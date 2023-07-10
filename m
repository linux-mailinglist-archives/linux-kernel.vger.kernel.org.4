Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8477374D2BB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjGJKDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjGJKCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:02:53 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2133.outbound.protection.outlook.com [40.107.255.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A36C1FEB;
        Mon, 10 Jul 2023 03:00:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTUlB+KOaU6nAxL3Q7ST1tNsy6uQJ/eCBLlfwQdO6zFBpz/3PcOxgmQvKx8SCAN+X5WCZQXrYYqrXxA+xCRFsJTEOyZhCU5WJSRK/u9SDoxhsKVymxAPK25G87vdhunuh3Yvs8M6ReCu2f3f1DrMP83rd3Wau/mrF0LBWbHFCPUNVvYdUTxvIjrWuc6lLNvf2rCPmrinPXiFZEzi5HxoZnaKq6y9PZXRwYahtaXPweGJA3YmJFUTzwL9/t3EsrMj7ryOmdyjgGTe9CFEQy7UKFn5DqwUSLGcsbWhWb8JyD6UL+2NkQUMtqn5wNK4fJ/TsU+Biy79yR53eLX3B95CRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/Y+IYV5b8ZmuaTorAO7hsd8tpWaVdkZ+BMEJ54HFrY=;
 b=YdewkdBVk9QI+bnQvStWkjUKsuwsmAYrFNqmKyQp6suaJxahVbV1G4bHRqDQr2nrXIkEMDQMYOUBGIb+65n4oncQDWD5K17ilxsdtpAWltcBy0mCPXeix+DI5yt+Rkz7apKXUVhrM24KrDH1fRZI67OyptoORjqQ28XYgp8xa7MbXuesj+LOfbD72d8066/e7EoDfO4WUebdHuYbiCLO78F9cUrqgRW5GThWrMK4KBNfDnh6y+pEcss34FJjSRHVUtG5lbXQmXUWdul86INFAR8h92faB0A0IreUYkM9/Aj3dCxM8sg+pp8Anrl9LzT+7jxEEfd+m9AtQgwJgqTrGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/Y+IYV5b8ZmuaTorAO7hsd8tpWaVdkZ+BMEJ54HFrY=;
 b=KAowNc7ontg9jtKraywT4Qx8uL4vEscTt9WGtGs6eugThiV9EBESDLnqScbpi4Cy3kygGYdpc7U9TbGgWJ44cMlOdIvzLq01vzCMCao0miYkg4mc/oKt2A6C25mRyxlBacd3dc8bePxWpm/u5RpoCc9sDB43IpL4GvEtNbVWQpAlJV5LEqa4LC423ALhwbTbn36j/UzN0vtwt6Q4qoCW+uduenM0LyUCMgyRz/WyHs7yPLIWDbbrvLqR/j3mw2ibDNvLD2CkOZK7/rXVsDoSef5WZMk8cAYb5jptmemrXEw3OswFGuFYIjTl+kJRIQ+veqPPvybUJFIJJICCPJZTsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6096.apcprd06.prod.outlook.com (2603:1096:400:33e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 10:00:10 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 10:00:10 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/21] thermal/drivers/rockchip: convert to use devm_request*_irq_probe()
Date:   Mon, 10 Jul 2023 17:59:16 +0800
Message-Id: <20230710095926.15614-12-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 633470ad-3920-4b21-3d2d-08db812c7249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AxE+qo6Fg3zfBmsOnSXDefqXP//DrHiHSMXN+jUtncgcpYK+QXi9nZAyPhlY/5/SnxsYF6g4GspaA2iqccN8hczagfx/J3OtZzUs4nZeRTYHTmbE75VvGd54axDHLjgyrj0/9M0JaOZ/3U/5RtDd6ZQv1MrJo7HEha/mPwXLdjNtWLjIS9+wPNBgHXKF0quN300KWdC0ugpYQnIMG2tZM3SsDAp6T7Zq6TOaMAfgtbl5YOqa00zHPvKrdzksfGLm18v333+B0hMU3vonm9uF8q8O4VClc+gvncffO3al5aUrKB/4hb5BoxCJw6aVwiGOuKe18dj8l5bOTZNogo8vRjCH44LDpbuEbORZ/ZS0rCS5u+Sm8MWgtfkTq7i/KGnzDJwUKN9k2ae1OAAAeEMjsO38z3GxgyWIVYkhy+4oj5qHNir3mCO56/hOBt0dr/BL8cqmhOG+GTV4Q/Uk6XwiYnSq8UcQG7bea+7MYWiuK/BoPpB3GJYIGTSQLtgmS9gqz/9CLF8rpeuqRO27x0t74j3dnqq7XYAQJvbt20rYHXBmHksKYjrN6plUMMlMr/v+3aSSE0x2uvtMLZMXnQ2OUzarfKASf+l5xfiMc1APNEKtJ9KBv9b7HoWk9iTz1AXe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(366004)(136003)(346002)(396003)(451199021)(186003)(6506007)(1076003)(2616005)(6512007)(26005)(66574015)(83380400001)(41300700001)(4326008)(66476007)(2906002)(66556008)(316002)(7416002)(5660300002)(8936002)(8676002)(478600001)(66946007)(6486002)(52116002)(110136005)(54906003)(36756003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjJmY1kyaTZqVGpTMjZGQWliWWowV00vYTJMMVhDK21XMTVaMlR6Q0FmMEx5?=
 =?utf-8?B?MnFWcElsUThjNStxSlRkSG5hRmFWTm9PN3A5aU1vbXo2NTlvb2d0Zkx1aTlO?=
 =?utf-8?B?WTM1dnYrZUM3bXVLdTBoNEloT2tHQU5pZG9IK001N0NibnlUT0lhVUgwb01N?=
 =?utf-8?B?cjA5VlpZZHpuaXNDR3Vyc21leHZyRUJhdkE5cVErMDRRUGFWRXlISjYwZWhR?=
 =?utf-8?B?VzZ4dC9qTk9jU1RYVnBBQlFHdDVVUlQ0a1N4QUVYMitMU2Zid0V6Tlc0MDNh?=
 =?utf-8?B?UmRNWm54UlpMUmJDcFlQaWw3REM3YW9CSEVtaEVqckdGa0dEeDVnZW16bkxm?=
 =?utf-8?B?dmFxZ012S3VFUnB4L1V2VzFORlVqWTh0RUp4akp0UGR2Yld5NnI0d3BmOEdX?=
 =?utf-8?B?TVJ3c0I3U2pCSUZSVjF2SFlVaks0RGhxRDJ5WFFiRnVqVGRSNGlxYmlnOEZo?=
 =?utf-8?B?S3FMSmVZNDFuN0lPZ0xZLzFhMktiVW52NkcraFB3SkptRy9QQXNUQVhFUURI?=
 =?utf-8?B?YlRqSWpGV0YzUVZJaWJPbnlnbFhyWUthVXNCd1ZEVmowNkQ0REdtZ3NkWGFO?=
 =?utf-8?B?eVhsSDNJUTllU3dtQjJZd3F5MmNaaGRwc01LaEZiSnN1Z1RLVkxTTXpXcUoy?=
 =?utf-8?B?cXlWQnJldzkyZXVsY0JZb3oxRkVFZFppSnQyZnI2YzM0NCtRdndGUEptNU12?=
 =?utf-8?B?b0RzTFFMbEhtMzJaNlFJMFZHd012RmVZL0FSYmErUFBKeHpOUWNiMEl0WSsw?=
 =?utf-8?B?b0c3UitMSGQ5SGdxbUZwZUJPRmhPbWx3Y3RxRXltQzUvVFk1T3ZBMStnMkhD?=
 =?utf-8?B?cXdPanhNV0RNWHkwY3RhNFpjalJlLzczcUpVWU9PZkQ2d2QxUUdHTERXNEhT?=
 =?utf-8?B?T25FbTUybGNlcFZzY0Fnck9jM08xdjF4YnRHSytHL216YmVoOWdzc2lyQi9w?=
 =?utf-8?B?VU5BTTl5Vzc3RHB4UFpYQXZEN084T3Zydy9NR2thZ3ZSQUpQZzYyd3ZkRU9n?=
 =?utf-8?B?aUpHdnBFdmZlM2hGRFZZUXA1Q3JWcWQzWU5MSWVYWldaV2wyTHNDekx1Yi9D?=
 =?utf-8?B?SEVzeWdMcWhVeFFLRmZQUDRFbnJTYmNHdUQyVlc0VG5jTlVWeDRyd2t5d1Ju?=
 =?utf-8?B?SG5aSEhJdHVvRHdOT0xNdGROMHZ6bWFXK1ZXanhDMVk5NEtIcVNFNEZpVzZL?=
 =?utf-8?B?SkFUYjJ3dmNGTUlRRm9FMUZhSHB1K2toN3VtVVBxU1FHanJvTjdjTjNZbWll?=
 =?utf-8?B?UmZUWjdEZWtsTmM2QnRBbFlVZEd5N3YvRzczUUZGdHFwQVh2MEZzMVVHMytR?=
 =?utf-8?B?dVF1T2hCZzhaV3hwUmFlVFdqTkIzdTAyQ0o2azBCdDVmUXdTb2F6RXJtdVN1?=
 =?utf-8?B?QzBLUFk5d0VCNDlZdENSTS9RbklLZys1SUJQcXkza2FLK1FTbUc2bGU5dlk0?=
 =?utf-8?B?dS9rc1ltS291dHgrQ29JckdMMW1zcUY2dEg5b2tieUZzb1Y4L1ppVlJVd3NE?=
 =?utf-8?B?Z1ZSSHMyNHVZbXBWbkJmLzF1NmlxblE3QUp6L2hNVkNKbHlGYVMyNEhCV2Iv?=
 =?utf-8?B?djZPaGFZcEhJVE0raVp6UlJtaEtRNkI5S1dCRFlPMHZNYjZMeWZ0MjlnUUd3?=
 =?utf-8?B?OUdVZ1dkUmpOTVBHb2pUcm1mV1IweFFYV29mN3QvVXc3cGtQTkJlRmFFT0Uy?=
 =?utf-8?B?VUkzVzAySmE3NlFUdGhvb3Z0eVBXZlRGOS9tRC81UHlaZDVsdmorUEd0d3Zm?=
 =?utf-8?B?NzlGNHI0WXcvTjNRWmZ0OGRjSk9neHpUWXBtOFgwTHhXZGFuOFlYK0d4Y0I4?=
 =?utf-8?B?aW9lUWxFQkp0S2FENXl3Q01jWjlLaDczb3JwcCtGU2IvN1BMcUhBa0VsSlNN?=
 =?utf-8?B?c1MxeXErOGNWME5kTFBrUE1xalNub255UEVSUWlsSlhvYmQ0SzhYS29keXJQ?=
 =?utf-8?B?MnpCcDBrblplaFowbjFoQjFsanpGNzBpTHhUYjlkbU1BaWJkaVNiZnhoTU1q?=
 =?utf-8?B?TDczSEFteHdSUGhwU3dWSHU3dUltUjRCQ3Ftb0pCTFgreHhEN3Zoc2pZK1NV?=
 =?utf-8?B?d1pFb1NKUE5hV2YySm15UFhGeXM3c1ljQmtUelVmMjNMMm1Tb205d1Uxek5Q?=
 =?utf-8?Q?MzMwG1f+9IGQdZlw9lSz/Uvjk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 633470ad-3920-4b21-3d2d-08db812c7249
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 10:00:10.0319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAmOEJ3SLbBPjUXaxIe+KT7JjVT73TctnaZE0BVZMhnWt/zXYGNzx01cyrsLANTyPQshsirp1CPCBdxuUUvBBQ==
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
 drivers/thermal/rockchip_thermal.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 77231a9d28ff..11061f6ef323 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1577,13 +1577,12 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 				"failed to register sensor[%d].\n", i);
 	}
 
-	error = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-					  &rockchip_thermal_alarm_irq_thread,
-					  IRQF_ONESHOT,
-					  "rockchip_thermal", thermal);
+	error = devm_request_threaded_irq_probe(&pdev->dev, irq, NULL,
+						&rockchip_thermal_alarm_irq_thread,
+						IRQF_ONESHOT,
+						"rockchip_thermal", thermal, "tsadc");
 	if (error)
-		return dev_err_probe(&pdev->dev, error,
-				     "failed to request tsadc irq.\n");
+		return error;
 
 	thermal->chip->control(thermal->regs, true);
 
-- 
2.39.0

