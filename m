Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94CA6EB4CF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 00:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbjDUWcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 18:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbjDUWbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:31:55 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB4F3A86
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:31:52 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-95316faa3a8so376754966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682116310; x=1684708310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7v4mG2PrvGHT4HWW2aD7kz/Jo5VqruKafQcmH0GEdHQ=;
        b=LRwxYnYte61pFMXBNA4fGK8jUs7j4rOkyOV4DdeP+ttViOoqcp1tzRcSM8sa6ZXXhX
         vhWQAmT5hkJY2mOlU7tXY5f/L/K/EhmJJrJrZ4+133xDbLq8LjeQ5pIfF+PvofBirVJ6
         bC59k8XvlJTnxagd5d1KHmr826EoFOSYDtlUPT12aCyD5RNHsKsg3vG7wPuvougchO8p
         0ZoczI3MB6arJx/H5gLkYcuv3bqEBBGwuz5XsLPqaSbQVmoI5anSkmBjrMQWKK47VdJw
         B6W++SAaY+DJSV8Z2ZCU7l0i2h7Qck4sB4jUnR24mbutUri2h/jAGjXx/ihbfCO7M3pU
         Elbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682116310; x=1684708310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7v4mG2PrvGHT4HWW2aD7kz/Jo5VqruKafQcmH0GEdHQ=;
        b=PhOJa0WxVRl4F9H1PWGvowRnqNeBZ50V3WuWVDdQDXON4eZpPWaCGpIeX2VlCXurO8
         l2q40fFRvevKX4XDXEFXPiwPLcQY7tCDC57OVL5y2XHXPaEQzGoRH6d97F/KpjZD6/yz
         /JcWEQjQspe62Y5O0Oax3TmMK4AcFNy3Tzy50kN85fWEPU2UN5zLueIH7ciIdXZZxWN8
         zf7kYomzqrjo5iVGlQIQtGcdjoYLNsHlluUQ0rCZuESBQDGjh32S2DVsqHiXFM8BGoMT
         T58XhbTOFYKPxkOHP0geR8axpPKje0xXmtn8o4vu1bPSQaDLnUB1EOyQ+zsWPJihTUGs
         /cGg==
X-Gm-Message-State: AAQBX9foYEBJldajcSH0mpWaNNsk22stPqfMaMzp8WLtJWTCxD9GOCNb
        98q66VyJiWa/Wy5Td0kxXbLjRCWkEM5hw/UwXaVK8w==
X-Google-Smtp-Source: AKy350ZToStdpI3/6McxwF83TbNvU0TpEGKWh9SGPOim56WxkraHbbPATz3MtaW9Xt/+n4pzC+JJtg==
X-Received: by 2002:a17:907:7845:b0:957:12b7:30b0 with SMTP id lb5-20020a170907784500b0095712b730b0mr3566568ejc.18.1682116310636;
        Fri, 21 Apr 2023 15:31:50 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:687d:8c5:41cb:9883])
        by smtp.gmail.com with ESMTPSA id aa21-20020a170907355500b00957dad777c1sm308173ejc.107.2023.04.21.15.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 15:31:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: rockchip: add missing cache properties
Date:   Sat, 22 Apr 2023 00:31:48 +0200
Message-Id: <20230421223149.115185-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As all level 2 and level 3 caches are unified, add required
cache-unified properties to fix warnings like:

  rk3588s-khadas-edge2.dtb: l3-cache: 'cache-unified' is a dependency of 'cache-size'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Please take the patch via sub-arch SoC tree.
---
 arch/arm64/boot/dts/rockchip/rk3308.dtsi  | 1 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi  | 1 +
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 9 +++++++++
 3 files changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index dd228a256a32..2ae4bb7d5e62 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -97,6 +97,7 @@ CPU_SLEEP: cpu-sleep {
 		l2: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 6d7a7bf72ac7..e729e7a22b23 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -103,6 +103,7 @@ CPU_SLEEP: cpu-sleep {
 		l2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 657c019d27fa..5badc68fe9f0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -230,6 +230,7 @@ l2_cache_l0: l2-cache-l0 {
 			cache-sets = <512>;
 			cache-level = <2>;
 			next-level-cache = <&l3_cache>;
+			cache-unified;
 		};
 
 		l2_cache_l1: l2-cache-l1 {
@@ -239,6 +240,7 @@ l2_cache_l1: l2-cache-l1 {
 			cache-sets = <512>;
 			cache-level = <2>;
 			next-level-cache = <&l3_cache>;
+			cache-unified;
 		};
 
 		l2_cache_l2: l2-cache-l2 {
@@ -248,6 +250,7 @@ l2_cache_l2: l2-cache-l2 {
 			cache-sets = <512>;
 			cache-level = <2>;
 			next-level-cache = <&l3_cache>;
+			cache-unified;
 		};
 
 		l2_cache_l3: l2-cache-l3 {
@@ -257,6 +260,7 @@ l2_cache_l3: l2-cache-l3 {
 			cache-sets = <512>;
 			cache-level = <2>;
 			next-level-cache = <&l3_cache>;
+			cache-unified;
 		};
 
 		l2_cache_b0: l2-cache-b0 {
@@ -266,6 +270,7 @@ l2_cache_b0: l2-cache-b0 {
 			cache-sets = <1024>;
 			cache-level = <2>;
 			next-level-cache = <&l3_cache>;
+			cache-unified;
 		};
 
 		l2_cache_b1: l2-cache-b1 {
@@ -275,6 +280,7 @@ l2_cache_b1: l2-cache-b1 {
 			cache-sets = <1024>;
 			cache-level = <2>;
 			next-level-cache = <&l3_cache>;
+			cache-unified;
 		};
 
 		l2_cache_b2: l2-cache-b2 {
@@ -284,6 +290,7 @@ l2_cache_b2: l2-cache-b2 {
 			cache-sets = <1024>;
 			cache-level = <2>;
 			next-level-cache = <&l3_cache>;
+			cache-unified;
 		};
 
 		l2_cache_b3: l2-cache-b3 {
@@ -293,6 +300,7 @@ l2_cache_b3: l2-cache-b3 {
 			cache-sets = <1024>;
 			cache-level = <2>;
 			next-level-cache = <&l3_cache>;
+			cache-unified;
 		};
 
 		l3_cache: l3-cache {
@@ -301,6 +309,7 @@ l3_cache: l3-cache {
 			cache-line-size = <64>;
 			cache-sets = <4096>;
 			cache-level = <3>;
+			cache-unified;
 		};
 	};
 
-- 
2.34.1

