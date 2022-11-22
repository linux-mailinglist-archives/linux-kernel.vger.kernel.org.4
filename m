Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A2F6331F8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiKVBJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiKVBJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:09:17 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEC2554EC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:08:14 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id me22so15793953ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8Z/CuSU+65/xoefFvoUYNSAqkT5w7zFjiS9CzpEsgo=;
        b=khl3j/XE7m0EGnorZA5Q3DsiTbyoBwHi5GUL7KsN5WlbQ+h1lY66BGMbM+GhD9kaMz
         u47U0zrTL0kvn7kfYNZRORwbSPyXy0piyY8zcGPxNckS1lhvn6VR8nu13RnVQQ0XbgmN
         0KI3ZRrknYNP6Oh7kYy/xVEcCuU+e6yxPxPfz1P9vEm2T4Rn+GdfM6OOPnRXK6UTo8LN
         SDHXV/U2xOlAaiu0s8kV6f0i6hk1zkL1yaJU4GlQFS61EyqKe7kZa+nux6/RbpzqoF7d
         2y37q0+hcsMmpuWIk/qYoT/rFdaz1C3009x2XE7O/z6IaXZpW/GlAGBWwCjFFYvGP2ZR
         mnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8Z/CuSU+65/xoefFvoUYNSAqkT5w7zFjiS9CzpEsgo=;
        b=KH9i7Wo3DhxvV9qM9SjyV6qpWcm9IoUPlQXE/pful5OloTVU1gJnoCIARXVSt6fV5w
         H2z/r1eEa+1JhPr6+8MN0zzl1UuE+4OpNK8wO3Z+7WBe/wnk+QjjnR9sETUMtnn2x1LD
         dn0nNDmtauODawcXYZc/6hjdmdPlI8Lvdg/cA+16RZBGhlTu4SQ5/T806wXOz+Fql3vg
         SCd+n83bll0+00ELzjp7nC/4kBa4IwPxtCiuA8pP9tSD2JD0gJYQh8JFlS84vmQ+cguZ
         RSsPdJGK2m1tLmtY9PJkXLP9lDesdjsnLx8oQ+8v1KewOQny4ZVsUz+rAZc7vTd4Wn+2
         aGdQ==
X-Gm-Message-State: ANoB5pl9HYUIl+iE+AAxxcKwuZ91j8drCGUs1aOQAKNEUp82VbXkDCh7
        oYFW4xKuYY6wemqc4J9qt6K+OA==
X-Google-Smtp-Source: AA0mqf7Go5aHljXna58A3ki2BugYv1A9YAbDkmIxbJqzeq58ZihN3W52HFeTXtwAFk/yPKe8S3aGLQ==
X-Received: by 2002:a17:906:1ecf:b0:7ad:902c:d1d6 with SMTP id m15-20020a1709061ecf00b007ad902cd1d6mr6197186ejj.143.1669079293135;
        Mon, 21 Nov 2022 17:08:13 -0800 (PST)
Received: from c64.fritz.box ([2a01:2a8:8108:8301:7643:bec8:f62b:b074])
        by smtp.gmail.com with ESMTPSA id f13-20020a1709064dcd00b007030c97ae62sm5514683ejw.191.2022.11.21.17.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 17:08:12 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     devicetree@vger.kernel.org
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        krzysztof.kozlowski@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com
Subject: [PATCH v2 6/7] ARM: dts: mediatek: Remove pins-are-numbered property
Date:   Tue, 22 Nov 2022 02:07:52 +0100
Message-Id: <20221122010753.3126828-7-bero@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122010753.3126828-1-bero@baylibre.com>
References: <20221122010753.3126828-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

