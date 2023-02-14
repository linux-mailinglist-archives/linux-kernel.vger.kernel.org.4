Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F7B696048
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjBNKGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjBNKGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:06:21 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2045.outbound.protection.outlook.com [40.107.105.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F551420E;
        Tue, 14 Feb 2023 02:06:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVd/zomG3uQ/5qBkxZlctYUjDCPsJ4SA3/jCDdV9+s+HWZKVep8qJ9bgT4O3qKsrVl4eL8Ekld305mYuvX4c0ITfJ3o4dc3QIZfJYETwyxFPSHexkh1RUp+loX2B3Ixvm6XkQbMhHmkcz2jm+HQjZ9y2S/jmaIqndZGrHTDWk/kqySGi8nwYRm7xjfHc/cecMthzvdwY2+kMxX/A9odGwnf9rDeNmPB3+r30cn8BOHUNCh+41D5b2G0S/oeACjpvYnBA+sl2fflbutpOdK1J1REemjlFmVDKTkJMG7Wx8N90hMKJ5x9TvtWior4gkZL3PPWqRGPtebC71C69RtohHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0OdUp9s+dStWlUALHKkK7Av/wXlOt0a8Jr6xwhaD74=;
 b=V11vZsxPTxHnIWUI7ipi+cboq4L5/k/2TdUML2X5NAlg4pF8qyk7N2ANy0AzmGR+w3/BFwq0S7yePjF2hG81dUFc+K1+wwaDmxOny7WE2ly7AMo5VbgG6obA8ds4qXTOcfgVTnzM9B4FU80k57jM4P8SMOqxHrOrI/x3MKvhQziUDljb3rGgHeaVWHCMABb5ABrvlmV+3/yCOuwV1ceeuBmdawtQPZWyqzx5cm4Hc6Xamy+pcB+Z01lFX3BgOgyrxV+Zbld7+jYX4KiIQDbn5VLn/UYkoeVx8wsPqf5sRWS21Jp0jMW3MDnfCoYDiszrapuMkMK/udFwaFoDvyRQ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0OdUp9s+dStWlUALHKkK7Av/wXlOt0a8Jr6xwhaD74=;
 b=XgTUlvnIaFB97FL6wi1W31eU3ogBpD37cINnxUDbGFKs0T8dWv7A2BU6giHINRKEPg+96DoUd8hNuqGs23FAcykmGkQIFw/wLEh5X2Nsn53CVX5x8U+lxW3oTnX1CmOHZ8aiC3Y+E5imTV/nO/SG3o7ypYj6QRXe6yEK4L9nUyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB6800.eurprd04.prod.outlook.com (2603:10a6:803:133::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Tue, 14 Feb
 2023 10:06:03 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6086.023; Tue, 14 Feb 2023
 10:06:03 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 05/10] media: Add BGR48_12 video format
Date:   Tue, 14 Feb 2023 18:04:47 +0800
Message-Id: <7bc59312f70c7c293dbaac156b3c6e2ac9095ade.1676368610.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 10cd5b71-79e6-4f20-2df1-08db0e7314b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JSaQXS0gquDiXB2iOV9DNk/hjuZz7iNhD419jxiDX6b14i3giXmoYhy0dJfttwBo2BNsLSYN+4dxXcKDKcY9YsQwSd5nIJpEEP+y4nuMI+BOTjN1R1I2nHS1rbM1I8nRQmRhM3VqLrd62hbEbLxr94fOnpTG3knYU2ApuPSbPsXa/plitCT6LDBYNz4oqdf85AHlIDJruElRzhJClPVAkz+0ee5pOYNSJOL4gdhogx4GV5UU9w67rWfeanzgsf3/hVcgP9KvRcr1KIngXgF2JyiF5ft7ftqIBjpg6dtBgLSPqM2GbM2oqgHg4laSG238twS6xi2+NU4ysoyF+a3JS+wqah9B4c3IdSrSTjjZommHcGpS0MzoG/WF8Nd/zCEhTbTQJjjWhAI0r5+T3JaAtU/sDtw5BdyHU3n7pCcI+al91k7AfsgN+Z3XblgopQA+9wPFxzydSoofVYW/x9liQcZtROHsVPOtfYFnzzZHPTBNCl69DpQUoKCPdZr2pCwr7+X0GEVfwuCDvEzsVAJsLUzWW7RQN+LIguw94McXrc4tfQdsHLn1NBB5snV0WPR42Ff2BCsLPLpNbUe46AP3SI7ZlBuhjeHGdxoD0HJStXT9NTEhreByNNMOyOAsAmmzcp2AXh3k5kM/eDHFLprZsF1KRyor9mgnmJExRrup1OvoJWN0MXTCYH9eUpVeRqRO75Jpb51ejYfWJFjA6CF++A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199018)(6506007)(52116002)(83380400001)(6486002)(2906002)(36756003)(26005)(186003)(38100700002)(66556008)(8676002)(66476007)(66946007)(8936002)(6666004)(6512007)(38350700002)(2616005)(4326008)(44832011)(478600001)(316002)(86362001)(5660300002)(7416002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wuVxkVsnAcTrMw29Y72s8z88lxrTrGqL/VeE8B2GSzJhngBkC52QNAFRPYN4?=
 =?us-ascii?Q?4X/ZOOCBu69r4cITkfkys+QWqF5qWi+YrEUDEkpm/sh9Wi8IbMbbJ/IRf1FB?=
 =?us-ascii?Q?Xw6oKTXxlRpKmWQ3CGBONSTWlv5s7t9FUI9aFJMC5q28l3qOQ2L0iE8umTql?=
 =?us-ascii?Q?uICOy+y4Aw77QurFJmLZiDhRUH3RyvY+/GFGqJrWZPDt1XKOF4hxhyWL1H3Q?=
 =?us-ascii?Q?n/STHcAnZfs6BD0Lr6apN4bAn0JEjB6beKcPvZ9tqIIx3gLO+jmsmxU2HKhW?=
 =?us-ascii?Q?Z1CEJJeoS0zOUqMLK6oxlHdJ6xZ0j6kiQEQ2rrbmIBUoJgsd+7Aw2Gp09BXe?=
 =?us-ascii?Q?3uC2Cjda8FoC2Cwet5dUsLAgsabPx3MECIO2p792GshH5vs4rxoPx9PC2qG/?=
 =?us-ascii?Q?08+GQ1hWdUx0tLFWa6V+yxQ21Q8LTOTDJyt6GnvqyLww/Xzg94zVPM9Mf6Ea?=
 =?us-ascii?Q?HfqPYgfyDmUaxIRfxIL7mPd3lRfxjpFiIXD+pZXEdPTay75ad9ZBJDuIotuY?=
 =?us-ascii?Q?S+Kbv0Mu0Iq49JLMO3euuUpSkGbkABVyN0fBrfj1H9Hfoc0H0kiUDnZzmR+W?=
 =?us-ascii?Q?gYb6L8a3KwKr14K80Pdlc9p3TASIebId/+d6oGRPTWlA+Df3eiMsMAKenZqt?=
 =?us-ascii?Q?kSTRNtWOAeHaPJy6WEZ0ZXImxVc666wPtwGsJ6IwR1JzvRcJwKPL12APkfLD?=
 =?us-ascii?Q?lBZzoKHE9pWCmYiFR7eygiQbDcXuzfwXflMZ+V7v4jQrL83BPqKuYiMvmlK8?=
 =?us-ascii?Q?+I947PpiBkPeMjzLdOFojIJo97eiVVwymX/TIOnt92jXb/mHldGAqytDVsjW?=
 =?us-ascii?Q?BM0yiwHxazS+19XUFr1Dz7Uy5gHcEmaQfqY9RfzhTqbERHly55AV2wib47Tv?=
 =?us-ascii?Q?75hbuCaRlnDGDrXs0sGjmyrHXBXiAGlsl4oZO97n+Kb57Fz3/fvLonJFJu+R?=
 =?us-ascii?Q?I5Nn9evq+ZyUYxAX43vrQiYpChq7jfxyc+VRX4FT4PvNA14RyTbojJTSfedY?=
 =?us-ascii?Q?vrBL+Jr5grQYgzdnH6+i+yvXcOGLL8FdxlTcipRHgHkwp8ev8XC9v8Lf0ZeL?=
 =?us-ascii?Q?on4rEVLgJizjO1SrdXp+T8RnZJ7S41seLjLEHsbGAAhp5rvtaxOogvuc484Z?=
 =?us-ascii?Q?O32IoOeheZho2AOfRe75dGZIEX5jzwPtLxB3J3YvgVgl6EMS25yNo39snm+i?=
 =?us-ascii?Q?U2hZ7UI7UXtH+2YWzxsKgVIQ4Be8N3itSHRY9yy1otLImQJoueAK0uU1UR02?=
 =?us-ascii?Q?gVFwwuBz39EeOuvkCac5lBy/gghqgd+Bdt7d/RuFBwHvB+UJa7Qv2AipF0hf?=
 =?us-ascii?Q?L6E7KhOqqHcSCt9DrQv4smRGJiDjWdHlvUpN1ui6eC5uvEBrJcOt8LmkHk6y?=
 =?us-ascii?Q?8udzNEX+mXp5miJI9Yrowrze9HJEiUzUEnMjSUfv6mtRru7axWxUeWNvds2Q?=
 =?us-ascii?Q?E8xisc7rGpMT2I8CxPa3ps3MsKt8DeAxm+8w7mYHDN7DYXHa06CQUmvGGIye?=
 =?us-ascii?Q?aTXcOc+tmZlaWozY3nguWrYAZnJqNRw/ztf0BjcwVT5M1mxRPjeqQWySdeYo?=
 =?us-ascii?Q?8OuxsNfYU12DKbO38pNq4IdJVEm5HWtSmt/One/e?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10cd5b71-79e6-4f20-2df1-08db0e7314b5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 10:06:03.6690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3VKRyfTXQn6Bn7m2/HyEm33DbvkMtOyScbQkx+hdsP+c+5G3fbaj7+nQ9Auwcn4Qq/fBAh+pOrh16cOPN4n7w==
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

BGR48_12 is a reversed RGB format with 12 bits per component like BGR24,
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
index 30f51cd33f99..70568f7ae130 100644
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
+    * .. _V4L2-PIX-FMT-BGR48-12:
+
+      - ``V4L2_PIX_FMT_BGR48_12``
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
index 7731ef63543f..e73103fa65ab 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -252,6 +252,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_RGB565,  .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_RGB555,  .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_BGR666,  .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_BGR48_12, .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 6, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 
 		/* YUV packed formats */
 		{ .format = V4L2_PIX_FMT_YUYV,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index e27ed78684a2..e63580a3d712 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1299,6 +1299,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_BGRX32:	descr = "32-bit XBGR 8-8-8-8"; break;
 	case V4L2_PIX_FMT_RGBA32:	descr = "32-bit RGBA 8-8-8-8"; break;
 	case V4L2_PIX_FMT_RGBX32:	descr = "32-bit RGBX 8-8-8-8"; break;
+	case V4L2_PIX_FMT_BGR48_12:	descr = "12-bit Depth BGR"; break;
 	case V4L2_PIX_FMT_GREY:		descr = "8-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y4:		descr = "4-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y6:		descr = "6-bit Greyscale"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 0920f20764db..7aafeccd8f02 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -577,6 +577,9 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_ARGB32  v4l2_fourcc('B', 'A', '2', '4') /* 32  ARGB-8-8-8-8  */
 #define V4L2_PIX_FMT_XRGB32  v4l2_fourcc('B', 'X', '2', '4') /* 32  XRGB-8-8-8-8  */
 
+/* RGB formats (6 or 8 bytes per pixel) */
+#define V4L2_PIX_FMT_BGR48_12    v4l2_fourcc('B', '3', '1', '2') /* 48  BGR 12-bit per component */
+
 /* Grey formats */
 #define V4L2_PIX_FMT_GREY    v4l2_fourcc('G', 'R', 'E', 'Y') /*  8  Greyscale     */
 #define V4L2_PIX_FMT_Y4      v4l2_fourcc('Y', '0', '4', ' ') /*  4  Greyscale     */
-- 
2.38.1

