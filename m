Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9995362BC67
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbiKPLrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239085AbiKPLqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:46:14 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DDA54B21
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:31:45 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id c1so29014679lfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MEODRiV03kDY+EMEoyuOQG4/Yqha9V2LRLyZY6cCtC0=;
        b=CN3iDpQsG0ter+LCioFrhZSGHj64YuaD2IV9w99MwLq12ajV61yG95Y9LS9RG3qQ3S
         G2MtaV05yZpCgEi+Ls9cqguQ1HLDf2U70p8YZKoxcneIisWQ6rdfSHtBpI/VrpqktM+W
         WGC9XIE4iNxhYyPrz08APj4FALfqGL8grviSoxYwT79KITxSAM8GTSbAlxiNHIhY6H3w
         TKUioBKngUopelIQK67psapgIfzF7Tzx+wVzPUHcqRPn1fCepuWS4HSXhASjeH6WDxkU
         z7ZNwP6PEl2dyTAWfcawNIX1zo6KeOfqvasInyc3K4795VH8BcdCIe3O1/9xprFRAqmC
         0mqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MEODRiV03kDY+EMEoyuOQG4/Yqha9V2LRLyZY6cCtC0=;
        b=iw1dWovjqmswectVKEfXxzoXNaQPhP+4gclLtawE4Bnk+U09voR5FTvrutWfaxuRGp
         crXqi78ZVGHBPQ60ZR/hyqQs25h1U+EJar2a8ycO/gRsYBc9wfy4+NkWiGuMjCkDRI3q
         /oTab4NaIgtzQlyaHLnMx67l1Bq4ZV2Xv1UpDLHO2pgRKv6gJt9z++N0ZV1rNAFWGYrz
         vpDyBIEAMbbgU/2q88/70YWDuc1d4AFST8c3HtVb5+pLiJUZD/c+RAqei0ePRrx8xzXQ
         RBkTHsYKUHWYHc+7+zEQM3UizUXQk256NPFAlySqxtEeyI0pZ9QlYSlMeiUytMS4rMws
         lqCg==
X-Gm-Message-State: ANoB5pkCMiLv2iAbxuPzBLNUbqFNKjdsO3ONpIY+mIw5Z6KP8zpemwcv
        XCUQ7B1z1qlyhN1Oyd8ZkljMaQ==
X-Google-Smtp-Source: AA0mqf7ebVAbyZOP/thN4WAH1RBfcvBJS4DknNeH4wIAg0GHWJxwf+o1+zC54G2uMe6BrT1b5ih//Q==
X-Received: by 2002:a05:6512:12d3:b0:4b0:38f1:1784 with SMTP id p19-20020a05651212d300b004b038f11784mr6689665lfg.335.1668598303502;
        Wed, 16 Nov 2022 03:31:43 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p18-20020a2e9a92000000b002778d482800sm2963403lji.59.2022.11.16.03.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 03:31:43 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH] dt-bindings: thermal: qcom-tsens: narrow interrupts for SC8280XP, SM6350 and SM8450
Date:   Wed, 16 Nov 2022 12:31:40 +0100
Message-Id: <20221116113140.69587-1-krzysztof.kozlowski@linaro.org>
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

Narrow number of interrupts per variants: SC8280XP, SM6350 and SM8450.
The compatibles are already used and described.  They only missed the
constraints of number of interrupts.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index f0bd4b979e28..5bcfddc877d3 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -146,11 +146,14 @@ allOf:
               - qcom,sc7180-tsens
               - qcom,sc7280-tsens
               - qcom,sc8180x-tsens
+              - qcom,sc8280xp-tsens
               - qcom,sdm630-tsens
               - qcom,sdm845-tsens
+              - qcom,sm6350-tsens
               - qcom,sm8150-tsens
               - qcom,sm8250-tsens
               - qcom,sm8350-tsens
+              - qcom,sm8450-tsens
               - qcom,tsens-v2
     then:
       properties:
-- 
2.34.1

