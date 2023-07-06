Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B41749915
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjGFKLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjGFKLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:11:20 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2106.outbound.protection.outlook.com [40.107.215.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9851B6;
        Thu,  6 Jul 2023 03:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCbXLdwEhtyFLb06XBQ7l8yjZnXSkyfFpPuOxmEIdONz9FRv5YhGy3x5WR78hkXPHwG+seZFAvnb/bmVs+559iFHtZkW90FqQPrFIH7EamAZ2gQz0vq1ZPdiHr2oyIKfuUZjUl2EVTnxNWXZjlCv6P5u+ZEq2mktomkJV64NwZwdm8V3enczf1jWMlQc/XOBDWJqRR0e0AUtvVOZP8ztfw6EUjuG9TIFA/RUfztZLzlZh7SRvvX/kNLB/OJSE9dkUh1Y6P8anUMh9SpFN6kFHFEQjeGHGx2pEItJppQ55Xcu+rQTUo+Bk3437odIoPbDxwGan9zKz7w9a2c+PPv+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfouEtqZ7uS6ZOcDGWijvrv3iSSdFp2d2nCGg6/ubeI=;
 b=QbGZmM0kK0PfFF/NBWUSPgkf9v/t/4X9FZ4/UA+lSlYwWzE4M8vup4B7Sx6uOYVNoxEmWphtucCsRUdk+NxjUw7QNW69lPvVYwGRksO6ft95c30zWER94ny0f6o2VM1YjKFlADeDXnAlHdVDBpELnaOtUna4AmxOxOrmBZaul+ruL6Gz7M8q87lrZEdrTX6oZ9XEsvSKQFzgbSNjWp66Hmcfcjs0wtejgY7TReuBhb7XxKTTWSnZLG0kKljmjxtRGTAw3XwGwGTe6r2i9VxxDKd2SvhMMa1cqEpG0IJmVEbmj1AVrUVdciRdBjaSLV6pI5ftzZ1S1OtHddzbkOCMZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfouEtqZ7uS6ZOcDGWijvrv3iSSdFp2d2nCGg6/ubeI=;
 b=ac7WSQjo6Y+jAwL0L/kCkmGWKyBx1amRWkiKz7f2wH1G+JAAptmWzMPCeKT1Kdc1s7nFk/q5MlvPe6TYx9scjpt3uea730fl0i6FIFX+dmY5AOEgpWSOVO25PU1vu6mRNqs09ESkkimz08tjlVgoiQd4H6kZ3z8dxgEKxpE1OpfIqhsYuHYAIDlNOR5o9ba99mGZkjkgHc7Sxcf2VMCUIfKQIPfKbaSnPedqu8htN6vNxtAmlTg9m1yOHXRz8l5KITe+QtnPppeZn72cpkLtqlch7d6O/5eIHy0A4Kbb9Gpps2GfeF1Qg/rJukZ9V3DWYaedIYRhUrahptRUSeODiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6447.apcprd06.prod.outlook.com (2603:1096:820:ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 10:11:16 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 10:11:16 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Eugen Hristev <eugen.hristev@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] media: microchip-sama5d2-isc: Convert to devm_platform_ioremap_resource()
Date:   Thu,  6 Jul 2023 18:10:52 +0800
Message-Id: <20230706101100.75654-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706101100.75654-1-frank.li@vivo.com>
References: <20230706101100.75654-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d24267d-1e3b-4eca-49d2-08db7e09559d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mnTHNVRqCM9YIiyAOdt5BcmJW5YJFwqs8d/Y+PhfPxgYP+RsA42rBFO1mXjYR+ewFgi/V2KjLfHj2QwrQXEqGgn4hCJmlvGXmsbKPFlsvJbOH1Vs5ZiIHY4mASbAE86q4Js4lGbAurHhvbOA6t3pXESfTK6xuKkWNxouVFkoWHFaC0heSXXjlk8VY5Cq4nrS+Wge7oyW3RSw9x+RizN5qpDgxtDurRz62oWYLsamieom3oSk9gEYneCeJXszEfYpSouzMA2DwBVIzVEj0SUrPl8KaFwkB6PknKCoEXuN/Txn7m/2knDxYOaSv1BFhJu5B9JvsQcsReK1eOZo2gFD8VaFkjAJWSfffOvKgd06yYv3wNGckBqVI5cSsFrbU8OSiB+RtkDAKx4JYYCsf+MTpxOfkH52zYficg96l61g0XirLb078PBiXag7BoYy0y8U3HXEoXqVBV2spgl3KzSX3KoUn4RKtUbYv+F2dAzrJv8GWnpu1grickpXAgz9qs0nhln6KIhRIX8BrZz7j7pugfOI8jCyUjMV6huw6ICVQ0N++mycxC3uOv/ZBW82wu0GbQzxt+V7ofwEipg/RiiM8prf5v0W1yPX7i61uvlkW/LSFTR3YMSEGqLFS5GvgaCt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199021)(8676002)(8936002)(86362001)(2616005)(83380400001)(38100700002)(38350700002)(316002)(41300700001)(66946007)(4326008)(66556008)(66476007)(36756003)(52116002)(6512007)(26005)(6506007)(110136005)(186003)(1076003)(6486002)(478600001)(6666004)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O/zGWsX7DCjy3Zz4mRDP32tJMy4rujmLmigMPlTOP3pS+eepiTTbQWI+YGg4?=
 =?us-ascii?Q?v/nlE/gIYDngYCALG+MNtUIbYkkaZPJJa94992XlCpwBNbp7phCThlouy1Iv?=
 =?us-ascii?Q?S2QjadXXsSE9DTJ7dU4i/3BqHix/7F4DWue6AkU4iljOk8Li2wMAY6IqdDJq?=
 =?us-ascii?Q?shLoO+ig/BE4jJ+t24lIKOvvJ8u1R1uQdpLMkQdWd1/SPVFdy8QwMKNrAnvx?=
 =?us-ascii?Q?Z+2c9BrZ8JVoSFLDI2cEhzjqNixV8sGWU4nJXKCCExoWBf3sBZe7bUYurjXh?=
 =?us-ascii?Q?lsBsZaVPDyp/es/f90oVHHQymkS30IKadLgem35YuzbQq4ZcVyHS9KrYdFZH?=
 =?us-ascii?Q?hEcEsTkLcgjExklh7ewCOHUCSGvpBtn2Ql/LfPPJhaItj4klSJRvcNW/tcbp?=
 =?us-ascii?Q?OFNqhdD1t9ZFv65NRfCQpSfLuX7f6YaVnJJLA0iENG35usUxG9NojsiKQodO?=
 =?us-ascii?Q?BuP4t6Fvvjg7WaTpBiwI7iH11XS+qTb/tRjkxR8xpUX/WoUNxuDr7w+1Mcrn?=
 =?us-ascii?Q?1UyqQG/N34LW/rPcYHh/XX3cKdVGxlZTvvMAdwhoJ6g7IpNIyReeBPY6egQz?=
 =?us-ascii?Q?M9KuKqqnP9MOyQ2IyRZY4sFr6VSjqKtBpK2B+luI4m2rxN9VugMetXiaZEUr?=
 =?us-ascii?Q?vwRkxUoB0/3638V/Ylwylkqh9rteLbtf4PNd6lDlxI4pMIC4IMa7yRWV+xWs?=
 =?us-ascii?Q?teCilM7OXqN1tQpNYSQVabFyBSBnlNIFmFHci9aKtKIMDlWlGRFOKksDHrNE?=
 =?us-ascii?Q?dDJzXjkawmHq85Bb9y3KR7gK4oLC90ll7LAktQVvo7aYetsg5y0Dzdtn3ylY?=
 =?us-ascii?Q?o4q0alVxzTx/2TVWvCE07zgkdkeKKZpGJxxzlERRX8BmkIE67MXo3zovSJvK?=
 =?us-ascii?Q?LsivVakt9Di9MR+IvIhXDLvr/Yju7gfXfLs9iHmuDKMqeTwj0HzEOdgWxnuT?=
 =?us-ascii?Q?qHdPoQK/kjY+7p0Z4UEFQX+jhhiG5MqszmBUyG43EejtkIYQfkeALWFOIBBK?=
 =?us-ascii?Q?PloXkCVZInw5xjGA1zfaZZvpGX36QTBlDNDQC6oBzuxlWAXGYZOV7PXZEUGH?=
 =?us-ascii?Q?7hE6cU0Kjr4qLi90na3GY0/prvX4STOiX+zYEDyBF7sgPvuzO3eBTHnPdtLK?=
 =?us-ascii?Q?/EelT7DGHnCksvTFgS3vYqx0xWnqT4LCrtoV4cEvgnVjvZNebQHjvHm55ZME?=
 =?us-ascii?Q?SEZhx80vV7d+GSLDSAWmx5e5pSeKN8KDVAbNpRHHe/f8QnaayMxnEEhGcSGO?=
 =?us-ascii?Q?HZevShZHBKJGBZ95LNtWU2CLpebr5D0kIdFEYzViP6iPFf+PJanXGVxwPcZE?=
 =?us-ascii?Q?/Mxl8U7nKM/Br/N0TqyKrgPBie6RaxuhElxy7retPtIATWFtAtWBja8Wf/Vj?=
 =?us-ascii?Q?z6Es+Kb+j0UxiCFE8or4xwADhpp/ZfUBO56P9ZlZF1HgCuyOFxE+qNcEgQON?=
 =?us-ascii?Q?rZWQtmfiphXoIZ4SxigHFkQ3QILsgXPO/1N1MYK/fzVMaLJOK7GmrlGhTvbQ?=
 =?us-ascii?Q?ss5QrxCMu6Y/FGeu+OhV09ImasBp7UlEWpj/HOxFymrbJkFfgXD2+oRdyI5b?=
 =?us-ascii?Q?Rnmh/TrALQBjlFNTUkpgx9sLPeLYD+nxKGrftUas?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d24267d-1e3b-4eca-49d2-08db7e09559d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 10:11:16.1387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMP8O7uUt/ap+zawtkp3kgo8UymKFscjWhCoMOvF7p+csBHJYZ+oFiN9Qj7pWbS5sJo2+84mXgXt/hB8xB5p1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6447
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/media/platform/microchip/microchip-sama5d2-isc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/microchip/microchip-sama5d2-isc.c b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
index 746f4a2fa9f6..dfebb58bfd07 100644
--- a/drivers/media/platform/microchip/microchip-sama5d2-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
@@ -409,7 +409,6 @@ static int microchip_isc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct isc_device *isc;
-	struct resource *res;
 	void __iomem *io_base;
 	struct isc_subdev_entity *subdev_entity;
 	int irq;
@@ -423,8 +422,7 @@ static int microchip_isc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, isc);
 	isc->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	io_base = devm_ioremap_resource(dev, res);
+	io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(io_base))
 		return PTR_ERR(io_base);
 
-- 
2.39.0

