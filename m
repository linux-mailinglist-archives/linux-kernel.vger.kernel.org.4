Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F099669402
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241238AbjAMKYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241125AbjAMKXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:23:34 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C095F5E;
        Fri, 13 Jan 2023 02:23:34 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 8E63B4206F;
        Fri, 13 Jan 2023 10:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1673605412; bh=c4zDn0WsX9vKD9/T+0pbZ4hUgI1frFckuoNzd/1iP5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=n7zJ2YyRvs+dpSlx1IN05ugU0M7nsDpfdKXXY6aPy8xi9FPg0iViM+Z/TxZxhqJBW
         liFzKSpAht3GuYcmh2FcrvaP5c7uOUvxw46GTnWjxSWDShILeTEQEy9s6mvLx0mfgX
         vQINtu0OhMja720uWNW3wfnXIbl0H4JIgGs9TNF6Yo31Cb6HipQQlLNMpC5XEBfml3
         JTDypjBgDOgLWhUqzSI/ETk920CpYmOdthRQajOz4HN6Ux5eynaOmIOc8Fp7EG1+Gz
         NBYQ2BKLsIWwsFVQkZfHmDK9H9Rd6BmduEWi1ot1zE08fcGXMlaLXD5wHGiMEWZzdZ
         +mTEBCUyOcnlg==
From:   Hector Martin <marcan@marcan.st>
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Janne Grunau <j@jannau.net>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH v2 1/3] spi: Use a 32-bit DT property for spi-cs-setup-delay-ns
Date:   Fri, 13 Jan 2023 19:23:08 +0900
Message-Id: <20230113102309.18308-2-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230113102309.18308-1-marcan@marcan.st>
References: <20230113102309.18308-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Janne Grunau <j@jannau.net>

65us is not a reasonable maximum for this property, as some devices
might need a much longer setup time (e.g. those driven by firmware on
the other end). Plus, device tree property values are in 32-bit cells
and smaller widths should not be used without good reason.

Also move the logic to a helper function, since this will later be used
to parse other CS delay properties too.

Fixes: 33a2fde5f77b ("spi: Introduce spi-cs-setup-ns property")
Signed-off-by: Janne Grunau <j@jannau.net>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/spi/spi.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 15f174f4e056..3f33934f5429 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2220,11 +2220,26 @@ void spi_flush_queue(struct spi_controller *ctlr)
 /*-------------------------------------------------------------------------*/
 
 #if defined(CONFIG_OF)
+static void of_spi_parse_dt_cs_delay(struct device_node *nc,
+				     struct spi_delay *delay, const char *prop)
+{
+	u32 value;
+
+	if (!of_property_read_u32(nc, prop, &value)) {
+		if (value > U16_MAX) {
+			delay->value = DIV_ROUND_UP(value, 1000);
+			delay->unit = SPI_DELAY_UNIT_USECS;
+		} else {
+			delay->value = value;
+			delay->unit = SPI_DELAY_UNIT_NSECS;
+		}
+	}
+}
+
 static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 			   struct device_node *nc)
 {
 	u32 value;
-	u16 cs_setup;
 	int rc;
 
 	/* Mode (clock phase/polarity/etc.) */
@@ -2310,10 +2325,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
 		spi->max_speed_hz = value;
 
-	if (!of_property_read_u16(nc, "spi-cs-setup-delay-ns", &cs_setup)) {
-		spi->cs_setup.value = cs_setup;
-		spi->cs_setup.unit = SPI_DELAY_UNIT_NSECS;
-	}
+	/* Device CS delays */
+	of_spi_parse_dt_cs_delay(nc, &spi->cs_setup, "spi-cs-setup-delay-ns");
 
 	return 0;
 }
-- 
2.35.1

