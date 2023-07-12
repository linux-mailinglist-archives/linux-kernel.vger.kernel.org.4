Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A162C750116
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjGLIRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjGLIRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:17:09 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2090.outbound.protection.outlook.com [40.107.215.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428701FD3;
        Wed, 12 Jul 2023 01:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/shaG558dvme994EaCEeG0kf9LRYgccjtgWR/e+17FtKiH1sH5/w9WuGgcqF0X+LBT3KmNOVDR96DzyXWyvdvmHkBCe5RA93yLqXTiyrtnkSOV/7FB/+yTnTRrbog0MaHPYDhWhov4scrgQLH/DIqJAK09ZFVeIwA5XcA8SrKDlOUK/4ySPnxZbKIAIeN6gJJAbK69DfoBP09j+vnSsfVzS3zM2OqtgSdslfai8BZukv/m84BfGwrkM80OQz7ah/UzCJYjUXY6VcujH9/qPtDAnirE5hwMMXVwbNVYUtBU360MMLd4Ep9z4BiD4+mAlGeQkmnktjKVo9FZGAYl+bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4anR4hB8BWzDaOgZAWI1NpEZLsSC9kJ1QyDsNU8d7s=;
 b=IjhD7Bg/Qiy/lk016qrph/Vcy0MinUx/iZo2d/QtpCpaox4jLuxMdg8/AdwCqeFLIVI+mRnOda4QBzBf+/R58ca3hEOMg/KXbeRPn6iQeDUqSaOZXXWORWsgKaiywLcQBG29WACo+c+XzmAaXlYu1djMzYEPzOhDT2YcQAu6/JDfO3SrgSr2JKB2vd79dERvVnG24jr1Kwi2BE0cekAQj3oQqjwzoKzIZSXYy4yVSFl2HQGylMnYLS7ElypRdbmFTTR+fwTilmyOAE6NY2RZYxFhC5V6a+B797GWZkx1snw5KfeYEUPtIUBfysfZe2S88h3gQUaCaOLAPyBOFdt9SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4anR4hB8BWzDaOgZAWI1NpEZLsSC9kJ1QyDsNU8d7s=;
 b=A0YTbUy/dLPH4j0F9UcYAt4LSNWfbfyPF12zRiKSAnYRiGPT+Rg+griFiI/QQHFIRXB3IA1poOy4pgH5p266B6lGin1oKLpR2hMxT/KzSwaS1KrgUvPP5z3maK/U3RYIwowvqLRNVrn/F3OGVh/iNdK0cd2EGjRK8DeDEQJaNCGGTDIUtipP66MdEzrPM2gNNXgiA7rRUORGRluJdBYR4gKMC2qvCu8nFN4o0e9+nnh2IDqX2Yhxj+CGu/ZSoA24tsc7TMAL0zZJKeJZRRMy1vkhE4UJ48xsR65h6xr10LdT2yBtkY/P8tT+dnSNutErl6aAh+6jMdNGgp1kYoQX0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6524.apcprd06.prod.outlook.com (2603:1096:101:171::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 08:14:25 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:14:25 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 19/27] drivers/thermal/k3: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 16:12:50 +0800
Message-Id: <20230712081258.29254-19-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4774065d-af07-4d41-451e-08db82b0015e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tfJKjhxM6rXUZbuejCr5mo0BBYgGI98SGWZnWZL9z/F59Z79HfigjF0tyPwhljwGLpQ2IioPYm275pBiIPEqyLXP/YKWlEAD/Ut6miZpnmAdvGYQV0j/Jhgd652tN/SijZXZCe6SkAlgkueJdUcsQXTdmELiEpcov8o9RsvGb6VUCB7HUqYOPK+Wn45UHtS5F2wj5KftLDXdSQ+7MPnfTbslBllGsqUP94yDaTbccKWTCB1QZmj0PMB7IjxGmaN8AImdkZYsJDt8UucU4Q4pSio7DXPpwmls7wmZIapn6YRZu97bCHJm95MXJ3u8h9SSnRVMXNsmp6yfiGpV3uO363LkI30TAT4LAiwJDDaFxuwVmdoz0HpwVnwT85dA4ZguFw1aJ12X7QDOFrOQBoDsKQOZucWkkdPeaPhSVW/21uPfJP5Sqqwy+ed8Mv8cvAcrYOCSmTK27n0P0RL77ASP4EdrsjdPhjFS3+ZDkvcZTqmWAetsQYRxuJsStZB1CScTd9+H8wJQ3nrIDyFP7O5EbfSC93m1MxPCpLMLh25W9EYW4fUB8HClZ4sJyBkVGPHgO8yrl4Zkfn2m9RSh6cMFnYrNNVMlUZ/mUsba1t1HaxmDu6qQzFirFlk7Ypd6Drpv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(8676002)(8936002)(5660300002)(186003)(2616005)(83380400001)(6506007)(26005)(86362001)(41300700001)(1076003)(6666004)(6486002)(52116002)(316002)(6512007)(66476007)(36756003)(2906002)(66946007)(66556008)(54906003)(478600001)(110136005)(4326008)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDFPc2U1dGtPd2wxUFJEYlMyODZXK0FtdmRKdGozbEFFYlc2RGN4Rnp3SlVC?=
 =?utf-8?B?SjVIZFhZbDdrc3JYSnAzZGhHU25TWTRabSt1U29IU1EzZU9lSy90RFp1MU9V?=
 =?utf-8?B?UGt1V2MxVTRmNVJINVBjYUVUK0I0ZHY5MHVyTDFua3YwVmZ4YXRGQnBSSVpU?=
 =?utf-8?B?WTBLUlZxRFJBa0pLWU1KZlBnaDdqYjR4S3hsQm0wcCsrNFQyTml2VmxrNmZJ?=
 =?utf-8?B?UGtBUnNGdVhjaTlTMzI1bXdGTVZhbkNYUXZiY29NTE5KVFEvMVhKWWZ4NkRp?=
 =?utf-8?B?VDVOUXFhOFBZVXp0WkMxZ3FWQlp2N2paQzU3d25QRTNjSFlqMDhEaXRSdm1y?=
 =?utf-8?B?TmU4VjFOM25nYVJPWldWbUtvdmJJa3hZY01oeURTdmU5dnlsZEl0VXZrTDRq?=
 =?utf-8?B?QXV5Yjh5bkczbkF4Q25UQlNmL0dIbDRiblFpaVJJazFpZW91Y3FBOWZTR0Jm?=
 =?utf-8?B?UFQveHFqMmdrUjA2VE5WSkZObU4rbDVadFFTemUxTENreEdrWlZDYVhTaWVn?=
 =?utf-8?B?bk9GUkEvUnRzTHRXMXpTWE9PWVRPVFdSN3Nzd0xpUjJpVVJBQVlMRTBTNGRy?=
 =?utf-8?B?Vy9DQWQ3bnB6YnFadnY0bFl4TEx4eHlYTTYxM3lzcWZXT3plTU5oSENKRlVw?=
 =?utf-8?B?YncrSzhIdllMczFEbmZBU0dNc083ZlQ3TlJ0Vnoya1VwK0JCOG9jRnZsaFNp?=
 =?utf-8?B?SzMyU3BtMXZFclNOWWhOd3JZdDcraXZpQnAxTXJ2MGJxQ3ArNTZQWXpZcFdt?=
 =?utf-8?B?TmNOZXhXUmszeVZpNEhSa2d5b3RpYXUwOStLY3I5WGxXa0grQUsyUlRZUytI?=
 =?utf-8?B?WFRSUHRzd01ZOTZySnBGRjJXNFZNSG9VN0Uzajk2OHQ2bWx4WjdpOER1U1pC?=
 =?utf-8?B?MGswU2dYZ0ZyVy84M0M1bVdUVGgrNmtrOVozVk5QVE43K0pBS3hsajVuTlBy?=
 =?utf-8?B?ak5KUWdRKzg2bjgxNkMvS1pGQm12eWRPSUs4K2VvTHc2QWl2ZmJ5VnludjFZ?=
 =?utf-8?B?Y1BQY0ZCcmxySnJEaDRmaVhGR3dyUW9zZDFyWWpBM2lFVXRHL1ZhMGo4QVhQ?=
 =?utf-8?B?ZEZzNE9lVEpreVZpTFBudi9vUFVGeEdkSXZXZkR1amNHM2lmOVppcHpicUJC?=
 =?utf-8?B?UjQ2QWVSNVpoaUtZdnI0VzY2eVNDNCsydG95eDhsMER4WU5XSmNUekE0MEVq?=
 =?utf-8?B?MUlUdHd5STI2L2FrQkFRM05mSVk4SmZzVUNNYzVQQ0RkMG5CaWpTQmdXVE1k?=
 =?utf-8?B?S25VaW5xVzNLbnp5Y3NpMThmbWw0eFVoclJvNTV3QXk0ektaeUR6WWlNa3dM?=
 =?utf-8?B?VjFwY1QzUTZFdkQyNVlrR0ttSjZRQ1ZiYThHZ2x4UzE0eGxDcVUzTjFwdWIw?=
 =?utf-8?B?YkpQU3kzNE1zdy9CcFM3YUdQUVcvczN1MDN2bzZhdGFaMW9DTUFWRjVpdzdh?=
 =?utf-8?B?djkzbHNITmxEVlljUWd4ZW9OZWptTXBHT2JibnpTRTJWbVhVWXZ3RFVGRmIz?=
 =?utf-8?B?OXBBSm02LzBMTFZIWjE3TXR0L2hVWkIyVnRPVE5mL09yRi9RNXlMWjFBZUU4?=
 =?utf-8?B?RjNudER6WHRuNUQyMDBVa0JWeWN1RXBXMXVFRC9lcUJMTjJzYk52SHpyUWps?=
 =?utf-8?B?U2dQZGl0NStCZGI5Tjd1L3U3YkhkZUlTUG05SzBQVEo4YUxuM054bG03MVpW?=
 =?utf-8?B?bjRGWkdKdXlXcUNFTnZLRWtDdDJYbTdZUERjNFVGcXV0d0d4UlpITU0xUzVp?=
 =?utf-8?B?eHg4aWdLYXh1dWdhSnY2aFQ2NUd2YXlVVHQvZ0xGcmhYNUFpa3BHOEk3bC9s?=
 =?utf-8?B?RHdZNHpod3hnZFdMdE5sS1VYd3ZTV29nVHlOdEx3TXdkWWUvTkFwK0JYRmFZ?=
 =?utf-8?B?ellPNkFrUlNhMjNGZ0MvWFNocnZEV3pnMHp2L0dLN2ZlQVYweXZPSWlIeXJB?=
 =?utf-8?B?dGNFSmxVaGduRnAzblpta0EvdnRUemoyMHZJQXJLNzdnTFBpQTdiQjl2ZkFT?=
 =?utf-8?B?SG1yRW52NXp6T3haNkxnQ0liK1ZHTlk2dHpKUWo1cDNSbkQ3YzJyM2tpU2Vz?=
 =?utf-8?B?elNoamdFME5rdkxqMzlEYmZPR2U2Z0dsZ2VZSHg3Nlpmenl1ZVFBRUlGQ3Jh?=
 =?utf-8?Q?fyMcLiSJvEQTjpvjLBwKW17M9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4774065d-af07-4d41-451e-08db82b0015e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:14:25.3351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ix7dVL1ZC9v7fm0wHtK4dQk7yZxN+0QVxzOtATuNQ3GtOI17efKADa5VzMn/fveGQcDTQ2xUnmJj04aa4KxYyg==
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
 drivers/thermal/k3_bandgap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
index 1c3e590157ec..ae03c5bdb5f1 100644
--- a/drivers/thermal/k3_bandgap.c
+++ b/drivers/thermal/k3_bandgap.c
@@ -236,12 +236,10 @@ static int k3_bandgap_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int k3_bandgap_remove(struct platform_device *pdev)
+static void k3_bandgap_remove(struct platform_device *pdev)
 {
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 static const struct of_device_id of_k3_bandgap_match[] = {
@@ -254,7 +252,7 @@ MODULE_DEVICE_TABLE(of, of_k3_bandgap_match);
 
 static struct platform_driver k3_bandgap_sensor_driver = {
 	.probe = k3_bandgap_probe,
-	.remove = k3_bandgap_remove,
+	.remove_new = k3_bandgap_remove,
 	.driver = {
 		.name = "k3-soc-thermal",
 		.of_match_table	= of_k3_bandgap_match,
-- 
2.39.0

