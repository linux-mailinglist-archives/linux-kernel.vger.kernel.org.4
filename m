Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCCB7500F4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjGLIOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjGLIOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:14:00 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2103.outbound.protection.outlook.com [40.107.215.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B7FA2;
        Wed, 12 Jul 2023 01:13:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSGaFOAWM5MRQRhk68YkosXcvIlvYPr/9F71xtuvdXaa4KSCyL4bb8rIY/MjBeVb3N4BxZTgpQ2lGBI1AcjqXUWpn+Ubobb2aXZJ+1D0xZzcBy6nlMZPL+xedPVsE7ZZKfWhgcFY0K29dakOQ/KS2zplJl8DDD4mtxGMjGe/rMrmP/QqB4va0yu1Zh+hOuUhhx695T+zzyhvmBsv342+2gAAMxyKcF95TBfyym1kjp9OdeGyinjIPLy0PjGFFVdufW5YmMpqqFhZM9bAhgZsTAk9jRGcZzwl9ObUUZ57Ui2oB96ekag1obOqcKigftofjMuoZCnPbX4ko1Fc2qe6GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPaIbHnUrLgcrPJeVxQLB1UziQNQ2n1S+DMK88EN3Ko=;
 b=dH4WaFrsAvLrJc+PeL46kVCw1yrYz4QSA0/agMOIk9OMb52t3UixJiRm+BydOPL7rOBU2Oh51bahciDglJ7KE8O0pDhNIjjW99uP81pIkMWIcbV+WbDIDSYTkc8E6U8K4AR3AORGrWeZLwyVsUch7ULMd0InneO67MKY83h8WDVDLedJUGntxzeziWcPvYYGjHf0hz1sti+9uHbZUY/dKTfgCY65XqJ8Yx+D7CMdvWDCHUNz6h/BwrAQy9yYWYL3yOm1wIF2ceBSvuL6kblko4rEygWVAxGSLRr/vVnAB2MXO7Rc8L/oaqSfeFktlUOU1aRz6crc9yOS91cW05XMrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPaIbHnUrLgcrPJeVxQLB1UziQNQ2n1S+DMK88EN3Ko=;
 b=Oa8fCESlm3Ss/Ew+aoTXxXmV7S8INkTe066saZrwmO43iAJx2e73tGFycnp+YOVg1orBQ1SchZdfXBmxS/gpV6ySQXVUgh/sGxoDII/I4p1wjG6SZVPY2RjO9agc1uiZa05bqySjdaad7nN7FM4fE3CjrxpyyTNqr9bzL1gnQiK/7Ifj9ckNYQzHBDJnkvN6MClwBt9t7jB6dpU0nxASJMaEUuhQCv2QTG6iWyTbSDH8/K/6JaTMgycqm7Y/BMlBeQvJ/ox5b8otmgIMO2ohGWpO6qNGb75Q+DCCEj30CAupDNVrERy0gPYVp2ACcTxAud4MTV1nDQNDBjhp4tps0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5382.apcprd06.prod.outlook.com (2603:1096:4:1d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 08:13:55 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:13:55 +0000
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
Subject: [PATCH 05/27] thermal/drivers/imx8mm_thermal: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 16:12:36 +0800
Message-Id: <20230712081258.29254-5-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c0d6d2a0-d817-42cc-8f87-08db82afefaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1uMLbiuQUAwZYpIJYlrXpVO5Wk5k5zYbCaKDEnVaPuNm3NHwx2mWv+Yu/+imQr0Q2B7yRmEBplygmYkuHEQGIukdUF7S1SehXBHrJcBpZKEeKd7vcJWkMVTNaNkIcHOFHbVV+rYZDAkKrr/LiEzKKdOBo6eBC8lykQZN19HkVRc+b9eHMj9oU4/zvbEPiLX+1TlVEH1LlrY1dAME9aH8U3wrtz5Qi2ZsXEtpsTGUAwqBOjOI5icywAvNTNKCuzDjB1gVE5gaK0w+vAHD2/Do2yWoJXkg4isoZfp3RHCs233I0Xp6aMtLavbrMxeLWLlSvfRY7wP5q8yWVGPKTEa1klWhlPy8C4eWrDqB2yH5YpzWTd/4lManDtbY3QSNrgNgWXapcDrhH4Rym6SlOStgaU4QUCwg/gO29YaI8sbGVtclxJ/TrD6AE0lxmHCYCTHn2ZBCdSnBsUMa5wY3G58glWFEy+8PhCN08OEU/ZuW6TmkdyGDOmXQOqwBAFP5sJt42iZn1QQoTuR8ebN+yKte1RsmAPbq2/1yDoSoYy+qI7+UtnCtxj5RFQZ58/OegZGUkPnPsw41JX2MdJbb6dOWlQFAUnfzj6NZ3sMaDsxCz4rrIykD1rMAr5aViRQv306L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(6666004)(52116002)(6486002)(478600001)(54906003)(110136005)(6506007)(1076003)(26005)(186003)(6512007)(2906002)(66946007)(41300700001)(66476007)(316002)(8936002)(66556008)(7416002)(4326008)(5660300002)(38100700002)(38350700002)(8676002)(86362001)(36756003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXZxVGhZbUNUb3JXRTloVUpPdHJ2U1Bhc3dxd2xqUVVDanBoNGlHMkdrUlhh?=
 =?utf-8?B?WTM1azFRRGticEhrbmhGQVVPUFpUbU8xZDIwbzZhZGNvTkFLa1pFRFhDQW5s?=
 =?utf-8?B?STlMdGRZVTJFd09pbGN1aGxod3F5enNsVlp3VnFRSEpseWtnajZrcTJMV3Nr?=
 =?utf-8?B?b1JzSjI5MHdQZG8xbGNvTi9aak9HaEdDRnBJR1Q5blRBTWM4M21rZVpDaUNC?=
 =?utf-8?B?Y3VGajRNQXR2TjF4Ny93S3FCQWNJVW1neVZrOEJkSmVRd3phR3NMcGt2ZGJB?=
 =?utf-8?B?YXRHV0MwZ2F2UHQ1bjRyRm1ML2E4UW5qdml2TENSa28wTlR4T0hkYzhoYURG?=
 =?utf-8?B?eGdaemF1VkpQbXcrWmRiRWNTM0ZRcVVrQ2gxNHZOejBNQU5pSDdvTUNTL3lW?=
 =?utf-8?B?OHJoelNqOVA3em0zM1huaXR4NG8zVkVKdnQ2bkJxNXpCZ2RSQVpjL3FRUFpD?=
 =?utf-8?B?R3dBYWp2YU1wTlBXU2xLVWpEVGl6YXdXTklHMjNSR00zSmxUMzVzOXhEVi81?=
 =?utf-8?B?N2ovZHAyMFpZcHRhMFVVa002Sm9oUzF0bVBvYWN3YUd6Z1Q0ZUwwWllRWCtk?=
 =?utf-8?B?eEw4ZlBRU0pYNE1oMElwWXpnQnhJYysxdzk3RmIrbCtvQjFzU3RsRGdUWHpT?=
 =?utf-8?B?SVdZaGdSNy9jTVd1TXpPaUFZcGt2YnBpclc0WDhXK0cyNzQ2MEM2VmVheGF2?=
 =?utf-8?B?ZWh0M3BQWUFFaHZKZEEyU3JxZmpBVC8vWi9OdzBGdkNnYTRubk5kWWpvYStV?=
 =?utf-8?B?VVl2UDRyRGZCcWdLVk1BMXFpYk9kaDZhSEdHeHg0cWxUS2V0WFl2RFJYM29z?=
 =?utf-8?B?L1Y2TWRBVTVZZlpkUDViUEEvbzdKbUlocXBGQTVJNW9nQnpqZFRmeFJJUWFm?=
 =?utf-8?B?VHJaL3VCbTNiZlgxb01IZ3Rib3ZxdG51Ry9aZ3FFdGZJakxqQXNzaytXYUFh?=
 =?utf-8?B?eUNjN0tBRDNucmx3TkZIMEJyQ1htcEl6ajRSUGxLbEoxWmh3NFRQWktSeFBw?=
 =?utf-8?B?SXdYcGc4S0xzcDhYSVRvSDBob25NNWJSYzRIUDI3TWhFQTYxRFJndW55Y2ll?=
 =?utf-8?B?Sm5RSW1meEJxNlJwWWJSSWQyek1rRXlLMnZqUnAxNlNvVTdzL1F3c2pZNkt1?=
 =?utf-8?B?ZTNRc2lFb3JmWk1tS2hPQlVWeG41ZW9kZU10UWNpYXU4Y0dyWlljTnd5T3pE?=
 =?utf-8?B?RGFyUFV1U1pWNk1uV1JlZ1FPcG41RXhKbTNIYkxtZHd2U2cyOU9Cb21QVnhX?=
 =?utf-8?B?WXgrSWcrdGRPUWxGZFNUTUo4ZEdzeVVMdWxXcitEZVhjTGh4dmdhYVRBWk1K?=
 =?utf-8?B?Y0VmYjZ3NzN1SEZxVTg0VG1OcWpJazRrUWJ2dXp4dXV5ektYeWRESVdDNDVm?=
 =?utf-8?B?c0s5TGlBc0NWWWZUcnpYejhJb2VFNU42MHhYcWtsRk4ybkRkalZPdkFOdmJ0?=
 =?utf-8?B?MDdSNlBPaWVvSk5YbDA0UjhSVjl2QVMvMHQrRml0aEd4cmxMOVZBUE9ZYk5u?=
 =?utf-8?B?NEE4KzNIQnhjRjNUMS9UWEtMRnZBYUxmUFFvKzA1ZUdCT3NWMnJ1bjR0UUxr?=
 =?utf-8?B?MWs5RXpCZTBnb3FSQm8rbEdQNGJDQzdzbllDaVVPTzRuZzdMdlNkTTloTlB0?=
 =?utf-8?B?VXR3VDJ4Mm10SEtnM3N1Rnh5M2t3LzlCQk5malhad0x4Wnk2UVZDVzQ2YWRT?=
 =?utf-8?B?WDdlOXVOQUlRSGR2dVE0L1pQcmlNUnlVNytpTGtpc1RQVHo4L09VWmZzY0o5?=
 =?utf-8?B?TVJtYURwRkt0aXpCNng2OTR2MzkxRTRwN3NEaW9JSEVNMWx6ak1JK0tydGZy?=
 =?utf-8?B?NisyS1ludjlZN2lSNGtWaDNhbUp2STY2R21SVkE3RDBoaVNzZStMVis1WE1u?=
 =?utf-8?B?RUJmT2d2VnNqNDVHOHlqQ1prRjFudlBDRzd2ZW5xTmsxTUl1UVk2UUdveFZW?=
 =?utf-8?B?b1VYVFh5R0hOMHFZNnpkalhWQkdWNGdLcVdKRjRvZHZJdldhUkJHMlpBL05N?=
 =?utf-8?B?eHIyWEtkaThpQkgwZEU1QmhqeTFpcE9RSDNuQXlDRDByNlprUzhsNmFsTERh?=
 =?utf-8?B?Q1NNNlU5NTVyWjJINjk0YW52MVBkUzg1aU0vSWh3UmVUZkxVWkZLZWNoRWdv?=
 =?utf-8?Q?aefqa5hCnbYH/n1DO8F0M2anG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d6d2a0-d817-42cc-8f87-08db82afefaf
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:13:55.6672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SIoofbUqzxWGLZcF4dCwVX2i2uLngE5Uh3uaT3XsToVbFxROFtca+HjXrMpAie19BejXlW56nOoptVkOEjfHGA==
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
 drivers/thermal/imx8mm_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index d4b40869c7d7..b95564ad6319 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -366,7 +366,7 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx8mm_tmu_remove(struct platform_device *pdev)
+static void imx8mm_tmu_remove(struct platform_device *pdev)
 {
 	struct imx8mm_tmu *tmu = platform_get_drvdata(pdev);
 
@@ -375,8 +375,6 @@ static int imx8mm_tmu_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(tmu->clk);
 	platform_set_drvdata(pdev, NULL);
-
-	return 0;
 }
 
 static struct thermal_soc_data imx8mm_tmu_data = {
@@ -404,7 +402,7 @@ static struct platform_driver imx8mm_tmu = {
 		.of_match_table = imx8mm_tmu_table,
 	},
 	.probe = imx8mm_tmu_probe,
-	.remove = imx8mm_tmu_remove,
+	.remove_new = imx8mm_tmu_remove,
 };
 module_platform_driver(imx8mm_tmu);
 
-- 
2.39.0

