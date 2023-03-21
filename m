Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E766C2709
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 02:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjCUBLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 21:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjCUBKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:10:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3A5303E1;
        Mon, 20 Mar 2023 18:09:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EEBADCE172D;
        Tue, 21 Mar 2023 01:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD9CC4339C;
        Tue, 21 Mar 2023 01:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360903;
        bh=nmmWRyJx/utTFv2HT/REPz5mLM19GLoGlHL5SEhyX9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uCABiA2Z4i8aENda//BSFshKfiNRR9VgDL4egA8isx1Ty5E4e7jk1XAnsJ1jQgTQ+
         Ztk7qpUFMfdqZHDhGQtZWtqS3AOgtDmmSzNBKixPFpY425ZjPIuTErDBCKxhm1G9tK
         V8qO1R8xkmm9Oj+irnPCe5R9dH0Upj0C6kZ7XRJ4sRVYvfjWpQsLZIyFRuJP6ovuJ/
         fMyci8awWVf/IBO8BjtQiVSRPoRKps8rL84WwPorQdNmtEpg4/NPQEsGzh90/rDphC
         n+GYxP7v+pyLzfCs0Gr+wueKQ1o9hsJAPMVelWgu3oGJh1ZSK59kqfzZjhhrA0wd3q
         R32XUrI5DfBlA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B2753154039B; Mon, 20 Mar 2023 18:08:22 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, John Stultz <jstultz@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        kernel-team@android.com, Connor O'Brien <connoro@google.com>
Subject: [PATCH locktorture 3/5] locktorture: Add nested locking to rtmutex torture tests
Date:   Mon, 20 Mar 2023 18:08:19 -0700
Message-Id: <20230321010821.51601-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <3679d2b2-bdb9-4fa3-8134-240a8d0f449b@paulmck-laptop>
References: <3679d2b2-bdb9-4fa3-8134-240a8d0f449b@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Stultz <jstultz@google.com>

This patch adds randomized nested locking to the rtmutex torture
tests. Additionally it adds LOCK09 config files for testing
rtmutexes with nested locking.

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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c                  | 35 +++++++++++++++++++
 .../selftests/rcutorture/configs/lock/CFLIST  |  1 +
 .../selftests/rcutorture/configs/lock/LOCK09  |  6 ++++
 .../rcutorture/configs/lock/LOCK09.boot       |  1 +
 4 files changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/lock/LOCK09
 create mode 100644 tools/testing/selftests/rcutorture/configs/lock/LOCK09.boot

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index a4d15a9a9d7f..c7f264aed5b7 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -544,6 +544,28 @@ static struct lock_torture_ops ww_mutex_lock_ops = {
 
 #ifdef CONFIG_RT_MUTEXES
 static DEFINE_RT_MUTEX(torture_rtmutex);
+static struct rt_mutex torture_nested_rtmutexes[MAX_NESTED_LOCKS];
+static struct lock_class_key nested_rtmutex_keys[MAX_NESTED_LOCKS];
+
+static void torture_rtmutex_init(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_NESTED_LOCKS; i++)
+		__rt_mutex_init(&torture_nested_rtmutexes[i], __func__,
+				&nested_rtmutex_keys[i]);
+}
+
+static int torture_rtmutex_nested_lock(int tid __maybe_unused,
+				       u32 lockset)
+{
+	int i;
+
+	for (i = 0; i < nested_locks; i++)
+		if (lockset & (1 << i))
+			rt_mutex_lock(&torture_nested_rtmutexes[i]);
+	return 0;
+}
 
 static int torture_rtmutex_lock(int tid __maybe_unused)
 __acquires(torture_rtmutex)
@@ -585,11 +607,24 @@ static void torture_rt_boost_rtmutex(struct torture_random_state *trsp)
 	__torture_rt_boost(trsp);
 }
 
+static void torture_rtmutex_nested_unlock(int tid __maybe_unused,
+					  u32 lockset)
+{
+	int i;
+
+	for (i = nested_locks - 1; i >= 0; i--)
+		if (lockset & (1 << i))
+			rt_mutex_unlock(&torture_nested_rtmutexes[i]);
+}
+
 static struct lock_torture_ops rtmutex_lock_ops = {
+	.init		= torture_rtmutex_init,
+	.nested_lock	= torture_rtmutex_nested_lock,
 	.writelock	= torture_rtmutex_lock,
 	.write_delay	= torture_rtmutex_delay,
 	.task_boost     = torture_rt_boost_rtmutex,
 	.writeunlock	= torture_rtmutex_unlock,
+	.nested_unlock	= torture_rtmutex_nested_unlock,
 	.readlock       = NULL,
 	.read_delay     = NULL,
 	.readunlock     = NULL,
diff --git a/tools/testing/selftests/rcutorture/configs/lock/CFLIST b/tools/testing/selftests/rcutorture/configs/lock/CFLIST
index a48bba0d35a6..28e23d05d5a5 100644
--- a/tools/testing/selftests/rcutorture/configs/lock/CFLIST
+++ b/tools/testing/selftests/rcutorture/configs/lock/CFLIST
@@ -6,3 +6,4 @@ LOCK05
 LOCK06
 LOCK07
 LOCK08
+LOCK09
diff --git a/tools/testing/selftests/rcutorture/configs/lock/LOCK09 b/tools/testing/selftests/rcutorture/configs/lock/LOCK09
new file mode 100644
index 000000000000..1d1da1477fc3
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/lock/LOCK09
@@ -0,0 +1,6 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=4
+CONFIG_HOTPLUG_CPU=y
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
diff --git a/tools/testing/selftests/rcutorture/configs/lock/LOCK09.boot b/tools/testing/selftests/rcutorture/configs/lock/LOCK09.boot
new file mode 100644
index 000000000000..fd5eff148a93
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/lock/LOCK09.boot
@@ -0,0 +1 @@
+locktorture.torture_type=rtmutex_lock locktorture.nested_locks=8
-- 
2.40.0.rc2

