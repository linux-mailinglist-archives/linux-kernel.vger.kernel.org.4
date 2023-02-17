Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A5069A612
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 08:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjBQH0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 02:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjBQH0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 02:26:51 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C51645DE09
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 23:26:42 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxONkxLO9jNK4BAA--.3838S3;
        Fri, 17 Feb 2023 15:26:41 +0800 (CST)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxf+QmLO9jiSQ1AA--.63745S4;
        Fri, 17 Feb 2023 15:26:41 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>,
        Jinyang He <hejinyang@loongson.cn>
Cc:     Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/5] LoongArch: Add JUMP_VIRT_ADDR macro implementation to avoid using la.abs
Date:   Fri, 17 Feb 2023 15:26:26 +0800
Message-Id: <1676618789-20485-3-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1676618789-20485-1-git-send-email-tangyouling@loongson.cn>
References: <1676618789-20485-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8Cxf+QmLO9jiSQ1AA--.63745S4
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7WF4kuw4ruFW3Jr13WF13XFb_yoW8Kw48pr
        nIvr4kGFWUGFn3AFyUt34j9r4UJa1vk3WaganFya40yF4aqryDX34vkr1DXF1qva1rJrW0
        9F1fGwsIqF4UX3JanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b28YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07josjUUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add JUMP_VIRT_ADDR macro implementation to avoid using la.abs.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/loongarch/include/asm/stackframe.h |  9 +++++++++
 arch/loongarch/kernel/head.S            | 12 ++++--------
 arch/loongarch/power/suspend_asm.S      |  5 ++---
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
index 7deb043ce387..855c9d9e3210 100644
--- a/arch/loongarch/include/asm/stackframe.h
+++ b/arch/loongarch/include/asm/stackframe.h
@@ -10,6 +10,7 @@
 #include <asm/asm.h>
 #include <asm/asmmacro.h>
 #include <asm/asm-offsets.h>
+#include <asm/addrspace.h>
 #include <asm/loongarch.h>
 #include <asm/thread_info.h>
 
@@ -216,4 +217,12 @@
 	RESTORE_SP_AND_RET \docfi
 	.endm
 
+/* Jump to the virtual address. */
+	.macro JUMP_VIRT_ADDR temp1 temp2
+	li.d	\temp1, CACHE_BASE
+	pcaddi	\temp2, 0
+	or	\temp1, \temp1, \temp2
+	jirl	zero, \temp1, 0xc
+	.endm
+
 #endif /* _ASM_STACKFRAME_H */
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index aa6181714ec3..d2ac26b5b22b 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -50,11 +50,8 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
 	li.d		t0, CSR_DMW1_INIT	# CA, PLV0, 0x9000 xxxx xxxx xxxx
 	csrwr		t0, LOONGARCH_CSR_DMWIN1
 
-	/* We might not get launched at the address the kernel is linked to,
-	   so we jump there.  */
-	la.abs		t0, 0f
-	jr		t0
-0:
+	JUMP_VIRT_ADDR	t0, t1
+
 	/* Enable PG */
 	li.w		t0, 0xb0		# PLV=0, IE=0, PG=1
 	csrwr		t0, LOONGARCH_CSR_CRMD
@@ -106,9 +103,8 @@ SYM_CODE_START(smpboot_entry)
 	li.d		t0, CSR_DMW1_INIT	# CA, PLV0
 	csrwr		t0, LOONGARCH_CSR_DMWIN1
 
-	la.abs		t0, 0f
-	jr		t0
-0:
+	JUMP_VIRT_ADDR	t0, t1
+
 	/* Enable PG */
 	li.w		t0, 0xb0		# PLV=0, IE=0, PG=1
 	csrwr		t0, LOONGARCH_CSR_CRMD
diff --git a/arch/loongarch/power/suspend_asm.S b/arch/loongarch/power/suspend_asm.S
index eb2675642f9f..90da899c06a1 100644
--- a/arch/loongarch/power/suspend_asm.S
+++ b/arch/loongarch/power/suspend_asm.S
@@ -78,9 +78,8 @@ SYM_INNER_LABEL(loongarch_wakeup_start, SYM_L_GLOBAL)
 	li.d		t0, CSR_DMW1_INIT	# CA, PLV0
 	csrwr		t0, LOONGARCH_CSR_DMWIN1
 
-	la.abs		t0, 0f
-	jr		t0
-0:
+	JUMP_VIRT_ADDR	t0, t1
+
 	la.pcrel	t0, acpi_saved_sp
 	ld.d		sp, t0, 0
 	SETUP_WAKEUP
-- 
2.37.3

