Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07B674D2BD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjGJKD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjGJKCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:02:54 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2132.outbound.protection.outlook.com [40.107.255.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8BF30C3;
        Mon, 10 Jul 2023 03:00:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ef7+ROMWTh0e4sr2VXfIANsLrTmgoxScVa5pBQfiVB+vWFS5IpjA2xDfJkImt2TnCspqG61HYHGW1DDn4W5ICisid/VcQ6QqFbDcAywqEthtYyUbvnsQmH3uALZzh4djeZ2/pMoA3vR7u7RaQT1VmAHvWO6+PzLmj99ONTCZZ5LCu43l86dpV5Y8yqk0rBK3mJaQwTsEVee4BpNMqbTTFnoi5e1ktCCVq8SOGIMzjia1S8D5YfkkEPbQN8g0vPsAjQjbF700O8SgSypmX1jezyqqBJctHiLvPLPZJuCZpgYLCsTg5Y/lewqLNhkG26TFcpYtLxKFwEccSdlOOV20Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsmcWgX7BL4IwTWY9lLTCwHJynqqmrmN/xhM/6pg+KY=;
 b=EC4uu/z6rWt8MuwCs/STner4iglHL9/tRIRoDJmin/CBOqBDK5/iZ0QlcdtEEaXJ2YuMVoL4lmip2/S95AIO8FCCdczTdSmYZwmLEAVUJ9vE4zQblLBPxpp/APR/6hhc3cl9DJ3FAhmR2X3theAZiYJ0iEHv3tbiVQY44B3QAVaJJz6t97UsX7RkaGpcRysvcaQxLMnbMW5d6u0tU14+PizqmuPZOlIagFDy+8TVLnLJqPtlgm6tWRsoz4qYvmoiQ5ODlH15RQieKBBoAyLhN9GpdakFARV/xNSxWHcmykZuChnUlsLiy/ivQEnwaQ7g4ROqwRFQX+gW0i2zGKKpSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsmcWgX7BL4IwTWY9lLTCwHJynqqmrmN/xhM/6pg+KY=;
 b=Npugu+Vxwt5SlIZiAtnGDJyCr6YDjxPvPnY8gUwJfbYh5y4CEeolzlQzseqYcvoIHk3RT4QvNeBZm7w/Lmrz+bRL3SmInu3NkGoQ3dKsqOtYJr9MyV5C/qVhqzYPSb4AagB/VdpKAag0JPtdq4EXNuh6hIo5/JcyeszBvRMkAQ8RQXmMeNmQ6tqtZn2WEjCg8/W1Tom8yaYQVC4jm/qfQIoFSf+oJ0iAFj5uf7J9Z3eYF97Z2q3uPd/EKqzg0hsKrydXjlc/NFnPo64LpnIXH8c8P4dmaO6L6uHClPxEwzczy7y5lu77lEFd+SR4zIBPvkmLEqlUYJx5qGTADJbQRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB3963.apcprd06.prod.outlook.com (2603:1096:4:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 10:00:27 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 10:00:27 +0000
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
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 18/21] thermal/drivers/qcom/tsens-v0_1: convert to use devm_request*_irq_probe()
Date:   Mon, 10 Jul 2023 17:59:22 +0800
Message-Id: <20230710095926.15614-18-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a200bffb-c02f-4319-be84-08db812c7c6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iby14uBnVuIKpNoO96hqE77e78s+OOILCK471xzopGgkhPAC/Vzi1NQgUEIr4itx9cBt4IwnnFgLfDEiSW/ezFR66XEYANTVqVF3IN8C0CPiEi7Yu/SCP06SQKzkTd7kO+qLGEdBo6FyErdCB2jXeKvTPZUSh9mv9pADL7xUBMPpZ5WAwS3M0XGgF+SGuegfjb3U0LHolExY6Uii1+au+t1rCyMJBPfLkRi7GjAr9SW6m6mgq0J8GuREakdgWY5MJTdAVVED94eoHmmXc/7dYwd82vMRH8B5xRJ20M6ljuMEq+x714k8uGwISzfCQDkGJefUA/yfsdFJyTLiI95TlVEuV8yFgaR0TkEMl93SPDdhR9lxC8ttfEkq483gEAit9RBbWAFTJ3tfRVcbqKltwzrIp+WZGF+P+xu/xaLeEtkHVXLGW10gII+9E5rfO9zyElkbciG1LmXD/oV/o7i5eA9EQCAs2dJib+EOsSs4AJesDpw2J4blAhszHVF7HcyYz7lOkRUuff0WvnDRMUQsHYvd3Rlv9AxbvX+2/dAQR2DSoBqbEzzmA0uxHdT/LGSGH+ODGfMDpPhDoi1npNi12QrejvLQ3aPvumGucS7ms+F8dT73i3jFhN+kXpHBHTTi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199021)(86362001)(38100700002)(38350700002)(36756003)(6666004)(6486002)(52116002)(110136005)(54906003)(6506007)(26005)(186003)(1076003)(6512007)(2616005)(7416002)(5660300002)(2906002)(66556008)(316002)(478600001)(66946007)(8936002)(66476007)(8676002)(66574015)(83380400001)(4326008)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlpXYTRIVnM0WHY1N0xCWWY0YnUzNGlHUm9GaENXbkhYdkNjSE9hU2R3aUJS?=
 =?utf-8?B?bTU0UmRkaVJMcngvdm1vT1V1ZVB0MGVQODIwWjNWdjdYZWF0NjFrWDVHQThW?=
 =?utf-8?B?SUg1TTNQSm12aWJ0Yk8vcG1vS0hIS2p5UXZmaGRQTTd5S25rdFl4cTlpVW1z?=
 =?utf-8?B?RldzL0lSRFJsVSt2ZGV2WGVka1JFYXFEWm1pMVRTRWZzeEpOWUwwS2NXQk93?=
 =?utf-8?B?bk1rUm9ZYVB5eC96NytsWjViTUU0RG5TYXUreTZzZW83RVFMZWRnTmJhcEZo?=
 =?utf-8?B?bUR4aTRQUWNZeVZQYTArSXluc0VpeWtrZ25ibnlNRml1TGdXWlJQZDVFOUVV?=
 =?utf-8?B?WXVmRjZnc3ZYczhJbUtBbUtZQUdGSmJ3dFBKbHlKRVJEdmFqNEo5cWdQOGtN?=
 =?utf-8?B?ejBOR1hwV0I2cHRLUm9WYy9tWGdWZWFsME1UQkZMRDFnaUZadEYvYVhaSG1J?=
 =?utf-8?B?Ukl4QlBDb2dDSWJlYmlpUzBEa2RYMFI0SlNWMExiYlRuUlVKaDRUWjhSU1pQ?=
 =?utf-8?B?WHlwY1o3cmMrdUJmdTV2UjZaejRpSzBpaTlqSVczWTFrTUZ3bG1FRUhsbXk2?=
 =?utf-8?B?S2FON0l5eUxzRWZYZ2hJOTFneDJ6UGloREtoZnFTWExUSkVNQWJ4bXcwaSs3?=
 =?utf-8?B?OEFaVTQ4eU9sSHBsNTlmd1BTOWRXV05xY1VaYkMyd285eTQvTDZ1UCs3Mlpn?=
 =?utf-8?B?YnFBMnhRelc0NDQ0M3VjYkJpRU54T3pLbFhTbzIrMktNek9oL21XeUxKTjNs?=
 =?utf-8?B?cXZ2S2t4ZzZUeUZTOE4xVW9PZEQzeVN0RTJNa21LNDdZRWJJWHMvWkN4eU5E?=
 =?utf-8?B?TlFETG1sWm84SVJQaGRxSnhScjFhcERxSWxybWlFeXo3VXJNREtMQlYwZnRV?=
 =?utf-8?B?cmdnVFh6MVJ6ZnkvN0JGZyt0RXVDb3dOYnc4eURiZU14VXFSR3BURkZKQ0ZG?=
 =?utf-8?B?Ty9LVlMxbExjZkRJUEdXZVY3T2NqcnRRTnFyNGUzNnNNeCtveWFLWHhha1Rw?=
 =?utf-8?B?UkFoa0lRVUNYMzBicUQxS0p4TG14dzREQVBtaFdGdGZDQ3BsRDZkdVJ5ZHE2?=
 =?utf-8?B?Q2t5bkRieTNlZjNuMVdMaTF5VnBUWlA0TGN0cCtycXV0TGRVeWxtb3JZQStx?=
 =?utf-8?B?YS9nZ3VmNHZTT2V5cGNvZERuSlo0WldnYlR5ai80clRkamFqYUtsZE55N3NV?=
 =?utf-8?B?aU94a3p0UERGRENVZTRwanV3ZjZXWklWOVkwWU1GSXlOK0szWHY5Q045akhi?=
 =?utf-8?B?NDRmQmthWmE0cFd6NE13eFpqWXBKeXZsdVlXUHhKbG9zTXZKcHI4bitEK0oy?=
 =?utf-8?B?Qi81dUFlbHcwQStvZWRtVlJqQ0VPV3J0bTkrUDdLLzVpVGFINFZmbDFNTHBW?=
 =?utf-8?B?K3R5U1JCQkxNQVFlMy95TVRLUzZmK1lqTm9na3hPbkxScTRGbzZ4dzNNWkQy?=
 =?utf-8?B?M0lYQnFCdXVyT3JVejQ3VldyZ3M2U2k0clZZeUI0dG85ZGZLQkJoNDlYUVFv?=
 =?utf-8?B?QVc3MjlwREREN29IeTZHei91dkIrWCtiVU5GK0NyRnJnYWliOHRnVXZudzE0?=
 =?utf-8?B?dTE4WTdPMHY4Z3NHZVBkTTVaZWovWGV3Y3loT2RjQjJ4ZUZ0RnJBc1Yva3V2?=
 =?utf-8?B?MDhIdncwNmgwSUd4Mi8xSlZWTTJCL08xRUdNSWVTRFQrQ3FNVXBkeTBJSjhp?=
 =?utf-8?B?aUFDc0NQSWZ0L3dQc0ZKU2JOYldZZGRTRWFaeG9BbTVibkdOZlNKbi9ZU1Ru?=
 =?utf-8?B?Z09jbWVIdWJWVnZzOXV4UHhrRldBUmRTLzRNMEVtTVV4QTJzb1JibjZQbFB5?=
 =?utf-8?B?M2RVWG03NjRmdGZzWHlydjNld2hyenJod1ZmWTErYlBkZEtHNi8wRUh6L3JM?=
 =?utf-8?B?SUFuSS90VTJKSk8yZTVuNE5SNmh3TXZVNGxnWXJmeE5WTUhaaVMzaGxHdnR1?=
 =?utf-8?B?OU9nKzRCeEFHZzNEMm9udWVoVXdLc0ljSW15bWtBQkVZcUlid2hlQkp5YkxN?=
 =?utf-8?B?YVhyUEFUQXovS0xLbWJ0Y0pnWDRrbk9VUGFxdmVSRTlaZFpuNzVqWDFJL2hL?=
 =?utf-8?B?NDNlcWV3Uy8ralU4TzJGUjFpb0RUN0lSb3pYK0p0UzI4R0RrUHJHd3ErSjUv?=
 =?utf-8?Q?mCa7WypLSVggrjFfMrW2Be+lC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a200bffb-c02f-4319-be84-08db812c7c6a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 10:00:27.0495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WB6MutGmOVom+xucUq4Olbw6uTg9admGaKyHtx0tPgBtAfZ1jbm4BWJ1HZ/iSj7qWpV6Nm7uk/1BaUAckMT7CA==
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
 drivers/thermal/qcom/tsens.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 98c356acfe98..d4528d36c085 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1171,21 +1171,18 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
 	} else {
 		/* VER_0 interrupt is TRIGGER_RISING, VER_0_1 and up is ONESHOT */
 		if (tsens_version(priv) == VER_0)
-			ret = devm_request_threaded_irq(&pdev->dev, irq,
-							thread_fn, NULL,
-							IRQF_TRIGGER_RISING,
-							dev_name(&pdev->dev),
-							priv);
+			ret = devm_request_threaded_irq_probe(&pdev->dev, irq,
+							      thread_fn, NULL,
+							      IRQF_TRIGGER_RISING,
+							      dev_name(&pdev->dev),
+							      priv, NULL);
 		else
-			ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-							thread_fn, IRQF_ONESHOT,
-							dev_name(&pdev->dev),
-							priv);
+			ret = devm_request_threaded_irq_probe(&pdev->dev, irq, NULL,
+							      thread_fn, IRQF_ONESHOT,
+							      dev_name(&pdev->dev),
+							      priv, NULL);
 
-		if (ret)
-			dev_err(&pdev->dev, "%s: failed to get irq\n",
-				__func__);
-		else
+		if (!ret)
 			enable_irq_wake(irq);
 	}
 
-- 
2.39.0

