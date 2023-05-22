Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5859070CE1D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbjEVWjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbjEVWiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:38:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86164FE;
        Mon, 22 May 2023 15:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684795133; x=1716331133;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=twPJPBQvSJdj8pszIWsTqK3k3eR4WJYwlwiK6V0ITV8=;
  b=QDA3Vm0R1QWzV//AFnxvACHd3Ge707D2iOKnxuP5bX57VkQUiG2YeMuL
   aW9PFz+CGSqmOeRguDYkbYFpn9EWHxQB37b3lN8e6vM/qTEfLuHbiAGRd
   RFDS9gOlgjuMaRaZRXVl2JVlVZa0SHMgupnVba76ESuPF9HlSTs13GH4x
   90rGOxTKRmeV+j/7zaddZdP++kBdf4nsCeAsUtoRWzpBWsOjIi9iQUqO6
   ClXn7izcKzaV60ONwCzQiXTsy/0N+ykPELO/iZ3qIhEzRntZ5AXszeKQc
   /+vFFe/Jc4DLaWnOMx3xubEvmRamAHdIfReVFCVGuTcoVoJ0ZJgqkjYXo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="351910515"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="351910515"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 15:38:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="1033794760"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="1033794760"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga005.fm.intel.com with ESMTP; 22 May 2023 15:38:50 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH] thermal: int340x: Add new line for UUID display
Date:   Mon, 22 May 2023 15:38:44 -0700
Message-Id: <20230522223844.2330343-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to the commit:
"763bd29fd3d1 ("thermal: int340x_thermal: Use sysfs_emit_at() instead of
scnprintf()"
there was a new line after each UUID string. With the newline removed,
existing user space like "thermald" fails to compare each supported UUID
as it is using getline() to read UUID and apply correct thermal table.

To avoid breaking existing user space, add newline after each UUID string.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Fixes: 763bd29fd3d1 ("thermal: int340x_thermal: Use sysfs_emit_at() instead of scnprintf()")
Cc: stable@vger.kernel.org # v6.3+
---
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 810231b59dcd..5e1164226ada 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -131,7 +131,7 @@ static ssize_t available_uuids_show(struct device *dev,
 
 	for (i = 0; i < INT3400_THERMAL_MAXIMUM_UUID; i++) {
 		if (priv->uuid_bitmap & (1 << i))
-			length += sysfs_emit_at(buf, length, int3400_thermal_uuids[i]);
+			length += sysfs_emit_at(buf, length, "%s\n", int3400_thermal_uuids[i]);
 	}
 
 	return length;
@@ -149,7 +149,7 @@ static ssize_t current_uuid_show(struct device *dev,
 
 	for (i = 0; i <= INT3400_THERMAL_CRITICAL; i++) {
 		if (priv->os_uuid_mask & BIT(i))
-			length += sysfs_emit_at(buf, length, int3400_thermal_uuids[i]);
+			length += sysfs_emit_at(buf, length, "%s\n", int3400_thermal_uuids[i]);
 	}
 
 	if (length)
-- 
2.39.1

