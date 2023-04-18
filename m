Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4EA6E5CCF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjDRJDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjDRJD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:03:26 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E08459DC;
        Tue, 18 Apr 2023 02:03:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o9-20020a05600c510900b003f17012276fso3707234wms.4;
        Tue, 18 Apr 2023 02:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681808595; x=1684400595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajXs06UijPfgdVv8DLP2AjdFM+0RrueVDlEarCdQVpo=;
        b=j7Pe/+pqlzOJ/vG0vE/qOsas0HRfO2+Yif8P/u89R3t1wByFjhtpyJ9hqepXktG0Nl
         tDcpNoX3u2TRUJX5Jwb3KGk+17CzCH4Rj/2UD+RpofTNFMekqcekCLWn84sC7qoOF/jK
         eDOhRd7SC2PDrf9s1FX1ChVbUomowIQDZJTpX40fd+wwCUquuZ/gMIO1PLYqFFgvZWi/
         XFFWCDEcbr3FY8Ko1pvpztWHOFegF9O/pbzU0z5RGot8hIfQQ13xOJl/pFC9jOz7khl3
         4FOd18k1fNTwr28ktoY6rtF+FVlXRf+kqMyB/VsZXPochk7goykJkLM1Gl6+GSHF5WPQ
         rxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681808595; x=1684400595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajXs06UijPfgdVv8DLP2AjdFM+0RrueVDlEarCdQVpo=;
        b=Dw6saPJiaswjp0zwd18YDyvi6V397hN7KeqOweJocUwTFW9652Tji4hJVSk/utQQpG
         FooW8b6Xe5qcRjJbrNhTRcjkyZaJx+r6FkFNAVh0nxUH3ULUvIfqu5nC0cumO9iCfn+5
         XucdivgwPLndrykPBc1t8TyP07KAhi6gv2QZEtgSGz+1GwWWfsNu6T4+MTrmaQYF+9tB
         nHQH7lv465BJ8wJJnP36JhKzTXfAEtIc2+MD91MN7EDiFuvxqe1qWAggFreX5rTI6lr2
         ETHBEzyRlS6r6Tf9jgwA+QAtotq3UAxpfuYXs01g69oyPKvsgv34MvFLWF/Tyi8lj4Ud
         t2WQ==
X-Gm-Message-State: AAQBX9dcR1dtL9B8KvfLkIYwekM5ZF/I6yJaeMEJNRfAQkXH3izT8pHD
        gcK8+SUkFYXJqnfVDYruQMVu+xodc8g=
X-Google-Smtp-Source: AKy350Y3vO4zuacALcR/VBO8Mb2EHh2eP+GP60L1voUD1Z7RLPzZD59QrceD/83BD1JCFq5d7+OAiA==
X-Received: by 2002:a05:600c:2295:b0:3f1:7345:2d4e with SMTP id 21-20020a05600c229500b003f173452d4emr5055352wmf.1.1681808595629;
        Tue, 18 Apr 2023 02:03:15 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id u7-20020a7bcb07000000b003ee70225ed2sm14341109wmj.15.2023.04.18.02.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 02:03:15 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH v3 1/9] dt-bindings: clock: add mtmips SoCs system controller
Date:   Tue, 18 Apr 2023 11:03:04 +0200
Message-Id: <20230418090312.2818879-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230418090312.2818879-1-sergio.paracuellos@gmail.com>
References: <20230418090312.2818879-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 000000000000..0b29dcacd686
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
+          - ralink,mt7628-sysc
+          - ralink,mt7688-sysc
+          - ralink,mt7620a-sysc
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

