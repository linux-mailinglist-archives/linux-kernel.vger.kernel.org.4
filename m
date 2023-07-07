Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2E374AE48
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjGGJ4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjGGJzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:55:36 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2095.outbound.protection.outlook.com [40.107.215.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B566E72;
        Fri,  7 Jul 2023 02:55:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoYnptBWhZri0mNHLy4d/7JAz3BOrBrecn+U8tQfZUei9/rmyOGat5/eCWLx1dbD3kANhLKIaGEYOl2AeZkLXXpu4EbqBe9BLViuMsvnARA+iUGAeL7XupSpzCnHFI3ScPx5st87UnNRCQpkrqTVpJjwQIBEptDeGeKcXtTymOaY5pvwV4OqjJdRHlknhXhdEKjq3s0mgF1FslDKd/2DDuvmzR4V3jj8Q4lgGLTMf4zclH6gK6Mnx2ADW0LOjzpxLrboVWw/d9gul73iePQfj7it+fFA83442NgnKe92UC5h2P36mnZnjpMBmSkQVsgXT/13zLNpo1OzD/ZWwNGBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MD8GThYyR4e7OPYeAyEKnBqEfkeohWv4pHC59+3Uy50=;
 b=aLCx/Q7xEG7Vo3nnbyY+5inG6qZIBHKOQoTbaDOSiEgAPIu5rjhiH5uUyAjNt10ctcLK5XDIO1wllGeHKier9PSYyP0CBoGXYOo1Tnl9yyiR9xGIDUWHb330U6KUeccz+UB1MoBplhyMUWnbOLllzh8kC1Qg0XcksYjEqOoMgFG2N6GhG/BuTWuu64gjXPhyXzSD+8NphMs19i+kgq+7tUf/mbDBaP9t1oaUwJxtiqWBUq4x317Gk/w1epFgBTRykfdYxbte4zdEtu4U3SJIeuGyHx1fHU1JXQpTBSx7dKRp9KhuJBvnnZZBjBZNfZXkkpNmMGvBkRFHQASPu39KKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MD8GThYyR4e7OPYeAyEKnBqEfkeohWv4pHC59+3Uy50=;
 b=UDC5fKxzivHvidsxCOupRLqRzTnrbw6h1OVbQ9mIO5ck4U7sC/81NXTKAX6AHp7Iy7w7ywS5yRFKJtSPeR//AKs6LVZv/MR7y7rsVqjAbQoxWJh7qjMe03pJfPU80AwYZ2C/yrcRDcZ8Y/9406oo51+gDTpJ8kuqnCTsSYr+K4Lp06a9Rp7SVytqmZ9JtECaeoSr1uSSoshK/Ggxppor/OarNSKcrqng6ElODZ5rF9CXuYLp2T/ik/qAlSfntJ4AJSFSxWfCq4S26CpiLAJUActxzw4EwZYczn5Vt0fI/mUmW49/mFBBSzsiVbVQ3fcW5QAhGvQNz33PAHToGFPsFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYSPR06MB6793.apcprd06.prod.outlook.com (2603:1096:400:473::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 09:55:30 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 09:55:30 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/11] ata: ahci_xgene: Convert to devm_platform_ioremap_resource()
Date:   Fri,  7 Jul 2023 17:55:05 +0800
Message-Id: <20230707095513.64224-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230707095513.64224-1-frank.li@vivo.com>
References: <20230707095513.64224-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYSPR06MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: bbb23946-17d1-45a5-0625-08db7ed04c6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nfdwRR7iH1Wuu0TxdAbjKelwyCtJV+O5BYwkCRGHZq/RJnCAK+vSr7tsS+pL1kEoG4ghZT76BmfFUzPBBaikJDqllKIywEnrRBLdrnvEuBM+V8FHcwkPLXViVIOo8CAQFymgcEPq9gCU5b67+1LEj+56H2fS0aQYTTQU7jhz7kkgrcr88FeuqMO7BDNfIE0lqd0RIWVt1nVrAKX0zOtV/pZdw28WrSZINuQ0dgiA/c2GcEkDj31NxQWcrX+qjVvrSpe4MyLCT8RYCBMGmqERjr0KxIO1LisksOo5Ocr+F2k/nUEAyc31IzZCXyqAKkoE/nxMNLefy5CrtLMc7XbMZ1NCVESM/9z6m1AoVg1v7SZzQwzuAvNpSjgDKkvtKlehZHMVAWakRHg1nqJ4+gvPQPh/Q8ASwMogpl91yRhRT7qIbvi2xSSVX3XUeKe0YeMGRkJtVb43G+fACj65zsXo3fkpTnDtn+wcwF3PKT01sc4KYuW7IssIuidzF45Lo3PxCGM3ORqeU0f8vm3fhnlu7EWsjc6IQRzIXyMOqwbtfX5d/MPtyYX942gAlV2ic7btZHlKNCUv7V3A33HVZm0jMk02AzyWJdKJ9ke/XrYuT3AYLxSXOj8gRMUkbtDWHy99
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(66556008)(66946007)(66476007)(6916009)(4326008)(2616005)(38100700002)(38350700002)(86362001)(186003)(6506007)(26005)(1076003)(83380400001)(36756003)(52116002)(478600001)(6512007)(6666004)(6486002)(41300700001)(8936002)(8676002)(316002)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nBZrRoK06dHOpivwKNRTUR3YMHPH+B4wakTLECwcxtWYatvwdELkji0nKnLA?=
 =?us-ascii?Q?qzX6oqdvhDSLCsAhsy806FfzpospcTSztwwt6oWJ3BKVaBLFyuVQ/Sa4MzT2?=
 =?us-ascii?Q?qf3UDViXlXAuDZUBBce9FoSaRiM7LEBPIEIsJAlUrP9qwjMBV/Iv4RZ6p3du?=
 =?us-ascii?Q?ZKwDP1ookJd6KkfHruV9vOdwgTqtxgaobd6LQtlCSYCWzSxtT4XaFpUwycJ5?=
 =?us-ascii?Q?NQIi9VS5s8B+ozMsiiCQZll8qHoYh7TdRLK6vcTEeOzOfDDZMePhrhHW1SAJ?=
 =?us-ascii?Q?en2UW7ws+hQwe1oMlyGP2p8pIDVd+dOwn1OW3/b9/Ds1+uge3eJZMp6MCszU?=
 =?us-ascii?Q?0H3OTVu59ku9b6M+2WDM2LWlh/3yn1JgTTTwdsXBFZmJ9K5F+Nxpqf2HSsl4?=
 =?us-ascii?Q?BVd541nWBWCdcd23LwFLq92DgoNL19qFcQzaA5GY/W3+O3MtrVkFNteUy8Cz?=
 =?us-ascii?Q?WeuY1x0pQgRzCZF5wF3zUvYPkuIyTWZWMyP3vO6RqVyibhm2ZhhnpD/eewJu?=
 =?us-ascii?Q?qPpiNqbDeYKt+ybMK124XOgy3JpNl7KqeJ4K8RweoZeOSVTRXNXuJDMOuyrD?=
 =?us-ascii?Q?gfPSZQRFvHAp9ZzITRSV97iT/C01GCQsATwBLK+h9RZC1usd5meeTwW7MLc1?=
 =?us-ascii?Q?b3OIqu6O5haBp54xdZbKTPR0OyptculUPclaEQsC20bd5mMANbtV3FarT+Ho?=
 =?us-ascii?Q?gAf8ck5frrPhZxJ9wKClsZmPS7u1BqN6uj8O0ZfkPYvXD97YXdeVpbV+rnaG?=
 =?us-ascii?Q?TijSMH3Jqg/vlzOSp9huW9lv0aQhj0+ZTglNNo6yGg9RLyH9M2fKJHqyQzWK?=
 =?us-ascii?Q?dAaBS96lbWgHv/6XgbqKaL21Qc9tQEUjSludlHSAU2o50POoxxrceB94bZws?=
 =?us-ascii?Q?litn7zNag0KYzNWHlmZfLLTA7c0TMzEkg67mU24I6Rul3fN/YuEicwJh9Emh?=
 =?us-ascii?Q?ckGJMpRPOxryfK2QPSG4R11IDNAO7W0UH9CK8XRK+VZOJKKueo9yk7mTarLE?=
 =?us-ascii?Q?MLhOziMpT10VpkpU+UDxDPdAAWB7iOk081rg/z6Rj1UeXg+T7DZsXIXGE3i9?=
 =?us-ascii?Q?M4SXCs5XP3k4t4s/aUDi51BqJZ9ZsQpQTYcTOYpkW3RPOsPFnmqa4GicfqT8?=
 =?us-ascii?Q?LxqDGSod1/aqjcpLSP8n6WKQtMX6HLf3NimZpDQg0Le4l0Px5rxMkyMBrrZi?=
 =?us-ascii?Q?qyY+rqTYRkwcBIkU37pRkZvHlQF56Kqu48fCAQKZMfXZ/nTrB7Jhl64/GOWW?=
 =?us-ascii?Q?90mWsgPsk2jrEER6I+EDYb3VyeIuP/6SQYBivs3IHFNvuFWi42z04XdwxGg6?=
 =?us-ascii?Q?/qXeSMFKy64AjfEWzU9DGodE7UOGf9cSBt0QXijQ34dWkYVhuXgbsCxUF0CK?=
 =?us-ascii?Q?rVL2OyzuuV/5pyK2fIzWsepJ7Wt6YgTqp90ue3x9medDOepobSIKafY0uC60?=
 =?us-ascii?Q?L2uMnvJpCnmcEBLuwzQB80jAfzsHNzF8FroGEVikQlMBu6vp6E3JlC00UbQT?=
 =?us-ascii?Q?KTJT8qf2AFSiQDq8gSdy96xcy80uYKvGSb445PiiHZJqNDk8iYw83lIgomEd?=
 =?us-ascii?Q?E90aTMkbMjjgelLT+hhQ/0vDVLP99KCqCChHdX+u?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb23946-17d1-45a5-0625-08db7ed04c6e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 09:55:30.5811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRNn71jG72fNuCQi58b1c45BjUOpoUZS+WjJ1YRz8NVh3buzO584+N7SJ/8yrxaSAXQTwcJ1rCuU7LfErga3ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6793
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
 drivers/ata/ahci_xgene.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index eb773f2e28fc..f5deaf648663 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -755,20 +755,17 @@ static int xgene_ahci_probe(struct platform_device *pdev)
 	ctx->dev = dev;
 
 	/* Retrieve the IP core resource */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	ctx->csr_core = devm_ioremap_resource(dev, res);
+	ctx->csr_core = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(ctx->csr_core))
 		return PTR_ERR(ctx->csr_core);
 
 	/* Retrieve the IP diagnostic resource */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	ctx->csr_diag = devm_ioremap_resource(dev, res);
+	ctx->csr_diag = devm_platform_ioremap_resource(pdev, 2);
 	if (IS_ERR(ctx->csr_diag))
 		return PTR_ERR(ctx->csr_diag);
 
 	/* Retrieve the IP AXI resource */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
-	ctx->csr_axi = devm_ioremap_resource(dev, res);
+	ctx->csr_axi = devm_platform_ioremap_resource(pdev, 3);
 	if (IS_ERR(ctx->csr_axi))
 		return PTR_ERR(ctx->csr_axi);
 
-- 
2.39.0

