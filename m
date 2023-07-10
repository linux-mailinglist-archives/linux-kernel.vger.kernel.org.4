Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B853A74CF8D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjGJILl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjGJILg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:11:36 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DBFDD;
        Mon, 10 Jul 2023 01:11:32 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 36A84RBn047544;
        Mon, 10 Jul 2023 16:04:27 +0800 (+08)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4QzxMj1FCxz2M5vH6;
        Mon, 10 Jul 2023 16:03:29 +0800 (CST)
Received: from ubt.spreadtrum.com (10.0.73.70) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 10 Jul
 2023 16:04:25 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     <linux-serial@vger.kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] serial: sprd: Fix DMA buffer leak issue
Date:   Mon, 10 Jul 2023 16:03:48 +0800
Message-ID: <20230710080348.4137875-2-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710080348.4137875-1-chunyan.zhang@unisoc.com>
References: <20230710080348.4137875-1-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.73.70]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 36A84RBn047544
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Release DMA buffer when _probe() returns fail to avoid memory leak.

Fixes: f4487db58eb7 ("serial: sprd: Add DMA mode support")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/tty/serial/sprd_serial.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 942808517393..e1f11382fc39 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -1203,7 +1203,7 @@ static int sprd_probe(struct platform_device *pdev)
 		ret = uart_register_driver(&sprd_uart_driver);
 		if (ret < 0) {
 			pr_err("Failed to register SPRD-UART driver\n");
-			return ret;
+			goto free_rx_buf;
 		}
 	}
 	sprd_ports_num++;
@@ -1222,6 +1222,8 @@ static int sprd_probe(struct platform_device *pdev)
 	sprd_port[index] = NULL;
 	sprd_ports_num--;
 	uart_unregister_driver(&sprd_uart_driver);
+free_rx_buf:
+	sprd_rx_free_buf(sport);
 	return ret;
 }
 
-- 
2.41.0

