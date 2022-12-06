Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51BC644EA7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 23:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiLFWpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 17:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLFWpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 17:45:25 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF703E080
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 14:45:24 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id gh17so9879766ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 14:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNI2i3/QTr9mwnzcqdEPuyaMkTpSlzmqI4PslyM1ul8=;
        b=iTwAOWgL1wzIv3tLnUGKyAmdMRj1jN526teYp1qdotQsOYATNG9vDIAiDfFE5CTWDe
         4pEgVyRPvBO3neWP5pyVPFhE/40et1LEJS7tTUXUC09p2n2v+bQ0RZXsdC3/StgGpECy
         7lAQ2ZfU04RPQiqpjRZWbTX9Zpk4k/zxuQl3nae/HJDzSVtU8Rn/tRlnLcUm53Edk3Y4
         rdTJME4BNcfvkfJccsffUfN8cFJigAmAfX2aMhfjkJ90NEIWx4gulBnalYfVz+4Hpqc1
         Fgr9h7OVJJRjagqFQUb2J5nyungUFylwQTkISq8lhBE6IrU0Xq5ojRx4NVzkyhEYlnFg
         Qd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNI2i3/QTr9mwnzcqdEPuyaMkTpSlzmqI4PslyM1ul8=;
        b=Z+sM1mYjzoXRiu0/maIy5zXACvqQEUYcZwLPjLSe5oRh/EMGKO54uKYWQ19ibCjkqC
         zGOyEJeMBF6JO5Rz6qfFqMkk17zikST6mMec1wSTC7hthww1oS7EfGqAGPU0wrptGxGX
         TvUsTGlVz9R257UbGI52d7CLk6lF16/7x0TFmQAS2+jE2y0rSY7y9a06PAR2X6HOsGuA
         F4urZfODrja0tsE0BomzaYfSRYI+nhiMQ4m99OzAdj6FLi1wsQJFPDPkVmVy6khPyCm9
         dUh9r2GPfsMHlh88MNFIl/tBjcmKOLQ7jVjB9ObOTabOAgmQFM0VwMXAwgRDVPSoBoMZ
         kf1Q==
X-Gm-Message-State: ANoB5plTUB1nv7C/WZ2oZrqJx7whJDs2JppKwujpdUC3CUyJbOyEqYgx
        jRfFlwrB4jocNcCllMjx5QfbBQ==
X-Google-Smtp-Source: AA0mqf5C0wxTDc9ZGRfLSZAnR4QlPssuwpgRnBUt8JjDVq2cVuqfDQ09xcvR8jbYpxUhtvOwAJRQKw==
X-Received: by 2002:a17:906:3c03:b0:7c1:9c6:aaa1 with SMTP id h3-20020a1709063c0300b007c109c6aaa1mr4583515ejg.583.1670366722767;
        Tue, 06 Dec 2022 14:45:22 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id r17-20020a1709061bb100b007c0985aa6b0sm7820772ejg.191.2022.12.06.14.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 14:45:22 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 2/5] dt-bindings: clock: Add SM8550 TCSR CC clocks
Date:   Wed,  7 Dec 2022 00:45:12 +0200
Message-Id: <20221206224515.1495457-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221206224515.1495457-1-abel.vesa@linaro.org>
References: <20221206224515.1495457-1-abel.vesa@linaro.org>
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

Add bindings documentation for clock TCSR driver on SM8550.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/qcom,sm8550-tcsr.yaml      | 55 +++++++++++++++++++
 include/dt-bindings/clock/qcom,sm8550-tcsr.h  | 18 ++++++
 2 files changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
 create mode 100644 include/dt-bindings/clock/qcom,sm8550-tcsr.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
new file mode 100644
index 000000000000..2b72ab82041a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm8550-tcsr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm TCSR Clock Controller on SM8550
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+description: |
+  Qualcomm TCSR clock control module provides the clocks, resets and
+  power domains on SM8550
+
+  See also:: include/dt-bindings/clock/qcom,sm8550-tcsr.h
+
+properties:
+  compatible:
+    items:
+      - const: qcom,sm8550-tcsr
+      - const: syscon
+
+  clocks:
+    items:
+      - description: TCXO pad clock
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
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+
+    clock-controller@1fc0000 {
+      compatible = "qcom,sm8550-tcsr", "syscon";
+      reg = <0x1fc0000 0x30000>;
+      clocks = <&rpmhcc RPMH_CXO_PAD_CLK>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
+
+...
diff --git a/include/dt-bindings/clock/qcom,sm8550-tcsr.h b/include/dt-bindings/clock/qcom,sm8550-tcsr.h
new file mode 100644
index 000000000000..091cb76f953a
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm8550-tcsr.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_TCSR_CC_SM8550_H
+#define _DT_BINDINGS_CLK_QCOM_TCSR_CC_SM8550_H
+
+/* TCSR CC clocks */
+#define TCSR_PCIE_0_CLKREF_EN					0
+#define TCSR_PCIE_1_CLKREF_EN					1
+#define TCSR_UFS_CLKREF_EN					2
+#define TCSR_UFS_PAD_CLKREF_EN					3
+#define TCSR_USB2_CLKREF_EN					4
+#define TCSR_USB3_CLKREF_EN					5
+
+#endif
-- 
2.34.1

