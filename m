Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067406A964D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjCCLbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjCCLbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:31:14 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036581ADC6;
        Fri,  3 Mar 2023 03:30:50 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id bd34so1340490pfb.3;
        Fri, 03 Mar 2023 03:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677843049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSCivjwbmYS+neUeDiXxBgpSlm4RJRFlrCt0pfe+AdU=;
        b=U5UhUYlK2I8OR0BrZ4eX6AJm/2uAUkqhKcSpMMZr3Qj2n9jMfOEzPRYPBuL0pDjmnm
         ZbDrddLGGfUZQ+O57d/5Iygpy6wjRIXHXyVakkvfEAuPx2aICgy/an62WgAD1L6DLYMi
         7bL+SGBoox5h/h/wrDtXIzoueROa5NQI/DSqiBlDRRaizudxEA3z9w6ZKRM91DtDWV0Q
         Sa9gXC2062Udvd7WrcFzmcTRAGZmEfArn+F3m3AsTHMb3XEsV3811U+dhh40jkOmdQ0J
         owGSNElLQhQVFPbaYJT7HbSYmv2zpZVA8sMG7WPVUntFFCOA3Rn+PLcEzA4SUMIOjvJG
         dheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677843049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSCivjwbmYS+neUeDiXxBgpSlm4RJRFlrCt0pfe+AdU=;
        b=usFZmmxDM5JxDhzLJktEBt2osLts8IIi/9wfopxKeec89yWL8qcNVSNzei1256ghKP
         64iM1ti0X4v67tUOHIDClpeUKEQSK7Ph4NyKkbPCcPPvaTNrkfYc3xnEImLj+so827TQ
         729RWUOKz2LqO3R5+blzWTN0ttRGJ4Tf87/Ipyo4bti2glAtxKpkq2e0TeRGprCB44FF
         xk0ndnsElvR38i7nTsMHp+ZvZs5xQn4w+jxyeGNVXkIA9Eg99baJXsEBchKmtkGjaBAM
         n0l5SJptP24+0DyX03lEbw+D/tB3mBe/J1DFbhFHpxsvyzZzkDxrgIsK7PnH94/YPyBR
         kiqA==
X-Gm-Message-State: AO0yUKWF4GOP7OJ9xPvk8W58CRf5VCjkBgQZlkpjkVfXtA4WOuii8Y4m
        iVlql+TCwH1aoqix8tXFlOs=
X-Google-Smtp-Source: AK7set9S34ezebk+Uze27z3eR5BJ7YXUl6MMtA/P3FQvfeQnpCBdiLVhgFEOdA5Lyl5Uv8xHUvGkrA==
X-Received: by 2002:a05:6a00:cd:b0:5a8:cbcc:4b58 with SMTP id e13-20020a056a0000cd00b005a8cbcc4b58mr1886378pfj.12.1677843049282;
        Fri, 03 Mar 2023 03:30:49 -0800 (PST)
Received: from localhost.localdomain (124-148-239-17.tpgi.com.au. [124.148.239.17])
        by smtp.gmail.com with ESMTPSA id n4-20020a62e504000000b005a8c92f7c27sm1356262pff.212.2023.03.03.03.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 03:30:49 -0800 (PST)
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Seth Forshee <sforshee@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: [PATCH v4 2/4] apple-gmux: refactor gmux types
Date:   Fri,  3 Mar 2023 22:28:41 +1100
Message-Id: <20230303112842.3094-3-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303112842.3094-1-orlandoch.dev@gmail.com>
References: <20230303112842.3094-1-orlandoch.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add apple_gmux_config struct containing operations and data specific to
each mux type.

This is in preparation for adding a third, MMIO based, gmux type.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
v3->v4: Collect Hans' review
 drivers/platform/x86/apple-gmux.c | 93 ++++++++++++++++++++-----------
 include/linux/apple-gmux.h        | 18 ++++--
 2 files changed, 74 insertions(+), 37 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index ec99e05e532c..36208e93d745 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -5,6 +5,7 @@
  *  Copyright (C) Canonical Ltd. <seth.forshee@canonical.com>
  *  Copyright (C) 2010-2012 Andreas Heider <andreas@meetr.de>
  *  Copyright (C) 2015 Lukas Wunner <lukas@wunner.de>
+ *  Copyright (C) 2023 Orlando Chamberlain <orlandoch.dev@gmail.com>
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -43,10 +44,12 @@
  *     http://www.renesas.com/products/mpumcu/h8s/h8s2100/h8s2113/index.jsp
  */
 
+struct apple_gmux_config;
+
 struct apple_gmux_data {
 	unsigned long iostart;
 	unsigned long iolen;
-	bool indexed;
+	const struct apple_gmux_config *config;
 	struct mutex index_lock;
 
 	struct backlight_device *bdev;
@@ -64,6 +67,18 @@ struct apple_gmux_data {
 
 static struct apple_gmux_data *apple_gmux_data;
 
+struct apple_gmux_config {
+	u8 (*read8)(struct apple_gmux_data *gmux_data, int port);
+	void (*write8)(struct apple_gmux_data *gmux_data, int port, u8 val);
+	u32 (*read32)(struct apple_gmux_data *gmux_data, int port);
+	void (*write32)(struct apple_gmux_data *gmux_data, int port, u32 val);
+	const struct vga_switcheroo_handler *gmux_handler;
+	enum vga_switcheroo_handler_flags_t handler_flags;
+	unsigned long resource_type;
+	bool read_version_as_u32;
+	char *name;
+};
+
 #define GMUX_INTERRUPT_ENABLE		0xff
 #define GMUX_INTERRUPT_DISABLE		0x00
 
@@ -195,35 +210,23 @@ static void gmux_index_write32(struct apple_gmux_data *gmux_data, int port,
 
 static u8 gmux_read8(struct apple_gmux_data *gmux_data, int port)
 {
-	if (gmux_data->indexed)
-		return gmux_index_read8(gmux_data, port);
-	else
-		return gmux_pio_read8(gmux_data, port);
+	return gmux_data->config->read8(gmux_data, port);
 }
 
 static void gmux_write8(struct apple_gmux_data *gmux_data, int port, u8 val)
 {
-	if (gmux_data->indexed)
-		gmux_index_write8(gmux_data, port, val);
-	else
-		gmux_pio_write8(gmux_data, port, val);
+	return gmux_data->config->write8(gmux_data, port, val);
 }
 
 static u32 gmux_read32(struct apple_gmux_data *gmux_data, int port)
 {
-	if (gmux_data->indexed)
-		return gmux_index_read32(gmux_data, port);
-	else
-		return gmux_pio_read32(gmux_data, port);
+	return gmux_data->config->read32(gmux_data, port);
 }
 
 static void gmux_write32(struct apple_gmux_data *gmux_data, int port,
 			     u32 val)
 {
-	if (gmux_data->indexed)
-		gmux_index_write32(gmux_data, port, val);
-	else
-		gmux_pio_write32(gmux_data, port, val);
+	return gmux_data->config->write32(gmux_data, port, val);
 }
 
 /**
@@ -463,19 +466,43 @@ static enum vga_switcheroo_client_id gmux_get_client_id(struct pci_dev *pdev)
 		return VGA_SWITCHEROO_DIS;
 }
 
-static const struct vga_switcheroo_handler gmux_handler_indexed = {
+static const struct vga_switcheroo_handler gmux_handler_no_ddc = {
 	.switchto = gmux_switchto,
 	.power_state = gmux_set_power_state,
 	.get_client_id = gmux_get_client_id,
 };
 
-static const struct vga_switcheroo_handler gmux_handler_classic = {
+static const struct vga_switcheroo_handler gmux_handler_ddc = {
 	.switchto = gmux_switchto,
 	.switch_ddc = gmux_switch_ddc,
 	.power_state = gmux_set_power_state,
 	.get_client_id = gmux_get_client_id,
 };
 
+static const struct apple_gmux_config apple_gmux_pio = {
+	.read8 = &gmux_pio_read8,
+	.write8 = &gmux_pio_write8,
+	.read32 = &gmux_pio_read32,
+	.write32 = &gmux_pio_write32,
+	.gmux_handler = &gmux_handler_ddc,
+	.handler_flags = VGA_SWITCHEROO_CAN_SWITCH_DDC,
+	.resource_type = IORESOURCE_IO,
+	.read_version_as_u32 = false,
+	.name = "classic"
+};
+
+static const struct apple_gmux_config apple_gmux_index = {
+	.read8 = &gmux_index_read8,
+	.write8 = &gmux_index_write8,
+	.read32 = &gmux_index_read32,
+	.write32 = &gmux_index_write32,
+	.gmux_handler = &gmux_handler_no_ddc,
+	.handler_flags = VGA_SWITCHEROO_NEEDS_EDP_CONFIG,
+	.resource_type = IORESOURCE_IO,
+	.read_version_as_u32 = true,
+	.name = "indexed"
+};
+
 /**
  * DOC: Interrupt
  *
@@ -565,13 +592,13 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	int ret = -ENXIO;
 	acpi_status status;
 	unsigned long long gpe;
-	bool indexed = false;
+	enum apple_gmux_type type;
 	u32 version;
 
 	if (apple_gmux_data)
 		return -EBUSY;
 
-	if (!apple_gmux_detect(pnp, &indexed)) {
+	if (!apple_gmux_detect(pnp, &type)) {
 		pr_info("gmux device not present\n");
 		return -ENODEV;
 	}
@@ -581,6 +608,16 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 		return -ENOMEM;
 	pnp_set_drvdata(pnp, gmux_data);
 
+	switch (type) {
+	case APPLE_GMUX_TYPE_INDEXED:
+		gmux_data->config = &apple_gmux_index;
+		mutex_init(&gmux_data->index_lock);
+		break;
+	case APPLE_GMUX_TYPE_PIO:
+		gmux_data->config = &apple_gmux_pio;
+		break;
+	}
+
 	res = pnp_get_resource(pnp, IORESOURCE_IO, 0);
 	gmux_data->iostart = res->start;
 	gmux_data->iolen = resource_size(res);
@@ -591,9 +628,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 		goto err_free;
 	}
 
-	if (indexed) {
-		mutex_init(&gmux_data->index_lock);
-		gmux_data->indexed = true;
+	if (gmux_data->config->read_version_as_u32) {
 		version = gmux_read32(gmux_data, GMUX_PORT_VERSION_MAJOR);
 		ver_major = (version >> 24) & 0xff;
 		ver_minor = (version >> 16) & 0xff;
@@ -604,7 +639,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 		ver_release = gmux_read8(gmux_data, GMUX_PORT_VERSION_RELEASE);
 	}
 	pr_info("Found gmux version %d.%d.%d [%s]\n", ver_major, ver_minor,
-		ver_release, (gmux_data->indexed ? "indexed" : "classic"));
+		ver_release, gmux_data->config->name);
 
 	memset(&props, 0, sizeof(props));
 	props.type = BACKLIGHT_PLATFORM;
@@ -694,12 +729,8 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	 *
 	 * Pre-retina MacBook Pros can switch the panel's DDC separately.
 	 */
-	if (gmux_data->indexed)
-		ret = vga_switcheroo_register_handler(&gmux_handler_indexed,
-					      VGA_SWITCHEROO_NEEDS_EDP_CONFIG);
-	else
-		ret = vga_switcheroo_register_handler(&gmux_handler_classic,
-					      VGA_SWITCHEROO_CAN_SWITCH_DDC);
+	ret = vga_switcheroo_register_handler(gmux_data->config->gmux_handler,
+			gmux_data->config->handler_flags);
 	if (ret) {
 		pr_err("Failed to register vga_switcheroo handler\n");
 		goto err_register_handler;
diff --git a/include/linux/apple-gmux.h b/include/linux/apple-gmux.h
index 1f68b49bcd68..147dc1c52e08 100644
--- a/include/linux/apple-gmux.h
+++ b/include/linux/apple-gmux.h
@@ -36,6 +36,11 @@
 
 #define GMUX_MIN_IO_LEN			(GMUX_PORT_BRIGHTNESS + 4)
 
+enum apple_gmux_type {
+	APPLE_GMUX_TYPE_PIO,
+	APPLE_GMUX_TYPE_INDEXED,
+};
+
 #if IS_ENABLED(CONFIG_APPLE_GMUX)
 static inline bool apple_gmux_is_indexed(unsigned long iostart)
 {
@@ -65,13 +70,13 @@ static inline bool apple_gmux_is_indexed(unsigned long iostart)
  * Return: %true if a supported gmux ACPI device is detected and the kernel
  * was configured with CONFIG_APPLE_GMUX, %false otherwise.
  */
-static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, bool *indexed_ret)
+static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, enum apple_gmux_type *type_ret)
 {
 	u8 ver_major, ver_minor, ver_release;
 	struct device *dev = NULL;
 	struct acpi_device *adev;
 	struct resource *res;
-	bool indexed = false;
+	enum apple_gmux_type type = APPLE_GMUX_TYPE_PIO;
 	bool ret = false;
 
 	if (!pnp_dev) {
@@ -99,13 +104,14 @@ static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, bool *indexed_ret)
 	ver_minor = inb(res->start + GMUX_PORT_VERSION_MINOR);
 	ver_release = inb(res->start + GMUX_PORT_VERSION_RELEASE);
 	if (ver_major == 0xff && ver_minor == 0xff && ver_release == 0xff) {
-		indexed = apple_gmux_is_indexed(res->start);
-		if (!indexed)
+		if (apple_gmux_is_indexed(res->start))
+			type = APPLE_GMUX_TYPE_INDEXED;
+		else
 			goto out;
 	}
 
-	if (indexed_ret)
-		*indexed_ret = indexed;
+	if (type_ret)
+		*type_ret = type;
 
 	ret = true;
 out:
-- 
2.39.2

