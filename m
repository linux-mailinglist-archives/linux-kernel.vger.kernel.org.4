Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3285B6AAC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiIMJ1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiIMJ1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:27:39 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150072.outbound.protection.outlook.com [40.107.15.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36013564FC;
        Tue, 13 Sep 2022 02:27:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAJRJR0ZycQVfW3VNQufnhPsN4164L+Zb6EvvNPO2n3V9cefLIJw1ctnaAhhP1nX5A7Y0KHSELziGcSK8Lz+aAfgQJqFD/uqSnFMGZaN9jHDEjAfJXw4xH6JDJDMtMzaJcRCZWM3ADn1BhbNq/I1SBEAMGC04geuQjY0izO9nY7nfxiqpzs7PynTLf5wshgx3OqliI9ci7BrXRb5VknoqBECL67KuFKTdieXqNDZ6SxIH09AKiVIAaC9ICGfpe/qapDVUH4+cy92LCbeMx1HmR5KSAf8AQ49i9FH+Va7DOgnZSGiKa2zYTuHJV4MNZGnM+PRWIB1Ldd75o9RZf9Z6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCdMU7hOc5jim7gx8cEvOCEqNTqfA35WFAkIMUJFVwE=;
 b=nbkhmL+6ruiB+bnjorj8yvtMMT2QqiUtC6ABm4y3RQYxJP/ODcK09BzFAg+538qnrUKhmFwReTFsXqi88b1UMzdcqy4BSmQlAx1MbHHouflDEExv5+en4fV2xivxde1goMp6oKS2oPfeKOB61P/4R5cAE/v6FojHTDqjnkx+8nXNSeDCDj5OgVIfINa+loaOWqYjEjflIuMoIdL/Hnp46GIb9SsS4O9/7Agnr3hcFZm2mH8jbllzdU+W5XgOWREzXVwn3pH0ypQWJAIp2mg0vz5ZzcA+3qq/zZtpyXv/H9W2bI7cDVd6FlgLg/HToCYAMJxtexAVIvyEXq/RxUq6GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCdMU7hOc5jim7gx8cEvOCEqNTqfA35WFAkIMUJFVwE=;
 b=Q4KYZX3VdomlxefxZMFSzmmzkcCU2omDss5+h2zuozRwr62bLutDFbCOBfTqHxeNE4ZcKgkyjGg+fJGrFw0HPiNxG/XafeYmiEgF5jPiGK/aY42cob4liuhfaLcTBfAy1jxEFDZWF5Kp9LaF1GlGLh0rnSyfZRsdE8cj3p6TUxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7234.eurprd04.prod.outlook.com (2603:10a6:20b:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 09:27:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354%5]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 09:27:33 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        abelvesa@kernel.org, abel.vesa@linaro.org, sboyd@kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] dt-bindings: clock: add i.MX8M Anatop
Date:   Tue, 13 Sep 2022 17:29:08 +0800
Message-Id: <20220913092908.1708931-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0082.apcprd02.prod.outlook.com
 (2603:1096:4:90::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a1ce82-6d66-4593-e1d6-08da956a2ff0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YrQfAGrv4mhIitbDZrU6czJTTNbsmYFGTdxEpugQOddoS5JfOvUL9YJNjgkSijFxVjwPQ9+2ddR/YrMqEib9+cUUhFi+Cu6l6sr0XFGaDG2yl7/LUBNlCtpoAR0LmYSoJhomfEsEqRu7uFtkqUgIXhxDDmIhYAV2ZkQqpIVEDFzKP66M+KAAykC1yvrZ0dVHJv2sqx6CUS43OkvQcurM5lAr8SFnpDpRMz4lWc5+xftmRcwGppDaja5eabYBiiE1uLuHWigdijQA5NJyAYITb8seBeI+KoemkARZ8825tKmVES9jL9vl/2nZeNt0V48QZo++EJJhlei87zIoTtKBHy2TA5gFX9hb6M8kO1qaziu5kiytHcwuEciAFOv3ZP/O9IpCEnkwirEeNJaNwKhzv6y7VGw6A7MaLKOlZUWmTwMa8i6CpybYcFiQD+MLRtXlM7g6F+Z02ICNltUObArI96TIrk9GfEpPRKwmfqi0dP1kBO3Gktn8klVzxaBR0YMpKuaQv9tG3cqNMO/34aOLG/qQEU/pfW2kXYNgB/ZTLtMplBsnoROBfr+TluX9qcCT6/1nJsAIb4RMeRBUzc3Fth3OhUot4axMJUzYW3BsqIttxRVba65FosZ51UFNbj8F4f8gsSGHtlDC+nLkxcUlM9w08ydAUt8ks1pIi4zCbrtw5utWraHuwzIc12MShs5HPhsmNCoWoPHCsH953stG/rnn+mEiVCGWDQIFpxe3vEQ6vtO4G7G7g5nMgk61h8Dc/45bZScU++bOoCtP3A1TLY8Wa95FxTbgSrgQ+8R7uqZRODq5Ip2v14R9ZAsn9O8YnknpNmeK7XBqHhE37ESyEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199015)(6506007)(6666004)(66946007)(2616005)(38100700002)(41300700001)(86362001)(2906002)(478600001)(966005)(52116002)(1076003)(83380400001)(38350700002)(7416002)(316002)(5660300002)(4326008)(186003)(6486002)(66556008)(8676002)(8936002)(6512007)(26005)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QXtE9gu8t6g8+tiuXJtE5bFDWhrm68UXFKphlYbrUrF1lm9kGNH+TeHZEezZ?=
 =?us-ascii?Q?rLnHD4TA2mINgudR+Mr2MKE/Pu5nhvBWlEFLAq1cIEcXN7YpW/4AqfLTPfNP?=
 =?us-ascii?Q?Y4v+zQc9Znti355csSeFizWeqWweoqzoF6loSlbRHr8NuGk8S3mdIGnIHkEq?=
 =?us-ascii?Q?DVpUCjcR2q1LtcOX1OzLfR7zkmHsC7Pcpeu022a4YONiTKtUfg8llkdGMcK1?=
 =?us-ascii?Q?eCvNDDlYcoSItatLz9R9ojBTMBD7Cc0hMPOI/xxp6iyJV1woqzFrKftraNFd?=
 =?us-ascii?Q?vWbc6hqVRHjNw7S+TqgcBsvAud2SE62xhdMfsDObqIEoBpop8GI31l9nLdZh?=
 =?us-ascii?Q?lXerizAzahOPKbzHb1ag8ZKy9jvbYmOIzC/6oFqCWQ2EkQL2ymyuAtDpthgs?=
 =?us-ascii?Q?OejvZsV8WTZLLYtzGlN+214gEfR4gWGGT4E8JWxYjKxrGHSN2uZN/qruKRmS?=
 =?us-ascii?Q?YKLwvhZBItUUlXAS2oIk/TnAylHQy/6ybocHTgsxfE4/DPa017Sk/OR2h7Kw?=
 =?us-ascii?Q?TGSWpn+/JcPS2D7wGIcvAArLT+AHMH3CZjpO0qT2W4mFfAMzFQo+lvD7XBgp?=
 =?us-ascii?Q?Tzan5eroD6zqVs67EwJKp8qypSPo9JUAZWxuCLs2Mz/V/rBN4x/eXyqW1+2Z?=
 =?us-ascii?Q?hsIsFCQLbbmYxPHZY4NgpjmnrUfGBlMtX6X/NCHOSwOklnoqJn5LlkVvbMjk?=
 =?us-ascii?Q?NPnM4/4KUN7FjNQXYGCcItF+l1Dee35uPfFj094jdY5uQ6exxM04SWybakwi?=
 =?us-ascii?Q?PCP4ZKBawJxAy1IJMm7fJjz6hnDzklKR0tazZ0xWzVeAOGet52m2pTM6Hm3C?=
 =?us-ascii?Q?Y09e2DOMWfPXdAsCzy1SWBKbFSl75b1eSIuNTuk2M+8ZK8W/ULa2EKSdVbKc?=
 =?us-ascii?Q?Wo/L6yZB/WaopPbKAF6T6Jqawccp0834MweqDh4BWUmgqZ9tSK1tw9jVvdPF?=
 =?us-ascii?Q?u0zvKqqzx2sf8vW1YPtHrb0HTf8fAr3TWS29VJAiNHS7HOPH80Ucx3Xqa1zn?=
 =?us-ascii?Q?E1Is1fI0QF1VbAKJVQ3nk7QDSCQ2Lui+Bs6kdvditsBeS+BjX8oeIBc5DDKT?=
 =?us-ascii?Q?NZibTZMYPBdhQFpcY0xUWnoiUHqzdMJdPievLqQzsOTdiHarAnIksG5S0gVN?=
 =?us-ascii?Q?p3jvZ6j/iXS0kOd2zUthx298/g+9CeKscCrKU1Zj8j5mvK6+aTMyaxcFFdOp?=
 =?us-ascii?Q?dGGy9mfCJ7t1Frty6w0JSKTfKg8vy/h2npfo3pDT8wIgpENKVg3hMz3FrRao?=
 =?us-ascii?Q?1ihTyDy/iWWUH12kT3pOVdyobVDHCIiEkqftwnzQx+3CURJPJO6To3QsB4gQ?=
 =?us-ascii?Q?0tarCoAyhRhefhbq+L9cwphq6rNE5FFgkpqkR5gFTu5u9Zgw6W/4GlsHUB4q?=
 =?us-ascii?Q?ETiNLN8jz+oKJwVnN7Hx8f4TpVWfm84k/fUiG9eh5xTPhGqH45ayceRKjXlz?=
 =?us-ascii?Q?ngnDIbTIGNYzSXbwI3dDHem2dEwONMhhaXMhDT73SOOnhYY4Zvx89CWfivY4?=
 =?us-ascii?Q?juhawCryPW86WsKpBhSeTiylS0ilELzdS+z8cDYzzsVNLqFeTb+x3PMGRovM?=
 =?us-ascii?Q?hwkI1JVO+henP432RD75Xc4sRQyvqHM3J1gPmM10?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a1ce82-6d66-4593-e1d6-08da956a2ff0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 09:27:33.1442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AAymTL0pAyGPbn5Yh4XcVvYzjad1HVeTq9+ZvvNedEEhJiYuZjXy6coHixu83V90kvlIie551ipdulUgm6dxFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7234
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8M Family features an anatop module the produces PLL to clock
control module(CCM) root clock. Add the missing yaml file.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Drop syscon, use clock-controller
 Add fsl vendor prefix
 Add interrupt property

 dts update not included, so there will be dtbs_check fail.

 .../bindings/clock/fsl,imx8m-anatop.yaml      | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml

diff --git a/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml b/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
new file mode 100644
index 000000000000..2c0efa58d898
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/fsl,imx8m-anatop.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX8M Family Anatop Module
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+description: |
+  NXP i.MX8M Family anatop PLL module which generates PLL to CCM root.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - fsl,imx8mm-anatop
+          - fsl,imx8mq-anatop
+      - items:
+          - enum:
+              - fsl,imx8mn-anatop
+              - fsl,imx8mp-anatop
+          - const: fsl,imx8mm-anatop
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    anatop: clock-controller@30360000 {
+        compatible = "fsl,imx8mn-anatop", "fsl,imx8mm-anatop";
+        reg = <0x30360000 0x10000>;
+    };
+
+...
-- 
2.37.1

