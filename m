Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C852F677F66
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjAWPRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjAWPQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:16:33 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFA529E15
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:16:04 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k16so9278941wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dk48DflEVPiNMsVzVHmXNv30f/nbEuFRGIrA+z9bojU=;
        b=Lm0zuZbBNeFiRpfVxHnilWlEBdstocfP0ZUoo1h4TjfmWVxoHWL23rz3qgQSjbPk07
         UTHn3cRigu62z3al1Bhh7ja7LrXK7NwqYtlUhbrqfurOOGYFuvoq0pRRQMbrIyKSI8PY
         SSQFv4Qlnn3FRcrp4NvQg82hfONFxxwXMuxGhqF8JGf19hZLpqVErxCEQUKwuSQeSoHy
         T9+/ssbY1s+/dgkWcbzHGWxA7eoaz0jPK2tiV6LH0DamB3MuNgugkCKWTL92TNh5cuve
         YBcpu4iH1iJzcNSDm92l9cKg5pimlLSurFmE7A9sIQcBVBrJI8LO6Hpr7GJ+W0gvJUZA
         7OoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dk48DflEVPiNMsVzVHmXNv30f/nbEuFRGIrA+z9bojU=;
        b=M5NH6+hlKu/IHm2xCZAFRuC9nWa28qg4VY1eStIhJkHOh9dQloySIcyz5SerSgkNv5
         L3nwImySaypjIr5QV3GDEzvRkto4FepwjEcsMD0Ip1l5d4qA09uwczQKD5qVJLafhcjB
         TJml1zxQO4FOamydFBOs5xlwW0G68rPbfwol4LI4ZUUs55MU9v74Np+4N+moZd1oCaPd
         Dt1HXBIS1I8tIGlF0Oggnfews9cBRdjg1fT8vMWA/AdQ9m8Y1kg8hs8WYaZJItU3TrJJ
         iaxP+dOhtkaj1pNyxs+BorwE42dGtHk4G0AI7hyceYthYpTLy/V6cK/yPisZayjR6peu
         Mfhg==
X-Gm-Message-State: AFqh2koyuIYWCoCV33N1FB2Rb2leioGn1yC+W7LNmG/LlQdnRDsEgD7g
        Gb8b5LWRyNkjRdlmH4dz6eFLbg==
X-Google-Smtp-Source: AMrXdXvFKtH7040cCjx3S3DGoY8HiOQQa/YwSelxFXYs+4kkB5h8I6yzKkTdGnsFV02heZgxBmp5aw==
X-Received: by 2002:a05:600c:3ba9:b0:3da:b40f:7a55 with SMTP id n41-20020a05600c3ba900b003dab40f7a55mr30678998wms.6.1674486961934;
        Mon, 23 Jan 2023 07:16:01 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h11-20020a05600c314b00b003db0f4e12c8sm11772532wmo.34.2023.01.23.07.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:16:01 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: imx8q: use generic node name for rave-sp
Date:   Mon, 23 Jan 2023 16:15:55 +0100
Message-Id: <20230123151555.369881-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123151555.369881-1-krzysztof.kozlowski@linaro.org>
References: <20230123151555.369881-1-krzysztof.kozlowski@linaro.org>
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

Use generic "mcu" node name for rave-sp node, as recommended by
Devicetree specification.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
index 4e05120c62d4..2698920f1415 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
@@ -490,7 +490,7 @@ &uart2 {
 	pinctrl-0 = <&pinctrl_uart2>;
 	status = "okay";
 
-	rave-sp {
+	mcu {
 		compatible = "zii,rave-sp-rdu2";
 		current-speed = <1000000>;
 		#address-cells = <1>;
-- 
2.34.1

