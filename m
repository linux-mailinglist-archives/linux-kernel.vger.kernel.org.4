Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9C55BF37A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 04:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiIUCa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 22:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiIUCaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 22:30:21 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DCD40BE9;
        Tue, 20 Sep 2022 19:30:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvHdEP/XcRPx8jBAnaC2RY+OeRUBkJINyK8QEFyo5RxPx2l/4KoWSlIhWywVeDCI08eHCYA//Q9yRRKbvNzPYtUijHX/xi3dRqL5Exmqww1PJr+7xEfp6W3g0jlWrMOjZbmjdeqExCFhxhdWxr5FyNOMGKZ8q/+eQT9alpV63V027xhcKUiSF1SG2PhQVzLlFDznwehE9G2dxtema05xmTATdpvCvYTrYhmep0AZXIq6JvWq/CNlXLrzbEnHN+T27CGrxDyUCXNzGLCkY6h2NiWjoc81YNq7/VjzTth82lLQweTP8nd9mP0poEYsU16dcSJD2o7l3y781r+gbQX+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNH+cj4E6grdttzE/rzfSFQk5YvyfNTy2wZ7sz8EsX0=;
 b=Q5r4mqi3tvhzeKlQ2O+Zf/zriKUKsk+X8Z7HxUjW+546tmrtsDmusL0R38Say+w+iSbsvC9LtkVkOk2A6yZNHVi8bYLxLU7pU/vVVqUj7Jt940puk1gmonXCYVsHKhLjKM45wYmPu/hgZDL4MORh4BLHe6hxqsaDQtTtrupbMJnbS1TuEvIy+7jxQgHzWmPtoq9qnNuSjiF2qRFhI08fzQ/aX7N2rOh7ioOBRD23TOpTWJQtCPmNDs5xtrkd0oY6IGi853DtIcewxSvr5J3+RK4RoQsdagRjIrwLGQLb4n3VMTEYCWVg89euuUjTpvPlSfT/sPFX4hJXDFvbKBCWkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNH+cj4E6grdttzE/rzfSFQk5YvyfNTy2wZ7sz8EsX0=;
 b=eHZiMWsynICMQQ1oYNMLByL8+ruxs2DBVBURHrXOSkN3EoO2eq1+Hak4+uXF0ujhkHwk6M5D4cxV7GsTahhB4Ix+yWX64B/SVqiJzuP/k6eWjoPOJnU1lh87DU1UKLmOPnV1rHW9ybFITAEPBPUQNNOO1vxqHasNYdSWObx71bs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB8767.eurprd04.prod.outlook.com (2603:10a6:102:20e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 02:30:17 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::4550:e439:2389:be53]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::4550:e439:2389:be53%5]) with mapi id 15.20.5632.024; Wed, 21 Sep 2022
 02:30:17 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] media: imx-jpeg: Support contiguous and non contiguous format
Date:   Wed, 21 Sep 2022 10:29:19 +0800
Message-Id: <ed620a2f0da1873477c9ce25ec13c5683468e2fc.1663726876.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 73cb717b-6eea-44fe-d764-08da9b793886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dBfSGaAjcG2h6e/98iRIdJ4McNu9b7z+ALSP7VcYi2Sbpk3KImtwnO7SsgPBrfnjsq/bQiHFkHgH1VbxEM0WcoL9w+n8NdF62jQMTN0jrsBvJAvPU/Xo7dHVEWT2ZLthfa2Dx46KvwqovrUVE/wRuHT4JvZryQRvgvLSqS7/lu1DK0HpiAhjK6XlCTSDW0o+uYj50anViXiH7MF/uprTO6gHSXwjrLwxGNpDRo49Ld5zYiYsm3wg66SWxDcPian3Nj1LpygjzWvOX8iM6UgfhPKGYtxpX2SjHEqWiGgZg7mINkNWqc4V/eZkYUxATDW+TWCSXqdLvzsBCULHOBVGWLQTECF1LkkwI+VTpXlGzIp/iEvMNyPYCPUcodd+1+pZ4W/KTI11ycu1HXMEZ4bLBR2Kj8k0O+VekzuTN/MKjrytN6GNC4VCb2zlK1LxBDuIDEvenCjq34kG0ZeV1aFh20zKYtY8hJXXuQRZhvSB1aZ97tperT035doijSnzp6zfEmWBP7Us08DEP/P/xjP6eXsX1wip5A1sd+uSxdijgW3xdA5/uiUIiivED47v6LaOlQs8mYd2B43mL56emNPt5c18j7yFPxKYXEwk/6kVJFiT7PJVZnUVxINeo0mB59D5rCciXsR7IUDdEoFPuUUzsvH0f0tDGABv0NRIpX+tFAdzcDUrEQ+7RoIeSB1fUDNEs6zQLFFGRXTFoZmYHXLJY/Sr7XhlEzTJ8wqHbNaeJRXcSVzXYwhdcL0lgj/j29CL5mzRNjo7gtBQSdG4INWbzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199015)(2906002)(6512007)(52116002)(26005)(66476007)(66946007)(316002)(86362001)(36756003)(66556008)(8676002)(5660300002)(4326008)(44832011)(186003)(7416002)(30864003)(8936002)(478600001)(38350700002)(6486002)(38100700002)(6506007)(2616005)(41300700001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l6A3QH5YqcGSCn7OGogaMYnGFJp0BD20rP61ybPxembH6nDMYLa3fwbK3TIg?=
 =?us-ascii?Q?k/WzrX0S2yvDbKsMXLoMDcbGcoGB4qeEydGp895uFIJXYqxCSvtnyG/Yix0l?=
 =?us-ascii?Q?1FNIGh8yBZHIWpSzBUAEDlQCkaEIes8Iq1mn4M19Qs4dycD8BD7J/G26noFk?=
 =?us-ascii?Q?sPPW88aAUKTrHP1SdtEHwfB8Umri9RfBuogxW+P3J5Z0ZHzSlaqaL898k3og?=
 =?us-ascii?Q?G4pYLvmDrV/sKvlHVwYHHWX11l55yPqP+409ciAtfznUoR5KwUEYq0ll7i7u?=
 =?us-ascii?Q?1WPhNHsz9D7y4ivCjAQsXKIB0YHTGTRCQCL5TpzrGxkN1Q65EUlnvCrM+Xv6?=
 =?us-ascii?Q?+EF7AwIe+njs1wB67I3xoAyswX3cCUaHPgv5b844ZMMaUg668ZeFbtFoRQgu?=
 =?us-ascii?Q?TceXomlQV4fAMBLB75wIO/h/hFm8WZ37DOFsp3jo1YCrHdcuk9ADLeb4vozY?=
 =?us-ascii?Q?7WM7P2eo1mSs9JviNbYjSbRcZ9Dzyl+0Z1VAuKgg9PBmIeE1DftLJ9UOVrK4?=
 =?us-ascii?Q?tYtpa4M9hU8dpQDvO6O5IQpImHtWLo0oUnys38ZZEd9XjziiREELBcAl6Iq4?=
 =?us-ascii?Q?Bz3JmCnPyMzoRYGzAWj5m2TWmtM+L3MFgAWcWZWIrJQVQrfWUm50H6uosU6L?=
 =?us-ascii?Q?Cn3Q8zOeDNc3+NzcTmnhvsWQO02mj2kwvuGrD4b70Pc+ZQN/i02zh91H2k3s?=
 =?us-ascii?Q?3t6V681xYQQoU1lCQqrNEswTaHkfx12Ax9xUKx+Gvdf4NxPo3EBLTaghPIiE?=
 =?us-ascii?Q?ays44zY99V0arCmohS9kJfkLN+P7Xq8nt0+wohz7yzUSOid6o35exRyl9MXq?=
 =?us-ascii?Q?7GNRV2lOw1sBTdVrUzdE4yAmKccUJk9a2Q/krq90UZT2ms0CKUy/DJ5xo1A3?=
 =?us-ascii?Q?P5ramKVm/S/aVijZb+sa7sBzRuMVbD3W64tQvn5gTCTXLHfFevopV5f8feqh?=
 =?us-ascii?Q?X6PgzNZ0ihpv1tZyrce7BlQsZ8yQCIWyICa1szfdaE1VuqgAnI5+qK2O1Tbx?=
 =?us-ascii?Q?KiJHyYm6K+gWW/wJXJ6PjPGUrG9HrD/KpN/uUOB2MMyUQZwlvklEUiz81IZy?=
 =?us-ascii?Q?i4z3jEjvH1Vi4pk3FbWN8thpg+hu4iyecc14SGQrcQ6wDwEAeQYTJuZceDRj?=
 =?us-ascii?Q?yCxMWFzQ/sl1AfmTYCbKLUKH0/PakrYdBYj1VsXbPHU7kymI6T5i9CTdGv6R?=
 =?us-ascii?Q?sAfISBC05IJNHXEoI6z7OsNaVfryiYY09D7R8ivgkV4RbrEPJdtt5DK923zy?=
 =?us-ascii?Q?hhwBzE2Nvx3EvB7SbLxwMXVbgcDho84YKMx5RxrpY0mqliMUVT4u07x48HKK?=
 =?us-ascii?Q?GRpXUuaNFSXFHUgUyG96TTisP7sPRFxoz9mw1OywRI/T54fyfCbgbJ4wqP5Z?=
 =?us-ascii?Q?EgJmuvsIMwSlgKNrBAwBIQ8Fltz6UzvevwYn61NjJspoerNcanpVRyTk1gFS?=
 =?us-ascii?Q?5x+wXlFRguOC8dXLq95CzelI6Z6SlR8gfsOKwfElImdoOEfYpls/6OvzofIZ?=
 =?us-ascii?Q?ewN4w+uFnAUpleDVEgffXo4cKq+sAZtR+ss18OW4IMWi1bcMyG22DNXZVl63?=
 =?us-ascii?Q?XMxRkjgE1D4Thxhll//yvVbWe35zbEfdQq//Po4E?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cb717b-6eea-44fe-d764-08da9b793886
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 02:30:16.9930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elY8fZOtfTlkRqbrDZT23T9XblnalY/qt9pQhz1EfO2REp38OX+fln/jkIqRgJ20rz9XMqo0VWKlktfZ+Qr0fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8767
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mxc-jpeg supports non contiguous format nv12m,
and in order to compatible with the devices
that only support contiguous format nv12,
jpeg can support nv12 and nv12m in the same time.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 226 ++++++++++++++----
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |   7 +-
 2 files changed, 185 insertions(+), 48 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index f28af58aa56b..4ebd0e495b82 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -69,7 +69,8 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.fourcc		= V4L2_PIX_FMT_JPEG,
 		.subsampling	= -1,
 		.nc		= -1,
-		.colplanes	= 1,
+		.mem_planes	= 1,
+		.comp_planes	= 1,
 		.flags		= MXC_JPEG_FMT_TYPE_ENC,
 	},
 	{
@@ -78,11 +79,13 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_444,
 		.nc		= 3,
 		.depth		= 24,
-		.colplanes	= 1,
+		.mem_planes	= 1,
+		.comp_planes	= 1,
 		.h_align	= 3,
 		.v_align	= 3,
 		.flags		= MXC_JPEG_FMT_TYPE_RAW,
 		.precision	= 8,
+		.is_rgb		= 1,
 	},
 	{
 		.name		= "ABGR", /* ABGR packed format */
@@ -90,11 +93,13 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_444,
 		.nc		= 4,
 		.depth		= 32,
-		.colplanes	= 1,
+		.mem_planes	= 1,
+		.comp_planes	= 1,
 		.h_align	= 3,
 		.v_align	= 3,
 		.flags		= MXC_JPEG_FMT_TYPE_RAW,
 		.precision	= 8,
+		.is_rgb		= 1,
 	},
 	{
 		.name		= "YUV420", /* 1st plane = Y, 2nd plane = UV */
@@ -102,7 +107,21 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_420,
 		.nc		= 3,
 		.depth		= 12, /* 6 bytes (4Y + UV) for 4 pixels */
-		.colplanes	= 2, /* 1 plane Y, 1 plane UV interleaved */
+		.mem_planes	= 2,
+		.comp_planes	= 2, /* 1 plane Y, 1 plane UV interleaved */
+		.h_align	= 4,
+		.v_align	= 4,
+		.flags		= MXC_JPEG_FMT_TYPE_RAW,
+		.precision	= 8,
+	},
+	{
+		.name		= "YUV420", /* 1st plane = Y, 2nd plane = UV */
+		.fourcc		= V4L2_PIX_FMT_NV12,
+		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_420,
+		.nc		= 3,
+		.depth		= 12, /* 6 bytes (4Y + UV) for 4 pixels */
+		.mem_planes	= 1,
+		.comp_planes	= 2, /* 1 plane Y, 1 plane UV interleaved */
 		.h_align	= 4,
 		.v_align	= 4,
 		.flags		= MXC_JPEG_FMT_TYPE_RAW,
@@ -114,7 +133,8 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_422,
 		.nc		= 3,
 		.depth		= 16,
-		.colplanes	= 1,
+		.mem_planes	= 1,
+		.comp_planes	= 1,
 		.h_align	= 4,
 		.v_align	= 3,
 		.flags		= MXC_JPEG_FMT_TYPE_RAW,
@@ -126,7 +146,8 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_444,
 		.nc		= 3,
 		.depth		= 24,
-		.colplanes	= 1,
+		.mem_planes	= 1,
+		.comp_planes	= 1,
 		.h_align	= 3,
 		.v_align	= 3,
 		.flags		= MXC_JPEG_FMT_TYPE_RAW,
@@ -138,7 +159,8 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_GRAY,
 		.nc		= 1,
 		.depth		= 8,
-		.colplanes	= 1,
+		.mem_planes	= 1,
+		.comp_planes	= 1,
 		.h_align	= 3,
 		.v_align	= 3,
 		.flags		= MXC_JPEG_FMT_TYPE_RAW,
@@ -419,6 +441,7 @@ static enum mxc_jpeg_image_format mxc_jpeg_fourcc_to_imgfmt(u32 fourcc)
 		return MXC_JPEG_GRAY;
 	case V4L2_PIX_FMT_YUYV:
 		return MXC_JPEG_YUV422;
+	case V4L2_PIX_FMT_NV12:
 	case V4L2_PIX_FMT_NV12M:
 		return MXC_JPEG_YUV420;
 	case V4L2_PIX_FMT_YUV24:
@@ -445,12 +468,17 @@ static void mxc_jpeg_addrs(struct mxc_jpeg_desc *desc,
 			   struct vb2_buffer *jpeg_buf, int offset)
 {
 	int img_fmt = desc->stm_ctrl & STM_CTRL_IMAGE_FORMAT_MASK;
+	struct mxc_jpeg_ctx *ctx = vb2_get_drv_priv(raw_buf->vb2_queue);
+	struct mxc_jpeg_q_data *q_data;
 
+	q_data = mxc_jpeg_get_q_data(ctx, raw_buf->type);
 	desc->buf_base0 = vb2_dma_contig_plane_dma_addr(raw_buf, 0);
 	desc->buf_base1 = 0;
 	if (img_fmt == STM_CTRL_IMAGE_FORMAT(MXC_JPEG_YUV420)) {
-		WARN_ON(raw_buf->num_planes < 2);
-		desc->buf_base1 = vb2_dma_contig_plane_dma_addr(raw_buf, 1);
+		if (raw_buf->num_planes == 2)
+			desc->buf_base1 = vb2_dma_contig_plane_dma_addr(raw_buf, 1);
+		else
+			desc->buf_base1 = desc->buf_base0 + q_data->sizeimage[0];
 	}
 	desc->stm_bufbase = vb2_dma_contig_plane_dma_addr(jpeg_buf, 0) +
 		offset;
@@ -594,6 +622,28 @@ static void mxc_jpeg_job_finish(struct mxc_jpeg_ctx *ctx, enum vb2_buffer_state
 		mxc_jpeg_sw_reset(reg);
 }
 
+static u32 mxc_jpeg_get_plane_size(struct mxc_jpeg_q_data *q_data, u32 plane_no)
+{
+	const struct mxc_jpeg_fmt *fmt = q_data->fmt;
+	u32 size;
+	int i;
+
+	if (plane_no >= fmt->mem_planes)
+		return 0;
+
+	if (fmt->mem_planes == fmt->comp_planes)
+		return q_data->sizeimage[plane_no];
+
+	if (plane_no < fmt->mem_planes - 1)
+		return q_data->sizeimage[plane_no];
+
+	size = q_data->sizeimage[fmt->mem_planes - 1];
+	for (i = fmt->mem_planes; i < fmt->comp_planes; i++)
+		size += q_data->sizeimage[i];
+
+	return size;
+}
+
 static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
 {
 	struct mxc_jpeg_dev *jpeg = priv;
@@ -673,11 +723,11 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
 			payload);
 	} else {
 		q_data = mxc_jpeg_get_q_data(ctx, cap_type);
-		payload = q_data->sizeimage[0];
+		payload = mxc_jpeg_get_plane_size(q_data, 0);
 		vb2_set_plane_payload(&dst_buf->vb2_buf, 0, payload);
 		vb2_set_plane_payload(&dst_buf->vb2_buf, 1, 0);
-		if (q_data->fmt->colplanes == 2) {
-			payload = q_data->sizeimage[1];
+		if (q_data->fmt->mem_planes == 2) {
+			payload = mxc_jpeg_get_plane_size(q_data, 1);
 			vb2_set_plane_payload(&dst_buf->vb2_buf, 1, payload);
 		}
 		dev_dbg(dev, "Decoding finished, payload size: %ld + %ld\n",
@@ -716,6 +766,7 @@ static int mxc_jpeg_fixup_sof(struct mxc_jpeg_sof *sof,
 	_bswap16(&sof->width);
 
 	switch (fourcc) {
+	case V4L2_PIX_FMT_NV12:
 	case V4L2_PIX_FMT_NV12M:
 		sof->components_no = 3;
 		sof->comp[0].v = 0x2;
@@ -752,6 +803,7 @@ static int mxc_jpeg_fixup_sos(struct mxc_jpeg_sos *sos,
 	u8 *sof_u8 = (u8 *)sos;
 
 	switch (fourcc) {
+	case V4L2_PIX_FMT_NV12:
 	case V4L2_PIX_FMT_NV12M:
 		sos->components_no = 3;
 		break;
@@ -967,6 +1019,32 @@ static void mxc_jpeg_config_enc_desc(struct vb2_buffer *out_buf,
 	mxc_jpeg_set_desc(cfg_desc_handle, reg, slot);
 }
 
+static const struct mxc_jpeg_fmt *mxc_jpeg_get_sibling_format(const struct mxc_jpeg_fmt *fmt)
+{
+	int i;
+
+	for (i = 0; i < MXC_JPEG_NUM_FORMATS; i++) {
+		if (mxc_formats[i].subsampling == fmt->subsampling &&
+		    mxc_formats[i].nc == fmt->nc &&
+		    mxc_formats[i].precision == fmt->precision &&
+		    mxc_formats[i].is_rgb == fmt->is_rgb &&
+		    mxc_formats[i].fourcc != fmt->fourcc)
+			return &mxc_formats[i];
+	}
+
+	return NULL;
+}
+
+static bool mxc_jpeg_compare_format(const struct mxc_jpeg_fmt *fmt1,
+				    const struct mxc_jpeg_fmt *fmt2)
+{
+	if (fmt1 == fmt2)
+		return true;
+	if (mxc_jpeg_get_sibling_format(fmt1) == fmt2)
+		return true;
+	return false;
+}
+
 static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
 				   struct mxc_jpeg_src_buf *jpeg_src_buf)
 {
@@ -977,6 +1055,8 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
 		return false;
 
 	q_data_cap = mxc_jpeg_get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
+	if (mxc_jpeg_compare_format(q_data_cap->fmt, jpeg_src_buf->fmt))
+		jpeg_src_buf->fmt = q_data_cap->fmt;
 	if (q_data_cap->fmt != jpeg_src_buf->fmt ||
 	    q_data_cap->w != jpeg_src_buf->w ||
 	    q_data_cap->h != jpeg_src_buf->h) {
@@ -1081,9 +1161,9 @@ static void mxc_jpeg_device_run(void *priv)
 	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
 
 	jpeg_src_buf = vb2_to_mxc_buf(&src_buf->vb2_buf);
-	if (q_data_cap->fmt->colplanes != dst_buf->vb2_buf.num_planes) {
+	if (q_data_cap->fmt->mem_planes != dst_buf->vb2_buf.num_planes) {
 		dev_err(dev, "Capture format %s has %d planes, but capture buffer has %d planes\n",
-			q_data_cap->fmt->name, q_data_cap->fmt->colplanes,
+			q_data_cap->fmt->name, q_data_cap->fmt->mem_planes,
 			dst_buf->vb2_buf.num_planes);
 		jpeg_src_buf->jpeg_parse_error = true;
 	}
@@ -1216,19 +1296,19 @@ static int mxc_jpeg_queue_setup(struct vb2_queue *q,
 
 	/* Handle CREATE_BUFS situation - *nplanes != 0 */
 	if (*nplanes) {
-		if (*nplanes != q_data->fmt->colplanes)
+		if (*nplanes != q_data->fmt->mem_planes)
 			return -EINVAL;
 		for (i = 0; i < *nplanes; i++) {
-			if (sizes[i] < q_data->sizeimage[i])
+			if (sizes[i] < mxc_jpeg_get_plane_size(q_data, i))
 				return -EINVAL;
 		}
 		return 0;
 	}
 
 	/* Handle REQBUFS situation */
-	*nplanes = q_data->fmt->colplanes;
+	*nplanes = q_data->fmt->mem_planes;
 	for (i = 0; i < *nplanes; i++)
-		sizes[i] = q_data->sizeimage[i];
+		sizes[i] = mxc_jpeg_get_plane_size(q_data, i);
 
 	return 0;
 }
@@ -1313,19 +1393,40 @@ static int mxc_jpeg_valid_comp_id(struct device *dev,
 	return valid;
 }
 
+static bool mxc_jpeg_match_image_format(const struct mxc_jpeg_fmt *fmt,
+					const struct v4l2_jpeg_header *header)
+{
+	if (fmt->subsampling != header->frame.subsampling ||
+	    fmt->nc != header->frame.num_components ||
+	    fmt->precision != header->frame.precision)
+		return false;
+
+	/*
+	 * If the transform flag from APP14 marker is 0, images that are
+	 * encoded with 3 components have RGB colorspace, see Recommendation
+	 * ITU-T T.872 chapter 6.5.3 APP14 marker segment for colour encoding
+	 */
+	if (header->frame.subsampling == V4L2_JPEG_CHROMA_SUBSAMPLING_444) {
+		u8 is_rgb = header->app14_tf == V4L2_JPEG_APP14_TF_CMYK_RGB ? 1 : 0;
+
+		if (is_rgb != fmt->is_rgb)
+			return false;
+	}
+	return true;
+}
+
 static u32 mxc_jpeg_get_image_format(struct device *dev,
 				     const struct v4l2_jpeg_header *header)
 {
 	int i;
 	u32 fourcc = 0;
 
-	for (i = 0; i < MXC_JPEG_NUM_FORMATS; i++)
-		if (mxc_formats[i].subsampling == header->frame.subsampling &&
-		    mxc_formats[i].nc == header->frame.num_components &&
-		    mxc_formats[i].precision == header->frame.precision) {
+	for (i = 0; i < MXC_JPEG_NUM_FORMATS; i++) {
+		if (mxc_jpeg_match_image_format(&mxc_formats[i], header)) {
 			fourcc = mxc_formats[i].fourcc;
 			break;
 		}
+	}
 	if (fourcc == 0) {
 		dev_err(dev,
 			"Could not identify image format nc=%d, subsampling=%d, precision=%d\n",
@@ -1334,17 +1435,6 @@ static u32 mxc_jpeg_get_image_format(struct device *dev,
 			header->frame.precision);
 		return fourcc;
 	}
-	/*
-	 * If the transform flag from APP14 marker is 0, images that are
-	 * encoded with 3 components have RGB colorspace, see Recommendation
-	 * ITU-T T.872 chapter 6.5.3 APP14 marker segment for colour encoding
-	 */
-	if (fourcc == V4L2_PIX_FMT_YUV24 || fourcc == V4L2_PIX_FMT_BGR24) {
-		if (header->app14_tf == V4L2_JPEG_APP14_TF_CMYK_RGB)
-			fourcc = V4L2_PIX_FMT_BGR24;
-		else
-			fourcc = V4L2_PIX_FMT_YUV24;
-	}
 
 	return fourcc;
 }
@@ -1392,7 +1482,7 @@ static void mxc_jpeg_sizeimage(struct mxc_jpeg_q_data *q)
 	} else {
 		q->sizeimage[0] = q->bytesperline[0] * q->h_adjusted;
 		q->sizeimage[1] = 0;
-		if (q->fmt->fourcc == V4L2_PIX_FMT_NV12M)
+		if (q->fmt->subsampling == V4L2_JPEG_CHROMA_SUBSAMPLING_420)
 			q->sizeimage[1] = q->sizeimage[0] / 2;
 	}
 }
@@ -1401,6 +1491,7 @@ static int mxc_jpeg_parse(struct mxc_jpeg_ctx *ctx, struct vb2_buffer *vb)
 {
 	struct device *dev = ctx->mxc_jpeg->dev;
 	struct mxc_jpeg_q_data *q_data_out;
+	struct mxc_jpeg_q_data *q_data_cap;
 	u32 fourcc;
 	struct v4l2_jpeg_header header;
 	struct mxc_jpeg_sof *psof = NULL;
@@ -1458,7 +1549,11 @@ static int mxc_jpeg_parse(struct mxc_jpeg_ctx *ctx, struct vb2_buffer *vb)
 	if (!mxc_jpeg_valid_comp_id(dev, psof, psos))
 		dev_warn(dev, "JPEG component ids should be 0-3 or 1-4");
 
-	fourcc = mxc_jpeg_get_image_format(dev, &header);
+	q_data_cap = mxc_jpeg_get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
+	if (q_data_cap->fmt && mxc_jpeg_match_image_format(q_data_cap->fmt, &header))
+		fourcc = q_data_cap->fmt->fourcc;
+	else
+		fourcc = mxc_jpeg_get_image_format(dev, &header);
 	if (fourcc == 0)
 		return -EINVAL;
 
@@ -1534,8 +1629,8 @@ static int mxc_jpeg_buf_prepare(struct vb2_buffer *vb)
 	q_data = mxc_jpeg_get_q_data(ctx, vb->vb2_queue->type);
 	if (!q_data)
 		return -EINVAL;
-	for (i = 0; i < q_data->fmt->colplanes; i++) {
-		sizeimage = q_data->sizeimage[i];
+	for (i = 0; i < q_data->fmt->mem_planes; i++) {
+		sizeimage = mxc_jpeg_get_plane_size(q_data, i);
 		if (vb2_plane_size(vb, i) < sizeimage) {
 			dev_err(dev, "plane %d too small (%lu < %lu)",
 				i, vb2_plane_size(vb, i), sizeimage);
@@ -1762,10 +1857,25 @@ static int mxc_jpeg_enum_fmt_vid_cap(struct file *file, void *priv,
 		 * (more precisely what was propagated on capture queue
 		 * after jpeg parse on the output buffer)
 		 */
-		if (f->index)
-			return -EINVAL;
-		f->pixelformat = q_data->fmt->fourcc;
-		return 0;
+		int ret = -EINVAL;
+		const struct mxc_jpeg_fmt *sibling;
+
+		switch (f->index) {
+		case 0:
+			f->pixelformat = q_data->fmt->fourcc;
+			ret = 0;
+			break;
+		case 1:
+			sibling = mxc_jpeg_get_sibling_format(q_data->fmt);
+			if (sibling) {
+				f->pixelformat = sibling->fourcc;
+				ret = 0;
+			}
+			break;
+		default:
+			break;
+		}
+		return ret;
 	}
 }
 
@@ -1801,6 +1911,27 @@ static u32 mxc_jpeg_get_default_fourcc(struct mxc_jpeg_ctx *ctx, u32 type)
 		return V4L2_TYPE_IS_CAPTURE(type) ? V4L2_PIX_FMT_JPEG : MXC_JPEG_DEFAULT_PFMT;
 }
 
+static u32 mxc_jpeg_try_fourcc(struct mxc_jpeg_ctx *ctx, u32 fourcc)
+{
+	const struct mxc_jpeg_fmt *sibling;
+	struct mxc_jpeg_q_data *q_data_cap;
+
+	if (ctx->mxc_jpeg->mode != MXC_JPEG_DECODE)
+		return fourcc;
+	if (!ctx->header_parsed)
+		return fourcc;
+
+	q_data_cap = &ctx->cap_q;
+	if (q_data_cap->fmt->fourcc == fourcc)
+		return fourcc;
+
+	sibling = mxc_jpeg_get_sibling_format(q_data_cap->fmt);
+	if (sibling && sibling->fourcc == fourcc)
+		return sibling->fourcc;
+
+	return q_data_cap->fmt->fourcc;
+}
+
 static int mxc_jpeg_try_fmt(struct v4l2_format *f,
 			    struct mxc_jpeg_ctx *ctx, struct mxc_jpeg_q_data *q_data)
 {
@@ -1831,7 +1962,7 @@ static int mxc_jpeg_try_fmt(struct v4l2_format *f,
 
 	memset(pix_mp->reserved, 0, sizeof(pix_mp->reserved));
 	pix_mp->field = V4L2_FIELD_NONE;
-	pix_mp->num_planes = fmt->colplanes;
+	pix_mp->num_planes = fmt->mem_planes;
 	pix_mp->pixelformat = fmt->fourcc;
 
 	q_data->w = w;
@@ -1862,7 +1993,7 @@ static int mxc_jpeg_try_fmt(struct v4l2_format *f,
 		pfmt = &pix_mp->plane_fmt[i];
 		memset(pfmt->reserved, 0, sizeof(pfmt->reserved));
 		pfmt->bytesperline = q_data->bytesperline[i];
-		pfmt->sizeimage = q_data->sizeimage[i];
+		pfmt->sizeimage = mxc_jpeg_get_plane_size(q_data, i);
 	}
 
 	/* fix colorspace information to sRGB for both output & capture */
@@ -1902,6 +2033,9 @@ static int mxc_jpeg_try_fmt_vid_cap(struct file *file, void *priv,
 		return -EINVAL;
 	}
 
+	if (ctx->mxc_jpeg->mode != MXC_JPEG_DECODE && V4L2_TYPE_IS_CAPTURE(f->type))
+		f->fmt.pix_mp.pixelformat = mxc_jpeg_try_fourcc(ctx, f->fmt.pix_mp.pixelformat);
+
 	return mxc_jpeg_try_fmt(f, ctx, &tmp_q);
 }
 
@@ -1932,7 +2066,7 @@ static void mxc_jpeg_s_parsed_fmt(struct mxc_jpeg_ctx *ctx, struct v4l2_format *
 		return;
 
 	q_data_cap = mxc_jpeg_get_q_data(ctx, f->type);
-	pix_mp->pixelformat = q_data_cap->fmt->fourcc;
+	pix_mp->pixelformat = mxc_jpeg_try_fourcc(ctx, pix_mp->pixelformat);
 	pix_mp->width = q_data_cap->w;
 	pix_mp->height = q_data_cap->h;
 }
@@ -2029,10 +2163,10 @@ static int mxc_jpeg_g_fmt_vid(struct file *file, void *priv,
 	pix_mp->xfer_func = V4L2_XFER_FUNC_SRGB;
 	pix_mp->quantization = V4L2_QUANTIZATION_FULL_RANGE;
 
-	pix_mp->num_planes = q_data->fmt->colplanes;
+	pix_mp->num_planes = q_data->fmt->mem_planes;
 	for (i = 0; i < pix_mp->num_planes; i++) {
 		pix_mp->plane_fmt[i].bytesperline = q_data->bytesperline[i];
-		pix_mp->plane_fmt[i].sizeimage = q_data->sizeimage[i];
+		pix_mp->plane_fmt[i].sizeimage = mxc_jpeg_get_plane_size(q_data, i);
 	}
 
 	return 0;
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
index f75dfc89ff6d..660dcaca8658 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
@@ -45,7 +45,8 @@ enum mxc_jpeg_mode {
  * @subsampling: subsampling of jpeg components
  * @nc:		number of color components
  * @depth:	number of bits per pixel
- * @colplanes:	number of color planes (1 for packed formats)
+ * @mem_planes:	number of memory planes (1 for packed formats)
+ * @comp_planes:number of component planes, which includes the alpha plane (1 to 4).
  * @h_align:	horizontal alignment order (align to 2^h_align)
  * @v_align:	vertical alignment order (align to 2^v_align)
  * @flags:	flags describing format applicability
@@ -57,11 +58,13 @@ struct mxc_jpeg_fmt {
 	enum v4l2_jpeg_chroma_subsampling	subsampling;
 	int					nc;
 	int					depth;
-	int					colplanes;
+	int					mem_planes;
+	int					comp_planes;
 	int					h_align;
 	int					v_align;
 	u32					flags;
 	u8					precision;
+	u8					is_rgb;
 };
 
 struct mxc_jpeg_desc {
-- 
2.37.1

