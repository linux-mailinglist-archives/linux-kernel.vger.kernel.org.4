Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06BA6186D6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiKCSAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiKCR7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:59:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15185FE5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667498362; x=1699034362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bF+UOfIOr6mZm7+jXKRYrpF9ErB2atj/R0xUVsOO12A=;
  b=MdAV8qxCZkaqxWw08eNDBP3AJVhC6xVEUJxWMyqgjvMWNWI777zFn3ZT
   X8mnqSRu0Jvx/hwxh+pH2usyrvP6/iaUITaBqKvdxwoUhuOoz9QSJJEcl
   GzZOHQPpsvOv80tGPlAXty9hQWvJo8mSwYNlTvVLMUQlTKCAhczL2RHw+
   XSzDfkgP+0pEd7wkP/QBm3N77HD3gdgaowF9bbySwEpUh0RVoTAGWLElf
   wDkJrD3B1v8KV7UKbuqP8i/x37i+wbCVyMLDy5Vp9b/GyZySBOYla3cXa
   kje14kPnaJx1wenz2if+OdOA2gYp6XupqDsnu80PxQNI0SueZRXTMwq1K
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="308476973"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="308476973"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 10:59:18 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="809762565"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="809762565"
Received: from araj-dh-work.jf.intel.com ([10.165.157.158])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 10:59:18 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [v2 09/13] x86/microcode/intel: Add minimum required revision to microcode header
Date:   Thu,  3 Nov 2022 17:58:57 +0000
Message-Id: <20221103175901.164783-10-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103175901.164783-1-ashok.raj@intel.com>
References: <20221103175901.164783-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 arch/x86/kernel/cpu/microcode/intel.c  | 29 +++++++++++++++++++++++---
 2 files changed, 29 insertions(+), 4 deletions(-)

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
index 8ef04447fcf0..020d0feed3cc 100644
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
@@ -838,7 +857,8 @@ static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
 		memcpy(mc, &mc_header, sizeof(mc_header));
 		data = mc + sizeof(mc_header);
 		if (!copy_from_iter_full(data, data_size, iter) ||
-		    microcode_sanity_check(mc, 1) < 0) {
+		    microcode_sanity_check(mc, 1, true) < 0) {
+			ret = UCODE_ERROR;
 			break;
 		}
 
@@ -861,6 +881,9 @@ static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
 		return UCODE_ERROR;
 	}
 
+	if (ret == UCODE_ERROR)
+		return ret;
+
 	if (!new_mc)
 		return UCODE_NFOUND;
 
-- 
2.34.1

