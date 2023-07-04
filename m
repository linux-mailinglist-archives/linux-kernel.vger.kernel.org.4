Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56E8747058
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGDMCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjGDMCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:02:35 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2110.outbound.protection.outlook.com [40.107.117.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F18E62
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 05:02:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdtxXqUgCeTZguAOvFn+70dnOMT9NYxR/cngjNKxGmmo/3keyZxkOMQK+d9xL6KzLPgO1e69JpTEnjhG4Tkv5O1sZ1C0oAg3kzn+J81P9TcAg9XAODnzetThoV7uYUPiogN1E4dHgTellUpAOGTO0QQKXXqczchGUjIwbHyqtCGqLGlyQmM7DVDWi1YJXmz1vQ2UJITtSh7ECwXGSkfvuCldnFIkkUJtnwQc1k+3aRQid8hUifX9Rei/XaYh4AvGdjWbJcQw+IU7WcT3ZoUn7/BlxEy/Kpv9YrtxS3+hsaJ/dF4uZqv2kc2JwihpiNX8WPdbob09nUYrM52VjObb8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gErAKk7xTs3pgJAw1u2E8wyjIQEFQ8OkMoJIOhhJvoA=;
 b=OBCWcaV6o6GP5BZhMeKD2g1QetEXl2QLcM1nQpzwF5ewQOmE7HUyo9IgocISqm2f7eFsSiKrFbzd+i2gWMfKcW1TCGtUq65cfmM+D+8oLikAaivGZJNkHfcQDFeKbkfAybnFmJ4f/3KPKwZtxY8g+MF5bBhp0/pS6zn1skQDRkZA15+zMvsdEAJaarDAUdm1bsBQ4XBw2J/Hhc9IH6waJwLczkGyEF+XDJA+XZbOhkQKQitX7xyWrj32LVNSpA2XfLc/LhEBC/5ZtE/E10PqMHi7qIERv9ujc8WeNHVML93kjsUiyZezdeZu6tyZkUOOW7ST2YizxvRPElT2lZJ/nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gErAKk7xTs3pgJAw1u2E8wyjIQEFQ8OkMoJIOhhJvoA=;
 b=ivaFTOKCSus61gm6DGExBRdtzIvh38tceMsMmf+yF5DgDcpC6NTQ2FtLsqg+ddxYIzqo3hNylDcnmJeiSu7x7iHrBLwLW+Kb1bpKgqS+ZC3n6oKBTrVJMXrcKe48FLme1PQ+QGst+btXbQWyylwAVX6/h4KfbRt0qIEx5J393P5o6IodJ0Zv1JAWXmZ3nrnWIa/g2fs10yOh7Qpns3LZpyOn/IqbhlEmdzB/oIEPDH1XO+2n12JuHzXwPpPvVuMSaP/bq2JVKuL1+QcRMcJvzgpyvKWKaEebJmDhhrsjSfj5LG6W7vfycUOiTHIgDnBDZl8xefyTYcf5VyvNhgNO0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6052.apcprd06.prod.outlook.com (2603:1096:400:354::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 12:02:31 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 12:02:31 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] reset: simple: Convert to devm_platform_get_and_ioremap_resource()
Date:   Tue,  4 Jul 2023 20:02:09 +0800
Message-Id: <20230704120211.38122-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230704120211.38122-1-frank.li@vivo.com>
References: <20230704120211.38122-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0144.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::24) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYUPR06MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b4bde4-aeb2-40b6-e5cb-08db7c868b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2aesFOD36tIvjIl32MJQ5OOpk29kurcZgOivuJ7UnLRKrmar3YwQFuWMF2g/5jFGPN/rR/DY6Ie8lNtiPJRQFFfJtzjIl0GBZlaJ1vGnltHKtbEFZas2EruNv/bSE71v9Mc1jDNYUXbAoJjxZ1bpcp8KtQFMvSwaT+EeMnWMVNFIfwsZx6MVSK8j0rcR4QbW0z9cQE/TbqOcQ5POswMihyeqtxnLgQF48mMK7SgH9XuSFx9xBWJRvFkm3JBnWk4nN5HYeBwOceMn0e3bgslR0z/nXOKM4z+1OJb+hg+9RNqYLtvt5PmcjbVaAMRCJQ5XAFdB4XKxm+eAkvL6+DZcw4nvMyigEhOYWcghX0kmvRax0n+XVxDYCUS0tKGn9FWAdw+GdwK93chCPVTkUc28aFUlHheHSQIg/E0YpnY7Qfkhn1gX1PIp21H8ZrMM/R9CytSRhiSDpPcpawoFDvIZ75cADa4hSdQayHY2XOBa9gHERa34lxg+1ZlniEHxa2RPKk/5qaWNHXn32+mU0l08l7XnsQIQnn6xeJ/HzVFI128pgvXHeb6RbDknP+h7MrJNRlxmMVxB2IxV9dmkVG2c2hY+UZnh/D50R2BzTWbapCem8td/6b+SfDvKSHlb+1UY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(5660300002)(2616005)(86362001)(8936002)(8676002)(6506007)(52116002)(26005)(1076003)(478600001)(6666004)(6486002)(186003)(6512007)(4744005)(2906002)(38100700002)(38350700002)(83380400001)(316002)(6916009)(66476007)(4326008)(36756003)(66556008)(66946007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KsNo7fRmXqtVbWU242VsuDOG2jbUHANSxaQcgnCw+sUJo6BaV+chWw3XM62c?=
 =?us-ascii?Q?Q+4+/m9pqu0NiRFcMN7Hb98u52tkewfJu9DvJ6u8fMmAbkoOCRd8XaOFzvNQ?=
 =?us-ascii?Q?IqHq3K1eqAlie7qhGejvyMotDUNQCXMB5YTZHYw1mP0kfuyzfhyJWSxLBT0q?=
 =?us-ascii?Q?ReXgPQSSiYPQM6TQfb4v/8BwfTeQjb9MPVNiwFQzhihtPmXf8bDI2cY6dg5u?=
 =?us-ascii?Q?i5LpIPcjVIu5/tMZHfM8jQ8mZ/K1ls0i2/n1nAY/aZ6aYgrnzunQEdKMoZwZ?=
 =?us-ascii?Q?1wfwHHO64Za7LgX8VB6/ARWG64eI/knLRF4Dv62eyeIQNIdBPbXybhRlMHrI?=
 =?us-ascii?Q?VoWCesh+hHSQXk3zXhUU6ZsNM3rMktcDth0xC/Vq5gMFGOkZDeazzb1JXWIU?=
 =?us-ascii?Q?NP7NJ1KDq1BZtxmcatqByvIg5Sz7cffoSV2sPNh4xmajgdO4HbAkzDAciLlK?=
 =?us-ascii?Q?xIrGs1f7QixlDOZ4zjqyRs5jukVpB4qaL0TJE1KDdwBXLtx/Ck7Y9BNCOj6N?=
 =?us-ascii?Q?KEbOuM0JejHfYrk7OnlO5reDZpEuEMy4/dyz9LHDy6+i8CaZqvgaTHQ5qzg4?=
 =?us-ascii?Q?YJYNpC7El1syrNHMvpK7wmJeGpLEoP8KSuEGk02pLM76bYWBnGmzLP3hk7/N?=
 =?us-ascii?Q?zH6vYlmZOE/e1B2TJ/w0DnFwT9mu5hKpWE5YEi5DLZ1I/z+DGRo/qvM8MG3R?=
 =?us-ascii?Q?VlMoUO2b6/lnrae/4jisnYdGPo3y0pkOWphhkQj3eKDlqYPirCcAo/ytWIWM?=
 =?us-ascii?Q?uOCvZozNbK/meIxg933W/uHMjpTjae00Bjy9H7ImfJkxYYS2bGol5c0LSyRB?=
 =?us-ascii?Q?5DUWSj73is7gJIAHAOd12yW9llCODt3VM4A1V4dS0Zkx0kTpRNPWnH+8Diz2?=
 =?us-ascii?Q?B8Rnhd1CPGG/bK9qiAy5E38tiknHok1YPLPFddBqzTpl8fdPbLQ3XHClueh1?=
 =?us-ascii?Q?IhkjlL8C5Pj0ZY/jeoDDVD8xtr/1Nu4aKqOENO+yurmJPmK88G2lW335Hsi9?=
 =?us-ascii?Q?rhhjT1yrnCM3B/Go5dLeo6jB/d4ylNL3WBAUjcnZARUG2D0XFsoyqqqHIzcD?=
 =?us-ascii?Q?G70cEF5O3FUPE3XVJLUYuYn7t2NLmMTb5DHkWTvTL7m6n4gDn/ZdIcs758WB?=
 =?us-ascii?Q?TUcPehqQ7DnSWQO+p7che8obZ0w3tesxokUAmF6vmjqLcsLMfpN5a1/yT0Wc?=
 =?us-ascii?Q?q1s8uxN5kPtTlo0/MB4eEXPl+HdJdnbkj/rYJ1WLv4pu/ULRBAAn9/5v6G+H?=
 =?us-ascii?Q?vKQLCx0qn6VPfPGJbJqL8rSn40/928cTXvpZGmeZggow8TLfs2XK6NcQTjh1?=
 =?us-ascii?Q?xZZIKzXOKSZYLuwOplLkmMGNOV282CqjTm0zkWhlNhm73byIKAQpZyrkewTF?=
 =?us-ascii?Q?rj1+uhKmS9yqKZiR6fq9ZYdZ+bMOQ6JNZWFtx2EUWoXgSfSOiS8hwwt4v7Vc?=
 =?us-ascii?Q?n9cLTzNpTTYB3PDgc9w6ZxbIueAZe7y+HCxWJ0OskHkpMJOz7u/DRxL+H/FI?=
 =?us-ascii?Q?5V4LRmDXK1c5sBvViOcCt0blJVK4V40GMSe2VhDmOcD04px8k0wSwUtuxzpt?=
 =?us-ascii?Q?IzcrRMDIlPVED5q/o3b08kVICjkm1p6B2roStWvi?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b4bde4-aeb2-40b6-e5cb-08db7c868b80
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 12:02:31.3016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEvUDBH+Pa1GHEeSajy/pESMJlNieitpZyC/WgRTbVNQnX3FtTnFEhhuc4EeQ55AR8CBEnpz/3mj3dns2NeQYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6052
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
 drivers/reset/reset-simple.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index 361a68314265..1133b2af7692 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -170,8 +170,7 @@ static int reset_simple_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	membase = devm_ioremap_resource(dev, res);
+	membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(membase))
 		return PTR_ERR(membase);
 
-- 
2.39.0

