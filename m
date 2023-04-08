Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BC06DBB4B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 15:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjDHNtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 09:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjDHNs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 09:48:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE78903F;
        Sat,  8 Apr 2023 06:48:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB65961508;
        Sat,  8 Apr 2023 13:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A3FC4339C;
        Sat,  8 Apr 2023 13:48:31 +0000 (UTC)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] dt-bindings: clock: qcom,gcc-sc7280: document CX power domain
Date:   Sat,  8 Apr 2023 15:48:20 +0200
Message-Id: <20230408134820.76050-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230408134820.76050-1-krzysztof.kozlowski@linaro.org>
References: <20230408134820.76050-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GCC clock controller needs CX power domain, at least according to
DTS:

  sc7280-herobrine-crd-pro.dtb: clock-controller@100000: Unevaluated properties are not allowed ('power-domains' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/clock/qcom,gcc-sc7280.yaml         | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.yaml
index 947b47168cec..ff0b18bbb0fc 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.yaml
@@ -43,6 +43,10 @@ properties:
       - const: ufs_phy_tx_symbol_0_clk
       - const: usb3_phy_wrapper_gcc_usb30_pipe_clk
 
+  power-domains:
+    items:
+      - description: CX domain
+
 required:
   - compatible
   - clocks
@@ -56,6 +60,8 @@ unevaluatedProperties: false
 examples:
   - |
     #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
     clock-controller@100000 {
       compatible = "qcom,gcc-sc7280";
       reg = <0x00100000 0x1f0000>;
@@ -71,6 +77,7 @@ examples:
                      "pcie_1_pipe_clk", "ufs_phy_rx_symbol_0_clk",
                      "ufs_phy_rx_symbol_1_clk", "ufs_phy_tx_symbol_0_clk",
                      "usb3_phy_wrapper_gcc_usb30_pipe_clk";
+      power-domains = <&rpmhpd SC7280_CX>;
       #clock-cells = <1>;
       #reset-cells = <1>;
       #power-domain-cells = <1>;
-- 
2.34.1

