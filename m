Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F08167ECDF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbjA0R6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjA0R6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:58:44 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86287D2AA;
        Fri, 27 Jan 2023 09:58:42 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id rl14so15887111ejb.2;
        Fri, 27 Jan 2023 09:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AkTXtXZvSlyW7dhrOhtl54a2x6aLLDzgCZF3MBO2yT4=;
        b=D45urjwlLOqJ5oEWUBgdQkmsYbSjvXmkD1jToywten5PtNhUD9c8awHO3NHAzmQl46
         2Ay7kmFQRTQ8cZlB/KTtUw4eoj7fQiY6CGXuax+YXRwNWSVSiw4757N6Bzx17MKeSu01
         k0IehkZHiqWzWobRDv3JZXtZ9P1YJv/2yildPxCacxYjqdIGstP2wDmIpbjXyE9fpa5s
         nWgSHzL5YwOsqCngAEOjpzySj8hclwm0nOaStOt0f2qt9S/Lo7ONKJyFSQxx8nap4w29
         /WrsHxbyuxSN7wYTpEZKcbmqp9cceq8uzA+byVq4aZffRa2Q/oB/VixxOTb4yuoN/UrI
         kkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AkTXtXZvSlyW7dhrOhtl54a2x6aLLDzgCZF3MBO2yT4=;
        b=K7VNo1mVGyH45N9lN53piPIuUb23vIxZUk+dHEj1NjnX3myRN/O08sPRN3e86wOkzE
         dAtGqvxtpvX4/16q5sBgZXA6KIVBHMYB9MJONXMgEX63LrtP3SrG+7KwvIyegWL/h3D6
         jFh8qIBFhmaPbZ2jGIpx9eI5FhGUlx4tYeoijNPI3PAq06k0Ebm2r3QV6LTaLOxFnEs1
         NTJNcrtZ4+WfgIB5xYh3PL6G7IJ8cmGS42iejWuMbi9TMSCxWhHjiGGpsMFmOPg5VuKc
         F/0/weI3UauwulyIngj9C9QpIW+Znbl1+U48MCTuVB+z50AkyOZe6s7HFeDuHdDs0fPo
         /UnA==
X-Gm-Message-State: AO0yUKUGFmt+YG/lqiR022OZ/MuHJijtKNr8qdJT/2uAf+kcHvoJSR65
        imVQLgm28tJQ4YeByMSE4yE=
X-Google-Smtp-Source: AK7set9YFRj0WFfdzKw45ndnfLNVXHirfZXQPMiwuSaPd2a9SuM0Yn0MHy2+hb2rKxYyINLcUmX2FA==
X-Received: by 2002:a17:907:c26:b0:878:53a5:70a1 with SMTP id ga38-20020a1709070c2600b0087853a570a1mr10777796ejc.50.1674842321108;
        Fri, 27 Jan 2023 09:58:41 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id z22-20020a1709067e5600b0087276f66c6asm2600508ejr.115.2023.01.27.09.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 09:58:40 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/2] dt-bindings: nvmem: io: new binding for IO accessible NVMEM devices
Date:   Fri, 27 Jan 2023 18:58:30 +0100
Message-Id: <20230127175831.26753-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

With the NVMEM layouts binding in place we should now use:
1. NVMEM device access bindings
2. NVMEM content description bindings

This binding allows describing NVMEM devices that can be accessed using
IO mappings.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../devicetree/bindings/nvmem/io.yaml         | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/io.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/io.yaml b/Documentation/devicetree/bindings/nvmem/io.yaml
new file mode 100644
index 000000000000..67e0aae9cd94
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/io.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/io.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IO access based NVMEM
+
+description: |
+  This binding describes simple NVMEM devices that can be accessed by simply
+  mapping a predefined IO address.
+
+  It's a generic solution for providing NVMEM content access. The way of
+  handling actual content may be device specific and can be described using a
+  proper layout.
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    const: io-nvmem
+
+  reg:
+    maxItems: 1
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    nvmem@10000 {
+        compatible = "io-nvmem";
+        reg = <0x10000000 0x10000>;
+    };
-- 
2.34.1

