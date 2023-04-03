Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CA56D3EA1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjDCIII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjDCIID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:08:03 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2041.outbound.protection.outlook.com [40.107.13.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11BD3A80;
        Mon,  3 Apr 2023 01:07:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAH3d86pFprgAuYcHtmS4hMRs6GMQS4aAipNmCCgewr7oybdTk/F21eBAAxgTwuAcjF7BySgc6oLlCR0f+6Hp5z0XpJN3WMv3oBntVQiIppaQjzlXLKlG38mmQ8O1+QNl0rgq8LfCy2xUlOTE5guncrb6d7/LD0yrbUn7vB/C0ammnX9qxoEoawxXghwNe2ZqGrP6+cRBl8sJu0/R2aywui0yjmpfT38SEA7WvD72lz03A7bqSbbsgOV6axWf9ttVPdJaHUcu4/FDaIGssGoxGBKf5Muba1bAYaPZZTMPWklqFZYYShGcnIhRWQDm4mS8Sq+YKrHlGoNj6Or1JDHEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBf5YYZVd2liZdsPi0F/u2XDFSLtK7FEf2m6YKFL+/o=;
 b=cOQf6xH5YIC6yGb4ljoDV/TdMV+YHB2WdykQ5VsakpMWTaQkFGBiBVblOFNDjRLytI7UVn2pL95933RHnkTDU+3RWJyUtwS93BE4cgrLZyy1ORiLwzUGA2u3QTNOQLFeri09MAZi9mnCUcDjIdUWwcG68Ri8A+XRVqKjoPWdTuQ7Am5up0/tb1soM2WPvhZYa1UYbBB/TtU7B2jlchpEcZXkkfHTNQbRz6ePS/ILUTxDsdHyNKcP12FGqezXH6jUvB0pIZpJ31NgSqkM+lcpUwdKlh07PGkF2j16GTmRwRG+Fy6Mp72+7WIbIoSomWQLm+0RM3v4K02XYgclv+uiZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBf5YYZVd2liZdsPi0F/u2XDFSLtK7FEf2m6YKFL+/o=;
 b=TfvKUSJx5rYq5oTriJeQgGVlwlOdnMC7GmZ1GV5nDG4T9iX7W6dmBlML67kQ8qsKN+qu5hfo02t12QRsH+79aYHFJXzfkCxE+l3uTtLfSWWg3dTurym6VDZcebp9nfuiT6k9ovjnlXu/n0SyTFAicD3ikwSZQwnwyexMkcMdCL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8090.eurprd04.prod.outlook.com (2603:10a6:10:240::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 08:07:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 08:07:55 +0000
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
Subject: [PATCH V2 3/4] clk: imx: imx8mp: Add LDB root clock
Date:   Mon,  3 Apr 2023 16:12:45 +0800
Message-Id: <20230403081246.3194230-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230403081246.3194230-1-peng.fan@oss.nxp.com>
References: <20230403081246.3194230-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0197.apcprd04.prod.outlook.com
 (2603:1096:4:14::35) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: b277623d-bce2-47c1-097d-08db341a8749
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nsGwSFxHnOfblQEevs2vCFmtHrJiA8QA69Oim/N6JV8gVrf67UVsjsQhEXhaCIcnl8vP8mCRURvIvAcHcnVe+El6p3aO82l7NnFyubQU1ODIh+j0figfzAGp7RY8rsFI6TIjX0nt5HHiTpLiAVZwJsufNl6fIaRsNd6g0e+1O1bOzr70NS4eZwAn3Z6aW2Qj+LT8cyIjUGaWjE/UStleKXBs68Q1n7CmYdO9vwIkoghZAwBPQn8S/NClTByV9sB8wNs/L4UlTyV+BOC+z87TP7UkWgmN5CE1Odyaoy9qI1RXszMmbAdOzhddbP4veR8zytkINCam06aUYXGJXCMPmIKb0ysY7rKx6ruR1smz0nqNIH1l+yQkSK88T//osef3HURMtJzj4DfvB9LlE8H9jouDzkUXbedkLxhJ1hv4t/eZtP+p1TWo+syb08exGUPSuZev4L/TbiyvrOS/5msIRyuJBecMqG7gpBQ8BaKN53Na2lzYyJiqtOC0YwDflt4x2vKVajK9VynKUswNBs0b1843X7hPtq5G7l7bPeXQWpm1ijvUwfn/yzSIsjlx49ALTDUNfuzQr7RtZv0iqG267s/8jCJV+RwOCotBqeaVRrcpyHbnwZr/j7hrhP1w2g5EhtfMNGFENn7IKFX0++nrWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199021)(316002)(8676002)(66476007)(66556008)(41300700001)(4326008)(66946007)(5660300002)(7416002)(54906003)(38100700002)(8936002)(38350700002)(478600001)(86362001)(2906002)(6486002)(52116002)(6506007)(6512007)(26005)(6666004)(1076003)(186003)(83380400001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wTP6gccJrlAwLlK6x2J3pQcB/ao5oWKlg2HC/qCeBmbFuONM5T3u+5GwBBw8?=
 =?us-ascii?Q?gLYbQfH659wayYrqnzzrJujhQJLMQVqzIapwiotnUOrojWO8CFSX4iRDkBS0?=
 =?us-ascii?Q?ajQ4xhQduqogkN8Evk11RaFa6sNMX0PKoiVW4lgrGZpyMKIWMZYzAbLNt08z?=
 =?us-ascii?Q?W1M3yCpwHH7Ra31aKSA14QcXBiFl29P7yG2B3ZrE0Wkb2n8XXw05kBtEeRqB?=
 =?us-ascii?Q?kUF5C2NmDbv8zn+qZzZqNs5UqCraPW2jIP1ZNMozvqY+UG73iZehqvzTCRe0?=
 =?us-ascii?Q?4zN6P5TF3PiI58IpPO49bBUMDx0ff0cW5Rja1fdz5xFAA50mKulVk+x0SYu0?=
 =?us-ascii?Q?YWK4nC5DFj2LUYRbdTLwsdYieSctMRyya3ZXXXvEuwSooUihy4XWDc75AOhV?=
 =?us-ascii?Q?ATc+lGaUfPweixLIXOT/EenDi4Z4KoaK6rj1JuG4jURJ2WjRqu4M1J/vQtV7?=
 =?us-ascii?Q?PzoavJ3HtsMUIour15SZ06JJM0x84BDNva96r5LAsDzpnUK2dorGTZEUr4KY?=
 =?us-ascii?Q?aVw5LTzS+aN/0bVeSgyMdcerqLuytvjBKQnRHBaCDgwnRpnBuJDXOj5fk8wS?=
 =?us-ascii?Q?AzC/UNZbELwZwnJqyKI8ddbfBWMN83MgtlUF1Ys3YH+14y6bSYdbtWPRCF1H?=
 =?us-ascii?Q?3Onqm0QJr3WGl71Le+KjKrMN8paX19/7evSV8qu528Ww+j/ATliqEn2bDIOU?=
 =?us-ascii?Q?zUxFqsGtAliPq/ZmQY5Xs5gosuhIjmHS4qGZoCn5jfgJh68U0xeEreySxGnS?=
 =?us-ascii?Q?XFYyQM8hIJxX/iDGTX8y1d6qFee8gNCkHAfFLeLoEMyUeemi9D6s+YiFg0bk?=
 =?us-ascii?Q?oYqIZnR6/g3StQUljo8nNbXLNq6ubIe1qroQGQ6sHPBcbCGdr4q5nI9OkDmG?=
 =?us-ascii?Q?+M89QR7aC2rsXxzr7t7uvtTCHs45Ti0/SgIADjAu8J6t4Qr0WxzjlwKLwepF?=
 =?us-ascii?Q?gnoGOYMX2gDkXXDn6fu6gnlRiCGHD9F11LgJ4FJCJNOFYV2567wQuhcsT2AF?=
 =?us-ascii?Q?76IUGkr7GdmMkI+ZFpnNIJw+OWGNVtCVNHt4YxAq4gb4aOWTwRiEbK7KE23M?=
 =?us-ascii?Q?oru/KzEDqtJ3ZaBoPn52nCpLXJhO3mbLaAkpFBx9J3Jy4o7HrlMHxKxlfsKh?=
 =?us-ascii?Q?okI1AwYX8I0GWDCfqMIh5JU8hokiyupVN1lgPBE3raGKGZ4ejokmQEazdqBH?=
 =?us-ascii?Q?r88pq2wtiDdJLXqS7NvqySyKB3CH1k4HoM3WQWtF+YFlL1mARKRFsqoxjmDt?=
 =?us-ascii?Q?+u7WNhbKi0HeI3JWuZ/BlK1FfCh9MC3m+uB2Ei8OymbrbK44yGIbdVM+QJoc?=
 =?us-ascii?Q?iHlZ46qkJ15WCQWnkIkga6S2MrqolOgY9MjVemUlOjcmHldIjdmOOvGzTF+J?=
 =?us-ascii?Q?AqmWjizumKAbLXM/RX1mCZwZiQsBAbUnIpey9WD2627akssvcphBu8YnSOxR?=
 =?us-ascii?Q?a6s/JXO6gLAxyzDq+WEFuPQJNvetA//HnBVPwo3M7MxSMH+k68M2u8A/trAA?=
 =?us-ascii?Q?SOOePE+e6cjT4vlgUWJAgC70bRvgKLBOygBsWHyn6A1gPxkh2OYSL1PmVQ9w?=
 =?us-ascii?Q?OWLFiVM+QDNs8JedF8c+jGOYfod0Cpt2mhU+b69e?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b277623d-bce2-47c1-097d-08db341a8749
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 08:07:55.0079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HzfHFBbVNZtL53jsdKqQqZ2GcoREW8AZURiNR/yT9KyxmWZZEXukATNDq5M2c/QkwXmXbfL8bHdoHWSSSSwImw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8090
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

V2:
 Seperate the dt-binding part into patch 2

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

