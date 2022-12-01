Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B237863F8AA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiLAT5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiLAT5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:57:19 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3C292A10
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669924639; x=1701460639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5NEx/bxUh3Dnkqm8hyP55D1tHzksS3f13yi+/V0jpV8=;
  b=iPklKJSGkxzy4TFyvpLK2if9dK+QTkJbUPuW2Ov0WaXmNHA7HpgK55eG
   x2QPBIpDUqp7+38i+mQVF5Fm2lVAVgnb/XxGh5hVw1C2i4d9Qif+pvAvM
   vCz/ANnKF9lss06DRgOqI/nRRPkZpS77udr3ny5AvjK6rgSBdpkbUDcNH
   yB0UTu//o9yYwuU1H+yabgS/dQ6/xjBTqy5WJObWJvAVMEQAJrvWWq5Kn
   1SjBT3CFfaQdkvhRuWxrpH9d5AJFDQ/BZRLtWiGxK07+BfeuQuYvZoDBt
   E6Gr2W88ljBa87FfBhvQMcJnUB81cbwfgnpDj9OTNS4cec5OFEa2+I/mM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="303391889"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="303391889"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 11:57:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="708205144"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="708205144"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga008.fm.intel.com with ESMTP; 01 Dec 2022 11:57:18 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, irogers@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 7/9] perf/x86/msr: Add Meteor Lake support
Date:   Thu,  1 Dec 2022 11:57:02 -0800
Message-Id: <20221201195704.2330866-7-kan.liang@linux.intel.com>
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

Meteor Lake is Intel's successor to Raptor lake. PPERF and SMI_COUNT MSRs
are also supported.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/msr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index ecced3a52668..074150d28fa8 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -107,6 +107,8 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_RAPTORLAKE:
 	case INTEL_FAM6_RAPTORLAKE_P:
 	case INTEL_FAM6_RAPTORLAKE_S:
+	case INTEL_FAM6_METEORLAKE:
+	case INTEL_FAM6_METEORLAKE_L:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
 		break;
-- 
2.35.1

