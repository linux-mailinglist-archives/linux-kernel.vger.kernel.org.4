Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7BD666E1E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbjALJ17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjALJ1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:27:05 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A17142602;
        Thu, 12 Jan 2023 01:18:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RP+b1uJhEZrun2eb49cvz2AKLTibdTgfXjm5Y5+PgiqQ6NRDUwLGMPR+oo1bUMfvIsCPWcGkLiOrmkm9NiglywQ22WzVIlrGgQIYuavRNHri2EDGEsiEO5eTrdYnyHdAXsXjCZ1KEFdzuDqWlr2ZhrsnxknZ50cNuAJb/qSQaum7oApoc75IUDlel6QxhfHXtSSsS27bNi65/JEh8R1ShIMyDrNjCw4NeATKCtnsxwXYZiiEpqZTH9scrLw7fFUrtyZR2AFX7B7/9Y06RKb89esQccp4aYO/848C1+H+RVNl63cWii3rsSBxwb4Q4dBIn6PbuMKeL8ANtdqWz4pxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYwLI/QJgKA4Zj1KamZcyw2XXGKQKSoRTfBbqsF18oI=;
 b=QQ8qyyHaI9FyF8YgTa5/WQ0AsoS9g/rNfvsbVCx58OuDNOE+k+f9NJwj4C9YGhhr6ktIOG06aXbGprrSZ+UyRT6capi37nZq8VqU7i4YyoQsPCnROaA0HbB864HRVJ7Pc4dim7Qamh138tbzypq3iZ6arzPh5myeYUNyPyXxhBtDhSB+Xk3hgg+19yi8XaZmi7jwCRvNoMFYkBb1CgDHo/O8Tnmz/YEbrRYCtlLCqkVlo5jmUDO+B7HMKjN+H0kam41BUEBVi797cjuX+Az8NFulC0V7jLmsduw4wJl06Xb0zPMTLd2wVfhxPnvIfIyDRqg/oeaQp7aaUZ7LD/Waog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYwLI/QJgKA4Zj1KamZcyw2XXGKQKSoRTfBbqsF18oI=;
 b=ppLid9zWkT8J7s3Pms6c+6fOktnNmQ+IzCalQWsXcemGs5Z2eJBItGM2/+xwm4+Aus/42gaWbr1pKjz/R5CUL9XfhH65B5KfacagTI4IT9okJhdhvhBUK9pgTjEHy1TVpL/mNUvs0ULSDXtANtZpKXi/8H7DJy3AMG4P6L3BDn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8923.eurprd04.prod.outlook.com (2603:10a6:20b:40a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Thu, 12 Jan
 2023 09:18:35 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 09:18:35 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] media: amphion: decoder add support to RealVideo
Date:   Thu, 12 Jan 2023 17:18:16 +0800
Message-Id: <cover.1673514352.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM9PR04MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a2136c-0bed-463b-b12e-08daf47dfb50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3o8P3J4oGGB/Z1sV4slwDGZu26RW96wiC/cfIfe14EihmO/6ZcY6ZaN6LMzAKZnZzHfO9SB+sVtUdaj0ZQ570unQQuqW3cjN3SGN6hfEpSAQ3iX7kLj1Nz2vYZICb1xzuMo78fd7meezAnk8G1dO3FYAs0Q2V/YYVMKILLtPRBIGZXhikPyRs1UCq0CBVOJYBw/rkrZ/6fwBBEmkU3Yotx6xImndhNy7RJ2uWCUVOn4KkNjnp3ZoV4/+QQGmx0RsDBQlGwk1s54citN5S/eX7JFS4IAstkK3SVM5C1UBa84fcwzA/hSIxdSsgPkfEKP3IlDRS4ZgVQ4O8++YWhdgI1Opn1oRVvUe4lQr/1hT4k8kFN2vVGj0dRd7PxSXE1uiZhfGEWIPGUulsxYEQOhUTLJYQr1QtgassBuBHS7iRO3aUNA0iacSsM+pHo0GO3DbNM2NwbZ+DF22bcBveJFXEx9Xz249Q49M2mumC8X+0+rH3jdogHuEBrd1X9scGaCYD/IsJqHOgXborHIfuJdv6uOz58pIFOW9rSvM5vtYNLB9hthPMe9Pc+Mne946p/AwS67HAzFs4CoAZ99WV+riFIOnctjkc/JtghZeBZ9Zgq8MFpHYoXuqn1hhVPbdfN6S+KnxNy34knvoVP4PmkVUhh1kFYTZ4bZyx/t8pAUCrW2cxt42y2CDym7EX2UIiZeLpo9N/GBRvN2AHpQf9RUwOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199015)(316002)(2616005)(26005)(41300700001)(5660300002)(8936002)(7416002)(66476007)(66946007)(8676002)(66556008)(4326008)(4744005)(44832011)(2906002)(52116002)(6512007)(6506007)(86362001)(6666004)(186003)(36756003)(38100700002)(478600001)(38350700002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Efpe7pPOE0LWVFHRSsrm2PSq1aclYMPMRL2DoaCWNauA25asS3Nc8z6xjaZ?=
 =?us-ascii?Q?+yhImu0MwG28db+Wo/vWYYCFZ8OYE7+I0B9ewbqRT/6qrLcz4ZLXHBT9vUzY?=
 =?us-ascii?Q?vjPlpzkBAK4jzrFDwIzg1FOtmG8CfIbodGnVduU/nqQSmcR6xZel0h5Ljiv2?=
 =?us-ascii?Q?+XhWel0I2j+zMbE7YUYGa3lADlq/S4Bpl4ZWs3VbFY3yG+uEa40yu8nSRwRD?=
 =?us-ascii?Q?AjFnF0bQRAblBkPlPk8HJejGYaAsDHbNMLUVj62IvaBFsc/kf4gsqrWbxf17?=
 =?us-ascii?Q?zYIyulbYtvlxd4oVMFWF/lht4Ixz7ihfZSYDuhWUWZapV3td8j1UDIEkZR9g?=
 =?us-ascii?Q?n7LsJgofQWfCUQTGECSyacb5zZpd0nTdm0soHJAikg21aYcWSuc3dohB/hjI?=
 =?us-ascii?Q?kM15p8Ce/uZz8XknrGLjdZmYEr41VkQJsAi6f+Ah07BUsJlIrnQVeaLo9PBq?=
 =?us-ascii?Q?w8grGdyj5z9MaPYGURgyjzdSaVU7q1iaXnCQHt6oDlYdMFAeJk9XZRfzVg+z?=
 =?us-ascii?Q?Z++D04Cppl3zYZMjO1mVtU1r7zYX1dnrXJC/49Gb9dfX44D9aaIXC50K/qTd?=
 =?us-ascii?Q?2B4CbGZRVlHipi0VoeowIMcPPuUgsOTvuERgXCUepjEogr5HakycL3i8baJg?=
 =?us-ascii?Q?pI/D/ONCOnS+leFSTWlEhUuMHLQKpBIG82PjxOZvngbf9kI/fG7VZkirJPhC?=
 =?us-ascii?Q?i6eV+VQ+NFCd+B26hpikgBRNrZhBdOuq3laHsTgE+UERwdRTPdguV2h9kn2v?=
 =?us-ascii?Q?hMnHGZpfWeA47FYebALEAnOS/Y4akNqRS++YH+p6cFSiJPkahB3C2cQX91ix?=
 =?us-ascii?Q?bmYnG6TNK8uG7zyVlyQBsKGq/h2LPVcv8ewYDGCw2j/6KVFXZmG9QRo9boYg?=
 =?us-ascii?Q?6GS7xfKF/R1pnXHz+3NkgfjaOTh1i1Gov/izatBZMNU0PcH3fwrurP7dv0xe?=
 =?us-ascii?Q?fXCG4aQwNJwdzYTxfGLr1pLETlIBbd7FHNYUPBg4JTgLnrSWKs1boJSiRKK0?=
 =?us-ascii?Q?qByGXDSW2g+zjiISfyLZLKQXtH6kPUBVmgdCYhQRgFtqMo4V+ofwKO89oIgw?=
 =?us-ascii?Q?dKZiKy3SZfcbcqn6BmMA4xokOagXlD3xcfB3aOwHpTUwtm73ZuUlBvVRVmO/?=
 =?us-ascii?Q?RuiQjv87qziC4Vfhwg1kP4V1Lan81HCV36BN1Pia7ZK66wd5hLoW9RmVhJ7V?=
 =?us-ascii?Q?wBiOp3jYD3ZVwsjqGGEg4023OXqVTxIrTb+KkHNh6XFKDvxdrVkz+hggviZy?=
 =?us-ascii?Q?a9K3yVqTwu+5ChmgsDRR6j3laz7xar5/6pWQpP9zuE+JkkmJUCzul9o1IzMC?=
 =?us-ascii?Q?5qO906X2uYR3u/QITmMs9I5anWRITQWnIc2ibGMBggJsE3sjkBOg+3e9MQ7T?=
 =?us-ascii?Q?qz/hJJDtExjVtsq2A9b+cCPInntCETKj4Axwe1FBbBxSIiuzsSsdocbwnby9?=
 =?us-ascii?Q?/nlC1B/+eUD7makij6DUmn/xm6lH7pTgtTcd6OTaDgSgvqYurj3MSdSfw7Di?=
 =?us-ascii?Q?BfTCKVt/UFGcgntJypIgVOloKm3UJU9vKh4mW6O71b7MQbb1RHacwgAfMWLo?=
 =?us-ascii?Q?SnJ07h0zwPZdp2JK1rI1g+xpv7mOgtNg0cJ1edwS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a2136c-0bed-463b-b12e-08daf47dfb50
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 09:18:35.3617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2plCgElnlw/lZESH2QtRmVfxXef2RHT8Hoqehw5Yn5AkIziUpjzSopotvUCjkEIUaWdoHmp2etHlf2bvWuEVQ==
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
RV30 and RV40 are RealNetworks' proprietary H.264-based codecs.

amphion decoder can support decoding RV30 and RV40 streams.

v2
- correct the format name from RealMedia to RealVideo

Ming Qian (2):
  media: add RealVideo format
  media: amphion: support to decode RealVideo video

 .../media/v4l/pixfmt-compressed.rst           | 11 +++++++++++
 drivers/media/platform/amphion/vdec.c         |  7 +++++++
 drivers/media/platform/amphion/vpu_malone.c   | 19 +++++++++++++++++++
 drivers/media/platform/amphion/vpu_malone.h   |  1 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
 include/uapi/linux/videodev2.h                |  1 +
 6 files changed, 40 insertions(+)

-- 
2.38.1

