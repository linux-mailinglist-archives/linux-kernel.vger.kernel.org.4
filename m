Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D60D625D53
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbiKKOk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbiKKOju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:39:50 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D378D5CD05
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 06:39:31 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id bj12so12909143ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 06:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAMGBaW4DNgnbxHPENr1NAw38Yk5iEpRnIys3RSCUnE=;
        b=DVseHuqQ+fdeqFq/cg5i/yOGTG4qIR6mwKQlbApHL7hGPLZtwKD+3PuBn6DEtxZjzU
         SCj3NzZbHwsYr6cAIdX0AtIDt+EioB8psnFybSyTkN0Os88giBjtV7Je58ZV2J9NqiGM
         BK8t6Pl/+wsQ9rzJbLDdqP2UxZQGL4OEuiVos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAMGBaW4DNgnbxHPENr1NAw38Yk5iEpRnIys3RSCUnE=;
        b=hKFFEURWs/9vi4tV8E6fvLg6YR7cc3LeegBVSTwnWeeWvEgvDiZjF/R98hWwjNjNmb
         q2icrdku9gcCL81VQ0cipqnoefCifsuO/19BtbGLVxiOb06uHSk8BM3CGmca2/dUn+at
         niyA9+pNm3rrgWF+rM92THlpqT5SiHTWxVj4bwBZoyh6xvUqhdbZkUiMxyLjvPKH8C6i
         U8SBSfg/Pw4HKnTIYpwRTJdD69JtHBHig5WtNZddGcYiDwVmQ+Cq/6mAK7tCO9ACpgDd
         ZZS/FwRZoCZcrfvsbFczCBGswG0duo66V/T4kVvyhNHKw/bpyTa4ugMOYjvS5kxe66n3
         u2Eg==
X-Gm-Message-State: ANoB5plLetj7yIbP6p9XvzYO7EvFAlpBmb43hazDQhk9aVtXIcsER/vR
        oyW6loEUJvzkpJh/QE+ISw9J0oEK8qsQB1wjTvQ=
X-Google-Smtp-Source: AA0mqf6uSSRRx4Q/XNl8iM4CFB+rpwgzG4zqyxc1Y93PWapbVBiCTtJEFTV0LfFQL7WkrlvtCR5YjA==
X-Received: by 2002:a17:906:f113:b0:78d:addf:67c1 with SMTP id gv19-20020a170906f11300b0078daddf67c1mr2043542ejb.272.1668177569930;
        Fri, 11 Nov 2022 06:39:29 -0800 (PST)
Received: from prevas-ravi.tritech.se ([80.208.71.65])
        by smtp.gmail.com with ESMTPSA id jt4-20020a170906dfc400b007a1d4944d45sm945886ejc.142.2022.11.11.06.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 06:39:29 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] iio: addac: ad74413r: add support for reset-gpio
Date:   Fri, 11 Nov 2022 15:39:21 +0100
Message-Id: <20221111143921.742194-6-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a board where the reset pin of the ad74412 is connected to a
gpio, but also pulled low by default. Hence to get the chip out of
reset, the driver needs to know about that gpio and set it high before
attempting to communicate with it.

When a reset-gpio is given in device tree, use that instead of the
software reset. According to the data sheet, the two methods are
functionally equivalent.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/iio/addac/ad74413r.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 9f77d2f514de..af09d43f921c 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -71,6 +71,7 @@ struct ad74413r_state {
 	struct regmap			*regmap;
 	struct device			*dev;
 	struct iio_trigger		*trig;
+	struct gpio_desc		*reset_gpio;
 
 	size_t			adc_active_channels;
 	struct spi_message	adc_samples_msg;
@@ -393,6 +394,13 @@ static int ad74413r_reset(struct ad74413r_state *st)
 {
 	int ret;
 
+	if (st->reset_gpio) {
+		gpiod_set_value_cansleep(st->reset_gpio, 1);
+		fsleep(50);
+		gpiod_set_value_cansleep(st->reset_gpio, 0);
+		return 0;
+	}
+
 	ret = regmap_write(st->regmap, AD74413R_REG_CMD_KEY,
 			   AD74413R_CMD_KEY_RESET1);
 	if (ret)
@@ -1316,6 +1324,10 @@ static int ad74413r_probe(struct spi_device *spi)
 	if (IS_ERR(st->regmap))
 		return PTR_ERR(st->regmap);
 
+	st->reset_gpio = devm_gpiod_get_optional(st->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(st->reset_gpio))
+		return PTR_ERR(st->reset_gpio);
+
 	st->refin_reg = devm_regulator_get_optional(st->dev, "refin");
 	if (IS_ERR(st->refin_reg)) {
 		ret = PTR_ERR(st->refin_reg);
-- 
2.37.2

