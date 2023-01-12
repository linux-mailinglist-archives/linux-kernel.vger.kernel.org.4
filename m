Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8036666D89
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239328AbjALJKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239989AbjALJJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:09:48 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33128517CD;
        Thu, 12 Jan 2023 01:05:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHL8FI3QblTBuU+vymVk1ELk9dVQ5v5MI8BjJR7RL0gXyRGz18079OndUH1aEZVP05zwB5ynpj7ohRsqkez45C/7ZASfMnQbWqVSlqAQDH8N+MwiK1cx180SWPqZ5hKNtGm6n0xX/79BIDOdcBTqL/jRf/hvKXINymBIsYa0FBD50eRunZklCwwQRlUYZQRDRAuTI+ci4CmV/45O/zURLdykrtr3c84u63vQu+o8wYMCWR2ByI1pBZmSZfjLV6IzsSFmguxA3Ipz3QanDIrWcQfpJ83Gm/qTcFGgKpm9mgZsUGzW5Ge9Kn1VZ3OVPQKHuLc/N49WENPQbZaarhYPzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLbHqvFid5kpglFfLDqcOBAkqUlUOnZOsOr69aaScEU=;
 b=R4gyiW/tJ5vO4QFBb3bsNBPymEXTxi1DAN/Z5z3xBCbzf0nvgjFwA+2R1pq2m7VG1cegRKRABzfRuSszE7U1Np+fLCEuJKuW779xpec0/WNkb1ZrKv3Ly4Dk8PsyG7IJuFE7BS1bJknfgtiZFbOZZSs4xRE7pDJmtzzJaNesFVI6Vfi1UIALBO0p7m118l6wEzrf7Hu6c834HFhftL4KQhcrr61+nMvr8b3Mx8q6NMIQOyq40+cnJaI3bFDYkTdq0W1NZR4jeg2WkNQSFxBC28h39XACfXHMCNHC9U5OkXaVWBze1hEXX/4bHCbG9W+0XfvaSxOXwEUyGNQVqRRHPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLbHqvFid5kpglFfLDqcOBAkqUlUOnZOsOr69aaScEU=;
 b=JlET4pXxDltLIlyRFAvuu6TnySC3Kes/22qXJoVp3YR2hTEc9hsRwPMSXHREpZugGKKGm7wZNNvykbquVUw9ltC8u1SiW+7yjHscd7WF6paz4F5qxE+Xo1nS2CwkrMto0/AsXuiATAeSWFB99K9uOnrFBSqta4B50wZzeCcFczE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8875.eurprd04.prod.outlook.com (2603:10a6:20b:40a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 09:05:07 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 09:05:07 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] media: amphion: decoder add support to sorenson spark format
Date:   Thu, 12 Jan 2023 17:04:46 +0800
Message-Id: <cover.1673513975.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0200.apcprd04.prod.outlook.com
 (2603:1096:4:187::15) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM9PR04MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d472917-fcd0-404e-5e2e-08daf47c196b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: khRNwKF6XPpQ3TzoOfbJx+lJgRB0Wffw7mw3DijgJHzwYU5r8u6/STCM5NZbLy9Rov4Ow9IvVHofWvbViUz8riCXnGUE4747ZTp2Kf8sm0xldEbYkYQpQUzgv68XIZsjESoCn8I6RHv3MBUXhLiqXuP3Ds7i/MA/jHMkgwtFsP6M9+CicncxP7JuzZb2JUXmonZlvXwZ3psLsAIvviUeEfRqrt4wfgtdjQ4ebzlrM3eI/mzRrbtrSKB740qGX4RvNmmYX3IjmLrk3VGr8Zq7tUUxqat2iaa0ioiYpPqWZBF/JZ1xOp3SYrVsj8kA9sGAsUEC28A17xNDX8wSJsfpSgsZ/k4l2KDtKALlAmKcjWYGgYyl7+PDviFRng6hYa6R7ihipgaA7zFve9hUBSsNX8Ep76Jp9bz8o6SqBfN/CSBC1xHmnkzC12S8Q8nRhzLssuhtntD4I3ta9+9+BrKNE4fbAJRU1J8W4X7CyLk8hSPYngLqi+IOuBUlZFvWGQk9JyMMUbbwV8Ez8lHbjxRwlfP2gCjtnh3FBHgB327fKQrwI2EW65yQsHwOw//W+wl7LNexUiig5/hHvldJeEMCtcrJrHeat4nxvYCTqkz/XRTVi40Aew/RYUM9FQIfChzONiTzIsW/Poyrv5pvVGwD7eMkSBSMKuIr2IKrKe7pPZQL17bwj//HHAwiuyvlhoN5A8ZVK8nPgTL8bZLYE5l23Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199015)(38100700002)(2906002)(6506007)(5660300002)(8936002)(6512007)(4744005)(186003)(44832011)(7416002)(41300700001)(36756003)(26005)(6666004)(86362001)(52116002)(66476007)(8676002)(4326008)(66946007)(66556008)(38350700002)(2616005)(478600001)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jjU7oF0Ju5Qyq254PG6N3qmg8adOk7ReDeRiWD5Qz4aNdfLUAe28iF0ajlSJ?=
 =?us-ascii?Q?1vcRHdu8SsTVQz6S3j6QuXgtvbNSFUXGFDDex88BXrvU6fGyh3yFx3LXAt23?=
 =?us-ascii?Q?KTA+Dyghsbl3eDyVwhx7gD2G9GrpC/pVGEA+p+D+1c1if8QMQEWx8lnFiyx+?=
 =?us-ascii?Q?30f/RF58o+LSlPdkfou0+EscV+16NkfHvbE5wZ1tycaN4D4DajTKdxSb/mxe?=
 =?us-ascii?Q?hb6uI7bRtt1m6zwM9f8LPNxFpxoBMTO+v3jbAdvROQo7CrrlVKKBwNFAx44y?=
 =?us-ascii?Q?gRjb7Jf4Uh2HFyIA8leGwSxW1Q371PGhhocs9zXDuXOaX2kkMw6VcTyaJl1y?=
 =?us-ascii?Q?cbzGJfIrskVFoAnMglDyw9ghbeZRTSXWexHp7hatJ1ZFKbHDQwnjMTzPXxST?=
 =?us-ascii?Q?EmIZDSfF3bIqfw+20ERkhgKwWwunw4v+dfD6kVPPL9XsH4rQ8lH62L/3frAH?=
 =?us-ascii?Q?PAGVMoBGBi/pbk8kbpH1IunMKoGtv+i4AiUl2zqp+Rqgxtm7vdJnLh6G7Sk9?=
 =?us-ascii?Q?/QGOiOPtxSESh2rcBHYK/ZiTDnhWyRJ4tAusBK90BwY3xvGaSa4wx8bjipgT?=
 =?us-ascii?Q?i3Uu8Gp5dSbLZ3U1LYE8XQdpJTeg+28i8f6eqkdTBB5/w4c9uJjNEQgByeVg?=
 =?us-ascii?Q?hifVdwFA3trhT1+FIWuipUUl5mTd8uLz0QODCW/hU2adWoGEsF1M/p2dWleT?=
 =?us-ascii?Q?zYg30Ycomykrr/KmNDcOq93FlJsJgolLecvfIVPTZzc/MP+GyI9+YcAiK2KF?=
 =?us-ascii?Q?jmggs6jSftZGkpQBd/qIQCNZX3qJ4zEkgtlToCNtKGuNiy9XxEP/Tq22mikX?=
 =?us-ascii?Q?P+fExLFb/W+QiV69NM9tVLYgqGSQNb21+dNhu5Okb7IaHf3GZNxyRGuDvElV?=
 =?us-ascii?Q?FNA095rYfiXtqIZulR9YpmN5ieUpl1G0EYFCy/V+VAOQhwj0CebfPcoDecuz?=
 =?us-ascii?Q?i1S0kxnIgtqseRJxNzfOV080c6/xk2iqr2o0SUl+fQCL0Kq08zNAbzViebyh?=
 =?us-ascii?Q?SAUwt00WYR3E+oFQPKvcAW0DbgMPt0mDFlx1dUy53m7v51mwtIqVY/NmASdQ?=
 =?us-ascii?Q?7yV6TuHzTkNz17wx3nruf1M3pMmFILLSoM+hIcv+87xEG+V9nZkLxh47urCR?=
 =?us-ascii?Q?6bc5zuHvf4cIW7EfqwXBpA7qAPR8Vvbrur3LCPT2a24pMa/TISetAXdXXVPV?=
 =?us-ascii?Q?lNf5OVqcUjnTF/f0/i6KGzPkFpqqcFPB28YTcpYfRytfIRKTe/9QJM3mbV/W?=
 =?us-ascii?Q?Tk+5ggQqLSKIOxEzNLU8KC1yOIiUwDmqvYE9U+kwzIFCefYlxmMU6b7dA4GA?=
 =?us-ascii?Q?vVZa8v4JVdMuLm+moJ9gGKVYxQLmqLbEpgahhX4G/sgiD9kphMUybjdcnJQD?=
 =?us-ascii?Q?nWpAUA1PLM+iTgSQOdG4kHt8ZRuurXH4+jatBYWBLoEjxQzCwG/aHDsYczvK?=
 =?us-ascii?Q?abVtZTGsgmz8eQYnkyTBMeLv7cfUQM85+WePcx08qWUIvERIkp8ExdvqAmRb?=
 =?us-ascii?Q?ZsmpK947bQBnN+qzb2ouHBhHsMxMvrlfgHEl84C5c/WtXTihGv2eqDb8LB75?=
 =?us-ascii?Q?sM4GtndyseqOEfbmxPb9uO/mE0rDVXA2kjaqFoks?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d472917-fcd0-404e-5e2e-08daf47c196b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 09:05:07.2341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4PANZRgr7ljqA/vhDPBRgJhBQWhXGpoL5odKoFfK4JoncEq2cFiL2sW3Tev5I3A0SQ1xvEKdPWi6b7GjHmc/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8875
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorenson Spark is an implementation of H.263 for use
in Flash Video and Adobe Flash files.
amphion decoder can support decoding this video format.

v2
- correct the code in document

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

