Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660876B8F50
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjCNKKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjCNKKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:10:16 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54D29927A;
        Tue, 14 Mar 2023 03:10:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwd4FYmg+UQyMCv6VhykFhIv1eigrNDf+l7c1U4q4X335YoNTkwl5xPWaPr+rBX3YVSDaFKCmLKM2cxVdi4mfbjvANOx/LFtZA7qYG6VOT2Oc63dsbMYDbdFiwhA/j4zkq3MW1uajKZzTfvr/WzPk0QR06A7RhQNBzhRCw26ztwW4Od5ZbvahNv0k6KEtpFSEO7iSZmTFlf23xrns4yX17cNNhnA960RGFHHcr0r9S9qKGlK0b1x8we03eFa+JSyf2y2KoyEmou/pkZh46a1o0RgXoh19Bn1O8n2ENTscEgG93Qf36Eeibe92n0YJoDHO+mmILU/Me4naWavdWb1Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVuAnwgEIL4YQq0/bJK62tZyqTqnMKhQhytnv/9FPEM=;
 b=YQi9hX2NzMLppvyEQYIZP3ZHsVB05j5b4yxJgQTcGOysmpbdgLegIhhdN1ng2PiGu4ina91gvnw+tG2Z/2l21i44yXnaNOBihaoh/1FiPkesZw21xjqxcy2aIIqPCIqjHCdyXn8bJz2qWL/2ezSopMVRP8sE+EgjGQUQSCPFhmUZt0nqviVkC23XjKTp5ZEemPt28QSt1pZS3GS/7wRsSVDYbySblBIjMt+XseFs1ApR4QwgmQeVD2SQYSr4IN/S1y/8vC2QTKCbjUyS+JWefOww0Jxl0HlzSaJgcP/GuphHOHocbSel5QcA0QFj5rYP0XUFkxGMFpnd8YhBMSOmEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVuAnwgEIL4YQq0/bJK62tZyqTqnMKhQhytnv/9FPEM=;
 b=Fta/wc13y73xxbB6uZl+0V9458MwTCYg4iu7VnWC6yGrfXK35babuyKTmE3NYHVCV9vVLhE7MwjpbS/qk5liZm68WsP+Adr9bCWmtC9c8d+iul1E1mb6EW0B+4Dwvd78oGx7it+XL53S5CZkIftVOsaCP3s4qlnM4qqhS3JJRIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DU0PR04MB9346.eurprd04.prod.outlook.com (2603:10a6:10:356::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 10:09:58 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 10:09:58 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 00/10] media: imx-jpeg: Add support for 12 bit extended jpeg
Date:   Tue, 14 Mar 2023 18:08:43 +0800
Message-Id: <cover.1678788305.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|DU0PR04MB9346:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4c7073-94ea-4e1b-8590-08db24744429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2GATGASwZb3X6/oHvZTpkgri9fYf0tbs2jZ9SafLd1NAG0nGLM7npl1/hLDEpEq7HNcxWBZ/10EyRBUHnTTnEGkn8Nlk/VJoFLP/EGjr7m1rk9ROtW4jCLa8GtYbkc4nOiqxviekimq6gL0IHLLQAdvUnnD0kO6jS3Nv5j6K8Dg2oLgonSDQXbn9dAu85x2xZDF7LSG5nZOo0PMz82ptn/WssfoxxJJNkh6qqFKVbouKPw1jRMmMMnBrIJ/nZjUN1V3nHj4oe1zWB8R1b6nJIefsBhX/U+9Icf+aGsNwjVOdAs0hEBhKJjC+mhLTlt4gwT/1VsCA8pIwzbupzqy+QT66sf0AO8dQYSTSTOLDjz76FWwnRDYbNCFQpl50DS9mpCpRQBXthrmbD1Rh8j+Cb2J4lxzWbm+rRSU6W2x/D19KdICqWGi15hdCPkr2d7JXEwj1KWDaJK3kAqB+sHcMe3Ig6O4zgp0qlXMdhGz1URC4ifHAzf6eBpcXA2bar6cSa+iqQYxBxXO/I0qwhb4i+sL0yuV5yfE3mLxd7+20vPhoAKHW95GG+SJx70FeAbSrqYH/ahV3AIee32KpgmTbbGnTdBY1Ondztdp1Qy/r22y7rTSoq7uaB+wWlMNiz9Vumx82beQKEL5UTcGhki/PHiNlnjru6OqjESmCS3cweXyEk5ZV+eaQFD4qdiTurpAamtXIDUtgl6gWfJQ7ReT1Cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199018)(2906002)(41300700001)(83380400001)(36756003)(5660300002)(7416002)(44832011)(66946007)(8676002)(66556008)(38350700002)(4326008)(66476007)(86362001)(38100700002)(316002)(8936002)(186003)(2616005)(26005)(6512007)(52116002)(478600001)(6506007)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iuslYA3FXkcBX5iPDICLcK1sPmWVwvC7NkU4LqJPMr/yaxWOgqVHxPRgsZ1U?=
 =?us-ascii?Q?uB2Xzaqachc+hXfwXcWgV8VgLSCHwLV9qLulcDUrLqAAs8rzaFq6dORyTq7z?=
 =?us-ascii?Q?LWtFKZJQmgRB8RwP3D3S9BWwFvIfKq+/rWCOtseY9s4sNqZUaYrR9ibgz8av?=
 =?us-ascii?Q?xuCOEzkyIUgtGeUgczuILiR4vH42TMyWFbV4OY27lio4tdgyHvdQIM1rypDT?=
 =?us-ascii?Q?gO7Ko0VnzK9nHT1mGFtwEnCKvASvLgpLBEqumH9JMmxGcdHR0ZU/jArv2Kvh?=
 =?us-ascii?Q?Cm8Y0Ffj1tGqfX9L1j99JK12y+9Tv3JjZCBF1cJsTtJlDT8DKmBg/p8s6MOf?=
 =?us-ascii?Q?gzsGojKtUFsnFWqVhtsjm3XWLdxepqBWpfDZPcEytaJM7RjxrTx1N9sEoyOw?=
 =?us-ascii?Q?8VU3bTYhsVqberACWqP1RDYLcZSJr6e/0YuAvZzl5VnFs76BLwuuVQxyfnXM?=
 =?us-ascii?Q?STnGThM4imcrnJ+zb6RWZihwYbC46SBrMwrirYMidGFMONHdDwdnakyX+w4z?=
 =?us-ascii?Q?wF532SeiUWhLCZ9t45OFuE2OuxhjwhAtwqZaZtpXju10jMNArqVKZG0mzI6I?=
 =?us-ascii?Q?oJgX7kHyzqjjc/6Jm6B7Ft6j3jVbP+iXTwskzSa5/DrZkdBk+exuVSbjT2F/?=
 =?us-ascii?Q?pJ/4MAgGp2FPyAz8t4n/ynisl2lYWfDK9UOcCfnfONkXcSxuvq1zBIdVspyn?=
 =?us-ascii?Q?lkfB466Cn2k+dbFc7sAmH0gWcQnSAb8wdjTzmDPalhjZu5LXEvWdVnMiHnqa?=
 =?us-ascii?Q?QdR17Z3sAQkvNqJlPC+ZlyefkO0+pagfaELdwz47snV+5gqUAKV8J7JyNlbb?=
 =?us-ascii?Q?LEwbNb71A60sGwkXnxQEgQRWmewjoYK0+qvk7IFYbjNznavDNYMLUoSuSXf4?=
 =?us-ascii?Q?qW9TTMrmQjmqjv5uxrL/4vd3ti2Re2WpCMdx1+Jg6Uzo8xFN4sd+EBftVVkK?=
 =?us-ascii?Q?srUQ5vy2zRNrDIhZRiN5NAIGAbUrKZVmd8mezn7QPgIZNH7P+EZytZuBFh3j?=
 =?us-ascii?Q?jmM/SONDoezIShUI1ejsnelhMee5yUvt1EPc9wG4gELfQ6Y03WOzl18/DemP?=
 =?us-ascii?Q?Ic9pVQnkv039hq5EXIaJjQ+UWH7oJ4u6+k1m2kdq0BVmFTfMJA0/A6G6+EAZ?=
 =?us-ascii?Q?3BSdm4IW5+6glxyAKcqrkgcO/S1fxDFM7xBet6KeTwPqwnj1LnRdlMqLO+EV?=
 =?us-ascii?Q?kpTrsOF3P0qDpi4NBiK3sCHDH7lFIaL6swm3OHEeCK7nz2rLl9Gx7oSkHIp6?=
 =?us-ascii?Q?LdRBTnwevI6OGXVgnKSRiFKtrJFzavXRG78BvsGbr5HQkY5wgUGIg+JJL9FQ?=
 =?us-ascii?Q?+ZnbXIiBsEJq1/QpLMxX2U8og8Tf6sxzaEK+yd6aE0U/stjRBvEvV0VtVRSd?=
 =?us-ascii?Q?SqP52+yeKftm9HNBvnKZwqZ/ca+xaKskWjV3N6bx5T7hwxybBLr2teN9nB4V?=
 =?us-ascii?Q?lBesrB9kCDchQXwXgX+JeFGiHnjNP6xjASTw3ROwEZ3cwNxbPKnTeNHjZEmX?=
 =?us-ascii?Q?0lKLqidERDe7uBoaYCy2AwnHm4RSIAPZdlYgxRPM1uVs29Q6srHPgiEH2U3R?=
 =?us-ascii?Q?wAWagmPynTobVFoDdosLDMfJBijJVLEOKcxJXfS2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4c7073-94ea-4e1b-8590-08db24744429
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 10:09:58.3466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDH5m6Fgmxnseu+PT1PsHfpLEYtS73clSNzQveKcLY7qg+sUmzjxs6sWh/rFxU9d5VVdJVQro4EQlVS/q5qR/g==
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

the imx8 jpeg codec support ISO/IEC 10918-1 Standard Baseline and
Extended Sequential DCT modes.
it can support 8-bit and 12-bit per color samples.
Currently we only enable the 8-bit jpeg,
and we can enable the 12-bit extended jpeg
with the new defined 12 bit pixel format.

v4
- drop format yuyv64_12, use Y212 directly

v3
- correct the new 12-bit format naming according to Nicolas's comments

v2
- correct the new 12-bit format naming according to Hans's comments

Ming Qian (10):
  media: Add P012 and P012M video format
  media: Add Y012 video format
  media: Add Y212 v4l2 format info
  media: Add YUV48_12 video format
  media: Add BGR48_12 video format
  media: Add ABGR64_12 video format
  media: imx-jpeg: Refine the function mxc_jpeg_find_format
  media: imx-jpeg: Clear slot next desc ptr if config error
  media: imx-jpeg: Decoder add support for 12bit jpeg
  media: imx-jpeg: Encoder add support for 12bit jpeg

 .../media/v4l/pixfmt-packed-yuv.rst           |  28 ++
 .../userspace-api/media/v4l/pixfmt-rgb.rst    |  42 +++
 .../media/v4l/pixfmt-yuv-luma.rst             |  15 +
 .../media/v4l/pixfmt-yuv-planar.rst           |  94 +++++
 .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c |  19 +-
 .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h |   5 +-
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 326 ++++++++++++++++--
 drivers/media/v4l2-core/v4l2-common.c         |   6 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |   6 +
 include/uapi/linux/videodev2.h                |   8 +
 10 files changed, 523 insertions(+), 26 deletions(-)

-- 
2.38.1

