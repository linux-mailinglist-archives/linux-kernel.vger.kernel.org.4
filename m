Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E335750112
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjGLIRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjGLIQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:16:40 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2137.outbound.protection.outlook.com [40.107.215.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C801FC3;
        Wed, 12 Jul 2023 01:15:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYhzeHDpQbEq190LouZNXvuHMvlW1J2Yur4UwpQP1+fr8x2By4ya1kwIlkmhyqrWNF2Ia/sMHawgzQ8ryJCREk+R47ZSmHON2nLdC44wq4b19h9PqEn5WFp0pN+NcfBXOZPoPjA85QsbXUroQ0mvNhUfOMDYCYwo+0nVoUM7jel0rj01K2cAP8j70GFIF2bM4lRJlXyDSy6rbKycYvZgW877MBdgNZ3sOeEZe1w8AN0MnBh5w18MQwDhqFv4ldGh5t3MFjOHlxeTY5sntrIZ3ZY1gGQmD4d21cK7s3dZ6Pe/6VQRvrBFahiQu3Fo1PAEL1mrmAHI59zYWI1967FefA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFgJBXXEtiM5Mp8+y5LGgXWr+IbVRZHIo9JtSR+Nias=;
 b=eNxCydeL8thsHi14Oe83QC9nQN+7vK42om7Z38aRmNmvWFw/gOAb1+t5no40U8MDdmMxM8rntvQhCmRQHbwCDjTt5qzjbcSSpN05Cpte0kwNmhW/0k0rkI4YxwRrbU/enNSmpUNl338AKM7aaQy3uIB8humiucPoXPNzwbj3etlGQVAFHjRxzfKdIppb66zxui51LXFlB9DIg+62rTaXXpHo3NwEIA2i99FzCrIt7bkOu3fYsXs2Y/hQwWRfA3aaLGVIaCLUdm0PDyu/2b44JvsD/UsmfukfbWyei/DXmLl4fNp1rAKe1sv+DkWDXa6mX/2GCwta4is9naLEo+Q4IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFgJBXXEtiM5Mp8+y5LGgXWr+IbVRZHIo9JtSR+Nias=;
 b=LnSLxCOjj8hK5dw2J2sG5jTZ9PQGQefCMdgtgViAFn1GQZ5UM8tZZiaVw6lS43+nigeAOEpgf6kbawR9QfyTu/s6Mw2AUxEObvz7KjLgFu1tMm5mh2PiQyAv9BW2Ibdx+LYVmI21PG7rIh4OCCvaEfiT9jZV8i//EGMnzxnEewSglN61WDp8NTMyWoc03hJdt66bSN5+ThFXQ4FUoIZzKP8ZzM5wZSEiqREQnRiCkvxAtWA2u8CcgHDeJxl6/IzzU46NT0hJ0ZsvL559EXR+vpXLT+HtubxM7hbgR0enwAgSsfu38pSGyKJzdUe4JaRsw+cxR3gRdRoD7VnBW7UzoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6524.apcprd06.prod.outlook.com (2603:1096:101:171::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 08:14:23 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:14:23 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/27] thermal/drivers/rzg2l: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 16:12:49 +0800
Message-Id: <20230712081258.29254-18-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 92ad5278-6fd8-447b-35e0-08db82b0005f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JSO9DzMTqEI4GNwbdWHyUxwf4JZGV7nW731QrczKEKteejxr5yJa3ap3k8DOi7kqAytBbCm6RaHLxPJ3gFsoKUEQN+ThlHpvSY3FW7e+214k1d9AQsSS1bxA9l94aeHX/fOpOGdtAbJBGa3h22TOS/wC1dLpIlN815TIxytU9hg3nMBAWcC9WMFIEwitkHyhOVyoqu7j/dqp5duKhv1e33GP4MzCLVgtoN7bkSitS7YpVA3H5v9DSz7KSXProq6wT8LmIB+L4vGFlfNvAiVm1z+gIv/sTb6NKeYvG786uYcdyt6Rf6kEN/Av/OI62TiQn1Anam0xhpI7laQXUi4XDhl3j5uddsc4LC2UB+8x+yiNdBbgrAW81gZ8yd4yYacwFxqarFL0pd2XleRsFBgu3Pq2gcmVIUW/x1s70dLk2XFdI9H3Vv/xAeHMtMm0ExjpqN4rVkDKnRxSg6TAREgsvpY6LLwbDVkSFraOeFZiy8A9u4IRViAH9JGMesM6Xc2yG/ezyiPxQsC4sfAi2aEYmPbeDKeO37K4eoECg5XcNfZBdA5TIqL7rF8vlhEMh03r3tO69UdiP978oLxTgx/2ZKXVdFfyLh1e6Yi71uORsTK/9wFk86YrG+eyT2UqdP1c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(8676002)(8936002)(5660300002)(186003)(2616005)(83380400001)(6506007)(26005)(86362001)(41300700001)(1076003)(6666004)(6486002)(52116002)(316002)(6512007)(66476007)(36756003)(2906002)(66946007)(66556008)(54906003)(478600001)(110136005)(4326008)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUFZM1IrcWRkTHFmNVZNbUZHbCtSNDFta3Q1ZW9OSHA0VG9oRWtGTkx6M25X?=
 =?utf-8?B?aklUdFU5QXRBTGVPb25NS1BGWXVKM0EyMzBRVmpBWUpSMlNWclBWelVmWmVI?=
 =?utf-8?B?anZrS0tqMXZac2h5VEJVd0dRQng5c3g5UXhBRmFWUldlNVQ4QzEzeUh6eExl?=
 =?utf-8?B?SWIyYmJaUXBnYmc5L0NPR3QydDhOS0diTC9US1o4Umt2KzltRnNJKzNkaW1a?=
 =?utf-8?B?NTcyOFkyczh1bEJ2aUVOMFZDdE5WODg4b2U2ZTE5SFFQMnBVRzJnMjJ0U1I1?=
 =?utf-8?B?WFo2REU2S3VNajZsYWdGbURSK0syNU0wRktsRmdvQ1dra1FMeTdiVGNJK3NH?=
 =?utf-8?B?ZngvV28rQUxHclVKTVRvTmJucHlKeWhlMnF0Lzh0alcveldnMDh3TDI2QU5m?=
 =?utf-8?B?dytHUTN5Ny9aTVd3MWE4K3B5dUYycVJ3cmdQa1VtRmtOTWJvZldlNndWWHU0?=
 =?utf-8?B?TGtnSDlaTUxxOC9pN2pEWE9MZ3ZyMllOdEVMZXMvVkM2cHluSVFlTlJUQlJy?=
 =?utf-8?B?N3ZEdG1PdC9vREVMT3ZSRVVwVGVpZ0JxM2MrRnRjMSt1VEdIeGJ3QmJEU0N5?=
 =?utf-8?B?d2JMaG84V01nb1prN3BWekkwQW5LVU5SazJoM0p6d2xlNHlkM2ZRcUxDVU1C?=
 =?utf-8?B?NnVFMnlySVNvZnlxL3VFbHVkdHFSNU1uSGMrU1NxK3ZJT3FabFpvMVZhOG5p?=
 =?utf-8?B?ZGRVRFAwQVUyZldJWHgwNmFYZG5waGFYYi9RUFhmSlN4SGZ1ck1qZFRzKzFL?=
 =?utf-8?B?eTVoRlAxYjVtMFJOdGJtODhmbW40RkJUTDlOR2t2U1Y4SzlaRFBjbURsUnFl?=
 =?utf-8?B?aVVUd0ZsUFFqcmt6R2k5L2VHQlRwL0hpVjJ3ZGVuUmNJY0dVeUp2QWd6S0xM?=
 =?utf-8?B?OXlKT0kyMjVpWFRubTF3OG1lcXF2ZW5LbC9ZTEh5bDZvdXkvREhVR0hTTDBB?=
 =?utf-8?B?Nm5zU2gwQ2FaUGlCaWJwOHVJL0VZd0pzRG5wNHF0MC9INnI4RXpaVFM1RGo3?=
 =?utf-8?B?L2hJN0NYUUhXOGlSK0NYaUQxTDJ6M2pnL0NYWHZrcURUL3pSWmxWTWhXOHNU?=
 =?utf-8?B?ZTNCVTl2elIxdmRwQStzL0JHbzNpUllYM2huVTNFRUt1NTJQalc3VWpJbWk2?=
 =?utf-8?B?czNaTlFjeUk4Qlc3U3JPbktrWjVvM1BaMFhSTU1aZHVxbENrMHJ4dkpYMDF2?=
 =?utf-8?B?akd3MUVpcFVoZGJEZjB1SXBqR1haOUQ2VXk5S3Z3UGZneXQ2TUowemNtS2o2?=
 =?utf-8?B?UGw1S0VMY3ZhdDRMR3ZaRzJnV1QvTHVlNUVWZHE0aS9aSmxmQUoxSEhNck1k?=
 =?utf-8?B?T0hoNDR5cTR1THpYcUZpWWtseElNajRJR3ZucXVRdjRZY0krQUxQbE5rWURW?=
 =?utf-8?B?ZTlEajNjemErWHA0QXpnR3lYdDlETE9zNHU5L2QwRWRPM0Uwd1VyR04xMUdl?=
 =?utf-8?B?cE1MWnFvTE1sTjNlSFRFWUpUWjdXd3Jtd3ZQeXhVVURzVmhrRVl1Ukcrb0ZW?=
 =?utf-8?B?UXB1UHFEdDZwSjNaaFFHSHIrczVNNFgveWE3WGZEb09ldnZxQ3E3RXpvQTU2?=
 =?utf-8?B?M09FeTB3dnRYVS8wUHA3M3FpNUZDNy9BOTh2eXI5OTB2T3JmZEVHRUpmS1Na?=
 =?utf-8?B?bnYwbEF0ZTd3REhIMU9IZGZVZCtEOU5aUk1ZOEhCOUo2LzI3d29qWUpzeEp0?=
 =?utf-8?B?R21JTTFESnpOMXFWc3lCOFZPTHpHMit3cHBFZVlVT3RnL2dOZyt1SHdFQ29i?=
 =?utf-8?B?ZDJ3YUpwM09qR1ZOYjlDRXFWTEg3QWQ2SEpDL1p1Nm1kalRSR3FPVlVMRWMz?=
 =?utf-8?B?TEdyNGRuUEFxV3Avek0wVGZSRjdzSlo3b0w2SEdhM3FYMlVHRWpkcVBVc3NQ?=
 =?utf-8?B?WW42VXZuVy9Da3NYMjJxMWs4dmFTQjh0UFJxN3BQVkxuVlNyMkJSeE1vZEVi?=
 =?utf-8?B?Z2hpc2ljZXJObkVtOFNLNkF1Q3d6cXRVQzVQWnVUT2tJNzdMK2xkcHBmSkZT?=
 =?utf-8?B?STVQaUlHVmZKQ2pPRXcrWnBmR3VYQlBJUGZXSDgrWmxna2ptWHA0WWpLcG5j?=
 =?utf-8?B?UE10bXUzRUdya0gxcDNYMFVHK0IxKzVYNm9MemtuNSszV0FnNFVNTUc4NlRk?=
 =?utf-8?Q?04h5mtZdi+2ZJpk/mLhk6Rkk2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ad5278-6fd8-447b-35e0-08db82b0005f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:14:23.6654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5jFGA806Yco2Kmd8217AMOmg+rIKcNGdI8TjwWUp1srW8tHJdpdK/r8y67+6JC755dKJsiRtaoCjt3vjnsR9eQ==
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
 drivers/thermal/rzg2l_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
index b56981f85306..a723eaff78e5 100644
--- a/drivers/thermal/rzg2l_thermal.c
+++ b/drivers/thermal/rzg2l_thermal.c
@@ -150,14 +150,12 @@ static void rzg2l_thermal_reset_assert_pm_disable_put(struct platform_device *pd
 	reset_control_assert(priv->rstc);
 }
 
-static int rzg2l_thermal_remove(struct platform_device *pdev)
+static void rzg2l_thermal_remove(struct platform_device *pdev)
 {
 	struct rzg2l_thermal_priv *priv = dev_get_drvdata(&pdev->dev);
 
 	thermal_remove_hwmon_sysfs(priv->zone);
 	rzg2l_thermal_reset_assert_pm_disable_put(pdev);
-
-	return 0;
 }
 
 static int rzg2l_thermal_probe(struct platform_device *pdev)
@@ -242,7 +240,7 @@ static struct platform_driver rzg2l_thermal_driver = {
 		.of_match_table = rzg2l_thermal_dt_ids,
 	},
 	.probe = rzg2l_thermal_probe,
-	.remove = rzg2l_thermal_remove,
+	.remove_new = rzg2l_thermal_remove,
 };
 module_platform_driver(rzg2l_thermal_driver);
 
-- 
2.39.0

