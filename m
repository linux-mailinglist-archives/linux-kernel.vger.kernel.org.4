Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380AF651966
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 04:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbiLTDNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 22:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiLTDM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 22:12:57 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2078.outbound.protection.outlook.com [40.107.15.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E1114029;
        Mon, 19 Dec 2022 19:12:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wj06yuuK7kOhtlHwm2hO2nlnA7Qzy326xJ1prgFG5WgNVv5FZcLzDADlLFZpD3q7gnfWlG0HOI8tyEemk+Xbk00cwAjFnVjHFtmDon/i2WjvhpLLwSbYClV0rlMuBKfsI2ssntsWLh6twSYkG3IR7uA5+8vbQBCP59H2kxbiXXaNfKzOXM69OwDGmJkS7bA6cLTI++UicX+tnvC84C+irngpXAfqISZZxBqBp1wipaND0MaIEHVpnMObnkD79OqujaVEi7pyidSvUnaryuO2xBY7FE5eoBTTwI2lXgMocdHqulgQNwOnewRd04f9W7ddlh0zwAPK1f/y9q49rVA1pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5EcEWx+58L+wG2ipe/BlV2BSRVp6Bv8Ai9LEw9dMAg=;
 b=PoeaedfCVQ6qurghj6b105NpCwUciqu092jeBNNkQbJgZKohhAjsPU4ORUj35w0VeaQdn9GUC/35/l52WGYsiG93JVtFRs9SVE2oBrWNFzlrV/sXYH8znOLgnPG1QF47kR+/4wjfJNjpU86vz7NsLvS4jp0ViTEgf/uBsmdI1IA13QbL9U1tOhQN0nvVAXg1ZMsdo+7pqcs6QlpjW/SDdZ0r4VIqifsHFiQJp9/WsD8hKmMMvkzDjNdRLe8b+C2wmOAT8rC671w44cE0IcFKRtYtKixBXE3gxgmo7Mn15f4JLo/g3gqjhzMXzsAetDj4nS8IT/25E22IxY8KcXB9dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5EcEWx+58L+wG2ipe/BlV2BSRVp6Bv8Ai9LEw9dMAg=;
 b=F3utPRgyDroXt4T8oxVaaA/OacfBBUNsZd7z/hrIc2wGIxcLAy28gzmMAI4B8dzH7yaL9ajt2vEGJ+OvDhtBxJnbMMZ7yTpwgoLdt7+gVzNpmHiIxJuT+muBIaqzRkY9QwMSuPEOxaMg8A1DXSzEBCfJHNCL9NCFV6zTEYsos9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS1PR04MB9405.eurprd04.prod.outlook.com (2603:10a6:20b:4db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 03:12:36 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 03:12:36 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 05/10] media: Add B312 video format
Date:   Tue, 20 Dec 2022 11:11:35 +0800
Message-Id: <a3ae7c29f0c2c8e86f2c35d50a4b9cbc432c6cf0.1671071730.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 345d7bb0-c469-4602-4025-08dae2380b0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FMi5Cf7fBc+MI+QqFHyKqrHjxOJ86edkaHcSLUlL+Db3zXg8wisFGsyxwSbEJZCFzewGse0RuCzft7Ekr1PWda5tPeZOB0ZP8fArOGzmpXp8VDSYjBVUCE3ubX8urq+UOQYUHgF65tjWuog61ohaSK0O4VdJihriu43NWcAne4GYCI0TV2YYCKYJQu7hJrYnCbiWMNn8fQbkU2BB4ToLy22MBjkmxqriS6HH10R2UitYySI33k3mw9k7GK+467JDfct9GrAjiF5oHmNNUtoHr4SZCFebSGx/yq2QQ1HfAZTbDYosHMAhkamui3BE/bpzUUqdUcNFmnNRHyRyUflg77H7n2n/gjbUCAzbWQTFsnOILt+ez3sqzR+OwV9HsQTJT8smKXyK2g1WXGrpKGV/FYUn44WMrvi2odxvi1zrtPNbm6lRa4LtoqwjB/uJiUAbLJj8icuJYvuSZ6mcmP5SdC9SnbiVJH+Gku4aPvQKJ3hYRYMsx+7729rMkVqxlK79/jmwpl1nRoZgQkSg/r/bNrMLT9/gqtqs1ZpMBS7VwfeGbtPkBqf5mH51wACmy3SW+HbbbhMul9ICNYqfNyR/PnE9kbIGQ1t35e23RDgF/JJF1ufwpIU0DvuWkjredHS9k6u2/LF7pre+4He3hFPfkmTj3zvtCEaxzNUiXvYQqzj2lzJNS1AodWV3f97nJK1nQ9G94libdstLhRmQxNdl3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199015)(36756003)(86362001)(478600001)(316002)(6486002)(66476007)(8676002)(52116002)(7416002)(2906002)(5660300002)(44832011)(66946007)(41300700001)(8936002)(66556008)(4326008)(6506007)(38100700002)(26005)(38350700002)(6512007)(186003)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FJ6gJQQJV/HHUNhVl0xl7FgbJ3mHBk/v3AluAvncmweP3s8BsMeuj3Vnv/4n?=
 =?us-ascii?Q?ldo+XZqPhNaXbksYzVNFBo7/PJhwqLEKyLnjqXO8t+URNSB//rkecLd4W46b?=
 =?us-ascii?Q?Vm6qmC/SkNl9Ibmr6voJ12ifuwIPqdwdf34pGsEHk4ualV0iHyKqndq45sdU?=
 =?us-ascii?Q?q6COWA9qd6W/jZwdsj6m54rNDMyDNcmgM1Ud95cP81HBbkF9T64Xz6MObUNq?=
 =?us-ascii?Q?W+XPZe1LCrtTYyXSH3A+kTdcQyVTQXBPA+HAmDTTtflm6mzpibvwbjKTCQv3?=
 =?us-ascii?Q?ZCXIIC6HDgQK6CZYVLXXgKYai/w8fJmLj6oy0qmztjAQNmkxBrNn1/FanoUC?=
 =?us-ascii?Q?ndKI+MhVYGlKElzdbfBrUDKNuBupoAhWSIikwHJCuCEh1I391txzPQ+xZw91?=
 =?us-ascii?Q?hmAB39G0KY/gQcULJDvC65nkl62lpz7I12L+/cv0kDllF8dvjeil8sm/hRPS?=
 =?us-ascii?Q?KIlimKhYEsdET27kpY6FZAX0sPOsINikIGKfBHEuLBpXh/qEGelCAzjCM/AL?=
 =?us-ascii?Q?sxdot5dzzibQg4asnivd/0PJe2mc0b2K+AE5On3jRXmPX+n3P7CZX07rB5eD?=
 =?us-ascii?Q?WR/pcQ8yOVJC2I1yB/b5LOlknr+0UxiXdqWoj86IE8dw49AW+f0GqqtQ/aJn?=
 =?us-ascii?Q?kpi0cveZrq+AKCdIzMuY+VlQc55jUykrqhEJW1ObAHt4oEehEX70PTn+HbFh?=
 =?us-ascii?Q?Ur/ayvNibrOA2kOtnzNmM6+QjTILsiIDAmGuq5YNzBuByvOUlza4YypOmOSx?=
 =?us-ascii?Q?eM6MCYwEcXwwrikZOUuJ1kPEx3vbD7DyPtP/sgchDLco5lnxZ+xWCAKDd6Ww?=
 =?us-ascii?Q?sMqrv608yV2rwTk8bdpWLmFI6//YoepQ6pgCCJkhn6L9oqgkTObtEC9WO4NU?=
 =?us-ascii?Q?nxXecQ2MKXiq+tNr13xQxa8V48qgvVmXOvUS78S6EQ9pO8ipnc4xoCKWZRDU?=
 =?us-ascii?Q?6PHUS/cFqN6+Vr/fUS+qZofRsjRMdS1Q4kSTOa/DxtOW1Cz3exh6NIVIx48G?=
 =?us-ascii?Q?TaqBP5tVjo5eedMjPn30OtaODnE7Tf3EIQfrBLfSzSFFUwuuBLsKZaNUr7oz?=
 =?us-ascii?Q?Ebjwciea7gkXw8ZHrpodf2pgid04MH0SNj9BwwYLKuAruXPFaQzmMYtkn3+U?=
 =?us-ascii?Q?2hqkqqoly1aGzfLWmd251pNjCz6hrieuqODMRyvV+9xW9Gw0yabUpXUl92h0?=
 =?us-ascii?Q?dAzOn5KK7v0ke9hb1HxhflFHwPJgh/DKgo7dAq0m2cwLajScjqyw/8MKbAe8?=
 =?us-ascii?Q?2FyMigfETBUBkOgX1EuW2NUHHa4/hxcYqkA/MN46Hd/sIL0k+gsMvOUPce83?=
 =?us-ascii?Q?qA9Gt9oQxG/B5HlBul8PkB8yzUwBBDd1kLTdgW3SSP1wF0O4e5Y1l35RG7AY?=
 =?us-ascii?Q?aZ0iFWLB+YtROb0isjpF4kQ6XIqvVpSUA3GeFIPNHmxv4QNPBrsJLQxhCpv9?=
 =?us-ascii?Q?G+NYGt3TX1f5Rn0RzyhxCYFNfh8HrKvR9RghRcpCwZUzTVf+VKJbuxjw70/4?=
 =?us-ascii?Q?Ih1KhkhcK1PL5Tfif4a9EspqshAcxDRris9d9fFYeulPb0TaY5RvUJ8Vbbj/?=
 =?us-ascii?Q?9XwSg3S6Yphm6jpWsJ8xsFX0ccAPsoRUZCOOBtcq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345d7bb0-c469-4602-4025-08dae2380b0b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 03:12:36.0022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZyj0k0QlehAW1RoNg8r5bSc4VEOJG7QN0zudh+cKWjN9kSHuz+A1Okt54RGY7C1mhoEsepBC9pVdLSLYiEV0A==
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

B312 is a reversed RGB format with 12 bits per component like BGR24,
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
index 30f51cd33f99..f7785c93292a 100644
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
+    * .. _V4L2-PIX-FMT-B312:
+
+      - ``V4L2_PIX_FMT_B312``
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
index 332d4b11bc1b..0cc58abae562 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -252,6 +252,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_RGB565,  .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_RGB555,  .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_BGR666,  .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_B312,    .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 6, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 
 		/* YUV packed formats */
 		{ .format = V4L2_PIX_FMT_YUYV,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 5b97d7e5dbbf..8c3d40d3acf5 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1298,6 +1298,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_BGRX32:	descr = "32-bit XBGR 8-8-8-8"; break;
 	case V4L2_PIX_FMT_RGBA32:	descr = "32-bit RGBA 8-8-8-8"; break;
 	case V4L2_PIX_FMT_RGBX32:	descr = "32-bit RGBX 8-8-8-8"; break;
+	case V4L2_PIX_FMT_B312:		descr = "12-bit Depth BGR"; break;
 	case V4L2_PIX_FMT_GREY:		descr = "8-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y4:		descr = "4-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y6:		descr = "6-bit Greyscale"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 3475331737af..c67f895210de 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -577,6 +577,9 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_ARGB32  v4l2_fourcc('B', 'A', '2', '4') /* 32  ARGB-8-8-8-8  */
 #define V4L2_PIX_FMT_XRGB32  v4l2_fourcc('B', 'X', '2', '4') /* 32  XRGB-8-8-8-8  */
 
+/* RGB formats (6 or 8 bytes per pixel) */
+#define V4L2_PIX_FMT_B312    v4l2_fourcc('B', '3', '1', '2') /* 48  BGR 12-bit per component */
+
 /* Grey formats */
 #define V4L2_PIX_FMT_GREY    v4l2_fourcc('G', 'R', 'E', 'Y') /*  8  Greyscale     */
 #define V4L2_PIX_FMT_Y4      v4l2_fourcc('Y', '0', '4', ' ') /*  4  Greyscale     */
-- 
2.38.1

