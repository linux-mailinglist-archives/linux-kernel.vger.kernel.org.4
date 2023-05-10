Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF5D6FD945
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236582AbjEJI1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbjEJI1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:27:15 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B845F3A80;
        Wed, 10 May 2023 01:27:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTENRBjN43LG1tNhthnyj5CLqI+74oRBu4FNTZ4DVAOS3zM8BNWbq0x3+2YsdXlliuWKSpCwrRPbnyzGBFFh4etg36SpWvTyVVoegZ1sEVQEtXKULBeJKf/JQCNPhez2SMpO7qgu6VTWa6qlcxFtAubSkvsZC/WK55tQ9HCCBMWSDDOAPNM+xEKSgh047FpN9tUBMt7qf7hq2+/96FwTliT4/Pjj6L56UR9lsqDbV4AvS1RA2Z7iga4M8sbTOT2oO8XS539SYd1SHW52FH2ejlYySrk7ao825BRY3NwMzTkqvbgjVTfdksvMNr2h36UZK2P98vI9PoQuRRVok5Fu/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zb+lwJPQu5FkYJumGi4itSdsiRWXOwRcNtlnolOvvOI=;
 b=EE/RwcLlmqDek3foBSjnZa2+5mbhmRBm982ZkpyACLdYohIwfg9qhkF2bk4w67KyjRzQ/zgIMlzEwyw7mbW8PjFYfEk0Uw4uLUZrnM3OIEHpROf0RHZLptm7gAmlas4XOQvsanCQEgJVFIb6kehueLF7GmlZ4TRHSodDqHhBgV1rDtfZQy0u9m0IZhbKvPUDWnLE0imhfRqBTrvKXk8Uh5N0H56y9BohroA9rzWrQnJpYf6szI+Cdbsf0Ev6NAx8cNSJXGKdZVn+wHCbOTzMfoYRk0vYR25YdHGoOt3ZYAzZnWP8TGwMfXGnog0ag1DPhySfts1WFskJO4kaBVbvHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zb+lwJPQu5FkYJumGi4itSdsiRWXOwRcNtlnolOvvOI=;
 b=UZ1pWQFFa49GWVrZvxsuCHq5UEHcKBu+KXT8+uW0kSC0pQXSV2Dk0/rBN30OFz+doWwL1RCbyN5aBO5vc4991BSQLg5PF+fiySv9ZOO8VXtDQeLPjjDJbH8a+gxpSm+uDLyBtx8D4+r9B5utPPydjpC9DgH1ohf/qruxTWGbXOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9368.eurprd04.prod.outlook.com (2603:10a6:102:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 08:27:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 08:27:11 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/5] arm64: dts: imx93: add cpuidle node
Date:   Wed, 10 May 2023 16:31:52 +0800
Message-Id: <20230510083153.3769140-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230510083153.3769140-1-peng.fan@oss.nxp.com>
References: <20230510083153.3769140-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9368:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ad9bf5-988e-4f47-4b2c-08db5130597d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8gIgwRMteQuU8Pmx7BEPpSu2jaGRUzGR6GRgzBoFqYeXfKHp2IahYPeDwXTsOvsqBxuDmpWlH+XIGkW93Vyo2CiJN/s7qvJd2kKiChr+wAerE+cfoJxpPZtPrFo9HaKMK5HD2jkXqXdIj/qq9QBCW0A+RcseD2QLnz4kljKISXg81jlrZGxt53NgStNDVJjwYlZsjR9PYelr/m9ySrbuzan890UHnmXPDf0izHTnXb8dv5T5T7KWf33IQof5nesPeL8ivbSlB0dS9sdDrLes0VJP9AiUWcyp0e8cE0tieewWKvgDPn+eGmq/d4kXnWOaqtyS0K2I3AJg7UC/qjkTeqachLOtcv2u/4nf2PPhMiUWdYbQDrMP2dOSc3UI2OaatYBv1e15y8V6U1vauqN7QpB9uBf70oDrXqDtXhFlCAd17UW1FmdkSP3NPYa0GzzLn51LSPmCazOYU41R+3KCUbPG7DQIObb+CmFueud9Md6k/7u4fHeey2w5FdCRXMN+lK4xIvHf8yGmC/U35BQFG9fHvqskKQKGaJuk0K3QA0n51J9MOQxLG9QjCO/AOJBfgJCTx4BiTyWFAU/MJxysjkdTYQBS08oX1lyrt5W52m70eDqAhJRPq3y1+SKSv7ck
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199021)(38100700002)(38350700002)(4326008)(8936002)(8676002)(83380400001)(2616005)(66476007)(66556008)(66946007)(316002)(41300700001)(6506007)(1076003)(26005)(6512007)(186003)(478600001)(86362001)(2906002)(6486002)(52116002)(6666004)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?esQdXvEsao8Pjv2gYZvdohO879AEo1QthSrjXAL/hBl8BSwEjWnt+NgJh6/K?=
 =?us-ascii?Q?320lZuLa0R19VNOCd84lw7HNF1nI+cgkmlq7v2iEKneU+ebIhby3b7xjXJax?=
 =?us-ascii?Q?DfsxcQFa6d8PW5b+strNI9dwBe8zaU6fVoJ1LMB4P99wjnwWDUk5Y1GNcIR0?=
 =?us-ascii?Q?mpg4HvhjGsPOHp9a8HaDBeAcI6VtyQd0wtgYLPc27A2n0o3FxyJl5ym8iCF6?=
 =?us-ascii?Q?BbbxGKaNgyHabPC7Uu3kFJoHGtDfVoeWhVrKH3LuJYJTaE3nWUeua87HPFcj?=
 =?us-ascii?Q?xmJN39R5TgLK+Wc4AJPAhXGTv9q9uhchTyoOP7/KwYWNTwoJbfXiiTdvVJ3S?=
 =?us-ascii?Q?NvLKREH1nwBaC3CuS2a1mEaMOkWUQre8OXZ65909Qi4FVeG+0P97dqOVKDLZ?=
 =?us-ascii?Q?//jlstWgvyyaKthyR1upJRTV0S/9UXt+4e5EZqkemU7hjf/2W+UV0lfMY+K0?=
 =?us-ascii?Q?rt8IyfD1c73ZczJ6+LaqCXmMhoD5xa6J4aUolKN+pw39GYNQd6A4s5oqJKfW?=
 =?us-ascii?Q?2iMl5M33yBls9C43X/ZZ3YdhNe9jlhTWfDDEWd6MIzJhdij5DXiOvk5Y6hEB?=
 =?us-ascii?Q?lqGmpGSVBjNwZGnGKcfx2Jc7Bj2A9VhB9D76NCMdsO9wlN80gT2dktnCpg/Y?=
 =?us-ascii?Q?/dD30KaRD4U3B5qkQ0Ucx6lvliw+jK0iJRbPxDDGp12fIX1Bv1ReaomPUlIO?=
 =?us-ascii?Q?SHlMA6+9cAOE+ChkkxwR1LbzKDTUT9/TxsKj11bHUSkcvQTLPpt6vv5q71ot?=
 =?us-ascii?Q?phFr2EcsFH5hMGS0vi1VD66NeN2pAB6P5ohK1qJWUUeIlRzsigFlzohqnZGB?=
 =?us-ascii?Q?Opv/RkYqNI6p9mPLZkOiQreFgXPmX0BPCi0okFuISD1UVbeLd9wXg7jt5qFY?=
 =?us-ascii?Q?7XFZbpJ7R56fZWFXZlsj3txCROtzVpSappifU9ZPfupIv2eEnPSLHrJ/QQj7?=
 =?us-ascii?Q?N/BCZRsrozmuZ0gMVglTq/NdocNYp+6yf99b8qqce0ckxkRL73PRuxrDPL+E?=
 =?us-ascii?Q?WQZlvgalZJxsixZmaGN5UKbZh3qbk3/Z0F49dZ08E4UFaQz0jSFlBo/VZbVy?=
 =?us-ascii?Q?9vorZmQHUvmPvFQ8m1sEg9E7vhj3FX5SM4A+slbsCD2C2JgRlAr96BhssLjf?=
 =?us-ascii?Q?V0ovyuJnLoE04lDd/KMlKVwzlVm0Vu5fJJCyOkBKFzvhkdTep/5ZzPXPTlJB?=
 =?us-ascii?Q?s3RClqImj7jdeSsvgJZ5uGLP4TwacmK/70B96zyGjifIj7cXOV1rgLQkIhRh?=
 =?us-ascii?Q?Zmvzi4LnyMGTC9VA703l+XMexBj9shbx6oTZ0gcmfzt3oTxD7vleB3VT/1Rl?=
 =?us-ascii?Q?tS8d+T8UAMaev9/T0pSjhSPNcR9PTspKOEohYI+j8iia+iHwjWBsIwHzLbkn?=
 =?us-ascii?Q?iZ5rMKUu2aW4gAEmzsObr7ook2zK4ib3DDPs49v6jXztus4uCLOMVYoQ2hQ3?=
 =?us-ascii?Q?qmMaV4w8AyTPctMkeva6gax/9BWO5sybXv1Y1e5vwFOVnGrK/u8+wlehwPUl?=
 =?us-ascii?Q?u9z1f5abhjh7fdOWPW/FBpeJMd1U2TUvbRzx+x1PkhKosDu0k650HV6r+bEe?=
 =?us-ascii?Q?7OuTEbEuVu7jrdNuGgZpFjc6ngt/fSE9IDaV0CwR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ad9bf5-988e-4f47-4b2c-08db5130597d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 08:27:10.9475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQRR2/1t2Wzwg33HjVojp415yUWiBixFAefz9PA21zSuNM5mYOhAyfRBt3jlT7h5EC0U1lUzikguBnAVPiW+bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9368
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add cpuidle node to support cpu idle.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 5c5652ae4ee0..dc444ca394af 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -46,12 +46,27 @@ cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		idle-states {
+			entry-method = "psci";
+
+			cpu_pd_wait: cpu-pd-wait {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x0010033>;
+				local-timer-stop;
+				entry-latency-us = <10000>;
+				exit-latency-us = <7000>;
+				min-residency-us = <27000>;
+				wakeup-latency-us = <15000>;
+			};
+		};
+
 		A55_0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0>;
 			enable-method = "psci";
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 		};
 
 		A55_1: cpu@100 {
@@ -60,6 +75,7 @@ A55_1: cpu@100 {
 			reg = <0x100>;
 			enable-method = "psci";
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 		};
 
 	};
-- 
2.37.1

