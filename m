Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DCB64A6A7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiLLSJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbiLLSIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:08:22 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D13637A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:07:52 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id ja17so3305571wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQuE2K78uUlvCMGWFDZZHN9GOwoDWtlsbedBiWwRDfg=;
        b=jaHLnsIYEZXfnaU6a2ldMiE275sZuX9Wbq117I2Jw43JPyMxu5yo68Uj7Yy4ycmJYq
         PUU+LkMNy+SF81zAOHaS+BQhLkjgH+f+SfO+9q8ueaaMTUl1GJqJBJ3NhM8qojWlSrp7
         MVoQtDGxSPWSWS30rW5bo4HsLRBgFJySBBdN/m9tNI/rX8f81dhAYmXSAh0rVY9wIwzY
         eil7uJupKi3DZb/is/7NEAJhn3eHqL9jQEutvZ9PBfwjzd2XQlpQTLCJmCgZlvsCwhZ1
         v71KA5thTpBdW0xq+yO5YvO+xAuZR9nkEFA+djLJjQXonSxzmxygnS//vyON6nsl62Vp
         298g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQuE2K78uUlvCMGWFDZZHN9GOwoDWtlsbedBiWwRDfg=;
        b=LfbtDBeW1uL8wU55xrNx4/l7StZYpbwi1mDBJLrCz7k1HHnvQ/UQq173IHKqrukh5l
         Tq19pa5aWzQJt3P1McSoMNySF4C4iW8YQFb0Mp1RyZC/Hk2xvC5qTJkG34vtnJ9ZAyFj
         3Xot3UODdzpZrmM/jC+ZP8hQbnA83Wxn2tJ5x71gjFQFz2t3LhxbhZySAJFstcZMHBnj
         LNBoVRn/MnWLL5v7fCH+q0mp4w+mY/+LaASsq0cmUSNe6eaQ1n3fqHLDckJ/BMdraEL7
         UO6C1ZtcvG88VJIJUhLhS12bxrTyjZH5DDp7KLQf+pCFrCrxTD49xoDyuyndMDZpHAUW
         gpyg==
X-Gm-Message-State: ANoB5pmLPabh5lh+eBOmamLVmYv9o0H1KAV0Btb6VElHvGcQ/F1dhVka
        flabbYmAKBl6+WsZ17LLF/yiAg==
X-Google-Smtp-Source: AA0mqf4YkjQSyvUPzCW5WFKTMeX06dUxr3FM0c1i93DR0EFe1wd0BuRBczuZcAm/hzFgM0p3opDFWg==
X-Received: by 2002:a05:600c:1c90:b0:3d2:274d:be7c with SMTP id k16-20020a05600c1c9000b003d2274dbe7cmr3040697wms.19.1670868470682;
        Mon, 12 Dec 2022 10:07:50 -0800 (PST)
Received: from localhost.localdomain (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id t123-20020a1c4681000000b003a3170a7af9sm10156808wma.4.2022.12.12.10.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:07:50 -0800 (PST)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH v2 10/15] spi: dw: Calculate Receive FIFO Threshold Level
Date:   Mon, 12 Dec 2022 18:07:27 +0000
Message-Id: <20221212180732.79167-11-sudip.mukherjee@sifive.com>
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

In enhanced mode we need to calculate RXFTLR based on the length of data
we are expecting to receive or the fifo length.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/spi/spi-dw-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 10d453228368f..75f5ce5f377ca 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -428,6 +428,14 @@ static void dw_spi_irq_setup(struct dw_spi *dws,
 	 */
 	level = min_t(u16, dws->fifo_len / 2, dws->tx_len);
 	dw_writel(dws, DW_SPI_TXFTLR, level);
+
+	/*
+	 * In enhanced mode if we are reading then tx_len is 0 as we
+	 * have nothing to transmit. Calculate DW_SPI_RXFTLR with
+	 * rx_len.
+	 */
+	if (t_handler == dw_spi_enh_handler)
+		level = min_t(u16, dws->fifo_len / 2, dws->rx_len);
 	dw_writel(dws, DW_SPI_RXFTLR, level - 1);
 
 	dws->transfer_handler = t_handler;
-- 
2.30.2

