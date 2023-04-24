Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154846ECA30
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjDXKV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjDXKUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:20:47 -0400
X-Greylist: delayed 1524 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Apr 2023 03:20:45 PDT
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d501])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5531BE6;
        Mon, 24 Apr 2023 03:20:45 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id 8F7625EEC6;
        Mon, 24 Apr 2023 12:35:50 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-mhvRtd8a;
        Mon, 24 Apr 2023 12:35:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328950;
        bh=NUogbMI2IRdm13o7ZrbdcTniNyKLaz7Q19OJcE6Bd8w=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=F1Ko+Nx5I9MOqBhET+JwDMTvP1ciKPZwMS/i3lJ3nuDBX45g0geeabrtXz6JsD+c7
         5hDcd3p1MIQKuO2ivddwBW4cJGYlhgOCmfQDyCKQ6IkzUPNBwu3cuT2Fog3+2guinx
         sO3yqhL0LAP/7ScFESnxDVHBdGTtL9wTgsl4QsBQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/43] spi: ep93xx: add DT support for Cirrus EP93xx
Date:   Mon, 24 Apr 2023 15:34:33 +0300
Message-Id: <20230424123522.18302-18-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- find register range from the device tree
- provide clock access via of
- use_dma as a DT node

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---

Notes:
    Arnd Bergmann:
    - wildcards ep93xx to something meaningful, i.e. ep9301
    - drop wrappers

 drivers/spi/spi-ep93xx.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index 5896a7b2fade..b37be7109161 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -22,6 +22,7 @@
 #include <linux/bitops.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/scatterlist.h>
@@ -644,6 +645,25 @@ static void ep93xx_spi_release_dma(struct ep93xx_spi *espi)
 		free_page((unsigned long)espi->zeropage);
 }
 
+#ifdef CONFIG_OF
+static struct ep93xx_spi_info dt_spi_info;
+
+static struct ep93xx_spi_info *ep93xx_spi_get_platdata(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+
+	if (np && of_property_read_bool(np, "use_dma"))
+		dt_spi_info.use_dma = 1;
+
+	return &dt_spi_info;
+}
+#else
+static struct ep93xx_spi_info *ep93xx_spi_get_platdata(struct platform_device *pdev)
+{
+	return dev_get_platdata(&pdev->dev);
+}
+#endif
+
 static int ep93xx_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
@@ -653,7 +673,7 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	int irq;
 	int error;
 
-	info = dev_get_platdata(&pdev->dev);
+	info = ep93xx_spi_get_platdata(pdev);
 	if (!info) {
 		dev_err(&pdev->dev, "missing platform data\n");
 		return -EINVAL;
@@ -726,6 +746,8 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	/* make sure that the hardware is disabled */
 	writel(0, espi->mmio + SSPCR1);
 
+	master->dev.of_node = pdev->dev.of_node;
+
 	error = devm_spi_register_master(&pdev->dev, master);
 	if (error) {
 		dev_err(&pdev->dev, "failed to register SPI master\n");
@@ -755,9 +777,16 @@ static int ep93xx_spi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ep93xx_spi_of_ids[] = {
+	{ .compatible = "cirrus,ep9301-spi" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ep93xx_spi_of_ids);
+
 static struct platform_driver ep93xx_spi_driver = {
 	.driver		= {
 		.name	= "ep93xx-spi",
+		.of_match_table = ep93xx_spi_of_ids,
 	},
 	.probe		= ep93xx_spi_probe,
 	.remove		= ep93xx_spi_remove,
-- 
2.39.2

