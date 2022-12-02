Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BDB64029D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiLBI42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbiLBI4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:56:05 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4241BF660
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 00:56:01 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n7so3050530wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 00:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EJrTQIS5zIHcJVe/CbMMVgFbpImlTtQ6/Fo8uf0cQs=;
        b=JIqlacfCsCrmPalBO+OWEy2050PGFO4+Z4HoYN3BUUX17PUxngGVj5jQldKkoECl5Q
         54u/hQK7mLJb9TFrtlj/QfPaXo4bFtIezelgVJ7TBtJI+/Zqbvb3mcJQ7S5NF9EZ58sl
         RhGu6zoDpQwCDzXclKQLni7FD0MkCchGRBCCnXcWT/mgJrfwCQKN66xgCfQTsEN7m1CW
         ZQWmAa4A16X4GG8wAeqcksl2qFVzcrZlmO7c7QHiTntK40Ezz6vUuKA19d7n8ZPnP9B4
         Sl2eoq9P4uD4Vvxf9yutqdRHLS1NG9ilfHwtovoQNJ2JmVRK5ytbbSJmk3EhiSfs96K8
         6b7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EJrTQIS5zIHcJVe/CbMMVgFbpImlTtQ6/Fo8uf0cQs=;
        b=1yp66aetLmtxnpBQULFykBLYO/Mx8nBYjUW6QEVsETDv3a2OuCGpkppbEx+xHahgmf
         0AZVVepZCqBSkrM8a7UZE7Ci2CRyrMImi5Olfnwle5xupW8XMJOWQPYJIzEgv2tFabeB
         p4UJ9ExXn17gfVHCrBHWoD/J3F+SZ52phvVN3C6RYRfmFFc6NcrPiAderFDnnheUkw6L
         ghiUuJkvLSzHBdExw6OIIJYqMa+WRhjXp/qOlv29GuHzaw/M/ZPFzgHN58euo2j/8tT7
         7+1Ca5/UgPnUpX7jqb0U0WT4v8yAZMUGzbTwcBEypKhT40OzFF7Ui0+lBSKk7/JxQUaH
         fowA==
X-Gm-Message-State: ANoB5pkQ/5VieKSY1XGUJdd2yQZh2wbhCb3Xzb1yWekqmqKVPWA8Y4iH
        LfhOWK+lKji2/IskgLDiwWyg8w==
X-Google-Smtp-Source: AA0mqf4H7BdOQHxq22fHKrgFGPUb7PNDquCgpqtQ/MMdOum4urukiu96DWWC6by43Pc+TSLm0iM8hw==
X-Received: by 2002:a05:600c:4d09:b0:3d0:7e33:9e3f with SMTP id u9-20020a05600c4d0900b003d07e339e3fmr4635685wmp.163.1669971360183;
        Fri, 02 Dec 2022 00:56:00 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:29a4:6f04:ddb1:1ed7])
        by smtp.gmail.com with ESMTPSA id a13-20020adfed0d000000b0024219b1cb1bsm6527517wro.60.2022.12.02.00.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 00:55:59 -0800 (PST)
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
Subject: [PATCH v5 03/14] tty: serial: qcom-geni-serial: align #define values
Date:   Fri,  2 Dec 2022 09:55:43 +0100
Message-Id: <20221202085554.59637-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221202085554.59637-1-brgl@bgdev.pl>
References: <20221202085554.59637-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Keep the #define symbols aligned for better readability.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 62 +++++++++++++--------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 7af5df6833c7..97ee7c074b79 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -39,57 +39,57 @@
 #define SE_UART_MANUAL_RFR		0x2ac
 
 /* SE_UART_TRANS_CFG */
-#define UART_TX_PAR_EN		BIT(0)
-#define UART_CTS_MASK		BIT(1)
+#define UART_TX_PAR_EN			BIT(0)
+#define UART_CTS_MASK			BIT(1)
 
 /* SE_UART_TX_STOP_BIT_LEN */
-#define TX_STOP_BIT_LEN_1	0
-#define TX_STOP_BIT_LEN_2	2
+#define TX_STOP_BIT_LEN_1		0
+#define TX_STOP_BIT_LEN_2		2
 
 /* SE_UART_RX_TRANS_CFG */
-#define UART_RX_PAR_EN		BIT(3)
+#define UART_RX_PAR_EN			BIT(3)
 
 /* SE_UART_RX_WORD_LEN */
-#define RX_WORD_LEN_MASK	GENMASK(9, 0)
+#define RX_WORD_LEN_MASK		GENMASK(9, 0)
 
 /* SE_UART_RX_STALE_CNT */
-#define RX_STALE_CNT		GENMASK(23, 0)
+#define RX_STALE_CNT			GENMASK(23, 0)
 
 /* SE_UART_TX_PARITY_CFG/RX_PARITY_CFG */
-#define PAR_CALC_EN		BIT(0)
-#define PAR_EVEN		0x00
-#define PAR_ODD			0x01
-#define PAR_SPACE		0x10
+#define PAR_CALC_EN			BIT(0)
+#define PAR_EVEN			0x00
+#define PAR_ODD				0x01
+#define PAR_SPACE			0x10
 
 /* SE_UART_MANUAL_RFR register fields */
-#define UART_MANUAL_RFR_EN	BIT(31)
-#define UART_RFR_NOT_READY	BIT(1)
-#define UART_RFR_READY		BIT(0)
+#define UART_MANUAL_RFR_EN		BIT(31)
+#define UART_RFR_NOT_READY		BIT(1)
+#define UART_RFR_READY			BIT(0)
 
 /* UART M_CMD OP codes */
-#define UART_START_TX		0x1
+#define UART_START_TX			0x1
 /* UART S_CMD OP codes */
-#define UART_START_READ		0x1
-
-#define UART_OVERSAMPLING	32
-#define STALE_TIMEOUT		16
-#define DEFAULT_BITS_PER_CHAR	10
-#define GENI_UART_CONS_PORTS	1
-#define GENI_UART_PORTS		3
-#define DEF_FIFO_DEPTH_WORDS	16
-#define DEF_TX_WM		2
-#define DEF_FIFO_WIDTH_BITS	32
-#define UART_RX_WM		2
+#define UART_START_READ			0x1
+
+#define UART_OVERSAMPLING		32
+#define STALE_TIMEOUT			16
+#define DEFAULT_BITS_PER_CHAR		10
+#define GENI_UART_CONS_PORTS		1
+#define GENI_UART_PORTS			3
+#define DEF_FIFO_DEPTH_WORDS		16
+#define DEF_TX_WM			2
+#define DEF_FIFO_WIDTH_BITS		32
+#define UART_RX_WM			2
 
 /* SE_UART_LOOPBACK_CFG */
-#define RX_TX_SORTED	BIT(0)
-#define CTS_RTS_SORTED	BIT(1)
-#define RX_TX_CTS_RTS_SORTED	(RX_TX_SORTED | CTS_RTS_SORTED)
+#define RX_TX_SORTED			BIT(0)
+#define CTS_RTS_SORTED			BIT(1)
+#define RX_TX_CTS_RTS_SORTED		(RX_TX_SORTED | CTS_RTS_SORTED)
 
 /* UART pin swap value */
-#define DEFAULT_IO_MACRO_IO0_IO1_MASK		GENMASK(3, 0)
+#define DEFAULT_IO_MACRO_IO0_IO1_MASK	GENMASK(3, 0)
 #define IO_MACRO_IO0_SEL		0x3
-#define DEFAULT_IO_MACRO_IO2_IO3_MASK		GENMASK(15, 4)
+#define DEFAULT_IO_MACRO_IO2_IO3_MASK	GENMASK(15, 4)
 #define IO_MACRO_IO2_IO3_SWAP		0x4640
 
 /* We always configure 4 bytes per FIFO word */
-- 
2.37.2

