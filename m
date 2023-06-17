Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32A5734266
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 19:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbjFQRPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 13:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbjFQRPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 13:15:49 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BD41BD1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 10:15:46 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51878f8e541so2268520a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 10:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687022144; x=1689614144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c21VY/2BYjMlFucoAaJTu2heJdLQjzrbKq28dJy2kr8=;
        b=hXitajQIYQy6+cIjWT7Br2R8daKc/xIkbkDOfexi27WhXBrb/ySi4i35aFb7TldkC8
         Tloafqwlgo0J4vcpHNtbtomLmLJaxB/6NbRXs0HTuCgiuSnnc8N7WpRi+yIIzu3eOPT2
         X1f8pebRXGkJ6ZZPmrndSGxF7HlQlhGDlU++G8PiKQ4dGrhOSHmwok23Yw3mwF6RCmpy
         5t+kVxca2/4W+IuySLlt5dPOa+xGyRyK6ZDMf1hcWfFUpZ6+Z+Mc1Z6I/yMA5uvfwKch
         sV/D2p2A+t7qVmk/AjS/qyl9X4PBuGR1towLVYtSD3TwHmAcaHT+o96zDJs9rWpzPdzI
         nVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687022144; x=1689614144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c21VY/2BYjMlFucoAaJTu2heJdLQjzrbKq28dJy2kr8=;
        b=AcESSyNxO+7/GB0XTM1+Nzi1ylbUxQEgLhtPJmsIYj8RW6899W4Xm+yHBrnTPTU9zT
         4SF2wl+efEtQZVT8adz3nk1UQ01HbZOGKOIBGj6W/BErhFMlC9hJ2CVftUIqauXb+lUm
         F7d4IsGjbmBdxZ9oiGBEhhs5/kSY1yMYdjbAoZJVBunZkR+eMlMDwYqkD4Iw9l6nNMd1
         KeckegQ7CzQ0/LaxZxRLpUPWtlrVfjOSaH+ObVzVFRL26b9IHrP5pNtnVpho4xrLNZyU
         z3b9W2Zn0Wbr1LR5kYEEnWUkAAQC8Mld4LyhGr8Gg3gxynje5o2qXM22EFXmApKEXNYG
         y8Gg==
X-Gm-Message-State: AC+VfDwo/dN8wnRtCmIZZZE+GVKaSY396zZgjOZf9IIVs8KnPeVkEDtK
        e+S+sNEXeKcsXMZcIU+VFmLhgNEtkLhReVNj1FE=
X-Google-Smtp-Source: ACHHUZ69OM/TksZc6GNPrPvtkN8ZrxorrwSL2oPcxVDNZVs0v/WVIdkPYlMrgzCIEZceFpY2YkAajw==
X-Received: by 2002:a17:907:7e83:b0:982:30e3:ddc7 with SMTP id qb3-20020a1709077e8300b0098230e3ddc7mr5045228ejc.5.1687022144588;
        Sat, 17 Jun 2023 10:15:44 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b009829dc0f2a0sm3841897ejb.111.2023.06.17.10.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 10:15:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Nikita Travkin <nikita@trvn.ru>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 01/15] arm64: dts: qcom: msm8916-gt5: drop incorrect accelerometer interrupt-names
Date:   Sat, 17 Jun 2023 19:15:27 +0200
Message-Id: <20230617171541.286957-1-krzysztof.kozlowski@linaro.org>
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

st,lis2hh12 accelerometer binding does not allow interrupt-names:

  msm8916-samsung-gt58.dtb: accelerometer@1d: 'interrupt-names' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
index 7943bb619116..54d648972d35 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
@@ -101,7 +101,6 @@ accelerometer@1d {
 
 		interrupt-parent = <&tlmm>;
 		interrupts = <115 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "INT1";
 
 		st,drdy-int-pin = <1>;
 		mount-matrix = "0", "1", "0",
-- 
2.34.1

