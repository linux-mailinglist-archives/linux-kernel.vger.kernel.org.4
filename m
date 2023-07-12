Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92950750331
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjGLJdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjGLJdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:33:44 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C46719B;
        Wed, 12 Jul 2023 02:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZBCjqnEKkjqPGZu7mNI5v7kG0tFMaro+G01Dy+pWffww3d9p/ixIqb6paN3c0rxwXFv2+v137RHRZ4FGgwoWy72/yHnoyJ6KHf85sGCZVFWxWCG0qu3VYHMSBODkYWdoebmevKEeK+ig5d4xtH7MNIIV8xdEoSk0LPzUdHPI5kw8sGRAq8yzICIHwcDAaDbUqligXnMQQShE/0S4EW5nFAhNxLgJMGoBs8oLoVW0Ktp/fgelcpbx3oK4MH5UXh74E7yPyjyHoJ9bWaypvXZGTQLHYGgdL09GofrrwL6MwbFSFIVnAwUSal2YuYbGfZ/q38M+nQDRmb7qnOMd9szUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqJOSTWVYvvDD/0geGFqcr4P4Y4fddEKafaq1JUVAYk=;
 b=JKIMn6MPz2aNxoEU5KSGFob5lqTjbZkXWw7I7FyMmi2ebBgB7ZjquUxuxSim7s+1P2raBMPB4pHqvztwwl7R7wRMRTOknbqE8OUyIpc7lkjxd6/8+iP/JDZQ8Zf1/Wii/VE09t9tkSt0AQqjZkfS3BAUALnSl38vC8Zh6TlsExqiuZQWOtxuP7coDR5ut/fE7l7zhnblS6HfI9zIxfvvPbLxXJroiKBhsNpVL5fgXwzaz30Z02tNvjkigkMg1fBsj4uVKCCLb4uKy8G53BGrZprPoLJQHfTkci4e4zSzMRPK+Ftk7PNb1wAH8eraB/h6rup7kXjOaoYsrjPWcCqc0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqJOSTWVYvvDD/0geGFqcr4P4Y4fddEKafaq1JUVAYk=;
 b=aMRTZYaIX9MDOXsPxnC5Y8EkFmgPJaqi1TSLpzZ4zCBg2uJchEZtFchApL1qZK9JwKD3YFkpFj5CjwGXcvgBmF/2WQkqWfTwGFGq8vnstwkfkVXfxrvJ/GgbyG6I9QiXWbExQkk34n8X9RLCT/bAcVEh6bI/vF0AocvLAB6fiCNaa8nHnn5y9tHVkROrism8kImH+Wu+EfAccU16Xv9SQ7/NNtjEwSrCaAoghzmP1JIxfDDZ18gzM2Ucw7ZG8U+ljvu4Imj+bsViPlkfueK7lNV0tnSkGBRJ6i/JPJcgHOzbJScyM1tXRE5A215wrTtcjK8Tc8E6gN5V7uaEUgrLBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5985.apcprd06.prod.outlook.com (2603:1096:101:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 09:33:35 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:33:35 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/19] cpufreq: sun50i: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 17:33:04 +0800
Message-Id: <20230712093322.37322-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0172.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::28) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: abb97346-b692-43ff-67c5-08db82bb1036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KlSF2NlGYaFhyBF7oPR/m5aBn3C2xck1RuvYPvauruVqSRp69wsaMXmcI8oSJiVD5YFBE5i8d6BPBqWxkU2zBvj/g6fzGcagsrMSsgOcMXkpEWIMjf972gJ/zJlS806HCAq2DneBaCAgu8oTP+Rk0qLhlYWGOWEnxvI1wD0aKRudS37oXnSz6fgI4+GY0o81k08FxU66LZEyKdlvuc4zi3z64/fWqeL1tZmT7gVtHgi+HoeEFw/uxygTMw3OV0gwkx7bMbM8/9gJqbYrXVN+mWPOXbQg/vkTW6RQnjfRytqrPj84L8BiGYKYStzttgnxrJ1vqVret+hHCCpkPQUZgIDK7uGiZAkPe3oloQOJ3kI9rfLBaFNCyfRxLovii5MLWQN2K9607HXo9tjooDyZPHGtC8W5h0sHIZDHR6YhjmVBhjeQKkw4ls7PApFCg+SPvDWWkKdNi3Q4wuu2sR2aR9+5hSHwVuUvLXwtsPs0WXhyoFP1NYtmJMNLb1TFUF8rDxpvbTPxWKhLobx6XGRtBMFzmFBtJAvb2+bGHZ+U8Cnzi7fBM/LNmckPSu/fKMNx18OcbsbXKE1lRgnC01GtT6g0cH1zcRtTvlM0eu5hHsPkImjWFADheu5V07hBUYlq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(186003)(2616005)(110136005)(54906003)(38350700002)(38100700002)(5660300002)(8936002)(52116002)(6666004)(6486002)(86362001)(8676002)(478600001)(316002)(41300700001)(2906002)(4326008)(66476007)(66556008)(66946007)(7416002)(6506007)(83380400001)(26005)(1076003)(6512007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkFtMlQzTGgwN2JrcU1BcFhUTVdMSGtPUm9VU2NDVmQyMGdqSzV0NXFhMTdw?=
 =?utf-8?B?cTRnZzJFWjB5bkVMSm5Fc2orVzJoZm9iZkg2ajEyUU5kcWZrdHdtV1kwakpK?=
 =?utf-8?B?aWRlZnhMenFOQjJQQytPelpSdFBJbStna2NFSDczeVlYbVVrYStROE9XdTZy?=
 =?utf-8?B?NWcxOG9yWlU2OFdqZmNJRUJqZWsrdzlQVnJHMC9XdnhrZFBBZVFyR04ybm1u?=
 =?utf-8?B?anpkMWF0OVpTY2dpaHFCSUJHNlZyZzIvRWVURmQvdmx6S2picUtaU21tMmlG?=
 =?utf-8?B?WHJCelI3SWxFTXhRdVc3R3Z4dUhtcUhNWnkzeVBkVUFVTEV6SDlSdldPU200?=
 =?utf-8?B?K3VGR2tIZEl4WXhWdlZWUEdoZEorRUhyZmVJa1gzSjM2U2lZUUMwZU5QZ3lU?=
 =?utf-8?B?SzlkZUNaYnMxbjV0UW9zeDRqOXhwdCtCcllyZmFFVER2VFZzNEFmR292dkJO?=
 =?utf-8?B?R0VrdWhaU2xqQnErNUJ0Q1psOTBPQVRDa25HcmhaRVRDRHVPNko0K3VYRTNv?=
 =?utf-8?B?OG5vM2pLM2JodmwvRnRXSzFvNFU3c0VkT3ZLM1ptd3M3dzB5ZEFQS1FtR0xE?=
 =?utf-8?B?UFppNVpyWnltcmRzN2FFNGg2YmVYdFNLcC9veVFvLzUvSmdRNmUzSFBiUWcz?=
 =?utf-8?B?Q0o5WmczUWNKTkhoZng1WkpFZi9rZlM5WEZxZ2ppUTZGOG40ajM4NC9ER2k5?=
 =?utf-8?B?RTBjRUc1akwvMkxlVkpLUGp0blJQK05ONjVOZEtyVTJobmtVRlBjdzZvZG9z?=
 =?utf-8?B?ZXFRcUE1TS9VQnFjcjZTNTNCdVA2V0x2QmNvWG9RdUphMGFnZXBGaUVJU05i?=
 =?utf-8?B?VTRyWHhBT29UWnFsVVgzRjJIUlpESkcyd3RpcGZ3MVltQ0pmU2ZZcDJTU1Iy?=
 =?utf-8?B?ZTh3UENVNGRDVWZiYWc0bThGaldkTk42bnhub2tiZTk4L0RWVnlSaGs1ajN0?=
 =?utf-8?B?ZmNzL04rUmgzclFUQTZPZDNFaE9ySjZHQXBncENjcnZyeXdubnNLQjBTMzYr?=
 =?utf-8?B?MlZLNnZtM01rM2NPVytDY0wwbFIydXhjNUk4MVdnS01vVDljdjlJTWVxZHZy?=
 =?utf-8?B?UExRNHhKNWtnRjJ5M3ZuTTZyQ1h6d0FMazQ0SWg2d3g4MzZYcU05YzVLZllq?=
 =?utf-8?B?RFpIK3lzejMxTlpWc1B5ei9EYUxjcXVVUjY0dHN3TUFoSHlOcm5oWU5ScTNh?=
 =?utf-8?B?VGJjdFVITDNNcFEvQWFacS9lRnZLaWFrZVJ4cVp0ejFraDdOd1lERnFTazRs?=
 =?utf-8?B?RFNzbnVrOVpLUTFtY1Ntek1vQmN6RTJ1RlBlNSttc3JFOXBvQjdTdi9lbkdR?=
 =?utf-8?B?V01YS2pyREdOSzRuQ2ZOMUdFaGk4N2gvSUtuOHdZR2ZQQnNVaE1hemtVRXhl?=
 =?utf-8?B?OHFwVUFlblcrMURhOHAvdmdYTUptWlk5N25DTnVWOUFMODM1L1JxdEVYWDZB?=
 =?utf-8?B?dDRTYm5mSzhoalRGYmNycTV1VFJvQjF5ZEoyeDJLcTZLdnZ5Y3J2dnByOE5q?=
 =?utf-8?B?VG1KNzNzeGcva1ppaWRSTnZ3Zjg3T3V0SXdaWStOdjA0b1cyUXY5Qmg3dEpa?=
 =?utf-8?B?OE85M2ZZbjRNdGM1dEV1NnNNbEI0M1cxMlVPOFBjRm92WXpCd0xBN2QyaXRu?=
 =?utf-8?B?L3dOazEvUEp5cFl2S0U0M2tSR1JMQWIvZ2pSaElOZC9FK2tHSFRQcW5WNDFs?=
 =?utf-8?B?UHZ2SjFrb0doZXFhTUo0dTNMTjhEbGovSUkyNFc2T0tYQ1pVeVJTZ3BrdmN6?=
 =?utf-8?B?TlBDeWVjSzJ6aEo5dWsveVhaQ1ovNEZTYlFLL1BXN1h0eDM5Z1VYTXBKMUJX?=
 =?utf-8?B?STZyZEZHUisxMUhxeWptQ3VJOEpVa0c5NDFURy9UcVBMYTBiSkc4K3RnWFRC?=
 =?utf-8?B?eHdBZzZQS0Ywb1V5N3o1MzFFVjJQalEzRnlxNFhlU0JiRlRpVGhuYmxzNXdy?=
 =?utf-8?B?MGlNNU5pOVBmRWVGd3g0OWpwMWpTNkNGOGM5NjViQzI1VE5nMlRaZzQxbStS?=
 =?utf-8?B?U3NyeUYrVzR2REVVRHNZdDU0RVY3dVIxbG9MYVVkd3B2NDEyTzdRTjVNZEty?=
 =?utf-8?B?S3BXK1VOam9iSW1iamFxWWt4MmxoSjdJa3NlcDV1SFQ2V2d0bVJzcUtCMkFj?=
 =?utf-8?Q?/BirUUjPkwSvOmA13jRXDYA72?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb97346-b692-43ff-67c5-08db82bb1036
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:33:34.7587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMB/XgQl3/6i4sNuDcRILeYY8dVIgeOlruUIx9vqBi8RToakzs5vjXlhCQMHOoTHkYyz/tyNntHbyxb/jdWf1g==
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
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 4321d7bbe769..32a9c88f8ff6 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -137,7 +137,7 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sun50i_cpufreq_nvmem_remove(struct platform_device *pdev)
+static void sun50i_cpufreq_nvmem_remove(struct platform_device *pdev)
 {
 	int *opp_tokens = platform_get_drvdata(pdev);
 	unsigned int cpu;
@@ -148,13 +148,11 @@ static int sun50i_cpufreq_nvmem_remove(struct platform_device *pdev)
 		dev_pm_opp_put_prop_name(opp_tokens[cpu]);
 
 	kfree(opp_tokens);
-
-	return 0;
 }
 
 static struct platform_driver sun50i_cpufreq_driver = {
 	.probe = sun50i_cpufreq_nvmem_probe,
-	.remove = sun50i_cpufreq_nvmem_remove,
+	.remove_new = sun50i_cpufreq_nvmem_remove,
 	.driver = {
 		.name = "sun50i-cpufreq-nvmem",
 	},
-- 
2.39.0

