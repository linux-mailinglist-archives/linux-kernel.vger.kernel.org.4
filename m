Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D1E72F037
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjFMXkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240572AbjFMXja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:39:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535F91996;
        Tue, 13 Jun 2023 16:39:29 -0700 (PDT)
Message-ID: <20230613224545.137045745@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686699567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=DDD4mAWSMPbjAODBEDFm/GZSLXiwbvYxlB2kHZQV314=;
        b=wVvSy71gluUCZPIXgEtKPo8BBg7ieMdvjy41cFsDvAMwvS7sWiK2ivysp2uh7x/mxyaE2v
        lRpXB1T+7Rb6IhJgtH5Gh08EjeY+LV6qZp8KxcG+Mhf6mq4TcOLzZ/urF31L2Jq6vP8rGD
        O3sKohDckVTh89UONt6PufDlgq59mtO9ozxMIcgcJeJuYnkf5IiWhWBIszpLhkgYnocc/h
        xrbrRFzNmT23GfQzPff5kIDwltofebDY8pYCgfGaONVaucUAY1o15zJaZaeGbebvk8LdrS
        hHhnyxcZsRDg7D6qogYEDL7tYICUsTP9fXm2+DUkN6m2IpENljiliuemCZcuKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686699567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=DDD4mAWSMPbjAODBEDFm/GZSLXiwbvYxlB2kHZQV314=;
        b=xCdom/FmXQFqzqnDxobvpXnmHuFNJaBHO2lxQlF4vIc3u28hxBBnrlvC4Zi9IVE9w6CRK5
        Ws8bEUww9+yjUQBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-ia64@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org,
        Richard Henderson <richard.henderson@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [patch 04/17] ia64/cpu: Switch to arch_cpu_finalize_init()
References: <20230613223827.532680283@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 14 Jun 2023 01:39:27 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_bugs() is about to be phased out. Switch over to the new
arch_cpu_finalize_init() implementation.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-ia64@vger.kernel.org
---
 arch/ia64/Kconfig            |    1 +
 arch/ia64/include/asm/bugs.h |   20 --------------------
 arch/ia64/kernel/setup.c     |    3 +--
 3 files changed, 2 insertions(+), 22 deletions(-)

--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -9,6 +9,7 @@ menu "Processor type and features"
 config IA64
 	bool
 	select ARCH_BINFMT_ELF_EXTRA_PHDRS
+	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_DMA_MARK_CLEAN
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
--- a/arch/ia64/include/asm/bugs.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
- * Needs:
- *	void check_bugs(void);
- *
- * Based on <asm-alpha/bugs.h>.
- *
- * Modified 1998, 1999, 2003
- *	David Mosberger-Tang <davidm@hpl.hp.com>,  Hewlett-Packard Co.
- */
-#ifndef _ASM_IA64_BUGS_H
-#define _ASM_IA64_BUGS_H
-
-#include <asm/processor.h>
-
-extern void check_bugs (void);
-
-#endif /* _ASM_IA64_BUGS_H */
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -1067,8 +1067,7 @@ cpu_init (void)
 	}
 }
 
-void __init
-check_bugs (void)
+void __init arch_cpu_finalize_init(void)
 {
 	ia64_patch_mckinley_e9((unsigned long) __start___mckinley_e9_bundles,
 			       (unsigned long) __end___mckinley_e9_bundles);

