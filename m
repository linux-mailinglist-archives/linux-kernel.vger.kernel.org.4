Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1646912F7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 23:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjBIWJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 17:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBIWJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 17:09:37 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9011066EC7;
        Thu,  9 Feb 2023 14:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675980573; x=1707516573;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NWdX4ovfeso9/xymokaYM6nKkkxJTUMaRhX9Ah2IpwQ=;
  b=MqU44/XFDZRVmrHQUdE3pQ/WatTFqMwfweDKuSvxoH7XIO5CPNfoCjOx
   Iwhxh14R1P0yOgEbr6MYRXt4N1P9cT72ifDkJJpPnqU3K+GfT/LIm4NCa
   NB8BwMbdnmT0fdIoE6Bzf+1EgHtfbxe9FOGLPNJsmxw6W2FnJ944Ty1Ye
   5yR3Sd2kjcn2SlLbqwMZiQyREmR8dCdp94mCN4egsOxE1n6z007zYOyQY
   KEch9GelwaWVYiEiF7Y6CEt1drYGkIE/b3pPfCSbaPHKd8YwOjXMQNqQC
   Ec4/bhlJBRF8yLgju6I41pSi4CgA/qE4mXNhVHy5k48/lzKofAVVUFznF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="328893458"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="328893458"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 14:09:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="736509528"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="736509528"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 09 Feb 2023 14:09:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9978F1A6; Fri, 10 Feb 2023 00:09:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] media: i2c: imx290: Use device_property_read_u32() directly
Date:   Fri, 10 Feb 2023 00:09:54 +0200
Message-Id: <20230209220954.46306-1-andriy.shevchenko@linux.intel.com>
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
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v2: added tag (Laurent), wrapped the long line (Laurent)
 drivers/media/i2c/imx290.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
index 49d6c8bdec41..dc228af6fac9 100644
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -1132,8 +1132,8 @@ static int imx290_init_clk(struct imx290 *imx290)
 	u32 xclk_freq;
 	int ret;
 
-	ret = fwnode_property_read_u32(dev_fwnode(imx290->dev),
-				       "clock-frequency", &xclk_freq);
+	ret = device_property_read_u32(imx290->dev, "clock-frequency",
+				       &xclk_freq);
 	if (ret) {
 		dev_err(imx290->dev, "Could not get xclk frequency\n");
 		return ret;
-- 
2.39.1

