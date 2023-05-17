Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291FD706CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjEQP0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjEQP0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:26:17 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDBA7A85;
        Wed, 17 May 2023 08:26:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaP6ZmYAn1DX/VhBaKoD35wKcstH1ThplKxszsRmtaWicSgop+mzQS/iG/ZNWnZY0tAlarWB4XjncrJ02KXqMjZOiJRnWX2c2gTSsN59Z44OMY2wrbl2N7SLy0q1tDQop6XVHNW+mtODHuQQIC0URF909ZsnkjHsSUYH/nS1yYPMjLQt8FISaf5rRmxkvxJLfOB6wJUI7pJYw+uL+5dFxmZEe0uHSG6J3loyLAD3SrSZIaTTwVGjrTPBUXcnBPtfJQJf/U9TLyC97nPyJDDhyWKjjp6mAMbcOrc6ZBnceumg7Vg/TnB73bJGm3bavEqeyPFNUFdHKqQ8xa8NmTqeeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owPhG6mTDaJ9D5eP9BWgU14tOhHx+fEzJEOMaHiu0eg=;
 b=BwHhK1jvxeL7KTQ2F1xsqAaQ2O977ubneZfIySYm6agiK25XCPniaep1KlfxKCWCKudjStsPE+oHuVuCU0BRahs8yJwxu6Y6+pUFxOjd2PK43l8PH4FcrybcZ0oPTz+Xc+B4FiWz4rvz7u2gCK8B1+Egts+5IRKKpNVwRyfffIxCGMDEQVd8l8b1DKkjMTPbmTJieTN1lplJcr73rbKoyv2jopXmK5rPADAG05ln+0U9Lqpgft8armTWOQwevoXCLucA65qbmyu6Cgp2853yYF4xUStmmcLuzNahXEB7rlKTQTJyf33G0a+X6iRwa5S0iwtzNayF6MephIp51mhpxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owPhG6mTDaJ9D5eP9BWgU14tOhHx+fEzJEOMaHiu0eg=;
 b=a0c8DoVCUxkjbyd0fk07+gfL5sqBGeMdxj7FkZ4kKRZgQGOHQpU/am1lgJ4n1Uu1HVccp6U/ako7D8N3czsYMmcZw4GS0P9K95GF+euJVJVmvO35xMWfxGChQlrfUzIzweQyTWLlpdLNaQyWUDN1UcFL/5WTcsZzyj9z0Aki1t8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS1PR04MB9697.eurprd04.prod.outlook.com (2603:10a6:20b:480::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Wed, 17 May
 2023 15:26:10 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 15:26:10 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        peter.chen@kernel.org, pawell@cadence.com, rogerq@kernel.org,
        a-govindraju@ti.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: [PATCH 2/2] dt-bindings: usb: cdns-imx8qm: add imx8qm cdns3 glue layer
Date:   Wed, 17 May 2023 11:25:45 -0400
Message-Id: <20230517152545.3404508-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517152545.3404508-1-Frank.Li@nxp.com>
References: <20230517152545.3404508-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:254::35) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS1PR04MB9697:EE_
X-MS-Office365-Filtering-Correlation-Id: 0850b13d-356f-458e-d39c-08db56eb0aeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PCvAJsARXVZnyJ041JKBb8wzV8RDVTBjKoh3BouJMtU6q2H7r2FjzowfmaUUBs/sWns0xDhrVzBOTaSeX+EjLIJ+uGl4YaT1aWyqBapO+8s1iJ4sr+Z9MIuzyghUl6jr7FmPIGKqtU/kUMZkWKeYsDVFDOZtUYXgEWU8zwAEmSgctG/RrvHr8MZrcjOVq59xb9PAM6R+4j6gR1bFS4paV83YpIe9yN2kjd/ev8pufkWQgdAwi7XZj6CWJXybPYG3uHV+PPZKFPcOii57HroLCwqmN241GRFWecnK7A4OjCY2+92DBvSDditRg8V4mv4HB6v4o5MMbeGchEwUoZokaXfptAEISqovOgfXfhoWESnwTpLyuh03UiFZYiFpdgrOCEkHrF+8B6GMqAydGeX3UlrrtgMkFsWe4iL5nsHv6r/dEAmzT8FtB4Gu1dOBWL61GJGTQhJy6Ylo5wANp4kHPHkT6BYSDeRk8Kegrp4k6NMex5C6rhuez6Pi91eH1JEyEqyIalcbD7VIPTXrye+nXJxrLHCtqS3+2msX6p8ya+OYwInvS8hA4j5jVDvfSH0XF8YkEnF8rxa67m2NV30ot74q+ZHMjD+DOwpVAQBpJpCIJ5f8h97ysGxObEQANT+vT3OWVTrVq2UXU47BLVExiSZrVZJdGDnfnaa678rG+H8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199021)(478600001)(38100700002)(38350700002)(1076003)(83380400001)(6506007)(6512007)(2616005)(26005)(52116002)(6666004)(6486002)(36756003)(186003)(966005)(316002)(41300700001)(86362001)(4326008)(66476007)(66556008)(2906002)(5660300002)(66946007)(8676002)(8936002)(7416002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?loDV+WRFSKi7fV97qfmHOUjc9XJ1U2pmEcXwtswmFqPKwKPEZtESxS0MubW5?=
 =?us-ascii?Q?9ZgEWJu6AiLxkGCtstE+R8OkiZdMc0oGNC5XYVuPyEZqARxkZ3yyIPeD57X9?=
 =?us-ascii?Q?oJhrz293wYk3AFXwI3O5Y61RrLfWjF9oh37NkTSPKb9ZcCIP+mIy8MZxJkAV?=
 =?us-ascii?Q?JP3BAtw+kqELkdLnvSeED1Yy5sHXVpK+1wqs6BEX+F7l3hnMp6twYYXvNT4C?=
 =?us-ascii?Q?WvoE4+ipJFoaCIyb8GGKhkeqN57rE2SxTwNdbVx6i9ghCKmXjmTOENBedR6G?=
 =?us-ascii?Q?BlI4FKcKdbQhcMldyGuDrV31MdnnHEum1SMt134gW4hel43XKzMR334VYuQy?=
 =?us-ascii?Q?xMNG/WdAYF/tiZ5a/tQ3l87hTJz+ycM/txLEerr1IAiWbk5ZcXJEmgdDJfYL?=
 =?us-ascii?Q?pU8u318QYH/RQMQh+0h6F/fKzJ4ztb6FsP5Sjx4j7hD4D6FnaPNX/6Shi97G?=
 =?us-ascii?Q?7QKPrv0hvpKczh5/MdrPh2bxVKcMhai5ZwO1y9c6AHAGHr9vfRAWhUs/wOvV?=
 =?us-ascii?Q?4kAqchx9TQ6qVaAX3KfxeUqcJKX7+OraKrclehXKFCmXmG9AbqB/eR0FIN3E?=
 =?us-ascii?Q?qIlCe9Rs7ClY3qMhDJo9R6tPnLe4mkaeeeLtA6aweUnRnM9aSN70KHUlSkDW?=
 =?us-ascii?Q?Rn5LzAk9UDsmzx1HwlUUXM5NBLrKTOga9LHvk6AIJ9HvR72AQ/9vgfUXahlp?=
 =?us-ascii?Q?SFFOy8ge9p5IUlCkL8tHaapHoNVfqU2mx5rVwQfKHXP88Y8J4bSeeNBleoI6?=
 =?us-ascii?Q?Ezn/EiulUox1YySeImoXJ99+m5ywJ/OEDRAOHdNSwkRYZcSsPG6QKB83ptJX?=
 =?us-ascii?Q?4TVIeFTIJldTUD3sv2FmIg3AWMV8pt6suUztD4IVPhFa6DmoP5tDzhT2xx3G?=
 =?us-ascii?Q?9Emw/16l4R+RrIRcksAmc693RIzLPYcwVzT4iNc9KJnno5Ww1GsXM95Mzyt8?=
 =?us-ascii?Q?OHp8+eHBdzL5pKVAYsNEJiXp3vOuokD6liICN5XLR0YjijcIqykxb6doQL6O?=
 =?us-ascii?Q?OduFIy4QcCl1wISRZkZHsNLQgCZ60RFuTXiwospLVaY6VflyleHu9trBzaoX?=
 =?us-ascii?Q?3dOmcWxWmkSq6Gj4IePnh3FQTU3ydKbcfe22+ilzH3zRGBZnRq+YULQo5tOi?=
 =?us-ascii?Q?B4m3tOf+chqjmKNqZrSMiGg7MnvFJK+7dSNYoH/k8Ee7K3+kyigq41ruVvif?=
 =?us-ascii?Q?SwAQWpiIZj+T5IIn48lGeNRXYneqZY0x7CgMOmpJBo+28oSJi7gD/BEnQhm2?=
 =?us-ascii?Q?YcD+6OAxQJZ9j26urwkqHVHETeEnkFWWifJvNBNirbIV//Mgeo2zl4mYgEOx?=
 =?us-ascii?Q?XKen5nWMvRNWGMs+4lrLfa77LfRx//gdZDhoubxbOB/Fr4/8yormtCG+vaj+?=
 =?us-ascii?Q?38a4nHObiuyKbBDLSxwRoor7XD3Z3FkZZRkzR77FkYd1maULrgYf1btiDSl4?=
 =?us-ascii?Q?BPZqpSvgpq4I2wFVWNEFAEcJYrg2ggnl0Mv+PLfqN0lRRw0XekZpiUe3REpf?=
 =?us-ascii?Q?b9yXLcy5MKFWAAGmmRgkc9sJsBwppu4xOo0Tokx8fKIfYF7JyETIDOrubF+5?=
 =?us-ascii?Q?89q72F1MbTzhtpMFb1I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0850b13d-356f-458e-d39c-08db56eb0aeb
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 15:26:10.5114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amVAJQWxKjF4b5zZLiIg2Vsk1fK4UepGvtW1uLkQSErYnbpBRiK9AZskbZvDSrQNTJcuGG6aeqVJHah5ppaA5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9697
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NXP imx8qm integrates 1 cdns3 IP. This is glue layer device bindings.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Preview discussion: 
https://lore.kernel.org/imx/20230327145523.3121810-1-Frank.Li@nxp.com/

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

