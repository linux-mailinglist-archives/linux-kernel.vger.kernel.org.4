Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD8772808D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbjFHMxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbjFHMx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:53:29 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BE130C5
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 05:53:22 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f6dfc4dffaso3726425e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 05:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686228801; x=1688820801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uE6yetChMOkuyV+sjyKHm251FghkzA4hPqZSw4S47tc=;
        b=Qs964vZiSrUd9xRN3bUR/kE1/e/8gR9C1EDcHEoEQBiZ158H5xj3aAZ6L/9ZLCs1Pk
         ndRB/ofQDZyBz6zBADVcceYTgIKIM/HO62OVhUmNUW8gz8LWamZeE3+YsMZnlc8v+EWW
         htU6R6duJkyyrjU7L6hbbUNGKCjfuIh/ejC3O3PIAeuhhx8I5PjNOwjmgU/hEpzBCB6Z
         bKtCkVZ0TeXBrsQY7voGzc2CYsz3JIgdim2Il1bPLj0WIvmIGYYMcaUmTA98Bu3pLXLl
         cjk9JQgO+Fuf1i5pmyBqAVsqW1wE/ib8m7/vxbblwm1kM0BpvastTaXbmu1JInicssul
         8mKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686228801; x=1688820801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uE6yetChMOkuyV+sjyKHm251FghkzA4hPqZSw4S47tc=;
        b=Z/GSHWR22iOaMmXEksuQ38LY9jhP/U6OJvqTfYbq9lI/V3Z/smzzOvvB2ObcgPMqQt
         Jwtyc6PPJ3HgdMscbAvrZ7oh2qqSth9zYfP20n+KuXnogPC6iEkXwiQ3/BBD6hyZmXSn
         AEHW9ZE15n72Y4CSVyVE6eW4mZFcyIa0Z7ksKVg+AgugpPCrXFQvR8Q88YyW9Ph0P9U4
         6pdcbiL8PKbVralYC8QMhKrqw9CLJLVnGlHURpJyB6BmV9WWTc4trM92+WJ5SUwIbYpM
         Ox8pFAuwG/KGP57VPPapuGIYGC4uaYKjsfw0+mVcKHWqi7fD1oyUtBirYvY9OQnzU/ee
         pBJg==
X-Gm-Message-State: AC+VfDzcVvBp90noVuxg9n/Dp8GxX9wxbrLB5By/5e3GE1Giai9783kW
        FFu5OWnG5PEDtaFzREaSgO1c6w==
X-Google-Smtp-Source: ACHHUZ636bbC4LpcLeOPnpSyZyMFlV/AWPyMeWt7bFH+vrpAbzR1F2n5Km6Sc8dcNnvF98MFXtKM5A==
X-Received: by 2002:a5d:510c:0:b0:309:3af4:8c8c with SMTP id s12-20020a5d510c000000b003093af48c8cmr6725833wrt.54.1686228800773;
        Thu, 08 Jun 2023 05:53:20 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id m22-20020a7bce16000000b003f7e4d143cfsm1894032wmc.15.2023.06.08.05.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 05:53:20 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     johan+linaro@kernel.org, agross@kernel.org,
        konrad.dybcio@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 1/6] dt-bindings: clock: Add LPASSCC and reset controller for SC8280XP
Date:   Thu,  8 Jun 2023 13:53:10 +0100
Message-Id: <20230608125315.11454-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230608125315.11454-1-srinivas.kandagatla@linaro.org>
References: <20230608125315.11454-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LPASS (Low Power Audio Subsystem) clock controller provides reset
support when it is under the control of Q6DSP.

Add support for those resets and adds IDs for clients to request the reset.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../bindings/clock/qcom,sc8280xp-lpasscc.yaml | 50 +++++++++++++++++++
 .../dt-bindings/clock/qcom,sc8280xp-lpasscc.h | 12 +++++
 2 files changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,sc8280xp-lpasscc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
new file mode 100644
index 000000000000..047cae91f443
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sc8280xp-lpasscc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm LPASS Core & Audio Clock Controller on SC8280XP
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  Qualcomm LPASS core and audio clock control module provides the clocks,
+  and reset on SC8280XP.
+
+  See also::
+    include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sc8280xp-lpasscc
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,sc8280xp-lpasscc.h>
+    lpasscc: clock-controller@33e0000 {
+        compatible = "qcom,sc8280xp-lpasscc";
+        reg = <0x033e0000 0x12000>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,sc8280xp-lpasscc.h b/include/dt-bindings/clock/qcom,sc8280xp-lpasscc.h
new file mode 100644
index 000000000000..df800ea2741c
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sc8280xp-lpasscc.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Linaro Ltd.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_LPASSCC_SC8280XP_H
+#define _DT_BINDINGS_CLK_QCOM_LPASSCC_SC8280XP_H
+
+/* LPASS TCSR */
+#define LPASS_AUDIO_SWR_TX_CGCR				0
+
+#endif
-- 
2.25.1

