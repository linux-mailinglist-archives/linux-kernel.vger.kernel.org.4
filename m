Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD406C41DF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjCVFOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCVFNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:13:54 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14A150FBF;
        Tue, 21 Mar 2023 22:13:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLH1XlHmRtJ7AvtFcd8bKycasMaeySw9MtLldrDh9mpsTCUFcN0gYjZWEsRDJYRw4HXES3c6TIYNHNAGwJz9HSeRgC3Zac56fD39cuUQu5ol9cAauN1yD0AWTKk3Eik0NpZ4uIVaazjl+TdmPn0xN852vbqKXjIT/5ogPSweSyPpWQtvN+0pp3ONn1ITFdUqShXrg3bcRgSujxcSf3+PlCKhsni3XZztOqmpJ+yAcNddK8NCB6M6Pj88RTzl5cUnV1jCeyCQ1A/5OGXZvJIsUe8UdtHIZPscEOdOOFSoNSMljY+l3mTYXnZqKqdkM1vIsRUg2ENL2he2/Bp9N0/+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaV1IAbypr+7qw1xD0wjbMHN8X3GD4YNlQK9XQbiICc=;
 b=nJ6NTuFNpixmTlhrDmZr4NYqIoQrdQY6JW0jESwfknQs65O4lNVEjAB5RU7iC19X8MlMscQJ8h9LCXbz0wzWgvzjcK+UfqZPUiIJWKeKsI01jmGvs6V2H5g4/skDTMZQ5lbdTUHgI1O5JRBgyKq/YTTJyMVStUrpNZDkjluO8+FESHCuZZueaSVpeg11rpK3po0zx8kM74OnVcdvNkyEyyX100t2smQRtc5hyV9wLZ/I0MAL1LXRa/HsWxXxXFBBl6RM6a3MfmEyHNZuRrmPrQA3/L+35frORSpAtB6nDg6MayFW+J1zPxKf8o0M/qgPtsE/NwKcmrFVscO3IGlFew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaV1IAbypr+7qw1xD0wjbMHN8X3GD4YNlQK9XQbiICc=;
 b=DDMTy37nzuOp6nV5CDiJ1TgGbK8cuGvoIMtXVgBN/z6fMgPOgqN0EfTNV88zum8i6n/QGXJwSQtu9YmMiZVW5Ub7pzvMTW3IhSUT9bhTrHLKEDY8xLQBI1T+gb8oFZhk2TXKi1Jixk8pX3Er/BCFmTke7akdIwtHMekealsYFAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8100.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:13:50 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 05:13:50 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 02/10] media: Add Y012 video format
Date:   Wed, 22 Mar 2023 13:13:05 +0800
Message-Id: <25b44caf5b508c099f29019df23f967d41802332.1679461709.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1679461709.git.ming.qian@nxp.com>
References: <cover.1679461709.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM9PR04MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: b5033481-4f87-4fc9-100d-08db2a943907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wfm5wgm9rTiR9oKuJFQMvHW4njz+OLqYOJzoO//EYEz/PYP2rlkbVKKZJADINXXhwqGOdRmydUKTzmXRS2IYZq7G467jcUY+4AnplSznTRbU2OBLI7R0hp+MyL2g6bDjSNSH1I/QylZh6eRVSmsNtj8mCU8s7WzUrJ/mlL/HpHsuCLNWho94tgVUB4YX1s42Blu7Re0MWRHJX4zE0/AIksGmWzmxV5UEDbnjD4ct0BvOC81XbU6Fqfak/ab4oka+4gScy2ClzaByk+JOc/oEAXEdhxbNkkHse4Z8xNnqpqZR2PRy1AF4sw88/Z8JJVkfxKyY//mJTd3/eiT8jK/Luf6BydpIs4unrONwLux/Cu9MbTIiiEjawK5LiDUjjR2w1qexQXpA4Vv6AMKgXMUp2zOsWQnTK5vl/Y6g5mtd6Icj1PGXftXfmifG46q0j+BCqII5t36EERgvXcgOvOgYC/9VM6xL35ZFI+h7BAEJS/eA0I0tVzOtPgO0krxbaWYpcbfbwn7shiNHLpCTDUiLYFRzOVMNBLmfn0W54rvTlIkQbA/7SUOVVZSslDFpLmmh68iFxzehWlK/qphqwAIsZbGTL06TwXj/1ZmFaD7/N9oHQB3s3phXXDGcplZevOAbZUAVbKTCUV8XqIOQ/i1VMm6tpoL+npRalDg5sHJKkIMDgaT5+NYL53iEgCdeIQswXzS1c324MIWB+xx61i/NVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199018)(6486002)(66556008)(41300700001)(52116002)(66476007)(7416002)(478600001)(66946007)(5660300002)(8936002)(8676002)(316002)(44832011)(4326008)(36756003)(86362001)(6506007)(6512007)(186003)(26005)(6666004)(2616005)(2906002)(38350700002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QUQURGCB8353rwDa18utDtdckUQK7HGT30YBU6vONaPseuX6+b/4CVPtMz9S?=
 =?us-ascii?Q?vqx+lMc3S7x2FkrFJt3yWO+Jcdj6LYYN0y03a/6nrBN3/cxm1fkZ04ERHrX4?=
 =?us-ascii?Q?lEBqhFBM3LTo+sR2CZJs14LD9QQcPY1MhC21YfnGLmT2CRH8vk/dsFwzLpK/?=
 =?us-ascii?Q?JNHdqAOqoNgVfW73+azIT0wUqbuk3MtRUQWLyh75e6wRboZnvdj759qFT5vX?=
 =?us-ascii?Q?5pxWIZR0+pflZSNEMhOj/XTJ94BhSglQ6EbPAlCg+jXp4UrE+EBXNAam6Y+d?=
 =?us-ascii?Q?ZzGZdhjxcwLkqsDWl++Dlh1D5HqfrnF6TnUA9D+SQAYqOd3yyUJgw3Zj5ZUi?=
 =?us-ascii?Q?Cjy+LZVoF0QRXF405vOIwoAGRtHp7mxna9Qph71pu30+2IYUrALRYjCQOQNR?=
 =?us-ascii?Q?r/f5SPX+/BMFamMhcvkTzrnuY3buvGaXT0a0T0cv+rRpVWH77YIB27XRA6Y3?=
 =?us-ascii?Q?wWRU35JMT4l3CiNyi0qP89BCHN06gE5nOIu42CZQuZMOMsjpVYOjsJnEkd70?=
 =?us-ascii?Q?qgHJALWp72WbxpGFKWj7AIXfJqw89d4u2rdg0E3cE4HoQW47AyN2epWiKzjm?=
 =?us-ascii?Q?xCUJO6fzs7EzGYqRNBChaN8H8CETiDIjFSmBkHZiNreHGOl6xlVkktA/xaYg?=
 =?us-ascii?Q?QG0PzO1kO4fz4FzfyVXZPfCXkJyWKW1Mj5xfi35q/BCsynexFAQS/lDB9q1j?=
 =?us-ascii?Q?2v1CueSp015Wb92IsPhGRIP31HScyLbiy5k8nRWZdUe4+MrOjBev00AFtDL4?=
 =?us-ascii?Q?ShtWbxIT1bounB5dDIuK5cUwJ9kLlh4biMvTPoxvuwKnURbMTMkpQlgCUVFd?=
 =?us-ascii?Q?YXqWHv8WMgbgyAoh+5P0aM9AudZV15OA4+8iya0lUelhvaW6wjE6n7Jf2IfE?=
 =?us-ascii?Q?z296OB+lqf/AIbLdtYmTQrjwOIBhkcYIQhXOo/tw2R5yOjS+4rfeI4LVNUOo?=
 =?us-ascii?Q?xsqcjPuhAPKyB4cUxRnfVS/+rxDzuH39eb0thc5VeKUFMFXKIb7AJ/1TnRKM?=
 =?us-ascii?Q?FrNI3WPf0Lcfb/1T9pnRjRVJqPuYJYqyI9TVo+LjIv4SKzENjBBY3yaiikXE?=
 =?us-ascii?Q?VPdUnwdmgWQXG9xSo8/nDzEZi0S803VoF+TWF3978fBY5DG4H3y86B1bv0Fc?=
 =?us-ascii?Q?XA0slb0lri5oPbrXWo5Vfi9BS22X83cEc2GQkFUzZkF+IQe5W5B/Dl1K/qzF?=
 =?us-ascii?Q?Y4ob6MCs6GlnJBMgNxmvDdwNczU3QiiRdncZbul+UvNkxJiFz6aIzCBzb9xU?=
 =?us-ascii?Q?qFs9mGkUw6Yesg0V7xLJ7PTY9VEVjUJvGNOU/1FbB3cNz/Aw4ieT1zLjpyK2?=
 =?us-ascii?Q?N1gBPMp5h5cX42/iCxuwMLSN6q/v12JGjTgmjzamfW9hZwYLtwvNFwemvFwA?=
 =?us-ascii?Q?8sHQtnyE0TVwwW/w2DmsKsnwKQ4UJ84O8Zichvs2PE6F4Py0vA9rxOw1MwRF?=
 =?us-ascii?Q?MCUndebwoadByHKUEOsEfXXhqEc7WHEgnnYoJmW6+tmYo/0CSYrpVPdhFvRO?=
 =?us-ascii?Q?FME2Lfn3W4AlskDSnq1BZIZZYHvXC2yWbcQoXS32hNMr21OIdceNom/i59H0?=
 =?us-ascii?Q?GkrZw3j+F6UNNmS08by5dCihfU14iMuaNdcA+dKG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5033481-4f87-4fc9-100d-08db2a943907
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:13:50.5066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ViiDt7XNsrUKjHg5hZ+OZTHm5YSk27Q/Xez85eZjdwCNSJJ110bshR8zgDS1O0+KlpDSO7HzLDabqT7Dl83ScA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8100
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
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
 .../userspace-api/media/v4l/pixfmt-yuv-luma.rst   | 15 +++++++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c              |  1 +
 include/uapi/linux/videodev2.h                    |  1 +
 3 files changed, 17 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
index 62078a01de76..cf8e4dfbfbd4 100644
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
@@ -146,3 +157,7 @@ are often referred to as greyscale formats.
     than 16 bits. For example, 10 bits per pixel uses values in the range 0 to
     1023. For the IPU3_Y10 format 25 pixels are packed into 32 bytes, which
     leaves the 6 most significant bits of the last byte padded with 0.
+
+    For Y012 and Y12 formats, Y012 places its data in the 12 high bits, with
+    padding zeros in the 4 low bits, in contrast to the Y12 format, which has
+    its padding located in the most significant bits of the 16 bit word.
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 6489b67babfa..be90a9f8c94e 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1307,6 +1307,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_Y6:		descr = "6-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y10:		descr = "10-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y12:		descr = "12-bit Greyscale"; break;
+	case V4L2_PIX_FMT_Y012:		descr = "12-bit Greyscale (bits 15-4)"; break;
 	case V4L2_PIX_FMT_Y14:		descr = "14-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y16:		descr = "16-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y16_BE:	descr = "16-bit Greyscale BE"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index f83a9d1210fb..db06d4c4f008 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -586,6 +586,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_Y6      v4l2_fourcc('Y', '0', '6', ' ') /*  6  Greyscale     */
 #define V4L2_PIX_FMT_Y10     v4l2_fourcc('Y', '1', '0', ' ') /* 10  Greyscale     */
 #define V4L2_PIX_FMT_Y12     v4l2_fourcc('Y', '1', '2', ' ') /* 12  Greyscale     */
+#define V4L2_PIX_FMT_Y012    v4l2_fourcc('Y', '0', '1', '2') /* 12  Greyscale     */
 #define V4L2_PIX_FMT_Y14     v4l2_fourcc('Y', '1', '4', ' ') /* 14  Greyscale     */
 #define V4L2_PIX_FMT_Y16     v4l2_fourcc('Y', '1', '6', ' ') /* 16  Greyscale     */
 #define V4L2_PIX_FMT_Y16_BE  v4l2_fourcc_be('Y', '1', '6', ' ') /* 16  Greyscale BE  */
-- 
2.38.1

