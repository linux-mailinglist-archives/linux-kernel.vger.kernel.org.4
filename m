Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402F86403BA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbiLBJti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiLBJta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:49:30 -0500
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5618BC9376
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 01:49:29 -0800 (PST)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 0E82C5FEEB;
        Fri,  2 Dec 2022 10:49:28 +0100 (CET)
From:   Edmund Berenson <edmund.berenson@emlix.com>
Cc:     Edmund Berenson <edmund.berenson@emlix.com>,
        Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] spi: execute set_cs function before gpio cs is activated
Date:   Fri,  2 Dec 2022 10:49:26 +0100
Message-Id: <20221202094926.9113-1-edmund.berenson@emlix.com>
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

In some cases it is necessary to adjust the spi controller configuration
before gpio cs is set.
For example if spi devices requiring different cpol are used from the same
controller the adjustment to cpol has to be made before gpio is activated.
To achieve this set_cs should be executed before gpio cs and necessary
adjustments can be made inside of controller driver.

Suggested-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
---
 drivers/spi/spi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5f9aedd1f0b6..bf2a67184969 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -976,6 +976,11 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 		enable = !enable;
 
 	if (spi->cs_gpiod) {
+		/* Some SPI masters need both GPIO CS & slave_select */
+		if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
+		    spi->controller->set_cs)
+			spi->controller->set_cs(spi, !enable);
+
 		if (!(spi->mode & SPI_NO_CS)) {
 			/*
 			 * Historically ACPI has no means of the GPIO polarity and
@@ -993,10 +998,6 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 				/* Polarity handled by GPIO library */
 				gpiod_set_value_cansleep(spi->cs_gpiod, activate);
 		}
-		/* Some SPI masters need both GPIO CS & slave_select */
-		if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
-		    spi->controller->set_cs)
-			spi->controller->set_cs(spi, !enable);
 	} else if (spi->controller->set_cs) {
 		spi->controller->set_cs(spi, !enable);
 	}
-- 
2.37.4

