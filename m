Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5899F69C99D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjBTLS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjBTLSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:18:23 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FB76199;
        Mon, 20 Feb 2023 03:18:11 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id nw10-20020a17090b254a00b00233d7314c1cso1079187pjb.5;
        Mon, 20 Feb 2023 03:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+2GD3NyXi/bx/63OE2grzvv6OrVtnQk5f2mxDh+T0HE=;
        b=Q1eUH6pVqphIvGeNtcp4NK5eH4GX82RXPPWDM3CQ0J5ZccrT05giSqsjFr3sxOqmT4
         lZnNgBvpqO1veZbfcmyy26+ReoZQFzjhMJQW10GJhojT4+2Zn2CYGgqSPkBj9xHXzxaj
         KhelOqgFGqJ+ufUaFeX1gFPl1tNMW2V3jA2QOv+lrPRj8s7CsgP0+W4WvWPMuzzkrJDA
         FeTUAILn7imu1l2Y3tkZRQIOCBafWQ+iJ5c17B6QmfV7+xgQD5uFtl1m63hjVMTwl3TH
         /bphgu+6ZndL2c295967BBdisvfoPQ3I8AIzTs416wMhI+8rlvcbH+gWJsxvNlpFbr+d
         AyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+2GD3NyXi/bx/63OE2grzvv6OrVtnQk5f2mxDh+T0HE=;
        b=ahv381Zm/HUnyDcz+ozhS79NU8isaHvEDU2bP/SxUYUutYkuY6Dxzb/mPFJe3NfK3Z
         03rCETAYY4rBNub3BR/UZ9yzQoZtaJqE5h5MFyMnQ1yDIbs64JByx0FYwMGzV+peeJgc
         RoCqgob9IK5xw9KCdJqqmFQTgXAZXYzlPaMShNf9Mb2i+3Swt8qjA5OPRgzsxcc3/uTE
         B6+ddZgT16eKGSNzmb51PkCMTbnpvvTX6jhEV1wCqdR6Oc1+/hl8V70IYmoDDQTAnwid
         exL5JnegwMbCFAbNikLD/VOgmCJy3OTiH6B9Or8dD03hbgb5mYK8wKtmlQGI3htnGqgl
         yNNw==
X-Gm-Message-State: AO0yUKV1C5DROjtWxT6EDGbpwTk0YIcvYpEBvAXIJOeODR3tSs1Thpeo
        N236ejK/1zgfZphjFaLkSFfgYQ4LtKgiWg==
X-Google-Smtp-Source: AK7set8fIDlU3gzHwBecocGWnCMAuy2sOX8lPQWSmlaqOXqnLmh8mp/Ro9nu3sh7CvbNgDZY4fUHfg==
X-Received: by 2002:a17:902:d509:b0:19a:96ea:3850 with SMTP id b9-20020a170902d50900b0019a96ea3850mr3792317plg.17.1676891890674;
        Mon, 20 Feb 2023 03:18:10 -0800 (PST)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id iw11-20020a170903044b00b0019a733a75a2sm7721820plb.60.2023.02.20.03.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 03:18:10 -0800 (PST)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] dt-bindings: interrupt-controller: convert loongson,ls1x-intc.txt to json-schema
Date:   Mon, 20 Feb 2023 19:18:01 +0800
Message-Id: <20230220111801.2037164-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Loongson1 interrupt controller dt-bindings to json-schema.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
V1 -> V2: Drop the description part
---
 .../loongson,ls1x-intc.txt                    | 24 ----------
 .../loongson,ls1x-intc.yaml                   | 47 +++++++++++++++++++
 2 files changed, 47 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
deleted file mode 100644
index a63ed9fcb535..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Loongson ls1x Interrupt Controller
-
-Required properties:
-
-- compatible : should be "loongson,ls1x-intc". Valid strings are:
-
-- reg : Specifies base physical address and size of the registers.
-- interrupt-controller : Identifies the node as an interrupt controller
-- #interrupt-cells : Specifies the number of cells needed to encode an
-  interrupt source. The value shall be 2.
-- interrupts : Specifies the CPU interrupt the controller is connected to.
-
-Example:
-
-intc: interrupt-controller@1fd01040 {
-	compatible = "loongson,ls1x-intc";
-	reg = <0x1fd01040 0x18>;
-
-	interrupt-controller;
-	#interrupt-cells = <2>;
-
-	interrupt-parent = <&cpu_intc>;
-	interrupts = <2>;
-};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
new file mode 100644
index 000000000000..48dd071ceeea
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/loongson,ls1x-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson-1 Interrupt Controller
+
+maintainers:
+  - Keguang Zhang <keguang.zhang@gmail.com>
+
+properties:
+  compatible:
+    const: loongson,ls1x-intc
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    intc0: interrupt-controller@1fd01040 {
+        compatible = "loongson,ls1x-intc";
+        reg = <0x1fd01040 0x18>;
+
+        interrupt-controller;
+        #interrupt-cells = <2>;
+
+        interrupt-parent = <&cpu_intc>;
+        interrupts = <2>;
+    };

base-commit: 39459ce717b863556d7d75466fcbd904a6fbbbd8
-- 
2.34.1

