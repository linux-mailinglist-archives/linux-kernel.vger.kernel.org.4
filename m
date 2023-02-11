Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E892692DA2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 04:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBKDR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 22:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBKDRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 22:17:54 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3ADC56EC6;
        Fri, 10 Feb 2023 19:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676085463; x=1707621463;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sb+EmESFN2NwMi7oUF5AK4fv80o+2wrYvPnvn9rSR1A=;
  b=mBu3WwJHYlx00v2WmeFJZQXG4ZpYvE2rVUrQsHFqEnxoDE/DZEF+Z2by
   KVGqOIyGMstF6kPF8bLPb9c2pD3s70vZI5vhXmzKVkFxyLfKSK2nauKAN
   0/aOFUSvZG5IVWXCYDBR2vHh38FNKcYvfYrDGME4N4GevRc2u9T5TziH8
   spxtIjxQDYevxHw3CZiHer84p/KA03yt7Ft/RwA9tBA9v6CtIuvwMKLkA
   cN57RenFWMywtzPBdHC3z8fO3kHr8sh89PbC/r73h5SsQBpVsNUlCP9dQ
   kANvgDFGYWcd1Qlr3dLaPh2rZri3d0/vhnNQ3yBpC7h2nYU/nBbbE6Nwq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="330586656"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="330586656"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 19:17:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="731919112"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="731919112"
Received: from danma-mobl1.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.254.213.8])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 19:17:22 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: [PATCH V2] powercap/intel_rapl: Fix handling for large time window
Date:   Sat, 11 Feb 2023 11:17:10 +0800
Message-Id: <20230211031710.277459-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When setting the power limit time window, software updates the 'y' bits
and 'f' bits in the power limit register, and the value hardware takes
follows the formula below

	Time window = 2 ^ y * (1 + f / 4) * Time_Unit

When handling large time window input from userspace, using left
shifting breaks in two cases,
1. when ilog2(value) is bigger than 31, in expression "1 << y", left
   shifting by more than 31 bits has undefined behavior. This breaks
   'y'. For example, on an Alderlake platform, "1 << 32" returns 1.
2. when ilog2(value) equals 31, "1 << 31" returns negative value
   because '1' is recognized as signed int. And this breaks 'f'.

Given that 'y' has 5 bits and hardware can never take a value larger
than 31, fix the first problem by clamp the time window to the maximum
possible value that the hardware can take.

Fix the second problem by using unsigned bit left shift.

Note that hardware has its own maximum time window limitation, which
may be lower than the time window value retrieved from the power limit
register. When this happens, hardware clamps the input to its maximum
time window limitation. That is why a software clamp is preferred to
handle the problem on hand.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
Change since V1:
1. drop pr_warn message for bogus userspace input.
2. Add a comment when handling the large exponent.
---
 drivers/powercap/intel_rapl_common.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 26d00b1853b4..69526d21699d 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -999,7 +999,15 @@ static u64 rapl_compute_time_window_core(struct rapl_package *rp, u64 value,
 
 		do_div(value, rp->time_unit);
 		y = ilog2(value);
-		f = div64_u64(4 * (value - (1 << y)), 1 << y);
+
+		/*
+		 * The target hardware field has 7 bits, return all ones if
+		 * the exponent is too large.
+		 */
+		if (y > 0x1f)
+			return 0x7f;
+
+		f = div64_u64(4 * (value - (1ULL << y)), 1ULL << y);
 		value = (y & 0x1f) | ((f & 0x3) << 5);
 	}
 	return value;
-- 
2.25.1
