Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58C669E7F8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjBUTCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBUTCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:02:47 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627BF2D15D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:02:43 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d7-20020a25adc7000000b00953ffdfbe1aso6092074ybe.23
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WwK53qS/jcR6/xM0LNfdTpR4NejvvarONLmagoE1yHA=;
        b=Rn8Q8/DRcejIDDnzupSaVh/xi9Z0bSnXaAVXNzvfTilsOMgsUxUKgTLlH+4MCiHikc
         4S56Z5kgYkZDJw3NFnr9mzRFquuoWagHJ4tTH7/1Pra5LDmBOrlqvKw1eRlFIUb4FYQE
         P5aBK2d7yQV34rVOcqvASAQ+DAOJR+0NzyfKBBfsn1a4YejHCbV/9br3x3nx5TUt0Hyb
         v7FOQm4XMFkiZXUMPXIbaTR0BlTNCP0d8TibphFWng8+7kP3qzwU2P+Gj2HuILJ/R/Vu
         njlyMz/Dks0m0SPQ+wjSbkG330jP5WjDXgWZ9gzEVM0urjNGYbMdQ0TdjMMXwmAxYZd/
         Ghsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WwK53qS/jcR6/xM0LNfdTpR4NejvvarONLmagoE1yHA=;
        b=wS452BdEapbRKhBvq3C6X+vTnYRiF2GH2yhhZ+5pFcuwVJ7uNzbRbnqPiheLUkdM/I
         EHXgSetn5cLtDNOU1jJamavVMwK4FtgGdvDyFgj1pgEkN9ChMD5lKqkpumgi5baXhb15
         9saSXlI19xfqxOTn8sWf4bWcleACj59y3svMwXSnvi0uU82cw7gDXXewmqpBbjhqyvX1
         aImmcB/RVEGaicrQAI537Bzu99uM5dVqKW/4u4mir6yfN7pxptOqEKGGo7m+wTu2CPUz
         Bf4q3Hgglm4KditJ08nhhH+9PcnKA73FpJwfIG9XQsGxxMauh84GsDjbU4ga/8BH49gq
         GPpQ==
X-Gm-Message-State: AO0yUKV0zzcg2yQ8TU7ZNvOoyQ8MsPnRVZeyOG8b4qgrE0D+GK3eiWxh
        XNsN6urfC5wYOwhwtPV0B+zHN8K/76Jr/h0R1vlzQo1+RtXuEn9lOQy9fwpjLFqom4ni2zbb1Ok
        2WKRMQrwzQLz4zxWCqzXg6ptZR3LLfaYOnBiHM+CjK0xOAb7IFOOJdrrxEKYGrLJc09TrLZ4=
X-Google-Smtp-Source: AK7set/eYV7Og0N63VAF7ppdTJht3ZyfssgE6mpqnJnsf2pPPPbKIPb07a+IPDPJplUJK1Hz+A1a3LGetMof
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:10ca:b0:9ed:13e9:fe68 with SMTP
 id w10-20020a05690210ca00b009ed13e9fe68mr551231ybu.3.1677006162586; Tue, 21
 Feb 2023 11:02:42 -0800 (PST)
Date:   Tue, 21 Feb 2023 19:02:35 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230221190238.21285-1-jstultz@google.com>
Subject: [PATCH v4 1/4] locktorture: Add nested_[un]lock() hooks and nlocks parameter
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        kernel-team@android.com, "Connor O'Brien" <connoro@google.com>
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

In order to extend locktorture to support lock nesting, add
nested_lock() and nested_unlock() hooks to the torture ops.

These take a 32bit lockset mask which is generated at random,
so some number of locks will be taken before the main lock is
taken and released afterwards.

Additionally, add nested_locks module parameter to allow
specifying the number of nested locks to be used.

This has been helpful to uncover issues in the proxy-exec
series development.

This was inspired by locktorture extensions originally implemented
by Connor O'Brien, for stress testing the proxy-execution series:
  https://lore.kernel.org/lkml/20221003214501.2050087-12-connoro@google.com/

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: kernel-team@android.com
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Co-developed-by: Connor O'Brien <connoro@google.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
v3:
* Minor commit message tweaks and naming changes
  suggested by Davidlohr Bueso
v4:
* Add co-developed tag
---
 kernel/locking/locktorture.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 9c2fb613a55d..6fe046594868 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -48,6 +48,9 @@ torture_param(int, stat_interval, 60,
 torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
 torture_param(int, verbose, 1,
 	     "Enable verbose debugging printk()s");
+torture_param(int, nested_locks, 0, "Number of nested locks (max = 8)");
+/* Going much higher trips "BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!" errors */
+#define MAX_NESTED_LOCKS 8
 
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
+		 "--- %s%s: nwriters_stress=%d nreaders_stress=%d nested_locks=%d stat_interval=%d verbose=%d shuffle_interval=%d stutter=%d shutdown_secs=%d onoff_interval=%d onoff_holdoff=%d\n",
 		 torture_type, tag, cxt.debug_lock ? " [debug]": "",
-		 cxt.nrealwriters_stress, cxt.nrealreaders_stress, stat_interval,
-		 verbose, shuffle_interval, stutter, shutdown_secs,
-		 onoff_interval, onoff_holdoff);
+		 cxt.nrealwriters_stress, cxt.nrealreaders_stress,
+		 nested_locks, stat_interval, verbose, shuffle_interval,
+		 stutter, shutdown_secs, onoff_interval, onoff_holdoff);
 }
 
 static void lock_torture_cleanup(void)
@@ -1053,6 +1064,10 @@ static int __init lock_torture_init(void)
 		}
 	}
 
+	/* cap nested_locks to MAX_NESTED_LOCKS */
+	if (nested_locks > MAX_NESTED_LOCKS)
+		nested_locks = MAX_NESTED_LOCKS;
+
 	if (cxt.cur_ops->readlock) {
 		reader_tasks = kcalloc(cxt.nrealreaders_stress,
 				       sizeof(reader_tasks[0]),
-- 
2.39.2.637.g21b0678d19-goog

