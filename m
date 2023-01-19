Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC05672FD9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjASEBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjASDo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:44:29 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2424D4C6DE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:41:04 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id y3-20020a17090a390300b00229add7bb36so571950pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HoxgLjiKMEnBReX8y4HZGzgpLE7NIwrXXlAdWPhN3h8=;
        b=vlwDso4zfaafKBLTGZSWLErQYEQ5QY7rcEF1zh4iSwN6iI98SPm4toCnLM60XjMy4U
         FRNIPBJPK7qWyW4yTOoWw97SviB5VdLcf6aUSGuTjQsJMYb8Zbavhp7M/PAS1qeiAP6X
         cXaa/J4BPtXSbGPCBJ8WbxDEphDYH/nAgZbF1jPL3wdCuGQDAlUjiJzEIUHvQmft3ebF
         CgqzDWF742LCFKEkCV8Jzpq3zWCapvPnXt/QUPKBnSeCrBsbUizewQrbR2j1lpp5fHTq
         T89ytguL3doR5oUDohfGweF5HhryX0Na/PWFC6zEwp/TF/WP0RfBI3Nt1RvlZWz8h9kW
         rq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HoxgLjiKMEnBReX8y4HZGzgpLE7NIwrXXlAdWPhN3h8=;
        b=Vr2lGyVF6LvN/AvpeAIOLojGHajMFIEQmK+dq6OD9pxtWdngRBCejpEUR9OrOEC8eO
         HmA3wl0Nnul94zr20s2w5EZvYv4oU5yNqwNCNcas16w5E0cuYv3Ec7v8pI/DqkT4pdBf
         A92GfHuahq8x0BYyDU2L2S9hCo0SuokCqxmVyHBnjTy7kpptQc2fuv+eiwicMNAraVb7
         U5e6Iucy/yd70AtyrGFsp6wwBdzN8Mie9F5/t0LyuffYkRdDj3oNVJttwoSzwA6sSnFb
         aDYlmFR89Zu24GHqmTpP9TjgFBK+IFaopsAdLMmqhaiXXy2PvKrEp1bRe5wNXI1m6xCE
         +MYQ==
X-Gm-Message-State: AFqh2kpn453gFG97kCdQTfma6Xk5rcQvZGHys4R2IoLTxNn9NlXHu6q6
        iRO1WlA/knGrNI4/iEx3MEjK9A==
X-Google-Smtp-Source: AMrXdXv9gtvswiH5b6jgB6AVsqRnU4Ge6BwluWHdlQkKPdo0JB/42cVs6C8gs/HBxJmeeDTgLO9msg==
X-Received: by 2002:a05:6a20:4c9f:b0:b8:694c:201 with SMTP id fq31-20020a056a204c9f00b000b8694c0201mr8961901pzb.11.1674099662453;
        Wed, 18 Jan 2023 19:41:02 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id f13-20020aa7968d000000b0056b4c5dde61sm11097879pfk.98.2023.01.18.19.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 19:41:02 -0800 (PST)
From:   Brad Larson <brad@pensando.io>
X-Google-Original-From: Brad Larson <blarson@amd.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brad@pensando.io, blarson@amd.com, brendan.higgins@linux.dev,
        briannorris@chromium.org, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, davidgow@google.com, gsomlo@gmail.com,
        gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v9 11/15] spi: dw: Add support for AMD Pensando Elba SoC
Date:   Wed, 18 Jan 2023 19:39:14 -0800
Message-Id: <20230119033918.44117-12-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119033918.44117-1-blarson@amd.com>
References: <20230119033918.44117-1-blarson@amd.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD Pensando Elba SoC includes a DW apb_ssi v4 controller
with device specific chip-select control.  The Elba SoC
provides four chip-selects where the native DW IP supports
two chip-selects.  The Elba DW_SPI instance has two native
CS signals that are always overridden.

Signed-off-by: Brad Larson <blarson@amd.com>
---

Changes since v6:
- Add use of macros GENMASK() and BIT()
- Change ELBA_SPICS_SHIFT() to ELBA_SPICS_OFFSET()

---
 drivers/spi/spi-dw-mmio.c | 78 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 26c40ea6dd12..9b6f876227e8 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -53,6 +53,24 @@ struct dw_spi_mscc {
 	void __iomem        *spi_mst; /* Not sparx5 */
 };
 
+struct dw_spi_elba {
+	struct regmap *syscon;
+};
+
+/*
+ * Elba SoC does not use ssi, pin override is used for cs 0,1 and
+ * gpios for cs 2,3 as defined in the device tree.
+ *
+ * cs:  |       1               0
+ * bit: |---3-------2-------1-------0
+ *      |  cs1   cs1_ovr   cs0   cs0_ovr
+ */
+#define ELBA_SPICS_REG			0x2468
+#define ELBA_SPICS_OFFSET(cs)		((cs) << 1)
+#define ELBA_SPICS_MASK(cs)		(GENMASK(1, 0) << ELBA_SPICS_OFFSET(cs))
+#define ELBA_SPICS_SET(cs, val)		\
+		((((val) << 1) | BIT(0)) << ELBA_SPICS_OFFSET(cs))
+
 /*
  * The Designware SPI controller (referred to as master in the documentation)
  * automatically deasserts chip select when the tx fifo is empty. The chip
@@ -237,6 +255,65 @@ static int dw_spi_canaan_k210_init(struct platform_device *pdev,
 	return 0;
 }
 
+static void dw_spi_elba_override_cs(struct dw_spi_elba *dwselba, int cs, int enable)
+{
+	regmap_update_bits(dwselba->syscon, ELBA_SPICS_REG, ELBA_SPICS_MASK(cs),
+			   ELBA_SPICS_SET(cs, enable));
+
+}
+
+static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
+{
+	struct dw_spi *dws = spi_master_get_devdata(spi->master);
+	struct dw_spi_mmio *dwsmmio = container_of(dws, struct dw_spi_mmio, dws);
+	struct dw_spi_elba *dwselba = dwsmmio->priv;
+	u8 cs;
+
+	cs = spi->chip_select;
+	if (cs < 2)
+		dw_spi_elba_override_cs(dwselba, spi->chip_select, enable);
+
+	/*
+	 * The DW SPI controller needs a native CS bit selected to start
+	 * the serial engine.
+	 */
+	spi->chip_select = 0;
+	dw_spi_set_cs(spi, enable);
+	spi->chip_select = cs;
+}
+
+static int dw_spi_elba_init(struct platform_device *pdev,
+			    struct dw_spi_mmio *dwsmmio)
+{
+	const char *syscon_name = "amd,pensando-elba-syscon";
+	struct device_node *np = pdev->dev.of_node;
+	struct dw_spi_elba *dwselba;
+	struct device_node *node;
+	struct regmap *regmap;
+
+	node = of_parse_phandle(np, syscon_name, 0);
+	if (!node) {
+		dev_err(&pdev->dev, "failed to find %s\n", syscon_name);
+		return -ENODEV;
+	}
+
+	regmap = syscon_node_to_regmap(node);
+	if (IS_ERR(regmap)) {
+		dev_err(&pdev->dev, "syscon regmap lookup failed\n");
+		return PTR_ERR(regmap);
+	}
+
+	dwselba = devm_kzalloc(&pdev->dev, sizeof(*dwselba), GFP_KERNEL);
+	if (!dwselba)
+		return -ENOMEM;
+
+	dwselba->syscon = regmap;
+	dwsmmio->priv = dwselba;
+	dwsmmio->dws.set_cs = dw_spi_elba_set_cs;
+
+	return 0;
+}
+
 static int dw_spi_mmio_probe(struct platform_device *pdev)
 {
 	int (*init_func)(struct platform_device *pdev,
@@ -352,6 +429,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "intel,thunderbay-ssi", .data = dw_spi_intel_init},
 	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
 	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
+	{ .compatible = "amd,pensando-elba-spi", .data = dw_spi_elba_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
-- 
2.17.1

