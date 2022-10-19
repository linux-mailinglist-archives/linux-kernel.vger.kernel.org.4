Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B647F604F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiJSRyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJSRyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:54:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3873C11A1B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:54:29 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7c5329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7c5:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5765F1EC0715;
        Wed, 19 Oct 2022 19:54:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666202068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ice+Zpi8zqJzSIBZbKVrhqcEXHbvGajZDt3Qb7Qrcbw=;
        b=jKjaecV5WEdb4cujmDjYvR2CCmguOOuhdR+mtB9OD8y+m78filHR9OpVZzZ9SVjRM60ccw
        0Gzuuw2DEHBisWYROPg1GJZ0SIDf8aaRUz3vG7KnXE7IteJ8+g3ZzHvoPbk8vMu74sLlQp
        HUByZi3iik6cBMQR3FhDPS/nAo72OoM=
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] x86/microcode: Simplify init path even more
Date:   Wed, 19 Oct 2022 19:54:23 +0200
Message-Id: <20221019175426.31025-2-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221019175426.31025-1-bp@alien8.de>
References: <Y1A5YHzmzab8LrYD@zn.tnic>
 <20221019175426.31025-1-bp@alien8.de>
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

And since the driver init function is a late initcall, there is
filesystem by then so a new firmware load attempt can simply be done. In
case a new one is there. Which is weird to begin with - how would the
initrd contain an older revision than what's on the fs since former gets
created by using the blobs from the filesystem.

Oh well, it is cheap to do so why not...

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/microcode/core.c | 127 +++++----------------------
 1 file changed, 23 insertions(+), 104 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index a3aedc93afd9..0aa6609e748c 100644
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
 static void setup_online_cpu(void *info)
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
@@ -740,6 +652,13 @@ static int __init microcode_init(void)
 		goto out_pdev;
 	}
 
+	/*
+	 * Try to load microcode once on the BSP in case the initrd has older revision.
+	 *  Frankly, I have no clue how that can happen but hey, loading here is cheap so
+	 * why not.
+	 */
+	microcode_ops->request_microcode_fw(boot_cpu_data.cpu_index, &microcode_pdev->dev, true);
+
 	/* Do per-CPU setup */
 	cpus_read_lock();
 	on_each_cpu(setup_online_cpu, NULL, 0);
-- 
2.35.1

