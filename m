Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6505D655D1E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 13:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiLYMBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 07:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiLYMAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 07:00:40 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAA76469
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 03:59:47 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id m6so2484387lfj.11
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 03:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ExVoiUpX6U97IwTnko2fEfj7v9D1prV4olDEP5D5io=;
        b=mj/BnUSLmbbHa0rGlrkk358XG2VGf0Z29EEwI1IbHMM+uP8kiNxH2zkAMFTE7cHDdg
         xTvmXlEYsZhcnY/DltcrjplkB2l5+E999eUQ0exHvZNCtvrojJIRBb/hfRYxrQDOJ5zH
         IL7EGweWf6TfN8A7QG0uQ6kulpLHov+jrfFWHYj3yCMeEaO4SUo+jci5uAnMamGFSwpU
         yWEzhJwI+6OgRQiUsw+sExYUQ5VN+pESPqV2jrjGwIMozJ70P13YMhwKV8IuCHF6GDu0
         Ll7bc7a2yyowP3FLnOZXJlG+ToLQ/bhY/ag9ntDIslgwxND+MY4gYps3/CT0x8PPRqC1
         J6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ExVoiUpX6U97IwTnko2fEfj7v9D1prV4olDEP5D5io=;
        b=e/Nr59c+X30BsLEfpDZpe5u7zLdo/+ehZFxZxqgwji8rPz96x61gTp2I86M426kJWp
         P+q0YTpARkfV2aQgM6Jj1PljMfR8C1axaXCJ8fnxFM9fYWgydeHBfwR8fqvLIo+1AnIy
         R6LfOcyvtmBsTJd9/e7cEl6ddtgnF3sh0BB9Q0seb6uDCS+WBbaLAo3D8uuZ1s0RbkJa
         Y500K8vEaTWbRTMrUgmczzK1OwSUWk1EutTqUX2g63QAhRvS2UIVKEKhJxYJqxxGGd1v
         Bl4S+KyoCqmVwWX+aJcJN6z5wuBeMNVxHTg9gVb8F1rMM38OWZD3V2zvQ6zUhyXqEyjC
         Svpg==
X-Gm-Message-State: AFqh2koGg7luIxk+eZAc66vsYoe3USa3caczDwKW+rNpqZdTEoo8KQwQ
        jEo+a432902pcMSg26rOURMTtw==
X-Google-Smtp-Source: AMrXdXvRoHODcVE1Z/m7I9inLxGRn9KGvmQR6hYnkIUmcPWQwFWh03XIBatwnpiar+kQVD3SCsa+Zg==
X-Received: by 2002:a05:6512:3d9e:b0:4c0:2b07:e6e7 with SMTP id k30-20020a0565123d9e00b004c02b07e6e7mr5379114lfv.58.1671969586994;
        Sun, 25 Dec 2022 03:59:46 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v10-20020ac258ea000000b004b501497b6fsm1338615lfo.148.2022.12.25.03.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 03:59:46 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: phy: qcom,sc7180-qmp-usb3-dp-phy: correct SC7280 compatibles
Date:   Sun, 25 Dec 2022 12:59:43 +0100
Message-Id: <20221225115944.55425-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

USB3 DP PHY on SC7280 is used with SM8250 fallback:

  sc7280-herobrine-evoker.dtb: phy-wrapper@88e9000: compatible: ['qcom,sc7280-qmp-usb3-dp-phy', 'qcom,sm8250-qmp-usb3-dp-phy'] is too long

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../phy/qcom,sc7180-qmp-usb3-dp-phy.yaml        | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml
index d9d0ab90edb1..97d94c685d7b 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml
@@ -19,12 +19,17 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - qcom,sc7180-qmp-usb3-dp-phy
-      - qcom,sc7280-qmp-usb3-dp-phy
-      - qcom,sc8180x-qmp-usb3-dp-phy
-      - qcom,sdm845-qmp-usb3-dp-phy
-      - qcom,sm8250-qmp-usb3-dp-phy
+    oneOf:
+      - enum:
+          - qcom,sc7180-qmp-usb3-dp-phy
+          - qcom,sc8180x-qmp-usb3-dp-phy
+          - qcom,sdm845-qmp-usb3-dp-phy
+          - qcom,sm8250-qmp-usb3-dp-phy
+      - items:
+          - enum:
+              - qcom,sc7280-qmp-usb3-dp-phy
+          - const: qcom,sm8250-qmp-usb3-dp-phy
+
   reg:
     items:
       - description: Address and length of PHY's USB serdes block.
-- 
2.34.1

