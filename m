Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29BA72AED5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 22:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjFJUnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 16:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjFJUnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 16:43:04 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350FAA1;
        Sat, 10 Jun 2023 13:42:58 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f6d38a140bso21845585e9.1;
        Sat, 10 Jun 2023 13:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686429776; x=1689021776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YepcUjgWrlzucwsUXaypG8Xwm55IhlbZIwruLgPvyBE=;
        b=F6rnkQ9QkfUizsHDO4zOJeZAMdU0vxJlJ14YnsLnpd+8OC0mIeS7UmV8LiFfC3cLrl
         4avEyjBKT8wXZT/ylM+Cpiu/cgzY9CjIz+jQsYiGFEMZQoEyX8uOFHVIt8Z3fW3nIIyp
         KJvU4O7Ni+VsXm1PXinGdoyFZ+zGVtUeU/shysWO3e9a2unqlpI9M4UURbORiBoxmEKR
         Tk8DzjkTl6G9IQsisefVZglSX0mNrT/uBWgc5JgWPrAVhhsdf9/B39ZrJILoUgD1UfY+
         YwyEEcg6cXhmyz1YG+cVdr2nT0O4sABbM02281C4YG7Cn8tpe9XrYlFAzO/6vAnBD0J5
         9ivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686429776; x=1689021776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YepcUjgWrlzucwsUXaypG8Xwm55IhlbZIwruLgPvyBE=;
        b=TEsQs07fzlbqpRnoxyWksIAdasOCm/aAMSZ5xspdCie6Hp3/9U2mWSNbNp10dU4Vqv
         MEEZDcTzYx5aKtWzZL32ByzNfvQ7Qf38M5mKRmD/2GA3Pe04KK6t330/e8eD+FvgIz0q
         3K0ngM61Ph1xmAP2hI5lo74bb9YEc2apeyl3HaOVf19dBu8tGjqhXuSBsJAsTZShfyb9
         KSWZQ1h/WG3fTMtLR+B+gopb0nf21xTIP7j4k5lJoOAEnToxv9UPc1jgnB3uKnPn0jSb
         JWF2Fl0nxfo8CeAI4jwjvrEaVXEFdYSFUV1auDm/Pu/0QYA/m4sx0MwsmQOReGqCU9do
         wpzg==
X-Gm-Message-State: AC+VfDzaNrC5/Jj3H1nIiLZ8DJnc9ZUOkOLtzEVrOoe1s4Jya6s58YwW
        DcESs7O8z37MwXFJJDwa/7GS+nTeZyGZ/KY6
X-Google-Smtp-Source: ACHHUZ5hl/t9RLi6dcRWD6tEfDyFIVkmHTmWhAr5QgeTFMaBDa20Chpow03pAm0mgovfjDvYv8anlA==
X-Received: by 2002:a05:600c:1c15:b0:3f7:aee8:c23a with SMTP id j21-20020a05600c1c1500b003f7aee8c23amr6460591wms.19.1686429776392;
        Sat, 10 Jun 2023 13:42:56 -0700 (PDT)
Received: from user-PC.. ([178.134.198.138])
        by smtp.gmail.com with ESMTPSA id p14-20020a7bcc8e000000b003f605566610sm6547733wma.13.2023.06.10.13.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:42:56 -0700 (PDT)
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
        Andre Przywara <andre.przywara@arm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 2/3] thermal: sun8i: Add D1/T113s THS controller support
Date:   Sat, 10 Jun 2023 23:42:19 +0300
Message-Id: <20230610204225.1133473-3-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230610204225.1133473-1-bigunclemax@gmail.com>
References: <20230610204225.1133473-1-bigunclemax@gmail.com>
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

