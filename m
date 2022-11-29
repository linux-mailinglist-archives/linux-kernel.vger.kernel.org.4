Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A72E63B803
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 03:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbiK2Ce0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 21:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbiK2CeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 21:34:11 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6136342F4B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 18:34:10 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z18so17943651edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 18:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8Z/CuSU+65/xoefFvoUYNSAqkT5w7zFjiS9CzpEsgo=;
        b=TGMnn46CtKmUg45vARZzI+l7g+wJRHX66iFsaESAYfjUreGPhFtBLMrWSVfN8NhQ4R
         EAj8tu1adlY/+N+IFytx6V0pihxUb6rgNkgIhvtEo674brpFnW8vfu7xWJWALL7JtLUM
         OZXaJyvSkMWjBQ2HcTY+/T07EugndtdyOxTAW0ahTze1Z1ZNQvMemygppjQcVhQOBPuT
         WOFzgajTZrV5D4fqhH9WxOTtL5J8mKkhErGwFwJGcuD/SA5SkPVzJt7TTz5oj9QP4Y7A
         poSLVkvYcplY4mgCj0z6tYrs6Oz9E+2nack2BY3eemkJ0u8yVzJbo+mcpjR/U7k+gUId
         CXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8Z/CuSU+65/xoefFvoUYNSAqkT5w7zFjiS9CzpEsgo=;
        b=fjAheyIbAmDvmP+yyi4IRxLnFMJ1Nu9xBgbSTUiy+J2XBZa2sYBBOjDy/iPn9E1G2w
         pOIjJFYFShkqyDAo2GuK8JUC3JN3gyVPNJnxEF+JW2DFc/U+b+4VNRhiIIaISjyJo0+u
         DR5hWNETjzib8+B1wcC09aXemWn/p7d+nghsKBlsJPd0/iPicmYudxYqfpvx6AhPo+fg
         9UnrJu2QnYfp6WEqJHtXj32pyZxxR9sNzraInNLUBF4qdV3JgrXCcL3ah5ohRqm1Y0Ml
         NXaqfrTrYLsRZsEpCEkSTQ90UOfS4owl6UbPbJSbqJgS23nP/TnuOBIecdgmvJTNYmEq
         M3HQ==
X-Gm-Message-State: ANoB5pm4hu9pBG/smR+9dEyGIqfs2Vz4iR1YPxFMoR2zi2FFFcOgpVin
        2+jExo6RcKHYjbtdZotA3gO01g==
X-Google-Smtp-Source: AA0mqf60o5tLbeI6S6dpTLzC6o649BcnNTqez9gWqoEhygiGGK9mOCHndjEEV+VdcPsGK1nhuiq4LQ==
X-Received: by 2002:a05:6402:3707:b0:467:6847:83d3 with SMTP id ek7-20020a056402370700b00467684783d3mr10333472edb.247.1669689249014;
        Mon, 28 Nov 2022 18:34:09 -0800 (PST)
Received: from c64.fritz.box ([81.221.122.240])
        by smtp.gmail.com with ESMTPSA id a4-20020aa7d744000000b004615f7495e0sm5733817eds.8.2022.11.28.18.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 18:34:08 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     devicetree@vger.kernel.org
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        krzysztof.kozlowski@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org
Subject: [PATCH v3 6/7] ARM: dts: mediatek: Remove pins-are-numbered property
Date:   Tue, 29 Nov 2022 03:34:00 +0100
Message-Id: <20221129023401.278780-7-bero@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221129023401.278780-1-bero@baylibre.com>
References: <20221129023401.278780-1-bero@baylibre.com>
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

