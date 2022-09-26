Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631A85EA7DC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbiIZODd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbiIZODF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:03:05 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7178C16FF83
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:15:42 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a14so7191203ljj.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=IY5WCju6CXSMSpyaBxZnX9goKMuzVUk1634djEYX4Mo=;
        b=wR7zZHc20zH30JAQxHhs/jAP+ec2By8goTerBpRyfRIvHLAftHntMmUN9BYz+7ais3
         wp8qU7nhkP7NraXPF6mB5DlKTUNJnITNdux4fsm0JLN9vsL4h7Ek+P6tZCTGZTNxIwtX
         Q0lfC6NHyBZ4QzAkkad1XQyohJIkfGm1lBK4S9YP9XTLE0UPXGnce6OxtbMG8SUqiFAm
         Y1NcFmozwtbcO6N1bJHFS/UaTz0z/pBTlvd4GGTxUIlAxZgIjZsI46GMIVoqQZg4v9yw
         USlsfx+vXcwnb5rSNmPCTs7zYvPWcAs0XhyQOp8W87skdikhAlcNW/iqh5HyDl6Wh92a
         V9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=IY5WCju6CXSMSpyaBxZnX9goKMuzVUk1634djEYX4Mo=;
        b=q1502gcdaXIFBjl1v2NcWsc3S5dpqJ31+Gfq0Yxk4paqJqxI9YH0qt3sOzkEWVmF15
         2KlTChrBGMLmDkM1tDrrVpjvnPBV2xP3U/3FZsqfgK8t7gQsrX505oBuGp1toaq/YNDk
         DqPJBo8DDMd/xHzlIA7Sq+QPvaxLvsWRZZyv23oQ9FQ1t92s8iirr24cUiqepyFuGna7
         gubq2IcnvfnNFauek0MvzYg//UJv9M3ZKHepa/neN2yHELQ8WF+dbuSaz7YDbz1P/EY4
         I7dc8lSqsYY0xYfAViw/uhL+eQHW+XMNFF1oB6VWBUTpGgWz9OAv/a6wswKSSNnfltoB
         FOmw==
X-Gm-Message-State: ACrzQf1gOCeh00Rc1SN7w9hiUU1lupEbEjaTXRbSZUtVrFrv5Nnkc/Vx
        Xr1ewLvyDgp5SIlLKMbs+1MxPA==
X-Google-Smtp-Source: AMsMyM74YzEMyURaMahwhUvcwk8S5UT5ZaUTOc8Phe7quGfAlMFe86CKHINRb0Frulqwn84EogHUSA==
X-Received: by 2002:a05:651c:4cf:b0:26c:6cba:c57a with SMTP id e15-20020a05651c04cf00b0026c6cbac57amr7594584lji.288.1664194538091;
        Mon, 26 Sep 2022 05:15:38 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id l10-20020a056512110a00b004971a83f839sm2514717lfg.39.2022.09.26.05.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 05:15:36 -0700 (PDT)
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
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Subject: [RESEND PATCH v5] dt-bindings: qcom: document preferred compatible naming
Date:   Mon, 26 Sep 2022 14:15:31 +0200
Message-Id: <20220926121531.357741-1-krzysztof.kozlowski@linaro.org>
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

Compatibles can come in two formats.  Either "vendor,ip-soc" or
"vendor,soc-ip".  Qualcomm bindings were mixing both of usages, so add a
DT schema file documenting preferred policy and enforcing it for all new
compatibles, except few existing patterns.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

---

Resend:
1. Add Dmitry's tag.

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
index 000000000000..9918b20e4478
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
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
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

