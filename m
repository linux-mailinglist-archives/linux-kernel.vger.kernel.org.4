Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CBB614ABE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 13:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiKAMc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 08:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKAMcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 08:32:22 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97A7186C6;
        Tue,  1 Nov 2022 05:32:21 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j15so19909153wrq.3;
        Tue, 01 Nov 2022 05:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcHdGYuE9xm44RA5FHTYXcIEnNYvo39HlseQC/d3is4=;
        b=AVe0oNCbe6mj4a4F33eNcXgrCUocwQZLmr1c6mDX7/sBmRIcwJPw4QLcCOe/Uoiw2k
         H+rs0Azx4DLe2TFbfMqdnK7ZbW6ZOMZtsgEKFv8UqlyAgu4FKqi9AGFDG0IjoNqKghDh
         d7TpA2LURiajbVKMlYKTn3rd6s27u9+Vha/aZD3h5QXAUVNi8ksd1qa92BaYG2Mf9Nn3
         nAMMuCUs1RtW/ZJG70JcVJohoKkFpegRJYzxX0GeMu1dAIoukRY7acBlNkzDR/eRbEMo
         YUHMfHddIAv41tu0tpcTpuuk8Q4XI/Vm/PX39pHv/jSI79iTuvJtTUcFr2M6FWWFdrHE
         ljVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcHdGYuE9xm44RA5FHTYXcIEnNYvo39HlseQC/d3is4=;
        b=1S2p5TCHrSh/au03MmD0qDuAuEwAspo8Erc3YmSXfjPygF86KhzlDO+JeYPCxDs7PK
         WSd0tGs4OaVX2EG4qsnIgKDBB6eAmHMgPwIluR0vdNZPTC1tLNMrqyDkrV9tYHZ7QzlA
         IqsANkslDv9fDSYlzyBZTvzSncWuwZjwP0HTmsKZCeSViI0OvP8ZIyHKi3V0xlCJ00Es
         T6SW/3UiQjlqWU6/JaOwOsLSIwuaEXbvilaho4pzEUhmoDa97tcW8E2XZjFoAqtkUj8G
         KfynxcmHTzt0QeyyyC2M39/acrCoQ5f/bvKPr11zwfTvcFcUuFhvHH9P7ScvpKELgkla
         3sCQ==
X-Gm-Message-State: ACrzQf3/l3XRkyLabM65SPOmMhCSHBI5Hm8D7heHYe/aImrFSY2mmF/K
        ocCMybSyZQqogLv6ILlK1BI=
X-Google-Smtp-Source: AMsMyM4t/UaZ8R5H9R4/LQiV313FVGfPrVoFw0WvzFjQKUmRhgXf8pUy7MadGrLlFAhi+k7Oct/KsQ==
X-Received: by 2002:a05:6000:1a85:b0:230:f238:a48c with SMTP id f5-20020a0560001a8500b00230f238a48cmr11075518wry.92.1667305940226;
        Tue, 01 Nov 2022 05:32:20 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id f18-20020a1cc912000000b003cf5ec79bf9sm10404176wmb.40.2022.11.01.05.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 05:32:19 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wens@csie.org, samuel@sholland.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 1/3] media: dt-bindings: media: Add Allwinner H6 Deinterlace binding
Date:   Tue,  1 Nov 2022 13:31:59 +0100
Message-Id: <20221101123201.3021129-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221101123201.3021129-1-jernej.skrabec@gmail.com>
References: <20221101123201.3021129-1-jernej.skrabec@gmail.com>
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

Allwinner H6 Deinterlace core is used for deinterlacing interlaced video
content.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../allwinner,sun50i-h6-deinterlace.yaml      | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun50i-h6-deinterlace.yaml

diff --git a/Documentation/devicetree/bindings/media/allwinner,sun50i-h6-deinterlace.yaml b/Documentation/devicetree/bindings/media/allwinner,sun50i-h6-deinterlace.yaml
new file mode 100644
index 000000000000..521f58559444
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/allwinner,sun50i-h6-deinterlace.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/allwinner,sun50i-h6-deinterlace.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner H6 Deinterlace
+
+maintainers:
+  - Jernej Skrabec <jernej.skrabec@gmail.com>
+  - Chen-Yu Tsai <wens@csie.org>
+  - Samuel Holland <samuel@sholland.org>
+
+description: |-
+  The Allwinner H6 has a deinterlace core used for deinterlacing
+  interlaced video content.
+
+properties:
+  compatible:
+    const: allwinner,sun50i-h6-deinterlace
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Deinterlace interface clock
+      - description: Deinterlace module clock
+      - description: Deinterlace DRAM clock
+
+  clock-names:
+    items:
+      - const: bus
+      - const: mod
+      - const: ram
+
+  resets:
+    maxItems: 1
+
+  iommus:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/sun50i-h6-ccu.h>
+    #include <dt-bindings/reset/sun50i-h6-ccu.h>
+
+    deinterlace@1420000 {
+        compatible = "allwinner,sun50i-h6-deinterlace";
+        reg = <0x01420000 0x2000>;
+        clocks = <&ccu CLK_BUS_DEINTERLACE>,
+                 <&ccu CLK_DEINTERLACE>,
+                 <&ccu CLK_MBUS_DEINTERLACE>;
+        clock-names = "bus", "mod", "ram";
+        resets = <&ccu RST_BUS_DEINTERLACE>;
+        interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+        iommus = <&iommu 2>;
+    };
+
+...
-- 
2.38.1

