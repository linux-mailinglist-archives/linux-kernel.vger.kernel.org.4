Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C16685F6A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 07:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjBAGEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 01:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjBAGDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 01:03:53 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2058.outbound.protection.outlook.com [40.107.6.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D555CD18;
        Tue, 31 Jan 2023 22:03:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wh8hpoVAEhqzX/j3AUhuNwrA1pqBajtMm3Mg0vpjmvsxwNlYv+ZE+bUQ67VyMwjQb4W8B2RF32/Q6SQZ5CluFFTYmVZN4XPaGqk6R82fFTyW38WCF+evVuf1/mrkF4/wv3GLHdhMlqOEcupMuZGDTbGLE91JXlWcuemBvIKvSbdJmW4DoQFeoaCYLvACatayWeiN/7STRoXruGexGg3sSVIKTOkvpnVOwXrjPDZiUpUnpdMLnUA7nk/3QPGiBQtwCevJioDjarjWxWd5F9LskqmFaxtvjVNM1ppjzSm0YK3+rXLQxqc3XGc6LX8n6PQfBawQdQ7Frs67CzJi9lLk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTXQrH5fMG756GCzr1yXe9rqr4+/N+rrRpiDTrCr+Xo=;
 b=A31XNGX/GtlD7sI97EYXoum7D7gjQwZ191lM6Ez4h5GQnTN0r8S8SuCoLKNlw2J73y9KlrfWrx8qMzhSEPS7KQKnTQSPYSEKydVUkWYis+JHLMTIJcCgv5dvDuUOyUPHWM3SOsfwfWFoXabinCfn5wSuMQrTZGeYFzFGu7gRIGRDjMi1UVhAa7SFkrd3IvqorAxJwJ9KWGZUl5wJBSKj05JzMAtT0mLgpNWYfIyro6vwU1RO4zcQ4mLEULaO/LY3hu6/0hHajxeqVvkENZTgQ78RPALLSpwxmcCShdeyqB43LoKTMjnztNdEcdLwltuwOiDFNcOfIcRZpTY8xWcvbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTXQrH5fMG756GCzr1yXe9rqr4+/N+rrRpiDTrCr+Xo=;
 b=OT4DsudzJnfmKMKs5HN3GXDjHuKbHH7z2P/Ffnqvme3KSTWIMnkjMZfYHhhNFZWtiI+sM7lkGu2K7blyibr4scpWfWMIUPdysdnY5hKWRYTA5yK+7tOnW11t9rqwU1QKHK7oSW+c9ME+jWHkBsBIhhtXYX5+LbpHZ8ohuyvGHMQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 06:03:37 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 06:03:37 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 05/10] media: Add BGR24_12 video format
Date:   Wed,  1 Feb 2023 14:02:27 +0800
Message-Id: <8c74b48e728ecb075a4a65b9771610c9cbe27294.1675230665.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1675230665.git.ming.qian@nxp.com>
References: <cover.1675230665.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|DB9PR04MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: e40a1b79-e735-423e-149f-08db041a0f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xnUZyjYW29Bd/WA+YAhXVuOm6lsJnVJ7yLjdItkcSTJpwhVd+qyxDqh6RGzTMv1jMAdXRpDqwLVvJ+deYUK65e7OxQkFv24llNGvyAh9MFvRDxPMR2kx3WMb0UTdHl+ybqAw01MIRmA1j/qxK1WQGD9R2FLDi+Wew4Q6UXspiGgdQyUZB3jiX2O6cBzeeRHEa+Ed3vOQvV6OgNgzp5iGcV5wVdBCQ9jBFirKWe+E/FOteK7fHdwgrrZGkJhFuG8pFGlviTiXKbPaykoECyHXRgILBBjmK5DOcQb5uccz73hDehJOFyziI71e5Fuly6KGMBcSFuA2P+vg8oK5/AUQ+LBMP6IjSjgL3FocEuhFjOgyH2gYhKryrF12BKAVhEBhqVwVkRYr5V/C3YXx5Pb3pPtVfpnV+VCQvSRHdwQ8jqrZT8TM8uyj5oDgCceRQBr0swfTdccbO7bWgu9hxtKbB+1L7+Hgg1zwNRRdTYxGBurJnoydz0LLNwUls8fxTxpGiQ6RT2zeymRxPNlA+VhZ2bsF4yHbSyTxHs0sMvWfnziPPJgL4PsJJxt+LaBohSULwjW9W87V13GTb6/YEeZKGDNqEACQNjYPmT/9Q+7nTluSQ8D2l+owuixsXD+BOrJOAB2Pka1+CL9jmlYR9uDt+QVUOI7nzBVSuIUtNfS4JBaTj2J97d6eQwZvZLTWoAZt/vY7I/RSb35i58kFrimHIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199018)(38100700002)(52116002)(2616005)(38350700002)(36756003)(7416002)(8936002)(86362001)(5660300002)(44832011)(316002)(41300700001)(2906002)(83380400001)(6506007)(6512007)(8676002)(4326008)(186003)(26005)(478600001)(66476007)(66556008)(6666004)(6486002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iILzlGBrpzbFqwyW3lXUpAZuWrUepksAy6ikdoHT2iR4H/J0A979gpoOCjsp?=
 =?us-ascii?Q?tDEFqQ66pxBUnVlNgWp5zRb4L3UBNAhAhSfnBprAAygDFFOJJDkUUJ7grajD?=
 =?us-ascii?Q?WNFEbOlOc6bfKIr3Zm5OB6S2FygsCL4aq9+BTlfPX8ev5ZOnHRacam3azKJP?=
 =?us-ascii?Q?wDjx8RGJY1j66lt/Pc8YOASrcydeTsSrAgMioPw1xaKf3UPP7llVUNwD4OVi?=
 =?us-ascii?Q?ZXe3JJ/ilWdzqVwfLrOU/hZPwgDhA/t9W//5WZvvkSZfA3w8f7uVZbUxuwam?=
 =?us-ascii?Q?9NiD4+E01yngC5yjq9jRsj6Aa/gc/+b2OGVVRsInHCdp2+pB4UEXq3YMst38?=
 =?us-ascii?Q?e+8BXBEpAByvKXszOc4BoT2udYArKAMQbd+pUSgQ5cOVKnT3y5lbvFPTgy6j?=
 =?us-ascii?Q?OGpKkuwMYvNCueWRVh/838rfQZ3nolooMY7TfPyTy6IIEuy7aJroqEf96h3r?=
 =?us-ascii?Q?ymVhsytcDiBWs9tD06fHdp11NahcU4gUU/u+NPbxM9XLGH/H8jW6FcvDY0rB?=
 =?us-ascii?Q?ZwuaCiDKfnnHMMxZL1gHX7f0nfPLl5RUJu1qJi+oVf+sko0RGUAOIoCNXg5Y?=
 =?us-ascii?Q?YNqty8bk8cse4ui2WWOXMS033jLI1z5xFzThVhS2c8e265Ny5Mntj54SfCZB?=
 =?us-ascii?Q?7XVNtbpmEf8JIpE23s2G5csfzabubI5jOMpZl2waROKVJxCgwGlH2wIJ/H8d?=
 =?us-ascii?Q?X7h+H4Wb+U2awi8EsmtaZWhYYDDysQWSu99wHaj+cz/NKLRRYyI3AeLwB8yD?=
 =?us-ascii?Q?hjm2Hf11Edyac0kaKpWmSDHXi+XI6CkHZl1lzjVW0rQxgErH9327hB60OXUn?=
 =?us-ascii?Q?7+RdBKyPxOjJNHtKK24hk8hjCHkKBmWGb3tYN4GRHHDoa2/JBp2P16LRzMuv?=
 =?us-ascii?Q?kNpFtRmJ6EPKVLGO7S3x9Gzu0R5tmHpWnpbs1ffQLXTTGjrR1xhnkd++b9wH?=
 =?us-ascii?Q?xAs8dtzS7JOWvUz/gy51faUb4guIzs29y48/zxW6rBRpvFAlUFETKxOErXec?=
 =?us-ascii?Q?CTzQSkdHhZil7syJ83PKMrsX3vGchsSufPBSyfoDY1nlGXVjRFWHsRrtVhgR?=
 =?us-ascii?Q?KT1KtQ/n82lbM9JtpaQ1Jk55YgFERIN51KgX+RYKaOPOiEOd6sXG+P3lCJQx?=
 =?us-ascii?Q?5kYYuLQU+U1Tj51gSawA7AnYumtS5D1rQRSXCe/wGY18tLfmukt9m4sycT6a?=
 =?us-ascii?Q?3waCojt7ZOraUWAOXAqE1WpGzWP4wxsIAilfU4lGFqKdzS0GWDRFKTzFSUAE?=
 =?us-ascii?Q?al0HW6RaspInn1n175EMA/8/0VImQCAeZE9WumFg0vJaBkw+Ip+OvEC+lOJ8?=
 =?us-ascii?Q?ZV+M5/xanDtQqTGO5B6gTnk2bwohWbH/jz/ig3WS7+3H5DYYGLqhfC6GlarN?=
 =?us-ascii?Q?WPR2A5siwjkL0Cy8cdjCIB97YpiNg2VTg5/vNT5aMyEUt4vqwo3e3tVhJ1W0?=
 =?us-ascii?Q?8d9SQtYZN4xteQrRVgEV+erjIgH26VdprvwrBMuzziUO/CKQeM1w5+ErjmIw?=
 =?us-ascii?Q?qYau4J6g0vJST4vWlRqVT52oMFA/fMDDI5z2eJJYW3U3oU2WRefzeWxV5wNS?=
 =?us-ascii?Q?d7y2TCEdzAi9msViRZc/eyYJ32BQTAJiTzNB72xs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40a1b79-e735-423e-149f-08db041a0f34
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 06:03:37.5351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDrURza3sK9J4/Vcs0+gb/edtouuqNIUOmKxdpAKfUm1pciMY7manP679DecE6mq59gJRlmwgSFN2itAWjwgVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BGR24_12 is a reversed RGB format with 12 bits per component like BGR24,
expanded to 16bits.
Data in the 12 high bits, zeros in the 4 low bits,
arranged in little endian order.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../userspace-api/media/v4l/pixfmt-rgb.rst    | 35 +++++++++++++++++++
 drivers/media/v4l2-core/v4l2-common.c         |  1 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
 include/uapi/linux/videodev2.h                |  3 ++
 4 files changed, 40 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst b/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
index 30f51cd33f99..da29ba69c2d9 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
@@ -763,6 +763,41 @@ nomenclature that instead use the order of components as seen in a 24- or
     \normalsize
 
 
+More Than 8 Bits Per Component
+==============================
+
+These formats store an RGB triplet in six or eighth bytes, with more than 8 bits per component.
+expand the bits per component to 16 bits, data in the high bits, zeros in the low bits,
+arranged in little endian order.
+
+.. raw:: latex
+
+    \small
+
+.. flat-table:: RGB Formats With More Than 8 Bits Per Component
+    :header-rows:  1
+    :stub-columns: 0
+
+    * - Identifier
+      - Code
+      - Byte 1-0
+      - Byte 3-2
+      - Byte 5-4
+      - Byte 7-6
+    * .. _V4L2-PIX-FMT-BGR24-12:
+
+      - ``V4L2_PIX_FMT_BGR24_12``
+      - 'B312'
+
+      - B\ :sub:`15-4`
+      - G\ :sub:`15-4`
+      - R\ :sub:`15-4`
+      -
+
+.. raw:: latex
+
+    \normalsize
+
 Deprecated RGB Formats
 ======================
 
diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index b3ad02f8cf11..024190f82cf1 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -252,6 +252,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_RGB565,  .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_RGB555,  .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_BGR666,  .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_BGR24_12, .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 6, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 
 		/* YUV packed formats */
 		{ .format = V4L2_PIX_FMT_YUYV,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 711d1b0a8184..329515786abb 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1298,6 +1298,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_BGRX32:	descr = "32-bit XBGR 8-8-8-8"; break;
 	case V4L2_PIX_FMT_RGBA32:	descr = "32-bit RGBA 8-8-8-8"; break;
 	case V4L2_PIX_FMT_RGBX32:	descr = "32-bit RGBX 8-8-8-8"; break;
+	case V4L2_PIX_FMT_BGR24_12:	descr = "12-bit Depth BGR"; break;
 	case V4L2_PIX_FMT_GREY:		descr = "8-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y4:		descr = "4-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y6:		descr = "6-bit Greyscale"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 3eb188581b83..ab52a605e6c0 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -577,6 +577,9 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_ARGB32  v4l2_fourcc('B', 'A', '2', '4') /* 32  ARGB-8-8-8-8  */
 #define V4L2_PIX_FMT_XRGB32  v4l2_fourcc('B', 'X', '2', '4') /* 32  XRGB-8-8-8-8  */
 
+/* RGB formats (6 or 8 bytes per pixel) */
+#define V4L2_PIX_FMT_BGR24_12    v4l2_fourcc('B', '3', '1', '2') /* 48  BGR 12-bit per component */
+
 /* Grey formats */
 #define V4L2_PIX_FMT_GREY    v4l2_fourcc('G', 'R', 'E', 'Y') /*  8  Greyscale     */
 #define V4L2_PIX_FMT_Y4      v4l2_fourcc('Y', '0', '4', ' ') /*  4  Greyscale     */
-- 
2.38.1

