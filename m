Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782CB6F94ED
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 01:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjEFX1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 19:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjEFX1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 19:27:39 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB8F1A1E6;
        Sat,  6 May 2023 16:27:31 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f19ab994ccso31812695e9.2;
        Sat, 06 May 2023 16:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683415649; x=1686007649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sz+u5N4kcArj/4/4O+XvKmG7yrDykhccEDf8daX3ZbA=;
        b=h0dREcW8aiCUpfPiBMA01W4AdvM5HxHH/X9SFFeYN3dxrTbGzf0w02Zj9XIrp0vhF+
         g3ONrCGrCxn/6Y/0PXq0G3apgo70GDqhEV5N9hl5w2EMlZ5vK0JF3t4oRB0w+Xg/RdY7
         /kF3K2gtDGYpZOse3BHg/uGTr+JO7kfEXw2cD3t6hhIciKANHnaxih6+xtIzMGJVUF8w
         b4N07hxDVc56sS/xQFJL7Kh+yYMbv+xV6uymxdH3V+ihcRno+wARarxt/Acjro2pDOPv
         PeI/CZF/SdhA0qynwWViNElbAupMJGd0LOCSWSsMXMasdCwzb4LGf/WtkxfYYWpBAHu3
         hL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683415649; x=1686007649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sz+u5N4kcArj/4/4O+XvKmG7yrDykhccEDf8daX3ZbA=;
        b=Eh+SZXCNvuB6pflHwfo4FFSjs+AOxrms0eoaneFmfYEjcs+JbUA9OKU/lMrYALNAyG
         34zMVDwdhm365VOOluQwPp2MgiGeuzM3oxIj+FXccZVgSs/ypoXYUacZa8+tqzE7WPRP
         LGTFlw8NYtzQASya3eEkTpdv3048VZTH8XiQ2wcuOP5MRNn4g5KDv+X8hQn7RAo7riji
         J2JgoYbv+0OjzxOT2YSbGS09YD0LkgQiFbVFkPkN0sgvlqHQU4T1d+PJs/3ELuG3HoZA
         jjx6YfW5QifNvhyPnOF46vZg+mHOuOIP54L9THr7bMZz0azAaxuFZ6/tZOtmtukfSwWH
         CqBA==
X-Gm-Message-State: AC+VfDzJW3AWdSFqdGEIxjPLgeMPGh7W8c675vyVv6RgwKP1ZtJOOLSK
        e97hDTOj82fJC/JqZCJHXJt8EZahgEAwIQ==
X-Google-Smtp-Source: ACHHUZ558Vn2BHGt7HPcyoo/dxzfQ/bcKey8DMqGxSRedZ+6NdT67o63GCejna/hoVRU+xuhhRs00Q==
X-Received: by 2002:a1c:7712:0:b0:3f4:1dd9:e9e0 with SMTP id t18-20020a1c7712000000b003f41dd9e9e0mr1526884wmi.7.1683415648950;
        Sat, 06 May 2023 16:27:28 -0700 (PDT)
Received: from localhost.localdomain ([176.221.215.212])
        by smtp.gmail.com with ESMTPSA id p4-20020a1c7404000000b003f1739a0116sm12098655wmc.33.2023.05.06.16.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 16:27:28 -0700 (PDT)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 3/5] spi: sun6i: add quirk for in-controller clock divider
Date:   Sun,  7 May 2023 02:26:06 +0300
Message-Id: <20230506232616.1792109-4-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230506232616.1792109-1-bigunclemax@gmail.com>
References: <20230506232616.1792109-1-bigunclemax@gmail.com>
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

Previously SPI controllers in Allwinner SoCs has a clock divider inside.
However now the clock divider is removed and to set the transfer clock
rate it's only needed to set the SPI module clock to the target value
and configure a proper work mode.

According to the datasheet there are three work modes:

| SPI Sample Mode         | SDM(bit13) | SDC(bit11) | Run Clock |
|-------------------------|------------|------------|-----------|
| normal sample           |      1     |      0     | <= 24 MHz |
| delay half cycle sample |      0     |      0     | <= 40 MHz |
| delay one cycle sample  |      0     |      1     | >= 80 MHz |

Add a quirk for this kind of SPI controllers.

Co-developed-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/spi/spi-sun6i.c | 92 +++++++++++++++++++++++++++--------------
 1 file changed, 62 insertions(+), 30 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 01a01cd86db5..1e9e9a8159d9 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -42,7 +42,9 @@
 #define SUN6I_TFR_CTL_CS_MANUAL			BIT(6)
 #define SUN6I_TFR_CTL_CS_LEVEL			BIT(7)
 #define SUN6I_TFR_CTL_DHB			BIT(8)
+#define SUN6I_TFR_CTL_SDC			BIT(11)
 #define SUN6I_TFR_CTL_FBS			BIT(12)
+#define SUN6I_TFR_CTL_SDM			BIT(13)
 #define SUN6I_TFR_CTL_XCH			BIT(31)
 
 #define SUN6I_INT_CTL_REG		0x10
@@ -87,6 +89,7 @@
 
 struct sun6i_spi_cfg {
 	unsigned long		fifo_depth;
+	bool			has_clk_ctl;
 };
 
 struct sun6i_spi {
@@ -260,7 +263,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 				  struct spi_transfer *tfr)
 {
 	struct sun6i_spi *sspi = spi_master_get_devdata(master);
-	unsigned int mclk_rate, div, div_cdr1, div_cdr2, timeout;
+	unsigned int div, div_cdr1, div_cdr2, timeout;
 	unsigned int start, end, tx_time;
 	unsigned int trig_level;
 	unsigned int tx_len = 0, rx_len = 0;
@@ -350,39 +353,66 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 
 	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);
 
-	/* Ensure that we have a parent clock fast enough */
-	mclk_rate = clk_get_rate(sspi->mclk);
-	if (mclk_rate < (2 * tfr->speed_hz)) {
-		clk_set_rate(sspi->mclk, 2 * tfr->speed_hz);
-		mclk_rate = clk_get_rate(sspi->mclk);
-	}
+	if (sspi->cfg->has_clk_ctl) {
+		unsigned int mclk_rate = clk_get_rate(sspi->mclk);
 
-	/*
-	 * Setup clock divider.
-	 *
-	 * We have two choices there. Either we can use the clock
-	 * divide rate 1, which is calculated thanks to this formula:
-	 * SPI_CLK = MOD_CLK / (2 ^ cdr)
-	 * Or we can use CDR2, which is calculated with the formula:
-	 * SPI_CLK = MOD_CLK / (2 * (cdr + 1))
-	 * Wether we use the former or the latter is set through the
-	 * DRS bit.
-	 *
-	 * First try CDR2, and if we can't reach the expected
-	 * frequency, fall back to CDR1.
-	 */
-	div_cdr1 = DIV_ROUND_UP(mclk_rate, tfr->speed_hz);
-	div_cdr2 = DIV_ROUND_UP(div_cdr1, 2);
-	if (div_cdr2 <= (SUN6I_CLK_CTL_CDR2_MASK + 1)) {
-		reg = SUN6I_CLK_CTL_CDR2(div_cdr2 - 1) | SUN6I_CLK_CTL_DRS;
-		tfr->effective_speed_hz = mclk_rate / (2 * div_cdr2);
+		/* Ensure that we have a parent clock fast enough */
+		if (mclk_rate < (2 * tfr->speed_hz)) {
+			clk_set_rate(sspi->mclk, 2 * tfr->speed_hz);
+			mclk_rate = clk_get_rate(sspi->mclk);
+		}
+
+		/*
+		 * Setup clock divider.
+		 *
+		 * We have two choices there. Either we can use the clock
+		 * divide rate 1, which is calculated thanks to this formula:
+		 * SPI_CLK = MOD_CLK / (2 ^ cdr)
+		 * Or we can use CDR2, which is calculated with the formula:
+		 * SPI_CLK = MOD_CLK / (2 * (cdr + 1))
+		 * Whether we use the former or the latter is set through the
+		 * DRS bit.
+		 *
+		 * First try CDR2, and if we can't reach the expected
+		 * frequency, fall back to CDR1.
+		 */
+		div_cdr1 = DIV_ROUND_UP(mclk_rate, tfr->speed_hz);
+		div_cdr2 = DIV_ROUND_UP(div_cdr1, 2);
+		if (div_cdr2 <= (SUN6I_CLK_CTL_CDR2_MASK + 1)) {
+			reg = SUN6I_CLK_CTL_CDR2(div_cdr2 - 1) | SUN6I_CLK_CTL_DRS;
+			tfr->effective_speed_hz = mclk_rate / (2 * div_cdr2);
+		} else {
+			div = min(SUN6I_CLK_CTL_CDR1_MASK, order_base_2(div_cdr1));
+			reg = SUN6I_CLK_CTL_CDR1(div);
+			tfr->effective_speed_hz = mclk_rate / (1 << div);
+		}
+
+		sun6i_spi_write(sspi, SUN6I_CLK_CTL_REG, reg);
 	} else {
-		div = min(SUN6I_CLK_CTL_CDR1_MASK, order_base_2(div_cdr1));
-		reg = SUN6I_CLK_CTL_CDR1(div);
-		tfr->effective_speed_hz = mclk_rate / (1 << div);
+		clk_set_rate(sspi->mclk, tfr->speed_hz);
+		tfr->effective_speed_hz = clk_get_rate(sspi->mclk);
+
+		/*
+		 * Configure work mode.
+		 *
+		 * There are three work modes depending on the controller clock
+		 * frequency:
+		 * - normal sample mode           : CLK <= 24MHz SDM=1 SDC=0
+		 * - delay half-cycle sample mode : CLK <= 40MHz SDM=0 SDC=0
+		 * - delay one-cycle sample mode  : CLK >= 80MHz SDM=0 SDC=1
+		 */
+		reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
+
+		if (tfr->effective_speed_hz <= 24000000)
+			reg |= SUN6I_TFR_CTL_SDM;
+		else if (tfr->effective_speed_hz >= 80000000)
+			reg |= SUN6I_TFR_CTL_SDC;
+		else
+			reg &= ~(SUN6I_TFR_CTL_SDM | SUN6I_TFR_CTL_SDC);
+
+		sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);
 	}
 
-	sun6i_spi_write(sspi, SUN6I_CLK_CTL_REG, reg);
 	/* Finally enable the bus - doing so before might raise SCK to HIGH */
 	reg = sun6i_spi_read(sspi, SUN6I_GBL_CTL_REG);
 	reg |= SUN6I_GBL_CTL_BUS_ENABLE;
@@ -701,10 +731,12 @@ static void sun6i_spi_remove(struct platform_device *pdev)
 
 static const struct sun6i_spi_cfg sun6i_a31_spi_cfg = {
 	.fifo_depth	= SUN6I_FIFO_DEPTH,
+	.has_clk_ctl	= true,
 };
 
 static const struct sun6i_spi_cfg sun8i_h3_spi_cfg = {
 	.fifo_depth	= SUN8I_FIFO_DEPTH,
+	.has_clk_ctl	= true,
 };
 
 static const struct of_device_id sun6i_spi_match[] = {
-- 
2.39.2

