Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2964E7246F7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbjFFOzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238409AbjFFOyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:54:52 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214D710C3;
        Tue,  6 Jun 2023 07:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686063285; x=1717599285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c/5XpYGJgNkpc6+N1zdlNqMNznMRQMPDPzJeNG7kCwM=;
  b=csqj4sHSe9CsvSRpGFhVt0J6dXoBR3GXvOh2R7LQEh7qgYYL59Nyrd01
   JNr7p3PgMI5ZWy29W3e1Mm0TBPnusDFNDlT+bDO5r8KYNSHPWY9yFpL/v
   fotsZd2DtD/s2wA3prIry9ZTdTYTzv0R1lcODbuaLGjzesBdT5+N1ztmV
   nSrvLdAqsG03AYDYsNgAn80fPA0GwidBEmyUwsVNSDZm5tumBn+TQcBLi
   YOQqY4wxWI++e+XrbJElzBWpFdixrfJVTVGlADLnopg5uNcFlj+rfh1Zj
   qKmfYqoFgzGiPoQTn04VCFDcJToZ23tpoiO81PByKEzVy75YcPCuOHpPF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="337050753"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="337050753"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 07:54:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="853479979"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="853479979"
Received: from ekohande-desk2.vc.intel.com ([10.234.35.153])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 07:54:43 -0700
From:   Abe Kohandel <abe.kohandel@intel.com>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Abe Kohandel <abe.kohandel@intel.com>
Subject: [PATCH 1/2] spi: dw: Add compatible for Intel Mount Evans SoC
Date:   Tue,  6 Jun 2023 07:54:01 -0700
Message-Id: <20230606145402.474866-2-abe.kohandel@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606145402.474866-1-abe.kohandel@intel.com>
References: <20230606145402.474866-1-abe.kohandel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel Mount Evans SoC's Integrated Management Complex uses the SPI
controller for access to a NOR SPI FLASH. However, the SoC doesn't
provide a mechanism to override the native chip select signal.

This driver doesn't use DMA for memory operations when a chip select
override is not provided due to the native chip select timing behavior.
As a result no DMA configuration is done for the controller and this
configuration is not tested.

The controller also has an errata where a full TX FIFO can result in
data corruption. The suggested workaround is to never completely fill
the FIFO. The TX FIFO has a size of 32 so the fifo_len is set to 31.

Signed-off-by: Abe Kohandel <abe.kohandel@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dw-mmio.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 5f2aee69c1c1..c1d16157de61 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -236,6 +236,31 @@ static int dw_spi_intel_init(struct platform_device *pdev,
 	return 0;
 }
 
+/*
+ * The Intel Mount Evans SoC's Integrated Management Complex uses the
+ * SPI controller for access to a NOR SPI FLASH. However, the SoC doesn't
+ * provide a mechanism to override the native chip select signal.
+ *
+ * This driver doesn't use DMA for memory operations when a chip select
+ * override is not provided due to the native chip select timing behavior.
+ * As a result no DMA configuration is done for the controller and this
+ * configuration is not tested.
+ */
+static int dw_spi_mountevans_imc_init(struct platform_device *pdev,
+				      struct dw_spi_mmio *dwsmmio)
+{
+	/*
+	 * The Intel Mount Evans SoC's Integrated Management Complex DW
+	 * apb_ssi_v4.02a controller has an errata where a full TX FIFO can
+	 * result in data corruption. The suggested workaround is to never
+	 * completely fill the FIFO. The TX FIFO has a size of 32 so the
+	 * fifo_len is set to 31.
+	 */
+	dwsmmio->dws.fifo_len = 31;
+
+	return 0;
+}
+
 static int dw_spi_canaan_k210_init(struct platform_device *pdev,
 				   struct dw_spi_mmio *dwsmmio)
 {
@@ -405,6 +430,10 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_hssi_init},
 	{ .compatible = "intel,keembay-ssi", .data = dw_spi_intel_init},
 	{ .compatible = "intel,thunderbay-ssi", .data = dw_spi_intel_init},
+	{
+		.compatible = "intel,mountevans-imc-ssi",
+		.data = dw_spi_mountevans_imc_init,
+	},
 	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
 	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
 	{ .compatible = "amd,pensando-elba-spi", .data = dw_spi_elba_init},
-- 
2.40.1

