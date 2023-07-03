Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4A3745E20
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjGCOG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjGCOG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:06:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC89E51
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 07:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688393166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zHQXfVtXAZjvrQC07bbaf5d12vfBfUWqeJ1W4srezSg=;
        b=H9y3vgDTOKjzMdrN5PiDBQjVQ/4/q3RuNPlJTgt/ojS/PX95RlxOK6KzArl6dQGIPSSNtA
        b1QUpPAzKZFV8e89hbvxxpwQS98FFkkoEI2Ryl2xQJUJ4iv3suRf/ImgP6XTmk15y486Xc
        F4vDUNDi5Apu/6Szq4asIhOfEleX2d0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-KKwRuRHoNVWxmJZw_RtnrA-1; Mon, 03 Jul 2023 10:06:00 -0400
X-MC-Unique: KKwRuRHoNVWxmJZw_RtnrA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B40C03C18FE2;
        Mon,  3 Jul 2023 14:05:59 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.22.32.241])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B36D6492B01;
        Mon,  3 Jul 2023 14:05:58 +0000 (UTC)
From:   Nico Pache <npache@redhat.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     aquini@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>
Subject: [RFC] arm64: properly define SOFT_DIRTY for arm64
Date:   Mon,  3 Jul 2023 09:55:26 -0400
Message-ID: <20230703135526.930004-1-npache@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM64 has a soft-dirty bit (software dirty) but never properly defines
CONFIG_ARCH_HAS_SOFT_DIRTY or its necessary functions. This patch
introduces the ability to set/clear the soft dirty bit in a similar
manner as the other arches that utilize it.

However, we must be careful... there are cases where the DBM bit is not
available and the software dirty bit plays a essential role in determining
whether or not a page is dirty. In these cases we must not allow the
user to clear the software dirty bit. We can test for these cases by
utilizing the arch_faults_on_old_pte() function which test the availability
of DBM.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Liu Shixin <liushixin2@huawei.com>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/pgtable.h | 77 +++++++++++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 891ab530a665..4de491627f49 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -173,6 +173,7 @@ config ARM64
 	select HAVE_ARCH_PREL32_RELOCATIONS
 	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ARCH_SOFT_DIRTY
 	select HAVE_ARCH_STACKLEAK
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_TRACEHOOK
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 0bd18de9fd97..a0a15ffa2417 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -121,8 +121,9 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 })
 
 #define pte_hw_dirty(pte)	(pte_write(pte) && !(pte_val(pte) & PTE_RDONLY))
-#define pte_sw_dirty(pte)	(!!(pte_val(pte) & PTE_DIRTY))
-#define pte_dirty(pte)		(pte_sw_dirty(pte) || pte_hw_dirty(pte))
+#define pte_soft_dirty(pte)	(!!(pte_val(pte) & PTE_DIRTY))
+#define pte_dirty(pte)		(pte_soft_dirty(pte) || pte_hw_dirty(pte))
+#define pte_swp_soft_dirty(pte)	pte_soft_dirty(pte)
 
 #define pte_valid(pte)		(!!(pte_val(pte) & PTE_VALID))
 /*
@@ -1096,6 +1097,78 @@ static inline bool pud_sect_supported(void)
 	return PAGE_SIZE == SZ_4K;
 }
 
+#ifdef CONFIG_ARM64_HW_AFDBM
+/*
+ * if we have the DBM bit we can utilize the software dirty bit as
+ * a mechanism to introduce the soft_dirty functionality; however, without
+ * it this bit is crucial to determining if a entry is dirty and we cannot
+ * clear it via software. DBM can also be disabled or broken on some early
+ * armv8 devices, so check its availability before modifying it.
+ */
+static inline pte_t pte_clear_soft_dirty(pte_t pte)
+{
+	if (arch_faults_on_old_pte())
+		return pte;
+
+	return clear_pte_bit(pte, __pgprot(PTE_DIRTY));
+}
+
+static inline pte_t pte_mksoft_dirty(pte_t pte)
+{
+	if (arch_faults_on_old_pte())
+		return pte;
+
+	return set_pte_bit(pte, __pgprot(PTE_DIRTY));
+}
+
+static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
+{
+	if (arch_faults_on_old_pte())
+		return pte;
+
+	return clear_pte_bit(pte, __pgprot(PTE_DIRTY));
+}
+
+static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
+{
+	if (arch_faults_on_old_pte())
+		return pte;
+
+	return set_pte_bit(pte, __pgprot(PTE_DIRTY));
+}
+
+static inline int pmd_soft_dirty(pmd_t pmd)
+{
+	return pte_soft_dirty(pmd_pte(pmd));
+}
+
+static inline pmd_t pmd_clear_soft_dirty(pmd_t pmd)
+{
+	return pte_pmd(pte_clear_soft_dirty(pmd_pte(pmd)));
+}
+
+static inline pmd_t pmd_mksoft_dirty(pmd_t pmd)
+{
+	return pte_pmd(pte_mksoft_dirty(pmd_pte(pmd)));
+}
+
+#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
+static inline int pmd_swp_soft_dirty(pmd_t pmd)
+{
+	return pmd_soft_dirty(pmd);
+}
+
+static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t pmd)
+{
+	return pmd_clear_soft_dirty(pmd);
+}
+
+static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
+{
+	return pmd_mksoft_dirty(pmd);
+}
+#endif /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
+#endif /* CONFIG_ARM64_HW_AFDBM */
 
 #define __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
 #define ptep_modify_prot_start ptep_modify_prot_start
-- 
2.41.0

