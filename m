Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680CC734F62
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjFSJOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjFSJOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:14:12 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4135E106
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:13:44 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b46bfa66d2so21967651fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687166022; x=1689758022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/jlXshozPayfgGZVovFzvapxjkBArH5oxzJwkbABuE=;
        b=smPvooVZDMG6/lDx07CAQ9B7NaGB3AL987mVEZR8fMhvsvwiUQe7FnUpQOczc4P79I
         d0LyMjJzgmJOAnqBUWgzDU/PpukuQdirk8x5OH39GJlrTiHW5ep7bXNWe8WXz0/ugg4L
         gY5+W+eixvS6mWyPZ8/o7oPIZtOsaou226x+w3Kf/teuO/bAfSFyZ3dE2r4asorxUZR0
         gs0GPTfaPlZdOf1OZA0UCS3385EIwEf9P+6R3v4yTqDJHb1qWc/8HsjPAOES3HGSrFVD
         ZsmfA8Zl71esltct8+q7H5mTk6On0dUPKq56svoaM1FapfG5hSeAKXRz5dGsJycW/aA1
         63fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687166022; x=1689758022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/jlXshozPayfgGZVovFzvapxjkBArH5oxzJwkbABuE=;
        b=iohTSx+vINNE9i/DAFgK+W9Q3UtkfJrwKx72onCGs6f3JB70Mvs355gU0/p9RrLOty
         tShq3O5uVEx4qOQnR5Jy6+gEaSVrO58qif9fx5jd9+J/SA/QJ55zy2cVoGP8p7iqtdOT
         Wjr+FRcef6Cb2Gb92032Q+ySsVHGK3FeQgJt0+HflW8Vkm+CCX+2I9D4RoDkPbDxrAXZ
         Rn3/NO4UY00cREMOyV3eaCN9VKAftkrbFoCjuulrnCW3xxFdNlygIWC16vTgOSL3X0wd
         ZPsZApZBOJV9oUVAXcMTqh2qGF/wVEJA+1CsSFJPgtbqHwLU5NoZWs9iRG5dqIXTX8YR
         bNNg==
X-Gm-Message-State: AC+VfDwsRQQf+f7U+NOhYwMBvj5EDtMy+aBi0+hqwQppdpj1g9yCkRLD
        yPzNzi/3g67XEA8dH3xyMQ6Mmw==
X-Google-Smtp-Source: ACHHUZ4XooL288ZUyMfrNgoXSobChLrzQ7WKm8t5OrAYR/aV6BhbpBu3jmIz3yJrLsi7NTYoVER1lQ==
X-Received: by 2002:a19:661a:0:b0:4f8:418e:1e49 with SMTP id a26-20020a19661a000000b004f8418e1e49mr4791125lfc.16.1687166022604;
        Mon, 19 Jun 2023 02:13:42 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d9e8:ddbf:7391:a0b0])
        by smtp.gmail.com with ESMTPSA id p20-20020a05600c205400b003f9a6f3f240sm3072993wmg.14.2023.06.19.02.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 02:13:42 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH v2 2/3] dt-bindings: phy: describe the Qualcomm SGMII PHY
Date:   Mon, 19 Jun 2023 11:13:35 +0200
Message-Id: <20230619091336.194914-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230619091336.194914-1-brgl@bgdev.pl>
References: <20230619091336.194914-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Describe the SGMII/SerDes PHY present on the sa8775p platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../phy/qcom,sa8775p-dwmac-sgmii-phy.yaml     | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,sa8775p-dwmac-sgmii-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,sa8775p-dwmac-sgmii-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sa8775p-dwmac-sgmii-phy.yaml
new file mode 100644
index 000000000000..b9107759b2a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,sa8775p-dwmac-sgmii-phy.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/qcom,sa8775p-dwmac-sgmii-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SerDes/SGMII ethernet PHY controller
+
+maintainers:
+  - Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
+
+description:
+  The SerDes PHY sits between the MAC and the external PHY and provides
+  separate Rx Tx lines.
+
+properties:
+  compatible:
+    const: qcom,sa8775p-dwmac-sgmii-phy
+
+  reg:
+    items:
+      - description: serdes
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: sgmi_ref
+
+  phy-supply:
+    description:
+      Phandle to a regulator that provides power to the PHY.
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
+    serdes_phy: phy@8901000 {
+        compatible = "qcom,sa8775p-dwmac-sgmii-phy";
+        reg = <0x08901000 0xe10>;
+        clocks = <&gcc GCC_SGMI_CLKREF_EN>;
+        clock-names = "sgmi_ref";
+        #phy-cells = <0>;
+    };
-- 
2.39.2

