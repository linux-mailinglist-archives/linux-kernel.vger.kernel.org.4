Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99BC5EE08E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbiI1PeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbiI1Pdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:33:41 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8211FD21
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664379220; x=1695915220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lyIQvO6QryqLJ9DdTCazOcSHrR9HExVOtryBPtG47aI=;
  b=egTShiQThc21WijcMU6jnkWpl9aw6wUVS2C4e8P2B/zGH2ABCBA1DEOB
   zR1t2j6+0p3vLB/47aZpPsu39ySecZM0tB8ltoPmGaJzrscZ0y8LoGRnE
   RaUYOYiBMj6UxwV1aCGRJkv7cRJWjkHe9gmoaa2Qi85Ry55EXuzhrM33t
   E7ypnOS171KdzhYEreevw3ygpnwTMRYPnJh0MQFRE8U78uJLlgw0lid+U
   Wo0n1Qt4fEUQ69nabKrMKP5RlAHPxI56CzVMPmfRtxYW17Vv5KsMAgy06
   jt0Py6SclaxBB8DOa9u16dP5zCVr5+3J/d/1lOVTeV1YC623Uf4HR3S3v
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="302544938"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="302544938"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 08:33:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="764328135"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="764328135"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga001.fm.intel.com with ESMTP; 28 Sep 2022 08:33:40 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 3/4] perf/x86/cstate: Add new Raptor Lake S support
Date:   Wed, 28 Sep 2022 08:33:30 -0700
Message-Id: <20220928153331.3757388-3-kan.liang@linux.intel.com>
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

From the perspective of Intel cstate residency counters, the new
Raptor Lake S is the same as the other hybrid {ALDER,RAPTOP}LAKE.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
- Rebase on top of tip master branch
  9286a39427d5 ("Merge branch into tip/master: 'perf/core'")

 arch/x86/events/intel/cstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 8ec23f47fee9..a2834bc93149 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -685,6 +685,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&adl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&adl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&adl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
-- 
2.35.1

