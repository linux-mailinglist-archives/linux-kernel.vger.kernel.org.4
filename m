Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A16655B60
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 22:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiLXVoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 16:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiLXVoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 16:44:09 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A82CBC16
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 13:44:08 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b3so11473430lfv.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 13:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E6YG72yT6P2Xf4EVWM2/oNdMhJIz+PxjF3DxMSN/2MY=;
        b=L6W+ILV89UzVX4p54i0Aiyfx2Tj/2KmrlTtXJVEpnFUvSw3ZjBtUuLoZQqzAx4Vqkr
         PJBuaxG9/LCh4jNEFDEbr66CKzjdOcQn3v6IRjWzyu8LX/6UQvshUDAUsaMlkEhZJ6jg
         EE/3aRAt6A5+FxIpP2y49WOc7zmUXaf2vfQ+1eacxJQWkrot30TygoNd6aW8hIRWBrTV
         GWCgGZRPCJu/BdvW/+4wdSXmCYAYnY643YYxWQ5pqYdH83Z6xfv1voRe0VPym09rAKqw
         8aZwS/Zu+D6SyDB2+cGTI4EjKJ+MnbnFATjF3nF7oyCMj7IvY4+BEc9IVQsHk60Q+Ffn
         b0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6YG72yT6P2Xf4EVWM2/oNdMhJIz+PxjF3DxMSN/2MY=;
        b=1AWm7+LMKS/Gg8D/nbxaIQSuimu/TJ8BPBzay8srQKVOl+oRL0x1WJCjMAOjKIdsM8
         Gv0N9RwXPdr4NZDlNvrTg+hRAD0lEbbctcW1/Od8vCmqM2T4jytaY53x/4l0S7GiAZO2
         1LnLmCsfrU1ll8tFXJ3iUJs6wtiujeRhiCaLDsf04y7Y0cG5OIeMioSF0rZXZWampjTN
         t9KK1PRndrnwlTEebWmlouSMJvqwc328QZuRnh+9jXYRDJgCGHal3IiXzLg6TrIntPuX
         SHniSgYI38d+GwbSfPdkhyEUBwOxUnH185CSNvKDxh+Td+HCP0cNkK/11YtEKIKtlibL
         PEcg==
X-Gm-Message-State: AFqh2kqlrtO/ZOBJ5Djo6NCDIM8CdUuMEa0G455ub55EOQ+GvGNt7jjV
        DYHP8+8cP6UXwPg13ANnpRJW7Q==
X-Google-Smtp-Source: AMrXdXtLymnfGtKqLGeilvw3UM7v35kiK5lgoSFpB1glWTmqhP7U2DQerc3OoHluZnDBc5HE0oSiCQ==
X-Received: by 2002:a05:6512:168d:b0:4ca:fd5f:ce82 with SMTP id bu13-20020a056512168d00b004cafd5fce82mr794946lfb.49.1671918246547;
        Sat, 24 Dec 2022 13:44:06 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o4-20020ac25b84000000b004aa3d587c84sm1110903lfn.200.2022.12.24.13.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Dec 2022 13:44:06 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: clock: qcom,camcc-sm8250: extend clocks and power domains
Date:   Sat, 24 Dec 2022 22:44:04 +0100
Message-Id: <20221224214404.18280-1-krzysztof.kozlowski@linaro.org>
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

Add clocks and properties (power-domains, required-opps) already used in
SM8250 DTS:

  sm8250-hdk.dtb: clock-controller@ad00000: clocks: [[46, 10], [44, 0], [44, 1], [45]] is too long
  sm8250-hdk.dtb: clock-controller@ad00000: clock-names:0: 'bi_tcxo' was expected
  sm8250-hdk.dtb: clock-controller@ad00000: 'power-domains', 'required-opps' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/qcom,camcc-sm8250.yaml     | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,camcc-sm8250.yaml b/Documentation/devicetree/bindings/clock/qcom,camcc-sm8250.yaml
index 93ec1f598e6e..426335a2841c 100644
--- a/Documentation/devicetree/bindings/clock/qcom,camcc-sm8250.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,camcc-sm8250.yaml
@@ -21,12 +21,16 @@ properties:
 
   clocks:
     items:
+      - description: AHB
       - description: Board XO source
+      - description: Board active XO source
       - description: Sleep clock source
 
   clock-names:
     items:
+      - const: iface
       - const: bi_tcxo
+      - const: bi_tcxo_ao
       - const: sleep_clk
 
   '#clock-cells':
@@ -38,9 +42,18 @@ properties:
   '#power-domain-cells':
     const: 1
 
+  power-domains:
+    items:
+      - description: MMCX power domain
+
   reg:
     maxItems: 1
 
+  required-opps:
+    maxItems: 1
+    description:
+      OPP node describing required MMCX performance point.
+
 required:
   - compatible
   - reg
@@ -54,13 +67,16 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/qcom,gcc-sm8250.h>
     #include <dt-bindings/clock/qcom,rpmh.h>
     clock-controller@ad00000 {
       compatible = "qcom,sm8250-camcc";
       reg = <0x0ad00000 0x10000>;
-      clocks = <&rpmhcc RPMH_CXO_CLK>,
+      clocks = <&gcc GCC_CAMERA_AHB_CLK>,
+               <&rpmhcc RPMH_CXO_CLK>,
+               <&rpmhcc RPMH_CXO_CLK_A>,
                <&sleep_clk>;
-      clock-names = "bi_tcxo", "sleep_clk";
+      clock-names = "iface", "bi_tcxo", "bi_tcxo_ao", "sleep_clk";
       #clock-cells = <1>;
       #reset-cells = <1>;
       #power-domain-cells = <1>;
-- 
2.34.1

