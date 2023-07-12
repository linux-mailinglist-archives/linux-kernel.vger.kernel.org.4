Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7B7750104
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjGLIQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjGLIPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:15:24 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2090.outbound.protection.outlook.com [40.107.215.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0E62688;
        Wed, 12 Jul 2023 01:14:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oO54yIO1nm2asbrVHbiPYt7GIJGit7/McdLjvMW9xBUPB3gPr8suBCE+zrtFI6QW5XBsIYuhasUpku+wNkx4HkFiR2MYEQ94rC9VNadHMgMxalTUjd9riUCDzTKHk4KTMwfYRrS2CqEYFS4sXfLoQdSWF0e1HYHcT9mQELxM5VkzJ+7f0gJMmQUX0C1e4sKRJveczQiWpLmDAoGMYqkWBQTvsDZYWYoqUQDeMSOAu3Dm2v3J3ZD8g6RA2F7LkmNmWYjKqVE1b4Es60G5Y83eEPBXxM5DeC33bzHxaVfRLnZ2RZ4HENIJaAEzwdLS0oNIqM76YwfLyUTPHXLosmQd2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AmRGHLwszoXzj02IaQufMXzkfE0fzmNaTRUxzGYq9w=;
 b=bJjuLJrhd0Ynlynvm8iult0KFMufkEKNC1VqgH8R4N9TOx9xZrQVv2qQiTP315Gc14Fv76Whan0KiQvnnJV0tQGAFA2rTtJMdWlevwe5mgsXjDQ2IBmoABMk4bZf1jsXoQjjWyDuFMMYItf8PEUFiV/w3+JS1PdJ591s9QUfBO4qH4K9cCDc9xcbm6RgHYpsdrKIL2X984xXnKXcGVwhWdVumuLzXoVxJu7rZm7nZJV5D32u2yL/dsA1+VXb+pxJeCJkl1Iqk1vmsvJxKAgU1VNr602gJnGZxF+K3aWSHQhJzDxJN4CwU01TCr7bIMzU6ibo+eRpxOzkyK/HQ9/w6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AmRGHLwszoXzj02IaQufMXzkfE0fzmNaTRUxzGYq9w=;
 b=TrrVdMZCr781RbBSrdOc03V6YXleWAftYuv+/arDO+h3WPD8tcEfNBdo89ZBzzbqeu4D7kfDel4HbPD9MhRk1M9Gnk/fWFcGv2Y9OIJCTaiED5MoD3YKDD/qxiE0W3Y5Vyk3TOECQe6doV80bewdtIeMeoXSpCtYpll8vqt4vBK687mA1g4Zkg73Gw74PQPfK4TSpMESmAbKBp5qV3zP0Q4i6RY26bdZi47U+TF3nlweEtF/LLnU4oRouWofAvr3bDm5nB7D1U6mul3vnN+4X2cuq29pyH/Uw2XuvVwHRroAwOdT/yi3vvbNlTLIMmXS0QP6nM2IH/himvpapgZPhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6524.apcprd06.prod.outlook.com (2603:1096:101:171::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 08:14:18 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:14:18 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/27] thermal/drivers/imx: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 16:12:46 +0800
Message-Id: <20230712081258.29254-15-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 18734dab-774f-4604-5895-08db82affd51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2A6nk+I9VOI8TS0aD5s6HqtttCUVl2Xe0WR/3VWOC3BcnDjCrWae25Ht1m0pxv2GDkTagp/srCrh9SDD39D+3RoGMiAcJDK/0zFWAv2pCkJSXVPczxL5nRIY0oKh6Is54kyfrliU0pknEup0Em/KzNQq/nQU4Iu9mD10OW2y1+4swuXsEKDlY0h3bppn9uDpgWR0M2lm/KDAww8kpoiUyOaNlFgd/G1ZIXr80tUKd4ttfbs+Bq9BTt2Mm7cNBA2AZuUvxQJRe92mOSqpFanFlY4Tn79T6PTVi5zXhknPK6i1TrDYRo3aFX03D/8ENQ4uS6QT9BVAaJpH+EMLPG+3EgMf9wL2WrlsaTdhfcJjMP/BZXruzpm2Ukxk+2+EC6ooidHHD2evX7BG59mS3tQsjonslDkgSkiM/FdGgaAXbpGvvS/wTjIQqE68vMZTVxccvrm8m+N72zMtfpDOFmbbFicKDebuF1mQXaiooUIORxC1VU+rszoketTiYITBxKdnXXWAWi4UAolaSZM5E1CPr1yZLDuK2VYSsR3NmhNbb21TblHiocTVrr5lgDDjmPT7oY9TiM3s9D11HSDxR5f1Dr9bPbjPlbHJb9vozYyQGWwi1s5kk+EHwAyJsFcVR1AZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(8676002)(8936002)(5660300002)(186003)(2616005)(66574015)(83380400001)(7416002)(6506007)(26005)(86362001)(41300700001)(1076003)(6666004)(6486002)(52116002)(316002)(6512007)(66476007)(36756003)(2906002)(66946007)(66556008)(54906003)(478600001)(110136005)(4326008)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVFBcTBLdlZ5SEpoWjN4eklSSzVoM2J4dVVGeUVhQVp3OWpwVUVVSElOZWdV?=
 =?utf-8?B?d243ekN6SDJtY0R6VzhFTVNwQlovZVRHVGY3Q2EvdFF2MXJFQ0lNRzk4RHNK?=
 =?utf-8?B?OXRxTEh4TkFCVUFSMTFSYWx2NFh1aTVLN2c2aklnWURSb0N2dFJMZTlPVFRt?=
 =?utf-8?B?NVpsYytFdnhOS1Flc2t6ZHhod25wVHcwaDBFVFlGYXp3L2Y4YXFBbHhjTDdV?=
 =?utf-8?B?VnFOcE15cUF3SGV3U2hTMEhxUXZLU0o1MlBVRGVhOTkrdGtySGpjNnMvV1Vn?=
 =?utf-8?B?dVpnS1dwWW54bXhndTRHVE5uUDJHZXEyMXB4b3loQ1NPdjB2TGNRWVdJTE42?=
 =?utf-8?B?anRXWlpmUlV5K0k0R3JCeTlnaGs2Mjd6RHJ2MHJiWG1KMjR0V0NuQWJyalhU?=
 =?utf-8?B?SHB1TzFFcEVjKzkvUE5vR0dQa3hwMmVYYXdxY2RHbElvc2U3NXB0dGlEN3Ev?=
 =?utf-8?B?Qlpmcmx1SHlGRjdrbStqSzE2V1JjQVVKVDlST2U4MHFwOUxZcyt5MXJ2b0tP?=
 =?utf-8?B?czNJUi9COGFoWUtzZ2NIa2JwYkUrK0V5MGxpeUpjckxnTzRYRHJhMGM0YnJo?=
 =?utf-8?B?TTVlOG0zaGpBaWlCVll0TG93OWtodmt5ZnRLL1BTNGpYMlYydDc1VzlLb3lY?=
 =?utf-8?B?dlpLTmUzVDZOb3U5UVJCVUE1THJFWGZPc04ydi8xZldpZGh4a1pkYmtDRTM3?=
 =?utf-8?B?UTR0UWFhaS90ckxHSUJycnNYbmlGOGpDWmpPVDRGNDVzVHN5RU03SGFwU2sx?=
 =?utf-8?B?UmRldU1aOEtHekpTaFFyNzcrVEFvZkNrYWhoaDdISDhyZlhMejVZRWhvZGhv?=
 =?utf-8?B?dyszbEU2WEdmVEVyek9wbGkzTDd4THlwZVB4T2ZLQjNpVnlDSHh4VHE4Z1lV?=
 =?utf-8?B?azBpc1l4S1U3dDdHKzJCSjZyOTJYeFFvdWRKVzQwbEtoRnp2cmJMRmp4Tld6?=
 =?utf-8?B?Q3pLMEdmemowRUdRNmVzL1lESnhSWHh0dFhHYzdJN2lFVUZsbys0cXRuZGdP?=
 =?utf-8?B?aUtzM2wwRDV4eHZQTVpJTldpd1ZLZmdxUDYxYTBqT0ZCSS9VYmVIVW5WVzRt?=
 =?utf-8?B?czlCdFVFQjNrd3VjUFlubWFXdFZROVdjZVp0RVMvS0VXZ2lSK1lWTjd0blpa?=
 =?utf-8?B?NHVVdTRsclFDaklkSjZHTFBKMC9UVXNGKzh3RnpUSXJBS3ZtRlBRRkNJSEc4?=
 =?utf-8?B?bkJZc2VsbnFkSm9Ha0x3Z0RSZ0dRUzhaUTE5SHU1SnUyVVg3dnh5UjJLVmtx?=
 =?utf-8?B?NDFTUUtrbHBqZGxHakFOUmNXQW5EQkR3K1cxQStJdGl0eE02dDdINVZVMkdD?=
 =?utf-8?B?ODEwaFJnMmJEZG53Q1ZlYWVZcUMwcnk3N3BLOWRBM2ozamViOEI2M2FXOXRG?=
 =?utf-8?B?YTJtVFVDQ0NmZVN0Y2FjTElmRzVZNlhqYTFFZzBCM1pCUHUydkNQa0VWNHdV?=
 =?utf-8?B?elZta1dVbFN0VWxBWHhuQ2lmd0RLbGdYaUVmQ2Y2Z1ZodE9iWWgrYndIYmxE?=
 =?utf-8?B?OVpTMnNGRjdyYW9GK1dIQ0tDUmpFcjRnZDFRaEpsQWhvQXB1dG95VHhuUjFL?=
 =?utf-8?B?NVNXZHdIa0RuNVZmN1NZTGY0aXppR2dVYW92TWZtRExkMGs2SnVqRGpTOW1Y?=
 =?utf-8?B?T0Rmem1USEdtMDJFQTJkZHpiZ3FpZ2p3dWZ6STZrdUZOSHJ1QTAzYjRYdUlD?=
 =?utf-8?B?VjBRZDJ4anUrUXZTRUthb24xL3JpbGVuVnA4ZU9Zb2p4WFpxbXp5YUxnMlNB?=
 =?utf-8?B?ZGU4UVlUT1RYQVJsdTFEdFVpbjhJWXhTYVdYbDhrNHJNVDlLMVk5Z1NPdWhs?=
 =?utf-8?B?QTI4L2ZXSFoxbDNrUzVZM3lvQmdOR2VyUS9pU1YzTE1ma2g5T0svK3cyMjVi?=
 =?utf-8?B?NytUcUZFYUtocFMzQUJCdDUxOU5QR1lHK291TXJJcFExSk5EakRwL05NOHBE?=
 =?utf-8?B?cnlrTWx0cEFoT3BkdEpHRlJ1OHJwRzVZUkRDaXJsQ2ZsOUp4ZElJaDBOd2Nq?=
 =?utf-8?B?SzdURUVHREV2b21pWTlRcFlmRWxsa1lyamV2TmovL25hQVllai9kZ2lGNDJp?=
 =?utf-8?B?dTgxakdUZUhJNTNNUFVqS09lczc4K2ZKb2lnVys5dHhsVkRpL0pYMTlvTjBW?=
 =?utf-8?Q?Hk4JV5qFr5abjfeSzErq4HRrR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18734dab-774f-4604-5895-08db82affd51
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:14:18.5257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9V6DQjNNXiAVYQQkvSbmL7NFodWXdxZRaYiyeS0SzpgCsL6xQb0KFZxLYtqZC8lLlcFxCQY4T93hvfwtHnqwA==
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
 drivers/thermal/imx_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index a94ec0a0c9dd..0f033c2ca0ad 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -771,7 +771,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx_thermal_remove(struct platform_device *pdev)
+static void imx_thermal_remove(struct platform_device *pdev)
 {
 	struct imx_thermal_data *data = platform_get_drvdata(pdev);
 
@@ -780,8 +780,6 @@ static int imx_thermal_remove(struct platform_device *pdev)
 
 	thermal_zone_device_unregister(data->tz);
 	imx_thermal_unregister_legacy_cooling(data);
-
-	return 0;
 }
 
 static int __maybe_unused imx_thermal_suspend(struct device *dev)
@@ -880,7 +878,7 @@ static struct platform_driver imx_thermal = {
 		.of_match_table = of_imx_thermal_match,
 	},
 	.probe		= imx_thermal_probe,
-	.remove		= imx_thermal_remove,
+	.remove_new	= imx_thermal_remove,
 };
 module_platform_driver(imx_thermal);
 
-- 
2.39.0

