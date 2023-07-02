Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CB1744FFC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 20:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjGBSvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 14:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjGBSvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 14:51:19 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45959EA
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 11:51:14 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-977e0fbd742so433306066b.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 11:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688323872; x=1690915872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9/mme4Lm+IwXrrQx5Y89ikjVJUw+qnmRCi3rmSsnT4g=;
        b=Zuhnc1HGzSO7uBk+VyGuuUa5cyluYdGZVU+kuJ/QWmITjrRcfHKnWZ7bt4o48qF2Te
         pDK5+x+ESI2xNPn84e/H8TLV2298BnTgqs0ujIf6SNlFdBXUpw2N5CwjZqY5WTDsv3y8
         6BU87Rp4SbcAHs6Cc6R7RDifYHablnCyZVMb+IEKqgDS+zKHaHWBj5i2MbYAxudzk9Mh
         ZXRqsKAagDfNVNhA3pCilq3gMbX83EaDpOdnjEE4M63ksj6jVaB3kD0OpNeGrcWqwA/n
         Uz4GFGn3ZSWvxa9oVmiDDMGuuyMCQZwPT1iKo96XTuTm00vTl9eHj/w0EwlDJpy4z8Al
         WxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688323872; x=1690915872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/mme4Lm+IwXrrQx5Y89ikjVJUw+qnmRCi3rmSsnT4g=;
        b=lQYzWfeskR9fIZr2ynh3r3vSoabYb/gNDfO4eu3yYwal2OAYLWMNfYUcW1CLDnWbox
         Z7eyD/UA2zN88SCRKcTSpUQGvGXW/ay8mP1Mhb89QqMM0lPJmL2y7CB7O0s4eqvZ82Et
         sJj6Nxz20uVBFtvQoLws3dl+frpbqd43DW0xO+7rJ/yKysE/0MDK3NYMEnrvWWJNhGkf
         2O6ed+NsXeagoY39XEtyqFHYxS3nVMCYxVAl7bfcx7TKkJBSm/1rdl044ciPY66RxEWU
         vO5HkFzKhJ2v40M483u2oKwYI4dD4ioYJr0cZAxR9CafYoEzAEmrHffWu46Pk/ydeoHy
         AVIA==
X-Gm-Message-State: ABy/qLbVaRGlpyE0GpWKkNQsiTQXvDgtC61m9pJFKzEH3TDI+9MRWT+O
        D1AZZNzdEBiqNSTMdrM73i18Gg==
X-Google-Smtp-Source: APBJJlHi/q4sUNd8jee7scTtyJ7OSdYtxch3B7eprgdADql8ScJgIB0rOMFFwMEeSTx0hmgIpCigsQ==
X-Received: by 2002:a17:906:8699:b0:94e:e30e:7245 with SMTP id g25-20020a170906869900b0094ee30e7245mr5757074ejx.8.1688323872184;
        Sun, 02 Jul 2023 11:51:12 -0700 (PDT)
Received: from krzk-bin.. ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id w15-20020a170906480f00b00992fafcb82fsm3121663ejq.24.2023.07.02.11.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 11:51:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: microchip: minor whitespace cleanup around '='
Date:   Sun,  2 Jul 2023 20:51:07 +0200
Message-Id: <20230702185108.43959-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTS code coding style expects exactly one space before and after '='
sign.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 4996499cc738..24075cd91420 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -469,14 +469,14 @@ serdes: serdes@10808000 {
 
 		switch: switch@600000000 {
 			compatible = "microchip,sparx5-switch";
-			reg =	<0x6 0 0x401000>,
-				<0x6 0x10004000 0x7fc000>,
-				<0x6 0x11010000 0xaf0000>;
+			reg = <0x6 0 0x401000>,
+			      <0x6 0x10004000 0x7fc000>,
+			      <0x6 0x11010000 0xaf0000>;
 			reg-names = "cpu", "dev", "gcb";
 			interrupt-names = "xtr", "fdma", "ptp";
-			interrupts =	<GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
 			resets = <&reset 0>;
 			reset-names = "switch";
 		};
-- 
2.34.1

