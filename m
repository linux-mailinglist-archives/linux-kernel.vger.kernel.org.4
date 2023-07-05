Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02FE747E24
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjGEHWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjGEHWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:22:33 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2124.outbound.protection.outlook.com [40.107.215.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095E910C9;
        Wed,  5 Jul 2023 00:22:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EorcQS90tSulGiO9Uc3s4048rkQ3h/gZASoVRwjvsCTB32Ry197r0Pw4IBnAZXvu+iOVtROu7WeECLMs+FQj5VvxZWqnLvgS3B73n771qkOHY55nywXYLfiz6210fl8FtvI9s5m8tmaJSjne8rK2R6UkUTVSzlT/XrvZ9KV2imU5xw7jY9o2vEZ2DOm+l413kS+FtLmSeH/wxR6fIVLTrIlnfJcMihq+CQ9VGTUWcyPdno73uo5DuKydHXN7oQOkFQ4X2MNYJs9Nz0Pi6DmScau2b2c/ANe+R0yPgyple7QehO5YDfMx5NZXvcDRyyHQBdtxQRSbUg7nbvAOr61ucg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFSVdKGS9Oy5GDAxc2bSOThrkajXBFAGXKxLogs17HU=;
 b=R4qcEHeF5lJ6k0ZH0bN46v89aeqaCl+3UAB0ZdfPbt9eTlECJhvukgRI5oWCS5R48JuztJHF9A/taXStTLn4vvL/YruQP2q561q9NRthUtNYmEggFsbHLM0k8kzx9w0wPT/tJW956eO40eYBNqJAEXF4eOngmUV4Z3f3xovbQpXCt1QtH7deVoPKxlwl+tS2+IaH6i3Hx6va2cuBMH2JHVbey5q2et5EFX8TiHb6ifxgGvtphWp/eSpLNZzcRqmopY8FNBb7iWKTYTpGaERTHDk7cw6lo8iPf7Maxn4k5o+7AVV2ducuGTlaXDq/kR5oSiMgEkDbp1V5yEmfyOov/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFSVdKGS9Oy5GDAxc2bSOThrkajXBFAGXKxLogs17HU=;
 b=oTUcXWHiMNowaMcjVzkQO33MEM0W8c28xWLDDZpD9QAcA75aoLt3CEjaWBoCuidaW59uMbmbEOAHuD9elx/gKWYOUbzeDUTc/hsBMZnP1C5ENcaMwjJE4I6suzzpjDGf7avH99j4lqM0rg6WKx67e79rrDkgFeHgsXnQMwy24BWcVnz+D3lc0e5e8jkKkt5znaj40yh2u53rF6YgszyqAjFBxN63Fi2y/OChmo5azK0BIHQ7v5JqWIZmXMMmU7Dhv/e72aJyH5uICVP6sHLC8/2t1F/F5wHH9tcRbeYtyGAFKT5B4h7DGt4zvS5xqDGOH03+6FYsJ3wmDkDdgyBC/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6058.apcprd06.prod.outlook.com (2603:1096:101:e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 07:22:19 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 07:22:19 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] crypto: atmel-tdes - Use devm_platform_get_and_ioremap_resource()
Date:   Wed,  5 Jul 2023 15:21:58 +0800
Message-Id: <20230705072159.77221-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705072159.77221-1-frank.li@vivo.com>
References: <20230705072159.77221-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: 1222c6fd-9574-49ed-764f-08db7d28915a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v2ohh54AFlHy6xDpiNDZzsPbljpWO4LEmNK4uf7lpOCkpTCrSMIZoHWZZKHEfQXGKvTn7jZJWl/EbHszJRm/KDyAG3AnArYt7xOyilqzvqdOR3sWYmmBh89IlNiDgqbsgcgrgsLdvO3MRuf5p1iqYhpvI59/Pe7VnqTuNuXApD2YyRX6f43yUIdltRk4hjsWx9v5+fDzTKgaqk/hujGxKKzoXxehjrwvVk+IulxC+xRBturp1IvOoBcXVI7D6Pq1Xf2owHrlnxXVhXDgwKbxOpaaoBOfJdRl4FcqcNMRHUPf+NQvyKovvUm1fIRViqOqTCwapi/Mxb5S6Gd9OImwjofnZxgLQlPMkfoR7HM9Kjkn/YtsXQbnl+xgErFok4mSXXyIQOy23MTNXu2rmhIu0En2fowsO34z0XaXxv9T3pnXhylw2v2LASEjN5173iNCcFBBza2EsdpIg8G+vtGPNEzcQdLEuA2AchSiQiGO38B9YqzQqPsWlhDXKOykl/r75xwZ3pUJTHUtwYYWwDNtjS8SNEMy6NQSpLZ/u0hN8UfZm9DCJufwskC/K+FDBkynDHTrj69ANjgZPLRr4fT9/UsALWuhYdLWmAGO9fDguSQ/zKfcuBU88CPbvgUF9PBg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199021)(26005)(66556008)(66946007)(36756003)(66476007)(4326008)(316002)(478600001)(8676002)(8936002)(5660300002)(2906002)(41300700001)(86362001)(6486002)(6512007)(110136005)(38350700002)(52116002)(38100700002)(6666004)(1076003)(186003)(6506007)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2XLDnHYQQeVLkj3QPdItIngiH/yssmvLVRLr3+e8CV7E3sS2QqBY7eQ2nRxV?=
 =?us-ascii?Q?qBQEbpUrcIbHwSZetDMX4cDO/Vs/HmFJ2L7IqrftLfi6n2yVAU43UwXmJ1Ei?=
 =?us-ascii?Q?OcpNGTz2+NlJNfP/C8nAB5bp6skCtBr2KAlWhP8iRxmaO70b1QJ9VxQ2fGKz?=
 =?us-ascii?Q?5jHORJ+2YWq2aoLqKKiOd7owWII81Yz1YeVDDD2aYmgzSKK+MCVz6If5EYDT?=
 =?us-ascii?Q?82i8JX5kXu6dQBCzqtSe3YLJX3W6NUSiMCf1VAx2PRCMqtB7TnDn9PTNMykj?=
 =?us-ascii?Q?5JqT5NWV+ahX+TTLlexgbusFKeX271UpBxBIB0noutst+ll/rd+H5qcG3zGr?=
 =?us-ascii?Q?Tnaxcj8cBv30xzwAqvcPatEkx9jb5fZOOjNLLIRtHfa0veXfclFEyAacZwoB?=
 =?us-ascii?Q?/lhQXLqWLkF2SjJa2MISsG7zHWDbhsrdJd+iJzr5kX7SED5dfzw7nnPtonpm?=
 =?us-ascii?Q?8wWPJCeQ3coZOJgogRFPO5d6fYj6PxByvr7ibpM6o31X6BcE1ZjLvuldMxjD?=
 =?us-ascii?Q?rlRnL7IYZ1YyWtyJl2i5KORAQe9JLAPPUaeWtyM3htEjLz0Q3VJa/qjfkBlC?=
 =?us-ascii?Q?sefMGBfLvP0iNQS2YnZcbpZ69XkhNk7hLevhH+gOsCMqSkQDWHc+GDMT8Rce?=
 =?us-ascii?Q?SJaAbQuXAOWOtHqN3fiHiUHuZq+LSm/VintYwhhswhkBB+vJopcxnLd66apT?=
 =?us-ascii?Q?7FA6onMfAkI17MiHOxM5XSq3sKlyYJlEpPpgMbfblhWIqd7d0bNawz+N/iQI?=
 =?us-ascii?Q?RyvcjNThdpzTW/Un0d/PLJsDd+YC91qWksLw0rWJragspVsloNy412w2W4Q/?=
 =?us-ascii?Q?vA3oUw3UeZ7O0IZlqDPqjGFnhhqsS2PFw94t1tVTu7FbcuqSUy6O/IJSzFDd?=
 =?us-ascii?Q?D7bAwq2AzQACepbkAeJRz+zyT/v6PIM3irKXmPh+6m2GhAkpVj7bxh0d56M2?=
 =?us-ascii?Q?+vL88rzP6Wyb6Wm5N5ksWpK6va18JHPaIRsJgFEhLLPb48xQ6RDqq+IOj8Mg?=
 =?us-ascii?Q?CXaS/JwGrDnhaRDfbGh6jsS0Vi4zy/GgXSYwLrxSUDW3RTHOhoNTwlv4pE7C?=
 =?us-ascii?Q?ibVEZfjVG7LxdfxFUhAD17FkVMALCvS9SUIgam9Dg14CNZHHk8RkNzcHusFU?=
 =?us-ascii?Q?iNRBlqpLr5heCT2yuX2qeFPG0vf5ark78WLi4TiHQ8HCtMgVa1faD3Xy1vnU?=
 =?us-ascii?Q?ZULZb4yiGDuSCcIAg6Z8caqzaoSuGRepm8II0P+xJACS6X4PHNzakRdaWKzg?=
 =?us-ascii?Q?B9Q0cOGbCFWtGD/fwAIpCb+Dxfi+qYEo/OA5l6WtlX62VZNU7r9kjdLjXgts?=
 =?us-ascii?Q?G9lReNjEXU5oBvf7H/CePwcKqCyee30sZHcnmS37bQoFYltzsOQO0pdaxl57?=
 =?us-ascii?Q?qG+KFy6IHiTXDECdzrxVnHMoReOiQrahmL+Ui8B7sGlxZVPh8cHv8gHhLfYF?=
 =?us-ascii?Q?yJ8WQyJNu7+oL5gkULUgHX/feFXo3Uat3VmfIUokRheLD1rT4bFbGQBeoJAO?=
 =?us-ascii?Q?HpVgTXUnRWwTpdnJCX4Yn2oeIV2O3C6FLHJCJgVrxuMHgVaZM2H7ErccfdkU?=
 =?us-ascii?Q?9z3c1EtXfoqfywhE0MqOKSwqQxybzyWoy7c4U573?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1222c6fd-9574-49ed-764f-08db7d28915a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 07:22:19.5581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3YkiKy+NTr5fHo7SmqijDeO82p69ZtxTFRfecS7MFSl+0n1TVePNM+y09/5vIZ/o6xbj3uTUOqCqI5ps7H7Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/crypto/atmel-tdes.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/atmel-tdes.c b/drivers/crypto/atmel-tdes.c
index c9ded8be9c39..ba8981f326cf 100644
--- a/drivers/crypto/atmel-tdes.c
+++ b/drivers/crypto/atmel-tdes.c
@@ -1172,11 +1172,9 @@ static int atmel_tdes_probe(struct platform_device *pdev)
 
 	crypto_init_queue(&tdes_dd->queue, ATMEL_TDES_QUEUE_LENGTH);
 
-	/* Get the base address */
-	tdes_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!tdes_res) {
-		dev_err(dev, "no MEM resource info\n");
-		err = -ENODEV;
+	tdes_dd->io_base = devm_platform_get_and_ioremap_resource(pdev, 0, &tdes_res);
+	if (IS_ERR(tdes_dd->io_base)) {
+		err = PTR_ERR(tdes_dd->io_base);
 		goto err_tasklet_kill;
 	}
 	tdes_dd->phys_base = tdes_res->start;
@@ -1203,12 +1201,6 @@ static int atmel_tdes_probe(struct platform_device *pdev)
 		goto err_tasklet_kill;
 	}
 
-	tdes_dd->io_base = devm_ioremap_resource(&pdev->dev, tdes_res);
-	if (IS_ERR(tdes_dd->io_base)) {
-		err = PTR_ERR(tdes_dd->io_base);
-		goto err_tasklet_kill;
-	}
-
 	err = atmel_tdes_hw_version_init(tdes_dd);
 	if (err)
 		goto err_tasklet_kill;
-- 
2.39.0

