Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D1D75033C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjGLJeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjGLJdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:33:50 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0930410CF;
        Wed, 12 Jul 2023 02:33:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=depkaKMFq/ZYClKftGSMklGQmcws6Uginx0YiEKWSqvE5ZBoNDUNTdPtpj8IKF8oeOVBAPKW10ZcQyAZKlolAcHBASOcdc/vGpxMzjSgwPcp78qG9//rfdGYbhxKME2RmTia3gf35TPVF4nXhiPXLOtwWCTr8NYn2vgNjPfv2KbgHn6hnn7EPkkvvXqUXz7HIgfNQ53WkW6MlHPWC3Zdq/cAPOuXA/aqiQvnbYYjodwvcygAM9zHtiXsMosF05BbOvjyxIKGCyuzUFYeJe7yLSL4WRFSdbYVMqOqRiTWmSQB++VoxKjUn5/TRgkEjg9ufhrA7QUTrXXpZ7QJO+Ccdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRt3nLHXeR3vcguH4NVhTOfBUAWdrygfM+C7TT3dW3g=;
 b=AXCXXfWd7bz2B/AhvJ9L7hNkaBlmyFXdKSGT2LmSgGjOUmeAKVsf54N/q4trcwJeBSUzFn5JB/B5Z6cy0gpgpV8C8a51B3Zcyfh1N+BTo3t0vmIqwhCI/MxWz93Y+bxGLABOZ5bcuFqv4920KAXJvFlxmiGRawKMm1iYmM+DG3Ta+1/lxqG4najnZneOEXMWo0BcGEKq6VUqW/12I9rUbcfCeNGtlFHU57RiVLxJ8Vw/K1pdm3XHhVgSyFI0HrsUmsn3Iqw0atNyE36ilvIqqMfqH7gmDdtMKkexA8Q1RK8fbPHZrYqD4L1z+VFAO0vdBD6VLXsZ4ZaTMaDGqDkqvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRt3nLHXeR3vcguH4NVhTOfBUAWdrygfM+C7TT3dW3g=;
 b=l7nLrNqatsnEOb1KtvCreFhSaJ7CFkujIoShDwXQuYzenSYRMvoTRRVFZhvotouuP9vxePG0Q2jSkgZUPY/fDW1XzwZz+uBHsU0vIwvb2yyNQSRJf9VhlfdAhqntBpn7TyYQYkpBEcgjw+GSohpUHHe7r82x+RI8JK0pGGIbgX1SR8M5q77UM2CpEq0Wf6of/Y8v3JKaKhbQLtSjzYECQK+sc2FC/OB4JUeis/uKfH8452PUI5MUB92SpScjVsAjixC1oji0ltN9hr8I8ia2709wpyx4yoBS9b/NoLgPyf8MKyHqpWmoV/yBpFvrJyg0CQ/zNgBn1yLLOZSTyvYTZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5985.apcprd06.prod.outlook.com (2603:1096:101:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 09:33:45 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:33:45 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/19] cpufreq: scpi: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 17:33:10 +0800
Message-Id: <20230712093322.37322-7-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: e2e4a9b8-274d-4bb3-026a-08db82bb16da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nHgV++bOtf7FZba5r+S0Ac9cQB9nN9T4QYcSlNkXLjtuSQfXuuJzpqMa1OJENACINKPZjEPlq0k8Ls2DuijtrAvrs7qE9uixsOsjAiWvjO0FNChGqIv0UCJShJNsc8PAVdeqOv5zK3lWjqW0YKX4y4s+LyFSHt3yC+eClM/fLhFSiVTfu95TVMEHUxqoKyyI//0QSZ5PzzH1fa3FAK2J+dAMmHi+pKVoMF84AaUoZoncVtrwmS5bruteRe3Grde1pAZYcqdKlYnZHsibOcx466itlH0+ulYkGNP2VZletDHyCR1SrjrBJ439vPI6QozakuM4PZax6pgI9kf6XWqBZfDIoSz+rxZGQ085xKYFTAdqPSDn2v/x6IKHxZDVWl0cRxtWkMlwElcKBG+Tnp5w4TnF9v+s5Ko6LfUTxl8znItBYSIAi7PK8xz9jNetkh5KsRUQzOYw+wVQZuYYq+uucZXuNCtrp3nQ3yxC67ZjrfoGXKCwJpPw+GoKa1LHvrz4m5GoN8XjRibQox0Cqkbdm3q+hlUV3PneT6uziRszhPtP7YlJyuTWvJKQWHE5LDevuG1GwUha6c7GamYPRRO2iT/YsRJdhpv3FjEAfiyxmBaYXVaGbfZAmMo8RKcM12cL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(186003)(2616005)(110136005)(54906003)(38350700002)(38100700002)(5660300002)(8936002)(52116002)(6666004)(6486002)(86362001)(8676002)(478600001)(316002)(41300700001)(2906002)(4326008)(66476007)(66556008)(66946007)(6506007)(83380400001)(26005)(1076003)(6512007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1I0MmQ4alBzZW1NVzVrWFE2U1FDY1UwdytaaXk1L0Nxczl6U3EzcjRhMXdG?=
 =?utf-8?B?bDU5dzd2T29SQWFaMzhsY0duRnBSL1FOWGRWck12eERaWlQ2VkhvYjMxYkJk?=
 =?utf-8?B?YWVsbkYwRjJ1ckpvSTJCaktyeGFjQnV3V09HZk5ocEtCREZ2NThiSFNiQzF5?=
 =?utf-8?B?RThKUmt1TnEyY3V3Uzk4ZlRnZ3FxRmJ4NVpydU9hejl0ZkNudTBrN2xVbXBN?=
 =?utf-8?B?czJGMEVwT0V4YzBqRUhUWmdITWdyZW54VlJpVURpbE1pSzR1ajJ4MEpiVTB5?=
 =?utf-8?B?Q0N1RTNVdVhUK3VteFNHekNWRVpqb3gxS3pNbHhTaFFIWTVTa2FhNGVwcWJn?=
 =?utf-8?B?dExQNFE1Wk1UdHJJZ0lPeDZGSXBzVlloY1BjYmN0OEQyeXJjK0ExcklpNGZI?=
 =?utf-8?B?UkN4SlFuWWhYYVhyZnM5T1plcWh4MHV2M2VGb2praXhHNXBDSGVLQi9qUG9p?=
 =?utf-8?B?MFN6U21VVVNZV0U5Z0x6emppWHBmWHVpL2d2aXNESzdITWZqcEVjdEJIaFpC?=
 =?utf-8?B?cUlvdkVjQ3U2VzB0WWd4bFJvNVFxUyt4ZkIvTWI4WXJqekoxRlA5YUpmbXZn?=
 =?utf-8?B?VzY3NzlWV2xQVjFlemlUTHZ3YXp0QWRHd3FRaU5UN3A1NkN2TXYvRGtMNFEz?=
 =?utf-8?B?aHJJVDVMaktDcXRNUVJjR0pxWUxKc0N4MVlzbzZJSW1ObktqakRCZUtYcENV?=
 =?utf-8?B?MkczT1pmeEJBbms4R2pTZVN5VlFaQkwyYjFFV3BRUWZ4cUxBcXRmaUFwektl?=
 =?utf-8?B?VmRnUnZYZ2FqcG5wbzZkejlNSjdIYWRyT0Y3NmZzbU1JVTBOS1Vjc3JHbkFI?=
 =?utf-8?B?aFRSdGZPMDc1VGRaN2ZtQm1sNWpwdk5PWmQyM0t0d3JMR3ZWb1VxMWx1RDZl?=
 =?utf-8?B?aWVyRW1yV1ZzVXVJUy9sMkVFYjYwVHdvc2hFd0xDRmJVdXRRV2JjTEoxb2N1?=
 =?utf-8?B?Y3NvRnM2L3ZqZlZhenZlVk9rVU0xM0ovZHNRV28yNzhFY0dLUzVHVm0wS0FW?=
 =?utf-8?B?ejNrQmUzK2oyRjg5M21UZzgvMGlid25tVWIzdkJOdlZuTlBaRE42Nmt1RUhW?=
 =?utf-8?B?ZkRHbUNtUFZQZVN3dFBua1FDV1RzUlRwcCtFb0Z2NmVPNkdkY01JWHNubmtZ?=
 =?utf-8?B?cmRGR2Z5b2JrN3Jya1hiWjh3c0dSLzdueWlYVDAvcXZUTTFPMkJVNkJTM2RD?=
 =?utf-8?B?NGlXUlNJVmVqaE9xS09CTW4ra0hZVC95a21hRkdGV1ZlQlVVVjZVRTM0bWto?=
 =?utf-8?B?ZWsvY0szaTVCMEpjZ3FYQUZEWVN4dC9Hd2NuUlAzc0htZXhTUCt6U1Bqd0Mv?=
 =?utf-8?B?V2ZlZU02b2VvcFQvdVVxemJtOW5rd0pSYi8vNzVQUElTMndTbmg0STlZTElt?=
 =?utf-8?B?eUZ4ZEhzMUZFeUdWUmwwR1Y1QStxM2NUazI0Y2ZmcThwSHcxL0FlU2pRMGxy?=
 =?utf-8?B?RGZDeWtWSXhYZDFvM1d2ZGw2cmFnalJ6L1pBRjMxMzFZRnV0K2JzTklqU1JX?=
 =?utf-8?B?cnVFdDlOTi9rZjFhZWJSNTdzTDdhTFdCaFJjVDhlMWxOOEVNY1NjcmtQUndm?=
 =?utf-8?B?QVl0VlBVZTFsMitiZ1hMRXZMWFY4UWlNeExSYjNpelhsMVBNcFU2Q045eHFY?=
 =?utf-8?B?bGlEYzFsd2VEYklIZXBqMmREeU5aWEVhamx2ZlJBY1QwWVZXYnFzUDZEbVZN?=
 =?utf-8?B?VWZoR1NXMEpiZlN1WjBiQ2djUXlydjZCZjcxZ05mcGQ1ZHV4akhyOCswclBE?=
 =?utf-8?B?YlZZWXppRDNnNmovdGpzMjI5KzFqczh0ODRaNlN4SmUrK0tNUFkvYWVRVHo4?=
 =?utf-8?B?Y1dKMHd2MExHS0lzalNUTytJWXlCaHQ2WTFnUWVndUdrQjRBMkZLbnZRa0VN?=
 =?utf-8?B?ZEQreDNKd1pyWUgrYkRxdmFVcjFpTjFFc2NaRlZaeklCclVhRUhZaWhvTGR4?=
 =?utf-8?B?K0JVaVh0WmNXcmF4ZzByT28vN3lEa3ZCem1BVm1RNE5RT2hENEFuYWFWZytX?=
 =?utf-8?B?SkVBTXNxUExCWkhaUU51NmlaSVBhelVSRnpGeVU5clZNY2VVb1VnM3VCMk1h?=
 =?utf-8?B?TkZIR2tTamcvNmw0cWZOL2c4ZnI0UWxsaVM1b1IzdU5GTTBidFUvaFFPT2px?=
 =?utf-8?Q?JNSrwS36/hN0jExNY7thXLIyL?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e4a9b8-274d-4bb3-026a-08db82bb16da
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:33:45.8510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n21UeX8ZKWQJQBCkAU2QP8S0ikswoNqlMDzYayv6x82ywOLMe57LLUwgadrb/joAhiMoU8pkePJDFByE/ce/Ow==
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
 drivers/cpufreq/scpi-cpufreq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index fd2c16821d54..28f1e0490af1 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -208,11 +208,10 @@ static int scpi_cpufreq_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int scpi_cpufreq_remove(struct platform_device *pdev)
+static void scpi_cpufreq_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&scpi_cpufreq_driver);
 	scpi_ops = NULL;
-	return 0;
 }
 
 static struct platform_driver scpi_cpufreq_platdrv = {
@@ -220,7 +219,7 @@ static struct platform_driver scpi_cpufreq_platdrv = {
 		.name	= "scpi-cpufreq",
 	},
 	.probe		= scpi_cpufreq_probe,
-	.remove		= scpi_cpufreq_remove,
+	.remove_new	= scpi_cpufreq_remove,
 };
 module_platform_driver(scpi_cpufreq_platdrv);
 
-- 
2.39.0

