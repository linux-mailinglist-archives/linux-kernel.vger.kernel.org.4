Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359D575033D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjGLJeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjGLJd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:33:56 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA921703;
        Wed, 12 Jul 2023 02:33:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+mePwis9j43fdouDQcS5oQ1CfzMPOOTMvw9fDJfJKVvHLKgtqBuLgsqTAOscyLxb1PdC4izfOMkcTawLMBx9PEgSBeAvqeLWHla6rWWx4rHKevAcUZ0ViY9HyJFCiVe0dTneLKHkD/sgPMXBoyUCoOghRID1Ssg60CCXG7a3KbXDoILXOB8XEqgXsQd6lGBN87MjyfT9aQTJ0wartgO4rMyzclwMaoz0gb7xz0ABG+g5E2V25o9WFYi60tUiCd5qIo3kD/Ze2X4kZYPJDo6W/gRkFrhXQasNWWCnjkOrvCMYCx2wwewtPMqfv/+F0bEH5uilHkse9q1D9RKtf+4KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbZ+0WrsTdQ0/jo/QyZW+/XbcPYMp7LBIjLgnvIrU9o=;
 b=RKAW6iJrXhE5Tudrh3x7oxC7313haan4Ickudmx3CXN/lwvjQNIEKpUph/U4lM070/efRIQJX1po4N6Reb9tzBX9C0Nisjeym3edoPSKpNq9/9TLGOv+COTGuMOnNK9fy3Q6DAaa7XLo4L1WGAUTuzdqxYou+VQngTN6bYvg1QrwoAozKPrdKxHBJ2QCOtTqoidrCO6mImLqdzpcO0T8RfT25IP3SQSKnNzS2InAiDu3/BSOz4n2bGrLrtGRbMdKHrEzdofcJYeiOR3PAr+T62o3iJLLizS7riVcJIHNpYCgAtqP7T5gXwNpCEHZ06TzhYTs3aRgBgr4tXR92jJWKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbZ+0WrsTdQ0/jo/QyZW+/XbcPYMp7LBIjLgnvIrU9o=;
 b=djMwyIy6OYc/HaN5jyExDA1bjvet2OtpcLEYsoQU1FEnNCHxpD3h8KZM50ZiRTW5bjzg/SWr1aPWCqyj7zZADioSrE5aZZhDiISjrVYSVrEuDNtnkBv3eWtbdwVDVjjBdUyPxmDf/MLy/WJ9QIsFZu4k5efWK2GyMIsXD7VhdKGfc4rkmxjkXtWmSDgRn7/I71dxsw2WgFSPaSmO+V61DYKgMUcBY3Eek63gZwXTuiklBbdcvMO75SWlHClfULuxzuqI9YBG3QSyDw/Q396HUnVYb7r5zrU7QXN+oJmlnBqw0rX7HRcTJ2S8lA5grTGQG7/mDJadH6qfXDKPMLYxoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5985.apcprd06.prod.outlook.com (2603:1096:101:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 09:33:47 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:33:47 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/19] cpufreq: tegra194: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 17:33:11 +0800
Message-Id: <20230712093322.37322-8-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230712093322.37322-1-frank.li@vivo.com>
References: <20230712093322.37322-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0172.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::28) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b559e9-10ed-434b-5f21-08db82bb17e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CkQqh6LoKDpp3qDLTEBXSwZOI4X042Jd+nOFuuZ6h5dgHAePWFkldjwjeMjtIYLdHij17z5yYsIdqfDTSfH4MyeySMFwwAL2XZK8eegSTFL0VekXBgtWmx7bYWQ4m7kwb/La9ATVPsNTBmDHOhPZdLsK76Evg/nMommV8hS7ycAUyDUFqq47GNLFpjv9vngsaJt6M4Zt4rEpRhFo5Jp3w1U6jKSbL1p+YZgkleI6xsdZjufyImO4g0+GYeDU88TaTkQxCTud9Q/JSiSiow4/K3OL7MGTzbpE7hUECVRcu48IPteZB7tSgkUDB1bfsQ7QWB/N8fUPJTrf0hznGGs6nzTR7kwez+/pPdhrVgJW3i2pk7+4sDLlrlxyzyqLG0IhZN2+W1zBaTiBfjLwaioNIm2l54jjCdrV1oT2/jJoSqXmwlWb2fkS8C4dtuNJogmE62SiCRDsFo8ZNgCcvWUyJ+ZmWg/lniFjZbVyzrcprNYvPYlOwK9+EZPeafpQ1sAaDKX2KNzk4JNA2NoueEOEfGLg2TTRoPzZ4qPPCKFR/c1/ghyCQ6hREREP8TYrCrTUJbCMoM47LIBBhmJuLOux3Odrg6eXr6el2syynvKkvruuJs262Znd8elznfl9Y1l9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(186003)(2616005)(110136005)(54906003)(38350700002)(38100700002)(5660300002)(8936002)(52116002)(6666004)(6486002)(86362001)(8676002)(478600001)(316002)(41300700001)(2906002)(4326008)(66476007)(66556008)(66946007)(6506007)(83380400001)(26005)(1076003)(6512007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm9LR0U5L3h5YWdYZ1VnOWExWitnek9kdVQwOGN2dThpS2hkaU1ncjZZaXB4?=
 =?utf-8?B?L25JTmQyNytqOElNV25RbktMYm53TGFwSWhic2ExZzY4SzZBeFZLaU9FcUVj?=
 =?utf-8?B?aFBsaVdnNS9hNUZIM3hDTzRNUHVHWlJ6WW9HRGY1MWZxQ1prUjM2ZUhaZDA0?=
 =?utf-8?B?WTlHSHozQmF6TW9OR2pIb1lyOUY0TXc3c2tkWlpWNTlIcGduUUNkUTM4ajFC?=
 =?utf-8?B?c3F3eHY1S2RXR0lRd3JCa2E4R0htSU4vbDVEMVVYSFVVOWp6eDdIbEhKSGpF?=
 =?utf-8?B?M3JvNWhja1JKdk9Od01VcEpmVmdnbDFMbmQ4a0xGdmM0UDIzWmZyd3NlcFhY?=
 =?utf-8?B?WFNRQnljUHl6WjBxUVdoaGxGRDVLSS9NMWVnWjNMb2xlL3doMUIxUjZpLzhG?=
 =?utf-8?B?TzkxZU8wUldlemVRZ2VBZ0xZd3VMeWVTTkpYeFpKNGhCajF1NXFFR2dvVGx2?=
 =?utf-8?B?RTY0R21Ra2FqUGcyeXIzeUgyUkNsejdvK0xnaWc2ejR3cnh1OElSRVlOVTI2?=
 =?utf-8?B?cDY1WnJraGI4QzNWT1d0RGVzdnF0RUFiWGpGRmxiVmhDNzhrbzdJajl6MkFi?=
 =?utf-8?B?WTR4aEs4Q0crbkZCdUF0V0FYVW5uUVUxNFh0aHlPSllmVEEwMWIraXlJbFRH?=
 =?utf-8?B?a0xDQ3BkRG9HcVQxUUk4SmJ6ZHZWUGxzaVUvOHB3bEVqL3pnNTFITnR2dy9U?=
 =?utf-8?B?eEJTUFlPVk0yaDI1UllsWnkyWk05N2diS1FYWlE2SHQ2REFvREg0d3NCaVph?=
 =?utf-8?B?Y043MERVbXA1dDBuOW8rcENPVjNDTHJyeDlSUlgyUjFkcjFhQXA5OU9nOW1w?=
 =?utf-8?B?SDUwaSthdkRseGtSL3pSd2hRMlE4Q1NWSEVFZy9nN1UzU0E2TzcwUVRvNWVL?=
 =?utf-8?B?cVA2dVI1WlVjVjJYNEVGVUZsb2xMbDdOZythUzJMUGtTUGdITk1QL2RLaS9S?=
 =?utf-8?B?Z0ZxMk1lMFJtMnFGcmtML2wvRFRPVU1zc1pyMExTclNNVmFoTU03cXkxZzMr?=
 =?utf-8?B?d3hHSGlpWTM0L0FHWitYWG10WGVjODlOeDZQeTA3RDNySm9Ed2hVSFNKbGdz?=
 =?utf-8?B?c0t4OFdMVHM0VXp1K2puKzVwbWpmWGFMRklVQ1NVV1ZFbVpGQ0k0cEJaWXNR?=
 =?utf-8?B?anNVYUxSa0lCZTNUOFNSM3ZUM2Z6YkZ0MFBpUGJ1alNrVXdaMHlCMFpQZ240?=
 =?utf-8?B?dDdiWGYxUkkwLzYzRkJKMEFkUmpGOGFtamlHMURRRjhKZE9paHg5ZjkzQndX?=
 =?utf-8?B?STUycHFHUmhvZ0lLaW1zTlV5Nkp6ZUorSzdUMXRMbzgrdUNhdTJLSnptS0Yx?=
 =?utf-8?B?QWdCU1ViQ1pNdzlKdmdsRzlaTjArTjB3M3VDUERKZVlkanVRMzBPYytVVHFj?=
 =?utf-8?B?dzEwUm91SFpRdE5VZjJmWFNxanJnS3UwdW1hOFYrQVlTMVcyc0VrMzhlbU51?=
 =?utf-8?B?WEZRNTd1czNlV0RRR1ZpaEEzYVVDVFpreXh1L1dyVTd1ejZYandrdlV1NnJV?=
 =?utf-8?B?aGQzNVMzWlYyNVY5bVhIcWFEM2RSaldvNHM0UFRYU0lhbGlVdmwyanlXUFI4?=
 =?utf-8?B?dUw1VHRNU0JBU0Fuekp3U0MyRDZQMW84NWdBbnV5ZVpMYUo3TkF0QTBxTjBO?=
 =?utf-8?B?ekJYNUdzVXg0MDZQOGRQbTZZUHloRGk3OXdIOG9Va2RSRERVblFqa0psZ2RR?=
 =?utf-8?B?d3JnKzQ5SXc1SVFmSFFHbGRyOTM3TEZISFRoZUVFMFJZT1JwZUQvOXY3MWw2?=
 =?utf-8?B?V2o1RDdqYlF4dVd3K3ZMZGRIWnJHK1dzYzZUdlNpaCtIcXZBZmsvQU9NcGdp?=
 =?utf-8?B?V2k0cVNJTkRpek5hN2pEM05PNzV3eVFYYjJaUHBWZ21qMnYxRVI5RXFxdFRs?=
 =?utf-8?B?N2UzRUlaTVUySUpDK0xCUlR4TlB6VWpiVUNhZ0RyNkpFdUFtRzFQd3ZKaERo?=
 =?utf-8?B?cDJ0MW1ZMndla1g1bTBLWEtrMTZXNjFvY28rQWtTcU43YWp5TVhPdHJTTC9o?=
 =?utf-8?B?L05KRE9rNzFkcXd3TjMvMlp2NGhTeGUybElHRHFwNGkxVVJERXNVRlhVdTZ0?=
 =?utf-8?B?dnZHbnRnSmtrRkFzbE5SbzhlSHBIRU9IcU5JZ3djcjFuVyt5UWJTc2REdWNH?=
 =?utf-8?Q?DxH0viWdwKVD2M2/kx6FHYLiU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b559e9-10ed-434b-5f21-08db82bb17e7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:33:47.6014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ArlfFhyMdCwxxl5Y/PDbthFt1UgKB+5dnAkmnTPcQl2XoVlw0el94vxjOMjP3t9Lp31u2iqEurbW6fRbroGfuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5985
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
 drivers/cpufreq/tegra194-cpufreq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 36dad5ea5947..c90b30469165 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -708,12 +708,10 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int tegra194_cpufreq_remove(struct platform_device *pdev)
+static void tegra194_cpufreq_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&tegra194_cpufreq_driver);
 	tegra194_cpufreq_free_resources();
-
-	return 0;
 }
 
 static const struct of_device_id tegra194_cpufreq_of_match[] = {
@@ -730,7 +728,7 @@ static struct platform_driver tegra194_ccplex_driver = {
 		.of_match_table = tegra194_cpufreq_of_match,
 	},
 	.probe = tegra194_cpufreq_probe,
-	.remove = tegra194_cpufreq_remove,
+	.remove_new = tegra194_cpufreq_remove,
 };
 module_platform_driver(tegra194_ccplex_driver);
 
-- 
2.39.0

