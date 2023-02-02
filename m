Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B456872F6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjBBBZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjBBBZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:25:19 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9C869539;
        Wed,  1 Feb 2023 17:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675301118; x=1706837118;
  h=from:to:cc:subject:date:message-id;
  bh=VBzWoukx2SS6XrRH71Q5fqpOr6MncyDcf/33oE3P7lI=;
  b=beF/Lr5C9NVEgO7hduUfx8hk/ilFwbGTmKYHQkRB97wo1xvROWrqek8L
   ORUZglD3bkgycT1+EtrUsFmM2qocvfYKyLEdvnqmJxslZUPWFmdUSj/yR
   OH9yOUKOAV+uaZCbiZ2FLi3yz1DYpXwRo7gxfEBSyldra1CSXWgo7pL92
   twsDpmvp0JorYUeODlr8FW4+qi9mCJcqxRgNo7ttG/uRWXnyUVBcvaRng
   S+7JZZJLX6FkcvGAV1EVv1FSfiWpC8keAGsvz+HDNv935NnRsYNqMVaLl
   mp0SCsER+0wLBg49hk9TJs/whrQx6RdjE2wFr827Mohveyr3VU5eWzMkx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="328334772"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="328334772"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 17:25:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="695579295"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="695579295"
Received: from power-sh.sh.intel.com ([10.239.183.7])
  by orsmga008.jf.intel.com with ESMTP; 01 Feb 2023 17:25:16 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] powercap/intel_rapl: Fix handling for large time window
Date:   Thu,  2 Feb 2023 09:31:40 +0800
Message-Id: <20230202013140.30416-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
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
 drivers/powercap/intel_rapl_common.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 26d00b1853b4..8b30e5259d3b 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -999,7 +999,12 @@ static u64 rapl_compute_time_window_core(struct rapl_package *rp, u64 value,
 
 		do_div(value, rp->time_unit);
 		y = ilog2(value);
-		f = div64_u64(4 * (value - (1 << y)), 1 << y);
+		if (y > 0x1f) {
+			pr_warn("%s: time window too large, clamped\n", rp->name);
+			return 0x7f;
+		}
+
+		f = div64_u64(4 * (value - (1ULL << y)), 1ULL << y);
 		value = (y & 0x1f) | ((f & 0x3) << 5);
 	}
 	return value;
-- 
2.25.1

