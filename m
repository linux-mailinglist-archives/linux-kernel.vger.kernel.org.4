Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0553E651960
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 04:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbiLTDMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 22:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiLTDMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 22:12:30 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2040.outbound.protection.outlook.com [40.107.15.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEB25F44;
        Mon, 19 Dec 2022 19:12:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXAnC2+WATAJH7gsaijFxSFj3wLC9XZqoABq2GlNmy3bgONJbJ+EjRdPjif9WkvtiPOyYIkLRi9jj+5PES0+mOPC6tCBAhe0VXAo99pSIuTTYOy90dgxyyW1oqeL9oapEeidT5rfGDNVkKDM1P8njs8gj2X+o3VQU6nDaY3W6ZKNEXpX+l/eWlSZkTjXIBCGJsgMHsQhtClOhrBb+G0xLExk5RwpjoipUHYzdbxI7/Zctfg/1qALa838j77OkRxIEobS1EVokPzPROdKDfX/6r0dyOLForroljumWjs1xPtjX12PzeTzdv7brnvfU75UXgJy/gFWzJTwuN3WpWBEIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1u/CtgyVahT0gjIMbS8n7n0jcnPnAKWt2rMh7vAtAE=;
 b=d5b20DGZVdW686Vmnozqm7C5ZqwE1xwhGswXKKyGH+XCqejTgGF6QoiD0bGrmilMsaSczlelAnMAUknlNaDhrJTH5hy1YwDfleA3GU+++sCy4mvsyf9ZwQp3noD/PfL6Ug+TMJRjoKNRhY7SRIyP2WaKAZZMCj6GnPwzw7Nfe6YRpmBI6Rdse/y9x12dJN5jZ1DnVwCSjOZWygPymXb0Cj411XQ3OIMGaz2QZT2hJ2ZunOEfUo6tStmJ8SlFt80bh+qnYD79TZa6nQ80OGxQ79uICrOheFHGzrDFgqmiFp5sJ6iB0jqSwgj1b9T8jZeFOBv2vRPR/WtNN+deJiyzwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1u/CtgyVahT0gjIMbS8n7n0jcnPnAKWt2rMh7vAtAE=;
 b=lFRsbhUFrDnbHVUkcjAK4mZQd6pklywak7f8GXWfDtH+XaFT5VEL95P2QVFtF9ROgVzkRxP/htrJD+5Whqmh8GDpIrM4bilrEVd3UFkzhL61AzH5LP4xv4Z0RQ/fF36b1mpxAGIVTYucotFpmgK9dqCzgvOxwBDO75yRLZE99Hs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS1PR04MB9405.eurprd04.prod.outlook.com (2603:10a6:20b:4db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 03:12:28 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 03:12:28 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 03/10] media: Add Y212 video format
Date:   Tue, 20 Dec 2022 11:11:33 +0800
Message-Id: <9aa51224d2c37cca5f1283532cb99f3c8251b120.1671071730.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7711a01d-6501-417f-ff79-08dae2380648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yU8bR/rgoZVSltYs3FlavW4Ug83177D7SaWxuNFHBbtNFdrJ+z9c7f5M8tOfd5dc7p+1NDQInfY23IEygHiCJP0DU7bE+DpAYjeeHY/WYImZaJpSfBABJyTtuo3KsMI8tTPNkCQk/WVhqnuh/YivIec9eICBAHBk7DpEuvMbe3Teeg5lqPZYX5AdAVgBbiLlmlzXcfL3VF4pvOFqLDQ20hKWlA11G7EQKRTNcGXWFvgFyZLF0ZX3nKKMzH88XiK2RI1m8CAfsS0AzGwISUZMNohwxI3LOtwHs9HktgvSfYexqeMq9m6Anqxx3Pff0s9XnwExzLuociJaOMVBqfQLvf1FA9SXL/5D8w7jDFBX8W1PP5+s7W0VvM1dRkbmu0nkA4GBHxWnmyaazHaPPCpWQqmckkFC0YSJxyakiWtYESGVUcItSrUIsSqhg9fgK0NFXyV/41qXY94pPiHR3XQ/gNaBryOkXSrgW8xA2WzW7HC6GgJ4+zAVRMmvptCnIumEzdTWs/Pqq4PzJmXh5nDtWbNLd4CBhn8I4INPj58UBr4T5fUDA/TV9qzIFkHqCnYEJtEuFQDc9dd8KRMUAhdXmEz8oJxzLTjNrqur/WTkuyTUmmV49xv+tAa7nAabpE7lC453EWhMv/DGCoU3DgnKRTw9d9nMl3McNHP8tSO9743vkuglUtx/235risNmeIgp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199015)(36756003)(86362001)(478600001)(316002)(6486002)(66476007)(8676002)(52116002)(7416002)(2906002)(6666004)(5660300002)(44832011)(66946007)(41300700001)(8936002)(66556008)(4326008)(6506007)(38100700002)(26005)(38350700002)(6512007)(186003)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L3j/hr7XY15z/NcD4DC5i5T5voRGIrlZVAr5ix/gJx7p6c14AeAoDrK3l1k7?=
 =?us-ascii?Q?X4zIBWMHVRZB0P/il00Ec8Kg2E33pJ8AglVnRV2EzX36C5ztX33L7sk14PcE?=
 =?us-ascii?Q?qUxOnSE4I9ePu131x+Kr5EEYui5Z90xktSs3iNbKfjsG9wgRrIEB4yvFDaMp?=
 =?us-ascii?Q?Iz/xVaYzz7fNdMjeJAoaArgYb5RELD69eI8xbn21qlzkdlYRXYPRrZ9cpzEy?=
 =?us-ascii?Q?9mcROoEOThdvK7Mu3jn/w0RJfIxUuo9uGgTAHnJ7c0EI+EVd46Juqy8mit/3?=
 =?us-ascii?Q?Egm93zHqro6z8lNFDK200g3VQreWv7jYpayyx49Dmm5v56DZwPRotTeiQQPp?=
 =?us-ascii?Q?SaCqDxwVztFi0lHWKzeoAsp54p4WEeFGITzezC/uo9OGrXi636W+6zFLjg0N?=
 =?us-ascii?Q?m4S2rwwezq2sZtODkf8UOIzBSCRvNKcres/I/7vqeKx2OIGEzQbSSv3f9m43?=
 =?us-ascii?Q?65dTLlxW/Oi4uWMSJTR3ws3zkaeEbJNFJP7QEVXsg8ZomiB0ID82jVJ2ioR8?=
 =?us-ascii?Q?/XD9xoPi3OuN5AIYL6AJ/V379UNKvzGkQXqhL2kJc+DkmfWVGd4gAiAMgYtv?=
 =?us-ascii?Q?KyLkso4cyojlRufxxcIYXyH4wMoVxTJfiUBxWsPEiD4u9Xwc0eV5vVSArFL2?=
 =?us-ascii?Q?WotI9CH0lF6R/kTcM/gybRWIaLIqftfxa3QaVx+jya17N2fAwiCXEQtwCopm?=
 =?us-ascii?Q?wqjkv3wUO3PijSQw26PzsoJ9QJw441enSDCH48KSXxboyrGHncfH4Fn3GThK?=
 =?us-ascii?Q?Il0eDvWBqUNKpbFU34/LezLvA9m8h9YzPbrNUzS557br3TZjv+0xZWrAz/F3?=
 =?us-ascii?Q?w6JLpRa6jX4m8jESvdBk9Budrx8zRFJkcqUUPWf91HJ1uwh40yWH1sZMqLDY?=
 =?us-ascii?Q?zzhHFHulvi+HxzHVTAqKyxUbPGw7ByS3TgOWXp9JHNVp3WfUIxS9SSvoOhEN?=
 =?us-ascii?Q?8aKmzva0N4/LniOSpK4jLao9K0pqQr4KDXn8iZAofCS+jO/8V4s/igPd0NoM?=
 =?us-ascii?Q?nLZ1z+oQPj+QVcIYjRRQ+YfRjUSq2rClRW5pRbx7ZYImW193dwACWHuDYtgw?=
 =?us-ascii?Q?mM2nSrfsLJC+Jnt+TvqTEDBE/ejcsgB1d6chbHkgPhDOXBfqrXe1jRIWCH21?=
 =?us-ascii?Q?Xhh1vBZn8oyUxgKRgZfxvidSNezlSxp/0Z0A6k2+8EI7OUea4Nczgh4VMAcr?=
 =?us-ascii?Q?nbEenpRSH64wU+55vrd6QrlSyaOiUv46RUPjB7wEA/jH5hHSDH8HcRmJ2Jw0?=
 =?us-ascii?Q?s/hCgagzuC9OTzsAU8KC1h/6K32glVNBGzLDFY1xGnNIzHEIt4N0vZWrH1lE?=
 =?us-ascii?Q?3FNNdVriBN1uGPLAo+PEkXclodWYUdYu/P0Wqd6D/bpbhRTVQjaoHHXMimCA?=
 =?us-ascii?Q?HxiRwhsTtL6A2hFoIJ5Hc+PQ9TPyQoLineP869L3H5gvQ3U+Dzch0qwp1Nlc?=
 =?us-ascii?Q?DeLmOnlG/QLxtPSRYQZqgi9223u5oPMshTOC3iBLndvGrOtLM3T20dYYNhnA?=
 =?us-ascii?Q?NAhpLALuR0D1F9FErUBN31hCW+zLtFqtStZkl/JPyc/som4dEZLyE9hLUEsd?=
 =?us-ascii?Q?qcXByUbYnSLjUISsUfTxeRdNdleruVdRf2zZ9Pil?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7711a01d-6501-417f-ff79-08dae2380648
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 03:12:27.9870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDQ2cUueE98FKIn8KXj4MC8B7BgIqty21EpftyF8/erZyZCAlCf/f5dmYnuFHcjG3n1ZIpkEh+2xUNxtPTnJeA==
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

Y212 is a YUV format with 12-bits per component like YUYV,
expanded to 16bits.
Data in the 12 high bits, zeros in the 4 low bits,
arranged in little endian order.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/v4l/pixfmt-packed-yuv.rst           | 42 +++++++++++++++++++
 drivers/media/v4l2-core/v4l2-common.c         |  1 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
 include/uapi/linux/videodev2.h                |  1 +
 4 files changed, 45 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst b/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
index bf283a1b5581..39ded0b1e65c 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
@@ -341,6 +341,48 @@ components horizontally by 2, storing 2 pixels in 4 bytes.
 
     \normalsize
 
+The next lists the packed YUV 4:2:2 formats with more than 8 bits per component.
+expand the bits per component to 16 bits, data in the high bits, zeros in the low bits,
+arranged in little endian order. storing 2 pixels in 8 bytes.
+
+.. raw:: latex
+
+    \footnotesize
+
+.. tabularcolumns:: |p{3.4cm}|p{1.2cm}|p{0.8cm}|p{0.8cm}|p{0.8cm}|p{0.8cm}|p{0.8cm}|p{0.8cm}|p{0.8cm}|p{0.8cm}|
+
+.. flat-table:: Packed YUV 4:2:2 Formats (more than 8bpc)
+    :header-rows: 1
+    :stub-columns: 0
+
+    * - Identifier
+      - Code
+      - Byte 1-0
+      - Byte 3-2
+      - Byte 5-4
+      - Byte 7-6
+      - Byte 9-8
+      - Byte 11-10
+      - Byte 13-12
+      - Byte 15-14
+    * .. _V4L2-PIX-FMT-Y212:
+
+      - ``V4L2_PIX_FMT_Y212``
+      - 'Y212'
+
+      - Y'\ :sub:`0`
+      - Cb\ :sub:`0`
+      - Y'\ :sub:`1`
+      - Cr\ :sub:`0`
+      - Y'\ :sub:`2`
+      - Cb\ :sub:`2`
+      - Y'\ :sub:`3`
+      - Cr\ :sub:`2`
+
+.. raw:: latex
+
+    \normalsize
+
 **Color Sample Location:**
 Chroma samples are :ref:`interstitially sited<yuv-chroma-centered>`
 horizontally.
diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index a5e8ba370d33..21ace56fac04 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -258,6 +258,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_YVYU,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_UYVY,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_VYUY,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_Y212,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 
 		/* YUV planar formats */
 		{ .format = V4L2_PIX_FMT_NV12,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 0ee730aa6cc7..4d5f722b674a 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1342,6 +1342,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_YUV420:	descr = "Planar YUV 4:2:0"; break;
 	case V4L2_PIX_FMT_HI240:	descr = "8-bit Dithered RGB (BTTV)"; break;
 	case V4L2_PIX_FMT_M420:		descr = "YUV 4:2:0 (M420)"; break;
+	case V4L2_PIX_FMT_Y212:		descr = "12-bit Depth YUYV 4:2:2"; break;
 	case V4L2_PIX_FMT_NV12:		descr = "Y/UV 4:2:0"; break;
 	case V4L2_PIX_FMT_NV21:		descr = "Y/VU 4:2:0"; break;
 	case V4L2_PIX_FMT_NV16:		descr = "Y/UV 4:2:2"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 3d8f89bff33c..b8a501dccfa4 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -618,6 +618,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_YUVA32  v4l2_fourcc('Y', 'U', 'V', 'A') /* 32  YUVA-8-8-8-8  */
 #define V4L2_PIX_FMT_YUVX32  v4l2_fourcc('Y', 'U', 'V', 'X') /* 32  YUVX-8-8-8-8  */
 #define V4L2_PIX_FMT_M420    v4l2_fourcc('M', '4', '2', '0') /* 12  YUV 4:2:0 2 lines y, 1 line uv interleaved */
+#define V4L2_PIX_FMT_Y212    v4l2_fourcc('Y', '2', '1', '2') /* 32  YUYV 12-bit per component */
 
 /* two planes -- one Y, one Cr + Cb interleaved  */
 #define V4L2_PIX_FMT_NV12    v4l2_fourcc('N', 'V', '1', '2') /* 12  Y/CbCr 4:2:0  */
-- 
2.38.1

