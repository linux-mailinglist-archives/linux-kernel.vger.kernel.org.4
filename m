Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19ED6B6A36
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 19:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjCLSil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 14:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjCLSi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 14:38:26 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7218BC16B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:37:46 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g10so11375800eda.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678646190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TH9VNI6fNpG+atm+JmGgMQR/C/NF96qhJ4vOv3Oyay0=;
        b=fZ1W+DKo9MUQ2Jrc8sjp61K1a4s6HNfRKDpBDPodjwFFpHk+xpwEO0vd6ZqjoJ2106
         oaPghzFvkHQwLanGgBJZlQuGCFz7H6Utgizn6jOYABxM8iRHK92bobJ93oIYT1x+d9pv
         h+oPGX1Fgm8xRsVPzufNzimOUfzfXN6xUlkeCoDeeF2BQ2bIbPuIe59u3HbLaxeYQpOs
         TkoskaBQH40YoDm1kOa1975ReGAj0QKqo4lSG2iI0S53zICyUPQgVttsb2L/KDDnyGaY
         aHF7jaTWD/0Pu77qa0RhwKrlFv/H5j8okv1vC4K0iZn9mJrajMi517sqZoCiVLGDiwod
         +t3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678646190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TH9VNI6fNpG+atm+JmGgMQR/C/NF96qhJ4vOv3Oyay0=;
        b=39AXNDoKpnPI1ruUoXlg0R3Tp90nCkqWCC+pl108dHb2brtpI64QK0LGkhqQgJ1twd
         YiqLKPhNJ7B6KPXgWmSWHYUIGoZM5piYhJjWAAJ1IbgpU2wwmFmnL9wH+H9GFoedSFAL
         KdwcYBodGmU1ALzXXuCjTCMlloDD5Yi2qPp/OWkltMfZiLvzbx09m6NLjD6Hegr5TkRP
         MLEGTw7+G97ctzF/KJXMQBzy1iVqVzM+EHiFye9TnNcujFMKyf8CXtdKKYuF9DMfIWnR
         EAHrzKDEIMiexDmVUHQZBcxd+86yuO8k9ZQ+RGT1Mfg7viP8Xp+ikbNx7VtPEPD98r37
         kz4g==
X-Gm-Message-State: AO0yUKWmQOPzsiX7voDDTPsgnQlgouK6sWI9+gtbpftGzCW3PSO5zl5D
        ZI37LT7RF5rxWkHU1+zkDRNtWA==
X-Google-Smtp-Source: AK7set8J0qSzibgHFlSK5MY5+M1gFKCXgckA2oI9gOKm83QxnlYA+ZBHOMApvtKG/3HZR405DgdD8g==
X-Received: by 2002:a17:906:bc58:b0:928:a2:904e with SMTP id s24-20020a170906bc5800b0092800a2904emr1915750ejv.54.1678646190073;
        Sun, 12 Mar 2023 11:36:30 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id p14-20020a1709060dce00b0092669fb4ba1sm893806eji.130.2023.03.12.11.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 11:36:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        Gustave Monce <gustave.monce@outlook.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/8] arm64: dts: qcom: sc7180-trogdor-pazquel: correct trackpad supply
Date:   Sun, 12 Mar 2023 19:36:18 +0100
Message-Id: <20230312183622.460488-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230312183622.460488-1-krzysztof.kozlowski@linaro.org>
References: <20230312183622.460488-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hid-over-i2c takes VDD, not VCC supply.  Fix copy-pasta from other
boards which use elan,ekth3000 with valid VCC:

  sc7180-trogdor-pazquel360-lte.dtb: trackpad@15: 'vcc-supply' does not match any of the regexes: 'pinctrl-[0-9]+'

Fixes: fb69f6adaf88 ("arm64: dts: qcom: sc7180: Add pazquel dts files")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
index d06cc4ea3375..8823edbb4d6e 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
@@ -39,7 +39,7 @@ trackpad: trackpad@15 {
 		interrupt-parent = <&tlmm>;
 		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
 
-		vcc-supply = <&pp3300_fp_tp>;
+		vdd-supply = <&pp3300_fp_tp>;
 		post-power-on-delay-ms = <100>;
 		hid-descr-addr = <0x0001>;
 
-- 
2.34.1

