Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886EC748053
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjGEJBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjGEJBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:01:47 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2092.outbound.protection.outlook.com [40.107.215.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA2510E3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 02:01:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RreXiUEDWRsFlXFH4rteZgQJCiQabu5BrN2k5xzqN+pw1I7VUzvyjL9IPJAR9vkXbulVJonEzKgRpSPcLGH47JCq/tJ8r4yaBJNdIXVHSBZIl8E1+dPnlbOUwgoJPqJAq8v7xfrzflll6QXTYaiIFQTKreDQSlB1GBGywlDif3jLChbme8mFGJcRzKKfdwI7573804eQX8TE1xnwGzPpHBj8kR/fQJ3AhqA3TnZlcZHdIuvTii6JGxZyADrWMLy2hupAc8nIhGEDL+uSSifg1+/LkUtCED6TmvSR3RtLrd+ivJv/4QUFi0L5aF7xe3JV5NdeFmQqpZn1Mb3ExlE+cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceERcHS3vIFMT+gdi/X160XFJqjBBw4HMM1zYRm1AnM=;
 b=AeBFlhjSteoHryiyMWPIPGJ0jJXyA+MCgjovIjZ3hACTaqBChl43gJAKDdr/papZmcwBF6WQ/l8d1phhXr+yPLLPefL9j3MQpd8gbTGHOnMpEb2Yxb2PelFjZ/GXq68IHkScE2Cnp+ryOdWz0BPC+mPkZQpZ5z18AQ/e8KPhDIXH6cyGtsfuJMpGUDFs8+vw3oR+Xo2QrWD5/RckpErnGw4emfQvxMxj3FPWL7qYCM4ERBHWDSRvMFbjrickhRw9LapYuuhvrOknymoCWFPYbDMFZ2g35ppaqGaMPG7uxeYn/t+S33n2yUk6ORHpzaqncnKyEbQmn5gfRswhsGRTeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceERcHS3vIFMT+gdi/X160XFJqjBBw4HMM1zYRm1AnM=;
 b=SM3uo7c4RTqfsUIWiqroqPMmR9INNhtgWcVYpEkpp6sa/ZslwlgColAzm7hTU4f/hnEWDUVq2/Cb8LFGj5BZ0LAb8BylvUZWrAcUqFN3GzWO3OHvAjNE8OCSvBUHkhzMKVtd2BHQg0cTuBzrqM7VGBxfbpbQuOLgSx9mTqMq67CP1hH8FYkk5AEy5y5LAReUiC9atTvv5/5Dm3cAOP8hC11cDkrodadnVroAnz2pa2gHM+dAC/ZZjdUKYPosT0oqmdHen9G+5z0+GF01XvxTf+rHLtZZLmLGdoNwbeblrLUdFNe3L0loKRfmsgNmpu5KLwz5jzENiVJQXYa5KLpWdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5804.apcprd06.prod.outlook.com (2603:1096:400:265::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 09:01:42 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 09:01:42 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] phy: mediatek: tphy: Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 17:01:26 +0800
Message-Id: <20230705090126.26854-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705090126.26854-1-frank.li@vivo.com>
References: <20230705090126.26854-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:3:18::19) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: a2f6f803-67b2-4106-fdbd-08db7d3673a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vx3RSBL/wOF2z9ZCcWKGfxSz9y5lpaHW5XUSZRvrV3PXOVqsLNu+C0Kn00K9lfrx1w/6mioZIOpA61AKADtIvLTAJxDAuBbkVLoz+8yvyYHW+wSL3zb0eEeTzQnWwY5tGkY+rtgzZcu3LCgYhgvJghZejOINfthuxEApjvVSOXY/9n4Ezz78NXO/6ZImiv/RbC9zy9JtUnVNq6TPgxtKm4AQgkmMwXm8WEd4rYpEmZD70VKVA8/AsI8n4DTdoN/zzGOWlHzfAR67nTjQ1FcG/jSQFaBbekUjFRwSdd5i6kMsQqK5l8WphCP3KYBDmmTw7GF1dkct36SxukLMT/Urlalm71FkybV1ShHN0gnI8IdF+EfRv+DIVvXdTjSBSeicItLlLoSoqv01XkUIe13xnz+Hv9iY46osVJUErNs4IvFtHYeq/qHxL9yjErgiqgw2zk/AcBhU2ZKhNmBzwJnTAm6PFKTo8VHOx2FC/BYZB2YjBAImGtsw5dboGbVoM419fRKZMelZYKA8CJkrBZsUFGSV5Z9nl4zDcrBiUb8NGG8r2o8IwB/pk1fcieXEaqVRant4FraM8v8FpdqdfHX79qLkf2by+Dr0J7wGPSwV3bgoHFGMd/HVTiK119M6eMSD7RK3gWOmBSyG9+bTwbw/2urnAAgRhX1RixAYJdjeoGg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199021)(26005)(478600001)(6506007)(1076003)(6666004)(6512007)(86362001)(2616005)(186003)(38350700002)(66556008)(38100700002)(66476007)(4326008)(66946007)(110136005)(83380400001)(52116002)(6486002)(316002)(8676002)(8936002)(41300700001)(2906002)(5660300002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0KUbe0Vj1FiIg0lToaP9vN0/L6Nt7oOCqzeVbT7sTSbcdzaZkMrb29kgf6F0?=
 =?us-ascii?Q?IT13OlpkPQHstjK32pLCxrrR98diZI2bhQgEz/bOtArr7evr7bDabNrOkvo2?=
 =?us-ascii?Q?65vlpjUaBK13Or8fnU0f50iPnWBSewZGCXza4fu220kEZ6WeZNjULD1vx259?=
 =?us-ascii?Q?/OGnm3tVNNw+3c43rvs7fbtN0o9b8ZLVvDUv7xWxvb2rxRgRDCivGIZO/eci?=
 =?us-ascii?Q?u2ktBLvgAjG5LCq9mjhq5M3V5OTItK+UcUKQegGvSAvDNv+0U967dvffla31?=
 =?us-ascii?Q?g5nZCpde6qcbvn3nSNqtjhQl58RdE0TcngFjo67VBq+udiRQQ0tUnIwOUugp?=
 =?us-ascii?Q?dL5AacVtjwCE59Bh5FcyxZI9UjznKdBYH3N8PrfgZxgm+Cq3QZRynj370kIl?=
 =?us-ascii?Q?n/LkqyLOXTBDdddzor/YJW1RoKG7WKKSjHr8Wq8Crz7T52zGyPJCpXh2h/Dn?=
 =?us-ascii?Q?dQLljqCezde2DKfv6/97B2XQ/nyDo2jSc/GuxudPLkW/sUOPrujxxO/6JrkV?=
 =?us-ascii?Q?HSdVcThBCr6d39WFvlurLYSv/2jRLux51nmfgRVH3I28hoPJCNcQM9+5ykV/?=
 =?us-ascii?Q?pqL3leHUF5eBIMtYbaeJYaUL1+FahiRRwF8us7fRA77Lxu/FW7UBZMPVhPrN?=
 =?us-ascii?Q?DDmbL5kdK/ojzbs1O90pvlG7HJ8EHDG+QumXY6z2rktRTtnUjmYAbtRqMKDn?=
 =?us-ascii?Q?fNxVECsgaPah4ioHmxZVsKZ3achTl+sL6HKfa/BSmJ/iyvttYkcKc92ocoi8?=
 =?us-ascii?Q?MTqNDypLjOJW6GL5Gb69+XKxvgyENBFk0lA/8/+uUSdrlCJMsOLNftU1NNJO?=
 =?us-ascii?Q?ypE0E681m2BNynSFwaozyHdICXG+jxLUfHGy1DSD00VqpjcnakxXNtx3eHGb?=
 =?us-ascii?Q?UQYrLTY+8Yzo4siiLoanEJf7t2KHxtWJAxiTOT/WacltY9+vbX6+YpW8dI7s?=
 =?us-ascii?Q?zVaFSxNwnb/0YuF/Dh76ySWYQA+NlJWQj3OznbyxpH73j2F8BrOeJRT+8Fha?=
 =?us-ascii?Q?c3wJTCy5B/q0r4lYQeVTvetTt2a6vT++OW0WbFo4n/OX8CO42CJ6TqeU+ysn?=
 =?us-ascii?Q?aPdHFU3bv6abXWzaMtnC2+8PZ6AX6PNWYbnM64CLNiCKhYMsoCawclJYNQuN?=
 =?us-ascii?Q?Yn2VXAdMrcrForn7JQqca9weKysCN59ErbluJeLtqlntgOHKnw4OiM9HWWAn?=
 =?us-ascii?Q?bBEQ1y5PM69AJih/H9aQzgKixt1EL/WmEsh3p43NG+fKrp6eTtFtjbvmFli5?=
 =?us-ascii?Q?OU1IH7UfyyFZLS5Wd9JAwgHRoakUVZzWJ46EUJzPO+oq9a+mzenHe4lg6/lv?=
 =?us-ascii?Q?Vf41N31uH7A3nrw/gQsAVcMqm2Lv3uM1i1ccliDtma3ioIgNbcBMPK/xqzfM?=
 =?us-ascii?Q?eUdZ6WBzirnAhIq6CPju9QMCJv8WD6yLC/8wP+CFr9HDVKn0QKWir4efYZGy?=
 =?us-ascii?Q?3zx6Ez/1uNOY6tXSfC1IQLcbHP6flFl07bHTTpzci3Q9RH95Y/+UF0fURe8I?=
 =?us-ascii?Q?PxwzU7vEeSBObSMqrYtrjLygeAvy9FqooWE+MAWwby+GllMG3oEGfGA47WBl?=
 =?us-ascii?Q?M8ZEpeHo9OgmtoHJ7h5FO+sCUtMD9XM0Af69j2Xf?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f6f803-67b2-4106-fdbd-08db7d3673a6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 09:01:42.6609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNJ3vMXy7Un9yMJ5K25ueEIPhNDMfNjWS6y7jDbiycHG1bt+RhhFDpF3kj1HasclO/ElHyHmColtXlMH1aNWAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5804
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/phy/mediatek/phy-mtk-tphy.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index 0d110e50bbfd..cb7a4e6ea017 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -1554,7 +1554,6 @@ static int mtk_tphy_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct device_node *child_np;
 	struct phy_provider *provider;
-	struct resource *sif_res;
 	struct mtk_tphy *tphy;
 	struct resource res;
 	int port, retval;
@@ -1576,15 +1575,12 @@ static int mtk_tphy_probe(struct platform_device *pdev)
 	tphy->dev = dev;
 	platform_set_drvdata(pdev, tphy);
 
-	sif_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	/* SATA phy of V1 needn't it if not shared with PCIe or USB */
-	if (sif_res && tphy->pdata->version == MTK_PHY_V1) {
+	if (tphy->pdata->version == MTK_PHY_V1) {
 		/* get banks shared by multiple phys */
-		tphy->sif_base = devm_ioremap_resource(dev, sif_res);
-		if (IS_ERR(tphy->sif_base)) {
-			dev_err(dev, "failed to remap sif regs\n");
+		tphy->sif_base = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(tphy->sif_base) && PTR_ERR(tphy->sif_base) != -EINVAL)
 			return PTR_ERR(tphy->sif_base);
-		}
 	}
 
 	if (tphy->pdata->version < MTK_PHY_V3) {
-- 
2.39.0

