Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251CD6B2032
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjCIJfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjCIJef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:34:35 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7599438A;
        Thu,  9 Mar 2023 01:34:22 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id s20so1439670lfb.11;
        Thu, 09 Mar 2023 01:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678354460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xvRq5Jv0mE0gBOFKvZj3ILwliwYZSlL8lUsvNU1SHTw=;
        b=N6P4qY+ylVk38GewMnGLjzS479rkCWyNCexALrNfM/t83h+q3Ga+7rowXUvguSg5xK
         MpptfQ1TlQI+CXK0lihd4kUSz45+1aQXn5uq6lxXGHAcvKs4BDCteE2s77gNKylS667O
         zs8tnPLVe3rM+hHCoJev27WWVAiTc/+tzH3bSvm1aXtgNvgDIeicz2kME1Lfbmvv8GSo
         f95uQDBmMACPXZdLVITYnlaApTERsHCtA6Et4oEFLcrP8H6bcZ1ufsHVBs2MmrQQ015e
         rQV67M76fE06cWG+HL72ASXv0FtJ5KStWHteViPn+NaHZdJ/idVqTU9iGAV0tuuS7D9c
         3q6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678354460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xvRq5Jv0mE0gBOFKvZj3ILwliwYZSlL8lUsvNU1SHTw=;
        b=y68aGq5+aLNzEmZ7p8LDnaeZrAFGdyC0zoQy2wlhEKvQI2qq3aAyI+VqmxnRXr5xwh
         Y1whia8JrvK8gHWM4I0GMUXSH3FBYjfjiQE3NuljqFgugXj+pdDbqfK1wtVnOL9pfh0X
         vUoG1wX5XPWrLrBa75FzgMP/gxRZwGa4TgOVaLZZgpDeo+Kmygg0zuCi6z2Wgium3xwJ
         woMFY2p/KWpLDcYqnq5D2MuIdd4KBUXIoO2XLouC2Ri6FQ0M0EOpIJiabfH5Y2TbUSeL
         2g3qYCh33hKdhdm2aE3s3mPf3Bfn4VNBFE0MgE9UoSAYun7Jue+LvV96OBmTsHdIzvlj
         nKog==
X-Gm-Message-State: AO0yUKWZCPNODoYJ5444trCBTmGn409gsOOLo2Sf4oJHsI2B4yITWX8x
        Ejn7rPlmylSav3lOn+OU6Ao=
X-Google-Smtp-Source: AK7set/WKNhApt4nM8wOG5pTfVTWwLPjWUXOfR3RP4xKZx1nR6gL5xyZWTrm4pa3U2OsTNXTyJ8uTA==
X-Received: by 2002:a05:6512:398e:b0:4db:1e7d:5d49 with SMTP id j14-20020a056512398e00b004db1e7d5d49mr7141933lfu.21.1678354460474;
        Thu, 09 Mar 2023 01:34:20 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id y9-20020ac24e69000000b004db1a7e6decsm2583034lfs.205.2023.03.09.01.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 01:34:19 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: nvmem: layouts: add fixed-layout
Date:   Thu,  9 Mar 2023 10:34:10 +0100
Message-Id: <20230309093410.15214-1-zajec5@gmail.com>
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

With the introduction of NVMEM layouts I believe we should prefer and
support describing all NVMEM devices content in the "nvmem-layout" node.
Inluding fixed NVMEM cells (those with hardcoded offset & size).

This seems to be cleaner design and more explicit.

Introduce a binding allowing fixed NVMEM cells as a type of layout.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../bindings/nvmem/layouts/fixed-layout.yaml  | 52 +++++++++++++++++++
 .../bindings/nvmem/layouts/nvmem-layout.yaml  |  1 +
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
new file mode 100644
index 000000000000..7eb86c999a5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/layouts/fixed-layout.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVMEM layout for fixed NVMEM cells
+
+description:
+  Many NVMEM devices have hardcoded cells layout (offset and size of specific
+  NVMEM content doesn't change).
+
+  This binding allows defining such cells using NVMEM layout. It can be used on
+  top of any NVMEM device.
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+properties:
+  compatible:
+    const: fixed-layout
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+patternProperties:
+  "@[a-f0-9]+$":
+    type: object
+    description: NVMEM cell
+    properties:
+      reg:
+        maxItems: 1
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    nvmem-layout {
+        compatible = "fixed-layout";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        calibration@4000 {
+            reg = <0x4000 0x100>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
index 8512ee538c4c..03da7848c713 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
@@ -18,6 +18,7 @@ description: |
   perform their parsing. The nvmem-layout container is here to describe these.
 
 oneOf:
+  - $ref: fixed-layout.yaml
   - $ref: kontron,sl28-vpd.yaml
   - $ref: onie,tlv-layout.yaml
 
-- 
2.34.1

