Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8246161AC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiKBLXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiKBLXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:23:30 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2072.outbound.protection.outlook.com [40.107.105.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79797D2EC;
        Wed,  2 Nov 2022 04:23:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hb8F+opIUe77kPNzDU7DZrdZASMvFjj4DKzY9Sc6MQj9EdOVHnx4CVxzFcbocjW33DeAkrlCprFA0NSl2nDQEr38TaRL0ayBuicVBJ2zg2lRN56QxLmfhjMgx+0ezpN/DLROBXeCZ/ybcXZdh11qVk1x2HhdUUp6mpXUR/0ik2YN2QXcD56VDYcsZt6+kDiT6b2ozM6lHIhdmnYgcvxDKvzscYcyR9U6doIjQiv3bdU297FasDeA5CQWFatcq3+QZNgbQmkHj/hfTkMk3qKW8xCL7baXkw7Ghc8zXfabFfEz+TXuiBZw7V4/dDRLWb7v6QDS+pV9LMfzrheaQVPrjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWlNtzCdAWVrYve5om23lHn1xZc4+/XdLwo3T4eWn10=;
 b=JxnwUVrq5IrdR7+w151RXDuMC6wnndj/ieeMZFdta9auEm9yg1a8UhYFpVZGIcFVSdSBO6b2Y/VrVdXkn9fnxmqWXB/PH9ufvOXoD2DouGQmhATSxwGLEtshoxSFKvWQ+NXGB+x8TkgPayL2DLmGyaljq+5ubQXEar53wrAXNh2Fuiza4vG/brIgglZgK4Zsz+++JQNnPqJzt8iV9dx0LI7Mp5mI1x4kZaNwOvOziWKZZ76f2mhaHLw2dfLIsXeTP8Vi8ouapV1NgzJ21EcEJFZO0DHdp2OFqSa3IfAnWRsIujF2QCfkHW1X88rpviYt/OZMWxvf6t5UUrXdyRGFJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWlNtzCdAWVrYve5om23lHn1xZc4+/XdLwo3T4eWn10=;
 b=cHzNW6a8JoDYpaOPtjRh0G0krV9rcfvIJZ0Wdd5UpoaVO4WUMx2O9B0y1jr0f9gFI6UFtj8upIOS1C4CX1FHQJNKsynevFL6Pu+eWbynl7860kwG6flb7nRLU/0Ck8taUZ1YCxDm5R+ttP1YX7f7Wh0P5TiPyyu8NVu66pCWJAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Wed, 2 Nov
 2022 11:23:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701%7]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 11:23:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/2] remoteproc: imx: add start up delay
Date:   Wed,  2 Nov 2022 19:24:49 +0800
Message-Id: <20221102112451.128110-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: bdabf21b-d6aa-47a2-77f1-08dabcc4a667
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9HsNYV5saarPMZsZVFKcz/SVlfeiToF0WFH0Gi0LS4XTiX+YjsAp9DWW1b457sJnROlmxY9GXv09TieTmujA/6tiZXOVJK1+6HJRMHzjzMzNx8d0Ircbw/m2X+xyhYDGybWZDx7QtMiA75GoK4uRhcqNgSLSSGBH3FmUachsLmKFqUE4FImwv3W9bghRAd8LtT/1X8G7i0ftGp2vKeGHvbeobDHACfCmONzCIxiVIC+0PQLn8prITtBVizexsYteaYqh2hq+EUC77f1jZ3XB4XB9Q4GR947UGbSiFOfX0Cw0q9GRZi3HIUYnb/dDWO4xHJhci2+eRagdy41Lls/RbWujgHpTXwtQgsuDua3EEFMx/9YfY6zTsFsDymfqxBnmOEesP3dWxYauV4um6Fem5K/XYu+uIdJRzCNnBHf11y73NEVOdfSWl2pySTq4VvmpPcDa/azcLESX2vzjyiZbGisdExxiO3SnTUH5Co0hyju8G6bf1MH7xhzmg24j8oKs+wP+mLr9TcgroTQgDRbsvrmM7+4eoCDuXDJ/C4Fy51omczEqsBbzqP07jLuVVcHjCWrOHMfpDQQc2jFXNy8sDETzc8KpywZyZYpPNOOb8RI54Zs2ApR2UeyQ7DoBReLRupPCMCoDgBsnucNhpbqJ7YMgykOyxI6f/Jw/iHcpsJ1+T4/aHWHAJ59KB9SD63VYpveAGDfU9Im3F5AeT3EiOxpgbS4xmyQsD47lArW215QEohk90HjzWIaHF/obclar/x4WPxA6PqvmSe4dlldny0gTXc3qkWFZqGUBkx0urxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199015)(6666004)(5660300002)(316002)(2616005)(6512007)(86362001)(66946007)(1076003)(66556008)(2906002)(7416002)(83380400001)(8676002)(66476007)(6506007)(4326008)(26005)(41300700001)(8936002)(186003)(966005)(6486002)(478600001)(38350700002)(38100700002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3ScyI8QBEg3UOWlvcfna6xXN6zJj7zQN6OfYM4M/ICQP2pCSqrGru21qDPVD?=
 =?us-ascii?Q?fPTO+X8L+6UmsF6Z6lOIzNSTd9Puv1xkYxTZx0E6UyUK32eE19M8UvNuPrRN?=
 =?us-ascii?Q?4YOPY3efQ84dlB8jD5WvGjbpLqWi9Hh3MdBT3qez1fVJejxkvmDsJosx6AaM?=
 =?us-ascii?Q?vWoYLkMFA+Csk3c/nin41hjaOsp7GmwSKHEJiMXBOKFNLpiIWAV30Yn1f/i7?=
 =?us-ascii?Q?leo5cUvUOXmCcVAsy1kmRlmE862gNsoTYxgvDCr+1vUyRVLdpmxDIAk0tC48?=
 =?us-ascii?Q?pAMzKwoGitTIRMQaI7xosU/XVdfdBfGP4/QTw+vllxCg2mw4G/Btjt+o1Tmj?=
 =?us-ascii?Q?FWe59SCnFEfkBmfF4CFpOoPhcHh4lDyQ4rssQQPRjfeV8uJ271js1ZqFhH+d?=
 =?us-ascii?Q?EWX5Y/zlL9Eq+TcTEYjMrKgJVV8JON3caMY13gAiij5vXbyM0aq86RsYomMj?=
 =?us-ascii?Q?Q4W8x1YiLAZFYfAyLmBl69mdeDYGwcAi7p65Z3S/xtTlnI7L0xPNZpFeag5a?=
 =?us-ascii?Q?C6z08+N1ZyI9rm4Ep6/T7JlzdiXZ4uFuZmlUUxhy4TFv4QwrHV+LBcShn3q7?=
 =?us-ascii?Q?Y7LGyHVh+uw/sUqVvnjRQh4XuvEJYLXJwlcMXJ8ejwoxLfGa2cEmTb76UtWb?=
 =?us-ascii?Q?eEjCkYPTF1+jGAaJqL5VKGsS9BlDUfnol+yGF0sKeVb2V6PKe7aYcLZ7MEav?=
 =?us-ascii?Q?pyKPflLAIsZIbFUATkTs0CV9sdC030xHiE8PpmNNI1aDHLL+DLWBMopLe0OI?=
 =?us-ascii?Q?sLBo410qiFmG+YHGf6Y/QKtYN5JQZhZ0KRCfNt1RXqfWbG4njdclK1jRchtY?=
 =?us-ascii?Q?xENStqyTu5WcqIYSvm9+y3l+3U6ftCRyMQa8bdyqAIJrk0AZF8X+kcZt3lsQ?=
 =?us-ascii?Q?e5A3ftljYEaemzIUOxH/HrCDY+AH22hgzXH4qQr9q1IVFe7GWaG3q1YaLDn4?=
 =?us-ascii?Q?d4t36ePfUgwj+yiyzIhPsd7GAZ4qRkT4JaZbsZZPVo2S8ZKSWIACNcAxHP3y?=
 =?us-ascii?Q?6pEnLYMsIeihkS240yHbmN5p50R5pxfsXx7qg8LH4BfY+2rfRwOUW+8w9KNr?=
 =?us-ascii?Q?7GjvSC/j2AXqg0zxTicYeIVa7xNkqLdZAthTzB8PC2yqH8lae+tcwJLTnslO?=
 =?us-ascii?Q?2T4ANxtc4p2e2xvDgrbZTTRMjQaw8VXGUEgN0ppE2GBmw3RTtkIznSGVArWa?=
 =?us-ascii?Q?K1GPD77UkX1GfsMiYvmDbwrPiaHApsfu0g1HW4O/vBf+4b+bt2+6OHhCyFYq?=
 =?us-ascii?Q?zY7ImI37GXp8/9XEB6BdxgemK66MCwRBkQ6s/MV2tojiPVAPWp2GLVJlauou?=
 =?us-ascii?Q?nPvLyq9b494PMH3TwYw3D1EgCQshn8XZPzyVMIbcfdkfNrpXp57gVjgVlDxc?=
 =?us-ascii?Q?OdN8sg5snnaAr67qLprTFaZ5aS3ML9Wl0KuuCCu8a+ArBT6nQasJIvQnqIF3?=
 =?us-ascii?Q?pTcwf/7YG9lhzuXO1nGKonGO/TXQK88BMzpwJ6IR9Jgl6Mk3YYtESlaiPl41?=
 =?us-ascii?Q?IyB+JPVEugtroDlJLIzGdyunY3mM8q2VuxQTHOCobz+15R7ZlWEzWvhzJB48?=
 =?us-ascii?Q?nfparZjPlkkjD76fJr1vrvH0xqtSYoYRZZW7E7/H?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdabf21b-d6aa-47a2-77f1-08dabcc4a667
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 11:23:22.1350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNOmHgJW5b4VFc43Dk3SoIldO/FPj3Dru0AiSTTixfgIRv9PB+/8Sku5liktrDHd2rA68GFyLUp4hyclizcreg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8344
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
 Rebased on linux-next

V1:
 https://lore.kernel.org/lkml/20220609123500.3492475-1-peng.fan@oss.nxp.com/

There is case that after remoteproc start remote processor[M4], the M4
runs slow and before M4 finish its own rpmsg framework initialization,
linux sends out vring kick message, then M4 firmware drops the kick
message. Some NXP released Cortex-M[x] images has such limitation that
it requires linux sends out vring kick message after M4 firmware finish
its rpmsg framework initialization.

The best case is to use a method to let M4 notify Linux that M4 has
finished initialization, but we could not patch released firmware,
then update driver to detect notification.

So add delay before linux send out vring kick message. It is not good to
use a fixed time delay in driver, so I choose to get that from device
tree.

Peng Fan (2):
  dt-bindings: remoteproc: imx_rproc: add fsl,startup-delay-ms
  remoteproc: imx_rproc: delay after kick remote processor

 .../devicetree/bindings/remoteproc/fsl,imx-rproc.yaml    | 4 ++++
 drivers/remoteproc/imx_rproc.c                           | 9 +++++++++
 2 files changed, 13 insertions(+)

-- 
2.37.1

