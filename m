Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7116C41F2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjCVFP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjCVFPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:15:54 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075F058B6B;
        Tue, 21 Mar 2023 22:15:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReheG9/pa3wub4vfJr2rOPyxgMqLgx+1wzCDJ31BO98ry+AfjSZMaIwtUzu+r9IAdO/DZS1y/oGL70BHgTvB3kP29+8mjbF3QkEyJMm8IqQzEqAdSXDVSwe6KtQesihpCRAaaqICPyE3ZMJsHsNTiHMSoYjj3ZQBetknphHqTadPbpccDgTTqRtOIPRUOoc/S6oJPx37WzOKOnyug2uxyDVistAgoJE3ztxEmwiV1JfAXZFdNNzgUDSxFnBR0lNLlwFEBu9Ui98hxPr7kVGaG/8EjFmwe1/UNEMKlwZdhdBqP8h8hAe0raH2nKlxKnWsm26jhDzl97TweIVeDqjwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KQHy4ojmtQF1BduRAXSRUeX6FHJREEZUO4mQRp9hxA=;
 b=kxXFjM+RuiR4ZZHBj0+RVTg7vDCJIfzojPZ1FvoXkyeRNAQZyyhu0LnhH5fLDGpADXAbhv9vKTy2NQk7A9h4IONV8FkeWxuuFWpNCppYqVpav/JiPFiNNzD1Co3fiBGponKX9GbkbSHaiU/WJcpBA/4r3KtsuTO+X9iPY+t5O1u62aqcToa7c4U9HXvT6g8dLXuqxez6+Nv6zLRF61zMThbB7KdpBFKmSzBsHVz8/xUqxzBW1PzXWZShg1SNUm0naTolrNFWVbXQbkP+cZGa07kO3lG4xOx3x3K0O6cpr8lPM6brjEUmKWXjiSf5iVBUd2+wd4ojsdtTrs/rqVgBTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KQHy4ojmtQF1BduRAXSRUeX6FHJREEZUO4mQRp9hxA=;
 b=GhO+2GOT8byskifRPPqRkCs9Pa1dBIcPwvWAwN2feGCHtjZIloIALkRdDIxFs+Q78ypwnjUsedMddCRIlPDuapdnMe76klRnSD7gLkEt+M/wq0T4MSL1NKDngdVhzw/YSj5JJm8MWnscY5z0OeaInqmB0gBVDB3JbYjJkDriFh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8100.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:14:17 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 05:14:17 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 09/10] media: imx-jpeg: Decoder add support for 12bit jpeg
Date:   Wed, 22 Mar 2023 13:13:12 +0800
Message-Id: <9bfff536b5a7f952faee311cf689a1f5b79a47ef.1679461710.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: dcadd56a-9b33-4343-7c0d-08db2a944904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2sOTBGc+veMuD7Cidpq/HSsj520/AG668l8bzbKshawL693zcSkTGbcQf90ycC10mwGg4az+IOaSWiz2+KyLy8l1NdbCYfY0POhoBeMm2KSxWIPbOsjaI/dOh37CyqgE1zrD9KXA23SI/X0BDIorZwfyYksW31a5dO9G9RzFTNEIdebOzn1VEL0cyA4HIFMUsgHv6MsHEYTlz8JUgTUIwvYoxTgNMd2r1UpSw/zqWgJjHqDfqf32QMmMp6TKblv3rmyK8B17PpAIrPDr9fGaLoDh12NTJ6BjyZHH+BK11hSdJ+QWI/G5mmdf6LOhAanRjC99FOgVu4PB7w/od+pVCZqBWz5YmYwWypscmO3ezN+/yPPGnvvjMRcHD+SYCJnJEv5XDQcsbl9AxBzeDUb3veMVXOI/jmqD+I2GSUH0Ik/N132x/BjvqWXz/t5R1ApTSmy59yqN4SQPoVGDx5U2Y9AGZzGiR82VpCyFgbL0dXEPAcwMGt8iML+/Cd7uPVKIaSrf/aaTi0JUAOkOwXTFYb5rxFl4S2l2o8Mf+G/gpq4FxSlGlZ1fRt4sHjrtRvQYWJfD3W4ekWZP6d6Wer5t+bRNOO1gmGjTDN9gAZ592n5yOUnGIaOUN6XXgNu3NVpXVBHdLKFS5uEiJqEmQ/PYctnsngeH9X51i3UQucY9gsM3qAXBQODNsRu6cXhKAg2MOOrL2bhJKeReC8qwFjEy5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199018)(6486002)(66556008)(41300700001)(52116002)(66476007)(7416002)(478600001)(66946007)(5660300002)(8936002)(8676002)(316002)(44832011)(4326008)(36756003)(86362001)(6506007)(6512007)(186003)(26005)(6666004)(2616005)(2906002)(38350700002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZOa4Z0XDm75Rscb4sjJfQYOyYyHDaoMgKLSLo+2MWro8u5KPN+XNS7Ga/Cd5?=
 =?us-ascii?Q?n4vmwzQaa3Fk2tYuNHW9xc9qyBlJk+cz4Kp8etmD3lcTab+IRP8NjY4Suk+B?=
 =?us-ascii?Q?E70c4JFq0yj99lQE0tNSzZ6hswPeMJQ893WMUm/nZ3Y0sClYWf98Jcwd9SzC?=
 =?us-ascii?Q?vuoxVXUndHkqmM/xfoujdYEMgUHY/TwKVIMuo2sgSVh1JTc0gUyIkKuUcAIe?=
 =?us-ascii?Q?6ngcimqFg6qTkK2DvrlKFXKSe68MnWiPQ3h0pNYNakYCz3SD1h2f6n2aImLl?=
 =?us-ascii?Q?TIbSMxgjtUM1H1M2oTEpz+wdiUq0z0uWIA6Lj3PWhYefaf1KfqYnPjJD2WVm?=
 =?us-ascii?Q?XozvOTzCtBf2VlOyWZKGMtq0CN6iPq6mgdhfNFfZmWSHGnAEwmQwdA+BECd7?=
 =?us-ascii?Q?GzOBLQP+ztoMJdXWQef/rOl632ijKJBgYki6MvW1ESyH6ousWZo/0pFXEyzs?=
 =?us-ascii?Q?vGak4iaENGmqt0C/m6NOTScLklqZy9hxY70FK6YXHtrfxbzg1kDloH5WWHA9?=
 =?us-ascii?Q?mpjm5LRiftTCVRAnvmJUczzPJnv/a0Yyo4s4dVPYA9WQmYjuq92meW/GCUFt?=
 =?us-ascii?Q?X2O/zOdtaXpQUzUUpAguoJz5xjjW2owOI20nJ5dP8dnOix5KfrRTH1DElupt?=
 =?us-ascii?Q?iGT1BS2GeWQT8jbrtqQsPNBV38cSHduUaJhz5uVxMYB5mKxgJerD3TgETtDC?=
 =?us-ascii?Q?/CC+C+nx57QoC+TP7ZB3D2nF/zpbvbNlgu/0HI7O7It6QsHMbcfvfIKexTe4?=
 =?us-ascii?Q?qZzmwMwEOwX53NnGUrIsG3V96eUkGOEz9VnFx9uNoaj4mAq60G8oqpb4pF5H?=
 =?us-ascii?Q?CcRxzEODiHF3P9gP3eRnuqnHEiAL2pjSufO5hEm05rQpJcj88tt1bV6vnAFq?=
 =?us-ascii?Q?+9CmRapQhzp1C5ogR7D1HbnFtlVU0adVKce1J9iaS4n/mbFNqIWg56BoDlmX?=
 =?us-ascii?Q?5di1Dhl2HslcCjxMFDlRkbxDu39p2iqfsRjK74Fn1awwTTN946qeBFBnB03h?=
 =?us-ascii?Q?zkV31xRcdLQgrfAzrAFlBbzsdcLhTzHlAhRtz82XRCWsYNJjXh2lLXLpFwhN?=
 =?us-ascii?Q?qj4QdOQLPWpRgx1CnTAZkh6kf8Xf9ptyq5USNZ0T/+PcqQigGOIrhcggqZw1?=
 =?us-ascii?Q?Ds3lwdDflMN+gw28DOLDbTeqoyxZ0BTpZO7ZFxvJj8rriXgv493xCjlbGwMJ?=
 =?us-ascii?Q?AuzaFSrwmYRWRtm2s386NOvAgkS7zkG8h1We+OHZA+sX/E41uDEGfF+DDIrU?=
 =?us-ascii?Q?RqzU1Kz7hy/I+eXjGhKtyg4EKtaxb5D6snTZ2WZxnx18j+kLpG67bbrw1fBI?=
 =?us-ascii?Q?mb2Z/Tpy63XvVxF8iX0ROn8g4atJt+C2ygUMiHEGlueW7tysfKi+l25hkx6y?=
 =?us-ascii?Q?Nkf00O4vKKR45ibvHiQPDyCJzjfCrUswqCOaCoivLhsK+2Bk1a/MQ3VWhU/r?=
 =?us-ascii?Q?do7Yijuf0jDvdAy9kXcLWoTPO6c92POWBLH9Q/qgoKRAqHrig2uIVQprOW+8?=
 =?us-ascii?Q?RwBpDVBhPZ6EyT+T7qjEb1Bok234dSX0KBOF9IfAVHIVThpCf1V+gGtOMsyW?=
 =?us-ascii?Q?w6Y8Zet8OFd35DLTnEqzsdPQ9ZwgylmnXjbq5Lzw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcadd56a-9b33-4343-7c0d-08db2a944904
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:14:17.3489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wZGwwxXPdndx3wmS2dhfg+eujvCGTM1ByIA+wdizqYKj+aw/Cs+fyFPVXh3jdgegnOY7dEIlWQ/CKDKFDzhtg==
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

