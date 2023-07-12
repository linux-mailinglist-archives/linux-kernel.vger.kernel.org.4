Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8444750120
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjGLITB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjGLISA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:18:00 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2124.outbound.protection.outlook.com [40.107.117.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B882686;
        Wed, 12 Jul 2023 01:16:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DccWMCXJmfc84IJ6au4zZbfbXuCGSrc5jNKE4AXNPicf7S1yTdmn/YFLEgpaYUEcXrH9woCJhtDWFdR2JKeFwaKlz6fB/L6sQSurJKJYb7vuLjNi8Xg6spGA1AaG8q0952WtSrd6sApK8D1yfdqQEyd60dkMYytjNPkKgp2hXw25lyHhBJT0xqYIggQdJmu2/jr763I8bGdc7V6VTLo18LuyKTgbRp5lXgzOD5k9uz7CbJ11ehcFAf+Yd2vfIj/UdJ6p3j7p8l8/Xfrk1Iyr+fiZZdrW19Sfm9qrm7hmvu/516mBlegKFNas3FdQyTe57qZPRPx5EC8gI1XRqudNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYFoLrIYPPMmZGcgCqfwl0/W4Ed+UKsrtwUWwkise+M=;
 b=julGXPhaCI/pcRVj1un+vf/3EWqFpOGExNo+YKZPcRJplsgAjVpA70XITAUbxNj9oBSlmkyxRtFVuuVLqASncBwXEvdUqAF1i2GrE5Kc2cvJ0TJSGez1BKSoSOH/DkF6g6Jcg96AJ3ahd7JoTGkbRproNei/vcIV8oMZVY5Uir0eGL0jlTkAD915RfcvnTo+t8GaN2WFnBiLKTfuJAUwACnVgFNpqhDRgCyJGUBZtA85CxF0mgbVe55WWmk5OdikR+y6rlHtgtyVDz4T7lmlAPCUvbitp1Pd1mq7rCfFqoVCpcdlisR7Een7PrxBT3ZZQCl7PdTgf24y5eh5ohkSQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYFoLrIYPPMmZGcgCqfwl0/W4Ed+UKsrtwUWwkise+M=;
 b=XAjcqdHUK70IHI/k7gdInFwQCZWqB3ptQBKjfT3y2LkBh+zsBPK17Kfe2gmaBiHiUCFJOAtkpBfA8obFRC4q9CVQM4ZcE2P0nPDl8diddYuufbkJ+S570Ezhbc22+o0I1HyO9t3odZi1CzuEmg09T+4lyh9B035hJ+5+IMWyNJqukieJYUy8Py4KjUDJCYit9ze0XnnhMVjEbopgTpRxRNurOMzJ9OA7bowjnDCrkC0bL/9Vm78qDCdC1K66S+p55sgBX17CXw2l8SnR4GbVkdzyOCEY1CmSqYiYQw2emmcI/ybDyCmWNSkVDw1RmbKR7YZ4Q10/ba6J2jNGJayasA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5382.apcprd06.prod.outlook.com (2603:1096:4:1d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 08:14:14 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:14:14 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/27] thermal/drivers/k3_j72xx_bandgap: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 16:12:44 +0800
Message-Id: <20230712081258.29254-13-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3fcf2f94-e2bf-4974-3407-08db82affac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aCD9pwk0nArSQfhrAgVDt37mcjrDdHz4SZ/uHw+17A1PkmMwP30+L8RTH5AnDt94vbBAdsb4tV5wZFhnO2SOkvwwHITEEM+xPsep+1CVUP/VFcTyLGvhHKtlGamUI9bPCiISw8rVbvrHotEqTfQM2vsje3ntZvdx5aT9p/XMwh/ZgXkY8TGAuUXJAK+tKVwlZ/ay2RC/ap5DQ2TOErt0Spk8q4qmp5hLzcAIwSo3aZfgrDIbojf5OyRFJ56EN4b+2QTZvofen0n5mxzUF0VYeIeUuZxPj7ElGDq6INCw00AT1YqbScKm+QOUjacSyCM3gRCXdQbT7n9dy3IPL3td0dYxMIpDV/48iK3BJ6nwcfIYFxQpW4hJXl8XqytsggLMa8zBYgaPn96J3C816uJ4dqV/PEoaq1n+S/XSlBa+x383bEOmM+Pur6rwdfcVkxqWlepZabfYD4e8uhIERY0hapLiYyQcK5HDepdb3Q9oos5ZXFgiaikSTuQQVje9Vpq4soidf55s8526FpHg4+goasnZpADQkq1rlmLBDV7D8Yl4PJsQExuDDS08XSUl3G+v9GSonkM2QA2vkxKRa34QmQIK4APUFglT7I0YFQf+U+lqPf3ChjZdrXAMXDeQdZJZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(6666004)(52116002)(6486002)(478600001)(54906003)(110136005)(6506007)(1076003)(26005)(186003)(6512007)(2906002)(66946007)(41300700001)(66476007)(316002)(8936002)(66556008)(4326008)(5660300002)(38100700002)(38350700002)(8676002)(86362001)(36756003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RllzMitTYWR3a0hBTVhTMkYyR2xxVGZ3bUEyOHNqc3lNYUxzRGFHNXhOS0JR?=
 =?utf-8?B?Um9sNUh1MUJjUzc2YjRpQmVpZmFGZ2ZBdVdYaW14VnpFMW1nU05zRENrMTgz?=
 =?utf-8?B?TWxzbDNtTTZxbzZLK0lHUHE5L2JTY2QxcHZndXROYUNIN2M4QzAyYldmNDJM?=
 =?utf-8?B?UXdzSS9OaFJwK3BaczlIYVI3bzRQaElXcnBMU0JVeUl0YzgzYlRLeXZSUzBp?=
 =?utf-8?B?eDBsRVpTVG1Ibmx3bFN1Ny9LNkxyalN4Q2YyZS9DcUtkVGppdWkrZTgyQm1Q?=
 =?utf-8?B?THJCcGdBSUdsdDFDdlFUT21XdjFIbjRPVGZjV1R5OTczeUl3eDlBSmE1MXJX?=
 =?utf-8?B?M1VIRUJtUHBpNm1vU2dnQmxUdnFHMENjY0xrTkpSNTA1WFNEYTJDWWFST1FY?=
 =?utf-8?B?cXVqb1FzakJEVEJ3akVLbFhlRjFhbVNKcnZjbDd5aFhFSS9YTlRiQUVIQldR?=
 =?utf-8?B?akkxeGxLU2w4Wkd0SzdpRklDSVozKzJZWUdyMW5zcENmK05mVkkxVWJlVUg3?=
 =?utf-8?B?d0FXVTlORUErVVZVSWdnS0xPZkliVW9XdFhtK0NHOEgraU5tcnl4MzBmN3dj?=
 =?utf-8?B?a2JjbklDTDJlS1gzVTFKVVdsTk5PUDdib3ZGYjhkV24rM1JyTm1FOG5QQkZC?=
 =?utf-8?B?WUs4dm5VeHE0blRkcVgzTStHbFJyajRWcnQzMCtZTGpjRU8xU0Jnd1RwSnpj?=
 =?utf-8?B?WTdKUE8yajdoLytPMjZuNlRGQVR1N0JJd1hjZ1ZTWEVYVm1oSnFxbFVaRzdi?=
 =?utf-8?B?TjRLTXZrK09wRTFZYVV5aFB6Y0pnNVRCdVNWa1RzVmw4cHRkT1grdHBjZFh3?=
 =?utf-8?B?VHRQNk1QMGZ0Sk52MHczWkphVW5DY3cxY3Z3U1lOU1Q4SlF2c3YzNHpBMkNr?=
 =?utf-8?B?UkRhTG4vbTI5Wlc4VHBtMTJmT1RJajcvamd4NFNwTW1Gc29pS0I1bTlseU9N?=
 =?utf-8?B?QmtXZEZNTU5rY3hUZ2FrMXRLckZzVWRsT0ZDNVJ1ODNIZEdJUllsckpxeml0?=
 =?utf-8?B?Z1g0aS91T2ZWeGdTYXN0andrREQ3bElTYmExcjR1cXlNcU5XUTgvaElLYWVH?=
 =?utf-8?B?Y3JiRVBHYmZLTW0rV2NhUVFCY0M3WUlPK1pHZXpHNitYUzBwVG03VFNMVzZL?=
 =?utf-8?B?OUd6c1dzaGJsQnZSS3dXc09lZXBqbG5TNmhHZ0gybHZoSGtGL0R2N0F2YzRv?=
 =?utf-8?B?aVZIa29uN0QydXd2Y09LRnZGUHVJY1krWTVOOWtFL1FkdjJpeTJJSEZvSDBL?=
 =?utf-8?B?TzdXSHlGd3lGeGp0dm5FRURLS01abGNPbyt3RlZvVjI4aDUyd0tjSGFMUG9N?=
 =?utf-8?B?SlNtVFNQb3hxZWxmU2k1bEU0d0xIeXErMjZILzdVQ2J2MmVSYzd4ekg1MXps?=
 =?utf-8?B?bmsvS00wMUFVMFlLU0tyMTJVRTNPS1I4Yno3My8zSlMvblpOdk4rbjQ5UE0v?=
 =?utf-8?B?c0ZwOThFeTJqVHpzNVVsWDRlZE1MYm02T1hFSFlMV1hKNC9GZ29HM3FraWlh?=
 =?utf-8?B?M0d4ZkZ3VHF4UzgzcTVNakFLSGVldTQ0QTNNWWg3aDIra2xxWE9rRHh6YlZu?=
 =?utf-8?B?azlOTWVkU1dBVloxR2tPdGl3V1R6ZGJPUkhGejc3bklaQUtnUno3bUN1a3hG?=
 =?utf-8?B?b2Nmc1ljV0lzNFJmamxrcXFMS1BkQkUwanFSTW1maXBUMlhobjdaTEdUYVVm?=
 =?utf-8?B?NkFSR1d6UFVoclJlNHord2tvWVZRcWQ3VlRjMmxxaHlOWXNJOEZNazZ3a0JW?=
 =?utf-8?B?Y0t2QXpiVXNGV0xlNnozSlVDc1hJUGNUR3MyTFVHb3lFY1J3MjZIQ1Vrc0hz?=
 =?utf-8?B?aGM2WnY1U1d1Q05na25hdnBOdVBCZmFERDI3UXo2OFVSL3NWUmdkcEI1eGtV?=
 =?utf-8?B?Nmw3QkcwaFExTjFPdHZZQzJQZWxtalhzUlR0ZENWT2ZDMVJxSnBwMFNCUXpv?=
 =?utf-8?B?VWZyUUpwNm5iVDlkWGZycEtCclNTQm40Qk83UUM5bXkvNEpzNzlja20wdEJv?=
 =?utf-8?B?TGMvdUxGTmM3YW1ReEE0eGFMMFdoeHI4OVZJTEhLY0IyWEQyWGE3N3hmREhH?=
 =?utf-8?B?dVFCaDhMSnBCaThpTWJVS3RjN1FxS2VKeXlxalNOS0tteFNFUUJYMGJ3RjJY?=
 =?utf-8?Q?V1qRrmr1PsXSLSpKCMrnEazCp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fcf2f94-e2bf-4974-3407-08db82affac4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:14:14.2232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxJweYBw8dTXYvkZRrNZqnxSg37il/9/xa+fU412smeSSd5t4oG88YTOj5qTOL1ntZ8PjJncNd/gHkxdWlMLfg==
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
 drivers/thermal/k3_j72xx_bandgap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index 5be1f09eeb2c..62e24d08f408 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -523,12 +523,10 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int k3_j72xx_bandgap_remove(struct platform_device *pdev)
+static void k3_j72xx_bandgap_remove(struct platform_device *pdev)
 {
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 static const struct k3_j72xx_bandgap_data k3_j72xx_bandgap_j721e_data = {
@@ -554,7 +552,7 @@ MODULE_DEVICE_TABLE(of, of_k3_j72xx_bandgap_match);
 
 static struct platform_driver k3_j72xx_bandgap_sensor_driver = {
 	.probe = k3_j72xx_bandgap_probe,
-	.remove = k3_j72xx_bandgap_remove,
+	.remove_new = k3_j72xx_bandgap_remove,
 	.driver = {
 		.name = "k3-j72xx-soc-thermal",
 		.of_match_table	= of_k3_j72xx_bandgap_match,
-- 
2.39.0

