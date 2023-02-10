Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F866917BD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 05:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjBJEvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 23:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjBJEur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 23:50:47 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C147717D;
        Thu,  9 Feb 2023 20:50:38 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id s8so2950412pgg.11;
        Thu, 09 Feb 2023 20:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llCbPbOzgkB9LqnEKDg0eJRQRzqzHegvsI/7ZgnBi0I=;
        b=DakxaCeFrVUDK+fBPzwW0q50lGy8dfpodfy+gMycCeoLm0uDmeXFnQXXDZyLi7del7
         JaaUcKkYa2ZMk6NKk7ql73vYJwD80tNBKd8BX9MS8jQSeiI2oGavDPYPWA6joip4Hx6U
         TLbJ+Kk1/3UIiTtq+g00TLDRCrzTYNbB+gaBeh3Mt5sKSY007swlm4nV852KMa/uGthP
         xLqZRWkgrgHg9wl5MbP3LDrV9cVcfLruRDM0bWbAYXXU4XhiGEZQ/DtWVnKsLeYZpIO4
         rvMDC+rIIjsQt/LUdFi99/aFasESB8qmzDqCEijNL41XCe/zLP+GtXIzbmudLQkyprqV
         o/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llCbPbOzgkB9LqnEKDg0eJRQRzqzHegvsI/7ZgnBi0I=;
        b=5xZCAEA7yDfHXUV3JpZduAkAfYXwmsEALg0IsXY+T3dzjx8E3/VTfcZzNJH3mocero
         aoQOGTGIEcIpNIsUDHO+If2DGwoC0i4X2vfn0QgWt/COS/0ewKP0Aq3hRBUC5DhnwMp5
         zsRhdc4XONtW+bn7v1WLyZF4KiPhAM1dljwRWdFsG93W5NXUtJ7z5SJ0lgt92qtltPxN
         GqfuSp+4oJuyxDgVALix4aVFAkTClPt4fQIBgW4nOzgPg1NT7WP/Pk1vDTk7NvmiKNQ3
         LGoUfk2s+um4I82IVQMbpUp10mVsOHj6iGtmeqT9E5FgB0EwzKdSAyasGT1ll68OUa6x
         Mzdw==
X-Gm-Message-State: AO0yUKXCV0QuDodAG5YgJaVB/OI5lddmEBlXUKQghJDYHbH9DDX0cJ6P
        O4J3XgnNPYaG7GiQ/8GzlQQqH6zgr/DzIQ==
X-Google-Smtp-Source: AK7set/SdNDaxY8RGkXC46WnRWnT+ejz/fvUgvitcGPaMPnjzk2pPPFhGYTCadje/Vq75fDjEdq/AQ==
X-Received: by 2002:aa7:991a:0:b0:5a8:4de2:e95e with SMTP id z26-20020aa7991a000000b005a84de2e95emr5148288pff.18.1676004637995;
        Thu, 09 Feb 2023 20:50:37 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id t13-20020a62ea0d000000b0057fec210d33sm2269218pfh.152.2023.02.09.20.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 20:50:37 -0800 (PST)
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>, Evan Quan <evan.quan@amd.com>,
        Kerem Karabay <kekrby@gmail.com>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: [RFC PATCH 4/9] apple-gmux: refactor gmux types
Date:   Fri, 10 Feb 2023 15:48:21 +1100
Message-Id: <20230210044826.9834-5-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210044826.9834-1-orlandoch.dev@gmail.com>
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
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

Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 91 ++++++++++++++++++++-----------
 include/linux/apple-gmux.h        | 18 ++++--
 2 files changed, 70 insertions(+), 39 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 6109f4c2867c..760434a527c1 100644
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
@@ -64,6 +67,17 @@ struct apple_gmux_data {
 
 static struct apple_gmux_data *apple_gmux_data;
 
+struct apple_gmux_config {
+	u8 (*read8)(struct apple_gmux_data *gmux_data, int port);
+	void (*write8)(struct apple_gmux_data *gmux_data, int port, u8 val);
+	u32 (*read32)(struct apple_gmux_data *gmux_data, int port);
+	void (*write32)(struct apple_gmux_data *gmux_data, int port, u32 val);
+	const struct vga_switcheroo_handler *gmux_handler;
+	enum vga_switcheroo_handler_flags_t handler_flags;
+	unsigned long resource_type;
+	char *name;
+};
+
 #define GMUX_INTERRUPT_ENABLE		0xff
 #define GMUX_INTERRUPT_DISABLE		0x00
 
@@ -181,35 +195,23 @@ static void gmux_index_write32(struct apple_gmux_data *gmux_data, int port,
 
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
@@ -449,19 +451,41 @@ static enum vga_switcheroo_client_id gmux_get_client_id(struct pci_dev *pdev)
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
+	.name = "indexed"
+};
+
 /**
  * DOC: Interrupt
  *
@@ -551,13 +575,13 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
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
@@ -567,6 +591,16 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
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
@@ -577,18 +611,13 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 		goto err_free;
 	}
 
-	if (indexed) {
-		mutex_init(&gmux_data->index_lock);
-		gmux_data->indexed = true;
-	}
-
 	version = gmux_read32(gmux_data, GMUX_PORT_VERSION_MAJOR);
 	ver_major = (version >> 24) & 0xff;
 	ver_minor = (version >> 16) & 0xff;
 	ver_release = (version >> 8) & 0xff;
 
 	pr_info("Found gmux version %d.%d.%d [%s]\n", ver_major, ver_minor,
-		ver_release, (gmux_data->indexed ? "indexed" : "classic"));
+			ver_release, gmux_data->config->name);
 
 	memset(&props, 0, sizeof(props));
 	props.type = BACKLIGHT_PLATFORM;
@@ -678,12 +707,8 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
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
index eb2caee04abd..25c1de4a716e 100644
--- a/include/linux/apple-gmux.h
+++ b/include/linux/apple-gmux.h
@@ -36,6 +36,11 @@
 
 #define GMUX_MIN_IO_LEN			(GMUX_PORT_BRIGHTNESS + 4)
 
+enum apple_gmux_type {
+	APPLE_GMUX_TYPE_PIO,
+	APPLE_GMUX_TYPE_INDEXED
+};
+
 #if IS_ENABLED(CONFIG_APPLE_GMUX)
 static inline bool apple_gmux_is_indexed(unsigned long iostart)
 {
@@ -65,12 +70,12 @@ static inline bool apple_gmux_is_indexed(unsigned long iostart)
  * Return: %true if a supported gmux ACPI device is detected and the kernel
  * was configured with CONFIG_APPLE_GMUX, %false otherwise.
  */
-static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, bool *indexed_ret)
+static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, enum apple_gmux_type *type_ret)
 {
 	struct device *dev = NULL;
 	struct acpi_device *adev;
 	struct resource *res;
-	bool indexed = false;
+	enum apple_gmux_type type = APPLE_GMUX_TYPE_PIO;
 	bool ret = false;
 
 	if (!pnp_dev) {
@@ -95,13 +100,14 @@ static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, bool *indexed_ret)
 	 * device isn't present or that it's a new one that uses indexed io.
 	 */
 	if (!(~inl(res->start + GMUX_PORT_VERSION_MAJOR))) {
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
2.39.1

