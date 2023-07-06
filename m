Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF206749926
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjGFKMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjGFKMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:12:23 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2135.outbound.protection.outlook.com [40.107.255.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A261AD;
        Thu,  6 Jul 2023 03:11:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nc5reNbdcEjEGUl1RsUrlra+zCeiPf4B9uqOLk6ZOCpsirV2QK8bONNMHFInMxECp8ZZJxyGwMUdvQyWUNZMcGEE5/8BXJMk/i3YQFO+3c69fI9DCeZDEasMs/tVY0N3MssWE96DzW0cHt3nYywYBBgBRj8FvUsnLkR64xQEUHcWDvAxRYKJzcPAvA/LaoOLBsPAjqvyGsWtjMSATQZB6hh+RdWw1Ht95eGRuTDzgu5sBTOukEABGdxiTGNP2nVVveCDw0rUXKxGo8GQViNkpyHqG2MX6/F3MvtDBtPJ32VAAh/Z+bln5/9qDHlxZ2aNao+BYpxPmP8cSKZrWi6psw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAUcI02Yc7OXoIuTsiEMw4YZ/QUqDj0TAykDjwwpNhE=;
 b=OeJy3aPM/F440SEw69DRNiCyemjGM0z9nvj7Tq1SGCJuxRuEqKzS8El3gqfBoxRZkSNUbE29wqfRMm3TEw8Ijrhc+TTBUQ373Dlo0FOdD1HatBN7kg0Ir8fd7V1rHW0NBtxtLCM8AycLcYPHWwuPBDX8n+NwfY1lX3CW6bpRJn+nBuQZs3/DDL82SE5gAWCTR87zu3e9lzT08yesLCMdpfZHej3p/umubQezbedWnXzeCFbfoYtmH4zPbnfTjeTZPjtZQAVa3lDFTDHk7Lbe+nJEGZXAlT46ecMGGSb4joHq5JZfmziV2D2+eWLvr0AhXHKK58OFUfvVPnS7N1CX4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAUcI02Yc7OXoIuTsiEMw4YZ/QUqDj0TAykDjwwpNhE=;
 b=KHgMTnidlhlBa+TFzDrf2QZ5ML+ZHku+Cn3PyISIvLw6GmmFsgXafsGBQtTIkGb2JNDuY8zqpk7xGQ4GVDXMJp+vO2f+oZhtXgd6895qukj5nxBSoP/QY9B9w8i1rZ8n0O8+52wyVXawkvMyYnBAmeipI3DztxNdLbh3cc5tzlVGv6Baz0gXUBWflVooN62Wt+j1UTC7O+bmlGaISTSl7u8FHTGU/3cJD6t8Y/hAzmLWrV+fGbrpgud5ocezKyP4DDxBuIxDeGRYGnEyeBjZqQnxb0Wn0ufWZTE6TIYo2wF+zzBKB+5rkLnKNzdo9NwA/jddkQrMvDzv1wAwFVdl0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5287.apcprd06.prod.outlook.com (2603:1096:4:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 10:11:30 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 10:11:30 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] media: sh_vou: Convert to devm_platform_ioremap_resource()
Date:   Thu,  6 Jul 2023 18:10:59 +0800
Message-Id: <20230706101100.75654-11-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706101100.75654-1-frank.li@vivo.com>
References: <20230706101100.75654-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SG2PR06MB5287:EE_
X-MS-Office365-Filtering-Correlation-Id: a393bacd-6712-493d-6dd8-08db7e095de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSuhnAxBkd8BOkOvcIVKJRKOywbosLqx1wcZBux6ADuCNacsNBvJBJs+K+iqjOfwjJMGmy8c0VqP3ou9XZw8HmZARjSB3Kwnl7BxFm13tJaVZNehoahZfxtfb3mm7vmaHCVy+GUFlTzIDUNcF5qtkWJK47UxmnqprEYrAEI0NHHAFlB6Qc+1Ac8O3kHviti6cfO6c3xzfC2E5D1m3wY2UdbC/pZvOZSWcvmwyqYTD5my7Pclin75+Q4UBKpw1jL9sRGmq4KDPFrIW87N2xGzUiVHSgoErvpQGocm6ik0SGVQ0yRP3gdvRWCVJjGtf2phIk7F4ebvaKTBXb7aSQq9hDvliP0JacOBo+mh8XY/9S8XA5Ef/27TlSPEsslvkAiYLAmoyJEbasLQ5xjv+FEzlQgg7I49+GmQxDOAGCBk3+DjyjFIEsGXy55Wz3+ltaoyjHMHfY1mXt0LwjNY9n35Rxa3wtht/4RQ5YqLaRJWqNsjaV2qJlIJPB71xOgjPZxJK8pBlIXO4VGEF99GABcezfjkyjEw3Z/uAW2/4WvsB/Kd2jSxByL+xNsTC6MR8kEjJoks1Qa43yb48X8AQPIinZkVWQL0+wVs3+RRTS8lqY6uUXJvaZhflotDIZxDDgXP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199021)(2906002)(86362001)(8936002)(66556008)(8676002)(2616005)(6512007)(6506007)(478600001)(6486002)(1076003)(6666004)(52116002)(186003)(5660300002)(38100700002)(26005)(83380400001)(316002)(38350700002)(4326008)(6916009)(66476007)(66946007)(36756003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PJThTOQ6tPeaBY5DOLWxcqeU4r7U39C+VKPK6fpB5cjXoj/ksWZqsBMw5xI2?=
 =?us-ascii?Q?A9ZG7f1v3KB+mcVmi5+FqpW1w8qGMY2+KImvdmIkK8fkewd4UiM7ad5q9jBj?=
 =?us-ascii?Q?/4IxhwN7wXIWrFlkjZBUTIdEd/bhC5uiSqMAMzSi6NgTEphidjSZ+MiAmGZZ?=
 =?us-ascii?Q?8ovIvDVag8kWF3w6bBU/dAH+htpSI74ps7taAiBJk8EeDTRqsmC6ibInbh5X?=
 =?us-ascii?Q?EfVLLi9uE1zq0Asuq6A0DNqMVUjhP+MlVEZGcQOMho1XAUXR/fNNaDVE4Ggn?=
 =?us-ascii?Q?AegvpWabbbVHzvR1Dyl6NEnu7u4ZjoPg8uhx4bekGKWJCTXzU7UMNCTPZ6fA?=
 =?us-ascii?Q?WSVHQnH7a79HOaozyZ6iyjGVUZ9ptxhF60OkygoJ7aiWOiy79hSY1V07Tr4I?=
 =?us-ascii?Q?m8uhcPu3gfleoQEWwwF/lb3l3ylSdQ/0t4I1C7D0etM++NuPGgh2/dTem4rD?=
 =?us-ascii?Q?c/96YA4eazjGfY3qj1Ez7KPwN1kvV/Ux29DYLIsfPAYUi+0XZ7YqKM3ptZsJ?=
 =?us-ascii?Q?j2YwniUnOYPv+5AGxkGa3mHUCmnrIVWtqj4TI6Ous+AP4ZcdA2AxYXXuBYrU?=
 =?us-ascii?Q?IiLCYKYLCv9fVac4lh1ivWZg2jNl236OEIFynPn/NVuuz+uQ4OPWV2TcGwK/?=
 =?us-ascii?Q?Sh9M7ulqJIPuTxZJECyqquhcPaaF1r6WR3ae5nmrNcJGyZd2b7jcXLIroBtD?=
 =?us-ascii?Q?g7kKEvCJRN/E67peOo2zAfndrx9YJLJeNoqsEQTGUkqA/+/VwwGyv11+YXGA?=
 =?us-ascii?Q?8OHSezMWxUg8ChJkc2wNZ7wjVE6q1PsvSl0DP4NVTezyKZZ5G4yReb9Yd4ve?=
 =?us-ascii?Q?j82cF+qNXE5G48GmeMkfnBXjAvazAa0HrRmIEmoJcMRX98+I5Vk22orqmr4a?=
 =?us-ascii?Q?Z9c4/LCRDeYffm00ZcGNPmEKIBZvcnAi8O9a5bn6/3PCzPHd1Yy96cA1o1G6?=
 =?us-ascii?Q?vUzrZ09mWZ2fN3N4+DQpam5V7XNAzk0WZUV5j4MwJfqlDiX1ojlROOn/upI8?=
 =?us-ascii?Q?j1VEy7XvFxQl2QHbzUnNe7zR2lhofkQ2hFiXLMcYyod7vN+ihXto4nHrCGRq?=
 =?us-ascii?Q?J3NDPkyNhx9S7y1McrKDCpBOo7dsYehWL2cBHhwn9I0oUzeCahfpEsxlXDV7?=
 =?us-ascii?Q?VBIn0eJaOV0VdTKp/Xv52BdLwd8jPo/sYHxcHFVyQ0AhxwbQFbgpgXh1uTeO?=
 =?us-ascii?Q?A6L6ZwrHGQEhku77wpmo0vVEqrFezA2b8Of81lzK9QZFlnLhC8licnhonUgH?=
 =?us-ascii?Q?eQDnE27pgz4+jRZDbtBqNSK0rH3JkkkggGJ4JBfPczYg4jGJDI7G9OCKxQ9A?=
 =?us-ascii?Q?3jLXEvffQ7BMdLzv7OM9NRuf9QR2zWTi94i4D1Y7sWJmKvncITzTXtl6NxGh?=
 =?us-ascii?Q?3NU+6UZMraHZ19Sp7oxCtwpILUeoD/ZvSnfLcY5RhFZsfeMXTs5pHNZxoAwd?=
 =?us-ascii?Q?GGU2C3FlUuwDFyQodt946ue9QA5d8oZGX8qcLK7L9t77bSJVf+YUpd5pfKnM?=
 =?us-ascii?Q?t2qe8cvKvETrHNM5pqzjMrerMWZClZmLRSLMQku6INY/eNkAI4DwPeW5BkId?=
 =?us-ascii?Q?QzT+thdM7091zM5JNEsZzUnoNcM2H7Q0t4eomDjd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a393bacd-6712-493d-6dd8-08db7e095de4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 10:11:29.9540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUL+4zIW4Ou1AZQIYJs2OXVMrXN1NadREBep/e2z/vCN+Sm4UrZvX6iF06hbQTr1u3cP9pY571fKyCoTVu4IWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5287
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/media/platform/renesas/sh_vou.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/renesas/sh_vou.c b/drivers/media/platform/renesas/sh_vou.c
index 8fe3272a541f..f792aedc9d82 100644
--- a/drivers/media/platform/renesas/sh_vou.c
+++ b/drivers/media/platform/renesas/sh_vou.c
@@ -1223,19 +1223,19 @@ static int sh_vou_probe(struct platform_device *pdev)
 	struct i2c_adapter *i2c_adap;
 	struct video_device *vdev;
 	struct sh_vou_device *vou_dev;
-	struct resource *reg_res;
 	struct v4l2_subdev *subdev;
 	struct vb2_queue *q;
 	int irq, ret;
 
-	reg_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	irq = platform_get_irq(pdev, 0);
-
-	if (!vou_pdata || !reg_res || irq <= 0) {
+	if (!vou_pdata) {
 		dev_err(&pdev->dev, "Insufficient VOU platform information.\n");
 		return -ENODEV;
 	}
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
 	vou_dev = devm_kzalloc(&pdev->dev, sizeof(*vou_dev), GFP_KERNEL);
 	if (!vou_dev)
 		return -ENOMEM;
@@ -1264,7 +1264,7 @@ static int sh_vou_probe(struct platform_device *pdev)
 	pix->sizeimage		= VOU_MAX_IMAGE_WIDTH * 2 * 480;
 	pix->colorspace		= V4L2_COLORSPACE_SMPTE170M;
 
-	vou_dev->base = devm_ioremap_resource(&pdev->dev, reg_res);
+	vou_dev->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(vou_dev->base))
 		return PTR_ERR(vou_dev->base);
 
-- 
2.39.0

