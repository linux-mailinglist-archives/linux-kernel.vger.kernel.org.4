Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88357411D1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjF1M4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjF1Myu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:54:50 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A751FFE
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 05:54:45 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b69e6cce7dso56518841fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 05:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=technolution.nl; s=google; t=1687956884; x=1690548884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rhoE/hOU88UBbnOfrfm2/MGIVLb91cXx21MeqmNwUZw=;
        b=Npt0Tn85u814tonQVf53TAZhdKLQB+57Y8w4w3VZP+BNUQf+hcfeytqDl9knhUAGcL
         E+PTgJSQOhBbcyVFH7iRAJGOtbPV59HTS1Aut/PD1EwmVux+zCbeIVQbTRpnIR9MSCM/
         8ltf+TGp9AuvL3we8eWSwfa/eAs+VMzps4yl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687956884; x=1690548884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhoE/hOU88UBbnOfrfm2/MGIVLb91cXx21MeqmNwUZw=;
        b=aCcmPEbmTaOVA+YqlSQ9bHkLrnTwOnafpRs0jZb2onhYkUWJlGVzIFmbP7707J3NaS
         XXdp448Ok2K5tHgdJ5aC0zt2mbHuKdu+SN78V7mAaozsEqiZuH6j9Xz3ghfGdvHu3qF8
         rHxJX9OPlb4Grqmu4Z0oUR2vKeTRVMO1sTZbVBV0TwkimYMxMeRhV1y5Nqs5f1Iuuc7v
         5um8QqeG8ayO9MN+tRiuvLhVjxNT2G3e+4pS66KhGwPvQrjTvzescuu1TsHc0CgwL6cJ
         kRUUkcRS23HohmMgAlyPcqnc1rlD27o4oAPRbnrodIyBbGgUD1UKxvj9C/ms1e020fyd
         UQTQ==
X-Gm-Message-State: AC+VfDy04cf63DAXczswPF2pWyNC5ZCFmnDfdgqcvnrdSHbzX/TQ11gN
        OxqboOzdprfD26gqSg8erb48N8lj8rTXmGtISH8tCUJMLFwqoPdu5YZj0xhDO3u+wsWeQzJXFlW
        MNnfaqt1USpK+OKOhuQ==
X-Google-Smtp-Source: ACHHUZ6vV9qAUrXcC2BjcqVO+KrNC7uf8EcMIKDEDARCGX6s/gB9JD+RuYJQBpSt9sFveiWGB7SDjw==
X-Received: by 2002:a2e:9943:0:b0:2b6:9909:79ca with SMTP id r3-20020a2e9943000000b002b6990979camr8036311ljj.30.1687956883878;
        Wed, 28 Jun 2023 05:54:43 -0700 (PDT)
Received: from STM-Latitude-5530.intranet.technolution.nl (90-145-157-240.bbserv.nl. [90.145.157.240])
        by smtp.gmail.com with ESMTPSA id h8-20020aa7c948000000b0051d87e72159sm4440636edt.13.2023.06.28.05.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 05:54:43 -0700 (PDT)
From:   Stefan Moring <stefan.moring@technolution.nl>
To:     broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Stefan Moring <stefan.moring@technolution.nl>
Subject: [PATCH] spi: Increase imx51 ecspi burst length based on transfer length
Date:   Wed, 28 Jun 2023 14:54:06 +0200
Message-Id: <20230628125406.237949-1-stefan.moring@technolution.nl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-techno-validated: techno-validated
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMX51 supports 4096 bit burst lengths. Using the spi transfer length
instead of bits_per_word increases performance significantly.

Signed-off-by: Stefan Moring <stefan.moring@technolution.nl>
---
 drivers/spi/spi-imx.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 34e5f81ec431..cbd306c25d28 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -644,9 +644,13 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 	if (spi_imx->slave_mode && is_imx53_ecspi(spi_imx))
 		ctrl |= (spi_imx->slave_burst * 8 - 1)
 			<< MX51_ECSPI_CTRL_BL_OFFSET;
-	else
-		ctrl |= (spi_imx->bits_per_word - 1)
-			<< MX51_ECSPI_CTRL_BL_OFFSET;
+	else {
+		if (spi_imx->count >= 512)
+			ctrl |= 0xFFF << MX51_ECSPI_CTRL_BL_OFFSET;
+		else
+			ctrl |= (spi_imx->count*8 - 1)
+				<< MX51_ECSPI_CTRL_BL_OFFSET;
+	}
 
 	/* set clock speed */
 	ctrl &= ~(0xf << MX51_ECSPI_CTRL_POSTDIV_OFFSET |
@@ -1243,6 +1247,7 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 		spi_imx->spi_bus_clk = t->speed_hz;
 
 	spi_imx->bits_per_word = t->bits_per_word;
+	spi_imx->count = t->len;
 
 	/*
 	 * Initialize the functions for transfer. To transfer non byte-aligned
-- 
2.34.1

