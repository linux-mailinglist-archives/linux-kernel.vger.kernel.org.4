Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94ED6337AC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbiKVI6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbiKVI5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:57:52 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5363C15813;
        Tue, 22 Nov 2022 00:57:51 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id g5so4204488pjp.4;
        Tue, 22 Nov 2022 00:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPI07iSVE5uzkhd5OwFFJcgh7eLm39fNMV2ldIj9sag=;
        b=OQkhn8nAPkSrM68V6BwhF+ilhFUZGkJgwdomypnQWb/cOyG1A30UtPOp0tHltJlWLa
         R1NIZTpnjSv0CjK1zFnagEir5UFJSlBYy1wYfoNBefBW95KYCUe9vFS/1lL39hhLW7DK
         GV6PpE7l+Q6p8nKWc+ncQ42AzwH3kCnaKYzDnv8mgYDAPImndpF/MIikKMIDgn2QlAck
         TA7ZthPutAVaTYuRbBryeIU2viTRybCAGYkbb6wOap1uHiuFr6IO8lMoGqZzDZ2zm/a0
         wBWOyDZslF7LBfpm+aXM38A8BpDKIB6ipVDw7ipEFUkVAPhe+b6M2Caoguj+rnjwAmGK
         V47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPI07iSVE5uzkhd5OwFFJcgh7eLm39fNMV2ldIj9sag=;
        b=II707aE/WkOLn7jTHr8gNyBIxEkt053TP87fjZT9MNXFyy8EKmZX4tlZxme1CyesOm
         rkgRkNZdy5z79VShW2m/5IDxdnMnfVHWrG//DOTXXO+7NBEYsSr+Ys8f3j2l9vcd5Heh
         XozEG7IjqOmXbR5SpRWwpRvB7jNzaPCJKRoK4QVNCueWg9CDAwFw7+iR8XI5lpza/371
         2f0R9dRDPlP9uJvfp9IatLgd44wREIPD22ChQd5PQaLg6YIfqTJGgvnyXIeQI0i8Y/jR
         /YGpqXO6l/8ww2zj5ixjjmDJMITqgKYU077saJCtwOHOmZRydgBX91WJIsxMmLEAmB/T
         MY8A==
X-Gm-Message-State: ANoB5plRmxXvWlqGP2liwWxUWmFLfe1QwrmKyzcpayp6+qJhakgnuaZ5
        DZuBKOTSV7HEINCjCkp8Axg=
X-Google-Smtp-Source: AA0mqf4AbuVeMTh9dhX6PRFoohzd9/uzku/ZbYmlRAjDZdJhpYETDw/pFDbXDRh2thKP9K4023FBTw==
X-Received: by 2002:a17:903:234e:b0:188:cfc6:8543 with SMTP id c14-20020a170903234e00b00188cfc68543mr12202259plh.95.1669107470736;
        Tue, 22 Nov 2022 00:57:50 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b0017a0668befasm11400246ple.124.2022.11.22.00.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 00:57:50 -0800 (PST)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v7 2/7] media: dt-binding: nuvoton: Add bindings for NPCM VCD and ECE engine
Date:   Tue, 22 Nov 2022 16:57:19 +0800
Message-Id: <20221122085724.3245078-3-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221122085724.3245078-1-milkfafa@gmail.com>
References: <20221122085724.3245078-1-milkfafa@gmail.com>
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
---
 .../bindings/media/nuvoton,npcm-video.yaml    | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml

diff --git a/Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml b/Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml
new file mode 100644
index 000000000000..b5be7ef09038
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/nuvoton,npcm-video.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NPCM Video Capture/Encode Engine Device Tree Bindings
+
+maintainers:
+  - Joseph Liu <kwliu@nuvoton.com>
+  - Marvin Lin <kflin@nuvoton.com>
+
+description: |
+  Video Capture/Differentiation Engine (VCD) and Encoding Compression Engine
+  (ECE) present on Nuvoton NPCM SoCs.
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,npcm750-video
+      - nuvoton,npcm845-video
+
+  reg:
+    items:
+      - description: VCD registers
+      - description: ECE registers
+
+  reg-names:
+    items:
+      - const: vcd
+      - const: ece
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: VCD reset control
+      - description: ECE reset control
+
+  reset-names:
+    items:
+      - const: vcd
+      - const: ece
+
+  nuvoton,syscon-gcr:
+    $ref: /schemas/types.yaml#definitions/phandle
+    description: Phandle to the Global Control Register DT node
+
+  nuvoton,syscon-gfxi:
+    $ref: /schemas/types.yaml#definitions/phandle
+    description: Phandle to the Graphics Core Information DT node
+
+  memory-region:
+    description:
+      CMA pool to use for buffers allocation instead of the default CMA pool.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - resets
+  - reset-names
+  - nuvoton,syscon-gcr
+  - nuvoton,syscon-gfxi
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/nuvoton,npcm7xx-reset.h>
+
+    video: video@f0810000 {
+        compatible = "nuvoton,npcm750-video";
+        reg = <0xf0810000 0x10000>,
+              <0xf0820000 0x2000>;
+        reg-names = "vcd", "ece";
+        interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+        resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_VCD>,
+                 <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_ECE>;
+        reset-names = "vcd", "ece";
+        nuvoton,syscon-gcr = <&gcr>;
+        nuvoton,syscon-gfxi = <&gfxi>;
+    };
-- 
2.34.1

