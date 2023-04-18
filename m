Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B286E6A70
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjDRREG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjDRREC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:04:02 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1276A83DD;
        Tue, 18 Apr 2023 10:04:01 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id sz19so17936846ejc.2;
        Tue, 18 Apr 2023 10:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681837439; x=1684429439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vPtOEf6o9L+QIeM7mj51xFTJXg60GGzvFPLnfiQs3fI=;
        b=Q5hq6xZshQP4Y4gE0FC6f5K8lW7FAsZDu8eHI5JCevOGA4w9oAjRIxLawaoxXaOBXt
         B/xBMYWDE+4PMOR2grtPX1C9vMFzimp7n9kcb+h2OH4YH6s3TUDNFq8xsrXE7tIq/eye
         r9hDSsO/tmCtB6s+GpB8WWxE9qe52HdHBeIcy4J2woxdOTDkkeLxRhCNUxyRBcCgTBd1
         MrpdFGvau4KTPdrp2CS8tlDYel/oOCDU3h5aiCpqNqUzJuZSSYx8R7XI5OGBnb3KVslW
         3GZVdHnaP+RsZHBFGMrHFyo4eRIJ6qUJGWMGz8RlTW3t55eX2/YfqYeXz+gzyR7caQdd
         IdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681837439; x=1684429439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPtOEf6o9L+QIeM7mj51xFTJXg60GGzvFPLnfiQs3fI=;
        b=SY06OqEFQ5UgpUBFLlC7vZF2eDO94rWp7gcbaSGqI65+wUbq7x7DPN0P/gxrrxMOHo
         jYunaZe9HsAEjL3B16dzPwluNxNciq0WIE2MtxgI6+XYCP/MH57x51NNQBQ6WWg9Qjso
         1yMueEdmaFo6zGySC5+fM3yJUGyTBMomhORm6DzxlFLU3Xmcy8XqC7xSySmfs9OFfDcH
         HqlGdxfx+sKgwBFdvWwzWEjoP1TBXir38RMeFIGGTvMau5O2Y4eNl0IV8JZ6ejCQ5+xd
         3tzsRJ7jl2RBXfrJLbbf3pZe/JrLPTTpel/lgDjJsailB4QM8YnBg3hlIhkTPqW4yG/t
         MF0w==
X-Gm-Message-State: AAQBX9fz2X4AKQBkrBuo+BDQALHKiDzLDrSV8q/IT6V2wYuRWp4u30zo
        vMCj3VlXmm5PzJgQS8tOacc=
X-Google-Smtp-Source: AKy350YdSuc9CzaWM/olojirocUUrjyVHohmfuQux8U0tPaCl11LWAE2Vl6oMQV2CH39+QqIl1edlw==
X-Received: by 2002:a17:906:1354:b0:94f:6d10:ad9f with SMTP id x20-20020a170906135400b0094f6d10ad9fmr7474302ejb.42.1681837439244;
        Tue, 18 Apr 2023 10:03:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:8c00:3b40:572e:1d42:2ab9:f5e8])
        by smtp.gmail.com with ESMTPSA id g8-20020a170906c18800b0094e877ec197sm8435760ejz.148.2023.04.18.10.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 10:03:58 -0700 (PDT)
From:   Nikita Bondarenko <n2h9z4@gmail.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com
Cc:     Nikita Bondarenko <n2h9z4@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: watchdog: brcm,kona-wdt: convert txt file to yaml
Date:   Tue, 18 Apr 2023 19:03:41 +0200
Message-Id: <20230418170341.28805-1-n2h9z4@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converted txt file to yaml. No additional changes.

Signed-off-by: Nikita Bondarenko <n2h9z4@gmail.com>
---

Changes in v3:
- updated commit message
- updated the compatible definition to probably fix "compatible is too long" warning
- updated example to how it was in the txt file


I do not have this warning when I am running  
make  DT_SCHEMA_FILES=Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml ARCH=arm dt_binding_check
maybe I run it without some additional variable?

But I checked arch/arm/boot/dts/bcm28155-ap.dts, it includes bcm11351.dtsiv which contains 
compatible = "brcm,bcm11351-wdt", "brcm,kona-wdt";
which probably causes a warning
This is exact how it was in txt file example.

If I put it in an example in a yaml file, dt_binding_check does not pass.
Looks like the issue is in the enum type of compatible. It does not allow multiple strings.  
Updated to not to use enum. The example with two strings in compatible passes the checks.

make  DT_SCHEMA_FILES=Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml ARCH=arm dt_binding_check
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTEX    Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.example.dts
  DTC_CHK Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.example.dtb

make  DT_SCHEMA_FILES=Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml ARCH=arm dtbs_check
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json


v2 patch is here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230402135555.62507-1-n2h9z4@gmail.com/

 .../bindings/watchdog/brcm,kona-wdt.txt       | 15 -------
 .../bindings/watchdog/brcm,kona-wdt.yaml      | 41 +++++++++++++++++++
 2 files changed, 41 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt b/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt
deleted file mode 100644
index 2b86a00e351d..000000000000
--- a/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-Broadcom Kona Family Watchdog Timer
------------------------------------
-
-This watchdog timer is used in the following Broadcom SoCs:
-  BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
-
-Required properties:
-  - compatible = "brcm,bcm11351-wdt", "brcm,kona-wdt";
-  - reg: memory address & range
-
-Example:
-	watchdog@35002f40 {
-		compatible = "brcm,bcm11351-wdt", "brcm,kona-wdt";
-		reg = <0x35002f40 0x6c>;
-	};
diff --git a/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml b/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml
new file mode 100644
index 000000000000..3d4403b41cbe
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/brcm,kona-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Kona Family Watchdog Timer
+
+description: |
+  This watchdog timer is used in the following Broadcom SoCs:
+  BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+  - Ray Jui <rjui@broadcom.com>
+  - Scott Branden <sbranden@broadcom.com>
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: brcm,bcm11351-wdt
+      - const: brcm,kona-wdt
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    watchdog@35002f40 {
+        compatible = "brcm,bcm11351-wdt", "brcm,kona-wdt";
+        reg = <0x35002f40 0x6c>;
+    };
-- 
2.34.1

