Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2676750346
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjGLJfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbjGLJer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:34:47 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E812F1FF1;
        Wed, 12 Jul 2023 02:34:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrZtV5E1qzrcitTZlF1uV9nbHzJ1wI1tLMhO7qAiZmwEJS2iyG2zt4wcBfGFfl/xHwRCGAb6lSaSXNpgjKA1os4HYI5G5E4V/YVB8iuUvt4rjbiFnw8fNOuWBYhqjfGpe/Gou7GsP3OFYd4fPfq4kXE5Cw01FRU5nfDWspLijbejzWxd7+xl/EG85E7v99GvYYMbLlmgGDsQglKhHaAV4AoeKbgr8B/R2gapD63wRoUmqpuRPBx5+obzb0Sq7EgxifssgBfKZE6SR9s+4B9GJzXaG9JshNbYofYqtl5I8KXqgwD+5C31lv1cFexoA5I+fwNa4YkTiBdK68adjqH1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHAWR+GUpAJDQGPWQJfK9K89QVrh/eBdAeEeYad/c7Y=;
 b=UNOcyUNh7al7h5BKwLklCKDiq1naW3AusdKjIGqCFCOnqm6cowMW3cv+HLi2GfbW+LFX2Rh9Nlq68KZoCykVbjEwwVdxhrZUUYMuRQ6mkyn90sFAJTduMxZ7z750/Xcb2N99CfZhYwcgmotU2ajLCxJ293RTVF8+ITlPYbuRVE2O5ywHW29v4K4X9Rqekt0bBWkIr3TRM2/w18HwdLOxaAJ8y9hBHgwSOsCselwRKUWWhh6pYWhg9BbNUkHSyf7sMOUhddAhQDpiw7goG/EMjKP6X3YKynjZxeYKYLlCfBNIfdHfH7KldlqoMIsCcMNOgcjTfmjSgQW4TNKUTXOBRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHAWR+GUpAJDQGPWQJfK9K89QVrh/eBdAeEeYad/c7Y=;
 b=fuhtAMRdxhKYbWda7dyC3eRgOAjCpPLjmtkCx7+aIf12YBZxr1CUyJwuLOYQpMG8aCZ5eJh7ngBFGyw6EmxmrBs7oM+9c6DOJrJCFiYgfUQFhtrHKEXTZavmRJlTkTE1gZI5kXuMNVcqCeiYequC7ibCPj5g74Y65kmuJWlzZi5diQDlLgT0RBnnsgFd9f2a1o5+FVskjB59BIBlxIw2g+Frg53DdRlZN3UbKNkA4mLiPQzig9/9rWm3G/XLb3hsEpvJOzlW/uyKWnELWNIOalNE8Pqos7l9XCaRnvebHLqT+3Th5qWJCYlwegu5hJT+0kAQ5CoytmESU2HjzU/GcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5985.apcprd06.prod.outlook.com (2603:1096:101:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 09:33:56 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:33:56 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/19] cpufreq: pcc-cpufreq: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 17:33:16 +0800
Message-Id: <20230712093322.37322-13-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230712093322.37322-1-frank.li@vivo.com>
References: <20230712093322.37322-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0172.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::28) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: 292f889f-7359-4be9-1cd5-08db82bb1d17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K8iv0pXMx0d5b+vHXEv+cPGeqh6X9+mafmNcTOSJV4JNWUZO0JhpPnCl0c3x727R8K1+tAzW1pQztKv+tzOKstS8Jts6+DaBhL+o3QMxj9+QxsgszXAWq2RD8psNoSefXRgZqpzYh/3cWgnaqeO/9HH2QpI7u0Pd+35Yc+zCQerArsRuTdM/+NPyDLlIB5D+kF3ysn6H8/D1rd5giddC61KmR4CoriVwUDQHfd3zkJyPFTcc7IJpm76HkLIkqkCGa93WqRFZq13HlG6+gOo8ozAqSjz2RGjRLHppJVuIYNk9FfMfuUu8vlec/8uwc3Ri/YOt3eBvcxLF0hCZWCuWIUi++ji3NIZd/hbHKlSAfKm1qUkZ88K8KdkqGFbiEtkEiZaYInRjDYvnc4vYDGwKn3HI7dZlAAvqMSwvznH81M5ZHmmoCgVDzq1FZ+vNSyqg48fSgwb61F/U8WfsXMdfxHpEC4dXzakS6JucOTsYhxEcpkhNE9drD4NyfoGVryHtgbptTNwN5NiuPrxwztyD24zJ+tMFtjNL1rAEey2nxk3+HJjHAIihpPpRdryJLrOk+5W7+zV9ExUX1dfVcwXHuoe+11y2s8X5n5htNBk29U/lfdVLxSELmWD3szeHjeka
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(186003)(2616005)(110136005)(54906003)(38350700002)(38100700002)(5660300002)(8936002)(52116002)(6666004)(6486002)(86362001)(8676002)(478600001)(316002)(41300700001)(2906002)(4326008)(66476007)(66556008)(66946007)(6506007)(83380400001)(26005)(1076003)(6512007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djM4WllRVTd6WmYwNkwydEhheFg2cGxUUzFJa0ZHRjF1Um5UdWdOZE9BQ2ZI?=
 =?utf-8?B?NDhOSTVDbWdiVUQ5V0VDbjM0N2pBMjRxQWF2bVZQekI3SW9zMTNKS3hsRHhE?=
 =?utf-8?B?aktiSmtEczJiM2ZYcUtrTE5SaEZvMlpvNWtNQlBFcXZpWDlXb3cyeTBzSDhh?=
 =?utf-8?B?dTJoNWhMcXhuWFkyVXY1c1hQbThkODZZZjhOK2hBRCt4R014YmFrclRleDZ4?=
 =?utf-8?B?dE1SajdDMnh6ZGhGY2huNW95bDIwVmt6clJSd0N2RzFZWFFCbmFkMHM3L296?=
 =?utf-8?B?NFBnVGFpbzdoSlBxUDJxSTBvU3pjRmFyOW8xZVhOWmNMcGNmRGRndzVmL1Iz?=
 =?utf-8?B?TytSNjU5MGV1d1BldHlIUU9UQnNkeUlxU240bXlDTmJQcGRGeEx6a2M0MDVp?=
 =?utf-8?B?ZHNpa2hUSWVoUm5UQVk2amZaMS9pM2RhbFB0WmdlVVptQjN1eE1LR0pVU3NX?=
 =?utf-8?B?YkxXWW1TRmd3UUtjcWo0OUh2SlUyQzFoNC8vWDF4NW1JNnB6KzNGWXpiTmYw?=
 =?utf-8?B?bTEvWTNsNm94aDA3VUFaQlYweWhrL1ZCSWhDMnRMZ2pUZkYwV0o1SUxWcU5p?=
 =?utf-8?B?Z09WZDd4QjdidGIxVTNPU0FPVVdRMEVlYm52c1BJTFZtU2NLcUF6U2ZRT1FZ?=
 =?utf-8?B?c2NPeVZhazFVWWMwdzFxenhMR0EwN2ZQT1JkUEhnVTk0VFhvbkV2V2FWVTVK?=
 =?utf-8?B?U21pOWk0TXRmRzNOdG9IVWp4V2kzQzdBTDBxd2dyU1RyQ2NIY0RWcXlDZlcr?=
 =?utf-8?B?UHU5NURiRnVCV1FvVmxOYXk3R3RBd0ZSUmtad2JvK2Z1SWdESXIxKzcxa2Ni?=
 =?utf-8?B?bjdTcVZ3dHAwdlZxbVFUMUVaMXg5QUVic2RYUXhOL3BjTDZQVnhmRWRWU3k2?=
 =?utf-8?B?SmdpZzhVSHVNOVMzZU95V1ZhYmlrZTRyL1NwTW5xUnJicnFCalVFWXBhcXkz?=
 =?utf-8?B?YzM2UVhRcXRqTWMzakJUTkhPV05XKzl0N3dmUTZlVVdiZExLQUptUTlySXlG?=
 =?utf-8?B?bzFTL0JPb3NsM2dmRmZLNnAyMDY2eVNkbXBwTFhmTTk5dVVWcTFiTDVFZjc4?=
 =?utf-8?B?MUZQeml2TGtscmsyMk82NUhRL1RrN2xQeCtia3FSbXkzbmZDUzFvY3hSRC9P?=
 =?utf-8?B?WXU5Y2pxYXNPSW4wUWRzMTFpbVlKYmF4OFJta3B3WGt6YzFDZDMya2lLU3JV?=
 =?utf-8?B?S0VkcEVGUWxDSWNGV21JZkVCNWtoWVVlcjZaaXJLeS84SU9YQk1RNXRCMzA2?=
 =?utf-8?B?Z2c5cjdIejVSWW90bGxwSmRpaitGVGFmZmJsdEUzaUpmUUQ1KzlvRCtseGJ3?=
 =?utf-8?B?TkwrU2ZYc21hSHZTZnRDZzlxWVMycUMyUll6Vktrb3piMTJmTVZ1VEZFd1Qy?=
 =?utf-8?B?OEdJQnBlWm1QemhhMldXV3pFNHBrUWFMZTI3ZTRoZzkxQkR6T3JFMU95TFhi?=
 =?utf-8?B?OTdzQ3FsZ2N1SFNtSndRWFlrUUtMVWdTOEFRaWswaWtHd0ZwREJEV0ZEZm9U?=
 =?utf-8?B?N3lyekZiYmN1dUliR2plMVlBazZYbU50VTZnTkVxbWp4TW9HdVdXNzFtWTlW?=
 =?utf-8?B?ZzBuLzlnTmZsRjlZMSt6aDlBZExKN3RnRWtCSm9sSFg5UXhXcGF4Z2QwZUUy?=
 =?utf-8?B?QVZuQlZjRTBSTDRRSnFvNWovajZPdTN5STFLWDUvbWY0UlR1QVlETjdTWVk2?=
 =?utf-8?B?N3NaZWUxWjBsdW1mSWxweDA0SEM3cjJ4WVJTYjdNL2kzcFFyQWJLRU9hcXJa?=
 =?utf-8?B?d08xNjIreGJ0bkROUkZOdzVzLzdFK0k0SEtCRGRvT1lFRk94UkpKa3h6TnFJ?=
 =?utf-8?B?ZlI0bVh3SU9LaVBRVERaeklTVUdZczdSZHptczhTYkh2R1FUWU5uUUhONWsw?=
 =?utf-8?B?Y0t3QU51UmpBZEJ3N2hJQ1BabldxOHNRYjhERWdqRms1Z3JpeWFib01XanZ2?=
 =?utf-8?B?UGU1ejNBazBOVElKZUhSRWZHUzJMMDhpa3hrWDBkeXMxTUNod0pQSlBsdHJQ?=
 =?utf-8?B?NS9EaVk5MG1JYnZvcHJVTzhaeGQ4bVQ4SE9XUGFQWHVqdnh5ZGJJaVllMWVX?=
 =?utf-8?B?dFZhUUtJQmsvWjJjWXZhclY1YTJ4N0hJdnNVSlEvT2t2N1J2VFZTWlFkanNa?=
 =?utf-8?Q?XB/jm4uMt50ppFeQwWTFBDBEk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 292f889f-7359-4be9-1cd5-08db82bb1d17
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:33:56.2940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTOnohbT5o1lO43d4NLr7IANcKW2NHPDA1r0RgJ899uTOkYT9Qlq5LCaTl2attdeXXpWRb+F4P6NBpwMm2Nqgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5985
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/cpufreq/pcc-cpufreq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index 73efbcf5513b..84fe37def0f1 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -608,22 +608,20 @@ static int __init pcc_cpufreq_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int pcc_cpufreq_remove(struct platform_device *pdev)
+static void pcc_cpufreq_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&pcc_cpufreq_driver);
 
 	pcc_clear_mapping();
 
 	free_percpu(pcc_cpu_info);
-
-	return 0;
 }
 
 static struct platform_driver pcc_cpufreq_platdrv = {
 	.driver = {
 		.name	= "pcc-cpufreq",
 	},
-	.remove		= pcc_cpufreq_remove,
+	.remove_new	= pcc_cpufreq_remove,
 };
 
 static int __init pcc_cpufreq_init(void)
-- 
2.39.0

