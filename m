Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C5968DB8B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjBGOdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjBGObB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:31:01 -0500
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3F43D092
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1675780189;
        bh=W9Fri07rSLvFzK88TTPRH5yOkj10Mz0KpXTA31lQPHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SxCinsc9t5H0OBxUO98edPYsoJl2ESh7ep3lPHDWIM7A91qliL1TqDhkfbQ865ADQ
         vrkqZ6/KspgCZDW1d5bDFMdVW3OFDLDGiFkY23yHkXOxgs6VlkCO4wSFf5klooul5V
         NsnmXm39jE+0kCaXHS49yu/pgsyFiraOOrz6DoPo=
Received: from xry111-x57s1.. (unknown [IPv6:240e:358:11cc:4100:dc73:854d:832e:2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id C87C265DC8;
        Tue,  7 Feb 2023 09:29:44 -0500 (EST)
From:   Xi Ruoyao <xry111@xry111.site>
To:     Youling Tang <tangyouling@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jinyang He <hejinyang@loongson.cn>
Cc:     Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] LoongArch: Add JUMP_LINK_ADDR macro implementation to avoid using la.abs
Date:   Tue,  7 Feb 2023 22:28:20 +0800
Message-Id: <20230207142822.52172-4-xry111@xry111.site>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207142822.52172-1-xry111@xry111.site>
References: <20230207142822.52172-1-xry111@xry111.site>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youling Tang <tangyouling@loongson.cn>

Add JUMP_LINK_ADDR macro implementation to avoid using la.abs.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/loongarch/include/asm/stackframe.h |  8 ++++++++
 arch/loongarch/kernel/head.S            | 10 ++++------
 arch/loongarch/power/suspend_asm.S      |  5 ++---
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
index bbec1e56b61b..cd8240858599 100644
--- a/arch/loongarch/include/asm/stackframe.h
+++ b/arch/loongarch/include/asm/stackframe.h
@@ -217,4 +217,12 @@
 	RESTORE_SP_AND_RET \docfi
 	.endm
 
+/* Jump to the virtual address of the link. */
+	.macro JUMP_LINK_ADDR
+	li.d	t0, CACHE_BASE
+	pcaddi	t1, 0
+	or	t0, t0, t1
+	jirl	zero, t0, 0xc
+	.endm
+
 #endif /* _ASM_STACKFRAME_H */
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index aa6181714ec3..e8a4bf9d7599 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -52,9 +52,8 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
 
 	/* We might not get launched at the address the kernel is linked to,
 	   so we jump there.  */
-	la.abs		t0, 0f
-	jr		t0
-0:
+	JUMP_LINK_ADDR
+
 	/* Enable PG */
 	li.w		t0, 0xb0		# PLV=0, IE=0, PG=1
 	csrwr		t0, LOONGARCH_CSR_CRMD
@@ -106,9 +105,8 @@ SYM_CODE_START(smpboot_entry)
 	li.d		t0, CSR_DMW1_INIT	# CA, PLV0
 	csrwr		t0, LOONGARCH_CSR_DMWIN1
 
-	la.abs		t0, 0f
-	jr		t0
-0:
+	JUMP_LINK_ADDR
+
 	/* Enable PG */
 	li.w		t0, 0xb0		# PLV=0, IE=0, PG=1
 	csrwr		t0, LOONGARCH_CSR_CRMD
diff --git a/arch/loongarch/power/suspend_asm.S b/arch/loongarch/power/suspend_asm.S
index eb2675642f9f..596a682a7924 100644
--- a/arch/loongarch/power/suspend_asm.S
+++ b/arch/loongarch/power/suspend_asm.S
@@ -78,9 +78,8 @@ SYM_INNER_LABEL(loongarch_wakeup_start, SYM_L_GLOBAL)
 	li.d		t0, CSR_DMW1_INIT	# CA, PLV0
 	csrwr		t0, LOONGARCH_CSR_DMWIN1
 
-	la.abs		t0, 0f
-	jr		t0
-0:
+	JUMP_LINK_ADDR
+
 	la.pcrel	t0, acpi_saved_sp
 	ld.d		sp, t0, 0
 	SETUP_WAKEUP
-- 
2.37.0

