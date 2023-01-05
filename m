Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB7F65E8C3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjAEKTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjAEKS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:18:57 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9501848CE8;
        Thu,  5 Jan 2023 02:18:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDioSXGhRcZKARoiKU1n+KSHjwg6YmgXFAwTa2qQ/SkhL5IO4JQvQdzL23Y4GhFH2uzEgDxCDdknswHzTVJeRrP2RDd3cewdnQ9x9FhkGtA9HP2rHktgS96sTtacc3kB8tc7A1R/cdZ8UAKz2e2H6EnxYb8FFlBkcIf6Ft1WO7/h9KxgqXTmHUtJ5T1zbWzbTOfz3v9CuYLOSBWi/k85Hc/atITo16ZW7mrmwnXvGt2qS7awpO5lC0CBLS8k+WqZmap20Jcx8RwhJekLbrDRy4szWFYQl90baCJUFlKDNRzv2/xqnMB4uLSQMZX3sjbXMJtBMFZSEopxjsUm0ppOnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfcVjV0kIRfDqG7PFRwPl2FL/jWHvmvFfVp1cPsRq84=;
 b=ZAhxE3CPzFVF9s3G0f+tE73iFgeK7RGHIILaZaijopJ7pgsnlC9e7bpY8FVc1qfl4QQ3aWrTC8JCgK6/lAdWvqR2PP5W8wjJTfMVSNRz8PAlx1oECBWJSiS1KwzIJ4qhKzohXqiJy7c7w3qPJUX0ldNZnjN4E6IGZ60G7cGAOS7vj89iKh9EgucY4c5MayRAgv2xrFWL+1G68gFTTZ8KLpMmEElBwQ7C8eMdW9nmEvkGeQkXsVCti9W6xnm5nJXT1WO1/XXSC3PJ+TFJuLn+82Ye/1638V960S3IN20vnr8YnP0f6sOa1UA+EKmieWbu6JADL52vzslxZgtfXuNENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfcVjV0kIRfDqG7PFRwPl2FL/jWHvmvFfVp1cPsRq84=;
 b=fVApOZVuUImO2u4/MyYiHBlwa43mBFMx/BrytB4gBRON+OtmhFCVw1Vx6gKFPFnA1yChW1M/HSYKO7eiLm0ldGH+R/+0vh0lStce+6dpS4aRa+TOlxN+2LW0R/4v1cURwlOFZZSEoeuAfRxrnRpEcinNOhOftVeZvjjMXihkdiM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by DBBPR04MB7625.eurprd04.prod.outlook.com (2603:10a6:10:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 10:18:50 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::f75a:918f:6b4c:4a00]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::f75a:918f:6b4c:4a00%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 10:18:50 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v1 3/4] qoriq_thermal: No need to program site adjustment register
Date:   Thu,  5 Jan 2023 18:17:47 +0800
Message-Id: <20230105101748.6714-4-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230105101748.6714-1-alice.guo@oss.nxp.com>
References: <20230105101748.6714-1-alice.guo@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6053:EE_|DBBPR04MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 0723d77a-a00e-4089-1849-08daef063d45
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bwPXbbGi5lMarK/mXvQgoe3oH2aNL0Fsudiz9E2UZmHT27J+eszn+t61cmzi1mcDEdsAvnJFQ4tY5qBtLVb/pHBqsRevxfH1bbkH8z99bYfHstsBl3BBhEYok07piSwnVKFvQeXofphLkgYjATjlOde2lDCJR6FSHl4ZaBlbS+9HQ8+jomsDo+25THsjLbtBLG1++xGFwykv3oXOeLWGeo2WBLxyq6Owcu1uzol1XKq4qNfeeMq+KgXb95mDncuZbPjkUqqRjZrRokjxZcuPHQxBd8K0wZYaecNWciPf7HIK2D1tA2O1ho+4gsYJ1GDR70hgSSmQ70kHF7rD6VvG/9ROLfi9b3pcrUOljSdfTiF15U7Ap0tF92sRF8j0wc7MSt+wWLj4XQZ4y198nvMHRPiVA3jIgw4aY/JYlOSyUXpeJS65HAIzelr5o74nkOLfW5XY69q3DxBAEKYokF6lDUvS8yQtax3v8zHvd4xZbAyojzjcgwYRbi70cKV3zcwn9f2m0rnsU/0g4lvTJV5h3VH6eHit/uX4XD5b6zpv6P5VvtUft0e8pZLuoeiCRgXMqJfsZNR7cmaghFaTtiOwu2qTKrjvr0AV86wOFyR5vEi2ihxmJG13Jmu0LmeGbokIDnGFaLk7DF4EPhvV6QfT5LXse6HWPzA+55scap/SLFsik1TFMoxvj5e3gQAT0fbxfkIcQb0hq7bdr5TxnH7HOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199015)(6666004)(2616005)(6506007)(52116002)(186003)(6512007)(86362001)(26005)(316002)(8676002)(1076003)(66946007)(4326008)(66556008)(66476007)(5660300002)(7416002)(41300700001)(478600001)(8936002)(38100700002)(38350700002)(83380400001)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xtYN8ugY8OMlnWXM3aqAjBWE0U4pa5htE7pDLYjqBWAh81CG0oRPjIjxpEUT?=
 =?us-ascii?Q?UU605N7Q7cYKWzfhd947WL6/qb1uTDGhntkR6Rs38FNgSDpGR7LlHWGny+h8?=
 =?us-ascii?Q?qceA2ltiWDxkncydwI8VOMDzF28/xxbDLW+Fv/O7EOfP/D10RZqM0aiL5p6a?=
 =?us-ascii?Q?5AIYXySU82Z25E6+LOMyGTb0lqvoz2COu9JMf3zEjLBfCAeYsHA7Vdyx49su?=
 =?us-ascii?Q?1pyJHQNhbNXu2CYaswdLo0SuMk7QFE00agqU378lc9D4ZW3vUcZOv9+ZoR/0?=
 =?us-ascii?Q?K7AOA3f27gB20oDdoLt8Vq5abElcnTl3P2iUl3k1sx4oyu3RBA/9PYFtvV+X?=
 =?us-ascii?Q?8KBjGbBrQu9cjLpTFK1OD+Di3YOm/T2boOtVq2JcuRK8je+0epj/KDVA3PHF?=
 =?us-ascii?Q?w9MoR0PVEIGlKttj5DAGnWR03AsDNuNaiuoHzI8OxSnX6vWVc561S3Nk4fYu?=
 =?us-ascii?Q?BOMQxgA65aIMPyMK8dWdXVMB9alzh96pZY0Ou2XR8v/O8aS9u/KoXwjsRMBW?=
 =?us-ascii?Q?e1n6YX+xPW1+CqQvQsWtbWYEuEKObxHFcz0Oh2g80GYS0aXaPk7hEZRW/SSk?=
 =?us-ascii?Q?E9vWQq6YNpRA/SqdhnrIfbRD5sHxwERGciv5NrcV8o9rc8QsczYRVJ453kqY?=
 =?us-ascii?Q?7K1ok0+meAOpjSWoaxfiDyxJht0TryHBe9OEk/U5cVPlj5sB0AnFUsXPmrIb?=
 =?us-ascii?Q?K4B9T+UIRaUpM++z3mWr1jayfsWEQWrw0tpDOwUmCAMf9mS7qH1QngjZLqgs?=
 =?us-ascii?Q?FYn1qY03JTk8awnriYC6HebSjucUW9EaUZYEfyMevGXe7Pq4nQJJsJ1va3aO?=
 =?us-ascii?Q?opdB5ro6AB9rial/1EneNL8fwflrynGfZn47R3rsu+ZACUiRbNFyAC6ZjBgc?=
 =?us-ascii?Q?BEUyJDdNEQ92TmNCG8D9NsLkAJ4dzObJNR0rSOQxXthQvhBCM7ngYo+e+2CQ?=
 =?us-ascii?Q?WxGJvywKUI9dKZRqp0irPdiH4EhbhoH2tM6OJuj8LU2I/cMbfRpB2G1kbgKW?=
 =?us-ascii?Q?wLLYMxL+s9w+P6UcmWA30j31GfmKOGt5V4bDyWBr86EzvBRAD6nQ/K6pwkCY?=
 =?us-ascii?Q?Sxs5FCDuTsUXg+79NCE9UeS4NsbH+nZFZ0k4b9D3uKp3Drhj2N2Iu2KEKgw7?=
 =?us-ascii?Q?QLovDw1sXolg21+o83F/H7gvFCesa0R3R1uHHcPiidfptmt4MRyluO6Oj6eG?=
 =?us-ascii?Q?W68/g78Xfuj5FOpxfupP1DCcCWntublTzHzLwtzT3Ah0ilTLdF8FukN7rqdR?=
 =?us-ascii?Q?9naew/u+AL5g+iOrnEkmWC1gqju8WPZue7a0cpvJ/k8UM7ESr1zTL+llkZaJ?=
 =?us-ascii?Q?dniBG2+TyTcIxbnL8dloHuuM5RBiFZzaYXyPloNxE6f74bnnDu5le1pKpSyU?=
 =?us-ascii?Q?ACPIcxgPahLOFUehLKUxneqN6ZbuQYXSIdSu7D+DtzGt9OoaVBhpmnnCLtfO?=
 =?us-ascii?Q?bwHk5GbTvhPdfyQHF8Ap0+fthMQQX8ed+lTZ3Ai2Nlx1zfBT+/6i9BeF500C?=
 =?us-ascii?Q?s+3lNj4GiXOBBY+CbsByzT4M2hMEJn7ewR1L5eqd48H2my+inMCBAQ7u6/JT?=
 =?us-ascii?Q?CYb2IA5Zmqo8fdu+O0kKUAx3sMudPz6UHktDSlUN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0723d77a-a00e-4089-1849-08daef063d45
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 10:18:50.5158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9uTmRM5g7tHoJXYHCGEDR/gr3GzEe3BtpHpgf1zu9t/lzkmsxgz60uWf5ZpQxlf5ziRwnJvbEOwZwvoaD9vTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7625
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pankit Garg <pankit.garg@nxp.com>

No need to program site adjustment register, as programming
these registers do not give accurate value and also these
registers are not mentioned in Reference Manual.

Signed-off-by: Pankit Garg <pankit.garg@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/thermal/qoriq_thermal.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 18030bd68687..24ef446414cc 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 //
 // Copyright 2016 Freescale Semiconductor, Inc.
+// Copyright 2022 NXP
 
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -245,8 +246,6 @@ static int imx93_tmu_calibration(struct device *dev,
 
 static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 {
-	int i;
-
 	/* Disable interrupt, using polling instead */
 	regmap_write(data->regmap, REGS_TIER, TIER_DISABLE);
 
@@ -257,13 +256,9 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 	} else if (data->ver == TMU_VER93) {
 		regmap_write(data->regmap, REGS_V2_TMTMIR, TMTMIR_DEFAULT);
 		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V21);
-		for (i = 0; i < SITES_MAX; i++)
-			regmap_write(data->regmap, REGS_V2_TMSAR(i), TMSARA_V2);
 	} else {
 		regmap_write(data->regmap, REGS_V2_TMTMIR, TMTMIR_DEFAULT);
 		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V2);
-		for (i = 0; i < SITES_MAX; i++)
-			regmap_write(data->regmap, REGS_V2_TMSAR(i), TMSARA_V2);
 	}
 
 	/* Disable monitoring */
-- 
2.17.1

