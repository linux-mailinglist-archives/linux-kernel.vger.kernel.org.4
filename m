Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7626BDB7D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 23:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCPWVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 18:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjCPWVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:21:43 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986D3B0B8E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 15:21:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id p4so2861321wre.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 15:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679005274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZOcJlN4hsoET9GB1lz88zELWFf4YxBH7A+4Yjdmpg0=;
        b=jHDfLcCchiqdnozdtUvd3AIzSPgmu8CKRQyfMZhtMflGqrA4sIZVBV11LttR2/WRVQ
         j6CPPcpqg4vZd+OlXmy1/pRWVAisVuiFqwtLTvO3oTeuan72LXYJ+1Q3PFcPJeLFsUqL
         MER8KlDOQBcISMTImXF1w3+CZsw9iemukQHpHNfzDc3RIdfsWm+EXE9sTiubnYMTyZRr
         vkbmS4MJljqZGRK2MUKVO8rbpMle2zqdi6M34Fc9tWxSr2HU5waK82B5J9QwG22kAwB/
         CehZoT7fehMX1KmYU3h8N0EhL9xS5LaSrZiNtTY9aH7km5ZeZJYR6ywGwK8T23gdWHjn
         VrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679005274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZOcJlN4hsoET9GB1lz88zELWFf4YxBH7A+4Yjdmpg0=;
        b=EY5zQZn5An2CJuVut1/zVjpB+QqgaeGyreL/L8+eRdVzhX2UQxB2Sjy0+6qFV0tn6U
         n2diNgJJXvUeidIPYMOmUoAt91lWjWdOr4zmQ8qLe/R0EXCMRxhGG6DIAXPsX7RWeC3u
         wp8F+vR5QEjuEvNCf721B3pNlbfCuqwfMF0/ayx1Ijw9nMqK/8JjAA5F3rbdEcZRbPGf
         22znBH/FbTK25ORsbRhEKBjBGP9M6lKTOUNUXukQ2OO7e1TawJFUcsVk2uWlFzvuBlEp
         /qqprqj/zmRQdJaWv2Ni++I0JBgX5Cj+0PfvPYjOHsXnlQiWq0Ld3smdOqaIV8AbdetB
         JUhg==
X-Gm-Message-State: AO0yUKUZE2sHktn+DB58ff3vzVEY14bGMZh9iYMJ1b0dvHv/sLcmVMmK
        WfPeLstSAvlC+jog/7eoZUbwCw==
X-Google-Smtp-Source: AK7set8/JMm1BD3p/e7ex+3Zw/5k1J2dt9JTTu01hxcYcndc0IEXCkt8Lgt35mwniZI7VpeZ1a3zlQ==
X-Received: by 2002:a5d:530d:0:b0:2cf:e2f3:ef46 with SMTP id e13-20020a5d530d000000b002cfe2f3ef46mr5192145wrv.52.1679005273994;
        Thu, 16 Mar 2023 15:21:13 -0700 (PDT)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:4b87:78c3:3abe:7b0d])
        by smtp.gmail.com with ESMTPSA id f9-20020adff989000000b002cea392f000sm439256wrr.69.2023.03.16.15.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 15:21:13 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de, kim.phillips@amd.com,
        brgerst@gmail.com
Cc:     piotrgorski@cachyos.org, oleksandr@natalenko.name,
        arjan@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rcu@vger.kernel.org, mimoja@mimoja.de, hewenliang4@huawei.com,
        thomas.lendacky@amd.com, seanjc@google.com, pmenzel@molgen.mpg.de,
        fam.zheng@bytedance.com, punit.agrawal@bytedance.com,
        simon.evans@bytedance.com, liangma@liangbit.com,
        gpiccoli@igalia.com, David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v15 02/12] cpu/hotplug: Move idle_thread_get() to <linux/smpboot.h>
Date:   Thu, 16 Mar 2023 22:20:59 +0000
Message-Id: <20230316222109.1940300-3-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316222109.1940300-1-usama.arif@bytedance.com>
References: <20230316222109.1940300-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

Instead of relying purely on the special-case wrapper in bringup_cpu()
to pass the idle thread to __cpu_up(), expose idle_thread_get() so that
the architecture code can obtain it directly when necessary.

This will be useful when the existing __cpu_up() is split into multiple
phases, only *one* of which will actually need the idle thread.

If the architecture code is to register its new pre-bringup states with
the cpuhp core, having a special-case wrapper to pass extra arguments is
non-trivial and it's easier just to let the arch register its function
pointer to be invoked with the standard API.

To reduce duplication, move the shadow stack reset and kasan unpoisoning
into idle_thread_get() too.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Kim Phillips <kim.phillips@amd.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 include/linux/smpboot.h | 10 ++++++++++
 kernel/cpu.c            | 13 +++----------
 kernel/smpboot.c        | 11 ++++++++++-
 kernel/smpboot.h        |  2 --
 4 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/include/linux/smpboot.h b/include/linux/smpboot.h
index 9d1bc65d226c..df6417703e4c 100644
--- a/include/linux/smpboot.h
+++ b/include/linux/smpboot.h
@@ -5,6 +5,16 @@
 #include <linux/types.h>
 
 struct task_struct;
+
+#ifdef CONFIG_GENERIC_SMP_IDLE_THREAD
+struct task_struct *idle_thread_get(unsigned int cpu, bool unpoison);
+#else
+static inline struct task_struct *idle_thread_get(unsigned int cpu, bool unpoison)
+{
+	return NULL;
+}
+#endif
+
 /* Cookie handed to the thread_fn*/
 struct smpboot_thread_data;
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6c0a92ca6bb5..6b3dccb4a888 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -31,7 +31,6 @@
 #include <linux/smpboot.h>
 #include <linux/relay.h>
 #include <linux/slab.h>
-#include <linux/scs.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/cpuset.h>
 #include <linux/random.h>
@@ -588,15 +587,9 @@ static int bringup_wait_for_ap(unsigned int cpu)
 
 static int bringup_cpu(unsigned int cpu)
 {
-	struct task_struct *idle = idle_thread_get(cpu);
+	struct task_struct *idle = idle_thread_get(cpu, true);
 	int ret;
 
-	/*
-	 * Reset stale stack state from the last time this CPU was online.
-	 */
-	scs_task_reset(idle);
-	kasan_unpoison_task_stack(idle);
-
 	/*
 	 * Some architectures have to walk the irq descriptors to
 	 * setup the vector space for the cpu which comes online.
@@ -614,7 +607,7 @@ static int bringup_cpu(unsigned int cpu)
 
 static int finish_cpu(unsigned int cpu)
 {
-	struct task_struct *idle = idle_thread_get(cpu);
+	struct task_struct *idle = idle_thread_get(cpu, false);
 	struct mm_struct *mm = idle->active_mm;
 
 	/*
@@ -1378,7 +1371,7 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
 
 	if (st->state == CPUHP_OFFLINE) {
 		/* Let it fail before we try to bring the cpu up */
-		idle = idle_thread_get(cpu);
+		idle = idle_thread_get(cpu, false);
 		if (IS_ERR(idle)) {
 			ret = PTR_ERR(idle);
 			goto out;
diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index 2c7396da470c..24e81c725e7b 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/sched/task.h>
+#include <linux/scs.h>
 #include <linux/export.h>
 #include <linux/percpu.h>
 #include <linux/kthread.h>
@@ -27,12 +28,20 @@
  */
 static DEFINE_PER_CPU(struct task_struct *, idle_threads);
 
-struct task_struct *idle_thread_get(unsigned int cpu)
+struct task_struct *idle_thread_get(unsigned int cpu, bool unpoison)
 {
 	struct task_struct *tsk = per_cpu(idle_threads, cpu);
 
 	if (!tsk)
 		return ERR_PTR(-ENOMEM);
+
+	if (unpoison) {
+		/*
+		 * Reset stale stack state from last time this CPU was online.
+		 */
+		scs_task_reset(tsk);
+		kasan_unpoison_task_stack(tsk);
+	}
 	return tsk;
 }
 
diff --git a/kernel/smpboot.h b/kernel/smpboot.h
index 34dd3d7ba40b..60c609318ad6 100644
--- a/kernel/smpboot.h
+++ b/kernel/smpboot.h
@@ -5,11 +5,9 @@
 struct task_struct;
 
 #ifdef CONFIG_GENERIC_SMP_IDLE_THREAD
-struct task_struct *idle_thread_get(unsigned int cpu);
 void idle_thread_set_boot_cpu(void);
 void idle_threads_init(void);
 #else
-static inline struct task_struct *idle_thread_get(unsigned int cpu) { return NULL; }
 static inline void idle_thread_set_boot_cpu(void) { }
 static inline void idle_threads_init(void) { }
 #endif
-- 
2.25.1

