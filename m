Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1413A5BE453
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiITLWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiITLWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:22:52 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E705F23B;
        Tue, 20 Sep 2022 04:22:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2uKMQzlMhbehFVJxH6yq3d7zpCDR2nO3imOPNB8ydpIm617LDJVxVa+KGecsChwn8BNASkJ23b3HaokyRx1fpsNb5MLVL7J3AFu3d0Y9zn9iMkbjP3TvYXpDHGIrlEAJPD0J5p22Ap4kEdvMwUHgw0AR9U7C2eb631x8cIVIeDYgI8KTu0REoCvpVbEqgKSSBll3tMJGLsiR9AcPkqcJ+Q69c5G6GUX6+myiVwaw5PEWRkex4nzAtpj7Rp+ybPsJCZIcjoC3WY5g5rTiU7ofjCDSgxG288ipA3MRKTiFQdw608GxOuX1tYbs5h0TaS/Xmsg5Q5N7+fkz57OyGziDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygP1flMFljP9JPJKAE0r6LUWU5GxUCidMEqTpxBQrsY=;
 b=BtxRRV4/C6eSGaAz7MDXo9/wbbV9jbGw9pRKXOS2pk7uxjLwFvk7kXvBMpVI4uIOc4STh6I8l9ol9WYFo9d6TWW5rmcRXOGXBNbdbvdflxsd7y5NTHO/Wi1i9h96zX1lsp9bHMl5hym4UsJJaL49ukBUh7NtQd6JK/2ERSitjVf4lToVpHH6fHoF/7G4LmHsDW5oSLGSIvni34mFncRzN5gi1foW9RoYrjr/J32kqdV1DakLnTszZj2Dt0d32HxTDDV1tGAa4vntUAkQOGObv148WzJWnyxoHTuFqgeaGEg78C0HFfFDnxR8E/8oJySW/I8NGvDMOOfUQ5k1/08FPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygP1flMFljP9JPJKAE0r6LUWU5GxUCidMEqTpxBQrsY=;
 b=c/js8JvHwn7iJ7r7d594Hxszb3GB1mhnUDBeUZwsU1C/c38vwdd/6zsVTvut9HpmS2qcTDFrF+Bf+T8LCeF24HK4HabWR60Y0x5rl6Vu9qRRCxMHX7IMnTsaVzt51oA0kUmm91D01Sa3zi0EVet3hOsahyduIT5NJB3wuJsWAGU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DBBPR04MB7849.eurprd04.prod.outlook.com (2603:10a6:10:1eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 11:22:49 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::121:6a2a:2d4b:cb8a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::121:6a2a:2d4b:cb8a%7]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 11:22:49 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        bhuvanchandra.dv@toradex.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serial: fsl_lpuart: disable dma rx/tx use flags in lpuart_dma_shutdown
Date:   Tue, 20 Sep 2022 19:17:03 +0800
Message-Id: <20220920111703.1532-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:3:17::21) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|DBBPR04MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: 603b397b-c94c-4909-e071-08da9afa730e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P4MirIQuM++wMIhMqsnmCALTRwb/pkGrXEUT+CLq8tDRk99RblEstEsjayE/88SRRS47G/k5kFp9prxfevwhcv2hENn8Q9/GIg0f+MVKQwFSZZsGAQjHKcgkvEkGfEasxzy5jr42MPX2WcQaX1d5ZYyO23PDZJtUtNmtBUC3lK/I7T5MFhZUs/KvWFSRke4uA85u33pSXNM/kFQW2iKPoFzMb+rIfIr0/gwAj8jT2ssD6mzXX2aP+AeE9M6tsz9yg1tbqXhnnoCyk/msi+R9IswrY9B4yQ0Xc98EVZIW/5hGUPd1bpLiROIxGoDxuhKIZZjG7tjox/mml9ytSV/ZUUPCpbfepl4Hr4LcYgcdgBx2jrrOGwlY+pJaIdmPb1s4hX4GuNCKCk1d6jMk00cLUbfqs+TKDv6ffidwdcy2nQ0KkpL/SN59Uw2FBvNS2d0OjJlNe4vibNbMtBjiggh45h3xFJPnVUORnpWtp5UY5o0hJf+psiby0V3+iXTIwERCTIwvm1uEwh+HB1+gg9k4X/3MDvgriPtwFfyuCl9kGwdhniT1WoogNEfGKVlyE//sOn6owUDC1HYDb6eUOALpW8YN0+eeE4Ty/ljaMgU1Q21CH76s/JuTGBUrxdRuPbUKi8AuSWBDSJN26FBaGyx69kkSP/zE7LRYMRzNwPBD0AGkiDTQGhIXxJmwLVGa1uCjtZoY7EHDphBx6fQxyzbUo1Hk5O2JGxhfFUHPNv0nEn4F0W4LQCMfJYDmtNikPJFgrnRh17ApxNIhItBZupdVmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199015)(86362001)(52116002)(6506007)(6666004)(41300700001)(4326008)(8676002)(8936002)(26005)(66476007)(66556008)(6486002)(45080400002)(478600001)(36756003)(66946007)(316002)(1076003)(186003)(44832011)(2906002)(2616005)(83380400001)(5660300002)(6512007)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ohsJuv2hqCe6aiHs6svgLksunJGinGrCvJwOGXEn9lRn1EH0hOvwmiCy9Ggb?=
 =?us-ascii?Q?7ouN4Y4B+AwmIHIcEqzAuxX/AORkqJYCUWm5Tn13+tF4za7Suh9jXthik0p3?=
 =?us-ascii?Q?9zpwc/gebNrmwTSyRXsN9S4l3h+B79uNjmo4SIxYAC9gdk2IcaYkXZyQB6SZ?=
 =?us-ascii?Q?dvMBGwqDJqOoJ/C7Mavean9nZXBlIfwiJLiD2ciK/GzF8X/PdgP43yLudRz+?=
 =?us-ascii?Q?eP2uMPC3+6nK9gtjUFJdqVOOnDOZzPkhhH2U+0VF/3/4DE/EFfqITeyFNWdM?=
 =?us-ascii?Q?XiXd1bV5BfANz4XDe5jpN3in+jhrt7Yc66y6Lz6hdgBkqgrJdaYtdD3g5hnA?=
 =?us-ascii?Q?UsUstKEqVdbwqtWRSqpuBGKl0DeishhgoHMj3nLppAoU/RQT9z3+LMq+cAyQ?=
 =?us-ascii?Q?RLBVoCQ3PxwYTi4OGZ4Kw1KZUiDE9rRot04nwhVa69/gzDmPj6NmviCQt/Y/?=
 =?us-ascii?Q?yJnt/NM7ktPIldyplbFLSPZtU+/4CieZs6/8SgDOYFvhyA2EHBjNWc86gWyq?=
 =?us-ascii?Q?sD/kPfQeH33b/e5bHqTPfEjMKTP/cm+Nro11cQzKXcVhSrCeUcSqQjLGxAG8?=
 =?us-ascii?Q?bm7zbgXUdQWIFYCI+Hby7EGEavs+JtTCA+KuBqfmTwDGI+K5MZtIv5Eu5esn?=
 =?us-ascii?Q?2gQYCRmF3T5rcl8Lh9Of/H2kp6iQffwshoKM4UiBy224NefkrPvrFc95cL9l?=
 =?us-ascii?Q?NJ4RM0ncBaUHyFlvpBsMJ/zwnrJC69qKepHM4QjcieOLNHA+0xhanFFZFhLU?=
 =?us-ascii?Q?7J3Gfu850/jDcAvdqS8U3bUFPEREu9kvNDMJCZe8RderVM+5tsJ8sfb712ZR?=
 =?us-ascii?Q?Fu80IwmFklvBJ1v9QghAIjg9y43qwQVB12qKemynXYk6McSoKyeET1gScqJI?=
 =?us-ascii?Q?twZG8X3125AT/sldLlU72AMHCgKo2bTy+hIUk4ZfVsflC9dm9Hj51oxSXOht?=
 =?us-ascii?Q?1xOMXRE2qfqOANADMSZCWv2opfp5h2hTekojmXTo4zsnud1lCSyBPF9TVox7?=
 =?us-ascii?Q?+3z1C7CLNR/CsWR0kCrpabhKgf67aMlpEiPnkkUU8wQoC5cS7qEPldFYAUk7?=
 =?us-ascii?Q?O4xEtreiZvsPOlMURZY/DbnJBJLWSEIsCdLlM7YM5L6Ou7/EofWDDBAHyHXd?=
 =?us-ascii?Q?8kBdOun3J4FQjShwQZHKR0AZNX+yifBJWRa9rK15VBhmcUEge6bWP23ts9Rg?=
 =?us-ascii?Q?Fu7kqjzcaYKVTXOmSRXCEvuDWuGoaszZMDORV5JbISvlKvCWw4sSnUGN2yYK?=
 =?us-ascii?Q?mUJDek+Y/MiogS4URn0guoPDf59M0j19mN0s+Cchb/SEDPKWNHY1+k2+A52h?=
 =?us-ascii?Q?Y6C+PMqjswziM+urOCwBOozkW92XNKuZI+XfHTSEipXnYKFGAh4vZT0WAybP?=
 =?us-ascii?Q?RVW+mrDi5nLTfRfr5oVY6pX6dEgM40qYJ41IenQYT67yIHZIXikkGZ3DsLxK?=
 =?us-ascii?Q?XQfRbpeeFYH0MotXvs0DeEsnUcfx2T3PQMsZ9Hd9KHmjECrCxTnzh1BJFM/f?=
 =?us-ascii?Q?hllktXNy+LMxIYX/mq6ooOq0Zv7ZC5LkA5qn2QF2eTEg0vBFSJr+tSLy1GJz?=
 =?us-ascii?Q?l2lB8DE7fs5BQmZcCoVjXqasfQY3+5cWEAaIny91?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603b397b-c94c-4909-e071-08da9afa730e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 11:22:49.1076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/lFIIyHtO4owXfVdqblN26+hRbCCMdDzlSUKRXffYOI1jj0mVyAjJ7aQ2CIrpi+9wikyAkRa5XUGEQ748rUPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7849
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lpuart_dma_shutdown tears down lpuart dma, but lpuart_flush_buffer can
still occur which in turn tries to access dma apis if lpuart_dma_tx_use
flag is true. At this point since dma is torn down, these dma apis can
abort. Set lpuart_dma_tx_use and the corresponding rx flag
lpuart_dma_rx_use to false in lpuart_dma_shutdown so that dmas are not
accessed after they are relinquished.

Otherwise, when try to kill btattach, kernel may panic. This patch may
fix this issue.
root@imx8ulpevk:~# btattach -B /dev/ttyLP2 -S 115200
^C[   90.182296] Internal error: synchronous external abort: 96000210 [#1] PREEMPT SMP
[   90.189806] Modules linked in: moal(O) mlan(O)
[   90.194258] CPU: 0 PID: 503 Comm: btattach Tainted: G           O      5.15.32-06136-g34eecdf2f9e4 #37
[   90.203554] Hardware name: NXP i.MX8ULP 9X9 EVK (DT)
[   90.208513] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   90.215470] pc : fsl_edma3_disable_request+0x8/0x60
[   90.220358] lr : fsl_edma3_terminate_all+0x34/0x20c
[   90.225237] sp : ffff800013f0bac0
[   90.228548] x29: ffff800013f0bac0 x28: 0000000000000001 x27: ffff000008404800
[   90.235681] x26: ffff000008404960 x25: ffff000008404a08 x24: ffff000008404a00
[   90.242813] x23: ffff000008404a60 x22: 0000000000000002 x21: 0000000000000000
[   90.249946] x20: ffff800013f0baf8 x19: ffff00000559c800 x18: 0000000000000000
[   90.257078] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   90.264211] x14: 0000000000000003 x13: 0000000000000000 x12: 0000000000000040
[   90.271344] x11: ffff00000600c248 x10: ffff800013f0bb10 x9 : ffff000057bcb090
[   90.278477] x8 : fffffc0000241a08 x7 : ffff00000534ee00 x6 : ffff000008404804
[   90.285609] x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff0000055b3480
[   90.292742] x2 : ffff8000135c0000 x1 : ffff00000534ee00 x0 : ffff00000559c800
[   90.299876] Call trace:
[   90.302321]  fsl_edma3_disable_request+0x8/0x60
[   90.306851]  lpuart_flush_buffer+0x40/0x160
[   90.311037]  uart_flush_buffer+0x88/0x120
[   90.315050]  tty_driver_flush_buffer+0x20/0x30
[   90.319496]  hci_uart_flush+0x44/0x90
[   90.323162]  +0x34/0x12c
[   90.327253]  tty_ldisc_close+0x38/0x70
[   90.331005]  tty_ldisc_release+0xa8/0x190
[   90.335018]  tty_release_struct+0x24/0x8c
[   90.339022]  tty_release+0x3ec/0x4c0
[   90.342593]  __fput+0x70/0x234
[   90.345652]  ____fput+0x14/0x20
[   90.348790]  task_work_run+0x84/0x17c
[   90.352455]  do_exit+0x310/0x96c
[   90.355688]  do_group_exit+0x3c/0xa0
[   90.359259]  __arm64_sys_exit_group+0x1c/0x20
[   90.363609]  invoke_syscall+0x48/0x114
[   90.367362]  el0_svc_common.constprop.0+0xd4/0xfc
[   90.372068]  do_el0_svc+0x2c/0x94
[   90.375379]  el0_svc+0x28/0x80
[   90.378438]  el0t_64_sync_handler+0xa8/0x130
[   90.382711]  el0t_64_sync+0x1a0/0x1a4
[   90.386376] Code: 17ffffda d503201f d503233f f9409802 (b9400041)
[   90.392467] ---[ end trace 2f60524b4a43f1f6 ]---
[   90.397073] note: btattach[503] exited with preempt_count 1
[   90.402636] Fixing recursive fault but reboot is needed!

Fixes: 6250cc30c4c4 ("tty: serial: fsl_lpuart: Use scatter/gather DMA for Tx")
Signed-off-by: Thara Gopinath <tgopinath@microsoft.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index f21915015d67..064bd1f33c21 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1771,6 +1771,7 @@ static void lpuart_dma_shutdown(struct lpuart_port *sport)
 	if (sport->lpuart_dma_rx_use) {
 		del_timer_sync(&sport->lpuart_timer);
 		lpuart_dma_rx_free(&sport->port);
+		sport->lpuart_dma_rx_use = false;
 	}
 
 	if (sport->lpuart_dma_tx_use) {
@@ -1779,6 +1780,7 @@ static void lpuart_dma_shutdown(struct lpuart_port *sport)
 			sport->dma_tx_in_progress = false;
 			dmaengine_terminate_all(sport->dma_tx_chan);
 		}
+		sport->lpuart_dma_tx_use = false;
 	}
 
 	if (sport->dma_tx_chan)
-- 
2.17.1

