Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB526E7170
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjDSDIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 23:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjDSDIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:08:30 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBFA6A66
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 20:08:24 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [7.185.36.25])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Q1Qcl0RLGznclq;
        Wed, 19 Apr 2023 11:04:39 +0800 (CST)
Received: from [10.67.111.115] (10.67.111.115) by
 dggpemm500016.china.huawei.com (7.185.36.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 19 Apr 2023 11:08:22 +0800
Message-ID: <1debb39d-63a3-9e2f-5efa-7852af1ffa42@huawei.com>
Date:   Wed, 19 Apr 2023 11:08:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
From:   Yipeng Zou <zouyipeng@huawei.com>
Subject: Re: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
To:     "Gowans, James" <jgowans@amazon.com>,
        "maz@kernel.org" <maz@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
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
Content-Language: en-US
In-Reply-To: <7fdfb01590d8e502f384aa0bb0dc9c614caa5dfc.camel@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.115]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/4/18 18:56, Gowans, James 写道:
> On Wed, 2023-04-12 at 14:32 +0100, Marc Zyngier wrote:
>>>>> 1. Do we need to mask the IRQ and then unmask it later? I don't think so
>>>>> but it's not entirely clear why handle_edge_irq does this anyway; it's
>>>>> an edge IRQ so not sure why it needs to be masked.
>>>> Please measure that cost and weep, specially in the context of
>>>> multiple concurrent interrupts serviced by a single ITS (cost of
>>>> locking the command queue, of waiting for a full round trip to the ITS
>>>> for a couple of commands...).
>>> Fortunately this mask/unmasking would only happen in the rare(ish) cased of the
>>> race condition described here being hit. Exactly the same as
>>> with handle_edge_irq(), the masking and later unmasking would only be done
>>> when irq_may_run() == false due to the race being hit. Considering that this is
>>> a rare occurrence, I think we could stomach the occasional overhead? I was more
>>> asking if it's actually *necessary* to do this masking/unmasking. I'm not sure
>>> it's necessary anyway, hence it wasn't implemented in my patch.
>> But does it solve anything? At the point where you mask the interrupt,
>> you already have consumed it. You'd still need to make it pending
>> somehow, which is what your patch somehow.
> I don't really know - the reason I asked the question is that the related
> handle_edge_irq() does this mask/unmasking, and I wasn't quite sure why it
> did that and hence if we needed to do something similar.
> Anyway, let's focus on your patch rather - I think it's more compelling.
>
>
>>> Yes. This bothered me too initially, but on reflection I'm not sure it's
>>> actually a problem. One possible issue that came to mind was around CPU
>>> offlining, but in the event that a CPU being offlined was running interrupt
>>> handlers it wouldn't be able to complete the offline anyway until the handlers
>>> were finished, so I don't think this is an issue. Do you see any practical issue
>>> with running the handler once more on the original CPU immediately after the
>>> affinity has been changed?
>> My take on this is that we put the pressure on the CPU we want to move
>> away from. I'd rather we put the it on the GIC itself, and use its
>> Turing-complete powers to force it to redeliver the interrupt at a
>> more convenient time.
> This idea and implementation looks and works great! It may need a few
> tweaks; discussing below.
>
>> >From c96d2ab37fe273724f1264fba5f4913259875d56 Mon Sep 17 00:00:00 2001
>> From: Marc Zyngier<maz@kernel.org>
>> Date: Mon, 10 Apr 2023 10:56:32 +0100
>> Subject: [PATCH] irqchip/gicv3-its: Force resend of LPIs taken while
>> already
>>   in-progress
> Perhaps you can pillage some of my commit message to explain the race here
> when you send this patch?
>> Signed-off-by: Marc Zyngier<maz@kernel.org>
>>
>> diff --git a/include/linux/irq.h b/include/linux/irq.h
>> index b1b28affb32a..4b2a7cc96eb2 100644
>> --- a/include/linux/irq.h
>> +++ b/include/linux/irq.h
>> @@ -223,6 +223,8 @@ struct irq_data {
>>    *                               irq_chip::irq_set_affinity() when
>> deactivated.
>>    * IRQD_IRQ_ENABLED_ON_SUSPEND - Interrupt is enabled on suspend by irq
>> pm if
>>    *                               irqchip have flag
>> IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND set.
>> + * IRQD_RESEND_WHEN_IN_PROGRESS - Interrupt may fire when already in
>> progress,
>> + *                               needs resending.
>>    */
>>   enum {
>>          IRQD_TRIGGER_MASK               = 0xf,
>> @@ -249,6 +251,7 @@ enum {
>>          IRQD_HANDLE_ENFORCE_IRQCTX      = (1 << 28),
>>          IRQD_AFFINITY_ON_ACTIVATE       = (1 << 29),
>>          IRQD_IRQ_ENABLED_ON_SUSPEND     = (1 << 30),
>> +       IRQD_RESEND_WHEN_IN_PROGRESS    = (1 << 31),
>>   };
> Do we really want a new flag here? I'd be keen to fix this race for all
> drivers, not just those who know to set this flag. I think the patch
> you're suggesting is pretty close to being safe to enable generally? If so
> my preference is for one less config option - just run it always.
>
>>   static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
>> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>> index 49e7bc871fec..73546ba8bc43 100644
>> --- a/kernel/irq/chip.c
>> +++ b/kernel/irq/chip.c
>> @@ -692,8 +692,11 @@ void handle_fasteoi_irq(struct irq_desc *desc)
>>
>>          raw_spin_lock(&desc->lock);
>>
>> -       if (!irq_may_run(desc))
>> +       if (!irq_may_run(desc)) {
>> +               if (irqd_needs_resend_when_in_progress(&desc->irq_data))
>> +                       check_irq_resend(desc, true);
>>                  goto out;
>> +       }
> This will run check_irq_resend() on the *newly affined* CPU, while the old
> one is still running the original handler. AFAICT what will happen is:
> check_irq_resend
>    try_retrigger
>      irq_chip_retrigger_hierarchy
>        its_irq_retrigger
> ... which will cause the ITS to *immediately* re-trigger the IRQ. The
> original CPU can still be running the handler in that case.
>
> If that happens, consider what will happen in check_irq_resend:
> - first IRQ comes in, successflly runs try_retrigger and sets IRQS_REPLAY.
> - it is *immediately* retriggered by ITS, and because the original handler
> on the other CPU is still running, comes into check_irq_resend again.
> - check_irq_resend now observes that IRQS_REPLAY is set and early outs.
> - No more resends, the IRQ is still lost. :-(
>
> Now I admit the failure mode is getting a bit pathological: two re-
> triggers while the original handler is still running, but I was able to
> hit this on my test machine by intentionally slowing
> the handler down by a few dozen micros. Should we cater for this?
>
> I can see two possibilities:
> - tweak check_irq_resend() to not early-out in this case but to keep re-
> triggering until it eventually runs.
> - move the check_irq_resend to only happen later, *after* the original
> handler has finished running. This would be very similar to what I
> suggested in my original patch, except instead of running a do/while loop,
> the code would observe that the pending flag was set again and run
> check_irq_resend.
>
> I'm also wondering what will happen for users who don't have the
> chip->irq_retrigger callback set and fall back to the tasklet
> via irq_sw_resend()... Looks like it will work fine. However if we do my
> suggestion and move check_irq_resend to the end of handle_fasteoi_irq then
> the tasklet will be scheduled on the old CPU again, which may be sub-
> optimal.
>
> JG

Hi James:

     This does have a problem, and I didn't hit this on my test machine 
because my interrupt

handling would be ended quickly. But this scenario really should be 
considered.

     However, if the check_irq_resend is executed in the end of the 
handle_fasteoi_irq, a flag

is needed to identify it. Same as the original IRQS_PENDING function.

     It's just that the do/while loop in our original patch is replaced 
with check_irq_resend.

     As for the irq_sw_resend that will be followed without implementing 
chip->irq_retrigger,

I think maybe there will be another problem here: interrupt response 
latency.

     If an irq_sw_resend is used to trigger a new interrupt, the delay 
of this interrupt response

is uncertain (tasklet scheduling, etc.), which is important for some 
devices with low latency

requirements There may also be an impact.

-- 
Regards,
Yipeng Zou

