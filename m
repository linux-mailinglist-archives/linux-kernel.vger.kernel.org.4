Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF5E69E7F9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjBUTCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBUTCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:02:47 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D762ED4C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:02:45 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id p14-20020a170902e74e00b0019ad833d8a4so2492596plf.15
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5cepCIHpaKzs52FKbEjggulKdfWjoWwYnrJ7V/VC8n0=;
        b=CDDNatyyioKxlkIW9KqEU0dbH7/bxu8/DiWfXuP7z+579D7+hKsC6II4rsZ1KFTnSm
         sXByQojJWGePA5fDSVReZQ8N0xe0qS9ijzqb7TOeRvv2/Q4lA6xojL5XY6EAsvWMzgRB
         qJ/aa5Nvaz48s6fgEYHkFd/VbFOYB8xw4wrfnn19xjoVq6VelozaZ9yX7jOe/KL8n11+
         leWmALz8cNgbtE9XQ/H87WhiHIKmRudv2O2x8bZC2n73XSPqMC8dVrQtNdCJw7OxSbQX
         HbLvlvBiT/uc+H4VKVOkIwCbdXRSAuXAnzrnADlo+dwvI3MvrXMxn+ZR3XXJCXZXR5cp
         5mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5cepCIHpaKzs52FKbEjggulKdfWjoWwYnrJ7V/VC8n0=;
        b=IgcKCO3iLjeLVEP1sQiNc3NIuf4d/fzxxZ0cGVp1u/oCeMh8CoMDwyKgC5NacmG6xT
         63UJlmmJ9ezoR0h1hObkp+e88tAfGVdIQC+g40xsr4IOfpVNt1dxF4t4I/465++fwK+D
         w/egqzGH3c4feSWhrWqdaQcOMojl7fEA5nEujcl5NyIcHKcJ4a/KCkdVainWy4mbnHHb
         y2KOhlPbfH/rXsCTcRU0EfxwIzHdmxNlT3K2zeu8srJS3O0jk+S1lOkkCTEoHVx2WKqq
         tH+Idye8NPZf9yfaEHw0Uy4yUheZu3jD6F+T+KyB0gQt1fkbvAEe9cAL5PdJnzT6iOhO
         mNFg==
X-Gm-Message-State: AO0yUKVkwVrFVF16uiPQCfM/NHv7gQm6556KhvCoMqpNctUbQbu3BKId
        +nKZCU5hd7DTtUHF7OLRKMu2O0NhOXZ10Uxg+WTb+1fwt7RJwxPNHBpUJwFCaxg4SAj/Ha9ymx5
        LvvUokg61pLHe3zvmD/eEcfaLcu9j3mL2Q2Rgp3pDl6IyJc8TG3AJx+IJWHOSw2NT0UqJCpI=
X-Google-Smtp-Source: AK7set+r3PY/QiWlAqpTDe0ew5xhxug9FSKx0R+/TpoKCfbOYJPlg3itgQH+aWIuoA35ePGmGpc3h+XS6or+
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:903:48e:b0:19a:f63a:47de with SMTP id
 jj14-20020a170903048e00b0019af63a47demr789500plb.7.1677006164331; Tue, 21 Feb
 2023 11:02:44 -0800 (PST)
Date:   Tue, 21 Feb 2023 19:02:36 +0000
In-Reply-To: <20230221190238.21285-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230221190238.21285-1-jstultz@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230221190238.21285-2-jstultz@google.com>
Subject: [PATCH v4 2/4] locktorture: Add nested locking to mutex torture tests
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
---
v2:
* Add LOCK08 config file suggested by Paul McKenney
v3:
* Minor commit message tweaks and naming changes
  suggested by Davidlohr Bueso
v4:
* Add co-developed tag
---
 kernel/locking/locktorture.c                  | 35 +++++++++++++++++++
 .../selftests/rcutorture/configs/lock/CFLIST  |  1 +
 .../selftests/rcutorture/configs/lock/LOCK08  |  6 ++++
 .../rcutorture/configs/lock/LOCK08.boot       |  1 +
 4 files changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/lock/LOCK08
 create mode 100644 tools/testing/selftests/rcutorture/configs/lock/LOCK08.boot

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 6fe046594868..8a08c004aa80 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -332,6 +332,28 @@ static struct lock_torture_ops rw_lock_irq_ops = {
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
@@ -360,11 +382,24 @@ __releases(torture_mutex)
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
 	.task_boost     = torture_boost_dummy,
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
2.39.2.637.g21b0678d19-goog

