Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21BF750340
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjGLJef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjGLJd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:33:59 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AD119A0;
        Wed, 12 Jul 2023 02:33:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcvMKRIXzEVZwyH6FN2emI5iSmvNsQ8DztwmSaKDwwkcEX9X5GLOieRPMH9CqmffaTBVYjGCxsuZBVYGKXrU+kTJRuSN5cBU+QsmiILj9UsTPDcvsRYrZ5Fn0PGDYxGQE2eaJHScc72dvi+qHXNyLjBSVqJbEPIWnriB70QvDIdlizYubeGKIGTIMMPhyDbShNBTAGodfrAzgAmFyT1/BDJfB6/R+HIPjt0Yw/F990deAEuEwr72jDVsXzDqNGGmmI2V6KQcFfaF2bsrTznxWp7Hv1Z1tM9gU7acQdFudRCcYPvlaT7fOlLQzHBVYkBqZxHrZz0n4jPGxxpB2vN4AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+IWyyTdI+3JNaPeR5z5dkNulc/M/Z1sGW+d58kuBYw=;
 b=O9guvuIeHI4wtCwYLdyxx/6OKb4aio3nHjMnGx1SavJA4Vsxz/oJGDe1ZCviskwxnZQV0DjD/nUA3ioiRYUeZ2P563iUgl8ORKLwT56Rf6tfJPkQh9TTZQAt7bhylylhatnkhd9JCH+XqvlrVIS7NwdEno/FjU4fLe4fAiymxQBjXI3SN/QQTV/fqMc2LHZdv5vDShwL22razErN0VM9dMNHJV9UihygkqgdJCP38x/pREiEDjC9w6H6t9bwhHuBsbegzW/jfiFM3+m+1yUKO1YIkdIrFMsxZu6XG0U8wQ+ngHU+EWXjGgv6IqFi9fkSW0bG6Htl/oXDRZOMGQZChQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+IWyyTdI+3JNaPeR5z5dkNulc/M/Z1sGW+d58kuBYw=;
 b=oqhemZW5WRABsTPJ07ApY2jS8FE0ih5yT1huvWTOElYWTKANHEPsNpEIskbBDK7zNAbmeU+sA3QXJnRYSI3aLSyncdJn80YE2msL5Dqis40ai8nNfH/9WuHKZNI730SEcWm/evt0+63WJW9DJ4dwMoyxF5ld5mVyr8QLWTc18BX1SCW4w0+uwxY2HcWyCOBL24GOCc5HrYgbtA8k8UCGdzkNgwfIw8LmssICvbrF/5aQMO13zI0LmzSgSAo+Y0teM4YjQnMk00C1vU2gno3xqWo1pFKG8HYl058xsacitHb9f/VwM0wmRh/SnzCnFk1FzyehVk4NUqOQtn4nDPZSGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5985.apcprd06.prod.outlook.com (2603:1096:101:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 09:33:51 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:33:51 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/19] cpufreq: imx-cpufreq-dt: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 17:33:13 +0800
Message-Id: <20230712093322.37322-10-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6bbb9c65-1ff5-4573-12a9-08db82bb1a40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MpceXVcx25I1doBJ175W1Bvvqa6tUhZ1Z3FIuP5D5zcWw0SCo/qGGAAaX9lw0qunVtUjYb4BwuqNTjXpe24jGsmtuyufrxnXb/IKkSrdFhl78zryvonBOWNOkbJKrsJwLmTArylrSOHonh9POCH033WsZg5XsfI6KGTxPdKRtJifCPHtdkX4AqVeWwU7GiIp4ZyZkBNMDr9WxG/T5r5LYuM20uR0LeItmIdIqIjK4ClFx7RAvQZsC3eJNKvdw1GbQGDQZw9U1HFM86BoVSS/EmQ0jJ26ztcyv90knU/8u1g3Q7Y5hEM4aK0aabcjjC9wfMZd2pWCPPPt0Hsf3zKgkh+kiCmdDorrk9y7xR3sorR49QXiGzWX25rKWCxBQu4dYFBYOa+CsME2oNpi9wgu8UsV35eaTTBo4ubMesd1DZKE23u264n8NkgJtJWQhfdVKGWBGTodd6PzAqeMfagZ2UGPCf0HV9Y10AavB5WBr8RtTavH0qRjIN3Pld57Lb0RUQAya7fZP3iZIFpQ0z2XYaoemj7ypovqkvYWWnVgLR9ZxUEg8/zDCV9bPHvtQUmmrRftpaKb3hLp+E96yzHmCAZbskihID90+RiBA06eEnmG6srSj0klj6VinLauvID4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(186003)(2616005)(110136005)(54906003)(38350700002)(38100700002)(5660300002)(8936002)(52116002)(6666004)(6486002)(86362001)(8676002)(478600001)(316002)(41300700001)(2906002)(4326008)(66476007)(66556008)(66946007)(7416002)(6506007)(83380400001)(26005)(1076003)(6512007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXNTWjQ2VnlVR0NqZVJVeERwNS82QXgxTmRMa1dTcVlOTTh6dnZyZmE3b1E5?=
 =?utf-8?B?SlZKQ2pQcmRKVktmNGJ3LzVYVXY5R0dDQngzbTFOeVdLSzVhZlc3QStaOTgx?=
 =?utf-8?B?ZnR5b1o0Mmw4TUF5dFR6WFB3UHY5WmtRRlV3KzVxWE9RUmtsRFJIUExCdkFP?=
 =?utf-8?B?Zk9Ed2Nxc003VHZ6U3k1Zkx1RTcvVVVVVTJ5Ri9jQitLWlBod1U0RGJ3Ymhn?=
 =?utf-8?B?Q242dnNrQSswa2M3NVBmWS8wV29vNFQxdCtMbS8wcFo4YTZodjVhcVlTNEs4?=
 =?utf-8?B?cVpRTWlzWGo5dDA3bWZBRTlSQS9LNDUwN3pFWnkxOHErc2NFSU5qOEF6KzBy?=
 =?utf-8?B?WHJkU083cjhqMDN1RjJmb0w2MGI5a2xBQ25rR3FCSlNodURkTXNKbE8wbHhS?=
 =?utf-8?B?SzlIVXBNeWlwOExPaXVkMTIrNkJQZ1dvUFlNN2xGdzI4b0FRQUR2YXE2V1l5?=
 =?utf-8?B?eVBaNXkrK0FFazdZOTlnaDMzS3VhaU9VOXFNL0hXbzEwaW5nSm1Lc09VZlNO?=
 =?utf-8?B?Nm1YZkpzUndEYWxLQWkzeDBmTVFFSVE5aFJrbXo3Z3pqZkw4MVVFWTd0aHBh?=
 =?utf-8?B?YXJ1b2JSUVBpSE5FU1hCT3lydFVIaWMrOU84OHBaTjJqVGlqODNWZUk0ZnBr?=
 =?utf-8?B?S0JEd3Q5NlJmMTVMeGpnRGxEeE52M1U0dWJCcFMwVktjUmFxZFlaWXZOcjNM?=
 =?utf-8?B?clhvSVYrbUx5RXp1MWlaRFkxNjB5MElvclVzRnc0YTFpdUQ3OHRPTWNHU1M2?=
 =?utf-8?B?Ym9kV1Fxd2cxaUd4bTJ3NFh0VWpyWFhNbmdJVVNKT3VhTDFoWENIM0Q0KzZ4?=
 =?utf-8?B?NlBoTmRLd2gyM1ZBWkxha1JLYk02UHQxSG5yUHB0aURVVkczN0NHWmg2cjQ0?=
 =?utf-8?B?WTFCVkY2bFNHbHZDKzljR1FZcnNxM3UwM1A3R3psVm9MUFRPSlJaWHRtazBt?=
 =?utf-8?B?MVdVYVFrS0FuRDRoTTNXVC82bzB4MExoalc1alVta05hMjZMbmRKbHo0Nnk5?=
 =?utf-8?B?b3VCYVo5b2Y5RUhTNXQ4b2Z0YjBwbkt3M1dxeHZ3T1R2MXJaUEt3b3pDR25X?=
 =?utf-8?B?ZzNObHVaMHBuaDY1M21FMVV3bDdtRmU4UWhaclVmN0N4NkpnTnRJeFpCRmxV?=
 =?utf-8?B?dmR4QzZETDhwV2hHUnQ4Wno1VEptVTQ2UEs1Z05YbmhxVmRzbFpWd2Y0dFZj?=
 =?utf-8?B?TVp5NWprejZPbWFPZmJ3TUZHTUYxaWU2M0NOcEcxbGEzQ2c1MitFbC9pbE9C?=
 =?utf-8?B?SlRYU1BWcUU4dGViWU1jSFRKVHd3T1dndWR0cWlxZTNJVGlGYzVmOEk0UTNo?=
 =?utf-8?B?a1Z0cGdKcGk0eE9CVDc1WTlkdGVxUW1KZmFualhvV0xTZEFDWG0xbkd5OFkz?=
 =?utf-8?B?aVU5NnI3SnJxbFpwbVN6OWx1WVRnb1FTb3JpVUJmcWQ0d3gyTTl2YWJBMFBI?=
 =?utf-8?B?YzlJU0pSbXdGTlhmVEdEdEdDeVNtM1hSa01pSE9jaGNmZmk2R05GbTk0UVlX?=
 =?utf-8?B?TUNUUTRHK21QSTVMbVlkR2hFU0lGY2IxZkJvVlF5ZW9FQ2Y1SUsrM3VBOEpt?=
 =?utf-8?B?QzhpcFlha2RiSElsSXlSNGxiMFgybm9HNmt4TEk0QlYvSEJJbVlLMTYyTmZU?=
 =?utf-8?B?Z3p0M2hLY0tXK1JPVFNIeE91bWUybVgwRXhIcG81UzExY0VTQ3BZV3k2SEhz?=
 =?utf-8?B?VnpwMThaVDBDNjZUREpsZFFjbnQ4SXNsUEFtSWJhRVo4SmhxSlRqT1NTeUZz?=
 =?utf-8?B?QncwNFhGTXgyalRoaXpoc1dxclFaaFdDb2NSSVpQTTJIeHlYTi9QckZoRzdD?=
 =?utf-8?B?YkpSNHltU1ZSUmd1b3JlbWgzSUNhaE5wQ3k0S3JjYng2SnhidU5DZWZqalBX?=
 =?utf-8?B?akdDUFd6aFdnRHlLMmJhS0pWOStTWmM4ZTJ0OVkzYkFsckRGMU9KY0RMTUU1?=
 =?utf-8?B?ZzZybHY0Y0pkSzNPWDc5MjFsc2dLWFVHRk9MTnUzallhZmNCbGVQdi9PejRi?=
 =?utf-8?B?U210VkIvWkcyemlzVFNDVW5zOHdTbkNlenZQWWR2VldaNXZTSjBIVHgwMjVl?=
 =?utf-8?B?Y0NmSkZBU2E5V1JqUEdnVWw3U2d4WlBRRk1ObGhKWmdOUDRaSlZ5eEdqemJC?=
 =?utf-8?Q?CQcpr5AYu+VXm0YnLS/rVLcIx?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bbb9c65-1ff5-4573-12a9-08db82bb1a40
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:33:51.5357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmqQVDvEVxDYXAeXN6hLs7bMbwBQB9NpDChTM9uiTELkaZS8HVq8sPesvTz4VIcQRLJz9l918fFXmNgEcoR3TA==
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
 drivers/cpufreq/imx-cpufreq-dt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq-dt.c
index 535867a7dfdd..577bb9e2f112 100644
--- a/drivers/cpufreq/imx-cpufreq-dt.c
+++ b/drivers/cpufreq/imx-cpufreq-dt.c
@@ -172,20 +172,18 @@ static int imx_cpufreq_dt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int imx_cpufreq_dt_remove(struct platform_device *pdev)
+static void imx_cpufreq_dt_remove(struct platform_device *pdev)
 {
 	platform_device_unregister(cpufreq_dt_pdev);
 	if (!of_machine_is_compatible("fsl,imx7ulp"))
 		dev_pm_opp_put_supported_hw(cpufreq_opp_token);
 	else
 		clk_bulk_put(ARRAY_SIZE(imx7ulp_clks), imx7ulp_clks);
-
-	return 0;
 }
 
 static struct platform_driver imx_cpufreq_dt_driver = {
 	.probe = imx_cpufreq_dt_probe,
-	.remove = imx_cpufreq_dt_remove,
+	.remove_new = imx_cpufreq_dt_remove,
 	.driver = {
 		.name = "imx-cpufreq-dt",
 	},
-- 
2.39.0

