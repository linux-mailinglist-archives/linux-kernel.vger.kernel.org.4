Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37590732B6E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344303AbjFPJZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344145AbjFPJYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:24:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F346710F6;
        Fri, 16 Jun 2023 02:24:53 -0700 (PDT)
Date:   Fri, 16 Jun 2023 09:24:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686907492;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e6fgxovlKe1RYrO16lLDmsTQ9XUN1pcL1dHZC0P3wqA=;
        b=3f8cIvwhgflmYtNUKLL+rNakNlJdRJoSGbiD1hbE7G/3fVIs9MKDEMuxUHa3qQcGSURbsM
        /dfd2gDsyTNmEXWmzKbDOx9WozCIDJ1bKnYttdVzrpd9qff04JeK7swmGPhT8O4VhrEhhh
        Z63cLWK5El+GblQGlvL211702Gmtqv9is//NdJ5l62M7G0kEVIjp6n6LRpNMuJnPfDHbE/
        5G6MkwUn5iARrA4aqNM6rfaioEOhOb8i4vxuqthlFU3516kYbKMbAOtOCpRlNDk+m/9kEZ
        xxQzjkTN/Mk6IKpoHdJqX7grwmPeIJHe1BYN2MKzcWxLcx5/4WgZLVKA2+HHLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686907492;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e6fgxovlKe1RYrO16lLDmsTQ9XUN1pcL1dHZC0P3wqA=;
        b=4PBxqOXeGoQpV1K68UIc1kFIyk2PS2abqVZW04yZ4wFYLEUfsuVT2+YbZyhuQRy36Puuge
        rKakMDlcBFmaJhDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] init: Provide arch_cpu_finalize_init()
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230613224544.957805717@linutronix.de>
References: <20230613224544.957805717@linutronix.de>
MIME-Version: 1.0
Message-ID: <168690749166.404.11609502867505653973.tip-bot2@tip-bot2>
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

Commit-ID:     7725acaa4f0c04fbefb0e0d342635b967bb7d414
Gitweb:        https://git.kernel.org/tip/7725acaa4f0c04fbefb0e0d342635b967bb7d414
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 14 Jun 2023 01:39:22 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 Jun 2023 10:15:59 +02:00

init: Provide arch_cpu_finalize_init()

check_bugs() has become a dumping ground for all sorts of activities to
finalize the CPU initialization before running the rest of the init code.

Most are empty, a few do actual bug checks, some do alternative patching
and some cobble a CPU advertisement string together....

Aside of that the current implementation requires duplicated function
declaration and mostly empty header files for them.

Provide a new function arch_cpu_finalize_init(). Provide a generic
declaration if CONFIG_ARCH_HAS_CPU_FINALIZE_INIT is selected and a stub
inline otherwise.

This requires a temporary #ifdef in start_kernel() which will be removed
along with check_bugs() once the architectures are converted over.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230613224544.957805717@linutronix.de

---
 arch/Kconfig        | 3 +++
 include/linux/cpu.h | 6 ++++++
 init/main.c         | 4 ++++
 3 files changed, 13 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 205fd23..171e6b5 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -285,6 +285,9 @@ config ARCH_HAS_DMA_SET_UNCACHED
 config ARCH_HAS_DMA_CLEAR_UNCACHED
 	bool
 
+config ARCH_HAS_CPU_FINALIZE_INIT
+	bool
+
 # Select if arch init_task must go in the __init_task_data section
 config ARCH_TASK_STRUCT_ON_STACK
 	bool
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 8582a71..4893c4a 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -184,6 +184,12 @@ void arch_cpu_idle_enter(void);
 void arch_cpu_idle_exit(void);
 void __noreturn arch_cpu_idle_dead(void);
 
+#ifdef CONFIG_ARCH_HAS_CPU_FINALIZE_INIT
+void arch_cpu_finalize_init(void);
+#else
+static inline void arch_cpu_finalize_init(void) { }
+#endif
+
 int cpu_report_state(int cpu);
 int cpu_check_up_prepare(int cpu);
 void cpu_set_state_online(int cpu);
diff --git a/init/main.c b/init/main.c
index af50044..77d5316 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1078,7 +1078,11 @@ asmlinkage __visible void __init __no_sanitize_address __noreturn start_kernel(v
 	taskstats_init_early();
 	delayacct_init();
 
+	arch_cpu_finalize_init();
+	/* Temporary conditional until everything has been converted */
+#ifndef CONFIG_ARCH_HAS_CPU_FINALIZE_INIT
 	check_bugs();
+#endif
 
 	acpi_subsystem_init();
 	arch_post_acpi_subsys_init();
