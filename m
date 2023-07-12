Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578BD750102
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjGLIPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjGLIOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:14:54 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2137.outbound.protection.outlook.com [40.107.215.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BCF2105;
        Wed, 12 Jul 2023 01:14:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyfoD/4PEjZzruSLNJwQEmpEPUaww98g3dU0r/QWSbTbCR1OcB0bqIr1JevdSQaEBUq/E2D4CHLK4fpP848zbTTi+l9SQ3NIb6sBvuaa1RJ4pd+RAltFdPOO1Wiiw1PymFdT25GVNALtq/6z80kejPikvAN7jcOukEUxGajIBUeX2bKaWFLJQeJEHq5ux6pC+ymUR8Al3eOXcsPdMWRerQHhYZraNUsqoLmelo/ob2MaXi5lUF0MfzULlQT/AfBFeOcK0c5bdA9PNW+hu764EHY8o4Vv4zfxzl7d6KW6r+o7qRwxTmpJQFDK11o8nY+QUpVA0DbwWLKrd2OTDVuibg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7T90CmrdbjDP4sHSP0/vhp3TrV2NK3fye4IqWpjyNWQ=;
 b=niOQeUyk+AReRF7IpFh5ZPayH/qDqWMIKkglKjxIaZA6NGXtOoFBawN9XYEg2fvLfHU+VWemNQgfnZUctU56KxocWPMezwm284Sj6R+cmxYLwb8H28Xp2E7jzxN1oN0NBoPYO2UKPoGhm5+bSagBZUsOPtwfYKoexQLueH36RYWQ8ZsCxvHXWburaN6aoWPBVx43iibp23k1rEHbePIn1hIsz8ywfjuRidBHl4Xd3WWsuta7a6IP6VOGFtEUiauKcd1Bm5qGqoYoZ6+mdfYsnuvWdBmsbqNulyP005td6X8PEX90qMcm/2yUEt5VgST5HXQq0VQUr4MzLoCLAd1b/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7T90CmrdbjDP4sHSP0/vhp3TrV2NK3fye4IqWpjyNWQ=;
 b=fxHkDVDWAVvovGhdQlk1G6zWguhZx71NSqv5ZxKdiUpqOW3T19bcp1/FnxPIgCwEkaUKmchIisJFwSbdYSLOt2BINZTFB6OF21ifPA9iTQI7qG2UcQh8zO6qdcsyWQwsEUzIWvN37N9lR66yQk90UpczRUFa0BSvg6TbeeWVczgv8l7HRg/3c08kh9+4AJ5Y3oUueS6m+gkThC6SrkoFw5Qa9JC6LJ0XbdUGX9hBQlCieJfYoFt/EzWMDH/d9pIfvnjqYMBSHyDRS1xNOJOkrdhMrJBkqEhSjFr5yKOoDpb770+DEeer2S6eVXJIGjd6jqG5pIfyM6BRyERR7Q5yJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6524.apcprd06.prod.outlook.com (2603:1096:101:171::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 08:14:16 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:14:16 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/27] thermal/drivers/tegra-bpmp: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 16:12:45 +0800
Message-Id: <20230712081258.29254-14-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c213e313-7635-47bb-2b6e-08db82affbee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mH+JKAXuOv4rLrk1OsDmFhlLYYw0fbwa6oq6CnPYE4Ku2fTiLmmDr3i02L8gQYQ/b6KzkWInkbFwi330xy8yDW9s4tzKHABChoqCDV5QAxpj7R0wFI6gePFyVBBo3hu/qb3Z6ZGOaW/JlG5Vhhbebb5ANUUhFbJ1xHibuSGfAFSsDrIkhOcTyQFmsQrWlGRL2d9C4PqIwjHPY8bLWGMjP76ZGIoTTIeInqDQHOzP6FDSncEuM6ONbAKhKxKxkkuNjAS9c4qFohjuKXhosGValA4DsjJlL3EX6BrPfNBJgyGNn+yara0JpuNMVJhcH3K6594roaAKdyPBq1uM3RXq7s48epzGtuSIM2o8iDAvZ4yJhLOfOB4atn9WYfMe1jbxU7n+TAkEXsMEW9QMyhp8ARQPyinkfb1ojdool1f9Vflag+9QYKvXu7AEl1aFkmjMsc4AkV28hlaFHQVK6D5YSa3MSUeusz0W+TZIlSIMhljU12dcc/QrANZXiGjrtw68TJ0ewS3RGpfbnEw2myKxOS3uC1rDgY2g5n7SpzziiM+rXHeAfw+3a48w1j4nTNRsMvxG1l5Si2BUa4gZBeSDneZiPUqPy8iHmU6hdiJDd5t9pFjuWfLsr+GhHwZjEzJ2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(8676002)(8936002)(5660300002)(186003)(2616005)(83380400001)(7416002)(6506007)(26005)(86362001)(41300700001)(1076003)(6666004)(6486002)(52116002)(316002)(6512007)(66476007)(36756003)(2906002)(66946007)(66556008)(54906003)(478600001)(110136005)(4326008)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEpXWEVhU1NHdnVrdVpjOVJCUTdTRFh2VHpvMGlGZ1dId01BdHhQVm9HbkJp?=
 =?utf-8?B?eDFZYk8rN09wWkRta0lncjdZVFpRaWc5dUt1STVXYUJJYTlMZDVqcmtZTWVP?=
 =?utf-8?B?dG1PY245UGpZVmFwTmdnRjJqTHFlS2FEMEZ1c3NyMVkrZXltWHloMHhHeFJi?=
 =?utf-8?B?ZzV6SmdicTZYcGlodVl2dW5LdUtnZSs1a3ZtSFdHb2tnYmdIYXo1NTB4RlZ0?=
 =?utf-8?B?ZytmNzczUmZKSXFzeEtaOXFiWXFOOUdEb2JnN1RTTEc3RXJSQ0xvcW5yWmNh?=
 =?utf-8?B?aTlFcWswVzUrOC9FY2Y3clhpTEVqSS9TQnpwb04xTGpHcUFWUmNLQzVOdVlm?=
 =?utf-8?B?RkdpRyt2SDNDMGowVUJkaFRiUVQyWUozOVZMOWtzcXB1RS81UXRySzYxZkdp?=
 =?utf-8?B?RlJMeFF5ZXIvbzA2eUVjUkt2cCtDSnlaYkYwMHF2Mm9zcSs3M25ZLzdIQ244?=
 =?utf-8?B?K25KNzUzUEE4N096d2lHd1lwM1ZGNm9qdlJnazI3NE5vVjdubXl1VDZwOHJa?=
 =?utf-8?B?eUNiRHZzZ0tMblRMYXFGRUc4dVBVbDdoM0FReUcveTZ5NVhYMjNqSzZmeTRE?=
 =?utf-8?B?Q3A2QzRDZjFBdCtKMytVOFJWUzhPT2hqS3kyYm9jYjlVbnFSZnpndGVsY2FW?=
 =?utf-8?B?TjZZM2s5TEJGZFFkOXJzajJZWGhGTzFtc1V2amx5bFVBS3JZWTBpRm1uK29n?=
 =?utf-8?B?N0VMSG1qbGtVRWNVSVRiK3FzYXdaclkwc0NHMkQvRlR2N0NjdktpdzRtajlZ?=
 =?utf-8?B?UUxObVhKRGZNa0l2OHh2SnExRklHOUdWTWhzWTE0dE1GTUpQUUF6cXcvZllV?=
 =?utf-8?B?T3JXRnBqelN2TVZSZ3g1bXVKV0tITjVLSVk1OFNNWDdrdDdBWlBuUFQ1RHln?=
 =?utf-8?B?eUtZYnE5Q214eXAvcXFvV0lVdmFGK1lGYy84TUdaQk4ybUU4YjVlQkQ3T2Vh?=
 =?utf-8?B?alIrZkRuMm4rMko5bFlTUENDL2t1MlNTYVdOYmF3SkozSVhKMEdtcHhpRWZR?=
 =?utf-8?B?d1J6OEdZb3pQUWpGbEVJdHNoeTY3THNaMk5GL3hGdFVtd1NKdXo3c1B0Wmxi?=
 =?utf-8?B?eEhrQVhSeWZrYmo2d3lOemZtazBMYS91Vnl4cTNWQzRiUGxPZ2pJVlJvQVZO?=
 =?utf-8?B?Y1JmckVPdThjSTBuRnlkRzZtQjRaSkN0Nnl3MGVzUUtJMnY5dDFqVDIySGdH?=
 =?utf-8?B?d05xZzIzL0Z5TS8vdUR6R2x6S0ZvdWw1ekEva3dnVnFib3BPVE9tQlNNdktt?=
 =?utf-8?B?eStaNFpMSjF3NHAyUUdyWXcyRlpPazM3WUsveWlhMy9xc3hrbjhXcDFCM3VM?=
 =?utf-8?B?RXBiRnJWVTBNRGNTdjVVUmd3cER2N2JGM0gxV3dQOWh5dmlQL1BjNjdMeisy?=
 =?utf-8?B?SzBXZEpoTjJ3enZpNlJVSlZEVUErRjc4NE5jUG1rVzJDSEpkR0w2eDQ3VmVT?=
 =?utf-8?B?TlZXdm42eHI5MFNTcElWczlZSHpGM3lxVkJ4Qi9MRHBjbVFtK3VqczNQbWZJ?=
 =?utf-8?B?T3owNUJQZGFjTEQzMmFMbHFjYzVXTkY0VUVOR2lvbFdrcXNHcE00M3hSSHQz?=
 =?utf-8?B?SDZORmM3a1A3WE1SWkVta1ZUcW50bk4wWUl1dURPbG9zbVUxUTIvSEMwRTN5?=
 =?utf-8?B?QU8zTkwvc29HMy9mdnNrK1dKelZXQUh5VElUOWxHSW9KaGtwaSt2eXE3MDhr?=
 =?utf-8?B?V29XWHZ6Qzdrb2hPdDlZeXhnVFl2MElLZEhJQkI4L1Vwb0dpWnhvWFgvWTdn?=
 =?utf-8?B?Z1hkSXQ4WGdNcmJESHRhQisyazFQeklWNEZINmxiR1dRK0dIbzJhaXFIWkJ4?=
 =?utf-8?B?L2F2RjhvZi80REk0Mkt3NEJKUGF4dU5kdXdzNGFKSG9XeFBNR1N5Q2hUQ08r?=
 =?utf-8?B?Vi9ZUGdXYmcybzFKRXhBWjdZUi9TeUJGelFGbjJlOVduK2o3RlhYM2ptK2Ni?=
 =?utf-8?B?Q0FZU01NV214ZTU5WGxvVFRDZmtLbExpR2dMOUJ2V29MR2IwdldDY2pZZ3J2?=
 =?utf-8?B?cm1lL1B0YzhGcGRXTHVrc3ZCMVppQlBYR0d6UVhmNFVNa3pRTVpLTUFyM2Ur?=
 =?utf-8?B?elZPbXpSU2p3Vkp2S2trUS9aN0dRd2VRaXhHNWxtM3hVQmd2T2JVQ1lrRVUr?=
 =?utf-8?Q?5i81XDym39stKeyoRrLK6yjbq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c213e313-7635-47bb-2b6e-08db82affbee
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:14:16.2120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qg732zlwJvsjyLXAqFAVUdSQfGSmHSkySaYMAuTYKmKNTeaAzLt85hQ6f1gP4q8Hs9lpzGBP5Sia8iUYcsfrhA==
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
 drivers/thermal/tegra/tegra-bpmp-thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/tegra/tegra-bpmp-thermal.c b/drivers/thermal/tegra/tegra-bpmp-thermal.c
index a2879d624945..5a41c200deae 100644
--- a/drivers/thermal/tegra/tegra-bpmp-thermal.c
+++ b/drivers/thermal/tegra/tegra-bpmp-thermal.c
@@ -250,13 +250,11 @@ static int tegra_bpmp_thermal_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int tegra_bpmp_thermal_remove(struct platform_device *pdev)
+static void tegra_bpmp_thermal_remove(struct platform_device *pdev)
 {
 	struct tegra_bpmp_thermal *tegra = platform_get_drvdata(pdev);
 
 	tegra_bpmp_free_mrq(tegra->bpmp, MRQ_THERMAL, tegra);
-
-	return 0;
 }
 
 static const struct of_device_id tegra_bpmp_thermal_of_match[] = {
@@ -267,7 +265,7 @@ MODULE_DEVICE_TABLE(of, tegra_bpmp_thermal_of_match);
 
 static struct platform_driver tegra_bpmp_thermal_driver = {
 	.probe = tegra_bpmp_thermal_probe,
-	.remove = tegra_bpmp_thermal_remove,
+	.remove_new = tegra_bpmp_thermal_remove,
 	.driver = {
 		.name = "tegra-bpmp-thermal",
 		.of_match_table = tegra_bpmp_thermal_of_match,
-- 
2.39.0

