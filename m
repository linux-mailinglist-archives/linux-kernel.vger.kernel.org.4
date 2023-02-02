Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A463F6889D3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 23:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjBBWeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 17:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjBBWeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 17:34:15 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D5668AD4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 14:34:12 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id z9-20020a170902d54900b00196680ec8bbso1575385plf.16
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 14:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JqXBZCshocKpxm4gEZMlbqbtIQK38/N6xcknjdoOafE=;
        b=rtxJ+BeTJ2KGfEbZbbP4kOUdXR7t10eCA7N/6Qus1DybSK7fnJzApwwV+0M4y+1A7C
         QNE+jnNgMUEclDsYBGvrxLCJFp1efPe1N+3AruYpf1ePfHUDbH3USc2n7YDrQO52Z3yW
         S+vVueWtrBlQjeLj1foHFhrVTOUyeY48oR319ratj8r031ViZk6P6heXrazbE2XQKSQb
         d4TeNmyocCJmTUYe1n3PsuZBmUBRwiX9+dSvL6Gg8JysuDgdFFYev52/dVinOiLgxIK1
         O9ZT2V6B25uH8VmekIe1mqwmng5zEYHkW8F3ohP7EsyL+U04jVQhnye+GsGlW/0gHa4r
         P/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JqXBZCshocKpxm4gEZMlbqbtIQK38/N6xcknjdoOafE=;
        b=DYuTmLYWqcI0XQLdQuwZGDYpFW4DhW6gXRA1erievxgLHA3rHOISmEWGBSYWLASViU
         yEWa9ghmGYBED2yRTU3NxPX8OPVtL35e7Gq7H8oXwX0n7nfowePGYjRQNWKuBN8eplfA
         66wI/jzxoD0CIa/Ma/85mnM4J04TX+m7W56EZxovnmHLFfQuckfKpFtQ9L4NbRkOHd+d
         MlZSIcybbwRXUERoAjlFDvGuzbTswKJk+mtmJGKyqaAbEpJbKGq3vubv78QwEawb5Y+S
         ir3wBxYWm96hn6u+ZZ9iO/ajJO9hgskOhv433A89Bh32KLWEQ7nkx1jqtH67VZs0SiK1
         Hatg==
X-Gm-Message-State: AO0yUKV41oR792oIWb92ybC4xHIUoAjwkVRLPxRrRajnwqItHlJFw/oA
        B9e6mnIEsP9i+vUAx7IlGP4rbIpCYHKZprotj/+ErdQUQCr2NYv9wC7/BEzvDPKstcXdVkAiB1V
        J6AUKn/mpilNHF7LzbY72HemErhRXm0obhI6iIBYhcQOG68Pvsqjw2i+0FHqSxjWEQknI7N4=
X-Google-Smtp-Source: AK7set9jKY6SAJHs9HUfQdlzVmEnaQlEY3eJt6Tkj8jpF5UuaT0fCvdAqa8Wmr8aq9ApYypnuFwTUwiONgYq
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90a:3d04:b0:22c:7639:a926 with SMTP id
 h4-20020a17090a3d0400b0022c7639a926mr974784pjc.83.1675377252249; Thu, 02 Feb
 2023 14:34:12 -0800 (PST)
Date:   Thu,  2 Feb 2023 22:34:06 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230202223409.2812443-1-jstultz@google.com>
Subject: [RFC][PATCH 1/4] locktorture: Add nested_[un]lock() hooks and nlocks parameter
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

