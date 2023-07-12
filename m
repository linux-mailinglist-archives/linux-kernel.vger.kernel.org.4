Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDAC75034A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjGLJf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbjGLJe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:34:59 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2108.outbound.protection.outlook.com [40.107.117.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4622696;
        Wed, 12 Jul 2023 02:34:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrMXjhXcil7C3v4SXfnucCjud/uu5FaHrWwdUBmPJT+uUtnIph8VR3d5dnf+qPT3Qe1vrc2LrJeAozPBJ5HbMdqC+pvAVmO1nNkGOlp3dd/XWubWkLOUD7wbLQeIkXfGGAew80xoqt8oMi5F007SGyVqO1B2qgG7Y01/8HfehKZos4a5Z3qRF0s+jZr5XK7CbjYX+7JaNqvGEQbQPZDkoprD6xwMW4IyvX5PXxIsygd7/xENSgzqoD6ezewI8Hf94lELHhT6JLKJyzmAFAl0/OSM+FBScNcUtzir2v2Af5MvKiAeFGBXHAUFNMiRECH3k78EpDSSiFjhjCSywFUpFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmQ8MC0mbCrOml3uTJQxFN+QTq/ImG3z2bCvVVacQOU=;
 b=BcAinG0pqw9Gfsn4FijbNhFTDQ8zZ5gPF5pzKk04vs/7sykBaMbJZCvdplfMM3Re+wjTRKcps2+3kNfnZTxyv9Xgnmt704GurBbF7aHAw1KsbZ4/O0BJPYAXHy7VpRLJcZOcxue2uDh1WQcE3NfFLWT9GAYXdMz+gjmGjVl1iDkxov4m8bu/2B+7TMvt3KsNlkeQaLQ3scr+y1t22JYMqZpnEH7EXZGuKufQgCc5XpZnFHEioDJryrwJNyx+G4h+AYt96Yt0FnsI6XhzPCjKah6ImqwprzfFBv+XPIAN+WTffGol1oPZhHl2DpgnBmqFzp1G8uRT92+qoPJFIOYCFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmQ8MC0mbCrOml3uTJQxFN+QTq/ImG3z2bCvVVacQOU=;
 b=VJpBuRO68NCeTml2L0CwzqNMCU4KLGL9BQFzsOAKWQIrQ+JKNziEjqi7H/t5CCa8KLVi+re4BlIgfYomK7XgmAl9lsabysxnEiYjTlkp7FMz1Q4q/u+3+RGTq4yegn6x+/KPABQCOj+oKPrxxrGO+eOybRfpO5giHDkWwGM3foIuAy4qVJ/L209oYoLi5qgKQ9TJK8CTts7CDtMRdGhBdNZ584DmmxSq6dx8u4UBURQ/on9gWDBydTdJc3QX04CmIBpCckrdRCEafQHHWi9tv8RdPQE018mgu0szbaR2tGpElHtqH7bJgZ7wtbslIuDl7KCe7cPTL4XnIElvoQKlGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5985.apcprd06.prod.outlook.com (2603:1096:101:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 09:33:57 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:33:57 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/19] cpufreq: kirkwood: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 17:33:17 +0800
Message-Id: <20230712093322.37322-14-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 42c75e9e-f718-4562-0862-08db82bb1df0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bBmfekcvJwCsqrzNJsdEgfGVkIWigQ2CChUEPsggAvQy0e1fPlOGouGTnloTpXt8LezRFyVE3ltlarUXGzeXe74HgZy1v5j7XTxoOsKN1C7AF6uWv/LSgQvTgEKVaKNXD1SEbbzANVBkohM/FcBl7/26X/5gmYxUHeyXJpCY2mXd4Bcx2zfRxzrTfGi4ou6mACpBRWNTcxdBdU6c5T1hzfFEysRTGAn2Mp1tA48DB7G4BvJS9SMltC0NY166qnfXdiDI/71wRrKodHzlC4qjpDxc1X706zrK/cSO35lZfrTa2yNbZeCBB0CGpLb+uwSvhl9hfhHJj4euEQm/yLqAELbmMPXPnDkoAF1tV9kcVCkg0wisCk+cyGGT8xxdnLFvwUqF+p24VtI8z64h3mnKaXn+vqAD8dwbeeQwn+HWq6gpoE0owRX8j9yYM6ObBVYbh/n2tUlL/Fx8rZqmUELEUKm4mH0nSmMEOBVycAFnG2XRqh52jxx8oh/4HIZWRBi8uVyuNFwoqBI4/aHdZN14TAwHMrYqT6x5xPL9nd/8/4CCL40R107ASpkEEgmosxgLdr1VcT3lyKey8zBGNxWS64XttBTGE1GQcAYeXDU6YSM1h2Xe92pkgT96d/yXTy0W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(186003)(2616005)(110136005)(54906003)(38350700002)(38100700002)(5660300002)(8936002)(52116002)(6666004)(6486002)(86362001)(8676002)(478600001)(316002)(41300700001)(2906002)(4326008)(66476007)(66556008)(66946007)(6506007)(83380400001)(26005)(1076003)(6512007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU9rZDZONTNlQ3FmWGZZS2g3SG9DYytnNDhrV3o5eHd1K0hkY1EyWk9ER2pI?=
 =?utf-8?B?SjFzTlB5dFJFdklPOVR5QnlKcFVUN0hlR0FTYVZMcCtZa0Y3QjB6MjYyMkdJ?=
 =?utf-8?B?cmpyVCszSGpIVzZRU2tRYzhPcXBPTHN3WmV5U1RGRUdxUjZYTHphVzhoZ1Rs?=
 =?utf-8?B?K1VXanVmanJjMldzMU1IKy9UYXAybzI2RXUwMVNGSGlKSFNYU1k5OThTa0ZC?=
 =?utf-8?B?bzJtNjhJTzhHQjRiZnhhRXpQdXRNWmtuMTlrOUZJMXZEZkI1Q3BvOG1SVy81?=
 =?utf-8?B?WDR5R3hQQytGeUJJSzR4MmRpTmlkcFlHbS9aTFlHdlFKQ0lMQ3hsYmNOaXpB?=
 =?utf-8?B?ekFSTnlqeWpFY0N0NDZ0ZktxWmtBRUpaRHNMTk9OVUpiTWFsUE9nOGxJSm04?=
 =?utf-8?B?N3Y5Ym1udnJ4VWFSWXEyYnZsa2lQM3hKeUc3bnVWbHpmUktuOHYzY0dpTVVu?=
 =?utf-8?B?cUxYYUtrNS9JRmowNXFOVFdtTFhQc3NQdXBSSmlJMFc1dXlLTnFyNUorbEpi?=
 =?utf-8?B?NlRxUSt4MzdCL2duY1VMazl0bGtacHBMMW9rUm9zc1diTGl0bzd4Q2hlUnZN?=
 =?utf-8?B?bVJOVGR0OXpZcytBZDdqSzhJcmdvTHdHT2diOGUybi91bkpXK0FoeVpEc0xw?=
 =?utf-8?B?MElFcTNwNWRKTlRMVVpkWW9TempQQkRmUUQ5NWVyT2cxdFZlcXlhdUpSQjJ5?=
 =?utf-8?B?OTJzRDJxRGhYYzMzcUd0UVh0ZE0yeE5IeUNEOHFNdzRqdDRhOTRxNHNaUlZ4?=
 =?utf-8?B?VDV6dHJFYnl0SUhZQnovb1NsR2g3cWV3cWpETFhRMmVYazFHeFo0T2x1V2FK?=
 =?utf-8?B?ZnJ6Nk9vZEgrSUlnWkZDVGpvVlNpVXRZRjBGVVRsNytsU3hTcW9BUjFVL0NV?=
 =?utf-8?B?bisyQ29ielYyMzRTbWlQUTlMMys3amhxYUN1T3c2VkJOei9LN1c0WTlNWHhT?=
 =?utf-8?B?c2lGTzhHenNkVXMvQ01pNjZabk5haEpoeHBwajg5Nk9aMDFIZzNVR2dOd0hK?=
 =?utf-8?B?WXFjTU9jcDIxbGFtMTRhMnFHMFl5YWpCZ2tldTlTN0ptOW9ZN3N6OVBjckN4?=
 =?utf-8?B?VWtJQitKeE5zWlM5SFljWXlIYTVFdnF2RWIzVUpBelArT2llTHlsL1EwR3Er?=
 =?utf-8?B?SEhDM1I5akVIS0h4REJwYzFtY1N1R1VuQktXS2FVclB2NDdNRFNSZVdFZWR1?=
 =?utf-8?B?NUpPVFR4MlJlZFpiSUMxcVBQNkpBSHZuRzQ3RDZGdmx1dkNLenZncDRzVlI2?=
 =?utf-8?B?c29xcld3UFpsMDU0K0p2MUxJSEd0cTlQWE1nOHljQUh2eXdSaTcwY2hvQUk4?=
 =?utf-8?B?MVhqL2VTZ1EzWUNHZk12ODhmcUJqUTVGdS80bGZmaGdWSHZRRk1IR3M1S3E5?=
 =?utf-8?B?QlVxSE9pOHhjK21mRHVoNUlvOEFkMjBDc3FVMXBlNFBOOG5Cd2tERERaTXF5?=
 =?utf-8?B?VytmR2hncURTL3RnTnpQSnAwMXBVYzk1WVYxUmlheHVlVUVhNUdkMGhYbGl1?=
 =?utf-8?B?aVpmellabzVOWWlNemJaUUFFcUZmalYwY1JVSzkvRDRZL0ZVWFdWZWVwTjJO?=
 =?utf-8?B?L2hHRkZpd1ZBM2l0R200SGVhay9WeVFxYUd5aDBGcW5pVWZsSXkvZlVkNGZN?=
 =?utf-8?B?dHJQR2praGpkbnVCU2kxM0FPU1lqaWlFRmVvMmJzd3YzNDFqKzlPZUZLWk9I?=
 =?utf-8?B?dXdTZzFsR3V0ZXVPMnVLdXNqWVVobEJTSW5BR25rTmkzemtHbFF0bDQzc2Y2?=
 =?utf-8?B?RzI3SW5TaFhJZWkzT0hyRHk5MGE4d3RKTThSVC9GcEloeVFUejg2dndwWVg0?=
 =?utf-8?B?MWY5MzgzeWhDc1NwWXZQeEZqOFZOVlBMM1JYczJoNUVsd0MyZkMyZ3JtS1d3?=
 =?utf-8?B?YzVzeFNmcE1IcnVBY1RPejNBZDVCWEtUMDlONWd5TWl4VlJYMkNYSEhaNUJG?=
 =?utf-8?B?MTd1Tldab3BLYzBjZmFzYzJlVUxpRjBTVlRKMlF4Rlc4dEhKQ3hQWVVIYTFx?=
 =?utf-8?B?NFhoZmlnUUV1cU5jLzhMWkRHbWREYWVXdDlOc0NOY2JqcitIaG85TFZmc0xN?=
 =?utf-8?B?a01idE9TNDdKTnRHaWhBWmpkTVc4MUFBeGdib295N1JkOFZFTnVwUlRLakQy?=
 =?utf-8?Q?gdx/hAZuqzl7iksddZWf3vVIQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c75e9e-f718-4562-0862-08db82bb1df0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:33:57.7150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVEGLaavN1MXwyiFUEJVXqI9ZkftbJj+CwqE3WkMBYfRBOJW6+b4WNc38B+i++/I/Ma9cbwrxNq3bACAp9yc3Q==
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
 drivers/cpufreq/kirkwood-cpufreq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
index 95588101efbd..fd20b986d1f2 100644
--- a/drivers/cpufreq/kirkwood-cpufreq.c
+++ b/drivers/cpufreq/kirkwood-cpufreq.c
@@ -178,20 +178,18 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int kirkwood_cpufreq_remove(struct platform_device *pdev)
+static void kirkwood_cpufreq_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&kirkwood_cpufreq_driver);
 
 	clk_disable_unprepare(priv.powersave_clk);
 	clk_disable_unprepare(priv.ddr_clk);
 	clk_disable_unprepare(priv.cpu_clk);
-
-	return 0;
 }
 
 static struct platform_driver kirkwood_cpufreq_platform_driver = {
 	.probe = kirkwood_cpufreq_probe,
-	.remove = kirkwood_cpufreq_remove,
+	.remove_new = kirkwood_cpufreq_remove,
 	.driver = {
 		.name = "kirkwood-cpufreq",
 	},
-- 
2.39.0

