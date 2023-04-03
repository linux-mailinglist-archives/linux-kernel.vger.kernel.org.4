Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A1E6D40E1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjDCJmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjDCJlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:41:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8C593DD;
        Mon,  3 Apr 2023 02:41:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EA8D621B45;
        Mon,  3 Apr 2023 09:41:28 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id DAFBB2C14F;
        Mon,  3 Apr 2023 09:41:28 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] MIPS: Remove no longer used ide.h
Date:   Mon,  3 Apr 2023 11:41:11 +0200
Message-Id: <20230403094113.6056-2-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230403094113.6056-1-tsbogend@alpha.franken.de>
References: <20230403094113.6056-1-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=RCVD_IN_DNSWL_MED,SPF_FAIL,
        SPF_HELO_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are only three drivers left using ide.h, which are all m68k only.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/include/asm/ide.h              |  13 ---
 arch/mips/include/asm/mach-generic/ide.h | 138 -----------------------
 2 files changed, 151 deletions(-)
 delete mode 100644 arch/mips/include/asm/ide.h
 delete mode 100644 arch/mips/include/asm/mach-generic/ide.h

diff --git a/arch/mips/include/asm/ide.h b/arch/mips/include/asm/ide.h
deleted file mode 100644
index bb674c3b0303..000000000000
--- a/arch/mips/include/asm/ide.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * This file contains the MIPS architecture specific IDE code.
- */
-#ifndef __ASM_IDE_H
-#define __ASM_IDE_H
-
-#include <ide.h>
-
-#endif /* __ASM_IDE_H */
diff --git a/arch/mips/include/asm/mach-generic/ide.h b/arch/mips/include/asm/mach-generic/ide.h
deleted file mode 100644
index 4ae5fbcb15a5..000000000000
--- a/arch/mips/include/asm/mach-generic/ide.h
+++ /dev/null
@@ -1,138 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1994-1996  Linus Torvalds & authors
- *
- * Copied from i386; many of the especially older MIPS or ISA-based platforms
- * are basically identical.  Using this file probably implies i8259 PIC
- * support in a system but the very least interrupt numbers 0 - 15 need to
- * be put aside for legacy devices.
- */
-#ifndef __ASM_MACH_GENERIC_IDE_H
-#define __ASM_MACH_GENERIC_IDE_H
-
-#ifdef __KERNEL__
-
-#include <linux/pci.h>
-#include <linux/stddef.h>
-#include <asm/processor.h>
-
-/* MIPS port and memory-mapped I/O string operations.  */
-static inline void __ide_flush_prologue(void)
-{
-#ifdef CONFIG_SMP
-	if (cpu_has_dc_aliases || !cpu_has_ic_fills_f_dc)
-		preempt_disable();
-#endif
-}
-
-static inline void __ide_flush_epilogue(void)
-{
-#ifdef CONFIG_SMP
-	if (cpu_has_dc_aliases || !cpu_has_ic_fills_f_dc)
-		preempt_enable();
-#endif
-}
-
-static inline void __ide_flush_dcache_range(unsigned long addr, unsigned long size)
-{
-	if (cpu_has_dc_aliases || !cpu_has_ic_fills_f_dc) {
-		unsigned long end = addr + size;
-
-		while (addr < end) {
-			local_flush_data_cache_page((void *)addr);
-			addr += PAGE_SIZE;
-		}
-	}
-}
-
-/*
- * insw() and gang might be called with interrupts disabled, so we can't
- * send IPIs for flushing due to the potencial of deadlocks, see the comment
- * above smp_call_function() in arch/mips/kernel/smp.c.	 We work around the
- * problem by disabling preemption so we know we actually perform the flush
- * on the processor that actually has the lines to be flushed which hopefully
- * is even better for performance anyway.
- */
-static inline void __ide_insw(unsigned long port, void *addr,
-	unsigned int count)
-{
-	__ide_flush_prologue();
-	insw(port, addr, count);
-	__ide_flush_dcache_range((unsigned long)addr, count * 2);
-	__ide_flush_epilogue();
-}
-
-static inline void __ide_insl(unsigned long port, void *addr, unsigned int count)
-{
-	__ide_flush_prologue();
-	insl(port, addr, count);
-	__ide_flush_dcache_range((unsigned long)addr, count * 4);
-	__ide_flush_epilogue();
-}
-
-static inline void __ide_outsw(unsigned long port, const void *addr,
-	unsigned long count)
-{
-	__ide_flush_prologue();
-	outsw(port, addr, count);
-	__ide_flush_dcache_range((unsigned long)addr, count * 2);
-	__ide_flush_epilogue();
-}
-
-static inline void __ide_outsl(unsigned long port, const void *addr,
-	unsigned long count)
-{
-	__ide_flush_prologue();
-	outsl(port, addr, count);
-	__ide_flush_dcache_range((unsigned long)addr, count * 4);
-	__ide_flush_epilogue();
-}
-
-static inline void __ide_mm_insw(void __iomem *port, void *addr, u32 count)
-{
-	__ide_flush_prologue();
-	readsw(port, addr, count);
-	__ide_flush_dcache_range((unsigned long)addr, count * 2);
-	__ide_flush_epilogue();
-}
-
-static inline void __ide_mm_insl(void __iomem *port, void *addr, u32 count)
-{
-	__ide_flush_prologue();
-	readsl(port, addr, count);
-	__ide_flush_dcache_range((unsigned long)addr, count * 4);
-	__ide_flush_epilogue();
-}
-
-static inline void __ide_mm_outsw(void __iomem *port, void *addr, u32 count)
-{
-	__ide_flush_prologue();
-	writesw(port, addr, count);
-	__ide_flush_dcache_range((unsigned long)addr, count * 2);
-	__ide_flush_epilogue();
-}
-
-static inline void __ide_mm_outsl(void __iomem * port, void *addr, u32 count)
-{
-	__ide_flush_prologue();
-	writesl(port, addr, count);
-	__ide_flush_dcache_range((unsigned long)addr, count * 4);
-	__ide_flush_epilogue();
-}
-
-/* ide_insw calls insw, not __ide_insw.	 Why? */
-#undef insw
-#undef insl
-#undef outsw
-#undef outsl
-#define insw(port, addr, count) __ide_insw(port, addr, count)
-#define insl(port, addr, count) __ide_insl(port, addr, count)
-#define outsw(port, addr, count) __ide_outsw(port, addr, count)
-#define outsl(port, addr, count) __ide_outsl(port, addr, count)
-
-#endif /* __KERNEL__ */
-
-#endif /* __ASM_MACH_GENERIC_IDE_H */
-- 
2.35.3

