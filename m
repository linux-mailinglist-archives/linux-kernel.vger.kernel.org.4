Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2155E64A6AC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiLLSJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbiLLSIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:08:24 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F8263F0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:07:53 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so5927262wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yV6+oiSdPjciFRPPCXlaaf05DYc0wxneaaODGSgK2uE=;
        b=Y22bKRAfcHnmzs2KZUi6jIstXPxhHBZWZQH5o5L6ddrFcZLMEHUAdwjRJytIKvwvf0
         3juKw7qaULaSH9BmLJJzWklC1rQP1dNXnzyCResSGkYz1io1zyQiBiUZDJCCoC4b4V1e
         BReayyJGtxjvP7ykcbjzzl1x33zjDHl1nfqybysn2Bi8Qfrr4kLnZoTp+8yb++Y28ONd
         MsJ9YW3nKTUTKr8llNSNoR4EhT8sUUhuOAmH+9U8CxFxH8oY/99G6qsORDUUfXtAAVQt
         WT6ZZS8CnZv4V5NHWb3atkwBsW7sbnLR8H3LqZLOOF1NDmSvcDR3tBRUVtDp2xLcGyKh
         FBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yV6+oiSdPjciFRPPCXlaaf05DYc0wxneaaODGSgK2uE=;
        b=pxoaZSGJuwEzeNH23dMRYuy/RSbryvwZ3rWlxamoATHz6HeivSI5/7p+d5Pa7eGI3d
         dIYuSzwW1gycSCMoHonHbXmUXHH1yTMyuoRPQJ0lBFF1LBZvuoEGBvrVvwjYWaM2k+lj
         /LAXOq55ppXzB32MnnlGwZOvyEhuhXg3+8lz61apg9Djw4O1g2XhoNf9iOVmzBX1B86i
         53UDkXTB3BG7wlMVgWw2rYtePf65r8GGZretJHzdWM6ydr4HnLXYTm2dVIpFhj0uvqKh
         +zSlCdRh6GqdL2WXLcQCDC4u/gHHkJ1mgZox6XDCQl71hMs7bjIgpN7cb/OllLwOCHtw
         LDDw==
X-Gm-Message-State: ANoB5pmbSb0HZKXZB5I9UraeMPVT6ElDSSxCmhTsaM4y9JvFthYyWRT8
        NGA+lPPf+4nLnjjlTw4t/Ne6OA==
X-Google-Smtp-Source: AA0mqf63xZP9eTl0bysLtgyG3g0nG0GhxM23IddzbnhHOhlvfVKIYf4FEI66D1D0svRZXgN1mXFdcg==
X-Received: by 2002:a05:600c:3508:b0:3cf:b73f:bf8f with SMTP id h8-20020a05600c350800b003cfb73fbf8fmr13614720wmq.7.1670868473356;
        Mon, 12 Dec 2022 10:07:53 -0800 (PST)
Received: from localhost.localdomain (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id t123-20020a1c4681000000b003a3170a7af9sm10156808wma.4.2022.12.12.10.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:07:53 -0800 (PST)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH v2 13/15] spi: dw: detect enhanced spi mode
Date:   Mon, 12 Dec 2022 18:07:30 +0000
Message-Id: <20221212180732.79167-14-sudip.mukherjee@sifive.com>
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

All the SSI controllers supporting enhanced spi modes might not support
all the three dual or quad or octal modes. Detect the modes that are
supported and finally enable the DW_SPI_CAP_EMODE capability which will
start using all the enhanced spi functions that has been added.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/spi/spi-dw-core.c | 68 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index cef56acd8d8fd..9e806d5878beb 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -1143,6 +1143,69 @@ static void dw_spi_hw_init(struct device *dev, struct dw_spi *dws)
 		dw_writel(dws, DW_SPI_CS_OVERRIDE, 0xF);
 }
 
+static u16 detect_enh_mode(struct dw_spi *dws)
+{
+	u16 mode = 0;
+	u32 tmp_spi_ctrlr0, tmp_ctrlr0, tmpdual, tmpquad, tmpoct;
+
+	if (dw_spi_ver_is_ge(dws, HSSI, 103A)) {
+		tmpdual = FIELD_PREP(DW_HSSI_CTRLR0_SPI_FRF_MASK,
+				     DW_SPI_CTRLR0_SPI_FRF_DUAL_SPI);
+		tmpquad = FIELD_PREP(DW_HSSI_CTRLR0_SPI_FRF_MASK,
+				     DW_SPI_CTRLR0_SPI_FRF_QUAD_SPI);
+		tmpoct = FIELD_PREP(DW_HSSI_CTRLR0_SPI_FRF_MASK,
+				    DW_SPI_CTRLR0_SPI_FRF_OCT_SPI);
+	} else if (dw_spi_ver_is_ge(dws, PSSI, 400A)) {
+		tmpdual = FIELD_PREP(DW_PSSI_CTRLR0_SPI_FRF_MASK,
+				     DW_SPI_CTRLR0_SPI_FRF_DUAL_SPI);
+		tmpquad = FIELD_PREP(DW_PSSI_CTRLR0_SPI_FRF_MASK,
+				     DW_SPI_CTRLR0_SPI_FRF_QUAD_SPI);
+		tmpoct = FIELD_PREP(DW_PSSI_CTRLR0_SPI_FRF_MASK,
+				    DW_SPI_CTRLR0_SPI_FRF_OCT_SPI);
+	} else {
+		return DW_SPI_CTRLR0_SPI_FRF_STD_SPI;
+	}
+
+	tmp_ctrlr0 = dw_readl(dws, DW_SPI_CTRLR0);
+	tmp_spi_ctrlr0 = dw_readl(dws, DW_SPI_SPI_CTRLR0);
+	dw_spi_enable_chip(dws, 0);
+
+	/* test clock stretching */
+	dw_writel(dws, DW_SPI_SPI_CTRLR0, DW_SPI_SPI_CTRLR0_CLK_STRETCH_EN);
+	if ((DW_SPI_SPI_CTRLR0_CLK_STRETCH_EN & dw_readl(dws, DW_SPI_SPI_CTRLR0)) !=
+	    DW_SPI_SPI_CTRLR0_CLK_STRETCH_EN)
+		/*
+		 * If clock stretching is not enabled then do not use
+		 * enhanced mode.
+		 */
+		goto disable_enh;
+
+	/* test dual mode */
+	dw_writel(dws, DW_SPI_CTRLR0, tmpdual);
+	if ((tmpdual & dw_readl(dws, DW_SPI_CTRLR0)) == tmpdual)
+		mode |= SPI_TX_DUAL | SPI_RX_DUAL;
+
+	/* test quad mode */
+	dw_writel(dws, DW_SPI_CTRLR0, tmpquad);
+	if ((tmpquad & dw_readl(dws, DW_SPI_CTRLR0)) == tmpquad)
+		mode |= SPI_TX_QUAD | SPI_RX_QUAD;
+
+	/* test octal mode */
+	dw_writel(dws, DW_SPI_CTRLR0, tmpoct);
+	if ((tmpoct & dw_readl(dws, DW_SPI_CTRLR0)) == tmpoct)
+		mode |= SPI_TX_OCTAL | SPI_RX_OCTAL;
+
+	if (mode)
+		dws->caps |= DW_SPI_CAP_EMODE;
+
+disable_enh:
+	dw_writel(dws, DW_SPI_CTRLR0, tmp_ctrlr0);
+	dw_writel(dws, DW_SPI_SPI_CTRLR0, tmp_spi_ctrlr0);
+	dw_spi_enable_chip(dws, 1);
+
+	return mode;
+}
+
 int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 {
 	struct spi_controller *master;
@@ -1172,10 +1235,11 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 		goto err_free_master;
 	}
 
-	dw_spi_init_mem_ops(dws);
-
 	master->use_gpio_descriptors = true;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
+	master->mode_bits |= detect_enh_mode(dws);
+	dw_spi_init_mem_ops(dws);
+
 	if (dws->caps & DW_SPI_CAP_DFS32)
 		master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	else
-- 
2.30.2

