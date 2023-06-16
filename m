Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A20F732B61
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344233AbjFPJZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344017AbjFPJYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:24:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A48B2117;
        Fri, 16 Jun 2023 02:24:45 -0700 (PDT)
Date:   Fri, 16 Jun 2023 09:24:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686907483;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n8JjCGMZg2aquHdshBmUxYgzLMNz9foabYDHjHRLCmw=;
        b=IWR7Mc5o118rmqaS3z1ueZAQl5gq34xv3g/Ux8i5BQSijVLAzU28Il0eeGAnGepLQrrQS0
        QX0imLGSoFt1bRnmFkmWae4Xli42yJhIxO645g1IQ9n8Q7s/PzeWQMJWc3IlXBApmWpSjy
        JueLuMz+C5taWHsu4e9Eg7V6cwfBIvK823vZYlQ+SyF/pUIY3r0OqPolukn1msXOks1cWL
        66jT2VkHcc2kJY0/DMYC5AZpcvinBPc25QJFDJ3w9I3aA7I5vCVeF2pgsLjXe7L9++XpTm
        yhnbksN/Syyb3s9WNI7CsCUKmiJLXS92lqeKEauWlKOrZZL0+gjHvDQtMDYugg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686907483;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n8JjCGMZg2aquHdshBmUxYgzLMNz9foabYDHjHRLCmw=;
        b=Yn2P/wpO8JAk2MIdUbUdR/CYq4Jle/S8mcqM0mEc5Zej1hTEvrDtSoAbeH2Fjj1RfR4MDT
        PX0OM1KX5ynYtrBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/init: Initialize signal frame size late
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230613224545.727330699@linutronix.de>
References: <20230613224545.727330699@linutronix.de>
MIME-Version: 1.0
Message-ID: <168690748312.404.1213636159310165530.tip-bot2@tip-bot2>
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

Commit-ID:     54d9a91a3d6713d1332e93be13b4eaf0fa54349d
Gitweb:        https://git.kernel.org/tip/54d9a91a3d6713d1332e93be13b4eaf0fa54349d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 14 Jun 2023 01:39:42 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 Jun 2023 10:16:00 +02:00

x86/init: Initialize signal frame size late

No point in doing this during really early boot. Move it to an early
initcall so that it is set up before possible user mode helpers are started
during device initialization.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230613224545.727330699@linutronix.de

---
 arch/x86/include/asm/sigframe.h | 2 --
 arch/x86/kernel/cpu/common.c    | 3 ---
 arch/x86/kernel/signal.c        | 4 +++-
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/sigframe.h b/arch/x86/include/asm/sigframe.h
index 5b1ed65..84eab27 100644
--- a/arch/x86/include/asm/sigframe.h
+++ b/arch/x86/include/asm/sigframe.h
@@ -85,6 +85,4 @@ struct rt_sigframe_x32 {
 
 #endif /* CONFIG_X86_64 */
 
-void __init init_sigframe_size(void);
-
 #endif /* _ASM_X86_SIGFRAME_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 5ee8b31..b8a4db1 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -64,7 +64,6 @@
 #include <asm/cpu_device_id.h>
 #include <asm/uv/uv.h>
 #include <asm/set_memory.h>
-#include <asm/sigframe.h>
 #include <asm/traps.h>
 #include <asm/sev.h>
 
@@ -1607,8 +1606,6 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 	fpu__init_system(c);
 
-	init_sigframe_size();
-
 #ifdef CONFIG_X86_32
 	/*
 	 * Regardless of whether PCID is enumerated, the SDM says
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 004cb30..cfeec3e 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -182,7 +182,7 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
 static unsigned long __ro_after_init max_frame_size;
 static unsigned int __ro_after_init fpu_default_state_size;
 
-void __init init_sigframe_size(void)
+static int __init init_sigframe_size(void)
 {
 	fpu_default_state_size = fpu__get_fpstate_size();
 
@@ -194,7 +194,9 @@ void __init init_sigframe_size(void)
 	max_frame_size = round_up(max_frame_size, FRAME_ALIGNMENT);
 
 	pr_info("max sigframe size: %lu\n", max_frame_size);
+	return 0;
 }
+early_initcall(init_sigframe_size);
 
 unsigned long get_sigframe_size(void)
 {
