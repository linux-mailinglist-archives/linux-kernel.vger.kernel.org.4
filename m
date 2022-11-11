Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BFD6264BE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 23:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbiKKWrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 17:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbiKKWrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:47:10 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150043.outbound.protection.outlook.com [40.107.15.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36155532F3;
        Fri, 11 Nov 2022 14:47:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kM8Q9uCN5Uikvq40SG2ABXMXmfjrrSLCe30Qaiyu8C69/LdD3PUh/H91jpEvYg0481t0Z4GhLlGhKA1a6ZiCRKnEkyFnSEyYbIsR0+jn8jw/4PwXVOGBXE1zE3DFV8RijIW2cHr7AnypyvtRtMY3OBS79ohB3/eoms1lrjkhHBcIbiXYMy9va/FvA/WfYphjtFtQJUIqU8ji/fXv3JZw6DyuWlNZvgJWH4fm3uEqh3HoO8H+rDeJUgrlcEy7ZMbBM3Qy2Hp/PU9/vlaG6wgmlYZhY2vtQAa3sRZLpA0+cflcvGo0yPHKLqwVNxDGQgU3GYqQfY2nCn1ywqLNXsr5Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tkl8PT8zzkfqDAcFnXYeGlgXksdGpJLiKubggmkkcxI=;
 b=h2Zklljymvn//etwOX11EQS+/VgDUwj3W6WPOy/c7AlVJn/McDWVH1UY+5tfyrRVZhUbfkL1cwXUXFyuXdqgt7y+xRbVqn4aFcG3RHVXAGm0Vgz/ndKlHSZZ2zyob4oldzf8Dan+TcUcQArCYx2vlU/qxlGsmyshc4/XCu1zg/gNEDt9SVKz64Jc21mNRnqwJSQ16Y4HLDXUkQMNXt0RgrZrb8nWW1F0UZxx+2/VoEtiPQBN4p1GqNfvAFJDv471GTNGCz05nITeawp3/NlRYKBU5LTJjyQRzLCGNpXw9mh4uGG2chwrPch8hvJom7xs4Jd0r7uSB3rtIUJvTo8RNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tkl8PT8zzkfqDAcFnXYeGlgXksdGpJLiKubggmkkcxI=;
 b=HrhuLXbHxuL6ooAINyCxLyy6kccbdQ+wwloj0ME/Wd3i8KHhT0nwIBBXIcr9Qt2EOFZbKnLjQz4mrpeWR+Jw2ZSpHvghf8lEiXzaPAmDpXnCVCURDYipqzuT2qKChQxJh3CnLOhuN70G/x5Ck8Vb1781uZ/635ms1Y9Epdh/yuM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by AM0PR04MB6884.eurprd04.prod.outlook.com (2603:10a6:208:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 11 Nov
 2022 22:47:06 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::9317:77dc:9be2:63b]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::9317:77dc:9be2:63b%7]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 22:47:05 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     linux-spi@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH v2] dt-bindings: spi: convert Freescale DSPI to dt-schema
Date:   Sat, 12 Nov 2022 00:46:51 +0200
Message-Id: <20221111224651.577729-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4P190CA0009.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::19) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5136:EE_|AM0PR04MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2ca4f1-19e9-4137-d5e5-08dac436a844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ujVHyVyW3mJU3S8L/VUIdmYbm9PQTltAv8TpU97zOBoM3RIxN+LA7YZBTeTY+9NOxx4MfEZ/3ErXBX/vjdP/gJNnt+ahFx2b5IIQs67vcIBLvfiP5sMfpx9flvogpMo/zi6nnQ6uXvtwO6PYPWgDcQta9/7EViGBrg4wY6Kr3+CnoddbmTTHeUdJh2NW4a7lhIhjvh5mj3dCstf5F3Dn8bPNkPEGGI1Uj+lepMEFVMzRYuMMg1FxLgjJlZ3jp8P9yDZceaNL9r7GrSpVaBqwDUIB6Qk6z9O0Sy9v5pKf7YFnRACX389p8FNPKBtlRPHt5aae71mqoqC6f88+SsnV1UdmzC0H7OQk4Ug8cCCowTtbfmLLYx0UfcvbA3PlAKMHrbaSoQKMR+yYw2oibg/DgfOTarq1zMPeXCnxzjBMNGf5O3WWMbcMYIFFxnACvlmXjZTL2AGJE7o5yQsnCtsjwNl9I5YNUdD9CS+LOzLk7VmS+z4bwb5c4iEEEKMbxeohoMf6xCZkGcY8q0Noq1F40Kx7xtcGDC2yFhqr7peciI3UduS1OzE7+KEriwOxeeVTr4BpNYvoZt+LuxoW4xvKzOOiUSb2mcyxhM8IQOVAz/+wx2CUnED3xCzghBA3/3uiDXEivOQD0tXPkHsnxbyx5NnrbJdpn8gnu2fU7O4wYaL1B49kNwfzzyV6pRzKU4kDCiG+iU116W9YzpDQsp8gtrdPiNZr3aO9iNsolS9AkOt0nO1yYi5GP/Jv6JvgJjPMTncrNbWXbixEG34gxSeg7+chQTWyf5lkhcBBuvXIG/7321GJP5Rn85OUlj2Mk99fzd9xnZo6OpsGH2v4h+ntQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199015)(4326008)(2906002)(8676002)(316002)(83380400001)(6666004)(86362001)(38350700002)(38100700002)(52116002)(6506007)(36756003)(66476007)(66556008)(66946007)(966005)(54906003)(2616005)(6486002)(6512007)(8936002)(41300700001)(186003)(478600001)(1076003)(44832011)(26005)(6916009)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JuA5cslhn5WpXmNCG7s2p+HfjlZAiT+VqR3rPYkOsthh1IwI7Z/orJOIEoUw?=
 =?us-ascii?Q?jOfZsl0IGg2n1GIdxiJARAE0371LcVw0mF5O3iBvI2ub48b2zfM1YUhUquCR?=
 =?us-ascii?Q?+PN6kHE/7VcTfb345PLHXDnhO5T/sdKaFdOqDVl0g9wdE6wvu7R0nqjz8bI2?=
 =?us-ascii?Q?FZ/ypfD6JemGgYgvkBfckw/SZerp07kuCKbJZdlnI44WFHv7JbXUOergDY0T?=
 =?us-ascii?Q?xB+9kEPj0wqXifpxJ984iPHUJ0Ld+oV6ODqeZ+1k5cRF3L2B62fCHynTzgP6?=
 =?us-ascii?Q?uF38LoEcNLTY6yi/9ZI2zrE/LGNHHEBqzyqXW7Cq/4yQ0tky2CdveZvuCC/T?=
 =?us-ascii?Q?H6zdJ6E/upZuLHZeNcmwwxwp5X5gOelo7RL1O8CU8Y4LrSNr8dfQuduha4OB?=
 =?us-ascii?Q?zoB/KP67iu06DBdadpLxT5QmiTHDKuAahtRjfUuilJSrPzl/fuRkJlinENqR?=
 =?us-ascii?Q?ZK3IY5vRD26JKuhWbtg+8r8FqQCK4RHroadT7oiopZfG3+fpXCaLLuiKYwOf?=
 =?us-ascii?Q?8+O6cg5wPg7iNQy4WIuRgBxgfMn70b89rOf9WtZNCTsDpDugL0WZ0cccGDkU?=
 =?us-ascii?Q?ifp2gUeas6hWEOHZr/8uoUrWDs0q5zQktYnsuS7BK6IgqrpIbgE9+J4mBcdv?=
 =?us-ascii?Q?RjyiC3KlqAbMvPeUwIAOCy994kGFspcaO8/cbRTgC7FN67YETIPAcjBpS0ZO?=
 =?us-ascii?Q?YI2JhuM6l5nM6/eU05AOs9ngKmQkH1o1KqH8FQCarUcP8y8dCtsZjhBYELjW?=
 =?us-ascii?Q?Ki0TFrsDUCktuAAQV6emBQNRAvg9B1q5OkamFgchxMmbgOzY8kuQprniijtK?=
 =?us-ascii?Q?E80x/3bPC+psjAgOKqt13J6T7sv8+ZMBJhjoYH0BZ7yC8XNv1+M+v1HyLDFp?=
 =?us-ascii?Q?I1tdPkLxx5pbwC4pJq0ErAblBt0agfHeZYddqY3dZDMDKi0ci7huVDm71qG1?=
 =?us-ascii?Q?KIRDNovsbbryGC3lUT5ZtxZON8sc7y5oq4xIRDXT5niCHBM/gMuRao7BGQmr?=
 =?us-ascii?Q?tWgYtqjBPQN5V/Qe/eWnV4CyzXFqZRXwfM38M7mrhwWXXDFxesWyCZ3n6OxG?=
 =?us-ascii?Q?IfYV/bdqCCpkgCISbz/oNtFc4hclrhmKUqFvQOQCVzZAeBa5B8WBayFrrTU2?=
 =?us-ascii?Q?HEIJPvdVTJtQ4XUJk11W8I6duRDfSfbJ+mhofePisgsQPir9sk1mLeCXSBC3?=
 =?us-ascii?Q?bckZGMRWqonJRQZs9YcW3qPxzS2yVdR1TMA467aCFT/Bi7efFCMvlAVdPoSG?=
 =?us-ascii?Q?WWquX17dZFeFmOct7TEGUmTwZuDD73MJwzPePgabcMqluKUdfgliJaqYv5is?=
 =?us-ascii?Q?zQVlIHBG52J5WsdkAA3+oOPq7aOEzLp5OQewch3lxeO1OzZ3ohAMJQl1onUv?=
 =?us-ascii?Q?vRvEmPrqH6datN7elvI94rOQWa/LjtArfs8hiszkiBlNd/WGd3hpkzinH9mv?=
 =?us-ascii?Q?hGBVE3aYyEGYCb2NhOAhmCYmNk0RMKPno8/FvHI+KI3El3V5SOjS3a+v1tfO?=
 =?us-ascii?Q?JKrBN/NMKaiJAer6owMeC9nEbvWsPo/3j9/S8A9uGtfTkNrqmEfggjUVMjGJ?=
 =?us-ascii?Q?ZYQc3gbOvkyPyrNZ0ypWQqNgfITTSNRMlrLJWJTZ9cKnzwizDjva4MxN6jvI?=
 =?us-ascii?Q?dw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2ca4f1-19e9-4137-d5e5-08dac436a844
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 22:47:05.9676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLzQSEtehDPEY84e0jhRiSuT7wkX4Rgkjm/yRxPdJtuH4NbyMiQYFZOKBGu/HrD8VssxNsEfvEWaU7Q0V8tngQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6884
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuldeep Singh <kuldeep.singh@nxp.com>

Convert the Freescale DSPI binding to DT schema format.

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1 (from more than 1 year ago) at:
https://patchwork.kernel.org/project/spi-devel-general/patch/20210315121518.3710171-1-kuldeep.singh@nxp.com/

 .../fsl,spi-fsl-dspi-peripheral-props.yaml    |  28 +++++
 .../bindings/spi/fsl,spi-fsl-dspi.yaml        | 118 ++++++++++++++++++
 .../devicetree/bindings/spi/spi-fsl-dspi.txt  |  65 ----------
 .../bindings/spi/spi-peripheral-props.yaml    |   1 +
 MAINTAINERS                                   |   3 +-
 5 files changed, 149 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi-peripheral-props.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt

diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi-peripheral-props.yaml
new file mode 100644
index 000000000000..d15f77c040d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi-peripheral-props.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/fsl,spi-fsl-dspi-peripheral-props.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Peripheral-specific properties for Freescale DSPI controller
+
+maintainers:
+  - Vladimir Oltean <olteanv@gmail.com>
+
+description:
+  See spi-peripheral-props.yaml for more info.
+
+properties:
+  fsl,spi-cs-sck-delay:
+    description:
+      Delay in nanoseconds between activating chip select and the start of
+      clock signal, at the start of a transfer.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  fsl,spi-sck-cs-delay:
+    description:
+      Delay in nanoseconds between stopping the clock signal and
+      deactivating chip select, at the end of a transfer.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml
new file mode 100644
index 000000000000..8a790c0ed95f
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml
@@ -0,0 +1,118 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/fsl,spi-fsl-dspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale DSPI Controller
+
+maintainers:
+  - Vladimir Oltean <olteanv@gmail.com>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+properties:
+  compatible:
+    description:
+      Some integrations can have a single compatible string containing their
+      SoC name (LS1012A, LS1021A, ...). Others require their SoC compatible
+      string, plus a fallback compatible string (either on LS1021A or on
+      LS2085A).
+    oneOf:
+      - enum:
+          - fsl,ls1012a-dspi
+          - fsl,ls1021a-v1.0-dspi
+          - fsl,ls1028a-dspi
+          - fsl,ls2085a-dspi
+          - fsl,lx2160a-dspi
+          - fsl,vf610-dspi
+      - items:
+          - enum:
+              - fsl,ls1012a-dspi
+              - fsl,ls1028a-dspi
+              - fsl,ls1043a-dspi
+              - fsl,ls1046a-dspi
+              - fsl,ls1088a-dspi
+          - const: fsl,ls1021a-v1.0-dspi
+      - items:
+          - enum:
+              - fsl,ls2080a-dspi
+              - fsl,lx2160a-dspi
+          - const: fsl,ls2085a-dspi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: dspi
+
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+  spi-num-chipselects:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Number of available native Chip Select signals
+
+  bus-num:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: SoC-specific identifier for the SPI controller
+
+  little-endian: true
+  big-endian: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - spi-num-chipselects
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/fsl,qoriq-clockgen.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        spi@2100000 {
+            compatible = "fsl,ls1028a-dspi", "fsl,ls1021a-v1.0-dspi";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            reg = <0x0 0x2100000 0x0 0x10000>;
+            interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+            clock-names = "dspi";
+            clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(2)>;
+            dmas = <&edma0 0 62>, <&edma0 0 60>;
+            dma-names = "tx", "rx";
+            pinctrl-names = "default";
+            pinctrl-0 = <&pinctrl_dspi0_1>;
+            spi-num-chipselects = <4>;
+            little-endian;
+
+            flash@0 {
+                compatible = "jedec,spi-nor";
+                spi-max-frequency = <10000000>;
+                fsl,spi-cs-sck-delay = <100>;
+                fsl,spi-sck-cs-delay = <100>;
+                reg = <0>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
deleted file mode 100644
index 30a79da9c039..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
+++ /dev/null
@@ -1,65 +0,0 @@
-ARM Freescale DSPI controller
-
-Required properties:
-- compatible : must be one of:
-	"fsl,vf610-dspi",
-	"fsl,ls1021a-v1.0-dspi",
-	"fsl,ls1012a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
-	"fsl,ls1028a-dspi",
-	"fsl,ls1043a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
-	"fsl,ls1046a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
-	"fsl,ls1088a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
-	"fsl,ls2080a-dspi" (optionally followed by "fsl,ls2085a-dspi"),
-	"fsl,ls2085a-dspi",
-	"fsl,lx2160a-dspi",
-- reg : Offset and length of the register set for the device
-- interrupts : Should contain SPI controller interrupt
-- clocks: from common clock binding: handle to dspi clock.
-- clock-names: from common clock binding: Shall be "dspi".
-- pinctrl-0: pin control group to be used for this controller.
-- pinctrl-names: must contain a "default" entry.
-- spi-num-chipselects : the number of the chipselect signals.
-
-Optional property:
-- big-endian: If present the dspi device's registers are implemented
-  in big endian mode.
-- bus-num : the slave chip chipselect signal number.
-
-Optional SPI slave node properties:
-- fsl,spi-cs-sck-delay: a delay in nanoseconds between activating chip
-  select and the start of clock signal, at the start of a transfer.
-- fsl,spi-sck-cs-delay: a delay in nanoseconds between stopping the clock
-  signal and deactivating chip select, at the end of a transfer.
-
-Example:
-
-dspi0@4002c000 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	compatible = "fsl,vf610-dspi";
-	reg = <0x4002c000 0x1000>;
-	interrupts = <0 67 0x04>;
-	clocks = <&clks VF610_CLK_DSPI0>;
-	clock-names = "dspi";
-	spi-num-chipselects = <5>;
-	bus-num = <0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_dspi0_1>;
-	big-endian;
-
-	sflash: at26df081a@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "atmel,at26df081a";
-		spi-max-frequency = <16000000>;
-		spi-cpol;
-		spi-cpha;
-		reg = <0>;
-		linux,modalias = "m25p80";
-		modal = "at26df081a";
-		fsl,spi-cs-sck-delay = <100>;
-		fsl,spi-sck-cs-delay = <50>;
-	};
-};
-
-
diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index dca677f9e1b9..a475e757f8da 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -101,6 +101,7 @@ properties:
 # The controller specific properties go here.
 allOf:
   - $ref: cdns,qspi-nor-peripheral-props.yaml#
+  - $ref: fsl,spi-fsl-dspi-peripheral-props.yaml#
   - $ref: samsung,spi-peripheral-props.yaml#
   - $ref: nvidia,tegra210-quad-peripheral-props.yaml#
 
diff --git a/MAINTAINERS b/MAINTAINERS
index c242098a34f9..c75ae49c85b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8160,7 +8160,8 @@ FREESCALE DSPI DRIVER
 M:	Vladimir Oltean <olteanv@gmail.com>
 L:	linux-spi@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
+F:	Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml
+F:	Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi-peripheral-props.yaml
 F:	drivers/spi/spi-fsl-dspi.c
 F:	include/linux/spi/spi-fsl-dspi.h
 
-- 
2.34.1

