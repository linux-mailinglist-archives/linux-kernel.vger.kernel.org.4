Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAF06474E5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 18:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiLHRPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 12:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiLHRPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 12:15:08 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB76866CB3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 09:15:07 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id pp21so572939qvb.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 09:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aZ2+sw7FJ1Ulfb1t917ioZfA1huDsXUFceAu5sO5xnw=;
        b=bCHRRbsERHtOUuyy6wIDtyQHTChr2kZncVci9Dp3KH0sO44r/l+X15TqDlja9O9vp9
         CgMdoRud+jBvaMmZAZWXDbNyl4ZdkKpP0bPUnBg+2jx+rHR8Ldeb//I4FvH6HyEdIXUS
         mr8W8PN+c9O0Jr720PNJnzi79Kx1bATy+IwQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZ2+sw7FJ1Ulfb1t917ioZfA1huDsXUFceAu5sO5xnw=;
        b=tXQfgwbDfkJXY5PhIrdZY2E4NnWvNDaWH8Rnrd/LBjaegyXyVtrmjipvVBjk5XLrBo
         qdRpa1skzyUdocaLhdxU2FnuzQzupCaVva01wUpxpnBgTGpjKV68kWwfa1RoFaX8nASY
         D/HSArnJPoc2sbNh8hTBgapxl7lxZfkyo4L2/4rwrQaD9POVbhroI1izIsDGejXsg1HZ
         stPSMxN0YeyZNSl89/t/1Mtr/NXjYyqHfC3v6/X55CSzFEME3Ktx3R3MtH1vK84smgfP
         6tY39eXQHjnDIiRG7yZnPIuzYLfJ0I20Dwlm+HlY58wKv6JlEywxLBRiRMsQd9eTZoa2
         9WXA==
X-Gm-Message-State: ANoB5plb1MoCh6pvlJNKyerPYaI/k3CSopYv9ASUOLpbgSpX0CVzsoCC
        19gt4X9fdVMG+6JTaONNK/WhaQ==
X-Google-Smtp-Source: AA0mqf594J2eFY0KNEupimOvbIvK9KeK9uYcg0eIdH/QT59AGYHqPwmCbqUllsseAbXaebEnCF1w/g==
X-Received: by 2002:a0c:e9c6:0:b0:4c7:6938:4514 with SMTP id q6-20020a0ce9c6000000b004c769384514mr4460381qvo.0.1670519706840;
        Thu, 08 Dec 2022 09:15:06 -0800 (PST)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id bp32-20020a05620a45a000b006fa2cc1b0fbsm19484619qkb.11.2022.12.08.09.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 09:15:06 -0800 (PST)
Date:   Thu, 8 Dec 2022 17:15:05 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        John Dias <joaodias@google.com>,
        Connor O'Brien <connoro@google.com>,
        Rick Yiu <rickyiu@google.com>, John Kacur <jkacur@redhat.com>,
        Qais Yousef <qyousef@google.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        kernel-team@android.com,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>,
        "J . Avila" <elavila@google.com>
Subject: Re: [PATCH v5 3/3] softirq: defer softirq processing to ksoftirqd if
 CPU is busy with RT
Message-ID: <Y5IbmWjZTw2t3SH9@google.com>
References: <20221116075929.453876-1-jstultz@google.com>
 <20221116075929.453876-4-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116075929.453876-4-jstultz@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Wed, Nov 16, 2022 at 07:59:28AM +0000, John Stultz wrote:
> From: Pavankumar Kondeti <pkondeti@codeaurora.org>
> 
> Defer the softirq processing to ksoftirqd if a RT task is
> running or queued on the current CPU. This complements the RT
> task placement algorithm which tries to find a CPU that is not
> currently busy with softirqs.
> 
> Currently NET_TX, NET_RX, BLOCK and IRQ_POLL softirqs are only
> deferred as they can potentially run for long time.
> 
> Additionally, this patch stubs out ksoftirqd_running() logic,
> in the CONFIG_RT_SOFTIRQ_AWARE_SCHED case, as deferring
> potentially long-running softirqs will cause the logic to not
> process shorter-running softirqs immediately. By stubbing it out
> the potentially long running softirqs are deferred, but the
> shorter running ones can still run immediately.
> 
> This patch includes folded-in fixes by:
>   Lingutla Chandrasekhar <clingutla@codeaurora.org>
>   Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
>   J. Avila <elavila@google.com>
> 
[...]
> ---
> v4:
> * Fix commit message to accurately note long-running softirqs
>   (suggested by Qais)
> * Switch to using rt_task(current) (suggested by Qais)
> v5:
> * Switch to using CONFIG_RT_SOFTIRQ_AWARE_SCHED (suggested by
>   Joel Fernandes <joel@joelfernandes.org>)
> ---
>  kernel/softirq.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index dd92ce8f771b..5db2afd0be68 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -95,6 +95,7 @@ static void wakeup_softirqd(void)
>  		wake_up_process(tsk);
>  }
>  
> +#ifndef CONFIG_RT_SOFTIRQ_AWARE_SCHED
>  /*
>   * If ksoftirqd is scheduled, we do not want to process pending softirqs
>   * right now. Let ksoftirqd handle this at its own rate, to get fairness,
> @@ -109,6 +110,9 @@ static bool ksoftirqd_running(unsigned long pending)
>  		return false;
>  	return tsk && task_is_running(tsk) && !__kthread_should_park(tsk);
>  }
> +#else
> +#define ksoftirqd_running(pending) (false)
> +#endif /* CONFIG_RT_SOFTIRQ_AWARE_SCHED */
>  
>  #ifdef CONFIG_TRACE_IRQFLAGS
>  DEFINE_PER_CPU(int, hardirqs_enabled);
> @@ -540,6 +544,21 @@ static inline bool lockdep_softirq_start(void) { return false; }
>  static inline void lockdep_softirq_end(bool in_hardirq) { }
>  #endif
>  
> +#ifdef CONFIG_RT_SOFTIRQ_AWARE_SCHED
> +static __u32 softirq_deferred_for_rt(__u32 *pending)
> +{
> +	__u32 deferred = 0;
> +
> +	if (rt_task(current)) {

Over here, I suggest also check dl_task(current). SCHED_DEADLINE is being
used for the 'sugov' (schedutil governor threads) on currently shipping
products, and DL should be treated greater than RT priority.

On the other hand, the DL counterpart to avoid softirq is not there, but at
least softirq can defer for DL threads.

> +		deferred = *pending & LONG_SOFTIRQ_MASK;
> +		*pending &= ~LONG_SOFTIRQ_MASK;
> +	}
> +	return deferred;
> +}
> +#else
> +#define softirq_deferred_for_rt(x) (0)
> +#endif
> +
>  asmlinkage __visible void __softirq_entry __do_softirq(void)
>  {
>  	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
> @@ -547,6 +566,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>  	int max_restart = MAX_SOFTIRQ_RESTART;
>  	struct softirq_action *h;
>  	bool in_hardirq;
> +	__u32 deferred;
>  	__u32 pending;
>  	int softirq_bit;
>  
> @@ -558,14 +578,16 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>  	current->flags &= ~PF_MEMALLOC;
>  
>  	pending = local_softirq_pending();
> +	deferred = softirq_deferred_for_rt(&pending);
>  
>  	softirq_handle_begin();
> +
>  	in_hardirq = lockdep_softirq_start();
>  	account_softirq_enter(current);
>  
>  restart:
>  	/* Reset the pending bitmask before enabling irqs */
> -	set_softirq_pending(0);
> +	set_softirq_pending(deferred);

Over here, the local pending mask is set to whatever was deferred [1]..

>  	set_active_softirqs(pending);
>  
>  	local_irq_enable();
> @@ -604,13 +626,16 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>  	local_irq_disable();
>  
>  	pending = local_softirq_pending();
> +	deferred = softirq_deferred_for_rt(&pending);

... so over here, pending should always be set to atleast the deferred bits
if deferred is set (unless something wokeup and executed softirqs while
interrupts are enabled -- which should not happen because BH is disabled
through out) [2].

> +
>  	if (pending) {
>  		if (time_before(jiffies, end) && !need_resched() &&
>  		    --max_restart)

So then here, pending (which also now contains deferred due to [1] [2])
should already take care off waking up ksoftirqd, except that perhaps it
should be like this:

  	if (pending) {
		// Also, don't restart if something was deferred, let the RT task
		// breath a bit.
  		if (time_before(jiffies, end) && !need_resched() &&
			!deferred && --max_restart)
			goto restart;

		wakeup_softirqd();
	}

Or, will that not work?

My point being that we probably don't want to go through the retry-cycle,
if something was deferred since the plan is to wake up ksoftirqd in such
cases.

> +	if (pending | deferred)
>  		wakeup_softirqd();

And then perhaps this check can be removed.

Thoughts?

thanks,

 - Joel



>  			goto restart;
> +	}
>  
> +	if (pending | deferred)
>  		wakeup_softirqd();
> -	}
>  
>  	account_softirq_exit(current);
>  	lockdep_softirq_end(in_hardirq);
> -- 
> 2.38.1.431.g37b22c650d-goog
> 
