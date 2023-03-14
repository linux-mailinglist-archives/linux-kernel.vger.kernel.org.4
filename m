Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528BC6B8F6B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjCNKMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjCNKME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:12:04 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA409AA02;
        Tue, 14 Mar 2023 03:11:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPFCgR9AoGZHmZW8s7dFlC3pTSSE36pt5AgqBAzVhQfUL3YjsZRK4wdEGpar0XIxkdHNgS6Bj8DT13iUTyiWJ317ObvwXPPgVwPuiRLGSGvS+ckIg8z16VADFY3On3h01jFhBe5biSm+RxsC5dmCKit3lWXmyHPm739uE01/OMVaxJhNjoiDar3g1kFEEvQXmkGLmuVdkLUyVUaFaCzRA92M2yJHowXinjjXzm0kcpuyjS74QPrC6h8lGQvRUTkWpZ8WKLEP54kgNP1iEf8j/FSZnG4H7UT0V4XNQIRkfXk5zJ+dpYmJc4TPlLeK7nTon84U7wik/895Xn9NSIGKeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KQHy4ojmtQF1BduRAXSRUeX6FHJREEZUO4mQRp9hxA=;
 b=Rg7Tq8U4K+7gl1TxTbBh9j6rBhStgevonKbDYr/X9NJjf4ahAEW3r+vSxnAFdUSCr60JCzsO3/HMNsCYJk0yynSI0f0F13616AhSQOw+M2CjTUqJ8xow77vHumBegxzlVbZyio6O0GWrw0+Gs2yHQE0AULUI/nrwHOdh4StfE/uRuqGRM0igiaW+VWe0QxnO+lCXDiWH48pFYbpnggLVZ2PgDMcE3TsZvLN9y+56ucJVLaGzPXApJ3VPOHFNbP7N5OiXiV4JXuZqD8Zr26YO79eQpelzfqX/zZTfTyPqjfKc6dfG8nI6IrXsdt4aK1CjQ+xGb40UXMzjO02iBmL8Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KQHy4ojmtQF1BduRAXSRUeX6FHJREEZUO4mQRp9hxA=;
 b=dDfOytYaXdYJ2/p4qICMICChR8oLbAb/zNFREkQYT1cfABBuP6KNc4KljkDW1wIf0UmNufq1826jvTD4nmEPjcX14oNEYVqqGNzIOHxr5+sXmhFbM6w8eSX82E3aZubLScQDw9q8lPNMzaheMMUclGKdBoR8nt0qRm7RDrKw+pM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM8PR04MB7841.eurprd04.prod.outlook.com (2603:10a6:20b:244::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 10:10:34 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 10:10:34 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 09/10] media: imx-jpeg: Decoder add support for 12bit jpeg
Date:   Tue, 14 Mar 2023 18:08:52 +0800
Message-Id: <69bd4bbc12b167d84fce97979257081eec281a67.1678788305.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1678788305.git.ming.qian@nxp.com>
References: <cover.1678788305.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM8PR04MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: c7424708-70c0-42cd-74ba-08db247459b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bUBLTdUaP177q/36sbPYu7vlmmppO9WRTvP2PghtuUrb/gdeeaRNqNJt2ES/IidNQwGG3HWM6i4mfCuak/txCWDq4DYKL26dyxrA0d0MXWQ6obiQAVJ7sMulwzeOud7cLIyPjPrHPSyNvtPJm60Vphj+ZTKYh/AdQX2tI8dkWYvKY9osHjo0aIzjCQLvR0y35bfkkKDaw+THuNgLLsjxrmQh6EH20oyVMOjuee7ciEfmwJzMIznkb0LA1zM3tlI2N0kVuBe92+r38nTkSZN5WDlPEvPcdQXxYxlX+b4ColQJ4/vt6q8BrQwzgJOxi2Srsi7F5yCmWqwc0IKmCZJSS+k4Xx9K7QN597krG0YV9+a2sB95/vVxcFHvTJBYKu/atn4zIXqfLlIr6Lb1P/PmssgZh6ghIvPaMWNxhtyOZuiP0mB1GJZ56i0cSZBDgD58NtEMBaWaIX3ShY/7CoMH+NH8vdE5Goa5DWQVj3yQaz/OX9O01OPz1qxFWe4TLMBg1xu9gkc+bODv9KVIdvXda4Zh0fuC2eqDf2AoiUVgYOzGLXiUTyOBNn6EdJVsKOhbPClJm/Ou2LM1OFFXsmUurTICEturK8wcp7gl4ywarBHZVV2+EOSnkc7ThB7a8j2jIiWJOOHzycLwHejTX6vSmyGfTPManKCumOhCa6P8N0IuLL3Y8ycQkJkZnIZnSZEmJfH70MRncqERGAba9me2fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199018)(7416002)(5660300002)(8936002)(2906002)(44832011)(38350700002)(38100700002)(86362001)(36756003)(41300700001)(478600001)(66946007)(66556008)(66476007)(8676002)(6486002)(6666004)(4326008)(52116002)(83380400001)(316002)(186003)(26005)(6506007)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v56h01PXKfxiO1xuhnYP6scxqrWTBIRKgw3ZwF4jXnWtEiB+uHeKxQELmZq3?=
 =?us-ascii?Q?8h7RV8kBkJ/wmEMwZe1LshryaBdCvtYggzZlUF4YoOM0rn+hRVsN2TXNY4B7?=
 =?us-ascii?Q?GjGceh7ARPy8+CHsg4niS0KSdNNnlkQfgHMUrPYKLkB8cSQ3Rtel4hCYFihE?=
 =?us-ascii?Q?8RrfBtNnsz+wHxZ02NJDO//PTtIHOHfQ7A2Zf0bz7Lu4m2O+OT8lym2In2O1?=
 =?us-ascii?Q?uu7lu7Y4x1uiuJfrkgxdUr64tLVeYszgNf9khtUsNT+G/S2uooZcpGw8jIsC?=
 =?us-ascii?Q?+csAg6iSUuYi3E5njHOaFIxsPZX1znNgpfHDg3PS5IscurlyqNsJAnhDBm4D?=
 =?us-ascii?Q?iwdv9D2HmqKBBpU/4+LAoLQSxrmxp3dDmxZWeV4GUJqm+jGL1syvG+KDWQHI?=
 =?us-ascii?Q?Ws2LTuUbb8ASb+HQ1AKJHhrIkqW32e7cKpvd+Ypo9fLFaXyiZRB//OkC5Hz7?=
 =?us-ascii?Q?yhol7CUf9SBC7fGXkqCTSMpxUz2+bYMSQwk+C8FjCqNWM30UexGj8lNdUxA+?=
 =?us-ascii?Q?NqMMyLXZBgWnCTk/sN8/KOkhvp4/G6g4H2yqNQnQr9Hk3zm8gsjhmPa5ODAQ?=
 =?us-ascii?Q?qcTu0ivoOQ4DJHdsg40x8ho/hRnBOh6ye3mi0PKaI1k12Kz0UluWgB6bewdu?=
 =?us-ascii?Q?dl61Rpt+par0HAuwRL6Ey8b5AXNIjw3F+f1T6J/asFCFtRVWmwSz8L1I9eUM?=
 =?us-ascii?Q?T0WiMjhFCl1dntGyQM2HsuDbSqme0JjNHFvmM5OPj3/crZJdphpbuGMRLc6o?=
 =?us-ascii?Q?1QyRHmeyYqrOYIlKEKW4bBSuIwnvjqZ7ILsNWGoN8n1ykSZpZnJK8NR7BeIX?=
 =?us-ascii?Q?FBAmxrfB8UCmpYyiImS+AR7bzNIU163faCj8IzS7ufD+8s9XBy/RuxC8MT5P?=
 =?us-ascii?Q?mYYMcolXJXbmwigdNaVTvZzYoJ+Q8Lyp3l0sKcsMGrHYVDylxgKUrRa+J4WE?=
 =?us-ascii?Q?yhjS1qyLEngoXLFeMNdE/p1cWqsTCNPa8LfVw4/V7RnC251wIUZYu+eB+uOp?=
 =?us-ascii?Q?pYZtLofDW+eEejQynFXRNpW/pu0keTovYpno8dSydBvDqgbTbxtxIzX2Z92j?=
 =?us-ascii?Q?AczECi3H+rbmlTZFzH4T1jaqXdD6UbH0vaothue/nZLR7d745VRnYq7t78no?=
 =?us-ascii?Q?yH7UFgtmffzd1AJFwAnRCrUvuGYyjsFF7PuPdsQfJ/Ps/sU+OuTxNS4jtXyV?=
 =?us-ascii?Q?zZY508BEyRbYzOYIfuYz8TSKSLoA31OVLpaHsZMAsaO0TbV9MdEdKeTme0hH?=
 =?us-ascii?Q?+rCPdaN11v393a/StGiZbYun1vIp3g1K+pTBZK9CUNs8IRfE/ispIlVUErH/?=
 =?us-ascii?Q?HAMzAJjM0fAK/4TgoxWcTkXlxTfnAiQdwmM9nO3YU6lsj1q6eeehciJ91m59?=
 =?us-ascii?Q?habBkiH24C9aq8HHiKA8YiCJ/kHYskHYGRXEeDpnPbbMhPpKFSYqEqatguwo?=
 =?us-ascii?Q?4rAlNe8tn6YCnSjJuy2A8zrA7tYRiu3PpdlfVpXlXlU6nElVjzrhqH1SLInu?=
 =?us-ascii?Q?DFtM1FXg92G64gAoGzfQFI9enj9kxcWM5uAw8eQy7ZuOuGu+/tGYiV8kKjXH?=
 =?us-ascii?Q?slXoVajeSk95qnBW94wx6nsXRED3ebJgu2/74XKR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7424708-70c0-42cd-74ba-08db247459b1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 10:10:34.4384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOiI8+T9pIm4fOGdPVMDhILzC/RWlul6MhCxlkIn4wZ7PiYtzaETmFlmnX5VeRrm7nVrI13rLJJxjsxPKDUVuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7841
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
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
index 3f1c9bc4b144..74ecc5415aa6 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -87,6 +87,20 @@ static const struct mxc_jpeg_fmt mxc_formats[] = {
 		.precision	= 8,
 		.is_rgb		= 1,
 	},
+	{
+		.name		= "BGR 12bit", /*12-bit BGR packed format*/
+		.fourcc		= V4L2_PIX_FMT_BGR48_12,
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
+		.fourcc		= V4L2_PIX_FMT_ABGR64_12,
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
+		.fourcc		= V4L2_PIX_FMT_YUV48_12,
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
+	case V4L2_PIX_FMT_YUV48_12:
 		return MXC_JPEG_YUV444;
 	case V4L2_PIX_FMT_BGR24:
+	case V4L2_PIX_FMT_BGR48_12:
 		return MXC_JPEG_BGR;
 	case V4L2_PIX_FMT_ABGR32:
+	case V4L2_PIX_FMT_ABGR64_12:
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
+	case V4L2_PIX_FMT_YUV48_12:
 	case V4L2_PIX_FMT_BGR24:
+	case V4L2_PIX_FMT_BGR48_12:
 	default:
 		sof->components_no = 3;
 		break;
 	case V4L2_PIX_FMT_ABGR32:
+	case V4L2_PIX_FMT_ABGR64_12:
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
+	case V4L2_PIX_FMT_YUV48_12:
 	case V4L2_PIX_FMT_BGR24:
+	case V4L2_PIX_FMT_BGR48_12:
 	default:
 		sos->components_no = 3;
 		break;
 	case V4L2_PIX_FMT_ABGR32:
+	case V4L2_PIX_FMT_ABGR64_12:
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

