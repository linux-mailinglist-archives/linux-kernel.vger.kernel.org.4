Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45475651963
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 04:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbiLTDM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 22:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbiLTDMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 22:12:51 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2049.outbound.protection.outlook.com [40.107.15.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA7613D1C;
        Mon, 19 Dec 2022 19:12:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5YKTnaijjJHvzQbKtAKmfL1aqMD5xNLPVozRD6bKSDDzzgbf555hyZj5niqjtbjza1/EuM/wVF55Arh4HmhjyTcuUhkzbMuIoMMV26NnTryYPa3qPhFGysVTr1p3Q7cZPN2VyRuvQPfgy5XITnPH0h4VUmnadZxHJs9JDaec4XgXvaFfH++wok5A6cu5hog5ewdBdiFGVmcZGXcKJZnpAZT4qHx/79O8KFwoMq6oQZ8smiaxL/URXqAUpWoYIflLa0lX0fH2ZSmL0sVEoaQNQCqPxtEeCSuvrRddZRpcXMVbwX7s2kbtb4FpFXyeqpzOoxiBAiwoaaxMdiNdwFVEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UIH+RRI67kjol9AqivPlGAMCEzoyQR92GRQaOICDhQ=;
 b=QGuUiew8JVvW+W9TGBMwH0s3w9kS3p0SLD5R9lG8nc5hAmwl2ZudyjUW3uWxHZCmJ8wxJioauJXEzbHq+xGUNHSzCIRrVuQSYCPdof8wC2vK3QvwbXyQAE9u+rD5g8/vcVgA0GhSZFN2BQmswvxuN1Q7XiFkh2yEClA7XndUoomICvJC7cl09Q4wKiU/XyH+WwPHLy50+7OmFXKK13ghUE0p71pbcGXSwIRNZ/np4dg/LOyT2E8u/dGlznzCzUmGUlZzZ1inojhMdR9mm141ojfib4VsB4fL8WN29WcGVBrGZQfGMI5wwehjppjwXQ1pBdPE4jEl1YMrf4xAxjpw7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UIH+RRI67kjol9AqivPlGAMCEzoyQR92GRQaOICDhQ=;
 b=QCDncQ+a2+MML84yv0HJFfaBT6bitEZXvb9gRTKZfq/qszqigMhrFYs3QMLw4iMeExZZEF75X1M8VeWEfEmE55l0yOcQ0lNl72Eil2YW70uG7SzUIivZoYgef80HuuKjv+tCBnTKnkTxtAfk1IWz+o/FSEPeu9E9j5YOYHfcbjA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS1PR04MB9405.eurprd04.prod.outlook.com (2603:10a6:20b:4db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 03:12:32 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 03:12:32 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/10] media: Add Y312 video format
Date:   Tue, 20 Dec 2022 11:11:34 +0800
Message-Id: <4eb46df4bb84da00560c6c757cd661a1d00e76fb.1671071730.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1671071730.git.ming.qian@nxp.com>
References: <cover.1671071730.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AS1PR04MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b521f06-af78-47ba-77ef-08dae23808b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qkEaV+rhwwFMmhbvZ/uYURT/O7mZ0qzpq1E1tYWCxZy7HVPRUNY+h5sEqp9nwNuPzkpoOHX42pU1KCEiBDOF+3PGFxQIORbNf9m/6FWQx0NhWDVdaotlluSQA8uchI2NMpTkwpicmsIMYGC92xMYctZiA7kGzfVBCWZCc6wdqwQBv1TxIYsq9dWp/FwwAA0XtFFVdtcilWa3GHFA+WTRMOhiw8rmCralDgd3b3XUCW5KrTCLevPaGQSqFK2qcnyxh9J2KHhPAXgdYPsBVPHWFIW53b9b7uZmUKdOPgIHFSRgLYZFXrZeqsKnXdKzkVuvcRs7uzL/oNpoiBRCeDyj1jIOqF9nf9WyglYKE2/BSoe7MgNZCVL9UNtpq1bpGxzNcoGXfs4W0gJVY433qo3BMfgIvmcfumPnNKHoVPf+2kjv/qBqYc8lQ1EKq62B0wJDeQbQ+gNqu8hyudx3KOnn9VNq3qh98MOgxQ0oDJncNfBmAaMdyxbgnLa7/tUrxh3y0kUPp19x0tuQib3WPYUTP1tHdSnyNSRJrLzyGccjY/q0iopR5s6ZHaImsQ/3/4LFGq0bFXZRJgxgVERFGYLqwW2fI9sQdfO9qvBFrDRWFoc5+VHW4RdD68siC9bwjxij2KbZqFDLtqT7E2VFF/3pEJ9Fko2DoGcPCEFXl1MdDY5rG+VK9pkyoog6r7dpixoB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199015)(36756003)(86362001)(478600001)(316002)(6486002)(66476007)(8676002)(52116002)(7416002)(2906002)(5660300002)(44832011)(66946007)(41300700001)(8936002)(66556008)(4326008)(6506007)(38100700002)(26005)(38350700002)(6512007)(186003)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KnAuoOLLSJmw/2un7rTK0SNhz90LZnauOCZQEZGzp/qFIWzoga2ypUJGMpqt?=
 =?us-ascii?Q?Zh535Vk6c7JEm3T4xrEIxeKvAjZ1MwQyWAwd9XzLCQAUXio6OicslZFnmmB0?=
 =?us-ascii?Q?wrU99UXcuPvmp4w9kb2yqs6hfSdelZ2xeETlDDGz0bmCATrHivfDFC5gkUns?=
 =?us-ascii?Q?oJ4Xd1iB6tv5I20R391N/OvXaoU2ypuA0bZe6AVJ/due6A6fICKgPXEo9z2r?=
 =?us-ascii?Q?CplH6joD+R/1nniHaY4CDLcTABkQwdQfk1W8/Ng8Wr7az5UNOxRMrVThNPEp?=
 =?us-ascii?Q?mBza2SDp7KgydJaIsXFuJ7Nzz76Gv0zpLTOcnTubfwWpvRcRCXTfzW689RcW?=
 =?us-ascii?Q?0SD1oad0qqikRSGndcdIhX8frlWntunaqOhQUGZ2KJTQE5nrBmHoVd7xPGus?=
 =?us-ascii?Q?68wjDEE1fHpNP+rlXlbXYjsPSW7FqqFIvl3hf6U255AsmaaFC8ZQGp05bJL+?=
 =?us-ascii?Q?4416ghBCHZNx75wNCxdZNJXc8NVxsMb6zLS9Sq8EaIZXo6YDi/I18I20EvyV?=
 =?us-ascii?Q?Mv9WMoEANnZvaneuBUMde2g2m5NLRNLy+Vz3xksvy/XDvU1CS3bPVBvkb7ZU?=
 =?us-ascii?Q?eSoFUFP0COg32EzDEzL8yG8BCDW8cKn86ks3RVoXMySWp1kKZgy+94joI+J7?=
 =?us-ascii?Q?VygHtyJ6bj1oiDgXA7AdD3QVWTC7q44yEjZUXe88opv/nfCp00LFvZqMee5R?=
 =?us-ascii?Q?vT8uXGbJqsR4wde5svJxdPvQ1nu/qZC+9lYYXkM0CdtEu9vEubAHlsrsr+su?=
 =?us-ascii?Q?2aLCOXhlaB8EIKxrisYbNmDZm+rxTzp8B0AWTJkdX6ZgTNwc7jmHiq71ICgC?=
 =?us-ascii?Q?dKBmbQAIQB2x/7z5WmABW9Qxh9iW1S4g7PtLi2QWOCn7+YrjkAqBiIVIYeih?=
 =?us-ascii?Q?TX6pbh/LZBnf1ui33w/qHqQbLLg6emzgvLiTihEc/MIsuT0J3uA21lEvsb0B?=
 =?us-ascii?Q?/T01LCKxvdc74OkFqHfIPrTCZwce8RlrNMXpz39wBcH9MShy/esUW+5eWHG1?=
 =?us-ascii?Q?hB7XU/vQpRpeNHu/38/Sa46K8D2ic+YOeWu1h6DYXZfzQR6pMcOko0o7id2Q?=
 =?us-ascii?Q?Ba1DJ07glxU+4XDb2YyMTk6yWdxia8BSvwrRJXJYIHHe3NMRFdW2Ep7UQi/u?=
 =?us-ascii?Q?AvBeLpYHuIHeyw3GKhOmTSoQNIXhS7/H2MbmRIx3dvJbyeCtJxKp9tPj+sPO?=
 =?us-ascii?Q?jsBw8x+/Lk6YjKLZ5UJrhe7alcXatO8lP8Iqwt6AYmopM1sWxzkHdE4QQ+k+?=
 =?us-ascii?Q?g9/3GsFRaMqxgCxYXB6GPYtRJjrtPi6EGRoh4Miulw4EKKndeiQcl7f3SzNP?=
 =?us-ascii?Q?/ZW+9k+DBN/8Ba1mnIs3mxHiqZB5m2E7olKLwLwhCMCZTP1RhAQaYWryt3Kf?=
 =?us-ascii?Q?NVVrihxTSjLpwFdNDIswO/1lVLU7yg/VZGiYRdz+1CBwLYi0cWg8ApgTBuWY?=
 =?us-ascii?Q?+TDFFd3Q79WVD0xGZ52RCvlT2o5PpNRsRjWCJ0XMBst59b26jffCBEfSk8r2?=
 =?us-ascii?Q?uzGYrnDfrxCwmFzH0Fy5b3UQz54eTT560kqyuMNnQjmM4pDyxXRemISsJJTm?=
 =?us-ascii?Q?b3VMYnLo+LKb7goovqHWy7Y6OQXXV/3YAfz+WRqa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b521f06-af78-47ba-77ef-08dae23808b2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 03:12:31.9868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IoCDAY/i5fvN+Rc7D9Gr0NqY1xZyVoMyNhzG4l4KzpslG9Iypa20O2fUckDItmjy9oxyXwLOS95GcYB1QN5YcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9405
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Y312 is a YUV format with 12-bits per component like YUV24,
expanded to 16bits.
Data in the 12 high bits, zeros in the 4 low bits,
arranged in little endian order.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/v4l/pixfmt-packed-yuv.rst           | 28 +++++++++++++++++++
 drivers/media/v4l2-core/v4l2-common.c         |  1 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
 include/uapi/linux/videodev2.h                |  1 +
 4 files changed, 31 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst b/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
index 39ded0b1e65c..a91c30ba6b73 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
@@ -257,6 +257,34 @@ the second byte and Y'\ :sub:`7-0` in the third byte.
     - The padding bits contain undefined values that must be ignored by all
       applications and drivers.
 
+The next lists the packed YUV 4:4:4 formats with more than 8 bits per component.
+expand the bits per component to 16 bits, data in the high bits, zeros in the low bits,
+arranged in little endian order. storing 1 pixels in 6 bytes.
+
+.. flat-table:: Packed YUV 4:4:4 Image Formats (more than 8bpc)
+    :header-rows: 1
+    :stub-columns: 0
+
+    * - Identifier
+      - Code
+      - Byte 1-0
+      - Byte 3-2
+      - Byte 5-4
+      - Byte 7-6
+      - Byte 9-8
+      - Byte 11-10
+
+    * .. _V4L2-PIX-FMT-Y312:
+
+      - ``V4L2_PIX_FMT_Y312``
+      - 'Y312'
+
+      - Y'\ :sub:`0`
+      - Cb\ :sub:`0`
+      - Cr\ :sub:`0`
+      - Y'\ :sub:`1`
+      - Cb\ :sub:`1`
+      - Cr\ :sub:`1`
 
 4:2:2 Subsampling
 =================
diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index 21ace56fac04..332d4b11bc1b 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -259,6 +259,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_UYVY,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_VYUY,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_Y212,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_Y312,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 6, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 
 		/* YUV planar formats */
 		{ .format = V4L2_PIX_FMT_NV12,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 4d5f722b674a..5b97d7e5dbbf 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1343,6 +1343,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_HI240:	descr = "8-bit Dithered RGB (BTTV)"; break;
 	case V4L2_PIX_FMT_M420:		descr = "YUV 4:2:0 (M420)"; break;
 	case V4L2_PIX_FMT_Y212:		descr = "12-bit Depth YUYV 4:2:2"; break;
+	case V4L2_PIX_FMT_Y312:		descr = "12-bit Depth YUV 4:4:4"; break;
 	case V4L2_PIX_FMT_NV12:		descr = "Y/UV 4:2:0"; break;
 	case V4L2_PIX_FMT_NV21:		descr = "Y/VU 4:2:0"; break;
 	case V4L2_PIX_FMT_NV16:		descr = "Y/UV 4:2:2"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index b8a501dccfa4..3475331737af 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -619,6 +619,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_YUVX32  v4l2_fourcc('Y', 'U', 'V', 'X') /* 32  YUVX-8-8-8-8  */
 #define V4L2_PIX_FMT_M420    v4l2_fourcc('M', '4', '2', '0') /* 12  YUV 4:2:0 2 lines y, 1 line uv interleaved */
 #define V4L2_PIX_FMT_Y212    v4l2_fourcc('Y', '2', '1', '2') /* 32  YUYV 12-bit per component */
+#define V4L2_PIX_FMT_Y312    v4l2_fourcc('Y', '3', '1', '2') /* 48  YUV 4:4:4 12-bit per component */
 
 /* two planes -- one Y, one Cr + Cb interleaved  */
 #define V4L2_PIX_FMT_NV12    v4l2_fourcc('N', 'V', '1', '2') /* 12  Y/CbCr 4:2:0  */
-- 
2.38.1

