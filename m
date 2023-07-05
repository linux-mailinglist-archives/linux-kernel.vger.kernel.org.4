Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C1A748497
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjGENEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjGENEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:04:39 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2102.outbound.protection.outlook.com [40.107.215.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0A2E3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 06:04:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZJ7rRUS519+VdxM3JoGYl5HDhIOHBTtCzbLF9PimaGF1culQINVfbdhgJH5PwaBXw/9TT3OP2QhHUowqvwF23Tj530EJgP+u9r2DlncHdnyt84LB2xHNKp1nzSMIGty/vF9+XIfmEZWClzaYHFB3f8Yq87r3vEAM+/cMG2gAY/+B2AFFBdAoEWGl5oJ0TzpP0Qj8rwNMGrYjAGRCiBuABeAL1sY+sWOqY9lVExJwLW/LDEyNq/dP8V+npHl0+2Ay3mgpMPJSf6b0bdGmJBB3f87SGX0PeObCq5WoFrrMbsvkegZabgjUPsaWJvDqCEaHxC1vWy2/OkEmQx/oF2FuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xd3vD87R43+XxY+DGCoQQz3hynb98Cc/gIxYz773wFk=;
 b=QvyPKAhfHhdxlGfs1dAItsUWrJJt/t9UXGnv6x5bms3sJ3dE3UfCP9KVUWT/j2TuuCMfz+WnsszoSJRds3AFIISY7MPE8BYHvdBaHy5+i9CUfmLTbxpyTkRVFh8AcTTo4HVJ1+R6v8pcqaaSbdyTMjtjt9e4gtZr7ALOq1Scc2BeYwitSY7N2j1tkjlmgke6+dZaAI3hPig+tkA5DrGpU6D9UqlV3OJVrSTvhD8Xokt7BoJVZXfX7ApGXZ+tqDkyk8MVRdzo9sVdY1iTuflij+unmeZdjftHLas0OhpMqSKmKsA6Xo6hTK4olzaLFprnATNn/OUli9zQSvyLNGIDeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xd3vD87R43+XxY+DGCoQQz3hynb98Cc/gIxYz773wFk=;
 b=A5X3ZxYTrR0byV289kGdv1vVkt279Uw8S5v5PIPIqzxsthvzlopIc5whvESV4EteRaf8KJlg3bqXi3wnBRrK5ywhIzNiFTwyZmCNR0DyTBAusaUtaafqtpaiT0M8KYcJSK1VSDCLh1mTUbQCHmFs7S1UsYxNYg2CJcYEJbhOB69aUNf0XN89h7kUWW7GpqawVYLzf8uT5b2K3vZa8X/6idD/dwJR6Eot0CwyL19vU7PlJQLBnFVnf2if2fUiPZ4FDWNDt2oDw72iblkiZdSUV+xhV+4F/8nZSxfmJTEFs8eyzrQ9Or654h/kxZfkqykqCS3ITPf6FanGeD8dMfGzsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5891.apcprd06.prod.outlook.com (2603:1096:101:d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 13:04:36 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 13:04:36 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Yangtao Li <frank.li@vivo.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] iommu/ipmmu-vmsa: Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 21:04:15 +0800
Message-Id: <20230705130416.46710-5-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: d90bafa8-5466-4db5-bfe2-08db7d5861f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lAkcLRNRsBlAedwDahNxJ+OsQY1fvpaipmL/oI8vzQvWQ6w+Fzkx5zVhoaiGUhJfEsYxQPBk1yI7mMZVtrVJ0tCCt2Vf2Ou0emhOsVgl706V0cqvYNpSoB8XluSp+TjdldeIRAFGVi8BB0erWn4ScyYMlOp7bJJli0+5ZstMatZXNn+1HoH5ziwlWbenG1OeJsiokXW20qMyIdSYscsWfLjmGELBySzqgyygfeevS+I1RZvrOFqao9CX6EkJCf1UwG0ndU/O9jUj8dh5AKJ/p6gocUVbV+n/XHKsWZsDzsssD4w+6tZfh4qif2Slns9/FjH/SgTeY+AgrPsdViUXhBHNBv415Ssg+NTFVmW1oyAL58nJq6ZqeZE2lR/7SdYmpBDy6GjxqE0rdHBny7MFJdUYenr4KIrSDqOl6NpMxnjV2MrDOxeypHBsOM2AI5AmfVAHc3Ef/VOT1CVOQ9pIZgo2lAa7Z61lHQcGvzJz48Zeh4cbTlXdiGoihZFSJXB3lCsYQcNANWDtdbFgRGCZEiUignBHsdh2PTC8H2bbC371N8uOJKtMbIdaZGHwS00OfaffBSHPTlDvpe0YMBB2kpDXI5VbC40Y1pGAdnJ250qMxfGQ57jl4XalPZnQuHHd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199021)(478600001)(52116002)(6486002)(6666004)(110136005)(66946007)(186003)(6506007)(1076003)(26005)(6512007)(66556008)(4744005)(2906002)(41300700001)(4326008)(66476007)(316002)(5660300002)(8936002)(8676002)(38100700002)(38350700002)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/emq+h0iTRT16JsCLlk+RBPR1jYXB4SsYL5uf5BHPUtIRE6kccI9BldXVUbf?=
 =?us-ascii?Q?iBj9uvmiIhXns/0bmFNIeHY1qabwiO7istVloNDqUV2IbUcYhvA/shKEOxd/?=
 =?us-ascii?Q?cFdKRfVMTvdWxbGYqHjWH9ql9EUi5tcgDGttErS0jjqN87EXMaW0KUWBEA0N?=
 =?us-ascii?Q?34CqoRNPeYDZG2Ni7ajakFqD7CPSY6ctC3yRnXE3b+JzredEcvd1xs5LvS1v?=
 =?us-ascii?Q?CVZ+PEjqiwI0WSEkgSKA+vRqpMoWeIp0sgQ57ofTKm2Fta9bEd8zwj69ddFv?=
 =?us-ascii?Q?oTDNLNi6O00kFqtZDnAbXG13cCZOHu2BoZC+VjkA5K+f4JQEm5pWviYXb5Oz?=
 =?us-ascii?Q?2qTVl7+tsyq2xxL9DVXrbC+2LZAvTlfRYz6+3l8IlH2jg6wadMk8+M4Xj8Cd?=
 =?us-ascii?Q?dztE/7m273OTevM0z0GzOd9m1ZwemhKCVt6Lw2E/RuXh7dp6/O5JMWxOD4dA?=
 =?us-ascii?Q?1f3tBy5z6Jav+JQ2ipoWn3JN21MF4xQBUXQC0m9ijuoFWVq0dq5Wlfhc7TlY?=
 =?us-ascii?Q?AVZhntYQuogq0bev5Lcu9j/E4otrDKn/6bbv+y91aM1ErZbXhRXLgKb0ZgJO?=
 =?us-ascii?Q?MHfKJV7YWYcY1HyTvaMSpzaqJrIPnyiPfZVeTZIf4tJNvxcZPeaoxePTnuIj?=
 =?us-ascii?Q?eJX6wNkLw2CHx7x0PCDETKIiYhPjeKRlKr2wmSVo1oxDKmLt1tFASZ1hiYo1?=
 =?us-ascii?Q?J5zbltl+CKD72at0+UWfH12MNXhaoqd3PUVngxX380dG8iMQYnWK9a9/mwuY?=
 =?us-ascii?Q?DPOlCB//5dg2OljsqCwWOJG0uHjADVqtmhmgG5HULVYt6T2qn/BQZohz3xsl?=
 =?us-ascii?Q?sjX2axpftUUHCiYqYvyum8sxRYWN8aS9NsdNmtdeIxxmTgLmdRNiMeuUTuN7?=
 =?us-ascii?Q?ctX3IpntRbgN+4Gji2uhqu79dLVkIibvk79xdMz+8wqb5tq5P2WmYAI9ZPUO?=
 =?us-ascii?Q?Yaif76R7WqwxGMkA/5UwjNewCA3aliUfv3U55TRKjyAU4eozLxTcC888QD6V?=
 =?us-ascii?Q?mC4M53REHcuBwSah0o9Aj6MAfNqU0LwvMC9w8IIECnI8VNYhWN92gdeltrDm?=
 =?us-ascii?Q?rpglVvBRcKDi5ixZPyAFzA32NQ+7x5G5aWGX50wi+6RlWLl5B5WSXIvYzR2B?=
 =?us-ascii?Q?2t1fD4BClZ6SbbABbvyQJFEuLTSUltsLgUuIrOHPV17H8pvmp60i/Sk+AE9R?=
 =?us-ascii?Q?4ETV2wjJejUJK/hacwslgtVNO/busDBmGCEB/Qw740NXMWZBAmainp/TYrQz?=
 =?us-ascii?Q?vaNyf/02oG08zPVw8p4ATEHMJN4b1zy4yRBfk60Q2wCu4t7ZUKlQWr7HRkf1?=
 =?us-ascii?Q?HIzH47ko60x8mT4rydgiGOeJnRxiR6oSrgpBIRcmXP+9GvEym1Uwx3d/KDUf?=
 =?us-ascii?Q?ssptZtbLAaLDQyxpwNmdk4sRGPZe1SEvJ3grwF15ouJx2DroTJvDNkbjjK81?=
 =?us-ascii?Q?XILFmESICOLiBU0iuSF8xGMHRIsWRzav88//hWoCG2X6s7ICH3SXYb2XO8Tl?=
 =?us-ascii?Q?BKuMzobRY0LJXxToPv/nm40zEgWSXduo/FlJGLR59StHa6XdXj2tQUw7FLJ4?=
 =?us-ascii?Q?FMF4eXVo5EklDs3Zo0TsLgqNl21xjPK3TItZ2NLV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d90bafa8-5466-4db5-bfe2-08db7d5861f3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 13:04:35.9263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efr0DIHMfTg9jpDozsTw5txQ9UUYiijVooLWEV+8EJ6pQaIMvrF0yVUF0Fr70EXX2tkhkOVmPtda4CJtnxPXSA==
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
 drivers/iommu/ipmmu-vmsa.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9f64c5c9f5b9..01cf577e597c 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -976,7 +976,6 @@ static const struct of_device_id ipmmu_of_ids[] = {
 static int ipmmu_probe(struct platform_device *pdev)
 {
 	struct ipmmu_vmsa_device *mmu;
-	struct resource *res;
 	int irq;
 	int ret;
 
@@ -996,8 +995,7 @@ static int ipmmu_probe(struct platform_device *pdev)
 		return ret;
 
 	/* Map I/O memory and request IRQ. */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mmu->base = devm_ioremap_resource(&pdev->dev, res);
+	mmu->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mmu->base))
 		return PTR_ERR(mmu->base);
 
-- 
2.39.0

