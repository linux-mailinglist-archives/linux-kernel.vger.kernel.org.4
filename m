Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4010D64FBE8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 19:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiLQS5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 13:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiLQSzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 13:55:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C6429E;
        Sat, 17 Dec 2022 10:55:37 -0800 (PST)
Date:   Sat, 17 Dec 2022 18:55:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671303333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QZ7G8DdnJbJkLuBIHKD3A8tjle3Vsm81cafdXatLT7g=;
        b=EcFYhhsm5dYt+3OdkmRxE8HTjBTP8fK+BrkZkJiLgTc2Qzn0pG55hA3NJtWy78UmW9wNI+
        nlN7j/NIqAsxdEw/unnJtS3wvbOmrMN77aoNOg0lfmG1wzzGiKFGfmCBZ1gYTrqx4yUd9L
        v/cxjJ3kQ9VogOTaNmX+jcUZZqfWBt4hYhldi9hHYf3AfZR9AlmvluxdoWW8abOedG/CCg
        71p6wNDA4QBZNYe0xDgzWSL2GTnAkrVP93w6RZba26KdoceFNEoq1g0cgCXOhzxgMPw072
        wX4fL357CTs1rzTScpkiuwOTMSRxWxaOxemSUxnNZPo4U2oyqvP47Ar9VrRBSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671303333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QZ7G8DdnJbJkLuBIHKD3A8tjle3Vsm81cafdXatLT7g=;
        b=14L+lsiJvuW+a3DBXFBWT/z7jeGcQSdVRy/m2urqUxYqPiyTExDbotzdUhD1R0J24UymTx
        OacEC/FXl3EC/2AA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] mm: Rename GUP_GET_PTE_LOW_HIGH
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167130333346.4906.12446557215962501207.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     6ca297d4784625de7b041e8451780643cf5751a4
Gitweb:        https://git.kernel.org/tip/6ca297d4784625de7b041e8451780643cf5751a4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 21 Oct 2022 14:51:44 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Dec 2022 10:37:27 -08:00

mm: Rename GUP_GET_PTE_LOW_HIGH

Since it no longer applies to only PTEs, rename it to PXX.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221022114424.776404066%40infradead.org
---
 arch/mips/Kconfig       | 2 +-
 arch/sh/Kconfig         | 2 +-
 arch/x86/Kconfig        | 2 +-
 include/linux/pgtable.h | 4 ++--
 mm/Kconfig              | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b26b776..15cb692 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -46,7 +46,7 @@ config MIPS
 	select GENERIC_SCHED_CLOCK if !CAVIUM_OCTEON_SOC
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
-	select GUP_GET_PTE_LOW_HIGH if CPU_MIPS32 && PHYS_ADDR_T_64BIT
+	select GUP_GET_PXX_LOW_HIGH if CPU_MIPS32 && PHYS_ADDR_T_64BIT
 	select HAVE_ARCH_COMPILER_H
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KGDB if MIPS_FP_SUPPORT
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 5f220e9..0665ac0 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -24,7 +24,7 @@ config SUPERH
 	select GENERIC_PCI_IOMAP if PCI
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
-	select GUP_GET_PTE_LOW_HIGH if X2TLB
+	select GUP_GET_PXX_LOW_HIGH if X2TLB
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_SECCOMP_FILTER
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 67745ce..bb1f326 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -157,7 +157,7 @@ config X86
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_VDSO_TIME_NS
-	select GUP_GET_PTE_LOW_HIGH		if X86_PAE
+	select GUP_GET_PXX_LOW_HIGH		if X86_PAE
 	select HARDIRQS_SW_RESEND
 	select HARDLOCKUP_CHECK_TIMESTAMP	if X86_64
 	select HAVE_ACPI_APEI			if ACPI
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 765fd4b..7dd3df7 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -305,7 +305,7 @@ static inline pmd_t pmdp_get(pmd_t *pmdp)
 }
 #endif
 
-#ifdef CONFIG_GUP_GET_PTE_LOW_HIGH
+#ifdef CONFIG_GUP_GET_PXX_LOW_HIGH
 /*
  * For walking the pagetables without holding any locks.  Some architectures
  * (eg x86-32 PAE) cannot load the entries atomically without using expensive
@@ -365,7 +365,7 @@ static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
 }
 #define pmdp_get_lockless pmdp_get_lockless
 #endif /* CONFIG_PGTABLE_LEVELS > 2 */
-#endif /* CONFIG_GUP_GET_PTE_LOW_HIGH */
+#endif /* CONFIG_GUP_GET_PXX_LOW_HIGH */
 
 /*
  * We require that the PTE can be read atomically.
diff --git a/mm/Kconfig b/mm/Kconfig
index 57e1d8c..0eabd0b 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1044,7 +1044,7 @@ config GUP_TEST
 comment "GUP_TEST needs to have DEBUG_FS enabled"
 	depends on !GUP_TEST && !DEBUG_FS
 
-config GUP_GET_PTE_LOW_HIGH
+config GUP_GET_PXX_LOW_HIGH
 	bool
 
 config ARCH_HAS_PTE_SPECIAL
