Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58351685F80
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 07:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjBAGEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 01:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjBAGE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 01:04:27 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2041.outbound.protection.outlook.com [40.107.249.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3251038EBA;
        Tue, 31 Jan 2023 22:04:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbxC9ExDTADgU8U60Kmvs0Y4VFcSeiiiNZxYyO/Xc55Q3KSSiT1wMZPOSK19yq7EzYlHSRIH3NJFImCyHjVwKOezi2LWWgolnR6ObKKl3mmqQLW0ocZFY96PQquwpYoFe0gV9ubfftvhBWiNmrqL5FFwkMAlblWBppyNZvb4Y//OA69LKZY5udSDrgqaYWEUUCsvLlwxh1HK675Z4E6IkfZ6bifOtyqqgH194/sD+alp/U5qXxHnQ0FrENYuGlaYzaMFSDQWs3d0OSJA/oIZrAqbP/lCRQejMlr+F9oQgiTU/sPy4ygOTOfEljOSQPfqO2dz39zS3Rp6X8EzXJPDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2e0CU7sES36aiy95m2z3T9eE5qB7rasadl/DHDlusE=;
 b=NzYXUK4f7cMowrXw0qJWsMQuwOvM7at2FsbBlTv86epwyGiV5960Cjwz1VUNrVpEJ5/nswDBZ8HMbUaPlKJxMCX7xsikrDsXkxnh+Y/EMhmk5Cr+tsPR8ygPGXDNfdOeaWnRtwyMI4d0S8JcwdT6EbkaxOjvXYCzi60VX0RY+kog/iSi/6Zslgq5Ai8MvLbggSUL8M9lgFwSnuQO8dG6ndh179JzSkkp1pEPAXxXrlG9/jrkbRTyV4NsCMdLpCoLbbEgE0fvimp2juH97psU+8P734sFXscV+JsR3CheedfRL8x8A4bte95dcuxMgVhs4M7PUHDlTBFif4jzFCk9Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2e0CU7sES36aiy95m2z3T9eE5qB7rasadl/DHDlusE=;
 b=VPvogLI21J/cBNzsm1fuk5clxohBiHUrAiSDAqDTbyMDSjIuAevRElyWFJYJYIpjsTjQxAkR+nv7q1X6CW+OEA4Ous/t8SX7lJqDshJiXJFMZvbyz6DWkQw83yGb/EBOXnIkXsS7wQ5TVdsTBvg8VrNeggN3lHG6P/YAiN8COYI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 06:03:53 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 06:03:53 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 09/10] media: imx-jpeg: Decoder add support for 12bit jpeg
Date:   Wed,  1 Feb 2023 14:02:31 +0800
Message-Id: <3c2df9a3093df66ac6a44a04b8c55211fc7a60c0.1675230665.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c2518123-c6e0-40e6-d3a1-08db041a1894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rPvs4EOBlAcBVEkXgJZGCn+/2v4o3Mn5AXtPYC6IphbP1r3Xc+0Ibg+YeZdDql71FpMJmMrZB1Q3QQ7hHX4k7VKIu3UKoETmOTmPc6V4G7yJbm0CBFDeUgMAYswECrwScZqbhMXWSEMd/ZVYLNl+jR/g1hjWVPx+2No2/YGDmkCs4aohskUq6liHusfeyXScEtWIb0ZEwkx20kNvi1U5Xzot8COilv+SmjKHNDk2vLY0zX+CGtLh48YPuNXbHIAFufOrNunRwe+wt0X9NZ2wehkKb8rVepJSNk8iBgmYxn02kMThf1Id+31ql6l+QfhNeb2aiQDJZ3E9AgBz4j8B0jBggeXep4ItbOxGyWzSRExK3yIJYPyZ4lAEaZ3/jMgqC5+zwV3XB7L59ygAbNoqL40CBfHnm8tZoUgWLXuatnaKkMg0WEqP0TAAXvVLHh+7WyS/C2aWHtpdf+mayun3ns0+n89492G4Tnhue/pUKdXYXLxVVbI9aCzMGVcaYFDCLh/0YTACqkMVkNbGriNRx7rtaa1CaIZDWfj1yFihkcaqTiN+ZaZ93Yrmu9fQY4qQw7gPbcppth+rmoOCLcOX/EvkZTKGE4bE0uGmTDt2tBH2SaHXLgCUlwijDon8hFjdmH9ZxMmPJ31zxPGYQ51gn7J0bipEzAnOPQ/Q6mg1KxBwdKOZGgTlGhPYv4ZRWZHtFkMTpTeuajHmafo93BiT+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199018)(38100700002)(52116002)(2616005)(38350700002)(36756003)(7416002)(8936002)(86362001)(5660300002)(44832011)(316002)(41300700001)(2906002)(83380400001)(6506007)(6512007)(8676002)(4326008)(186003)(26005)(478600001)(66476007)(66556008)(6666004)(6486002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?25fL1eRaUCFT0lfwpKWPac3lxFtNhzZmhLDIy8EC561cq+7e8oY+H6stbIoD?=
 =?us-ascii?Q?5v4mH9/LhUkxg2y+x+NRAViCCvty3pEpAA6ZjMqqheKZbMSkbvWD/B06Powv?=
 =?us-ascii?Q?ZDa24CobOKmdpT5dhshjDrtTzQQBSk26oaF4/x1xTnDGTTIeripUNwAi7PyV?=
 =?us-ascii?Q?QNuWlTdw2UlpMR/33brXheF6GJIxlguGesRDQ33N9M4JqwRsl17uYFqe5CZQ?=
 =?us-ascii?Q?qK6aIZfz6yHFrRBJicXsf8CDuNEPtJ06paJxurTEUY+Y0rzM8YwEDPJ9r4ET?=
 =?us-ascii?Q?u1FiQlnQHW0lqtZdgWFcQlm1gx/+lELIOHeTyo496UgvIXAvtWjYaGhVIcaX?=
 =?us-ascii?Q?7FvaJRA2cf2HU6OWF6qsoTJaPZbm+3nhJAFzedDEqmOBxfp6fLmAa4CFO8B+?=
 =?us-ascii?Q?cx5cQwAE1QR+C+r3Qj29LP4isa6f9mcDHvF00I03gSYeE82jg6P00J97d56L?=
 =?us-ascii?Q?4f7Ryqqbo4rrPkTMzela9nayLaG4tdnRU4hFfCZPeO8V1T7a8scFJ8DN0zWf?=
 =?us-ascii?Q?rnRwX7SDCypKNmO1phbItc0B7qnGxJmaoBwr4jgCbtwEWatQAd1kfTj0smP4?=
 =?us-ascii?Q?MsjpBbB2sJ3NvrxA9yorfkKTAbX1mMv6/yUOZDOjhaU/lZ7mI+G2m22K0Ydz?=
 =?us-ascii?Q?ozUZc7kPdfgV5GaxCnNx0RonAk863CYawNQPI+fOwVOaQzLm+IXhWDGuElhv?=
 =?us-ascii?Q?nmXmkQglX52xSFEv4EWo3f9lBDdAWgAXDB0uYxF2foZCOcQAGohiY3Zqoajl?=
 =?us-ascii?Q?+sFh49haxJyFUAHikVWUteLv8UWeAt5hbET96zMJ4gbuUWVcxsQsDuSK71+F?=
 =?us-ascii?Q?jMgefZKiEf7AU+HPQ3bDvhutzuw/pJR8Z92OeDhXBw9kHix7yEy8cLzr9y88?=
 =?us-ascii?Q?zYBpv/F6F9WvrRZKVFTrKGTiawLDm8McFPEYYVZ2EKZqAYt/HRQx+NGvLBsM?=
 =?us-ascii?Q?fClyVxwhijZkxS4cEWiSc/FiFg1SionRGCKd2Kx1hXJ69qqq8NujNCOdhvLs?=
 =?us-ascii?Q?s+foHcpMBrPWch8W9Iw7pkT/ruBJ1t2TOc5FsNF7lShcY8H7BzwJfXiXq6Bv?=
 =?us-ascii?Q?7w++kpBmD99WznME3lFi+64uzAHm4w7bYHUe7obJ3xhMMpqYNYTmAi+T5kL6?=
 =?us-ascii?Q?C35+yVH2OtvCw229tgQkArIITee4QDMaB5uoYKKPRgBq9lc/8cWkHJYICXL1?=
 =?us-ascii?Q?rlfTpOXCZYKbk4RbZ+opptL57YxrvUDml+t+p/tovmgNVhrjSsqbNztIpzI6?=
 =?us-ascii?Q?C7FpOd8NZfbNdAkWuMuLW0ymVqIc3GCjEF7NfSF4scP/JTtk/QHsIUo3vnVj?=
 =?us-ascii?Q?qAAxWh/rshEOy1KGxsEiyISmzCNZX1CZ7mHtFh+rqdyeKu/sUviU2ieIgi/q?=
 =?us-ascii?Q?v5YwUqmi9n12Z6S4PAhccIwaHD4u6w2tXbnshdQWgvZtoiPyINf89px2QIyU?=
 =?us-ascii?Q?/WIzQlJdFfQHr0BBPIkqPAj6s1/dqNEHPPz620H/HchdgZNrYqaREd+/ut0H?=
 =?us-ascii?Q?I/Asziu2aPbVPqpewMNoPRTuDJhoh9fYVXTfXs86PFgwL60njW8+lUfxjuo8?=
 =?us-ascii?Q?FsEhj7OIjPs8bgA2Mu1o/hNwxMWXrP27/dTvFCoT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2518123-c6e0-40e6-d3a1-08db041a1894
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 06:03:53.3780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UhjDNKteNv5pR+vi9praooeuTXD9MlkRhGrPRH608Vqdfl6eNT8JE+xqkVzp0C8/FDl6jPdUcYK1HXgn3dd0ww==
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

enable decoding 12-bit extended jpeg

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 136 +++++++++++++++++-
 1 file changed, 134 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 3f1c9bc4b144..d493fddf114c 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -87,6 +87,20 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.precision	= 8,
 		.is_rgb		= 1,
 	},
+	{
+		.name		= "BGR 12bit", /*12-bit BGR packed format*/
+		.fourcc		= V4L2_PIX_FMT_BGR24_12,
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
+		.fourcc		= V4L2_PIX_FMT_ABGR32_12,
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
+		.fourcc		= V4L2_PIX_FMT_YUYV_12,
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
+		.fourcc		= V4L2_PIX_FMT_YUV24_12,
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
+	case V4L2_PIX_FMT_YUYV_12:
 		return MXC_JPEG_YUV422;
 	case V4L2_PIX_FMT_NV12:
 	case V4L2_PIX_FMT_NV12M:
+	case V4L2_PIX_FMT_P012:
+	case V4L2_PIX_FMT_P012M:
 		return MXC_JPEG_YUV420;
 	case V4L2_PIX_FMT_YUV24:
+	case V4L2_PIX_FMT_YUV24_12:
 		return MXC_JPEG_YUV444;
 	case V4L2_PIX_FMT_BGR24:
+	case V4L2_PIX_FMT_BGR24_12:
 		return MXC_JPEG_BGR;
 	case V4L2_PIX_FMT_ABGR32:
+	case V4L2_PIX_FMT_ABGR32_12:
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
+	case V4L2_PIX_FMT_YUYV_12:
 		sof->components_no = 3;
 		sof->comp[0].v = 0x1;
 		sof->comp[0].h = 0x2;
 		break;
 	case V4L2_PIX_FMT_YUV24:
+	case V4L2_PIX_FMT_YUV24_12:
 	case V4L2_PIX_FMT_BGR24:
+	case V4L2_PIX_FMT_BGR24_12:
 	default:
 		sof->components_no = 3;
 		break;
 	case V4L2_PIX_FMT_ABGR32:
+	case V4L2_PIX_FMT_ABGR32_12:
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
+	case V4L2_PIX_FMT_YUYV_12:
 		sos->components_no = 3;
 		break;
 	case V4L2_PIX_FMT_YUV24:
+	case V4L2_PIX_FMT_YUV24_12:
 	case V4L2_PIX_FMT_BGR24:
+	case V4L2_PIX_FMT_BGR24_12:
 	default:
 		sos->components_no = 3;
 		break;
 	case V4L2_PIX_FMT_ABGR32:
+	case V4L2_PIX_FMT_ABGR32_12:
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

