Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD746D0347
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjC3LeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjC3LeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:34:11 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B79110D7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:34:10 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j11so24064799lfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680176049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cYbYycdmup7ooDPSWSxlw+wfKu3e5N7WtJR3yxq44lc=;
        b=m5vCBuGJqx23A5v6T6OBZyfULIxy1bEKyorWAYsxthAaAh8Ux79BG67VzvWO2dAw0v
         HzpXSAVyZlV2PXHkKaI9klWO20uBj9Y5D9PiqlGESLiioNu4mewtsVuUhmj6rC47FDMQ
         9R2Fcwg1NptgNmfG2JthKxOnyGHykCR9X0F0eTCJCL7SaUWDTYJPwIokZKQpvuriFr2K
         z45zgkJGpZZrkMTfsNjmatrlCjCt0MYqw/kQVZeh9hDAQi5mrHJAj9RnJ8DgE2Leke+E
         1bppdiJVzOtkLqBNWEd+L3Vz+45u3whZeUa9Kr5aL82S5GIEBheMp2UQw1QbOocBzLcx
         NQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680176049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYbYycdmup7ooDPSWSxlw+wfKu3e5N7WtJR3yxq44lc=;
        b=A0r4J5+XAf1dGIDZHbaNzOnfCJ5sCOvOXRU4reNOsZcik0nUYWrs3qadL1/xlAtwwU
         ZkPE83cmJf04VgG0vptDZLoPcGAjIY4oo9VqaXluN/WaSpoLpn1SFVtK2cT2wGxxtBJ5
         m0EUXlhn3O9fXgkF615U2G6CVdcPwobCEeZctqb5iusX2oSduCUVdKddcXRPozu9iq/T
         DXYa7zhcrbpcw0h+HY3zBHNGe6LqSP73YV645dFMf8/m5bP6zgsos9up8ceHu6589shR
         azmgXReQMCWG4MvkLlNTOPgP8H5VZLWOI4ccLxbwwTbnCfeUVl9USvP6DgBxaawbBpua
         iLRw==
X-Gm-Message-State: AAQBX9eAgzC+INOV6DE5l5wMaPTJ94hYEOvjXZiBg+JFjRBGgQnF53jM
        KYWBzRbMksYAjxWhBT+S96evYQ==
X-Google-Smtp-Source: AKy350a2EDWQYZVhflo+GOFEPA/WWu3pQ/gL6jWPerrjJR9OygRe+bysk5u936muBYaB+ATgDKZ6jQ==
X-Received: by 2002:ac2:5623:0:b0:4eb:c24:205b with SMTP id b3-20020ac25623000000b004eb0c24205bmr4787726lff.69.1680176048706;
        Thu, 30 Mar 2023 04:34:08 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 21-20020ac24855000000b004d5a720e689sm5877690lfy.126.2023.03.30.04.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 04:34:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5] ASoC: dt-bindings: qcom,lpass-va-macro: Add missing NPL clock
Date:   Thu, 30 Mar 2023 13:34:05 +0200
Message-Id: <20230330113405.55722-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several devices (e.g. SC8280XP and SM8450) expect a NPL (Near Pad Logic)
clock.  Add the clock and customize allowed clocks per each variant.
The clocks are also required by ADSP in all variants.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v4:
1. Rebased on:
   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-6.4

Changes since v3:
1. Only rebase. Other patches from this set were applied:
https://lore.kernel.org/all/168010864198.3244592.2114017565664183933.b4-ty@kernel.org/

Changes since v1:
1. New patch.
---
 .../bindings/sound/qcom,lpass-va-macro.yaml   | 68 ++++++++++++++++---
 1 file changed, 57 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
index 4cf778e3afdd..4a56108c444b 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
@@ -9,9 +9,6 @@ title: LPASS(Low Power Audio Subsystem) VA Macro audio codec
 maintainers:
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
-allOf:
-  - $ref: dai-common.yaml#
-
 properties:
   compatible:
     enum:
@@ -31,16 +28,12 @@ properties:
     const: 0
 
   clocks:
-    maxItems: 3
+    minItems: 1
+    maxItems: 4
 
   clock-names:
-    oneOf:
-      - items:   #for ADSP based platforms
-          - const: mclk
-          - const: macro
-          - const: dcodec
-      - items:   #for ADSP bypass based platforms
-          - const: mclk
+    minItems: 1
+    maxItems: 4
 
   clock-output-names:
     maxItems: 1
@@ -64,6 +57,59 @@ required:
   - compatible
   - reg
   - "#sound-dai-cells"
+  - clock-names
+  - clocks
+
+allOf:
+  - $ref: dai-common.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,sc7280-lpass-va-macro
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          items:
+            - const: mclk
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,sm8250-lpass-va-macro
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: mclk
+            - const: macro
+            - const: dcodec
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc8280xp-lpass-va-macro
+              - qcom,sm8450-lpass-va-macro
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: mclk
+            - const: macro
+            - const: dcodec
+            - const: npl
 
   - if:
       properties:
-- 
2.34.1

