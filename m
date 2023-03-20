Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F2F6C1B60
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjCTQZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbjCTQZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:25:03 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E88144A7;
        Mon, 20 Mar 2023 09:18:30 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id iw17so2567445wmb.0;
        Mon, 20 Mar 2023 09:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679329108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bctdp5Tstqk2AvqzSiT5td166EHJA9YJFi4utzMiUk=;
        b=pRfBxCwWR72Lzx1g0XoslE+NCxYw6bqXg1l3e6gCH7JywOfinbJcwD3dILh1wLS0PN
         +0rP1rloQ06BpwmTzBDKr9rNhtO09ofdw7HmNGE8EFhFaE2uMIfHXIoHOa+oxXJIf6xg
         gkKtBeiqMgPLN8uxr5gtdNqrwvudGEwdjhd2pZobSz/LV9KVN4xnY13OBbKGzMNhtUVb
         b9MnEYCZBQCsAJC+v+PR+Hg7ISPOYT2T+binsj18gC1aRYHp3PZ1jz9FJOJ1p1saj4Rw
         ohBGl/GUucYr3HIOU5qj+jCp0fr70Z4nQSLvg4ivnCE34cVZuNjSKYNPyK3PYfnpUisn
         PaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679329108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bctdp5Tstqk2AvqzSiT5td166EHJA9YJFi4utzMiUk=;
        b=OmpIQGRI0Z//nApfcCn5I9Ys1Ouk6EoX4IwtrDv6EoyXMy3IzWwM3s5aiFQHj4oxz+
         y7AUxf4DIyHGpic/wbjdUCrb9NA1Hpj8PeIIUsyXgcCnITAvbOB1Bwmw0vagYkobDuba
         6KMMnMhjaRAGWBj6AnjTrnwfmIln7lkBuykFvJtEi+SToRed6axfhx0hFe82v9w0q6hl
         zAfxEQ1wrRIvrsZCS6Vr23xfGdUHbk2NgqiAsCzfdpeyjwiun4SSh7I3BEQMUDmmAaxT
         2iYsDGJSTswblzIDX9qSd+UZ3VrW2+gLJzYeztJAh/Q17GKLmXTA2FvwNIZT4sV4EktV
         99eA==
X-Gm-Message-State: AO0yUKW/NJoE/CPp2g3OQ4qWBo5ebjyi+gSVDGT1srkRe4SAYUyHNzrQ
        AcNFDp6OZvGRr4kMwuAjKkLBOVRIakU=
X-Google-Smtp-Source: AK7set9AJ06ynLhZ7mboQgBenJFe64E3xlc7CoYCnRyJS5s8S+wf/xb5UomZoi/p9mePjIHyiw1L8w==
X-Received: by 2002:a05:600c:2256:b0:3ed:a63d:1a59 with SMTP id a22-20020a05600c225600b003eda63d1a59mr71391wmm.17.1679329108213;
        Mon, 20 Mar 2023 09:18:28 -0700 (PDT)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b003ee1acdaf95sm847776wmb.36.2023.03.20.09.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:18:27 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH 01/10] dt: bindings: clock: add mtmips SoCs clock device tree binding documentation
Date:   Mon, 20 Mar 2023 17:18:14 +0100
Message-Id: <20230320161823.1424278-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
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

Adds device tree binding documentation for clocks and resets in the
Mediatek MIPS and Ralink SOCs. This covers RT2880, RT3050, RT3052, RT3350,
RT3883, RT5350, MT7620, MT7628 and MT7688 SoCs.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 .../bindings/clock/mtmips-clock.yaml          | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mtmips-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/mtmips-clock.yaml b/Documentation/devicetree/bindings/clock/mtmips-clock.yaml
new file mode 100644
index 000000000000..c92969ce231d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mtmips-clock.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/mtmips-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MTMIPS SoCs Clock
+
+maintainers:
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+description: |
+  MediaTek MIPS and Ralink SoCs have an XTAL from where the cpu clock is
+  provided as well as derived clocks for the bus and the peripherals.
+
+  Each clock is assigned an identifier and client nodes use this identifier
+  to specify the clock which they consume.
+
+  The clocks are provided inside a system controller node.
+
+  This node is also a reset provider for all the peripherals.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - ralink,rt2880-sysc
+          - ralink,rt3050-sysc
+          - ralink,rt3052-sysc
+          - ralink,rt3352-sysc
+          - ralink,rt3883-sysc
+          - ralink,rt5350-sysc
+          - ralink,mt7620-sysc
+          - ralink,mt7620a-sysc
+          - ralink,mt7628-sysc
+          - ralink,mt7688-sysc
+          - ralink,rt2880-reset
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
+    sysc: sysc@0 {
+      compatible = "ralink,rt5350-sysc", "syscon";
+      reg = <0x0 0x100>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.25.1

