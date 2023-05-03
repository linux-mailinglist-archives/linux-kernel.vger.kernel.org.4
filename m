Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54096F52D1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjECILg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjECILf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:11:35 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0930E4497
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 01:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8b/aJRvh+fv4fLj4hFMh6/HHGeJ/Wgr2FYE2nM0K8+7e2+x1MDqPQDPfDHdug/jccELLy3eJHjeWcW4g+ZD//pBsh5Qh9tMXLaKj2SUmXxO2KFZLnQFrcLpku2W9KXFGpamUI/UIL7P6og0FXjUsciS02cldq1acvGWtVA5yPh1M0C+1gFj9cpPsDonYArhIzaVkSN/2aKR8tlE2qPJjYu5xv6HJYWpabwoUR9N6iPJVWBW98nES3PA8M3+6fWWTcCcIuT8OrhIGZFlHmQlCvmb/mcO1msm61DtHRuJm5uus/1gjFUwx4KzOjtNG7Vg/Q4um/9KN04v47SXqDH8jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOlNlxW1utziA5jo+UMHtHC8Fr6/606iUvgR2FPKOeY=;
 b=QczfFOQ+YY+MyjCquhm1Mjmyu5EX4+3fcyDKChjz+RGqBEta0pcDXhU7Rp96+IZy2yFAPWRnY/aKuHf+f7E0l/ME5ArSvACKasqogHlIDdmvXi2PDqe2JyhGZsd8m1MaNw7jP1LEiCYjf1wc/cLaVKFl8pWPWLPNWJeS1pnuMrqOC/pvgVq17aE9UwndowGfqw/m5av5FZUNgn9Mc+1zDr6gtteT2uV8cGNfbeJX51EiUxgucdmFhvd6FnC92JBdr9uW6kYiJUFilF2MIFA7OLIV+blQkvKCKX+/ZWto7UJEE5o/l51cBZqL2/7lweHm12LreYwVl+LaB3KZt3oSNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOlNlxW1utziA5jo+UMHtHC8Fr6/606iUvgR2FPKOeY=;
 b=BaF0tztqdfdl++mU+kRvl4FTmbE7tvMnvz9GhEylrX0HzycZF04S+1FN7I9yomDIfOrao3m8WURKd2bHfMNAgHZnk+s969nB4Kz5nOaguDjRewdIbCwyBpvqZMPyxJXAUjJlG4Igm4aJzbq7n2yrn4xRFmV45191t1PpNymNioE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by DB9PR04MB9865.eurprd04.prod.outlook.com (2603:10a6:10:4f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Wed, 3 May
 2023 08:11:06 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::42e1:4216:edc6:52a9]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::42e1:4216:edc6:52a9%5]) with mapi id 15.20.6363.021; Wed, 3 May 2023
 08:11:05 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, daniel.baluta@gmail.com
Subject: [PATCH 0/2] Improve support for sof_ipc{3|4}_bytes_ext_put
Date:   Wed,  3 May 2023 11:10:47 +0300
Message-Id: <20230503081049.73847-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::35) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5151:EE_|DB9PR04MB9865:EE_
X-MS-Office365-Filtering-Correlation-Id: 14831727-bc5f-4cda-c16d-08db4badf174
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1orHpdfrkWU85xtdFF48FeziFi8ZPKyAxaDD8n5e39dWfW8zzXYDLezlWzqCEl9phIdeMdjKNhlZ3T7SaotRglvbzcz0K/uqY47CIRthX26kP8K4f3DqNoQ2fFShCJwrJZ3BMDsfuahhpqJQqZlgX7kKGceeHyYzu4RHFEJb/CWZXeSt3UB+NzreQYXaK91hwxstg7e66ZLqe//QDJNoOS+bgdFwwYjIE4NufPaUo2Ocark1ny+gklC0UBmawxWCHufDc3Qqf0vmUQ9cDSr+e7axxaynyqQlUbI0pDC52Y7eWktzdYsm13YPwuEsBySDHGunG4ShlllrmDgEiKj826jEOgts9EMcDMXfvZAvAkmScefYYeWyWBC+mHzRlNFZSYwcoLbNlTOYNBVM4zNYBYxkG5wRzYKqyhEcf9pwSBBvZl1gu6MZtxDr7uftrdCDyF8SBtJ9y0rivDnwmbI9gLaswDzxzj6fuMNpc3D3XmD+hfLZSvad+CniAa0gGj6x2SU9t4wkLxFEisYM6eQf9vjK1amXTvVOmzH12t+D1eHbaxPfMjkz3/PpBe39kAYRhtSFARmMeeuDxXGv6ARAk7b0aRwZ/4ifDbg21BfBINlTuiyxVBdul/1ZW3RyXV6K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199021)(2616005)(83380400001)(478600001)(186003)(4326008)(66556008)(66476007)(66946007)(26005)(6486002)(52116002)(6666004)(6512007)(6506007)(1076003)(44832011)(316002)(8676002)(8936002)(7416002)(5660300002)(41300700001)(2906002)(38100700002)(38350700002)(4744005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cGOQLIpTf0f1RSCFPy1/msBbymAjd6bGsQsQ4/9n2RTCWwXhsmIX5oKJXFO6?=
 =?us-ascii?Q?hm4EvYwhE1Idvoh5Ys0bSSuUiunUj2Romkb7ZC9nLutHFqH/mnIAtC2+pb6q?=
 =?us-ascii?Q?sHR+WDBxt618gMzq4RfA6W0Hdjhw6+aI7W/b7ndGK99uldSvG4R49KffNhId?=
 =?us-ascii?Q?W7B9ld6i+EzlFiIa2Fe+EP2QlmxAnEUTopOCuMZlLhz2WUIiq1ptNEWfKTr7?=
 =?us-ascii?Q?6ypouSUwD581H8bftlcRAg9cLoxLAfEpEsH5rR/LmNh/MgzG2CVY7R63BhJB?=
 =?us-ascii?Q?pZIqlEKWiPsPk9BYqkusXNLT4Kmv2V0EfByp1ikqs2pyMkmeuWWw/5y2kkGU?=
 =?us-ascii?Q?spG+tK69KD29baQ/dz2h0XuxYmIEygH4NyVTw1D7DYzbRxYdiVdUTw5fVxPf?=
 =?us-ascii?Q?qj7a9gw5ZzfS3yf+0yILh3xDXGjJyMFWl19lJShKqL111AJtg+g8U+Cbmtvg?=
 =?us-ascii?Q?PZsnbD8995UzgpGOZ5GNAJ9ahtp2i/BwT6ZOv4gGOzeKH3CEbVaz+b3Zul2B?=
 =?us-ascii?Q?Zzqj/XPdkSsuto3DAvAEfzmmw5INk0igAXFBsLM7fdwJll522dYVNZvJu3wv?=
 =?us-ascii?Q?NEa4+0oMNTHRR3XoJt+45nSp7rz/Fg066z2cm3l1MZC9hFZBlKqMlI/6qnYx?=
 =?us-ascii?Q?E+kX/9s/SNquZF05kZVWaZFwwLD2yASvbCsfyJoVilIbVE9sItVt6pbqjmW1?=
 =?us-ascii?Q?LK37t6MTiqEcy/EE8oqN68+95JA84N4yU6fmYaY9/7U7RpUcVETXr1xmtTXk?=
 =?us-ascii?Q?Xl67nFEGkTV+fSiTzZy/ci+jCjxpEbB8icjzHpHRjPQCvYNxcCqw/WGX6K8n?=
 =?us-ascii?Q?eIO3FxTe6mDCRA/FX5+/LLv1FIyZUE9lUYv0wjeea7haBDvk72MZrblQUTYM?=
 =?us-ascii?Q?5TLrYZ84X8NsuRgbZPGsBWuRWFdxzK1Lhgw6ARS3HIqWCogQTxDXVCgcG4bE?=
 =?us-ascii?Q?uuYrpEA3pVwVVzykiOthdaHty4hcG8t8vo9ROJu5NpZ5r3FcpvOyrbfke7VR?=
 =?us-ascii?Q?iChxzr2pMJMnJ2CENAl0urqON39tGIcOF2SnmFAW4h2oTu24Zd5GvbQauXVm?=
 =?us-ascii?Q?awWPEBy6RdnO6wY1IrPGQhyGPhTDa2Lwc3abt6BLILrxgB0nP9zfuqzI5YtI?=
 =?us-ascii?Q?35sN18Bn1UO8LFW3+WDkzF2WD1YeZGoJM8EWpoizMJL81mbXKAciQQbcQaS6?=
 =?us-ascii?Q?ZY0rsF/pUNRH7XpRH/4XLNyBI1SEhiHVjVJ7KzBA3kEdbA37IePUozga9Qxn?=
 =?us-ascii?Q?jchg+P6sgZK2JIJfpl3CqVjGp691myBa2uJ/GltONNwAxweBk05SDmdO4MRD?=
 =?us-ascii?Q?TCLbZBm0XFL303gPjm3zitrUHrkZVSP2gYOnTx8ISoWRHPdNPlXEcQldgfE0?=
 =?us-ascii?Q?66l8hae3rq1edGczZ0Ue3hhQNPdDcYXBAeVMSdqYjHthT7lBoV3b5Kc8xiGL?=
 =?us-ascii?Q?/K+ms6OTrMTBdYSPsd4lm0tdqO4LaxQ5ubRAAkRFx7+dVz3X6Lh0XhvK/eIL?=
 =?us-ascii?Q?UnLaNbQuVNDa37kf/hXiC5OTAXVU0V8ekdTDmyZC0HGKQDQK5MKFGhirqBl+?=
 =?us-ascii?Q?vIZvlHBagZhFpaXQcSK4FjnpeEUQnW56VDwNG0rO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14831727-bc5f-4cda-c16d-08db4badf174
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 08:11:05.7743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKCiJtbndYjorNl/KJ3DNGOw5fza21V0xVU8QWRkfwvUaj6jimpXoPvXUb8fYHig0Jfl7nTw/MtMvr+PiTXd7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9865
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

This patch series provides better handling of cases where sending
a data blob to FW results in a validation error.

In this case we restore to the last good known value instead of keeping
the data that firwmare rejected.

Paul Olaru (2):
  ASoC: sof: Improve sof_ipc3_bytes_ext_put function
  ASoC: sof: Improve sof_ipc4_bytes_ext_put function

 sound/soc/sof/ipc3-control.c | 54 ++++++++++++++++++++++++++++++++----
 sound/soc/sof/ipc4-control.c | 39 +++++++++++++++++++++++---
 sound/soc/sof/sof-audio.h    |  1 +
 3 files changed, 84 insertions(+), 10 deletions(-)

-- 
2.25.1

