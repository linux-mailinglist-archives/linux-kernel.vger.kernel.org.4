Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E70607F40
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiJUTrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiJUTrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:47:14 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2133.outbound.protection.outlook.com [40.107.103.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41C62930BA;
        Fri, 21 Oct 2022 12:47:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eien89ZotiRI9VitqM/UUgEK7++ZesQfGa2ryAYREAVMRjT4FONR0x4NJ3HnKlhc9DXRSqljEXtzLfO8oi7jx/KfpOlO2TI8arh8AmmBMZPtbGVhaIqMtAKSU8NQVswdMmRmnAoTh6/7mtdvEbWif31OSEFiHeyl/4IjlzHieqqattsuMVi1joH+wIrZWIZ4ABRNMk3MiCl2Qv8Fuzmssauk3WRlei86INzOEPQrBT8r9Um9Z/cH5RkMzBVJTv7Ke6oCYqzfU9qwvb653HL45CdGMLSAX9CHAo6g8YJsrr/zbZXt9KXyemoopyHC6JUMxo5V4l5YLWX1o/e08DggyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/xfbaDNHxdjfu09gIfamRX6kD8CHGJbFPRQ61Q/5GA=;
 b=MoEoxw0yrFy+lN0kD2AlUcmkRp1VFZENDbSShvYxQtuKSxPJym4IWRG0IEBb8BIrOPvqVrYRBVGDTDH4jA4zGdnSAQBd7blKkghhtTtpUbg+cqhtGiaUpTtFBqXIxuxx1LMpgWCVg8NHAccE3uc4CH37HUzHcXecLkgj8BrEJ+y+0+vku6wu3iNDcB+mb6nSzovv4uKrxwnWWaqk8W6k3xGzMhDAeTENpllTBM+pG5kLPlq2ZNDG5Y+7bzy6ecl640Qkk0rzErAXd5A36bUbK+TtcM9b7ks4UOUYOpLIG4/fbOkuyd8ButMf5UEkywji0r45lXAPU2lMd3UISUOrmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/xfbaDNHxdjfu09gIfamRX6kD8CHGJbFPRQ61Q/5GA=;
 b=dx8ZfEGVPaVV66Nu2H1E3ofNb80jlZQAxvcEHoh3vd/GegwzLi8iS895gzGEfghpl878i8Nx7ObZYnhuCbCxptxU8r+iSIxFH+LQRIwBbLn/xrFNr4oQfcSx+vnfyjrOvonhkHCTc4CgVaMVmjVZtcZSsqjTrDCDCFOx7AVuA8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by PAXP190MB1719.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:281::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Fri, 21 Oct
 2022 19:47:09 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::a621:b61f:de56:b8]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::a621:b61f:de56:b8%7]) with mapi id 15.20.5746.021; Fri, 21 Oct 2022
 19:47:09 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML DT scheme
Date:   Fri, 21 Oct 2022 22:45:49 +0300
Message-Id: <20221021194552.683-2-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221021194552.683-1-vadym.kochan@plvision.eu>
References: <20221021194552.683-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::14) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|PAXP190MB1719:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e0cba34-cf1c-47be-098b-08dab39d0ab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVTNm5Y/QLnyFoDwE3TGflj0EaZnAgVJ/+nLbTMwp8x0zCiVWjYns5WdRTRgdLWirxz+DaTJmaMR9NQA13YAFUIueXotMGa3dFOsMQV4zg850IlYuR3KZuyOOmt4+rXaPbc0GOPyARnyG02/Z1H2HqpzselL6263M34h2Pkbl988RvzAMgqe+jLfT/5leE9feLqyKzdlhuJMdOheB8PxiUohnHZwDd8DXkVxnfeEGkcWgOu7XMyscsHg1QpTme2efzTG5AFohF7Bs9WPub9G9DFQA5SRpXAwhCxPM5sABQTisASEkfH7ROQKLmaABXRhKqlUPBoDRAa9F6tFRJQIXcI/zHYSZ1I9gyHu7X2ek2JuUgIvcx1+ndmagbuBohrwXhsbaZ4xqK3ln0qtlLRRY+wEh36iVe7oxnB8bueO645IfDQv+teLJxCE6K9c94MuI3KLXdNTko6My0LA/znYWG8xjHXq9WSXcTy0wwXIZUuT863u+f4NXEWdj23nnsmituGneFNI2WPFV7DlWDGWBoVaYl111qH31cEDbMOxBdltJ+Fm+qq4IvZzuEJO2SUokxTFG5dqBm3oDMzgN+srAilDEDYYc1D5b2aRcONGCNIZqQr5V6sOCAtDuc3cvi4ONuoUw2gSCVrlZt5MA6SzudBZ+Rk4d08eTzT3cIhRjiWT1GLvOJAvxlfsO5Hnlrcg2Rk9a/OuT+sBlTCBESF8MaHICs/4vUjJaINN6fv9L8k6piFBFfQ8F+op+LJLh7mx8++p8w3CXe8d9juJ7lJKx0p9k55PJclm5/yxh1M/8P8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(34036004)(39830400003)(396003)(376002)(366004)(136003)(346002)(451199015)(5660300002)(186003)(8676002)(2906002)(26005)(4326008)(921005)(86362001)(2616005)(508600001)(66556008)(38100700002)(36756003)(110136005)(66476007)(6512007)(38350700002)(107886003)(6666004)(66946007)(54906003)(83380400001)(41300700001)(316002)(30864003)(8936002)(41320700001)(44832011)(1076003)(6506007)(6486002)(7416002)(52116002)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RMD+Oqs0/DCtV7P8XJhwjKs6G+2kvftA61AGxoRGLrRmwzySkSsVT3V9Xwu4?=
 =?us-ascii?Q?czf2bA0IinoIiOHNh9oP9U9oQ4M+iEsRhXLtMjfGkOe9DAZZGPQzzYzJdv+H?=
 =?us-ascii?Q?P35e4IDZ+4aKSej2s9/uORNqkzx/j8eHHaqKCLDFQG6YA4sFI6AJlkWt6t4z?=
 =?us-ascii?Q?q5cSMy4nvwO/98KMTugAuU7quyhQDEsCiBe2v92dGo+/UjT50rumq4Wy7NJR?=
 =?us-ascii?Q?/18F45RziAtIASjQ1pQgVWc+HRlKsXNRt4SXIKil0NcHATTkja2EKPTJtOuk?=
 =?us-ascii?Q?ytSTcVKhtKXWCMYzta7FkzGX9SD1Z8svqQtgCZIteT3UguZmC68meXt7t/U3?=
 =?us-ascii?Q?COKK5nsHtBdThXjy4Etjv1M+ZO0aq5vicllJZq7RGy2NGqGeKJcSmchtOaDb?=
 =?us-ascii?Q?7LOtYcVvTd1zmkroBfJ7Y1j5k57+ITnxTn8V8AyHldrcK1ZK+KT5pYlOw4Tq?=
 =?us-ascii?Q?wRJjcWvBhegHsxtY+x1Rk2ykTCzjq8qKuk7chniJgSJhF6GZaKv2JdD58M/Z?=
 =?us-ascii?Q?Rno+JYNEmO3XS7ZbJ8hiOSOAI4asv6mv3EVCepIyJ7j4gp6BVTMh19OkHfZr?=
 =?us-ascii?Q?aqAXSZkLcXEkmIGdYn5dCxIchk/47Mu9A4Ni+JGqXgA6JX3tJzHGDgZeas0D?=
 =?us-ascii?Q?g53QpFMLazk7vAEAD7Jymml2ct/O6BG3zLvcyfnSGn012s5KgthhFaHUXTvE?=
 =?us-ascii?Q?Fy22bIYSNPqpVU2Eew9gtu2CbFiMxNdxWJfDiJ1oAXjkZZukGDMFo8YM+CQb?=
 =?us-ascii?Q?BbZkkL4iaxqqr8ZQ+175SDnYdRXA8Yskk8c5+KwckIX3kd8HcjXnJg1WZ2lI?=
 =?us-ascii?Q?+J0vCj5wFhzfVmBAkHN7heCaU/zNCrQnc2FP1w4/ppJWU/pWxdjIHWqi+kxA?=
 =?us-ascii?Q?9StGFqJFznUowEdUtg+YiHA2BnL0Uoc+q9DcCxLQvKrUW8zfmB6tL5KVB4hN?=
 =?us-ascii?Q?8/CYDDaChEWNeYU+5W4tdIp6exypNIq7mQdLjE/2KeNDCL5TBZfqlA5qRMkz?=
 =?us-ascii?Q?E1njO/Es9PjXyjjAuHAtQqyNIyvYCrlyaNwBUUXn/98PHcHKrlgk6smTM75o?=
 =?us-ascii?Q?SJ9EcEUPPDs54ZIfnhvheEnVx76E/ZBu0f0NoGKOpiB6n3p8SA9aYwAknINf?=
 =?us-ascii?Q?84dmAqxDe/pJHrV3zwuUpp62Y+1bs9ENZVpaqfFTNc+ATdKiD7kDb7sfbh9i?=
 =?us-ascii?Q?H8uV7VIUIQUAutiAaqAAzqhPbLO7XFRQp0zyf2ZZC4kGVp3Fw4ySAN+691/M?=
 =?us-ascii?Q?xBXSLqhi3nYqkNOxGs6u93ok7JHHBYjsDaRcyj9Kle6eHL4UB5g+EnAqlDIy?=
 =?us-ascii?Q?Je7+WHgi/bElBSZ0rMVm7APzMxsXJ8buvpJfi4tkJ8dczjnLFToToC0tjHDa?=
 =?us-ascii?Q?yNrHQ9inLpG5oXx2D3JB3iR59UZXW/lMHcS9HT7MGGuZ5yyCmy3HFesYy2je?=
 =?us-ascii?Q?edl2A9WO/SX9bryYss10w6hC3vw2WWhlkKpHb+LkAaFVXlE9/iNp8180qrr+?=
 =?us-ascii?Q?lYO3C0JsusAb+bc7xx7XqQhJS34uNB4YTUflszv88TnN4dXv13HJAx/nBDHC?=
 =?us-ascii?Q?PDHzJSO3gKQBFKCklOJ/M+Bxg4/z6402qha747WGp8rDLI+ldpDTm3tbmA4m?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0cba34-cf1c-47be-098b-08dab39d0ab4
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 19:47:09.8248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRaJdUahpGqFXwA9ApRj1NHVHbPDUWhrR91rezxgxUhk3OCF0WuQfrdjzz9XVdSDMwN6o7LP7j9kl7irWUcapPIaLoQNOOD77XuWpKmtRqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP190MB1719
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the DT binding to a YAML schema to enable the DT validation.

Dropped deprecated compatibles and properties described in txt file.

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
 .../bindings/mtd/marvell,nand-controller.yaml | 199 ++++++++++++++++++
 .../devicetree/bindings/mtd/marvell-nand.txt  | 126 -----------
 2 files changed, 199 insertions(+), 126 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
new file mode 100644
index 000000000000..535b7f8903c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
@@ -0,0 +1,199 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/marvell,nand-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell NAND Flash Controller (NFC)
+
+maintainers:
+  - Miquel Raynal <miquel.raynal@bootlin.com>
+
+properties:
+
+  compatible:
+    oneOf:
+      - items:
+        - const: marvell,armada-8k-nand-controller
+        - const: marvell,armada370-nand-controller
+      - const: marvell,armada370-nand-controller
+      - const: marvell,pxa3xx-nand-controller
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+    description: |
+     Shall reference the NAND controller clocks, the second one is
+     is only needed for the Armada 7K/8K SoCs
+
+  clock-names:
+    items:
+      - const: core
+      - const: reg
+    description: |
+      Mandatory if there is a second clock, in this case there
+      should be one clock named "core" and another one named "reg"
+
+  dmas:
+    maxItems: 1
+    description: rxtx DMA channel
+
+  dma-names:
+    items:
+      - const: rxtx
+
+  marvell,system-controller:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Syscon node that handles NAND controller related registers
+
+patternProperties:
+  "^nand@[0-3]$":
+    type: object
+    properties:
+
+      reg:
+        minimum: 0
+        maximum: 3
+
+      nand-rb:
+        minimum: 0
+        maximum: 1
+
+      nand-ecc-strength:
+        enum: [1, 4, 8]
+
+      nand-on-flash-bbt: true
+
+      nand-ecc-mode: true
+
+      nand-ecc-algo:
+        description: |
+          This property is essentially useful when not using hardware ECC.
+          Howerver, it may be added when using hardware ECC for clarification
+          but will be ignored by the driver because ECC mode is chosen depending
+          on the page size and the strength required by the NAND chip.
+          This value may be overwritten with nand-ecc-strength property.
+
+      nand-ecc-step-size:
+        const: 512
+        description: |
+          Marvell's NAND flash controller does use fixed strength
+          (1-bit for Hamming, 16-bit for BCH), so the actual step size
+          will shrink or grow in order to fit the required strength.
+          Step sizes are not completely random for all and follow certain
+          patterns described in AN-379, "Marvell SoC NFC ECC".
+
+      label:
+        $ref: /schemas/types.yaml#/definitions/string
+
+      partitions:
+        type: object
+        $ref: "/schemas/mtd/partitions/partition.yaml"
+
+      marvell,nand-keep-config:
+        description: |
+          Orders the driver not to take the timings from the core and
+          leaving them completely untouched. Bootloader timings will then
+          be used.
+        $ref: /schemas/types.yaml#/definitions/flag
+
+      marvell,nand-enable-arbiter:
+        description: |
+          To enable the arbiter, all boards blindly used it,
+          this bit was set by the bootloader for many boards and even if
+          it is marked reserved in several datasheets, it might be needed to set
+          it (otherwise it is harmless) so whether or not this property is set,
+          the bit is selected by the driver.
+        $ref: /schemas/types.yaml#/definitions/flag
+        deprecated: true
+
+    additionalProperties: false
+
+    required:
+      - reg
+      - nand-rb
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - interrupts
+  - clocks
+
+allOf:
+  - $ref: "nand-controller.yaml#"
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: marvell,pxa3xx-nand-controller
+    then:
+      required:
+        - dmas
+        - dma-names
+    else:
+      properties:
+        dmas: false
+        dma-names: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: marvell,armada-8k-nand-controller
+    then:
+      required:
+        - marvell,system-controller
+    else:
+      properties:
+        marvell,system-controller: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    nand_controller: nand-controller@d0000 {
+            compatible = "marvell,armada370-nand-controller";
+            reg = <0xd0000 0x54>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&coredivclk 0>;
+
+            nand@0 {
+                    reg = <0>;
+                    label = "main-storage";
+                    nand-rb = <0>;
+                    nand-ecc-mode = "hw";
+                    marvell,nand-keep-config;
+                    nand-on-flash-bbt;
+                    nand-ecc-strength = <4>;
+                    nand-ecc-step-size = <512>;
+
+                    partitions {
+                            compatible = "fixed-partitions";
+                            #address-cells = <1>;
+                            #size-cells = <1>;
+
+                            partition@0 {
+                                    label = "Rootfs";
+                                    reg = <0x00000000 0x40000000>;
+                            };
+                    };
+             };
+    };
diff --git a/Documentation/devicetree/bindings/mtd/marvell-nand.txt b/Documentation/devicetree/bindings/mtd/marvell-nand.txt
deleted file mode 100644
index a2d9a0f2b683..000000000000
--- a/Documentation/devicetree/bindings/mtd/marvell-nand.txt
+++ /dev/null
@@ -1,126 +0,0 @@
-Marvell NAND Flash Controller (NFC)
-
-Required properties:
-- compatible: can be one of the following:
-    * "marvell,armada-8k-nand-controller"
-    * "marvell,armada370-nand-controller"
-    * "marvell,pxa3xx-nand-controller"
-    * "marvell,armada-8k-nand" (deprecated)
-    * "marvell,armada370-nand" (deprecated)
-    * "marvell,pxa3xx-nand" (deprecated)
-  Compatibles marked deprecated support only the old bindings described
-  at the bottom.
-- reg: NAND flash controller memory area.
-- #address-cells: shall be set to 1. Encode the NAND CS.
-- #size-cells: shall be set to 0.
-- interrupts: shall define the NAND controller interrupt.
-- clocks: shall reference the NAND controller clocks, the second one is
-  is only needed for the Armada 7K/8K SoCs
-- clock-names: mandatory if there is a second clock, in this case there
-  should be one clock named "core" and another one named "reg"
-- marvell,system-controller: Set to retrieve the syscon node that handles
-  NAND controller related registers (only required with the
-  "marvell,armada-8k-nand[-controller]" compatibles).
-
-Optional properties:
-- label: see partition.txt. New platforms shall omit this property.
-- dmas: shall reference DMA channel associated to the NAND controller.
-  This property is only used with "marvell,pxa3xx-nand[-controller]"
-  compatible strings.
-- dma-names: shall be "rxtx".
-  This property is only used with "marvell,pxa3xx-nand[-controller]"
-  compatible strings.
-
-Optional children nodes:
-Children nodes represent the available NAND chips.
-
-Required properties:
-- reg: shall contain the native Chip Select ids (0-3).
-- nand-rb: see nand-controller.yaml (0-1).
-
-Optional properties:
-- marvell,nand-keep-config: orders the driver not to take the timings
-  from the core and leaving them completely untouched. Bootloader
-  timings will then be used.
-- label: MTD name.
-- nand-on-flash-bbt: see nand-controller.yaml.
-- nand-ecc-mode: see nand-controller.yaml. Will use hardware ECC if not specified.
-- nand-ecc-algo: see nand-controller.yaml. This property is essentially useful when
-  not using hardware ECC. Howerver, it may be added when using hardware
-  ECC for clarification but will be ignored by the driver because ECC
-  mode is chosen depending on the page size and the strength required by
-  the NAND chip. This value may be overwritten with nand-ecc-strength
-  property.
-- nand-ecc-strength: see nand-controller.yaml.
-- nand-ecc-step-size: see nand-controller.yaml. Marvell's NAND flash controller does
-  use fixed strength (1-bit for Hamming, 16-bit for BCH), so the actual
-  step size will shrink or grow in order to fit the required strength.
-  Step sizes are not completely random for all and follow certain
-  patterns described in AN-379, "Marvell SoC NFC ECC".
-
-See Documentation/devicetree/bindings/mtd/nand-controller.yaml for more details on
-generic bindings.
-
-
-Example:
-nand_controller: nand-controller@d0000 {
-	compatible = "marvell,armada370-nand-controller";
-	reg = <0xd0000 0x54>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&coredivclk 0>;
-
-	nand@0 {
-		reg = <0>;
-		label = "main-storage";
-		nand-rb = <0>;
-		nand-ecc-mode = "hw";
-		marvell,nand-keep-config;
-		nand-on-flash-bbt;
-		nand-ecc-strength = <4>;
-		nand-ecc-step-size = <512>;
-
-		partitions {
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			partition@0 {
-				label = "Rootfs";
-				reg = <0x00000000 0x40000000>;
-			};
-		};
-	};
-};
-
-
-Note on legacy bindings: One can find, in not-updated device trees,
-bindings slightly different than described above with other properties
-described below as well as the partitions node at the root of a so
-called "nand" node (without clear controller/chip separation).
-
-Legacy properties:
-- marvell,nand-enable-arbiter: To enable the arbiter, all boards blindly
-  used it, this bit was set by the bootloader for many boards and even if
-  it is marked reserved in several datasheets, it might be needed to set
-  it (otherwise it is harmless) so whether or not this property is set,
-  the bit is selected by the driver.
-- num-cs: Number of chip-select lines to use, all boards blindly set 1
-  to this and for a reason, other values would have failed. The value of
-  this property is ignored.
-
-Example:
-
-	nand0: nand@43100000 {
-		compatible = "marvell,pxa3xx-nand";
-		reg = <0x43100000 90>;
-		interrupts = <45>;
-		dmas = <&pdma 97 0>;
-		dma-names = "rxtx";
-		#address-cells = <1>;
-		marvell,nand-keep-config;
-		marvell,nand-enable-arbiter;
-		num-cs = <1>;
-		/* Partitions (optional) */
-       };
-- 
2.17.1

