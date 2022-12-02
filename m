Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827FB6403BB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbiLBJtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbiLBJtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:49:39 -0500
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228C6C934F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 01:49:37 -0800 (PST)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id C60E05FF10;
        Fri,  2 Dec 2022 10:49:35 +0100 (CET)
From:   Edmund Berenson <edmund.berenson@emlix.com>
Cc:     Edmund Berenson <edmund.berenson@emlix.com>,
        Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] spi: dw: Write chip configuration before cs is set
Date:   Fri,  2 Dec 2022 10:49:34 +0100
Message-Id: <20221202094934.9420-1-edmund.berenson@emlix.com>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using chips with different cpol, causes first communication
to fail on cpol change.
To avoid this issue write cr0 register before cs is set.

Suggested-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
---
 drivers/spi/spi-dw-core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 57c9e384d6d4..c3da4fe3e510 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -93,6 +93,7 @@ static inline void dw_spi_debugfs_remove(struct dw_spi *dws)
 void dw_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
+	struct dw_spi_chip_data *chip = spi_get_ctldata(spi);
 	bool cs_high = !!(spi->mode & SPI_CS_HIGH);
 	u8 enable_cs = 0;
 
@@ -106,8 +107,13 @@ void dw_spi_set_cs(struct spi_device *spi, bool enable)
 	 * Enable register no matter whether the SPI core is configured to
 	 * support active-high or active-low CS level.
 	 */
-	if (cs_high == enable)
+	if (cs_high == enable) {
+		dw_spi_enable_chip(dws, 0);
+		dw_writel(dws, DW_SPI_CTRLR0, chip->cr0);
+		dw_spi_enable_chip(dws, 1);
+
 		dw_writel(dws, DW_SPI_SER, BIT(enable_cs));
+	}
 	else
 		dw_writel(dws, DW_SPI_SER, 0);
 }
-- 
2.37.4

