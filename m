Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C73963D50B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbiK3LyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiK3Lxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:53:32 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B9F69332
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:53:30 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w15so13490326wrl.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BJ0mV3lQZzVQnN0+KPldbno37+5NtwHZY0AFSgovrd4=;
        b=acIsg6LXeJ3grXrgT2fD7j0JfSNVoLIvbrRJLjdEzR6jry8EaXgyZjlwUOnNEhGASs
         3vzwYUfLR3NchW0Oa1255fRrEPBgdA1aU1RIOqszr8HfabBBBR4KV7gW+CDGoqXlyXxw
         ySS3NttuppAdUl9Gu2mk3TCgj3zHkfCZY3a2ygan3tG4Ihb1R2yyJJm/VeEvAEv1FRZq
         1IOgWFLjgw6ahoPqeCHrRE2trqgP1UDBMECJsTa0MMKdZf5Nw2mM/7P52Y8EwG1As9aM
         Fc4sFFXrrFHMD1Hwx8k+ficGAyDZv6ONpjJi5NND7E9VLUk3nud2vgCtiQzk0+uhR5cc
         47ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJ0mV3lQZzVQnN0+KPldbno37+5NtwHZY0AFSgovrd4=;
        b=rykcdrkXtN/Uu91lwOQ3FbfdXMPt9pWZXceOnjqe3l999HMQqHl8CULuCTlV3tHXhA
         8VxMZHZFbBkITvqjFg4EYgeGlBKhDazL7rfTuGRTB2NAeQwWxYleJyHYEJFrdW2i6YfE
         dPmLf6jN7oKxSG3UxESc5nwe/1K9H8OcEOrSNEjx/wnIF2p8B3iAqaGmYHkCv8qV3ww4
         YxPJ+psn6HP7elYgFFayKTabALT6R36Y1DizTPawLFPPbRYVovoGClBwHsV9Umqv4HBM
         0tVlLG6eTrKcmZleWfordzGriKLqMAQteQV+tdmJDgHmtsOS4MYHryCRDDMmCZ6bIYxg
         qO7A==
X-Gm-Message-State: ANoB5pmMn/dwje57e/z8WY+HhkQ80+6riNjkV06+IAOC/Y2c+1YLAIwv
        375D/Z1DVmPbAyLBT1KaWITMqQ==
X-Google-Smtp-Source: AA0mqf6bFLBHIpl1wyArkpDAELc+tfpDVmAKWZvW9NuWSU6H4gPa1doKCccsK/b/7YkEynIUd4Ot5Q==
X-Received: by 2002:a5d:56d2:0:b0:236:cdf8:1e3f with SMTP id m18-20020a5d56d2000000b00236cdf81e3fmr29701721wrw.80.1669809209160;
        Wed, 30 Nov 2022 03:53:29 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:a4e3:afa8:e6c2:32d0])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c210f00b003cf7292c553sm1686691wml.13.2022.11.30.03.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 03:53:28 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] time/namespace: Refactor copy-pasted helper into one copy
Date:   Wed, 30 Nov 2022 12:53:20 +0100
Message-Id: <20221130115320.2918447-1-jannh@google.com>
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

