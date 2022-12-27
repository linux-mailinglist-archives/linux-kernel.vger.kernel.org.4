Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC36C656FC3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 22:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiL0VJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 16:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiL0VIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 16:08:14 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6454CDF52
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 13:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672174925; x=1703710925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=phiqAvz/xpITFJnL47O2QLXJB8ncqn7f9MVajt9NJVM=;
  b=mOgBGnjQ9QQm6SYao/YIz0CJ4Pqby68iH9ZaSXYcmOc5aGoWJluqY/53
   o/TpU2i8FtcUfx0WZgH7Df4qIzdgVApqgJS9dYat4+qspCsnVi7ljiVP/
   1729vNO8OsrRLGHSFlSz2Til3W1o4zMAB9IWQR7Sl3Nt3kMtW6HmbDmU2
   z1tYWghH7x1qVT156RFj1cr7+f6+pWSh5Im/p3/bOIIq+BPZGhv33SVFM
   590wR0jP7N9pRm+MK3yqdjCp5JJCGy/KcBXRLKtUHU8ufwMAq+e2Sj7xH
   qAq/ylauo110bmYpqXqXaAUMXROfJq+JmzJ32KzbNHgSQcVGWrqN3B1es
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="304259686"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="304259686"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 13:02:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="760435297"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="760435297"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 13:02:01 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v3 2/2] x86/microcode/core: Take a snapshot before and after applying microcode
Date:   Tue, 27 Dec 2022 13:01:44 -0800
Message-Id: <20221227210144.5112-2-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Y6tMgcU2aGbx/6yt@zn.tnic>
References: <Y6tMgcU2aGbx/6yt@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

microcode_store_cpu_caps() basically stores the original CPU reported
values and not the OS modified values. This will avoid giving a false
warning even if no capabilities have changed.

Ignore the capabilities recorded at boot. Take a new snapshot before the
update and compare with a snapshot after the update to eliminate the false
warning.

Fixes: 1008c52c09dc ("x86/CPU: Add a microcode loader callback")
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: x86 <x86@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
---
Changes since last post

- Boris
	- Change function from copy_cpu_caps() -> store_cpu_caps()
	- Keep microcode_check() inside cpu/common.c and not bleed
	  get_cpu_caps() outside of core code.

- Thomas : Commit log changes.
---
 arch/x86/include/asm/processor.h     |  1 +
 arch/x86/kernel/cpu/common.c         | 17 +++++++++++++++++
 arch/x86/kernel/cpu/microcode/core.c |  7 +++++++
 3 files changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 387578049de0..ac2e67156b9b 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -697,6 +697,7 @@ bool xen_set_default_idle(void);
 #endif
 
 void __noreturn stop_this_cpu(void *dummy);
+void microcode_store_cpu_caps(struct cpuinfo_x86 *info);
 void microcode_check(struct cpuinfo_x86 *info);
 
 enum l1tf_mitigations {
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b9c7529c920e..1f0b57a5d89d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2297,6 +2297,23 @@ void cpu_init_secondary(void)
 #endif
 
 #ifdef CONFIG_MICROCODE_LATE_LOADING
+
+void microcode_store_cpu_caps(struct cpuinfo_x86 *info)
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
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index d86a4f910a6b..14d9031ed68a 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -447,6 +447,13 @@ static int microcode_reload_late(void)
 	atomic_set(&late_cpus_in,  0);
 	atomic_set(&late_cpus_out, 0);
 
+	/*
+	 * Take a snapshot before the microcode update, so we can compare
+	 * them after the update is successful to check for any bits
+	 * changed.
+	 */
+	microcode_store_cpu_caps(&info);
+
 	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
 	if (ret == 0)
 		microcode_check(&info);
-- 
2.34.1

