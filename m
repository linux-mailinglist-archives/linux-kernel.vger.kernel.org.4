Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5710B67EDCE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbjA0SrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbjA0SrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:47:08 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5008761D7;
        Fri, 27 Jan 2023 10:47:05 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id f19-20020a1c6a13000000b003db0ef4dedcso6006341wmc.4;
        Fri, 27 Jan 2023 10:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+TzU0hDAWzqzIsf+fugrbPVmb0cJvXw5r9uGPAwlts=;
        b=EtBJMYUGdEM4o0MSLMJ2W0nPXQgGGTKm/53jvmkHg12xA+wj7HrBDu3sdD9+mznBpa
         QVQxOMX4XfeNqP3iOJMDMuiatjh4Um2RrPYuvLUeuAKGQjUPBJOS7QGU/gSWSVmMSdO1
         1mOrnV6oPLMb895nRYAZjBozCI9jm7EsXOZbx0KRabF2kez6DwjzXxzXmoadaRR6bi9h
         J1hy+IktAPPlrGbg4l0OBk/6ykNXLxQhX5+SugpfHJ6wmc1eJUgeBfeP6uyjW/qdWtoT
         /Hs+GLN4QEfG7QbXtiz+AZTav9kXz7dWeg0u8wnxxi4OQbceh3A4s0t9+fL2LzseuCAN
         OsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+TzU0hDAWzqzIsf+fugrbPVmb0cJvXw5r9uGPAwlts=;
        b=i9XVjUHafdWFhCCrZZgpAfAFK/DajVYtzivgxlUb8f0/Zyf4x+4feRe4pImKPzDyfD
         mBi2zFQBFmMLjOG5xp9lGLufHdNTXq7BkcYsHNZEZ/qXTUk1fA6ctuadH1glhebFYGYV
         tgrKTeqkaLeN8hbdbPhrYexUSV70xsOMtIAOHLSet+AVs6EU1q2vSHW5qs4vjtvEI88s
         s0PKCKqHjJlPVlm62uA/0oiPzxfu6lENaC7OcxT6oyY69LWQ4niOU8rOjMF2c3W0IxXd
         tWQXdavbYrzJrtWQsNidxQVrLkobwG2M3E1RwgqHw7SRRLN+j9LYTfKkUZGq/6+cR2Bo
         o1qw==
X-Gm-Message-State: AO0yUKV4TE3V5pa323Nj04/ImAtu3Kn//HiNZnDGqlt3p1o0XW8IMVS/
        LaSmZgcne4hSduiK4Kzz/S4=
X-Google-Smtp-Source: AK7set+cunZVd3+7yKUcqE5BcbG92TFIUXyQOkmtyI6EsJa3gcsqHrbWgdg0NO9+By0Fl6+ovtjYvw==
X-Received: by 2002:a05:600c:198f:b0:3dc:31f0:3a60 with SMTP id t15-20020a05600c198f00b003dc31f03a60mr4411291wmq.32.1674845224333;
        Fri, 27 Jan 2023 10:47:04 -0800 (PST)
Received: from xws.localdomain (pd9ea339c.dip0.t-ipconnect.de. [217.234.51.156])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c310c00b003db012d49b7sm16234208wmo.2.2023.01.27.10.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 10:47:03 -0800 (PST)
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
Subject: [PATCH v2 3/4] dt-bindings: firmware: Add Qualcomm QSEECOM interface
Date:   Fri, 27 Jan 2023 19:46:49 +0100
Message-Id: <20230127184650.756795-4-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230127184650.756795-1-luzmaximilian@gmail.com>
References: <20230127184650.756795-1-luzmaximilian@gmail.com>
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
index 846d6c927840..5493bcc5792c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17391,6 +17391,7 @@ QUALCOMM SECURE EXECUTION ENVIRONMENT COMMUNICATION DRIVER
 M:	Maximilian Luz <luzmaximilian@gmail.com>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/firmware/qcom,qseecom.yaml
 F:	drivers/firmware/qcom_qseecom.c
 F:	include/linux/qcom_qseecom.h
 
-- 
2.39.0

