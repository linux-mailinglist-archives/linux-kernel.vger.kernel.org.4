Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F026FCA5A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 17:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbjEIPhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 11:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjEIPht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 11:37:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AEE19A4
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 08:37:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3616B60D24
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 15:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C824EC433D2;
        Tue,  9 May 2023 15:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683646667;
        bh=FByPzvBStNqHUfRWd9lr/eiev+34CMu90xFrzHsEDhY=;
        h=From:To:Cc:Subject:Date:From;
        b=k6KScQglaZq1S9PBBnYM4QsLoCZmvYpyWTWAla94VYTVzgMHUgFx5Lfv0SAywuSdf
         L3tXm7rZI1jDrIoD810mafHx2ngaznzAFV/nWu5yNkwHMdO1XzY6g8HaSJRXLbXYs5
         ivzCx0T5XyB6dMRHFtlbOWOQQmiaph1pD4BgrWIyEW9XiRFsnFzwVX1E6NtYSWphHx
         bkQz9meyCERBguqRn4Et2XTTa+z9U1PZbiPt9jYD8z1BklyHkqNyRqgf+gMHOW/1uJ
         bALL4wjzacJ7bGvnnqbXUMFt0D/uX3fvakwzU6MDbv2cPVVgpL0NONOn3ovHxhw1Ks
         NUF29nSSwJz/A==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] riscv: mm: stub extable related functions/macros for !MMU
Date:   Tue,  9 May 2023 23:26:41 +0800
Message-Id: <20230509152641.805-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

Since v1:
 - fix a typo: s/MMU/CONFIG_MMU

 arch/riscv/include/asm/asm-extable.h | 6 ++++++
 arch/riscv/include/asm/extable.h     | 4 ++++
 arch/riscv/mm/Makefile               | 3 +--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/asm-extable.h b/arch/riscv/include/asm/asm-extable.h
index 14be0673f5b5..00a96e7a9664 100644
--- a/arch/riscv/include/asm/asm-extable.h
+++ b/arch/riscv/include/asm/asm-extable.h
@@ -7,6 +7,8 @@
 #define EX_TYPE_BPF			2
 #define EX_TYPE_UACCESS_ERR_ZERO	3
 
+#ifdef CONFIG_MMU
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

