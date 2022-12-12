Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0901764A68B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbiLLSIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiLLSIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:08:11 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D415F73
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:07:43 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id h8-20020a1c2108000000b003d1efd60b65so5945659wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/E0yrCX/w68NetnkW1cEsRRs5XY/9DzIPnhuqKIJns=;
        b=OyvO0QzJj1fhziCAWdsYVx/UKbdbBA4bx3cDt9uIGpPMmdedpdt31DOtoeammzLoea
         MJHFt3njOaFOOeUELbZ842aNblDbokMI4RvBNRkbc5qj7w4gep0sp+vzAnVOqBZnQYIu
         1N/LYxrLJXJXhrZNwbAXDmsP+xlnSfu8aZEZwFTKBElspvB0NyPKR4Hx1J1MUKVnqPML
         CeljWIj8fpFup/xt1GaK8CEXQ7e53MUv7wnTbo3eChXfo9LZ7nn8wZ2ciILLn6syxDxt
         wVbjBG5Is6qAE+oVIaJXAxzQPY9eWtWGmNkuivM7/+CLj3ByttgPD8BSV770u4X0IQ+n
         pbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/E0yrCX/w68NetnkW1cEsRRs5XY/9DzIPnhuqKIJns=;
        b=0eVaWqb3pZCiiLZsyjhAs0GCGJ9EzWpt/UdgCcY/gLisrTDX7eL5DHkfsEDiN7ao0N
         REsPJMMpiOy/UyboAaahtCzJ6YPqyISPZyopuFbp9Ahunuk0Mwk4F+Cyays4R2HGjNgm
         WsUxBvvWAQl5WcQ0jJ9DWQcYoyDA+/Z3Enc+N055IQcVKr/iRJvlJBr6JmZbiDM/rpIm
         17Am65CqfcYMnE9XQiPwsPap7hfZrbu9VPTdsCEconW26cHrUZQId70h4ERbK7SvbCBC
         aVN6ysC8iAXCaw87RoQ4iJCKjpl6VbInifG7rHrhGHAL3ggKo4/527biZfu3nqDefP7h
         jhGA==
X-Gm-Message-State: ANoB5pljod5c0aiq/rCLNxhHUQrmnp4l5R+BGynwICbdN+zbrsuZNDKE
        r6VuwEg6FlKCVYYbGw6ONrxtBA==
X-Google-Smtp-Source: AA0mqf71R8FCWfC8x8sqet7rycmRYXZKz3wn9O5O4w6CxCK/2v61XZyRVq4eLvrmv7PTC/CGlUpUqw==
X-Received: by 2002:a05:600c:1e18:b0:3d2:26e1:bd45 with SMTP id ay24-20020a05600c1e1800b003d226e1bd45mr3859314wmb.29.1670868462552;
        Mon, 12 Dec 2022 10:07:42 -0800 (PST)
Received: from localhost.localdomain (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id t123-20020a1c4681000000b003a3170a7af9sm10156808wma.4.2022.12.12.10.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:07:41 -0800 (PST)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH v2 01/15] spi: dw: Introduce spi_frf and STD_SPI
Date:   Mon, 12 Dec 2022 18:07:18 +0000
Message-Id: <20221212180732.79167-2-sudip.mukherjee@sifive.com>
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

The DW APB SSI controllers of v4.x and newer and DW AHB SSI controllers
supports enhanced SPI modes which can be defined from SPI_FRF of
DW_SPI_CTRLR0 register. Without enhanced mode, these controllers will
work in the standard spi mode.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/spi/spi-dw-core.c | 13 ++++++++++++-
 drivers/spi/spi-dw.h      |  6 ++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 99edddf9958b9..77c23772bb3d9 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -333,6 +333,16 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 		/* CTRLR0[11:10] Transfer Mode */
 		cr0 |= FIELD_PREP(DW_HSSI_CTRLR0_TMOD_MASK, cfg->tmode);
 
+	if (dw_spi_ver_is_ge(dws, HSSI, 103A)) {
+		cr0 &= ~DW_HSSI_CTRLR0_SPI_FRF_MASK;
+		cr0 |= FIELD_PREP(DW_HSSI_CTRLR0_SPI_FRF_MASK,
+				  cfg->spi_frf);
+	} else if (dw_spi_ver_is_ge(dws, PSSI, 400A)) {
+		cr0 &= ~DW_PSSI_CTRLR0_SPI_FRF_MASK;
+		cr0 |= FIELD_PREP(DW_PSSI_CTRLR0_SPI_FRF_MASK,
+				  cfg->spi_frf);
+	}
+
 	dw_writel(dws, DW_SPI_CTRLR0, cr0);
 
 	if (cfg->tmode == DW_SPI_CTRLR0_TMOD_EPROMREAD ||
@@ -422,6 +432,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 		.tmode = DW_SPI_CTRLR0_TMOD_TR,
 		.dfs = transfer->bits_per_word,
 		.freq = transfer->speed_hz,
+		.spi_frf = DW_SPI_CTRLR0_SPI_FRF_STD_SPI,
 	};
 	int ret;
 
@@ -664,7 +675,7 @@ static void dw_spi_stop_mem_op(struct dw_spi *dws, struct spi_device *spi)
 static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(mem->spi->controller);
-	struct dw_spi_cfg cfg;
+	struct dw_spi_cfg cfg = {0};
 	unsigned long flags;
 	int ret;
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 9e8eb2b52d5c7..414a415deb42a 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -17,6 +17,8 @@
 
 /* Synopsys DW SSI component versions (FourCC sequence) */
 #define DW_HSSI_102A			0x3130322a
+#define DW_HSSI_103A			0x3130332a
+#define DW_PSSI_400A			0x3430302a
 
 /* DW SSI IP-core ID and version check helpers */
 #define dw_spi_ip_is(_dws, _ip) \
@@ -94,6 +96,9 @@
 #define DW_HSSI_CTRLR0_TMOD_MASK		GENMASK(11, 10)
 #define DW_HSSI_CTRLR0_SRL			BIT(13)
 #define DW_HSSI_CTRLR0_MST			BIT(31)
+#define DW_HSSI_CTRLR0_SPI_FRF_MASK		GENMASK(23, 22)
+#define DW_PSSI_CTRLR0_SPI_FRF_MASK		GENMASK(22, 21)
+#define DW_SPI_CTRLR0_SPI_FRF_STD_SPI		0x0
 
 /* Bit fields in CTRLR1 */
 #define DW_SPI_NDF_MASK				GENMASK(15, 0)
@@ -135,6 +140,7 @@ struct dw_spi_cfg {
 	u8 dfs;
 	u32 ndf;
 	u32 freq;
+	u8 spi_frf;
 };
 
 struct dw_spi;
-- 
2.30.2

