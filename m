Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B128E75011E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjGLISz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjGLIRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:17:55 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2090.outbound.protection.outlook.com [40.107.215.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46842212D;
        Wed, 12 Jul 2023 01:15:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyhx9hgZCVgEeOfNtFDRqoECWF0VGaPFwx0+suf6g9n/j6Fkgf4nGOOpvOWf1B9pkXCEawsDEVh6yrdw3Bgmfw1Ljqk11Rl0yoUDb6slaKnN6d43sM0czTK24U8AP36Xa2JnxoWNi9tM3bCBCeELXiF05xh/78vwu1jUsI++FVWn4ghf7LS5Gm513Omfl9R9jg1eosU5D8kYBtnsM1wsBrO709mLnUSckivOfID92rqFvPHso041JgVDBSIyCGfrqZifhJ3mR/anedIruZLl/s9AGokiQqW2JEMNm5xxxqyZVv2q1TnoyHTVjbRoA9UoW4yGxkopVRVopR2vue5C+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmlYxUlZMLn3gJYLM84Y8qIS0SHt06c0F82wrEX1jIo=;
 b=Ww9kBS/6dp7n0yRxFkYj+KcE4Q7z7G6mEgXweg6neT+1hkF/xbgnbHx4uBeCIeSwkwpnoTbMuhvCZwsVl588cQr+8zWnilz9+8v7/aU836wmfw0alKZN5UKKv2FU5YF3SvsmL8FHoPWTwxcyTEafaKJ7M8o3+RyNY1JZOIqtSCG/eJ6BB4ilfzm74mifMOVrfXZnvbwVzQ1/fQCBtasRyRSr/BkV48l+pacbgiaEPIMNWIMAzyvez83hiL8kTqjmR+Ceyozj349N2pON4fgcMgNvmRaavyPXHqgHEHxbRsj4UbMYldPZqpYV9/FJscnU9zEhEcnGaaiJZdyYu9bCnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmlYxUlZMLn3gJYLM84Y8qIS0SHt06c0F82wrEX1jIo=;
 b=d4dzxt+ASED5iSMqaBLFBG72lD8vHeemBAzz91JEMBbWIt9W68UGiJ9O6K2Np+HOsgQAuplWfSZkjL6AsHf5+vn1u/E1pFpLZ4ILDRA3EJ5g089IBS6x3u3YaAIzof0bxGyJG99BaqYuWD0CHq0j0P1VjqPzWr4GCM7IgPIccLCg/BoB7LJxjm/yP7GY41yRDhHYCMyqnZf4GwOHYbep8YpqpwE21LxD97lNyY7nFj+Uu+dUzW2ojxMXQM1PU4JgdEcYS7ioH7MjaMMevYj7w1SOFaWRGuIu854G4pPbwxp56E28gPlZWpYNdV7cJYxmsTehEaFkj7QGNa4tf6qbbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6524.apcprd06.prod.outlook.com (2603:1096:101:171::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 08:14:29 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:14:29 +0000
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
Subject: [PATCH 21/27] thermal/drivers/rcar_thermal: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 16:12:52 +0800
Message-Id: <20230712081258.29254-21-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9d0b128f-b9df-4228-7e7b-08db82b003df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NHDupBP443ajH+MN7hcS0xHZ8IKO0yRmOQLE+/gbBYlJ7VIewc4gZ4Fo4XSz+jnSFLc0wGb0w1eIYkLMuFWoQ4Igj3YJonBYnmya5wZ666QWA4ZxkSk5qCvMTrL2Hwg6pAuzEIoBk9njn2HpCS6jqjkVt06b5O3AT2zzJfsYwXJk+sFRBgyIzoOZ+8ZifsBInb2MinSkgAla8h0j+R82u1nQzm6iHAmKE7vOomC8ZpqI6sQXAZdcxrrcBBnhblDeRv8zhkUwuCxXtP0kuiVrjuQkjYIO/2CuqXXSa1g5G7AfZCf/ZbjuNdn1njrmPuINHs+8UQP/WaK6IRp1Pw0keMyRsubd1BnYD/F539lCOcsV8/ezzlhLmL8NkoFnF6Cx1SxehoX2oCHSw8QbpS/eyk0ZGym9F9g3pOyVQ5q1L61r5NG+NZk0d8xvJ7zV/kQeMXLe5x9r1fuGKrFCVL9gzLSghGa/MKsMHyzL7Abvk0eJqlN/Wzk0qCBiWcYRyEVdKdJnDB6Vdw0+hsUPIuFj8G8jTeWPDQsf9bPC9haX9aGv5EM5NTtQC4MSk56XfPvXRW3qmtHCBA9JgBiZQXzcPo5lZ7i9A7Y1YL3IKcALnHwdujP2rbocyZVP9YQ3u/MM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(8676002)(8936002)(5660300002)(186003)(2616005)(83380400001)(6506007)(26005)(86362001)(41300700001)(1076003)(6666004)(6486002)(52116002)(316002)(6512007)(66476007)(36756003)(2906002)(66946007)(66556008)(54906003)(478600001)(110136005)(4326008)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3dtOHBxS1MxVmdmdHMzUXRlaURBYURUNStHRGlucGpnRW1nWUI5ZnJxa0do?=
 =?utf-8?B?TEJQYTJyZktuYThjcGhRSjllb0VzZ1ZVV2Y5WWFQbUJZOUszdG9yeVpLaFJm?=
 =?utf-8?B?aVYzUVJaZUpmLzYrNjM4VHB5VEZFUWI1bWlnbEFKNGZ0R2FpdFk3QTBkdWp1?=
 =?utf-8?B?S1BucURSTjFSYkhYM2NETXVSOUtYWXZRbUdTQTlSeGtubVV3MU9FSWRWamxV?=
 =?utf-8?B?WStoQVNDK3g0d3k4R2tmM3Bidjd1aDArQzF1OWpxZDloVDFnSkI3OXc3dlNq?=
 =?utf-8?B?d3RxNDJxcnFEL3ZZSVdQdFN4MENiTm1MUXFCNlludjZPN3lmVG9TNktKQzZL?=
 =?utf-8?B?YlFDdVk0czNsbjltN0FsWXUzeWdvL2RPS1p2MUVwZ2tMNGY3S0FMM3FXZHlN?=
 =?utf-8?B?S2dEWWoxTjdZNmhkOXlhYzByZ29OTGJzdzZGMnlJSlNIRnhxK0ZrNG4vVzZq?=
 =?utf-8?B?alhZT1daNlRSdWlySFpUeVpweDY5RWh5MldqNEh5TnU2YzFTWkpxS2NkbGxz?=
 =?utf-8?B?emhwWUo0U3ltYS9pOW5saU91L095bzBvTmY5NkNEUDIwd0dOdGx4ZFh1R0FS?=
 =?utf-8?B?enF3bDB6MThkUDZJSWZobU9ramJCYWR1Q2QvdndMdmFiaWw5bFRxZGI4azVj?=
 =?utf-8?B?ZzRXbXp4a2FVS1krTzhDNFFURTFubW1SRS9jekdwa0F1L3grU0pjajM5dkdJ?=
 =?utf-8?B?VmFKQXFnRk9wS0xKajFHUWc3NTUyd2VEWlFWS04wUnpOZGpDMkoxYmF2TXl4?=
 =?utf-8?B?eTVCeVVuaG5EWEs1cURBWm0zbE80Qld3VmJIb0IyQ1VRbkJMcHZVMWRqYUdy?=
 =?utf-8?B?SnhPdUttWW9WcE45c0EzWk4yTzJGVFFlNVEyK2RGTUtnNFpYcUZWb0RqS3Qv?=
 =?utf-8?B?Nmg2cVVKS1B1aXEzaWxUTllqTHRVSmFROXFONTV0bDhtRXdqZTVTT1AvTnFS?=
 =?utf-8?B?L1pWbUEyakNmSEU1VEhKOWVqV05MMExPemorU1VrdmFpS1ZKdTJxOVNWU0tB?=
 =?utf-8?B?bkhRMk01SGU2RzcwWHNBc1ZtT1dqN1JDdnpLN0xXK1VRQWp6aHlnMFd1Wllt?=
 =?utf-8?B?SmVKaVFRN0FBQTBPTmN3cTRBMSthL2FBV2xGeU1jRzNwMm1QUm1SWWxTSHcw?=
 =?utf-8?B?SzNZcXRmTHprYjlYaVYzYUhaOSszNVNhSUR6K01uTm4vT0xSNk5WZmdtaC8v?=
 =?utf-8?B?Z1FkNHNYaUg2UXMxZjJFN0ZDbXVzbk0vOTVid0FHUXI3c3dWLzZtTGQzNHBk?=
 =?utf-8?B?QjlmM29tazJHK3V6OVp6Z1J1SU9CZ1BVVDM2V1dMaGJMd3YzTFA2QXdyUGoz?=
 =?utf-8?B?UktObVJjdCtzUTZPeXlEVTdoNlo3RnhxWkpTNzN0TWI0N3FyMVhlVUxzOG5U?=
 =?utf-8?B?TGltY1hZODVMeXJDSW9Wa3lKMnRhRW4xaXdDbGFIWjBEUFFXTkFsWnJVc25G?=
 =?utf-8?B?Q0txaC8vVVBNanV1WW5Cd2kycXMxaU1mbjNNQkg3SWxCeEFqMm9XL25yZmxv?=
 =?utf-8?B?VkJCRnROMEFZVHB3TGJaOTVqZVlpaFY3TGdlMGRYL0RyVHQ3K2JpQWxHN2pu?=
 =?utf-8?B?SDI1Yll2dHZvQi9tWlVOazU0d1dGVnEzNzBMb0YrL1ZKeCtvVDFNL09iTDcy?=
 =?utf-8?B?WUpIV1FHQTExMloxMkp0ZHptbWNiTllubEhZWTJZOWJ4Z3ljMEJneFU0dkhS?=
 =?utf-8?B?ckVhVERxd1pDK2RsbVNRMFFyVUJZMnl1MXN4dzFkeTBKNnFoeXBmUGJCMWti?=
 =?utf-8?B?UWVXVlZPWUNtWlJYUEJmVXZoRzVLNjN6bzY0RHlTaUxrNU45bzhBeVZpSlND?=
 =?utf-8?B?V244dmtoQmNXSU9obDJhWHNsc3o4dzB1Q0RaKytlR2FneE5kTmdlSHdqOXd3?=
 =?utf-8?B?QjFDUGtOZ3pqR0tyREpNalI0TjJRa3dBalNRdkpVeithczBqVlgveXlKN29P?=
 =?utf-8?B?NnpLZ1J3RXF5QmRlQzdTWElQd0VLVEZFK2x3cHlyVmJZdy92bUNtTUtudWJj?=
 =?utf-8?B?ek9vU25QVjBmTXNWUTVHYnhiVC83TnZzS2lCVzJxRUlGZUNid3dIWm9ETFF6?=
 =?utf-8?B?azhLUGZMTmgxNXcwcHRmQkZJVWdLd0NybUVkZ1RBc25ZeUdDUnRpc2VzNmo3?=
 =?utf-8?Q?4tHyo9noa1bTRFYfA6/aZGj0r?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0b128f-b9df-4228-7e7b-08db82b003df
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:14:29.5389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lq26VdSOYwJAvEAVYEkKk6nAvmL0S4NXogRzAZsVnBYcDB826147ACMpPaYelsLNIljjySmNRAhyFJVQ5ex6Rg==
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
 drivers/thermal/rcar_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index b8571f7090aa..b4c58c5f6f6d 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -371,7 +371,7 @@ static irqreturn_t rcar_thermal_irq(int irq, void *data)
 /*
  *		platform functions
  */
-static int rcar_thermal_remove(struct platform_device *pdev)
+static void rcar_thermal_remove(struct platform_device *pdev)
 {
 	struct rcar_thermal_common *common = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
@@ -388,8 +388,6 @@ static int rcar_thermal_remove(struct platform_device *pdev)
 
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
-
-	return 0;
 }
 
 static int rcar_thermal_probe(struct platform_device *pdev)
@@ -581,7 +579,7 @@ static struct platform_driver rcar_thermal_driver = {
 		.of_match_table = rcar_thermal_dt_ids,
 	},
 	.probe		= rcar_thermal_probe,
-	.remove		= rcar_thermal_remove,
+	.remove_new	= rcar_thermal_remove,
 };
 module_platform_driver(rcar_thermal_driver);
 
-- 
2.39.0

