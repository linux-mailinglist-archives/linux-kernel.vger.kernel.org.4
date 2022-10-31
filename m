Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A97613D43
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiJaSZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJaSZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:25:07 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54F4D80;
        Mon, 31 Oct 2022 11:25:05 -0700 (PDT)
Received: from g550jk.arnhem.chello.nl (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 2BA7CD03F1;
        Mon, 31 Oct 2022 18:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1667240704; bh=7iBgek2JhQmhnFtXHoGRmTx0yH0Ccd14S9GW/5t6pqA=;
        h=From:To:Cc:Subject:Date;
        b=h7dN2NmmyBT7y2iKa4vKczh+OqKqzBYxukUc4OiQJiWi4rjECNgRpuJAcKgEkLWOD
         Se47FJJP5crCFoSPZf54v0Xt/EsF+ksYGXU2FzZ7TCsLBA78jELvmuFOW18ZIkyCIj
         JeWzQx8jByRKd5zACLqDNcXxkeyzRQSri+kyYNsY=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afd@ti.com, Luca Weiss <luca@z3ntu.xyz>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio/adc: qcom,spmi-iadc: use double compatibles
Date:   Mon, 31 Oct 2022 19:24:54 +0100
Message-Id: <20221031182456.952648-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As in other bindings, let's use specific compatibles together with the
fallback compatible. Adjust the bindings for it.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
* New patch

 .../devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml        | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
index 2a94db688830..fa855baa368c 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
@@ -18,7 +18,10 @@ description: |
 
 properties:
   compatible:
-    const: qcom,spmi-iadc
+    items:
+      - enum:
+          - qcom,pm8941-iadc
+      - const: qcom,spmi-iadc
 
   reg:
     description: IADC base address and length in the SPMI PMIC register map
@@ -50,7 +53,7 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
         pmic_iadc: adc@3600 {
-            compatible = "qcom,spmi-iadc";
+            compatible = "qcom,pm8941-iadc", "qcom,spmi-iadc";
             reg = <0x3600>;
             interrupts = <0x0 0x36 0x0 IRQ_TYPE_EDGE_RISING>;
             qcom,external-resistor-micro-ohms = <10000>;
-- 
2.38.1

