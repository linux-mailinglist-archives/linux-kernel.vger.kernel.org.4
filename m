Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C91975033B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjGLJeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbjGLJdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:33:49 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87941A8;
        Wed, 12 Jul 2023 02:33:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfMtvB+5Qf4K+QLrWpDTRb0JMcdarprZEewLK6dSTHwbF8M4OBOW+E244Ta1TB/HF9ovSPIbwnIr0BupHgILdDj/IJKR754DEDnrZXjAiLJc2giCKdasa/jO3Fj3yd0nfBr9K+5/bTtM66cu/EatqLGv9UxjER45vYIySjg7VYcjsxj51OeQhO5ICRYlTnGCFrJd/HBfyLP2o/8HM561IcCOaf5WTlIahuHdtvtPy397rSojiZrstG8C13uaBX00BSPrImIBE7Y+x22HXhep2E8BsVuXa//BttwDpRGocf4j3qtcjHqjGqHRYsDXUZ4e6/RvgCnxfnJdG/8sCfNEwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqT61dVoVAjIMQ4tirzFDt2GGKS7bnlhSrtMFE0j2EE=;
 b=eBSKq6qTlee+QE0mCvSY3ErxOososbsqDBuReMRVHpbqyme5LthfhFNdNoMdfQ5irXpMdDkikp//18DOqOmDo0q4+3Oy8pZJMOfQSvqjqabp86BPb5GEbG438P5hBfjfGowkLRlmu6QtgV/MHr2Hhox/s6FbEPLVRlPWxMwAw37ult4bHsu8rzrF7yYW9Yk7yaRKSE23p8KOlXzCESwMKYPs4QjHiFfiO/DtEWSsfju2F0m4ts7NTvaeRn13US3FahaxyLovPcNCOn+p0LxlPuFc9nN2Ynis0SScJtPSr5wz82OkoLqN1yuHktl/HaBeiTYOUsvg9LLHa/nE+appyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqT61dVoVAjIMQ4tirzFDt2GGKS7bnlhSrtMFE0j2EE=;
 b=gzDZm7ghehIvYvzXwGjbU7nkhumWoem4AeMu7RtrqdLXN8ihIQT8+sOvWQCBnxSpixWv7QpNWAdKGon+mc42ZsuKdh219rKgQo461Vhikcv0mdOCH/3ROk8iDt8tS0Kz5+z2Q9YPT09t4muc7q3PyT7TGuss6e1VbgqQEOc97r17MKCvOyFSjEQEQs1s1dGw2HpPzGdwtDFrsjHyS+0UBKmNgkJ8lr1DpHcGCNjcu7k6r1CI2Pcmo44dFIlU9ZsUJCx8GTek4fy06qMwKbmOdW2g1qV4sxmuipsNtRQWJ1vXC4gv9pshlHs6as+Hwh9kjpo8pm6T+Sd5XMuc2NmwoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5985.apcprd06.prod.outlook.com (2603:1096:101:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 09:33:44 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:33:44 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 06/19] cpufreq: mediatek-hw: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 17:33:09 +0800
Message-Id: <20230712093322.37322-6-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2d745619-8c11-483b-1cc5-08db82bb15c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u18YQH7PdgFaMzcIQ7cGGKfWilJmeX/OfjjwWtCDpsZYADxuwUCWEsGVEmFdWjnibCmCCvWRK3A8H8dWZNv3ul2hIr+0DTNe7EhePtoUCYfebdqtqLYxg1po8c21b1w9Yo9S+wt+mSacJw3cOYtf7iMNSj1T9L5Vr7a3oX8vQJ8sNbRWj4p1LgqKxMHneyEsOk3XXqozVNMo6HjkdLqPoZ9UdQfo48n0J0xfWBrYrCTrvAzCaHAx7VLKVDJuXKgJnWfFPUOFfprrZeIwSGRT4Hk4eJqy+qy1kEwVSICQSZmxF14aQwaAQNFlHRZHizg/h5dJjIIFgRZAxLcEwqu+Q1yvNcvUAmO0cRQu0SdiE5P1vFKfLtolg+73NnXwpsqeba+BEnuL0+bxubUWOR8mMS49vaLe/GUmE2LF/+tLRu6ggVmxW6Ow5vDugXBowWne2UNLynddWNcIRFU2XI65hH7VzjvSaS/K046HD0fr4GEFIJ6SOZpQS5UxI7oXedcG9TFBwLd7EFabI/MZjSifEtgIBb6RpWXBwuyQCuMSu6UTI+zJL00/HO6TFdD0I9TL5VoXilhz5NdFok/uoIlNIS3/x5aBFIt7T2QQQpOnOUpD2s9YP6BU1kd/xWHSusae
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(186003)(2616005)(110136005)(54906003)(38350700002)(38100700002)(5660300002)(8936002)(52116002)(6666004)(6486002)(86362001)(8676002)(478600001)(316002)(41300700001)(2906002)(4326008)(66476007)(66556008)(66946007)(6506007)(83380400001)(26005)(1076003)(6512007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTVHNDNSSHFxZFFseEJmYnJUQm1xaTNQdHJJSCtGeHRqZzJtaTdtd2ZKZUNS?=
 =?utf-8?B?ZWtzeGI5NFU0UytvMzhWM1lhdzViRi9xQlBIdEI4VXR2YkxVVTNtM1lsLzJO?=
 =?utf-8?B?alQ1SCtOVEZjUy9zK2cyT09PY0MrSHJ3ZkZqNUwwRHVVcHJERmpMQmJaZDFS?=
 =?utf-8?B?NXdWZktHa21HbFdPUWN0L2JEMk9TRER2WlN5bEx2SVUrdDFhRUlib24vdFVt?=
 =?utf-8?B?Skg1anVuTFIyaWhDT1prQ1JtNnJrcEtvaFltTDJhdTNBRzlvNkdBODY0QUo3?=
 =?utf-8?B?Q0VtOHlZODBXQzRVczBTdEplb0FWRGpSMGZ5OG1rL3AwUFhPL2VJcGVxcHpJ?=
 =?utf-8?B?VTVBczRTUEFtNlJMWGU4TkM2R1JqWGlTN0ZIelNHcE9La0t6V3gwT2dlUTB1?=
 =?utf-8?B?QVRDVHBtNmhkUktUbFlGRnREYkZUV1lLVUZOTTkzOFplYWE2VjQzZTBGRXln?=
 =?utf-8?B?alJqU2dhbGRBOFFseDB6YWpqU3VGenpRTFM4VnN6Z0NDY2t0dE5nMkxMRUQ4?=
 =?utf-8?B?bHFLQkkvNWVsOFJyRGo5NTZjSGhTeGUxT2wrRHVRZWRUdzR2WkVyU2NWSEZ3?=
 =?utf-8?B?S1E4L2hQckRTSHNNMXBwUzA1SEdsZ3N2b0s1KzkxOTZjVDNGaU56WTRmWk5C?=
 =?utf-8?B?SnJuVmJFTXBzcytLWHFHeUowb0EwTlYwUWFFMzd5VDdydVFlQVBRbko4aXd6?=
 =?utf-8?B?NFV2b1dMd0VodVozSHJzQW5tUFI3ZFFyL2tmVEJzOFgvU3owMHV1RDFSekZ0?=
 =?utf-8?B?Q2c5Q05Xc0h1cjRTMThwdU55cG9SV0h6eHVIWHRDQzgwdlZkQTdRSkJGaEln?=
 =?utf-8?B?ZFZtd0M0cTRpcFlOQ0tBSWsxdHY4YnRwVitvakZ1RWFiYjVzQktnK2FidGZl?=
 =?utf-8?B?YWF5NWpRRks3bFZhdjQrcXBsKzVsWnM0NEcyUXd6TDNpWk5LTzl2a0dLb3Fu?=
 =?utf-8?B?SFhFRExvVFArVTFjYzJqNHFaOUZPTmxWVEZZTC9QaDUvS2VueHVSNWN4dG5P?=
 =?utf-8?B?cWxiNzdwck5MNGxEK1hFanNBV1BVQmtmdDVkc0lTbEhZSGZhVUdYVjFYaXhn?=
 =?utf-8?B?QTgvZHYzVXA2MnloNk9IU3FBMTlpcWdVZGdsemZUckVFQzVKVXNLZ0ZLd2o0?=
 =?utf-8?B?R2xLT3VWVmJ1c21aQW90TEZYS1RLZHFiQ21lSXg3aFd4Qng2UFNtOE5wWFVV?=
 =?utf-8?B?TUdqL0pLdDFEcjdmazhwMHJPWGxXVFdGenQydWxJUm9nayswZGcxZmhmZXA3?=
 =?utf-8?B?YmxybHZqM0VQMnJESnNCOGZ4b2NpeXJHNktxSHQ1TjZSNUdyZGJEbTg2Q0xQ?=
 =?utf-8?B?SXlKdTUyeWkvb0JlZGUxREw3c0RUSTFyaDlKdHBQSE1zU0ZueGNRZDlqOTdn?=
 =?utf-8?B?dXU3VjQrTkpieWNUR1FRY3lRQTlNWERudS9PbzM3aVdDVkd2NDg3VXVBdlVG?=
 =?utf-8?B?Wm42aklnT0d1WnRpMnptZm1NaTZXN1E0RnJsaTRCMFV2Y3lqeERWOTJVTk9i?=
 =?utf-8?B?RzJFbDJtbWR6SURKRzU0Z3JKNGZkcDhieVd6ZE9rZ3Y2M1M0RFJHNTE4bEd0?=
 =?utf-8?B?OWFpdlppSmZoclB2WTk0WWwyNWVheTRYWnlBN21vRktBYUw0SUNBVEZaWWVk?=
 =?utf-8?B?aHNDNEpVOXlsZXI2dHFaSy9nQndtNGt6c3NWNzYxdyt0TjYwOVprRExLcDV4?=
 =?utf-8?B?WVhjRGdMSHZHTUMrK3VZZDNGZDZyczhESm15RncwNVl4dFRFajdZb3dUNndS?=
 =?utf-8?B?UktqWE9zbFpUUzA3eWVuaGZCREdlbCtNdU53RTF5Z1NsNzB1cTZTM0ZiL1M4?=
 =?utf-8?B?TE5NM2tkdzAxS0F2bTlRQjNNOVN4SG9VVGFqR1JjYWN0T3I0bythdTVKK2xG?=
 =?utf-8?B?b0xrbng1ZlVzUXhRdFJaTWc4Ym1jUUpRSWEvNmh5TXBtdHhkbStVbWdveTNa?=
 =?utf-8?B?MHVKL3YrcW9kK2k1YkRvcTdCRWFzaGlPa21WSlk1dzFXNXlNMzZQZllvMXdD?=
 =?utf-8?B?R1R5emc3RnplSERtcmFSaURRamQ4aTM4SS85VmNYd3FIbnZsTEFyU1hpZ09a?=
 =?utf-8?B?SFR3UElFSmJUK3VwcUZ4blBmYUlJUUQwcVhHd0g1N1R4RFVNUmJvWjNwUUt4?=
 =?utf-8?Q?ocT/UQxYCFqPHmqtHQjMLQf8v?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d745619-8c11-483b-1cc5-08db82bb15c3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:33:44.0088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hPIloeMBL7jzwWCB/nvSagxLY7CuQPps6nUFHLESPoyq9RTHXU3y94Xc9sOAxGbu4HOCcSKTQpnzNCta7eEnxA==
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
 drivers/cpufreq/mediatek-cpufreq-hw.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index b22f5cc8a463..062250192f42 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -315,11 +315,9 @@ static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mtk_cpufreq_hw_driver_remove(struct platform_device *pdev)
+static void mtk_cpufreq_hw_driver_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&cpufreq_mtk_hw_driver);
-
-	return 0;
 }
 
 static const struct of_device_id mtk_cpufreq_hw_match[] = {
@@ -330,7 +328,7 @@ MODULE_DEVICE_TABLE(of, mtk_cpufreq_hw_match);
 
 static struct platform_driver mtk_cpufreq_hw_driver = {
 	.probe = mtk_cpufreq_hw_driver_probe,
-	.remove = mtk_cpufreq_hw_driver_remove,
+	.remove_new = mtk_cpufreq_hw_driver_remove,
 	.driver = {
 		.name = "mtk-cpufreq-hw",
 		.of_match_table = mtk_cpufreq_hw_match,
-- 
2.39.0

