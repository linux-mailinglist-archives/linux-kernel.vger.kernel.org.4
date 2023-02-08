Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D8E68FA72
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 23:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjBHWxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 17:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjBHWxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 17:53:36 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D06525282
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 14:53:33 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pPtJi-0003OP-Vu; Wed, 08 Feb 2023 23:53:31 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@rivosinc.com
Cc:     conor@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, christoph.muellner@vrull.eu,
        ajones@ventanamicro.com, Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH 2/2] RISC-V: improve string-function assembly
Date:   Wed,  8 Feb 2023 23:53:28 +0100
Message-Id: <20230208225328.1636017-3-heiko@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230208225328.1636017-1-heiko@sntech.de>
References: <20230208225328.1636017-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

Adapt the suggestions for the assembly string functions that Andrew
suggested but that I didn't manage to include into the series that
got applied.

This includes improvements to two comments, removal of unneeded labels
and moving one instruction slightly higher to contradict an
explanatory comment.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/lib/strcmp.S  |  6 ++++--
 arch/riscv/lib/strlen.S  | 10 +++++-----
 arch/riscv/lib/strncmp.S | 16 +++++++---------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/lib/strcmp.S b/arch/riscv/lib/strcmp.S
index 8148b6418f61..fb186bf28f07 100644
--- a/arch/riscv/lib/strcmp.S
+++ b/arch/riscv/lib/strcmp.S
@@ -40,7 +40,9 @@ SYM_FUNC_START(strcmp)
 	ret
 
 /*
- * Variant of strcmp using the ZBB extension if available
+ * Variant of strcmp using the ZBB extension if available.
+ * The code was published as part of the bitmanip manual
+ * in Appendix A.
  */
 #ifdef CONFIG_RISCV_ISA_ZBB
 strcmp_zbb:
@@ -57,7 +59,7 @@ strcmp_zbb:
 	 *   a1 - string2
 	 *
 	 * Clobbers
-	 *   t0, t1, t2, t3, t4, t5
+	 *   t0, t1, t2, t3, t4
 	 */
 
 	or	t2, a0, a1
diff --git a/arch/riscv/lib/strlen.S b/arch/riscv/lib/strlen.S
index 0f9dbf93301a..898466f67000 100644
--- a/arch/riscv/lib/strlen.S
+++ b/arch/riscv/lib/strlen.S
@@ -96,7 +96,7 @@ strlen_zbb:
 	 * of valid bytes in this chunk.
 	 */
 	srli	a0, t1, 3
-	bgtu	t3, a0, 3f
+	bgtu	t3, a0, 2f
 
 	/* Prepare for the word comparison loop. */
 	addi	t2, t0, SZREG
@@ -112,20 +112,20 @@ strlen_zbb:
 	addi	t0, t0, SZREG
 	orc.b	t1, t1
 	beq	t1, t3, 1b
-2:
+
 	not	t1, t1
 	CZ	t1, t1
+	srli	t1, t1, 3
 
-	/* Get number of processed words.  */
+	/* Get number of processed bytes. */
 	sub	t2, t0, t2
 
 	/* Add number of characters in the first word.  */
 	add	a0, a0, t2
-	srli	t1, t1, 3
 
 	/* Add number of characters in the last word.  */
 	add	a0, a0, t1
-3:
+2:
 	ret
 
 .option pop
diff --git a/arch/riscv/lib/strncmp.S b/arch/riscv/lib/strncmp.S
index 7940ddab2d48..e36f5a6e1b16 100644
--- a/arch/riscv/lib/strncmp.S
+++ b/arch/riscv/lib/strncmp.S
@@ -70,7 +70,7 @@ strncmp_zbb:
 	li	t5, -1
 	and	t2, t2, SZREG-1
 	add	t4, a0, a2
-	bnez	t2, 4f
+	bnez	t2, 3f
 
 	/* Adjust limit for fast-path.  */
 	andi	t6, t4, -SZREG
@@ -114,23 +114,21 @@ strncmp_zbb:
 	ret
 
 	/* Simple loop for misaligned strings.  */
-3:
-	/* Restore limit for slow-path.  */
 	.p2align 3
-4:
-	bge	a0, t4, 6f
+3:
+	bge	a0, t4, 5f
 	lbu	t0, 0(a0)
 	lbu	t1, 0(a1)
 	addi	a0, a0, 1
 	addi	a1, a1, 1
-	bne	t0, t1, 5f
-	bnez	t0, 4b
+	bne	t0, t1, 4f
+	bnez	t0, 3b
 
-5:
+4:
 	sub	a0, t0, t1
 	ret
 
-6:
+5:
 	li	a0, 0
 	ret
 
-- 
2.39.0

