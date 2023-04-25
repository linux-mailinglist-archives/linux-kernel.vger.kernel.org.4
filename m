Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C266EE365
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbjDYNpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbjDYNpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:45:35 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E7CCC18
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:45:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-94f7a0818aeso872250366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1682430333; x=1685022333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4sRdWC2cDHZjejBYhhOCUr1iFuyu6C1Fz1Mden7vTg=;
        b=Z+SKr1Ux8TXyogmCHsNc4/c9jBYnw/ezmC0VGtD1fZH6kazcZAF/QNVU+NXutbp4tt
         gDMLMyvaf3VlLPBJN6PxnB9PSBlCbSGoN3hQ67YfPy85ej2Efk2mrrPj5C3R+yEeu5bj
         b+ID2oi1EGUK8rhRUgZpj6hu8zzOpzOdayHS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682430333; x=1685022333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4sRdWC2cDHZjejBYhhOCUr1iFuyu6C1Fz1Mden7vTg=;
        b=dh/S/w2m8E1DclEAH+OywuBFfYXLu+dRuhvWB1u78BUXqigjuDazKcgKMCk7vGPNwX
         n4qdlEW5w7rhqdR5lnyey0NRa/RFeX8r8CrgXqFLhk/kx8RRxDfS0BiSD2Z4Dr6bDpt9
         XoygN3Kr3iU3cRVVW3SlolQerNNThxiL4m/God3CaH4TSQZx2rLHX9PZetOnVJPwZHf/
         qSaUGQWYP1OLLyenqJSaVFCfrcie6guYP77j2T6znZa/wzWvFlj5BHIt+mEjYi68pJJE
         zvIeU3WPJ3Tgny+ajajY4PpHbh05REnwTY2ktKv8mPEDKn/gIilWCQlrVi9+/XeNcFIK
         A3wA==
X-Gm-Message-State: AAQBX9eEmcqMUCYhuoA0tEA27QK0Xv60iK7m48tDwYe1vqiW03D3LsB+
        gZN9vvbAcTdXih8WBpr8MMPbAw==
X-Google-Smtp-Source: AKy350bel0saz0NNkLMsNuHNUBFgQRefYyEt6zhsCW5VrBurn20Uw4hMW3itsS+i0T2zY7/JuQWDyw==
X-Received: by 2002:a17:906:7686:b0:956:f4f8:23b6 with SMTP id o6-20020a170906768600b00956f4f823b6mr13168543ejm.43.1682430332774;
        Tue, 25 Apr 2023 06:45:32 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f10-20020a170906048a00b0094eeea5c649sm6806822eja.114.2023.04.25.06.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 06:45:32 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] spi: spi-imx: use "controller" variable consistently in spi_imx_probe()
Date:   Tue, 25 Apr 2023 15:45:25 +0200
Message-Id: <20230425134527.483607-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230425134527.483607-1-linux@rasmusvillemoes.dk>
References: <20230425134527.483607-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Near the top of the function, spi_imx->controller is set to
controller (and is of course never modified again). The rest of the
function uses a mix of the two expressions.

For consistency, readability and better code generation, drop all the
spi_imx-> indirections.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/spi/spi-imx.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index e4ccd0c329d0..6fa53a82674a 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1725,20 +1725,20 @@ static int spi_imx_probe(struct platform_device *pdev)
 	else
 		controller->num_chipselect = 3;
 
-	spi_imx->controller->transfer_one = spi_imx_transfer_one;
-	spi_imx->controller->setup = spi_imx_setup;
-	spi_imx->controller->cleanup = spi_imx_cleanup;
-	spi_imx->controller->prepare_message = spi_imx_prepare_message;
-	spi_imx->controller->unprepare_message = spi_imx_unprepare_message;
-	spi_imx->controller->slave_abort = spi_imx_slave_abort;
-	spi_imx->controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_NO_CS;
+	controller->transfer_one = spi_imx_transfer_one;
+	controller->setup = spi_imx_setup;
+	controller->cleanup = spi_imx_cleanup;
+	controller->prepare_message = spi_imx_prepare_message;
+	controller->unprepare_message = spi_imx_unprepare_message;
+	controller->slave_abort = spi_imx_slave_abort;
+	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_NO_CS;
 
 	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx) ||
 	    is_imx53_ecspi(spi_imx))
-		spi_imx->controller->mode_bits |= SPI_LOOP | SPI_READY;
+		controller->mode_bits |= SPI_LOOP | SPI_READY;
 
 	if (is_imx51_ecspi(spi_imx) || is_imx53_ecspi(spi_imx))
-		spi_imx->controller->mode_bits |= SPI_RX_CPHA_FLIP;
+		controller->mode_bits |= SPI_RX_CPHA_FLIP;
 
 	if (is_imx51_ecspi(spi_imx) &&
 	    device_property_read_u32(&pdev->dev, "cs-gpios", NULL))
@@ -1747,7 +1747,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 		 * setting the burst length to the word size. This is
 		 * considerably faster than manually controlling the CS.
 		 */
-		spi_imx->controller->mode_bits |= SPI_CS_WORD;
+		controller->mode_bits |= SPI_CS_WORD;
 
 	spi_imx->spi_drctl = spi_drctl;
 
-- 
2.37.2

