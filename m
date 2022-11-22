Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1802A6339D0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbiKVKWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbiKVKVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:21:49 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688FB192A3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:21:43 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id e11so11061094wru.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1c6aXOWkMzrvJWb4ybDXSFS8VHGCMiU8NIu3wtX2eo=;
        b=qWHugDNcVkjomPaQsfZ4/isqFWLeE3ZO/OmoCsuLTZO3YjlJe0rgcmRkDPz38GRpQb
         BT5LgOv9c/2zm/E2YPXjCbHb6c0zgLcQRZdBejuZgdEhMI2TeWYOhhldRlysQ1pHgLz8
         vPSjakesx33UiH3YXSHLwtxkFZPKsV4YIEVbHXDrl/DEHeAb1ugeuL/wyd12Y0mP3CJx
         GpV+1RHWqIgiov2fwlBTv8Hy2pB3la15XvgcCLelo2RlxY4kVZ7zy0mSxHEJUFrY6tSD
         5vDuwio1lssYSChU6p4RPf+rUYpfcg+WHJoD0SwK8AFvsaj7X9rNu179BLgo7A3MQMuL
         uStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1c6aXOWkMzrvJWb4ybDXSFS8VHGCMiU8NIu3wtX2eo=;
        b=LcsLZSpDSlawD9LHq5ztBiZ7LaKG6zH8h9lJPuKJlbRMcVhlgMYD6jLi9S1pYUEizO
         SBDvpE0wtBSJX0niI5ZZjXt26IjiiAuINMnv24SgZocRXbvXgNs4V3T/WDG6ocj8vfT/
         hejJ3PcCydhVgVqLPDjSmlCRN0C0RtME0GY8FqXxi5JmlKoU/s2kAIZfWjcJ3/9ck+Jp
         GAWLaQhWQ04PyQnnDc3BvT485uRtoe3zfvTVOUuTzUKzhKlteZp3SwyMAk5Qln9/UYw4
         OsHTlGC7rwfYaOd79Pil04OPWsP0xhPBL8ZqLcbQSYR86LimLZX0vIvgTyxHNRSWwUhL
         atOA==
X-Gm-Message-State: ANoB5pnlcLG8+5RrzzafbDtQzv+heRY5tROEMrVsJYaTrYB59pBHPl6X
        K1SmOkzjHLXhG72zlerW035LJA==
X-Google-Smtp-Source: AA0mqf6I9HzW74pGIU7imlc2UarQOe9VU1MHYuemI3la9HGnQg7np/WNBNgu5QHIi2MU/Y4IPLtQrA==
X-Received: by 2002:adf:e84f:0:b0:22e:37c1:b225 with SMTP id d15-20020adfe84f000000b0022e37c1b225mr12954282wrn.428.1669112501851;
        Tue, 22 Nov 2022 02:21:41 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e011:9e81:66f1:3415])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4083000000b002366e8eee11sm13432873wrp.101.2022.11.22.02.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 02:21:41 -0800 (PST)
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
Subject: [PATCH v2 01/15] tty: serial: qcom-geni-serial: drop unneeded forward definitions
Date:   Tue, 22 Nov 2022 11:21:11 +0100
Message-Id: <20221122102125.142075-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221122102125.142075-1-brgl@bgdev.pl>
References: <20221122102125.142075-1-brgl@bgdev.pl>
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

