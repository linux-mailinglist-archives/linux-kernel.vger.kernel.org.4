Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4816A6CBB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 14:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCANBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 08:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjCANAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:00:55 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7913E0A6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 05:00:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzTfYtRVwl8qd3Dt9DOEfvg2/LyCTOtaxuLYjEMbWOX9Paj/F9xGNSXkxi90ITkf6k3hTbKhvSnv4V4EnoyMlWX+Vi0kY+4bxa8pXZP3wSStiYSWsJvYSWOwwfQYrkHY//K4xrOaNRCdq7OZuQi+anN26Qet3RLCtdEnNP3y31ghgr4nW5nuRSYfQB+6AjGJG3QXfo+8OPK2VYosDnWFw4Tk+ypxP61p1iTMYfaFbDmVb3dX9dLbNHOVc0BeP508xpSoRAwYzy2Y02/5zLvc92IxqQELCXOYMuPM/6iTPASMYDEgo3ZU9/aV2lsfBvCBrao/geSGDs6NqkiL5KoVRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErliCWonpKvN0cP+JostdoQmRsJAZ/hKZQkJVYa0LjA=;
 b=dgGxyD+yT7ryopU3ldhiO3sfgc8SEQckbQX4bEQiER0icOaZbnUiTrzP5fb92/G4jM3OIq/fDHVNLTjqxVPXG/fqu5b5tgyRIKDjipy6HTJAUdw3YeQAgdW4wj2s757taSBY0iELh7spufi590Aj7wjKBYmxnLxMsuRwG41R0evaYS8IUTkLuf3bkH7dNpaPMwkINPeipW28qyi9m1sfVLIwwLY1JsXvhkUj3IG30iMgyeA21AXWzZfbdJPRy3q55s2MK3OpYEDmT8XN2Bj/vBZmR6gh8gKaJNcPN3Dcu0lGXgiCfLIoaC1N39W+UPALr9uk0d228b1SkedMl82Bnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErliCWonpKvN0cP+JostdoQmRsJAZ/hKZQkJVYa0LjA=;
 b=E0Dgj4FPrLdY+jcQ5xPOp/nY9dvVzxsbBX1POJ3Oh33Q54ygTJlV+12e/rUkD1nchFngXzMBtXoxiTCgabduPnGmcLxS9OuJip9C7Q7ySlkLJtx03Vkd2yddwfIRVk4xxWfh5kRP4e4E078GG+uSBMKpHaz5JDVQIi6FFDkSEBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by AS1PR04MB9335.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.20; Wed, 1 Mar
 2023 12:59:49 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36%6]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 12:59:49 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        peng.fan@nxp.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, m.felsch@pengutronix.de,
        jindong.yue@nxp.com
Subject: [PATCH v3 7/7] soc: imx8m: Support building imx8m soc driver as module
Date:   Wed,  1 Mar 2023 21:05:57 +0800
Message-Id: <20230301130557.3949285-8-jindong.yue@nxp.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230301130557.3949285-1-jindong.yue@nxp.com>
References: <20230301130557.3949285-1-jindong.yue@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To GV1PR04MB9183.eurprd04.prod.outlook.com
 (2603:10a6:150:27::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9183:EE_|AS1PR04MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: cd868c63-9c96-46a3-529c-08db1a54d701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kQwBy59u31aXA4kzCQhpsFOnqEzjNTkAkhDf9sx9Gwi5qlBxreD5IJVOhpn7c5pVpMg8BObooYkyXUkEZGRPjcIJKAEAXYmc3X6dzDNaiYJBnm4NYFsZMXTKmZwAaE1WP95zLsLvpNdcaYBZjN/QjNdC7z6i5aaTmuAjBRVgz5W3S0kLjWmOFKY6F2l25cy2x23P3NZYzYGT/Z0M7xDro5v+lO/LhE2vFHJlWYtkuZ2ec2dr8VvG3NfLSY20SP/tqVdFxDlhIYeZ7OaiUpHOxwcXf9wd/taPaEDS03d1iDXXCLaNKGDIOkMmqmvI15U9fRNH1Lnu3L0EvwWePmujJ9Y3cYJDKSja9+mmkelaa2FOE24kUTffdh9ZhnQE+jfa3GPLb6V7UTuv18Js4CMiBjJ6UDmndhxdPHwOyAQ3HghOLEO95zTY/u2m4Z5h1PUh3IBxnlIq2uOXmbHu/dxy02lz0nletIbHfVc6HphS7aNnHWQ/I8JkoItfnQZzdAiTsRHGu4bpysVBWkEeMKQLW0JpHjSZoRvFuZfz+0dwjZLL8zhHNfb+7To8Awnj6KHreTZvhcPWhNg+wHOXxh9b7dv8N9ZTbiimGgozX/nwZCqca4N8IZ95Ycr5clUHULi6zK9UuSL9avrqCqBtQjsNo83yAh5MQjCm/YhUEHeDnm9WcRfNumtqVKPVjGNHl6u0GodVT4NXwbrxKcsjHK9g1Bxde4rCkOIlPHvMGJCK8G8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199018)(4744005)(36756003)(44832011)(2906002)(5660300002)(83380400001)(6666004)(186003)(2616005)(26005)(4326008)(1076003)(38100700002)(38350700002)(66946007)(8676002)(66476007)(316002)(41300700001)(6486002)(6506007)(86362001)(478600001)(6512007)(66556008)(52116002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SvG8eKCA4jyvQv1KlI+efRRh/5Jbh1jqE4RcM8mkYKQLqFK1ovFLdvLOsP/Q?=
 =?us-ascii?Q?mFvIQTl9Bn784qAzn71b2XkCzqd7du7GNvnuiSJDOrpKVlCiOkyf1hwllr3R?=
 =?us-ascii?Q?5BfHbDgLZvahCru4iuxm/LUh5xRs+HmBBYsiwkmOAK5HZH4c+SeQrVZi38hA?=
 =?us-ascii?Q?41gbWy23kHgVz9YacxVn7L5m9Zna/r6Fr7FAHMnSZtt5o98gLGmWXITmQmyG?=
 =?us-ascii?Q?CfjxzaRrV0Cho7FvBYz2cpEoXkRcACKmOCAHWo2dr8df3gbBHhCdFsfeGl6Z?=
 =?us-ascii?Q?ioxucTnjAfG1ybbiabmz9WWcFmvTTpsk88IwiFSWJRsI9Ogs34b3aIYgMEGV?=
 =?us-ascii?Q?YGWSkAaIoJa5B+2sS29y3BZw4nQc5GyjB/HhagSK1USP/Gtk6F4oVRR4UsmV?=
 =?us-ascii?Q?wRSfiD4BHlLz3v7LcUfcBgMeNSLyQV8HDE1rWmmNLpt/DPcG0/hVbsCy6s/9?=
 =?us-ascii?Q?QQnZegFCfH/ZuthLwWdisASKQZig2dCTQlC2MpRLO+KFYHKOGN7U81MzP02f?=
 =?us-ascii?Q?AvDZyx6ZZsr3FkoIZxlePNDafz9cyaJboy7DZcqyPHPE0ae9H4YU1rzg/rYt?=
 =?us-ascii?Q?ZmgCefKgNU4mjLFgBUwgC5fAPcnn8Ww7ZcGUe3s8QgM5qwX/NYY9JsvugdM4?=
 =?us-ascii?Q?BnAlxFp3B96mEMpz+aOolh0BH9FERc/KGr94+zlbtl8HZUwCfqYscCndOIyh?=
 =?us-ascii?Q?dPtPUoGg38Q6y3qaDmwV+mUG+KuwqRAbRz0vNvZvKD8pKAVCzyqS/Inb0GYY?=
 =?us-ascii?Q?ZRgt8SULN4vZcQgRX5P/hR/cGw/vKAHMihI7dSCTbKj2QqR3Uy9lnigKdm+P?=
 =?us-ascii?Q?A9KXEhpAvloy0eMk6E9BCBWHsMR/tjxKTDo2rnZfYcweyJni9st3/d1Dbzgk?=
 =?us-ascii?Q?FXrlyBfeYr3UGVKk9KAQul4LC/AfaioSSQJNnU2cI6gAY84uqQJIi/UfM00R?=
 =?us-ascii?Q?8Xl1u6yoZsMFC5JYFLHuqup0wpOmjk250cqs3OD3OlQWww7XOdCImvE9POhu?=
 =?us-ascii?Q?qUdYD6ejTVyEUV2XGQ62jH6vhoOXR669PHN/kuoNICjcqtKiVvYu/9935RSK?=
 =?us-ascii?Q?gidnhsSey7dUDXKX1gcWVYdWOL8dwTKpsiZMKMF+E5zrgGwmNzLj0aEuAZvo?=
 =?us-ascii?Q?+i10PtEbs3uvBHPACl9b4t13Vhjg9jWRZfaCkyTwXPmTMtxsKQ2+P3+x/yhB?=
 =?us-ascii?Q?9D1YUhfVoe6Nf4j541VLQf+4n8xDGhx4ukSINjZUV2kFHHpjcD1l8Yns1SEU?=
 =?us-ascii?Q?DRtrnNZWWfkYJ+rZbHiMUyL2NH44Lez6suFmeJy1zfqwtP2dntRiruxH7sTT?=
 =?us-ascii?Q?CU2KKdoxatGBbvL8MAs52/iEXXRHBdo2m13nhYHvpHuqpsGahzkPYfv+wUrc?=
 =?us-ascii?Q?9gA8oMLoKcg+6byd6bfQRnMJGqnHAMVxw5XlH4tO8MZn/d8/fh206JHhZjMV?=
 =?us-ascii?Q?dTJA6jG2C7pg9tnpuwIg9dskHE0WdFGsL9psl1NsMn1E23zUUKlb1/kC28ne?=
 =?us-ascii?Q?xvKaCBfWe982UHb9pVhzXAg+gCi/T1v84xIMgLTrPDDJqhwwgInZijK5/RX3?=
 =?us-ascii?Q?9jWCSgXDkJzVoFlSmFwSkEfhuMdsL8XzSyudaHhP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd868c63-9c96-46a3-529c-08db1a54d701
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 12:59:49.3882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ArHOahO3JJ8ei3mIWkt7snnU/6CjkX1rNGPe5tUGfrXmswKv2IvoEYLFSwdFnaxwcKWQHKXAj6gdQvRTxWm9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9335
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the imx8m soc driver as tristate so that it can be built as loadable
module, module names are:
soc-imx8m.ko, imx8m-blk-ctrl.ko and imx8mp-blk-ctrl.ko

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index a8742fc58f01..76a4593baf0a 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -10,7 +10,7 @@ config IMX_GPCV2_PM_DOMAINS
 	default y if SOC_IMX7D
 
 config SOC_IMX8M
-	bool "i.MX8M SoC family support"
+	tristate "i.MX8M SoC family support"
 	depends on ARCH_MXC || COMPILE_TEST
 	default ARCH_MXC && ARM64
 	select SOC_BUS
-- 
2.36.0

