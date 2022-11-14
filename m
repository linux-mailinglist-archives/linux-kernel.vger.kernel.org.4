Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99378628A14
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237430AbiKNUGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236438AbiKNUGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:06:24 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32ACEA4;
        Mon, 14 Nov 2022 12:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668456383; x=1699992383;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E6Fr5EqSLsNUebM1iEN8hkFtHJmRiv4orK6AmUjJIB0=;
  b=U7E1D+2tcfMlvcnqf11wUH3nRsprsN+UpWhzby9FLTInSS9YErYZe+Dx
   tB4Vn4QLHZMg5pH7iuwcFNSaUi/YlwpWMflMegkYVJzMMFyqAtjQOC0TF
   t65v2uzL8Mwnrdvk9F0MIfndEy5yVaLoCE8LaVYa4LB9ANnYz5LLH+9Mr
   PvdsLLZh7gRCmzla+jg778J2qeRLgonQTh7Ys3Gwy/2HFXJH0NvYI2smB
   yNup7SiKUEHKw3KXcvETUrqcf+joLTpVZZ3bgGeBdNrc+Zi25Pefp1eiT
   UpqK9jMuYdW7s1SsdksBvAsfLoAwS9rUwac9knFiHxzCutSQ57IkObB3v
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="310779575"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="310779575"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 12:06:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="589508116"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="589508116"
Received: from parandri-mobl.amr.corp.intel.com (HELO guptapa-desk.intel.com) ([10.209.117.50])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 12:06:22 -0800
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, David.Kaplan@amd.com,
        thomas.lendacky@amd.com, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, hdegoede@redhat.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com
Subject: [PATCH v2 1/2] x86/tsx: Add feature bit for TSX control MSR support
Date:   Mon, 14 Nov 2022 12:06:15 -0800
Message-Id: <80961915d70eb31d564f9ddeaab809e5c895f3cc.1668455932.git.pawan.kumar.gupta@linux.intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1668455932.git.pawan.kumar.gupta@linux.intel.com>
References: <cover.1668455932.git.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for TSX control MSR is enumerated in MSR_IA32_ARCH_CAPABILITIES.
This is different from how other CPU features are enumerated i.e. via
CPUID. Currently a call to tsx_ctrl_is_supported() is required for
enumerating the feature. In the absence of feature bit for TSX control,
any code that relies on checking feature bits directly will not work.

In preparation for adding a feature bit check in MSR save/restore during
suspend/resume, set a new feature bit X86_FEATURE_TSX_CTRL when
MSR_IA32_TSX_CTRL is present. Also make tsx_ctrl_is_supported() use the
new feature bit to avoid any overhead of reading the MSR.

Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/kernel/cpu/tsx.c          | 30 +++++++++++++++---------------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index b71f4f2ecdd5..3cda06ebe046 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -304,6 +304,7 @@
 #define X86_FEATURE_UNRET		(11*32+15) /* "" AMD BTB untrain return */
 #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime firmware calls */
 #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit when EIBRS is enabled */
+#define X86_FEATURE_MSR_TSX_CTRL	(11*32+18) /* "" MSR IA32_TSX_CTRL (Intel) implemented */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
index ec7bbac3a9f2..9fe488dbed15 100644
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -60,20 +60,7 @@ static void tsx_enable(void)
 
 static bool tsx_ctrl_is_supported(void)
 {
-	u64 ia32_cap = x86_read_arch_cap_msr();
-
-	/*
-	 * TSX is controlled via MSR_IA32_TSX_CTRL.  However, support for this
-	 * MSR is enumerated by ARCH_CAP_TSX_MSR bit in MSR_IA32_ARCH_CAPABILITIES.
-	 *
-	 * TSX control (aka MSR_IA32_TSX_CTRL) is only available after a
-	 * microcode update on CPUs that have their MSR_IA32_ARCH_CAPABILITIES
-	 * bit MDS_NO=1. CPUs with MDS_NO=0 are not planned to get
-	 * MSR_IA32_TSX_CTRL support even after a microcode update. Thus,
-	 * tsx= cmdline requests will do nothing on CPUs without
-	 * MSR_IA32_TSX_CTRL support.
-	 */
-	return !!(ia32_cap & ARCH_CAP_TSX_CTRL_MSR);
+	return cpu_feature_enabled(X86_FEATURE_MSR_TSX_CTRL);
 }
 
 static enum tsx_ctrl_states x86_get_tsx_auto_mode(void)
@@ -191,7 +178,20 @@ void __init tsx_init(void)
 		return;
 	}
 
-	if (!tsx_ctrl_is_supported()) {
+	/*
+	 * TSX is controlled via MSR_IA32_TSX_CTRL.  However, support for this
+	 * MSR is enumerated by ARCH_CAP_TSX_MSR bit in MSR_IA32_ARCH_CAPABILITIES.
+	 *
+	 * TSX control (aka MSR_IA32_TSX_CTRL) is only available after a
+	 * microcode update on CPUs that have their MSR_IA32_ARCH_CAPABILITIES
+	 * bit MDS_NO=1. CPUs with MDS_NO=0 are not planned to get
+	 * MSR_IA32_TSX_CTRL support even after a microcode update. Thus,
+	 * tsx= cmdline requests will do nothing on CPUs without
+	 * MSR_IA32_TSX_CTRL support.
+	 */
+	if (x86_read_arch_cap_msr() & ARCH_CAP_TSX_CTRL_MSR) {
+		setup_force_cpu_cap(X86_FEATURE_MSR_TSX_CTRL);
+	} else {
 		tsx_ctrl_state = TSX_CTRL_NOT_SUPPORTED;
 		return;
 	}
-- 
2.37.3

