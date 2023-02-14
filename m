Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B50369603B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjBNKF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjBNKFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:05:53 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2041.outbound.protection.outlook.com [40.107.14.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEBD527C;
        Tue, 14 Feb 2023 02:05:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MF24CDDpUFkuKATik+KbJZhqwR9wPJnXcLYI+BYBazQBVNN8Cy347vZrVXH/78xyxzfbG27BTVByjSMvfVw2kT8Fyvac6fpa9u4oqtCD7oJGFJvW3UGtOKrRDokiA5ljs5pdNUDjlubE8Fs9A0OIeSRXlXlhz8ApqodOUHPVOSU1MpXyIY3lywb4Yf6Wy2ypBegQY211A/OaWAQdf0Oa33EaIBtmyORc1fZ1mdzICBxxvPZgNgfrIbgOxSb97SNwodNTY1KuVsU/yDsO0OOhD9aCYv1U6950aumO3HK3/HHvelJTa2F9vfWneB/D8HTBxzEGEgthHTbXIO4UvmA6Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/gvrBgcYfBMiPuYaztMA7JJWd8ZL+CtVG3h2U7bgMo=;
 b=bT9AKkBBs1vodJBJSN1WPu4JqmynKTPWD6NZbPd9s/8ylZe6xq+ByeO8Dp6mtmJl6gEzx9N8jZjo8YxpscH3lL6l2IWcg4//DAvD7sqYhHdF2DUIFnsix/4NnPPyQpO7To5ZCrK7GcTL50xKQ7oU3DfXgprv4Lt5K+OUD0KlCOaaOgyVd7n44bvPuVqCYSLdQC164E8UoXkXBtUYV8qwHzq6x0kP8tJdMOD71nAJ6cQyoBCfzu4heRsLXU4tB9/DIlX/hj4Ul1gbbRTUKzJJQPGy5wngUTeFcPNY1HgHegLht2cGxjamW2hJj1twQmxooQfM78UoMlp6vycyCKO7mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/gvrBgcYfBMiPuYaztMA7JJWd8ZL+CtVG3h2U7bgMo=;
 b=LuBtFsVciGCOsPLA22NqK7TUeKA1EzB0y2GgaCREdI40r1YHzw+nzNVp07CA1LmAWtOLH0eQcSgL45tIptJiFEMpBmPd/GvZdmmuIPL4ukvkrze1EelSV2dE6QK1Ms9qzt/NkXAEbzD6EAbyxX6X5XCZ/k4hpjWeEcaGa6H5QS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB9204.eurprd04.prod.outlook.com (2603:10a6:102:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 10:05:47 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6086.023; Tue, 14 Feb 2023
 10:05:47 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 01/10] media: Add P012 and P012M video format
Date:   Tue, 14 Feb 2023 18:04:43 +0800
Message-Id: <f866a3940ec56d707852e05fbe053e7c38391311.1676368610.git.ming.qian@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|PAXPR04MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: 6681713f-2dd5-4c61-9c89-08db0e730afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BS7eU2nd3x8Y9VQe7D/N0UZH/0XW6RNN4kvQ4LW/PmzTj6FPH9CH1+XnyCpOUK+NTYR/shXg6of+tDw4+74OLUqP3O9UVqGyL6D1hZe/0uTsazN2ysnIoKziebqci6e2MSG0+pfCOE2LzyDwkifgaZQBrWHpJB5L7m5hO++2DG63CLBmw6p6C0BeUfOAIqkqlJZw9m4wKCChDpDYDj8u0zfizqGY+P2HvtIF7O62oSJR3xjVq7t7//GMWQ524H/XVI2t/HcTJvOm8br7vNypjJS9mQxs1hGzrtLV945kKxV3k6WhHDizuvDXUrXvQA4wkQsuuSX9PwpXci8iAxfDBaMVwYMTi0Tl/13n/rXLG1BFU+ziF+cdmhO/BvGj5K9qQhVcjQwNEGnVzNLJrrpghj9mbpgC88rxGrPUVRoFr5zE/ETmQekQ5TNccp0X3zzQwUMbFHL63B6OXOghzAYKOGb1BswLcQYVFj4kdVpXK8+iwVadHHvPzwgKA+kvsgWfDFXWk+wpUsHkLGdwieQ5qucrCV+RiSE1vUxn6LI8VZPpgebapWxLxqUem6n+Gs5p+aWUR7CjguhdAHnLcOGpgJqBsF/ivDAE8j4Q4R6eBeTP4+1opYsE+lXBCLGbnrt1W+rpAKlgURzKSHoOobiBzzHqpFyVyhP2UH5Xeu7YJ1QH2rugOM5hmd8Q39L5tgXnZ7TMt7HN7Ox9TtRP7C1xMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199018)(6666004)(2616005)(41300700001)(8676002)(66476007)(66556008)(66946007)(2906002)(38350700002)(478600001)(8936002)(38100700002)(7416002)(4326008)(44832011)(5660300002)(316002)(52116002)(83380400001)(86362001)(6486002)(36756003)(26005)(6512007)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1hQywsIsj3oHWea8322la+Y5C5LITV+swY6KW7p5E6phgewAomIk+ijc7H1b?=
 =?us-ascii?Q?tzuoPeFLtdyww8QotEwIH0dEeWPntCc6XTuh5ue/aD2i4SAltmEP4A2zF9nu?=
 =?us-ascii?Q?sNc7sp2o6gOZNvxai99r+iNCFZqDblc6Z/wGpV/NDM/KAIi4t9eZoA4qStIG?=
 =?us-ascii?Q?ItrScIJJ1T2UZFYDoixuUDy0w7LrL9Xe430krfFyU9lmNJWyWgHxOhtuAC4r?=
 =?us-ascii?Q?NIPeukXIT+XfwE/C7i1LFxUT3qcCiecnXoxmZKk1cAVW1yL9UzDNIJJdCsbG?=
 =?us-ascii?Q?x5O1GBFLTyDfGQFKhz49Dinwz0q1qAM/3jS0FF2yvIR9jQioa080ZjU1DhC4?=
 =?us-ascii?Q?S+f63sFK4t/0DVPxNY++70EQUkIpQVHMu5ccqTrJdop5298ZzINkLhe95u/F?=
 =?us-ascii?Q?VBCtYG+3hZq8xteC/B9h9FCrg+dEHpAKrP3yWWI1pN9To3QXtNWQYR5bjQcu?=
 =?us-ascii?Q?yIpivsqDBPePZvdh2l8lvdL+co/zS4RFc3sMHRjY5hEq++X2znLfxb3vbVfR?=
 =?us-ascii?Q?1SsOFKTjQhUkzJMZkWwvqZEngUJJ/c34mt8LZUJVO5+Z/DZ8yJ2BbaBA4w2T?=
 =?us-ascii?Q?pq1IeWMd/hX2lmg1ilym6PaFnS1JO8C/38CptRZBS6naMzJSrYKa0+ONLolf?=
 =?us-ascii?Q?1WsLV6ryL6gWYt/n5FXfIzGv7ZaeBZCBEHncyK8s3mafsBULdNNcEqQ62dWu?=
 =?us-ascii?Q?Lx0ZcorYHcHqlotlEltS1GvT5BfRc2YPH4xn8/9mijnT1VnyiqDaP6iqRNFY?=
 =?us-ascii?Q?Nui65xAhPK4WVrgH5QHg0aP0pfIDMp8VPoLgSWM/kg49bbQdOx/nw889ABzj?=
 =?us-ascii?Q?Bk9/p5COJFKB+UBTU81D5d6we9Z/jDKjhCVkzYrCRQ9wy979s4Dd9K0/DCEu?=
 =?us-ascii?Q?DB5+8H6LMvWcOn6Rhx5OvfbOT4Qk1OvhztyQVMHVzU6wMmyM001ho9VN028H?=
 =?us-ascii?Q?7Ty/ELXY7nrrvu+NTcgtmGM1RtI/i+l2I9PJg/SkGqoUcKLvdoR2vA3ZrnFe?=
 =?us-ascii?Q?ufrgaQz6wMTZrnhyeMCFZcefK8dMKxMvKVG9R2ajZG5zZAfRN0jPcMBqdooj?=
 =?us-ascii?Q?6TlCtGfStcG1HvCckVf6Ot6aRczCgi8ege6ueExz4aH4mvHVTBt4ejcChsQc?=
 =?us-ascii?Q?eyo7V8TjvRIZh1dVWnR9BXt1yphUkI/xnH+sPake1WgTyHgTyZSLyrDqcsbB?=
 =?us-ascii?Q?bQQe+GGqiP2IijBNihpjU1Ux6sGJ3OrInXufPCm6JPGdbk7MWO+VRArSF7aw?=
 =?us-ascii?Q?7kuh+1EQuXaEhX8xK6LDJCi+HlrfNtcN7KBPsayJwBKbAlkgRZ1tofr7sAEp?=
 =?us-ascii?Q?aJXvnEg2w3n5ciCUoDv7AmCZ2yy+h/ZTsKm2ZjmqoH9CAuWCHaWdj08V19Xx?=
 =?us-ascii?Q?eTA1X7MErBe7+kctGT7jwA3EdDkz0RihMUfz4v2CpmvPo1zZiao3/C6/hUsQ?=
 =?us-ascii?Q?k9S2Af71V2hqr/8NI3zzxEPTKcTTL+6QwzKC0pVYtFI52ruEZyvJUnqQavqE?=
 =?us-ascii?Q?l0i3JjC0fqmtymqwT7s2CQekaV2fXgU8kBGLTVj9lQID4p7whS462PXwdmVd?=
 =?us-ascii?Q?igVcQ9N11HBENQkMgM73k0UlL0MF+keZyNBsx4R1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6681713f-2dd5-4c61-9c89-08db0e730afe
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 10:05:47.3574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwWVKcHKWftA81n0xZHWDbygWAFV4wgdtfHQaGwNdKgo3TPSyAly0TqXjIUhERx6Ya6Y7mpQLPCUng/7bKfM5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9204
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

P012 is a YUV format with 12-bits per component with interleaved UV,
like NV12, expanded to 16 bits.
Data in the 12 high bits, zeros in the 4 low bits,
arranged in little endian order.
And P012M has two non contiguous planes.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/v4l/pixfmt-yuv-planar.rst           | 94 +++++++++++++++++++
 drivers/media/v4l2-core/v4l2-common.c         |  2 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |  2 +
 include/uapi/linux/videodev2.h                |  2 +
 4 files changed, 100 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
index f1d5bb7b806d..aa37c3de8808 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
@@ -123,6 +123,20 @@ All components are stored with the same number of bits per component.
       - Cb, Cr
       - Yes
       - 4x4 tiles
+    * - V4L2_PIX_FMT_P012
+      - 'P012'
+      - 12
+      - 4:2:0
+      - Cb, Cr
+      - Yes
+      - Linear
+    * - V4L2_PIX_FMT_P012M
+      - 'PM12'
+      - 12
+      - 4:2:0
+      - Cb, Cr
+      - Yes
+      - Linear
     * - V4L2_PIX_FMT_NV16
       - 'NV16'
       - 8
@@ -586,6 +600,86 @@ Data in the 10 high bits, zeros in the 6 low bits, arranged in little endian ord
       - Cb\ :sub:`11`
       - Cr\ :sub:`11`
 
+.. _V4L2-PIX-FMT-P012:
+.. _V4L2-PIX-FMT-P012M:
+
+P012 and P012M
+--------------
+
+P012 is like NV12 with 12 bits per component, expanded to 16 bits.
+Data in the 12 high bits, zeros in the 4 low bits, arranged in little endian order.
+
+.. flat-table:: Sample 4x4 P012 Image
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - start + 0:
+      - Y'\ :sub:`00`
+      - Y'\ :sub:`01`
+      - Y'\ :sub:`02`
+      - Y'\ :sub:`03`
+    * - start + 8:
+      - Y'\ :sub:`10`
+      - Y'\ :sub:`11`
+      - Y'\ :sub:`12`
+      - Y'\ :sub:`13`
+    * - start + 16:
+      - Y'\ :sub:`20`
+      - Y'\ :sub:`21`
+      - Y'\ :sub:`22`
+      - Y'\ :sub:`23`
+    * - start + 24:
+      - Y'\ :sub:`30`
+      - Y'\ :sub:`31`
+      - Y'\ :sub:`32`
+      - Y'\ :sub:`33`
+    * - start + 32:
+      - Cb\ :sub:`00`
+      - Cr\ :sub:`00`
+      - Cb\ :sub:`01`
+      - Cr\ :sub:`01`
+    * - start + 40:
+      - Cb\ :sub:`10`
+      - Cr\ :sub:`10`
+      - Cb\ :sub:`11`
+      - Cr\ :sub:`11`
+
+.. flat-table:: Sample 4x4 P012M Image
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - start0 + 0:
+      - Y'\ :sub:`00`
+      - Y'\ :sub:`01`
+      - Y'\ :sub:`02`
+      - Y'\ :sub:`03`
+    * - start0 + 8:
+      - Y'\ :sub:`10`
+      - Y'\ :sub:`11`
+      - Y'\ :sub:`12`
+      - Y'\ :sub:`13`
+    * - start0 + 16:
+      - Y'\ :sub:`20`
+      - Y'\ :sub:`21`
+      - Y'\ :sub:`22`
+      - Y'\ :sub:`23`
+    * - start0 + 24:
+      - Y'\ :sub:`30`
+      - Y'\ :sub:`31`
+      - Y'\ :sub:`32`
+      - Y'\ :sub:`33`
+    * -
+    * - start1 + 0:
+      - Cb\ :sub:`00`
+      - Cr\ :sub:`00`
+      - Cb\ :sub:`01`
+      - Cr\ :sub:`01`
+    * - start1 + 8:
+      - Cb\ :sub:`10`
+      - Cr\ :sub:`10`
+      - Cb\ :sub:`11`
+      - Cr\ :sub:`11`
+
 
 Fully Planar YUV Formats
 ========================
diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index 40f56e044640..a5e8ba370d33 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -267,6 +267,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_NV24,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_NV42,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_P010,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_P012,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 4, 0, 0 }, .hdiv = 2, .vdiv = 2 },
 
 		{ .format = V4L2_PIX_FMT_YUV410,  .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 4, .vdiv = 4 },
 		{ .format = V4L2_PIX_FMT_YVU410,  .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 4, .vdiv = 4 },
@@ -292,6 +293,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_NV21M,   .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 2, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
 		{ .format = V4L2_PIX_FMT_NV16M,   .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 2, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_NV61M,   .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 2, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_P012M,   .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 2, .comp_planes = 2, .bpp = { 2, 4, 0, 0 }, .hdiv = 2, .vdiv = 2 },
 
 		/* Bayer RGB formats */
 		{ .format = V4L2_PIX_FMT_SBGGR8,	.pixel_enc = V4L2_PIXEL_ENC_BAYER, .mem_planes = 1, .comp_planes = 1, .bpp = { 1, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index b26da2650289..a166436be83f 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1349,6 +1349,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_NV24:		descr = "Y/UV 4:4:4"; break;
 	case V4L2_PIX_FMT_NV42:		descr = "Y/VU 4:4:4"; break;
 	case V4L2_PIX_FMT_P010:		descr = "10-bit Y/UV 4:2:0"; break;
+	case V4L2_PIX_FMT_P012:		descr = "12-bit Y/UV 4:2:0"; break;
 	case V4L2_PIX_FMT_NV12_4L4:	descr = "Y/UV 4:2:0 (4x4 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_16L16:	descr = "Y/UV 4:2:0 (16x16 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_32L32:   descr = "Y/UV 4:2:0 (32x32 Linear)"; break;
@@ -1359,6 +1360,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_NV61M:	descr = "Y/VU 4:2:2 (N-C)"; break;
 	case V4L2_PIX_FMT_NV12MT:	descr = "Y/UV 4:2:0 (64x32 MB, N-C)"; break;
 	case V4L2_PIX_FMT_NV12MT_16X16:	descr = "Y/UV 4:2:0 (16x16 MB, N-C)"; break;
+	case V4L2_PIX_FMT_P012M:	descr = "12-bit Y/UV 4:2:0 (N-C)"; break;
 	case V4L2_PIX_FMT_YUV420M:	descr = "Planar YUV 4:2:0 (N-C)"; break;
 	case V4L2_PIX_FMT_YVU420M:	descr = "Planar YVU 4:2:0 (N-C)"; break;
 	case V4L2_PIX_FMT_YUV422M:	descr = "Planar YUV 4:2:2 (N-C)"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 1befd181a4cc..5448aa3b7858 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -626,12 +626,14 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_NV24    v4l2_fourcc('N', 'V', '2', '4') /* 24  Y/CbCr 4:4:4  */
 #define V4L2_PIX_FMT_NV42    v4l2_fourcc('N', 'V', '4', '2') /* 24  Y/CrCb 4:4:4  */
 #define V4L2_PIX_FMT_P010    v4l2_fourcc('P', '0', '1', '0') /* 24  Y/CbCr 4:2:0 10-bit per component */
+#define V4L2_PIX_FMT_P012    v4l2_fourcc('P', '0', '1', '2') /* 24  Y/CbCr 4:2:0 12-bit per component */
 
 /* two non contiguous planes - one Y, one Cr + Cb interleaved  */
 #define V4L2_PIX_FMT_NV12M   v4l2_fourcc('N', 'M', '1', '2') /* 12  Y/CbCr 4:2:0  */
 #define V4L2_PIX_FMT_NV21M   v4l2_fourcc('N', 'M', '2', '1') /* 21  Y/CrCb 4:2:0  */
 #define V4L2_PIX_FMT_NV16M   v4l2_fourcc('N', 'M', '1', '6') /* 16  Y/CbCr 4:2:2  */
 #define V4L2_PIX_FMT_NV61M   v4l2_fourcc('N', 'M', '6', '1') /* 16  Y/CrCb 4:2:2  */
+#define V4L2_PIX_FMT_P012M   v4l2_fourcc('P', 'M', '1', '2') /* 24  Y/CbCr 4:2:0 12-bit per component */
 
 /* three planes - Y Cb, Cr */
 #define V4L2_PIX_FMT_YUV410  v4l2_fourcc('Y', 'U', 'V', '9') /*  9  YUV 4:1:0     */
-- 
2.38.1

