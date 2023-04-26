Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431376EF457
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240808AbjDZMbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240547AbjDZMbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:31:20 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9171B4C04;
        Wed, 26 Apr 2023 05:30:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loG7U5cJ+Z3Pgdc6xcLTSqGj90kjbHHbYlFUWdHJDaPgaW8NaaZ5zrgUfWuQwODsdtTJffAWhr1dmU808TWinEJU8m4dwsidh5xaXJumxNuYN4EjnjyhBzsdzykaXI3xTu02OlrYKfhawtSXFjfeBu8e5rv+5GV9b1lo8zHdsWiskem6bzBvncLS53eDYlayk3d5VvEtUeBWBYvvguoqKArbXHhAP038ZfJwFWIdR5IX1Ygx5FQOBY1gMcHk+Jv3ut6JpSj5QKozgOXPVrfFIewuSxxYykvMvTVmZkb+x7bFN+aYFw3YIdIu/ZDJcbjTz6UwL6biDqRxAfEOvtYQSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opw2PFF3KyAbkOspTpPzGHVTV2PCAIJhDuzgh8smGOU=;
 b=NQAD4xQc3RVlDVF32GlwIAG7gZiL7sSB17arYfidSWS9T4FSALkaNxrLcsojI00Swf50GPQxlEO4+tJtH9gpH9HMRJNckgdPCCq02mr30zzvDSmchaSo6echHo7hJ+Fjt6cUocyT80kqfGgecQ5TkogSI9QSa+CNgFop6AKWVU7NaQ7zAYK3aDB4QBiIwYoQPmFK06+yx62wS+EJuwuGhK+sTBFV5+kgBekchGiwczZ9u035jfQtsnGIISCZX7usHkWHNBJ8Pc67rTZnEg75C00QnydqC65io33N+L6gICcsJMO15ZEjTh1yQCxeSWfZ+W6/ozinWLEwCLJ5+l8WSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=amd.com smtp.mailfrom=xilinx.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opw2PFF3KyAbkOspTpPzGHVTV2PCAIJhDuzgh8smGOU=;
 b=iWJnzcQaiDMn4z19qccVwzaQvBU61WxSJfadr9s/WbH42rSmlyrcuk8Shh2lnQuRJEm/739yjiAhmpL8VqTLFGQXMhZ4PkyislFHfzZzUUfYJ/lnIAKoEqpGYsCpnTm5sxQpBPFCkXbipM1iaoGhWXirxYgflXYFBH9aeB7notQ=
Received: from DM5PR07CA0094.namprd07.prod.outlook.com (2603:10b6:4:ae::23) by
 CH2PR02MB6791.namprd02.prod.outlook.com (2603:10b6:610:ab::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.20; Wed, 26 Apr 2023 12:30:30 +0000
Received: from DM3NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::63) by DM5PR07CA0094.outlook.office365.com
 (2603:10b6:4:ae::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Wed, 26 Apr 2023 12:30:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT046.mail.protection.outlook.com (10.13.4.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Wed, 26 Apr 2023 12:30:30 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 05:30:22 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.23 via Frontend Transport; Wed, 26 Apr 2023 05:30:22 -0700
Envelope-to: git@amd.com,
 manikanta.guntupalli@amd.com,
 michal.simek@amd.com,
 radhey.shyam.pandey@amd.com,
 shubhrajyoti.datta@amd.com,
 srinivas.goud@amd.com,
 manion05gk@gmail.com,
 jirislaby@kernel.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Received: from [172.23.64.1] (port=50338 helo=xhdvnc101.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manikanta.guntupalli@xilinx.com>)
        id 1preHp-0000lG-KD; Wed, 26 Apr 2023 05:30:18 -0700
Received: by xhdvnc101.xilinx.com (Postfix, from userid 90444)
        id A418A2131D; Wed, 26 Apr 2023 17:59:52 +0530 (IST)
From:   Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <michal.simek@xilinx.com>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jirislaby@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <michal.simek@amd.com>
CC:     <git@amd.com>, <radhey.shyam.pandey@amd.com>,
        <shubhrajyoti.datta@amd.com>, <srinivas.goud@amd.com>,
        <manion05gk@gmail.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: [PATCH 2/2] tty: serial: uartps: Add rs485 support to uartps driver
Date:   Wed, 26 Apr 2023 17:59:47 +0530
Message-ID: <1682512187-8828-3-git-send-email-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1682512187-8828-1-git-send-email-manikanta.guntupalli@amd.com>
References: <1682512187-8828-1-git-send-email-manikanta.guntupalli@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3NAM02FT046:EE_|CH2PR02MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: e701a54c-e124-4757-ea80-08db4652061c
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Da/C2N3PT0OYrZQF/RxIcJ9EsnAwxGVm0G9n3BM6gQJnJC91eVGXMgxI8Qy+NiEEcZCdv2Ybso61WlPzoXaYW2/1Cgdm6/a0GoGAY9nlC22q/HnO5JNKldxH4Xlkj/LXb6ebDqeuQCljX1gk38eoGGGzqmE9qNpSheAK7bvpg7LY7J2CzNjG+s235uRTiThONw5nRvC8jGP6r3v6C79V/gTbr1asMyzeqbg0c6mXG7uTiktGWtHE2/+y00caz4Q4uJbqCEwWc2WXSbAIM0lJXCehCkW7EPIWFbC7nm4EnRf1rdSvIg9TNU63st4mOZoHBeF1fegHGXi+xuqJX0Hau9uMGMFWZxjz8+phgSgR7Lf1hLZYJFmM+854dKudq+PFdg32LaNE0MUwG0DCD3RsufUyEnROeDWylehzmKTa01r2VGBlBTvYmHHPg41TW9PXcaEc/w7HNPldhDXTBBj8+yK6hzQ87OMTmVvADl6BuzlyV9muHFjaGutDKadye1hyNXWxGnoVpOnN6BzdtDJzdRVvAEAph0QRDa6TUErZvYbubN6Vx6aLA5Ws67DMacUu7D2/G+Tr215Kk3gTCpt+5TBeGE4nmwczfh6By36DzXa/Zs6/tNSwS+KBZkAwf+SMfblNXSMqjuuZBkohh/kTTasQWBK1ZtQ+Zk7FR7qeXV22Pok6rYfp1KBMpvctBaAzAsCGBv9kMr96jglWEOD//QHXIi3kWL2MK3YZacjuqytvIIvvMqAZEub5ZbDjQT7w
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(6636002)(54906003)(42186006)(110136005)(83380400001)(2616005)(47076005)(478600001)(36860700001)(7636003)(26005)(6666004)(356005)(316002)(82740400003)(4326008)(921005)(70586007)(70206006)(41300700001)(42882007)(336012)(83170400001)(186003)(6266002)(5660300002)(36756003)(44832011)(2906002)(40460700003)(7416002)(82310400005)(40480700001)(8676002)(8936002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 12:30:30.6096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e701a54c-e124-4757-ea80-08db4652061c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT046.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6791
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add rs485 half duplex mode support to uartps driver by making GPIO
high before tx and low before rx.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
 drivers/tty/serial/xilinx_uartps.c | 96 +++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 8e521c69a959..339b962460ee 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -23,6 +23,8 @@
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/iopoll.h>
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 
 #define CDNS_UART_TTY_NAME	"ttyPS"
 #define CDNS_UART_NAME		"xuartps"
@@ -193,6 +195,7 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
  * @clk_rate_change_nb:	Notifier block for clock changes
  * @quirks:		Flags for RXBS support.
  * @cts_override:	Modem control state override
+ * @gpiod:		Pointer to the gpio descriptor
  */
 struct cdns_uart {
 	struct uart_port	*port;
@@ -203,10 +206,16 @@ struct cdns_uart {
 	struct notifier_block	clk_rate_change_nb;
 	u32			quirks;
 	bool cts_override;
+	struct gpio_desc	*gpiod;
 };
 struct cdns_platform_data {
 	u32 quirks;
 };
+
+struct serial_rs485 cdns_rs485_supported = {
+	.flags = SER_RS485_ENABLED,
+};
+
 #define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
 		clk_rate_change_nb)
 
@@ -305,6 +314,27 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
 	tty_flip_buffer_push(&port->state->port);
 }
 
+/**
+ * cdns_rs485_tx_setup - Tx setup specific to rs485
+ * @cdns_uart: Handle to the cdns_uart
+ */
+static void cdns_rs485_tx_setup(struct cdns_uart *cdns_uart)
+{
+	gpiod_set_value(cdns_uart->gpiod, 1);
+}
+
+/**
+ * cdns_rs485_rx_setup - Rx setup specific to rs485
+ * @cdns_uart: Handle to the cdns_uart
+ */
+
+static void cdns_rs485_rx_setup(struct cdns_uart *cdns_uart)
+{
+	gpiod_set_value(cdns_uart->gpiod, 0);
+}
+
+static unsigned int cdns_uart_tx_empty(struct uart_port *port);
+
 /**
  * cdns_uart_handle_tx - Handle the bytes to be Txed.
  * @dev_id: Id of the UART port
@@ -313,12 +343,17 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
 static void cdns_uart_handle_tx(void *dev_id)
 {
 	struct uart_port *port = (struct uart_port *)dev_id;
+	struct cdns_uart *cdns_uart = port->private_data;
 	struct circ_buf *xmit = &port->state->xmit;
+	unsigned long time_out;
 	unsigned int numbytes;
 
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED)
+		cdns_rs485_tx_setup(cdns_uart);
+
 	if (uart_circ_empty(xmit)) {
 		writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IDR);
-		return;
+		goto rs485_rx_setup;
 	}
 
 	numbytes = port->fifosize;
@@ -332,6 +367,21 @@ static void cdns_uart_handle_tx(void *dev_id)
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
+
+rs485_rx_setup:
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
+		time_out = jiffies + usecs_to_jiffies(TX_TIMEOUT);
+		/* Wait for tx completion */
+		while ((cdns_uart_tx_empty(cdns_uart->port) != TIOCSER_TEMT) &&
+		       time_before(jiffies, time_out))
+			cpu_relax();
+
+		/*
+		 * Default Rx should be setup, because RX signaling path
+		 * need to enable to receive data.
+		 */
+		cdns_rs485_rx_setup(cdns_uart);
+	}
 }
 
 /**
@@ -829,6 +879,9 @@ static int cdns_uart_startup(struct uart_port *port)
 		(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST))
 		cpu_relax();
 
+	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED)
+		cdns_rs485_rx_setup(cdns_uart);
+
 	/*
 	 * Clear the RX disable bit and then set the RX enable bit to enable
 	 * the receiver.
@@ -1455,6 +1508,25 @@ MODULE_DEVICE_TABLE(of, cdns_uart_of_match);
 /* Temporary variable for storing number of instances */
 static int instances;
 
+/**
+ * cdns_rs485_config - Called when an application calls TIOCSRS485 ioctl.
+ * @port: Pointer to the uart_port structure
+ * @termios: Pointer to the ktermios structure
+ * @rs485: Pointer to the serial_rs485 structure
+ *
+ * Return: 0
+ */
+static int cdns_rs485_config(struct uart_port *port, struct ktermios *termios,
+			     struct serial_rs485 *rs485)
+{
+	port->rs485 = *rs485;
+
+	if (rs485->flags & SER_RS485_ENABLED)
+		dev_dbg(port->dev, "Setting UART to RS485\n");
+
+	return 0;
+}
+
 /**
  * cdns_uart_probe - Platform driver probe
  * @pdev: Pointer to the platform device structure
@@ -1597,9 +1669,30 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	port->private_data = cdns_uart_data;
 	port->read_status_mask = CDNS_UART_IXR_TXEMPTY | CDNS_UART_IXR_RXTRIG |
 			CDNS_UART_IXR_OVERRUN | CDNS_UART_IXR_TOUT;
+	port->rs485_config = cdns_rs485_config;
+	port->rs485_supported = cdns_rs485_supported;
 	cdns_uart_data->port = port;
 	platform_set_drvdata(pdev, port);
 
+	rc = uart_get_rs485_mode(port);
+
+	if (rc)
+		goto err_out_clk_notifier;
+
+	cdns_uart_data->gpiod = devm_gpiod_get_optional(&pdev->dev, "txrx",
+							GPIOD_OUT_LOW);
+
+	if (IS_ERR(cdns_uart_data->gpiod)) {
+		rc = PTR_ERR(cdns_uart_data->gpiod);
+		dev_err(port->dev, "xuartps: devm_gpiod_get_optional failed\n");
+		goto err_out_clk_notifier;
+	}
+
+	if (cdns_uart_data->gpiod) {
+		gpiod_direction_output(cdns_uart_data->gpiod, GPIOD_OUT_LOW);
+		gpiod_set_value(cdns_uart_data->gpiod, 0);
+	}
+
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, UART_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_set_active(&pdev->dev);
@@ -1646,6 +1739,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
+err_out_clk_notifier:
 #ifdef CONFIG_COMMON_CLK
 	clk_notifier_unregister(cdns_uart_data->uartclk,
 			&cdns_uart_data->clk_rate_change_nb);
-- 
2.25.1

