Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D733608B08
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 11:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiJVJVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 05:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiJVJVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 05:21:14 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2108.outbound.protection.outlook.com [40.107.247.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D30152FDA;
        Sat, 22 Oct 2022 01:34:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gzm/j6m7QhjA++Kwcee+FScTl+6x3N+pj0X1VgJBMUExJ3SjdipRjn/NWhh8PjNz2HRMfSCz1Qk+1GiXHZbbLtc+sf6aRuXyxUaVV/ofWueCOuyvrcXxUMqO7wUUeLuQLxopvNbwwYxhBWc31lmdyjWrl/oDE/yynJ9WrPrbaf1/Ty3bMC4v+iRntvbGvDU1XmUlMV9CECue5Xpddfs8RwJQcx0bFgQJBXlsdSasxrugJCRRBB4ugLtV+MmMjMEb8tvAlbZnel94/URFN7KJyVodYg30C53nalsAelq5eEPI4BMSmVaqtA2VFwLLCz6bdx2tN5cSkKyAuXp8Eutcjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0J3QKmhzf2vVuorTS8f+IqiJ57dyaHM5PuxO1cAy1U=;
 b=UdQu4X/giTNUv/vDvqc1Mkh0i+QhUby1nwDq8xJ5XC2oPQOSaUVauHo2J9joG3N+hs654XEo4kt5MMc0DuD14vwIBJ6sksuNpA90EfZybkPi1heZPrgZnAR2TlibJgqdjHjqHWHIexxZihZ8cyz5C7AMCZVTNgE2e9hGiWW3+3ho49WzcKB+IvA1WShcV0h4WI+lTnndF4aPY1//LrVsx3A10Q5YW5GxVduclRTrcWT2VWiBM3UpddPFUKZ8uqgQI1d5omf4/qByHcDZJcowULbOSIdr7ZqNuA5hAl3PtSiAYLz764xw/gQLxN8qS0VuJnDNeYoxcGFkKLiA7K2S1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0J3QKmhzf2vVuorTS8f+IqiJ57dyaHM5PuxO1cAy1U=;
 b=ZGVmZ2auQIzTeZlYvHo7uClbxIp08GobrQfHLrjDxtxk1NvdtyDTe7DIW/k+feh27kOcAs0BTSXSOJTmIfqxDiXYDwEL57c7RamB+zk4Xv5LQFVgDrCy2dmtb3H69DYEi1SLHyq9qcoJDLzN3vr3QMioR/w25I/Ct6dzW5lCpOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AS4P190MB1855.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:506::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Sat, 22 Oct
 2022 08:26:43 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::a621:b61f:de56:b8]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::a621:b61f:de56:b8%7]) with mapi id 15.20.5746.021; Sat, 22 Oct 2022
 08:26:43 +0000
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
Subject: [PATCH v2 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML DT scheme
Date:   Sat, 22 Oct 2022 11:26:25 +0300
Message-Id: <20221022082628.23876-2-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221022082628.23876-1-vadym.kochan@plvision.eu>
References: <20221022082628.23876-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::9) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|AS4P190MB1855:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e7d332-4e29-4d72-0359-08dab40726db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4YX8Eurr1r4+gWaVVd2a84ISpJWrBZT8yH2zbxTkdG8+gOS041dbE5hQ/xd3eazZHUzNZf4tyuuDUDG3A9zI3eQgPL7mueDb6opMqHch9gByfdp488GolS2j3xdvV+ZfRkvjana7L69K7lhUmmbq+qXzJ2UmwsMi4cg9iX7R913M4I5OKxAHwfgbC/b/1RWt5WX8lW7f9NZC9XiO+Pkze+nDbWuVy8/31oG/HWAX5m2/Whi5W0XrjyFQZBSaMq+okB4qB2ClC7X81/WYnilOkKW3bW2gCMa3ml7t/wvhmrFng+QzF3bQxg9MKbSiQxk26HmKXjeSiolEW59vK7xdzVQJPTMDCSM2ISbHn7wCP0FPXVSApA0t3OPxP2FHZxZTpy/f2+hPddbPyEhF2BHoE56EV63e/fVfmjA/lc6xv6X5Cwj3zDWKxHC+Kv19vpOR+6BWcVTWWfpA63NHT1Ql8EQXgW6myFD+euD4+atAykDREj2QIW8t1UVJRKSxi5Z+hCVnBlC2pCdVV6tVIM5BoQMsZfJntFwOyidINOxOvqorex+PaWX1t1rma0VmZZZxf5v78WllHX9BPBeDPGuA4PfyfzWTCLubHH0Pw0wnvvT0OcVu5ztkdgsE0xiGynNvvV/SEqvIMfkI23fl9Qrcv68SVSWTjVtitQX0uKkoyHyUzToLUcAuGj3wxgC2Ip/RWXXMsN+iQcRL71aO3Sarh7TPvK0/auqUFgdj9SJ/smO+GVFR0gopMCMWyN1F+tLDCapNtWHw7QKZg0DtcOWB+vCEAMpbCXZ/SIm8jBSsfKs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(34036004)(136003)(366004)(376002)(39840400004)(346002)(396003)(451199015)(1076003)(186003)(6506007)(52116002)(6512007)(107886003)(6666004)(5660300002)(83380400001)(7416002)(26005)(44832011)(41320700001)(30864003)(4326008)(2616005)(508600001)(54906003)(41300700001)(6486002)(966005)(8936002)(66556008)(110136005)(66946007)(8676002)(66476007)(316002)(2906002)(86362001)(36756003)(38350700002)(38100700002)(921005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7JoBSWi18yyVj14eaVZs7OEAuXAcldcQzia5TuV2UQlor+SOcyVn/XrjQCrt?=
 =?us-ascii?Q?suPbPPpYnem8/tXdQ9hnP9v+OjuFZCMXwMqc8AfG/qrg7PXxcR5jRBkkvogh?=
 =?us-ascii?Q?MOU8uozPgcYq7ZywTiSsq7KfnZLtjN0Voe8LCxl1x684jXOcZ6Mq48rMWvdP?=
 =?us-ascii?Q?4H/EHKA7rswfoU5TWmrgZv+jVZ2Y779dy2yw+XXCaAqkIiKB2FtyTbNjeGZd?=
 =?us-ascii?Q?jqbIKizaQJPKeiJWiT+4nUz2RsD2g1fPTmqk038eSI+ktU9/BWYRdst77BBX?=
 =?us-ascii?Q?cj/2vCl8lGjd7yW46+0SzP3jypFSpG4w504GaIlOSejxcoa62hBNflbNmZZk?=
 =?us-ascii?Q?6/W1eDMmRmmzNY2jxZ6Fh41TKIlDqLXWwc9TX82aFaQ4E6H4yUYArz67cg3k?=
 =?us-ascii?Q?GZX5W8Nzjm/aZwgnWUbfPiaa9Kk+z3kZf7cBTqpijLXqhxwux/dco9fcjwV2?=
 =?us-ascii?Q?onr5FbJKsxH/6PSOkNVECHTrmec0G1SbSZDhqv/HkUGcG+zQVlfFuc1lDg+V?=
 =?us-ascii?Q?6G2EiV2oaUw8TmAPj0Dw1IxU3VGZenz9x8Q6ARn+9lnH3JHGa74s9aiJ02zR?=
 =?us-ascii?Q?UVk7bRnVwj/E3eEu8jdBgzDt0D4N7r6F+qDN84q1XTrsK2Aodhy653ZA5paw?=
 =?us-ascii?Q?3un6DjRFgRIf1CoRWRQ2/Aznjs58H1umJ58fyGX58luPHAiaZpz1plEhS2rZ?=
 =?us-ascii?Q?89vDAqtZzVO9cv+GJq1byncUs8o8W5O8pHqf8WGH/nPLyvkRfuK0YYbtSIxk?=
 =?us-ascii?Q?ikPdT2XvW+H/iCNFOCQg4/eiX2mVoq7fuNFrm/VUwbbdjiy1LDXlZDQJMUxp?=
 =?us-ascii?Q?9ulVlTS+KGsk7/qZtWYMBI9GCh/hKeOOrTc2fMP4krUmp49X5qIrPuQsxGbn?=
 =?us-ascii?Q?Fp/f+jxVJmOKZnSNGDpMiSG0IUlvOO9/a/QiYZoMJm/6iO5fXx8bUkOHphTm?=
 =?us-ascii?Q?pkjXNRrZQHwqeq6UoVdF4ha1JCrAl7eQ8aWOsGbSSlefZ+bR48h+4Jj8uXuX?=
 =?us-ascii?Q?4d2c5AiVGWDWgx2al5jMivBa8NNoiW0+NXs+crtwAAP/sB49+VMDVE+1JHqp?=
 =?us-ascii?Q?TiHQyJLQKeSyu8VBY/3/xhMuvKjT+pU7UyDC4ZT1kBV1sVNMoG1Zfn6e2Yts?=
 =?us-ascii?Q?XTc9Wj5eyXRu2ljHrslefr/2J0SLaysYuDGPpQ3cc5yUlv4aDFk/lpMZ5r6R?=
 =?us-ascii?Q?PPToXuEsKmZzG3qVhgdXh5htQ+fuVbi6bW9K9kqve/DzpPtJjNdicJ5bizDb?=
 =?us-ascii?Q?hlNjFD7Q3vtjNNWBCQTLMGaFBsYuCrah0mxd4ESaov9f9bM5y04ScEJWyd62?=
 =?us-ascii?Q?jhBsc/ft71lYGC0P25+se1ZF/KUbStHAQEuPISBU2fGADvOwuBK32PgWJJzh?=
 =?us-ascii?Q?NTCgyPTznVXiScc3LoolesHcrZLfsGAG03VIpnmKgB8MmY8d+iSeqsIeJUDC?=
 =?us-ascii?Q?6BQ5asbGozCjklSHTUVMjrrC7qybYI5OsMK+sg9/mj2j7vMB9sLjJi63Z08s?=
 =?us-ascii?Q?8IxlueR0Jzj4adnLPzGx/cl+LUkWr/H1ZPedUIjtouKIIAeHSmTksnb+gxdb?=
 =?us-ascii?Q?Q/syWSLc0wBurHFheO3nAwsP7MFuod7ERXU34mlbqk8oRFqTC596V1vmOGrp?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e7d332-4e29-4d72-0359-08dab40726db
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 08:26:43.7410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXpE2uiEYDxVvdkzQPWIeEfGmPbJq4vfu5xIXQN7ov0vxw1+9EBKVpx1kMFbTl4nT0Oa6AUF7F+1nmEdpbW8XgUkJxC3l2iNFvfIrxj6zjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P190MB1855
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
v2:
  1) Fixed warning by yamllint with incorrect indentation for compatible list

 .../bindings/mtd/marvell,nand-controller.yaml | 199 ++++++++++++++++++
 .../devicetree/bindings/mtd/marvell-nand.txt  | 126 -----------
 2 files changed, 199 insertions(+), 126 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
new file mode 100644
index 000000000000..b3f4de7478cc
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
+          - const: marvell,armada-8k-nand-controller
+          - const: marvell,armada370-nand-controller
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

