Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC27470AAA8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 21:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjETTJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 15:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjETTJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 15:09:24 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46308FB;
        Sat, 20 May 2023 12:09:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-510b56724caso4053560a12.1;
        Sat, 20 May 2023 12:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684609761; x=1687201761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FsOd9MgDJMeorWa734Iw1cUVj+gA3xOrUBWqtCM238=;
        b=Lvvrq1SrYEfGFtgK7XhopNNUW54VnLwwME7kwJUCt8G3GVicDeIZlxWmgHie87B7Fj
         jNjvyjTlE2nrdtNCtNTpva74t5epP7ecc8iHlMyYNZBDgieD5hu+rMHoaiaCerMoSbV4
         aaUGZy0qXj9W4hG+6stW0yxr5OGId1vwY0oazw7+h1Di4bRquJoi6C0AictpcJPUZYyV
         s0N7kVc/l8gQquPgec2NT6Coo+RLxAVlICYzly6v+1M9FurbqPW+KISKYgkHBiwjYwbf
         pP4qihvHvrnYy6fFre6NHS9YFlVLhPN7tiC1IqnIM/G1VliqjeLV4ldyuKgUFVHn4i27
         Xn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684609761; x=1687201761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FsOd9MgDJMeorWa734Iw1cUVj+gA3xOrUBWqtCM238=;
        b=kVDQYlGPnXClfEg+C/XKHTqb4fD68jM2ywXXqo6x32Tgq2mga3Vq2X0Zt1awN0gApz
         fJripBeD+mwRijMoLqNbuOsdgaa3Lim0tNw8TotTAZ/6y58ROJfQo2VgF9uW9zidWjrG
         asQob2YwgFWMwUsXT+Ibt2vx4IzVjW0yiRyh4tS27SG5KlhiziU46V1f1ayyEYGOsP0d
         VLifqe06cD2jPwB7kkEp3RlDSgyY2gEeG5rjehkePHyKeZWVbKDZaEpJxLhtQmq5Ofov
         bJKZ5n9IYwQRhvlmxWJr4OB8DasINwOeus87nBOqnv1D8thKqZg8X7eadm/mFWu+1VGT
         Yn9Q==
X-Gm-Message-State: AC+VfDzzlaYIVA+g9exRpwS5TH1DHnbaDGMntNCBmSlgZcXjH77S72UF
        mykrYrXl18CL6vZiaDhhuF0=
X-Google-Smtp-Source: ACHHUZ7/zpj7cLb82AnNyJLgCRKb4XbhmL6eH35FJLdOfnh75t+GIrt5AA62jl7FxhUG5JPQW71JcQ==
X-Received: by 2002:aa7:cd06:0:b0:50d:8d42:a454 with SMTP id b6-20020aa7cd06000000b0050d8d42a454mr5224238edw.21.1684609761696;
        Sat, 20 May 2023 12:09:21 -0700 (PDT)
Received: from wslxew193.fritz.box (p200300c78700c900cb504b662390cd6b.dip0.t-ipconnect.de. [2003:c7:8700:c900:cb50:4b66:2390:cd6b])
        by smtp.gmail.com with ESMTPSA id ba7-20020a0564021ac700b0050daa883545sm1065889edb.64.2023.05.20.12.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 12:09:21 -0700 (PDT)
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
Subject: [PATCH v5 2/4] spi: spi-imx: add support for SPI_MOSI_IDLE_LOW mode bit
Date:   Sat, 20 May 2023 21:08:53 +0200
Message-Id: <20230520190856.34720-3-boerge.struempfel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230520190856.34720-1-boerge.struempfel@gmail.com>
References: <20230520190856.34720-1-boerge.struempfel@gmail.com>
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
index 34e5f81ec431..1c4172fcba2d 100644
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
 	spi_imx->controller->prepare_message = spi_imx_prepare_message;
 	spi_imx->controller->unprepare_message = spi_imx_unprepare_message;
 	spi_imx->controller->slave_abort = spi_imx_slave_abort;
-	spi_imx->controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_NO_CS;
+	spi_imx->controller->mode_bits = SPI_MODE_X_MASK | SPI_CS_HIGH | SPI_NO_CS |
+					 SPI_MOSI_IDLE_LOW;
 
 	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx) ||
 	    is_imx53_ecspi(spi_imx))
-- 
2.25.1

