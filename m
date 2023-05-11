Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262AC6FF37D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238150AbjEKN6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238041AbjEKN6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:58:48 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4201BF4;
        Thu, 11 May 2023 06:58:47 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so79612044a12.1;
        Thu, 11 May 2023 06:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683813526; x=1686405526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=plAKUv42Sn46En3seCmYitfaF7G/SLKfsBL9Nzw7uRw=;
        b=Y7AqvUuLXbmjeEGage7I+9M2J2MQst3psCrciGGTiGFZOpwCvvh+wGd5x7eNIQugRU
         2c4Hka8ERtwqxm0zK8AJqlzKhrV3Xwlji8aNv1zyXjDMoZN+lBz9V/UdyYFNnLMOBQS4
         y+d2TouKBAFExIjLazpq4aAeFoHMnLZMJp+GlmEMXn0ZbYTRlkukAs2WFL6az4Bt/iDE
         qVwVKXuXl66OwQY1tWPQkblznUHMFJOjcSjllblG683WoomCpQyt2wRdNK31G3/6IeBc
         CBZCLMaalvZrU/3h1DNZGslHt+2C4T2wK3iEDSPZTIOAQYKW3UlHdbV1cj6YdNOfYXS1
         No3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683813526; x=1686405526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plAKUv42Sn46En3seCmYitfaF7G/SLKfsBL9Nzw7uRw=;
        b=T8AW13f1NH4pYETHe2i+Om+84db42zbAxm3R/xx/nI1QoMYLlPh/eUPC4fceceHJJm
         h7Bn0jPmR9a2wJALnLNL4HsB2Z09ILl76g+Xt8rRqyxPrbEL5VApBIXIfFBIVgBfv2gr
         aXIZBVHcGHInuaUSHuEMe0ZlYa/Nxv0xOJ9sYjiv6eSa1gZir8UOTVX/jA9g7jOzhQkf
         +ck8HKU3JjXt0Yg5/5ydkkXEoc6KIEX1LlZQtrfIqN+WZVcbqMSrYG6CVPXX3Smxs2sg
         Aiao4bXnwxqgcCqGHac64z6EBtNFx7RothkroYUBYNutqGW1fJm3iVFHCKDJNdOOBYUt
         fx7Q==
X-Gm-Message-State: AC+VfDytK0aUSuNtU5wtCuRQ/SITvVy06s9X0B3PyUNwT4EDVcXLzM/F
        dDhw/hv26n/nVbIcnMB+ZQ8=
X-Google-Smtp-Source: ACHHUZ6W/hrepCZO8dtSF4PWtMXMh5m0iaLmX86DlYJ3hPfenOSBlDCLLqnXhALJMjKCox8mjf1rZQ==
X-Received: by 2002:a17:907:d0e:b0:94a:57d1:5539 with SMTP id gn14-20020a1709070d0e00b0094a57d15539mr19781061ejc.5.1683813525596;
        Thu, 11 May 2023 06:58:45 -0700 (PDT)
Received: from wslxew193.ultratronik.de (mail.ultratronik.de. [82.100.224.114])
        by smtp.gmail.com with ESMTPSA id de39-20020a1709069be700b00969e9fef151sm3627994ejc.97.2023.05.11.06.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 06:58:45 -0700 (PDT)
From:   Boerge Struempfel <boerge.struempfel@gmail.com>
X-Google-Original-From: Boerge Struempfel <bstruempfel@ultratronik.de>
Cc:     boerge.struempfel@gmail.com, bstruempfel@ultratronik.de,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: Add option to keep the MOSI line low, when it is idle.
Date:   Thu, 11 May 2023 15:56:32 +0200
Message-Id: <20230511135632.78344-1-bstruempfel@ultratronik.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, the imx spi controller uses a high mosi line, whenever it is
idle. This may not be desired in all use cases. For example neopixel
leds can get confused and flicker due to misinterpreting the idle state.
Therefore, we introduce a new spi-mode bit, with which the idle behaviour
can be overwritten on a per device basis.

Signed-off-by: Boerge Struempfel <bstruempfel@ultratronik.de>
---
 drivers/spi/spi-imx.c        | 9 ++++++++-
 drivers/spi/spi.c            | 2 ++
 include/uapi/linux/spi/spi.h | 3 ++-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 34e5f81ec431e..6acab2b4ffaa5 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -281,6 +281,7 @@ static bool spi_imx_can_dma(struct spi_controller *controller, struct spi_device
 #define MX51_ECSPI_CONFIG_SCLKPOL(cs)	(1 << ((cs & 3) +  4))
 #define MX51_ECSPI_CONFIG_SBBCTRL(cs)	(1 << ((cs & 3) +  8))
 #define MX51_ECSPI_CONFIG_SSBPOL(cs)	(1 << ((cs & 3) + 12))
+#define MX51_ECSPI_CONFIG_DATACTL(cs)	(1 << ((cs & 3) + 16))
 #define MX51_ECSPI_CONFIG_SCLKCTL(cs)	(1 << ((cs & 3) + 20))
 
 #define MX51_ECSPI_INT		0x10
@@ -573,6 +574,11 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 		cfg &= ~MX51_ECSPI_CONFIG_SCLKCTL(spi_get_chipselect(spi, 0));
 	}
 
+	if (spi->mode & SPI_MOSI_IDLE_LOW)
+		cfg |= MX51_ECSPI_CONFIG_DATACTL(spi->chip_select);
+	else
+		cfg &= ~MX51_ECSPI_CONFIG_DATACTL(spi->chip_select);
+
 	if (spi->mode & SPI_CS_HIGH)
 		cfg |= MX51_ECSPI_CONFIG_SSBPOL(spi_get_chipselect(spi, 0));
 	else
@@ -1743,7 +1749,8 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->controller->prepare_message = spi_imx_prepare_message;
 	spi_imx->controller->unprepare_message = spi_imx_unprepare_message;
 	spi_imx->controller->slave_abort = spi_imx_slave_abort;
-	spi_imx->controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_NO_CS;
+	spi_imx->controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_NO_CS |
+					 SPI_MOSI_IDLE_LOW;
 
 	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx) ||
 	    is_imx53_ecspi(spi_imx))
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9291b2a0e8871..3ad538b317a84 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2260,6 +2260,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		spi->mode |= SPI_LSB_FIRST;
 	if (of_property_read_bool(nc, "spi-cs-high"))
 		spi->mode |= SPI_CS_HIGH;
+	if (of_property_read_bool(nc, "spi-mosi-idle-low"))
+		spi->mode |= SPI_MOSI_IDLE_LOW;
 
 	/* Device DUAL/QUAD mode */
 	if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
diff --git a/include/uapi/linux/spi/spi.h b/include/uapi/linux/spi/spi.h
index 9d5f580597039..ca56e477d1619 100644
--- a/include/uapi/linux/spi/spi.h
+++ b/include/uapi/linux/spi/spi.h
@@ -28,6 +28,7 @@
 #define	SPI_RX_OCTAL		_BITUL(14)	/* receive with 8 wires */
 #define	SPI_3WIRE_HIZ		_BITUL(15)	/* high impedance turnaround */
 #define	SPI_RX_CPHA_FLIP	_BITUL(16)	/* flip CPHA on Rx only xfer */
+#define SPI_MOSI_IDLE_LOW	_BITUL(17)	/* leave mosi line low when idle */
 
 /*
  * All the bits defined above should be covered by SPI_MODE_USER_MASK.
@@ -37,6 +38,6 @@
  * These bits must not overlap. A static assert check should make sure of that.
  * If adding extra bits, make sure to increase the bit index below as well.
  */
-#define SPI_MODE_USER_MASK	(_BITUL(17) - 1)
+#define SPI_MODE_USER_MASK	(_BITUL(18) - 1)
 
 #endif /* _UAPI_SPI_H */
-- 
2.25.1

