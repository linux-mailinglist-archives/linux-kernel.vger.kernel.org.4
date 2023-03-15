Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BDD6BBA9F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjCORMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjCORMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:12:32 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9232812CF1;
        Wed, 15 Mar 2023 10:12:30 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r11so26647637edd.5;
        Wed, 15 Mar 2023 10:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678900349;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r19eXeSkwUKc4KS+vsW8oUnWuCNr/j51z25ohQwsQHs=;
        b=Dy3MkT7zL3Ox8P2OvtQKOJpJDSvCFMyfe7HAaFwRglAfa7XZtW8RlmAUVQj+oCvX/c
         tg6vz4RMa7MkmZwpV+cBNtAnkQurOrVC89/5GaYor7khpsoZgGxa05k2pbBRca6uq34L
         qs4I5FyECjeyWMTt7i8bqkp5R/JNMHvNXmB2LDJQ+3z4AOYPR4fjTVzZqNE1aeW0g7UO
         AIkfrMT0ZubjZtAQ0iR5XjLNi8Xnz45bBOjqXEKCflzSfN1ivHaDMkec+85qpDqVPKGg
         Ek0yWEsNBhGaw9kqBIn7uaGEiw6iCgjXtmo0uyhoDkWvRaT3Wx6db9XlTPm5U3f2Xoxh
         Qmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678900349;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r19eXeSkwUKc4KS+vsW8oUnWuCNr/j51z25ohQwsQHs=;
        b=fnWxslctuLxQDUHln+/QEYv6yJYS/hvQnyE/x0aJxz7YoYpXb+vuQQ+S1/wPMUz185
         HAQTcbVoy9hP2BItVZ+UjFtpwQpi0+tz80/rVEFN/HJShbPvBP9loWEezFOpXn89/NJG
         K4PjGIs2OCFjNF/cpQ3UsJZU3eRYKXkA9IdNYpAigb4Ca8r6BJG2GG6KjahB3mpEfOVr
         EAjjniHGg2tHBCgrGxZkNdRpR7b9f9AdoKnjPoUja3xSSO5hKYnbnvMguQBNApJEXGQ5
         QMaP0FIHubjeqDEP8QIGLkWOXuwWTvwB4wNTloM4y5GgaG+2JydPFGwGde6BodskENT3
         VT5g==
X-Gm-Message-State: AO0yUKUQ0Y+D4/JWPsSpVwzkdio4w8uawI+MfXmKJX5ekGfOy3BbN3Or
        r5ETvpQgaC51vAMhCitMUJw=
X-Google-Smtp-Source: AK7set9YKkK9KI5B5CHbx+fpc7HPmnK86i9Ko+wAj0pQrVxVkECTeEGyqz4SAJ+y1vhAiURFU7l4dw==
X-Received: by 2002:a17:906:ae51:b0:921:5cce:6592 with SMTP id lf17-20020a170906ae5100b009215cce6592mr6585257ejb.59.1678900348796;
        Wed, 15 Mar 2023 10:12:28 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id ot41-20020a170906cce900b009255b14e91dsm2775428ejb.46.2023.03.15.10.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 10:12:28 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 15 Mar 2023 18:12:26 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Message-ID: <ZBH8esPBh75iCALQ@pc638.lan>
References: <ZA7yK6iznHqiBu5i@pc636>
 <01559085-EB77-4962-B5EF-FF767F5A7353@joelfernandes.org>
 <ZA9B+sgrlK5yommJ@pc636>
 <CAEXW_YQ=cr_KTCZ8+Gpx9XLz6K6_sdcz_9KBs+gZuhuc2UQuLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQ=cr_KTCZ8+Gpx9XLz6K6_sdcz_9KBs+gZuhuc2UQuLg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 06:44:44PM -0400, Joel Fernandes wrote:
> On Mon, Mar 13, 2023 at 11:32 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > On Mon, Mar 13, 2023 at 06:58:30AM -0700, Joel Fernandes wrote:
> > >
> > >
> > > > On Mar 13, 2023, at 2:51 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > > >
> > > > ﻿On Fri, Mar 10, 2023 at 10:24:34PM -0800, Paul E. McKenney wrote:
> > > >>> On Fri, Mar 10, 2023 at 09:55:02AM +0100, Uladzislau Rezki wrote:
> > > >>> On Thu, Mar 09, 2023 at 10:10:56PM +0000, Joel Fernandes wrote:
> > > >>>> On Thu, Mar 09, 2023 at 01:57:42PM +0100, Uladzislau Rezki wrote:
> > > >>>> [..]
> > > >>>>>>>>>> See this commit:
> > > >>>>>>>>>>
> > > >>>>>>>>>> 3705b88db0d7cc ("rcu: Add a module parameter to force use of
> > > >>>>>>>>>> expedited RCU primitives")
> > > >>>>>>>>>>
> > > >>>>>>>>>> Antti provided this commit precisely in order to allow Android
> > > >>>>>>>>>> devices to expedite the boot process and to shut off the
> > > >>>>>>>>>> expediting at a time of Android userspace's choosing.  So Android
> > > >>>>>>>>>> has been making this work for about ten years, which strikes me
> > > >>>>>>>>>> as an adequate proof of concept.  ;-)
> > > >>>>>>>>>
> > > >>>>>>>>> Thanks for the pointer. That's true. Looking at Android sources, I
> > > >>>>>>>>> find that Android Mediatek devices at least are setting
> > > >>>>>>>>> rcu_expedited to 1 at late stage of their userspace boot (which is
> > > >>>>>>>>> weird, it should be set to 1 as early as possible), and
> > > >>>>>>>>> interestingly I cannot find them resetting it back to 0!.  Maybe
> > > >>>>>>>>> they set rcu_normal to 1? But I cannot find that either. Vlad? :P
> > > >>>>>>>>
> > > >>>>>>>> Interesting.  Though this is consistent with Antti's commit log,
> > > >>>>>>>> where he talks about expediting grace periods but not unexpediting
> > > >>>>>>>> them.
> > > >>>>>>>>
> > > >>>>>>> Do you think we need to unexpedite it? :))))
> > > >>>>>>
> > > >>>>>> Android runs on smallish systems, so quite possibly not!
> > > >>>>>>
> > > >>>>> We keep it enabled and never unexpedite it. The reason is a performance.  I
> > > >>>>> have done some app-launch time analysis with enabling and disabling of it.
> > > >>>>>
> > > >>>>> An expedited case is much better when it comes to app launch time. It
> > > >>>>> requires ~25% less time to run an app comparing with unexpedited variant.
> > > >>>>> So we have a big gain here.
> > > >>>>
> > > >>>> Wow, that's huge. I wonder if you can dig deeper and find out why that is so
> > > >>>> as the callbacks may need to be synchronize_rcu_expedited() then, as it could
> > > >>>> be slowing down other usecases! I find it hard to believe, real-time
> > > >>>> workloads will run better without those callbacks being always-expedited if
> > > >>>> it actually gives back 25% in performance!
> > > >>>>
> > > >>> I can dig further, but on a high level i think there are some spots
> > > >>> which show better performance if expedited is set. I mean synchronize_rcu()
> > > >>> becomes as "less blocking a context" from a time point of view.
> > > >>>
> > > >>> The problem of a regular synchronize_rcu() is - it can trigger a big latency
> > > >>> delays for a caller. For example for nocb case we do not know where in a list
> > > >>> our callback is located and when it is invoked to unblock a caller.
> > > >>
> > > >> True, expedited RCU grace periods do not have this callback-invocation
> > > >> delay that normal RCU does.
> > > >>
> > > >>> I have already mentioned somewhere. Probably it makes sense to directly wake-up
> > > >>> callers from the GP kthread instead and not via nocb-kthread that invokes our callbacks
> > > >>> one by one.
> > > >>
> > > >> Makes sense, but it is necessary to be careful.  Wakeups are not fast,
> > > >> so making the RCU grace-period kthread do them all sequentially is not
> > > >> a strategy to win.  For example, note that the next expedited grace
> > > >> period can start before the previous expedited grace period has finished
> > > >> its wakeups.
> > > >>
> > > > I hove done a small and quick prototype:
> > > >
> > > > <snip>
> > > > diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
> > > > index 699b938358bf..e1a4cca9a208 100644
> > > > --- a/include/linux/rcupdate_wait.h
> > > > +++ b/include/linux/rcupdate_wait.h
> > > > @@ -9,6 +9,8 @@
> > > > #include <linux/rcupdate.h>
> > > > #include <linux/completion.h>
> > > >
> > > > +extern struct llist_head gp_wait_llist;
> > > > +
> > > > /*
> > > >  * Structure allowing asynchronous waiting on RCU.
> > > >  */
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index ee27a03d7576..50b81ca54104 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -113,6 +113,9 @@ int rcu_num_lvls __read_mostly = RCU_NUM_LVLS;
> > > > int num_rcu_lvl[] = NUM_RCU_LVL_INIT;
> > > > int rcu_num_nodes __read_mostly = NUM_RCU_NODES; /* Total # rcu_nodes in use. */
> > > >
> > > > +/* Waiters for a GP kthread. */
> > > > +LLIST_HEAD(gp_wait_llist);
> > > > +
> > > > /*
> > > >  * The rcu_scheduler_active variable is initialized to the value
> > > >  * RCU_SCHEDULER_INACTIVE and transitions RCU_SCHEDULER_INIT just before the
> > > > @@ -1776,6 +1779,14 @@ static noinline void rcu_gp_cleanup(void)
> > > >                on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
> > > > }
> > > >
> > > > +static void rcu_notify_gp_end(struct llist_node *llist)
> > > > +{
> > > > +       struct llist_node *rcu, *next;
> > > > +
> > > > +       llist_for_each_safe(rcu, next, llist)
> > > > +               complete(&((struct rcu_synchronize *) rcu)->completion);
> > >
> > > This looks broken to me, so the synchronize will complete even
> > > if it was called in the middle of an ongoing GP?
> > >
> > Do you mean before replacing the list(and after rcu_gp_cleanup()) a new
> > GP sequence can be initiated?
> 
> It looks interesting, I am happy to try it on ChromeOS once you
> provide a patch, in case it improves something, even if that is
> suspend or boot time.
> 
> I think the main concern I had was if you did not wait for a full
> grace period (which as you indicated, you would fix), you are not
> really measuring the long delays that the full grace period can cause
> so IMHO it is important to only measure once correctness is preserved
> by the modification.  To that end, perhaps having rcutorture pass with
> your modification could be a vote of confidence before proceeding to
> performance tests.
> 
No problem. Please note it is just a proof of concept. Here we go:

<snip>
diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
index 699b938358bf..e1a4cca9a208 100644
--- a/include/linux/rcupdate_wait.h
+++ b/include/linux/rcupdate_wait.h
@@ -9,6 +9,8 @@
 #include <linux/rcupdate.h>
 #include <linux/completion.h>
 
+extern struct llist_head gp_wait_llist;
+
 /*
  * Structure allowing asynchronous waiting on RCU.
  */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ee27a03d7576..a35b779471eb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -113,6 +113,9 @@ int rcu_num_lvls __read_mostly = RCU_NUM_LVLS;
 int num_rcu_lvl[] = NUM_RCU_LVL_INIT;
 int rcu_num_nodes __read_mostly = NUM_RCU_NODES; /* Total # rcu_nodes in use. */
 
+/* Waiters for a GP kthread. */
+LLIST_HEAD(gp_wait_llist);
+
 /*
  * The rcu_scheduler_active variable is initialized to the value
  * RCU_SCHEDULER_INACTIVE and transitions RCU_SCHEDULER_INIT just before the
@@ -1383,7 +1386,7 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
 /*
  * Initialize a new grace period.  Return false if no grace period required.
  */
-static noinline_for_stack bool rcu_gp_init(void)
+static noinline_for_stack bool rcu_gp_init(struct llist_node **wait_list)
 {
 	unsigned long flags;
 	unsigned long oldmask;
@@ -1409,6 +1412,12 @@ static noinline_for_stack bool rcu_gp_init(void)
 		return false;
 	}
 
+	/*
+	 * Snapshot callers of synchronize_rcu() for which
+	 * we guarantee a full grace period to be passed.
+	 */
+	*wait_list = llist_del_all(&gp_wait_llist);
+
 	/* Advance to a new grace period and initialize state. */
 	record_gp_stall_check_time();
 	/* Record GP times before starting GP, hence rcu_seq_start(). */
@@ -1776,11 +1785,27 @@ static noinline void rcu_gp_cleanup(void)
 		on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
 }
 
+static void rcu_notify_gp_end(struct llist_node *llist)
+{
+	struct llist_node *rcu, *next;
+	int n = 0;
+
+	llist_for_each_safe(rcu, next, llist) {
+		complete(&((struct rcu_synchronize *) rcu)->completion);
+		n++;
+	}
+
+	if (n)
+		trace_printk("Awoken %d users.\n", n);
+}
+
 /*
  * Body of kthread that handles grace periods.
  */
 static int __noreturn rcu_gp_kthread(void *unused)
 {
+	struct llist_node *wait_list;
+
 	rcu_bind_gp_kthread();
 	for (;;) {
 
@@ -1795,7 +1820,7 @@ static int __noreturn rcu_gp_kthread(void *unused)
 			rcu_gp_torture_wait();
 			WRITE_ONCE(rcu_state.gp_state, RCU_GP_DONE_GPS);
 			/* Locking provides needed memory barrier. */
-			if (rcu_gp_init())
+			if (rcu_gp_init(&wait_list))
 				break;
 			cond_resched_tasks_rcu_qs();
 			WRITE_ONCE(rcu_state.gp_activity, jiffies);
@@ -1811,6 +1836,9 @@ static int __noreturn rcu_gp_kthread(void *unused)
 		WRITE_ONCE(rcu_state.gp_state, RCU_GP_CLEANUP);
 		rcu_gp_cleanup();
 		WRITE_ONCE(rcu_state.gp_state, RCU_GP_CLEANED);
+
+		/* Wake-app synchronize_rcu() users. */
+		rcu_notify_gp_end(wait_list);
 	}
 }
 
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 19bf6fa3ee6a..483997edd58e 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -426,7 +426,10 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
 		if (j == i) {
 			init_rcu_head_on_stack(&rs_array[i].head);
 			init_completion(&rs_array[i].completion);
-			(crcu_array[i])(&rs_array[i].head, wakeme_after_rcu);
+			llist_add((struct llist_node *) &rs_array[i].head, &gp_wait_llist);
+
+			/* Kick a grace period if needed. */
+			(void) start_poll_synchronize_rcu();
 		}
 	}
<snip> 

i do not think that it improves your boot time. My concern and what i
would like to fix is:

<snip>
           <...>-29      [001] d..1. 21950.145313: rcu_batch_start: rcu_preempt CBs=3613 bl=28
...
           <...>-29      [001] ..... 21950.152578: rcu_invoke_callback: rcu_preempt rhp=00000000b2d6dee8 func=__free_vm_area_struct.cfi_jt
           <...>-29      [001] ..... 21950.152579: rcu_invoke_callback: rcu_preempt rhp=00000000a446f607 func=__free_vm_area_struct.cfi_jt
           <...>-29      [001] ..... 21950.152580: rcu_invoke_callback: rcu_preempt rhp=00000000a5cab03b func=__free_vm_area_struct.cfi_jt
           <...>-29      [001] ..... 21950.152581: rcu_invoke_callback: rcu_preempt rhp=0000000013b7e5ee func=__free_vm_area_struct.cfi_jt
           <...>-29      [001] ..... 21950.152582: rcu_invoke_callback: rcu_preempt rhp=000000000a8ca6f9 func=__free_vm_area_struct.cfi_jt
           <...>-29      [001] ..... 21950.152583: rcu_invoke_callback: rcu_preempt rhp=000000008f162ca8 func=wakeme_after_rcu.cfi_jt
           <...>-29      [001] d..1. 21950.152625: rcu_batch_end: rcu_preempt CBs-invoked=3612 idle=....
<snip>

i grabbed that good example(our phone device) where a user of synchronize_rcu() is "un-blocked" 
as last since its callback was the last in a list.

--
Uladzislau Rezki
