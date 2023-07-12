Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382B3750339
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbjGLJeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjGLJds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:33:48 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A0E10CB;
        Wed, 12 Jul 2023 02:33:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2/A89/8+HSTyBpR60ocd5+kZ2b2pNyXwxx7FayKWEZc5z9RXsVwU9OtBYCEmHhE7lgJe5aWuTMCoTJ5UBgH3EodCW5R9ebn7MJiJCsBv2LIOAHPGv3b2WAibD33cuibJ0iWp/sjBNUOaTuAFDjIA1Eu0GzboNGelyuOzFbii+R3qNRNjZm868w5zVRp4jALGyjoZsX1swgAzOQlPf0eRkISJ1mwNx+5dAc4UwcSMp86H6WxcctRVUSuBmXrN//umUjguLxaj4oztl2q+CKDjIOUWldG0AzispVXCSVF95tQxQiRg6FLRKC//hrXocpBLy8z3ajmUCnoMI3kWpuoxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hn4BgINhfID0hXgw7aqm2m9dcznZSf2Tp+1Mvs1eRBo=;
 b=YepzNFIRBw+Esy8kCC++1FTqfqVaDCIMAfh2SWMDsZmcczdmgggkxmfnJ9kxGxzyLUnj1yKk6RYrhdsrkCT7eyxvQd5Hmn1QvHwhOlULSF8b79XO87ut5psbn/WWSEBsZjnQAPZVorl3Ks1h3FxXWDZioETk2HGeWULuRU8FNnWkexcXxJMH3uiyKr61bI8ad/5+BMJrNgqnA47QIcH9fE2StpjPN2m0h1OKujGTNdbxPSTKTLZNIfF8W6D/inuqyNLQrjb0Mw/XRG+MXllBQr/81Ivzw5rvTc1eSIAuTmoKJzvmvTQNtgXVQDylLSlY/GxS3zZYGs2Qulu9+0oJeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hn4BgINhfID0hXgw7aqm2m9dcznZSf2Tp+1Mvs1eRBo=;
 b=fPjwUTdK6xpvkzw07fRSMw0ARdkRxouFetX9ABk2/rmv2dmptKurVaQkjXtnSE14fpEHzNm+F6NDNeJ1L43eqHT9QMGYZaTW0QUGlf9xzcoCeNmwtLLY9e7s1Ne2fN7FDEMwGcI7faYYrQ3h+zqU+KkLw9bSp0CJpkgmxxrq7jr6pHRb9Xlh+ui6C7PbWxPZoXyTNxTkiD2fzO8Fhs4SLVr6dUL8m8FSAO7BFz4VTuFg2dRyGzdme1wnRQ2zo5UFN9lZJ1EsRh1/krErhdrf0IX6qXRmxoBOorFvdHPergDS6E4CnkNmvk/kOAoGWU4UOdK37W+M2RLt9vztocUgnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5985.apcprd06.prod.outlook.com (2603:1096:101:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 09:33:42 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:33:42 +0000
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
Subject: [PATCH 05/19] cpufreq: imx6q: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 17:33:08 +0800
Message-Id: <20230712093322.37322-5-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 828dac23-1c83-48c5-ae2a-08db82bb14a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N8QG4E2UNPXTf8iA5eaHt9z5mloI1G4fSojelp6/AK2lZG587ksSyA8MYSREeUjspzaykzs/YfjbxBh6tScEmR0loNPUbbMw8c+zVrIAgsTWuTJa7DAELmqfx+ObCLBQFkhiNvS5Wuyw29O/rBaC7f0206sW9OrSzvvwZFrp/Nu9RiQWbcCS/XoYfvYRorQLt808QvYg7GyfJ/VEQkIXptOA1VuVywIDiue7KrlegwzqruGDyoUnJq6Rgjn9RzJy4gt6WWDueG5AN7DZoii7OPGtvVlIjjb79o2IzA+NMu1KF7pv7aw6IiuLVFdhqdaIfHNqPN80p7hJGbZdu2cgLK4xtRCxU3Sp3NcxY3IPmSRGOJztMmtcInxkOALt7nlLHIAI0FQ1DisMWKC22sDoAtceIeIJt+A0FpS5zlAFXsCeIS/iv4h1o4g9kGzzT5TECiVIIU9vtzlpZFB7CAx7Q9G0S91crdvTEs4O+j7XUZjB3/vn8r0Vydty09sFstJQtrT/KcyZGxt9Mlf89muP4OvjSn3fPcSvTkdKb0/iDg1jA36LGmGuPVNCl4cyASWNnqWboHGtwbeYIPqgYd6U0kL7r1C2UCk+uzD7SIVfR9wQwP87wvPSL9YczGU8s7Ks64T0a68PQSvHVmS5ZcS3oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(186003)(2616005)(110136005)(54906003)(38350700002)(38100700002)(5660300002)(8936002)(52116002)(6666004)(6486002)(86362001)(8676002)(478600001)(316002)(41300700001)(2906002)(4326008)(66476007)(66556008)(66946007)(7416002)(6506007)(83380400001)(26005)(1076003)(6512007)(36756003)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnVBemZGNHBTaWpTT3RvTXpKMklaOUoyWUdPcGpIZFQ0eVdhbUJwRmZJYnQ4?=
 =?utf-8?B?eDh2dlJxdzFBQjgwSllSV2t4OEF1K3ZZQWxSajhWdmU0M0VyQ2IydWxid1VG?=
 =?utf-8?B?MDVzOWdwNHlUbGlUeWM4MUN5UUpSOXdpeUJrZm4wbkJ2OUlEVFFEYUdkbnhn?=
 =?utf-8?B?b2xXQ3huUnFrd2tRSjVkVmViNndEZjlKY2dtUWZvZmlwVmpvSXB0dHJVTnhL?=
 =?utf-8?B?eU1iVk1DcDN4TXdHeXdTNFoxWUJveFh1N2RBNll3czNKVXl2YjZzSmcvOFI4?=
 =?utf-8?B?c1duZmtQV0I4bmMxdWhUaldQU1oyQXdxbVh2dno3U0R4QVVKNk9wTHhhY0Fn?=
 =?utf-8?B?NzRGdnJLUFNTOFVUWEFDRHZIUjJBZWFEbUFhVjZIUE40OWdONEVRa0hoUW8v?=
 =?utf-8?B?TkcwUE90dFFMdW1UOVZRdGdrTEFtQ2tZeU1JamE4Smw5eVJsZzU5R1FROGtn?=
 =?utf-8?B?V2YzeERBNzhNR1QwQjEzVjlZeVE2alp3MFRMYm4wdXZtb2FtMURTZnNpVXdp?=
 =?utf-8?B?Mm5VN1YrS01adHZCeWpvK1U0Rm9iUkEyekFRSUpCVTlpOXN1bk1SM3JpaFB3?=
 =?utf-8?B?cFh0YlJQbGJEQ21CdDVJQ1VIcmt2RDRmRFIxQit1Z0pUakpEUlJaLzhSYjVx?=
 =?utf-8?B?dVNsY21WSFh4R3dEOHlsOXBNRGR3TVBSbFlDZm9LaWRpRjBoM0NoT1ZNallv?=
 =?utf-8?B?QkVSeFpQMTVQdkE5V1pueG1QNTlIMFpnU3BReFI4L24rMytrd2VjcjluTTdX?=
 =?utf-8?B?Zmk2SVJBbHBiVUMzK2NRRE5aV042aXhQcm1YUGNFL1VONXYxTGhYSlBBcENs?=
 =?utf-8?B?bWtsVGpscXhFbDhlQzVGMzcxdTdnYkJnM2lUQnUxQzRncXE2b0dVdGwvOG1y?=
 =?utf-8?B?VllWOGxUSkswbUwxVVhTZi90VWhwMC9aVlUrN0ZRdm03MXEvYjVrTEoraDRk?=
 =?utf-8?B?ZjJscFZkeHF2bzc3djNhR3pKZ2Jib2tyckpna25icERwQzdCeGdLSnEyQWxO?=
 =?utf-8?B?SVorSXN5ZjBPeUtjUzZBaU1qZzZVQ0l1eGZjUlY2WVVzUkN0c2o4MjY4d2th?=
 =?utf-8?B?ZURMNkxnNk1lSHIxZUZxQWlkNllUT2ZsYzM4RVZwczVmK002MjhoL2dudDl3?=
 =?utf-8?B?aFdHc1VMejJVMk5mQ05IYngyNEhieDFUMjNGYUdCdlRNMlZhT1Qxdk1tNHg2?=
 =?utf-8?B?Q1YwOU94eHVvQUl4Y3FGekw0V3ZLclpnN1IrbXdxbTBReGZ3dHdVZXpxZjlH?=
 =?utf-8?B?bmZzS3BqLzJwa2dIeXhtUkhkdmVrUXFDVk1RT0RIcjdLc2I1bDMwZUNISDRI?=
 =?utf-8?B?MUt4NndQbEZDcU1ETktPNWZlQjZhdFNxQkE4QmtLd21DTHpRL0o1KzBDN0ZG?=
 =?utf-8?B?R1dCaS9JT0dWNVRZOENmSm8rUkVHS3FRQ3ZwQlQvd1hGek5idExpdnNGRkx3?=
 =?utf-8?B?cUQ1Y3lPbyswYS9EQjRuRkNRaTZwUGlnc3lFQWJTY1BMc0ZIV0RLa0tueG5n?=
 =?utf-8?B?aEFtdFpoaitzTW1KRm1FbUE3bDNIRTdSSmJ4TXl0dFUrUEY2RDIzQkVBcEp1?=
 =?utf-8?B?UUV1R3F4UHZYdnYzMkJFT29QTWEvSWd3MjlkYm1ockJaR29EL24ySVlNZG9K?=
 =?utf-8?B?RGJBOEZxUkh2U1FzeFFNeldtRFVBZjMwYmN5SXM2M2I3bS9RcmZ1aFRXcm5n?=
 =?utf-8?B?V1RyUEZTMXc2T0R4NlIwZXNORW1xck1vOGxGSjJINGdvTHAwWkhaTTBZTW9Q?=
 =?utf-8?B?MlN0M05HRm9DWHFDYlVhQUNWZE9BY0VwQnQwM2FPSnd6azQ4MDFrMEllTXcz?=
 =?utf-8?B?QTdyMk96ZjJ5ek9xRmhTcjhoekt4bjdhdWJIT0Raelo1OTFGbWJRZmE0emJU?=
 =?utf-8?B?RTRWY05jWkdRazhPdVhTVHpwSTRhYmlSeXI3eEtLTWROb3FFUTFNamVoSjcw?=
 =?utf-8?B?ME1Celk2NGNhQUVaOGFqYmJ5YnVQMVZlYyt1bXVIQWNXQkJyU3VFRjErcFBu?=
 =?utf-8?B?aXMzcUdrZk5CdGJDKzhGQzVzTlhsNDV1WUtVM0ErV285Qm5aTnhNN200Tzkv?=
 =?utf-8?B?ZlNsYzBUcXJ6YmZMZytLZHJkNGxpVFNIRndJejBSQStZM00vYkJNeEZiRk1r?=
 =?utf-8?Q?ZoyKPIUrqpd/QwDAJmqhFRO4z?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 828dac23-1c83-48c5-ae2a-08db82bb14a2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:33:42.1086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3nwZficnIyP9950uqvVOAwHzxAGjJBZnQ6PtCgQz2y9VDiWDo0CX8JN+rjRHfYwTvTCmKLu4P7yk2+bgXmCqJA==
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
 drivers/cpufreq/imx6q-cpufreq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 9fb1501033bb..494d044b9e72 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -519,7 +519,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx6q_cpufreq_remove(struct platform_device *pdev)
+static void imx6q_cpufreq_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&imx6q_cpufreq_driver);
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
@@ -530,8 +530,6 @@ static int imx6q_cpufreq_remove(struct platform_device *pdev)
 	regulator_put(soc_reg);
 
 	clk_bulk_put(num_clks, clks);
-
-	return 0;
 }
 
 static struct platform_driver imx6q_cpufreq_platdrv = {
@@ -539,7 +537,7 @@ static struct platform_driver imx6q_cpufreq_platdrv = {
 		.name	= "imx6q-cpufreq",
 	},
 	.probe		= imx6q_cpufreq_probe,
-	.remove		= imx6q_cpufreq_remove,
+	.remove_new	= imx6q_cpufreq_remove,
 };
 module_platform_driver(imx6q_cpufreq_platdrv);
 
-- 
2.39.0

