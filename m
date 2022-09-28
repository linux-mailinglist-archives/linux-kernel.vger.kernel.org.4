Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CD55EE090
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiI1Pd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbiI1Pdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:33:40 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFDE272E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664379219; x=1695915219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y5KrlaZXK2n4gEYTOuzqegMpGhsLPAZKlwe9qmZ6YG4=;
  b=IrKVvHTzs+WCQqqP8nuzN3E/sSir1+HZFVl3T6LyplguiYvJ8uohTg0c
   wOrlE0VAD9wTqig8SCvtYsfhhPjJTto8y5XDfpXIXUWREgriB5b6PE16Z
   YNo/uErTYEkTUHmKDIqipZ+48SvPW3GcJYABg9kAee8KtFiOmtqMEqfMl
   JIEGAVbpNqW6ierSXQE7EQNqRUKCL077RulqSrPucEsrKcTcyeooj5mVg
   ZveeBadnxCBvkknbentlTmTZGv4rNwxDfk3z+tf59zNXZs43GiCz1jd9f
   08F+ZO3C6upiUw1avzp8/Cp1vfRtcZb1/b83vSw+jxrzGCiqGSuGlTD64
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="302544933"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="302544933"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 08:33:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="764328129"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="764328129"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga001.fm.intel.com with ESMTP; 28 Sep 2022 08:33:38 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 2/4] perf/x86/msr: Add new Raptor Lake S support
Date:   Wed, 28 Sep 2022 08:33:29 -0700
Message-Id: <20220928153331.3757388-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220928153331.3757388-1-kan.liang@linux.intel.com>
References: <20220928153331.3757388-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The same as the other hybrid {ALDER,RAPTOP}LAKE, the new Raptor Lake S
also support PPERF and SMI_COUNT MSRs.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
- Rebase on top of tip master branch
  9286a39427d5 ("Merge branch into tip/master: 'perf/core'")

 arch/x86/events/msr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index ac542f98c070..ecced3a52668 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -106,6 +106,7 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_ALDERLAKE_N:
 	case INTEL_FAM6_RAPTORLAKE:
 	case INTEL_FAM6_RAPTORLAKE_P:
+	case INTEL_FAM6_RAPTORLAKE_S:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
 		break;
-- 
2.35.1

