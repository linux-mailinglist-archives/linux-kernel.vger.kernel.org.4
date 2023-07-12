Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305B675010D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjGLIQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjGLIQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:16:03 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2136.outbound.protection.outlook.com [40.107.215.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653152700;
        Wed, 12 Jul 2023 01:14:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PF/wi240e2Onsxv0itbELahJcGOScybXkkrZCBD6gsjSKGZnMDVi+2mQUnxNqbzuXQKpi+mdBpepO0Zji0LCtQaQpLDZ2vu/jDHJ+4Ec6sdUp+Sb4odcgcj6jsorvtZTsdjEcdJpKMWBnZ0pyl5icDxeW4fpXTnrPiQ1VYck3yaHIJVuOAN0ss2poKicXK2x9WnmN9G4ui7Ylg4mIgKC83oKklAJR4jsJOYNY+0UyP+zJuC9Wf+3ejmaH6PYynYspxkVb4vEbE8SILm7ofzxZ16Tl0A12IXqsdY+yVA5oy87njAa6LIMqLnZWp511SV1rOOkxcJxfhWeC7Xnbd99DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDpghUfsAcmM6fKD/5o033Ckp7CnOvDpysz9Vp/fg5U=;
 b=SqlHhS+jkBvq01UjuS3Rt1h9MGo7qNXnyfcfgeZxmr2xvPWxep6J0MMthJAP9WrgG6JDs7dCYYT0YYD/la7ieIirzpw73ywl28HFJlqK9cmq0ued0uUkrnBuVaod7jKpUGHyiTlYHhN8e2z/EiY04G+igwSN7qL4bUdPClm0S437sYqF/rtmhe2heRGwLoeisnSiB+whBkUAiNsjMer5dxkJGXNPa71BQjLJURsJjk3XWE1knR6nCBks0Xlo2NcWA7UjtrTQK4Toacoz9l3Pl1wNrqqTVJDQVNDHeuVCRGx1o8tgDaQGKBRx7LlvXIQImSWisha3gE2ibDLXIAUtfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDpghUfsAcmM6fKD/5o033Ckp7CnOvDpysz9Vp/fg5U=;
 b=C+VyypNQb4MFTeiLgTQjeQ4pGhGfGdIv9t/tKOwDWgQFNgFMREHi3NrkKY8saq2YA5ns5K7R96HMwDkvE0H6dLYJkQGbvR0GqqHRDIu7mkzFzUZKMY8AYFueLa03AKrGd9dOHQoMF4xppnMaI36fXTDKRhlWZnP4Qsz1XSkbRuJYM44eJnu4iHDtaOYu8/bz4AaqNEDZGBZzBdNP8xn0xU2+BboeT2Mt2OLF2np3zEhGam7c2wPeWhuBOrHAxe80c7Kyb6pCYoNSE7tbXwsgbDIwQLOr5FZ8hFRi+NCeNR+wO/RqK1jibhomPOP2WimcM89DhsVxVJRwXjcOFWq/IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5027.apcprd06.prod.outlook.com (2603:1096:400:1c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 08:14:36 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:14:36 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 24/27] thermal/drivers/tegra-soctherm: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 16:12:55 +0800
Message-Id: <20230712081258.29254-24-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: fde2135e-d8bf-40da-be66-08db82b007bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aWxmbxyiivnRW5LZAweY/+3euVqR2R5hHLyje5tjQKOLb0uLkab6r9FrqIzeN6MgSV5ta1PrJM5Wev1F+itr6saD1+Uh1VoCIKo+St4fH30aLeXaUcVj2l1m392/MKLRimoFBpnWmuuqw03si1eBDmCbA4fkAasKzd/CGIGLIY4vAbEMvnaqsfqz9AAubewzfGzsHWcerAPPTtn3I7desn1UawrS5rEWA5ufaqegT6GmA4zbsAi/nohfyW1JR+SufHNAhuo+p9LlX7rG2lAWhk3IWtE5pizbswRDSfz+Yq4rZGtKmRCt9/WsyGnYNLPVt2qzcSpn+8QRquBnFMoaFgznsa2STyqMQYSAmOA6ikNYYwzoCZcXc3xj0PucBs1ryBK4Wau7he29ldSJQYr1m9EBnGy6IIqDF5srs4C3kiV8/fCsDQnVj6NbxjAIoVFHxFN064OoDKN2QRQZNc7GwWkdN3bePkMlkHzHhw1A7kUP9tcWZzN41uuZoaliLzIGVc/5UneD/AJM1m/Rl8vk3UMETUUM5QeTvSYAnrLD0K7Wm3bZW1uC5FXauG+0eNjjl6by/1V1le8g/+UPt+aE+DLRo/rVsj8dVP8xXoXlH4OSZ4WH9SWlgTW0wknFSRJb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39850400004)(366004)(376002)(136003)(346002)(451199021)(66556008)(66946007)(66476007)(4326008)(478600001)(36756003)(110136005)(54906003)(86362001)(26005)(186003)(1076003)(6506007)(6666004)(6512007)(6486002)(52116002)(83380400001)(66574015)(38350700002)(38100700002)(2616005)(41300700001)(7416002)(8676002)(8936002)(5660300002)(316002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGpIOVVXajNKcU05N05WTllWNm5FMkdmV2R0RThaNHlNaW1MdkZweWd3MFhF?=
 =?utf-8?B?WU1DRmFzaGRaV2puMFVZU1lHZ0s0djNnMGxaZnhmTUtTSzZtSHlHUGtNQVZC?=
 =?utf-8?B?dXpGR2pGZ1dXWjVBeCtXcWNPRjVjSVdES2Jha0V6VWRGUXdvVzlkd0RSbGxC?=
 =?utf-8?B?dmRGQ3hTSE4wSFVycUJJbDBCcEN2MmxtcGVZR3IydzJ6eEpDS2R0dUZJNUE0?=
 =?utf-8?B?Y2xvdERJL1EvaGVCbXIzYjJHdjBnazZmUTkvQkMrdUZvYU9RL3Z5UGNWWnpE?=
 =?utf-8?B?b1RLRGJySjdZTjRNSHk4MFFhSFhMaFFpQjg2Zjg3bExWVHo3b1IzaFJEUndj?=
 =?utf-8?B?eWp0cWYvNmFvNXllNXo5UWtiazlYZ3paa0ZJQ3pBTnlwRVBnYVR4RHN3V0VH?=
 =?utf-8?B?M2V5c1BqbXIxcXBXS1haaWwzZ3I3d3lHSTFJZDlSQjExbk9MTmhUcC93SmVQ?=
 =?utf-8?B?blovbUhIVURvRFc2MWxWV2xBdnhnV2luWnBWVlV5aSt6by9pWDVEZHlpMjhy?=
 =?utf-8?B?Sk10VlJhclBobHFBb2FyYmZQaUN2bmROM3ZhWkRTWXRrdE9UMC85TW5nYmh0?=
 =?utf-8?B?NWhkMzdEL0dxc1phbTVkNlNKMTJFZjZFWU4rV0I2QnBxakMrTFV1bFBpbzlO?=
 =?utf-8?B?T3hkeU5YK2xVTVhhbzBPNExWYjJiYnF1WE1jMWZoZThKYVVvMUxlWEd1a3Nq?=
 =?utf-8?B?TXJ0ejJFQXhVaWhlYk9YT3lQdHh4azNGS1NIV0k5UU54WFF4SUJMdVhxWHl5?=
 =?utf-8?B?dmExZ2JpQjNjcm5ra0djTUoyQllSWHF6VFB0VHJOTWRCR1RSRjFhQVUybUZq?=
 =?utf-8?B?cnMxL1BTZ0pwVHlTSit6MDBSRGRLLy9BR3MxVnUxVGYzclY5QXhjL0tRN0FI?=
 =?utf-8?B?TEhNQkpaRFFFdkFYWklUVkFVbWR2aDBrQ2hqZDZtWGlVNUJ4eE9PNVVNTEpo?=
 =?utf-8?B?SmxQajNWMVVXYWtwTWJIZXJkWEJsdDdibWZZSzZiTFErTlIwUHBpWHFIdlRn?=
 =?utf-8?B?QW1DNDRaZjRNbGlKNUoxQWdZOUUrSUJ4cnZ4TlFPT0ZCZG5sK0V0RVdtbCtX?=
 =?utf-8?B?T24veDAwY0wvTHNhQ3VXdjNoQlVUVlI5WStiM3oweGIxS0NoTlN3N1BsU3V6?=
 =?utf-8?B?VFNucTd3WmU5OXkydHk0cGFISEx4OHM1a3ppMWtqcHVkOUtXcnpPYTdXUEZR?=
 =?utf-8?B?U0x3Z1dYbHJ6VElPSXhUNDVOeFRmVEtndTVSTmEwcFBlMnpZL25LcmMvUFlz?=
 =?utf-8?B?RkVKc2hteTFlRjluU0sxNEQrSU04MzAwaDBETXFVc0JFSTBabmNiTmVGRWNL?=
 =?utf-8?B?ZmU2bXIxaDE5UkQ1VFJ4R29CUklUYkVKbmI3QWpYdEFkclY3dk8vM3ZVS2dv?=
 =?utf-8?B?aTBjaTFkL3VBbkdhQ3lrNzQxWENCM3ZZUTJxNFJhVW01dEJNYms4SWl0VzB1?=
 =?utf-8?B?bjRhekM4Y2oyT3hrZjlaVW1yYngzV3ZiZCtUWlBPaTRXMFJ6ZkcxNTNKZXJH?=
 =?utf-8?B?dWhBN0lNbFZtQ005VFpLU2RmYWt6K2lXeGZLSERQcXV2NWxxM2hrcnFjV21N?=
 =?utf-8?B?Umdtajd2SEJtQlNkL05hS2RkQjZBdnhFU1c4ekNVV0QxTjFxK1loNE1UNlhM?=
 =?utf-8?B?YkxRMmdpKzFSWmNiK1JBNTROS29EVXl2ajFQdjJORnVieDRKTkJqcXUrQzVu?=
 =?utf-8?B?OFVTbnljbFNtSUFnN1FFSlROaHdZZDgzMFBrQTZjald4NnpIdXVpMzhBcFRv?=
 =?utf-8?B?aWM0V1Z0b3ROWlN0amNEaTJ4eHg4L1dPS0FGUlB6eU9rVTNKby9xOTl4M2Nw?=
 =?utf-8?B?eWlFeGFTS1hoaWw1WDhZZlVOckVwZTVzMDBFKzd0SS9COU14QVFIWCtFd2h6?=
 =?utf-8?B?b0VLekJ1RTNyMkQ4eFNNb0xneFQ0VEdHRDkzeEJDazdBaS9GTTI4ZStVdGxF?=
 =?utf-8?B?azdmcHFsTmJtVmU3UWw3c2dsM1U1V0svMVZXNFdmU0NLS0FEelhYSEpDZHgw?=
 =?utf-8?B?SmVwdnBLc1Ntd3lWV2JYenZ0TmtmVXQ1dGFKY1lwK1U5aHRhMFRCcjhYalF5?=
 =?utf-8?B?ZEE4UmliWHVzUks4L0RwcFJjazdtZy9VU3hQcXRadThnQUFhU3hZZS9GZXFw?=
 =?utf-8?Q?c+GTkQbNwrA5DhU6AdipGME+r?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde2135e-d8bf-40da-be66-08db82b007bc
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:14:36.0036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SgIeAksltozG7gIqXwDpwqibJX1PlrQTx9uVveFf735+StSkp3jBCF4vCzHRMrfXattkI1cL7f4X/hFbxuThig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5027
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
 drivers/thermal/tegra/soctherm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index ea66cba09e56..e7fe8683bfc5 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -2219,15 +2219,13 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int tegra_soctherm_remove(struct platform_device *pdev)
+static void tegra_soctherm_remove(struct platform_device *pdev)
 {
 	struct tegra_soctherm *tegra = platform_get_drvdata(pdev);
 
 	debugfs_remove_recursive(tegra->debugfs_dir);
 
 	soctherm_clk_enable(pdev, false);
-
-	return 0;
 }
 
 static int __maybe_unused soctherm_suspend(struct device *dev)
@@ -2274,7 +2272,7 @@ static SIMPLE_DEV_PM_OPS(tegra_soctherm_pm, soctherm_suspend, soctherm_resume);
 
 static struct platform_driver tegra_soctherm_driver = {
 	.probe = tegra_soctherm_probe,
-	.remove = tegra_soctherm_remove,
+	.remove_new = tegra_soctherm_remove,
 	.driver = {
 		.name = "tegra_soctherm",
 		.pm = &tegra_soctherm_pm,
-- 
2.39.0

