Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02F06ACC99
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjCFSao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjCFSak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:30:40 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104A530195;
        Mon,  6 Mar 2023 10:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678127439; x=1709663439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SzDNxv/R8pxYIbdy4sFf5lgkB072RjOTFq/X3ZPzELA=;
  b=VZvs11m4tIt75iNGgZMH4odbY0PE5+tGbTYy7aJUR95xEVD0OZF5MHw5
   BRdkea3aN/8BHpoNn+eEe7BmJsQHAo/DFXya4z1duT0PTijMBCOu8g3qa
   ko07r39mBWJL6CGdFhJ94zFLCbkN+U5Zi5Z8WOBqLGMbPpNkSLWuAfIsr
   OMcCWSYbvAsK4pbbeqFDECZVR7GjXNOmhB3I01IyEwZoCjBwAwDe729xb
   rA33ltoAqAc0+G5kksr1okcVLvV7BZEN9Yl1QexmONBpLC0BZB4LB1G2i
   rv6IrVIvWqamRs21lSnfPHDmVQsxLxVo5+XkO7NzX+S1EC8y+B8Z5xquw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="363257686"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="363257686"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:30:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="786348696"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="786348696"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 06 Mar 2023 10:30:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 54D0387; Mon,  6 Mar 2023 20:31:19 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/5] spi: mpc5xxx-psc: Correct error check for devm_platform_get_and_ioremap_resource()
Date:   Mon,  6 Mar 2023 20:31:11 +0200
Message-Id: <20230306183115.87314-2-andriy.shevchenko@linux.intel.com>
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

devm_platform_get_and_ioremap_resource() may return pointer or error
pointer, never the NULL. Correct error check for it.

Fixes: 60a6c8257f41 ("spi: mpc5xxx-psc: Use platform resources instead of parsing DT properties")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-mpc512x-psc.c | 4 ++--
 drivers/spi/spi-mpc52xx-psc.c | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 5bdfe4a740e9..a2ea24a63cb4 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -483,8 +483,8 @@ static int mpc512x_psc_spi_of_probe(struct platform_device *pdev)
 	master->dev.of_node = dev->of_node;
 
 	tempp = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
-	if (!tempp)
-		return dev_err_probe(dev, -EFAULT, "could not ioremap I/O port range\n");
+	if (IS_ERR(tempp))
+		return dev_err_probe(dev, PTR_ERR(tempp), "could not ioremap I/O port range\n");
 	mps->psc = tempp;
 	mps->fifo =
 		(struct mpc512x_psc_fifo *)(tempp + sizeof(struct mpc52xx_psc));
diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index 95a4a511c388..1bf728f4d766 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -321,8 +321,9 @@ static int mpc52xx_psc_spi_of_probe(struct platform_device *pdev)
 	master->dev.of_node = dev->of_node;
 
 	mps->psc = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
-	if (!mps->psc)
-		return dev_err_probe(dev, -EFAULT, "could not ioremap I/O port range\n");
+	if (IS_ERR(mps->psc))
+		return dev_err_probe(dev, PTR_ERR(mps->psc), "could not ioremap I/O port range\n");
+
 	/* On the 5200, fifo regs are immediately ajacent to the psc regs */
 	mps->fifo = ((void __iomem *)mps->psc) + sizeof(struct mpc52xx_psc);
 
-- 
2.39.1

