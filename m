Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CD4668AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 05:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbjAMERd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 23:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbjAMEQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 23:16:32 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35AD68C9A;
        Thu, 12 Jan 2023 20:13:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXZrBW1hvG7x3/TGbrBB5xY4caEhRcC2eXa6YhxqlOiVPW8YnY3cueSo316wKRQUx93+AOIw8d80Azz4Z1d64BjY4bgD8NpniRZQqCgSU3W9P1aYoB2VbQFnTS98wX9hLimyELV7n3qFsjfupB80W7Ii1vKIh5AohfriwIDpTNhg+9DNWX2K/O9dgNFuDMADC3CRLN0XCcpJYXg348JGXM/6bHMw77HQSPHGGzm8MuJWtJGIooS7zOaoWRwvQI94rsI0kTtZyt7sTSyVWKqPMdfLFizO6ymVGja6+pKbnoPaeK4UvGZY2FkehnxdQ7YYElerYtcxewQHZvlwuJI2+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZ8SPgDGgUZh9LMDh23mMnZslhboBm/85UmzgnKha0Q=;
 b=aqc7DuwnTwrrZ8HX5pWHcEtTK7MRy9G+HJoUK5QJJuAdJ1B7XjCGDj37CFaNE1yby580mC6LKYX5B8hx8Vsk+nHgvnfChmR976yvQkABcYFokYrNROLBcUu4YaHIBhSzVmWwweTyxtCZ4YkiSprjcwo/UQv9b8gLugP55mZXN9vhEukPaNbCZdRlVJ3jekpsBN3P2wVZW29BtzV7QcZbYvSXrJqR4mauTZ0jjBp7j7/TSQXaXqhSJ/9JchlkkVk0GC3WdgzKKc2sOjtxKZ10RwFWChjsCHo6n2nBzCtxHMF/P45vf946bYkS8be+za1U9j4B002x05YL1cfjKJ9xrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZ8SPgDGgUZh9LMDh23mMnZslhboBm/85UmzgnKha0Q=;
 b=lLjvTOWwrEWPfyDdgb1bhWd05ch5+KgtZMInHQM9+NdObaUU3QXiAQF5eZoI1g1a5ew160Ngyc17QBYoloS3bShGLQjzZ2TF1ABtmwJeYPtJyN/4Qet6ry1lroYtGihCXr1HoHxTik0VF9121tNxoe8aFaF2hQ7Pvm3basVNsGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM8PR04MB7441.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Fri, 13 Jan
 2023 04:13:22 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6002.013; Fri, 13 Jan 2023
 04:13:22 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/2] media: amphion: decoder add support to RealVideo
Date:   Fri, 13 Jan 2023 12:13:05 +0800
Message-Id: <cover.1673582851.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0230.apcprd06.prod.outlook.com
 (2603:1096:4:ac::14) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM8PR04MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: 209a57d3-5d29-4b79-dab1-08daf51c825f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +yBrYEy81LpNS0KLXWhuynYcetuVE0S2GGvLQr5wiLPyDloc61mSoRc9yH9Aoa1uRQZcooy54SF/5U5z75ZGCj7VXrOLfQBT0qhFDynikwcQE9KQ6wDTemLZI67LDW4rDfQfS5Zh1z9HRZ6i/fFuX6OT6khMUbeKF6xuBkQWmxbD/Ke7W75FeHmbexDB5q3ZclNMvvZPhypi6hymgqqNjFiseahMdqSVqHCus+tT7mw/sjiDxWNiG9HY8uhqVHnjOuMq31RjT2rXAY1ooSWd4eZ+C/leR7WsE8iAZdU6fnDKCXY4KRTQvHqdUMc8G5t9cLjMXJ/ufUEJ0yz4vLRpaK+iZO3DSEj2WbEZ7yZJivOA3H3hreJR+lRTgYNnmomHvVVOM1dr4Q0ZIXrcdlZbAdW8vqW9G+zIMurS7eQEUcSYRHiy7ykawmsY1qKYL3tT3UK1Z39INXuzJkp9aZjcKCW/XcKzm4w3VMQ2y9yiiA//IgXMJiT5T+F+EDr7AvXTrJcTcejaNEKKK8jgjlkaChC5xMovTNJL7Tk4rq410flfF9SHb1nv+h7W1SHwegjFG8FzIyZr+196UWghGy8KJubJ/65S2A0yD03P0T0WiglDzKkGKXHkMlgFmOc13EZhy5qBzfCRUvexOoioxOGxBA8VWNomi7RmgleEi5yLSq31AuQSErag3L/Y776LJ0faOQyoirr5y6IEaTvltNzTPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199015)(26005)(6486002)(478600001)(52116002)(6512007)(186003)(316002)(2616005)(8676002)(66556008)(66946007)(66476007)(6506007)(4326008)(6666004)(41300700001)(2906002)(4744005)(44832011)(8936002)(5660300002)(7416002)(38350700002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sMI4K0ninkotwKf5FF4rD5gcKVVOtwWf760AxECJqc946QXiWxxDpaagHym4?=
 =?us-ascii?Q?seqRWYfb1YMrNFRjzrSgexHhhAlc/NWsp1nGN/UQOcBnq5HCWQGWOiqTX6sh?=
 =?us-ascii?Q?FdgqB4x+8oUdosERdaygxHM6xto5yrgUPFDlJkTj2FqtI0WhWHkXxhJRu2Es?=
 =?us-ascii?Q?iOALUSQXJbEdS2nxOENblVKeRMIrivaoH5jK3CASv+QpsEbDswZpHYLOZKyE?=
 =?us-ascii?Q?I5LgObrdXVsMBnXgNWetYjR8dET/BPSYuWyOrOvVJAO+Zdn5LS2vodXe5gVo?=
 =?us-ascii?Q?uMys8YB1xhD1QGPVwxFNWPnFPXO70YX8EjJl5Wwk693+HW4sJccw2X8beNzX?=
 =?us-ascii?Q?C1T9FcTYtDq4H6bwtBVK7U31qBr8miL1BKtuM7Tz9r7Tspejp2WwhHIkM4Tx?=
 =?us-ascii?Q?QOlU764/A2k3WNLAobPXaRMB4QRyFuBndouG2Htc82H7B/OcdK0uV9ukD9bt?=
 =?us-ascii?Q?P6og0ga45qe4BIdnojuO9NBCu9QuW6ezI9+FMY//A5To2Cz+tvRkTH63ocAe?=
 =?us-ascii?Q?qTdWP3FwMgZvTE7d8Ud4cINB5Bv4d92dwkkrfVJ54uujs6+HmJyPjwD14Xkr?=
 =?us-ascii?Q?Lkcn3uIwqPAhvPeDrP89qOwiPkbKZqJ9ivjIfJ9HQVgzGRJyPlAyDzJa1U6j?=
 =?us-ascii?Q?ivHurYRgUhcXzQ2B8WuCu9uDfDvHNeb3PyhLVPCmY2ZnMlbM937qu396yrrj?=
 =?us-ascii?Q?uiYXQYlUP7/TNJmu7XOK7H9U/mMbhlAIBiqHB6dQlnuBEpPN08J+uUpO5uq5?=
 =?us-ascii?Q?ukHcfTtVS0paxAYd4MHhqVtFOcjyOIyfwvYLX6PxHTK9JYxj0hQalYYVeK45?=
 =?us-ascii?Q?3hHQ/U/Yly8/Mxr8z8p3w4DH66V/EMbOHpoqNI53wjv0KbDJ/0QGUc8sipGy?=
 =?us-ascii?Q?zT4EYcQja1rw5x9G3QcfATUb6h93Hw+cU0pnbXj9/+icl8bBAGLafK5GwORd?=
 =?us-ascii?Q?oofkg52PhJCgdTPK76PvVl/Fv7QpIoZs17+SnW4Ww4RpSTZtRPKk52c1q1jB?=
 =?us-ascii?Q?s8YKjch8em2NwdUVwDur1yPfncA+LCfhPSCeTSG9DRYK0VADci7ZcSYLzLzH?=
 =?us-ascii?Q?ucvQAwHQb3kHrULVjkRP4iMbyPHYoRTY9zr/zoJHnVNBUEoVpbr+JkeKuk7n?=
 =?us-ascii?Q?tWn+HdrwjSLWypcTQnmKge+qPgOHZFmeAxjNh8FSkHC19/OzGOriJg2DpC8T?=
 =?us-ascii?Q?aMcdcsGgezUTZwMXfxZZV4uA+a1u7cV1Tg4OQ4eGvHX/xXX/dVfiXsmN1f2D?=
 =?us-ascii?Q?Ssx0k4su2ZXFAq8XFm2G1GIxUNrGXCCoX8p3VIOmO7q0dHl/bvnKyTneLl4M?=
 =?us-ascii?Q?CG2qaLYmW5q/XEPDEfjBERIC2yCCpRniaJ9bo4BGLjXXSUZSHOPxsJDnP/bZ?=
 =?us-ascii?Q?IzFUw+d71Vrn9WQlHEr6Um6GWLD9lcFmRIQC6xTvLGt8TekD9Piu0DVvU22O?=
 =?us-ascii?Q?U782D8qBJS0oCJadaY+oBsP14wI0jcnbYaD5o/VHBwwLRmOKdNT/FxoeZRXr?=
 =?us-ascii?Q?GVcZbFmwbgKIbcCB7oUhKzDSkWmERPz24luaQA9rXK0VJVj2fux9bnKk87dU?=
 =?us-ascii?Q?xl6MOdHn79cfPmEIm8hsOKXZQveJ0CBtyMwOSc6r?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209a57d3-5d29-4b79-dab1-08daf51c825f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 04:13:22.6243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2x4QbAbhui6Hci3cV0ESIEaRNCZe5ZsBZZgkuvZtJENfvUE6qaye2+rnL1QENMVAf1Ntt7k2+bnnbg1J6itiQ==
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

amphion decoder can support decoding RV30 and RV40 streams.

v3
- define respective formats for RV30 and RV40

v2
- correct the format name from RealMedia to RealVideo


Ming Qian (2):
  media: add RealVideo format RV30 and RV40
  media: amphion: support to decode RealVideo video

 .../media/v4l/pixfmt-compressed.rst           | 21 +++++++++++++++++
 drivers/media/platform/amphion/vdec.c         | 14 +++++++++++
 drivers/media/platform/amphion/vpu_malone.c   | 23 +++++++++++++++++++
 drivers/media/platform/amphion/vpu_malone.h   |  1 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |  2 ++
 include/uapi/linux/videodev2.h                |  2 ++
 6 files changed, 63 insertions(+)

-- 
2.38.1

