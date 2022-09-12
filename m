Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB835B6445
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 01:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiILXl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 19:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiILXlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 19:41:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F51D25298;
        Mon, 12 Sep 2022 16:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663026109; x=1694562109;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5VLXrjOR8Z8WZuxPsiSZsdGrF+rYHfQ8teAthj0SE20=;
  b=lfzk1eakTj2E6w4N0hXj3MHqJbp6LqhVQR0ImUXjFloHPgJ87Iku68FF
   KcZjqW8rP8Y1Y6DTNzdPd8TB6MidoMpoEoJxYWcI2fBPCVUqueBUSuT0S
   NxuOdSqCr/Ht3Zv0NHdp5cacAD29oeif7bF98ACANT0cVa0VRfEZMotzC
   vhM0HMk+7XpOrVGNirKJiQRP+qUJBP9sQ5fGBF/O83YDyr1h7EqBrfuCL
   jXb6yRKTtebz1zfPZBW5puHkGDbLTW17yCpRvRKSAzMTeWB0IEV9Jntwu
   8+Ztz3K+GGMOXVv3gKZ3hUv703OWvwlbTBaQ11KZsYBqdUBYBS/5qUH6y
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="298793777"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="298793777"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 16:41:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="741961153"
Received: from sho10-mobl1.amr.corp.intel.com (HELO desk) ([10.251.9.78])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 16:41:48 -0700
Date:   Mon, 12 Sep 2022 16:41:48 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>, degoede@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com
Subject: [PATCH 3/3] x86/pm: Add enumeration check before spec MSRs
 save/restore setup
Message-ID: <206cec042e17f15432d523d12ce6f5ae9267dc77.1663025154.git.pawan.kumar.gupta@linux.intel.com>
References: <cover.1663025154.git.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1663025154.git.pawan.kumar.gupta@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On an Intel Atom N2600 (and presumable other Cedar Trail models)
MSR_IA32_TSX_CTRL can be read, causing saved_msr.valid to be set for it
by msr_build_context().

This causes restore_processor_state() to try and restore it, but writing
this MSR is not allowed on the Intel Atom N2600 leading to:

[   99.955141] unchecked MSR access error: WRMSR to 0x122 (tried to write 0x0000000000000002) at rIP: 0xffffffff8b07a574 (native_write_msr+0x4/0x20)
[   99.955176] Call Trace:
[   99.955186]  <TASK>
[   99.955195]  restore_processor_state+0x275/0x2c0
[   99.955246]  x86_acpi_suspend_lowlevel+0x10e/0x140
[   99.955273]  acpi_suspend_enter+0xd3/0x100
[   99.955297]  suspend_devices_and_enter+0x7e2/0x830
[   99.955341]  pm_suspend.cold+0x2d2/0x35e
[   99.955368]  state_store+0x68/0xd0
[   99.955402]  kernfs_fop_write_iter+0x15e/0x210
[   99.955442]  vfs_write+0x225/0x4b0
[   99.955523]  ksys_write+0x59/0xd0
[   99.955557]  do_syscall_64+0x58/0x80
[   99.955579]  ? do_syscall_64+0x67/0x80
[   99.955600]  ? up_read+0x17/0x20
[   99.955631]  ? lock_is_held_type+0xe3/0x140
[   99.955670]  ? asm_exc_page_fault+0x22/0x30
[   99.955688]  ? lockdep_hardirqs_on+0x7d/0x100
[   99.955710]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   99.955723] RIP: 0033:0x7f7d0fb018f7
[   99.955741] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[   99.955753] RSP: 002b:00007ffd03292ee8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   99.955771] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f7d0fb018f7
[   99.955781] RDX: 0000000000000004 RSI: 00007ffd03292fd0 RDI: 0000000000000004
[   99.955790] RBP: 00007ffd03292fd0 R08: 000000000000c0fe R09: 0000000000000000
[   99.955799] R10: 00007f7d0fb85fb0 R11: 0000000000000246 R12: 0000000000000004
[   99.955808] R13: 000055df564173e0 R14: 0000000000000004 R15: 00007f7d0fbf49e0
[   99.955910]  </TASK>

Add speculation control MSRs to MSR save/restore list only if their
corresponding feature bit is set. This prevents MSR save/restore to
attempt invalid MSR.

Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/power/cpu.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index bb176c72891c..b3492dd55e61 100644
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
+		{MSR_AMD64_LS_CFG,	X86_FEATURE_MSR_LS_CFG},
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
2.37.2


