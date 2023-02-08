Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470C968EDFC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjBHLdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjBHLdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:33:15 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6782C3A5A5;
        Wed,  8 Feb 2023 03:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675855994; x=1707391994;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6QWobExJUgNiPIpPcBCb2eizDi1d8apfdQb0A0ZA4ao=;
  b=FYna69kPiAl6+MDl/aVA7clizfxl94MZZytdBZuNHKriPLGjXcYUmhEu
   Zb1HYMiMRGVpEnofwxE8IdQYPtbisfWER8TxwkQMtG9GoQhCBTlosZ6cq
   bP4vk+5UnJL/bQZph2O4doMDn+OLTjj8UXsxtj6Qy4PnZBpU0xhgq2UnD
   37NcsSXWR7orHNxkETR3g6ljIMl7hcrDfyVF4TLE3rJM0UQI+/aI+GdkN
   FAVdeVtFyMJrV8SCV14QoN1aU14boqhQJlKShq8iXyLulnIyXu+zF21SQ
   FshJSY+29Yw5aJjJx/9O1wo+bmASa5lNwPMzDiYgWx7gdt6pcrKt2fYdQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="394365329"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="394365329"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 03:33:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="735910066"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="735910066"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 08 Feb 2023 03:33:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A97FD1F8; Wed,  8 Feb 2023 13:33:49 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] media: i2c: imx290: Use device_property_read_u32() directly
Date:   Wed,  8 Feb 2023 13:33:48 +0200
Message-Id: <20230208113348.16880-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
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

No need to call fwnode_property_read_u32(dev_fwnode()), when
we have already existing helper. So use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/i2c/imx290.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
index 330098a0772d..e7aa2ecdcc88 100644
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -1137,8 +1137,7 @@ static int imx290_init_clk(struct imx290 *imx290)
 	u32 xclk_freq;
 	int ret;
 
-	ret = fwnode_property_read_u32(dev_fwnode(imx290->dev),
-				       "clock-frequency", &xclk_freq);
+	ret = device_property_read_u32(imx290->dev, "clock-frequency", &xclk_freq);
 	if (ret) {
 		dev_err(imx290->dev, "Could not get xclk frequency\n");
 		return ret;
-- 
2.39.1

