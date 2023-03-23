Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D69A6C5F27
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjCWFr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCWFr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:47:27 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2088.outbound.protection.outlook.com [40.107.7.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA532D71;
        Wed, 22 Mar 2023 22:47:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6i89BHozqAGp3KQmoshGxd+eNiUpAjLRrYSzkZzcL7sx6J9WyeGiQ7kY+Y1syVw2ZxZij0W4GeG4yuhf+LEB0fd89O8loOV49ij1YuvYaexa1GRVNpmr+mbuMS1HndvHZwTsHT2wwF4+spOhB9Uuxrc8IFgD7Yaq5rgBRXhvy0RuZSwWRkCY/xRQyi2AnAX/EZP2q6w99b1foVZj1ymNhw91gWAmid7Vi64slwQAk6vFgXEHBXkiJahr/ufx9uZOOatq52712C/VQS8vTuXpaC7VfvmP9PVaHwtDxv3XdFG8P1pAsuox06OY/Kft8stLvKhzgmhVYtrZ5kJNZ57iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwuZYwXNw0HU7vjgqtcPteOamCWiixbYbAknL41j90o=;
 b=LeGA+Dgev04Mt7v7N5OVNgm3imey+u0qx3gCOzc5jYc8XnPTjDxjvbJ5kScmu1UB8+CtiZRABcHF8a3XZcjBYweitiX6B3cTntAdLfQ+VTUedsX48yQ57z+RdD4zBXawuzEGDM7s+u+YqOeJH0cNKEx2tkWdUg62VctPo4+ftuiURkNPi1J/YfZ7MfMai0Ee71DijMjZiWWlTAdo0Fj1dvCIGnN/i9CnssWrd65FReasLcFhevIJBc9WIOk5nxGpVALMVVEZ7gUx/yeU0/rhjcqnUpNFtjrlH2csNwEd3eIZx6LXENkxc5yiGoxvfZKJ1Oq9pi+q6s4nJBty14LLPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwuZYwXNw0HU7vjgqtcPteOamCWiixbYbAknL41j90o=;
 b=PM/9zzeOvSWq/S1T5dm1BYiQTHIdfL2Un00Bb6JNNSHLsKXrZBeQPK3RJUWrJ4pdCiziQXqKuOex4IxwJOL5+KaYCk7lwXTBfLqrjyMvm7Rc2OEh973GG3cwYu23pSLt8wZKj129o8Pwzh6+wijIoZZ5r1DXNyft7xlJJZqSOGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 05:47:21 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3079:f55a:740e:c103]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3079:f55a:740e:c103%9]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 05:47:21 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serial: fsl_lpuart: avoid checking for transfer complete when UARTCTRL_SBK is asserted in lpuart32_tx_empty
Date:   Thu, 23 Mar 2023 13:44:15 +0800
Message-Id: <20230323054415.20363-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:194::9) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|PA4PR04MB7743:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b2a153a-0198-4b71-4245-08db2b621213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qoy5teZIN6j+Ayi+uIxWW2uwxHGdCnfByZYTw2PYmtg9GwGu0YqW35rcCDbhVjquK1pbW5I7I9Vj2LduInMwXzPNk1pMTmDdWEt9eVd7xHV5ETpLIDpiLhOWk3bGQiP/gALYkI902KG7vWxPuhRQmsS9hWqlZaZwRPv7so+nl4Oq/b+SKVoaZ/FPAuBiNef/VQGaWhdInFlzDNUGIPlJBtihd7RsOMuM3pcbganPWqnH6j1K9G9C4LbIe8rFIM7ccZ9JCW1UY1YCkxmIj2Bxdzd62sVlL8qKDMi1fQidwWVsSF14bvKNLgX1TtDx+tJc57kXcSny9ByyugepXNGlUjeDTba7sbEct95dMGJyuGrB60RI49ItF9cyRB8XATEdi/Ju56T+EvH3jHTLUhmHspF+c74S9s/j1uklojSu8ryP8FlgFXtC+NwGmBV2l/Q0lC7sC8yRX8bY4yOOUsI5B06fGnU6FiNgm6Bz1U9u5V+NzIpvrLJ7fD+Ba1ojF/A7RRxLnKU6xC13OzSUw80vsMKQWa0u6XetMNvib+wRfSlNaLuldGpsqwdxu6+ZMRYnLtCOwrc8ruGYRnSK7dCdnwY3LvCmGfhv2/QpL8SjzZVJqLcj0XKs25tMGV+Ms3ahqM3ThIZuv4unkDHTc1MjLjlb6DHfUiiZVCIoAqh0mQfz3ozHD4TUskAYgZHqpz6RZRmodP/zbx43e4wHslYVSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199018)(6486002)(83380400001)(52116002)(2906002)(38100700002)(5660300002)(86362001)(44832011)(38350700002)(478600001)(8936002)(6506007)(1076003)(26005)(316002)(6512007)(6666004)(41300700001)(36756003)(66556008)(66476007)(2616005)(4326008)(8676002)(66946007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7sQmJD62orDzXX83RWfm9uu9TikL/C6qTkyrgBiqBgBrVj6c4dzyh0XWPAHx?=
 =?us-ascii?Q?1b2bwJRrKbzMAjpwBActNnouK3aakx8JIeVWrIKKxM+PKng7+aHeS5wFjiRg?=
 =?us-ascii?Q?TDJG43Jd9pVP64SAYsSPV2eFCsVEsMe4sVJJqm2JkiJK7jHHDTQ/cZjLZqvY?=
 =?us-ascii?Q?BFYMzGfEKJO5lJIgpul1N9C7Uk5slkXRnairZRvr3+ygQm1opATkg9d3IJpA?=
 =?us-ascii?Q?+k+yqu50/M1kQbY2rwg4syzFTXXWg+5h56BRi+m0hoWozSJ3bdXHVAlarISe?=
 =?us-ascii?Q?vHvQNvJwzz+CdaQeg/YLHTksxwvRirZ5NNPTACoX0RNg/QJKFXF1HHF90PmJ?=
 =?us-ascii?Q?Ezzrr6DsVoCHPlMN/DGcsp4ketcgs+Tjf6mRk2vF7Hgimf0Dg8ce6KtVP/jb?=
 =?us-ascii?Q?09bil/K91B2GhuI1VEWoOhI7o0FkQWIJkdBuKfzZ4RAfYr9VVt59xsqulGMt?=
 =?us-ascii?Q?9zx/xwZwPyB3KUyYBKqFJ8XHY3TQpT55HGpqvh23xm4lSVI2slc8I65hAcCZ?=
 =?us-ascii?Q?JIdRP19Y2LiG8Czo4TPRJCkqcATJhw1Ml/vltR5xmYrEU9b+Fx6Gm8iOa9T2?=
 =?us-ascii?Q?hBlKR74RxNq1ivhZ3ti04TlFDh1J9mRgK2nTwvMU1T3mQV2Fm1gGfQ7YQFpz?=
 =?us-ascii?Q?2I/OiOgUVfp3C4PSYtI/iJXYJ2ForIeUzA1L6JFSIIkwik0QuYphucmfuiwl?=
 =?us-ascii?Q?+hky4OcvVOk3ZAdMfEQy/nWI9mPa0ku5m0EMlKXxTYRffFlK9VIMioQTLaKB?=
 =?us-ascii?Q?PDMMxaITZiidTsfB0/pjp5ihfT3sVEIqZysD1uT89RweWKrv9xCGgBqMUaeu?=
 =?us-ascii?Q?oaxSWgtn3smsT/34muks2/g1bwV8mLvB3aPTf6HORU9Ss3KwzD9NXbd6rCfU?=
 =?us-ascii?Q?RGJ87jlYsmrAk0Er/b/uV0L48L1K9+1fH7TrHuHm2BKOOZiuwlwJnUhEGbEM?=
 =?us-ascii?Q?y97ItSM2ff894CYN373BEifB2khyMZDnwLYYRiwA13ENhehYDqtVGHjopJaV?=
 =?us-ascii?Q?+jntm637+JZD09o3sQ06CowGVkpHqLrVI2Jw/m3NnSNjVisGbgmSRTDI5ZdQ?=
 =?us-ascii?Q?mvVF4gJ9Wz0gXIjytWgIFvqhS8U3fgz2fxNqcvLKvnEAsspC0ggvIaurkoMF?=
 =?us-ascii?Q?Gkjmh6CZsM05W0i6+as0xybStpburVgPX62B39QF4EBO8+ufiduqWX6jFSOm?=
 =?us-ascii?Q?AWAXe+6EzQ4JlWlGXG/gTVGHAOgqmBKaSPlK08DGOdqXBpZSeLtauAG+VHrz?=
 =?us-ascii?Q?JHOP9QccNJVclMc9iFOlMbBuYaEEcx6iralmuJsLdYiQd/1AH2lhRuX4ya13?=
 =?us-ascii?Q?vxRUxWAeggXevaF48BoHMAtk5+VF6MlotqwrMcVu0+z9itbnyAR2qeOom5xN?=
 =?us-ascii?Q?BDidG4wwd/KRCXWXuZvzWdOyXHF4fPfGao/g0HFlTovRZv5C+gpfHENn2Ckn?=
 =?us-ascii?Q?74zh+aJUGZ1DqG1i3Rg0LoZucRQSDnKTTQTiKSZ5wOA0ACkUjBceE1ue3hdT?=
 =?us-ascii?Q?XJzxDtoUuqpdwmKdMcdHlhkEpOVrw3cKF5TltUG+D0u64/ZtPTAPaAFHBqP4?=
 =?us-ascii?Q?YXGIY7W6XsAw2INfvL2dGfURTJ4/PE59ZaSLhfEL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2a153a-0198-4b71-4245-08db2b621213
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 05:47:21.5441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkY8wlo6fTtidTyxkV9EIb2r7XSUobRCw4IsdMZqQHV6hDno3Vtqb5ZWh/NoFcp1IgGHdV9HQmKTvbvP3RclrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7743
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to LPUART RM, Transmission Complete Flag becomes 0 if queuing
a break character by writing 1 to CTRL[SBK], so here need to avoid
checking for transmission complete when UARTCTRL_SBK is asserted,
otherwise the lpuart32_tx_empty may never get TIOCSER_TEMT.

Commit 2411fd94ceaa("tty: serial: fsl_lpuart: skip waiting for
transmission complete when UARTCTRL_SBK is asserted") only fix it in
lpuart32_set_termios(), here also fix it in lpuart32_tx_empty().

Fixes: 380c966c093e ("tty: serial: fsl_lpuart: add 32-bit register interface support")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c974a1d88f88..3281e81e1723 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -863,11 +863,17 @@ static unsigned int lpuart32_tx_empty(struct uart_port *port)
 			struct lpuart_port, port);
 	unsigned long stat = lpuart32_read(port, UARTSTAT);
 	unsigned long sfifo = lpuart32_read(port, UARTFIFO);
+	unsigned long ctrl = lpuart32_read(port, UARTCTRL);
 
 	if (sport->dma_tx_in_progress)
 		return 0;
 
-	if (stat & UARTSTAT_TC && sfifo & UARTFIFO_TXEMPT)
+	/*
+	 * LPUART Transmission Complete Flag may never be set while queuing a break
+	 * character, so avoid checking for transmission complete when UARTCTRL_SBK
+	 * is asserted.
+	 */
+	if ((stat & UARTSTAT_TC && sfifo & UARTFIFO_TXEMPT) || ctrl & UARTCTRL_SBK)
 		return TIOCSER_TEMT;
 
 	return 0;
-- 
2.17.1

