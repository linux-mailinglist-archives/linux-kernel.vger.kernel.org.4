Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C3E63BE73
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiK2LBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbiK2LA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:00:29 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F5B60EA0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:00:25 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so623548wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCx51yC9FU1yXWOh1yw/MuoHVQ7pzTJCbQJJlG1PhVk=;
        b=fg/ELnn3dT2bcQp3NIsvGvAOU4IIfMZG7ttb8g21jmYpRlMWMygqPh6xHOp87tY7p1
         yaEc/eMl02eyBI04DF+CFr9KsOVEFG+N7r+BLdaPQLVtF54wlSfc7YcZpkal/k3zGsWg
         nD+HEkPmENlhGytkXDIbO0TLrjIJl3lPnVcSL1RqGVeKPjQrAnxZtMGAWWuKuJ9eJz+o
         TRPMuSq8a6uVrYDfO/jyddUfd6iT2ItfcEJji9G+/6TePWUfizyi1mneFNTVC3AcGoOb
         n91WZsy8rlNs/Z5jiUrzLzIBv9clb8pzVX0Zec+vdA0M96YJaXEY1enbT9zWaJkAdlip
         Ttfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCx51yC9FU1yXWOh1yw/MuoHVQ7pzTJCbQJJlG1PhVk=;
        b=okJwGMtwk7XjAjtrNb3bBB4d2TNl65nt/0vb8CvKvGvx0vnRGyaZyH2bU4MeqHjGW4
         FDlPxl2RG3C6zK3TuFQ5DFXfXf1/ZWjxAyqppmHZSYB9No/DFk+zi2DPYg4Bn8TU2mqv
         IWNoQLTJcBSHVcFOMMiVuQ0Xfh2lAkIZ207fRLJ/s7XbhqhgO73nubFuPjlA9oVq2ldT
         qhcQloNUspfPrTcg9lGiUrEahPDJ8ICbgqdUgQGhWL5z0Qcd06gQNaYjLG2k3BdT/fls
         Px9vg5v6RWMt3ZybGcvpbJQIQRAjmKUrdPTtc20hCt9eJvAyXjmM2bPQHbGWbqnEQ9+s
         aOpg==
X-Gm-Message-State: ANoB5pnlPeTLQ/c6bcFPOIBKXQoukhmJwOtpzK+f9pwtB832mVlgonmZ
        BQbjiuwKXgBZBeeiIlBCovux+w3jn61I1Q==
X-Google-Smtp-Source: AA0mqf4A8+jlrMOET9sawxjDQfpCcherYi21OVJ+m7bOPfzZf0RJvzBAFf3zIRN40FNPqQJr5SiKDw==
X-Received: by 2002:a05:600c:2193:b0:3cf:a323:bfe6 with SMTP id e19-20020a05600c219300b003cfa323bfe6mr33940371wme.86.1669719625514;
        Tue, 29 Nov 2022 03:00:25 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6b19:1d8e:fbca:fd02])
        by smtp.gmail.com with ESMTPSA id q19-20020a1cf313000000b003a3170a7af9sm1617658wmq.4.2022.11.29.03.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 03:00:25 -0800 (PST)
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
Subject: [PATCH v4 08/13] tty: serial: qcom-geni-serial: refactor qcom_geni_serial_handle_tx()
Date:   Tue, 29 Nov 2022 12:00:07 +0100
Message-Id: <20221129110012.224685-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221129110012.224685-1-brgl@bgdev.pl>
References: <20221129110012.224685-1-brgl@bgdev.pl>
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

qcom_geni_serial_handle_tx() is pretty big, let's move the code that
handles the actual writing of data to a separate function which makes
sense in preparation for introducing a dma variant of handle_tx().

Let's also shuffle the code a bit, drop unneeded variables and use
uart_xmit_advance() instead of handling tail->xmit manually.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 55 +++++++++++++--------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 68a1402fbe58..ece5b4d543fc 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -93,7 +93,7 @@
 #define IO_MACRO_IO2_IO3_SWAP		0x4640
 
 /* We always configure 4 bytes per FIFO word */
-#define BYTES_PER_FIFO_WORD		4
+#define BYTES_PER_FIFO_WORD		4U
 
 struct qcom_geni_private_data {
 	/* NOTE: earlycon port will have NULL here */
@@ -704,19 +704,41 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
 	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 }
 
+static void qcom_geni_serial_send_chunk_fifo(struct uart_port *uport,
+					     unsigned int chunk)
+{
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+	struct circ_buf *xmit = &uport->state->xmit;
+	unsigned int tx_bytes, remaining = chunk;
+	u8 buf[BYTES_PER_FIFO_WORD];
+	int c;
+
+	while (remaining) {
+		memset(buf, 0, sizeof(buf));
+		tx_bytes = min(remaining, BYTES_PER_FIFO_WORD);
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
 
@@ -735,7 +757,6 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 	avail = port->tx_fifo_depth - (status & TX_FIFO_WC);
 	avail *= BYTES_PER_FIFO_WORD;
 
-	tail = xmit->tail;
 	chunk = min(avail, pending);
 	if (!chunk)
 		goto out_write_wakeup;
@@ -750,29 +771,7 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
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

