Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB574602025
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 03:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiJRBH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 21:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJRBHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 21:07:25 -0400
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE76BAF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 18:07:20 -0700 (PDT)
X-QQ-mid: bizesmtp75t1666055110tjnhfzdi
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 18 Oct 2022 09:05:09 +0800 (CST)
X-QQ-SSF: 01400000000000D0I000000A0000000
X-QQ-FEAT: RLrSOnjbvYEE4ixCvJiuWdQmDrSguY+tG0vCka7FbT//sYS2O3tpYI/hA9xeM
        GV7LH5Wt354nB9ufMQ4Fn6Fo00YIaX+nnZR4q2pLmMVyPo5AyU+4bz7Fp2yXqcLkkbAY32e
        dcJk6k2dEEzs7PVr7M6PNW30NvmzluEKwMvcMDq48fVugg28T9TaQpJ78LgmIYJQ/0db3hU
        RsV0nASA2YgZ8AecXLTGAPYXvQQ+1zUxMSyQoJOBI9kyP4LUtwrbNNXrjueXh5g/5QbaeUe
        sYt8gzXOwgvKROhrzKPmuPNm1FZu95DFPFWlt27yPZ1AXdKj59i3ba8YfbfzgNvh4gBTKBx
        S0GOrxtKA0uSa3EeOR9VekAGDK3Aqgpr8dtWdtrmjO4vnn2LYRk1mO8X8vCsfZzrAKxb7cy
        ORjEBic49ac=
X-QQ-GoodBg: 1
From:   Zhang Xincheng <zhangxincheng@uniontech.com>
To:     tglx@linutronix.de
Cc:     bigeasy@linutronix.de, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com, maz@kernel.org,
        michael@walle.cc, oleksandr@natalenko.name,
        zhangxincheng@uniontech.com
Subject: Re: [PATCH] interrupt: discover and disable very frequent interrupts
Date:   Tue, 18 Oct 2022 09:05:09 +0800
Message-Id: <20221018010509.7474-1-zhangxincheng@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <8735bmr8zy.ffs@tglx>
References: <8735bmr8zy.ffs@tglx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > +config FREQUENT_IRQ_DEBUG
> > + bool "Support for finding and reporting frequent interrupt"
> > + default n
> > + help
> > +
> 
> Pointless newline.
> 

Thank you very much for your advice, I get it.

> > +   This is a mechanism to detect and report that interrupts
> > +   are triggered too frequently.
> > +
> > +config COUNT_PER_SECOND
> > + int "Interrupt limit per second"
> > + depends on FREQUENT_IRQ_DEBUG
> > + default "2000"
> > + help
> 
> 2000 interrupts per second is just a hillarious low default. Trivial to
> reach with networking. Aside of that on systems where the per CPU timer
> interrupt goes through this code, that's trivial to exceed with
> something simple like a periodic timer with a 250us interval.
> 

This limit is really too low on some high-performance PCs, and I neglected.

> > +#ifdef CONFIG_FREQUENT_IRQ_DEBUG
> > +#define COUNT_PER_SECOND_MASK 0x0000ffff
> > +#define DURATION_LIMIT_MASK 0xffff0000
> > +#define DURATION_LIMIT_COUNT 0x00010000
> > +#define DURATION_LIMIT_OFFSET 16
> > +static unsigned int count_per_second = CONFIG_COUNT_PER_SECOND;
> > +static unsigned int duration_limit = CONFIG_DURATION_LIMIT;
> > +static bool disable_frequent_irq;
> > +#endif /* CONFIG_FREQUENT_IRQ_DEBUG */
> > +
> >  /*
> >   * We wait here for a poller to finish.
> >   *
> > @@ -189,18 +199,16 @@ static inline int bad_action_ret(irqreturn_t action_ret)
> >   * (The other 100-of-100,000 interrupts may have been a correctly
> >   *  functioning device sharing an IRQ with the failing one)
> >   */
> > -static void __report_bad_irq(struct irq_desc *desc, irqreturn_t action_ret)
> > +static void __report_bad_irq(struct irq_desc *desc, irqreturn_t action_ret, const char *msg)
> >  {
> >  unsigned int irq = irq_desc_get_irq(desc);
> >  struct irqaction *action;
> >  unsigned long flags;
> > 
> >  if (bad_action_ret(action_ret)) {
> > - printk(KERN_ERR "irq event %d: bogus return value %x\n",
> > - irq, action_ret);
> > + printk(msg, irq, action_ret);
> 
> This wants to be pr_err() and that change needs to be split out into a
> seperate patch if at all.
> 

This is a good suggestion, I get it.

> > +#ifdef CONFIG_FREQUENT_IRQ_DEBUG
> > +/*
> > + * Some bad hardware will trigger interrupts very frequently, which will
> > + * cause the CPU to process hardware interrupts all the time. We found
> > + * and reported it, and disabling it is optional.
> > + */
> > +void report_frequent_irq(struct irq_desc *desc, irqreturn_t action_ret)
> 
> static, no?
> 

Yes, indeed it should be static.

> > +{
> > + if (desc->have_reported)
> > + return;
> > +
> > + if ((desc->gap_count & DURATION_LIMIT_MASK) == 0)
> 
> What's the point of this mask dance here? Use seperate variables. This
> is unreadable and overoptimized for no value.
> 

This mask is probably not really needed.

> Also why is a simple count per second not sufficient? Why do you need
> the extra duration limit?
> 

The extra duration limit is is increased to ignore transient conditions.

> > + desc->gap_time = get_jiffies_64();
> 
> Why does this need 64bit jiffies? 32bit are plenty enough.
> 

Yes,32bit are plenty enough.

> > +
> > + desc->gap_count++;
> > +
> > + if ((desc->gap_count & COUNT_PER_SECOND_MASK) >= count_per_second) {
> > + if ((get_jiffies_64() - desc->gap_time) < HZ) {
> > + desc->gap_count += DURATION_LIMIT_COUNT;
> > + desc->gap_count &= DURATION_LIMIT_MASK;
> > + } else {
> > + desc->gap_count = 0;
> > + }
> > +
> > + if ((desc->gap_count >> DURATION_LIMIT_OFFSET) >= duration_limit) {
> > + __report_bad_irq(desc, action_ret, KERN_ERR "irq %d: triggered too "
> > + "frequently\n");
> > + desc->have_reported = true;
> > + if (disable_frequent_irq)
> > + irq_disable(desc);
> 
> How is this rate limiting? This is simply disabling the interrupt.
> 

This does not limit the frequency of an interrupt, it just reports an
interrupt that is triggered very frequently and may not be normal.
As for how the administrator will deal with this in the future, it is
up to the administrator.

> 
> So again if your limit is too narrow you might simply disable the wrong
> interrupt and render the machine useless.
> 
> So if enabled in Kconfig it must be default off and you need a command
> line parameter to turn it on, but TBH I'm less than convinced that this
> is actually useful for general purpose debugging in it's current form
> simply because it is hard to get the limit right.
> 

At present, this mechanism needs to artificially give a suitable limit,
which is really not very easy to use. But it's really hard to automatically
get a suitable limit for different machines, and I need to reconsider.


Thanks,

        Zhang Xincheng
