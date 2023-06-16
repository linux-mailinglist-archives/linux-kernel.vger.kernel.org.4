Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FE2732B70
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344344AbjFPJ0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344140AbjFPJYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:24:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AE72719;
        Fri, 16 Jun 2023 02:24:52 -0700 (PDT)
Date:   Fri, 16 Jun 2023 09:24:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686907490;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2h5647/jSFIONuj4MZl2GP0+HmxtrgKzcVIh+TWijOs=;
        b=D6//SuwQ1nFT9DwaAGLvy90WurOUneDUZpNS7QyvV4RjOS4ct1P3CqnIVikE912QffjDp1
        IWAngEDKd/tmxdRFIw17fHnYaw8rxBMbdm8yvQhy3PHjpjfH9owjRdFido58NbhLAoovvl
        xjepqOWwZS9/JTZs0sAS1e9xTPLw7I11O+wFcVAXmEeGarE25qpJEqbaaRcnaUcqGtvq6d
        YrtKeKAqNsC1zImrAsL+VmkofrqmPGKPvQnt47Rug/4aaX5tWMSGh3tXd2ogusItMV53hj
        +iZvS9ZBBugSEtbJN6mCDHR1mci8DPUDN0S/cjrQaIcplFmDFH+Aw/MqYEJJww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686907490;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2h5647/jSFIONuj4MZl2GP0+HmxtrgKzcVIh+TWijOs=;
        b=bRK7sSQx8CYCBP3dBTA5zpCABRyOOTQ/G/jKss5077lseWFQNqMFjXVMDGioKLyXA+md+q
        XGgjiU/TgM1OH9BA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] ia64/cpu: Switch to arch_cpu_finalize_init()
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230613224545.137045745@linutronix.de>
References: <20230613224545.137045745@linutronix.de>
MIME-Version: 1.0
Message-ID: <168690748968.404.14167135207073680726.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     6c38e3005621800263f117fb00d6787a76e16de7
Gitweb:        https://git.kernel.org/tip/6c38e3005621800263f117fb00d6787a76e16de7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 14 Jun 2023 01:39:27 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 Jun 2023 10:15:59 +02:00

ia64/cpu: Switch to arch_cpu_finalize_init()

check_bugs() is about to be phased out. Switch over to the new
arch_cpu_finalize_init() implementation.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230613224545.137045745@linutronix.de

---
 arch/ia64/Kconfig            |  1 +
 arch/ia64/include/asm/bugs.h | 20 --------------------
 arch/ia64/kernel/setup.c     |  3 +--
 3 files changed, 2 insertions(+), 22 deletions(-)
 delete mode 100644 arch/ia64/include/asm/bugs.h

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 21fa63c..2cd93e6 100644
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
diff --git a/arch/ia64/include/asm/bugs.h b/arch/ia64/include/asm/bugs.h
deleted file mode 100644
index 0d6b9bd..0000000
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
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index c057280..9009f18 100644
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
