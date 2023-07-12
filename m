Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7777500EF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjGLIOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjGLINz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:13:55 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2107.outbound.protection.outlook.com [40.107.117.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13634170E;
        Wed, 12 Jul 2023 01:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPw1TKEzUEIxWrrJCPNPNj0erWwVZr5D+06B/2qqAHlNi2CMVlpxoRu0myGOIY5ZXP/VAqDLRSLOUvHvcwz8BIGGtsHXN96A6HFwEIUcQlVcddpMAQh1npyPifQNCXqk/qAFvDbIMxtFdE/qoIw56ietIQYn00g96voWpMzNdbPRO5iaywwRMSTJf6rRCmxxDacVSek7UolrGuW6aVyJXnGSE0l02srz3rZb/5umEnxiFyKetam3rKDKLx84W/fcJErupeddLTEf+PBbJjFhp+olYVxrHeBCcqajFo4EWtSHS8IRLqg71V/1Uw0BmR1ovchOWwDnhhCFBcvPykpojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzLCRfXSM5Q+XLM+3F453WQFQF3sJhFjkD9vWMheGAA=;
 b=UdfG/38vjN1QKCm9zSwndLKrYZVtgXQr1L2vQNhftbgSztmr5k+uakmvt6sh4EcDYsWzX0b6ZePiLCE+CDIqJuf/rKXiRYLCpx2P9vMzNziyUgxdRfSrqHpmFgsUrUJXgQR0yhQX9gsOXOhMtsKZLl9JOIrzLNvi4kpvlsPrwVW/dVlD17FxFzvzx+nCZlU6Ysx2l65bhjgRlWuIqQjdIVCLcSWWS24Z0YfwqFK519ULyxU8D9fKtejPfMmkuC2bKo9TSmfcpfqXDW+2YTPo0XwxADecnpqgnouHVzwUKcdBTzOsPQPLz/Ejf9Ol3VvNAEtKv7EocTC8BaafJD9f7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzLCRfXSM5Q+XLM+3F453WQFQF3sJhFjkD9vWMheGAA=;
 b=RY7fHY4VixdQtiizYxO9h80utu9wtORyM/zjWzrZZbG+1xeC1s2eNofDxn0vnBLvT6f/OK6SlrKrtg72rTgGd5UtouW4GXWlRhfiO57icJukQQojDCjosELxPFWbGuFvSwcyQBiNsByUKfBaF3c4QgVQwPvykyThOE4VdMtNNCYf8DKhzTUJt2YC9wBfolEYr/6fo/16hfyhq8opKS7XUXTC5ngyne07TC0Gj1oRIfcZyBYcgXr+CJM/9NKBu+EAKyC7o4F/6gfA0sVXgsVxV/2WK64pe9SRI4/CY6SdTGIgkO2zX8iG9QEl8iSmwAjrDMeUF0f2Er9FPb3rKEjthA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5382.apcprd06.prod.outlook.com (2603:1096:4:1d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 08:13:50 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:13:50 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/27] thermal/drivers/broadcom: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 16:12:34 +0800
Message-Id: <20230712081258.29254-3-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a121bdc0-dcca-4ac6-1a67-08db82afec66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WsNH7W5DglptFbWoOqcRoHq32d6V0t/81ZYYiJfGqoaIyZLafE+w0HDX+Ug0VnBlrJUynLTX5Tf9AmCEnp/ONsE/qSC1P2TaNUXTQg1ZncwMUfLAqLY9bWGdOWdAd/RLloanIJPaPUo58IpUuc4jn67Q2aB4PXydkEhN6uWgyklTLiXYj03AUPLjoFhCA19lJrgQGcBB6Umd89p29PHPMWzh6M6bIodLVcsgCn45KbvYWmH1N51gWcPfjtqUQD7Q5ezlgLD5+yavezc6LzqFHVmlUwxV0P7CGKbho2EDLVHzjzrJE5i+l04W1mSnAbu642vFqvzyK992B73Nd9S5GiJkC+FQ/RIjYOM70qaMEk+HHziL4bEY9CPw/+UwsFv1uHPYxpIxiex1NEEpIdSHatSZplyog3al0IjftoaWlhieOEyjPAiH0E0UVQernDf39pnX4vA5tONSsxWQnST+hEIndOuzJy0TjcFt+Dw7ecZveHPYFKwcIoISCAjPKW7UJNqbAMSd76k3tasw50bkyI1/5pIuDnZ0E+3r1nzIn53s/GyXQVe6qGbHkr1BjQARqTG2gBMaBWywMgHM8tt6yZLHNWFFa6EgEtOb2khJDHwcgtNukWujWguPN1IeKkkd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(6666004)(52116002)(6486002)(478600001)(54906003)(110136005)(6506007)(1076003)(26005)(186003)(6512007)(2906002)(66946007)(41300700001)(66476007)(316002)(8936002)(66556008)(7416002)(4326008)(5660300002)(38100700002)(38350700002)(8676002)(86362001)(36756003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S05GQ2lNdXVpRjY1bEtXNW5nRC9HejdFb0RNRUdIY21IZkRrcXZaOGVLOWJT?=
 =?utf-8?B?MlRzbW40eFloU1Fibzd5SVF2VEVPbjIxYjJXb0lEN1Y0dGN6Zld0Vk5lOVE1?=
 =?utf-8?B?bW51dzYxN3QxeE1jV3BINERUczEvYTVVWXdPRE1FNEMxUG1FVzNCVXZNWXlm?=
 =?utf-8?B?a29KdzUyYkdFb3Zqb01sSUltQS9nd0JsaThJb2h2a3Z4QS83TDJFWjkzN0l4?=
 =?utf-8?B?Y1VpdUhMRFN0MzBXN2czQ2xMVWl1dWdMR0s2REZ1T2paTmZoQ2V2VFBKLzVp?=
 =?utf-8?B?SWVuLzZyeG1xTFNPZXlXNXJnc0t2ME9jS1oySy90WlRtRjhXVGlrQ2dnb2Vz?=
 =?utf-8?B?bDRycnc2bytOR05BZlVsQUZXVUlOcEp1UEZrZHQwZWVOa0VENldWMXQxWW8w?=
 =?utf-8?B?bHpxVnRjZHNjRDhDM1hYaFlNejJHQ3dRU1N0dko2S094VzNwa1VkZU0zUFd4?=
 =?utf-8?B?MGZDZGpsY0pzR3hTTG9WOEJ6cEhxcmtYc005dTRiaWVFd2ZmREVpS1BUZzBp?=
 =?utf-8?B?R0JwSnZ2ajJSQ2IzZ3IxNFZxb1BEbUdRTkhIblpoUk1JSW05Zkw3bGJiS1o0?=
 =?utf-8?B?RjJpV3F6UWNEbHlQR3JXVGtEZThDM1JDdmg2L05TMXhmNXZJSTA0eXZTSGh4?=
 =?utf-8?B?dFg2cE92V1VqbVJ4KzRrbndCRWlpdC9DOENpWmVEM2l1QStLV0l5RHlOTENl?=
 =?utf-8?B?Tk1IazNjbVdDM29Fakd6c0lMRXlTZEVYNEZ3dlg2OVVuYmhQclNIMW43U1Rv?=
 =?utf-8?B?VHg2a3ZPTm5uUEVqaXVRUkNQaktWMnRCemZNVzdGU3lGUTZBaEhhSnNZL0NN?=
 =?utf-8?B?ZUxZZlU5ZFFXaGlRMnlNb3VFQjNIRVFzYWFoTWtRZGo2V0pLMVFBOEViYWh3?=
 =?utf-8?B?d3o2bzA5T2xrTWpFTi9YMkgvWXRJanZqNzBiTklpazJNR3ZRcnBwSk9BYWdz?=
 =?utf-8?B?TDBkenptNWNtZ256WDdmMEtXNldMaENPYnc3MHNPSjJnOHhKN1JoT3BNNFJK?=
 =?utf-8?B?UjFIUXl0clF6eHU0M1ZhZmxaZEdQUnVEK1hndm40OG5GZjVQaWhBRThxbE5K?=
 =?utf-8?B?M2daRndTbDdKSGNDUGNXRGJWV0lZSFFTclZlSC9XYjRwM3pxOWFQS0J5ejNE?=
 =?utf-8?B?YmtNUzMrNmxhWlNKcHJHWXl5NVE3K2g1N1IvUDZCUVRIclp0a0ZOLzZrSVdG?=
 =?utf-8?B?QmlaM0twSjNNZE9HOHdkNXFGaU12YWhMNVlPN0wzNUZCNDdxU0xHcTBvb3Zq?=
 =?utf-8?B?UWZzY1NGWVV0MlpyZkg4dHlRTnRHbFhhKzhuQzkyYXBidXp6a1c4V3pZUDRE?=
 =?utf-8?B?ZGp2YmhQY2RhTGE3a3N6Vm9uMGhYMGRDbnJZTjBzQkdXWUlCS092aGpjOVh3?=
 =?utf-8?B?WS9jeUlGSFJ1Wk1qL0ZObHAzcU1WWDRtMWlmZERiVEY5N2FTd3czM29ycWlj?=
 =?utf-8?B?VVAwczF1OFYycXYrR296K2JGb0R2amxxMnZNMU5hbDltc3IrN2dPM2swOCtv?=
 =?utf-8?B?WlN2bE10QzkyTHJCS3czY3hieHRGYWNnUHJIYzZwRjcvNzEzSFVpcTJOZVRi?=
 =?utf-8?B?emFsdUE5d1RCQ05qZlBJcWZWQ0EvczlZS0FDOThjMFJ4WWpUc3BpM01MVW42?=
 =?utf-8?B?R3JaZzNGKy9HbjVLSXBFOThQZ1I0RHZia0l6SFkwY085SE96djk1SnFzZHAy?=
 =?utf-8?B?T0tTWDVLY3dFUEFHQ0hLM0ovelRGQkJ5WDRobUl0MlpqRTVLWkNJd0s2RkhR?=
 =?utf-8?B?aFRhY21VSUJESkwzbWlpVmcxYUFaZEZIYnNWT2dGWklrbXJPOUlmUFRYdmhP?=
 =?utf-8?B?bVZyMSsyblgyUXBQeitWREZ0dnQwNi9pWmc2R1JocnlHb29DVzFpN2lrY3Fi?=
 =?utf-8?B?Rm1ZNCtMSGtzM1pkbGRhNzMyUDcyeFk1dGkrYzBwUko0eEQyS2NFUXFxRUMv?=
 =?utf-8?B?Q0NVQ2UvbDcrOE5hb0w0cWFFbWN3QTg4cnlxblhnMnhzUmkvQzJRa3g0ekJu?=
 =?utf-8?B?MG1PTzVOUkVRa3BoMmoxN3RNTjh0Uk9xZ1VHY0lIdnNQaGZrZkRoaEZ6VjZF?=
 =?utf-8?B?R2JBUCtWQVR2anJTR3I4cWhuY2tldUh4enhKZlc2N0dUUE9ub25wUGFGclJ4?=
 =?utf-8?Q?0iUjjw5dRXXg5UqB0vb+jPG0G?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a121bdc0-dcca-4ac6-1a67-08db82afec66
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:13:50.1551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tKPmWUP2LbXx9eYenZLxmUcUwVNH6k3zipKTd0yTqjpwkxvMpe6UaBcGQhz2qbjBsvjzLgFGKclrYH8eW6bXKA==
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
 drivers/thermal/broadcom/bcm2835_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index 3acc9288b310..5c1cebe07580 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -282,19 +282,17 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int bcm2835_thermal_remove(struct platform_device *pdev)
+static void bcm2835_thermal_remove(struct platform_device *pdev)
 {
 	struct bcm2835_thermal_data *data = platform_get_drvdata(pdev);
 
 	debugfs_remove_recursive(data->debugfsdir);
 	clk_disable_unprepare(data->clk);
-
-	return 0;
 }
 
 static struct platform_driver bcm2835_thermal_driver = {
 	.probe = bcm2835_thermal_probe,
-	.remove = bcm2835_thermal_remove,
+	.remove_new = bcm2835_thermal_remove,
 	.driver = {
 		.name = "bcm2835_thermal",
 		.of_match_table = bcm2835_thermal_of_match_table,
-- 
2.39.0

