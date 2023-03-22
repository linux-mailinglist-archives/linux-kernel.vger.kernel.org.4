Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDF76C52D4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjCVRmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjCVRmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:42:02 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B9762FDD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:42:00 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i5so29252865eda.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679506919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKPYbv1iLnGB+8/bk3IbTuS+zV9TKOLzePRCaV4OSl4=;
        b=JyG+FBGneMH4ZKGQuAwN9W6vi3bAke5m0pF5GzCiVJMp+VJQ1TNtdN1h5EKDJRmQsN
         Dei1vKHaJYFewN22LglD4O/94S/w1dQpTYwnjFGRlP3UQS2vleGyNULXkgDJYo5+gIwb
         CXhDMDMF9pjGCzySKQmqG+g04kM/yXSYEdko0aoXY7Sze7THF7At1KoIaPNK+xzO9blB
         jNoBLj+icuz0b1ZEtk0wmlSCneHasnIuMWA398ho3Yb9bw7mg5clUaRN4wA+sm0gnr7J
         qGPJ8l69XQRk7yRRWRbIFzhjSGHSXVxquoRXHpFPzd1zwkn24ZeWkS7g2XyCP28WT1Qe
         d6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679506919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKPYbv1iLnGB+8/bk3IbTuS+zV9TKOLzePRCaV4OSl4=;
        b=e8e7YNvGaxDGX555vYU/cjfqAShOOtaVrdj8Vuw2K2AO0/VNtmTO0a+l1MEdVsF29M
         pNHuAB1bj1ukoI29NxWIqBPSaIpqEhQFWahWw1oSshmLfeagyfqaULcHvWGm+AXlcMgb
         lqxXCu45rkCDlqBrR5GHtdL9aBKwWCYS5UVzx2w1SIAjfXqhD3OK7yuRTzXQks/rdDo3
         FUWUOHif1OIb8jx43ijCVUsB8tLHT7bdNLqhQMAPQOJ1BGI4f21JtsFF4jWmazoiGi+T
         HkbFvmvXZRphiSN0ii6/jG8zOwGwg7jlrHJssRBk/CEAwfnOIVRZ3otEUeD+3RGV3bQ9
         401w==
X-Gm-Message-State: AO0yUKW/KEvJRDs6McglmJD/DYJ8v4jSJ5t+JWleBo/WpOI4ff5X42mT
        uGbsyrT3HUt7GwDd9LeQfE7B8Q==
X-Google-Smtp-Source: AK7set+3RzZVCxiP77frIe2otYhQXt2BFPKagKzGZd50N8VdpJl/B/632phMQk1P+KyAGDHvjHq32A==
X-Received: by 2002:a17:906:11cd:b0:8b1:264f:3776 with SMTP id o13-20020a17090611cd00b008b1264f3776mr8093294eja.23.1679506919220;
        Wed, 22 Mar 2023 10:41:59 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:5050:151b:e755:1c6])
        by smtp.gmail.com with ESMTPSA id jx3-20020a170907760300b00930876176e2sm7548088ejc.29.2023.03.22.10.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:41:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 07/11] arm64: dts: qcom: sm6115: add compatible fallback to mailbox
Date:   Wed, 22 Mar 2023 18:41:44 +0100
Message-Id: <20230322174148.810938-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230322174148.810938-1-krzysztof.kozlowski@linaro.org>
References: <20230322174148.810938-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM6115 mailbox is compatible with MSM8994.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index fbd67d2c8d78..2feaf9c831fe 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -2038,7 +2038,8 @@ watchdog@f017000 {
 		};
 
 		apcs_glb: mailbox@f111000 {
-			compatible = "qcom,sm6115-apcs-hmss-global";
+			compatible = "qcom,sm6115-apcs-hmss-global",
+				     "qcom,msm8994-apcs-kpss-global";
 			reg = <0x0 0x0f111000 0x0 0x1000>;
 
 			#mbox-cells = <1>;
-- 
2.34.1

