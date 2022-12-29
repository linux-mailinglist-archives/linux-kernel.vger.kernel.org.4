Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D3F658E82
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 16:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbiL2Pu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 10:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbiL2Pul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 10:50:41 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480FA13F4F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 07:50:39 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso13473857wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 07:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTBjJnbC2jcK/U6kcPP63swBkiUWRZWtVNKlNlvxvdA=;
        b=rnJLV6jDgxvrOimj+97Y/JoPHeT2PyG9CgZ0J1458YFn1neIkvZxPvnuz6+RkVb8sN
         YfQYgRmrvRLxddDMUkhM+wWq+fnlT6sGpKZfhnb/k3RZTBo/zGBlFtngaoP0aaVKUMRn
         nlL2ajXaYDl333kbdMFE6qZv0Cy7BRQ7tH+LzO29PfQkAEaLo+/0QOqwhOjyW9YB0bQ/
         Qjyj70j5x+kkEs0IbwAthpNcYPHlD0bu4l6D00ecbN4f//N+Ocb96VyJXD6YLROhE7jf
         vtUhlv7LvFZYwbV+tnJcy46NSrufoHe+5PYcZzsSGExuw7MOhNWKcE0OBf8JU0w8v+B1
         xF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTBjJnbC2jcK/U6kcPP63swBkiUWRZWtVNKlNlvxvdA=;
        b=UkoC+12ibP1idsLaLigw0bZi26erAzc0+v45muSdItZ1bPEq5PFmowwMHGJp3DbIlq
         AygvHgFvK6EBZkSKHcDnbu04Ombf4kfAInkYyNj0aEaP6NAsdKftOpJJwGzK2A+Yst5C
         Q0ZUfNdiOAIfgRGsrvTKOgQevJMbimYCfCTRkDvGFhgv3NOF2qVVO9NVraCzWmHkT39Y
         moQ90k16ua48pOScdvy8MtBYNScn4D7RwkuRknuQsR1EYf5X2/7tJ+jEpQMgN6Clm5R2
         8VlGQqKqf70AVHRKtnj9oiGjszaUyKtMRi+R2jmB6rjI130N4etqYufAPByfrmVDgTk8
         lIPA==
X-Gm-Message-State: AFqh2kokXaPd8IfhZH6hEep3g4MDB6IqmrW52B5vpCY1C2e/KRDMMgV9
        RkC97QnD9DKqfp4lDWwYOP8avg==
X-Google-Smtp-Source: AMrXdXuNsTn+hIZcSw2u0mTZWw+OrvRI963yf3H80jldX7PZ0QPLNIYHDlWbY3VC3btSjdGnXFeYyg==
X-Received: by 2002:a05:600c:b92:b0:3d9:779e:9788 with SMTP id fl18-20020a05600c0b9200b003d9779e9788mr11404075wmb.37.1672329038812;
        Thu, 29 Dec 2022 07:50:38 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8f7a:98d8:9d8d:ced8])
        by smtp.gmail.com with ESMTPSA id bh12-20020a05600c3d0c00b003cfa81e2eb4sm25251647wmb.38.2022.12.29.07.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 07:50:38 -0800 (PST)
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
Subject: [PATCH v6 05/14] tty: serial: qcom-geni-serial: improve the to_dev_port() macro
Date:   Thu, 29 Dec 2022 16:50:21 +0100
Message-Id: <20221229155030.418800-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221229155030.418800-1-brgl@bgdev.pl>
References: <20221229155030.418800-1-brgl@bgdev.pl>
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

While at it: turn the macro into a static inline function.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 36 ++++++++++++++-------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index a4a50f2a6554..803a46ce4179 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -133,8 +133,10 @@ static const struct uart_ops qcom_geni_uart_pops;
 static struct uart_driver qcom_geni_console_driver;
 static struct uart_driver qcom_geni_uart_driver;
 
-#define to_dev_port(ptr, member) \
-		container_of(ptr, struct qcom_geni_serial_port, member)
+static inline struct qcom_geni_serial_port *to_dev_port(struct uart_port *uport)
+{
+	return container_of(uport, struct qcom_geni_serial_port, uport);
+}
 
 static struct qcom_geni_serial_port qcom_geni_uart_ports[GENI_UART_PORTS] = {
 	[0] = {
@@ -175,7 +177,7 @@ static struct qcom_geni_serial_port qcom_geni_console_port = {
 static int qcom_geni_serial_request_port(struct uart_port *uport)
 {
 	struct platform_device *pdev = to_platform_device(uport->dev);
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	uport->membase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(uport->membase))
@@ -212,7 +214,7 @@ static void qcom_geni_serial_set_mctrl(struct uart_port *uport,
 							unsigned int mctrl)
 {
 	u32 uart_manual_rfr = 0;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	if (uart_console(uport))
 		return;
@@ -253,7 +255,7 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
 	struct qcom_geni_private_data *private_data = uport->private_data;
 
 	if (private_data->drv) {
-		port = to_dev_port(uport, uport);
+		port = to_dev_port(uport);
 		baud = port->baud;
 		if (!baud)
 			baud = 115200;
@@ -506,7 +508,7 @@ static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
 	u32 i;
 	unsigned char buf[sizeof(u32)];
 	struct tty_port *tport;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	tport = &uport->state->port;
 	for (i = 0; i < bytes; ) {
@@ -549,7 +551,7 @@ static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
 static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
 {
 	struct tty_port *tport;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	u32 num_bytes_pw = port->tx_fifo_width / BITS_PER_BYTE;
 	u32 words = ALIGN(bytes, num_bytes_pw) / num_bytes_pw;
 	int ret;
@@ -598,7 +600,7 @@ static void qcom_geni_serial_stop_tx(struct uart_port *uport)
 {
 	u32 irq_en;
 	u32 status;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
 	irq_en &= ~(M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN);
@@ -627,7 +629,7 @@ static void qcom_geni_serial_handle_rx(struct uart_port *uport, bool drop)
 	u32 last_word_byte_cnt;
 	u32 last_word_partial;
 	u32 total_bytes;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	status = readl(uport->membase +	SE_GENI_RX_FIFO_STATUS);
 	word_cnt = status & RX_FIFO_WC_MSK;
@@ -649,7 +651,7 @@ static void qcom_geni_serial_stop_rx(struct uart_port *uport)
 {
 	u32 irq_en;
 	u32 status;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	u32 s_irq_status;
 
 	irq_en = readl(uport->membase + SE_GENI_S_IRQ_EN);
@@ -687,7 +689,7 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
 {
 	u32 irq_en;
 	u32 status;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	status = readl(uport->membase + SE_GENI_STATUS);
 	if (status & S_GENI_CMD_ACTIVE)
@@ -707,7 +709,7 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
 static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 		bool active)
 {
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	struct circ_buf *xmit = &uport->state->xmit;
 	size_t avail;
 	size_t remaining;
@@ -803,7 +805,7 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 	struct uart_port *uport = dev;
 	bool drop_rx = false;
 	struct tty_port *tport = &uport->state->port;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	if (uport->suspended)
 		return IRQ_NONE;
@@ -871,7 +873,7 @@ static void qcom_geni_serial_shutdown(struct uart_port *uport)
 
 static int qcom_geni_serial_port_setup(struct uart_port *uport)
 {
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	u32 rxstale = DEFAULT_BITS_PER_CHAR * STALE_TIMEOUT;
 	u32 proto;
 	u32 pin_swap;
@@ -920,7 +922,7 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 static int qcom_geni_serial_startup(struct uart_port *uport)
 {
 	int ret;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	if (!port->setup) {
 		ret = qcom_geni_serial_port_setup(uport);
@@ -1006,7 +1008,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	u32 stop_bit_len;
 	unsigned int clk_div;
 	u32 ser_clk_cfg;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	unsigned long clk_rate;
 	u32 ver, sampling_rate;
 	unsigned int avg_bw_core;
@@ -1291,7 +1293,7 @@ static struct uart_driver qcom_geni_uart_driver = {
 static void qcom_geni_serial_pm(struct uart_port *uport,
 		unsigned int new_state, unsigned int old_state)
 {
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	/* If we've never been called, treat it as off */
 	if (old_state == UART_PM_STATE_UNDEFINED)
-- 
2.37.2

