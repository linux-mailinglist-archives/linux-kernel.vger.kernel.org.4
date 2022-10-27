Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40F960F494
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbiJ0KLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbiJ0KLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:11:08 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FA8DD391;
        Thu, 27 Oct 2022 03:11:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SC2e+ibq7uzQA8EBs00+w6EkseGz7a35CwehvCrdqQRLXEevGpSoUdUPzmbkVT7AFTwpExvKIilkPv5FwBXzMpTjcaQCxaGPNl1MSnBCLrxAbpXFKFFt2OiV/o04pef0HNQ1rw77NFPFrwXnfsavFRJHYGdSswGCbDWhUU1bpiY959RXxWEHZThDXt/LIDLUJgSOvsVLBokwHX+W6vlJxvSgbLzjkOn/QhkrvpHoggX2ErmcTX5gMrrdmzjSesUr2DkLjCi1d4y5evQU0rhxwvsfYJS4hNADPMwvyLQqMq/qShT3jLVHFbDDpZJtQtlhFbHZ8L+Pw8LMneJZRF1mdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMF2UQoM3hDYd2ZRUZ7vonl3XWx6bxAI1Q3/+YWmo8k=;
 b=fJOe+6YTsqNr4lLtqUSnoKJddwui1gOpZUMAevOiQNYH50xWiMo6QH3aSyAzqiVpfk7AbZo1CKIEMxAzyV3Wu7D/9fyGMQ0D63pKq4A/YBpsXQIIyGWJrgmWdCTeioWARVbL0pvyHGh+24HAmiitCn4Cd8qVYJwh728H1ENaN3Q9/YZn3EI10Z+MIvF2BvB/ArvxkCyv0iTklLKOUS2IV0G5/v4vo9C6oUdGK+ur6JTeaekXme4DShENY2MNodxB9Dz4n/l6KaBnSMxzXQwf1QvRfgMi0VnBfL0Njg5rRGRM5DWWPasJDFy2oVqVR8pbOVWPLkYoWIT6eUs73JxcLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMF2UQoM3hDYd2ZRUZ7vonl3XWx6bxAI1Q3/+YWmo8k=;
 b=lAIL7tKp2xZYRc42P/kjxUwapDRvOWEbPrG8dUu/J05NCYTpHflToa2p1noKcY/ci7ROCbUhUiFwnIT0m2ZBw5p4wkoGC0qPLaIOsC+gh5a68T9GO5TILWPzJ/ZZwMQvfXjzmu3cSs6lnQ7fo1K64l0vg3nmd2UCA1WAInDupBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6875.eurprd04.prod.outlook.com (2603:10a6:10:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 10:10:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18%5]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 10:10:58 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jacky Bai <ping.bai@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 5/6] clk: imx: keep hsio bus clock always on
Date:   Thu, 27 Oct 2022 18:11:58 +0800
Message-Id: <20221027101159.942843-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221027101159.942843-1-peng.fan@oss.nxp.com>
References: <20221027101159.942843-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a97fa4-cfea-4677-f8f3-08dab8038b23
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iMgMzP57O4RsB46fVNdXXFDc2NW62pq04Vz0xKCSekUSeyrnkX5FoCOSxG1AiSEUteG8kaUG7DuNZqUwn+JinBGrauQ0WegpfMW3oAqPl+aTFyac804fvJ36u3qwUIL+tgNLYZnsyGBSdcUHPPjjkqaaaciy/biSo79kNvUEBDA8/X/bx77p/zhHQyULWGzml2svpy3JIY8Yg7yFnw1oZSDC4NY45cnMNDUcimwCCrEF6h312xjt7aY6YLP9mtTzXGhHoXIZfj1U0hE0ILBWa3Sh9q7w+1l0ZGrcLw2Mncb9XlrWwyPTK+iRRmOueSO396cNLDDyUOUT5LrOVFssiMxLmnx9XOdhIZyoSL786g7DgpRS4Xjl864ZE76hIrPekLSp5hTwNnAKfImT3ilO93ruRzpvAXfhMR6rBQUeuAJRZmP2MHqnp9CApwLF9lPu668qsKqZw3DRVOlHzed/O+xL3qBHFhvE18beLSHEslXAv02/inLfEI882oMDX9pq7MkEBov1d8tc2EFcyUWYJHJTJmU7b32+Iqhnwvc2UHittFpHaFhwddIIxj4S2vAU9pl+K6VQpPm4THustM+OWLN9u1TU0GkZr14GUpNRHnIlut6A7c88ebJjA8/kUFRG63tPiYAy+w67lCFqwcXsDIGBzQqe8Pzo6MmBPQEGELGMeD7rRgWtSH2AZQOUE/EnvpcOJ4e3s8KaWUT6XWSFXLXM/HCq+Eq5RE0NTb8U58P7u/oQtqYrqkP3Esw5NRX64bi7mVYSj9OGDYOxgn9uHfWC1GxhuSBOIiZlNgaRCJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199015)(66946007)(186003)(2616005)(921005)(83380400001)(38100700002)(38350700002)(2906002)(7416002)(41300700001)(1076003)(52116002)(86362001)(5660300002)(8936002)(478600001)(26005)(6486002)(6512007)(4326008)(66556008)(66476007)(6506007)(54906003)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Uy5R8ZlCsmk5VGIyz0j/DlDKcB/FMwpFbcEbcPOTB3WTXsnZVQHh55UfTYJ?=
 =?us-ascii?Q?tmwJANUlTkhd9w3pDbPPFOjOo6XsrD2Pug/Z/aoNDkJq0sZFPkGW0FikDS5s?=
 =?us-ascii?Q?Iobzv9ngmxAH0Z0zp5ySDSKi3gohFSKj96elrh0qtitI+uiW4ziEW6Jw7nJN?=
 =?us-ascii?Q?wLQ0Xw0DDOKwx3D19pIS1PphMTI2/8czWkiXBt/+ID8ElyIDJVHA7YutsaHQ?=
 =?us-ascii?Q?Falfcwp8ygqjaEjmzkZ+Cnh2CJsyv1LrVp+Rb2BNbI3HhFcFAY78VCEeamyT?=
 =?us-ascii?Q?+T/8+kjxrN/WdkJSrAlojT/WVxEh0xFd2bGdmJmR/WdlIzgoYkHMMgpX/ZvY?=
 =?us-ascii?Q?+L+qjiTEyaQLxtLm8jL9N4RjSCPdVA9392igACi9DGNv3fNL3FYfqzyzpIYM?=
 =?us-ascii?Q?L7toH/lrd0/FjTav2sO7YIzCWAgxaREHJRYcaxAziGml10fp7K4KoBQqEZYf?=
 =?us-ascii?Q?+CKb1ZtOE9U7njVQAIBaUkIdrjs9CbdOYHfAdeoeFgggha0D3u7e5Euyi/4V?=
 =?us-ascii?Q?Dw2JWyFFx5/QPAqsoPxwa3lKPicM4icdfMV9M/8LkyMOKSry0mW/aF+13N24?=
 =?us-ascii?Q?lWHvmaZssHQZV9TlLhpEkLaz4k/v1Rn/jMkMav0T4ZrQGNEnqbU+P4AtkXoV?=
 =?us-ascii?Q?29Yl9nrQzUp3123+lvJSnioD5iufFaNra1rvVPPCRaiR7e4TES++DlRYs3C8?=
 =?us-ascii?Q?y7iyqOYPHNFNd7D9ZvQ7M1RFiBdLQpmaho95NTkIFnsmC8+6UMrAjJe+96Ac?=
 =?us-ascii?Q?WW+i1qwDyHswnj3TSQkHE+nNkmVHGKtYzFkIHM8zduD/vP1iGb8iqqrhCWCo?=
 =?us-ascii?Q?2BBAamkYyC2CDpqZtwL2WLhH7dE7/x5fIV23iWR+KIyotoADjSv0rdgm577V?=
 =?us-ascii?Q?3WbVxxg+xol2npYtqOIsEsyjY1QAe3W2ynOu1v9gBexhNMfqu1vHZbN6XzwT?=
 =?us-ascii?Q?bjUtR6B+F3e693GAf66xp/v8gwVSmXHP8cy5ElTkR+8JYmWr6E8Vtu2vfHBj?=
 =?us-ascii?Q?Uv2nQnHnJw/NgovzsKQyWneQn7JiaMII9tpSM7Nj76RnrPN6/Y2j4q9FWgXt?=
 =?us-ascii?Q?dGr6pGPzyo15KiU70Q2/H/IK6mnrFnKCSMl4fEV4hIABRpQzKNpvQZ4Xqkpz?=
 =?us-ascii?Q?qn9SbWoWIhkovVHBjc4gPTc4ZiUDYFyWgrmNSplZuMKqW+DegkDL0qSx5zfI?=
 =?us-ascii?Q?fiw8i+aHzf/Xyh/oWFq+lNYjIMjp8wSNRjSvk4xUVSnJPpJNnnoB2etAk4vJ?=
 =?us-ascii?Q?dqZF9wr5eF3a31mJbT86cbbspNzGpgNZs9cvG4yUbOVvo+f04nlLOQiAxTG3?=
 =?us-ascii?Q?u5v5IxS2QtgFAe63auCVr2Qiu6tvyRqcDm7D75jACZqwDhQ1Vc+Rzr0/29Xv?=
 =?us-ascii?Q?rig7+OrxCZih0hu27s4pT3Pe3ykHoIx6AixLBWmpE8L0mVTUWDfRFLVVA8Vf?=
 =?us-ascii?Q?ACsFzFzq43RBk8e6J1gtWeOzq6DX1F+KtnqBbhqtPChcJ2cTaJBQLYFilxZu?=
 =?us-ascii?Q?PFYOLkLOyD1FrMjzI1jmlCz8MoHyVOKYaBDYE9L3dtT68/Gmn+zgpknpXq0x?=
 =?us-ascii?Q?hiXSrNLAQYyWwlixtQEv3egn4ySjdeYTily34+Xc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a97fa4-cfea-4677-f8f3-08dab8038b23
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 10:10:58.7024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LtfOUgVuBR8gMOC0puyV+VHLUejt3L6pCj5bGLvdkJDowWXZlfj1w0CVdS2PZMnk1qorgTcEbK1V7jtvi183HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6875
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Bai <ping.bai@nxp.com>

During Linux System suspend/resume stress test after System Sleep
enabled, system will stuck sometimes. It is because NICMIX is powered
down, which HSIOMIX(always on) is not powered down. When NICMIX
powering down, HSIOMIX will get a hardware handshake, without HSIO ROOT
clk, the handshake will lose. Then after NICMIX power on when system
resume, the access to HSIOMIX through NICMIX would be broken. So keep HSIO
ROOT always on.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
 [Peng Fan] rewrite commit message
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index 422ad3c89845..74e8d810db7f 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -109,7 +109,7 @@ static const struct imx93_clk_root {
 	{ IMX93_CLK_CCM_CKO2,		"ccm_cko2_root",	0x1d00,	CKO2_SEL, },
 	{ IMX93_CLK_CCM_CKO3,		"ccm_cko3_root",	0x1d80,	CKO1_SEL, },
 	{ IMX93_CLK_CCM_CKO4,		"ccm_cko4_root",	0x1e00,	CKO2_SEL, },
-	{ IMX93_CLK_HSIO,		"hsio_root",		0x1e80,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_HSIO,		"hsio_root",		0x1e80,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL},
 	{ IMX93_CLK_HSIO_USB_TEST_60M,	"hsio_usb_test_60m_root", 0x1f00, LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_HSIO_ACSCAN_80M,	"hsio_acscan_80m_root",	0x1f80,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_HSIO_ACSCAN_480M,	"hsio_acscan_480m_root", 0x2000, MISC_SEL, },
-- 
2.37.1

