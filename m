Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287585F0576
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 09:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiI3HFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 03:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiI3HF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 03:05:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFF195AB
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 00:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664521521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fb2JReozfv54MtUy+eBVpC/u0BQPPExT4P3ErcpkW/k=;
        b=GHoiFFIRMBI204PNnY3r2GjFshh8tPI1X62tK9XevnD/1j63MF9swoKFC9MdUfYM63C+/T
        OgarfUCpXeBjCNlhh2S0E7MvwfZYLsIGvG3R4xCMuDrxgTio3riFU62oyKEyMdKN4nkbm3
        QtcrIk5j6GsdeZ0nFaRvlvkD5/jziRU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-484-SOsjIWjwNBG5w1v4ErvkxQ-1; Fri, 30 Sep 2022 03:05:20 -0400
X-MC-Unique: SOsjIWjwNBG5w1v4ErvkxQ-1
Received: by mail-ed1-f72.google.com with SMTP id t13-20020a056402524d00b00452c6289448so2967894edd.17
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 00:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Fb2JReozfv54MtUy+eBVpC/u0BQPPExT4P3ErcpkW/k=;
        b=uRDYFEi2Vp/XW86WzyX6PlNvBS0XSh8T4ErPfqmBpy3aywHq/7ZJfkXxfRxv5BMFJQ
         LVqa/0yCPbpMaOvvOR79lJ8J16nKdaSx/wFYzxJFaxgsg5kU3ovQsB5fZq2+Bpwz74FT
         ViK9FzK6TUJ33tvPgY+hB3JH3xzlJzyNxSmNq+hJqXA8UX1QF/vxwHYSa9Y2xwkngsaf
         SpeXul6iZim88aRbVTvGKwniewmMSfXwa7QihgogkSvR3gvQuUF52FEbg8D1IdcVjky2
         /qRbb7LxEkgy2utlEGAap0+N/FTAcT7dsZ9Wyu7zR/QCb5xAelGnWgYBhVcNqfT6lIqh
         LzdA==
X-Gm-Message-State: ACrzQf3GkDIwdvgymubcvhEASC45Citq/PIr6tN4ab5fnz9crSUmRsF7
        Ey7mBV8oi437VLkjQiw5ZBOEzwOtZPajktjXE3jr24AjW+84uSHo7XBxnrnuiCLGILLWFpMM9aw
        ApUq7LNEIRU0b2iQKNfsRPpg5
X-Received: by 2002:a05:6402:4511:b0:43b:a182:8a0a with SMTP id ez17-20020a056402451100b0043ba1828a0amr6689231edb.410.1664521519063;
        Fri, 30 Sep 2022 00:05:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4p2VCZOoUx2ooLanffpnmAV6GX1zUfkAoiYJ01WnT/11EmYZTezxUREXE/g8iFyqxJoAp2oA==
X-Received: by 2002:a05:6402:4511:b0:43b:a182:8a0a with SMTP id ez17-20020a056402451100b0043ba1828a0amr6689216edb.410.1664521518779;
        Fri, 30 Sep 2022 00:05:18 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id kx2-20020a170907774200b00781b589a1afsm708638ejc.159.2022.09.30.00.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 00:05:16 -0700 (PDT)
Message-ID: <25e02043-257d-be82-b562-89ab896ab555@redhat.com>
Date:   Fri, 30 Sep 2022 09:05:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] interrupt: discover and disable very frequent interrupts
To:     Zhang Xincheng <zhangxincheng@uniontech.com>, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org,
        oleksandr@natalenko.name, bigeasy@linutronix.de,
        mark.rutland@arm.com, michael@walle.cc
References: <20220930064042.14564-1-zhangxincheng@uniontech.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220930064042.14564-1-zhangxincheng@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/30/22 08:40, Zhang Xincheng wrote:
> From: zhangxincheng <zhangxincheng@uniontech.com>
> 
> In some cases, a peripheral's interrupt will be triggered frequently,
> which will keep the CPU processing the interrupt and eventually cause
> the RCU to report rcu_sched self-detected stall on the CPU.
> 
> [  838.131628] rcu: INFO: rcu_sched self-detected stall on CPU
> [  838.137189] rcu:     0-....: (194839 ticks this GP) idle=f02/1/0x4000000000000004
> softirq=9993/9993 fqs=97428
> [  838.146912] rcu:      (t=195015 jiffies g=6773 q=0)
> [  838.151516] Task dump for CPU 0:
> [  838.154730] systemd-sleep   R  running task        0  3445      1 0x0000000a
> 
> Signed-off-by: zhangxincheng <zhangxincheng@uniontech.com>
> Change-Id: I9c92146f2772eae383c16c8c10de028b91e07150
> Signed-off-by: zhangxincheng <zhangxincheng@uniontech.com>
> ---
>  include/linux/irqdesc.h |  2 ++
>  kernel/irq/spurious.c   | 52 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
> index 1cd4e36890fb..a3bd521c3557 100644
> --- a/include/linux/irqdesc.h
> +++ b/include/linux/irqdesc.h
> @@ -102,6 +102,8 @@ struct irq_desc {
>  	int			parent_irq;
>  	struct module		*owner;
>  	const char		*name;
> +	u32 gap_count;
> +	u64 gap_time;
>  } ____cacheline_internodealigned_in_smp;
>  
>  #ifdef CONFIG_SPARSE_IRQ
> diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
> index 02b2daf07441..b7162a10d92c 100644
> --- a/kernel/irq/spurious.c
> +++ b/kernel/irq/spurious.c
> @@ -222,6 +222,38 @@ static void __report_bad_irq(struct irq_desc *desc, irqreturn_t action_ret)
>  	raw_spin_unlock_irqrestore(&desc->lock, flags);
>  }
>  
> +/*
> + * Some bad hardware will trigger interrupts very frequently, which will
> + * cause the CPU to process hardware interrupts all the time. So when
> + * we find this out, the interrupt should be disabled.
> + */
> +static void __report_so_frequently_irq(struct irq_desc *desc, irqreturn_t action_ret)
> +{
> +	unsigned int irq = irq_desc_get_irq(desc);
> +	struct irqaction *action;
> +	unsigned long flags;
> +
> +	printk(KERN_ERR "irq %d: triggered too frequently\n",irq);
> +	dump_stack();
> +	printk(KERN_ERR "handlers:\n");
> +
> +	/*
> +	 * We need to take desc->lock here. note_interrupt() is called
> +	 * w/o desc->lock held, but IRQ_PROGRESS set. We might race
> +	 * with something else removing an action. It's ok to take
> +	 * desc->lock here. See synchronize_irq().
> +	 */
> +	raw_spin_lock_irqsave(&desc->lock, flags);
> +	for_each_action_of_desc(desc, action) {
> +		printk(KERN_ERR "[<%p>] %pf", action->handler, action->handler);
> +		if (action->thread_fn)
> +			printk(KERN_CONT " threaded [<%p>] %pf",
> +					action->thread_fn, action->thread_fn);
> +		printk(KERN_CONT "\n");
> +	}
> +	raw_spin_unlock_irqrestore(&desc->lock, flags);
> +}
> +

This is basically a copy of __report_bad_irq() please instead just give
__report_bad_irq() a "const char *msg" argument and drop this copy.

Note __report_bad_irq() is currently called twice, once from
report_bad_irq() and in that case "if (bad_action_ret(action_ret))" is
always true, so inside report_bad_irq() you will now want to use:

	__report_bad_irq(desc, action_ret, KERN_ERR "irq event %d: bogus return value %x\n");

And then there is a second call in note_interrupt() in which case
"if (bad_action_ret(action_ret))" is always false so there you
will want to use:

	__report_bad_irq(desc, action_ret, KERN_ERR "irq %d: nobody cared (try booting with the \"irqpoll\" option)\n");

And then in __report_bad_irq() itself replace the if with 2 printk() calls with:

	if (bad_action_ret(action_ret))
		printk(msg, irq, action_ret);
	else
		printk(msg, irq);

Note the if is still necessary so that if any of this gets inlined
(I sure hope not ...) that the argument count then is correct and
we don't get the compiler warning about the number of arguments
not matching the format-string.

And then replace your __report_so_frequently_irq() call with:

	__report_bad_irq(desc, action_ret, KERN_ERR "irq %d: triggered too frequently\n");

	


>  static void report_bad_irq(struct irq_desc *desc, irqreturn_t action_ret)
>  {
>  	static int count = 100;
> @@ -273,6 +305,26 @@ void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret)
>  {
>  	unsigned int irq;
>  
> +	if((desc->gap_count & 0xffff0000) == 0)
> +		desc->gap_time = get_jiffies_64();
> +
> +	desc->gap_count ++;
> +
> +	if((desc->gap_count & 0x0000ffff) >= 2000) {
> +		if((get_jiffies_64() - desc->gap_time) < HZ) {
> +			desc->gap_count += 0x00010000;
> +			desc->gap_count &= 0xffff0000;
> +		} else {
> +			desc->gap_count = 0;
> +		}
> +
> +		if((desc->gap_count >> 16) > 30) {
> +			__report_so_frequently_irq(desc, action_ret);
> +			irq_disable(desc);
> +		}
> +	}
> +
> +

I believe this should be moved to below this block:

        if (bad_action_ret(action_ret)) {
                report_bad_irq(desc, action_ret);
                return;
        }

Since we don't want this check when polling and we want to keep
using / prefer the existing handling for bad interrupt return
values.

>  	if (desc->istate & IRQS_POLL_INPROGRESS ||
>  	    irq_settings_is_polled(desc))
>  		return;



Please note I'm in no way an expert on the interrupt subsystem, so 
I have no idea if this patch is a good idea in general. I just noticed
the code duplication which is why I did a partial review of this patch.

Regards,

Hans

