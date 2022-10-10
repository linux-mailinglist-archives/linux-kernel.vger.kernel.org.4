Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F305F9C90
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiJJKRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiJJKRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:17:20 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12136B163;
        Mon, 10 Oct 2022 03:17:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbiEasa8dtuxP1RM7k4OT4g8afk6c0yikIat++u8vh0YValXJxKcPliEkgzexx4679xlznZ/mJ6ZcGcUgsu/bTUjfkGv1gQT2oeUroSmG2Ijwhcvpp+PRF2/QuGvtn8NCa9IhPaOwd+y/ZYY8K4rrlFlcsTPLk7HBq+xXBrSLYpnuhK2gORn3yYhI/s02ChswB5tcvn749BaCzrUPRLOfiWFbeCWLuh+wdeThgaF3H4oiX06+EcAtsJVRmuiBTlxO2bp43wAa2OtchwmfeLZNwNRl74PcwS8MHbwIuPQI7Rnu4V77wg5U4gIjl0ydJBFOYhgO0TW+bW54CLXO0gJpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDx0nkvYEpS/AgQNVBQc0jHiJP5P5HXsULgt6e7l/tA=;
 b=ED7mXRleaodLiBicnsCW9VAXlpEPMvMg4L+YNxklb7SBRGHJZ/cPCjmbA+jPc6aD07DZzvPmhjd7OfOMcCXMqZi5KF71BCrpmlCV4TCsTufaGGaUbmJRiGb9d4kFL8+ztM9vGtYwwd+lXVu69Sw+4ZuzEcCnr6cvlDkl011gUNBx6FkpzENguYTls1gpbcvycMXKR/d0fxIzWZj+9BdZl07ef3EOP+TrQeikX5VfOHM8liHdFh9qRPYx4ydBAUOzjlYfDLEf9YhWCZFbcl0kolRIYTKs0CSLtglIWl0u+CB6TI+QnldBJsvH3BRK2K/RDQNnpMgThRYDgJ9spnx6VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDx0nkvYEpS/AgQNVBQc0jHiJP5P5HXsULgt6e7l/tA=;
 b=hMxixZQauUM8lS93JgKH7+bSkdGwSB55K5fD1SB+EQ5dni2GzOeLEuPH+h2PR9/sH2XjAmGxkOJzgzY99zPWXmGtytk2BR2Ueepod6wAynTSdq/03+W0YR8xMXKvGWQkMBRIDYmrmG1QWrOGiIvlYRgUDv8bJ6CAMxX9K6uIlBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7783.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 10:17:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Mon, 10 Oct 2022
 10:17:05 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/6] dt-bindings: usb: usbmisc-imx: convert to yaml
Date:   Mon, 10 Oct 2022 18:18:14 +0800
Message-Id: <20221010101816.298334-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221010101816.298334-1-peng.fan@oss.nxp.com>
References: <20221010101816.298334-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0048.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::17)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 332f55fd-6b13-4eea-431f-08daaaa893e5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I7OipNmB1iPfMDNZrwScwuT2d3KFR5VN9VFSVmiKuKHpzMSa37MS669tqWPJxxsi+Zm0R+FXOYllgbO2tYDsTKgA/Mnm/i5tUjOM73FJvRiz1eW7jiK1VKYeqvKuiNLzBklD1euLnku8nGsQwjfi96045DLB1TLqzYgD0ktVD75rgu0NRGYv5wGelxWRMy2EHwFnUBr2jmeHltU8tkK5taWJmHLVNqxUssIm6hVuql4R/dIplBBar88N7BqfGthtXNZE0gYCrZqhrMulFK4TExpZ/t1W8QFyFf9HmYXwRtLFxvlmLs2vcTJXGtjxAkzEi0wBr2Gd8ZnwoVdrUvNTcXrV1WUVMpDjSPInReLlrVts2eRW2KeclfcEUthui0Q2aZnxvjYONINFSvnkBML5FaVW/xMFyGBv7dN73eohpQptFZ9FFcgKBYk0wf2OhMe0fg/bRhTUpyt/2sNGhQqG1DHMVUdOmugikkTGiKpGf1GG4dFclJQpt2MI8E1tGYTJQQF5GVIEQF0/6zPksQUVeY/V3aqvc2Mk6zdCvJgiFluH7BAtrC3g9vlw2Xl+d0CVEO5Pb5dYHXNdaYnvWMHH5WaVlUpIyq+Lbiauzqvz5gptjVMa3qQeFJn97LZPZq8kQxbnZXQqTSYPELpPzL6JFt3nUCaHPWPSLxHe90ZlT9Djvwq8On8iDmcv8PSnxwu49o5lfv1psUjoDJ4SZe9MgoBscaU7+6UB0pBvHTxEPTKRjDls6T5Iflx14AlScJTl80f8cUNBnbZ4TVyfKzJPc4/UlmAk8tplGxJkEnURm8topqYI+efAeZ0HGf4xgfeQSpjFMBvj3m858NTnvAdxTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199015)(316002)(7416002)(2906002)(6486002)(186003)(1076003)(2616005)(66476007)(41300700001)(6666004)(66946007)(83380400001)(66556008)(478600001)(8936002)(8676002)(4326008)(5660300002)(966005)(26005)(6506007)(52116002)(86362001)(38100700002)(6512007)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S/QQaVwxqWTiVm23C9DQwzzwDr/iX4qMpiZUU2rBgCVPv0PWYOcgDEEl7o2U?=
 =?us-ascii?Q?6cItfIwP0zJzVYLYqmbL7rqvYg+CCKkNLgBRP4n1b9tjJN8i/JrylgFyxtd5?=
 =?us-ascii?Q?qU2M3DBO+KmNA91QfCYgvujAU5Qt5+AKUVlHR5JTNo1egZJWRRPVL0q8BMcL?=
 =?us-ascii?Q?fC1zG3Uprje3s2wHjE8I9+tGJ09umzPVfDCjx50Q0W96cvdogv3KZ/HyLADt?=
 =?us-ascii?Q?umSeDSflsaKTnvXMgNM0plFZU9xyO5RdbM90OuXjfSOGxFvZ8HQEwYFP9OTd?=
 =?us-ascii?Q?79XKJn9DfAVT8z8bUTUghcOp2kllYmDi4ISckLcI/32xEMJp+PmmIFkxDmQQ?=
 =?us-ascii?Q?70f0fSUViLlP95Yy4uOT796RhnJ90egK9sJ4GqZpaeGPWDV2a4dvs9EZVCfW?=
 =?us-ascii?Q?j+7yx5FKts+rwsXIgMR6c6VhK7OhAr6HBgIsZQRVcZQS2Qh9uz1PJpZdIB1x?=
 =?us-ascii?Q?Ahwk4SuhQNlVEVolCAgA4ox9AiuWVdxksn7ebX2kF4LywYiCb3nBIrInu+Pr?=
 =?us-ascii?Q?NjKzJhJXyQyekE9RWDAF9B4bKc2TvBD2jgE/WP/KZ9B8VYLE4wrXjMVgxxEG?=
 =?us-ascii?Q?0ygLYKPxGttRMbUD6A+qGYQs4C2mgZitgtGFSYPAY9v8oAhmmjS+KO0gfYjv?=
 =?us-ascii?Q?X9bZEc2UACOiUKFjUOpacktpYruVC0+tkmqAIMa46joIBq/Z8wCATs6Go0pA?=
 =?us-ascii?Q?BQ0HK5iunLcZVFQdi1lDSSxR7Yr7OLs0B9Go669Fn/7zKKl+QmCH6V1MRnpE?=
 =?us-ascii?Q?PLAqwq1+XUd1wFoGyD5eRdh4eO126W8ti41iOo2z0fslxnrM2B4zaqaAoYbE?=
 =?us-ascii?Q?BNkqd0rduYCaIGLSEWHZ+y5FKuwCHN+5+JiJ7+Coc4X5uFB/oClN4VUJ8Obe?=
 =?us-ascii?Q?datsIPQDfwmZSEbyKyIYtO4ZKo4+RGd5sRIEs8080xT4PCusxoqnjwksxTYk?=
 =?us-ascii?Q?eCByP8+zn9JJupPBvPxFytFNk3waTE2AAdJYLS97XuxOqbE5xr6+TzXdSU9H?=
 =?us-ascii?Q?lhaMsYCbKz8UWQCcpa6aDrAsuSleCIuSTSRrJN/5YcvEoHTkxGpwx9/JERDn?=
 =?us-ascii?Q?637SWZuwDiEN7Ep9AdoXmzRqisx+pG8YEE+0m4/x+L/x3NilgSAi5EGv1qxM?=
 =?us-ascii?Q?hTPnzZwEvsF8CZmUYryveaOSd5E44ziEf/axo74tZu0wkhhLwQjwuTSxsQz3?=
 =?us-ascii?Q?4lZ7bk0YJPZ7R/pk6n3YqM+cpK1wi7dlzVkc/eduAKEs9mSEyWd0ngIDxsNm?=
 =?us-ascii?Q?pc4t/ftADBtU6tFgRXZ5jPN4NdeeZ9lJQVcff1FL+c2/IJMkLfe86qj4xhdQ?=
 =?us-ascii?Q?u1B1SVuqzjOwgpOLrA99+X+LjEoEr9vnumrHTvNsTGuL3/WuzBsXBs5yYq5C?=
 =?us-ascii?Q?nVG/AFCiU2jOlfBhbp33J2Lqdi8VdLui7QyUdYsI6zQmhbNpL19Sp1gpNnZD?=
 =?us-ascii?Q?X+TR1oN4DXGcZxwXxvZEy7vnUwNzXFsmT36G+SpKrrzpJuDp+DIKGP1VbC8c?=
 =?us-ascii?Q?2quCqX+UhYd8+t+KfcL4Ibrhcxejs2xY8tk+DAARIAaCGYfBlqgbJ29cTSB9?=
 =?us-ascii?Q?q3odfUfysZcCMwyK9z0EkU3VAgJzdCkdeVTeiLo5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 332f55fd-6b13-4eea-431f-08daaaa893e5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 10:17:05.0423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LyRPOOW2YhyR8Dy1VTuaR/uF09UrAvLrcW60P5MtKbKYqL2bLeKpKWvuvp6BOCiszL5/CKXWIdHh0os3wXOmRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7783
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Convert usbmisc-imx to yaml format.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/usb/usbmisc-imx.txt   | 18 -------
 .../devicetree/bindings/usb/usbmisc-imx.yaml  | 52 +++++++++++++++++++
 2 files changed, 52 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt
 create mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.yaml

diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
deleted file mode 100644
index b796836d2ce7..000000000000
--- a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
+++ /dev/null
@@ -1,18 +0,0 @@
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
-- reg: Should contain registers location and length
-
-Examples:
-usbmisc@2184800 {
-	#index-cells = <1>;
-	compatible = "fsl,imx6q-usbmisc";
-	reg = <0x02184800 0x200>;
-};
diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml b/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
new file mode 100644
index 000000000000..c0741ce9b523
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/usbmisc-imx.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/usbmisc-imx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX non-core registers
+
+maintainers:
+  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
+          - const: fsl,imx7d-usbmisc
+
+  reg:
+    maxItems: 1
+
+  '#index-cells':
+    const: 1
+    description: Cells used to describe usb controller index. Should be <1>
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
-- 
2.37.1

