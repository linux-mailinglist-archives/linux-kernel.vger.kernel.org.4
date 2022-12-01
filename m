Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E951663F3C5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiLAPZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLAPZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:25:35 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46197AA8CC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 07:25:33 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NNKY247dfzqSn7;
        Thu,  1 Dec 2022 23:21:26 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 23:25:30 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        Marco Elver <elver@google.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Alexander Potapenko <glider@google.com>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] ARM: kfence: only handle translation faults
Date:   Thu, 1 Dec 2022 23:42:58 +0800
Message-ID: <20221201154258.126144-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a similar fixup like arm64 does, only handle translation faults
in case of unexpected kfence report when alignment faults on ARM, see
more from commit 0bb1fbffc631 ("arm64: mm: kfence: only handle translation
faults").

Fixes: 75969686ec0d ("ARM: 9166/1: Support KFENCE for ARM")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/mm/fault.c | 18 ++++++++++++++++--
 arch/arm/mm/fault.h |  9 ++++++---
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 46cccd6bf705..de988cba9a4b 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -105,6 +105,19 @@ static inline bool is_write_fault(unsigned int fsr)
 	return (fsr & FSR_WRITE) && !(fsr & FSR_CM);
 }
 
+static inline bool is_translation_fault(unsigned int fsr)
+{
+	int fs = fsr_fs(fsr);
+#ifdef CONFIG_ARM_LPAE
+	if ((fs & FS_MMU_NOLL_MASK) == FS_TRANS_NOLL)
+		return true;
+#else
+	if (fs == FS_L1_TRANS || fs == FS_L2_TRANS)
+		return true;
+#endif
+	return false;
+}
+
 static void die_kernel_fault(const char *msg, struct mm_struct *mm,
 			     unsigned long addr, unsigned int fsr,
 			     struct pt_regs *regs)
@@ -140,7 +153,8 @@ __do_kernel_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
 	if (addr < PAGE_SIZE) {
 		msg = "NULL pointer dereference";
 	} else {
-		if (kfence_handle_page_fault(addr, is_write_fault(fsr), regs))
+		if (is_translation_fault(fsr) &&
+		    kfence_handle_page_fault(addr, is_write_fault(fsr), regs))
 			return;
 
 		msg = "paging request";
@@ -208,7 +222,7 @@ static inline bool is_permission_fault(unsigned int fsr)
 {
 	int fs = fsr_fs(fsr);
 #ifdef CONFIG_ARM_LPAE
-	if ((fs & FS_PERM_NOLL_MASK) == FS_PERM_NOLL)
+	if ((fs & FS_MMU_NOLL_MASK) == FS_PERM_NOLL)
 		return true;
 #else
 	if (fs == FS_L1_PERM || fs == FS_L2_PERM)
diff --git a/arch/arm/mm/fault.h b/arch/arm/mm/fault.h
index 83b5ab32d7a4..54927ba1fa6e 100644
--- a/arch/arm/mm/fault.h
+++ b/arch/arm/mm/fault.h
@@ -14,8 +14,9 @@
 
 #ifdef CONFIG_ARM_LPAE
 #define FSR_FS_AEA		17
+#define FS_TRANS_NOLL		0x4
 #define FS_PERM_NOLL		0xC
-#define FS_PERM_NOLL_MASK	0x3C
+#define FS_MMU_NOLL_MASK	0x3C
 
 static inline int fsr_fs(unsigned int fsr)
 {
@@ -23,8 +24,10 @@ static inline int fsr_fs(unsigned int fsr)
 }
 #else
 #define FSR_FS_AEA		22
-#define FS_L1_PERM             0xD
-#define FS_L2_PERM             0xF
+#define FS_L1_TRANS		0x5
+#define FS_L2_TRANS		0x7
+#define FS_L1_PERM		0xD
+#define FS_L2_PERM		0xF
 
 static inline int fsr_fs(unsigned int fsr)
 {
-- 
2.27.0

