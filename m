Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83587157A8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjE3Hxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjE3Hxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:53:36 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A244990;
        Tue, 30 May 2023 00:53:34 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f60e536250so34227175e9.1;
        Tue, 30 May 2023 00:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685433213; x=1688025213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkbCQOnKS0MEzWaipfWc4DGGonHwiuGiYcvsGowmXvU=;
        b=spBov/dTKnPQTzEzpMhXigoTX7X/8Uy9+xEi+2SGTI4nYTjx17cEVPOwNm4X9ikPH1
         Qh0x7NptMwnX20XnhL/QATaCJ6TQZoVFb6dmIoUKhOymbyiBtWFHlePHn1N6p5nec3hv
         J1Khu3np4XVmYgPNIdRROtvsEVeHsLWQ+CGgGMApjBLtbjht1hd5TvPd3rLoXAauJmuU
         /cZNNPZCZtHyZASgWKJEimYxGxzKt4teB4H6hHL8WLKj3BJmYqqmKzXuoXuh/FOnAg3D
         quC+3OPRwDRP3yZzNmA9lFEn42YPk2kaYQw2bmvH2gPa6Mvz21HOwTgmW5bF2ebwTg/b
         PnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685433213; x=1688025213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkbCQOnKS0MEzWaipfWc4DGGonHwiuGiYcvsGowmXvU=;
        b=fl0n5WddDCBZuIpHN1jCAgDQpi1Y0AD+sb47JahwL829ZvCf1XEvEwGu5tzhJm0HUT
         TVeC3+Y9FgX3HLtj3JRQFdCVsHW//F4jhTFRiBBJ+EHC9rP+RdtYRyZRdL1yYrfX75Uh
         l8MAmF3qtoKP2kKXl/vWwJ6+qF1H8+wm+WTu0UBplh4Qb0OcewBgxV1pmHY56r2od6KA
         8hOyEYn5oT12FzPRSVqBu4l8L8xwHbb6+Y6lPx+Cnl/S6vajCuVlYy0xnOVWTqlsOOh/
         mx+q8UhFOC+e+dgZI1HaCFN0+KEhmWneFOvrh1JlJGxrrrYdITCU/BXGUMn/EdiNOXza
         QmXg==
X-Gm-Message-State: AC+VfDwP+nIwPBjg9jfL22FtahUYFtJ2M0IVWtvj8zDfT27Og8DHqGq6
        P1NDCzX0JDqCh61JDqjal0E=
X-Google-Smtp-Source: ACHHUZ5lS04TottrJMUXz+OX64OkqVEwB8rUwbfUhTJ/mSh0cTtiFFjMjhfvClBS2a93tbKFEGxkyw==
X-Received: by 2002:a05:600c:19ca:b0:3f7:2da:8fb4 with SMTP id u10-20020a05600c19ca00b003f702da8fb4mr3522438wmq.17.1685433213186;
        Tue, 30 May 2023 00:53:33 -0700 (PDT)
Received: from PC-UT2.ad.ennebielettronica.com ([78.152.97.130])
        by smtp.gmail.com with ESMTPSA id x21-20020a05600c21d500b003f6041f5a6csm16561275wmj.12.2023.05.30.00.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 00:53:32 -0700 (PDT)
From:   fl.scratchpad@gmail.com
To:     jic23@kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabrizio Lamarque <fl.scratchpad@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 3/5] iio: adc: ad7192: Use VRef instead of AVdd as reference voltage source
Date:   Tue, 30 May 2023 09:53:09 +0200
Message-Id: <20230530075311.400686-4-fl.scratchpad@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530075311.400686-1-fl.scratchpad@gmail.com>
References: <20230530075311.400686-1-fl.scratchpad@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrizio Lamarque <fl.scratchpad@gmail.com>

Add missing vref-supply and fix avdd-supply used as if it were vref.

AD7192 requires three independent voltage sources, digital supply (on
pin DVdd), analog supply (on AVdd) and reference voltage (VRef on
alternate pin pair REFIN1 or REFIN2).

Emit a warning message when AVdd is used in place of VRef for backwards
compatibility.

Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
---
 drivers/iio/adc/ad7192.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 5a9c8898f8af..bc41323ea810 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -177,6 +177,7 @@ struct ad7192_chip_info {
 struct ad7192_state {
 	const struct ad7192_chip_info	*chip_info;
 	struct regulator		*avdd;
+	struct regulator		*vref;
 	struct clk			*mclk;
 	u16				int_vref_mv;
 	u32				fclk;
@@ -1014,11 +1015,31 @@ static int ad7192_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	st->vref = devm_regulator_get_optional(&spi->dev, "vref");
+	if (!IS_ERR(st->vref)) {
+		ret = regulator_enable(st->vref);
+		if (ret)
+			return dev_err_probe(&spi->dev, ret,
+					     "Failed to enable specified VRef supply\n");
+
+		ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, st->vref);
+		if (ret)
+			return ret;
+	} else if (PTR_ERR(st->vref) != -ENODEV) {
+		return PTR_ERR(st->vref);
+	}
+
 	ret = devm_regulator_get_enable(&spi->dev, "dvdd");
 	if (ret)
 		return dev_err_probe(&spi->dev, ret, "Failed to enable specified DVdd supply\n");
 
-	ret = regulator_get_voltage(st->avdd);
+
+	if (!IS_ERR(st->vref)) {
+		ret = regulator_get_voltage(st->vref);
+	} else {
+		dev_warn(&spi->dev, "Using AVdd in place of VRef. Likely an old DTS\n");
+		ret = regulator_get_voltage(st->avdd);
+	}
 	if (ret < 0) {
 		dev_err(&spi->dev, "Device tree error, reference voltage undefined\n");
 		return ret;
-- 
2.34.1

