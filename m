Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E7C74D29C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjGJKCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbjGJKBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:01:50 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2116.outbound.protection.outlook.com [40.107.255.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3258A1FF9;
        Mon, 10 Jul 2023 03:00:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdQJlTPCm5RPKWhGimlSoyNApw2ykcu1sblHHSFP1fWiOnyblNmJS5ufA6+xPIXGapgnTi8DL9PIMiSo/pspdzmYEe+fkGbXKc89fc1YXT+74JcnyH5BhrextoxlEz8gYZ9x7JMDFt3be6SMlzr+BoSH7/uSN784jgUBDlFLxVCADZIeesakOBSIh1oOZdNBmk+3RI+LjQqBAvevD1IlRO/up6MOZ+qRV5Vayq7I3IUpx9Zpbyzb3PfESuJTIZJuuqk6+4SNg/8OicxKkUR7QkEbprDw4aSRVxrHD9IHAThGtOJIESXiOxVq0AfGqhu3NaRVyiJ3wKgJqPio/oSQqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1Hj3E6IG7zyG8szMhWXzr8YNPdDsgk2wzcCR+rFIBw=;
 b=fZ8QW75IkyVcHwdNSo98YUB8RsnOtBEyHbeo0zQ6HwPt6sxm+/jdrUahBwgeETZaug34/0cuc+03drNHKkHf8en7DQw9+ypuZRIbAdiRkV+JGX0ZtRXTKyKUI/n9jZjj+q7XVHA9CRU+fHaGkHJErJ5OXKub6GBUh1mmCYavc9Nh4uC54B9xEs5cwCViwzc/z5iSBAOYnaYsMm32kCKD49fVQc9xr7dAMFFzT6ltxSSjh/w90vYVT61gzfaCL9O14uy6hhnXXG+suB0XRbqSNK89lgbf7cUXYDkb+kvACO6BTrDmXa0Yr+S+nmvz9wTrt268d8cNUNWvqvkxshG5NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1Hj3E6IG7zyG8szMhWXzr8YNPdDsgk2wzcCR+rFIBw=;
 b=G/FZpuu7p2k52nGzYZoE8R9SWMD7B/GluQFwhKfKdVkyZV3R/HpN8tpsyV9r/72yYVeXGHQ+fOPE1WzpnCclymlMOLH77JhnL+hBv8EbCe9V9JfS7klDEfMejm8HVVi1YjpW1WCJdofSAOT0mXNueqHGudvcEzonBZRrCu6NwtvabBxO+mcNSZLDQEl+kBZsIOn7niAalQAjqOCEBKLaPVyf5clmtWd2imzi6pVRcubyQ9tDSIXmkHFQYR68KhiiLqXDVAqETrA9684Fmn9JerfrAbTrhBVTrPvdzsz+haLVMh0HqWLmxueAmWhhrxjhNbr6BC1VlGu8Bnn6/sN5aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6096.apcprd06.prod.outlook.com (2603:1096:400:33e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 09:59:50 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 09:59:50 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/21] thermal/drivers/tegra: convert to use devm_request*_irq_probe()
Date:   Mon, 10 Jul 2023 17:59:09 +0800
Message-Id: <20230710095926.15614-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230710095926.15614-1-frank.li@vivo.com>
References: <20230710095926.15614-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0167.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: f0f2d4b8-600b-4955-a69c-08db812c6699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BfInYk8hT9Mjqvc5dwfZtA0Vs9wI5MX8qXTCcE2Rn0EFqHChUuI4+W5PxcGferBrcOioI2qYOMUbTum7QULK7hE8ilPVNgoXBvKiSckfJ5Hftx9fTdCNDws8tR0APO92r3u8CSG/b0oRDHrjdk+JpOLsIXyziNlyxcWj82zWnmMv4zsqy6BRYt5Yr8UATmzkxjz5nPUhREBs67TgwDk6RDGrfJkso1f20gV7lscduucpv8avs6+gQoBNrfjwLUQKQz+wI67NuAvpkhdYffZWPkY0pS5k9deD0i/jYFP6qqc2LaoOvLT9G3BfoBME0B3B6lOPnRC+eNLQ8DTpAG2XefaX4Vrc9pY379sLgCG+VrcFG/be/r0cND+BIkrzJvXlesUfXTjtCcW2YoGvOwG3rbyJ3SaVQM3bgAILhX7qTbhHUrweUUHdNMSwibTY6qB3qv1HsCD7Y3sZ9XlLeY8/e7XQrpPzeFOzomtlUQiGQ7l0FwcZGYVYHmmQ40fr+opiFQki8jjO8qSBTQa+jqCh54HjNtI74KHmKDuslpMC+297in9O5E1yVFfm+jBHIRQUULX578COxN8azLrT+zoF+Yl1uZkA2itW+miK+lYIjCUgUAf+juQs+0V+2RHlhvZh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(366004)(136003)(346002)(396003)(451199021)(186003)(6506007)(1076003)(2616005)(6512007)(26005)(66574015)(83380400001)(41300700001)(4326008)(66476007)(2906002)(66556008)(316002)(7416002)(5660300002)(8936002)(8676002)(478600001)(66946007)(6486002)(52116002)(6666004)(110136005)(54906003)(36756003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3Z1T0lUWnJGMnUzVkNlRjJ1VFROeE10ZGVFWFVHcGY2b2V6TlQ1YnNrenNO?=
 =?utf-8?B?QmlWSFRDdDNGaysxTmdINFVzZnQ1b0ZDMnhiR2JqOXFodTk2NmFoVFE1SjNK?=
 =?utf-8?B?TU1JOFBKS0V3Vm5EempuS2U5THE2N29yVTR6UFVDMkt2TW1MYXU0a3lQTzVx?=
 =?utf-8?B?S3ovL1gxQlZlK3V0enVNdTNqU1pXbElKR3dYNEtvOGhCYi83VnpNdk5CQytV?=
 =?utf-8?B?UVFtQytWWlRWOWYyUzhJOFE5bnpZSWZuOUxhUHN3aGpNeU0wVUFhZk9vZmtu?=
 =?utf-8?B?QzlPcFdDNkRZSlllQWZ3dGdEbUVwWVoyZTNXV2M1WmgwZ0ZmZGJaRDNnemdj?=
 =?utf-8?B?cUN4NHVaYnh0amhrT2p6bi8vQWpENlUvT1JlRWlHa1NkaW1YODhZRGg3WXlY?=
 =?utf-8?B?aXZWazVTR2c1ZXc5WDhEOE1SMk9SL3JNVWRXdHN5ZE1ERHhDZXJmc2QrYnN6?=
 =?utf-8?B?bTMrWWhFeCsxcGUwOTV1VnM3REFCaXdZSzJwQjB1MU45akNRYUQ1a2hyQW5o?=
 =?utf-8?B?MHJNVFFoUnZ5ZGRlb2Jlc1JSblN4dkdGdlBqbHdwNHVNNHBtemVGcTVhRERG?=
 =?utf-8?B?K2dkUmlJeHZ4dnViSi9wWmtGa0ZXZk5VZm5nQmtlM3dMdDRHQmVwUmRjWHlN?=
 =?utf-8?B?VTg3dCtxSmR1Ulh6SEMvakNpWm9ic2hUYXlLcmpSNjh5YjVQYTdPWlBhOEFm?=
 =?utf-8?B?RmtvQjVSdERNckFBUHZRQ1o4THQ5L1VSWTJiaVJvK1A5K0xndmR1WFdhV3BJ?=
 =?utf-8?B?d2s2YlZTMEVRS1NMT3JjRWNwRURRSEVLZjhNRUVxRVJkRzlER2pJNjY2MU11?=
 =?utf-8?B?Rkx5MzU1bHNGYnArRkJzYUhoNFNmU0N2YktBUFNyYnhzWGdzcFFwK3ZXQTc2?=
 =?utf-8?B?NHl6SEpsZ1FFcnVVYU9aZGwraG1aSVBiU0dvdml6cEY0aHNGSGdOQ1REOGR6?=
 =?utf-8?B?bnlYL0hvZG1VL2wxKzJmSGVKSkxqbjdUWDRNcmFudHVrbGczQ1gzbGV6REhO?=
 =?utf-8?B?WVhZS2syaFJZaGhpWDVNVnpHdm9NSFRKTDkvL3NaYzlmckg4SHNsUDJaZ0dh?=
 =?utf-8?B?MW5wTEIybHYrOHlUbXRGRTgycFRPYi9KS1FUWWJ4dXJLZlhqREFlVHI5bDNy?=
 =?utf-8?B?WGIwclNMbHU1bzdsUXJtb2ZlWVQrMTJhMTZLL3lDd3NVaHVmbkdNTHBZbnJD?=
 =?utf-8?B?eGdUeUhzdnNOcTdhSWw0OWxaVUNIUWxBZjRJc1JLZFdjanMvUEt5Mkp5MzI0?=
 =?utf-8?B?Mm9aSm80ZlZpS256UnpvRHczallPOVdVL3NoVE1VYng5V3RtZmRwVVJXb3Na?=
 =?utf-8?B?M0JYYU9jbU81RVdyc2UyTWF3VFVJcnVJNnJuL2RGeEp2bDBUVVBpeG1VTjRI?=
 =?utf-8?B?SjJRU2t1RzNhbGFJOUw2MVZFdm5LQVdnTWdVVmMwRS9PQnh4cXlpSFJCSFBj?=
 =?utf-8?B?TlFtbm41WWZIZU9JVUc1b0lST2lsUXRtZFhxTDRJbmlOWWduMWlES1BtcHhG?=
 =?utf-8?B?d0lmVVd3QXI5aE4xcEQ2anpOa0VwOCs5V3F6dWViOGdyVzNTNnp5RG12cTla?=
 =?utf-8?B?Q2tGRUV5R0Uxc2JMak5zTGQwYTYzcTcyKzJkZUpLT05ITis3NEFEUk5yLzQ3?=
 =?utf-8?B?WHZleUJUdFBBbkpaMDhNbTZzLzAwNDRVbVBzbXpFc1ZOT0lOd2I4UndteU1U?=
 =?utf-8?B?ano1NXpWdkV3U1lMRHl0a2o5VW5DRm5GYkJqUENkTjRRMituamFEQ3E5Njhx?=
 =?utf-8?B?aGFDYVIzY1cwY1NjcG5IOHpabW1EVW9IRk1laGhIZWw3WE9HUHJMU21qdmYv?=
 =?utf-8?B?bDQwMVcwSjdNRVdXbXlScUZvNW9XLzJxSWp3dFJnVjZsRUlQOUV2ZVlySnJz?=
 =?utf-8?B?UnlyWUlPMGxtMW1zbnBSRXdGRE81eHg1REdpdnVzZ3VtNFQzeGgwS0VZcnNk?=
 =?utf-8?B?UzdMVzYxWS9nVUlIbVUvTnhNMzhpcklKUU8yZDJmRW1RZDRSSVA4bHllb1lL?=
 =?utf-8?B?UEhEMlE1SFY3bk51UlJSeWtER051bEtnQlVVdlExUGZBRXhmeDVpck5QOHl2?=
 =?utf-8?B?ZGVicHVZaXp4NGNlTmxSZVZYRGVUSWNEMTE3RWszYU5TWWt6MGQyWTN2azVu?=
 =?utf-8?Q?kJZ/P7ERpyBvBnPfOI7slpPC0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f2d4b8-600b-4955-a69c-08db812c6699
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 09:59:50.4269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvGobHM7xebvcbytp1JBQdKds+MxSgga8P9xZO3iFa0q4GePfYMh0sybv7lXNFOvy55lw58Rflif/4RTNC45qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more than 700 calls to devm_request_threaded_irq method and
more than 1000 calls to devm_request_irq method. Most drivers only
request one interrupt resource, and these error messages are basically
the same. If error messages are printed everywhere, more than 2000 lines
of code can be saved by removing the msg in the driver.

And tglx point out that:

  If we actually look at the call sites of
  devm_request_threaded_irq() then the vast majority of them print more or
  less lousy error messages. A quick grep/sed/awk/sort/uniq revealed

     519 messages total (there are probably more)

     352 unique messages

     323 unique messages after lower casing

         Those 323 are mostly just variants of the same patterns with
         slight modifications in formatting and information provided.

     186 of these messages do not deliver any useful information,
         e.g. "no irq", "

     The most useful one of all is: "could request wakeup irq: %d"

  So there is certainly an argument to be made that this particular
  function should print a well formatted and informative error message.

  It's not a general allocator like kmalloc(). It's specialized and in the
  vast majority of cases failing to request the interrupt causes the
  device probe to fail. So having proper and consistent information why
  the device cannot be used _is_ useful.

So convert to use devm_request*_irq_probe() API, which ensure that all
error handling branches print error information.

In this way, when this function fails, the upper-layer functions can
directly return an error code without missing debugging information.
Otherwise, the error message will be printed redundantly or missing.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: AngeloGioacchino Del Regno  <angelogioacchino.delregno@collabora.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/tegra/soctherm.c        | 38 ++++++++++++-------------
 drivers/thermal/tegra/tegra30-tsensor.c |  9 +++---
 2 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index ea66cba09e56..3d144377d90a 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1993,29 +1993,27 @@ static int soctherm_interrupts_init(struct platform_device *pdev,
 		return 0;
 	}
 
-	ret = devm_request_threaded_irq(&pdev->dev,
-					tegra->thermal_irq,
-					soctherm_thermal_isr,
-					soctherm_thermal_isr_thread,
-					IRQF_ONESHOT,
-					dev_name(&pdev->dev),
-					tegra);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "request_irq 'thermal_irq' failed.\n");
+	ret = devm_request_threaded_irq_probe(&pdev->dev,
+					      tegra->thermal_irq,
+					      soctherm_thermal_isr,
+					      soctherm_thermal_isr_thread,
+					      IRQF_ONESHOT,
+					      dev_name(&pdev->dev),
+					      tegra,
+					      "thermal_irq");
+	if (ret < 0)
 		return ret;
-	}
 
-	ret = devm_request_threaded_irq(&pdev->dev,
-					tegra->edp_irq,
-					soctherm_edp_isr,
-					soctherm_edp_isr_thread,
-					IRQF_ONESHOT,
-					"soctherm_edp",
-					tegra);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "request_irq 'edp_irq' failed.\n");
+	ret = devm_request_threaded_irq_probe(&pdev->dev,
+					      tegra->edp_irq,
+					      soctherm_edp_isr,
+					      soctherm_edp_isr_thread,
+					      IRQF_ONESHOT,
+					      "soctherm_edp",
+					      tegra,
+					      "edp_irq");
+	if (ret < 0)
 		return ret;
-	}
 
 	return 0;
 }
diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
index c243e9d76d3c..dd4c2deba93a 100644
--- a/drivers/thermal/tegra/tegra30-tsensor.c
+++ b/drivers/thermal/tegra/tegra30-tsensor.c
@@ -593,12 +593,11 @@ static int tegra_tsensor_probe(struct platform_device *pdev)
 			return err;
 	}
 
-	err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-					tegra_tsensor_isr, IRQF_ONESHOT,
-					"tegra_tsensor", ts);
+	err = devm_request_threaded_irq_probe(&pdev->dev, irq, NULL,
+					      tegra_tsensor_isr, IRQF_ONESHOT,
+					      "tegra_tsensor", ts, NULL);
 	if (err)
-		return dev_err_probe(&pdev->dev, err,
-				     "failed to request interrupt\n");
+		return err;
 
 	return 0;
 }
-- 
2.39.0

