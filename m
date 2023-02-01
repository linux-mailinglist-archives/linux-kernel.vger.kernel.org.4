Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B768A685F5B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 07:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjBAGDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 01:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjBAGD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 01:03:26 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2058.outbound.protection.outlook.com [40.107.6.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9A55C0C8;
        Tue, 31 Jan 2023 22:03:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kk20gGXIaYQv4pR5qZwyqhSxywLVtzyvuVcZliPj4/M8g++qRVkohsOXrDNMDOB5wEoItYQD0F9zxAdn29AveDc8BUSbZt2yrq6LfFK19+MTCJDq6OrCc0bnyRUg/ODO+U2+v3IeLhLL6WE308PsG3JIXsrQW4gJDMO04+1Sn1BAi4xGtQWk47lB/mBnW1i0YMPem40khGRYhinppwK/37FfkMChSTBqV9s+jMP1IuMD5ZFhkQX89+gdUVQfGdonRuyII7IS/2AxpIJuEIzl5WDiG63+iZsBTL0lxSPlxwKhWPIvELGQwlIGHjrQB/1l4/CysMH6uLHBy0vyGBTzOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miYxDbfwNBWe1KNc4EwmJT97nAHpFZhA3X+bNK+LYGc=;
 b=UsnX5KG1gjkFW+v970tngE5a/gh17KKZZCHjkhjxnF3hhgvcDre3iwoPoUUQmKsX10n04bYoHSjLhnD9iIzXtpRPCtyLUMWPmp8z8YzxpZTBNiJoZ8iEORQ3sZSkvlE0vz3tJSV2CKUC2Z7iSJNke8x15Um4fpGDHRI+IpMsXLJdpiDY799zfQFDe8tI1tn4nvktfiyx5DIHKvl8+PUQDUnkaudmQwXYV4DLkM0J350R9IiHAPUV0uTaiUOx701szGvU5tEaaKsi+wT/4JK+/w21vInOJ/D7qKWqGOWaobpktjw1O81tV4rNqJd3udOEHt915y+agVnib0V4pj94+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miYxDbfwNBWe1KNc4EwmJT97nAHpFZhA3X+bNK+LYGc=;
 b=AJiNi6jb//Zm1xeGch/wMWOL/SVjxN+LjGG7zeX4ITV7vCKvYnt8LXY9MO2ChZiazbw4P3UHchoqr0jeJkzNQnWs9a29Bygl8RRHnvN52WrsRjnHn0U/MYFG3fjh3LVx0FGiH+WzcQZNicpRGsi1TD4XQMhpCmzLpA5MJ+7vZuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 06:03:21 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 06:03:21 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 01/10] media: Add P012 and P012M video format
Date:   Wed,  1 Feb 2023 14:02:23 +0800
Message-Id: <a38a72b8567938f90e5dee6fcd307f87a374737c.1675230665.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9a6e70d7-e3d1-435e-90c5-08db041a05ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w5vY17yn/pzskLvxQIVoKUcAruZphB/V3/ZBmNANRtgBu0cf0sWbNe8Oalzn6PJaKS+yP+S7XTxI1X8UEhpz9RR7VmBvLuxzT6bqh2U52Y04WnwmURVi3tZ5MhcqgTEe9Sex/2f6vZYpLO+6YLH7v+YVLi8ZesFnSrS1zYiuz/fb+N4KZe7S5bwnklxBiAjeGm0tNxq/O4oNd3e5kZ2yubkmXti7YS0SXQniojw7TfuuE8mRxlDHVvtvMHC353yzwQNNwMmwFe1rPh08NNUNXRymLGqglXDPDSGdD3ZWWGy/8eD0mg+DarLZdRi3oFnJeXt/hIuow3WJZ6t6R/KLlbtVvbS+5xOu5BbhUr53CjU7706Duy8Rui4k9xRpesxZuCUa4x4oQ3pDirFF6nMT4j0ho0vp7x/T+GjQXktlFQ+76wEPrEX2BD66i24jqO5nwir2hKJi/9irKjp+rMHNLJzKOqKcF687VXep87wa1bpeGU63D9fAzX0eQo2j1mBi6FJNH0jsgNBq71KI30ys9PMZSp6zrI/rmHqiXAbZc+8pQqbKJ7pAQCmO9Q9/bCK0mQnwg0V71M/oXClIDAnGEiGx5m9T6GnrDYu1yfVkJWV2qc/sK1DmW2rO51XaDBmvIiGM7CFTtZ5OLPsbcHYibGoLUo44GVV1pkdI3HirwRS2B008tgAID1+5rZcvLzFyCKy3QNv8Z+0qF+JCZ4jtMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199018)(38100700002)(52116002)(2616005)(38350700002)(36756003)(7416002)(8936002)(86362001)(5660300002)(44832011)(316002)(41300700001)(2906002)(83380400001)(6506007)(6512007)(8676002)(4326008)(186003)(26005)(478600001)(66476007)(66556008)(6486002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WKYYMLH/0OPkCYnoktLcp581EznFks4IoKjNfFxOZQhg7RupyVvCkQMdoYRO?=
 =?us-ascii?Q?0khZxw+kMKPneAGtyg3TCvgnoN00wvle5eGtR+1uQ3u/LqDKfFFSBpnMbJt7?=
 =?us-ascii?Q?w+QoqY7+Q/akb7KUmZ2ny2Tfo+dYmM08+mA1B+o2xWCBgD/qknVhFZUwMblq?=
 =?us-ascii?Q?b3QvIpKaUIJmNUgOjob5WkNvjPtW+vu+ZxOyx/46RuEBDj4dB3fmfVm0txF/?=
 =?us-ascii?Q?8xKM5qgJZmVwH5jfvnBMKdxXFvLOe9sdZ5afXwxXuAYyZhsZ8mhHX3KgRRA1?=
 =?us-ascii?Q?A6V777AgefMeVvZD8OXWZlxYXhA22jamt1vkd2NxKLJ6uz89KEm+6wBaMhQv?=
 =?us-ascii?Q?5hW83WF4uY9+dSD1SyFl8xtvfLlFLBITR9EUu1Rj8i2+3Ed1fcHQIxZ9BqB9?=
 =?us-ascii?Q?uIc52AIyttWcSF667SeBc6pnzKRZQK4xXkb6jb6sWNzoSNa8/InQ3VscnHCl?=
 =?us-ascii?Q?Qi6boRUsQxBUhdj/NIu/u9CZO5Dtd/o/A+QY8W3M7POy/u8/mDiiyQZ9SsbF?=
 =?us-ascii?Q?UGzFMZqBaFAgbErKXVUolnc8jsZDTVQyFmdEltYJFvTIoqFfc9WZl6HFdWfd?=
 =?us-ascii?Q?HUBjpZpqD5y0IQc26WUIpeJKPsZItuAUuxzLLrshQawDTU5hHpx1VyOHxugH?=
 =?us-ascii?Q?kEUa6j/dJpxO4MbQbVS1+zTC+0DD2Rci52MZcFtvscatVjgZXl0bDuPrN2hd?=
 =?us-ascii?Q?/Bw+lWMKEA0qYlQptn26XuxA10n/mYM0+Pz5Yt3Y2nt5EOxV5pWmtjKhUp/s?=
 =?us-ascii?Q?T9tmk1D34XFczLwjHvVxAjOGU8yKuNOoL+sxufJHeugAkS2mW3mYW7Am8upv?=
 =?us-ascii?Q?mcQ6TYsl9nGFD6BbYQ68PwvFDo9SOr0+b02QTTE0utUDOYr5z0c0p1rf0MmP?=
 =?us-ascii?Q?MZGMDHzmvX3QpD0TkK2jIkus9mBJB2yrE6bFoM0+8maUk1kagPuLobWAd9a/?=
 =?us-ascii?Q?KKVqndK9Z5vc8XM0eeYU270PTpsLLxrysR/lmB16bSq0uOuUs32CpM0KO3/g?=
 =?us-ascii?Q?r6DssmwBUMfNJcy+IlN9CZtmj0b6TRk9Tqfgartor3/aiWXL4Myz4ERRXiSw?=
 =?us-ascii?Q?q3t3s1uiTrRRPSAxiYroIrXlQssp4bs1BtEuT+lfLlyHunKJhalS7jFDWzZF?=
 =?us-ascii?Q?PbiqLZi7Fu+vGWj6QfrlXwv8BG9ZB8UAgj6ll1Mfy5rtrk4ab8TyjoPgMFiu?=
 =?us-ascii?Q?zi4cADXXfGQBeni2lVgUY70oZyqDYLno2svkaTRD0Wnko7YTT4XcgnUPdx2C?=
 =?us-ascii?Q?upbApmi/3GxLhd+ncdnq7227zEAdN0Xj1ybXuc/k7ma3uJK4aPSOQKke0fAE?=
 =?us-ascii?Q?9T8st9H6D4vvwlavNq5DpdseNOkFiZvIIBUFUxC5dR4yK/zDYgmWAuMsbPQX?=
 =?us-ascii?Q?NdqNgaFUn7IOfyQC+BpMZegU0CDn2ZAl9wpUxzk5GtjtzBZk+IaWvFBUT9Tv?=
 =?us-ascii?Q?bbCJ94+D05nYm5PFeDKmjp2I7E+DbsWUkr2+LYOfz9hV6g2F1CyGABajnHH0?=
 =?us-ascii?Q?01pnEKomsfHlEFJEQtGrKV1UOSnChwZUzXyYdI7eGafoRtI2uSwyS9qxpMG5?=
 =?us-ascii?Q?HfRBoe9hDpQ/eKZjuKbaPhBouXRD2RrBrybMwHVK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6e70d7-e3d1-435e-90c5-08db041a05ce
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 06:03:21.8485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PnJo0D93R5FzEUF3NxgoIitTKTEcvKCc8pkKkn0OYb+wmY5cRUEcftCuSTqaE92TOa2Lf8TK/c4BYtnpfSSpZg==
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

