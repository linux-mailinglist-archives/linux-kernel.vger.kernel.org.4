Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0215750131
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjGLITj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbjGLISr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:18:47 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2090.outbound.protection.outlook.com [40.107.215.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FE526AE;
        Wed, 12 Jul 2023 01:16:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlWwXf/8dT5EtOA683eEblNmUo1ZtlEuz+lE04ZHKWl+XWHV7FG3MLFivs9LI21rbYWiN9I7pzm2QqGn27yOOcHnjDFAHyHRG5wZ0EpNrSC1bu0xvmydS1WojoqZ1ESwbQgWkX15234ksCnro1egZ2HZX6h/YHsoeKyerDXE4ktBSb4YPbylgnoUxcpvSiw/V1BzoYYkd3FZpNbwXRAsY70KORfMHBwh42uDyTWLoVBS04dXIkN3merEHsfg89D8AuPNZX8XpNPW/apuCNvzWPCfWt+8s+zIav0aUYfIx7re0NUykJNJxsqmLA8Mnf4RdHnhaZEw09gFxID4pypG7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNvjmd9xpoD3cwxwNpAAcC7ffsnPu39nlxJUxUcHiFw=;
 b=B9cYnCtw8QIkNvTpBJPEiAcbNubYrxuvao/xWv72mhMOutknj7iil9cAETv5l/C1U971BfpIZrxfal2J2gEhr4cig3XBevDN0cUmGZY3n2IRmzhgZHUh54FpxYaWskJ9cDYsT4tBZ3EjKq+slhwDGYpn1/qG/aksnLli6BDvFSat1WYv7/8nU5H3PJFy5/PO/DGR8pgmDw96OoI0ucnmf7i775WORPSTPwTeCCGlRU9aQSgUxqnu4kjAUsKoFgTLox+d5jqKn0FBp7skwjPhbEZQlL7cqfVMSAJQVeCsDafBTzWgWws6GbC/ZrPPiyDj+T/G0H9ptrziPf9hxDi5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNvjmd9xpoD3cwxwNpAAcC7ffsnPu39nlxJUxUcHiFw=;
 b=nizB2NtW0n8Gdq9M9GwvYz3veDjnFOQG/ZRHKBYUP8l8+xW+Qat8AfTOrTigKYDwskb/lvnu5fb0ItSwrArHOXYfUhTv7WCFD5B5n0LFYC/2cSvXa8I2C33w+Qm+miu0Mt2537qdOfwfIagJTYNeHrWf+biqaFU/DmeWmp/VBdVcxVNve8+lQTtS+TavLQSk4TmPIgVcU2vZpJtDuW3jkxkn9JoLVTuQ6LqOoD3bTDPp2T0DmN8lpQs5z7xK0P9Q2l39cB5Pqab56+MEfasTedXb5C4U+absnEetan1Z3lAe6WiQndWX3Z8YqKBL3IXnQx4PNsbn0AYsWhvTY2HEkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6524.apcprd06.prod.outlook.com (2603:1096:101:171::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 08:14:33 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:14:33 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 23/27] thermal/drivers/stm: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 16:12:54 +0800
Message-Id: <20230712081258.29254-23-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 27b486b0-7e43-4a13-054e-08db82b0066f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c8DS4tOMH8XHisE0YYw3lrNVFmQaLbMvdP1761dYBUi5Luo0t8OTsjPfB89yFEZx3mt2RZOgMwnMhy8FbSozK7yBOFvB6WFZ38rdsQuHAMO5DqaZaAZRaO2vQ75i3Pv8EcpUWPn1DpSqnjHrl6rw3yCjQWfbTo3Qdr53WCFk4rUi9Om/h9QIz4Ich+A7h25Yd8z7jVIDahgmSU+1oO2KP8a9KNS6tMR4f1FqdrQq+AbUez6CrIupp70c7aVSnp0ZNEWx0DYWFuzrdEpqhKFdEgEhxOucPeFc/hiOkx9GgxZmCV+qBBqoGS8LZQ5qv8DUD2NCs+YFdna7Ydyxf1D1odgpRWv/r4ai0dCjWGW3s7omMn4v0lzp5lZ8DhWklgchagbl9jUpaPRSO1fCSd9AVholzmmVpi8w5bBFcpZCS/316Waeh/rDnYTJRKNbhhGR9HII4bEkjvSSi9aEaT7DUk7l2XqU7imICwOh5Q8W8/Xw+UzP+C2lmVqkqUbuY4NWgtquyNc27+hcp1AANFx8UzrD3UtuJqyOtbl4V3w5GtOr0LEJP8mY4pt5s7HzObcT6gunhW4r6BjcffeJcrmpHqRftsufEy16JezNb8jtpzFf2Jv+tLShrntCSohqckav
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(8676002)(8936002)(5660300002)(186003)(2616005)(83380400001)(7416002)(6506007)(26005)(86362001)(41300700001)(1076003)(6666004)(6486002)(52116002)(316002)(6512007)(66476007)(36756003)(2906002)(66946007)(66556008)(54906003)(478600001)(110136005)(4326008)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2dxTlNVaVVOU1dCbE5yWlNRcjRRM0dZeUFKN1MvUGt3eFZhNlZWdUtlTVpN?=
 =?utf-8?B?aUdITE83N2hMdFVGaTJGdTI4NFJJU0YyMWtjUTVhb05TNEs3d1hmR2U4L2Qy?=
 =?utf-8?B?VjVGOEQ5NEF6QzRBVWdObDZyemhqNXZtZzRzM3pHRFQwRDNESGEwTVkzcFNy?=
 =?utf-8?B?SHBHQkxleElxdlJhaThJV1pxdDlqNFBPZjRLTyt6dlZZdmRUbng5WFdXWGc0?=
 =?utf-8?B?SzF5NVhYZnFWS2tmTXpVd2YxOTBOb3llRWpSVG5xc05ObnRxT0h3Q0phMDUv?=
 =?utf-8?B?S050TWlBZ2ZkY3F5TmRWQlJJZ1c4MEZBUC8ybWxkQjhUMVorMkN5S2JsYlJD?=
 =?utf-8?B?WTYyM2dkWTlPYlJKRUU1Ny9qV2NHUHhVcERORlFHT0JsY2x5SlZpNGlsV2Zu?=
 =?utf-8?B?V09aM1NuZ1J4cWFYNUxSZkhkQWJ1b1RqbXhFclJFZWY4WFR4UWNlUE5zQXNk?=
 =?utf-8?B?UU82SkhPWGk5eHp6dE1XTmlTc3E2RmxlczIxT3N0K0lXUlR0a05JME1TT2p5?=
 =?utf-8?B?TWFTNzFBNnpoSDdxUFdoN2NydXVjUFU2VFBBMjEvaXRJcEFwcGpzR01McU5W?=
 =?utf-8?B?c2Q5blU5UUxrSjk4OXhiRmJzekZlT0kxQ1ZaYlUzaUpWZ3dTczQ2Z1kxTjcr?=
 =?utf-8?B?ZVJ5WFRUTEVpdVZJWG1JNnJSdUM0NTdsaUE1YUlSdXFid01aQk5sTzRFOCt3?=
 =?utf-8?B?endCSGlLWlgzRDAzZ09BSmMxNEkxWkxVcUxLOXZORDBaWFZSZDJSYXJsMHFJ?=
 =?utf-8?B?VDI1dEdRUDFvT3lrcm5WdFRlbklxbkR0cG1rNHBmd1c1bnVtMnJTcmZBQzE0?=
 =?utf-8?B?UnlYUTl4UXhZKzhLUWY4THhIU1U0RVRPZ1F0RWMwdW16QTkwbkY0SUF5Z2Nn?=
 =?utf-8?B?RkFtUGl5Zjg3eGpDUDd4MUMrUktFTDVadWhCU3ArWnhtRFVTR3BZbVZNbmw2?=
 =?utf-8?B?UWpSSXpJczJxaTVVbmErZnk3L1ljQTJPUWFtckVzOTNEZUFFUEF5WndJd3lT?=
 =?utf-8?B?NjBQWkUzWEtFQU5sR05VajgxeUd5SWRKekJPMy96TVh4T2VFZFVKWkc5WXZS?=
 =?utf-8?B?ZW9mRDZIbno0ZWF5TDlqRnhkeU9JWUVTNFh1TmtLdTZnTUFxcXlVVkZCQmF2?=
 =?utf-8?B?Mkx5aitXRXdQbmJ3QlZoeGpBL2M1QUltMTN5aWx2dGR3QkpyK05TbVMwWUFy?=
 =?utf-8?B?azBlTjR0UTBiR3dHWmV3WHkxYlFuOGtKVitJYUlPbHNldVpKb0RDZ2pqU091?=
 =?utf-8?B?dS9CbTRUR2hMbnUyMFJZS1ZrUDRyUS9nVzNEWHY3RXVhOWxwenpBa2hJMmdC?=
 =?utf-8?B?VXQvRHd3aHl5RUJhdEpCSDNkbDB5dWRpQ2RvQzZBVWc4Z2RwOThlbWNyTVhm?=
 =?utf-8?B?N1RGTzVGdUpMK0NjREpSRHh5MzFlM2EzQytZNEtnRVNxQ3picEY4WkRXWno0?=
 =?utf-8?B?SUtscWZ1WXVqYTJQMklFUUNtVTFCVzZoYVl4WEx1TUZnVDdMdkUrQ1p0NFNT?=
 =?utf-8?B?K1l6WldRbURNUG16Y0ZtbHEwRWorVFBvRG1UYXZ4bmRPb0t1TEdKc1FEb2pH?=
 =?utf-8?B?bkhPdElXRTVRYjgwTXRFdDA3Z3FSc0tZaGJoL2F4eXV3dU92U3VXYUJ1bnRJ?=
 =?utf-8?B?UHZXS00yeGZqaUVWLzAveDkzNCs1cExMV095ck9HMjZyL2cxMXdyMFV3bml0?=
 =?utf-8?B?S25kSkJ5OHJXaVBiYVR5VzF4Z3hEK1RlQ2MydWIyTzlLaVJRalI3Yk8zS3h4?=
 =?utf-8?B?bFpPVnI5b1BpOEdsU3lLTUZ1WkNUVS8wSzZVYy95LzNnZjNnbDNqaGRSRzlu?=
 =?utf-8?B?b0JJUXZadVdDREI2OHpNejZXRnQ2NEZ1MXpLN0k0dGw0WVBuSXlPQWg1RERa?=
 =?utf-8?B?NHp6L3hqYldFaEt3OVpkZDRaQmxVWXozeEp5bEt3cG8vTUU3MVpoYXEvSHlY?=
 =?utf-8?B?Tjl2aTN3eEtTZk9yZ2tEV0hKTVd0T3QyZG9ySG1SaGhJY0tmdThPallTRFIw?=
 =?utf-8?B?YWxGMS9hbS9YZHhJSm1KbkhXMTZzK296ZVhOUGZVSVdyTXl0aWJhM1pVMW5N?=
 =?utf-8?B?M3lKZnlFdEF6QmtXZGhZaDd5MDhhZ0ZDbmorNTZ5V3hSdUtzaUxtRUMvcG1l?=
 =?utf-8?Q?JQ/jBFcNF3T/e6mNE3MW9+pfl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b486b0-7e43-4a13-054e-08db82b0066f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:14:33.8278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZ8vk1G/h3HSFfMkGQQVO0ZNey1/SRHAJLLqdy++h+qQLa7SxsiqQq6AS++JXSaGUXJD1CbtgWZT9Pm+zodeJg==
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
 drivers/thermal/st/stm_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index 903fcf1763f1..da6a25ce4469 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -571,14 +571,12 @@ static int stm_thermal_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int stm_thermal_remove(struct platform_device *pdev)
+static void stm_thermal_remove(struct platform_device *pdev)
 {
 	struct stm_thermal_sensor *sensor = platform_get_drvdata(pdev);
 
 	stm_thermal_sensor_off(sensor);
 	thermal_remove_hwmon_sysfs(sensor->th_dev);
-
-	return 0;
 }
 
 static struct platform_driver stm_thermal_driver = {
@@ -588,7 +586,7 @@ static struct platform_driver stm_thermal_driver = {
 		.of_match_table = stm_thermal_of_match,
 	},
 	.probe		= stm_thermal_probe,
-	.remove		= stm_thermal_remove,
+	.remove_new	= stm_thermal_remove,
 };
 module_platform_driver(stm_thermal_driver);
 
-- 
2.39.0

