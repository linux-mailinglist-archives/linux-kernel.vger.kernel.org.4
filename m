Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612B574D2CD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjGJKFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjGJKEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:04:25 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2133.outbound.protection.outlook.com [40.107.255.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE12FA;
        Mon, 10 Jul 2023 03:01:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDi8f4fhqBQmLo/w1erRj4h0KDlAtdnSYVvIxrxqzZptmLOvVw0oCGfXqxRJT2yMWLHiCk6wFbGmZPHwv+jGf+i4uRzAIBpkOnshebHP7jC1j2C/L2Upo9EjR8nXmfABFuPbSMc9mY2p34D0/6/n5qKPibxngIHOta95yf7Jb1Fh/lBPXuPUaqSl+kKwmjwc3fYidJfbLEcsnAhxrJ2RtJ1OFhhk6l0a4dqjBq9iA1RYZ8cOnsKeGoXfZt5YxfzJhoeXv7MCEJxb+x0iSu1b6Ebcth3IWCmrJYymTzX7X22P/axAke0hBUY3lxFAJI5Ywi4hbbRENZvTzJZse4/9Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+TzYuEeTgIKdnKfQ77B8vedEfB0P2/z7sQrh3Z4zJE=;
 b=jbdgUc597raW8lebj/wdUJpRl7kmq9zg7nrHuiE6i8l/UcLXbrdnlcLBxenKen/FrBPMG0E4yGM8PNVS5D6ISW9oZmr06JoZiz3hVgM3nk4gZwjWSP6jsVeKZZtOg8ChQ3oOlbcP7IgLL6YtxI5kfjz6dA/KogeSC5eylREB7cMYyYPOhJaG/LPqlgDlowfJmK9Ztu8g8rN9swqepz5FDRD2r6GnqLa+9VReUc5plE2jJpm6i4Ucc27hwV1ng+1G+EX2myWesICHHo4ayN2nuchAF3L2cHG6jcSNJPhjzkzczHa5pJCIuMkuKjvQ+UDb24D3ACI50jgQB4us0vkD+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+TzYuEeTgIKdnKfQ77B8vedEfB0P2/z7sQrh3Z4zJE=;
 b=kiD7/uXVMCofQRZRkRX6QdEPamF9JqMfA1ZKeGZh2ReH/s0XEXen5Alpbwi069HZrEmwGNKJ9pGCt81SoCGON/onmU/S5TA1kfGCmYbK2KGEOPeiFbdvooV/Sx3bDYqPNUsGX2yvxDCtFJwB24CYdOS2g1SS6GJpjEKYDenspndmt3yI6g2wlPzz1v4OORXOFrtxc6zjgd5dV+JliHaw37Xpp3aRduUbp3LHgu7aJD9F2It79VEBvZyEpNmzLoGOhTDeiTdWGhov8z7g3Y+nngSEflq3m1K98v/ryph0xSu8DaWpP1upSvOH0FPEWSD3FIWr2sf7ovdMOyFaZJm3yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6096.apcprd06.prod.outlook.com (2603:1096:400:33e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 10:00:24 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 10:00:24 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 17/21] thermal/drivers/stm: convert to use devm_request*_irq_probe()
Date:   Mon, 10 Jul 2023 17:59:21 +0800
Message-Id: <20230710095926.15614-17-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 50708932-a9ee-43cd-aeba-08db812c7a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6lRSknbGh8PmoS3Xny7ElGcMj4BkXGR6wUlGvJFyeGElbaP0+MxuEZVysx+sIgC0Tl9LrAnn2bMHfKSvqYIxDoURVajnmY2KoOUu8mNxcaTe6hgvKy8LG/2RvIx+Ei+wpuYcbTmdhy52anUfS1gVT62LKb397GM9JtBxQzNBIl8O/5rMgvCwUJGkFyn4GUM2+3+qirkqZBdciwPO/9qp4wA4iblD9VoC/DtGU7h/naSkfSnAPCbydxH6EZQLfSlpzIv95QdxsDe73yYndvCXRnWYJYf73D8bdPFtemKacq6w72ysCwpQrnrB5DrOtubIY7pBYN+cNogfEPYvMjilqyjTpcLf0ZG3MMDETrsPKvhGUByvkhDTSVEmK3SvOjJVdFqHOKUAvC+PteSwv0Jq2lkICtH3e6fF+WSCQbbbM4N3PF7/8G3vrtC9kMCen6nHg8F6S/xvlGU+BsAS1yoaqiae+E9CkZ/DPWYsjMtfpYDhIMi3R3T4szfHevmV3nln9xsaDhPJnbqROzyNpRfwnLnrZKPZxsqAqiNxMMAy4sBMScKEqmV1tDcs3DEusA9L2+bd3lCd1ubWgI8H8oNj2HcroyGBUaicMB2it75vLPcGOlzFmKDSI8WhyHH5okEb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(366004)(136003)(346002)(396003)(451199021)(186003)(6506007)(1076003)(2616005)(6512007)(26005)(66574015)(83380400001)(41300700001)(4326008)(66476007)(2906002)(66556008)(316002)(7416002)(5660300002)(8936002)(8676002)(478600001)(66946007)(6486002)(52116002)(6666004)(110136005)(54906003)(36756003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVkxNmltZGNxT0c4SXdOSjJyTUt3K0FLTGp0UHBoZmcwRUFiRGhidGtnZ1lF?=
 =?utf-8?B?RUExV1IxcThramlVYmZEY1l3UUZwL200dytSdFZkaFhKZDlVRW54eFkwdW1R?=
 =?utf-8?B?U3dlZkJ1L3owZDBqRTd1TlNkRGZzY2xoUUVSdWFEd1pQTDVIUHZTcExLTEFX?=
 =?utf-8?B?c1VqbklIQW9VQUVDZDlrZUcxK2ZoOEs3QkhmckZuU1Q0dXJVNmdhQW9vRm9j?=
 =?utf-8?B?WmdiU1VYS2taT2MwTFRzSXAxVEoxRnI5SzBHM0VETlV4cWRaMlc1ZG5mSm1V?=
 =?utf-8?B?RURoRXhjYzk4Rjd5NjAwdlhQbmdQWUNaZ3VyUkxMaTlraE93ZWNIU0IzNFJU?=
 =?utf-8?B?ZzB4NWQwc3lqdnRtSVFFUGZEQVRDWlZ1bkJyTEdlQ0txeG5hVlNybXlKTUlK?=
 =?utf-8?B?UVVVSVcvTE00dTVtalRkL2xzdkYvY0VjZm82c2NLRXBEYXE4aHgyNEZVb0Rl?=
 =?utf-8?B?ZHNuSTdhNHdmUXdSQWNEckd1b0dKckgwYkJBRm1mVUFmZW1JbVl3djdlUFRR?=
 =?utf-8?B?cTlsZmk5YXlzRnVDaVBQWmpOZXVWQlh2OC9PbW5iQUNSNWJ1b0ttbVhqNDUw?=
 =?utf-8?B?NSswQ0wyb0JuZGNyVXpLYkFkU2FxazFTZ25EQnhsU1pTTjdrWWpIS3p6ZFcw?=
 =?utf-8?B?bk0zTVhRMnVEdkZWWlE2Q2FnY3BSdWNlaWsydEtWNG5JMlRzS0lvdTlmYTRQ?=
 =?utf-8?B?bHNZMnUwQkpWVFRBdUtQcE10MC9tRkU5OURHZjhDNUw4M2FsRVNhQzZRY1RW?=
 =?utf-8?B?bWdIcDh1VEdsN0JWSXIrTHlVYjBudUh5WGQ4YWxrSTJWY2pydWNCNmFVSkVs?=
 =?utf-8?B?ZWp3b0t6Uk1ybXArOWdheXhvNGgxa3UzQVRLV3ZEY05SMWx4OTI3SmhGYitk?=
 =?utf-8?B?UGRWTWZhNXBmRzZmS2tLUVFhUVR5ZG9uQ2NPbnkxSjlhZmlIN1hRU2d1Z1ZW?=
 =?utf-8?B?VE5LY2gwMkpqTmZsUWRaeHFrUHE0dnN4a2g4cnErb25kdUNmNWxXQU1LYVph?=
 =?utf-8?B?ckpsemxNZEl0YkJhd3dyYmhYU1hHblY3RzBUeElvY080NFE1cWx6YkRvZWx3?=
 =?utf-8?B?WlZSSXlDZkJkeHYwWFRDbG1ES3pqUjYvRFFIUW11Z2d6SzRkd3ZRRWlabEhB?=
 =?utf-8?B?dmc0VFhtOTNkUTE2cm1Lbjg3aHh6K244Mkk4RmxWWWtsZ0FHUzZUV0RmbXFV?=
 =?utf-8?B?QThWY1cwTlltUlI3SWJmVFZKMjVBQnY4RmtIME9GQWJ3ZE02cFhzTEQzbFRR?=
 =?utf-8?B?eXVaNGpJc1BERm1wVm1EbnpTRnJlL3hDdWxyQXBlK1ZXSzJ1TVpJVzhwcWNK?=
 =?utf-8?B?QVNWS3hQb0hKcmxzTmtzaTBONVpPa3FWK05hOFlRdVhIditRUEVoQUJqS2VC?=
 =?utf-8?B?VDJOeUdlUHoxSlpqZjVxZE9tTmt3cXY2NndvQVB0eGp4RlJoanlaTUhTQTNr?=
 =?utf-8?B?V0V1UEJEQjIxcXUyMGJEQVlRSDI3M1lHRWdzUUdWeVJITk8vbUJWN2NDb1J1?=
 =?utf-8?B?UW5ZMnNnZVlpbHliMVNMSitGaHdPcHp4MC9JWDd0bzcyNGEyQ1hPY2JzeHRh?=
 =?utf-8?B?aDRZVHRnNkxtNjZmK1BaZFZGRXhYbjdSYzFLZHJYTmxXcnY4R1YxUWozRnQ2?=
 =?utf-8?B?NmxhVTN5Y0VmUGxwdWZwNXFyS2hxdkxOWG53ZTNGWGtTVFRiWE9JdzZ3bmVP?=
 =?utf-8?B?WWZ5KytWdjRDOVp4aFQwelRpYlptNXZoZ24vQ0NacWxibW54T0VZRWg1S0Z5?=
 =?utf-8?B?bHJRcy9GWmVNY29Qc05xWC8xUkxMTnE2WnZ1S3NoV21UVWNnWDNlRTRxcUZm?=
 =?utf-8?B?M3VKaE9zSU02NGdmblZoS0dSVFV4cFJNQVE5eFU1ZWFZZFluOTJ0aVAwc2Rz?=
 =?utf-8?B?V1VzaVQrOXZJTVEzOTV6K2FoRitvZ0NYd3BkU2VGS2QwZERSQ2NJOGpvQU4x?=
 =?utf-8?B?Y3d5L2VKRlZBZVg0OWYzTDZUY0YwOXFyR2huelZYbzFtM2lyNm9UaGxGMUxx?=
 =?utf-8?B?UCszcndoL243WkRYeXhtOG5Sb2RUN1RYMUdFOFk5YzBHMGlZTkJXVUFtOUVC?=
 =?utf-8?B?OUNnQVNScVpqU2kvUTlLYm9NcXA4U1ovOW51Y2VyRmcxT081TFFZYXVocy9I?=
 =?utf-8?Q?z9BvNHDcUObq5J4Gix5p9THYE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50708932-a9ee-43cd-aeba-08db812c7a9e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 10:00:24.0271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1M+lcwzHaiTgRP3rY7KrlwAvwU2zQZYM1X5/3OtFwJJIsQ17TrI83qhdF9LdmNb0dN3MiDqEkIIGrxQYHuR+pw==
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
 drivers/thermal/st/st_thermal_memmap.c | 12 +++++-------
 drivers/thermal/st/stm_thermal.c       | 13 ++++---------
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
index e8cfa83b724a..40bb318b5489 100644
--- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -97,14 +97,12 @@ static int st_mmap_register_enable_irq(struct st_thermal_sensor *sensor)
 	if (sensor->irq < 0)
 		return sensor->irq;
 
-	ret = devm_request_threaded_irq(dev, sensor->irq,
-					NULL, st_mmap_thermal_trip_handler,
-					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-					dev->driver->name, sensor);
-	if (ret) {
-		dev_err(dev, "failed to register IRQ %d\n", sensor->irq);
+	ret = devm_request_threaded_irq_probe(dev, sensor->irq,
+					      NULL, st_mmap_thermal_trip_handler,
+					      IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					      dev->driver->name, sensor, NULL);
+	if (ret)
 		return ret;
-	}
 
 	return st_mmap_enable_irq(sensor);
 }
diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index 903fcf1763f1..6a36a7eab9bd 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -387,16 +387,11 @@ static int stm_register_irq(struct stm_thermal_sensor *sensor)
 	if (sensor->irq < 0)
 		return sensor->irq;
 
-	ret = devm_request_threaded_irq(dev, sensor->irq,
-					NULL,
-					stm_thermal_irq_handler,
-					IRQF_ONESHOT,
-					dev->driver->name, sensor);
-	if (ret) {
-		dev_err(dev, "%s: Failed to register IRQ %d\n", __func__,
-			sensor->irq);
+	ret = devm_request_threaded_irq_probe(dev, sensor->irq, NULL,
+					      stm_thermal_irq_handler, IRQF_ONESHOT,
+					      dev->driver->name, sensor, NULL);
+	if (ret)
 		return ret;
-	}
 
 	dev_dbg(dev, "%s: thermal IRQ registered", __func__);
 
-- 
2.39.0

