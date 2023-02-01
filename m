Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A55685F64
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 07:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjBAGDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 01:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjBAGDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 01:03:41 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2058.outbound.protection.outlook.com [40.107.6.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA985C0DD;
        Tue, 31 Jan 2023 22:03:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZU8GW4BL3wHi6ZjIe9Ne+N+SHeRUnQ6b0n+b+JsnUqIHiLkbRSOANndY2UktPvEsusSnQTn5vs2Ocl/oUk+2kNbbUG64UWHo3RUIs+Ez/14+PqIvUCl3u0jqfv8lAebv63cv96BcGYD+kfqs32E5rP6qHQArOb1yJJdRBkeMP1PHnJf2T+4RvbogQMfFD+XDqQlEsQOXpgV1qopoMKH95zMhs4xvxyE8TJV1Qkq8Cq1BUjbYUPc7TCTukaDcFgJWFRWUx2AjT0vQcWkwnJzz6iFTTiMSxC9cxtEXDqJBTOmoQs07ESPl2V/yXWQcjT1z4q75NoXT7ZkQxVpd8iYRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vu1AQX56LJV0XXXyYOTPozmFZsX/rucHWunly+erF/E=;
 b=FraaDy3PyT6DhuIzielI/lq5xZGT7LvZDH8F4QRuEJsFQRpb0NsBBGzx6dXgNyvf66kVkIJJK7pdv2NLrLDwCMxWRNyzJYs0FIrUAKWLEMfZpDmVj6gBh5/M8zE9l/q6Wx6wvCpD2vk8vOnuS8dRPC6UZjxUSgT6AhdBtRubTrPWRY117u566s5LtLhfg+vUUHho1pVzm2Mf/c9yQUV0ioJZfB4BPZzklv4Vaki1uc2P1NcKgVrefJpzz7C/GzvFovC5X+2fama7bS5uZmmCs2rQMqj9HkiAkHkebkzKqiVSUCEYHR8j/zhIiZA9Uw+tNydk9br6ojGgQiYHsNLBZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vu1AQX56LJV0XXXyYOTPozmFZsX/rucHWunly+erF/E=;
 b=Pa4L1wYFN5ueRSXSqAH2/UtPhKvh6tReKes8IJpDvVHGjrmxDPJLiFae5WWzNkOuFgFoPEmbRgrsbNX/jknQ7BArYvrfw7V3gsaJC1QIJOopfcOW4VwajDxPjicDqEVY0sqtKbhgSm1lp8rzG4ADIa5gB+UICBD631/8pdJTj6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 06:03:33 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 06:03:33 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 04/10] media: Add YUV24_12 video format
Date:   Wed,  1 Feb 2023 14:02:26 +0800
Message-Id: <70b55bc46cd3cce59637d384013785c9efe444db.1675230665.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f716eb89-652e-4d30-ae88-08db041a0cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+d0BlgWal2Ejq2hk2U1ePR8XJyD2KCDRcViYnBBKQSrRcT6R5OtvWYHm8VYt9o65b6nQuROTld0IRQIuYI0QsIp0eNjEBEdQWHbrxL4rGZQ/zUEPgTVmgwlNJQ+1vV/6iX9PELAz2KP9pzsK5dDZFXTm7pBb9peXXg0azEbgPqluJ3mCT27jlBUFI46QwF7GuarJ6ZlqV71lb1ljLi4aLVrnv33l+yv6NBJooE4AOJnXFX4wKIJfdsWKQcJStLC0znSxZtrrfz5wXgN+m3moLXFBj/McZLalDna0+WwOJ9jaflj6DKUmdsrC1nCF02/2tMv8vLuiQN0+LAY9JMKydNlyFlBvCroQ88p02Fa5jPrbRDjyqMjhT+nos3lU70m9abiPE3PVOh8WH0M5f2VZgQlSGYm6hhLvjd1v7thMrBcJKlZcGnweSHoDu7KHHbZ8PiO/obJItgSKk6W/DWFZrobQWTCSw0aNpDlFbo6tEpCidZgF9CVPkYKryRFETBWu6nOu1q/aevu3eY+eH8e5hDX/IfvAbDX4tnzFaRvqjX6D17ut3WAZuhFv6/H/V6XEbnxjKrjM3vVw/v3mB1dcHvcP8Q61PFelQ4+kmHZknyglyy/hn1WnHxsNRdo9mK4yyUMXZ0+1hYvgCCc5Oak1924L7ggie3nKEwefkAsIN/WeS6+zqElQsJCppAN8cpMWmqOdchqyAX5ZzrQq2QRwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199018)(38100700002)(52116002)(2616005)(38350700002)(36756003)(7416002)(8936002)(86362001)(5660300002)(44832011)(316002)(41300700001)(2906002)(83380400001)(6506007)(6512007)(8676002)(4326008)(186003)(26005)(478600001)(66476007)(66556008)(6666004)(6486002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DVFtSlXon7BudJKlGqjoQWHHZ4yg4094Mjf6oX+Wz0DoxdhY4Rj1qVevT30N?=
 =?us-ascii?Q?LU/wfMZLPNDa0j6WDJe3fSua1AzFFyzU5CIjE10VcSuCvD0Y2uVz7p8Nr/ci?=
 =?us-ascii?Q?plgriD8otyqpUV0BrGKAMJKC9I4UG8Q3Ka5D5S4NZhbOi+R0XJvfQEp6B6XT?=
 =?us-ascii?Q?hC2tEfVEFpApphuQxB/XxMrmHquPbOISVPovKQkt9k36RJyyUYwdzVb2tfxA?=
 =?us-ascii?Q?gn1OFSypsIHhimA5/l4z3THWJYS2qj5Pa0VUxlcybwcjIPdhrhikiRsFkWzv?=
 =?us-ascii?Q?ciArwVvm3hLstCY40DYdU+mxhiTuqoKS/TlV0bcUcyBxtiEEthtgYJhwS73H?=
 =?us-ascii?Q?gX93rVeswnROeSkDRylt5TRsS3cV3IvoqORkhHg2e8xAbVlmOguVuKQev2s2?=
 =?us-ascii?Q?it6WvSuiD2uH2tdHmN+K6zQu5NZF3zgIYA19OySNgK7C0MrRpXBnGnRYUfe0?=
 =?us-ascii?Q?Es+lx174Cp7N7n8WEXRz/efP0JRjuFsHyHDYpkZGq3ziqoENXzFPDRM5qcVW?=
 =?us-ascii?Q?pnOwgHt2NNFKUt2ho3tQ3nTAvmUSh9RIr5VJJoKJNMFCDe+H0H2rJhIwk7tZ?=
 =?us-ascii?Q?DFKmrcSbLhX9MOB45xc1ygOc73LLChAqT3+GIxfCqOjEecrmNeh9ycfiHfad?=
 =?us-ascii?Q?I6Hi0Kfxx6cY70niJjoewV4ovc1qQXM5H0M2qvLfhRPLhWd2MjKZB48h9qQP?=
 =?us-ascii?Q?l8y6Z67esheDCMS1O8xIlWdDxOSIu5YAwU27JWQsrpUYzIZv9vhl4jaMrT/x?=
 =?us-ascii?Q?jXSaKv6/tXBjOOhl5eo9Mq94k+nlDz6jSKM0kq7afPF/g0BMU7x/Uu7E+mNC?=
 =?us-ascii?Q?+GKvSAFM7qRvbG9tU/rUTtCCNoprIPH29KxISbfbJMJrnului1FKip8rUKo7?=
 =?us-ascii?Q?iOyIDkDoS1Xryk2WtvjQjWtZVL8CHA5623SioVvC0lzoZfdhGgDnjp+BSVR3?=
 =?us-ascii?Q?0bATLc5g6g4PZFvnGx1BWAOyYK/NtR15K32kbnIAz+qyRAOjW9vcSuNsRh+/?=
 =?us-ascii?Q?M1kyDy3y4zZ5y0bd9UNJ0EdF8o+8gcOM1vQs65nuJCzVFvygex+VcVf6D033?=
 =?us-ascii?Q?GbjW4VKhOHtLDj3gzGLJboYZBTtXnGs4FrMEC9eLI/chHtZHFcHJiFWtdcfA?=
 =?us-ascii?Q?dGNi8AZ4KBaM3Va7CQ2POgP1ryIpU4q30d3Gy/hLtYxN4UBsNDt4pHs1Uy03?=
 =?us-ascii?Q?T0JNKi3pDI4ZLz7P+0dc0xIctcupilsyPQsYHqQX9bCjWtp4wHLFpL5BTp5h?=
 =?us-ascii?Q?rf7Lt9A+SP0sEABKjApcysy0612rY8McUa/It62S2Gi53R/BC6UKLZRk+MoT?=
 =?us-ascii?Q?GrUI9Te0/btUstjeYwIrhc4yr/T7p5tHnwgDk4X9QF89yxhSpShmXSiCc69/?=
 =?us-ascii?Q?Uq1gm1ick5PpyDkMp1SEsfg/3W0I0GKjt5aRS8RzkRwti7P0sHGn6MXJC2wR?=
 =?us-ascii?Q?Nd+hrL2dm+hUIj6bi3BJevl3CIHnSRQ4jOSZapcRbyRCRS1i8RlnXX2mXX8+?=
 =?us-ascii?Q?t/CIEo5tZI4ggatPq7hJjKLfsYHz2I2N3ZJyQLzhtW9jL6QnGqiXWyea/565?=
 =?us-ascii?Q?nICn2H3h/FcD/7HzIdPhjuAfD8zPiSrjN96e0Y9z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f716eb89-652e-4d30-ae88-08db041a0cdd
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 06:03:33.6291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BX3RS5kM6o7LP/bf7JXnzK4SGYWSUFcUmD+Iyy6/uqnBP9oRTFbyQ60UkNq7aDPofYbvkdLqHFRbrBtE+GZspA==
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

YUV24_12 is a YUV format with 12-bits per component like YUV24,
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
index bb7169b2cc8d..a098c5e8e609 100644
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
+    * .. _V4L2-PIX-FMT-YUV24-12:
+
+      - ``V4L2_PIX_FMT_YUV24_12``
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
index 3a882fb71227..b3ad02f8cf11 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -259,6 +259,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_UYVY,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_VYUY,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_YUYV_12, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_YUV24_12, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 6, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 
 		/* YUV planar formats */
 		{ .format = V4L2_PIX_FMT_NV12,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 928acb9d13ec..711d1b0a8184 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1343,6 +1343,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_HI240:	descr = "8-bit Dithered RGB (BTTV)"; break;
 	case V4L2_PIX_FMT_M420:		descr = "YUV 4:2:0 (M420)"; break;
 	case V4L2_PIX_FMT_YUYV_12:	descr = "12-bit Depth YUYV 4:2:2"; break;
+	case V4L2_PIX_FMT_YUV24_12:	descr = "12-bit Depth YUV 4:4:4"; break;
 	case V4L2_PIX_FMT_NV12:		descr = "Y/UV 4:2:0"; break;
 	case V4L2_PIX_FMT_NV21:		descr = "Y/VU 4:2:0"; break;
 	case V4L2_PIX_FMT_NV16:		descr = "Y/UV 4:2:2"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 01fd233ff681..3eb188581b83 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -619,6 +619,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_YUVX32  v4l2_fourcc('Y', 'U', 'V', 'X') /* 32  YUVX-8-8-8-8  */
 #define V4L2_PIX_FMT_M420    v4l2_fourcc('M', '4', '2', '0') /* 12  YUV 4:2:0 2 lines y, 1 line uv interleaved */
 #define V4L2_PIX_FMT_YUYV_12     v4l2_fourcc('Y', '2', '1', '2') /* 32  YUYV 12-bit per component */
+#define V4L2_PIX_FMT_YUV24_12    v4l2_fourcc('Y', '3', '1', '2') /* 48  YUV 4:4:4 12-bit per component */
 
 /* two planes -- one Y, one Cr + Cb interleaved  */
 #define V4L2_PIX_FMT_NV12    v4l2_fourcc('N', 'V', '1', '2') /* 12  Y/CbCr 4:2:0  */
-- 
2.38.1

