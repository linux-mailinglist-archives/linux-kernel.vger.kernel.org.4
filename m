Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D168A63F8A7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiLAT5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiLAT5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:57:18 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D61092A10
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669924638; x=1701460638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FuioOk9lkJV3UqTyerhKrNp8li4XyFOaJM/neBGnO78=;
  b=Ze8ep/UlnqH4qh7kzQh7aTefBmzGmkoARBgBLw0MOKm1gd8KzD4I835v
   dXtkrtAE90m35K2wupMiKpuvnR5hirGjhg+md0zlvfvWP8RswrAKxdhsq
   i3hnUCvb+RB21QXhyiKlAIIHdHimXi+A3xkZb9ugNVOZZn49ceRHZeXEd
   RqaXvauAPyL5BzVfTDMTKyJjsea+Qb+mQ5ojq7EVqTBT/Do86sJTsGd6f
   J36BraxTrr66IY0uwo44E9aV5FKzuwm/UiSfoB4yJu57ZspD89qWWcMRx
   OPakwsBKPO7J9NPcHjssU15rLbZoGTHC45Exiu/eSBupNiGZzmvldKoHD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="303391872"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="303391872"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 11:57:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="708205083"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="708205083"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga008.fm.intel.com with ESMTP; 01 Dec 2022 11:57:16 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, irogers@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 4/9] x86/cpufeatures: Add Architectural PerfMon Extension bit
Date:   Thu,  1 Dec 2022 11:56:59 -0800
Message-Id: <20221201195704.2330866-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221201195704.2330866-1-kan.liang@linux.intel.com>
References: <20221201195704.2330866-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

CPUID.(EAX=07H, ECX=1):EAX[8] indicates whether the Architectural
PerfMon Extension leaf (CPUID leaf 23) is supported.

The "X86_FEATURE_..., word 12" is already mirrored from CPUID
"0x00000007:1 (EAX)". Add X86_FEATURE_ARCH_PERFMON_EXT under the
"word 12" section.

The new Architectural PerfMon Extension leaf (CPUID leaf 23) will be
supported in the perf_events subsystem later.

The feature will not appear in /proc/cpuinfo.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index b71f4f2ecdd5..9f05a0bb93ca 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -308,6 +308,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
+#define X86_FEATURE_ARCH_PERFMON_EXT	(12*32+ 8) /* "" Intel Architectural PerfMon Extension */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
-- 
2.35.1

