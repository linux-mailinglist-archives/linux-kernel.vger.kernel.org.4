Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9B373839F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjFUMWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjFUMWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:22:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D35EDD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687350149; x=1718886149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t7jSq9lhIuDurlZNMr91+neHmx2u8cph/G6HgXnh4hI=;
  b=iNlRnkdrHc36YbhD2KaZiF5rttMJXCm4yYkKrmq48HYRrKvqysghohZ5
   hq1jPi/rRghzjRjpJNqAO2bdrCcIPb+GoTBNnuqFK1uw87KA5ZQkbbHFX
   l48mc/sBGy8+bf87+pd8T6YJYS8uLHau31P1cHCFrCgEPXpxb/IcFtaDy
   cthAp4A3ZO0LZ2Wq28xSKKj5OM3EY8/9O/5IGKfjV3fC5QDwVxwGbM0l+
   93I8GAk5UDqJynzm5cddM5CevUkvsVng9+EVjgAMsHy6EvuT+zaOeJrUv
   7MY3GmGeR1NvgZFafPR7sEKVveDh91qxxrW6r3slIb+/VHhtcrpzYcb+9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="360165698"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="360165698"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 05:22:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="888638354"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="888638354"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga005.jf.intel.com with ESMTP; 21 Jun 2023 05:22:28 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        andrew.cooper3@citrix.com, chang.seok.bae@intel.com
Subject: [PATCH v1 3/4] x86/fpu/xstate: Simplify print_xstate_features()
Date:   Wed, 21 Jun 2023 05:09:41 -0700
Message-Id: <20230621120942.121822-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621120942.121822-1-chang.seok.bae@intel.com>
References: <20230621120942.121822-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The print_xstate_features() invokes print_xstate_feature() multiple
times in separate lines which can be replaced with a loop.

The print_xstate_feature() function already checks the feature
enabling status, and it is only called from within
print_xstate_features(). So the code can be relocated.

Move the code exactly to print_xstate_features() and wrap it with a
loop there.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/fpu/xstate.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index d488621b280e..6d72498ea0bc 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -253,31 +253,20 @@ static void __init setup_xstate_cache(void)
 	}
 }
 
-static void __init print_xstate_feature(u64 xstate_mask)
-{
-	const char *feature_name;
-
-	if (cpu_has_xfeatures(xstate_mask, &feature_name))
-		pr_info("x86/fpu: Supporting XSAVE feature 0x%03Lx: '%s'\n", xstate_mask, feature_name);
-}
-
 /*
  * Print out all the supported xstate features:
  */
 static void __init print_xstate_features(void)
 {
-	print_xstate_feature(XFEATURE_MASK_FP);
-	print_xstate_feature(XFEATURE_MASK_SSE);
-	print_xstate_feature(XFEATURE_MASK_YMM);
-	print_xstate_feature(XFEATURE_MASK_BNDREGS);
-	print_xstate_feature(XFEATURE_MASK_BNDCSR);
-	print_xstate_feature(XFEATURE_MASK_OPMASK);
-	print_xstate_feature(XFEATURE_MASK_ZMM_Hi256);
-	print_xstate_feature(XFEATURE_MASK_Hi16_ZMM);
-	print_xstate_feature(XFEATURE_MASK_PKRU);
-	print_xstate_feature(XFEATURE_MASK_PASID);
-	print_xstate_feature(XFEATURE_MASK_XTILE_CFG);
-	print_xstate_feature(XFEATURE_MASK_XTILE_DATA);
+	int i;
+
+	for (i = 0; i < XFEATURE_MAX; i++) {
+		u64 mask = BIT_ULL(i);
+		const char *name;
+
+		if (cpu_has_xfeatures(mask, &name))
+			pr_info("x86/fpu: Supporting XSAVE feature 0x%03Lx: '%s'\n", mask, name);
+	}
 }
 
 /*
-- 
2.34.1

