Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894476C4207
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjCVFUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCVFUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:20:09 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2045.outbound.protection.outlook.com [40.107.15.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514B73B87F;
        Tue, 21 Mar 2023 22:20:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAscO4iOAaVB35aVlWNVj3/IGPlAPQTaTO9/QzxA/TJTBhRdiH15/5qTCCi5vfxrllu1Zj3SO1NY1i7dp6hnvZCpAHal61AD+bjBsxMGxvp7lXQInk2xQtdB0rDacJh6ppaRFNbAhG9U9zIBiUSAM8eifB/wf99LLJQiYdBWp/hhX13GDKIxIVvJnpDt86CecqfW38B6jqB9oWlXyWMmfpEKF5Im5z5XSZbSdjAmAR3JozbvLqdJOh9Om+1iLvCDNJiwZJENJcFzS42rb1SMeJ4JZBS/z4TJjmujwBxBCFXqSFHtviY3Tj8pazWPS1J5S2OksQqZd3Zpan/JVRX6Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QL6wRMx58EM+Rqv0F/Moxlbn6SuYNC/oCt+pMmG2Ug0=;
 b=dQLG+rAK2JU1Rkk9PFXMRIA+gUMwqYeJDUHZYEhj6/kJfgswXwChmb/uHj8a7vd2QqRtj3ds1uQOwBLYny2Vdjf7/Z9LsUQUCo/nHHldS8m+7i7BK7IsoA0n+TuzBbeLWeO9Pb2hJzrrj3msmegF+T2s4A7FCVtfI4ytd/6Xt4AnoIasORvyOqwo4kJk2/EQiIh0xvULjyajrtTPIoX9h9oNC7iUNINzjmdP8flGbF6YX8535hYh9XDgl4AYphYilKEn0VgBzrwQRvXrdW4XrprM9zZ/ULfA2iIloBfpxd9euUKVmRD4/fiG1y+2BTcKLksPgRqzztcEbKlbMJk/AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QL6wRMx58EM+Rqv0F/Moxlbn6SuYNC/oCt+pMmG2Ug0=;
 b=kuYTIlFDrhGcp8DZdiAJgSd1e4ziicrXms1A2nqnNKKHF3zgJtlZDR2YV7oyiy89SKR8hJzocuV7gOVur089RxyAdbItc3sdL4qJymQKEQzDTrEiGXBANoP9TRmm/PodLXMsoQmGdYEy0CrqaCXyKG3wYqCQVOf/dKdMcjKD06w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8351.eurprd04.prod.outlook.com (2603:10a6:102:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:20:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 05:20:05 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V7 01/10] dt-bindings: usb: usbmisc-imx: convert to DT schema
Date:   Wed, 22 Mar 2023 13:24:55 +0800
Message-Id: <20230322052504.2629429-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230322052504.2629429-1-peng.fan@oss.nxp.com>
References: <20230322052504.2629429-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: cca4fc1a-cbc4-4fb3-997a-08db2a951858
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tu1VczQZ11hdo/H/t+zmEZ/rIC9vzn2TEc2E/lXDEhcx1HAyX599ww2HX8gJLaJEZGteFi405X/dbU1mQs2EXu9ygZ+lFeuF2cbZ5Y8NZZriQJa9/Xc9l7BWv5hQ1rkl9ywmoWuVxUBCS28xWR4PbiMclQdVUu09JufySligxUz3X+LQaz3/woYniISGaM0x8GCMg9T2vecT+xY4IOxjVQw8UtjeLE1QyxBbMnAje3mhED80yPtLlVu2WzDtYrZYA5xFX3kO38hZwdcUNF1Ktdb6EAOdWNFWF2KEBYPaPPsxe5ACznMydEtMgKQFzXU9LmWhggEL80xMXEuyJG/vWQa9qSWWth5XcDHOfOZscniMfGRnOxVeePs3V3FAzh3yqm2RaerJaDyVRzVM2/I6MXIpX8a6cTAyzK4zx8eZXsNIC0YH4XIjDxAWq2fpZO7+Duv07j/5MbZ8F6ViXh+N7ggodwkp/K5dYyqttijKcf6jECgKzZ4txsuRnKZQkTm6LG+Nge3ch43HtrImY4L0XP+ZFiSSxYUfKxyD6R/mBd4x4yBrENWBUHICI3OcHillDH005c/3j1/7RGFMWIQB45bRz3LfVEGXgtdQFhwTFszHgpe+ASXbn/KyZG7I9ty+sgdTmqrTjgqQKVXb5rAGugea/jOmJLu5HSvI5prarSiO2RbRqmoWsbBYqoLbrf5OKCQXTvk8Dysb/SStPhHAL0Ps3VryYLKC33gdO9rxEGo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199018)(2616005)(6512007)(41300700001)(52116002)(186003)(966005)(6486002)(4326008)(83380400001)(478600001)(6666004)(316002)(8676002)(66556008)(66946007)(66476007)(26005)(6506007)(1076003)(54906003)(7416002)(8936002)(5660300002)(38100700002)(38350700002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MBYZ0JnrgNrDH9Uh1NQGaARdRxRKTbyCZT/sksbJrf4m7NI5+uH9IF75J0K3?=
 =?us-ascii?Q?cNzzXh35ePmTiapt3XfjBpcYG0q0LDvH3Yvwr4JASqKyA/hFEd9Ol4w3MXze?=
 =?us-ascii?Q?innDeWnmVmvQh5V5oZ1trirrf+Yu2wHo4X8R5Rq3pcRikVUbjPpm19lfaJ/y?=
 =?us-ascii?Q?gOPD4Y9ltK88ZMEPzkYTV4xLZT7VtoSt1iO4Yl+lMLRbKTbbRHF8YgYjEBcm?=
 =?us-ascii?Q?RJ5mti2BPRPcQZpCWaLMJ7P9ZTTnC7Vh/3apLysySNn9f3w7ZQFO5c2Lz133?=
 =?us-ascii?Q?QqMFqp3iVPwHqrXz+FNZOvXuD7ceXXVWLikA99ylLwsGWh2+3FjAKK2jIMcC?=
 =?us-ascii?Q?9AIuSk6sETYWaePsWoYXJ9ClvzDClKr4I3HBnNfUQnS2lILtng7TQy/r1mTy?=
 =?us-ascii?Q?2tkI0F4Y9FKVigh4k3ZCcxD3672K4GLSvFTf80BxPNl5PIQg+OW9YDgNe4yY?=
 =?us-ascii?Q?bNRiKGoGXkBFDNpJqQr7OtmTVObL40jHBYaHd3q0GP4rmBY62iOMdSoJ7rT5?=
 =?us-ascii?Q?pM7YbMAYAEOfHsguJ9/RjXVPZzCan/YwscCWsfxBb1uOsdpDxgN++/yxtYch?=
 =?us-ascii?Q?51b+xz/ux91iExAPuzDucUMiaaUWGs6A3RxntzfnH41QrlpVeXLJba4FFRWb?=
 =?us-ascii?Q?eqMjA9AoIGRT6IctiJ/QNNoCmTfys83g/6yvs7r/fsRDLh7wkwci7xyRWuuh?=
 =?us-ascii?Q?Z3m0VxsGhPJ0TU6NYixCGPZmHPCLMf/CvhZkdpnFpgeLZwwTkCg55hcNNzrG?=
 =?us-ascii?Q?Nfoh20u1SuNsOX6jUQx5BLcSE7lJddKgIyw2Nvs+5zz9vgSfoAbsPNyM/w6L?=
 =?us-ascii?Q?hLfLFDRsG4TtplOpQVL2lbyLDivx8IZU5VIRsVfK8Smt5khsA/i1Sg0WmJty?=
 =?us-ascii?Q?aguYX+t2f81tHcQvjkcyy62zOP00ozQlkbsmlcoLP2FI3FA52lzJieegmPkr?=
 =?us-ascii?Q?5CB8ODv2ao2OX1ArwTSUMtmC96ztHMLYB0h8vzL4TJmU9Z9eFfr06JDqQipI?=
 =?us-ascii?Q?jZ/fvMblDoweTveGUhQDpZOn/U7aCGCeYrr5Ki+JlYw9TGYjeVtIfmGYDnCW?=
 =?us-ascii?Q?poLPZkZvYybnlw8c6sIdheLv5kJqcIDBqznmyi14aRbOcFe7JC/BfqD9SLSt?=
 =?us-ascii?Q?OsLOT7awn2ePujkEIuSMvSQ1ezWzQb7hG/m12KNMlwntDQTgjb64HOka9wrQ?=
 =?us-ascii?Q?rQiF3Ta9mg4MWuFXxXEE14jSGdx3s/6mI+qgoA2C9iJpu6VNf1hvC/YaJNMy?=
 =?us-ascii?Q?Oe8Tk9cqltMDMwEP9yR8x0LF7ODVRBa67w0TVXyZhk2lfPLeUm52nM5Z9hbV?=
 =?us-ascii?Q?Mu0v6MPU/NgFj9CU4VcS/vrgtf8fHWez019mokOQN/t10e428hazYa9BaWdR?=
 =?us-ascii?Q?M6gvH/lyPU8sE/xfIy28fgNTifJ1hXdidVkYuxUiTHSEbJkF8cXz5v8G96F5?=
 =?us-ascii?Q?kxzoWx3CpJXtGA8FzJKCJgzlvufMM7lO9SioKZNTHntQ0X8StuckHPbLC+we?=
 =?us-ascii?Q?zlIEjmo9ZYKZwfxNyXNdbGL9wTvy9k8yy+jMFODqjYTdvCCq83AV3dpWqHaN?=
 =?us-ascii?Q?rzbt2NodcCm31In72UL8v8nrYPkjDuI22qi2ACj+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca4fc1a-cbc4-4fb3-997a-08db2a951858
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:20:05.3134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fx9fL0aWgUR/QG+IlyLQzGbtKOZSsM8pwm1o954BmFGCV9Q92je7FYqhWZ0BpI0ivKzwNPCcPcX/umRVw8gbRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8351
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Convert usbmisc-imx to DT schema format, add missing compatibles

Reviewed-by: Rob Herring <robh@kernel.org>
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

