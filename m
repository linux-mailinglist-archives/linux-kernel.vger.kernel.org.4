Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E7B608CF4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiJVLtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiJVLsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:48:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA38424FEC7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 04:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=TK/Z6RlKcsjeIiMJAK610lvWrcZp9kpetOjgnaxEVyk=; b=BukeXEN+MIjiqbC4c+Me1GShNp
        3NJEOydsKmBtXlCm9wZSBPlu7rh1Tpdlku9TEONhdRsvIEUUB+bqMHMSm1mvu7KAgQPtSwMg4xvVP
        Y8xYk+e0IhS0rasaGjclCuquJU+ICuftzGWoGhAr8Zz1A+LQFPCC3Vx3cw7UAs74Lh2KxPL1vNJnA
        7F4+ebmeUEF0Y0T/0KGU0Qh4x75bo4Pi7iIXE/tgZgByH3FEN75c7yP7CWc522xWgxDQzT/j/YQII
        y60Lvw31VYz/F7wfeNBNBsmpc4sJJDb665REzL/H0+BzHuN2LAKPzZnF+fbzi2K4hiN5y/0t+Y58q
        da2+8wqw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omCzR-00Dtgu-Ja; Sat, 22 Oct 2022 11:48:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BDB1E301FC4;
        Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2C25E28B8E510; Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Message-ID: <20221022114424.776404066@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 22 Oct 2022 13:14:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, willy@infradead.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
Subject: [PATCH 05/13] mm: Rename GUP_GET_PTE_LOW_HIGH
References: <20221022111403.531902164@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since it no longer applies to only PTEs, rename it to PXX.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/mips/Kconfig       |    2 +-
 arch/sh/Kconfig         |    2 +-
 arch/x86/Kconfig        |    2 +-
 include/linux/pgtable.h |    4 ++--
 mm/Kconfig              |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

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
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -305,7 +305,7 @@ static inline pmd_t pmdp_get(pmd_t *pmdp
 }
 #endif
 
-#ifdef CONFIG_GUP_GET_PTE_LOW_HIGH
+#ifdef CONFIG_GUP_GET_PXX_LOW_HIGH
 /*
  * For walking the pagetables without holding any locks.  Some architectures
  * (eg x86-32 PAE) cannot load the entries atomically without using expensive
@@ -365,7 +365,7 @@ static inline pmd_t pmdp_get_lockless(pm
 }
 #define pmdp_get_lockless pmdp_get_lockless
 #endif /* CONFIG_PGTABLE_LEVELS > 2 */
-#endif /* CONFIG_GUP_GET_PTE_LOW_HIGH */
+#endif /* CONFIG_GUP_GET_PXX_LOW_HIGH */
 
 /*
  * We require that the PTE can be read atomically.
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1044,7 +1044,7 @@ config GUP_TEST
 comment "GUP_TEST needs to have DEBUG_FS enabled"
 	depends on !GUP_TEST && !DEBUG_FS
 
-config GUP_GET_PTE_LOW_HIGH
+config GUP_GET_PXX_LOW_HIGH
 	bool
 
 config ARCH_HAS_PTE_SPECIAL


