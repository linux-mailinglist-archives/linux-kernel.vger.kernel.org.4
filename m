Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837DC71638A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjE3OR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjE3OR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:17:56 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8C3126;
        Tue, 30 May 2023 07:17:18 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96ff9c0a103so654731366b.0;
        Tue, 30 May 2023 07:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685456236; x=1688048236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9alx3JE4yyy/h8WRBpR+J1YPMr4Oma9xkFMx5Mn/Wk=;
        b=fBcfpVqE3wkBfIkERxFqgLX+9dQ6fyb02UnZEZSuejKpHIWdNihFYnH4lACZxkkB0Q
         vHZm0PkzV45uVJQ60JUcUUOKKSp3V7Xbhw6Ki7/kiOD3KAqpJmInUJOXWcBUMEzfe31M
         LeGph8Dt5TvQoxWzaWzzX2lU4lfHGNm0WS2hm1S9leyZZRkSAgu/hYe+BsPM0Yi0598K
         IYBPjvsqGP+S0SvkCgG03fNQYPCm4bh9ISa94uTeNoeiIjE7fwonitZ9i7ed3vVh/IQJ
         Rv20WXIoOCNCqFT+ULL0bviBFs6oyig6zgiR19CAG7ljjh36IkYyg/wHI1MFRRrbBg38
         RyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685456236; x=1688048236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9alx3JE4yyy/h8WRBpR+J1YPMr4Oma9xkFMx5Mn/Wk=;
        b=eNY0VYkQnG/jbqMyy495KABzJM+0Lc3WUNE/Ypn9uTS0EDDQyMmd6xu2x2/CZZOghc
         hKI+Le7vtLdipvCOAUX8HvQR+3IsWkEKPfA68gLVH9DzgH9jnbbyAg9NvR8PsR8pEIRq
         4W2voDjnoQdvlmZW5tp8ODLOEFEClwDPZrRRVoldFeah72KJ8brxTiH1vEN5vKI2rFPw
         V7TE5UshbUpGFMLOwygYsP2IRdmVYcsgC9X2XJXGDG6NzFJ1byU4B7JU3Ht0tKolWXf8
         zjh94dqYc2hRfyR7eGwwdApNWm3b7RUdWk0VwI99zWKOVSVTricLwwKskmQQAwql0iMv
         nyEA==
X-Gm-Message-State: AC+VfDzQd1oOP96mbXx/ncO8OkFpNrlS8lO5oi6qAZu1uxXelBvQ5lI8
        DxbeBoIxyzgfmeK/7JC2qMr9tvkUnux93A==
X-Google-Smtp-Source: ACHHUZ6V33VsolAjDkkTO9syiRNOUvyj/MrEEW6rXZ/kWk/booc71t70Wv2ry3FtyxSL//30fN+VeQ==
X-Received: by 2002:a17:906:dacd:b0:973:d863:f651 with SMTP id xi13-20020a170906dacd00b00973d863f651mr2369549ejb.44.1685456236017;
        Tue, 30 May 2023 07:17:16 -0700 (PDT)
Received: from wslxew193.ultratronik.de (p200300c78700c900796a998533c043af.dip0.t-ipconnect.de. [2003:c7:8700:c900:796a:9985:33c0:43af])
        by smtp.gmail.com with ESMTPSA id n20-20020a170906089400b0094e96e46cc0sm7354359eje.69.2023.05.30.07.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 07:17:15 -0700 (PDT)
From:   Boerge Struempfel <boerge.struempfel@gmail.com>
Cc:     boerge.struempfel@gmail.com, bstruempfel@ultratronik.de,
        andy.shevchenko@gmail.com, festevam@gmail.com,
        amit.kumar-mahapatra@amd.com, broonie@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/5] spi: spi-imx: add support for SPI_MOSI_IDLE_LOW mode bit
Date:   Tue, 30 May 2023 16:16:38 +0200
Message-Id: <20230530141641.1155691-3-boerge.struempfel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530141641.1155691-1-boerge.struempfel@gmail.com>
References: <20230530141641.1155691-1-boerge.struempfel@gmail.com>
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

By default, the spi-imx controller pulls the mosi line high, whenever it
is idle. This behaviour can be inverted per CS by setting the
corresponding DATA_CTL bit in the config register of the controller.

Also, since the controller mode-bits have to be touched anyways, the
SPI_CPOL and SPI_CPHA are replaced by the combined SPI_MODE_X_MASK flag.

Signed-off-by: Boerge Struempfel <boerge.struempfel@gmail.com>
---
 drivers/spi/spi-imx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index bd6ddb142b13..6f4d3cb81fdf 100644
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
+		cfg |= MX51_ECSPI_CONFIG_DATACTL(spi_get_chipselect(spi, 0));
+	else
+		cfg &= ~MX51_ECSPI_CONFIG_DATACTL(spi_get_chipselect(spi, 0));
+
 	if (spi->mode & SPI_CS_HIGH)
 		cfg |= MX51_ECSPI_CONFIG_SSBPOL(spi_get_chipselect(spi, 0));
 	else
@@ -1743,7 +1749,8 @@ static int spi_imx_probe(struct platform_device *pdev)
 	controller->prepare_message = spi_imx_prepare_message;
 	controller->unprepare_message = spi_imx_unprepare_message;
 	controller->slave_abort = spi_imx_slave_abort;
-	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_NO_CS;
+	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_NO_CS |
+				SPI_MOSI_IDLE_LOW;
 
 	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx) ||
 	    is_imx53_ecspi(spi_imx))
-- 
2.40.1

