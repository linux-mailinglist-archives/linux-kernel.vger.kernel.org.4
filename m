Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F57D6B8F54
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCNKKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCNKKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:10:31 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D42690B60;
        Tue, 14 Mar 2023 03:10:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6l++yAe2opTeePfaGjGslyRoyKJ/6gXViL1C9uXfCCkTgm1Hq7lN3ktCBUnX2F9KtNBP6FhauF+INQQgm2WXcCKdU3e3Y67Sp5NjA3fGd8jsbt9tG+W68Qha62vdFM8Gp4vml+C18WjtK51pRZ7+uGXYpdKuopXcUtvDshovT4UdwKfbP7uSl4sAIqWhHEBuR6/en2X9jL67wMgSM4APc/pMdQGrBfhiXyJIMgTudTvrwiBtlthq2gGiUu4sPpfySc2aWfn99ttIyGRUiiTgaaKE10ikXa/tQkV/XobGMB+ad9y/pp7LyLxBGPVNkz9URgtQJwpbmeFXUOaR6atWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1qeezMggQrS6VABFD/LN4woKCcPMlArIcccd/ztvnU=;
 b=VII5upQx7V2n89jfBX7t/FoNhqZ5F+4FSKZP63koV91MVnyzD8S7eoNCen11aYoEFeMkcJ6naoKOXiOXwb3TqQCn/eCpPgT8O5+ZeQTRRq4dJBDiMfhO0nZ4Rmz9VzCTI/JLyJ88bumnr4hCaIlD+fF4aghx+BlWDaXTcnxepkASFdUiSRKdBDNfgwDDlC2sFscv2z5++cyeOMnZR8Phz/K0iv4GxzQLQpLoE5K34rd/VvQWrf3gaPxWsBQoCDTnf1Ho818nkmlg3EjTZ733sV0Som7Fpp71Xlw8Uobxnh4MMYJqOIJPTOQKUs3QOnCEvtsT/lPYTLgb0uWGbmtvpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1qeezMggQrS6VABFD/LN4woKCcPMlArIcccd/ztvnU=;
 b=KMJaT9kbw+pHvcSnOROz+A6WRSZvT1UXqwSGOqzvOUDwObOJN/D0DpwQOTlFmsHJ8FH7Qt8nW+h3vlO4jXNaRhv59E+z2LBhicA9jgLDmIre6AIrwkM70B7W9ZjRPMg8C3FK7C7p4eTXtzPqtZG10JoDDFGYwoKOdlCv+5SkRhA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DU0PR04MB9346.eurprd04.prod.outlook.com (2603:10a6:10:356::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 10:10:02 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 10:10:02 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 01/10] media: Add P012 and P012M video format
Date:   Tue, 14 Mar 2023 18:08:44 +0800
Message-Id: <42a8e54f01ae62a36ca51eeb6652cee91baf20f3.1678788305.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 928062c0-6185-4b6d-890f-08db2474467d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vpEHNTPU4HQF0mzIyFdWm5kBAChqgCMsJtbyDq1+0MEORBFnFETgIClvd1ai3lYbdWzDYFpx3K1zaCfdXk4sZNANiMXIDbXVfrQEZyQCDa1wOts40KoSrbYmQTZViNAO8Ee89FPRBpbU+EqCWvo2YSm1gD11WbAXPL08uhXXNFMNP/fpxn3rhe+l0OubkBIYxWwhlSn6baaVcQlCSYLbHX5GGI29dpkEHmtExJ7cfFGbjDsRHmhBoifCZ2gWE94sOCYJv3yr6H/GTfKmJXpKZkwBieWvegqJ6So2tlAq5BurBx6bLl+UOGiS+hq5otzuNp6CioSQo+btNoz1YmmnsQ9GLAINEIC8RIwmy1E7uqCTJEjt/LwepJARIvSzJIADtOTqCTtZIKtqGd6+IFTxHIPuyy93PKMzhRxnTyO50/BWQgjaaWI4GJ5q8tPoag43RwBD2KrEfZJvhSeuEglbbZVdeC/pYXTxYBTOaOj8WMLDlbFI7LunkfRxmkaImrC4D6ravOUkzFyHAXQrsV2TKE5AJfTntvN+aqlR7NDO6wLK8+rkBto8ycaV7ppK19rI6Ga9infDb4DWmpwNl5d4KuPMQMjtBqH+DP0TpgO+n+BYDgHFIvTRteC4xmWq3dFxNsFJcMem/49BZ5FYuAnBltBqZGraJsM5dGoAQp4MsKEcoBpXi6pmRRKgeAcmPIlsTxvH0JkpdCI3RwtY8HO4hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199018)(2906002)(41300700001)(83380400001)(36756003)(5660300002)(7416002)(44832011)(66946007)(8676002)(66556008)(38350700002)(4326008)(66476007)(86362001)(38100700002)(316002)(8936002)(186003)(2616005)(26005)(6512007)(52116002)(478600001)(6506007)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xjxd7BB7ov8e5M70GN2fKOwYtuG1YIG3JxR4Pp3xKPriuWpEIr2xVuhXDdPF?=
 =?us-ascii?Q?my5HqMTfWkXQIebG8W7gfwl5jeGk2msqXk5PYLav6TTEnya/1c0geME1txel?=
 =?us-ascii?Q?bP/mN5VgoNvS0gAJCyI/EQ1Vp+DXXpn3gA81dgVPkptqyVMIp2cBXGCaByoL?=
 =?us-ascii?Q?J0XAb19tmt5ZgmOrGzqexiESNizGgGDZXChvXW853dEjlgv6Um0OmGcsPHyg?=
 =?us-ascii?Q?jg+VEKVCjQySdmOOvx0+OnTDuClf0yx7PPeox/LYQuZakBS05uvDQrIJ3i5J?=
 =?us-ascii?Q?jSuxpj1wdcu3+T2wEMezJDKu/4KsQaUhKKKrN2cBllXErzKYqfu6RUt7NexN?=
 =?us-ascii?Q?eQV8GRgNadnDHCJ+4r5odtwKN3dKRULVZzUu2N4hYeKBQGABpE3Nihaa2IDS?=
 =?us-ascii?Q?P0y6OfQgp+TgSZtd/L3m9RA3ohXW+o0zbN+XEA4SU54hiLInURbM3fQyNUhT?=
 =?us-ascii?Q?XedsuCOIqO4iQ+pxzAMFqYqN3A8L8wHZT4xdx5uMrJCpblueuWyUqY/d17LH?=
 =?us-ascii?Q?A7zA0L6SROjJoJbjJSGZvmsjE0mLDugrWeIpSR/HQLEFmJltClO9+SufrwLZ?=
 =?us-ascii?Q?a9GKszV6R8Wg/VM3JKeIdiNwXLnoAV0wP2/CYNvRWkgFvy6QMVssnr0zLdEw?=
 =?us-ascii?Q?ay0amZ+3f7v9fUMmesvEQzbSKUHcbEZR3hregucFM24tbpeUh4VBljNNgTLU?=
 =?us-ascii?Q?4wmScCDLoudw/ylJVC5z7jpF9/+3WyZnDsWiAkzwMbs8j2s0dgQilGTtKPHD?=
 =?us-ascii?Q?kqaGBGFN70bg57LX346yCAwJZymMIXPGN1QSxtXsH/6Fe0PwZhetW8iPn31G?=
 =?us-ascii?Q?FtRxVLLjotMk9htKDPL9eLf2EzDqbywYwI9SVWVvjjRMfL/+vPbcmTYPSJrQ?=
 =?us-ascii?Q?lxOw0+wepjLWVOLVJ5mbhBOUnsKT2S2IrPjYqcoZ/TCUb9Oc62yD2RmaUV8V?=
 =?us-ascii?Q?f2wrtUNxYOeLuMsA2/84s4SG9ThpYZP+rb5AQA6565I3mG7JtHMKsfPF3q63?=
 =?us-ascii?Q?DgnoqCclPqeJvTQPH4W2NoNptNBtOF7BS0Y4BZHfrrvAYfQmCWMf5D7yzrAO?=
 =?us-ascii?Q?oIRHsY+C54JhmKQzVD9q8cNyIvCKy5/S7wsj0isc6jSYhEtNunb/BrVDzzFs?=
 =?us-ascii?Q?arTvWjfUex+SsVBLW8Xl50k4NIRkYFANn4K9v4vF3Z7W+jlk3qKBAgMGqEcb?=
 =?us-ascii?Q?V/lFCG8b3YxXP2NNP9qjS3KnkfpRtyg4pAur8lhZvXpB00lpi5LP5Ji046Zh?=
 =?us-ascii?Q?7CjxMLQXr7SQ41ZqzAYndlRjMbeBKCjAq3/74pXnNDGqmkXgeoMusnPfUtAm?=
 =?us-ascii?Q?ygbQXloTH/cF3PntMdJcfCA/HQAkgHjTh8u/lPe3fY5yggjn6jkpc7MOxt08?=
 =?us-ascii?Q?lNJKNSDqtwy/hCZqtDUWrQRDTSJ/vjLZNMQEagr9zXKsjeZhdFC+bzcdr/AL?=
 =?us-ascii?Q?5+4DXxSvtoTVDs39hL30HJ893Nqx5RbZnIn1t88xEyQqLHbyxG5RsZOfZ4IW?=
 =?us-ascii?Q?UHeIT/sJUl/FkrDItWe4ruGcuBkgH6EXCPgds2hJd1MoWWoAhzU2tyxAorix?=
 =?us-ascii?Q?ksJhmpJLyOHnDnPHFSs2Y2nSHpJhbWG/m0iZDUQS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 928062c0-6185-4b6d-890f-08db2474467d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 10:10:02.2683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Skuxw37XbfJ2jngkbzqho5Wg4+POjSaaHsIB2LNodctw4EeTVpQ9MOUQui1jdlYY85r6wc1FYkDlKCY+NMsAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9346
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
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
index 87f163a89c80..6489b67babfa 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1352,6 +1352,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_NV24:		descr = "Y/UV 4:4:4"; break;
 	case V4L2_PIX_FMT_NV42:		descr = "Y/VU 4:4:4"; break;
 	case V4L2_PIX_FMT_P010:		descr = "10-bit Y/UV 4:2:0"; break;
+	case V4L2_PIX_FMT_P012:		descr = "12-bit Y/UV 4:2:0"; break;
 	case V4L2_PIX_FMT_NV12_4L4:	descr = "Y/UV 4:2:0 (4x4 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_16L16:	descr = "Y/UV 4:2:0 (16x16 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_32L32:   descr = "Y/UV 4:2:0 (32x32 Linear)"; break;
@@ -1362,6 +1363,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_NV61M:	descr = "Y/VU 4:2:2 (N-C)"; break;
 	case V4L2_PIX_FMT_NV12MT:	descr = "Y/UV 4:2:0 (64x32 MB, N-C)"; break;
 	case V4L2_PIX_FMT_NV12MT_16X16:	descr = "Y/UV 4:2:0 (16x16 MB, N-C)"; break;
+	case V4L2_PIX_FMT_P012M:	descr = "12-bit Y/UV 4:2:0 (N-C)"; break;
 	case V4L2_PIX_FMT_YUV420M:	descr = "Planar YUV 4:2:0 (N-C)"; break;
 	case V4L2_PIX_FMT_YVU420M:	descr = "Planar YVU 4:2:0 (N-C)"; break;
 	case V4L2_PIX_FMT_YUV422M:	descr = "Planar YUV 4:2:2 (N-C)"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 17a9b975177a..f83a9d1210fb 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -637,12 +637,14 @@ struct v4l2_pix_format {
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

