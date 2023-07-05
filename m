Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FA2748498
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjGENE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjGENEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:04:42 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2102.outbound.protection.outlook.com [40.107.215.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013EF170B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 06:04:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsWqxWcMtZVe6PHyrijfvJjGhv/9akCtqDmFLuHrRc8zuX2ayJIZ3Rj9ermLztnT8GkGqxq5JbgrEMidkNDJ1L+irP5ftzAUHyllg4LhB/hetsGJbZgEaGffeL4DKb0ACRhJ4DCwBICs5f59EECsS7jFD9WKLitSXvsrItbLtsUEg6+syIeLI1xdNMeJlAkNYmA6A7wPpTOUKV5IOBU5FkV48W1qb/ZujTtKtULxFfKqHzuia0kCpSl81Gw1KBEqtdTNsKwg6VE01nAoMSUKYOXUO1Dt39dU0le4OPm1uBGmB3w8mlX2EMU6l6/LYJXcm7wek5J8vkf6ZIa+ZWHEzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/FKROkns/aT3W5EmDyW7I75f5H4AFux2NcHTMqTyeg=;
 b=Lk3PZUjjTatXwMvInN15dFRo+cxqQE2rzPo7XGbHfu+6gX5IxNGObi2ezUkYKt0t4QlbHFRL1Cvho23boIbGk6x2XvPCveDrvSvyFb2pFoaOkVWpemfd9PSql3s/69CDtuRUdzIYoqRyjWpdt1+aujK7x9Qnlfw+bzyPhIU7khwr2sW5p+sCnN4k/1T3kGnAK/+o7vvf7HDIpOzKQNyAvg0eabhadMNiC217SXyEK2oRKcCRStbRJFlWh3dN9TmFyMQ/tE8+xSaPxxHi/2d5es1SNz75pUGK8DTFxD4uF3Y/FbTfzDIuia64p649JChrQpwUiWOZONrRTYPF/C4fSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/FKROkns/aT3W5EmDyW7I75f5H4AFux2NcHTMqTyeg=;
 b=mw5fp5zbUfOqbRbJrDrr9j7E5QuI70wJxeuO5cNpqoppGXIXQQyMY6+qa3cw1e6bZJDQMpkBmnM16sj+92UndRzhjzygPtB9JicrT8WaaQfdK0ptmn5ZIUlssbikN2xh18NrX/8fUcGI5iO+TFIfvIwNhEsVobQ5tlYI/fWo09aW0RvUwABtIda+ohnRwqP/bpGpFRNmSwpCwFDttM5GCmgbrRqFa3qs6lsaYfYaVj0OnKGSegmuxbvchgSmMRqydtVBkyImz/oWqK6Mw8kX3c4XBIPchkNAosP9oxplBPJi0J20xdZFMDckrIsIlp2gM7MGHT14UoO63yEnthbkdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5891.apcprd06.prod.outlook.com (2603:1096:101:d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 13:04:38 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 13:04:38 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yangtao Li <frank.li@vivo.com>, iommu@lists.linux.dev,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/6] iommu/mediatek: Convert to devm_platform_ioremap_resource() and devm_platform_get_and_ioremap_resource()
Date:   Wed,  5 Jul 2023 21:04:16 +0800
Message-Id: <20230705130416.46710-6-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705130416.46710-1-frank.li@vivo.com>
References: <20230705130416.46710-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: 870f86ab-671e-465f-c37b-08db7d58636e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZR0e7L239CRxNQElPl+JqckKIX6p097PLgV+vXugnQBuJX1bDQqQjpBCozATTrDzwgbi2wK+kEIlbF16yhOGKCO/K8ZZTdRa+3frQkO91M+8CHAHiEsyQtXGj/WK9skicipwu8kQV1xzIbKOeJJw9CkiPzNA2QX1tRfudx9mF86V5l5Qpxg51DMx622a//pvUsTrN91Fr6IejGEO7ss41JrTt1nToXHADbBNYjvyOPwHYyYLND06Dq21qBOOboMWRuJcEvXZLZbsTB0dTbnEPoL211yvQz2c8OtdUIia7tC1GDXP9Q4qDedMawY0OLmUkI4tteKNJT99UAZuhHBdCV1TwupcB7zdNiUd0msMsNIA9MwCt1K0I/rrzaHjLomyN1ZULYmfliBoy2pCVCiLPlJSUxzJpDpbTwi+JxyDWU6JqVI/KuiXtE0R7pdxFHPWZt6sprwCdf0F+1VcPmDLk5fdw/UEi+LIuB078w1IRht7ZqAOWzKpX1xi7irSE1FpPOxQYmk08ATGHMjIvhOkGIUV8/++lm68mUMB4DI9rqcxR2G8oXkZWwi6yiRdE17gwfDsf1zJTAS6SsiC+UEDyt/cNuWL6Ki3nHs5l9tv/SMZCbYM4u7ETcM5JroVt/Ul
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199021)(478600001)(52116002)(6486002)(6666004)(110136005)(66946007)(186003)(6506007)(1076003)(26005)(6512007)(66556008)(2906002)(41300700001)(4326008)(66476007)(316002)(7416002)(5660300002)(8936002)(8676002)(38100700002)(38350700002)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?axo3/Hke4orzFWFk8sRczp4LmujEeFQayPyj2gcZpNgBaE3API4mXWWMdC2K?=
 =?us-ascii?Q?BOhXKrRfwmO1zWf0efCwAc8W/9QBR/6jp2/iCuN3fzsEBKuuPg5RmR0BfOi3?=
 =?us-ascii?Q?MfM4bg5pSeuQgENT/0GTmyfNXFVsbONCVY4s96dev5sGwFmTvnbxv1pBktJU?=
 =?us-ascii?Q?C71uHsqOe8kG0wopAmyvabwKz1pVUZdQwUIqZ3yoZUC4P4Ij5WpM4mc1fM2e?=
 =?us-ascii?Q?RLoO0uGKqKXmJNPvStTeyWhYkdHL0NySldf4UtQt4ryW9huWez/8HtftQhaV?=
 =?us-ascii?Q?FknduCdeKWru7SaRP9Oq1NW55iZj5k0+NlnuMkTioNVIqukNMpuMNy+GH/bz?=
 =?us-ascii?Q?Hu5iZFvhxuMiBy/RvAY5xd5RpYRzCcztKUny6XF+B7+1aj3H97YVcGl+QU0A?=
 =?us-ascii?Q?MZn4oscy8KtosRMzt0WvR5uFIDvubTusHFJa2kHTNpr4w5Iz9W6hnI1hoDoz?=
 =?us-ascii?Q?Xu34BX3L26JJQBUXl53YY8+Ao5KDPkr4jnSgvf0W+aQrtJx20+Yuciealr3g?=
 =?us-ascii?Q?8GHRSM1UvZXpxlcDSfAxMgZQqKsi7Gd1F6NMzwBuVKxQZYFmezgjWnA9GMEg?=
 =?us-ascii?Q?V0uYfKz9Lrt7MHwCXtC2zBxpGJfNesa1JY5cSZ9GJH1QV4eeGof4eGM6qEVT?=
 =?us-ascii?Q?MVjgGlyCEzDRP1FAeM1XowdOr6uHCmv9mI1738trAXnVuCmrKHlNkDpDm1GS?=
 =?us-ascii?Q?7pQroP32ZSSvPGJ1smWJ188sBt+r2GZLIQBTBlUomzrmD2daEvQOk7vkUuFe?=
 =?us-ascii?Q?RLOS2eFV97B9Wd8NhDiphUorx2qiyQujPfhjfTzeDFSyYoz6c2ZBW4l2If1F?=
 =?us-ascii?Q?fc/+IVFvpW6BTZ+2K4v2/t/puAIgIIAJz15ptEFKEpU3aSkoi68SUS87eXmd?=
 =?us-ascii?Q?OPwgEFpNdun/e6F0WAlQ8OuUwNXu8DOHrvlP4VaL2DaUTQ5Ru0g1RDbOCfzD?=
 =?us-ascii?Q?+9amZARMcBDAAkkDIHjCkrEQ0RCf5fNJD2s7uYR6UrrrzfgsZMM/x5e2sWsa?=
 =?us-ascii?Q?MSzQL6khgMst4dl2eMkEKhSp5wPhgGXSnFt2qv0o7SvDFtLeHwuwxfaQuSKz?=
 =?us-ascii?Q?HU0zJL7E49co2OErRxqdw3TQy3X9QYfrfzNvDtfMeksOZecA/OIyHy+4a0KI?=
 =?us-ascii?Q?AmUus40MlTw1WHLr4iT+uURYMzHPweRlTZmq9tDweZhml9vquiSrnAV+qvkn?=
 =?us-ascii?Q?9BUjIKUmWYxN5NXHwMPEq1v4F+NO8lj/08kGF0FbHW27xZ/lfpgoeBRjfTk8?=
 =?us-ascii?Q?gbZjqqk99oj7HcNxtP1/DRkGr+ecfvjGy2g15o1KOPEmKoDxof9kX1YM/5ZQ?=
 =?us-ascii?Q?LduyazuhJVQXnlX+ft07C+tPsRpTOUDQ9UYifVYYBYEtqlSh/+QfJlRMTqMb?=
 =?us-ascii?Q?3jFE10Or+GR5gAqlTnmbZXLRbN2hw/H8AHsFOFkgx3ui/LTw8FcKrsoa47ww?=
 =?us-ascii?Q?MPLiJC6D1Yggkapp3QyOqgUMGoV+UYfGaN9OchFazqKs40GMGmSHzhDoQ0Cx?=
 =?us-ascii?Q?Q3sW9E/Xg/KdrgCGUwRiaNCB68uN5DrbBAOiPqtdCzBz97BJ2RhZSeQnbzv0?=
 =?us-ascii?Q?AMv38ThRnksb7mimnVCJ2jDyVf47FRKR/4N6iq7j?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870f86ab-671e-465f-c37b-08db7d58636e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 13:04:38.3339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GYVDiyTZfgiWfx+6/UQY21V/klpdSu56kE/G8SDsjj9JS6f6j+CRYW7xZsmd6SAhhNKfcQPAsQneRMyKQiG4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5891
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() and
devm_platform_get_and_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/iommu/mtk_iommu.c    | 9 +++------
 drivers/iommu/mtk_iommu_v1.c | 4 +---
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index e93906d6e112..6595a25c103d 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1264,16 +1264,13 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	}
 
 	banks_num = data->plat_data->banks_num;
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 	if (resource_size(res) < banks_num * MTK_IOMMU_BANK_SZ) {
 		dev_err(dev, "banknr %d. res %pR is not enough.\n", banks_num, res);
 		return -EINVAL;
 	}
-	base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
 	ioaddr = res->start;
 
 	data->bank = devm_kmalloc(dev, banks_num * sizeof(*data->bank), GFP_KERNEL);
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 8a0a5e5d049f..2e116241f80b 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -610,7 +610,6 @@ static int mtk_iommu_v1_probe(struct platform_device *pdev)
 {
 	struct device			*dev = &pdev->dev;
 	struct mtk_iommu_v1_data	*data;
-	struct resource			*res;
 	struct component_match		*match = NULL;
 	void				*protect;
 	int				larb_nr, ret, i;
@@ -628,8 +627,7 @@ static int mtk_iommu_v1_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->base = devm_ioremap_resource(dev, res);
+	data->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
 
-- 
2.39.0

