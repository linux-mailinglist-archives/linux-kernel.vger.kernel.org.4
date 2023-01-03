Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8A365C7EF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbjACUQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237743AbjACUQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:16:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1684E26E1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 12:15:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 331DB614B4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 20:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8634CC433EF;
        Tue,  3 Jan 2023 20:15:56 +0000 (UTC)
Date:   Tue, 3 Jan 2023 15:15:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Connor O'Brien" <connoro@google.com>, kernel-team@android.com,
        "J . Avila" <elavila@google.com>
Subject: Re: [PATCH] trace: Add trace points for tasklet entry/exit
Message-ID: <20230103151554.5c0a6c6f@gandalf.local.home>
In-Reply-To: <20230103185408.2874345-1-jstultz@google.com>
References: <20230103185408.2874345-1-jstultz@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Jan 2023 18:54:08 +0000
John Stultz <jstultz@google.com> wrote:

> From: Lingutla Chandrasekhar <clingutla@codeaurora.org>
> 
> Tasklets are supposed to finish their work quickly and
> should not block the current running process, but it is not
> guaranteed that. Currently softirq_entry/exit can be used to
> know total tasklets execution time, but not helpful to track
> individual tasklet's execution time. With that we can't find
> any culprit tasklet function, which is taking more time.
> 
> Add tasklet_entry/exit trace point support to track
> individual tasklet execution.
> 
> This patch has been carried in the Android tree for awhile
> so I wanted to submit it for review upstream. Feedback would
> be appreciated!
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Connor O'Brien <connoro@google.com>
> Cc: kernel-team@android.com
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
> [elavila: Port to android-mainline]
> Signed-off-by: J. Avila <elavila@google.com>
> [jstultz: Rebased to upstream, cut unused trace points, added
>  comments for the tracepoints, reworded commit]
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>  include/trace/events/irq.h | 43 ++++++++++++++++++++++++++++++++++++++
>  kernel/softirq.c           |  9 ++++++--
>  2 files changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/irq.h b/include/trace/events/irq.h
> index eeceafaaea4c..da85851d4ec1 100644
> --- a/include/trace/events/irq.h
> +++ b/include/trace/events/irq.h
> @@ -160,6 +160,49 @@ DEFINE_EVENT(softirq, softirq_raise,
>  	TP_ARGS(vec_nr)
>  );
>  
> +DECLARE_EVENT_CLASS(tasklet,
> +
> +	TP_PROTO(void *func),
> +
> +	TP_ARGS(func),
> +
> +	TP_STRUCT__entry(

Could you also add a pointer to the tasklet too?

		__field(	void *, tasklet)

> +		__field(	void *,	func)
> +	),
> +
> +	TP_fast_assign(

		__entry->tasklet = t;

> +		__entry->func = func;
> +	),
> +
> +	TP_printk("function=%ps", __entry->func)

This way if we wanted more information, we could use event probes:

 # echo 'e:tasklet_info tasklet/tasklet_entry state=+8($tasklet):u64' > dynamic_events

-- Steve


> +);
> +
> +/**
> + * tasklet_entry - called immediately before the tasklet is run
> + * @func:  tasklet callback or function being run
> + *
> + * Used to find individual tasklet execution time
> + */
> +DEFINE_EVENT(tasklet, tasklet_entry,
> +
> +	TP_PROTO(void *func),
> +
> +	TP_ARGS(func)
> +);
> +
> +/**
> + * tasklet_exit - called immediately after the tasklet is run
> + * @func:  tasklet callback or function being run
> + *
> + * Used to find individual tasklet execution time
> + */
> +DEFINE_EVENT(tasklet, tasklet_exit,
> +
> +	TP_PROTO(void *func),
> +
> +	TP_ARGS(func)
> +);
> +
>  #endif /*  _TRACE_IRQ_H */
>  
>  /* This part must be outside protection */
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index c8a6913c067d..dbd322524171 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -793,10 +793,15 @@ static void tasklet_action_common(struct softirq_action *a,
>  		if (tasklet_trylock(t)) {
>  			if (!atomic_read(&t->count)) {
>  				if (tasklet_clear_sched(t)) {
> -					if (t->use_callback)
> +					if (t->use_callback) {
> +						trace_tasklet_entry(t->callback);
>  						t->callback(t);
> -					else
> +						trace_tasklet_exit(t->callback);
> +					} else {
> +						trace_tasklet_entry(t->func);
>  						t->func(t->data);
> +						trace_tasklet_exit(t->func);
> +					}
>  				}
>  				tasklet_unlock(t);
>  				continue;

