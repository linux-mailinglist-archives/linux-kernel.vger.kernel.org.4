Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56898749643
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbjGFHVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbjGFHVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:21:06 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::701])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17659198E;
        Thu,  6 Jul 2023 00:21:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqJP6g1jEn6ylI9G6qSqnzAhIYXmpNBReNL4xCpoMHNwPenKsdCQPu9Oqo/ux3dwKinved/PD7xgeB5KIWKqT+cKs3NspAqseEAawwaRjqqJ09fZStPKtOCgrTFw/Alp/tQ3ESu0uJpHsOieEGuLCA0sm3mNMaMrT/S+wWm5HAmcE4xR6KriJGMLFdQjLQtgJ2lYmtL/I48/76zfbWncqdlQ9rI2sPiXyYWYV/l+HMU+3FHztgFCYJrcnPBS3ROrO6zdvlcBxPkU+UymCX4NPHmCz4850r/e0JSPVLrd6NrLrFgkf3edW3JrHcNaiIixC4pXQxP+sjaDllFYNcAanw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkXzs0odMqkULCNwqvLMP4G+l08tCTOh9Lptz0C93Jc=;
 b=nTed+dcaymCbCVyqdxHMrOTI9GlJ2Yrfh0DNyUNT6zFtVgWCcvVmMntV5YAJvkCPC4uM7LG8TGYbBgWjgc04KxXcMs4njgeGH0x9nIGv9OLkTbO8HM+g+tnz8P/y11I2YlLsvWp6yq7onw0ftEftBh0h1t9VD8AHz0M7uYkUlodkZLo6mV3mqW7UXh+3ALYuVZu+gS0L42iZf9z1cVBJNZtF0me46VmRZhNhcw0vP1wwuiymq3WY8IVwSMB9JkUh+n9wpny7Wojr70JqkGD/NK93ZWps5yoWbZRSNKc/rDgw5sqPqm4GgjzWEtSMNpsGbdLra/25NMd+LCqOoXj4bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkXzs0odMqkULCNwqvLMP4G+l08tCTOh9Lptz0C93Jc=;
 b=DefRbfTASoBFi181NQFTtK2U79DzdQFazCd+/m4lnbyQDr6gPoAS0UO95LLFKB/zXj+r6elYGDluE6+aYvfEE69dLeaVxcsJ7BdE1fpykQJ10M+1Si87VNlOA5PdUz0TBI+KvqNnIpzalNl/JeA1SroF7Jdl/MMXeDqM1r7dT5YXO3BYB/SpyVPMfjiGVSNK5IPbsrcOxC3xvOixpvII/j1eiZUpJf9/TIJ2ERtJqgIVC/ILImjmGxJxkF0NrhaXRplAfncDVrRdYAScLAJ1o9m4kS/+Bz8xrjqesBQJrdntxsLzcCX99PGbt/WBSAG/acNvViwIsgerhb7ZgVScGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6081.apcprd06.prod.outlook.com (2603:1096:101:d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:21:01 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:21:01 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] bus: tegra-gmi: Convert to devm_platform_ioremap_resource()
Date:   Thu,  6 Jul 2023 15:20:40 +0800
Message-Id: <20230706072042.31296-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706072042.31296-1-frank.li@vivo.com>
References: <20230706072042.31296-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 67bb6390-3d15-4d5a-111b-08db7df18cf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q3m/yDfM99ZNEInEPBDDxCLwDmMi3llV3/Q8yVXmb/tYD7YQg+T6VPHncmKqiS2eE6AkFt+Fc3Bf3W5LbwDIkP+7Lfy5yg9XX79FvYCB7EsKhsAnFzKg5gthFwgQ58jud6eTrvedbG69vrhsBzgGwH4TTSC0/2lZQinmV/rDG6pfsQPseVbYRd3UITVICRBDOnh9jTETcM3xkyglh1ys5WLL5B81vhwBCJh2f4J37LFm/1IcVeRKtFtS3Unelz3J8xIHstUNdxg4k6FIekPxIdEaHBX06At+yczPzzUOEJuEClEdkIaU+lWphY6KbHqHguHGcXc0FmMVa3J5VPLU9x8ZDqazyrCRh2VaCeo+lm5rpLZyo1tGGZJClXB8zSB7o6pghoMJd3oibb5L3pxxfYHP2vmbqC4Q30KCREIRLZLnGy75b9nRdopNcufC1dJV/KHuZlq8cCbZrNQRSDIHBm6PG15mobiLQwczOuDzPnr6+gPBUTDzol99SknS+6eSPQsd6z0FY0akW9HSqnFHvPwjeFMIox9Q0LdroJNbqJNMDwV8fqgl7FhJP2nfIAQTp3IL3Cr+2OZyVhxDtCIkH/kOT2jmspD+DuirSdE9udB7vTNFnCTAA/5vMQSmIrRq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199021)(38100700002)(478600001)(66476007)(66946007)(110136005)(52116002)(6486002)(2616005)(6666004)(66556008)(41300700001)(8676002)(8936002)(38350700002)(316002)(4326008)(186003)(83380400001)(6512007)(6506007)(1076003)(26005)(4744005)(86362001)(5660300002)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X50YkKAInOdZgVLht3f0DKHPmPxar1yKJVEpyrGr3EYcVrgKIaR/qna+PvMR?=
 =?us-ascii?Q?wvGYdJ+vJuf/Dgit7FSZudhS/9u/w+E6FLIFttL26hFYg65VL1cds4mAoq0y?=
 =?us-ascii?Q?tcWpSqz6STNr7gj+OIxskHnJt3zCxPm+pyGmUIkms7B8ii1QwJHC/GsRU4mc?=
 =?us-ascii?Q?ktDH+0xKVFsy4n68Co24UwU+/Le3BCLVhDhbO5edPAO89zwOQNTq+Ra8mh1A?=
 =?us-ascii?Q?8LKFUEgZRFn+3hKWXiztKY3kPG8g6gTT2JcqS+VXXkAFbh7JmfoiK2PL/8GI?=
 =?us-ascii?Q?Jieiq00FM8aMupTMd9R5yVsjrYLiQx2k/oengyedcuykg8rZMUhPxl3Y7xkT?=
 =?us-ascii?Q?Rjvcma0fHvjPt330+1cBS1Z4UQsp/TgmMViwRzOuRAJDwaq5ecZZsvcTuNaA?=
 =?us-ascii?Q?PuUU3Dy/ykLmbMwgqdT5/mHXe26h+Qqq9JjL6SEv1Eo6SLNrPTqHRFR/goIc?=
 =?us-ascii?Q?WLjHBGpRud3Ymkz1XwDaO2Xv9nFY3t3TP6DS5mc2nfj3UTY1/lmt4JQTcmiM?=
 =?us-ascii?Q?3o2LKRnDMLysaQ6s537wzQTcW6inwQjlO66j4VltgTO1REZekL05w3jxcn3j?=
 =?us-ascii?Q?i8BYMglFTcJt1OTnJBff8wtsDxcNUKJVWM4eud9zSC7BSKovuV7RaXqAKGlj?=
 =?us-ascii?Q?h0SmXx99KEfsK2X0j7roAgw16dSUr5Pz+XE1/Mt0Jn0QdQS0RXRRJPYufk2P?=
 =?us-ascii?Q?N70SuKgGx7yR5mvnwYqLVzOKeD/y271+uSNbLaPhEtl60gRa04qlr19iDX3N?=
 =?us-ascii?Q?2H1eQBqricMnu02epAqWWWzEnbIGRWz4QhaogsPp9rCMCcgTpZjqMnTSB+9/?=
 =?us-ascii?Q?y2g7DTY2/2Qp5YrQn+DIP4HoPgsbWXSyBtyYlrZguQp6nfQmA70YC6ln6LLE?=
 =?us-ascii?Q?SkjTfENG3GOznamUNtd4igDY6H0A1xAff9d98CRrTQ1TeoIuPvF2IOHzO700?=
 =?us-ascii?Q?bgYSzyXBNiujIvDlhcfu9AMVdHMPiC7fmTCDm6BB+niYk9TI+94rRPUOAMmn?=
 =?us-ascii?Q?DogsSWyWmYJ4bKwFjtngof0IPzGdlu241YSeFLiOd6Kle78urwL3A8kEEFCi?=
 =?us-ascii?Q?pU1uC6+42ANM4Bt/XyDeKmevuE9KnFZk6xzoF6xKy8ccS7C0tJiPm907OGZE?=
 =?us-ascii?Q?mpB3CRdt/+W7uSA63cQG1rJXEmDBggVpuJh8SLSi6TL2fFpDZjvGz+9sDRhI?=
 =?us-ascii?Q?n07vPMYNt7lEl5AFIdi7iNmh1x3XF59EYQA3Xr3PLGQHroB5vY0xcihRAzEI?=
 =?us-ascii?Q?7z+3AQAFTBZi889uJjSp5k/RlESH/lm7GCqPOujGENhGnfY2yntdS4r3O7S1?=
 =?us-ascii?Q?n4hf88Dt8mRJAA0efbprEMeg4jS5FojyvvkH5vG9od1JYmHg/Kugzi3E3fhL?=
 =?us-ascii?Q?OBCM1Ayb0c+rhGd+kevJLWLc8VY6FC1xRMzqF2FBGE/4RGt3Y5E/67vb9cC1?=
 =?us-ascii?Q?0nHoQ5ZP9EGvS/zCt8ljtl+PEx91k32+J0siwn2iiYTlYMZuqncdpU0+Lw3P?=
 =?us-ascii?Q?9mw2lakQPHJnkmguATE68R74FSb9UpyTp9ihJz/p0c1zEP3jDkyFTZq5EiA5?=
 =?us-ascii?Q?QqBNnBvk4hHYNqsABhvDBO1toVrtDvlY0ZXvr9XU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bb6390-3d15-4d5a-111b-08db7df18cf5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:21:01.0780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/MI/BDrSzSJboMi5NVmn1cw4CQdonVQRM+9rJUwIpMxcjTun9gncgghzAfhE99M+8BYU5qkj5IvAoPsGH+nlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/bus/tegra-gmi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bus/tegra-gmi.c b/drivers/bus/tegra-gmi.c
index e3506ef37051..59919e99f7cc 100644
--- a/drivers/bus/tegra-gmi.c
+++ b/drivers/bus/tegra-gmi.c
@@ -211,7 +211,6 @@ static int tegra_gmi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct tegra_gmi *gmi;
-	struct resource *res;
 	int err;
 
 	gmi = devm_kzalloc(dev, sizeof(*gmi), GFP_KERNEL);
@@ -221,8 +220,7 @@ static int tegra_gmi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, gmi);
 	gmi->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	gmi->base = devm_ioremap_resource(dev, res);
+	gmi->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(gmi->base))
 		return PTR_ERR(gmi->base);
 
-- 
2.39.0

