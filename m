Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4267169E7FA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjBUTCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjBUTCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:02:47 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C422D16F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:02:46 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id w7-20020a170902e88700b0019ca50c7fa3so343613plg.23
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+PDdG/xsbruylMts3CB20c9cAMQAh0JCYl5tHB8A4B0=;
        b=n1VEkquQlwo0RUie1ys+LnHyXx+2/hsc+JHa+ftOmW1u9L5D+p6agkVv9tqb/4EHjz
         /uktewL/nYsEHn5BGvMvLf9Ef4q119Pxo1acUv37JmEEzQi27pyGT9m0fk9dD+vQShUP
         Y/sXl1bF1sQ+9GXEKk/n1p6szq1ZEd+RfnDTUSLHLq5r/RsWAVPdapsoWhDQy1dPrvbb
         ZY4xehHFfgYOdutOILSx5z9zJ4PK2IgLJdgzp6GnmEK302uwJJcA7XqnJsNQdztqUcPj
         G7elixIbzuw5DEWS5JGNsHPkwSHXvTPkqVpT/eVIQ20TANqDcpQ1OqLDyixny+qnwgiX
         1z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PDdG/xsbruylMts3CB20c9cAMQAh0JCYl5tHB8A4B0=;
        b=7nM2zDtOa090jpyBNoETJLUy2QtSe4mtMaLgNwxWwVbnmWTmfl1cKMDJ58LzIAPxow
         p6wH3qG8YDABvhva9JgJf8p8T6SPVvR+pAHBdIK9tgJzFBpsNZueeCNdaocaxjnmUD7C
         SzXpS6nYLPT7VfBcw6pGhqJEgy3hiAG39yRhs09bQIDe/dlJX26O48iQKODKep+SEbS3
         Q/ji7vZjFc+54lCJII6GXzxUQVEpqcnbpXRHzNbNufuni56ko/X0NIOpboWKUP2q7+ze
         K18LDmM5XME6bXiwgP5pmtw5cRZTRM8tu1kaD0Dj5eXAnYdUJSIRU75JBc8JM2ZPpEDO
         cRrg==
X-Gm-Message-State: AO0yUKXLACxxoD84jycQ3sHq2tR60LK1TSi0dD8XhXTRl7M3OMfUa5st
        aMJmuVlbeU6RTu/gJvPGCBaFtTGjrn+gYURsxQCqVGz8JcOl0kfTGAQbW+QX2jj6MuUUWt8YU8f
        nLrhFK5kYykKl09jQeabZyn4gvyU/7fBcUFl/IcUrky4JyTChKorZQGgI+BgNskXQ6mRuieI=
X-Google-Smtp-Source: AK7set9TKCCi6fP2g2F1rmnpTV7O0wdW+Wshhfmom8OzLYMp7clCC9QHzOU2SrNjlTxqxO1EE/I4kmjvR+Lf
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:aa7:9396:0:b0:592:5896:89cf with SMTP id
 t22-20020aa79396000000b00592589689cfmr724292pfe.0.1677006166032; Tue, 21 Feb
 2023 11:02:46 -0800 (PST)
Date:   Tue, 21 Feb 2023 19:02:37 +0000
In-Reply-To: <20230221190238.21285-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230221190238.21285-1-jstultz@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230221190238.21285-3-jstultz@google.com>
Subject: [PATCH v4 3/4] locktorture: Add nested locking to rtmutex torture tests
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
---
v2:
* Add LOCK09 config file suggested by Paul McKenney
v3:
* Minor commit message tweaks and naming changes
  suggested by Davidlohr Bueso
v4:
* Add co-developed tag
---
 kernel/locking/locktorture.c                  | 35 +++++++++++++++++++
 .../selftests/rcutorture/configs/lock/CFLIST  |  1 +
 .../selftests/rcutorture/configs/lock/LOCK09  |  6 ++++
 .../rcutorture/configs/lock/LOCK09.boot       |  1 +
 4 files changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/lock/LOCK09
 create mode 100644 tools/testing/selftests/rcutorture/configs/lock/LOCK09.boot

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 8a08c004aa80..fd8b2b007c26 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -506,6 +506,28 @@ static struct lock_torture_ops ww_mutex_lock_ops = {
 
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
@@ -570,11 +592,24 @@ __releases(torture_rtmutex)
 	rt_mutex_unlock(&torture_rtmutex);
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
 	.task_boost     = torture_rtmutex_boost,
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
2.39.2.637.g21b0678d19-goog

