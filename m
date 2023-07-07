Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E3074A9B4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 06:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbjGGEId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 00:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjGGEHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 00:07:53 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2139.outbound.protection.outlook.com [40.107.117.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC4826BD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 21:07:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQAziniRAkYTyHUBumjyd5OxbMuh3o7v2Im/KTMRunNCEtHMMV4uPcASPuH/be8LNmqHvz32OvvitSxbtiSTi3fWIC3VVGqWgba1TqMSSyjWlZEHN+Pexw+D4xJEEf23576RoUgUyMEHNbhjgq4GdOg2B6VDqcm+LMwRgGBZM7etz+loxsV29dgq97MceJMJ48unG5PUiEpb8JzeqEFRVpkz1FAVmWhIkM7cKDp6lx9KJMQE0Zplm1+QLxZva40ReraVx6MEaR+fddiV3W/3dXkH/8g00fChxP8z5NSVJoXMqNLqKEIMR1tLw2UWVem+BDEArtxnLMA1gO2rJ9RQfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0+iI7AY1yI8a+yrMcuBIJJ035tveqmejoJEjMArvlw=;
 b=LUslpXhed2Qeu/9w504+d40ZfFK5FYrVLhiGI0VEvHXf+OUProRd+Vd+SHAVFHsw0IjYuVG035JKEZtxsWfCAQ0PEJKS9CqfhS4GXknZ0Va9b+QHh6ZV9YTovFoMJbTcUsl2iCApT3/qUA7fT284QiwjhAbGFYoYtVB5foSGosFYi93f6EuJ8ChVKN5n7jpvsl5JATUcjBoGGFpWgO8FFVH/zXFJHIEUXOyceUJISVwdwV2131DNKdfgvCbSZa2yn/1dm6KzrV684y3p4fQCMlpOfVRY1/RQAE057Wf2ciiIDvDQBTtrK1ANzfjObR31Mt9RhMN8J6qI0l8Y32afug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0+iI7AY1yI8a+yrMcuBIJJ035tveqmejoJEjMArvlw=;
 b=qGRN3jkB8GhJ6yHUXUbEyGB32dBUFeluWjdVlhg9g/5C/mRUWaGRO+Gqyt5GZ6AqYlgbn41QDAMCJaBLJp6Uee64rQ1HhuDMqJAhuAwu2Pl4QZao7oXEVF2PnzoS5PQ0DPUkdnbfwOZNjPE4KpL0rQaScwDgOfkXrhY3MjvJDRdHc3TZw8wG7rVIlg4ce+bedCQrae5KtNoBwdwK5bGXGQ28X9dbc4ISguwggUUe+RfYVGfH57XOrX6Y5v0VPDcXj637sooTUBaqHaQXAvwlJ0yuG6qQJn/E3AHORRwuqDYiaDU7lgLNis+kfvg9C/MfvgIPO0++iG5DtNJqbBAH2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5470.apcprd06.prod.outlook.com (2603:1096:400:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 04:06:54 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 04:06:54 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/18] mtd: nand: samsung: Convert to devm_platform_ioremap_resource() and devm_platform_get_and_ioremap_resource()
Date:   Fri,  7 Jul 2023 12:06:15 +0800
Message-Id: <20230707040622.78174-11-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230707040622.78174-1-frank.li@vivo.com>
References: <20230707040622.78174-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5470:EE_
X-MS-Office365-Filtering-Correlation-Id: b1fd0060-9c9d-432c-d5af-08db7e9f9984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fPAtZTwIVgvRBjNhZqPcU0/mP0XuAiJXC9PaRRCD1MIIbnHZhxi+p2Fe6oFC4FDQr4jVgCSiXU0mdTTGPKWOUqBRCKH6xiTZ42Nx2Rre91U9W+CWk3/Vnh14NAQM/u/JOBZHd5Og3eD/1Hu+ill4lHh2RnL/wZKE5B8PAvLTlD2hlx1dsWvZGoP4ffiaeLntysUSazapgitFNQTqygSBgehJhPCD9Q0924hGlYeJG2OCC6UmAnPgDmlkwyWAAMchIsPNCg5rJ29K4nl1ozqkxLLQu1aHN/vMaG3KCuGIF5Ik5r7yxygI+HqgYeAOjwklnINd4sxbdyDxDb8IiM5aLXZqX3YDfrsFn0JCJfP113vv3h5T1kObKBH+CovNNKyaqlG1NcyiFvggfFnJxBR6c64UxrlYpEP+zqfEdioqrqUNJqMZ7LytPIxecATsNNjoq4Lr4ylqdbdY1owozs/lMdE9Liy+mTHO3olHG13gOWZFkTBcVVtbFf6+O6iJnnF7bm+qsW+z1aghUJ1nzebkj8dz7QuRejOjJaXW1o2zKQaX3qL0PVVLmL6VyrW1kVqEIDDFpA/x9D7izYQU3cVX27lECttClJvvxG/9z7rlJxyFG/y7UcMyDlZwlJoocqY2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(478600001)(6486002)(52116002)(6666004)(110136005)(26005)(186003)(6506007)(1076003)(6512007)(2906002)(316002)(4326008)(41300700001)(66946007)(66476007)(8936002)(5660300002)(8676002)(66556008)(38350700002)(38100700002)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yrrKd8NvaXhXEJm1qjp6MSCLYc3qGi70xFKH7tJtyJFytwApRLfx+5NEhYx4?=
 =?us-ascii?Q?EZgN4Mp4N2MnEEib/WStpZXUj+4i85RdJyQPxlKBXBNgmT7dK+hsRfmdBucC?=
 =?us-ascii?Q?3T3+0LSmg5O3++lG0z30hOr3WMgmVBGAtYDcMcply5p2HQERgHwHpQUjMvH8?=
 =?us-ascii?Q?X89Suhov+fWOhnlyTBpdoLqM4Mwk7zH465KGw1C0ybhlUxdkQQziqaKfdCBQ?=
 =?us-ascii?Q?tTk0y1oJmmtxCBXl9vrDI6lP4xG7UMQpRANXZKcWw8C/YA4tp7aFB0knVWf5?=
 =?us-ascii?Q?5h5pqwAj3SV7lqEaBbTxrOEwrtsfrZszG0lzfkddi0QLwyWoR62bAF3p33i2?=
 =?us-ascii?Q?UzB57szLZSzeZD1NejB7Pvyf7SW1yPJkXZn7M9aDNwfsD2zauUtT6u4DwoAC?=
 =?us-ascii?Q?iZvrKQzdXUw+I9fa2jyNy8VW9v7QZw4KESNYcwYTolJk+fsJpNNa68VYHTbo?=
 =?us-ascii?Q?Cxm4FXSwQcA8tsM77ATdaNDhO72CmnlYYxHY9a3rvS1FOlZ7pdkDHqp+p2DG?=
 =?us-ascii?Q?+xLi8+P7L/beuqEqz35rNYnJMntcBryTZKB9si9XgzHZUS2waQrP/TCzit+x?=
 =?us-ascii?Q?u1yntUeNL0/0KDT0/0TmKmktiOs2W6V0VABfhHP5HXDQJp/N3N2iSm6/mlOR?=
 =?us-ascii?Q?NxEdX+QCGkzdgKBEcj4oTH1TyV7Vs5RTUbHthiDmXtUFANTLXdxRCAVwlrR5?=
 =?us-ascii?Q?rVMafBSeop4+ZgvJ5Kkj5/W/jxSHxfbedM3btjS1hgZtux3KEJMNm7Nde9Me?=
 =?us-ascii?Q?DJpXdO6bzjG7ADveK1DTIdu/B+kmpgEJIW3TZItIo3731KM0SDxST7UvYMp7?=
 =?us-ascii?Q?a7c3jKeLqGRii1CrBFE540hbcbcjisXUt93mszx86Ra4jGL8pM7/vKT39F2O?=
 =?us-ascii?Q?HNqZ3YCBySCknOypskM+TvwrZv2vxdpxcZ80Opw1OUas7NnOQzHZglKiCTge?=
 =?us-ascii?Q?jjNUeFxlncPajGGan5IBX6AqCjMXdl1QYX8IjFd1X+YFBVhltAboDAyLkI0h?=
 =?us-ascii?Q?aosk09o/oUkj1F3xameiMINMv3lKeaGxdaoKpUHzGBaU1Xe9jJABBq923t0O?=
 =?us-ascii?Q?mAnNsLnJ/PWqN7fKDvyXcojHhDh9spYhUl4ZuC/2Wf2xkoskBugS5tjm8Lu6?=
 =?us-ascii?Q?Fr/etwRo+N4KrWrVgBrDeAOjA3vqIabMOUh9QKcPct9VCv3ffKTQxcAaPwKO?=
 =?us-ascii?Q?7+ZXCndcuoPeug1DpojX3Z2Vfu0/EjwgUUADpfKhQaeLG9a+Gy0wHr6eOst5?=
 =?us-ascii?Q?VQSh2eh4xRnE4pVs4nw8E+s6hn4IMJh0PLJj83+WepdUft5aoZ/R/rWQps/c?=
 =?us-ascii?Q?U9q84vL5ySs+p5qHJGIfwXsqsZRwPqiOl2Pv3Iro9Camwa73ii17ELQ1KLbz?=
 =?us-ascii?Q?qnEQmbSYTIuum1FXbwIYi/2AKr2HQM7Tltt0GKE6L9UCdikF5XJhDjfAAnOD?=
 =?us-ascii?Q?++94pLAzBKbcEEJpq/+16Whttr/95VEtdeZwdcSYyhr8mhRXk+zSsTH1Jo79?=
 =?us-ascii?Q?/uDV3PrMwxTzgSvHvbyIlZ6kdoRf2Iwm+rybkqWW9d0BMT9WZhfouV3qMWCA?=
 =?us-ascii?Q?0W8FV+NS/cuw6Wt1LqpnVA/3rbnC/gSIfvH/oAUL?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fd0060-9c9d-432c-d5af-08db7e9f9984
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 04:06:54.4860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tmz84jE+1ngclHaZkw1uGw7/IiCaGCgTv4S5VTSmNNHrSsRVMaopk3eKhPOJw33TJwfjNh1vK2HWC7w9ThPeaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5470
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() and
devm_platform_get_and_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/mtd/nand/onenand/onenand_samsung.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/onenand/onenand_samsung.c b/drivers/mtd/nand/onenand/onenand_samsung.c
index 92151aa52964..fd6890a03d55 100644
--- a/drivers/mtd/nand/onenand/onenand_samsung.c
+++ b/drivers/mtd/nand/onenand/onenand_samsung.c
@@ -860,8 +860,7 @@ static int s3c_onenand_probe(struct platform_device *pdev)
 
 	s3c_onenand_setup(mtd);
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	onenand->base = devm_ioremap_resource(&pdev->dev, r);
+	onenand->base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
 	if (IS_ERR(onenand->base))
 		return PTR_ERR(onenand->base);
 
@@ -874,8 +873,7 @@ static int s3c_onenand_probe(struct platform_device *pdev)
 	this->options |= ONENAND_SKIP_UNLOCK_CHECK;
 
 	if (onenand->type != TYPE_S5PC110) {
-		r = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		onenand->ahb_addr = devm_ioremap_resource(&pdev->dev, r);
+		onenand->ahb_addr = devm_platform_ioremap_resource(pdev, 1);
 		if (IS_ERR(onenand->ahb_addr))
 			return PTR_ERR(onenand->ahb_addr);
 
@@ -895,8 +893,7 @@ static int s3c_onenand_probe(struct platform_device *pdev)
 		this->subpagesize = mtd->writesize;
 
 	} else { /* S5PC110 */
-		r = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		onenand->dma_addr = devm_ioremap_resource(&pdev->dev, r);
+		onenand->dma_addr = devm_platform_ioremap_resource(pdev, 1);
 		if (IS_ERR(onenand->dma_addr))
 			return PTR_ERR(onenand->dma_addr);
 
-- 
2.39.0

