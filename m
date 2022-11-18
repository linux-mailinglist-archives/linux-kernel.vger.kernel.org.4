Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A1262F48C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241411AbiKRM0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241460AbiKRM0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:26:05 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B266B9737E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:26:04 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id k8so9088517wrh.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NW75qAvpRVogQL0T7QAGtVl+SEYpXGObCi3yPFwvGso=;
        b=EqyvRD3fnkEs58HS1MMX5qKFpQrHn13x7ClAlbDNa0KboEO7GCK0S4b7nS7OAhLKeT
         d5pA1JlHIqA5uDZ5453AtnwgFjEy25mt04/RlMfEixLcMyq/8tefIWEaQs7Qfo7Gmcp1
         s3X0MHBEdJ+EGYDP/9P7hQLRWqTV4nezFH/AzwzA9BAQW34JZuz7YZYA/kCnrs+TiFvx
         FqefR5rly249zxebdONWx4i+S+5fCU8uG8XdhkveuD9oNtoQBkACJAFaYs3OJ35DeL55
         MWgPs/47rcLpZEWszfJTbRMLi93GOPdUQgcHBaoThC0j5l4a1iWx8q+Y4GFnLg6PsgM9
         50Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NW75qAvpRVogQL0T7QAGtVl+SEYpXGObCi3yPFwvGso=;
        b=ZdV4RcOyePNb0xSUDbTrorubhhwx6m/bB/G5pLzfvdsa24RTyBdmPJYBCrAO2jvnA4
         aSpCRCo2fO93ZkKTdfLWa2e/Ojby4wz+y4LgVJ1qoErhbmRrYv8Q5Sn1NOqX/Oa2OqUK
         3Y+XJ7aJzGDmRhwv+vqNSybRGlkRgVUsFE05HGTyB+gTx3V+/MShTY1FQ6JfpFaFikKM
         E3FvtAt5wwP7abRRO+6VYjGObIfo3TLTay87GUZCYQMKpZNW98immgnjWknAJ5AvNMwg
         zKbGn4QC31gZkCjOyMA/44n5cjhKztPUIvmPtQ/whg7JkhTF10kS2qYWM/SFUJAweWLg
         vbIg==
X-Gm-Message-State: ANoB5pkDBAS6Rrdl4n9qobpYuF1dm1bkyX1McIIzsPJMpbpE0BL7/jef
        s4ndPF82ts/SFgNavXZ0YIgBug==
X-Google-Smtp-Source: AA0mqf5gwSln0Qe4LaacO8yLD4GGoADA7DHRk2d/vZu5FcHfF7IDeTUrhaVrDTj+csJFbAxgCr6Fqg==
X-Received: by 2002:a05:6000:78d:b0:22e:3d63:80bc with SMTP id bu13-20020a056000078d00b0022e3d6380bcmr4390469wrb.30.1668774363188;
        Fri, 18 Nov 2022 04:26:03 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b10c:1279:a704:75d4])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b003c6f3e5ba42sm9873958wmg.46.2022.11.18.04.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:26:02 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 01/15] tty: serial: qcom-geni-serial: drop unneeded forward definitions
Date:   Fri, 18 Nov 2022 13:25:25 +0100
Message-Id: <20221118122539.384993-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221118122539.384993-1-brgl@bgdev.pl>
References: <20221118122539.384993-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

If we shuffle the code a bit, we can drop all forward definitions of
various static functions.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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

