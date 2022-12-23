Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F29C654B60
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbiLWCz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235927AbiLWCzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:55:52 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F543BCBC;
        Thu, 22 Dec 2022 18:55:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZlAtZND+JV8MAyV8xeAAYbz0tyqgNWp/OIMq+sSDgMXBOpeg/GSygFidiO/IYrUgG5+nJZ9Ro34thnKXEpOqPVTCNl3phWsZkTo7DAo9PrLmWMYIUJH4kwiF9xH3sipGuEP9Uu2g/tnvZMmMrp/3alI/hPcLTuNDursUzvTRe/W/Ci4EKq3TVUUJ4+nwD+CkEkvmNMuxNJf7i0Au2D1WywrWBJFtFlMWYnHYwMQo1XfKspzqO6izcGtRKM4b3rSiHAeUg9tD5Oiwt9KKWtZmzoHS7YrwJxr82ex02n6rY2lbc8FCpObySplnmajbQc/ET8RWhJHgIQpxFG8dvXBTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itB46XbOHz79YZz0tspSO7paJuu0pIDY7WfL9IYDCuM=;
 b=PvTWwSNmbY1v19zVdfYVZYPxNolTtV0YUmHv2qeLcXADLE2HfVYD4jIaa6sbKC2iCcDcuHFGMnR0d32WLeh/nU2Rx2BkJqImwegDhXh3OOH1uUHRBWUzE7PGAMkS57QHEXdbeIecaeXvpQcUe1oseretCSI4aZk7oA8GnGKHasyUqF9AWBqy8JWC/5LNWATcVI3E/80f/IuJqvvr6CaBrhLRCFEhk47rf3FcKAg4YB19Cuc0K0Tez1DW87tkBYW/5DPrNebRQtpQwAY0sv2aEktSaUGbL8nkStu5KiZAvACRWfYiYOuITax8JqnqycEAFYgys4h/xOK/9NDolsPN7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itB46XbOHz79YZz0tspSO7paJuu0pIDY7WfL9IYDCuM=;
 b=OTR3niwSbnWinDWbxfm9SpiY4s6WIrClRVinAo4wop5MQnNuXYBEFGdVTO9PPMr2MGFIxwjQitT3z3onNbzR31+EEO9GwezWjSc6isMB45bl2l90GyymZcVe5wYFNCKCxEr2C+Nx9rbx30iukjABAnE8+3Yk4PJsWZkDrKO586g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12; Fri, 23 Dec
 2022 02:55:47 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973%5]) with mapi id 15.20.5944.013; Fri, 23 Dec 2022
 02:55:47 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/5] dt-bindings: soc: imx: add IOMUXC GPR support
Date:   Fri, 23 Dec 2022 10:56:59 +0800
Message-Id: <20221223025703.15784-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221223025703.15784-1-peng.fan@oss.nxp.com>
References: <20221223025703.15784-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0186.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9642:EE_
X-MS-Office365-Filtering-Correlation-Id: 5401b4fb-7bec-4b62-1a07-08dae4913105
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rs5+eOMSkeT2TGLhXZs2O6KTTfrppB0DdfVYyUD62thfDYKMfkatE5KpHHjDipminAkzLG83x/VP6ylLG9ch8Y+YPevS2+QmG6NgIoUI1H0XSV0/wDJHwzKhMdrRhRyjsqUQxB3OxKLhMf3jMBoiN96xeOJGcw7Tpkcnwb8Ku89bRy+BYF/4CJo2mKqZiRiGZ537xwwef6NIa4mTotUSCnq7cHAnjgauKCAKT93Fc3CyI7TpXVNQELEfklGGkqPC1FfkZGgytS9PUB99sJuzHjSrS+Dnvvp0QZrKqsP4SfMixCbr3NjL7qGg5oeU6VBRPksyZmEWtK3K0Fb6C7QuqWe7KLZvdxzCQgeCBA78bZ7avcxZAViuGL9PxXMkbFJOGs1HFPk5Dwkc0M11/Dreum5Rlk2YQ2scHkIT2Ws+mj/DaVj/8iddnsTws5XFVvP408PpCMK/gaKF8SSvYcUX5Je2mLRduMKimMFYQHr7aQa6fnSB3upc++0kpYzZ1a5/T+SinHD09F3G3AuvLqcfuMLGgYRB7d67gJeesLhwtQa6OLrROlRMlDQWYbcTnYIT2yIk5TicsaUghcPEwnqdGHFrCUhvw/qmhtPd8g9GBwEyp5kTqrePoc3bjXm7V955JJ+DGaPrP1zyVRU2Ty4+oOveyRA8kKAXlm9PHPokOZa49edB7msWVA/5Tq3eV9Kw+8clFhxuivRZPmIhieTSsuinMN9zcxgIcws81/Xfgys=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199015)(6512007)(66556008)(8676002)(66946007)(4326008)(66476007)(6666004)(186003)(26005)(6506007)(2616005)(6486002)(966005)(1076003)(52116002)(478600001)(316002)(86362001)(41300700001)(8936002)(5660300002)(38350700002)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/+OVtPe0UT2VAv2D7vPAEdJM4//QoKmZI1W/+ZRW5xEBhaNtWzHnjW5PG85G?=
 =?us-ascii?Q?cZYFHDsZuD05zw1idrtJPiKZ1qhAM7NzXW48DEBwzXvTzmnbCoakrQ2zbvw8?=
 =?us-ascii?Q?25rqQs4psoPdmRPyZFsgxTZZebhMN2hjM27ddlcPO02IAflQ9znSMKSlXz1U?=
 =?us-ascii?Q?YGunQZN+aF2XV3knTfNkbSPL94+ozseyx0RbSrDK/qcPaHLAWVbtDx0RXtnZ?=
 =?us-ascii?Q?lHEgdz0FxEh4sGwcVL2zPHue6OIAWGhQfnt3pXgoq+HWwet+tOOEti7oSP4O?=
 =?us-ascii?Q?15mqG6pJ0Br9zVHMnfJ30ke/EWaCBvsiBTxkHK8fpTmHE4tJ+Naq8VNiUKwA?=
 =?us-ascii?Q?71rm+tQGSzAOEEIyASOVMrQeCl2UbvYOb3Ra9JJQ0yVJbrK9yYkY4QZX8thm?=
 =?us-ascii?Q?7Utbp6GVj1NilKIwOMiud+PEA6e14DjqwogTTYo5CzgDjRGgNi0WoOStaeCi?=
 =?us-ascii?Q?SkUcKAlEvJywu6VPdOVf/xCOeFuKQodoSyfy5wJNhXtYrnUqgA1Fqk+7pwST?=
 =?us-ascii?Q?/hHCgH6DoVrbbB8Tgk9awGscRBKTYSlg5SWaTC5z2whe1fIqvTLnghUcRjgU?=
 =?us-ascii?Q?ib12UQ1ArBFLj1wneMqTgpha6MlmASyeVqrEfZpNtWtiAafFhY8tsdTWrc79?=
 =?us-ascii?Q?JD6C2hGecaYQ5T44eDHuWNQ+A8/U5MaECKO8riXg9djODwmHcHrKRo9C3RCR?=
 =?us-ascii?Q?g32KnThszEFxeNOwVSdDE9gMny/M8DsStkFH5Jk4ZXamL0DrHPVRpfc4Ei27?=
 =?us-ascii?Q?bYE3eNJI84V81gMhrudiylaEoqLuyNZWtQxbf317NaPgMfn077JgGPA0NyiH?=
 =?us-ascii?Q?PBWln51KnG/BOwLB+9e5iQoFpDQIJIOl2EpKk/J835iZY3dE9hgiRqIks8x1?=
 =?us-ascii?Q?tpaSettg3t3kUkaS1G58SjK7CsSqSl+6pp5jlSTbV8XJdo1P/shdw3mOXtE4?=
 =?us-ascii?Q?8D4KLnau38NHH+eZAorUmWmid/9D1Yp8+u81DNoUdVU7CCMctXgOyprXvKK6?=
 =?us-ascii?Q?iSqpyKjCnJIy6n2b9w6q5NSYisTT8+7FnyODoc4Wuk5w5MRcrWpec+1oMZat?=
 =?us-ascii?Q?bIY8D2aXNSBjqkr342AVWW0smUOY3XzTK/RLPjDxhfY8Ce6KShku9APquIh7?=
 =?us-ascii?Q?l3EUNT5z4nbT9t0DJKy87TnFtj7ADKZ/F6cCLebU6LtRgtpffxb6Izf4gWGJ?=
 =?us-ascii?Q?SjTwtS86RWPwV1jskE1DqM+sMIjN6RqHhPpCdOZBdNfUC1b7zKtlKsovaeq4?=
 =?us-ascii?Q?0EgufBNIRWhjUABM7+opDEjkLAKXtV+tni5LF9bcQZ77jnttjZqUA0cFAmwD?=
 =?us-ascii?Q?8HqvIRpNGaRXupdWFItdQv08SEOLeUCCUYjB7qf8ZcFHvM20TIzYR6pgwxJt?=
 =?us-ascii?Q?5jaY7QsieidVHADlHhemIN3ZnKpflT4AewUp4bU/VKV9PErVAG4LC4IzPjac?=
 =?us-ascii?Q?wmaiAHGp5XSPUijH4O7XF67m8BS1gQS0wfN0qO5agkeZIzpNLdDGMqvvrXCP?=
 =?us-ascii?Q?bWzfTpHxee7+Im9TGrKmn60gA8W5rDIvzbZziNPP0uApXwmSnACwSgyTHD4j?=
 =?us-ascii?Q?iHABLx/kdtpXu7qKYtbMSStfZbxQC6bCg7eQSPwK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5401b4fb-7bec-4b62-1a07-08dae4913105
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 02:55:47.2342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77lOX+1/OZhbUam4KSK7HyY8Mkfkw1YejP5zGufOCSOkhmv9NfY8+ekxHhLXCKSs3s5OBf5mo/J9bdPP6Vb+hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9642
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add binding doc for i.MX IOMUX Controller General Purpose Registers

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml  | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml
new file mode 100644
index 000000000000..1da1b758b4ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/imx/fsl,imx-iomuxc-gpr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale IOMUX Controller General Purpose Registers
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+description:
+  i.MX Processors have an IOMUXC General Purpose Register group for
+  various System Settings
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: fsl,imx8mq-iomuxc-gpr
+          - const: syscon
+          - const: simple-mfd
+      - items:
+          - enum:
+              - fsl,imx8mm-iomuxc-gpr
+              - fsl,imx8mn-iomuxc-gpr
+              - fsl,imx8mp-iomuxc-gpr
+          - const: syscon
+
+  reg:
+    maxItems: 1
+
+  mux-controller:
+    type: object
+    $ref: /schemas/mux/reg-mux.yaml
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  # Pinmux controller node
+  - |
+    iomuxc_gpr: syscon@30340000 {
+        compatible = "fsl,imx8mq-iomuxc-gpr", "syscon", "simple-mfd";
+        reg = <0x30340000 0x10000>;
+
+        mux: mux-controller {
+            compatible = "mmio-mux";
+            #mux-control-cells = <1>;
+            mux-reg-masks = <0x34 0x00000004>; /* MIPI_MUX_SEL */
+        };
+    };
+
+...
-- 
2.37.1

