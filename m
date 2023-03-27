Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1DF6CA84C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbjC0Ozz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjC0Ozv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:55:51 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2073.outbound.protection.outlook.com [40.107.15.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182DD1718;
        Mon, 27 Mar 2023 07:55:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSSwLne1fXTUSot7j4zsnuJQFzeYjDPOIDipBv/gMoqhOUoQzgYHDgZh9/ulJB369n9qhdQPndQxjuuztgtJG5VAmOQMIIxB09MFA/NYz2mhkNGwAFOwTGbcMwCMHTKxL/gE1TKU1VpOfBcw0AF3EDM/KTKqCfsc40D3qBB5L6tEMGnqKHGCkrT+A1YRwDz0WdKrkBuL1n2XHcd7FPjuKdwPljwibs+6JzIcp6Hw/4erFMV1dZEY+wXd986l0S6/j/9dVnrfibpFnQREBD6r0Y4TM3+FFWa7Uw7fDCnNot8pltTiQnbjgxXF1h7BxzY91TwHjUt6cvdpgqdG1hG2vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCC3DNRdxmiAd2kKJgEzjXS5A9ITCtgBzH7CLjCoLFw=;
 b=QtsHq8q7mYKVyE/GIz3CM8ySFeJzPLbNkz065qBve3sBy3uuzQDRtp9PvgXVfQ8j+0Ti2jHf7oSkS5DwWLyuLyAP6lIHuav8pHPW+2sOiXEuwsYPuBlDsZqedsnT8edKx3IWAmI5fRdXxE9+cnHTNCs12zzlY2ChhTKsQtxK2xVyHtrgBT4IXdr7y3GWQBESPhopKFwvKMsGBJ8cNGFfRIbneUqQavdcsfa72R8yKGq1IYAwEFZaaFImdXlxo5IpvuKX+5FpnV8WF0wq2OSdfzpZoEK8+Vfa+tG+Mk+U2AQHe+mBhGucK0nE/qndiZFzD9tfhLgX4s4lP/wcaQfB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCC3DNRdxmiAd2kKJgEzjXS5A9ITCtgBzH7CLjCoLFw=;
 b=rwhbiqYe77a74IeOVJ8+NPAp2w7OqF+ASqSAOihLHvg6ZZ2EmNlujQYBAYl2dMlGMUh66uO309TBp1kaUcuQ9nqK8cpYgdNptbX8nxrkXxboyHnA+11JN7DqHJLyhRcmmNfs4rPrLqKh8wrBAPl2LE00B5Bu/kw/dMwKOeG+hg4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8640.eurprd04.prod.outlook.com (2603:10a6:102:21f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 14:55:45 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6222.029; Mon, 27 Mar 2023
 14:55:45 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v5 1/3] dt-bindings: usb: cdns-imx8qm: add imx8qm cdns3 glue layer
Date:   Mon, 27 Mar 2023 10:55:21 -0400
Message-Id: <20230327145523.3121810-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327145523.3121810-1-Frank.Li@nxp.com>
References: <20230327145523.3121810-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0066.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::11) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8640:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b491f2d-4c4c-4bcb-1b94-08db2ed3582d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QkaVNI+e8Mten92bW954F1KJRfedKFrkFGoMDYtAfK7Py2E0SDQBmFaO2viwL0s/MCX+iwVEk0md8QV/4N2NBXLuoyXliJiRKpwXOIMaWOPQBCJctODl1wpGP6zBWk+YxZCuL88/qlhX+uE4GPnG+mnjEHetZUnbNTHp1KEAPQmeswkoedbW3EygzmUuBGem6ibNvCXoUAaVYfwxIDozoAbQFSJzGExp1HmLrMAsBVXiPZmBTsil6QgPkd1EImmLHe8uaIbysqFCGihw47gStaHy3UPSUKpb9bEOZ8cUkghAAhLHoMMirYVihad1+5UI1nV+5ji0ePRMVDiaFjIlZgG8sRMXyF8JYCdOkE51HmJ7tkJkZdnTFiGgtKsG7mx89rUSe13NwkMqexyNZZo2U/o/mXVVA2mjge/tFEhlaKH3/l9eimbFBKawv0HcanHbKbPRHa69pLvBRyMsq9Lm3RGDSll4oHoktJZSYVt+nLPQTbrrisc7hguqb4MCdNIXb0zFdYqOi5skGvq4xNaUJGu3jlO7jbGeqSps9RILLqHiAlqwve/OXwc350mMO7QWy1uEtbG5cjzMtYf7+jMayTnFm9t+R01eVcCFM20BywBOEa6V1quYgoncjWYhv2zdl3kpSbf2SGKYW1ipx3qQevOc9uJulrz2Jst8tZwAnkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(36756003)(86362001)(6512007)(6506007)(1076003)(26005)(186003)(2616005)(83380400001)(7416002)(8936002)(34206002)(6666004)(966005)(5660300002)(41300700001)(6486002)(52116002)(4326008)(38350700002)(2906002)(38100700002)(37006003)(316002)(66556008)(8676002)(66946007)(66476007)(478600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hMF/lmwC5aXI5oiWyVfN+4pdAmFXtGDOUfbtjMMtfPzAhMb6rG7vAPSqzYnE?=
 =?us-ascii?Q?TerrvR1tQ3UvB9jYxgp79hM3ubh5aMZuP5JIDXi5SKEXbghcSj5YpvT+aZNx?=
 =?us-ascii?Q?3W6NlzXWJvfZu4whqarqEDrCoPud3eSJM9uLwoptaSwM+KiPGmfhGjWR1sE1?=
 =?us-ascii?Q?XkNelSCcAFPR4XmoLkfioSejxyyNCoUpOKNdwYEynwJOSkOA/2BVtyxsJaw7?=
 =?us-ascii?Q?xefrAKYmNTzn3MRUiTOrREz6IUyaB5/1CfyGX/xmjHzy7a0zI+tIHjdo/XCn?=
 =?us-ascii?Q?8zianKnYk5KhpvDgde0MzgMV0wP3l9RHib3zjY8d0U4+D9zpH3vDF8cE6ctk?=
 =?us-ascii?Q?xogXRZeV4tcksIziQJ58X8ztnwOxIlPJmuo6gbzrUt2QmzEyWZt2GFkxGhRr?=
 =?us-ascii?Q?sxpOSuIb4oWk5WyWhzZEdNyTts3Wc+pqjsT6zR6je5eeCKzm4AHSY6O7Z3og?=
 =?us-ascii?Q?PCjy/GtWB3SyRwcUcLT5BW+PJrHSdXMXuM4pa+Ou7TCZsz04JXJ8gtUt2hD/?=
 =?us-ascii?Q?5kXLB08dfHpFks96/085ED0uhhDB5I6Y4jzJUUGx/fnubTdneZUJAHCqyzeP?=
 =?us-ascii?Q?m9Q+KB8WA61Lf+0iPEHHR92F2bL6y/cu9H40Ti40cf4+2Hxwlb4MyzbEslTs?=
 =?us-ascii?Q?XJ8fWamAW7zVgBWFZxFeoLUIhzoWzdrFe3FQwoSJfUJJINxaKDm3d4dCLsn7?=
 =?us-ascii?Q?3mp5CJ4UCgBnkc9dhbNlGd26MiVj3sAxPP05P2GsuF+vMpsEX2LMPPa0F9b7?=
 =?us-ascii?Q?l3hVGm3ohdJXu/kE5LLEqPQXlSUYk+8Sh4+SC5MWksBAsJPIEedUEOOP/FSl?=
 =?us-ascii?Q?t5Z1+Gj/nqlVoMnQcrlpwklkUoTGDhWCGmI8ubZeh15LUjKhjuAO/gjW4Cii?=
 =?us-ascii?Q?BN7iIw/J4upPK19ZlqkAlUcBeYJRSL6BqIMJSaRszHHUhasGZv5ciHqdVm9i?=
 =?us-ascii?Q?RcQSUmpPC/oWgvrPKmzwE+XWU3tcFG5lYTcXy/kiqZ4KpazKIT7s9EgSnX1a?=
 =?us-ascii?Q?XBXWKhWFH1TfNOhK0ui8joh16vcS9T6HGUbc6cw3E9eNVg+TWG0EvNecjglP?=
 =?us-ascii?Q?M1KRebOwVH2HL3vC6ZTqTY5fograyafh1Avoeg/4Ou0mKRA80AlDAqWfnbgz?=
 =?us-ascii?Q?gheKRA30uxsVznCeMBe3CnYSgPkYcEA7bWvcZ3bsI9m7NPfdsTlqn7RfawwS?=
 =?us-ascii?Q?I37OsSRZ6hFXp0UO7TGCYldlIhJ0YLgmOUT+utriB+VU/j1o2JmGfzlO5mdV?=
 =?us-ascii?Q?FzH9pXtKyZlWT5qeTi6fiKql+qM7yWNWoEiApXaIXW3BDvNC98SR5XRNTK9Q?=
 =?us-ascii?Q?H9cqScSYjMRR2ZfxdHonbfjjRS4m7dz9ZFFpEOP5N6spoVuhMLKK8Ypp/veH?=
 =?us-ascii?Q?Z1+O0gQgMROKI6D82eJKDSN1XiQzNYYJHmellUzGbr8XdwEbgj+KTaJBoHSL?=
 =?us-ascii?Q?YlrX8jDdiGl8uiNiZwuKS8rjWniJjqSNh9ShGeE8Lk+OprS7ljAltHKpP9A3?=
 =?us-ascii?Q?gfPdrG4I6iZEThNcsm6gRDjEFxfR6/jRQh/Y5NezhtFL7+WJip/6Q2Lx6G1Y?=
 =?us-ascii?Q?efYOPC6djXmiiGKYrOb3X+/5WlgerYXkzn/2UaqJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b491f2d-4c4c-4bcb-1b94-08db2ed3582d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 14:55:45.7145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPM/bnbrGO/BtKtIpq/cHlx109z+Wg4G+U4ABo9bsbrVW/SojorQcUaSQSzafF+/aKn5bQ+qezp49KHwFoSCuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8640
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Change from v4 to v5
- Use shorter clock name according to rob's comments

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

 .../bindings/usb/fsl,imx8qm-cdns3.yaml        | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml

diff --git a/Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml b/Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml
new file mode 100644
index 000000000000..ceb76394af60
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml
@@ -0,0 +1,103 @@
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
+      - const: lpm
+      - const: bus
+      - const: aclk
+      - const: ipg
+      - const: core
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
+      clock-names = "lpm", "bus", "aclk", "ipg", "core";
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

