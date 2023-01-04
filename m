Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FF665DD74
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240101AbjADUO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239277AbjADUOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:14:11 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51D21B9FB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 12:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672863249; x=1704399249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7qAgriB4wHb+jHdCXvImsH0VxmeivK2v66/ujQm0auE=;
  b=NtkPnD6+P4Dql5BizSDZ9Y4PnTlsLS3h8onSPO8ngTL509Vp81d2V/Jv
   nTHaW6tlklSyI3vqKXD79qSf3mnAnBLLkG/YPxk8BxE1xVKxA7DTIsAwF
   Y73xO4tJo75weszET/I+SvHyyC9odyjieCXGXMEms0gQglmjvZi4TepJt
   GdvN7Tf6cIZdwrM9fIF73keEARGC84HPD7B/5UPu6KKKk73OrVKJ2Z5dM
   e+XUNTiB7M0Cou1Vk47dvRAfKG2zjezTKsySxRqcke4PIJXfeVMrfneKy
   sdTPu0owA754Xi56v9h5pxeS+4hKSYMixU5GLRnujH856B0z6lLWEPHzq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="322105461"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="322105461"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 12:14:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="779324003"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="779324003"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga004.jf.intel.com with ESMTP; 04 Jan 2023 12:14:09 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, irogers@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 4/9] x86/cpufeatures: Add Architectural PerfMon Extension bit
Date:   Wed,  4 Jan 2023 12:13:44 -0800
Message-Id: <20230104201349.1451191-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230104201349.1451191-1-kan.liang@linux.intel.com>
References: <20230104201349.1451191-1-kan.liang@linux.intel.com>
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

Change since V1
- Rebase on top of 6.2-rc1

 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 61012476d66e..b64555b68a14 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -312,6 +312,7 @@
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
 #define X86_FEATURE_CMPCCXADD           (12*32+ 7) /* "" CMPccXADD instructions */
+#define X86_FEATURE_ARCH_PERFMON_EXT	(12*32+ 8) /* "" Intel Architectural PerfMon Extension */
 #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
 #define X86_FEATURE_AVX_IFMA            (12*32+23) /* "" Support for VPMADD52[H,L]UQ */
 
-- 
2.35.1

