Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A01575034D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjGLJf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjGLJfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:35:00 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6536519A6;
        Wed, 12 Jul 2023 02:34:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wb65ea1KTwoMX3H4i8iVbWg+vYotOuCCht7horqQdUooxMO80iKE/UXkvhCyeGnOXInb9sDKjdRN+RjIvTexP2R8Wt/yAUaeZ0tHREYpjfSnS8ifDCIe6+C03VSAUbFnVoaZ+9HALk4ctuxc9WQdFwSuOxxEGakiTfZcTTuNCpq+i9sk+5OZgEWDX4Ft8sTZyFd0dVAUF6rnYq9cJaLI9v7BtyEfji1PbJvK6iiHo/TuxyNzHU04/oxYoMekKSR+aszN5NF/Bdm5cGPIR+NpIPPwBk4IEdtAs9WQgt/rW9zULT5gy2HPeC7EFIukvZL+chZSc+fUUs6v+QRj01DUDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDgqDKXKbMkmxHcyQAqoj0mOTiq+h3nRHhuzdeQGeGA=;
 b=OZskxIc1HZW6+smpZy7FV94cBrtqSClNoLDcQ+7Drze7vG9owQ2I5f6PAt0VLnQGYzFK1J4p3lb9LqTnOpB+KSMLFFes6lG8gxIRxQ9WjAKsmQcxMM4fXT2y7mBA3mEeN4YcJk7rMWLRu+aS4EkY2tgScyUjkj+IGijwoOIGjhSIqy7DdURLCA+NcQMGnDj5Uz7cpFULfsndlF3nEWxrIegfEVrd4Vvyp9VFyeakwAHrnYPXZUobJS1ZrcDJ6nyzv/AywzcDCS2rPL2NqH8ahJRf81VaGiP+dLM2x6Xv6Bzq9LzSD+FpQdDOvpxoQUsZf4QzdVgEg7SwtUAEOZONXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDgqDKXKbMkmxHcyQAqoj0mOTiq+h3nRHhuzdeQGeGA=;
 b=bYuwmQO0Xx34r7blFkOQb1BI+4l4JlYfCbDSYRio2SYlUatJoEmRabXhWBRgDiakTxKcEnVOlyi9zw85YMNMoWirzPTGj1WnX6DSK1zpOEKVVKKag9kMo0uyOrD0BLFO6YJ4THRVuPX0qERjyaS2QqUllMqgtwAJqPmVvn4CeB6K5CrwXPmN3S7u/FuuQ84pnanu3qqFUEzypO5+Wmoxb9K+cC/ykLRjTefUy+KVMS2T+O9WLT37v+wc2i3C8ex1Vqku+mScIU+NuD1RyJIs9HXcq3RZgOjgslsHgL80OE/BFD4mAsvjXR7VM0hKOFoEu49k94vfmNbOK6RdfJYDPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5985.apcprd06.prod.outlook.com (2603:1096:101:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 09:33:59 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:33:59 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/19] cpufreq: qcom-nvmem: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 17:33:18 +0800
Message-Id: <20230712093322.37322-15-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6954258d-ec96-455a-621c-08db82bb1f1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bEI8OyR4aDPoY9zQloH5nnCqdqhWZc8B+NO+BVVtHPQ4/YrjG0hE7RQPUIBXrFMhW3fISdaVzsa2nxFqJ7Pku85eUASQsXf1kYgbT+giLln8xJQ+2nsXi/KZPSMuGnEPcz2Kit1CsWbASAOO626ENdvN+wVTDAwAyvoK6EB9Lpy05mftPbAZVlFvKOSYAIPjVjTLVriUDWA0Sv1KAQ8CEQFNFgeWzQeuethDm0Be381ZrE2PBj0ct7GoAjAOo2es4JbWw5MjCVv/qRnPelfUyxO9uVAxbIa9L4uQYBKD3UqqMwAeqRBRgGJmCYEKRS3I/8KNl9B3vzNAEInJYZ5td4gXRVz1BxVkfOXl4mv6nY+Q8pYwQKbaTSqMUxUMSSoO5u4nA9AMeOuX4HSKLG81YgKbN2gj3oIQC/45png/Fe+jfnbhizmGw2Bu/e5EwsK0mpoY01jCZbSi1oVeJxlJ/gIeNZDPmUeHeyY1V6Xdiq3VkOugoxEQFJMtNSSli0LWC072EbN00OjLTynAsnB43F+wVp1lLWnSHbWw9gjD6h5v95WpLdWrLr1Gn1YTrEQ6H2xbCjqK3Dwmle6TbqrYTpM2si4xwMGQeC6ozDFlFFFi1GX46r7eNlCBVCoPVufr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(186003)(2616005)(110136005)(54906003)(38350700002)(38100700002)(5660300002)(8936002)(52116002)(6666004)(6486002)(86362001)(8676002)(478600001)(316002)(41300700001)(2906002)(4326008)(66476007)(66556008)(66946007)(7416002)(6506007)(83380400001)(26005)(1076003)(6512007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWdzRzVKSk53Und1aVVQaVZ2WGx1VDZMZ3pGUkdpNEhXTTE4U0JyNXhkYXhk?=
 =?utf-8?B?c1A2L3pZWk1CbkFQWjlaNmI2dWVGRUdOM1JLcGFESUVZZzVVeUd4N1V0NTR6?=
 =?utf-8?B?SWhTWHNTZ3hqMXNGSzEzd1FCczBYcjd1VCtyeDlTTGJlOUJGcS8xd0RWeXg5?=
 =?utf-8?B?dWV5Unp2UUVmN1JqdlI3WkM0eTdRZXFJUHRCc2kzdmFBQUs2NHBiTGc3Q3Yw?=
 =?utf-8?B?cDNReWlEL0pWQkVIT3ZLdEEyL1ZNMkZLQXN3Y3JMM0M0OXJ1K2lPbzJyY1Vw?=
 =?utf-8?B?cjRiV0QyN2ViUzJrSVN3aXlqOWdMcUh6SEpzMk1qbEFmcXNsWDFCd0Z5WGgz?=
 =?utf-8?B?UUJhNURhZW9tM3U4NVdUY0xPcjN0cGJFdnozQlhxQXZ1enA1Q3doaVYyUWFP?=
 =?utf-8?B?NExvcDRNeTRwNHFKVUNWbXMxdzBkSU15c3JRRU53aWpxbjdkNTJkakppb1E0?=
 =?utf-8?B?ei82dVdoZ0NKRFl1QzdpQzFUd0xRbm9rT1B5OE5odklLNG56M3dxS0IyMjZX?=
 =?utf-8?B?bnJTcjFzMzU2OHF3UFBuak9JYjI2M25uMnhBQzkxbFdRWVI3Um9ZUWpYSm9z?=
 =?utf-8?B?RGx1SWZqdFJ0eFJLRVZRU3locVlRanZXd3dPcjQvYVZuWVRJcjBwZGM3Ylp2?=
 =?utf-8?B?alZ3Z2pOVGxHYzJyR1EyV3htbFcyMTV2azNvRFA5VHlBb3I4S0Uvb1Yvanpz?=
 =?utf-8?B?OUtPa24yQjlnd25UMzJYUS9RSG54Z2pBZE5IcHBPLzBIUGw3UlBXM3NOZEp5?=
 =?utf-8?B?V3dZMXoxSVhtSklnNHpFS0VWTDJsT3cyZGIwNWVaWUZPV3BUeG5rVklQUWp5?=
 =?utf-8?B?akJsUnVaTy90T0hzdDJVN3Q4UTJZTlVhajhaMEJ4OVg3b0YvdUFaRHliS2NI?=
 =?utf-8?B?UW1tbWdBRkZnZWtBK2JtSVVNSkVJbVFHeUJOUEdtNXllWG8wQlhZc0xqSnNP?=
 =?utf-8?B?WnZrL2MzQTZyQ2VPWFZvZUJnRFBUNnhsTVVTRGkrczlIYjl4a28vMXF2WTR6?=
 =?utf-8?B?NUtEN0hjNjJkNU1hVlhnNXJ0N2YrZHA2Z1JRY3MvSUZIQkNnMGxwZnY3L3Bk?=
 =?utf-8?B?SnNyV0ZBcDV3ZmRnQTJUbmlsdFc4QkU5TW5BS3hya2hJQkVDSkZxR2JrZGo0?=
 =?utf-8?B?dVdmR2VSMFEzU0xSL0xxTDA2N01iU1MxRWp3b0s5cHREZXlwa3pRUkJ1blNT?=
 =?utf-8?B?L2dTSktVaFdMaENlNWRjOUxBOEV1bHdIVVczdnVDV2xtdUY5S2oxV2dudXhH?=
 =?utf-8?B?Q3pNZ0xEaWNWVkhiWjBOTXI3L1lWSnUyaW5ZNVJ4WnpYVkE3M0RYdU42aFRh?=
 =?utf-8?B?R1d2SldYM2ZRTWIyeUw0RDdEazFHdEVYdTNOQTM0OHA0QTZ2ODlFVWk1VExN?=
 =?utf-8?B?b2FSM1d6UlN1K1BnbHloV0pUQURjZVF3TWpudnZCeEF2U1ZobnZpdXBBWGQ5?=
 =?utf-8?B?a3I1WGYrMXpReWM4QjF1NEF3WjBmMDF3N1BWVGNQY0t6ZEdXWlBhQXh6TEZZ?=
 =?utf-8?B?Y3ByWGVMSUtxZlgySGVRTzg3aEhNaU9sOWlWeHdFdDJLZThwNTFqRUpFUFFj?=
 =?utf-8?B?Uk1WdmFuVHREMHNKUGRyTnRQaTVUcjlOOGtwMnRtNWhTZG9WS0YzT3NzYUhZ?=
 =?utf-8?B?OFNDeFAzRVM0REFUdGdQR0hCaDkxMnZ4UVlUM1BoUE85OWRTbTBWbVpmNUZm?=
 =?utf-8?B?VjZDSE9CVExOd0xFb3RBN1p1NVhNcWNFdHBMNGhZMWlUeGNiZFkycXc3WGl2?=
 =?utf-8?B?cndJN0VhN0VoN0lvaTJVWTAydlVCVGZMTXVlQ1pjOXZnQjg5NXl6bUcvRldk?=
 =?utf-8?B?OGRkWUVMNGNjSXhnVk51b3RCQnN3cnNyZ2N2RnlPQU5YbUxrOG9WZUtuMkRy?=
 =?utf-8?B?TW92MUtZRUhoa3JVS1VtKzNJdFNySlBkM1hnUWNLRWJuWnBZZjJvVzZGWkVv?=
 =?utf-8?B?TjFueFVJbVQwT0RYZGxUT2RmcElLQ3pWaTdXZnVXMVpUbDEzeG92TDRzczg0?=
 =?utf-8?B?Ukh1Mk81QWkzald0MnFKVURiek5LRTdUUkhNV2RiWDk3aG1YdmhXZkptcURo?=
 =?utf-8?B?d01lSlBKRmdyTnR0N3czNWVoUnpIMXVWZmpudDBhbVJyQXU2THVuK25SOWZJ?=
 =?utf-8?Q?5ja5vAkeb++kXmCqbQtPbqoNr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6954258d-ec96-455a-621c-08db82bb1f1c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:33:59.7020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4/eyHKF1JYR5D+1fi+Q7nCtcAL7nNx2dY3GNG7sw4ZHTopTuuo+ujUZEonG7WqROXjax1VwNNB8mHGc6s4R/Q==
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
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index a88b6fe5db50..3db58d5957b9 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -334,7 +334,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int qcom_cpufreq_remove(struct platform_device *pdev)
+static void qcom_cpufreq_remove(struct platform_device *pdev)
 {
 	struct qcom_cpufreq_drv *drv = platform_get_drvdata(pdev);
 	unsigned int cpu;
@@ -346,13 +346,11 @@ static int qcom_cpufreq_remove(struct platform_device *pdev)
 
 	kfree(drv->opp_tokens);
 	kfree(drv);
-
-	return 0;
 }
 
 static struct platform_driver qcom_cpufreq_driver = {
 	.probe = qcom_cpufreq_probe,
-	.remove = qcom_cpufreq_remove,
+	.remove_new = qcom_cpufreq_remove,
 	.driver = {
 		.name = "qcom-cpufreq-nvmem",
 	},
-- 
2.39.0

