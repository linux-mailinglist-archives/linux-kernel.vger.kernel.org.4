Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57564748492
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjGENEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjGENEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:04:34 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2102.outbound.protection.outlook.com [40.107.215.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F197E3;
        Wed,  5 Jul 2023 06:04:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ng65VQxeHtYjR+cDaSX9KHUYHuvun34DBqOwgXQU7Lt6eIN8bq8ip/AkhaoMYfnMIUQHjzdEvtKcEYKI9IAMn6cCiBxfXJ2TG/iNis8zJ5Jgg1Ainxf+hiReAbLhZiUJU52rucYEJydES416s+j51W/q+4BNRznp+8nX+ZR1UvS3ZBCKqPVEr4MdwD9ML+1RWhtcwpwRLD/9H7qvezXSzkLcOAiQp9HYtcTP+7MopbxMvYiwr4F52zjPuXSZCCAl7h7DpX/1OcFi8N5vgT19QJp054Bq9oFbg3w9/QwkXTPl0XLtk6FYHMa4+6Xp6GyWUpLZcUKxXHutVwJVvsH7aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnZrRpWJHfvggV9oAys2Y2gnnknH2ZnzOeA1IXV7vWg=;
 b=oZcmZUe0bNXSI/qaIaSECmnIw+1yGJ8iuS9SBXwBnqISlJXSxcx592EisE0s4oM917XXjcRilNdpAlilh2l+PPP24fIpO4MXmUPjInvJfbrh7xuPjYiEMaW0L40ocbVxQhyZJ5rEDbdhyr3//oCmYDrAJaaYiOkdQ1c31TLxybd3Uh1I6hP/8UGIzjT7wearEA3zjAfXrNUTkQF0QaFxY64ZleIM3Qawo00DX2D3MyYKjoHIn7Zw4acr55imejDHOtycbaxGADv24+hGtIutCdDGaSZZ+3nofnpe4/r7KXMF3Zsbjl/kpJGuNh4Kt8uEZYjl6Y2+dtQM0xNz0i4Rlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnZrRpWJHfvggV9oAys2Y2gnnknH2ZnzOeA1IXV7vWg=;
 b=lkuByXzIUjiDk8p1zQn3N9Oe+TuuzCboow58qEeLlqoyQesGT5v1WBbV15s5jGNhh3vkvq4S0FYDa63j4v8SX6+/dMaElaVJoCsrmvc5Uh5HHVCdNHvHZ1QFgjtPNMDHNu0dN/L3b34DC3llEGDFBaq+du0t+vvGO1o7Sq0EJ9JrLfHl2BDfYjwzDtycmAjwo9NGVUXhLWacLnEtiwiY/2+c49rvERe4iUA+glSn2V+Pk1GwQ/450cFnP9/XuH2ohkruMevanMxIipfiPzqBRCcd7bPRsJ/ZmUDnJHIBiX/8dZEUALR2Dq1WOclREF9jakUV3fmSv/dmJ0r4ttGQ1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5891.apcprd06.prod.outlook.com (2603:1096:101:d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 13:04:28 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 13:04:27 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Yangtao Li <frank.li@vivo.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] iommu/arm-smmu: do some cleanup
Date:   Wed,  5 Jul 2023 21:04:11 +0800
Message-Id: <20230705130416.46710-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: 05494a64-9f56-4433-052d-08db7d585ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: McY1nBu9v1+QdlZc9nLlEK5JlKXs8ldPk+iprhqABp4nPrZlxmY+EaQnE9xOGYKsNjZsGLEIJfY1wG9UiQda4aABUVnyX8dNGCY04meuraykgVcbsE+ci02N3w6hM8VqoUa3gQAmT6UBmAdGF2PULI2/bkPmq3rXSYb9hwqTt+GmKZ2D0zwBpBDurYwu886kwpSLlxlz6p3RCh3uhnHOSJa701yRSRzT9qCkswNAc2xLD/m4ZxySR3g/VhBp4eBbE1+DxDFn17ygHi4YTqNDSNN0hy0p90P6NTTFTUn4f9fb+B4V0sa9QbKnvrR9lg94N+mfPnh/vy4StDYCqqOZm2ycPPFjD8KDQo94AdUn2E3uxe1FZPDrz1VJtQ4gtXDPgiLwJoLZVjuN/oiyEAOK2u079WEbJFdl48/JwYbLQg7rwv4+yxG7aOzrcL7o/pyK8pgvPfRKWTf6HMCPdkGXMWtUnsTpaA8QJh0U8Z3vnixQKLKhdtfmcTbb757vsaj779iYVWrkd+Jer+GKKMAWbMfRScxDEdze9YkqbUGa4VqlCQg0f2N4u68/0gt1S/hesobzcP4t3wppzlnxA4MuA02O2h5H9+5hZl8v9G9RPR4LAhfGfdZbxKVZa1HYd2p3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199021)(478600001)(52116002)(6486002)(6666004)(110136005)(66946007)(186003)(6506007)(1076003)(26005)(6512007)(66556008)(2906002)(41300700001)(4326008)(66476007)(316002)(5660300002)(8936002)(8676002)(38100700002)(38350700002)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z19KsaawN9vhDVn/lRMe8cJUhv+MSh/xFLl+f9pllhSleeJsRwJcD59LANXm?=
 =?us-ascii?Q?67IqJ1o5a6l5ydt7U3dLd9tag4EIzmUjAOEmCu4iTjN+weyakB8EQ7kTqxij?=
 =?us-ascii?Q?W65nl1x6L4l/52FXvMKPqG5R0J+hdqKQM5BFQoZdX2yfk8g54ajyt8Qqg2B/?=
 =?us-ascii?Q?IMWoDjziZJ8pwGnR4gift5sOvc2UevXyz9X6fdi1lJwT8zQ0ZR9+b87qhgZG?=
 =?us-ascii?Q?34YGxNSGq/+z1R6u3+H/9NhAdiSTMXmvLktQq9it9YRZGmKAk2bPsmHyeOOu?=
 =?us-ascii?Q?4uhSyTc2U0jF4P/nFUOoQCmUQj32rYkOd21bXprBrSTe/yefZ7KortSbTKqQ?=
 =?us-ascii?Q?e6KhLNVxN3wEGfaVDhD1+VtvJRVLuHpee8WYH5t8kzgkShoOO1xOK1aRuLED?=
 =?us-ascii?Q?qhzjJCc8tYcZqeTWfMo/K4v2hdFWuUVot+KiYi9t2cEU/j/0KO1iYhl4PMxL?=
 =?us-ascii?Q?MoP6bqQbN6uCTRTAaXLm7Uu0m7t7KxQQhIWIoPmI0Qe9ZJB8+9n42uWOVuZQ?=
 =?us-ascii?Q?DW9vo0VNwi0tZhkDPVCuxiPtwCybOaK451IrwTuos0ZV5f5tMNW+hY3lFECZ?=
 =?us-ascii?Q?b84smLd/H2vTPQLNBQFZ5ExB8iBJKhpACYRO43NWKj35kZ0i4f7kreVL1B+i?=
 =?us-ascii?Q?pwrvH3PXgNJR2AR9I40xqGe+d1MFo+lmJvOBI+Yoo0q7FV01VKVgn5miHlI1?=
 =?us-ascii?Q?81g9QEUUl1K9ntqPEKx62G4zCBEF+2jfMJd6oSvDFSDDOBrCJsABzYStG1yB?=
 =?us-ascii?Q?SGWpdJ6OcYYypgre+ed/6B1GAvOLy/Msj2Lcnp3HTcXwRqnT9w1nH8SkoCxT?=
 =?us-ascii?Q?BlJPdf+Sy3rG+9a0mMVoiNAU16PNhXiX6KFEgQCiA5EJjbil2xVB7nOG9cKc?=
 =?us-ascii?Q?St5UjHGCmicOtwzgufQO6aOmRGtXYjbHlUWuK/41Div5LZNY9LZBGmujO3US?=
 =?us-ascii?Q?xPxKTwO/lKsIs58ul2rwFlFsgvrwEv8jvQrbn9ISQMRyyb/f0mmKMUXkfov1?=
 =?us-ascii?Q?8686he/JmR7Ly3+c8ROtsUNWSXMm5qU4yMRiSOfubYr30xqHFAl0aIVFsvkA?=
 =?us-ascii?Q?VR5g8vef4Ztzqo7JqlzRR6QVhctE2HsuUz8BkT5OsC6B3RwwdUiG/YVGEbEX?=
 =?us-ascii?Q?jtnVv8NQBtD+gF+McP6KuM5zUpM435fNYkN1vKMkqou0a4LiDiWO4nPRRysk?=
 =?us-ascii?Q?vkVSOPrjJP5AVNs0QXcff7BYgE4PsWrcBkgE46s0jUQqPqipD+R4WdSYtpMt?=
 =?us-ascii?Q?Zke9JJGci7Wye/FEsNDuv62ypMxIByEGBF2fzwH2XbNinmXd6MJrmZqUiPm+?=
 =?us-ascii?Q?2fUcZTD1zjKV02r81DwiplPbMKVUD6LcfIIM7LztR781ochi6paqP0Moorwp?=
 =?us-ascii?Q?yXS5rWjENsqFRNQfPWUuu+4ydvrUvWsGtexBTkIzwT98JRbHGBkznVjcl+NO?=
 =?us-ascii?Q?+N7CQo2pfdPOt+m0ZarpDEM6UZdynBs5g+4oLOvz2hBy73OcXBw2C74Ycf+g?=
 =?us-ascii?Q?hRcpcQXr1jrtFN7+PiM1i8LHqW33XKZES5Zy8MaX/q/9dX8/FT2C/LQIDj5g?=
 =?us-ascii?Q?7GaRq4KgIu/th+i8pFmxUAQ5lgL2OxsFx4dBxRW7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05494a64-9f56-4433-052d-08db7d585ca5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 13:04:27.0452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUf906VZk7sgv5PSHktWpSpavkwiHXL3T/p5TEKZIBRvCUj2PPgRXAQ+B6V3xOK2MjtVne9hcrm2xNkA2Klp3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5891
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use devm_platform_ioremap_resource() and fix return value
when platform_get_irq fails.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index a503ed758ec3..abf798104830 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -633,7 +633,6 @@ static int qcom_iommu_ctx_probe(struct platform_device *pdev)
 	struct qcom_iommu_ctx *ctx;
 	struct device *dev = &pdev->dev;
 	struct qcom_iommu_dev *qcom_iommu = dev_get_drvdata(dev->parent);
-	struct resource *res;
 	int ret, irq;
 
 	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
@@ -643,14 +642,13 @@ static int qcom_iommu_ctx_probe(struct platform_device *pdev)
 	ctx->dev = dev;
 	platform_set_drvdata(pdev, ctx);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ctx->base = devm_ioremap_resource(dev, res);
+	ctx->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ctx->base))
 		return PTR_ERR(ctx->base);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		return -ENODEV;
+		return irq;
 
 	/* clear IRQs before registering fault handler, just in case the
 	 * boot-loader left us a surprise:
-- 
2.39.0

