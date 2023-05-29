Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D464F714224
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 04:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjE2CrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 22:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjE2CrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 22:47:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D327BB
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 19:47:17 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QV0L42QwbzTklk;
        Mon, 29 May 2023 10:47:08 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 29 May 2023 10:47:14 +0800
Message-ID: <516b8316-fba9-f3d9-2b3a-2536bd747a69@huawei.com>
Date:   Mon, 29 May 2023 10:47:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
To:     "Gowans, James" <jgowans@amazon.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "zouyipeng@huawei.com" <zouyipeng@huawei.com>,
        "Raslan, KarimAllah" <karahmed@amazon.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sironi, Filippo" <sironi@amazon.de>,
        "chris.zjh@huawei.com" <chris.zjh@huawei.com>
References: <20230317095300.4076497-1-jgowans@amazon.com>
 <87h6tp5lkt.wl-maz@kernel.org>
 <0869847124f982c50d0f8d0ede996004f90a5576.camel@amazon.com>
 <86pm89kyyt.wl-maz@kernel.org>
 <7fdfb01590d8e502f384aa0bb0dc9c614caa5dfc.camel@amazon.com>
 <5a1fb95b57efbd6b6c2cea4a4e3ae5407fadeeb9.camel@amazon.com>
 <91902b8c-c854-c498-e5d0-2d959bd08637@huawei.com>
 <7de1c7f0c9ff4a84b3cc3fa15ee39596c08b665f.camel@amazon.com>
From:   "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <7de1c7f0c9ff4a84b3cc3fa15ee39596c08b665f.camel@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, James.

在 2023/5/25 18:04, Gowans, James 写道:
> On Tue, 2023-05-23 at 11:16 +0800, liaochang (A) wrote:
>> Hi, James and Marc,
>>
>> After studying your discussions, I list some requirements need to satify for
>> the final practical solution:
>>
>> 1. Use the GIC to maintain the unhandled LPI.
>> 2. Do not change the semantics of set_irq_affinity, which means that the interrupt
>>    action must be performed on the new CPU when the next interrupt occurs after a
>>    successful set_irq_affinity operation.
>> 3. Minimize the cost, especially to other tasks running on CPUs, which means avoid
>>    a do/while loop on the original CPU and repeatedly resend interrupt on the new CPU.
> 
> Seems reasonable to me.
>>
>> Based on these requirements and Linux v6.3 rev, I propose the following hack:
>>
>> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>> index 49e7bc871fec..1b49518b19bd 100644
>> --- a/kernel/irq/chip.c
>> +++ b/kernel/irq/chip.c
>> @@ -692,8 +692,14 @@ void handle_fasteoi_irq(struct irq_desc *desc)
>>
>>         raw_spin_lock(&desc->lock);
>>
>> -       if (!irq_may_run(desc))
>> +       /*
>> +        * Ack another interrupt from the same source can occurs on new
>> +        * CPU even before the first one is handled on original CPU.
>> +        */
>> +       if (!irq_may_run(desc)) {
>> +               desc->istate |= IRQS_PENDING;
>>                 goto out;
>> +       }
> 
> Wording may need a slight tweak, especially pointing out why PENDING is
> set.

Sure, see the comment below:

"Ack another interrupt from the same source can occurs on new CPU even before
the first one is handled on original CPU, IRQS_PENDING bit can be reused to
indicate this situation, which will defer the execution of the interrupt handler
function associated with the irq_desc until the first interrupt handler returns."

In summary, the IRQ_PENDINGS ensures that only one interrupt handler is ever
running for a particular source at a time, and the major usages of IRQS_PENDING
in kernel as follows:

1. Used in irq flow handler to indicate that an acknowledged interrupt cannot be
handled immediately due to three different reasons:
- Case1: the interrupt handler function has been unregistered via free_irq().
- Case2: the interrupt has been disabled via irq_disable().
- Case3: the interrupt is an edge-triggered interrupt and its handler is already
         running on the CPU.

In any of these cases, the kernel will defer the execution of the interrupt handler
until the interrupt is enabled and new handler is established again via check_irq_resend(),
or via the inside loop in handle_edge_irq() upon the previous handler returns.

2. Used in the spurious interrupt detector, a few systems with misdescribed IRQ
routing can cause an interrupt to be handled on the wrong CPU. In this situation,
the spurious interrupt detector searches for a recovery handler for the interrupt.
If the found handler is running on another CPU, the spurious interrupt detector
also defers the execution of the recovery handler, similar to case 3 in #1.

I hope this is helpful.

>>
>>         desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
>>
>> @@ -715,6 +721,8 @@ void handle_fasteoi_irq(struct irq_desc *desc)
>>
>>         cond_unmask_eoi_irq(desc, chip);
>>
>> +       check_irq_resend(desc, true);
>> +
> 
> I'm pretty sure the second param, "inject", must not be true. As is this
> will *always* resend the interrupt after every interrupt. Infinite
> interrupt loop! (did you test this?)
> I've changed it to false and tested, seems good to me.

Sorry, This code is a very trivial prototype and has not yet been tested.
You are correct that the "inject" parameter should be set to false, otherwise
the IRQS_PENDING check in check_irq_resend() will be skipped. Thank you for
pointing out my mistake.

> 
> I'd suggest adding a comment here which pairs with the comment above
> explaining why this is being called here. Also perhaps adding:
> if (unlikely((desc->istate & IRQS_PENDING))
> ...so that in general this function call will be skipped over.

Agree.

> 
> If you want I'm happy to make these tweaks and post as V2?
> There are also some other comments I'm keen to add to the flag enums to
> make it a bit clearer what some of the flags mean.

Don't see why not :)

Thanks.

> 
> Marc, what are your thoughts on this approach?
> The main (only?) downside I see compared to your suggestion is that in the
> irq_sw_resend() case the tasklet will be scheduled on the original CPU. As
> you mentioned in a previous reply, perhaps we shouldn't bother thinking
> about the sw_resend case now as only GIC is impacted. In future if
> necessary the sw_resend implementation could be tweaked to schedule the
> tasklet on the CPU which the interrupt is affined to.
> 
> JG
> 
>>         raw_spin_unlock(&desc->lock);
>>         return;
>>  out:
>>
>> Looking forward to your feedbacks, thanks.

-- 
BR
Liao, Chang
