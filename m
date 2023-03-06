Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6F76ACC9C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjCFSay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjCFSal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:30:41 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F087BBA7;
        Mon,  6 Mar 2023 10:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678127440; x=1709663440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4ozgUwrnazel/IFh5JrjS3Sz/LmjOqA6oCX8ytuPDBQ=;
  b=cqCrG/vJBhLJ4ABLNn8WjTPsHEnMY35/CKdd7+ezFZHHLHM6cO4TVGEC
   qbSs7X07Can4UMzhMtwykDgdrNnf70RdSDlX+w4lyxkUTEGvh3xPN7jY7
   Dp74/hCHVzuSI5xiVSYRPY8HOXXl+eZZpLKkQ7FZONEiO4f/J7MCsIxUe
   wGSgfwt9ow4II2iSvKW3ne0WmkoYukf8GGAjTTqtxXFi+vFnBVu76ea1z
   Xi8I22RL7jL+SlIzGDE3vhxnoarRVtqtp3MyA7BftorhLx//OewMZri5b
   JXZT6HF6qfupg8+/LLs/BU9+ssGYVqIPI8cETVik8YjXm3D4ltwW5hSNt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="363257692"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="363257692"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:30:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="786348695"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="786348695"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 06 Mar 2023 10:30:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7C4F7154; Mon,  6 Mar 2023 20:31:19 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/5] spi: mpc5xxx-psc: Propagate firmware node
Date:   Mon,  6 Mar 2023 20:31:14 +0200
Message-Id: <20230306183115.87314-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230306183115.87314-1-andriy.shevchenko@linux.intel.com>
References: <20230306183115.87314-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Propagate firmware node by using a specific API call, i.e. device_set_node().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-mpc512x-psc.c | 4 +++-
 drivers/spi/spi-mpc52xx-psc.c | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 739df2b241e9..77a228f633d1 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -17,6 +17,7 @@
 #include <linux/completion.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/spi/spi.h>
@@ -478,7 +479,8 @@ static int mpc512x_psc_spi_of_probe(struct platform_device *pdev)
 	master->unprepare_transfer_hardware = mpc512x_psc_spi_unprep_xfer_hw;
 	master->use_gpio_descriptors = true;
 	master->cleanup = mpc512x_psc_spi_cleanup;
-	master->dev.of_node = dev->of_node;
+
+	device_set_node(&master->dev, dev_fwnode(dev));
 
 	tempp = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(tempp))
diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index b75bc2457883..335a6b9eb141 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -11,8 +11,8 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
-#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/workqueue.h>
 #include <linux/completion.h>
 #include <linux/io.h>
@@ -318,7 +318,8 @@ static int mpc52xx_psc_spi_of_probe(struct platform_device *pdev)
 	master->setup = mpc52xx_psc_spi_setup;
 	master->transfer_one_message = mpc52xx_psc_spi_transfer_one_message;
 	master->cleanup = mpc52xx_psc_spi_cleanup;
-	master->dev.of_node = dev->of_node;
+
+	device_set_node(&master->dev, dev_fwnode(dev));
 
 	mps->psc = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(mps->psc))
-- 
2.39.1

