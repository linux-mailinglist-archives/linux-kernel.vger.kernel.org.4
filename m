Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD115F6956
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiJFOKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbiJFOIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:08:46 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853B6ABD6C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:07:49 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id r14so2903469lfm.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 07:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=YdAvou5XOvhniH+gopyjkOoF2hRzFhgukfX/Gx2EKtI=;
        b=mdBykJor/p0t0D+qG3r23aOEUG5QTTZQ3FBicP97W4zQgP2GtL79PE1JDl8uRDQIbq
         dCmjC4wyWxUa2XaOKY0Rb2l4/YbroqMa7FwIQAI+U5VrU0M+isDoJod1m/FkwceuWsy+
         PmiEIoitzsdfjSNuew+GG7mdi24PdJqt8gAcX8Vftp3ea1RjpNVPY49H7yWg/LueT8Va
         X504AuZYxPch3NAOITTHo8gN61FDOZj1kOQNFz/IMAhEDBCwWCaxtzg/PDjLUc/ydPQ3
         rvfvJuRjHm4Q07KaYOP/5qiDAZLQLB/9SuTyWPOBJMOwEXlIo3VYJq+sS6ZYBCRefodG
         GKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YdAvou5XOvhniH+gopyjkOoF2hRzFhgukfX/Gx2EKtI=;
        b=17QKQ+jTvm7QErUc58xxGlbsWmzAAjjTMi4sRY/b3E35XeVTg2yvTYfVuA+yXTdmaP
         zoXd7YILY7Ks31g+PvewFS/D7gK88g27s7tubqjPb2elx5vBAbsP2b9HUSSsMG95uPs0
         9Qa3H6+gNW9YK2zXeMXLvtKj04XPpK9rIDqwZ+i+26c7fdPF90h+RaEwBpKY9IcKrDCf
         lmbISFtje/s8IgnIq0XGrbAzfhgOHWQfOHTpZ6KfwFvtF02ABZcJGvdL3FLRndTuV2bh
         g1NV2IOHad8oxMwJ4XVMkO0YYys15yYHE3Dj+wvX4hbEfBmSrv789/HHS48PIaG+V6V0
         EeLg==
X-Gm-Message-State: ACrzQf3ghIaErzbFhHKkXFP1DgTyTs2J4abHGSoeHJO8vGOE/Eh/aABh
        AhGzL90XT6r1lEayF8Fr3W5+KQ==
X-Google-Smtp-Source: AMsMyM5Wc0R7+uRhNp2I86HUNA/4DTmOhMnudSFlI9YmNeKReN/AjQ4Ap3mKwX6l58vohzhEnLpPTA==
X-Received: by 2002:a05:6512:a93:b0:4a2:6bd4:e9d9 with SMTP id m19-20020a0565120a9300b004a26bd4e9d9mr59857lfu.100.1665065247331;
        Thu, 06 Oct 2022 07:07:27 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z3-20020a056512370300b004a2386b8ce8sm1833929lfr.211.2022.10.06.07.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:07:26 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 34/34] dt-bindings: pinctrl: qcom: adjust description
Date:   Thu,  6 Oct 2022 16:06:37 +0200
Message-Id: <20221006140637.246665-35-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
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

Drop "binding" from description, because the field should describe the
hardware.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml    | 5 ++---
 .../devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml    | 5 ++---
 .../devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml    | 5 ++---
 .../devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml     | 5 ++---
 .../devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml    | 2 +-
 .../devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml      | 5 ++---
 6 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
index bf84649593ef..6f9b92afb621 100644
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
index 23868cdf4e03..3874908ff7de 100644
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
index 19d16cc9d749..5c6a0d057787 100644
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
index bdb896e5682f..5f87f15dcd1a 100644
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
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml
index 071f416f74b2..52e5571cfbf0 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Bjorn Andersson <bjorn.andersson@linaro.org>
 
 description:
-  Top Level Mode Multiplexer pin controller node in Qualcomm SC8180X SoC.
+  Top Level Mode Multiplexer pin controller in Qualcomm SC8180X SoC.
 
 allOf:
   - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
index 2d7097edfb40..00116a045f6e 100644
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

