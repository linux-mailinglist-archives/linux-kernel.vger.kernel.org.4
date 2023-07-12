Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82039750332
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbjGLJdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjGLJdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:33:45 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591DC1A8;
        Wed, 12 Jul 2023 02:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRvt3qddAdR5r7RGf2s7qjha/zbBTJLL1UGtD8cIcpPzfS+daKULagOBQBTrQwi5It4abM05KwCiMs3Lgvt4bfpjZYGYxc/8DQBaaJKvr4isjW7YUS6PSYanp+jwIo16b2M7Z9/zz8UpwqjF3LRstzXHeADFaedbvo8FdTkXGxoqL3sgMQWQLpG5jBYaJUBd7QRIK/+A2eYhJqL7Pdhp7OrjorulHuFlGinOssKcWKzqLygNe2Lr8HDRlxrY/gEwMy6OV8KhhINTrNA5qHYbEvyeUycpOW6XLhWYJwl6HvAiQ7b/c0ibmQdSbAIybJVERymspvtDl+moZoojZBglHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYtqx7WfYEGqYG5KEaHeDbzCIJfRJ6FFOI4C7Yrs37A=;
 b=dmQkgsjHta3e/Q+njezIA60w3jPBUc1ImH6FyFw3BmZn+N8hCxap1ad0WsH2RBTC9JVdFl7etU/mzFOCGRdLEtLJ5/7MWEIPtZnrzq3SAGOlTD2yS0m9LjA7VlNrmNmsBJpM2dIKZLON5oAj2cVy9JG8XKJSx8ZzDOEUx4paR0w8u+GOZ3LzGUiW5N4Xl/pmRcuJ4uBMc7Kk1SbTKbcqGg2gF+fSqw0DlDUPWYu2qO6cs05i2GrGh5EzIE8zKhZXGEs04F78TdkXU29xhnOwcblT7pie45+faycxa3s7dUfVECrH5W0Xx3VB+XQWPCSMfYfTcn/G8HyN1LE0mBH2tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYtqx7WfYEGqYG5KEaHeDbzCIJfRJ6FFOI4C7Yrs37A=;
 b=Gdimz1Mlkqc0IfR2eg6o+8qU5Xlg2AO8LyVhHxTwoDkjr9Hx9S5zO4p4DM+fnbZ6urjPJO2jUQaKrLCb7cXT/2iJ2hwN6ac47Rj76RgpqVIpxuyOOsW4sNpR5NN2LToAB/nHZ43AKKkYQm0ZnmVm+PRGthL7LowEZQhLlqCibvODetTrtkzmstiwbSW1yR5Smyh0BQwI+FtTudWqG+HfkF62+9P8q/oKb8NNWFLzf9/sgnjlTpyQV4gOYbRn9cvsCyt2jPscU8mlhOhnlTzXsTbO+dKYAFAVhLm25fkcQ6j/ZO2e4IJEa5rjtI0eebZDAImjOV2D85UARcdx8s4CIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5985.apcprd06.prod.outlook.com (2603:1096:101:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 09:33:38 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:33:38 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/19] cpufreq: qcom-cpufreq-hw: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 17:33:06 +0800
Message-Id: <20230712093322.37322-3-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7d3b8a70-de08-4e21-d3d5-08db82bb1242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KLllzGyAwtfPcG9/vNkMgFJNwrSdRuEcmy5HzdRW6O3/RaL9i75jPQ1rz3S8M0aTCSx3LV4AvTDcDA0ZKwrINt9TvOGdKT6mgBioLn2Nd6fM+xXcRlYs3BPa87XmSAY9/+lIhchOyeHp33yjfQrnUFSfok0GyO+e3+33ZdXQr9r8fPuMlWiiBYwbihImu0Hfo6mSBWnFzeXLoRcjPAzApok52rihTCOIvSfMaSi07wyV8f1khb38Q1ipUOwql2O7gdAYvdNUPWQxIriqRPWny46M36fng7mpP7YOG67D6P+fknOuOKJW56fA+gtsK3nEN4JDZ5ZsAvQrpp13/bkUPOleFPu5APuyOlxayfkOaurRTgjZuhjFQGpOe9l7hrxbueRJg87LLhjqHFVlOmiOgV/z96VhcP6nE9Sy6VouNCZpQ5XwvvyLZxZCmKaFPJtEwNoQmAMKw2nLUmsa3LMqW8Ex/4ViIgJflsVfid3ZFTEMlH3JRMoK7Z/o8JKUa/we+7OoqREFgsv+3pdLsBg9lNXpAKZ4YwihKP6utY7HaKEeP8QP1w68c+Qe5tMh0/Kn1D/sCzANQC6s+OnjAZiu4jxzIt+aHxUlZcG6BtxosMy+pHYgJHEQa5pBy6QnBFLT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(186003)(2616005)(110136005)(54906003)(38350700002)(38100700002)(5660300002)(8936002)(52116002)(6666004)(6486002)(86362001)(8676002)(478600001)(316002)(41300700001)(2906002)(4326008)(66476007)(66556008)(66946007)(6506007)(83380400001)(26005)(1076003)(6512007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3FuMUk0cE1wdHRNa0VLbGtrQ2xWaXFEakxrN2xxdnhva3lONm9KTGJoWVFN?=
 =?utf-8?B?b3J2WHYvTEF0Mnk3UFMza3lrMzU1NzZ6ZStTZnNFa1lXQVBMckkzRFlTeW41?=
 =?utf-8?B?L1JYMFBSVnJTQU5WdU9UNzFPN0NCYzUxcU14TkY0ZmoyMm5sNS9xVW9oeFRH?=
 =?utf-8?B?REhOOS9MaUlmRUxDQktaVG1wb2d2T01MaEdtQnB3WW1zaEExd2pCNk9wZStS?=
 =?utf-8?B?eUNhVEF1cWgzbVdpRnJPN2phUG9WTEFLV1laWmUwWjg2TUlzcHhNeGtESTVE?=
 =?utf-8?B?MEIrK0xvd2xyL214Rm82cmRqdDZpOVVRUWhxN0E0TUJiaWwyTDBwZGtKd0VW?=
 =?utf-8?B?VGtnM2E4ZW1LWk9JZ3JEb0pvODlIY1VMN2VyS0dLQzQ3eER5R0VFd3l3ZFlS?=
 =?utf-8?B?Tko2bENKS0poZGhzaXpmVkpPdDZ4WHBJZWI0Mm1ESkFXd3J1bWt0RjJsUGcx?=
 =?utf-8?B?NFZsUjBtb3dxZTZYbHc5SURHdDMxZ1lOdHZtSDJXK3hoWWd1aUttU3dpUHc1?=
 =?utf-8?B?bEplTCswK2ovcHZNcFJtNGtLN1RFd2tOYjZaYTJtZTZwUVpIQWFlZGFCKzNi?=
 =?utf-8?B?M2ZmUDNqNEptbEgrT01jWlJ4eVAxOU9FSXBsaDFFOHFuREFpNXI3VW5paFZT?=
 =?utf-8?B?T3EyZ05pWWJzM1RvcmtNcjRpU2lqbm5Bakp2R3NqZlNvQzZ1VXhhSDJIMkhD?=
 =?utf-8?B?dVNldEpYQk1mRWx1cU5QaEwyRy9iRmYwa056NzNsOGpUUXBCaGNtdnJOWldt?=
 =?utf-8?B?SGViaW9GcWxPRi9ORml4SnpUQ3ZuWjZUOXMxOStIL0lERnp4OGdTNjUyTGxB?=
 =?utf-8?B?VWxiUll6M3RQSEJLaDlDS25GclBlaGR6R2EwWE5iT1l2SlUrSDFnVmlZYU9C?=
 =?utf-8?B?aTYwZ3BmcXBlaVUzMmlPWGZqVFJvWHZabGhIeUZHMzRrV3MrMmhQL2ltNVBp?=
 =?utf-8?B?UTR1ZFA4bDVKd3VJUGhGSTN5Nm9DZHhmUUg1eHNnR2RyMDVKSG9ZMmo5dXhv?=
 =?utf-8?B?ZlVHNXhjbjVHU1hDZXNWYUk5am55MjhZWlFhQ0hZcWg0V3dvRk43TlVEajdy?=
 =?utf-8?B?TklRbEJ5QXlhYmt4eWpwM2UwTUZEZHZlbHcrQWEyNjBhWnAwdDcvWFhIVFJV?=
 =?utf-8?B?TEhTb3pqMGVwaEhPcHp5QkVNZXZtdSt3UlB1QlVUUVdMUUtGVVZGWEp4SWor?=
 =?utf-8?B?RlZlUjRkbVdpYWJTUUlleFNXY25hQWlYc1VTeXc4OXlVdCtJMVgwWVNPdnNm?=
 =?utf-8?B?YTFFUmErL1FGUTVjQ3VSTkYxYTM0bHNVd2RkQVc1eDNxYlJSK2hIb0xCN2pk?=
 =?utf-8?B?WmZnVUczQURCREFTTUFnQmNtVjlad0s0UmVBcXliYXZRQ1k0cGs4NnB5QVdo?=
 =?utf-8?B?V3QzNTRWZnFxbzVtbHVtMjY5Zjd0WU9JL3NtcFhQbVhkVHZaOERwWjlhb0o3?=
 =?utf-8?B?bjRJQmRMeVIzTkRxMGxIc3loSnNDQVFiaXBmV1pMSkNaSEV5Yi9Cajd3bndj?=
 =?utf-8?B?N1pVY0JpalQ3OCszWjdZQ3R3ZUg3eFFKci8xUHJJQWpBQ0FrWWtPMlZaM0pW?=
 =?utf-8?B?MkVNQlA3THhYYzFUVjBMaWRFejNRTmE5RmVaSnRJVHVKc3pBWWc4N3BIRHpB?=
 =?utf-8?B?MDRFQWgrdVMzVmVtb2VGQnM0eTR1V0ZsR05VMlAzYTNtZFg4SzYwWXBuelZ1?=
 =?utf-8?B?TDdOTE1TUE9GMFJoaGZNSjVYTzVQcDQrQW1nQjVlQXV6NnQvdTUvbzhQakl1?=
 =?utf-8?B?b2NUZUF1UE1uV0lLZUtRcExSYk1xSG5tR2czTkc5cDluQlEwVWJSN1FXMU43?=
 =?utf-8?B?NWExUkNVeXowcFFSRFZoemVPVjJ6N3J6eCtoY3hWVDlVay84cUdUUmNXYmpn?=
 =?utf-8?B?YmplRTNCWStrRlA1ZXdKTTNhTStZdjIzc3dPUm56aEJTaldaU01iOXlSTjg3?=
 =?utf-8?B?cko1N1FwWlVlTXNCcENVRG5IRHM1SURzYVpkV0lSWnBvZjEzZUdRQy9kbHR1?=
 =?utf-8?B?RitSUFFhaU9mVDQyV21pblFiN3BLWFdwL29GNzJ6ekdmNFNsS1lNWklLbzZs?=
 =?utf-8?B?cXgyTWRiUTVxb0xvOGx0cXBBVGZYTldRQ0RNalFGOFRnT3k4UDg1dmhRTitE?=
 =?utf-8?Q?GDeH1sjBaNDLxEqdB4LFuQ3tq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3b8a70-de08-4e21-d3d5-08db82bb1242
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:33:38.1334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1f+/os1UoNN1Vab/NsiBlheITly3ftcGYfDobxeejzKMrJ0Km68yTXFQQdUhFX5JGeMLia3aywf+prtrJqYpw==
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
 drivers/cpufreq/qcom-cpufreq-hw.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index f2830371d25f..f24cf2eddf1e 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -730,16 +730,14 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int qcom_cpufreq_hw_driver_remove(struct platform_device *pdev)
+static void qcom_cpufreq_hw_driver_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&cpufreq_qcom_hw_driver);
-
-	return 0;
 }
 
 static struct platform_driver qcom_cpufreq_hw_driver = {
 	.probe = qcom_cpufreq_hw_driver_probe,
-	.remove = qcom_cpufreq_hw_driver_remove,
+	.remove_new = qcom_cpufreq_hw_driver_remove,
 	.driver = {
 		.name = "qcom-cpufreq-hw",
 		.of_match_table = qcom_cpufreq_hw_match,
-- 
2.39.0

