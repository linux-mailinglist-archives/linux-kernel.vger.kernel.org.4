Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC5C62FB26
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242458AbiKRRGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbiKRRGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:06:48 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E8F28736;
        Fri, 18 Nov 2022 09:06:46 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AIC9udW020529;
        Fri, 18 Nov 2022 18:06:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=selector1;
 bh=GEsgskyYzb0RHzR+1jCrcUioio0/GVuMkcP/vFdV+os=;
 b=wiHjAhLR1klYjxzFm5LtzYeDN+ijnuhwKr7z9wQyF407U0ntZFc735hkGdT/T5HUhICT
 Y/bbF3F0Rf6KW5alWcqzrb7e2TGtq9H/9fw5sG5mXjuvosMgEaUY7Si6434lB7SlI1WG
 nGAYbx8qKuyh7gzYxamT18acO9nMnwmPRG76ftTWJ0pWddjYF7hpe12GQDvklakNcP9h
 vECAXCjGjYCnOCFDhLkT3BpnBOrbGeREdfi/Hu0g0qySLkbkN8dX3Oc70uaFW4CKaacf
 TAxbeFEr5ETLPBz1sHh5GZnyaKMN7RsnSHv16PcdxyIjqA6KyB8RBZ4gDj/eTvXwKnRb uA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kx0m9d8rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 18:06:30 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3599610002A;
        Fri, 18 Nov 2022 18:06:24 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 70E93252241;
        Fri, 18 Nov 2022 18:06:24 +0100 (CET)
Received: from localhost (10.201.20.168) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.32; Fri, 18 Nov
 2022 18:06:24 +0100
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Valentin Caron <valentin.caron@foss.st.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] serial: stm32: move dma_request_chan() before clk_prepare_enable()
Date:   Fri, 18 Nov 2022 18:06:02 +0100
Message-ID: <20221118170602.1057863-1-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_04,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If dma_request_chan() returns a PROBE_DEFER error, clk_disable_unprepare()
will be called and USART clock will be disabled. But early console can be
still active on the same USART.

While moving dma_request_chan() before clk_prepare_enable(), the clock
won't be taken in case of a DMA PROBE_DEFER error, and so it doesn't need
to be disabled. Then USART is still clocked for early console.

Fixes: a7770a4bfcf4 ("serial: stm32: defer probe for dma devices")
Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/tty/serial/stm32-usart.c | 47 ++++++++++++++++----------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 24def72b2565..a1490033aa16 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1680,22 +1680,10 @@ static int stm32_usart_serial_probe(struct platform_device *pdev)
 	if (!stm32port->info)
 		return -EINVAL;
 
-	ret = stm32_usart_init_port(stm32port, pdev);
-	if (ret)
-		return ret;
-
-	if (stm32port->wakeup_src) {
-		device_set_wakeup_capable(&pdev->dev, true);
-		ret = dev_pm_set_wake_irq(&pdev->dev, stm32port->port.irq);
-		if (ret)
-			goto err_deinit_port;
-	}
-
 	stm32port->rx_ch = dma_request_chan(&pdev->dev, "rx");
-	if (PTR_ERR(stm32port->rx_ch) == -EPROBE_DEFER) {
-		ret = -EPROBE_DEFER;
-		goto err_wakeirq;
-	}
+	if (PTR_ERR(stm32port->rx_ch) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	/* Fall back in interrupt mode for any non-deferral error */
 	if (IS_ERR(stm32port->rx_ch))
 		stm32port->rx_ch = NULL;
@@ -1709,6 +1697,17 @@ static int stm32_usart_serial_probe(struct platform_device *pdev)
 	if (IS_ERR(stm32port->tx_ch))
 		stm32port->tx_ch = NULL;
 
+	ret = stm32_usart_init_port(stm32port, pdev);
+	if (ret)
+		goto err_dma_tx;
+
+	if (stm32port->wakeup_src) {
+		device_set_wakeup_capable(&pdev->dev, true);
+		ret = dev_pm_set_wake_irq(&pdev->dev, stm32port->port.irq);
+		if (ret)
+			goto err_deinit_port;
+	}
+
 	if (stm32port->rx_ch && stm32_usart_of_dma_rx_probe(stm32port, pdev)) {
 		/* Fall back in interrupt mode */
 		dma_release_channel(stm32port->rx_ch);
@@ -1745,19 +1744,11 @@ static int stm32_usart_serial_probe(struct platform_device *pdev)
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 
-	if (stm32port->tx_ch) {
+	if (stm32port->tx_ch)
 		stm32_usart_of_dma_tx_remove(stm32port, pdev);
-		dma_release_channel(stm32port->tx_ch);
-	}
-
 	if (stm32port->rx_ch)
 		stm32_usart_of_dma_rx_remove(stm32port, pdev);
 
-err_dma_rx:
-	if (stm32port->rx_ch)
-		dma_release_channel(stm32port->rx_ch);
-
-err_wakeirq:
 	if (stm32port->wakeup_src)
 		dev_pm_clear_wake_irq(&pdev->dev);
 
@@ -1767,6 +1758,14 @@ static int stm32_usart_serial_probe(struct platform_device *pdev)
 
 	stm32_usart_deinit_port(stm32port);
 
+err_dma_tx:
+	if (stm32port->tx_ch)
+		dma_release_channel(stm32port->tx_ch);
+
+err_dma_rx:
+	if (stm32port->rx_ch)
+		dma_release_channel(stm32port->rx_ch);
+
 	return ret;
 }
 
-- 
2.25.1

