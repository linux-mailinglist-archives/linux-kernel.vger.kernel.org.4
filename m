Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4AA6FCA02
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 17:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbjEIPPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 11:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjEIPPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 11:15:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917DE40F3
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 08:15:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 218D362C76
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 15:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6BDC433EF;
        Tue,  9 May 2023 15:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683645345;
        bh=ueNs2jSBg81BPlBmRMQAY6QrnRrosCgVLhmITxyBbpo=;
        h=From:To:Cc:Subject:Date:From;
        b=osh+Lrc1XkB/Jv8dmOxZXma85u4raRZFwdPVEux+HyijVxApGpdMiD/jmb+M5QF9F
         Y3YvdKu7nC5GoJQKHc3loiJqzWpV3k5l67ceBi8iPmAIqKr8NqYOrDkOrr92hj3BkO
         /SVDS5fQODKXcw+qCGF6CPNNSBZ2oC1reTJ7f+W6eECP6DEGqeISiLaZ3UYFCXZczy
         HUOXeLNCdLK4RjGhjSjOq5a+NacxaQFJPKypgSre66FvGGPBQp5YDdhieshYIAvCFw
         6t2TLE578gsbZQpDeO7Qaf5jYJAVvPFdXgLWkw97pntvfNq/USDm3bUpcNwiwPNmJV
         tHwdFiKUOdNcQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: mm: stub extable related functions/macros for !MMU
Date:   Tue,  9 May 2023 23:04:39 +0800
Message-Id: <20230509150439.612-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

extable relies on the MMU to work properly, so it's useless to
include __ex_table sections and build extable related functions for
!MMU case.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/asm-extable.h | 6 ++++++
 arch/riscv/include/asm/extable.h     | 4 ++++
 arch/riscv/mm/Makefile               | 3 +--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/asm-extable.h b/arch/riscv/include/asm/asm-extable.h
index 14be0673f5b5..909d6beaf499 100644
--- a/arch/riscv/include/asm/asm-extable.h
+++ b/arch/riscv/include/asm/asm-extable.h
@@ -7,6 +7,8 @@
 #define EX_TYPE_BPF			2
 #define EX_TYPE_UACCESS_ERR_ZERO	3
 
+#ifdef MMU
+
 #ifdef __ASSEMBLY__
 
 #define __ASM_EXTABLE_RAW(insn, fixup, type, data)	\
@@ -62,4 +64,8 @@
 
 #endif /* __ASSEMBLY__ */
 
+#else /* CONFIG_MMU */
+	#define _ASM_EXTABLE_UACCESS_ERR(insn, fixup, err)
+#endif /* CONFIG_MMU */
+
 #endif /* __ASM_ASM_EXTABLE_H */
diff --git a/arch/riscv/include/asm/extable.h b/arch/riscv/include/asm/extable.h
index 512012d193dc..3eb5c1f7bf34 100644
--- a/arch/riscv/include/asm/extable.h
+++ b/arch/riscv/include/asm/extable.h
@@ -32,7 +32,11 @@ do {							\
 	(b)->data = (tmp).data;				\
 } while (0)
 
+#ifdef CONFIG_MMU
 bool fixup_exception(struct pt_regs *regs);
+#else
+static inline bool fixup_exception(struct pt_regs *regs) { return false; }
+#endif
 
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_ARCH_RV64I)
 bool ex_handler_bpf(const struct exception_table_entry *ex, struct pt_regs *regs);
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index b85e9e82f082..9c454f90fd3d 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -13,8 +13,7 @@ endif
 KCOV_INSTRUMENT_init.o := n
 
 obj-y += init.o
-obj-y += extable.o
-obj-$(CONFIG_MMU) += fault.o pageattr.o
+obj-$(CONFIG_MMU) += extable.o fault.o pageattr.o
 obj-y += cacheflush.o
 obj-y += context.o
 obj-y += pgtable.o
-- 
2.40.0

