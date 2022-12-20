Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C507065195E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 04:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbiLTDMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 22:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiLTDM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 22:12:27 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2040.outbound.protection.outlook.com [40.107.15.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E609538AC;
        Mon, 19 Dec 2022 19:12:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOmVkCpKJy0IKE6Ucd1ixAZf7ukTBPUVYb8KWxijL3kbSKgTNopGpkiCZtHhJSm+20gBZPq6FlZrsLYpG+vdpA2QYjZjAdjCpNpME1Y0y4Z5zsywWnkKtDIAropdodRy86F/KrFnM6ivB99Ygwtwp2gS48C508UVO4BtgWML1VHdwhbHS6tJw3qW0ZS91NQyqd9CQtB9gzW27hvodtQ2MFX4UknGOhu20xVrc03b66PUroG2ppNVGU3WxBQBwQWGsusN+62py/c5otq75H7dtZAbPGXtbbYm8y3BBNIjd7JdseFKqBXAjYz3HTuUN+VaXSUE+BJ79uPU+qMw16Ec8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miYxDbfwNBWe1KNc4EwmJT97nAHpFZhA3X+bNK+LYGc=;
 b=nQWuVxMLh73tZvp/wls8udG1rgu7rbwq2RiHYFYQ+Txy1rUflfupqSyE6GOinJhJhPq2pTGROzgN3ZJvt70pDHI1luM2O3cehwiAd5vSAQj84BAZi4CEyl213ESr1EcsvVBgUhsQ8vDV28xkMYAyFQgeUQ2RnOy8yQ00eieZyKuIVWV1VGhK08abhCVmjzSbpkxa6PiYsqEZyGU9jRlqkJMHWngBFDLGib4ZEwX7ohc5Uk3Ifc+iqihF/V1t19yfNddzhKGvbOKnAKKzFQDMyHw9bHQZLnPQa6WsLmTmL5zQ+T3B7dnNIedI99fKexUJKUhqoV16YUQIBXsZf8OckA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miYxDbfwNBWe1KNc4EwmJT97nAHpFZhA3X+bNK+LYGc=;
 b=KI+SD36FDUPc2Z+yfACfOZBxUyFi24X78zBugJkNWaULTCPcaIiD43GkYbBDMvTSm2tGPHP31NNpP6lhOYe2H1QsiFH/zCFY2RTp+LF7HEH58UbVrk//dMrwBZR3a6AQbvESzhCjNdojpVn5BHFcgK7seiJXxM6G+c7zWgUe0fo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS1PR04MB9405.eurprd04.prod.outlook.com (2603:10a6:20b:4db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 03:12:22 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 03:12:22 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 01/10] media: Add P012 and P012M video format
Date:   Tue, 20 Dec 2022 11:11:31 +0800
Message-Id: <dfaef3c8eb29108b1837a1959d598c8b0db63422.1671071730.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b330ff6d-1d37-440a-fa31-08dae2380181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UsNDU6TWXDTeS/vsoZS4wmGfatGyUjWsQXL31fxF13wcIk/m7QcQvlmHHvr0eBsJqyt/QnQ/uPWXfCf0lI/GYiDvj7cqoWtKYjEZIIR9o+kaI/38BUmdh7LArXGJbJmg8mJF8Ydc0y3H7Of4jz5yslyNG4hyGQZsMW3JVNwUggu4ikxCqXX2TgtzIA4vnYFubA9CECFLGjpvzn2km/VnkXTDtIdXhJPTkjyXuKRYh6h5nE7C1y33bIEHEM+0b9VqJyyxunElTjZ8l1YQBXhuBY2SGPqaRFNoui36010SRyx72AOON+u40x4toajwZVE6S39uSzyG9/ngKsqaChjpOVIbHTtbCgyQXlfvpffG0He23Eo7SB2YbO6ZiFlSFN2W+QjxnHOcltyxmU52/9ZltbI+QDXi6d6UgfBzVhPDIUHlb/5T0E4bHo9ez4/3Ym4U5jiBTW+raYpAqCTXuXhB8sITLCX745WZ7TsRM+P53zvGzLcf2K8P+J5LlhhAJRXO3/vakrdUa6tVkrju8WXZkRALOSwn5YwUe7ATACuKfBQwdK0WYDwZXMOr2H7zia95AZjBUKoUmXiO9KflNjGElduy4I3U7AIgxb4picXCrAfJk1gtaFmY2jTUfpKFeiRw7JuCIz+u/Hh2fY85v8jtlXgFVotrZGfRO3nyyboqinkR4sN5VQh7398lgJYNFyNhyIOrUWR7465++7XuZCfJlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199015)(36756003)(86362001)(478600001)(316002)(6486002)(66476007)(8676002)(52116002)(7416002)(2906002)(6666004)(5660300002)(44832011)(66946007)(41300700001)(8936002)(66556008)(4326008)(6506007)(38100700002)(26005)(38350700002)(6512007)(186003)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VijHsFX9NQZOf51vJdY1ptlcsoTnZFhutIo4F2+C8i4AXsFxNtcY7rtVIKwj?=
 =?us-ascii?Q?rbaC9Ge8oBUJhQwi7za9gEi3JQMcwqzfEmvC0HYGD9waUwBujh+eOsATnCAp?=
 =?us-ascii?Q?2UhHwLMqFqVsZU/r2r0rGkuy9KE/d8n7fNKOwQN+g0yi/hyGoGFxUTVT5uz9?=
 =?us-ascii?Q?oMhcbMetz5b07YTPdrc2SkRHwhJRdcIWlH7XVXRfhBuPuM91OYx4nxKByvHW?=
 =?us-ascii?Q?KaC/uDBPJt/2KwCgzkR1IJwm7di/G1spw4ynxPJSMaLctJmFYSUcdxqKpcQh?=
 =?us-ascii?Q?EmUXQhCG9mwMFi7WosKTpO2l61OJT1IyFD4WMN/XkgjoEiXZwzTlIfbnNOpG?=
 =?us-ascii?Q?5bdDqpxbruqhdk7GzYg0upG6qSwYlYY1Krbs18JPArwfGotnWnOlazH5HsrV?=
 =?us-ascii?Q?a1+p/qOw50vbc0Rjpg3U2P5sHwnz91VN9ZQ3+AE3ctkmhBNqWiZJn1LyGsvJ?=
 =?us-ascii?Q?uykQgxoRg45szqT/kbCDzYz9s4Z8/H1GovnKZtaiKEVSoF1Fy4gwR+DmASXE?=
 =?us-ascii?Q?8zDQDEk76jOJ2b3Wp7IPtSUMW9FQX3Ck5MNAkEq1Dj/TlzJFG4g/yNwIstYm?=
 =?us-ascii?Q?f9PheiwFGXkvbxHuOD8CHxBH+Q1H/aID05GZQYq/T9C9zPa46xJ2zjkk01D0?=
 =?us-ascii?Q?mFBo+RTVmImAfOnDXER7phWdRkmrMHF1qtNqVjkVQQPspvqR5Rb+NVZ6tNiF?=
 =?us-ascii?Q?B+3b5jHsYUOejNQlyl6Q9nO6HPC7aoPjwcjrDwLqdBhBU/EnhdS3/u56Pl7x?=
 =?us-ascii?Q?cYbb9WVJ7iGDILmvb4MNXROJZk+mhkvxEibKn6aHjkKIkz77j98c8Xeb41od?=
 =?us-ascii?Q?nTxndh1Xm8EwNyyGx2u3NwvCGd+SljdbAVhUNtlysdNUESMR9yMm+pN7pqL4?=
 =?us-ascii?Q?SnlAacvTeWc8aFU2dufKdRYyBoO8HlPtQ2HiczW8OEvmUkPxZrwTLQG4QDSM?=
 =?us-ascii?Q?T1/o8ZYaugOrYi2lPbp2+ohjQjq6VICNSjyiR6p8viGTJ9D1UGJxUJmd3tAS?=
 =?us-ascii?Q?qqhYURrUeQ/5jsaobuf6WlLgQDA5pub2sFaJ1x38aJdMjFuscjKOk9d7ZecL?=
 =?us-ascii?Q?u67nzJ90T1WQlptV5Gzq69R30IkWODv7Lz3rjAIaBkxjpGGA7Y4gkfapxcQ6?=
 =?us-ascii?Q?gWfyPC/bAsy6EWNFYCcou4w+yiDUVacjUnYGINGwIjQ1SV/pTC6Yz+ABXdnB?=
 =?us-ascii?Q?AI5osiFtwzzyldFp97sw2GlvuXrEoMMyL0UAl3erosKu2HslrOJww3DQK2mD?=
 =?us-ascii?Q?QS6OLydkyUwU8/U35OvtDTooNDk2txJwPQ724SRge8jOJXEKpqLu8ioN9UnD?=
 =?us-ascii?Q?irOLDUg8h2d4yPbYGU5R0CUOkRV8tJObymMGyYLKQb1951clQjs2f57gFsye?=
 =?us-ascii?Q?bAdDCXPZc9Z3No2sFJUpZqWCfeHKEIiu1QVhgxrtbl5jCSkNHhlJTXH57h0F?=
 =?us-ascii?Q?V53cEIMbDmdrzXgh2RzqTZ1Pjae0iO9Gw93g+bY7HNrnShJXuJMWsUtCF57v?=
 =?us-ascii?Q?pKlWyZIkBwjvHH1gIr8gWOBuSvAiHMChJVMa5owOpBZdU8B4lIo31ikpmOgI?=
 =?us-ascii?Q?ROnp56S/QkZRnj+1pYMjUSPLk/HQpEjFgsSOMdDF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b330ff6d-1d37-440a-fa31-08dae2380181
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 03:12:19.9562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xHBtnIavkliyUvk3r64HrBqm+AC3ie3vwQZnMZBa9Nz6YyOzkdVBowkENiXIB9Ak2TZKf/eL3WvB58P53P8d/g==
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

P012 is a YUV format with 12-bits per component with interleaved UV,
like NV12, expanded to 16 bits.
Data in the 12 high bits, zeros in the 4 low bits,
arranged in little endian order.
And P012M has two non contiguous planes.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/v4l/pixfmt-yuv-planar.rst           | 94 +++++++++++++++++++
 drivers/media/v4l2-core/v4l2-common.c         |  2 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |  2 +
 include/uapi/linux/videodev2.h                |  2 +
 4 files changed, 100 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
index f1d5bb7b806d..aa37c3de8808 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
@@ -123,6 +123,20 @@ All components are stored with the same number of bits per component.
       - Cb, Cr
       - Yes
       - 4x4 tiles
+    * - V4L2_PIX_FMT_P012
+      - 'P012'
+      - 12
+      - 4:2:0
+      - Cb, Cr
+      - Yes
+      - Linear
+    * - V4L2_PIX_FMT_P012M
+      - 'PM12'
+      - 12
+      - 4:2:0
+      - Cb, Cr
+      - Yes
+      - Linear
     * - V4L2_PIX_FMT_NV16
       - 'NV16'
       - 8
@@ -586,6 +600,86 @@ Data in the 10 high bits, zeros in the 6 low bits, arranged in little endian ord
       - Cb\ :sub:`11`
       - Cr\ :sub:`11`
 
+.. _V4L2-PIX-FMT-P012:
+.. _V4L2-PIX-FMT-P012M:
+
+P012 and P012M
+--------------
+
+P012 is like NV12 with 12 bits per component, expanded to 16 bits.
+Data in the 12 high bits, zeros in the 4 low bits, arranged in little endian order.
+
+.. flat-table:: Sample 4x4 P012 Image
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - start + 0:
+      - Y'\ :sub:`00`
+      - Y'\ :sub:`01`
+      - Y'\ :sub:`02`
+      - Y'\ :sub:`03`
+    * - start + 8:
+      - Y'\ :sub:`10`
+      - Y'\ :sub:`11`
+      - Y'\ :sub:`12`
+      - Y'\ :sub:`13`
+    * - start + 16:
+      - Y'\ :sub:`20`
+      - Y'\ :sub:`21`
+      - Y'\ :sub:`22`
+      - Y'\ :sub:`23`
+    * - start + 24:
+      - Y'\ :sub:`30`
+      - Y'\ :sub:`31`
+      - Y'\ :sub:`32`
+      - Y'\ :sub:`33`
+    * - start + 32:
+      - Cb\ :sub:`00`
+      - Cr\ :sub:`00`
+      - Cb\ :sub:`01`
+      - Cr\ :sub:`01`
+    * - start + 40:
+      - Cb\ :sub:`10`
+      - Cr\ :sub:`10`
+      - Cb\ :sub:`11`
+      - Cr\ :sub:`11`
+
+.. flat-table:: Sample 4x4 P012M Image
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - start0 + 0:
+      - Y'\ :sub:`00`
+      - Y'\ :sub:`01`
+      - Y'\ :sub:`02`
+      - Y'\ :sub:`03`
+    * - start0 + 8:
+      - Y'\ :sub:`10`
+      - Y'\ :sub:`11`
+      - Y'\ :sub:`12`
+      - Y'\ :sub:`13`
+    * - start0 + 16:
+      - Y'\ :sub:`20`
+      - Y'\ :sub:`21`
+      - Y'\ :sub:`22`
+      - Y'\ :sub:`23`
+    * - start0 + 24:
+      - Y'\ :sub:`30`
+      - Y'\ :sub:`31`
+      - Y'\ :sub:`32`
+      - Y'\ :sub:`33`
+    * -
+    * - start1 + 0:
+      - Cb\ :sub:`00`
+      - Cr\ :sub:`00`
+      - Cb\ :sub:`01`
+      - Cr\ :sub:`01`
+    * - start1 + 8:
+      - Cb\ :sub:`10`
+      - Cr\ :sub:`10`
+      - Cb\ :sub:`11`
+      - Cr\ :sub:`11`
+
 
 Fully Planar YUV Formats
 ========================
diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index 40f56e044640..a5e8ba370d33 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -267,6 +267,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_NV24,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_NV42,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_P010,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_P012,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 4, 0, 0 }, .hdiv = 2, .vdiv = 2 },
 
 		{ .format = V4L2_PIX_FMT_YUV410,  .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 4, .vdiv = 4 },
 		{ .format = V4L2_PIX_FMT_YVU410,  .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 4, .vdiv = 4 },
@@ -292,6 +293,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_NV21M,   .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 2, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
 		{ .format = V4L2_PIX_FMT_NV16M,   .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 2, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_NV61M,   .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 2, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_P012M,   .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 2, .comp_planes = 2, .bpp = { 2, 4, 0, 0 }, .hdiv = 2, .vdiv = 2 },
 
 		/* Bayer RGB formats */
 		{ .format = V4L2_PIX_FMT_SBGGR8,	.pixel_enc = V4L2_PIXEL_ENC_BAYER, .mem_planes = 1, .comp_planes = 1, .bpp = { 1, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 8e0a0ff62a70..067dbdd0a9ef 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1348,6 +1348,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_NV24:		descr = "Y/UV 4:4:4"; break;
 	case V4L2_PIX_FMT_NV42:		descr = "Y/VU 4:4:4"; break;
 	case V4L2_PIX_FMT_P010:		descr = "10-bit Y/UV 4:2:0"; break;
+	case V4L2_PIX_FMT_P012:		descr = "12-bit Y/UV 4:2:0"; break;
 	case V4L2_PIX_FMT_NV12_4L4:	descr = "Y/UV 4:2:0 (4x4 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_16L16:	descr = "Y/UV 4:2:0 (16x16 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_32L32:   descr = "Y/UV 4:2:0 (32x32 Linear)"; break;
@@ -1358,6 +1359,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_NV61M:	descr = "Y/VU 4:2:2 (N-C)"; break;
 	case V4L2_PIX_FMT_NV12MT:	descr = "Y/UV 4:2:0 (64x32 MB, N-C)"; break;
 	case V4L2_PIX_FMT_NV12MT_16X16:	descr = "Y/UV 4:2:0 (16x16 MB, N-C)"; break;
+	case V4L2_PIX_FMT_P012M:	descr = "12-bit Y/UV 4:2:0 (N-C)"; break;
 	case V4L2_PIX_FMT_YUV420M:	descr = "Planar YUV 4:2:0 (N-C)"; break;
 	case V4L2_PIX_FMT_YVU420M:	descr = "Planar YVU 4:2:0 (N-C)"; break;
 	case V4L2_PIX_FMT_YUV422M:	descr = "Planar YUV 4:2:2 (N-C)"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 1befd181a4cc..5448aa3b7858 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -626,12 +626,14 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_NV24    v4l2_fourcc('N', 'V', '2', '4') /* 24  Y/CbCr 4:4:4  */
 #define V4L2_PIX_FMT_NV42    v4l2_fourcc('N', 'V', '4', '2') /* 24  Y/CrCb 4:4:4  */
 #define V4L2_PIX_FMT_P010    v4l2_fourcc('P', '0', '1', '0') /* 24  Y/CbCr 4:2:0 10-bit per component */
+#define V4L2_PIX_FMT_P012    v4l2_fourcc('P', '0', '1', '2') /* 24  Y/CbCr 4:2:0 12-bit per component */
 
 /* two non contiguous planes - one Y, one Cr + Cb interleaved  */
 #define V4L2_PIX_FMT_NV12M   v4l2_fourcc('N', 'M', '1', '2') /* 12  Y/CbCr 4:2:0  */
 #define V4L2_PIX_FMT_NV21M   v4l2_fourcc('N', 'M', '2', '1') /* 21  Y/CrCb 4:2:0  */
 #define V4L2_PIX_FMT_NV16M   v4l2_fourcc('N', 'M', '1', '6') /* 16  Y/CbCr 4:2:2  */
 #define V4L2_PIX_FMT_NV61M   v4l2_fourcc('N', 'M', '6', '1') /* 16  Y/CrCb 4:2:2  */
+#define V4L2_PIX_FMT_P012M   v4l2_fourcc('P', 'M', '1', '2') /* 24  Y/CbCr 4:2:0 12-bit per component */
 
 /* three planes - Y Cb, Cr */
 #define V4L2_PIX_FMT_YUV410  v4l2_fourcc('Y', 'U', 'V', '9') /*  9  YUV 4:1:0     */
-- 
2.38.1

