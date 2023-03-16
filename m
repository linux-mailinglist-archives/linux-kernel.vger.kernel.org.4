Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA636BCD74
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjCPLE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjCPLEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:04:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7995CFF0D;
        Thu, 16 Mar 2023 04:04:21 -0700 (PDT)
Date:   Thu, 16 Mar 2023 11:04:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678964659;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BvzODTdt2rVktDwVAWQSZNh8BaXMdae1JUj9xPFJ8GU=;
        b=OZ2Cni2uXUCwCxx0wjBSWXlAiBw57rB3EBCK4cR41/zx02PAetiOEFJo85XUIcYs9NFv02
        kpka3jInsHA0ffvixNF2CVNy7lwXcfKpjEou410Oilw6fENaywN/ytrGe0m7kbTQI5PG6y
        CoYf19btOAod20H+5n/OPYSN4WHjsjkzrI6ztxL4TlkAjaa02yZpOz4Ujt+0ypy2tvXu91
        HCmVraW3acGUFCs2tCbi31rR8N+whW8isrhvQMJfKPYTVa3cddWtdryKuN3vLSzDUo3FFj
        9wsvBT7txdDcUVQJkTEQOI63xbEsuWGl+TZJlc9aLKobb9AiCIzD0w4MxrAdog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678964659;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BvzODTdt2rVktDwVAWQSZNh8BaXMdae1JUj9xPFJ8GU=;
        b=JHKZIc+QHlrVR1C49DQgjCgwjalNsaGplODPuiPa9EMJTGfi4fMOba3ye4oBtIMdZFDxQ/
        Dr7WMglahtrU7dCw==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/split_lock: Enumerate architectural split lock disable bit
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167896465821.5837.11576952994116410374.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     d7ce15e1d4162ab5e56dead10d4ae69a6b5c8ee8
Gitweb:        https://git.kernel.org/tip/d7ce15e1d4162ab5e56dead10d4ae69a6b5c8ee8
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Wed, 01 Mar 2023 17:19:46 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 16 Mar 2023 11:50:51 +01:00

x86/split_lock: Enumerate architectural split lock disable bit

The December 2022 edition of the Intel Instruction Set Extensions manual
defined that the split lock disable bit in the IA32_CORE_CAPABILITIES MSR
is (and retrospectively always has been) architectural.

Remove all the model specific checks except for Ice Lake variants which are
still needed because these CPU models do not enumerate presence of the
IA32_CORE_CAPABILITIES MSR.

Originally-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/lkml/20220701131958.687066-1-fenghua.yu@intel.com/t/#mada243bee0915532a6adef6a9e32d244d1a9aef4
---
 arch/x86/kernel/cpu/intel.c | 59 +++++++++++++-----------------------
 1 file changed, 22 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 291d416..1c648b0 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1451,31 +1451,13 @@ void handle_bus_lock(struct pt_regs *regs)
 }
 
 /*
- * Bits in the IA32_CORE_CAPABILITIES are not architectural, so they should
- * only be trusted if it is confirmed that a CPU model implements a
- * specific feature at a particular bit position.
- *
- * The possible driver data field values:
- *
- * - 0: CPU models that are known to have the per-core split-lock detection
- *	feature even though they do not enumerate IA32_CORE_CAPABILITIES.
- *
- * - 1: CPU models which may enumerate IA32_CORE_CAPABILITIES and if so use
- *      bit 5 to enumerate the per-core split-lock detection feature.
+ * CPU models that are known to have the per-core split-lock detection
+ * feature even though they do not enumerate IA32_CORE_CAPABILITIES.
  */
 static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		0),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		0),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		0),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	1),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	1),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	1),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		1),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		1),
-	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	1),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		1),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		1),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		1),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,	0),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,	0),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,	0),
 	{}
 };
 
@@ -1487,24 +1469,27 @@ static void __init split_lock_setup(struct cpuinfo_x86 *c)
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		return;
 
+	/* Check for CPUs that have support but do not enumerate it: */
 	m = x86_match_cpu(split_lock_cpu_ids);
-	if (!m)
-		return;
+	if (m)
+		goto supported;
 
-	switch (m->driver_data) {
-	case 0:
-		break;
-	case 1:
-		if (!cpu_has(c, X86_FEATURE_CORE_CAPABILITIES))
-			return;
-		rdmsrl(MSR_IA32_CORE_CAPS, ia32_core_caps);
-		if (!(ia32_core_caps & MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT))
-			return;
-		break;
-	default:
+	if (!cpu_has(c, X86_FEATURE_CORE_CAPABILITIES))
 		return;
-	}
 
+	/*
+	 * Not all bits in MSR_IA32_CORE_CAPS are architectural, but
+	 * MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT is.  All CPUs that set
+	 * it have split lock detection.
+	 */
+	rdmsrl(MSR_IA32_CORE_CAPS, ia32_core_caps);
+	if (ia32_core_caps & MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT)
+		goto supported;
+
+	/* CPU is not in the model list and does not have the MSR bit: */
+	return;
+
+supported:
 	cpu_model_supports_sld = true;
 	__split_lock_setup();
 }
