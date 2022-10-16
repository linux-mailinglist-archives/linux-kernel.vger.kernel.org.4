Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E18A6001E5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiJPREN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiJPRDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:03:32 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45B4444B6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:02:38 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id y10so6240142qvo.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88CQD2qxJDDsWpeM6Y7JxzJKMImZlbT1MdksUVYxP2A=;
        b=Q7DshXbW3Kh8dMen2kXAzuuwLTXXbkQ8eqZitiJ108W5Z/TNed1BhLSsq9FY+nWC+F
         +81gdZG8zLzqji+QP1iJ6KyCQwFvQ9xZ/OSMGh/dx4QIqZI0VMAnwqpVg4y9RgoVWY/j
         DF2zxSD72e4Wc9VUA6/cGoLEGKL1sLFmC7EerYEMEKDHEsV/R/31j6cUBtiUUBhIIWDQ
         7Ll734BUJrnkyhYr+JrzF2FdiFUz/W/ku9DEvTKm0fHC7LWXu3kKKK9hwSz8cl34G3mR
         3MP3xwXIFiIAOit93BBDZl0dON+VvkySZZLWh8Fvf6JZFJBDSJRFqRDmCDqcRIib6Z/t
         xw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88CQD2qxJDDsWpeM6Y7JxzJKMImZlbT1MdksUVYxP2A=;
        b=VtA+DKZRLrrweLuCsnkbj7cwUN+Eswh2BYNhk5eOELQQGB08esmJPx+vo2AillUf5E
         hqAiAMETaxYv0b8fuWVhd5yfbZqU0Qv0oK7DWmzfyKTAL8ftcuF+b5QwM714sCPLfLXj
         D2AMpce12/sD5+Buuiv/ui8M+aYsVmWUwP0MaSyMlUTVspEVBZLP/iGgUBJ1VK+RbIRL
         cdBfhQCiFPqhSJeRIQCYbq4PUmjtcf17ucFaUjPudTJ/Hn2wqxoisnJ6g9soCJX+zh8j
         k2yzxCfTpulc8jEQCwR0E+CciSPXDuBI1beCOrm5X9+8Fr7fvEk7mIzScdkEtr58UtnE
         t7uA==
X-Gm-Message-State: ACrzQf1/z3KIyTiqcndsO/4L6eYQfoloVDHCEB7ufqyv3E7fmva6fQ0n
        OaQ7SK0kTVI+F+J/oBlxOWUDRg==
X-Google-Smtp-Source: AMsMyM7Un0yufydn5PYV866XTIFaOxvpw7MiXEEHLc8xtUcTYvaipruph0nxPclNljBGvdo9yQDenQ==
X-Received: by 2002:a05:6214:29cb:b0:4b1:7991:e844 with SMTP id gh11-20020a05621429cb00b004b17991e844mr5791211qvb.72.1665939750484;
        Sun, 16 Oct 2022 10:02:30 -0700 (PDT)
Received: from krzk-bin.hsd1.pa.comcast.net ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id q6-20020a05620a0d8600b006ce7bb8518bsm7539967qkl.5.2022.10.16.10.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 10:02:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 26/34] dt-bindings: pinctrl: qcom,qcm2290: fix matching pin config
Date:   Sun, 16 Oct 2022 13:00:27 -0400
Message-Id: <20221016170035.35014-27-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
References: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
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

The TLMM pin controller follows generic pin-controller bindings, so
should have subnodes with '-state' and '-pins'.  Otherwise the subnodes
(level one and two) are not properly matched.  This method also unifies
the bindings with other Qualcomm TLMM and LPASS pinctrl bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pinctrl/qcom,qcm2290-pinctrl.yaml           | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
index 3f4f1c0360b5..5324b61eb4f7 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
@@ -50,8 +50,9 @@ patternProperties:
     oneOf:
       - $ref: "#/$defs/qcom-qcm2290-tlmm-state"
       - patternProperties:
-          ".*":
+          "-pins$":
             $ref: "#/$defs/qcom-qcm2290-tlmm-state"
+        additionalProperties: false
 
 '$defs':
   qcom-qcm2290-tlmm-state:
@@ -146,19 +147,19 @@ examples:
         gpio-ranges = <&tlmm 0 0 127>;
 
         sdc2_on_state: sdc2-on-state {
-            clk {
+            clk-pins {
                 pins = "sdc2_clk";
                 bias-disable;
                 drive-strength = <16>;
             };
 
-            cmd {
+            cmd-pins {
                 pins = "sdc2_cmd";
                 bias-pull-up;
                 drive-strength = <10>;
             };
 
-            data {
+            data-pins {
                 pins = "sdc2_data";
                 bias-pull-up;
                 drive-strength = <10>;
-- 
2.34.1

