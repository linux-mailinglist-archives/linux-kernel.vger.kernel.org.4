Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C7075035B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjGLJgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjGLJgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:36:01 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20717.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::717])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70FC210C;
        Wed, 12 Jul 2023 02:35:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tbvur/pRKi8kXhRS7eys95owGe3P/wtsE6/mG0OTzcmxKnjk9pHcdKg+tDcUjOmx+vV9m8iBr97HYJGPlrLph7cPIUSTRLN2oCgVuwHwzmN5+xhwO1bMKIRrOxSuInyEr+atq9fRQAWL/lGP/y9GBlp4Y4U4e8iKDbxtNKsPwRlTJDHdIU3zXse428dgwEgVdX/fczLrjK3JkvBqn62NZxfs7Pmsfq/R5UfwXIIo5N1ZwLHBV017ZWli//UQFIkgOImAYiw6GZ9ndePZ3sV8MARQbkqeJ8sCabWjwPhK2aIPgUq59nZDr7Neut4UXyjSPQfQZO/uvSn/rPwu6ZrrQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODrWtgSyv6IxrZtWeftArJlnezTb+OKVjb2Bn6QAOsk=;
 b=gTfZYjS92d0XR+SYmX1qblgJsPRINkRvsxf9eu0ZnKRzG8O+wd5hPpwuFNDzqPGm0OAwJxzKQ73WlkR2ON/Uyc/9mxIta1icUyK0z2m7LndtQv7RhXtoG3nDfpY/Ugt4Jqxgzi2ONyx5q1+6JCYfdsz4ebmPGsePn1s0ArHIpMNnFGu/ryklxB2P0HOHWRgn1aUVkkklmI6w6cWPKniSJh6r/S8H4JzGejLuGNBoYmVF5maiKK/ABr8xSUU9uS0BGEc8jsuaAASjOibb7DinVmeGgqGpbbH0M6ycH2U99muRBYhCGbDXJwNd8dc3QlkQQTVm82EDUCwpLUcS3sMwOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODrWtgSyv6IxrZtWeftArJlnezTb+OKVjb2Bn6QAOsk=;
 b=h2hzz1KFRbqLCUKZD8WyFEFlfVI1ii672aqUcvZ/l5clnw2CoAtvdGYuJCAqDDxCWtmR6rFJavtRzPRaIjNyl9AisBBemU/XVLHFzowe9YdriREbeNrfDxPdkBJ+geVEsBsVpuI501r1WvPxgExkqjIm3twtijulE1Qlruc25JSjj3iBSc8NFhuTQF+tvmQsFrLHYbqRED94g41JxOZoWV+fAVcW+/bX7vdiHpvui0KcB8CmdJ+1Cb93OMw7jQl/4jdEFf1LA5+L2Y3ngJnvoxpoeqZOzffvRRgvQZhANUsfjxC+KlzUZHAwA4UuOBhQgQa4Ws0u1k58ZpvN/oxwgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4091.apcprd06.prod.outlook.com (2603:1096:4:f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 09:34:06 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:34:06 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-omap@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 19/19] cpufreq: omap: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 17:33:22 +0800
Message-Id: <20230712093322.37322-19-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: bd2f3c1b-a6af-49af-69a1-08db82bb22df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IjA7tQfQp5TDT0TflhR9cqw2D4Fcm2HIsS6GE7zef6O+5NZ/xWxO5XaJxDkJX336efbuh3nEOu19eaWLW17HeWdDNyfqfoWMgS2tYQziOk3kFnEU0vSzv4ahHjzKJS1XB3oN6dAmATJMmzSPeuzoj4O+MT6l6BwJA3n7OsYy0FVt9eSKuFg+GWzjY9vv+I5tJFrpm/fJopwskD3c7I+lhPxD+yo3TiC5bugfCTwjIVeVL8ZiTCFHO+KANZjmyQNQ/63BkAfSUpHVUi/uRbSJV/C3AhUKKQuqRhmlfLcR5bQBdPKSoJmqIDp3Z+f3QvdEmMUfPSFdmThjSYw+HamPTya8rm+xDNAcv6p6csItiS1sZWNlGbR8hCl0hCVwVyXWr9tllbNO3R7vX4s1r5yHvFOpYAu5SXcjbdFcvd97lrYxWwoC3LiDcXQwQ+uMuA1QmVDdtumWZHXvM/4VNjN7wHETAEVXk1xsISWvqsKFjM/+5fID1LZWfYPvkEuN+U/oKUIx3kBnDI+TxmjvKRDCc/mr174J+reFE0PILWLIFfXQeRk4GhE9WKrkbkbjch8d3QQjG+AGukHGei4teqa4WCV7htIWQ+p9Nai/H5vqOXrvLbyGheWih6Ny2qO5KDAE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199021)(2906002)(6512007)(38100700002)(38350700002)(83380400001)(2616005)(186003)(26005)(1076003)(86362001)(6506007)(5660300002)(8676002)(36756003)(8936002)(110136005)(54906003)(6486002)(6666004)(52116002)(478600001)(66556008)(66946007)(41300700001)(66476007)(316002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjNZRGQvTDIvOHF4M3VsNjlHVFpaOHZjaHBHVmRTMWFFSSs3dUQxOUdPa3RV?=
 =?utf-8?B?UW1TdTQzMExOMkx5Yi83M1ZmRXptVFBlN290Y1g5WkhiU3k2Y1lxYUZOOTNI?=
 =?utf-8?B?Uy9BbUFRcVdXOEFUamFQcmVkSFIvajJBZ3lrWEZyZEJUNlV6dXQ3YkV6TVlI?=
 =?utf-8?B?T25QSVJhWW9tTFUzUkljOGo2OHV0OTBsK0hVQTZLd0JZajFoRWhmWHlyS2VR?=
 =?utf-8?B?bVdPQVNrVW5ZZHZWMVRlVnliWjZrYlFDbkxEWGM0dW13L2d1eGpmRm41N2ty?=
 =?utf-8?B?SWtHNm1rVUVZdGdDemgveTYwSXFtazI2T1pjWmxWeWpkc0FsMHltUVFFZkUr?=
 =?utf-8?B?WXFIRjdteXlzZ1JsWWdYUXZLcUFSdGt4ek1oTTZiYzVqcUUwdEVmNEhMbHVR?=
 =?utf-8?B?MzZ0Nnc5UnFQVmg0c3Q0WGllbGFvaU1XellTdTYyWmtTbmdvdUpWcnVyYUNF?=
 =?utf-8?B?RnBVWXpEdnBqaU5RNHdmMmdLWTlYQll2VVB0WHozU1NCek9kRy9yUGdOdVR0?=
 =?utf-8?B?d3BtUTlXeVNjODczcE44YzQ4YTRHRlluay9uRHZBRk9hQzRMT0VUNllsK202?=
 =?utf-8?B?Umk5UG9OSzZybkZPQ09yTDNpNHZVTFJKQ3loT1dXMXNmVW0vamtjc1hGSjhz?=
 =?utf-8?B?bk5EQ3ZZeDNtYWtWRHIxTUZVYVUwNHErTm0wb3lybDNBaXlRVVVRTXFLbHcv?=
 =?utf-8?B?V1dFK3hBRlY2aXVzZmR6QkpjaFprcnduVy8yWVhFNldrQVNyek1qeVNOMStT?=
 =?utf-8?B?OGJBK1QwV0ZaTTdJdXZHayt4ODFVL2M3YXBwVTMzdXlyYnZQdmw4NmUxVWww?=
 =?utf-8?B?cE1yc3JHWjA4VnF1S0NaaDhpejZrRmNoL1JhZUJuNTNzSHJ1OVp3T1FxcXBo?=
 =?utf-8?B?VzliWENZekdQMC9udVRyMHorQWJpL3FVZlhCaHJzalNpSC8wRmRoSmVMS2hu?=
 =?utf-8?B?WkIrYXpFSklDNEVobUFkMURhN0Uxcnp3cXlEb0NPR2lKVzNtK2N1NktkZndy?=
 =?utf-8?B?a2hCdDVmdDRNVWxqaGMzNzFKTnU4M3hmOHc4VWRscyszTHdyeTVpZzVvbUZx?=
 =?utf-8?B?VTBITGNaemd4QXUzNXM4Nks4TTJscWRqWkY5dzB2OE5JbXZmaHllbDZHWlFn?=
 =?utf-8?B?clFQVDZPTDBicGhXc3htTHBHR1ZmOHR2blVyUnJYK242c2dzZlRUQ1ZaN05u?=
 =?utf-8?B?N1ZVbnE1VkxIRjgvUTAzdmtCWFYremZUbnhLclUwT1p0RnhGSFRzS0l0bkVC?=
 =?utf-8?B?RHhXNUdUMS9mVlFHU1FVZk5QMnRFOURMWkxwOGJ4VlQ0aEVSd2pkV1BZOUwz?=
 =?utf-8?B?ckZqc1hqMTRSWlpMenF1VTVZNS9ZT2JYMjJXOWtWSDNnR2IwQ29VenVBUkNq?=
 =?utf-8?B?aXlUM0VEMGxNcXVONFI3a0c0VlJKWGRGTFp2VjJ0RURBQjF1dVdQejNoOEZL?=
 =?utf-8?B?dGxmTUxJUnk0VSt4VkNrUDJ4TU84VWxyOG42NjV3YS9HbERoekpGL3czNi9x?=
 =?utf-8?B?NW9YQ0dTdlcyc1QwdjAra2IxeEI2NTR1VS85OFhDR1YyOGMybU00ZVZ3R1BF?=
 =?utf-8?B?MXRWZzRxd1licVRjblRKY0JwVTdaejdIS1F3K2JzWVIwSFUyd0R3MVBUNnNX?=
 =?utf-8?B?bHFDYnRrWGpCNE9wRE4rb0YzM0hSdUxVcU8rbkkremQ3RW55VUxNWTQ1YkhH?=
 =?utf-8?B?dkxMQy9GaE1pWFZYb1JuS015ZXhTQnpqSitGUzRraTU1Tld0SmtYblpSUm9k?=
 =?utf-8?B?eFVDR3ArdE9vU0VYcitYbm5wMzNDaGJSUlFwdTVFTVgydXRBcHFjN3U0K3Zq?=
 =?utf-8?B?QzlMY1FTVFBHUlcvc0dFTFJPSWFoaWpaZXo1dlpMdlhqNFJPUjlMTElYQSsz?=
 =?utf-8?B?amFEYy9tZDRncmNNVjkyM1dwSEhlWXhjRXY1a1RwNm9UNVpLVHlZWVpSVXpv?=
 =?utf-8?B?NjZ5TDJtL1VZdmQ4aXpXdWVsZkxxZ2NvWWl2WE4zbUhEK2MwdCtlODVvUHBG?=
 =?utf-8?B?NjE3MCs4TzU4UlFvVm1aZlZBTVkrRVMvczl5c0NOeW53aStSbHFkYW9sNjVY?=
 =?utf-8?B?VWVsQU5sZklDdHFTeXRBamxOa2R1b0JxSTNnUWt2NmdQNDFDVFNGMFNucnZR?=
 =?utf-8?Q?sVcjqk6xsNiH0hPvmMocSoHLq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2f3c1b-a6af-49af-69a1-08db82bb22df
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:34:06.0037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wGuP+YZC+lmsbwhHuh2M3JO1XuH8bpPzV5yubApZmfoeCdfinQhCrhQgxIiObH7s78FWfGD3rT1zDnBX1DGWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/cpufreq/omap-cpufreq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 81649a1969b6..895690856665 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -182,11 +182,9 @@ static int omap_cpufreq_probe(struct platform_device *pdev)
 	return cpufreq_register_driver(&omap_driver);
 }
 
-static int omap_cpufreq_remove(struct platform_device *pdev)
+static void omap_cpufreq_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&omap_driver);
-
-	return 0;
 }
 
 static struct platform_driver omap_cpufreq_platdrv = {
@@ -194,7 +192,7 @@ static struct platform_driver omap_cpufreq_platdrv = {
 		.name	= "omap-cpufreq",
 	},
 	.probe		= omap_cpufreq_probe,
-	.remove		= omap_cpufreq_remove,
+	.remove_new	= omap_cpufreq_remove,
 };
 module_platform_driver(omap_cpufreq_platdrv);
 
-- 
2.39.0

