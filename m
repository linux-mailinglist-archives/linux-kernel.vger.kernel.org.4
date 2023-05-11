Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945676FE97A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 03:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbjEKBbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 21:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjEKBbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 21:31:21 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E62D14EDD
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 18:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Mxl2w
        NE+hmoN5CP0uUbBqPWQ/Uij5D+8xp99kCZL0l4=; b=NgycCNmjS/iGd+YGRwyZJ
        1KtUjA98iDtPZCKQGpSqcDvaRFDfMyMAZhmSuei6wclVes57hqL75bJpIsA18Zy0
        jcFMJaxSD383KKfvvt/qz2KU3QgTZODu6xSLUadZIrRlX2nlpFx9XJu0y9Vq20ut
        HvEOH5pslsyLGgO2ZrUzXg=
Received: from zhangf-virtual-machine.localdomain (unknown [180.111.102.183])
        by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wDX3uZPRVxk0OcZBg--.52349S2;
        Thu, 11 May 2023 09:30:56 +0800 (CST)
From:   zhangfei <zhang_fei_0403@163.com>
To:     zhang_fei_0403@163.com
Cc:     ajones@ventanamicro.com, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, zhangfei@nj.iscas.ac.cn
Subject: [PATCH v2 1/2] RISC-V: lib: Improve memset assembler formatting
Date:   Thu, 11 May 2023 09:30:52 +0800
Message-Id: <20230511013052.3255-1-zhang_fei_0403@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511012604.3222-1-zhang_fei_0403@163.com>
References: <20230511012604.3222-1-zhang_fei_0403@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDX3uZPRVxk0OcZBg--.52349S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF4fGF13Aw45Cr4kArW8Zwb_yoWrtF4fpw
        4fG34rGayqkF1rW34YqFyrtFWDJw4Sq3Z5Xw1ayr12kr1UKry7Za4qqFW5twnFyrW3ur4D
        ZF1DJrW7ZFy5XrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U79N-UUUUU=
X-Originating-IP: [180.111.102.183]
X-CM-SenderInfo: x2kd0w5bihxsiquqjqqrwthudrp/xtbCfApsl2DcJgttvwAAsO
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Jones <ajones@ventanamicro.com>

Aligning the first operand of each instructions with a tab is a
typical style which improves readability. Apply it to memset.S.
While there, we also make a small grammar change to a comment.

No functional change intended.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Fei Zhang <zhangfei@nj.iscas.ac.cn>
---
 arch/riscv/lib/memset.S | 143 ++++++++++++++++++++--------------------
 1 file changed, 72 insertions(+), 71 deletions(-)

diff --git a/arch/riscv/lib/memset.S b/arch/riscv/lib/memset.S
index 34c5360c6705..e613c5c27998 100644
--- a/arch/riscv/lib/memset.S
+++ b/arch/riscv/lib/memset.S
@@ -3,111 +3,112 @@
  * Copyright (C) 2013 Regents of the University of California
  */
 
-
 #include <linux/linkage.h>
 #include <asm/asm.h>
 
 /* void *memset(void *, int, size_t) */
 ENTRY(__memset)
 WEAK(memset)
-	move t0, a0  /* Preserve return value */
+	move	t0, a0			/* Preserve return value */
 
 	/* Defer to byte-oriented fill for small sizes */
-	sltiu a3, a2, 16
-	bnez a3, 4f
+	sltiu	a3, a2, 16
+	bnez	a3, 4f
 
 	/*
 	 * Round to nearest XLEN-aligned address
-	 * greater than or equal to start address
+	 * greater than or equal to the start address.
 	 */
-	addi a3, t0, SZREG-1
-	andi a3, a3, ~(SZREG-1)
-	beq a3, t0, 2f  /* Skip if already aligned */
+	addi	a3, t0, SZREG-1
+	andi	a3, a3, ~(SZREG-1)
+	beq	a3, t0, 2f		/* Skip if already aligned */
+
 	/* Handle initial misalignment */
-	sub a4, a3, t0
+	sub	a4, a3, t0
 1:
-	sb a1, 0(t0)
-	addi t0, t0, 1
-	bltu t0, a3, 1b
-	sub a2, a2, a4  /* Update count */
+	sb	a1, 0(t0)
+	addi	t0, t0, 1
+	bltu	t0, a3, 1b
+	sub	a2, a2, a4		/* Update count */
 
 2: /* Duff's device with 32 XLEN stores per iteration */
 	/* Broadcast value into all bytes */
-	andi a1, a1, 0xff
-	slli a3, a1, 8
-	or a1, a3, a1
-	slli a3, a1, 16
-	or a1, a3, a1
+	andi	a1, a1, 0xff
+	slli	a3, a1, 8
+	or	a1, a3, a1
+	slli	a3, a1, 16
+	or	a1, a3, a1
 #ifdef CONFIG_64BIT
-	slli a3, a1, 32
-	or a1, a3, a1
+	slli	a3, a1, 32
+	or	a1, a3, a1
 #endif
 
 	/* Calculate end address */
-	andi a4, a2, ~(SZREG-1)
-	add a3, t0, a4
+	andi	a4, a2, ~(SZREG-1)
+	add	a3, t0, a4
 
-	andi a4, a4, 31*SZREG  /* Calculate remainder */
-	beqz a4, 3f            /* Shortcut if no remainder */
-	neg a4, a4
-	addi a4, a4, 32*SZREG  /* Calculate initial offset */
+	andi	a4, a4, 31*SZREG	/* Calculate remainder */
+	beqz	a4, 3f			/* Shortcut if no remainder */
+	neg	a4, a4
+	addi	a4, a4, 32*SZREG	/* Calculate initial offset */
 
 	/* Adjust start address with offset */
-	sub t0, t0, a4
+	sub	t0, t0, a4
 
 	/* Jump into loop body */
 	/* Assumes 32-bit instruction lengths */
-	la a5, 3f
+	la	a5, 3f
 #ifdef CONFIG_64BIT
-	srli a4, a4, 1
+	srli	a4, a4, 1
 #endif
-	add a5, a5, a4
-	jr a5
+	add	a5, a5, a4
+	jr	a5
 3:
-	REG_S a1,        0(t0)
-	REG_S a1,    SZREG(t0)
-	REG_S a1,  2*SZREG(t0)
-	REG_S a1,  3*SZREG(t0)
-	REG_S a1,  4*SZREG(t0)
-	REG_S a1,  5*SZREG(t0)
-	REG_S a1,  6*SZREG(t0)
-	REG_S a1,  7*SZREG(t0)
-	REG_S a1,  8*SZREG(t0)
-	REG_S a1,  9*SZREG(t0)
-	REG_S a1, 10*SZREG(t0)
-	REG_S a1, 11*SZREG(t0)
-	REG_S a1, 12*SZREG(t0)
-	REG_S a1, 13*SZREG(t0)
-	REG_S a1, 14*SZREG(t0)
-	REG_S a1, 15*SZREG(t0)
-	REG_S a1, 16*SZREG(t0)
-	REG_S a1, 17*SZREG(t0)
-	REG_S a1, 18*SZREG(t0)
-	REG_S a1, 19*SZREG(t0)
-	REG_S a1, 20*SZREG(t0)
-	REG_S a1, 21*SZREG(t0)
-	REG_S a1, 22*SZREG(t0)
-	REG_S a1, 23*SZREG(t0)
-	REG_S a1, 24*SZREG(t0)
-	REG_S a1, 25*SZREG(t0)
-	REG_S a1, 26*SZREG(t0)
-	REG_S a1, 27*SZREG(t0)
-	REG_S a1, 28*SZREG(t0)
-	REG_S a1, 29*SZREG(t0)
-	REG_S a1, 30*SZREG(t0)
-	REG_S a1, 31*SZREG(t0)
-	addi t0, t0, 32*SZREG
-	bltu t0, a3, 3b
-	andi a2, a2, SZREG-1  /* Update count */
+	REG_S	a1,        0(t0)
+	REG_S	a1,    SZREG(t0)
+	REG_S	a1,  2*SZREG(t0)
+	REG_S	a1,  3*SZREG(t0)
+	REG_S	a1,  4*SZREG(t0)
+	REG_S	a1,  5*SZREG(t0)
+	REG_S	a1,  6*SZREG(t0)
+	REG_S	a1,  7*SZREG(t0)
+	REG_S	a1,  8*SZREG(t0)
+	REG_S	a1,  9*SZREG(t0)
+	REG_S	a1, 10*SZREG(t0)
+	REG_S	a1, 11*SZREG(t0)
+	REG_S	a1, 12*SZREG(t0)
+	REG_S	a1, 13*SZREG(t0)
+	REG_S	a1, 14*SZREG(t0)
+	REG_S	a1, 15*SZREG(t0)
+	REG_S	a1, 16*SZREG(t0)
+	REG_S	a1, 17*SZREG(t0)
+	REG_S	a1, 18*SZREG(t0)
+	REG_S	a1, 19*SZREG(t0)
+	REG_S	a1, 20*SZREG(t0)
+	REG_S	a1, 21*SZREG(t0)
+	REG_S	a1, 22*SZREG(t0)
+	REG_S	a1, 23*SZREG(t0)
+	REG_S	a1, 24*SZREG(t0)
+	REG_S	a1, 25*SZREG(t0)
+	REG_S	a1, 26*SZREG(t0)
+	REG_S	a1, 27*SZREG(t0)
+	REG_S	a1, 28*SZREG(t0)
+	REG_S	a1, 29*SZREG(t0)
+	REG_S	a1, 30*SZREG(t0)
+	REG_S	a1, 31*SZREG(t0)
+
+	addi	t0, t0, 32*SZREG
+	bltu	t0, a3, 3b
+	andi	a2, a2, SZREG-1		/* Update count */
 
 4:
 	/* Handle trailing misalignment */
-	beqz a2, 6f
-	add a3, t0, a2
+	beqz	a2, 6f
+	add	a3, t0, a2
 5:
-	sb a1, 0(t0)
-	addi t0, t0, 1
-	bltu t0, a3, 5b
+	sb	a1, 0(t0)
+	addi	t0, t0, 1
+	bltu	t0, a3, 5b
 6:
 	ret
 END(__memset)
-- 
2.33.0

