Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145D46744DF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjASVjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjASVhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:37:34 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0044FADD;
        Thu, 19 Jan 2023 13:27:19 -0800 (PST)
Received: from localhost.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 7B5E71F891;
        Thu, 19 Jan 2023 22:26:42 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jonathan Cameron <jic23@kernel.org>, iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: Require generic adc-chan name for channel nodes
Date:   Thu, 19 Jan 2023 22:26:31 +0100
Message-Id: <20230119212632.185881-2-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230119212632.185881-1-marijn.suijten@somainline.org>
References: <20230119212632.185881-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed in [1] it is more convenient to use a generic adc-chan node
name for ADC channels while storing a friendly - board-specific instead
of PMIC-specific - name in the label, if/when desired to overwrite the
channel description already contained (but previously unused) in the
driver [2].

Replace the .* name pattern with the adc-chan literal, but leave the
label property optional for bindings to choose to fall back a channel
label hardcoded in the driver [2] instead.

[1]: https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/T/#u
[2]: https://lore.kernel.org/linux-arm-msm/20230116220909.196926-4-marijn.suijten@somainline.org/

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 .../bindings/iio/adc/qcom,spmi-vadc.yaml         | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index bd6e0d6f6e0c..9b1a60fe7599 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -54,7 +54,7 @@ required:
   - '#io-channel-cells'
 
 patternProperties:
-  "^.*@[0-9a-f]+$":
+  "^adc-chan@[0-9a-f]+$":
     type: object
     additionalProperties: false
     description: |
@@ -148,7 +148,7 @@ allOf:
 
     then:
       patternProperties:
-        "^.*@[0-9a-f]+$":
+        "^adc-chan@[0-9a-f]+$":
           properties:
             qcom,decimation:
               enum: [ 512, 1024, 2048, 4096 ]
@@ -171,7 +171,7 @@ allOf:
 
     then:
       patternProperties:
-        "^.*@[0-9a-f]+$":
+        "^adc-chan@[0-9a-f]+$":
           properties:
             qcom,decimation:
               enum: [ 256, 512, 1024 ]
@@ -194,7 +194,7 @@ allOf:
 
     then:
       patternProperties:
-        "^.*@[0-9a-f]+$":
+        "^adc-chan@[0-9a-f]+$":
           properties:
             qcom,decimation:
               enum: [ 250, 420, 840 ]
@@ -217,7 +217,7 @@ allOf:
 
     then:
       patternProperties:
-        "^.*@[0-9a-f]+$":
+        "^adc-chan@[0-9a-f]+$":
           properties:
             qcom,decimation:
               enum: [ 85, 340, 1360 ]
@@ -292,16 +292,18 @@ examples:
             #io-channel-cells = <1>;
 
             /* Other properties are omitted */
-            xo-therm@44 {
+            adc-chan@44 {
                 reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
                 qcom,ratiometric;
                 qcom,hw-settle-time = <200>;
+                label = "xo_therm";
             };
 
-            conn-therm@47 {
+            adc-chan@47 {
                 reg = <PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
                 qcom,ratiometric;
                 qcom,hw-settle-time = <200>;
+                label = "conn_therm";
             };
         };
     };
-- 
2.39.1

