Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788A775011C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjGLISp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjGLIRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:17:49 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2136.outbound.protection.outlook.com [40.107.215.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF95F199E;
        Wed, 12 Jul 2023 01:15:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mx4hHhtlc6bhCQ3wWg4n5DefZS/ftOFU2OOtwpuYP0/p4QuRM5vRLED7wbvJK18spCcLlFIPPyLm6RLK9PWA2pMOhgURtbyvUBA6hv5P89gbdYepmHoCk1Y4qkChhjAD427uyAzZir8y09DOJtxxesDXPTZGDeaNwXXxUrKq+4ne2Trp98wdgtCxz1J1JjLUBzuqedM5zUh1HDScj+EiKnygY0sc3GbZwDQf2ncL2tWrV0dcG0Kbz9U2N/JWprmKgCuotEZ7p5jRPEAvGHBwpKoiV/dy9Ksk8APgCXxecvtt833pt7Jxw6jnDuiEa7dRoqpp0Jr2+TuMptwGmpIgiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBLuBcb0aq39A6ve1LIP7jQ8bQkSgTkbFQP14gLD+wI=;
 b=F3KzNhxcOtBot1LuvQ4l/xNx3hG11pc+GQYh6u1R5U/afIl1bqAn22EFJYlNox7g4guSDmazxd+VXeI3eSIQ0DaJtydg4wdrA2/o0GF5c4+XuHnMXQwhC7ufenK4lzG6s6XRKzzGNqTgBloRjnoJ/JywHiR+nfN0KfgHBoYJBwFgH1FBjlzQZh2JlvYRQTLlymg0d9/Mlwhe2JAffScIWuA+b2XkgOpccsKDpyVzwlEMCtB9FZN8/qGd8FQ+/5L5WYclkQ4FP1qYAbi/sjXZk208SA1SJSIQeXbxnR0NX6LNp+DRmLgnOS+tdok38psZbQZYdr8lanDdijohUWR0Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBLuBcb0aq39A6ve1LIP7jQ8bQkSgTkbFQP14gLD+wI=;
 b=grsi3s4ag5toBee1dlLxCSdXtTk9Y0E/JFbTwlxBdg+9sfTi1vXqn+ZrVc4wQkHR0eOoi/qsFFbXvG2jB1hvbY2rubM58rineMAihBexCuvKPVWASbLqlXW+4LrNmFl5VUv72ZjkYdpL1E1NZnDan1RMXxoT/bkDAmNUxW/uRrOTN1ZVd4nUwt4Hp4kcQZjGf5BvKAll/SuXtI9O3Po+9lvDXA1RmUXid6xcrb4yvqvyAFu3/JBTqcAfFI3CGol8DMJGHhO8lsJxA8s5YGx3wXr3tmCyPqYu8gZRZPjXKU7gS8dwlRAvG9XuCzEnoefsbMcMKxmyQ8uJJKczIpq6Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5027.apcprd06.prod.outlook.com (2603:1096:400:1c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 08:14:42 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:14:42 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 27/27] thermal: intel: int340x: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 16:12:58 +0800
Message-Id: <20230712081258.29254-27-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230712081258.29254-1-frank.li@vivo.com>
References: <20230712081258.29254-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0208.apcprd04.prod.outlook.com
 (2603:1096:4:187::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c1ca3e-1730-4d64-ade1-08db82b00baa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSflBvgUqDicdwOHHHTxmfMaHzRvUZoj9hEnlzae/pOqp3AaVu5scP537QJkOz7L8VmCPxXmjWdJW6dWKbsZycLVeViOuj+TP6s3LTmEpWJ3Ak3G/4f1mJFc/2cP3aRkLzRfcBMUBBIL0nnNyQAxQ+UBQ0PHaRW/qThIdXM0u3zTqmok/2CGX5E4Pot5Rp8x/iWwFW2PJZ43RuTHA5UVdrskQyCx6FGfUGzXi/TAXlXcEs2Wt/TsPlQReCQoQt9txcB5JHRpJamETtdQ4kuNKwkm3demiAKEcM42rP/3wPrh3sKQx5FDHc3axZsztLQQhsuqhRPjFw70yK8CgihaZSLANpGhubG/nc1XTg3I9RJr5bygkwNoKnx8N+BzdL4vtTHBs29dsqbRASdONylRl/keTDdHvi+wdrS6YIASnKvvyAOVFrCeMDiwHS27Ppa25fi02e4zF2odtgcj5Boi2vBlh5H8JlkCsNQyY6KnL5yZqCIQ1lLPWaCH577chv5rtMNtan8pKLmKc+M70GjTl11EzguDCXYxVN5/X5sb4Ktfq2FnDW9ZX3/AFVgEOFl80leEoLZTSNpuTKzEclNYru2a6KQXqO+TPjZ2ouNmDvGKq/d5YB6cgOTuW1f4gTDp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39850400004)(366004)(376002)(136003)(346002)(451199021)(66556008)(66946007)(66476007)(4326008)(478600001)(36756003)(110136005)(54906003)(86362001)(26005)(186003)(1076003)(6506007)(6666004)(6512007)(6486002)(52116002)(83380400001)(66574015)(38350700002)(38100700002)(2616005)(41300700001)(8676002)(8936002)(5660300002)(316002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWFIL1RqNkprbjNjNlpvcDJ3T1hHYnFSVDBqSEFEY050Sk5GelRJY0U1RnUv?=
 =?utf-8?B?VHl0cnprYlZPb2l4K0V5SHd0NGZPNFNGcWY2WWZuNk9LM0hxTFlyUFVaT1Ey?=
 =?utf-8?B?dUtscTNBNUxSc0hIQktMc0htaHZlcW5wd3ZPUjlrVksxUCtqTmdBWEhwSDZD?=
 =?utf-8?B?aW5FdEZkUXZsVXpmT1hoRFIvaUxQQ2RaWUtXSURKOFRMV0JsR05aTVJmK2kr?=
 =?utf-8?B?S0VORXVXdldrR3ZOL0V3bkVOc1pJWlRaMkRuQ1RwMjNwQlRIdXI2VE5xYUxX?=
 =?utf-8?B?Q1BKNDhvaWQxVDc1V3FzZWtPQWFrdStKbHI3RklFZ2tXM0M5SkczV2pjU0ZU?=
 =?utf-8?B?S2l0b0grMUg3U0hhVnZvWnhaL0J4VGswR2ZyaTh0KzViN2c4SnVYeEhiS0Fv?=
 =?utf-8?B?Ym1HbVFtOFpYS2RLVHk5aE5pdGdjSDZwaGFRMVlxbWQrZ1B0SzlDMFB1RjVQ?=
 =?utf-8?B?Z0xZd0xsaWxQZ2Y1NWZ0Tkliczd0OUpXdUNmQW5FSTM0OVhwdUt5QTk1d3RP?=
 =?utf-8?B?dDhLTHBYandpVFJvQ3BHZS84eWxGNWNoNFQ2SWYxWXBZT1FrZkFEWGZUcTcv?=
 =?utf-8?B?QzdIRXpTVXY2Qnhxc1JuQ1cwdEMzd0RzckxIR1QvWXNML0J4alR2RzRuN2Ew?=
 =?utf-8?B?SmhZdncyQVZlQTdiUldtQ1RRY0F6a1pkWXNadnliTE0yYWxWa2tQc2dhZUVw?=
 =?utf-8?B?aXArajY1Ti91cEhFZG1UTG0reWphUWdxOU4xSlNwYXRmMVFDa2VTWm9lNkd1?=
 =?utf-8?B?b2NVK3g3U3BKRXVwWWVYV0xsUnFWb3o5N0FCNm9KTkRpbzQzM1cvbFNQZXEz?=
 =?utf-8?B?TXlQMDZHWGpLRGFvQzZPeTZGNmNHbEJGekt4RWNMYVJrVXg4aUtGN0g4alN0?=
 =?utf-8?B?OFpXb2tacVFQR3ViVDJNa3l1RmhJaHZYeXdLei9RNnhRazNYaE15MzNXN0J1?=
 =?utf-8?B?T05QRTZUSDZDckMvNjNEMllaU2xTd2JERW94RHhsaVNZTVJUNTA5S2RVYXNS?=
 =?utf-8?B?cHk2L2l5Y0ZtMUJROFVReTZ2OWxOcDUxNVM2d09yZE1zS1dpNDdVNG5Fdno2?=
 =?utf-8?B?czJ5MXdvQmRsY0hpalhSc2tDU2d2MDBpek9TMUpkckh3WVI0WEw0RnM2alM4?=
 =?utf-8?B?RnJ0ZjhtT0tVekdlbUQzYUtqQmdFbXIxREUrbE93bDFNdFpxS0pUOG1wVy9V?=
 =?utf-8?B?Snh1bHRRNUg2ZWdEUTBYVE8vcEhQcGV4RzFvcXNlZGMzVmlpNU4rN1hSazZY?=
 =?utf-8?B?dGcxNGN4R1orM3VTRXNaNmVxUVZocGh5czlyMTVlWUcxc3Z5aEpBdTRLU3BQ?=
 =?utf-8?B?TmFyOEN1MGc0K1ZZaU0xcmZZV0FPWXdNNmJCVTJuTWQ1WE55RWJzTG10dlZ3?=
 =?utf-8?B?WXllNnc4V0xKaGxJSDBaUVhOaUROTTRjUUIwVW1tU2J1M1VoOWt2UmFPNERz?=
 =?utf-8?B?Q2trak8rYTdieXZmUU1YdUpDc3pwWTVta050dkhoL2lHaU93NE96ZHE3N2Jx?=
 =?utf-8?B?Q0tvaEtpL09STWl5MmJoRHk3VWpMbzF1c1g2VEhyVVNiUzdzazU4czhPb092?=
 =?utf-8?B?Vk5JNEk0dDQ2YmRGN3g2MUN1VXdnN0IrWGptcVlUOExsQ1FXMFJsMk1UaXBk?=
 =?utf-8?B?bVZ4WlNkdXF1R2poWmQvT3JVS0RMQ1RwdnZoaHpHb1BYcDZjQWVEeFF1cG14?=
 =?utf-8?B?L1ZrcUxrUmZkcjVrY0RFNEx4QVlzWU1SNks5SGFwSHUvbWxWUUUwV004Ym1h?=
 =?utf-8?B?Mk00VHp5R3oxNmthVERhMlh3bUFxcUdIYnQzbkkvZ09RQjFmd0JzSytWbDFH?=
 =?utf-8?B?NUR4Y2puUlpKakZNSFRQSWxMdDdCa2l3WTFmNklNVUV3TEtKZmJ2TzZpRERV?=
 =?utf-8?B?MGFocVo2TDNKSFNkNXVFbGlnRFBIRWVocGJHdy9laWZEMmRlOXRNNVk1TUJi?=
 =?utf-8?B?cjZNczIzQS9pQUVYekpJU3lEL3NNQWs5bG1XL2FudFpZY0VKU3FMblZWbU1D?=
 =?utf-8?B?UHFNZU9ZZEpBdXZRQWx3djQrazF2SVQ2UTdCQ3pmZFRPUTRWekQwd1ZlVHV1?=
 =?utf-8?B?TmRVV2tZOTBDYnpGS2ZsSkpuUDdjd015eDB4Q1JFQmZGOU1jMXFzSDB4dEhY?=
 =?utf-8?Q?GbilZAfqTMvzU8FHMh2uWdDMi?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c1ca3e-1730-4d64-ade1-08db82b00baa
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:14:42.6117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pgqr7/UFhpkalBly3jeZ5JsRBqPvTv9H+Ur3Uc7k6If+q+4RQl9zW4t2fhwe5VlpeR32Oc7ouPfkd3RjnQgTXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 5 ++---
 drivers/thermal/intel/int340x_thermal/int3401_thermal.c | 6 ++----
 drivers/thermal/intel/int340x_thermal/int3402_thermal.c | 6 ++----
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 6 ++----
 drivers/thermal/intel/int340x_thermal/int3406_thermal.c | 5 ++---
 5 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 5e1164226ada..8fbc97641740 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -674,7 +674,7 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	return result;
 }
 
-static int int3400_thermal_remove(struct platform_device *pdev)
+static void int3400_thermal_remove(struct platform_device *pdev)
 {
 	struct int3400_thermal_priv *priv = platform_get_drvdata(pdev);
 
@@ -698,7 +698,6 @@ static int int3400_thermal_remove(struct platform_device *pdev)
 	kfree(priv->trts);
 	kfree(priv->arts);
 	kfree(priv);
-	return 0;
 }
 
 static const struct acpi_device_id int3400_thermal_match[] = {
@@ -714,7 +713,7 @@ MODULE_DEVICE_TABLE(acpi, int3400_thermal_match);
 
 static struct platform_driver int3400_thermal_driver = {
 	.probe = int3400_thermal_probe,
-	.remove = int3400_thermal_remove,
+	.remove_new = int3400_thermal_remove,
 	.driver = {
 		   .name = "int3400 thermal",
 		   .acpi_match_table = ACPI_PTR(int3400_thermal_match),
diff --git a/drivers/thermal/intel/int340x_thermal/int3401_thermal.c b/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
index 217786fba185..714f4cb59cfd 100644
--- a/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
@@ -36,11 +36,9 @@ static int int3401_add(struct platform_device *pdev)
 	return ret;
 }
 
-static int int3401_remove(struct platform_device *pdev)
+static void int3401_remove(struct platform_device *pdev)
 {
 	proc_thermal_remove(platform_get_drvdata(pdev));
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -62,7 +60,7 @@ static SIMPLE_DEV_PM_OPS(int3401_proc_thermal_pm, int3401_thermal_suspend,
 
 static struct platform_driver int3401_driver = {
 	.probe = int3401_add,
-	.remove = int3401_remove,
+	.remove_new = int3401_remove,
 	.driver = {
 		.name = "int3401 thermal",
 		.acpi_match_table = int3401_device_ids,
diff --git a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
index 43fa351e2b9e..ab8bfb5a3946 100644
--- a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
@@ -71,15 +71,13 @@ static int int3402_thermal_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int int3402_thermal_remove(struct platform_device *pdev)
+static void int3402_thermal_remove(struct platform_device *pdev)
 {
 	struct int3402_thermal_data *d = platform_get_drvdata(pdev);
 
 	acpi_remove_notify_handler(d->handle,
 				   ACPI_DEVICE_NOTIFY, int3402_notify);
 	int340x_thermal_zone_remove(d->int340x_zone);
-
-	return 0;
 }
 
 static const struct acpi_device_id int3402_thermal_match[] = {
@@ -91,7 +89,7 @@ MODULE_DEVICE_TABLE(acpi, int3402_thermal_match);
 
 static struct platform_driver int3402_thermal_driver = {
 	.probe = int3402_thermal_probe,
-	.remove = int3402_thermal_remove,
+	.remove_new = int3402_thermal_remove,
 	.driver = {
 		   .name = "int3402 thermal",
 		   .acpi_match_table = int3402_thermal_match,
diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
index e418d270bc76..9b33fd3a66da 100644
--- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
@@ -262,7 +262,7 @@ static int int3403_add(struct platform_device *pdev)
 	return result;
 }
 
-static int int3403_remove(struct platform_device *pdev)
+static void int3403_remove(struct platform_device *pdev)
 {
 	struct int3403_priv *priv = platform_get_drvdata(pdev);
 
@@ -277,8 +277,6 @@ static int int3403_remove(struct platform_device *pdev)
 	default:
 		break;
 	}
-
-	return 0;
 }
 
 static const struct acpi_device_id int3403_device_ids[] = {
@@ -293,7 +291,7 @@ MODULE_DEVICE_TABLE(acpi, int3403_device_ids);
 
 static struct platform_driver int3403_driver = {
 	.probe = int3403_add,
-	.remove = int3403_remove,
+	.remove_new = int3403_remove,
 	.driver = {
 		.name = "int3403 thermal",
 		.acpi_match_table = int3403_device_ids,
diff --git a/drivers/thermal/intel/int340x_thermal/int3406_thermal.c b/drivers/thermal/intel/int340x_thermal/int3406_thermal.c
index f5e42fc2acc0..1c266493c1aa 100644
--- a/drivers/thermal/intel/int340x_thermal/int3406_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3406_thermal.c
@@ -178,13 +178,12 @@ static int int3406_thermal_probe(struct platform_device *pdev)
 	return -ENODEV;
 }
 
-static int int3406_thermal_remove(struct platform_device *pdev)
+static void int3406_thermal_remove(struct platform_device *pdev)
 {
 	struct int3406_thermal_data *d = platform_get_drvdata(pdev);
 
 	thermal_cooling_device_unregister(d->cooling_dev);
 	kfree(d->br);
-	return 0;
 }
 
 static const struct acpi_device_id int3406_thermal_match[] = {
@@ -196,7 +195,7 @@ MODULE_DEVICE_TABLE(acpi, int3406_thermal_match);
 
 static struct platform_driver int3406_thermal_driver = {
 	.probe = int3406_thermal_probe,
-	.remove = int3406_thermal_remove,
+	.remove_new = int3406_thermal_remove,
 	.driver = {
 		   .name = "int3406 thermal",
 		   .acpi_match_table = int3406_thermal_match,
-- 
2.39.0

