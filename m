Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AE05E897B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbiIXIH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbiIXIGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:06:48 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24943127572
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:05:40 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id w8so3475034lft.12
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XFjm6zy5pNuV6EFMWZDa8Aqoeg4BjA/X1Ww7Riz4YHM=;
        b=d88SHg6hQjd6/po0T0mVTUf8gaetCCcJuTdE+f8xyTPEAc5N7nPRWUyiVepvM7h2KR
         kLqUhiOgEQUZ+jWr4tOHZuqRrjDbK4OAw0T5KSNbgbrOAgNka2gozp92IAPbjOye8eeG
         wvG6Yi5JZpVh6n5rgNmuNCbUlmAEDCk26EmXw3nXXfKbP5g4/xLorMY6iGPjOfw8F4mC
         s3LOjbeiU9clUAuNl201I2VsWyLLVFcmFpbaEFrkQ/uE2zlqjfpGOG71XS2sOiOIoxaM
         za+93spcesN1+1sbxoY+IaJoXzhVmwprCOGHDA25v9p8W1BEQ0KkJkmkS1er/sC9O+IZ
         p1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XFjm6zy5pNuV6EFMWZDa8Aqoeg4BjA/X1Ww7Riz4YHM=;
        b=7UVB09RoYAQ4MZ3XxZ5lPNi+Vo+Robjfi40AUSJn/ctR5l1BJQWQ0LFnLoU5WkZFFr
         SHqJGAsSA/8mUOJRihuMAELvZesxAyUFkiqTlGtvKBwb+hJZFJ1AD6InbHBf1APAeWYK
         dEouRrH2Wk7NRB2ciV/4ff2DVYr0kTl47BeD96kIAV4PFYuR2+TRklr+NmunQbC51qUM
         +HhVMMQtXImtuIcUQgdBhehfQSNF+sAljpBLC/lfkT02trtpgWu2mZ96zkHs2ypSx15x
         YWX3p3M+o4fw2YI0uX2coi51w6Mjlwdtx2cA5VO19lkKsxEPFr4mvC17ji+gMEh2X57Q
         fjFQ==
X-Gm-Message-State: ACrzQf0QHmscedEkRKEiniHkrRoXv+ycvk5X9eHOnij3gkWOMfwonuCc
        rphrvtemja+4h1K19os+ENS3YA==
X-Google-Smtp-Source: AMsMyM43sU6MM8cUoob4M5l0eYTi46ZkJ/Sn1rji1oXq0MyTlZzSxWdnSJ0i8i7LnsB0rOZ1Ao4DSA==
X-Received: by 2002:a19:5e50:0:b0:497:a331:91d9 with SMTP id z16-20020a195e50000000b00497a33191d9mr4876766lfi.162.1664006740286;
        Sat, 24 Sep 2022 01:05:40 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y2-20020a2e5442000000b0026c41574790sm1696668ljd.30.2022.09.24.01.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 01:05:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 25/32] dt-bindings: pinctrl: qcom,qcm2290: do not require function on non-GPIOs
Date:   Sat, 24 Sep 2022 10:04:52 +0200
Message-Id: <20220924080459.13084-26-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
References: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
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

Certain pins, like SDcard related, do not have functions and such should
not be required.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,qcm2290-pinctrl.yaml        | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
index 5324b61eb4f7..89453cb60c12 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
@@ -60,7 +60,6 @@ patternProperties:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
 
     properties:
       pins:
@@ -116,6 +115,16 @@ patternProperties:
     required:
       - pins
 
+    allOf:
+      - $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
+      - if:
+          properties:
+            pins:
+              pattern: "^gpio([0-9]|[1-9][0-9]|1[0-1][0-9]|12[0-6])$"
+        then:
+          required:
+            - function
+
     additionalProperties: false
 
 allOf:
-- 
2.34.1

