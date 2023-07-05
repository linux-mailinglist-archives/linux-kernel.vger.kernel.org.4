Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4AA747D65
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjGEGuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjGEGtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:49:36 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4332125
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 23:49:00 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9741caaf9d4so554168766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 23:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688539728; x=1691131728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4BLpQcyu9Z+TkFkMMBNPXxj0TsUd7XYOG3VtXDiVEos=;
        b=hd2auJm2gJxE4NaPzfdgf5PK1CXoj2u+Yk2TzKUjTKUuiTR57+YdVsmoPUOSVY3uHK
         nZIqRZP+CHOzMM+ajppHFqCX2bLcbnAH7p6kiFs4MN/ffNpLpVGUotjq+IEdg22Y+aFJ
         gZAArYBhp5Y9VrkANFgq0PDYvXjoMqtwHnq9Xt8N+PWQRBOAKXfDP/ls1ItbOKLcLyfR
         FWKgS8WumdEdYJsGaa/MLDzxYJbixjGpIxKA3h2j8Gx0141ogqoRiYBhNs1piK6eNZiK
         +iv4iHQHsfbW+cAaLGb8Ax7bzq27wMHWMlI1I9nfGIsFNAmqV2HX4QwNjg85ETb15k5V
         dOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688539728; x=1691131728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4BLpQcyu9Z+TkFkMMBNPXxj0TsUd7XYOG3VtXDiVEos=;
        b=dhdo0dPXXGN+oBRVMM7LoYjYKisERnlN+lF6C5rzjE2eQ9GXsZOeXjhBMmdQNcwuer
         /EDHvbNtiLJ+MgiUEangtvZFfcQIIVaFjT7iBPFkgmwGZzUkfxhO1HEll7nWJDWFXFci
         g6+FjkWtXFxu+lhYnvFc95rHm4xFB5DuDMvuz2XgWw10N0VwcuCxQv0yjFE5sJev0YaR
         z+p3mJPyZly2fXCf5GRsAu1gNnJBjiCd/7LE9e+z/ZV7R9Q2cJhZTeoRZYFCWioe/XB1
         0HuR93diLQxUD8WwOJd79J3IvMdYjJ923jbGbycHlN/MXqlonvWRb8uo9iVTEE0CZPSJ
         BBhQ==
X-Gm-Message-State: ABy/qLZaUxKJDk8pIro1u0Tora363s7lYlt+eCk9/6chKaS+KSYDXi8M
        nbApi1fZ71m7suIgaav6LywCMw==
X-Google-Smtp-Source: APBJJlFdr/JqlYyk0Iw3f97ZqtublI4upHtqJRPCgBSEDqIv2RXPje/WG4Qau16mX2OZcIDrN04zeQ==
X-Received: by 2002:a17:906:57ca:b0:96f:8666:5fc4 with SMTP id u10-20020a17090657ca00b0096f86665fc4mr11686557ejr.50.1688539728502;
        Tue, 04 Jul 2023 23:48:48 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id lj14-20020a170906f9ce00b00992bea2e9d2sm7504836ejb.62.2023.07.04.23.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 23:48:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 1/3] arm64: dts: rockchip: correct audio-codec interrupt flag in eaidk-610
Date:   Wed,  5 Jul 2023 08:48:21 +0200
Message-Id: <20230705064823.9210-1-krzysztof.kozlowski@linaro.org>
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

GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
These are simple defines so they could be used in DTS but they will not
have the same meaning: GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE.

Correct the interrupt flags, assuming the author of the code wanted same
logical behavior behind the name "ACTIVE_xxx", this is:
  ACTIVE_LOW  => IRQ_TYPE_LEVEL_LOW

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts b/arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts
index d1f343345f67..6464ef4d113d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts
@@ -773,7 +773,7 @@ brcmf: wifi@1 {
 		compatible = "brcm,bcm4329-fmac";
 		reg = <1>;
 		interrupt-parent = <&gpio0>;
-		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
+		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "host-wake";
 		pinctrl-names = "default";
 		pinctrl-0 = <&wifi_host_wake_l>;
-- 
2.34.1

