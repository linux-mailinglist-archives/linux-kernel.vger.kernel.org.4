Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685B06C270C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 02:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjCUBLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 21:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjCUBLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:11:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B07E3865B;
        Mon, 20 Mar 2023 18:10:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9FB25CE16A5;
        Tue, 21 Mar 2023 01:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11770C4339B;
        Tue, 21 Mar 2023 01:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360903;
        bh=GQT3gDb5XSFR5fOAsmb3ioMfC+QJKP06+f3R9XWhiU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VaO4sSXV0wrW+9eNJfLw7JHjKSUv2W8ayl47jAoR9bVdHQGqyZIDC/x11VY2RFWeL
         On9TikIC3WwSCf49SP2OEusVbQ85pcMjGjxmKr/9GZnZj2z8vyliu8xat3oYX5Dqxa
         0clvitewlvnFopnR3Xkn2O2LmEB9qh5kME/t4bxj4HBt3Msd73pNqQTYhYF9N4jUei
         bCwXW6pPTkfS5Q1TX6BBmVKXm8R5pa5NFI0w2DhTjPmMoL2OuhsljAGbKzgMUHwg1/
         5juATx2ihWtV1q6E2gwdHMTftJcwJBEbtRpnh2OkDpYSZxqykItl3q7SOyIW8+YpLh
         xF2do8tbX2vWQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AEB1F154039A; Mon, 20 Mar 2023 18:08:22 -0700 (PDT)
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
Subject: [PATCH locktorture 2/5] locktorture: Add nested locking to mutex torture tests
Date:   Mon, 20 Mar 2023 18:08:18 -0700
Message-Id: <20230321010821.51601-2-paulmck@kernel.org>
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

This patch adds randomized nested locking to the mutex torture
tests, as well as new LOCK08 config files for testing mutexes
with nested locking

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
 .../selftests/rcutorture/configs/lock/LOCK08  |  6 ++++
 .../rcutorture/configs/lock/LOCK08.boot       |  1 +
 4 files changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/lock/LOCK08
 create mode 100644 tools/testing/selftests/rcutorture/configs/lock/LOCK08.boot

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index a8519af25ece..a4d15a9a9d7f 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -370,6 +370,28 @@ static struct lock_torture_ops rw_lock_irq_ops = {
 };
 
 static DEFINE_MUTEX(torture_mutex);
+static struct mutex torture_nested_mutexes[MAX_NESTED_LOCKS];
+static struct lock_class_key nested_mutex_keys[MAX_NESTED_LOCKS];
+
+static void torture_mutex_init(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_NESTED_LOCKS; i++)
+		__mutex_init(&torture_nested_mutexes[i], __func__,
+			     &nested_mutex_keys[i]);
+}
+
+static int torture_mutex_nested_lock(int tid __maybe_unused,
+				     u32 lockset)
+{
+	int i;
+
+	for (i = 0; i < nested_locks; i++)
+		if (lockset & (1 << i))
+			mutex_lock(&torture_nested_mutexes[i]);
+	return 0;
+}
 
 static int torture_mutex_lock(int tid __maybe_unused)
 __acquires(torture_mutex)
@@ -398,11 +420,24 @@ __releases(torture_mutex)
 	mutex_unlock(&torture_mutex);
 }
 
+static void torture_mutex_nested_unlock(int tid __maybe_unused,
+					u32 lockset)
+{
+	int i;
+
+	for (i = nested_locks - 1; i >= 0; i--)
+		if (lockset & (1 << i))
+			mutex_unlock(&torture_nested_mutexes[i]);
+}
+
 static struct lock_torture_ops mutex_lock_ops = {
+	.init		= torture_mutex_init,
+	.nested_lock	= torture_mutex_nested_lock,
 	.writelock	= torture_mutex_lock,
 	.write_delay	= torture_mutex_delay,
 	.task_boost     = torture_rt_boost,
 	.writeunlock	= torture_mutex_unlock,
+	.nested_unlock	= torture_mutex_nested_unlock,
 	.readlock       = NULL,
 	.read_delay     = NULL,
 	.readunlock     = NULL,
diff --git a/tools/testing/selftests/rcutorture/configs/lock/CFLIST b/tools/testing/selftests/rcutorture/configs/lock/CFLIST
index 41bae5824339..a48bba0d35a6 100644
--- a/tools/testing/selftests/rcutorture/configs/lock/CFLIST
+++ b/tools/testing/selftests/rcutorture/configs/lock/CFLIST
@@ -5,3 +5,4 @@ LOCK04
 LOCK05
 LOCK06
 LOCK07
+LOCK08
diff --git a/tools/testing/selftests/rcutorture/configs/lock/LOCK08 b/tools/testing/selftests/rcutorture/configs/lock/LOCK08
new file mode 100644
index 000000000000..1d1da1477fc3
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/lock/LOCK08
@@ -0,0 +1,6 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=4
+CONFIG_HOTPLUG_CPU=y
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
diff --git a/tools/testing/selftests/rcutorture/configs/lock/LOCK08.boot b/tools/testing/selftests/rcutorture/configs/lock/LOCK08.boot
new file mode 100644
index 000000000000..b8b6caebb89e
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/lock/LOCK08.boot
@@ -0,0 +1 @@
+locktorture.torture_type=mutex_lock locktorture.nested_locks=8
-- 
2.40.0.rc2

