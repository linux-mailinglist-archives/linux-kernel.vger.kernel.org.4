Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB9C635B45
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbiKWLJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237619AbiKWLId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:08:33 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D8A9BA14
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:08:13 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bs21so28863641wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzY04K9GyuBHm3usH7zJK0sqLLvwAU6csJcimfdY1bo=;
        b=SxiA56FEPn1tTlUbvznsd9HsII5+1ZsnUYrfPdthATClaXeuh1+DSatCx06H9IKbrv
         7/bWd6pe0VRT0Jau2lKEnpkt6iYiYC51ali/LiNmmatnIrZdhm83XyiG4MaR9P9H1UWE
         Kh4e9kBKrNhNRnWU8jdtmiIkjWNVqH4Ld7wqO4C1n2RFKLfXcml/OGJ6jMYkCvEum7DL
         jodgRO1kQoDRtln/s2aUNthOQM2Ftcil/KpixJs8ZK0prPq1R3iJOiY3KS55WzFN3T9G
         eZ9IbE+jN5H6S/6OY9+cHF5jV14dOOZeqc+APeugwZifOT9Hqp4LU4jryhmZtuHCW0Jr
         tzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzY04K9GyuBHm3usH7zJK0sqLLvwAU6csJcimfdY1bo=;
        b=gkUT2t20mdGu6DYOrqLDNMIqh12QNiBsrI0NVQmrlci+h97gAw8Vf6IxyNERhUKd6N
         wWERNUc/tD3f2Oky7hBOf7Acv2zeVSl492LxoaBg6+3Q+Iu/VMbEom+aGgTmCPf3nTZE
         XeTfcrYQhWKp9d6rYQKSj4RGr8HaMdo/gskuB/0s8lhttp378nnx8i3k8PWZEEhNcsmD
         ndJv5A/1r81eH7rQ2VnJsYMt/Ggz4gnDTKMjh7FRgEH2/zT4mdO0QtQ4JQNQb22Dsig3
         jB1czTJh4/go/KuQbeokV1n2Hnbgymymbmn00iKAce1Va4zg/5ldkJ7s7WcVaPIVXiHq
         lSBg==
X-Gm-Message-State: ANoB5pmv6TNcF39Vxb2cWtfJmd+Y9al8RmmBQBriBAPQLu/6DgbElPbj
        3SKwkrTFzZxupKAxxxNMkr+WZA==
X-Google-Smtp-Source: AA0mqf6JZaxLA6+i2yDWj1lFtnlxnO2S5fLvX9YGI8ysDpwpWSst9x/t1Nl3BbMIfPGK+7BounysRw==
X-Received: by 2002:adf:dfc6:0:b0:236:cfcf:8e36 with SMTP id q6-20020adfdfc6000000b00236cfcf8e36mr17163483wrn.323.1669201692287;
        Wed, 23 Nov 2022 03:08:12 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ae74:d94f:4677:3378])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b003c6c182bef9sm2560406wmq.36.2022.11.23.03.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 03:08:11 -0800 (PST)
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
Subject: [PATCH v3 08/13] tty: serial: qcom-geni-serial: refactor qcom_geni_serial_handle_tx()
Date:   Wed, 23 Nov 2022 12:07:54 +0100
Message-Id: <20221123110759.1836666-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221123110759.1836666-1-brgl@bgdev.pl>
References: <20221123110759.1836666-1-brgl@bgdev.pl>
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

qcom_geni_serial_handle_tx() is pretty big, let's move the code that
handles the actual writing of data to a separate function which makes
sense in preparation for introducing a dma variant of handle_tx().

Let's also shuffle the code a bit, drop unneeded variables and use
uart_xmit_advance() instead of handling tail->xmit manually.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 54 +++++++++++++--------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 68a1402fbe58..658b6d596f58 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -704,19 +704,42 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
 	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 }
 
+static void qcom_geni_serial_send_chunk_fifo(struct uart_port *uport,
+					     unsigned int chunk)
+{
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+	struct circ_buf *xmit = &uport->state->xmit;
+	u8 buf[BYTES_PER_FIFO_WORD];
+	size_t remaining = chunk;
+	unsigned int tx_bytes;
+	int c;
+
+	while (remaining) {
+		memset(buf, 0, sizeof(buf));
+		tx_bytes = min_t(size_t, remaining, BYTES_PER_FIFO_WORD);
+
+		for (c = 0; c < tx_bytes ; c++) {
+			buf[c] = xmit->buf[xmit->tail];
+			uart_xmit_advance(uport, 1);
+		}
+
+		iowrite32_rep(uport->membase + SE_GENI_TX_FIFOn, buf, 1);
+
+		remaining -= tx_bytes;
+		port->tx_remaining -= tx_bytes;
+	}
+}
+
 static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 		bool active)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	struct circ_buf *xmit = &uport->state->xmit;
 	size_t avail;
-	size_t remaining;
 	size_t pending;
-	int i;
 	u32 status;
 	u32 irq_en;
 	unsigned int chunk;
-	int tail;
 
 	status = readl(uport->membase + SE_GENI_TX_FIFO_STATUS);
 
@@ -735,7 +758,6 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 	avail = port->tx_fifo_depth - (status & TX_FIFO_WC);
 	avail *= BYTES_PER_FIFO_WORD;
 
-	tail = xmit->tail;
 	chunk = min(avail, pending);
 	if (!chunk)
 		goto out_write_wakeup;
@@ -750,29 +772,7 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 					uport->membase + SE_GENI_M_IRQ_EN);
 	}
 
-	remaining = chunk;
-	for (i = 0; i < chunk; ) {
-		unsigned int tx_bytes;
-		u8 buf[sizeof(u32)];
-		int c;
-
-		memset(buf, 0, sizeof(buf));
-		tx_bytes = min_t(size_t, remaining, BYTES_PER_FIFO_WORD);
-
-		for (c = 0; c < tx_bytes ; c++) {
-			buf[c] = xmit->buf[tail++];
-			tail &= UART_XMIT_SIZE - 1;
-		}
-
-		iowrite32_rep(uport->membase + SE_GENI_TX_FIFOn, buf, 1);
-
-		i += tx_bytes;
-		uport->icount.tx += tx_bytes;
-		remaining -= tx_bytes;
-		port->tx_remaining -= tx_bytes;
-	}
-
-	xmit->tail = tail;
+	qcom_geni_serial_send_chunk_fifo(uport, chunk);
 
 	/*
 	 * The tx fifo watermark is level triggered and latched. Though we had
-- 
2.37.2

