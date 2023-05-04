Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A8C6F72C4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjEDTEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjEDTDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:03:43 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C14C5247;
        Thu,  4 May 2023 12:02:54 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f19afc4f60so6540575e9.1;
        Thu, 04 May 2023 12:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683226972; x=1685818972;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iqiutILdZW7mHwgY6Mn5p3FOYdCM0R4yopVFuUgsVJg=;
        b=JhLre/copfcFDrM2xcDx3AR+0GXtZUjakRqHyqxbDLbL8GZo8c34rpOdKlf6n6Js1F
         bDPiSf1JTUAwuqfcoR4pvnukqNvsCo29EKNEgwSI7VjrDHXPn+SwwtZ8MPeRCF98xpNS
         qCCiVc8S4OJrvsJNOHEUkOg9uZSR185c6jqBFoxoQShvocbMAQnud5s++J/bh1wgpXOC
         hgvnKRgcqEcDmUpGYd9G21gElc9xjdhb97vF+PfuRTz+oZYfPL7l6guhQzrUUwovAdWF
         iXAsmtGnIaO35UDMqxltTFtWzPdS5rJVrVMGgElRm8Hd4/Wfu74NX+bvJTgyvKs24RME
         gTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683226972; x=1685818972;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iqiutILdZW7mHwgY6Mn5p3FOYdCM0R4yopVFuUgsVJg=;
        b=ljtfQqdlCVB6VH9KjVMeubsedqAF9XpiSRrlwjuNHlxUYvXXB87iFQXaI2xdh9G2kp
         qKIOuvUTFfBnmTcvvcAsM7qpOHsKgUelcHr6bEdzrT1Up+O2XWeUSFFrYOsUhuXTcbsy
         NlCMLUuopa99adp66Z05uqChpBLgYTpA8AEYrOnF4nueJRXzs4GkTajkczFrgt9MKlRM
         Lg/+cyZ4mOrT/U9hSfgcEzE0lhu699lImPqE+696OLwhACHNenrnbpp1Cw2vIlrBZ+n9
         WoFD++VLpDW2qjLC//cWp6KE6P4w7TVu+rjnzXxl3br8swAw/QtD1nw9d2/h40PpN33L
         IXkQ==
X-Gm-Message-State: AC+VfDwbSwDZy8x9o2uT6QQTl/tjc+BGEVn7bMacc05U7LgnbGEgQdEY
        uNAP2ChwPu6l8Qimk5SSERg=
X-Google-Smtp-Source: ACHHUZ5onpMNRhOYWW3NwiRfpffkv5YQWt4qBIpdj6n4tKs1GinnIMCeeHOs7hwlsH4i95AGUqtOXg==
X-Received: by 2002:a1c:740d:0:b0:3f0:683d:224d with SMTP id p13-20020a1c740d000000b003f0683d224dmr548811wmc.9.1683226972016;
        Thu, 04 May 2023 12:02:52 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id o23-20020a05600c511700b003f07ef4e3e0sm4485213wms.0.2023.05.04.12.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 12:02:51 -0700 (PDT)
Date:   Thu, 4 May 2023 21:02:50 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: misc: brcm,kona-smc: convert to YAML
Message-ID: <20230504190250.GA10108@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Broadcom Kona family Secure Monitor bounce buffer bindings
to DT schema.

Change during conversion:
  - add used, but previously undocumented SoC-specific compatibles

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 .../bindings/misc/brcm,kona-smc.txt           | 15 -------
 .../bindings/misc/brcm,kona-smc.yaml          | 44 +++++++++++++++++++
 2 files changed, 44 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/misc/brcm,kona-smc.txt
 create mode 100644 Documentation/devicetree/bindings/misc/brcm,kona-smc.yaml

diff --git a/Documentation/devicetree/bindings/misc/brcm,kona-smc.txt b/Documentation/devicetree/bindings/misc/brcm,kona-smc.txt
deleted file mode 100644
index 05b47232ed9e..000000000000
--- a/Documentation/devicetree/bindings/misc/brcm,kona-smc.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-Broadcom Secure Monitor Bounce buffer
------------------------------------------------------
-This binding defines the location of the bounce buffer
-used for non-secure to secure communications.
-
-Required properties:
-- compatible : "brcm,kona-smc"
-- DEPRECATED: compatible : "bcm,kona-smc"
-- reg : Location and size of bounce buffer
-
-Example:
-	smc@3404c000 {
-		compatible = "brcm,bcm11351-smc", "brcm,kona-smc";
-		reg = <0x3404c000 0x400>; //1 KiB in SRAM
-	};
diff --git a/Documentation/devicetree/bindings/misc/brcm,kona-smc.yaml b/Documentation/devicetree/bindings/misc/brcm,kona-smc.yaml
new file mode 100644
index 000000000000..ba0312a20083
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/brcm,kona-smc.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/brcm,kona-smc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Kona family Secure Monitor bounce buffer
+
+description:
+  A bounce buffer used for non-secure to secure communications.
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - brcm,bcm11351-smc
+              - brcm,bcm21664-smc
+              - brcm,bcm23550-smc
+          - const: brcm,kona-smc
+      - items:
+          - const: bcm,bcm11351-smc
+          - const: bcm,kona-smc
+        deprecated: true
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    smc@3404c000 {
+        compatible = "brcm,bcm11351-smc", "brcm,kona-smc";
+        reg = <0x3404c000 0x400>; /* 1 KiB in SRAM */
+    };
+...
-- 
2.25.1

