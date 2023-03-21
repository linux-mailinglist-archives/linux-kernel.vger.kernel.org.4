Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A766C2CEB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjCUItE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjCUIsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:48:06 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B663E126DE;
        Tue, 21 Mar 2023 01:47:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlJv/6xFigKIj0Ou5UPWkdRii7CQvOG23ejreIqqeyMgW3rg264zWIKD7E40l3DDYXv82b5ApmcvIDz6qJrD+B5mYBx5ww4wAKUav1t6eC3cr+IyZdSrDyf49mw/+QIqPGiRr7YO9vxniEcNBue7eN5sBnkS5RLKsXSSCgCGAo+rux00jWjmYqJLwBBvhVXEkdRoI9C8+Tqm9ufQHVro0AWcCpnn5bWQXD/3PSzLv4b/i+n8KZ1+2Jirq2A9mQ1lYeASB5kwCyEP9DYZGZQNRM6KtStJDkFPUzbEXg4KrW27vjb/nIWPuth5nNn7SDYVaBXrkxNWOPiLHpiVD+fVBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdhQaz4LP/Ye3oNM/W3yGOegSQ5eqxH+MjxRqf3WZBA=;
 b=MlNINYfw9uUxKPTnLA+a5I52I7Z7HJgxN+VxvitrJw5LMH4vCAelekKFbkmVD5m/yX3xLDnUsZp5c7JSWmZ9IeDHr34sX3oHqAafYw7wlz/ZZQmI1PsIPvPlVwWXI1wuC49GJ8MtDAMUoMUcO5UWt2pj+K91e57b1wytCBBuElWXBIB8ao1i4VXStEgzanFqOPzj0sRJonqZKKkm/O7R7at9xaekYj9bAL1yit3+bNByKefhafygrDQVfx9JbYKLnNvVxx4/b/cwmNb8NCyjy41kP8aunyUpYm9PLMCTQ3610QYkTN9gJFNQUzkrJIxNDMIkS7aQQXByCsWk3ml25w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdhQaz4LP/Ye3oNM/W3yGOegSQ5eqxH+MjxRqf3WZBA=;
 b=M7XdEZ4wivFsQSufLTBTIpl1kWGs1d4Dmte2RMXW78AvhypYBDv1aMuk15C+LZguwVVjfOEjPNdlsbRHyK0gfUkIUt6HO9L+VNGCHqYcJy7hQQnZrUmHYd/wVN1bQtGZbJyb/544CBoOIIStwJGigrIEsQs6RTUuhHwhcsptOPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7849.eurprd04.prod.outlook.com (2603:10a6:10:1eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 08:47:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 08:47:15 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V6 01/10] dt-bindings: usb: usbmisc-imx: convert to DT schema
Date:   Tue, 21 Mar 2023 16:52:04 +0800
Message-Id: <20230321085213.1624216-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230321085213.1624216-1-peng.fan@oss.nxp.com>
References: <20230321085213.1624216-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: df499962-12cd-4401-6202-08db29e8df11
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bnsSWY8clN/z5T6h2sTgsXblY2lZ16BK9/WonmMDsRCQXhORJLq1/BX85mYcmdj+ckRDHL1w1H2Nz0n6CBX2adq3sysLUVwMYQoWLs1y22crAOhPftzfWsvYuZTtYqu2sSoRusf8kPv9Vyw8W3sX8F6NhLDeN+S7jA3uy2PTS2anjfADRmu9BGIUF9TC0g4tMu6/akGRohEvI4rdAk3B/GtUIs5pP4uN8uQxbSou1MAAFU1slxHbyoKpgcjNedGbnTgoCqOnr3vwjXNnpbynfHqgy2h6pi2kYmd3GndHssw+HvWdU2RB8a/h0Ux45luWIO1UCQ7tjKJ4WDb0aqr5zggXtBpjy+4GIR3tpm7qwFh1/an2o96KgQMv1BgS7aL0EgZ5jTd/0F6E8pvrwBsx+G/wg4dE47Kl7RHsT77X6ry310WUhl+DBLvAmCz7ywSxYb12KjxK+drKPLs7OlFGtpUoFzbop45g1jKLPKKsZfDkVTUhxfs12yHLGstmazyH/t7ESYmxObCHZD0k4UqvK5bUpD5TFT/EzVwybadDn3+AKIxVvEZxVg/tAVnxq8rRmCJQCJ4Z0WjxK3rJgqLZtCXbxQdt9F2Nd+CznetUj2HjXOu5lkyI8YRW1hm5h0f+ViiUAa746fSdJIl/ggA2CRPvF3XoafC0cqueY3Mmf+qaaFJDopCpXES+KHuR0cg/9/yBO0aC+zCDF9EXYQuaavwszJkJQs81sH/0mSzFdCo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199018)(2616005)(6666004)(6486002)(966005)(6512007)(186003)(26005)(6506007)(1076003)(52116002)(38350700002)(38100700002)(478600001)(2906002)(83380400001)(86362001)(66946007)(316002)(54906003)(7416002)(8676002)(4326008)(5660300002)(8936002)(41300700001)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vqr8+GyoB2RyKQcaU69YdT7IVGPQBcduDgB2wTm32E3Nl58vbSpYjYujauLX?=
 =?us-ascii?Q?Qhy60nr8tbQfWjEuRH6bNUuImXbVsdpxwB8rfZ9+5sPvudx8pvOwcnXkQ3Bg?=
 =?us-ascii?Q?pLRM49MMbwMzju450vB2TA8maAtjf2rSHe+tIgNcdR0msXNaoficdz8E4eNW?=
 =?us-ascii?Q?+1OSqRgC8rr0ak90Vqy187SPV9GmEtLJOWYMTG9hnMLP5FXD9THXkF8VOXhM?=
 =?us-ascii?Q?YufVvbC7IYj3Iy50WNxPmRJnHPbzM8qZCfJeDRLJyaMkr7Jz67l0gLdgtu4l?=
 =?us-ascii?Q?sTwLuuYLFnisyOCPrhpOKsT9p0rRYKff25Wcu0NMgmndaVCkvg7Kii6RCFR6?=
 =?us-ascii?Q?G4eI9jt2lrhTCIdLABCpwZe19JRlU7B1akjBgrqC/ui/pKLLArIqQfo+yobu?=
 =?us-ascii?Q?F6kGyr9IA32m2emcn+Af4ZeQjZquS3EJ/XMY4NQ/mO6dUTLCpCt4q8IKdRnq?=
 =?us-ascii?Q?DsHS48d+CA0ZiW0pFeoX5/JYQxb+LVMW4GJj0VBoIhLkdLmhDGakX8cnPQaL?=
 =?us-ascii?Q?eM2YRTbaYSz6+G1aWgvXQ+S0E8w/S/K3wMBrc40X1pyzcNIf4JP9CE+F6MZX?=
 =?us-ascii?Q?Jyy/g53RhfmObjydSvudjvDTIX04VXe1wz9Yu+8TV197nTlgW71wlCRyPk7X?=
 =?us-ascii?Q?95YtHKSDMBAzg7cDyZuxx8PvByu24swQ+mIfMmFy5A/6c1xOeVM+FzsWlNoh?=
 =?us-ascii?Q?UKB3xEmBF/C1wk5FrGAJ/rk5nYa0HkSkY9ZNW/sGesBbB7V9HNJEdqZT5bzB?=
 =?us-ascii?Q?6DSeOi4LerBt3MzyF7A6bV9aBuAnF0sqhkpwt2HUiThHEhDjLMBVw43RcOtG?=
 =?us-ascii?Q?3XLXCjHNSrvFmpEPfVW3vA24l4k34onRUDTcgiZ/I+kEj6RchVx12sRcrTIq?=
 =?us-ascii?Q?Mz4UI8DwfjKZB8BfnsKbZHlg36jbhdMGw7l63fhHHPYEqxmhvY2p6DoM/lkL?=
 =?us-ascii?Q?RQYWdlYRESGhKr8tqRGyHm/IZnb6oayuuP77Rzq9XSspjFtI2msHXe9BH6wO?=
 =?us-ascii?Q?6p24IozqrkBskcyAGqqN8PEfkPxwEheA6IYUvfi6Js+ZRIzYHLe6UUidgkuq?=
 =?us-ascii?Q?Ej7WqEk6Ux4m9n6MiwBVGXALpR1BVBFY9Qi/GaK+Xi//0KGz25JJUtXM+PBO?=
 =?us-ascii?Q?gl334QlOSSahUGYDYu01WCecpLYbbSptYPb1wCApAWaX0g5VBNvbrrY2QSOk?=
 =?us-ascii?Q?qUU+kvdfQ0mBi1N3XE/FWiETj4l0Bopb4N044hhyEOVwJuLDQc+XjFAEH2KJ?=
 =?us-ascii?Q?po27IC+3WOUbCrvEbZ0VMgpusucTKgB2yWxyRsAAOI91DSO9Ntwj7eZHu6UG?=
 =?us-ascii?Q?agHxuAo5vh7YuvP4uxIaSQYCXK7ekPNb5syDxL7Gwazk4zt2WpOSBkgdOLtx?=
 =?us-ascii?Q?BV+h2j0xVl1pNE+qxyD3Cdkvj5AMxpUcWqe/dtUu5qEH4t0VOPIiOCvikIId?=
 =?us-ascii?Q?0SyrqpHLf24g74sUJBv9XHuDXIEJoKchLm+pIA2Dtx6opPt2Wrt7j4MG2TVk?=
 =?us-ascii?Q?uNkDtmyAWWbB4FPDMSOxvYkQ0Wcki9EI+vs59P94siJdrtLupOA789l0Z8Xd?=
 =?us-ascii?Q?6WaSKKnNd4ir0xU9T/TRwyrSNXhqEciumwTXKNsw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df499962-12cd-4401-6202-08db29e8df11
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 08:47:15.7947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2UMB8ZrV4YrX9VogtbBOPPvcfxvreHHLrsL01mtd2s6yGTTyP1fepXTHavc6kXyAtd8JMj1JuZZlu/PXbtYOtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7849
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Convert usbmisc-imx to DT schema format, add missing compatibles

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/usb/fsl,usbmisc.yaml  | 68 +++++++++++++++++++
 .../devicetree/bindings/usb/usbmisc-imx.txt   | 19 ------
 2 files changed, 68 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt

diff --git a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
new file mode 100644
index 000000000000..2d3589d284b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/fsl,usbmisc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX wrapper module for Chipidea USB2 controller
+
+maintainers:
+  - Xu Yang <xu.yang_2@nxp.com>
+  - Peng Fan <peng.fan@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - fsl,imx25-usbmisc
+          - fsl,imx27-usbmisc
+          - fsl,imx35-usbmisc
+          - fsl,imx51-usbmisc
+          - fsl,imx53-usbmisc
+          - fsl,imx6q-usbmisc
+          - fsl,vf610-usbmisc
+      - items:
+          - enum:
+              - fsl,imx6ul-usbmisc
+              - fsl,imx6sl-usbmisc
+              - fsl,imx6sx-usbmisc
+              - fsl,imx7d-usbmisc
+          - const: fsl,imx6q-usbmisc
+      - items:
+          - enum:
+              - fsl,imx7ulp-usbmisc
+              - fsl,imx8mm-usbmisc
+              - fsl,imx8mn-usbmisc
+          - const: fsl,imx7d-usbmisc
+          - const: fsl,imx6q-usbmisc
+      - items:
+          - const: fsl,imx6sll-usbmisc
+          - const: fsl,imx6ul-usbmisc
+          - const: fsl,imx6q-usbmisc
+
+  clocks:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  '#index-cells':
+    const: 1
+    description: Cells used to describe usb controller index.
+    deprecated: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    usbmisc@2184800 {
+        compatible = "fsl,imx6q-usbmisc";
+        reg = <0x02184800 0x200>;
+        #index-cells = <1>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
deleted file mode 100644
index 29b8f65ff849..000000000000
--- a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-* Freescale i.MX non-core registers
-
-Required properties:
-- #index-cells: Cells used to describe usb controller index. Should be <1>
-- compatible: Should be one of below:
-	"fsl,imx6q-usbmisc" for imx6q
-	"fsl,vf610-usbmisc" for Vybrid vf610
-	"fsl,imx6sx-usbmisc" for imx6sx
-	"fsl,imx7d-usbmisc" for imx7d
-	"fsl,imx7ulp-usbmisc" for imx7ulp
-	"fsl,imx8mm-usbmisc" for imx8mm
-- reg: Should contain registers location and length
-
-Examples:
-usbmisc@2184800 {
-	#index-cells = <1>;
-	compatible = "fsl,imx6q-usbmisc";
-	reg = <0x02184800 0x200>;
-};
-- 
2.37.1

