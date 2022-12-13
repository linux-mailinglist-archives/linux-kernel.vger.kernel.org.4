Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B101164B316
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbiLMKTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbiLMKTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:19:31 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F098C1C423
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:19:29 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bp15so4086102lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dAp4hskFZjGN9y85+kSjx75sUPK/6e/z3wevYeNaTXA=;
        b=dUoAwJ8JaVf8oHHkfNK/gOqgjmNxvUu+Qp+Q0gFQlqdOqvQXHTJizZG7ezH6bq6Vdc
         s59ryiH+uO2BNlCyq/HeMYYk6WMPrQa/YCT/hh1v8h623w1XB47e2mCJ/NKuqukuuwO5
         DuVvd7uHX8uhEJ6/R9/Nkfp6wvduQ5D+B7B88ZQUMTw62GFjvw0a9GsWaD+NVlPZcY6l
         P2Y0F4ulg9Zj5KAuerOStnS/DrW0M7VxFAeEhZ56c0TUXtiEO0+A3ZVayyhLaSYEw5WK
         cEqTb05f+MoTwOlx2ecaYiPkgdgG1DTKkFpmRGt7VqK6mNsIriKCDdiv3X3rALabj1Yk
         g2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dAp4hskFZjGN9y85+kSjx75sUPK/6e/z3wevYeNaTXA=;
        b=IhZBlxVIt1zqjDSbBubYIGy0B6qRk+0/wU+1+71zg24FYX3jRGrTNkPTkFiOv8Z4mL
         HtUXPG3tLRAnAe2JrCCh5IB51YjNb7cWM2nExrLmlgbmDJqHUc70PFtcfg5bPsq0ietn
         npxTXN6sZsQFz4KHq+fRLpmcyOayunmhNPtziFN2xAxdroyIJvgHiTlp2GzQIHm061R6
         DzQkL+RTGdi/N4o+O+XROQsH3pF/Lr99vPFf7mGWUR74YvH8NR7hhZzKCCy3EOpM7j6T
         u/ZyYjDSuG+8d67XdHD5hdQW02JrGz7bV3ZooEwZ3V6zHvrMOqtHiClZiI+rEmP12CtB
         qqkg==
X-Gm-Message-State: ANoB5pmOYgFc74/juWS4dRLV6NYupOIpFqC10PLvFcIrUJR8azrAsdXW
        hFZjNacewbbNZ2wlRPxqeVyXxg==
X-Google-Smtp-Source: AA0mqf5QBIa3tHvXhuX4FOmUOD94PbeJ7R2eJhlkRSDqXBTixxuOzBy2Mx6kPvpkKqtwe3SClyD0Zg==
X-Received: by 2002:ac2:5f47:0:b0:4b5:9dc4:e785 with SMTP id 7-20020ac25f47000000b004b59dc4e785mr4381473lfz.45.1670926768251;
        Tue, 13 Dec 2022 02:19:28 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o11-20020ac25e2b000000b004b5732080d1sm302460lfg.150.2022.12.13.02.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 02:19:27 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Kiran Gunda <kgunda@codeaurora.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] arm64: dts: qcom: sc7180: correct SPMI bus address cells
Date:   Tue, 13 Dec 2022 11:19:17 +0100
Message-Id: <20221213101921.47924-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The SPMI bus uses two address cells and zero size cells (second reg
entry - SPMI_USID - is not the size):

  spmi@c440000: #address-cells:0:0: 2 was expected

Fixes: 0f9dc5f09fbd ("arm64: dts: qcom: sc7180: Add SPMI PMIC arbiter device")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>

---

Changes since v1:
1. secoond->second
2. Add tags
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index eb1e1ea12ff6..906fb9343bcc 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3274,8 +3274,8 @@ spmi_bus: spmi@c440000 {
 			interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
 			qcom,ee = <0>;
 			qcom,channel = <0>;
-			#address-cells = <1>;
-			#size-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <0>;
 			interrupt-controller;
 			#interrupt-cells = <4>;
 			cell-index = <0>;
-- 
2.34.1

