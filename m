Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEE966D445
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbjAQCc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbjAQCcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:32:21 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A45924130;
        Mon, 16 Jan 2023 18:32:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkvjwNWN8G+nhgS1zrbERCG3rvinSFzt5SaBXyqm2Bz5YeDvmnBVjodSm+5QLbBl8alqCG7zzXHxQ2f+Q8gzisgGGq3XXONYm6r7tko9CibWRljuPUnJV1TtbQmfU5z15OEqQ1A0hrqZDB1qasdnpyNJJ0aFLQER+VitAKueSaSkZ+wjbvwCLm0gtJP/cK/yZHi2J7LynFB2hY2XKzLseAVcG7+mrI07LzTngQHqAQrbE2tBX0KOTpdrHxM2rbn0h9NOvutR/WKAsKUAHXy9CFzsqbHS6lYlbM7z4lRHKDiIx1rHyoPtYoaLmwBRLXmBaIddm89yAN6HJTdz4XD+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tyha0VYLVYYL61gpGycKJuUWdhgHBy60gc3/TUZI5p0=;
 b=XZI9GJi8zWotzJcv+ZQPr869iRGKs08lm2XyNF7OhV/wzcHXJs80be+QuKAUTcPbf9EEFTuBoicTMp3pNEcvH9dpo9Su052sB+ZiJyIE5fV5ijIk0RxkUk18IiwVz0RMVPd0Nqcl12GSUr+aM5gWHauch0XL5V1oxgFIHTZbx6bX2lf93axE9HzdnUs9c8brVRrdBRyGbol8ppzaOXbtPRCqzIFJjSwmaZqadQWMv8fkFm73sT/BZ4x3wjYDrtOoJbfI5vxRD/Fx8/2EBuDGs9Dsw1m0nA3slsP9GhUTNU0XprMMx36kLcOVsaFFF+yfb7p77jS5D6Zdezeycd9zlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tyha0VYLVYYL61gpGycKJuUWdhgHBy60gc3/TUZI5p0=;
 b=BfJYA81FNIUrMVoUiZ/FNshmgrP38yecqccJBMNVj6fnCsemJ9DE1XZ2c6A17A0tBFfnhRT2nNplfzHrphjZ9qtYgKO6GP0pleU7hu6keAni3skVyxU+ay9aFK1PCBHHhZpgPIbsxotFBK3hsHhQO+UtjMQVgt9tYYykGxwbPcc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DBBPR04MB7786.eurprd04.prod.outlook.com (2603:10a6:10:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 02:32:17 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 02:32:17 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/2] media: add RealVideo format RV30 and RV40
Date:   Tue, 17 Jan 2023 10:31:54 +0800
Message-Id: <daff0c9a4040d77f142f055d2113100251354d63.1673922423.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1673922423.git.ming.qian@nxp.com>
References: <cover.1673922423.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|DBBPR04MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ce6366-015d-4e77-2e28-08daf8330cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KKYw4NwOkSB4ut6THyZBFY1vuWHLaaYChErMrn3FFplyeXah+pBYrv3FQaYxKIw6d+O87neU1Dfnc93xG+n2jO3B+GLkdc05/YT+ajT9iHjvXyPN66lmXECeAx3Y+cftKywUj1wTJ3xjf14YZJY6YjNAL7Zyjd2742A/KxxvAKLyzRHxBVOvPq+JSHGsMUjM0xYlXwXBeKPgaHM35lCXZvFWVjh/4PyV3madx4OrPHBNDcgVc6sLZiEuNMAMvUonNKAVfhcMKq6f4RWKt3K5+loliJUxaVMyNbKzS71LklZyAcmve7E/hif3mCAQFP4SfyjoWAYq2bN7u+qiX2LIfIhqEXWvJD6e23FA35ayHE/2wXYvs+Xi4o8Rklx3R9p7i9uLPMEqSCpEbQtA716zYn/r9vdVhaatvGIppDf2nk6r9rlq7k4i7hInNWhzDbGx2mIejxZdb5PHPSV59rpHVi7qQtqQTJ2aa5lW0LMn+3iF0AhTz3qIglsw6HaNd886xG2yvBc6bsoXMJHYjccjt52cBPZnb172MrHRe8qD7UsXfWBd8VmNGF2kJ9GxofpWzgbb9WOPjxXJropXhvAcVJfj3nLGW7TF7yiM1pUtzGFFHfOECeos+S7m6TlZK4MzGcLZ6rUYOfgsC8KiFSZSifEE7iO8Z7Av+eFzqQR7WzGRaXflmZKK3bXrHVxqf+/1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199015)(86362001)(66556008)(41300700001)(2616005)(66476007)(66946007)(6512007)(186003)(26005)(8676002)(4326008)(36756003)(5660300002)(38350700002)(8936002)(6666004)(478600001)(52116002)(6506007)(316002)(7416002)(2906002)(38100700002)(6486002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kuXZXSYcn3CjrCkUfQltUf7eFan4nW/1Ly3AEtwlx3vvcdxEg8zsNAmyQm0B?=
 =?us-ascii?Q?J0Kq8betnYYpIkGeuT7mmoV8NEPhB2hhP5cvEO5Y5sPzMAudxjJ7Fl1u5ggN?=
 =?us-ascii?Q?rdgmGOZqjdkpBktM6urkStJH9az2WfB59yOd8z8yzNf6s5vG8OoCWvuCI20+?=
 =?us-ascii?Q?yZZmJV8j4vkvLK5di0lmCZ2dOCrfPfG8mjIFlXtyMyTPg+k2N9g+iXZT0bq9?=
 =?us-ascii?Q?5Jl+QU0BRlDuwM1oHUpAe56f0kBLoS7B3o+34G7lIRFgLRr9MBiD/cGZM7j6?=
 =?us-ascii?Q?bCynGfSDWuGy4OMlP2T+RKXLlGNaUPetAAGpgaMnB0ielkYvrfGI1f3wrVve?=
 =?us-ascii?Q?uUKEsWITYaZGmQ4dtY6phuMqZraageX5DU/EqvNMxMTHGQS02D3/Hdz0GWFb?=
 =?us-ascii?Q?BzMnSH9WHFU2xlISQOBvMSfVyzAEC+q99LsYcAjA4LSoLvfqoYQ0ZfbfHE0r?=
 =?us-ascii?Q?GsOteTSThAq5KJzjK+wZbnq5W+ZErBYAs/Im9MHXkplsQLCPO/xfDPKx6/2H?=
 =?us-ascii?Q?60DeIa4256uoBuV440ze26Cw18j9a9BrlYQTc2oexx1vR4BylyABMgLQDtgr?=
 =?us-ascii?Q?84YHUXmU2jJYx7EXJf2q00ykM6qaynZ7EForHJ9Np8jbUnBD5TMTI2+CGSDO?=
 =?us-ascii?Q?Cf+7gjwjdAnB37zQ9txkfoVwQSrAD5muNIlKRbszODxN4uQxp/Te6b0lKhTp?=
 =?us-ascii?Q?tSbT4rJ6jW0F0xlAZnS3lZfo3QmHt+De3TRLcdixKOsrY5O9AGX1kil4lRFp?=
 =?us-ascii?Q?0qiSluHsYPIS9JEjs/tdtvJMJ3Zo1Fcm+8rM6xuT/6/9U92PjujFEntxX/y4?=
 =?us-ascii?Q?Daj86I4IT5r7Hx1dhn39KstzCZBFry7vyYQL5ObP27jtFQwxs0Lw5yVdKH8F?=
 =?us-ascii?Q?mbN2KDHgEFx9VJG+RWYuktLB3OgNiwEp18nAjOIZmHbzIV8zP2rfkk0eNrmP?=
 =?us-ascii?Q?24lvQo1+idy92o/6utE+K5LcuwIppcebv3ZP+yLsteo7mMOfyvI2zAH0Lehe?=
 =?us-ascii?Q?1uThcY5jj1qNOlxC3Sm6gG71/BSNVBADRi5kC6QqUoqkgvCwAIDZulmkyjUx?=
 =?us-ascii?Q?a3CbWOxcjE+Bzbe9D+ARvrIxUJkJRzA1u8VVMCM+Gg755bUnvWvJdqdoeiqo?=
 =?us-ascii?Q?KFTzIGB5uXO2W9ZkGd9x1OwWX2uOT211kVhD2Z1/YHlnpJR9qgnVvhd2YeCu?=
 =?us-ascii?Q?qPpk+5QoGUFVj67+fFw1oUK7fBxW5BR+yatCfnZNXZGnmsSLYr2qByLa+nbR?=
 =?us-ascii?Q?O4A44tasWIWvXTdFr1aY2ZUjE474BnyE0MLNaLs5gluhkFst+vZ01ClU+1XF?=
 =?us-ascii?Q?IPU9La3B8afNo2NdpDyWCdn6Y6J4rP+jQkHAU1XgA62zv6t8zUi4euKlx8im?=
 =?us-ascii?Q?dmtFb0MJNziIpndLipOpXGxiVsfUNNJswvL5aJOoNEWVTvcbC9lvn5GQ2Hmx?=
 =?us-ascii?Q?af2xRWRNJPVATYsB+sFpEHpTAtsXWkyY0kUFUuzCj0OAPTr4gtya/dahaNzJ?=
 =?us-ascii?Q?rtxuEKUqNWWTB8lKVcvFwFKSdg5GPU0YIfOQdaDTtWVstMDPUoXpfzyo5GYc?=
 =?us-ascii?Q?+nIhagj3IJUh2Kvre45dbGfR+1EYCf4/09QDdkNm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ce6366-015d-4e77-2e28-08daf8330cff
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 02:32:17.3604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ua2wmvzHWuVHMoFzQI3DXWXEMVqf2hhZbJcLjIveIt+XLjKSwQtUZ/1npOlcY5JneMYLkHsJQIRKh8xhcJmaIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7786
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RealVideo, or also spelled as Real Video, is a suite of proprietary
video compression formats developed by RealNetworks -
the specific format changes with the version.
RealVideo codecs are identified by four-character codes.
RV30 and RV40 are RealNetworks' proprietary H.264-based codecs.

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/v4l/pixfmt-compressed.rst           | 20 +++++++++++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c          |  2 ++
 include/uapi/linux/videodev2.h                |  2 ++
 3 files changed, 24 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
index a0230f357680..06b78e5589d2 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
@@ -237,6 +237,26 @@ Compressed Formats
         Metadata associated with the frame to decode is required to be passed
         through the ``V4L2_CID_STATELESS_FWHT_PARAMS`` control.
 	See the :ref:`associated Codec Control ID <codec-stateless-fwht>`.
+    * .. _V4L2-PIX-FMT-RV30:
+
+      - ``V4L2_PIX_FMT_RV30``
+      - 'RV30'
+      - RealVideo, or also spelled as Real Video, is a suite of
+        proprietary video compression formats developed by
+        RealNetworks - the specific format changes with the version.
+        RealVideo codecs are identified by four-character codes.
+        RV30 corresponds to RealVideo 8, suspected to be based
+        largely on an early draft of H.264
+    * .. _V4L2-PIX-FMT-RV40:
+
+      - ``V4L2_PIX_FMT_RV40``
+      - 'RV40'
+      - RV40 represents RealVideo 9 and RealVideo 10.
+        RealVideo 9, suspected to be based on H.264.
+        RealVideo 10, aka RV9 EHQ, This refers to an improved encoder
+        for the RV9 format that is fully backwards compatible with
+        RV9 players - the format and decoder did not change, only
+        the encoder did. As a result, it uses the same FourCC.
 
 .. raw:: latex
 
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 9b5b04b8aa69..0546b00d3fc9 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1473,6 +1473,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 		case V4L2_PIX_FMT_FWHT:		descr = "FWHT"; break; /* used in vicodec */
 		case V4L2_PIX_FMT_FWHT_STATELESS:	descr = "FWHT Stateless"; break; /* used in vicodec */
 		case V4L2_PIX_FMT_SPK:		descr = "Sorenson Spark"; break;
+		case V4L2_PIX_FMT_RV30:		descr = "RealVideo 8"; break;
+		case V4L2_PIX_FMT_RV40:		descr = "RealVideo 9 & 10"; break;
 		case V4L2_PIX_FMT_CPIA1:	descr = "GSPCA CPiA YUV"; break;
 		case V4L2_PIX_FMT_WNVA:		descr = "WNVA"; break;
 		case V4L2_PIX_FMT_SN9C10X:	descr = "GSPCA SN9C10X"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 262ef10cfa02..b121154a6e24 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -740,6 +740,8 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
 #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC parsed slices */
 #define V4L2_PIX_FMT_SPK      v4l2_fourcc('S', 'P', 'K', '0') /* Sorenson Spark */
+#define V4L2_PIX_FMT_RV30     v4l2_fourcc('R', 'V', '3', '0') /* RealVideo 8 */
+#define V4L2_PIX_FMT_RV40     v4l2_fourcc('R', 'V', '4', '0') /* RealVideo 9 & 10 */
 
 /*  Vendor-specific formats   */
 #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 YUV */
-- 
2.38.1

