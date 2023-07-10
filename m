Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CA374D2C9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjGJKEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbjGJKDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:03:20 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2110.outbound.protection.outlook.com [40.107.255.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6CA3A89;
        Mon, 10 Jul 2023 03:01:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAE2w8x3Gy4WHLvpmjKYRA/8atOxvGzsEshR5sQb8ltMJFG/TbcDmw/Oi7RCaa2XPSLcMdy0lDzcYnPVr6JdJn3HpISLLC/WNppb0xz0UzRkII+dRi/POHrRaLpKxSihWtwSRuw9nonZVicK7vRoalRkpMDAmhN+hb6R2I7wAaxN9F+1L7pqIqYWj9n5yHr3aD0TuXH+LGaZ0rgA8tAzHIb0AX7Jge+yQWWHh6iOSipOt9fi+wy0wxUkWMqTqZvzuX5cz0D5qnKYzZp2rFn0BS3wopeH+Pnt4BSE24HsL1RxzkCqj7iqr1e6X8fVA3Ppx+wcTW8OL1yCwp9ItZ4FUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIbTe94tJb+c7Hut//D6DIRJqgxdHnLzwdkufWRqizI=;
 b=YgzuHLhDny5qo3WJ46Z60KENYJOUM5a/kE9LLplpCN+it1aQuEC0mAWNI9bCowFfo0YI2tpLIpfW7UUN5bmAJbt+1VvtD54zHfNBNk/yTbmJ3zNaUxSYRmfoIntGQ8yPTPiBgF7PHX//GfyT0e1d715SdjxV914iJ4fLltexRcoFqa2n45qLDYZC0v/WnCFZUlRlPcejA/AqDzIczp4SgROUgMnq5eApL6Qmt0WBRGoH324IBnyMUJJiIaTuRo0yi6pu2oWHD6p0cdEwgo6NBMfeMdqX3qXl8X9Z0RcOBBsHVb6DHzjTYgnpsTLGlV73gn2rdTBEeanUcvvbXH8mPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIbTe94tJb+c7Hut//D6DIRJqgxdHnLzwdkufWRqizI=;
 b=XYzPUgGWsLIsbgQ8JU3nI5zGGZqlK2HwSdaopqrOyHPwy5L1ZiMadso3bfvNNcab9pr5ap46KSIo4FhkQoqJs842DwW4jTeQUxdG51jfJNpvov5wjqamfpftzyCOmvD44bNHFn0c7LSJYSss/BAWcaWfEYIwgQ4/suEJmDra2LimhtW1G1qvG6n9gPGaJ2jNWSx3A5raFHgsXUwyhccZ4OHwjmHN+ZsWVQICuptp7OlUI4PKhIIOodwviROa4hsgA5FdYPj/j1j1IL1ZMjAIEGj5oSbuRp8BdanAlAuZg2weaY1sKlZ4iwEb339zJBRE7Wy9k1QrZpcvqaM3D1/ssw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB3963.apcprd06.prod.outlook.com (2603:1096:4:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 10:00:36 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 10:00:36 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 21/21] thermal/drivers/imx: convert to use devm_request*_irq_probe()
Date:   Mon, 10 Jul 2023 17:59:25 +0800
Message-Id: <20230710095926.15614-21-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB3963:EE_
X-MS-Office365-Filtering-Correlation-Id: 111c1420-0d5f-4fd1-d28d-08db812c8218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aaFCJ0GRr6hEhIaAfDsPP/NeN8f0IPCndZLvjGyrzyX1+6U29QLUR1YJre3A2mS7jZn4h5xu0Yv3iCUoNIZAKEk0zWZYu1opBf1pRxUydcAWIpFRC1Zq7RgYdOkNo5zNx3VNc5bxe6zRrR+eeWVElUUPiyioMq0pRnEzMBn9+NAIIUq+1s2Na29msxR8B2MJ6/hnty8Yh+tcnpT8iqKgjhxKsWULhET9Vd85wPxDTdRa58pHM/jLGycgk92lw714SvxehZIitnBovYbhn2XoDH/hfVJw+lxsCj+Z2IMzNjNU1W34sEycP3LEyZnzzfDh2n7a1DP249mIqZ71ULS6/pHBLM2uiT8izUfcj9bzlYMia7V7HfY7sDLN81bwuiqul7neNT+KQuHMEr16UfDVP02ae6NdwpKmFNhNUGg1BkCDDiA9xRZxWoDtjxgbbWPxa13Ycz4gpSnpmzxldaBtgIlNwah/iVUbFobUTBsOqERUNIGZh2nDkbx4UtlT8W0AYYWhzWtdkL6YL+QiPeLGhrrOx4XGE6l0GB1fEuqQ+2Ltmu4oQnqowVFQ9/14/AaEbLz+YwWEs6d1+emT3gxY2t66v7M0HVsXclIVVfLQyDSSDExqr/AglnEYALKCNjVJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199021)(86362001)(38100700002)(38350700002)(36756003)(6666004)(6486002)(52116002)(110136005)(54906003)(6506007)(26005)(186003)(1076003)(6512007)(2616005)(7416002)(5660300002)(2906002)(66556008)(316002)(478600001)(66946007)(8936002)(66476007)(8676002)(66574015)(83380400001)(4326008)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0pvNEx5d212aHAvR24wSGxtSnpVOHBRdGRUZGtQenQ4U0VFeTAwWTlwNnVN?=
 =?utf-8?B?QWxHbGpGd3lMVXEvbHI3NXpkcWJiSS93STY3dldqdERsbFBNaWEyaWRLOC9D?=
 =?utf-8?B?WUcxYm4xampYdVdmTDZIc0p5ejZhbXVmY1UwMHFUZHBlWTgvaGVnMVN5TWhD?=
 =?utf-8?B?TlMrUWRCTUFjMHZoYjF3RERyckI2V25kL2p1aGU5ak42TVYzU3UySFBUSE1V?=
 =?utf-8?B?ZU9GUzBWSXJtU0RXVmdLN0ZOaDlOUGY3a1NFaGpWTEl5aUhqaEN1UkU4Ly9E?=
 =?utf-8?B?SW9iZmFuV3cwME11a2ppMmI0aFh6OXZ6d1dEMXJuT2hhZk1XWG1HTysxNERP?=
 =?utf-8?B?QkRWVjVEc01VVlczMGsxYXcwL0tRdFdOM3lqWllsWktKWlVJOHB1Tjd5Y1py?=
 =?utf-8?B?WkVwUmtEUEMxUWwybkZCeUVyUDJLaDc2TVRFakJYRlMxWEMxbkp4ZWhqVUJ5?=
 =?utf-8?B?REFQN0R0OXFmRzJwcnRvNlRyMGh3VFJiUWFwOHdsWEtWSm8rd2llMnlKQ1Qx?=
 =?utf-8?B?SWhPT2p2bjZrR01ISXJEa1Uzbldha1JnUUNXT3NuSStwdDh6YmtHT2V3Q1ZU?=
 =?utf-8?B?dVFod3VtamdqQUpCS2IyR0UzeC9ueUpkOW9HSnR4QlczdzdpZWNGWEtPbUdu?=
 =?utf-8?B?U0x4ZVFRS25UTDlmOHpoaytnTWtvaUNoblg2aVJxV3B6YTFnR1NOMnpndENs?=
 =?utf-8?B?TE1JRWtCT3NFYW5JT2JUU0ZjOU1TRVRGdHBhWUNDSmhabUhrRTdWeXAyQ2tm?=
 =?utf-8?B?U1VQdENjdHNqakhzUXhVYzRnMG55NjhBNFFObmpBbVdkWW5rTmoyNzd1Nytq?=
 =?utf-8?B?NXArenJnR1pqWkp3K2l0QWdicDh4bERKaFluQUhoN2ROVzAzVDdRK3ZFa2NK?=
 =?utf-8?B?bE10TDFzT3hBb0NGMnhTQzlwN0hUUjNLVFdYMUhOdFNNd2tlMEl2M29XRjh4?=
 =?utf-8?B?U1BndFN0UTFkSVVRc0IvYUNseHduaWtsWjZDWTQ0c1psQU1FU2xiL2l5RnhH?=
 =?utf-8?B?alFNOFhaWjZOTzQrZEl4V21jNE14bVdnNU01alNJMkswc2NKMDVkRTVXVUNU?=
 =?utf-8?B?NGhQS1hwSHk5TkZFa3RCdWkyNXBDclJ0OFBBTCsvUk1LMTN5N1kzNVBsbkxN?=
 =?utf-8?B?bDNsK1huNmpkWUcxZ1BhZGlIeXBHdkJjYy9wNlFFS3FKb3ZZSTVWaGM2SjBZ?=
 =?utf-8?B?aXFRWVZyNklsY1RpeWJYdWFwQ3pwa2t0YURnWHJUbHg2R0JHbmx3YUlBRmJR?=
 =?utf-8?B?VE9VK3lIeVBYZWZaY25iWi9kSmNIYkduZlZxSXZjdm5KSlZ2eGhlZ0xuc085?=
 =?utf-8?B?aTV6OGlLYSt6d2RUWlVmOTl2cHlZMEdUVzNGZTdvaTAwS0FLQmpVbDViUksz?=
 =?utf-8?B?bG1sUXVkb3hiRUdKQzV6L0txSGtMUHVZczRuSjNYek05U0oxd2kzWWx4b1B3?=
 =?utf-8?B?dHBCTks3MWZVdGIvQjBaaStnR0dBY2NwNlFrKzJGUVdmL09aYkozVlRQRXhl?=
 =?utf-8?B?OVhkQ2lQTWl2VjF4RXJGZTZhSGlJSVRRZVZlZ1J0S3I5bGJPcFJHV2RUaVdU?=
 =?utf-8?B?bFZvWXNCNGFXRFhpcG5YZm1sREpCUmVYUUhVTWY3UU5PYzdOdDdENDUwRVB1?=
 =?utf-8?B?NGhuZW5DSm9qL2x6SEZKeVpaTmJPMTJjT1I1YkdpME9IamdFc201QW5tbWov?=
 =?utf-8?B?SDF2VGlLWGlrVURWL2ExR1laSitpaGJ6bnZMK2l2UzZCdWE5MlRma0o3bEoz?=
 =?utf-8?B?aDhTUUdKUjBoWW0yUXB4NXB1cWp2eXJUZXVGM0hPUWNsMnpEWUVvbU96NUZr?=
 =?utf-8?B?dXB1djdDQzMxcnJYV3pLVzRLTXBZUzZFTXVyazlmc0dPdFNFMEhhajlqd1FY?=
 =?utf-8?B?SnhtRWlEV21ZLzc0UjJzSVBQUjZaVzVCYnlIbWZteHUvUGZzU2puNzc3WmFl?=
 =?utf-8?B?c3ZQWHZsUEZDdFNDSzUzSllkUGZGWHJEK3FWWmJLR05BdXRlb3JSNlp5MWZ0?=
 =?utf-8?B?NjNXaGpCZSs4b08rL2Vkb096NjNPTzhKY01HWFMzbGw2TGlOdTFwSjZ5aTdZ?=
 =?utf-8?B?U1ZRQ1RGNlFUeHJuUWc1cWdVR3laOXBycURtdW4vUjhkeUhVbURJbVkzMVpB?=
 =?utf-8?Q?pPCyDFAYxqB2bgulsgs5FV8h3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 111c1420-0d5f-4fd1-d28d-08db812c8218
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 10:00:36.6174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cGO7Kwv0BXLdlMBL/xtRPe55oefXmKqxUPwmDA94Aw9tttQH0I4Mw31/DauTr1HOWvRYh/awEi6YHVgzva/pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3963
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
 drivers/thermal/imx_thermal.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index a94ec0a0c9dd..3131a09f9906 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -746,13 +746,12 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	if (ret)
 		goto thermal_zone_unregister;
 
-	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
-			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
-			0, "imx_thermal", data);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
+	ret = devm_request_threaded_irq_probe(&pdev->dev, data->irq,
+					      imx_thermal_alarm_irq,
+					      imx_thermal_alarm_irq_thread,
+					      0, "imx_thermal", data, "alarm");
+	if (ret < 0)
 		goto thermal_zone_unregister;
-	}
 
 	pm_runtime_put(data->dev);
 
-- 
2.39.0

