Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F32568D291
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjBGJU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjBGJUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:20:15 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AFC2386B;
        Tue,  7 Feb 2023 01:20:13 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v18-20020a17090ae99200b00230f079dcd9so671640pjy.1;
        Tue, 07 Feb 2023 01:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OFIOC5oKZ0F+p/C6qXyoQWPtbp1a9uFnXmP1cOo5xc=;
        b=RCckrOHJt/6VqyUvHwDqR4hyvGBdRsW0dlw51lOl4qRPoiRmUXtVk2h4voIJsUUPzT
         uMYgFYCIoS6r6p42rj59oqDbAy1gDl6aYBXfcsak3k6DAN1WzdwqsOb13aQ3gaQwghZ1
         YFHojoYwTHU3rJQEba9U4Fl0VL2Hf5r/nrRoACaZQGcnPNmXPsW3hmGjpsbFrGqwW28I
         umXq+30/KYeUk4JcV9GwxCBziK9m9cCixAmRhSaevaT+gv3Jlay8+9zSsLfu5aCI/lVF
         4vG2f/BUwFJDAuitWszUgRLulNRVUaZeOCFs/B/TTr9DJjVnMrDUHVLYkStAcf8kOCRx
         UNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OFIOC5oKZ0F+p/C6qXyoQWPtbp1a9uFnXmP1cOo5xc=;
        b=r9PGQ3AowyRC16QRr9ySV3ZmDuwDtu9JOQF+szzWbNXk2weV1p6Mg86xP32GH47/VN
         SNqbL6gHKGfXQQHxJl0z+NnxqcuR1YhPBK9ngzXfkySB0aU/Iq3qUyzr+3IVPSaNDuMO
         tP2cB4+WioPn3KNhF492gLvwCmMee43q7bNuEOsIzawR2HpqwD4xR7LNMH/f9UGv7Guf
         PP0++2L8WF3D06b9uBFPRdXM9VG6+qngnzt2gubU+y2UyXN8TXzgClFzFlquB2Orp7cT
         HGp0+iFClmSp7Q9d65eXN0E5UDpzMbTkY9ckBqL4rCiWcNjck5LnHVro8lgEBzRn3dx9
         R6Kg==
X-Gm-Message-State: AO0yUKXezxXCZO+iVOxgyKD8UZkLoXUZQEvgRAccB5JKG/tabcZ7zND0
        wLFyEGJ6xLaJdkPch7ka2EA=
X-Google-Smtp-Source: AK7set9fOvvpWgMDcJz2u3rQ6XeaRoL8y0BrUuZA0oF+0zCMiynADcbV0RWtD/cr9OOcpieGPhlEzQ==
X-Received: by 2002:a05:6a20:4298:b0:bf:8c0c:978b with SMTP id o24-20020a056a20429800b000bf8c0c978bmr3212423pzj.5.1675761613269;
        Tue, 07 Feb 2023 01:20:13 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id io20-20020a17090312d400b0019934030f46sm545327plb.132.2023.02.07.01.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 01:20:12 -0800 (PST)
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
Subject: [PATCH v11 2/7] media: dt-bindings: nuvoton: Add NPCM VCD and ECE engine
Date:   Tue,  7 Feb 2023 17:18:57 +0800
Message-Id: <20230207091902.2512905-3-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207091902.2512905-1-milkfafa@gmail.com>
References: <20230207091902.2512905-1-milkfafa@gmail.com>
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

