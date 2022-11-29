Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA3463C810
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236781AbiK2TUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236735AbiK2TTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:19:12 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0440B6D489
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:18:47 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so15214731wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wxyzq5HoGGPjbm+gODa1txXf4Q/7Y+OG+18WipqPvk8=;
        b=C7udiI9DZ9yrtSSFqKTvirw8jYU7kLh3jL5ugkLtf55sgtnKUK0l08r9A82M6adAaq
         jTkhTdaFW4s9L3hAvLP31VYKygvX0PS4i6Y5wHGHZiJ6mGvrUNTDyJap8TXhjRn+NSL1
         U+9EPwBIcrL3NQPRXWuFblADZSBovx+GAKF33BCQ2fRRzBBs/cgDcqoOafCoIa2Wr85K
         kubHmbkWTRBLi+hYf5HI1atoQ4K/NF7JmiE2jfD3fDjl9H43JvRLkg+tVjsrhDkHE7nq
         drpoU9/5nF+HjuFS365ASEDU8WYmWjX3j4EEczY+2qLP0uskgXo+eXNBHFz31FHXc5Te
         u7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wxyzq5HoGGPjbm+gODa1txXf4Q/7Y+OG+18WipqPvk8=;
        b=qbv/JrGGKs8QnnuKfCZpn6PeOl8VaDl6EKHYVqslfUCXMEqIuVAlZR2eQnwiEd/qEW
         yhH0AvUEZYVWNLtuZfHtfO9MOm82PTQgsoYvhZhklqQsCUfEwRpnXjVk/zaQQRNDlEYo
         bwQsIGd2ZXE91NGOAuactfo5vsVkhv/W8bfVWIAVr3kCeeR/dGnL9VuxEoyMVZNGwirL
         BFj/PDVWRV+MLPJ1Evdm0/BRcyr9TelCoY1Ban86azJzvco7z5qMoVbtIFwaVbeDBdus
         RHd1ixiwCTQpUd1S7OOB7/ZYioKFqaCtkd2Eucynz75UILT5ngbV1T9+og7zojlbid8b
         O6aA==
X-Gm-Message-State: ANoB5pld+ZYTOfcVOJOo6dNQuyyXyf1gQtvesRL8UpQxW0I7bIPfBp97
        B59UTIMp5h3bDeU95N2cRYaVRA==
X-Google-Smtp-Source: AA0mqf7kLqxJPfRzdFeSuQaSd8KasAfw0mgXxSdu4sxBwny26+wgEuzYUj7kChJX2IE1etT3yt85lg==
X-Received: by 2002:a05:600c:3110:b0:3cf:b07a:cd56 with SMTP id g16-20020a05600c311000b003cfb07acd56mr44367090wmo.143.1669749526203;
        Tue, 29 Nov 2022 11:18:46 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:5011:adcc:fddd:accf])
        by smtp.gmail.com with ESMTPSA id p9-20020adfce09000000b0022dc6e76bbdsm14349862wrn.46.2022.11.29.11.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 11:18:45 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] time/namespace: Refactor copy-pasted helper into one copy
Date:   Tue, 29 Nov 2022 20:18:38 +0100
Message-Id: <20221129191839.2471308-1-jannh@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_timens_vvar_page() is not arch-specific, as can be seen from how all
five per-architecture versions of it are the same.
(arm64, powerpc and riscv are exactly the same; x86 and s390 have two
characters difference inside a comment, less blank lines, and mark the
!CONFIG_TIME_NS version as inline.)

Refactor the five copies into a central copy in kernel/time/namespace.c.

Marked for stable backporting because it is a prerequisite for the
following patch.

Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/arm64/kernel/vdso.c       | 22 ----------------------
 arch/powerpc/kernel/vdso.c     | 22 ----------------------
 arch/riscv/kernel/vdso.c       | 22 ----------------------
 arch/s390/kernel/vdso.c        | 20 --------------------
 arch/x86/entry/vdso/vma.c      | 23 -----------------------
 include/linux/time_namespace.h |  6 ++++++
 kernel/time/namespace.c        | 20 ++++++++++++++++++++
 7 files changed, 26 insertions(+), 109 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 99ae81ab91a74..e59a32aa0c49d 100644
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
index 4abc019497020..507f8228f983b 100644
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
index 123d05255fcfa..e410275918ac4 100644
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
index 3105ca5bd4701..d6df7169c01f2 100644
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
index 311eae30e0894..6b36485054e8a 100644
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
index 3146f1c056c98..bb9d3f5542f8e 100644
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
index aec832801c26c..761c0ada5142a 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -192,6 +192,26 @@ static void timens_setup_vdso_data(struct vdso_data *vdata,
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
+
+
 /*
  * Protects possibly multiple offsets writers racing each other
  * and tasks entering the namespace.

base-commit: ca57f02295f188d6c65ec02202402979880fa6d8
-- 
2.38.1.584.g0f3c55d4c2-goog

