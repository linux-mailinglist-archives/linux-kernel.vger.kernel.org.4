Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F306ACC8E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCFS3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjCFS3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:29:05 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B8FCA29;
        Mon,  6 Mar 2023 10:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678127333; x=1709663333;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1ax5g14lSVc66zIwDmHHBnU+JvCUysUQMQFqDH3oZeo=;
  b=HQ3uunTVrAB3m2l3UB+opL+OLTylFu0VZKj3DFOSVgDepxZP507A9xIt
   xyraI7XLAM5TYjyevzxo86XyxvIxs1bfbbBUbP3NZToT6iAzykR+Z5QHa
   12FxoSbRlypwg2CQqHN/Qb1wkJQrXHU8wRv+1wFTz1w06+rvGHZQdp+V2
   DLhXzAvNjoGuM410S3v9NzkDWdiPrsoDQkTv+ZiDWt9UcBhmJQL1fsaKX
   ufNH8S9oCXOHVTBkR1PrX27r86AYhwTJ1Ggc3fVgndP/fznK79DDCBq5j
   9c2R66cBiYypyss8XNamWIIqcKOZpIzhMVcBY1TfFVF/5vBiJbCm12P5/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="335658517"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="335658517"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:28:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="678585698"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="678585698"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 06 Mar 2023 10:28:31 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E5AC7143; Mon,  6 Mar 2023 20:29:14 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: Propagate firmware node
Date:   Mon,  6 Mar 2023 20:29:13 +0200
Message-Id: <20230306182913.87231-1-andriy.shevchenko@linux.intel.com>
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

Propagate firmware node by using a specific API call, i.e. device_set_node().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 798030c0c5ce..295d02e7f0a8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2368,8 +2368,8 @@ of_register_spi_device(struct spi_controller *ctlr, struct device_node *nc)
 
 	/* Store a pointer to the node in the device structure */
 	of_node_get(nc);
-	spi->dev.of_node = nc;
-	spi->dev.fwnode = of_fwnode_handle(nc);
+
+	device_set_node(&spi->dev, of_fwnode_handle(nc));
 
 	/* Register the new device */
 	rc = spi_add_device(spi);
-- 
2.39.1

