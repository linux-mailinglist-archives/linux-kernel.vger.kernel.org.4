Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61016681CFE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjA3Vkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjA3VkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:40:19 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCE944B4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675114817; x=1706650817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=782tPInWyNWww11wtOIG78CU8X6ISLOcwEBBBjgrn+E=;
  b=EtOampvAZWL3a/8CYGiTC2/tPKKyLzPv9tDwQOkgfpm5rPzLRUnhP1G8
   u6dw9KxbqzbSCNgRCET4GTaKyJOn/Y1BcBF961HkzJGjvrEnOl+NIjRG5
   5lxILnbcB1BxXbjEVytmRXaNgB681vdLP8MU6OTRPBH+VBlhcRZNpdgco
   niyYwPuHWFU8H24jDVg75rSru7GrskV8TRcjIeJZ5Wf2VhmeDR2e8PDul
   XHk+RPE5AzlTenu5CqUMl46QJvgxfCzXbTJ9z8WS5H5HYppYjJwpJhb1G
   4yxc5g3S0RDwHj9I0kVLaOBQls7GakFd0E/VZxqFN+s5ITEy1CbFM96ES
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="328955542"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="328955542"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 13:40:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="696571873"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="696571873"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 13:40:12 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefan Talpalaru <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: [Patch v3 Part2 6/9] x86/microcode/intel: Add minimum required revision to microcode header
Date:   Mon, 30 Jan 2023 13:39:52 -0800
Message-Id: <20230130213955.6046-7-ashok.raj@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230130213955.6046-1-ashok.raj@intel.com>
References: <20230130213955.6046-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In general users don't have the necessary information to determine
whether a late loading of a new microcode version has removed any feature
(MSR, CPUID etc) between what is currently loaded and a new microcode
revision.  To address this issue, Intel has added a "minimum required
version" field to a previously reserved field in the microcode header.
Microcode updates should only be applied if the current microcode
version is equal to, or greater than this minimum required version.

Thomas made some suggestions[1] on how meta-data in the microcode file
could provide Linux with information to decide if the new microcode is
suitable candidate for late loading. But even the "simpler" option#1
requires a lot of metadata and corresponding kernel code to parse it.

Simply "OS visible features" such as CPUID and MSRs are the only two
examples. The microcode must not change these OS visible features
because they cause problems after late loading. When microcode changes
features, microcode will change the min_rev to prevent such microcodes
from being late loaded.

Pseudo code for late loading is as follows:

if header.min_required_id == 0
        This is old format microcode, block late loading
else if current_ucode_version < header.rev
	Abort update, can't update to older rev
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

When new features are added, there is no need for minrev enforcement.

Check if the new microcode specifies the minimum version for safe late
loading. Otherwise reject late load.

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

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: x86 <x86@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Thomas Gleixner (Intel) <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Stefan Talpalaru <stefantalpalaru@yahoo.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Peter Zilstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andrew Cooper <Andrew.Cooper3@citrix.com>
---
 arch/x86/include/asm/microcode_intel.h |  3 +-
 arch/x86/kernel/cpu/microcode/intel.c  | 39 +++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/microcode_intel.h
index f1fa979e05bf..e83afe919b10 100644
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -15,7 +15,8 @@ struct microcode_header_intel {
 	unsigned int            datasize;
 	unsigned int            totalsize;
 	unsigned int            metasize;
-	unsigned int            reserved[2];
+	unsigned int		min_req_ver;
+	unsigned int		reserved3;
 };
 
 struct microcode_intel {
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index de8e591c42cd..4b3df85f2ca6 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -135,6 +135,38 @@ static void save_microcode_patch(struct ucode_cpu_info *uci, void *data, unsigne
 		intel_ucode_patch = p->data;
 }
 
+static int is_lateload_safe(struct microcode_header_intel *mc_header)
+{
+	struct ucode_cpu_info uci;
+
+	/*
+	 * When late-loading, ensure the header declares a minimum revision
+	 * required to perform a late-load.
+	 */
+	if (!mc_header->min_req_ver) {
+		pr_warn("Late loading denied: Microcode header does not specify a required min version\n");
+		return -EINVAL;
+	}
+
+	intel_cpu_collect_info(&uci);
+
+	if (uci.cpu_sig.rev > mc_header->rev) {
+		pr_warn("Current microcode rev 0x%x greater than 0x%x, aborting\n",
+			uci.cpu_sig.rev, mc_header->rev);
+		return -EINVAL;
+	}
+	/*
+	 * Enforce the minimum revision specified in the header is either
+	 * greater or equal to the current revision.
+	 */
+	if (uci.cpu_sig.rev < mc_header->min_req_ver) {
+		pr_warn("Late loading denied: Current revision 0x%x too old to update, must be at 0x%x or higher. Use early loading instead\n",
+			uci.cpu_sig.rev, mc_header->min_req_ver);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 /*
  * Get microcode matching with BSP's model. Only CPUs with the same model as
  * BSP can stay in the platform.
@@ -681,7 +713,9 @@ static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
 		memcpy(mc, &mc_header, sizeof(mc_header));
 		data = mc + sizeof(mc_header);
 		if (!copy_from_iter_full(data, data_size, iter) ||
-		    intel_microcode_sanity_check(mc, true, MC_HEADER_TYPE_MICROCODE) < 0) {
+		    intel_microcode_sanity_check(mc, true, MC_HEADER_TYPE_MICROCODE) < 0 ||
+		    is_lateload_safe(&mc_header)) {
+			ret = UCODE_ERROR;
 			break;
 		}
 
@@ -704,6 +738,9 @@ static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
 		return UCODE_ERROR;
 	}
 
+	if (ret == UCODE_ERROR)
+		return ret;
+
 	if (!new_mc)
 		return UCODE_NFOUND;
 
-- 
2.37.2

