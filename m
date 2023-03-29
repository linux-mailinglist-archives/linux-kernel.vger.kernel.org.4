Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51FA6CD5C6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjC2JC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjC2JCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:02:21 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DD549C7;
        Wed, 29 Mar 2023 02:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680080509; x=1711616509;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MpN+NoE8ltrbIOFRhoiH8RX1fmB1SfinxkoJtqy1yZQ=;
  b=VJvlDSumZvChIuQE72fkllLEKkkOVJkHZLdhTmR128bZ978zpCRHRUyR
   Msklf7Co3nNoy1WWs+vUuceDB9ocfnyPvIXwopKtPtnCKZ9gvSs5yKTiN
   E3awsYZ5bx5dRAImEgwl8t7ydZxjq8tJDOGAFFZzp4drQUpBotH7bSstQ
   u4g+oYUsXKrF3lEyAHHdwuQoqkRlcoJVKK+4bkXUbzDbzBnFljn7o2xyD
   Pw5ZIrZtfLfnBTIQagYLuQEN7KvSDQ6v9uC/tEOX7DC3fRV/mUdXoIMLf
   YeytPmGqGHRCbOZXZ0KeAJmhk0yniAf7ddqIY8qnOqG94BfM04uLcaVts
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="324726927"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="324726927"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 02:01:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="748717768"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="748717768"
Received: from wenqin8x-mobl1.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.254.212.141])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 02:01:03 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH -next] thermal/drivers/thermal_hwmon: Fix a kernel NULL pointer dereference
Date:   Wed, 29 Mar 2023 17:00:55 +0800
Message-Id: <20230329090055.7537-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the hwmon device node of a thermal zone device is not found,
using hwmon->device causes a kernel NULL pointer dereference.

Reported-by: Preble Adam C <adam.c.preble@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
Fixes: dec07d399cc8 ("thermal: Don't use 'device' internal thermal zone structure field")
dec07d399cc8 is a commit in the linux-next branch of linux-pm repo.
I'm not sure if the Fix tag applies to such commit or not.
---
 drivers/thermal/thermal_hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index c59db17dddd6..261743f461be 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -229,7 +229,7 @@ void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 	hwmon = thermal_hwmon_lookup_by_type(tz);
 	if (unlikely(!hwmon)) {
 		/* Should never happen... */
-		dev_dbg(hwmon->device, "hwmon device lookup failed!\n");
+		dev_dbg(&tz->device, "hwmon device lookup failed!\n");
 		return;
 	}
 
-- 
2.25.1

