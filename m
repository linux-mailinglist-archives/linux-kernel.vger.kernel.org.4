Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51E86403B7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbiLBJt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiLBJtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:49:24 -0500
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E05C868A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 01:49:22 -0800 (PST)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id C25FD5FCDC;
        Fri,  2 Dec 2022 10:49:20 +0100 (CET)
From:   Edmund Berenson <edmund.berenson@emlix.com>
Cc:     Edmund Berenson <edmund.berenson@emlix.com>,
        Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] spi: dw: select SS0 when gpio cs is used
Date:   Fri,  2 Dec 2022 10:48:59 +0100
Message-Id: <20221202094859.7869-1-edmund.berenson@emlix.com>
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

SER register contains only 4-bit bit-field for enabling 4 SPI chip selects.
If gpio cs are used the cs number may be >= 4. To ensure we do not write
outside of the valid area, we choose SS0 in case of gpio cs to start
spi transfer.

Co-developed-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
Signed-off-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
---
 drivers/spi/spi-dw-core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 99edddf9958b..57c9e384d6d4 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -94,6 +94,10 @@ void dw_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
 	bool cs_high = !!(spi->mode & SPI_CS_HIGH);
+	u8 enable_cs = 0;
+
+	if (!spi->cs_gpiod)
+		enable_cs = spi->chip_select;
 
 	/*
 	 * DW SPI controller demands any native CS being set in order to
@@ -103,7 +107,7 @@ void dw_spi_set_cs(struct spi_device *spi, bool enable)
 	 * support active-high or active-low CS level.
 	 */
 	if (cs_high == enable)
-		dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
+		dw_writel(dws, DW_SPI_SER, BIT(enable_cs));
 	else
 		dw_writel(dws, DW_SPI_SER, 0);
 }
-- 
2.37.4

