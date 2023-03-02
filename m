Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2655A6A78CD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 02:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjCBBU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 20:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCBBUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 20:20:24 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F94460B3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 17:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677720020; x=1709256020;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ASsgRxs9Z59T1yJxOQpzf05ogTUrW/D6lLtPVYMS2HQ=;
  b=izpll0G42mJY0oTFjD5goa3bZKx9jwlLkXa6qX8kZug1cbHA7ygfqiBA
   +asKckbZGvaAPzLXzNGX0K7pXHeGZ/kcZhkVmuqveHhXvD2hT6LApqzJg
   FcQyrL/kh2fjEroceAPr1npY3er3QLeRHXW7Tsb/954JYoYSwouGXWWlc
   9nkOczRFjVW83EjhLA+oeeKW4dh4rD3q9qhZFtN/lpbRp3kHkeRjaMqJ4
   F4OqU5vTUSGzJEh6xxEZgDhYJmOGmvxipMrdgGnZLo9PQF3ZDX0fsEAAH
   9/46YxMkrcLpHZXbsTedEbbseqkcPH0uGACFjxuVrTSxghnN6lcu1KXP9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="315002177"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="315002177"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 17:20:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="652226070"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="652226070"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga006.jf.intel.com with ESMTP; 01 Mar 2023 17:20:18 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Andi Kleen" <andi@firstfloor.org>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>, "x86" <x86@kernel.org>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH] x86/split_lock: Enumerate architectural split lock disable bit
Date:   Wed,  1 Mar 2023 17:19:46 -0800
Message-Id: <20230302011946.211696-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The December 2022 edition of the Intel Instruction Set Extensions manual
defined that the split lock disable bit in the IA32_CORE_CAPABILITIES MSR
is (and retrospectively always has been) architectural.

Remove all the model specific checks except for Ice Lake variants which are
still needed because these CPU models do not enumerate presence of the
IA32_CORE_CAPABILITIES MSR.

Link: https://lore.kernel.org/lkml/20220701131958.687066-1-fenghua.yu@intel.com/t/#mada243bee0915532a6adef6a9e32d244d1a9aef4
Originally-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 59 ++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 2d7ea5480ec3..d27f8973b58f 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1266,31 +1266,13 @@ void handle_bus_lock(struct pt_regs *regs)
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
 
@@ -1302,24 +1284,27 @@ static void __init split_lock_setup(struct cpuinfo_x86 *c)
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
-- 
2.32.0

