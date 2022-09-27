Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A8D5EBC61
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiI0H6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiI0H4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:56:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B88AE84E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:56:05 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n10so13634701wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=U4G0XoR4OtiRi5wvEtvdLd6HFOllsQWXwedib2I2XRI=;
        b=FwA/ieJr1TKaFR5LKDFY3s/yBX9tqhQuaKMyBWipgkHFDq7GRX86eJR+E8pqtJo1BT
         kn7z6ZZ/UqUhsY15DfOPzk+URV1Q+A5t1IIRx0VcQfBMdEbxMgN5TDtQtcM5/jLr4XTs
         I45DCRQ1uGVsFf7dSz7biWKsa5VhZy9ZImpKkceMUGXjeyJVTY5svF8K2InJdrQP8Yy/
         TnYbEeR7fiq1RyWPNBkGuABBNRwQFVA6a84V6VuuZwJuMrZdHe7iqAejUUcYeqtRwe1m
         JnCkshPDYzzlwmdxy9zAq+aC/9jzUIX6ofBxSr2TaXuFpJhLMxeYhhG5kL3SlV0RMnDr
         K20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=U4G0XoR4OtiRi5wvEtvdLd6HFOllsQWXwedib2I2XRI=;
        b=TvOIUW5wE/Ka8b7IkLm11iIp6CgS+P5/Ht8oznbIPQXVImuiPkaI63Zco8CiUtm/LI
         xqP1NPY+iwtpCzNtEZbt2yD+lDdrxzpUC3wt8wtESaXgsRp7YBYbzxTo7RLPQpSdeb1R
         CZ5cgB5Mfd0+lr0iDhdLn3LyaAzuUxutIq8Kfz2OU0GiPO6irKvdyxM0OcSHtDuiHI8U
         G9BzhLJUO1qCv/mbV0l+6/no04PS8iI6/RJ0MLzG2pWkfLe5G6YTemnvtQNi4VQ4JX75
         bLHV4nyADpJicKXUyM8NugQgyHbjYdrppCaAS0MqXQjJPNvPjOCJelWmh1T6XsVIqgrY
         mk2Q==
X-Gm-Message-State: ACrzQf2u48+PjC2snLa9/4gicrOO5e06InOicbYfdttGvKgaRfMMJRTk
        ZkVSJ3vmv3qGe2P4iDMR2wxCJA==
X-Google-Smtp-Source: AMsMyM72xxcbDl2X+QT2Is3zqpSPwfG5om66b6BrUcHJHVTz8wEZCd6Saf9lq9jbqFld0R5E753rNg==
X-Received: by 2002:a5d:45c4:0:b0:228:9248:867d with SMTP id b4-20020a5d45c4000000b002289248867dmr15858905wrs.474.1664265365119;
        Tue, 27 Sep 2022 00:56:05 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x8-20020adfdcc8000000b0022afbd02c69sm1076654wrm.56.2022.09.27.00.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 00:56:04 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, ardb@kernel.org, davem@davemloft.net,
        herbert@gondor.apana.org.au, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v10 28/33] arm64: dts: rockchip: rk3399: add crypto node
Date:   Tue, 27 Sep 2022 07:55:06 +0000
Message-Id: <20220927075511.3147847-29-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220927075511.3147847-1-clabbe@baylibre.com>
References: <20220927075511.3147847-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk3399 has a crypto IP handled by the rk3288 crypto driver so adds a
node for it.

Tested-by Diederik de Haas <didi.debian@cknow.org>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 92c2207e686c..4391aea25984 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -582,6 +582,26 @@ saradc: saradc@ff100000 {
 		status = "disabled";
 	};
 
+	crypto0: crypto@ff8b0000 {
+		compatible = "rockchip,rk3399-crypto";
+		reg = <0x0 0xff8b0000 0x0 0x4000>;
+		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru HCLK_M_CRYPTO0>, <&cru HCLK_S_CRYPTO0>, <&cru SCLK_CRYPTO0>;
+		clock-names = "hclk_master", "hclk_slave", "sclk";
+		resets = <&cru SRST_CRYPTO0>, <&cru SRST_CRYPTO0_S>, <&cru SRST_CRYPTO0_M>;
+		reset-names = "master", "lave", "crypto";
+	};
+
+	crypto1: crypto@ff8b8000 {
+		compatible = "rockchip,rk3399-crypto";
+		reg = <0x0 0xff8b8000 0x0 0x4000>;
+		interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru HCLK_M_CRYPTO1>, <&cru HCLK_S_CRYPTO1>, <&cru SCLK_CRYPTO1>;
+		clock-names = "hclk_master", "hclk_slave", "sclk";
+		resets = <&cru SRST_CRYPTO1>, <&cru SRST_CRYPTO1_S>, <&cru SRST_CRYPTO1_M>;
+		reset-names = "master", "slave", "crypto";
+	};
+
 	i2c1: i2c@ff110000 {
 		compatible = "rockchip,rk3399-i2c";
 		reg = <0x0 0xff110000 0x0 0x1000>;
-- 
2.35.1

