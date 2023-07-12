Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C68750342
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbjGLJeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjGLJeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:34:13 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891311734;
        Wed, 12 Jul 2023 02:33:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3Eef4wlubdq7M3IIBu9g6uWC3uEwOQOl2UmkzvrCBH570DIiOQW5ePBT6s33BKbeKmCMKVlE7MaQ/TQNbpmaLAsUMna5wAlEorqnMfahdskYElYrlZu/wHk4rmh1kjvLIq4vZOU8NpUib9nzl44PHpok+QgA+tk/TY6s7bhhrnK2jlxaT0mxQx0ugLyWJMTjP/UA2a+jgVkDLrGIiGEsN1qsklj/KfULRlzA2ir7ugCNJAlgDLxyOyl9bLjIOvob+xViHMnSllUDZ4q4e4ceWG19SuaPJRhjEl20NCpGjqPBM1SHPk2YW5/QeC91nRg3NrPfiE7P8QdnlqQqENgdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iay+IBxV/Yg8sWs5F5S9FoVE3oZ5N68RmY8kEJqwsKc=;
 b=J39KxLpwzmdf1F0iC3bPZHX8unmtS2ZGmVba+08CK+dFFlsOZswsYmueoG2zhXpdUUrZhROeKNqYxx4m62nD1hc2Y0lB+5DDCxW8/Ibws24LfcS8qwrtnU8SmxbVYYuibVZy9ieSdj0vfKUBB74W+7o7AKRDD2FS/QHiJdQ/4ybuebOXhZQNwgMStC4T10aObYNWTS9s1fQNeP5nWEiOENvA0fH8hwb3nxNwPq8xTj/Cii2qZ2Cty4PA/RgbZ8Ydppbi1iwTrObH5WqlTyi2gnWVG6CrPBlb7CdJoaMHgGmz8nAwYbBb7g+DUR50NyTtctWvSHe6VhZTPdMw8atebw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iay+IBxV/Yg8sWs5F5S9FoVE3oZ5N68RmY8kEJqwsKc=;
 b=fiGkAM1986+i9vmN7T6QenvY4SqYegFHYs+FW+WApxwnUM+41mB7ul2Z67YzxyB5v0lq0+iNc7UYcEHQhwyKdWysfpElzi6MQ6FqWxBUyaKzzM1Qy6+VtIR3/D+gwZRSMZcbsiHR5KImYGHHz5zynXzEf8RhbZUkGxPGc1Sey8S2H9ZyIPPc8E/Al1ZKFa+W4lQ82QZyfnSfHrh1X6eWIPe0kD7IRk0tQbE6Zmek1xdlwgdUtkOmLotFhynEyZBqV3DuYVOQ1BVH/7t494UQhzVg3LJLoE8bGtKBtPbFhHVTDCxCvvF9wQfbNtalwzOkRZXdN0FVzvBbwGhwCe0/eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5985.apcprd06.prod.outlook.com (2603:1096:101:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 09:33:53 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:33:53 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/19] cpufreq: davinci: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 17:33:14 +0800
Message-Id: <20230712093322.37322-11-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230712093322.37322-1-frank.li@vivo.com>
References: <20230712093322.37322-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0172.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::28) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: aab5a0ca-a0c7-460f-c2ad-08db82bb1b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zrXVH50nQuOD0TvGkc2Rvxd3Ko5HqZ8Z/Ub6u2Wg4bSudswEwS91pJLzHpatHFLnvTQKMIuw6k2pXa+C6Id0mJCkfY+twML9mkwNXcZf9kHpAJ57SQTD+CDCj9yRrkWUY4tVXTi+nX35KwUJX5S15ZpWo+5wlx+23EwwvUetfHxmKOkR1VaK6R9SPkim0dZPtjz6Bb58X3PZnmu7dITJh5yJxPX7qflM34pm9rK1t7ZkvKv6tw5iQ+m5VfmJoPpTpCCQX9kN3LEzXD3MGqPatllwKoPe+Ua/1gqCbjh13nQmgd/YOioBypzJbfuxnBfr36d5/us+fBt7UNVn4ER39IeF1dZDHF4lq33hRLC2pwEbX7i2FeCPa79E4C4U0u3ayZqAw1Nle1ldWUujKd4GH0/Iza3GEBW5l/NVGB5oAok1iMAId963cnJY+TMWDhPLjYze6qUQCDpqykNcU4IpdJf5nEEeV08dhWhICuOJkIWAr8ce6MJdw/UVyxuAbmEyC0bpMziWcZKJ+SsB4/AG4ZNiY5q3XwsDvSL/BNSlpKtXibrZuuMC6gKvjOIteptkFiDAk61XorpbYz1mJjbM4x/qdBKxXfL9X/9xvPr7B2IhjJsjwrlSKZEQCVDDX3JE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(186003)(2616005)(110136005)(54906003)(38350700002)(38100700002)(5660300002)(8936002)(52116002)(6666004)(6486002)(86362001)(8676002)(478600001)(316002)(41300700001)(2906002)(4326008)(66476007)(66556008)(66946007)(6506007)(83380400001)(26005)(1076003)(6512007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1VkMC9Vcm1PM2hpY0NUblF6Zm9OeXdjWW8rN0JFVldETGQwSTZ3QzZrenE3?=
 =?utf-8?B?bFVLaFIydVRVRFZIM0ZjeUZvcFVJREZyZXpxdElwZTByVFIwR0craWhFSXhw?=
 =?utf-8?B?bWZZQUU4Z0c2YWVaVVFrcTV2WEJaaU1hVFp5VDJzWUVoQU56SkR6WFArbVEv?=
 =?utf-8?B?dW8xVGxLSTBSNmZvZGpoM29kMTRCcCtRamtvL3JRMnVOZVZpMUcwT1Ixc0pp?=
 =?utf-8?B?UWJRVDJBK2Q2eXdqWGZ2cklKWVQ2SDl3SEZRL2Yva3pSNUpYcGwxbTNaeUJn?=
 =?utf-8?B?QXdnVERXeUxlVWVoWVBEcUZLaFM4dE93MkRSMmREWFJnbWdtVWpGenROZ0pJ?=
 =?utf-8?B?aVR4UzBudHc5SXQ2ejdzaFBoWDV1ZXFFUkd1RHhoZ3pMTEtWdnR6MmhXeGRp?=
 =?utf-8?B?MkJqYWhLOFNINVVzOFJBaUNBbjZ6ZnFWR0F5YnAvcTdmblIwK3lEWUhoVVQ2?=
 =?utf-8?B?MDk5Q05IRWpIVlUvbGN2YTlwb0hWTXR5YlhvblIrQng0M3JibHhHZVBTb2N6?=
 =?utf-8?B?blRZRk0wcHZFWVpualI4cXBXSTNhdmpOVlpTMDkxbVhMRVRNR1JjdnErdWMw?=
 =?utf-8?B?UGduU1Ixb0hQM3dTUXQwK2RwZ1FQNlI1UmcxWkw2TkFTdDNRbk1NZEhwYm1n?=
 =?utf-8?B?dXo5WFlBRHZoMFN6aGgydkhINDA2MEQ4QUd0elVnZjBWUGlPTDcrY2xIYjY5?=
 =?utf-8?B?OTIzNUgxaTV5WmQ1eWhrdFk5ODAwNURZOUhYaVFrc3NQNG1MKzV6QXR3QUVn?=
 =?utf-8?B?ODVXeFEzQzZ2MlBiZmc2NDh0VG5UMGlWRGZFd21KNDFlMFRvN2daUzJMUjFS?=
 =?utf-8?B?eTFrbUxUdnBGNktuYVhDWVlIVWRnYlJJRU1uSjZwbnBPSDJmOS9IbXl1Qlkv?=
 =?utf-8?B?eEYyNS9wSHdIVU9tMnN2am5hRTZrQ2ppbTFVSks4ZS9LZm4xQWpsU00vblB4?=
 =?utf-8?B?Q0t0L1REM2pnU3E5TmROV21QVm1ITGkrSjZ5UEpHOEVzcXVzblJjK1hsZUpR?=
 =?utf-8?B?MTJnNVVaSERvWUlLS2lwQldBTlNNY015MHZIc0t3MUVQNjBVWnJiVlRLVjJL?=
 =?utf-8?B?eFJEMnVJb2NULzFtSzN1RlI0dW5jZXNJYkJ1N3M1OTNkR1NiSjFCaENZOFA4?=
 =?utf-8?B?WERPd3B5L25vWENMWExZbHJCSzY3T28xMnVObTdSdFRLdUlWaisxcEFWN29Q?=
 =?utf-8?B?bXhpYVVIOEtZbVVGbTk5M1ZGUEkrc0ExWkx3QnRmY3VONzE2ZlAveTQwYW5R?=
 =?utf-8?B?RlMyOVBCTk5zdVo3SnIyZUo2bUZ1V3lJVzV0U0ZsL20wWEUzNGtUWGdadWZV?=
 =?utf-8?B?cnZmeFhId24wVUJ6NEJ5cUVnRkhER1ZhQW9yakFSMUxkbE1Rd3BNYVc3MU8z?=
 =?utf-8?B?dmRRMjliYVpuVmplNllzUXByMGpJN3N0SmMvZGV0TTM3V1dTdUIzc1NYOWEx?=
 =?utf-8?B?YUYrRmo1elJ0UWVvQUlUSWVZOUo4SGxWWFhGNFpvL0h6U3VHczFaQnNOYjVt?=
 =?utf-8?B?eDBwVUNQR3JTc0FkSVZPY25XZ3hqUkdCc1ZmVFg3bjhUcXdIY1ZxcnN5bC9p?=
 =?utf-8?B?dHE0dlR4alB6SGpQSUw5VzFTRkJzcisrU2oxUEwrKzQ3Z3lxNmhqVXpVRTc0?=
 =?utf-8?B?Nnl2bVRkQUZlQTM1Ry9ML0d1aytjc1BOTFN5ZkJXRzh1NmNhblplTGR2cW1M?=
 =?utf-8?B?ODJXa1Ryek5scmhGeFRyTUtkMkl6ZHFGa2o0K3FJRW1LcVdnd1pYczdJUFM3?=
 =?utf-8?B?cUFNYTQybkpoQnNnNUtkWW5qM0s5TUFDZk54bU1vU2MyZUtUYmhjM2ZQTnlm?=
 =?utf-8?B?ZkRLN2Z4WWdhV3h5WkErT3VvZDF3cDcxTkxqUUN1MWgzWEEwdm9nVDZ3T1V1?=
 =?utf-8?B?N085ODNzMmsvQmlib3RBVjhSN0ZJaW5JNXFtSUlpUE9QNFIySmtnWE92c0RP?=
 =?utf-8?B?ZVhBOTgwQ3BMZ09Xc2xRODJVL2h2b0pyTWluQWFNVkgrUUdrd0dLc2RxMkhs?=
 =?utf-8?B?L1ZCSEVJdmxyakhBRDdzMXZUV3BGU3YrNGRwLzVKNFcwbEZjMVVCTGxuNWVR?=
 =?utf-8?B?U1ZsYm9WZ04rZDVwZy9HT3hFVFRuYmc4ZVV3NlNPSkVONFUwT0NtNW1qdllK?=
 =?utf-8?Q?dwflzW+wG2q4EAZyVdAqW6c69?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab5a0ca-a0c7-460f-c2ad-08db82bb1b1d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:33:52.9834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zXxBsiCoN3uSm779QjHDrvQDCt/Yla1n+iiA48stXiCiHVgAwJ5H6XWg2XMWpn2LMlf4XKkj11a2+n1UsV4jw==
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
 drivers/cpufreq/davinci-cpufreq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-cpufreq.c
index ebb3a8102681..7d2754411d8c 100644
--- a/drivers/cpufreq/davinci-cpufreq.c
+++ b/drivers/cpufreq/davinci-cpufreq.c
@@ -131,7 +131,7 @@ static int __init davinci_cpufreq_probe(struct platform_device *pdev)
 	return cpufreq_register_driver(&davinci_driver);
 }
 
-static int __exit davinci_cpufreq_remove(struct platform_device *pdev)
+static void __exit davinci_cpufreq_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&davinci_driver);
 
@@ -139,15 +139,13 @@ static int __exit davinci_cpufreq_remove(struct platform_device *pdev)
 
 	if (cpufreq.asyncclk)
 		clk_put(cpufreq.asyncclk);
-
-	return 0;
 }
 
 static struct platform_driver davinci_cpufreq_driver = {
 	.driver = {
 		.name	 = "cpufreq-davinci",
 	},
-	.remove = __exit_p(davinci_cpufreq_remove),
+	.remove_new = __exit_p(davinci_cpufreq_remove),
 };
 
 int __init davinci_cpufreq_init(void)
-- 
2.39.0

