Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B69746DE0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjGDJoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGDJna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:43:30 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2111.outbound.protection.outlook.com [40.107.215.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF509C;
        Tue,  4 Jul 2023 02:43:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAIqOZoPNwFuFVAIW8AsFmg/5UQKLfDc30NOO/bbLFYexxARUN0/tuWch1yWLTXv5C/6EOnPNlHw66WWtct4qE+3I9y2h6nfKZfuMpQoikYdai0FoQxe0+DD68mKqzPprJvGZnczZ/NoQe8BnzSQHHzfCARJ/w77G9TrjbYID2CiKc/PYwNLijTePTilefgoIv18t83m0RwMrPED3O7T21ig4lc7uQsuLXF7raEU/5YST3bBreYlhZ/cQVZatA7gnvFt81uNXUF6v1rQ41/IbQhABE8CZWOJu7pMhnH93ViQi2i8O9auwF2+6LbFsrSbiEJhvB+7MclUgRLxCWoxZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpDzsysTxZRt0yrJPmnU4EvQAW9TZdyhB7OhVnP00aA=;
 b=MjX+wsrNuonAkt6TolVu/CawmhUvNfjVNX3R7WN5eDzNRjyzo/KtyWVNZONU7/UlikSXrjRgIyxCfSXwHOjJ+CKvrc85U6P+vIqRikiERNW0VqVxlHvfOXo0FMTWmsKsZD8DhJ4H9m0Izu+mHQNwOotQVjFUtXUSidexxgTADU9SRR3cVI2hquSzD77nU996x+olafRMSaqacr7mlLPYV0qxRDRaDPZi7w78sdCFb8u+JtJDsLpsOyTLAYrj3OizKgN9DnjWf4WqJHPIDg1JR9KiuadQQKOTHkM+PWyKaRGAu4wnzig3cSoJ/k5DOwZdfCSEtt7jL044V3sHuTh1HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpDzsysTxZRt0yrJPmnU4EvQAW9TZdyhB7OhVnP00aA=;
 b=ngKV1sh7BUyq5CCUmf7lr9kZKR+c40Nmv7Qg/c42M3KzcC1KbmMf9C3aJ4nKHrRWugneSUA8/WmCfb2Igc8XkDoV3N3f6s0PvZtxQOY3cz1leHTzf6hX77iYte1iA2cc9wDxlcYPFH8S7memvlo1ATLeJm6vn/vOnGXOaHCfL6ULWfJjd6UYA8NclAkjOudfp5QkDmdEpzImiz4gpDY+Nph8imtDOBJou4OotQkSTAicKOtaneQFIP+EibhGpyXM2+1NmlgiABGI/PNCYmzsckimy4M8v9zHVusag0QW8EMu+KvyhSlbj720Y7yFf+PCuoOUlbV6bNu2iKkm3qxSlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6743.apcprd06.prod.outlook.com (2603:1096:101:17a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 4 Jul
 2023 09:43:20 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 09:43:20 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: bt1-pvt: Convert to devm_platform_ioremap_resource()
Date:   Tue,  4 Jul 2023 17:43:06 +0800
Message-Id: <20230704094306.21933-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: 0477b216-23e3-485c-7529-08db7c7319b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b69Uyg8aCU//kvVDbmTGhRTS+msDI/FCB81JasRv+W7KwOfzdPQEAwgrPHrTccVOJa4mpo0YNPsSZ+4RqjIe4fmofEhLHUugjT7p+SYO7Rz/Or9fsfKiH9TYJsNfv5AD7eg6Dkq5p/jx+sV7YIh0sBE3xJO2g03EaxVlQX9fnulO3TY9DavAZHEuFVQXYDOJhhNk6HBqmFK3tbBaDt56zASrsWq+9xaRsf5bU1qa48gQKUAin2g+EeS6oj6TmBK4oRGRw6C3SFWKLqb06SkbGAN7ewOc1+FYSA1IIZcuk6uXEeXYFy9Q/ctEJwhBQAqn+p1F3iMWSqc/0xSLTUZxypfQ8f/VNmvdgQdzI3NfUOFjXS9GkzKMi9RND/02aRxrwm2wVsCooUSpYSdnRYE4rEdVPQJpfj/c0l8N7VJd34NN7QKV8r4a/1cq55JLkqUgH9FV2Ey3+el4Fu6GruEdfJdgTtk7VQ5qttzfQ7DsvF/j/UorZw/3zilBfvSlZGDbbhEZJmcSIymDsxg3wuwkC2NRV+4rgIkbX94AOEcfQflXUOS0wK5zZ62tfWpc7Pp4tjAwBowavG2g2IcpNCkFT0Fo9dKKOLtBZzEYYn2EdcPK1/AMMcARzSecTrLuRDdd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199021)(6666004)(1076003)(52116002)(4744005)(38350700002)(2906002)(2616005)(83380400001)(38100700002)(26005)(6486002)(186003)(6506007)(6512007)(110136005)(41300700001)(86362001)(4326008)(8676002)(5660300002)(478600001)(66946007)(66476007)(8936002)(36756003)(66556008)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1sODQvWnIzh/Swv68s4yTcyO9G0qRfT++nJA6AxA53Zd5s2xueCaSwkkuuvM?=
 =?us-ascii?Q?A+XRo7q/c3o0gfzJCvk/oPxv74XsWwy+iOwRObRQnqLhCkDkyujnXRrEGYF/?=
 =?us-ascii?Q?zc2a97DwNH2oTPAslFXkfayL/xuxtjMt/VU73qF9VTub9WeR2RWkhBe6hNvh?=
 =?us-ascii?Q?qwjOLPJ/hIesoJeNPO/U3y4Mk+eEUQJXTJ6ojBJNyiZkqxStfcYRqFoPSoF3?=
 =?us-ascii?Q?B0x/oDBLeGUIPoff3GltWy0PqjpxY1soToY4IrFrWIu7B3N2phRDeX5EE6vY?=
 =?us-ascii?Q?S90nEO0sBCOz3/Rs4aXUW4YJkTRqWbkyiOGHtAmqYUgjrvK7KhqRmwJ9Jfd2?=
 =?us-ascii?Q?mzUNW7s6gPeBqpTFYHmHm8uvhUw+XNErMs1JVy/AefbNW7Qu4oyRtr8mTBZF?=
 =?us-ascii?Q?aL1evQqDTM6DAR1kQSZujnovf+upOapFO2yoPqAmdC3giX/TRWRDq/e+aYkD?=
 =?us-ascii?Q?pxcFxlbqJmXqjmI3A6juVRYh6wAJrR1r/qBgllZoVCL2aYp9y+UEt5ZFKidc?=
 =?us-ascii?Q?3AIvn8K/oieITf6Tsf4fvrHFGtyj0/0sAG4H9A+qzSuzlurDJvT66gaUF8vA?=
 =?us-ascii?Q?/jyFRDIi6MSaBkoLIskJfmgVdLKkCasxCHIgvB1IDaNQ05SuRBo4hsiRUh46?=
 =?us-ascii?Q?TD2XiQXr2FJfiAMkPz1/7HowGTkkPO91uCB3/e9fR80zOUJ1n67Hd1f+RJ09?=
 =?us-ascii?Q?VUtcuz8XBRYsCUrHNVbW2RbjkifZEhtFXk+WhWi3vrvWsp9vIoeJUQ/wq7IB?=
 =?us-ascii?Q?2j2M0Npk5/rt2sl/GE/+VANmvs/rKD6TMpUo8YcexC72+vPrOHuG9xmeKyMU?=
 =?us-ascii?Q?v3Rd6AgAFVOzuw4o9TLF2hvrsbuAc/dhf5BZC4NHiN2DeIgxgDx4SBpk2nPr?=
 =?us-ascii?Q?syeUc8asb+vGGVfHX7ny954GoQ4jLdsautGkC3FHeLuQ47piJ03C0uShRPUG?=
 =?us-ascii?Q?mbhpiHYO77wWj5lVXbpHL0ZRxuVTqLW/IA8VQRJqoCdmrc7tm0nQleXsbOBO?=
 =?us-ascii?Q?0Q5YJgrA3yqASo0TZXThmbs92tOhCWYjcl9zqJHHHY5KnmIq9qIQhvgHmncL?=
 =?us-ascii?Q?bRBMBobMOt2lDgOjKicDDD7u+sSGN9/seY5a2RFSlMKQ7w/bXGABVJUvqeyd?=
 =?us-ascii?Q?HLXlqpkor5dTW6iE5Ke1ckRuj3OWu8OiyaQJ8k399zy3x7WPZtSyiVSMU5OC?=
 =?us-ascii?Q?CT3xH1CQu4ZS1qUhxYtVVOQefXM8J7hPSSswztTRqJxKtXjcAvoW+gscWmUT?=
 =?us-ascii?Q?ZqbC1i8jk4UR6eAPZT81clAftz0o2I0SuSD/bBBkK1ZEkb2Nkb07TX2S6rrn?=
 =?us-ascii?Q?OiUKnt9Jpnj+Rd3uSQBI3L9AsceqQtDDy8LVp/TvbhrL9nV3QYZvf1MoKQJW?=
 =?us-ascii?Q?+usPNcfYAdB2G1USHMKhn1OQNKdbglHCuEPgOQmqzq4H5UeEFa46H5kW29Md?=
 =?us-ascii?Q?RXj1Rtu7IOQ72GYf3Q3XWyGKqEDR4XGT4Z9CW1NkqZUnvpM73l+r0ZMqfIWV?=
 =?us-ascii?Q?vdioRf+NaLckj6UQdxpIYCDLY9ovsXzZP73M+fkH2FU9M2htdP45IekaR/0s?=
 =?us-ascii?Q?Trl68UTZ1ES3cfcnYJ8OMMPxp4diuG+WxBJXUudU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0477b216-23e3-485c-7529-08db7c7319b3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 09:43:19.9573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkyCZzzFNJQA2dI04YS90QfNrci2QDIZ/qKXx1qmaZdEP1ibv0LRgHSgAfzx/Wsoc/WkfpOAZDGeU38NHSaiyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6743
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/hwmon/bt1-pvt.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/hwmon/bt1-pvt.c b/drivers/hwmon/bt1-pvt.c
index 8d402a627306..b77ebac2e0ce 100644
--- a/drivers/hwmon/bt1-pvt.c
+++ b/drivers/hwmon/bt1-pvt.c
@@ -891,15 +891,8 @@ static struct pvt_hwmon *pvt_create_data(struct platform_device *pdev)
 static int pvt_request_regs(struct pvt_hwmon *pvt)
 {
 	struct platform_device *pdev = to_platform_device(pvt->dev);
-	struct resource *res;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(pvt->dev, "Couldn't find PVT memresource\n");
-		return -EINVAL;
-	}
-
-	pvt->regs = devm_ioremap_resource(pvt->dev, res);
+	pvt->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pvt->regs))
 		return PTR_ERR(pvt->regs);
 
-- 
2.39.0

