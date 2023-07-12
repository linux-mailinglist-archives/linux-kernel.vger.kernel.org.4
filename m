Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F687500FB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjGLIOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbjGLIOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:14:15 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2116.outbound.protection.outlook.com [40.107.215.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F17A19BA;
        Wed, 12 Jul 2023 01:14:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtE3fiTXW+95h7NrZq+ag+b6kSkTUdhGbCS/RNjpcEBXC5+o0q7kZxwROjIvBfnmzPgpm/aYGNPsLdA6fA76mgCMG5x/RY5iOMVleeP82KjgAYR+FhYKabmkZl498ohVIK8wpxU1WOFuAfQY2c0FeZI+bMEYenVMtZ56v0d787e/iXR9QmgxAMkAbXr1y9SYIg4Mh7PK6aEPNR8Ik3JF474fo+KJbDMRP5Y4ZmFR4rrB6vBfZnCrNxmd6hNJHs/cm3Z0k3HXPrsOS48+bgYyhoux8qTDLHlno91xYFowF+bqkgfxMyo1n6sqevgaa5oxwtHhwkIBtsRxJFZr3LGa6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTSHy6tikfzk9mbKrw76CHlWfY85kX8JtLDPfmC6nfo=;
 b=NkP1psMVF69JIyq3JKpVLsgA/ZjPVw7tQmBWXMuSRz42lB2oCKQrISBGMYOklMyB9+1kDlPRw0kmXGT3NFY6JBGEsFVgl0KdhNxKRUovS0eprZvFAhz+WuxHuLTW5bB43vxpe+gatT5RsozN1c3/JCcP/oO70yQqT8Y2EYqsjCyOOocNVcnVxlkU0oEjob1Q3ysFqt0Uj86DkemOscc6b3qejUrvoJUMyc/P9eq3sGyduYuPFdYCKa2rqjW1WlZyY4HgCqxWTKEukFtq9pRaJQQOtqgFpctXK20geyfARqPNDnN0cmSNApIn3ixkieB1z86oA5KMRTAm2Io+kYXnhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTSHy6tikfzk9mbKrw76CHlWfY85kX8JtLDPfmC6nfo=;
 b=TH3uZKxeRknU/OIyzjleKp2MZ6u94UATSyVRXm4PaajmwPuh5DI6lfef6ZgSfOUxfXpWa5omu40ReeaPlQcvuL2xCR6lvH3oiAgGB3BXzlrnmzn1jyKbuCXLl89jiDgZC/kenpyTCZCnz3tex2TlkKnsHJo8NgqlUuinVK86/mjyMOsTjZ3c1BuaYsq0CP+AqEp5XdAiN82+FSGYvLWyZ4l5H1bZUdlxTYfQEcNAzj4rcnlCQDvu8YYObapQEqAP68ULpQ2PWHTAIgwzXea2p6Kk7g4C7SdMtScXv6pbgq9PO6KpVO/twHvw/z0VVp/aRLpGi+Dsgwlz9hhhUblc6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5382.apcprd06.prod.outlook.com (2603:1096:4:1d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 08:14:06 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:14:06 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/27] thermal/drivers/spear: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 16:12:40 +0800
Message-Id: <20230712081258.29254-9-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: e3ad1a3d-2f46-4668-680a-08db82aff62f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jh4N8cd1C0cb89OHY3/acIUzGasKd6FkgqlmWqMHXT2/ccQuivct2vF4ppfoHIW8Mm0gKMToOP0Y1j4VSlUBzWg8w+dDl+Crmr6EH/FUjwRkrzDJ0Hklg52dbpffcI7jS+j/Wnx59sSy7S6u1CS5rWUvCpGEjALBUDALvh2XBCrdLxa5QlQE7bPYkV/M6nSOnQbhJd0DTs/BTbBOtZfTFlUpJHJqA/k4sXsZqLS0ZYCL/9jDbyHMTqF1VUDroMXXvAOeZoi6+yRiTDcuVLezO9odCuw3EMXTLljqxaZOrQpwsZAV+CigCfZuXP9KObMaF/dG05pshwTprj27dqO90dy79AgLF/VXy7QLVCeIlaZjiwADHEyZ39c0XUe8sGdpBLXNdJfr4RFJff0hd8x0DFvy0KicYmUpuE9hrpUszT4nLDsd1fG+Ihu/b1VmuBO5VbDpg3RO44UtSSrBoxGBQEBLQEO4HsxdjQmaRJyu5+6LJJfrusrbxdpgNZV1ehppO2rKVgEWGRZOR2nYzNH1NA8WsjxIdNbQ+eUwi+cRnNAhBKd6O5/NJK+HHAqNf1V++4rwgGMdkSh5uhuZYNsGpPkz11WEA62yUMsNwWEMXIYIXKfNhLKFiGYWHj9nW+GZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(6666004)(52116002)(6486002)(478600001)(54906003)(110136005)(6506007)(1076003)(26005)(186003)(6512007)(2906002)(66946007)(41300700001)(66476007)(316002)(8936002)(66556008)(4326008)(5660300002)(38100700002)(38350700002)(8676002)(86362001)(36756003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTNqdFhBaEMzdFRndEU3ZDRUYU0xVUtRalVyNURaVC83Qk1ORVZFRnZyU1Ew?=
 =?utf-8?B?VE45MnpPcEtjZmNRSjJnQXE3LzFzMzVQbVh5RlF2eVI5ajNUbWpYL245QTdt?=
 =?utf-8?B?aUU1STJVTktwcUJLVUdqRjJVNVUyOURSUVZIVnNBekcvYWozekJvTHRsYjc4?=
 =?utf-8?B?YmFoTHVBYzF6QndKbGJDc0lORWtVOTRtbXFNdFNjZURWaDJSWnhKZXF3WFZp?=
 =?utf-8?B?NlpSWi9icXlIMEVEN2g3c29XaUhEd3NtWkhaVGU2UVg1S3VHOUJVOEQzWHNY?=
 =?utf-8?B?My9FcUZ5VVV2eFFxTVVrZDBCVnIvS21ROHhQcEpyS3F6RG5DWlRmT1JyWDZz?=
 =?utf-8?B?Syt0cEVnaWlZZXZMdUFSQzVzazNSQnRwakgrd1J0aUlERDlNY3JNN2grZE5D?=
 =?utf-8?B?VmZDTlhqbVN2bVcrcE5hNytVUlREYzhBb09RbGZPbGI0aW83Z25NUWpVT0Fi?=
 =?utf-8?B?WGJxRUo3cUxIUlNEdHAvWEQ1R1U1RjVydEl0V2lGc212dVJPbzJWWmhFbjRo?=
 =?utf-8?B?ZkVuSzhXODNLWEQ5dWZvRHdSN0NZb1dBbFVieXhRbVdzRXpZSmZrelJDOEE2?=
 =?utf-8?B?WlJOSTZPeFZhWGtWb2hydE1kSFFXRTZTSmxkbER3TTBOQ1ZxNVBGWndSejkv?=
 =?utf-8?B?VVdPN1Blc1hGR1BJU1FLbXFLa0tKZmFnMGZlT0doUXRVTlVDSzYyWmVSakgv?=
 =?utf-8?B?SzJocUtFeW5xVy8rVC9ydnoxc0N0UlBaWWJjcGo1QnZudmJKVGE1Mm5yMEZI?=
 =?utf-8?B?cVBhQlAvZUU2S2U5TTgwYWk1SkhiUm55SHNrdnl6NXJjb1pmbmVweWh6Umxy?=
 =?utf-8?B?Vk82c1k1Y2hCVlBmczlVc1Y0Z0MydTU3VlZBZm5RUDdZZXVaV1JCUGtxdU1m?=
 =?utf-8?B?cG5IZVp2YzhDeG9uRC92bnNQK2RnNVQ0UEIreXhvSFQvUkMwMTUvbEFaQ1hS?=
 =?utf-8?B?UWdjUWZ6UEdCQ1owRURhbjlpVXNEcXg3QTAwaXVzeTh6dzE5RUd0NjJvNFR5?=
 =?utf-8?B?NGdKLzNIdTUycDc3NzZlZ2VuTHl2Mm9yN0NBK2RoVDVjeGU5bUFUQ1lmN2dG?=
 =?utf-8?B?eWNiQm5IY1JYK2ZRaVVBcWlyZXF2ZkpYSGFMSXE4QnN2WjJDOEoxN0lzQmlL?=
 =?utf-8?B?WTJ2ZVc2alAzRHhQTHByZFhQK0dqTVVvT2RTUDNRbXJON3c1TlFDUVcrSXpH?=
 =?utf-8?B?VzVURlNJN3ZmdG1zZUl2eFYwNEt0cGtSSm94aTZxZ3NyanNpTjd6elluNVFJ?=
 =?utf-8?B?dmhDTUI3c1M5VUVVY3l4TmZKUWlVc2NRL3pEczdEanhQUDVlaHJReWRKbXhT?=
 =?utf-8?B?L2lET2tCc3ZFNmlXRVZidXRGNWo4ZzVKUUF1bzkrbHBmQy9zcHFReGJaVk9z?=
 =?utf-8?B?MWV0aXExQ0NCUy9QSVA4dkcyR0NGRTlmck1nTXV1YytpRzQ2ZXQ4dVJrcE9F?=
 =?utf-8?B?aG91SDRpdjREenByZjhRQmNoRlZTcDZNZm5hc21wbnZodWRTeElLdGp2SVZF?=
 =?utf-8?B?OCtmQW1uaHR5Qzg2MGJmQlFkb2k1SXpVSEdBVHZFbmFyNmltUFk3VUFLUnJJ?=
 =?utf-8?B?ZmpiSjJnS1VDK2JCNU1GR2lOZ1dqNFpRTXhMRUhSV3Z4MnZ4RnF5bkRUcGt3?=
 =?utf-8?B?N3dwZGVPdk9WeUc2RVBQQVNZc2wxRkJ5b0tmYkdTVS9acngzQzA0bVEvTjh6?=
 =?utf-8?B?VzlKMHhTeFNVOStEdU1Da3FuUWUxY2JmeDcvR0lPREw1WVB2YVFiamRQWnh2?=
 =?utf-8?B?Uzc1aWlmQmw0SmZZOHpsQ2puT21jQXJYVFJsQTQvVFJidmZOaTdJRTM3Vk9K?=
 =?utf-8?B?NjlzNVM2UlZIbUduMFJtZWRSS2JkeUd5UDNNM1NyNnlYTjNkcUtRN0JyaXpr?=
 =?utf-8?B?eUtKVWUrMjdhSnBSVDJxTkZET1MwUU5OdStjT2JQeHdhRHQwUTVSOVRQM0V1?=
 =?utf-8?B?elNDVzMyOTAwTHNjSm5aeENZbCszYW53YjRTM1dlSC9aV2pNaHNYODBKakFq?=
 =?utf-8?B?WEJ6Qk5WY1hoTmVKNUhQc1gxeUtMMVAwb202ZHJtUERWNGZPTjZYc3F4VC9x?=
 =?utf-8?B?Mk1PK0tyRURiK0lpTmVkMTZpOTltcGNCTHNCb1FLVzRna2FKQW5oUDRFbnNH?=
 =?utf-8?Q?2b6KAgTzRH9lA76DJ2S4CvzDG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ad1a3d-2f46-4668-680a-08db82aff62f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:14:06.5568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HjIWdBJEGpkWuSHNx85MubFtVDRsAzON1Y8Kd8VcHiqA95e8e0qK6g0vXezoKF3yBomwM3MZmsdvgp8mkyAmFQ==
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
 drivers/thermal/spear_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 6e78616a576e..843fa5c8e7c8 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -150,7 +150,7 @@ static int spear_thermal_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int spear_thermal_exit(struct platform_device *pdev)
+static void spear_thermal_exit(struct platform_device *pdev)
 {
 	unsigned int actual_mask = 0;
 	struct thermal_zone_device *spear_thermal = platform_get_drvdata(pdev);
@@ -163,8 +163,6 @@ static int spear_thermal_exit(struct platform_device *pdev)
 	writel_relaxed(actual_mask & ~stdev->flags, stdev->thermal_base);
 
 	clk_disable(stdev->clk);
-
-	return 0;
 }
 
 static const struct of_device_id spear_thermal_id_table[] = {
@@ -175,7 +173,7 @@ MODULE_DEVICE_TABLE(of, spear_thermal_id_table);
 
 static struct platform_driver spear_thermal_driver = {
 	.probe = spear_thermal_probe,
-	.remove = spear_thermal_exit,
+	.remove_new = spear_thermal_exit,
 	.driver = {
 		.name = "spear_thermal",
 		.pm = &spear_thermal_pm_ops,
-- 
2.39.0

