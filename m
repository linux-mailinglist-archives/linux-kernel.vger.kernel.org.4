Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B08270D242
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjEWDQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjEWDQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 23:16:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061A0B6
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 20:16:09 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QQKBv4dZlzLpvl;
        Tue, 23 May 2023 11:13:11 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 11:16:06 +0800
Message-ID: <91902b8c-c854-c498-e5d0-2d959bd08637@huawei.com>
Date:   Tue, 23 May 2023 11:16:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
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
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <5a1fb95b57efbd6b6c2cea4a4e3ae5407fadeeb9.camel@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/2 16:43, Gowans, James 写道:
> Hi Marc and Thomas,
> 
> On Tue, 2023-04-18 at 12:56 +0200, James Gowans wrote:
>>>   static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
>>> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>>> index 49e7bc871fec..73546ba8bc43 100644
>>> --- a/kernel/irq/chip.c
>>> +++ b/kernel/irq/chip.c
>>> @@ -692,8 +692,11 @@ void handle_fasteoi_irq(struct irq_desc *desc)
>>>          raw_spin_lock(&desc->lock);
>>> -       if (!irq_may_run(desc))
>>> +       if (!irq_may_run(desc)) {
>>> +               if (irqd_needs_resend_when_in_progress(&desc->irq_data))
>>> +                       check_irq_resend(desc, true);
>>>                  goto out;
>>> +       }
>>
>>
>> This will run check_irq_resend() on the *newly affined* CPU, while the old
>> one is still running the original handler. AFAICT what will happen is:
>> check_irq_resend
>>   try_retrigger
>>     irq_chip_retrigger_hierarchy
>>       its_irq_retrigger
>> ... which will cause the ITS to *immediately* re-trigger the IRQ. The
>> original CPU can still be running the handler in that case.
>>
>> If that happens, consider what will happen in check_irq_resend:
>> - first IRQ comes in, successflly runs try_retrigger and sets IRQS_REPLAY.
>> - it is *immediately* retriggered by ITS, and because the original handler
>> on the other CPU is still running, comes into check_irq_resend again.
>> - check_irq_resend now observes that IRQS_REPLAY is set and early outs.
>> - No more resends, the IRQ is still lost. :-(
>>
>> Now I admit the failure mode is getting a bit pathological: two re-
>> triggers while the original handler is still running, but I was able to
>> hit this on my test machine by intentionally slowing
>> the handler down by a few dozen micros. Should we cater for this?
>>
>> I can see two possibilities:
>> - tweak check_irq_resend() to not early-out in this case but to keep re-
>> triggering until it eventually runs.
>> - move the check_irq_resend to only happen later, *after* the original
>> handler has finished running. This would be very similar to what I
>> suggested in my original patch, except instead of running a do/while loop,
>> the code would observe that the pending flag was set again and run
>> check_irq_resend.

Hi, James and Marc,

After studying your discussions, I list some requirements need to satify for
the final practical solution:

1. Use the GIC to maintain the unhandled LPI.
2. Do not change the semantics of set_irq_affinity, which means that the interrupt
   action must be performed on the new CPU when the next interrupt occurs after a
   successful set_irq_affinity operation.
3. Minimize the cost, especially to other tasks running on CPUs, which means avoid
   a do/while loop on the original CPU and repeatedly resend interrupt on the new CPU.

Based on these requirements and Linux v6.3 rev, I propose the following hack:

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 49e7bc871fec..1b49518b19bd 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -692,8 +692,14 @@ void handle_fasteoi_irq(struct irq_desc *desc)

 	raw_spin_lock(&desc->lock);

-	if (!irq_may_run(desc))
+	/*
+	 * Ack another interrupt from the same source can occurs on new
+	 * CPU even before the first one is handled on original CPU.
+	 */
+	if (!irq_may_run(desc)) {
+		desc->istate |= IRQS_PENDING;
 		goto out;
+	}

 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);

@@ -715,6 +721,8 @@ void handle_fasteoi_irq(struct irq_desc *desc)

 	cond_unmask_eoi_irq(desc, chip);

+	check_irq_resend(desc, true);
+
 	raw_spin_unlock(&desc->lock);
 	return;
 out:

Looking forward to your feedbacks, thanks.

>>
>> I'm also wondering what will happen for users who don't have the
>> chip->irq_retrigger callback set and fall back to the tasklet
>> via irq_sw_resend()... Looks like it will work fine. However if we do my
>> suggestion and move check_irq_resend to the end of handle_fasteoi_irq then
>> the tasklet will be scheduled on the old CPU again, which may be sub-
>> optimal.
> 
> Just checking to see if you've had a chance to consider these
> issues/thoughts, and if/how they should be handled?
> I'm still tending towards saying that the check_irq_resend() should run
> after handle_irq_event() and the IRQS_PENDING flag should be wrangled to
> decide whether or not to resend.
> 
> I just don't know if having the tasklet scheduled and run on the original
> CPU via irq_sw_resend() would be problematic or not. In general it
> probably won't but in the CPU offlining case.... maybe? I realise that for
> GIC-v3 the tasklet won't be used because GIC has chip->irq_retrigger
> callback defined - I'm just thinking in general here, especially so
> assuming we drop the new IRQD_RESEND_WHEN_IN_PROGRESS flag).
> 
> Thoughts?
> 
> I can put together a PoC and test it along with Yipeng from Huawei if you
> think it sounds reasonable.
> 
> JG
