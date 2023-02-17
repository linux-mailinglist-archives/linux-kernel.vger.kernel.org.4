Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238E769A633
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 08:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBQHmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 02:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBQHmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 02:42:14 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF00359C9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 23:42:12 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id ez12so1029509edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 23:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hh/eaKeFdPRF86ASmVSQKSQfIBYS8r04eyNx0ttbKF0=;
        b=A/fTvINNtr8IJJzKxAqSVUOiZZmrE1A7FR/li/EWdL7Z+NyvwBsTffOboueOaf7qTo
         kR7zEo5ijoYTyUbge6Isr6xyCcwDUQaNzlJ6B2lONtnD7FzFD/fPgA/58cpul/SsswQ3
         SZDzEGaAi4hCY/6LMeOq6w20A9lpaotplj7Nw/w0935aqVQ7E4ZCSWvnPKhChicEHNoN
         Zp0HYCAwMXyYNGSu+JO3uGNJ3Z04NRtqBKyv6+j8zimCjSOqx1hP3dHHLSzSsVhGewJM
         O3Oi7WDYl3ZdUtB7zZL/ihYwMAn37nSEsSDlRLYgFpJDvOT6/IFegEPCrMmbt6oxwrAz
         Z/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hh/eaKeFdPRF86ASmVSQKSQfIBYS8r04eyNx0ttbKF0=;
        b=v06pZS4Mc3JusVAeSALWO9/gd62fdURD7dECo6bytfO13vkAivIpTuddsvviP7Tcfa
         tIKW6P8LA80gBTyCSKVbRBMff8GhZWv7T4bjH9VczVampEc25DaGnQE5In1cBxK4jHwg
         Iocuo0Ax1xveIZQVhd/dNXXjNQhsGdeAUn5FUVFbR7pHI0cc+JdnQCVJLRNSDRNN83bu
         DXe+CgI0egmd8W8kmT5OjVJG2NdKXDLUYz1cmrY7glYaBNAdv+tchtl1KBdEowYBwonW
         lDjVUlm2d8mGgm3e9TNh05iyw6nfQamt6MKEyxU6bNgG+vs+NztUQd7ogfpmprWFenOj
         e5bw==
X-Gm-Message-State: AO0yUKV2vqJuQnz9rew4EsX2MLLEO4j55IuANmYOIvsG7S5FcAPuI/cr
        wphv30unxp1irQqyZx+k+KU=
X-Google-Smtp-Source: AK7set+crRhpQ3blZ7RVVTVc8Ps+0gaCdOMtlHgA10Vw5hT8OwQkAw+miqel1QIEyB0wQlST9NKfjA==
X-Received: by 2002:a17:906:7950:b0:87b:f7dd:792f with SMTP id l16-20020a170906795000b0087bf7dd792fmr5320377ejo.8.1676619731133;
        Thu, 16 Feb 2023 23:42:11 -0800 (PST)
Received: from gmail.com (1F2EF163.nat.pool.telekom.hu. [31.46.241.99])
        by smtp.gmail.com with ESMTPSA id x22-20020a1709064a9600b007bff9fb211fsm1781404eju.57.2023.02.16.23.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 23:42:10 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 17 Feb 2023 08:42:08 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [GIT PULL] scheduler fixes
Message-ID: <Y+8v0JG8DvedQISA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2023-02-17

   # HEAD: c2dbe32d5db5c4ead121cf86dabd5ab691fb47fe sched/psi: Fix use-after-free in ep_remove_wait_queue()

Misc scheduler fixes:

 - Fix user-after-free bug in call_usermodehelper_exec()
 - Fix missing user_cpus_ptr update in __set_cpus_allowed_ptr_locked()
 - Fix PSI use-after-free bug in ep_remove_wait_queue()

 Thanks,

	Ingo

------------------>
Munehisa Kamata (1):
      sched/psi: Fix use-after-free in ep_remove_wait_queue()

Peter Zijlstra (1):
      freezer,umh: Fix call_usermode_helper_exec() vs SIGKILL

Waiman Long (1):
      sched/core: Fix a missed update of user_cpus_ptr


 kernel/sched/core.c |  5 ++++-
 kernel/sched/psi.c  |  7 ++++---
 kernel/umh.c        | 20 +++++++++++++-------
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e838feb6adc5..2a4918a1faa9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2951,8 +2951,11 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 	}
 
 	if (!(ctx->flags & SCA_MIGRATE_ENABLE)) {
-		if (cpumask_equal(&p->cpus_mask, ctx->new_mask))
+		if (cpumask_equal(&p->cpus_mask, ctx->new_mask)) {
+			if (ctx->flags & SCA_USER)
+				swap(p->user_cpus_ptr, ctx->user_mask);
 			goto out;
+		}
 
 		if (WARN_ON_ONCE(p == current &&
 				 is_migration_disabled(p) &&
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 8ac8b81bfee6..02e011cabe91 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1343,10 +1343,11 @@ void psi_trigger_destroy(struct psi_trigger *t)
 
 	group = t->group;
 	/*
-	 * Wakeup waiters to stop polling. Can happen if cgroup is deleted
-	 * from under a polling process.
+	 * Wakeup waiters to stop polling and clear the queue to prevent it from
+	 * being accessed later. Can happen if cgroup is deleted from under a
+	 * polling process.
 	 */
-	wake_up_interruptible(&t->event_wait);
+	wake_up_pollfree(&t->event_wait);
 
 	mutex_lock(&group->trigger_lock);
 
diff --git a/kernel/umh.c b/kernel/umh.c
index 850631518665..fbf872c624cb 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -438,21 +438,27 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
 	if (wait == UMH_NO_WAIT)	/* task has freed sub_info */
 		goto unlock;
 
-	if (wait & UMH_KILLABLE)
-		state |= TASK_KILLABLE;
-
 	if (wait & UMH_FREEZABLE)
 		state |= TASK_FREEZABLE;
 
-	retval = wait_for_completion_state(&done, state);
-	if (!retval)
-		goto wait_done;
-
 	if (wait & UMH_KILLABLE) {
+		retval = wait_for_completion_state(&done, state | TASK_KILLABLE);
+		if (!retval)
+			goto wait_done;
+
 		/* umh_complete() will see NULL and free sub_info */
 		if (xchg(&sub_info->complete, NULL))
 			goto unlock;
+
+		/*
+		 * fallthrough; in case of -ERESTARTSYS now do uninterruptible
+		 * wait_for_completion_state(). Since umh_complete() shall call
+		 * complete() in a moment if xchg() above returned NULL, this
+		 * uninterruptible wait_for_completion_state() will not block
+		 * SIGKILL'ed processes for long.
+		 */
 	}
+	wait_for_completion_state(&done, state);
 
 wait_done:
 	retval = sub_info->retval;
