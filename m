Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C871666D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239916AbjALJKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239991AbjALJJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:09:49 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB854D4A8;
        Thu, 12 Jan 2023 01:05:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeOb3L3XTnOj16xIn8rM7nQ8HSGzIbY1INaUCnWSQ3C91gqaG3vNSIwkbllse8dQ8kIM+LdQF70Z3oAHZxe3ZjZONnwsBu7QRpbOg4Ghc1rHU31JkMtPq/OAxndmGGU5ccVhr0kN9SEwYVViLewt6Z/eT1a/g25TKwsUM7jnKkwDLkOAlTuU7InDNN93dLB2f6sUzU1zKfr1uGkVAc7l976xHL3bIqJAuyLR3zuf9mB1rIfdHJ2SQKuvULv/lbwgK9118gM0sJU+a+rRHV+9zigy8kR38J29aCPXTKHKx6bcheg87a3WPOWFlh/z6AHEU1Rp69F7xKBRJiFbXkXw6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8LUl6sWj72DEsDN7yyXOzYWigjgz0tWjhCW6KdwStY=;
 b=FpxyI61UBnXQjFYVq0DsARdIERlCjb2hPck6MWxZjEPfxntxUjN428mdGVUkn3mQx3iIVxx8GwFATf5tlm5COyv8YvKZst9C01LyU9VRX62t0jn4kYjBV4kZeBgNccqcFlevsn3Syb6FjrJqmaT+jzn0XXuNUnP8uNZFst46NeWfZVSzX7z6RqpaEmg3At5JUDJtu2J2ky63klR0MgpNyMUyMNT5oIQJxTDfI+vPl5gbvIk9Gc13Whu5Ze6dKaluGFRlEbgEBuDdZpBi66I5W9320RZzwirjWFUbqVRAkgPiyceDHYoZD+t0EprIVQYn+SmoMVKDlslRvCGPskho6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8LUl6sWj72DEsDN7yyXOzYWigjgz0tWjhCW6KdwStY=;
 b=btEzUxwKPovfg0JYp003ZNS+w27ZiNA0nNk0uIEWhYEzmjarm82em2kzwfevyVie3Jn7xr4jZs8F0d/eMGZH91lR9rw3P9pDeBYnJVtNQImgSoPG92XUjvz/8/XwU+6JKf0I35DPQxcj8mhd6HsM3E9JWZclFpC3EWii5T5rpN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8875.eurprd04.prod.outlook.com (2603:10a6:20b:40a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 09:05:11 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 09:05:11 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] media: add Sorenson Spark video format
Date:   Thu, 12 Jan 2023 17:04:47 +0800
Message-Id: <fb29e0170fcbf258136566d59aaa904d0da559a9.1673513975.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1673513975.git.ming.qian@nxp.com>
References: <cover.1673513975.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0200.apcprd04.prod.outlook.com
 (2603:1096:4:187::15) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM9PR04MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7f9ea1-731a-4f80-80c4-08daf47c1c42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vh2pavcgV/suHaPf9yHhu6qlz4duPxXj+swpa41/9HVGB/L+vpsLZzeTwl4hMU26yQNmf4TwQduMIYIN10gFLpGj+oJhauMyxl4TFL/gjwvBvDk28WkEot+Nw3hmm4qiJe0lDRPMeeKLyd0oe+uEQp2TTht6psAroeYXhKXorHEHvQk8pAYw7mJNfyy7qwNobc5haaciBhljYJBFD9OrQRo7qtrvDaRjMzat1o4BOQzenjYwnFLxzNi8NfFZw8GIynCCPLfwGqRGB1GuclShY1qwEsfM5sOuzqgkRixDtjrXJeH2nzwklzzQ8F9UUFVBmWmzbOUZQt5mUdyvVIhyp7Se7PLRhW5wMSR8QDH+PDFxFQK2Iybqfvbh3mlT9WOeckjWee6bpmaDGKotqMmSWF0rC5Cws3lazIZu7l1ko68pPmZRekLyRjhw7rwyjaKfhC5arCmZ5UwEwX5MQiQnKBf62TB4EkwGrCgp4qBPo+BUTWfKV0pB846sd/oZUoJoSttLdm+3s2mi4IRmmGHKN//u9nnA5Lh4DJDjQscESBRWnLDfAK3aZz/yEQtFdA8HqgRw6zm+nPB4xkYD5worBYCRmiVFYrTdz5zoiZC0h7CI7UMk7JIciF+8ufZbmD70TxNo+g4yRZlkKSxgggHVUihn52WP50MV5SpmMVombOFdQH5LrNHkVGCzwpMJ/YyBNXplx5M4qYTnww0kpXFI2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199015)(38100700002)(2906002)(6506007)(5660300002)(8936002)(6512007)(186003)(44832011)(7416002)(41300700001)(36756003)(26005)(6666004)(86362001)(52116002)(66476007)(8676002)(4326008)(66946007)(66556008)(38350700002)(2616005)(478600001)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EQ/qboC32imFKWgQYq99hzcEtpso5xIDyHJvCoAG+KHkk/oO+Pr/1Ml4NG6B?=
 =?us-ascii?Q?INWhRNeSFMdcSWRxwUPU9tR/6teNgCS79o64xkFSAn2tlRVvXR2zBrIt+pqi?=
 =?us-ascii?Q?s3CfUh6IK5g0jvhpiUh8U0WfWoaYpOn9MkVPeZj/t3wl7OHWxnqI0dupi8qv?=
 =?us-ascii?Q?xKPU3PnqSJTcQbqoiaFHG0sh1YdC0bmjddIV9eXpDb/C0lHjnMXMhL5TIHf1?=
 =?us-ascii?Q?OqxkNGkjyWRsZW8qAsjhLvK0mSCskQVnPM3lX1Xe6yb60E0+Jk4sKk7YG+AO?=
 =?us-ascii?Q?1+yeXT1jyrTXzXgz5SHLHsmggp/UUZBe7HposQ46GFv3MQV0xz/9zXiRKAaM?=
 =?us-ascii?Q?25y0UY+XYh5xbQts/53NjzYtOK2vhriMHjsXOxuxH/2/iDtUnwXJNY9XGSA7?=
 =?us-ascii?Q?2CaG2L/u4C08F3ECxJlMiaAnjRBQ1N03MkjRRE9GGJmonw8w6I0QVKiGif7j?=
 =?us-ascii?Q?3pWTkJk6wNUrFsqvVDe13CXsJYdTbySZXEQGSNcLveAwogQi3SonH6CO4tnH?=
 =?us-ascii?Q?i6adArjEMKGXR/paq3+ArFTMOr7STQLOUfq5udp81ygPkFXLwxprwLcVhPCE?=
 =?us-ascii?Q?xNs9Y6COlfzkTgxAec/Z6+Jxyt4KukeJp5WpseXWUD7s5by7xIyjuW3qMqjz?=
 =?us-ascii?Q?IX5H7ddjxr4rfCj0X+ssNmw+OinOUNlxN9PvMZtHOPWUn78ca6pTDTjbic+5?=
 =?us-ascii?Q?5hq1zVbZ5iLBmVXzbP4oEexDfzoBXVNiqHsOLqdbCzAY6XsiZOIpXHr1M3I1?=
 =?us-ascii?Q?ohuHHBKyumCqmyJHD4ZwBeUsTT483nmokgkkWpWaUgDavqL1ozoqs4XLFcOw?=
 =?us-ascii?Q?sUIiGJB2Sv4u8pSR0buOmkBH+07LTvrF/Tg7HbLq+ilA0bRxnUZrxRfeSWXX?=
 =?us-ascii?Q?OISye2qBzEeE7jIRnMrcF8u03UvYZCT6nVhREbIRI7dtMBZUDGgg2j1gxNB1?=
 =?us-ascii?Q?PQVrcTWZH8edXHR2T6QYps+IJiIx9sN85MP64hpiJPdwt7R96ikcbEsMsahY?=
 =?us-ascii?Q?7jB8zxUga/2KdoILQPLY74Ym7cT/XOnXoqUrTu51F9K5phY5reMtI2MvC9/w?=
 =?us-ascii?Q?fVDm8u1S+zrunsJy5uXljMEnvfZTgNzTi17iyxG4uYQEliojY0xuwzO2yKIq?=
 =?us-ascii?Q?S38Div8xVw2tr/FsjqtRUPAHyACY/KJVwOH/Ku9L2NK62DdQ2dpXj8QfipGK?=
 =?us-ascii?Q?QOlNrLE6TnTix4QbWRKXzIEJyyXzLnKYhk0L61cRrrnvGcU7/eIldjCE+6NZ?=
 =?us-ascii?Q?E0jhpqvrYoSxWHw7s3R+VlJaE3l8YUGVfvg0F82i5tkuQuZhhL8GtCY5SNmM?=
 =?us-ascii?Q?RbKDYCTsPpz8apPWyNhFzfsmML+bFhnRS7eb7/kczcycJm2UhEkjWeMTt0zC?=
 =?us-ascii?Q?v+cqExPnZgy6cMLpB8CO5N3mcHyAzN0UQnsoKp+cvfuW3ztx3ar8shSj0On7?=
 =?us-ascii?Q?iWfat6M4yVvfj2ELIC3PIzIj5Rtv9f+EtPH88DRIu2S10P1BgFc5UUqwz7p3?=
 =?us-ascii?Q?D/a/ti/JSK+CU2n/NT3zPr41wqF/paZukMp36+7YWLEAEc2Rb2D530/CPHok?=
 =?us-ascii?Q?zFqyoKSc9D+mwRPthKnE5iGmLX90hG8CU1ZPHPAm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7f9ea1-731a-4f80-80c4-08daf47c1c42
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 09:05:11.5932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LK4/PKh2Eb9g5TQX7v991IcOKlUIvZ3ySNF3h5HUE6brd19Lcq4+nXXp+j2slTcnFXZ6l+s7WTf7HNBIz8RJ5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8875
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorenson Spark is an implementation of H.263 for use
in Flash Video and Adobe Flash files.
Sorenson Spark is an incomplete implementation of H.263.
It differs mostly in header structure and ranges of the coefficients.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 Documentation/userspace-api/media/v4l/pixfmt-compressed.rst | 5 +++++
 drivers/media/v4l2-core/v4l2-ioctl.c                        | 1 +
 include/uapi/linux/videodev2.h                              | 1 +
 3 files changed, 7 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
index 506dd3c98884..a0230f357680 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
@@ -88,6 +88,11 @@ Compressed Formats
       - ``V4L2_PIX_FMT_H263``
       - 'H263'
       - H263 video elementary stream.
+    * .. _V4L2-PIX-FMT-SPK:
+
+      - ``V4L2_PIX_FMT_SPK``
+      - 'SPK0'
+      - Sorenson Spark is an implementation of H.263 for use in Flash Video and Adobe Flash files
     * .. _V4L2-PIX-FMT-MPEG1:
 
       - ``V4L2_PIX_FMT_MPEG1``
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 8e0a0ff62a70..9b5b04b8aa69 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1472,6 +1472,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 		case V4L2_PIX_FMT_HEVC_SLICE:	descr = "HEVC Parsed Slice Data"; break;
 		case V4L2_PIX_FMT_FWHT:		descr = "FWHT"; break; /* used in vicodec */
 		case V4L2_PIX_FMT_FWHT_STATELESS:	descr = "FWHT Stateless"; break; /* used in vicodec */
+		case V4L2_PIX_FMT_SPK:		descr = "Sorenson Spark"; break;
 		case V4L2_PIX_FMT_CPIA1:	descr = "GSPCA CPiA YUV"; break;
 		case V4L2_PIX_FMT_WNVA:		descr = "WNVA"; break;
 		case V4L2_PIX_FMT_SN9C10X:	descr = "GSPCA SN9C10X"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 3c56b81424f3..262ef10cfa02 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -739,6 +739,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_FWHT_STATELESS     v4l2_fourcc('S', 'F', 'W', 'H') /* Stateless FWHT (vicodec) */
 #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
 #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC parsed slices */
+#define V4L2_PIX_FMT_SPK      v4l2_fourcc('S', 'P', 'K', '0') /* Sorenson Spark */
 
 /*  Vendor-specific formats   */
 #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 YUV */
-- 
2.38.1

