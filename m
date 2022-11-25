Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF8063872D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiKYKO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiKYKOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:14:54 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4272A3E084;
        Fri, 25 Nov 2022 02:14:52 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NJVyD23HgzJnsl;
        Fri, 25 Nov 2022 18:11:32 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 18:14:16 +0800
Received: from ubuntu1804.huawei.com (10.67.175.28) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 18:14:16 +0800
From:   Yi Yang <yiyang13@huawei.com>
To:     <ldewangan@nvidia.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <yiyang13@huawei.com>
CC:     <linux-serial@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] serial: tegra: Add missing clk_disable_unprepare() in tegra_uart_hw_init()
Date:   Fri, 25 Nov 2022 18:11:09 +0800
Message-ID: <20221125101109.175394-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.28]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Fixes: cc9ca4d95846 ("serial: tegra: Only print FIFO error message when an error occurs")
Fixes: d781ec21bae6 ("serial: tegra: report clk rate errors")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
---
 drivers/tty/serial/serial-tegra.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index e5b9773db5e3..abc5039eb273 100644
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
-- 
2.17.1

