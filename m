Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B035C6F902A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 09:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjEFHd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 03:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjEFHc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 03:32:56 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B4411B6D;
        Sat,  6 May 2023 00:32:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3078c092056so20674f8f.1;
        Sat, 06 May 2023 00:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683358353; x=1685950353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cc4szePKx1X47wb+R4eZfAu1BbHj1cJ7EQ+8XaS2XQU=;
        b=jJmA383HE6SadUuzWkr0Aexf3fnIPKp3FGbn6NUtx4kukFoljCKelXY7NBQZ4fslrm
         rVjI1LL+w02bLpKBuGx7Vvw+i+qUBZi84kFu8sLwmcj8RynSLycyEgBUMZh425IDu21M
         k1aEe8bCQ+I9UNOMCxD9K9T/Jo9xb8HtFwp/51yjDt4scSY180My623vn9qtvOtbXVyT
         V+T/ZXVr1ND9qmgXdO7m20L2Iz7k0ju0YxdBVdsSAPO6O4elXWy/8zRU0Jdj3F/6bKCH
         PXSUr7XUUftdYfOpcHE36/KbgMwU7X8R2soYMRhXBTjtqpDJEoT5NPOuEAXfah9R28xl
         JTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683358353; x=1685950353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cc4szePKx1X47wb+R4eZfAu1BbHj1cJ7EQ+8XaS2XQU=;
        b=RlqjqfCbao6LcEn93dYOaIC/9X9oGwZ0DKh+YH0Rn+bQvCThbnnQaZ3lg93K3KetCx
         7Zf1jJLn3MkEVBtap2AS7NRKdzopY7OJwm4yAuQo1c0cyZfaqA4oC2QLp/Ox06RXE3oq
         RSlMcao19U0zcw6b/Esj+k+9HEC+mDc1Kn5Q3Kd15R8xOhZZubd7EuHEDd31cRjTKO5P
         Qqwf80nakRoiyX2cvVZgZLRLLvfMOCqMmqoJIhJTWvGbj0Ijec/4Te90BH7bH/hX+9Ye
         qAwQ7F61hni+mawJvHz3LZ+4x1jsp6qve1jfHlZek33ZJksaMNmZ3yLD67FOvx3vJyvL
         6Cmw==
X-Gm-Message-State: AC+VfDx9aLqp+i9oRnmr8FVhoTRNs9+5L1QmE35QcX2CVDhKeUD2/LX+
        YHJXuKMw9xnkzoWCDCYS9fU=
X-Google-Smtp-Source: ACHHUZ7iKNMgiA6FrTO13Wh1jcfSYOwc7z8ztUbs82d23I9cVn3y0WpeoXY7leOX/h1s07PE72rZmA==
X-Received: by 2002:adf:e6cd:0:b0:307:886f:fac1 with SMTP id y13-20020adfe6cd000000b00307886ffac1mr692505wrm.35.1683358353148;
        Sat, 06 May 2023 00:32:33 -0700 (PDT)
Received: from localhost.localdomain ([176.221.215.212])
        by smtp.gmail.com with ESMTPSA id q14-20020a7bce8e000000b003f182a10106sm10071944wmj.8.2023.05.06.00.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 00:32:32 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>, Mark Brown <broonie@kernel.org>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 4/6] spi: sun6i: add support for R329 SPI controllers
Date:   Sat,  6 May 2023 10:30:12 +0300
Message-Id: <20230506073018.1411583-5-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230506073018.1411583-1-bigunclemax@gmail.com>
References: <20230506073018.1411583-1-bigunclemax@gmail.com>
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

From: Icenowy Zheng <icenowy@aosc.io>

R329 has two SPI controllers. One of it is quite similar to previous
ones, but with internal clock divider removed; the other added MIPI DBI
Type-C offload based on the first one.

Add basical support for these controllers. As we're not going to
support the DBI functionality now, just implement the two kinds of
controllers as the same.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/spi/spi-sun6i.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 82523011a3a5..fe287a45df9b 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -715,9 +715,21 @@ static const struct sun6i_spi_cfg sun8i_h3_spi_cfg = {
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
+	{
+		.compatible = "allwinner,sun50i-r329-spi-dbi",
+		.data = &sun50i_r329_spi_cfg
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun6i_spi_match);
-- 
2.39.2

