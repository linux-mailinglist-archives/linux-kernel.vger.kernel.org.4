Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CB0750352
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjGLJgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjGLJfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:35:37 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B961B1BDF;
        Wed, 12 Jul 2023 02:34:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuT3hNmvNMFAbPANuN3fxUKMTSnRm6y+D6a+tbLPvTW7zv7179xx88rMqODdAwHl8XpT54W70W4Q0m1BaqtLRgHLvJPFzDkuXIChwJaueINqVMBIf6xCS9mc5E8/9L+v9FdmMx41EoHQCURZazBciYUhem7TzdaC5/gdmndBjUzRob7SLwIY2GtjteJvFg+s+WSdy1X7AGiun9bMmnutLdXDO/xe1kBHrXw6MZcLWlE92Zz9bicdLrxTmaxiDvlM85JE5TyinENqUn0djh8b2+EJlD6tLD8t3zAMwkQ580m+HgAbbNQKUCbwHEN7oFibl06lND3eJ7YdE60iBZTvSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCJxJqCS0KKYw026hjVugnxJVvGsQ/lL/AxNkg9+mC8=;
 b=QuXUedM7NX/U0Uo55SAx/kuN7KzJTm6wvopEGo+nFjsK1kMkvElnxgdqBLwXhjA79XFhGJ0uT1VAfaiqXDuXC2Hhppq6HztaYuozMqRe54ESGkH/wA09W1t2SyZDx/Q0Pkg1W0Yp5W0m+eYTW4uMftb41NV8JOeMSoLjmHml438WfZWGwhP02JCyUcHzlhcqZRw8FfrZt7hk2r2ktwA0TcmBAUQhegmAAkI7mxur3pCCmH8VWO2EiqX78+w9W9r/h8bzc5cClxDA08pjFFge7g/1SDN89ZanMG3zgvAuZLmZSCyfrdvOUEEen/twJsAb2Gqsz8IP7QW/VN/ZJeFW/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCJxJqCS0KKYw026hjVugnxJVvGsQ/lL/AxNkg9+mC8=;
 b=nWmt8ubdlOq/bkuoJZhYaVp7QtJIVRuBmJoqv865216Pnjj3ZFBAchCsOdNxr9hMc9viQ9m93HPbfSWb1T9N8aHjSfF69J4jQM6qaAd4AjS1PdsomIhgDxcvO7Xq4RYhx/d4W4Y++WbIXgo7JrYDVrcXxByQwkC1YLY3y8wCYb4A+1mA8+BpHdh5SFaBqHDUNxJw9vmlTWm0/R51WoSTjVVF/a9yYHtJSQiKwCETI52vD6At4o8wII6WglWoC8oHSBnYvGQP5BXNcbgi/nESlWmpLo/azZmG+bbpnuC4T1q8jNz0yEM4NcWIvqQMiMEj7eWa4oMUMbeBh+AkCl4sLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5985.apcprd06.prod.outlook.com (2603:1096:101:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 09:34:02 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:34:02 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/19] cpufreq: acpi: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 17:33:20 +0800
Message-Id: <20230712093322.37322-17-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9b5658ce-a5cb-4a0a-0c8a-08db82bb2105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmuGR+XlQ+vsaBwsl7o+pCda837dc9Zn7b/Nl5/McPX8ajaIGzzsiLmPrtc8AYfFE7RiOH/wF4iAJqQee+4b5kLQ9bLRo+ZpzcmCr+Ky49ShEA969X7uNI5zBBT6BI4ChrAmAArpw76PmeN/P+sDlHoqloOorxo01Yx8GmxXWN0o6+y2RFAehXtaAxUDMN1Y6/cHU4SRiWJAqp4VBY2C3Jv2SMrSK6CiWD3ICEwMpey5IJ2oDMGK/LErNE+UQRQAIzA0AXZCedOzyivjuQ5zsAeLw+axDJbrXBNxdYsK66pqcw/4x8ffyLff9KlFGxDcbzaNkCMuKFMmd5zaKqkMHCXxcmXJcZRu/Na6Pai8ufB/tT4FP4Kzvo795lEYGjAPzTRf5sSrl0UtrRcy0qxTyeQ4zq6n3u95wG23BqKF/PHGLXpPPLg7TC813pRqNMWcKW3y9jbIT3sXkjhsaW7HV9mgHiCgGi/LtZaFevuPVCkS1lfk2hIKSnfljnLWCI81knYFpDWD+MlE25jvlNJXrqqI+KajzyiOxjb3EeeMCA7ddhXuszhNvuzn9UQpx0vs3HfS6BESoMSOVLHsqTMphtBNX3kmfpa9slXR4ubZBcS4g31m5lZMcjzv1y/FjdN6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(186003)(2616005)(110136005)(54906003)(38350700002)(38100700002)(5660300002)(8936002)(52116002)(6666004)(6486002)(86362001)(8676002)(478600001)(316002)(41300700001)(2906002)(4326008)(66476007)(66556008)(66946007)(6506007)(83380400001)(26005)(1076003)(6512007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWxZbE9hRHU4dXpuSWZyYWVsKy9kSU93YmtqVklGY3pZNXFGODI0QXBoMHRX?=
 =?utf-8?B?YXo3ZGlTTWpXN1NwVDlDMzd3a0NwMnBKTklKaDYxSnNaa01pVHRxYWM0WUVw?=
 =?utf-8?B?bmRKeXB5NVNwZ1VlMUg2VVJ1WWxzSGcxRXNKRGpPS2FHUTZyMWkxTllrNS82?=
 =?utf-8?B?MnVFVGlNMGVsSGJzbFlKMHdTeStRMnVzZFRxanF4L1pzUWVScDdVYTFOVEVn?=
 =?utf-8?B?Qi9CR2VXeEU5cEtGVFpRK2NSdEpjSlZtdktvcmx6ZCt3Z3dDdVJyNVNnUDBO?=
 =?utf-8?B?ZzhuQ0tCRFZGOGpGVDRaLzBHQ2JCN0tza3I2ekpRS1p3blRpNDFiUmszVFYv?=
 =?utf-8?B?UFVlYXBnYmZQeElEWVNoVlhaY1IzZXQ2VkJzbGYwN2RwNXBvODlaZlJweHl6?=
 =?utf-8?B?RUprNG5FL3I5UFlZbFVFbUlqdmMydDdIaVcvdVdrQmZDZFJpWUtTNEQ2QW9a?=
 =?utf-8?B?bUJXZlJRNTRteGVZbDZvemxITms5TitZNFNiZE04WXluRmNmTzJmTmFTazI5?=
 =?utf-8?B?T21pRXd1Slo1c1RPbHhET1RXdFNiamRYQWVJTlpRM2R5VkQ4TDZxVHJSalNX?=
 =?utf-8?B?cXAyeFlsYmVxOWRFZjFSWGVIemR0ekpHRVBpb25yYkFlKzM3aTVla1l4WVJy?=
 =?utf-8?B?RnZUUFI3T2dRbXR6YjFjVU9zOHBCbTUwTEJhVWZjc0ovRFp2clBjcXJRVDMv?=
 =?utf-8?B?d3lOcjNWU3JOcGd2Z2RFRERUak91SXh2dHo5R2E3b2IxSmlKUXF0YktrR1NW?=
 =?utf-8?B?UDBLdDR2bXErQ1FxU2V6VWtvTFRnMENSc1E4aE55N1grQ2xxeHdPNFdma1Rj?=
 =?utf-8?B?VnFCempLbFNIMnRRZ3FTRURWdGdoRHVVNk5VbE4rV294dXg1VzJ1aktiNFBY?=
 =?utf-8?B?T2VFeHUrcHFuMVVzc1RNYm5veUFYdVZhT0hTcnRDTHdTaVBtMFBkYTVOYysz?=
 =?utf-8?B?WlJ3MEJZZmJzbHoyWlE5WjgrcWIzeFRtRXlqdEd4dnlnSTR3Sk9iMmZDd1Zk?=
 =?utf-8?B?YWF4aWNNWlpaWGdOdTZIOStXVG9MaFRHbnVoR1lKMkZBNHdTL095YmVjeTVq?=
 =?utf-8?B?QXFkWWc3OEdWMDg3RkdlcDlXc1pBMjd4bDIxQVVyL2N5QUQvQXhtcGJTMXJa?=
 =?utf-8?B?TSsrVUt5V0cralFTSHM0LytRa2NmSmVzcTE5WWlNbGNBaDdxWDJkVmpDUzlU?=
 =?utf-8?B?UVozVFMyUVpYSEpBdVNNUC9wSGdmdTNwL21xQzRlMmhLV0haZ1FFdWFaV2dQ?=
 =?utf-8?B?eG9QeGZQUG5pSUNETlpQWE9TR0hzcW1GMUE4cXR4STR3UHhWTFQ5OUlWWGN4?=
 =?utf-8?B?eHN3TkhLMW1YS2Y5WkdWM3VGa3YvRDdaUTU5RW5yY2RpTFRRMkZGQTVLRmNw?=
 =?utf-8?B?aXFFaXJIM0JzN2c0cTE1U2VXS2Vva0NNUlBDa2N3ck04V2xDMm9ERGY5MFFi?=
 =?utf-8?B?dmpOYmFXekUxcnFVdERCTHpwYjhzR3ZQZnI4a3R3WTczd2s0NURMVU5pY25D?=
 =?utf-8?B?cmRzT2lBVTdhOUEyVVVxWFBVV2RWSXE2KzZFR3BKTk1McG54bkJwbjRaUGFI?=
 =?utf-8?B?WDF4elk0Rko4emN5Y25GbWV6bklyUVZQd2xBMTM2Rng1dm9OOGlRclFlZUxL?=
 =?utf-8?B?azNIdk50OGgraGZzTVFmWWpYNFNadTgzVk1RRXZXbGhTWlY4QVdEakpuRTZI?=
 =?utf-8?B?S1JWQldzTllnMEhwelJFZG94TFRubk1KdXNTc29BTjZFa0ZVSktMa1hQalll?=
 =?utf-8?B?ejdQMGNyMWVMbU4rNWEreWRzaUxJdE1lbnBnbEs4STZubUUyL1RTQ0JsZS83?=
 =?utf-8?B?ZEhQR05MdVQxK0JmTWVkR3laMjEzcUo5RVVtN29RV0tZOWo1N2pPUWNzVkM5?=
 =?utf-8?B?bEd5bFl1MUVuWFVKYTlvOU5YSFV5ckY0NmtHRHJHb1pFN1ppbTJxaUNUMkc1?=
 =?utf-8?B?bU1KcUo0ZFdFbm1DbzFTaWpkU2hMb0FoWm1TMm4wY0Q4WWFqUUY4ODNxSmln?=
 =?utf-8?B?S1VFOGNjclNhVDBxUmgwSXVWTGJQNUhIMCtpcTY4YTJCamdCUjZPSkt6T1kx?=
 =?utf-8?B?WVlXdGk2MnZJbGJmSTJDZlA1T1ZNaW9ONmFDWFpTY1FoVXFnbXhWSzUxcGNx?=
 =?utf-8?Q?LK9E2r4pMzwb/eyCGojl7H/PY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5658ce-a5cb-4a0a-0c8a-08db82bb2105
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:34:02.8930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +O5tqYl8IcGf3O37n5vRGESFvwe51tI8SSV4x8FPQY5RpXgpXtC9wPHxoLHT5dveyyF7Rw6JilYlA+Tfd1p2xA==
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
 drivers/cpufreq/acpi-cpufreq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index b2f05d27167e..37f1cdf46d29 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -1011,22 +1011,20 @@ static int __init acpi_cpufreq_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int acpi_cpufreq_remove(struct platform_device *pdev)
+static void acpi_cpufreq_remove(struct platform_device *pdev)
 {
 	pr_debug("%s\n", __func__);
 
 	cpufreq_unregister_driver(&acpi_cpufreq_driver);
 
 	free_acpi_perf_data();
-
-	return 0;
 }
 
 static struct platform_driver acpi_cpufreq_platdrv = {
 	.driver = {
 		.name	= "acpi-cpufreq",
 	},
-	.remove		= acpi_cpufreq_remove,
+	.remove_new	= acpi_cpufreq_remove,
 };
 
 static int __init acpi_cpufreq_init(void)
-- 
2.39.0

