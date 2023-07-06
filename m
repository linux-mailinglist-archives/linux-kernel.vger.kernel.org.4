Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E495749919
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjGFKLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjGFKLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:11:32 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2135.outbound.protection.outlook.com [40.107.255.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FB11BE3;
        Thu,  6 Jul 2023 03:11:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwJAXQxPYJe3N0M5uT6zDFs2mIdqi3IK8Dm3PGVVFdf3cubBR50UnI7AbcX6OxH4UVjMxDeiZGi02WC5DShq0Zi0vAUShDhGPP4mMIBxVhrQr6zQnFaZsnp19f9emqyLFq6FPqv70NO0A/Vu1J8nWZSblPWCm+YsKFjD2OO5vTo88TGGDyxyOt7SHo0wSu3oyDUxaP/cHBbrarQhthV+dfAnnMAuimp43MZMZReBLpJnO/q1Q12vQH0aDVYnBGj6tiNdg8BRFfOYPBOqexu3twcmFQIpuUXFGzEJ6Cn0Ga4nvyVs6u4DLOvFfPQRmFt7WkRLxC4hD72Thhnmo3iQgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MS2FDuWAkni+a5EwCQTyvqVldbp/7BosU2IV9F9kZU4=;
 b=J0GYFpRZtv8aWdiR4Y2znYLS3ZvRFfc55BDKx2ltBV/D3/E4pyusaBlcUdlmGoJaz9O7RhtUeuvPfSfcS89QBPK/xr4Dd9T3w4rVL2BfUiBOzZavjk2fSBBIhRAeqvvu3aBWTZOgd5z56PcgEanroZAlxx3oEFs8ZoZuc/GbswvyftTDFlMr5WpXmt+hR5uRpknmjzEMwW8B39XSQ4q3F1BtctRhkqBEsUfe361UpsnAhkP6NLEeHTHjoRg0dp+gNAQWuNxnyq72Sxbt7nStjBNShVtRrio4Mz3McolbaE7/xOtEmgG52ZemDTWdQ8SYe8w/cWYxSRldxxCw5/gONQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MS2FDuWAkni+a5EwCQTyvqVldbp/7BosU2IV9F9kZU4=;
 b=V+V6lRBMNexLH+lo1blEnea8Z/YVc3AFelm+1PQ5yumePm9sp6zyVyYFv00XVoP5hoY+rILPE7E5SnH89rN7MDNQcJWFtkdqPN8WI7aNTc7l9AzORSkLIl4nbdaEbzydSUvggkQjXGVIJ9LkH+knBImNhuAT3bsSbt8WNorOoxkUE3wcOTV+AcLMxrN1HTjAv4NLELYqpdQzhwO9627VOGfSFvQ+R6fE1kfBAsywnap6db8tzKU0CpWQdSwvDJ6RmDeO9SOFFMNOcuAzjySc5U477PnAmm22fnPE4oJSS5UuqBm41eMY+o2qKNnV2HII9C09PifWDORHfR/wsqZQ5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5287.apcprd06.prod.outlook.com (2603:1096:4:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 10:11:21 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 10:11:20 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Eugen Hristev <eugen.hristev@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] media: microchip-sama7g5-isc: Convert to devm_platform_ioremap_resource()
Date:   Thu,  6 Jul 2023 18:10:54 +0800
Message-Id: <20230706101100.75654-6-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SG2PR06MB5287:EE_
X-MS-Office365-Filtering-Correlation-Id: ac978c5f-75fd-4886-7191-08db7e09580b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 39SQiwkLR8H1cBIaI4K1yjTrV83hpb1p7ka5B6uEFtJjwWha0xK7HnM1t/KBZhMP3c0ehFNq8Qx5qtfbRBHFBc0e2KUaqmun2aOrTIjYiJpK1wkskRLq2EIXn058Yyab2v8sxTXP5nAfRBbnjUZs783JVjkkRcPaoUuL0xBh8ol+mTqGTuVt/dK/eJf2BOXWXBs7Evb0ej1nrtOsB+nkFNUlyccxxBmQcpQcLR+1WZ7T5LYFXvMF4BHdLCwvvaCLmxkDHVwOiSrLN9iC2yK5Nix+WuIR5AoaXJ8bixQMtsCAeTT8u2qyL1xY8R8UyI7j742ksH08pSl0fd3S5CdBqjvi0fKjc8JD+wc9e4r5/JWNZT3Q7w7qoD9pMlIJutnx9efVeUGF0Ti+k+fvECaLig162bByjpgeABP7TzxbH8CjIwF8QpFV2MXCHO38DeM91WI0VnTOYBud5lCyAAWHx0OyhpU4D/EHj4fd09hCEOmFKP5Ity9Os2cThW9eoDXBkx6tk65gv5uE/3SPOWXcP+0LOo8m1VSPJkJwhi0itSmuAGyz1VVWKfVHn1ZgLPr4wJDWQGXcViQQVCW8MW40c7aPLq1Y5/0HjDrEHlG+GF+IupT+XnyH/yvApBRoixfV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199021)(2906002)(86362001)(8936002)(66556008)(8676002)(2616005)(6512007)(6506007)(110136005)(478600001)(6486002)(1076003)(6666004)(52116002)(186003)(5660300002)(38100700002)(26005)(83380400001)(316002)(38350700002)(4326008)(66476007)(66946007)(36756003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lNzgCj5hlZDYKvn1E+Vf7kyX7RgbQD3k16i0T6bhfuqdLZaKgOO/sOQUlvtb?=
 =?us-ascii?Q?evN4Nw4Rc7rL9H1EMZD1EgN4jlynim4K4eyNMLY4nzuiPPlVli8kMT6HCxJx?=
 =?us-ascii?Q?ybk3jiMVFRdvz7Ko7NjtiOf+TqFSngSpLbtALsKkQteb+VzmFrtwkcMBzcxo?=
 =?us-ascii?Q?aqcfc9a0blSSTcBlp6vO5eRphwIDqFOY6i/9oNtpXV4idQzLNL35nE+q6c2t?=
 =?us-ascii?Q?2G2kS6XKC74/S3IU4b/9gub2FEqZXaFq9Z+n/SZGQad20+4In2ib4J9rqogg?=
 =?us-ascii?Q?iLIelkhepPIFQiaBbrtN9+5bfyHaX7UTcpKJ/Kb48YrcobtolW601gz/Qzb1?=
 =?us-ascii?Q?6uHJc/zKKz8hVXfko609NcPl0mLB1YdKcmfrLl6mY9eLF+HhrniwfKRydpKq?=
 =?us-ascii?Q?PT0WdFCpDj2Zrk34JbQ+3w4oow4KkdwQ+A1AyATxO3B1/2soozHvJEYzi7/L?=
 =?us-ascii?Q?XCqMhEPrqFMLkDxvqeoXLbWffhVH9ijiNyUNB5H42nvsrdk4p4bwkmrQwQoV?=
 =?us-ascii?Q?4oDQJQyHA6AkyXXf1N75x1jXmgCxkpwHexPiX/T/2Ki/cSXO06oz8jnTWNrB?=
 =?us-ascii?Q?1DeiXZ0EvNViY4GGXsqVgAngKRcKUUt0U9Q781v+tho22F1NJXNlyKT22d4u?=
 =?us-ascii?Q?bCh5OusWgnFtyU3n3bFJoy5yWz/oMratluUm1mlG6E9LWJFiQUoPuDVFTwQe?=
 =?us-ascii?Q?eJse6vaVtioQcYodaQJW0GAIYPwoRk5xHZRJrUAHd4621pnOuWNlzArEgXNC?=
 =?us-ascii?Q?EXTVDuO2LlcelWNjCKLRVUXsf3IEW8FktfM59HunFKxToseayl70D26kknN2?=
 =?us-ascii?Q?da7BhbdSNTVaSuyHFAxi7uQlIRL9T3w+wIYojVMVOHFHdJZ+Xts0RToosnA8?=
 =?us-ascii?Q?YrD7rpT16hHEQ9NPXypTNmDESWAE+lVBKrTYFHtQJIXTz3jh6a6JaQh95VMF?=
 =?us-ascii?Q?6SPYrTsLs5s42eubBFEeoMuFFfGkvooemPrdqLvw2IItfpOLHd7vToZjjgeR?=
 =?us-ascii?Q?ZjGzWjsbwDoV41o7DyyYNs4khriQ5aQZXbvjqqS+qAxDNKAzgwtPbq1CTamt?=
 =?us-ascii?Q?C4Yrf5rmaK835Bo1lmS3NVkKcd35XAGL2r+LMUFfA+Sp4a/cNaq1LYSvOn0a?=
 =?us-ascii?Q?v9T87+/8aZ2/LhW+S/lUbnyhMGSmw8oTbtt4itUuvvifcWR4yjmDW57TYtZD?=
 =?us-ascii?Q?tGnOzK1HAkZPlWkBMVMucs9Q6EDSBhHmRTaJjY8lCLux5jqyidKCoLo3fQhY?=
 =?us-ascii?Q?F/BNEVI/Yz2aohBsXw9YFBgU1moluT0Bj9sfxS21opXhUtP1Wi1rk8Lzzu3H?=
 =?us-ascii?Q?Ko1Wy0buyCl3orgII8m4dBok9HmXZjcJE6l0aDol4FoUqcPn8XbJIpRE3HGy?=
 =?us-ascii?Q?oI1Yw2duSh2yUduvJEEzl0da8Gu0yftCSkiDWqCfo1CkY3exiTWHACvsSy5A?=
 =?us-ascii?Q?GkEjcf6ETLm6fVEVKGCiHR05jgQY52oeOoMR616Wg2CbuIlkWDV5m3bDOptQ?=
 =?us-ascii?Q?Bit9MroRzEsIxROydcahN5KNq9W/VmwacY/NEdYLjFRK54x+u8wluT+aWcn2?=
 =?us-ascii?Q?/HVUTr5GJ1QwIx2f0483Eb8kelIUaRuQkwxpAZEN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac978c5f-75fd-4886-7191-08db7e09580b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 10:11:20.1847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOxPM18ngKDq3lhQxHq9cyuMYnduk7SNllbcmUiIhEGVkg3v4CmJnW6mwnwL7NdTVjEPCMy6MmQ9LKhQ271acQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5287
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/media/platform/microchip/microchip-sama7g5-isc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/microchip/microchip-sama7g5-isc.c b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
index 79ae696764d0..2543e05a3389 100644
--- a/drivers/media/platform/microchip/microchip-sama7g5-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
@@ -398,7 +398,6 @@ static int microchip_xisc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct isc_device *isc;
-	struct resource *res;
 	void __iomem *io_base;
 	struct isc_subdev_entity *subdev_entity;
 	int irq;
@@ -412,8 +411,7 @@ static int microchip_xisc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, isc);
 	isc->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	io_base = devm_ioremap_resource(dev, res);
+	io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(io_base))
 		return PTR_ERR(io_base);
 
-- 
2.39.0

