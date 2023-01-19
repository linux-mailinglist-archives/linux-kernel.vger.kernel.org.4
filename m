Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21948674B7F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjATE6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjATE6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:58:14 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130581A0;
        Thu, 19 Jan 2023 20:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674190054; x=1705726054;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ozaxhpxM4A0zByBv1AHnqvQW/wrI3mGABs3fTgTiWIY=;
  b=kqKj/NOof0w9IRfBmZw79h5ATJ0QFcOM9Uv88uS+dHWIKj2/wvFMZP35
   OPeCoOS6mt8afgWqrmDGKgW+tUYQsYeJLUmK222Yw+W7mLnjCj/8kSv5t
   Xhq+11jJnr5w5BiGAoEsSQYT9FASr8c1FVfnv/zeji1Nm3xxG9IoEakgc
   TXE6Lv12mBkvSOU05ynBe8ov7W1ZVWsU1EetRKto8m6abFEkIBReslwnU
   VitFq5qrWW8Vz3LHUDIwhHbedtof+x9OeKBEi3OhdU5rNz9hpHBS0FyDc
   tArG7H+sxiCdI62QCC+01zlCWzgmLK79OiSZtt4BbK1ukyXv5q1kZeXD9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="308938731"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="308938731"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 09:47:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="749008977"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="749008977"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jan 2023 09:47:16 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B892F36D; Thu, 19 Jan 2023 19:47:51 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: adc: xilinx-ams: Convert to use fwnode_device_is_compatible()
Date:   Thu, 19 Jan 2023 19:47:49 +0200
Message-Id: <20230119174749.76769-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded fwnode_device_is_compatible() in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/xilinx-ams.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index a507d2e17079..34cf336b3490 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -1220,8 +1220,7 @@ static int ams_init_module(struct iio_dev *indio_dev,
 	int num_channels = 0;
 	int ret;
 
-	if (fwnode_property_match_string(fwnode, "compatible",
-					 "xlnx,zynqmp-ams-ps") == 0) {
+	if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams-ps")) {
 		ams->ps_base = fwnode_iomap(fwnode, 0);
 		if (!ams->ps_base)
 			return -ENXIO;
@@ -1232,8 +1231,7 @@ static int ams_init_module(struct iio_dev *indio_dev,
 		/* add PS channels to iio device channels */
 		memcpy(channels, ams_ps_channels, sizeof(ams_ps_channels));
 		num_channels = ARRAY_SIZE(ams_ps_channels);
-	} else if (fwnode_property_match_string(fwnode, "compatible",
-						"xlnx,zynqmp-ams-pl") == 0) {
+	} else if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams-pl")) {
 		ams->pl_base = fwnode_iomap(fwnode, 0);
 		if (!ams->pl_base)
 			return -ENXIO;
@@ -1247,8 +1245,7 @@ static int ams_init_module(struct iio_dev *indio_dev,
 		num_channels += AMS_PL_MAX_FIXED_CHANNEL;
 		num_channels = ams_get_ext_chan(fwnode, channels,
 						num_channels);
-	} else if (fwnode_property_match_string(fwnode, "compatible",
-						"xlnx,zynqmp-ams") == 0) {
+	} else if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams")) {
 		/* add AMS channels to iio device channels */
 		memcpy(channels, ams_ctrl_channels, sizeof(ams_ctrl_channels));
 		num_channels += ARRAY_SIZE(ams_ctrl_channels);
-- 
2.39.0

