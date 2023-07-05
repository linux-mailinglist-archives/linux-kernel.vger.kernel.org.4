Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065EC747D95
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjGEGyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjGEGya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:54:30 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2122.outbound.protection.outlook.com [40.107.117.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73515171B;
        Tue,  4 Jul 2023 23:54:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZOYGwNczmiHrn1S7hOQ6l/t1I7h70YIVkPapBLbEeX8gbtD1WDUj3mF0+Ggc5q4gusD6zZi/k07n5jXaztw4hjN/6ktm8Pwqds1vDMhde2rMdoQXBEQ8YKXHDw/wVCwXTNZ7SQh1Htd1fqNhr4p5l5Gp6b3kzvmJ7Yzr2D/LfwzNSZr7fvlx3Cu8B2Rx7+rzwMgKZipfyLcnrcHqKUm8PAIi3zMd+VfSbfoTZOFZkrgeALmuzGFchvDIjTxrpamyWPoSHV3Jw2GnIFDYK3Q3VFUdLFLpiXevvju0JO7nb5FxabVj5Z55XrjWMAJG69FBr9yVD5wCjD1TU5zX1s3cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbABw28bHcAgDi5TzlvCIupD6gWq8yQwR+DTbLa4a5k=;
 b=YDjPO3KeX/2zjfK6UV609132AzTaDdzKrhwJU8iVxzJz3u2qbRYEArYDMGgLL6iR7g8KCkvTqIMy3ZmslrafmXus7buQ8PSHZvI2AzNjH8pPsf5NlED6QtlJmHrR0/HhLgWL8+dnEpckR7s8GHj/JZ0+bV5vOOwsAVLXfCabsJE7y2bDTssGloyYqHRxnpFyuJLMEPnu1azaflV+T/mtVYQ+TN5vUtLIMeq+CShHt5cQFul7qYoMwmI9dWbAeSuB96f0TqxloEdqpba3Ap/DSwp1na1DByN6T0VNBPeTE4U65Ep5b35i3Bjl5nWnosC7iYgQ+nYSRifGXQD035qADg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbABw28bHcAgDi5TzlvCIupD6gWq8yQwR+DTbLa4a5k=;
 b=pmzVBSnWmjtpTGNMgYULU2+76cOubLIiwKhVLOE3LOklSeXTB1pS8tGgStVx9pkdYcg5muzW5sJBKDhOo7WNN8ajjTh9dbOYrY3LBXxRl9MDbe5+wVhS2FRC2XXkF8xCydd4M4VujtSv5JoeGJ3Iqyyj66iXRaNV8EfM+JjMQ0znIZnzUO745980Ra5620qoyRF9YNDCpjlzv1lPGbcJC2s9yt7CI7LY/VC5UT4LXEaYEgvw3NYfUvkYaMHhV4LRPnJUoU6vHt27tlIxHr7TI6j2MslS9DL5029seTVvUpWUewOXTEmMdKVqr7AsWQQvM5DnIcRG0y65RBRyzRUDUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6087.apcprd06.prod.outlook.com (2603:1096:101:e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 06:53:32 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 06:53:32 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] clk: bm1880: Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 14:53:04 +0800
Message-Id: <20230705065313.67043-4-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ebd736-0e2d-4815-31e9-08db7d248ba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D0/OiwJBSxwD+6SbMec/dAZPBpURUEcKJ62q9bwh/qqfcBmwR7CF+9x1sgf16ktvHQeTiKMKHeteFjGekn7xSxAyR3kcQmL+ZFLP0y03QkHuLsCaM/mDgFmtWQ5J1LDgEyx0rtgsEcO/gC+ZpA9ncoasROXVeOQUXJEs0KGOL4Va7il+A3h18PBtnLJtiNb4Xwj7kca5VAqkrnQJ3ZSA54W0TtZ6AaEZH3TJ0OSFxv2MdtHYKG4S3cN2RUr2kGBgiWJEbIKohnSfz2HhtrhSaiRSQu7mNOTsLYwQvW56tDSrChfOwADZ8GOhbqUN4Rrq3T4+EGYCc5NjB37aG6UHihQIys4/+a/gL14MeFwexlG88awLEIaunMFVFYxqcYCVC5JeCjlZWQaCAnodbdT+cl8NNqxC2nnmxMgbHjRJjMehNLf63lsrAngX8K2Unu8iWNiym9zqwJ/jyM1WpVX+Y9WDSPCGZEDTfQZYPKB5BZEI4XsgzoXAfeDlVtXQs2eV6I5qUZ90iXIr4q/cf3srfkCFh5rEa9pJOkOL5l2ZgSDl3zRe+pUajpV/9H9MXTLocoiGzEwCxbJsyGcyhv4RHXzTeQp8fL01MFF6xDGQjLYLa/Vf3Vk+4LRk/rb1kMdI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199021)(41300700001)(38100700002)(6666004)(52116002)(38350700002)(83380400001)(2616005)(186003)(6506007)(1076003)(6512007)(86362001)(6486002)(110136005)(316002)(478600001)(66946007)(36756003)(66556008)(66476007)(4326008)(8936002)(8676002)(26005)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rYg/fPMA9JtY5a80+hmT0DqmzGrfjXc/YoadkpAN8tKlWeCbcsBxmTI62eyQ?=
 =?us-ascii?Q?h76206/GvY6qan/Uc8GutfqfsBMtvqHp3pvnvlh53IRZGrDj6DDl0iaVF2Um?=
 =?us-ascii?Q?juNus6N6XY73U/rX8+p29FoxFgC7/mpTUWjHNz68B1m56t/zf67B0YS4miCH?=
 =?us-ascii?Q?HiCct615NX7wO391nF8epxaK8srJ+mc5352xrgqENJkRsjjNN44UTNSxGA2Q?=
 =?us-ascii?Q?KbyAT+dS3PXXIw1OwGS4V1i07i88eNhz2f4p3YxynRXrmWUEbWlRpOE1M/cV?=
 =?us-ascii?Q?FES2cOhlESh3az3y9CcGm977atR4lPBdqlXOJ6Sm2ght6l9U2bpzGWLS0x7o?=
 =?us-ascii?Q?vrV1jlzZlKlG0T5s45mGP5OC5rPt2BZ6WNLyoiJVsrTsrX2h2OT3gXDAHGcV?=
 =?us-ascii?Q?5TgWMV7dAjlsKrGq+IRM0Au8VF+o24Zp6A/VSRYXH3HSBX1z78SnFpqPgUm4?=
 =?us-ascii?Q?WtF1Bbqe/4DzDTtQ8epdhGO1h/kVNXCHgt+hRK+BeiWWfITfeZx0FgYSlWKp?=
 =?us-ascii?Q?rUJeBKvQ5w0hjuNLFD18bA2cz0y6s2cMn53aYGEKDQ++Zz2oXhyPWInNqxWk?=
 =?us-ascii?Q?LJXBijABgNUbV5DbDYQVHlhtI2XowxjTuOfrgj+vsfRhKfCmcvM83zVAkoCX?=
 =?us-ascii?Q?tvu/h9jFhX4FOV0IN4hNhT6rv5x4F/HUV/p/VI+jVcDLNja0YnllRHXvUdNy?=
 =?us-ascii?Q?5tlQh5rEDGATNopZnKZPuag9hTUTpM2xsc6Xh0l48cVQifDMxPMVbUpICGPE?=
 =?us-ascii?Q?sugsFb/Il4mg0nljGUNE21SkOXeB3UK4vnqCZHrBU4GMutlcXd9o1K6uTqKl?=
 =?us-ascii?Q?N0eWijAS7dwIPiHl1Ds0imBuBRcWM8/wXDCN4zdTyIJ5+sVc2ftRGWY3vFR2?=
 =?us-ascii?Q?l+TCDhNSgnwBFZ0JD4NDnqOysXMed8DOyEXhu0TheJ/8yADVE+Xwb7p3c0gv?=
 =?us-ascii?Q?2W4FyMC1NSQJWJQZJEiBcG18nVk5QWZxMsH6qP7dUB1hArUfu22rzKTx1/JP?=
 =?us-ascii?Q?VWHTQiyxA8JemAgy0uVRFBSA0eJCyKr7+Y9JuYZ2tSnzkh0yB2W1RvvdNlop?=
 =?us-ascii?Q?GcXbU76f74niOZsMSLzPuOyU8rvKcJG2FVIE9Ew7QQGGmFyqKImGNw/Y7iwP?=
 =?us-ascii?Q?S2u1gtjYtsU8kAAFmNvV2KOJtaZv84ERAoYU80p0gpcfjy/aIAFs7HeyrYZJ?=
 =?us-ascii?Q?r0ckv9mw0rw69MD6FqRHeKpLGXFuEu5AADpZG4VYaUSX87KFnF7/oxIsi9Pz?=
 =?us-ascii?Q?ri7dTI708IyrefEw5xJ0cq1lXmVwmP9j8/l0tlE01gBBjr8AaRIvQopfUcXk?=
 =?us-ascii?Q?l94+YqRt5oqrUpqRbBFWUxNYikNPFzwrUnYQljVyLoQxpOYVZsBtyV5sYDwQ?=
 =?us-ascii?Q?lLZMivf0AmRmyZw3FKt/p2NceRuaK3CYmJFGfFykjC2fLPO/SSwvtqv0Tcc8?=
 =?us-ascii?Q?Nszrz8b24SuDgbGQL7DpkWMmyVJzMSdir/Ffh9XXYtQs0UFIXrOeaDIhYuV1?=
 =?us-ascii?Q?8+ob943nKW6tUpPV7Us6sdCoKhKf7UPQE7IVjzzxqKw6SFROvs+fGjBPeoOH?=
 =?us-ascii?Q?sVG2mMDd5HYk66hUUegZfIOvf+KTi6D/2VVBxdv6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ebd736-0e2d-4815-31e9-08db7d248ba0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:53:31.9920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SambnBO2ttJ67ZesfRALT40AFBNw7QLJGwFq+GM01NwNDcV1xhEqToRZT2RQt4Kupq9Z4HgBZZOBFwhP+o0UTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6087
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
 drivers/clk/clk-bm1880.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-bm1880.c b/drivers/clk/clk-bm1880.c
index 2a19e50fff68..a3814817ba86 100644
--- a/drivers/clk/clk-bm1880.c
+++ b/drivers/clk/clk-bm1880.c
@@ -876,16 +876,13 @@ static int bm1880_clk_probe(struct platform_device *pdev)
 	struct bm1880_clock_data *clk_data;
 	void __iomem *pll_base, *sys_base;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	int num_clks, i;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pll_base = devm_ioremap_resource(&pdev->dev, res);
+	pll_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pll_base))
 		return PTR_ERR(pll_base);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	sys_base = devm_ioremap_resource(&pdev->dev, res);
+	sys_base = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(sys_base))
 		return PTR_ERR(sys_base);
 
-- 
2.39.0

