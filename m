Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1506629944
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiKOMxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiKOMxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:53:16 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE0E27DEB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:53:15 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id k19so17384239lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A0aVE2Vm75FnX45DS6H+N0+bh1Fym8h1oNgifah97LI=;
        b=TZYEMDIsfylrpXElIbq2FfxDowrQafjfPMu+JkDdlXWDvpVKBuKztENdYIxcUO2blr
         NZt79bd1h5j/Be90jj4YHnkaq18CGKzCc9CFWZU4TdOAvfQCpuEa7eOb6j9yyyTISPK4
         GWWcsmdWiZWMtzG6T+wh3tkxp2+Z43tRIq7JBVtjdThL8Etu1d5oLe9UtezRJM83efm6
         9uRuCoj5/wS1vNSTVkM0XEtlqpmAV38xLp8Z5KgHWPGMfMkHHNH9jeBsb3C/8fURILRk
         bwsapGWHSRsXgkEvqqhSjduhO9ZMnMFgKz8ILgYlQIDTVQHrRaJUR7kMNc5T8tT5o+6h
         oP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A0aVE2Vm75FnX45DS6H+N0+bh1Fym8h1oNgifah97LI=;
        b=RwCuXYNvS35N2iA6JCtzqIlJMzcu4MQUfMQny9MChXtrAMZkvhLZi7JQbZyixe/ODM
         lt3o86mDVW0Q/wdJI9JAEsnmg6qLmUB+rTpft6Ay4ioUXSZUyTlL74YnZpJhPYjmGaA+
         ZIj52eVj/czXpIh+/+FH7MB6Iu7pbhrBdIO9asQ5B4r4A+Y0ocLFKkiJO6u2UBO+wXDF
         mR7+1OvLkktCUwcF+ZPlkCKkhDXCfk4mPta/km36vFE/+kpKtDp43k/V5yyw6mmqjgoI
         CGnoZGLMXuAuoJWYSQ9MH9eNgxPxnhRodq2HL7sIeKZXRD21H1GlspElMMGC5kmoTXul
         mRww==
X-Gm-Message-State: ANoB5pkKPlkUENBr+MWU2JKcBBT1lsnx+ajvzIjCc3IogX6bOCZxUbnh
        c1Nm5GrWxkpPnpNJfawFJ0XUKw==
X-Google-Smtp-Source: AA0mqf64JEQ7hBw+k88FcuUEk+S7j1SeEfj3LtvIwpUBJaQuCyDwMTeM0NbrlrXkh3lRsm2Z685URg==
X-Received: by 2002:a05:651c:10b8:b0:26e:8e6f:3c4 with SMTP id k24-20020a05651c10b800b0026e8e6f03c4mr5950160ljn.113.1668516793996;
        Tue, 15 Nov 2022 04:53:13 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d8-20020a056512368800b0049110ba325asm2177224lfs.158.2022.11.15.04.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 04:53:13 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] dt-bindings: PCI: qcom: add MSM8998 specific compatible
Date:   Tue, 15 Nov 2022 13:53:07 +0100
Message-Id: <20221115125310.184012-1-krzysztof.kozlowski@linaro.org>
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

Add new compatible for MSM8998 (compatible with MSM8996) to allow
further customizing if needed and to accurately describe the hardware.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 42 ++++++++++---------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 54f07852d279..0411e2e67661 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -16,25 +16,29 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - qcom,pcie-ipq8064
-      - qcom,pcie-ipq8064-v2
-      - qcom,pcie-apq8064
-      - qcom,pcie-apq8084
-      - qcom,pcie-msm8996
-      - qcom,pcie-ipq4019
-      - qcom,pcie-ipq8074
-      - qcom,pcie-qcs404
-      - qcom,pcie-sa8540p
-      - qcom,pcie-sc7280
-      - qcom,pcie-sc8180x
-      - qcom,pcie-sc8280xp
-      - qcom,pcie-sdm845
-      - qcom,pcie-sm8150
-      - qcom,pcie-sm8250
-      - qcom,pcie-sm8450-pcie0
-      - qcom,pcie-sm8450-pcie1
-      - qcom,pcie-ipq6018
+    oneOf:
+      - enum:
+          - qcom,pcie-ipq8064
+          - qcom,pcie-ipq8064-v2
+          - qcom,pcie-apq8064
+          - qcom,pcie-apq8084
+          - qcom,pcie-msm8996
+          - qcom,pcie-ipq4019
+          - qcom,pcie-ipq8074
+          - qcom,pcie-qcs404
+          - qcom,pcie-sa8540p
+          - qcom,pcie-sc7280
+          - qcom,pcie-sc8180x
+          - qcom,pcie-sc8280xp
+          - qcom,pcie-sdm845
+          - qcom,pcie-sm8150
+          - qcom,pcie-sm8250
+          - qcom,pcie-sm8450-pcie0
+          - qcom,pcie-sm8450-pcie1
+          - qcom,pcie-ipq6018
+      - items:
+          - const: qcom,pcie-msm8998
+          - const: qcom,pcie-msm8996
 
   reg:
     minItems: 4
-- 
2.34.1

