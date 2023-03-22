Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E1D6C41EC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjCVFOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjCVFOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:14:41 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27D250FA7;
        Tue, 21 Mar 2023 22:14:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=no4A0juhGJPAqO+Ds7UdKv72uYmEKNnu34ba0yPwPPmMKL4TEfy0fcF2ifoxVRssC2tbgc/5tgto/Xj1hKP5SxBu+otPQ3MtEAS+44TERDLUf3NtRztXSPaYfs2VR7sIzeqyGjGXxNnPplUJrIPnQYVrSLDKCKHWXi8Ru5T9cXX8WkclVXjztjtCXTas5d3IgPwpRX22A/f+I2E54VnWoMnBcvhqtsxyslxDaE/1spOnuftRkUCSHrg4ORbZlB9zSB8skfJZqfM6NOxxGjIxplBmpMPh7K4iDVIYkWD1TrRuR2va+I645cMonowWTRk5RcuJ2rbbDBff0yz+YDc58g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bg8E3rFasrAzSgljKXK1Qi0OQIn5iLNLHNqDHkzmrgs=;
 b=kcQiJVW1TG7rdUXu7OSlgXD96WcEKRPNezwC7ovdoPQJvI7kekmW2xcjrWgPYs9+wFcQ4LlWlSAccHriY0xTIi8zIovXfyJ/SBcdraDD3A53TcURojyYGG31GwqCn+OdRu3gh8ndf2UMiLlaLDFr9bIGKJcFXSs9c8WlJXlSYNrEY65PsliFXJZuHlTvNtof1fZuYEjFaxcptsTzrR3hOi2FzTg/QzoOlsijI4v2dcHq5es1DHDphtvXOCA2yFb3G+5K6F+Ygl+mwgJJ6E0+38QpoaRMMZ7dO0agJDsxKchPg5+f+59hmGOecpqm6ejZDYRPcbCCR1cJYwsKgfFfRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bg8E3rFasrAzSgljKXK1Qi0OQIn5iLNLHNqDHkzmrgs=;
 b=rh/4CrsiEAC64VbIJfiwwljkqBCrAHfLVcS3M269vwCQPGfOicS8Il7+9InH8O0+w2PexsN0H46SNWj/PFoGPdoMfZCtFEXttoMCUJjRAaEtOanSgvhXqz1rlbQz+3PHJpkR8zBGgdNYHJlqJmaiGE1uHc3ncfmeK2TPCV4qUTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8100.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:14:05 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 05:14:05 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 06/10] media: Add ABGR64_12 video format
Date:   Wed, 22 Mar 2023 13:13:09 +0800
Message-Id: <9c250d2e65405d920d2918521cc86f47c7e78ec3.1679461710.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 960ff9f4-c4e4-4a57-48b9-08db2a944220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gi72wmAD8VEeZzyjn8XJJ+iXJUVe5+d6rGO+9R0TwB3epqhyqN6EtVgpaizdwoiTLLBcu9n3xmBqBLpl5/5PJ6tu1E3FybOjMqhjVIrbVBk4lyvz54UeIfuruUJuzFI7lipSeOfwHij0SEM/GPk5AV4+wHz/Qyl85bsoMicYXJLFwUYBTHVb4OK1+eNInV5Bz9f+B/xSfXOIOW74NPqbVx2J2WRxwkhch4wg3DcftwCRCqXbvi1xW/DlMXrGukdoZPcBeUPsaCTBNSXGdl8motkYjfycjZgebx9sC5szs0HfGFcvQRpS7gh05NN67wsxf8Qb9b5szsOdUelsvm9IMvVJXg/ZoNHUnpxqy1Fsk+BkVuId/LvWhuhRR1AmZ+hiZWWmfqw4hn6Ir16Ljl2JI4o7fpiUkp64CRlddK6vri/zEHxT1RmfWwRk6OhVrLLK6h9Mmv1K1kJszStxLfgn46uYVYbfbBbwzf8sKMm5e7tR83z5V/ThftOkFPmUOlFiU1UfE804j9lCm3U5cnBBL69k4on8hLOTBdlTdl92RpeouYM+0DOcK9bmfnVJRrwpJrt3uJe3mtPKkCCe5frKd+pR3H3JHcXeurP5TAyAM1cGa17by9CkQYu5oofGSbevNFL/0IIMuUhIrDYIXXdD3mrPRIAmBcnW8rEyJc4HnCGup/rZqopVbO/j8GbhHVpCWAZk8QsKBfpb4TTNyiQPFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199018)(6486002)(66556008)(41300700001)(52116002)(66476007)(7416002)(478600001)(66946007)(5660300002)(8936002)(8676002)(316002)(44832011)(4326008)(36756003)(86362001)(6506007)(6512007)(186003)(26005)(2616005)(2906002)(38350700002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UCBugjvHGnVM2+eNSF7NR5y/3ap/1EGsROTTbAx3yFj+adAgeXAuIBSANs2w?=
 =?us-ascii?Q?pvwuyl+gZYFypiW4ejyJxOwGAcgMiSPD63F45tHiLCKzWEL38iAY+Qo1SfkD?=
 =?us-ascii?Q?6BOMPA2a0xyLW6df2SqpbCedRE21tJkcKVtW1fSozGOLrn6u64eUuRQ3PUU8?=
 =?us-ascii?Q?Gfa6jRZKj0HBlKn7W89JKE/wARLu980WrIfwax300PPESBu28JO5n7RpCBM5?=
 =?us-ascii?Q?zUa2QKyqO6NBVH2l9RXKysBDWNFzxwc8epkq/LWW3wAPtF3Advnp/x/cPgkR?=
 =?us-ascii?Q?wTJ+PgMS4ETC7bIv8kRoW8of3ksZPHzMSwmLxmjuERwT1MuBCI4auDVmuBer?=
 =?us-ascii?Q?CCwuf04xFeqIm8zBz9NbPcG+92Y1qYq3zTOx6SwmQ0WBX/uaTkMiyrQOBlLg?=
 =?us-ascii?Q?vn29fUz8y+tlqRaGojO/YF3VKrbSR1FINyhTrDa9E25WIp4a+l6KyPAcJsB7?=
 =?us-ascii?Q?3FFEvIGmLyuUCz7RpzMNEpoRXIwFZ5U1rUKPOw2O4lRUHLVOmZ3Smjlld1Eh?=
 =?us-ascii?Q?Ysyf616fm+bHcMzEOaPETX+sJZUj1RbdJ/UxVIEOHIGsjyz7BFXm/4vJOYHB?=
 =?us-ascii?Q?Ma2PkPoSZeLcEPqQsoMQZ6MFNF/VHk7G+ctNvMuhIGhNaTogjZ5RPRvEXT9X?=
 =?us-ascii?Q?5dAHZSqjy+uThj7JXzYdwXZGhjrO9QqvFrCPaYMVRaIFqHi3akGSL6xBrH+u?=
 =?us-ascii?Q?ollKoaQWHyKSB/riOCMRl41T75SaE4YsHtUa3S+K7oiDQBf/bhrHUvD5jih3?=
 =?us-ascii?Q?ko6e9fiFM81JLcykDc0afFqs/2O2T33wpFEgn/Rxi+P6jureOAeRfFgBMlGm?=
 =?us-ascii?Q?s630PWexZLfGGcrlgEF0ZqH3gYn3hcN6p7mgV3Ru/yy62JMc5TRZcjifoFI+?=
 =?us-ascii?Q?sMX82WUdr3F4ZI+D2IrJvLTmh9Y5aibJSd3QKZWGMCA2vmBF6w1spHagWTbW?=
 =?us-ascii?Q?a1YL429T9wmszO1ti+/BaJCgtkuaS7+jXzFgkeOjboG+f9oxnJmtT7grKCEo?=
 =?us-ascii?Q?jiEP3VJRF7xnXnlAVJyyEMhdR6ALQmspMqnP9pkqKDOmhu0L+gpz2OZwl5zu?=
 =?us-ascii?Q?zZxXeW9qJLCAZByAJ7F1WR41z32HRrXr+CVFSzpk0o16EeylAyGebWKxVvg9?=
 =?us-ascii?Q?r8VnMh/U2Phe33+WXoBG7Ek7NEpu90+uUSgtTpNl6Sil/I+AgTg7G7QtOJRO?=
 =?us-ascii?Q?gwkqsF68l+rpMWxAS1w3o+yDhxNM0BrLJRNqlETtNE0EcrEMZh6gMVQS2ThN?=
 =?us-ascii?Q?mBk2zVnP6Ais6RuLd1gE1uoW70+ZGXIXZAsdupefFtj/nSh6zEKzym/JYUVu?=
 =?us-ascii?Q?Jb7L+MToE7G5R958+LNQ+2vEwr0TZrXsG27XgSQHOS8Pg3FQbfjVuwv94cYo?=
 =?us-ascii?Q?mzmtfu8aYGW07npjmKnPOlfdzDRKUZ3ti1hualVG5zXTF1hiABrvXB9yw07l?=
 =?us-ascii?Q?sGBbPoprZHSGdX8XaA7tB8ms597IbzG8Pb6Zf7P/luaNBRs369PhkjUBTDNp?=
 =?us-ascii?Q?CF67emeRB2eChsmBvLM6O/FtxRQY+B1L6i8mAho1iPfXSvP8dIsBIUZMv8oQ?=
 =?us-ascii?Q?107HXNNvB7lkCmu9JiDF9bQIOn5OdWB5x3JUQrdT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960ff9f4-c4e4-4a57-48b9-08db2a944220
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:14:05.7714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5tNJp0zxgySRtbZrPQT9LOpbLF2uUA2HZSjNy13wfsFtRtKOP+M49ktHgyDddrNeU1u9XS3+PYcZVT2TxXSRtw==
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

ABGR64_12 is a reversed RGB format with alpha channel last,
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
index 779f0bdda642..38811025d71b 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
@@ -985,6 +985,15 @@ arranged in little endian order.
       - G\ :sub:`15-4`
       - R\ :sub:`15-4`
       -
+    * .. _V4L2-PIX-FMT-ABGR64-12:
+
+      - ``V4L2_PIX_FMT_ABGR64_12``
+      - 'B412'
+
+      - B\ :sub:`15-4`
+      - G\ :sub:`15-4`
+      - R\ :sub:`15-4`
+      - A\ :sub:`15-4`
 
 .. raw:: latex
 
diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index 16d3c91c7da2..3c5ab5ecd678 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -253,6 +253,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_RGB555,  .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_BGR666,  .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_BGR48_12, .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 6, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_ABGR64_12, .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 8, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 
 		/* YUV packed formats */
 		{ .format = V4L2_PIX_FMT_YUYV,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 3490eb3f42e4..b87c7d24d3bf 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1303,6 +1303,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_RGBA1010102:	descr = "32-bit RGBA 10-10-10-2"; break;
 	case V4L2_PIX_FMT_ARGB2101010:	descr = "32-bit ARGB 2-10-10-10"; break;
 	case V4L2_PIX_FMT_BGR48_12:	descr = "12-bit Depth BGR"; break;
+	case V4L2_PIX_FMT_ABGR64_12:	descr = "12-bit Depth BGRA"; break;
 	case V4L2_PIX_FMT_GREY:		descr = "8-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y4:		descr = "4-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y6:		descr = "6-bit Greyscale"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 3c5acd72606c..a6df69ce5cf7 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -582,6 +582,7 @@ struct v4l2_pix_format {
 
 /* RGB formats (6 or 8 bytes per pixel) */
 #define V4L2_PIX_FMT_BGR48_12    v4l2_fourcc('B', '3', '1', '2') /* 48  BGR 12-bit per component */
+#define V4L2_PIX_FMT_ABGR64_12   v4l2_fourcc('B', '4', '1', '2') /* 64  BGRA 12-bit per component */
 
 /* Grey formats */
 #define V4L2_PIX_FMT_GREY    v4l2_fourcc('G', 'R', 'E', 'Y') /*  8  Greyscale     */
-- 
2.38.1

