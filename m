Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E250674942C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 05:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjGFD1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 23:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjGFD1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 23:27:43 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2125.outbound.protection.outlook.com [40.107.117.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0EF1BCA;
        Wed,  5 Jul 2023 20:27:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+FLUMenfUl7vllmKgBmjEtN2FKSVV28xI0KjRfepqSTAjBCHRgKSVJOGxBLF7yaHqtAJytmY8lS49UI53Pfp+vQntvPokbbZ5y8GrFXv66L82LWPQwTM6zTFSOFq2z9/Soc4SUWZxtZ5a01SaNIS6ecI81RvWuIoshvv/FJwh4KFodvLvA848naHOiY+Xb4cu4uendioZrgy2mGVOSK59zkYHEBAxPt4PadBFYDAI+7MQBQDyh/yFNqVxAg+wxyJ4igsQKuvOcjpnZrLEcWY37oh1PAqvlMobYAb7aIwMjcTMcwUz8v8TueAok6KYEPi0Qo0FigOxCK3r1R9BeS4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCozXhCFyD/XrU9B2Ybd3Lyt1YGWHmw9Wfxon709hpw=;
 b=B0HEsr2mprzsV8NmYJDZB5KmjYkagAqTNByOyVAX2zcB0z3qZL8DeRbC5QBsaL4HRRdnpvZke6tzYPTF95wwx7pN5JahCzP1NxYmrDU3oPB6sJ3AwIbsOwKyMeSRqZT6C7M/0c5/G9D4Kd1Ztnvc912xzYz4Ca7DMozw/7AVPfibJY5ZHxoUf7Lx6WA3HgBB79ppK7qp+hT8hpCYvLnuyt0xf+7csE6jZNR3n3xUTMFYQbe5BHP3Ap09QylxIWV1HMDGxWIgKletvW3a7UADTfh4LeG+Xib9YQqGcc6ESbPxZZmt80BhrdbOY/XjVYlhr5avsyUyPWdTUP6ds1g33A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCozXhCFyD/XrU9B2Ybd3Lyt1YGWHmw9Wfxon709hpw=;
 b=KxuHbO5F8g0/17iI6JX8EMZLm/le0AkLcAvxnR/B5R/sVIrA0atG7RiI8a5Ntpl4yYcy21W2VVjme0IOGkBZkrhD52UlOeWt77FvdrJBJGPSwK2YUMOR1qZ/ItMHHtHikDtQQHEVnivkhA8N2baftywYGq5675Wduj/Voi+oRGzdsjZQ2Ox2gvvmtXAc79VjueZIm8y66OuDPQe5CrjbfLmhbe4xTKWfh2f0Q8Aeft4IkHxe7VUXJqhfPZDiURE8MKRDbRP4NlsiLIaVQZzCGwuyn2uWSwc8jZ8USydk+RUGrjkcMuG/Tbn+fnRGoPctsnwkeaJ29nIf/riRKiyiGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5468.apcprd06.prod.outlook.com (2603:1096:101:b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 03:27:39 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 03:27:38 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] spi: davinci: Use devm_platform_get_and_ioremap_resource()
Date:   Thu,  6 Jul 2023 11:27:21 +0800
Message-Id: <20230706032727.9180-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706032727.9180-1-frank.li@vivo.com>
References: <20230706032727.9180-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5468:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b2c2474-d4dc-4c54-55b7-08db7dd0f2fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4GIOB7ZLGQbxYoz/ZwhL2SHM1GbIPEung2U/Peip7poM+BsaMTfTZxONjXXttTiXolCHXa+NYEINnBv5dND9mXL2j1uq6JZvSvm+IjM0Ixi2X3ksowPL0JREyWROjAMKGG1PMBY+CmMIGUXWnLdsLvvFR+AWV7pIEnZvKbClKoXS14iCE29ljOv3oRSNBH84mEt0zHF1ydsXS800XR2HUIs3tqgFeuEGtdf2uLmhz0zO4BsEMuOYtRdlCONd/W0TTWw//8bdTBKYlZOf+YsjK+QNnrIfeF/XU47PRjskNYeJIXtRTed/oucfq6pQVRiT9L48akw10OCdPqJL/XMU4fudx35RE4Yz0hztKXwzvW9py/z1vTP+YbSB3zUgOeA3pgG2fl8bEhyqBy1mtgaL0IbqUERJ7L6Ck8fDuBoXBHFnpRqpFd5eMPKEkDTzz0GskHHqeaWaVv6laQ/yncr5anzjZx0EEZFXoJ2tEOx4Nnzi7aQz1Zr3Dz0Ct6koAhpS5yvYgjkbcaAIpU+1cwVaBM4+jIKkgi4915xO6H0HSvUEybQaLXvyGgEbublyAk4qlysAk/O+A42yBin8Uj/bI6L1Wge3HJv/3oP85jzk64=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199021)(41300700001)(478600001)(6512007)(52116002)(86362001)(38100700002)(38350700002)(6666004)(36756003)(6486002)(316002)(66476007)(6916009)(4326008)(83380400001)(66556008)(66946007)(8676002)(2906002)(8936002)(2616005)(26005)(5660300002)(1076003)(6506007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JHRWBo3+FhRkCOZXBKxjNp1+0Iea1WXLH8h+/RMzoDSX4PvT0vJTAbFlsI6H?=
 =?us-ascii?Q?zTt09Wp1C/sr7gGj4vAOmUMn5MLwJ/ciJopbTncVYgVzNQK/gqg3OStD+/7n?=
 =?us-ascii?Q?oa3B3OKEt9CHfOUAmeJqbokgvF+2+N5p++rI9Scz6qrdtJHaWTEMr3FdDqqB?=
 =?us-ascii?Q?TVkICKnUvfSRdlMRHKelreXd74Zug+w9fhNBmxTeV4gsUy1GCXqcLgULoO4C?=
 =?us-ascii?Q?iZItgLpqPSQzQsrXMmaOGE0IxX8tmmU4ZKxidVZTiC5Ai2XUpz56PMA1xrmM?=
 =?us-ascii?Q?ZUEotNV7wpxKJQzSH7oLMvaNwtk55Byiip+JYLY2bzOuhGKOcxbcbB6NfhcU?=
 =?us-ascii?Q?rKQeIm9mFKORM4+iyaMCaACbrKRGmqAhofK5YbP+IiaUW9DxvbsrtpvNwf6N?=
 =?us-ascii?Q?2l2Y5K/ON+omtY51bJv3r3/swlG3ru7pMolRPBE82vZRa/3rGYX7IWo+VxGt?=
 =?us-ascii?Q?QReDGF4zcO0cPYTN+woPb9mqDWvOvb0iU+UggCQw9hI8zAtcOrrNiYeKA6Vs?=
 =?us-ascii?Q?C5K7SL3xJvuoxE85xgix6N71412WWBeiUeMfs0YimJlpr3VeH6e0Y7wQaSZS?=
 =?us-ascii?Q?JJHPSzBW+iqJBKE5Ds+G3bvMlsNhqPpuoRCWOJ7UUdTit821EAbM/rcb+jzo?=
 =?us-ascii?Q?N535jvtiB6LYmpOoYFTM37/U90A0OrLxRTkF74zREFMxJSK4PyB0Aot9zDvP?=
 =?us-ascii?Q?U2BwX3z2tCi3m9WR11M/ZmmzrRolRxn63kL6SQL059pas63nILmAEuQjdeqr?=
 =?us-ascii?Q?pz/vu7GlTPUeTcrLHTOJk5L2D840EoDms9yUM1deHryg9g0JOosYhxW7/TVF?=
 =?us-ascii?Q?gTfUHbHuO0oEOLxMVTz/WJCqmo55ECfdwPvYrO5Dcqh9tQOF3GGr2h3a3CK7?=
 =?us-ascii?Q?tas5l39I2HRHb7AJtruVjExPnKGEMsiddywih5b9OU+TdLNmFu4XgR2D9xho?=
 =?us-ascii?Q?xP2u6ZzVtbNdzFp1UwSgMJyVFVoxQrtnQGxEZ6Bge2Z2qmFyNenuR6AX5j8z?=
 =?us-ascii?Q?AfzeeoEPkni8MlJmNXQoI33y3Cu46IxGU1pUgXpCZrLNtuMf6EOU4pIlRpYK?=
 =?us-ascii?Q?39IInAazxnmDBFSh7uRHH7vrEgGP6bS4RGV3hft68GZhFdMCo0MAx28PjvWq?=
 =?us-ascii?Q?PdVrdswdWhDJ1KkFiVb+jBDDTJOsebpGj5atTby50vc2hTVQK6o5v1mGm/et?=
 =?us-ascii?Q?B6A63wreae6q6MAHzqb2HWyYkxW4myPnY+gNmAF9uKWTqs/Fb/zDP1lQ4ug0?=
 =?us-ascii?Q?975KGa8kfaNBWnWPqPi3ixQuxlMFdhwz9uiYvagVz4BLclePKP7KAhnXhiq+?=
 =?us-ascii?Q?xfI7cJBygSGC8Acw3m0rWQH7R8oTLxEu2iDuK7yXS3i6ZWY1lYhsb9lIJ7gK?=
 =?us-ascii?Q?ksqfelaE9M5hVoVrZzN+VIFlET8LH1ZgVrwSbHrij8SjA7XtXsyF/8faabym?=
 =?us-ascii?Q?xTcnmlRkdrRighC6nqeKhPjbDqRav1h5y0ia3t4MnxEs2t8NgDoCCUCl0tmn?=
 =?us-ascii?Q?7YZ9UYEksR+/FYtASkyBpyXilSlnjmeE5BiqdBW3gDjFDDMtBA6tOycsNBtf?=
 =?us-ascii?Q?qrFTB88i9/vfu+UGkZDzUMIuHhZj7eRk5hNSBN0T?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2c2474-d4dc-4c54-55b7-08db7dd0f2fd
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 03:27:38.8791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Houh2TWJaZX0OQfYaW0g6QDOjWvsJv5YX7yUdD338GI4NkmXmi7/agFqx9QbI5o+6CxOEQQvOD3ROyu6KFdGhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5468
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
 drivers/spi/spi-davinci.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index b04811c911e2..a85fd0cb4a5e 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -895,25 +895,16 @@ static int davinci_spi_probe(struct platform_device *pdev)
 		goto free_master;
 	}
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (r == NULL) {
-		ret = -ENOENT;
-		goto free_master;
-	}
-
-	dspi->pbase = r->start;
-
-	dspi->base = devm_ioremap_resource(&pdev->dev, r);
+	dspi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
 	if (IS_ERR(dspi->base)) {
 		ret = PTR_ERR(dspi->base);
 		goto free_master;
 	}
+	dspi->pbase = r->start;
 
 	init_completion(&dspi->done);
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret == 0)
-		ret = -EINVAL;
 	if (ret < 0)
 		goto free_master;
 	dspi->irq = ret;
-- 
2.39.0

