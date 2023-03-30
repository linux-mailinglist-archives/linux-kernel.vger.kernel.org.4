Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A8A6CFF86
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjC3JNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjC3JMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:12:46 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2517681;
        Thu, 30 Mar 2023 02:12:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNhObUGyXCcrpoC2AVcHRfJnUBVpdt4samtV2MCUx6VyrjYDQvcj89vH7ln360+pGJ14Fd/qIZL+agQyTmJeosrGo2UHUyt/Eqsk2BwNBcBTNG3bjGJYS6AuTkLa0mAUELsS99N08yM2cNdtXzq/luEDMllAZgRMEHjv95RfKt1Qswu2iw9WcJWaDjCWwhQFjCGsQq1an161zCyRAAVkhK6qPAHtsT5KI2A/yPe12dtwJyarkwRTDBZEcoluipU5RbV8Nan40h8P5PrBoH+hMdi/tY3msVOTD0HJyRuiq8pW067jlulb0DoVBYRU+MZJ7+eOjKxiM+NdqRBIOI7iFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wu3JWWPect5Eubpr+9HD6qlKWrx9eMl8VbrAoPtquvY=;
 b=ercKjsp1cWpomzBsEOP9659e6veJ3jXjadlMvhGTTTs80h61my95hbd0tqE9T3y6IlHf9D4sC425gP1y1BqGIRZPaW9EVvpLwEtf/+6w72PEMey2ABwE/G0Gpjj7ZF3WSvI6E8KuhE/8xJFchJyL8k7rrBf2mVX5hqlWQbD32BrLTNDs9Wou1/BDVOFO/4vl4cvG27+rnMlp4FS02J62DozEfXpHcNqBOkuRlFSuJoeuWggU3iO5PUsuBp7rsosKruzMx80sZ52OkDoTVZU3V6rZPhLqcqxM0kH/e6XhW3L1yU/jfAihLh5eFrPA5e0egljJ9/l/G0vjoDsAtsgbEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wu3JWWPect5Eubpr+9HD6qlKWrx9eMl8VbrAoPtquvY=;
 b=He1Kg0meYCKAtpAKC3vfo98rR8+qrn9zu/zc+TDMt1jtEDDAJIMRfnrl8pj7zm16UumuIgcv4hjQdlm2mHTCv6tUKy7Zz/nGthjuWubELT7vn3PkcBGPvIBNKinN7YVVh1HkuYm1A4UHq4fihtzSEcAx9YXaQ64v1deTQGASLzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7725.eurprd04.prod.outlook.com (2603:10a6:102:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Thu, 30 Mar
 2023 09:12:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Thu, 30 Mar 2023
 09:12:34 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] dt-bindings: usb: typec-tcpci: convert to DT schema format
Date:   Thu, 30 Mar 2023 17:17:36 +0800
Message-Id: <20230330091736.1873121-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 29409921-2197-44b3-37cc-08db30fee5fb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUX/SeHarXWZMh82UByOaPQzj47XHJyvr92KPNN1LxywXbogshyOOQv6zMAvXZaH5a3qVjIFfQS/LU4tf7ur1GqA0fHkb5wFKXFXXKF27rx8wU0QJFqO391rdr6vXXOzTiZiaMkGjYk8z5fakIPKO0nnMXddK5uUcjNQCnnDbviyN1CZPLZU76+fl63HfMObICTirBqtwxpGRdha79BrCYNmF9fNaaJ66gJw1mpcErzHlEfLocTyTJVARA/XDpxuUhBFdJMGyOTEGKiviolANgg9qunzdhS0N70uDXJuS8fInpkEi9unPeUJ5208/VOff//BIWgmcwuWpZofoxwhenizH4qdAfdMcUERPKv9EleeFlygbcjH7FZctQyISi7NEFwTvgSmOPsF2fz1xU9YsuZzGQLNYDpX175Cr/HM4FOSCMOUk9pAs4vdQrPbOuY1HreJjjQyBItWpfUSJMYbmadmDMG3HFKXBMGMLHUson6we501aRe4aWvZw46YCUpYHzHU7schMMQdFefUtwmR6ICs6STHeyEY5scDgz/j9O28nHK14NLQp8u7DHPhCLl8lXtwNYB9w5bDWorpzL+1a4XDdERQEO7GFFhNhLogopw3kV45jMJrGGndJqufCk4E9r5LyrL0CDuyoOcWX91B5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199021)(2616005)(86362001)(2906002)(478600001)(6486002)(966005)(186003)(83380400001)(52116002)(6506007)(1076003)(6512007)(26005)(8676002)(66556008)(66476007)(66946007)(316002)(8936002)(7416002)(41300700001)(38100700002)(38350700002)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bj3vd/Dg2zzA0EzBhsshT9VisFht0fkf/CxRCjYklCOv5ZQJuI/2N4/XxCIi?=
 =?us-ascii?Q?QNkUboDoz9mkUGdVw0wlV91H5jCKLCUpgzegoYNIc8kqWyUG4AJ0GzX+Pb8v?=
 =?us-ascii?Q?ibt8Tk6Y961Up3+cg3phiyblPCgdwKannQwi1tlVqJty3bMZyfg9YHq3BBR7?=
 =?us-ascii?Q?UgtCT8joq0BqGB5KVUo9gsk0AASFbhC9kLvjW1z1KoHDU3PbFcnLctvVy5MX?=
 =?us-ascii?Q?BA+UYegdLKyrafYAzOwsSfEMqh9req2OJcgWhnwiCDXrLHPAXaSTkEjCCUY+?=
 =?us-ascii?Q?SpXDKyuU+poEiNVmoXdjVA5/QAG7fa6Ht1CAdE8q7pxH+7jKdWpHT0qqjszI?=
 =?us-ascii?Q?AtL7XXa57qe9BGSpMlo8Rlxonh3wdCwjV2tPWLqk1Vc354teyocoCGazLwEg?=
 =?us-ascii?Q?AYLesWhZO+ZGa4gkimtrDykh0mr8otXZQaFehdjU46xOJ5zlrkbcf8TqXKHA?=
 =?us-ascii?Q?zvO7HiQF29idvwLkQti7q4wxAOmUBISGqC2KwI1WoP6uVhBuLeExp1mzPjjX?=
 =?us-ascii?Q?QupZQoPeVW9PF7TuSLUNAYpLmpcVHISIahFEQFfU1qLhyGiAZo7BK3mwRxEX?=
 =?us-ascii?Q?n2aQnuJ1459gAAYAJ0sN5s7UvbW8C/SuiVzVxEv+8zfhKf5goLB7CPQqDax0?=
 =?us-ascii?Q?TntR0ApVmCWYVYsMPwo1gY7jc/Hos+nW21OuySbjh26T4O2heXIwDOwWDa76?=
 =?us-ascii?Q?C/UQQz/0xzuoaJ5iNq8qucYvER+zEW9CUVEXVuq39F2enFyHoX1RVekdrz81?=
 =?us-ascii?Q?1gnYvk6QzCM82/BEZmtszQNROG1QBBXMemSQyfknwPci5y0JaXWFEEcHeQyU?=
 =?us-ascii?Q?qP8JfYedcnoyi0RIi81V+XtgA6E28SRhMnNKy3oVnynNqwH4egIlIgSg3veY?=
 =?us-ascii?Q?kcW5HuutwKuB6dacLdUrb2//BbiGCRQXZwQsQp79wr0mf7yLkfzdWmamyLTY?=
 =?us-ascii?Q?ZUMWY/0y8/LSWrKvUwghhAvVJKe3fv9xNTIJzorMcSX6m9ayXs0BvTp8Grll?=
 =?us-ascii?Q?sN+AWC12/0aZLt2OMqWYhGpz9INY56TFAyvvH1Xy2HivFPKpMzz4dOUmIEBE?=
 =?us-ascii?Q?ynYBqOArNFCZdIODI3LnVFtqHPElGU+E8ki7YL5KTmLZgHGC97BJZrxZigap?=
 =?us-ascii?Q?/KYuUUA48DWjDQUMYrV1nfGFqFe2onEGS8crqPwGsYUM6X9MprGJzs9Xv2fa?=
 =?us-ascii?Q?JaT2R6M1efvNqTnUZDpd7V+vFk1e2/pqa37DivtOAR5iuUENt8RqurRBTIjG?=
 =?us-ascii?Q?AOe0d/CQSrr81RinyQnjBiJRA1+aGv8h2lfaLva7fIhhTcfihuU1m4V+Hj+Y?=
 =?us-ascii?Q?0M/mcdG8lxHlUkGkLwY4ap6uQum8pUYcWBD157lrFZdQeU6iMlooFa2OsWEy?=
 =?us-ascii?Q?pvWTFBqRJ9EBuoDkJSdJItGivPrqe5O6UPRmon0tmhUwwgNbJQhj4AyNNBEl?=
 =?us-ascii?Q?I5jcXqrZMpPYyKz5IgFvqN8oRuf9Oxg39d8SsCd1Ob1zzZ4Saxi3GvUs9ApA?=
 =?us-ascii?Q?nLdjLaIV4EDg0GyNGAuYKItH+rSJvtBUFqvhWBR26H7sYUd3jpq8JvFKU+q2?=
 =?us-ascii?Q?C7yWNYTas/Fk8rIjXE+0wR6O+96a7Cig9DvI3zuB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29409921-2197-44b3-37cc-08db30fee5fb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 09:12:34.8477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXL4y4Fm545cACn+rRxggVP4Pz9AlCDKvrj9Brv3W6WckO2UmXDB7Quw4GhVtViMPw1giqPZVIX80f2xBjQ7+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7725
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Convert the binding to DT schema format, and rename it to
nxp,ptn5110.yaml

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Rename to nxp,ptn5110.yaml
 Drop port property

 Note:
 There will be dtbs_check failure, Li Jun has a patch to update
 driver: https://patchwork.kernel.org/project/linux-usb/patch/1679991784-25500-1-git-send-email-jun.li@nxp.com/
 Then he will also update device tree

 .../devicetree/bindings/usb/nxp,ptn5110.yaml  | 72 +++++++++++++++++++
 .../devicetree/bindings/usb/typec-tcpci.txt   | 49 -------------
 2 files changed, 72 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/typec-tcpci.txt

diff --git a/Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml b/Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml
new file mode 100644
index 000000000000..a940815ebd6b
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/nxp,ptn5110.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP PTN5110 Typec Port Cotroller
+
+maintainers:
+  - Li Jun <jun.li@nxp.com>
+
+properties:
+  compatible:
+    const: nxp,ptn5110
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  connector:
+    type: object
+    $ref: /schemas/connector/usb-connector.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - connector
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/usb/pd.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        tcpci@50 {
+            compatible = "nxp,ptn5110";
+            reg = <0x50>;
+            interrupt-parent = <&gpio3>;
+            interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+
+            usb_con: connector {
+                compatible = "usb-c-connector";
+                label = "USB-C";
+                data-role = "dual";
+                power-role = "dual";
+                try-power-role = "sink";
+                source-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)>;
+                sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM) PDO_VAR(5000, 12000, 2000)>;
+                op-sink-microwatt = <10000000>;
+
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@0 {
+                       reg = <0>;
+                       typec1_dr_sw: endpoint {
+                           remote-endpoint = <&usb1_drd_sw>;
+                       };
+                    };
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/usb/typec-tcpci.txt b/Documentation/devicetree/bindings/usb/typec-tcpci.txt
deleted file mode 100644
index 2082522b1c32..000000000000
--- a/Documentation/devicetree/bindings/usb/typec-tcpci.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-TCPCI(Typec port cotroller interface) binding
----------------------------------------------
-
-Required properties:
-- compatible:       should be set one of following:
-		    - "nxp,ptn5110" for NXP USB PD TCPC PHY IC ptn5110.
-
-- reg:              the i2c slave address of typec port controller device.
-- interrupt-parent: the phandle to the interrupt controller which provides
-                    the interrupt.
-- interrupts:       interrupt specification for tcpci alert.
-
-Required sub-node:
-- connector: The "usb-c-connector" attached to the tcpci chip, the bindings
-  of connector node are specified in
-  Documentation/devicetree/bindings/connector/usb-connector.yaml
-
-Example:
-
-ptn5110@50 {
-	compatible = "nxp,ptn5110";
-	reg = <0x50>;
-	interrupt-parent = <&gpio3>;
-	interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-
-	usb_con: connector {
-		compatible = "usb-c-connector";
-		label = "USB-C";
-		data-role = "dual";
-		power-role = "dual";
-		try-power-role = "sink";
-		source-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)>;
-		sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)
-			     PDO_VAR(5000, 12000, 2000)>;
-		op-sink-microwatt = <10000000>;
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@1 {
-				reg = <1>;
-				usb_con_ss: endpoint {
-					remote-endpoint = <&usb3_data_ss>;
-				};
-			};
-		};
-	};
-};
-- 
2.37.1

