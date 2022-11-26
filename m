Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB1C639349
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 03:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiKZCME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 21:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKZCMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 21:12:02 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630025984F;
        Fri, 25 Nov 2022 18:12:01 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NJwFn4lBwzRpWM;
        Sat, 26 Nov 2022 10:11:25 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 10:11:59 +0800
Received: from ubuntu1804.huawei.com (10.67.175.28) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 10:11:58 +0800
From:   Yi Yang <yiyang13@huawei.com>
To:     <ldewangan@nvidia.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <yiyang13@huawei.com>
CC:     <linux-serial@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH, v2] serial: tegra: Add missing clk_disable_unprepare() in tegra_uart_hw_init()
Date:   Sat, 26 Nov 2022 10:08:52 +0800
Message-ID: <20221126020852.113378-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.28]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing clk_disable_unprepare() before return from
tegra_uart_hw_init() in the error handling path.
When request_irq() fails in tegra_uart_startup(), 'tup->uart_clk'
has been enabled, fix it by adding clk_disable_unprepare().

Fixes: cc9ca4d95846 ("serial: tegra: Only print FIFO error message when an error occurs")
Fixes: d781ec21bae6 ("serial: tegra: report clk rate errors")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
---
v2:
- it is also missing in tegra_uart_startup() if an error occurs
after a successful tegra_uart_hw_init() call, fix it.
 drivers/tty/serial/serial-tegra.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index e5b9773db5e3..1cf08b33456c 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1046,6 +1046,7 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	if (tup->cdata->fifo_mode_enable_status) {
 		ret = tegra_uart_wait_fifo_mode_enabled(tup);
 		if (ret < 0) {
+			clk_disable_unprepare(tup->uart_clk);
 			dev_err(tup->uport.dev,
 				"Failed to enable FIFO mode: %d\n", ret);
 			return ret;
@@ -1067,6 +1068,7 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	 */
 	ret = tegra_set_baudrate(tup, TEGRA_UART_DEFAULT_BAUD);
 	if (ret < 0) {
+		clk_disable_unprepare(tup->uart_clk);
 		dev_err(tup->uport.dev, "Failed to set baud rate\n");
 		return ret;
 	}
@@ -1226,10 +1228,13 @@ static int tegra_uart_startup(struct uart_port *u)
 				dev_name(u->dev), tup);
 	if (ret < 0) {
 		dev_err(u->dev, "Failed to register ISR for IRQ %d\n", u->irq);
-		goto fail_hw_init;
+		goto fail_request_irq;
 	}
 	return 0;
 
+fail_request_irq:
+	/* tup->uart_clk is already enabled in tegra_uart_hw_init */
+	clk_disable_unprepare(tup->uart_clk);
 fail_hw_init:
 	if (!tup->use_rx_pio)
 		tegra_uart_dma_channel_free(tup, true);
-- 
2.17.1

