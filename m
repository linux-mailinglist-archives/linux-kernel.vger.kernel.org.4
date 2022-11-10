Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4761C6241FC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiKJMKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiKJMJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:09:55 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2072.outbound.protection.outlook.com [40.107.247.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1028E5598;
        Thu, 10 Nov 2022 04:09:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lv2aU0odGIGg+vk7j3YCr+DsqMrqDnxmwc9DzJs2KwiGXTu4PB5unhSF29sebunnFtezHO+F3nN9Mqisp6le5IXdnjUwkhQPWTJlri3Of01shR3E0+pksSI1+nmuOGbQEtyCtwU0twipm2jTDPAlZSxXdf+gUQPY1GGOVRtuUHxo8zD80vCOJfiB3F+KJ2LOtn8wsMWQWZw8oD9vrbS4A4y9EzmZs0BBbs1xfkG83rOhWBjH8tSKznPwKFUv+iz3kK5KcI00PAJishiGwJjB1YOPKo98nyI8+62QSDW/BKLsyP0crxKIVOo93ziLyd/QuvJOi6BXm/zvipckCb9Vzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fq5ouvCQ3ElcmR3ryx0nl31TuAcJBOFcoph7Uac9pL8=;
 b=bRuh9OdrmkSLArmym3jAQzmco2i5SEP6IQIUsGGSo8YOy4HsjfGq73wFkLXR+fIRXP04nCxwNY0BKznFKbNYN6w9H3DFr7r6wENqAN/u35Xk2pR1l4ZkvX3WeTC6YRnxJqmBLZ15FnGU7/q8RX0Wf1uKHMXB61HJLHtGfS0jl31SKn2VWynjCtbI+HFchULWUT0A2NDDwUwMP0nrErAi0SxTDtzfM5y0GUfJ+DxI+8w7eb1GxRzp/17PU/h6oicxpwYPLLCU9nRNiHnQTpIuT4V9nD3SKCPhKTPoeZFQeWPErqX2yTL4laPM9Kskz7rrVX6USigO7d8eHcd9FpwEkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fq5ouvCQ3ElcmR3ryx0nl31TuAcJBOFcoph7Uac9pL8=;
 b=fsFZmhJlHloSpF1o5T3NfVa6p0vOyw5I5djs5+G0qtU1OVTjc7VBJ0yib28QtKVs5sXdgz5hK4lITLImanZ22EuHTB4JiPVtC+203CH/YmobPlUUhE+pBuRjYQcfEjQ66RQcMBGym8UkJbKyhSRPIw8froD+TLkObdzFJ/bJClM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB8PR04MB7097.eurprd04.prod.outlook.com (2603:10a6:10:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 12:09:52 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d%3]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 12:09:52 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2 2/3] tty: serial: fsl_lpuart: Add runtime pm support
Date:   Thu, 10 Nov 2022 19:38:58 +0800
Message-Id: <20221110113859.8485-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221110113859.8485-1-sherry.sun@nxp.com>
References: <20221110113859.8485-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::28)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|DB8PR04MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: a5410af7-f5e7-4b88-08a0-08dac314791d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uZqiHhnqbBAv2Z0XtAhpnSfUmj1sdUn6jQEZ+bx7d2SE988DnMPut7XNZDbGI5PA7IaH9ffjN/yBWXPHTvw8LYHuX8df598/G/8lU0CI4g2yx5AWvz/Ol7RYhNqOA2tQ2rqVeuXfkFRGwGUGpGfovsn7XUEtBRckV8bZywGfnu19za6zC7BitCXS6lts+lFz9uPSCOp0wekSwrwy2tKiVXpgFuy9MhkVJ5erjqfRCOl9kiREDraXDxWRjZKphz6zpiun/rscSRDwlXsLMUEJj9v/bZKysJdy10foHr+TjRm2NrUiGeif+nwjwI8tdG7c35jo1UTEFsHZZlfNHuQha1cxrS/I2+R6XfWzmrp84RwRYZY3BFERbqvpXNDB920+YO18uFQNOow+fk9IVIyLQvQMXMYvYLM2DMi07/JPNwDLTxsBFhLLKBhLmmUxgl11KHFT6CtszxSA6Mav4EeUwRQEHTkLvl8/X4zGTFnDtCeuyjZd+FTAqrrnM0o88MR4HeNZXx5OEdqCI6KgAg2wreVNbG8K6l6G9lrcWtwXCpZLOuHzJauakLNX29vcuXA0uAIOwSH4kptwVt60PXTsQNG6ywgz/BkpJjlvL3MjfeqZV9tCtdR5Gy0bhb7UEPTuVD89SmqO73Ch9IuG+yh86zbqjqQMdhis4orXWSla984Vpso5ydhUFuFAwMOdSbniY+T3grAbpGnDvAR1IkjbYByvYUhqee032XxE/cwysEknu7KRSlYa8mqWQ69DMcbV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199015)(38100700002)(38350700002)(6486002)(478600001)(8936002)(2616005)(316002)(52116002)(6506007)(66476007)(6512007)(41300700001)(66556008)(66946007)(86362001)(36756003)(26005)(83380400001)(44832011)(8676002)(4326008)(186003)(1076003)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pQVsp7XDB/U5CR+XBUzuSKpEqgZ67lSNvYjGzSe6/VEUwCRWSVJPdEyWdLGX?=
 =?us-ascii?Q?EUFu3rn1/Le5EynGYbK4mDLDYzSpkoz1z2giKfxk6CfkB8vKX88/ayqXM7WO?=
 =?us-ascii?Q?OgQQVTe6Z1O+KoZD1DsMTsyMIhwlVTraVV12jDW42Rk/wQVYCvz9v1xUF4Rl?=
 =?us-ascii?Q?WTAQhoOi9mWL4mZArMHVmnPHoUrdBUk2Kfqg2Hgh/kAXgESu0elLdiEJPgp5?=
 =?us-ascii?Q?acYR35jcbW4SO4SRF6jsrrqiKRXijsJtrha/G+mOVCJvPqsc8gufb6bBh8hR?=
 =?us-ascii?Q?/8AwKRRvWTcjBKdPW0aQB1GEeHfSXXutP7eSa5882bNwme5jXXCOKsx+0CZJ?=
 =?us-ascii?Q?TaoYqkHG7JHHz4IZ/q2a59MJEV8PriPfe1RlxgpDddL/ov7KUPaWPvadXZzq?=
 =?us-ascii?Q?jsTcIMDXhleKcFYUfXhy1KlBg9YRuwE7GB1Db//HH1znxwGD4UgjfatOXbvK?=
 =?us-ascii?Q?pQ7yejZBtCMblXeRO98I5Xxfqr4RddG/zfybwYM8vwuw2Lf6qBiTqFGGWlc0?=
 =?us-ascii?Q?vyRwANOM01K2L673SF56I1bpraUePhoIvYH09aF89nVEUyPggRNO9+S5vNJ7?=
 =?us-ascii?Q?IR90R69Sute0A9u0UBsneMpjZPeAub1NkOCuqcVzufkIxxQG2kLzV5oOm2rD?=
 =?us-ascii?Q?2lAN1RRfBgpDEqHBioqstp3/MCNHn1EbYd11anCZMppKb4K61qA7rCMpTPEq?=
 =?us-ascii?Q?nzZ+6fVnfdor+eMQgyaJBvm98y6QeIx5uz058bJ0QVNrj7jON+kuhdclksTc?=
 =?us-ascii?Q?Z/mUxy8jJrYfGmMrVvnjOaGbpouHCwWW2jA4R8nQM94w2d+zXB7cbCOIisEo?=
 =?us-ascii?Q?zCzTnecVbItcNJ1mYulzEJsyqGyRA3uk5hGbTr72N5vZgBJJ72sJxs1N1Oul?=
 =?us-ascii?Q?OCZ+VPqr3cqvojxHWdptZ9zYsPQdwck0boNzbivaOeyKLhREcmNCxMicvp4h?=
 =?us-ascii?Q?RzkIh7NWpbns0cI6Ligw4ekj6WR+msGYQLkYRsGegJjKFxI4w0XO8TMHuRpB?=
 =?us-ascii?Q?h3KFQAigrS0xI/mXdGX7BDR/trDbmcHuldcNpJB/tyRHXLjPGhWKNMm3mo+g?=
 =?us-ascii?Q?w5CU68ratKuxhMX3wuGgcaUNGQF4qVgKQIqJNYTFdRrY+VoeTUrtFG9fFExT?=
 =?us-ascii?Q?BsxNKCw53rUCKYystFDSWoK6MgCwLwdqdRAD84g4vA/wBU7DrYKos0KGIuQI?=
 =?us-ascii?Q?hg6wAG2wG/n+ROMWxxSapVyx4dQpPmqaQaQWEEUXZL3ysN5PaMIX1qZ+ba8g?=
 =?us-ascii?Q?CNO7HSDUwBlePfkDypuEcPwUAWBz8dOHJ7+/YLlMnc0Fodv5q1A/SG2QIsyk?=
 =?us-ascii?Q?JhA1NjuFzLu0DkLGPWKQPIo5bYmPR0PXcXRKXdglFzTZ3AOiWoAlTiqaNve8?=
 =?us-ascii?Q?UHOnedo7eypZ48xa8XQCmNtkyfi4ybbWUOujAu9O61Sj9H4VvFJk3d00yzIB?=
 =?us-ascii?Q?5bN6MNp6tUJtdBxcwB08dEiAcKxB1dFxz3ILhKDiEJKQr9hntBbo2j1ST2YZ?=
 =?us-ascii?Q?0cgWM3WmSL3nFWiojtsagPyp+J3T+oTZXNzEM7/75JoHZ4LiK6PNehKthSDR?=
 =?us-ascii?Q?wCdlo7mMsGDcRGpEV+YlsFjmpFXpQ/zR/dZx4qxM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5410af7-f5e7-4b88-08a0-08dac314791d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 12:09:52.7554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/TTxZPLm7nRapraB2npy/ufO9WsPJ2Z7Vg7w+7z0k6MrvOpiQyCssAb1/cWw306N8aoFysmjKjp1wnStU3KQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7097
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add runtime pm support to manage the lpuart clock.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
No change in V2.
---
 drivers/tty/serial/fsl_lpuart.c | 60 +++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 2654d86f52a4..5b3962bb0de2 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -19,6 +19,7 @@
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/pm_runtime.h>
 #include <linux/serial_core.h>
 #include <linux/slab.h>
 #include <linux/tty_flip.h>
@@ -233,6 +234,7 @@
 
 /* Rx DMA timeout in ms, which is used to calculate Rx ring buffer size */
 #define DMA_RX_TIMEOUT		(10)
+#define UART_AUTOSUSPEND_TIMEOUT	3000
 
 #define DRIVER_NAME	"fsl-lpuart"
 #define DEV_NAME	"ttyLP"
@@ -793,6 +795,20 @@ static void lpuart32_start_tx(struct uart_port *port)
 	}
 }
 
+static void
+lpuart_uart_pm(struct uart_port *port, unsigned int state, unsigned int oldstate)
+{
+	switch (state) {
+	case UART_PM_STATE_OFF:
+		pm_runtime_mark_last_busy(port->dev);
+		pm_runtime_put_autosuspend(port->dev);
+		break;
+	default:
+		pm_runtime_get_sync(port->dev);
+		break;
+	}
+}
+
 /* return TIOCSER_TEMT when transmitter is not busy */
 static unsigned int lpuart_tx_empty(struct uart_port *port)
 {
@@ -2241,6 +2257,7 @@ static const struct uart_ops lpuart_pops = {
 	.startup	= lpuart_startup,
 	.shutdown	= lpuart_shutdown,
 	.set_termios	= lpuart_set_termios,
+	.pm		= lpuart_uart_pm,
 	.type		= lpuart_type,
 	.request_port	= lpuart_request_port,
 	.release_port	= lpuart_release_port,
@@ -2265,6 +2282,7 @@ static const struct uart_ops lpuart32_pops = {
 	.startup	= lpuart32_startup,
 	.shutdown	= lpuart32_shutdown,
 	.set_termios	= lpuart32_set_termios,
+	.pm		= lpuart_uart_pm,
 	.type		= lpuart_type,
 	.request_port	= lpuart_request_port,
 	.release_port	= lpuart_release_port,
@@ -2745,6 +2763,11 @@ static int lpuart_probe(struct platform_device *pdev)
 		handler = lpuart_int;
 	}
 
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, UART_AUTOSUSPEND_TIMEOUT);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	ret = lpuart_global_reset(sport);
 	if (ret)
 		goto failed_reset;
@@ -2769,6 +2792,9 @@ static int lpuart_probe(struct platform_device *pdev)
 failed_attach_port:
 failed_get_rs485:
 failed_reset:
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	lpuart_disable_clks(sport);
 	return ret;
 }
@@ -2787,9 +2813,30 @@ static int lpuart_remove(struct platform_device *pdev)
 	if (sport->dma_rx_chan)
 		dma_release_channel(sport->dma_rx_chan);
 
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	return 0;
 }
 
+static int __maybe_unused lpuart_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct lpuart_port *sport = platform_get_drvdata(pdev);
+
+	lpuart_disable_clks(sport);
+
+	return 0;
+};
+
+static int __maybe_unused lpuart_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct lpuart_port *sport = platform_get_drvdata(pdev);
+
+	return lpuart_enable_clks(sport);
+};
+
 static void serial_lpuart_enable_wakeup(struct lpuart_port *sport, bool on)
 {
 	unsigned int val, baud;
@@ -2935,6 +2982,10 @@ static int __maybe_unused lpuart_suspend(struct device *dev)
 			sport->dma_tx_in_progress = false;
 			dmaengine_terminate_all(sport->dma_tx_chan);
 		}
+	} else if (pm_runtime_active(sport->port.dev)) {
+		lpuart_disable_clks(sport);
+		pm_runtime_disable(sport->port.dev);
+		pm_runtime_set_suspended(sport->port.dev);
 	}
 
 	return 0;
@@ -2969,12 +3020,19 @@ static void lpuart_console_fixup(struct lpuart_port *sport)
 static int __maybe_unused lpuart_resume(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
+	int ret;
 
 	if (lpuart_uport_is_active(sport)) {
 		if (lpuart_is_32(sport))
 			lpuart32_hw_setup(sport);
 		else
 			lpuart_hw_setup(sport);
+	} else if (pm_runtime_active(sport->port.dev)) {
+		ret = lpuart_enable_clks(sport);
+		if (ret)
+			return ret;
+		pm_runtime_set_active(sport->port.dev);
+		pm_runtime_enable(sport->port.dev);
 	}
 
 	lpuart_console_fixup(sport);
@@ -2984,6 +3042,8 @@ static int __maybe_unused lpuart_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops lpuart_pm_ops = {
+	SET_RUNTIME_PM_OPS(lpuart_runtime_suspend,
+			   lpuart_runtime_resume, NULL)
 	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(lpuart_suspend_noirq,
 				      lpuart_resume_noirq)
 	SET_SYSTEM_SLEEP_PM_OPS(lpuart_suspend, lpuart_resume)
-- 
2.17.1

