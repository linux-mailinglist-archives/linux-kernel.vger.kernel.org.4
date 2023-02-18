Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42A269B9F8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 13:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjBRMW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 07:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjBRMWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 07:22:53 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9049C199FA;
        Sat, 18 Feb 2023 04:22:47 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id b6so285192pff.2;
        Sat, 18 Feb 2023 04:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AwTSqQb3wjPt6eNO90ccFFM1V4xy3OiFS52of0iH9l8=;
        b=aC85b7fvrlsjWF4tk2mJ+nIV/NQ118Bm3jHMBli98saai5JsnLpKn6ZphYdRCXdZgb
         OGEpSdta7SXtZcdNnKrCc6sRTsESzIl2I738JCnbTCSxCngeJ9SOlocCVvMuEMS5+B0h
         wsIPecN4cdCe2Fq0E/GFTc496lwToxl23bP6SKgnfRDlrK2oWRId2ae+v3V+f8clGSeb
         aKCvdt/y+1P/vqQ2hTAujYSS89TgFQnpflqGt7sUixN7qlGmm3Mr8ONJwmqMhfhJZGjs
         hRdHmYu6yiveu0rL+biv7trM8BtzHwuzRU5Ldxwdn7wLy4R+VpocJ/HcRD26WbGvZGz9
         7tQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AwTSqQb3wjPt6eNO90ccFFM1V4xy3OiFS52of0iH9l8=;
        b=bY+nlmvguOtpCWNyLVjHz7Vxy7a45ZvZlEfTRV8lVtu6p6jOEOdxmfHa6i5BNYAj+L
         53EB9oQ1yDaPJfIs98Dv4A9C+JtY4z1lFCfsPmITIEUUHfEOq1n8Ds7PaNUK9tBo3utC
         EBZXAa3To2ByI0Vjx6glfvstat+T1YRKezd0u+6+qRizDixHZqm57WMYuiXT+Y+Rp6SP
         KmD82853t/24QdCI+HPzHa4lkJgAILWne32+/YvodzLunKSZckM5zNgeUwccVoL3FM/7
         Iu0cbDqevQMJhSNfiP6S3d/fjqEiNz4MvFqMcvqgRSIje1XQ1rtiPA/mKQMPMqGOf7O/
         aoeg==
X-Gm-Message-State: AO0yUKXEZGk6vEBw8xDolJNN8viwafyW38IgQ8GhKU6nd2SCew1frE1S
        UOaqLb7SlmOkXM9W836sJj8nF2gQebEqgdrN
X-Google-Smtp-Source: AK7set+MhnHfv0oMsca/LdCR9oO5HwnkYdn/MDvzxZD/ofOMr1UP9mLNTHncgbKoY0VqFhsztpOufQ==
X-Received: by 2002:a62:7b4b:0:b0:5a9:b910:6d98 with SMTP id w72-20020a627b4b000000b005a9b9106d98mr5966352pfc.13.1676722966646;
        Sat, 18 Feb 2023 04:22:46 -0800 (PST)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([223.85.203.147])
        by smtp.gmail.com with ESMTPSA id c16-20020aa78810000000b005a8dcd32851sm4714732pfo.11.2023.02.18.04.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 04:22:46 -0800 (PST)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH] dt-bindings: interrupt-controller: convert loongson,ls1x-intc.txt to json-schema
Date:   Sat, 18 Feb 2023 20:22:36 +0800
Message-Id: <20230218122236.1919465-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Convert the Loongson1 interrupt controller dt-bindings to json-schema.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 .../loongson,ls1x-intc.txt                    | 24 ---------
 .../loongson,ls1x-intc.yaml                   | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 24 deletions(-)
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
index 000000000000..4cea3ee9fbb1
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
@@ -0,0 +1,51 @@
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
+description: |
+  Loongson-1 interrupt controller is connected to the MIPS core interrupt
+  controller, which controls several groups of interrupts.
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

base-commit: 25eba1598c8e1e804c02e3a0da50782c50c11c41
-- 
2.34.1

