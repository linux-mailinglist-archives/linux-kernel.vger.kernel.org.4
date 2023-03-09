Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612736B1E5D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjCIIiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjCIIhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:37:35 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B85CB4F6D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:36:21 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id cw28so3901020edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 00:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678350980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/SEpOpIkakui+KeMg3zz9ImxN2mZh/kxITlQnQLk08k=;
        b=cEEibjqkZl2hRaglcfe5+Mgr3v5dISNz87JPz0LxDpvCQv6l6Q1y1GWoaUa/Cmyun5
         iHJg9CCVjymvau/N6/QDGethK3WrtsIyRan//DtThOBj6kqxhXFo+9sr++Pv6cfliCPj
         Citgky1mUJFI9Wi3gQocYyyiFs4Vg+yxFAxbhrLWMIYtjMrvLNIqokSa9do64rVEPbEu
         vEmFuHrAvu1UWMeXQo0yFQbgwSTg92MZdrQh0D1rf+3IKaCUNpzH2lGbRdKs9vZPj/Jc
         xchqOfryqWSKTMKnKzBMs2Uxb2+AFsztEdiF8osr4seORuWc/jKG8g5RyB1pkO6K7lRE
         zL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678350980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/SEpOpIkakui+KeMg3zz9ImxN2mZh/kxITlQnQLk08k=;
        b=flTEpvI42sghw/xVtr2w1cHkQm4H+pdoeFgGmC9S8U6pijyNNdqiNen9aWxSuRrtOA
         6JfqqDKPS71DYizcV+vNsFQGShyl6Ma/la2Y7uU44MEpUlRKuv4rKe4BkmgbM/lmT/q9
         LvrpXT9hm4pfBExJhS+10knBi4RJdq2TocRZOQ6oXDfTSMYCUdAp8BaUDZvIBEIZpuZq
         clzdTtLGsxzwcW3aate6ggN6/R19er01wEV+82HCnAmPhEg4s/XOFpI5toxPTHFtNDAl
         Vu1rzEI9ZvvSK28dnPWcbOHPHvFrQ1OalrbTTXzxVm2IA2PeGoYpPkihsosaDwbkltCv
         wWYw==
X-Gm-Message-State: AO0yUKX03agOmA/3xHF1IzUmwKhfzZtJQ3utYs6QPbzBQtK4DsHsGtsK
        gvSf/ytYkM5076BUEC4G5Np0Cg==
X-Google-Smtp-Source: AK7set/H5Curkw44DShH7kUbF2c0b2yHw5SAle0NeduHbjUmzuXXVRvS05xJJ8IDoy/r/n8yxOqF3g==
X-Received: by 2002:a17:907:7f9f:b0:889:1eb1:7517 with SMTP id qk31-20020a1709077f9f00b008891eb17517mr26477271ejc.30.1678350979928;
        Thu, 09 Mar 2023 00:36:19 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090681c500b008d269233bd4sm8506217ejx.204.2023.03.09.00.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 00:36:19 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] dt-bindings: remoteproc: qcom,adsp: bring back firmware-name
Date:   Thu,  9 Mar 2023 09:35:48 +0100
Message-Id: <20230309083548.47205-1-krzysztof.kozlowski@linaro.org>
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

The firmware-name property was moved from common qcom,pas-common.yaml
binding to each device-specific schema, but the qcom,adsp.yaml was not
updated.

Fixes: cee616c68846 ("dt-bindings: remoteproc: qcom: adsp: move memory-region and firmware-name out of pas-common")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Use maxItems:1 (Rob)
---
 Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index b571efe6d550..2edadba91dfc 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -44,6 +44,10 @@ properties:
     maxItems: 1
     description: Reference to the reserved-memory for the Hexagon core
 
+  firmware-name:
+    maxItems: 1
+    description: Firmware name for the Hexagon core
+
 required:
   - compatible
   - memory-region
-- 
2.34.1

