Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A938A65D111
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 12:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbjADLAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 06:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbjADLA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 06:00:29 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2055.outbound.protection.outlook.com [40.107.247.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC827FD10;
        Wed,  4 Jan 2023 02:59:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYZ35swYtRkbrfvPeYuktDA2JLVuK3nx7gyXghYdQrSxepmBjZ0hXUD34dUSWWYk+1aD7XUUtV5eniCy8EWNfOII3UwBpWtNIWk4psgf18DPxUKzrs0oLZajPyxH3ZeYhYjAmtC3Bdvox2jTZCTv4MDqOn3bTWFryoRFin3ZtFes93JYxdpXkvBX3T8/Eczju8q5ifCTDOZy/1wH492JeTY2tZsz4s1L9b/ILmjbFSdxmRFEDctrVtbByaNysktNHy+4V+LzikbO1Uqo6dUI4777nXO3v3T8NlDJHR7xDAplUz5+1O6fEmxf79dI0XhoThel6E0aARjpYw19+wJjyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvuGzmOxjdj59e+G3A3ayOxtYqmunzLFeU/qotaF/c8=;
 b=NUEojnUe1NANcDL6ROjeEdhXw7LvWPzTCs7kNll8m7gD0j9pKO+vyIZAyHnRiNsoO6USNMumiDZQL56+yAESnCiqE8ZXJGPzJS20b0HgKlf1S651qYKxnEsRlHx9HTN+o5k09nv3rdKNjDyHDxuCRK/LcIrzWdzDc2zzxWrR+WWFM10VGxxRxW75MmxhpoJbvOi7/syetH2DpVrql7pZ9DYeWL569XqIuJUensHT8ayTcIDceorRNtCc+5BhpQNDLZFWD2lao+IyAsvVumQOmjxuQmSQueIpxr+8W0J2eb0yZbjg4J2LmoRO2Z3PPlYGvq1IyJq6WzTw+FMurG4W5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvuGzmOxjdj59e+G3A3ayOxtYqmunzLFeU/qotaF/c8=;
 b=D2uvKYKifL/aHtddRjLg7Ch3lnYsczlV9RtINBIx6UZ0//ufwR7XSEYA6ZAqbE81R9kgzKd8aGE95HKjtT28HZR1pnCorcjVWWOrZ7x/taSkRPKLcPkRxyFYoZeO1QIEn3nnFfzralLbb7vkcXGJoCN0jsvEJnapZd9td85L7lA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8440.eurprd04.prod.outlook.com (2603:10a6:20b:413::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 10:59:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b%7]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 10:59:11 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aford173@gmail.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/4] clk: imx: imx_register_uart_clocks update
Date:   Wed,  4 Jan 2023 19:00:28 +0800
Message-Id: <20230104110032.1220721-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: 3133d46e-a465-4079-2306-08daee42b5ac
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mPbDqCVkOtwBbBtOR36+aYaEOMy/KNY3AvlG0KoL63uefMIeGKH+HG4i3Ydasm21/+a3RCXYaQZgo7xLobnGKX+D8ydVHwy/epw9k5sW5BbvEEK2nibNSpaKP+KbJf2bhrKgerjJX/QuVst4vEis/XOhAV42TNUMFnZgCkP9HXu6GO9PkiRq6EVfQZBDbT63ZQDM6WqunM/lDZcfT2n61US8SR2oCGMMUm5SkVGllFNEy6q79pBaG+FcYwUdOOpX2YtmHFAfzGnLOqdNABnljuclHlpqjwn6eStLinwNK9wzoqob/Pc+JmQlon89rZsPcwvHY4sT7cVfShr/bWRR/WfM7MrDvlrvxz/h7cweRpKPBbM8SRi0PIrGaaKDnlpg2D20ad5gs8DkWy1n74B2HDmStU3UoQNBhL4hOxMPNooNZmcmynt/94iL6zMHP1AMQzSWPgrLWyEP9cOBmh2s3DeQReIRYnfLst0sbc/Zq3f0+I9+KU6FgU9FMMDQ0TKjFGa/EzBddj3bu7bPTgKB2MvxxS2lJTLD9e8PLYtLdKYmw2qtnqFSPKpsHC4j7MqDPfggMlt8EWHvD84T2CbR9TCCldYWjOwYBicKYu33YmfYPQi244gzhxw+ZFFALpt9IXdWEOwhJvgYzMYBPwyqrPGdMB+1I4JOpsmm+HY0Ad753lCzwUABZBmUhna1VThd8mi4A3LI62xxoepY63N+xQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199015)(6486002)(6506007)(6666004)(478600001)(6512007)(26005)(186003)(52116002)(66476007)(66556008)(8676002)(86362001)(66946007)(4326008)(316002)(2616005)(1076003)(41300700001)(38100700002)(38350700002)(8936002)(83380400001)(7416002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pv6kNPUR1NQQVqmUz30D716ODMZ5Ntti9nm/XNl5Xbh3aMScOxNgH56ABbQ+?=
 =?us-ascii?Q?pwNkMIRX+d2wlSXcam/uQ45Vgaq3buhdbDHgXlr7TDMAPKornjBypstYK+F2?=
 =?us-ascii?Q?U+KcvwUdWjErvS9VGul7Po+31RDllr1Sztqx9mKhO6JDD2A+Y+XLR9ZmphH+?=
 =?us-ascii?Q?oeCNscznvSjHJigjFi/KKXX3+QqzYPhAo5cbn2Maw3ztULPiIvFsRzDELV8N?=
 =?us-ascii?Q?/ojXbC0P3diyTeoQYiBzuMSTsMjDr5WF97QE8SkWdgFmsYZecQIgQAoBg5rl?=
 =?us-ascii?Q?C8jNuEyAbfp/UVLazoqQJ42a2jbqE7sgIoihjdHC5xM2/vqnLqu1fCyuThsf?=
 =?us-ascii?Q?rLu5wISs4t51ikL0i9I2e5qW0NSwWlKHboBgDHMpbQM/UrU2TrickqXxSlKZ?=
 =?us-ascii?Q?NAbrFu6iB/5mzdgLhbxBgnrJEsTK6xHP2vcZ74ZpSlsedxSc+GGuO4/W+zwn?=
 =?us-ascii?Q?iIU0jG8kpwJegcLekK9vBx8fbfQpoTCdLc4TXirkkdrFuRU37lCyL3XPqny5?=
 =?us-ascii?Q?dEc+ym9BJluZSzlkvwk+1tVSN2ltHksJGN6jvLulVL03FQPQipDBoBCUCDB5?=
 =?us-ascii?Q?U8E5fNseKnAmH2ON+Bl5d3sQ4rJ5lZqc466+2xUOC7f95LgWUnjWrKJbVdm1?=
 =?us-ascii?Q?XS3DipWoCdmyLtMv5I2yQSAFggRXz7wvq7gIxTd6OE9T8O+8jy+FLQ0z277Y?=
 =?us-ascii?Q?vLtbM98HQG5sKjuGLAd5WhBmPunrhYYKKqMmTvJCrinlwkB608f+QbpB8gB/?=
 =?us-ascii?Q?WV83U7H2Vie6P9uwKLIYYcp6E9NNV0qTLHMjIY4B5He4j+eO74wOTzqFUijO?=
 =?us-ascii?Q?L8lHJPggtvAzeS9nGbHsGp3Gg1LDsyCobk6lSx6bk2R1Y/K+bHq7aeMIGbkK?=
 =?us-ascii?Q?vWXVYDgJVSORTi9gY2MAiRwRKYLtkMnBpOTxfbccuqIm38zy4vDZz50xdDg4?=
 =?us-ascii?Q?9U3pGsWVNioyS5H0QTgOiOSGQMKNSxKYlU5DY1UZr/k2oBpEFkIKajk+tPy0?=
 =?us-ascii?Q?CLTEDAuMi8Gyr/cxacCZ3wc1lyShOQrbyhNo9EdOV/G4B01MWNG9xCibzpsV?=
 =?us-ascii?Q?J8TzBh4Y5lVnwEQfaxnx+q/abk9MuEmOvEQlqv/4PCIDNVBaAY+xthv3hEPX?=
 =?us-ascii?Q?xiovK6B+RUE10aJzNY/oPaoE0FhoI9NQfhohv5OL5ONHM3V9bF4n25/Uqati?=
 =?us-ascii?Q?AzK927rc9yPutPQfJyUXZwbU6ad4HuvsbxnWVr3MtOhhVH/od7ypWxBs+OaS?=
 =?us-ascii?Q?ikC5Rd/TH5tF3YLTPE23Q+90NGPi+f8HIQk7fBtjxJ8d6EGTUhqxMew3n0sr?=
 =?us-ascii?Q?vzc31jf+/zqBq25mVYFoR1kt2o7dIZnNHK3OFILqjU4U+FC2of1bDZcdpzbL?=
 =?us-ascii?Q?6T3ujgntydHXXGG88reVNssHOKyMl0+FdNlWA56SFxty0zhJIjyEthiMcPBB?=
 =?us-ascii?Q?CGOmmTskC5XWBlfJ5xZGlY8FSRPWQkzil18MLSmKMTGf1OWFT8sKfi9/bRCN?=
 =?us-ascii?Q?a4bKn1mdSkelTOKLHh6R5yqQl61jxj3jNMIUmhpWcKTFVW4B+6w55N5g9nyo?=
 =?us-ascii?Q?4vYS3CGOnkcr32M+Rr/Gf/xL5LsgMK1XiwFd8prC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3133d46e-a465-4079-2306-08daee42b5ac
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 10:59:11.2992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAnN0WqY6J4pUInbWYiI1O/R+U0z/C4rv0/IJnBht8P+k1te3gQVwvxUIyv0R9AD16AuctwnjFrbmdxHAEEVOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8440
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This patchset is to cleanup the imx_register_uart_clocks usage, and
use this API for i.MX93 clk driver.

Peng Fan (4):
  clk: imx: avoid memory leak
  clk: imx: get stdout clk count from device tree
  clk: imx: remove clk_count of imx_register_uart_clocks
  clk: imx: imx93: invoke imx_register_uart_clocks

 drivers/clk/imx/clk-imx25.c   |  2 +-
 drivers/clk/imx/clk-imx27.c   |  2 +-
 drivers/clk/imx/clk-imx35.c   |  2 +-
 drivers/clk/imx/clk-imx5.c    |  6 +++---
 drivers/clk/imx/clk-imx6q.c   |  2 +-
 drivers/clk/imx/clk-imx6sl.c  |  2 +-
 drivers/clk/imx/clk-imx6sll.c |  2 +-
 drivers/clk/imx/clk-imx6sx.c  |  2 +-
 drivers/clk/imx/clk-imx7d.c   |  2 +-
 drivers/clk/imx/clk-imx7ulp.c |  4 ++--
 drivers/clk/imx/clk-imx8mm.c  |  2 +-
 drivers/clk/imx/clk-imx8mn.c  |  2 +-
 drivers/clk/imx/clk-imx8mp.c  |  2 +-
 drivers/clk/imx/clk-imx8mq.c  |  2 +-
 drivers/clk/imx/clk-imx8ulp.c |  2 +-
 drivers/clk/imx/clk-imx93.c   |  2 ++
 drivers/clk/imx/clk.c         | 17 ++++++++++++-----
 drivers/clk/imx/clk.h         |  4 ++--
 18 files changed, 34 insertions(+), 25 deletions(-)

-- 
2.37.1

