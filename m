Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E93696050
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjBNKH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjBNKHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:07:24 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2045.outbound.protection.outlook.com [40.107.105.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620251E9D7;
        Tue, 14 Feb 2023 02:06:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZI9O0Gow+csqnIi7dfzD5BYo+VO/ouYi/90j4ACY70bRpuKPntT3N5lib6bPLnPPVnOiKuICgpYFi9NH4u0fpgblZm+5JnapfbgRwK1HQl0co9pzb2Of0Hur+lkmxdtNWIHaAXWVqJNmqG62/o/iIHjLKtOnu3WXr6Hl4gzxn3Fn1SvEqeTIe+Pv8C+4/Wi4L6aK8zpcMnkV0iYSj0ybGpMET9s+8gpVLisMZTj7e8rg8V1R87AWKIJfQqiuZZqZuEmoYc6Yovm6+C9Tfk89rVZSWSOqo9jzPEdlyO3qorLPQMfrAWksBD87TN+LmpItG9nM/T7++SU8Jlf2VZLxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HtPUGDrL90dDHNDgqSHbRFOdqqqZXS5JUCzQX0fw9o=;
 b=N5d8Wx+zxDPjyvO/VA1wxULAm4TzZyc7nRb1wQ7QpKT5Xzv+/iR9zSdVJmBQylNawNC+/CO8g8xkEAZEHvjJdyIU2zW/h3XaZlTfTPdjCWP3+BwnogsxJAsdnCLFgXnG8rsVcAdfyhTKQ2+AryFzkEolh+3VArk42tHZYjgVUd8zKqk8bikPsKXTxX7B0g1GsBA0HFFSi8HzFStOV1n3HZAEJQIZ04cYItkwao9sS2ksfOS9ELVb/+vMAQxm2cedQ547sSK2/wUlgfHy5D47SsThEOYqX48fMS3xYm8tFi9sQIzoWKC5ApuzT/oJ0X23tOt60JTglE94ULlTyY4K1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HtPUGDrL90dDHNDgqSHbRFOdqqqZXS5JUCzQX0fw9o=;
 b=jLOLPm4bppzTb6KDmWRoFOFszbtAnmS8kJO3IMGraKmiI2kVNi5s8MG/q9itB2aj3Zftc+bLR3ns7l3XIvmYjLsMhhxN0dSj+Vj4yFP+eULhF3zfgcpRHfH96Vzo6XeEzOjycLxu037wveOGOIHqPLAGS5IAkvAE6THk8PhJ8KM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB6800.eurprd04.prod.outlook.com (2603:10a6:803:133::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Tue, 14 Feb
 2023 10:06:11 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6086.023; Tue, 14 Feb 2023
 10:06:11 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 07/10] media: imx-jpeg: Refine the function mxc_jpeg_find_format
Date:   Tue, 14 Feb 2023 18:04:49 +0800
Message-Id: <28d3f4f44f7da5bd84a03468f0fb541734395a66.1676368610.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1676368610.git.ming.qian@nxp.com>
References: <cover.1676368610.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|VI1PR04MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: 22cba84a-df0c-4e6d-7032-08db0e731958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Vhwb+1Y9Ywd/Zd1p9pO/V7IflRcrw2ypFlg7zVPnp7ygIMQZF7Xr/TUu5H+143J/KiGTWJhVKR08Dkgm9jACCjvxCNg12SkZ4EFdHxvL6BRs6OZocoM8FlZ4Vs2WLIy6F2MFVLf+skSeGsCKqeXsiC5o5PboZPuW5Jm23D1a2xGtimh5IL165tG0p5KJOuOyF4Bwsu8CFqHonxpnHzLjlrVSOxiBc4E0nTfiC88S2sHhEeeomrtm/tHA5K7QMs6+npV4sHnVBE7SWssQFDqFt6PpGXwUIDqlvYslo0v/E0JhGQCxzjbAuifwZLRsAciQejg3kx0u3bIWX9lKVBlLX4+AXV0JlQmrpE1SDW5UWK2iiYLU432ZkDwhNUv96kZXwD7dQw5/7cuV/dWb4CaH5hnC4APabHrR9Q/xNy6KownF7VfBwzjji4AsfjINva/vMYgRSwk5DLIpHxdoZqfYN7tHGyYySW81SmVO4hjJYWBFyc0muXbnGwWDkBQFw0+q8FzUcJ1GjZfXJBGVYpHVdpwIcsD7OlMY9ife2StxuxQ+9BGpNNJknc4JmOT5QUmigQr8DW1qCY8o6JYzXt7WxFqW26Yd/3dLGE0xC/Fn2fdqWs/wVMbRO5w1wAf6s6WlpFHrvhmbhr2YMHJNA+vtD2iP31uDHuafDJmEn0juDYfK337Te7jPUTtF8yP4qTyFOZqLHh2DcbLlZDk2jxLZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199018)(6506007)(52116002)(83380400001)(6486002)(2906002)(36756003)(26005)(186003)(38100700002)(66556008)(8676002)(66476007)(66946007)(8936002)(6666004)(6512007)(38350700002)(2616005)(4326008)(44832011)(478600001)(316002)(86362001)(5660300002)(7416002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pPfijjKbSQwdLLpRrbKzN1ws3eW8gnzR5QlvXDLikVoTw1CCIZUbLwXRS3OL?=
 =?us-ascii?Q?8RdFztAYLOvwVdVXpdQVE/0jvgoK4RsWJccbYb2/2jySsVPieJn0zqGXDiRG?=
 =?us-ascii?Q?jjSfpTEASEBQoQZ55mSInXGjk6JpoGoOOrC/xCZOPVQIZ41ehSHk9KbduUrS?=
 =?us-ascii?Q?r/RQ8IdU1Jxko5x1qBjjBpx6J9L3LfJMLLBQbPNKfPKZ4NKqNMPaTrlNcHze?=
 =?us-ascii?Q?Jtv1POX0chyIAnR6omV/aKB+dwqLUBNnP1M2YW0yU7n/44u62gxCJuNduAGs?=
 =?us-ascii?Q?IWcZWNC2DzikMVnUHOzRNA4A20CnkkJYWRGosN1hAE1Edr37a+LeekGp04g2?=
 =?us-ascii?Q?K6TAobJfMtiQ2Bhgp66kZ51SQqDICBsSDpIe3H9gtp06r/8r4+MjrSaqU0f8?=
 =?us-ascii?Q?E+RW+stuACEjTM35o8JdL/JR9rP44PBAH8qXd7I+mb6Y46/D1HVreAsCUdr1?=
 =?us-ascii?Q?GhxCzFhB1f90FTnqPl/r1wZu/6FN+xQ4RkQydgfhYwbZePtTw6i0jQFm9Y3+?=
 =?us-ascii?Q?PoJfzqJvzvOmMEQ7NLpuXZ/CzefpzDHc70k/pwviAuqInd8WiJ+gkTfuj5e8?=
 =?us-ascii?Q?6xY/a5k2FCL/iD9V71agpLkkRX2bBb0JMSqeQhIzMr0Y25Oxj56GLhmkVjc3?=
 =?us-ascii?Q?kEGb7Z4kQarcuMkiJSVwW6fuKkuHzxETFWFOjnvDvMRV1g2pPRCqvckI4jvj?=
 =?us-ascii?Q?JicDfcYOn9wmXJUeZ+V6MQcDwfw+vt8W65y4ncBZusjble9BKqWLqUpu2Fno?=
 =?us-ascii?Q?x9XsELwt7M3GhoDEEGtbSJNkKbbFGZWIyCrLR2gDIbt+B3llFfb8LFEFYHwH?=
 =?us-ascii?Q?6G6fwZrxeOyMpTuMRczKTxxLosXhxaXxHqHk3/+sI1pXtcb/XlQBFOjdkRBe?=
 =?us-ascii?Q?tpJqtubXRAn56WqJDESJwfIZX8P9OdusvqBBT/bBP6lWROQiyi1WUpvF3Zrm?=
 =?us-ascii?Q?P8UBG6XELPXwtAannDu59saJ4seGdXCfesx/E7pXCTOqG384uc2GtWWyq/T+?=
 =?us-ascii?Q?v7tDUa7FD0jtHKXgPDhuaEJVVkmzGc1BZCZlaBe6z9qBCSkAG1lf8Y+jQx60?=
 =?us-ascii?Q?1Ra5QqFjYPy90XfRmSwLk5GqkR/ffHziwB+g7zgTUNI6WMcXJ0WIVeX17otj?=
 =?us-ascii?Q?3yabRPLAJhyUIGnGH/+Do8owqpqEx2UEGUNsZ7rzkGnWWeRGr782eyzw81OM?=
 =?us-ascii?Q?oZQaCLrYqzW20BdCkNIuZ+JKHMiQPcHFdEKeKxOS5q2SUTU2+GITZGrMFp0+?=
 =?us-ascii?Q?jCaPaNjnPWAmsqY8sgEN+i7tDIWTm5qHrfOFRQsNF+1kyzM5hHeHWyxRUFP6?=
 =?us-ascii?Q?QaweCDT2SNijD/RBLTwh/OC+ajjQ3kX0i46G7pGBwRebI+CpT4Zr9Qyna/3a?=
 =?us-ascii?Q?BaHjFngiUPP19dLFby/fX42Othfr85CQo9hYJQptmccbxj8/+6K9O94cjOF/?=
 =?us-ascii?Q?rxkKFF19OqGy1SOB602HpFgnQGYergESbMrzzt+bXIR645jZJ9YgtsnOmPhr?=
 =?us-ascii?Q?tqHh5oUwUI0WCQFHfonbnbs5Jhl1vvNzcad1V/FiIDNnpQM7DoWaaYj4V9iV?=
 =?us-ascii?Q?Eb36yMqxDlCodeP8yJZnlpuyDoSTr96wYDccw4/K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cba84a-df0c-4e6d-7032-08db0e731958
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 10:06:11.6529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7Z195wHhC10pW5qsnH8ZzaFrJOveVhB957p888b5LO3nNyT+NXdu+QuEbufUafkfdPG+9jxVzl3ccdk3sPleQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6800
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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

