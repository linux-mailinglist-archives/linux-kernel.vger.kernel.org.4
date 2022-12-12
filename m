Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849F164A6A0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbiLLSJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbiLLSIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:08:21 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341756151
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:07:50 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id h8-20020a1c2108000000b003d1efd60b65so5945941wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8uXFQDQkqLQIMCCxoCS+6jURPh07ZY2kozA9MFfN3M=;
        b=WyMYo3JOmKqR6l1OTjzSAVzd/O6pzzj38Z8131LC916E6Bjpk6YUmO/UGsza5Qfu/N
         WF1eGeJubEX7OWJu1Buj8ONi3vtB//zq+MFRrmPjPhCw9sHj2Q+2xIqp0gS8pX6x9CgW
         2FM/3QzPb1B8BgDFwRJ6Dia2koBzZQv8rBROfQ+sQcUHs1we2jAzhrSL0AEb9QgBZ0eJ
         jmWs2mG13FYebAS3JQ043Vl6lqRmadTWurytHmlopBV/HKJpcsilZxFMxbRwLzfduc2l
         3s319UftBuIDMk6mAFewnSLQyMtZ2tr4WC3o9Tm3bbbRm0y12EBQ8ryJwxrWgrbtlueF
         KRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8uXFQDQkqLQIMCCxoCS+6jURPh07ZY2kozA9MFfN3M=;
        b=a2SA4o2Ci/MuODRi/x95fda0DPdmrIaVEQ7XK1WPcR8X+bdE3g1e82L72AJIcQ0HOJ
         qz+OoO1fqN1bbfVcZEF8x8i8Ctrk5cnO1vZ/d/PbNyt3qSgmMErFyPJlr3wh+Bam1s6g
         lWF5KoXfFaRaFN6gXjO3qnLD/XyxHT7TYmPtiDuNE65MgLecDqx1M5MX6mLZWCv//Idz
         GOYx9BF9as2QGnQdi0hKnvT5gzKCtrawoHD5qGfKOT31XyOzGyxUIwLBmP8QysLuIsGR
         V9rbeT23Rvostz4CqLvbrINhJ0D48PPta5HPKE1tyHuSImRmazBLCbFSQ/KQGTeK8nPk
         G5Rg==
X-Gm-Message-State: ANoB5plgyrKMRy2rNsybuSFCr/6Nqu7erjWEDnOzOOVeHztmINTJ6qvZ
        KT7DIacbn1PIuSW4N01eULcy3g==
X-Google-Smtp-Source: AA0mqf6b79xT/oO0cekZ5BaCDQCbXRdsCcbTP9RoWft1JiWLKKW8AR/nkgvIL2DzS5OU8fjYcZsWbA==
X-Received: by 2002:a05:600c:4fd0:b0:3d1:c0a1:4804 with SMTP id o16-20020a05600c4fd000b003d1c0a14804mr13434541wmq.17.1670868469792;
        Mon, 12 Dec 2022 10:07:49 -0800 (PST)
Received: from localhost.localdomain (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id t123-20020a1c4681000000b003a3170a7af9sm10156808wma.4.2022.12.12.10.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:07:49 -0800 (PST)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH v2 09/15] spi: dw: use irq handler for enhanced spi
Date:   Mon, 12 Dec 2022 18:07:26 +0000
Message-Id: <20221212180732.79167-10-sudip.mukherjee@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
References: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the interrupt handler for enhanced spi to read or write based
on the generated irq. Also, use the xfer_completion from spi_controller
to wait for a timeout or completion from irq handler.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/spi/spi-dw-core.c | 62 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index f540165245a89..10d453228368f 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -251,6 +251,34 @@ static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t dw_spi_enh_handler(struct dw_spi *dws)
+{
+	u16 irq_status = dw_readl(dws, DW_SPI_ISR);
+
+	if (dw_spi_check_status(dws, false)) {
+		spi_finalize_current_transfer(dws->master);
+		return IRQ_HANDLED;
+	}
+
+	if (irq_status & DW_SPI_INT_RXFI) {
+		dw_reader(dws);
+		if (dws->rx_len <= dw_readl(dws, DW_SPI_RXFTLR))
+			dw_writel(dws, DW_SPI_RXFTLR, dws->rx_len - 1);
+	}
+
+	if (irq_status & DW_SPI_INT_TXEI)
+		dw_writer(dws);
+
+	if (!dws->tx_len && dws->rx_len) {
+		dw_spi_mask_intr(dws, DW_SPI_INT_TXEI);
+	} else if (!dws->rx_len && !dws->tx_len) {
+		dw_spi_mask_intr(dws, 0xff);
+		spi_finalize_current_transfer(dws->master);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 {
 	struct spi_controller *master = dev_id;
@@ -265,6 +293,12 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 		dw_spi_mask_intr(dws, 0xff);
 		return IRQ_HANDLED;
 	}
+	if ((dws->transfer_handler == dw_spi_enh_handler &&
+	     !dws->rx_len && !dws->tx_len)) {
+		dw_spi_mask_intr(dws, 0xff);
+		spi_finalize_current_transfer(master);
+		return IRQ_HANDLED;
+	}
 
 	return dws->transfer_handler(dws);
 }
@@ -862,6 +896,8 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
 	struct spi_controller *ctlr = mem->spi->controller;
 	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
 	struct dw_spi_cfg cfg;
+	int ret = 0;
+	unsigned long long ms;
 
 	switch (op->data.buswidth) {
 	case 2:
@@ -909,11 +945,35 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
 
 	dw_spi_update_config(dws, mem->spi, &cfg);
 
+	dw_spi_mask_intr(dws, 0xff);
+	reinit_completion(&ctlr->xfer_completion);
 	dw_spi_enable_chip(dws, 1);
 
 	dw_spi_enh_write_cmd_addr(dws, op);
+	dw_spi_set_cs(mem->spi, false);
+	dw_spi_irq_setup(dws, dw_spi_enh_handler);
 
-	return 0;
+	/* Use timeout calculation from spi_transfer_wait() */
+	ms = 8LL * MSEC_PER_SEC * (dws->rx_len ? dws->rx_len : dws->tx_len);
+	do_div(ms, dws->current_freq);
+
+	/*
+	 * Increase it twice and add 200 ms tolerance, use
+	 * predefined maximum in case of overflow.
+	 */
+	ms += ms + 200;
+	if (ms > UINT_MAX)
+		ms = UINT_MAX;
+
+	ms = wait_for_completion_timeout(&ctlr->xfer_completion,
+					 msecs_to_jiffies(ms));
+
+	dw_spi_stop_mem_op(dws, mem->spi);
+
+	if (ms == 0)
+		ret = -EIO;
+
+	return ret;
 }
 
 /*
-- 
2.30.2

