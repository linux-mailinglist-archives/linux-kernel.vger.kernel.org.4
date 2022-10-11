Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158A85FBDDB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 00:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiJKWYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 18:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJKWY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 18:24:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13372B27C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 15:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665527068; x=1697063068;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zWLh6lckIuD6uRmP7t7beHp+id3OGg9p0XzTNSvHSO8=;
  b=iIOycd3I2EAjrE1gGKk1/SfQjn3SM5Om6gcG62BfaSOZdqFPsyvAkzUp
   d6JrayMbQpnsqY7Fct8jrIGZd6/arpKEuv9G9H24d2yJHVLRJUAEch6CP
   oaQ1gpTCBTMvTUw6TZHbo8FRllxOkCceB6IKcoaJg3w3RgYrtg3pqkiwz
   Y/U82lQ2pxskRnxLgmT/KAnCNjKAdgz9Layb6FVeL/wuc6EUD6xD8wUag
   xH0steS851+97wLxYfsLjw3IJ2jr2KQuJjVjBHvHRRomFbAP6IA/xQLxo
   YeDZD13+0RkqxqC970fCoSNzpixwVEu9iBmQVTAwzRd0/chtgpKP3MrZx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="390946343"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="390946343"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 15:24:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="689419429"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="689419429"
Received: from viggo.jf.intel.com (HELO ray2.amr.corp.intel.com) ([10.54.77.144])
  by fmsmga008.fm.intel.com with ESMTP; 11 Oct 2022 15:24:25 -0700
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     chang.seok.bae@intel.com, x86@kernel.org,
        Yuan Yao <yuan.yao@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] x86/fpu: Remove dynamic features from xcomp_bv for init_fpstate
Date:   Tue, 11 Oct 2022 15:24:25 -0700
Message-Id: <20221011222425.866137-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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

From: Yuan Yao <yuan.yao@intel.com>

This was found a couple of months ago in a big old AMX
backport.  But, it looks to be a problem in mainline too.
Please let me know if this looks OK.  I'd also especially
appreciate some testing from folks that have AMX hardware
handy.

Builds and survives a quick boot test on non-AMX hardware.

--

== Background ==

'init_fpstate' is a sort of template for all of the fpstates
that come after it.  It is copied when new processes are
execve()'d or XRSTOR'd to get fpregs into a known state.

That means that it represents the *starting* state for a
process's fpstate which includes only the 'default' features.
Dynamic features can, of course, be acquired later, but
processes start with only default_features.

During boot the kernel decides whether all fpstates will be
kept in the compacted or uncompacted format.  This choice is
communicated to the hardware via the XCOMP_BV field in all
XSAVE buffers, including 'init_fpstate'.

== Problem ==

But, the existing XCOMP_BV calculation is incorrect.  It uses
the set of 'max_features', not the default features.

As a result, when XRSTOR operates on buffers derived from
'init_fpstate', it may attempt to "tickle" dynamic features which
are at offsets for which there is no space allocated in the
fpstate.

== Scope ==

This normally results in a relatively harmless out-of-bounds
memory read.  It's harmless because it never gets consumed.  But,
if the fpstate is next to some unmapped memory, this "tickle" can
cause a page fault and an oops.

This only causes issues on systems when dynamic features are
available and when an XSAVE buffer is next to uninitialized
memory.  In other words, it only affects recent Intel server
CPUs, and in relatively few memory locations.

Those two things are why it took relatively long to catch this.

== Solution ==

Use 'default_features' to establish the init_fpstate
xcomp_bv value.  Reset individual fpstate xcomp_bv values
when the rest of the fpstate is reset.

[ dhansen: add reset code from tglx, rewrites
	   commit message and comments ]

Fixes: 1c253ff2287f ("x86/fpu: Move xstate feature masks to fpu_*_cfg")
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Yuan Yao <yuan.yao@intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/fpu/core.c   | 3 +++
 arch/x86/kernel/fpu/xstate.c | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 3b28c5b25e12..4d64de34da12 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -526,6 +526,9 @@ static void __fpstate_reset(struct fpstate *fpstate, u64 xfd)
 	fpstate->xfeatures	= fpu_kernel_cfg.default_features;
 	fpstate->user_xfeatures	= fpu_user_cfg.default_features;
 	fpstate->xfd		= xfd;
+
+	/* Ensure that xcomp_bv matches ->xfeatures */
+	xstate_init_xcomp_bv(&fpstate->regs.xsave, fpstate->xfeatures);
 }
 
 void fpstate_reset(struct fpu *fpu)
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c8340156bfd2..f9f45610c72f 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -360,7 +360,12 @@ static void __init setup_init_fpu_buf(void)
 
 	print_xstate_features();
 
-	xstate_init_xcomp_bv(&init_fpstate.regs.xsave, fpu_kernel_cfg.max_features);
+	/*
+	 * 'init_fpstate' is sized for the default feature
+	 * set without any of the dynamic features.
+	 */
+	xstate_init_xcomp_bv(&init_fpstate.regs.xsave,
+			     fpu_kernel_cfg.default_features);
 
 	/*
 	 * Init all the features state with header.xfeatures being 0x0
-- 
2.34.1

