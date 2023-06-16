Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B361732B6B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344285AbjFPJZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344090AbjFPJYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:24:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF062700;
        Fri, 16 Jun 2023 02:24:51 -0700 (PDT)
Date:   Fri, 16 Jun 2023 09:24:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686907486;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GyhfjxTwhAKHG4iVITF4i9TPy0D9uGIskaBvaU0vr0A=;
        b=vYhNrkiHxq0P4RdrMJMD7tPChuXcr8LbxQm5fs3iXh0N0qUnyJojvjey7AR8toCkYtuReF
        HIt9GVWtIGBqp1se+j+zFzr2VHZRowpQ5LJG6G+dR8PvIT6DeZwX4XiPdBxUoFluXtVb+j
        Qfa1oN84tje1QraUSuyP1K+CIwgvWQRBUipSVcLjryLo3dM33nGVr5cuzTkObxus0FotHe
        XgOCjmLhDtmz0YKZgMxiuTgs2Y+EljbZHnpCcnkKiEv/EA2b7czjYmHyfGfIM9GjJE0pE0
        +D3y19nZ9ozPC9gU1pIMTdA6kz+tIq9rUAlQW+s2ynqN93Wa7wzBkxjUj9ZU2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686907486;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GyhfjxTwhAKHG4iVITF4i9TPy0D9uGIskaBvaU0vr0A=;
        b=F8IlrR13f64aHqK6r09Ea2PB6N/PB2xyj90nJvIeCAAl1Mf7b2kS+PmJyRDUTRHxRcsx8S
        yquhZh7nOgROc+Cg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] sparc/cpu: Switch to arch_cpu_finalize_init()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230613224545.431995857@linutronix.de>
References: <20230613224545.431995857@linutronix.de>
MIME-Version: 1.0
Message-ID: <168690748642.404.16664989239465546956.tip-bot2@tip-bot2>
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

Commit-ID:     44ade508e3bfac45ae97864587de29eb1a881ec0
Gitweb:        https://git.kernel.org/tip/44ade508e3bfac45ae97864587de29eb1a881ec0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 14 Jun 2023 01:39:35 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 Jun 2023 10:16:00 +02:00

sparc/cpu: Switch to arch_cpu_finalize_init()

check_bugs() is about to be phased out. Switch over to the new
arch_cpu_finalize_init() implementation.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://lore.kernel.org/r/20230613224545.431995857@linutronix.de

---
 arch/sparc/Kconfig            |  1 +
 arch/sparc/include/asm/bugs.h | 18 ------------------
 arch/sparc/kernel/setup_32.c  |  7 +++++++
 3 files changed, 8 insertions(+), 18 deletions(-)
 delete mode 100644 arch/sparc/include/asm/bugs.h

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 8535e19..36fd488 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -52,6 +52,7 @@ config SPARC
 config SPARC32
 	def_bool !64BIT
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_CPU_FINALIZE_INIT if !SMP
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select CLZ_TAB
 	select DMA_DIRECT_REMAP
diff --git a/arch/sparc/include/asm/bugs.h b/arch/sparc/include/asm/bugs.h
deleted file mode 100644
index 02fa369..0000000
--- a/arch/sparc/include/asm/bugs.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* include/asm/bugs.h:  Sparc probes for various bugs.
- *
- * Copyright (C) 1996, 2007 David S. Miller (davem@davemloft.net)
- */
-
-#ifdef CONFIG_SPARC32
-#include <asm/cpudata.h>
-#endif
-
-extern unsigned long loops_per_jiffy;
-
-static void __init check_bugs(void)
-{
-#if defined(CONFIG_SPARC32) && !defined(CONFIG_SMP)
-	cpu_data(0).udelay_val = loops_per_jiffy;
-#endif
-}
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index c8e0dd9..c9d1ba4 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -412,3 +412,10 @@ static int __init topology_init(void)
 }
 
 subsys_initcall(topology_init);
+
+#if defined(CONFIG_SPARC32) && !defined(CONFIG_SMP)
+void __init arch_cpu_finalize_init(void)
+{
+	cpu_data(0).udelay_val = loops_per_jiffy;
+}
+#endif
