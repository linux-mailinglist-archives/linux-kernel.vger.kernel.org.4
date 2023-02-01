Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F23685F8B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 07:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjBAGFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 01:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjBAGFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 01:05:14 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2041.outbound.protection.outlook.com [40.107.249.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B21A5CFD5;
        Tue, 31 Jan 2023 22:04:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOrtEwbyvA0JKfeC6dkMK8GX5a37JXhSps2R08Vvv9EjXzYZ/aTeICUT6YqLoF5c+FqKL7azho++dWTsrHHw7bENOI7nU/F8O6vvthhdbKFe7JLAEJNHExMU5B4n9gGxM098Xn3rWdbAEJBfub0pUSmQ753BvuxlCYlhu0//XgQpi92EUMayX1hStEhUD3GAfXP+2P9r1zSNHNC80R2o8CRkQeGMazYpQ6JE+vpflW1/eWpckNhSZw1DcnaCibk1JZ1yHJcQrzJ+hRNkgVC4zxbNyb4YgcKo04zwp7fOQ5XZGdKEat6hQJ9+pFI7avG5m1CmyWjEY+2CZsmPwmegGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HtPUGDrL90dDHNDgqSHbRFOdqqqZXS5JUCzQX0fw9o=;
 b=MXFBQuD33BKGfzgZUpcbqrF8jGKzcz39er1bD/YK9S9eW4aBLxPuGAdH+JDMGMTEpW/SJ6Mg/cDcMJFVzrjleWA8B9ZeUanJpBslNcE25KCcVRHxzE4Llj0iMc0te5hMZjdZPPC7a/NJQ4qo2rOQA23h4LH+QSovjQXi4iwg/ERguF187hUDMejSvERacctgIXBoeqeh1U+dBF6BVI94ALWY29eh/sZHxuhztk4Tuv0pU1IiV3CD8xuweAnSXYFWzcqklGKFBk8mlr1sqc2gPIwZd5UOrmnd55vz0mvmjq7yyl9crehrNNUQSHiK96r6CA+EdwwKB+c4zzmcyjdZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HtPUGDrL90dDHNDgqSHbRFOdqqqZXS5JUCzQX0fw9o=;
 b=CtUIwAifUDSZkPj/Ygtyw1BnVAJHW365FtVpGJ5aZatoJpWxxDKWw5iWF8VAfGIIPgnL/2YNopKRD4mKhdKcpOsrw4vglGsMqt/qz4Sy4sTeknPNbObr+R0JkkEIkuGrirJkQXD3aTeaQYa9p5fj3uRu7X5R3x8y5AY86TOcm1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 06:03:45 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 06:03:45 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 07/10] media: imx-jpeg: Refine the function mxc_jpeg_find_format
Date:   Wed,  1 Feb 2023 14:02:29 +0800
Message-Id: <f06483c5545de188aebc609e8004cf6df2291bc0.1675230665.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5b612d9f-48d7-43cd-69ea-08db041a13ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nHEanYDuc4A0XDXMqGR6Y4bDT7zpdvPcJYd5/wnoDrIETKXxeHzTAbPWP3nC0MXYMYUFRLXsnib+owxJUwpV1IGe0Gd3+HkbdhQRdYXeLoPf33UqbtrPVeXtex0aQcqzlmYLZwvZKIOxyIM5YjSlNF75CcBgF1j+B8NTTAf+jmrwx7sk5z0t/vGEWlbMeBak/pNas0hg0hVuqk54pjlsF+PVsmBThwJOqjpx19jVJK7+fm8ZUguVLyu1DGKK3OoHEKlnjXO7rMonIKu50aruhWa2W6mWW4tkP7145Ni0FeaYMl6Qqtp65LOPVNXWXfisLgsQuIysMBQLwyFVIAukIZKGj7war3jjsTG9QIYsko3ycGmxu2ZjBheBk+f648hF3h5gFb8ZM3KEKgKNFvGo0zmXZvDoNit1xrFQjegFUhrdChAA2AbHwSumTFYaMT6lytD69VmzS31oh1siE4H7Xdbzl3tVMlNm/SCAE54bNGEcCPy7uaxHfgEUf4SOcqk3ICB+bN6HVR7UMbdXMAmMoKymLYSsHS/AhtNoPIJtmSLEBUMzzb5ipjT7mqEU+QSPOQLn36pK/3PnMYtsp7FfUNSWkvsGplsqw46kl9d/z4FhDvQv9iOfoaaV7eF9TmABDCGlTbhAhYfX7BF/irn+IGQ95U9Fr1Bdrb69uGl/CKYgkFvvnS51ls3S4klsx9jMKcOiZT/VlyBk1Q52VS1IdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199018)(38100700002)(52116002)(2616005)(38350700002)(36756003)(7416002)(8936002)(86362001)(5660300002)(44832011)(316002)(41300700001)(2906002)(83380400001)(6506007)(6512007)(8676002)(4326008)(186003)(26005)(478600001)(66476007)(66556008)(6666004)(6486002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v/BWDLPciA9jQCHnzrDCT4a8yzdBvqYBHsfqZIY2jRl0u0Z/jP1g0lM5yGfu?=
 =?us-ascii?Q?D1t68YGmxDS1yHTL20irxxxBWWhbZl/5GflQNIdvqzoik5kB1lmvJQ1L7hr5?=
 =?us-ascii?Q?KwBvGQ4giHLebqe8/ax8jk+zjQISLh8cO8iY/uvgoL+OYl/DvoWIuc8MqAe8?=
 =?us-ascii?Q?gFPSGCluDn7nmvyO0nequDGknFEqJVIyuLjF8IuYdgAwQVI9alrQnoSKJLe/?=
 =?us-ascii?Q?fh8RtfVypQoUmbcZJA8X2LDjgPIFxJ3Q+UuAcpqcF15fINvJ+9A7ESu+EZo3?=
 =?us-ascii?Q?k5M33wgZoAjRsn/Kxe3VqiUFBbo1weiYOeRxuWatigk3j7UDfhH2z29B5/I+?=
 =?us-ascii?Q?EbGouH/7vfAiByPaWgjeHLv5S7jf6ObcCqsRvkKmG4hMaZQTj/wCwPfDxLct?=
 =?us-ascii?Q?JrGDeVJ1QDYo1jGqnVuLGgnKTKb2iKF4n8ik0BIa++ZXqsWYe+3EPoJSMpi5?=
 =?us-ascii?Q?XfGAC2f+mVB6H2L8unCrsFRW0DRzSFuznlxGyu+xST+19F8xs61JphcPlvDq?=
 =?us-ascii?Q?BwI9LJKZV6ixfmt23PGco4lJ6Oak6wLJYWy7uvtvUt7h8DRdYReLw57MZnLL?=
 =?us-ascii?Q?CtqmQMfVES6Ofo9NbrkZUpnHK7a5X//A3a/2ND4BkCKvwEuk0+uM2UDii2eh?=
 =?us-ascii?Q?knVY6ua0+7yXcrZwg4/nWLbIxbeUnPV/xH1uJPxu08BLwS6HTID17rbTQGs/?=
 =?us-ascii?Q?fxNYe8Uu1hYygNHlczyA/IMGjEb0N3PdRvkKHb/7JuZ6rp2ZVCXBSfO6NUCC?=
 =?us-ascii?Q?0dQ4S0p5y8NYnp2rtDQ83Zr04+3qapGp3HvuUh1oIi4vNXqttymm1S9cKwqw?=
 =?us-ascii?Q?p05kFq2vuN8kd4lLJA9CDl1/0wgOxPPYHeXm0kUO4FadQpoYzxpdRWnPJsdZ?=
 =?us-ascii?Q?dRKBSVYBULmr1BmWW6Ex3bfqlQCYFd1mLmbv70qrLPgJ2D6vyG8/vN5kPmqs?=
 =?us-ascii?Q?3STgA3/9yZluYt+dSHw3pwk7rM0Dyw8G4g4ybktNP8hY/fm/+S1JlHws9A3B?=
 =?us-ascii?Q?xH4ZAaDczPwG5OEV/SFYZd1SPviYhGkdvGVk/KlxbE1oGpmPIRtnnZ9p9nRg?=
 =?us-ascii?Q?baPpWgI+qTokEwSxqbAjmvrGtLEZGkMcbvPdEHmiHNY1MA11v/miv1cnnqb8?=
 =?us-ascii?Q?Y1HovQFg0PD5fYOgNMLVIcajmOcK/nwC1rhpoUaFw+JYu6Fh0FxbPU2tfQBX?=
 =?us-ascii?Q?gSTORGg7jcK+mDGvfvEoC3DzAL+MBAqP3vIxWwqOb3fHI54v3euri+q1IznK?=
 =?us-ascii?Q?4gYtlP3x674TQQpuYWQl7PvukSeGWpxy6rBMllFw2IGOw7yjEf+bt/L6i6ux?=
 =?us-ascii?Q?ZPRE0vG74g/EDAlw7QgNvIBGbQ8WI3ydoF36wZ92AsCICedxRmsS5MlYW67S?=
 =?us-ascii?Q?vBRVuQQJAsg7y5C5KiYJQvGQ0lfb1hJNB1gBXJu/ozW3lub6w4yq3RN37lOH?=
 =?us-ascii?Q?cGTVxqWbOWcm/J+tM/c2abIZ0iF0+X1mcqYcf9W96Ri03LE8epmC16CCtNfJ?=
 =?us-ascii?Q?shl4E7tdKFpY4FxOX1USw1rx6AifB6Wrz8OxV+magmFx1vUWII+0KJBXjPLG?=
 =?us-ascii?Q?zJhTvilU8JIq6YaRJeX0OohnLUUq+2ukTPsllRVX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b612d9f-48d7-43cd-69ea-08db041a13ea
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 06:03:45.4566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nQSti0SC1n3fpselcbEq7qdGVVgZqpaY8rNUvKPKkYN0QtAAqGsZ2hrU3714JxG0uQN1cn5gwxSe6NPCEFg+g==
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

remove the unused parameter ctx

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index f085f14d676a..70b6eea733e7 100644
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

