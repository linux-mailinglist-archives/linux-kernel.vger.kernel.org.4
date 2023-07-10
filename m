Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F62E74DEBA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjGJUEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjGJUEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:04:05 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C28A13E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:04:04 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-403b30c7377so5868901cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689019443; x=1691611443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QE5xKsSsyeGv9fIIctRqoxdDyE7MPAyTGVDmmeq+ixU=;
        b=XnKZM9UbzPNGRyQMbF9g/3Zlj+vlzjkH2N6zArI52fqowRA/wH1LxM+wGNk4Q86Edj
         HBGCoHhqyhdGlU93kPNiD/HGJglMCCpL/c39ljqQBEI1wGwXNtYmy2m6jjX4Qlk1CImD
         3h6pJPYK5NGioKoWsZzg9XoY84MYW6kDTEMaGJEAX7BF2aX7HnyoRUYvhpuCjOlVEkZ7
         1/mrwGRk4vTyMpNTiFMHiJDgufpcEyIkrcugHY9F6xav58EDX7mmga8gQmTeqS8IfSvd
         RmysbZVaOwFIILCh/Y2e33XyyfwEx5ExnZeUR+8xRYpxWYOVscHsENumL9aPzBkE6DcL
         gIUQ==
X-Gm-Message-State: ABy/qLbqpDuZbR7q0LL+i6ZTU8CZlkJdV6/q/RTuLiCqYe+1UyMvA4ng
        atrAh1JDE5VfN7ESGHyBD8Xe0/JL8TU6bcyL
X-Google-Smtp-Source: APBJJlEE/4JqEU5DKF97ZkgVYls4asm8IrRhpaqRjLmLJ0tVrW3s1rdAn05mGjrCeraOP22vAERGog==
X-Received: by 2002:a05:622a:486:b0:3ff:407e:12 with SMTP id p6-20020a05622a048600b003ff407e0012mr15034264qtx.25.1689019443006;
        Mon, 10 Jul 2023 13:04:03 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:4850])
        by smtp.gmail.com with ESMTPSA id x13-20020ac8538d000000b00403ad47c895sm265964qtp.22.2023.07.10.13.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:04:02 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, aaron.lu@intel.com, clm@meta.com,
        tj@kernel.org, roman.gushchin@linux.dev, kernel-team@meta.com
Subject: [PATCH v2 2/7] sched: Move is_cpu_allowed() into sched.h
Date:   Mon, 10 Jul 2023 15:03:37 -0500
Message-Id: <20230710200342.358255-3-void@manifault.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710200342.358255-1-void@manifault.com>
References: <20230710200342.358255-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

is_cpu_allowed() exists as a static inline function in core.c. The
functionality offered by is_cpu_allowed() is useful to scheduling
policies as well, e.g. to determine whether a runnable task can be
migrated to another core that would otherwise go idle.

Let's move it to sched.h.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/sched/core.c  | 31 -------------------------------
 kernel/sched/sched.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 167cd9f11ed0..1451f5aa82ac 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -48,7 +48,6 @@
 #include <linux/kcov.h>
 #include <linux/kprobes.h>
 #include <linux/llist_api.h>
-#include <linux/mmu_context.h>
 #include <linux/mmzone.h>
 #include <linux/mutex_api.h>
 #include <linux/nmi.h>
@@ -2444,36 +2443,6 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
 	return rq->nr_pinned;
 }
 
-/*
- * Per-CPU kthreads are allowed to run on !active && online CPUs, see
- * __set_cpus_allowed_ptr() and select_fallback_rq().
- */
-static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
-{
-	/* When not in the task's cpumask, no point in looking further. */
-	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
-		return false;
-
-	/* migrate_disabled() must be allowed to finish. */
-	if (is_migration_disabled(p))
-		return cpu_online(cpu);
-
-	/* Non kernel threads are not allowed during either online or offline. */
-	if (!(p->flags & PF_KTHREAD))
-		return cpu_active(cpu) && task_cpu_possible(cpu, p);
-
-	/* KTHREAD_IS_PER_CPU is always allowed. */
-	if (kthread_is_per_cpu(p))
-		return cpu_online(cpu);
-
-	/* Regular kernel threads don't get to stay during offline. */
-	if (cpu_dying(cpu))
-		return false;
-
-	/* But are allowed during online. */
-	return cpu_online(cpu);
-}
-
 /*
  * This is how migration works:
  *
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 94846c947d6e..187ad5da5ef6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -44,6 +44,7 @@
 #include <linux/lockdep.h>
 #include <linux/minmax.h>
 #include <linux/mm.h>
+#include <linux/mmu_context.h>
 #include <linux/module.h>
 #include <linux/mutex_api.h>
 #include <linux/plist.h>
@@ -1199,6 +1200,36 @@ static inline bool is_migration_disabled(struct task_struct *p)
 #endif
 }
 
+/*
+ * Per-CPU kthreads are allowed to run on !active && online CPUs, see
+ * __set_cpus_allowed_ptr() and select_fallback_rq().
+ */
+static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
+{
+	/* When not in the task's cpumask, no point in looking further. */
+	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
+		return false;
+
+	/* migrate_disabled() must be allowed to finish. */
+	if (is_migration_disabled(p))
+		return cpu_online(cpu);
+
+	/* Non kernel threads are not allowed during either online or offline. */
+	if (!(p->flags & PF_KTHREAD))
+		return cpu_active(cpu) && task_cpu_possible(cpu, p);
+
+	/* KTHREAD_IS_PER_CPU is always allowed. */
+	if (kthread_is_per_cpu(p))
+		return cpu_online(cpu);
+
+	/* Regular kernel threads don't get to stay during offline. */
+	if (cpu_dying(cpu))
+		return false;
+
+	/* But are allowed during online. */
+	return cpu_online(cpu);
+}
+
 DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
 #define cpu_rq(cpu)		(&per_cpu(runqueues, (cpu)))
-- 
2.40.1

