Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DC46F992C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 17:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjEGPGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 11:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjEGPGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 11:06:14 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99726191C0;
        Sun,  7 May 2023 08:05:58 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3078fa679a7so609657f8f.3;
        Sun, 07 May 2023 08:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683471957; x=1686063957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7busPrq4Ix2D0XVL7/yDg+1KY42O5SIQ2uX5rrJTys=;
        b=WJviFBiRpKKdvo1AbdVorv1k0LHGOVJgpFX4nC2Bi+cMQlqBqyIvX4pWyPQ9zWDuU5
         bCfrjfVXnvCwV1yFR20U13u10aFZqJIv1e8E7idIxkNWP+oP3RPNIeZDFxbywq0ALqFO
         XccX3TebqOKg04UsHzW12VyT9FdtC2x1cMNTeSzFW4ZAuu2UoRb32QFv4/E/DPmO6lbv
         g/mm3cYM97lkrjN0F3nIQN1/SCU15/Uqc0p9v+SzQevYcmUwiNGJmVdmmS01sL/q4rx2
         RxVFvOiun6xporcGtN8DaG7QRxYfkpA4E3SAEtvDkSTBsC7FHXxQbtrJSfND19PilENn
         lkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683471957; x=1686063957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7busPrq4Ix2D0XVL7/yDg+1KY42O5SIQ2uX5rrJTys=;
        b=cS39Ip3ziUZqrRGkr/i4uaSKL5czOBI78i8H1yk7m1xJGPaj+a6u48TVCUM67cMi0C
         CmBf3SQMuOWDmajdH7kHcnMhhLx7WvBQsH74TY9N/LXXz7StrpwD8ahtxQKN6tEG0Min
         r/RUicNk3LKd5NG6lXYJcR1PMBWrTcZa+Lp+MzOf9nwzcg7cGBa7pnrw+8ExjLRtkHN/
         DDGBGXSafAKy2WEY6Aue0ExgygjNZgapeyG88V9kb0BBGAgOrTL+vGVWPxV5FChJiJy4
         uCj1uejwq4vw2cMKE8BZgLBaCHH/fsnZMLJzWkxXPm+tStr+Q5N3i0+ks4tpv7l5hHP1
         9o5w==
X-Gm-Message-State: AC+VfDy3maD+mHVHfvv44pksImIEDCXEa/HWDGRZwX/M34/3HnPa5VgM
        ZgeIR7fVZtQNjbkNPMlE5Go=
X-Google-Smtp-Source: ACHHUZ6Tgq00goUGd6cc5bfJap5ngrn1ZPs4mrdlVseReHkslpgNcCs6pqxjKm3kGw5VrEUK/xif5w==
X-Received: by 2002:adf:f84b:0:b0:307:8b6f:dcff with SMTP id d11-20020adff84b000000b003078b6fdcffmr2923274wrq.37.1683471957047;
        Sun, 07 May 2023 08:05:57 -0700 (PDT)
Received: from localhost.localdomain ([176.221.215.212])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d594f000000b0030771c6e443sm8437998wri.42.2023.05.07.08.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 08:05:56 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Mark Brown <broonie@kernel.org>,
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
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v4 4/5] spi: sun6i: add support for R329/D1/R528/T113s SPI controllers
Date:   Sun,  7 May 2023 18:03:36 +0300
Message-Id: <20230507150345.1971083-5-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507150345.1971083-1-bigunclemax@gmail.com>
References: <20230507150345.1971083-1-bigunclemax@gmail.com>
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

These SoCs has two SPI controllers. One of it is quite similar to previous
ones, but with internal clock divider removed; the other added MIPI DBI
Type-C offload based on the first one.

Add basical support for these controllers. As we're not going to
support the DBI functionality now, just implement the two kinds of
controllers as the same.

Co-developed-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/spi/spi-sun6i.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index e4efab310469..02a3a4f2b3a0 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -738,9 +738,17 @@ static const struct sun6i_spi_cfg sun8i_h3_spi_cfg = {
 	.has_clk_ctl	= true,
 };
 
+static const struct sun6i_spi_cfg sun50i_r329_spi_cfg = {
+	.fifo_depth	= SUN8I_FIFO_DEPTH,
+};
+
 static const struct of_device_id sun6i_spi_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-spi", .data = &sun6i_a31_spi_cfg },
 	{ .compatible = "allwinner,sun8i-h3-spi",  .data = &sun8i_h3_spi_cfg },
+	{
+		.compatible = "allwinner,sun50i-r329-spi",
+		.data = &sun50i_r329_spi_cfg
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun6i_spi_match);
-- 
2.39.2

