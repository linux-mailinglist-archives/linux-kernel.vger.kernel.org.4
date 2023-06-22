Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C23F73996A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjFVIZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjFVIZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:25:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CCA1BD0;
        Thu, 22 Jun 2023 01:25:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA9A661783;
        Thu, 22 Jun 2023 08:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA8BC433C9;
        Thu, 22 Jun 2023 08:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687422323;
        bh=kT1iIRFCb/FngiibBFp/oj+CcwR6QPaSbU5bJ8Db0PI=;
        h=From:To:Cc:Subject:Date:From;
        b=MAbC5CrnuU+abGtqx92u/WmSNcxhtdTj+Ss7+80MMiTRQOQaRj3H5ELz7Thn0kxGZ
         07bi/WjYBczBDXSk0pVrH8olmqVSWc8SJVNzc71C8axWUek65iVkMNpZNndKVFaj/M
         4xyydAcNokrUc+j0wMLXZ0qVTQe+lO0Ktm7y/gTr52xwCWuT+9NP37LYA35kekHa33
         n/ko1TdlNEUCCuWpWb5qJbFaRD1WJPiNbsgqhGmEfIBdf+qw6BF37tqXpShR90KwzM
         DMeIZF48Yfm5BCfAHegfLSjUrap/Uw/UpYru+8YsXLfpcEX3cHTckYb6AEjqZzgOAm
         oKyqc03Q7QSpg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qCFdA-00023c-Gw; Thu, 22 Jun 2023 10:25:28 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH] spi: zynqmp-gqspi: fix clock imbalance on probe failure
Date:   Thu, 22 Jun 2023 10:24:35 +0200
Message-Id: <20230622082435.7873-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that the device is not runtime suspended before explicitly
disabling the clocks on probe failure and on driver unbind to avoid a
clock enable-count imbalance.

Fixes: 9e3a000362ae ("spi: zynqmp: Add pm runtime support")
Cc: stable@vger.kernel.org	# 4.19
Cc: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/spi/spi-zynqmp-gqspi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index fb2ca9b90eab..c309dedfd602 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1342,9 +1342,9 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	return 0;
 
 clk_dis_all:
-	pm_runtime_put_sync(&pdev->dev);
-	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
 clk_dis_pclk:
 	clk_disable_unprepare(xqspi->pclk);
@@ -1368,11 +1368,15 @@ static void zynqmp_qspi_remove(struct platform_device *pdev)
 {
 	struct zynqmp_qspi *xqspi = platform_get_drvdata(pdev);
 
+	pm_runtime_get_sync(&pdev->dev);
+
 	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
+
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
 	clk_disable_unprepare(xqspi->pclk);
-	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
 }
 
 MODULE_DEVICE_TABLE(of, zynqmp_qspi_of_match);
-- 
2.39.3

