Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D5765691F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 10:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiL0JwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 04:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiL0Jv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 04:51:57 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75D895B4;
        Tue, 27 Dec 2022 01:51:56 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id y21so6380619pfo.7;
        Tue, 27 Dec 2022 01:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OFIOC5oKZ0F+p/C6qXyoQWPtbp1a9uFnXmP1cOo5xc=;
        b=MaGNbWq//LCbCCBqpSLiUzVeKCmDrbpADMQkIPK4FpujBFGk1sWzxckXT6Jz5DCuzL
         fcn5xGe/9lRQ48yNCM+Y4iMolWxCi0wCdkOz/OqrIhlOxEFKJvBz9k86aRFiwcUDSI78
         celDoh+RJOIjdtZqMkGRbKUUxSYhgYKQBphJQ69tzRhY98AcDPkWZb6TZWTN0jQ+qfJh
         w1t8he/p2YaJM64uKqiDZ2wtdyE0QIrbkAH3iZFYuyQUv8/ZcZNZoox2MvKLuiw78X5D
         ZWM5qfLW5RKz81FgPxPN+3O1vvQm5QvxnAQ54CqF3thV3EIChyCPzZ59I7JXU/iqdpnI
         2kEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OFIOC5oKZ0F+p/C6qXyoQWPtbp1a9uFnXmP1cOo5xc=;
        b=g7QJtPGp1AJq1nbFWJnYjizqnnlMSJ+6AWSvWbrv2RlYXwT6UVZjVn1COv7woURNjz
         jy6m3KzM5cAIC3u9l5hm/6dlqnkAP6RfQx0zka3PAvkMcOQoYPAQ+yJedfPfE/UqWFrt
         bOrjVZ3VcANpBuNPhQhN4ltAJLmwj/8I8gnzuBSQAm5pSoSYO6hWiGywNSadWE6pRGkn
         o1QPfeqWJgWUtsgqvqWYw1DhR+vQbfgeu8zT37KoUb+zySqQJT4MgaHLO5IUxtes+I5V
         mIXO726UiPlxruC3Lu8cn4l/tBaJPGWwYaILK+om3StbebhCxrqqp3Ypa4erVuyYOpV4
         oocw==
X-Gm-Message-State: AFqh2krhZsl0LoMsaz8yuXPM/UmCDZxnsnBByMlgbcbT2zlfaAP2wavU
        rT56SeHtxXWns8E/g6eo2WSOpzIOTBJLyQ==
X-Google-Smtp-Source: AMrXdXt+US725h1K9RlmpzKyZK4Rmq2JTxmD1ZKEXSYdbzi8fQ4fap518bq02dRoqNF3FOtjDOjkHQ==
X-Received: by 2002:a62:36c4:0:b0:578:7e9d:97b2 with SMTP id d187-20020a6236c4000000b005787e9d97b2mr25223491pfa.3.1672134716421;
        Tue, 27 Dec 2022 01:51:56 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 21-20020a621515000000b005813aec74bdsm2619052pfv.139.2022.12.27.01.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 01:51:56 -0800 (PST)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v10 2/7] media: dt-binding: nuvoton: Add NPCM VCD and ECE engine
Date:   Tue, 27 Dec 2022 17:51:18 +0800
Message-Id: <20221227095123.2447948-3-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221227095123.2447948-1-milkfafa@gmail.com>
References: <20221227095123.2447948-1-milkfafa@gmail.com>
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

Add dt-binding document for Video Capture/Differentiation Engine (VCD)
and Encoding Compression Engine (ECE) present on Nuvoton NPCM SoCs.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/media/nuvoton,npcm-ece.yaml      | 43 +++++++++++
 .../bindings/media/nuvoton,npcm-vcd.yaml      | 72 +++++++++++++++++++
 2 files changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/nuvoton,npcm-ece.yaml
 create mode 100644 Documentation/devicetree/bindings/media/nuvoton,npcm-vcd.yaml

diff --git a/Documentation/devicetree/bindings/media/nuvoton,npcm-ece.yaml b/Documentation/devicetree/bindings/media/nuvoton,npcm-ece.yaml
new file mode 100644
index 000000000000..b47468e54504
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/nuvoton,npcm-ece.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/nuvoton,npcm-ece.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NPCM Encoding Compression Engine
+
+maintainers:
+  - Joseph Liu <kwliu@nuvoton.com>
+  - Marvin Lin <kflin@nuvoton.com>
+
+description: |
+  Video Encoding Compression Engine (ECE) present on Nuvoton NPCM SoCs.
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,npcm750-ece
+      - nuvoton,npcm845-ece
+
+  reg:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/reset/nuvoton,npcm7xx-reset.h>
+
+    ece: video-codec@f0820000 {
+        compatible = "nuvoton,npcm750-ece";
+        reg = <0xf0820000 0x2000>;
+        resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_ECE>;
+    };
diff --git a/Documentation/devicetree/bindings/media/nuvoton,npcm-vcd.yaml b/Documentation/devicetree/bindings/media/nuvoton,npcm-vcd.yaml
new file mode 100644
index 000000000000..c885f559d2e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/nuvoton,npcm-vcd.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/nuvoton,npcm-vcd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NPCM Video Capture/Differentiation Engine
+
+maintainers:
+  - Joseph Liu <kwliu@nuvoton.com>
+  - Marvin Lin <kflin@nuvoton.com>
+
+description: |
+  Video Capture/Differentiation Engine (VCD) present on Nuvoton NPCM SoCs.
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,npcm750-vcd
+      - nuvoton,npcm845-vcd
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  nuvoton,sysgcr:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to access GCR (Global Control Register) registers.
+
+  nuvoton,sysgfxi:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to access GFXI (Graphics Core Information) registers.
+
+  nuvoton,ece:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to access ECE (Encoding Compression Engine) registers.
+
+  memory-region:
+    maxItems: 1
+    description:
+      CMA pool to use for buffers allocation instead of the default CMA pool.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - resets
+  - nuvoton,sysgcr
+  - nuvoton,sysgfxi
+  - nuvoton,ece
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/nuvoton,npcm7xx-reset.h>
+
+    vcd: vcd@f0810000 {
+        compatible = "nuvoton,npcm750-vcd";
+        reg = <0xf0810000 0x10000>;
+        interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+        resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_VCD>;
+        nuvoton,sysgcr = <&gcr>;
+        nuvoton,sysgfxi = <&gfxi>;
+        nuvoton,ece = <&ece>;
+    };
-- 
2.34.1

