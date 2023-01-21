Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DF06766D3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 15:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjAUOyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 09:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjAUOyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 09:54:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90B21CF56;
        Sat, 21 Jan 2023 06:54:30 -0800 (PST)
Date:   Sat, 21 Jan 2023 14:54:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674312869;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WHTB7uciogfXIqZk5e2CC51HjpIcGIORjrCCkOZD00o=;
        b=w5CFRHhUZKp0LXzX9iJ91nc7HMSBNpRs0PmmtyPEDkQWTDJ9FSfEmLJihjDEpoLXwnRaL9
        39T2PsYq44oPJLL2YQqmLmLuHYWFfhkEfdZQks6zKdnOWY6sJpjylV9gqYzcPENoya5PUN
        rI7G6FxUvB6pzltqbdW19Z+U+xAj/fgiAVjOw4pgOp4i45qJ/YhZqF19XtArFie7WAM8fb
        rWz6APoUUQiiOTdTupQ+fyDd2XMRLvSUg84yLc0AXP4pQJXReZS5I9bjk2VyGA+3PGfETW
        68jERMeRYPpzcaDZUotT5b5OaedIJmhBLxZ8Lm258nPF8Js40beio+Iuor9jpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674312869;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WHTB7uciogfXIqZk5e2CC51HjpIcGIORjrCCkOZD00o=;
        b=qHhZ+657JuJkkWOCzU0JGAwzU7ERZ+2wrzn+RWj51sFYJJJF9frZjEgx7vEpiPaPWPckZ+
        EDd6nLywzGjrKVAA==
From:   "tip-bot2 for Ashok Raj" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Add a parameter to
 microcode_check() to store CPU capabilities
Cc:     Ashok Raj <ashok.raj@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230109153555.4986-2-ashok.raj@intel.com>
References: <20230109153555.4986-2-ashok.raj@intel.com>
MIME-Version: 1.0
Message-ID: <167431286879.4906.14404949532620771196.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     ab31c74455c64e69342ddab21fd9426fcbfefde7
Gitweb:        https://git.kernel.org/tip/ab31c74455c64e69342ddab21fd9426fcbfefde7
Author:        Ashok Raj <ashok.raj@intel.com>
AuthorDate:    Mon, 09 Jan 2023 07:35:50 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 20 Jan 2023 21:45:13 +01:00

x86/microcode: Add a parameter to microcode_check() to store CPU capabilities

Add a parameter to store CPU capabilities before performing a microcode
update so that CPU capabilities can be compared before and after update.

  [ bp: Massage. ]

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230109153555.4986-2-ashok.raj@intel.com
---
 arch/x86/include/asm/processor.h     |  2 +-
 arch/x86/kernel/cpu/common.c         | 21 +++++++++++++--------
 arch/x86/kernel/cpu/microcode/core.c |  3 ++-
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 4e35c66..f256a4d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -697,7 +697,7 @@ bool xen_set_default_idle(void);
 #endif
 
 void __noreturn stop_this_cpu(void *dummy);
-void microcode_check(void);
+void microcode_check(struct cpuinfo_x86 *prev_info);
 
 enum l1tf_mitigations {
 	L1TF_MITIGATION_OFF,
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 9cfca3d..0f5a173 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2297,30 +2297,35 @@ void cpu_init_secondary(void)
 #endif
 
 #ifdef CONFIG_MICROCODE_LATE_LOADING
-/*
+/**
+ * microcode_check() - Check if any CPU capabilities changed after an update.
+ * @prev_info:	CPU capabilities stored before an update.
+ *
  * The microcode loader calls this upon late microcode load to recheck features,
  * only when microcode has been updated. Caller holds microcode_mutex and CPU
  * hotplug lock.
+ *
+ * Return: None
  */
-void microcode_check(void)
+void microcode_check(struct cpuinfo_x86 *prev_info)
 {
-	struct cpuinfo_x86 info;
-
 	perf_check_microcode();
 
 	/* Reload CPUID max function as it might've changed. */
-	info.cpuid_level = cpuid_eax(0);
+	prev_info->cpuid_level = cpuid_eax(0);
 
 	/*
 	 * Copy all capability leafs to pick up the synthetic ones so that
 	 * memcmp() below doesn't fail on that. The ones coming from CPUID will
 	 * get overwritten in get_cpu_cap().
 	 */
-	memcpy(&info.x86_capability, &boot_cpu_data.x86_capability, sizeof(info.x86_capability));
+	memcpy(&prev_info->x86_capability, &boot_cpu_data.x86_capability,
+	       sizeof(prev_info->x86_capability));
 
-	get_cpu_cap(&info);
+	get_cpu_cap(prev_info);
 
-	if (!memcmp(&info.x86_capability, &boot_cpu_data.x86_capability, sizeof(info.x86_capability)))
+	if (!memcmp(&prev_info->x86_capability, &boot_cpu_data.x86_capability,
+		    sizeof(prev_info->x86_capability)))
 		return;
 
 	pr_warn("x86/CPU: CPU features have changed after loading microcode, but might not take effect.\n");
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 99abb31..dc5dfba 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -438,6 +438,7 @@ wait_for_siblings:
 static int microcode_reload_late(void)
 {
 	int old = boot_cpu_data.microcode, ret;
+	struct cpuinfo_x86 prev_info;
 
 	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
 	pr_err("You should switch to early loading, if possible.\n");
@@ -447,7 +448,7 @@ static int microcode_reload_late(void)
 
 	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
 	if (ret == 0)
-		microcode_check();
+		microcode_check(&prev_info);
 
 	pr_info("Reload completed, microcode revision: 0x%x -> 0x%x\n",
 		old, boot_cpu_data.microcode);
