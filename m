Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03164696054
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjBNKIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjBNKH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:07:59 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2045.outbound.protection.outlook.com [40.107.105.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2874FE3B3;
        Tue, 14 Feb 2023 02:07:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqOlLKL/8FM6Ct5Q1N4uHsIkYOKW7So2SIautrMlQMyKvNnqCuzotpfQwKWqMDaz7gu0yrD2EtI+W/CEcV9fbLNOV/PMnuvJoeeQe5BKMI0iW/+n59UvpiDO6DibsgtRrup94zrZOWOr0hdF4G+qyWsYwiECkk/HG+P2XZnw6W3j/aPT0r/BTFGI1Sp84+WxPZF9Nh+14ZO5lkTAGHZankjXx2OOdeDzP3H8w0Ll8e6GIU3wazkMByYFIfp3MIj6E75yYnodF9YE03ZuorE/G9/R7IuJ3GTD1UG+m1TC/J9GIc6UOYrIGNT8jOgNYDZx+emU0eK02i1ITujSwQ20dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96gy3aHr7cpkDLTeFd2DQlBvTgiWWIT2l1W6YnPOVSM=;
 b=DB6ZRmCv8pe3Cu8SCoqclraaeSxikm5nXiVtOaem4WGqDReTlpZSxzSuk8w6FcgAtC7BxDOiMVFI5tF15t2iSpOFfRgxAUUFuTslk8hAWkBTjxgQFsWe7PVk1XvuHGq2D4raUD82Q1abZv/vXZRlTSA0+Prl8JaOTfFX96rI6i/MLkjXFfgG8rRxrti94iyY+GHKXJ60o1BadRbC9+Z4RxHNlRWYmXtQQmScWxf2l6ZPiByRL3jPIQ20Tq9/8LQ8C9l4uyzanYrC1btjBFb7ntP3iWp/WEAG2DYH0UerHxaqa3WyYipJXqY4XwGBdBpyPD6KJip3QhwtxzNJFqvFMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96gy3aHr7cpkDLTeFd2DQlBvTgiWWIT2l1W6YnPOVSM=;
 b=kW0nchOzGO02Dbv0uwhbKv5PRhAEkuSGOdahW0EWmm9Sq5u+5aHr84z3SUpu60HmjuEjMUXqwe0gcdjF7gA+/ohvMVqjsnnpkzzlM+L6vWAl+p60zFRxiBZfz3Vv7sLu1UzN4ZVv+sGUKANpCgzFX6BfAaQSTJu/83QY7y+92P4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB6800.eurprd04.prod.outlook.com (2603:10a6:803:133::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Tue, 14 Feb
 2023 10:06:19 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6086.023; Tue, 14 Feb 2023
 10:06:19 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 09/10] media: imx-jpeg: Decoder add support for 12bit jpeg
Date:   Tue, 14 Feb 2023 18:04:51 +0800
Message-Id: <9e72cab82f407f4d039d7979ff8995b768bffc69.1676368610.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f7a6bfe6-d2e1-4d2e-4c68-08db0e731e37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eDD///rl5tbSOnFzdmFn3ALxWTfCEpH920qKFUnFEd3d3rGBUNn1Nadr+48Dhudqax8sXOhCZAmjmYNn89vSAb5Iou6SuN3kJNHHvkvQ/ERZq0eMVkiMX2CdBFAJ9PB9xQ2qt3tl2U4ADldutWXo6ojXfieUjY3PBZ8nCcXibtU5qQ9KVU+m/4FJx0r+8fmlPvMXGN4aA8pggTmeIaGw4zRahW4c6lHwk6ZxI0wcDSJn2fm9dOkkRJWt0W7ttL4KsJh8Kk510SXQhTZdcbMFbITQZkyxqscIYsY9Q+8goJnw5miQcLNsw4srtFJSA5w5uJU3Cqv/Iuevy89Ecx3Hf53Dr17UU7u0lZzlNi9alrmDYGeeVR+MIis4k4pBFyZpltfqzHXLyM31xbk8JkkSimgAyZDzB8SlsL7MyI8OhpexYZZEGXHwOUZvmLpeqALKcK7XFezdaYiQ3UOel44zOYKirc2SSZJ+pFE7UDHb14Wo7Ug1pj/LT3IrQ1OCKGhKDVh96L2xxciW0GaZSmdhVKOjUiyFimW4WBD7V9yLDhSXpr9I0L+L8Tlzb55vqkTEchossaotIMkSxRIu2yQs2KdTZlDe7j5wUy/PLuDyxQULYGevu48lZ7psofDVRCyi7n59tVohS5QZzjJGJJzPBHYvhNfd/Hp0tUb/smOn9jEAGdSWxgNZdAZstEFWTMAlXRwTfo7bFZLDGR5ocOJBuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199018)(6506007)(52116002)(83380400001)(6486002)(2906002)(36756003)(26005)(186003)(38100700002)(66556008)(8676002)(66476007)(66946007)(8936002)(6666004)(6512007)(38350700002)(2616005)(4326008)(44832011)(478600001)(316002)(86362001)(5660300002)(7416002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/csrpP96t4+hdB/i2Ima5XV8AeLVwqtJmn/SPMP8ERwSBW5sTdiir5K0cd90?=
 =?us-ascii?Q?KvnyOEg1ookiY2tTLDeiH6vo7gs5o1XwkmMPIUL3GbdvanWHjA5WAFPE0mSd?=
 =?us-ascii?Q?iPIxkz2DyUZsT/Z26eIyV7Mh/nOZBsYE8XnOGGl5X9K/nSomMhfBgqjLwumN?=
 =?us-ascii?Q?Bh1KCgbytdUnyWOF18EFbpXsOGhzIdG+OJKhgEzrzguJxDyzxXHAK/lG9AcI?=
 =?us-ascii?Q?eOCSBKA10iugnpd8CWnUhu8Dq+GKgIRqvysRO2Usp8NEXCAheRGJ5oU48HC3?=
 =?us-ascii?Q?P/4LpzNtx29DjpqobcLqr3LyO69ncxzQ2CwoyaRd/zUL9QbReyQPRPs6qmH6?=
 =?us-ascii?Q?IOm11MG3VQccpWneyjic0s19DtHtASgZL3kU42kqmBPF70eCxtZ4c3e70Hfo?=
 =?us-ascii?Q?VOe9BzMTp0PvaE/XBFbAHGrpWwEHXq1t+7foB/4Y3xt1XjEfFDYqU1rEo91k?=
 =?us-ascii?Q?Xo00MadV/FiIStgrYlzNBlm76s6fcGuVO1HS8f+MU2ZT9Nj3rt28VdrsCzqm?=
 =?us-ascii?Q?Ca3yrMLNm9VZ96BzGPOW4kFmkPKkL0WoI425iIYYwdXrpRB9ExEb5ElnNY79?=
 =?us-ascii?Q?PEnB+xssCJsfQr1PVS4I7v72dc68D7UMAdHi4L9aHPupDiyKh4hQOi+tjjco?=
 =?us-ascii?Q?p+18coKnhR4Tbmv1yKtAgbJsolU0R8zvIdQjWksFndHmEmal5gI14cVz3d4d?=
 =?us-ascii?Q?8/byfw6MnCwu6VSZy0SjMvnT39T5SxeiUeGhi/NL24tD6XeRrhIA4XrTvsRH?=
 =?us-ascii?Q?n4+2nQ97mp+XN8tzPMIsOecUXU6dSUXTqATUdO3rTbRw7nEjIU30havhpD+z?=
 =?us-ascii?Q?wW4Z0eP0QSfTY+xX5vL9l3xYVII2kX2els3AWX0ahU+K0enZiP3RlSk3xMlg?=
 =?us-ascii?Q?S4o6pDcgHjcMptNdSKFPBghwhzdyXFb9B2N1hjBNdhQbXxJ3T32TOGSdpOYz?=
 =?us-ascii?Q?ks6CSivrxF4GGeq2sXBuDktsRNrTK6Ocy7glw37SG8VEXRUAIMh4w82iyqVM?=
 =?us-ascii?Q?Yz1sLYaRTwRaiGyI9RhQzmvcpA6TslvVc2w7jTy2dfUpFwAi8czOcc7OqEV+?=
 =?us-ascii?Q?8603pMZirb4jB1wIxihjxFnwEdhJZLLvnNhweGd39f8FDAEad0tv9q3SVOh/?=
 =?us-ascii?Q?fRvLoOcjjeuoL+ZEiOoDrI4eVtI0At/H1+QGE7yP66STUPk8YNTkOkWWgkq9?=
 =?us-ascii?Q?xXkt6rbn9OXD4KenPCuYI0p+/0lHiUue8OTkFxw9w+StCKWHcacDQ9se4k/p?=
 =?us-ascii?Q?Kovy23vKrqO3Ng61w9FzivO00u6SeKnAfY/Ah/lMFIIQdzWqTFZ6NBzuTnf0?=
 =?us-ascii?Q?Uci+ARJH2RwJ912uzxiJJvFJb2ZcDF7/OaVGIDmCa6n9+q7HLSrXTEYjzBAW?=
 =?us-ascii?Q?5VG0dayrhZQHlYD1SXM2T5zoiwGZiCzZLy8JLjfy3Q1uBz4OoVj6LFc8FjMz?=
 =?us-ascii?Q?0vv5BVQfzGSTIaJ+ZpJGo6yLlwVkTNyBm1gCzNo2Ysd1wVObMpgbbwnehYeS?=
 =?us-ascii?Q?qECSFcuvFZUAARsXHGxeVAwJp7nuF3rOWS6KZVribgD9bBb3gKNsfmq3e5BC?=
 =?us-ascii?Q?eo88VI2Dybp7bewmLHWuWRFs4GnsnBWujvf8zu89?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a6bfe6-d2e1-4d2e-4c68-08db0e731e37
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 10:06:19.6837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcVHPjymZfMRFoAAkllz+827u61sbGu5BcdcMdkms7258a7+7HMcNqjcBW5VHeNGKTZ8vyEF9uod3vy4hTzqsg==
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

enable decoding 12-bit extended jpeg

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 136 +++++++++++++++++-
 1 file changed, 134 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 3f1c9bc4b144..7743655ab12f 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -87,6 +87,20 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.precision	= 8,
 		.is_rgb		= 1,
 	},
+	{
+		.name		= "BGR 12bit", /*12-bit BGR packed format*/
+		.fourcc		= V4L2_PIX_FMT_BGR48_12,
+		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_444,
+		.nc		= 3,
+		.depth		= 36,
+		.mem_planes	= 1,
+		.comp_planes	= 1,
+		.h_align	= 3,
+		.v_align	= 3,
+		.flags		= MXC_JPEG_FMT_TYPE_RAW,
+		.precision	= 12,
+		.is_rgb		= 1,
+	},
 	{
 		.name		= "ABGR", /* ABGR packed format */
 		.fourcc		= V4L2_PIX_FMT_ABGR32,
@@ -101,6 +115,20 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.precision	= 8,
 		.is_rgb		= 1,
 	},
+	{
+		.name		= "ABGR 12bit", /* 12-bit ABGR packed format */
+		.fourcc		= V4L2_PIX_FMT_ABGR64_12,
+		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_444,
+		.nc		= 4,
+		.depth		= 48,
+		.mem_planes	= 1,
+		.comp_planes	= 1,
+		.h_align	= 3,
+		.v_align	= 3,
+		.flags		= MXC_JPEG_FMT_TYPE_RAW,
+		.precision	= 12,
+		.is_rgb		= 1,
+	},
 	{
 		.name		= "YUV420", /* 1st plane = Y, 2nd plane = UV */
 		.fourcc		= V4L2_PIX_FMT_NV12M,
@@ -127,6 +155,32 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.flags		= MXC_JPEG_FMT_TYPE_RAW,
 		.precision	= 8,
 	},
+	{
+		.name		= "YUV420 12bit", /* 1st plane = Y, 2nd plane = UV */
+		.fourcc		= V4L2_PIX_FMT_P012M,
+		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_420,
+		.nc		= 3,
+		.depth		= 18, /* 6 x 12 bits (4Y + UV) for 4 pixels */
+		.mem_planes	= 2,
+		.comp_planes	= 2, /* 1 plane Y, 1 plane UV interleaved */
+		.h_align	= 4,
+		.v_align	= 4,
+		.flags		= MXC_JPEG_FMT_TYPE_RAW,
+		.precision	= 12,
+	},
+	{
+		.name		= "YUV420 12bit", /* 1st plane = Y, 2nd plane = UV */
+		.fourcc		= V4L2_PIX_FMT_P012,
+		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_420,
+		.nc		= 3,
+		.depth		= 18, /* 6 x 12 bits (4Y + UV) for 4 pixels */
+		.mem_planes	= 1,
+		.comp_planes	= 2, /* 1 plane Y, 1 plane UV interleaved */
+		.h_align	= 4,
+		.v_align	= 4,
+		.flags		= MXC_JPEG_FMT_TYPE_RAW,
+		.precision	= 12,
+	},
 	{
 		.name		= "YUV422", /* YUYV */
 		.fourcc		= V4L2_PIX_FMT_YUYV,
@@ -140,6 +194,19 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.flags		= MXC_JPEG_FMT_TYPE_RAW,
 		.precision	= 8,
 	},
+	{
+		.name		= "YUV422 12bit", /* YUYV */
+		.fourcc		= V4L2_PIX_FMT_YUYV64_12,
+		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_422,
+		.nc		= 3,
+		.depth		= 24,
+		.mem_planes	= 1,
+		.comp_planes	= 1,
+		.h_align	= 4,
+		.v_align	= 3,
+		.flags		= MXC_JPEG_FMT_TYPE_RAW,
+		.precision	= 12,
+	},
 	{
 		.name		= "YUV444", /* YUVYUV */
 		.fourcc		= V4L2_PIX_FMT_YUV24,
@@ -153,6 +220,19 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.flags		= MXC_JPEG_FMT_TYPE_RAW,
 		.precision	= 8,
 	},
+	{
+		.name		= "YUV444 12bit", /* YUVYUV */
+		.fourcc		= V4L2_PIX_FMT_YUV48_12,
+		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_444,
+		.nc		= 3,
+		.depth		= 36,
+		.mem_planes	= 1,
+		.comp_planes	= 1,
+		.h_align	= 3,
+		.v_align	= 3,
+		.flags		= MXC_JPEG_FMT_TYPE_RAW,
+		.precision	= 12,
+	},
 	{
 		.name		= "Gray", /* Gray (Y8/Y12) or Single Comp */
 		.fourcc		= V4L2_PIX_FMT_GREY,
@@ -166,6 +246,19 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.flags		= MXC_JPEG_FMT_TYPE_RAW,
 		.precision	= 8,
 	},
+	{
+		.name		= "Gray 12bit", /* Gray (Y8/Y12) or Single Comp */
+		.fourcc		= V4L2_PIX_FMT_Y012,
+		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_GRAY,
+		.nc		= 1,
+		.depth		= 12,
+		.mem_planes	= 1,
+		.comp_planes	= 1,
+		.h_align	= 3,
+		.v_align	= 3,
+		.flags		= MXC_JPEG_FMT_TYPE_RAW,
+		.precision	= 12,
+	},
 };
 
 #define MXC_JPEG_NUM_FORMATS ARRAY_SIZE(mxc_formats)
@@ -437,17 +530,24 @@ static enum mxc_jpeg_image_format mxc_jpeg_fourcc_to_imgfmt(u32 fourcc)
 {
 	switch (fourcc) {
 	case V4L2_PIX_FMT_GREY:
+	case V4L2_PIX_FMT_Y012:
 		return MXC_JPEG_GRAY;
 	case V4L2_PIX_FMT_YUYV:
+	case V4L2_PIX_FMT_YUYV64_12:
 		return MXC_JPEG_YUV422;
 	case V4L2_PIX_FMT_NV12:
 	case V4L2_PIX_FMT_NV12M:
+	case V4L2_PIX_FMT_P012:
+	case V4L2_PIX_FMT_P012M:
 		return MXC_JPEG_YUV420;
 	case V4L2_PIX_FMT_YUV24:
+	case V4L2_PIX_FMT_YUV48_12:
 		return MXC_JPEG_YUV444;
 	case V4L2_PIX_FMT_BGR24:
+	case V4L2_PIX_FMT_BGR48_12:
 		return MXC_JPEG_BGR;
 	case V4L2_PIX_FMT_ABGR32:
+	case V4L2_PIX_FMT_ABGR64_12:
 		return MXC_JPEG_ABGR;
 	default:
 		return MXC_JPEG_INVALID;
@@ -483,6 +583,17 @@ static void mxc_jpeg_addrs(struct mxc_jpeg_desc *desc,
 		offset;
 }
 
+static bool mxc_jpeg_is_extended_sequential(const struct mxc_jpeg_fmt *fmt)
+{
+	if (!fmt || !(fmt->flags & MXC_JPEG_FMT_TYPE_RAW))
+		return false;
+
+	if (fmt->precision > 8)
+		return true;
+
+	return false;
+}
+
 static void notify_eos(struct mxc_jpeg_ctx *ctx)
 {
 	const struct v4l2_event ev = {
@@ -767,24 +878,31 @@ static int mxc_jpeg_fixup_sof(struct mxc_jpeg_sof *sof,
 	switch (fourcc) {
 	case V4L2_PIX_FMT_NV12:
 	case V4L2_PIX_FMT_NV12M:
+	case V4L2_PIX_FMT_P012:
+	case V4L2_PIX_FMT_P012M:
 		sof->components_no = 3;
 		sof->comp[0].v = 0x2;
 		sof->comp[0].h = 0x2;
 		break;
 	case V4L2_PIX_FMT_YUYV:
+	case V4L2_PIX_FMT_YUYV64_12:
 		sof->components_no = 3;
 		sof->comp[0].v = 0x1;
 		sof->comp[0].h = 0x2;
 		break;
 	case V4L2_PIX_FMT_YUV24:
+	case V4L2_PIX_FMT_YUV48_12:
 	case V4L2_PIX_FMT_BGR24:
+	case V4L2_PIX_FMT_BGR48_12:
 	default:
 		sof->components_no = 3;
 		break;
 	case V4L2_PIX_FMT_ABGR32:
+	case V4L2_PIX_FMT_ABGR64_12:
 		sof->components_no = 4;
 		break;
 	case V4L2_PIX_FMT_GREY:
+	case V4L2_PIX_FMT_Y012:
 		sof->components_no = 1;
 		break;
 	}
@@ -804,20 +922,27 @@ static int mxc_jpeg_fixup_sos(struct mxc_jpeg_sos *sos,
 	switch (fourcc) {
 	case V4L2_PIX_FMT_NV12:
 	case V4L2_PIX_FMT_NV12M:
+	case V4L2_PIX_FMT_P012:
+	case V4L2_PIX_FMT_P012M:
 		sos->components_no = 3;
 		break;
 	case V4L2_PIX_FMT_YUYV:
+	case V4L2_PIX_FMT_YUYV64_12:
 		sos->components_no = 3;
 		break;
 	case V4L2_PIX_FMT_YUV24:
+	case V4L2_PIX_FMT_YUV48_12:
 	case V4L2_PIX_FMT_BGR24:
+	case V4L2_PIX_FMT_BGR48_12:
 	default:
 		sos->components_no = 3;
 		break;
 	case V4L2_PIX_FMT_ABGR32:
+	case V4L2_PIX_FMT_ABGR64_12:
 		sos->components_no = 4;
 		break;
 	case V4L2_PIX_FMT_GREY:
+	case V4L2_PIX_FMT_Y012:
 		sos->components_no = 1;
 		break;
 	}
@@ -847,12 +972,15 @@ static unsigned int mxc_jpeg_setup_cfg_stream(void *cfg_stream_vaddr,
 	u8 *cfg = (u8 *)cfg_stream_vaddr;
 	struct mxc_jpeg_sof *sof;
 	struct mxc_jpeg_sos *sos;
+	const struct mxc_jpeg_fmt *fmt = mxc_jpeg_find_format(fourcc);
+
+	if (!fmt)
+		return 0;
 
 	memcpy(cfg + offset, jpeg_soi, ARRAY_SIZE(jpeg_soi));
 	offset += ARRAY_SIZE(jpeg_soi);
 
-	if (fourcc == V4L2_PIX_FMT_BGR24 ||
-	    fourcc == V4L2_PIX_FMT_ABGR32) {
+	if (fmt->is_rgb) {
 		memcpy(cfg + offset, jpeg_app14, sizeof(jpeg_app14));
 		offset += sizeof(jpeg_app14);
 	} else {
@@ -918,6 +1046,10 @@ static void mxc_jpeg_config_dec_desc(struct vb2_buffer *out_buf,
 	desc->stm_ctrl &= ~STM_CTRL_IMAGE_FORMAT(0xF); /* clear image format */
 	desc->stm_ctrl |= STM_CTRL_IMAGE_FORMAT(img_fmt);
 	desc->stm_ctrl |= STM_CTRL_BITBUF_PTR_CLR(1);
+	if (mxc_jpeg_is_extended_sequential(jpeg_src_buf->fmt))
+		desc->stm_ctrl |= STM_CTRL_PIXEL_PRECISION;
+	else
+		desc->stm_ctrl &= ~STM_CTRL_PIXEL_PRECISION;
 	desc->line_pitch = q_data_cap->bytesperline[0];
 	mxc_jpeg_addrs(desc, dst_buf, src_buf, 0);
 	mxc_jpeg_set_bufsize(desc, ALIGN(vb2_plane_size(src_buf, 0), 1024));
-- 
2.38.1

