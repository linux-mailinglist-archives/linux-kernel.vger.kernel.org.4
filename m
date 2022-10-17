Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0026007D5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiJQHjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiJQHjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:39:33 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBB7FDD;
        Mon, 17 Oct 2022 00:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8+75v/OVN3cGNeZOqAs6dbCP+gmMNBmglEYOUFf7U5W42EkFr+mO6SDjqIkpj7/YBYUUK5Pept3yCN2KI+/4Qpohy30ibiWr2NeQVoV0gMOT94R0PJrUkjvJSL8GHWjZcBW/R8zXi/y2ohikLP7XO0+v/CWlvCHBflBT00jtzVjdotOfGT2dH53hz8zvT2zDY0aXZHKoVHDzmJuJ2fqd32rqNJ0JqHA8YUVQVy1WAeFgPGGEvxTNmxWZGrD9DCfGzsajVsFQZEBHNVd1lofbbPKIP+bJIC8VsbMnbaJzkHwdTGV2C/aTOBNryNCkpDdpyzE3ySwqrEzHmQqDZ3qyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJDEDv1VRRd0eGjIGre7g6bjvhDBPv81iXX5yZ29A5s=;
 b=bhobrGP+P/MIZt235g/1VGrNZtq+J9KC0OtYKe5yHy2PEIX1Blr0k9SaC9H+FU8pC9++dPUGjjZ3JNdro8fl8htxPepLbXC0o096cvTYqRQnh9Ej7JNNSffZC0wumwbxsnwj7c5BBWqXOICgnWzJ2L4fiPHf6WzcFNMdTCa3oV8L99Y77NugspraCUEhzqIv2vQOEAVcVPKQmGo2xvmYgtbclljbYq4fG2SUsmYvPbdYqTezBikMftsIv+Wg/0bE1uI+6yW2xuYmXxnD/7DMQgbl8wfW4w+GzKzRfMMGYjAbMRne04sOjLcAlMTiEBZ6P45K0TO5vBGwffeIYQ9K7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJDEDv1VRRd0eGjIGre7g6bjvhDBPv81iXX5yZ29A5s=;
 b=gj0rl7lp5fimUJfQFV7XEqRGbb9HK25acieChsr80Uavaca5FlwoRIYOdmTuCwyu20zYC5P3Wcco9TQmdgAxf9IgrxnwUqeOcX1L0fI+ZNK/XQDOGZs3ajIDlz39XQy0Dlm9nbCfTVe5uLG1bM1CVpvroXVBRpjvMIYMf9dWNAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS8PR04MB8296.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 07:39:29 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::181b:75f7:dbc8:b4bc]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::181b:75f7:dbc8:b4bc%6]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 07:39:29 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be,
        krzysztof.kozlowski@linaro.org, robh@kernel.org
Subject: [PATCH v4 RESEND 2/2] dt-bindings: bus: Add Freescale i.MX8qxp pixel link MSI bus binding
Date:   Mon, 17 Oct 2022 15:40:39 +0800
Message-Id: <20221017074039.4181843-3-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221017074039.4181843-1-victor.liu@nxp.com>
References: <20221017074039.4181843-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AS8PR04MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 49754669-1f02-4a7d-3ab1-08dab012b984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bni484sZjUulPlT6X3B1jzbdyh9bd3omS9KsFhUQwPZ0uIyVlhuJljtu44UUIgvRCyRrq9efIuBFMo5rjrB8KnSSu4JfvCUyqwvMrXUIoQpxf2mjhrz03nFaKcr9mgTg3vBr7PoYObZW4OUxak7akdWAjO7TkPqKIuFNJc95b+QKG+mI25RuSUh0XR+6cD7sWRmlLQfu7EBpT6YlWeuNtnOerqD9mgahpKhY65xodiCrmSs01lIV4sZ3I91v1t2l6Kw4ne2EvyaixT3pw/oilF51lHLQwLMCPJT/zmo/eDX1XMAmfMBNr2jMFqT0G+EfWV1VyAqnvJVFAgIOrNnR4U2ramwUAKhLOHoUcb89Rzk1nBHQ0TfveRWbkjpmLkuqTrzvWZs/lelyfXxDCbHDCoHCkHpOGpUAQqCoZPBpB6/6WLAQ/5xoyTOYSgfbbzBpELHDKe/wIEu740/yCV4i138+KZJVL+NiCcKJcz2tnmKUV4yGri3J+9nr9kkQCByGxBYoX7t0x0TPcoColRRXDZPl0SaMFvbm3fV7X1/dk0Pv09YKpJMtm+WH4Jsy5XDOEUJ9PQ0ku5wjkqiJRNaSaEKCpObWA/Ta6R6iuKkCIP/ONaygxF2ap+GjT4wcmUr+Ar2yvTEI4JLywUSqVJ0hcmwbEeHHfWI+LnJT/Ufyt7MwoEUqoXKSQSfpHgeId4/ZC4TiF9qzGCwXmIjRAbFiqjnUx6Y8JV0Z1GDl4VcXRVzwhipnRpZXaZAdf+EpcyDRxet64I8VsE6K09CIfGA1T8nNrH8ZSaaFxi9wfbDbYJ0bkku6FwjoJpewe7r7n30xWwFJlONae/kiuKF48t4/Lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(4326008)(8676002)(6666004)(66476007)(66556008)(66946007)(83380400001)(52116002)(6506007)(36756003)(86362001)(41300700001)(5660300002)(26005)(6512007)(8936002)(7416002)(316002)(2616005)(2906002)(38100700002)(1076003)(186003)(38350700002)(966005)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vQmj7R1nU3nKnGQE3PFAskt7t2Vg3Umrx8PE816gd/w7Wv9BBbo7vzuz9YO9?=
 =?us-ascii?Q?L1GIYR52y5vgFsKeAXu7ky4EvAuZdrnDf6SD1qCAOnACAO9JSFqQBzB24nl3?=
 =?us-ascii?Q?Zo/6qNjXXnVuKgNf2KJ2lc3YY+YpF9dJXzp31wDSxzcwqFmyo/xkaZRmBcG+?=
 =?us-ascii?Q?XtM1uxLw30hWRnw9OmziIhf19Ha7naMaHX4iF17hX8PfGmTQq4XDfVYRv19M?=
 =?us-ascii?Q?azmmBfMKdNneb0F0wrRfpyqaZVCcgjVA7aq65wP3reGwYQrZKz5cAdZy0lqF?=
 =?us-ascii?Q?2SxyUf6nmgQ0JzBdy7ZjiIvfsfqFQLzgZGTqKZM322aEhRzgd8W1ZP3L5bTq?=
 =?us-ascii?Q?2gGjoBWY28W3EDsCfEFUrmpAACbGEcP2CAhHpAvmBegkj+wRFwt/rw+L3mOD?=
 =?us-ascii?Q?wNwLo61d7piXgi8u5FcUepu2pt+o/rp1HOBpo2BoctL3ZZyW9Aldc5+OxfO/?=
 =?us-ascii?Q?L5vn9wpJ1AJUoqwbGQVFcg/umjrSxOoUlWwaW4FXnHrvh1fXUfaMo9h5Pn7d?=
 =?us-ascii?Q?LkCQ2u1ToEXiV7yViIFeDoPZhU1CLS4oPp8BHw5P3VrCIACrfeTWnDOzfqpH?=
 =?us-ascii?Q?lb+r85XGuVLJEr1f7kdBqBQMmPVTGn14s+xJ9zVgnMNIH5KFVeUoIYJXqyb9?=
 =?us-ascii?Q?ll2vmqxgIWs3z7rFMiuBJmcydQaZM2Dr55ozIV9x8uTSCEOw21LvJRLP/giT?=
 =?us-ascii?Q?2PqxwuR1IosciiZnL0s6TlxWgTFdsOhkPfBgcOFfdGlgMl3ArkHFh++PDbNx?=
 =?us-ascii?Q?Ed8/CEvmRBF3kV6F7PTg80Dej3Xmbptsags/i9pGUsoK7SqOq04UdQPgh6Iu?=
 =?us-ascii?Q?OAgbfHxBY+Stup2H4ivzeEI9ICHFEHohPY6PP5bxKpnlXT+4m+tE7BoBVLqw?=
 =?us-ascii?Q?2RztN7atCfwSsdkIl9tEcZ+x8L2pVLR+BntUPY/N/TlmafZ1ZlV9iJz94evt?=
 =?us-ascii?Q?bFklevNUHUHRASO4tX5nM4dz8+yqBfCBQoVw6+5k5R1842bmnOzsVGmA+ULA?=
 =?us-ascii?Q?L7z86qcAHSMZPq2QoHZm9Ns37LYeE44H+1OZJZE57J/MvV9w+XFX4NJ5E2p8?=
 =?us-ascii?Q?oP1LK9GPiw7MQjcZLubLHOwMQm48H6GYh/mR7gzdUm15qoo5wQexs4QJ7tJx?=
 =?us-ascii?Q?4Psmy9+9cHX74TJomEU3TwaBnsEXahrfS96H/ZVb5INxeYu/HYJqhCTp8nPL?=
 =?us-ascii?Q?24x/fh+FFMyecs5IZF4FbcfqwJXzduYnlhRtU2UXyk1ZYmZhhNrwqs0mwuSl?=
 =?us-ascii?Q?pDiMmMgYiJ6SRyKPrHSQtlU4UaUBiH5zMT6UnfJSyLwy4YEpPPQU2nwo2lBc?=
 =?us-ascii?Q?arWLYNfUW5vzM8S81J9weiBdiNZ2MpCaANeP4jonpCODEFHAyNxEbgvz1ZUq?=
 =?us-ascii?Q?fDtJkcEr0OPACfLizweNgRcxlQwuyXrX5+xBZ5NDGeripzw8e/hKDnPFP62c?=
 =?us-ascii?Q?veUs3Wj8sxnwb4OUprOasc/8RUbOqKnxTx+fCsvgvNIQ0xWh4BZb2zlrGEkS?=
 =?us-ascii?Q?GzwRKRX8zYh+f3U8uTrT8qFQb38zkY+8Br/zZcE3H5IkLAzoC6/z/hVU/+j1?=
 =?us-ascii?Q?iImzAO45pYudMYrXCp1rMVsWdlBfQ4CO67I7SDpt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49754669-1f02-4a7d-3ab1-08dab012b984
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 07:39:29.7977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q7zTplxcey6Y0SJbvDiUvvU4efq7PDfg9PFjZ8HDsLJO4uGjuraFxJ79p7TxFrU7IA0aRIW2+swg6/h7CW6Flg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8296
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Freescale i.MX8qxp pixel link MSI bus is a simple memory-mapped bus.
It is used to access peripherals in i.MX8qm/qxp imaging, LVDS, MIPI
DSI and HDMI TX subsystems, like I2C controller, PWM controller,
MIPI DSI controller and Control and Status Registers (CSR) module.

Reference simple-pm-bus bindings and add Freescale i.MX8qxp pixel
link MSI bus specific bindings.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v3->v4:
* Add child nodes in the example MSI bus node of the MSI bus dt-binding. (Krzysztof)
* Resend v4 to imply this patch is based on v6.0-rc1 so that there are not any
  dependencies. (Rob)
* Resend v4 based on v6.1-rc1. (Greg)
* Add Rob's R-b tag.

v2->v3:
* Add a pattern property to allow child nodes. (Rob)

v1->v2:
Address Krzysztof's comments:
* Add a select to explicitly select the MSI bus dt-binding.
* List 'simple-pm-bus' explicitly as one item of compatible strings.
* Require compatible and reg properties.
* Put reg property just after compatible property in example.

 .../bus/fsl,imx8qxp-pixel-link-msi-bus.yaml   | 232 ++++++++++++++++++
 1 file changed, 232 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml

diff --git a/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml b/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml
new file mode 100644
index 000000000000..b568d0ce438d
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml
@@ -0,0 +1,232 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX8qxp Pixel Link Medium Speed Interconnect (MSI) Bus
+
+maintainers:
+  - Liu Ying <victor.liu@nxp.com>
+
+description: |
+  i.MX8qxp pixel link MSI bus is used to control settings of PHYs, I/Os
+  sitting together with the PHYs.  It is not the same as the MSI bus coming
+  from i.MX8 System Controller Unit (SCU) which is used to control power,
+  clock and reset through the i.MX8 Distributed Slave System Controller (DSC).
+
+  i.MX8qxp pixel link MSI bus is a simple memory-mapped bus. Two input clocks,
+  that is, MSI clock and AHB clock, need to be enabled so that peripherals
+  connected to the bus can be accessed. Also, the bus is part of a power
+  domain. The power domain needs to be enabled before the peripherals can
+  be accessed.
+
+  Peripherals in i.MX8qm/qxp imaging, LVDS, MIPI DSI and HDMI TX subsystems,
+  like I2C controller, PWM controller, MIPI DSI controller and Control and
+  Status Registers (CSR) module, are accessed through the bus.
+
+  The i.MX System Controller Firmware (SCFW) owns and uses the i.MX8qm/qxp
+  pixel link MSI bus controller and does not allow SCFW user to control it.
+  So, the controller's registers cannot be accessed by SCFW user. Hence,
+  the interrupts generated by the controller don't make any sense from SCFW
+  user's point of view.
+
+allOf:
+  - $ref: simple-pm-bus.yaml#
+
+# We need a select here so we don't match all nodes with 'simple-pm-bus'.
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - fsl,imx8qxp-display-pixel-link-msi-bus
+          - fsl,imx8qm-display-pixel-link-msi-bus
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx8qxp-display-pixel-link-msi-bus
+          - fsl,imx8qm-display-pixel-link-msi-bus
+      - const: simple-pm-bus
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: master gated clock from system
+      - description: AHB clock
+
+  clock-names:
+    items:
+      - const: msi
+      - const: ahb
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    description: Devices attached to the bus
+    type: object
+    properties:
+      reg:
+        maxItems: 1
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - power-domains
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8-lpcg.h>
+    #include <dt-bindings/firmware/imx/rsrc.h>
+    bus@56200000 {
+        compatible = "fsl,imx8qxp-display-pixel-link-msi-bus", "simple-pm-bus";
+        reg = <0x56200000 0x20000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        interrupt-parent = <&dc0_irqsteer>;
+        interrupts = <320>;
+        ranges;
+        clocks = <&dc0_disp_ctrl_link_mst0_lpcg IMX_LPCG_CLK_4>,
+                 <&dc0_disp_ctrl_link_mst0_lpcg IMX_LPCG_CLK_4>;
+        clock-names = "msi", "ahb";
+        power-domains = <&pd IMX_SC_R_DC_0>;
+
+        syscon@56221000 {
+            compatible = "fsl,imx8qxp-mipi-lvds-csr", "syscon", "simple-mfd";
+            reg = <0x56221000 0x1000>;
+            clocks = <&mipi_lvds_0_di_mipi_lvds_regs_lpcg IMX_LPCG_CLK_4>;
+            clock-names = "ipg";
+
+            pxl2dpi {
+                compatible = "fsl,imx8qxp-pxl2dpi";
+                fsl,sc-resource = <IMX_SC_R_MIPI_0>;
+                power-domains = <&pd IMX_SC_R_MIPI_0>;
+
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@0 {
+                        #address-cells = <1>;
+                        #size-cells = <0>;
+                        reg = <0>;
+
+                        mipi_lvds_0_pxl2dpi_dc0_pixel_link0: endpoint@0 {
+                            reg = <0>;
+                            remote-endpoint = <&dc0_pixel_link0_mipi_lvds_0_pxl2dpi>;
+                        };
+
+                        mipi_lvds_0_pxl2dpi_dc0_pixel_link1: endpoint@1 {
+                            reg = <1>;
+                            remote-endpoint = <&dc0_pixel_link1_mipi_lvds_0_pxl2dpi>;
+                        };
+                    };
+
+                    port@1 {
+                        #address-cells = <1>;
+                        #size-cells = <0>;
+                        reg = <1>;
+
+                        mipi_lvds_0_pxl2dpi_mipi_lvds_0_ldb_ch0: endpoint@0 {
+                            reg = <0>;
+                            remote-endpoint = <&mipi_lvds_0_ldb_ch0_mipi_lvds_0_pxl2dpi>;
+                        };
+
+                        mipi_lvds_0_pxl2dpi_mipi_lvds_0_ldb_ch1: endpoint@1 {
+                            reg = <1>;
+                            remote-endpoint = <&mipi_lvds_0_ldb_ch1_mipi_lvds_0_pxl2dpi>;
+                        };
+                    };
+                };
+            };
+
+            ldb {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                compatible = "fsl,imx8qxp-ldb";
+                clocks = <&clk IMX_SC_R_LVDS_0 IMX_SC_PM_CLK_MISC2>,
+                         <&clk IMX_SC_R_LVDS_0 IMX_SC_PM_CLK_BYPASS>;
+                clock-names = "pixel", "bypass";
+                power-domains = <&pd IMX_SC_R_LVDS_0>;
+
+                channel@0 {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+                    reg = <0>;
+                    phys = <&mipi_lvds_0_phy>;
+                    phy-names = "lvds_phy";
+
+                    port@0 {
+                        reg = <0>;
+
+                        mipi_lvds_0_ldb_ch0_mipi_lvds_0_pxl2dpi: endpoint {
+                            remote-endpoint = <&mipi_lvds_0_pxl2dpi_mipi_lvds_0_ldb_ch0>;
+                        };
+                    };
+
+                    port@1 {
+                        reg = <1>;
+
+                        /* ... */
+                    };
+                };
+
+                channel@1 {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+                    reg = <1>;
+                    phys = <&mipi_lvds_0_phy>;
+                    phy-names = "lvds_phy";
+
+                    port@0 {
+                        reg = <0>;
+
+                        mipi_lvds_0_ldb_ch1_mipi_lvds_0_pxl2dpi: endpoint {
+                            remote-endpoint = <&mipi_lvds_0_pxl2dpi_mipi_lvds_0_ldb_ch1>;
+                        };
+                    };
+
+                    port@1 {
+                        reg = <1>;
+
+                        /* ... */
+                    };
+                };
+            };
+        };
+
+        clock-controller@56223004 {
+            compatible = "fsl,imx8qxp-lpcg";
+            reg = <0x56223004 0x4>;
+            #clock-cells = <1>;
+            clocks = <&mipi_lvds_0_ipg_clk>;
+            clock-indices = <IMX_LPCG_CLK_4>;
+            clock-output-names = "mipi_lvds_0_di_mipi_lvds_regs_lpcg_ipg_clk";
+            power-domains = <&pd IMX_SC_R_MIPI_0>;
+        };
+
+        phy@56228300 {
+            compatible = "fsl,imx8qxp-mipi-dphy";
+            reg = <0x56228300 0x100>;
+            clocks = <&clk IMX_SC_R_LVDS_0 IMX_SC_PM_CLK_PHY>;
+            clock-names = "phy_ref";
+            #phy-cells = <0>;
+            fsl,syscon = <&mipi_lvds_0_csr>;
+            power-domains = <&pd IMX_SC_R_MIPI_0>;
+        };
+    };
-- 
2.37.1

