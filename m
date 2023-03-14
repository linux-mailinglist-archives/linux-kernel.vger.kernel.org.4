Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10406B8F70
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjCNKMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjCNKMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:12:23 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on0603.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA0999D7F;
        Tue, 14 Mar 2023 03:11:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dK7RQbX0rEQlg2sCqDXZhLMWyd2Htff5g9s0tCSfi7R0P4gS44TzZ94aDqiFFW5L2AGgex/8tye5jg7QQD1ko8qPMSuydbU8vYuBVrtc8GdCsGUDzM2TqpODON6DgXgUIL8LfN81Nqwuju0eHaAag/XOTskcGYKnmu5gw8PgQ4NXUWjerh7T1aDVSy0DMqq9wWVPyBzjxElRP6JUlfZkyTUNB85RsoQvj5bKj36jqW9m/0gN+/055D4I/o9QLH8F+zgX1xlMBjFpJ0M58WCoUtM6pBWaAPMpHUxsFm85CpfYHu6JIGUGjSYVTZqj97OJQxdSFjdnSiJ/TIIKp838xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0OywNSR58/8/Ip9EQ7IOUPZsp8jHhQekHxiCQTr9eg=;
 b=A8oa0ohct2TrCP/G3+upIfD1tLnq+qHq0tQEGVBlC3/sI1ljzBy2PvNer/tH838wPEP9Te2lKgkq8PjZmSaIyS+tCqb6SUNTs++pqhS5Dx40toiS3uMuXThtcbBOqv6QMVSK/EVm5FevdGW1x5Ah/Xq3nEMRs/WVZnUYB9WRoIXowgxH57fRnk5589qmsb6kWeJ2fw+mL2B+2zuO2OjccKfN/Owi89maiiF4NvB+GTcxP6aExgrUygd1jTMYFcCZ2jxgdNZLjorJ9q1EubUw4P4bE7uwBjwKzA7KvbT6zVLHA4vQvmV9EyFQvDUE5qZ7N892USJONIdlZm2aZx++bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0OywNSR58/8/Ip9EQ7IOUPZsp8jHhQekHxiCQTr9eg=;
 b=qDfFZMLEZEeAzk18pfXPVUV4fjPce1fsfsOvCYzm0p8CBvbYuGyN44dY3TETdoC6i8TQwTKsm21AQyUTd8qE4m1HCc6AgLVqaLpXsICKNEptYEVqUA5T4n9BUwEG7h5y5pEVb+pKGV7FDzw6xvLb9t3N/wqM3B4TJKVOolhV49Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DU0PR04MB9346.eurprd04.prod.outlook.com (2603:10a6:10:356::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 10:10:14 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 10:10:14 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 04/10] media: Add YUV48_12 video format
Date:   Tue, 14 Mar 2023 18:08:47 +0800
Message-Id: <44bfcc0f57f0eae6d2a94914e40a902556f6eb02.1678788305.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9da7cf42-fbe8-48af-5293-08db24744ddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n2fMGC5OGkubmxJMrnghlh+MQBIhRKJxO70FHOoV8lNfQy+Ym3pRUQWbiwCSD4KiBOye/Ag0WNe6tuvi/NQgbO+PSnXWA5DJX/AyzjVKCm0Ms/5dJ3VDBeoguk61UBWmg+s+DYtjFgEtzvsLRN23k4czMU+7W1RpyZomQj4ManDHPBxDRsPavHKGRChEsH5TnLTvnR3l6TMMWp63yN3kscRKUgVomt0WHwmI8haMh69CLCKmwoj9a4OEeTL7h9Y8SpgDC8wfQ/jeLc24KGwzzYrZ6B4fPSDB1sFR1vPiDSvBLDn0TM1/WN+R7MqbE5Ajtp3X1C5gBBVl4XfAhWEJ0CIr3v09dOBBDcRvQrCLwDQ3bn7zSo9HBAEGK5k7yzl+zWhaTutGo/uTBx/9cawJZDFasoPcsM83aqe9vUUjddENhxnmhbtzFBOdEWJo9POaKotbBLlVBidIdV3t9O2gKWB0FTb+MLL7LJsnNnxo09I5KnC/aoHkLlEgs+R33UmfsRgCUGsn4ooQEZXbXzLyw3DZ2PUgeOvsXyQDodZRmJiKb/OlyLp5d45tKcSbB+gx+tHeSWJsyNf9nf9BY+/IGlji8+/K4GkBzYPiyDQnlPP6TA0RWJ1IgcZoQQTytup9lRaEeRlzxhFu92kuTcn6izTVsUW1iGB0kh15aX0T+ftB7ilYCQ4XyZGSl2a3Zhesv3pUNaToSKDilv0hH9vAgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199018)(2906002)(41300700001)(83380400001)(36756003)(5660300002)(7416002)(44832011)(66946007)(8676002)(66556008)(38350700002)(4326008)(66476007)(86362001)(38100700002)(316002)(8936002)(186003)(2616005)(26005)(6512007)(52116002)(478600001)(6506007)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pe4WMoNZjV0YQgWpyYzZrNPt3VbuW8fnR0OtUcSjHzSw3r9tpdw5sJTZCWzM?=
 =?us-ascii?Q?DHI5hoKhOICQ8zJBY0xl1CwEjn6KvTM3OeJktI35iYSglPD7myJ1HBpRhT3q?=
 =?us-ascii?Q?l6bX6wgkfaFS7lH9Dy/s24zgwbfyZEM2S5jR8WWVA2PWkn+iDaHqySq99dzH?=
 =?us-ascii?Q?DNPA+3I/9Gz/lM7eJw266LjgtU4Z5l38DJZzzHvLmSV9WKsAwubTHpk+M8U4?=
 =?us-ascii?Q?K0bsHe9SNhOMCEW+mSO6exZsBb7GthIef6jg6j0lbvyf05+c5WQWCBm70ySf?=
 =?us-ascii?Q?7s4YrD+jr4S6HEfoXEPeCyGHESI0F6EKBzv+HYz6PMMYG3f6DK1ugHti1VkW?=
 =?us-ascii?Q?1lA4bj5Fnk0EkS52F20hGQPbbOQTi7t9sh13LVG6zUib5FxsiiQV8fiRpfor?=
 =?us-ascii?Q?dr5ugI1IsDhdqq7m273PDxZMlOchewNKRVaM3d2GpfZJ/3RCMIoLuZPCzFFt?=
 =?us-ascii?Q?o9k7fvQQcpCehvAQM5DY2/6B0Y2A6IAU6BI7wQFHiHgI4dzvIvifat9PuUAj?=
 =?us-ascii?Q?RUfmZNEv4nVskrAGyX9fcZvY034Hwc4Dw+gWFtYaF7v+Y/1OLvxedq6SS/Jf?=
 =?us-ascii?Q?7m/OOd43n1tM0F+bdIbdColVqfjIHuYNJcQ0zRdSxy4/sZytdkVKp7exYCdm?=
 =?us-ascii?Q?TfaqcfUAKhxsCq09NjRtmYJvtfoDfJw5yonzU+wuyqhzIEFR95GbPo2QvwHt?=
 =?us-ascii?Q?OVy8xqzEzbU5T8tRkUpGQVJrph31l2t7e4T1VoZdBa9KnFiFAg8Zu9YxVUFh?=
 =?us-ascii?Q?jdMWm368T8DTZkx/+ARSwzX9ep44qc+zpCP+1aUm+1NTo4lSbc+eQSL5UYUw?=
 =?us-ascii?Q?8aROk7AXYsMhUqReeXeOnLsoFYa7wDz+AbyYXxVabXH3kyYR/qX5rymXsuF3?=
 =?us-ascii?Q?PV1JmLb/q016KW4WhqQ+VEU2reu0oqniO4KcrIcIUzveD+bfUhbLFFCCFTJl?=
 =?us-ascii?Q?nOiMmx1JLqOCSY04EFzLkaKXJZkbYIEZP9ab+EpSxS93CSZEzMjr1HpTNfMk?=
 =?us-ascii?Q?4SG68rqUmc8ATAC9g7IhgsaQ0NpF8g2FjGkcHHc5a7ZaMl9sRoGMXAZhF1TE?=
 =?us-ascii?Q?7F67yR9N9JbiB6H78/k3gSmeMnO46xWxw61EPf2jjBhQvZv4TNFWc5D/p3bt?=
 =?us-ascii?Q?Mf0P4ZYyRjPsIgpmReJGwAInOcmNuuOXn0wDb0pVJjr9/ZNNxHf4GXB9tGVt?=
 =?us-ascii?Q?ggCD9a8eGtDzRNN1x9xuIQh7it6CAUUEubqto8iYcM25lIgfJn50cBdK1QWb?=
 =?us-ascii?Q?D0T1tGoDuIGuhLxLK/bKfOZIBTszgNNlYoWEqNDFmnAVI5BzTSwPW7DmJ056?=
 =?us-ascii?Q?Lp2JpGjsfOeDkV9ayqaBLb/unsapIpRUBIRZWSBIMsjJOBAXuw38fEQhEtS6?=
 =?us-ascii?Q?H4vVtTis07KV9ZmaG33bv06unmxyiRTUajf5tTx59VvOj/9gXk5kWVwykscy?=
 =?us-ascii?Q?iG9N8i9KetEz/2tllrt1kgpK+pJgQgg24eoi64SJ4kFS5qpupzaa6SPazBKZ?=
 =?us-ascii?Q?XfTlkg97WtTga7naOuD+FFbFtvXkpua+XCb05OVh+iMD/2SwTey3nuK9RQdC?=
 =?us-ascii?Q?Qmc/tXFeQ6XV5YM9MsUzboXP6wj5BAPX99iZLoCC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da7cf42-fbe8-48af-5293-08db24744ddb
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 10:10:14.5957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyJz3VTyE2S1bkRRVhvda6kRjDW6cr0dXmPlLCUfCKrBdq9XkDTS1mCLQfsMVQc0aIyn91lX/w139CPAaAtgsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9346
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YUV48_12 is a YUV format with 12-bits per component like YUV24,
expanded to 16bits.
Data in the 12 high bits, zeros in the 4 low bits,
arranged in little endian order.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/v4l/pixfmt-packed-yuv.rst           | 28 +++++++++++++++++++
 drivers/media/v4l2-core/v4l2-common.c         |  1 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
 include/uapi/linux/videodev2.h                |  1 +
 4 files changed, 31 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst b/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
index 24a771542059..ed998d8341ff 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
@@ -257,6 +257,34 @@ the second byte and Y'\ :sub:`7-0` in the third byte.
     - The padding bits contain undefined values that must be ignored by all
       applications and drivers.
 
+The next lists the packed YUV 4:4:4 formats with 12 bits per component.
+expand the bits per component to 16 bits, data in the high bits, zeros in the low bits,
+arranged in little endian order. storing 1 pixels in 6 bytes.
+
+.. flat-table:: Packed YUV 4:4:4 Image Formats (12bpc)
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
+
+    * .. _V4L2-PIX-FMT-YUV48-12:
+
+      - ``V4L2_PIX_FMT_YUV48_12``
+      - 'Y312'
+
+      - Y'\ :sub:`0`
+      - Cb\ :sub:`0`
+      - Cr\ :sub:`0`
+      - Y'\ :sub:`1`
+      - Cb\ :sub:`1`
+      - Cr\ :sub:`1`
 
 4:2:2 Subsampling
 =================
diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index 21ace56fac04..da313a0637de 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -259,6 +259,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_UYVY,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_VYUY,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_Y212,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_YUV48_12, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 6, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 
 		/* YUV planar formats */
 		{ .format = V4L2_PIX_FMT_NV12,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 2cb485643562..6543cda5815f 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1346,6 +1346,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_YUV420:	descr = "Planar YUV 4:2:0"; break;
 	case V4L2_PIX_FMT_HI240:	descr = "8-bit Dithered RGB (BTTV)"; break;
 	case V4L2_PIX_FMT_M420:		descr = "YUV 4:2:0 (M420)"; break;
+	case V4L2_PIX_FMT_YUV48_12:	descr = "12-bit Depth YUV 4:4:4"; break;
 	case V4L2_PIX_FMT_NV12:		descr = "Y/UV 4:2:0"; break;
 	case V4L2_PIX_FMT_NV21:		descr = "Y/VU 4:2:0"; break;
 	case V4L2_PIX_FMT_NV16:		descr = "Y/UV 4:2:2"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index db06d4c4f008..8a6430bc4a00 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -621,6 +621,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_YUVA32  v4l2_fourcc('Y', 'U', 'V', 'A') /* 32  YUVA-8-8-8-8  */
 #define V4L2_PIX_FMT_YUVX32  v4l2_fourcc('Y', 'U', 'V', 'X') /* 32  YUVX-8-8-8-8  */
 #define V4L2_PIX_FMT_M420    v4l2_fourcc('M', '4', '2', '0') /* 12  YUV 4:2:0 2 lines y, 1 line uv interleaved */
+#define V4L2_PIX_FMT_YUV48_12    v4l2_fourcc('Y', '3', '1', '2') /* 48  YUV 4:4:4 12-bit per component */
 
 /*
  * YCbCr packed format. For each Y2xx format, xx bits of valid data occupy the MSBs
-- 
2.38.1

