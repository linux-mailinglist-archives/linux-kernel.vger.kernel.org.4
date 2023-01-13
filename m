Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26949668AC1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 05:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbjAMERm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 23:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjAMEQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 23:16:41 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236BA6952C;
        Thu, 12 Jan 2023 20:13:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+bu4Fi10AlbhlwUIgOFWo7iEzXFY8ZBLjSFxZV601aRVc7VO2K1SQlV6cXp/r7on22Ws2JRJbSFkIflQtRQxXt2z0lccbX/Gs/i6tKdhcF8ZiNFeYY9Hrh0D1322E2r+nQ/k3sDEmDOe1wFc4QPVUpAToN/7rfkC01p5snYfN6/VA4zM4OSAVrx/bXa+uT/i6oXDSHlqarkN6abAUGj28s6FiYOhwjaD3kCxmEAheJ4aNCe+rhY/PcSgGGBq8F8Q2NFGU2MYbsHkdIevuhwK2Ncwnhj6x/FaasdSk4+zwQ84QnvQr/TTmN+iWjG0nKDe00DH6VWE8MiOJdF8nx1wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cStn8w9CF1LPdHQ48xYYM6XzYl0qHNvDi1MjnrnI+U=;
 b=k6Il67Wx8uCrSKG9RQ5QdRj/TDIUrTVls3OwX2EoX4xmHd4Jtzn00rA+Bv8+UYYl04YW1opvwAJ5xdmL8XndM8J7wFengzvDvCAp86/Kmnu7UtqUxvaFWZy1BzYZOHKUVb+Z+5V/a6FwRVrQ+/eQ3N2kDTFfG+9/zSABo2DFKsytzskY3PCKLSz40k2q0BFhNicMDoxysDDzf3QhZcWBGG2ZUNNOduPozOYLLFgcAkv+bDOu2cnzKaOOoVaqQkHqHm4W3+c+l/Y1ZvMpcYvVZW8ph74Ig6hJXYnc0u0BAeg2fizlMS8EZSjwpFmx+1azxyzHdLxdQq9piQQSI9xkXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cStn8w9CF1LPdHQ48xYYM6XzYl0qHNvDi1MjnrnI+U=;
 b=nbXen0SNEI43/5AIV9WCqarNPQywlF9IbgthfA20PtXNFQB4RJ1SfcqhLT+LgSomduTs2rfwcBD3Are7X+jgW25ueZxR8SAnfWMjvSmTHsV2ex0lBIYQ7z7GSu2rLI6cItXGT5LbcVWQliCKS9BCHT5QyLu25Du+V+n3TOO/4xs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM8PR04MB7441.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Fri, 13 Jan
 2023 04:13:27 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6002.013; Fri, 13 Jan 2023
 04:13:27 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/2] media: add RealVideo format RV30 and RV40
Date:   Fri, 13 Jan 2023 12:13:06 +0800
Message-Id: <8cbe08de42af1ecf0df39970d57742445fd0d488.1673582851.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1673582851.git.ming.qian@nxp.com>
References: <cover.1673582851.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0230.apcprd06.prod.outlook.com
 (2603:1096:4:ac::14) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM8PR04MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: a0823b29-c3be-4f28-c09e-08daf51c855a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D/uACnbROTbUq5RPoppU5F7AmMs7g1IM5acj0nMupfhaQKleWMGggnN2AR2goF2ZcjsWSm9XG2v9kmIaPuh5QNCylt85OO/yttY8fKCatadtUsrEId5qcteY2GLy/8/MWyiT9KM1vLPQYg3c9w/9i5at8SIVoLB3CBGSuRv7qIIrE36I5brCN0uJbwmwhZpw2wCJfHATS1rjJ1qUDNr1V5gJuvNZrBNo8EWKVtFEFolHftjnT3ZT7tkLp8sPIEvp7drKPptD89ElO1arP8gwh6ZiCR+ShlPRjExXX0fWnpng0AeV/F1uhDNvg/MCuTvj/eGdCX9kvjLr+FR1yTZ2hzov8xKCV1MEQB4kJha7xJBwHkaHwZQYC15qK/UQDFjoUL1M04fOH/eO+N7Rwp9g5SKq/FjSxzaqJWbF7XDHm78cw4dc8nmCUQuUhuDxma+LE0eDA5eF/t+0Om40SIvTDZq1RafD0Haw7DGa9zNX0CG+XPjemPUpes3496HYNRVa/9RX6/0VJ7XHGYW23qlC/IJAPM/1mNBCCWUtTlYENviE21/oYBORhUu6+v/58KWVsHkQ+dkkRszdrWt+2fME8QUwDF1yN0qr0Sy3+zzHCOPTUnJPDnS/MrJj6oxOs3f6ZivSTCORv+ViiiNsvOOBkqThRRc4cnGkVYzbkKR+2DM7kxGrv1U5x/AVA51VbNqiM0qKuNQo+pbnU3DyXw602Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199015)(26005)(6486002)(478600001)(52116002)(6512007)(186003)(316002)(2616005)(8676002)(66556008)(66946007)(66476007)(6506007)(4326008)(6666004)(41300700001)(2906002)(44832011)(8936002)(5660300002)(7416002)(38350700002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mxIzGrzRphB46fE9vbEMk+V9ITmbXP3dOJ9vqGRvwZvsPVUmCzVsuG+72Vax?=
 =?us-ascii?Q?2yJlw/F65nIGw8e8Ndg5FAcS+ltYQO313+F8gVmbteeafeLloZKRyfmFqJOA?=
 =?us-ascii?Q?yBO+ni6W4x5pvLMyYJN4blFSzYifEmNF1mRH/MHL1IaDlCaiHo36JMhb1jZW?=
 =?us-ascii?Q?QqHASILirgZhFGmQKoaZfZw0nEuaCeYQnMfTUh5nXx+nnzYq8/mcVoEOgXtp?=
 =?us-ascii?Q?8lPqRabfSOkZ0xv0GVOlqF8n9eji7uELDP1olIiRWU5MT7ELmJbdVCZdf2Ew?=
 =?us-ascii?Q?mqiw5jVoSVkhi1Zg/nvU732tuc+L+H4DASmWZAF2Rvy+vR1SHl4xg4hM0JVD?=
 =?us-ascii?Q?CStbY6JRHucWiXFFDJMAdWZqsDP0oQqfI+njl9Djby3dzZQjxmvWwfJyPV2L?=
 =?us-ascii?Q?ukgQTL2BZjxu9BDCeMbWyfMe+c6fKyUDTca2rfFL6YFV4sgb42HvA/lPnxFm?=
 =?us-ascii?Q?9CJlDYS4dwffTtItOkd7DTXbqjwAPE/xVHx1XMyObFWidlYZR8hLkwO7dONU?=
 =?us-ascii?Q?gTg8xcugYzJaox+ZqB7KnWL/gm9Fj9nL6V8NBZnzb261QKK11tmbO81t0w0T?=
 =?us-ascii?Q?u25232XFqzPP8EGTkE8OB6Ee7ft8VWgXOc+ze1BKBHY27BOkEu75SruJS0Ah?=
 =?us-ascii?Q?LYEeCPqVdsyg0g0mpn/TPUnN3vyop/0TohQR3YCUk4GHxA8Y2K/KZqYwhZ/0?=
 =?us-ascii?Q?2bOR5p7bcFTtLOlY8PB3aT3lDxhPTKzSLthy4I28f2KTvKzlT7Vz0jgHbft/?=
 =?us-ascii?Q?/NBvpXHXyI8iyVZYF/EiaXoYXxgWV1LpUkZ04V8DOOeNOr6SVmq9juIcPVo8?=
 =?us-ascii?Q?dvKXOJRd/EneNGdnm4PKtt1CjrZimuMtMvMG14VlQKBQ29Mt5dZcAxIBfVd5?=
 =?us-ascii?Q?sE72TugM20DN7hWTdSQjEQt1Rzqvw+UvBSlvKwQcX0j8AB8TtLtKdZWWEnky?=
 =?us-ascii?Q?7ggKf/4NPmp4xZ5M2nIB0tG81F9etDyxasmQKDxKrnSD+ygX36hJZoHDsqOs?=
 =?us-ascii?Q?g7ZTsg6fADo7HelP8Wti7ENJStbzq4CPX9eUHME2nz7+VOL53MUviKs3MYt4?=
 =?us-ascii?Q?3sOYX+lsuSC/ShCkbLx6o59ZVAQoiEzVoj7Zpzu1CdSCIOAujwQTx09WFprC?=
 =?us-ascii?Q?ub4d19obo2GjtxEJVReeNFuZ/xoJx8KGe1vgOQ0C5ytHEtvEXyPcZeKwE8KM?=
 =?us-ascii?Q?wocmNbQqv0A+i8iEyxf0IVEmOEULuKsqT5sWEwhUxE81UorF+oQwC2u+CoZl?=
 =?us-ascii?Q?Zk8CR4F2R0QV9kZlWhBjiiI8xSLBSG8MHmGtfNqQW2MVUOBT3DDcRg3QzUJI?=
 =?us-ascii?Q?rndiXHVRcvu355XfSy7om/8VeK/8acOfdiaEXsIS7m83dRWveI9rkk7X7qEG?=
 =?us-ascii?Q?Gjpyms4QTFJCjO1Wl+RLTRK4gJfJwcb1ocQcZ8OndofkgiyxaUwyA9rDwcTx?=
 =?us-ascii?Q?wRe+/2mSlMhLTLjmdt8cxjftVKZ6jUrTfHT8hTbhP2OUL5y0nYM/8+sMdkKB?=
 =?us-ascii?Q?q6r9R9ZNT9fY1y/rgTeLEOsF/3x60u2ODfSPuOSslOoy4+r9l8VOBole4IiC?=
 =?us-ascii?Q?mHgZe3SgYrj12Z6ZtsnLO54EXj1KRMo5vmGYl3Gf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0823b29-c3be-4f28-c09e-08daf51c855a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 04:13:27.3740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z65g5OtYK8A5U7W3pyWRURs7CnxMWN8PFnAq8eIRYoKr6r+azU34fVAz8npgvNEVDWEHy2+9KAwhqQkJdQBZFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7441
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

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/v4l/pixfmt-compressed.rst           | 21 +++++++++++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c          |  2 ++
 include/uapi/linux/videodev2.h                |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
index a0230f357680..50ac095c1f16 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
@@ -237,6 +237,27 @@ Compressed Formats
         Metadata associated with the frame to decode is required to be passed
         through the ``V4L2_CID_STATELESS_FWHT_PARAMS`` control.
 	See the :ref:`associated Codec Control ID <codec-stateless-fwht>`.
+    * .. _V4L2-PIX-FMT-RV30:
+
+      - ``V4L2_PIX_FMT_RV30``
+      - 'RV30'
+      - RealVideo, or also spelled as Real Video, is a suite of proprietary
+        video compression formats developed by RealNetworks -
+        the specific format changes with the version.
+        RealVideo codecs are identified by four-character codes.
+        RV30 corresponds to RealVideo 8, suspected to based largely on an early draft of H.264
+    * .. _V4L2-PIX-FMT-RV40:
+
+      - ``V4L2_PIX_FMT_RV40``
+      - 'RV40'
+      - RV40 represents RealVideo 9 and RealVideo 10.
+        RealVideo 9, suspected to be based on H.264,
+        RealVideo 10, aka RV9 EHQ, This refers to
+        an improved encoder for the RV9 format
+        that is fully backwards compatible with RV9 players -
+        the format and decoder did not change,
+        only the encoder did.
+        As a result, it uses the same FourCC.
 
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

