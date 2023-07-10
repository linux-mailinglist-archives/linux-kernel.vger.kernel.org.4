Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E9F74D2B9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjGJKDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjGJKCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:02:49 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2116.outbound.protection.outlook.com [40.107.255.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48052D70;
        Mon, 10 Jul 2023 03:00:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZGNGbLWAdsfJQzEsJKK1I+Vv+k99KwfgVRZX637+54ukTIlYM6b0GQIvlfsv/H2+joh67yKUCBVyPsvurBy7/xVcItESOx0m3ExqZCkvPDE1eJTlIs/UhwYFehBnxNfB5jF4DrpC0gqlZAm99JLnFB2qo7GMDmIRScNlrXka5j3dBduDy6RMf2HkHag8fG7ztDqjYZIx9LYzAZ5pYdMAsKjpAB+Vep+MqsAk0T+R4Y0Q+uJr8GcMAmLHeHxFtyPujdovnYcqGNEHGXVNEwkH/V4W7wpbmAvWQgaR/ExIett2VHwi+WuOWpJHBZzI8zqhEO6iC1e9Eru6v+CTQEJlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xb6eS0PaxW2FdVEkfZYti3txNl0ppvMkAmkHrLIDlqA=;
 b=LgfdDn5cI+msfQqApRLJj5QW1t9BCckMraX0NJUJ8Rmw1WIcU3kkGYUhcbAZWmDvDXhbS5qBxrWqqKzPrzbTTg1lxXWft1HHgsTLKTYJ/5SS1iS5MTmEG6PNoZzCN/BjywGvGg/gRliQUxe036qfck8W2E1bbj1LB63a4pbeA8Ndnog3yU7wOl/etoXSKcoHpZ2zV1babTeU1mpAwPIxETI4Zp2Ks7ICoUI0+HpNEES9UctrTb13cQv1ngScRqVHjRNeB+2MRnaC0d82b0ovcikA2ufH4X4hSTix4ZiBTktKBP+kvtFz5T1TUUma1gytv73ecOro5dz03GQZRkDshw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xb6eS0PaxW2FdVEkfZYti3txNl0ppvMkAmkHrLIDlqA=;
 b=opyC4pOFN0xYgdK1N432pz/vgL41tqm+YfRyTu1h/EiP8/ovtJMrLSrkvbMPh+AfUTDgQFmDuJAGUF25gXlGaWa6SuWUpqCMAzqpGgaUfKYYBkWKhAFcqdaq5SwfOgIiA85rBuEktMwKVGwxs2Ul50yifVPGOZ/Zf2dyLqbR+DNCyZwR+VuLsZ0Vhu1opRuSD86CL2lO82jTgYKtvid5xNNRUxVyE97TESZQ7E1cgj/sJHkCUTEsNRCCGJfBtCJVIjfb+zIX6F5t3KCmfpY805hrBIKHOIyMyRNuv4mbCFVxHmGuR5fmf4UeSXpfknjLN6b08LCdSwRRkqK0cdZ8GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6096.apcprd06.prod.outlook.com (2603:1096:400:33e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 10:00:04 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 10:00:04 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/21] thermal/drivers/exynos: convert to use devm_request*_irq_probe()
Date:   Mon, 10 Jul 2023 17:59:14 +0800
Message-Id: <20230710095926.15614-10-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9411cbf1-5cb1-4660-c7c5-08db812c6eff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ojWhGgu/i/UdOo/v3OHWeSi0yBG7NH/nwMhWW6J8kyMTx4VqLOUH82MQRWjWg2Wxdwbh9XXYLorQY9fpjLVmvfWBV7Hh74Z5ApH7px//0XxAmilMPeRMhoSiMtFtuVGCwfcIjuYxSmZQn56mb962hRL/B4FZL24If94AT0/giu/kiYm4qgxWNswdn73XstTVKjAEr43QpWfXZpyWWxAdPMU71noF71LYUCZtHZiuPezdfGg910gAoTOonJ8CNNlZxmnDj8po2cvLOWJL5A/gh2mrH5PjlZEgfrGviBxcvU5NkNX1+HnpcrhRSoLboO3P/mSuQk9BAnH8YvExaWFQCYKNpmPclHLRtlm5Rs9Pb4JBJ87mr+rfHB2ePJxxF7fLzyxW5qsfdnj35hKE38CuZbW1UIy4YuhMEeYAn2iLNsDEBmJlajQvrec0uT8aqz1DEmaJ+e+vURjSdZ/DLS1S22fdN9caxhVszGvNRsOO0XtovFDGMxCuGufcgZi6NOLBXR//jY9nLGuZhOBQ4X1ZkTWdYKhj1dh5MJW7llBkNedIS7XfnoPhyJ2ThKH8Z4u51uHeXKCBBtSWBaNiNJagqEe7rrJcyTdybq1G6co1GEsKA6gNBlDtORtsbKUOuakJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(366004)(136003)(346002)(396003)(451199021)(186003)(6506007)(1076003)(2616005)(6512007)(26005)(66574015)(83380400001)(41300700001)(4326008)(66476007)(2906002)(66556008)(316002)(7416002)(5660300002)(8936002)(8676002)(478600001)(66946007)(6486002)(52116002)(6666004)(110136005)(54906003)(36756003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFdWdWtGWllzbGVGekxOUit4YmU0VTNFSzlMczNZbUdBbGxWQW1JRTBNRk5L?=
 =?utf-8?B?Ni9EWCt3U0V2WGNDUlF3ZTBVNzZSbDQ4MC9NUmlOSG9FNC9LZk45VlpsTGZ0?=
 =?utf-8?B?QjBjaC9Ja1oyS2JhVU1ObkFZUXJpSWxJS0dvMURPcUMwMldBc1JIT0pTVlVj?=
 =?utf-8?B?ZVFhMW5lZlJ3RTg2MkJ4RXZwRzhlQkxzK0hrb25ZdUVHNkEvQ09FSy9LNzNP?=
 =?utf-8?B?enJlU2VRNkoyWGhzTkUrQTBad01hQTlIbS9FLzI0SkVCOWtTZXBIdjNNY1gx?=
 =?utf-8?B?NjNEKzNldDUwUDE3a2FuL1FCYlNFYmFSWW1iVzlFclJuSFpJTDdFMUNObXFK?=
 =?utf-8?B?TVM2UDBmaGQzZkF2eTNTREtuVGlhWVBBZlVlMzR4Vmo2ZnVhbkI0bGlkRWxG?=
 =?utf-8?B?NUFjanNqaFQwMFdrRHdBQ051M1R3MVA3QStkVFhrVzBUeGNSYUpkZU15SWJu?=
 =?utf-8?B?alVnSVZvRUZIME5iWmwzYU81S1RTVEV3TlJCd2h5a2NEVTcvYnk2VFpOZThY?=
 =?utf-8?B?SnhyTzlVT2tici9NVUUwZ0F4OXhMaHI2RnpGeG5LcDBLdGNJMGJSYnhuVmd1?=
 =?utf-8?B?REtKRTJVQTlhUHNoOTFZZTg3Y0EwdkNIRHI1ckhZWEp5Vi9aZURCYkFRdGhC?=
 =?utf-8?B?eUZQamJqc3hHMW5lL3pjLzhSOXVxb3Y1N2Q5L1JNR3duNFNqQjJ3SXFrT0xo?=
 =?utf-8?B?WElJNFhjWW84MW9XbmRnU1A0YzUyb1hERTl4MTlvK2JlTEE4aTVNWGQ5aVhZ?=
 =?utf-8?B?Sjlvekp1QW9Fak5iTDNmNHdaVHZyM1IwaHlBajVydGZLckFoWThLT2hXaGpS?=
 =?utf-8?B?MUFtWHJ4dTBocUFIc3JUTFVnMXMzbVNlZEdWangrMUVpd01wZU9LdzMwY3F2?=
 =?utf-8?B?L0JIdzh1RGdJYzRBcXd0Y3FGV1VmRWxqMHB6MUhDR0JNRURuSTd5bkYwWjlh?=
 =?utf-8?B?MHFKU3BERCtjd0lvTit5UmRFUEd5cW90RnhDZDVzeEtCRnB0V3ZvREt2OEVx?=
 =?utf-8?B?RFFkSGQ4bWprU3NaQzZMazJEN2Y4WFh6cnRXV2ErQkgvTFBrTlRTK3lmeE52?=
 =?utf-8?B?TWNzMG5MK1F2anZUdmhOTUdnMk15VmthdkJxWU1sbXJCYkhLZ0FiQjh1ZkQr?=
 =?utf-8?B?MHVDUzgwTW1iSE1FaFhUT2I1L0tyM3FWY1puR0sxUVlrNmZDbk16T3R2SlBk?=
 =?utf-8?B?T3VjSHB1Y3p1S0dpdHpob083cStBMVFDTDE3OGdSdUtOd21oZU5ra0NSc3BE?=
 =?utf-8?B?UEY1MEJuSGtBZTlCZVZhOUtYMVlaeDJtcmZzY0VkelZaQ0lScy85cUcxZkl3?=
 =?utf-8?B?M0RsWGwrdnFPa1Y1NUpPTzRXY29xdG84bndYb0ZGV2h6cXltMWNLQkg5Z3BX?=
 =?utf-8?B?ZVE3Q25xdktrbWFrWkxYSlFEVTBxWkNDWDRCUk9QT1NoTFhxd2pSWUtTanUx?=
 =?utf-8?B?bkxVNUJsWG9NVjJHRTJpeVNPU1dHYjMzZjluRGY4TjBZMEZ3S2RsVVpsLyty?=
 =?utf-8?B?azRER3lvZUJISExqYXlKZXN2TWJWY2tkemhlb2dxYkRsOHRVVGhtZnhkUnJC?=
 =?utf-8?B?RmdXS1ZmR1FKRmxzcllpdm9LS0tVQjVDNzhOVDh4cWJibVdEaVZZS1BwTlZv?=
 =?utf-8?B?ZlRFaUE4cDNDSVFqMnFEVFRmeWNieEUzN3FMNVRMYnR1ZHhRdEVPMEZCVm9i?=
 =?utf-8?B?MTNhZjd5dTJNelUwMGN3MHFmZjRPVDBPOWgyTzA5aVdhTzRwNmFhMzdsMGtN?=
 =?utf-8?B?K3lVeEQrbzRSdlEyeXVDWXRvSFg0VFVnT3FhV0VjMHNVblJYTzk3QU83RjhT?=
 =?utf-8?B?NWVDdE5XcytESDZIb2E1Ymx1MS9pNVc5OHhzWEhuWUtsZDE4R0RSbDAybHZN?=
 =?utf-8?B?M0pnRjFtQUdiaitVQmVNcHNNKzBpTk1HZkJhdGgydklMc2VoVlcxbUpzQTBO?=
 =?utf-8?B?Q3I4ZHJTbjZ1bzFpemhGcGw0eVBkVDF0bFVibFcyZ2JiL1BqK3NxQ1hwQzl5?=
 =?utf-8?B?NHRKaGhZOE5aakhJa3lRSjI1TytRQnV2aUswaDJXOWRDYk1DSjFYY3Fpb0hY?=
 =?utf-8?B?L2JWMit6VUttTm5raEFuRzFYbkE3clc5LzlrS0Z3bW92R3pmQjJnNi9tM2NW?=
 =?utf-8?Q?J9d9YrmZVcVf0qOZo8A0qDnKS?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9411cbf1-5cb1-4660-c7c5-08db812c6eff
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 10:00:04.5437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtZIFT9FjTuz1y0tN42XEqIf72iw7ZbFN77Ay9ejNF0wWbxMy383uezFuZJD5Ah4Xk5YTn0voQa79Fop0O4o3A==
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
 drivers/thermal/samsung/exynos_tmu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 45e5c840d130..697d2fbdb1bf 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1100,12 +1100,11 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		goto err_sclk;
 	}
 
-	ret = devm_request_irq(&pdev->dev, data->irq, exynos_tmu_irq,
-		IRQF_TRIGGER_RISING | IRQF_SHARED, dev_name(&pdev->dev), data);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to request irq: %d\n", data->irq);
+	ret = devm_request_irq_probe(&pdev->dev, data->irq, exynos_tmu_irq,
+				     IRQF_TRIGGER_RISING | IRQF_SHARED,
+				     dev_name(&pdev->dev), data, NULL);
+	if (ret)
 		goto err_sclk;
-	}
 
 	exynos_tmu_control(pdev, true);
 	return 0;
-- 
2.39.0

