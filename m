Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E5E6552A9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 17:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiLWQTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 11:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiLWQSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 11:18:44 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57BF1AF28
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:18:42 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id z26so7618083lfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ssdvzhuee2XQDm50/3Dh08z9mzFiguEgbpNiLUtPtQk=;
        b=UYjsne41U/8//XGrEZ6dq42DkOf4pl/H4mBwv95l7LC/HPOBxZBwIOHP512CSawS/V
         ZXRxPXvOBUKILtZWA6ZCHDGiTWcfnPi5EujmFDoS/QYeXBeVfd9qGhjN0xdyqARDD2h9
         WV4xJo5w7mJN3fK5yuHO7DCiAZh1cBTovHrXChNvE3TCggPvirfwVf/stzpztbef/jDR
         ox7SMWCthNCXopIH0fL+A93HX0+5N2zKKbKGXHEEwh3wS/HFJB7V/lfin8nsd2xAAK2p
         ZqNj2j1L4PYBVZYbqF1Y3cQ7ARbhV53zt3b2HXhYSrm+70WsNa9pUsC1Yux6sObo/tEQ
         tPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ssdvzhuee2XQDm50/3Dh08z9mzFiguEgbpNiLUtPtQk=;
        b=fkLZZkN+zsnh+t4jSxT5SXLvQCE/uGrw720ElWhWGNjY169ZhnT3biETvW1uMC4wAA
         W63moA4DneSUzJeRAwJ18CvZzhBmo4OmWvW/4KcjO9ajvEdN0Kab4TQ+vd5xy2Mth/ph
         lXX+BsjoUjsYZN5ruPKRCuVHA9YvizogUjsMQcDmkTRXSMKG1362pzmcuAc7sTPEEhan
         wbKvOQNNyM3SB4X18lOUMIJXrAVL6p2YP0RdD0g365GZTc44HEUHYwE/DoGdQoC6VnIR
         /EK+miuU/92yOsbfrUX4ZLXm+zP1N2fgCiterlHJty3KjnTonnrP0y90gQKi0+sMab9A
         18fQ==
X-Gm-Message-State: AFqh2kofB6WbElojTz3FodIKgjkeosQyqErJE/FG3HqmL0nQuD1+MARL
        s6q7x+/bILhPS3b8Ycrey7wpLg==
X-Google-Smtp-Source: AMrXdXsWw512KHluUBDJzRaXuHifwQ7aus50gdJRaT8b2kbKkEG6+slseJlplBRP71EZhfMrDmokPQ==
X-Received: by 2002:a19:f80c:0:b0:4b5:853c:ed30 with SMTP id a12-20020a19f80c000000b004b5853ced30mr2676054lff.23.1671812321141;
        Fri, 23 Dec 2022 08:18:41 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id n18-20020a05651203f200b004b4f2a30e6csm581360lfq.0.2022.12.23.08.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 08:18:40 -0800 (PST)
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
Subject: [PATCH 1/4] dt-bindings: phy: qcom,usb-snps-femto-v2: use fallback compatibles
Date:   Fri, 23 Dec 2022 17:18:32 +0100
Message-Id: <20221223161835.112079-1-krzysztof.kozlowski@linaro.org>
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

Document SoC-specific compatibles with generic fallback (e.g.
qcom,usb-snps-hs-7nm-phy) already used in DTSI.  Add SoC-specific
compatibles for PHY on SDX55 and SDX65.

This disallows usage of the qcom,usb-snps-hs-5nm-phy and
qcom,usb-snps-hs-7nm-phy generic compatibles alone.  Do not touch
remaining two compatibles - qcom,usb-snps-femto-v2-phy and
qcom,sc8180x-usb-hs-phy - because there are no upstream users, so not
sure what was the intention for them.

This fixes warnings like:

  sa8295p-adp.dtb: phy@88e5000: compatible: 'oneOf' conditional failed, one must be fixed:
    ['qcom,sc8280xp-usb-hs-phy', 'qcom,usb-snps-hs-5nm-phy'] is too long
    'qcom,sc8280xp-usb-hs-phy' is not one of ['qcom,sm8150-usb-hs-phy', 'qcom,sm8250-usb-hs-phy', 'qcom,sm8350-usb-hs-phy', 'qcom,sm8450-usb-hs-phy']
    'qcom,usb-snps-hs-7nm-phy' was expected

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml  | 33 +++++++++++--------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
index 68e70961beb2..85d405e028b9 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
@@ -14,18 +14,25 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - qcom,usb-snps-hs-5nm-phy
-      - qcom,usb-snps-hs-7nm-phy
-      - qcom,sc7280-usb-hs-phy
-      - qcom,sc8180x-usb-hs-phy
-      - qcom,sc8280xp-usb-hs-phy
-      - qcom,sm6375-usb-hs-phy
-      - qcom,sm8150-usb-hs-phy
-      - qcom,sm8250-usb-hs-phy
-      - qcom,sm8350-usb-hs-phy
-      - qcom,sm8450-usb-hs-phy
-      - qcom,usb-snps-femto-v2-phy
+    oneOf:
+      - enum:
+          - qcom,sc8180x-usb-hs-phy
+          - qcom,usb-snps-femto-v2-phy
+      - items:
+          - enum:
+              - qcom,sc8280xp-usb-hs-phy
+          - const: qcom,usb-snps-hs-5nm-phy
+      - items:
+          - enum:
+              - qcom,sc7280-usb-hs-phy
+              - qcom,sdx55-usb-hs-phy
+              - qcom,sdx65-usb-hs-phy
+              - qcom,sm6375-usb-hs-phy
+              - qcom,sm8150-usb-hs-phy
+              - qcom,sm8250-usb-hs-phy
+              - qcom,sm8350-usb-hs-phy
+              - qcom,sm8450-usb-hs-phy
+          - const: qcom,usb-snps-hs-7nm-phy
 
   reg:
     maxItems: 1
@@ -160,7 +167,7 @@ examples:
     #include <dt-bindings/clock/qcom,rpmh.h>
     #include <dt-bindings/clock/qcom,gcc-sm8150.h>
     phy@88e2000 {
-        compatible = "qcom,sm8150-usb-hs-phy";
+        compatible = "qcom,sm8150-usb-hs-phy", "qcom,usb-snps-hs-7nm-phy";
         reg = <0x088e2000 0x400>;
         #phy-cells = <0>;
 
-- 
2.34.1

