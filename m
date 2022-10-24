Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE5A609D3C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJXJAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiJXJA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:00:26 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFC639BA5;
        Mon, 24 Oct 2022 02:00:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqUPS0SMCJ1Ts0Pkxxt8nKhr4+BG9tgEhasoyA6xdoTJkEs9FI+F+O9VfJJLkuJmDAE+bQe97hSP7K8LXS0aoIKIaCqcLnUr/bsEXlsP3jg0k6PDfuRsR1WmOk5VTOUucd8KM0fJYxe315cACBjOTRvKTlLrZPFzHvGpawFJ9SN8YYbb3JFMYUrEemuHb51oT7UJM3OcxtKk6XDKpkyKpLfNCCbU/UcvNXMw2250oJ6bDcemyvWgN5OuLPucWdziBFCTckP49A6mw9dxQPTWRKz1LKLCwWb4FyhYROiQks6cpSjPJAbYVxt1fqGz2FdNKA6o0nMhMYulxdMkK4IP7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+KMrE8QvBGWYsBXEjD97/u06LCRPDLmgqZJqB4F/pc=;
 b=fMF37daGkYivoDwZDQoVdV9qK/Yw6WEEaO0Nzd9ZfrkWnpY//RrpYVMcobQQZVJvxPJhSML08zblr4KjFY+ol41nP/8dLxgayRVwOS0ytz2tKWSctcH6HbO51ES0Ff9VaxisbZJNGbqk0b4m55anjEnltuV7j9rxk7ntCEp5TtzXFyLqw0vMjCt1Q+rgmfpXWvz34cRwx8U9AIomamapYtUbsrSqzo2xW6lprRRzMz4HIuhe8BSghwWsfFlbNGESpJIbfEZNsvn2fQKDjMxMyp1M4CzAZl0l5tzfiqTx/H7OjMOsXML4WeKhHjegQ1g783zd2H253bQoAGyVAG0heQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+KMrE8QvBGWYsBXEjD97/u06LCRPDLmgqZJqB4F/pc=;
 b=C6yh/jhuXDXjvCoi0rEXrLKkVO5oPAdrmMUTwJkL8bdHbATDMNpcMqWa79UaVVzLoPPEALzAR2NXqPBqaxCYOHoTD4r1Mqw3W37Wp3LSDK6sNEUr4fkqqZuW03mftN6+6LHEBtUGCSDMYvLkrY6AmXuXWyNEoQHLpwdUxW8JlYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM9PR04MB8177.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 09:00:19 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::84cf:df3f:2012:79ea]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::84cf:df3f:2012:79ea%5]) with mapi id 15.20.5746.025; Mon, 24 Oct 2022
 09:00:19 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, lukas@wunner.de,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V4] tty: serial: fsl_lpuart: don't break the on-going transfer when global reset
Date:   Mon, 24 Oct 2022 16:58:44 +0800
Message-Id: <20221024085844.22786-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|AM9PR04MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eacc91a-be1c-4c71-bf5b-08dab59e2cd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xhstw5fANVw1oa8kaIEbUDuHbZRCmWkpkgwvZGW3JOl8mDVf4ie6fK69aOBFuHHnHCCLawUpV0CJ0y2K9wh6f5WtNi1XmqUhovqzbLE7yfpXntKfUs5wSYWFXAxGvXv8QHhz2YrX0/iNQdxj8GfNxyoURS/lhaM02G5Eo5IVMnvNCsM417aV6liCd8sszZdaIevgj93UITM6Uiow/9KqOpse/jlZreYKcRINc4MYxZixBtKrMAb8/X55uUHjYfx/FEEi5WpGrwQPiVnbOuopUazDEv7MDzZFbwHoa+coV672742SCIIpnywg0dISIdTClUFefaOxigxXESYRHTz9dCt1z7yCnDbKqDuq3yzSZrQc1yz4b0plbbVlA5Xkj1PFndQSiQS+E1gWClky11QI5/1V6dMPOP6K6hXN6cdzIyOYYzfjjl2uO8qzPUwVy6uxIkDvVQPIlYlhZS3IIj58v8vega21ueXeP7cwHg3FoTiOTSjNXqg4oLz2l1MF7CohOD71/jQeXf9LO46PZi7wIlAf/ghAG7ItDXt15n0M0aJg19y7FVUk2GTQ2aj5S7s1KDoMHjC1Ndp3VXtVRMPkPexS1Q0LIoNvxc7EuEqtidJgHSHi3FpS/ZlQDg7FLk3S5nLeJz1G9/VbtzQLVG7szmnnnvXasHqUO0nDc7soFZ7c4F0ENw2d1ux0/pVAHYgb5XkAUkW4HK8M+b2sXJU8M/l4H/PfjSlIa+aLbtVymb/UZDLgDs6sIYt8nqywMQmGYJMszXOP3/HRSqTNkOkCsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199015)(36756003)(44832011)(2906002)(5660300002)(8936002)(66946007)(66556008)(66476007)(8676002)(4326008)(41300700001)(86362001)(316002)(6506007)(26005)(6512007)(52116002)(83380400001)(186003)(1076003)(2616005)(38100700002)(38350700002)(6666004)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lk21kGdUqZYk2KtWpEvX1MaW2F/koY4vNGJiYRYsSRxuDv96+skWcgk9uT/s?=
 =?us-ascii?Q?wpmk/nBXZDJVNiN5f8rE5hThWGCksQMsvQiXRgLtQ55hYfHSb64Q+8jgmNgE?=
 =?us-ascii?Q?RglWCuiXlJsbnBeYwRMeijYsWljM2fdMXOUlf0Q1+fWFyIkiuu+Asc3TfWqQ?=
 =?us-ascii?Q?XvHWBVGBsj1iVOAQfw0y0raRT05ziMIBCWrxQQTgCemn72mfYYEEWfQGVuJI?=
 =?us-ascii?Q?jzapbFQzrUwYkCs5zJUcwrOVsMUg27d73ejEuCnl0X5jQc3zVjdOmhJ9HYwa?=
 =?us-ascii?Q?/zW3wHpYv20v+uxbipO6vI0aRFE8vThYdC1DypHGty0bEX61hItFK/I6tCMl?=
 =?us-ascii?Q?epXFxqS/yOKYlt2XkLvI7aSg0E3qI7V7Qsn6NgkWVIRJeHvvRadB1WfyEufJ?=
 =?us-ascii?Q?F38ELX6PhGoxolG9CAq4v2+cpjOzGTIYoTmgZu6/pKzJpGZYtA+VPyIXDujr?=
 =?us-ascii?Q?eDFkgKPIfDJ2VKR1/w6O9j31DK52rPMt/kMTl38845bIq+n3Zph4F8K5SwN2?=
 =?us-ascii?Q?QWk4BfZli2jDQjp+fIE+oNBJPStVQBM5AJxJYFe1YJvtVjkEDMTOeAgjP2K2?=
 =?us-ascii?Q?6UovJLchAQQCTLFVw4A+6jyldVJs5fl7M4Zbgbm/zak4qy5z37IAyzsuPrRY?=
 =?us-ascii?Q?rBNG+PTySmhJdyELEr8yj0VmKtPMcZSuBQdWIrtDOT3iMJktoi5Td03lQoji?=
 =?us-ascii?Q?7T82255MLu1UmPOR+eVGWdkXvF8rRmW3hH5hzCU2vJA6ACeVjaOJFL/Cn4Vl?=
 =?us-ascii?Q?wDLYheAn/CM+LU1XhQ3OFslg5z+EPkG4fMDNzrg2ufGTEa9+SOfee50QBQ9w?=
 =?us-ascii?Q?YQeA5KFiPumyAn2vzeWZT+45VoBXw86rLAd0H848PLXioagum+B1z2MVZ5vS?=
 =?us-ascii?Q?R1w4UQ8sqeOc+Av5CF/Nt9d3bXc9wjVuLVOeC/q7/PE84JbZMFZiDKpJZAro?=
 =?us-ascii?Q?600R0pVNKr1KmVktD8zAIoqiU1K0iUPeZ0smlekTvqhZ+4KTUIP/8ayXdFtI?=
 =?us-ascii?Q?xg0KHEne683aoDmcOS9Iz6yxyjFmjHIVWQv01oeJh+TkTrUUAs7D6/ovIbQh?=
 =?us-ascii?Q?NyIQuBUFQq9/vflfqFCUxxnARQ8LDjgNWjcQlBEJ/lGiWfCMZewNePOXSrHu?=
 =?us-ascii?Q?oxKliJTfOhZ6dB/pMajVTX7ccXzHen9W9oOaI6GpSsfS20CKErFSsWAWVOLQ?=
 =?us-ascii?Q?tK3gpHk/JzeWcrWzHm0OMfWjQk9jbXGJ/FZeDpmZVnLqLgq1q8PWUY7qCB+P?=
 =?us-ascii?Q?PjVMH9A8nEPfL+DunGSqTfLsuM/UL1Apxp5NVM5DRyvNmwDwPj4U99qoR3xn?=
 =?us-ascii?Q?kCjQIioqNgg1YCv5UM7+3IyscNJuE0sQNyh59s71oHacuK8f+Fek9xkLN4VF?=
 =?us-ascii?Q?sY+U5IjZOvbAkOYtzTKpMtKdEbCYMEDIQt3faM4xMqzyfMHGL35T7bfe6qkf?=
 =?us-ascii?Q?wOcL191CeJOGOkrxXHg4oRJ6p2ORyA4DecrsZXzwrf9ReIfi9MXCGdXmWQss?=
 =?us-ascii?Q?HxUMnVxQMT/5FmBz4HqEHD2gsM0WYiH1Owq2QOmF3wz3Vcvke69vLw8E9xBB?=
 =?us-ascii?Q?3X+MxzCUxOgKeuOnCbHc8lMJXfwy6ubbfjmDWEjV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eacc91a-be1c-4c71-bf5b-08dab59e2cd2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 09:00:19.0315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGmCFUiHtp84Fs5Sk2CP7p0h5joWI6Lh6/vRUVE5Hh+ts+NiqtyO3ugRTn9DSDYsN9VIva/ARblj3/Br5QZ8+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8177
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lpuart_global_reset() shouldn't break the on-going transmit engine, need
to recover the on-going data transfer after reset.

This can help earlycon here, since commit 60f361722ad2 ("serial:
fsl_lpuart: Reset prior to registration") moved lpuart_global_reset()
before uart_add_one_port(), earlycon is writing during global reset,
as global reset will disable the TX and clear the baud rate register,
which caused the earlycon cannot work any more after reset, needs to
restore the baud rate and re-enable the transmitter to recover the
earlycon write.

Also move the lpuart_global_reset() down, then we can reuse the
lpuart32_tx_empty() without declaration.

Fixes: bd5305dcabbc ("tty: serial: fsl_lpuart: do software reset for imx7ulp and imx8qxp")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
Changes in V4:
1. Use read_poll_timeout instead of read_poll_timeout_atomic as we are in the
non-atomic context.

Changes in V3:
1. Replace "engin" with "engine".
2. Use read_poll_timeout_atomic() to add a 100ms timeout when polling the
transmit engine to complete.
3. Restore the whole ctrl register after global reset to avoid any confusion. 
4. Move the lpuart_global_reset() down, then we can reuse lpuart32_tx_empty()
without declaration.

Changes in V2:
1. The while loop may never exit as the stat and sfifo are not re-read inside
the loop, fix that.
---
 drivers/tty/serial/fsl_lpuart.c | 76 +++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 67fa113f77d4..888e01fbd9c5 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -12,6 +12,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dmapool.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -404,33 +405,6 @@ static unsigned int lpuart_get_baud_clk_rate(struct lpuart_port *sport)
 #define lpuart_enable_clks(x)	__lpuart_enable_clks(x, true)
 #define lpuart_disable_clks(x)	__lpuart_enable_clks(x, false)
 
-static int lpuart_global_reset(struct lpuart_port *sport)
-{
-	struct uart_port *port = &sport->port;
-	void __iomem *global_addr;
-	int ret;
-
-	if (uart_console(port))
-		return 0;
-
-	ret = clk_prepare_enable(sport->ipg_clk);
-	if (ret) {
-		dev_err(sport->port.dev, "failed to enable uart ipg clk: %d\n", ret);
-		return ret;
-	}
-
-	if (is_imx7ulp_lpuart(sport) || is_imx8qxp_lpuart(sport)) {
-		global_addr = port->membase + UART_GLOBAL - IMX_REG_OFF;
-		writel(UART_GLOBAL_RST, global_addr);
-		usleep_range(GLOBAL_RST_MIN_US, GLOBAL_RST_MAX_US);
-		writel(0, global_addr);
-		usleep_range(GLOBAL_RST_MIN_US, GLOBAL_RST_MAX_US);
-	}
-
-	clk_disable_unprepare(sport->ipg_clk);
-	return 0;
-}
-
 static void lpuart_stop_tx(struct uart_port *port)
 {
 	unsigned char temp;
@@ -2636,6 +2610,54 @@ static const struct serial_rs485 lpuart_rs485_supported = {
 	/* delay_rts_* and RX_DURING_TX are not supported */
 };
 
+static int lpuart_global_reset(struct lpuart_port *sport)
+{
+	struct uart_port *port = &sport->port;
+	void __iomem *global_addr;
+	unsigned long ctrl, bd;
+	unsigned int val = 0;
+	int ret;
+
+	ret = clk_prepare_enable(sport->ipg_clk);
+	if (ret) {
+		dev_err(sport->port.dev, "failed to enable uart ipg clk: %d\n", ret);
+		return ret;
+	}
+
+	if (is_imx7ulp_lpuart(sport) || is_imx8qxp_lpuart(sport)) {
+		/*
+		 * If the transmitter is used by earlycon, wait for transmit engine to
+		 * complete and then reset.
+		 */
+		ctrl = lpuart32_read(port, UARTCTRL);
+		if (ctrl & UARTCTRL_TE) {
+			bd = lpuart32_read(&sport->port, UARTBAUD);
+			if (read_poll_timeout(lpuart32_tx_empty, val, val, 1, 100000, false,
+					      port)) {
+				dev_warn(sport->port.dev,
+					 "timeout waiting for transmit engine to complete\n");
+				clk_disable_unprepare(sport->ipg_clk);
+				return 0;
+			}
+		}
+
+		global_addr = port->membase + UART_GLOBAL - IMX_REG_OFF;
+		writel(UART_GLOBAL_RST, global_addr);
+		usleep_range(GLOBAL_RST_MIN_US, GLOBAL_RST_MAX_US);
+		writel(0, global_addr);
+		usleep_range(GLOBAL_RST_MIN_US, GLOBAL_RST_MAX_US);
+
+		/* Recover the transmitter for earlycon. */
+		if (ctrl & UARTCTRL_TE) {
+			lpuart32_write(port, bd, UARTBAUD);
+			lpuart32_write(port, ctrl, UARTCTRL);
+		}
+	}
+
+	clk_disable_unprepare(sport->ipg_clk);
+	return 0;
+}
+
 static int lpuart_probe(struct platform_device *pdev)
 {
 	const struct lpuart_soc_data *sdata = of_device_get_match_data(&pdev->dev);
-- 
2.17.1

