Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35024727A75
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjFHIvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbjFHIvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:51:18 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5B330C0
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 01:50:32 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9745c5fed21so56078866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 01:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686214231; x=1688806231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jVm0fhsNyk10WhIekiGem2q5QIQ6o6txtC4ntkrd51Q=;
        b=ZGzz5r4b575ZzlWyig0XGGzxar6+zK8gw7Jyz0wDHVB9LFFbul3V1P87N+8nYaYXQI
         MBmcg30HbUj50Lrc0QCi+Nv37lgqcOdyPK9/J4EXa6eXcnNOMkeh84/ofONzkYEG2fRf
         IPtGqxc4wQJ5h72vACNtcnXEbae9MxmdHiTMfXJmIpomgeY10r01oXFsnjKZAYb8G5LA
         HAIK8Ur2SF/J3z6Ydqjesotxs4SQLvskd+JlbW+oiVxWTBBrf8UoyH7APR5Q+7HXkY+u
         ZbVxmplqpBFm1cujdheR8PS17ZPMoJl6gVBcqh0I905CDBGvMXLP6qUolqwMq7L7S8Nq
         Jk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686214231; x=1688806231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVm0fhsNyk10WhIekiGem2q5QIQ6o6txtC4ntkrd51Q=;
        b=Vsde4BVMTvClBMJ/fUktDelRU0clnJUEDb8eEqI/3UEndrAFmn5fh2hSqClcaHNZtX
         ZcYTfIBum4+Mnrl84oWG3kBjIcJZtKN2oTqsO4qLT2I2DF16TY13Jo2ANA++q3fRVJP5
         xej89JmTgM5B+9gMMsgUPGmY+E/wx/NuwMmEOjNB3yrcKFLnAFmdtdSj2bZvqyz0lT7s
         2rub3egN+Qiu45jTsoge8IH/vR5dNgxHEFMF19NbHCAJqqHfZPEbGTPEqTxz5XMJHAzV
         VFdNLzxS49is6Y0VVYmFB7jRk+xA1y3wdzMlODtoOL1q7TWn7ock2ryvH/8ej1nLZSTj
         OrHg==
X-Gm-Message-State: AC+VfDxkFa1L+OGxvliJVV7X3zZN4dOf8x4tMczTkp8omfvi7geU9aL2
        2uti+2wh+fUc2pu6tz0rNnXXONkhXkut4siiyuo=
X-Google-Smtp-Source: ACHHUZ4pnN5cAyFjYUsGInH/tdkVvDcSKcCSn4zKfvrsA6R6pzv5+PGqhAmrFI8c2EPYKNODjDdUQQ==
X-Received: by 2002:a17:907:d29:b0:973:ea73:b883 with SMTP id gn41-20020a1709070d2900b00973ea73b883mr11133516ejc.66.1686214231091;
        Thu, 08 Jun 2023 01:50:31 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id gg24-20020a170906e29800b00974638e4a98sm410173ejb.24.2023.06.08.01.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 01:50:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ASoC: dt-bindings: qcom,wsa8840: Add WSA884x family of speakers
Date:   Thu,  8 Jun 2023 10:50:22 +0200
Message-Id: <20230608085023.141745-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for WSA8840/WSA8845/WSA8845H smart speaker amplifiers used
in Qualcomm QRD8550 board with SM8550 SoC.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/sound/qcom,wsa8840.yaml          | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml b/Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml
new file mode 100644
index 000000000000..a999f787aa4d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,wsa8840.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm WSA8840/WSA8845/WSA8845H smart speaker amplifier
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description:
+  WSA884X is a family of Qualcomm Aqstic smart speaker amplifiers using
+  SoundWire digital audio interface.
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: sdw10217020400
+
+  reg:
+    maxItems: 1
+
+  powerdown-gpios:
+    description: Powerdown/Shutdown line to use (pin SD_N)
+    maxItems: 1
+
+  '#sound-dai-cells':
+    const: 0
+
+  vdd-1p8-supply: true
+  vdd-io-supply: true
+
+required:
+  - compatible
+  - reg
+  - powerdown-gpios
+  - '#sound-dai-cells'
+  - vdd-1p8-supply
+  - vdd-io-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    soundwire-controller {
+        #address-cells = <2>;
+        #size-cells = <0>;
+
+        speaker@0,1 {
+            compatible = "sdw10217020400";
+            reg = <0 1>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&spkr_2_sd_n_active>;
+            powerdown-gpios = <&lpass_tlmm 18 GPIO_ACTIVE_LOW>;
+            #sound-dai-cells = <0>;
+            sound-name-prefix = "SpkrRight";
+            vdd-1p8-supply = <&vreg_l15b_1p8>;
+            vdd-io-supply = <&vreg_l3g_1p2>;
+        };
+    };
-- 
2.34.1

