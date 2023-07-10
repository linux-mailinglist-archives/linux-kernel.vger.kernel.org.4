Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7900374D2A0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjGJKCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjGJKCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:02:02 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2133.outbound.protection.outlook.com [40.107.255.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8114B269E;
        Mon, 10 Jul 2023 03:00:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKsLFwy8HMtGOUtAagGO/r4Uae6z/ey9WL9StJg2x+fXyl+lf1a8HNX/a0ZRmD784oYEXHWG39rM4RqyYQHUUGp6/89j6FQAWlXBHY3cIDRuc7fK4mXoMi7PXdCKcmJ1g8mFJPyogqc1FUNh79sP1UelbEsi76k36YRZBJMdqYh+0VhQ4N0wQRyGjpbYGbV+Mi1SZGSuMv2dBUx95jffm5TKZzlyebWfl5j8ka6kKmz3NuIfrV5qF1KFC7gFdLs+SSBPnlEW5zu7t2Js9K6IrZa+iXMcGnR2ZqMetR77mBz3bbvgiOOFQJXKPisLZ+4Qd5GRh17fPbS+dHcjREGTeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D248ne9Yy+xz5Qu0zwOr53AYR//erHJNT+poSLKgvBs=;
 b=UwJa7KF4yxDrWpjJRln7eQX53V7DoVU3eFsGI1E7Jvjfkef6c+pxHEq/Om/UTqXZY/b2WdNcP8Rhjujcs00jTdF2iYXNYvMkG3q/9jItUNWKYKQOTNPdjce0w/gVnst/tlRoAU/VLH2BCN7p4+aVL7csYuJ06S6wJ2ygWATbHNI2cmjiAVpzaq3PzFs5NxRUVQxcxR5FKK/88YJ1XXmhf6k3wFnEncCRN2dXa16kSmdZFawHdGZWFNkFrllDbtyZXqq6ySOno7i0miOA1/GLbbV9GLfZtsUwNrsfDrWnPdSuGXwkIOcd8Sj0jQk1aNIsUAE66hQbZpPoA7WC5eG/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D248ne9Yy+xz5Qu0zwOr53AYR//erHJNT+poSLKgvBs=;
 b=lcMpkALHr8YFEgiMRhkhiSLp7BqPXlQBuG39sFHS/25FB3bqbDqQuPV+jLsDw/8tFJKARQnRZ7N/AOlK0Qqp/j7lfa1x/8KtyBP77xG6TCuBZ5VELQP+ALoPoTly9bF6cY6vXqnggp942r3YGMwgCP7SEjCGIVPp92fHLW1372gjDqmBYMunXkRTupxu60B8Nf3OQvvSQqX/Fxrsp/7QbkHpQ/uJab3gil5iAwDCJX9KRS/CbwJv+puQOSQY4VJNEqcAuku3QlM+LTfNTTtHgEJrd5hOw4GFCP+nV6lR94xQo6nV+/KOL8XvQ9GJq+hJ94rEGbBXkEU8iVKW/bEgeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6096.apcprd06.prod.outlook.com (2603:1096:400:33e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 09:59:53 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 09:59:53 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 06/21] thermal/drivers/db8500: convert to use devm_request*_irq_probe()
Date:   Mon, 10 Jul 2023 17:59:10 +0800
Message-Id: <20230710095926.15614-6-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 67f6c439-3648-43f0-53f9-08db812c6863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sPQa1Sk0D1aV1Fb8cpaCmgb57zgBG7MYKVaBW3/G3j7g3nEViwv9lbBZHYI8gwyHtDUF17Cj12d5c+WWWOWNP2GTGyJTkKXnXwOmBIolN+3gvny0a4DhKeGkni08pM/u5C0OncBACN+4GyVndZL3j//YbIc5y8UlM87cauMePNnCBfFsy9lw8MQwUfXd0nzxsbkC9MFbqwmC8n5hRB/qUkztSNjV5jLNjcjBhmaHSFxtfGep+rmQAnC2B9aPJeQOKf8l+JeEDXREKnHrcMZ1Z9pNVF69AjnF+gPmGw/Gj8ivBvPFH8O5d9Txp8NDuKeBfzsW0wvPrPY1OidWH3qdisBFwthsL5JUcMJnzWmGXsp/h580bSbw4mHF5MewFnUUAjV8hNJBgPdCyXOh19yig8YvheE6KfrZFaiia7rOAxKs2EM9FvQ4642w/UmYNCpa4Mu+tkZh7IFS0W8b2iqY0AS+K3Ev7+bvfvokowToIGxS9TN41aDh8QlUexYsHPO7F3zdbM8Ti41F+S/bzz+rEldxOWllhrbjrMIYKNbWy66wb/gE3EpIRAicbhCrld4b5mboqkkg7aOsL1Y2S0Jv+BDRHEDgaZo0/xfrZ/1I5gJHocGkPX6yIupVxolqA9RF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(366004)(136003)(346002)(396003)(451199021)(186003)(6506007)(1076003)(2616005)(6512007)(26005)(66574015)(83380400001)(41300700001)(4326008)(66476007)(2906002)(66556008)(316002)(7416002)(5660300002)(8936002)(8676002)(478600001)(66946007)(6486002)(52116002)(6666004)(110136005)(54906003)(36756003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEtxSzF5ZjZNU0R0ZUpRK2h4c05PMGMyY3lWN2lOZHN0eFdRMnJraU5NaDNX?=
 =?utf-8?B?V0RQT0VxQ3Urcmh6My8xaUo3Y1FIWlhTQ0VLWWVBZjhKdU55WlBmdllIdlIz?=
 =?utf-8?B?bkE4ZFFqZlBnOFp6VTY2UmVKdUVuY1BZM09vUGg0bjhla1JMYzByVjhDdDd2?=
 =?utf-8?B?WVZjRC82Ujl0OE8wdHRveHFPVWpKTGlKKy9neklRTmVRdzh5b0JVK29mbFNJ?=
 =?utf-8?B?WmdKdGIrK2dpVTVFYmlJU1dUbW5iSi9LYkNGTkpJbmRDb2Rlell6WnFNNVVK?=
 =?utf-8?B?ek1zS0wxeVBZWnJpWmthUjNZa3k4Rkg0U3EyMFpTZFE2R2xLb1hkcUVkRzVn?=
 =?utf-8?B?ZS94SkxWSkFrNzZwKzdab1VXSWZvS1A3QVg5T2MrZHo5ZXdRa25ETGZoZmo5?=
 =?utf-8?B?alpxZ2U0dklxTVI4RFdpQ2V1U0VsM2M0Q0NZSzg0anZaRzBhQlF3dlBuZjNw?=
 =?utf-8?B?WWhkalVpQnYreWl5eUZpdG9QWC9PalNoOEM4QWxEZkVZMzZKZytxei9VdGF5?=
 =?utf-8?B?M1had1pZKzRMNFB3L01rck8zNk1nV3JML1l5b3l5YzhGbXk1am12eFk5Q0tq?=
 =?utf-8?B?c0RkV0l6YTdEY2VNUzRwdjhtQmI0NXJHODBFVzVvWFRrUE9MY3JNMlN2REl2?=
 =?utf-8?B?Qkd3Q2NHWWJQcTFIL1VhNzArTUEyWEVNU3JRWjV3Smt2dDJOK01OOHpEdWhP?=
 =?utf-8?B?WnBRL2FyYWoxVjdxMGV5TUVJaEFhWWUxTTgvYm4wNzRKOFJzN3l1L1R0NHFl?=
 =?utf-8?B?RXNrWFFOMHo3bTBwSVU5M0tNWVhTRTVKMUNpSkxEdDVjRHdZUHg2US9xWStX?=
 =?utf-8?B?MUxNdXFZNnZEUHdhRXRuSkNneHRIbUZTY0NmbEYzZERDWVpMT0RwRWtyOVhx?=
 =?utf-8?B?bW9LblVaeCtoWUZTRlJPbGJ4b0ZQakpGQzNOOFF4VkVPSHZoSEthSm9Sa3Fz?=
 =?utf-8?B?OHQrRHVkQlVPTG1yTDVmQVNScU9RdlB4OUNFNmdkWThzaDJzZzNIOVl6OUtT?=
 =?utf-8?B?QkxueURHcnkvWkp5SHpJVEE0ZGc1NDVTQVJJenYxbWw3aEl6T3F3c2Y1VVAz?=
 =?utf-8?B?SStUakZZd0RDUUhiaW9YR3dQME1UVGRZSzVQZzQrbDlpZTRHT3JEclIvdlZs?=
 =?utf-8?B?M0R2VjBxZ2R4Yjk2eFAvT3JLSU51dnFETFdHV2ZjQW9EM1diRmZhTnBHcUxk?=
 =?utf-8?B?TFc4SUZhRVpabENTcjI2M0hNcTNVUXZtWXV2WHBMWTlSY3I5cVY4eklSL0Z6?=
 =?utf-8?B?dVpibmpXekd1K2ZLL2Z0S1ZCVTBaSkNJSGcrMWlvMU1hTnFzc1NFQitzUTdN?=
 =?utf-8?B?Q085Q2RXT20wTldCUGVZTkVQeXNUWmxOQnJzQmhTanBMdnpGSGF5dy9Sd2xY?=
 =?utf-8?B?d1BiK1NBSFc1UnRQbGFtZnBQcGxkVHVWY0x5MUNQUUJoVjJSdTUrNGNpRis3?=
 =?utf-8?B?Rzl6anVkSnRFTTkwOHN2aWoxYllnWlIxemxJU1ZEZC92WXdVdm9hUU52THla?=
 =?utf-8?B?alVQVlZXN1BSTEkrcnNQWkFmUHRNSGs3eGdhbktvNHFoSUNKSWFFTFFmN0hW?=
 =?utf-8?B?YlBJazA0QzhZSDJ5VmpUMmErYlppdjYvODE2RmhwWitmRy9GRDAybHpjdkNO?=
 =?utf-8?B?TDE2dWNlNFpySlBxR2tsbUdiazRFVW5aVkdXK21LV25FaWpxUDFyN05FNXhB?=
 =?utf-8?B?NTBHbWdxVkxCRXVJdmN4Ym1CTnU2dUx1aEZCRGd6c0FZdnowMFU0OFpOb1Qw?=
 =?utf-8?B?b2pPUkxqQ0dMaUVYSlJrRXVaaUYxd1ErZzFBTTlVdFRPcVdIMzFYbS9adlJC?=
 =?utf-8?B?NkhBRnZBRzhPTzZUU3gwOVRaMmJUQVZXT0htRUZiNUZsNVBVS3A3TGc4TzZX?=
 =?utf-8?B?TjNzTGxkQ3BoYjFNaytZU2FHcFNKMmtrZHRDZEFlL1lDanZOeS9rSHkraGFh?=
 =?utf-8?B?M0hzZmhsUDlNdzRrRmVqNW9MOTNNVFlReFY1ZUtDQXhQTU9VaFZleGYwcFY3?=
 =?utf-8?B?b0NjWHYvYW9IbXBMMUFySU96UDVZcVRhaFlBKzE0aXFOZndvNHpKd1k4OTV1?=
 =?utf-8?B?MWs1YXVNVmcrdmZTQzRINTFHUFhkY21yUVZ2OXRNYUNQT1ZtUFZoaCs3Wjdi?=
 =?utf-8?Q?8RO0RAdlI3YOA6aafgO0G+hBV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f6c439-3648-43f0-53f9-08db812c6863
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 09:59:53.4279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pT2TwrcOwz5e1A/qRP5pDLNXJJUD9p4gqWstf9j5a+2XGtysEkZEgUKzK/ml7vRl/7mOepRs6ovppxUxCDFFxw==
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
 drivers/thermal/db8500_thermal.c | 16 ++++++----------
 drivers/thermal/qcom/lmh.c       |  7 +++----
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index fca5c2c93bf9..0ef8fc2eb4a1 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -164,25 +164,21 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 	if (low_irq < 0)
 		return low_irq;
 
-	ret = devm_request_threaded_irq(dev, low_irq, NULL,
+	ret = devm_request_threaded_irq_probe(dev, low_irq, NULL,
 		prcmu_low_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
-		"dbx500_temp_low", th);
-	if (ret < 0) {
-		dev_err(dev, "failed to allocate temp low irq\n");
+		"dbx500_temp_low", th, "temp low");
+	if (ret < 0)
 		return ret;
-	}
 
 	high_irq = platform_get_irq_byname(pdev, "IRQ_HOTMON_HIGH");
 	if (high_irq < 0)
 		return high_irq;
 
-	ret = devm_request_threaded_irq(dev, high_irq, NULL,
+	ret = devm_request_threaded_irq_probe(dev, high_irq, NULL,
 		prcmu_high_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
-		"dbx500_temp_high", th);
-	if (ret < 0) {
-		dev_err(dev, "failed to allocate temp high irq\n");
+		"dbx500_temp_high", th, "temp high");
+	if (ret < 0)
 		return ret;
-	}
 
 	/* register of thermal sensor and get info from DT */
 	th->tz = devm_thermal_of_zone_register(dev, 0, th, &thdev_ops);
diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index f6edb12ec004..48a14d7e8bf5 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -207,11 +207,10 @@ static int lmh_probe(struct platform_device *pdev)
 
 	/* Disable the irq and let cpufreq enable it when ready to handle the interrupt */
 	irq_set_status_flags(lmh_data->irq, IRQ_NOAUTOEN);
-	ret = devm_request_irq(dev, lmh_data->irq, lmh_handle_irq,
-			       IRQF_ONESHOT | IRQF_NO_SUSPEND,
-			       "lmh-irq", lmh_data);
+	ret = devm_request_irq_probe(dev, lmh_data->irq, lmh_handle_irq,
+				     IRQF_ONESHOT | IRQF_NO_SUSPEND,
+				     "lmh-irq", lmh_data, NULL);
 	if (ret) {
-		dev_err(dev, "Error %d registering irq %x\n", ret, lmh_data->irq);
 		irq_domain_remove(lmh_data->domain);
 		return ret;
 	}
-- 
2.39.0

