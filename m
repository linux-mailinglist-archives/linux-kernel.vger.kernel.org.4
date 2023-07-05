Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA1E748496
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjGENEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjGENEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:04:38 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2102.outbound.protection.outlook.com [40.107.215.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B39DA;
        Wed,  5 Jul 2023 06:04:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yg2Ic404T1/tDzjKxho71QnKy5GRhQw0iOhN8EDVEteYqjSWimY2jsDo4VCx3JbXxTjIbOfUAW42NxrDaHrTQwZZX6qsKCRVpySCkcNbguBZI3ZGlrCXkr33qd9tp3lRxuT5uDyJDaQUVAI5fuiIS9Wpwjw6UjHA4b5Qq8Kq9tudYaSyUrj3PNGVsOs3IQfIGD4X+8rM1X/wAsUYq/epPBwgCy39xEZqvgb3epvONI6DaeFiOVu0AQVJ57Ri1f1W7Wg6Lj/A4gj+xHkzUD7RP80nSciHImykWm6FqZz1P5TLpL2FRzmSA8VerC5Cb/aYK9Pwajf8pSFTQuDL664kpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5jXm6dQN4RzzpE/swXSXXJbHtqjwIw1Ubsqg5yY/O4=;
 b=Q4lyEvZcXuof7FTofeeu1t9Q0puvikEPp5HeFt4j800oS+cM+418RewS0J+6N52AIDcARGOVxZpg0FjciD3o7C0JLYUxTh5yRhveoWqp/x/P/2lFFsZeFqCfOtakKAbpdY+tOTm2dvMvslsxqud/sOcrrOXEwEN8dEdoRpQO1Dgh5ji8r+duxl1ie4wPQfvbRHKVJiStwtfdv4tmWfW9V3VmY9JNutLmrm+SQEV1E6umfNXyf51e8dXS1KQP/rdlDko4K7xdiegOt9touvzACBjc4845+UAtCGx/UNbbc+pmOrlBodMOw8Gy0jlzFPuGw18z9zABAIvjRMyb8moZvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5jXm6dQN4RzzpE/swXSXXJbHtqjwIw1Ubsqg5yY/O4=;
 b=lzDFXV5RTx+r0DgJbNtyV3lexa658Pa1oQkrgGWgGGjsXOxAq2Uu+eEHgJY0ITTquMQXlh38LJRHCeXL1w9mK0xPIp3sxnlWEQUFRV8gJkdG5PpS2aB6P2l2YIAkzXQJIEzBu5ZzQizw7w6D5puXxYrD5hHf02YKFUj2RUpzr7G5hK8Ld6J6U/U50DCluug70c7R7OGGRmLzpDSIwdGyEkYHbtPDU96MMz/TN289K/to3N/Zjao/KApBkSeDtO4IFyziFmpW5bLJlmS6brDuf7TNd/6y19Kp5dsY5T0d+LXUnMYC5RfMt6s83K06exdtYNkB7/Jsu3XefznW4DKosQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5891.apcprd06.prod.outlook.com (2603:1096:101:d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 13:04:34 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 13:04:34 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Yangtao Li <frank.li@vivo.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] iommu/exynos: Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 21:04:14 +0800
Message-Id: <20230705130416.46710-4-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2cd66c90-37c7-449a-00f9-08db7d5860e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pDObYfuZ5kpprLtC+PmSuY/iwzVb//Y1blheAQmldHadrHNqeMMzYwPXyXFJA4c7Rk7khNhQw6JqZEN4YG2AcKkvDws4ZxO4UscnXspy5PSKQk7NPeMKr7RuFMo/8trGsiLvLjeyxz11bmYRad8PWJFTCTWwjhBA1cLs+LPw/VVY6D0ZL0vMskSkYhfj/F0v3gdtB3xg3u0A0velpZhuauFizTKGbhnOonk50Sckscrk4Z+rPY9Iq4vMEpYFxAXESvxj1fLOaUu+KXa6+H/vMVy/fRuPzh2hG0e4XChfRP4zvY/oOKDA/zA4dFI/dZuwNsmKnVNbt50X+K2DKNS76780bLCE3Mcp3jGZabqFqrapCbWKpeHff9QqDZ5z7RJc2kOnDIRVJ352fEtkGpSa9ALcyDK2QKffrE4R5BFa/2JqeekPPrTTyj6mk+yxreZ2y/1TvC/3ZdDJKrRhhsVQQRqo0gbnxtlRiz4+7SsHGQ0WaddF1jNXDzQ2C3+MSjiREH8ryDqOihTMEoZHsmi8kHhm0YKKAYNGD9dVUHo5gUwOznPSeEgdVkuOyL2IbI92cPqnvqFM3gENIykcWxfKayHb7GDag519g3OG+4TSDp6xnUJpZue2T+qUNFhGIxky
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199021)(478600001)(52116002)(6486002)(6666004)(110136005)(66946007)(186003)(6506007)(1076003)(26005)(6512007)(66556008)(2906002)(41300700001)(4326008)(66476007)(316002)(7416002)(5660300002)(8936002)(8676002)(38100700002)(38350700002)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+2YCRJ7x+P9J/m/eIz6uVUrDbGz1iItdMgkVznr50Cv6a6pud4E8ZXT4yIfX?=
 =?us-ascii?Q?F1nbqL30nM1d/NOXEcncyitObqjAmMAAUffOu89sK0vzPFzFJfaQyixUfQ9s?=
 =?us-ascii?Q?czOxDIAun7dk98YUFeBTq6ESZSdDfUiFSEyKZ14zn+zUEgV667wx+IZyRq4E?=
 =?us-ascii?Q?+CUz8cJ+8Ddo45q5JFwhtxv+4POlj/CdNIUnqHAMS2oBPf23F2laLOTcVLGv?=
 =?us-ascii?Q?vAlkNcB2B/p0wDcISDz9qbHnnRyEngxfcSrMz5f60tBnpY98istk5Lq/JnZf?=
 =?us-ascii?Q?A+u6hyb2C5eUo/dcxtf43WA78NpKN7t6nGQi7s43bN697+3XBUhbNRuejivk?=
 =?us-ascii?Q?1v+MYZulxi9W+5ry41d0lJBoRNACNqiyd4kDYTXK1kjU7OfSxSp2pJoI4BwT?=
 =?us-ascii?Q?kIpcAD0FlzSX2gZE9dU52SPibmUOX3rFc7cwkvVla+XGPAcByY7BCS6KmnJR?=
 =?us-ascii?Q?mdg3MHW5KqIpwn6Nzq/mw0VxABEEgev3J7PrVr1VX7TDnEpWzCgBi2dPaCxd?=
 =?us-ascii?Q?ptkOln/bx1SlruJyn0/4hhXowy/rtkAJRc6moG4LioF2Zx5t1NHf3ncNzEXt?=
 =?us-ascii?Q?E/qcT2IFyHFU/6dNYze47VRVbAlyrqY9MXxynGy0VouthKKxe09pWpcumwqT?=
 =?us-ascii?Q?qqTsPpDWQWebkGUHDlNFFZ2qcXoq+KBN3RyfIYsiKTpZzdMH0qkov0YQhS38?=
 =?us-ascii?Q?9s553Q2rLFyC79/P+TNwxP2ruzjFYfLwVRJgYLpQrFTE9mCqIfegZ0YRKocQ?=
 =?us-ascii?Q?piVn6UKtEpdKx8YA5On4QV3j2NIXAgo/kCN0ohmoURxKaijSEoD9e1KO38io?=
 =?us-ascii?Q?qDYYJ7lXcO1wOK5I+n9XyuBvFyY2aSoks1an6Ei0po+Mh5Hx+SvoELKVhDw1?=
 =?us-ascii?Q?5Y/a1vvtmjxY2RJoCKazmt65bAj6k93ql34j6m532lAYJFvDsr2b052U9kSZ?=
 =?us-ascii?Q?fPwv9i8lXBy6V3F3UgUSKZX50PJbtDYUVkrs2w8TDlAYGGuPvZltFoTT1T3R?=
 =?us-ascii?Q?+diJGZliKs54exYQtpMLSpadQSKSzUBxfaiI5nP3Zb8ajAGMMk6ht+ugOz9M?=
 =?us-ascii?Q?foq0bmj1SqA8gtzc/TdHjL0/ssSWXVn1VVkR1tNkzThmhiD8mU8UF72b9j4l?=
 =?us-ascii?Q?ZtKiFQHo9LlOHcTWeVCc6vpxLZxsej+jJIOYeFTzwpkazmNyYjub+MiGiqbA?=
 =?us-ascii?Q?TD8FMGU8xDsbCp0bQGcdxiYyK75m34Z2QhX9tLAOQoXs4+OEe0QyIjCWY7ua?=
 =?us-ascii?Q?siZG4dlPGey8bRwPaDJ/QyWtLF0Ag8OobovhzBYz8KK5/9d39DVInzhH0oc9?=
 =?us-ascii?Q?pbFvDfghbiJNAwMDIw9J1ZMqHDqyc5USVJp+Ab3uHzD0B2+5/TNY1NCtyFRv?=
 =?us-ascii?Q?+8dYLfk8ebkkRCNfCy9C6bStCKBdMs2big8H5KS3YegKag4eIxwEzaJigBs+?=
 =?us-ascii?Q?d9zWiJ11FPlEvWRHdp2Affq1FvxXb++jcrWzmya1+zeHNvejlZQ9eHqcZGUL?=
 =?us-ascii?Q?x1dD0GF+4WHIz9iIy2n6rxgwRZWXMZXyfmDdhqHdIvbzGsnKTkq5tiDCVe6x?=
 =?us-ascii?Q?4dFdomgzQQ5berMF9ipm7yVptJKkDvZbFtQf4zzj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd66c90-37c7-449a-00f9-08db7d5860e4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 13:04:34.1571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GxKRRORmEbSVym3vndl8AdAsY5Ipguxr3byntiu4DaBu6AxEwA6dj6gkAeMiKLt6qQlmbtTFWNswGnZhov3XxA==
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

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/iommu/exynos-iommu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index c275fe71c4db..ab6208015997 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -725,19 +725,17 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 	int irq, ret;
 	struct device *dev = &pdev->dev;
 	struct sysmmu_drvdata *data;
-	struct resource *res;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->sfrbase = devm_ioremap_resource(dev, res);
+	data->sfrbase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->sfrbase))
 		return PTR_ERR(data->sfrbase);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
+	if (irq < 0)
 		return irq;
 
 	ret = devm_request_irq(dev, irq, exynos_sysmmu_irq, 0,
-- 
2.39.0

