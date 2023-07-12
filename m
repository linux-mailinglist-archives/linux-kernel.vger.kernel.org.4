Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D697500F1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjGLIOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjGLIN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:13:56 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2107.outbound.protection.outlook.com [40.107.117.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7CE195;
        Wed, 12 Jul 2023 01:13:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zbx+RKPfOcVBknTlxqNsE7/vQ2KIuwsPNxAoiGy0uYfAkUQydN+EFz4Fpkt3YcAu0ojxs/QRvyhpLJCv2TUJGWFQ85P+ntKFhrK+3ZrC+IJQ5+rAnkLpiY+b17ecx4SxdUU4YQKkWH/UBSmyPM5D0uonMhFCgGjqh3nl4M5alNMtViCrRVre+ABnbFREl/EtT7T7kv8VaHSBHTNIJSyIn0mb966Kk7F6pF5A/Q0kKF4pL2MYpjhqGb7umfDjsQI51n/o4s8K5ZmRWt4C/JKWazVpup239pHo6gGGfHfcsKvYxkismUcLTNv1qfeAyTFtlUxN6E0pjUnIWQiDHlpivw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyvljtpagtsfnuAKvlq6VdiLKjkkJMSxKhFNYW+BGnI=;
 b=kOEUxDiW/1pIIM3Ymd+loW5UDcb8/n0/m2l/odYxPt2qAnsjULdr/J9/DdSilReAyOY/66RUT87T7T/jANONlrrNqPdWUlKTPUOjT80obtmnVfvS9qfYIn0t8oSZmNDJnQljQ4YVlX0IBf6AOrI1ynFZu2FEDoM30Ic2bRlmnMD3ps+UpzXqzzqKfOOK0Uuxean/uUKuaMe32av3DOAYK0VfW7iarlD5no7/hGsP4aaylDITfFZCLfkXjiMxe37C/NI89mWNcCXjHJRWqsO2IHon8Q/YpbvGnF8b2LX29tmBW9n61gsbkt9vjSz5NOWnHxVBQfQEtiYrXgLKTVNRpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyvljtpagtsfnuAKvlq6VdiLKjkkJMSxKhFNYW+BGnI=;
 b=OB7Y4qa5Sr1zcDPOwH8317SUQWQzDaH7ITzlXJISf2AiZNOAxHXPxI97qj53WxkLUgJ/ykkR/vt+khHRgG7qE47au7rQtWpzvgIXJQ5cSLpECN/ddK13L4ZADcoe7IpaFNy33puZFgCre5WMYQpkMDmq0JyquMdKUUVvfowCS2yfp7uVTX1rVWPlBM6HUmKicqMYjlGtcM6jjkzJF/I7uFgehr2eQfwaVvL5qb0syWJvsEcyLc+ov/Vmbw91SAEERijoHNxUZtCMmlRcEMtrVlUIR8RBe0w6xUXGQgI2zpds0hJxj3WGD31SzffscDejqdMFJKOMoKVA0+fTVsGPDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5382.apcprd06.prod.outlook.com (2603:1096:4:1d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 08:13:52 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:13:52 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/27] drivers/thermal/rcar_gen3_thermal: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 16:12:35 +0800
Message-Id: <20230712081258.29254-4-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a372113a-ca4a-40d0-d086-08db82afedd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJ51T+ZoCoXSZN8t/Q3cEF1xlqMyUoFtOWLYfNOePi+nP4r2pSuTDdmx2CZT2pNRZkBG61p5xQCpFQ+MpM97p1IzA6HHp8b6nqIl1p9H8T9eW5l3c7399uXfYo16TQGmPgod9dELFFYlCvBtQwXPu8cV/hTi6+5bH8GXkqur6nStbEDWYqT/FNQ/crrnHkpSXH1DlkYnNeOKwsPEe7f0JEqfRWd7o2XEqNR52QovBKeHAOp4gJ8cSm2UiL1LUEnNw/wB+6kgg8ZjybDBi1bHYPOuDW0Dh6r2d6jZTGFhCgaNIyZGU3AFRWxih89LjkjOzOibctMY884J/bP+DtQZwAoSEj8AVVqeweqa8YRTQTtS9n7B1nSAYE+nSwEeisPbE2Bo9ivDQf9pOjxdd9ESIzHgzZq8kp0+wWNu29s/Wb+Id5G7ZIYgSZnMtJcrEq810DviR44RCdgT6FTEFPzQPo9uWz0WrRoki0tT2F9PnPCyrAVKfYiW6nizNOrg/OAruAGHpJESKMuSJVSn88a437euoXXd6IeHxP3WBnSCkqK9j+TcPIHMHI16qozGAUEISq60u7/3MX1OKo+YJhTie4G4nMdIK5gn1U8MdnpYidgvq3UMttNQ0t96tUit2Yqp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(6666004)(52116002)(6486002)(478600001)(54906003)(110136005)(6506007)(1076003)(26005)(186003)(6512007)(2906002)(66946007)(41300700001)(66476007)(316002)(8936002)(66556008)(4326008)(5660300002)(38100700002)(38350700002)(8676002)(86362001)(36756003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0RmcEgybklnaDRjNnpIc1J1SGNVcGxFY2lyc1ZaeHNuS09VZ2MydVM3dmNk?=
 =?utf-8?B?eUtuekE4elNmNXpCWmorWUdDOWdoYUNMT2RaQ2hZRDEyMnVUZ25qb3BrUDlG?=
 =?utf-8?B?U2Y1UHNLaWYzdU0zekh6ckNqL1ozTU1EZXR6Y050TzA4RUhjRXFkcmh5Mlls?=
 =?utf-8?B?UTlVc01ybUxadnh1TDhYSCtnSGJtR2N3bWU5ak1FQjdnbCtndzNGdHdtRTM1?=
 =?utf-8?B?azhhbXhNallpNmVGdGZIeEUzZXhQT0l6eFF0cVc2RTJBQk5SSUsyUkJxSTVw?=
 =?utf-8?B?WGhiRE5Lak9yMG9sdmdxdzN4TXUxc2Nlc1g0Z3N0QWptdUQxcXpzQS8yaDds?=
 =?utf-8?B?YXkrL1o1Z0Q5SzR1UkNMZkJkSFB3ZG1xc0tkRW9aWFkxdmRoSEx5MUs1NVNs?=
 =?utf-8?B?K3RueUQyU2hOL3dFeEdTb1o2N3NteXlJc1pkazhjcHBUelI2K0psYjJUck5V?=
 =?utf-8?B?UytoOFAxYmJYT3pUOXVwQ1hLMjd4UjBxbElqNDRyVDQyM1NtUm5yRzAxYm9R?=
 =?utf-8?B?KzhhSFhPMzU2L0Z5ampMeEZJbUI3bndYU25KSFZOakhzam0rYkZOV1FsQ05J?=
 =?utf-8?B?eWJSU3Z2V3NUdUNjK0h4VVVrZlc0djMrWkVUcmFlb2g4ZGFYcDlCcXZXeXU5?=
 =?utf-8?B?VmYyMENmOWZ2MExnYjdnRHdQWkxtMzVYUGsza0ZGY0pYQjZyaCt6V0IxYk10?=
 =?utf-8?B?M3F6SW5EMldkb0FVay9BMmYxMGNNMmxXYTU2alg2dnlMNldkMHJoTDRLMnN0?=
 =?utf-8?B?UDd6dUZVZ3ZQV0QxRDlObXVUdHhBKzlLVzN3SWtlNEZ3ckQrM3ZSM1FPY2w1?=
 =?utf-8?B?ay9ENFhBY0dyYWJCZzNianlKUGlkRXdmQitadVUrNDRDbmxKOUg4cWFER0py?=
 =?utf-8?B?TXAvRFBKK3pBMHJlajUwNW9wMlAxeGVtUy9OQlZhUmFGb1N4cnp0QWJwcGx6?=
 =?utf-8?B?NFRwMVB4R1QrVXFhUlEvZzlObFNZd1VNWjVxcUhGNGtXeWF3S2xoMzVrRGFx?=
 =?utf-8?B?UkRiMEZnZ0U0VWp6RW1TL3hYZDk5R09Lc3VkS3FWRTlodXhNUlFkZmdCUjNh?=
 =?utf-8?B?amJLZDJtMXVLNitPZDJMN1JiMGVvQWF6WmpUUzRwQjJyQVJ0alZmM3A3ekty?=
 =?utf-8?B?Mmlic0p6enV4ZjNXVFBwbGowUVlIOWJhYVR4MUtwY1dvVGE2TWRuZm5wTFBS?=
 =?utf-8?B?OGdHTXJKWmlXdWw2Z1F2ZmVFaCtoR3MxREFuY3c0YzlzVGZ0M0llZ3JHQTNu?=
 =?utf-8?B?anU1a2VmMzIzdVFKMmx4T2Y0T0pzSkRBU2JrcW84UkFlN3laamhydEVBUDhH?=
 =?utf-8?B?Q2xTN3RkaXlwZmRrU3NvWHZoc2ZpR1lVWXdJdWlUZWVTQ2gzYTJCKzdRczMz?=
 =?utf-8?B?SldvTmNGR2xXeEU2dm9nRG5OeEJybysxUERramdFM21Jcks3N0tKTEVUaWtv?=
 =?utf-8?B?a0x4OUdVZDBCbVNKTDRiOFZmRzVPd0krb1VZVnNJcktZS3BOWmt3WERmOEI5?=
 =?utf-8?B?Zml2MEFQc1RGVm41YlAxWTJ1WW1XT1NZSVNBVWFiS1VFeDdPWUlQWEJjMWRy?=
 =?utf-8?B?MG13RHM5WkxGWmY0V3RNTytEZWMvTjhiQXpaMThSNjJ0b0lwQ2FxV2pMSnpp?=
 =?utf-8?B?QnYvSWtSZzhpNk8vN3MrSzdvb3gyVC9RVlQyaU5lclE1aXRDM1p5Qi9USjFE?=
 =?utf-8?B?T3pxLzRKMVQwemVTVko5UWhXTk5HbG00dDVqMHJGRmp3WWJYWFVVZVBxQ1RQ?=
 =?utf-8?B?MVZIZTRFbmsvUU9TbDZtKy9WbE9FTFVOQ0wzK3BMS2NEcXJlbVRZckhXM0Zy?=
 =?utf-8?B?YWh4ZGJmK0pHVHQ4TlZGZDBRTXI1UFVqTW13cU1aMHB2emZlc2hJc0FDdDcy?=
 =?utf-8?B?RGtRVExDR0M0TE9GSGVzZ2t5OHVLeHduVGZaVHZnYXgyWDJ3dGw2TEd6d1Vl?=
 =?utf-8?B?UlZFUTJQNE0yQ2FUSHphWVh4MEdpdXhteHlSS25BaWtMQmdQMG01c2xuYWtk?=
 =?utf-8?B?MVUrTm5zT1dBemJKZjlxTFh6OUM3WHhtVS9sOEQzNnhwbmRpUnM4VUh0Q1hH?=
 =?utf-8?B?M2VObDNCS2U5a2dnbmRod2MwdzZJci9zbDZBY1RpTy9FbklJK2FRMzFnSzlW?=
 =?utf-8?Q?IS7KdoaMc70PyyEtjFbZgXOGZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a372113a-ca4a-40d0-d086-08db82afedd2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:13:52.5430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozMT979mJAxXw4mN/lcAxFUPK1BTmyuG8PrTjv44MOtjRez22EuifPW+GMX4paKgf+N0btBdDLnQS7hyaaHyLg==
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
 drivers/thermal/rcar_gen3_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 9029d01e029b..1405163caa34 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -432,14 +432,12 @@ static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
 
-static int rcar_gen3_thermal_remove(struct platform_device *pdev)
+static void rcar_gen3_thermal_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
-
-	return 0;
 }
 
 static void rcar_gen3_hwmon_action(void *data)
@@ -594,7 +592,7 @@ static struct platform_driver rcar_gen3_thermal_driver = {
 		.of_match_table = rcar_gen3_thermal_dt_ids,
 	},
 	.probe		= rcar_gen3_thermal_probe,
-	.remove		= rcar_gen3_thermal_remove,
+	.remove_new	= rcar_gen3_thermal_remove,
 };
 module_platform_driver(rcar_gen3_thermal_driver);
 
-- 
2.39.0

