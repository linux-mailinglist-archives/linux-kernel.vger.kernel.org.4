Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC385FF456
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiJNUKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiJNUJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:09:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794F81DA379
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665778170; x=1697314170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PfIf2Cma+MnvIuRcKLEmWaD4K88xeMCHSq0iB6JP3yE=;
  b=YjvKLyWESmBP1cwT8Z+WGnnR1OQcaTtLHhTjXt/jCwEtDGUJjI80ZiY8
   MnHSTt4u6sk4dWAeZnCn3+eV5mWr/qfcWd3fDP2LW5HpAm3Q9YCT6Xzxg
   qpM2JzJHksWldUBigvBkhY+XyvdWNbnRZ59OdeZ17B6Rnr5b7x4Q0z7Vy
   eRJwGfbt7qb6QzFEZgcojs8jx4YZx7lWIaAdxv8VaNH9vMfAOn5f6c1TQ
   IwbPN6FMzAVHXMO7ALCDhffPB9ElfWw7xVZQfomZzJaEcEsw3S6R1INCe
   HGc/UjYAmLoLnbceSiQ8txcz985G1TjjPF3intSOoc+6azTbxK6fEPoR0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="304202161"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="304202161"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 13:09:29 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="716870162"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="716870162"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 13:09:28 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH 08/13] x86/microcode/intel: Add minimum required revision to microcode header
Date:   Fri, 14 Oct 2022 13:09:08 -0700
Message-Id: <20221014200913.14644-9-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221014200913.14644-1-ashok.raj@intel.com>
References: <20221014200913.14644-1-ashok.raj@intel.com>
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

In general users don't have the necessary information to determine
whether a late loading of a new microcode version has removed any feature
(MSR, CPUID etc) between what is currently loaded and this new microcode.
To address this issue, Intel has added a "minimum required version" field
to a previously reserved field in the file header. Microcode updates
should only be applied if the current microcode version is equal
to, or greater than this minimum required version.

Thomas made some suggestions[1] on how meta-data in the microcode file
could provide Linux with information to decide if the new microcode is
suitable candidate for late loading. But even the "simpler" option#1
requires a lot of metadata and corresponding kernel code to parse it.

The proposal here is an even simpler option. Simply "OS visible features"
such as CPUID and MSRs are the only two examples. The microcode must not
change these OS visible features because they cause problems after late
loading. When microcode changes features, microcode will change the min_rev
to prevent such microcodes from being late loaded.

Pseudo code for late loading is as follows:

if header.min_required_id == 0
        This is old format microcode, block late loading
else if current_ucode_version < header.min_required_id
        Current version is too old, block late loading of this microcode.
else
        OK to proceed with late loading.

Any microcode that modifies the interface to an OS-visible feature
will set the min_version to itself. This will enforce this microcode is
not suitable for late loading unless the currently loaded revision is
greater or equal to the new microcode affecting the change.

The enforcement is not in hardware and limited to kernel loader enforcing
the requirement. It is not required for early loading of microcode to
enforce this requirement, since the new features are only
evaluated after early loading in the boot process.


Test cases covered:

1. With new kernel, attempting to load an older format microcode with the
   min_rev=0 should be blocked by kernel.

   [  210.541802] Late loading denied: Microcode header does not specify a
   required min version.

2. New microcode with a non-zero min_rev in the header, but the specified
   min_rev is greater than what is currently loaded in the CPU should be
   blocked by kernel.

   245.139828] microcode: Late loading denied: Current revision 0x8f685300 is too old to update, must be at 0xaa000050 version or higher. Use early loading instead.

3. New microcode with a min_rev < currently loaded should allow loading the
   microcode

4. Build initrd with microcode that has min_rev=0, or min_rev > currently
   loaded should permit early loading microcode from initrd.

[1] https://lore.kernel.org/linux-kernel/alpine.DEB.2.21.1909062237580.1902@nanos.tec.linutronix.de/


Tested-by: William Xie <william.xie@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/include/asm/microcode_intel.h |  4 +++-
 arch/x86/kernel/cpu/microcode/intel.c  | 25 ++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/microcode_intel.h
index 4c92cea7e4b5..bc893dd68b82 100644
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -14,7 +14,9 @@ struct microcode_header_intel {
 	unsigned int            pf;
 	unsigned int            datasize;
 	unsigned int            totalsize;
-	unsigned int            reserved[3];
+	unsigned int            reserved1;
+	unsigned int		min_req_ver;
+	unsigned int		reserved3;
 };
 
 struct microcode_intel {
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index e08777ae9cc4..46edce811c69 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -163,13 +163,14 @@ static void save_microcode_patch(struct ucode_cpu_info *uci, void *data, unsigne
 		intel_ucode_patch = p->data;
 }
 
-static int microcode_sanity_check(void *mc, int print_err)
+static int microcode_sanity_check(void *mc, int print_err, bool late_loading)
 {
 	unsigned long total_size, data_size, ext_table_size;
 	struct microcode_header_intel *mc_header = mc;
 	struct extended_sigtable *ext_header = NULL;
 	u32 sum, orig_sum, ext_sigcount = 0, i;
 	struct extended_signature *ext_sig;
+	struct ucode_cpu_info uci;
 
 	total_size = get_totalsize(mc_header);
 	data_size = get_datasize(mc_header);
@@ -240,6 +241,24 @@ static int microcode_sanity_check(void *mc, int print_err)
 		return -EINVAL;
 	}
 
+	/*
+	 * When late-loading, enforce that the current revision loaded on
+	 * the CPU is equal or greater than the value specified in the
+	 * new microcode header
+	 */
+	if (late_loading) {
+		if (!mc_header->min_req_ver) {
+			pr_warn("Late loading denied: Microcode header does not specify a required min version\n");
+			return -EINVAL;
+		}
+		intel_cpu_collect_info(&uci);
+		if (uci.cpu_sig.rev < mc_header->min_req_ver) {
+			pr_warn("Late loading denied: Current revision 0x%x too old to update, must be at 0x%x or higher. Use early loading instead\n",
+				uci.cpu_sig.rev, mc_header->min_req_ver);
+			return -EINVAL;
+		}
+	}
+
 	if (!ext_table_size)
 		return 0;
 
@@ -281,7 +300,7 @@ scan_microcode(void *data, size_t size, struct ucode_cpu_info *uci, bool save)
 		mc_size = get_totalsize(mc_header);
 		if (!mc_size ||
 		    mc_size > size ||
-		    microcode_sanity_check(data, 0) < 0)
+		    microcode_sanity_check(data, 0, false) < 0)
 			break;
 
 		size -= mc_size;
@@ -835,7 +854,7 @@ static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
 		memcpy(mc, &mc_header, sizeof(mc_header));
 		data = mc + sizeof(mc_header);
 		if (!copy_from_iter_full(data, data_size, iter) ||
-		    microcode_sanity_check(mc, 1) < 0) {
+		    microcode_sanity_check(mc, 1, true) < 0) {
 			break;
 		}
 
-- 
2.34.1

