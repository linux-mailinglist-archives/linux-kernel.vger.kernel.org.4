Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F7E6ACC9D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjCFSa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCFSal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:30:41 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E7E32CE1;
        Mon,  6 Mar 2023 10:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678127441; x=1709663441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fquPdIobgt4dFtH9WXP11i+KlpBlpDxDrJNJpLKK+xU=;
  b=JISjJtUhW7ju62DxeEmyVaFPDrBvtAynfTV+CIfHlbSWxAuBVnzgulG0
   7Yu3EmSAP1QaA4R200ZtqAh1uQrd3kafDg2FbKZWvOyzMkhU/0pbDdsZZ
   /lNPcg1wGg1Ez6JgbSYS35Wos8muKkJDOy1e86yC6wYGAeH7+8aV6uUWF
   xwsY+K/IWo0m7Ad35q98BrRgjVHxouy3D3c0fAGSBWmJRpv5enJ9u2nbW
   5ktryAGsXS9xZzK6I/iAYRfvUJ3U40GQMfLL0fMSCdMWA2T1ZKnrQygUO
   4lMMYnfvqiWe0CeSioOA9y1qGDoCdfgkCWSucj+fLQeRdyei2gVRcTxiS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="363257720"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="363257720"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:30:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="786348766"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="786348766"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 06 Mar 2023 10:30:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8B6FF398; Mon,  6 Mar 2023 20:31:19 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 5/5] spi: mpc5xxx-psc: Consistently use device property APIs
Date:   Mon,  6 Mar 2023 20:31:15 +0200
Message-Id: <20230306183115.87314-6-andriy.shevchenko@linux.intel.com>
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

Instead of calling the OF APIs mixed with device property APIs,
just switch to use the latter everywhere.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-mpc52xx-psc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index 335a6b9eb141..9a1a080fb688 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -309,7 +309,7 @@ static int mpc52xx_psc_spi_of_probe(struct platform_device *pdev)
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
 
-	ret = of_property_read_u32(dev->of_node, "cell-index", &bus_num);
+	ret = device_property_read_u32(dev, "cell-index", &bus_num);
 	if (ret || bus_num > 5)
 		return dev_err_probe(dev, ret ? : -EINVAL, "Invalid cell-index property\n");
 	master->bus_num = bus_num + 1;
-- 
2.39.1

