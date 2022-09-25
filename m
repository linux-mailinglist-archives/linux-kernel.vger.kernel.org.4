Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B221D5E9628
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 23:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiIYVSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 17:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiIYVSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 17:18:33 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64012A96E;
        Sun, 25 Sep 2022 14:18:32 -0700 (PDT)
Received: from g550jk.. (2a02-8388-6582-fe80-0000-0000-0000-0006.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::6])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id ACD85C9C11;
        Sun, 25 Sep 2022 21:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1664140681; bh=sTYvx6bH0IsQJZ4TUfqZvxdBUTU/q50uwQG9uFwSEcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lNBOxqeHJK3E0Wvhc7SSH6l45Wp0Wkb6YZdUuDRLXhiVx2M3F+ICLv381xcTOOTSX
         +EQbgLaxjo9DJ4YBTXYbOe07QT5FmgRdPQXM9xW5rInRKef3GAjpPdsNfKmkf2PRqv
         TFExrMvggQGLLKMrk5Y51M/M841CL64VTkKmC3uQ=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: mfd: qcom,spmi-pmic: support more types
Date:   Sun, 25 Sep 2022 23:17:44 +0200
Message-Id: <20220925211744.133947-2-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220925211744.133947-1-luca@z3ntu.xyz>
References: <20220925211744.133947-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* 'adc@' is either spmi-iadc or spmi-vadc
* 'charger@' is either pm8941-charger or pm8941-coincell
* 'dcdc@' is usb-vbus-regulator

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 16ade0fa2d33..e54fb5d64ef8 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -105,7 +105,9 @@ properties:
 patternProperties:
   "^adc@[0-9a-f]+$":
     type: object
-    $ref: /schemas/iio/adc/qcom,spmi-vadc.yaml#
+    oneOf:
+      - $ref: /schemas/iio/adc/qcom,spmi-iadc.yaml#
+      - $ref: /schemas/iio/adc/qcom,spmi-vadc.yaml#
 
   "^adc-tm@[0-9a-f]+$":
     type: object
@@ -115,6 +117,16 @@ patternProperties:
     type: object
     additionalProperties: true # FIXME qcom,pm8916-wcd-analog-codec binding not converted yet
 
+  "charger@[0-9a-f]+$":
+    type: object
+    oneOf:
+      - $ref: /schemas/power/supply/qcom,pm8941-charger.yaml#
+      - $ref: /schemas/power/supply/qcom,pm8941-coincell.yaml#
+
+  "^dcdc@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/regulator/qcom,usb-vbus-regulator.yaml#
+
   "extcon@[0-9a-f]+$":
     type: object
     $ref: /schemas/extcon/qcom,pm8941-misc.yaml#
-- 
2.37.3

