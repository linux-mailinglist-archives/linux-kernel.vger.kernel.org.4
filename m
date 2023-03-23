Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53596C6B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjCWOtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjCWOtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:49:12 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2077.outbound.protection.outlook.com [40.107.8.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672B7F773;
        Thu, 23 Mar 2023 07:49:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sg5SN4ej+qiM+RQvkapyGCEiEmXRUyew69MReLWD2KITAXhtj7+8iRog71qJMzVsR3fROxq/FMZqe9j1/1L4kcb6kGs2dxmvEVatN8imrsWDaXqiQRuDyvr8x+jzvqVe3SU68bX1H9AYWwmgY/xHlp+0IVM3vrzOxXU+cN9ik8dXG5aJb8SGkrIYsoTr75MN0MmNhLA8ZSyh2w7ePGG/+M7hDOyMXinO75Mx5gh2keN1wIItJidLfPXZg/VSlvvp6Z39ozGk6Nx1ScYIOPwxlVh76svReL9J7D3Oj37L702L8+qJ1CVMNbdHMs3EbGv2xdLyYZ29nk8TYxJYZ8SIVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cruGKK4IQW6635Ztcdl12flObos7TvxEmOlvETIWy48=;
 b=P3UMuKYoK+6tXtAjeul+mIg+dIqq+69X38opGkSU0Q9Mv5BLfzf9fxRj9lradjCZH4t7R7t+V9MEV3MD+kWS1RTNINHyF8P2AH5mBEF5T4YC539nBoXht6aZQQ7X7KFfSmgyqKZwVYgGm0tbiVL7f/SGGky5mScITfQQJecNhO5YovwIWccU5v93Cfx4ZQBADBPD0jM9UL9KteVwza9pyy4qIuCokwXxwy5fqzX0IyXBC/1M8MJupPPf0cDmJ4d6rR9M+QiMsTIlt/qp4orICM78iQuNfNl3pmN661ARfQgUHmh7wBej5Ay2CYmoFATT0daMcMmtKdc91Axsd1sjTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cruGKK4IQW6635Ztcdl12flObos7TvxEmOlvETIWy48=;
 b=anFwEHmb8MOr81TAL6FA5rNLUeUhIYWk2DI234PvqcpfUNUXqr4AHb48pgntREkleB8g5PoLEOIcWYIA9BONgu8+d8fvC3th2jR4pnE7MVrAFMjLhcIXcxEr92872Qw7461aZAeISAtb12fVm2jqfnlT1VL+tUfNeY7OmPW7VRCE790KRiNeLMkO5Ykk+FYBCnCyRiqdB1sogmqG8GqjJNeilaKNhBZ9GOaG/0EAmcyO5wIbrosuSssK0Lp8Y/Hh6RKlYo9bdfL87T83BvFuOB7eVZquPvZkenCGmAczePlFPaZy4FEGbZgtccKz9wJ2PA8aNzlwzuGC8x/4eqX1CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by DB9PR04MB9625.eurprd04.prod.outlook.com (2603:10a6:10:308::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 14:49:03 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 14:49:03 +0000
From:   Chester Lin <clin@suse.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Chester Lin <clin@suse.com>, NXP S32 Linux Team <s32@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v3 1/6] pinctrl: s32g2: use of_device_get_match_data() to get device data
Date:   Thu, 23 Mar 2023 22:48:28 +0800
Message-Id: <20230323144833.28562-2-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230323144833.28562-1-clin@suse.com>
References: <20230323144833.28562-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0294.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::6) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|DB9PR04MB9625:EE_
X-MS-Office365-Filtering-Correlation-Id: b46f1637-a2d0-4c7b-e7f1-08db2badbec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ANM9oHAPDQdZljT6kfgXnrc5o0kjEo3caUWGA6SLbEe4ikA2qC1ra6Md0HV+n7iXB1b7TvTVVBI3vWF1zTeK1gp6RcgGtLRnFO8t6g7V8Yft5Qrjz+IoZc2w4+3D7Vc6wE3OsAbwns4rAaMdQMhecD5pwl+SVt+Fd3ggJeiBiUDgNrZDBs0bF5oigmTWibNLB+jDwzGczz0zW123vrLhyAJyBGimSlpmIYK426R/whf7DOU5dEmO2zmhVxMMF2+dJa+uWX8Vmfbuh0uUXodfFoP0gR8IQ7WsRlYreI7PLy8ixFR5XNp8rQQcvgDoZID0igVZY+x27F7tl6ZTsGxvy/SiuGUq+YQZSnQ90AY2xZp4bD5pPuI1HFtbCL4ipm+2BXOFTc9XVUiYUDEVE5BF1DtTdZroN8d4mmevo5EnNlUyFODSorpc9VkzWpLAEHRgIM4x89qjqT5p4jvvLLTx7+REnFBXkrFvOkcvzP0TwZ8XV3H8D6TkRV4YwSkekH924RHzn5GSOFp1+C5HUbYGwmJZkkPlURp7xezUK8IUlxVOuNxFWG1b8rbu3E71CeDA/OxI6KSGNzKf3A1GxnCXy9GloCu1JMssQVOGSlUTH0pA0TlLOploMLEmNWnsxyi5IFbEsDkcEmrwwKykVRRtAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199018)(4326008)(66556008)(66946007)(66476007)(8676002)(110136005)(316002)(54906003)(5660300002)(7416002)(41300700001)(8936002)(1076003)(26005)(6512007)(6506007)(107886003)(6666004)(2616005)(186003)(83380400001)(478600001)(6486002)(86362001)(36756003)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4RjQ7KDid2LWk5YhdKCgFAaQ2+cGDHE8Kr/BvqV4FTg7GiCIB+mrKix/svDT?=
 =?us-ascii?Q?J942iB91JL9S9f+5cuxemFNFkDjad1Nnm9rbIWYGMOs8YHNuzRmW8PdwJK5D?=
 =?us-ascii?Q?ayjQr0prNHmO4SULBL6hQ0LWPtqBNBl22f7ID795FLGdJEJR8zNDfqQxumAX?=
 =?us-ascii?Q?31Exu1vdd3tGjI5E4UtgR/rS93CqPivjwOQv8xpW+s/YXNjT/eQPtNipeGXJ?=
 =?us-ascii?Q?772C8kbTEhN3kwX3A8wLysaUkJ5xk+fi4m8Z4WdGDYN+EfEns24e59zWqQ9Y?=
 =?us-ascii?Q?q5joAa8ZZ625+R+GV3fR//Wdco+jT2H5pm7BN8REruxjYb4aYGnhciT1JsnT?=
 =?us-ascii?Q?8qHAJQ8VJyQokM6cfpHIMLeAG936O2AKQ7G3krRE0LO0JGFGmpcwMA0cAEBi?=
 =?us-ascii?Q?lPNA9eo7ZofirDdrEEyIy+l7Iv/ynjZhXlCBuztoxPp740KC+ZkGWtrhVlfO?=
 =?us-ascii?Q?8/Nc8Ivw1TgkhJhB4+lSLTdk+DIXayb/9Ja5QD7K6Rx1BYaEXFftbb6B4qqd?=
 =?us-ascii?Q?l9hYhQhv9YVf5YVLCpLu7AwLfvjfVnZFuB+QIhdQN0muPnZf0up26J61LDeH?=
 =?us-ascii?Q?ICtDJeIscNkKvWrsa0JUFtTgr/NaXyitOZz1vkjIqRVuhxZEF/kLcnA71oyf?=
 =?us-ascii?Q?fEQX5oBCd9nCJaqdaZWmE5G+KF3K5YqqTM6aDnsuLo0JOL0fxs9BJxqAzZnY?=
 =?us-ascii?Q?0IPPRx/lM06y6INLXtsfIKrrL3FKMba1SUV1o8RGpUrzGtoujmDHqMOxvADo?=
 =?us-ascii?Q?wk8Am/GVl5EBQxPB49nsp9WssbjmCXD6Ej1Ye9x3OlhvNsgwUOVrMa7JxnGf?=
 =?us-ascii?Q?tRpyIy1sPtPhdOjkbyzEi8XBHNg5K4BN7H288pJ7LMWYpJ6N9Ex3+tvJXFwT?=
 =?us-ascii?Q?SRHlOn9RG6khK2jAsZ709iFQ4HE4osMNYN/isbmrLHGeUWZrDok58ttA56Za?=
 =?us-ascii?Q?vIpMPC8dkr2UeAgU1vTMFpv0ss3zxdxCcKpSyxj0LHF9714T/zEzy4SE6u5a?=
 =?us-ascii?Q?4MgshfWP5jibn7bOoNAqfOC4dbWE7OXecMHXjoQUtRmEtbuJ1xYnKIqCJ9zo?=
 =?us-ascii?Q?IAcBaj7Q5U5eEfXUHlvk6llWAnNv7fAxSh8O/hhSdP0uq96U/42FIVs2RZ09?=
 =?us-ascii?Q?Pg9eJTHUmfztz5ZXDflVrKwrC9mRJzRN+fKew0Yrz2iHv8xrxj4XliJGvSlj?=
 =?us-ascii?Q?nfY26GwyD8ammQx37BR2I044tR9me4SeDMWjR9bhV21P3SH4NvgFuOtbxozA?=
 =?us-ascii?Q?EmDqI/0WAhgGrkEYv4ik0xIHi/KFUicnnExdaA5k3UO34y/Mo8Q57yVhZd28?=
 =?us-ascii?Q?3XCOtCA1koqYcwCxb9Z0K1nr9VNVVjiAb469mCIl59W/mPcPaSWSheSuKjVH?=
 =?us-ascii?Q?JwnbjaZ6+YH8wCUaezHq8+6GwZAUpix5xgVI+v/IIeIH+cc/DhVo5Yl78vhh?=
 =?us-ascii?Q?DwI9+ZDwAG+l/V+QgMqP2GwEtimj12URQMMHoLMCcbxVL//cnXpa7LOJmSRr?=
 =?us-ascii?Q?AaYHEUDdhWuDMEyfXIl7bUuwNZ2z1nKN2bR2y7KGG/gTWiIwU9lwSxdR6Mdm?=
 =?us-ascii?Q?kU4x7lC0W7G8bT+SOlg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b46f1637-a2d0-4c7b-e7f1-08db2badbec5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 14:49:03.4597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxeRMOcuXpz0qOKp467D9f/dJOf36to2VRqP8luVHyRJyh94qS2jOxeeIYm2mE0E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9625
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Choose of_device_get_match_data() instead of indirect reference via
of_match_device() so that the implementation can be more concise.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Chester Lin <clin@suse.com>
---
Changes in v3:
- Declare the struct var 'info' as const and remove unnecessary type casting.

 drivers/pinctrl/nxp/pinctrl-s32g2.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-s32g2.c b/drivers/pinctrl/nxp/pinctrl-s32g2.c
index 5028f4adc389..0e2d93681769 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32g2.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32g2.c
@@ -740,14 +740,11 @@ MODULE_DEVICE_TABLE(of, s32_pinctrl_of_match);
 
 static int s32g_pinctrl_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id =
-		of_match_device(s32_pinctrl_of_match, &pdev->dev);
+	const struct s32_pinctrl_soc_info *info;
 
-	if (!of_id)
-		return -ENODEV;
+	info = of_device_get_match_data(&pdev->dev);
 
-	return s32_pinctrl_probe
-			(pdev, (struct s32_pinctrl_soc_info *) of_id->data);
+	return s32_pinctrl_probe(pdev, info);
 }
 
 static const struct dev_pm_ops s32g_pinctrl_pm_ops = {
-- 
2.37.3

