Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B94574948F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 06:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjGFEHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 00:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjGFEG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 00:06:57 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2103.outbound.protection.outlook.com [40.107.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D1D1BC7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 21:06:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vph6zPWkZngcJxwN8KAEcnwOYln+pb1Q/dRc3KQ0cVzmGT/lo4RCbLjyoW53OiRjidXMy6HXfRrIjlPAqRp/thP6Vi1g3ghwLiViPFhLNC2TphWbeb12I9kEHdhZAEBtlZJJNhzbq/TH/mIQu0/sVoe9I1jWuQfw6VOsYIkgyJBnADtN9RlLchqz5uEKrYK8N0pO4Ep7AxunwJzy+ZEtHrRBg2aB/SWwou1zUi0Lb+QQeTacpHwg2mACfkVhzR783e6/kq3EU3ljg78t2ML1SyMFKJ+5DHQmrVJ9k3jXGJ4AxYzn135ULfFn8Ml2n2uGoEXZh6vhKMwyQgtamtd54g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gp6i3XVwslbEcJdro/w6HtqhqmPXyj0JhfOdQi64F8Q=;
 b=UIinEzqsrj33yW4MTYSYrnm5UYfBIg3n3Sm29pnO2npCfaOjlDcGFgxCbyoHzf5tUbVmvW4mT3Lda+Ei0Ld/J8C22QoxPdJT+JBxlGydn/hNjFqAEqYWkh96nNQ/c+6UTn0+ppHK1YPpBGySfIhqRKCdRWVs8+wwh+b+QpoKaBTzYiohVHXxcxMGT16TpjcKY9sSpLv+w+PD9y+OmiQtmyxSW7ggl8dXUtai9Qq8wjSTLAs9tgA9T0//bZZVf4ugxh14r0LJ10Ov8lAM2pvDYWik06YoiZpmOcMF28ydNCbKimUhQahGL8R94tjvO/gilO6+46bmfjwtMDLhqNjpqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gp6i3XVwslbEcJdro/w6HtqhqmPXyj0JhfOdQi64F8Q=;
 b=MCGMp+9AHVXpttknlzWgPEhI8h9nT1jVAMtFR8atTS2m/k/s0UYY5odLnIdz8NU7UZNsJfUE8mR79353npNVx01Ue+FCet8mh1x3vsMi9/yMvxoH/aUtknp+K2wuofvnmJMBiAj/YekheRiyvr/ZzoJ4ED39k+0DZ2Gsagd/L4N5Se5O45f6Uz/dFO/HBDWEAlaSWqeH8qh1+eCuCXkqbroiNW/C7svO7U/FHftS8Dl2a0NnHB2IReGRtrFUmN0J7inxOZR6o6vsVtFDgkmGy38CMZRqTTzwBKPNp9fKpsjEUMMkiHykyW9BKLSYgSHomA8cnWQPRUwPNbSTB8m4Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB4548.apcprd06.prod.outlook.com (2603:1096:301:a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 04:05:27 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 04:05:27 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] nvmem: uniphier: Use devm_platform_get_and_ioremap_resource()
Date:   Thu,  6 Jul 2023 12:05:04 +0800
Message-Id: <20230706040504.34057-8-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706040504.34057-1-frank.li@vivo.com>
References: <20230706040504.34057-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::29)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB4548:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a68796-df39-448c-d8bc-08db7dd63b67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vjmBrGEuy/sIQ3HvoIGOq+PvRjCwMNf3R9NzX4A5+fzbdMLB3BTTfzsIuO6EFZnf7OK4ZvwI9jpM7ZiZuHzPUrplm1DezDP4g+V1AleaHeM7IrIaJshCHt9fIjiv5/q7sLQHA7E61HTpoMWRKX1Hazol+U58GyAUmMZea4rC84606nkwiSWlZV8FfLfBF6LUKmZ17MV6y0nIdyOyoO9I7/sLRjOfN8N9YrDoNfkbgdBNKrLWGg4N9LEGTn0wlTv2khtPItYoe5x+oYzlUrNoSkcGwgqcnfb9Vg68zMMUwTcaX1heyhOR9/n+a0/BZYKdtfsyQ+HbcG76toLJS/b4qXW1ZPvVqlN8HkndctK5zaIC6850BJAA2moM9dgcGlaPJvqAjTW7/gztTQnoY75yhVSOomlKN8OfggyAygXbx2xra/MXr3kJblbPqxh2zkEI1P6qaVdRpraaBCPGKXGxor/iNdKuc84PJIq75LDwrynKXzQLD01iP8rbLi6lMlfh7OxNPvyXe+qjM3rfBBsWxSdr1hf9ilGI7fckN10vW0UygijHGJ+3siwHOoRJDN70Rnr7J0fexYNA8yiROjVe5X8FHTNmbgNrWZKwY1hNEca1Si27u2fai6qsjdo+rIuM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199021)(41300700001)(8936002)(8676002)(36756003)(110136005)(4744005)(316002)(5660300002)(2906002)(6486002)(66556008)(4326008)(66476007)(6512007)(6666004)(478600001)(52116002)(38100700002)(86362001)(38350700002)(186003)(66946007)(2616005)(1076003)(83380400001)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jq3+6dvBS81FscUTR47FjYYeOM3emZ+0yueHzsinnqvhdzXaQDC7mZnaAydN?=
 =?us-ascii?Q?DvinG9b8lIaiGV5tu9PagaESfbtet+W+8f/1SQ8mbaR5dTMNf0agBINiQYNp?=
 =?us-ascii?Q?XyGQvDym1obq5JcVTtQdc5XmN76WFzHzciVquhpIbh5hrZxWVHPBX+32YfZp?=
 =?us-ascii?Q?TuRcPVKh8G/oKW1BIJKHYpXud6b4xJy2jA7tNOzDdqsDNbfxrYDWbRiJ/+8e?=
 =?us-ascii?Q?G14e+9+vA5CW0eZGSywA5PbASWRXYG/tRsgF2/0Y+07S6VM68V2+WUYq+g47?=
 =?us-ascii?Q?9DW/zkkT8Bdp8MSdVHT9/jhZTEijOpaYizLdii6PfPPI0enLVrNtMQ42Ny9l?=
 =?us-ascii?Q?aXNVLLUKVhCOGZ/R64A3YfO4vepPEawJ8OTaLWKefMmQ7L6oTQuv40kZeiwr?=
 =?us-ascii?Q?sSuT6FRHg9bE1upb01DRakcBHDzpbVGwOidrWrsAa5DWpEtvEC6mjjF4e2TJ?=
 =?us-ascii?Q?s7xwaWISZ2OKUjr8MvD3QBAzBosdMLcs/IGd6Yykit9QnW9nmEK3jEgZ6qA0?=
 =?us-ascii?Q?AFgXUbL6XjhnswK/UZJRTnC2HQGM6CSoLJaLHuFpBw6kTdRYXPE2KzcHNOek?=
 =?us-ascii?Q?JAMcNgn6KOVDVqolo95EEqXxqVUsxfrzT3HVAWCMWPOmiLlR2lBhaSUGWyp2?=
 =?us-ascii?Q?Knpcb2ZUbbuDY1ijhjZ1UdXIYKEUzLMfOyTlmiSTYTXK5StaK7k5GRKytTEH?=
 =?us-ascii?Q?qxUl9yJV9RT71JCxPgsW9aCqfi/IH0wSghwllwLEJPwBUxPDjWshGXyGqkYe?=
 =?us-ascii?Q?72jPcwU2nMa0JHEtij1HFaP/v7OBbC5591rQEJcPfS+51XQUv9WIOciWTEVO?=
 =?us-ascii?Q?RwCD+GRxpq2em5Lhf+52MgCIiJwRa/W5FTvtUAAWu5v0PY0vKo7bGwkgxSo0?=
 =?us-ascii?Q?VoI/LY5SWUBQMnAzKaX+bmpPxQGp2UhsKhltNr+cxVQLq4fmLMHtbBUbp4Os?=
 =?us-ascii?Q?50hue5Ioc5B6Re5NwmX6U80gEt72lmeEbv0QUsdJAccVOGke1CttNO7l6v/X?=
 =?us-ascii?Q?AGAnas5UKXm3lr+LCN+yAUX7vGUsuuDvNJCPvccZqjw02tkUGnqCt3eElOwn?=
 =?us-ascii?Q?iCB8OLLuyjiDW03fXYeDKruyUImJi/tG/I2CorOP5G8SA5gzM10L1Ui2qddy?=
 =?us-ascii?Q?CrtZTRxS+BM9ndThhC7bChhHU5QUz7p7TuHxpFWQcUNJuYSKqbdFKCFtnj2f?=
 =?us-ascii?Q?O1nSGRYyjUoNoLny56YvguqIfsGAmZsNA43kAVK2dqxDE7FT9UL2ali4o+zT?=
 =?us-ascii?Q?rYZx8NsJw0NOdnSpDbWMhtXnrUq4lYe+xYYhcZe/5s4VH8NUaZ8Vq5w4jcCN?=
 =?us-ascii?Q?wpnk07jyNCyTrmKfzkwCrkfQgYzHJ3B0UvtJ15WGimf5ksgjrxlpy+SrDKWT?=
 =?us-ascii?Q?goH/mOF6v7XQAkvfZCIOXJzQ8peWmX4lPLkNTN4QntqdafvioyG6RRt/R6hR?=
 =?us-ascii?Q?nzweBKTeN/As+stvPy8FDAAT25hJyBgWLrj45TzOo0ULshhfUCkek+u1gn91?=
 =?us-ascii?Q?vnSMIGpG2xggvHaBsLgDud2XWuxZ5FKwduH6EzSoO1qcDGy5hnfQ94BBbTT+?=
 =?us-ascii?Q?bzdv/pHEC8NjsPJ/CTN4l8gWXfeFIcyf2maImad/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a68796-df39-448c-d8bc-08db7dd63b67
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 04:05:27.8226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sq0eLj6c57+5v+Sm/vzWx0Gv0VXhyai1eeyOishzyr9JRMN9cmImptDR+g1HjW8QP3PmOVPBgbeRVMbxOQGy9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB4548
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
 drivers/nvmem/uniphier-efuse.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/uniphier-efuse.c b/drivers/nvmem/uniphier-efuse.c
index aca910b3b6f8..0a1dbb80537e 100644
--- a/drivers/nvmem/uniphier-efuse.c
+++ b/drivers/nvmem/uniphier-efuse.c
@@ -41,8 +41,7 @@ static int uniphier_efuse_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(dev, res);
+	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-- 
2.39.0

