Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CD765196C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 04:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbiLTDOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 22:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbiLTDNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 22:13:36 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2078.outbound.protection.outlook.com [40.107.15.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BB115A3B;
        Mon, 19 Dec 2022 19:13:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ST8sWCtc3VC0En/NDOinaPW7Kuc/XJM6cF3/W/gXFXvQ9YwxCvjpgC2zNVsKEB9zeVLH3925AcyZhdNE41Yyq1+E+1OzCvOiHbi3+RNSKaeKg1v2azANTi4xUvDjd/UERAUh1ndxb6u6GE3KJ+RW/9o5Liksm95N+VsXkqFILTQtRfLAGnH0AtA/vY7wvfJqJrQ0htqe6ikFko1x91I+rjBfR4HRozzXThf61GJejx+MyhlaEXVCC/HX4ZsAKu8AOZj9KtCFizC2lHkI7F78ejblahUFjZDmzQWyQU4tYLQY3jzK7M9yBOk8G0fBj2ktZoCIyDlrN3eZgNn5y/dWvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbIcPoq9RrGMWVbDtmtLrCDuucGY+RLJ/fv0HBuvT00=;
 b=lMP6On115SxhNNIdLwlEhAsNTWYrADfSdcKbK7zxoHpyufo15/jEpuyqBhePKTCbtJJwuQjJv/EGt06DEUlPQD3bEMB6tNaJOgQpbTuzWO6InEwpt19vVFrrlhsNmDMZO5jj+j3/j2RPjDHs29+Cmomm+g+RE0YsaYL4QGcDTEGR88VC98b0a+1dLHTvX/9AZIk/Rm+pQt+MmpWczcFxbpkyDU+2yXOUHPRzz1+cR6/J4l07QvEap9quZVrgL3L9niD4vThg11OrVuWHOqPGOK8r2gK0KIlE2Ld+nvJnfdI7tPhh+t0eThmaTAKKVvSMK4qHw8sY+shV9+t7Mzketg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbIcPoq9RrGMWVbDtmtLrCDuucGY+RLJ/fv0HBuvT00=;
 b=s7d5c+RUm/NwaK2lyYKP/rV6u8pNkhxNrGKP7y8RRFsU49hYiK+cCoKYUMAo2IQeR4VG3u3Jjvi5RMGB8CYfKytwbjA0UTv1xd+DilDVrDt8W874HXyoR1wdfDBTtWTUgZIoFWg3jKTNy164xQtE5Ml6QCxDJ0sCQkhtAr/hYyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS1PR04MB9405.eurprd04.prod.outlook.com (2603:10a6:20b:4db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 03:12:44 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 03:12:43 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 07/10] media: imx-jpeg: Refine the function mxc_jpeg_find_format
Date:   Tue, 20 Dec 2022 11:11:37 +0800
Message-Id: <2aab9e89d5e0ef398fd6e218e11db6ad47f0082b.1671071730.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1b0975b0-59e0-46ff-80bf-08dae2380fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RGBPo9dqkZwNGlVctwgiaGglrBA7kyo3p5AhjLvzEHiJ/IImQkMpXhTBxJWaNd0G00dtYMQEsFTbh4tZF0MkGEqp+PSs9H0N3a5DC3+50vnZY27Py2ORi/qvaICiih2v2prn3hZ/tJ9hnsxbZygWgAflYFz70LRtfgjaH1kj/E77rBxvO71UM9EQoAy5OyAj7RjNidL74gtjFMxTjIllccK4Ao7jE3htsZxntnyI2jd4/TgCbOiVDFewQeAjlJWetAMQR7XVNRjcS75v+xQ3ek8dYD31MuiMMONtCHgOCHhjaEsnJq98TRTgDDexzWCt4+obrWJFiMbd70qzZG1OuYCONkqYkg95UmIWFDXPq9AHw23UPdGCn3w2Mk0ahDcZFOsXgA1qW+9xVZgk2YWT3MUsqbkwLhw3N/WbcA7k5Lyl5B3rkbT5mdKMSA2uKC3fq8o0vu29ejeQjMlruLOKzqdpaoX0QWOMNPV+H5GtZsWD+EYULwHSAxPIY+3mgqQHjRfyHUN+Yea9O+TNjfY+Aa01dkiu/h9/BubULrz1VFKSykhtUBVwIk8tktglC0/WH9GmdhnWJNWL+pQ7MeQF6q6jdb76fCvSdN84ZyYT2GlsoMA6Je7FCyUjBm61wPPkVPtxuR/9Bl0W12pCKXB1aE0YvD/BIyj0qGa5e3yLew8vVsPtBJJrMjhygwUamZEMtBW8jTcEb4xrMK9DGB163w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199015)(36756003)(86362001)(478600001)(316002)(6486002)(66476007)(8676002)(52116002)(7416002)(2906002)(6666004)(5660300002)(44832011)(66946007)(41300700001)(8936002)(66556008)(4326008)(6506007)(38100700002)(26005)(38350700002)(6512007)(186003)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4f2VWHFLHoONDzYmA/fV0Ew3M1whoVNZS6ser8kDs2ESmTHM0h9f1pZVw/35?=
 =?us-ascii?Q?h1GKJBO7scX5q3WAd54SvFqbJ5AYLdwAuSLoipRNX3quqr3Be+Ie+6kaQ5sg?=
 =?us-ascii?Q?ikctXC6jDhKxJU8TtGWUkCNeWsHCxIvVDdb1cbL/+gK1RYzFXWV9nb/Csbqf?=
 =?us-ascii?Q?9/ELFxsUkwQOzc+EYhP39ldfYNfCSmAjyEHBXokLxGiwiSU2WJngNHlpjdsA?=
 =?us-ascii?Q?2c2G25dgxWxe9iZiStEgKaxfl3CXF+5uaJeRXdeJBcbsdj23P3XUOv7nrTI8?=
 =?us-ascii?Q?m3EfsOiuZMzIkjKjQZ/sZdXQr3/kygyPT76K7LiOdEXNEu8ObW5ADqgxLzrn?=
 =?us-ascii?Q?3d5b0vfM69/shJcHTYMDER7WT3ZJWQV0VFnp3fSBvDqTTkmpvExAdTGdqN/3?=
 =?us-ascii?Q?qfFSoUbSkIJ1M0bBVyfTklHUeIfM7+mqXoYWzqpgQbZVs6tfI599oDsurO3g?=
 =?us-ascii?Q?HI3cx1F3MfawBVM88sHR3KxRfEcDeB1WlAxd/SMhPwe3MkEQycGCaSydCTl/?=
 =?us-ascii?Q?QPD6THIgNEJfbDQs9YLp9X6CPkgFg8yksshMhYGJjaHpVzr3tblhorQXtsti?=
 =?us-ascii?Q?YdFxgYOsfZYu0rsXXIzZQfPO8tw8PtVXgjcj6vFeGOnJRqI3998RUn4PRQXF?=
 =?us-ascii?Q?SIXmxVf60UVVdQqwpNFhA23/CGZVszaW9Mi3+CQs9EybRQPfljj6xUgIM2Be?=
 =?us-ascii?Q?Fvr75w8mEmz7PIRvLjNFViy9p1Ul86/FIZabxpzNt24wYEf3+8YXPDG6Cawp?=
 =?us-ascii?Q?fK6M+tvH8uqTPHGOUjPOMp28UQGXfxXV8I02k3kg3iywMK7Jy5IFHtKlURqf?=
 =?us-ascii?Q?bijQZqh0Sjs77D8bHHVcvnCw+NJrGvO2QNFx0mpQ8kLVc0KqIk0QXyJGHSSV?=
 =?us-ascii?Q?G+ddcXShRZhhm39N9tUWBUNtuCR5q4O4LBQI3VkNQ0h1bSG9ohp0Zngg9cxW?=
 =?us-ascii?Q?fGtW5OXo4iHBe6fSdG3xighFXzh3CEwSpXZ1PgAlP+HEDa5r9loFXsw1F9D+?=
 =?us-ascii?Q?tRG+dsRipZ1A0AtFomwMeVNhIsrZkZXiqJ9fUCiBlMG9X4xApmUJPBe4RxS2?=
 =?us-ascii?Q?nblv3tAC8/751xefXiz18bN5le2577Wl1KvUo+vcXyxcwlmezcsHf1xnCRSQ?=
 =?us-ascii?Q?sZtWVGB8tJJ2hIapC8EhRSqUizzNGIRJ3ztsGq0vV38A4OuqaMPepzTS0Zsr?=
 =?us-ascii?Q?Pxzp0PzEkO4T8WW8eM9kHXJjrYjBib0PtdL9NKF7yhCXpIYgwdqlvHg9QW6I?=
 =?us-ascii?Q?ZrK+0aVYP7c8emFAfN3PehxJR87s3zwEVfmPX1LYA2zkUTciNEMibbqX5efD?=
 =?us-ascii?Q?BluOb9Suz2jaOhWGB3+IRMcDSde2bm9QtE+X/gBd35iZRuATXmmIOk4HK3ld?=
 =?us-ascii?Q?xQBJd8GeTb09/7zPSRjXLFYWSgLdkixzT+gR1mtifsCARsa4tw9BE56HtBNq?=
 =?us-ascii?Q?eAKO9E+3MkUneHM/lauVmvKJNcPEYQR4AM8qhyDT4jjCCSZ/1xo/3b2es9+Y?=
 =?us-ascii?Q?Zi9QSrTgsNi6hopCTakEqeEyv6nV3dnOwnJ+bsAmPNZnPsSorkDb+Gbv0RiO?=
 =?us-ascii?Q?OOUfStk8PRWfx3h0Ju8Se7JAbCvLRxxiecuOLzjE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0975b0-59e0-46ff-80bf-08dae2380fcd
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 03:12:43.9237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUwXiKcDy4NPsqIduKejRMN/0RGTWlj5ka3x2LLIotTiUE2qVyFx+bXCM9xX9gPUIVv3RsX3LdgTawdv3jVTgg==
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

remove the unused parameter ctx

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 6cd015a35f7c..97e61e28c649 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -420,8 +420,7 @@ static int enum_fmt(const struct mxc_jpeg_fmt *mxc_formats, int n,
 	return 0;
 }
 
-static const struct mxc_jpeg_fmt *mxc_jpeg_find_format(struct mxc_jpeg_ctx *ctx,
-						       u32 pixelformat)
+static const struct mxc_jpeg_fmt *mxc_jpeg_find_format(u32 pixelformat)
 {
 	unsigned int k;
 
@@ -1562,7 +1561,7 @@ static int mxc_jpeg_parse(struct mxc_jpeg_ctx *ctx, struct vb2_buffer *vb)
 	if (fourcc == 0)
 		return -EINVAL;
 
-	jpeg_src_buf->fmt = mxc_jpeg_find_format(ctx, fourcc);
+	jpeg_src_buf->fmt = mxc_jpeg_find_format(fourcc);
 	jpeg_src_buf->w = header.frame.width;
 	jpeg_src_buf->h = header.frame.height;
 	ctx->header_parsed = true;
@@ -1702,11 +1701,11 @@ static void mxc_jpeg_set_default_params(struct mxc_jpeg_ctx *ctx)
 	int i;
 
 	if (ctx->mxc_jpeg->mode == MXC_JPEG_ENCODE) {
-		out_q->fmt = mxc_jpeg_find_format(ctx, MXC_JPEG_DEFAULT_PFMT);
-		cap_q->fmt = mxc_jpeg_find_format(ctx, V4L2_PIX_FMT_JPEG);
+		out_q->fmt = mxc_jpeg_find_format(MXC_JPEG_DEFAULT_PFMT);
+		cap_q->fmt = mxc_jpeg_find_format(V4L2_PIX_FMT_JPEG);
 	} else {
-		out_q->fmt = mxc_jpeg_find_format(ctx, V4L2_PIX_FMT_JPEG);
-		cap_q->fmt = mxc_jpeg_find_format(ctx, MXC_JPEG_DEFAULT_PFMT);
+		out_q->fmt = mxc_jpeg_find_format(V4L2_PIX_FMT_JPEG);
+		cap_q->fmt = mxc_jpeg_find_format(MXC_JPEG_DEFAULT_PFMT);
 	}
 
 	for (i = 0; i < 2; i++) {
@@ -1950,7 +1949,7 @@ static int mxc_jpeg_try_fmt(struct v4l2_format *f,
 		 pix_mp->height : MXC_JPEG_MAX_HEIGHT;
 	int i;
 
-	fmt = mxc_jpeg_find_format(ctx, fourcc);
+	fmt = mxc_jpeg_find_format(fourcc);
 	if (!fmt || fmt->flags != mxc_jpeg_get_fmt_type(ctx, f->type)) {
 		dev_warn(ctx->mxc_jpeg->dev, "Format not supported: %c%c%c%c, use the default.\n",
 			 (fourcc & 0xff),
@@ -1958,7 +1957,7 @@ static int mxc_jpeg_try_fmt(struct v4l2_format *f,
 			 (fourcc >> 16) & 0xff,
 			 (fourcc >> 24) & 0xff);
 		fourcc = mxc_jpeg_get_default_fourcc(ctx, f->type);
-		fmt = mxc_jpeg_find_format(ctx, fourcc);
+		fmt = mxc_jpeg_find_format(fourcc);
 		if (!fmt)
 			return -EINVAL;
 		f->fmt.pix_mp.pixelformat = fourcc;
-- 
2.38.1

