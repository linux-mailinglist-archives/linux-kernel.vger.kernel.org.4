Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4610F63AE11
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiK1Qo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiK1QoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:44:19 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27C41B1CC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:44:14 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id h24so7039867qta.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XXSSzXQqwpqTp8kvMCywn3wDULboBrcJlaRyokBQ21k=;
        b=fejHIyNfaphEgkYKnCMhaL2S9tzT4NlOpJKoyQ/v4qpJLWqHeLSj8Q/Bt8hkvQgiNW
         kf190UpnS4b3+SMrlzWDpyElTt4EXZp6IxFfn6XkfhiwmSmG3dzw0+kBSjHu6elG+sBH
         76tF+npGB5JvlV3CaGWJ+G39ZWHYT+hbM37sQOLlOzLG5Uxtt87VXn+BS9DH3YYNPH0P
         yCzDWDNfhT6rLYKJVvz8pc1exJUAbkb0fmDJO8CDCXipAI+F8UtVaA//tWLZw+FAY62w
         wsVbyuA4jzpTNb2zMM6z0KtyvzP/DPYa0lmYAzF3y+okU7yq3liWGN9ajF3L8AUB8EqB
         WoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XXSSzXQqwpqTp8kvMCywn3wDULboBrcJlaRyokBQ21k=;
        b=z65M21gtWtlVeZNvO/Y1qZEUb+Lwi6d0MpjsQ01UPrQ6Gd1TGp3iT4MJgPzQL6otj7
         62sJt5HJ13Z+8Q1Gunc+cJLKt+h/EXU0GsaZTn+EIPRTt1lxX6ddrxrico1t1WFNGKJK
         meRXKyUwvVFbxyiwLfqJw5fgKgpnnV6MqwXr5B8xLafz7xm2MaV8oUUmgzoOBSElrfwd
         1KBKrTb8WUwCvTTxOkJ+Wv/qkp8aII2V8P0KPj1wc3HM9g/WDSmpNw7X1KP5GhTQu2lO
         2v8iCF06oluFomSOJ5fYVSOfZNFYLw8VNnvnJExkUSWLvqxrz3/ate0yKG5c3qp+vuKu
         2Kyw==
X-Gm-Message-State: ANoB5plrRT8ctk/wyzlvlqvrHWdyqiBKKRy4d1nilKlGBma/NSWvFT8P
        gtW9u9owGmeSsuhkS2WV/DPsfw==
X-Google-Smtp-Source: AA0mqf7AtxhiM423WOE+xFxDY3JxLwBVPHLaeViLYBR9XRHLigeZ8k+EOCSYlJRNcx4+zIoCpf6HbA==
X-Received: by 2002:ac8:604e:0:b0:3a2:9fcd:59c8 with SMTP id k14-20020ac8604e000000b003a29fcd59c8mr34598175qtm.273.1669653853577;
        Mon, 28 Nov 2022 08:44:13 -0800 (PST)
Received: from nathan-ideapad.. (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id bn31-20020a05620a2adf00b006b95b0a714esm8724614qkb.17.2022.11.28.08.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 08:44:13 -0800 (PST)
From:   Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     nathan.morrison@timesys.com, greg.malysa@timesys.com,
        Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] spi: cadence-quadspi: Add minimum operable clock rate warning to baudrate divisor calculation
Date:   Mon, 28 Nov 2022 11:41:47 -0500
Message-Id: <20221128164147.158441-1-nathan.morrison@timesys.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Cadence QSPI IP has a 4-bit clock divisor field
for baud rate division.  For example:

0b0000 = /2
0b0001 = /4
0b0010 = /6
...
0b1111 = /32

The maximum divisor is 32
(when div = CQSPI_REG_CONFIG_BAUD_MASK).

If we assume a reference clock of 500MHz and we set
our spi-max-frequency to something low, such as 10 MHz.
The calculated bit field for the divisor ends up being:

DIV_ROUND_UP(500000000/(2*10000000))-1 = 25

25 is 0b11001... which truncates to a divisor field of 0b1001 (or /20).

This is higher than our anticipated max-frequency of 10MHz
(500MHz/20 = 25 MHz).  Instead, let's make sure we're always using
the maximum divisor (/32) in this case and give the user a warning about
the rate adjustment.

Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
---
 drivers/spi/spi-cadence-quadspi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 447230547945..21b60b354404 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1119,6 +1119,14 @@ static void cqspi_config_baudrate_div(struct cqspi_st *cqspi)
 	/* Recalculate the baudrate divisor based on QSPI specification. */
 	div = DIV_ROUND_UP(ref_clk_hz, 2 * cqspi->sclk) - 1;
 
+	/* Maximum baud divisor */
+	if (div > CQSPI_REG_CONFIG_BAUD_MASK) {
+		div = CQSPI_REG_CONFIG_BAUD_MASK;
+		dev_warn(&cqspi->pdev->dev,
+			"Unable to adjust clock <= %d hz. Reduced to %d hz\n",
+			cqspi->sclk, ref_clk_hz/((div+1)*2));
+	}
+
 	reg = readl(reg_base + CQSPI_REG_CONFIG);
 	reg &= ~(CQSPI_REG_CONFIG_BAUD_MASK << CQSPI_REG_CONFIG_BAUD_LSB);
 	reg |= (div & CQSPI_REG_CONFIG_BAUD_MASK) << CQSPI_REG_CONFIG_BAUD_LSB;
-- 
2.30.2

