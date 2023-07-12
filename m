Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55F8750351
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjGLJgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjGLJfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:35:36 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2108.outbound.protection.outlook.com [40.107.117.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D8E1BD0;
        Wed, 12 Jul 2023 02:34:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIZ3eTciWWlQ3bkqW/ah/mjxztvXh1163axUCcviXNO4uulo5OYRvuTyLc0jgag7aC3WHAE47S9x6F6K5yQZtmZcZKS/cbfTSC+RpwdAp7a/rYT7BfRoPMplYv5Pr6kqTXaan3wYaAPILju3y6yZ9SgDRLMQqheZQBIrJ1ILIXsRr3+TaT5Ry2FwqQwtpC3mtPKtJ2EtIU27CVpfxalQ9Izwe5rp4bdGw2pgb5ZLis0COW/2DmhWmotoJ3bkwJwo1bQoCHZGki7B0GDKgaFGrSwhMK3/uz/039TFybI/0CVl8A89f7otUL+39doWp+/gNtVxkmlqtfhlFJ0BhRmAzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xxd4pDuQMQTbe3wajRQCtOORyTdekhjvyWLURZTgnKU=;
 b=ULc3kncwFTQ/cvNkYc9BnEII6+AtsEu/gXIDZGz9cTwgIa1//Obk0wwg/LyWuMvATKRfMnM9zRYfYFrKn5t8+7PS46nv/M1nd5Gc3qJdxy/Xqp+2NLpWglBj1CTlPi6uN+rZpw251QCJqv0MSamMwk+piDF/P186poGibXbpevSYhU1a+RQ2EGzz+9IIJyBokjcL2gfAHDdOpjX1clrRAiv7cFCneA+jXSZADpwlOvKF2jCfS+YBvqSWkxZx3b20F5nQRHYo+0u/1A/WsAE2bhqQnYRoAPENBza3VTlmpyY+oh09jH+XWXs3hWXyyjJIXUG1fYE+T3TCOtaEwc60Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xxd4pDuQMQTbe3wajRQCtOORyTdekhjvyWLURZTgnKU=;
 b=JelU4UIaK2FM2KHpCnoCybAOyPuXY4rwUMjzY/p3Ju0EW2H+RSnNTdUljJ1+lwKn6I2aMbsDAoho/Cr/lmGKmTRE84/Xug8oJcUYzdltMETXPwvnDrgVExPcE3H1xswmj9YnqrrvRXWtoM319AZtyRoVDp1PNcRQNODyagRSk+Kwm6WJMImphBP+a3nygptB8Smnq3fQEgNGvS1jeSrh5Cdb1iavB+SXDe4pmrwrF/PuyEWreYYEBIJmlKmZmr1uoUW8BcfOG9gSsPijxG+0KlM25pfLfC/r3fCR3YK26ZP0JgRnmpXkOuIQGWH4rkJ9TOGY3NIF2x2WXTKvs4159g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5985.apcprd06.prod.outlook.com (2603:1096:101:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 09:34:01 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:34:01 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/19] cpufreq: tegra186: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 17:33:19 +0800
Message-Id: <20230712093322.37322-16-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 01e25c38-2bbb-4e3d-5c93-08db82bb2027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1KQf9C/pnrOcaSMLCTTi54ctYqJn/7yVdUzCbkrLBqrza1yFnZ67pPXey48Jqjf85tNuOcJE20VLkyfe/VM1JobcjLzWmV/zL1bAkNZ59yaNKFxK9b1VQBxegjXG4a4+Px5zzo15Hpxrc6uumaUlj/M7wG86QtrxkX8fXgLVMCKXkuWZCNJJXI3yr1RbmN7T0j95gT6SeVzzuyG60mCdoHg7EG7AitKW7G3Abbh5XQ83rqux7AzF3hCrn+inS7NWeZFjVwAR8zVtgw70SZ2NtQEePqdVbbg/Irl9WGtO8lLkYpGaqtsrptNozGcZbK4ShGmQ+Bw7wK2siRicTlcW49YyxVac8JAAoEqJebCDHKBWtXCZ1U52a6U2CpwHubuWYXOZed/O72InpLWXenMxrO/Sb1I8Nm6Wo4Kmbzx+cacj7ns1g5EqvkI0C8agHIkfHY9FZBIOgQ+xxi8w5WF85nvMcTRYHpUUJ2kP0jSK7W4EHbv7rCv94pMogYva/MDhyxSlcBmxQe8ABwIhRO6eCm9My/d6AvzSvvpLhjINBN0/yPHcq8YNQXDsQFSFDto8qFQVzNeWH/61iyGntoLYyNCr/rKM3xDJjialrRRmg0FkFdNGpm8O2vilxtP26DYV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(186003)(2616005)(110136005)(54906003)(38350700002)(38100700002)(5660300002)(8936002)(52116002)(6666004)(6486002)(86362001)(8676002)(478600001)(316002)(41300700001)(2906002)(4326008)(66476007)(66556008)(66946007)(6506007)(83380400001)(26005)(1076003)(6512007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2l6ZWdJdHNLUnFHK3N6QXdDVWdQM2w0WDhYTkNBTDJuZm9kUEZDdDM0SkE1?=
 =?utf-8?B?QnFtdVJGdHJwaHZyaGdPdHdGekFDOGFaQXNud2tzU3hjQTR2Qy9nLzh2NlFt?=
 =?utf-8?B?Rzd3UWZhQllXU3BaWXFITlhSY1YxaGVUMUdOS0tlQWRsTlBIUWp0Q1NzRnFo?=
 =?utf-8?B?cmlXOGNRR1ZoQmEyeUFLZ0hlQkdOS1lQSDdXRk95N3d1NkVCdWNqVDZ4WkNa?=
 =?utf-8?B?VnRUOWIzWVdTUjJaWk4vbmN1emRPOEltWEtYZGRTSjJUemIrRGlJMEo1QXFZ?=
 =?utf-8?B?T25OdDBQRXNPc2pJRUs1T2hoRXZ0R0JOTFJaaGFFOS82emxxZzc1KzNidWdV?=
 =?utf-8?B?dU9Pa2ZlZEF6VC93MnkwZ0tjSzIvaEZ3Ni91bzYwckRQUlVqeGxsM2U1UlZP?=
 =?utf-8?B?SVY1c292MTI1ZDVxNVh2T1lYeTdwaXVGaTZreWpUdkVuMGo1RXBtTzZUNXRr?=
 =?utf-8?B?cWZ1SlVsSStjY0k3VForTGE5TGwvNzRxazF4ek1NRVhudmY1RTVLQjJHLzNk?=
 =?utf-8?B?cXdIZGpPNEd4dkt4TWp3Ymp5eVlYcm00bkhqK0I2Wlp3M25DTXEyTm9HVk54?=
 =?utf-8?B?RExxOWgyUHZJWmpYNjV2OGx4d0FXZzZRWUVvWHlORzM5clNyRTRJVyswNi9K?=
 =?utf-8?B?QytnY1dQV1pqNVdpOHpHUW94dkVqOEthZVB2RVl4NFpYM1Fla3gyQ1poQUZQ?=
 =?utf-8?B?dkQvd3VXOVVIWWpFeHY5YnZOaWZvZHJvN1Zhb0lBWDBRcm1vZDhkR3Jzb2lB?=
 =?utf-8?B?S1JLd2FiWW11M2tQcWpsR0hjcWFxaHo3Z2xwN1Rxa3dFakZhWENPOXlpd2dX?=
 =?utf-8?B?R3YySnJUdkVHaUhCRUFZWlpvaERZbnBoMDNSdWxqVDV5SXFGdHBSUDdKbjY1?=
 =?utf-8?B?SmMyUWllR1lEeDBDb3VYaC9Id1IwRXhaYUpveldIcXFRK0htWm1nb3BjOTB1?=
 =?utf-8?B?VVhQSjhERDdVZXdFenNsTzlwclduNXAyZUpjSFk5djE3aEgzV0FheTF0Umkw?=
 =?utf-8?B?RWdYTUN0VTl0UzZZL1BMRUhzMGkzY2llVnNUL1Fnb3E4N2ptWHo5UnJEazhj?=
 =?utf-8?B?bVB6dXZOWElLcU5GSFhYa3lCZEUxQ3dYUHJETmlXVmRLWDR5emx4UExHaHlM?=
 =?utf-8?B?blU0cVhCdkNvUTgzVWkwVUJkOEs1WXlIRUJYZENzbmxMSk1YVVBvWkh1QTd1?=
 =?utf-8?B?cTRSV1N2TitHUStoVExaUXloRFk2SGhrZ0hSZ0g3Z0QrNDg5M1VibGIwdXNL?=
 =?utf-8?B?ZXMvOVhJL3ZpREdSelkrVFZISVVoOE1WZEVZTG94ci92MTdRTVZBb2JYeCtK?=
 =?utf-8?B?N3ZYZFcvbUxLMUQwM1dFbGZ4aTI4N2xZVEMxVE9rQzRiVTFQZGt3a25Ca3Qx?=
 =?utf-8?B?bzZYbWV6eENUbjNlcVRvNVF4Y0VnUlJNMDM3b3FTMTR3RE9LTXNLSHV5VXpF?=
 =?utf-8?B?Qkx2aEdybE1ST1lFNjNIUWZkeHNaSWFEdGVLQzFMNFc0TzN4QU9zOGxNaXdo?=
 =?utf-8?B?WElKWkd0Z1FwVlhQV2RKaXd5cyt3YkVMK2creldQUmRLNmdENFlObEFmZUw4?=
 =?utf-8?B?VDhUajB6T05rclVVd3NFYnc2bmdqZGtNTWVpUlpzaUV1Z2xzbEpWQUpTandp?=
 =?utf-8?B?WlJpT1VjVFVWVUlRTHRNbzA5Q1kxYUcwQTFOTXo2MmVvWkVXNDhCcFVEODdw?=
 =?utf-8?B?ei8ybDMrUzcrbG8wK1Y3UTRkTmU2ZGtmYXFmMThheXJKd1BsVXo2UlFjbmsz?=
 =?utf-8?B?K2hZVG81UFIzb2VxbkVJVDJDM0FyNXpPZkkxMjdDWmVxbzhlOVYzNnZHU0Zr?=
 =?utf-8?B?ZUZZUVpXLzBjMSt6cllKcHhlU3JsR1NIbkdRYzZKWXNpTzVXVnRZUmFUOEdU?=
 =?utf-8?B?aFFyME1RQm5xcHBac1g3TmZ2dUlzNUtiQ1FjSVhnZUVYMEhydDlmSUV3Nngz?=
 =?utf-8?B?WlR6M2ZSeXZjVEVBR0VjQVVUcHZ3S2FqVjN2SUd3N1FKU1NEdFBCL0N6YjNk?=
 =?utf-8?B?SjUrSE9oamVEaVU4YmVtVmt2amkzS2hxZmU1cGtoVVhnaHBHejFVSjdxUElY?=
 =?utf-8?B?dnFxZTlTQkI5bjJuZHJITlNNeVM0bnhnS1pPOVNSYjVLQ2wwdWFQWmhPaDdy?=
 =?utf-8?Q?mySptyps+5+OHW5DM5snb7V0/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e25c38-2bbb-4e3d-5c93-08db82bb2027
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:34:01.4646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKVUeC6+7XJkbTCA5KIsiU0tds/yuWWXxNhn190hM+7TPKW6kSKpy//ONQE9tdoS9Mc7wVyI0UDAGS19MoilWA==
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
 drivers/cpufreq/tegra186-cpufreq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index f98f53bf1011..7b8fcfa55038 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -259,11 +259,9 @@ static int tegra186_cpufreq_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int tegra186_cpufreq_remove(struct platform_device *pdev)
+static void tegra186_cpufreq_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&tegra186_cpufreq_driver);
-
-	return 0;
 }
 
 static const struct of_device_id tegra186_cpufreq_of_match[] = {
@@ -278,7 +276,7 @@ static struct platform_driver tegra186_cpufreq_platform_driver = {
 		.of_match_table = tegra186_cpufreq_of_match,
 	},
 	.probe = tegra186_cpufreq_probe,
-	.remove = tegra186_cpufreq_remove,
+	.remove_new = tegra186_cpufreq_remove,
 };
 module_platform_driver(tegra186_cpufreq_platform_driver);
 
-- 
2.39.0

