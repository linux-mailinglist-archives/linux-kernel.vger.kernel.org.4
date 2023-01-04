Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B2465CBCF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 03:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbjADCNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 21:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbjADCNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 21:13:18 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2052.outbound.protection.outlook.com [40.107.15.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4D217E12;
        Tue,  3 Jan 2023 18:13:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MO4JSDEACfNs97UmSxHiDXXspW3vp39fI/Vf7w1fNGcP0DeDtyYHyYhLT+e34C8/T6WMUTASheKCsLKnpAjGDlGYdw13ejbmBS1ryzEVs707aYyiqiB7uqLQr40aDaiac5t/C9AA5yjpNTjZvaCeTLAR2TG6m4iQ2qkT+XX0LlkP02ET02EWxcZP41ko3nB3ez3dBQe4dqZo2XnsgCIKiSlnOA7Vxgvq4FMXEJi5mQz4QrG5LAOZ2o5aBKtm0bwh7pH75XcRkG2Enq03Xp6o914HS9Mt6s6UhagHBqvfjWeOL0hVlOVEKE1XxfSx8dy2mTrFqhQvw6kpaCJSY2OyAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGsyB5wbYFVuk+lj0VMLAh2CpUtODfNqCGYkn2RIqyg=;
 b=VvPF4CxAOOZpdVRghTnEReM6TRslaGFWW5TFcm86yufuqrK9EOxoEgjUaa18hnaYt42MZZ4FmZsGnt3zV+JPCzvXcODVZGpwyziO32W0ObYQUmfd6DVeg2jHhVrxrOtJT5mL7bnupN/ozU55RaMXYsx0wMnkXPjUkC7S/z35Ufa/PMFWpxiQ4yHnwzKLNWZN3QbbM4A30CeI1cm6NabRqzdliL3hqEKC9dD60t9mJo2CxhA8SJnCzSVnsCBihkhsU2wJ6r0+L6nznxs7TQwZH72dy+545+eJ/Zn+xmFHwKEfy9bSs2E8YWG86HD+dMU3o4+ogKnQFr2iiPoH+jSXMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGsyB5wbYFVuk+lj0VMLAh2CpUtODfNqCGYkn2RIqyg=;
 b=dI5NsRokiUIHX0C3AeWYNEVEqoTXaNBiVloj01flWBE4l46ficQhrDukeZwxMfHjlqQhxXIQwjK9TGYWkdV4ExRvG6PHzlFf5pW9Q/aKchF47lKT8uhv1DA4chSbv+Be1jW3rzBTjJczuI2jkYGjvuLJMtFAfxsKqDnsTifElEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9229.eurprd04.prod.outlook.com (2603:10a6:102:2bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 02:13:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b%7]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 02:13:11 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     aisheng.dong@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, ping.bai@nxp.com, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V2] dt-bindings: pinctrl: imx8m: Integrate duplicated i.MX 8M schemas
Date:   Wed,  4 Jan 2023 10:14:30 +0800
Message-Id: <20230104021430.3503497-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0061.apcprd02.prod.outlook.com
 (2603:1096:4:54::25) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: fc30f857-e702-46ae-733f-08daedf93a1e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/4K/gXxBJ4t68pPm2CRMPXTrVKtUHLcFAcnZ/3HpE4BUaTix/iZy5SVdoPvYeAuSDDnV1QQbZFBRnsfOs9IelAja2um4uYSdjazUoPYM07kyDoNmGIxeHV9tmGqG9UjP/gczu/K+IJXGPgsGHDoWg7OEwAk3M6LAXVeyCo73/EQG/jc+Y7depVvRtk47Ss5YgK00sxPZewuFNB1bBOeTtWdeIeq0Smn0Tgk5D4ckm/UG1Zsn+dAybnGZS4QWYIlzaUVz/RdJWx1Q/lakwypdwu6zaHk2bynjrFwH9ISSDIme7+ioN5ZDF4QyHkdBvh6YEnMi3pWqdZ/37OiNf6hxBQwX4eukro6cORFZaANmcaDG23pmgq3qZSQ985ij5SLFYQvAqUZ2Dh9PnvHeRNZk5iJC/I4OhRe86FL+mfBSxbEiZjb4FgHA52TCCpUwI3H5GIuYnv3HbKFzP1Nib53ECZPyQBCerqYh+naOyu/o0iLnswJenuPyPINQXDMgWxn2CbDCOVhfYy4gKXI/MiZzpRRtCWRmJ5w6Fv92STYs3lmO5RZ5o9zIM+sp7Uzjy6BgN8HPbor2JVkTjZMgdumiqhATKbtL/gdaoLz1GSGLY2SaSgOTlkJAGch5A+r7LYZZ426AwZFL2h6XkZmr7oZeEXIX9C1e7OKwxcokdC0OlhWxspDVyyRlqwXrkmE5v4k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199015)(86362001)(54906003)(316002)(478600001)(966005)(6486002)(52116002)(2906002)(7416002)(5660300002)(4326008)(8676002)(66946007)(66556008)(66476007)(8936002)(30864003)(41300700001)(6666004)(38350700002)(38100700002)(6506007)(186003)(26005)(6512007)(83380400001)(1076003)(2616005)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ws7iAnaR03lOvlzV8whdy9amiXN33oVhcBtP+o7u+J6BAmsg342qmToK8LkH?=
 =?us-ascii?Q?2vRRRYgsfGVXCRcj34ckrg/CtVxiBmdFQVLFA5Ihc8nACM0AnsPbzLjjCRzf?=
 =?us-ascii?Q?sVykbrBP0eLqk4DEc7PZ2+YmMkLDB8IaXOH+hQRVH5QQo1+E09l3HIJIAgaU?=
 =?us-ascii?Q?bwC2ogcqnKZotqIKzAeNIJICRenRRX++1lJcyO40k+oupfX4vM0jBCik/cED?=
 =?us-ascii?Q?BTYGwn/aGunXjj3R09ytLiMkCZSc8gXc99RG0O+3ec9o6t/XswphB4gdQrzG?=
 =?us-ascii?Q?L2iq6u9Xf+0vL3ctGWXB7u6hxfDyVRiBK8E5vHM69kGdif1Sh4DnXR2P4bc8?=
 =?us-ascii?Q?VxlFYueR1zEB0HpO2V3LQw5CE3Pn2fOAqYcSxkumBE4b7TCT5d5x6m22e4T6?=
 =?us-ascii?Q?7ZzjdGHdj2Y+Ct+XTwGRj019OIdcpgX85IgdY4+An3uKsQL9h0yjAdY7umN3?=
 =?us-ascii?Q?BaPofOGnQmSRCdOqV6TNiYbywz9+cMf8RhWUgWWlrm3GVRCwbjyCBw/8EmIO?=
 =?us-ascii?Q?vlYFTIkmQuV4b9CjRn97MVFDJ3QQ/xlH3rGI+0p8l8k6Ugrep5F0wFNtQCE4?=
 =?us-ascii?Q?EddVNfpIFoE72nihV5mhaW+rs9M3MhHh+AWeFFq+tljw0UUiB0oTgR1qxOji?=
 =?us-ascii?Q?u0yY0JPX8Q4bJIEcPQ86MtDaQPjuAJPz/yGykpPwqEGCpuEW5U8E2Ppe6u6b?=
 =?us-ascii?Q?wKN8ecBdql7uYESXiL/b6GMQtqMpsCM/0BtW1/tpjIybeXmJ/YrRNi27/9yz?=
 =?us-ascii?Q?6yiTTw19L6qxBLYZHus0jVsAM6CV36ZjF57SVyhWDBGDrEGrkM9GmMbP2GI6?=
 =?us-ascii?Q?tAONpbYmfTpUO5kIGv35cnOO4Ng+VWiZAkI/gA2IZ9r9nqKqfTny/SpL4ftm?=
 =?us-ascii?Q?pbE+n5df81aYBD+4xWoj45PeMBS3ZKhZ5wmVPG8XW5IwSyRjngmymzsV1DZ1?=
 =?us-ascii?Q?0GYZNTOWH556V5/Ta8WYO6XiqBmw05uoHivPoIC2aYrpuGUzuEr07s91pVOr?=
 =?us-ascii?Q?b7yePKBZW74qRMlwc6FuNbRU/KqC8Rqx//ZmqMJjYt8kjkdEcJ/9Jps80YKD?=
 =?us-ascii?Q?WucDYHdsYmaf8xIVtwzB+Ox2QIjpX5UpZsT+O+adoHQDA2Z+IMaUgw25CpQQ?=
 =?us-ascii?Q?srSFLACFcIp59Sno2i5+IY7oE9Wk6oahuBVLKLANwabCOqrG+HP6cvegt6o4?=
 =?us-ascii?Q?suTGBYoWvZ9LV5IETAyUqWW9v8qxbSrO1TM2Pqri5LGVK0KH/RhOAmfMnMxi?=
 =?us-ascii?Q?1VQ/jXLsJnk47bsj+3tqTb3C0hbwJhbRvt2zHTDzDo/60g8jxPjdOb4C5Ulp?=
 =?us-ascii?Q?VJHT0n8BMTc8OEhg0YEGWkkYa1obHWN2zTwC3UMTC592Mg6iS4hC6Uvdjy47?=
 =?us-ascii?Q?yp8cwpx6jCQtGYbJJNUORqRYzhxTeuFtiQDbWiNu+UmL2Bytcbwo7faKZ+RG?=
 =?us-ascii?Q?5n/CD/TXMdje3f0LVcnH8ghmblngaF6ZUCZWi85BIwJXt6k4YJNaizofSDgo?=
 =?us-ascii?Q?43pM/7lUB9s4uUBhxBKajDLL3gPyB7HngfogX1YwqUkU85/kIrG/NzwFl+f4?=
 =?us-ascii?Q?3qd7oiw+rdTFo3Rme1PmAGK1xi7mGntGJ50Cj4jW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc30f857-e702-46ae-733f-08daedf93a1e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 02:13:11.0154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tr8AS5hgqUlF3fgG7Kub4rQG8vYCQbeljGI5CcvVKW4SSUZndIsfOyYON0ujyeJZnmv5p99GZdgvRHMu54hzYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9229
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The i.MX8MM/N/P/Q IOMUXC schemas are basically the same, it does not to
have four schemas for almost the same binding.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---

V2:
 Drop extra space, limit to 80 chars per line.
 Sort alphabetically
 Update License
 Add A-b from Rob

 ...mm-pinctrl.yaml => fsl,imx8m-pinctrl.yaml} | 24 ++++--
 .../bindings/pinctrl/fsl,imx8mn-pinctrl.yaml  | 84 -------------------
 .../bindings/pinctrl/fsl,imx8mp-pinctrl.yaml  | 84 -------------------
 .../bindings/pinctrl/fsl,imx8mq-pinctrl.yaml  | 84 -------------------
 4 files changed, 15 insertions(+), 261 deletions(-)
 rename Documentation/devicetree/bindings/pinctrl/{fsl,imx8mm-pinctrl.yaml => fsl,imx8m-pinctrl.yaml} (76%)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx8mn-pinctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-pinctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imx8m-pinctrl.yaml
similarity index 76%
rename from Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.yaml
rename to Documentation/devicetree/bindings/pinctrl/fsl,imx8m-pinctrl.yaml
index 6717f163390b..7ae084397258 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx8m-pinctrl.yaml
@@ -1,13 +1,13 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/pinctrl/fsl,imx8mm-pinctrl.yaml#
+$id: http://devicetree.org/schemas/pinctrl/fsl,imx8m-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Freescale IMX8MM IOMUX Controller
+title: Freescale IMX8M IOMUX Controller
 
 maintainers:
-  - Anson Huang <Anson.Huang@nxp.com>
+  - Peng Fan <peng.fan@nxp.com>
 
 description:
   Please refer to fsl,imx-pinctrl.txt and pinctrl-bindings.txt in this directory
@@ -15,7 +15,11 @@ description:
 
 properties:
   compatible:
-    const: fsl,imx8mm-iomuxc
+    enum:
+      - fsl,imx8mm-iomuxc
+      - fsl,imx8mn-iomuxc
+      - fsl,imx8mp-iomuxc
+      - fsl,imx8mq-iomuxc
 
   reg:
     maxItems: 1
@@ -34,9 +38,10 @@ patternProperties:
           each entry consists of 6 integers and represents the mux and config
           setting for one pin. The first 5 integers <mux_reg conf_reg input_reg
           mux_val input_val> are specified using a PIN_FUNC_ID macro, which can
-          be found in <arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h>. The last
-          integer CONFIG is the pad setting value like pull-up on this pin. Please
-          refer to i.MX8M Mini Reference Manual for detailed CONFIG settings.
+          be found in <arch/arm64/boot/dts/freescale/imx8m[m,n,p,q]-pinfunc.h>.
+          The last integer CONFIG is the pad setting value like pull-up on this
+          pin. Please refer to i.MX8M Mini/Nano/Plus/Quad Reference Manual for
+          detailed CONFIG settings.
         $ref: /schemas/types.yaml#/definitions/uint32-matrix
         items:
           items:
@@ -51,7 +56,8 @@ patternProperties:
             - description: |
                 "input_val" indicates the select input value to be applied.
             - description: |
-                "pad_setting" indicates the pad configuration value to be applied.
+                "pad_setting" indicates the pad configuration value to be
+                applied.
 
     required:
       - fsl,pins
diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mn-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mn-pinctrl.yaml
deleted file mode 100644
index b1cdbb56d4e4..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mn-pinctrl.yaml
+++ /dev/null
@@ -1,84 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/pinctrl/fsl,imx8mn-pinctrl.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Freescale IMX8MN IOMUX Controller
-
-maintainers:
-  - Anson Huang <Anson.Huang@nxp.com>
-
-description:
-  Please refer to fsl,imx-pinctrl.txt and pinctrl-bindings.txt in this directory
-  for common binding part and usage.
-
-properties:
-  compatible:
-    const: fsl,imx8mn-iomuxc
-
-  reg:
-    maxItems: 1
-
-# Client device subnode's properties
-patternProperties:
-  'grp$':
-    type: object
-    description:
-      Pinctrl node's client devices use subnodes for desired pin configuration.
-      Client device subnodes use below standard properties.
-
-    properties:
-      fsl,pins:
-        description:
-          each entry consists of 6 integers and represents the mux and config
-          setting for one pin. The first 5 integers <mux_reg conf_reg input_reg
-          mux_val input_val> are specified using a PIN_FUNC_ID macro, which can
-          be found in <arch/arm64/boot/dts/freescale/imx8mn-pinfunc.h>. The last
-          integer CONFIG is the pad setting value like pull-up on this pin. Please
-          refer to i.MX8M Nano Reference Manual for detailed CONFIG settings.
-        $ref: /schemas/types.yaml#/definitions/uint32-matrix
-        items:
-          items:
-            - description: |
-                "mux_reg" indicates the offset of mux register.
-            - description: |
-                "conf_reg" indicates the offset of pad configuration register.
-            - description: |
-                "input_reg" indicates the offset of select input register.
-            - description: |
-                "mux_val" indicates the mux value to be applied.
-            - description: |
-                "input_val" indicates the select input value to be applied.
-            - description: |
-                "pad_setting" indicates the pad configuration value to be applied.
-
-    required:
-      - fsl,pins
-
-    additionalProperties: false
-
-allOf:
-  - $ref: "pinctrl.yaml#"
-
-required:
-  - compatible
-  - reg
-
-additionalProperties: false
-
-examples:
-  # Pinmux controller node
-  - |
-    iomuxc: pinctrl@30330000 {
-        compatible = "fsl,imx8mn-iomuxc";
-        reg = <0x30330000 0x10000>;
-
-        pinctrl_uart2: uart2grp {
-            fsl,pins =
-                <0x23C 0x4A4 0x4FC 0x0 0x0	0x140>,
-                <0x240 0x4A8 0x000 0x0 0x0	0x140>;
-        };
-    };
-
-...
diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-pinctrl.yaml
deleted file mode 100644
index 4eed3a4e153a..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-pinctrl.yaml
+++ /dev/null
@@ -1,84 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/pinctrl/fsl,imx8mp-pinctrl.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Freescale IMX8MP IOMUX Controller
-
-maintainers:
-  - Anson Huang <Anson.Huang@nxp.com>
-
-description:
-  Please refer to fsl,imx-pinctrl.txt and pinctrl-bindings.txt in this directory
-  for common binding part and usage.
-
-properties:
-  compatible:
-    const: fsl,imx8mp-iomuxc
-
-  reg:
-    maxItems: 1
-
-# Client device subnode's properties
-patternProperties:
-  'grp$':
-    type: object
-    description:
-      Pinctrl node's client devices use subnodes for desired pin configuration.
-      Client device subnodes use below standard properties.
-
-    properties:
-      fsl,pins:
-        description:
-          each entry consists of 6 integers and represents the mux and config
-          setting for one pin. The first 5 integers <mux_reg conf_reg input_reg
-          mux_val input_val> are specified using a PIN_FUNC_ID macro, which can
-          be found in <arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h>. The last
-          integer CONFIG is the pad setting value like pull-up on this pin. Please
-          refer to i.MX8M Plus Reference Manual for detailed CONFIG settings.
-        $ref: /schemas/types.yaml#/definitions/uint32-matrix
-        items:
-          items:
-            - description: |
-                "mux_reg" indicates the offset of mux register.
-            - description: |
-                "conf_reg" indicates the offset of pad configuration register.
-            - description: |
-                "input_reg" indicates the offset of select input register.
-            - description: |
-                "mux_val" indicates the mux value to be applied.
-            - description: |
-                "input_val" indicates the select input value to be applied.
-            - description: |
-                "pad_setting" indicates the pad configuration value to be applied.
-
-    required:
-      - fsl,pins
-
-    additionalProperties: false
-
-allOf:
-  - $ref: "pinctrl.yaml#"
-
-required:
-  - compatible
-  - reg
-
-additionalProperties: false
-
-examples:
-  # Pinmux controller node
-  - |
-    iomuxc: pinctrl@30330000 {
-        compatible = "fsl,imx8mp-iomuxc";
-        reg = <0x30330000 0x10000>;
-
-        pinctrl_uart2: uart2grp {
-            fsl,pins =
-                <0x228 0x488 0x5F0 0x0 0x6	0x49>,
-                <0x228 0x488 0x000 0x0 0x0	0x49>;
-        };
-    };
-
-...
diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.yaml
deleted file mode 100644
index d4a8ea5551a5..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.yaml
+++ /dev/null
@@ -1,84 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/pinctrl/fsl,imx8mq-pinctrl.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Freescale IMX8MQ IOMUX Controller
-
-maintainers:
-  - Anson Huang <Anson.Huang@nxp.com>
-
-description:
-  Please refer to fsl,imx-pinctrl.txt and pinctrl-bindings.txt in this directory
-  for common binding part and usage.
-
-properties:
-  compatible:
-    const: fsl,imx8mq-iomuxc
-
-  reg:
-    maxItems: 1
-
-# Client device subnode's properties
-patternProperties:
-  'grp$':
-    type: object
-    description:
-      Pinctrl node's client devices use subnodes for desired pin configuration.
-      Client device subnodes use below standard properties.
-
-    properties:
-      fsl,pins:
-        description:
-          each entry consists of 6 integers and represents the mux and config
-          setting for one pin. The first 5 integers <mux_reg conf_reg input_reg
-          mux_val input_val> are specified using a PIN_FUNC_ID macro, which can
-          be found in <arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h>. The last
-          integer CONFIG is the pad setting value like pull-up on this pin. Please
-          refer to i.MX8M Quad Reference Manual for detailed CONFIG settings.
-        $ref: /schemas/types.yaml#/definitions/uint32-matrix
-        items:
-          items:
-            - description: |
-                "mux_reg" indicates the offset of mux register.
-            - description: |
-                "conf_reg" indicates the offset of pad configuration register.
-            - description: |
-                "input_reg" indicates the offset of select input register.
-            - description: |
-                "mux_val" indicates the mux value to be applied.
-            - description: |
-                "input_val" indicates the select input value to be applied.
-            - description: |
-                "pad_setting" indicates the pad configuration value to be applied.
-
-    required:
-      - fsl,pins
-
-    additionalProperties: false
-
-allOf:
-  - $ref: "pinctrl.yaml#"
-
-required:
-  - compatible
-  - reg
-
-additionalProperties: false
-
-examples:
-  # Pinmux controller node
-  - |
-    iomuxc: pinctrl@30330000 {
-        compatible = "fsl,imx8mq-iomuxc";
-        reg = <0x30330000 0x10000>;
-
-        pinctrl_uart1: uart1grp {
-            fsl,pins =
-                <0x234 0x49C 0x4F4 0x0 0x0	0x49>,
-                <0x238 0x4A0 0x4F4 0x0 0x0	0x49>;
-        };
-    };
-
-...
-- 
2.37.1

