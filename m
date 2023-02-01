Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00678685F6F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 07:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjBAGES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 01:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjBAGEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 01:04:04 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2058.outbound.protection.outlook.com [40.107.6.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E2C5C0D4;
        Tue, 31 Jan 2023 22:03:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcClNI4LI6LIEkaTDBmtZaG/eLHB2IorVoIdQ4aavxskxq3yEbb0br0HZCemxktdjPbyy4b7yVLMK7Ao6iuA1Qn3qend/MTkjFAoEQX8GM5zlnUme4tJY28nOouICPCOpghaseNxU7Lsj7a7CrWjfdVsYEXCdNW4XjcePr+ngQuows0K10F3PLQjdKzl4stSmV/RnTeQpQRwM5d9GqhaLa7T8T65sFFXdR9mALPwctVmu81SBjas0lj1587GLA9CgsjOowWuEOGBZtW2K+lCfOKAIerdGmGdPUO7xTS6zpiDTuuF0eCm4TvNYrO/Ok8bVBWuYDzNFdvfGfnsl6n5Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzOpO02wOeajZWbfxSVroeD/TsCs0KSY43KB9xfSf9k=;
 b=RcA/4p3iUtBOI5nq0Vox9apaa1eIZ1o05k0uRSF2pOu9C0DkSiaoCMYmhPi4bh7g7EzNzN6MWyXxsBHAYay9Gw8vDKBmCXUSZhqu1tvimQQN46gMCo/QEiLB7a9kMHk2YDLrP/tTj4fUqLzxAKzldq3a8orebLNCWo1+zyzS2/INhgzqLWb79Qfcapd+axVPM//1Wr0K2N/HJaBZbXT1RQyiSNDylSLOV3pirTOINhSqPaEAz0hOQmJDTXV+TfQdUkOMAFwwgNC6rxqpBk1d/51UvGY+yiAhRlERN9dGqGXGfdrvljW7mqHrPEuuq7syjZo6rbkhUirY68RkH7I/Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzOpO02wOeajZWbfxSVroeD/TsCs0KSY43KB9xfSf9k=;
 b=JVUPBWkC+p/ILuNxsBoyGx6d+juzAfPXnyElX7gmYFiOOV0ZUEU3900jPxBdU44mPrmEy6DeNJRB7taja7kNPrEXy3i09FfaILKj95CH56wiCzz7I7Yj/bYme4MLs0atg58YIHBzJThlXGXlWqpA+SYR+4MAkkOeEYns5ZqC7fE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 06:03:41 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 06:03:41 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 06/10] media: Add ABGR32_12 video format
Date:   Wed,  1 Feb 2023 14:02:28 +0800
Message-Id: <e09312997dbc544a69d687fba213c096bcdfc3e9.1675230665.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 632d3ac1-3583-422f-53a4-08db041a1183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uk7WvzQ13dvwAO9qCe1bdS+rFHd+GW4YQkYyvebT5XqQL6EYPWw7vNrabVkGIvFa4efLF9Gx9/8oizdOY4gGiRSYbdjtLVCfErTv9pnE8l6XooCsCT1n33DQLn/rRuSekjhhCAL1klCLMCAVpfibd9OYx+jaoyFWlc6aYN5V+8y+rhw45vremldCIywlPE0f0qWDlvHMba8+QwiijrU7oCNunp4f2JJdFLi+nscs1tkHHm4wFUi5dKg48SYRf0KHGyRb8l/FDyKItGlEeHDXAa/w11c18uKvGXW5BF5L3E8oIrnJcVez4016tFttnl3aCROub8z1Np0IoFsCOyZKG4WhmwgrZf678T4AX5PyXbctMTg5yur5G25DsYcr14cwNQdQWyF3boRr2eJwbL+XghWFcIExkASCOMvYpYIkydBdQLvquXDCkfVQqc4d6IVQNYEtrmpU5YEbjVXJdV9aJ/el/1lrKHS/A1T6jaodcX6vU7pU4k/3DjBgm72fl9/bv0NPnEXCfYWKncZyebI2GAc7noUyEQH8G4dmeYtUOKTyoBIDtLqcFnM9r5IRahYvC+kEBcuuN7sVq7pe9Z7ERm35ZE+YpeCzSRRHG12FFnvqQtS0IgDoE4Uf6kS0tyskKDGIRrG+CW/aUNEezJZsetvirege02IxOkWun8J085gNLWJ+nhX4/kKQCeaKLojGgD4cdby1vl38oHH+zA2udQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199018)(38100700002)(52116002)(2616005)(38350700002)(36756003)(7416002)(8936002)(86362001)(5660300002)(44832011)(316002)(41300700001)(2906002)(83380400001)(6506007)(6512007)(8676002)(4326008)(186003)(26005)(478600001)(66476007)(66556008)(6666004)(6486002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PR+LqNn5dY0JUMhBTHy4aVDmmrHknC8wUWpa/xd/xCdzmirKMqRRc4cAWZ0A?=
 =?us-ascii?Q?hZ57Rvw6P6jC89ftaXXDBsVDWmqcVtFsZ9BbrLj+BoC9/eoKkIKvGsule4Gg?=
 =?us-ascii?Q?WkQKY4dx2vbGCVzycCViGSwiKjSSY+LtgWt+hU6zNH16Yz8c7RaSn61IlRYl?=
 =?us-ascii?Q?BA1QwA9E+MnVLPRI85ivgF/DuGli8gjUMx4iaxfZ1VXIg2DoYbhxEbtQvdw9?=
 =?us-ascii?Q?5VUAaqjvI7T+xaWn646a/0rbSPIq/Q97uVBI609xdDZbo1vOGiLN03atMxEk?=
 =?us-ascii?Q?p3Vfh+EJbn8H97IokIG/bZn9fF5dSkIgDLHoS8K1M49WSaG0SAToa0pYrak+?=
 =?us-ascii?Q?EOp+t48r3DCz/dEajAjLYTRtKZra45TS1VaWzfbTW7oJ+0/R0DKn/jooVSAm?=
 =?us-ascii?Q?2SlsAV8mtbdC73RMzwqdo0iTyf3vg38kE3rJSVqUxo4hzy+EJi0e8xncCR2O?=
 =?us-ascii?Q?Au2ZsoAx/6sOtH+FcgMU/mlY/B47qWkfuAt/SuuZLUPyODvg5q7vpPpSquQo?=
 =?us-ascii?Q?HRKxwtZyANhmxDHbX5l/QJlmdjF7+tCi5ZEY7C74cL0QlGTb9ydiO5UF/dDN?=
 =?us-ascii?Q?o5KLoDlJhW2hjSYCTJ9BBIpkdWHghH/xmI3Po0DcakJ1Y+MGQYqfh5z4ugu0?=
 =?us-ascii?Q?nVKZLRi3eTPVXWZr1UKnNW08T+9hcKkuLJn12ve4apgbDycrZKZoYhYfgwEP?=
 =?us-ascii?Q?lgnqT9O1M9fmEvSzreJsNBDAFsrA8tvHmFd3g2isQ6INAYe8m7ZdViTJYyLN?=
 =?us-ascii?Q?nNVhCMojlIXiOJspxuNz2No0oKLx31hCaFe83BdIWE1olhaKwkGxwFfWBbSX?=
 =?us-ascii?Q?kp7oujOgIufKcLX90KwpT/2r3F+3FGzYmmUr00pMLzcViJg6dTRSYKl5Dv2T?=
 =?us-ascii?Q?aPmDQ5AJ1452wVu+a8LLVvbKo4Kpz/p9jI5gzKALIsodESKmyiysDaDFQ/py?=
 =?us-ascii?Q?YAsgrZBUheMks2HicWdJ/p9LD2j5b12fFaOM3y2IJa/JeWWzq3a/hCXpqX/o?=
 =?us-ascii?Q?pLF9AUrkpIv7RNMXzdFL6uLaSme3GSLMVl4x9QfVsE4OvQ9SyMwKPeqDfP8G?=
 =?us-ascii?Q?BMvrIFy26ECe+sh2enY9IwT+IVHSaA5FvDkNbC5pVFv5zyH6Ud4h4DZGV3jg?=
 =?us-ascii?Q?22llHfFIm0Jmr0ZaiIsB/kzBE9cEHryehALHE978SshLaBrhtTiICBLWP36D?=
 =?us-ascii?Q?uPsUnEhsXEI+dzCadtkhLRnXFzDL0fKoz7nq9Io3yawL7OfYPWrMOIMxkwv+?=
 =?us-ascii?Q?8gZy5L6JNz9/P8goeo1AoefUSv5c0qSHMlM3/wulZTBljsxvyoaoqDXxcgYg?=
 =?us-ascii?Q?7PTCdNPR8V5/F1jXfxFgeoW9b8ML/e9y9oh2U1QBrt4D5heBCsjcCFDJe+E+?=
 =?us-ascii?Q?duzpDXKsk2gyut6/IQtst+bDo11VsySV8Lja6xPTvQPDd39711tYYEOITOI7?=
 =?us-ascii?Q?wgIet2c0milPZoEHD12rb7jUjTpWL/SN1bM4vDi/rCPyukgDpabQ2+XmmQvX?=
 =?us-ascii?Q?djzRid7i3u88Wsp6AjTPMGQsYlGOk70vZC8RbnwSNiHF+uoh9e4u8keg1VFF?=
 =?us-ascii?Q?LQOD6zP34lr5oWQFvw3IrUct2NuqIfKH1jnifRH+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 632d3ac1-3583-422f-53a4-08db041a1183
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 06:03:41.5349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8U94Pc06nXGYjNW/jdD28D03pQ288o6Uj7uKUmWUMvPez4YcRUYwTDSWjCgy0H5AtmEiGeuqLQnyGbmuIYq2g==
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

ABGR32_12 is a reversed RGB format with alpha channel last,
12 bits per component like ABGR32,
expanded to 16bits.
Data in the 12 high bits, zeros in the 4 low bits,
arranged in little endian order.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 Documentation/userspace-api/media/v4l/pixfmt-rgb.rst | 9 +++++++++
 drivers/media/v4l2-core/v4l2-common.c                | 1 +
 drivers/media/v4l2-core/v4l2-ioctl.c                 | 1 +
 include/uapi/linux/videodev2.h                       | 1 +
 4 files changed, 12 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst b/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
index da29ba69c2d9..cb60ffe8f860 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
@@ -793,6 +793,15 @@ arranged in little endian order.
       - G\ :sub:`15-4`
       - R\ :sub:`15-4`
       -
+    * .. _V4L2-PIX-FMT-ABGR32-12:
+
+      - ``V4L2_PIX_FMT_ABGR32_12``
+      - 'B412'
+
+      - B\ :sub:`15-4`
+      - G\ :sub:`15-4`
+      - R\ :sub:`15-4`
+      - A\ :sub:`15-4`
 
 .. raw:: latex
 
diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index 024190f82cf1..4b3302a07f83 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -253,6 +253,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_RGB555,  .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_BGR666,  .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_BGR24_12, .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 6, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_ABGR32_12, .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 8, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 
 		/* YUV packed formats */
 		{ .format = V4L2_PIX_FMT_YUYV,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 329515786abb..0f772e19890b 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1299,6 +1299,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_RGBA32:	descr = "32-bit RGBA 8-8-8-8"; break;
 	case V4L2_PIX_FMT_RGBX32:	descr = "32-bit RGBX 8-8-8-8"; break;
 	case V4L2_PIX_FMT_BGR24_12:	descr = "12-bit Depth BGR"; break;
+	case V4L2_PIX_FMT_ABGR32_12:	descr = "12-bit Depth BGRA"; break;
 	case V4L2_PIX_FMT_GREY:		descr = "8-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y4:		descr = "4-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y6:		descr = "6-bit Greyscale"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index ab52a605e6c0..757ab14e7a6e 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -579,6 +579,7 @@ struct v4l2_pix_format {
 
 /* RGB formats (6 or 8 bytes per pixel) */
 #define V4L2_PIX_FMT_BGR24_12    v4l2_fourcc('B', '3', '1', '2') /* 48  BGR 12-bit per component */
+#define V4L2_PIX_FMT_ABGR32_12   v4l2_fourcc('B', '4', '1', '2') /* 64  BGRA 12-bit per component */
 
 /* Grey formats */
 #define V4L2_PIX_FMT_GREY    v4l2_fourcc('G', 'R', 'E', 'Y') /*  8  Greyscale     */
-- 
2.38.1

