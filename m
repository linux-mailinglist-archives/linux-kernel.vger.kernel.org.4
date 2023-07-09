Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A9374C513
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjGIPOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjGIPNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:13:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A07F1709;
        Sun,  9 Jul 2023 08:13:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3DD060C1A;
        Sun,  9 Jul 2023 15:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56163C433CD;
        Sun,  9 Jul 2023 15:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688915600;
        bh=y6bziz/MvdQ+aDDDtJgCjPL8YGD7r7BVYP/dHYkzrrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D1ZGavs5GB8A60bFSMtqW1Ie1E1mhZ5H7Q1gBLxknh+F3VjVgbqanzRsGM2K132ZJ
         EpbZMCSPFsniYYPVqD0lOkJIgy/x4O155H59GCgQowNC/wo5jYZu+IK0nB5lPaB2R1
         Bm3FxrYJ1wFhz7kBtXUkX05VGLCtLXQP85eHyaHFtYjkDzBRzs7KvqFRrTFNt4O40R
         LXxS2lM5VncTBUEvbZNPAR9Mfe2Dh4S1E7GJO5laHmZn1hKUZpGWyVyQnULs7C8jHJ
         WrmkjlnLR6F+jTYLHwH347pYzRHe5YGOCwEZCQezeY3pWI9u9MXsl/GNhO1rK9/0nD
         9ERcTq3GD26qQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Abe Kohandel <abe.kohandel@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, fancer.lancer@gmail.com,
        linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 14/26] spi: dw: Add compatible for Intel Mount Evans SoC
Date:   Sun,  9 Jul 2023 11:12:43 -0400
Message-Id: <20230709151255.512931-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151255.512931-1-sashal@kernel.org>
References: <20230709151255.512931-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abe Kohandel <abe.kohandel@intel.com>

[ Upstream commit 0760d5d0e9f0c0e2200a0323a61d1995bb745dee ]

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
Link: https://lore.kernel.org/r/20230606145402.474866-2-abe.kohandel@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-dw-mmio.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 15f5e9cb54ad4..5a38cb09a650d 100644
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
2.39.2

