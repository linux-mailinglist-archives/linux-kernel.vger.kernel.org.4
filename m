Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B1174AB29
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 08:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjGGGd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 02:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbjGGGdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 02:33:43 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EDE1FC7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 23:33:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e43473ee0so34356a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 23:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688711621; x=1691303621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rZJMXQqBbYtG35iaT5k3WfIhsJUmOKUvW8i0uD8NBI=;
        b=R6ZFDYFtiyI8QhUOPF6/ZqW8UzJswYZ0EN+ADhSd2YTyJsje3D0PZj3nDoKg+IU2g6
         oePk+WhsqDnjZIloNBJmSLMHqjTh7jSs/l2GuCbZETzeD4fx6VwJvnlNXfHHZ8GGPRsD
         5ICdV+l8u7Nf6IaA+Rsx6fDrSi/rctd28Y6urlyxFCJiagJlNi87Cr3wP6dis1J8wMc1
         eTAl9POvBZ3rb38PLgSDNFPh8k2X3OUDM+GRlL4FpHdIPiyxXES1wcNDdpM0Btn4wxCt
         QIB9RujK6e936OkZFLvYEedcYoGVRECEYmBhWA9J2y9lkb4N+5Iey2L4FSf/Pl1ycqFq
         inwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688711621; x=1691303621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rZJMXQqBbYtG35iaT5k3WfIhsJUmOKUvW8i0uD8NBI=;
        b=ipCCryZ7EPhSpUewXXz1Ov5yTi+2LBHog2j4j6fX5wGUOMyRRbfq4AiLwAtZziDgH0
         P+NWw48wzu6TgF0fjQrURIkf5HYHm3JFGPKw4xSojwac+pyg6IVXRXO1IT3uWOQdbVTh
         cDl4eFqF6ibImfu/MToqZUxy7w+23Jd2nMXleojVmV/mT9LH9zD72359vzmMv76kPpk5
         4XA/ehslPBOzI29GV7DCXgytBSMSjc9Fob2Z+Sn5fhdHK7bKvKfIScQG32QkqpY5ykE9
         K8qgt0geQ6P8oeq1cuSkDQXtoAFlyCymAchrTIuAccjPukjk4bzLYfxGe3kKDlbBOmit
         7bHg==
X-Gm-Message-State: ABy/qLaeEE7XdEd2GqW3d8An0hqO6bwOGAkm2i21JkuhD9oaeduE0Bud
        tfVy2khjjCT3vJBb6ujdzL0tHg==
X-Google-Smtp-Source: APBJJlFbgp3bzMYcY5DMSqClEkgQHsd57Rd5nfrMO9olrSVVPArWA9IWaAqP0FBML7kLKVnjeSzKyg==
X-Received: by 2002:a17:906:d7b1:b0:98e:1b9b:aef7 with SMTP id pk17-20020a170906d7b100b0098e1b9baef7mr2683392ejb.64.1688711621156;
        Thu, 06 Jul 2023 23:33:41 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id s24-20020a170906169800b0096f7500502csm1724803ejd.199.2023.07.06.23.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 23:33:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v2 3/3] arm64: dts: rockchip: correct wifi interrupt flag in Box Demo
Date:   Fri,  7 Jul 2023 08:33:35 +0200
Message-Id: <20230707063335.13317-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707063335.13317-1-krzysztof.kozlowski@linaro.org>
References: <20230707063335.13317-1-krzysztof.kozlowski@linaro.org>
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
  ACTIVE_HIGH  => IRQ_TYPE_LEVEL_HIGH

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Correct subject and commit msg (active low -> high)
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

