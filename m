Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44A1693D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 05:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjBMEzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 23:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjBMEyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 23:54:44 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F1111EAC
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:19 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id k13so12361796plg.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YCem4BrJJv8uMiBliK+eUgJsgA757fo9l+siWv19bQ=;
        b=K5WRT8kvkrTRnxFXNxNWmZZe1eWQeiMi1qunE1LIKywvna8j3v5SzYl1jChj3QeZjI
         oNQVdHcccQpG2WuR1gzQg9kq/+0VuzgdVWD7JtRLTBXEFTOX1GEgMl7e5WBjD6OfQPdd
         71LTAu0tFhni4ZSn88ImId4fpVYObX1bY6JW37HXCp7hvg9l286KFURTu9ooi1NBKqLt
         u26MG8kM25n8svLfFhRQp8B3l5+xVXSXRfyHCQXaBio+kKCjC+Q8QLGXOyPk+PiaEIGE
         UxpBMq4IRtaJ3U/MEkWjmDf10E4N70sMBA71dAXlsLakRYCt8pcisJr17siP90QETbWq
         4NMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YCem4BrJJv8uMiBliK+eUgJsgA757fo9l+siWv19bQ=;
        b=4B/NpWzf0qtQkmkBRHHIBdGzh0rUvhQ6FToMZz1H4oQsTxjwVzvnABvCj3m6xI9VW5
         OcDjJ5Mpj4AxNQrBaAMWHStwCzvO/MEONnXGAzbLhBhDl02yYXA/lUgiTo0dLHnekwHI
         I8YRbWsLc6IaZ9l6RHUm2OukUrVXbje86FOPr1RQIlZXzaD1Cib1KAScajLnIaGEwm4j
         GL7yi/EFjpcT9fYlM2hhRp5PvnTu+Wtzpz4+HZXtqUo3AEfe3IM+SQ+kRY/+tRUgIN6H
         QbXlvt3j+kc25xfnXRw1noFmgfIdDQXCn4vBZ07v0XG6MfixFzc1SmCmEas3Lb1xQ4h4
         wFuQ==
X-Gm-Message-State: AO0yUKXzataOCEysrZMbgx/btzY43IOB1Hw0d4ipn6f7a6fnPKRsVoUD
        2RydXBrPwJyUTR+wC9270sK5J0yA/G9o+JVl
X-Google-Smtp-Source: AK7set9FL/syEzV/2KBqufzNCOsrJUvHtlRk/LJL1zmvxtRWPEp1GVPCimz+TSI3kDQUud1c6m89VA==
X-Received: by 2002:a17:902:e74c:b0:199:2a36:6c3f with SMTP id p12-20020a170902e74c00b001992a366c3fmr27035701plf.6.1676264058174;
        Sun, 12 Feb 2023 20:54:18 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b00189e7cb8b89sm7078303pln.127.2023.02.12.20.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 20:54:17 -0800 (PST)
From:   Deepak Gupta <debug@rivosinc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Deepak Gupta <debug@rivosinc.com>, linux-mm@kvack.org
Subject: [PATCH v1 RFC Zisslpcfi 11/20] mmu: maybe_mkwrite updated to manufacture shadow stack PTEs
Date:   Sun, 12 Feb 2023 20:53:40 -0800
Message-Id: <20230213045351.3945824-12-debug@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213045351.3945824-1-debug@rivosinc.com>
References: <20230213045351.3945824-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

maybe_mkwrite creates PTEs with WRITE encodings for underlying arch if
VM_WRITE is turned on in vma->vm_flags. Shadow stack memory is a write-
able memory except it can only be written by certain specific
instructions. This patch allows maybe_mkwrite to create shadow stack PTEs
if vma is shadow stack VMA. Each arch can define which combination of VMA
flags means a shadow stack.

Additionally pte_mkshdwstk must be provided by arch specific PTE
construction headers to create shadow stack PTEs. (in arch specific
pgtable.h).

This patch provides dummy/stub pte_mkshdwstk if CONFIG_USER_SHADOW_STACK
is not selected.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/mm.h      | 23 +++++++++++++++++++++--
 include/linux/pgtable.h |  4 ++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8f857163ac89..a7705bc49bfe 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1093,6 +1093,21 @@ static inline unsigned long thp_size(struct page *page)
 void free_compound_page(struct page *page);
 
 #ifdef CONFIG_MMU
+
+#ifdef CONFIG_USER_SHADOW_STACK
+bool arch_is_shadow_stack_vma(struct vm_area_struct *vma);
+#endif
+
+static inline bool
+is_shadow_stack_vma(struct vm_area_struct *vma)
+{
+#ifdef CONFIG_USER_SHADOW_STACK
+	return arch_is_shadow_stack_vma(vma);
+#else
+	return false;
+#endif
+}
+
 /*
  * Do pte_mkwrite, but only if the vma says VM_WRITE.  We do this when
  * servicing faults for write access.  In the normal case, do always want
@@ -1101,8 +1116,12 @@ void free_compound_page(struct page *page);
  */
 static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
-	if (likely(vma->vm_flags & VM_WRITE))
-		pte = pte_mkwrite(pte);
+	if (likely(vma->vm_flags & VM_WRITE)) {
+		if (unlikely(is_shadow_stack_vma(vma)))
+			pte = pte_mkshdwstk(pte);
+		else
+			pte = pte_mkwrite(pte);
+	}
 	return pte;
 }
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 1159b25b0542..94b157218c73 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1736,4 +1736,8 @@ pgprot_t vm_get_page_prot(unsigned long vm_flags)			\
 }									\
 EXPORT_SYMBOL(vm_get_page_prot);
 
+#ifndef CONFIG_USER_SHADOW_STACK
+#define pte_mkshdwstk(pte) pte
+#endif
+
 #endif /* _LINUX_PGTABLE_H */
-- 
2.25.1

