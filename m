Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A492D6D7E8B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbjDEOEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238335AbjDEODP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:03:15 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAC972A9;
        Wed,  5 Apr 2023 07:01:37 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id k37so46824424lfv.0;
        Wed, 05 Apr 2023 07:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680703294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPAHsCB+vewAndH85J11KGlhia9f1zZVc29B15eZm9c=;
        b=Hl1YkxX408ksxtgpJsoPqFtNm8AGaBNRHeN3oipVgw1Y8pQyQCXwT6fu07JcpbI++1
         cqjO4MmRf8onmi7mrY1Ei/P4Js1zNR/7rh//Wo/fz3qi3nxquBQB1lbMmZvhZtDk7ay3
         S8tXkZGsA8kvLTTTUlEEsedxTYLQDqPHDGT6s57lHRT25faJi02Uzih/jiwAsdBqGBI1
         Be5hesX8uJGs6dHIuem7NT+9d2E+IooOG6S2+cSNP6dcioaLcQ1LTgkRSUAifTBGfn8d
         rxIplIalZduK0l4EU42SCtOo5uWlGED8mkCusPtzWbUsWHrklfen8F+1/iX0ZoTfhtKv
         yarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680703294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPAHsCB+vewAndH85J11KGlhia9f1zZVc29B15eZm9c=;
        b=RdffTwzXaB17ToywZnThCUmz6ggzV8TXjliSAaitz43ligGnD9zz0QaWdeRvsiJVIL
         9xcuVF93pgfOjRetlN2tfSGEOWr+1BwjJVt7SpuptO18lU7rIRb0am3ryhiM3NALn8ae
         xav8F0XfWEuTy74LG86KLvvcK1MfedRdwbM3zR3qj9meWqNAwFgHT9eN8TXfdKuTTGRF
         CJc3J+df1HGgJqVhNptt718zWWlVhvThKRIfzHX5Ilt93qAeoS64ggl8j3jdYKgP54Xs
         XwtduDSa08JAdlKF1dla7iMzsSjXKT6rK3tYeuY7/HI3XHaCyMeA19mLFh28NIki4GGu
         XrxA==
X-Gm-Message-State: AAQBX9cyyQjctNeWzresa5488NLJ0yP6ybp6DypFhqzYr2jH10wRsEcq
        T5nxtschSYITMkK0FNVvkjM=
X-Google-Smtp-Source: AKy350bQQ06vmL12FOZTrLwYg7QQ/v1odHrtFvuh7wHG38TJYkoenMhyuq7eXxESP94AlO6803AWMw==
X-Received: by 2002:ac2:50c2:0:b0:4a9:39f4:579a with SMTP id h2-20020ac250c2000000b004a939f4579amr1594470lfm.66.1680703293093;
        Wed, 05 Apr 2023 07:01:33 -0700 (PDT)
Received: from archbox.v.cablecom.net (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c4ec600b003edc4788fa0sm2412383wmq.2.2023.04.05.07.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 07:01:32 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] iio: dac: mcp4922: get and enable vdd regulator
Date:   Wed,  5 Apr 2023 16:01:12 +0200
Message-Id: <20230405140114.99011-3-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405140114.99011-1-frattaroli.nicolas@gmail.com>
References: <20230405140114.99011-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MCP4922 family of chips has a vdd power input, which we
model in our device tree binding for it. The driver should get
and enable the vdd regulator as is appropriate.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 drivers/iio/dac/mcp4922.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/mcp4922.c b/drivers/iio/dac/mcp4922.c
index da4327624d45..0b9458cbbcff 100644
--- a/drivers/iio/dac/mcp4922.c
+++ b/drivers/iio/dac/mcp4922.c
@@ -31,6 +31,7 @@ struct mcp4922_state {
 	unsigned int value[MCP4922_NUM_CHANNELS];
 	unsigned int vref_mv;
 	struct regulator *vref_reg;
+	struct regulator *vdd_reg;
 	u8 mosi[2] __aligned(IIO_DMA_MINALIGN);
 };
 
@@ -148,10 +149,23 @@ static int mcp4922_probe(struct spi_device *spi)
 	if (ret < 0) {
 		dev_err(&spi->dev, "Failed to read vref regulator: %d\n",
 				ret);
-		goto error_disable_reg;
+		goto error_disable_vref_reg;
 	}
 	state->vref_mv = ret / 1000;
 
+	state->vdd_reg = devm_regulator_get(&spi->dev, "vdd");
+	if (IS_ERR(state->vdd_reg)) {
+		ret = dev_err_probe(&spi->dev, PTR_ERR(state->vdd_reg),
+				    "vdd regulator not specified\n");
+		goto error_disable_vref_reg;
+	}
+	ret = regulator_enable(state->vdd_reg);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to enable vdd regulator: %d\n",
+			ret);
+		goto error_disable_vref_reg;
+	}
+
 	spi_set_drvdata(spi, indio_dev);
 	id = spi_get_device_id(spi);
 	indio_dev->info = &mcp4922_info;
@@ -167,12 +181,13 @@ static int mcp4922_probe(struct spi_device *spi)
 	if (ret) {
 		dev_err(&spi->dev, "Failed to register iio device: %d\n",
 				ret);
-		goto error_disable_reg;
+		goto error_disable_vdd_reg;
 	}
 
 	return 0;
-
-error_disable_reg:
+error_disable_vdd_reg:
+	regulator_disable(state->vdd_reg);
+error_disable_vref_reg:
 	regulator_disable(state->vref_reg);
 
 	return ret;
@@ -185,6 +200,7 @@ static void mcp4922_remove(struct spi_device *spi)
 
 	iio_device_unregister(indio_dev);
 	state = iio_priv(indio_dev);
+	regulator_disable(state->vdd_reg);
 	regulator_disable(state->vref_reg);
 }
 
-- 
2.40.0

