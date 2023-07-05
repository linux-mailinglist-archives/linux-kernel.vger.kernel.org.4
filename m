Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23136747D68
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjGEGuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjGEGtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:49:42 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5604B2685
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 23:49:08 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98377c5d53eso736421966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 23:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688539731; x=1691131731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GB4bpNO3SAJRb4aZuiOoT5tlPntO7wrJyRlzhpgfep0=;
        b=D6HXcgpHibNmK6NkqhcOhTtIW5+ekU9iXxP97snkK3BNydz/RuVs6uGiuGiUOotYHc
         pJIMnec7dx93W7yNBm7gBJ3WuDLzdOM2JoWQ2C+Pf2fCE2T7VPbT5j8BpE5dOqkA9NF9
         oaYY7rFY0iPy7STFlXVDbPz38v8etgYx4yYI28cBb7HWdymSgzfqiXV8Lu+HZ15cRyuk
         +A2aRwh8w+E1aGoNFZaf610DUh9YoIdypgtHu7f7p+jlvISmjSsVqJhQolms0NBmP/hb
         QzCP/CYVepxNleUQvOreWm4BGHNJfQWNAOYLBgqmzgBtfokh8u7Ug0VpQUtv6xipPxY/
         lyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688539731; x=1691131731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GB4bpNO3SAJRb4aZuiOoT5tlPntO7wrJyRlzhpgfep0=;
        b=jU74ZDc/EjeYEOt2+07/HyvUXV8jNJx8x/q86c/iapyFrt418fhkJItsM0tbiGIPDQ
         sE/2Agw980iibqJAgvM08u2s7/jNbkBboQHOIYLedF/4HGvVZcwa54WmN4MlIb5QWF4Y
         ik7Qwwm1cv8lNopafzJ1osILHPRLe6c1GRsT05XD7rx/vm9/mqh95j30cTu6210CLdBX
         8puDot/YZj0YZeoCMMq5mcP7nfMLeBYvb4JUepqXrnr783e1ODpo5auCgLLYIlgt6EuR
         NCqBdrn8NU52PjDhRk/sGQupO+67AEr5THaC/KXSt0fY4fvKUCNhAB+/QpDUJ3G4SQ/D
         4zyw==
X-Gm-Message-State: ABy/qLb7eu/MIAq0iIxyGimAB+cXpmgQ94yMcQCLZflNplC8r9U8LERb
        7FxMRMC1Or6QQSfNhCJ4aHa86A==
X-Google-Smtp-Source: APBJJlGqxp0nR/roJ4vSdQwDqZktpU71hnPcawgc4zAU5CBltXqnjOabo4Kgh5z0KdGtSqmZXiPVgg==
X-Received: by 2002:a17:906:c28f:b0:978:90cc:bf73 with SMTP id r15-20020a170906c28f00b0097890ccbf73mr10185458ejz.48.1688539730997;
        Tue, 04 Jul 2023 23:48:50 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id lj14-20020a170906f9ce00b00992bea2e9d2sm7504836ejb.62.2023.07.04.23.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 23:48:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 3/3] arm64: dts: rockchip: correct audio-codec interrupt flag in Box Demo
Date:   Wed,  5 Jul 2023 08:48:23 +0200
Message-Id: <20230705064823.9210-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705064823.9210-1-krzysztof.kozlowski@linaro.org>
References: <20230705064823.9210-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts b/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts
index 322f3e809f15..0c18406e4c59 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts
@@ -416,7 +416,7 @@ brcmf: wifi@1 {
 		compatible = "brcm,bcm4329-fmac";
 		reg = <1>;
 		interrupt-parent = <&gpio2>;
-		interrupts = <RK_PB2 GPIO_ACTIVE_HIGH>;
+		interrupts = <RK_PB2 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "host-wake";
 		pinctrl-names = "default";
 		pinctrl-0 = <&wifi_host_wake_h>;
-- 
2.34.1

