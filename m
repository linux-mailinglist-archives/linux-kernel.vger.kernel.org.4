Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48F26C41F7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjCVFQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjCVFQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:16:22 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A451515F0;
        Tue, 21 Mar 2023 22:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OglWgR3IfBSW10yTiRHSBmHpm9/if4BLeNTizbXilxgS9zJtk5ZT9GLrDHuJVZ1FYcjxqvFLBrLZX0k2xjHD3SN106j6MftoxVsCeEZAIJYJhWZQSkB/wKIf/54baVXHWj9xkru7qGc7pbpZnA2JBGOq1NOBdP2TtUv55FhOLKxXYCtbV0Vt1TzkDZxJU9Ov63Gip0+cA94HMNDQByoOncypLo1Bw5NNAg1Uv/EUcxmjli7k/ExOYP1+prXLDyWuVwEXvFxOZrg1AYEzYu42g0CkLVkCTsC9MdB1vK1WzRxc0wN+JlwfgZEwPTnglU1yrRX0kgPfFC0YzmP4BSwrDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWE2v7gcmTZgAjF135o2R8bWHo+YHguXRwe76ddTpZg=;
 b=efsL2KsH5CpGbzhi71D6hgAHO/ISmmEzT1IriMLigsHPqi6zGkSpi45SdvgydD/XZwQjZHgdlMuky5s61z+AUG6TqTBkdmZuGuUvuZo4I1xQ1kRLWqKScmPbrrl/H2kzqAj0BD1PLWTShgV4j51B3f2JXN9loWdVkkqIxxLNK04wEjhHvS9AQjCi45yaa6RZw3bdk/K15XWWooT0lkFMrp4ubb/b1z5E/LCjnC9YuJakF/vu/tze3oh2iuN2s/oJZKaAXwWP4epZe4G905N2TwUD7PqSzw6VqrVZCH/TOKKJpUUNg2rdjHbSTBSkw0PSalfQNKsTjJYZriztvXWZOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWE2v7gcmTZgAjF135o2R8bWHo+YHguXRwe76ddTpZg=;
 b=l2ooSAChFYUpBftK5jYMIIxAl5bGiISONWtq4d9iPtk/w9pcJDKgm3WHWGlogi5/WEHvZzWACepugcNEHxWDw+i5b/SfoIj2EHFHwTJJRR7edIRUiaD3lw8NmW+U5yUKsay7Fpqiv1NZ3610nph1BVmx4tVzP6EkZMVbRb5ye2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8100.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:14:13 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 05:14:13 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 08/10] media: imx-jpeg: Clear slot next desc ptr if config error
Date:   Wed, 22 Mar 2023 13:13:11 +0800
Message-Id: <c702b00a3495606714285564e1920d3fd1e25477.1679461710.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1679461709.git.ming.qian@nxp.com>
References: <cover.1679461709.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM9PR04MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: d8021e41-8ef8-4f6c-78a6-08db2a9446b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mxuIISw4QOahI6PHeg0cdzuiXBkp9h+5I9I5LBVGHZs/B+DBLRcLS+NPgVIcT6YJSyIibRpL+2IEXW2EColsu5RjMelqjVyPXwvSakPepHRcrSkXxNCWC9lV+/YLz/eQlN7HNczGWONzWmxPslD63hW9ciVvcjVbo3ta8kVPeBaLj5mz9aEdnD7ktlqYqVK0O5hSF31cVHHiVEOOwFi6SbFqFY9P9qjn++FBf6fA1UnakFpsMsnW6Rb77nR/aLbxs9aTU49O4D+Uvek41+G8wjHcnavIBfX6Hta6f1CPJHnU3QnA6LTJc/MpTBDYaX/gGlYWrh0h63ysSwky/RQcHz52lZoKL8PJ3OxIjMPAwTT2hrpsiCKFJCmB2KMcjohRxP/S3YXIK7M9tFiIoqrl6gmL1i+UqJSENAqmpj2lBOA7jp3B+hvmWaxDqrSroeFei1bA/dRyF5HY0MQmSoaBvj5Lrrc0pskzFsFI6Ie9AEf0OTjdQnS8jLsPoOI7MQSYJ2I15SfTthPQiBJJtQi9QhYZoBzcRgmuv1CRPerQVnQQV15pzDciT6ej3sQRIwcoySVFvNnZb1g0U7EwaaFq+I9+YrBN9qFjh95ygOmRCdfPfNJawJAQu74/oddfcpEX56E1bxRP7iKTUg8tFO+AcCbY6eIhK7d2XJRn+mmbbL//bP+F5eB7MHRHtiR0rBugktuikfGkND6JRSe1oVFDXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199018)(6486002)(66556008)(41300700001)(52116002)(66476007)(7416002)(478600001)(66946007)(5660300002)(8936002)(8676002)(316002)(44832011)(4326008)(36756003)(86362001)(6506007)(6512007)(186003)(26005)(2616005)(2906002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P5eE67KO8+UKJCf5yMGAr3paQOmVsyFhMW1cFaMpZrbn//hDbK1R2KGR3Dq3?=
 =?us-ascii?Q?Isrp+NO+x0A40cpnPCFrDwnIfmGDmw9ahuzo61NCz3UoRVSeWr1GlcgfCW5b?=
 =?us-ascii?Q?xIivdCbHX1ZrfS47zw07Ut7Q5df7WE2FfM60wQC49R4AjyF7+70uwqsBAzPh?=
 =?us-ascii?Q?w8+acer9PXPMEHfS1/xBJDRbBytrGd3Gpwbu57493WEFcZKIWjhDY6j9PB8c?=
 =?us-ascii?Q?bBK9cjBvGKW/OfzNBYq2iJ5dXP2ZnzME7mNgdE4J/fKf97e7bHn3g0OvFHuJ?=
 =?us-ascii?Q?DtXhKg5YCYuFYMkeeGrIXROUpEi9DeaputOSYPLOIPCbdDutm0s2bzP1+4qr?=
 =?us-ascii?Q?TiDJDTD13bDQA1JbxHsy9U1loYmHO6qlS3QP1VoBLJAPbH39lMGuZvS54ErF?=
 =?us-ascii?Q?51MihRENnJIHWlPbyCXxJVm0ZkLul+JEHc/9iA1Yab7xlvopQv/KitbFpVSP?=
 =?us-ascii?Q?sfATkz7ZOgWQhOnLmIDr8T+oiHaiznelZ1lL2qL+ai9SFczJswo/MtLs/Ubm?=
 =?us-ascii?Q?pkSHvTh+YaN/WABj0wONQnqcs6CasQeTabs4y8dJRj0YZ2DksOvRLk7k+jPl?=
 =?us-ascii?Q?maXv2AtY5fJXGCBaLbFpcpzvNcHAGa/lvpWcFdegPHc0fKi5BbmLMDXH9Q0/?=
 =?us-ascii?Q?RICT94VKHXWG0z3VL91E8c/OH28008+j2BdSkDoECkhKcm00Ovm8hIuYOv5x?=
 =?us-ascii?Q?Xe9a6hD8OWF3zbd84mAtT94Xt079l/kdBKuFishmyZTZB7ScoNEWeupOQsP9?=
 =?us-ascii?Q?39dMObmuLYuuwOlDKdmNpG+ATQC/ErpIPLxf6FbHzXzL5paHokeJ/ctXAoG8?=
 =?us-ascii?Q?iBF+0XaFBBsz1AQKr95hIjy/Z9B5OLSVVNdlD40LfAueONKwLkMbXTDKEoUb?=
 =?us-ascii?Q?CDkB6QpLyl1OdnGhj3Wr/e8Ur5Jfi9cI2F3eSSaIZT8ccknVkY60DnsbJ3SQ?=
 =?us-ascii?Q?z73tJnaJFAzIAxZg52vylPiDO8671yL/lC2NmphkLzs7n0jEeYpyCqD9Onng?=
 =?us-ascii?Q?aT+9FNhezSz6GGPPiMbbMFTmUOiz3Mq5cqmFeo1sGBP5HttPBeqSUfH1XTIm?=
 =?us-ascii?Q?smrylSuNuC1kgDHMNmFBipPoUpoCkk5dFH82lwl4anPbWM6ajKT35UzZIrha?=
 =?us-ascii?Q?YJ5PMuv/Bi4dyDBa6Y5Yge/VVZATzWfHgzSggAjBFVfIuwl86VWfgnYL8dwX?=
 =?us-ascii?Q?8r2ui7eZY0Vu2pB0d5Lor5cgevBHQvclo+lTEPSvBYdmx4zsDKWbwepx7azN?=
 =?us-ascii?Q?hkkcU7z1LYsMeUAvFNR3QQBNwHn4qybDoQ9OZerYhT4kvFmNQm4GWK3JFaag?=
 =?us-ascii?Q?b2wYDcCJNUa6GgghitYXnNtmjGaK9kPTt3S2keY5fH05GXqAVWzsCm3R9VD7?=
 =?us-ascii?Q?dZ0QV6jmUWcsvvlLIAx1am1x9dFBAeRjv04hxT46axJ75AnHzIZkL2gITpJS?=
 =?us-ascii?Q?OZykajNd0pzWdZSTXKYGuPzcWNOE633GjHEhsNubxERsosRvv+Lp2e3XpPly?=
 =?us-ascii?Q?0wiZFmWCsJEgvh37//Shy/1D07UfrqxMVJ8S6CdSH5/JwVWb/3T6q4dyvKav?=
 =?us-ascii?Q?G0acSBDvIlMnHgSESSNkT/JhtxZaIt8p8ElrUPPo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8021e41-8ef8-4f6c-78a6-08db2a9446b0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:14:13.5366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ppsIuXNYxebVKZgEWxBqslZI77BDKgk+rSVv6vPeDeex+6IK96EzIxRWFVP3//MLuh3Pl5xM3Kk+VnccdUMbOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8100
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clear slot next desc ptr if config error,
otherwise codec will report config error interrupt repeatedly,
it may led to system hang.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c | 5 +++++
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h | 1 +
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
index ef28122a5ed4..bbd5d6a9fc86 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
@@ -178,3 +178,8 @@ void mxc_jpeg_set_desc(u32 desc, void __iomem *reg, int slot)
 	writel(desc | MXC_NXT_DESCPT_EN,
 	       reg + MXC_SLOT_OFFSET(slot, SLOT_NXT_DESCPT_PTR));
 }
+
+void mxc_jpeg_clr_desc(void __iomem *reg, int slot)
+{
+	writel(0, reg + MXC_SLOT_OFFSET(slot, SLOT_NXT_DESCPT_PTR));
+}
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
index ecf3b6562ba2..8b7cd6526efd 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
@@ -137,6 +137,7 @@ void mxc_jpeg_set_bufsize(struct mxc_jpeg_desc *desc,  u32 bufsize);
 void mxc_jpeg_set_res(struct mxc_jpeg_desc *desc, u16 w, u16 h);
 void mxc_jpeg_set_line_pitch(struct mxc_jpeg_desc *desc, u32 line_pitch);
 void mxc_jpeg_set_desc(u32 desc, void __iomem *reg, int slot);
+void mxc_jpeg_clr_desc(void __iomem *reg, int slot);
 void mxc_jpeg_set_regs_from_desc(struct mxc_jpeg_desc *desc,
 				 void __iomem *reg);
 #endif
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 70b6eea733e7..3f1c9bc4b144 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -692,6 +692,7 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
 		u32 ret = readl(reg + CAST_STATUS12);
 
 		dev_err(dev, "Encoder/decoder error, status=0x%08x", ret);
+		mxc_jpeg_clr_desc(reg, slot);
 		mxc_jpeg_sw_reset(reg);
 		buf_state = VB2_BUF_STATE_ERROR;
 		goto buffers_done;
-- 
2.38.1

