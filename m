Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B34662B19B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 03:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiKPC6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 21:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiKPC6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 21:58:02 -0500
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C1025D5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 18:57:57 -0800 (PST)
X-QQ-mid: bizesmtp71t1668567442t45i2o4u
Received: from utnb-jevon.. ( [101.6.93.65])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 16 Nov 2022 10:57:12 +0800 (CST)
X-QQ-SSF: 0140000000000040B000000A0000000
X-QQ-FEAT: du0rsRKm0AHCqbU+MdZ/TF1wNfklu76Gj6AnB5f+Jiq+wn0GMe7zFBachZjAh
        SSWtuSd6/xn7tPWqtiv6W+4CfLb6U80eA789/LDfv/cbEBwWxZcpELpWAi8jCvm0C5YT3V2
        Lz+YRBrpgUBBdqqo2npfPmuw6k9kVqu3Q6L1p96G95aBnK45UsiYpAbGVwBADs+8H2djbva
        IxA98Rz8ETnldnTX6BlLCUehegtnJ8ha7o6ufXLNnJnFgDqzN+bKn2y6twB95a5GqHk5lPc
        Sn287HmKMBUVp+/KPAjvsDIAMwBhZeRxFSCUdOub7Boaj9DIYx1LT7nB1sK7maPDFOdEbJH
        SMGk6H38/TISxWwqNHRrhLzGVybE7xs5NhUkUYzvHMeHQjCRII+WjgcfxP67w==
X-QQ-GoodBg: 1
From:   Jianwen Jiang <jiangjianwen@uniontech.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alexandre.ghiti@canonical.comp,
        geert@linux-m68k.org, panqinglin2020@iscas.ac.cn, arnd@arndb.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jianwen Jiang <jiangjianwen@uniontech.com>
Subject: [PATCH] riscv: Implement ioremap_prot support
Date:   Wed, 16 Nov 2022 10:57:09 +0800
Message-Id: <20221116025709.27368-1-jiangjianwen@uniontech.com>
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
That macro is similar on platform loongarch, mips and sh.
We just need to replace _PFN_MASK with _PAGE_PFN_MASK, and select
HAVE_IOREMAP_PROT in arch/riscv/Kconfig.

Signed-off-by: Jianwen Jiang <jiangjianwen@uniontech.com>
---
 arch/riscv/Kconfig            | 1 +
 arch/riscv/include/asm/page.h | 2 ++
 2 files changed, 3 insertions(+)

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
index ac70b0fd9a9a..d379b4702849 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -84,6 +84,8 @@ typedef struct page *pgtable_t;
 #define __pgd(x)	((pgd_t) { (x) })
 #define __pgprot(x)	((pgprot_t) { (x) })
 
+#define pte_pgprot(x)	__pgprot(pte_val(x) & ~_PAGE_PFN_MASK)
+
 #ifdef CONFIG_64BIT
 #define PTE_FMT "%016lx"
 #else
-- 
2.37.3.446.gd42b38dfb5

