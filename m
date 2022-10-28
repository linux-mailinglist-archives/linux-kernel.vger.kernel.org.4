Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B8B6119CD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJ1SBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiJ1SBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:01:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD32517D2A1;
        Fri, 28 Oct 2022 11:01:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 525C962A03;
        Fri, 28 Oct 2022 18:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D3FC433C1;
        Fri, 28 Oct 2022 18:01:13 +0000 (UTC)
Date:   Fri, 28 Oct 2022 14:01:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-usb@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        John Stultz <jstultz@google.com>
Subject: Re: [RFC][PATCH v2 20/31] timers: usb: Use del_timer_shutdown()
 before freeing timer
Message-ID: <20221028140129.040d9acc@gandalf.local.home>
In-Reply-To: <4e61935b-b06b-1f2d-6c2b-79bdfd569cd6@roeck-us.net>
References: <20221027150525.753064657@goodmis.org>
        <20221027150928.983388020@goodmis.org>
        <4e61935b-b06b-1f2d-6c2b-79bdfd569cd6@roeck-us.net>
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

On Thu, 27 Oct 2022 22:23:06 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> > index bbab424b0d55..397f263ab7da 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -1261,6 +1261,9 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
> >   
> >   		/* Don't do a long sleep inside a workqueue routine */
> >   		if (type == HUB_INIT2) {
> > +			/* Timers must be shutdown before they are re-initialized */
> > +			if (hub->init_work.work.func)
> > +				del_timer_shutdown(&hub->init_work.timer);
> >   			INIT_DELAYED_WORK(&hub->init_work, hub_init_func3);  
> 
> A similar call to INIT_DELAYED_WORK() around line 1085 needs the same change.
> 
> It would be great if that can somehow be hidden in INIT_DELAYED_WORK().

I've decided to treat INIT_DELAYED_WORK() like it was before. It only
checks from the time the timer is added to the time it is removed without
needing a shutdown call. That's because there's no API in the workqueue
code that allows for us to require a shutdown on the INIT_DELAYED_WORK's
timer.

Guenter,

Can you remove all the extra patches that touched the timer.h and timer.c
code, and replace the last patch with this, and then try again?

-- Steve

 include/linux/timer.h     | 38 +++++++++++++++++++++++++++--
 include/linux/workqueue.h |  4 ++--
 kernel/time/timer.c       | 50 ++++++++++++++++++++++++++++++++++-----
 kernel/workqueue.c        | 12 ++++++++++
 4 files changed, 94 insertions(+), 10 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 45392b0ac2e1..27e3a8676ff8 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -8,6 +8,12 @@
 #include <linux/debugobjects.h>
 #include <linux/stringify.h>
 
+enum timer_debug_state {
+	TIMER_DEBUG_DISABLED,
+	TIMER_DEBUG_ENABLED,
+	TIMER_DEBUG_WORK,
+};
+
 struct timer_list {
 	/*
 	 * All fields that change during normal runtime grouped to the
@@ -18,6 +24,9 @@ struct timer_list {
 	void			(*function)(struct timer_list *);
 	u32			flags;
 
+#ifdef CONFIG_DEBUG_OBJECTS_TIMERS
+	enum timer_debug_state	enabled;
+#endif
 #ifdef CONFIG_LOCKDEP
 	struct lockdep_map	lockdep_map;
 #endif
@@ -128,6 +137,31 @@ static inline void init_timer_on_stack_key(struct timer_list *timer,
 	init_timer_on_stack_key((_timer), (_fn), (_flags), NULL, NULL)
 #endif
 
+#ifdef CONFIG_DEBUG_OBJECTS_TIMERS
+#define __init_timer_debug(_timer, _fn, _flags)				\
+	do {								\
+		(_timer)->enabled = TIMER_DEBUG_DISABLED;		\
+		__init_timer((_timer), (_fn), (_flags));		\
+	} while (0)
+#define __init_timer_work(_timer, _fn, _flags)				\
+	do {								\
+		(_timer)->enabled = TIMER_DEBUG_WORK;			\
+		__init_timer((_timer), (_fn), (_flags));		\
+	} while (0)
+#define __init_timer_work_on_stack(_timer, _fn, _flags)				\
+	do {								\
+		(_timer)->enabled = TIMER_DEBUG_WORK;			\
+		__init_timer_on_stack((_timer), (_fn), (_flags));	\
+	} while (0)
+#else
+#define __init_timer_debug(_timer, _fn, _flags)				\
+	__init_timer((_timer), (_fn), (_flags))
+#define __init_timer_work(_timer, _fn, _flags)				\
+	__init_timer((_timer), (_fn), (_flags))
+#define __init_timer_work_on_stack(_timer, _fn, _flags)			\
+	__init_timer_on_stack((_timer), (_fn), (_flags))
+#endif
+
 /**
  * timer_setup - prepare a timer for first use
  * @timer: the timer in question
@@ -139,7 +173,7 @@ static inline void init_timer_on_stack_key(struct timer_list *timer,
  * be used and must be balanced with a call to destroy_timer_on_stack().
  */
 #define timer_setup(timer, callback, flags)			\
-	__init_timer((timer), (callback), (flags))
+	__init_timer_debug((timer), (callback), (flags))
 
 #define timer_setup_on_stack(timer, callback, flags)		\
 	__init_timer_on_stack((timer), (callback), (flags))
@@ -243,7 +277,7 @@ static inline int del_timer_shutdown(struct timer_list *timer)
 	return __del_timer_sync(timer, true);
 }
 
-#define del_singleshot_timer_sync(t) del_timer_sync(t)
+#define del_singleshot_timer_sync(t) del_timer_shutdown(t)
 
 extern void init_timers(void);
 struct hrtimer;
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index a0143dd24430..290c96429ce1 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -250,7 +250,7 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
 #define __INIT_DELAYED_WORK(_work, _func, _tflags)			\
 	do {								\
 		INIT_WORK(&(_work)->work, (_func));			\
-		__init_timer(&(_work)->timer,				\
+		__init_timer_work(&(_work)->timer,			\
 			     delayed_work_timer_fn,			\
 			     (_tflags) | TIMER_IRQSAFE);		\
 	} while (0)
@@ -258,7 +258,7 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
 #define __INIT_DELAYED_WORK_ONSTACK(_work, _func, _tflags)		\
 	do {								\
 		INIT_WORK_ONSTACK(&(_work)->work, (_func));		\
-		__init_timer_on_stack(&(_work)->timer,			\
+		__init_timer_work_on_stack(&(_work)->timer,		\
 				      delayed_work_timer_fn,		\
 				      (_tflags) | TIMER_IRQSAFE);	\
 	} while (0)
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 5179ac2335a0..9a921843cc4f 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -691,7 +691,11 @@ static bool timer_fixup_init(void *addr, enum debug_obj_state state)
 
 	switch (state) {
 	case ODEBUG_STATE_ACTIVE:
-		del_timer_sync(timer);
+		if (timer->enabled != TIMER_DEBUG_WORK)
+			timer->enabled = TIMER_DEBUG_ENABLED;
+		del_timer_shutdown(timer);
+		if (timer->enabled != TIMER_DEBUG_WORK)
+			timer->enabled = TIMER_DEBUG_DISABLED;
 		debug_object_init(timer, &timer_debug_descr);
 		return true;
 	default:
@@ -737,8 +741,10 @@ static bool timer_fixup_free(void *addr, enum debug_obj_state state)
 
 	switch (state) {
 	case ODEBUG_STATE_ACTIVE:
-		del_timer_sync(timer);
+		del_timer_shutdown(timer);
 		debug_object_free(timer, &timer_debug_descr);
+		if (timer->enabled != TIMER_DEBUG_WORK)
+			timer->enabled = TIMER_DEBUG_DISABLED;
 		return true;
 	default:
 		return false;
@@ -774,16 +780,36 @@ static const struct debug_obj_descr timer_debug_descr = {
 
 static inline void debug_timer_init(struct timer_list *timer)
 {
+	if (timer->enabled == TIMER_DEBUG_ENABLED)
+		return;
+
 	debug_object_init(timer, &timer_debug_descr);
 }
 
 static inline void debug_timer_activate(struct timer_list *timer)
 {
+	if (timer->enabled == TIMER_DEBUG_ENABLED)
+		return;
+
+	if (timer->enabled == TIMER_DEBUG_DISABLED)
+		timer->enabled = TIMER_DEBUG_ENABLED;
+
 	debug_object_activate(timer, &timer_debug_descr);
 }
 
-static inline void debug_timer_deactivate(struct timer_list *timer)
+static inline void debug_timer_deactivate(struct timer_list *timer, bool free)
 {
+	switch (timer->enabled) {
+	case TIMER_DEBUG_DISABLED:
+		return;
+	case TIMER_DEBUG_ENABLED:
+		if (!free)
+			return;
+		timer->enabled = TIMER_DEBUG_DISABLED;
+		break;
+	case TIMER_DEBUG_WORK:
+		break;
+	}
 	debug_object_deactivate(timer, &timer_debug_descr);
 }
 
@@ -813,6 +839,14 @@ void destroy_timer_on_stack(struct timer_list *timer)
 }
 EXPORT_SYMBOL_GPL(destroy_timer_on_stack);
 
+static struct timer_base *lock_timer_base(struct timer_list *timer,
+					  unsigned long *flags);
+
+void __timer_reinit_debug_objects(struct timer_list *timer)
+{
+	return;
+}
+
 #else
 static inline void debug_timer_init(struct timer_list *timer) { }
 static inline void debug_timer_activate(struct timer_list *timer) { }
@@ -828,7 +862,7 @@ static inline void debug_init(struct timer_list *timer)
 
 static inline void debug_deactivate(struct timer_list *timer)
 {
-	debug_timer_deactivate(timer);
+	debug_timer_deactivate(timer, false);
 	trace_timer_cancel(timer);
 }
 
@@ -1251,8 +1285,10 @@ int __del_timer(struct timer_list *timer, bool free)
 	if (timer_pending(timer)) {
 		base = lock_timer_base(timer, &flags);
 		ret = detach_if_pending(timer, base, true);
-		if (free && ret)
+		if (free) {
 			timer->function = NULL;
+			debug_timer_deactivate(timer, true);
+		}
 		raw_spin_unlock_irqrestore(&base->lock, flags);
 	}
 
@@ -1272,8 +1308,10 @@ static int __try_to_del_timer_sync(struct timer_list *timer, bool free)
 
 	if (base->running_timer != timer)
 		ret = detach_if_pending(timer, base, true);
-	if (free)
+	if (free) {
 		timer->function = NULL;
+		debug_timer_deactivate(timer, true);
+	}
 
 	raw_spin_unlock_irqrestore(&base->lock, flags);
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 47a7124bbea4..9a48213fc4e4 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1225,6 +1225,16 @@ static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, unsigned long work_
 	put_pwq(pwq);
 }
 
+static void deactivate_timer(struct work_struct *work, bool is_dwork)
+{
+	struct delayed_work *dwork;
+
+	if (!is_dwork)
+		return;
+
+	dwork = to_delayed_work(work);
+}
+
 /**
  * try_to_grab_pending - steal work item from worklist and disable irq
  * @work: work item to steal
@@ -3148,6 +3158,8 @@ static bool __cancel_work_timer(struct work_struct *work, bool is_dwork)
 		}
 	} while (unlikely(ret < 0));
 
+	deactivate_timer(work, is_dwork);
+
 	/* tell other tasks trying to grab @work to back off */
 	mark_work_canceling(work);
 	local_irq_restore(flags);
-- 
2.35.1

