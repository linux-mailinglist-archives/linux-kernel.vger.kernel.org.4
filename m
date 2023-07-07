Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB8774AB26
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 08:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjGGGdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 02:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGGGdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 02:33:41 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1491FC9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 23:33:39 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-992ca792065so186613066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 23:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688711618; x=1691303618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e1W0PEIp2Z9O+/54QqCCTT57o1K3eq1ISnoT3iEkIG4=;
        b=Ji+vp0Rf7GnjgL/ryIs4zj5psew4pNxA0cs8GFKCCt4E8wh0ztH3y1BPKo8A6Kr5CR
         Ssh+LsCi0ePSmFr6nLgrN73CA2MGcMaJIrfjpg/jM7aBYCC7QstmFfJTkw+D0od4S9CL
         fK43PEE9RS+gtkkroUsHTHuZrB4sb2u/XCw+wBuIGWfkCD0UmOg1nuWcTcVNjB4Y9lBJ
         XtIxHr9Fe2nvRTn/d7F6dMPhkKhvs3PfzluZg24d0Fqx/c5HsGGJBo/U2On4yiyKU7x2
         jekKm74a17Mc0FGyAaRQgC6mRyV6NJcMAVHpqNP/NinRZ88jHW6ZblkBXu+EnDP5KDX+
         smmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688711618; x=1691303618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1W0PEIp2Z9O+/54QqCCTT57o1K3eq1ISnoT3iEkIG4=;
        b=CH6oYhL5vXL6mBbBRHmNs5OTl8kY/3NjWwsJZ89Bd6u40787udscaO/RyY0Xta7qe8
         l4i+Wz4/WTHrLBFfsVzve2JmQNsoFX+vmL2zZeAv7pIrsCk33IJoiOUq+HkIzmrlAxni
         afbqX5v7nHqhHQNmG+UZLOwC+v84JMLsd4Aq8pkuqIgGwe/XcYVbMxOeTJYRl5Mp+QAj
         OmfQX7NOgyW9BIXVV3IyRUqLFbZz3SNX8cdt9m/3KZH2Yqk6CI4MptbYh7j+4tj663OW
         z33raKcqyELbVUYM3OAYA92YuXA8Mlb8wtqPdycRTrJ5gwMRLnbsaSFT/3fj+APFZhfK
         FU+w==
X-Gm-Message-State: ABy/qLaC0DQxNkGu+c36ugQdAUGwSTSTmnYmB7MmNhCrmMitH77RnvBa
        QAS+O6Y7q+bF9KITI08tTwkEUA==
X-Google-Smtp-Source: APBJJlF+EQzCxlpuXGk2rbnxNVji72DYX39eyT/xKUrWXgFmOCWnAUyM7SHtccK5tqS/eFhQSlzXhw==
X-Received: by 2002:a17:907:75f6:b0:94f:449e:75db with SMTP id jz22-20020a17090775f600b0094f449e75dbmr3160188ejc.52.1688711618411;
        Thu, 06 Jul 2023 23:33:38 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id s24-20020a170906169800b0096f7500502csm1724803ejd.199.2023.07.06.23.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 23:33:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v2 1/3] arm64: dts: rockchip: correct wifi interrupt flag in eaidk-610
Date:   Fri,  7 Jul 2023 08:33:33 +0200
Message-Id: <20230707063335.13317-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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
  ACTIVE_HIGH  => IRQ_TYPE_LEVEL_HIGH

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Correct subject and commit msg (active low -> high)
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

