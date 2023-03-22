Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB516C41EF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCVFP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjCVFPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:15:19 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC78459E63;
        Tue, 21 Mar 2023 22:14:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XK1P5NY7W7I7LF9/c4BngySiUUTxbeeTGApE06A/9DTSpdFCo+QU1WjkkI0i8OLvmIDziHcUQ1CPW/bGUbu42XMW06TCtDTx8o6Oi2ipPkdDpI78t5S23L/RYwfvbWgXStrZNshN/aBR3V18asMjln3tkk05oNb2srvRresXliDGS7CQVexks/G5bael/6hR8Kt9EyfQ6/0DJvvVXBoUpz7f+5ozfzDbwM5wJx4AVYtrZnV2IP2twZjV0Kg0IHWluWpy4XGfKBYrhF5eTfbQBU9kUaDaap4dDlTNKrlHW1M8I2X2c8pOYfK3VvKtwHo2f34MKViaNXLkF+sjYUrL1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HtPUGDrL90dDHNDgqSHbRFOdqqqZXS5JUCzQX0fw9o=;
 b=mgRtP13uEzcG8c48DVHYbeMj4HnCeH+emgodQstn/4+gXU4d82XR3nMekH6Q1mC6jPgd2+sgLIDiVnAYyqt/qNVctwNN46uQhiLBWrDI8RE5yjef0i110Z0VJRJKyJz5g0rF5kPVSi/r4Y1Gk22Q5WD7l1t9p/tLq4qvdIuf+3Ay5yZ9IyTDAF6xic0gRioMZH56stvyIzpHgdpWcmMpiiQ8PKxG9wr1BiYL10T5kJkDhtD0Z4++gJ2R6XfCP6Fb+OitlGP/kzrRtuSS+smWjc46zs55awi5MAyh5O6cPtpffePIDj+Q7fiMwmGcWDWFTgt+mOY5+pa63j0v3OrvBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HtPUGDrL90dDHNDgqSHbRFOdqqqZXS5JUCzQX0fw9o=;
 b=UG0WnjVK3ollsitj+b9FnK49ekEKVddWYXysybozD3dlm9MhTyVWi2/pjoV25r1+34hzGaQSkfZaGbR8shZmLDU8EBc1397kN1cS3uCLLVl8ke/Lf0NMF/RL3RyJlwblLOZL+2UVUiTQn7JCOXOODB3uk5yKIwpKY1yt1y4nluI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8100.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:14:09 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 05:14:09 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 07/10] media: imx-jpeg: Refine the function mxc_jpeg_find_format
Date:   Wed, 22 Mar 2023 13:13:10 +0800
Message-Id: <c584baaeb6c0f781fa6f260984b0e545d60d1c6a.1679461710.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b6b7a76a-5879-40ab-fe64-08db2a944465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 42KAB3Z7aMBKBC19/JPyYsODAWKaCRQmyOlTam+kfR38PvWKUyjNeng17aIHDqmnw6IF5o28CD+vMRc6tyZUbXdYfNCibebgLkGomjXapm1IlmBZPe8qZZQICMhlW/F0vCoUTSNdAQ6gKIIE4h5H+WFmNdNcWfw1SIEMrDyNrHBtY4GH1q3o+GWP9P1czkeTdUGA1RbZRx3Wdd4FbIEXI5gKJ7hzNMHPjTI6x97eniDcRIzXxj5BvhZVEUkvQ4fHR8N0Uuv9SH8e82bpf3S/d9bPwzc7i+btAbEexcAZHnLEi01qjmmQEn+DV0j4vTXb2UgXcjYQ1uZ335t9ALjDhPrjCJCiimrYoXrf0lwWju0rQ3KH+YhW9kFyXIVRk2b07TqvEGco+M+KtERl3ndPawzuTId7C+WEz6pYSP5uMe/C6lJbzp3W9RSkRYLf0AqCtIcTK4Qhlyd3rRtRRQ/SC/9oGe9JBSjPgFAENR4Vltd8FuuVxgnyIuUUICN1yxn50fW4dVM2hNJu2Nlz+V5b4H9CoUYX2gncJ2oOQDgOSizF0MAiHd3qRacgeGtEXj+JC0gL6ENvfnfmmRP9bvKljBPyPm+B+1BApXnRCld0H/9HmtKnk8En/poh/yQlOZ6fc3sxhQAqnmP7maQF2QUplEpBCx2PrOJeqCQgzpWzD1FrO8WjSRwLzjySJaMH4iy8NfuIiQQT/8T0Gv0T3qHj9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199018)(6486002)(66556008)(41300700001)(52116002)(66476007)(7416002)(478600001)(66946007)(5660300002)(8936002)(8676002)(316002)(44832011)(4326008)(36756003)(86362001)(6506007)(6512007)(186003)(26005)(6666004)(2616005)(2906002)(38350700002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wrin2dCmIfInAwww+FEYLA0c3FlMviHihPfS6AeL04Lsi1DXFCy5DV41KlNi?=
 =?us-ascii?Q?W6hyN5BPZM82E+iGGi2wmEnbODkiVjZMwFG61CpgtCmQbmeh4lgCCzx4IjId?=
 =?us-ascii?Q?gf6dj/y+ZBqpl/iypTSv9FGPy7NB+oGwnKWn2lO1tsiK5mWx54Ra379bCPHJ?=
 =?us-ascii?Q?0k1ZB/Xd0etLn4mauX3QeJffzPjT7rZtKzMPv349IZ82evwu8cmS6EG0jiso?=
 =?us-ascii?Q?UZkHfdLC8nubM/wAB4YRBR7E2H/QsX8sRjt2ljIz/V0eF+qiLBNOOADFKMA7?=
 =?us-ascii?Q?kJ9oKiIOSM9XPCCKw0XSTHZdyGKeja/KQfw8nTfDLaFPKj1779aWyy1WVoFb?=
 =?us-ascii?Q?ii7Sw7S9KlX4Vj8Ro5YSqY3f/0rbHC6pzPnOW/aUypixJIooImShk1MW3696?=
 =?us-ascii?Q?ZZpLXXoqDEsk7aY5LqjVh0ExXBxTCCUpVHaq6/B9Z2Ld7FLR+Ecd+70Jy5lb?=
 =?us-ascii?Q?Qw41OhbovC3+rnwzhQ7nZu3qN/lI11iLw61ZpqAC1ZGwMRTVF/AGScUG5pZ3?=
 =?us-ascii?Q?+pnbNOM1+jacHKNe8/ue2wBWx9MqwF9PeR8qf0OB0nLHzPorQ3vxV+qJFmCJ?=
 =?us-ascii?Q?NRk+Zy42Z5W6yt/xO2zOXz8gqFTss9UGVDKVcYb914jR0Wu4SHZi65vdV6L8?=
 =?us-ascii?Q?S5Z8rhFZQQ0sfYvYiWks/tlPzXgrQAuDPbASCNF9XPRQXLLREuzkmlIOvhcG?=
 =?us-ascii?Q?cyt2THI0da+m/WsmapQUNBX3UEv7MOiI5I9BZhNdSwkRTcUC4Sp3k1vFrpXO?=
 =?us-ascii?Q?3OJwJ2om9Yel+MtGf+TFJZa6zGXWA/Rf04YXOnq8pot5yz8vHn9EOVcfyfRG?=
 =?us-ascii?Q?e23EJU2KcK0QTsK7x8anTCtHf0wVegkUwRJchWJ29uhOhnQmZcwk4I0LYK70?=
 =?us-ascii?Q?ZBfacOvHa1JhWqKnAE2DMBsyf8r7PjMb5jKxLyU50B8SI8aFLnhrU3yhmSyb?=
 =?us-ascii?Q?jSIgZ0P8dvyhjLrUgvvalhT7dLUAwj8YntyN4OY0+63o4JohdTJ/k6Ub/dqF?=
 =?us-ascii?Q?6BNL9B//G8GsekNLOawSr8I8hX2kIETGjKZyDTfxfR7peGWzZRLEOR5ERGlx?=
 =?us-ascii?Q?gN0DGN7m/28QJVPlU7Agzn2+CyRQyC7eyOhnU3jM/7ovraQMTQyjkTK0sM3w?=
 =?us-ascii?Q?RNFUmQ6xchPsbnMuEXI6pSmy/fGmG8GtBCYgUYxSXiEV0Pz7efi7QhkViWAc?=
 =?us-ascii?Q?w9FJWzNkf1zXJTdFxt//SnbT/aIozYWwHHwpaeUMRahAbkIzkUNuAxx44NsJ?=
 =?us-ascii?Q?xYy6RF+yhk9SYgvY8jF+N5vLK1tbEkeBaWs0LRKD+wO0dz9cnVoerdtrskS8?=
 =?us-ascii?Q?VvlwyGLR13fV7XlJbe7AddkQ87yB7Vu7xEdAvAzkS5FNjl7UZI3M/OZvx4WF?=
 =?us-ascii?Q?nO40wMzxTdzMlAqU6P41LEBipkhFIXOiB/ibggOU+h2GcoLvMHaDr0QBMZcD?=
 =?us-ascii?Q?48AL7GvCWgMoZRu/Rqt5Fx+8dra291YbeYMIS0WyJ2gcIH6WHd/1wRmol3iw?=
 =?us-ascii?Q?nTwyd/7ayQoM7ca59qgElIlxF8jRk35a8I8VluiM5/bLem+ycHy6Blpbw+P4?=
 =?us-ascii?Q?8lvtHwQB1jRLrvQLRL4QObbwBoOzIPO58OQkSQcz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b7a76a-5879-40ab-fe64-08db2a944465
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:14:09.5837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yk7DWZKMP1DDuXlghn6tagJcJ1vEFnQB6KYMk8peRERefG745HxLGR7jex311s2gRu/0QJXYNQowMOp1MMIuNw==
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

remove the unused parameter ctx

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index f085f14d676a..70b6eea733e7 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -420,8 +420,7 @@ static int enum_fmt(const struct mxc_jpeg_fmt *mxc_formats, int n,
 	return 0;
 }
 
-static const struct mxc_jpeg_fmt *mxc_jpeg_find_format(struct mxc_jpeg_ctx *ctx,
-						       u32 pixelformat)
+static const struct mxc_jpeg_fmt *mxc_jpeg_find_format(u32 pixelformat)
 {
 	unsigned int k;
 
@@ -1562,7 +1561,7 @@ static int mxc_jpeg_parse(struct mxc_jpeg_ctx *ctx, struct vb2_buffer *vb)
 	if (fourcc == 0)
 		return -EINVAL;
 
-	jpeg_src_buf->fmt = mxc_jpeg_find_format(ctx, fourcc);
+	jpeg_src_buf->fmt = mxc_jpeg_find_format(fourcc);
 	jpeg_src_buf->w = header.frame.width;
 	jpeg_src_buf->h = header.frame.height;
 	ctx->header_parsed = true;
@@ -1702,11 +1701,11 @@ static void mxc_jpeg_set_default_params(struct mxc_jpeg_ctx *ctx)
 	int i;
 
 	if (ctx->mxc_jpeg->mode == MXC_JPEG_ENCODE) {
-		out_q->fmt = mxc_jpeg_find_format(ctx, MXC_JPEG_DEFAULT_PFMT);
-		cap_q->fmt = mxc_jpeg_find_format(ctx, V4L2_PIX_FMT_JPEG);
+		out_q->fmt = mxc_jpeg_find_format(MXC_JPEG_DEFAULT_PFMT);
+		cap_q->fmt = mxc_jpeg_find_format(V4L2_PIX_FMT_JPEG);
 	} else {
-		out_q->fmt = mxc_jpeg_find_format(ctx, V4L2_PIX_FMT_JPEG);
-		cap_q->fmt = mxc_jpeg_find_format(ctx, MXC_JPEG_DEFAULT_PFMT);
+		out_q->fmt = mxc_jpeg_find_format(V4L2_PIX_FMT_JPEG);
+		cap_q->fmt = mxc_jpeg_find_format(MXC_JPEG_DEFAULT_PFMT);
 	}
 
 	for (i = 0; i < 2; i++) {
@@ -1950,7 +1949,7 @@ static int mxc_jpeg_try_fmt(struct v4l2_format *f,
 		 pix_mp->height : MXC_JPEG_MAX_HEIGHT;
 	int i;
 
-	fmt = mxc_jpeg_find_format(ctx, fourcc);
+	fmt = mxc_jpeg_find_format(fourcc);
 	if (!fmt || fmt->flags != mxc_jpeg_get_fmt_type(ctx, f->type)) {
 		dev_warn(ctx->mxc_jpeg->dev, "Format not supported: %c%c%c%c, use the default.\n",
 			 (fourcc & 0xff),
@@ -1958,7 +1957,7 @@ static int mxc_jpeg_try_fmt(struct v4l2_format *f,
 			 (fourcc >> 16) & 0xff,
 			 (fourcc >> 24) & 0xff);
 		fourcc = mxc_jpeg_get_default_fourcc(ctx, f->type);
-		fmt = mxc_jpeg_find_format(ctx, fourcc);
+		fmt = mxc_jpeg_find_format(fourcc);
 		if (!fmt)
 			return -EINVAL;
 		f->fmt.pix_mp.pixelformat = fourcc;
-- 
2.38.1

