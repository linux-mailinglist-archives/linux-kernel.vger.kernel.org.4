Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B88875012D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjGLITY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjGLISb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:18:31 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2137.outbound.protection.outlook.com [40.107.215.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C522D7E;
        Wed, 12 Jul 2023 01:16:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScbyEyyZkmp53JTPqryXo2DgaI2X0Cqwv5No2+q1MZ2lDWSk2Kagu2ktFt/AcCskW3ipbHh37zthEiC3aP9aXkrwu44DdE4ZwwU5QfTxCtWITllY62R5fAGFBIxw+2RZJiU92Xgs6BOfLZkYVjsJZLZycTWaj7syBib72mwex6t7r0e3wUdOKg2ZlEQH4nkud+FP7P7XpK4Lxwc7TniTxRLdokRsO9Q/OdV6zYCC1cx6BZO7/7B0rOQNehIsdjTm2jSsX1w0KZDmtjos9sl3l2mVI1SC/6WJ7teJbUxjxZfNASDqSpznqUmjZMqAj8XKtCZyI3IcXrj4d7RueXvd0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhP46AB2RhUS6oqayVfe/eF0wD+5UJFy3MIxYFrPY9U=;
 b=FRdSIu1EjWAJZVERld1UXVVhPfBCyDG89Cq6Xds2I3n/zf7miK/tSfrfha2Qb+9Qz5UdYdR/gKoxfkDmzpBzacDFihTm7SXR1Pm/hQ/qmBm3Gx1CqQ4Di9T/yKCk9aW2Ib2aAmf9olVQJUBF5BxWP/USiaxOHoxm15XV3y5j0PcCMWFzr11y+guG/ZNCHwqtByQANI+irJdCL+U3Mo0WqBO4HPL2FXUaNZN4GmYFABABbcV7cLrAxtPBUCQ2/nhJ5DpuQNYy0iKuF/sdUJG84yye8u/R2l/1CUt27VmvCPzSFnVLzByuagPpiF2FlBLzP900xfgYTQk+rt3Xl43KgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhP46AB2RhUS6oqayVfe/eF0wD+5UJFy3MIxYFrPY9U=;
 b=LRGitOodRjNR3NiZ+0usCFk7tB5x4aLA31VYtRdW/yTh5ICrdjBQJw4SpjyT8e0Hr2TBxYN4OGqMq9dBpiySlK8DpInCZUMuYEr4fPGOh+DLk0+fYhAnVdsTbGT8p5DM0m0Vbl+v9urmQd7z33Dg9/GuzIsbv+Hz7O0Mu2de2CCEjJdeHo9XVpNw7SFxGiTWxDRqs2FQnRA7svA4o6JMMiQU1cVlz8PD3FdZ+fMH08s98Pmy0CP/7WXXsN9+cFDAek2G59n8zku8bIr5teV6xgeAaNI6dMtnAE7q/kpCqkUHuJGozz0w1qpmWHeVuSvaKgqg2CzlRaBLc+5lmKqY+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6524.apcprd06.prod.outlook.com (2603:1096:101:171::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 08:14:31 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:14:31 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 22/27] thermal/ti-soc-thermal: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 16:12:53 +0800
Message-Id: <20230712081258.29254-22-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 937f8d88-d09c-401a-fc12-08db82b00531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GMxUaieA4cUpoatiAQ+KBaUqiS3RKnwvbpkAHuLPqin/lI0g3hNDulvFWQMOENZXpgSy80dD9hI7Xsfa9HLsIQ8WG4uLOUC4Lb3jC0l0X2p3clBZ/ls3ZXvslIB2a0Z/Fs2c2qBcr9cXOBgFW+0TPIMySRYNUFbdxR5LFNjSe7/BuiX/BxksErU3amak1bfWj1VQ8rDr1McFTGDZiPVmURNVdLbb8EpZS9jDCBE3Lh8zjCjEsCFVKD/ajSuT4r7EDFeWnmT+R/GKjXpoPJyTLQXMxMYmNcV3l5mBKwGb4H5k6P7Hd4xWa0vHEplSJIe/6HY+hhwBwg+OAFmppiDSXyNq44E5t9cvegC9Nr0lsnmT6HYj2v/xlsbXI+J3q3FTi7tiQO+uIcXFpWi567AP/2wZRLiyfPeAHpKkKGtB5vH1regwTb/ZRuKEMDd7/WCVSYycaRXtNzFJs1UAt+w/nplQZp3uAl05bg7uRc/L4HRPgbdZgQon2L0/JTgd139/Sc9tLCeRPYqSrWfdj7mYJnPa0i38fDwvTtVrQqDzE0DdjZHXLbgrjVzIcD1laxf+R6dEx6z3rakA9HefCpgZ7fTgzYOO+yPjA0WODdVKIcsCoZcEeUVcKchFDXkOI+sp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(8676002)(8936002)(5660300002)(186003)(2616005)(83380400001)(7416002)(6506007)(26005)(86362001)(41300700001)(1076003)(6666004)(6486002)(52116002)(316002)(6512007)(66476007)(36756003)(2906002)(66946007)(66556008)(54906003)(478600001)(110136005)(4326008)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUw4Uk5pZTlpaWNNK1pOSTZXQ2lJQWdCa3BuV1MyTW4xeUZ0Q1ZyL0w5cm1I?=
 =?utf-8?B?MXAvclZpaWo0V2VnWG1IYUdyL3JPSXBJVkQzcU80RDYzZUUzMHBLN1g5elQ4?=
 =?utf-8?B?d0ZpV2dJeVg0UkcxOW5BQWxUOUEzTW1KaWlJL3lkVEJGaUZySHFlOFFac3J6?=
 =?utf-8?B?emE0WnQ3SFJVRW16YWc4ZGhFZkREMGFRN3ROQlRHbWMxK0xTbGQ3SE5lby9a?=
 =?utf-8?B?OGJOcnN1czFxaEIxamU5bVRVNWlHRUNQMHQxUk1oS0pRQlJtSXBWcE43S2lW?=
 =?utf-8?B?cGdyMUE4THhJcXoyMHpKMDBZb0RXZTBMenQ3WTBkTHk4WnJuNnZGOWZ3bERE?=
 =?utf-8?B?VmRWc1NmME42VG9ZWmJObGc1Z25ObDEwVVNiN2E3RDhacW9zQm04SnlXODQw?=
 =?utf-8?B?ejRTYlRrNVJUOHNuN1NwTlFqek1SN0xWMTNBdlkzQTZYWUhHQ1JKZXRWd29R?=
 =?utf-8?B?TlVsM0tEdHFEc1FMVUR0L2JNT2cxazlHS01qM2h6Mll0eFcwS0owT3IzMk0w?=
 =?utf-8?B?YmFMUGNJaUdNUHpaQzJFK3djcUljR0FzSWV0YTFHc2NxRTJuL3Y0SVljU3VD?=
 =?utf-8?B?cjQwbkViTFNWTkY1YjZnQ293c2d5NVgrVFZuMW8yYVRsVSt4K0VQQmtORy91?=
 =?utf-8?B?Z2RWOFhiN2pyUlpUdGRpZDQybjlJQkJaTk95TCtPY21FTzRkYlVGQmd6VHhq?=
 =?utf-8?B?a3VGMy9OQUZWVmVVMnRIQTRsdXp0aHNwUDQ0cGkzckdMVU43S3NRZVVHc3By?=
 =?utf-8?B?cTFWdFI2T2lGczQyQ0xXb1h2SXpYWmhwNWcxbzRheUV6Y3dLeWV5dTRBUjVs?=
 =?utf-8?B?MDlyaVl5WTBZRkQ1ZFFTVTZ1emM5SlY4Wm01UWJPZzFWVHhKT2FqRHdlNjRW?=
 =?utf-8?B?d2NNVXRmTzh4MlVhRW43Q016OTUzV2RBZkxzZWZyaEpjMGQ0cDN5SlB0TFFs?=
 =?utf-8?B?VCtNakszbHQyTkhlN09TSXdITzNWQVFBcEd2cG40TTZjay90VFVFQjdXRm1y?=
 =?utf-8?B?Wk43cXRNMHRyS2tZdGJwL1R1VGJDMmNEVjdRSlZ4bFh1NHZQbCtHMDdCNjhH?=
 =?utf-8?B?aDBQcVRYcXBzT2FDVEhTR2xVaEtZYzRrMGM2R2drdGVsaUdaZHo3M2c3WVFO?=
 =?utf-8?B?TE96QlR2MlNnRVZUR1pYSzhqY0xCQkk2QVF4TFE1QVFLYUNGZHNqYmNzMVQr?=
 =?utf-8?B?NUcwckwxa3ljNVVORno2NzJiRXM5OVBFWkxrSGhKbkdBcjJHZk9ETWVOM0Rn?=
 =?utf-8?B?OCtvUDN6UE9zSkZ4R1RWYnAwMFpQaXBjUCtoa2NhWTREVDdESFBmajlkV2RQ?=
 =?utf-8?B?MytrZGlKOWM2VHNtRlZxQ1ViN0wzMnZ3OU1jNHdHT2ZNUStUR3c4NmpxaDNP?=
 =?utf-8?B?eFlxdFI5bnV1c2tXaEFWcUZLVTF1dWxSMnZXNzF1S2lROHY1em1lVmsrdm9N?=
 =?utf-8?B?V29UdG12VDN0L1BybWQwTURvRTcyWEJONlFxbmRiM3loVndCTXZjeDFaSXZN?=
 =?utf-8?B?SVczUFBrdXQ3cEFpSFN0L1ZVdjZneFR1OTIvSUlXZTFuMjUvdDA4WmMvTGk0?=
 =?utf-8?B?SlRvTGU1aXcvRkJQMUdMc3VBRTdqS3I0SWx3N2tTK3ZHWFo3NFVESWVCbG5r?=
 =?utf-8?B?aWx6M0x1emprdGRGWW1CeGFYc1NsTm8wY21ybzd6clJ3bk0vbmE3SndTNDBt?=
 =?utf-8?B?L1F3cWdlNUpJb3J0NWl5MS9MNWs2VmRRdVVPSUY5cm9aNlY2MCs5VkZtekYx?=
 =?utf-8?B?QmRjR2tDN0NpRWhyK1hxNGV2WWIvMDNtU2dkOEcwVUdGc1l1YktacVFvL0RN?=
 =?utf-8?B?NkhOdUZyTk14SnkzQ2xGODlSNVlvSWt6eXp3UkUzRDFPaHFSdHk1WDdhZ3FN?=
 =?utf-8?B?TjNxLzBsQUUrNXEwbmhRdzZ2RzFvVFIwV3ZrTlFGMmp3cXJLcnNCMVhvQ0lU?=
 =?utf-8?B?VnhXQVhjN3VWTzBwNnhocytuWitFSGQ4OEhPZjlOZ0tzOTNqdnM1ZFowbGxW?=
 =?utf-8?B?Wk5EZW9ZbTVqYXdoWDExS0huK01QOXVsT0xlazFIS2N0V2p2SGNwSlMrYktM?=
 =?utf-8?B?cTllZ3owZ3B5dlNaOTgyMnlxSmlsT1kvZU5HVHIxQm5RNnlEQVR0UFovTUwz?=
 =?utf-8?Q?plkOETWkbQMuULNV1jSoRSFSb?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 937f8d88-d09c-401a-fc12-08db82b00531
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:14:31.7375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMeNwE2kCysWQOZhE3LCqRKZa5xD56D35ySjMaHtITFe+mylfRtY5/lOmURyh7ByD2lRTp7fC1E5BStszwggrg==
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
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index a1c9a1530183..6c23f2095631 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -1068,8 +1068,7 @@ int ti_bandgap_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static
-int ti_bandgap_remove(struct platform_device *pdev)
+static void ti_bandgap_remove(struct platform_device *pdev)
 {
 	struct ti_bandgap *bgp = platform_get_drvdata(pdev);
 	int i;
@@ -1098,8 +1097,6 @@ int ti_bandgap_remove(struct platform_device *pdev)
 
 	if (TI_BANDGAP_HAS(bgp, TSHUT))
 		free_irq(gpiod_to_irq(bgp->tshut_gpiod), NULL);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1283,7 +1280,7 @@ MODULE_DEVICE_TABLE(of, of_ti_bandgap_match);
 
 static struct platform_driver ti_bandgap_sensor_driver = {
 	.probe = ti_bandgap_probe,
-	.remove = ti_bandgap_remove,
+	.remove_new = ti_bandgap_remove,
 	.driver = {
 			.name = "ti-soc-thermal",
 			.pm = DEV_PM_OPS,
-- 
2.39.0

