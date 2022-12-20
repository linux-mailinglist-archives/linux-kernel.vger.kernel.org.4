Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B9E651972
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 04:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbiLTDOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 22:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbiLTDOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 22:14:05 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2078.outbound.protection.outlook.com [40.107.15.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB72215724;
        Mon, 19 Dec 2022 19:13:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLRQgh0kuLQW9ZBpPeu59o6G04ZJT+KeaCIbWw0pJbMjQJe+STOPWZW1jh0S1D5sXBOjjUWx8n4kJ2HL7qhjF0wM4at+tMP4vhgYeCNeYnIf5KZzvnI9AMyosq9DOI40LBd9+/eIPPeSL7OJ+RT4TDBD2Q/FCGhxBzlc3AktZxhg94FybDuz4M1r+C/fjpEyBOxm7q6uyE0NBaVU+2yXDKddgSWJm1up9csOz4AYfdox5JkPc5SZ5i/3XpJOeDM0xDUsyqeWs3K0TDDZWItqUKWqZevKPZPXadgQ5nTxLkFBmXyBs/SHdJfft4WTDJFzIUMjyDpHJmpnEa96iGS0JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tRRcYWM2F4NhBPurQ8+lVOE3PstoxyoMGzAGY1Gjnw=;
 b=aRxTXxvX47UXhvyBFHmt694yUTq2kyS9htu4tt64EZB9rVcpym9QzLsY9PdizZLuxuRIUGsJoNo4eJAvrCNl92GufzpUHzqCtL7UuE1mm1zDhZiN0o2QczAbySRp0fUrdWgXlZfyvCoa3JlSLMZChK4Xt0H6rBOjgVSURCVnjHszEe7mzCIir4eMK3ydQ/JabiBFByIwIbkxdgA6viuRHQY3tU+SWKrMcic92PT53zXRWf5ir0FfPkYWd95AjbcW4eH2cdbX6YLFqsGezzN5f/7xWEA2tayJXpGsqBDZS2aGpHR1uy04FBNVy/mGucCMiezTaO2mhb4l3rH7w/s0Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tRRcYWM2F4NhBPurQ8+lVOE3PstoxyoMGzAGY1Gjnw=;
 b=oswAB+2CqFaWnDR8k1Ph/7CdAd6yICqXjlRfvNPWlTG1mXP3j95CyNN4DZocnmzmALNgU1DJJPZreCYDwiJKgUj4fWfi/U1/uiB0m7+7L7opgixnH7ztNfnlaFmb4RnKkM35YExIbC0wmrApvXIpuNf78HC73OVPC76dimOtrXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS1PR04MB9405.eurprd04.prod.outlook.com (2603:10a6:20b:4db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 03:12:52 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 03:12:52 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 09/10] media: imx-jpeg: Decoder add support for 12bit jpeg
Date:   Tue, 20 Dec 2022 11:11:39 +0800
Message-Id: <6dedc442a17062f4fe4083edf47839cf9cbadc2e.1671071730.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 72bda074-b3cb-411c-fae1-08dae23814a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k57BybuyNlmaFGr4T3BkjM9gIq+sdPv/MuL0Ho2/36UcUQz2Su+CEfFsgCUJ1YFKG1+9MRL6UDeiy/TlsXBG8K+2CXuMdP0/VoLCcJVmGySLoucPQfJ3lU+J22JnFVZLvkP4CxWuyeBFyuUNHNkffpXJfF34pLZcvfHfitfLKa6ojt2uDMJs/2F1jDhVloxU4qaWoERAGbRDM12DKtbdXnzM/9mI/bTNPaWzygG4I6LYa0oF/DsHvMmXQZofzAj5vbQm+Lzaavttb4IOimRszccU5gTd/gES/UBPiE4R7KusfCTaiLav2feHGud0ZwM7pCutYFL9aggWzBdcI4zbemc0UlIYU0BsJv6V9WYuqbi8MRtsxKUKhAViK+QymqMbFtdZ0z1QNsn3tdF6eUSFdqEKZFciJYAjFslvSpsi5O/4WLniuL6GSNgV3blPJBmf+kKHi5SyUWWD2VL8FvRMlVL2fgAyeja+foB3kyZDcI/Vi/QiMYkNjznwOH0q86sgYmZKgUwmgGGcKGVU77LD3lXo/dDyAZbmLy4VlmZfdForqa9tRxsrRkyz+Pd/NMByzbMZKZZwil56cKsdv7hwwW4TbFZbr0fxUE9tzMs8lrc/d+VCEZ6wsUzlnwustR4VnCzVYLmCX+a83YmKGzAyhn5rVoVaGawxb0vty8oN3ogva3KShAU2im35iEOkPWffZxwL+ie5bUA5ik0G7u847w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199015)(36756003)(86362001)(478600001)(316002)(6486002)(66476007)(8676002)(52116002)(7416002)(2906002)(6666004)(5660300002)(44832011)(66946007)(41300700001)(8936002)(66556008)(4326008)(6506007)(38100700002)(26005)(38350700002)(6512007)(186003)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZEVGdQoNQr2TKseV78LE0l8QFhmtEvyBgwydINz7Gd8r8f1ym5sgoYwRqfWM?=
 =?us-ascii?Q?ZQDsJsYlgxlRX82KLH8XCka7EI93aDnrdPf67OhnjeCVRY9ecWrZp4KKI0OP?=
 =?us-ascii?Q?bfFm/xyKNCrPFSH99zS26RqqUojkZykydsZRjytig8/5u5RhHIByqkfu+Wsh?=
 =?us-ascii?Q?W+o9rWGQA6J34kDb3KwYbiZjoSDj4FG2Dd6KonIG11HXZzqeRpI+6dYxn6Zz?=
 =?us-ascii?Q?LzQMj2BEEruSNmXBE9xHbzN9NYg7N0vZWGa/rVDBrSST15LoV94nKrSRE1ai?=
 =?us-ascii?Q?bwgrp/LCGxvWxgpNXW0chXYKCZ41sVtvJMLs3bVrv9mztslucfAgruv47VrK?=
 =?us-ascii?Q?gVwAhe0rG/kMehr2mmiBYTF74TjvkUjywcZf3oEkEVV+BWyKS9jjI2E+dsxo?=
 =?us-ascii?Q?krGwfmZ6a0TigcKAWSPW2bOBEG5FK+UkposufqFsnE+kncgPOQ3LGmf7kpaO?=
 =?us-ascii?Q?SV0FH9yLZSgV7yXhfGsRoNVb6/X2I1or1h1lqvXkxyHu9v7JkCmT3Kdmu+p3?=
 =?us-ascii?Q?BPXXNA44xdZxtFa/C30iz2p4daLMB78CGSZL6gzjFouAPjiMrWk7mC/OLvSy?=
 =?us-ascii?Q?O2OvIiw0X931+KwO14rFkluVA1ENAsyUlrTUVIQhg507PK7pDLbKKMe6SrJs?=
 =?us-ascii?Q?Om6h2TFteg3aEQ5t0tZ/znFBP295VmzUVafFtT/0zcnGOoUUi41lGn64CAF5?=
 =?us-ascii?Q?9mshE5JdtnTDlGbwLb1QmpnFj5H0M+Hd0IkInDUo7hZk5+mYMTY/vd1rGgPC?=
 =?us-ascii?Q?fIRL9QEU6St6yIq/LOQ06fOdN7JNf9mBQ+I91XfTnXn9kBnv9Okc9j3Ub4Q1?=
 =?us-ascii?Q?kGmt0/gmZh8B/E018FAe+nrpahviLx6FJthsjZsg3slxf5UukZAy3e8QwoM0?=
 =?us-ascii?Q?0t4W/3dEnVfj9VJZ7OEAoJTkJ7RCSRxegCP8EeClNLq7JIVyTvHti6dXoGMH?=
 =?us-ascii?Q?+on7+VwmzqQRXrAzys6AtyqCqegNAWm4A4Pf9OmFeC6v+YISsAOELlK0C5UI?=
 =?us-ascii?Q?pzIfaMPsCSSYAu35cjmDMrJ4SPriRXAiFkUgumC0f3OEikuT48Tg4hoKYMPO?=
 =?us-ascii?Q?RQ3oUapUTaJsVj6+DxX1TZciNbV7pGDitYzajKuC9Yvw7zB8ttkyy+NP9cB5?=
 =?us-ascii?Q?MmPA6pKNXnu4clcK0Tca9KOIsRIeM7Om7Xar92seiSOkHHRiVdlQxjJxcOMO?=
 =?us-ascii?Q?m47mBopeQ48psSoHtJ131rybl6BXvaWgVXwApOpIHPpMxeNAf87TodudnaQc?=
 =?us-ascii?Q?YDoqIZqVTYXqK3NJeSa3ju2Esm86IgU0bKwDvBwIOXiv/q04uE+rYfyHORyi?=
 =?us-ascii?Q?1IFfNPz0mATZMXe2JIatHjz26gSRW7VHc8oJPezl6ZcDygniU7gOGjuZ9lT3?=
 =?us-ascii?Q?6cCiqYYM3sUHqw3yHNqnlnAcYlAakAIvvDbvRk7B3eLnFekCniyqC+uQHyYh?=
 =?us-ascii?Q?Uw0pDymZHGD9hDss1WaSoFTDrJOCZcJq2wVuKGw1g9Ef3Lp24fmePPi/ysFX?=
 =?us-ascii?Q?nckwvkdPOdcU2YwIBlNMuAq3n8Cx3R5JoLtLVyTBme9tCqNNhd2a30pgv8rq?=
 =?us-ascii?Q?UhS/GY6xjUbN4kNgoaegUr74YomfYaYfMYhRniCK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72bda074-b3cb-411c-fae1-08dae23814a9
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 03:12:52.0639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7MWaS0FP308LOxlgdeLCznu7+AHmfid6MexF/S9pIN1Cw2gYo88AUG/DfpH0zD/OrFEsky0jUj/rrcRCdVj6Q==
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

enable decoding 12-bit extended jpeg

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 136 +++++++++++++++++-
 1 file changed, 134 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 7c3ad1ee4769..2dd52d593764 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -87,6 +87,20 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.precision	= 8,
 		.is_rgb		= 1,
 	},
+	{
+		.name		= "BGR 12bit", /*12-bit BGR packed format*/
+		.fourcc		= V4L2_PIX_FMT_B312,
+		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_444,
+		.nc		= 3,
+		.depth		= 36,
+		.mem_planes	= 1,
+		.comp_planes	= 1,
+		.h_align	= 3,
+		.v_align	= 3,
+		.flags		= MXC_JPEG_FMT_TYPE_RAW,
+		.precision	= 12,
+		.is_rgb		= 1,
+	},
 	{
 		.name		= "ABGR", /* ABGR packed format */
 		.fourcc		= V4L2_PIX_FMT_ABGR32,
@@ -101,6 +115,20 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.precision	= 8,
 		.is_rgb		= 1,
 	},
+	{
+		.name		= "ABGR 12bit", /* 12-bit ABGR packed format */
+		.fourcc		= V4L2_PIX_FMT_B412,
+		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_444,
+		.nc		= 4,
+		.depth		= 48,
+		.mem_planes	= 1,
+		.comp_planes	= 1,
+		.h_align	= 3,
+		.v_align	= 3,
+		.flags		= MXC_JPEG_FMT_TYPE_RAW,
+		.precision	= 12,
+		.is_rgb		= 1,
+	},
 	{
 		.name		= "YUV420", /* 1st plane = Y, 2nd plane = UV */
 		.fourcc		= V4L2_PIX_FMT_NV12M,
@@ -127,6 +155,32 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.flags		= MXC_JPEG_FMT_TYPE_RAW,
 		.precision	= 8,
 	},
+	{
+		.name		= "YUV420 12bit", /* 1st plane = Y, 2nd plane = UV */
+		.fourcc		= V4L2_PIX_FMT_P012M,
+		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_420,
+		.nc		= 3,
+		.depth		= 18, /* 6 x 12 bits (4Y + UV) for 4 pixels */
+		.mem_planes	= 2,
+		.comp_planes	= 2, /* 1 plane Y, 1 plane UV interleaved */
+		.h_align	= 4,
+		.v_align	= 4,
+		.flags		= MXC_JPEG_FMT_TYPE_RAW,
+		.precision	= 12,
+	},
+	{
+		.name		= "YUV420 12bit", /* 1st plane = Y, 2nd plane = UV */
+		.fourcc		= V4L2_PIX_FMT_P012,
+		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_420,
+		.nc		= 3,
+		.depth		= 18, /* 6 x 12 bits (4Y + UV) for 4 pixels */
+		.mem_planes	= 1,
+		.comp_planes	= 2, /* 1 plane Y, 1 plane UV interleaved */
+		.h_align	= 4,
+		.v_align	= 4,
+		.flags		= MXC_JPEG_FMT_TYPE_RAW,
+		.precision	= 12,
+	},
 	{
 		.name		= "YUV422", /* YUYV */
 		.fourcc		= V4L2_PIX_FMT_YUYV,
@@ -140,6 +194,19 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.flags		= MXC_JPEG_FMT_TYPE_RAW,
 		.precision	= 8,
 	},
+	{
+		.name		= "YUV422 12bit", /* YUYV */
+		.fourcc		= V4L2_PIX_FMT_Y212,
+		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_422,
+		.nc		= 3,
+		.depth		= 24,
+		.mem_planes	= 1,
+		.comp_planes	= 1,
+		.h_align	= 4,
+		.v_align	= 3,
+		.flags		= MXC_JPEG_FMT_TYPE_RAW,
+		.precision	= 12,
+	},
 	{
 		.name		= "YUV444", /* YUVYUV */
 		.fourcc		= V4L2_PIX_FMT_YUV24,
@@ -153,6 +220,19 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.flags		= MXC_JPEG_FMT_TYPE_RAW,
 		.precision	= 8,
 	},
+	{
+		.name		= "YUV444 12bit", /* YUVYUV */
+		.fourcc		= V4L2_PIX_FMT_Y312,
+		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_444,
+		.nc		= 3,
+		.depth		= 36,
+		.mem_planes	= 1,
+		.comp_planes	= 1,
+		.h_align	= 3,
+		.v_align	= 3,
+		.flags		= MXC_JPEG_FMT_TYPE_RAW,
+		.precision	= 12,
+	},
 	{
 		.name		= "Gray", /* Gray (Y8/Y12) or Single Comp */
 		.fourcc		= V4L2_PIX_FMT_GREY,
@@ -166,6 +246,19 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.flags		= MXC_JPEG_FMT_TYPE_RAW,
 		.precision	= 8,
 	},
+	{
+		.name		= "Gray 12bit", /* Gray (Y8/Y12) or Single Comp */
+		.fourcc		= V4L2_PIX_FMT_Y012,
+		.subsampling	= V4L2_JPEG_CHROMA_SUBSAMPLING_GRAY,
+		.nc		= 1,
+		.depth		= 12,
+		.mem_planes	= 1,
+		.comp_planes	= 1,
+		.h_align	= 3,
+		.v_align	= 3,
+		.flags		= MXC_JPEG_FMT_TYPE_RAW,
+		.precision	= 12,
+	},
 };
 
 #define MXC_JPEG_NUM_FORMATS ARRAY_SIZE(mxc_formats)
@@ -437,17 +530,24 @@ static enum mxc_jpeg_image_format mxc_jpeg_fourcc_to_imgfmt(u32 fourcc)
 {
 	switch (fourcc) {
 	case V4L2_PIX_FMT_GREY:
+	case V4L2_PIX_FMT_Y012:
 		return MXC_JPEG_GRAY;
 	case V4L2_PIX_FMT_YUYV:
+	case V4L2_PIX_FMT_Y212:
 		return MXC_JPEG_YUV422;
 	case V4L2_PIX_FMT_NV12:
 	case V4L2_PIX_FMT_NV12M:
+	case V4L2_PIX_FMT_P012:
+	case V4L2_PIX_FMT_P012M:
 		return MXC_JPEG_YUV420;
 	case V4L2_PIX_FMT_YUV24:
+	case V4L2_PIX_FMT_Y312:
 		return MXC_JPEG_YUV444;
 	case V4L2_PIX_FMT_BGR24:
+	case V4L2_PIX_FMT_B312:
 		return MXC_JPEG_BGR;
 	case V4L2_PIX_FMT_ABGR32:
+	case V4L2_PIX_FMT_B412:
 		return MXC_JPEG_ABGR;
 	default:
 		return MXC_JPEG_INVALID;
@@ -483,6 +583,17 @@ static void mxc_jpeg_addrs(struct mxc_jpeg_desc *desc,
 		offset;
 }
 
+static bool mxc_jpeg_is_extended_sequential(const struct mxc_jpeg_fmt *fmt)
+{
+	if (!fmt || !(fmt->flags & MXC_JPEG_FMT_TYPE_RAW))
+		return false;
+
+	if (fmt->precision > 8)
+		return true;
+
+	return false;
+}
+
 static void notify_eos(struct mxc_jpeg_ctx *ctx)
 {
 	const struct v4l2_event ev = {
@@ -767,24 +878,31 @@ static int mxc_jpeg_fixup_sof(struct mxc_jpeg_sof *sof,
 	switch (fourcc) {
 	case V4L2_PIX_FMT_NV12:
 	case V4L2_PIX_FMT_NV12M:
+	case V4L2_PIX_FMT_P012:
+	case V4L2_PIX_FMT_P012M:
 		sof->components_no = 3;
 		sof->comp[0].v = 0x2;
 		sof->comp[0].h = 0x2;
 		break;
 	case V4L2_PIX_FMT_YUYV:
+	case V4L2_PIX_FMT_Y212:
 		sof->components_no = 3;
 		sof->comp[0].v = 0x1;
 		sof->comp[0].h = 0x2;
 		break;
 	case V4L2_PIX_FMT_YUV24:
+	case V4L2_PIX_FMT_Y312:
 	case V4L2_PIX_FMT_BGR24:
+	case V4L2_PIX_FMT_B312:
 	default:
 		sof->components_no = 3;
 		break;
 	case V4L2_PIX_FMT_ABGR32:
+	case V4L2_PIX_FMT_B412:
 		sof->components_no = 4;
 		break;
 	case V4L2_PIX_FMT_GREY:
+	case V4L2_PIX_FMT_Y012:
 		sof->components_no = 1;
 		break;
 	}
@@ -804,20 +922,27 @@ static int mxc_jpeg_fixup_sos(struct mxc_jpeg_sos *sos,
 	switch (fourcc) {
 	case V4L2_PIX_FMT_NV12:
 	case V4L2_PIX_FMT_NV12M:
+	case V4L2_PIX_FMT_P012:
+	case V4L2_PIX_FMT_P012M:
 		sos->components_no = 3;
 		break;
 	case V4L2_PIX_FMT_YUYV:
+	case V4L2_PIX_FMT_Y212:
 		sos->components_no = 3;
 		break;
 	case V4L2_PIX_FMT_YUV24:
+	case V4L2_PIX_FMT_Y312:
 	case V4L2_PIX_FMT_BGR24:
+	case V4L2_PIX_FMT_B312:
 	default:
 		sos->components_no = 3;
 		break;
 	case V4L2_PIX_FMT_ABGR32:
+	case V4L2_PIX_FMT_B412:
 		sos->components_no = 4;
 		break;
 	case V4L2_PIX_FMT_GREY:
+	case V4L2_PIX_FMT_Y012:
 		sos->components_no = 1;
 		break;
 	}
@@ -847,12 +972,15 @@ static unsigned int mxc_jpeg_setup_cfg_stream(void *cfg_stream_vaddr,
 	u8 *cfg = (u8 *)cfg_stream_vaddr;
 	struct mxc_jpeg_sof *sof;
 	struct mxc_jpeg_sos *sos;
+	const struct mxc_jpeg_fmt *fmt = mxc_jpeg_find_format(fourcc);
+
+	if (!fmt)
+		return 0;
 
 	memcpy(cfg + offset, jpeg_soi, ARRAY_SIZE(jpeg_soi));
 	offset += ARRAY_SIZE(jpeg_soi);
 
-	if (fourcc == V4L2_PIX_FMT_BGR24 ||
-	    fourcc == V4L2_PIX_FMT_ABGR32) {
+	if (fmt->is_rgb) {
 		memcpy(cfg + offset, jpeg_app14, sizeof(jpeg_app14));
 		offset += sizeof(jpeg_app14);
 	} else {
@@ -918,6 +1046,10 @@ static void mxc_jpeg_config_dec_desc(struct vb2_buffer *out_buf,
 	desc->stm_ctrl &= ~STM_CTRL_IMAGE_FORMAT(0xF); /* clear image format */
 	desc->stm_ctrl |= STM_CTRL_IMAGE_FORMAT(img_fmt);
 	desc->stm_ctrl |= STM_CTRL_BITBUF_PTR_CLR(1);
+	if (mxc_jpeg_is_extended_sequential(jpeg_src_buf->fmt))
+		desc->stm_ctrl |= STM_CTRL_PIXEL_PRECISION;
+	else
+		desc->stm_ctrl &= ~STM_CTRL_PIXEL_PRECISION;
 	desc->line_pitch = q_data_cap->bytesperline[0];
 	mxc_jpeg_addrs(desc, dst_buf, src_buf, 0);
 	mxc_jpeg_set_bufsize(desc, ALIGN(vb2_plane_size(src_buf, 0), 1024));
-- 
2.38.1

