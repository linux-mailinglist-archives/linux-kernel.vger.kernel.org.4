Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785F66AADE0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 03:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjCECVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 21:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjCECVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 21:21:34 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31B015550;
        Sat,  4 Mar 2023 18:21:32 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id k37so3744608wms.0;
        Sat, 04 Mar 2023 18:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677982891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhdfqbejCXAA/EEgTgeDfAkdEQU7utw6cEIkt9BYRg0=;
        b=pLZx111xGFqaYchgmdt+S5lOjPXQmmhMDMNtsSxR/FXBEIk4DhQK1uGKoEYlI9sbJs
         FmD+9LolgrUt0Wjenln4mdxnuHP3a88ZtrPF02kjgfUpG9DyqKx3qk3437rN5zO2db2F
         hvmHZm34diT0qSqjUFPxdW1qOnQ5TGXCUQ+8LrZUaXGBPRf8Txv5wrTFle+5paYURWrY
         WpduxEdavR/3MxjDNxJSO0mSCoXRO6MIlSumkVXcv+cONTOAZgaj7ZqiYuOXrgm/0XpD
         vXCJu6rMcuUxcx8jXA9Mnlwmljbx/Zyd+WWlabmpFc/PpR1yvG2yLUah/XlWZRwBw3uR
         lwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677982891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhdfqbejCXAA/EEgTgeDfAkdEQU7utw6cEIkt9BYRg0=;
        b=x5zNGUmuZlzBofQrRbSjbx4gG0QKMgmhgvvrIlQ6ELgglGDc6qqiYj0JWjbWhLWB7Q
         NoCjIi31B6m9NziKrrx/1bSl0ZpSrj0aowTcUX+cSKbzVw6YwoGxXvtvMiIUjqVLwm/p
         U3AXHxS+2HMWGJB2iy/LU/YrVBOezNEb7fpVJdHBWlSO1oCPOL5ZytwggZT6o749dwtO
         ZzER8lODP3QCQbqRR8/q5jUSYp5daNn+nFjEbYITy5uDBwB3wc69hPVrzogbUO0H5mQ4
         4KkeojZYAiEl6Gw+ZsvVj+AFujxmcbFwIZvB9kGhDKQeYx109s+pEKMZ8CoR8GdFPeHU
         qkEA==
X-Gm-Message-State: AO0yUKVz0LDh0hJ16+hJnrd9cS2ne0vEO7MPWqZEZ4nJlaOkBDoEQZYv
        xbGSrGX2yJDt6eccCtEIg0Q=
X-Google-Smtp-Source: AK7set/nIGRwkILaZPaYTRND1rpZTKAKNdYReAnXeBe+CFMCXxvQofEEoJRc67D7OIhmtfOqKDOHEw==
X-Received: by 2002:a05:600c:524b:b0:3df:de28:f819 with SMTP id fc11-20020a05600c524b00b003dfde28f819mr5654488wmb.15.1677982891256;
        Sat, 04 Mar 2023 18:21:31 -0800 (PST)
Received: from xws.localdomain ([217.138.207.232])
        by smtp.gmail.com with ESMTPSA id k4-20020adfd844000000b002c57384dfe0sm6356451wrl.113.2023.03.04.18.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 18:21:30 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 3/4] dt-bindings: firmware: Add Qualcomm QSEECOM interface
Date:   Sun,  5 Mar 2023 03:21:18 +0100
Message-Id: <20230305022119.1331495-4-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305022119.1331495-1-luzmaximilian@gmail.com>
References: <20230305022119.1331495-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the Qualcomm Secure Execution Environment interface
(QSEECOM).

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Changes in v3:
 - None.

Changes in v2:
 - Replaces uefisecapp bindings.
 - Fix various dt-checker complaints.

---
 .../bindings/firmware/qcom,qseecom.yaml       | 49 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/qcom,qseecom.yaml

diff --git a/Documentation/devicetree/bindings/firmware/qcom,qseecom.yaml b/Documentation/devicetree/bindings/firmware/qcom,qseecom.yaml
new file mode 100644
index 000000000000..540a604f81bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/qcom,qseecom.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/qcom,qseecom.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Secure Execution Environment Communication Interface
+
+maintainers:
+  - Maximilian Luz <luzmaximilian@gmail.com>
+
+description: |
+  QSEECOM provides an interface to Qualcomm's Secure Execution Environment
+  (SEE) running in the Trust Zone via SCM calls. In particular, it allows
+  communication with secure applications running therein.
+
+  Applications running in this environment can, for example, include
+  'uefisecapp', which is required for accessing UEFI variables on certain
+  systems as these cannot be accessed directly.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,qseecom-sc8280xp
+      - const: qcom,qseecom
+
+  qcom,scm:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description:
+      A phandle pointing to the QCOM SCM device (see ./qcom,scm.yaml).
+
+required:
+  - compatible
+  - qcom,scm
+
+additionalProperties: false
+
+examples:
+  - |
+    firmware {
+        scm {
+            compatible = "qcom,scm-sc8280xp", "qcom,scm";
+        };
+        qseecom {
+            compatible = "qcom,qseecom-sc8280xp", "qcom,qseecom";
+            qcom,scm = <&scm>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 1545914a592c..ef1f806986e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17384,6 +17384,7 @@ QUALCOMM SECURE EXECUTION ENVIRONMENT COMMUNICATION DRIVER
 M:	Maximilian Luz <luzmaximilian@gmail.com>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/firmware/qcom,qseecom.yaml
 F:	drivers/firmware/qcom_qseecom.c
 F:	include/linux/firmware/qcom/qcom_qseecom.h
 
-- 
2.39.2

