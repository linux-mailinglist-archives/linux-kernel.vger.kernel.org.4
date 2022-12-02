Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9114640251
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbiLBIhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbiLBIhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:37:09 -0500
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CACA6595
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 00:35:29 -0800 (PST)
X-QQ-mid: bizesmtp79t1669970067t2y9zci3
Received: from utnb-jevon.lan ( [111.197.251.121])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 02 Dec 2022 16:34:12 +0800 (CST)
X-QQ-SSF: 0140000000000050B000000A0000000
X-QQ-FEAT: bwGCdh8HjQCqJQfi+gC/rhbC+wkOzyzykwBjb5QmtilG0Y0+31ivTyDyV7/hx
        jVnqh3on3UMNhrpDbxN7IM/bbEXlPlz4zjyEaRYEN7fqFYH+rzzeyBXtKxHekHxGOU2nLUS
        q9dgGHI8JC2HVTUSO2+SP5tn29eDFBoxwSkqowBrieaUYKeXZT5wIVHd42nX0A22fVrxCf3
        Z/o6I/5Ed70SG7fsjwzZ3RM9F3Z+3QQL3fBcvkXUMNv/rpRFWmIr016saGYq+o32TVVUpXQ
        UUtq4Zb8k2VvR7OnugaWyINSqM7Me7p2aIpDZGr1P2ZAev+wgyD10sAw2FLmjnzYU2gLhpK
        4P25svnqcsHNZqJ2Z8GVmcpW6RsrVH02sHmgM8MrW9morAV/l6uSQi3RwjfsQ==
X-QQ-GoodBg: 1
From:   Jianwen Jiang <jiangjianwen@uniontech.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alexandre.ghiti@canonical.com,
        geert@linux-m68k.org, panqinglin2020@iscas.ac.cn, arnd@arndb.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jianwen Jiang <jiangjianwen@uniontech.com>
Subject: [PATCH]     Implement ioremap_prot support (v2)
Date:   Fri,  2 Dec 2022 16:33:56 +0800
Message-Id: <20221202083356.169176-1-jiangjianwen@uniontech.com>
X-Mailer: git-send-email 2.37.3.446.gd42b38dfb5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    Feature ioremap_prot only needs an implementation of pte_pgprot on riscv.
    That macro is similar to the same one on platform loongarch, mips and sh.
    We just need:
    1. replace _PFN_MASK with _PAGE_PFN_MASK in pte_gpprot;
    2. add "select HAVE_IOREMAP_PROT" into arch/riscv/Kconfig;
    3. add "depends on MMU" into drivers/fpga/Kconfig to fix the building error "undefined reference to generic_access_phys".

    Signed-off-by: Jianwen Jiang <jiangjianwen@uniontech.com>
---
 arch/riscv/Kconfig            | 1 +
 arch/riscv/include/asm/page.h | 2 ++
 drivers/fpga/Kconfig          | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fa78595a6089..5ed2c7361040 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -95,6 +95,7 @@ config RISCV
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_GCC_PLUGINS
 	select HAVE_GENERIC_VDSO if MMU && 64BIT
+	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KPROBES if !XIP_KERNEL
 	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index ac70b0fd9a9a..cb08a4911d60 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -84,6 +84,8 @@ typedef struct page *pgtable_t;
 #define __pgd(x)	((pgd_t) { (x) })
 #define __pgprot(x)	((pgprot_t) { (x) })
 
+#define pte_pgprot(x)  __pgprot(pte_val(x) & ~_PAGE_PFN_MASK)
+
 #ifdef CONFIG_64BIT
 #define PTE_FMT "%016lx"
 #else
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index bbe0a7cabb75..0493272b8bff 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -5,6 +5,7 @@
 
 menuconfig FPGA
 	tristate "FPGA Configuration Framework"
+	depends on MMU
 	help
 	  Say Y here if you want support for configuring FPGAs from the
 	  kernel.  The FPGA framework adds an FPGA manager class and FPGA
-- 
2.37.3.446.gd42b38dfb5

