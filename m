Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B70749437
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 05:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjGFD23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 23:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjGFD2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 23:28:00 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2115.outbound.protection.outlook.com [40.107.255.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A271BCE;
        Wed,  5 Jul 2023 20:27:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUmFmJmoF4L9wQSjUfLpW5v8VjFs5P5gUh2utaYlOIK6iqIhMqNQKKAAZmPl5Y39EWrXJIQBR6GWkCola1zPLFcXLT2R3W1c5yeEmp3OWQeFZlokZiNu3sX9EtQUG5f1DdljUNYTQl2xFqrvra1PRnZcDFE462JjRYL89oamOgWcE1I26o0/E7dHRytPt4ufKXnQyaxAxliUXuWRPBxPslnmylVx6YnsfWYIvAa9ppqj24q2st9R4UNVFRO46Gt85bFKHC0VYJMDD7kPDQQFjBDv59Ff5LfghM3ionXJMkXRToe55HlAnTTza8ewIUcVQ/OaTNAeXwVb4DXo/6bvrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKI/rVNfZtNwKlVj+7meBFBoKvhYCYDFWGA5L1MgsKQ=;
 b=cxLoW1vx43SsUzXnORiFJ9HGglMXx0gIiwV2Pgb8IIKDROCdPLkiA+ac5kKEBJSaIIpm6WMAsycIZkNhTa9DC8EUljeT/rvBibsM0wkhFQskjNr+CSKn+PbhLm3N0zJnZExBVOO0MOFRvLB3wRRnkr6YmXADH5HlgTNm5kLGoCAs3/hTiVW7sDP7cBxlV+ebL05IstSn7WrU4ZK9mK0BkCC3GYGbOqampCr7mPokCsDRU9JVk7/qu3LICV0qkoHm4IYNjOPvNMUp/eY6Eso2q93EcHuw7UJpeg+dnYpfgJS+CcfBLr3tzVvfoMuKuQqUhWE/Iq1mTD5LAvKaNGdTlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKI/rVNfZtNwKlVj+7meBFBoKvhYCYDFWGA5L1MgsKQ=;
 b=OR1naNlAWkY9rRuZ4WVvM7MYEX0oKKUJ2Cw3c3JMmoahXCNMBAnrNXZC7rGhUE1Yjykxo14xeQoB581tjXVtaLWP5SjPt6RKGvWpVc3E/1E+VdLX2FVJiiiy6Wez5NUzMn9zVUyF78t/KTTknYM2eYWwKMFrev5DckTjM3xvYUC7MGPmCbVuQeh09Ao0nIxcDmnYwuZGsLY9jHtsYkw2njQOAZ/nKe5bRm6AVQ1GpND7/+Dj2zVXyMhBuopONHrkPK3PPvJJLqmPU7CWf5+WTgrz7K9pUvIUSRrQYdBH4aoOtzlfeiif3BPbcf8IMhDkFh2XcRXxWoowH26CKc1gqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5043.apcprd06.prod.outlook.com (2603:1096:4:1a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 03:27:46 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 03:27:46 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] spi: tegra20-slink: Use devm_platform_get_and_ioremap_resource()
Date:   Thu,  6 Jul 2023 11:27:25 +0800
Message-Id: <20230706032727.9180-6-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706032727.9180-1-frank.li@vivo.com>
References: <20230706032727.9180-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5043:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a8cdb5-48a8-4ddc-9eaa-08db7dd0f74a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: odQebywnfEL4Ebt3BtRctRKtg28wnkQ9ULxH/l059hY3mXwgiEQ4mIkaKq7ImINFEaLRuI7oOQbrjABM5UUGnJKafilSA8IF/qoMecPwGt0z/DVRNsKkxc+4u97WfGdHkuML2h7QBYZHVfzlnwwePsAUUxNlpzNAo6hku1psq33jYIPCdbX8jWs/7nnDmlCRNTZzNljXYKwuexglXv0phC8aQIT+aoOXTaXAfu9/8AaYNLXC0h5WXdIDw5jXdcGx+UpFDPOsss7JSg358RYcw/l8GYmE9WmYbsuxfZVb7RbfLSEGybJKLbYo5kGrQaMtoGpwZLCPrO6K/S58wCoe/g1mrhsAo2Alm9d+zJKIJ+u4kavMU3+uLZXR3qvCa30giGE9OrdKhertpnkPwi9gC7qjDRZTXsuD7adGgvzddhItmagPoMMTas2H8K/2wjbrnhbcYGSHXkpwEFNqtqPn1/7+d0jU7UozuUvqPnjW58VzMawZi0DEp80V6qmiFSGCwguVf3LmjO04w91HCr64zsqQeXRp35GGdjG/0KrSCjXToZmwRu5s+YFofnYHN+Keb2EezRh4T0mEArE2TRy2DfBM8wILRok2MCeBm/Dtrqhf740oFR4YspeWeuIBUCqI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199021)(5660300002)(2616005)(8676002)(86362001)(8936002)(83380400001)(38100700002)(38350700002)(41300700001)(316002)(66556008)(66476007)(36756003)(4326008)(66946007)(6512007)(186003)(52116002)(110136005)(1076003)(6666004)(6486002)(478600001)(26005)(6506007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uOKNZoSKKrnEKxqIVtVXhOSE6MlHDYP2Jz+LNQ84S2BnBq/Sh8z5TvY2/ZFj?=
 =?us-ascii?Q?exa6BUDxFbMx6/y/ERCQawlGr2AJsjGIBUUJ42F54rlkQcbO30l7a8fNHFAU?=
 =?us-ascii?Q?V2r01U8fgqiT+c1IGuIEIZiZffql4KIYeRA7rfSF9q4CM0yyOrSk5c3Rwmgl?=
 =?us-ascii?Q?wILuwD0dfxTysMlswTSIgJhCIptKsvdMPae8GoX6gU1oW8T9L4nSivGpB0k1?=
 =?us-ascii?Q?2n9SXXONI8K1zl/XcxJZTT792tC5JKBpKWE2q7J8v6MnJBlx08doloB78erz?=
 =?us-ascii?Q?3f71iYqof0zmkiy3okH2aAhQT52PAqFZ4Yqe57v9yxi93KJOgH08b7lSi/2N?=
 =?us-ascii?Q?zE/r3eROCIFH+CBpMK0tt2lPFdhtNPA5Ub7m2RnrqQylqsLKQbi/txC7xRV5?=
 =?us-ascii?Q?kvLk3v8fIjgzXEJgZsdkrOg3+V81Bq/j1cD5XudxbD4J4a0pjfyV05FM5Mwc?=
 =?us-ascii?Q?LrZEmdCfbrihrZpJFsu8pgHrRs3eR5DAYk43kgvSQkD4RjNcdd9qas0zDwF2?=
 =?us-ascii?Q?diKmPtsfMgnU2+qJCxJ8FdHufWy2Ltf5yTHhv+XSCK4cKlui+0hNJ1yOia1a?=
 =?us-ascii?Q?HP5e/R7TnayZcfRbYspFta2o3Qcw4T4x36LkhnH/bhSjKDddd/bgGsAFCXeO?=
 =?us-ascii?Q?FqHatl21zvP9PP9ElHMMGvS79u1UOANqbrEFzcbJoePBgPQKjRdHRQnr1oTo?=
 =?us-ascii?Q?Gc2R79MJzQZuk5aYwOGFDL4/eBS1c+ALKKW1iXEdNCd/xWYzlNqTPZoBcF0K?=
 =?us-ascii?Q?WrH7lWHVylaV6Zs0wSjAFf7rYZhuTPuzF315pDDfvLh1J03bjvazdSj01nxL?=
 =?us-ascii?Q?ZSAVnKDx001GVnHjQcxLDFX4ZxNqJAwMqsE2H1ayaQ6h8aYw8P1TT4IZLBCf?=
 =?us-ascii?Q?1tCGqBnYEH2K78nQ8selAfphT5f2O1ayflDt0RsKl2vRz1wNJE1A3ymdznuR?=
 =?us-ascii?Q?YVsv98/IEpCkr/7j2BA2Gjh41wB8OxbRFl+Brz+mdT5tU9COEd2sDkc8Y/uC?=
 =?us-ascii?Q?fuNarq/xxrCOAM77+GtlEa+MVthHpPK3EHy8XHeBJby1iEGZG25cwRc96vyK?=
 =?us-ascii?Q?SZXGXms8kCtEp7GG2iztKewVwIQ/6KJqVzVqdYFV7YJFfGghBex7PT+EsmWX?=
 =?us-ascii?Q?pmV2NB420uX3gjLQcXp1hHmdsYj7xI/5ukLvRWqfWYpN8s3KslSUaXG46F20?=
 =?us-ascii?Q?1pARAbzUt7FkyNDOAm19SdovCD8Prfan9VGt0Tc934jjsYJFWXJKQZ9jIz+o?=
 =?us-ascii?Q?6Zk+KCjqloZ7hkKDnddVD8mPRuOdoNS4YEBItvgWynI72vlQYtyZB0UI9SeE?=
 =?us-ascii?Q?E9OnDFxUMlmiPYWAyK0EkIDhVJ+A5o8SBtqMst84JLVROh0WcLFLXPN/4PRq?=
 =?us-ascii?Q?da99YGWwMvBccYaQNFGR2NHcb+D31JlSvScC1GerYveLqZNCz34BcKLpXFjI?=
 =?us-ascii?Q?6Iphzlt8UrB7Yk/3rMGRJEUnyNp3wEa4hlXXO9/SyaZ41Dz4aHWpleAEu9dp?=
 =?us-ascii?Q?FrNjW1py2Sw0m2OYfUCt2eEJ9fNKWDqg2b8xYJmYSpiSt7GCkTNnw1yREZdC?=
 =?us-ascii?Q?QdqiaO3jh5ZhxpcTggzCzDdjHetJCsbfmeck+dS5?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a8cdb5-48a8-4ddc-9eaa-08db7dd0f74a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 03:27:46.0607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+UQX8k45AUzO7RfmCDHpX/W7eCM1UWVdwqXfLTm4V5NBFg6iWuJ1TSumeFXQ4zon63Yy5LMZge95PPgrTal/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5043
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/spi/spi-tegra20-slink.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index c2915f7672cc..8cfd9e4f60b5 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1034,18 +1034,12 @@ static int tegra_slink_probe(struct platform_device *pdev)
 				 &master->max_speed_hz))
 		master->max_speed_hz = 25000000; /* 25MHz */
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r) {
-		dev_err(&pdev->dev, "No IO memory resource\n");
-		ret = -ENODEV;
-		goto exit_free_master;
-	}
-	tspi->phys = r->start;
-	tspi->base = devm_ioremap_resource(&pdev->dev, r);
+	tspi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
 	if (IS_ERR(tspi->base)) {
 		ret = PTR_ERR(tspi->base);
 		goto exit_free_master;
 	}
+	tspi->phys = r->start;
 
 	/* disabled clock may cause interrupt storm upon request */
 	tspi->clk = devm_clk_get(&pdev->dev, NULL);
-- 
2.39.0

