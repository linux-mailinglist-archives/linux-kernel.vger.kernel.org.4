Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72FE72FF32
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244778AbjFNM4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244773AbjFNM4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:56:09 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39C51715;
        Wed, 14 Jun 2023 05:56:06 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f8cc04c287so5841605e9.0;
        Wed, 14 Jun 2023 05:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686747365; x=1689339365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YepcUjgWrlzucwsUXaypG8Xwm55IhlbZIwruLgPvyBE=;
        b=F51kGwChgtMam7+0FLFHEzdk+DFy/9+MlYjnFjYPdWQhHG8jv6vSd9cO+88v3BfRPw
         BHCQwfdLUYSjub3dCSa71rl6vUYkohnDsgpoc+98YpmON1uNihUkFG4vJZiPy5O13zuf
         kcRvqBmcbmtEVGwbSB2CdZjd4wqqDaIdfko2K2kHmFqnMsgUVNKNisAjxRGA5sMKnlnc
         HlFGkTFVm6M6LrrHzI7yzcQzMSwaS/S4lfp1JpYzCyn2viM0dMNikN1d5nGe5Hryy9/h
         zhKFnH/NJT/IKKGoXIrNS0rPjg8IJKIPLZf86Kj4YJ4/rjAwVIAn4ivceBv7ICw83b43
         PFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686747365; x=1689339365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YepcUjgWrlzucwsUXaypG8Xwm55IhlbZIwruLgPvyBE=;
        b=NffBKj9Z1IwffQMPKfLX2duc6VRopDZ+MaaA0QEz/o4MgmqwTTtWxq24WoPIN1ewd7
         EmcCldxnAfi35VE8c5htO9Mguqh2gpD/s0o6woe89vaFbObleUmfZYnGVaMXnlecwQF8
         0vCRuA0FsKBgtSxQHW/YxJ6+2EDqbWbJvux8oXimDGKpauHSoxtkzUrlzoNXuN+HDacm
         QhIO6ZzMZD+J6jFaNlXpu/PTjIhJFR/ksb7tZCQ+jI7BQFYQlBAWkjoQLvZ5pyX2rvxW
         CDCAOpBAAl/Yvay+UewQegDdvQlYmhNw8QEiZ1IxJ2PpO7uW1Q+0bP1buE/dEUypJV4a
         pF+g==
X-Gm-Message-State: AC+VfDxFY/KdGGN1LO53Ulmyi6HNmTN7ZKto86dxxbOX7wSBgGvN8+Ms
        hMwpA4BOdtr0ceFf2qH5UyXlE7grV/FyADrG
X-Google-Smtp-Source: ACHHUZ4jL/18v+yeoDRa6uKUlkZ94eQoDQIc/G0RPv2dXEDM634qS0fXpWbBMwLe/D9AttbkyWXPcw==
X-Received: by 2002:a1c:6a18:0:b0:3f7:19f9:4c4f with SMTP id f24-20020a1c6a18000000b003f719f94c4fmr10721940wmc.21.1686747364978;
        Wed, 14 Jun 2023 05:56:04 -0700 (PDT)
Received: from user-PC.. ([92.51.95.194])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0ad500b003f7310a3ffasm17402522wmr.2.2023.06.14.05.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 05:56:04 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maxim Kiselev <bigunclemax@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 2/3] thermal: sun8i: Add D1/T113s THS controller support
Date:   Wed, 14 Jun 2023 15:55:20 +0300
Message-Id: <20230614125530.660597-3-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230614125530.660597-1-bigunclemax@gmail.com>
References: <20230614125530.660597-1-bigunclemax@gmail.com>
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

From: Maxim Kiselev <bigunclemax@gmail.com>

This patch adds a thermal sensor controller support for the D1/T113s,
which is similar to the one on H6, but with only one sensor and
different scale and offset values.

Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 793ddce72132..01cc4e130892 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -628,6 +628,18 @@ static const struct ths_thermal_chip sun50i_h6_ths = {
 	.calc_temp = sun8i_ths_calc_temp,
 };
 
+static const struct ths_thermal_chip sun20i_d1_ths = {
+	.sensor_num = 1,
+	.has_bus_clk_reset = true,
+	.offset = 188552,
+	.scale = 673,
+	.temp_data_base = SUN50I_H6_THS_TEMP_DATA,
+	.calibrate = sun50i_h6_ths_calibrate,
+	.init = sun50i_h6_thermal_init,
+	.irq_ack = sun50i_h6_irq_ack,
+	.calc_temp = sun8i_ths_calc_temp,
+};
+
 static const struct of_device_id of_ths_match[] = {
 	{ .compatible = "allwinner,sun8i-a83t-ths", .data = &sun8i_a83t_ths },
 	{ .compatible = "allwinner,sun8i-h3-ths", .data = &sun8i_h3_ths },
@@ -636,6 +648,7 @@ static const struct of_device_id of_ths_match[] = {
 	{ .compatible = "allwinner,sun50i-a100-ths", .data = &sun50i_a100_ths },
 	{ .compatible = "allwinner,sun50i-h5-ths", .data = &sun50i_h5_ths },
 	{ .compatible = "allwinner,sun50i-h6-ths", .data = &sun50i_h6_ths },
+	{ .compatible = "allwinner,sun20i-d1-ths", .data = &sun20i_d1_ths },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, of_ths_match);
-- 
2.39.2

