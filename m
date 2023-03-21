Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6EE6C2966
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjCUFAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjCUFAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:00:42 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A572F22A29;
        Mon, 20 Mar 2023 22:00:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id m2so12387456wrh.6;
        Mon, 20 Mar 2023 22:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679374839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lAcvidJFWBiWwQbXFpyAulclUoQGqy/9MXewW6ul7I=;
        b=pIKJ4xJr4Xp7/dL1yMyRtrjtH62DyYtnJJ9drmQwJ6T63vHPBLx9TivZgD0a6A10Cn
         xgPIyIL3OcT75PvAPBEELC1vZOWc62zBMUS9el1bnWCAUbrJjwQ/ZNRT90IUPagD29dl
         +zV4xUe8CtEV3jLeeBZhpFwklTMjp2DjZm3fWvrZ+E8oSCwuhT4wFvBOu66vSudmG6IA
         cWOpJpSsjKY1v2lyb7VWVJaz2rS2l/H/xkay2kQaqBuxdQzDYCsNsead084vDY9UHWAM
         /kvtgnjUrt77uUe52Rda1uWF4YL2ouLTlTmFtaAct+S9tI1RGsLsUnEoTXiMBpHcdkg7
         5SgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679374839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lAcvidJFWBiWwQbXFpyAulclUoQGqy/9MXewW6ul7I=;
        b=gAI7Jm5YvcwMeucdlV+qFmgBI2g1l0lfll3ZgC2WLZORBxLQjLVCII4HseTZYWhNkp
         4cEiI9PMQkas2z4IEGfbLJfrINmmPi7Awcv3k/qDbgZVscfgzIa9fMErrou4++2jF2bW
         GU5+TEY3gJlkbOzMngwg3oYY7+ZUkkpeI/lNZ0v+7/CouDuQtEDuJsCOzAul4dZFvQ5+
         6t4Unpf7KXcirP6OM36LCW5zW7b8iQBfh+QigrD6VhpY0xHaRIg/ZdNfFWmixY/wqIov
         MyfXEEZ4yKNgEn9nmWCkF79nQEiXF1o2uB7VQlAaM1raaT7E9T8PJ7v+Q3hv8YAJiV39
         1ffQ==
X-Gm-Message-State: AO0yUKWXpyYjxbwEtug+bK+41DKNBC/tYwNJWExPq5cLRTdJYb60589A
        n/99LuAMQRcoG+7cLJf10c/4Osn/JjU=
X-Google-Smtp-Source: AK7set/4yT6vQ+xJNRGzrbP7Z/pUqk5U3dY2R182obgvT8EmU08dBGFiPjhlb+Y2VMWwExPOJF1zTg==
X-Received: by 2002:adf:e589:0:b0:2d0:776:b766 with SMTP id l9-20020adfe589000000b002d00776b766mr1220672wrm.8.1679374838644;
        Mon, 20 Mar 2023 22:00:38 -0700 (PDT)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c020300b003eddefd8792sm6238432wmi.14.2023.03.20.22.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 22:00:38 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH v2 1/9] dt-bindings: clock: add mtmips SoCs system controller
Date:   Tue, 21 Mar 2023 06:00:26 +0100
Message-Id: <20230321050034.1431379-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230321050034.1431379-1-sergio.paracuellos@gmail.com>
References: <20230321050034.1431379-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds device tree binding documentation for system controller node present
in Mediatek MIPS and Ralink SOCs. This node is a clock and reset provider
for the rest of the world. This covers RT2880, RT3050, RT3052, RT3350,
RT3883, RT5350, MT7620, MT7628 and MT7688 SoCs.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 .../bindings/clock/mediatek,mtmips-sysc.yaml  | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml b/Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml
new file mode 100644
index 000000000000..f07e1652723b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/mediatek,mtmips-sysc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MTMIPS SoCs System Controller
+
+maintainers:
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+description: |
+  MediaTek MIPS and Ralink SoCs provides a system controller to allow
+  to access to system control registers. These registers include clock
+  and reset related ones so this node is both clock and reset provider
+  for the rest of the world.
+
+  These SoCs have an XTAL from where the cpu clock is
+  provided as well as derived clocks for the bus and the peripherals.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - ralink,mt7620-sysc
+          - ralink,mt7620a-sysc
+          - ralink,mt7628-sysc
+          - ralink,mt7688-sysc
+          - ralink,rt2880-sysc
+          - ralink,rt3050-sysc
+          - ralink,rt3052-sysc
+          - ralink,rt3352-sysc
+          - ralink,rt3883-sysc
+          - ralink,rt5350-sysc
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    description:
+      The first cell indicates the clock number.
+    const: 1
+
+  '#reset-cells':
+    description:
+      The first cell indicates the reset bit within the register.
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@0 {
+      compatible = "ralink,rt5350-sysc", "syscon";
+      reg = <0x0 0x100>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.25.1

