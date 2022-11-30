Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E21B63D319
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbiK3KTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235647AbiK3KSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:18:50 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3977F286D2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:18:48 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ml11so15257030ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSQin7QU7m3wea+By9/0m4C67OFHqy7bfbLiJ+YSrfk=;
        b=sbQG9NetJxA1tW9+reryqbw/YSRCTH/j1617V6HYFABlbvVg03j80I8+OoRLOJElSN
         +g0BFhDJBu0Zrya6IsRAawrI+Hg8m/JFlqcgwPcdOV6u68RCt+iOM0KW+3o1RRo0yko3
         Cl+xAiv6TORn1Rg+cL0TS6QO/PKWn4j2rT15/gFwhADf87Ftiu3fawq+pNreFzWZ7x/d
         qp831Z+BiRfC9ewVKUWhf8pqqhH0ga1Pw3zXvHPUPkHavYpF/XZ6ttPMMCG9PLKjV4df
         Rpe/OnFI1mmok5J8xxd7Im+tyBYNb5dWcrj5gIh6eYK0/GgS31/1ewW8PayPWBUMz5y/
         1p4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSQin7QU7m3wea+By9/0m4C67OFHqy7bfbLiJ+YSrfk=;
        b=lwtMxCL1k93Vjz9KUv7coVOobthchSqSIRq82hM1sadI6mGND/dWpx6Y9JJZqT7MAO
         A0YRCVzykfJt6DbjU1WJnQJl196sHtWZtWQdrztz+BEzt0/whVtxRX0VL9WRcVVTpyFe
         42pbVGcXbDs8GozDi06HNgoBYKtoETetQTL/+lDEmbZbonXmv6i/MiTh/I76wD1Udfg/
         2+9no8YGWaDvSfIk+8GsLWIOY6k/ZUHg8VhfWYLzgGWoUtZ2lzupXtvo7XqcA4EY58l1
         NNKZHobf57mVtfb6IPzUHQxj0cndokw9e5A3ifuSV3v+F0iwqh0FqxOgtD3jtvw0dt52
         qanQ==
X-Gm-Message-State: ANoB5pkWhbsDPeCJ1X9x92ipz0NYyaMPtG13ojLLQwnrDAJqNtrHfAVJ
        Uo9ctPR8ORFgnJXh/pjDMQ61Ng==
X-Google-Smtp-Source: AA0mqf5enEd7pHTAknHmAHrK3tjOFgGd8XoZ8Hop2BlEF+7KWh1o4MhtbgHwj0+rjhA5DBeaUL93qw==
X-Received: by 2002:a17:907:6d12:b0:7b2:bb8c:5398 with SMTP id sa18-20020a1709076d1200b007b2bb8c5398mr39647859ejc.573.1669803527352;
        Wed, 30 Nov 2022 02:18:47 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id l4-20020aa7c304000000b00458dc7e8ecasm449462edq.72.2022.11.30.02.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 02:18:46 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 01/10] dt-bindings: arm: qcom: Document SM8550 SoC and boards
Date:   Wed, 30 Nov 2022 12:17:35 +0200
Message-Id: <20221130101744.2849294-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221130101744.2849294-1-abel.vesa@linaro.org>
References: <20221130101744.2849294-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the SM8550 SoC binding and the MTP board.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 7637cf27d799..a586a38c3461 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -68,6 +68,7 @@ description: |
         sm8250
         sm8350
         sm8450
+        sm8550
 
   The 'board' element must be one of the following strings:
 
@@ -818,6 +819,11 @@ properties:
               - sony,pdx223
           - const: qcom,sm8450
 
+      - items:
+          - enum:
+              - qcom,sm8550-mtp
+          - const: qcom,sm8550
+
   # Board compatibles go above
 
   qcom,msm-id:
-- 
2.34.1

