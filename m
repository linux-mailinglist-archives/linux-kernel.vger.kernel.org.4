Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F21A68A356
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 21:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbjBCUBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 15:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjBCUBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 15:01:43 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D2DA6C07
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 12:01:42 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id z7-20020aa79587000000b00593f19705d5so3207440pfj.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 12:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JqXBZCshocKpxm4gEZMlbqbtIQK38/N6xcknjdoOafE=;
        b=KPkJ1C/qL+FzGJYKo7gZ9K8p9Rgy19fakC/0EXy5pbZ9pd7P+QiTu0iD0dhI9UbSJE
         ug9LrnGhUIFtdtwIQyckSPbuQQe3jbw9Oy21pU+za+tjCpzjDq73hVOchBdcN8PCAmAl
         0NnMek0tb/OU0RvhfHWeFcOJFawcLGLO6fO5Rfq87athdWEN4bAChRYsL/ETwxqRQGyd
         IE7CYS156co+zXWT9O+hzT1mhN2LlMFYOVuwTia/t5apG1VfKGhqHH7RPEs3uhotz9ry
         x1RHZAI3i6wb4BpMmyDiepFohU0aMUssXeL10kjpkWU9e2cXoF49WhvcmpysMm1/+eK+
         kR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JqXBZCshocKpxm4gEZMlbqbtIQK38/N6xcknjdoOafE=;
        b=4fl4VMtzNvkDShE82fMYsgtH7hnp/7katEPTc+cVqft8htTMEYbnrPEYda289l8fVp
         UvdhgO62OpWtLmOU+k9Lxiy3GU3MzQt4MVf9rAE2Tbw9nym4JJkRWeyx3pZQm1NDgyfP
         AnHjKHP2ITrv4NCEYXe6sFgDoPYzKHYCdUSHyiyrYUA3mUCgXdFwprSdWTZqrC/AHBbQ
         y4FmkoOIQBlvSeyQKevGSrGOa3D3xEcMhaWWoAM7mWlD3Ib7K/uqfSt8k9y9T83satfJ
         opXNOpWxBmT2G49yrWu15cbfNOrpIsi56YlDYeg7z/r/AUlCTd52ST41g8OZbNzPPg9q
         BIIQ==
X-Gm-Message-State: AO0yUKUUWmh+ewpumVop5yAkx/tD06xzKvIdR37GMjsxeccEpVjZ3UEO
        hX3yCFemvAWO1sES89SRrS9r79x3oSZKohrF25nNF4sJUa3r2q3MxnBxWJhbNj9VYKi2ooHgbXh
        s56RWxHgHAp6+1O1QsNeC8kw1qQ8sRG6AcoH4bp6FwIOXJYIP7naweau1kcrNP64AfjQdat0=
X-Google-Smtp-Source: AK7set8JPnZxVFCHbB1AGGUevN9knwDSex9toGJJvf4HG1+oZw8YNgPoQrhwBtORgREelhgPERfgo3LM8er1
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:8649:b0:194:706a:ad18 with SMTP id
 y9-20020a170902864900b00194706aad18mr2662260plt.18.1675454501477; Fri, 03 Feb
 2023 12:01:41 -0800 (PST)
Date:   Fri,  3 Feb 2023 20:01:35 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230203200138.3872873-1-jstultz@google.com>
Subject: [PATCH v2 1/4] locktorture: Add nested_[un]lock() hooks and nlocks parameter
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order ot extend locktorture to support lock nesting, add
nested_lock() and nested_unlock() hooks to the torture ops.

These take a 32bit lockset mask which is generated at random,
so some number of locks will be taken before the main lock is
taken and released afterwards.

Additionally, add nlocks module parameter to allow specifying
the number of nested locks to be used.

This has been helpful to uncover issues in the proxy-exec
series development.

This was inspired by locktorture extensions originally implemented
by Connor O'Brien, for stress testing the proxy-execution series:
  https://lore.kernel.org/lkml/20221003214501.2050087-12-connoro@google.com/

Comments or feedback would be greatly appreciated!

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/locking/locktorture.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 9c2fb613a55d..f4fbd3194654 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -48,6 +48,9 @@ torture_param(int, stat_interval, 60,
 torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
 torture_param(int, verbose, 1,
 	     "Enable verbose debugging printk()s");
+torture_param(int, nlocks, 0, "Number of nested locks");
+/* Going much higher trips "BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!" errors */
+#define MAX_LOCKS 8
 
 static char *torture_type = "spin_lock";
 module_param(torture_type, charp, 0444);
@@ -76,10 +79,12 @@ static void lock_torture_cleanup(void);
 struct lock_torture_ops {
 	void (*init)(void);
 	void (*exit)(void);
+	int (*nested_lock)(int tid, u32 lockset);
 	int (*writelock)(int tid);
 	void (*write_delay)(struct torture_random_state *trsp);
 	void (*task_boost)(struct torture_random_state *trsp);
 	void (*writeunlock)(int tid);
+	void (*nested_unlock)(int tid, u32 lockset);
 	int (*readlock)(int tid);
 	void (*read_delay)(struct torture_random_state *trsp);
 	void (*readunlock)(int tid);
@@ -669,6 +674,7 @@ static int lock_torture_writer(void *arg)
 	struct lock_stress_stats *lwsp = arg;
 	int tid = lwsp - cxt.lwsa;
 	DEFINE_TORTURE_RANDOM(rand);
+	u32 lockset_mask;
 
 	VERBOSE_TOROUT_STRING("lock_torture_writer task started");
 	set_user_nice(current, MAX_NICE);
@@ -677,7 +683,10 @@ static int lock_torture_writer(void *arg)
 		if ((torture_random(&rand) & 0xfffff) == 0)
 			schedule_timeout_uninterruptible(1);
 
+		lockset_mask = torture_random(&rand);
 		cxt.cur_ops->task_boost(&rand);
+		if (cxt.cur_ops->nested_lock)
+			cxt.cur_ops->nested_lock(tid, lockset_mask);
 		cxt.cur_ops->writelock(tid);
 		if (WARN_ON_ONCE(lock_is_write_held))
 			lwsp->n_lock_fail++;
@@ -690,6 +699,8 @@ static int lock_torture_writer(void *arg)
 		lock_is_write_held = false;
 		WRITE_ONCE(last_lock_release, jiffies);
 		cxt.cur_ops->writeunlock(tid);
+		if (cxt.cur_ops->nested_unlock)
+			cxt.cur_ops->nested_unlock(tid, lockset_mask);
 
 		stutter_wait("lock_torture_writer");
 	} while (!torture_must_stop());
@@ -830,11 +841,11 @@ lock_torture_print_module_parms(struct lock_torture_ops *cur_ops,
 				const char *tag)
 {
 	pr_alert("%s" TORTURE_FLAG
-		 "--- %s%s: nwriters_stress=%d nreaders_stress=%d stat_interval=%d verbose=%d shuffle_interval=%d stutter=%d shutdown_secs=%d onoff_interval=%d onoff_holdoff=%d\n",
+		 "--- %s%s: nwriters_stress=%d nreaders_stress=%d nlocks=%d stat_interval=%d verbose=%d shuffle_interval=%d stutter=%d shutdown_secs=%d onoff_interval=%d onoff_holdoff=%d\n",
 		 torture_type, tag, cxt.debug_lock ? " [debug]": "",
-		 cxt.nrealwriters_stress, cxt.nrealreaders_stress, stat_interval,
-		 verbose, shuffle_interval, stutter, shutdown_secs,
-		 onoff_interval, onoff_holdoff);
+		 cxt.nrealwriters_stress, cxt.nrealreaders_stress, nlocks,
+		 stat_interval, verbose, shuffle_interval, stutter,
+		 shutdown_secs, onoff_interval, onoff_holdoff);
 }
 
 static void lock_torture_cleanup(void)
@@ -1053,6 +1064,10 @@ static int __init lock_torture_init(void)
 		}
 	}
 
+	/* cap nlocks to MAX_LOCKS */
+	if (nlocks > MAX_LOCKS)
+		nlocks = MAX_LOCKS;
+
 	if (cxt.cur_ops->readlock) {
 		reader_tasks = kcalloc(cxt.nrealreaders_stress,
 				       sizeof(reader_tasks[0]),
-- 
2.39.1.519.gcb327c4b5f-goog

