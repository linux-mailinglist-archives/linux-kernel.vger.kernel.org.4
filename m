Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF946A2F9A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 14:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjBZNAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 08:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjBZNAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 08:00:45 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A6F1205D;
        Sun, 26 Feb 2023 05:00:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghWYwaT4bHpB7auYyk2ZvaNxM9oDpdpDC49pvoTF0pqsG7IHFHmfKokNcDxO0LRfqp77L515akmoXw8EQrfNzt0iX8zhuJvhdV+b8Mkq1MI+nOdfZLKvK2x00gTyfTj8elAveALRHXpW7hEmqSmE6HyXjnCS9lyvrKKFe0U860a/Fr3HQAWUsoN/lh1ggwParElt7K1ZUJzb5UDAfXC9BGqGKyZBzqcQjVgk4G9tjti3OI+E13vtmgdh05TF64qlqtnDNvSAeMVin4LPGjTW4vJEJ4qSDC6R7ttVqtnUI4jLVvQrgVJFh50FzP979spUmewmBEF8TWzo6XHOyVjxWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDZaeAs1gGdg+asb9N+gR0yNFVxWeH255sGDbjSZkgQ=;
 b=Bg6UKzlAteH3eE5hWAr6A38a7DUjTQLldrQ7SXKfot+9AZos9GSaNwLfiDRy+iEJ8PaYrD1aJJJsltprNO/x68MfAhLEw6ct9EoYC5Fe3kdsmvbgwwXGCvbuG7TmSKNF1S1Jhp/kdzeU6ymEKDboZjwErTKRfjCcLb1togWHBuiQRLV0OwTZllwrDOq0YW0jpibHBw+KND1sKbXNlnLP6YO3N3zLueaC0UgGVyORCVfid+wfmmdF3igE0/sWm06wXzfsIG5nh4oa9sO+pE5iZHcqT9tPVxwVrqglid3SNbYCrDPpa5UBeMfTVH1NIwTFkgZjPiiKbRZeWcXYVA72iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDZaeAs1gGdg+asb9N+gR0yNFVxWeH255sGDbjSZkgQ=;
 b=FT8K897O+Fj6Mm4YszIFiud2iWTNHUJI060VVg6A8cAxOH1ZN7qMVzpTrKj6iU/D2MTo4kLGpm+/u+9RztauANInwynt50VIzBj09gkXE1wcbTVVAgjAkcr5Vhp95gj2AqWEg6WmfXRCJXbilU9v4OAUxpct0yDH+EPuaaqq/kE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8968.eurprd04.prod.outlook.com (2603:10a6:10:2e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Sun, 26 Feb
 2023 13:00:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.025; Sun, 26 Feb 2023
 13:00:37 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 1/7] dt-bindings: usb: usbmisc-imx: convert to DT schema
Date:   Sun, 26 Feb 2023 21:05:33 +0800
Message-Id: <20230226130539.277336-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230226130539.277336-1-peng.fan@oss.nxp.com>
References: <20230226130539.277336-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: ab383b70-597c-4fef-f85a-08db17f97434
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fTaR3JOE0SFQThXbJIZvuvou9LW5o+sD0CaQdQeSxoQlZPxnrMM44k0EKx1P3eDBr8jYGSjAPQkCJ+zHJyvu7HdM3BrLruBpSdgFHiar6K6V7PN/JQr1zowYJl94ZnvJgeeaX9HXDa/IcFEte6003H8WBiHLTI9BjdSbd0IIwcAhtLhEuRSYjkhxlzh8y2aJ7QZq6ihvyJP7qHdhjnwd/Z8jvVk26zLBTaDwy9TeeDUwwvqPJVbWP4OmH1bdiifU+p6L5Ew3fkfjO4mXUD6W7MLa+7w6BBGX+lyWt39MkU6eaFzHM+QhxHJlhkiDmNrGd5sKO0t7axhMIBoUEqQMJa3DWgGDyw9Cep+ppoDciV5m3vboNuc+O15zojQf2Rqk5/qsjnLVYUKU+HoIU0x1xrRaFHnIFlADGhgxKgILn/2j1XfcQgQRMD58eMn5DH4UMFE8tXrtpQdB/S960NFQ8G0bZZzgmSv4RXJNV+E9sYc+uXZxiVQPvcwp4sUqKe5NbxSfSu5RjfnE4rivTQD9fN7Ti/y2daXDsLh3mg5xpm5mc7gqRMQFoyqw5QZAt+oDEeq4KLkI7QGYRXONjdU+7kpr6/FFnI3PNqnwp5L9DnJf19mzvOoJlzxebLE1YmB3STD0wbzJN7S7HaWqJaI6lrAiPNP541p1MCxDw/jhadnwz74XOM/aFVFBupE+jFtC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199018)(83380400001)(8676002)(6666004)(38350700002)(38100700002)(86362001)(8936002)(5660300002)(478600001)(7416002)(2616005)(26005)(6486002)(966005)(1076003)(6512007)(6506007)(66556008)(66476007)(4326008)(2906002)(66946007)(316002)(52116002)(186003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OyrQT8DldUyUPOkmQbtfiw7+HM7epQl/S8+hbkq/Yh/bQle1TLlCCF7lEY9r?=
 =?us-ascii?Q?xUKOPAmaCxVDE7Bfu5M/zu9i3mow4G+vY+mZGM6QeGJfNuOHuc+8La8d04U4?=
 =?us-ascii?Q?gel6F2cub3PGAYpJc/va5JF/suaPKdfkobp/OgO8MDAxxfnTo3ais4Bcif8O?=
 =?us-ascii?Q?lOO14rlvqkabsphZ0aRo73yUY5ojiYY+ybX0f67yFjr369GKG3iu+z1yxISN?=
 =?us-ascii?Q?8nPhst9prD5/M3szls82FXlm2+zAUfVpArasIwpVkpKbElSKeGn01sP3j2zD?=
 =?us-ascii?Q?iHuwa8noQ/k6a7+csuEspsIwCUArvwMrMl6oVhNE7gb9TSL+b0C5WTfQa4Fc?=
 =?us-ascii?Q?QIZqE4JMSpNEoTdSN6NLRyPhsLDw8G1o8uFY79FZAGn68YHkFmEYz6XD8MZo?=
 =?us-ascii?Q?sk9+UIAbTVyHIuWasT+YwL4uWYnPq81AV8eGqglcLBXvgEqf5c4OIYReacHS?=
 =?us-ascii?Q?JOYu7NiiNebfRJ0vGL88kgqbYsfVJLtRiHcUB1DWJjuiFrP7hmdULmgxFZ1C?=
 =?us-ascii?Q?IkFQjIHXpiBr4+jbPtKkOxW7Ap1Mdm50dbY6dexdQ+0Yk90dUStODEbhRkbc?=
 =?us-ascii?Q?arkBWT80iOVo4XJpSH504zUennHckd5H8DvG5Wjt4TJDe+PyI2zZ8PIUblZ3?=
 =?us-ascii?Q?tiT4/onsTWQBIfKjLIlKbPvjoZYXRBy8jYpeMdRhTSOrIz0Fz/yzMvslGfg5?=
 =?us-ascii?Q?KvpQ3TjWLNWglWSV+6FwHK+3wLu400/iJqY1PNaP94pKEMWpdLxWwYmyoqmL?=
 =?us-ascii?Q?tvNH3IkRHiEjeSFkuTjpMGbkwQmHI/Vk9Ggrfz1lYmOlW8ceRVeisJTkkZ1E?=
 =?us-ascii?Q?6NO1yMTbTfomlmH4AjLUQxgcAKGWqhOf/dPMJ8SV6yQfMX8NFPnQNbCwpuMV?=
 =?us-ascii?Q?J8Mlkou10WvirFJwaNPBqsX6GcGYFxnT7VGWdKoS6nB/0L3XfYfNxK1uTLpz?=
 =?us-ascii?Q?0dJqMX8A6t7WQ3NC8bSzrnPKkb79rAaqn9QI3OWKroc4oOrGHbD6lmISECLd?=
 =?us-ascii?Q?ukaVJh9rjoRucfHgm5bKdB0pxvTG20v8VgfFHy6U9+VClVbUwnDcJnpOf4EX?=
 =?us-ascii?Q?haTgyw8VML2NtF1hXC3UApH6rzX89Lbaz0hHr5OCJ6hU8byIKBxXGlc6soXx?=
 =?us-ascii?Q?rAAUcoAMpBgdE9S2gMTzyXI+uzTDFQGPaH4rjtB83OEgPXzmc41doGlitEIH?=
 =?us-ascii?Q?L3KTJOPUwu1zKHSBBm2O/qfUA8PPy9qnhA8wSOQMDQ91zJ7SKiKaoGXmH5JD?=
 =?us-ascii?Q?qvZwjfQ4NtFgJbl4W0r/6j8iVdQxH04rt6kBFohDcv3gQkLDqzr1VlO5BRJF?=
 =?us-ascii?Q?VWYoTymMlLLFRfCpYSudYq4z4nxZYgZaGQK0UleDtAD8A7RuQiFz12u8jK1E?=
 =?us-ascii?Q?hwVi8fFErkcPtfUba93W/graOiN9GHgB9mkCy1+HxhWohej214zj2ZsapEvB?=
 =?us-ascii?Q?haTmGgLkT1uM7b8pNrEbh1W7Lbgw46VyA0KlEoPQ7WS3YSrz9B8fYcx3kPQ1?=
 =?us-ascii?Q?XE20c+eNrEOrJwpqyS14k2seDDAw6vXWnIAXb4fffWypHqpOWPWg/tmeT24C?=
 =?us-ascii?Q?4YZqL23yIxO3pdkRL0t09cFl9ewYGxe2+zNvG8Xc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab383b70-597c-4fef-f85a-08db17f97434
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2023 13:00:36.9793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLxIY0pZ0TBD9B6fm+icw+7NgAh5QziSbtdxtuSSifTeiOAz5UB+jqK1tEpEoQx1O3Osd/2WdL8gQ6MBYWBz5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8968
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Convert usbmisc-imx to DT schema format.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/usb/fsl,usbmisc.yaml  | 54 +++++++++++++++++++
 .../devicetree/bindings/usb/usbmisc-imx.txt   | 19 -------
 2 files changed, 54 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt

diff --git a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
new file mode 100644
index 000000000000..517390b9d2c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
@@ -0,0 +1,54 @@
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
+          - fsl,imx6q-usbmisc
+          - fsl,imx7ulp-usbmisc
+          - fsl,vf610-usbmisc
+      - items:
+          - enum:
+              - fsl,imx6ul-usbmisc
+              - fsl,imx6sx-usbmisc
+              - fsl,imx7d-usbmisc
+          - const: fsl,imx6q-usbmisc
+      - items:
+          - enum:
+              - fsl,imx7ulp-usbmisc
+              - fsl,imx8mm-usbmisc
+          - const: fsl,imx7d-usbmisc
+
+  reg:
+    maxItems: 1
+
+  '#index-cells':
+    const: 1
+    description: Cells used to describe usb controller index.
+
+required:
+  - compatible
+  - reg
+  - '#index-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    usbmisc@2184800 {
+        #index-cells = <1>;
+        compatible = "fsl,imx6q-usbmisc";
+        reg = <0x02184800 0x200>;
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

