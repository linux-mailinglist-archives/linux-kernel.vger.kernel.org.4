Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5436F7D1C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjEEGlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjEEGlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:41:05 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F24B15EE7
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 23:40:56 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1aaf21bb427so9959625ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 23:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683268856; x=1685860856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpKnP1YDIVbRZiADGr23D8oPufyg/cq5r9T3i6z6bvI=;
        b=WDGKOcE/FqB/GE1K1S4uwtGh0vKOxbxdgPVXny6oxcV6ELPkwE0oO6wteOa7dVpuGF
         4IZcPC5nAhF0NwCIuS5r8t660wUQiFv7/JbH/q05Nj2/mH7hrP2N2rIhCFDxMuQ6veao
         KlugUTS4vzzLdHyHSCxwORtKZq7PAcznLjS1Zv/DvBrU1xRJkmnuD2R4x4vx5sG7TxFr
         awrWCIZK9QBEg78rcfnGvTcHb92YzObLp2+bAf5lXL2Cwt8Y7/BlvWTzp42z/O0z2Gcf
         QyS1Y5FilonYnTVz53rxVxcuyYPtBe/KXXybt332TQUpNnga2nEZrIwY8CbEpLI+l85l
         AlIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683268856; x=1685860856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpKnP1YDIVbRZiADGr23D8oPufyg/cq5r9T3i6z6bvI=;
        b=W8wMoNmDxRfENiMGa5f/iumZl1VPFhFGuIo5NgfaSAUPtXcUARsGdTg/hMHU3bmodZ
         wvQ5qGzim+7UPk1QA96x5HhLK1ZNF5x8B3iesaTMyjWNeCZbQL2uQMEV7q2i+JOXwFtM
         50fJuf2wH79VjAwaTqsuyHwSXEB4X9sR5FgM4D2gQ+HAR6eGRKNUwgOCfMYEBHe1XD8P
         KMv0p6PXuvGyYGsS8lXYL5YCjlbJH1/dUs5RO7prOEmFhZ8pOvaH5kKNE/qeQkPCNVkH
         xHp6ivgfV9LOsFRi6Evr9USQGML2TXhDMLY3zaBo/vnzZ2csUXcAhOhgJJrxEQQ8xnpp
         2ZKw==
X-Gm-Message-State: AC+VfDz5wVZwaT12vXAAyU6pRs7FV5wQ7J2g4Yuckdp49nJ187w6j7Bk
        XIMMo+Pihmb0NfcXf+lu0sy9kg==
X-Google-Smtp-Source: ACHHUZ6MMo/HLA1Gv2YAbG3oUKKVDbJY3AY4Pc1AnYFRJAXjH15QHfQWx74AKStc9XKhLJc+KdzF9Q==
X-Received: by 2002:a17:903:2405:b0:1a6:4b60:3195 with SMTP id e5-20020a170903240500b001a64b603195mr437377plo.66.1683268856042;
        Thu, 04 May 2023 23:40:56 -0700 (PDT)
Received: from localhost.localdomain ([223.233.65.180])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902848400b001ab0b2dad2fsm816251plo.211.2023.05.04.23.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 23:40:55 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org
Subject: [PATCH v4 2/5] dt-bindings: soc: qcom: eud: Add SM6115 / SM4250 support
Date:   Fri,  5 May 2023 12:10:36 +0530
Message-Id: <20230505064039.1630025-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230505064039.1630025-1-bhupesh.sharma@linaro.org>
References: <20230505064039.1630025-1-bhupesh.sharma@linaro.org>
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

Add dt-bindings for EUD found on Qualcomm SM6115 / SM4250 SoC.

On this SoC (and derivatives) the enable bit inside 'tcsr_check_reg'
needs to be set first to 'enable' the eud module.

So, update the dt-bindings to accommodate the third register
property (TCSR Base) required by the driver on these SoCs.

Also for these SoCs, introduce a new bool property
'qcom,secure-mode-enable', which indicates that the mode manager
needs to be accessed only via the secure world.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../devicetree/bindings/soc/qcom/qcom,eud.yaml   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
index f2c5ec7e6437..3b92cdf4e306 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
@@ -18,17 +18,33 @@ properties:
     items:
       - enum:
           - qcom,sc7280-eud
+          - qcom,sm6115-eud
       - const: qcom,eud
 
   reg:
+    minItems: 2
     items:
       - description: EUD Base Register Region
       - description: EUD Mode Manager Register
+      - description: TCSR Base Register Region
+
+  reg-names:
+    minItems: 2
+    items:
+      - const: eud-base
+      - const: eud-mode-mgr
+      - const: tcsr-base
 
   interrupts:
     description: EUD interrupt
     maxItems: 1
 
+  qcom,secure-mode-enable:
+    type: boolean
+    description:
+      Indicates that the mode manager needs to be accessed only via the secure
+      world (through 'scm' calls).
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
     description:
-- 
2.38.1

