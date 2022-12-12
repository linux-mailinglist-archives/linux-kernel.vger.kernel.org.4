Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF8564A68E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbiLLSI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbiLLSIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:08:13 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057A038AD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:07:45 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso199157wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xbJ67M7jKeuB1IJ5u3bcr0Za5IuyIS26G5fd5X0pUA=;
        b=fa/TInl4rJ2lDHUu5pDHgcAEOUC2/WYrg9+qcebp/lkZ8OeOls//4/jDHGVQjpKfpw
         TKtJY556TrXdt+grSc2oM5LoQj6rw7NMQyzgMH6NkJ/YdMn5RMzkCe3spTsJmW9tQOyH
         dnd8Ib5JaCvll3f8S7aIq+o3n7wvZdSEskaq0F7alC5SxLWzKI7/+0s0IPX8UW1dwaEM
         ajAU2Gmyn4XQ94AgicH9gDUpzt8BR9CoLURbRry74KWXsFZtQ41FyHNfQ8tu9B7BBsjU
         cxPQU6w3qsd7m6BhxWshl+2a1LZB1otDmO1qM/8N6U8m7dIaV9ap8NJBfBhGCgGa3XDh
         jzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xbJ67M7jKeuB1IJ5u3bcr0Za5IuyIS26G5fd5X0pUA=;
        b=Rf+se2q5WjJ/A7WSuKAhEgTE2uZBTqtUX/p8ZfGpm2COKQrHg7JT8BDOQK91gn8XJ7
         O064wQqzs21KcRWAa7RHErOT3XVVFz6hT/JXNiqh7CGDVvfk5j2450VQZRHa9zBO18qN
         zUHS0b7XKSPnc5YTwOXWzMfhXqfVTbp7TH8WKDe7UXT85RYtw/09p39iYDqNFTayXXIW
         vzzutlf0Lb3l+XdtwB2eX0tBI7A7l9TcL6tMvgi/d81b+cGLMb17zqKxrlUVTmPFejYh
         SM9JmbjD9CpxZ3OoSYIV6tv78OlD00SEVIoiJr3COsDIwkoZMnBEhPG3lCEq4qCcCypo
         aA7A==
X-Gm-Message-State: ANoB5pnwrmj+6I2mkwcHa8beorQY/C4R9s2WNj3KT5PvS428ObAyoNk5
        Y2IiUntXhcZ2Vcyw1fxIrbQAcg==
X-Google-Smtp-Source: AA0mqf6Bytvk/F6U22VWQx4z6V2kb2UXjONKxGpmi3o1oRmp2cGf8KUnDe8XAi0fsPVsM+XJjpHNlg==
X-Received: by 2002:a05:600c:2215:b0:3cf:6d5b:875e with SMTP id z21-20020a05600c221500b003cf6d5b875emr13385139wml.12.1670868464393;
        Mon, 12 Dec 2022 10:07:44 -0800 (PST)
Received: from localhost.localdomain (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id t123-20020a1c4681000000b003a3170a7af9sm10156808wma.4.2022.12.12.10.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:07:44 -0800 (PST)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH v2 03/15] spi: dw: update SPI_CTRLR0 register
Date:   Mon, 12 Dec 2022 18:07:20 +0000
Message-Id: <20221212180732.79167-4-sudip.mukherjee@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
References: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the SPI transfer is being done in enhanced mode then SPI_CTRLR0
register needs to be updated to mention the instruction length, address
length, address and instruction transfer format, wait cycles. And, we
also need to enable clock stretching.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/spi/spi-dw-core.c | 14 +++++++++++++-
 drivers/spi/spi-dw.h      | 11 +++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 8c47a4d14b666..d59401f16c47a 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -320,7 +320,7 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 {
 	struct dw_spi_chip_data *chip = spi_get_ctldata(spi);
 	u32 cr0 = chip->cr0;
-	u32 speed_hz;
+	u32 speed_hz, spi_ctrlr0;
 	u16 clk_div;
 
 	/* CTRLR0[ 4/3: 0] or CTRLR0[ 20: 16] Data Frame Size */
@@ -365,6 +365,18 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 		dw_writel(dws, DW_SPI_RX_SAMPLE_DLY, chip->rx_sample_dly);
 		dws->cur_rx_sample_dly = chip->rx_sample_dly;
 	}
+
+	if (cfg->spi_frf != DW_SPI_CTRLR0_SPI_FRF_STD_SPI) {
+		spi_ctrlr0 = DW_SPI_SPI_CTRLR0_CLK_STRETCH_EN;
+		spi_ctrlr0 |= FIELD_PREP(DW_SPI_SPI_CTRLR0_WAIT_CYCLE_MASK,
+					 cfg->wait_c);
+		spi_ctrlr0 |= FIELD_PREP(DW_SPI_SPI_CTRLR0_INST_L_MASK,
+					 cfg->inst_l);
+		spi_ctrlr0 |= FIELD_PREP(DW_SPI_SPI_CTRLR0_ADDR_L_MASK,
+					 cfg->addr_l);
+		spi_ctrlr0 |= cfg->trans_t;
+		dw_writel(dws, DW_SPI_SPI_CTRLR0, spi_ctrlr0);
+	}
 }
 EXPORT_SYMBOL_NS_GPL(dw_spi_update_config, SPI_DW_CORE);
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 414a415deb42a..f29d89d05f34b 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -63,6 +63,7 @@
 #define DW_SPI_DR			0x60
 #define DW_SPI_RX_SAMPLE_DLY		0xf0
 #define DW_SPI_CS_OVERRIDE		0xf4
+#define DW_SPI_SPI_CTRLR0		0xf4
 
 /* Bit fields in CTRLR0 (DWC APB SSI) */
 #define DW_PSSI_CTRLR0_DFS_MASK			GENMASK(3, 0)
@@ -126,6 +127,12 @@
 #define DW_SPI_DMACR_RDMAE			BIT(0)
 #define DW_SPI_DMACR_TDMAE			BIT(1)
 
+/* Bit fields in SPI_CTRLR0 */
+#define DW_SPI_SPI_CTRLR0_CLK_STRETCH_EN	BIT(30)
+#define DW_SPI_SPI_CTRLR0_WAIT_CYCLE_MASK	GENMASK(15, 11)
+#define DW_SPI_SPI_CTRLR0_INST_L_MASK		GENMASK(9, 8)
+#define DW_SPI_SPI_CTRLR0_ADDR_L_MASK		GENMASK(5, 2)
+
 /* Mem/DMA operations helpers */
 #define DW_SPI_WAIT_RETRIES			5
 #define DW_SPI_BUF_SIZE \
@@ -141,6 +148,10 @@ struct dw_spi_cfg {
 	u32 ndf;
 	u32 freq;
 	u8 spi_frf;
+	u8 trans_t;
+	u8 inst_l;
+	u8 addr_l;
+	u8 wait_c;
 };
 
 struct dw_spi;
-- 
2.30.2

