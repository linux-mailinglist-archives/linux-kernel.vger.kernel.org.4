Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5817A750100
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjGLIPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjGLIOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:14:53 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2116.outbound.protection.outlook.com [40.107.215.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991971FF2;
        Wed, 12 Jul 2023 01:14:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6fJ27s+hBe4wIYM1A+vw2o9OAbxGK1+qeBU92kysCVN8JBzGBRmL5kAHbp+Re1ipa9BBo6D5uveG40iqTg8UMC/exDixs4Sp/oSu1KkNR8mJl2KeJRcyzl39SOVgVo1YNH0pr/hyMX4TQ92xTKb1yLlLzzUQ4xlg40rNoYn8EzBIREbKeI4sM7sPJxZVzwK6wEbbw63wdaVYZnlfRRwsVmxymS0RIcN2kiZjtlnxJx9xidFceZYivUfd+4BcTHsURjFHzmFIJeaJfIB65XPzaUh8ViouQFTruEyzLjcK4928XlxwOvlW045Bz0+BUpERnHzyRylrY+Cph3jbBZuow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYrFEyS6+kzQWw8nVis4Vnhn01IbbeVNBEzmAGLb3Rs=;
 b=UJGEOX3pDii0xzMRsxGSfCCnYlYlHWoRUaKlCc5ceU+AdrcGHW6QMU1/wIpUJ7lCZ/GVUWAhVHNqrKmG1IuNqj0sf4mEDnqyeJvEe44Xmwl+v+Ii5FegfhqEkZj0ELwo7JhPCIqV0GcQF0MvXJUWlsLq+qR94wbiel2NgaJYbs1gqOVB2yk9BZaJr/nqxf5oxGWA2amlGHDlq5ii0MkI7KcQ0Ao/PH3mMjHJA6df4QRMpfj6Pw0KhHTFqWtWBoR1rG99QWRElGmfrG2zoo8xMZEYbjfG3KpEbdyZ8QyEl0JKOFHxg8gPBCtTbPAAQWIAyi5mVVkb5IiHMczWGTU9IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYrFEyS6+kzQWw8nVis4Vnhn01IbbeVNBEzmAGLb3Rs=;
 b=Gn6u57XeScyreIqQa+g07qzJm12CzQ54afKoi/Zj6yDDPuJVQogVH+tPIptEx5Pi66Slhq4KFW1Ay+SNHDlWUU9KToxj5kc6f1nN3+U+4vLJBBeFWFChpRMwI4/vgP2c8JSI1+efsT3132/fw3UzOObgM+kuP4uhDx6aR/DFOHyRPoutNpzsGMqAaxzjh8V4scApKx+V3BOx4fXCCvguy2nBIBxPoxQVs1FvTv63WVDynxV0X+NCalKTc3naLUKIl91bYCLpYsdY5Lw52G5zi3sk6Zd9dEe5zzuHc+oG8tqfEXe6IYw+a4YzZUH/ZBUVL7eT2OKhtW33jKG6MjKVEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5382.apcprd06.prod.outlook.com (2603:1096:4:1d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 08:14:10 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:14:10 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/27] thermal/drivers/uniphier: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 16:12:42 +0800
Message-Id: <20230712081258.29254-11-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: d38ae62b-e0a8-4614-1b75-08db82aff888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 38PFuoKpKw7kGC75QAesBjf3V9XnOUVo2c84jwsHWLBwYmLgTZt48CkU7a5KzvvVekmkaOTJQ3/YIuq1OjiTvmRwnC81xg2XShwcpTKPRqAXBGzWMt2rl2ttUsPpOq6+YgehMESGU0s2zykuXX39O3Rduil+vIRLRcZUmSrHLGWN7jijS63YCCxXR7BH91u0RkVu9g1ufqMfPOJPltIHxrODReuhkrwh8bkGIQmSl6O63WqCy83fVArhAWeVL1k9X+SWjvscab9u2SwX83SdG7tmuxBKZx4UqNJtUAxE9FXld7S7kxJ0BqebmIYfUM4GzmVfQlkb+K4XEXW8phis1pVVAUzgDZKLmDxmRlzC88xDHhWAcmNFS7zM5EyzwocURyLnY0AZp4TugY9dQnHWbMGkzGLvB8OF4I4ecjvZf7Cr7Kg7jl//BALjRkwWML7t0UUN+4JDXZMJMLbqqzw773V8TefX9nFXr4HRrZ80C1di13s9K9BAHdmLdsHOrZYiFrovYEri8krOJcGwjWYHtMbSudtX59QqVZ/06YSc06fEbw6oBhgsYvguYUj5vOO+Qav5uw/k6UGL4FnB2T9fXJgv5bMEa//0ASw2rgkBaKhC/KId75gdX/LUhRregy+3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(6666004)(52116002)(6486002)(478600001)(54906003)(110136005)(6506007)(1076003)(26005)(186003)(6512007)(2906002)(66946007)(41300700001)(66476007)(316002)(8936002)(66556008)(7416002)(4326008)(5660300002)(38100700002)(38350700002)(8676002)(86362001)(36756003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG5reStWZTNjMmUyVElzRnBVSTBPTHRkVi9CbDVuazRwWHVUOU8vZEE1Q0Ji?=
 =?utf-8?B?b3ZXam9JSHlEMkJVbEx3b0RzRVdkRTg1d0JNM0RxZm1PN2s2cEtVR3MrRGRF?=
 =?utf-8?B?dzZNOGtnU0Nyd2ttbHFzbVVFOHR6VmVETmp3MFc1VjgwbWpMeWQvWXEybkhN?=
 =?utf-8?B?M1JPZ2xPZWEvMklucUxNdFNXTWF0WkVYd0lMR04zZ3B3dXFWTWNmQW9NR2xS?=
 =?utf-8?B?N1FpQzY1aHNZVllRNURwMkl3YVVsYkhKeXY4bmhEMlQzckJnazNjVVNqMlps?=
 =?utf-8?B?b2U0V2lUeDlBTG9uOTVvMXc5Ly8ramJubEtxVjl5OGxsdkFuaWg1VDY4UUI2?=
 =?utf-8?B?RnVBWTV1THQzcHgxS1k0dG92TEtuNElkUEJQYWNlcmIzMk42cXBHMEZaaGlU?=
 =?utf-8?B?b2ZId3YvbzcyUFZOZm5XdCt0OXZ6dGpka2ZFWjd5OVZBQWdFVU5VSEtmOUtB?=
 =?utf-8?B?SmRwQkxZdzVSOFZLam96SWcyWlloMXRiRXN6YjRyN3Q5OEhNcTh5UnoxaExE?=
 =?utf-8?B?b3gzNzY4QzFiVlY5TUJRV01aelkrVzducjBSbEE1OWtoSTBUQlMxS1FJbE1m?=
 =?utf-8?B?dHNhTWJiWllBZFJGam1jU2V1Z0pBTmQ2MFlZTE43MExiMS9xWVkvT1lvUURR?=
 =?utf-8?B?TEt0WFdkV09tQUFlRDZlbnVPVTI2c2hqSmFsdEdxV3FNNVRyWWxteEk1L3lM?=
 =?utf-8?B?Rm5PdE0zS1B6R1dudjZYdjFYRHNkYWtOdjNmdlJlK3RNOTJSRm9BVEI0bk00?=
 =?utf-8?B?NUxMRkVXeDlJYlZpQS94QWdVSXl1aU53OTY0TDhuek5DMEErWWYyNjYzS0h6?=
 =?utf-8?B?RVF1SzNVUUtrWjFXOWdVRGRCWFJXeE5WdjZ1UjhBc1pYRTlEbzRWVUVmcGFl?=
 =?utf-8?B?U1hpbUQxb2kwUVpIZUpqQjc1OWhEMmFZMUovN0JwTEQzajVlMkdUTkFjNDlr?=
 =?utf-8?B?YURBa1V0MGdBS2MzYzYyNEdTNVZ6MGhqYUZCekZCQmJNY2hYdTRROTBGQnRk?=
 =?utf-8?B?UFV2b1gyM3Q4M1BqTVAvd3lrcDVQTXhkcU9nZ3hvWGVySDhKUTBpMzVyZ2Ew?=
 =?utf-8?B?Z21CRVZFeVVON1VnMHhRTmFzTG5YSlYrWGx2T2loN252VEExd3ZWR3RYVkNX?=
 =?utf-8?B?NzVzeXM2NXNYU0Rsb3dZcmhOWEFzWVNEUGgrZE5TL2pWSDVmVHRCeEN5NFdS?=
 =?utf-8?B?TDFYOUNMOWdVNFgrR1BENUh6SkZhZ29TbXBHYnZXdGpjV0t1TkRNcW80WU5v?=
 =?utf-8?B?K3Y3ZjJISGRCWEpsZ0JacDVPS2x0Tk1hd3pTU3NaUjRCb0lVeCtFako2M0F4?=
 =?utf-8?B?cUhEUDc5OW1xcmlvTGR6ano1QXJPeC8zbllZejRwMFU3NXgvRGZvaXBhQzNO?=
 =?utf-8?B?RnBPMEt0U0dVcU5UT2RIQTBiZmluWFp1cGU4RHFXN2ZtbjRGR29oZkJIRnd1?=
 =?utf-8?B?eUlNa3JCWm9XRWxzTlRHUGt4QTZoSk5YajZzeVBla014WXpjRUVsV1ZSemJ6?=
 =?utf-8?B?OU4wSGhGeVZVUEljMWxNeU5NTGVXeU9Xd2hEbDJxRlZYdzhpSVVqaW12WC9U?=
 =?utf-8?B?MTVHL2ZTQVR1S1IwNEtvTGxaV0tqbmFIN21JWjFiZHJ2enk5VlVxMnA4LzI0?=
 =?utf-8?B?QStrWE1UaUF6UVZBS25xdWg0Tmc3WVVlWVlNdHJ5bE9KZVg5aExmbkI5QVox?=
 =?utf-8?B?SE5VaGErSm1vYVRTMWw4T0pKelAwUmxaOHpDY0VzR25PZ1FPYkE2SklvOFp0?=
 =?utf-8?B?K1ZJMnBnd2xEV2ZkUndGUHlacEx3aWwzVGdCZzMraW9TZnRCNnRNYnNnS2lL?=
 =?utf-8?B?TE9KajNud1l6cCt5R2gvd2dDcWN6elNTZWt2eWV1K1g5TU9oMWhtaFpnWVp1?=
 =?utf-8?B?TTk2cUYrcGFNZk1LN0c2dmhnakhGNGxGZTRHNGw1RzY1RjdPUlQrenZ1UXor?=
 =?utf-8?B?c2hteFRGQk5FRTl2d25KeklYdHNwZG9uQkp3MC9qOTVtQ0tsSDFiaElKSVJD?=
 =?utf-8?B?SjF5VGdlYUxVMThmaENTVUdBck1HSXppOUd0VGFTUm1KaENJY0sxb0VaaDly?=
 =?utf-8?B?L3JsRDFuZ1NSVEloRUdaSGtrcEZFY2VxUURyQStoWVVMUG4zUGs2aVVVZkIw?=
 =?utf-8?Q?oqByV/FC6fgC/LaJiM32T0sRe?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d38ae62b-e0a8-4614-1b75-08db82aff888
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:14:10.5500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2TlHxvv8kcHR8GZmDTH4UJb+a4WTClu3T53dHbgNXNkp9fZyj4xlvws+Vt/L3h0CvhrXgag0jO5znoX3cKk6Q==
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
 drivers/thermal/uniphier_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index aef6119cc004..a5320ec9939c 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -318,14 +318,12 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int uniphier_tm_remove(struct platform_device *pdev)
+static void uniphier_tm_remove(struct platform_device *pdev)
 {
 	struct uniphier_tm_dev *tdev = platform_get_drvdata(pdev);
 
 	/* disable sensor */
 	uniphier_tm_disable_sensor(tdev);
-
-	return 0;
 }
 
 static const struct uniphier_tm_soc_data uniphier_pxs2_tm_data = {
@@ -363,7 +361,7 @@ MODULE_DEVICE_TABLE(of, uniphier_tm_dt_ids);
 
 static struct platform_driver uniphier_tm_driver = {
 	.probe = uniphier_tm_probe,
-	.remove = uniphier_tm_remove,
+	.remove_new = uniphier_tm_remove,
 	.driver = {
 		.name = "uniphier-thermal",
 		.of_match_table = uniphier_tm_dt_ids,
-- 
2.39.0

