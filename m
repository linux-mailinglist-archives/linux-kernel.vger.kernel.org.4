Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69BF750345
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbjGLJfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbjGLJeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:34:46 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2108.outbound.protection.outlook.com [40.107.117.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4433B1FE3;
        Wed, 12 Jul 2023 02:34:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnWpmjT+Zqp6EAabjbEYB2WkFjZN+RCLh7gVFWcIeOHGdabivta+uv+FBNHyRaPkiUEeygmqPxCtH2iWFh9V2yImNN4CNRynniQHV8mHGYFCngPWx59hBOKoOvBirmqP414QBDNozkZUAkq8kbUqjM3M4lNlXi274gkWbuwC7GAfP9vIICogpYPjikiaSCmVsmlvj2Sfy8kh3hRVwgXCdOK8jpDRUUnvvp4hrofs/lB+ERNnsHQP/q993hoRenMDlDUvvZdkDn58+RuXEQdkrEuT4GU5PygvpcQGJxMf1d2FW38ZOVYwqTM9DZ0wJH0IXBbJZMcl/xZ8Bbmq1rUVbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XqapXEpuuFmhuwq/fZXBPf3AQkm9oq/Wl+//p23kIY=;
 b=INzyd/BTzbyEQk/FvKowLsOGmGvy0Hcb52TRbgYhlD8oCVqGQd/ub5XiUu6GyjN7Y7BbEFxDUsD1wP+d8293v4dGoq01WUFQshSA8nOu3HA6KcT/Ab631u1jT/FJgi848u2t2N6Tj/ICJUtrkN/E16FLGcIF++YxO3i/SvMuzI+QWNnztDcAEB6NnJGAozh1oA2AglIHi9CCGdyF/WEHqMfx0zeWi24v6rmGTF2n4+Gp2vOlgwDg5Q1WJr7UWolugyY1Wu4+gZ2wYIiSBJTgKtbDIwLyDgFxbwtPdQWCcCjnbEu2RNJzXqulYwvpZLrM7cs98PQRIOyp/ofm8uaing==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XqapXEpuuFmhuwq/fZXBPf3AQkm9oq/Wl+//p23kIY=;
 b=Q44B7DOgyIs1xHvfngKdSxVjwRWKZmCjdvouBXoCSrASCIoASTrZxPx6768/RsqBrIZLsR8qel/IKssgkT4HIyeAlla2CkoXyuuAvYnA3vPTIblQj/UxKBrFpXwpd68O6r/VYlUqJV5ocNj1ZNJsbAt4pz4QkBY/V3jMYPHSW7gPM93YgAEs362rQcXEPGW5xu2gm8x4fqqY8GL4Pdi0JvbSiJRELj1nm9bTuwCFbDZ6RwqnMkOQRvlin2jbx75BcKJ6oMsImuHKYTwrCVwK1wPiqGSL27J1MZPpFNQux78jQKlsirIRDv2zS9mICSxXazvHPUourApji/EJCdrE7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5985.apcprd06.prod.outlook.com (2603:1096:101:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 09:33:54 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:33:54 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/19] cpufreq: raspberrypi: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 17:33:15 +0800
Message-Id: <20230712093322.37322-12-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 123b8d4d-82ef-48c1-3164-08db82bb1c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FN5Xuuxp7ea2O7fvbZ6yyYSKGHrNGsF676HMetedTy2WIC6cuClhg1RVC6Gsnyg3xz7plbw9agiErnKTmxrNWn3bokQeqLxnaDviq5baz98ZwEx1FZ3YHltivfef08U7bkI9xoXgE+DyF8p3EfSc5CbALwlNgYB5B3jiFqlYrlEMZv1yIoh4mRiaWMyxQMp5HdYEkNN6pBj7iYxOcKWcO0fWZEyrME8HVoe/a6lHbXdbLhKTPLP+J/kmR1Za1CmCf/LL4xfKFZx/L4aOAGQ1DVQ5bGmWAL34KFuVCsUW0tkPECIwU05VtP9w0AyUFdDQS2okWRUTnwg9q0D/gCxMcR6qeCBN+/gIdZWZJRzXOw2rCifKj73vqRWvUQuzpxcDnBlBP+6A4G9dyvPo61T3qPi8OMwYxFiCQsHOcjBoEdqiBfg6IpRBUQ7zOGO4FR9g55wl6Gd0PTMcXC8Z8SY1l9bOPbPzfVE93G2BbFLULnhebrY/gwCf+U2n/hIB/seZAGIlFeMoBTOxT7HHr68WxEHEpjRn5Sh/cMNHJ74YvTIT1MV9xC9+sA++T8v3ujwt1FvAFt16s6EPBpIzwBgG0wMYGmlWsIWSyWopulfL+doA7C9/B/U/iXj4m7VKGgvm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(186003)(2616005)(110136005)(54906003)(38350700002)(38100700002)(5660300002)(8936002)(52116002)(6666004)(6486002)(86362001)(8676002)(478600001)(316002)(41300700001)(2906002)(4326008)(66476007)(66556008)(66946007)(6506007)(83380400001)(26005)(1076003)(6512007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2dtLzZiUElrOFBEd28zY3FsSzl5Q3hXREM5cHdlY1RPb1hkMUJiV1ZWYm10?=
 =?utf-8?B?RndIV2FuYUJvc0RvaWpIeDlnaVIxVmVvUFRROTh6Z3lmM1IwUWl2Ni90KzE4?=
 =?utf-8?B?ZVh0a1FBc2h5WTJLNEFrbjZwdUFyOFJwV2FkbGlBQzFKNU04N1gydTJSVkI0?=
 =?utf-8?B?dW1hbXBXRjJETjNGelJhck52bjd3bGdjbGFHdlhkLzlOdjZZUTJ6cG93QXRG?=
 =?utf-8?B?UVJrbkE5TC85NUVpcFlpNDRTMVVvTnNiSW84M3hVL0VZWWJDcjRQYU5NZjMz?=
 =?utf-8?B?Vm92UkMwcjdqTmtXeWNSQXBLRjhHcnVaenpQdnJTUXNCMkhxcUNSL2tUUzVN?=
 =?utf-8?B?TVhRRWl0SVJOcTlPSXRGNE5qQnVkYmlrVHV6QWR6UGJtbHBTVUNiSDZreUxI?=
 =?utf-8?B?WWtmbDNLT245UFJVV2ZGVUtxWlpjSytFN2FJYThFRlNIYTQ0S3drQ3JjU1E4?=
 =?utf-8?B?dDQyUVNad3Bqd2FZRENkQnFQWnVjaTlxQnhqOURlZTIzZkVjdXp4NkhXWncy?=
 =?utf-8?B?bWxISTZVMkxxclNRV29YL3lpSW1sb3l4K1ltSnp1Wk9KU25vRVY4VDhPLytQ?=
 =?utf-8?B?ZzBKWk83R2o0OFpHd296Y3RJT2RnY1dQS0U3K2pjRXBiQWVCc2Vua2MyWTlq?=
 =?utf-8?B?U2d0TCtCemlkZ05OMjllTW04Rm9pZGxLSnlHU0NTSW4yS2ZaRko5bEZraXZS?=
 =?utf-8?B?a2g5d3FBTnNGZWJzTVhhanFBbUtGRDhWMmd3dExySGNpZlVIT2piRm1YMncx?=
 =?utf-8?B?QUdBY082WHNlM1VEaEdtRDg2cmtVL2hIRERFOFlJU2JicmFXcmd4Sk5ocXk4?=
 =?utf-8?B?TTVXQmNDVG5wUVpzaU1yUkZlVFVQcFNvVlphaGFIMzNJOU1qZmFnMDBtWS9x?=
 =?utf-8?B?cTV3bDZid3ZWRGJtdmNjTGE3UHJHL1J1NHVuc3paVit4K2Q3RUNkdWZBVUpQ?=
 =?utf-8?B?TFpSTitTWkRBSkk5Qjhac1FmbytrMUN4RGtZSFBteG5reXB1UVFuYXZoallw?=
 =?utf-8?B?Qk5GbmlpNU9uMXhBaFpNOWlFN1F2ajh6RUgwYlk5WEw4elZWMFM5OTdPTEdz?=
 =?utf-8?B?b0tBV253VnNjN2ZNR05IQkZhOXI1SjVKRTdQS0JwdWVaVkhkb1h0NkVjblEr?=
 =?utf-8?B?NTNIT0t5Q0wreUNsUXpnUEVWeW8rU29ZdjIzTWc2S1pKRzd1ZXRnT0RnbDFX?=
 =?utf-8?B?TlBOKzYyTnpHWlRQbTRZeEhkV01NUGZabzZVRUJmR042dmJHNVVoOVYrWGlO?=
 =?utf-8?B?SStnQlNIT01kd1pYK1drNGJvaWlZelpBNVZjcW15TG1maDBYUkZBL1ZLZ0pl?=
 =?utf-8?B?NnBMWXRSY2E0ZUh5U0RHeDVDUkRySUFsT2VadTNlaCtSUm5MakFmbXQrQXZs?=
 =?utf-8?B?a2J1eEFvRzBBZnNYWTZ0UjJoK1ZpamxlU3hKQ0t6MjhpK3U4bzh5YytiNFp2?=
 =?utf-8?B?WU50aFhLaUNoY1M4TTJ6bXVXZUVWcGRQQVN5aEljbWFWVG1jM0p0NWp1ZEVQ?=
 =?utf-8?B?aE9PSkI4bExPdjFTVXNpYXNGQ1YyWTcvVFZwVzBSQTBzd0lGSEplUlFhK2RS?=
 =?utf-8?B?ZnU5OEZDdGtPcXRNUUNzUm5KdDQwUTA2aXpNTFlNNU53OXdPTXJ6cHJieTZO?=
 =?utf-8?B?RjJqdmxYM3d4OXY1WUpVVlYrRGJIZXZ4TzhjVytOZ1JGZ2RuSWs4Q0Fpbmwr?=
 =?utf-8?B?QXN0M01INTVOZmM1TURudXJjNkdJQzl1enk4RnFORUVhMy9Pcm8wdHEyZGNh?=
 =?utf-8?B?R21HYmpaOENkS3p4a3lJakxQYjQ0S3pMYnRFano1Ynh4WW8wOWk2MGRxWE1U?=
 =?utf-8?B?d1FTWmNuUHdWcE1QZnFqZnRHQUUyanR2a2RkU1RJK3hvSHRyQUlYaEpJOWlG?=
 =?utf-8?B?R2dwMnVMRW5pUzI3Z2VGc0hFYnF2TVBXNnFNbEtTUjhEU3pWYzZVVzhmdkV5?=
 =?utf-8?B?WTJjeE1rMHRKZ3dqRjlWT1RlVHlIYXhWZnJFU2hnK2M2RG5IdGZyakJ6Z2pY?=
 =?utf-8?B?ZVppenlJV0NqTXMzSWFRNDVpWXRrd0I0NG9mbXZXc3ZBNmw4V29LTE9HR2c5?=
 =?utf-8?B?dVVPak5ER05wd0RvWG0weVR3eDdOdnNRS0l4aXF0eUVpWnBTYVNRMC94aExx?=
 =?utf-8?Q?0gEsV0jCpgDAV7AoU3nRLywaJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123b8d4d-82ef-48c1-3164-08db82bb1c3e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:33:54.8825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDRMIcZfMtm9zTRjfCU8aTaMrwFUZFeasC9w+eRYEMpDs3YApps0jKihcEgJg+1VFAT3uDxi8fZSKUK6QCgiVg==
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
 drivers/cpufreq/raspberrypi-cpufreq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/raspberrypi-cpufreq.c b/drivers/cpufreq/raspberrypi-cpufreq.c
index 2bc7d9734272..e0705cc9a57d 100644
--- a/drivers/cpufreq/raspberrypi-cpufreq.c
+++ b/drivers/cpufreq/raspberrypi-cpufreq.c
@@ -65,7 +65,7 @@ static int raspberrypi_cpufreq_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int raspberrypi_cpufreq_remove(struct platform_device *pdev)
+static void raspberrypi_cpufreq_remove(struct platform_device *pdev)
 {
 	struct device *cpu_dev;
 
@@ -74,8 +74,6 @@ static int raspberrypi_cpufreq_remove(struct platform_device *pdev)
 		dev_pm_opp_remove_all_dynamic(cpu_dev);
 
 	platform_device_unregister(cpufreq_dt);
-
-	return 0;
 }
 
 /*
@@ -87,7 +85,7 @@ static struct platform_driver raspberrypi_cpufreq_driver = {
 		.name = "raspberrypi-cpufreq",
 	},
 	.probe          = raspberrypi_cpufreq_probe,
-	.remove		= raspberrypi_cpufreq_remove,
+	.remove_new	= raspberrypi_cpufreq_remove,
 };
 module_platform_driver(raspberrypi_cpufreq_driver);
 
-- 
2.39.0

