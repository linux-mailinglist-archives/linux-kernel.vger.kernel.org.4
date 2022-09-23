Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7AF5E752A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiIWHsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiIWHsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:48:22 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2052.outbound.protection.outlook.com [40.107.20.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5799AFA1;
        Fri, 23 Sep 2022 00:48:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWSivshtMmuD8pw4VIAti2Z8UOCOBvYJtiVyK6pXwQ+DIKGdLjmfpCqjA56XzDvsQvoVEROI4iHqy3Fzj7Y+wWqOqXsthrwZbnzU6rMqGsCfEoilHySmqrcR1J7K775NL5Z1zc4tKvC8/mQdD81+p6DM1fz2gJyJTjFifT+cOA+BWbOYUvYjffFrXorUv7TMo9eTMvuIJGkUMXtNAxSfP+Hce+4efSWqlpwXeEwy/ZqMzwWUn+8Td/iGEZvLfptLKatCJyFbc93av4B1MdKHbwtt7g3KZbxe9lcMo/1166SOyFz6phsgo7i52eKAV7YMHx1W3qBJYrzjnfxJkeZ7aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NU07G24Vro6nTWihCHEsCiboVMk2HiAcomwLWl7kRLE=;
 b=DRcDGXBh2jXOS/+S4O1E0OvPhdA0V3gy+mHs1lb6IYrir4Y8WnSQlu9I14HPiZTDcZLzz2dT+lB+lgC26HfrnQlDRZCr+Go8QBHsAsocTWkwc8QPuWvetTcK3K9UMr/31dFOGaU9NZhkP8gF3XOADTRwk42ZObo+tXRY/t67GT8/9U6DZpe9YMOgurevAiY1NfLgf5Rafcfl5UKZpS3plWXNPkfCA/W3kFZTWXrA8CvY2z/CG8rblKoMBLlFUTst82ZvV7v0nKbcGJWD1LW+8OYU/QuuRuwEHE7ZoY9/Cg/nbo0bLGrOfQZAOS4NoyhGppPz5VpxcFBveGkit9qxnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU07G24Vro6nTWihCHEsCiboVMk2HiAcomwLWl7kRLE=;
 b=a90HOWckj4d+zhjubrG5C0M/+ccfYFbGWDgF04xuCDVs8tEBYe8z7ZPd688oCfcmuX2UKYJuDJSPk/P/CGxKDjaj6Vf1zbCKylglRvca0hWxBIDtlaDWuwdR9QtDWqfdn0okXaomwR8G2qnK0LMMYX/qqXjNXjPdB2ycPD3OEsg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7203.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 07:48:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5654.018; Fri, 23 Sep 2022
 07:48:18 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        abelvesa@kernel.org, abel.vesa@linaro.org, sboyd@kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V4 1/2] dt-bindings: clock: add i.MX8M Anatop
Date:   Fri, 23 Sep 2022 15:49:42 +0800
Message-Id: <20220923074943.981127-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220923074943.981127-1-peng.fan@oss.nxp.com>
References: <20220923074943.981127-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: db1931ea-b006-47d5-71ec-08da9d37fac9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1R/uSBArr6YatNXpUwqEBbtnE5TMZ/QbCMjxJ5/LKqZ15n9LTQQPAeZ68zSaUibwxSh7sShAgCX0ZvApJrtpbYPkAPrbWjHyJVm7eebD/3UC8zX6Hvy7ERxq/WgFJfScmV7pTBcqMIyBjn1Y8ATSBt5tsp5WlzCzKjPnEZJ7keXfSOZ6ABdu6Y49RHInzEZtxqZFlspmrE5puLOtDCdOWo4spFYXO2gl+BFAF0ovZgTKOzDT4Sio+MZsQZmaC8tAOjAdmjmTC+YNxAKljOdJh+gSaR2hkPTLXWp35ObOnHAI2ZdSd/oAV+6yZO8BD4lkjn3mXnzrAIpzOpJLBHFQ+SktvbvGPqsWOWeN713pwvU1977BUIiat7+GQJj2wJAcBdRD42KtPSYp5FhS9SsIh5ylkWBsuXfCJOmL9mZZ6ikQyurW1GatOngdNE8mBTIw3KDauut4q3ijZNYkX3zscLY4b2uZ/HyzkBGwOGOtKM5qa5m0/oxDcrer/DHvK949oDmtaOvQoHDVeLv0PmrNPpfraqK/btq+i+QGx+1gG1X2XexbKPFgxpTb5ElogyFFMoa9NFHXAMfX6NE1OTPA/1PaNF2t3+tUatz7x8YF5F9m+j+k0AKjGK/OJodM23mtow4lRx4rTkhORdUzq66Zk3Rhezkk/ZokbG0FT2TxlLwENaiiDUJWQGfMUOzR3/Sr00WwWhlAo9vz8phxq6w+XF2juz+x9C9xeiY/FlfmOy926yNTHT+UYD+9qWJIOxapoq55MzGrTuFoHC+N7NNwVL2NJuwT8JPITUGhB5KkOxylVvyGOm12iXSDPO5r6V+2zYu/qMN6Zjd7ulTlkVDdew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199015)(2616005)(186003)(1076003)(41300700001)(6512007)(26005)(2906002)(52116002)(6506007)(5660300002)(7416002)(8936002)(6666004)(38350700002)(38100700002)(86362001)(83380400001)(966005)(6486002)(478600001)(316002)(4326008)(8676002)(54906003)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wwa7X+PH6L2KP9i+LxZo8yNVgkqDmZCeM9M+HkRy66WgS963kS3zBWUvGHar?=
 =?us-ascii?Q?K367LmY0ubNx7nU/QhAzmO5Cx1L206rczGe22Z/pdvfvQEuKC+Pp3np8vsh8?=
 =?us-ascii?Q?GvN595mR0+EzH/rqknwYyZc8KBsedpSYc8BW8v6R50hBEZoWd9/BDpcz/bte?=
 =?us-ascii?Q?dsiozt6VuPt30fd7gv6NeNIWcTXbQKLvJYr5d1tqMm/m7RlV32sFzkc86MAx?=
 =?us-ascii?Q?JKY9WcKFVTQNJLAMfnvFa7+lbwO8AZG2ZrD6yN1ciXa8k0DlvsFz2/X9ZlkI?=
 =?us-ascii?Q?wR3L4WPsUCyk1pFILWUXew/PNz3PrYC/ay8q00ttmVbUDWC5UnRrFr+iDVmU?=
 =?us-ascii?Q?vcQlzrmX1Sq15tkA5+xxhLe6K2okrMzptNPiicjObLzvy26omfHCOrWsFKny?=
 =?us-ascii?Q?24oAW8TAIypbkNJlMlJk1AGBcIXqMLmYgNY293d/SKnXgmGdiEWyVcIYwuBo?=
 =?us-ascii?Q?xnzfFyHvvWCRZUcE/ovgqFKjLc3+ilT4x1KwHUn+MYB43ZiILSpCU77r082d?=
 =?us-ascii?Q?O711SD6WGAG/HBjwtnXayylNWoJRQvHshqO8Xu2p99a83/AWtM/CB1oaHYuR?=
 =?us-ascii?Q?cmnAFEywlfxCjPj5ATW+qJ3giae4do3ruRDJdNsR3PVU5fmoxQvUUTpsesFN?=
 =?us-ascii?Q?gNk+fYSeJS0gKatziybXhnNYFjPLLTakgvl65wnydpAxNm7gDXCJ0mELUoAF?=
 =?us-ascii?Q?5lO166xZJ/K4dWd2mFbUhwVbHEnMD1SEPmXesj7FJ/3W//aV+yCxwlyyVtlL?=
 =?us-ascii?Q?OW1EydZw3LndshWGzqPGvY8HeVABrFQmDQD9iBVsQRTmQBajSGc26tFmkCvZ?=
 =?us-ascii?Q?S/VsH3ePU1IjuQr35HW6zA3WTbJbYOn4XYtweN99OGtJkOyP3JkKj/+hudVS?=
 =?us-ascii?Q?hRbXkoM9u17QhYD6tWXXSO2B0T9UUEGYyPPsZaJsZDE0+2AgTPoHPP/FJxjG?=
 =?us-ascii?Q?meGZb2HnbCtTs70LFgrGjNqxiXC7evEWQi0EooxCyC7uATwMbhB1nvCYOa33?=
 =?us-ascii?Q?nxt94A31KvPXdiwclqNDEwBbiG/k4z/xpXR9WyYkpGR0dyBVa2Xt2f32RpSi?=
 =?us-ascii?Q?MhlVv0eDC7KrmPvz0d6zF3BgrHNXnfRRkvWF05hJcBiMdrOBHILmtXhvjytC?=
 =?us-ascii?Q?tKrrGx6/jP+v3MxLJ6pkfNydv8Jy6IPPtkaCZLxoOqSiwNl4jZymOVMzSNd7?=
 =?us-ascii?Q?UedZ56CdZYS9SaNi7nhMr3jNiUQLKejGOAV6jGhmDt5B/8YjjLe5wxjGZQ37?=
 =?us-ascii?Q?EvOSrhFIou/btg0c6ThId4tlUptud2dtJVIdbFW4KyyMRXpnPd7bH5snBl2O?=
 =?us-ascii?Q?S+2ERVMk3xzHUEy6T2708rSyrV0CxHuduuMXDBzcRzhlF1IArtoz/n1Kq1FN?=
 =?us-ascii?Q?OpygR0xNjthIVVFvpNbXQYRRmfudu1pCd/fWvj3AeP7+5NJUokEGSUeNszuU?=
 =?us-ascii?Q?Q+TUtWyrJZC8WzBPUprWoewDieut1m+9MzlkrVXyjBdgLdhUrsk8w21g63Oa?=
 =?us-ascii?Q?zoFLxlC9sqc3jQknb0U6uHcsRN1NcrwB8Am5BVKTdcfpJKNXwvN4eEWRUsOq?=
 =?us-ascii?Q?gCDiX2vKGhGNV1TaCz86BgMzIgj1djEvHBINwJt1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db1931ea-b006-47d5-71ec-08da9d37fac9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 07:48:18.4645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RkEhbSJWmmibS1BvJPHJbW3dzb6BGYRGBWBqrbna0++CP0+8PyZ7t5vv5cp1/CQ8CY4NmAuE/d2P4ZKBJurCow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7203
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8M Family features an anatop module the produces PLL to clock
control module(CCM) root clock. Add the missing yaml file.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/fsl,imx8m-anatop.yaml      | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml

diff --git a/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml b/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
new file mode 100644
index 000000000000..bbd22e95b319
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
@@ -0,0 +1,51 @@
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
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    anatop: clock-controller@30360000 {
+        compatible = "fsl,imx8mn-anatop", "fsl,imx8mm-anatop";
+        reg = <0x30360000 0x10000>;
+        #clock-cells = <1>;
+    };
+
+...
-- 
2.37.1

