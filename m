Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC396B8F69
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjCNKLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjCNKLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:11:25 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFE097B44;
        Tue, 14 Mar 2023 03:10:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuvkWnompa8Ay8RbbGW+aUMHeArGyTn4XwNn67/lSlPFIRtaMQ1szrQhXFAR2JQqQwNzX1KzQ1qgH0977MY3Vm5UC9Z9K1JkskEke/agSAG6iMI243PQywq3PMLXl84KxONHsTTzEH0VIHA2Dpuv+k/GCtKi0mJHNfCiVihwxEmMyG05LChkMiEwoAjDFEMcfw0OJ7+K+goOHQwNekY1Q0wptpMlELLfvrd9Kuyv03F0CZRWO4l0ghds5UFsFtkbGOAnPSqO4AnVgnhvgq3gJBn+ncdfC37OJlRWUQS3WD09CFpOLuW87V6X8joRiChUO2Mf2lL5JxAG2wDcgPbSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7cKeN0lTqGsO4nqj7pO/oD9FjZqKyVVa6nQ8BbK5Vg=;
 b=TdFm+c3lCldOEZfb5LW48/4mbWsnBNm0QQtzBzT618rxW1dXA3JGJFvGl39dxT/Wlbja8+ZNiq5xfdNmYTfPJTWPJjKjKU6QKacz6Tj6S/sm4qNvm90TJS99muvw7qPOQExGNYMazNndAnthLkY0rW7BIRdAAihEDU62ECt+kQSed9c+7/uO30pr8pB8yAm3Ke6VrouvgQlJDplriZxDu8P9A7FLdmYyqYNfM/HB0ritwupuwko98uBFiE44AOCgMI9zAXJ5zhW8WAOs7An0w3ZVOdvrMFW23iHQtQ+uNPbM35FFD2o27M6zKY1mC+RdSxQsbUI0KZb0awlte1UTOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7cKeN0lTqGsO4nqj7pO/oD9FjZqKyVVa6nQ8BbK5Vg=;
 b=Fqlt9VjDdjWTADuIM7kyWAR+WkO2GQsqGapiajPXMwX6UYpLdvDG10XZv5k7PmsMuB4AmZHjjhA1B/djvH7g7G1XhlvbMFe+kQWS5RhXQ3bLqzgM/ExK8X4KF0A+ZioAK1wZ+LsEzDB/G3ayrupAw1/2hAnrQjO/QWkZcd+TJoE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DU0PR04MB9346.eurprd04.prod.outlook.com (2603:10a6:10:356::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 10:10:10 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 10:10:10 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 03/10] media: Add Y212 v4l2 format info
Date:   Tue, 14 Mar 2023 18:08:46 +0800
Message-Id: <a517ea9c399e8f25161724441b9de4056cd9b90f.1678788305.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 33d128c9-c340-4472-da3c-08db24744b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZYbQohUSQMnx66XddbQH5IZnMoZmAg8Dn/xbkBhfJbkP9noLL22r2coJRhE+ThkcfYt1b0s+e9EgbPldETWhMMpA+9CF93QsPmT5IbvNxxDjDi7R4XFv+CpmDRAd0PIzHM+sZd9XBnpEa8D3M4T2pT1q7QPJugCvDrLxmflNJIKV6GQ/MCZ3Qk20+jFzVqXmK7euh/DkpyOa8Q77zRL3qsgvEue3rFyKDc1V02P0/Y5u48Me9fTmOev93pCa2PBptYTD4BeDWVJUeqH4BzgUCGN/X2pN757hJXeUXyNS3k+R9KN7dvTM786PayQsph2pPyYQcCFd74LepwJUNc+Oa7oUcfkxLflan2eMvwezRjDWFV9DK/3cfMOF1LJ4/VkUgbOrPGJXfjoKGP9PY4swlBhlD755HPEkEBY4qLKw52Z60lOZmmjM1VFUJL8DwRYliBrU7M0mIjgv4mZZzgLF/Xz2nnnfxbGk9yoH15pWJvSBLJc4Fpaqhj1pt4LidRO13hi85eXKAyNhxpDlsQo84EOOko8jCG7SYosHcWOgKG2vbyWnjzBK4e4Kj/d5MTwlffZEWjsZir/FhESh9fL0lOblrGN9olBX3OpHrchnSyPzDzeklS5zHaCasZVeLSDsPK4FTAMuKqGM+3ccKF/j8iBVrGEc1z+RB98HO1MqtzmHo3WYPU8D+5JpRK/tHdclE70n/btFUM0qJ6J+lObV2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199018)(2906002)(41300700001)(83380400001)(36756003)(5660300002)(7416002)(44832011)(66946007)(8676002)(66556008)(38350700002)(4326008)(66476007)(86362001)(38100700002)(316002)(8936002)(186003)(2616005)(26005)(6512007)(52116002)(478600001)(6506007)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L+zvwxBDYbCJltFciFRcU1Xe8PTIFtoU6LaTz9OPkKI7lXkZVQdOIJAFpp7r?=
 =?us-ascii?Q?udS9eF/ARRN6R/HvZrCfvgmszcl/Xh+hMU9KmrtbzAD12ummx6EENg+bNwz5?=
 =?us-ascii?Q?gPAMvYuvBpeEwcGDwJbcKWr1RoAXicOZAELPh1tE47KTnKjXPg+dF8YWfySw?=
 =?us-ascii?Q?MH11/MczlNlyXUG0rftKhVSN7bVLNVz5/29X965DxujxGE2iVuWbB7yYI2Iv?=
 =?us-ascii?Q?R77ATDctZueyybL6NUGefniRbQWYaSf0m2amAc41M4sbNU7lCk/Lq/SQPJI2?=
 =?us-ascii?Q?WILsbSKy86YeU1wgV+1nHYrluvu/GS9mid7b9zve9WXd1b4juOVDJNeOy86q?=
 =?us-ascii?Q?aLjU4NOu78L6qUSl+WMqSkABILN5k0EIhcpnwA49YH98gOECMmHFVez8iQBP?=
 =?us-ascii?Q?zPrXN6qrEyVjDCdvFRpOafDCLMrbkBsA5Vjqh9DlkE37ysuB9JXizO7HrJNH?=
 =?us-ascii?Q?T82r2udCMDu8SltQzxBE1J0hipVY/M0BAM4k9EMhQltyY+aZwQrn+kejk62W?=
 =?us-ascii?Q?yEiP0EePReuV1X+HqZO0hdzI1Buo49/x9RgVYs8QT006Hr8eTc5t+6hGnxrK?=
 =?us-ascii?Q?Cbpm6hLoZ8kttG4n8JPmXF8OwR2yc9ttHxj8Zzi0ABK860qfVAS8Lpl7rMaF?=
 =?us-ascii?Q?R8i05iCLcTZVvrdn4q3IoifeBLnjfkoanHFToGpnMZ5Q1hrDvtT+EqrcN25u?=
 =?us-ascii?Q?iP84SqZnyMh6rvi3+ycp87msgvU4VUoAOrmXdwtyd1Pu1XTj4674IPPdOrLJ?=
 =?us-ascii?Q?TbMP8IBgXaHlk7GQ1WZ8QlD4TYEroCY+jHH5dc4KdRhYWwiMdKynOI4/pFjV?=
 =?us-ascii?Q?bhrREn82AV93bKFSXe6np2iU22gntj1/TslGNyF35vcXXDXmH8guJEQrGhVn?=
 =?us-ascii?Q?8S3EOtYiKgFvKaeeCG+X3FBzW1L1ywPCqE6OM/ObVqC5nue16CWQvfmk9WMT?=
 =?us-ascii?Q?28NJleEIcs44fDn/sG50OrAIXotKPQvpqlw4F63k8OYK+pUfYIKOHDe2wy1s?=
 =?us-ascii?Q?dZeCY61UJxvLURYD4rxThzvrj7tHE/Tda36vDu/SyYSImeyYj4K47c4mlwki?=
 =?us-ascii?Q?5bEpzWa+nJYs+i0wuriSzQDBgiap5uFQWvBkB0bebIYFSgGQ9pmxNg1Jk0Bv?=
 =?us-ascii?Q?Thgd6wbPCSASN7WRnh8y7xwdVSjPq6a2jfk7jGfBVEom7N8qBw/TUgcvgMG4?=
 =?us-ascii?Q?fdZ2LEwh5QBVq+hocScdJ7z9yJZud+7oamFNn1hrgmJyDllq9T5e0qnKBb2s?=
 =?us-ascii?Q?4KwTVjFlcfCAOoIalvqHP5J5vRR7zJsGxnyevehyCCURoJ3IjZ08yPMQea3G?=
 =?us-ascii?Q?14u0z7ZNEe/LmCmeAKRInO2moYXDJUoP3jC/kGnfT4OrzC8E04s2wI7PTw1B?=
 =?us-ascii?Q?1njiJsoGZLeRDJEAa0gRKj5L4wD4kssXTnDv8Icm8Y8G0sFHFUId5FNQTydy?=
 =?us-ascii?Q?CYckiouJNqott1SKvdc6ZnbdAFLEy9OYfETmyz5yjdjya8OzI/SXf4yBzcNE?=
 =?us-ascii?Q?sVObFAWHB2gXuJnt6ydBDQ1PIq/+/9LV9gFg0UczjV9N7w4fPBJNMm8wyMBP?=
 =?us-ascii?Q?MR/Yx3QX1Zu5Drs8TMsdHAFjirOwxA5iTndGp5AK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d128c9-c340-4472-da3c-08db24744b71
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 10:10:10.5647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IsG/hclJWuEDqUP2nfvTDOP6VodMFhGygEk4utroKaGs6Nz0Tkm5bG0KscTJNin6IwV8K91tl43UzujjdQoKMg==
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

Y212 is a YUV format with 12-bits per component like YUYV,
expanded to 16bits.
Data in the 12 high bits, zeros in the 4 low bits,
arranged in little endian order.

Add the missing v4l2 foramt info of Y212

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/v4l2-core/v4l2-common.c | 1 +
 1 file changed, 1 insertion(+)

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
-- 
2.38.1

