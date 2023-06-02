Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C747271FAD6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbjFBHTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbjFBHTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:19:17 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530E1C0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 00:19:15 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QXZ4n00bcz18LsP;
        Fri,  2 Jun 2023 15:14:32 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 15:19:13 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <anshuman.khandual@arm.com>, <egyszeregy@freemail.hu>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] arm64: mm: move _PAGE_IOREMAP into pgtable-prot.h
Date:   Fri, 2 Jun 2023 15:34:45 +0800
Message-ID: <20230602073445.150273-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Szőke Kálmán Benjamin reported to me a build issue on an out-of-tree
module(from Xilinx[1]), which directly include <asm-generic/io.h>,

  "undefined reference" error for _PAGE_IOREMAP

In general, the module shouldn't include the low-level header file,
it should be fixed, but _PAGE_IOREMAP definination is kind of pgtable
prot, let's move it into pgtable-prot.h to put togethor with other prot.

[1] https://github.com/Xilinx/XilinxVirtualCable/blob/master/zynqMP/src/driver/xvc_driver.c
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/include/asm/io.h           | 2 --
 arch/arm64/include/asm/pgtable-prot.h | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 877495a0fd0c..0b0b12a95051 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -142,8 +142,6 @@ extern void __memset_io(volatile void __iomem *, int, size_t);
 bool ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot);
 #define ioremap_allowed ioremap_allowed
 
-#define _PAGE_IOREMAP PROT_DEVICE_nGnRE
-
 #define ioremap_wc(addr, size)	\
 	ioremap_prot((addr), (size), PROT_NORMAL_NC)
 #define ioremap_np(addr, size)	\
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 9b165117a454..f79afbad26a0 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -64,6 +64,7 @@ extern bool arm64_use_ng_mappings;
 #define PROT_SECT_NORMAL_EXEC	(PROT_SECT_DEFAULT | PMD_SECT_UXN | PMD_ATTRINDX(MT_NORMAL))
 
 #define _PAGE_DEFAULT		(_PROT_DEFAULT | PTE_ATTRINDX(MT_NORMAL))
+#define _PAGE_IOREMAP		PROT_DEVICE_nGnRE
 
 #define PAGE_KERNEL		__pgprot(PROT_NORMAL)
 #define PAGE_KERNEL_RO		__pgprot((PROT_NORMAL & ~PTE_WRITE) | PTE_RDONLY)
-- 
2.35.3

