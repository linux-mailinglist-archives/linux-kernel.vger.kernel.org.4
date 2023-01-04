Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C2065D5A3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239275AbjADO3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbjADO3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:29:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658DA1B1D0
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 06:29:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F09126174F
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 14:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32078C433D2;
        Wed,  4 Jan 2023 14:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672842562;
        bh=/UI6QPvD3oCrqOgTxaQlYrA8PAA4phdFzEfI7uMdEvo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y4p2M/AC+xTfh9JFLOMmjjroaBF3QwtYvCH5KjtB0/sm6k5hW9/vKgaPLWfZ3VjkI
         r+ndxwc4O3N3AnKqzI7vz8OsBv8ceG72Kfxuvzm6OwdkbRwfeIVevthhKz2L5mMwBd
         BEYyMuRPJvxqRdq1UGQqxaJ5+7S8yihDiugny7HbFC2GP6xPCCZBSUzmx5uEikZ4WJ
         PucHYplNX7IHTwdGI1mW6wEGHPxQNohatS7M5ijIdFXZPOu5l+6kTsPmt6GhNxDyjU
         uIpd4R+KKpLmbsZCzEk1FRvHe9IaOKzrk9wh+HQFKCuDWqhN8NHvMVX5hh8m4A81+M
         tP0bGUK0uzd3A==
Date:   Wed, 4 Jan 2023 23:29:18 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Connor O'Brien" <connoro@google.com>, kernel-team@android.com,
        "J . Avila" <elavila@google.com>
Subject: Re: [PATCH] trace: Add trace points for tasklet entry/exit
Message-Id: <20230104232918.2791484c39ac54c59a7110f4@kernel.org>
In-Reply-To: <20230103151554.5c0a6c6f@gandalf.local.home>
References: <20230103185408.2874345-1-jstultz@google.com>
        <20230103151554.5c0a6c6f@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2023 15:15:54 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  3 Jan 2023 18:54:08 +0000
> John Stultz <jstultz@google.com> wrote:
> 
> > From: Lingutla Chandrasekhar <clingutla@codeaurora.org>
> > 
> > Tasklets are supposed to finish their work quickly and
> > should not block the current running process, but it is not
> > guaranteed that. Currently softirq_entry/exit can be used to
> > know total tasklets execution time, but not helpful to track
> > individual tasklet's execution time. With that we can't find
> > any culprit tasklet function, which is taking more time.
> > 
> > Add tasklet_entry/exit trace point support to track
> > individual tasklet execution.
> > 
> > This patch has been carried in the Android tree for awhile
> > so I wanted to submit it for review upstream. Feedback would
> > be appreciated!
> > 
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Connor O'Brien <connoro@google.com>
> > Cc: kernel-team@android.com
> > Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
> > [elavila: Port to android-mainline]
> > Signed-off-by: J. Avila <elavila@google.com>
> > [jstultz: Rebased to upstream, cut unused trace points, added
> >  comments for the tracepoints, reworded commit]
> > Signed-off-by: John Stultz <jstultz@google.com>
> > ---
> >  include/trace/events/irq.h | 43 ++++++++++++++++++++++++++++++++++++++
> >  kernel/softirq.c           |  9 ++++++--
> >  2 files changed, 50 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/trace/events/irq.h b/include/trace/events/irq.h
> > index eeceafaaea4c..da85851d4ec1 100644
> > --- a/include/trace/events/irq.h
> > +++ b/include/trace/events/irq.h
> > @@ -160,6 +160,49 @@ DEFINE_EVENT(softirq, softirq_raise,
> >  	TP_ARGS(vec_nr)
> >  );
> >  
> > +DECLARE_EVENT_CLASS(tasklet,
> > +
> > +	TP_PROTO(void *func),
> > +
> > +	TP_ARGS(func),
> > +
> > +	TP_STRUCT__entry(
> 
> Could you also add a pointer to the tasklet too?
> 
> 		__field(	void *, tasklet)
> 
> > +		__field(	void *,	func)
> > +	),
> > +
> > +	TP_fast_assign(
> 
> 		__entry->tasklet = t;
> 
> > +		__entry->func = func;
> > +	),
> > +
> > +	TP_printk("function=%ps", __entry->func)
> 
> This way if we wanted more information, we could use event probes:
> 
>  # echo 'e:tasklet_info tasklet/tasklet_entry state=+8($tasklet):u64' > dynamic_events

Hmm, what about saving 'state' and 'count' instead of 'tasklet'?

I have a question about the basic policy of making a new tracepoint.

Of course we can expand the event with eprobes as you said, but without
eprobe, this 'tasklet' field of this event just exposing a kernel
internal object address. That is useless in most cases. And also the
offset (layout) in the kernel data structure can be changed by some
debug options. We need an external tool to find correct offset (e.g.
perf probe).

So my question is when adding a new event, whether it should expose a
(address of) related data structure, or expose some value fields of
the structure. IMHO, the basic policy is latter. Of course if the
data structure is enough big and most of its fields are usually not
interesting, it may be better to save the data structure itself.

Thank you,

> 
> -- Steve
> 
> 
> > +);
> > +
> > +/**
> > + * tasklet_entry - called immediately before the tasklet is run
> > + * @func:  tasklet callback or function being run
> > + *
> > + * Used to find individual tasklet execution time
> > + */
> > +DEFINE_EVENT(tasklet, tasklet_entry,
> > +
> > +	TP_PROTO(void *func),
> > +
> > +	TP_ARGS(func)
> > +);
> > +
> > +/**
> > + * tasklet_exit - called immediately after the tasklet is run
> > + * @func:  tasklet callback or function being run
> > + *
> > + * Used to find individual tasklet execution time
> > + */
> > +DEFINE_EVENT(tasklet, tasklet_exit,
> > +
> > +	TP_PROTO(void *func),
> > +
> > +	TP_ARGS(func)
> > +);
> > +
> >  #endif /*  _TRACE_IRQ_H */
> >  
> >  /* This part must be outside protection */
> > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > index c8a6913c067d..dbd322524171 100644
> > --- a/kernel/softirq.c
> > +++ b/kernel/softirq.c
> > @@ -793,10 +793,15 @@ static void tasklet_action_common(struct softirq_action *a,
> >  		if (tasklet_trylock(t)) {
> >  			if (!atomic_read(&t->count)) {
> >  				if (tasklet_clear_sched(t)) {
> > -					if (t->use_callback)
> > +					if (t->use_callback) {
> > +						trace_tasklet_entry(t->callback);
> >  						t->callback(t);
> > -					else
> > +						trace_tasklet_exit(t->callback);
> > +					} else {
> > +						trace_tasklet_entry(t->func);
> >  						t->func(t->data);
> > +						trace_tasklet_exit(t->func);
> > +					}
> >  				}
> >  				tasklet_unlock(t);
> >  				continue;
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
