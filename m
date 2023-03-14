Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A53B6B8F6F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCNKMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjCNKLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:11:54 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B8099C26;
        Tue, 14 Mar 2023 03:11:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5bJUYuCx54P4WV+iKgE8tlLAgjBpp8lcOko/mo832N/KnOH2iHDyMhSE3tpKxwZcYg9CQCP/AnWuMIkRcODP1HS4UIybQ860lKYHD/mbcG5lYXEq0Ld3Wqtlu3gWbwHPEGjkeP98p9EBBLV99QcOYgpuZ6ioQ4x/SI8JqNvqsmTDXwCFxWOobjGS3u7bUZ+1xmzkPp0bh9j7v0bsIVhHm+iZiktokNhngtMvx1D8GfmUbuYPio51GsGQdpphN8LFaANX+TUoZvdwcL+phtQ99Hxs/hS9wdGaGLqU4Q5WNZOSvorq/iYC6RgqC/grsnH1KBx3eUhsCkCtGreAUqLOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrCCkSbdN1I0P9qdCM3YoSQ4HPlDb++Simk14IaHDOY=;
 b=H3v8OUsreu17B01jF9fSQWnyU4UHujXWZH5PZ0Tx6TQQnX3DNVKo1Zd6p5uVVTLvjBVsto1T10XPMuYV6g1pUfc4JvL3aC18BvUkWfsRQjD4MHYj/tHRHgfiNRsdyyD7QKCFIfjXIPkg6BGYXO1ngt5pFvD3K95q937/qbeve4Kflr/je3fOQPZbbESF6yQRIAPZvfzW6CAOiElOQxgzd70wXJhOl7o11v9zrbiKZ/CHbERsR73PSciu3lVf7Jk7qxzp6Y517pmrwZurQEX7f/2QBB6+qpE9T2Kzcm0icWRTz5g66HXL7nIofST6zxQRrYA40BJGx5SDx7FV1MDsXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrCCkSbdN1I0P9qdCM3YoSQ4HPlDb++Simk14IaHDOY=;
 b=p7T4KogjnZ/KvVKJlSRcMfkpTcdmbGgxxX3GswDOYzFHqsO8HQ+RiJbRDICfGB6Oqd0dHOHuFjzip/ldJTLK0We/LuJIuLE+kZk6iKX7bg+4peih2qMgUerniXKEfa8LLRmVQaYXqkhv0uTb6VjEhXDVBj9VbEt7ee9PNHcRo04=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DU0PR04MB9346.eurprd04.prod.outlook.com (2603:10a6:10:356::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 10:10:18 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 10:10:18 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 05/10] media: Add BGR48_12 video format
Date:   Tue, 14 Mar 2023 18:08:48 +0800
Message-Id: <fbd891d2910a1a681cc66d196bcf36416a3bfe90.1678788305.git.ming.qian@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|DU0PR04MB9346:EE_
X-MS-Office365-Filtering-Correlation-Id: 986c829d-867b-44a4-1ab4-08db24745034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: svLv1yZU6923YZQ7NhUooRXFSlezLCGQ+WNsyXlV5Ju/ilxYdZkBlYxS+F+auNpvIywir0doPRAbStoZtp+PrMfXI6V7BQ7hvQPPRPy6+sQLP8foqLq5nMPmCZ6VIPNRgGnqSz+m4OZ46FrKV2gtQUR+HNg2b0R+A8czojnuZt4a4JPOyMauEaRe6Wydz8OwSPO7jfjQ6E7YZjIlYWtpeAc6QJb42Jy0+sf/t5iA51ofK+dS1kMI/JW4AgefQGG0ptNtLaj5ih52s4flPu1BEGf+uVXDdUJ3jH+2XGUeE6U5U5Vg0g1q0KlaSoXmxyAHsPxoj2rTSwhhKuzPZ+2FK98z+zRFaLdSs2w3oxKzzD7dwMb9OmTXyAMCONU6YRdSlJAzk1BNfPiyWFSV4W3U4dJp5BM1nrdCc+5C50qFd2mVpiNKSb8v0z0qDqdERrL3BDjIs0cbe85F4HjbINr7yK2WDyJlpKqavS1DaktozeG3ax4qvnReV1mTt1e+nz5ikOuQe8Kihua4KxSDcrwsaLGfsldvt8Es3AKDLSlZemI3cgdfRYgm3zbIZoFMNICQ8GKSugYKa7gveiG/B7aPZu2MNIseVlXBWq2+TJvQhvBD1E+1vC3l2PKKK2XOLaF6+rv9xxy1ZMYgB01/mMfBFL/f3GNZVTQtp9C9au3xHZtmaBbyLY9iReQXWpaH50E/+NZn+GQ7gpaZBf4NlRyBWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199018)(2906002)(41300700001)(83380400001)(36756003)(5660300002)(7416002)(44832011)(66946007)(8676002)(66556008)(38350700002)(4326008)(66476007)(86362001)(38100700002)(316002)(8936002)(186003)(2616005)(26005)(6512007)(52116002)(478600001)(6506007)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZqWDEyc1hspqTeYg4l2qGWpb+7GSg62L6EcwnKU93kIcMwvCo0xhDzzDsLLd?=
 =?us-ascii?Q?PDik1xYHzDH5JT1pS5v/KgR7vUXelDutDNvVz9Orbp6wc8JIzgl6jHhtow/4?=
 =?us-ascii?Q?LiEgUwY9RdlrENF1a5fotcUxcs44WBW9wt7sjWcYGwC1k5OdlJGaajHvejbX?=
 =?us-ascii?Q?SlGCA21GVkwZZP+kNPbDHHWPTSJkdP49hQHFqHGHSlAn4BGIPQEHeXFaBS5m?=
 =?us-ascii?Q?9cVH+121fX0WK4BPiVJHglzyizbi/cyXRpR6Y/UEDFOmSWVlCBlKD9QvTmG8?=
 =?us-ascii?Q?lV+zylOqUJPf7cZV/3277znMolJVKumUtVOX7FukMOeaV81ok5kUQurpJ3cQ?=
 =?us-ascii?Q?UsjXn0EeX8EXJ30Xe6CLrpo4IncU0ALGm8UJzGTdxngAoYxCfwxidp6vjUEm?=
 =?us-ascii?Q?Uikmt4sH8oCSTazv9SX8V5DqFihv59AlnuVQIRocGVr7NUISms+UpG4FUvs+?=
 =?us-ascii?Q?4i3L5fvFTX8D+I0xxWxL7VeZ6RCtYZqeDSX6iL+yu7wiRwQ/tfl9yRchI13m?=
 =?us-ascii?Q?fTIkI5DUNViYvDqxUbSxCE5/TRcQq75zhRUWfdh8IMZpbMxkqicguhyp2QI+?=
 =?us-ascii?Q?oiqCFFxJpUAu7rHgZYmYLZ2JGLvFt7c4ch3iqeOHZpDIswhG7sMto47JAMS4?=
 =?us-ascii?Q?x+NxS/JzHkgOIke+VKdk3BikOPWYVCMt4VuVSExJbIWfVLLfYnDQlD2bgZkp?=
 =?us-ascii?Q?JpLbIuxdkSlKJOJkOxCBXG41OUsLkqbyATOTxuYk1aDzyTqbIYjiljMAGf44?=
 =?us-ascii?Q?NJPTfAvSXvaDAECxHnig2s1I9FersWvIpEnwJf6VM/wYwgKof2/vtRxq/Q/x?=
 =?us-ascii?Q?g/SmwtVY7B3G8ZpWCkj4E14Yw93VPpfC6Zvy3qrK0bjHglo0Ntv+bKUhYSu6?=
 =?us-ascii?Q?2usdNBWY2tt8ie1uG7UJst+uP2fB+9yGsWIlItMru/NsibC1rbURBrIQNl/q?=
 =?us-ascii?Q?U5DrmVH2omLyY739dkiSkW+dF3QYWDwxPFIVMELFcXsw/U8/RqxdkQX0sdyl?=
 =?us-ascii?Q?gWGav61+0GFPh57pD0BRwm8oRKX2WaBuJSe/oRDvqUikwr+JJLG7l6XLXzBN?=
 =?us-ascii?Q?foe2puTqZaRljrx+E89vGSqsh6YO5eERAQNDd5pECk/ben8qUILhOdiaYPyx?=
 =?us-ascii?Q?7zfR6pHqO/YZ4NdGTVQ7sPWv+wBSleprtd7holEUmcWReLbeytJbLNnCFBR3?=
 =?us-ascii?Q?DXt53nImGpmVP6aJPQp5sU80yFCPz/aewTFkcSZmelQzc27tdVHDmtKBe/Xj?=
 =?us-ascii?Q?8Oq3fFWr1oThlVSdjBxqcvx0KTggw+GS/sYjCzYEodBmLwhauZHXMeJJ4rhe?=
 =?us-ascii?Q?Fz0hoi2vr3ThTs95DWrgxcC+ftTXqjPJLFfHEKcYnDprSwF1rymp/H3KkMDq?=
 =?us-ascii?Q?X6GB2tde8bdgxDHftr80WbrBcvAC3sPw3bqAoR4V1y3n1Gt3Dhn/GY6bXdUf?=
 =?us-ascii?Q?ws02vcqxPVzbHnEahs8aSXDDn7xIbm+vW74RLmR4kpI0IQk+qfh2RDoENA08?=
 =?us-ascii?Q?f8StBEWHvlSgcQvJu0oQSOKYsR6fO38FWVRKP8OC/Nus54ATaWn+/Oocf9b4?=
 =?us-ascii?Q?H8f2Dh4bb41THVc8cIOolJQ14HOCPdqlb8NpZZgP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 986c829d-867b-44a4-1ab4-08db24745034
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 10:10:18.8298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxYrY+ZGg5+fkevV/RwyQquRajx9dNgdLtUaAbfAUK4LWuYZSnK0ImkNdShlHlldSNLghUyENNHV+fTk1FdMEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9346
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BGR48_12 is a reversed RGB format with 12 bits per component like BGR24,
expanded to 16bits.
Data in the 12 high bits, zeros in the 4 low bits,
arranged in little endian order.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../userspace-api/media/v4l/pixfmt-rgb.rst    | 33 +++++++++++++++++++
 drivers/media/v4l2-core/v4l2-common.c         |  1 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
 include/uapi/linux/videodev2.h                |  3 ++
 4 files changed, 38 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst b/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
index d330aeb4d3eb..fc98a10991f1 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
@@ -956,6 +956,39 @@ number of bits for each component.
 
     \endgroup
 
+12 Bits Per Component
+==============================
+
+These formats store an RGB triplet in six or eighth bytes, with 12 bits per component.
+expand the bits per component to 16 bits, data in the high bits, zeros in the low bits,
+arranged in little endian order.
+
+.. raw:: latex
+
+    \small
+
+.. flat-table:: RGB Formats With 12 Bits Per Component
+    :header-rows:  1
+
+    * - Identifier
+      - Code
+      - Byte 1-0
+      - Byte 3-2
+      - Byte 5-4
+      - Byte 7-6
+    * .. _V4L2-PIX-FMT-BGR48-12:
+
+      - ``V4L2_PIX_FMT_BGR48_12``
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
 
 Deprecated RGB Formats
 ======================
diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index da313a0637de..16d3c91c7da2 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -252,6 +252,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_RGB565,  .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_RGB555,  .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_BGR666,  .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_BGR48_12, .pixel_enc = V4L2_PIXEL_ENC_RGB, .mem_planes = 1, .comp_planes = 1, .bpp = { 6, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 
 		/* YUV packed formats */
 		{ .format = V4L2_PIX_FMT_YUYV,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 6543cda5815f..6d9599391d7b 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1302,6 +1302,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_RGBX1010102:	descr = "32-bit RGBX 10-10-10-2"; break;
 	case V4L2_PIX_FMT_RGBA1010102:	descr = "32-bit RGBA 10-10-10-2"; break;
 	case V4L2_PIX_FMT_ARGB2101010:	descr = "32-bit ARGB 2-10-10-10"; break;
+	case V4L2_PIX_FMT_BGR48_12:	descr = "12-bit Depth BGR"; break;
 	case V4L2_PIX_FMT_GREY:		descr = "8-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y4:		descr = "4-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y6:		descr = "6-bit Greyscale"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 8a6430bc4a00..3c5acd72606c 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -580,6 +580,9 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_RGBA1010102 v4l2_fourcc('R', 'A', '3', '0') /* 32  RGBA-10-10-10-2 */
 #define V4L2_PIX_FMT_ARGB2101010 v4l2_fourcc('A', 'R', '3', '0') /* 32  ARGB-2-10-10-10 */
 
+/* RGB formats (6 or 8 bytes per pixel) */
+#define V4L2_PIX_FMT_BGR48_12    v4l2_fourcc('B', '3', '1', '2') /* 48  BGR 12-bit per component */
+
 /* Grey formats */
 #define V4L2_PIX_FMT_GREY    v4l2_fourcc('G', 'R', 'E', 'Y') /*  8  Greyscale     */
 #define V4L2_PIX_FMT_Y4      v4l2_fourcc('Y', '0', '4', ' ') /*  4  Greyscale     */
-- 
2.38.1

