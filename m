Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88F161148A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiJ1O1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiJ1O1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:27:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1653F7CE1E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:26:48 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7ce329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7ce:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD5031EC0676;
        Fri, 28 Oct 2022 16:26:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666967206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mav6KMGb8CiUNcHVuiIE28N3tUmXGA9j/5krq1Vd03A=;
        b=ZGwhkfDSqIBxQ6dePovBjH3xsRiE2Vliv0qwI8Scdaa30O6MjQZXi9DXeQzl8bxoGJoWUo
        007wNheMMfHpo9XHKglxdpCqf9YXBCo6wdQ6VRfH4FA4IIAcmsP0g/+Zo3W8V0JjNXTYAr
        Ja1Ng1IuDVfbqn2elhztTFVzAORvnsA=
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] x86/microcode: Simplify init path even more
Date:   Fri, 28 Oct 2022 16:26:35 +0200
Message-Id: <20221028142638.28498-3-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221028142638.28498-1-bp@alien8.de>
References: <20221028142638.28498-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

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
---
 arch/x86/kernel/cpu/microcode/core.c | 120 ++++-----------------------
 1 file changed, 16 insertions(+), 104 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 4c222e667567..63f7678743be 100644
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
 
@@ -480,7 +426,7 @@ static int __reload_late(void *info)
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
-- 
2.35.1

