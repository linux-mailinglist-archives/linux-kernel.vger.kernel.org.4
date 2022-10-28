Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0A9611B50
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiJ1UAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiJ1UAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:00:04 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59EE11C28;
        Fri, 28 Oct 2022 13:00:02 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id cy15-20020a056830698f00b0065c530585afso3576238otb.2;
        Fri, 28 Oct 2022 13:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7pOGY3qDnloGxa0C8LMhfsJ2du/KHg8KXjyQBoNDmeE=;
        b=dqrhy1CtThG3sEdjhP3DZnyDrEu6qKzjyK4k1uwDuTG3Wiuqr09ETRroNKkKYlTfdR
         Otf7GGFX8byq3Evly+RGpkgQWgI1JTyTQ+Ql0k1mAKLYI6XzV+Pr999vCWNz6hfBXCH7
         z30inwBFfEXBjl0knBdjy/xmMkkJdh9cTAso9MGg2j1BPj+tN42GOX7agdkIZjrguUFx
         vB0ok2mKkFxowoauJk3RvkcHp17Ax0rF3dkxsEbbPyZPQWIj8V5vPGavqpaboEFthuPH
         dJl38ymnZgq/1IKqegxepAOdhyBZzHy1PhzrccnSPJBZMpyeeePdxrKqMd2DqQftBieq
         rs5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pOGY3qDnloGxa0C8LMhfsJ2du/KHg8KXjyQBoNDmeE=;
        b=A+Lv5b0ROEYqIBttUsIgKGKlOWTktgFpyvDAuBmF/sgv+080otOlQyWeBqlyP4MC0Z
         YuwiTfX7g9bmCuRZORHRR8CKrUQXwQvx15zXR+q3NfJunh8UDgb50tmudNmmDXrK1+qn
         c/tbhwG3LkOejsD4J08n22a53HQPiB0tEE4n0srt9lB9UyHtdwgAHTm60FaBd5apLI52
         GSTWIeYJmjaxEWxCRrR92ypm851M6EXk6HyewDNbqVNIkDvSGJqMxPySmLQE8xMWO1Z9
         fX0QqWAdtjhKrbMAwpEB8Bofq7NXOxTCnPQ1ht8TL0fGhdKrOT5CtyAMxShWMtNIP9ES
         VDQQ==
X-Gm-Message-State: ACrzQf3Kt+ssWBI7LUlcjuxUUWY5OnexVoJddsEGdXJiUibPLc1Gj21c
        w/RIqMhYLiSOdwE6UfpAbTw=
X-Google-Smtp-Source: AMsMyM4N4GGvX4hK7UVK5ZzJiz2vFYM2hekkNHDRNMWHW4GmoC12cf0yB5G86GquATA3R6wUOVzTOw==
X-Received: by 2002:a9d:f43:0:b0:638:c3c4:73ee with SMTP id 61-20020a9d0f43000000b00638c3c473eemr487733ott.186.1666987201948;
        Fri, 28 Oct 2022 13:00:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u12-20020a056870440c00b001375188dae9sm2579007oah.16.2022.10.28.13.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 13:00:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 28 Oct 2022 12:59:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20221028195959.GA1073367@roeck-us.net>
References: <20221027150525.753064657@goodmis.org>
 <20221027150928.983388020@goodmis.org>
 <4e61935b-b06b-1f2d-6c2b-79bdfd569cd6@roeck-us.net>
 <20221028140129.040d9acc@gandalf.local.home>
 <20221028141007.05f5c490@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028141007.05f5c490@gandalf.local.home>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 02:10:07PM -0400, Steven Rostedt wrote:
> On Fri, 28 Oct 2022 14:01:29 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > @@ -813,6 +839,14 @@ void destroy_timer_on_stack(struct timer_list *timer)
> >  }
> >  EXPORT_SYMBOL_GPL(destroy_timer_on_stack);
> >  
> > +static struct timer_base *lock_timer_base(struct timer_list *timer,
> > +					  unsigned long *flags);
> > +
> > +void __timer_reinit_debug_objects(struct timer_list *timer)
> > +{
> > +	return;
> > +}
> > +
> >  #else
> >  static inline void debug_timer_init(struct timer_list *timer) { }
> >  static inline void debug_timer_activate(struct timer_list *timer) { }
> 
> Bah, the above chunk was leftover from some debugging.
> 

I'll test again with the following changes on top of your published
patch series. I hope this is the current status, but I may have lost
something.

Looking into it ... deactivate_timer() doesn't do anything 
and seems wrong. Did I miss something ?

Thanks,
Guenter

---
diff --git a/block/blk-core.c b/block/blk-core.c
index 17667159482e..69b1daa2e91a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -227,7 +227,7 @@ const char *blk_status_to_str(blk_status_t status)
  */
 void blk_sync_queue(struct request_queue *q)
 {
-	del_timer_sync(&q->timeout);
+	del_timer_shutdown(&q->timeout);
 	cancel_work_sync(&q->timeout_work);
 }
 EXPORT_SYMBOL(blk_sync_queue);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e71b3b43927c..12a1e46536ed 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -769,6 +769,8 @@ static void blk_release_queue(struct kobject *kobj)
 
 	percpu_ref_exit(&q->q_usage_counter);
 
+	blk_sync_queue(q);
+
 	if (q->poll_stat)
 		blk_stat_remove_callback(q, q->poll_cb);
 	blk_stat_free_callback(q->poll_cb);
diff --git a/drivers/net/ethernet/dec/tulip/tulip_core.c b/drivers/net/ethernet/dec/tulip/tulip_core.c
index ecfad43df45a..0c86066929d3 100644
--- a/drivers/net/ethernet/dec/tulip/tulip_core.c
+++ b/drivers/net/ethernet/dec/tulip/tulip_core.c
@@ -770,8 +770,6 @@ static void tulip_down (struct net_device *dev)
 
 	spin_unlock_irqrestore (&tp->lock, flags);
 
-	timer_setup(&tp->timer, tulip_tbl[tp->chip_id].media_timer, 0);
-
 	dev->if_port = tp->saved_if_port;
 
 	/* Leave the driver in snooze, not sleep, mode. */
@@ -1869,10 +1867,14 @@ static int __maybe_unused tulip_resume(struct device *dev_d)
 static void tulip_remove_one(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
+	struct tulip_private *tp;
 
 	if (!dev)
 		return;
 
+	tp = netdev_priv(dev);
+	del_timer_shutdown(&tp->timer);
+
 	unregister_netdev(dev);
 }
 
diff --git a/drivers/parport/ieee1284.c b/drivers/parport/ieee1284.c
index 4547ac44c8d4..50dbd2ea23fc 100644
--- a/drivers/parport/ieee1284.c
+++ b/drivers/parport/ieee1284.c
@@ -73,7 +73,7 @@ int parport_wait_event (struct parport *port, signed long timeout)
 	timer_setup(&port->timer, timeout_waiting_on_port, 0);
 	mod_timer(&port->timer, jiffies + timeout);
 	ret = down_interruptible (&port->physport->ieee1284.irq);
-	if (!del_timer_sync(&port->timer) && !ret)
+	if (!del_timer_shutdown(&port->timer) && !ret)
 		/* Timed out. */
 		ret = 1;
 
diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 63f32f843e75..b91b27c398ae 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -789,7 +789,7 @@ static void purge_requests(struct ibmvscsi_host_data *hostdata, int error_code)
 	while (!list_empty(&hostdata->sent)) {
 		evt = list_first_entry(&hostdata->sent, struct srp_event_struct, list);
 		list_del(&evt->list);
-		del_timer(&evt->timer);
+		del_timer_try_shutdown(&evt->timer);
 
 		spin_unlock_irqrestore(hostdata->host->host_lock, flags);
 		if (evt->cmnd) {
@@ -944,7 +944,7 @@ static int ibmvscsi_send_srp_event(struct srp_event_struct *evt_struct,
 			       be64_to_cpu(crq_as_u64[1]));
 	if (rc != 0) {
 		list_del(&evt_struct->list);
-		del_timer(&evt_struct->timer);
+		del_timer_shutdown(&evt_struct->timer);
 
 		/* If send_crq returns H_CLOSED, return SCSI_MLQUEUE_HOST_BUSY.
 		 * Firmware will send a CRQ with a transport event (0xFF) to
@@ -1840,7 +1840,7 @@ static void ibmvscsi_handle_crq(struct viosrp_crq *crq,
 		atomic_add(be32_to_cpu(evt_struct->xfer_iu->srp.rsp.req_lim_delta),
 			   &hostdata->request_limit);
 
-	del_timer(&evt_struct->timer);
+	del_timer_shutdown(&evt_struct->timer);
 
 	if ((crq->status != VIOSRP_OK && crq->status != VIOSRP_OK2) && evt_struct->cmnd)
 		evt_struct->cmnd->result = DID_ERROR << 16;
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 397f263ab7da..7d1f7a89a5ea 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1082,6 +1082,9 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 			delay = hub_power_on_good_delay(hub);
 
 			hub_power_on(hub, false);
+			/* Timers must be shutdown before they are re-initialized */
+			if (hub->init_work.work.func)
+				del_timer_shutdown(&hub->init_work.timer);
 			INIT_DELAYED_WORK(&hub->init_work, hub_init_func2);
 			queue_delayed_work(system_power_efficient_wq,
 					&hub->init_work,
diff --git a/include/linux/timer.h b/include/linux/timer.h
index d4d90149d015..4dfb3913bb69 100644
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
@@ -19,7 +25,7 @@ struct timer_list {
 	u32			flags;
 
 #ifdef CONFIG_DEBUG_OBJECTS_TIMERS
-	u32			enabled;
+	enum timer_debug_state	enabled;
 #endif
 #ifdef CONFIG_LOCKDEP
 	struct lockdep_map	lockdep_map;
@@ -134,14 +140,26 @@ static inline void init_timer_on_stack_key(struct timer_list *timer,
 #ifdef CONFIG_DEBUG_OBJECTS_TIMERS
 #define __init_timer_debug(_timer, _fn, _flags)				\
 	do {								\
-		(_timer)->enabled = 0;					\
+		(_timer)->enabled = TIMER_DEBUG_DISABLED;		\
 		__init_timer((_timer), (_fn), (_flags));		\
 	} while (0)
-#else
-#define __init_timer_debug(_timer, _fn, _flags)				\
+#define __init_timer_work(_timer, _fn, _flags)				\
 	do {								\
+		(_timer)->enabled = TIMER_DEBUG_WORK;			\
 		__init_timer((_timer), (_fn), (_flags));		\
 	} while (0)
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
 #endif
 
 /**
@@ -184,12 +202,23 @@ static inline int timer_pending(const struct timer_list * timer)
 	return !hlist_unhashed_lockless(&timer->entry);
 }
 
+extern int __del_timer(struct timer_list * timer, bool free);
+
 extern void add_timer_on(struct timer_list *timer, int cpu);
-extern int del_timer(struct timer_list * timer);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
 extern int mod_timer_pending(struct timer_list *timer, unsigned long expires);
 extern int timer_reduce(struct timer_list *timer, unsigned long expires);
 
+static inline int del_timer_try_shutdown(struct timer_list *timer)
+{
+	return __del_timer(timer, true);
+}
+
+static inline int del_timer(struct timer_list *timer)
+{
+	return __del_timer(timer, false);
+}
+
 /*
  * The jiffies value which is added to now, when there is no timer
  * in the timer wheel:
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
index 1d17552b3ede..3c47652aeccf 100644
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
@@ -774,22 +780,37 @@ static const struct debug_obj_descr timer_debug_descr = {
 
 static inline void debug_timer_init(struct timer_list *timer)
 {
-	if (!timer->enabled)
-		debug_object_init(timer, &timer_debug_descr);
+	if (timer->enabled == TIMER_DEBUG_ENABLED)
+		return;
+
+	debug_object_init(timer, &timer_debug_descr);
 }
 
 static inline void debug_timer_activate(struct timer_list *timer)
 {
-	if (!timer->enabled) {
-		timer->enabled = 1;
-		debug_object_activate(timer, &timer_debug_descr);
-	}
+	if (timer->enabled == TIMER_DEBUG_ENABLED)
+		return;
+
+	if (timer->enabled == TIMER_DEBUG_DISABLED)
+		timer->enabled = TIMER_DEBUG_ENABLED;
+
+	debug_object_activate(timer, &timer_debug_descr);
 }
 
-static inline void debug_timer_deactivate(struct timer_list *timer)
+static inline void debug_timer_deactivate(struct timer_list *timer, bool free)
 {
-	if (timer->enabled)
-		debug_object_deactivate(timer, &timer_debug_descr);
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
+	debug_object_deactivate(timer, &timer_debug_descr);
 }
 
 static inline void debug_timer_assert_init(struct timer_list *timer)
@@ -833,6 +854,7 @@ static inline void debug_init(struct timer_list *timer)
 
 static inline void debug_deactivate(struct timer_list *timer)
 {
+	debug_timer_deactivate(timer, false);
 	trace_timer_cancel(timer);
 }
 
@@ -1255,7 +1277,7 @@ EXPORT_SYMBOL_GPL(add_timer_on);
  * (ie. del_timer() of an inactive timer returns 0, del_timer() of an
  * active timer returns 1.)
  */
-int del_timer(struct timer_list *timer)
+int __del_timer(struct timer_list *timer, bool free)
 {
 	struct timer_base *base;
 	unsigned long flags;
@@ -1266,12 +1288,16 @@ int del_timer(struct timer_list *timer)
 	if (timer_pending(timer)) {
 		base = lock_timer_base(timer, &flags);
 		ret = detach_if_pending(timer, base, true);
+		if (free) {
+			timer->function = NULL;
+			debug_timer_deactivate(timer);
+		}
 		raw_spin_unlock_irqrestore(&base->lock, flags);
 	}
 
 	return ret;
 }
-EXPORT_SYMBOL(del_timer);
+EXPORT_SYMBOL(__del_timer);
 
 static int __try_to_del_timer_sync(struct timer_list *timer, bool free)
 {
@@ -1287,7 +1313,7 @@ static int __try_to_del_timer_sync(struct timer_list *timer, bool free)
 		ret = detach_if_pending(timer, base, true);
 	if (free) {
 		timer->function = NULL;
-		debug_timer_deactivate(timer);
+		debug_timer_deactivate(timer, true);
 	}
 
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
diff --git a/net/core/sock.c b/net/core/sock.c
index 10cc84379d75..23a97442a0a6 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3345,7 +3345,7 @@ EXPORT_SYMBOL(sk_reset_timer);
 
 void sk_stop_timer(struct sock *sk, struct timer_list* timer)
 {
-	if (del_timer(timer))
+	if (del_timer_try_shutdown(timer))
 		__sock_put(sk);
 }
 EXPORT_SYMBOL(sk_stop_timer);
