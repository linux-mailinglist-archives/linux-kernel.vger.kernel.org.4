Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85ABA6BDAEF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 22:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjCPV1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 17:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjCPV1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 17:27:40 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2045.outbound.protection.outlook.com [40.107.15.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4024E4843;
        Thu, 16 Mar 2023 14:27:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsfBinqAlZ7NawIQien9lGTDmgxdKXsU9TjVs86S57GvXewOQNvXRsuKoUzQRRugtIWisRwYTXjVBzFAhBlIqY83fFgeA1VdSqpt04okZzf2HEcyKAJRXktsFw1S7eOgOhO3sTqlO/tWeESDLHiWsLqEKn8mzdqTejH0M9Do4krSzsX+fg4YALZm30TwhJq4ANDWuzIEuI5BvgSuduUAxUH3NRK5ZklUZmYXaxAXO/RVEpEdGcEsZAHCivx+cbCESR6Pc6JgtcZ7pkR3JBi3Ga2IBysR48IhVms45LU91VJMfg7Uw1b7f/OZHCue+SYn49XcxNwVylc6QAtaupazug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFf39BcNOiXEhr+wtmDf26hk+HdCfvJxHhh0q1gmlAg=;
 b=Ooa1K41noiX6sB6MblfGOEe4th8wIbDR7yBfIK1N7K3HdFAEv3x9XLDVFak1JbVYH7nOJT2jFqP8VQdCXqFw6ZoqNP75jTzJzA/v7lGC8/eSB3Gy236sePLw10xDcp1Mu7RxGwlHM7JYeFDgZCjjgYpqDC7NQoNkQm2OvSMaNw0ppXJ6rrkfmLM4A8liY/ixDxUtCx1AOJzFZSYfeHv1gwp4bFhXuueVFyAnSVJFuN4mAsB0qvRJj8Vzr8paBxq3iAqSB2aORmsxsf5yhHXuHxqmarQMNx0N6u8PJKqYi+XkZ+BnY9fsPV8Ti53TSvhMfrzLgLDjOIMQ8IzqjcfS3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFf39BcNOiXEhr+wtmDf26hk+HdCfvJxHhh0q1gmlAg=;
 b=GHWNsX3nsLNS8SgNKdhd6x/hAvzSwq7MiW2+FdybBM5RnsB5mMHI2ynPlpOSje7ltXrEWaBegCUzwka/EcNURsc852yxlNVZPAQ4uhosTaBh2lmJJaopm331CgJr1q8hJmf0C+4YAg4IsqedmlfTLQEEV5CMXJU/V508Nrn2GEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7614.eurprd04.prod.outlook.com (2603:10a6:102:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Thu, 16 Mar
 2023 21:27:33 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.029; Thu, 16 Mar 2023
 21:27:33 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     shawnguo@kernel.org
Cc:     Frank.Li@nxp.com, devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Subject: [PATCH v2 1/3] dt-bindings: usb: cdns-imx8qm: add imx8qm cdns3 glue bindings
Date:   Thu, 16 Mar 2023 17:27:09 -0400
Message-Id: <20230316212712.2426542-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230316212712.2426542-1-Frank.Li@nxp.com>
References: <20230316212712.2426542-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::10) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: 80de4249-2fd3-440e-0cac-08db26654164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P2/fodr4UZPSWQIFidS7ZM0KvlL9t56jbx3pPiQkIdnnaQMr7GwhcgRwomaBkuW4Kn45PLFs8gouGzCf4Mh2sICx9XBArw0aj10YIUg0aQzZpizAHh6eu+Bjvi/gyZeeqJk2Nz/s4TSv9yrd02nqmcverPa04xtqStKj42tYSKtCICKfxruXw4pekJraxSpOImr6ZuJ2zB9o3NlafXkXfLy8KqanqOKV+EmyICccv+6hKD0IWqs92UKNyhArNFO3RarDv03lg+5Q3vj/bkB1cAOoUmaic4UptAEp2FIezq0qYDHbxb0KPtWmDu9aDRNjPC3nBMjacGNGie96hJf3WSf5/HucQHqJXaT7JdaihVVjptNH4a3W9T/54UF+v/EC/pvYuwa0HB5sR84D3WPwJepulSdUQR82tgKBz9dKRZhWDwanbdfryLN1uK56VXKYzYD4prdMVjsbDXYSlBeAWHM2Hz8/r7zGJidCbuijF+c/j/Omb5E/HUBrPQN7ABvjY6lDwoQuodKAfo3PueKwELAMMIzQWEuHr9buEBWQ+0UOswi50uDjUbh5cm2yUfHgfWGDZsGMnyAZVwrnjpclGKM6Xf6YkxiV117W5aJrXi3Jtj3+fNauT1+28vgdR4/OOjZO5xSWRli/3lsUIebiqrvXJJpM7qDcMbhk3z4aSihHl3teRfx/9bzTwzqnR0flQD1FLLBbEBsKllgwBUPDdemGhJDTfBzBHHiX422gPrv4WDtIExEql7fQ+2QD8lSE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199018)(316002)(38350700002)(38100700002)(2906002)(478600001)(36756003)(8936002)(5660300002)(41300700001)(66946007)(66556008)(66476007)(8676002)(6916009)(4326008)(7416002)(83380400001)(86362001)(186003)(52116002)(26005)(1076003)(6506007)(6512007)(2616005)(6666004)(966005)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LaD9o0IhSTyH00SJktWuQ+HX0B8frWdvU1NlXwI5Ix+eYQ0mKCUPn4QaKfoi?=
 =?us-ascii?Q?SiLea97tvIOxpi39UloOv/pawoyOndGNHgDAXzvtV0DfLp3JOW2Xm2pCzWi1?=
 =?us-ascii?Q?OLAQ7sCWcG8ZQ1GkdfrlQkWaHV5nWvpC3JJU1rZJnpvrRV3viwXq4qU30I4D?=
 =?us-ascii?Q?tRyHK00f0X2MojH6lNo5FFcPGYYFOOOKVGsAgwM6xN/klVtMFYY5WMrtu1zG?=
 =?us-ascii?Q?bpN7RiPPXLkolGzq1UIQ3czV1XMVyzo+pe+Pj7zk7f9WcZtLGD8QEKYxdR9f?=
 =?us-ascii?Q?+IlmBJV71X6R+72MpESQ8tadb2a5ebLD0rBDINDgZr3bAuujnLdXpZb6n+Qc?=
 =?us-ascii?Q?c3fIlbMBHCC8RD04h6skFjAHzp/DYHhz8gnYy1cxm5f9FlROlaIiucKX6Qxs?=
 =?us-ascii?Q?oS0gD9OBiPCfm3h2tPVGHybbAeaxPFKDTpY0pU8esfVrqHVSg1hDcDzHz4uO?=
 =?us-ascii?Q?RQxrymwNz2Na9utD6MhMSYHiCB88CSHNBfFhlxbBopg2qKWGCX49HGkUcYAY?=
 =?us-ascii?Q?br++jx2gJJy+vakFj/g2v5NHME5djYhGpMWaoaCy4ibmnWC1Wth83LI/tayF?=
 =?us-ascii?Q?38j2nU+1P8upApmRG+5w8tGeD4JsVHkr3Nn1OA8rc9vfXlAUecJnaJhvnA8X?=
 =?us-ascii?Q?V+E9M0ryII1kflXKE1ViLoHSsxuXwKYdWmlzFlBuyEafgKkc2dsWbDjFuFjj?=
 =?us-ascii?Q?Za4Hbaet74sUZgilJ6mHXrZOgE9qwWLwsjAT/wmfIH/SYSPuOZvXqODquyhx?=
 =?us-ascii?Q?Dar3L7XcAWrAxX0tpl9f+rrqTzfnpyf9cmsr/hSauifIp0yBc9ZK2zAyTTSZ?=
 =?us-ascii?Q?Gn2guN0lI1nmUxOoTTda47O+40kOCOBMDBgu6rmQmvlEAzArmYrb6nJ28/ua?=
 =?us-ascii?Q?k4pbX9RGmjj66RFuvAXRAAlnaTv6wecd1cqoOjrB5LK1qjmti5jjHlG8Apps?=
 =?us-ascii?Q?JKg4Rc36Ktgm85Cabow1R+P9n+AUubA9aPJT5Lm8dT6dDijAKNQYLX6daycq?=
 =?us-ascii?Q?uJvYu8TUAwUP55dRPcTU10L7qHd/UMSnKzWKN7eRAOe/pAwTFlBrAAnNre6U?=
 =?us-ascii?Q?h1ZlpOgom9B5gvqPlPxl5bwSnlX/7HRpBNcgg5x6/qG9eH1xMnHwXldJO8kr?=
 =?us-ascii?Q?2k0ePJjhom0iViddycRjD5JQC2TnfUmtEy8gQBYQW+5LYllrTOj2DgzMIbIt?=
 =?us-ascii?Q?N1cKW8YT7pqf7vabstUNFL0f8HJf/sOOtl3qcdnIOYv/a5kTpNOZc5rxluRw?=
 =?us-ascii?Q?g8m314YDDAiIhffOFj0B7S074b0NOYWdvNQo3yQXr1BtgzfkSVFknqhqpeyB?=
 =?us-ascii?Q?Km5z0L+ZRkhO7FTfsa6oTACfnGLnwvfu0PTUV4qKu5BEO28ap6x7o1HDU8Mr?=
 =?us-ascii?Q?4UK3QSupalDBe/z4Z8KMr0kRtVEfdhwbAJ/E/vww4NC6pMUzbnDmJcziikkg?=
 =?us-ascii?Q?1F3LIXUzV2T16ksnmPr/QpYOVH74VNjtNYis5yExlXlYESdHMJNPZCWJW6oO?=
 =?us-ascii?Q?zW9JjTCZQJ69RjhwJ6hQM7fpxm28ksiAjpJ5T5Zf9pgHHLrtVyGFD2gYcisf?=
 =?us-ascii?Q?hFOx/TINTStaBT6JzK7ihUfNiEgOQ+S7CCbhQnRw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80de4249-2fd3-440e-0cac-08db26654164
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 21:27:33.5247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChhoOKnV4QFyDv9RzPyP8aqdOfJHpVzCd6zMlWWQFSWNyk2iIUe6gu/Og6jXaAkPB1WdTQu7PsknMrsNTaagbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7614
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NXP imx8qm integrates 1 cdns3 IP. This is glue layer device bindings.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/usb/fsl,imx8qm-cdns3.yaml        | 122 ++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml

diff --git a/Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml b/Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml
new file mode 100644
index 000000000000..fc24df1e4483
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2020 NXP
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/fsl,imx8qm-cdns3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP iMX8QM Soc USB Controller
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    const: fsl,imx8qm-usb3
+
+  reg:
+    items:
+      - description: Address and length of the register set for iMX USB3 Platform Control
+
+  "#address-cells":
+    enum: [ 1, 2 ]
+
+  "#size-cells":
+    enum: [ 1, 2 ]
+
+  ranges: true
+
+  clocks:
+    description:
+      A list of phandle and clock-specifier pairs for the clocks
+      listed in clock-names.
+    items:
+      - description: Standby clock. Used during ultra low power states.
+      - description: USB bus clock for usb3 controller.
+      - description: AXI clock for AXI interface.
+      - description: ipg clock for register access.
+      - description: Core clock for usb3 controller.
+
+  clock-names:
+    items:
+      - const: usb3_lpm_clk
+      - const: usb3_bus_clk
+      - const: usb3_aclk
+      - const: usb3_ipg_clk
+      - const: usb3_core_pclk
+
+  assigned-clocks:
+    items:
+      - description: Phandle and clock specifier of IMX_SC_PM_CLK_PER.
+      - description: Phandle and clock specifoer of IMX_SC_PM_CLK_MISC.
+      - description: Phandle and clock specifoer of IMX_SC_PM_CLK_MST_BUS.
+
+  assigned-clock-rates:
+    items:
+      - description: Must be 125 Mhz.
+      - description: Must be 12 Mhz.
+      - description: Must be 250 Mhz.
+
+  power-domains:
+    maxItems: 1
+
+# Required child node:
+
+patternProperties:
+  "^usb@[0-9a-f]+$":
+    $ref: cdns,usb3.yaml#
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+  - clocks
+  - clock-names
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8-lpcg.h>
+    #include <dt-bindings/firmware/imx/rsrc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    usbotg3: usb@5b110000 {
+      compatible = "fsl,imx8qm-usb3";
+      ranges;
+      reg = <0x5b110000 0x10000>;
+      clocks = <&usb3_lpcg IMX_LPCG_CLK_1>,
+               <&usb3_lpcg IMX_LPCG_CLK_0>,
+               <&usb3_lpcg IMX_LPCG_CLK_7>,
+               <&usb3_lpcg IMX_LPCG_CLK_4>,
+               <&usb3_lpcg IMX_LPCG_CLK_5>;
+      clock-names = "usb3_lpm_clk", "usb3_bus_clk", "usb3_aclk",
+                    "usb3_ipg_clk", "usb3_core_pclk";
+      assigned-clocks = <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_PER>,
+                        <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MISC>,
+                        <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MST_BUS>;
+      assigned-clock-rates = <125000000>, <12000000>, <250000000>;
+      power-domains = <&pd IMX_SC_R_USB_2>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      status = "disabled";
+
+      usbotg3_cdns3: usb@5b120000 {
+          compatible = "cdns,usb3";
+          interrupt-parent = <&gic>;
+          interrupts = <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>;
+          interrupt-names = "host", "peripheral", "otg", "wakeup";
+          reg = <0x5b120000 0x10000>,   /* memory area for OTG/DRD registers */
+                <0x5b130000 0x10000>,   /* memory area for HOST registers */
+                <0x5b140000 0x10000>;   /* memory area for DEVICE registers */
+          reg-names = "otg", "xhci", "dev";
+          phys = <&usb3_phy>;
+          phy-names = "cdns3,usb3-phy";
+      };
+    };
-- 
2.34.1

