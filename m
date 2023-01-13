Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9842266A0E9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjAMRnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjAMRnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:43:10 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C06C13B6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673630974; x=1705166974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qte1q7+HJ25CNkhwh20t40WstQdc3MZAPVeyWl46Tfk=;
  b=MJ1PM5Z7K2+hF2X9mR4mxAK8yHv97ILzgFZW1gHAWZVkAHIhN5/nlExh
   20uuhoW+b2iYgVc4FX+d8Rdg0p8t1nUYhidOmQr1f+/mUdfP7IYqfoD9s
   zCzaHbmNcfxvfryxYkL08hRJV82w46ah6PsKroohc/LA84YGuXeHVdQV8
   oOwzLvUVde0qXNq05wwbYrJkTASD1ndKsic2jTsRFGK8IMkMhBWRqNzL5
   MtszwpqTSjpQXLP/NodBnhyk83hfi/aTXZcYqKuhJ0YM7Xw8I1TueWYE7
   4BGIcO6lOFHcL5DhdCn99Y37pfBmn0r89REpT8ML1yeOYHI0F8913/vXz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="304430006"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="304430006"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 09:29:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="766089920"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="766089920"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 09:29:32 -0800
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
Subject: [PATCH v1 Part2 2/5] x86/microcode/intel: Add minimum required revision to microcode header
Date:   Fri, 13 Jan 2023 09:29:17 -0800
Message-Id: <20230113172920.113612-3-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113172920.113612-1-ashok.raj@intel.com>
References: <20230113172920.113612-1-ashok.raj@intel.com>
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
 arch/x86/include/asm/microcode_intel.h |  3 ++-
 arch/x86/kernel/cpu/microcode/intel.c  | 34 +++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 2 deletions(-)

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
index 0cdff9ed2a4e..6046f90a47b2 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -137,6 +137,33 @@ static void save_microcode_patch(struct ucode_cpu_info *uci, void *data, unsigne
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
@@ -678,7 +705,9 @@ static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
 		memcpy(mc, &mc_header, sizeof(mc_header));
 		data = mc + sizeof(mc_header);
 		if (!copy_from_iter_full(data, data_size, iter) ||
-		    intel_microcode_sanity_check(mc, true, MC_HEADER_TYPE_MICROCODE) < 0) {
+		    intel_microcode_sanity_check(mc, true, MC_HEADER_TYPE_MICROCODE) < 0 ||
+		    is_lateload_safe(&mc_header)) {
+			ret = UCODE_ERROR;
 			break;
 		}
 
@@ -701,6 +730,9 @@ static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
 		return UCODE_ERROR;
 	}
 
+	if (ret == UCODE_ERROR)
+		return ret;
+
 	if (!new_mc)
 		return UCODE_NFOUND;
 
-- 
2.34.1

