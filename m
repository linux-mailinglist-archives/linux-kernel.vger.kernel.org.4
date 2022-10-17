Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC057601D29
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiJQXDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiJQXCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:02:17 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F441146E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:01:38 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id t25so7676892qkm.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJaaMRWb341YlNOp1Mot8yo+Re/+Aa6WFh4BRrXE4hI=;
        b=EGS0uvey1t9gNYIxj/uoq+MrNPse95ZJdvZjE92j1mfc3PanfFQZI/UiKyjbKnJspJ
         Oa7Err0EYk61P7QtubvQ1W2W6nTiRoWeLYOJoJhxfYyn71YFDWAqIXtYGMMjqcJ/hxB/
         i4e4PLx1u43mT3T1Q/laH7zsQESArTJnJiVfxAjvGNocXd6tfOfeR8ZQSNr5EKwjsb/2
         b0fVz1aSnBrmIo9umd25Al+kZpWyQWY0zbF0pCQ6h3XOydbwy0e6SsSB1b/ih2XCY996
         HNbCEspy+sVfiEgRy3shPRJwH/ALk0IEQeshqNQ1T2Ya6vzcJe6OlpPoBfwthOu3kQyZ
         +Mmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJaaMRWb341YlNOp1Mot8yo+Re/+Aa6WFh4BRrXE4hI=;
        b=YjDgg8h+5FwJmbHGSdMLL5righNlo2bTW3bfl/PCtvvHEEI20K3o6qbgHbl89hdh51
         kEFRaK3PY6VvGaaAAXHQAuTef5HvJsPFgTCvLw2OERT3Fd1Vwez45yA70eUNtHuCAJE3
         OMbuiz5rTt76I/+FkGEa8OzYgI7anSkhfOnFEGInuAxmi4kqPkZcHj+rvNuyhY+tTkQP
         lSlIPpm7MLsbV1eeC9/fAqh97PAZG7i3cpzfHayZo8iYsrVYuP8hAx2GPPU7tC4g7iGO
         9nn6nxh89NxAIKoXBSVauV4Bu1EtLrouTWhIibR4Mh5bbf9MNjFafcri0td9/pC6QQCR
         f+7Q==
X-Gm-Message-State: ACrzQf2stKkk/ruzy2Qa/FePzOT7Pb2wrzrP+BOnGZAgwa3IdCqGQ0hw
        flXiyaXDQK9876AfUEeR07Dkiw==
X-Google-Smtp-Source: AMsMyM4TnQ6tLduScy3vKVUzlQDSlF4Th6ubYfN1eYtt94HGcdmoy57ATwcfhknips/ayftP8NYTqQ==
X-Received: by 2002:a05:620a:4015:b0:6ed:a8db:32c0 with SMTP id h21-20020a05620a401500b006eda8db32c0mr9819327qko.656.1666047697721;
        Mon, 17 Oct 2022 16:01:37 -0700 (PDT)
Received: from localhost.localdomain (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id fg11-20020a05622a580b00b0039cb9b6c390sm729670qtb.79.2022.10.17.16.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 16:01:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 33/33] dt-bindings: pinctrl: qcom: adjust description
Date:   Mon, 17 Oct 2022 19:00:12 -0400
Message-Id: <20221017230012.47878-34-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017230012.47878-1-krzysztof.kozlowski@linaro.org>
References: <20221017230012.47878-1-krzysztof.kozlowski@linaro.org>
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

Drop "binding" from description, because the field should describe the
hardware.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml    | 5 ++---
 .../devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml    | 5 ++---
 .../devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml    | 5 ++---
 .../devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml     | 5 ++---
 .../devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml      | 5 ++---
 5 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
index 2b9638dbd31d..93f231c7a3b4 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
@@ -9,9 +9,8 @@ title: Qualcomm Technologies, Inc. IPQ6018 TLMM block
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
 
-description: |
-  This binding describes the Top Level Mode Multiplexer block found in the
-  IPQ6018 platform.
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm IPQ6018 SoC.
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
index 6d56d2ef1242..3b79f5be860b 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
@@ -9,9 +9,8 @@ title: Qualcomm Technologies, Inc. MSM8226 TLMM block
 maintainers:
   - Bjorn Andersson <bjorn.andersson@linaro.org>
 
-description: |
-  This binding describes the Top Level Mode Multiplexer block found in the
-  MSM8226 platform.
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm MSM8226 SoC.
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml
index cfe4664f6fb3..c9a4a79e8d01 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml
@@ -9,9 +9,8 @@ title: Qualcomm Technologies, Inc. MSM8953 TLMM block
 maintainers:
   - Bjorn Andersson <bjorn.andersson@linaro.org>
 
-description: |
-  This binding describes the Top Level Mode Multiplexer block found in the
-  MSM8953 platform.
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm MSM8953 SoC.
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
index d70ab12f227d..36502173cb79 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
@@ -9,9 +9,8 @@ title: Qualcomm Technologies, Inc. SC7280 TLMM block
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
 
-description: |
-  This binding describes the Top Level Mode Multiplexer block found in the
-  SC7280 platform.
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm SC7280 SoC.
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
index 30f4b3147768..a76117e41d93 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
@@ -9,9 +9,8 @@ title: Qualcomm Technologies, Inc. SDX55 TLMM block
 maintainers:
   - Vinod Koul <vkoul@kernel.org>
 
-description: |
-  This binding describes the Top Level Mode Multiplexer block found in the
-  SDX55 platform.
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm SDX55 SoC.
 
 properties:
   compatible:
-- 
2.34.1

