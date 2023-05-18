Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806CE707FD7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjERLkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjERLkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:40:37 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3140810C6
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:40:14 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-306dbad5182so1268880f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684409993; x=1687001993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LcnYqoHcZvLzA6Z3GL7iXhdSd41fT2YfxCPjhoX5Gg=;
        b=J19eqrqYxAX/RlpALBD7A4d7onhmQpGgddCk9FD0mP0a2jtRYbLlSFbRBMa4avh0go
         AvrsPn+q5UYMxVnW6o0UoRxPhM0kEUICgtxpkaj8hpaMBSBluDyyer1pveBy/4orbVat
         RvzlMKBxmO95vsCnEnvkF6Z8KWYbtMlTdqUR2Kzvoh9Zx5ghSBBr80ehtnSyftgh2WuJ
         0NCza6BNQHgEnGG6yZVk5H+2R+8mZRbh4TI+hOo+juzLnnn+JoW9zyQh+Jnov3snIT9A
         BX1fUTjYRgRtWyQoXTCfXHNsJoaTH/UWCRvj38ms2DfZ5b4APBvuAdxp8x5hWpaE70WP
         vP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684409993; x=1687001993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LcnYqoHcZvLzA6Z3GL7iXhdSd41fT2YfxCPjhoX5Gg=;
        b=L8t9iRYmGMLfMj3F1Zpo66+lmfrHcfLxdZExXDdIsMFWCYUnNSasZlxnCyeV9FQ4yb
         J3umorSmiwxtVLEAvZhyRi8yTmrFMfL5ozLl9z/kT6v75gcSITNAtuze680GjUPER+t4
         9MZmA6OQ4ZE/rOTr46jz80wU85h9H5EPy3f1BvO4HOHYkLqnu2elYIoXnXp/JaPNfAjy
         BAqeqIJzDaRYmTbuvosTNzDhKWlqrzTNoZHuwLZTtbUYYCs70a6BkKrEPJXIEgejE9AD
         fazgpb+dglsXE0LBG8blG2MiLiGqWPkLI5EiwREvy0K1zuZ5wDjd5yb+Fn83rw8X9Oiy
         4ICg==
X-Gm-Message-State: AC+VfDzHC5m5TnErzzsFCfd8RorqoS0r0qMZOu90YlCBoaKCvM0Fgc6M
        g9K3oH8VpDlUjyxDCoVfuCvZRA==
X-Google-Smtp-Source: ACHHUZ5ioBYKk2HoOTJ7/GOsCLfIkRsICz8W5l4WVwP7qy21i4PiTpTnZnCzG8rRg4T4CoVmr2rsEg==
X-Received: by 2002:adf:cd0e:0:b0:2f5:8e8b:572c with SMTP id w14-20020adfcd0e000000b002f58e8b572cmr1637884wrm.49.1684409992852;
        Thu, 18 May 2023 04:39:52 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id f14-20020a5d568e000000b003047d5b8817sm1897135wrv.80.2023.05.18.04.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 04:39:52 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     johan+linaro@kernel.org, agross@kernel.org,
        konrad.dybcio@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/5] dt-bindings: clock: Add YAML schemas for LPASSCC and reset on SC8280XP
Date:   Thu, 18 May 2023 12:37:56 +0100
Message-Id: <20230518113800.339158-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518113800.339158-1-srinivas.kandagatla@linaro.org>
References: <20230518113800.339158-1-srinivas.kandagatla@linaro.org>
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

The LPASS(Low Power Audio Subsystem) clock provider provides reset
controller support when is driven by the Q6DSP.
This patch adds support for those resets and adds IDs for clients
to request the reset.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/clock/qcom,sc8280xp-lpasscc.yaml | 57 +++++++++++++++++++
 .../dt-bindings/clock/qcom,lpasscc-sc8280xp.h | 12 ++++
 2 files changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
new file mode 100644
index 000000000000..7c30614a0af9
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
@@ -0,0 +1,57 @@
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
+  reset and power domains on SC8280XP.
+
+  See also::
+    include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h
+
+properties:
+  reg: true
+
+  compatible:
+    enum:
+      - qcom,sc8280xp-lpasscc
+
+  '#reset-cells':
+    const: 1
+
+  '#clock-cells':
+    const: 1
+
+  qcom,adsp-pil-mode:
+    description:
+      Indicates if the LPASS would be brought out of reset using
+      peripheral loader.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - qcom,adsp-pil-mode
+  - '#reset-cells'
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,lpasscc-sc8280xp.h>
+    lpasscc: clock-controller@3900000 {
+      compatible = "qcom,sc8280xp-lpasscc";
+      reg = <0x033e0000 0x12000>;
+      #reset-cells = <1>;
+      #clock-cells = <1>;
+      qcom,adsp-pil-mode;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h b/include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h
new file mode 100644
index 000000000000..df800ea2741c
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h
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

