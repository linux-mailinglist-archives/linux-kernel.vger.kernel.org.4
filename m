Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E360E6A6CB7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 14:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjCANAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 08:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjCANAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:00:33 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2051.outbound.protection.outlook.com [40.107.105.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E153E0B9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 05:00:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NasPKamo16H3Eo2TfPXi10zXTjdmF/qV354Zqy+PZLdt5fI5VwZfakOGeoGdk8mdKj5UN8LezbQLZYfF5+rtXdABwvD/20HJZjFbpYou9NFNTBNFJ3Jt5hlUnjvG7OA+CoatarLIc3BFTPl4A8wJ0g/VpJqPtMG09jK6SwbR36HQr8NH7vWKos10wl7Zxi2HZIx/P8JsIv/TkRS7bSHAc8FfMMyTiZlGA6mBc6QrQmFEOZpcmqieeVy35+YSJCu10rYcjPLctwV9jqcdwsKKmm2eVLIQEvWDMz19WX8QhNmGCX7Oz+oeeYgVKQQN0FGhQT7lm5jgCSAzCdBhCVRZmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n78rSK31LIM35Q8xYxkUbwZkg4lE3iWlUGIYfQub/SY=;
 b=PlR+l7NJgE0LjAbrKtmbLk2fGYmkmEqsjGQyPMWJcMb3YvIf15UASjblADEUataQ9jytqbZm1O9r0igXCC5fpIm42iJMCJMfeMLSx+UvmJdYOiy/6y8Mz5IdawKmEH0S0C/4N5rK+zvqc41SOVuyK8oH65PbXknNQKXGj7mdBEeK28H3IGzL9B/G9+6msUqi6cUIVHrHbbE+cC3opi63f3XP2T2oQ8KFhBwsLZPPPWTAYWh6SKhKDQiIvM6EvKD4LKze45GueP3BeWi+sPNLZZVhDNdycoCl66iCJ1yCC5P5t62+8/1FPcf+X9f/EsM/iwVMklWMVE7+7iy7VLUL6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n78rSK31LIM35Q8xYxkUbwZkg4lE3iWlUGIYfQub/SY=;
 b=nDf2YHZ7ZioO/VscSkwIFEsurFE53yxrBHAQom2KhH3hR6o7w4I4I79+GWPiheJ4yHJH9J0/N4sgigIE+a0hrpcZsfiQlYTSrfFujjbTmIMq8GBGsEJ/YNa/SHnRBqpq+d6U6v5prl+Dexu5GE5205bE2YQalKRnQdZTvqOWkUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by AS1PR04MB9335.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.20; Wed, 1 Mar
 2023 12:59:45 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36%6]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 12:59:45 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        peng.fan@nxp.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, m.felsch@pengutronix.de,
        jindong.yue@nxp.com
Subject: [PATCH v3 6/7] soc: imx8m: Add MODULE_LICENSE
Date:   Wed,  1 Mar 2023 21:05:56 +0800
Message-Id: <20230301130557.3949285-7-jindong.yue@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f5dc5ba7-8a8a-4b50-7303-08db1a54d467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yIGUtNEYNjimaqqVRZdBSwRamaJh2EaLeLydFae67YLwny9VmP/v3yzIYc/TA1puDcRPq7HUmSBht67WHV8vCf1MfmaR5jFPIxUaK4FX3ZbuF0qLogAVbe5gRdPjrDoFPNSjhdQe4alnjSfqYQ4pPsEVHAc0/nRAxcRzYukjDrMZNqCq5rDJIK5e7C0Me/MTcXRAmG+u6zg8ujpRmr8d9YJ/UhYWkOW+akcPe6JOAzxMb8gTm58ROXDA4ynoyWRgMPTqIcT5ml2XTJ+Mv21ieDsOL+Rae4BDxpmHSj2rpR37FLELYAagj01azqbH2US2zUX7rk/wd1RQhUgVt1bShmteN5bbjRRgPcB7rHQQU8moMjxpDj8vnnSr8D6N5RCAFVfMi+EmF/pbxUiS+fo4l4rqw22tuS98PIBQrQxAtsHZqDBWqdM9sXWi8RssM0nbFhaYobqW3G1g+QMbkOmplYWqe0nGFksalhW3NQO8V/NszTvKnp2aP90odYRc0kRzpWnfG8fYFonbwO98nh3WVudfI9fr0XyJIpdd8+VPjHXVrsdz112Z7+gzfXV+H8W7+mc5OcAobfbQYaHsRsAzb0AqpQbR9jRrnEnFda04YKSs5/1uXZTrkm0v5M2tqRDhAy1b9JPzmG5VjE1R4qhwKcknLyhMbq7pqwa5lTkabLxfhMKgSOSZn6G5SxGFTbXi9wNstm3ixwvx1+Ni0ASYQBwQ6ZbPr+rH35CjNh43FKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199018)(4744005)(36756003)(44832011)(2906002)(5660300002)(6666004)(186003)(2616005)(26005)(4326008)(1076003)(38100700002)(38350700002)(66946007)(8676002)(66476007)(316002)(41300700001)(6486002)(6506007)(86362001)(478600001)(6512007)(66556008)(52116002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7VEan1RpHhVJNvyEnzcr4+OGBUvVFfJ+epXpRpqCZNZLFjrIPQeQsuP5KMnu?=
 =?us-ascii?Q?KOiRnLFK/cYe6jrZDz/Lfw/7zSPs6f8aFW+ioNqlaCl4I6PyWH9lKRaw38Hp?=
 =?us-ascii?Q?YzaG0X4XzjKHSp6NYTkjnd6P0s34lS3KIr4dDweSs55O7RTBttOVoeQ/qCpd?=
 =?us-ascii?Q?clg90pGH87MCRkuGuIH6Tf0xPn4XQ1VblXT+sMXX2Xx2bWYlEEWzaN7BTmhC?=
 =?us-ascii?Q?5VJwOorC59H3DarOTIXgEkFit1/KEG8AiPRd1dEMF9wzTzvzffW2cBXBsRWa?=
 =?us-ascii?Q?k+FgNE57h8H9lyfoZZE8EIJv1h1vWy9Q4+2edbzKMRcKBhsF33k3xK293RJr?=
 =?us-ascii?Q?fX+MJlDFYCyURK3uwf85iVoSp4uXoQfJdh+Y+QExcDc1SlvUpWV3UKvm+8x7?=
 =?us-ascii?Q?KfbYFY0x0tvYzjqMaC0ZzMYwlKoosjVKpvw0HoHlnJ4eDUudQih7dp2r6rK0?=
 =?us-ascii?Q?wvJq1qL7pBeVq5gn35IaY6yQAYcg19KAn/hudk8iD43t+PIUql6EyD88v+z6?=
 =?us-ascii?Q?IgGm0YTr0T+35uG5CPDVT1DE8TdLVlT+hLoQp+BID51F17/p4vowebFQ4F3O?=
 =?us-ascii?Q?iO738LU4vX+VfqXF3Mb4QWOzFQbnhpPlP7QPLhVmkbvGMSVVGh6mrN+0mLh+?=
 =?us-ascii?Q?3ycihucLroRlk0YeVgm7gonEsUcPN9u0AncPC4WuVRKVS0qo5sTOarb+yUav?=
 =?us-ascii?Q?eV8bWIUeEkGqfDluDn9FLzu8R3qCq0zHTcUaqx5shAbZagel15fx+M935Bx4?=
 =?us-ascii?Q?erYcjQ2lk04emdamlzwqvn9w5d3DLzBwyTzP/r6ITlrvNxV0yyC55x/a2wgb?=
 =?us-ascii?Q?KGf9S+xrd6qUlF3K7VCUwujjNTVW/aaj7CCii6V6kLh1/2BfVN/wkDKaM4ub?=
 =?us-ascii?Q?fZW1gcyyN/s3uKV+MYwSlIVNvlCJjH9A4jIR7hF+jNjM3+3dpdsC38Wfe+O7?=
 =?us-ascii?Q?GZDsH/tnY7dXc6A+OSOxITmGLT8nOvkhh7q1BHX6U5uKnpAX7Kzq/lqo3DqA?=
 =?us-ascii?Q?MkDTVvmn8sppqB5Sof5yOqhhRmVjXxXqKQ/NmphkrgMOtEeTsGNy+o2bBqQI?=
 =?us-ascii?Q?/tyTNf4rS07cjR2Xd5zSSYHtztd9zRiflTpSsvEpbc3B6IVZ5A0cdyxBXfz8?=
 =?us-ascii?Q?pGqH0lv8uFYaeUzMAee7DWa3GYUoibZIwze1Cgc/sXitrFLFU+yiVzfDe5e9?=
 =?us-ascii?Q?mAbaUE4qpBkFVZ3m081VQKbxO6WCMpoDNL+ZUj3Ojqd69BZ2sih7zj27k4yD?=
 =?us-ascii?Q?veRt8mHGsq18cc4bgaZdIj4nOWborGl67197+rIfoDpAGGc6ZR2G73XVwQ4L?=
 =?us-ascii?Q?IXrZvDs5nlSwdmpDY2AnNIf1z3oc/WDvbefHpSgeGgR3VDXmZI0Sv1Xac5wc?=
 =?us-ascii?Q?Dp92i/csxCaFGX86dKPoOAEm2ztZ3RwG+o2DMB0drQfTtdNiI0GAAH0vz1AW?=
 =?us-ascii?Q?34q07G9vLS+Bw/W4PbX2G8BH+QnQ9fu7uxHnqEo2IesMKzs7WS7QqS+Nu8eq?=
 =?us-ascii?Q?6+5RM8MD9tXyRGR0xjgCzXhrfsb4LRSf2VrVWcYMO4rUbM9GK8n8mB3liEig?=
 =?us-ascii?Q?lgvs+d5bWO0+ix3WYR2F2czR1q5MtSMUj6VyGdfb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5dc5ba7-8a8a-4b50-7303-08db1a54d467
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 12:59:45.3524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSFPM7Vt6A8r9SfoVDLhCerEFSfGmvdCpuxkTp3WvfwcyiEx7FkrjlsbwT4Ek88zLRzLAVw9zHh410VkC27K5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9335
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MODULE_LICENSE to support building as module.

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/soc-imx8m.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index 32ed9dc88e45..1dcd243df567 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -242,3 +242,4 @@ static int __init imx8_soc_init(void)
 	return ret;
 }
 device_initcall(imx8_soc_init);
+MODULE_LICENSE("GPL");
-- 
2.36.0

