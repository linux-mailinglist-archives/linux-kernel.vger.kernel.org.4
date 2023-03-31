Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148A06D177A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjCaGdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjCaGdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:33:43 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9377F779;
        Thu, 30 Mar 2023 23:33:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXruWynAoC+FJ88pb1l2Ed4ToBUI38DQ/YUejEeGGQ//HUamilc90HEJ/OgSOQTgCrBiykWXvG+g3Gy6Bp69906gpxCCVjryjUFs4yngRu7AGFTZ72IRYM++8rAKTo941oiHkYm8N31iW7BtU8E/A4zZKvjUlAA8TBGwjLeVM9BzoEOVycgE+LVB2AiEsapbIJ7AnK8ze+AROOZTlKt/j19y5LV8MVKkQwq4fKi4DlwECkDusNKFbpYs8pVQ1/4ETEfEH5guEpIQ9jikOzb25G2/reFwxpcq8w1xFsKy3v+tbsSqnv4H4zICAw5G0e72uFunJ1EHcx/ytr3NnjZMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlR8D+X0Cd/2yXH6oInv5JiG8UoVO03J9Zpnrn7l3XM=;
 b=O8oiYqpZi5EKl3MBvolIsWYbYHWI2SwzxsDfwQBqFzUvt1JYAKwThNQ/8104LRDgeONQzf9o3QChgTI4RFntDNCOLVhp/ILT23iM/veSmq1zkRMhf1b8J6gmUmEMX9k5JCZUkE3Zhh4wq9rTlyoNXdlM/JuFNrYPCb4HyMF9Byj/o++7SYHYYuePRquJ2gDEozw1md3U1KrsTLhlTB4d/dgEOvFZbj/5aGlT3vSKBr/DNAZKabeS3gpdkFbXL4aFulsuVfgBTp+izZOwSCqFmM3LU/wVttXBnlZRS98pdbq5fgeit7R+K5sYeawzBJ63IQKzKsHsZpEFCTrLTskXbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlR8D+X0Cd/2yXH6oInv5JiG8UoVO03J9Zpnrn7l3XM=;
 b=Fsk3Efi9APPsL3DxXpfOgT0X73YZQ3W49mn4okGIzGKn2gT6PLiBy8jbbJP1fQVe29uO8Y4Om6djGB1pemUSF2x2MvhpZrqfQE02TCCSLv2FX72Thxe39uDc2/J17F9WbX83yD4be7VStd2IfyEEMWfRwHqxvsP7AqmCkbyRHw8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7356.eurprd04.prod.outlook.com (2603:10a6:102:8d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Fri, 31 Mar
 2023 06:33:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Fri, 31 Mar 2023
 06:33:32 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Ye Li <ye.li@nxp.com>
Subject: [PATCH 1/5] clk: imx: imx8ulp: Fix XBAR_DIVBUS and AD_SLOW clock parents
Date:   Fri, 31 Mar 2023 14:38:10 +0800
Message-Id: <20230331063814.2462059-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230331063814.2462059-1-peng.fan@oss.nxp.com>
References: <20230331063814.2462059-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0030.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::17)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PR3PR04MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea3aeef-99fe-41ae-537d-08db31b1d938
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c069GgcPbJhZ7FKl1Ff7uwv/xnVuN/6n8X7B6+BATJj6qx0FHeR1SmLXCBECXw8hxCIwoLtYUVePCCVMCxqMuVsKYHcHYqjcTCceNkXcPIHBFtzZViOHd6XVSIkFJ7qaY71xWCYxa/NIWo2N8ylFsQt53920TcL+Sdn5FM/K5yAqpjtQfrZedUYiQSvbneLbnt5jtH2UVK5xTu7D678s0g4M/54glZ+O0FAIBOsOjM9Ddd4NHRrUkZTiz82XelID4XA2wFs4Tk9/oxI6RTMi4QSUUyy7o9DCbAn+lt3AAZbm0+II6UBgTQ9IJze0Tz7l+TVErYIEaM6SuK4s+Vv5utqVA0+hSuQHAyFf+xjlxcR0SIvFWmTBZRPNoyVJyEcT3yVuNX2lomGEWjpqY1V9gcoTxfn9Miew/VZ+DnEy+j0TeBdCYv2qr+A1HbeLTUr2s+l2/UxnbdkU7tRM/0EWZ3ZSF6e/zgWnDcS0q/MnvXb4ZcinZs0e+VzClEzZRCTuGj2DmngrShPDtkDnJYNq+JPvUZKxcSmOE4fs3cWV9lpdLc/nhmNrjTweKquEO7JBX9lG5p+v9H428Htp53OlGYzKenkhc6rv4c3fO8OYj1Xo6939NpV3MnyAAqcuRw+OV870QmP7PIbUwy1uoHaGGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199021)(38100700002)(5660300002)(8936002)(7416002)(66946007)(41300700001)(38350700002)(4326008)(8676002)(66476007)(66556008)(6486002)(83380400001)(2616005)(54906003)(6512007)(26005)(1076003)(186003)(6666004)(86362001)(6506007)(2906002)(52116002)(478600001)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l8fn/FgqTA/UFHdNlQCa7nhXeNoYT5hfnwvvLF9qJaOccURwHrVa7O6u2RLo?=
 =?us-ascii?Q?3P4fTfEu7nHDJ1s+M6fIhwJNYS6SWoPHScjMxbbYi0+3rs4ofZlqrpHGPcHB?=
 =?us-ascii?Q?TiLOrK5+EGFOdl/eHIX3SIT2ItjM8NTTGRGbdGuONPSCHEYzv5Pqg4jypt1F?=
 =?us-ascii?Q?dj4th8Gp+1sOx7DKBwax7lfB2IQ7Rd6uDYLyju/gjGVXsp5EUHGmVIHCEcdQ?=
 =?us-ascii?Q?zVeSVqmRm84aHKVPrAzTsVT5Hpgq6MLVSw2FfTemHoHUVmJKPJyLrGhh5PSD?=
 =?us-ascii?Q?LEyLqA73QU9coqXPDTerjVGhxwrofwkbNyGkRb8JiB+nHoc6NLefZTxwJ//t?=
 =?us-ascii?Q?gZoyPsUaK480/ErYHoVYO3UFE1Bvw+F4ko1GtHMSZkHJeYK9X81g1ITcyQ9d?=
 =?us-ascii?Q?/cAZ/6cCpyRfsMlZ+0C8C+twS/BPO5FzxnmveYXoR8yl4ZN7t3LVGsjo+ilG?=
 =?us-ascii?Q?rQ0B3d8OYrwPbJdpZwaLnLGRcZlrYFadcSBWlRH/03v29d9ilugW7C9jw/4i?=
 =?us-ascii?Q?UN/eBfib65NCtab2gATopRKJ5g7oRitdlkd5uqz3Nhx4eBNGJVvwyZ/Tlqwq?=
 =?us-ascii?Q?UfcLJK5oFLrWRGHwgWZe7/BIe695fArgtmpMydAf/MDTbKPpGQDEOR8JIRdN?=
 =?us-ascii?Q?Vnq9qlB5tDC8Uy5i34ppl0nds6fkTLF3Y9qRjlpsIGGsqazGUTvUQ2hN5NGp?=
 =?us-ascii?Q?ytAd5ko5iSyOp4PE9RXCnxH30AROylGSlYxsz0qWCg6w2uCpLIyixBpF8ex9?=
 =?us-ascii?Q?apH0rN+kvE6N23uJ4m6jKlYnr058bTfoj+jqlBYrDQyn9Ca06Zpop9XB2q9M?=
 =?us-ascii?Q?NVJCsz6HAbHxUxwSac25XCVXatlX0X8EGdywlWFzeAU7Hp6MUFAB/YPLIEQG?=
 =?us-ascii?Q?F9CNeBvyBHg4ddWuQrEK2zJ/z6k4VHSVMV4OBQkhrl3egPG1dPgw/BXPhu95?=
 =?us-ascii?Q?QbA91Tl5uVnitgonfKI3mi0whDdAaXtKoHDsUpSgdW3QhH4vG6RSanUAgChk?=
 =?us-ascii?Q?QNqGVKfIfTIQodNLHxfvIKsX3mOYkd+m8aXW9584uNbIjd5alKZS/Dwq3jt5?=
 =?us-ascii?Q?05VaiOhzYB6/1U7pZcGneRzxINkhNmHxN7jCzHAHQ9it8/EGyGx5qtpHsaEl?=
 =?us-ascii?Q?X4ZltSBRzEq6uK+RHbUWt5TVKzGTdEYK8HjArFb0zJi3CqEp5SVAeFQF1J4N?=
 =?us-ascii?Q?lH2wcJizkXFs4EBhN9FsQjgtIcx5DwO/wVHzn/Dp+utj6EjHmhd63/pEHS9T?=
 =?us-ascii?Q?L+UOYls2gPnLAHBmNPb0xDqkZoo40m2PXpuXDLnw4cwv7PaZWtwShPMwi3J4?=
 =?us-ascii?Q?cWH297CnrRgLrod26bdo0Ra76zbzRz6IptRQ/fDxje9m5N09S6xZ8c2YbKBo?=
 =?us-ascii?Q?XYjqj7J4Cbpe+nOw6k3sIm9g9+v3B2RVBIJUdCRGVkAUxKdLNXCMKYJLUpSI?=
 =?us-ascii?Q?CrTEL1nRfyfTZOcAkru9lWDNGjnDs5KVoWqMfB2215JKbvRpJ1gxnvLD1YKW?=
 =?us-ascii?Q?et19T+mB60oFaEHGW+nBSCJb4pZNTCVsKNjsTmOSklcA06wWpQQgpNUGSKQd?=
 =?us-ascii?Q?h14vVxz5vqQClVcDH1uBafqB4ZdGRFyYFd6mPHmR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea3aeef-99fe-41ae-537d-08db31b1d938
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 06:33:32.9507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /NIgzJjXkZI9D2tcP+boXkmwkF9GYqKZ7eZcTDPETiepjNrV8aNMZpYOSpB7yUwPcQfq5ByS6qNMthTrBbyPLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7356
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

XBAR_DIVBUS and AD_SLOW should set parent to XBAR_AD_DIVPLAT and
XBAR_DIVBUS respectively, not the NIC_AD. otherwise we will get
wrong clock rate.

Fixes: c43a801a5789 ("clk: imx: Add clock driver for imx8ulp")
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8ulp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8ulp.c b/drivers/clk/imx/clk-imx8ulp.c
index a07df3b44703..89121037a8f0 100644
--- a/drivers/clk/imx/clk-imx8ulp.c
+++ b/drivers/clk/imx/clk-imx8ulp.c
@@ -200,8 +200,8 @@ static int imx8ulp_clk_cgc1_init(struct platform_device *pdev)
 	clks[IMX8ULP_CLK_NIC_AD_DIVPLAT] = imx_clk_hw_divider_flags("nic_ad_divplat", "nic_sel", base + 0x34, 21, 6, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
 	clks[IMX8ULP_CLK_NIC_PER_DIVPLAT] = imx_clk_hw_divider_flags("nic_per_divplat", "nic_ad_divplat", base + 0x34, 14, 6, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
 	clks[IMX8ULP_CLK_XBAR_AD_DIVPLAT] = imx_clk_hw_divider_flags("xbar_ad_divplat", "nic_ad_divplat", base + 0x38, 14, 6, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
-	clks[IMX8ULP_CLK_XBAR_DIVBUS] = imx_clk_hw_divider_flags("xbar_divbus", "nic_ad_divplat", base + 0x38, 7, 6, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
-	clks[IMX8ULP_CLK_XBAR_AD_SLOW] = imx_clk_hw_divider_flags("xbar_ad_slow", "nic_ad_divplat", base + 0x38, 0, 6, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+	clks[IMX8ULP_CLK_XBAR_DIVBUS] = imx_clk_hw_divider_flags("xbar_divbus", "xbar_ad_divplat", base + 0x38, 7, 6, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+	clks[IMX8ULP_CLK_XBAR_AD_SLOW] = imx_clk_hw_divider_flags("xbar_ad_slow", "xbar_divbus", base + 0x38, 0, 6, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
 
 	clks[IMX8ULP_CLK_SOSC_DIV1_GATE] = imx_clk_hw_gate_dis("sosc_div1_gate", "sosc", base + 0x108, 7);
 	clks[IMX8ULP_CLK_SOSC_DIV2_GATE] = imx_clk_hw_gate_dis("sosc_div2_gate", "sosc", base + 0x108, 15);
-- 
2.37.1

