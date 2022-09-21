Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B425BF37C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 04:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiIUCaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 22:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIUCaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 22:30:17 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661BB3E74C;
        Tue, 20 Sep 2022 19:30:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSfsbCy2A2Cc2xKHADBecKMOkytVgRBEcxVr7JwtlUpv4kR+rrHwngoSO1RIAgHt1IpoJoU8b0yspRax/a2kf+UyvnjSHVKpoq6EzyI6Izp+HgKvO7Xircv5qTF/y/Bvnu0CBryhgCidTLGszolkX8WS/wtrnI9FsKxlcKWaHg/4VhqK1rdgah71piwGOmql3zQRBqz8/cMsE43I5sN9UogExpMA1mauEoU/IiBpyHhzmMc4bXUN8JPKBgdNPRdxPcBRl5Ck4R7U3MxCK1eJHnStI++TwTfeXOfgKLvhre9+7Vg8JLTs4NEtqrT1RWC/FJNGoy2WPVFtuIhcGI5S4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mriOCcd8cLFBMQ+lV9VJPYvBqRZ3cmfFh2qEhCUtSZU=;
 b=KbYW3gnLYIMJ1OpRtBnk/xyRw4jJPVPZxMirWub1sy6JldcfVnW1LOp5gD/tFoJ5EjIhYspyIWVz0qZZ+lzx/8dyGzdfK1TctwO00QpKqjJEARgEDXR4jiV27HARgCw2TJwJlYO0SLoTTGNAMLeT2+9GDJwmKj6xqHqKCS97GACwxHQlUgEwRmSb1XDa8kgJpZm88JZ/eCh/NvfwGJ4b1AriEC2P5WL5v1Itx3ELSQtlGo4HhuobwYHZA0dGYRjBVWJgkrx4flX7f58pGfMVaOheUNj0TzQDD5eR2rCqQ99Mgtg1AM8O5f2BSXXMbz1Ld/NfMS3gNpttpRbDD/061A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mriOCcd8cLFBMQ+lV9VJPYvBqRZ3cmfFh2qEhCUtSZU=;
 b=lLHb6trVz6mN5AkF/3bS1+tDxOYL661pIltMNXDzmUcB8TELS+7PRSikl9ePqBDaS8P9YrcVqKfl6S9YrGdRcabgf4XBA++kOrajKgZfVoO0p9O1QUQhTXOQCiomUbgjenQ6RNp+tAmXtYM3f8GRpZTrsyaQ2bBrPON7+DjrPqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB8767.eurprd04.prod.outlook.com (2603:10a6:102:20e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 02:30:13 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::4550:e439:2389:be53]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::4550:e439:2389:be53%5]) with mapi id 15.20.5632.024; Wed, 21 Sep 2022
 02:30:13 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] media: imx-jpeg: Implement g_selection and s_selection
Date:   Wed, 21 Sep 2022 10:29:18 +0800
Message-Id: <454de26a257a2d257b8f361429e0c8a1898e65dd.1663726876.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1663726876.git.ming.qian@nxp.com>
References: <cover.1663726876.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::18)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|PAXPR04MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: 98152b8f-ed0e-430e-377b-08da9b793616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sApvHvAIl2m2dzh2bM0cTrImH5Ekd8Egjm5jPMU8LLYF8xXuBztwWoyihaYRLjEjrmL+cPwWDV9DizQyErHxkiJw4qh4XiOGxxe9mzeBM8R8+GUDWNhqY6Ns3uSIJWxUToHkL6/Z/nLoYHUFDyJOi7yVkfMQNeaAf+4/WH1l8i4joknIHk6uvQc8dYHmyRBHUS8lyP4s2RMQvZt4o8RmQ86PvyLfU3qjtRflMuzTZFf8P8e+cmBVCovisCQ5xKFOQFWj0ITIuDarmY5c86U15+xBYCWlTctN6pKsNwGoUp8WbeQ0w3dMJYsqEsnXuy9YdXLJ8/pXXYvq6g2/44mAAFPXR9Y6iMGFn/79F8sykYr4TAi3CvH09Aq6IrPjMO+h9D6FHDgR7hvdVu0oU8CJafUH9aocH2/0dWNM2AZxX+DEGr2+CflfuV4sou7py1HYEsuN6D9XX8X/wBL8LnPizUum2HvIDlYnhukXMEs3uyWcMsRoIwswjfS/e4x4EI0DEI40uROSdyFTqsEvi9B756D9VWENraj76f7/MPIb9VurgNZgMKiQCwN8r/LGEPeZu4aBPQ3MKvt1budb7JW7Q/KbNJdpTMwe5H9Fk0vKE9Ep48ZjiKIWfQ7kZzfdjqklAGTjJ17EkCP1fDoDb6pqc+M7uVkIVhrvJ3WgfTnM+6/sGOVPJSMqIlbPjRehOD4TeiVb+zf2XJtRxIE2D4/B/QxB0+R+V4A2ebbpzxBrDBHeelxWr06wX9Pg7GZ1JNfGKbJ+0uf5kf3pjlsbvVTRsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199015)(2906002)(6512007)(52116002)(26005)(66476007)(66946007)(316002)(86362001)(36756003)(66556008)(8676002)(5660300002)(4326008)(44832011)(186003)(7416002)(30864003)(8936002)(478600001)(38350700002)(6486002)(38100700002)(6506007)(2616005)(41300700001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hc9nrWSMNFIN/K9KdZyfubHUzya/Cy6U85kbx20sKw7GkcN6vEsLDOK7y9oy?=
 =?us-ascii?Q?+7j7knTzhzdKyPaor/q9tZlLUEiNInDbRxazfolAg/gF1UJJHitHrXaKDxFF?=
 =?us-ascii?Q?u5iXGSFeFt6eoZY6ndIJVQbRy75d6lIbBN4F4oBpBkdbprK8TBEqvMeNmfxt?=
 =?us-ascii?Q?R5s3pRIv+u72EBpA/6VUPr1fIgpGX2Mgb6Bu3uAPbaEEYk34AXG7T0MtqCRJ?=
 =?us-ascii?Q?DVc5XivF7Wou0gNYTIXD9t/8vxLmtEpmBZLfyOXcKS3BTz7KxUj7UI/wYWrR?=
 =?us-ascii?Q?U9TuAbjq3Y1suR2YqatTpTenD5cXx1cceZKX7DDc2xlfyMH3RzmhHpv5SUcI?=
 =?us-ascii?Q?b/gLFN1YANWtNe5i90lpDI/KeZ1Za0X/eG+/62ZtBGAgn+du7AjRBWRtXskJ?=
 =?us-ascii?Q?9U6pKIWpXvjQg0uekYacxFIe1z1CPRWp9OMsOmp8L0twGfC0RhkdTMcLKuIh?=
 =?us-ascii?Q?Cj8vAowjgsnFZnD6Zk2p6oJNpPEOO9E37WR0zAnQmZGIy3QahQNvVkOdXLy9?=
 =?us-ascii?Q?YB4f1TH9WhAxYT5DrP6JYekAKbWXD44RYkW/lmtPfyhBK5tTgJksd2DI/5LX?=
 =?us-ascii?Q?fXxmldLJT/aDPuJYiEEENXmJXTebXi76GSpRkNamtZd0FF8oRUuFMqJQxx3V?=
 =?us-ascii?Q?Bb42ZOIu7xn1GjZfcszYovOPbdmgmQO7QB/WK6+QJMMSgHQxF5qKEJSC2k6r?=
 =?us-ascii?Q?jL+S9ZMbrCaFU++B8C9JKDho0ATf14K3dusMk8yJmKdzEw+oUQtAEna4KDWQ?=
 =?us-ascii?Q?jPEWEsdN7IB5ZURVYu9MAvW3OOTONdclU7gvzLjMCmFhdxGedKUGseBtmwQC?=
 =?us-ascii?Q?3E1eI4tNslJYTePidzQU93TF8O4GcZAWp9Kr/+9ODq7av+nhkIUmF3d0+S5w?=
 =?us-ascii?Q?U44mvI9n1dB8WC4cqZHYlvansFhptsZyrrSl/GUaOiO4TfamJqVmGCz9ImhO?=
 =?us-ascii?Q?O/Xcgnu1ZeonDHCtVKflAjKgiVri+oKc8iuO+nYWA0Ch5OYqhwvJPlR5F22t?=
 =?us-ascii?Q?RJeb8JXG9fWqaWsdj1V+HWzn+P2PyGTPB+vCPx0i2iSqrQb+FSkeH1Plfhsh?=
 =?us-ascii?Q?3GzGbM4lvX+Hn4LVf8AHloCowdUaYnBWtVxtk70wesytZWuWvRkXsvDsrncy?=
 =?us-ascii?Q?Bx+6biFh5qrnrejdGGWt6TwP0SSZe5PCSig2BqOTJ+JI4Ry8AgMG8udFzIzH?=
 =?us-ascii?Q?2rLlN2TlgcP+t5X73Rx0YKifwak1HA4kYNi9EFFk54zS3wIhhS/Kvi5mv1iC?=
 =?us-ascii?Q?6R+uPP1f9cRFXSGwGXglwTwWLIETFJg79KRwqWBDr8T31Dwf+F6EzLaMEShe?=
 =?us-ascii?Q?+n2xPA0VCNOaafDq6J+1aULmT9qr2Am1+dNIsz4JG2PYiFeaZKsKWBDIkQlC?=
 =?us-ascii?Q?7HEvfFtb6VMFUuF79UvJq4KYoZlEd6ifgkJg7pZ5zDL6r03dRK+Ck612eaBZ?=
 =?us-ascii?Q?R5dOY6K3G2NYTcJQ3a45FfzIVhTrb15PBugj3KyifabzzmFrW5bHp+fTha2P?=
 =?us-ascii?Q?r6PRpB3V4ldPcKp1MldsxKPRx8SviBVACiyVl3ZcKFDsxoHwlhPHTNBfNMD3?=
 =?us-ascii?Q?mwRWQACoWM9Jd21z6A85W0L0jsjUBdp5w8NErseo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98152b8f-ed0e-430e-377b-08da9b793616
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 02:30:13.0401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kGKmz6iXa2/Kr5cJCUtO4sOSd9mcLBm2/KDqRhHMdAaET951ogyifnetE9VbTYdMDB1Q4dlf/DgjmpMm2/rwWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8767
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The codec can support any image size WxH,
with arbitrary W (image width) and H (image height) dimensions.

But it requires buffer alignment,
so driver can report the aligned resolution through the g_fmt,
and report the actual resolution through the g_selection.

For encoder, it even support to encode a smaller jpeg
than the original picture through s_selection api.

For the decoder, we do not support cropping a portion smaller
than the original picture, due to hardware limitations (wrapper side).

Fixes: 9e7aa76cdb02 ("media: imx-jpeg: Align upwards buffer size")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 327 +++++++++++-------
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |   1 +
 2 files changed, 208 insertions(+), 120 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index ec13394bdddd..f28af58aa56b 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -924,8 +924,8 @@ static void mxc_jpeg_config_enc_desc(struct vb2_buffer *out_buf,
 	jpeg->slot_data[slot].cfg_stream_size =
 			mxc_jpeg_setup_cfg_stream(cfg_stream_vaddr,
 						  q_data->fmt->fourcc,
-						  q_data->w,
-						  q_data->h);
+						  q_data->crop.width,
+						  q_data->crop.height);
 
 	/* chain the config descriptor with the encoding descriptor */
 	cfg_desc->next_descpt_ptr = desc_handle | MXC_NXT_DESCPT_EN;
@@ -942,11 +942,13 @@ static void mxc_jpeg_config_enc_desc(struct vb2_buffer *out_buf,
 	desc->next_descpt_ptr = 0; /* end of chain */
 
 	/* use adjusted resolution for CAST IP job */
-	w = q_data->w_adjusted;
-	h = q_data->h_adjusted;
+	w = q_data->crop.width;
+	h = q_data->crop.height;
+	v4l_bound_align_image(&w, w, MXC_JPEG_MAX_WIDTH, q_data->fmt->h_align,
+			      &h, h, MXC_JPEG_MAX_HEIGHT, q_data->fmt->v_align, 0);
 	mxc_jpeg_set_res(desc, w, h);
-	mxc_jpeg_set_line_pitch(desc, w * (q_data->fmt->depth / 8));
-	mxc_jpeg_set_bufsize(desc, desc->line_pitch * h);
+	mxc_jpeg_set_line_pitch(desc, q_data->bytesperline[0]);
+	mxc_jpeg_set_bufsize(desc, q_data->sizeimage[0]);
 	img_fmt = mxc_jpeg_fourcc_to_imgfmt(q_data->fmt->fourcc);
 	if (img_fmt == MXC_JPEG_INVALID)
 		dev_err(jpeg->dev, "No valid image format detected\n");
@@ -995,6 +997,10 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
 		q_data_cap->fmt = jpeg_src_buf->fmt;
 		q_data_cap->w_adjusted = q_data_cap->w;
 		q_data_cap->h_adjusted = q_data_cap->h;
+		q_data_cap->crop.left = 0;
+		q_data_cap->crop.top = 0;
+		q_data_cap->crop.width = jpeg_src_buf->w;
+		q_data_cap->crop.height = jpeg_src_buf->h;
 
 		/*
 		 * align up the resolution for CAST IP,
@@ -1007,7 +1013,7 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
 				      &q_data_cap->h_adjusted,
 				      q_data_cap->h_adjusted, /* adjust up */
 				      MXC_JPEG_MAX_HEIGHT,
-				      0,
+				      q_data_cap->fmt->v_align,
 				      0);
 
 		/* setup bytesperline/sizeimage for capture queue */
@@ -1016,6 +1022,7 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
 		notify_src_chg(ctx);
 		ctx->source_change = 1;
 	}
+
 	return ctx->source_change ? true : false;
 }
 
@@ -1201,30 +1208,18 @@ static int mxc_jpeg_queue_setup(struct vb2_queue *q,
 {
 	struct mxc_jpeg_ctx *ctx = vb2_get_drv_priv(q);
 	struct mxc_jpeg_q_data *q_data = NULL;
-	struct mxc_jpeg_q_data tmp_q;
 	int i;
 
 	q_data = mxc_jpeg_get_q_data(ctx, q->type);
 	if (!q_data)
 		return -EINVAL;
 
-	tmp_q.fmt = q_data->fmt;
-	tmp_q.w = q_data->w_adjusted;
-	tmp_q.h = q_data->h_adjusted;
-	for (i = 0; i < MXC_JPEG_MAX_PLANES; i++) {
-		tmp_q.bytesperline[i] = q_data->bytesperline[i];
-		tmp_q.sizeimage[i] = q_data->sizeimage[i];
-	}
-	mxc_jpeg_sizeimage(&tmp_q);
-	for (i = 0; i < MXC_JPEG_MAX_PLANES; i++)
-		tmp_q.sizeimage[i] = max(tmp_q.sizeimage[i], q_data->sizeimage[i]);
-
 	/* Handle CREATE_BUFS situation - *nplanes != 0 */
 	if (*nplanes) {
 		if (*nplanes != q_data->fmt->colplanes)
 			return -EINVAL;
 		for (i = 0; i < *nplanes; i++) {
-			if (sizes[i] < tmp_q.sizeimage[i])
+			if (sizes[i] < q_data->sizeimage[i])
 				return -EINVAL;
 		}
 		return 0;
@@ -1233,7 +1228,7 @@ static int mxc_jpeg_queue_setup(struct vb2_queue *q,
 	/* Handle REQBUFS situation */
 	*nplanes = q_data->fmt->colplanes;
 	for (i = 0; i < *nplanes; i++)
-		sizes[i] = tmp_q.sizeimage[i];
+		sizes[i] = q_data->sizeimage[i];
 
 	return 0;
 }
@@ -1366,17 +1361,17 @@ static void mxc_jpeg_bytesperline(struct mxc_jpeg_q_data *q, u32 precision)
 		 * applies to the first plane and is divided by the same factor
 		 * as the width field for the other planes
 		 */
-		q->bytesperline[0] = q->w * DIV_ROUND_UP(precision, 8);
+		q->bytesperline[0] = q->w_adjusted * DIV_ROUND_UP(precision, 8);
 		q->bytesperline[1] = q->bytesperline[0];
 	} else if (q->fmt->subsampling == V4L2_JPEG_CHROMA_SUBSAMPLING_422) {
-		q->bytesperline[0] = q->w * DIV_ROUND_UP(precision, 8) * 2;
+		q->bytesperline[0] = q->w_adjusted * DIV_ROUND_UP(precision, 8) * 2;
 		q->bytesperline[1] = 0;
 	} else if (q->fmt->subsampling == V4L2_JPEG_CHROMA_SUBSAMPLING_444) {
-		q->bytesperline[0] = q->w * DIV_ROUND_UP(precision, 8) * q->fmt->nc;
+		q->bytesperline[0] = q->w_adjusted * DIV_ROUND_UP(precision, 8) * q->fmt->nc;
 		q->bytesperline[1] = 0;
 	} else {
 		/* grayscale */
-		q->bytesperline[0] = q->w * DIV_ROUND_UP(precision, 8);
+		q->bytesperline[0] = q->w_adjusted * DIV_ROUND_UP(precision, 8);
 		q->bytesperline[1] = 0;
 	}
 }
@@ -1395,7 +1390,7 @@ static void mxc_jpeg_sizeimage(struct mxc_jpeg_q_data *q)
 		/* jpeg stream size must be multiple of 1K */
 		q->sizeimage[0] = ALIGN(q->sizeimage[0], 1024);
 	} else {
-		q->sizeimage[0] = q->bytesperline[0] * q->h;
+		q->sizeimage[0] = q->bytesperline[0] * q->h_adjusted;
 		q->sizeimage[1] = 0;
 		if (q->fmt->fourcc == V4L2_PIX_FMT_NV12M)
 			q->sizeimage[1] = q->sizeimage[0] / 2;
@@ -1619,6 +1614,10 @@ static void mxc_jpeg_set_default_params(struct mxc_jpeg_ctx *ctx)
 		q[i]->h = MXC_JPEG_DEFAULT_HEIGHT;
 		q[i]->w_adjusted = MXC_JPEG_DEFAULT_WIDTH;
 		q[i]->h_adjusted = MXC_JPEG_DEFAULT_HEIGHT;
+		q[i]->crop.left = 0;
+		q[i]->crop.top = 0;
+		q[i]->crop.width = MXC_JPEG_DEFAULT_WIDTH;
+		q[i]->crop.height = MXC_JPEG_DEFAULT_HEIGHT;
 		mxc_jpeg_bytesperline(q[i], q[i]->fmt->precision);
 		mxc_jpeg_sizeimage(q[i]);
 	}
@@ -1786,55 +1785,84 @@ static int mxc_jpeg_enum_fmt_vid_out(struct file *file, void *priv,
 	return 0;
 }
 
-static int mxc_jpeg_try_fmt(struct v4l2_format *f, const struct mxc_jpeg_fmt *fmt,
-			    struct mxc_jpeg_ctx *ctx, int q_type)
+static u32 mxc_jpeg_get_fmt_type(struct mxc_jpeg_ctx *ctx, u32 type)
+{
+	if (ctx->mxc_jpeg->mode == MXC_JPEG_DECODE)
+		return V4L2_TYPE_IS_OUTPUT(type) ? MXC_JPEG_FMT_TYPE_ENC : MXC_JPEG_FMT_TYPE_RAW;
+	else
+		return V4L2_TYPE_IS_CAPTURE(type) ? MXC_JPEG_FMT_TYPE_ENC : MXC_JPEG_FMT_TYPE_RAW;
+}
+
+static u32 mxc_jpeg_get_default_fourcc(struct mxc_jpeg_ctx *ctx, u32 type)
 {
+	if (ctx->mxc_jpeg->mode == MXC_JPEG_DECODE)
+		return V4L2_TYPE_IS_OUTPUT(type) ? V4L2_PIX_FMT_JPEG : MXC_JPEG_DEFAULT_PFMT;
+	else
+		return V4L2_TYPE_IS_CAPTURE(type) ? V4L2_PIX_FMT_JPEG : MXC_JPEG_DEFAULT_PFMT;
+}
+
+static int mxc_jpeg_try_fmt(struct v4l2_format *f,
+			    struct mxc_jpeg_ctx *ctx, struct mxc_jpeg_q_data *q_data)
+{
+	const struct mxc_jpeg_fmt *fmt;
 	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
 	struct v4l2_plane_pix_format *pfmt;
+	u32 fourcc = f->fmt.pix_mp.pixelformat;
 	u32 w = (pix_mp->width < MXC_JPEG_MAX_WIDTH) ?
 		 pix_mp->width : MXC_JPEG_MAX_WIDTH;
 	u32 h = (pix_mp->height < MXC_JPEG_MAX_HEIGHT) ?
 		 pix_mp->height : MXC_JPEG_MAX_HEIGHT;
 	int i;
-	struct mxc_jpeg_q_data tmp_q;
+
+	fmt = mxc_jpeg_find_format(ctx, fourcc);
+	if (!fmt || fmt->flags != mxc_jpeg_get_fmt_type(ctx, f->type)) {
+		dev_warn(ctx->mxc_jpeg->dev, "Format not supported: %c%c%c%c, use the default.\n",
+			 (fourcc & 0xff),
+			 (fourcc >>  8) & 0xff,
+			 (fourcc >> 16) & 0xff,
+			 (fourcc >> 24) & 0xff);
+		fourcc = mxc_jpeg_get_default_fourcc(ctx, f->type);
+		fmt = mxc_jpeg_find_format(ctx, fourcc);
+		if (!fmt)
+			return -EINVAL;
+		f->fmt.pix_mp.pixelformat = fourcc;
+	}
+	q_data->fmt = fmt;
 
 	memset(pix_mp->reserved, 0, sizeof(pix_mp->reserved));
 	pix_mp->field = V4L2_FIELD_NONE;
 	pix_mp->num_planes = fmt->colplanes;
 	pix_mp->pixelformat = fmt->fourcc;
 
-	pix_mp->width = w;
-	pix_mp->height = h;
-	v4l_bound_align_image(&w,
+	q_data->w = w;
+	q_data->h = h;
+	q_data->w_adjusted = w;
+	q_data->h_adjusted = h;
+	v4l_bound_align_image(&q_data->w_adjusted,
 			      w, /* adjust upwards*/
 			      MXC_JPEG_MAX_WIDTH,
 			      fmt->h_align,
-			      &h,
+			      &q_data->h_adjusted,
 			      h, /* adjust upwards*/
 			      MXC_JPEG_MAX_HEIGHT,
-			      0,
+			      fmt->v_align,
 			      0);
-
-	/* get user input into the tmp_q */
-	tmp_q.w = w;
-	tmp_q.h = h;
-	tmp_q.fmt = fmt;
 	for (i = 0; i < pix_mp->num_planes; i++) {
 		pfmt = &pix_mp->plane_fmt[i];
-		tmp_q.bytesperline[i] = pfmt->bytesperline;
-		tmp_q.sizeimage[i] = pfmt->sizeimage;
+		q_data->bytesperline[i] = pfmt->bytesperline;
+		q_data->sizeimage[i] = pfmt->sizeimage;
 	}
 
-	/* calculate bytesperline & sizeimage into the tmp_q */
-	mxc_jpeg_bytesperline(&tmp_q, fmt->precision);
-	mxc_jpeg_sizeimage(&tmp_q);
+	/* calculate bytesperline & sizeimage */
+	mxc_jpeg_bytesperline(q_data, fmt->precision);
+	mxc_jpeg_sizeimage(q_data);
 
 	/* adjust user format according to our calculations */
 	for (i = 0; i < pix_mp->num_planes; i++) {
 		pfmt = &pix_mp->plane_fmt[i];
 		memset(pfmt->reserved, 0, sizeof(pfmt->reserved));
-		pfmt->bytesperline = tmp_q.bytesperline[i];
-		pfmt->sizeimage = tmp_q.sizeimage[i];
+		pfmt->bytesperline = q_data->bytesperline[i];
+		pfmt->sizeimage = q_data->sizeimage[i];
 	}
 
 	/* fix colorspace information to sRGB for both output & capture */
@@ -1848,6 +1876,16 @@ static int mxc_jpeg_try_fmt(struct v4l2_format *f, const struct mxc_jpeg_fmt *fm
 	 */
 	pix_mp->quantization = V4L2_QUANTIZATION_FULL_RANGE;
 
+	if (fmt->flags == MXC_JPEG_FMT_TYPE_RAW) {
+		q_data->crop.left = 0;
+		q_data->crop.top = 0;
+		q_data->crop.width = q_data->w;
+		q_data->crop.height = q_data->h;
+	}
+
+	pix_mp->width = q_data->w_adjusted;
+	pix_mp->height = q_data->h_adjusted;
+
 	return 0;
 }
 
@@ -1857,29 +1895,14 @@ static int mxc_jpeg_try_fmt_vid_cap(struct file *file, void *priv,
 	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(priv);
 	struct mxc_jpeg_dev *jpeg = ctx->mxc_jpeg;
 	struct device *dev = jpeg->dev;
-	const struct mxc_jpeg_fmt *fmt;
-	u32 fourcc = f->fmt.pix_mp.pixelformat;
-
-	int q_type = (jpeg->mode == MXC_JPEG_DECODE) ?
-		     MXC_JPEG_FMT_TYPE_RAW : MXC_JPEG_FMT_TYPE_ENC;
+	struct mxc_jpeg_q_data tmp_q;
 
 	if (!V4L2_TYPE_IS_MULTIPLANAR(f->type)) {
 		dev_err(dev, "TRY_FMT with Invalid type: %d\n", f->type);
 		return -EINVAL;
 	}
 
-	fmt = mxc_jpeg_find_format(ctx, fourcc);
-	if (!fmt || fmt->flags != q_type) {
-		dev_warn(dev, "Format not supported: %c%c%c%c, use the default.\n",
-			 (fourcc & 0xff),
-			 (fourcc >>  8) & 0xff,
-			 (fourcc >> 16) & 0xff,
-			 (fourcc >> 24) & 0xff);
-		f->fmt.pix_mp.pixelformat = (jpeg->mode == MXC_JPEG_DECODE) ?
-				MXC_JPEG_DEFAULT_PFMT : V4L2_PIX_FMT_JPEG;
-		fmt = mxc_jpeg_find_format(ctx, f->fmt.pix_mp.pixelformat);
-	}
-	return mxc_jpeg_try_fmt(f, fmt, ctx, q_type);
+	return mxc_jpeg_try_fmt(f, ctx, &tmp_q);
 }
 
 static int mxc_jpeg_try_fmt_vid_out(struct file *file, void *priv,
@@ -1888,88 +1911,55 @@ static int mxc_jpeg_try_fmt_vid_out(struct file *file, void *priv,
 	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(priv);
 	struct mxc_jpeg_dev *jpeg = ctx->mxc_jpeg;
 	struct device *dev = jpeg->dev;
-	const struct mxc_jpeg_fmt *fmt;
-	u32 fourcc = f->fmt.pix_mp.pixelformat;
-
-	int q_type = (jpeg->mode == MXC_JPEG_ENCODE) ?
-		     MXC_JPEG_FMT_TYPE_RAW : MXC_JPEG_FMT_TYPE_ENC;
+	struct mxc_jpeg_q_data tmp_q;
 
 	if (!V4L2_TYPE_IS_MULTIPLANAR(f->type)) {
 		dev_err(dev, "TRY_FMT with Invalid type: %d\n", f->type);
 		return -EINVAL;
 	}
 
-	fmt = mxc_jpeg_find_format(ctx, fourcc);
-	if (!fmt || fmt->flags != q_type) {
-		dev_warn(dev, "Format not supported: %c%c%c%c, use the default.\n",
-			 (fourcc & 0xff),
-			 (fourcc >>  8) & 0xff,
-			 (fourcc >> 16) & 0xff,
-			 (fourcc >> 24) & 0xff);
-		f->fmt.pix_mp.pixelformat = (jpeg->mode == MXC_JPEG_ENCODE) ?
-				MXC_JPEG_DEFAULT_PFMT : V4L2_PIX_FMT_JPEG;
-		fmt = mxc_jpeg_find_format(ctx, f->fmt.pix_mp.pixelformat);
-	}
-	return mxc_jpeg_try_fmt(f, fmt, ctx, q_type);
+	return mxc_jpeg_try_fmt(f, ctx, &tmp_q);
+}
+
+static void mxc_jpeg_s_parsed_fmt(struct mxc_jpeg_ctx *ctx, struct v4l2_format *f)
+{
+	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
+	struct mxc_jpeg_q_data *q_data_cap;
+
+	if (ctx->mxc_jpeg->mode != MXC_JPEG_DECODE || !V4L2_TYPE_IS_CAPTURE(f->type))
+		return;
+	if (!ctx->header_parsed)
+		return;
+
+	q_data_cap = mxc_jpeg_get_q_data(ctx, f->type);
+	pix_mp->pixelformat = q_data_cap->fmt->fourcc;
+	pix_mp->width = q_data_cap->w;
+	pix_mp->height = q_data_cap->h;
 }
 
 static int mxc_jpeg_s_fmt(struct mxc_jpeg_ctx *ctx,
 			  struct v4l2_format *f)
 {
 	struct vb2_queue *vq;
-	struct mxc_jpeg_q_data *q_data = NULL;
-	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
 	struct mxc_jpeg_dev *jpeg = ctx->mxc_jpeg;
-	int i;
 
 	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, f->type);
 	if (!vq)
 		return -EINVAL;
 
-	q_data = mxc_jpeg_get_q_data(ctx, f->type);
-
 	if (vb2_is_busy(vq)) {
 		v4l2_err(&jpeg->v4l2_dev, "queue busy\n");
 		return -EBUSY;
 	}
 
-	q_data->fmt = mxc_jpeg_find_format(ctx, pix_mp->pixelformat);
-	q_data->w = pix_mp->width;
-	q_data->h = pix_mp->height;
-
-	q_data->w_adjusted = q_data->w;
-	q_data->h_adjusted = q_data->h;
-	/*
-	 * align up the resolution for CAST IP,
-	 * but leave the buffer resolution unchanged
-	 */
-	v4l_bound_align_image(&q_data->w_adjusted,
-			      q_data->w_adjusted,  /* adjust upwards */
-			      MXC_JPEG_MAX_WIDTH,
-			      q_data->fmt->h_align,
-			      &q_data->h_adjusted,
-			      q_data->h_adjusted, /* adjust upwards */
-			      MXC_JPEG_MAX_HEIGHT,
-			      q_data->fmt->v_align,
-			      0);
-
-	for (i = 0; i < pix_mp->num_planes; i++) {
-		q_data->bytesperline[i] = pix_mp->plane_fmt[i].bytesperline;
-		q_data->sizeimage[i] = pix_mp->plane_fmt[i].sizeimage;
-	}
+	mxc_jpeg_s_parsed_fmt(ctx, f);
 
-	return 0;
+	return mxc_jpeg_try_fmt(f, ctx, mxc_jpeg_get_q_data(ctx, f->type));
 }
 
 static int mxc_jpeg_s_fmt_vid_cap(struct file *file, void *priv,
 				  struct v4l2_format *f)
 {
-	int ret;
-
-	ret = mxc_jpeg_try_fmt_vid_cap(file, priv, f);
-	if (ret)
-		return ret;
-
 	return mxc_jpeg_s_fmt(mxc_jpeg_fh_to_ctx(priv), f);
 }
 
@@ -1983,10 +1973,6 @@ static int mxc_jpeg_s_fmt_vid_out(struct file *file, void *priv,
 	enum v4l2_buf_type cap_type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
 	struct v4l2_format fc;
 
-	ret = mxc_jpeg_try_fmt_vid_out(file, priv, f);
-	if (ret)
-		return ret;
-
 	ret = mxc_jpeg_s_fmt(mxc_jpeg_fh_to_ctx(priv), f);
 	if (ret)
 		return ret;
@@ -2032,6 +2018,10 @@ static int mxc_jpeg_g_fmt_vid(struct file *file, void *priv,
 	pix_mp->width = q_data->w;
 	pix_mp->height = q_data->h;
 	pix_mp->field = V4L2_FIELD_NONE;
+	if (q_data->fmt->flags == MXC_JPEG_FMT_TYPE_RAW) {
+		pix_mp->width = q_data->w_adjusted;
+		pix_mp->height = q_data->h_adjusted;
+	}
 
 	/* fix colorspace information to sRGB for both output & capture */
 	pix_mp->colorspace = V4L2_COLORSPACE_SRGB;
@@ -2048,6 +2038,100 @@ static int mxc_jpeg_g_fmt_vid(struct file *file, void *priv,
 	return 0;
 }
 
+static int mxc_jpeg_dec_g_selection(struct file *file, void *fh, struct v4l2_selection *s)
+{
+	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(fh);
+	struct mxc_jpeg_q_data *q_data_cap;
+
+	if (s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE && s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
+		return -EINVAL;
+
+	q_data_cap = mxc_jpeg_get_q_data(ctx, s->type);
+
+	switch (s->target) {
+	case V4L2_SEL_TGT_COMPOSE:
+	case V4L2_SEL_TGT_COMPOSE_DEFAULT:
+		s->r = q_data_cap->crop;
+		break;
+	case V4L2_SEL_TGT_COMPOSE_PADDED:
+	case V4L2_SEL_TGT_COMPOSE_BOUNDS:
+		s->r.left = 0;
+		s->r.top = 0;
+		s->r.width = q_data_cap->w_adjusted;
+		s->r.height = q_data_cap->h_adjusted;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mxc_jpeg_enc_g_selection(struct file *file, void *fh, struct v4l2_selection *s)
+{
+	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(fh);
+	struct mxc_jpeg_q_data *q_data_out;
+
+	if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT && s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
+		return -EINVAL;
+
+	q_data_out = mxc_jpeg_get_q_data(ctx, s->type);
+
+	switch (s->target) {
+	case V4L2_SEL_TGT_CROP_DEFAULT:
+	case V4L2_SEL_TGT_CROP_BOUNDS:
+		s->r.left = 0;
+		s->r.top = 0;
+		s->r.width = q_data_out->w;
+		s->r.height = q_data_out->h;
+		break;
+	case V4L2_SEL_TGT_CROP:
+		s->r = q_data_out->crop;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mxc_jpeg_g_selection(struct file *file, void *fh, struct v4l2_selection *s)
+{
+	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(fh);
+
+	if (ctx->mxc_jpeg->mode == MXC_JPEG_DECODE)
+		return mxc_jpeg_dec_g_selection(file, fh, s);
+	else
+		return mxc_jpeg_enc_g_selection(file, fh, s);
+}
+
+static int mxc_jpeg_s_selection(struct file *file, void *fh, struct v4l2_selection *s)
+{
+	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(fh);
+	struct mxc_jpeg_q_data *q_data_out;
+
+	if (ctx->mxc_jpeg->mode != MXC_JPEG_ENCODE)
+		return -ENOTTY;
+
+	if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT && s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
+		return -EINVAL;
+	if (s->target != V4L2_SEL_TGT_CROP)
+		return -EINVAL;
+
+	q_data_out = mxc_jpeg_get_q_data(ctx, s->type);
+	if (s->r.left || s->r.top)
+		return -EINVAL;
+	if (s->r.width > q_data_out->w || s->r.height > q_data_out->h)
+		return -EINVAL;
+
+	q_data_out->crop.left = 0;
+	q_data_out->crop.top = 0;
+	q_data_out->crop.width = s->r.width;
+	q_data_out->crop.height = s->r.height;
+
+	return 0;
+}
+
 static int mxc_jpeg_subscribe_event(struct v4l2_fh *fh,
 				    const struct v4l2_event_subscription *sub)
 {
@@ -2077,6 +2161,9 @@ static const struct v4l2_ioctl_ops mxc_jpeg_ioctl_ops = {
 	.vidioc_g_fmt_vid_cap_mplane	= mxc_jpeg_g_fmt_vid,
 	.vidioc_g_fmt_vid_out_mplane	= mxc_jpeg_g_fmt_vid,
 
+	.vidioc_g_selection		= mxc_jpeg_g_selection,
+	.vidioc_s_selection		= mxc_jpeg_s_selection,
+
 	.vidioc_subscribe_event		= mxc_jpeg_subscribe_event,
 	.vidioc_unsubscribe_event	= v4l2_event_unsubscribe,
 
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
index 8104ee4a3b7a..f75dfc89ff6d 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
@@ -84,6 +84,7 @@ struct mxc_jpeg_q_data {
 	int				h;
 	int				h_adjusted;
 	unsigned int			sequence;
+	struct v4l2_rect		crop;
 };
 
 struct mxc_jpeg_ctx {
-- 
2.37.1

