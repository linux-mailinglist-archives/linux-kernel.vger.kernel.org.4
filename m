Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA6D6402BC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbiLBI6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiLBI5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:57:06 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AF2C35B8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 00:56:12 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso3727423wmo.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 00:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPw7thSrS45qstEiKKG7LVim3F0rg+3QPQJZbEs5Dw4=;
        b=WWABFII3QiJ/N2Kv/xJ+xcBmLMdturc/QLeQjJ91CokGxBtwWzlPfoemd7BkMRcFtm
         wojzemA1OL4NzwQ6RY1GboVRhkL/5uS6a8n1XyfT1nOwQeQ5E/AMvI75nkBJv0Mv4j3U
         b53Tbu2IO8Ixn6HaUHOlKDzmbOK9VAomf7kvYjMwvK76zlCjVcvke4U3qLQ0o4nW//SM
         sgaOu/yeJK6b4Rqj5/NljaHHXMg7DzcPVzFDK+VnyNeYzYidxkh2LGEnl54FSmYff+7V
         2CQXmRe8q/sFNte95y7AG8GrCRA23QxquQHh1ALIxanOv01U53b4AUXu2/lQX6B4mCMz
         lhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPw7thSrS45qstEiKKG7LVim3F0rg+3QPQJZbEs5Dw4=;
        b=G6X20AWoeKbRFK/ACRPk1vwwoCLw3hyH0Y2TcFl8nBcAW1V0BYO79m9MNrOWM5FSxI
         RqXiChITKoMdfelZZ8+BX746EOWEyCwkjdmeY27x0krGkO0desuUrz16Nt1u6OOk4QK3
         jw3yh37YVBC0EkuzZrtCZTTiG3G7zOOZXaAKFgVLReWlPk0k6fDRAnrrSMiESmS9qnrx
         447d42+HmxJw4FWKJYiV+NE0+41vPP0l/FgTFIuGsFIO88iID8SMRTmQiVqME6nzgKVU
         YLgXX14LSWLcXTSdsaHdPN7aTIGVDKChQhMDFQtGVAHYOtxaXSuTvF4pNhwnfy0w5/uH
         54bg==
X-Gm-Message-State: ANoB5plUsl5rBRVU+/MuCGEtypOmkOHtCjKfbDLOgHVkcEVh0xb3eaIQ
        Mpv9/rl7idMuVNXXPiZxmqybhg==
X-Google-Smtp-Source: AA0mqf7qfpTwSUAYSnf+dzDLBPZs3xT7UCBeMPRdcQDeEklfajew/NMruNlI5FWjGYoTCvWDrwI8uA==
X-Received: by 2002:a05:600c:468c:b0:3cf:7c81:caae with SMTP id p12-20020a05600c468c00b003cf7c81caaemr45745603wmo.135.1669971370962;
        Fri, 02 Dec 2022 00:56:10 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:29a4:6f04:ddb1:1ed7])
        by smtp.gmail.com with ESMTPSA id a13-20020adfed0d000000b0024219b1cb1bsm6527517wro.60.2022.12.02.00.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 00:56:10 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5 14/14] tty: serial: qcom-geni-serial: add support for serial engine DMA
Date:   Fri,  2 Dec 2022 09:55:54 +0100
Message-Id: <20221202085554.59637-15-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221202085554.59637-1-brgl@bgdev.pl>
References: <20221202085554.59637-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The qcom-geni-serial driver currently only works in SE FIFO mode. This
limits the UART speed to around 180 kB/s. In order to achieve higher
speeds we need to use SE DMA mode.

Keep the console port working in FIFO mode but extend the code to use DMA
for the high-speed port.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 314 +++++++++++++++++++++-----
 1 file changed, 255 insertions(+), 59 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 1dfc0122ff53..85c8771ae318 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -70,6 +70,8 @@
 #define UART_START_TX			0x1
 /* UART S_CMD OP codes */
 #define UART_START_READ			0x1
+#define UART_PARAM			0x1
+#define UART_PARAM_RFR_OPEN		BIT(7)
 
 #define UART_OVERSAMPLING		32
 #define STALE_TIMEOUT			16
@@ -95,9 +97,11 @@
 /* We always configure 4 bytes per FIFO word */
 #define BYTES_PER_FIFO_WORD		4U
 
+#define DMA_RX_BUF_SIZE		2048
+
 struct qcom_geni_device_data {
 	bool console;
-	void (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
+	enum geni_se_xfer_mode mode;
 };
 
 struct qcom_geni_private_data {
@@ -118,9 +122,11 @@ struct qcom_geni_serial_port {
 	u32 tx_fifo_depth;
 	u32 tx_fifo_width;
 	u32 rx_fifo_depth;
+	dma_addr_t tx_dma_addr;
+	dma_addr_t rx_dma_addr;
 	bool setup;
 	unsigned int baud;
-	void *rx_fifo;
+	void *rx_buf;
 	u32 loopback;
 	bool brk;
 
@@ -249,6 +255,16 @@ static struct qcom_geni_serial_port *get_port_from_line(int line, bool console)
 	return port;
 }
 
+static bool qcom_geni_serial_main_active(struct uart_port *uport)
+{
+	return readl(uport->membase + SE_GENI_STATUS) & M_GENI_CMD_ACTIVE;
+}
+
+static bool qcom_geni_serial_secondary_active(struct uart_port *uport)
+{
+	return readl(uport->membase + SE_GENI_STATUS) & S_GENI_CMD_ACTIVE;
+}
+
 static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
 				int offset, int field, bool set)
 {
@@ -552,18 +568,11 @@ static void handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
 
 static void handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
 {
-	struct tty_port *tport;
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
-	u32 num_bytes_pw = port->tx_fifo_width / BITS_PER_BYTE;
-	u32 words = ALIGN(bytes, num_bytes_pw) / num_bytes_pw;
+	struct tty_port *tport = &uport->state->port;
 	int ret;
 
-	tport = &uport->state->port;
-	ioread32_rep(uport->membase + SE_GENI_RX_FIFOn, port->rx_fifo, words);
-	if (drop)
-		return;
-
-	ret = tty_insert_flip_string(tport, port->rx_fifo, bytes);
+	ret = tty_insert_flip_string(tport, port->rx_buf, bytes);
 	if (ret != bytes) {
 		dev_err(uport->dev, "%s:Unable to push data ret %d_bytes %d\n",
 				__func__, ret, bytes);
@@ -578,16 +587,75 @@ static unsigned int qcom_geni_serial_tx_empty(struct uart_port *uport)
 	return !readl(uport->membase + SE_GENI_TX_FIFO_STATUS);
 }
 
-static void qcom_geni_serial_start_tx(struct uart_port *uport)
+static void qcom_geni_serial_stop_tx_dma(struct uart_port *uport)
 {
-	u32 irq_en;
-	u32 status;
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+	bool done;
+	u32 m_irq_en;
+
+	if (!qcom_geni_serial_main_active(uport))
+		return;
+
+	if (port->rx_dma_addr) {
+		geni_se_tx_dma_unprep(&port->se, port->tx_dma_addr,
+				      port->tx_remaining);
+		port->tx_dma_addr = 0;
+		port->tx_remaining = 0;
+	}
+
+	m_irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
+	writel(m_irq_en, uport->membase + SE_GENI_M_IRQ_EN);
+	geni_se_cancel_m_cmd(&port->se);
+
+	done = qcom_geni_serial_poll_bit(uport, SE_GENI_S_IRQ_STATUS,
+					 S_CMD_CANCEL_EN, true);
+	if (!done) {
+		geni_se_abort_m_cmd(&port->se);
+		done = qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
+						 M_CMD_ABORT_EN, true);
+		if (!done)
+			dev_err_ratelimited(uport->dev, "M_CMD_ABORT_EN not set");
+		writel(M_CMD_ABORT_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
+	}
+
+	writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
+}
+
+static void qcom_geni_serial_start_tx_dma(struct uart_port *uport)
+{
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+	struct circ_buf *xmit = &uport->state->xmit;
+	unsigned int xmit_size;
+	int ret;
+
+	if (port->tx_dma_addr)
+		return;
+
+	xmit_size = uart_circ_chars_pending(xmit);
+	if (xmit_size < WAKEUP_CHARS)
+		uart_write_wakeup(uport);
 
-	status = readl(uport->membase + SE_GENI_STATUS);
-	if (status & M_GENI_CMD_ACTIVE)
+	xmit_size = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
+
+	qcom_geni_serial_setup_tx(uport, xmit_size);
+
+	ret = geni_se_tx_dma_prep(&port->se, &xmit->buf[xmit->tail],
+				  xmit_size, &port->tx_dma_addr);
+	if (ret) {
+		dev_err(uport->dev, "unable to start TX SE DMA: %d\n", ret);
+		qcom_geni_serial_stop_tx_dma(uport);
 		return;
+	}
+
+	port->tx_remaining = xmit_size;
+}
+
+static void qcom_geni_serial_start_tx_fifo(struct uart_port *uport)
+{
+	u32 irq_en;
 
-	if (!qcom_geni_serial_tx_empty(uport))
+	if (qcom_geni_serial_main_active(uport) ||
+	    !qcom_geni_serial_tx_empty(uport))
 		return;
 
 	irq_en = readl(uport->membase +	SE_GENI_M_IRQ_EN);
@@ -597,19 +665,17 @@ static void qcom_geni_serial_start_tx(struct uart_port *uport)
 	writel(irq_en, uport->membase +	SE_GENI_M_IRQ_EN);
 }
 
-static void qcom_geni_serial_stop_tx(struct uart_port *uport)
+static void qcom_geni_serial_stop_tx_fifo(struct uart_port *uport)
 {
 	u32 irq_en;
-	u32 status;
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
 	irq_en &= ~(M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN);
 	writel(0, uport->membase + SE_GENI_TX_WATERMARK_REG);
 	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
-	status = readl(uport->membase + SE_GENI_STATUS);
 	/* Possible stop tx is called multiple times. */
-	if (!(status & M_GENI_CMD_ACTIVE))
+	if (!qcom_geni_serial_main_active(uport))
 		return;
 
 	geni_se_cancel_m_cmd(&port->se);
@@ -623,14 +689,13 @@ static void qcom_geni_serial_stop_tx(struct uart_port *uport)
 	writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
 }
 
-static void qcom_geni_serial_handle_rx(struct uart_port *uport, bool drop)
+static void qcom_geni_serial_handle_rx_fifo(struct uart_port *uport, bool drop)
 {
 	u32 status;
 	u32 word_cnt;
 	u32 last_word_byte_cnt;
 	u32 last_word_partial;
 	u32 total_bytes;
-	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	status = readl(uport->membase +	SE_GENI_RX_FIFO_STATUS);
 	word_cnt = status & RX_FIFO_WC_MSK;
@@ -645,13 +710,12 @@ static void qcom_geni_serial_handle_rx(struct uart_port *uport, bool drop)
 		total_bytes += last_word_byte_cnt;
 	else
 		total_bytes += BYTES_PER_FIFO_WORD;
-	port->dev_data->handle_rx(uport, total_bytes, drop);
+	handle_rx_console(uport, total_bytes, drop);
 }
 
-static void qcom_geni_serial_stop_rx(struct uart_port *uport)
+static void qcom_geni_serial_stop_rx_fifo(struct uart_port *uport)
 {
 	u32 irq_en;
-	u32 status;
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	u32 s_irq_status;
 
@@ -663,9 +727,7 @@ static void qcom_geni_serial_stop_rx(struct uart_port *uport)
 	irq_en &= ~(M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN);
 	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 
-	status = readl(uport->membase + SE_GENI_STATUS);
-	/* Possible stop rx is called multiple times. */
-	if (!(status & S_GENI_CMD_ACTIVE))
+	if (!qcom_geni_serial_secondary_active(uport))
 		return;
 
 	geni_se_cancel_s_cmd(&port->se);
@@ -678,23 +740,20 @@ static void qcom_geni_serial_stop_rx(struct uart_port *uport)
 	s_irq_status = readl(uport->membase + SE_GENI_S_IRQ_STATUS);
 	/* Flush the Rx buffer */
 	if (s_irq_status & S_RX_FIFO_LAST_EN)
-		qcom_geni_serial_handle_rx(uport, true);
+		qcom_geni_serial_handle_rx_fifo(uport, true);
 	writel(s_irq_status, uport->membase + SE_GENI_S_IRQ_CLEAR);
 
-	status = readl(uport->membase + SE_GENI_STATUS);
-	if (status & S_GENI_CMD_ACTIVE)
+	if (qcom_geni_serial_secondary_active(uport))
 		qcom_geni_serial_abort_rx(uport);
 }
 
-static void qcom_geni_serial_start_rx(struct uart_port *uport)
+static void qcom_geni_serial_start_rx_fifo(struct uart_port *uport)
 {
 	u32 irq_en;
-	u32 status;
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
-	status = readl(uport->membase + SE_GENI_STATUS);
-	if (status & S_GENI_CMD_ACTIVE)
-		qcom_geni_serial_stop_rx(uport);
+	if (qcom_geni_serial_secondary_active(uport))
+		qcom_geni_serial_stop_rx_fifo(uport);
 
 	geni_se_setup_s_cmd(&port->se, UART_START_READ, 0);
 
@@ -707,6 +766,94 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
 	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 }
 
+static void qcom_geni_serial_stop_rx_dma(struct uart_port *uport)
+{
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+
+	if (!qcom_geni_serial_secondary_active(uport))
+		return;
+
+	geni_se_cancel_s_cmd(&port->se);
+	qcom_geni_serial_poll_bit(uport, SE_GENI_S_IRQ_STATUS,
+				  S_CMD_CANCEL_EN, true);
+
+	if (qcom_geni_serial_secondary_active(uport))
+		qcom_geni_serial_abort_rx(uport);
+
+	if (port->rx_dma_addr) {
+		geni_se_rx_dma_unprep(&port->se, port->rx_dma_addr,
+				      DMA_RX_BUF_SIZE);
+		port->rx_dma_addr = 0;
+	}
+}
+
+static void qcom_geni_serial_start_rx_dma(struct uart_port *uport)
+{
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+	int ret;
+
+	if (qcom_geni_serial_secondary_active(uport))
+		qcom_geni_serial_stop_rx_dma(uport);
+
+	geni_se_setup_s_cmd(&port->se, UART_START_READ, UART_PARAM_RFR_OPEN);
+
+	ret = geni_se_rx_dma_prep(&port->se, port->rx_buf,
+				  DMA_RX_BUF_SIZE,
+				  &port->rx_dma_addr);
+	if (ret) {
+		dev_err(uport->dev, "unable to start RX SE DMA: %d\n", ret);
+		qcom_geni_serial_stop_rx_dma(uport);
+	}
+}
+
+static void qcom_geni_serial_handle_rx_dma(struct uart_port *uport, bool drop)
+{
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+	u32 rx_in;
+	int ret;
+
+	if (!qcom_geni_serial_secondary_active(uport))
+		return;
+
+	if (!port->rx_dma_addr)
+		return;
+
+	geni_se_rx_dma_unprep(&port->se, port->rx_dma_addr, DMA_RX_BUF_SIZE);
+	port->rx_dma_addr = 0;
+
+	rx_in = readl(uport->membase + SE_DMA_RX_LEN_IN);
+	if (!rx_in) {
+		dev_warn(uport->dev, "serial engine reports 0 RX bytes in!\n");
+		return;
+	}
+
+	if (!drop)
+		handle_rx_uart(uport, rx_in, drop);
+
+	ret = geni_se_rx_dma_prep(&port->se, port->rx_buf,
+				  DMA_RX_BUF_SIZE,
+				  &port->rx_dma_addr);
+	if (ret) {
+		dev_err(uport->dev, "unable to start RX SE DMA: %d\n", ret);
+		qcom_geni_serial_stop_rx_dma(uport);
+	}
+}
+
+static void qcom_geni_serial_start_rx(struct uart_port *uport)
+{
+	uport->ops->start_rx(uport);
+}
+
+static void qcom_geni_serial_stop_rx(struct uart_port *uport)
+{
+	uport->ops->stop_rx(uport);
+}
+
+static void qcom_geni_serial_stop_tx(struct uart_port *uport)
+{
+	uport->ops->stop_tx(uport);
+}
+
 static void qcom_geni_serial_send_chunk_fifo(struct uart_port *uport,
 					     unsigned int chunk)
 {
@@ -731,8 +878,8 @@ static void qcom_geni_serial_send_chunk_fifo(struct uart_port *uport,
 	}
 }
 
-static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
-		bool active)
+static void qcom_geni_serial_handle_tx_fifo(struct uart_port *uport,
+					    bool done, bool active)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	struct circ_buf *xmit = &uport->state->xmit;
@@ -752,7 +899,7 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 
 	/* All data has been transmitted and acknowledged as received */
 	if (!pending && !status && done) {
-		qcom_geni_serial_stop_tx(uport);
+		qcom_geni_serial_stop_tx_fifo(uport);
 		goto out_write_wakeup;
 	}
 
@@ -795,12 +942,32 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 		uart_write_wakeup(uport);
 }
 
+static void qcom_geni_serial_handle_tx_dma(struct uart_port *uport)
+{
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+	struct circ_buf *xmit = &uport->state->xmit;
+
+	uart_xmit_advance(uport, port->tx_remaining);
+	geni_se_tx_dma_unprep(&port->se, port->tx_dma_addr, port->tx_remaining);
+	port->tx_dma_addr = 0;
+	port->tx_remaining = 0;
+
+	if (!uart_circ_empty(xmit))
+		qcom_geni_serial_start_tx_dma(uport);
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(uport);
+}
+
 static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 {
 	u32 m_irq_en;
 	u32 m_irq_status;
 	u32 s_irq_status;
 	u32 geni_status;
+	u32 dma;
+	u32 dma_tx_status;
+	u32 dma_rx_status;
 	struct uart_port *uport = dev;
 	bool drop_rx = false;
 	struct tty_port *tport = &uport->state->port;
@@ -813,10 +980,15 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 
 	m_irq_status = readl(uport->membase + SE_GENI_M_IRQ_STATUS);
 	s_irq_status = readl(uport->membase + SE_GENI_S_IRQ_STATUS);
+	dma_tx_status = readl(uport->membase + SE_DMA_TX_IRQ_STAT);
+	dma_rx_status = readl(uport->membase + SE_DMA_RX_IRQ_STAT);
 	geni_status = readl(uport->membase + SE_GENI_STATUS);
+	dma = readl(uport->membase + SE_GENI_DMA_MODE_EN);
 	m_irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
 	writel(m_irq_status, uport->membase + SE_GENI_M_IRQ_CLEAR);
 	writel(s_irq_status, uport->membase + SE_GENI_S_IRQ_CLEAR);
+	writel(dma_tx_status, uport->membase + SE_DMA_TX_IRQ_CLR);
+	writel(dma_rx_status, uport->membase + SE_DMA_RX_IRQ_CLR);
 
 	if (WARN_ON(m_irq_status & M_ILLEGAL_CMD_EN))
 		goto out_unlock;
@@ -826,10 +998,6 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
 	}
 
-	if (m_irq_status & m_irq_en & (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN))
-		qcom_geni_serial_handle_tx(uport, m_irq_status & M_CMD_DONE_EN,
-					   geni_status & M_GENI_CMD_ACTIVE);
-
 	if (s_irq_status & (S_GP_IRQ_0_EN | S_GP_IRQ_1_EN)) {
 		if (s_irq_status & S_GP_IRQ_0_EN)
 			uport->icount.parity++;
@@ -839,8 +1007,35 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 		port->brk = true;
 	}
 
-	if (s_irq_status & (S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN))
-		qcom_geni_serial_handle_rx(uport, drop_rx);
+	if (dma) {
+		if (dma_tx_status & TX_DMA_DONE)
+			qcom_geni_serial_handle_tx_dma(uport);
+
+		if (dma_rx_status) {
+			if (dma_rx_status & RX_RESET_DONE)
+				goto out_unlock;
+
+			if (dma_rx_status & RX_DMA_PARITY_ERR) {
+				uport->icount.parity++;
+				drop_rx = true;
+			}
+
+			if (dma_rx_status & RX_DMA_BREAK)
+				uport->icount.brk++;
+
+			if (dma_rx_status & (RX_DMA_DONE | RX_EOT))
+				qcom_geni_serial_handle_rx_dma(uport, drop_rx);
+		}
+	} else {
+		if (m_irq_status & m_irq_en &
+		    (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN))
+			qcom_geni_serial_handle_tx_fifo(uport,
+					m_irq_status & M_CMD_DONE_EN,
+					geni_status & M_GENI_CMD_ACTIVE);
+
+		if (s_irq_status & (S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN))
+			qcom_geni_serial_handle_rx_fifo(uport, drop_rx);
+	}
 
 out_unlock:
 	uart_unlock_and_check_sysrq(uport);
@@ -909,7 +1104,7 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 	geni_se_config_packing(&port->se, BITS_PER_BYTE, BYTES_PER_FIFO_WORD,
 			       false, true, true);
 	geni_se_init(&port->se, UART_RX_WM, port->rx_fifo_depth - 2);
-	geni_se_select_mode(&port->se, GENI_SE_FIFO);
+	geni_se_select_mode(&port->se, port->dev_data->mode);
 	port->setup = true;
 
 	return 0;
@@ -1307,10 +1502,10 @@ static void qcom_geni_serial_pm(struct uart_port *uport,
 
 static const struct uart_ops qcom_geni_console_pops = {
 	.tx_empty = qcom_geni_serial_tx_empty,
-	.stop_tx = qcom_geni_serial_stop_tx,
-	.start_tx = qcom_geni_serial_start_tx,
-	.stop_rx = qcom_geni_serial_stop_rx,
-	.start_rx = qcom_geni_serial_start_rx,
+	.stop_tx = qcom_geni_serial_stop_tx_fifo,
+	.start_tx = qcom_geni_serial_start_tx_fifo,
+	.stop_rx = qcom_geni_serial_stop_rx_fifo,
+	.start_rx = qcom_geni_serial_start_rx_fifo,
 	.set_termios = qcom_geni_serial_set_termios,
 	.startup = qcom_geni_serial_startup,
 	.request_port = qcom_geni_serial_request_port,
@@ -1328,9 +1523,10 @@ static const struct uart_ops qcom_geni_console_pops = {
 
 static const struct uart_ops qcom_geni_uart_pops = {
 	.tx_empty = qcom_geni_serial_tx_empty,
-	.stop_tx = qcom_geni_serial_stop_tx,
-	.start_tx = qcom_geni_serial_start_tx,
-	.stop_rx = qcom_geni_serial_stop_rx,
+	.stop_tx = qcom_geni_serial_stop_tx_dma,
+	.start_tx = qcom_geni_serial_start_tx_dma,
+	.start_rx = qcom_geni_serial_start_rx_dma,
+	.stop_rx = qcom_geni_serial_stop_rx_dma,
 	.set_termios = qcom_geni_serial_set_termios,
 	.startup = qcom_geni_serial_startup,
 	.request_port = qcom_geni_serial_request_port,
@@ -1399,9 +1595,9 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	port->tx_fifo_width = DEF_FIFO_WIDTH_BITS;
 
 	if (!data->console) {
-		port->rx_fifo = devm_kcalloc(uport->dev,
-			port->rx_fifo_depth, sizeof(u32), GFP_KERNEL);
-		if (!port->rx_fifo)
+		port->rx_buf = devm_kzalloc(uport->dev,
+					    DMA_RX_BUF_SIZE, GFP_KERNEL);
+		if (!port->rx_buf)
 			return -ENOMEM;
 	}
 
@@ -1531,12 +1727,12 @@ static int __maybe_unused qcom_geni_serial_sys_resume(struct device *dev)
 
 static const struct qcom_geni_device_data qcom_geni_console_data = {
 	.console = true,
-	.handle_rx = handle_rx_console,
+	.mode = GENI_SE_FIFO,
 };
 
 static const struct qcom_geni_device_data qcom_geni_uart_data = {
 	.console = false,
-	.handle_rx = handle_rx_uart,
+	.mode = GENI_SE_DMA,
 };
 
 static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
-- 
2.37.2

