Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E261570F21D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbjEXJVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240636AbjEXJU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:20:57 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1E0FC;
        Wed, 24 May 2023 02:20:52 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-510b7b6ef59so1689625a12.3;
        Wed, 24 May 2023 02:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684920050; x=1687512050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/xRPtd2AmjbmXpgou4sQlZTgH09nz9cR2dZE8lQL3E=;
        b=PPtskXMBVcYltGkT+VrqN9E+v3cEyV6+544dMX+xoe1iClmJetzSs7Bs6ON/ySpouZ
         NCeMuYoojyfioAV/tXwL+MQaKkjDlZk42y+VRAK/rmGj5ZJQ7v20k0kpi7yauOAlK9XY
         wAlIVf3gO9r5KHISM9/VrOCUQDL4P0N00GsnlWZ7nvO/VA9q6Tk/dx5Up9yxR8GGl2/i
         NVBrR2EYOE6CrKvLeBNSRmsBddDLbmo1MRrnOLkMgrWwAgxYbSqTLWnkYdsdwrgqWMkz
         bXKdXA73poVgAsLl8sUoPKwtEU2exVXfOBZEEosJOrB4zPlM4m5iQi8I4L7qlJS7uMdM
         zR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684920050; x=1687512050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/xRPtd2AmjbmXpgou4sQlZTgH09nz9cR2dZE8lQL3E=;
        b=lJVBBu6AX7TtUKkxfmbmBG47MyCxPqi9lRHxFNKE62gCBEW7hyhw8w2wjo3GTrNlLI
         7R4Kqdnuvxh0M9/OcU97xLkQLAexMA1N6qX6teTemI1S6T3iYG2Q97aYUhJNbnKvxxrJ
         +MdhiXmdpxvZLMRwf2xQa4hl9bbttqOQjhBh/WoCcoZGdKjy3+YzYFHRmJg1RQMUxs2e
         duN0ubYb8F7NI6oJDP0Zi1O79gEBQ1/HICsoES8hlZiHjFhp4RpI6d6Zhbv6ihdgc8Zi
         8PbgVWJwhqadC3uZYpYWB/GS3pjT0eLET3egbxC5xbwbi9XleQoZMo9Tagitdp3TiM/D
         eilA==
X-Gm-Message-State: AC+VfDwUs80IWPAwcSqNvqMz36h5bd4DFgnCgJd6GATA40PnDr3uxqxt
        dpf56c+BwgkhZrUEqi/c0N8=
X-Google-Smtp-Source: ACHHUZ4ArixSPchxmOg3uVHa68zXOjZi+cEwG9Jj0dh24gaZ1G5fD+6w7OttPO0/0uqQ5IuwliWrUQ==
X-Received: by 2002:a17:907:96a1:b0:959:bbda:fa51 with SMTP id hd33-20020a17090796a100b00959bbdafa51mr18565467ejc.41.1684920050496;
        Wed, 24 May 2023 02:20:50 -0700 (PDT)
Received: from wslxew193.ultratronik.de (p200300c78700c900fd67df8b3b199594.dip0.t-ipconnect.de. [2003:c7:8700:c900:fd67:df8b:3b19:9594])
        by smtp.gmail.com with ESMTPSA id jy22-20020a170907763600b0096fbc516a93sm4579527ejc.211.2023.05.24.02.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 02:20:50 -0700 (PDT)
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
Subject: [PATCH v6 2/5] spi: spi-imx: add support for SPI_MOSI_IDLE_LOW mode bit
Date:   Wed, 24 May 2023 11:19:45 +0200
Message-Id: <20230524091948.41779-3-boerge.struempfel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524091948.41779-1-boerge.struempfel@gmail.com>
References: <20230524091948.41779-1-boerge.struempfel@gmail.com>
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
2.40.1

