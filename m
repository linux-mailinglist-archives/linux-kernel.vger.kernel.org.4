Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2220264012F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 08:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiLBHrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 02:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiLBHrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 02:47:49 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2058.outbound.protection.outlook.com [40.107.103.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F18D15A13;
        Thu,  1 Dec 2022 23:47:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWYeeOy7Noe49Nhue0jgCTt0XAhnC5MdN841qC+SGqSBIbXFRbF276edz3XC0NvuoT55x/FI30FXQrkYo2RB8Gnero23zs+8ueNaEEic3ioy51s4uRsa5wvw1IZSp/gg84wJIS5hNilUkBDhGJ981LNR1Xg2WdP5ccBgdUmGAHqOP5YLJEpodOONw0Ik3fLbdNmlK8sls4aM91BDPFf3/LiUGC+FzrE2uS/6L1pUEhMD/m1EBTqfp7CWKbDrNgvrMJFsyIhubXcKpbO+n1WyeCQtf6lCm/ewYq+48VxxeIuqKwQ1K+O1rNGOz4tyPLxbTuuyPB7yYVCbJbGPtUT3rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elT66mqGRJvfXAdlVA0zPDj8gcIlOtzDsemuLuARang=;
 b=jELdzqcOZpC/I25DAyJAgkKpHVG5Unmnjh9wDMhqUb0J8bNz8RxxRo7JOh/lDclYnLZLDW4sEVM6sTL8stpK94ajxMI1pfBvi+mFZBnD0sdEEdxipHZMk9dc1hceMnWpwBEZJ9YeGDSyNYjBb2LkAKpdtpWUh88UlSq6MeGvvjdBi8i91QsUVdl30HZjfbMT971XR5WHYJa+yHB/FKFc/mvAhb7o5HC7aecHjQchs8VhD7279sVydEZo0qs1vGQjM0QJlnhMt+xn5a7W4QORt0zIVJdjYnDkRwJ8Pu4aiROBOQHp2/+iRtxQPE3ROHa9RT1F+dtxcCFs4OMgwvlk7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elT66mqGRJvfXAdlVA0zPDj8gcIlOtzDsemuLuARang=;
 b=cAPc0vuR2zMWeGoiQEbI389DLWYvg52BagZPHgj6MzD+/hXcX0gHt01zUuB+QRxF3LoKmlXah+rgVOWE/7GANFdsW16r85sPgD1cEBqOJL70/5e7Gd325Vh5C+iU+tLH3NISD5ISnNsQLUbhmwag/PsUEJd1X0990ncQdmrXvDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS1PR04MB9384.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 07:47:45 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::4e64:fadc:30cf:4b86]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::4e64:fadc:30cf:4b86%5]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 07:47:45 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, ming.zhou@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] media: amphion: decoder add support to sorenson spark format
Date:   Fri,  2 Dec 2022 15:47:15 +0800
Message-Id: <cover.1669966698.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AS1PR04MB9384:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d42c63-dc19-4355-8d8a-08dad4397fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1S1axViiPgPOmOP0VDMetnGdCXXh+BpPcprYFwxYSx4vnTceojH7qVp6K7La53PVa2dIYcR0AepIrdsd051f22IPxUhToT27j1xb8VO6MA+SVc3BSXA+kBfnCvW/DKvVo3aPYnGBrW/0mWG72QoU6FgWlVoqwfin6OMRqFyVdsm6RA3hBIddanWAWET7JzRFHrpnQOmPDPIiOcoOn9jIAdMXi4r7TRY4Fb5HUS8CRQaSjJgDWyk2sv2KMK4/iSasmNKgv6l/vdbszvdVwm3iTs18DZNC8caUHPlUFfZIJiRQ6QOXhzb4oWCMDBo2AHxVEo+XQ7jSk6bcG5asnDxc/oe5fW1zW2XkNxUwx4ZQA1s3SnkP0uiQF8g7JUsxX9Xysu5lkZRbQ3uXpQ52hXhoKFQsu81oD2nSKGbVKqYGhtUpYrRg0W7B5pArI9UeUpXh5cv63TMM6+2c3ZdQU0NujiRmlci14IYr8ByMvDPGb+UUfoNW3WIikrPwHaNjsDUbr/6Sp0MUenQimIKECwm1A+ycU77gJ1vMyxkXSmN/7/Vqc61y6y0gF26yqaz5+aiKtU/JPPksjuRkfPs0x0Z4CbY65cDvAeKqqUCImmQuM/kNYCEyk2Gu+8ilFjCs6aTm4jdseX45sEcu/HCVPB5zBMxfoFzNP+iX6Q0upHcnfD9WV3is2xKloDzjHmMvx8F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199015)(36756003)(86362001)(6486002)(316002)(44832011)(5660300002)(8936002)(4744005)(4326008)(66946007)(8676002)(7416002)(41300700001)(66476007)(478600001)(66556008)(38350700002)(38100700002)(6506007)(6666004)(2906002)(52116002)(26005)(6512007)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IwsOS7KtkyA5ntT9gvrM5lGHx1yR6cskaD4uPCaKpP9lgeeAkucD1cXGLAJe?=
 =?us-ascii?Q?G9PcxhrusuOeB9fNiZfKtvMPN0/i/xRZ0rp2nrvMVLRVnJYGCmdLN0DD4wII?=
 =?us-ascii?Q?YFNC2HnJqa+p1KoRrOEOELNkHGlKBYEQHtO9HI/E+ftdtjbVcAI66kI7yqei?=
 =?us-ascii?Q?kzBWqVsOeEtK/sKJKfPtrP/FRpgTNrY28BPI8eNSFWgbWo4J0WGxHuOb73At?=
 =?us-ascii?Q?KGgpGGmbxdwah5I5YdJ6FW7H1kv/LtGm3OcPK3svbP0OdmDyDe9RQVeA16ZP?=
 =?us-ascii?Q?e3DrlpKDO5rcpwFoXoyfrjaOuaYS7O39Z+ioJs1DQQbZLA74SxWGiwhXN1xu?=
 =?us-ascii?Q?/3QzcMuuBvNDDtxEU33ky7qALYgjy0/k91MLhBkT5/Rxs6ehDWOseHIhQAsM?=
 =?us-ascii?Q?75aLRNLow1Bn5zg+IQUBXOl6c0DgoU0qYocRY8ugpt/KEtCo0/lfrrUu4LQO?=
 =?us-ascii?Q?5QGZDaSCVjPkV7OlBtIVoUWsqYt14/ACPiIdaiFwEYwDF/6YbLrdYQS8MUXF?=
 =?us-ascii?Q?sN2bFtO7v+UlyT0Pp9FlXZDiNsE1wdeTQtuWbJgxsmiM2lcSix9emmLoqwvh?=
 =?us-ascii?Q?5VY+FarsD0BzmndFjqjN3hbBm5pM8bewjAACtfe2aFl6p1GYcznnASrGOixt?=
 =?us-ascii?Q?Bpdpv/HdTXqns3vFj6ScEkGEyfGZvnxmW1JIqmFGO2CW2+B/1R0bjsOiw6Wt?=
 =?us-ascii?Q?cI5glNMHvXP8ujIJprWGyWzPzwngDYK2x2eGchZQswMSHKEn+xHkYGnMdBQj?=
 =?us-ascii?Q?fu6QxxKkGzgxVv9/L3DLLlPap9Ptm3GO80r4wM0kch9n/UbHqE5VvoZ5vWk9?=
 =?us-ascii?Q?GM8/7nvKofrQ/hD6E2orz/tI7NHMijWq24xVlw/ZlvC3IXUDFfq31ioDElRD?=
 =?us-ascii?Q?g19nlCl01tBSicRUi2sIFNalxV/EHSUpKb09et7P53RdVREu6vtevIOfBGIp?=
 =?us-ascii?Q?HhxfxFAlUyEtsqXyBULwurGzzhU3e6FyMTP5dyaZsBbvuVCzgN8k5y15h0sH?=
 =?us-ascii?Q?Qyjumh0zLQgUhNkb+uqJL3bbkcKSn44796BT6Iu3huc7TZmBo3eJaxc7E0YH?=
 =?us-ascii?Q?TFhAWjE1pnT5coR60KNSDLqw+TDxhOJvLlqbhgnGMA27w/pzvhJjVxqceV0y?=
 =?us-ascii?Q?pP72BhGxVA4iAenIXg2nTR2R5wQhvfor+PAornik3QlKuXc3I0G1gUgAZavV?=
 =?us-ascii?Q?jW0SG1kbyCoLtL++q5pZJ6HlQ49/AajnbCtahfYJJbc/AxxfOQr65JtC/GdH?=
 =?us-ascii?Q?nPSw+qirk/pKJ3PKXLqp2eTMjnf6qijqObzh1Xc2nrybZww3i2r8XIyUAwNT?=
 =?us-ascii?Q?WeB6xDT4vjFS77ZDy/xyA/jzL++E1jvqyzvpYI5m95v5PrX9LfUu3MXQlWDa?=
 =?us-ascii?Q?yNLasOoWRMtWC/DoG7KSlMPxqUBWbw2Qm4aPZyho512t+1Nih3s1lIjVdfXg?=
 =?us-ascii?Q?zWGFOcmvq2sEYfmChBS/2WBSq+y6n7xmqDltXD1ZwL6enZpSJVXLWXuWM/RZ?=
 =?us-ascii?Q?46rbeZGvAh0qSAbu5m9LCe07bZiOKLsHg1HvJYbGnW9HU/f6xx15EbAxuKX5?=
 =?us-ascii?Q?DOk0LG8mql77rChwhaxEg32RSMnOOppmZ3GubLt8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d42c63-dc19-4355-8d8a-08dad4397fbc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 07:47:45.0759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CsdIToURnBHBgsiq5i/OQUi5EK6TVUFCGMNbDUphNB8Bkvaycd4Mk4Wep13kaQf0xegug1+SflHQT4gl2ObKeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9384
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorenson Spark is an implementation of H.263 for use
in Flash Video and Adobe Flash files.
amphion decoder can support decoding this video format.

Ming Qian (2):
  media: add Sorenson Spark video format
  media: amphion: support to decode sorenson spark video

 .../media/v4l/pixfmt-compressed.rst            |  5 +++++
 drivers/media/platform/amphion/vdec.c          |  7 +++++++
 drivers/media/platform/amphion/vpu_malone.c    | 18 ++++++++++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c           |  1 +
 include/uapi/linux/videodev2.h                 |  1 +
 5 files changed, 32 insertions(+)

-- 
2.38.1

