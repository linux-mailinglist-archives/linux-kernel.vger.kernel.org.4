Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1886D40EF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjDCJmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjDCJmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:42:04 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2071.outbound.protection.outlook.com [40.107.8.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C19113DB;
        Mon,  3 Apr 2023 02:41:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsMIbfTnihOBHowdXLj8PVcIxlj/Ndei9+F3KX3WYRD2U9hy7V4ATBQ5bX40r06Bb/S3gJczqwpRuKs6rAXNYcBfQ5h1nFCeQfikOYugpgWNjl/bYy73dpdIbWRQpbXUdfrGbZYaq7exQdfMHgcT1Hg9aQrdqXz6CWahXmnIuZAo/R5v04U33yGyi46hvUz4JSnO+TgXQEfMeSWtHgEJplDnDxdIBTFfjN2Z6vBaXWM1B9iWBY0is1sR32zgRkknVoUnR+G7p0VbSW6U5D1+dWqnCmjDJNojLzUhn3444uPsgE6VWLP1wNjXqBFSj/n5KehViGZI+/SmHEBSpAaYiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGAK4P5C5qM2/kEq+jrWiNZ1w1eTawwpwQsQ3Uk/GhQ=;
 b=htGrtwNnmTvbbbQ1QAhphqpVsk2kHM1U2+0oTVkoD9sklwHXoGuxeSHYbvBk7NmzxmMsakIORaYc1nONTvEYv1V7jgc12FvbJgOm09oi9DKCxiPgVac0amOBMJcL/y0xO11jgcnq1KHlHpcUjlLFdhRRZ9nSbfmeCkTGGLzHoAUVSJIsYEngIcUkaIEQo7uuzwZo+AY9ybsMIN0Viy4mQLxGEpj0Q/LR6Sguyq7pLQuNoAQ+DljB6te4jBryjdzKItJe7j58y5lUKs0tQy32Sebryeho3ynHc6AcMK+BdSAHOISXDj/jQBxQKcIvWOcAEVpI+w7sVTwuBuTAUv6Mpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGAK4P5C5qM2/kEq+jrWiNZ1w1eTawwpwQsQ3Uk/GhQ=;
 b=CzcELveh3D8KdyvsEN8CFmNoB2w/3b7yaAT4wQSsm1aErw96z/25Jk3IBx7equsbQX/VkbgqCfxq5/jscsmxNfVCyl2YEhRmTF08p6gqcTWXGH4Xo3IM5eo81QdgeYkBoDRzreck6ICiPfXqqq2Jwx7FDETjX1LDbYOl/fOMvAw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8595.eurprd04.prod.outlook.com (2603:10a6:20b:426::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 09:41:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 09:41:46 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Liu Ying <victor.liu@nxp.com>,
        Sandor Yu <Sandor.yu@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 3/4] clk: imx: imx8mp: Add LDB root clock
Date:   Mon,  3 Apr 2023 17:46:32 +0800
Message-Id: <20230403094633.3366446-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230403094633.3366446-1-peng.fan@oss.nxp.com>
References: <20230403094633.3366446-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:3:18::26) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: a767249c-0749-4ed9-830d-08db3427a3de
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zNaQkX8gdsUAkuzFiBLGbcy7oEhvZtS/PdB0kqKpz85XCIvT4e2Qb0PqyMzxGzCNE4EE9OoKhf6Q1iNcHSjoVEeLI5yNa5ECmqbHTX/lyfCh3/cxoToRqAhwMnFjt92ZlhCwiyMAvzOwdN7bflUGzrGJK7FtDF4/GaiRZUy9R/+FttR7SPMjLroIWmB5IG7oDzGZiLJtsnBFCzgHpp1+PqHAKi+FFchOy5n8uO5NvxdcK3Nvl0rh3YHC6JQ/bAWOtXevZDYePjr4IPCQjVqhramVQBecHHaOVYvvFKcID/TUd3yhfPKTSQOntN5/dq9VAmBK8dVHuPW4rsgbA3B+zIJSRgGMbgbPWo7iEMynPStGkqxYKtvr7ED3TwUsOVBqkUQtDcUiHlxBNMeqmZfElqOnP+3uSyyH6LhnIoa5drcfI3wuhFDxJe/aTZd776jZysOVt3TwOXPuZwjP1VndK/xDOm4a5S4zop9ADpiiB4WmkUgYOMBBIugnTgHRaibrNMayI+dMMhiY9Xwc3ZTZEVmmVUSVuSiVB9fVjdhjbGm9aH+8cHlyOkTFoX4FQUSIUWetwSZ6QHNhWjpzzu/LvJqRjS2HDmyahxGJAfn5BSjfarAmOgizMkXxDTNasjaWWlR6vqJcX9JW40DYiZUUtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199021)(8676002)(4326008)(66556008)(66476007)(66946007)(54906003)(316002)(478600001)(8936002)(5660300002)(7416002)(41300700001)(38100700002)(38350700002)(186003)(83380400001)(2616005)(52116002)(6486002)(6666004)(6512007)(6506007)(1076003)(26005)(86362001)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WvuTsoDliX9PnOYZlMsUXyKK29hoZzEy+HyuTLaRVcjesZ869Ml6RCnfgrXH?=
 =?us-ascii?Q?+PubSf7aKKl4WxLqe8gieC4qdD9y9zsj2ywMLu2cZWTqpCWHojHx1DV7gtih?=
 =?us-ascii?Q?0TSV7rOy17Rk/5kot6cVlkWH2//NNvJ8Yt8XqvwqrHP9924flXdWBLCYy5l0?=
 =?us-ascii?Q?JIFNZht8obuYqmCxbUiCOR7wUn7Q3XIewAryIiLf7pjPk+Q0IyR/TKTEYnnK?=
 =?us-ascii?Q?YB9Y4u0w5UknTki1MpbM+Wk4IQUVWkcEcoi944+lmskU4o/ZsSu6y4Fk48Dv?=
 =?us-ascii?Q?awONATiwcLR3UKa+oDZVgpyQKKjP7SxCgyrAskwajC1zMtrT2jhZaZ+aYXLv?=
 =?us-ascii?Q?hHj72rRMoCIHueWbmbrbcxO/gY5DW3pqKbyqiWm53hRwpbVbi1PX3q/fGCEj?=
 =?us-ascii?Q?zSC9+rMRRIApeBy0dZg2B3H4yyWcOc+QGdY0++yGVY5yCOW1TsxMJzZq+ef3?=
 =?us-ascii?Q?rYCehJV1TUOcc65hdH4hnRlsNdZT1Hkt/IrEdNWkaGOaCvCcihLT4vKWaBa5?=
 =?us-ascii?Q?8k8i9OtASdwS/oxlcHukeIQU+njR05jRbFov1Cy1VN1oZVOlankpFYtS+t7V?=
 =?us-ascii?Q?09tNbzVX4yGk9vPpkLK/6xWze8chL5MTgzQjkoK4/zwPykc+kgye6R4kmq4a?=
 =?us-ascii?Q?B2UZc579NiKxYNXFRk6gUjjZzz7pRYVj6FPsu/lp5ROCcAcn2VFokdUQy0QL?=
 =?us-ascii?Q?iKt1Le4ftsDQHX6NNEMbEwPDOsyyX2q/m8wsrXr3YTtHAPopVdERZW8SoO7v?=
 =?us-ascii?Q?9VF5inRx2nnrfY4O+s58oJYTLBM8bFABapUBhjzC2S8Yl78iGWM7p4VSfLYA?=
 =?us-ascii?Q?91qggfQld2jcR/bcZ638jSrgXfQPaU9jysH1B6hv8rzP/T0p7+hwYE0qZyZt?=
 =?us-ascii?Q?u4i+wFSg57zUsTk0AlCA+08wQ0cLSsq5cVCVoeoKAifwjR85NtZLGmvcHnUJ?=
 =?us-ascii?Q?qgFrhRlXtb/ICpCUVjoAbAaFlT0qeva5IRNeOXlODRuaqyO5bwQJnrbe3uZc?=
 =?us-ascii?Q?eCdTzXPvBsK23JdBlrYDMRmyjbwcTm4QUvbKmgQVY3Eg1RvZDrifphw+mOxL?=
 =?us-ascii?Q?4GoNunj/eMsSFBkvQogKpMUNGC46qTbNAggXtY2TMB726DZ1aDM9S9cE5Odm?=
 =?us-ascii?Q?NZP3F+zWT8ll6fNzBrFHJZdrP3pPJq0EQKLr2sBUfNXRZH55sFACBnFUIWFQ?=
 =?us-ascii?Q?Ju4rHnjFiBtr6CHw5ExgdNV2AvS+7g7yNPO6ZsnxqveHQkccyxc29IUzywEv?=
 =?us-ascii?Q?6jASbvJLSbiByKq5ldJxqh7uLPdiQSDP2RZhLBg0How1FnL5bAsHJh4STDnT?=
 =?us-ascii?Q?n5EcjIrJ58pjCBqD3fp/EeZR1sZIsa/psOTFdwrQCuSNgcWO4UHQoGjPhweo?=
 =?us-ascii?Q?qNsbEvhlk9dy7i7pq/FAEZgZusUu8g1qMIdYefs8K28HO0aJczm7iZzHN506?=
 =?us-ascii?Q?JmxWbOrNYBQ7rUZFKcdoA2GW0HyNr6ro05LNojvwVKKc9OmRkUe9AbZ7PbC7?=
 =?us-ascii?Q?/7VyCwS1PTzDiR10412e7qZHQZ3E6dtv3nu9Oiz9Ezb3TLsHcOunTgEojp3q?=
 =?us-ascii?Q?SCNM4wFA93XcF6A+DYC+9Gy1H/lTQZiUifOYDZTM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a767249c-0749-4ed9-830d-08db3427a3de
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 09:41:46.3112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fE+HEihif0USp0NObWS17U4zXS6DMefWKzT/aFECwDlSmCX8xAgMRPDJkmYiSnl45bpURIFUlpZwGYUc9qSYzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8595
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Ying <victor.liu@nxp.com>

This patch adds "media_ldb_root_clk" clock for
the LDB in the MEDIAMIX subsystem.

Reviewed-by: Sandor Yu <Sandor.yu@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3:
 None
V2:
 Seperate binding

 drivers/clk/imx/clk-imx8mp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 4a0f1b739fd4..8dcaeb213277 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -696,6 +696,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_MEDIA_DISP1_PIX_ROOT] = imx_clk_hw_gate2_shared2("media_disp1_pix_root_clk", "media_disp1_pix", ccm_base + 0x45d0, 0, &share_count_media);
 	hws[IMX8MP_CLK_MEDIA_DISP2_PIX_ROOT] = imx_clk_hw_gate2_shared2("media_disp2_pix_root_clk", "media_disp2_pix", ccm_base + 0x45d0, 0, &share_count_media);
 	hws[IMX8MP_CLK_MEDIA_MIPI_PHY1_REF_ROOT] = imx_clk_hw_gate2_shared2("media_mipi_phy1_ref_root", "media_mipi_phy1_ref", ccm_base + 0x45d0, 0, &share_count_media);
+	hws[IMX8MP_CLK_MEDIA_LDB_ROOT] = imx_clk_hw_gate2_shared2("media_ldb_root_clk", "media_ldb", ccm_base + 0x45d0, 0, &share_count_media);
 	hws[IMX8MP_CLK_MEDIA_ISP_ROOT] = imx_clk_hw_gate2_shared2("media_isp_root_clk", "media_isp", ccm_base + 0x45d0, 0, &share_count_media);
 
 	hws[IMX8MP_CLK_USDHC3_ROOT] = imx_clk_hw_gate4("usdhc3_root_clk", "usdhc3", ccm_base + 0x45e0, 0);
-- 
2.37.1

