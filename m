Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFC26C6004
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 07:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCWGx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 02:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjCWGxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 02:53:25 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF702D162;
        Wed, 22 Mar 2023 23:53:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOxE+YMIWggYg85ZOof55vBVVynb26jY03/eQtgSFMatVpLG0fccYxdYN4jPPUpCNWiL0fTQUx5gUiXuekM1WBNZxCRzH5eU4JA92a6JpkujrtxcYK56OvoHzlTQ6gwGaW6or+GQPk2GNr8TtAl8XW2hTahvUrWdNwDdXNfW0jbNsAowVYHDrZUSMGEaAwGjtiET/PyMd2LAfPC9cVgTcSeY+xr7U3IvHOIgLPZ6PZe+U1teJZNumvQ+QDxpR91ugs1KER78cJNaGQii2xNVPfD/A4o3OdGcBLFbtTfPFJHYN1V2EX8f62pwmijNxX3ywhT42XJJh/azj/TKYzIhcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsy85gB/xyFNmV2gnMmtIlbpYFhB5b8PuV+NZ2RJKgM=;
 b=O0Z+IE3JYMdCIYQZ5Eu3QMJU/0vnxN9xX+ycW4END6wEn3QhZKAdFL0t8xXepZ2Lw2qZsbpYo7uub8HqOFQljtQeLGbat/Iy4vPBjw+2yuBN5AIjwFOKUxLSCsP8KWZfeCgcdzRzBhAAalV0zJxILK3tTKFsHzlTA9uYJbKnLAyqzybxJ2zn+CbUrvzVhvMcLm9/PDgVGl/M1JsFZFlNabnbWGNpWbniBc7CGxHDSMTPxpauQIYyxqwGz9HkI26NdbOU3zteCZfq4PxPTYxqZhkNPqNYp1YZMxj7trqrNqdiJ2Oqj4oPd/+XUbBMnYfWd3F+zAYC629OjJbNEftd9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsy85gB/xyFNmV2gnMmtIlbpYFhB5b8PuV+NZ2RJKgM=;
 b=O+763+wtMJLPym9j7AVj8eWJcAxemv+BGnyNNfgR31FVs1SZZyz0lMEtaZ+6FZ9krI5Jahp1KP/GrDYlYL6zK461axdlz6hn2PvnHQimDl05pmqbbMPS4Hv3acq53M0hqBFxrXbSaKDOFjTkaES5tgzJe1buepwoBMn1fXvfE6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB9094.eurprd04.prod.outlook.com (2603:10a6:20b:445::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 06:53:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%9]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 06:53:19 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, jun.li@nxp.com
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: usb: typec-tcpci: convert to DT schema format
Date:   Thu, 23 Mar 2023 14:58:24 +0800
Message-Id: <20230323065824.3857573-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:3:17::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB9094:EE_
X-MS-Office365-Filtering-Correlation-Id: 29204a4d-d41f-4e38-6d8e-08db2b6b494f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MDORhCRaCubtQSEEvkKsOQbQWJ5OmfEVEvaPOSU6dtPvfQ0V/uGwHttvq7GwE8uQmDd+GNJErDPnlKOAzCq/trE1567fWTlVQ45bijwsoBz3YFU7rPAp2i7TkBKMmgFg+KeP9afRbsQvW+hKCzKW8hDs1Kau/PFFMJ1YVscCLgrU+townbUxGzuqpl+/+5RPWlYeAt+YBytM++QUXOBm8gFrGdkw3+xLfUSdG+xQnbfdeU+pvduKBqPqQill2IMX9H0muKIdpSQYn+0MCCCJEI1Yz5gi77sRovSwOQ6vJfAvEmxQbO06GCijUrKdkiuz9EzTs6eQX/QjFSPtdPvUcKHx/cpLxG9MMYrW98bRYXYR9UaoMgJwOH2MAN0Pz0eL2ycTeaHsvXddtdLOR7T2a1WBdDoa2aw2SNG2iYTLLxDa5NUysaA39uxmgRq+ZI7GSmoWsZ1nCL3vYe8Cibmyrx+iGXQANdHv+dmCqRrIdgpBtbNCft98aOVEIpIdNQJENKpu4voWYw4b/7ymxMpkY2J4JOGAbkuPB0B7+VyFyvnPYaHrk/BiJ6UOXwQvWBmKHtUxiVCpJxCBo32ETgHaqmyLi1WN9GVy+xUYKUs4BafQdzkfwfJumKoszICyDc4EuGN/7RdwUxC3rbi9THafNBLBbJLn3T+12buuQZnzNWZGvdmBx7GGlt2Z+zf3R+WBmrjGktFGwJMKwmz3o2BuTFcdrujM0KzewnZ7QNc8VqQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199018)(316002)(83380400001)(38350700002)(38100700002)(2906002)(26005)(1076003)(6506007)(6512007)(478600001)(6666004)(186003)(5660300002)(966005)(6486002)(52116002)(41300700001)(8936002)(86362001)(8676002)(2616005)(4326008)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iUKUKhzYs+jogOt5QvQwj4jCOkGvOpU1dn0Wv379BbjmFy8mkwEMgZ/MerSa?=
 =?us-ascii?Q?qtuT/7mgEEsYQgnVHVWyc1CtVxUzOYdVWBeY7gG9v85MyYF0NJcsJ29ztJ69?=
 =?us-ascii?Q?sAYZ+8Cz/uykp3pLLhkTjYyrDWCBLGVQ4WOkVMPcbheJwTZT35dV0eJNeOGJ?=
 =?us-ascii?Q?tZGD6JC3e2yBZDBKoZAwQ0fShP8wpuqtRiLhML1Bc/5V1uv+jCsAPe9axacB?=
 =?us-ascii?Q?WMo4uCQ3pppOSNS62U/hdzcVA0TezDh/SXrVHOWTJTcptemLe9Wi17/LnFVK?=
 =?us-ascii?Q?8tYXoy+wOePjFDTjQbRnXRfO+uxXWWbQJNqSCrV6sLl9Ol+IQbYBZKLHY1hM?=
 =?us-ascii?Q?wui1t5AHbLS2xB7mcCqxlaY+O75T2P7Q97jyRx5y0/gFGei3m/PBldQnpMlG?=
 =?us-ascii?Q?ycQZqnD0qFqCWSTpCZZy8GJ4QpBa1zauSBH5LBzjuqzmD/DfccM00Xcyl6an?=
 =?us-ascii?Q?yjv+y/6ii3jZ6CIAmWc51qflfrYz/5YPGh7BNuy6a0o4ptC845qtjqEu43DO?=
 =?us-ascii?Q?4pet0OQW4aCLHy+h5QMgn9/gn8qzkT2Upid+qjjqxeaeSqmCuJZ0nbcPUyLJ?=
 =?us-ascii?Q?5RvfjpRI+J6JHChtij1mkjK4IQn7X9i1WA3w28aJT0QZU1tg8SZ8zttSPeZ/?=
 =?us-ascii?Q?/ratnSyVAmjg604iXprhTaVJEEoMoNByS0NIAW/ciTQ+3mEocMRCE1jgGzi2?=
 =?us-ascii?Q?YB3kK7Z0ZrcuPPLocig9GTsw7WBs4u4Q0WC5qXs/qMLuFnftLh9wDxQl4WV/?=
 =?us-ascii?Q?uRAaLnGIxEaOJWR+T4w6mmEmu9VkRk4Qk/RIqO814Ux1Ouf478cnoxlfUIay?=
 =?us-ascii?Q?V38RFiWGJiiv9nAzLqfxowhlSxNbgZC+uNFqY6bUpdXTHyxvDQ+6WHUF4dNg?=
 =?us-ascii?Q?X2wbfVeWQibqVVIuuRzP3hKY2AMi4qQ4WiNxOWzgg8ZKCe2CS/09UWpkk4eT?=
 =?us-ascii?Q?udQpS7iXah7cNvs9jvnuJ0/h6pJMmV9aPnDmsDxcsjSpQ0B9Yc3p78p1i4ob?=
 =?us-ascii?Q?oOqth2DLVW8YhJJuivpzCsyo8mQAta3sWTLWc4YFWDxh+M9P5vGz15J4n7/Z?=
 =?us-ascii?Q?qEU6F/e4kWmfa7HFBIHiY7Ro71fv7WZy464k3aHofg3PudkMM/rdJtHb3iwm?=
 =?us-ascii?Q?JcW/S8qg3jvZN2V1m29VL3v/OMBhWWViTrOLEts+C9PdaV28O8Iy4Tlw/xFF?=
 =?us-ascii?Q?px8mjj4GUTwvYsHjn562EqR1ckpleCb31LGt6IIr2aoPYKiGneArhRNAHG+V?=
 =?us-ascii?Q?yzJcrXHcjYZEloMzTEffQqdRuWIetdRRgNox6ElQj2OeFbHw9SdHT43xuZWZ?=
 =?us-ascii?Q?qe9ylwGSgcwhVXSoOHj4RNqxHZIYf3Z+FhEV1uPboycGb+63f+lkVPJEEuy/?=
 =?us-ascii?Q?FGG3AH9lCVnJTvfwWB5PLTvbN9zxINC1BwYH7m2/8Kz+UP2+CCS7sKCwtf2d?=
 =?us-ascii?Q?5mDXOopFSkBBhnnDsqy7unLw0kcL7Th5dSXQWDVqkI+DEa4qIckZDdKr5X7D?=
 =?us-ascii?Q?VqrpGx6nes46m61c2vx/c5ejO5SMr7afQ7wyI4PNTc6tSgYCxztbrX1Bcwdj?=
 =?us-ascii?Q?0F9MjuG/vtBCaWDkFbFiylbyK1IWjiD2rx0luGzC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29204a4d-d41f-4e38-6d8e-08db2b6b494f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 06:53:19.7618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zrJWA04CIFIsxzRdQu4j0AKCvmp5moeZWWO7ppec+cQZniMxqdrSUYVtfnN/uyQRDRCTJH6ckrPJkQxMPhCQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9094
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Convert the binding to DT schema format. The default speed is HS,
so add a dummy port@0 in the example.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 The default speed is HS, so port@0 is not added for some device tree,
 however the usb-c-connector requires port@0. Not sure we should drop
 the required port@0 from usb-c-connector schema or add a dummy port@0
 for tcpci as what this patch does.

 .../devicetree/bindings/usb/typec-tcpci.txt   | 49 ------------
 .../devicetree/bindings/usb/typec-tcpci.yaml  | 80 +++++++++++++++++++
 2 files changed, 80 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/typec-tcpci.txt
 create mode 100644 Documentation/devicetree/bindings/usb/typec-tcpci.yaml

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
diff --git a/Documentation/devicetree/bindings/usb/typec-tcpci.yaml b/Documentation/devicetree/bindings/usb/typec-tcpci.yaml
new file mode 100644
index 000000000000..067d3b032e3d
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/typec-tcpci.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/typec-tcpci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TCPCI(Typec port cotroller interface)
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
+  port:
+    description: This port is used for usb role switch.
+    $ref: /schemas/graph.yaml#/properties/port
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
+        ptn5110@50 {
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
+                    };
+
+                    port@1 {
+                       reg = <1>;
+                       usb_con_ss: endpoint {
+                           remote-endpoint = <&usb3_data_ss>;
+                       };
+                    };
+                };
+            };
+        };
+    };
-- 
2.37.1

