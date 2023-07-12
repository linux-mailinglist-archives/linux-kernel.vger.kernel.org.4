Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986307500FD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjGLIO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjGLIO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:14:27 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2116.outbound.protection.outlook.com [40.107.215.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CB5E4F;
        Wed, 12 Jul 2023 01:14:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lcr/rDLqf7rmEK+s/Tc+njcgDdxo5fay7IQdNLle1dkcgCi7qwRDg6L5CfdiBw3TZjbfsWy7//NmryqXRwfKPuPdvhv1sDj572nGSV25ThUJyC7MyBkGY1Ztnm8SgD+bnFMcc1BUUznN8wWQx/2mYe7nTMeO4i0j8w/ucGWnMBfv+D973TZ2/jGU694NDnfpU8YiEEY8MSk0wUWGkzV4YnwAZfONxWU/MbRTNG3JvI56ycKvQBs3c3gnfNbw9jjM3CIwtqPPCC8cv+JqArPD8Qs1WbdJUo/kTYCS7T4zpnS7EQyPrg00K7VKz8KPNUwWiGVFYadFnENGNb+s7b+wZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2trwrTRv81u40CbsVYU+78HZvkwkCI6xWFO9bsRms6A=;
 b=dqBKer728umChfdYYzd3WFndcX8l9L4S5tDfewlkzEtWekVsqvo8+IRYJ9LswlnNFGlqE7OkyD6Q2zzmo9E1Br7w2Mrw8Iynxif+bw5Q9Ywkhh8+pPhccbr02t9I5cYdGVXXZILsTwL8ezJz7+jgUI1pWW2Zhp7MIYEZpA+s/1N8CUVRDDN7biJKmu3bNzNKVtKon9yPv9n2EZGlCrsC2T4ApTWQW9R7Y2RaXn4QkrLDHTgS/SFDbaNIIfoKnazX8KF7CvelB/ui5fmM+b4wzJRHkQ1d/bKxtIqgSLlasARpQH/T0P+umZa+HnVL+yJS9NrkR09zosdD6fMP4l0L1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2trwrTRv81u40CbsVYU+78HZvkwkCI6xWFO9bsRms6A=;
 b=KukuO4Xmg1T7xRAShFokkMj0ulmfA/pfpEZ2UVLWlZ98G6cEeygmjVXE/CzCKxTh1UG1aB8MSTtBhZiomFk0qAB2mr4Q80x4Z06IA3DYtvqvg65AFOZHviqP7RSd6zdOrCoaytAETvzola2U+ll2MFohBt97CyX+Rqz2aTFDByz+UvJnqwVr3wyT5DddgJadpFP7OVfXGipckKKOqn0kORyC7+x9CLWsZnkdOC8PEftigtvdLWXdFuaFyL4UtXyhAO8O6rz+KFBw+8YZaEvSR0tvo6YLA8LKpKZOKVx7R5dIaMA4kyoWfqqvvBqj8hMK4wb1sjoYdtUajd9koFo9KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5382.apcprd06.prod.outlook.com (2603:1096:4:1d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 08:14:08 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:14:08 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/27] thermal/drivers/rockchip: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 16:12:41 +0800
Message-Id: <20230712081258.29254-10-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: bbdec929-d002-4e3f-23f7-08db82aff75e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KmYmhvHbe1SXevXcR43uQCv7b0KOFuWHZAvARsYkm1IjuzsSH3+uFxUr90d9JzgDiWpf379xp03Dbi11X/S6GhLRKe3AUy5UXSPCipi7OTNApMnoYMvHzL0nVVNMDIiUc+48TSe4nTg431/d+/lJQqji60z7ye+vXBvXSW6yHla8YgrOlfhWGkCc9KhBYsWHKatjLUtG/4YYm5xoNauhzVABBXkqmr0vAiKKTT73yiHKJikgmp1bDSbsAxDLJ2sRu87R/oNcJN2h63iHLCT3BCYy8WMWM0ScMDTRiYJcsa+YS+cjRbqpliSJsWC1rzNEmTrgjJwKKqHdhYRaMDzSRPSHQM9ntKoyO+OrlfKuIwfV+t/5upUjZ3OzDudmZNHZeqG90agzoYh0NCTSaCQ47TO/X46DvTTKdKTBiQrrnDYVGR3yIN5EUqxLx7vwGfoWTFy92AddvjXFaN6cyq5ZNE2R4Huczcjv3seviSTh4PmFxI6+XM4W/lTRSXnKUwxjesITo7ZybkHIwPGqmkG7q16gXUZEii7Xm+dOt8VZTl2dR7GfA8FvJFkzq8V6RnMewvIjiBBmBt6zQknKr6gR/Dq4yvGIisTO7b6gL28P9zB0JV3pe5mBzalFs+y0pWe7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(6666004)(52116002)(6486002)(478600001)(54906003)(110136005)(6506007)(1076003)(26005)(186003)(6512007)(2906002)(66946007)(41300700001)(66476007)(316002)(8936002)(66556008)(7416002)(4326008)(5660300002)(38100700002)(38350700002)(8676002)(86362001)(36756003)(2616005)(83380400001)(66574015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1hkRDVFdHJYL2doOHVMeU5xYWF1d2E0Nnd1SEFiTFlOd2R6bEE2WCtONnJC?=
 =?utf-8?B?K0l6RG9NbEQzMVhpUnFudjJ6SjdacWVEV1BoL2VEek5NZHdDU3lqT0lTWDBu?=
 =?utf-8?B?ckowVk5OSUIzeVQ0c1dDbkN3UzNYWTlaZFN2ak82cm9EbFJEWE4zOU1mdnlw?=
 =?utf-8?B?SFdmM0N3SnJidG8yOGcwU2VnSlJRbUtZSmQxdndSVFFxYllNZVd6TEtmTmNr?=
 =?utf-8?B?cmF4MXlkYTZ3WVR3aGxENFExdnFUV0FsMlh5Z3RXcmo2SllOR3VjYjBZMWN1?=
 =?utf-8?B?RDhrWDZ6L3RtbVkwYXZRSzNQMy82dmRCRjMyNkpDWWdTK3JQVUI4TWoxNTJJ?=
 =?utf-8?B?SmNndTR2b1JOc25jRGNWZEpsMlpUZXIwT0FGRm9GVWdHUU01R3BPeGtqVyto?=
 =?utf-8?B?SS9aMzVidmVFNXpoZXFoKzNMRG96U2hzd3VFTXFPZjdDREV1NERHN2dXaTdM?=
 =?utf-8?B?aWhib0hkeWRXcjA4UXlYenA5QVdwNUpxMHlrd2VkRnlMZVdwMUkxSi9GekdQ?=
 =?utf-8?B?OU9DTUlkQ1hHMlVZMytMWEtuOWlrRWo5ZzFkQzUxZjI1NS9iWXVJVHFpNThO?=
 =?utf-8?B?Y1F0YzR2aXAxcHovN09sS0MyaUVwVUNOa1dsa1RLaEpNMTIyODk1ZGJPZnVv?=
 =?utf-8?B?TkF0R0RrUWRVSlI0dkczSDBTWnRLWDlwOFVnNDNqdGlkY3JZa0hBL21aalRT?=
 =?utf-8?B?K3c2VkkxT2U5UUVURnBiNmNUZ3JDT3hGZ0dQK0RoU2o4NjJ1Y1poakZSNW9F?=
 =?utf-8?B?RDBGTnlPUmNlZ0pKS2NtaUFkRlVBdCtUU0ZpK2tISGJoTGMwcDlKai8vcW9i?=
 =?utf-8?B?c0oyK1pJZVJvTzF1VFptUUZ1Z2NuME4raTVuaVZBSnUreXkrZVpPVGtSeTNl?=
 =?utf-8?B?L3dFbXZkbkZObEdVRUM1d3FnT3o1Z05qT0xsa1llamlYQVJLaVI4WHlmeWpM?=
 =?utf-8?B?b1F4T04xRkJ3VlliVFFsdklMSy9lZFRnZTFBeEIxWnczamtVcTJ4aEZFcU4x?=
 =?utf-8?B?M2JkazF3VS8wQ0pPUy9XcmxoMjI2Zld2eGM2VWM0dm5QZy90a2o4aElna2Vx?=
 =?utf-8?B?UXk4V1pQTFVWakhOampaWmE0clZJckg3MmFRU1A0SUpNTzlyVkxkamp3UElG?=
 =?utf-8?B?MjV4U0VTeGZCa29oZTBHSFhSVGtsczJoSnN0YkQrd05FWi8wc0o3T0oxbi9J?=
 =?utf-8?B?b0Q0NUJUN3NqK2RGcUZMa1hoTDdkUDlyZVM3ZkFsNXJiT0JNeEpuTUxzZkJp?=
 =?utf-8?B?THBhYkx2aVpDWE53UXI4S0lxT2tWdFEzNWtKcHRRTUJ3U1F5TlJRckRkYS8r?=
 =?utf-8?B?MDdLU0lZUGluYmNVN25tdUNBM0RnQndiSWRoWHBRQXgwRXRHbjNIRTRsbHM4?=
 =?utf-8?B?bGZzbEx5WWVZb0UzRXV3TzdCVXJPUkVFQTI5MTZ5cnBtazVCTnI3c3VUTWVw?=
 =?utf-8?B?YlY3MmI2WGJEaUdhd3JYMVFvWU41UjhhWW9wQmZmTHgxc1ZlTXNSNW9MWWxU?=
 =?utf-8?B?TG10cEwzSUo5Y3c2enVOeE5PNkJrQ3pqU091cnIwRnRSdVhCRGRhdTdDSmls?=
 =?utf-8?B?emhXOGE2bTM3Y2tXZGhIWUtBYmtkWk4vbUpTVkI4UkpQMDkrTTNaZFdnMUtS?=
 =?utf-8?B?SnNYMllOeXcwYnppRWJMV1FFN0xIbEdNVHladmRKa2hTaFN4T2lnakFtV0w4?=
 =?utf-8?B?ZHhoQjNGeGtnWUVMczdNRkVGWWJVUUo2andtVXRDQm1oQklQMEVEbzI0ZDhR?=
 =?utf-8?B?K0dXb2tCSFpVV2pyS0tJMkRkNWNNTDVjc3B1SVJlSkJFNi96c2R4S1RBVVMr?=
 =?utf-8?B?SHVZak54NzZCTlk5NVFITnpnVG5iN0Z0Y1FuUExKMzh4eHNUSFNwZm9KR3I2?=
 =?utf-8?B?ZXFNUjF0UnFNdlBDN2taZUJOQ2kwQ1JuZjFRNmNMY2pXVXI5QXp2elRjY0J6?=
 =?utf-8?B?Z25sWUJpbkdjMEM4TWVBZlJVNVpMdE5JVCtHRUJ5Mk02VlFUeGlsVkhqVWFX?=
 =?utf-8?B?TlFINlhKODcxTExwVEZIWHZQYWluVkZPMVIyeGZUWGdWbzFVSTRVb01zUU1U?=
 =?utf-8?B?b3VYMEVabVk5bDIyZEdBbGJHRzJGaVh0aUc5THVJUFd4ZFdxSEk5OXJseTFR?=
 =?utf-8?Q?K2shvYP5hDIjjECzDwmRWkQaA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbdec929-d002-4e3f-23f7-08db82aff75e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:14:08.5523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KI6sgDu/AUHlZNaEERcUO7k/3ZXdrTo0bJALVdLQSiKs0T7wyPZmi5MmrLA4dzHKyRx6JhHFBHt28JVSUGosIA==
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
 drivers/thermal/rockchip_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 77231a9d28ff..086ed42dd16c 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1601,7 +1601,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int rockchip_thermal_remove(struct platform_device *pdev)
+static void rockchip_thermal_remove(struct platform_device *pdev)
 {
 	struct rockchip_thermal_data *thermal = platform_get_drvdata(pdev);
 	int i;
@@ -1614,8 +1614,6 @@ static int rockchip_thermal_remove(struct platform_device *pdev)
 	}
 
 	thermal->chip->control(thermal->regs, false);
-
-	return 0;
 }
 
 static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
@@ -1691,7 +1689,7 @@ static struct platform_driver rockchip_thermal_driver = {
 		.of_match_table = of_rockchip_thermal_match,
 	},
 	.probe = rockchip_thermal_probe,
-	.remove = rockchip_thermal_remove,
+	.remove_new = rockchip_thermal_remove,
 };
 
 module_platform_driver(rockchip_thermal_driver);
-- 
2.39.0

