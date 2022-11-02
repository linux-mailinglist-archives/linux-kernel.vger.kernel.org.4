Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86417616727
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiKBQJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiKBQJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:09:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21B92B191;
        Wed,  2 Nov 2022 09:09:01 -0700 (PDT)
Date:   Wed, 02 Nov 2022 16:08:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667405340;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HFAqXyVVFLHLLFDqdDRfJm9tywmmu75vRl/YghGdX2M=;
        b=uYdoQd/Kx2Oyy9l3sysAOzcDMVB/P3PQ1Z2Tk4f5QnFPmsiRzzxgZwCPMgZdvwMenlz3a2
        Jd61/KeJsrF+5qeh3zPk8jBS2WXhDU2Zq4G5hz5e47gL8E/yHR+dffjFiFUR/Xfu+IySj0
        bjclT8ZvnSw4ckdNBLid1YbinqeCbwD+mhQCZxh0P1VeQ1wnwYe02mdQTF82p9FRLJBByL
        1rSxfw0dwp/oQDd/ZqltQBApsThnjxWx5tE3Gq9GuU/h/fNdYBSsM8+nemf8Ni3RLs+x9y
        XkfPYBUvJQvAnJfKYeGl6XFJIgiyobDgBduqmqwmsYOfKc8g0ZYmyIEmvr/jCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667405340;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HFAqXyVVFLHLLFDqdDRfJm9tywmmu75vRl/YghGdX2M=;
        b=afcZKx1/M2Fs8PFcgxYK8T1qs+t2WG9WdyLfLCH+Prv/fOUnWqoju2DveD5OBEZK+9vLxW
        nfjYuYA3Yd8oQTBQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Simplify init path even more
Cc:     Borislav Petkov <bp@suse.de>, Ashok Raj <ashok.raj@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221028142638.28498-3-bp@alien8.de>
References: <20221028142638.28498-3-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <166740533925.6127.10065532561377556916.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     2071c0aeda228107bf1b9e870b6187c90fbeef1d
Gitweb:        https://git.kernel.org/tip/2071c0aeda228107bf1b9e870b6187c90fbeef1d
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 19 Oct 2022 19:07:30 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 02 Nov 2022 16:45:46 +01:00

x86/microcode: Simplify init path even more

Get rid of all the IPI-sending functions and their wrappers and use
those which are supposed to be called on each CPU.

Thus:

- microcode_init_cpu() gets called on each CPU on init, applying any new
  microcode that the driver might've found on the filesystem.

- mc_cpu_starting() simply tries to apply cached microcode as this is
  the cpuhp starting callback which gets called on CPU resume too.

Even if the driver init function is a late initcall, there is no
filesystem by then (not even a hdd driver has been loaded yet) so a new
firmware load attempt cannot simply be done.

It is pointless anyway - for that there's late loading if one really
needs it.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Link: https://lore.kernel.org/r/20221028142638.28498-3-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/core.c | 120 +++-----------------------
 1 file changed, 16 insertions(+), 104 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 4c222e6..63f7678 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -319,60 +319,6 @@ void reload_early_microcode(void)
 	}
 }
 
-static void collect_cpu_info_local(void *arg)
-{
-	struct cpu_info_ctx *ctx = arg;
-
-	ctx->err = microcode_ops->collect_cpu_info(smp_processor_id(),
-						   ctx->cpu_sig);
-}
-
-static int collect_cpu_info_on_target(int cpu, struct cpu_signature *cpu_sig)
-{
-	struct cpu_info_ctx ctx = { .cpu_sig = cpu_sig, .err = 0 };
-	int ret;
-
-	ret = smp_call_function_single(cpu, collect_cpu_info_local, &ctx, 1);
-	if (!ret)
-		ret = ctx.err;
-
-	return ret;
-}
-
-static int collect_cpu_info(int cpu)
-{
-	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-	int ret;
-
-	memset(uci, 0, sizeof(*uci));
-
-	ret = collect_cpu_info_on_target(cpu, &uci->cpu_sig);
-	if (!ret)
-		uci->valid = 1;
-
-	return ret;
-}
-
-static void apply_microcode_local(void *arg)
-{
-	enum ucode_state *err = arg;
-
-	*err = microcode_ops->apply_microcode(smp_processor_id());
-}
-
-static int apply_microcode_on_target(int cpu)
-{
-	enum ucode_state err;
-	int ret;
-
-	ret = smp_call_function_single(cpu, apply_microcode_local, &err, 1);
-	if (!ret) {
-		if (err == UCODE_ERROR)
-			ret = 1;
-	}
-	return ret;
-}
-
 /* fake device for request_firmware */
 static struct platform_device	*microcode_pdev;
 
@@ -458,7 +404,7 @@ static int __reload_late(void *info)
 	 * below.
 	 */
 	if (cpumask_first(topology_sibling_cpumask(cpu)) == cpu)
-		apply_microcode_local(&err);
+		err = microcode_ops->apply_microcode(cpu);
 	else
 		goto wait_for_siblings;
 
@@ -480,7 +426,7 @@ wait_for_siblings:
 	 * revision.
 	 */
 	if (cpumask_first(topology_sibling_cpumask(cpu)) != cpu)
-		apply_microcode_local(&err);
+		err = microcode_ops->apply_microcode(cpu);
 
 	return ret;
 }
@@ -589,51 +535,15 @@ static void microcode_fini_cpu(int cpu)
 		microcode_ops->microcode_fini_cpu(cpu);
 }
 
-static enum ucode_state microcode_resume_cpu(int cpu)
-{
-	if (apply_microcode_on_target(cpu))
-		return UCODE_ERROR;
-
-	pr_debug("CPU%d updated upon resume\n", cpu);
-
-	return UCODE_OK;
-}
-
-static enum ucode_state microcode_init_cpu(int cpu, bool refresh_fw)
-{
-	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-	enum ucode_state ustate;
-
-	if (uci->valid)
-		return UCODE_OK;
-
-	if (collect_cpu_info(cpu))
-		return UCODE_ERROR;
-
-	/* --dimm. Trigger a delayed update? */
-	if (system_state != SYSTEM_RUNNING)
-		return UCODE_NFOUND;
-
-	ustate = microcode_ops->request_microcode_fw(cpu, &microcode_pdev->dev, refresh_fw);
-	if (ustate == UCODE_NEW) {
-		pr_debug("CPU%d updated upon init\n", cpu);
-		apply_microcode_on_target(cpu);
-	}
-
-	return ustate;
-}
-
-static enum ucode_state microcode_update_cpu(int cpu)
+static enum ucode_state microcode_init_cpu(int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 
-	/* Refresh CPU microcode revision after resume. */
-	collect_cpu_info(cpu);
+	memset(uci, 0, sizeof(*uci));
 
-	if (uci->valid)
-		return microcode_resume_cpu(cpu);
+	microcode_ops->collect_cpu_info(cpu, &uci->cpu_sig);
 
-	return microcode_init_cpu(cpu, false);
+	return microcode_ops->apply_microcode(cpu);
 }
 
 /**
@@ -651,14 +561,14 @@ void microcode_bsp_resume(void)
 }
 
 static struct syscore_ops mc_syscore_ops = {
-	.resume			= microcode_bsp_resume,
+	.resume	= microcode_bsp_resume,
 };
 
 static int mc_cpu_starting(unsigned int cpu)
 {
-	microcode_update_cpu(cpu);
-	pr_debug("CPU%d added\n", cpu);
-	return 0;
+	enum ucode_state err = microcode_ops->apply_microcode(cpu);
+
+	return err == UCODE_ERROR;
 }
 
 static int mc_cpu_online(unsigned int cpu)
@@ -688,11 +598,13 @@ static int mc_cpu_down_prep(unsigned int cpu)
 static void setup_online_cpu(struct work_struct *work)
 {
 	int cpu = smp_processor_id();
-	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-
-	memset(uci, 0, sizeof(*uci));
+	enum ucode_state err;
 
-	microcode_ops->collect_cpu_info(cpu, &uci->cpu_sig);
+	err = microcode_init_cpu(cpu);
+	if (err == UCODE_ERROR) {
+		pr_err("Error applying microcode on CPU%d\n", cpu);
+		return;
+	}
 
 	mc_cpu_online(cpu);
 }
