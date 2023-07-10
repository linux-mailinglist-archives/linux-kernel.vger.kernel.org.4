Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD7C74D2A5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjGJKCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjGJKCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:02:10 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2116.outbound.protection.outlook.com [40.107.255.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F242716;
        Mon, 10 Jul 2023 03:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9UOekh70PjWwE84uhkavOTKNAcMPNZcuFQ444I2ry/5O1deGl3O2qfAwThHETb7GI4xQdjrFK4QbcQ9hE9B7SoafIB7KrNnVJsCP0YJPWR9vg/oVsebSGHMji/+A7FZsV3jzhILs2JeLuSds808ADUFli44Gc9KgEl8MXbyx7fPCiqryLOyLfoCVW6JLLlPA0OJoDIR+ckPowQKpKM4GPiRrlP0YK+n5ILwCt5klD9UFbsuARnbfVxKZFxEz33qt5KC7JywGIfG64Nb0xMiLOQpf7l1roz4gqQXe++GT5dN9xyBpIAMt3TNrR1suH4p4b/IJfKW/ACwd5WZC/I/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHojIhWiIchKie5prnQ0Ii6NtBQrjHSYpApVgve/ZX0=;
 b=ZJhpuzbmOPWIhFTlzyqSnM0SFWqydqwVDZA22I7TcXyF+KH0pvAE/8tCaNqfI3PR+MnmoQy4IhVpnTm0clhykMGa5GHmN7C8R1Oaf4G1lYvmEL1NwuKZPv90fMtaew7fdZb9DKMrooseyGCZIsQC2RR4jQxkNhnb7Efrd4gvJffO3INKtES2NiSp9oDkM+XlHB18KnxpWouOk2/vyWjMgX8ju0gp199Cwvb9KOMqDHLwg2vA9UlZIuWqMoMN/0GComkMZDJymtcSTPX5NOI9jlZIGZ7dt5CEdOy9r1GwC4JVCYhVRtc+ECEBYAQq6OBRsFa9v+mhfMiesULrpHqrNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHojIhWiIchKie5prnQ0Ii6NtBQrjHSYpApVgve/ZX0=;
 b=AWoZdthE0HasAo4m1BnyepY5KsmRzZ47py0WH8UctJCjefBXHoaNB6+Z+ZhPPZh4MQTzlTlwLafRTWsbmrQs/dJtZMsQcLUDHy4SHS3PWsT1aaU8Y0f5Pm3P2dvDScSLGA9PmcvOb2MiG+PQ9Qrrcis49DhAtZtNCKcWoxTosS9ftBUNNinHT6YIJPGOdyCLnPdJiDOgBvJPs33sOLASBb7elLqXijOctUTa6tmbeXWM02bBLHILYZJUnlZCokG+/hYopoXfT+KMvIyky5JnQZZMYVH2f3bwBZmks6CqjqB1YiDb1m6kOjwfWcv12eicYEp1ysQL6/MWP50eTQyXRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6096.apcprd06.prod.outlook.com (2603:1096:400:33e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 09:59:56 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 09:59:56 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/21] thermal/drivers/rcar: convert to use devm_request*_irq_probe()
Date:   Mon, 10 Jul 2023 17:59:11 +0800
Message-Id: <20230710095926.15614-7-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 04e312a8-b6fd-41f6-697f-08db812c69f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YFkrTWieUWAi4Md00nGOX9B7it/08X1CH1GI+iBrjqkTn2jGPXZm6cG7yaR0p0D5N58fzg4z3jWFDdNsQMehDasRrUTDYZGlaWdWnBbjBNMHxmwkL27+Exdl3+6CyBfNphE6vn+1zy69z/xhlUdFVRrWgx8ZxxSVF7pfmNDdG736u8yIIOp7RwMyV3ji6U+Sonj8d/BVdlxeoUDkFapJLzYGRw45Q+EuXKLjm0q22hAT7Lr+G3Caj8iBsdQh6TcTJP6ZYNRYtNpSDGfuUY8yhSjCXea0mM/8kxPQuPGNXPdy02+n3UVOzizVDW3vTxcSueBsqKaPYaJCCRz1cwJ/5BbGID54AG0RMbOcyGiPWXrCSWaE0mHXAuY2ahn27pmbnTEZn/y4/kfJTBwX+vDQb0zZIGsezpwUzQqXxFCdarvaJxgJL+QWpcx8H8krThj80kPHRn5368mmZ74TkpXwE7jKLFX7BSfjrLHuFLrpv0dn0wMH/OdToJQXTRwUNNBqLVOj+2UhjuUeRt50rCikJHZY46LxvM8RkJxiiFqSxTOvsVYk+TCBiDM/ReLVpKPsVlcgW5mMz2Dia6O1AqMmsckF+EU5E1GwOV2Lajfq6/lmYQCUQpDBfovowcWMH8xj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(366004)(136003)(346002)(396003)(451199021)(186003)(6506007)(1076003)(2616005)(6512007)(26005)(66574015)(83380400001)(41300700001)(4326008)(66476007)(2906002)(66556008)(316002)(7416002)(5660300002)(8936002)(8676002)(478600001)(66946007)(6486002)(52116002)(6666004)(110136005)(54906003)(36756003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHZJbm1jRTRRekp0VzQ4MUxXemU3aVpGRVMyK1RBaWdGREF1bzc0bm9XS3RI?=
 =?utf-8?B?MUt2YlBwWks1UituS2xmSTU4OTFlOWFFQ21relZNSm5XS3ZVL2R4MzN6SmhN?=
 =?utf-8?B?RnpuQkdtMnlqU3NtM1p4ZHRrUlNqRTR0QVl6WFhrZTBGWm03c0pRYkJPOUx4?=
 =?utf-8?B?QW5zR2I1OWF1MnlwQjFLQjdnSnBmb0xVaTVJWkYyOWFrckJVRjlxcW5MYk45?=
 =?utf-8?B?M1JKV3V2Ync3R1FleGl5S2pNSnE4cjF3eVhzMzI5bENMSUYweVQ3NzExU3Fp?=
 =?utf-8?B?c1FxRDh0YTY0eC9wNWluRmo3YTNaMmlEN2M5VGdMK2pYa0tJbzk0QWo4Qk9S?=
 =?utf-8?B?a05XZzNtT1JSZUh6YTE0ZHExYkxnSmtoRERnMDFRQWR4ZitQMWxnR29FTmxk?=
 =?utf-8?B?cWx3Nk9JSlpKR0ovSDhuYndYV25XK0ZIR3JBazU1dXRreEdCQTJyaGs4dkxO?=
 =?utf-8?B?TFcwamxKazhWbC8vN1pPUFpUeEhkdHhHK2piOWpaSStGSVA5dG1NQm1zMks5?=
 =?utf-8?B?UkJmS2plU0JRYmVlK0s5NlV1OU1aRjExdmxGQXpoejFPei81eC9KOEp1ZFFy?=
 =?utf-8?B?MUFXVlI0alZ0cnJ0Qjc5bnppVFRoN2FqNTI1M2I3akJ0b2lPenQ4OWZlcVV2?=
 =?utf-8?B?WHg4NEdwdFhWa2pMVEVmTGx1VVZOWmlWK0VYYW9uUXpIWnNhMGJDKzVESUYx?=
 =?utf-8?B?R25CYTZVb2JheklCakNyMng4WGxpYkZwY3FPdHVPV2pYQmowaTQwWTUwZDZ1?=
 =?utf-8?B?Y1ZXN3dsUUI0QWN2VWVFL0JxMXgwdlorZzFONlFTaXI2NEk1SWpvRm1ib0ZU?=
 =?utf-8?B?UktYdFZrVFVuelA5dXFHNHR3THlJdGhLNnZpV3hNZG9mRXJZRHlWVGRudkxG?=
 =?utf-8?B?RE5ibktmeTBmbHJQY1k5eWRrNmYrOTkzOWg5eUVGc3BUYTU2VnJwMTY0V1dt?=
 =?utf-8?B?dWYxRXZKY0ZudjFvY2NHQXNOMmd2UXpTTko5cXZIb0JlSDVVMXo3YmpXaW8w?=
 =?utf-8?B?WlJPK1MyblNabVVVbEYvYWErd0RHWnN1R0lSL2lqUnhyTjVTOHRia2FGcFVx?=
 =?utf-8?B?clhIVnFSanRDVkRRSGY1QjloTG1KNVRRNml5SEdVZGRkdCtPQXhROVFXV3du?=
 =?utf-8?B?L3RWM2U4MzBuejZDaWl1WDBpYm9JV3pYUVh5RU5URkY1STNlTk1IdGVuSjg0?=
 =?utf-8?B?T05wR3Y2K0Q2bkVjZG12OFJtSXBJUjJMWEswazN1ZC91cy9aSjNtNDVQc2V4?=
 =?utf-8?B?eFJMQWI4MTVZc28zQWdNM1U2MGhLU1JrbzhPcHpEckdJczl0VUhKNnp2SUM4?=
 =?utf-8?B?QTM2UHlQSyt0cDFRNTdLSEJ2cTNaS1F6SnptbFRyYW5GMGpvUDlhdyt4OWxY?=
 =?utf-8?B?RkVrR1lzbmt2bklSOVZWckZEd1piSncxeSsycDdjRHN0QzlKOHFrSjNkTHhD?=
 =?utf-8?B?VGZ1OGRPNHVYcUlpWU15Q1REWE5JdEx6azNzTDFCNjNyeHJ4czBrVHRUVVBq?=
 =?utf-8?B?RUU1bjlsYXd3TnZ1SjkxUTNrTE4xdVQvL3kvR3FxUTZRMnR0TG04c1FXcDhr?=
 =?utf-8?B?eHc5cnlocWN3bjFJbmdnaDMvZTIzQ2RIcDdkOUdQY0RRbmpyNWkxVnNoWXVi?=
 =?utf-8?B?YjFuSlgxTkgzZmJpbVRLc1FQVk4vLzlYSStKQmVFSnkwNmtmTjUrTG4ya1dV?=
 =?utf-8?B?bDU5T1NoZU5Hc3hSSGdvNUs3ZFZ0MnFvczR6cFJidkVQcTZENlRMWkw3WUp2?=
 =?utf-8?B?aWI2K3NEVlNWWDRtbVhwL2JIb1krMC96MGZnejIyMFVGekRyQzJwSEU4RURu?=
 =?utf-8?B?eEZwS1pqQWhJakVLSmoyUjB2QlM3Qm9GUFM3VjlDT2l2TWtuU09OaUJ1dGxC?=
 =?utf-8?B?NmZwRTFHU1UzN1QxSmpNQXhmcmxwVTNYNWh2QW9tZ1F2OVRMa3RFTXdmUDZC?=
 =?utf-8?B?WWY0cHN6VmlDVFIrL3F0N2lRbXlGaytFMHk4ODhoL204eGRXWHFJSUxFcnFP?=
 =?utf-8?B?T0VBNFh5VmZhS0MzMzdCNWVQQVRTT2RwM3ZEK0cvMTFlUU5pYTJoOGl4R05y?=
 =?utf-8?B?cXRWZDJ1TUNab2NxQ2ZRVUhlM1pmMEF6NTR6K2x3SDI1Wi9tQ2RyQ05CVTRj?=
 =?utf-8?Q?7FrZFc0yiIvht29+SAp6WAgKd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e312a8-b6fd-41f6-697f-08db812c69f1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 09:59:56.0434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DaDiWgAIj0OpWnp5pmRMI2545Ji9XN6T8mjhdbZ0GkGqeJ6TwyMKWiKShsBViejSyQ/dZw7CQ+um/FGYxB95A==
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
 drivers/thermal/rcar_thermal.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index b8571f7090aa..56f3983dcd5f 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -446,12 +446,10 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 			idle = 0; /* polling delay is not needed */
 		}
 
-		ret = devm_request_irq(dev, irq, rcar_thermal_irq,
-				       IRQF_SHARED, dev_name(dev), common);
-		if (ret) {
-			dev_err(dev, "irq request failed\n ");
+		ret = devm_request_irq_probe(dev, irq, rcar_thermal_irq,
+					     IRQF_SHARED, dev_name(dev), common, NULL);
+		if (ret)
 			goto error_unregister;
-		}
 
 		/* update ENR bits */
 		if (chip->irq_per_ch)
-- 
2.39.0

