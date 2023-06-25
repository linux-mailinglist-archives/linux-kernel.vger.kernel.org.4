Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3995C73D103
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjFYMjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjFYMjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:39:13 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C311A1;
        Sun, 25 Jun 2023 05:38:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPHBjrzPuoCMF08ib1OFWVM8HmDb0ekb0dy9cBd5jySGuIuEphg4ldhqR5BEN1Mbt1vAUzs349IfqRd3LYU05jeDOEYslPzTqDJIGaZX3iSWvTQ9P74GUGz3tKfwdZzCjel4/DS2uIbsiIJu5ZX/HndTYSeMuLsJHDrN2WgUNEVs2NeagwW5E9lP1kTP3nrN0EymygzNteucA+3L+tmso41OcW6MatcMoK/FZay47lOkYkWoWy0wPtwBnLR0Rr+SIwcmEFulTTwdS52zSf06MS9FptmhBmqS/xsAKqaQK7k9rQyRgCV4d96uFVuz2L2RVYEQJUg5Y6eUggFaj9ufkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mp9nFpFZBlXnunG+1Bq2v0+un89/xIN/D0IL82NY/9w=;
 b=KeUr0iOwyIbzNFR1G27UGKityUlIO1knwjfvsMo7k+tEyFlbu/yEuxHO4YwM6NA6+3HKaw5OoprkkJb9Gv5/2oBq3zXHqUffmDkJH4WsczYApuu34zZnNW+P7NGgC5EbbzYJMipQ4dgA0WMPo/GGaHCOi2XwkwUn4t8gx6n/prl3EF4ejoGrkQjYQHTbZO3qUysyWKyw6aZLq6EBjC2dpKRBmHp1QiVm1LJpnQFmqnfs0/lMUf/r6TxQAQ1tUH1PX1lEQbmEoK+ITDWu0RjQpDNeOZXYo7VRapG9lMK9ikVl9GYPJclEB1FyhsVx1WzVgInJKBokVB4tsa42wUl1Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mp9nFpFZBlXnunG+1Bq2v0+un89/xIN/D0IL82NY/9w=;
 b=G98xmlClG1jQloQaA+Tv+aw5awtdA+zMyAfWuVD23cT+UCZCNJV4Sx3W2783WOIk/yd4tf7pmyBKPmTBowCvfvDKhLmD96ay7ZmwEZwhjXjXVQUikfira0nEUwFyqK6ZkMF2hi1YQb+UTjdpZLxWAwJjE5aIxDzayZCthk21Zbo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9314.eurprd04.prod.outlook.com (2603:10a6:20b:4e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 12:38:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 12:38:11 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 06/10] arm64: dts: imx8ulp-evk: add reserved memory for cma
Date:   Sun, 25 Jun 2023 20:42:34 +0800
Message-Id: <20230625124238.4071717-7-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0dc7cd28-bebc-4d59-98a4-08db75790915
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N6Ax13sXz+wYF0EVUx2fHiMGU+eV1ZCffQMOY3kSKJeHguUW6qfUVpimgSk7CE54KOkcEVP1MJsndv9y9JkgCsIS4rcYDeW2oLWmOlgQvrQ32BQ3Qy7aHffXErCViwUVI068iP7ye19IDhLSW30/VsSYGj5uFcZLW5uSGXXsPcN8OuvQ6rMsNhvQcfk4lSCHuyLO7MVUdZXhKYe6ulqbU390H7qbmvasob7VYo1dtwU8AVsbOnD1sR4c2iyhHcIoPdYcM9BN0gSHz8Q8usKfgp3i5OX2d4BW34VAEcg2cyf31bkPtPFktW0C+9AqlHOBtaPwK8DgaRlDO3CE+wRuTRbhX3zNZsEEMIcTXypRYrCVw7Lgc2oo7b9qoB5Bl9Crd0GcKW2/kwtfh4vdAsIzQS6Qh9ZNerdLnjpin3ulVL+SwQXjvAlu4gi0hAE1xStNnjjsCDyqlgoi1NPwYu1nO0GE8587H51szmKofj98n/94bZCMANmQnMg9s/wXdb7HS03jgh0oEoRCA7cXUZLDIlZvPoR/bEeCPGEm0q2bdOhfkaMUcKXG4LJQ6heMZVyUnjaXYScwL0FBsamaItEo3O2njnC7Xg2j6yIq3FpLDNmRbyvWfxXek5VPROe21Io/EVXA9Uo79Kv1RJyGv4RGvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(5660300002)(4326008)(66946007)(66556008)(66476007)(478600001)(316002)(8676002)(8936002)(2906002)(86362001)(41300700001)(6486002)(52116002)(186003)(6512007)(6506007)(1076003)(26005)(4744005)(38100700002)(38350700002)(6666004)(83380400001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UVaHjMmFjT6wxGxZgLiFKQAAjGW2R9P78OMg0tXWAWjTFZrW/QO7oE9hTnwq?=
 =?us-ascii?Q?lfGPbQjc8PUOG9amPHDNxNudfjASvbJq2+l9VW1MPYwU+SQpLMYgymK1ZY47?=
 =?us-ascii?Q?DwzGjk6K2GIfkS0nCR+ZPHMkdb8ggppkkevW6u2GHj3UZx0Lh+rgqQz9TKHj?=
 =?us-ascii?Q?3YrLgGAC8061y6j9ruPzHTnqwRYQC/3o9g8cg5LUVk8+6st+kawTbVWua+fA?=
 =?us-ascii?Q?MaRZKXs4yzi+Ba09owVV1AagbDh1jKEjLDgPAQdvqVVqEqhx6TTJydAcqhP1?=
 =?us-ascii?Q?cBnZkmQIPJSSWQ3xn4c4mO3yq42H3GR8zp4NI+6B+N60Zw5+kWl3VA3B/ZhU?=
 =?us-ascii?Q?4QIYAMy4gu9ntR1dHj2p/ucJRlEwtB2K/7nzaJu79XLtKo/LdwMA7W+rwMzs?=
 =?us-ascii?Q?RO7As+TvCzmz/8VzDFe4Vrweo81piQrIgOQeZH0W6xXNHOFPiPmk0CSuYOxH?=
 =?us-ascii?Q?z4K5WIZkVPZge3eR9hFvPRFOrj+TQLN1Vbp3FM3AW4C3d72wqd1cYOM7YI4M?=
 =?us-ascii?Q?a7J1Jqtgrr+Q5btgpp9HSmu58WOkCVb3LlDR5pi+bcdSMSLApaFaOqNdsB3s?=
 =?us-ascii?Q?7uVNH4e6JBntpWuKUpbg3HvWOtEmxn0DHoj7OQdGeZoz4qCtW3dxAJXI2MGL?=
 =?us-ascii?Q?XzXlW0W4sHtNfQPtowj6gbztY7bkekIpiK/+ds9sSVATSUDbtL2DJ1kjb5SO?=
 =?us-ascii?Q?ACXjjLg+59prbOwyg7QVdlClJTFoj7bsCdL1xyB7NPhTjfiTFQae3nWBCpbH?=
 =?us-ascii?Q?9gfOcyvfB4eJEpgUFTnMWV9A65ajxbdrbkqRFKlLoj/b7qXK44mEUvm1TxrG?=
 =?us-ascii?Q?cKAmnBOkl5Qyf5K9IzUHl6fSIYT4u9jEdQ44iebLJrBvyFyOS17fAb22PIzI?=
 =?us-ascii?Q?aXfshQkuzttc8eN4aU6Uc/pLTFKL+FIRiuVcbvJSsKZTOOnZpxcQMeW24eDu?=
 =?us-ascii?Q?zsMV71JQ9zDXyND4i/MWrPOWbg1KbI/TMvs+dS5TWMSqeFhAwreQrbQ+hUJo?=
 =?us-ascii?Q?wYWPv6z2DNAvt8nbDcMoWVi7CfPLZJtNIpKLdDKiY+B/7478PnahN6IPb5Pw?=
 =?us-ascii?Q?GZJ1MTt4EPxZKAVzUJBX6yiMGwdLux9emW2xq3WyQWBA6K9b6gzaWkR7i+OH?=
 =?us-ascii?Q?RGQzp4WBB6KvdoGzt3GqQzehogmWjxam8iQHfv7hCxcDjJeFNb7ncwpxGlN4?=
 =?us-ascii?Q?yC1EAHsoi3HM3+JnWGTJNUThtaxGTrp2AR7p1Rc+HtMa3OPSrWCV6dZO7kyr?=
 =?us-ascii?Q?PD7h6pIhlPN8HukI8rNImxXtEIc+whhfHc9c4PmDCsgdxfBf/fH5xiSaMbAM?=
 =?us-ascii?Q?L76NPsSa4VNj+o4wtVBFaW0eBly0N5wF8zzZYD/rFhyjt4bcMIj5RWhSDa+W?=
 =?us-ascii?Q?/1+L3CA8MVcRpQeAp375bpyk7IkkRUCJzoIfZHfcxMC5EmpFJExr9g9PShD7?=
 =?us-ascii?Q?IcM430jM7f2morma60rOpMKYk4eWZOjBbUIap7VjGCVuTrbC7KBI1/EWJu9h?=
 =?us-ascii?Q?8camePWISJ67w3lG/awdIXHS5vr9d3q5L/CNXWqiS3a2bRzV2Ln4Ni3/8gk1?=
 =?us-ascii?Q?aM92duyftgnEDsIDChGyHeNpmxGxqYghOgo166ux?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc7cd28-bebc-4d59-98a4-08db75790915
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 12:38:10.9890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJHD6yIRyEJ40v+OM72rwjz1YJhWZ5Ca2ZoGGldb1GRTAXZih31CzNoBKXUzzLqxUCXrP6Vx6LcN7ZD+hSPWZw==
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

Add reserved memory node for CMA usage.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index f1c6d933a17c..e171390a1888 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -20,6 +20,19 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0 0x80000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0 0x28000000>;
+			linux,cma-default;
+		};
+	};
+
 	clock_ext_rmii: clock-ext-rmii {
 		compatible = "fixed-clock";
 		clock-frequency = <50000000>;
-- 
2.37.1

