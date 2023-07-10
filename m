Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A183574D2AC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjGJKDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjGJKC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:02:29 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2093.outbound.protection.outlook.com [40.107.255.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C2F2D40;
        Mon, 10 Jul 2023 03:00:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRhCOsyAYjehsYJaK/IRHm02oBue935lJ5+SlrI1061hsbLmpnDGcE+1CMNWgt9TtQ1rOkvkfhwrP3HcS8cd64+6QGdb2JNK39IchxFo8CEO7krnRHHzT92RGGtqWZidtLenFyaD9Gb4lVRFF3Ro2SVoPLyg3KjGHz3ggHlYd9CLdzQ8J8Yxmt1Twk1HskCeEKVj6HoxBk/8m2pB5WTrR5sk6bP/TU9J19xhMIqjXXPd/kILdTg6g3IKGc3diDKE7ee+MiYOyAlTo/64FzoKfJywaTBObNe3HnI++Ml/zq3L2MMj5y9f1Qlc8qOxXikHgiG9DkkD5f/VmQig/WleWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxUuQrEXdZw6IlOKbCkrCo57TBzdecPai0pabWeYUwc=;
 b=dQdHd47kGd02lE/4I3qJc0l2QPFT+AWK0oXQtsWNLRVt4k74oJlOEVHpUr9wmRCEdNIpFDslLbHaAbODxsibAbUniaMHmW+c4nP1RNoFOY6cjEr3TWoeUGIZvSvWCRakubI17oEK+QPspxhZ+gpOnH3qPHQHCxxLSigrpKghyncI4SL68iXPmAZGHFOUY4fHlJg4NzO6n+/3lYVX+44WmwFxhaVgYHKYa3NGozQImIJPxDGZewYZH48xtF4c8ebAlpUwNiTmpNjs7atYl/PbBXGOSM6Jq0inmgbcIrhDQ1umIadQ2iDRLOuivrTI4D2Lfnkwd4T23VZ5RXqfjwHG7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxUuQrEXdZw6IlOKbCkrCo57TBzdecPai0pabWeYUwc=;
 b=NGuRIn7waVLhpRgej+F7sx0o9/p1qQIifo6oDyT+TY5/tPPkbGIXKNiQ8nfmiKu4cgN8rkUIfouAZDYcCqZ8st0e4ZcltTVsscKPxNDvskNyGDVS2HxnysYZHOwtG0i3oksEdHqxhvSON//YjV2NvU8F1m8aLRRGSoZC6EwYOSEI6Ywd5Dm77IdDbpbrqTp/8Jg1+O7aJC46/IyYCc1NcUQScNxbDrzLL3zwFSEakk2FXh/C16t9k7gP2ccK0ULEsXOnJ50OorwLo6YRlZchpeuqYtZD84k63lg60DxyghVujffredArPGlKUyRuQY0prckie5AFnohNP6ca62G8NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6096.apcprd06.prod.outlook.com (2603:1096:400:33e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 09:59:59 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 09:59:59 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/21] thermal/drivers/qcom/temp-alarm: convert to use devm_request*_irq_probe()
Date:   Mon, 10 Jul 2023 17:59:12 +0800
Message-Id: <20230710095926.15614-8-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 04b33123-4244-4636-db36-08db812c6bbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xKe63/FvUfXKdd14k2yPcUgM9Hz5VGoFRKPVmfcXruometSWUMjfXSS9kD0z2jGhQtbqXM1I4Nn0FjKi1ssKdBpzj+/XGYf7EHclxheP+gnzGthldQ0o8Zp2yNWEcyRu4J9kPYo9w93AX2A6Sl3tRWDnM5LFhv4Maa95TgKnjabxTFkdqjRb3Cz9L7pBLZfhffqSGYljjY8czURsgfhEtsb1c36uElnwj10//N91TxF+uANuZiCbUEtYc5nZ0VgMF+shFc6Ux5Jb1m8zmXnjAKM650dRGXgBjr7ql5rrrs+A3o1upE7T4qJoqnxeu8MYNhxckLTIj/aSeEypR5bk9dUDrnzyFoM+2gD2026IsJbfeCMtZhROCqsmEG2Fg9qthPds9RrkxJd/XDahbAP3LDiSFtPEJ0gSJ7dt/YW0zSCUlAWX4ynLns3W6T70ZBJ3IkP2iIFnp6+lh1EqvQj3vWoIRZScctl3KGKuVwdl9affccnyn9kutjaN/mo9KT0eq5Hlh3XgprzdjsrVBLz+J2+BvRCuPn0urezhIO0wIZwH9965k1PKnHuq1vXSzdqaxv5zjc3PFW2kmNJZnL6ZDni0/ifw+nWVINLhE/nGMzSgjFroDVdfKv3ydB0McCcz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(366004)(136003)(346002)(396003)(451199021)(186003)(6506007)(1076003)(2616005)(6512007)(26005)(66574015)(83380400001)(41300700001)(4326008)(66476007)(2906002)(66556008)(316002)(7416002)(5660300002)(8936002)(8676002)(478600001)(66946007)(6486002)(52116002)(6666004)(110136005)(54906003)(36756003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnpoemI2ejlDejFIVTNuSmRIRHh6OXNxbXV2NnAzOE9uL2IxS0NOcERRU0Ja?=
 =?utf-8?B?RnVYV2g4MnlZSURmb1NSOWNlZmZTbEk5WHMvbFMxYStiMFN6ZEtKWHVqY1lZ?=
 =?utf-8?B?d3JEQXVIWGpRODVhTW5lNEJER21abWM4M2E4YnpSR3ZKNjk4RXIwMkxuN2t2?=
 =?utf-8?B?eDVCa2pEWGpYRnQwbVJhVUhnNWR5MG5YcVgvZnRkWjNSdWx2STl3OGo5WVgw?=
 =?utf-8?B?dENjdjk1T1pOU2JHOGRiRzdabW1mVHVRV0d6YjhMWkNralNucm1rVGp4L1Nl?=
 =?utf-8?B?YUZlak5OWTZvNjEySE5XeTZJRklDU0xDNjlIb3pDdllyQTJJVExiOE9jZWZY?=
 =?utf-8?B?RkxaSG5jZWhUUmFlR2UzZ0RURDA2ZmRKcUNwQUJQa2wvemRNM0x3b2pwN1BD?=
 =?utf-8?B?QXl5cTAzMkVNcEhzTGRJeUJBQXlCa1psckxnaXI1QVcraXZMYTk2K2lJWWp0?=
 =?utf-8?B?b2pNL3d0Y0Rsbm5sdTExUm9oN3JUcGc4eEFldEZUcjdUVHVIK1BkMWo2UWQr?=
 =?utf-8?B?aGlNRkdDNkllMU9JTlVsQTk5VWdtUXk2dVBmdThGTCtSSHBQc2d6Q2IrNWNP?=
 =?utf-8?B?eTllOVVBNk5PcUIxdVlNMTU1aWVzclNtbG1POC8rYmcwbFdkT051eFlBMXlF?=
 =?utf-8?B?bGlUVWIxTmRqc1M1S085Z1Q4TldnRzZzQ3ZBQ0srN05WYkpOOVNEaWhvSytt?=
 =?utf-8?B?Tk9VeWljc0EvemRNczIrN1ZTamZXNTNtUTFZenpGY05wMm90aml6aDAwOGk3?=
 =?utf-8?B?K3BUU3g1L0t4TXZEK3E0UDZIODc1N20yaFFnelpkVlVIbkpDYXMrNUlEUFFu?=
 =?utf-8?B?a0x3cHVDaE84V1M5ajhCd3ZpM242YUV0eXA3QnpCWnlJWjJwMEdDNXdZcUMw?=
 =?utf-8?B?U1c4dVpMSjlyZEh5aEFIR3FjUzV0RWZtc2NUZXF4ZEw3ODA0Uk91VFlGNUZQ?=
 =?utf-8?B?cGdOMU5Xa0ZTZHJqemp1RytLa3IxckNYRUdDVHExZXFYelhDRTgvSW1xSEZP?=
 =?utf-8?B?WnVua2VUdHV1OU9wYnNVMHZrZFk0WVZFWmUvRUdRWDVYd2tmSWZVaDNwV2tn?=
 =?utf-8?B?eHlCWk5uYlF4d1hnWlRiVG9INThkUk1UTHVyVVF4R256cCtqRE4vTXB6eU5H?=
 =?utf-8?B?ZXN2OGY0dkF4bmd3dG5uZENMbVV4RTZlQjhCc1o3NHNkREt5N3RTQzczWith?=
 =?utf-8?B?cEwvWVJkbUdOdU0vVUUvc2tyQzI5V3M0eEV1K1NDdzRLODNTcmx2dG9oVU5G?=
 =?utf-8?B?eGNZSWQrRnB2akZ4dFlKKzZHM0k2M0RCWVFQbUJmUG1iUzNIVHd2Z3VrSlVM?=
 =?utf-8?B?YzBFWXpNZzlPS2lwYm5LYjlha0Rma2RiYStUVUNiUU42OUQ1Z3d2MFdKUE9X?=
 =?utf-8?B?YlJCVGY2L01rV3FYK2cxaXVTbEU0L0pLS2Exc2hxUXl6SVFFVGU2eUR1bStI?=
 =?utf-8?B?SE0vSk9lMDgwNjNJQ1YwV2xiRGdxSHJJRHhtTzEyODByWjRDUjA1Tlhkb3h2?=
 =?utf-8?B?ZlhLTm4zUjNXeGNCNmxNTUVxSDVnNnVTV285YnVvcXNtOHVhRkVlbUVJRnZT?=
 =?utf-8?B?cm5LdGFjS3BkNmVHOXYxWDVCdlRlWStnTU9MenEvZEk2RW1JRnM3Q3owK3ZW?=
 =?utf-8?B?bGZnd0NWQVB0Wk83TmgwSjEzM0NsQ0FtQXNmTksrY0lXSWJxYmIrOVRyTzI2?=
 =?utf-8?B?dzJ3L3hRM0xuR2VnYmpUaE81WkRvRzBmeGRBeC9GRkwydGx3Yks3eGxVUk1T?=
 =?utf-8?B?ZnkxbFhWWTc0R01ZV0RTRUJiaG83ejNXZ1lhWlhiVmxpVHk3M1BNVzZubEF6?=
 =?utf-8?B?OTVZNlVvaGd2NGRNU0FsZUZxN1AycnJOSktJSUZNVkM0NXhEcnV6SEd1WHZP?=
 =?utf-8?B?K3ZQWG02dGc0YmRyVlBkL1d1Ris3RExNUklFZmhtVFgxSkZIQ29QcFYwWHgx?=
 =?utf-8?B?S1lTVjhZWjMzanoxbEY0d1RhZU1mZmN0WldhNk42SWoxYXVBY1EzVHR3Q0FD?=
 =?utf-8?B?OTZLTnIwbVIxMWo2Rno0YkVYdWs2SWRHcWRvL1BKczVSYWxaTDM1d0dIK2JC?=
 =?utf-8?B?UnNscy9iZ2h5eHpldURRVk81ZDllSmlzR2pSQ1pOVTRXMEYxTCsxNFlvR2ZO?=
 =?utf-8?Q?FReQgTf8L7F7/BQGq4B73d62G?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b33123-4244-4636-db36-08db812c6bbf
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 09:59:59.0680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6chmFM/9jW1OzGNIug6clFahD9HbdDgoYtbOpw5J7lAOwvQV+m0J2RL/0tk/8a7TNSDwr2nmHbQFdI/Mi/Fyg==
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
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 0e8ebfcd84c5..1b4a7eca181e 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -455,8 +455,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 
 	devm_thermal_add_hwmon_sysfs(&pdev->dev, chip->tz_dev);
 
-	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, qpnp_tm_isr,
-					IRQF_ONESHOT, node->name, chip);
+	ret = devm_request_threaded_irq_probe(&pdev->dev, irq, NULL, qpnp_tm_isr,
+					      IRQF_ONESHOT, node->name, chip, NULL);
 	if (ret < 0)
 		return ret;
 
-- 
2.39.0

