Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACD05EE049
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbiI1PZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbiI1PZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:25:28 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAA25A884
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:25:08 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id i26so20885478lfp.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=/CE0pZsSoimzvz4KYprSdOM9XaT+5J4lkqToFLa8ZJg=;
        b=qYmooQpRI8RRzuGx+1tn5Z/QaCNWthTjBNWlnxyCtfNmqyjWOZnznR3Dfz5cjgqPZt
         4cW/6o+dWQ0CrXfgax+WB9gMMoiPBBehS6YJS0PvDK9uYaiBolIWKFME8mgNgtBkLDbf
         sLxLAptotu12FasL/ZcAXPFG7hxPY0+xPTorIVz/1HQtWTLCamDmiBWwRt+BL+9zyg0C
         JoZvA6OFspAsRg8OgNfYnuQnNFvshVIsgls4omoxOFS1uthMQ2lavketYz0LD8I5DzBd
         jJMEFvIx9frzRCJZXEbYSVKXFHnmxi3AgSZFcMae9ApDpjw10H33lcvVjI72iwdEvkOd
         LwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=/CE0pZsSoimzvz4KYprSdOM9XaT+5J4lkqToFLa8ZJg=;
        b=nMaPYxgil2RVLittQeDwN7QPB3yWSR9On6gEq43NjXT1eBnPpJk1qRVhk1SWyc66BL
         fNw7YZNbCKbW1CRjMLCDnF+K+Fl1mISXZpQsO4AaNwQT/rP6IVT09JKp2OhwC0POZxEu
         XClqamK6RpAVjGiW/b3Cn3pO1NSmvFyWVAnezTG1LTrej/frOwyge25jgCgFfWYZ+2Tx
         faxDOw07HH8CpdDrBHOQAQ7LNchFaZnoNsfIuZe9MO66YXc6/+Vr3T4p+gucHkSVN87i
         0cDT4DOyAvd0uGtu1C6d3LnT/Xaq3ad9At3im035w/y3jRUFNvxPDqW8VCaVZL3cYQGt
         m9GA==
X-Gm-Message-State: ACrzQf0uxeTBkGDvrl+SSX2SMxrHeW95NtmxGyb1aMbNxoZvn36If03e
        gaI0fbKhFfN4+7vKTqkniF5nGg==
X-Google-Smtp-Source: AMsMyM7H7+3obbpIiE1Ya/K0YY1X88ZwWtJmVZUqICyXSy5P099rpnXdLeVCHjUZsVLsmNNuro/XUQ==
X-Received: by 2002:ac2:4e09:0:b0:499:1e3a:54ab with SMTP id e9-20020ac24e09000000b004991e3a54abmr13173263lfr.170.1664378706601;
        Wed, 28 Sep 2022 08:25:06 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o3-20020ac24e83000000b00492d064e8f8sm499679lfr.263.2022.09.28.08.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 08:25:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@linaro.org>,
        Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v6] dt-bindings: qcom: document preferred compatible naming
Date:   Wed, 28 Sep 2022 17:25:01 +0200
Message-Id: <20220928152501.490840-1-krzysztof.kozlowski@linaro.org>
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

Compatibles can come in two formats.  Either "vendor,ip-soc" or
"vendor,soc-ip".  Qualcomm bindings were mixing both of usages, so add a
DT schema file documenting preferred policy and enforcing it for all new
compatibles, except few existing patterns.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

---

Changes since v5:
1. Correct Bjorn's email.
2. Add tags.

Changes since v4:
1. Add qcm.
2. Add more qcom,ipq806x exceptions.
3. Add Rob's tag.

Changes since v3:
1. Add qcom,kpss-wdt-xxx to pattern for exceptions.
2. Add ipq806x entries to list of exceptions.

Changes since v2:
1. Narrow the expected pattern to be followed by dash '-' after model
   number (msm8996-) or by two letters and a dash (sc8280xp-).
2. Add qcom,apss-wdt-xxx to list of exceptions.
3. Use comment instead of description in the oneOf list.

Changes since v1:
1. Add schema instead of readme (Rob).

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Alex Elder <elder@linaro.org>
Cc: Robert Foss <robert.foss@linaro.org>
Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../devicetree/bindings/arm/qcom-soc.yaml     | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/qcom-soc.yaml

diff --git a/Documentation/devicetree/bindings/arm/qcom-soc.yaml b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
new file mode 100644
index 000000000000..889fbfacf226
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/qcom-soc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SoC compatibles naming convention
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+description: |
+  Guidelines for new compatibles for SoC blocks/components.
+  When adding new compatibles in new bindings, use the format::
+    qcom,SoC-IP
+
+  For example::
+   qcom,sdm845-llcc-bwmon
+
+  When adding new compatibles to existing bindings, use the format in the
+  existing binding, even if it contradicts the above.
+
+select:
+  properties:
+    compatible:
+      pattern: "^qcom,.*(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
+  required:
+    - compatible
+
+properties:
+  compatible:
+    oneOf:
+      # Preferred naming style for compatibles of SoC components:
+      - pattern: "^qcom,(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+-.*$"
+      - pattern: "^qcom,(sa|sc)8[0-9]+[a-z][a-z]?-.*$"
+
+      # Legacy namings - variations of existing patterns/compatibles are OK,
+      # but do not add completely new entries to these:
+      - pattern: "^qcom,[ak]pss-wdt-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
+      - pattern: "^qcom,gcc-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
+      - pattern: "^qcom,mmcc-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
+      - pattern: "^qcom,pcie-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
+      - pattern: "^qcom,rpm-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
+      - pattern: "^qcom,scm-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
+      - enum:
+          - qcom,gpucc-sdm630
+          - qcom,gpucc-sdm660
+          - qcom,lcc-apq8064
+          - qcom,lcc-ipq8064
+          - qcom,lcc-mdm9615
+          - qcom,lcc-msm8960
+          - qcom,lpass-cpu-apq8016
+          - qcom,usb-ss-ipq4019-phy
+          - qcom,usb-hs-ipq4019-phy
+          - qcom,vqmmc-ipq4019-regulator
+
+      # Legacy compatibles with wild-cards - list cannot grow with new bindings:
+      - enum:
+          - qcom,ipq806x-gmac
+          - qcom,ipq806x-nand
+          - qcom,ipq806x-sata-phy
+          - qcom,ipq806x-usb-phy-ss
+          - qcom,ipq806x-usb-phy-hs
+
+additionalProperties: true
-- 
2.34.1

