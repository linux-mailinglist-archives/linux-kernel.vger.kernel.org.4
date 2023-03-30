Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF806D0151
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjC3KeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjC3KeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:34:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDC240C8;
        Thu, 30 Mar 2023 03:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680172450; x=1711708450;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aMBrQv3dD6HKKF5OK2mlzf/ElkqwSIasmpXMMURYf7c=;
  b=XdaD6IyJYXzHf1keZCkTAxzHr5vJSXNY/ftsJwBoRxBZYJ1pb7wwTZVs
   cthrIpjn9NNRPiplZkeuPKbKehjO2TaMOvs+sStHhQAPiRCyU0dQrTBu1
   /Vca6AihNsKm1amdW6ENjJdeA8HBl4ANJ6VkBbnpKwPfgcCqVX4ryQi7G
   vDq3Bof9mEBDKN8aDr1WtM0IC2ca6jdfC+GkLjK/EDrF4Ua+gI76UVCZx
   HW3Q7DIYtgpXLZrfPLsuCquZlYMHlVmFTSYbFy4buNgLkrtaH7t3obNVY
   IE6iDF1IKkabLLHdgSQbNuGxcgW2bpL5k1NcqGGBsR84VTL1aTKwYtU6E
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="368910788"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="368910788"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 03:34:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="634832281"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="634832281"
Received: from junjiech-mobl.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.254.213.63])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 03:34:08 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, peter.ganzhorn@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] hwmon: (coretemp) Delete tjmax debug message
Date:   Thu, 30 Mar 2023 18:33:45 +0800
Message-Id: <20230330103346.6044-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit c0c67f8761ce ("hwmon: (coretemp) Add support for dynamic
tjmax"), tjmax value is retrieved from MSR every time the temperature is
read.
This means that, with debug message enabled, the tjmax debug message is
printed out for every single temperature read for any CPU. This spams
the syslog.

Ideally, as tjmax is package scope unique, the debug message should show
once when tjmax is changed for one package. But this requires inventing
some new per-package data in the coretemp driver, and this is overkill.

To keep the code simple, delete the tjmax debug message.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/hwmon/coretemp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 30d77f451937..fe3d4d0dcbed 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -286,10 +286,8 @@ static int get_tjmax(struct temp_data *tdata, struct device *dev)
 		 * If the TjMax is not plausible, an assumption
 		 * will be used
 		 */
-		if (val) {
-			dev_dbg(dev, "TjMax is %d degrees C\n", val);
+		if (val)
 			return val * 1000;
-		}
 	}
 
 	if (force_tjmax) {
-- 
2.25.1

