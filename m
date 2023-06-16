Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B36732B71
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjFPJ0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344139AbjFPJYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:24:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3239F26A2;
        Fri, 16 Jun 2023 02:24:52 -0700 (PDT)
Date:   Fri, 16 Jun 2023 09:24:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686907490;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kjrxt0Lw+FBhfYzI0VUDdvwhgENjx3Fz9U3r/AsyxKA=;
        b=aCUGuGwf0uAKRQMPCN+lfit9FIAOES/p9WifcwTeUtCiOxXWB2N4vA6UKb5CaoowvVvGy8
        O6SWzpkY2vjK+1jmJgI8RZu9fWxLlUtTtNvCQsCuNT9eDMqzGzp6IOPZqHTQFBQeDdP3My
        HsqeBEAowMO+WizxCNa4DPoeJmULoyR13qvGdQQWk+jxJpp7MZUoa1QORf5MY/MFeUHYAF
        QWq3s8ch+uumDl+uilChbfHezyZO1zumVbEwJe1ycC+YuVXv9r7bv383PZRfo6LLmpjPb0
        JAQjhss158NwO8jWMflZLkrryu9Awxb/Ho1zfDU5dBA2PzsrpBSCJ0G+siMeZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686907490;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kjrxt0Lw+FBhfYzI0VUDdvwhgENjx3Fz9U3r/AsyxKA=;
        b=nQqqEiYLRdEhI2vOR5EH5G9CLx4K0gpSDcQQ95jsC0IGD8ViVoLF9JsnZyWa/r9LaBMYwa
        1aYq5piWgyXb/HBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] ARM: cpu: Switch to arch_cpu_finalize_init()
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230613224545.078124882@linutronix.de>
References: <20230613224545.078124882@linutronix.de>
MIME-Version: 1.0
Message-ID: <168690749031.404.12159674993860218564.tip-bot2@tip-bot2>
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

Commit-ID:     ee31bb0524a2e7c99b03f50249a411cc1eaa411f
Gitweb:        https://git.kernel.org/tip/ee31bb0524a2e7c99b03f50249a411cc1eaa411f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 14 Jun 2023 01:39:25 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 Jun 2023 10:15:59 +02:00

ARM: cpu: Switch to arch_cpu_finalize_init()

check_bugs() is about to be phased out. Switch over to the new
arch_cpu_finalize_init() implementation.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230613224545.078124882@linutronix.de

---
 arch/arm/Kconfig            | 1 +
 arch/arm/include/asm/bugs.h | 4 ----
 arch/arm/kernel/bugs.c      | 3 ++-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0fb4b21..d6ebe3e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -5,6 +5,7 @@ config ARM
 	select ARCH_32BIT_OFF_T
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE if HAVE_KRETPROBES && FRAME_POINTER && !ARM_UNWIND
 	select ARCH_HAS_BINFMT_FLAT
+	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DMA_WRITE_COMBINE if !ARM_DMA_MEM_BUFFERABLE
diff --git a/arch/arm/include/asm/bugs.h b/arch/arm/include/asm/bugs.h
index 97a312b..fe38555 100644
--- a/arch/arm/include/asm/bugs.h
+++ b/arch/arm/include/asm/bugs.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- *  arch/arm/include/asm/bugs.h
- *
  *  Copyright (C) 1995-2003 Russell King
  */
 #ifndef __ASM_BUGS_H
@@ -10,10 +8,8 @@
 extern void check_writebuffer_bugs(void);
 
 #ifdef CONFIG_MMU
-extern void check_bugs(void);
 extern void check_other_bugs(void);
 #else
-#define check_bugs() do { } while (0)
 #define check_other_bugs() do { } while (0)
 #endif
 
diff --git a/arch/arm/kernel/bugs.c b/arch/arm/kernel/bugs.c
index 14c8dbb..087bce6 100644
--- a/arch/arm/kernel/bugs.c
+++ b/arch/arm/kernel/bugs.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/init.h>
+#include <linux/cpu.h>
 #include <asm/bugs.h>
 #include <asm/proc-fns.h>
 
@@ -11,7 +12,7 @@ void check_other_bugs(void)
 #endif
 }
 
-void __init check_bugs(void)
+void __init arch_cpu_finalize_init(void)
 {
 	check_writebuffer_bugs();
 	check_other_bugs();
