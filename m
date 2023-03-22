Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FA46C41E6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCVFOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjCVFOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:14:03 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFC058B6C;
        Tue, 21 Mar 2023 22:14:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIu/s3IeHAT53Rl1PiKTCVaVj0PzjSedc4dAv3vczu0MpNKXICnJJUwLsyDa7hdzzlHCdXVx1ruAGslMZ9EHQ6ZXPDRRsnVf/rj8CUa8jPn9xqgywCrm23aw51OXGo0gbMrzJN9PbUFbPgbyHiQqKwzCoKQ7jYuH1xxVxb5NmMG56Pw8720AdncehSlj9/9Ei060WuoHgpMkydamhh8gg728W34zFg+zgqS1ZnouU7f1goqc0YTyHUZYVEa48eIPHm4QcMePA0CHFhMKIt7R6Z8WI2XSoxiNnI2Rqg7MDj++1FAzQ8R8iagonvNgDlFiVrtvyBPvemONz7imy2iITw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzTVOaUGnkWRPu5l+dlYHzF/OoH6UiLH+Wtdh1A2PIs=;
 b=gkEPwstOa6/l/TQeHMSTatejSsjvGBqPU8pAJ0i8+SdhTpiZNJaq40PVA6oQPAcEPQ7LG34rR6ySvUiicdRGkmER2A2cQCno4SCkEAIYSmiOjzLMGBZu4UxLTKADwrLAwKeO7hO1ZIEBNY4CbhEKq23/vvHqsmELix/TATyOq9+chu8B3g+6loMiDY2ItaqU5oNAlfJixbSEaHqs3Fkkae4T1Asag2nw3/Z2S0Ab5P/4rp3GmDfxq/rLOWJxAD9xYq77/L1REKX5pP+6MKLHAXYX6HetGH6ezVnfTVPyM0YgrlBQ21HLgR0dxkWWSHSh4owM4puR9KTOMMQwQcfXcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzTVOaUGnkWRPu5l+dlYHzF/OoH6UiLH+Wtdh1A2PIs=;
 b=eW8lVyJh/D7BLwILAqWUEfVdpM9TXHnWpaLuHDTHf2W+nivi3YExg6lIg7Gl5878zvSq9dHYVWRYYN5avaBfCfxuNylRqY9ROZzwk5lyP5CW2D21gmi6BUrWpnM1/HhojnuUzfv3rkdek9UDxM+6Z7DFPF9jsC3J/1B8qOD48ao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8100.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:13:58 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 05:13:58 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 04/10] media: Add YUV48_12 video format
Date:   Wed, 22 Mar 2023 13:13:07 +0800
Message-Id: <c6bf087b122873ff24a7598cf467a6e7c359bd42.1679461710.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f1944c1b-02c0-4e52-7b45-08db2a943d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gC1Thh5GWrTbGohA8CAYUQAyacXSdqPzAUgq7i+aeTjLt9VPI0BDpsqQr6SrHAKLoHuZHewkWYz26cXZ5uP9jXX10Gm77UT+SjMPvtBmNRPm+aDIg0wuBOXNz7WsK7mSBKr7FGPUsRcU6bIbvqqkaMcq7yt7Osbge17OqHFkahTAotUKi62sGUOEMXdEoIbmgUvFaYgSBCRyBnOY3UWC82oQ9xjTbzimrUvb3ufHTDn/TPW4Ozb0u3HBuz48q8f3Y6Nwpcfrx+1jHde6Gz2dF41BXczDuIlfu+iHWDIH0u9c6PCel6fB+aV0/trnbLXsQvFZM42TWFS12fq6hJQ7Ig7YtvANujaIlEA9LMC5B6dVP8H0eQk2Fky0rRVeV2dRxsOSNiX8uIb6nKqjG9z35cIOEj17VUDzjkm/P+qac1kJ2Laezkvq5VJgkaH5KTJ2ozdscnUemJ1ms5Nw/oe1speUtNF3kgH6sUHEURVXBwiPMhU4iA4BBABEOk1TjNrc9TENx26KcmiVxgkTlUkBNQ7YpfLwegUDIyZ/yWbY59uE0w6J/Rr+CN8IsnHWzLiKcDm35A8tiJ6p0UC/hkEHT12ID8vsVDJR5U2DxoxOqFFy7gKe+COYvRa7Dd4KB7FmA4p8zYEFNATcYkzZzVi4QFG7MDOKhdD41HvCopJPVFZbxeoaWXhugX//VXJtbppMsskXqvCoiasd11J+VFVC+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199018)(6486002)(66556008)(41300700001)(52116002)(66476007)(7416002)(478600001)(66946007)(5660300002)(8936002)(8676002)(316002)(44832011)(4326008)(36756003)(86362001)(6506007)(6512007)(186003)(26005)(6666004)(2616005)(2906002)(38350700002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?96sCNbxC+MaIz/vv/hUeMwhCWi1AeuiFXh59MFpCGIqe9ALaAKLp9IxPWwwN?=
 =?us-ascii?Q?ha54LaztHZn4aG6oRBQEZr6Bf8PVqf4LOfl1r9KPsCQ4Qnqdjvru3t8LU629?=
 =?us-ascii?Q?u5GS6X1vydz4agP542qClKni9Rcp/uZ0DEkaQ11QPpudWnrC+f7rXkIVMIWB?=
 =?us-ascii?Q?b1A5Mmo+byuk56hBfgjcQap1yhGIg/xatTy6xwCKcFr0B74hVpE2OEDVZXgu?=
 =?us-ascii?Q?C+Zqn7oE3qTglBhAdjMFrs+YITwLo70IHZe+kGBHf9TofvNnwJVqna0y5HKe?=
 =?us-ascii?Q?VtXCNYBEagMwAr9xbJceSg3/L2JYfLfNIN9vPkSNDCMJZ7vuvN27CJWcUOF2?=
 =?us-ascii?Q?ni6EIoVX9E+tGDZRkk5Vfe86DMPsfuLpmviKY5wFrM2/0jRRI+ZBQiDuOoHa?=
 =?us-ascii?Q?oKVcQ7HW+7DIsPhgNutoudBcfpqAdkvOrBRKKIUQBjh8A7A8BQo0mmV1yy+I?=
 =?us-ascii?Q?Yei+X81FBkE/8LhE+4bZv+8Z2dHv4JExSauktubxfDM33RAsCDQtMXq401uJ?=
 =?us-ascii?Q?S1DMLWX8tqW+y38Ruu05HQaUKfm/c3AkoYggOuc+G5oZkU/504o2IrEACD8o?=
 =?us-ascii?Q?+UuPlhAiCOxaeZYFj/lI43zMDE48u72jFRehPVH9lz2p6fjY5J2YxsZKqrWl?=
 =?us-ascii?Q?cw7BW5BaCz0mjbTDc9a/FgU5sqDLVeF5qFYc5GMb6QVX60SeSJtt6u0Add+r?=
 =?us-ascii?Q?Eotb8qP79AycKy0fyphJit+ddJMQn5RUmTiB06+jzXxHKzHd/cRth2wmvCHL?=
 =?us-ascii?Q?TNqMkm68FX76dgQGT0EcMJVAKQPgjfubyfaajw9YWchVFUbhk23++cIwvnuy?=
 =?us-ascii?Q?g7opVhlSjxTX9p3pZnYVVxRwtdaP2PIJ0EI2AlrbFAFEoMG14MUDq9Xh9PXj?=
 =?us-ascii?Q?oQSrwZ2cIE9oG9lgIEjU1J0schzzPA44gRUGJQwkMdXHY97EPgUtPvwpkgPJ?=
 =?us-ascii?Q?8VgT1QotMBtfPEV8HkIFrY9GAwN3uwsenBDWceXCZ8RYS0fQhD71eq/EO5Ph?=
 =?us-ascii?Q?0nw6aWzzM/i8xIutElry8q6AuqvXe4SvJl7hrLS9gPrUXiewORZ0FcUrxgXi?=
 =?us-ascii?Q?2wWzQaWCzYSdVS4XsDtqsLWQF26OdPgDQwlz6k5SA79OXtLuIFY17+YOfEAB?=
 =?us-ascii?Q?pEoJrZDzlGI76M/ZzlxwWR1ceYjP4ZBN7z3InvgCwIPEj8G57XowmI+U/sLw?=
 =?us-ascii?Q?uekRM4lBx0STJP0n6JczCJkXLkBFo5tzL6UIh8+oaNR7XQMa/Gi4Ded9vhqm?=
 =?us-ascii?Q?7dyB8+G7c+sZBk1qtmgcwyMStkyh4jA+sM5uUdVGKmqYX9Ega8xyPkoV3G84?=
 =?us-ascii?Q?kG50vdwYpyvN77el8IzB08s+xDWMWE6x5ubviPDsY1uCojIM+OBOzwH8pBPm?=
 =?us-ascii?Q?O2jCIS52YfWCZGE3NFGeuXJWU9E/kVJG8gGGuM7Q3RlX0bR0cKiamQ0QGU6i?=
 =?us-ascii?Q?jNbJ88AhnO3XVmRb4sBWzHoc/dYXoSkoIYmWhI3MMg42fQedZfzno9lRcNuK?=
 =?us-ascii?Q?DCj6zf0Z30s8s1jfU+Xf+k0fEqCbwGAWdIGFy5dKWflAOsd3FeGZmON74ik2?=
 =?us-ascii?Q?o5mt6zvf/RNrpRaSnDaqmxqE6A7MBB+e8DkMjZfV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1944c1b-02c0-4e52-7b45-08db2a943d92
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:13:58.1312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpEOMXgCVKkeC7AOfU/RoX1ALYp0K67njINoeQulp0bj8KQqj/qEr+ZxvLIDH1BfY7LDtfV1de1FRs4812ilnw==
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

YUV48_12 is a YUV format with 12-bits per component like YUV24,
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
index 24a771542059..fd6642f875a8 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
@@ -257,6 +257,34 @@ the second byte and Y'\ :sub:`7-0` in the third byte.
     - The padding bits contain undefined values that must be ignored by all
       applications and drivers.
 
+The next table lists the packed YUV 4:4:4 formats with 12 bits per component.
+Expand the bits per component to 16 bits, data in the high bits, zeros in the low bits,
+arranged in little endian order. storing 1 pixel in 6 bytes.
+
+.. flat-table:: Packed YUV 4:4:4 Image Formats (12bpc)
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
+    * .. _V4L2-PIX-FMT-YUV48-12:
+
+      - ``V4L2_PIX_FMT_YUV48_12``
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
index 21ace56fac04..da313a0637de 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -259,6 +259,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_UYVY,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_VYUY,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_Y212,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_YUV48_12, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 6, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 
 		/* YUV planar formats */
 		{ .format = V4L2_PIX_FMT_NV12,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index be90a9f8c94e..7225e566c528 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1346,6 +1346,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_YUV420:	descr = "Planar YUV 4:2:0"; break;
 	case V4L2_PIX_FMT_HI240:	descr = "8-bit Dithered RGB (BTTV)"; break;
 	case V4L2_PIX_FMT_M420:		descr = "YUV 4:2:0 (M420)"; break;
+	case V4L2_PIX_FMT_YUV48_12:	descr = "12-bit YUV 4:4:4 Packed"; break;
 	case V4L2_PIX_FMT_NV12:		descr = "Y/UV 4:2:0"; break;
 	case V4L2_PIX_FMT_NV21:		descr = "Y/VU 4:2:0"; break;
 	case V4L2_PIX_FMT_NV16:		descr = "Y/UV 4:2:2"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index db06d4c4f008..8a6430bc4a00 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -621,6 +621,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_YUVA32  v4l2_fourcc('Y', 'U', 'V', 'A') /* 32  YUVA-8-8-8-8  */
 #define V4L2_PIX_FMT_YUVX32  v4l2_fourcc('Y', 'U', 'V', 'X') /* 32  YUVX-8-8-8-8  */
 #define V4L2_PIX_FMT_M420    v4l2_fourcc('M', '4', '2', '0') /* 12  YUV 4:2:0 2 lines y, 1 line uv interleaved */
+#define V4L2_PIX_FMT_YUV48_12    v4l2_fourcc('Y', '3', '1', '2') /* 48  YUV 4:4:4 12-bit per component */
 
 /*
  * YCbCr packed format. For each Y2xx format, xx bits of valid data occupy the MSBs
-- 
2.38.1

