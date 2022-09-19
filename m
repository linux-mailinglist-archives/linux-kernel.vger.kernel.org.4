Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EFD5BC2A2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 07:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiISF6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 01:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiISF6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 01:58:13 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2066.outbound.protection.outlook.com [40.107.104.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0EE14D0F;
        Sun, 18 Sep 2022 22:58:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVxiC705GdFhZarYye7uxu/+RJnIOtudna5qvNFcvNIO0+4ZUt209bXo1cHc7tqtPmw4s2DLMA8l7p8iFjDQtO+i1Z8CuLSfPgN4H84AW9RdIFqG6SQFv+Gk/iIB55s3BCMb5mBAG+Ypz8yMTIkznEnHPnkofAYBGUMGZMN3ALhOu8l5ii51oulxPeI95cIH6Y93I054+N10QxNTepvS9d8rPC1thXH7LS56oIJ+M4a5dtO0+FgMsetx/F0dKPjPocx+Od1TFqkfwzrc+d1Q7GFCxhmdUy7zAdCS5/aCTeEHPG9CS0qKBeCJ7Sp3R+pEMi3uK4jhnOYpWLNgPkFsgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7NHiIh9HrZivhLf1BHBejyRACy9W+rqMlHN4aukonk=;
 b=E3BpvqhzuUmZ/EMg1qFnWhvApIx+C/CZBTFzS6T8/Auo/BmmgPE8xFyjp1Te6niQoLJq8zoZd/5gyosd37CeSpfdOtIZxaqtBSKPMepFQ55x2ezzMWfJL5+4+KP7q2D5Nts6soMDFDj6ofkU11rfuItusQwNQoPhvST+MkeYdEpz7U+JdiZhTriDPBQAt3jaP+AEKP3KB5xWtB0QLPJ2pnqRjBhdg2wU5BLk5C0AGeAuGQtsSwaE9pUveJRp/M2t1FiuB2YadNjlGldGD7YaKBJP01p4X2U4u8cEVS7vO2JFhwSDqt6rLMH9XFpvmWiQ8Z6AKP7BYOgKaDcZE7Id/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7NHiIh9HrZivhLf1BHBejyRACy9W+rqMlHN4aukonk=;
 b=jEQgQrj7A6TSESfmUE3t9Ys0iHMED4r56hYjHz2ArMFQqDgfYun8fKLATDQBvpzH8aR4eG0V+yyY0aDQj0O6+xEgfQINktmtr1QP8C2VZ8K7BhyvvP0xKHPyyHtO/dTMcgBEHSxLIaAiVOKPI5qsJ63OKjUKgPdmeogkQ6hrMw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7783.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Mon, 19 Sep
 2022 05:58:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5632.018; Mon, 19 Sep 2022
 05:58:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        abelvesa@kernel.org, abel.vesa@linaro.org, sboyd@kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3] dt-bindings: clock: add i.MX8M Anatop
Date:   Mon, 19 Sep 2022 13:59:04 +0800
Message-Id: <20220919055904.1659124-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: a898e486-9a21-4df2-9fb6-08da9a03ed78
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rDy2ww7tOAL1RRvZShwwy7E1VkCilUWwZgcHViJcvH4MfX1pu5+Kz6cR/qkAIUihTEkMNLiqzyQaYOhcRbW/Crugc54cN32BdBhKFJ2f5yeH/wx8CU4Ec0O858wPjBlRdW092ewcA4hLhc/UqV3E2ghOyI0e2SibHd64t0LpQCncwrvt15QQzs1t9KJRS9yYKScL5P2W/HYo5tyQqB7QkPL2kAPk3bKDcy3iaxxrMtxTEs1aFE/O4i9Enxy3m8B79eSmoxdZgnrJQAW0uY0kWDIGkzxPsb3ajO9Ez07gcrX79lmgxIP9UIWlcjF3M8CVgx+zHGSaAqw9da+Bly+ga2TXZvSwUo3R0QwO4g6jn9+D94a8wtx1ItgWwzFr58jHjeXEwxsK50/uiIwxZbpLCe8sFr41aj5QbMHI29qAgTT7m36B+urXXU+vho64d/JapCS5g6Ti3z+55AIW6t1P9uqrLpZ3ELCWQcwOB4YINky+QNK4GLzQtxctV04Vly1rPqQWUiCqbqAYgyLMTqmni8TebKRt0XB7LO8SU6Ff0k4uONn/m2u0u7xE/Pwn87vGJIR/68bkDh0bRg8ImE/W5SAQ20NhHfg18jpmi9c5IvMiahbsSfLUjSdLHV48uA1HEy4XtJZVt0gerx4B/FsveRDqdSG2IuqfRJH9El/T4xwRgEGtiw7CM3ylM5fzMYE7DEqno12Wjxg4M+5u2Fp23r4cyNaTaqLNzwmjLM3XY9HieG9FM/4JcaHsDfjr0GzomvIe58VPKw1VawlXt5J0k2hQ+KNlhQFcm0TPc+76ZP6Y6x3JpIqnIkmDHeiy3YkvoaaAVoY7imDc5rensUs6Ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199015)(86362001)(2906002)(5660300002)(8936002)(6512007)(7416002)(316002)(83380400001)(52116002)(26005)(6506007)(6666004)(1076003)(186003)(41300700001)(2616005)(478600001)(38100700002)(38350700002)(6486002)(8676002)(966005)(4326008)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a5qG5ysNUGxjffB/RiP55htf9RYMlNUuAHB5TBFZpJxbHuABwm0/flxzIGEx?=
 =?us-ascii?Q?FUOKykaAdhMifLT1hrL07s4ZtqblXIZcHvqAmMaU+eEN7Y/fsCxq/MoGwaqe?=
 =?us-ascii?Q?DY51+7KGlMFetGx7GVfsPp3UU8RxC7NAoWLO6U5TA7q9vxdoHDD2uHZts1X8?=
 =?us-ascii?Q?TfgCkp9IcY1cDQ1zkw7oQ2YYC4kLhgpvcc492YeEKHWWBTcdCI3KZPX2iuHe?=
 =?us-ascii?Q?pcadDZtVnDwJTEk7ScYIO3sGW/08U4JSpbGfOXzDCCgdP5MNzV/l8TfcOkFC?=
 =?us-ascii?Q?J/TLE3Bsjnsi89SlSlIHL1KFNtcsdBDcpxtlDvRpK26QX4c+vQ5hDXdgPhG0?=
 =?us-ascii?Q?MWYfFu3zeKS5aqJeRL9tvJPklgj1XrRV69X6V11oaL212TAhc8OLXRsQLIpS?=
 =?us-ascii?Q?zNh3C6YazfVI2eIeMjwZhtvLYn/D7PMRF470ZDN91ERgcnxepbXeNDWoXu3j?=
 =?us-ascii?Q?J6VAJ9YncKewQKHtKHQDiCMRoaii+IFovBstEpnOXEjWUV+Lob3yQOf1SSJG?=
 =?us-ascii?Q?zST4Himx432Szq94gIH5jDKHzsFzI+3bXQw4dtOvtb8hSuMNW+eI4gEacOlh?=
 =?us-ascii?Q?EWHxTB2kSyzNWZhaGev4HWnzp/Vi8OVtswRekRKykgWjPJJp9Rh3D/DrZe/Z?=
 =?us-ascii?Q?mgKKyh/tC14DJ+CG4hMyy7t4mGwCh31KDuYbeCWrW80Lu9OsECi6a2xe01Uw?=
 =?us-ascii?Q?pcUvQ37QDC3f3mybbIeqY9EEWqy4WIHY97BvrttaNmgnysp5YqyWFR3xrDqT?=
 =?us-ascii?Q?SnPMdibLuNmTVM6TZKEsn/bNEv+aWSgRTLFRXZh4txiN7OInyHwudNu03yko?=
 =?us-ascii?Q?SI/LDqOC4KD9zoI2srVMyGa8udY8STnmz9ovIdutH30Blq9Vc3oIqQI82Zsc?=
 =?us-ascii?Q?cyxHCebG7ij6rlxhq9lgBPQwq62xP23lDY+93dSJh18XVo5eEHUJ7Qb2GwGt?=
 =?us-ascii?Q?uF9FI7YAaMx30ydiVRqkyoI4tmSQj12yjK2iIoOfPvFjcyG2GOP52dJ7Mke1?=
 =?us-ascii?Q?b1lPPgStVeIiUmA5amlLAZgyX/i7ytr1KgYjuFI9D4yvBwstBXOdDiuOkCxg?=
 =?us-ascii?Q?wlxoEK1stAoQeYMV9tnK/FufXG4nU8VRjvnGPxwFQ3aHq7Aq8nezYtjJILHj?=
 =?us-ascii?Q?0DFvFSLidAjnYDQLCIXcc8PkQyqo8CrepH3nqMWGXy70mCG+X65sRR6qzZdO?=
 =?us-ascii?Q?4yWdQPY3W4f/t8WiBad+6aV0v7KF7ELgtZQ23GPLEX63EOD+EtcYLCBsJjci?=
 =?us-ascii?Q?nvAA5VWjcJ096bUn9GPPRSeUps4WQlGP1pLN5udYCmH4nc62shoFN3tCNhpa?=
 =?us-ascii?Q?kibf9WMAXUQtNEguAYu3LPAb7ZvuC262F92KNm511I0oUKV2OaPEwnDuMy/r?=
 =?us-ascii?Q?2yC5+pTbdKOdLWrKr0MQcYYf8KUv5loWuQiGld4iKb/uQHop+4vUztkAdxeT?=
 =?us-ascii?Q?Hg4pk6FUxnFxRf9LrWRJ7Z4uS36+Mfg9FKWBD1Nbxa/P96JUUc9+XF7Kej4y?=
 =?us-ascii?Q?81DZFcoE/87Dv46+fbtJTOOA2AcJOUz9KoRlXx1qko7E0YVOjdRuWKRiRCUz?=
 =?us-ascii?Q?SU8pI5cfHQ5nSxtSh99exUd9jNnscey2HpUO0XmD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a898e486-9a21-4df2-9fb6-08da9a03ed78
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 05:58:09.0082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtnf287V4o6Kbc7JFvdQsWn20SUn3ew+Jd7WEyfoacTTfEUx+hO+o+HJMk3/h04RHsStOosCEMV5PTVDjr+Fiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7783
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
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
---

V3:
 Add #clock-cells property

V2:
 Drop syscon, use clock-controller
 Add fsl vendor prefix
 Add interrupt property

 dts update not included, so there will be dtbs_check fail.

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

