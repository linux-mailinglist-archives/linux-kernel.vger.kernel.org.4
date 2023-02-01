Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CA9685F61
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 07:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjBAGDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 01:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjBAGDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 01:03:36 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2058.outbound.protection.outlook.com [40.107.6.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658E85C0D1;
        Tue, 31 Jan 2023 22:03:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ma9EMjwCW/qojNe9FG/y2RACMb2luXlEvsTR9Zw+lUx521W1MlnYe6hBRIoNs08S8c2JAk7//zBGB7f+0v1C2eADymlCTyuDIPJDmKOk+EHNtgateC4lE5pjuiBijQnLEZzlxi9miRd3Pcx5Y/enZ9O/eO9RALN7rvBdA53uY9jRH4GLVhMvlBdHiGcpfvhovY9my1KYLrCc94lPZMHnTF/eQE2BXSjsRKHfM8j+9wx4ZEg7AnEqLK1L2tpLn01FcF+wn8E2lt2ZvUWZCZg49g6+aIvu++AjzidUCTkEJOsgnS4ZMYZN8MzdI3hJR+FboY5IAv7kJFK+n6ZjHGWCpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7GmRrdRROf1UKXvZqMMMOpYTrLYX5IvJxAswZRaMtk=;
 b=ms/Lbg64ShfudVgGcDwv3hqLE/jvfNeoPSsS/1b0ucAHhsK4l19W7SptyOXeULE1A4kjEcDxYrOBNI67wucoW/psrnAtc2/geZi64Qs7T/dxiCSCr5Y72SyBfDE/J23Yjx2QF1j2TLsS+M3FK42bWI+6mb7qiIR83nMwg1yAmTY/VO0RZj2MofCGBZ8ZI54CiF0/Kpo44epV47jHDR0E35sAFxsxngN+8AViVQ6KwtWF/6508MLXGOIjovBrdc4kec8MuYs1Usgbvbw7MI5fUcA1TIJRo1tspCOvL3Nb75GcLdJpUlP4xSniB6nnRBhObo9r4uD8pbp2+LPw86RHAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7GmRrdRROf1UKXvZqMMMOpYTrLYX5IvJxAswZRaMtk=;
 b=E2oBqeN8pFK8c2+y3nKw7ge8nOBMBvQw4LA5LAZPZeDzl9eQTvE1wAHaOFa6SpUNlVnyysJqCTrUmbwtTnuImxHGZOaE9PQMM34gU2Dfo6hrKzrc/H1RVprtWDhxysSaRRq9Xm1trumOSLpovO5OiIMD5K8QNAyui4BYZqFVZwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 06:03:29 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 06:03:29 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 03/10] media: Add YUYV_12 video format
Date:   Wed,  1 Feb 2023 14:02:25 +0800
Message-Id: <116656d22cd244ed0c1df74a1968518d4ab51c23.1675230665.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c2f90a93-8fb4-41e9-aacf-08db041a0a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xwPWluVZCz4XvuvyTiUYrE9Px0W5/BwWWZy3ne/JsrP7KY5xmrG/QQc5+Qj7UivgbrQHSlnC9oIujnrwIgrkFxF8HB1pS/TReZolMtJliJQ605cyUWRsQVIeVD/Pq0USdET0H3NafTSouseoe8EdyClDN1WqDf1HhhyCg6+h59tI4n9NfIRag8xOi58mFO4WQRopAje9lvLF6c6HN6Dt7jiVOEtn+M4jB4c83EfHZTSbnLnngDFrHpIRkMGNefeUOfUZLr/NQQ9a3+5LH6dOCB8RukPGqvvcR/XwFIgk1QBXNDMMVq9zOz10NT6I45qrMsAWTtcXDT32YTibCgRT6rLdcur385zW8yMtNXbnrFmC4QIWMQwfrrVbEs63lxK3qgAZJLCNr2mOT2dQ5YFwmJJwbW11eI8sCeR1mEdzT2O7BgdqBKDpse3nWjvcTGvZiytNOf3DuRHkFiU8gnjLZ1kpIPSlwFqddOeTVJXwas/9Y/KPBfBn2oNwPY914uR+pMUS6gHBLNBfj77zlnJwZkAfOL7CvCEaolbumnfIAe8GCqmKdxnGUHSvpqTaqqOhmHTIL9Jp36JsvstIr5P+GSu1PjKqovtRiTf4WfDpSTaoKzGcPS6ck7tTocIKKqKWPDHtU1lsk06XFfz3uwm9os+e8mb4hxoj418MRrBPNFkjbAuVv2jO1Fq6+p4tLzsKrB5KOqvfKbG2rPbQJV58bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199018)(38100700002)(52116002)(2616005)(38350700002)(36756003)(7416002)(8936002)(86362001)(5660300002)(44832011)(316002)(41300700001)(2906002)(83380400001)(6506007)(6512007)(8676002)(4326008)(186003)(26005)(478600001)(66476007)(66556008)(6666004)(6486002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/L5TRbA5CX9QwdkrSCSzEXAZdh3jkHLk6f344QOwVezUElEnWJXxVDlRRYd/?=
 =?us-ascii?Q?sIax7rAlkZMLmNTqMki8prG9/Vq3ZtFYF7B/OBgaYeoW3NSx1EN2AHkZSFOy?=
 =?us-ascii?Q?v7pSKwey2UWFNwSUYAoMbYRku+ETagS+rULBDr0jyezvc2rVOysLOA4uUlbo?=
 =?us-ascii?Q?2XgVlo3JHB7nvwCDa+Ana5KPpmQ5ToGHwYhIiUjTrediklQIjTX9xjOLGzZO?=
 =?us-ascii?Q?XezD1fPzO9TzbgVB5fCpDz33ZzeAlfUnZg3SWMv3K9/bFjJ/ktpM+MPTkgEb?=
 =?us-ascii?Q?y0IZQVRwfNc5/jPy8hoNRy1IBZkxFMogMLXLg5axnSUFFkKtlbgdrZrqFK+9?=
 =?us-ascii?Q?MOrCkEn0cIVwATxhLDsMnp/ArUD7VnAMFY4CwQV5VXyLiwJ0z9Rp3gCfpGre?=
 =?us-ascii?Q?+2SGIMwjdECUxBxGw8VYVVxGkd02iAe9W96Wwl5Tij1PLrV1ihIb/hb+Q0/q?=
 =?us-ascii?Q?P9f8qcpzke+QeVJiwEs0n1+HIMwztwevd/OsMUrvnNJlgypNd4rd6wj0CU4m?=
 =?us-ascii?Q?y/RdPwpdKiygLm0u9HqgwghQZzSFQEOMwJ9M0W4EpFQVc+0h2sBCXKRoTpMm?=
 =?us-ascii?Q?G7CGrP6y8296J8moxNum6kgXkDPnzffn1QuP8jCkhoc/bFMaLr9GJs67q+bm?=
 =?us-ascii?Q?6ZQSxt2oOWcoWGRSkW9ITd039yXlmabeZGLuy+yG6cQJaw7MtRLGTjmrbG6M?=
 =?us-ascii?Q?r4ew5kH4dxxj4HEVweyCA1IefsxXUixQRny2aoKuXDJ1M2n+flvUYtX5GK0l?=
 =?us-ascii?Q?JwGhv7pajfs2sCQseFWQlf/vqzpEHcDc6a/ixLq8mBfVvflcDLMbWioN08lo?=
 =?us-ascii?Q?F8ftauIe90l9Zv2rmvNfkOqDanuDj15OUD1LSATEjgphV6a8fkn4Cm833fiw?=
 =?us-ascii?Q?ys/Q3o3/2bowfw+whNVUl5YGxLH/6s/1EmybOQkpbxv3mL9vD6AAn9CqhRif?=
 =?us-ascii?Q?aIGg12R8r93Q/Nwgt8l+O6ExxHo+Mcc2OASOZCQI7sS61oOX4r0KuSJYLD9o?=
 =?us-ascii?Q?ETtXZIKzZ7lYViEy2tyfSZX1/88t8Zn9ktofjHbnmUNuSZW8L6VKPgBlPbvH?=
 =?us-ascii?Q?gN0mGPzsOLID4nfCwqXExB9Dmo1nbBRZJTcdYaXXlKZa0rX1xD6lgOF0FpXf?=
 =?us-ascii?Q?Ty/8RXCRs/28Ssi6YV1y4oNUtAibD2JfuWYirxLzoV/HoAHahGMXe+7OCW1Z?=
 =?us-ascii?Q?epujn24FT7J6smm05M2BZ/IfbbX5C07EnYDCHsnWnDFL/Xc5DBnzF0i8bOYI?=
 =?us-ascii?Q?a7vEXhyLXyrHjHDZwIyTJTYbHQusEO0AhyuWURBOsx4kd+4pRjQspXwGATV0?=
 =?us-ascii?Q?QYMPYMJezGd64OjE0nK4I+AvDk71C0xwfIAaefVimj3dOuAW4hmRwr7Q4g83?=
 =?us-ascii?Q?qpVKNZDBCHx8w9fpP4DD9qflFdLsgJfUb1kSJh3m+4Ti4cGue7lie9kAi5uW?=
 =?us-ascii?Q?gIYPMCxrGLouquACqlgXe95DkFwdRze8Rh0/TjwXjXXYUv6n30lYe9bQ3ZlV?=
 =?us-ascii?Q?W9J+YF6Ec7Cf83vXEwua/1pFCy9BLALdAHfpOKSkAoMRSkOa2JMHbcxVAMeh?=
 =?us-ascii?Q?JcaMVmdAlnHl7WhA7YDmA75OkJf6Q887XFyJ+vSL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f90a93-8fb4-41e9-aacf-08db041a0a89
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 06:03:29.7230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WS19zDO7HxmON1AtwzIiGXkzt80TWoC9pRjRrRsLwQRO9EEXOmIcNlTkSpcyxdyazNyMFZDQNLAzKBCu3Xw11w==
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

YUYV_12 is a YUV format with 12-bits per component like YUYV,
expanded to 16bits.
Data in the 12 high bits, zeros in the 4 low bits,
arranged in little endian order.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/v4l/pixfmt-packed-yuv.rst           | 42 +++++++++++++++++++
 drivers/media/v4l2-core/v4l2-common.c         |  1 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
 include/uapi/linux/videodev2.h                |  1 +
 4 files changed, 45 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst b/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
index bf283a1b5581..bb7169b2cc8d 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
@@ -341,6 +341,48 @@ components horizontally by 2, storing 2 pixels in 4 bytes.
 
     \normalsize
 
+The next lists the packed YUV 4:2:2 formats with more than 8 bits per component.
+expand the bits per component to 16 bits, data in the high bits, zeros in the low bits,
+arranged in little endian order. storing 2 pixels in 8 bytes.
+
+.. raw:: latex
+
+    \footnotesize
+
+.. tabularcolumns:: |p{3.4cm}|p{1.2cm}|p{0.8cm}|p{0.8cm}|p{0.8cm}|p{0.8cm}|p{0.8cm}|p{0.8cm}|p{0.8cm}|p{0.8cm}|
+
+.. flat-table:: Packed YUV 4:2:2 Formats (more than 8bpc)
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
+      - Byte 13-12
+      - Byte 15-14
+    * .. _V4L2-PIX-FMT-YUYV-12:
+
+      - ``V4L2_PIX_FMT_YUYV_12``
+      - 'Y212'
+
+      - Y'\ :sub:`0`
+      - Cb\ :sub:`0`
+      - Y'\ :sub:`1`
+      - Cr\ :sub:`0`
+      - Y'\ :sub:`2`
+      - Cb\ :sub:`2`
+      - Y'\ :sub:`3`
+      - Cr\ :sub:`2`
+
+.. raw:: latex
+
+    \normalsize
+
 **Color Sample Location:**
 Chroma samples are :ref:`interstitially sited<yuv-chroma-centered>`
 horizontally.
diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index a5e8ba370d33..3a882fb71227 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -258,6 +258,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_YVYU,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_UYVY,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_VYUY,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_YUYV_12, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 
 		/* YUV planar formats */
 		{ .format = V4L2_PIX_FMT_NV12,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 0ee730aa6cc7..928acb9d13ec 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1342,6 +1342,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_YUV420:	descr = "Planar YUV 4:2:0"; break;
 	case V4L2_PIX_FMT_HI240:	descr = "8-bit Dithered RGB (BTTV)"; break;
 	case V4L2_PIX_FMT_M420:		descr = "YUV 4:2:0 (M420)"; break;
+	case V4L2_PIX_FMT_YUYV_12:	descr = "12-bit Depth YUYV 4:2:2"; break;
 	case V4L2_PIX_FMT_NV12:		descr = "Y/UV 4:2:0"; break;
 	case V4L2_PIX_FMT_NV21:		descr = "Y/VU 4:2:0"; break;
 	case V4L2_PIX_FMT_NV16:		descr = "Y/UV 4:2:2"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 3d8f89bff33c..01fd233ff681 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -618,6 +618,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_YUVA32  v4l2_fourcc('Y', 'U', 'V', 'A') /* 32  YUVA-8-8-8-8  */
 #define V4L2_PIX_FMT_YUVX32  v4l2_fourcc('Y', 'U', 'V', 'X') /* 32  YUVX-8-8-8-8  */
 #define V4L2_PIX_FMT_M420    v4l2_fourcc('M', '4', '2', '0') /* 12  YUV 4:2:0 2 lines y, 1 line uv interleaved */
+#define V4L2_PIX_FMT_YUYV_12     v4l2_fourcc('Y', '2', '1', '2') /* 32  YUYV 12-bit per component */
 
 /* two planes -- one Y, one Cr + Cb interleaved  */
 #define V4L2_PIX_FMT_NV12    v4l2_fourcc('N', 'V', '1', '2') /* 12  Y/CbCr 4:2:0  */
-- 
2.38.1

