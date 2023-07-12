Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABC5750123
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjGLITO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbjGLISI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:18:08 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2125.outbound.protection.outlook.com [40.107.215.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4798C268C;
        Wed, 12 Jul 2023 01:16:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itgAo1XV+z+mBO7pOrcWLlfwh8KXgzXBBZPE02o3ZdHGM5HAgA9CVEAkJVfEg4PouEyC33bP02OD54MRyjfDB7zlaOJFEpfBdw1cgz9bSq/NwCsIp6cZyKj4/9Wzd7sSHXFIKVPVZ+mRzyHIUyZHcQg67lGTHBNAbzibitQD/Gy55E4xpdkVRdeSD+W/trkt92ZDi5ZSZwuEnWeOBuxOpV2I7HaB06WzNUL/R8CBQfUC4hRqSp21p37PFrOeITWAAETXpucSuvlEDGXOJfipaWgSKK28MrcS8M6qhtoCEkkbQ6YsIHRybVOXLE/Ks0X3/TkVzaxspvwfXyHQ6eQF9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwexwAivTuXG9PH+vKIuYHomSb4dE8f2xbl35x1I5FM=;
 b=Zh3SbAQHHed5/jZDSv8mOnm4rlfHHq/SKFDMtjaMJPZI7+RCagn4zriLFZ4tUzKWfy8anlG4/pQOHFx8LKMK01335Y6YywqARPImZQ2kxzxhQPH211lcYwwWJCtHfffB0NWn/1pwKGP9756jALrpbpQIZYj6FW0zndn6wnq2Br8gCXE9sSe1liL7GbBM5gqx0dCZ0Gmdbo0q62VfbucZkTnAwvhXF1NSH3sJyANQXgfR0w4X0r/zzYGT+pWJL9KT0akJMgUaV6OBRvBrct35OwcFFjvjpwbTm7P/GTJD1J3Ev3Ddhu+TaHybq2kg9WAqysjbSBeseK/CNau9M6tsSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwexwAivTuXG9PH+vKIuYHomSb4dE8f2xbl35x1I5FM=;
 b=D+CjgTzetb+FFhhB4Cb57Ks/Ep2sY5lQPhZRTizEopMKkDfNUDfO37C71lx3fX8RjEN8/biheopSajLSP/AdSYbLciF+cSz2vgnRDLTee2S+gO+6Rx3LPcj6jClGSaT8FxVmBjayGqCd6kgB+WUnbQxBVpJc7E6YbyiarAWVI00W2okg7GAw8jN7jgh2blijM/uLarBo0nHtdd2TUSOphkamqas53xMg5zSGUJBeUKHta4GGaCMxSHiS0JjI764e6qO0Sjr378Cii5Jz0EyC3cCb36PRkVudZz/F9iVx4ERiO1fWJ2KMOSncqF6h6RazOdcRbscaT2URYGUnP8wkhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5027.apcprd06.prod.outlook.com (2603:1096:400:1c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 08:14:38 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:14:38 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/27] thermal/drivers/exynos: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 16:12:56 +0800
Message-Id: <20230712081258.29254-25-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8eabc445-a10b-4a4b-8649-08db82b0093c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hv5mdTmvnI7IbTR3V1DsHDFHdM0tFZqt68MMsRYquQZlnqnYwouYAr1unKj+XQLfllow2qyt0WF9pIBY/i8L1nPmyZuiDweQWGCT8Hsi7AdXsDt4vD2HRAO1z9B7/NLSQCpptqkajgH9KYBwhBXFgU3t/s1ppnEBZW9UPMZuEziBIutVWiJbuKIBCoAugJ+nWthlrVSw6/Z7m4RMvb9+hbix338n8aNY3z/wsAr44QzM+N9hVo/tkFqMb5uNsq4lXLL9n390Rio+vMxVbN9bsQTOlMo87W3BG7EP6k80TW4Qm5YnJ0+SPCLFilBacDss9SkPHOkNyVLbH7cfOXQQDiqemQZs6rF2J4Osa3Dkueb28WhP9dCDmKl/jBSe7X3ultsBP0Vn/zgfAwyF3VSHMuj13EFWkUGnhAvmtkO9+58iO5fOt0osV7Uul8Oq3LWCd6HJX0viCQ09crkkikvo7RbnUpOpcvzNAYOr2z9jTWy2ifRfqAZuR6b7Pre68IgJ30GosYHRY1zV7dG0WvcLRVS6vubJYFVoQX4brc1xqQ+dkAV4G+bp6CDENzlHnfByqB9F5lrkfpj55BX84fW6JgQ7IGGk9a7SxUP+/eof6XnH0Qo1fjRGzCaAlgerhYYd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39850400004)(366004)(376002)(136003)(346002)(451199021)(66556008)(66946007)(66476007)(4326008)(478600001)(36756003)(110136005)(54906003)(86362001)(26005)(186003)(1076003)(6506007)(6666004)(6512007)(6486002)(52116002)(83380400001)(38350700002)(38100700002)(2616005)(41300700001)(7416002)(8676002)(8936002)(5660300002)(316002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXo1Vmw0UllobDR4QjdKVUFnYU9xbnZSZEJRT3ZnNkpmVi83QlMvVlVsVnhN?=
 =?utf-8?B?NThJS3E5dUcvaXlUK3cvNXM2Y2E2MHNvYW5ZZGttU0hwbDluQ3lHQXV5aVdI?=
 =?utf-8?B?ZEF0ZWFjVHBRZDNMejIvY08vYkxaNlJtempLK0pzbDVnc1ZMaHdHVEtBQ1gr?=
 =?utf-8?B?eWtuNjlwODgzZ0Y0TWozd1J2RFlteVFySGZkZENZSElHVEU4S0RrZDgwSkNR?=
 =?utf-8?B?ZVJLNHJPUDRzOTJ1REpYQlJ3d0l5dVdyM2lTTFVLUmZLV2tpQTlLRnR2Z2Y1?=
 =?utf-8?B?OE5WNkh1Tnhid3dFWHBqbXFwb2NqR0p5Q2J3UFNWTGlTbDFnQW1OdnZreFlm?=
 =?utf-8?B?a2hRaCszcTVsSWlVa0RRKy9ySG1XcEFOZysxbkxTUjUzeko2WnpsN0I2cmJ6?=
 =?utf-8?B?VmN6L2czTFRjQ1Q4a3V6YmZUQ3pYcCtJVWdsQkVWQkd4WFBUOW9FMVIvbmNI?=
 =?utf-8?B?WmIyVkdSOGNOZzJhbkNVQ2lkSmw0bEphZ1hpREwxWDNOblM3VzloZG1pdHNU?=
 =?utf-8?B?ZGdYbGJnQjJUMDFnSkNvTFljU21Na04zZFdBbEJhNTE2aGxyU2JxRnh3MGlY?=
 =?utf-8?B?S1p4YkxoOXcrMlRJbnZSSHJzcUlwU2NGM0ZnY1VSOGhtZEkwbSthT2VxMEpS?=
 =?utf-8?B?NXkyelBqRC83aThVSXNjUHVETmtxNFlGeWhsZ2JJWEM2WXNSSDdtNEhZL25S?=
 =?utf-8?B?UFphU1RhNThwbFRaUTJWd0g5Smp1VC9mdkVJY1hNNGpaUkNRRjhDT2tXTWFI?=
 =?utf-8?B?WHpFMjZGUG5wZXh4QW1yMzdJUDFmYmt0L0wzVWZITVZYbnE4eE5LN1Q0YlFD?=
 =?utf-8?B?SWNzSHVqZGJrVFhqc3ZTYWNTWHgrRjVQVHArZ3cvV2tucVlHNnRXcVRjRzBy?=
 =?utf-8?B?cnFlSlpBQlYyTW9oMDNhcWRFekQvQXM0ZldCVmZkTzJjUklOOVJwbHFTc3M0?=
 =?utf-8?B?ZlpQZ0p2SDlSaHcyeFJtTHB4NTd3ZW03QzBiekxZMU9tTjZoZWlkeTFaRWxv?=
 =?utf-8?B?ZFpDUlVJWGw5MjBsczlvT0RmZ2JOSmh6cFhGM1F2ZnMva0RJL05CWUlnU1dl?=
 =?utf-8?B?L2Framl6c1I2YUIrMy9jdHB5ZTJCam1LQ01FVktEV1hqUUxUVFZGZ1lkMjA2?=
 =?utf-8?B?L2lvVlI3T0ROejREaVpWWHVMMXcxL2s5MmJtUmUvRks1NUV5VG51ZDNYQTBu?=
 =?utf-8?B?NjZubm9peXY5WFd6NFc3aXF5U2VXUEpGanJMR3I3dzRPUEhJSDgwdU5TaWdF?=
 =?utf-8?B?NTVRRVMvRW94cTRSRnhCMllvWVBVSUNmS3FXRDE3OHlPS2NmbGpYK2hXS1NI?=
 =?utf-8?B?TU9CKzdweVJTUE9VVVdGUE5sMktUR1FuaUtBV1UzTUJkeFVRMmo4b0RXS3Zu?=
 =?utf-8?B?ODA4U0cwVEhNUU8vK3VRVWI0SW1QWHNtbCtVRUwwcXNyS1V5cjMyZGQ4aVYr?=
 =?utf-8?B?Z1dHaVZDU1NOOFZOQXJSVTEzVFhSNHVCbTh5TjRUZWcweEh0L21wOFFCcDlI?=
 =?utf-8?B?TkZXMkhSaTBpSnorU0dwTGhnK1NIRjF6Q2lVL3B2UHBsL3hvZVpRRGZBaENI?=
 =?utf-8?B?YzJMRFkzQVNPVStxdFRSUU9MRDRmaVZ3SFhkVFB1RlZPd1ZpSElYWHZEQi9u?=
 =?utf-8?B?dStHNzBJWlh4USt1N2ZpUHBoeURhTFBYbFlPZStVclRvajRIQ2pkQndFeDYv?=
 =?utf-8?B?YVZsR2xEdWxIM3RBNlE3a2Era1FyaW1kalkwT1lpZlRlRmkwR0RDanYzOWUy?=
 =?utf-8?B?RnB6WWdET3ZZN1c5WmVrbE9IR0xKWjhjWEd3WElWaDQrWXhMa3dsOGc3amFz?=
 =?utf-8?B?QUZJSFkyenZCTFI0OXduMUVsY3J2SWdZOHIvdlpvU1kzVUZRYkZDUlJhRVJU?=
 =?utf-8?B?a3d3d2szOExxMm0xckxBdEFVUjF2TVQyS1cwb2RhRTNIUU5GeUJaLzhOem9G?=
 =?utf-8?B?N1BvQVg2NWJkcU1SY3crYTZ2WnhiQVBvc2plK093b1M0MkV6MHgxamlkZTJE?=
 =?utf-8?B?dys4VGRWOXBYSWlXNGx0SFFUU1QyQ1V6ZTFrZGp5eTVPY2ZaQ290ZCtuN2s4?=
 =?utf-8?B?bW5Zejd4dk5veXpQR0swclV5cXRzazVqY2JpZDM5Qm0wYnhjZE1ZaTQ0ZmtN?=
 =?utf-8?Q?YDiIiwtQzHVPRVPcqNkZLicy9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eabc445-a10b-4a4b-8649-08db82b0093c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:14:38.5280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5a0mwpVlssaeNODlpSoH/B74qhPdUPwdGkLH9FvAPfzK3SyyS8u8yHmMjPn00MLD+8KKAr8I7UrzcfY4FrlsDg==
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
 drivers/thermal/samsung/exynos_tmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 45e5c840d130..576ad558cfb7 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1124,7 +1124,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int exynos_tmu_remove(struct platform_device *pdev)
+static void exynos_tmu_remove(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 
@@ -1137,8 +1137,6 @@ static int exynos_tmu_remove(struct platform_device *pdev)
 
 	if (!IS_ERR(data->regulator))
 		regulator_disable(data->regulator);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1173,7 +1171,7 @@ static struct platform_driver exynos_tmu_driver = {
 		.of_match_table = exynos_tmu_match,
 	},
 	.probe = exynos_tmu_probe,
-	.remove	= exynos_tmu_remove,
+	.remove_new = exynos_tmu_remove,
 };
 
 module_platform_driver(exynos_tmu_driver);
-- 
2.39.0

