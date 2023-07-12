Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB00750368
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjGLJkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjGLJke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:40:34 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2090.outbound.protection.outlook.com [40.107.255.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A181717;
        Wed, 12 Jul 2023 02:40:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnF8axngaBe3uWYaGW54QyaT/vr8cORlLigovz+/mI0N/4n+kbUuXfcOZjHLPlX7qTn2IoUmxs7/fPdMzSdtg08BHJSZL1v35OaYPpY3N2U4Q3AXR364Ky2aqoD7QVcQeumiPgni2ZcaFsaouaCg63hWZ2Ipvm0euHzZgmmsv/cewd3EN7aWNTM5wF1yV78Pyol0RKTdLJBVjQBM5cVTtbJtzAcyczwXGZbK9MFLdeMftjwHugv+SBL/ItRNwfztAx6nvLrLXBZ+307HED+LkDlk4+B1mqlFoxOToyufmckOBBBpzmRA1ak5340N2gpO7Clusb7dzxWyRSY9kICOag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nnL6FiV6pbFEm7FrHnb/OvpyUz5yV9y/akirUEhRAg=;
 b=dM2iW9TtWRcJVb4/dlKY0gQMfdL3LMSqSCp8m5Dvc5kpuGufPhMUwgfiY0H1IA2zsIfyaQQJ8dq0b6K+/KN+TtnPGgXVP+eE58IyA3E6HfAR2XERd2q+MWPwvFkF8vT4OqxZrr/gsgNpq+183VWNVZiqJr3kqOT3vty0Q56wHeOmatibD77UhBz4KyIEVkWJpPDVgsIt9RFPw9vfuJONVtwQXWznv9TpKRraSueQuSWch/aLtE2pocSIfFB7WBK2JUYEmCzIMgYbAsYNAV+PaatrSJNklKPe20OJVnYSimpDYN7Zkz90EvIlyF0QWByIV3uai3imtF5M8vLOa0surw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nnL6FiV6pbFEm7FrHnb/OvpyUz5yV9y/akirUEhRAg=;
 b=qeF/QwALCOfu8bm17rjE+uISRm0c8hCvsE63fGRDb2WXAx3CZyg8qbuLHZA/l3FUzSIN78KD5jOjFgG2WPxsJPWD59vfxf/At64FhPf8IxFUwRJyUoA0ltFj5OTdPYF8nt2HcjtsWAWotN5kodAo/QFjsosOzgGmMQjzcgtTOUDjPF/eYrHsLRJD5RCKU7SZEU7b1CMOA+P0TurOfwQCYbJm78HWa5i62sH9DpwO6Vo9zgI11U5cmwiXii/Tm8Usmj1duS8ZSB14NLJJqGFlT69xVLpqX4sTnN0jSo3hGPwoZo43kPcGjWhmVTLEfhoYwKRvi7ac+bqFH/P9CZNP8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4524.apcprd06.prod.outlook.com (2603:1096:4:13b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 09:40:25 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:40:25 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpuidle: kirkwood: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 17:40:13 +0800
Message-Id: <20230712094014.41787-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0211.apcprd04.prod.outlook.com
 (2603:1096:4:187::19) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4524:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb4b997-b3e4-4c8e-1561-08db82bc04d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WWd7YaWNvln2pt0jhoOhxi0QL96BCYwcOiCG0Drjg1wb5RnF5DroYuWIVB7wTuy5M+Bb4NSk5/PEDYxza5CSMGd/g4WHqa8UWYpJ7+v7OZmWU6zTCh0JjE6cz0qC1y9Wwp6oMbHW6RYdAM46IEYnHyrYdOPzxGap2S/awJ/WPCaH5Yk5b+SQTiuka7ZlAyHfpCyRi24JawEZPBtVyF21ATvdRttmGxOaIgdGLiEtSrOu3Q67a/C7a5aEvUx+hG/HIwA5l3tazTE33oXcZfDnWRwAFD2Sod6EWzwfcH76lIU773LhQlhb7LEfCkZE5o+LhDuq3IflehEjfElVbGq+ePBc6500gaKZLQ6caFzr1CxpDSBbYxb03GUt9w4QnOpo0NRDe+toc/x3yWkwBrHPkpIkIZaYXFvCzvoZmneh9NaEAkG9COJpoI86lDw5JfoVewLihNlK/RENwB12jYTuEVwcbp1ehuCye9Ux5c2WM7pOjRfNTXLrSmCGB5TAngGL8CPSAwwFA/tSh3l5x+e5GQjfJ43yH8Kkh1NB/PcoGvtd7xmzRstSpsGMa1yTnAvIIMsvXRguJj6JYyYSy+Hx6xkEwJnLz1siZ0j4muqD5teAa2RBZn751sku0Tmc2pgP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199021)(478600001)(186003)(6506007)(86362001)(26005)(1076003)(5660300002)(8936002)(8676002)(41300700001)(6486002)(38100700002)(66556008)(66476007)(4326008)(6666004)(66946007)(38350700002)(2906002)(83380400001)(36756003)(2616005)(110136005)(54906003)(316002)(6512007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGV3TjA0MWVoK2kvSndUQWp1YWRPZzlka0QwRDROazRCZ1V6VllyV2xDWVUw?=
 =?utf-8?B?Qk1qR3BRbzhIa1ViZ0lMcVhMd25mNUtKekFoTVlxd3JXaDVwcEhLaXZ6Ym1C?=
 =?utf-8?B?WGZ4WFZJV1JyeEhLQ21icEhtWHBBSXFvRHJtZWxjZm0xWGVBQTRnaklCMmdD?=
 =?utf-8?B?dm4walBrL2F5WXMyaE1MRHV1U21LSlVySVJwZE1mZ0M2ZVVFdkpDWS9vQXRD?=
 =?utf-8?B?Vlh1S25lRDlYM1Fxd3A0cFRtMXNhVmYrWWZFb25wQUtGOW43aDJYNDFiUFA1?=
 =?utf-8?B?ZXNJaGV1eThtMFU1RHlsVGJlNWpodXhjcytEYjhLSi8zczhKMDZwUWpHempG?=
 =?utf-8?B?L0hJK1lnZURMTjdwRmNYUS8xNHRldkZvOWYyZ2dqZ0I1U09SVGlSZGtCaHZE?=
 =?utf-8?B?MG9yUHpMbGZtWHZIVW5oemhtZzRVaWxuT0VkbmFSZHpqcGlrYW5IQWVXRFBB?=
 =?utf-8?B?NmJXaFFiRkRyWjF4Q1lXaTdJcHR5SjJnbzltWm53OEFEVm9pV29ZSDZhWENx?=
 =?utf-8?B?ZDJjK1haRnh3dEhDWHk3OW5lZDNmL1NSaDdxcWxwU3VHRGdMcHRyNlF6Q3Nx?=
 =?utf-8?B?a3N3aTRNYkxyL0dGaUZKQlZVTmgxSXYzSmc4N2hLWGVudEsxVU1Vb2E1aEk0?=
 =?utf-8?B?YllUK0xUd2tTNmd6VnVUYWJQeWxqL0tIUkI2enhmN2E4OXIzTlkyZldTMjNr?=
 =?utf-8?B?NWdMam96VHNXV0NiNXpVZy9obWpSalpydktuMHREdUxrajFVMXAwZGswNklo?=
 =?utf-8?B?cUJUL05Ga0h6d2xnbEpERnpnckJXZXYrYlBwYmlmdDlqdDg3ZHN6aU5YQm5X?=
 =?utf-8?B?T3NMRTM5ZVBiMDExQ093MTJuM1BHRDJKR1RIOGJSbFNQTUJCaVJsNytBR01h?=
 =?utf-8?B?OVluRUpqOW5CVG5MUDU4RUJzaFhONkZIb21DUTU3TTFPQm02QkhDYVhudHV1?=
 =?utf-8?B?OUpCL3hmL1BDaVRVVkVuUVkzdmgreE9TK3NDNVJmaWNrMXZYYjNlQythazZs?=
 =?utf-8?B?eDZyMjhSYlN4WTYybWdGOGp6a2gxTExMcmxXUy9qbisyQnFLeTg4eEFkZGQ4?=
 =?utf-8?B?WmVXRVFDYVhuSE9sVkxqdDlkWGY5bCtkaGFRZE9GVXVvWXBYeVlZREpURW9j?=
 =?utf-8?B?S1RJUW1ZVnA0RXExcWpsSjc1Z2NEazkrbUMyVGZYcUhUWlZUbGowUG5sODZk?=
 =?utf-8?B?TW1uQTJtRnJURXQrTDlyVUR6cU5sV2JMbGU2TXdXbkZZbzlCOC8rckM5czNI?=
 =?utf-8?B?SGh3N0VGa3hDMlUveHJvN045TW1HNzd1VGhlcEdKT0U5Y3VuUU5IL0psbnc4?=
 =?utf-8?B?WnZOcm1QRTdwOFVGK3k1TndiQXI4enRWM2srUG1mUTNIb1JTZmtIaWttU2tT?=
 =?utf-8?B?bURUc3hOMmVCcCtGVnNlbU1mY1c3MC8xUXB6bXREUVpnTGo1UHZLVGpLMHdZ?=
 =?utf-8?B?d25OZ0w0eWZobEpjaFVpZVp2Vld4azF6NTlDSjMxT01zMFJOUjBjYjV3Q2pu?=
 =?utf-8?B?ZHNSeCsxd0hSNVU5YU1WemhTN1MramJJaWNwM0NyVzBIdW8raWRDRzV1aHhD?=
 =?utf-8?B?djNnVHlVWnErMnVMR2xLK3MwY0RRRlkybzQ4T3ZtcTRSZ29WaGhDWVpXK3Ja?=
 =?utf-8?B?SEhXWDJLZ0U3T1J0WkhDbkREYVU4dkdUdk1mbWZiMk9INHFubjd6U0dwU1la?=
 =?utf-8?B?cXBDNXV3UFI0a0k3OGRhelpPRzVSZXl3UHRtYXd2ejRlK3ZzY0IxVHkvT09t?=
 =?utf-8?B?RHVCb0ppMEZNMy9wTmxJbnJEaXNVMmFIOXNXL0JRZHVaMSs2dW5kdmhNUm9U?=
 =?utf-8?B?TnV4M1F5aW1WQ09yOCs2SUt6aFdjL3hhOU9YdTJOaFZSbDNwN2dkODVuQklL?=
 =?utf-8?B?cFo3U1R6MG1QSHgrKzk0bzJESlBCV0ZuY25JcGhGcFo0dXpQcjZLT0x0ZWha?=
 =?utf-8?B?VnFrdWxVU3ZvdXVXQXA1cE9SYW1qYjZQaXo4bXB2ZHg2REYvS1QrdXRIY1RX?=
 =?utf-8?B?OUkyS0RBL3JhNFh0V0x5Q2pLRkYxdGMraWQ3ZS94ckVHZVYxMzVRTm8wamVx?=
 =?utf-8?B?SGRqc0pZb1Q0RU1KSEdnYXduOG9uY29jQVE1UEJITTNPTHRvYzhidm5DSk5j?=
 =?utf-8?Q?B8FCyIQgJGfmgczVZknLdXF5k?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb4b997-b3e4-4c8e-1561-08db82bc04d8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:40:25.1251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gzdm7J9tj6n16OGbqVGLgnn1sdJtgUIRU8pGLXTLCETxGvFUdLXhq9sLWzxOJwTS9aBZbfJrO8cGuxliOtKgsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4524
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
 drivers/cpuidle/cpuidle-kirkwood.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-kirkwood.c b/drivers/cpuidle/cpuidle-kirkwood.c
index 13bf743f885b..602c4dfdd7e2 100644
--- a/drivers/cpuidle/cpuidle-kirkwood.c
+++ b/drivers/cpuidle/cpuidle-kirkwood.c
@@ -59,15 +59,14 @@ static int kirkwood_cpuidle_probe(struct platform_device *pdev)
 	return cpuidle_register(&kirkwood_idle_driver, NULL);
 }
 
-static int kirkwood_cpuidle_remove(struct platform_device *pdev)
+static void kirkwood_cpuidle_remove(struct platform_device *pdev)
 {
 	cpuidle_unregister(&kirkwood_idle_driver);
-	return 0;
 }
 
 static struct platform_driver kirkwood_cpuidle_driver = {
 	.probe = kirkwood_cpuidle_probe,
-	.remove = kirkwood_cpuidle_remove,
+	.remove_new = kirkwood_cpuidle_remove,
 	.driver = {
 		   .name = "kirkwood_cpuidle",
 		   },
-- 
2.39.0

