Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639DB67E15D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjA0KSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjA0KS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:18:29 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C27469E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:18:28 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id m7so4501892wru.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mNB6kpSKKSYhNna+5QBAVTfwz9dfQdgV2XPJczSJw9E=;
        b=T3LQPU3RqWyJxuT/gw3jjA2xLTImTa4k4ekIIP9GUwc+TLimEuicqeCXg3XLVaJxxz
         LefhQPyJ8X0c/kfin54QZ7G49D2t9wAjcAz8ViIgWeEnQGJsOOS89BYD5iwxlpgqLDgx
         4846Zz711amzIP5QH59yLGdI1VBrZ/UMQHUwI2pWrzE1UYI75ZgQzNlbpC4lWA91p1X2
         qi4UnEX/XCTu1KORXqR1dEWq3OpIXIH2+usJU2AmIXOU6aILvsdvSPBmVvcV8eMBA7u4
         xU2znOcCqbC6/4SrLjFfdcGR5tFMqqLeartyjpDjPxqabTBiOvUKzUc2BVWkX7GCSV30
         Jj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNB6kpSKKSYhNna+5QBAVTfwz9dfQdgV2XPJczSJw9E=;
        b=vXLjZAmN/vJQt9KOLVqrRuqoCdm05fyjDKWvHbWJycLZz+M4UnabAF6gLYZXDc48xf
         nLLSfbNJ+urHAddMMlN38QlcKatPbzAfIikwxHfeh6jrEfywXzZPxQ5eXcOvd01PszeH
         NwyYaAJzVAj7xSKJrcx5bjJ3VZbCFmb6gfUAikJMa+HX1Lw3n1HA+pNmxNI2J35PUa6x
         NZTimtPHYND7KprM76cirR4fMw1L+30GCf7utI9uB8mLBmoHKuDcCGF48VOyyByL72wS
         iG4OCi86sA/rdt6sVR8asKyrCrdhpZfs0YeXr7RE2o16pKdmL98eMooji35FleYL+Kyv
         ir8g==
X-Gm-Message-State: AO0yUKV/X7YklOhR0WlM6GvuM8a32tMXJ/hbfUPUQwVXGwg0f0bR1gTY
        8GjEdcOS0lBWf8lRq9Dd7E0Tlw==
X-Google-Smtp-Source: AK7set+Oo1LuY18jRFWgICS2lGN8zLYYoMI+CLpce2/9tjHjdYL0h6STQLfH6pn2Cypfw8pbP2DJag==
X-Received: by 2002:adf:ed50:0:b0:2bf:b571:1f18 with SMTP id u16-20020adfed50000000b002bfb5711f18mr10709776wro.61.1674814706877;
        Fri, 27 Jan 2023 02:18:26 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d6b81000000b002bdc39849d1sm3494564wrx.44.2023.01.27.02.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 02:18:26 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: microchip: use "okay" for status
Date:   Fri, 27 Jan 2023 11:18:24 +0100
Message-Id: <20230127101824.93684-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

"okay" over "ok" is preferred for status property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi | 2 +-
 arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
index bf12be5e8d84..ed94a80bf05f 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
@@ -538,7 +538,7 @@ i2c_sfp20: i2c_sfp20 {
 };
 
 &mdio3 {
-	status = "ok";
+	status = "okay";
 	phy64: ethernet-phy@64 {
 		reg = <28>;
 	};
diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
index ec90bda7ed6a..0760cf2e48bc 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
@@ -208,7 +208,7 @@ sfp_eth63: sfp-eth63 {
 };
 
 &mdio0 {
-	status = "ok";
+	status = "okay";
 	phy0: ethernet-phy@0 {
 		reg = <0>;
 	};
@@ -284,7 +284,7 @@ phy23: ethernet-phy@23 {
 };
 
 &mdio1 {
-	status = "ok";
+	status = "okay";
 	phy24: ethernet-phy@24 {
 		reg = <0>;
 	};
@@ -360,7 +360,7 @@ phy47: ethernet-phy@47 {
 };
 
 &mdio3 {
-	status = "ok";
+	status = "okay";
 	phy64: ethernet-phy@64 {
 		reg = <28>;
 	};
-- 
2.34.1

