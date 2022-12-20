Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEF565195F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 04:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiLTDMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 22:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLTDM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 22:12:29 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2040.outbound.protection.outlook.com [40.107.15.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDB92DC0;
        Mon, 19 Dec 2022 19:12:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdjuRl1F+8O2CemU+vYtqwnrR7/oj0msCCbkAfxViqAs+nmFUACuPnGrs2Us1TPIw4M8FUJd9EMBHsTpXX3EZNOhhApz4dEFn/NjSDiiarn8eMeahINs9z4lw5ZNsk1i9iL/7XzCLyDXHDjGvag34iE1l53s636QwZ7egIAzrR6IQcEYEg+0MhR9VZd95c3e22tSWvKKuc0buDfVhxgBLDtxnMgFbFd+6sGIcI/EpO/VWbmQQi7at/KhZsaxI3UQLoKcjVIXHSoPxFTjXqTWgt0iJcvwZbJ9Zi701HattxqwWsc6AmevGoFh/M/F9+8DAvJ9G+T6bAA4D4S+/DEvMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2Yx21b0j1MK0Ce6cSenyGIaB1kBCSsck2Aem2dw9Nc=;
 b=Q8OT2/2Na+ayz+cam14usmAV1GpqnvjhJ0hPyQhR0jUCpbOl5hyb84JXK3K/uRsSlWzDeDrzboSZ8LwIw98G99v94YVfyFCfwkKT+6xuBwmuw+z3gtVCSsaoGJQL1lNbr/FmYbV6Tl8B3bXsfbXgJQfRtaMrXGbMSz4Wz9MdKPhKNmHXAOgr7hC6a71AyC1kR1NnJg3cr3IbdpphY6Ah8ymeEe21F5IhTzhndiX1mbiJoW6RKiPvpjSpFWW7JIy0bSg9QIkAkRfSJCjaU3STVbhNTj/f3rrBRO3PloPeYCocYhGBwhXtr6zJwZOGSYUWKkiO9EiW4WW+t2O46DtHbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2Yx21b0j1MK0Ce6cSenyGIaB1kBCSsck2Aem2dw9Nc=;
 b=N1Evrkcwj1fWAM0uYMwuCY8upnYoh/7jEzt+lXu3A0ey7LZyzqWxwDAa9ALr0apb8Yox0wuqwE+lzQhgrR+HGIIlEEMn3GVaPhryWkqvDYIfzWVE02eVCJXYIHCVYbFE7TUBEbqS7eODp+s31pTn3HEakXO1/VDaF+JNBn2K47k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS1PR04MB9405.eurprd04.prod.outlook.com (2603:10a6:20b:4db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 03:12:24 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 03:12:24 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 02/10] media: Add Y012 video format
Date:   Tue, 20 Dec 2022 11:11:32 +0800
Message-Id: <cec05e22df1b9f33d4681aa4ed2b6b1175a13161.1671071730.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7edcfb57-657b-45b8-24b9-08dae23803dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xG/hly2z2jD3b2Vhx4jnLkQn6jSVdmT2CKAFy/ww6YgWMDhRXrfcmIN+JduRFQD7NVmWiOoLirPEhvHYIHUUrEElQO+7vcFekmh6ZrlxPYa+Ro/C2Q6qHajnUWofCTqK+vPPKIkp55y7q9XKhZnYtLJfSfjIHVWfnVa/cJS1L5eQ7ipo7WU3GhHOqOKiNCh1yN4IkVyRa4azn8msnC0UWXRAa/3uCjwhoixW/iKeI3Z51Rka0uE4BXciAgJj289QZP0/UInp4Dkww8hL45T/5r15m7q0chIp3cIpd21+1j4rxBh15AEOgyyPqQsx6LNnMTlykFo6brMv1kuuCbMBkHklzY2o75lGxpWRfttpa7H+CgnhkohStrSU3azTOpx+7hW897KtF12mUh0rZpJy6ywfCvxlobWWel1ICB2QK7ahUGVpo+2XKsufv9IeVf4QjnKOKmyqVii6gR5c+uangNkGOJjZLIeT3e38jqrtZt9deClqnR7uNhEySc75uU0T5utAwuW832CzUcp1jktFrUHsyjCLFkauCzPhAfy3GE4pgfuuzF0CoalAHIvXX09wLKdP5z/s8YQ9elEzOL6Ch9XFR0jr21OPJQ0C3BmXAqxhwvxSgpkbInzabcAgrkC3pKa3w9H6XMZBWENjAs9XGuIH10siUwTVM25iHQOC5FqFUHSxf2UBUGj1LSc91b3N/G4LZCtxc7aRt1NLRdIlSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199015)(36756003)(86362001)(478600001)(316002)(6486002)(66476007)(8676002)(52116002)(7416002)(2906002)(6666004)(5660300002)(44832011)(66946007)(41300700001)(8936002)(66556008)(4326008)(6506007)(38100700002)(26005)(38350700002)(6512007)(186003)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QQ82qs5rSZC5+R7iSi5Ys2puFXjkGRjIRri+tsHp2hCY/axjkjYJYhgY/ELE?=
 =?us-ascii?Q?uI4K9Aw+F+UpbH8f7DU2pUwMUgDyn854bkYLvpKQqo36OsIxEOqQb+rMch8l?=
 =?us-ascii?Q?3drOJi6LPeeXpsI3gzGZsjbWsXc4l8mgNftFuuS9Hbt7oc1ryV9KzTFSREBZ?=
 =?us-ascii?Q?LX4Hm3E816SycHOSAqDiQytTDkq0t14/CC9OLSExCAwKHvnZKH5T04njTe/X?=
 =?us-ascii?Q?udBNF3Lxa0HuEdhtQddNDj49/94sH8mK0DmU+Q0unKWmXXMImQ4S01xji6mk?=
 =?us-ascii?Q?rnsIbQ9w2OumCAnNj5BwKqgWNeO05AYAyB8kNk2SLapHX+mseaPFRaSJZDJ6?=
 =?us-ascii?Q?0opoGq5ypMa4+mCIvWeCs5UsqsXEIxXZx6tTyu+M9sHDFJJL+OhowbELDu86?=
 =?us-ascii?Q?t0cDUx9bWA0r4DjypJ4NzMTDNYI33swAXZCTxQV8TaBes44H6vNkDVEaTUxZ?=
 =?us-ascii?Q?062uzaF7/HpuaWwvN/5ED/yAmLaT6hFFPVJnQo8hBmBnpNVb0D0nwl0ygyY8?=
 =?us-ascii?Q?uiIMl2ubr/LTxdc8a/jNOST2dhFGvlauDUHOpSeitFoP19C4LhYoFV40tVf/?=
 =?us-ascii?Q?K2nQmxRl7/Auprn2SwukMQTSpsrMqNrQZ0RlUob1Mim7qlDDPgXy/2DuUeea?=
 =?us-ascii?Q?VEjB0eXqVVzLZ+3NXCMQj3CQqj2+31H5MlOvGvDD9jAD/gD0cQMffacVYlsf?=
 =?us-ascii?Q?a11MMEdAmA0vRYKjcL3iTwy/Fy1VhbUpfPovM0KmOwJpRflSPBpjqi/MnzfF?=
 =?us-ascii?Q?ETqcpRFpFA9iPK8CZAwqZ4f0wTr/qMafdcxmICRLwYFGqTRMtisoOAkjUTE3?=
 =?us-ascii?Q?wcPTNQl+4s4N9dCE6omeryVqOyTby92TQsA55OsXQ1T20rjita5K+Op4ws5z?=
 =?us-ascii?Q?EhOQ04maLTwevYEOJTt/PfBAmBNOjjtIlnlBBSt/7sJKztHNdJ8/+Q/Xicc6?=
 =?us-ascii?Q?LKqFkMM5tnPa2DnhZ4CLlAmfbLnyzX+xl0KaWVw6rbCsTukLe97ihNEBK0Lp?=
 =?us-ascii?Q?Q8z88nZas6p+EhbCM71hJTQVSshRKDL/So3iSRpumjRJUrt4GwZ6izFtqvpT?=
 =?us-ascii?Q?JF6sXVQ7il1ScDlhJ24q48O7RbcN2qR7NGjZzfCpAO/gRgWJynGlGVL7GckF?=
 =?us-ascii?Q?o/CFWs6R76rWoP34F2rW3gG6AqZIj8ILJL13G1eH7z9mvRWwq8+hCpql7zLz?=
 =?us-ascii?Q?AGbhyFdXoPS/NijhWVaGX1PH0gI7rCC5lqKClkDxj6vqmkMXEGNk/ogIOnx4?=
 =?us-ascii?Q?gxCczgR1Mra35LTYO9R9xwqz6876ZmClfoyOCuwNjQPbzNfE0YXR5g9Q2Fz9?=
 =?us-ascii?Q?SClrNMpQO6uYh2RTQSaWeEEPlhnm1gClccNCjLwdh9jr0X0PF9C/cWKZuMOT?=
 =?us-ascii?Q?TMwRO6NOpGs7BMof/hgvzp4kkKPoXNEqUnwgQyC3UZVKgZLgen5n79Ijo/yI?=
 =?us-ascii?Q?BGO5CmC/+85Qc2Nm/6dwLu+wX+Pob8jYKajOmDFfiY+0FWq4FuOoranOgBZu?=
 =?us-ascii?Q?LMNYCNQ6qOlIyYQl/ofFP6wEwHYZQjY46D5bN1lWMlD/NVRHMhG817SlTNSd?=
 =?us-ascii?Q?lmEYoWq34EUoYFxnVKlJ6Zm448cre8jp8qtXrxKd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7edcfb57-657b-45b8-24b9-08dae23803dd
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 03:12:24.0029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gK7ZbvyyoUXUnZeK1Hygv+ke0Xv88PMoT1n8U9FI+2e0vxYN+nPdOHkTGgnjxG/ZWMQl0iA8OGhLdAxgF7708Q==
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

