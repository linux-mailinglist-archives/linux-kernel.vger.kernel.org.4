Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031C863BE70
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbiK2LAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbiK2LAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:00:23 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB43D5CD0F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:00:22 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id r66-20020a1c4445000000b003d05a3775d4so4550044wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkZacf9TX3zvyVeUrL+nHxYirMYsPuTeW+Zo+lEbcT0=;
        b=ymqV7q53bvSU4CrarfDxQFR00R9D8YMrI+N5EwFtZvYEGwPr9XXHQazLobyxuBthbF
         CLskGiWGSuIulq9If4OwG48jM3vJ0E6Q0X3BVnpaiOcLs33eX+/JMcWACBZaAMlqLebn
         winH+dRCmI88m0gNS8U7LlQqYyli7iJYR4waUTqVUHry0Bz2e6xPR5izQw9PowSSxGu/
         f+UXJYzpFm4kvujtqA0MPI5L0R9Lf2xapVDZljwfQk2BLa5yfUJ/TXWdwbumWqBipc4U
         YnMhRfVTHVTFUanNhCJ11vDpqxaxJbJjll1/ZodaYVvLSjx3Q9p5uuLUl2oIB4aVRCHl
         82Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkZacf9TX3zvyVeUrL+nHxYirMYsPuTeW+Zo+lEbcT0=;
        b=F35zNrPVCEQNrW5gm/rrroOCRey4U1RTf+lggGzK9eHGx4GlPf78KNrcWcfcWtyXJZ
         QnBmRMKh2sllO21ZXXlaC9bVrjYmNxC3txonoJjn0Jp9w7HUFVlaa6OMrexfFjgEMbPM
         miMPNQX2nxxUIDc8mONzyU6Zuf+Bxl0IIrteNl/oUXAXXO0dIYiI/0dEzKrLGeI8udaK
         gZsuCcKnuWL4ASce8KGIJ8uUHjJTSmGh5J5Ss0ekrTFLP2/wkYXRAMYyXAhwQT+kC+Ql
         x6Kq/Xj6yQA5sLFoOFrxjKEdI8ZENZlvLE+vn7kRrwJdEQmw1bXgp+TnPTlM7yld7x30
         e4jA==
X-Gm-Message-State: ANoB5plnPQhvB37pvK27IUaHd31/dR9fZrpjuQdp4o7cllhiwqzCydjX
        bzy6vrwdINxHfAIJ5NSWqZwWHg==
X-Google-Smtp-Source: AA0mqf4E75mhjTHNy7PTTYWvDS5SFN/M+50o8ctNotiKaYOC6AwSOS1u/tBacyozgzngbw0fIO0nzA==
X-Received: by 2002:a7b:c046:0:b0:3cf:d58f:f66e with SMTP id u6-20020a7bc046000000b003cfd58ff66emr28931925wmc.165.1669719621501;
        Tue, 29 Nov 2022 03:00:21 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6b19:1d8e:fbca:fd02])
        by smtp.gmail.com with ESMTPSA id q19-20020a1cf313000000b003a3170a7af9sm1617658wmq.4.2022.11.29.03.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 03:00:21 -0800 (PST)
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
Subject: [PATCH v4 04/13] tty: serial: qcom-geni-serial: improve the to_dev_port() macro
Date:   Tue, 29 Nov 2022 12:00:03 +0100
Message-Id: <20221129110012.224685-5-brgl@bgdev.pl>
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

The member we want to resolve in struct qcom_geni_serial_port is called
uport so we don't need an additional redundant parameter in this macro.

While at it: turn the macro into a static inline function.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 36 ++++++++++++++-------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 97ee7c074b79..e4139718e084 100644
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
@@ -869,7 +871,7 @@ static void qcom_geni_serial_shutdown(struct uart_port *uport)
 
 static int qcom_geni_serial_port_setup(struct uart_port *uport)
 {
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	u32 rxstale = DEFAULT_BITS_PER_CHAR * STALE_TIMEOUT;
 	u32 proto;
 	u32 pin_swap;
@@ -917,7 +919,7 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 static int qcom_geni_serial_startup(struct uart_port *uport)
 {
 	int ret;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	if (!port->setup) {
 		ret = qcom_geni_serial_port_setup(uport);
@@ -1003,7 +1005,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	u32 stop_bit_len;
 	unsigned int clk_div;
 	u32 ser_clk_cfg;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	unsigned long clk_rate;
 	u32 ver, sampling_rate;
 	unsigned int avg_bw_core;
@@ -1288,7 +1290,7 @@ static struct uart_driver qcom_geni_uart_driver = {
 static void qcom_geni_serial_pm(struct uart_port *uport,
 		unsigned int new_state, unsigned int old_state)
 {
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	/* If we've never been called, treat it as off */
 	if (old_state == UART_PM_STATE_UNDEFINED)
-- 
2.37.2

