Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A9975033F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjGLJe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjGLJd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:33:57 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B2D1739;
        Wed, 12 Jul 2023 02:33:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFGleRb8uNlVyqMZ6BKA1zoYY4lsUeBH/JNXD0a4IuEvM9MDuXPoPYX+PRCqlS+vwhi6NyDGQzvMZM0AjlXaNOoIYN/uYY1kyzn2zg/nYRnIgyX4H7epais1PIqbakWo4hnSTA7c5FUwSuTE+9YMF1ertiilVhGR1MED9KZvVMxcWhXuXHDHG9EN2Recq1bwDYbaFAJOzXa2H3QzMPrBfO1MLDD/Bd/5yD9aeycIpRD8vCcnxN9r393oCaAvVkWHmWa/rwJA0D3sJiKfxeMGUgqp+NJ6kmqYPYL/ZB6zBNX9jltNsm3uAHk70bjaa/EQ2nL0pK8Q0DXtM1qulW/iWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cD12YVZGlHFVmTXoPA/7PJvtGDdpXVHEHm/asZT4mm0=;
 b=DtEnilNo1avqbFxPuP/ec34eNo6sGNxn+7XKNjv/NFoWHA5p6lQ/TbzLkZZs5pojtVv+oed1L4MVyKqwsApxEQ1bujiPirTHqv5jTL9KM6nSaGLZaexL+HrQivrTvQZKEckTYRgu6POMsqMRV6Ygtk2+yXhAoGe7HO3nbmBzMW5PAGu4vGpr3+e1MbwfhddDiufntsqL8OK6FTBCvto4vLPl4bIx6C8Ekd3kUiqJC1Xl/wulm7VfO0KNgFDaMV246Eh9K6lejakPGYGPSisFbLhmoblaJsRouqV+u8m305xQFFbU17f4JqiIzCz78POoK86qXh0SGd7wwblNGzuhiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cD12YVZGlHFVmTXoPA/7PJvtGDdpXVHEHm/asZT4mm0=;
 b=hlqnwzWi0j7Y5Qj/IW98RGAjrTBo7eKBru/zz7vf662yT5Vcp65g3JRDYVuG9QDIVIEzsUzBf54cQsboF//rN9GNu3EcWaf8mG6gt5Qa+6rAxaEHuDf3X/INs7+7i1h5KbLy+EtJBn9P4626s7f40EvueVO+MkMzQhd2/Ird15ubTwXS9pXBvRNfGj1zrTaWWuIBTArinfh35E9yqMrKVnszi36EJx2gWMMobP/civtQDjDBYWsGZobq9YUuCh53t08VI7x6DV6ky5T7VGsjoXoEXRGNjyUsxGsMkM8BWSbj6ClKESl/Gcm8rb9emarwx6cee1bK0AvgBrDzBAk5jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5985.apcprd06.prod.outlook.com (2603:1096:101:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 09:33:49 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:33:49 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/19] cpufreq: brcmstb-avs-cpufreq: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 17:33:12 +0800
Message-Id: <20230712093322.37322-9-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: dddc010a-4a7d-44f0-093e-08db82bb1903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IqmhE9j0prBPkrJr73HKHAE9JudXx7w9QPIcRq4r+E/ScDzaehyMHE3vd/rUGPJVODbRUMEXsE0FaJlpUQnJNsQ6b088wRz7RXHqcGAdLeoPplkAeSfZU9HqYTt+UfmmrBlT9Q42N61knssL0Klf1As4lQNeG1MYqbgPdvO3FlybWjDwuSFbOSG+UUsOpxXwibRYucLBph+xiStB+HFQBEBaIn88mtWNUJAG+WPeRbh6jnQOHutzQ5lyT4ZIsXyy7N+Bb9hKRBMWX4Fwk1il7yy3ZA3V/iSaoYowrzX/GudD1DlFYNmLfyH7WzzYHU1zhN04U2IhgFyyrt6B6ihWuVmtv56jdZsoDcE/K1tJ5okbdku8+7Jpn9NGtTLXqZ8cQgSb2hhY8qpIcIhxZCO+rT3d95jJjOngB3jilfaYT23fG2zWKzmxR+QeunN6Vyc74QiYgnm8v6OxgVf+n/SXHXn44idgoM8CFzTSUNWNiHON2ngZPhlfYMfveeMq30xoXtJ/WAA9N7cOL9tdc0hQVWB5HtuY62jDs8FzSj3jrMb9jylfaDMJBrJv/05qr67p4arGxQKPwAtqex1YBIvuGqahVytDwiEkKsOBWF2r2TcdfBclY0u9JpC8gz1t3Apl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(186003)(2616005)(110136005)(54906003)(38350700002)(38100700002)(5660300002)(8936002)(52116002)(6666004)(6486002)(86362001)(8676002)(478600001)(316002)(41300700001)(2906002)(4326008)(66476007)(66556008)(66946007)(6506007)(83380400001)(26005)(1076003)(6512007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXZ0bTZiRnk4TGdkcnkvVlJDbVl0RVZIVU92VUNuQmRtR3NmbkJrY1ZvNXow?=
 =?utf-8?B?bmRZZS9nVVZYaSt5TWlXdlZSdnlaeGtFTTBTb0t2NUNGNXkzUGI4WG1xcEdz?=
 =?utf-8?B?eWRRUk5kVUpVaEI0bTRJNjRXak85NER0S1dmVHRSUU1teW8zaVIxY3BoczM0?=
 =?utf-8?B?MGxGNTIxY0lrVzJZMkRRM3FHRjhQNFZHbnBpMlQvaExKRjJVQVhxU3R2U3po?=
 =?utf-8?B?Ni9ibVQzSGR3Z0ExRFBmOFYxM2p1Yk9sWno4NUxJb3NWeDFZZUEyTkdaUkMv?=
 =?utf-8?B?cHU4MG5SZW5vWEhYUktEMVByV0xWNHMvOGVJK2dYSmZpUmxzcTFvaDBkS1Rx?=
 =?utf-8?B?NU9ZQ0NucHV3YURXYmRON3pSdGI5c0UxRG9LQlIrWWl5S21HazdZZmtVbjly?=
 =?utf-8?B?cHg5S1NPRlFuVEg2czRYRUhoazR2QVlCSDNBak92N1FJV0E2L3lQSzFDNHBX?=
 =?utf-8?B?eTUwZ1I1L2thSHZNWjYxSm03TERlV1pZV2R5VHRucUIza3ptUTFLNTErelNY?=
 =?utf-8?B?aHo0d0tXem5WNUQyMmUwQlZDamdDd2dQendoTklLR1pvTHp2MGI4dGRrb2tk?=
 =?utf-8?B?azlMa3M0SEY4K3d3QzM3Rit3OC82NWd6cnc5Z1MvTXdtMHJXNGMvcnJvYXQ0?=
 =?utf-8?B?SFFPTTVQWGxLQUFXeGQvbHdhK3U3eTM2ZEdXK1cxcTQwMkpnV0F1QXl2anR6?=
 =?utf-8?B?UUx5dmpaRjdJYUNDZ2J2ejZpMlg5eWJXM2xmazRJcXFMYWVaemc2OUZyRUlV?=
 =?utf-8?B?VzlWd0dIYXdDTXRzSzJtRDBKWS9sUEEwVHMwMTl1dk02WTd6cExtOU82RkhL?=
 =?utf-8?B?Mk50dUhBdWdFR3lreVdsSUZHR1VWOWhqRXoyc0tJWXZkQ2pFa3FGZk9veFRv?=
 =?utf-8?B?QWZQeW5Ga1lleEVaZEVrUDhsc0NkMXFqaWZjcDRaNGMxRXBLL2syRG5xUHRH?=
 =?utf-8?B?TUk4WnFPcFp2SjB5QTB3MlhlT2xlQnhpUXp0L0JjOWJodk9TSzh0Ym5aUW8z?=
 =?utf-8?B?MUdXajlpMndzaW9Rdks0WVVuNURVaWVOUUN1Rjh1T0Y5MjhGbDFUQytWeDl1?=
 =?utf-8?B?U3duRTdMS3pkLzZQS3FVc3NQNFZobGNmMkZ3OHdsdW1Ua0NQbE5odGtUdnNx?=
 =?utf-8?B?MVRuU0NMNlRzNGFJbTBmOG0yN0ZReVpTalJQbzQ5Nkc5OHhHU2RjeTVSRXJm?=
 =?utf-8?B?T1lxb0kxcGpEemJsazNaSXVOSmdxNEhxbEZ2T1ZtdW1MUkl1aTRpVHRIUkpC?=
 =?utf-8?B?TDhiZTdLU2dac3pYSE1aUlRFcmtPYTlFcFQrUmd5dVE4cFFhL1RwZkoxWG1F?=
 =?utf-8?B?amVPUUd5UTJUQ1dZK3R1MlU0UnVjMGxiZWF0U1crWHk0a29oTW9UVVFENnpM?=
 =?utf-8?B?RWR3czFrbVlXMWptTTRqRHpBY0VQV2padUxLUTVDWkdSUFh5YmdyTXFzRXJB?=
 =?utf-8?B?MnMvaWRJdkhRZk9VM2NOR1FJQnRhcWxhSmJ1Y2hialQzbVVIcWZBcU54R2NP?=
 =?utf-8?B?bWs1SnJlOFhpbTE2ekE2ZFc4b0hXUk9aVmxPUkVONzBMZldvUnZxU2FpVXlZ?=
 =?utf-8?B?RzZTazV5T29lNk51aVdaNGdTOWJjL24vRkFGa09qUTcyR2ZxR0tQdThLalAx?=
 =?utf-8?B?akRSY3NHdk9MV1hOaFE4UVZZQW4vSUxlckpYSklLdzArZXI1VmxhL3lRU0ZP?=
 =?utf-8?B?a0hyNDBwRS9KbkZTcDl3UHZZUllUbkRnZmozdEF1TGluanNDcGtsQTc4a2c4?=
 =?utf-8?B?VVpMTXR5T0ozUDBlQjhVcFNDNDkzTGlpc2UvMExERjVreW1lNmM2MG0vRTJh?=
 =?utf-8?B?a3IxYjVqdHB6a1lvb052RWdIbmFaYUFPZUhiNHRvRDl3LzlGbUN3eFZjUCtW?=
 =?utf-8?B?YmpSUGkyQjFJMDI1NmUydVorZDRNTXZNaXdkT2ppRTBXVS91M2NOWllIUVN1?=
 =?utf-8?B?Y1BqaEdGb3JNZVdrbnE1aVBZK2h0NnF3dGVBWGVpSHdkWTIrRDVXVTQ1RnNO?=
 =?utf-8?B?UmpkU3V5a0xkcEhONW82ZHNoTDM1TXdVWkNqckx5RFBmcmlZNDZkT1ZtVkpp?=
 =?utf-8?B?UzA0L3JvTEltbzZMMXpJTlFVZmRKVVRvTFlCL3owZk5pa1V1VEtRdlRMR3pG?=
 =?utf-8?Q?DCQaKdYabX04VH4DGo169mA15?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dddc010a-4a7d-44f0-093e-08db82bb1903
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:33:49.4543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/IMmw7L285JUbyFiesPCPBj348BWrbuRxHDXd3/QLPRs0Uq6Zb7y27GJ23Y7e8sWwDfiX1YO1GF9aY9X5f5FQ==
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
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index ffea6402189d..1bdd513bcd19 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -749,13 +749,11 @@ static int brcm_avs_cpufreq_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int brcm_avs_cpufreq_remove(struct platform_device *pdev)
+static void brcm_avs_cpufreq_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&brcm_avs_driver);
 
 	brcm_avs_prepare_uninit(pdev);
-
-	return 0;
 }
 
 static const struct of_device_id brcm_avs_cpufreq_match[] = {
@@ -770,7 +768,7 @@ static struct platform_driver brcm_avs_cpufreq_platdrv = {
 		.of_match_table = brcm_avs_cpufreq_match,
 	},
 	.probe		= brcm_avs_cpufreq_probe,
-	.remove		= brcm_avs_cpufreq_remove,
+	.remove_new	= brcm_avs_cpufreq_remove,
 };
 module_platform_driver(brcm_avs_cpufreq_platdrv);
 
-- 
2.39.0

