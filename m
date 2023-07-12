Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040387500F5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjGLIOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjGLIOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:14:06 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2116.outbound.protection.outlook.com [40.107.215.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E5C10F7;
        Wed, 12 Jul 2023 01:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEXeiBF8g+5q3VWCoEyrudMVeFWD6qrkLs4E/enFJtp/j240NeA2u4qkBmXze+4cd2N9hNLh4GIQ6JVjHns/MhU32K3OZUaezI2cf2tYc8lkgUemDLmtyNMPu68+CUqtOiDcv0yuEJkjTGtKWwNuoY05DoZvh6lgQsHnPqAL6KSlEF5DbsC7TXCKLg892yBNXfa4YURCWRwIYLP+k245VfFEFDImxbvqxu3hIXMDBaDHoYPVcPo56Cq+XAxKyizTsHL53Hx+qGZAOiArtQMF1QeBGOr6jFsl90Eu6HPPz7zCDHvxVsN9la9RS8zobF6PZV/co41iZtG5e7eEhj6mbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOBtxgJupmI+362Ug4gZvaILE8rmdn+aJOFY+2JC5mI=;
 b=E0b+wsK1IoUTC+MjiNoO0JnSmyZ9ATe0mCo+hlLGIVNQwUOwN55JNW8d2inrNJ9MpBML3aV9yu6qLUs4aXdKFUIX9HYwv0rD4rRc4JGu71K1CclU84iYdQ5u2jDIJjJ0TWS7pgWy2yRArFL4YqzruISMpA1/8vk+JzqYy2s2glYE8JGnp5vZpnEsAaQPZYjur4XCS/E+TPOY/N2U/Lwxty0SpK8NsjfN970VXB+9iWO7HM8DhpmcTcI+O9KU0QLqVMmxfc/BcNcPOpyQWvHFZzfCI+TBbHM82nKlZxJEtQ9KOvqi/pWd4nPaySTKiLlDt70jtR4wF+GMvKzaSEMIaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOBtxgJupmI+362Ug4gZvaILE8rmdn+aJOFY+2JC5mI=;
 b=FhLlm4c8og83IFHt7JS4xcbJI2AZIex8sSjXhEO12kzIcn8D4WpTC9cEr/H/LPYfB6Z/jKBGRTId6XJZoGJsoeFmituArUZ7nVpc8fsrR19jv5VXNwfnfE4Qd1K6ZW5E34wPcfJUydKLZgwFYYKq62WllwZVvwvYfh01nu9NOTMKrig0WpR4iwf0/4LXDWLjJ/Fi+aQI9ln7FZRSlwRv10YZM70czpAKdXR+C7RQRKNwfveoA6kXamEGVkGm/e3fnGo3/nIRLH0LW65bq9flPlPHPQFquJwqoN60/B7hDbcl5CL8xffH0cI+A6/l+kuh/W4l/mzwR3ZY28oyK+vVqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5382.apcprd06.prod.outlook.com (2603:1096:4:1d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 08:14:01 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:14:01 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 06/27] thermal/drivers/mediatek/lvts_thermal: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 16:12:37 +0800
Message-Id: <20230712081258.29254-6-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5cd2d12c-89f6-43cc-69d6-08db82aff2dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dhQmjyNqXxtidFLb+8UMAra06iIoiC6NgkEVHQ9Fh+AJEih5SeCRpJuEmm7VtcJzYrXGKShFwi/uKd3T2XemhW8eMMp4azCq/vf9TxzOV6UKg0PrR71PGdanbHnFr4BuslscVfaLRgc6kn2mexa8n/dIgB9Fgfr1p+ISzd8kMyi6xuWGsPh2vBLhYnYG/ZYf7Vpjz7QZjQcNKYtd3mbccmzRxNnLIfbyM0rc3hz/7TwM1cpXyEdbLVAA0Jwbk8qpJO4P9C6jmUSZXTdyD4u1sPJEX9pHHtlx57Tpw/Wc2jRc9PO65+yjr2Ut/KVN4R6Fr/1N+gmRvIRhvuJ+p2My0CinzP9Apqbi8m3RS1KU07dYzAkj2Es8W5daQpbwA/XkH6sD3id2t/eb09GtOpjhcefAF/E2pzvUtk/DshVwCquTP3d9NmJW7WrbudgGBI5WcsMSs6v8ddnHKwHb4zZSFdykkoq9ea7N1sgYlwcwA6XQlmdb/1tNHjYeP9ZATjZsS6jVDXsBjW2KPxLlVMUDcshFou0b2DwLcfgLYV4p4G3zv+IEH9+PDDkazSMPdkp0UzEKSOKwj5dy+K2BAk3h6h0dMCF+jqE3RLEhjTi6vkhXCLlzTxl2gXXUVcNCSSYR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(6666004)(52116002)(6486002)(478600001)(54906003)(110136005)(6506007)(1076003)(26005)(186003)(6512007)(2906002)(66946007)(41300700001)(66476007)(316002)(8936002)(66556008)(7416002)(4326008)(5660300002)(38100700002)(38350700002)(8676002)(86362001)(36756003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjJQdXZMOEM4MEZXbUI3enVzSzFDYXFKQ1E0VFQwNXo1dVpCenFJbmhVVnly?=
 =?utf-8?B?TFdicER6dUhrdGpaQ29iVkpSWFd0L3dydGJJRFM1OUF3bTRWdlR0QmlxVndh?=
 =?utf-8?B?cUQ1SG5PWDJXQXRIQ1JSUG1xNXFXeXllemNrd2k4Ym11VmRIcjlGQXY1V00w?=
 =?utf-8?B?bm9DU3FNVHZWN2I3dGhZRzdkSHpNNWtsTmxQS2wxdEhoalFPSnV5YVA4T1pO?=
 =?utf-8?B?WDVlV21SRmY4a1ZFRDVOaSsvMUhPZGoyVWJXUlBGMnF3ZFFjVEQxNlRWQkZD?=
 =?utf-8?B?WSt3Vyt5eFpQeXo2eE5xNTNpaG8wVVJObVVIVDJPNUdxM2VTYWhSRWRTQVMx?=
 =?utf-8?B?OHNBQVFSTGd3a01RM0xUUkZ1b2doK3BUdGlPR2thckhQUExoV0JxTUtJdHF4?=
 =?utf-8?B?MDQrZ0VMQW9xM1l6bUl3TDBrQVU3ekJkT1BpdFdtUWoyUXprNW5Va0pRcERp?=
 =?utf-8?B?MjliZWllaGlKM0FBOTQrOEhLazgzZUZJZ01XTTN3ZVpSMUt3dEJOT1RyeEh3?=
 =?utf-8?B?TUZVR3F0alZYOVhMalBwbWlZalo5NTRQTzROVnArOU1PRHJmR3dIaEpyVWhC?=
 =?utf-8?B?ekJHOFhJZDY3S0kwOEZCZ0x2MElnMm1LbHBXQStCK1VuZU9CT21mZHBseWQy?=
 =?utf-8?B?OUozSDN5ZFFlMWFVbHIzeW9PeEErNGN1ZmNNWjdWUFlHeFdHQkVEdWdHdTBr?=
 =?utf-8?B?cTVUV2t5VytCblVOYWY4eTlJelg2RFc2aXNQNzJ0c2ZldTFWRUtrcEFFTkJq?=
 =?utf-8?B?ZVRIQkg3WmUwSFJsTW9TSmgwb1JlWWk3bGlrNjFiS2RWN2g5cFZKZmNFN0dW?=
 =?utf-8?B?L1RyaG43R3dxWktxZGNVbjNiTWYyTjUzdFVKUHFmSm1QY1RWOHNDN0wvZ1Zl?=
 =?utf-8?B?L0RUNU1JWlpGMUZMdWxFZXVhV1dmVG1saExUVTdzTEVpZlRwblB2RDdlL2hr?=
 =?utf-8?B?bnkydFNGWUNZRkYwR2RBZ3l5MW56ZzZXQWRHUmsyUENNQW1OektFTC9HZVhm?=
 =?utf-8?B?RWhtMFR4WHlkMnlOWlhycUtvOE1wS1Y2RjlFUDN0ZVBHWUNNZ1cwUlJtVnhw?=
 =?utf-8?B?bVpnQVl3OFcyeGdrWXFvKzlIbzk2NmorZCtRdDJGUm42aEtkeHNiODhzdm8x?=
 =?utf-8?B?S0ZXQ21SQ2xYZFYwZ2Fad2J6emgrN0xOY1JmWVNnUDJHQjUyRkVMeFBiMDRC?=
 =?utf-8?B?Z21JYTZiRW5CdER5MURqZ08xVjNXUW5oZ0lxMndwem05NmF4c0NOMWd2VFh3?=
 =?utf-8?B?eXB1RXdHYkxSd2dQNi8vRTdoSmhlS3RicUZXWWREN2hneFUvVVhpKytrVjJH?=
 =?utf-8?B?bGlUbHQvdVlwckpkR2ZCSHRVZVJJN3BZUFE4NG9ienJnUWUycHNrSzRDeWd5?=
 =?utf-8?B?TzVlMVZjRVRiNXJtTm1sU283SXk2QkxvRDE5ay9wM0hlUFdaWCtWVkMyN3NQ?=
 =?utf-8?B?Z0dBaXZJdEdyVC9FQWdWMjJWc1gxellyeXY5a21qT0dnWWJNanJyNFg3SGZ5?=
 =?utf-8?B?Y0hYK1hUcUpOaUQvK3ZQZmczVnZLdjNLQjBzbEhaSExmdmhCcC94Zm8wVUUv?=
 =?utf-8?B?YUFCd2p0Q0trckpaZG9BRG02OVEvU0lDVU9WUGhRdjZsT3BjQzlPL0l5ZUtp?=
 =?utf-8?B?aG1qSkVzdkRIKzNGUk9WQ2RBSGVCTmxkOHdwN3NwZyt1d2drSlpiTTZFQWtT?=
 =?utf-8?B?dHZ5TFdEYXBvSnVKZDgrV25pd0RuaXEwc2RMSVJvc1dFb1VrUSt1WkdPTnJV?=
 =?utf-8?B?OExOdEdRczIyTStWTjJ2MXE3K1Z4bzJFSlJuQVN6d0NwM2hSRkI0SThlUThm?=
 =?utf-8?B?QmRQNWRnTldGMVlFU0xHVzl0OHg4c0xIVlRWQVA3RTNNS2Q0OU1BQUh0YXFD?=
 =?utf-8?B?d0Q3MG5RV0xLK0NmcUppd3Vzc3g0WXNHeDlpZWtmVlZiYlpIR1VwS1pkcmpk?=
 =?utf-8?B?ZGdkZGZ4UzliZFlXdm9Lc0VQVFF5RlRUVzl2UW9NbExrUVJJaFdYWjlGYjVo?=
 =?utf-8?B?WTcrRTBmaUNVdmxtVWUyNEl4Ty9VOVN6UnA4ZFh2ZjNvcUJuYThEV3BYYW16?=
 =?utf-8?B?RWt4NzZDbEorci84REMzeWNXZTdaODE5aXhqUmdDVW5GYWJqL0VRdGwyNDJV?=
 =?utf-8?Q?1HnlT5nHbfFjt5j2W3T4VUVoz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd2d12c-89f6-43cc-69d6-08db82aff2dc
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:14:00.9960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbfUjtH1dTQte/hiR3U8S2HF/JF+P+Hj+W1Znub5OnkT0aZDJisTV1fuMF7qAU0SgKuC9qbBjwU9ZGwOgKQVhQ==
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
 drivers/thermal/mediatek/lvts_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index b693fac2d677..5dfa69c7669e 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1158,7 +1158,7 @@ static int lvts_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int lvts_remove(struct platform_device *pdev)
+static void lvts_remove(struct platform_device *pdev)
 {
 	struct lvts_domain *lvts_td;
 	int i;
@@ -1169,8 +1169,6 @@ static int lvts_remove(struct platform_device *pdev)
 		lvts_ctrl_set_enable(&lvts_td->lvts_ctrl[i], false);
 
 	lvts_debugfs_exit(lvts_td);
-
-	return 0;
 }
 
 static const struct lvts_ctrl_data mt8195_lvts_mcu_data_ctrl[] = {
@@ -1271,7 +1269,7 @@ MODULE_DEVICE_TABLE(of, lvts_of_match);
 
 static struct platform_driver lvts_driver = {
 	.probe = lvts_probe,
-	.remove = lvts_remove,
+	.remove_new = lvts_remove,
 	.driver = {
 		.name = "mtk-lvts-thermal",
 		.of_match_table = lvts_of_match,
-- 
2.39.0

