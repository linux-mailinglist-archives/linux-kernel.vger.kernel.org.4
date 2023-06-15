Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7840C731D0C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241308AbjFOPtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbjFOPs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:48:59 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4B72D43
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 08:48:57 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f61b45ee0dso10875257e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 08:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686844136; x=1689436136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PUAJ9GModBvA4BiyyqRlwTWGMClzVaAkbccnzBcQo3s=;
        b=MAv3MustOdNWaVH6UO8Tri+zzNC5QiaRcjMYPdrOwkg1F9oLpNPh+Se9yT+bTw19yM
         yp+3SnvrP3HaKHCpiwKlnxf9HOqrTMMAodRVIvGhiLCbwFbMfInStr+7OLvdh2I0aagU
         bDIphpBENWQ7JOeyR9wIVFYGEIto1/CU2Pn6fYlcuRQm/4N4/ZcbM7bIRjBOYmtrvxeQ
         XqFRL7flShjHn4VKXYwR57MWAOTacVW9A5HZ5ue5Q4MaLGXDU6dbqDhvTDUItnS7dElF
         kJxlZ5zB+5bdVK8ZFqWH2XfFhVItlBYcddiER9Shjw9oSEvhVUnJpP2HamlKkQR7bkPY
         XR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686844136; x=1689436136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PUAJ9GModBvA4BiyyqRlwTWGMClzVaAkbccnzBcQo3s=;
        b=eG/1qlrbm/q7dl748xZmrzeTWly4Jh/ptoOgX7/Fd0SUlAwpSa3nSy5p3HfqjSK3fa
         eqyOf49daaD1VYjlGoKwAtFfDPGua+8Oqi/EKUG+wv50G6Wg0EhVraf1N0LKxhQBFMLe
         JvxsRRra1+SAsIe9I0POA3vPmPNc76XLdqRtTG8A5xyH87LeyZ3xfoXu4nUzBaRrOuXZ
         6Q2i61lwFi3S5wl13ps7oKAJOK770NVW2EvQJZuINYJhpIiUuRxmTcBp1QvG3p93u3si
         GaFLxTf03IjOzB56BimRlXwKk7/jCx8gQnFjpVy8fd7CZZEuqVYtPh7US9GyBRqM6WPw
         qHBQ==
X-Gm-Message-State: AC+VfDyYOre+NFhbN2saXi9RmUIqaYJA7QMb6yEvaJSx+2Z5dpHu6NaS
        mM3DiXsfp1o27fSWB8cjefViKg==
X-Google-Smtp-Source: ACHHUZ7G/1KtQPGOmB35K5gwxpTmfOodKftc5Fr+/cmcI1X+hOOeaGnPkjyvF5SbSC55aY60zofuoA==
X-Received: by 2002:a19:5e58:0:b0:4f6:3c00:1766 with SMTP id z24-20020a195e58000000b004f63c001766mr9696485lfi.15.1686844136084;
        Thu, 15 Jun 2023 08:48:56 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:bbac:2128:4a5:31a7])
        by smtp.gmail.com with ESMTPSA id h8-20020a1ccc08000000b003f8d80ecc5asm5765516wmb.12.2023.06.15.08.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 08:48:54 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, danny@kdrag0n.dev,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sm8250: correct dynamic power coefficients
Date:   Thu, 15 Jun 2023 17:48:52 +0200
Message-Id: <20230615154852.130076-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
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

sm8250 faces the same problem with its Energy Model as sdm845. The energy
cost of LITTLE cores is reported to be higher than medium or big cores

EM computes the energy with formula:

energy = OPP's cost / maximum cpu capacity * utilization

On v6.4-rc6 we have:
max capacity of CPU0 = 284
capacity of CPU0's OPP(1612800 Hz) = 253
cost of CPU0's OPP(1612800 Hz) = 191704

max capacity of CPU4 = 871
capacity of CPU4's OPP(710400 Hz) = 255
cost of CPU4's OPP(710400 Hz) = 343217

Both OPPs have almost the same compute capacity but the estimated energy
per unit of utilization will be estimated to:

energy CPU0 = 191704 / 284 * 1 = 675
energy CPU4 = 343217 / 871 * 1 = 394

EM estimates that little CPU0 will consume 71% more than medium CPU4 for
the same compute capacity. According to [1], little consumes 25% less than
medium core for Coremark benchmark at those OPPs for the same duration.

Set the dynamic-power-coefficient of CPU0-3 to 105 to fix the energy model
for little CPUs.

[1] https://github.com/kdrag0n/freqbench/tree/master/results/sm8250/k30s

Fixes: 6aabed5526ee ("arm64: dts: qcom: sm8250: Add CPU capacities and energy model")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

Srini gave me access to sm8250 rb5 board so I checked the EM and found
that it has similar problem as sdm845.

 arch/arm64/boot/dts/qcom/sm8250.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 7bea916900e2..4b0835109b01 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -100,7 +100,7 @@ CPU0: cpu@0 {
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <448>;
-			dynamic-power-coefficient = <205>;
+			dynamic-power-coefficient = <105>;
 			next-level-cache = <&L2_0>;
 			power-domains = <&CPU_PD0>;
 			power-domain-names = "psci";
@@ -131,7 +131,7 @@ CPU1: cpu@100 {
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <448>;
-			dynamic-power-coefficient = <205>;
+			dynamic-power-coefficient = <105>;
 			next-level-cache = <&L2_100>;
 			power-domains = <&CPU_PD1>;
 			power-domain-names = "psci";
@@ -156,7 +156,7 @@ CPU2: cpu@200 {
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <448>;
-			dynamic-power-coefficient = <205>;
+			dynamic-power-coefficient = <105>;
 			next-level-cache = <&L2_200>;
 			power-domains = <&CPU_PD2>;
 			power-domain-names = "psci";
@@ -181,7 +181,7 @@ CPU3: cpu@300 {
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <448>;
-			dynamic-power-coefficient = <205>;
+			dynamic-power-coefficient = <105>;
 			next-level-cache = <&L2_300>;
 			power-domains = <&CPU_PD3>;
 			power-domain-names = "psci";
-- 
2.34.1

