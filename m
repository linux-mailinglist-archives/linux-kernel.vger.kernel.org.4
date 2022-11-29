Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531A963BE6F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbiK2LAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiK2LAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:00:21 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095AB60E93
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:00:20 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p16so10587670wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1c6aXOWkMzrvJWb4ybDXSFS8VHGCMiU8NIu3wtX2eo=;
        b=LE4lImcCvgy8Mnv5sG8chr9lZy8IL6afckFLBepGWaFzTyhQJnx0dro3oM7ZDDwJPN
         xtsPWwgPfDfV+YjCw0cj2tufSquJ/D0Ov6thn9bAjLkVuCGQR63tZWoqfu/dKkMqwLkA
         cGr1uAOJTnicfz6xz2DzejKvjmG42RmM4TlZqUa5uJdlRI247195yFPH4Cmg+q3EYwV+
         F2CtEvMzavXmc29m168nXMBrOU9v+Q/nTtLqzTQXmM3WrWAZY5KmtB7/MT9gET+wt8me
         /MH6R8v4F3LwL+C5Wtjqo555NxE3sRLqhxlSRLtD3jBb6SxWxulPIz9/3NbcTJPYQx44
         gwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1c6aXOWkMzrvJWb4ybDXSFS8VHGCMiU8NIu3wtX2eo=;
        b=sleD7Xn7lloQUyXYoj1O+Yj8Hll4lAuTMWtStyiukOHEhPJYwkTLUdCF0Cfjh42jQ6
         kT9TWac1Ee28823j3lK8LysVwoOx+wCH5LI6FFJ1AWtgJaXHjNdxb8uWX99LYkXDp0aG
         jxKhYzdeNRCrCEi7nzScRGiv3FJ9CYEGZe66zuLqgalj975b9KfygUCEQF1sWxhsWbKs
         FDAS0BIGK0HeSXk0FqLPUYff6QjbWDklTqKLGFpOehNwWwiM4HyxU/+tPfpR0tZM1CSl
         Vdl3KPXFRgvmfoFj/RDBWB98kbwkssePbSidpjFsfxM1t6CpNc7m0MyoD9mvzhFXFgm3
         FoGA==
X-Gm-Message-State: ANoB5pn9EAtKBt4wQKLPS851mN9qUN0DMZNCZOWVTnrVhQ3IyWuNZqsi
        +rc+qf33T7g+aZ7N/HK48OdxOQ==
X-Google-Smtp-Source: AA0mqf6VqTIbFbM/3GZZ3WwiNs6TWtIxM3kHFikzFJYjrp8lUz1IztoBGICJg68rP05ZLgHwHsPsMw==
X-Received: by 2002:a05:600c:41c7:b0:3cf:a0f4:7879 with SMTP id t7-20020a05600c41c700b003cfa0f47879mr27082424wmh.152.1669719618514;
        Tue, 29 Nov 2022 03:00:18 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6b19:1d8e:fbca:fd02])
        by smtp.gmail.com with ESMTPSA id q19-20020a1cf313000000b003a3170a7af9sm1617658wmq.4.2022.11.29.03.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 03:00:18 -0800 (PST)
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
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v4 01/13] tty: serial: qcom-geni-serial: drop unneeded forward definitions
Date:   Tue, 29 Nov 2022 12:00:00 +0100
Message-Id: <20221129110012.224685-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221129110012.224685-1-brgl@bgdev.pl>
References: <20221129110012.224685-1-brgl@bgdev.pl>
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
index 83b66b73303a..9f2212e7b5ec 100644
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
@@ -1122,11 +1122,6 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
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

