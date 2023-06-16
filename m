Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C90732B6F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344338AbjFPJZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344143AbjFPJYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:24:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D0D2695;
        Fri, 16 Jun 2023 02:24:52 -0700 (PDT)
Date:   Fri, 16 Jun 2023 09:24:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686907489;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CiZpTVxnUZzuczFQxKQSaLnqyVa2i6IQpsTInmTvxTA=;
        b=wOr7wbXRVwz61K1UkEMKsjSCXjeBOeG6EeOoYfwIJGTzZVZn0JHTH0jcCldpT0HQ8rnCS3
        LTF+LJFNGFTqSx9LpR5ws5D+wNaIMKE5JZZyJcI1LRSdsU//1z8LrYyHWV9tEBjLBIrJSv
        0VP+ReNgJWYT/IPKlR5gouf7OIFg3bWizSI209oihXsfkgI05xkDexkildzCfSBE4zqt0K
        Au7rGpl95JNee1PfxzzS5vPhCw60ESVNeTW1g+ztaJgEJgyA8+Tl4L6PglDjKvEwysl3de
        ubO7HXxo5DJ7RfzzSaNBxXnqmrtsSFrl7PPginu1S8FMq+upJb0L8BvYcExYqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686907489;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CiZpTVxnUZzuczFQxKQSaLnqyVa2i6IQpsTInmTvxTA=;
        b=APPAoGqe3FZ7EM2Vu5vK9SM3arJijq8aVUf6aUXIQWt0/QHU54yJAjgSX77v0D31UtnFTk
        x0nUTZHien37akBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] loongarch/cpu: Switch to arch_cpu_finalize_init()
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230613224545.195288218@linutronix.de>
References: <20230613224545.195288218@linutronix.de>
MIME-Version: 1.0
Message-ID: <168690748908.404.7577532475575258816.tip-bot2@tip-bot2>
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

Commit-ID:     9841c423164787feb8f1442f922b7d80a70c82f1
Gitweb:        https://git.kernel.org/tip/9841c423164787feb8f1442f922b7d80a70c82f1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 14 Jun 2023 01:39:28 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 Jun 2023 10:15:59 +02:00

loongarch/cpu: Switch to arch_cpu_finalize_init()

check_bugs() is about to be phased out. Switch over to the new
arch_cpu_finalize_init() implementation.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230613224545.195288218@linutronix.de

---
 arch/loongarch/Kconfig            |  1 +
 arch/loongarch/include/asm/bugs.h | 15 ---------------
 arch/loongarch/kernel/setup.c     |  4 ++--
 3 files changed, 3 insertions(+), 17 deletions(-)
 delete mode 100644 arch/loongarch/include/asm/bugs.h

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index d38b066..cbab4f9 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -10,6 +10,7 @@ config LOONGARCH
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
+	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_PTE_SPECIAL
diff --git a/arch/loongarch/include/asm/bugs.h b/arch/loongarch/include/asm/bugs.h
deleted file mode 100644
index 9839653..0000000
--- a/arch/loongarch/include/asm/bugs.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
- * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
- */
-#ifndef _ASM_BUGS_H
-#define _ASM_BUGS_H
-
-#include <asm/cpu.h>
-#include <asm/cpu-info.h>
-
-extern void check_bugs(void);
-
-#endif /* _ASM_BUGS_H */
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 4444b13..78a0035 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -12,6 +12,7 @@
  */
 #include <linux/init.h>
 #include <linux/acpi.h>
+#include <linux/cpu.h>
 #include <linux/dmi.h>
 #include <linux/efi.h>
 #include <linux/export.h>
@@ -37,7 +38,6 @@
 #include <asm/addrspace.h>
 #include <asm/alternative.h>
 #include <asm/bootinfo.h>
-#include <asm/bugs.h>
 #include <asm/cache.h>
 #include <asm/cpu.h>
 #include <asm/dma.h>
@@ -87,7 +87,7 @@ const char *get_system_type(void)
 	return "generic-loongson-machine";
 }
 
-void __init check_bugs(void)
+void __init arch_cpu_finalize_init(void)
 {
 	alternative_instructions();
 }
