Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA0A750109
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjGLIQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjGLIPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:15:52 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2137.outbound.protection.outlook.com [40.107.215.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263D219BE;
        Wed, 12 Jul 2023 01:14:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWrBO1/jHf/8mTTLOx3kWSAA0WW+AS4t7oIdSDHU/wkBcC9tswZqD/r0NoFBh+pucYWia22Iq7xxSbTiGci32csbo3rV6B1OfCe2y6Pulcb+Jq0fgBImM1TSV1180fzXRilGxi6fzf58XqaH+MmPE9aihxFlgZ5tNjTGDm5P2De5dTOJ3cP/9+V/X8gIhSSpen1PgYJRzD30KlneL0LYkbEumdo1kDpZ8eULgyHVN9BjxcD/BE6HivK9w/zugKrcfwqzf47BowrsVdgGvnRFi1kBrhcHJWn1QwaFurSraoa9TrkzQXdBYQgTJyRyQmvxTD4BUiG1MoPex6zWTSfL1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSB/KMZ2qmrY7kuTIjDmatHss0WgDykp8vjAB+Q9Qlg=;
 b=OLQFYZ923x2lLmi/B2dnUCpFldVgJ8/OJ67eOh/2KUnrlKKYPw2rd8F6B70RXk+nywqid9WzMKOLhkQj/qwgisHNnowQ5+ptI/VtB4O++HuWiJd07m3MAAamfuYaQ+Kv78SQfqgpqd5CPgr3MdyMKteQLTTQZTA+AZGdT8kIEJ9zAcXAOtT0u2CRdyfFDMXcJPF266l9KKx8IZROjFFBHaL83+DBW3P83MC1aeUFXu6reo+Ff6kf8/v4++3UmlT10bFDStK0S5827/Ms0aS6JAE1gB/xo4IuQQGQI2C8emAd7ZQ3O7EEu/vwjvEGCo3JJ4VSLSFkxVslh7XMMraGdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSB/KMZ2qmrY7kuTIjDmatHss0WgDykp8vjAB+Q9Qlg=;
 b=ChzJhou2JLragFfPctlDraNLvBw9k1MFWOouiaaPSqe6YgjMx3EKOxF0AfHfLhq9AkgFUItt9onWGbeh2374C3HognKbqvuX1OaGDvWF0ITMmf28F1GBXvBiyb2V6Fi46dY8APZrRKk7UayYluhIlfRDC0FscS4HmFMQ8AVSXu+QCXm5Muh1sMwDArbbjLNnq/yN94bx/21zbIEQg04eW5SZTg6pqCksnXREmEPBPhavZ+JE37fAhjyNpQpND+RMRGoI60V3BKjQjF6Tbsj841/Hp4/ZGoNsEHp2uT3MknKkYpc+ia5vSMnrgu4HcDO0ME1jrDyvJT359L+K+BqaKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6524.apcprd06.prod.outlook.com (2603:1096:101:171::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 08:14:20 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:14:20 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/27] thermal/drivers/da9062: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 16:12:47 +0800
Message-Id: <20230712081258.29254-16-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: cd2e76e2-290e-4ee7-b52c-08db82affe5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N80hyibjdVBtnXq4UTFTLqCeKXD5+qdC0O8KYiSLJPx7KeV29xI9P9d+39OP0VoYiQelLWJWeA3v4adtCdVTx0zL4EQO+fGhhz7WPswnuYPGIKLPDyNxpjo7BYWPufRSqshAFOPUp8RwtU6UEj5SOgrgZoY6MMMXGEkfloX/aPH8Nc/tRuTvMF2Joj635bIcwhAUb5E13CDbayRS0Ofolwj7dR6Re8g3AGE6UzYgKrOFMGMhS9mMAQ5jz4gdTRplkuQVrVxgY5pJeLE28bQkCaz6HhBl4qUPvKLbOGLQ6neZ//T3aNEfsp0J44KVXcrLJv1ymzAOUMtwoi1kM+Lr47ep951n2HkgalGPP1coVD83jRRLOU67zqGdIr3K1mpDl43XI9M7r02P7f1buLyh5dTx5rdZRkWiTQF2qBhCN8J5xc/Nen0+fDz+tgega48wkkclHMacG33GPCYB2vIVeSkD2RGjWJh0RaMHX/ncC7YWfHgu9wiVSlIySYBVVYjTNDo3viwckynm5NtklSaQCa+TUn8sS9zyTQgNmY8Dpbz8QANO1l1kkGD73RujGwg0Uwa/FK5gy6QcUhmz0kv7W2uzDpxDnInWCkcPoEqiXtcpQiKxwHqt4H+dox8e8T9l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(8676002)(8936002)(5660300002)(186003)(2616005)(83380400001)(6506007)(26005)(86362001)(41300700001)(1076003)(6666004)(6486002)(52116002)(316002)(6512007)(66476007)(36756003)(2906002)(66946007)(66556008)(54906003)(478600001)(110136005)(4326008)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cndISlRqa0pyU0lrQ21vSG9LWSs1MWN1d1NTUzRMa1pGdFp4Mkk1cmNzd1RI?=
 =?utf-8?B?cmE0UktnYSs5QmdPZ2tDVGlUQ1lPNjk3WG44bDV2eVF3QUFuQ0dZTWZxUE5E?=
 =?utf-8?B?WG1nMktCdHYraXFCTzdmSTdMZ0tJRWlpS2xBVlY5VTZiajRPUWp2Qm1PcExB?=
 =?utf-8?B?MEp2aEYwR0JYeWgxMWlsdlFIcEFaVnFaQlNLVWpGY25Xc21tOHlVRmFoL3Zo?=
 =?utf-8?B?NUFhYXdOZkVFMW5GV0RjdG5zaHFCeVVETHg3bGxRbEFSNmV3NlNzdG1ZVjI5?=
 =?utf-8?B?QUhTWFg1bVJxdWJxaUJXeDB2OTlkZm0vbUtJQTNVQVF5dCsvYkRxVmYzaFk3?=
 =?utf-8?B?TWVCRnNFc0RqSGpVemo5UzNGUmVlZWJhS1BUOE1nd25GdllKSU1ya1krNG9C?=
 =?utf-8?B?azdjZjd0d3NJaytHK3N1SjhLRFkzR2llOVd6QittdGNya1hvY2JzdHgxS2F1?=
 =?utf-8?B?ai9CWVhEUzR4VTVGT1F6WFhyUWkwT1cyeWVzUytFZUpEb0RLa0E0aHhEOG1B?=
 =?utf-8?B?aHRkbzU5c0N3ZnEzaGYrUUVwRVNVbmo0dlpxZzJadDdIcDhVaCsxTC9DQjJD?=
 =?utf-8?B?VFpCYzNmNGI2bmZkY04xbWFiVXBXekR6ekFNUGEvMC8ydFNwL3ZrcnRORVdM?=
 =?utf-8?B?NS90Q0FNYkR4RzFvTENnTXFKOHRFajhhYkZFTi8vN0NkaVFJSFZDTEFvZVhB?=
 =?utf-8?B?WUxIRDdkeG1pdDQ5ZXVhZ1ppbm0vN1dqYWZnTDBUNHJmdGt2YmI0ejRTdkVs?=
 =?utf-8?B?YVBualVieTJiQjJPUDdvcEhQTlI1L1g1TDljZm50YThmaWt0cWRCUERiT3pu?=
 =?utf-8?B?d1BUWWZiKy9zZFBkWlZhZ01raDc3azdvVnRUOEFER0JlQ1kzR2MzVGVMZVhX?=
 =?utf-8?B?NG5TbjJ6a2U4d0FMVUpQWkMrM3VKZ0FENDhwdWFwSnFsNStRV0xTdWFjdzM1?=
 =?utf-8?B?aTA2L1gwV3BjRU1IajlZd1lqekZNSENpVFNFdkxhVHl0ZDVGbThJbk5xN1pk?=
 =?utf-8?B?MG5MNGUvYkthMWpwUDZ4TXpsYm96SmZCM3h3Wm9xbjdHMEVaRjhBZ0RrZjJ0?=
 =?utf-8?B?dVdRUWxpWE14QXF0NHZQeWJXakt6ajBicnFZLzBrYllqZVhKczU2MWwrYXgy?=
 =?utf-8?B?STU0bHgxV0J1alNZNVh6ejBmRS9jdHJsN1J0Rk4rNzhxQlNoTEJ2ZFhVcU5x?=
 =?utf-8?B?b1J4ZHBvajdYcFdjRThsSTM1MDFvV2dML3RyK1JYWFZ5Yk45M1lXS0FKeE52?=
 =?utf-8?B?Q3crRjBjZ1lycUtiTXRXejdiMG5oakFNaDFTTkxxVVhycWFMaHErY0U4Tk9k?=
 =?utf-8?B?MEs2NndWZVBmNHhwaHpSRzVYazRpK3Irelh1aExEUWx0b083VVlSYWd1Q1RE?=
 =?utf-8?B?dThHckdjWW5sRUh4YjhWdnRjMW5EOWNyRVJjVWJkNHRkYmZ4V1d4V3Z3dktQ?=
 =?utf-8?B?TW9naVZ0cG5TVFk1ekZvTWpQeXE4ekZMSDBxNVRscXNUVG1oQXNpT2J0Vmtm?=
 =?utf-8?B?S3JPeEYzWjNGak81aU9aVm5Od0RrK00wWEZoYklKSGtZMUxyRS9SeVNOSmdP?=
 =?utf-8?B?S01OYWhJK3FlcHZCdVR1NXRGdTBhcFVQL25KME0vMkVtQ2lQcm1qbllOM3dp?=
 =?utf-8?B?b1lKZUtUMzV1U1duL3oxSmsvV1g5OW9NUXFROExBZjM2dUVXWmxFV3JJb2lh?=
 =?utf-8?B?N09ETkZZeUZSZkhOZ1ozMXpPaklOK1ZxeVE4N25xbUhYUTdiTEFBdHBEYktl?=
 =?utf-8?B?dXpYbHNBWHVCcVZBeDl4WEhUSThnODNuWC9Oa2svK3lhRUdISU1GZVNGVEt6?=
 =?utf-8?B?KzFyVG9WREFwUmlBR3ZScmlqMlRndWc3Z2JRemFnRlVhb3RRZjNzNWxhdG9h?=
 =?utf-8?B?WUptVmhxSjFycC9kTktMelNGNVlXUXZrd052ZWNGamEwcURDTmxNV2dxNlhW?=
 =?utf-8?B?NWFlUDFKdkFGbGQ3TDNITHpvd1M1Uks4WmdEalV1N1lrTHQ4SFIvdTZ1SlRV?=
 =?utf-8?B?VUlhYXROTWh4VHFoYTFIY0VGOG5RY0pZMFA1eG10b3M4bGJ6aS9qQU5UNWgy?=
 =?utf-8?B?RTJlemRwSEhJRG5wMDkra2NXZW95YXhXbnRJbXBmcVN5NzlsTVkyWjVUblR5?=
 =?utf-8?Q?H03nbpOHpY+EUeKRT5Hj4Ak7m?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2e76e2-290e-4ee7-b52c-08db82affe5e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:14:20.2995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcqPFc9FFjtTUHj0he0dsfJzu2L3YQh1dCAwGxP0wFpnB1OyrmQ9tQNU5JhqriLEEzUZet2LaJVnywlEXy47tQ==
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
 drivers/thermal/da9062-thermal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index 2d31b1f73423..160d64913057 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -239,19 +239,18 @@ static int da9062_thermal_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int da9062_thermal_remove(struct platform_device *pdev)
+static void da9062_thermal_remove(struct platform_device *pdev)
 {
 	struct	da9062_thermal *thermal = platform_get_drvdata(pdev);
 
 	free_irq(thermal->irq, thermal);
 	cancel_delayed_work_sync(&thermal->work);
 	thermal_zone_device_unregister(thermal->zone);
-	return 0;
 }
 
 static struct platform_driver da9062_thermal_driver = {
 	.probe	= da9062_thermal_probe,
-	.remove	= da9062_thermal_remove,
+	.remove_new = da9062_thermal_remove,
 	.driver	= {
 		.name	= "da9062-thermal",
 		.of_match_table = da9062_compatible_reg_id_table,
-- 
2.39.0

