Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CF7745014
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 20:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjGBSyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 14:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjGBSyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 14:54:03 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7724F103
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 11:53:39 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-98e39784a85so665882066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 11:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688324010; x=1690916010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yr057d23zYvecpNmrqhCxLjU9O8Fn3+fuNRTaa2YGv0=;
        b=iiODBNn2jqns3pOHhYdgkUKeuJz8oqa/oBgcWNN1RJIXDHMv0yzgP2L00vBZuPdQkx
         aGQHTBbh4f2tfcRqLMvd8wSe+BNUxR8RRF7vY8eaLDs6Z9UQgsEv7wulLHbh9lxmOAjT
         xNwx6LNa7VAUlK/HDp8Ss0uHFqo0gPrQZ7BwGITbn7h79bAvh/lt0ReFttaEr74yzJUF
         8J7BjBEZTqarQGK3DPq5HABan6phPfrC6qO7w8jbYNRreko1NV53WFjmRp1lNnY7Wz/o
         iZtUG4xbov1Tdx9ACnUegUmhbYiLdNv03Ug+WB9urcPMZq10J7FWsbDhhY7d1pIml/Ul
         873Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688324010; x=1690916010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yr057d23zYvecpNmrqhCxLjU9O8Fn3+fuNRTaa2YGv0=;
        b=k6AqlJwwBBykbZdxczikAiRdxupnin94bQeoT8ETjnjXedgQXw2Lc56EYCnB+3TRKu
         VARWNZTpv4utkuFhZmuTzcSLrxtlJxJP1e2S2MM3VLBgESAvAtDld5WHQ2qgG/aC8Z5J
         CAHks4S/2ylKvTeJc/pcEB2Apskg98CW0FosFDhzJbAYYNIffz6W0gbLN6JchDholqtc
         k0rE7h7k7Ape19r9OalGeJ82pznuX1/bK5OETTfNeoqtI3Gd/c2nP2aINEsQa+JaZpnY
         pW+jlzuZMhlu/PwmNAuqJkPuaHro+abK6S0mcCYKzXmRr+z/ZevbIe9fIIu8x914GJen
         ZTpQ==
X-Gm-Message-State: AC+VfDxBo5SGq05bYXUPErSMzJAGnU9QiTOHrtsh2ebpFznHzuefqau7
        k69bxDy0ge7Kvzrcrn9o8KFmQQ==
X-Google-Smtp-Source: ACHHUZ5GDNPNpJjP3txGq0+7mKAIPHM88cY8tFCVfX6obT+NvDBq6J8WWl0W0W27MHZVG5pj8mv/lA==
X-Received: by 2002:a17:907:6e1b:b0:98e:1c4b:10e2 with SMTP id sd27-20020a1709076e1b00b0098e1c4b10e2mr9679391ejc.20.1688324010372;
        Sun, 02 Jul 2023 11:53:30 -0700 (PDT)
Received: from krzk-bin.. ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id bf13-20020a0564021a4d00b0051dfa140947sm2436582edb.61.2023.07.02.11.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 11:53:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: amlogic: minor whitespace cleanup around '='
Date:   Sun,  2 Jul 2023 20:53:27 +0200
Message-Id: <20230702185327.44625-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use space after '=' sign to match DTS coding style.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts | 2 +-
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts
index 1b0c3881c6a1..13d478f9c891 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts
@@ -65,7 +65,7 @@ sound {
 		compatible = "amlogic,axg-sound-card";
 		model = "BPI-CM4IO";
 		audio-aux-devs = <&tdmout_b>;
-		audio-routing =	"TDMOUT_B IN 0", "FRDDR_A OUT 1",
+		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
 				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT";
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
index 29d642e746d4..276e95b34022 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
@@ -221,7 +221,7 @@ sound {
 				"Headphone", "Headphones",
 				"Speaker", "Internal Speakers";
 		audio-aux-devs = <&tdmout_b>, <&tdmin_b>, <&speaker_amp>;
-		audio-routing =	"TDMOUT_B IN 0", "FRDDR_A OUT 1",
+		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT",
 				"TDMIN_B IN 1", "TDM_B Capture",
 				"TDMIN_B IN 4", "TDM_B Loopback",
-- 
2.34.1

