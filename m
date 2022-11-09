Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929DC622965
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiKIK7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiKIK7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:59:17 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20629.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331A913CDB;
        Wed,  9 Nov 2022 02:59:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CB+C9TOI08OuRXFkSdBER1gtcV5nSorVFg9cgoawJagcoinuXyrko51ZvDDF19DOtaU2WQ2fAdG2LoIci8SSfbUtTqRXzRHsBACo0dO+YfMbFKAhflOiRBu367lcro8uNilQcgTAjwMajCPV0NHtIclvHotK7h+sd1SjOJ+MVPkekgImgCuOioBoaX0ieZv3LUKSitqE3pPvgFPabBXuXXc/Zi+TSMmmIqBbRIBc/79P8XPSDXA6FfPJr7G9gP3p2swDMCyKgcAcl8sUA0+cshNIZwCqUnMKffPq3jR4kPJRn/yU300Jh7Jg4dgVaLfuUDc2ahMFMG5dE+yg0tPTjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBqbLX6EUudZPxFb4ReckpPzBhyyGwwhFdF3x9HCgv0=;
 b=HprgEXzYZmtmbOo/DMXF1ToMGPyiqumVOHLRnACTIXMsHklNl8Kvj8lKeR0KJiR1sZuU7m64PybBQFFfpg0lf41IoDNLal/D0Ka6ZcDLUsqTEqzFqB3i4JB5/Z0+PEjONQlXZG3SmPu2MHzfraUHz5OWNEvfXyadIoVP0RkI5lR4b/zaFcDUPeC/jtM91eP4fMdtV0ftIC/maBYbx/zPaAKHyJB2DFcwEkEBX0ZepKZ6jOaWbHBxe9qlZSyKKhV1+fLsEU2OxVJ2jnqV1WfcIKZPsQuglizxDb/HTrqYMWqBlPzpTZEhTOzwRtkxd36M/WImhaWc2xSIFCOUQ/6ERA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBqbLX6EUudZPxFb4ReckpPzBhyyGwwhFdF3x9HCgv0=;
 b=UApWVHySOGYZWxVz/+g8CMFL0Mufb5YGZF7KV0ufZTnJKMzezAUQjvMU5ZEJa9Kn9j4CJGSwA81FbFhWWYFgbkWeXo3f67bA4mxLbhyxBOuotBUFgBeakQL5jJRt4DdAEI/imKekAmZT9YfQ29UQt1KeuuLrIJu2ZMPJuqCnFYI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8515.eurprd04.prod.outlook.com (2603:10a6:20b:342::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 9 Nov
 2022 10:59:08 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d%3]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 10:59:08 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 2/2] tty: serial: fsl_lpuart: Add runtime pm support
Date:   Wed,  9 Nov 2022 18:56:59 +0800
Message-Id: <20221109105659.17381-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221109105659.17381-1-sherry.sun@nxp.com>
References: <20221109105659.17381-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|AS8PR04MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b64579-2ea2-4092-c54a-08dac2416cb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pL93gJFQLRXhFXyq9y//cYTiJYu67W6JQQKuetB3PzmU+iWVdNcqQqtcejtk8ru7fHHAtOxQ+h9BVJ/NTStG0wYHJZvpyVKwtS1zg4vZ06LJdnKwI8RZapaUeNud3vjmPn/l8c7bv9TwAWJbn2U2jYxWPmDOx4BG5rO4doi3qND4kk1Mbrrn/emeKr+0PlzTagOXbTG81liggTDer67sM25LaL/aXxxYo5TEA3ris3jeapplkLR6xtXuS5CYM8/Yx5iQKvXWCu9SctoRE17n1+TeiAWtlUC6rAaypLgfXyVfaxaRV3vNeswNSt2uB86GjzDp9edYHHOHHj8J9LlAzWIQqW1ZXjKAUWWPT5q0nvgB0pv4R+wBdHD0dP8YuTyR6Alg96aHvNtL6NPIQaeZ3BG9/jPk2gVHDKfILXGBeTS1C9P5qJuF6IwJTe5rh9z8ysrB2JpoUq+BRVLrUWxNYnQrPkcaSAFEFxGmMcsR0g6E/xkV5mT7JsXu7jb8GMETQ0e53htyWcpxryuuJ5DRXK8uWcdgX3ynThxoPH976y4HAO9fEla5aIwr+j9UsI1ZRSiSfu3GGuIRnVKST0puLssnZhZ3bkQvNyxv23wdlfHEEaqdxWX4OB7q/mULYtxmJU7LawZbuwF4c7PIkHx8p4p/aoxnBSMqmvvDMp/qzG14SwkGHMGsDgQJjRE2AbX6kunqIlBbCB/oJ1BClXEJBo/nnbxedQaNq8xC8AkQIGFcHjXJcaZmiuATCYs+/L6UblPxEsHfczk55jH2pqb/uA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199015)(36756003)(86362001)(44832011)(5660300002)(52116002)(2906002)(26005)(6512007)(83380400001)(38350700002)(38100700002)(1076003)(2616005)(6506007)(186003)(66946007)(66556008)(66476007)(316002)(478600001)(41300700001)(4326008)(8936002)(6666004)(6486002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i5P802hhpmtrHxL6oITDZgr1ogiE4rrh8JFV5PFmBRTx3kr0cK4Hhxng5J0r?=
 =?us-ascii?Q?N0T0J7i+/ZvwyOVAcBezOPluAERpQRc5569E6YKi/D5gh55kdWm9pI0YqwYb?=
 =?us-ascii?Q?0mHiw2YoyPmGLaERqGUrOWLxuLBIfHbg1xOF04FEVBgbpkY6YzomuzM5CejB?=
 =?us-ascii?Q?WEj/fXnbBEhjxz3BdeThDGRb4rbp5j8QQaY1UeECPCt/NiRNV2G5sISVOp+/?=
 =?us-ascii?Q?KSGFL7wO/Uy4dC/APjAYpu7m4xP/wzELYOJdsWVZn3f+z9/ekjvmUH+BrN8j?=
 =?us-ascii?Q?f6Ec63VfuT4oUVCksqDPxWxOG2sjITUEOC3hSelLhSyn7GVXyE8Yzg17E1A3?=
 =?us-ascii?Q?3AzjuIX3x3Dszp6XsIfXs9ZezHQ8jmoOH9XPjmHcRyHbpTIynURW6OH01L8W?=
 =?us-ascii?Q?lxa4SOj01dlMRHBrRGEL7DqbujTFQZYSLrt6/6Ed/lmZXSFjWe9n/YMfIb12?=
 =?us-ascii?Q?JxlRUZLCkQ72iTVQNncQiix6s9nMG3li+LAQ/dbb53CsJssFdO+QClQYojRO?=
 =?us-ascii?Q?f85ApAIdQZRRjHldJrTd+Y7fHF+dpx71c/J6k2pNPVHZjJ9v/MHOLp5fVdOe?=
 =?us-ascii?Q?Z6pukFH9O/onQKlV+SN4U3Uvfg5Qx/9a7D/zYT5pDX5HymHV3W1w9GLEt0wS?=
 =?us-ascii?Q?dpqiMjqZ4brYDe2zNSyPGxPD9t2BnLJ8cPrAMukzlXwIyNshkEgyhJ70t+bg?=
 =?us-ascii?Q?1uPKalIs7H2Tpe3/E2QEX4+qWa5LBc+V+YkhlqWoQxWLKSOxg9lIn5Hlxhv8?=
 =?us-ascii?Q?IsRsEnVBmBzmEbW5zxT+tTwgEozAYa4sEtLjduRBYFRAD2rgIW+2tkvnDG6X?=
 =?us-ascii?Q?s6w78ymJzNXb1X5jzKTn076a5krHw3XXy/Wv7wTsAMajjRDlcQOrecbexbTQ?=
 =?us-ascii?Q?Rgu6/F0f7Vj1kX+mDpXKggIH1StRxJNmTuAnNWu4dySoCVHY4QzjFWkp1PJy?=
 =?us-ascii?Q?y7T/iuTa+dbOf0gGwpb4hgdThg8ti0URFySVSgbFrWcMDHalcpD6yNfnmXaF?=
 =?us-ascii?Q?YlhE2f4FL+d5RwTlEpP9lfJhjVYoIHItMO2E+7byTnqaiScFEgCaEf0kg0mt?=
 =?us-ascii?Q?44RuSa9L2sE3JDHZFH9gyySduYDKs/ICbPVOtxn6VWlZGJxXMLCmA79QrJ2Y?=
 =?us-ascii?Q?j8u4H1a7Kgf90wKjaD+LWxIrkAr4w2VQ66gJFTPgUUnalYBd76+n/WpLS9/M?=
 =?us-ascii?Q?d+NO78qA7MZ85fGqmIrWSexlI9bvU9WanjkPGhKGEuWZgxy9ddonF9XpCNwJ?=
 =?us-ascii?Q?XDhcKuVGkyFGXsqgxvoyMEeQZ/jJGmIM4UC13k8kP7aK6FDWJCcXZiBEvB/a?=
 =?us-ascii?Q?4HrDi98BFhJS0XU5PyXnIRmjfbG7wz9n1hvGcM3aCOM2gN/3oCsFLlJaIhdF?=
 =?us-ascii?Q?kRJgwbRkBZzT1u7WeU/RCw21Pve2uBxrZCDFnWsxWFSVRoU3xccKWJl5y/a1?=
 =?us-ascii?Q?Gb0kD5sFFhUR+5uTjET1XFNpHeX2nkLXEwl/pZNdp9cJowy8Nj8aBJxXF1YT?=
 =?us-ascii?Q?fFG3nmBri+Ip+5548B9eIpxHjz2cUcWLIuORP/U38cTAwDvAdSMI1OCNfs5c?=
 =?us-ascii?Q?+dyE7+48FKArXKz/6msKPf0pFjx8eCV6dbIS1ZTY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b64579-2ea2-4092-c54a-08dac2416cb0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 10:59:08.0720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCRtx/uO/1ZD7zjzAzX0lyLav2fW2mzeAJOWCX1PtpvGCvDEDxMUvij2uaDcOymYxL7pnpXAcm9/deUjZaHuZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8515
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add runtime pm support to manage the lpuart clock.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 60 +++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 474943cb06b2..e678a7aaf7e4 100644
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
@@ -235,6 +236,7 @@
 
 /* Rx DMA timeout in ms, which is used to calculate Rx ring buffer size */
 #define DMA_RX_TIMEOUT		(10)
+#define UART_AUTOSUSPEND_TIMEOUT	3000
 
 #define DRIVER_NAME	"fsl-lpuart"
 #define DEV_NAME	"ttyLP"
@@ -795,6 +797,20 @@ static void lpuart32_start_tx(struct uart_port *port)
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
@@ -2243,6 +2259,7 @@ static const struct uart_ops lpuart_pops = {
 	.startup	= lpuart_startup,
 	.shutdown	= lpuart_shutdown,
 	.set_termios	= lpuart_set_termios,
+	.pm		= lpuart_uart_pm,
 	.type		= lpuart_type,
 	.request_port	= lpuart_request_port,
 	.release_port	= lpuart_release_port,
@@ -2267,6 +2284,7 @@ static const struct uart_ops lpuart32_pops = {
 	.startup	= lpuart32_startup,
 	.shutdown	= lpuart32_shutdown,
 	.set_termios	= lpuart32_set_termios,
+	.pm		= lpuart_uart_pm,
 	.type		= lpuart_type,
 	.request_port	= lpuart_request_port,
 	.release_port	= lpuart_release_port,
@@ -2747,6 +2765,11 @@ static int lpuart_probe(struct platform_device *pdev)
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
@@ -2771,6 +2794,9 @@ static int lpuart_probe(struct platform_device *pdev)
 failed_attach_port:
 failed_get_rs485:
 failed_reset:
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	lpuart_disable_clks(sport);
 	return ret;
 }
@@ -2789,9 +2815,30 @@ static int lpuart_remove(struct platform_device *pdev)
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
@@ -2937,6 +2984,10 @@ static int __maybe_unused lpuart_suspend(struct device *dev)
 			sport->dma_tx_in_progress = false;
 			dmaengine_terminate_all(sport->dma_tx_chan);
 		}
+	} else if (pm_runtime_active(sport->port.dev)) {
+		lpuart_disable_clks(sport);
+		pm_runtime_disable(sport->port.dev);
+		pm_runtime_set_suspended(sport->port.dev);
 	}
 
 	return 0;
@@ -2971,12 +3022,19 @@ static void lpuart_console_fixup(struct lpuart_port *sport)
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
@@ -2986,6 +3044,8 @@ static int __maybe_unused lpuart_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops lpuart_pm_ops = {
+	SET_RUNTIME_PM_OPS(lpuart_runtime_suspend,
+			   lpuart_runtime_resume, NULL)
 	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(lpuart_suspend_noirq,
 				      lpuart_resume_noirq)
 	SET_SYSTEM_SLEEP_PM_OPS(lpuart_suspend, lpuart_resume)
-- 
2.17.1

