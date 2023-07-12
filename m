Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26A0750114
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjGLIRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjGLIQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:16:56 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2136.outbound.protection.outlook.com [40.107.215.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD721FD7;
        Wed, 12 Jul 2023 01:15:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyC1QjD0hcqSk+v2ervN8vezHNPx+DU0rKNj7S/K/tCs8OqxwfzeP9YXZQ/bwFn+ZwW2+Ketwesf8GUqm4rMcimXo4O4j2W3VMJVRaJn/Wy8yiRMVNr5qo1cts6iXm7XkyWjhIiIvmGyAedEi1Ywx9LtStPXiAPttBepbN/6ERYec4xElvR2v1C2Nb4GvviBtneku6KkHpmKd1Huf0jn5s8iIKkZ+FmU4eKo6QebdEaC8ua9h0y0tI3K7koS/3syObbkTy8Nd0D1s6bmB5OA1i+xFxrvQ/RPzz4RtlY2z+24HVxSXnBFa+KUywNVYOKq9k65QGa1G1bQDRl9xHjOYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkE8UIAMl81x4IEXLUNUoD00xlsLnumBQtjcFmK62/A=;
 b=FtxARiCNw7GgPdba1Tc7LCxr9o0gSsgcHUMQN9uCXS8vdq7FzZis6gMAu3smg8TaBlsGFakvPvhm3FbR43UPbJ6wylinpEGJT12FxuM0PBm7c1YbJTxPZjcJZVxXhR20vO2xkdqe2bCYqSkQC2NM+aOZGqLQsoBNJ/yrAJtmIh5rEKH5xmZY4B84xAcae0gcUY5MgQXdz9ukuJikqYsP+196UpIvCYKJIjOtyrVmbCqGvOBqY1l3O5aYH6sqfysu488bp1ouBgSnt9gCc0il7v1iP+JDxgNQm9M+F+U0wg/khUqCpHV5NInAns+/TcSYqDsIYslJN6QkjGTLrr8NUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkE8UIAMl81x4IEXLUNUoD00xlsLnumBQtjcFmK62/A=;
 b=duSF143yZnR2YoqVBwPV3YDEaag7BWm9aB2TjwVHfhlCXiFIt2VymumHAhj7H/JGXV+oLeD1vN4KDjqV/rn8BULX/yinz/+vTTLNWDJCUgHEiMcRTEH3P91/oIFPo2qB6zQnwtO7/mAE4u5RBltVm/YTCwcPBebhyN8n1rtfEKocY3QIvTnkFavIC3JyAUCxfdv7YbZcMkOCDZ4DZDer/t/X+FXYp8neyRkSb9ge1UAmBtCSrWv5EwFpygzU9D2pA+T52kggRfg8XFFM8bhQMJWoYVmdqy+eygLQJYOD7Ub6+cxYo7tCsT7P1yGKweiKNoAhi+cKYl+xF3r2rN0iTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5027.apcprd06.prod.outlook.com (2603:1096:400:1c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 08:14:40 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:14:40 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 26/27] thermal/drivers/kirkwood: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 16:12:57 +0800
Message-Id: <20230712081258.29254-26-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a29f5c-bc1e-4786-8fbf-08db82b00a79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EG7FypUVyLIRFKds2RAt3uwkrGAMkIM4d9QQ6Wo+/wutVWOCU1wDHhumCmuyZ4z05dU68J2Fl243DZgtIGjjBKzywh7QgchAtDx5VsFg4QGKVFK+ZHf9xFmdkrBhQWr9tunN9x2oK+M3ILVE7pB0uYC0B1M3r0KTbBjIELQ53eCBGCJks+Req2UZtMnCdvMLEqBnVTyr/e/kOWt0LrtFSC1me6Fp5z+PmP/NAUKr7ZD9xuB4jDgqcrhjrExFZJJCAnvCaqwoc4j31iIccyvJ+rsIVutE3gOUWN06yyUjyc4bycy63muutPCH5YdQuy/Nm6HxW+tHIapqsfxj7TUEQ+PMK72k0HyshxrzkllO93aYrbG9nu7fHd2RfbSORlExdKev0+KEQFDv0JP/xe2Fq1czYOyJ2+Xm3L4DfygMGzZj52jZZ7WeO15VTC1NKmhXYKL3yrPML2DJDoSHo2q6wyffidseqkX2fm5U/lzD09oPzuacaOpxaCyE7sFZlr8stimCS9fJ7vwxxM2AegCbLiLJ4EMc4p2sX07r0bus5sN1WYPlGgxickzR0CtLkPYF8pjlCvG/sl9Mf7NNmQGghhvMNf8TL6tNSvQpk97BVggjVvi14S+JFB0jBTlazkaD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39850400004)(366004)(376002)(136003)(346002)(451199021)(66556008)(66946007)(66476007)(4326008)(478600001)(36756003)(110136005)(54906003)(86362001)(26005)(186003)(1076003)(6506007)(6666004)(6512007)(6486002)(52116002)(83380400001)(38350700002)(38100700002)(2616005)(41300700001)(8676002)(8936002)(5660300002)(316002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWJ2QjY3Y2ZHZllrVW82L0VOUytOa1VsWmdKSHROejRJV3hycitiRUZrdzk0?=
 =?utf-8?B?aE1lRGZIWlU5alo1KzBYOWhnaDRMZER2QXUzeGZCbk9GUG5JUDhIbU94ZXFy?=
 =?utf-8?B?bCtheGsvMzBram95Z25HWVNzQ1FxS0NwbStFaHlsRjQ5YU5Dd0IrdlNFRXV6?=
 =?utf-8?B?bER1VnByUzRWQXIzNDJFU21XcWtickJSb3VFRlgxZjlkL293cnZydU9OZ2cv?=
 =?utf-8?B?QVY3MHhhSHJCYVBJNWlSVDE1Q2dEWkxaTG9TblhUZ3lUWmxpdkdIMytISktO?=
 =?utf-8?B?KzQ2VnVyNWY5OGVIUHM3MVNnQkhwSlhUMkphUlZmQzh1NVBQaXhhb21WQ0RI?=
 =?utf-8?B?bkl6RDYxaWtSejFVNEhKV0RmMWx2c09GSGRDR2NTNEhmbEsyL3FVRWRkc0s5?=
 =?utf-8?B?UnRJVGx0d1lZam5JRGNEd01CZ2FRV3VtMEZmNXg4NGpEMzJwSVFIeUtvOUls?=
 =?utf-8?B?bENhWkFMbnBMQkZ5TWhwMHh0TmpiVE45WnpnMnBTUFcyNWE3UzV1Nlc3bDd3?=
 =?utf-8?B?Z1c0VzEwdFdVQlRWMlNQSkVJTnRpYVV2UDl2enlKTEd4YWFZVUJDanpKNlU1?=
 =?utf-8?B?aW4ydzVUZ0JyRWN5aEtWYXRWb2NqVDZRWkpKWjIyQklaTGtTbytkUG1qVFZv?=
 =?utf-8?B?blptcjlxN0kzRUZvSllWNmI2d0Nob2hDcXhCSVFleExIcGEwdFJ3c0pib0VH?=
 =?utf-8?B?RUZ0aXFpQXc1MmE0VllTYmR5T0szMkJWRU5RbE1DamRjcHVyU1ZwZjdvL3JM?=
 =?utf-8?B?cWZHMGUwNEQzMDhwcnBqY3hJQjVHU21SWEVCeXI2MTVyRjE3Tm5Bd3BWOFpG?=
 =?utf-8?B?RmowM1hreUltRmN1MUo0dW0ybDQrWlJUeWhhb0F5aFBhelFEcGFNa2dkcHl2?=
 =?utf-8?B?MzFpL3BOaWFTT2NJM00yNHdUWmRVTlZaL21DQ1lRNW5BQmJ5NzFnalFYWnRw?=
 =?utf-8?B?STVST3NKMG1nYzNtd211eFNPelJZVkhUUVBFQ2hWNHhCaU9zZ1R1V2x5UWRi?=
 =?utf-8?B?dzZZVXU2aWdIWmpVcTBnb1JvVzQ5UDFvUG1Cd1l0Q0JZNEZnSDdmejFpSm9D?=
 =?utf-8?B?a2VIdlBFZmlyai8rMTlUY3E0NG5DR3JMTENyU3dRU1hiM0ZpbjV6QjJYV05B?=
 =?utf-8?B?T0U2cDdQU3VPdWc4L1I4bkxRTlNpZlQzUUl3NGIvbFlZUUxkYVVyYVAzZ1ov?=
 =?utf-8?B?WjlmMXBRT3dTWk5menZCK3BBcm1YVnFXNkp1b1lFVjlXTlVFT2ZaLzRpbkxy?=
 =?utf-8?B?WXRLc1RpNmt5WlE2OXVLTmpPaWdJb2NIcGpBVTlBbFV5eDVaSHd5eUhkQXRK?=
 =?utf-8?B?R2dQR0dzTkJhN1RiTGVBTk1pMSs5NmpPZTQ0dVliVXJkbmhzblBaTXpxY0tq?=
 =?utf-8?B?a21ENHlKWjc3NmVZU0VZVkl0eDk1enYzVm5PTW9oODFqcjVkWE41VEg1WW9P?=
 =?utf-8?B?WjBUOHRhUjRQb2xVYmY4UjNaWkZjOFRMczgyVDZDYStCbWhYZ3hOS1VmZmtk?=
 =?utf-8?B?OFVBTU5PeWJhTlJYWS9qTXMwczBsNlR0WEVrRFNVRkZsS2srdE14dkQxM1p2?=
 =?utf-8?B?MEFXRThnTEtOZEM2ZnI1UHdyQTBvTG5Ia01naXhBcS9oVGJwVWRyNDRURW5Z?=
 =?utf-8?B?WDBtTHdwTHV3c2ZiZmova2xuZG5rck51bHdtODRoaFBJQzRxdVlNWitHOFli?=
 =?utf-8?B?ZHVoSGUreW1ObFVVUFZBNHVpZDRrQkZxNEk5N1p6RHZqa3Y2SWNuRkxzRW9u?=
 =?utf-8?B?OUN5enlESGw0aFZEQ080TmR2SXJibUdDZWJBS2ZnZVpKWlZNWHRLMStSYWNX?=
 =?utf-8?B?cEpJUTZHaHZhN3F0TDJwcG4yOVlkRHhZN05EV3BndHBvVmZYQ0llZEpCVFpq?=
 =?utf-8?B?RjQ3bjg5bS9Zc0hIV3lpOWxRZGdrQTRlUDVkNDRzU2FGTWtoMTAxbVpBd2tP?=
 =?utf-8?B?Vngremo4MkY2SmxOM25yKy9rRkRVeWs2WU94U0F6ditJSUlvQ2UzNTJqUmZ4?=
 =?utf-8?B?WCtQZFUxMDliTyswRTM1cjk0MnZDNDBUTHQzWGZDMHhMcERvVitWUEdFc3VR?=
 =?utf-8?B?RXdMZ1VJZStPbDJtNmpXdVpkVHgwdkVOeGpUdXI4dWFFeE1rTzhveFk3Mmo4?=
 =?utf-8?Q?qr9lFgIDs5y3jWmVpw+Oni6N/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a29f5c-bc1e-4786-8fbf-08db82b00a79
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:14:40.6021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: veqoWnYkAB38GEB8w33CGmsJ1CwnHLpBKYyczsxkysyx8Lzm526fUo6e9zOovYGwD4YZV0Yrr2SF/vyumc1dfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5027
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
 drivers/thermal/kirkwood_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
index 668747bd86ef..94c95870f277 100644
--- a/drivers/thermal/kirkwood_thermal.c
+++ b/drivers/thermal/kirkwood_thermal.c
@@ -90,21 +90,19 @@ static int kirkwood_thermal_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int kirkwood_thermal_exit(struct platform_device *pdev)
+static void kirkwood_thermal_exit(struct platform_device *pdev)
 {
 	struct thermal_zone_device *kirkwood_thermal =
 		platform_get_drvdata(pdev);
 
 	thermal_zone_device_unregister(kirkwood_thermal);
-
-	return 0;
 }
 
 MODULE_DEVICE_TABLE(of, kirkwood_thermal_id_table);
 
 static struct platform_driver kirkwood_thermal_driver = {
 	.probe = kirkwood_thermal_probe,
-	.remove = kirkwood_thermal_exit,
+	.remove_new = kirkwood_thermal_exit,
 	.driver = {
 		.name = "kirkwood_thermal",
 		.of_match_table = kirkwood_thermal_id_table,
-- 
2.39.0

