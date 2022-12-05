Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70936429E6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiLENwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiLENwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:52:13 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E33511C15
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 05:52:12 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i131-20020a1c3b89000000b003d1cb516ce0so2370116wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 05:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M8Z/CuSU+65/xoefFvoUYNSAqkT5w7zFjiS9CzpEsgo=;
        b=wsgdxTuhatf3mw1TVkJQeXcqLfocJhxhj74YDevQF9YeRF3dfceSwSOa7IojVzyb7L
         B5YvTchNNBM8QERb8Z7fZ00Jr+oRZR0N/NuKpDCFANoDerZjz9ZdYHt82uWhTHHbAOCQ
         vXVW0fi+9ldGrDVOsSuL8bIFpJXG8/m/TfObyMHBcJ8DmBJ1sTkaZf1o5lOuo3ghvqsi
         ZPcAfUwmTSACNF3BiQwmC2Prh5kU/b4NT3DCQd1ANXM4wBVZdEuaevnv+aFsnxuVEiWy
         ebRpiQCTG3e/og2yEhXh3KrXQQVDdzNur2s96I56dkMdMoZRBpPh53XbFOQXhbNr8WYf
         clNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8Z/CuSU+65/xoefFvoUYNSAqkT5w7zFjiS9CzpEsgo=;
        b=jfG98bWoM6AQpzEGF77sfw6SxclxDz7rFtU0nIUApuDS5vzdPtg2rfatAZbDB9rFNr
         yy+2Uz4j/Wqt+8yf2QnRMMT8OjlovMUPOUrS5pY3BXdgYpuKvarD4zlLha9m7kq6armB
         A9oz4R2gMV9uLCGbZnV/V1QOtOtel4J66wZw3jP9eHL3wHIMs3+e2jSNGtzvKxcm8aQi
         C4sO+rwEUfUO+mCvWgwP8DtcV1ZBX+XYN2LMPkIN0rGY7yMisUADGI6Rxug6lP0daU9G
         sjs6pRQPhT2GW3G/+/yb+jr0MHizRZSNzbzNkVShE/wDnBT5gjplfvrO7Vge4bC5t0i7
         wjCw==
X-Gm-Message-State: ANoB5pmlu+lD4yjRZ5CYKNdcW9AOga49R0FBRCDkicqHx6RzuP977IYp
        8vUEJajm7+w2jUavcacKcxRrRg==
X-Google-Smtp-Source: AA0mqf52PvQXYzT5vaPuTGBXNCz91Q2KV0iCLC9fNEbt3klSJRTAtpx67PD5xqTxQIpCyNL0zdkknw==
X-Received: by 2002:a05:600c:350a:b0:3d0:74be:a059 with SMTP id h10-20020a05600c350a00b003d074bea059mr16204523wmq.177.1670248330589;
        Mon, 05 Dec 2022 05:52:10 -0800 (PST)
Received: from predatorhelios.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a3-20020adffac3000000b0024245e543absm9012700wrs.88.2022.12.05.05.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 05:52:10 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        krzysztof.kozlowski@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com,
        linux-gpio@vger.kernel.org
Subject: [PATCH v4 2/3] ARM: dts: mediatek: Remove pins-are-numbered property
Date:   Mon,  5 Dec 2022 14:51:57 +0100
Message-Id: <20221205135158.1842465-3-bero@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221205135158.1842465-1-bero@baylibre.com>
References: <20221205135158.1842465-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unnecessary pins-are-numbered property from
Mediatek ARM DeviceTrees

Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/boot/dts/mt2701.dtsi | 1 -
 arch/arm/boot/dts/mt7623.dtsi | 1 -
 arch/arm/boot/dts/mt8135.dtsi | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index b8eba3ba153c2..0a0fe8c5a4059 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -178,7 +178,6 @@ pio: pinctrl@1000b000 {
 		compatible = "mediatek,mt2701-pinctrl";
 		reg = <0 0x1000b000 0 0x1000>;
 		mediatek,pctl-regmap = <&syscfg_pctl_a>;
-		pins-are-numbered;
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 25d31e40a5535..11379c3e6b4ca 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -253,7 +253,6 @@ pio: pinctrl@10005000 {
 		compatible = "mediatek,mt7623-pinctrl";
 		reg = <0 0x1000b000 0 0x1000>;
 		mediatek,pctl-regmap = <&syscfg_pctl_a>;
-		pins-are-numbered;
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
index a031b36363187..0f291ad22d3af 100644
--- a/arch/arm/boot/dts/mt8135.dtsi
+++ b/arch/arm/boot/dts/mt8135.dtsi
@@ -152,7 +152,6 @@ pio: pinctrl@10005000 {
 			compatible = "mediatek,mt8135-pinctrl";
 			reg = <0 0x1000b000 0 0x1000>;
 			mediatek,pctl-regmap = <&syscfg_pctl_a &syscfg_pctl_b>;
-			pins-are-numbered;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-- 
2.38.1

