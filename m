Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193BE68F421
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjBHRQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjBHRQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:16:32 -0500
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE5429436
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1675876590;
        bh=KqQlLM65Y+42Fzaj+u5LF59N7vKKvEZNbihd+mJCsx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MVL/l6kUiZfPLh/gLfrTpJEPAlvyM5VsrmcLwFxYDTWntpd3sTe5QN4PvCLenOlI8
         DlKthMbYgk6B+W59CxJyI3H+bpTny2zaHdYXaUz2F7wfmwEvxxyMoXsDG4gZHBECJL
         pwuH06A0mO7Kl+Md9pLTJNAZPmhFPhJJeAjiYUl8=
Received: from xry111-x57s1.. (unknown [IPv6:240e:358:1174:d100:dc73:854d:832e:3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id BAFBA65C52;
        Wed,  8 Feb 2023 12:16:26 -0500 (EST)
From:   Xi Ruoyao <xry111@xry111.site>
To:     Youling Tang <tangyouling@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jinyang He <hejinyang@loongson.cn>
Cc:     Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v3 1/5] LoongArch: Use la.pcrel instead of la.abs when it's trivially possible
Date:   Thu,  9 Feb 2023 01:16:03 +0800
Message-Id: <20230208171607.391107-2-xry111@xry111.site>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208171607.391107-1-xry111@xry111.site>
References: <20230208171607.391107-1-xry111@xry111.site>
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
2.39.1

