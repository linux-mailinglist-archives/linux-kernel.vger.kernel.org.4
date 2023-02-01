Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FEC685F5E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 07:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjBAGDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 01:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjBAGDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 01:03:31 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2058.outbound.protection.outlook.com [40.107.6.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E8A5C0D0;
        Tue, 31 Jan 2023 22:03:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHFUryWP0sVqo5J434cwxyRxNc5PS0oJ54RJOn+rgLTiWU7z7dSbjKGPKW0KofspTIfgMYLqqaRZqrTt1qUfIAxIQw+E+NtgyCC+dvms8Utw1jY0C9vUHiqeiHPuszLtj9J1ur0wt3dCi+/I/g0M9K/VsjT8UhnkPmA2gF5o0kNKeRo/0/aIsFklepduvWHXfeCIrXHUMKMJ4ill0pb/X/kEqbxPrQozvaIE4EtX2JLCu6wOsv911UhcHRnSGHc/iEJ++WkJxMVQhc1wkpoyU5uaJQbxsTGQvtwWikpMAw2URwSpBcvbpSfSbYsK6jIUHORdHEpGQxWks8OWL0gwIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2Yx21b0j1MK0Ce6cSenyGIaB1kBCSsck2Aem2dw9Nc=;
 b=hm4brprARlP8ul2zLawpWagG4SmxCkwCBPw1Zg/8Kajrh7B32YNj2mvyR/8pgwdLcc52uuuhwGCDWbT9bttyFeTK1DutFGNKVOVlx6A6V7wYYGN8ICxS4+YheDfuSfD8xNuiz8Jf0Px7yvYwtRtqZEA706R876fc6j6QCOJUFOGFeRT+yMnTjz3TSqUv/n9Ijc4dGaB1D8vOsKx4J+cqHq/w6YIbjvb7UcgfmI+XFgPFlTcwH/GSr/UYFCPQCt/IlRHBBEOMLra/nRnSJ10slVGZFkvCheCmgDsk+ibOSUktiZq6F/K5F6KIsUMabg4tAv3t6QHGc8u616zd80581Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2Yx21b0j1MK0Ce6cSenyGIaB1kBCSsck2Aem2dw9Nc=;
 b=jzqmvKEIWiySfDXSgT5TMpGnIq4ekg9uOohs8GhTcmN/94wK+DJn/bEw8fbhg3mQ1qVzBwuFoZzLIHM8Fs2KwhdCaRdtVQH9boBmNPP1cFXMs55VURoO32jeEpLlA0m7dng3DxYXHbhtoJNg7MJSb6Q/PQv7THe4dlnJNjz2is4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 06:03:25 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 06:03:25 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 02/10] media: Add Y012 video format
Date:   Wed,  1 Feb 2023 14:02:24 +0800
Message-Id: <93889cdefacaad260d978a8353066dd384a64609.1675230665.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1de0bcc9-b257-4596-1dcb-08db041a082c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PWDYhOdKQFAjIjMVUFcI46pp7/kENpet3qgMk4M414AEi3BnXEG3NvtvYHo02xC7DTYBAEnI02YibG0DNLvv6XYHkV1D2VavXhXO7Up52g9aJbHkvNH+x/kmz70xE+NDCNgjpzu66HOSXHf2HewsMzzpjI/Au8fpVmsJsoPEYFiDtut9Q6gevJTVqiqqYXw0C4eB2cI+bDD355MiWxlHDsI87hV8mR41b0ADueXY8PLoNx1Wf/rDqbIMSnLx1OuPUH3U/zjDil+mz9VZGINiKL4InqWo4XX+HOwqvzCzKco+lpNqWXvFObkRizw0xaQz3sg4YxiSdBfbcHRv20eIHzwfvjB8H2rBvUndkgCeudBckD/+wmxLAr0+SnIVj/jj/X4bBJtq0HG3ySX+53mwEzCwEzLaltg71EKGNfvQrs+CD07ElB9YjigB2NvnGfot8gWZTB6rwggPmyqdx/xnGiPBLyZVw5be5dIKeasiJv0Jqt7G79UMmlt0mV6wsGdVq5/YdzGgnNJxPgh6RHY3vb/oR79wY5XXnuY2ZlSxPvmsUKKDSLgiWPtdjKPvo2cqDnQ6AL73NEItiOW9Q6yl/SdGP9Qd8KmBHkqNCaNy7ldN4Q7l+W4HBssJKkkan6MYwb9hgLWz0p6Dt442hQGdpcdS7FVEhbqAUYcYiOu3F7+Ow4z0dObuCX90BZPeW1XtoV1ximtlFo5uQIFj5/NZ2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199018)(38100700002)(52116002)(2616005)(38350700002)(36756003)(7416002)(8936002)(86362001)(5660300002)(44832011)(316002)(41300700001)(2906002)(83380400001)(6506007)(6512007)(8676002)(4326008)(186003)(26005)(478600001)(66476007)(66556008)(6486002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YP9mH6UdS3ni0hrQJnsG+HQnrcPQFPsgAskJN+oLxw1OFMZL5rFnKK/olQ/I?=
 =?us-ascii?Q?DHqjaJqfP9EXSPik3Y8gQlJkkRoVLhcW90B/UI4N81KH5/wOzb4GFUtGsgik?=
 =?us-ascii?Q?F0xuTtp2QepCw+wEV3egRutY+xeimDBtPZ44cOFdmK6HY9RSTD6O+grYcwp7?=
 =?us-ascii?Q?ESvvjD1trfBkZy/8H+brV8Y1bwoYE52EUgw9xRF/fS9yJoaKTpvRhTqSNDdZ?=
 =?us-ascii?Q?aps8QwRUBNk0zKzXcX4C8DmdyeHBUvyCPkOzT0znTyJrt39zPBnCPi/50Kbq?=
 =?us-ascii?Q?7JrsbBTZEUOvIvIvFTzBIRgTep2IjpfzMB9fC03paYoLBZPF0HHpXZhANPVV?=
 =?us-ascii?Q?i9/fWI/fSNERz9BFhwGYHU457n4MhYqguNn7dTx9vNG0rEdV4zejwgrP1S0Z?=
 =?us-ascii?Q?PVOuWArbgBsznUUXLIuUWlO6IPq1AKbbgS44umckRFlTnAYENYVQJC8+1wru?=
 =?us-ascii?Q?2gSQ+STdMX1L6ZxkSxtPxZw8WTFZZGJ4W4Bqcyba0aG+8nXIgy8v3p4qzttS?=
 =?us-ascii?Q?tBvzQTbUSc8oamzc8G/IzMCLcYYokXzlfXrLKsolojAZeTqp1M61qpntsjRB?=
 =?us-ascii?Q?fJDkPxWw7Vn07zQuTdPr8i+6wF+hA+fNI6LdGg1xmxhcx2aeWyo0D0ewSEK9?=
 =?us-ascii?Q?/6MKvmu5951hQf7Te/vPKsD9p9mYUbgigRbJgXl9yqImNudQN98ZrTzIPo5m?=
 =?us-ascii?Q?TqUarLYGw0DOnfAnEwRkOAHNBSB3vxkbjdXTBOuuUdYDLNfg5C+PY5Shq1Pe?=
 =?us-ascii?Q?asfjlq3bmzBrRX4iM/QkrxavII9M/jQDU9FVbkg84rBoCQLMKW5ocHLc9b9d?=
 =?us-ascii?Q?j7PBAX6gnGurMtA7OSFXnGo+VV/PS4NouAzlJAdQ9F4UadOIpO2cSzUJZQLh?=
 =?us-ascii?Q?A5gKmdJDC2o0peUZRewRWcxRNeqLFDkBECyakaTJVwmhn9snDShQGpR2c/iI?=
 =?us-ascii?Q?eoCf7TYn8va5WTsn3FvVWLm6bk1yl64YOqraHqOBFp5OE7iBKDYX0cE8AfUa?=
 =?us-ascii?Q?CTpdF+zMZfB5fmL8INelKa0rkjUPzKG8y3sYQQVocJFS2vg+efTca+xsgYzn?=
 =?us-ascii?Q?ucPvNPYpLKn6yZDGnL5cxVpxakoeErXXAZRe3kSTAXxsYyjvKMWp4ILq0Fw1?=
 =?us-ascii?Q?cACmu9GCio28DopGXBbY3milrcFttwSM93WzDZ4sPAkEVaxLdJzaFZ/TiAfw?=
 =?us-ascii?Q?SapuNTAsMMkWBrgN9SLVMxZCcuzovR8i0Kn/B2bawgU0u2YWUz8ilsWXzkF+?=
 =?us-ascii?Q?DgXFd4Br+lwMvKvK8MZabC/UoJmi1hCuWtAAOWKEhOq69ByxDoL612EF6cLR?=
 =?us-ascii?Q?+55assk1uDBQlOKI0VDs94DyydP0NO+pKTyoS94NafP0tUiVoBt6gXZzVTLx?=
 =?us-ascii?Q?6pk4lSyaH9DQ+9D1E6DTiXHwYo+MPjfzcZmczzeqBUdUlkzhMmg8qyiaDyKh?=
 =?us-ascii?Q?N+tUlDmG5j0OZSh6bT0/oavBJNDCihoWIku2TnBkBocBnOkuvzoubxJf7p6g?=
 =?us-ascii?Q?GnYl6yQlM7d3U69LzDRWXyChE8UQ/jtG/7ySHrNr4uLPROSTifPaws8a9Kt/?=
 =?us-ascii?Q?f1xZwvebjnxLZKU+jRTP6T1iFkkMLFPq+3VDI9Dw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de0bcc9-b257-4596-1dcb-08db041a082c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 06:03:25.8170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1M0eYWqIi9a6WPt45Fou1s5W3XB15az4asrZ6frCI2fCV0e2kl+ph5GkrKvS6hBaT2frjSlTbWq7P5qIme9/A==
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

Y012 is a luma-only formats with 12-bits per pixel,
expanded to 16bits.
Data in the 12 high bits, zeros in the 4 low bits,
arranged in little endian order.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../userspace-api/media/v4l/pixfmt-yuv-luma.rst       | 11 +++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c                  |  1 +
 include/uapi/linux/videodev2.h                        |  1 +
 3 files changed, 13 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
index 6a387f9df3ba..3ffa29000238 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
@@ -103,6 +103,17 @@ are often referred to as greyscale formats.
       - ...
       - ...
 
+    * .. _V4L2-PIX-FMT-Y012:
+
+      - ``V4L2_PIX_FMT_Y012``
+      - 'Y012'
+
+      - Y'\ :sub:`0`\ [3:0] `0000`
+      - Y'\ :sub:`0`\ [11:4]
+      - ...
+      - ...
+      - ...
+
     * .. _V4L2-PIX-FMT-Y14:
 
       - ``V4L2_PIX_FMT_Y14``
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 067dbdd0a9ef..0ee730aa6cc7 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1303,6 +1303,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_Y6:		descr = "6-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y10:		descr = "10-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y12:		descr = "12-bit Greyscale"; break;
+	case V4L2_PIX_FMT_Y012:		descr = "12-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y14:		descr = "14-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y16:		descr = "16-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y16_BE:	descr = "16-bit Greyscale BE"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 5448aa3b7858..3d8f89bff33c 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -583,6 +583,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_Y6      v4l2_fourcc('Y', '0', '6', ' ') /*  6  Greyscale     */
 #define V4L2_PIX_FMT_Y10     v4l2_fourcc('Y', '1', '0', ' ') /* 10  Greyscale     */
 #define V4L2_PIX_FMT_Y12     v4l2_fourcc('Y', '1', '2', ' ') /* 12  Greyscale     */
+#define V4L2_PIX_FMT_Y012    v4l2_fourcc('Y', '0', '1', '2') /* 12  Greyscale     */
 #define V4L2_PIX_FMT_Y14     v4l2_fourcc('Y', '1', '4', ' ') /* 14  Greyscale     */
 #define V4L2_PIX_FMT_Y16     v4l2_fourcc('Y', '1', '6', ' ') /* 16  Greyscale     */
 #define V4L2_PIX_FMT_Y16_BE  v4l2_fourcc_be('Y', '1', '6', ' ') /* 16  Greyscale BE  */
-- 
2.38.1

