Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3F7750348
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjGLJfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjGLJew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:34:52 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2105.outbound.protection.outlook.com [40.107.215.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E777C1739;
        Wed, 12 Jul 2023 02:34:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeDFJhfu1rwGChvtBj5KlLTtH0cvO15KzwOvc6u+Chgfo0lqmxTgPaoEoDeKfU21nd4i6bf2rP+HW2PvS92PaEN17Ol+uNjbw7r5TXFoTrfGDAmuy18WvmzHFaBXTQ0/OXa5RuJlUK87Tf2LmnmUPNFU/p8eUGA+T5b1epweuu5AnUUiYRz2RCIi3jbg852TzC3sRtOvX+uniXZlWD98NM16qdJ2AsYnpy9Ifo5+/Q8GMM3p/4gURiM44DbBDPzDRh/yRWbbgysfYL6DKrlxJ10rmGrZaFkMsiXTdHfRrOmegTUaGDM3xNjn7vi/sO9JxDG7JOpSmJeJGQyERdYORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzVbD8vpWGYcyP7wC5u0fG3SruaXhfw/VzRr4XIqwA4=;
 b=bEG6gTPM8ggnVECK33LiDG+ZWy/C2JG+NakTN3ZCD4C3mOW7T3H3L5yGHl9ZpB3kcPNb7+HLh5MFdOqwZ37ecHGLLlqzFH23tjDOUt6gFmKiIpTwQ584bGn3f8HGPW7TSc2AdImPHsYfDnMUyb2+hyiY4l+Sdy4gxt6FHbv2ApW23GYd8H/WsDoLeh1V9H9x2nohQLhwUMJeLZhaN2jTKLCelOsk9ps6SprJ1XpupwZr25PsOzM3qcAEsYB4K9mgUOWk47tmJ/FXOnL43FEjW6eGYKMFtvjrnvF1iq4YOh1kd5yq74lqaIO7fhqfsBFOTOJgxnJqxw3xi8sS9/yfxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzVbD8vpWGYcyP7wC5u0fG3SruaXhfw/VzRr4XIqwA4=;
 b=QkMeTfabHCg0orf7VvbeQwU/KtChKvbgyq/mhWxYnTyDXic/9ndaHYUGe0mn8Y8uNztltJw0OUsmtSooGe7CpmQsAMS8Svzrq3r8xhmpnjx+KLNQgr1XrB98mwonXdbWBLm8FRwgEsxfhSAeBTU98iY2ofSIXcFDI9VHnFbydGuuhMlJgkyvjNryxoGaDZgLp7X2KJV72ndRG+LMbDUdPyeoQ+cB4D5ioIjgKZzest7KPzMUmAttDKIDvRWqO+j8IsRzLwKfOz5xNhLt+FcVZ4+if6Krcc/HNsaU+FCuMzkb3UTp9gK6ch0QWkkROlwmxbEvZwvmtm5VTa1rWaAqUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4091.apcprd06.prod.outlook.com (2603:1096:4:f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 09:34:04 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:34:04 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/19] cpufreq: qoriq: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 17:33:21 +0800
Message-Id: <20230712093322.37322-18-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: 42dc6710-9b72-484c-bc91-08db82bb21e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yXrkZ8wcSkWAPriimk6/T2ZXK2A6DyZnpwa0BMlrE7ncbGGeWeGLynbhgPzyUxfbvWzAtx1cn9eavSGO+sVi8pYtdZRNUndm2d7ROX3SwblHpM7ElzZRK2PigqmzfzeHkhr0QmP0j+3bBQ/ObRSLDuXvJOqCLZLeOX8EzwQGiapYywB8cSKojFnfj+4bfoNZ+eBzuNjhaycv4qqPGx5GeCBaAxvq2XilYW2iX419Zk9Fbv+9YeV3cR9x7swcnIwdkMs1oO+p74MwgMcqupjbwHlTJqVLedn/S5cXrQ7g1vz1OKDoHBLBY8asXc4vLR7WjS3TVuohJV6weQHyfz/a2o+CK2TaKs4BpIUd22S1r5bcZKNv3PDjpwQq0eu4lQoEJv7oTeA9GMolxI0w/SN4aejyB5kDkzdLDsCbQxAUd/uhS484ykt3HJh/nLEqES81Hmn0NlFftyJZPCsLmT1hTW/ItaLLcQDnVzpghAkGJaSn3WQvi5CRLYpxId3NjyNXPCm0ER5l5KQMhvwmqQj48FqS6N8CBrmaf/Iw/C0ljaHsGSyQMnqXgWC6g46SymAnLsioFeb/PSeWVhIu4Lm92ZFedn6Wp82FCZj5E2R5Ju0kwI8NhMKuCdNK/yktB5UM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199021)(2906002)(6512007)(38100700002)(38350700002)(83380400001)(2616005)(186003)(26005)(1076003)(86362001)(6506007)(5660300002)(8676002)(36756003)(8936002)(110136005)(54906003)(6486002)(6666004)(52116002)(478600001)(66556008)(66946007)(41300700001)(66476007)(316002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGpiVVB4bWlCeVhxOUxoTzZ4UFlJMytYK2Y1NnV3Rk1NUDNEd1dqSzgza1dy?=
 =?utf-8?B?RmtabDY3eXF6Nk5senVIUHhsZ0F1M01ITjJoTzRjTlpkWXh6dkRMY3grbHBu?=
 =?utf-8?B?NHZ3UkVvYmtBaW4vWmJOcm42Ri9SMkxRd041aVVCSnZQL3B4T3lXSCtrbWNk?=
 =?utf-8?B?T1ovT3A0c2hlb3QvUmFDc2J4Y3doWUMrdjc0WHpleGtLOUw0QkdTTGsyaVor?=
 =?utf-8?B?MmdCcmtVVVpXb1ZLRFg0UGh0NTB5ZFhybEFrYzhMQ2tqUTdIMW1tWDgwNXVh?=
 =?utf-8?B?cXY2cHdPd2NiaDlGckZFM2J6WFR1RXVXcUJkc0h0c0NOWG4xN2NYM1ErMlBv?=
 =?utf-8?B?RnlEMmVzWHV0ZHJMYklVMVRTekZkWmd0eHFJQ1Yybm56YWgzc2V0VUU5cjRy?=
 =?utf-8?B?REV2SFB3YWhVR0FjKytDcVpJbFdaQnVSSnR3cXQwYzBkeHN1amtNVUZHV1hN?=
 =?utf-8?B?bDl1R21pMHVRK3ZLSkVua2VkMWNwQ1RYWWRvRnYrNUFQNXFxdFc3Z0NGZmlB?=
 =?utf-8?B?eEJTWFljWXcrNnVzL04yckVDcllVVy9BSG5VczgxbU5wbFMwcjc1WklHSGtq?=
 =?utf-8?B?UXV3dXlrQ0pSRkF1U1c2L29xcUFVY1kwSy9PeVppT01mdFFDK0RhdjdoUCtx?=
 =?utf-8?B?ME9BREdsVk1kZkp6WWhlMktNQjJweFp4cUZ4NDgvQjhLaXVudnF0QlRLNCtD?=
 =?utf-8?B?K2RqbVJheWZ5c0J1OTlJZGdiZmtLSU1tTmpPemdSTmRaK2FlRHVXQkxrVCsx?=
 =?utf-8?B?NkFTSmJTbUJZT0xIVHMwV21BWUFnZFdtaG1jQ0laQ1M0RXdlZVJ2cjI2djA4?=
 =?utf-8?B?c21jVG9JYmduSnBCa3BmY05OaWdyRjhIODd3M1NPYXozWHFFd1IwY01keWZa?=
 =?utf-8?B?Wi9ZTG5wbnNIR0J6SnNJTzNZM2VNbUJRbnR5NlpDT1ZYYzgyZW9YbzJMWUZz?=
 =?utf-8?B?WU5hWWtaNXAxYzRUVittU3NaeXA0OHJ2NGtyWkVSRXFmcFQ3YUsrN1ZWZ2Vp?=
 =?utf-8?B?aDNoUExKcEpIWitWQVptdFJCRHF0U3BKU2NRTnFxc2dLbFgxOTBnb0FvSmdE?=
 =?utf-8?B?QkFGM0hnSXdIdjZCbXBuanl5MFBROVUxZTBWVmRaYnREUjZPMGdhd0d5NzJX?=
 =?utf-8?B?NEdUZGg2elBEdTlxSU9wdjJFU0V2ZzRLYVo0SjBuOG9DN2NGZU4xVlpPOWNs?=
 =?utf-8?B?aWR6S1ZzaW5FdEsxczBVRHQ2dU94UjVieitTTy8xUURabHRZWlRhdDFLVHM2?=
 =?utf-8?B?V3RCMjlxUmlIYUtTRWdNNEZhZDZWQ3d4endPSWJhbTVKU0pDV1greHNWS0N4?=
 =?utf-8?B?cWlKSFJxeEFmZGdFbzBPa2g0SndNOUsrT2dTMzRRRG1VSUdTYzJoODdac0hH?=
 =?utf-8?B?WHJtOXJXWEo4aUhnVjZyak5TallVejNOQlZBd0FaZ3dLUnRTTzJWblRRMkg1?=
 =?utf-8?B?WDJIM0VUZVpVWnBSYjcyeCtzVTlRSXRuZy9BWjk4SDl0QUZJMkJnbWJKZVcy?=
 =?utf-8?B?Y2x2Qml2b0pNcE54eUJuS1R2TXZyT3hZNTk4akhPQ2FGbGM5czNQM3dpNi9q?=
 =?utf-8?B?bTZ5SUhJUUtBR096Rk9VWUEyRVlHWGYrTXBhWjU4ZzUzYUdqSW5SVHRMOWFU?=
 =?utf-8?B?T1E2dDBJdG5GODB0a0lQN1B4UWszOXZPOU9icmwxd21TS285bzYvOTM5ckgr?=
 =?utf-8?B?dE9leGcxWkFBODdtc3E3ZUw2SXBYcHFJb2dYTlZrZEVOMlBabnVsUlBxY1px?=
 =?utf-8?B?Ty94OTYyUm0zaHJtVGd6cEYwZWNNQ0hxQjJ6SEtxZ0FrcVZkVlJ6TUdlc3Zu?=
 =?utf-8?B?azIzaWs4dDMraDBZbmdHN1dFYll3TkhEUnNidFJvalNSZFNPS1RrSzlmWjRX?=
 =?utf-8?B?alFTc2FVeHJSV0xIYnhwNCtCQ0g5UVFIcUpsVkFCWUlQL3RYMzZidXFhRnVB?=
 =?utf-8?B?VjdhQ1ZCbTU1eitIQkEydE5hMll2V3lIVGVhaC80QWRPWnVKNE1TN0NSSnlI?=
 =?utf-8?B?cEo3dGt5VUZLQ0w0NDRtdWVydytPQWkzV0E1RStMbTRENEdKNWt4aU1pazZ5?=
 =?utf-8?B?Z0NuME1JbzBvNEZ3VWZ4SitkUENjUXFHT2w0WFlnSHFMY2Z1RUg5T2FYOTZy?=
 =?utf-8?Q?yCWoQ2ORoRYblYjxt6O9+LE4v?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42dc6710-9b72-484c-bc91-08db82bb21e2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:34:04.3592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DqRqYoHmT+YwW/3C9s6slLChYDfMPtGvYcYPQ4do7jJNvsjIUZcMqCeEaOp/Lm+etROUr3HJ/01PKO3XhRdKwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4091
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
 drivers/cpufreq/qoriq-cpufreq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 573b417e1483..0aecaecbb0e6 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -288,11 +288,9 @@ static int qoriq_cpufreq_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int qoriq_cpufreq_remove(struct platform_device *pdev)
+static void qoriq_cpufreq_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&qoriq_cpufreq_driver);
-
-	return 0;
 }
 
 static struct platform_driver qoriq_cpufreq_platform_driver = {
@@ -300,7 +298,7 @@ static struct platform_driver qoriq_cpufreq_platform_driver = {
 		.name = "qoriq-cpufreq",
 	},
 	.probe = qoriq_cpufreq_probe,
-	.remove = qoriq_cpufreq_remove,
+	.remove_new = qoriq_cpufreq_remove,
 };
 module_platform_driver(qoriq_cpufreq_platform_driver);
 
-- 
2.39.0

