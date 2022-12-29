Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E219658E7E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 16:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbiL2Put (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 10:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbiL2Pui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 10:50:38 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7434313F91
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 07:50:37 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so16615593wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 07:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l16P3Tz2y+nugpkt7mRQCRUw70VUrSOE7TcjuQJSFbU=;
        b=NQvEW5kBBBA5F9hm0a4wpWiGJoW/JaGcLszVI+f3sgRIHfdTlkRR4NirlyL/VuYQ4r
         3TwLxLAd8zfJJmUYNkCybr2eht0dLGdviZ5tUmJ6Y9MDy+U5m/0e9Fzp5lg1sO7eZjkq
         VHSNB4wiwpkd+bC83jGDzzQsHwoQn/kqQSTVGAq5jaO7yX7eOBcvNsyDtFoa7ArFUdg5
         Bcw4jO33phTGIOHszk/Bj+8kUVzE280fS6Las+pHIrwGOLG7/xXmwa94Nesvsqh8q6uE
         RdEpGBWIknQOPx0ZPQeIbX7fS5BaQofYelWGZF7if5dRiuRx5pwr9C3bd7dTpKa9Y/Iy
         5k7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l16P3Tz2y+nugpkt7mRQCRUw70VUrSOE7TcjuQJSFbU=;
        b=x7M6vMm15pkDsZpooc8hHYDjrdq0tUEfP3JE/Rqxpe3xTAdizOpKGRJoyNyZc6wIVZ
         DxIT9HcL4P07SHy+LWAPhaa6W626+pVUSbBtJ6PEvHpGIofMtKkahtTwfL/plEWDtbz3
         TTi2xDmTz2IqjeT0B6qXG5tCXAlYfFIpz1E6S9vjgX49yDiBCfgeYRlEykEzQlgdKvS7
         H/gjAU8gZsx1hvMXLPgCgkLhHaSG192p24k84ac1eU5mypDR4M4rLdRWhsuRCD5VO8ai
         noG1Px3VT7YiEnKGCf9r8Hn3rL0R26XGkZADli+ELQ14nZOAi/E/c5w91+gcxWYro1mm
         swNA==
X-Gm-Message-State: AFqh2kp3qQ5bQvZfEaGruKHpPORvwXyNsluc9u4Xx09chiX3c725wFug
        +tqix955/41f9d5tbdQtAU5h0g==
X-Google-Smtp-Source: AMrXdXv49hd8c4QJSOvJlzqfJl3/lA/m89biejJYnkqhYdy+1YkfHjxbMWkkYJaHQ6TxAwIHcZGdaQ==
X-Received: by 2002:a05:600c:254:b0:3d2:2c86:d2b2 with SMTP id 20-20020a05600c025400b003d22c86d2b2mr26204124wmj.24.1672329036024;
        Thu, 29 Dec 2022 07:50:36 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8f7a:98d8:9d8d:ced8])
        by smtp.gmail.com with ESMTPSA id bh12-20020a05600c3d0c00b003cfa81e2eb4sm25251647wmb.38.2022.12.29.07.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 07:50:35 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v6 02/14] tty: serial: qcom-geni-serial: drop unneeded forward definitions
Date:   Thu, 29 Dec 2022 16:50:18 +0100
Message-Id: <20221229155030.418800-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221229155030.418800-1-brgl@bgdev.pl>
References: <20221229155030.418800-1-brgl@bgdev.pl>
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

If we shuffle the code a bit, we can drop all forward definitions of
various static functions.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 79 +++++++++++++--------------
 1 file changed, 37 insertions(+), 42 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 4f4c12f3c433..31e0faf702a3 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -147,11 +147,6 @@ static const struct uart_ops qcom_geni_console_pops;
 static const struct uart_ops qcom_geni_uart_pops;
 static struct uart_driver qcom_geni_console_driver;
 static struct uart_driver qcom_geni_uart_driver;
-static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop);
-static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop);
-static unsigned int qcom_geni_serial_tx_empty(struct uart_port *port);
-static void qcom_geni_serial_stop_rx(struct uart_port *uport);
-static void qcom_geni_serial_handle_rx(struct uart_port *uport, bool drop);
 
 #define to_dev_port(ptr, member) \
 		container_of(ptr, struct qcom_geni_serial_port, member)
@@ -590,6 +585,11 @@ static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
 	return ret;
 }
 
+static unsigned int qcom_geni_serial_tx_empty(struct uart_port *uport)
+{
+	return !readl(uport->membase + SE_GENI_TX_FIFO_STATUS);
+}
+
 static void qcom_geni_serial_start_tx(struct uart_port *uport)
 {
 	u32 irq_en;
@@ -635,25 +635,29 @@ static void qcom_geni_serial_stop_tx(struct uart_port *uport)
 	writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
 }
 
-static void qcom_geni_serial_start_rx(struct uart_port *uport)
+static void qcom_geni_serial_handle_rx(struct uart_port *uport, bool drop)
 {
-	u32 irq_en;
 	u32 status;
+	u32 word_cnt;
+	u32 last_word_byte_cnt;
+	u32 last_word_partial;
+	u32 total_bytes;
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
 
-	status = readl(uport->membase + SE_GENI_STATUS);
-	if (status & S_GENI_CMD_ACTIVE)
-		qcom_geni_serial_stop_rx(uport);
-
-	geni_se_setup_s_cmd(&port->se, UART_START_READ, 0);
-
-	irq_en = readl(uport->membase + SE_GENI_S_IRQ_EN);
-	irq_en |= S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN;
-	writel(irq_en, uport->membase + SE_GENI_S_IRQ_EN);
+	status = readl(uport->membase +	SE_GENI_RX_FIFO_STATUS);
+	word_cnt = status & RX_FIFO_WC_MSK;
+	last_word_partial = status & RX_LAST;
+	last_word_byte_cnt = (status & RX_LAST_BYTE_VALID_MSK) >>
+						RX_LAST_BYTE_VALID_SHFT;
 
-	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
-	irq_en |= M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN;
-	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
+	if (!word_cnt)
+		return;
+	total_bytes = BYTES_PER_FIFO_WORD * (word_cnt - 1);
+	if (last_word_partial && last_word_byte_cnt)
+		total_bytes += last_word_byte_cnt;
+	else
+		total_bytes += BYTES_PER_FIFO_WORD;
+	port->handle_rx(uport, total_bytes, drop);
 }
 
 static void qcom_geni_serial_stop_rx(struct uart_port *uport)
@@ -694,29 +698,25 @@ static void qcom_geni_serial_stop_rx(struct uart_port *uport)
 		qcom_geni_serial_abort_rx(uport);
 }
 
-static void qcom_geni_serial_handle_rx(struct uart_port *uport, bool drop)
+static void qcom_geni_serial_start_rx(struct uart_port *uport)
 {
+	u32 irq_en;
 	u32 status;
-	u32 word_cnt;
-	u32 last_word_byte_cnt;
-	u32 last_word_partial;
-	u32 total_bytes;
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
 
-	status = readl(uport->membase +	SE_GENI_RX_FIFO_STATUS);
-	word_cnt = status & RX_FIFO_WC_MSK;
-	last_word_partial = status & RX_LAST;
-	last_word_byte_cnt = (status & RX_LAST_BYTE_VALID_MSK) >>
-						RX_LAST_BYTE_VALID_SHFT;
+	status = readl(uport->membase + SE_GENI_STATUS);
+	if (status & S_GENI_CMD_ACTIVE)
+		qcom_geni_serial_stop_rx(uport);
 
-	if (!word_cnt)
-		return;
-	total_bytes = BYTES_PER_FIFO_WORD * (word_cnt - 1);
-	if (last_word_partial && last_word_byte_cnt)
-		total_bytes += last_word_byte_cnt;
-	else
-		total_bytes += BYTES_PER_FIFO_WORD;
-	port->handle_rx(uport, total_bytes, drop);
+	geni_se_setup_s_cmd(&port->se, UART_START_READ, 0);
+
+	irq_en = readl(uport->membase + SE_GENI_S_IRQ_EN);
+	irq_en |= S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN;
+	writel(irq_en, uport->membase + SE_GENI_S_IRQ_EN);
+
+	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
+	irq_en |= M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN;
+	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 }
 
 static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
@@ -1125,11 +1125,6 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	qcom_geni_serial_start_rx(uport);
 }
 
-static unsigned int qcom_geni_serial_tx_empty(struct uart_port *uport)
-{
-	return !readl(uport->membase + SE_GENI_TX_FIFO_STATUS);
-}
-
 #ifdef CONFIG_SERIAL_QCOM_GENI_CONSOLE
 static int qcom_geni_console_setup(struct console *co, char *options)
 {
-- 
2.37.2

