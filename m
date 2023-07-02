Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C56D745001
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 20:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjGBSwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 14:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjGBSwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 14:52:30 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E758CF9
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 11:52:08 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9891c73e0fbso667530466b.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 11:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688323891; x=1690915891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyV6oi4lj9PnIcMxtyZNpUOpRAMhM3ImTjgURE61yCc=;
        b=AEK5VgOKmMcuNpIERsFeIZ//0kU1e/RK8BqEGVhbaSd6l0OjeJGIOGjC6DCI+1mjRS
         /yILn9cl9F7+82uxSRhzj0HGmwZCKAyU1Th0UVuyyCsFLYfVs64ngHImzPAlK7TcKPC3
         5r7Ny50XfoQrYJjYwWmsMoCuaXk212Bk2p50b6lL58F/Dz09taPg4SE6AtxgM7cnZl0D
         4zGcxXUkLNbtQXmPLENz7uoHxChocsvEdWEM7+qOZ0PDZuh/qyMn6sduuBGJJSud9EFD
         Q4zEXNDsVzJm7hzyGrdXmZ1KnmX08LOlQwzooKkeh0syrJ98V1t261ajIW9VFmdLSbbn
         zXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688323891; x=1690915891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyV6oi4lj9PnIcMxtyZNpUOpRAMhM3ImTjgURE61yCc=;
        b=VveYNjLFnShfkNuFesnmMrksLcQ21eHDXH3ALPWlHaxtmXdRax9MffsejdowheWCB0
         X0FHT8jLMDc/LZlLpXBsYj+VLWRmGYG98TnNhfx/U5z0Qs6FGaAwSjvA+9GntLzPn1xv
         Mo1jUN02HfRo+0dK0xHUG/J9fquNJOsRA8Ln1CaHytvxQO6rUKFWoGzyJXwZ8Fl/LGLL
         BYe4+pRO22Iaqya38/aECZkzKc838dpSc2Ehzkuhu0r6h+iODPuO5j7/m3viTZatvE8K
         MqsqQ5LErxYtee4Do/znYd2i3HsUbLslhuLCaV675M5/3v0XQsPEZmPWxfchbSKIXTgH
         3lug==
X-Gm-Message-State: ABy/qLaHuAoJY5HEnmfFeFMYELOnOzIawExDVkACoa9Mb6nqFzwlo9+k
        SStWpzZSBZU/ycJHzloj2X/U9g==
X-Google-Smtp-Source: APBJJlEhd6z8agOBibXRo3Dy6Bq5NMd874Up4DuglQ2keR4klQKJDsECi6EU6l1awkuvU2gwEx9/QQ==
X-Received: by 2002:a17:907:212a:b0:992:6d73:5696 with SMTP id qo10-20020a170907212a00b009926d735696mr6867049ejb.5.1688323891729;
        Sun, 02 Jul 2023 11:51:31 -0700 (PDT)
Received: from krzk-bin.. ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id gy18-20020a170906f25200b0099297782aa9sm5343084ejb.49.2023.07.02.11.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 11:51:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ARM: dts: mediatek: minor whitespace cleanup around '='
Date:   Sun,  2 Jul 2023 20:51:28 +0200
Message-Id: <20230702185128.44052-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230702185128.44052-1-krzysztof.kozlowski@linaro.org>
References: <20230702185128.44052-1-krzysztof.kozlowski@linaro.org>
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

The DTS code coding style expects exactly one space before and after '='
sign.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/mediatek/mt7623n.dtsi   | 4 ++--
 arch/arm/boot/dts/mediatek/mt7629-rfb.dts | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/mediatek/mt7623n.dtsi b/arch/arm/boot/dts/mediatek/mt7623n.dtsi
index 3adab5cd1fef..3e5cabf19cde 100644
--- a/arch/arm/boot/dts/mediatek/mt7623n.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt7623n.dtsi
@@ -116,8 +116,8 @@ jpegdec: jpegdec@15004000 {
 			     "mediatek,mt2701-jpgdec";
 		reg = <0 0x15004000 0 0x1000>;
 		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_LOW>;
-		clocks =  <&imgsys CLK_IMG_JPGDEC_SMI>,
-			  <&imgsys CLK_IMG_JPGDEC>;
+		clocks = <&imgsys CLK_IMG_JPGDEC_SMI>,
+			 <&imgsys CLK_IMG_JPGDEC>;
 		clock-names = "jpgdec-smi",
 			      "jpgdec";
 		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
diff --git a/arch/arm/boot/dts/mediatek/mt7629-rfb.dts b/arch/arm/boot/dts/mediatek/mt7629-rfb.dts
index 84e14bee7235..f24ebc20732a 100644
--- a/arch/arm/boot/dts/mediatek/mt7629-rfb.dts
+++ b/arch/arm/boot/dts/mediatek/mt7629-rfb.dts
@@ -168,7 +168,7 @@ mux {
 	i2c_pins: i2c-pins {
 		mux {
 			function = "i2c";
-			groups =  "i2c_0";
+			groups = "i2c_0";
 		};
 
 		conf {
-- 
2.34.1

