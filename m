Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324FD658E97
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 16:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiL2PwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 10:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbiL2Puu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 10:50:50 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DD42189
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 07:50:46 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so16615964wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 07:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBv8zHTOOLxZy2RrVYyB+getwbO3vReNF6vfPrfTbok=;
        b=MWfcjKD0Jfk0DPzARtgBKo9MCzAqpWQbsPxJpwmPJa8Cbqv4lBhQF4rna9DKu8oj9/
         55sPiqdse7RyR1pE99U+ZoNYJ7vke7LL4agedG+0UoTCJIZ2Ovc1ayJUuhe31STItRhn
         VS+/Z0Xp/fmfKcTu+ufsT9FU5Y7ZrRWgSfcIwmLwSkmSRx2C6Lqs+n1q8s+0tJMs8akW
         k+z+OOehqll+QKY7t1pxwDpYvK4/twBRb9dzsO+6L0GVUjZESgj+IlXgYjNXQEXwK6dh
         qD+eN1ZT/J1wO1ssaLZxAWWbFmOzHbwqGvTlZLSkf11TXEwwnda80OgguU9jrqLrZDFC
         v6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBv8zHTOOLxZy2RrVYyB+getwbO3vReNF6vfPrfTbok=;
        b=eUZOoO9lSddkGvvhd+/xub8OWkUkZR5+qIwR4ofk/JRLACNkhGrDOsnPIJFIHnAcM0
         9BMoUrLFoxFMZqG2hRdDBwlNYnoW0VuhHrX627i6fUMw301I18bhqa1PWl3CZb/y1O3j
         hAqT1fODCYgDA9mxloIe4VCQVWusmb/EktY5aS362k2fxvWnMxRajlJ3sL4J1zySMIgD
         rhJ+QRzhk/j5HNaiy4OXC0V3JMdyps+uL5Zh1jBb5trjYs5DfNozhUfcp62LvyoTAveG
         GhzRKHh0f0xECbzjfJki1q2yx3yO4P+93S29QrP/DwX+ryerPslwbtMLdCj/7GQGcvYc
         fV6g==
X-Gm-Message-State: AFqh2kpS7L1ddYOzRyKoqU7/G3yRb0UCFlN2sNvpQQ/YzpAMMMoS8wZf
        DtSXmEIRd4jSRNunclMrvoOGBw==
X-Google-Smtp-Source: AMrXdXuN12YDWaVW5BV/Kt9Vm4Z13l01wSqvmdr5l7KNl6nGg4MUTTVZ7DzF1PUZc+RzBLKLP68vGg==
X-Received: by 2002:a1c:4c12:0:b0:3c6:e63e:89a6 with SMTP id z18-20020a1c4c12000000b003c6e63e89a6mr20354994wmf.2.1672329045627;
        Thu, 29 Dec 2022 07:50:45 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8f7a:98d8:9d8d:ced8])
        by smtp.gmail.com with ESMTPSA id bh12-20020a05600c3d0c00b003cfa81e2eb4sm25251647wmb.38.2022.12.29.07.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 07:50:45 -0800 (PST)
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
Subject: [PATCH v6 12/14] tty: serial: qcom-geni-serial: use of_device_id data
Date:   Thu, 29 Dec 2022 16:50:28 +0100
Message-Id: <20221229155030.418800-13-brgl@bgdev.pl>
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

Instead of checking the device compatible in probe(), assign the
device-specific data to struct of_device_id. We'll use it later when
providing SE DMA support.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 46 ++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 6daa3e205fc9..0b3786040bfb 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -95,6 +95,11 @@
 /* We always configure 4 bytes per FIFO word */
 #define BYTES_PER_FIFO_WORD		4U
 
+struct qcom_geni_device_data {
+	bool console;
+	void (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
+};
+
 struct qcom_geni_private_data {
 	/* NOTE: earlycon port will have NULL here */
 	struct uart_driver *drv;
@@ -114,7 +119,6 @@ struct qcom_geni_serial_port {
 	u32 tx_fifo_width;
 	u32 rx_fifo_depth;
 	bool setup;
-	void (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
 	unsigned int baud;
 	void *rx_fifo;
 	u32 loopback;
@@ -126,6 +130,7 @@ struct qcom_geni_serial_port {
 	bool cts_rts_swap;
 
 	struct qcom_geni_private_data private_data;
+	const struct qcom_geni_device_data *dev_data;
 };
 
 static const struct uart_ops qcom_geni_console_pops;
@@ -640,7 +645,7 @@ static void qcom_geni_serial_handle_rx(struct uart_port *uport, bool drop)
 		total_bytes += last_word_byte_cnt;
 	else
 		total_bytes += BYTES_PER_FIFO_WORD;
-	port->handle_rx(uport, total_bytes, drop);
+	port->dev_data->handle_rx(uport, total_bytes, drop);
 }
 
 static void qcom_geni_serial_stop_rx(struct uart_port *uport)
@@ -1346,13 +1351,14 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	struct uart_port *uport;
 	struct resource *res;
 	int irq;
-	bool console = false;
 	struct uart_driver *drv;
+	const struct qcom_geni_device_data *data;
 
-	if (of_device_is_compatible(pdev->dev.of_node, "qcom,geni-debug-uart"))
-		console = true;
+	data = of_device_get_match_data(&pdev->dev);
+	if (!data)
+		return -EINVAL;
 
-	if (console) {
+	if (data->console) {
 		drv = &qcom_geni_console_driver;
 		line = of_alias_get_id(pdev->dev.of_node, "serial");
 	} else {
@@ -1362,7 +1368,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 			line = of_alias_get_id(pdev->dev.of_node, "hsuart");
 	}
 
-	port = get_port_from_line(line, console);
+	port = get_port_from_line(line, data->console);
 	if (IS_ERR(port)) {
 		dev_err(&pdev->dev, "Invalid line %d\n", line);
 		return PTR_ERR(port);
@@ -1374,6 +1380,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	uport->dev = &pdev->dev;
+	port->dev_data = data;
 	port->se.dev = &pdev->dev;
 	port->se.wrapper = dev_get_drvdata(pdev->dev.parent);
 	port->se.clk = devm_clk_get(&pdev->dev, "se");
@@ -1392,7 +1399,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	port->rx_fifo_depth = DEF_FIFO_DEPTH_WORDS;
 	port->tx_fifo_width = DEF_FIFO_WIDTH_BITS;
 
-	if (!console) {
+	if (!data->console) {
 		port->rx_fifo = devm_kcalloc(uport->dev,
 			port->rx_fifo_depth, sizeof(u32), GFP_KERNEL);
 		if (!port->rx_fifo)
@@ -1422,7 +1429,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	uport->irq = irq;
 	uport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_QCOM_GENI_CONSOLE);
 
-	if (!console)
+	if (!data->console)
 		port->wakeup_irq = platform_get_irq_optional(pdev, 1);
 
 	if (of_property_read_bool(pdev->dev.of_node, "rx-tx-swap"))
@@ -1444,7 +1451,6 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	port->private_data.drv = drv;
 	uport->private_data = &port->private_data;
 	platform_set_drvdata(pdev, port);
-	port->handle_rx = console ? handle_rx_console : handle_rx_uart;
 
 	ret = uart_add_one_port(drv, uport);
 	if (ret)
@@ -1556,6 +1562,16 @@ static int qcom_geni_serial_sys_hib_resume(struct device *dev)
 	return ret;
 }
 
+static const struct qcom_geni_device_data qcom_geni_console_data = {
+	.console = true,
+	.handle_rx = handle_rx_console,
+};
+
+static const struct qcom_geni_device_data qcom_geni_uart_data = {
+	.console = false,
+	.handle_rx = handle_rx_uart,
+};
+
 static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(qcom_geni_serial_sys_suspend,
 					qcom_geni_serial_sys_resume)
@@ -1564,8 +1580,14 @@ static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
 };
 
 static const struct of_device_id qcom_geni_serial_match_table[] = {
-	{ .compatible = "qcom,geni-debug-uart", },
-	{ .compatible = "qcom,geni-uart", },
+	{
+		.compatible = "qcom,geni-debug-uart",
+		.data = &qcom_geni_console_data,
+	},
+	{
+		.compatible = "qcom,geni-uart",
+		.data = &qcom_geni_uart_data,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_geni_serial_match_table);
-- 
2.37.2

