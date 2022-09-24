Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520F45E894E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 09:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbiIXHyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 03:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiIXHyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 03:54:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EDA43626
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 00:54:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C64D60E99
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 07:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EF4C433D6;
        Sat, 24 Sep 2022 07:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664006088;
        bh=u9mYajIuHBlZGE/ehPJVW7yGMSCvpdioE5IvcFBScms=;
        h=From:To:Cc:Subject:Date:From;
        b=RXXMLyv6uUFmBZ6NzmtPEAgS4krpYJvwGo+WpbrfFTUPDK1F3jMqBSk2jOFOCo+vb
         MEGJZlzR9ayY8mPXkdgdzoWSIWejpLxBhcjVQtZZwIN31HcNJ9YSwH9wt+0LZB35ME
         JYX2t5UlPDDRCnrBJj95Y9vSw4bZ8rb3bTv5JZQ1DsU7YNaDcMoRslK+eOO69wVax3
         VxLxH6shQDx6Kv1STwhgHLSptBvDUotG8dAYLMi76dvb1/c1zh/7WLrUhapXXvYz9n
         4DPkGFjChjI6oiqzhk/hKHY4AJfV0UgMq3UYJZvCswJ5uRjYye2yqn1+Mer1ahXOEX
         E05lIvFUXPc5g==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: vdso: reorganise the file to remove two forward declarations.
Date:   Sat, 24 Sep 2022 15:45:23 +0800
Message-Id: <20220924074523.3764-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the vdso_join_timens() after the compat_vdso_info and vdso_info
structure definitions so that we can remove the two forward
declarations. No functional changes.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/vdso.c | 65 +++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 4abc9aebdfae..3c5fb27085a0 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -60,11 +60,6 @@ struct __vdso_info {
 	struct vm_special_mapping *cm;
 };
 
-static struct __vdso_info vdso_info;
-#ifdef CONFIG_COMPAT
-static struct __vdso_info compat_vdso_info;
-#endif
-
 static int vdso_mremap(const struct vm_special_mapping *sm,
 		       struct vm_area_struct *new_vma)
 {
@@ -108,35 +103,6 @@ struct vdso_data *arch_get_vdso_data(void *vvar_page)
 	return (struct vdso_data *)(vvar_page);
 }
 
-/*
- * The vvar mapping contains data for a specific time namespace, so when a task
- * changes namespace we must unmap its vvar data for the old namespace.
- * Subsequent faults will map in data for the new namespace.
- *
- * For more details see timens_setup_vdso_data().
- */
-int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
-{
-	struct mm_struct *mm = task->mm;
-	struct vm_area_struct *vma;
-
-	mmap_read_lock(mm);
-
-	for (vma = mm->mmap; vma; vma = vma->vm_next) {
-		unsigned long size = vma->vm_end - vma->vm_start;
-
-		if (vma_is_special_mapping(vma, vdso_info.dm))
-			zap_page_range(vma, vma->vm_start, size);
-#ifdef CONFIG_COMPAT
-		if (vma_is_special_mapping(vma, compat_vdso_info.dm))
-			zap_page_range(vma, vma->vm_start, size);
-#endif
-	}
-
-	mmap_read_unlock(mm);
-	return 0;
-}
-
 static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
 {
 	if (likely(vma->vm_mm == current->mm))
@@ -234,6 +200,37 @@ static struct __vdso_info compat_vdso_info __ro_after_init = {
 };
 #endif
 
+#ifdef CONFIG_TIME_NS
+/*
+ * The vvar mapping contains data for a specific time namespace, so when a task
+ * changes namespace we must unmap its vvar data for the old namespace.
+ * Subsequent faults will map in data for the new namespace.
+ *
+ * For more details see timens_setup_vdso_data().
+ */
+int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
+{
+	struct mm_struct *mm = task->mm;
+	struct vm_area_struct *vma;
+
+	mmap_read_lock(mm);
+
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		unsigned long size = vma->vm_end - vma->vm_start;
+
+		if (vma_is_special_mapping(vma, vdso_info.dm))
+			zap_page_range(vma, vma->vm_start, size);
+#ifdef CONFIG_COMPAT
+		if (vma_is_special_mapping(vma, compat_vdso_info.dm))
+			zap_page_range(vma, vma->vm_start, size);
+#endif
+	}
+
+	mmap_read_unlock(mm);
+	return 0;
+}
+#endif
+
 static int __init vdso_init(void)
 {
 	__vdso_init(&vdso_info);
-- 
2.34.1

