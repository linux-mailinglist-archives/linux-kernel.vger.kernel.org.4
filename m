Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82C2747DA0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjGEGzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjGEGzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:55:01 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2122.outbound.protection.outlook.com [40.107.215.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D751C1733;
        Tue,  4 Jul 2023 23:54:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qidn11MFT0kilT5OoRgQIrq0kcsbLAP3BFd/FELD2KMau6sTrLSrFcWGLTc07vTUVayDjqbxLKwl+Z28NGmcmWvKrLjHtXha7f9XiNshviMrJi33X1wQD9bVKR9EDbjQl9qBZgOqVug3wD6vQt26Tvp3qh4OhKZqKJG0i2sI2n036Kb3SOstpR0Rc5xN8EuAn0aC0utCbpPo0sUsut4RCLq4mkftiTQR8KswX3n7kXXfdSco5upUo3J/fPYhtO6BZKgzYcBdmPUKOM9/QjjX4UADLrKkfThXC/kR/w701V2VX8+pYX7tvfkIpYuzrPeoD8Elm3rsPvl1yWND2RdpHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dq/ZVYgUXKyai+HzK/Dyb2odRZZrBRdAg2o3po8nnUQ=;
 b=TdcQeNJ6pXpQ0uT7HetZ6q++w/30DzRj0eFez6UN3jeXSRZBR1TCHYZUqDWSp0ptGcbs+Yh6PrvN1crrfRm25b5sU12+cb6Q+hGjgVkYACbhZb4RNgoWWIOydNWQGyE/lsWYz0psuHC1RW+iKU6XH2jcoqnfrWr3+/j6f6rMM0pmYJ98R7L9zqG6qvb3KD1jFF4+h1gq0FVeBGxXQSVeqXD/yuYIBlS0jX5tQ5fonbzsSMQpia41yqpJqhg92PJpHZqlIcHW1yVU0jB9shTsKQsQgDmk20WJxDM2+ySlStCWrRuUPo7HEccD05TbLxYtSNOV9NpLztG6XNUw3Ly4eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dq/ZVYgUXKyai+HzK/Dyb2odRZZrBRdAg2o3po8nnUQ=;
 b=CZBqTRO0aHiiVyWfOIBhOIoBSS+O3YOrIlabVSqefYkD6SS+oaFMkx0Kkzw8voRMyCsz8O7nCzsczBQabBgXVONF/i8eV39X5d0BtwCf/Luj3Fwj5YPGHKbYtLJ0TkunkctvfiS5IcZOHshVe9eAzwR6QQvO1wBpIzItV5bcF24GH1KcLvQj/1VG8BgCbDZ9qujSKx0QW71JVEv6Lx1aRdrfXqsGX1PbOABnyXgE/idQYrM5GKrPSvhPHm7ZdTwyCgvA0xTgjwwEikH437hQJdREB8Vgm6P53blWrARdZrejbU+/aQBHyhuUJVptyyK40U/jdMr6nm04UpY7Tym4QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4140.apcprd06.prod.outlook.com (2603:1096:4:f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 06:53:50 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 06:53:50 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jacky Huang <ychuang3@nuvoton.com>,
        Shan-Chun Hung <schung@nuvoton.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] clk: nuvoton: Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 14:53:12 +0800
Message-Id: <20230705065313.67043-12-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705065313.67043-1-frank.li@vivo.com>
References: <20230705065313.67043-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0196.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6ce61e-dbe2-4496-dfe6-08db7d249657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JH78alT17Zw8lH1Y/RrqN2X2Oe4zG/vv23LvPewBWN87weuS+/QqQCLYrqAXPEKQ2GoO/VZLwvyDAKcNbrYkV/aQ8ngaSddtO2hH1/rD5NgRRV6JJcvbh7qAIieQUSUVJjHiC+MESuRUSHWvu2YsgJ3UW0P1znwAFohYpi30Sp+EoIplcWgVyMLj6ZfGIsLwIbq7Xcn8w/2/K8MNUevzKRO0j01mbki3dvHCQsFNiLbm6c/vxH+mx8rr1FFSDAay/K1JxapsBvP1lUcWVjbbHLnE4Go4Njpog68yDxJxKM8rFznDeqp1GkAA3lBCClg2n7mmXCP25qlIGHhpa86+nNpOY8sYqX9m9r4QL0O3ruEI+KzAe5qsUww8d1I9m4khSToeH7inuUef2xdNQT3WDE7Sccbxiwc2Zd+FkcYflQyjcZU7auAom53DE1QG2+UP/cvE9D7OWSjNlcAJbLsscmF12B9oe3gK+jKuaIh/aLnS8OvetWTBcO7pRgTSOeoc49fMzSvjocw3MsQ5GImVsXwQOzd2c933VhB/TUV5GbC1bXgAn0aH8NJMa8lMNQoJ5tM3gHkSH3t3W9TKvculF0m9eu7cYFv/Ux0f2yEUq2RhSIgpvb7vspPHNditttei
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(451199021)(41300700001)(8936002)(8676002)(110136005)(36756003)(6486002)(316002)(5660300002)(2906002)(66476007)(4326008)(66556008)(52116002)(6666004)(478600001)(6512007)(38100700002)(38350700002)(186003)(86362001)(66946007)(2616005)(83380400001)(6506007)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VMeS6d+Xn+YLovHO4rF6c5D28mC8x8wNdOkceh8B4rLPZwcuPILMorLIs8he?=
 =?us-ascii?Q?rZm5rr3R8av+FJvG4hemeEPxTrQB8SF6yv50EQM9y1W8TVH/aN6/quueN8vW?=
 =?us-ascii?Q?35hZeQS/kodyXY/w31Mo+g+BxBROHMtOp0rzt1Ikr8FB9G2yJbffSCM2GAco?=
 =?us-ascii?Q?uof7xTuIwLS9E5cDUlVAJbylP8LkAwBHy+Q5n922TepfnJ3MBTocr+3LHfQV?=
 =?us-ascii?Q?E+zZbH2Be+qAsuWqNIv94cgUN0EbnWTICo7GPtia7FNAHwcMKGdhFlaC1KpU?=
 =?us-ascii?Q?+iVvu0fLjnMhoJC5pnFMtTrqZc26WC44RimUDDRmH+1tIbJDs8KvufPEIFW+?=
 =?us-ascii?Q?a1sFPgwd8IDfrdOJF4W/HRXm2A90DkOjbUd83G/6JsT0PtQ3B4uB6GX3wrau?=
 =?us-ascii?Q?33gWnnyaAOZuf8Rjs2SGg4xYMhFXRHQoF02Xy/sTpdeA345c6EKh+nau8BtQ?=
 =?us-ascii?Q?vY8uwsfLDBgvnJhWbC66xcU3QfNxE9palXKk8JNI6LJyBIpDeIyWMGk9sI9X?=
 =?us-ascii?Q?UQJ4F53wGwjoK0KpOjnMXNy5IiG0moX0HsuwlouyK26v8nT0SicyTocdJ44M?=
 =?us-ascii?Q?Yj7CSqNvozqxOfTPBxX4SNX1gNKDEfLBZJEAU9ZoC2syVRJUz8I86UISE7uX?=
 =?us-ascii?Q?C7x9W+fSvSuNWxDaAuvSROtUkmGwKvN8tPGaznngtUd2knRV/LpkcL25SW4j?=
 =?us-ascii?Q?mQ6P2D3S8MoxX+bjkJDVW507LN6OkI4wa6DsaWw9+AyA37uuuqvKs3OFp4Y3?=
 =?us-ascii?Q?5arx8fRv9ZkgAvyWU/txNEg3Qm1qNbCeTxMN0aW/9Tu3fsRwPUZknNwbkJtd?=
 =?us-ascii?Q?aOin9pjU5UwgnsvJCPXaPdh41Z94RKd5usyJTZbhSzgBKQ5lgEk74U44OyIt?=
 =?us-ascii?Q?MxXfTuz2n8BNCKe821MU1RdLzvNYw6DurA6QHRugc73OItKV1IWpWXSEMP6M?=
 =?us-ascii?Q?gAj9EdKaO8tU4TW7iMFfPhUotL4XV70j6HI5n+T/uXN3gfKwwtbIgpCuqyhN?=
 =?us-ascii?Q?dvHP75EbN6DFgtQDa/vi/ovYLcbaSBGNj1VL/q+94SuiXd6qG6tGmrspcarJ?=
 =?us-ascii?Q?1Q/rEYmOW2p9767QXAbbmYU8gahn86qHt5J3cHlu1HvnH4OKLDjC5atMoZ5N?=
 =?us-ascii?Q?A4Qv+ouRvVZWFwCT6LPq/BhPchUuGz1PugqfFdFFWBq6zrTwLakxWckzp21n?=
 =?us-ascii?Q?UTkuxdKyXico8PVmqqYffx6ROk/T0K6Zp9R3sz1LUVJNptX/41AddMu9iWS+?=
 =?us-ascii?Q?IWPHWYDxsW5LgE6wMA4rr0th7PWsJS3ywnwgWSgKPxy1gnlvyw1eZaoKuO7P?=
 =?us-ascii?Q?Z1QLRZofJrYHsWQAOPxR25PwAAxGAHyy+s+zGnLtHKLg2XVLnUiw4OtGxQc7?=
 =?us-ascii?Q?V0nzFkpcFLguePRyAJNW6hQrtCAlWnSjWtT9I2TlEmYGCnclwxbT2DvqBex9?=
 =?us-ascii?Q?DQVCyecTOUsOlQDHC24wue5QO9bj7z6bnt/pxFPRX6AiNVnkH6NtdzGbsdn7?=
 =?us-ascii?Q?1L7szqpAriir+j1CeBO/JqInyQMG3F+4OY44l//9cBk6EPwHOXCvRdhTTGCe?=
 =?us-ascii?Q?8rJyaQUeq4h/eHRBntjfx4wDAg89UA62JvqBsfPq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6ce61e-dbe2-4496-dfe6-08db7d249657
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:53:50.3741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cz8iJwscOJbvwtz4CMdamYxqpWXlJoUMoGz4nkMaF7QJ/k6/qevMBc1iJZQ2JA4EguBT43TUQ8OUKVbis6UuGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4140
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
 drivers/clk/nuvoton/clk-ma35d1.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-ma35d1.c
index f1fe7edd21b5..9f65d0623517 100644
--- a/drivers/clk/nuvoton/clk-ma35d1.c
+++ b/drivers/clk/nuvoton/clk-ma35d1.c
@@ -460,7 +460,6 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *clk_node = pdev->dev.of_node;
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	void __iomem *clk_base;
 	static struct clk_hw **hws;
 	static struct clk_hw_onecell_data *ma35d1_hw_data;
@@ -476,7 +475,7 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	ma35d1_hw_data->num = CLK_MAX_IDX;
 	hws = ma35d1_hw_data->hws;
 
-	clk_base = devm_ioremap_resource(dev, res);
+	clk_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(clk_base))
 		return PTR_ERR(clk_base);
 
-- 
2.39.0

