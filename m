Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAA2696041
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjBNKGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjBNKGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:06:03 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2045.outbound.protection.outlook.com [40.107.105.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E202310B;
        Tue, 14 Feb 2023 02:05:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpOR9nXjtUs5OwiYMCZDoXlUnPFvKKW6ROx5zLvhKx5xlvBGDKKrKrxXO6cqUofypeu8eddh9z0IZ/1pmAhgZ5cRS1rQugdY23ecMcXil0QZJTC6bfzEoM4N5gBjm/6AIycck/Z1RNSAYImxXuL0knmukXjMCcwNjjWz8hc9Re4S3xlxSlCLcj+xfSRxUVi8uOhMoY79yrDVUWgz0KmOiCfEq+mqvm6ngSLQ+aoF9Ps4I6tEnSrgXwqUC8Pmr9K4XUaAGXSH11K7ik0a2zkD/8bIro53SrgbNF8ax+xgCrHkz05zwQHPazybl2tuJOa3JgiyNYWpRLSG5WxYAvD+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pihe1ThFcXRKGVt9cI5LHQcBem5c5kwpQqXfiFB377k=;
 b=k6eLyPIe4H7wHjTfeI53bEdePbsIMSX0Siz4yYXcYDD6fOm+VeB+hJgP6rtd75VdruWhENuxRW2ZPOUBOrQiLjEdQkDSUiOv3Wilnlk5z6KeHqFsOkevbcdYcopmb+7w7DExUHcRTmDVCOwmPEiVdY0EIGWQNiN7TBzU9Gv2fsniPW9t4gx+CEwMb3SjBJTDOD/g6sby1RWNT1K5nalVyBwUJmRUuKb10IZBsgWJgxz/qdz4PohdYV2H/SE/06tE9MqjY0z1665OHnBHV/aUqvZxLzPI/lltBd+6wTjnkUDxfOXVfn4qk6ZXW9FfP2BDrZ6j3XaGFNzXzCzonk/gkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pihe1ThFcXRKGVt9cI5LHQcBem5c5kwpQqXfiFB377k=;
 b=EE1ObRqq1Nn+xHGJi3B+HOAmLkdZ9LPpo+vujq9AFB7IzUircX/eBvtM+otM9jsbck3Q2eJstBJAlfz3qC6L9/QM536+OdaY4bVZDQW6fY4KN+jnD/kU4CFkjrP8Zyz2iYGqLAs3QsaRv0PDOZRVc9vV+YHcMc2dPdB0wcGCBaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB6800.eurprd04.prod.outlook.com (2603:10a6:803:133::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Tue, 14 Feb
 2023 10:05:55 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6086.023; Tue, 14 Feb 2023
 10:05:55 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 03/10] media: Add YUYV64_12 video format
Date:   Tue, 14 Feb 2023 18:04:45 +0800
Message-Id: <f5ef51d5e0ce881501a3d72a8e49c8a040fc64f6.1676368610.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 45eff19f-c13d-4da7-a367-08db0e730fa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: muVatVx8CWMl4x/mleTFK4pkCgFp2jpn2fJVSEsQOPT90oJeSpN3MlalqKZhQWAaARTBSOAn0oSIVXYMit67freW2HnscwBC6s47HYUv8TZAll2wBU5xU9YltDkt2Mtin/QXODBbP7qC7jubKc4TLOdPGAAMt2D1fXYuX8HGvq+cXkVCKmMdvu4ARFM0i7UoplU3DtKEda1c7c+EjrASaS7qVTpF5h5o/2sPkTCgLfQEx0Wzzfgv+YOFgHWVYlNfxhytmoUmIfQPwZYBjS8bb4boNul3e+t45fUNzZtnu2xdySKA8bsEB2fO58WD4dhT1cyWy4PBkcJBQgOM/m26QimlaCQccEi9XsKIInOYBmlxNSxt5Z88PuchJKa+pbOCTzg/g51yRnivwnR/DyeNO9xDyWVxCBu9FsYX+WSPfftDHY2OKpjagM8JCGtCFqYFUCBjMId9oiZS2ZAmkvjpBeFn4LU9CR06a5qJ8Dy9+yP8k2yA6l7sj/HwCFPUhvwLOF2TNQHxiQvsy1xhlynPDdHGpyMixlFbbgZnKqVjhQRlC3lCQkcBOoaKsoumyk04crlMyzXkooWBrSyieaB/aZbUk2X+nGrvDv1DMxtxYHj/+3Ojj9DQhIRBQBsL9rPvhXPzQwLnez50UG8/IEhv6xyWJWWjYAO4E/NAW19Zpw0ho04gr8aVo0p1eV+hAK2IWjsPj7+ausIZArPLCH+frA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199018)(6506007)(52116002)(83380400001)(6486002)(2906002)(36756003)(26005)(186003)(38100700002)(66556008)(8676002)(66476007)(66946007)(8936002)(6666004)(6512007)(38350700002)(2616005)(4326008)(44832011)(478600001)(316002)(86362001)(5660300002)(7416002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9VXZwsIUgKdnyb6x7CrJaxcD8HtMaoP8aodp0cmi25E1THWKq0aI9yIYpoe/?=
 =?us-ascii?Q?Xz8ADzQOHKaA28tX580nsyXso144lEk0PdPbbs67Imp9UjXJjv4T47RE9m3N?=
 =?us-ascii?Q?MVwRu7YhrVXBEKjTBv+9UyaP0teOm+F+X6RrbFDiLUa8d8Sm3GlShz2KdTWi?=
 =?us-ascii?Q?A0XArHa8KzcOMa0m/wmou0BrAHeiGtRP9eu0Z78AftidkPD36Lo91K/nIwe9?=
 =?us-ascii?Q?uQlh3InRRYBuHfjx5oedqSfZQTgU+1w5uJ3Px1x0q2C6cqCo33BlDsL8VAVN?=
 =?us-ascii?Q?MqCYzENu7hYv1/X27cHPUaCigOhLtP+afo0Dikh59pu0m67wC6QWLBOP9KsL?=
 =?us-ascii?Q?KJ7lXvg846ghPie6ftQubGVVR8fKQqYI/JAk0LO3vycb9E5ubPWpfDmCqhB8?=
 =?us-ascii?Q?wokbhlK9VR16AhgF76xjkkLJtV+ZioifeTbOckoljxeXScmdLR3QXtMjahgb?=
 =?us-ascii?Q?XctLPPnm6BF9bOXvOro+ZND8P7BXa/Yy5orLPXEtwWaxt8v7MBZMwFaNslaW?=
 =?us-ascii?Q?owOJ1MIsg2M+ayLlA72ptiM5mDmJTHVVmKuifmhXH97xJjHKEGIMewW+Gier?=
 =?us-ascii?Q?UeEij0dZFF43m446aQg9eAWmiqkDezuyv8zFSC1aZZy8oXnS5JmZNbHJ3+u8?=
 =?us-ascii?Q?jB3OZvjceIhc3CHIQVBDut5SaiJjU5eLIUZytr3UF0JBKSsD6FfTwwfBJjze?=
 =?us-ascii?Q?wAxSWJQ3/JJeogaY/0+sFrP1Chk6NlHPoB94qLQDfrEb2Pd+pF2p/ugw0sFp?=
 =?us-ascii?Q?agb5TyXNO9go/EykImU8NXoEJSWT/kqK4meFR+6hffC5PFbsQc3BEEiG7Fng?=
 =?us-ascii?Q?VCIvgKoa5Uh6C0FGr6n/VDv0QiVvqWLCZJsP9qkpfu01syPsZha7cG3Sy/yR?=
 =?us-ascii?Q?tUKVfDuhYgnf5PaAZl2ggndnNXgT33TqFn0F+WDaNp++Nf2havqx8XBXPA8h?=
 =?us-ascii?Q?GQmbuICKnappKsI644PAtGf0uZtMMlp/gfte+1S34av0iUkwOBn2LolJ7iXk?=
 =?us-ascii?Q?y4Ud9lT+bby5aWyAsSZQ53EGZFKp9gj/pvlOqRP7/1esgTHUlISyP74HhhPk?=
 =?us-ascii?Q?e8mRaeFMEsuizCR81hdxY9PitORuIFlaX58rXnKV+9lIKKF0yOSZJAPjdXwe?=
 =?us-ascii?Q?Rxs7BQ73mA9p8FQxQhN4j30f8J01HpQoEvZdwTmRp7YiuiC5Em19zZfuuEU4?=
 =?us-ascii?Q?jal299HviRkaoy676OhGy7QLg2ziSiuKWRdZ2MsRAmpJ/rV747Xb9v1muTsx?=
 =?us-ascii?Q?UIEV4NLFBk5QoJfxv/OizBV1M35zrJ80CKtR9Dpx0T68gCpR8TdIpMzhKrEc?=
 =?us-ascii?Q?WbD3RIHw80U7HAg2aVLxGEhifa8JHp6noXOufZal9R9sGJ+qHASrepALTOVd?=
 =?us-ascii?Q?JFiKTm1muZnVRHyAsYN6aRZi6ssen+8zGbvXL977PGdg2Cde98I4xyyfJB8t?=
 =?us-ascii?Q?9rT/fiaFpBIPLsmUKFaP3KJx5Yd5IdLDLTBIY6Z6UO7vcfBGuPjLQO8JbnJK?=
 =?us-ascii?Q?Jh3hklSJiQJUZcrGrJaWis1p4xv/s5tUlae1zDRZIqZDoYeWZjdlgxyiGp5c?=
 =?us-ascii?Q?tR9n4TkF9QaEg0RvBLThb6ykVoamHRm7isqdduFW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45eff19f-c13d-4da7-a367-08db0e730fa6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 10:05:55.1695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1O7muecXhxTqeVKbxwShC6fNmwOCcKbVJpKAWu8FrM8p4JCdqDbIck+k5/4Uu+G8uS0vdF8Ah5lWn417Mk7RIg==
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

YUYV64_12 is a YUV format with 12-bits per component like YUYV,
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
index bf283a1b5581..76fc331f126e 100644
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
+    * .. _V4L2-PIX-FMT-YUYV64-12:
+
+      - ``V4L2_PIX_FMT_YUYV64_12``
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
index a5e8ba370d33..8fb1c0fa8158 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -258,6 +258,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_YVYU,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_UYVY,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_VYUY,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_YUYV64_12, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 
 		/* YUV planar formats */
 		{ .format = V4L2_PIX_FMT_NV12,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index ec1c9ef27e88..e5002d6fe7ee 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1343,6 +1343,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_YUV420:	descr = "Planar YUV 4:2:0"; break;
 	case V4L2_PIX_FMT_HI240:	descr = "8-bit Dithered RGB (BTTV)"; break;
 	case V4L2_PIX_FMT_M420:		descr = "YUV 4:2:0 (M420)"; break;
+	case V4L2_PIX_FMT_YUYV64_12:	descr = "12-bit Depth YUYV 4:2:2"; break;
 	case V4L2_PIX_FMT_NV12:		descr = "Y/UV 4:2:0"; break;
 	case V4L2_PIX_FMT_NV21:		descr = "Y/VU 4:2:0"; break;
 	case V4L2_PIX_FMT_NV16:		descr = "Y/UV 4:2:2"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 3d8f89bff33c..3712a36d6fdf 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -618,6 +618,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_YUVA32  v4l2_fourcc('Y', 'U', 'V', 'A') /* 32  YUVA-8-8-8-8  */
 #define V4L2_PIX_FMT_YUVX32  v4l2_fourcc('Y', 'U', 'V', 'X') /* 32  YUVX-8-8-8-8  */
 #define V4L2_PIX_FMT_M420    v4l2_fourcc('M', '4', '2', '0') /* 12  YUV 4:2:0 2 lines y, 1 line uv interleaved */
+#define V4L2_PIX_FMT_YUYV64_12   v4l2_fourcc('Y', '2', '1', '2') /* 32  YUYV 12-bit per component */
 
 /* two planes -- one Y, one Cr + Cb interleaved  */
 #define V4L2_PIX_FMT_NV12    v4l2_fourcc('N', 'V', '1', '2') /* 12  Y/CbCr 4:2:0  */
-- 
2.38.1

