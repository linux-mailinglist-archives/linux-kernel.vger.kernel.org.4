Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14816651C74
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 09:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbiLTIkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 03:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLTIjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 03:39:53 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A67115F04;
        Tue, 20 Dec 2022 00:39:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsyFXuOej+EwMgHhb6fsBhmC/ZY/enH/E4VJCj5yz++WGjicir64Qu5Dh9oTXFdCaVSsdOgGGTEvHBWifpLNzesyQ4Vz2GI3pYGSZMZiVWLOUTX2pmijDJ+FaJ8UOG6/YYbOtOJ2naXjnuFA5fCQNZ35Arlo21dzAiYeT8WmkTASNX1u8RabCoPVPmgCVYQ7E0j186TwGPKUG0g9c+itdgI0gdvb+lGuvuYs2r82FfrvhAt5KnEwRmSKhZbnSINrHZEW+RhSxp0vNxw875I6BL7f5EyQzXiEHg0F+0bAYIZf0KOd52GuF7NX6RVt5f2Lp2NRUWXOaM3PtKPTs77l1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whHUPORmun3BFMevsg7TwKmjp6JejX9t/s/Y9QImNg0=;
 b=ixMH2dRkQdPiPhNO76bZ36dIjLdfRhSD0SczcOtU0+dv9u9SewJ6NRHC/7JMsidIRbhs6w0vE7fufBppOptw84NOewN/f4sxVKgV56S2PmDr65jQwUeCbYPlQoWbP9Anaart7UL2zz3K9bXOOgvaoKVC/Aa5ZQEHarjYJ7AQxjqSjEr3FrY0+d8jj2IpQfMuDv8ygHIyyOzT8grZS+29/NuPheqB2125jQXJE6Z/isanf4LSXKSlbA0o3XZJ5bpq8CjCm+W3epQ/wrxMkvxOWBTDxsxhY4qEwoczSslG117VG5AhGh6lCcQVDsFGTCnZ0pcjHUcHipZ/Mr69Wijgdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whHUPORmun3BFMevsg7TwKmjp6JejX9t/s/Y9QImNg0=;
 b=F7zFSDo2Rbk18oYZkMuM79CXHg+GrKQB3jTIewpT0KoTsBsAaF0e7NGXtkXImKfiosW5fQ7NY2Yn1+iZifuSDbkTZ7j+uj1nD0b0DCwgKD0mECrUlfEgZPBQMS+rFQ4y7/wUKek1NEzGxvr8DqG0k8YjcHR91t5cjx95pnv/+OI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 08:39:49 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 08:39:49 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, ming.zhou@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] media: add RealMedia format
Date:   Tue, 20 Dec 2022 16:39:19 +0800
Message-Id: <969b6905c945a1cf0986a2188290ddf3c52c5511.1671525379.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1671525379.git.ming.qian@nxp.com>
References: <cover.1671525379.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0098.apcprd03.prod.outlook.com
 (2603:1096:4:7c::26) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|PAXPR04MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: 441ab82f-0718-449f-e270-08dae265c170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ekTP+uGs2Ual3FH4orfCAGmr3YTRustcV22Xt8ifG7jSTL9SeswZwgt/boO7/ZH26bVaUsFhxzJ+jXtIlrOYrhsLrOm9HU9fjrp5H9lZHa/JASkmtQTfydbUj6jSaPr7gY22yvPMvd1S0ryrRLTGL44FibHUTMrWDE+7dWWrS2RWGzx2ZDR3ZVbp3q0kK1hzcsdj7XKAMQeQS6dOZMv3Qsczlk1qr1giQRGYXl7q0RqTMavUnjtXKkRwMDKz9PW+uoRkoesjYvB9vmOTBRoK4cxSoRdY/nCyV6k/pvpxyoEnIjMHHdXQHa13yxE8lzgn7N9uJdWV3iT37BnapYJqnWDm4E8huDB5nxipPuoZ48E/m7G6i4RaLCoEu2Xv9T0wplARaGXiwjceCvxkrv8jJl0+uCEQfBV0IZ2c1NR7DHwObMDa4P+l9Ix8cPIje9PAUGdTBlhmbmFVc7OZvCmwDgFmdjQJdOjJdOGndbzVqhybbsw1dS6gfhVUi2sCrxMMA+oYc2DxWPvxseSdGgwsS3iIBKVH04SzoMt4SFnW2n4ivvl+JF9uvtAVyXcZNtgBi7QWmITJT7cuYaVXTMbGvMvntpuqG5nAFzwyPsxHU796vF23hEAAKlFd6MxOISb9uRoOcCubk371kAnVGfD0qwWoHmV17OLC/zcBx1c5A86ECDUvI0e1vJ/MttVnazbjM1YdSAtKYfB08BBnmfJxFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199015)(5660300002)(7416002)(86362001)(6512007)(52116002)(186003)(26005)(316002)(6486002)(44832011)(36756003)(6506007)(478600001)(66476007)(38100700002)(66946007)(66574015)(2616005)(38350700002)(66556008)(2906002)(8936002)(4326008)(6666004)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l/PznE0gxOMrTDNb8EIvNJUs8mJMk2VPvHX+t7FPGphzA7RfnOlje0arsIdM?=
 =?us-ascii?Q?V2yFIcsgDam5Zij4CCGH4IcxzpkM9JNEvaeuerU1zK7un7ta+ysEr20z3FBy?=
 =?us-ascii?Q?jKFAnhq4y65hFffrvtN4ypKA5KVmySzGCgwWJWhgiZJB77xGvoCbc8V+WneF?=
 =?us-ascii?Q?ciSqkLfi2TxGCxyOM0thTj26oVx1L3iERNg3aOfc4nYEBQoHeFEr7UeN64rk?=
 =?us-ascii?Q?t/KobK52TFsl8vCEItsUgoN/tsZ7mXczhnsNatbRF5fcv1otTj3bWSHPtpUW?=
 =?us-ascii?Q?1zvlu0DrIaXBnt2j3P1q/mh89IZX9biRvVO8vMb/0FuPIJRgEKcA6OqrzFO2?=
 =?us-ascii?Q?nzjvNF+PMj7vKYe1jQAHNqfTmrOuxnDnHAU20K12uHwBD8VCVUgj8+w2CQ1r?=
 =?us-ascii?Q?LFG7wXuO+epOoQ0KMQvTSqJ3nB9JKe8SbhKxuGqBsZO9MkxnJGYUr9XrhhXI?=
 =?us-ascii?Q?TpZgS9u6zNFou3a5pyvOCifw80yRN3J7WZXeWkcj9UJh3ak562lqR2YamQA4?=
 =?us-ascii?Q?Jd3ghAHt39TYmBZQAitNVH99mZq8K6kqZtuZj7PVGC+QMmj3r+zxecvUVPI2?=
 =?us-ascii?Q?bRLtdD6U3bOWqMZ5nWsK6P+Q+FVNJk20FLk4SKMGJKeiDmKsatddZq0EamkM?=
 =?us-ascii?Q?OafSrqTqs7usyL8hD6PZggRL5cSLs04D2+zlhBLfxA+GNL9jWyY3yOZSzsac?=
 =?us-ascii?Q?DoZMklLOMl/lIQGb2hya8akJ+WpoFgX4SF6RUFqiDZe85CkH+3X1fAAiLxBY?=
 =?us-ascii?Q?laxzSHwOC0WMbewQP5BnCUUXXglPYRuUGN6SXzO6dniFd0f3eloaAKaWXBPZ?=
 =?us-ascii?Q?hS79FYE9AjjFe10IWABtKZYfpf9iDJpvWe9yAm4JhGVUIO7zUH5+TXopEHhO?=
 =?us-ascii?Q?fHqQC7+ImAWnPv4FMfcUBGdzx/Voy/3w7/KRYwlf1EN4KDWyPvHQ23R4VH5T?=
 =?us-ascii?Q?IjHxXeqbyrillqbAv7JGxya7lrzAluQuBD8ZQhLGg6jCTOpsxO0pn5e59aUC?=
 =?us-ascii?Q?XbTiiOnPbOHmHQqnvKajQsSi082uXpYODgdMHqB+HzNvppqzMlT4vNkUahIe?=
 =?us-ascii?Q?pBOsCEJIJumuCwq+FrE1dF25VbY1eSaqq54HSuTvmhnyiWPitoD7LWw/ecES?=
 =?us-ascii?Q?UnQT2npRKbarBwXV0TemJa5xYZE5t1cjYsKBTDFlOznfQ2jG+mzkrADbDASI?=
 =?us-ascii?Q?8LXyLZHw155vIvPU0GTC27wAnJEGkmpoI/YZ+COVgeu7BOqlBryIiCoYLBWT?=
 =?us-ascii?Q?WLVK3V1c7ZkZVa4jk5ajVvAn8vhS3Ijns++El0VXfnL2Dexdemn+B93pcRLD?=
 =?us-ascii?Q?5gHNir7cx02/J81GE8gep/Yf8Q5DlcsV2FpZZj41tCMJ4M3GDvLw5Br6puJL?=
 =?us-ascii?Q?YfXLYaRLtYHUVIZa2jJeMK3B1X1D+UL5HlodUDeILryHfQu773OsIhJ5l4uK?=
 =?us-ascii?Q?RXAjAMEeQr1O3TDfzdp+DlsydLY+zzhIlpKpW9GKHwhVGnl+qdFLiMKiWnTa?=
 =?us-ascii?Q?+FY9QBNDr0G9Sllc0TlgL9PoRel48g4zUx5AsEiKxxQNbtXstd2O3Sw8HJ+8?=
 =?us-ascii?Q?AglIjVk57KnzNK3z4Xy0JwXZg20dIS5BdxtHRnfX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 441ab82f-0718-449f-e270-08dae265c170
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 08:39:49.3196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a19TAyWtwCF0ZVtxbFmiqJ4mxH0YVhenE8+c+LcQBV7ooUDZmzaB88xHOXKAh3HCeMU0ZX3n7AEtoaUfMGoVdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9255
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RealMedia is a proprietary multimedia container format
created by RealNetworks with the filename extension .rm.
RealMedia is generally used in conjunction with RealVideo and RealAudio,
while also being used for streaming content over the Internet.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../userspace-api/media/v4l/pixfmt-compressed.rst     | 11 +++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c                  |  1 +
 include/uapi/linux/videodev2.h                        |  1 +
 3 files changed, 13 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
index 8794b92fde36..31ba2c00091e 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
@@ -237,6 +237,17 @@ Compressed Formats
         Metadata associated with the frame to decode is required to be passed
         through the ``V4L2_CID_STATELESS_FWHT_PARAMS`` control.
 	See the :ref:`associated Codec Control ID <codec-stateless-fwht>`.
+    * .. _V4L2-PIX-FMT-RV:
+
+      - ``V4L2_PIX_FMT_RV``
+      - 'RealMedia'
+      - RealMedia is a proprietary multimedia container format
+        created by RealNetworks with the filename extension .rm.
+        RealMedia is generally used in conjunction with RealVideo and RealAudio,
+        while also being used for streaming content over the Internet.
+        Typically these streams are in CBR (constant bitrate),
+        but a container for VBR (variable bitrate) streams
+        named RMVB (RealMedia variable bitrate) has been developed.
 
 .. raw:: latex
 
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 9b5b04b8aa69..a4d12eea7fc5 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1473,6 +1473,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 		case V4L2_PIX_FMT_FWHT:		descr = "FWHT"; break; /* used in vicodec */
 		case V4L2_PIX_FMT_FWHT_STATELESS:	descr = "FWHT Stateless"; break; /* used in vicodec */
 		case V4L2_PIX_FMT_SPK:		descr = "Sorenson Spark"; break;
+		case V4L2_PIX_FMT_RV:		descr = "RealMedia"; break;
 		case V4L2_PIX_FMT_CPIA1:	descr = "GSPCA CPiA YUV"; break;
 		case V4L2_PIX_FMT_WNVA:		descr = "WNVA"; break;
 		case V4L2_PIX_FMT_SN9C10X:	descr = "GSPCA SN9C10X"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 262ef10cfa02..a7a7969ae4f8 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -740,6 +740,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
 #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC parsed slices */
 #define V4L2_PIX_FMT_SPK      v4l2_fourcc('S', 'P', 'K', '0') /* Sorenson Spark */
+#define V4L2_PIX_FMT_RV       v4l2_fourcc('R', 'V', '0', '0') /* RealMedia */
 
 /*  Vendor-specific formats   */
 #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 YUV */
-- 
2.38.1

