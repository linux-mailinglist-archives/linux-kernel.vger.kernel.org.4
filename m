Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925717500F9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjGLIOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjGLION (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:14:13 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2116.outbound.protection.outlook.com [40.107.215.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670C71993;
        Wed, 12 Jul 2023 01:14:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVkaOOgScelebmBKJ24zU5QB1aUTT4K6Uz2Ssk+DDFy8f+GTQjaEf+1s/Ed7mZ2hVxyVa6uBbM3xOS2WNoBQC+aU+mdWFlOtLYB5dPxmdbBhboYEgQ1JRXNcjN7XGuNaM+wQ8Lphb89lhZGaQiFXiFrWCw5qrtsgh1+ubSKW+Ssaxj6EnPcU+A2TRj3ud1qMG363IvzeI/eF0/6zHnopzQ9viz+I7/NScXnXPbAQ0Az1DkhMiwWvfNKw+ZuMR+nJpWZHY9g+mHmjcsxFkkNC8sKt4JkBZ3uPkC7VDu2ZCbwa+c1dARgWndqInjQ/OV7Rsb9ui+o4iVLFQT8aQSE2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KfnkcOCRCsGJGl26MPgx9BL6OZU2oHmhp4i4s8PNKM=;
 b=TXbXnnq9G+AOOGJcjvXllktYIk1ThPHgGrm2Vb7uIDlq+h2m3YGr9F3hSOG8lmB3/zmsdSy516tgPjDutvHs+W9H+DV2SmdvIauTQLdjkOrMA2tzvnt20FQXcs1Ie8qqgFsLr02MklsYKSr4DYZEJDZT+w/zEiz5f5wNnRghGzehoTS6WrZfE7Q4BNTdcGG5Q0IN37VRfE/ZKiXK/M4dxzvi8CdYKkhSx+Yfpb8xPILFAgAQNCk8XUyp7tTe5uS4MjqwXAgloZUMcuXuXDg7rvB6v5T9DogRLxYpf96H0gZTrOdqXzHYI3tlC5wKMdpNndxAfjVyrT5nnM61FTfdiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KfnkcOCRCsGJGl26MPgx9BL6OZU2oHmhp4i4s8PNKM=;
 b=Yie0RE81MhyJqYgY2Ln5yc9GQXTFLFQxD1Rdw/Fw5J5AahdM81DIuClx99Fs54tnvb9E4o8lJRVQYb+AfKUZhlH44OYEA4E7aRies7npOpj7ipe5SSMl0XG7wW1o/wt2WiAqZepehlVomasGd2IujrCeZJLmILYCdFLfcPs3rVt8D8+4Sfsb1M1/BCcms278i+y5yzq7Fqc6M5FtD8Q2nt0vqtJ66naQDEku1LK2lp1sKCitBzgjdgK7/O+AYpxq4do6/KZk9wGLOPNBzAvK2Qm5vIkAXXbyUQXNoLIyUrhBiWa6W6LAoAbQYETXJK2bg18sonNFhaseTG0Ya676jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5382.apcprd06.prod.outlook.com (2603:1096:4:1d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 08:14:05 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:14:05 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/27] thermal/drivers/hisi: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 16:12:39 +0800
Message-Id: <20230712081258.29254-8-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: f9a32f76-4801-4091-82fc-08db82aff537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xh55cCW8QLGVKZytFoZEHULq4H0LM5zk+nOo0cQDE6ODGujwi+UC8aJA3n2TkXqhZU10FtVPrVA+9ouWx9wamDT/LqxdHNMEyJoFqNfdYz0abWXn7vQ1BR3cVymqErOGiXS7PW2MdC9X3bu9V68Hr9KdhVwCURotKIG4dehPtQdnD5HRgSafnxx46CAu75EU7y04dAxwTNM/AfLkUJ54zccEt6BTqLMU4/zzZvzpyPV/qOeGab4bDplCjVdQZUG0rWS5CI2//z6fYNoPnRc0qjTBVcWsp+X9T8SXWgfG0/ZuY2Fdmgg8TacctBiWjvZnf+m/rfx9AfsFN4FqdGiktOYw6yo8QJu8TjHUM2Jq3QpqMwsTv33jSf45xqTaV099W2cXYDKhpBGNXxrMs4D7gtkm/hONnrOK4PPr19N8Hy8lOkJXAMr5vf5hHCaD62YyHeAxxJeqACwZDcRn9ToR/+TKk5GYi5saOHUEfS/qUdTREef3VkHyqYeg5Aql/M9BG/BTGE6Ur/yDRI1wo2zFtQueDhBapB5wynhDpNVuZ26zo4Q7QgOIv1MWADvFdgDW74SUmApIHFiUyMkw0tqe+JoN3g0W7S65ieSNp3euRrNWrM0M2DwDDcKLcfMb9tnz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(6666004)(52116002)(6486002)(478600001)(54906003)(110136005)(6506007)(1076003)(26005)(186003)(6512007)(2906002)(66946007)(41300700001)(66476007)(316002)(8936002)(66556008)(4326008)(5660300002)(38100700002)(38350700002)(8676002)(86362001)(36756003)(2616005)(83380400001)(66574015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmxjZ2ZCVEwrcXBnUDdPR3RNdXhiT0hiWXgzbGdrODVSYW0vdjE2MkR3RjM0?=
 =?utf-8?B?QVJOZFVyelZmanJZcFVYb1NBM1FmdEV5Y2NSbHBYc1JXMXliQmFWR1JWckFX?=
 =?utf-8?B?d05ERnBUSEU5eTRHK3F2M3pLK3VkVENyejdXblhOVHRVQ01haDU5Y2pHdFVs?=
 =?utf-8?B?Z0NkdnM0eFVRcUpaMWk2M3J5VGwvaEQ4N0hrckVaYnpvWE5QK0FJZE5WS0Zl?=
 =?utf-8?B?T2xUUnIxYmViODhjQ3RkVFhJUkZnZkFpTGlwa2p6Y00vbGxaWENta09xR2Fp?=
 =?utf-8?B?WjZzUXFpQlFBQm9RalJSaXdlb3VQWFY1Nk5YZVl3OVZRZlVmNjBoa2FteVhr?=
 =?utf-8?B?TjRpWEdRSmlRREoxalNGNHpUNUFoL1dBaThYTG5IZmpINE5UQUVlNlpuR3hj?=
 =?utf-8?B?ZmkzdUp3U1ZwSDk3QW5uRC82ME9OOTUrcjc1SmFQU01OODAzakdTZ3JKb2RO?=
 =?utf-8?B?S2txS2ZBeVBMY3lVNjhJcmp1SnM4NDJSYlVVRm5NWkpqSU1zRG9PS1MvNS9r?=
 =?utf-8?B?Z3pzVkNDSG5HdmhlTEFUejY3SS9zbmZNQkVva01mUmN2ZWhWenpqZGFHTE9r?=
 =?utf-8?B?M1g5NmRHRjlnbWovdGM4dnBsQXowWWI5blRPMnJRQkZ2QVRaZUlsVUZJZzF1?=
 =?utf-8?B?NnB3ZjJoYmpkdkpOU0FvWUZTdE9ucVhVWExDWHExcWdZRWRLVFYxUXBBUHds?=
 =?utf-8?B?Tm5JdHBWZERNK1J0WUdnN2N5SnVqSERRcHIrWDJsRndrRVFHU3RDZE51bE80?=
 =?utf-8?B?Y085QjhNdFk4UHQ1MGVKdWVQWmh4by9tS083RTM4Ykh0UFI1STNnazVBNWpF?=
 =?utf-8?B?TUtVODlrUnlhSFFLTk1yelVDbXd5M1o4dVZpcno4SGFTZjhWcXlBQkxGc0NH?=
 =?utf-8?B?K2N0TSs5dE1yTSt5N2lieTBraXFHbTJad1NRazNaMS9BRnFhMERYUzcxTXlO?=
 =?utf-8?B?emVEZUZYZWQ0SXM2QlVIN0MvWHRFbnoxcEp1RWJLZW0wZUJHZE1FVzVPRXlE?=
 =?utf-8?B?Zy9xMmVKdjFlWmwzZUxjTWlvQ1JMaXVSbzlqc3NUeXN4aUREOGNCZUNlR2ZI?=
 =?utf-8?B?YmxwVnF0UGRqRGxZRVgvaXFwOXNadDYxb0NPWGRjZjZCQmRERlhjRmxhR1Rr?=
 =?utf-8?B?RUZxa3lnL2ViYmRhYkdUWkI5ek0vMWYxbUc5TkNBOUYyWGFrK0luYWp2ckRz?=
 =?utf-8?B?Z0hVV0FwVk9yZWVlSHprMDlqaVZWZnlzMkhwM3ZTRGxyK2kzMDZsdmc0WU0r?=
 =?utf-8?B?aldua1l5WUZoV0lZbWhEN0p0ZmpreE8zdllFdzY1RHFQMGZySGpnbmdjem1n?=
 =?utf-8?B?R0ozRkxvWmRxcHBERVkxOFhPM3pMZ1gySlpUUjR6bnZhUXgrOXE1VGJPeGtI?=
 =?utf-8?B?ZG1yUkg4eXZsakF4RUM2TGRjK2hhM1VjaGF2aUMxRjN1emRXNjhMbHdjNkRG?=
 =?utf-8?B?eVAzN3hLdzVEbGRMd2djK0d2dG83QU5LbDkwTzZXQ1Bpc1MwTG4zcHplbUJq?=
 =?utf-8?B?NmkzYUkxelBHNTltazZtSnBRK2s4T1E5RklRM09pRUFxTHRaRmRUV1pqLzRR?=
 =?utf-8?B?TDl3OHRwTGdFTmFMbW1lalVoYi9CL3JIRm1KQXZhQWtidk9KUWp2WVo4YlJr?=
 =?utf-8?B?ZWt2N2dkcjQ1dGxRRlZWNktmZGxXY0JDdEV3NmoxejR6WGR1am9GN0FpR1VE?=
 =?utf-8?B?NVp2S1A2cDJaUGJyR3MwU1VQR3FiTHV3NWU1SzJrY3VzY0EwTVpmakljVlgw?=
 =?utf-8?B?ZXNjbWJNUTJpWHRncmlZVlZmaDZoUTdFU25wR2Z1Qjdzc1NMRmRjbytSQlNp?=
 =?utf-8?B?Y3EzZUwwRDY0emlmaFZvdHhlU0xXOHVBaCswRUR1TGsyTGQxbkFYQ0NjSXNH?=
 =?utf-8?B?N0RnaEkvZmloOTFkZDZ1WUlERGh2UU5HZ3hidit6ajBkZEdDYVJaNm9FenRs?=
 =?utf-8?B?Z1NPZWxWcVhLekdNbE9yYmNFUzgvcDNzYm9NSUVJUUtYV21uN2tIWXg4eFJJ?=
 =?utf-8?B?MGJudm5ZVklFWFNhbmRnRXdhamErZyt6MjVBQzhYdHNNd2dpOFVoVFNuUXJr?=
 =?utf-8?B?amExTnZ6anB4cVQzL0lJVCtEOEJLbFZ3VzJQVEVaZjdSWTRvM20xOUdOSTM5?=
 =?utf-8?Q?2IIjTquDbhbODajkEUwkEx5qh?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a32f76-4801-4091-82fc-08db82aff537
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:14:04.9287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nw6wyzXBpR1CHmPkHVAPQYRjsSpBDDfNtLh0Zg67Kq0UzlTdtw70xZ5vhSHQJSA1ccr5zkJpPLzZUUAj/kT/qw==
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
 drivers/thermal/hisi_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 3f09ef8be41a..855ccd6b8b13 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -597,7 +597,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int hisi_thermal_remove(struct platform_device *pdev)
+static void hisi_thermal_remove(struct platform_device *pdev)
 {
 	struct hisi_thermal_data *data = platform_get_drvdata(pdev);
 	int i;
@@ -608,8 +608,6 @@ static int hisi_thermal_remove(struct platform_device *pdev)
 		hisi_thermal_toggle_sensor(sensor, false);
 		data->ops->disable_sensor(sensor);
 	}
-
-	return 0;
 }
 
 static int hisi_thermal_suspend(struct device *dev)
@@ -644,7 +642,7 @@ static struct platform_driver hisi_thermal_driver = {
 		.of_match_table = of_hisi_thermal_match,
 	},
 	.probe	= hisi_thermal_probe,
-	.remove	= hisi_thermal_remove,
+	.remove_new = hisi_thermal_remove,
 };
 
 module_platform_driver(hisi_thermal_driver);
-- 
2.39.0

