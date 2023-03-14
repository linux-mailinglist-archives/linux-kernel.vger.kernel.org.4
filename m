Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FC16B9991
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjCNPgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjCNPfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:35:55 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2041.outbound.protection.outlook.com [40.107.14.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B0197FCB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:34:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2moNVOv3A3Lc08X3LNexfxfkuac3OLX5voPpQ1lN4cnEzdSqokRkPiIt+j/nUX/ex4Dgm55oSwzNfgtJjVqAH8zoI1xNX/uh839G7b5EmX7+Id8eJbGjKuY2Aem8MkwwDVMaBB+bjHVrnPBD0opnVthuAN2vTmBrcSG8JilNhydbvjvl+u50BFioz1hJMQEoHaUcOqA+8qK5MR2cm33bal88vhM5uIXMXFs5vr5eDx1mjVGQDln+oZVcMHNQUzhGPJOzO7I2D+8Vlyk5w7QUt7/uMLQRh3ox5MYXwKRqmvWoXJrB0CqivCUfG80+zEeyY2xKA/iFLCI3Q4f4wBuyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oiEE/Se8r5+8USjZJ3+s8fYimwB6HJy4aLNW7gkBhU=;
 b=FWGTVB/6kqqSa6zhY+p0Q0775KRVM7hXeHgKwm4rt5PxytK75Rtbf5pU0ruKT8KmqLVHbJzBnyJ/Vc72WKIkJT/Lf+PxG0KxjqCBkgY5IqBkVzeBvxXsIVqGYvOU1JdtOtXRJJaWXqeoy1hU6M0sS2F2uK0MUcR27tar3jmcjTrLz0A3L0TcuHyP8lx6bMxxPvEbBiNU2vuBNTGnh8Fi9Txtou2+zwf3Wvx6651ds/9aSdsCDs5n7nfD5xXxG6p925scoB6iEK2NRcfDHB15VM9qZH2z9azfsK22mw/2Gj0KmYxzJ7a5kdJvqZM53x+f9v/TvrJePFydmTAVRKkABA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oiEE/Se8r5+8USjZJ3+s8fYimwB6HJy4aLNW7gkBhU=;
 b=WTtW9iMbCgx/eRqJlIamFN6l5WS3n+BMKI428oZ2tf1OZybCodl2436ZrlbH+o4zCewleTvciS2wzof/tIgbQiVMT+9TNULFezjPm+x42niVhdawlss4dcEVgas7Nqtc/WsNf6xAw1dJ0dyHTpxUOGAlNt2G42UDAK1lCgDq47g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by VI1PR04MB7055.eurprd04.prod.outlook.com (2603:10a6:800:123::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 15:34:24 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::f922:7fbe:d027:5597]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::f922:7fbe:d027:5597%3]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 15:34:24 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     lgirdwood@gmail.com, kai.vehmanen@linux.intel.com,
        pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com, linux-kernel@vger.kernel.org,
        daniel.baluta@gmail.com, paul.olaru@nxp.com
Subject: [PATCH] ASoC: soc-compress: Inherit atomicity from DAI link for Compress FE
Date:   Tue, 14 Mar 2023 17:34:09 +0200
Message-Id: <20230314153409.1805280-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0213.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::34) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5151:EE_|VI1PR04MB7055:EE_
X-MS-Office365-Filtering-Correlation-Id: 026bbd4e-fdff-480a-1bb4-08db24a1964d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nbw+P6F36dyaBNpMgjMCvrlk2dx96F9nT4sv8GG82e08NM/X4hjt/Xj00O0k8faSPHic/e4zPmW+aBXJYmOnapnQKTzo1qfqTFBEMV+qxpQSXqr9k0dbrdsMeNjoPjuqVIcJnkkZkoTzsI3nQFOt6aDuAatXDsbSR0MmSXS6WTnA6Ri5RoXlmmhq/T/iCHwD99HMtjdX0s1b3Qh3AEHmtcnNtam2s+fGsj0WzgEmnBR6s3eVi7pD8HtDmqKA/9+MPB1JgPfxLVFmw4zynSWveZf6XbQPxhwE1TqFuM4G254gKNU9uT0BKu7vxPc/CM8OYLJf7OViKaywAeL0vx/B9FzBXZb3admoh+HdfTky49E9WHhwVxAvwnPGkmCPYlKkJgjjDgsx4WumBEz9J4noNyETIoiz/6hAwf4+GtuUKbciLhZDmIVBylDdoFr1LdA9BZZZeqre1k34Uw4GiyF6CLfxd6GZJ6b6QpwnH+eIFus32kMGbF1/SRbF+Iv0wzud48Qx4VeSTMc9ktiXwVe6S0n2cwvGQ+Lt7vZnERZs9gXJgpR6UZB+OduXz0nbit19s7tatAvb++cfjQdbraGw+iWh+YQ0r+yH8NTJbYY+ErV6VBsW/PdIkReOuR0vp0SqQ13vbekH03rNUDdbdsjy6oN7V9lsG4/6TtNa87Yy+QuVOXeT9epytRdNzKmkYl3rlNVld/kNEfyGUgNOli5T3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199018)(8676002)(478600001)(44832011)(316002)(66556008)(4326008)(66476007)(66946007)(8936002)(5660300002)(2906002)(41300700001)(86362001)(6486002)(26005)(6506007)(6512007)(1076003)(6666004)(2616005)(186003)(52116002)(38350700002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ess1RHlSc7zim2bNerSXh5cuFkzLVPIRAxkmoAZ3N51OEof56c6OVWAy1+F5?=
 =?us-ascii?Q?/OuAg+EONpVNNH/BwiGdEHuuZzVdLZT/5pUmhVj2vRi76j506wkRP1k61cwf?=
 =?us-ascii?Q?MxL/MrvFfmvFFmrEzL9VGEEoYkhhaQFvJHMFaHlKyQS/NAMHHdfab9puDAn1?=
 =?us-ascii?Q?Pf0zqaBQ/tHxke0NQlYgDqAwC3Ge+zGBrXb6J79WbTtAfok0DXlbKdu6t3kP?=
 =?us-ascii?Q?+5eJIxjdIA9xXA++c2s0ERvagRH4KFUo+ja4zPpTOHxfDy6OQg1ZQS65JFeW?=
 =?us-ascii?Q?ArQp1QxdXgRQfCEKpFephv0k641Yn5ikCzhc90PaHt9k5N9aB5ylUMkHzVdA?=
 =?us-ascii?Q?50KxtaWTcBq9QNnQOobolM9zpPL8M/mQoCrqgSDkgDa87uSjCLR5TUERWbRf?=
 =?us-ascii?Q?LbltWN8W1XCTZsJ+4409s4bq8fpWxvFBMMNYd9VntLZBzoHPj2l9Gt+bZjp0?=
 =?us-ascii?Q?A0Uj1w/RxXyf3XiLybYqUtN5b2a22mn87KTKT5ETivzKPeMFZ+ZCbFPvdQTW?=
 =?us-ascii?Q?i27Ty/JSSjH87sQU4s8NkB/3bK9BJzC5WukduZ+2xObn4zsBOdl2+LYm/ver?=
 =?us-ascii?Q?vdfO8GgqVm+/m9oqwoqVtSp5kL12waNk0dDyK8uniJg+U4hXYXTb+lElacIX?=
 =?us-ascii?Q?j3OxXgXyeVgeeJkqKkUyH/Wrj2nsEu+pvq9v1Figs2y7wVlR5BCs2DHgkqif?=
 =?us-ascii?Q?gcQrdqEdm1MQRHpN3iJcrwp6ZEjDjqffSpt6eCyAuvEUvAUR0Vgk/aHmvwAD?=
 =?us-ascii?Q?3ndfSHHQj+5SGliwjiLjUYDawTS7XLdq2ESOZ4JoPZrGYsts7/wR6pNTNo4+?=
 =?us-ascii?Q?70pGhRFQ3MYcMkKWDHyn0MrTvCSpbLQIl/1VB+r1i1iC5JSn//sKzv9HVGg1?=
 =?us-ascii?Q?LBPrKLd/35H0u8/ptG4IuZ8TH0vs2ChGIMSL1FTwhZr0G8nr+/bJRHHEEQq9?=
 =?us-ascii?Q?WduISVBiZOhX093QfqRRuOrhjI2W6CEhSC0FIFwN2fgqLkRwWNt9QbknbXub?=
 =?us-ascii?Q?1m81rulqE7E1Mv6PyZRK/FBEYCEW4onsrm3JLp2wAutDOCIZj8764P08m/Gf?=
 =?us-ascii?Q?0YCgoFguMKI+4KKB7BUscHRP2lcO6lX6lJMyWnGK0V30a9t/0gVYuhxt2Rtu?=
 =?us-ascii?Q?DyYlYsIZ1UsVoBAmjF6uEfusIP0m2Gg6PookD25Ab+NmCUfa6gKLgeyRdujj?=
 =?us-ascii?Q?JYuKbNN0VnslmvptVrgd+3I5CkUCDfT//mRbjtdPNYjy3r7dFpcsKXMYAp2I?=
 =?us-ascii?Q?PC4jwREF2OXIEkVRdsDoWqmJOyNPRHEouGqmjCFCa76fH8gKEDJ+SAMQhmot?=
 =?us-ascii?Q?UtA1DNshRwhp07lov6G+wdeOSvW7wmhAFouIPznx9iQN42e4OLBSJeqz221b?=
 =?us-ascii?Q?PqfnJczXxCm4Hrr4o+vmTSiz9ztZxEMztZ1CSsIzpyGpEDoqH019RAXN6BJY?=
 =?us-ascii?Q?AVSjivJrCHguFod8PF2cW2v2TFcdqmRmtn4eswlMrCKD4nlBhu6mBzSIjcsv?=
 =?us-ascii?Q?YhFVmgpzGi6LGr6nzHPxqadjGtglzq7dv6nNzzVpbZW2vM0U+aq6/q+tn8i1?=
 =?us-ascii?Q?OFJvrfn09jpCbJNn+Bgi2um6nkquZLsMNh4bBejzO0hwlEuLgy07VWNQZeZl?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026bbd4e-fdff-480a-1bb4-08db24a1964d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 15:34:23.5371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sLgsGnc1CoSKOnYDs9Ezkjwy4Ay2pdgXyE4ZIc2M203+kgEJB/EhjKtwkjY2v4s/1c9Jk2DLSs0rAf9NXfPKWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7055
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

After commit bbf7d3b1c4f40 ("ASoC: soc-pcm: align BE 'atomicity' with
that of the FE") BE and FE atomicity must match.

In the case of Compress PCM there is a mismatch in atomicity between FE
and BE and we get errors like this:

[   36.434566]  sai1-wm8960-hifi: dpcm_be_connect: FE is atomic but BE
is nonatomic, invalid configuration
[   36.444278]  PCM Deep Buffer: ASoC: can't connect SAI1.OUT

In order to fix this we must inherit the atomicity from DAI link
associated with current PCM Compress FE.

Fixes: bbf7d3b1c4f4 ("ASoC: soc-pcm: align BE 'atomicity' with that of the FE")
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/soc-compress.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index e7aa6f360cab..d649b0cf4744 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -622,6 +622,9 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 			return ret;
 		}
 
+		/* inherit atomicity from DAI link */
+		be_pcm->nonatomic = rtd->dai_link->nonatomic;
+
 		rtd->pcm = be_pcm;
 		rtd->fe_compr = 1;
 		if (rtd->dai_link->dpcm_playback)
-- 
2.25.1

