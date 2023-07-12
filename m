Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE207500F8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjGLIOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjGLIOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:14:08 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2116.outbound.protection.outlook.com [40.107.215.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47E01739;
        Wed, 12 Jul 2023 01:14:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HS2QW00QTnkIib3q47e6BEL5w9cKAMlJ6j05+moV4NnMYyWD8ZWlmBDL7d4000+6xOIAGcAR6nY2zaxOQxNfi9sk5d7h+ONvgefTdwnkfJC8LbUE6oPUVrbjqy/XLUQoFDuInKihtXz/ll9CshnpzdkWbgMB5TLARUnjlokPElpFU/7lNpMlerMrA97bphZYGc5urc+M8f5sEWqNKrpQrgNxCgZr6oRs/5bEG1mdOANq08bwJYY/NhrnKC+xa3ZdIyjpO8flYd+B/TmZMjUao3qfS3ZHsaaq2WJBrbT7xwBAG6Yq3//Hh1Sjs/xLycGa244IxfgYygo5EJNN8ZyIxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9JmYrx0NP1LgLO3UWT+h7gQiXj9+NS7xepB2bMhlis=;
 b=nVu33hVrGml95nUSeRo5OM9dH7VqoGfutlX2iwlQX+LJZ3Q8qQ2gUU9gVJKzZYBSUrFbV32pQkJ5mJaKRIE6LxNDDaiNTDLm/u9ymXSYbrWvTCORM7Ga/Zc7/ncwi4s90mUiWj+8bgI+L/k4VtZYjZUju8uxE56yRN8zvW04vAPPFpzW4jhmowAWlhYfkj+WC9+8TN8AYCIJBZSR2eDUEIJ7f4vdvId+2mffioPd9pT75Qc5jZwiHpD7zk4KJ66w50GQOjtRjyKSTPqGnpZrpCWY25zXDqTFqkRENCOtdnljHE4akN7G3oM1M2uQS4t0BE6zMveNhx6rETTb26PFXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9JmYrx0NP1LgLO3UWT+h7gQiXj9+NS7xepB2bMhlis=;
 b=hGHtvtj71xabR3iGkMKr9GPCztoc6HnbRc9KNxoaGdRqVj9CcB6kbAk6oSv37qP9ndx6kNBHMMRx4WLDG4Y4l8fXq36wun6yW4eMNbIXQCD2aauxz2PcHYzjtFgcPp/vn+5V319gkJt9FxRM6DUrvCn+hiRaGcrpM6UW1sX5EwwOyFogomsBjlG//RGK927HSI/SrW7s4/ULnslhuJYi710oDu4IRlPwvMkDstH3fCM7NAatkFTtpVyz7P3B1S/z7JLOK6wU2CBXfUPt9u8SiOukwIMJTPTz6rh+v7xaFpQEZc3R6/+2Mg9jqqTJc4VfV4WRIf1tF4lCJUa9GkgxeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5382.apcprd06.prod.outlook.com (2603:1096:4:1d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 08:14:03 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:14:03 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/27] thermal/drivers/qcom: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 16:12:38 +0800
Message-Id: <20230712081258.29254-7-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: ae9464a5-d92f-4c45-abd8-08db82aff433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uaCnpZMnx8nfy642RTdF4Bb9wLfWtG2vBj+FnZU/zHMIB3KWjs/HXuStAFa8BN+HoTnyowqw9rssqv1DfasmTZzdhEQUlDO7Fx2IIq1axNMAXK4tGplCaNhPQNKEqpUU8JIBHS7f1RD0f+6jGumi+D1zJK8VGuhi4Dcpa9aeMUNMMQrJ8TpW2X9hdLtawGE33i1m7kQkfkaoAtglbPsiMKHutVmhr3KU4ikFB4nadrsafJHdtcEWGQ2J5rr+ydsaDn29ZbGD4Xm7qwtAn+j/3rDbk2moTnb2bTkKF9ftuleKkmy6OIErfk7oSAT88Ez1FoyW1BgcFrKikeE5QiRnOBOAk9kEuuoIc+xu2+fACJ7FaxDZvFb8vONpL/92H5ReQoHkrfakTLa1bL4HrSJaeZG13y0orpvOyjWdupF0lsf7SfLFqmIpfkO288rHA9smuRA1eJjynoa44erlb/m0hNYBmXXJf7gKbJ9jhzu6R/2f0GGw1Brr30ES0+QZWVue0HBVTx9izroSXlBN8Fia+tstL3+mQ3L/JAcKOTmpP3jkLwcD2BVAOu/ws5p6geFvyHm4o94EHrjdT6VBgg42/2CXSTIPxYMSPNv2OI+r45HQQjHiJln2XEf+WQMzOaAD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(6666004)(52116002)(6486002)(478600001)(54906003)(110136005)(6506007)(1076003)(26005)(186003)(6512007)(2906002)(66946007)(41300700001)(66476007)(316002)(8936002)(66556008)(7416002)(4326008)(5660300002)(38100700002)(38350700002)(8676002)(86362001)(36756003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enlYWVRZWTZpTnFrTDkrRXdCZmdyQnl2NEtKWGJIb3A5VWplUWY5QlpZT211?=
 =?utf-8?B?Mis1Qzk4bDBjL2tTVWZNVXM2b1lYQkJ4a1dVT0pLUlpscGU0RkxHMFlnR1lk?=
 =?utf-8?B?dHFoY0I3U0VvZGhqQnlscTlkRmVNRlhuMmZRUEZUMitkNE53S1JNRlpJd0lP?=
 =?utf-8?B?NXlPVHcvaEdnNzhwWjZsOXNDWXBKTzlSVTByNkZxQjMxWUNHQ2x3cmZOa0Jr?=
 =?utf-8?B?REdBbkdvOENqUmRkZEpsYWhHaVNFMXZqaEMvc0UyYXFtTHhXYXk3WDc4R29F?=
 =?utf-8?B?bm9saFV0UWh6N1FpMkZCam5PbFVYQmdKWjJYMllBcVFzcW9ZenhXWHF2UUhB?=
 =?utf-8?B?SXpVdzlRUmUyOHZBOGNwZnRpV3ZjMVhIVUh3ZnJiOW1kUGFwQjNWNy9XdFJq?=
 =?utf-8?B?VkxKT1J4V3p5YTJUMU5WMVYwVWxJL2FSdTFYcHlvMGFIVlhQQTZTVG9nMlRr?=
 =?utf-8?B?TGZJcGphSFRtOXZKYmdBYnA0WVNBVCtWU0s2d0k4eW9zZTQ3NGVmVFV5LzEx?=
 =?utf-8?B?dEdydVJTajN6U2J3U2s5RkhldnU0aXYzMGZNSWEwNENHWmpMK2lFMnpCZGNi?=
 =?utf-8?B?d3dyQStPNkcvckFTZWZENnlFOGp3YzBVV3IraUFyTEFZbzQwZ3FaQ2hoY0w4?=
 =?utf-8?B?bFkrZklBUUJnOHNTT3ZuMGRleC82eG5Td29CeGU5L2hzM2RpdVQvTU93SUxX?=
 =?utf-8?B?dXVWSlFxeENxNHNDNmt6UTNVLzU1TzB6SlhZbE4rZm0rdUdxZGtPYmdZTW1v?=
 =?utf-8?B?UzdYOW9KSGpUaTRKNklHQkZWSlBYQnpUcEg5eXcyUW83VUl1bnNtQmxOZWw4?=
 =?utf-8?B?S0c4bFU5UkJCMnRqN2o3aytCMVZaeUgyY2x1NE5qcmsreGRkSjVEZ1hPdnBo?=
 =?utf-8?B?azVKa3NHSWhkTlVmNjJrUHRmWld5ZGozZnR6eDMzdDBTUFMxeWJyVWFHQWRW?=
 =?utf-8?B?Qzd5WU9UTk4wZ2htN3hYWDlRNDN3ci9Cbm14b3NZdjZYTzA5VFdmMU9ONlMv?=
 =?utf-8?B?SktDa0hGWFBvQTdXYzAxbXA2QTF3NUFWNGFoNHZ3T1l0b3lJVllVajM4MGd6?=
 =?utf-8?B?Q2h4OFV5dGg2MGJlU3Q0eHl2OHhFaTkrUS8xNkl4OEY3SXl2LzlGSUtwc3Yv?=
 =?utf-8?B?TXNwQUE1dExGWVU1dU5nUTNCMFBkQ0RJOWNZaXFaYzBJRmppVUVuamoxSDNw?=
 =?utf-8?B?UEVoTWQrNTk5M0NQRTNmb3ZYVmpJaEFYckNvSHRPWEoyekE1UGxzYUVqbGhr?=
 =?utf-8?B?NGZBSTJrdkRKZXNXYm5OL0hzRUFZdjhyaW1sRzdXM2lBYThPTW1jN091NkRY?=
 =?utf-8?B?RndPNHptdE1hNzJNU2k4YXNIRzJSRUkwM3JLWW11NnVENDE4MzVmditjLzRC?=
 =?utf-8?B?Rm5qbjBNVXE1bUNxMmRKUENYb1poUmdYZXVTWFBscG0rTHlDb1lORktwc0hw?=
 =?utf-8?B?WDB6SzlobkczNGJ4M05NZUp5Z0xaajFLMTVkSzc0U2F5d2NUbkt5U0Q2Wnhm?=
 =?utf-8?B?dnRFZXJiMUtSZUwwdHJFeXpDNHRMU0E3dkFtRmZuUWwveWZHTXNDS1FINGQ0?=
 =?utf-8?B?cEl5V2l3VnJoK3JwbDdmV2xxTmdac0E2UVhrY3I4M2lkZVdSZ21YaXhQM0lp?=
 =?utf-8?B?b3VLVE1haWwvU3JsMGptMHVXbG9uS2k3RDNvZDV6dkw3UmM4Y0NHUzBheVN0?=
 =?utf-8?B?RjlJT1l5eGtkSGIveHVnVlNhRE04ZE9pMDVpcXRKRzBEZC9FSnNNV3JRNFZ3?=
 =?utf-8?B?aWs2VHY4NW5FUmg1MVhFdzBPbE9zQmdGLysvb1ZEMnBXTThRcXRYOTJKNlpj?=
 =?utf-8?B?SGNtU0dzT25GRWV1WFc4R0NtVm1hM25SaE56c0NiWnhjajlDZU5mR1YwM05r?=
 =?utf-8?B?enFkODZEcStmRTh4RnZuWWY3ZzBMTGpaNWJ3clhJNlFhV3MxY3YxZ1hGOWRB?=
 =?utf-8?B?YnphMStFTGNXcERpekRsaGg1ZlcwbzdXZ0daQjFDYjlQY0t4WGlvYlJ4Z1RV?=
 =?utf-8?B?Y2pnMFBFK2RGOXVHTEdQQlhMd25VTlFvQncwOGp2RjhaQ2xCZm9YQmVOd08w?=
 =?utf-8?B?UDRvRlptL1FIZDFkdnpoY1loS2NBVFBBTE1WQkpWNmxpa3IxYzF4cjFxSGJM?=
 =?utf-8?Q?H2tErcAWp/qBbFLuhlR03EXst?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9464a5-d92f-4c45-abd8-08db82aff433
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:14:03.2525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3GZB+GwCs6p59PMoObFKlN6PAKgjDuoYL3fzS0tQyAsSFsJ1BF07vttQ9mADapNnv5ENl83hXcZVvPftN7ubA==
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
 drivers/thermal/qcom/tsens.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 98c356acfe98..6d7c16ccb44d 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1319,7 +1319,7 @@ static int tsens_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int tsens_remove(struct platform_device *pdev)
+static void tsens_remove(struct platform_device *pdev)
 {
 	struct tsens_priv *priv = platform_get_drvdata(pdev);
 
@@ -1327,13 +1327,11 @@ static int tsens_remove(struct platform_device *pdev)
 	tsens_disable_irq(priv);
 	if (priv->ops->disable)
 		priv->ops->disable(priv);
-
-	return 0;
 }
 
 static struct platform_driver tsens_driver = {
 	.probe = tsens_probe,
-	.remove = tsens_remove,
+	.remove_new = tsens_remove,
 	.driver = {
 		.name = "qcom-tsens",
 		.pm	= &tsens_pm_ops,
-- 
2.39.0

