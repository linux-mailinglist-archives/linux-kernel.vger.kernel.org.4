Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F45A691A45
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 09:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjBJIrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 03:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjBJIrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 03:47:46 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D66827B177
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 00:47:43 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8CxIfCuBOZjV8AQAA--.33585S3;
        Fri, 10 Feb 2023 16:47:42 +0800 (CST)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxX+SpBOZjLUYwAA--.56353S3;
        Fri, 10 Feb 2023 16:47:42 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>,
        Jinyang He <hejinyang@loongson.cn>
Cc:     Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] LoongArch: Use la.pcrel instead of la.abs when it's trivially possible
Date:   Fri, 10 Feb 2023 16:47:32 +0800
Message-Id: <1676018856-26520-2-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1676018856-26520-1-git-send-email-tangyouling@loongson.cn>
References: <1676018856-26520-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8AxX+SpBOZjLUYwAA--.56353S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Wryxtr1DCr4xAr1DJFW3trb_yoW5JFWUpr
        nxZr1kJFW8WFn3A34Dt34UurWDJ3Wqgw1ag3ZFkFyrZr42qF1UXr1kAryDZFyjqayrGay0
        gF1rG39IqF45J37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
        0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1LiSJUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xi Ruoyao <xry111@xry111.site>

Let's start to kill la.abs inpreparation for the subsequent support of the
PIE kernel.

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/include/asm/stackframe.h | 2 +-
 arch/loongarch/include/asm/uaccess.h    | 1 -
 arch/loongarch/kernel/entry.S           | 2 +-
 arch/loongarch/kernel/head.S            | 2 +-
 arch/loongarch/mm/tlbex.S               | 3 +--
 5 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
index 4ca953062b5b..7deb043ce387 100644
--- a/arch/loongarch/include/asm/stackframe.h
+++ b/arch/loongarch/include/asm/stackframe.h
@@ -90,7 +90,7 @@
 	.endm
 
 	.macro	set_saved_sp stackp temp temp2
-	la.abs	  \temp, kernelsp
+	la.pcrel  \temp, kernelsp
 #ifdef CONFIG_SMP
 	LONG_ADD  \temp, \temp, u0
 #endif
diff --git a/arch/loongarch/include/asm/uaccess.h b/arch/loongarch/include/asm/uaccess.h
index 255899d4a7c3..0d22991ae430 100644
--- a/arch/loongarch/include/asm/uaccess.h
+++ b/arch/loongarch/include/asm/uaccess.h
@@ -22,7 +22,6 @@
 extern u64 __ua_limit;
 
 #define __UA_ADDR	".dword"
-#define __UA_LA		"la.abs"
 #define __UA_LIMIT	__ua_limit
 
 /*
diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
index d53b631c9022..2566977f2f68 100644
--- a/arch/loongarch/kernel/entry.S
+++ b/arch/loongarch/kernel/entry.S
@@ -20,7 +20,7 @@
 	.align	5
 SYM_FUNC_START(handle_syscall)
 	csrrd	t0, PERCPU_BASE_KS
-	la.abs	t1, kernelsp
+	la.pcrel	t1, kernelsp
 	add.d	t1, t1, t0
 	move	t2, sp
 	ld.d	sp, t1, 0
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index 57bada6b4e93..aa6181714ec3 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -117,7 +117,7 @@ SYM_CODE_START(smpboot_entry)
 	li.w		t0, 0x00		# FPE=0, SXE=0, ASXE=0, BTE=0
 	csrwr		t0, LOONGARCH_CSR_EUEN
 
-	la.abs		t0, cpuboot_data
+	la.pcrel	t0, cpuboot_data
 	ld.d		sp, t0, CPU_BOOT_STACK
 	ld.d		tp, t0, CPU_BOOT_TINFO
 
diff --git a/arch/loongarch/mm/tlbex.S b/arch/loongarch/mm/tlbex.S
index 58781c6e4191..3dd2a9615cd9 100644
--- a/arch/loongarch/mm/tlbex.S
+++ b/arch/loongarch/mm/tlbex.S
@@ -24,8 +24,7 @@
 	move		a0, sp
 	REG_S		a2, sp, PT_BVADDR
 	li.w		a1, \write
-	la.abs		t0, do_page_fault
-	jirl		ra, t0, 0
+	bl		do_page_fault
 	RESTORE_ALL_AND_RET
 	SYM_FUNC_END(tlb_do_page_fault_\write)
 	.endm
-- 
2.37.3

