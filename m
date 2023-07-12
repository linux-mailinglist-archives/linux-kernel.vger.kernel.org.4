Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CD2750107
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjGLIQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjGLIPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:15:48 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2116.outbound.protection.outlook.com [40.107.215.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AFA26AA;
        Wed, 12 Jul 2023 01:14:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LN0MV9cJPOPWDFuSV3pEazt/wU7WqYNM4qGzjxNuI4hS1JfGaqO7p36lrDSVKpnkvr5En6RRvxqexYHNnEcKlz5up3nuKVdjJHAy8R8em+Rof+ZkCUZiaFNrLEoX26W0du6nLenpWhlV7ESFkwli2ZCET3RbMB8R3++5UPo0CM7ooECiXV1pDtv5xUpLAREoKRs1R58xKqhZM6pQV5pHipC5Su3sep9uBhsSeSZayY531tS0SrNvR4clSbH6pfVm8FrQoHsfjMD7y9g9uGfwQURZXahXWstO7i26XM993ZeEgkFyfuD3gYvNuHdLglPpTHTtO3P0QtZ0XXqWG5QMzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuytSjqM/X4Fmb98T2znUym9CSN4FbNy4RZeehwR64Q=;
 b=bKwu43lbB+Zigj/jwNj68roqYFk+tZU6N/mBmVgU4D/svcE+DjzQIGE5RXfd2/lBsiQPvaDC6AUJIX+Kl189EQcweptjWuKsVJHPB7vWOmHUDdeMhCzLHyRC8PkCX/4SbBXt5dwU7HtBy5stNv6rBQHoqsNs4Pi7ejnKezP0NyA4wIr66Mq+byQAwJwr4ekC2QZhixMk/1QoN0psNkXPiVZSsP6ZgnHfIz+EK4vbUlDUMeJ/2QLx84jV10x6w+elsnmTcfXv+qFrqRyr47zfrEAK1+tBNIMU7EgaUg8j2nIuA4lW+oUDgunLV3TnlgOI+oVbaVGPV915J7XMf75R4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuytSjqM/X4Fmb98T2znUym9CSN4FbNy4RZeehwR64Q=;
 b=pZjtjQ9hojKTgQi0fDTPmyqN/dixn2j4U3fYFHxB+hhaPlSvlS6YPfdf0UYo8qVlxNUo1Tule+Ctq1Gcx4sXsU0p4NUPU7PpmXW4R59COCGNRk8zUVAitkRYULyv3yUkQjcTqOF5fUmS5I6NqDOaGXlZRqrCYaqMFkAVwKBKBuM3VYBiI93i2IBAxb327+ShkzHCAILOAU4ujb9CwwerVZ/gYCBUfHDoMN+TnobZemkoR08gygEn4URsn3DpA8ILWxARRhargvibsZamJ5SnxCu+Tn44kXEgrOkENc5b06PcercN2SdP6uI/zCoKv8X+DjHTv/C9P67MNosRLs6m1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5382.apcprd06.prod.outlook.com (2603:1096:4:1d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 08:14:12 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:14:12 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/27] thermal/drivers/dove: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 16:12:43 +0800
Message-Id: <20230712081258.29254-12-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SG2PR06MB5382:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0f4680-6218-4125-2aa7-08db82aff987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cKqSeJlSta4qzSXrkeu3uj4EShY9rFoDdS1kKmEcdmtEP6ZNG6+J2PiDtBQXtAVEKRK9kBih9SRjkYZGy1hl50H1KhJBFPR9NZJFevaKy0FdJKVtQzTmOuSz33kSEWc+gtjKLPpi72o4upJWu+9ddx4aIa0nhMJadkEbm+P1Uqu7Xvlk4U+H/SqLieT5DaIM2SZJCydrEmoRw3Hh9nIwVJA2zcGj2LHB0N2uPTWFQacg2b1Hqy+RWwGvV06Hf1CZyOAzD+THHVIWtYL2J7JFHOZw0XUpPwPqU8HFmkiqeiNsZq4DysZo7yeuOYmbmoEGK5DO7uSQjG6zVCNZkbZcIxkJx0M6cwHOhi6mC7CqVTGUzmjO+KvU4iYzT/QL/SYax9sO3yrqyTAn3W0IaUuqBAngwq9N0Y5sWAaUipWeU1Yc4j0RoUMR7ASKu1swSLoLN+NllGLBFocF5je7i2BvfF9NkwmMOYjPfs/nLzaH8gm1QdHeIT3iZs4OfYqsy4TXkhJXV4QJg9IvYYpt1ajp1KLunN0pdIrZFm/qaJNyuyqHxjLY3IwOdAcPbHE/xzmDfEkVqV/Ul90iIzSZKNIL02AyxObeJkNNMsHSrI/cNTmUhZlcLzYPXRYOmRpNrnn7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(6666004)(52116002)(6486002)(478600001)(54906003)(110136005)(6506007)(1076003)(26005)(186003)(6512007)(2906002)(66946007)(41300700001)(66476007)(316002)(8936002)(66556008)(4326008)(5660300002)(38100700002)(38350700002)(8676002)(86362001)(36756003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmhQZE9wNzhFSFFKWEl3QUQ2Zy9UTDRpa3FNTFFrdjFHR2NwNEpDQzZKazdW?=
 =?utf-8?B?N1owKzBFT1BkdVNGcE50amQ0SW05L2UwaW9rU0dDYkZydjZwSTJLbkFxNzZq?=
 =?utf-8?B?ZERId1ZmY25GZ3h5OERtd2xMVExGelpvSkV6QXVMYXBXNlZLOXRtOThWTk8r?=
 =?utf-8?B?ckx4Z0p0cTQyakkrMlpXVGhSb0IySC9mS3ZhdE5zaFRrSEdxTTFPbytzUDVz?=
 =?utf-8?B?V0FBbzdXdjh4M1JMejFoM09HNk1YVjZrbmVQN05URUZFKy9kbkdxSzJKd0w1?=
 =?utf-8?B?T1FEU01zbDBwSHZjTlRzTEJDNnZjR3ZiYkFWZGJnM01wWStnQWNRQ0lUTXdN?=
 =?utf-8?B?TEtxUWo0RENzbFlTUjZ6cUFoUitRUFBaSWFzSDFDeUVlUXlyamZkSjd2VUJH?=
 =?utf-8?B?Z3pvd0tkaFJ0Y1hUVDh3WW4vWVpWeDYwc0V0THlJdks5cHMwYjJpUlFkSWFK?=
 =?utf-8?B?TlQyQVE2YWVKN0NSdURyb2VyeC94SVNOV2RHQTMrUG05NFp1TmxnTENKQVJw?=
 =?utf-8?B?TGdlSVpMdFN0ck9zbDRaSEhJRmFsb2RtZDlPUTRoQlFJaUdobGpuNlJnL1VE?=
 =?utf-8?B?NWtiSVNoNVlOTFJFbUJLbFZmOVVkVkZtNUlsaGpvdXNEWkV0VGQ4SDNnT0hp?=
 =?utf-8?B?T0RMUVliTFhwZVBTZXBJWTN5bWRZR2c3N2cwMFNYb3Nyd2V1NGdjcHNJZlps?=
 =?utf-8?B?MzgxWjcxd3NhbHBjRVpwa05OeC9xVzg4YUdoNmk3TTNxL2kzc0VQU0ZxYXBL?=
 =?utf-8?B?TXhtcUwrdTAxa2c1UFkrZWJhVmdDKzNaeVVkMTczNGxYUm93cjZvSnFhalU0?=
 =?utf-8?B?ekZQK2ZySURVVkpheklQZkJ1Wndmcnl1bWwwSGJUQnFnenc2NWV0RVd2cjhL?=
 =?utf-8?B?ZXVrbjFGdXc3TVhqY0taMEZtZ3p4RGN1RGRjSVhDYmlNbUJSWStycnFZL3NO?=
 =?utf-8?B?clpVMG9BbHlWUk5HcDJGSi9nR1dYTGRYMU5CQ2Y1NUlRRE8weC9QbG04bTY3?=
 =?utf-8?B?ejh0YTJoeW01Ny9Sd3hjQnNST0VQSHJUbDFuL2QxNm5FWjlEVFRGa0dHVXZ5?=
 =?utf-8?B?UGVhUzJDc3ZiUzhuUFFRcnlPaDI5QjVMekV2WmJ3SjErbWtBSlVXeVZqLzhx?=
 =?utf-8?B?VkZrQlRMcjlJbmdBSlc0VERlZUwxbU9ReThSTm5WMkMvNHM5NlBGVXUwbWd0?=
 =?utf-8?B?Nk5wdU9jaU8rcnR6Slg4NmVZSmJTNkdTY3krVzIybXlYQlZNbi9MOXlzSlRl?=
 =?utf-8?B?clcvN09GT1J4UDBybEdqOW1XeFdIZlVTL09OLzJhK21ZOVl4dTZFSFFnRG1v?=
 =?utf-8?B?RHBmOWs2QkZ1cmVqZ3NTQ0YxQkY2ZEhDNXVRSEZkWE1uS09HVzMySmRBNEh0?=
 =?utf-8?B?M2V3bjdZV0dRLzRJcFI2QTJHWHFjSHJRZEczUElHRkF5cDROVjVSMm5uZDZE?=
 =?utf-8?B?TEhzM0UyV2crOHRVanlhL0FLcHdaNnRYUlpMc2F5REU1WHZIM09Tby9CMEFH?=
 =?utf-8?B?cm44TmNJQVdFSXYyY0d6UWtpeGxmczZ6QTQ0T1duYUU4SXIwQjJWbXFDbyt6?=
 =?utf-8?B?eTRSV2Y5R0pxaUZ0KzJZQXV1TWRCdnpZREIrYXhXT3pjZmZ1MkpueDZaN1h2?=
 =?utf-8?B?Z2I3RmMydjRHKzArQkI3ZFgwZ29MK2doN1pKVUdSdjkxUjgzajNWOTl3elRQ?=
 =?utf-8?B?d1NGRjhyVDl2di9hSDdBNkdmRjFMVnJFd1U3TFNydnNzUU02WTRQMWYvUTkx?=
 =?utf-8?B?YmV1ZTVidmlCSktLcmI3TEIyVTM4Z2RVb2lhTjBxUk5QR2d1L3N1QmUrNHpw?=
 =?utf-8?B?bWpndHJRbDFhT2wzRUJzMzN6YkN0MHNMRVlUZmh0Z3p4L21BcHc3dUN4WmlW?=
 =?utf-8?B?Zkd3TzdGU1pxODZPVHhYaWRHR0o0bTJlWlQ3UktqVXBQNXlpcEhCM3daZkNR?=
 =?utf-8?B?N1F5cWE3Y01icUN2eXZBVFliN0Yrak4xYitTd3BOS2NvcnkrRmIrcDFESmsy?=
 =?utf-8?B?U0QzOE1mUlBVZkp0cHdjOUpzMlhQZnRzOUJJNTBPZkRBbHE0RkNDYXY0Wlpj?=
 =?utf-8?B?bjN4cHVjeU1EM0RtdTYwYkRzc2IyWG1MZFcwK3ZsU1VLOUp5MWNnYXBhU0di?=
 =?utf-8?Q?bt2YPLv+Ns+rFXdnLjWNcAITQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0f4680-6218-4125-2aa7-08db82aff987
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:14:12.2183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ys7GGyxgV8PoM7/GxCVW1qnsePiUn8UKe5egGoP33tOVAkDZ9ZTUzGd8rqv6LJA5FKD2ycbrBUfwbCclFfAS9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5382
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
 drivers/thermal/dove_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_thermal.c
index 9954040d1d2c..526c96fd4cc5 100644
--- a/drivers/thermal/dove_thermal.c
+++ b/drivers/thermal/dove_thermal.c
@@ -158,21 +158,19 @@ static int dove_thermal_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int dove_thermal_exit(struct platform_device *pdev)
+static void dove_thermal_exit(struct platform_device *pdev)
 {
 	struct thermal_zone_device *dove_thermal =
 		platform_get_drvdata(pdev);
 
 	thermal_zone_device_unregister(dove_thermal);
-
-	return 0;
 }
 
 MODULE_DEVICE_TABLE(of, dove_thermal_id_table);
 
 static struct platform_driver dove_thermal_driver = {
 	.probe = dove_thermal_probe,
-	.remove = dove_thermal_exit,
+	.remove_new = dove_thermal_exit,
 	.driver = {
 		.name = "dove_thermal",
 		.of_match_table = dove_thermal_id_table,
-- 
2.39.0

