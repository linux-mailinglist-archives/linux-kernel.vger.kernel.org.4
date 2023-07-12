Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6F6750119
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjGLISQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGLIRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:17:33 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2137.outbound.protection.outlook.com [40.107.215.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FF12D5B;
        Wed, 12 Jul 2023 01:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtovODxjYznE7RzaQvNq3KyfOYcddjpvaqupXdMvCXWG29mXnS19CHiknzymrXzqzqWv5a9C6IgrSvNsAwMqWU+e0fgax27o3msD1mstH+Ew5gzwiICnfeayyJ3lCQ5QncpevcTa+svmUoHQGpBIGY2+hgBCv5+AQlH5AKiyatJ/vhOHmCAFUiDEyHhZ2brpc7Em6ralkNS+4Ol1NRhPfsGT213hOvFwNHHuw/3EHOQsu/0t1wTxQ3V/UuSmxXqEn0Qy217vp4xugYiVn68PF7Y6elvpu+FC0alBiHXjZKSX/8SrNogyNiEL7/tNyg+4w2icgA62V4eVg/t3RztXlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7FwGtw4e9f+mAIMZLaLeQAhQ+nQdAGktLRvdZX51Kc=;
 b=k3PSOHVl0elr8NsBQiOb6IbGnnNcoyr1fqYYqdw9tLNIQITb8seYrv4XQNqVrUjUb0gkgO2qBkH0sirNUaWITCeaXxlaHg/ueyYqr3ezp6eG1LrQuj53XmoDBzLZUmQVYbXSlrIq7orqlckd6BJPrS7LZXTzOOlFflQwUTqkKSPkhmREUtaroShWdMJYaVwDo3qRNrf6OWrFyj8c3vwR8HQNCNy0t5UXvW0K1nnJFBpSdyjWKfUeqW9tY4RHs3tHH0hgID3pYioCTghn1SecYzxsGvc8e1JrmbQL4Cl870Z/T/hvJ6WQ0BIo1enT1T6IcVaRoQB+qP4qVkMkKJU36w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7FwGtw4e9f+mAIMZLaLeQAhQ+nQdAGktLRvdZX51Kc=;
 b=lgdT5b5yuyOI6q448rckzQuXbRVzu/iutg+DVgEbNusdDo7CkMWtuykMRzBr8JcbLCvKi6XbmGIxT/mln/TGK2YV88CJshTOF30umdRRm80DfbG2HHJdtQQqOkIa88uIBhErUWurW2d6Ij5SHPxXow3/UTWfI/KPXsm3tVTdN7W1xYIhDnC+ZxDhmZ7A2CUbFjUxI7WYl1q3TrJkNqpb+axlTvjPA5VvXTAZg++qz6bMQxVce26oAkaYK29J7J2EaU4aCOgPIIzKdq9/Q6+1MwhrfXjGF+ZdrOC7blKd38ZL+WAC4EdKUql1DYMRM7Pymt8yfnVYTuekBEwU0uAlNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6524.apcprd06.prod.outlook.com (2603:1096:101:171::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 08:14:27 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:14:27 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/27] thermal/drivers/sprd: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 16:12:51 +0800
Message-Id: <20230712081258.29254-20-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230712081258.29254-1-frank.li@vivo.com>
References: <20230712081258.29254-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0208.apcprd04.prod.outlook.com
 (2603:1096:4:187::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b73e176-a3c9-41eb-010a-08db82b0028d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KAS7ZB4mmu7igjU77C8Y/OweqIpRdBvKupMxEH7gfWCbAZMMVPjx3HemdqdexYEG0fKDvYNiWxkJuM++lTZrNbma5tPfYCkJ6gCdHuojCfrMje9sZu/N8O8oeXhb+jKeLYdQUM423+VzOYDY87d3QF1sbi6DAIpB1jfrofhUOwrEXMSdswXwnSNOIpPTXZ39Yyr0mjFlxh75n+mIYD1QylS+P2uYuqYisfj/QNEOQ4W1iZuk+YQM/8agGtnT92I9kB2Kyw5VKuJFKia9NpcyyB6VQ18pUPlR2JvyxeTVsf8QGDD++98+7vAup559NThCqTeuQfH6wCad1vuxQAu+q4s8d20xPRBelm6hM2GMVQG+16xyoSyqkpRlKn4MvW26iwlPUgLH+ASMtQMvQ9cKuwt99rReneqDjqXGQl0tXRRhzpxW5gQdRVId3Kwfa+FfAOHMeM3pIJ/scOAqS3bPeE/NNo+2L2XzDdBNk68aZiB36MsXxEVsmThtmGLZLNu5+qn7xVGgoO/S9IblK3x5dV9b1oNwj9dHrNtiUUmWKqHi7SBqCesvlscZcveySO4PkNFUEM8mvSHEFMRKTj2CvjBJ8EQawDWxFfRbg7LaHc7bJfddes/jQ00u4O9x3mTy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(8676002)(8936002)(5660300002)(186003)(2616005)(83380400001)(7416002)(6506007)(26005)(86362001)(41300700001)(1076003)(6666004)(6486002)(52116002)(316002)(6512007)(66476007)(36756003)(2906002)(66946007)(66556008)(54906003)(478600001)(110136005)(4326008)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHVsYUFKVnA0MExOQ3FPSU9Yb0NOVFBGYjViZUpxTUdLVDB3clR6YnVFaE54?=
 =?utf-8?B?bURMMTdHcjFycld1a2QwdUJCUU42WkowUVJlRyszZ0RiTEErQWZUbGxCeWpH?=
 =?utf-8?B?TkVnYk0yaU9EYm13aFY0bE1wMjdkbzg3dUlmbTZSTFBEdlZSM2N2MmJleG0w?=
 =?utf-8?B?a2lueXhVQjBxNDdHVHRoV2QvUGgzS2FYTjJIRVlmY3FLRGN0cythL3RFcWEv?=
 =?utf-8?B?a29IcWtSMXhWWmYrZXJQZk9aQnk0aS9qVGp1Rm5uNTlrd3RRUEduUTBBclRB?=
 =?utf-8?B?VkJPUDdwaHdmWmN6djYxUnJkRXJMUFUzWTZNWU10TEZJMlYzc2JtalNWeFhF?=
 =?utf-8?B?bEZ6ejZVWDhzOXFVV0lseUU3cVo5MmNuZzkrNnRtYUhTRXpMdFpQc2JGd3RW?=
 =?utf-8?B?S0lyWGRYYWJnakpWYnVSSE5ERGhiY2tLdVc5RG1Qa2VrZzJBU2puL1BzNXdQ?=
 =?utf-8?B?T0RGWVBZcDNvWks1OWE5Wnlxa3lOcHZHLzdDcDBaNzMzMFo1SmZ5WHoyMFhK?=
 =?utf-8?B?bms0VWJ1bU5kUHhwcjJYY2tTaWVQSzBoMlQvM0NGLzBvaFh0Q1V5KytML1hU?=
 =?utf-8?B?TDMyODArVzc1V1NSSkVsZFdTWWp6eGV0MHd6cUlSbFNzK3haY2tyQURnWUlv?=
 =?utf-8?B?Z0xqL25xbzBhK3RMYkNjODlBOEI2QnZWaGJqTzJNOHBtSllQMVNVNnd2TTdN?=
 =?utf-8?B?RjVGNUljYXlteVVYdmtEaGpXY3owVGhxbDlxdU5iRkIzd2NhNW1Ld1NXVDM1?=
 =?utf-8?B?VTVVeDNWQjIxcHdQNzhHZklIMWFLS1Q4UFVNdGx0YUlDNlJ4ZThhZ3pocVVT?=
 =?utf-8?B?ZUs0TStvcmFDNUdlYVBWV1ZWanpsbXIyNDFGUmloT051UEVkVmFrNHp4TW85?=
 =?utf-8?B?SjZpU1pBREVvWm54ZGt5czNkVjVFYUhGM2xWWWdHcnZndXNxNTR1ZkFmV0pm?=
 =?utf-8?B?OUJRS1RFMngzMmcrWU1vMUxud0FLWXJCdU9tTHBQWjdTQXE5cW1IUE1pOUJW?=
 =?utf-8?B?bzRIRDdsTlp6VGNpczRyV0d3aSs4dUMvZnNCK0JHckFxVnY3UjFQYkVGazhs?=
 =?utf-8?B?UURPaEZYWGdjQjRnWFhBTHpBY1d3UHd0ZUhqWWF0eHFUb05FV1RPblN6S3NX?=
 =?utf-8?B?NjdWelJYVy9VYzJLek5zWEFOV0xNSVd0blhzWWNKNFVtVThzQzJPSXY4QXhJ?=
 =?utf-8?B?RW9sZkc1ZEJvK1VQU0hKUk9LZHpNc3Z1bWMveTcyNTJTd3diTmg0MjFlVTNZ?=
 =?utf-8?B?R1BGdkJWNVpTQ0JLclozek44MHNPN1JTM0RGUVJiQ210dWtDSnYrK2RGMEZa?=
 =?utf-8?B?T25jL0hhYTIwL2YxRndvWkdUK0Zlc2RjM1JaK21iNzF5ejhmTXVxRmp4K09q?=
 =?utf-8?B?RVNySE41OEpya0swKzhya0xZSUJ6bjh0b2laZElxSXFsVkRIL1BoUHVBUnM1?=
 =?utf-8?B?aDRrbzhER29jUnYxZktjeWZmUzRQSmRsc29ER0k3ZFJETUQ3SU5ZU1BqT0pw?=
 =?utf-8?B?TjIvd3hQQk4zc1FpMmg5Q1hjUDM4Rm5VcEN6clZmVVdQNGx3a0QyUXg4MXZq?=
 =?utf-8?B?aDg5aEI5bXo2TmJiT1B2MVg2U3lZejdHUy9US2x3emJxZTV6b1VESXRmek1r?=
 =?utf-8?B?dTFoZk8yWXkwZFVnV3B1b21VMFNsRGFGcHBkZEN3NUsySWR4VExsZDUzYVA3?=
 =?utf-8?B?S1VGalBOYVdaRGZBc2FKdU1HUlNoZ2lyZENoR2VseFJpVzJFQU1GckR0QWI3?=
 =?utf-8?B?QVczUU9WenB1MzBPeVVzeEo4dzY3UFkrS2dYbUV4NnFNRnlzU2NCVXUxUGp3?=
 =?utf-8?B?ckVqMmZIQWYvS09Da0dZYzRKVGIybmFkU0FQRStIVjc2STBMZkd2T0tOK3Ry?=
 =?utf-8?B?cWZKa29uZzJ5RzhiQ0pRNmpmbXgrY1RyWWdQdW8ySUhSQk93WXo0T0VRWHhX?=
 =?utf-8?B?Sm9NRjQ4Rk5NWEdqQXhuNFRzZ3RyZkVXZVM1MFE1VGRBUDZHVVFQNy9QZ3dH?=
 =?utf-8?B?dFljZmUwaGQrN3ZqZlY0RXVlUyt1b3g4QmlWOWpDelhpZHNJYkZpSWpQcVhB?=
 =?utf-8?B?N014QkMzTnB5bjU4Nk4rK21nSjFKVFlHWW9yaFh1cll2MmIzMFhnOVFSanJP?=
 =?utf-8?Q?0HXaR0JlTdEIqkPwwE+waN4HO?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b73e176-a3c9-41eb-010a-08db82b0028d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:14:27.3056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqHXXueky8Zuyn3BWR7H9mDtgAvtZk4/LD+FLkbgt04ZnkdyYyNikPC5tcD2IvaOXJsyRwtwy6YTabl1icwmCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6524
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
 drivers/thermal/sprd_thermal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index 2fb90fdad76e..0546096f7e2d 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -516,7 +516,7 @@ static int sprd_thm_resume(struct device *dev)
 }
 #endif
 
-static int sprd_thm_remove(struct platform_device *pdev)
+static void sprd_thm_remove(struct platform_device *pdev)
 {
 	struct sprd_thermal_data *thm = platform_get_drvdata(pdev);
 	int i;
@@ -528,7 +528,6 @@ static int sprd_thm_remove(struct platform_device *pdev)
 	}
 
 	clk_disable_unprepare(thm->clk);
-	return 0;
 }
 
 static const struct of_device_id sprd_thermal_of_match[] = {
@@ -543,7 +542,7 @@ static const struct dev_pm_ops sprd_thermal_pm_ops = {
 
 static struct platform_driver sprd_thermal_driver = {
 	.probe = sprd_thm_probe,
-	.remove = sprd_thm_remove,
+	.remove_new = sprd_thm_remove,
 	.driver = {
 		.name = "sprd-thermal",
 		.pm = &sprd_thermal_pm_ops,
-- 
2.39.0

