Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433745EC2B9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiI0MbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiI0MbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:31:08 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0C367C9F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:31:05 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id c30so11829105edn.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=5ft9ZKgcoilbmvfkfl9ZpGjG19NwykRqtF901VdwZnw=;
        b=T/uniFHOpdz+MiTIdGzU7xL/KqvWrhxvv6LOrqyYzE/V7YkPjC1tefHPEYi87X3vXG
         ejFTM6X0X+8IIEWtGE0TdhYAVanv73/AOA77w3yEmRySAX0UjIu9XWLo0gZ+wQp0oEuO
         wAXAOd+/0SQHNa4t5Wv8hUtMNGfTdFMRwqEe4AbjI8klWLwDsd73OMe1Zfw9TxsxIcJW
         ezzbQG9JxlG5wUwBEsGvP70VWhfdcYGCKXhLiDpA6ei6B+HgT/NjoT0BUBE1LqSGreHY
         blCcFP61bMoyMidM2zfzfI8UusVuQj/Eq7LxLaOLYuMZt7q3NbKpLtbRmAlKPLtqiGjY
         cGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5ft9ZKgcoilbmvfkfl9ZpGjG19NwykRqtF901VdwZnw=;
        b=bnGtgj2S3kmy+o/RWwx0kBqe6OWeUuZE4u3KEOXODJqm3ZO07iTmCFWRtrs53jyM9w
         1+oSYMpbcXocF73ZHtf9E/KOphzGYutMpN1iQs24A1K9inax9YApxb11IxipZn2wZGd6
         Ths1+btTiGVVdylOvK6HSM+IKHxvKPdrf7qBR8XWNbAoyf5dVJZib/0IfgLXg74B09BK
         yJnX1B6W4RtTXqJOfoPa5TihqSuc5ghZhj6gnuJ2R959U3E2X0Na7ek1aCyyf1KKXXHx
         ea9IodJU1ze1rjhjaX9LAwX7rsqAPofOW6Vui+eqxXIQA6uaDRKbXiNljbmSGNQn/sfb
         ADQQ==
X-Gm-Message-State: ACrzQf0s9/B5ATo9R8MpfOtC06gHY2xThBPJszCsomsC1gBlKvfb3Qxh
        /42+PW17ta5CZ1bo8e0FDO/R0q1SE4QmLA==
X-Google-Smtp-Source: AMsMyM5Kvn5Mp4saf5XRcJwtEk9gtMJzbU0i/p8I+1gytRzlCaf/eo/w/fMDo9Cgkdcl9ZFyVGF2KQ==
X-Received: by 2002:a05:6402:1554:b0:457:375e:7289 with SMTP id p20-20020a056402155400b00457375e7289mr11645505edx.171.1664281863992;
        Tue, 27 Sep 2022 05:31:03 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:693c:15a1:a531:bb4e])
        by smtp.gmail.com with ESMTPSA id bc25-20020a056402205900b0044ef2ac2650sm1141168edb.90.2022.09.27.05.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 05:31:03 -0700 (PDT)
Date:   Tue, 27 Sep 2022 14:30:56 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] perf: Fix missing SIGTRAPs due to pending_disable abuse
Message-ID: <YzLtAG2bfRJ/vFRu@elver.google.com>
References: <20220927121322.1236730-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927121322.1236730-1-elver@google.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 02:13PM +0200, Marco Elver wrote:
> Due to the implementation of how SIGTRAP are delivered if
> perf_event_attr::sigtrap is set, we've noticed 3 issues:
> 
> 	1. Missing SIGTRAP due to a race with event_sched_out() (more
> 	   details below).
> 
> 	2. Hardware PMU events being disabled due to returning 1 from
> 	   perf_event_overflow(). The only way to re-enable the event is
> 	   for user space to first "properly" disable the event and then
> 	   re-enable it.
> 
> 	3. The inability to automatically disable an event after a
> 	   specified number of overflows via PERF_EVENT_IOC_REFRESH.
> 
> The worst of the 3 issues is problem (1), which occurs when a
> pending_disable is "consumed" by a racing event_sched_out(), observed as
> follows:
> 
> 		CPU0			| 	CPU1
> 	--------------------------------+---------------------------
> 	__perf_event_overflow()		|
> 	 perf_event_disable_inatomic()	|
> 	  pending_disable = CPU0	| ...
> 	  				| _perf_event_enable()
> 					|  event_function_call()
> 					|   task_function_call()
> 					|    /* sends IPI to CPU0 */
> 	<IPI>				| ...
> 	 __perf_event_enable()		+---------------------------
> 	  ctx_resched()
> 	   task_ctx_sched_out()
> 	    ctx_sched_out()
> 	     group_sched_out()
> 	      event_sched_out()
> 	       pending_disable = -1
> 	</IPI>
> 	<IRQ-work>
> 	 perf_pending_event()
> 	  perf_pending_event_disable()
> 	   /* Fails to send SIGTRAP because no pending_disable! */
> 	</IRQ-work>
> 
> In the above case, not only is that particular SIGTRAP missed, but also
> all future SIGTRAPs because 'event_limit' is not reset back to 1.
> 
> To fix, rework pending delivery of SIGTRAP via IRQ-work by introduction
> of a separate 'pending_sigtrap', no longer using 'event_limit' and
> 'pending_disable' for its delivery.
> 
> During testing, this also revealed several more possible races between
> reschedules and pending IRQ work; see code comments for details.
> 
> Doing so makes it possible to use 'event_limit' normally (thereby
> enabling use of PERF_EVENT_IOC_REFRESH), perf_event_overflow() no longer
> returns 1 on SIGTRAP causing disabling of hardware PMUs, and finally the
> race is no longer possible due to event_sched_out() not consuming
> 'pending_disable'.
> 
> Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Debugged-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/linux/perf_event.h |  2 +
>  kernel/events/core.c       | 85 ++++++++++++++++++++++++++++++++------
>  2 files changed, 75 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 907b0e3f1318..dff3430844a2 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -740,8 +740,10 @@ struct perf_event {
>  	int				pending_wakeup;
>  	int				pending_kill;
>  	int				pending_disable;
> +	int				pending_sigtrap;
>  	unsigned long			pending_addr;	/* SIGTRAP */
>  	struct irq_work			pending;
> +	struct irq_work			pending_resched;
>  
>  	atomic_t			event_limit;
>  
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 75f5705b6892..df90777262bf 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2527,6 +2527,14 @@ event_sched_in(struct perf_event *event,
>  	if (event->attr.exclusive)
>  		cpuctx->exclusive = 1;
>  
> +	if (event->pending_sigtrap) {
> +		/*
> +		 * The task and event might have been moved to another CPU:
> +		 * queue another IRQ work. See perf_pending_event_sigtrap().
> +		 */
> +		WARN_ON_ONCE(!irq_work_queue(&event->pending_resched));

One question we had is if it's possible for an event to be scheduled in,
immediately scheduled out, and then scheduled in on a 3rd CPU. I.e. we'd
still be in trouble if we can do this:

	CPU0
	sched-out
		CPU1
		sched-in
		sched-out
			CPU2
			sched-in

without any IRQ work ever running. Some naive solutions so the
pending_resched IRQ work isn't needed, like trying to send a signal
right here (or in event_sched_out()), don't work because we've seen
syzkaller produce programs where there's a pending event and then the
scheduler moves the task; because we're in the scheduler we can deadlock
if we try to send the signal here.

Thanks,
-- Marco
