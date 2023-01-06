Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5087D65FA60
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 04:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjAFDlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 22:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjAFDlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 22:41:50 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2058.outbound.protection.outlook.com [40.107.247.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7CF65AD9;
        Thu,  5 Jan 2023 19:41:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6rIcn6wQHXRswH9xvstWDPQ1SL2Ts5OSdRNou4g74p65dsem61nxFsbJXMtvcTtiEUhseDtzvzN3dJIi78luJpf++xeqIwjJIiEHuci9EN/L45ZA+FkQdh1O+45SMXvIBxGFySwzABCg/akuyY+VYaIE1KewFxDYwcjbmlHu4MjVww3anPyOHWzTrRSkwrgTA2LX4EMu1b28bBPK22ZPyOHTgDN9Hm6GNpAXZdhYcG99jpGFlGkKaAOhL6i1EGKzIc8DFNTMRMo34Wt6sqGnwM87kCX0IqE8MUjyt/sOgzchAiFPy4bX7B6QLaBWvORG7JXsmWZaJ0sl5CP994/8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXNz04N+YZ1vV6z9yFD5LK6MHEb+Z2SB6+/KtShgH14=;
 b=n+i3iEbXrNX38a3OdywkLVT3+vWVCHqnK/7ra44hnCOA7UkCygyRTxrzzKJwx+coeU8bXd02mdZOFHaxV7sjUFvJadnXPcm0muSvrs+9IcgPlZDmAKZ7tmvctthv8ijVfcqCExUs9vYS3vSwrZfgswJh4jmRlkC7UpPcC9UE1z49qzMPDkmzPJyOENgZr0j1OfFrZ3pdbgyTaPo6gTQ8vc7V395Z7kTCIWxY2H1ewZFpAma6FkKKe7fAL8xaJPHZP8/J6Ajto14EhSr+usezOuZO3czoW8OkXji42L/6QuZThZ3kN5kdME43jFuYZjwkYXzFWD5RoyMzTLaJq3y4aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXNz04N+YZ1vV6z9yFD5LK6MHEb+Z2SB6+/KtShgH14=;
 b=haqhQ/8AbYdaZhHM4kWC6LJB4Hlx3WPv9asxSCo27Iuv8zjTllIhUkuzwfbxiODPhOsCH3zdqUdUo11+wrOx7/jcRli9zqwjhSTWY95faY26p3KLzWRhZT3bp7VKRbKjgd8PO6bCOts5nSteMaRa/8ogy2+MaQoChvhTe9wsYiw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8480.eurprd04.prod.outlook.com (2603:10a6:10:2c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 03:41:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b%7]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 03:41:44 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        arnaud.pouliquen@foss.st.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/5] remoteproc: imx_rproc: support firmware in DDR
Date:   Fri,  6 Jan 2023 11:43:00 +0800
Message-Id: <20230106034305.2868740-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 94194c9c-b7ba-4e35-6aa7-08daef97edf7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EzztcMcLyPimGC5I2zzRejhcmPcZgmsOw2SdIg5MrdL858hjm4e81MUw1KQYtSFp4FXU4DcZUhdy0jrhpGyLWklEIyu5LdmEnLxxpCM7kBQXdGLpoGIYT6KUu4R4WrWjta6tB5oIC+uNFSyJ+kx9XMX4C379T0y4ltNswiuAhrFnxuWkPLfUF7o7LMD3gB9bDTimdjd20ADcUaqKI2Eq6tsxDTZwdXkmNhkquzUM7IG3GmNlxcSaL2allckCBmY+bUsJGPa4VRbwLJRLJOvxoDDmGwpY23O3Su8g92Zh8fqJmFy2PqLTtprNOTx7rqKQntoxk93pfY0RusTU5Thw1lx+9kbLkl104Z+BvDEhtMWJJBLhNlxB1PebS5s17w+FMTIpTGXhibQQ9zTzt+9yG4H4XA/FhUQDicCocgwv86otvPHnhC0/x82k+RJGWSALsP61/CoP3KYajqfHiAhjH7B1cc7F1xCSgdFvta+PhzzFid56HrjcQwjWYYEGxEfN6H5pMN9n+bWohnqgAROhjyTyWDjKu/rzXwETY9cfhjj9dtXVMfSLcSMUaI1uUM/FFm7b9L33K9fi09ZybnuPJ9stemMHnFpH/fESZYx+MSbaqfySSt126rMyWKi7RXELWFFBT5j8wxjAM9fDOoo4GRiWYLs5ktTxigPws/0/OuqeHO6jcTta6STkR3D/+7Gj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199015)(38350700002)(38100700002)(6512007)(86362001)(186003)(6486002)(316002)(26005)(4326008)(8676002)(66946007)(66556008)(478600001)(2616005)(1076003)(66476007)(52116002)(2906002)(6506007)(6666004)(41300700001)(7416002)(83380400001)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jRs4xBXlmsZY3DUhrzIZjKNUGEKA6jML1Dtmv0Vci91z/xfR+cSD+DKVB6nM?=
 =?us-ascii?Q?B0F1EvuZSETOvwJBy+iWFfiTUsBoQE7sVdLPt7YOyjWNVGhI421oDXO1YT5k?=
 =?us-ascii?Q?9keewNqoa6+GyXvNm6PeeU24/Jm4YP96NsVOrB4nyTH6+kX5hEBJ4sDy+IdS?=
 =?us-ascii?Q?DQBjjTgIknnCnw8BuS6OiSW+alhqnugH+ALNKpoMOeFIU8Q2y4xVxtnvY+zV?=
 =?us-ascii?Q?sAS+OD16Eco9E6ey+p/MbVwGzCafxDyz64i8u4e57cuX4J8vqtUctd0N5Uat?=
 =?us-ascii?Q?U0TpyL4FY5UOPnb85euwBVAExC2TWXXB+nj8ypLlka7sEySnyD0Ul8bX1fJv?=
 =?us-ascii?Q?v7JxNV6NScpTZ8FXY0CS+GBSoiDnlgB9TCaRytaJOlPjQ4e+NbSYPbNLxkfU?=
 =?us-ascii?Q?Vk8TZ3Pa+keWPu7Zrw5azyREkg+HOclkBMnQiPeWqUTEaSYvJCt8IGirr1zv?=
 =?us-ascii?Q?rxbYRQUdDJAo3CdNQeedibs+PxvYqLB5wRBEbyuJBs8XDXEaG0RLa3IgtdBz?=
 =?us-ascii?Q?ZJJ+Gr+f4PHue9xI3jnhtuOxpn64eZuJ7zlk1VJFainY3zWW/98L8v2Twy4y?=
 =?us-ascii?Q?dZCsodSKiIXhluYIdgfqG5M9gEf/Z43bkPMk4DBeYeaOdRbzejPFPsvc4AU3?=
 =?us-ascii?Q?1JuRtuG2HJy++isqBrc9vTbCc/eTrMyUtV2hTgwi6Pcds8A/ba5IdrBVrsna?=
 =?us-ascii?Q?BPgrKw1SBm1JW4yzsPkQkcKcVemn8CaeZhVdBIGtGo+tW7Z+Js1du4dh5EvE?=
 =?us-ascii?Q?fRG2sM2EWenGmAZ8y/5jnt9gXimOwLLQa2RQeXjgJCo9PrRqugIIvfa81KwZ?=
 =?us-ascii?Q?fmA9pBIYE+hvB2Jh2hOScQJ930VOv0ksjbEwbf0pNxbwM1HEqaHbv795sit2?=
 =?us-ascii?Q?7Z/YD04S7ZCcsAsEpJ6YGjK56nGFisNFtSKPCpqEiGTG0awMrT2WTQ5Hz3Z8?=
 =?us-ascii?Q?nolmWVM5A59QN7cR0780Cu5vc4TSfqyH1VRbGLSRGflxBvkiGQrhl03Xh6k3?=
 =?us-ascii?Q?eep7F69HCzOwPWb6f+IkMgGmyil48aL6w6mgBaqWBNXwDnuUD5rJEBahGK0J?=
 =?us-ascii?Q?yoDByWnmWLP4GQfv1qD6lwsaUn1WbFH2peEz4sgYskW6YbPg3cc9wytO7qYf?=
 =?us-ascii?Q?5lXjahRavVVb0yVFHrLei2673hxzvCyDfnBEpGJZBtUUGW5dn2QUpvoTt0WD?=
 =?us-ascii?Q?ncfyXR8NCLWaS4SeDc1qUkJQjnVlJ3iq13RNCuCSWGKY7cy7fEHAwWNtATPR?=
 =?us-ascii?Q?8HYuizaeOd6Cg8rXt4AZmRZLvqvWsjofXsh4S5IM89fDYUQdQiuIM151Ph6P?=
 =?us-ascii?Q?VWlPg+OB3q8fxaytFPm9xXgNjMNKOdMbTzl6SfWOtJ0T5AdKOQJlGXj/fA//?=
 =?us-ascii?Q?bLPbWEmUSb6pBFdapA5/md88IzrgJmzHYes9LnLuID/pMjD3GDx/aceRBg7Z?=
 =?us-ascii?Q?AMsVo8UKcu3oQ8IR7ryc76Y5SCh3iRBSkLow/aPY+XWkNTKcHld5ZRYh8QP8?=
 =?us-ascii?Q?NFJe0uCswhNqFlDzUtqwZS9UV8fXSL4AYWizINukqx5zFePUknxJlbVoZom9?=
 =?us-ascii?Q?2vajQkgJPbAfZbqVwpqr6mzN3GYMdEe70MlKvhId?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94194c9c-b7ba-4e35-6aa7-08daef97edf7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 03:41:43.9736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Se6yNtFwUMnnm7s1bWhMdUPq54aHA46JS3r2RFJ5RXWBvLT8dJsYgB6HjOyUjz/hJzwMbU9EsfIoNOZA2VLS9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8480
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This pachset is to support i.MX8M and i.MX93 Cortex-M core firmware could
be in DDR, not just the default TCM.

i.MX8M needs stack/pc value be stored in TCML entry address[0,4], the
initial value could be got from firmware first section ".interrupts".
i.MX93 is a bit different, it just needs the address of .interrupts
section. NXP SDK always has .interrupts section.

So first we need find the .interrupts section from firmware, so patch 1
is to reuse the code of find_table to introduce a new API
rproc_elf_find_shdr to find shdr, the it could reused by i.MX driver.

Patch 2 is introduce devtype for i.MX8M/93

Although patch 3 is correct the mapping, but this area was never used
by NXP SW team, we directly use the DDR region, not the alias region.
Since this patchset is first to support firmware in DDR, mark this patch
as a fix does not make much sense.

patch 4 and 5 is support i.MX8M/93 firmware in DDR with parsing .interrupts
section. Detailed information in each patch commit message.

Patches were tested on i.MX8MQ-EVK i.MX8MP-EVK i.MX93-11x11-EVK

Peng Fan (5):
  remoteproc: elf_loader: introduce rproc_elf_find_shdr
  remoteproc: imx_rproc: add devtype
  remoteproc: imx_rproc: correct i.MX8MQ DDR Code alias mapping
  remoteproc: imx_rproc: set Cortex-M stack/pc to TCML
  remoteproc: imx_rproc: set address of .interrupts section as bootaddr

 drivers/remoteproc/imx_rproc.c             | 52 +++++++++++-
 drivers/remoteproc/imx_rproc.h             |  6 ++
 drivers/remoteproc/remoteproc_elf_loader.c | 93 +++++++++++++---------
 drivers/remoteproc/remoteproc_internal.h   |  2 +
 4 files changed, 111 insertions(+), 42 deletions(-)

-- 
2.37.1

