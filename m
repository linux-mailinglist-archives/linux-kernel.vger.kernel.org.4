Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6006E696044
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjBNKGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjBNKGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:06:08 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2045.outbound.protection.outlook.com [40.107.105.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246F212060;
        Tue, 14 Feb 2023 02:06:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KarF7sr2eKMPtRvhjeKyqeprXF9eZiZks2lUFe4xfWfUPu2MZPytzBO9tmjwde7tLqJOcwY0dCyjIjN/xhcsrZ9B5/KYrN6P0GUTp4t3nHfJF6ILKGAoHDrttDQldJX0yZNnT+VkrJEko4cudEkaoqbNKxPXJaBE1+HvwGN/H2YQVRQSJuVHykXTcqb0b5OwrDR7ZBs34LgC/ZJdVbAnTddNvcS3fZkNuwVoYPa5ssb02JwGshVdH92lHEJu2rraiGJKa0G4eP1mIr6+B/QG0oZCS5s8WKeMC0iqTI3N5ufNpJ710hQHHqxy71sB9BVL38V9UMxfJTKEzpoTAhX7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOFUtR8COD7yZ5nrA2OUKwht/S07omDvy7VCDzMG9Qg=;
 b=JBPDkXnPL655SZY04vBsOqa7owAvoWIjKKW+nfqrn+5JMms8zCIQIRBx6bzhN/jZcRc3baYr3ACV5NoG8SuUDsWUQ3lAGJJP/f3zTS5udCkD4VTqeK9DyLAMrVHog9WyGrF2TrDcYv/jrHvEL98ktFW9KSgztJU7eOVNwB7bODUl5nAz+lLSyZdvSHYMFlMHPplCIye0DvXwzqf7af/ztu2k1C+d33AsCqhOzv+3xZXMRi9aST9Py6n1j2aTkyXB0Ix4xdVDAsM/RLVNYZSyO4PdGAxEXUYbdA8/HpDzDM9oB3POQlpglRifAzF+XEytwTDB1hGOa2Iq4atPbY7/Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOFUtR8COD7yZ5nrA2OUKwht/S07omDvy7VCDzMG9Qg=;
 b=R2NT5wwesc6iQYWZv1RY2ST6xbpK7qiuTzQvBtBGhHWlkpnn3bTomHCp+nP154+dH6yGOO1qgQ0tqSyqrIX9Ni8K0NRdt2sPWCbk0CpVEneXVtBoL+sVXmmp/ARfoglUlGPcVX30haFypAhiF93fiLCehktv3UDaEQXKLTBjeSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB6800.eurprd04.prod.outlook.com (2603:10a6:803:133::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Tue, 14 Feb
 2023 10:05:59 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6086.023; Tue, 14 Feb 2023
 10:05:59 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 04/10] media: Add YUV48_12 video format
Date:   Tue, 14 Feb 2023 18:04:46 +0800
Message-Id: <9d30b46b636451a4a1092e7f486c7c75dd39600e.1676368610.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 39ff5efd-9b5e-4e05-a6d8-08db0e7311fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2awftPDDtf4p8NYx/GJHX5C1jJEbGuoyAkkC8YPD2PFUkVvU9YiVa35ugb1ndvJM2tT1rMs5AbqpE5ujvh7lml7rmaY9i8ddXNvkte7750Gh/q/PozJQNYopXkK9Bcfj8uGzusbUuNqCh8UtlsiBB7YLDe/gt8Yhea6ip5oe54j9tz58odfppb5OUyvZnDOeFdGA5zCEz17AU/+5ku8w+X4OMvJumluyPfWOetSnPMxu7KNV1wqZDoIKoI++OQslGq/CBaNVBXLc/d81fYauTWEKqUiNUz1qoPwUyi3C3xuvgixmAlgm86j9EduPVSiNFx2DC68q4XmW5sAp0MvOcMYBWvNo3JFkA5IgezdYlKuf0ti8Li90N3EA4J5DNtcv/ZeYvi/ZnSwLTOEVZ0r+sVJOQqxgnNHMxJzEs1wyqHylle2sFV5E6cg/3qE3uHwkWz4kq30hcs9KY1fYv8SanlSBEDjG/9E7wQnM4TJ0G3f+6iUXyLivFnvXltRos7/2IUTC6LBRPVX8VMR49k/sM68QrFP2n0SdmPaikhyatEGT47/fD8rFWTH+s7eMz/a+VJKZI6GuoLXp+FxOvn59vAPr+wk0oi8rfzyIyDCbuIfTCXMReD/JRocdAAnSG8Qi+dpE1Eu7cmsw4h68qLGZ+L6jqr0bMTlJDqxXj9SmP86ocob0cgJQ6Cr+JhyvIoDCcr3yca2PS1WACL92Vt0IGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199018)(6506007)(52116002)(83380400001)(6486002)(2906002)(36756003)(26005)(186003)(38100700002)(66556008)(8676002)(66476007)(66946007)(8936002)(6666004)(6512007)(38350700002)(2616005)(4326008)(44832011)(478600001)(316002)(86362001)(5660300002)(7416002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SwSMINcd+TojFKT6xPK+yj7xID7/9uXba4d5i1AhRfpzhgnuxptoEG50G6fP?=
 =?us-ascii?Q?057saf+19J4EmfTevg5OJFDdLDTCsw7nLtXlSl+EqQZEWZzr7eiZhyFR6JDX?=
 =?us-ascii?Q?X+IlG62aJ3d9TA2AJqvRGlCWCBYs2ATcH50lNkj8FCRgnOWk+SHS0uavN1sH?=
 =?us-ascii?Q?rAJh4tlz2NKWGQK7da3tNmRgMun6LOwfI0wZuf0Ja2amDh6dUlMlvsPdLn7O?=
 =?us-ascii?Q?CTMz4ZJMp4a2xUoAn8uDie5Rce2Gl/bY38M/7Yalwx+jkwOhIUCjBeuiVdNQ?=
 =?us-ascii?Q?FeenLz1hRfHAbhkEL9T0f0pV3ZIsRdusb8jNRqzSw+dSyWVYKIHCjQLnSfjA?=
 =?us-ascii?Q?psfr0TFnNurAEolO1k7e3xxvVYECLtQdPGCmT5bKRCU4uq3zYUxZrfpkHnqc?=
 =?us-ascii?Q?fjvNmfNmktEPFU45G6gTh5Hn3UEEzbX7n/8NlOkS0P3PcBwj4nOqYB+zRhy8?=
 =?us-ascii?Q?mavQh+ERcptQtQkTKEOP4vcK3zL9Vd1je5hFtnbvwibz/9KGp9txLizC9Uqq?=
 =?us-ascii?Q?vp3zJ+yi9jjxxCxD6YRZWij8AaD0fJgCZNb4iMQeMgO2/Em1bq9VvUVaFsBc?=
 =?us-ascii?Q?Tk+0MWoFhUgD+cUrMz6wHuSWmQ0l2A2C2SUkZ2MNh7Q4iID8rqeVmdidd3Wc?=
 =?us-ascii?Q?EQsi+YPYInYKLvPz2aRRG8vkuoqPDrygAdxw45u6WvDaMmLaioxqa/P8r9d8?=
 =?us-ascii?Q?+v/T8e0uisHl8Z/55M1dye9IoPSE5WipfG0ZT797WxWL73ib5N6BWTZbY759?=
 =?us-ascii?Q?aokTz+T6nSPQLD0TkYXxd/GxkXQixqTDw8AW0mvN6sV/kf4L3d6/DFlTeF0K?=
 =?us-ascii?Q?QdPOMO1/Q9swj9d1+WH4IITeh6BuGiBSIZcf5n+1j3j/DqMwGPU1qXZvIIOx?=
 =?us-ascii?Q?nhUmNG9lli9ZpJH7d4FhfLa0qpMSzDy6b4no3hOXoeaP1QVi++TlpD/YOgBR?=
 =?us-ascii?Q?FfC0go5h76DBTEFsdilIH90VTmFDWjbH09SVyI360CV9+SYNMcx9KFU3eIVq?=
 =?us-ascii?Q?DjaSOxBEKNIJ7Ll4yKeXHhyuwspy+iR2PX+J8DqV3ADMSYUhk9QTDuAEU/r2?=
 =?us-ascii?Q?EVoJHo0SrbdilDMIoLcqff8VbJEHMAYozuPQuQmTeRpEeYsZNs5oPHpbrRx9?=
 =?us-ascii?Q?QYAYjUMJnmNblzz3HyYVUzbFGh9GDWDrH0KwsHap1FTTgmUyBcamHcStj9rs?=
 =?us-ascii?Q?qDKqdwcRT8PlLVGg/R7Np57X5OQCGicSaJot/Tb9DcvjZ5WUHV3rPElNPejY?=
 =?us-ascii?Q?1PT2FIp7XJc3lRFgbqHvaq+DhUq6MXJe+qvqoxFXnFt4ntg1CJq4WIeqmhUA?=
 =?us-ascii?Q?SzQqNJ5WkTDfusQ3QIrb8RgCUuuziMnj0UOMYGp/AHWxw//KPWDgm16Ao7n2?=
 =?us-ascii?Q?MX0Vou/ko76MSVoHBtXLDeZ2mpyNwbLGn4EUcMaFFx11+jMshEYHbnAAlbIN?=
 =?us-ascii?Q?4wrJbaNn/uVKfdMgInvRjZVJxVOqoHNoBdKQM5VHtO8Q5rt95BweN+2fBVah?=
 =?us-ascii?Q?Mrq8lbKARULZD8TrOj5EB2Bo81tq0LjDTLZ83ztB9EXF65ElNR4kPohFYRST?=
 =?us-ascii?Q?UwIQdcV2L13Mk6MckIme62IB/PDG1Qr8nuGsOhl4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ff5efd-9b5e-4e05-a6d8-08db0e7311fa
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 10:05:59.1380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHLenk0voaHg8DY2tQkSmeW3gABYPx6gmb++jK3dzDnavwekudao62zc8TmHWLx0T1MGxWawprsN7X0VDEAjeQ==
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
index 76fc331f126e..73d878544f8d 100644
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
index 8fb1c0fa8158..7731ef63543f 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -259,6 +259,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_UYVY,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_VYUY,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_YUYV64_12, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_YUV48_12, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 6, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 
 		/* YUV planar formats */
 		{ .format = V4L2_PIX_FMT_NV12,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index e5002d6fe7ee..e27ed78684a2 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1344,6 +1344,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_HI240:	descr = "8-bit Dithered RGB (BTTV)"; break;
 	case V4L2_PIX_FMT_M420:		descr = "YUV 4:2:0 (M420)"; break;
 	case V4L2_PIX_FMT_YUYV64_12:	descr = "12-bit Depth YUYV 4:2:2"; break;
+	case V4L2_PIX_FMT_YUV48_12:	descr = "12-bit Depth YUV 4:4:4"; break;
 	case V4L2_PIX_FMT_NV12:		descr = "Y/UV 4:2:0"; break;
 	case V4L2_PIX_FMT_NV21:		descr = "Y/VU 4:2:0"; break;
 	case V4L2_PIX_FMT_NV16:		descr = "Y/UV 4:2:2"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 3712a36d6fdf..0920f20764db 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -619,6 +619,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_YUVX32  v4l2_fourcc('Y', 'U', 'V', 'X') /* 32  YUVX-8-8-8-8  */
 #define V4L2_PIX_FMT_M420    v4l2_fourcc('M', '4', '2', '0') /* 12  YUV 4:2:0 2 lines y, 1 line uv interleaved */
 #define V4L2_PIX_FMT_YUYV64_12   v4l2_fourcc('Y', '2', '1', '2') /* 32  YUYV 12-bit per component */
+#define V4L2_PIX_FMT_YUV48_12    v4l2_fourcc('Y', '3', '1', '2') /* 48  YUV 4:4:4 12-bit per component */
 
 /* two planes -- one Y, one Cr + Cb interleaved  */
 #define V4L2_PIX_FMT_NV12    v4l2_fourcc('N', 'V', '1', '2') /* 12  Y/CbCr 4:2:0  */
-- 
2.38.1

