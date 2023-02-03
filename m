Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5F4689AFA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjBCOEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbjBCOED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:04:03 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4E79AFC2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:01:52 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d14so4720686wrr.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 06:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C80uHS7oQ9BIHpE1WmMa0ssy0dSruFRP/djxr2WevbY=;
        b=Qlxx84XZAGXu2f/D9Zjd3opzizOJ1VtjZiwcnVtu5WlR8C3ZeGzqw2xQ6fM5TQD6ye
         ySoDD1MS9qc/koK1t9UZvGrhc4DSmP5TfBkNeDeAxBfafUFWT8veGW98NdgefrgoCNXx
         nMzEE28npBOAVqDMjD+oafrLW7OnN2BQk6orC8qjMfwIS7sw0BbDHpl5r+9BilS4tcxj
         /WBsAlCqbJe4pwVQ4oMQx5k4GHfK4cqTWhIY6G5q6YZl99LfvboEml10YQPsNWDXWUsM
         dw00YoQ8vzwnVYVVolGU8DEAsu60sGCB5VtHq+wb+4PQyM0zFgDNJTIJBYp+1ij/6JCO
         hdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C80uHS7oQ9BIHpE1WmMa0ssy0dSruFRP/djxr2WevbY=;
        b=vqB1h6I2a6RSMfZGAHI7Cw3ubWQdr6NpZ9Ryhx4E276VOZJP+50WDbz+0O0lSeSz+p
         4NkC2q6zwWHLpEc2rWtszyq1XK3bsQ2SXhjJJlpcr10t9g54IpmhxNGUt9v4VgIqtNbD
         iv32taINl02MWvw9CirQKLKXRvAc3KpshuODhC9/vrKGy6J62EQNGag9n6VvvvpPafji
         fHFhqwvNCixJim7R4iWldxc82IkVLM4CFWrp6VdhucUqesBGpQC/y2NijEBrsJCMjDSA
         BV3NlEmk8drf/4nPX7aMUjbh/FHOxoJ+ycn+4Wj4yHxoDCaJk+8KbPI8Hb5xIPe9CUTy
         gx0Q==
X-Gm-Message-State: AO0yUKXUshk8hXrc5agZBaYg+jXge4ZHKn/c9keX8KYzwn5wcBZ7L017
        0n6pKu47xpJevPgWmxNvS6Yz5w==
X-Google-Smtp-Source: AK7set9QsyK9xtov2bQPmgwqnf/VObYYOTpUrptYGpBtPDdrWwmt2VHzCPQSmj5kTSFn7/FeUNm9WQ==
X-Received: by 2002:a05:6000:1a86:b0:2bf:c9e9:a654 with SMTP id f6-20020a0560001a8600b002bfc9e9a654mr10455136wry.10.1675432883455;
        Fri, 03 Feb 2023 06:01:23 -0800 (PST)
Received: from jerome-BL.. (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id x9-20020a5d4449000000b002c3cf230b60sm1719396wrr.73.2023.02.03.06.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 06:01:23 -0800 (PST)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     tony@atomide.com, lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, nm@ti.com, msp@baylibre.com,
        Jerome Neanne <jneanne@baylibre.com>
Subject: [PATCH] regulator: tps65219: use generic set_bypass()
Date:   Fri,  3 Feb 2023 15:01:19 +0100
Message-Id: <20230203140119.13029-1-jneanne@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to wrong interpretation of the specification,
custom implementation was used instead of standard regmap helper.
LINK: https://lore.kernel.org/all/c2014039-f1e8-6976-33d6-52e2dd4e7b66@baylibre.com/

Fixes: c12ac5fc3e0a ("regulator: drivers: Add TI TPS65219 PMIC regulators support")

Regulator does NOT require to be off to be switched to bypass mode.

Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 drivers/regulator/tps65219-regulator.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/regulator/tps65219-regulator.c b/drivers/regulator/tps65219-regulator.c
index 070159cb5f09..58f6541b6417 100644
--- a/drivers/regulator/tps65219-regulator.c
+++ b/drivers/regulator/tps65219-regulator.c
@@ -173,24 +173,6 @@ static unsigned int tps65219_get_mode(struct regulator_dev *dev)
 		return REGULATOR_MODE_NORMAL;
 }
 
-/*
- * generic regulator_set_bypass_regmap does not fully match requirements
- * TPS65219 Requires explicitly that regulator is disabled before switch
- */
-static int tps65219_set_bypass(struct regulator_dev *dev, bool enable)
-{
-	struct tps65219 *tps = rdev_get_drvdata(dev);
-	unsigned int rid = rdev_get_id(dev);
-
-	if (dev->desc->ops->is_enabled(dev)) {
-		dev_err(tps->dev,
-			"%s LDO%d enabled, must be shut down to set bypass ",
-			__func__, rid);
-		return -EBUSY;
-	}
-	return regulator_set_bypass_regmap(dev, enable);
-}
-
 /* Operations permitted on BUCK1/2/3 */
 static const struct regulator_ops tps65219_bucks_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -217,7 +199,7 @@ static const struct regulator_ops tps65219_ldos_1_2_ops = {
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.list_voltage		= regulator_list_voltage_linear_range,
 	.map_voltage		= regulator_map_voltage_linear_range,
-	.set_bypass		= tps65219_set_bypass,
+	.set_bypass		= regulator_set_bypass_regmap,
 	.get_bypass		= regulator_get_bypass_regmap,
 };
 
-- 
2.34.1

