Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF326D1846
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjCaHPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjCaHPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:15:07 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2044.outbound.protection.outlook.com [40.107.247.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31166EF89;
        Fri, 31 Mar 2023 00:15:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bE2lh2hSMsLH1v9VpY/BARBh7EH+Xhz70L8Gw1RqCIpJefd9wCuzn4xmxI84frZCOPVWjD+rjcr/UV8pts04UY6vAAtRviG/M4yElr3knfk2LIelBjdAmcGifQoUSNRulUxiF1bFs1ycExZhF1+iY7q1qyusIahs7iBdAqI6wUfJFQI50n2NIdm9SpL4UK8EI/u3uLiPyQbxgwzQNmaVe0Revga8vL9pe3oEXI5YprrvuOQsLy2/Oc65sBqMGwfboE5+1u4XADQZIE5MfY3DqUQXuoKlCmB6pmzme3ZjOUevPLAFVLrrZ2nTTIAfwzKYAnrEglFgM+E9sycD7OoI4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oL8rUXszAukBlFOTao9ruPtsLkTggkzkBC26qYN/hXA=;
 b=KMp55VtEdx8sh0QFlyCVwDWtto64CJFKcqtzQEgSi9Mjm2mJllgdjOan0cFPiEol8mKGQETEMseJY1DUSqlP6iDhy8kqjtbTgFUf4IzswoK1VxeqfuJCicWC7azXyHu8scQwQkxFm8FlQGdShg9jHEAJiGx/5fBc0NCWYzKrU8xKBrth2g6MHwQ7ivhyWEzIzN/yJUX0eOewXS99cok3pmbOnHebETVNVuShG5sv8uHhnsZZqo6/bUj3pUWwuAO6K/3kWolsR+5+5SkFioEzjiTEuTQtPhx4zz9g2kgvdMBF8RBb4ssNXWfEO7BLqFxQO7LEx7iAACTYXm6ymDaqcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oL8rUXszAukBlFOTao9ruPtsLkTggkzkBC26qYN/hXA=;
 b=cnBPcOIeJMWOI0jaYwTZhJTIPPpp7ZOP3gwGBGrCgaNQZfaQUunLs6DcL/RCElLZ5+wElc9bU7YHWrfne/BlQ8XHnOGZolvaM2U5fDeBxX0IVkWbeV0zNU3Buttc+yvWKlnXF7WHf82UtuspWqGIwszoT27AOc6O5T5l0PkHYcQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GVXPR04MB9879.eurprd04.prod.outlook.com (2603:10a6:150:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Fri, 31 Mar
 2023 07:15:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Fri, 31 Mar 2023
 07:15:01 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Haibo Chen <haibo.chen@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/3] clk: imx: imx8mp: change the 'nand_usdhc_bus' clock to non-critical
Date:   Fri, 31 Mar 2023 15:18:01 +0800
Message-Id: <20230331071801.2483686-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230331071801.2483686-1-peng.fan@oss.nxp.com>
References: <20230331071801.2483686-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|GVXPR04MB9879:EE_
X-MS-Office365-Filtering-Correlation-Id: be245063-3545-4056-6a88-08db31b7a436
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J3YA4LQbKS5ePEeLXjRKg8LKdbGFvtZvKxBFrAYvPbbBkaU/PpKQZdcUpYuu+YAGE2pvguy4JTuu14Rv0yp69FJnrB45lMEqCD7b+MBzuAgARDao/Hfr9ezPQae1zSa9C9ICjjdbLZmoXkSmZXQtOGAEFzdj6UfZ8tA8z6I9C/J8wMLNo7yf72E6ALC5V50oa9wFBgw2v9ijiFZ7c9I0dKIlSzXovjwpjAaS6TdRqP9Zr1ZaXvDGuJZ/xEf9JCgudwpiwpz3mI0yGTP/vUNTlaShiQ/M9SdHRuPzPjeTNrN37rbWGO4kGYNA9xGce/EY/fszzDHeSjJc7yD/s9hnKP7Sky+Xh3EyDtKBUb8RU50qWOaZ+UrcC8mP4uRSJpO5DgZ0ZptUGlksPVnrkiZJcjNsJvzAoxuOza1HjP1znTQCXVShoVy1IHAWr/ABotS8psiM4exu/19rIVTmn4L+FJQ57MPxgyY3/hsGusJKJQO9q4tjhXGbxt5E7OxiffwuUn570u+W/dTJFQlRzXphvcbHYQp80H48u2eUsHRRTgajMLnLN9w2p2BjJKX5mnypFYFz7tXbx4GyVfuMB6F+UnS+EJgp4UUgFkL8oODzSCRYb3AyGZ75OZpqhbk6xYhh7vFcJtyDb17o21TP9U9rtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(66476007)(4326008)(66946007)(66556008)(7416002)(5660300002)(38100700002)(38350700002)(316002)(186003)(41300700001)(54906003)(8936002)(6506007)(2616005)(83380400001)(6512007)(52116002)(478600001)(1076003)(8676002)(6486002)(86362001)(2906002)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SgQd0Yhqo+EFBnuwG9LmOApt5TT5fvqIJhh/O3ai8sJGcq2MlXbBYADruHLr?=
 =?us-ascii?Q?UQkW0k+KGOVb6DMmAcw8dpw+ZG9EjYml8LifY+k6mGp+ivhUrElSetgYNE5K?=
 =?us-ascii?Q?8ntqzQGRd09Yi5xAe3GUtAVPqAZYuhUV8Pq/kV6TEfhoctY5+hHNPtR5IXzI?=
 =?us-ascii?Q?jaoP6Op+RR91Dj0IzKY7O/Ow/4v5lYF2toh+hEI6RA1wdVYYPe4uE5mY1Tuz?=
 =?us-ascii?Q?n1TGrPU6CjcUIVZmMQAENxU5VsO0DThQxHu30KFnaeroDdlqwuLR5UpSSaDp?=
 =?us-ascii?Q?88Qujj9b80DDbMdg5a+5HbOEUKl1ngBq7VXp4/hGyUwnfwvQCsNiDrp0xzRd?=
 =?us-ascii?Q?R7EL2W8oArv4kAo2j/4a/6zN5GV4XEHqHwh5SXTO+kTWkfcTXRjV6xI5j1O1?=
 =?us-ascii?Q?Qwi55MEIOCUkom3tHt8n+i95mz1brmUSGhivJ5r7fWvHRVVSp0B3ddYf0VOT?=
 =?us-ascii?Q?doO4VzSbMqGhqmgSp2vMSj0nSC3kh/xtU+aMan/XhJYIklHqwj24GLQiPtsl?=
 =?us-ascii?Q?p+jqg5nGmKLrt6WxHxs9udN0eVzjF2Txk/HSzMsC6+StCAS45uzJMDay5vGy?=
 =?us-ascii?Q?IvLW82UjttiarDy3s3HkI2cwPQwWftdvMw8eCqxTK7HJFoIORlAgBU/HbYhm?=
 =?us-ascii?Q?n/FNJfRzKJOyf6AANnfZi5TUxUxKJyyfWic0QbAriqqg6qjaeousgYOKk74D?=
 =?us-ascii?Q?TO0O4nIfFlpqD6HCVyNw89SsenQR6/Kv4gzPEe3zMMZOPR1zGhyhfjvK5pz1?=
 =?us-ascii?Q?YZIW9mHHum1Ded7xeI2yj2u7EUHiwMVhBUwCZSqJ++e/al/scds/HkDDsvXB?=
 =?us-ascii?Q?Z3NodktGPE7LytyXSBzHdbzH0+oBvlLTetTBEcy121DNPs4BOxpp6wDJ16Pq?=
 =?us-ascii?Q?wZjFTPvgVyIN28LYS0woE1Ez64MammPYm/IYmzOiFEEOhJ92xqVmgxVPV/R6?=
 =?us-ascii?Q?kFmMaLTewM6Ss6q1zj9A5UwFG7OqNRketWtAdpJ3BoaJ7shh1li6qsr5HCgg?=
 =?us-ascii?Q?r8cUXEuT8SWp9PbpH7e9RSCk13e4PtM/iHKpZ1hghj132Lx6jPum1D8PFUfV?=
 =?us-ascii?Q?BELVyVisBmD751fO3dC04OCyTizNFKjd8vc4dyk/1GjhBLHj6UDzvWDfN7XW?=
 =?us-ascii?Q?ll0lr/sGrXkAAj0TOKnj05uogiRSE7OrnffV9sJ9M6GH+r7SfqgbqUg1t4OT?=
 =?us-ascii?Q?7smA1esCPAQd5yl0cwfqHPosJvm+L0puFJU0pGOaYvaoenm9CgsuRVJ9r/Zg?=
 =?us-ascii?Q?6nqCoygn9tw90GqXaCAwA8cO+N5Cox4DwW3TuE83PPK/vrHXkjPQqAc/6HSd?=
 =?us-ascii?Q?2iWApMte8I9OqetotNboBT3xBT3CTGhwjTYYfPEWxu9l8ktpPZ8n9PyUuSRf?=
 =?us-ascii?Q?j0BDKiDGZb0jQo36EfjOXgIZx6SsQAHQPjhsBPOC06GfeVeq0Syekdqnx7kC?=
 =?us-ascii?Q?XmXmbTOMlvTj7qFYGQfnUDaCKZPtdc63evn6zGNZvdNbfDRkL28UO72TwyJh?=
 =?us-ascii?Q?NeHMdG+024PDn1VrcSmohdFAiGyKgbsM4H0UMTl8Z6Nb+rb9QtZopKCtF4L6?=
 =?us-ascii?Q?nr8ZnW5Cal8bFXem3BD60t5q/Sd8CJ2prJfJ8uLN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be245063-3545-4056-6a88-08db31b7a436
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 07:15:00.9730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDPHK5hBDQDhTsOnpR5UOedQffq09OAYj6FqpNgQRWrR6s1sXygThnuV8P5TYEVOCq0CdBgrGMnhhTVNf1fA3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9879
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

The 'nand_usdhc_bus' clock is only need to be enabled when usdhc
or nand module is active, so change it to non-critical clock type.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 8dcaeb213277..f26ae8de4cc6 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -538,7 +538,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 
 	hws[IMX8MP_CLK_MAIN_AXI] = imx8m_clk_hw_composite_bus_critical("main_axi", imx8mp_main_axi_sels, ccm_base + 0x8800);
 	hws[IMX8MP_CLK_ENET_AXI] = imx8m_clk_hw_composite_bus("enet_axi", imx8mp_enet_axi_sels, ccm_base + 0x8880);
-	hws[IMX8MP_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite_bus_critical("nand_usdhc_bus", imx8mp_nand_usdhc_sels, ccm_base + 0x8900);
+	hws[IMX8MP_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite("nand_usdhc_bus", imx8mp_nand_usdhc_sels, ccm_base + 0x8900);
 	hws[IMX8MP_CLK_VPU_BUS] = imx8m_clk_hw_composite_bus("vpu_bus", imx8mp_vpu_bus_sels, ccm_base + 0x8980);
 	hws[IMX8MP_CLK_MEDIA_AXI] = imx8m_clk_hw_composite_bus("media_axi", imx8mp_media_axi_sels, ccm_base + 0x8a00);
 	hws[IMX8MP_CLK_MEDIA_APB] = imx8m_clk_hw_composite_bus("media_apb", imx8mp_media_apb_sels, ccm_base + 0x8a80);
-- 
2.37.1

