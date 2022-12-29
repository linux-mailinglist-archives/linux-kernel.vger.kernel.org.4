Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C0B658E89
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 16:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbiL2Pvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 10:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbiL2Pup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 10:50:45 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2042BF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 07:50:43 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o15so13397895wmr.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 07:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMVKrwdZWEXr4SpaY5rZECUzCmLZAbyQFJGjBVIK3cY=;
        b=M4K3oPLWC8XPeEjHXcBiEU120Ik7Q3MhxDOxbT6QisHcUgbXhyMnIIQVhzuXEhsnKi
         SOi42g9ylj8TQdeq9kuF52sBvj/8mx24DLAuRrYSbyKGnkur/8B6w/X2TeAj6t+pGK84
         fR1fum/WpBxE150PCiI6gJ0nWLFaA4FMnMCcEpmU1vPfmGwwne0Rq1a32gC56qAe8Eay
         DJQg6pSrnYTQEKnHbwHsICnQBp4yUC3p7afEZrl2+8ptdG9i3ClZW/dstgJkOuzEr6+o
         fieZ1VtpPl7Obr/riPpG6Sxd6d/1q1F1zWOAqwRni9GGn+sxzDF1JW0ihLCuVnlb4JT5
         IXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMVKrwdZWEXr4SpaY5rZECUzCmLZAbyQFJGjBVIK3cY=;
        b=sNgeKacxQAQzZ0dkKI5PWS9IOD1vTdHhCCvzKUI3Wre4V2j9uuLaQpCb/gFGuTL9zq
         ZyTJXklZmMsmtHAlx9nSMuqzNTFau29vwJh+nCwJ3EnjDlxB2kJCSAYIM02hf2xfITQK
         f21xZlIt+7IIqP6FG/H8V/swFpXTVu45Kmdra12WBAte6rVZNan4nrAJOfmLLHKOwYn3
         Mqu4/6Dp8xZ/fY6T/TwOS+kfr8XoYJreyZB2o/NhCep/M36vOHV9C2DqtdGyET8LgCdy
         S+LZGZG0QPGDj4fGJVFEmGV+On9gXbljExF7ZV8fVFI0/j4sjhywvRxhAwRFG5AWinTO
         Tp7A==
X-Gm-Message-State: AFqh2kqGoUfZT3elGBJNxqGz7Gf0MIv0XstqnXhcju1XdzNYQ3HJCtUK
        8/39HCh4oixszUKINCX3u23o3w==
X-Google-Smtp-Source: AMrXdXt2KvdOsGmdgCgY2p4lN7SOGTNM5pDZhTjrxi31uhL0bxEl8B0zOb6NWjynO+iUA0avgVVXdg==
X-Received: by 2002:a05:600c:1e10:b0:3d1:f496:e25f with SMTP id ay16-20020a05600c1e1000b003d1f496e25fmr21640763wmb.16.1672329042697;
        Thu, 29 Dec 2022 07:50:42 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8f7a:98d8:9d8d:ced8])
        by smtp.gmail.com with ESMTPSA id bh12-20020a05600c3d0c00b003cfa81e2eb4sm25251647wmb.38.2022.12.29.07.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 07:50:42 -0800 (PST)
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
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v6 09/14] tty: serial: qcom-geni-serial: split out the FIFO tx code
Date:   Thu, 29 Dec 2022 16:50:25 +0100
Message-Id: <20221229155030.418800-10-brgl@bgdev.pl>
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

qcom_geni_serial_handle_tx() is pretty big, let's move the code that
handles the actual writing of data to a separate function which makes
sense in preparation for introducing a dma variant of handle_tx().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 60 +++++++++++++++------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index e34fe56247d9..bd91a6a5ad37 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -704,19 +704,48 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
 	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 }
 
+static int qcom_geni_serial_send_chunk_fifo(struct uart_port *uport,
+					    unsigned int chunk)
+{
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+	struct circ_buf *xmit = &uport->state->xmit;
+	size_t remaining = chunk;
+	int i, tail = xmit->tail;
+
+	for (i = 0; i < chunk; ) {
+		unsigned int tx_bytes;
+		u8 buf[sizeof(u32)];
+		int c;
+
+		memset(buf, 0, sizeof(buf));
+		tx_bytes = min_t(size_t, remaining, BYTES_PER_FIFO_WORD);
+
+		for (c = 0; c < tx_bytes ; c++) {
+			buf[c] = xmit->buf[tail++];
+			tail &= UART_XMIT_SIZE - 1;
+		}
+
+		iowrite32_rep(uport->membase + SE_GENI_TX_FIFOn, buf, 1);
+
+		i += tx_bytes;
+		uport->icount.tx += tx_bytes;
+		remaining -= tx_bytes;
+		port->tx_remaining -= tx_bytes;
+	}
+
+	return tail;
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
 
@@ -735,7 +764,6 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 	avail = port->tx_fifo_depth - (status & TX_FIFO_WC);
 	avail *= BYTES_PER_FIFO_WORD;
 
-	tail = xmit->tail;
 	chunk = min(avail, pending);
 	if (!chunk)
 		goto out_write_wakeup;
@@ -750,29 +778,7 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
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
+	xmit->tail = qcom_geni_serial_send_chunk_fifo(uport, chunk);
 
 	/*
 	 * The tx fifo watermark is level triggered and latched. Though we had
-- 
2.37.2

