Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049616D862B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 20:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjDESkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 14:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjDESkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:40:19 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E9E6194
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 11:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680720014; x=1712256014;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zgirNs/yy9kf5VlqEnEGs45ztndGGwdnGjYncEsTT3U=;
  b=LXnOPxTF41AHdN3THl750QLPTzeRdHPnqRaorr5QGds86ddLxubZWaHX
   XbKSdsxEuhAntlGOoqR0nlsSxXZFftgDgf+LSbn2sSQ767TX1vVvbcOZ/
   Y0IWPb5XtWXnoNMONekCjHCY43JtnImUN0PflQVCWnamwqg2lXg7YjzTt
   Wl9hycpO3AcNmB23pm2ACSBXuk7JqAdYUt8Flq6wh9MBk5/MZs7Hh1GM5
   VL7zwwFt/tHPoD+yZlwPa+x/sgtfFdLgYfy1wFH+4zcgXBUprN8Nwu8Ck
   QlX8YyE+0813OyJf9p8EdJnyrDjsw5gyOoK0WCD9jCteC7QdwECPsZ3Dt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="340030870"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="340030870"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 11:40:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="636993556"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="636993556"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga003.jf.intel.com with ESMTP; 05 Apr 2023 11:40:12 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@redhat.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
        Chintan M Patel <chintan.m.patel@intel.com>
Subject: [RFC PATCH] x86/fpu/xstate: Add more diagnostic information on inconsistent xstate sizes
Date:   Wed,  5 Apr 2023 11:39:42 -0700
Message-Id: <20230405183942.734019-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A warning is emitted when xstate sizes are found inconsistent.
But the warning message doesn't show enough information to diagnose
the issue.

Provide more detailed xstate size information to help debug the issue.
As a hypothetical example, on a platform that may report incorrect
xstate size in CPUID.0xd.1:EBX, the diagnostic information after
the warning will show:
[    0.000000] x86/fpu: max_features=0x407
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[10]: 832, xstate_sizes[10]:    8
[    0.000000] x86/fpu: total size: 840 bytes
[    0.000000] x86/fpu: XCR0=0x7, IA32_XSS=0x400
[    0.000000] x86/fpu: kernel_size from CPUID.0xd.0x1:EBX: 576 bytes

XCR0 | IA32_XSS is 0x407 which is consistent with max_features.
CPUID.0xd.0x1:EBX should report the size of the xsave area
containing xstate components corresponding to bits set in
XCR0 | IA32_XSS. But it only reports 576 bytes of xsave area which
doesn't count xstate sizes for AVX (offset 2 and 256 bytes) and
PASID (offset 10 and 8 bytes). This confirms that the platform
reports xstate size incorrectly through the CPUID bits.

Suggest-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Chintan M Patel <chintan.m.patel@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/fpu/xstate.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 0bab497c9436..5f27fcdc6c90 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -602,8 +602,37 @@ static bool __init paranoid_xstate_size_valid(unsigned int kernel_size)
 		}
 	}
 	size = xstate_calculate_size(fpu_kernel_cfg.max_features, compacted);
-	XSTATE_WARN_ON(size != kernel_size,
-		       "size %u != kernel_size %u\n", size, kernel_size);
+	if (size != kernel_size) {
+		u64 xcr0, ia32_xss;
+
+		XSTATE_WARN_ON(1, "size %u != kernel_size %u\n",
+			       size, kernel_size);
+
+		/* Show more information to help diagnose the size issue. */
+		pr_info("x86/fpu: max_features=0x%llx\n",
+			fpu_kernel_cfg.max_features);
+		print_xstate_offset_size();
+		pr_info("x86/fpu: total size: %u bytes\n", size);
+		xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
+		if (compacted) {
+			rdmsrl(MSR_IA32_XSS, ia32_xss);
+			pr_info("x86/fpu: XCR0=0x%llx, IA32_XSS=0x%llx\n",
+				xcr0, ia32_xss);
+		} else {
+			pr_info("x86/fpu: XCR0=0x%llx\n", xcr0);
+		}
+		/*
+		 * In compact case, CPUID.0xd.0x1:EBX reports the size of
+		 * the XSAVE size containing all the state components
+		 * corresponding to bits set in XCR0 | IA32_XSS.
+		 *
+		 * Otherwise, CPUID.0xd.0x0:EBX reports the size of an XSAVE
+		 * area containing all the *user* state components
+		 * corresponding to bits set in XCR0.
+		 */
+		pr_info("x86/fpu: kernel_size from CPUID.0xd.0x%x:EBX: %u bytes\n",
+			compacted ? 1 : 0, kernel_size);
+	}
 	return size == kernel_size;
 }
 
-- 
2.37.1

