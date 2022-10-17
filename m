Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647E8600DA0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 13:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiJQLVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 07:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiJQLVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 07:21:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D815F123
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 04:21:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666005682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NwZndv+r/c65ODTpqsHYf2SNVrRCUFFbsjAWIg9kKY4=;
        b=Avu8o04AU2agPazv92IW7hNK5OL16hToBAA6+kuliXcr0jeSAa+vnvfWUvsQyluNSHfJ0+
        zpVOrOo9L52qjMeoPeuD8VH7pjZdTsMY39mi1YRSO+r1HHm3Dm/LDHBNAYXBTrjQH9czJZ
        7IMunqc5PvpryVXBZThrmfl3TTVn0XN38URBxZAr79joSjRKYmrAWCCeaj3IS6o0+cEhaP
        i7c8AWNHLsKWNfY0gbdwp7qhvlUNkAlRi3NcshGWdEAzQ278DtSAne6XaVI61qz0bk4IC2
        qrv3qSJ900OAWhHlufImz/Tf7ojGoabn20pK6w/nlarIP9oPiUWu5dr5zkK4Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666005682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NwZndv+r/c65ODTpqsHYf2SNVrRCUFFbsjAWIg9kKY4=;
        b=BGwiEI+y2tuUADNq47OpiRmlyv5FD7kidfoNo6JV7nnM6TopoeEx8+6Vwdidia04rB8Rqt
        CEKkAmqyDP9zWZAA==
To:     Zhang Xincheng <zhangxincheng@uniontech.com>, maz <maz@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        oleksandr <oleksandr@natalenko.name>,
        Hans de Goede <hdegoede@redhat.com>,
        bigeasy <bigeasy@linutronix.de>,
        "mark.rutland" <mark.rutland@arm.com>, michael <michael@walle.cc>
Subject: Re: [PATCH] interrupt: discover and disable very frequent interrupts
In-Reply-To: <tencent_3B90F136446E9125563169AF@qq.com>
References: <20220930064042.14564-1-zhangxincheng@uniontech.com>
 <86bkqx6wrd.wl-maz@kernel.org> <tencent_7C4E401B708789BC3A26F57C@qq.com>
 <868rm16tbu.wl-maz@kernel.org> <tencent_48EE20EE67D50AC81A28CAAF@qq.com>
 <87tu4dhhh2.wl-maz@kernel.org> <tencent_3B90F136446E9125563169AF@qq.com>
Date:   Mon, 17 Oct 2022 13:21:21 +0200
Message-ID: <8735bmr8zy.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09 2022 at 18:02, Zhang Xincheng wrote:
>  
> +config FREQUENT_IRQ_DEBUG
> +	bool "Support for finding and reporting frequent interrupt"
> +	default n
> +	help
> +

Pointless newline.

> +	  This is a mechanism to detect and report that interrupts
> +	  are triggered too frequently.
> +
> +config COUNT_PER_SECOND
> +	int "Interrupt limit per second"
> +	depends on FREQUENT_IRQ_DEBUG
> +	default "2000"
> +	help

2000 interrupts per second is just a hillarious low default. Trivial to
reach with networking. Aside of that on systems where the per CPU timer
interrupt goes through this code, that's trivial to exceed with
something simple like a periodic timer with a 250us interval.

> +#ifdef CONFIG_FREQUENT_IRQ_DEBUG
> +#define COUNT_PER_SECOND_MASK	0x0000ffff
> +#define DURATION_LIMIT_MASK		0xffff0000
> +#define DURATION_LIMIT_COUNT	0x00010000
> +#define DURATION_LIMIT_OFFSET	16
> +static unsigned int count_per_second = CONFIG_COUNT_PER_SECOND;
> +static unsigned int duration_limit = CONFIG_DURATION_LIMIT;
> +static bool disable_frequent_irq;
> +#endif /* CONFIG_FREQUENT_IRQ_DEBUG */
> +
>  /*
>   * We wait here for a poller to finish.
>   *
> @@ -189,18 +199,16 @@ static inline int bad_action_ret(irqreturn_t action_ret)
>   * (The other 100-of-100,000 interrupts may have been a correctly
>   *  functioning device sharing an IRQ with the failing one)
>   */
> -static void __report_bad_irq(struct irq_desc *desc, irqreturn_t action_ret)
> +static void __report_bad_irq(struct irq_desc *desc, irqreturn_t action_ret, const char *msg)
>  {
>  	unsigned int irq = irq_desc_get_irq(desc);
>  	struct irqaction *action;
>  	unsigned long flags;
>  
>  	if (bad_action_ret(action_ret)) {
> -		printk(KERN_ERR "irq event %d: bogus return value %x\n",
> -				irq, action_ret);
> +		printk(msg, irq, action_ret);

This wants to be pr_err() and that change needs to be split out into a
seperate patch if at all.

> +#ifdef CONFIG_FREQUENT_IRQ_DEBUG
> +/*
> + * Some bad hardware will trigger interrupts very frequently, which will
> + * cause the CPU to process hardware interrupts all the time. We found
> + * and reported it, and disabling it is optional.
> + */
> +void report_frequent_irq(struct irq_desc *desc, irqreturn_t action_ret)

static, no?

> +{
> +	if (desc->have_reported)
> +		return;
> +
> +	if ((desc->gap_count & DURATION_LIMIT_MASK) == 0)

What's the point of this mask dance here? Use seperate variables. This
is unreadable and overoptimized for no value.

Also why is a simple count per second not sufficient? Why do you need
the extra duration limit?

> +		desc->gap_time = get_jiffies_64();

Why does this need 64bit jiffies? 32bit are plenty enough.

> +
> +	desc->gap_count++;
> +
> +	if ((desc->gap_count & COUNT_PER_SECOND_MASK) >= count_per_second) {
> +		if ((get_jiffies_64() - desc->gap_time) < HZ) {
> +			desc->gap_count += DURATION_LIMIT_COUNT;
> +			desc->gap_count &= DURATION_LIMIT_MASK;
> +		} else {
> +			desc->gap_count = 0;
> +		}
> +
> +		if ((desc->gap_count >> DURATION_LIMIT_OFFSET) >= duration_limit) {
> +			__report_bad_irq(desc, action_ret, KERN_ERR "irq %d: triggered too "
> +					"frequently\n");
> +			desc->have_reported = true;
> +			if (disable_frequent_irq)
> +				irq_disable(desc);

How is this rate limiting? This is simply disabling the interrupt.

So again if your limit is too narrow you might simply disable the wrong
interrupt and render the machine useless.

So if enabled in Kconfig it must be default off and you need a command
line parameter to turn it on, but TBH I'm less than convinced that this
is actually useful for general purpose debugging in it's current form
simply because it is hard to get the limit right.

Thanks,

        tglx



