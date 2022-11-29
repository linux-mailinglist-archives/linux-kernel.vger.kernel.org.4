Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACCD63CA1B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 22:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbiK2VJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 16:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbiK2VJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 16:09:07 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A631EE32
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 13:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669756145; x=1701292145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+c+idxLi34QmYjm2JNwF3yjYRC3bi0/GYB7hm+1xYXc=;
  b=iMSjoF5xPeqZPvkk5bmJPC5ioZnaWGMJrbWs0aE7KSglJw2rXcjz7VWA
   sFmUlpEvTYDEzYzpEByAftwRjKxEjIwjRVWwF1zrXDHKrEvoDhLvQng5y
   KwiTAt7JxI19NQpRqhefjZN0j1VJym7xSRDwjQ0GD94Fd45TuwuKIlzng
   svXp6theL+SkbbBH13Cnf7afNdtzuMwNcnUe2ttvuAzvbT8F+i0Yf15sA
   nmSashcbh+93ZOq1rICl+VtDh35lF9yU5UcyIH7DjbrcCtO/kmBjrsK+t
   RUfIRY4AphpGlWT9/GEboYVT+Pd2+ErxPHeMZrjPnQa6bXuMhgEmWua5/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="317083139"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="317083139"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 13:09:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="646066211"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="646066211"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 13:09:04 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, alison.schofield@intel.com,
        reinette.chatre@intel.com
Subject: [Patch V1 4/7] x86/microcode/core: Take a snapshot before and after applying microcode
Date:   Tue, 29 Nov 2022 13:08:29 -0800
Message-Id: <20221129210832.107850-5-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221129210832.107850-1-ashok.raj@intel.com>
References: <20221129210832.107850-1-ashok.raj@intel.com>
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

The kernel caches features about each CPU's features at boot in an
x86_capability[] structure. The microcode update takes one snapshot and
compares it with the saved copy at boot.

However, the capabilities in the boot copy can be turned off as a result of
certain command line parameters or configuration restrictions. This can
cause a mismatch when comparing the values before and after the microcode
update.

microcode_check() is called after an update to report any previously
cached CPUID bits might have changed due to the update.

Ignore the capabilities recorded at boot. Take a new snapshot before the
update and compare with a snapshot after the update to eliminate the false
warning.

Fixes: 1008c52c09dc ("x86/CPU: Add a microcode loader callback")
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/kernel/cpu/microcode/core.c | 36 ++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index ef24e1d228d0..fab2010ff368 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -431,12 +431,28 @@ static int __reload_late(void *info)
 	return ret;
 }
 
+static void copy_cpu_caps(struct cpuinfo_x86 *info)
+{
+	/* Reload CPUID max function as it might've changed. */
+	info->cpuid_level = cpuid_eax(0);
+
+	/*
+	 * Copy all capability leafs to pick up the synthetic ones so that
+	 * memcmp() below doesn't fail on that. The ones coming from CPUID will
+	 * get overwritten in get_cpu_cap().
+	 */
+	memcpy(info->x86_capability, &boot_cpu_data.x86_capability,
+	       sizeof(info->x86_capability));
+
+	get_cpu_cap(info);
+}
+
 /*
  * The microcode loader calls this upon late microcode load to recheck features,
  * only when microcode has been updated. Caller holds microcode_mutex and CPU
  * hotplug lock.
  */
-static void microcode_check(void)
+static void microcode_check(struct cpuinfo_x86 *orig)
 {
 	struct cpuinfo_x86 info;
 
@@ -446,15 +462,13 @@ static void microcode_check(void)
 	info.cpuid_level = cpuid_eax(0);
 
 	/*
-	 * Copy all capability leafs to pick up the synthetic ones so that
-	 * memcmp() below doesn't fail on that. The ones coming from CPUID will
-	 * get overwritten in get_cpu_cap().
-	 */
-	memcpy(&info.x86_capability, &boot_cpu_data.x86_capability, sizeof(info.x86_capability));
+	* Copy all capability leafs to pick up the synthetic ones so that
+	* memcmp() below doesn't fail on that. The ones coming from CPUID will
+	* get overwritten in get_cpu_cap().
+	*/
+	copy_cpu_caps(&info);
 
-	get_cpu_cap(&info);
-
-	if (!memcmp(&info.x86_capability, &boot_cpu_data.x86_capability,
+	if (!memcmp(&info.x86_capability, &orig->x86_capability,
 		    sizeof(info.x86_capability)))
 		return;
 
@@ -469,6 +483,7 @@ static void microcode_check(void)
 static int microcode_reload_late(void)
 {
 	int old = boot_cpu_data.microcode, ret;
+	struct cpuinfo_x86 info;
 
 	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
 	pr_err("You should switch to early loading, if possible.\n");
@@ -476,9 +491,10 @@ static int microcode_reload_late(void)
 	atomic_set(&late_cpus_in,  0);
 	atomic_set(&late_cpus_out, 0);
 
+	copy_cpu_caps(&info);
 	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
 	if (ret == 0)
-		microcode_check();
+		microcode_check(&info);
 
 	pr_info("Reload completed, microcode revision: 0x%x -> 0x%x\n",
 		old, boot_cpu_data.microcode);
-- 
2.34.1

