Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352096C6D9F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjCWQcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjCWQcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:32:15 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2065.outbound.protection.outlook.com [40.107.241.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812172BF30;
        Thu, 23 Mar 2023 09:31:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdIuj+miyP0OJLWWv/fuRFzZFGRDSfu+zroDWJVwWOb3vhZyTxbpDxy/uX0blk5h9jwJDnUXULZf4loTArgCkzBpitJfgCGX/VDtsx/zL3aOYqVb2bfkFeFRBcSd3Af9VT0IxHKdx2SNIDjSVxcsb47giEDDZSs5DNFwzThTzGkS/UEcAoYLqnRmWP3KkT0wtSJcOsQNx9FZ0RqXcWhJ9G/jg/NM+hKboU6qkhJln3/ohyqo7PCsQy5mpURwahhgQT8d0DUIW4NtdZZv50Oei3zseVaqcsuCNma4CxEk0R80T3Fb4+7+aI+Xa8UdJMdNi2Gy6xJG/d9/YnZr0tp1oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imyL9eI4USOvMnCSNQy4LXZHc/gO/oM4PLGeoov/Gzo=;
 b=QfxvJuHpeaJXJQUqF8eqbNHUzle7wJ3E85PJdBvQoaldSBINFUwVL/pp0t19AkztAdOXbVQAVMcM9lwbXMsmil4bMv5cd3E7ql7SUmDCv2FM1/7Xf6ubzVkD6CNr7vZtU8wQrXmvfz2m2z6zVjWP17PGy6sK6wfuixr+CSlgHom3HYgzn1luOjcD27eGFkEsBN/6GDaKlxGDXM8WuAEoAv+jNw7bRWb8i4vrk84iOqKcuSREUHqOsi8uQ/LOSVTVUN/9dY46NIyhXeYao7ZN9oUKueQ3csGMSeiKr7IEbu1pEKuYbkBvWVdMjOXCqjPp1MfTQavbaUa0LPQglf7Y0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imyL9eI4USOvMnCSNQy4LXZHc/gO/oM4PLGeoov/Gzo=;
 b=nZY0QHQ4z/qCZ36+osLq94L7LQ6237BhSOXjRSgOxQLDuuAZKPHhsuAisce8wwWeJ418/D4WtNnPR3WvNxkhxE7OzvPv5pEHuUSDk7mv6yd3syNAZphZ9cpzveXHnEY6b37NaQzNmgpDafX4vRUKgNmJgIVIPTlm46rwVYi9IQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7789.eurprd04.prod.outlook.com (2603:10a6:102:c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 16:31:40 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 16:31:40 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v4 1/3] dt-bindings: usb: cdns-imx8qm: add imx8qm cdns3 glue layer
Date:   Thu, 23 Mar 2023 12:31:14 -0400
Message-Id: <20230323163116.2921999-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323163116.2921999-1-Frank.Li@nxp.com>
References: <20230323163116.2921999-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::17) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: fe4095fd-63c3-4ba8-8a03-08db2bbc145a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SWb5RR3LoBeYd1eGnFzc+K8gsdLpBmuFSczHiibnATWXfs73rmE+wsS3PIlC5EAOcjlLDIwiZ1Q0oNfEhRPJsDYKeEPb0a3/XpP2tB6rJ1qUw+1KNhzc1p1Ic+IL/DhTF/IzPJRx3piEvUVZt5E4lRz2A8yatbfw4+4frUUWHa8NYZo5EK+cene93pve2WvPdnuV4mCCU4aLYCDVwccefxdGCVB3a0fn4Vvoqj9Au2o8bH4koVdFN6AUCLT0RTYVUoHrNLut3iZ34+90MI2LFEUSWsFG1JKooySMpjHXvkyXAViN5sf5nCDTCal0LVmfqdzzZbj4jWjNpEG9bFFjKirk0IFTDYvsgGsLRbfGA6KceyIg9TGG2F/VSe0n4uVqFbRs7uwD4dwCBy/AFA6I+pneAp7VCveiXcpoWGSC0HD2EJUXQdgM8zD7OCy13XVD8SjGVwlrwuyh1oNs/jMZNtNWFEwj9nckCuXVTkbDPjO/Q/1m03KvLsFWbUEMPQxt0MMsbI0036e2RpeREGbmXppEVzvL8Ip4d7Y6nxpCWLF49VuHAxhz8FUZsY1OdSXoMddbg+kqwTUrszuX9sc7ohlApURwOzQw/UfBhDmNhhGOTut/FaaY5pZ79oF3gqW2nCuoOkXMz0ifZu6JaKILsUMRmXqfR5J1f17ZsLqogwaG9FfP0ZpKs25OpNDY3zcTHfqIzEG8YcbOz7fgKbPzR9XoSa14fjCLedIISnCd3pmEWao8OYZZsOipzlNgNpmF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199018)(38350700002)(8936002)(34206002)(66946007)(66476007)(66556008)(41300700001)(4326008)(86362001)(8676002)(36756003)(38100700002)(6512007)(6506007)(1076003)(26005)(2616005)(83380400001)(186003)(6666004)(52116002)(316002)(478600001)(6486002)(966005)(37006003)(2906002)(5660300002)(7416002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JyWFjRDZZ5XwFAHGP4DxJE0bVXN0bFeu8DVJX0ggjz6wvpPkrGoQCK2vj4FH?=
 =?us-ascii?Q?r0Yjlm2kSda98G8IGJ2lkUl0TDBjGYD+4G9s1bIPtYdb+HamuA7eKyPvfGRb?=
 =?us-ascii?Q?gFqGV27Vwhwt6+Ze9D7jbqe54CyP+5xmTwp51nhCeMeTBGGiHGerXuMG2rcx?=
 =?us-ascii?Q?nWIGkm+PFHKd5T4uWd/fLtshmWbLP2TbdNhsf9kxPYETQKntEy5yZN6sqNA8?=
 =?us-ascii?Q?W5YKdYivJ4Wmc3CrN+g5eJhoMLYpOz6l6tNZWtgjx2OKdss9csWNg80ODLIb?=
 =?us-ascii?Q?dpc+PLId55wHne+Wp9Ae3VCvCenNiWhTCQ3iHyZkPeUqR/hlAMsNV96sAPuZ?=
 =?us-ascii?Q?QeEQj9v+KVDQlRomiIbodM5jsUAA12M16VhhIcp0bVRLPBSHsVL8sr/Rn1zU?=
 =?us-ascii?Q?mFwrqiV/eTadCmhqI/ZEoHZ/tL/KD/Rt7wlUIHO4va9ZjmF7PQsHpiiZ3n+f?=
 =?us-ascii?Q?IvFm1zlWStMlDFo+KyiTKYjL6nlO6ejnGRq0ycKzhq4pBfhU/1x/RrRSLWLC?=
 =?us-ascii?Q?L0J5+OWd7WtpM6jAWp4P/5tmWGDmGjFLdMf9o3pA+a3nuKoENahT4kE920Yf?=
 =?us-ascii?Q?eMMA2pSqKJSVaDUOw4TiWnMpJxyUNZg6EqMw+4KhvtgKIABYd9sIzLstEEWB?=
 =?us-ascii?Q?1/4QHWN/ZIMgLpMn8POqOT63LcPmFeEIOP4BUwe55qgAd5tsO0XC9SnOovBV?=
 =?us-ascii?Q?ArpUmNoVl7VQDNdCKymvagBqytgXtFDsz/5KAVEqjJqimYuXpxtiNqXe0mse?=
 =?us-ascii?Q?zRaMtM0CF6QBny/pMi8vII5XhQLuJW06pITxKsjZ5DHP9z6qJK8b6aRAT9sz?=
 =?us-ascii?Q?ge/iFLm5WJnBL68ejFjPiqoj1GoEopcKxJSgGyXA9H12EsfmgMFRXijYTkbH?=
 =?us-ascii?Q?Kmvgk8qa3f5h7rmGLQg1ncUbyrPrHKFfn2dUe/GDU6wI79C0k35cOmJdL2Us?=
 =?us-ascii?Q?X8eqVtCP49K2FCgXBB2N1+ndNijZV8INBnKnCOKQ7a4G51sRF7XzWpGIZBrD?=
 =?us-ascii?Q?kQEW1euP2BoQxCbIMlnHryuwdz/x4hQrNHyiji+jYeOQW9RhwzkQXjxTJpj4?=
 =?us-ascii?Q?6etKnYrpUymoiHyP8U7zsbcMpFWCrPul+nZ51Ulo6LVuL2MUlFzdwS+RcXR6?=
 =?us-ascii?Q?/Ztewq2qf1suXkWvJnzzW4yGXpM1qy5CDU5zrcrYSFEvm925/2Hp/W5KxnIX?=
 =?us-ascii?Q?bQEac6wGqRC6X1t54Q+HB3JhAdWxmhfJITNyO2OgSIw8BwpQAFPdN3kZBAUG?=
 =?us-ascii?Q?j08KAf0OVQ2rWzXIY8m77PMQpI4Qms/kXoQk9yPP134G9c+z3rjhYI4db6Az?=
 =?us-ascii?Q?qf0pfKgQRGKsq8XMyiSMF4njLvkZTgvhbJodajPtuocdDTMMxzo50Es3DBxc?=
 =?us-ascii?Q?RZjApPFSx/T2ZsBLeC7M64zcLQDkClgf7sx1TLpDWJnMv90PTDqyYmYeU2ed?=
 =?us-ascii?Q?DnbB6RFuB2aplzXAeC0RubL6NGAEugM9obxwRVZbd8zNTJIJuvpVqgtYrIcu?=
 =?us-ascii?Q?2uTqIZNKknGS6PlIlkSWqgdUaU5p6hL81bobku+gpWgb7XqY6GkjKgIKdR9q?=
 =?us-ascii?Q?nSRCYdKByDJN7OIQvgfLpBgerl1wZVb+j26Wzely?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4095fd-63c3-4ba8-8a03-08db2bbc145a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 16:31:39.9943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NvAtYQ57yMR59a+LVSb8mRl/TBZwHJ8TWi6qHVHush6mkmGA0gDQ8MJM5cHN9XrYOnLWoxOUWFTkgyle6IQ/Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7789
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NXP imx8qm integrates 1 cdns3 IP. This is glue layer device bindings.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v4
- Drop all clock-assign

Change from v2 to v3
- Drop two fixed frequency clocks, it is system reset value, no need set now.
If need, futher work/discuss on driver or dts change. It will not block this
basic enablement work.
- Drop lable
- Drop some descriptions
- Reg as second property.

Change from v1 to v2.
- new add binding doc

 .../bindings/usb/fsl,imx8qm-cdns3.yaml        | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml

diff --git a/Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml b/Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml
new file mode 100644
index 000000000000..654d8704aa6f
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml
@@ -0,0 +1,104 @@
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
+      - description: Register set for iMX USB3 Platform Control
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
+    usb@5b110000 {
+      compatible = "fsl,imx8qm-usb3";
+      reg = <0x5b110000 0x10000>;
+      ranges;
+      clocks = <&usb3_lpcg IMX_LPCG_CLK_1>,
+               <&usb3_lpcg IMX_LPCG_CLK_0>,
+               <&usb3_lpcg IMX_LPCG_CLK_7>,
+               <&usb3_lpcg IMX_LPCG_CLK_4>,
+               <&usb3_lpcg IMX_LPCG_CLK_5>;
+      clock-names = "usb3_lpm_clk", "usb3_bus_clk", "usb3_aclk",
+                    "usb3_ipg_clk", "usb3_core_pclk";
+      assigned-clocks = <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MST_BUS>;
+      assigned-clock-rates = <250000000>;
+      power-domains = <&pd IMX_SC_R_USB_2>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      usb@5b120000 {
+        compatible = "cdns,usb3";
+        reg = <0x5b120000 0x10000>,   /* memory area for OTG/DRD registers */
+              <0x5b130000 0x10000>,   /* memory area for HOST registers */
+              <0x5b140000 0x10000>;   /* memory area for DEVICE registers */
+        reg-names = "otg", "xhci", "dev";
+        interrupt-parent = <&gic>;
+        interrupts = <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "host", "peripheral", "otg", "wakeup";
+        phys = <&usb3_phy>;
+        phy-names = "cdns3,usb3-phy";
+      };
+    };
-- 
2.34.1

