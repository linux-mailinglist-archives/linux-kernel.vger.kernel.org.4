Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2094A62F495
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241845AbiKRM0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241762AbiKRM0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:26:08 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DC7976C2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:26:07 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v1so8963164wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IDPXLtOOkutc4YEs1kDSCA4Awj/+cxV2z/RqKgbcLA=;
        b=0yEPHWXGMIEMGGm7qbNRpxy7F8zvbYlplpNguPP1mvqn0Y3iakwqTO/ONs0OOqBU1t
         1xq65nIWNlstgwiLav/4VWXp87OaKYpvUL2IX3bcKV95HZjx2E4O4RY2Zcfmi4GzevnG
         1Erd0AXYTmcHA9DFiccDrBL2xca99UA+XUKoxpNDY1BKtP73Mti62zqukZZS32HoLc+G
         odIggvMNA/nafiS8LdxkJ8rD8rmDZWk6z6SAsig9kQaOVI+lTUZymgEw+A5VImNxe0QQ
         GlFwnZiU2zmULfJ/l5uyqDM6tmYA5WAiM5kl9xWA67RkOOw8svTDGESvjc6lNc0WO+yg
         kdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2IDPXLtOOkutc4YEs1kDSCA4Awj/+cxV2z/RqKgbcLA=;
        b=p1meQj9hvcVDyJEIriqb5jbjgl7dsA/GtFkiWi82gF3hI6TJIw+9RpIyK73V4PIFlV
         aLXkpyP/LBnrm4/Vq0TdHqjK/zpUqz60APVpkTNB924voZ+tAxw7OmnAUe9h8nnbIa5I
         0RmmF4IG7sDMS2secsdzs6BSzPJtxozOObzCLMgZBEb0+SMl/gpwJX+/Xdq3nRlVmvd3
         pQ+r5Ex7sn4o+uiV/g1tSpiFCtihA8dWzIxknrfTu0ChxjsdFdaFSbyP9tOnA8j+Aevq
         K9aVRViel2sJ0OJm2h6KBcXGBVblF1VfsFlaFwnokGwmzdXrnXUWEUqAkrLJ3c5YCYyU
         B5uQ==
X-Gm-Message-State: ANoB5pmpRECVfc25jGuQ8YAno195eXXjHZDTRnLCYluKEmciSgR17G/1
        Ly79CJKelbIlOR4ec4TCj8+bIA==
X-Google-Smtp-Source: AA0mqf7WtT968SjgINAg+MszHXn+705VzNKEPW0VTe1tuS5JdYb4lXC75ijc689oRJJ/8ieaX3L/DA==
X-Received: by 2002:a5d:5049:0:b0:241:bd33:4e17 with SMTP id h9-20020a5d5049000000b00241bd334e17mr2690828wrt.174.1668774366132;
        Fri, 18 Nov 2022 04:26:06 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b10c:1279:a704:75d4])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b003c6f3e5ba42sm9873958wmg.46.2022.11.18.04.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:26:05 -0800 (PST)
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
Subject: [PATCH 04/15] tty: serial: qcom-geni-serial: simplify the to_dev_port() macro
Date:   Fri, 18 Nov 2022 13:25:28 +0100
Message-Id: <20221118122539.384993-5-brgl@bgdev.pl>
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

The member we want to resolve in struct qcom_geni_serial_port is called
uport so we don't need an additional redundant parameter in this macro.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 33 +++++++++++++--------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 97ee7c074b79..1db2795804e9 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -133,8 +133,7 @@ static const struct uart_ops qcom_geni_uart_pops;
 static struct uart_driver qcom_geni_console_driver;
 static struct uart_driver qcom_geni_uart_driver;
 
-#define to_dev_port(ptr, member) \
-		container_of(ptr, struct qcom_geni_serial_port, member)
+#define to_dev_port(ptr) container_of(ptr, struct qcom_geni_serial_port, uport)
 
 static struct qcom_geni_serial_port qcom_geni_uart_ports[GENI_UART_PORTS] = {
 	[0] = {
@@ -175,7 +174,7 @@ static struct qcom_geni_serial_port qcom_geni_console_port = {
 static int qcom_geni_serial_request_port(struct uart_port *uport)
 {
 	struct platform_device *pdev = to_platform_device(uport->dev);
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	uport->membase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(uport->membase))
@@ -212,7 +211,7 @@ static void qcom_geni_serial_set_mctrl(struct uart_port *uport,
 							unsigned int mctrl)
 {
 	u32 uart_manual_rfr = 0;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	if (uart_console(uport))
 		return;
@@ -253,7 +252,7 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
 	struct qcom_geni_private_data *private_data = uport->private_data;
 
 	if (private_data->drv) {
-		port = to_dev_port(uport, uport);
+		port = to_dev_port(uport);
 		baud = port->baud;
 		if (!baud)
 			baud = 115200;
@@ -506,7 +505,7 @@ static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
 	u32 i;
 	unsigned char buf[sizeof(u32)];
 	struct tty_port *tport;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	tport = &uport->state->port;
 	for (i = 0; i < bytes; ) {
@@ -549,7 +548,7 @@ static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
 static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
 {
 	struct tty_port *tport;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	u32 num_bytes_pw = port->tx_fifo_width / BITS_PER_BYTE;
 	u32 words = ALIGN(bytes, num_bytes_pw) / num_bytes_pw;
 	int ret;
@@ -598,7 +597,7 @@ static void qcom_geni_serial_stop_tx(struct uart_port *uport)
 {
 	u32 irq_en;
 	u32 status;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
 	irq_en &= ~(M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN);
@@ -627,7 +626,7 @@ static void qcom_geni_serial_handle_rx(struct uart_port *uport, bool drop)
 	u32 last_word_byte_cnt;
 	u32 last_word_partial;
 	u32 total_bytes;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	status = readl(uport->membase +	SE_GENI_RX_FIFO_STATUS);
 	word_cnt = status & RX_FIFO_WC_MSK;
@@ -649,7 +648,7 @@ static void qcom_geni_serial_stop_rx(struct uart_port *uport)
 {
 	u32 irq_en;
 	u32 status;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	u32 s_irq_status;
 
 	irq_en = readl(uport->membase + SE_GENI_S_IRQ_EN);
@@ -687,7 +686,7 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
 {
 	u32 irq_en;
 	u32 status;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	status = readl(uport->membase + SE_GENI_STATUS);
 	if (status & S_GENI_CMD_ACTIVE)
@@ -707,7 +706,7 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
 static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 		bool active)
 {
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	struct circ_buf *xmit = &uport->state->xmit;
 	size_t avail;
 	size_t remaining;
@@ -803,7 +802,7 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 	struct uart_port *uport = dev;
 	bool drop_rx = false;
 	struct tty_port *tport = &uport->state->port;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	if (uport->suspended)
 		return IRQ_NONE;
@@ -869,7 +868,7 @@ static void qcom_geni_serial_shutdown(struct uart_port *uport)
 
 static int qcom_geni_serial_port_setup(struct uart_port *uport)
 {
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	u32 rxstale = DEFAULT_BITS_PER_CHAR * STALE_TIMEOUT;
 	u32 proto;
 	u32 pin_swap;
@@ -917,7 +916,7 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 static int qcom_geni_serial_startup(struct uart_port *uport)
 {
 	int ret;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	if (!port->setup) {
 		ret = qcom_geni_serial_port_setup(uport);
@@ -1003,7 +1002,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	u32 stop_bit_len;
 	unsigned int clk_div;
 	u32 ser_clk_cfg;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	unsigned long clk_rate;
 	u32 ver, sampling_rate;
 	unsigned int avg_bw_core;
@@ -1288,7 +1287,7 @@ static struct uart_driver qcom_geni_uart_driver = {
 static void qcom_geni_serial_pm(struct uart_port *uport,
 		unsigned int new_state, unsigned int old_state)
 {
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	/* If we've never been called, treat it as off */
 	if (old_state == UART_PM_STATE_UNDEFINED)
-- 
2.37.2

