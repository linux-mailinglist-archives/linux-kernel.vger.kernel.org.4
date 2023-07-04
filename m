Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B167746DF0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjGDJsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjGDJsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:48:02 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2112.outbound.protection.outlook.com [40.107.215.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09898B5;
        Tue,  4 Jul 2023 02:48:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSXDz5n1T5E5DfbR1nmsFQFfkp1K/rs1+Jpjfck0X4ZmMdpTq+KIOH9osEd9objFDsed74IbDcCSV2aar8rv+4fkScUlbyOEPpookZsL3sFwVAkUUgFwa0a1/JzUaxmaoUhxWf0UPhzk9lqzmn9L/0QyFSYUuCh2n7jAFNUsGd4bl2wPFazwk/QyOHgRHB/J2r3Ll+uFjN35gp4Usj5BAXx+EtntAwu2QQxmb4qpai5vdQ4r2ScyqfAq2JK2tT8Eb6/UbKdusQuhQ96CIZMWX+7A9B2kdA9KlNsHsAIsCP57dHYYhNdppb3nB1twVan0OhWTt0ym5tkESxuWrIFAfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=183HJOQvmDlQVgEgcD5hQMtawkkw4U6Xl61Zww+fE6A=;
 b=dOyd29o7/7HesSyo8ZnwleujANleMv82dcznKHtuUqWPqrIu/8DwpQBEoEGwj+drjbUf+ShRWAtFIzDh9b7IekAmW+NRDLs10f+mfjIKFVMZDisE3aVOUb5mj2ze+gu1bJ5Hs0mqeoe/NKlBYE+UryB4NvpjZvsm1HWL6KXcYYYis0X/84B0nWHJl5mpPQUsZRF4vR6xTZq2B/BeJQJXzd86kHNhawr/CbfRsVB9+P9g6x9bnkEJBncPqJslIYfBkzmR7QpTXpHz380KkgCWhg8tHavL9hEY+5brxFwwiO38amI1wEbLsEgVV7XM69q8V2UMAHGUx6PIxOU0opT7sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=183HJOQvmDlQVgEgcD5hQMtawkkw4U6Xl61Zww+fE6A=;
 b=REaVaGMEYY2NiMB8J9PCRcsCybjVPduWL49ick6nktykJNBgs/ZRtZruJ5kmR2YXLFy3TG40pAI5erweYnfpMV8mysmrToO17ZB0X/O9yuicmlQymgcuv1X5LEh4VnWHjxeEFAVOp+QP0cHkOpYS2tGE/WPr9XuJkirf8rhJlrN2Un2nmvmyWjAYlq5csZEva+b7u+7oDzQwGgULS2kABI30i4uiXou+O/jBd8LQ+RaDUFdd/Z1ghJ+wPLFPKkn0dbAbj9wUV1xV8tQJascJzMn4xgbqpglCMf2CVtyMAg63G9cTSuP8yeGl1LkFZ2uFtRjHrv4gCJ6gXG2kFFbaTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYSPR06MB6768.apcprd06.prod.outlook.com (2603:1096:400:475::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 09:47:57 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 09:47:56 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] leds: ip30: Convert to devm_platform_ioremap_resource()
Date:   Tue,  4 Jul 2023 17:47:45 +0800
Message-Id: <20230704094745.25665-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYSPR06MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: 67412af6-bb49-4a99-bfa4-08db7c73be6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HaRPRDIe55UkZVtgK0l2ieVPIWyWn9Y3xC5mrv7sK/6zu248abELvnx/7pCLQCLs5UvdRbbSz8TW43dYe+gmPDMvCaWXVZreoJNyEKZMuLfCiKZnbir0fWQ34dEdE7xIUcVeCTp6h21tynQsQNcP59P5Y/vmLG6XGNNcuM+QJ1h0yey186isGC1yr/AulmYNXR97pFXYOGGK65BfOLEI1n1osh/dSFp+LvrIXnFh4KSv1Db28ZhCYlBjt5Y//EnUTdxdrIHMsg4MX6XsFFHu3VQ0gnwgOewhCUa9MThCXhwtmKNrsHKLxEtkwfVMm3lo3MoOk7pI8sqT4oBXl92YtTIKOc4x1PEGS3UWK75uvvscbkTFlp0B2X1DYDrWrkrJKTrwuKWkHuVziiyt237uCbd4K1vzEQqHmDmytYVwTHACqNn5cur8HslOa3cqzbfZ/J7cfq/+yNZii9iEvMOLtiLnaMc0Vu+a/6/8ydzEYp72vuSUy3UdiNQwR8shOmhMzPkrLcLBFW/RxBcfRRnCBEaff886QDai4tZqeExDa1LeH1XG0PmvJt/9NdKxgOlgthxyQ9UZGS/Dyb+3xWWOVwpISQ+fN9jgS5VFDkAax4Zp16zPqpwy+0t8K1SDlo3I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199021)(4326008)(316002)(66946007)(66556008)(86362001)(186003)(26005)(6512007)(66476007)(1076003)(6506007)(83380400001)(2616005)(4744005)(2906002)(6486002)(38100700002)(6666004)(52116002)(38350700002)(5660300002)(478600001)(8676002)(110136005)(8936002)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2zvU3lxtI++qMhW80Fu5IKHSDQfgpSh+qG4yV8OTREyxFLXRPCWk/FAAa9SF?=
 =?us-ascii?Q?u9SPUlgr0wl45lzDSz6Djnwoeg++xma/B2pAwQg5etxSIfGC6NL5JeG9s8Op?=
 =?us-ascii?Q?RkHZgLmnJSKW1nFhcjEdAl1nu9eD8S5f5oGN63FIcSObf0v1xzyitTlUIrAG?=
 =?us-ascii?Q?B9YsryU/dXllWrujTFlx8hbA6HzmvCrdjJvbVfPbWmHkGw3M3WpawaAEI0HG?=
 =?us-ascii?Q?Suae14QBGKTbI5w9ZyHqDq2ZIxQSsskHIX1SRKfpNFS/Fy6tk23foPwXpgTo?=
 =?us-ascii?Q?aCg0FZjohaFiL+ZQ90UiAu+5CQ86Tf9wGYGYOsAvFj4Hr7ZG6KpcvBHeF4XD?=
 =?us-ascii?Q?vKVuCZFZstXbddWNYzW+n31J93nrJBYvinHePB8heYtz5lI6M3OrWFVgteHj?=
 =?us-ascii?Q?GtTwNEJvu+/NfdzsESNi5Twj71Vk6lVTXnUCf5FxpJlbWuIe4GCm7IWdaIKw?=
 =?us-ascii?Q?d4+YClVrKeqpeZmbwY+ekoToFK+zArqz4zP40RXS+Bpmsi8O/1o13oMJDWgd?=
 =?us-ascii?Q?/HrQ6k6wiD2SYCe1vu9duJI3MSZd3+ytTuxC6K0ub9Bk4VpYy30DnSVE5uoa?=
 =?us-ascii?Q?tOKKLCWLoA7d9k9C6lwkA9CNRSDx2DY0SqW0vluX1AwiEcKVOqcUwrXW/Dte?=
 =?us-ascii?Q?qW4vo16sJUeCAg0zDfSlcj1JfZqlGQzbZsH0wAbT4rHERoFFsz/j2EcitnYU?=
 =?us-ascii?Q?TW9qiSX3PpWg/yMfrg6tqWlGOwxpmtB+2ZFjCPojSg5z6aKOmnz7S7NPYwY5?=
 =?us-ascii?Q?TIEjy784xjSRWa1lUPcif3yS1yx0XmD3ES6cr7a7YZSYin89pZKKLrhJyVv+?=
 =?us-ascii?Q?dJDGK/km7eQg6hWGOvfaguplIowe+QIumhpdg/7Ew8tBJ4T/CTJ/2tIhjC2f?=
 =?us-ascii?Q?+K73Div5iX6VG2cTofJzumZwfhxTpIf2vi12GLx4GpXmXmC1PwD+mI1bJ7KL?=
 =?us-ascii?Q?IsclaPRCKvu+l/3Gr+iqlGc2ij0kUNsfuSQk1UzYNp4aTKj+m0jIYep4sAQ3?=
 =?us-ascii?Q?9SPiVK/Z5VI+LgEwJdo9SWdUDLXk8xfTSmGw6ttHByK0WTV5MZOPnhoLM/tm?=
 =?us-ascii?Q?af9GUWt43j7tXb2uholm4FJ+VCNJ9nrUveFNNBB6VaMEcsrIByTTUlM1QFls?=
 =?us-ascii?Q?dU+VFiEzVH/oFxx189MoCc84HyeJb/ocGKIvvysfaVPS1R4/Vn7jEZFDJoBL?=
 =?us-ascii?Q?672FAwIFL5GlSqWHIyAb4HY7wkUnUhvc6/QjJpC/HM4y7nshTFJb/NnxyqkD?=
 =?us-ascii?Q?1Xuye1BouaXnZvp6/ffKvBiGE8dOXg//CCBI43+c9ROfTMh/hWaBSEA9rCuc?=
 =?us-ascii?Q?F30XU2weppqFwc1xwh4uNBgJDuPh+MjBkiT/RVTU1fEOVxZzYITGGXUlmce2?=
 =?us-ascii?Q?U35sPbcKVB9xWLfnkyoYYkLOdMebY19khjvpKmrtimc4SUoJdAgC9SlP8+7N?=
 =?us-ascii?Q?5KffmHK33LIsua7sTMf+ecOMMJtnB/C/iQUIZzdidYzk+U38VjfcE5VCSrg2?=
 =?us-ascii?Q?1UgoI6IPbskNzKccuUuBPWITs4wmoXQqWhSVXjF9aYK+1ADs8yd/WajRpedL?=
 =?us-ascii?Q?5Gm83JYXOzOMwLi5IRuMFc/vp/vcgt+SgW263IyX?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67412af6-bb49-4a99-bfa4-08db7c73be6b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 09:47:56.9060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iX2N6JpLT1Ucdeo0ys0u+x9EW5xdFWUkzWf6HB8VrVOXnUDYg5yWuh8rdgHlngXNr6fxaTANo4zSYSToM2Crkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6768
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/leds/leds-ip30.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/leds/leds-ip30.c b/drivers/leds/leds-ip30.c
index 1f952bad0fe8..2df24c303366 100644
--- a/drivers/leds/leds-ip30.c
+++ b/drivers/leds/leds-ip30.c
@@ -27,22 +27,16 @@ static void ip30led_set(struct led_classdev *led_cdev,
 
 static int ip30led_create(struct platform_device *pdev, int num)
 {
-	struct resource *res;
 	struct ip30_led *data;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, num);
-	if (!res)
-		return -EBUSY;
-
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	data->reg = devm_ioremap_resource(&pdev->dev, res);
+	data->reg = devm_platform_ioremap_resource(pdev, num);
 	if (IS_ERR(data->reg))
 		return PTR_ERR(data->reg);
 
-
 	switch (num) {
 	case IP30_LED_SYSTEM:
 		data->cdev.name = "white:power";
-- 
2.39.0

