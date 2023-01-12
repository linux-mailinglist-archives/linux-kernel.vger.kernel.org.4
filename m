Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43947666E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240176AbjALJ2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239831AbjALJ1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:27:08 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C9842E12;
        Thu, 12 Jan 2023 01:18:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaoPBZfdgkqp/qQt9vf8mNKvMpVxbElf6PKGOvO9hTGzBOgbXTenMM2/Pw2KrfnA2L5rwT1cTlT8zsUg+9K2ZGt9rGFAfTx+VjVbG5feh/1E4WnzCjhbrZMBi3eEdVd6UuR+/v/muNO1ekmk4V4Eyq+lTZ9OYCdsubdexxgcTZIl48ckPeJAK21LqDCxd8lo2hxSOas+Ze1q8dp89HrYx0ZWumqhSkQ1FbPns15XP1femvKxF9KcOUZwZmorXQOGokGplcYwz1cm5ELYGyDnb4Q/ISCUq4EKYu56desvPbX5veRMuylS+UvnrUJX3OHVer4clJmELwN/VDtP1vNwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiXOF+FlP2glu7hreA/LnlGNixZSJlnPxYJ9upd0yM8=;
 b=Nxwh+L34La0Zefgwthpzu3HqRV6Iewvnq2HMqJcP03aRFtrCfPOvynKlMRImScut2O5oBo73O8aVhyvU4+vYrf7GiObL7vqQzs4TfyXIwaoF6JSoM52rsbiO/3hC89xSw6N2izxrmKErCWRR/RWt+qC09Zq4VuaDW713bGNyre1d7sKq938iNgZl5YUxpa020EBAys6KTCRmWLOzsaiahkx3ceOoXvEe6C+MqED6nj8dX7nX3gkfPYR5gddxuQEYx1eJMg7Pr2ad+o/SGaVajk1+HcPj5ovWdRRUpQi56+AyoEOmILguroMLynHs8+mww0c2i8NqEzFl+yxNbPVfyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiXOF+FlP2glu7hreA/LnlGNixZSJlnPxYJ9upd0yM8=;
 b=m3mPpMwS4JbpXfgSiilxmPVFZRSuzcOOdBcD/5ofkvLC1oor3LTYlnQF1/6cxFazVZa558Op9gJyudO1eL86k/xt4S82+mUeP3oNQrfY2y5G9xX6cktxqVpgGKWlI70R5o8VsxYitOXs2mHMTUwIiXILBuVPf0Omw8eW7sQpTR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8923.eurprd04.prod.outlook.com (2603:10a6:20b:40a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Thu, 12 Jan
 2023 09:18:39 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 09:18:39 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] media: add RealVideo format
Date:   Thu, 12 Jan 2023 17:18:17 +0800
Message-Id: <ef8212602467151a6e20ccce3e7ef7adcd7a7c91.1673514352.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1673514352.git.ming.qian@nxp.com>
References: <cover.1673514352.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM9PR04MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: 97875b8a-4c09-4e93-c51a-08daf47dfdd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3G4awc3QU8Nr02rpfGrbOchXgvkfOjfR5G1A7i6QLuRwX6xzsWlPBXZynBeVW8B6KKnsbRXBENakt+99yjfQJABt9ABiUZ8rVL5HoXLbfUHHCpgQR4px2tXb3pIQ6ZNpqGmbZmr46DkdDMEVhsg9S8UsvR6s3VpZjwPe66s1a7Z0s0bAy5bQLFsxFPs2EOPX5SRenAFnszS773U3QFYR8CYu4uUpUmGLgU8UVPLENm4ylV2v6FN8cCsnZ7e0VeNAlkG84Qqnq4KDV/NO3zeNAL5f7LcBiUIEODLB/JYEKz2xp7c3YHeU4JG1Xj+bpoxi8UpbpsoVAoa7RtRStTUjxQ0JRiuvIEODiEMUFQG9Iamyc1cND83oNsX9BgysKgBQa9loepYJyoZ9xUk6KeyOP5eHqokvFLzC9yAfF/1rus+mWX7+Gg6UNldELViZxi6N3/5eodrUWn3l33WwbpYao+qrb9/gfgEy9KHjdmELyrfPWrThP6Fh4kVdunU2ZUI10YVRybr/5m1xUOee/OS0GsaLrzsRkILqpbfCffWj2ffGKofycR1UUlOPiUGDFStfRXvK8A2mKH/4mu491qZxaFTkV8TeqRI9ecs7TwQdhbM3XmCigXv6G+HP1SyKFi7JkCkFd8rI2MGjnKpgWi5V/c2aSIwCKgvcXnHmoWrtTBrV41vFhcQMUXm7PANbRvfijStOtg1FtCEDnRTqkKxrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199015)(316002)(2616005)(26005)(41300700001)(5660300002)(8936002)(7416002)(66476007)(66946007)(8676002)(66556008)(4326008)(44832011)(2906002)(52116002)(6512007)(6506007)(86362001)(6666004)(186003)(36756003)(38100700002)(478600001)(38350700002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q3iETQ+JgwGAxKSom8sU1umbb2zKzelGrHtaOgsKcJCUKZhnrXjB//Sq1Mto?=
 =?us-ascii?Q?VrQqQmhFPYWHioh+gsKZgxf7z5urTWPgXQfbrGrQa+DEaXB02nXe8rCUk/Mr?=
 =?us-ascii?Q?82s0Iw7ONOxKTqhSj9rjLh5GLJ37gy8lNKMJu5tJJAbyB+XF69+WAo7sHzB2?=
 =?us-ascii?Q?Z+lp8ZbW3ELvvfvzgEEptboVX52CKGkARJVhbpRKTon7XQBaKEDsjGPd6MIe?=
 =?us-ascii?Q?9/zDwSheeiVkp6qe+H78M7/MsQ5F1HPU6gWWwlqaKoFaIZQY+fI4qVS8I396?=
 =?us-ascii?Q?0vRWmd/a3UFm0Tn6yiGoLwUMzSj4D2AmLM4dZiQJzY8BD/oJhxwJKVsu4puJ?=
 =?us-ascii?Q?vhNF7n7aN+tNxNk8TeZszTz2byjGB1NagKYI5MoxyPQ3bSBtDyJUx49X+umD?=
 =?us-ascii?Q?DMfRiRCBswe0v7KIoudmWswdmUC7p2fRWOB4lRJlL8I4OLUsBJReMMAQSdKT?=
 =?us-ascii?Q?UqTNsAL2sESHe2rgDeIcHyUfeAjvadm1UoNzWLJbUakO7VC8p5qpN1mkKbd9?=
 =?us-ascii?Q?qEiINF7KDl9jZL6O+MHMPkcJwyNXWv7/M6cLviocjeqwZ1tjX/pFMi3g1mp8?=
 =?us-ascii?Q?+wf2W+zYckyvrAYVrVhNK28NGN+hNGv04f1/v6AwYi23GYvdoZBAbHDXvBE0?=
 =?us-ascii?Q?6fX3uS9pjLAJ3cm0MrsDH29ct2k1Dd/2AdvWxEmG4GvQYFVaBKUtfwSD6fYE?=
 =?us-ascii?Q?omJVidvtZXnhLpRYUiGqbdixU3q+CVtDA5Kt58kISmemJlqK64/kP/KvuX3A?=
 =?us-ascii?Q?qyMJmt/iD43NaeyQZEJTVwm5w2eC15yaV5X+KMA4Sct1YbNdhf+zS8rhCMHs?=
 =?us-ascii?Q?AqLS/LJgdN79ozprQJKzY7zlCGUd9mufmBrmup40F4YSdm8CpHbT4ZWdIMPB?=
 =?us-ascii?Q?Sef+hy1BrdgPjxkwolT+y7hdTobWYkkMUuhLw0Fg4tFFwlrE67yc4MiJUgzR?=
 =?us-ascii?Q?R5pvdhhf7daOFsr9jglllXXDE8ERfyV+W+OGSjqyEF688y6gP8Et8bpkdkL7?=
 =?us-ascii?Q?CIbY/0lDqpdVcomOTpq/hwFgcgqBkFb0pHP6gkdbTElzslqUDEkJdxEpXtxR?=
 =?us-ascii?Q?WOE8w0VVMDhIzm2iXcR0cYgsSTGsbZ3POpH23J7l9rAdnMix2KDI8jERiCeo?=
 =?us-ascii?Q?SaC3nLjcAUgLrYui28r0CXxd8x8ACb1iW0lwWTOouuubOBUZ5/TuffmeRhPt?=
 =?us-ascii?Q?bHhwkVZiSNQeuIO2GRMHa3tDk2wcxbp0hbLWlpR4Ne/fS011pR5TUPChBlAg?=
 =?us-ascii?Q?G5r83sTbDjdz6dURaltz4iWmpCOUtB94/KY0pOhjFRg0e5smZKyaut2FzpRX?=
 =?us-ascii?Q?4xKZKEA5yE1p7aOPzaH+qG/OXnI0QiReUiDQEzy2m8a2xgfbCoh/Ildwi+LA?=
 =?us-ascii?Q?W5wTAX3Zl+3FsElAXb2qnJy6lYTOWaXEdCs0vtm6uDhU86XFoFMM2aZ+HGGj?=
 =?us-ascii?Q?v0nxVXNlXG5Sb65LlhL0jZbvWGArgHMuw6Dv1s8bdu6X2H7B5FFxt2f978ps?=
 =?us-ascii?Q?Z6F7VOm91lAqWkg+IHMJPdkxxyKzIuwVAXdl2V6GDnsMA9HDxSfu4HjVZAIa?=
 =?us-ascii?Q?nj6Q7nxVEv5+h38F4kZtj5cNk1cXW6UOuKT3slVZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97875b8a-4c09-4e93-c51a-08daf47dfdd6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 09:18:39.5802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTGtIfxgET2TU94+gbEQW6qLKI7s7wBE7cKao6Y7hBGsunh5HE4qMcVHaNhbVDfbvTXEpHqPSN9YHnrTRY0Nzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8923
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
RV10 and RV20 are the H.263-based codecs.
RV30 and RV40 are RealNetworks' proprietary H.264-based codecs.
RV60 is RealNetworks' proprietary HEVC-based codecs.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../userspace-api/media/v4l/pixfmt-compressed.rst     | 11 +++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c                  |  1 +
 include/uapi/linux/videodev2.h                        |  1 +
 3 files changed, 13 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
index a0230f357680..22035d92c788 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
@@ -237,6 +237,17 @@ Compressed Formats
         Metadata associated with the frame to decode is required to be passed
         through the ``V4L2_CID_STATELESS_FWHT_PARAMS`` control.
 	See the :ref:`associated Codec Control ID <codec-stateless-fwht>`.
+    * .. _V4L2-PIX-FMT-RV:
+
+      - ``V4L2_PIX_FMT_RV``
+      - 'RV00'
+      - RealVideo, or also spelled as Real Video, is a suite of proprietary
+        video compression formats developed by RealNetworks -
+        the specific format changes with the version.
+        RealVideo codecs are identified by four-character codes.
+        RV10 and RV20 are the H.263-based codecs.
+        RV30 and RV40 are RealNetworks' proprietary H.264-based codecs.
+        RV60 is RealNetworks' proprietary HEVC-based codecs.
 
 .. raw:: latex
 
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 9b5b04b8aa69..c375261d169f 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1473,6 +1473,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 		case V4L2_PIX_FMT_FWHT:		descr = "FWHT"; break; /* used in vicodec */
 		case V4L2_PIX_FMT_FWHT_STATELESS:	descr = "FWHT Stateless"; break; /* used in vicodec */
 		case V4L2_PIX_FMT_SPK:		descr = "Sorenson Spark"; break;
+		case V4L2_PIX_FMT_RV:		descr = "RealVideo"; break;
 		case V4L2_PIX_FMT_CPIA1:	descr = "GSPCA CPiA YUV"; break;
 		case V4L2_PIX_FMT_WNVA:		descr = "WNVA"; break;
 		case V4L2_PIX_FMT_SN9C10X:	descr = "GSPCA SN9C10X"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 262ef10cfa02..0a7ddb023d7c 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -740,6 +740,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
 #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC parsed slices */
 #define V4L2_PIX_FMT_SPK      v4l2_fourcc('S', 'P', 'K', '0') /* Sorenson Spark */
+#define V4L2_PIX_FMT_RV       v4l2_fourcc('R', 'V', '0', '0') /* RealVideo */
 
 /*  Vendor-specific formats   */
 #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 YUV */
-- 
2.38.1

