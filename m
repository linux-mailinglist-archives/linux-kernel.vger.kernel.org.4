Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8736D1783
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjCaGe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjCaGez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:34:55 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85333191E2;
        Thu, 30 Mar 2023 23:34:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHpoK7oxxdXXtFtjO+yp+qLOJEugTnZG/EemMROlStLjoPRrp6hB1A2LoSUstQ2eSaip+g+KIFopNajPS5GdP9CbeuTvNWYoFRgkplPbc8Pl35/7048Kw9Ue9HdLunpVCTYYvuICsZysbw7XfOvqNrDkOPFA1gQeWhKi6FTzYVInYhaQQXm6xYFOQmhVcMOVLAwGEHbatjsw0WqJUuymdX8AoKEOG6c7xPjSLl8vB1Lupsm0ZaWYOORNN+Ao/0PN7SBRbjUQlbrroeGoUW6Of1E8iYYbV+K3pc+Mimu9Ey8eI8hzAcu8iPtfulsPQbGfFH5Gn9PrIDnPk2+fkOFygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+kk5vVtHszPsy7VkfxiCED1bhqOtpUvT/dSaLfIVvI=;
 b=FAECDbrsqDw+vJcqn2NLra19ys2LTV9G/6Fzp+ejZV8rhdEn8LAWfE0EcFq0cWr93dTpgHVOUDga26Sy/3DdFCO3NHVqvJqwGseysim6qoa8Uarmert1G8a7Bg+AU30V4tWfxCOcsrOKb3324rjpzj8E/tAIC1rDF6CTqxWzxZYFoXeKb+hXXLjOpr9BwqPa5F7fYYVT+tkrzFNDk+8DaqRkp9vs6YCO5yTMFulyFfkyAnYtlxtxCyosFXYAqFVninso+N7ZBaltajvRcuDLEtyW2uG8YAAK7TAimA8XrxXJPrQYeXdJ5mXWOKMf5CJCKrQPS/0aUZbedh1PHIETeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+kk5vVtHszPsy7VkfxiCED1bhqOtpUvT/dSaLfIVvI=;
 b=RFAk6etxMdW7QrUXEA0paQrwDapWKzr7m4Uz4gbpfLpQ1jc5OO+RpCi6k2Q5yMZi8E3FcPI4R9pZsf4nNa+ABBujpyBh05BNZUBv8XLV66BSaKa3dcUnrtq+zwYAGi92lKWFD7cAj3d6QN81ABpyM2CvsBeMSeQ46NQbXC1bVaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7356.eurprd04.prod.outlook.com (2603:10a6:102:8d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Fri, 31 Mar
 2023 06:33:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Fri, 31 Mar 2023
 06:33:51 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jacky Bai <ping.bai@nxp.com>, Ye Li <ye.li@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 5/5] clk: imx: imx8ulp: update clk flag for system critical clock
Date:   Fri, 31 Mar 2023 14:38:14 +0800
Message-Id: <20230331063814.2462059-6-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d0607f0a-0e05-4b8f-e432-08db31b1e40e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qhEo31x2WaZktsy/3iOsQ3gF5BIXO/KkwG17Ad6lhpmK7Qbu8nNHAQeyXYQUZpMX0Df331+pO8j7QdT1lfoW3/Yb6WUes3YIjBpdtSNeRf6EOet+vMVTivzc/wFQ8VBOBwlNShsB38hmZebdfA7xcvFroSy/hV4OQ4NziswA45K7/i/whZygus4sYAeKhMiRP7hHIcVIjxbTSumUlVEXD/Kw8q+5tHiy7FHK+Dmr9PknzFv9qX0W1k7z89I5An9hUwp0pPThNbmFnZrghbvv7tpk0fqGx94M6Fnqu91xBiaiQtmFPs9opgIiJgyshHnqmpCjnw4aSRHVrYFX+0ibIjiOJUEY3FJZtvbo8IsIWDnYBSdHKBBpskfAXXV/UhLenOiuYSWADmAz9hx7j0ky01wqjGBnvgrQNq6przwT4q1mvmxxKx8/bzEsq2HnsEHA9AN0DzyC/BU2IcvaiAR41AnRZwE8fO1Do9rTl0RY1drPu0x8tnvh9QgDzWrojY1gR7a7oxu6WYwfd0KYniFxprASuU+p2gFLexqSgMaFSDBRYq6vFtEuW4J1F0dcsL5PMZGuzaaRUz1+T5LMhYTS91vt8XdjM+CEX0G5TrBxrQ78pp5qPKrNPA0JPGtZXFnMTs45pCrKSVE6FWbbPIZvnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199021)(38100700002)(5660300002)(8936002)(7416002)(66946007)(41300700001)(38350700002)(4326008)(8676002)(66476007)(66556008)(6486002)(83380400001)(2616005)(54906003)(6512007)(26005)(1076003)(186003)(6666004)(86362001)(6506007)(2906002)(52116002)(15650500001)(478600001)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eE4HPr24Pba9F9mPqQxIZD0L0rctOQ0tq0y/bBszFatG1jW+kw1C7iMqT0aF?=
 =?us-ascii?Q?WmmcO6zz7IFEdA9XqMGywr1KYBN8FOSLeyuuRjb2f8NoME2LgV2+BYsCSi0w?=
 =?us-ascii?Q?mWEvbsprWgBXlyiRzubQdNhZJjsB4TRwKx4TN6kZTN9Jav7YivfETMcKeWG1?=
 =?us-ascii?Q?HzR7lkpLQ56W+tDO95bZIT+0R9GBCktF6SnyOS/gBJ5f3WwgDncwLNYmn5m6?=
 =?us-ascii?Q?cG5Z9vtxk+epUIsRKsW3xe1U0Jdjc88rTXnS82xAOIuhUO3ctLGL82+LphHw?=
 =?us-ascii?Q?aFW+GM/R78cHB1tHIQMX8NxGVvR79aRWVlMLUHYRDUNTN9/meq/xLWaE2p+D?=
 =?us-ascii?Q?v9CUUOyVfj6dAvesnCdAuuQhNOlbYK6f1RpJk7SQxZL4dCmmOLH0U/LASEjK?=
 =?us-ascii?Q?CZniV3BkTIImOy5NTc/cLx1gQ8s9QiWtHSy0mINVTWkd+NiVMaQFgLC1tntM?=
 =?us-ascii?Q?TQreEcIS/pEf8NryHmjMy/BxZWfXs8BGlg7emwrPdHvBR19Ywm5FqB+cqaWy?=
 =?us-ascii?Q?kmi0ouZTH9dGOZzd4ICeS7QGukarva4zC3Zo2heLztfVLGp5JW9oDA42lp24?=
 =?us-ascii?Q?GB4mQXKK5i/Up1mvGsYnjIJ1ze2rjrmFGzk5z8GOVWuip/bxH3VZd4IeXfNe?=
 =?us-ascii?Q?gaEnsNK1hsallByXeaWXVXcnR2yAnUMiCWFtDhA+a0DXfDcV0RyJVX1JJpfP?=
 =?us-ascii?Q?seUa5e3xnL+K91nJFP5RHRogpZmY+Bsl0X3j1jBnN68QQhuw1CNwFSRVM2R3?=
 =?us-ascii?Q?f0U6gq8EAYUaK+j9/1VWdyoPT9PBzLq0+cKQdQ5IcxfIJGxJ2j0CPjVXtPll?=
 =?us-ascii?Q?jDIaLOqMVxOz+WdYdXApBWnjO0DQIM6fZRNgAFp0qEQ03+77b/ki5zF6d7u9?=
 =?us-ascii?Q?3uTzi3oN/dtsFECdwoPbkmMNYvPTOO6QW8Tej/g1qA2dNp3f/W0VF+1FO2/S?=
 =?us-ascii?Q?Ru7Mmxc+8KrO+8zrr6e3x23q3LdbHoavo/diD58VXAh+kzNBRdMdxsKZsrmw?=
 =?us-ascii?Q?kocoBG3LjAdt4OB+4MsK7T5S8unk8YrgikSnTQazxKJxQQnkIfgJLTr7bpF3?=
 =?us-ascii?Q?O4AcPRBTyFsu6CQl4SIjJnuNxNaSGG7n2XP5KtZAUBA10LWtN3Js6j06tiNh?=
 =?us-ascii?Q?pVCHl0EANCU5A63paWgQFm8NuLl2JpbwBthbEv20QCm7Ee7Q7BMjtRlaWmGT?=
 =?us-ascii?Q?KYOxQ8M7di78mEfBZdajkQPMUrnxhIw0L8Ln3Ju3pBSM77OnSk8Ilg//Vo+x?=
 =?us-ascii?Q?qKeh0FE9aA0uxyE1LCIj9C2K1638uiE3KSM+jCxuj05RUVr5hXFhU4To9a3q?=
 =?us-ascii?Q?odNNstLRujwLaxmKNFE64IaauW5HWU2aaIuo9anIEC9rozYnOe/rzNmm7yHw?=
 =?us-ascii?Q?GlHPfDpTQLaGHKVAVV4Xr5NxgyIzD8Jey7RKowV/mtIZlEDPTQ/CJ5zqDeJL?=
 =?us-ascii?Q?EtW/LYkMEmQWSjLdvNRxi2ABRYmuM6ubLcW+Hvz+barA8G/utjDwVcbhQ7h8?=
 =?us-ascii?Q?ebma2zScqzQcFDHGHzYV/1/jbBK9WGNFVJCPJ6efbNKVCVyuzdIkrTKwcluW?=
 =?us-ascii?Q?y509FNv2vH43uMW8WfjAySlMXEthNc6fLwqlBnZs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0607f0a-0e05-4b8f-e432-08db31b1e40e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 06:33:51.0744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMZxVO24i50YZ4LvYFIFK9XYLm8lXi2fleU8m/4OMSNh+KpJlZFfUoQVTSatBFzTjXBR5013GCnkW1YZthtkVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7356
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Bai <ping.bai@nxp.com>

In order to support bus fabric clock frequency changed on the fly,
need to update some bus clocks'flags to make sure these clocks'frequency
and parent can be changed on the fly. For these clocks, HW can make sure
no glitch will be introduced when changing on the fly.

In order to support DDR DFS, the HW register bit for DDR_SEL
and DDR_DIV clock will be modified by TF-A. So need to update
these two clock's flag to make sure that the linux kernel side
can correct these clocks' SW state to reflect the actual HW state.

Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8ulp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8ulp.c b/drivers/clk/imx/clk-imx8ulp.c
index 6a8a9e50d826..e308c88cb801 100644
--- a/drivers/clk/imx/clk-imx8ulp.c
+++ b/drivers/clk/imx/clk-imx8ulp.c
@@ -198,10 +198,10 @@ static int imx8ulp_clk_cgc1_init(struct platform_device *pdev)
 
 	clks[IMX8ULP_CLK_NIC_SEL] = imx_clk_hw_mux2("nic_sel", base + 0x34, 28, 2, nic_sels, ARRAY_SIZE(nic_sels));
 	clks[IMX8ULP_CLK_NIC_AD_DIVPLAT] = imx_clk_hw_divider_flags("nic_ad_divplat", "nic_sel", base + 0x34, 21, 6, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
-	clks[IMX8ULP_CLK_NIC_PER_DIVPLAT] = imx_clk_hw_divider_flags("nic_per_divplat", "nic_ad_divplat", base + 0x34, 14, 6, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
-	clks[IMX8ULP_CLK_XBAR_AD_DIVPLAT] = imx_clk_hw_divider_flags("xbar_ad_divplat", "nic_ad_divplat", base + 0x38, 14, 6, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
-	clks[IMX8ULP_CLK_XBAR_DIVBUS] = imx_clk_hw_divider_flags("xbar_divbus", "xbar_ad_divplat", base + 0x38, 7, 6, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
-	clks[IMX8ULP_CLK_XBAR_AD_SLOW] = imx_clk_hw_divider_flags("xbar_ad_slow", "xbar_divbus", base + 0x38, 0, 6, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+	clks[IMX8ULP_CLK_NIC_PER_DIVPLAT] = imx_clk_hw_divider_flags("nic_per_divplat", "nic_ad_divplat", base + 0x34, 14, 6, CLK_SET_RATE_PARENT);
+	clks[IMX8ULP_CLK_XBAR_AD_DIVPLAT] = imx_clk_hw_divider_flags("xbar_ad_divplat", "nic_ad_divplat", base + 0x38, 14, 6, CLK_SET_RATE_PARENT);
+	clks[IMX8ULP_CLK_XBAR_DIVBUS] = imx_clk_hw_divider_flags("xbar_divbus", "xbar_ad_divplat", base + 0x38, 7, 6, CLK_SET_RATE_PARENT);
+	clks[IMX8ULP_CLK_XBAR_AD_SLOW] = imx_clk_hw_divider_flags("xbar_ad_slow", "xbar_divbus", base + 0x38, 0, 6, CLK_SET_RATE_PARENT);
 
 	clks[IMX8ULP_CLK_SOSC_DIV1_GATE] = imx_clk_hw_gate_dis("sosc_div1_gate", "sosc", base + 0x108, 7);
 	clks[IMX8ULP_CLK_SOSC_DIV2_GATE] = imx_clk_hw_gate_dis("sosc_div2_gate", "sosc", base + 0x108, 15);
@@ -255,9 +255,9 @@ static int imx8ulp_clk_cgc2_init(struct platform_device *pdev)
 	clks[IMX8ULP_CLK_HIFI_DIVCORE] = imx_clk_hw_divider("hifi_core_div", "hifi_sel", base + 0x14, 21, 6);
 	clks[IMX8ULP_CLK_HIFI_DIVPLAT] = imx_clk_hw_divider("hifi_plat_div", "hifi_core_div", base + 0x14, 14, 6);
 
-	clks[IMX8ULP_CLK_DDR_SEL] = imx_clk_hw_mux_flags("ddr_sel", base + 0x40, 28, 3, ddr_sels, ARRAY_SIZE(ddr_sels), CLK_SET_PARENT_GATE);
-	clks[IMX8ULP_CLK_DDR_DIV] = imx_clk_hw_divider_flags("ddr_div", "ddr_sel", base + 0x40, 21, 6, CLK_IS_CRITICAL);
-	clks[IMX8ULP_CLK_LPAV_AXI_SEL] = imx_clk_hw_mux("lpav_sel", base + 0x3c, 28, 2, lpav_sels, ARRAY_SIZE(lpav_sels));
+	clks[IMX8ULP_CLK_DDR_SEL] = imx_clk_hw_mux_flags("ddr_sel", base + 0x40, 28, 3, ddr_sels, ARRAY_SIZE(ddr_sels), CLK_GET_RATE_NOCACHE);
+	clks[IMX8ULP_CLK_DDR_DIV] = imx_clk_hw_divider_flags("ddr_div", "ddr_sel", base + 0x40, 21, 6, CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);
+	clks[IMX8ULP_CLK_LPAV_AXI_SEL] = imx_clk_hw_mux2("lpav_sel", base + 0x3c, 28, 2, lpav_sels, ARRAY_SIZE(lpav_sels));
 	clks[IMX8ULP_CLK_LPAV_AXI_DIV] = imx_clk_hw_divider_flags("lpav_axi_div", "lpav_sel", base + 0x3c, 21, 6, CLK_IS_CRITICAL);
 	clks[IMX8ULP_CLK_LPAV_AHB_DIV] = imx_clk_hw_divider_flags("lpav_ahb_div", "lpav_axi_div", base + 0x3c, 14, 6, CLK_IS_CRITICAL);
 	clks[IMX8ULP_CLK_LPAV_BUS_DIV] = imx_clk_hw_divider_flags("lpav_bus_div", "lpav_axi_div", base + 0x3c, 7, 6, CLK_IS_CRITICAL);
-- 
2.37.1

