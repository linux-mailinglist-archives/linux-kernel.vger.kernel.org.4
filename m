Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71B863EE56
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiLAKqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiLAKp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:45:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52FDAB007;
        Thu,  1 Dec 2022 02:44:36 -0800 (PST)
Date:   Thu, 01 Dec 2022 10:44:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669891472;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pqbQXT58QTEULlGE5E51Xu+0CVuy7mtNhlgtI1eWWec=;
        b=VLxX0d+gE7eSq+IxFPehwxw4AZTc3QzapP8DtB8IBqlk7XelAfkjoPAHzBh1VWqjRJtwO3
        hPiJ0PPjovsr3DqudTyScd7xWlwTtMphNnLCkaKm0XaHP2FqHjriLzOULEJ//s3UGm8qpW
        cCQEVikR+0OZQnYFzVmXmM9FO7FFM9kxHRPcLXT7m8iPlxoJPK8E1fSIZZBZwxOtrCtQrD
        LaubG5bcXgJJFLpiaBxAbdDw/Dtz4jZh72pijb7RHonJorjcJGlFJr+riDtwv5pPDQbBHh
        Met9l3LeUiR2tiSaOUd7hgXoI2qG5cjSKl4MEvPn7pVbezzLm0g7Rzd5djQYmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669891472;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pqbQXT58QTEULlGE5E51Xu+0CVuy7mtNhlgtI1eWWec=;
        b=xHjPo4SM0vTbbKmulGyTg38mp/OqC2ux3mMkwdaqAUimlYobh+fue4W2HnqMDZTJmh0jJ8
        rlNCD81gSgua/EBw==
From:   "tip-bot2 for Jann Horn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] vdso/timens: Refactor copy-pasted
 find_timens_vvar_page() helper into one copy
Cc:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221130115320.2918447-1-jannh@google.com>
References: <20221130115320.2918447-1-jannh@google.com>
MIME-Version: 1.0
Message-ID: <166989147114.4906.2929001822083296859.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d6c494e8ee932b2b21ff4b718eebb378e91b3da0
Gitweb:        https://git.kernel.org/tip/d6c494e8ee932b2b21ff4b718eebb378e91b3da0
Author:        Jann Horn <jannh@google.com>
AuthorDate:    Wed, 30 Nov 2022 12:53:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 01 Dec 2022 11:35:40 +01:00

vdso/timens: Refactor copy-pasted find_timens_vvar_page() helper into one copy

find_timens_vvar_page() is not architecture-specific, as can be seen from
how all five per-architecture versions of it are the same.

(arm64, powerpc and riscv are exactly the same; x86 and s390 have two
characters difference inside a comment, less blank lines, and mark the
!CONFIG_TIME_NS version as inline.)

Refactor the five copies into a central copy in kernel/time/namespace.c.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20221130115320.2918447-1-jannh@google.com

---
 arch/arm64/kernel/vdso.c       | 22 ----------------------
 arch/powerpc/kernel/vdso.c     | 22 ----------------------
 arch/riscv/kernel/vdso.c       | 22 ----------------------
 arch/s390/kernel/vdso.c        | 20 --------------------
 arch/x86/entry/vdso/vma.c      | 23 -----------------------
 include/linux/time_namespace.h |  6 ++++++
 kernel/time/namespace.c        | 18 ++++++++++++++++++
 7 files changed, 24 insertions(+), 109 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 99ae81a..e59a32a 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -151,28 +151,6 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 	mmap_read_unlock(mm);
 	return 0;
 }
-
-static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
-{
-	if (likely(vma->vm_mm == current->mm))
-		return current->nsproxy->time_ns->vvar_page;
-
-	/*
-	 * VM_PFNMAP | VM_IO protect .fault() handler from being called
-	 * through interfaces like /proc/$pid/mem or
-	 * process_vm_{readv,writev}() as long as there's no .access()
-	 * in special_mapping_vmops.
-	 * For more details check_vma_flags() and __access_remote_vm()
-	 */
-	WARN(1, "vvar_page accessed remotely");
-
-	return NULL;
-}
-#else
-static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
-{
-	return NULL;
-}
 #endif
 
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 4abc019..507f822 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -129,28 +129,6 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 
 	return 0;
 }
-
-static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
-{
-	if (likely(vma->vm_mm == current->mm))
-		return current->nsproxy->time_ns->vvar_page;
-
-	/*
-	 * VM_PFNMAP | VM_IO protect .fault() handler from being called
-	 * through interfaces like /proc/$pid/mem or
-	 * process_vm_{readv,writev}() as long as there's no .access()
-	 * in special_mapping_vmops.
-	 * For more details check_vma_flags() and __access_remote_vm()
-	 */
-	WARN(1, "vvar_page accessed remotely");
-
-	return NULL;
-}
-#else
-static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
-{
-	return NULL;
-}
 #endif
 
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 123d052..e410275 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -137,28 +137,6 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 	mmap_read_unlock(mm);
 	return 0;
 }
-
-static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
-{
-	if (likely(vma->vm_mm == current->mm))
-		return current->nsproxy->time_ns->vvar_page;
-
-	/*
-	 * VM_PFNMAP | VM_IO protect .fault() handler from being called
-	 * through interfaces like /proc/$pid/mem or
-	 * process_vm_{readv,writev}() as long as there's no .access()
-	 * in special_mapping_vmops.
-	 * For more details check_vma_flags() and __access_remote_vm()
-	 */
-	WARN(1, "vvar_page accessed remotely");
-
-	return NULL;
-}
-#else
-static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
-{
-	return NULL;
-}
 #endif
 
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 3105ca5..d6df716 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -44,21 +44,6 @@ struct vdso_data *arch_get_vdso_data(void *vvar_page)
 	return (struct vdso_data *)(vvar_page);
 }
 
-static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
-{
-	if (likely(vma->vm_mm == current->mm))
-		return current->nsproxy->time_ns->vvar_page;
-	/*
-	 * VM_PFNMAP | VM_IO protect .fault() handler from being called
-	 * through interfaces like /proc/$pid/mem or
-	 * process_vm_{readv,writev}() as long as there's no .access()
-	 * in special_mapping_vmops().
-	 * For more details check_vma_flags() and __access_remote_vm()
-	 */
-	WARN(1, "vvar_page accessed remotely");
-	return NULL;
-}
-
 /*
  * The VVAR page layout depends on whether a task belongs to the root or
  * non-root time namespace. Whenever a task changes its namespace, the VVAR
@@ -84,11 +69,6 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 	mmap_read_unlock(mm);
 	return 0;
 }
-#else
-static inline struct page *find_timens_vvar_page(struct vm_area_struct *vma)
-{
-	return NULL;
-}
 #endif
 
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 311eae3..6b36485 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -98,24 +98,6 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
 }
 
 #ifdef CONFIG_TIME_NS
-static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
-{
-	if (likely(vma->vm_mm == current->mm))
-		return current->nsproxy->time_ns->vvar_page;
-
-	/*
-	 * VM_PFNMAP | VM_IO protect .fault() handler from being called
-	 * through interfaces like /proc/$pid/mem or
-	 * process_vm_{readv,writev}() as long as there's no .access()
-	 * in special_mapping_vmops().
-	 * For more details check_vma_flags() and __access_remote_vm()
-	 */
-
-	WARN(1, "vvar_page accessed remotely");
-
-	return NULL;
-}
-
 /*
  * The vvar page layout depends on whether a task belongs to the root or
  * non-root time namespace. Whenever a task changes its namespace, the VVAR
@@ -140,11 +122,6 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 
 	return 0;
 }
-#else
-static inline struct page *find_timens_vvar_page(struct vm_area_struct *vma)
-{
-	return NULL;
-}
 #endif
 
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 3146f1c..bb9d3f5 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -45,6 +45,7 @@ struct time_namespace *copy_time_ns(unsigned long flags,
 void free_time_ns(struct time_namespace *ns);
 void timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk);
 struct vdso_data *arch_get_vdso_data(void *vvar_page);
+struct page *find_timens_vvar_page(struct vm_area_struct *vma);
 
 static inline void put_time_ns(struct time_namespace *ns)
 {
@@ -141,6 +142,11 @@ static inline void timens_on_fork(struct nsproxy *nsproxy,
 	return;
 }
 
+static inline struct page *find_timens_vvar_page(struct vm_area_struct *vma)
+{
+	return NULL;
+}
+
 static inline void timens_add_monotonic(struct timespec64 *ts) { }
 static inline void timens_add_boottime(struct timespec64 *ts) { }
 
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index aec8328..0775b9e 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -192,6 +192,24 @@ static void timens_setup_vdso_data(struct vdso_data *vdata,
 	offset[CLOCK_BOOTTIME_ALARM]	= boottime;
 }
 
+struct page *find_timens_vvar_page(struct vm_area_struct *vma)
+{
+	if (likely(vma->vm_mm == current->mm))
+		return current->nsproxy->time_ns->vvar_page;
+
+	/*
+	 * VM_PFNMAP | VM_IO protect .fault() handler from being called
+	 * through interfaces like /proc/$pid/mem or
+	 * process_vm_{readv,writev}() as long as there's no .access()
+	 * in special_mapping_vmops().
+	 * For more details check_vma_flags() and __access_remote_vm()
+	 */
+
+	WARN(1, "vvar_page accessed remotely");
+
+	return NULL;
+}
+
 /*
  * Protects possibly multiple offsets writers racing each other
  * and tasks entering the namespace.
