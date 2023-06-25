Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DEF73D0FF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjFYMiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbjFYMiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:38:14 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF871103;
        Sun, 25 Jun 2023 05:38:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rz+LGjPP7SdwfO9IPyayn6PCW+OhzGTpzdLRvDx6fKTXV1K3TWwHsqHX+5xTS1tmLEXfmKCDMbpMcf6NT47tfkxXYK/c2QBY6ZC12ARhGjrCgmJwypHCe0gk3SNS1ZF0VXXxkfVHw/rPcgydxzWvSHxpB0d7SxwuCsL6WMiFyvung70h8pvtGYxEJBkDjz5s2m9MH98WsSfDPthEE+dtwqaBWOfmjGDOUwL+VLUtgle0s6AI6pAHVUupuS2lhhQcPhWr7PoYIHlkmS5oWuizkouYGxRYq7QvdDu+s/qTJ0EVA0Oa4iujvBuG14mCKktDi+2iHbdYz25g2XkRrFjiVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2yrT/CURC+jRUKMLj+94rdL66vKQu1nKsRdF8mplJ4=;
 b=JWZWRLdFflgdjr8fHZF5BEvLHx9PD441znFUqyQhFaMJ/5InU218eoQ2hB9Mhor8U74rpl+zP3/CGGOCx1gvTEcYLpF8xxL4JwrVGdwplsqSWhxwVVAzNvhSHCx0Fh0efvlxX4wA0ipSb7Y7QATT+J1Kkny0sP1gBNd1dcTtt87kLjxQBi4bbIw6xq8QXCZPDlEVcxKFtMc/wkXPfD9fklglrVkGal2f3zPqqu+4y8L3nWg0GlrD+x5dI6MZpc3ZbrGEwuY8hamWi/txivFOn+nb+jrqSJAsMPnGcgnxH0GdbXmfGrJFAgHrpVFrXZ/+dk9ruu5HznwpP7ImKCpJBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2yrT/CURC+jRUKMLj+94rdL66vKQu1nKsRdF8mplJ4=;
 b=WaIlvmqNEBAy8skg8j38hu8B6Z3uAo1lEv+rwwe/pUDSU7NVC2KBhKpasvJgzVZIpudi5dYUWv4CGQWYodSD3yWGwQvsfkN+bfVz1S+yjBXcUwJm9vg+n+6KneU9WBkPCAGrXXTIy2QAUk2vebatB3imHHrffCeeK/ine7uDkSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9314.eurprd04.prod.outlook.com (2603:10a6:20b:4e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 12:38:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 12:38:03 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH 04/10] arm64: dts: imx8ulp: add cpuidle node
Date:   Sun, 25 Jun 2023 20:42:32 +0800
Message-Id: <20230625124238.4071717-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230625124238.4071717-1-peng.fan@oss.nxp.com>
References: <20230625124238.4071717-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0111.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS4PR04MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: b026594d-4c18-45d2-6523-08db757904bc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i1OzeYYtVdZA2eHrri8PLHj7FIL/N38LZUsUgivQtlWUzL3Yl8J0FTRPLE8++2nbVsdDM0uSZUqVKUMiQXGPanGGKDGQu2CJ2jt9YOG+1j8QBH4wzShWVa0QjkpqQs7xxnVtIGnyj3+ArYK0au4F+4TagAVgme+OvhmbwnuSzt+nQFXKqc0LenHzBa31Ewhvc/BPU6rhRM2YVDoJ6xARyn0aRO8N8NkJPkdIqwtt55WJp3p5GEJU3od1W2AjeHUSuJu6U6ZFC8nzgwVz2TpgMlUZl5xiZ+mgrRC40sX/HbHAvZ4igh0Tb0tOfX8l2xdsHs6yeptah5fICHqDSWvpJK5IHNAZWx5aBb6NayMLMtgXAZM/y8I5jVV9Wr27Bw+8WOVerPzJoTYGg1RzTRB6lXSB9ODDu08IJrBEL/Q/ANF3occ18g48cWOu0Ca1BOKzJ8FldhShY2EjZ8CXZ0h7Q7sKw28ejCWRGCL/zi+Nmdd3G7jQ+XejpW60qLLOZnd2pvVsnUrH4TrTQBkDILOXJz8rIIgUdBY8rPChvjusM+4nS804LNQ/7Kux2wJMpzDw1qEXnlNyW0h/Sh/CJ3/x8PdKVS8mvF57CgPzMX6OOV8ci7hbWrif3Tln8PuKsKNblXdwSCE2IvYDAd7+9yTegg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(5660300002)(4326008)(66946007)(66556008)(66476007)(478600001)(316002)(8676002)(8936002)(2906002)(54906003)(86362001)(41300700001)(6486002)(52116002)(186003)(6512007)(6506007)(1076003)(26005)(38100700002)(38350700002)(6666004)(83380400001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uXSxJV1yu40cCe8Qx5MZGy0S21x94arUVyY2BU85SHirhloY10KND0IN3U0x?=
 =?us-ascii?Q?GENL5ZQgD4PIaIXEu6CQOOX2w/UeJ5I5mebGdwx1c/rBfyTa6TUplmkGNBo8?=
 =?us-ascii?Q?mx1ILd7u4KoovMURDfaNmLNcZ4yybLj3zJTINXf8IUdWGvJAi6MbtxLXwuqX?=
 =?us-ascii?Q?TaDUbTVu6qpt4Du95nmeuvKgUo/RxUETF3PsAD3zsN8+B74VoVsnbsRmddSJ?=
 =?us-ascii?Q?YfQ4m/jkxYcHjEbZ84FQob/00D1KexR389iQs5XqTrrkF035fUAKiBQyQo6S?=
 =?us-ascii?Q?y4njgOmccM1DU4DQqNHZBOxB5KgCgHiKODbXIG4oV6JjoJQeP4Vb0zKbrzqA?=
 =?us-ascii?Q?w/dhYbmKm4tooKOJC+3NMtqwgKOzZHVeqp4sZKciMKtTEOWJgvWYgCX34ppV?=
 =?us-ascii?Q?AV5U0Phc1AszvexwKFAta4z74lDl6y2zk1C17PZcLr2bDcbW9yzp9cw5+jyv?=
 =?us-ascii?Q?w2R+ElcoogrUx4onfajSCo69G5WV/IpgsVdigM0nQL8/LbwVEas5WCdpQy3q?=
 =?us-ascii?Q?qj6+GcHcMSR+9F2t+bYkrI56qT7FEbwMcn9ik9ZpkZZ6hBpN7vrZcnoVwcOW?=
 =?us-ascii?Q?FBCvlClEUpWKoJt0K6GCoev4DZuoZubIvWuRWK3fsym8JWJmWXk0ZepIT6GT?=
 =?us-ascii?Q?mn2bJC39PcwZoxkYVfOPR9XxDfFkjIjL7Na1Kh/k1Oi+gPlwxn2dq3eQO/qz?=
 =?us-ascii?Q?SzA7EzJeb692ix4HEPvVVS6eWB3FYhj4jJ6+brnvRJbkrkVM6gByjJ3yNX1I?=
 =?us-ascii?Q?h6MFTIl8yg16BSXuO5VpgKnk+Azh0Z32mC6VZhlKATvXPca/Ad8QcyLMo3GA?=
 =?us-ascii?Q?I+TYAheNxpBGJ7ZcBtmUOSVwYHdffr4jxR2SEyOhXHa+aKglFEUBK77hXVYB?=
 =?us-ascii?Q?UfXTEDX6JgiD4nb7zYHQ7jdeb5gQZiaeTOEAH+F/GoCcWc3z1DgAW6CbXCzP?=
 =?us-ascii?Q?zErVjnILHTJlHRApaXsjMEkNa3m1QW8Q6DGVgdihdFb4/NbshFpUcQDwBWM2?=
 =?us-ascii?Q?IflA1YhieJpJqaG8PGPoLClB5biThQwqdghWf/JgbmBN5xVpJdIL/+6wZQYE?=
 =?us-ascii?Q?/z2G8nomclfbkDy237ggf4KYNKOYrogdgPzyeiXJCSrIJIcihKKOL1r1jZBm?=
 =?us-ascii?Q?S1hEHgsibZP6N+LMc1e3zSgjaPRm7dyULjLs8jQRZ3Jzq7E4vStYEsvgrRvW?=
 =?us-ascii?Q?ygy81yVHvpaXhuSJafOLhSKligDAkbIC3ynGrFTDazm0U82dX5p/Ua8pjPQi?=
 =?us-ascii?Q?R9a/vJuU+l8N8/l2oD+1F1CwHR2qF4Gs01gRza1sKAOtcJA6tELRT1q466kA?=
 =?us-ascii?Q?4CS34Z9yDGtnArZueKMQA7k9/RFVXsLoqke8QMCiPBbnBCjzvMKUhh/f2Iyo?=
 =?us-ascii?Q?K/3M4ZyK53x2A6FD0tTb/JTn+QfcI70yzDpJQEaHqAWE9WaREQH57qeqPYXp?=
 =?us-ascii?Q?a0OnqkXaljorBQ6xHVA8lIVpePurgxtIcpQA95L0yvqBmfyxfTw4JZlvRW+u?=
 =?us-ascii?Q?MzgBt/N6d62sbOyaJ8TziadkKi29Tl4TMOcK0nsZlVFYK38+BeDccN1sjAzJ?=
 =?us-ascii?Q?fcUi0JcNHKC76I71H8eLjz7CjPQHMdZ42U1he81J?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b026594d-4c18-45d2-6523-08db757904bc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 12:38:03.5977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EuJTzbby4aGaHcXt7uoWQcwdQr6UQ51HbGeAroIalPuv9nwrQcUtG8eSxppIX2beb9Xowt3POIsT/4M03jy8sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9314
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add cpuidle node and enable cpuidle for dual cores. The HW mode in
Arm Trusted Firmware is SoC Application Power Domain Sleep mode.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index fd30475a561d..16906c20bce9 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -40,6 +40,7 @@ A35_0: cpu@0 {
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&A35_L2>;
+			cpu-idle-states = <&cpu_sleep>;
 		};
 
 		A35_1: cpu@1 {
@@ -48,6 +49,7 @@ A35_1: cpu@1 {
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			next-level-cache = <&A35_L2>;
+			cpu-idle-states = <&cpu_sleep>;
 		};
 
 		A35_L2: l2-cache0 {
@@ -55,6 +57,19 @@ A35_L2: l2-cache0 {
 			cache-level = <2>;
 			cache-unified;
 		};
+
+		idle-states {
+			entry-method = "psci";
+
+			cpu_sleep: cpu-sleep {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x0>;
+				local-timer-stop;
+				entry-latency-us = <1000>;
+				exit-latency-us = <700>;
+				min-residency-us = <2700>;
+			};
+		};
 	};
 
 	gic: interrupt-controller@2d400000 {
-- 
2.37.1

