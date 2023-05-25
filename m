Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7B7710C29
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240340AbjEYMb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241025AbjEYMbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:31:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB924E4F
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:31:18 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QRnRS02qWzYslp;
        Thu, 25 May 2023 20:29:07 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 20:31:15 +0800
Message-ID: <3de796ad-a570-090a-bd61-fa9ca0b2b4a7@huawei.com>
Date:   Thu, 25 May 2023 20:31:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
To:     "Gowans, James" <jgowans@amazon.com>,
        "maz@kernel.org" <maz@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "zouyipeng@huawei.com" <zouyipeng@huawei.com>,
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
 <86sfcfghqh.wl-maz@kernel.org>
 <605113d89cdf53ba1a5034bb15704da58a5336d7.camel@amazon.com>
From:   "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <605113d89cdf53ba1a5034bb15704da58a5336d7.camel@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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



在 2023/5/23 20:47, Gowans, James 写道:
> On Tue, 2023-05-02 at 11:17 +0100, Marc Zyngier wrote:
>>
>> Sorry for the delay, I've been travelling the past couple of weeks.
> 
> Me too - just getting back to this now. :-)
>>
>> On Tue, 02 May 2023 09:43:02 +0100,
>> "Gowans, James" <jgowans@amazon.com> wrote:
>>>
>>>> This will run check_irq_resend() on the *newly affined* CPU, while the old
>>>> one is still running the original handler. AFAICT what will happen is:
>>>> check_irq_resend
>>>>   try_retrigger
>>>>     irq_chip_retrigger_hierarchy
>>>>       its_irq_retrigger
>>>> ... which will cause the ITS to *immediately* re-trigger the IRQ. The
>>>> original CPU can still be running the handler in that case.
>>
>> Immediately is a relative thing. The GIC processes interrupts far
>> slower than the CPU can handle them.
> 
> Ack - I've tested with your patch below and empirically on my system it
> seems that a resend storm (running resend in a tight loop on the new CPU
> while the original one is still slowly running a handler) causes
> interrupts get delivered at period of about 40 µs. That is indeed less
> "immediately" than handlers *typically* take.
> 
>> Yes, this is clearly missing from my patch, thanks for pointing this
>> out. I think something like the hack below should handle it.
>>
>> diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
>> index 0c46e9fe3a89..5fa96842a882 100644
>> --- a/kernel/irq/resend.c
>> +++ b/kernel/irq/resend.c
>> @@ -117,7 +117,8 @@ int check_irq_resend(struct irq_desc *desc, bool inject)
>>                 return -EINVAL;
>>         }
>>
>> -       if (desc->istate & IRQS_REPLAY)
>> +       if ((desc->istate & IRQS_REPLAY) &&
>> +           !irqd_needs_resend_when_in_progress(&desc->irq_data))
>>                 return -EBUSY;

Post from my email in this thread:

"Second, I am concerned that repeatedly resending the interrupt could be harmful to
the current task running on the new CPU. When an interrupt is delivered, the task
will be interrupt and forced to save and restore it context, and CPU must switch
exception level. This can be a costly operation, especially for virtualization systems."

Fortunately, this problem is supposed to occur rarely. This means that the performance
degradation may not be so noticeable at the business level. However, I just wonder if
there is another way to handle this situation that does not involve tweaking IRQS_PENDING
or repeatedly resending the interrupt to the new CPU.

Thanks.

>>
>>         if (!(desc->istate & IRQS_PENDING) && !inject)
> 
> Have tested this and confirm it mitigates the issue.
> 
>> I really think that we want to move away from the old CPU asap.
>> Imagine the following case: we want to turn a CPU off, and for this we
>> need to migrate the interrupts away from it. But the source of the
>> interrupt is a guest which keeps the interrupt coming, and this could
>> at least in theory delay the offlining indefinitely.
> 
> Agreed - just note that whether we do the hardware-assisted
> irq_retrigger() before the handler on the newly affined CPU (as your patch
> does) or after the handler on the old CPU (as my original patch suggested)
> doesn't make a difference - either way the next actual handler run will
> happen on the newly affined CPU and we get off the old CPU for the next
> handler runs.
> 
> The only time is does make a difference is in the SW resend case but as
> you point out:
> 
>> With SW resend, the tasklet should get moved to CPUs that are still
>> online, and there may be some additional work to do here.
> 
>>> Just checking to see if you've had a chance to consider these
>>> issues/thoughts, and if/how they should be handled?
>>> I'm still tending towards saying that the check_irq_resend() should run
>>> after handle_irq_event() and the IRQS_PENDING flag should be wrangled to
>>> decide whether or not to resend.
>>
>> I still think this is the wrong approach. This mixes the pending and
>> replay states, which are significantly different in the IRQ code.
> 
> Okay, TBH I'm not too sure what the difference between these two flags is,
> the comments on the enum values isn't too detailed. I was inspired by
> handle_edge_irq() to use the IRQ_PENDING. Any idea why it's correct to use
> IRQ_PENDING there but not here? We could tweak this to use the REPLAY flag
> and use that to conditionally run check_irq_resend() after the handler.
> 
>> I definitely want to see more testing on this, but I'm not sure the SW
>> resend part is that critical. The issue at hand really is a GIC
>> specific problem.
> 
> Ack, I'm also happy to not bother with the SW resend case too much. Just
> cross-posting from your other email (unifying the threads):
> 
>> I contend that this really is a GICv3 architectural bug. The lack of
>> an active state on LPIs leads to it, and as far as I can tell, no
>> other interrupt architecture has the same issue. So the onus should be
>> on the GIC, the GIC only, and only the parts of the GIC that require
>> it (SPIs, PPIs and SGIs are fine, either because they have an active
>> state, or because the lock isn't dropped when calling the handler).
> 
> Again I'm happy to defer to you here. I'm still not sure why we wouldn't
> prefer to solve this in a way that *doesn't* need flags, and will just
> never run for interrupt controllers which are not impacted? That seems
> like we could have simpler code with no downside.
> 
> JG
> 

-- 
BR
Liao, Chang
