Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B848268B3D8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 02:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjBFBc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 20:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBFBc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 20:32:57 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe12::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE1D11156;
        Sun,  5 Feb 2023 17:32:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQizGY7sRk50JCXPAJDJIQ/Nzz+rnbKW7SYdWzK/k0jYeZu/tp67k/idzpjALMjKo31cAmdX7R4yQsf26ritWAiO1cUaX8IxrgJlOE9UkRdjRmRNvP5O3wb/nbXBo5u9wORTjSqE2QPgpWAX88xzPIKv0L2wTlMMpxkPpbUn3MLU9kAvH4T0HnZMlheW7gPQFMn/WZBHQw6+7nWk5ya4Zs/EXHdRCOw0KX/eX44NcoPcbehpu3wBqRFnJSuuHB+PIN/3JuJU8Tes8t3X6cOD1U3TtmDQ/TGLoTjwO9NI/zgNL0l/E5pjjZG5vCvus638sCbeuQPHIVmVPkuB5juDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vjKPGwmjnNYe+VqL17imo8l2unTtRjKH8TJtazBGr8=;
 b=Gxjckfg6ZcvM8sFX4qdDXlq/6CNg7Tkt78H/uAbQnWLJXrZYS23IM7CQ1Lmz9cRF7mTzgWJW6pj6V1m4Jhr3WMWPmGgYE90fbLXqbReIWccOroV38LnDygAgevNxrJcfYq17ypAhkeuxR83O/Eqdz8DL0/wZUBsmlEqI5m0I2z1Avqe4/TKn4kbkglCJcQYdySThWdHwactQFfVggIqwPJNsUaUkBGv76vF983GrGR8ywHSu27xDzB3zw+M7/vkzJ6tUL6zK/RESnZAe0lm1yFUbm1cX2DehsZ1DpOnoRfNJCj0Po7sB/2dvgZ1dHOtsHVx6L70EeqN62ztJZYtDDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vjKPGwmjnNYe+VqL17imo8l2unTtRjKH8TJtazBGr8=;
 b=qu3N6YUgwCP7VBKLfyCFAeI3a77wRNBXrj7g2Q1Y9aOq+aga3ZQfwSVH/tljerurGGFn7s/D62O/kJ/wBTIK5C96RZEU713zib47uhDWAU1F5Be5YDeJtmwREej1AdmT0hVRL8tXWt1DUN0koBc6TrJBpJESI7CZ3btDuYGXbpk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DU2PR04MB8614.eurprd04.prod.outlook.com (2603:10a6:10:2d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 01:32:51 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7f24:bc0a:acd4:b13f]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7f24:bc0a:acd4:b13f%8]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 01:32:50 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, peng.fan@nxp.com,
        festevam@gmail.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de
Subject: [PATCH] tty: serial: imx: disable Ageing Timer interrupt request irq
Date:   Mon,  6 Feb 2023 09:30:16 +0800
Message-Id: <20230206013016.29352-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0196.apcprd06.prod.outlook.com (2603:1096:4:1::28)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|DU2PR04MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: aa18e8d4-38e1-464f-135e-08db07e20f54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5mNLHFSl3bIP35hfY9pwuiDZ9OWvC/i5dGJdAPx5JxvlpraoXwInFQg3GdDyg1HR6gc1NUf4hOAvjbpME0DMRadbvVZCGjOLSL82zeGjlUoMF58yGJcQYorkeYz4Z4M7T8ylk5LNqygFxEwSeAfse6XFmOX3JitgLX1oLLN8XeRykRab7YzzwcB4b0rMI87eNVyJRPz+ikCxxp2Wgl2pu+uXcTr26v2MuDBU/HC4TaUjZd/gD1x0mihvcRAnMkyyyf6dggI/i6C8Xna7HTwFOoWS8gRsBj5+31AerPduzXsMpiwbJr3YPdeKvLwmkP/3jpodfC3XB5AsDhRsvBaVbdccVWPMzSw2tfjMlm0ZdV3jCgqhuacCIxxDkXvsbgYPrLxyYC9KuRg2widZq3OHvc9mr9Q8RdIh/WNCNwnhyKU8khhxsPfMU84rCUwlUzdiq2grVM7IlkFUmb9PqCNAKtsYkxYMZETaVXrRD1fEB9GKzFkN8ZKg8R4JwRQ1m4nMAwaa8qFn0Gh7hkWM7G5VOu6bMsKozry3RVAJWvS80JURIQjbU8JEASQSCmhQmDPRrzvkjqlVMP7s0AQslSgtz2gMCiDYuJ+XocFbW6kqiNIiy733tz+e4vJnuGfg0Pjr2NKkcAi4q7hXKzEHQ0hxk3yCX9SJHEZIWfIHlHXnTWeKYPgCKeGVurdaCxeJuWcD83xKQdAbCeOXVlrNpJYaow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199018)(316002)(36756003)(86362001)(38100700002)(38350700002)(83380400001)(26005)(1076003)(6512007)(2616005)(6666004)(6506007)(186003)(8936002)(52116002)(5660300002)(6486002)(478600001)(45080400002)(41300700001)(44832011)(2906002)(66556008)(4326008)(66476007)(66946007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eFN2vk3xPxBl7XqxgG4SyOZtyphb4qNH38qxe4znUjgsD+xlApntWpWK3bP1?=
 =?us-ascii?Q?nIBjgfcJx2Mirp1W5BG9jW19/DwWPh39cOGKHsn/EWmgJhWLClekemrSLbRs?=
 =?us-ascii?Q?nOq5MKtAqsJfmgj/pKDcw/56VZAnreCSMSXU/uu0DZhqbuCPiAW7DFpIBqUa?=
 =?us-ascii?Q?t0IeC5l8KGvODUhZegWNla3+caY9JJBiC9XKjuzXeMAf5UPurWMtjHPLsSrk?=
 =?us-ascii?Q?56ylLkSwkCQzAcs2mouwsg2Ucq3zi5/g0+tECU4vGd0VZqsBr/3DekHIm/p/?=
 =?us-ascii?Q?se0OpoVhWs0IuMjxUU068z7vm4MxOuPeepAoA41B6wDVfi0eY+T1PT836Yrs?=
 =?us-ascii?Q?xB0j0wyWaj+ne+6TSRJiyLAdgA3ZGtQ/j+5aEcpignqk4GqVknQf/6tMmaXX?=
 =?us-ascii?Q?/D7k4ItKmsuyfGamA9Xp2uPSwcnqG2n0HOy80iuvDNjZlqtYHBK/Bo9Vbn3Z?=
 =?us-ascii?Q?p9u6WL5Hxrc7bu7gklnLJjxjCcscmJwYCHKuOK85YD3JqM3qXpBAssDbL/UD?=
 =?us-ascii?Q?ZcSjKSdSCfquPwKjwu/JmaGMlYYyPf4ix7+88CqUe9pgmkjeDPMRBKn9V0Qw?=
 =?us-ascii?Q?G9/98fJ5T5TwRQ45rJOoce509YhoygNrnscEP75sEzaczG4eKj2YzRNMxvBQ?=
 =?us-ascii?Q?RqMCPrHZh06uFTCFUJyulNlGkKWXXB6ML3NWTxRavp7mLEmGYGlpr+lX46SY?=
 =?us-ascii?Q?mhvIxIwSnhQSbLKxtmcpoN+cEYXMrTHyseUxsHHzRQNOE4PYnXKsSIOUAh0U?=
 =?us-ascii?Q?toO/T+BvH76OtZrK3vrIjuO9QZowd+P2F0QMMy4pvKplOf18RkUfd+LJZfO/?=
 =?us-ascii?Q?YZDwhZAjN8kQ345I4Jlr3IpqfC/pcfyUql5BbT1Fk/jqiZipcmiytO8mUAMp?=
 =?us-ascii?Q?DYc3Id0MpkV6gwJga43VqVL5YtFvboBa28NDi8OUi2PAODPOv5KFgx3aLMik?=
 =?us-ascii?Q?trto1ypBjB9DCxwskhlu/0I+VVQZ2z5/q48oSB6BZbZt+dM3ZWJI0tdkJ9GJ?=
 =?us-ascii?Q?rNMood0B1ns6MqxEZDiSDt/aOwQsxqXmNTcdMjP2ACPrt9RaDg850YpBPxV4?=
 =?us-ascii?Q?QcybklulqRj0ZSsbJCoWnwAolbDyAn66H65foRg9KaNYFzUA7uW7AehtaUYj?=
 =?us-ascii?Q?sdUa0lKMZdyjiOyKO5qRugwlZ6Xw64qx3ZrAvBhvmjjb7Jx5rMtavNQFF9Ct?=
 =?us-ascii?Q?Bc0yPMr3/Opf98FGqUepk6VEyuClvyo6LnT/tX6cdhHusH8g2dKUEPWVcQPs?=
 =?us-ascii?Q?Qm/4unNdpgW1mDWfe3UQ/WRtJ5iN6aM2cBWgbhHSLDeZo9BRSOjbaHeNWHQy?=
 =?us-ascii?Q?tACA1/19gyRn6qtD34cf+IOd4PPw6sF3vu3G0hYY4OKSzHJHn/gnowjq5w+u?=
 =?us-ascii?Q?WjLObbuBKtVs6HupwwAgwl4FHqJe4zwsuWGAzHdXGEtUGHk/UdaPJ8dPLniG?=
 =?us-ascii?Q?MtzFJ0ghDQo72bQD6c+h2+LMsn5QGVFa5j1ad4yKpa+ivzVsrje0CPdRrUZm?=
 =?us-ascii?Q?0lF+iEjcaUwclyvhaBnhi10Fd2lqvn9XV95C+4GhZE81XTsyvNsNvJQaE6Rv?=
 =?us-ascii?Q?a7mDR70689p/YlnXSx17wlw5NDWYmIMw028rakrP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa18e8d4-38e1-464f-135e-08db07e20f54
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 01:32:50.8758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZYuVwiA7Od0UQ9ywHgUEw2FWscrlBXFtmb0LQV5CMtG6gSAV0glaXkrGN1Mr0IFoqrRgmqW9ytOwb/Cd7XQYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8614
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There maybe pending USR interrupt before requesting irq, however
uart_add_one_port has not executed, so there will be kernel panic:
[    0.795668] Unable to handle kernel NULL pointer dereference at virtual addre
ss 0000000000000080
[    0.802701] Mem abort info:
[    0.805367]   ESR = 0x0000000096000004
[    0.808950]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.814033]   SET = 0, FnV = 0
[    0.816950]   EA = 0, S1PTW = 0
[    0.819950]   FSC = 0x04: level 0 translation fault
[    0.824617] Data abort info:
[    0.827367]   ISV = 0, ISS = 0x00000004
[    0.831033]   CM = 0, WnR = 0
[    0.833866] [0000000000000080] user address but active_mm is swapper
[    0.839951] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    0.845953] Modules linked in:
[    0.848869] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.1+g56321e101aca #1
[    0.855617] Hardware name: Freescale i.MX8MP EVK (DT)
[    0.860452] pstate: 000000c5 (nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.867117] pc : __imx_uart_rxint.constprop.0+0x11c/0x2c0
[    0.872283] lr : imx_uart_int+0xf8/0x1ec

The issue only happends in the inmate linux when Jailhouse hypervisor
enabled. The test procedure is:
while true; do
	jailhouse enable imx8mp.cell
	jailhouse cell linux xxxx
	sleep 10
	jailhouse cell destroy 1
	jailhouse disable
	sleep 5
done

And during the upper test, press keys to the 2nd linux console.
When `jailhouse cell destroy 1`, the 2nd linux has no chance to put
the uart to a quiese state, so USR1/2 may has pending interrupts. Then
when `jailhosue cell linux xx` to start 2nd linux again, the issue
trigger.

In order to disable irqs before requesting them, both UCR1 and UCR2 irqs
should be disabled, so here fix that, disable the Ageing Timer interrupt
in UCR2 as UCR1 does.

Fixes: 8a61f0c70ae6 ("serial: imx: Disable irqs before requesting them")
Suggested-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Acked-by: Jason Liu <jason.hui.liu@nxp.com>
---
 drivers/tty/serial/imx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index ae75135dccb8..0e0590d1b123 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2381,6 +2381,11 @@ static int imx_uart_probe(struct platform_device *pdev)
 	ucr1 &= ~(UCR1_ADEN | UCR1_TRDYEN | UCR1_IDEN | UCR1_RRDYEN | UCR1_RTSDEN);
 	imx_uart_writel(sport, ucr1, UCR1);
 
+	/* Disable Ageing Timer interrupt */
+	ucr2 = imx_uart_readl(sport, UCR2);
+	ucr2 &= ~UCR2_ATEN;
+	imx_uart_writel(sport, ucr2, UCR2);
+
 	/*
 	 * In case RS485 is enabled without GPIO RTS control, the UART IP
 	 * is used to control CTS signal. Keep both the UART and Receiver
-- 
2.17.1

