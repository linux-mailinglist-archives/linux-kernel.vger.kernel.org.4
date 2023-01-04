Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955EF65CFC7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239182AbjADJiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbjADJhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:37:36 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CF5F015;
        Wed,  4 Jan 2023 01:37:34 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 51F6742137;
        Wed,  4 Jan 2023 09:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1672825053; bh=yxqAc1bBEfZDS+8bRfcAcj3SjysPRG0Y/YATmIkz/cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=pUVvWOp1RYpDwgh5qbEt7nGu6aC/XdWaW3yV1D8l0utAhMB6LWzMX35bp1Kv3xjP6
         oKjaOntsGEpiqjOpd8AhWgWTKNAH+mavHz0wdzLmfyYBODGdt1xkGw0Ru/rklw+HFp
         WfB7+WF7VfKmHpI9U05k3JV3a+ux0pWuzsM5+dW2jwvyBSY2pUGy8wSK0teca73RvS
         do3YMpMCo9gskQ1Q1396CKy3dNjcQ5sBB/QGX9ViFT1GjOaVWaUCkANJQC3p5pKeyu
         1N97/zUobhhRuLtX+GfehEyV8+/PXKfAUL/REdSX4QcAPGzgtAjEB6oQxn/TG/ZUol
         5+9IFWSbtMbcA==
From:   Hector Martin <marcan@marcan.st>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Janne Grunau <j@jannau.net>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH 3/5] spi: Use a 32-bit DT property for spi-cs-setup-delay-ns
Date:   Wed,  4 Jan 2023 18:36:29 +0900
Message-Id: <20230104093631.15611-4-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230104093631.15611-1-marcan@marcan.st>
References: <20230104093631.15611-1-marcan@marcan.st>
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
 drivers/spi/spi.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 15f174f4e056..370e4c85dc54 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2220,6 +2220,22 @@ void spi_flush_queue(struct spi_controller *ctlr)
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
@@ -2310,10 +2326,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
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

