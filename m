Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DEC628A15
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbiKNUGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbiKNUGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:06:24 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0FAEAC;
        Mon, 14 Nov 2022 12:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668456383; x=1699992383;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EoZdGGK1L5qyZWve7P1IZ9ifkLXTCDDXv1VoITm9IvI=;
  b=bHTj4Ll0uPeZFYmtLnKb6J1F2XzdW5+wtvAaH+lQ8WpJwfm5/xQWWLho
   S0b1j6DpwCPlAxIeVFK9PpbiQPECtucNu+vU6i+QH6WUGzHWvWDJW/05w
   UGESvsnyB+p7/4mIJmh9rWEGiMuedtYZJnnM4dEp5th/hA5455DccMG5K
   4mZP+DfjKaxAYS3gVZGNBz5NeT7QpoacpAmmZIW7XjduPW1w+cit24czo
   E5j1VZ56ODgPsximjByoXUJV0PeWKMNOBoroeLqyQu7xcgNPWtmM7XOjk
   T/QxtpGYjQCokTN+k83jz/C0Syx/B1hMQJYQT5lsKGTTixAe98hyh5Dfz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="310779577"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="310779577"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 12:06:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="589508117"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="589508117"
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
Subject: [PATCH v2 2/2] x86/pm: Add enumeration check before spec MSRs save/restore setup
Date:   Mon, 14 Nov 2022 12:06:16 -0800
Message-Id: <ce8c7a5af804eca3b8978317bc8a5a219a7a7b88.1668455932.git.pawan.kumar.gupta@linux.intel.com>
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

pm_save_spec_msr() keeps a list of all the MSRs which _might_ need to be
saved and restored at hibernate?? and resume??.  However, it has zero
awareness of CPU support for these MSRs.  It mostly works by
unconditionally attempting to manipulate these MSRs and relying on
rdmsrl_safe() being able to handle a #GP on CPUs where the support is
unavailable.

However, it's possible for reads (RDMSR) to be supported for a given MSR
while writes (WRMSR) are not.  In this case, msr_build_context() sees a
successful read (RDMSR) and marks the MSR as 'valid'.  Then, later, a
write (WRMSR) fails, producing a nasty (but harmless) error message.
This causes restore_processor_state() to try and restore it, but writing
this MSR is not allowed on the Intel Atom N2600 leading to:

  unchecked MSR access error: WRMSR to 0x122 (tried to write 0x0000000000000002) \
     at rIP: 0xffffffff8b07a574 (native_write_msr+0x4/0x20)
  Call Trace:
   <TASK>
   restore_processor_state
   x86_acpi_suspend_lowlevel
   acpi_suspend_enter
   suspend_devices_and_enter
   pm_suspend.cold
   state_store
   kernfs_fop_write_iter
   vfs_write
   ksys_write
   do_syscall_64
   ? do_syscall_64
   ? up_read
   ? lock_is_held_type
   ? asm_exc_page_fault
   ? lockdep_hardirqs_on
   entry_SYSCALL_64_after_hwframe

To fix this, add the corresponding X86_FEATURE bit for each MSR.  Avoid
trying to manipulate the MSR when the feature bit is clear. This
required adding a X86_FEATURE bit for MSRs that do not have one already,
but it's a small price to pay.

Fixes: 73924ec4d560 ("x86/pm: Save the MSR validity status at context setup")
Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/power/cpu.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index bb176c72891c..0d97c25551f0 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -511,17 +511,26 @@ static int pm_cpu_check(const struct x86_cpu_id *c)
 	return ret;
 }
 
+struct msr_enumeration {
+	u32 msr_no;
+	u32 feature;
+};
+
 static void pm_save_spec_msr(void)
 {
-	u32 spec_msr_id[] = {
-		MSR_IA32_SPEC_CTRL,
-		MSR_IA32_TSX_CTRL,
-		MSR_TSX_FORCE_ABORT,
-		MSR_IA32_MCU_OPT_CTRL,
-		MSR_AMD64_LS_CFG,
+	struct msr_enumeration msr_enum[] = {
+		{MSR_IA32_SPEC_CTRL,	X86_FEATURE_MSR_SPEC_CTRL},
+		{MSR_IA32_TSX_CTRL,	X86_FEATURE_MSR_TSX_CTRL},
+		{MSR_TSX_FORCE_ABORT,	X86_FEATURE_TSX_FORCE_ABORT},
+		{MSR_IA32_MCU_OPT_CTRL,	X86_FEATURE_SRBDS_CTRL},
+		{MSR_AMD64_LS_CFG,	X86_FEATURE_LS_CFG_SSBD},
 	};
+	int i;
 
-	msr_build_context(spec_msr_id, ARRAY_SIZE(spec_msr_id));
+	for (i = 0; i < ARRAY_SIZE(msr_enum); i++) {
+		if (boot_cpu_has(msr_enum[i].feature))
+			msr_build_context(&msr_enum[i].msr_no, 1);
+	}
 }
 
 static int pm_check_save_msr(void)
-- 
2.37.3

