Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DA06917C1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 05:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjBJEvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 23:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjBJEvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 23:51:21 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C27777161;
        Thu,  9 Feb 2023 20:50:58 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 78so2965228pgb.8;
        Thu, 09 Feb 2023 20:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csEKku7VeftqKMa/oZ1aoU6u0+L74zJO0Dt8b/66dVA=;
        b=bSSBBpxuvLfNjDZVjz2+AmmgvNUi2UbO+qebR9jIEeWWG+ugnaK53p6mQpKFqVYTgh
         iuXQ4Y9y0HhXStihsMX1+bZmICz5JbJdj3Y5RDYwvHd0Fvm4BpohBTo0+84VXZE3pNkJ
         nHj3jMdQ2ECfz5zkBQU+zZ3Ou5aDNBg3gocOMdRkFgPV5bhYgSG4gvzu93r5S6Dh3JOb
         tLAJgLetD5xYT4Q8PSDp7jNYdLB5EoV7IW4Gq2iVdsp9WjCgK5g+crXN5OaIjS/YWKOv
         swXVeyoRy+mQbFKKCf26aGILb+pL93OyQTh9/2z5UaawmtNzWkhbwVdkID9qJ/kh2j6p
         N03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csEKku7VeftqKMa/oZ1aoU6u0+L74zJO0Dt8b/66dVA=;
        b=jb/9TBfRokH3vbPmHj1suLCvfLGwrd6TndvzqXslbcD46VVXSapt7EAzXN63QI2vGN
         0pldOiQhXG2NplVAuieGUXvFV5ZyM+NzIYVTIq3P8vVcs5kqzWRsW4fq0o3bI4pSRZpm
         /gKxVtwe0sQJm+uZHzIQdEtVKBMFePLvwOCcVsrh9aawGHaeNdvkaWFfn/cJALng/kY2
         S8D4G5zf6LHJ/wW+dgoHa4TZJ328Ikgs+i0RUeSBp3LyNaH4ayEHIQnWdk/ER9l3G5t9
         PYFs1atI7UsuSf7xgt4S9WG0esZ2Z5PqVUGnakpM/+mL6L2WCGbcmwLfzcRwAkpC/1u/
         pdYg==
X-Gm-Message-State: AO0yUKVitpbkxIUgbmrnb5ZIfZp/iHH5tw00MQ5WeYJh/29O5Afv+oC6
        TsAa/nAqs5wbB++v2k5fp8E/32FxxiSIPA==
X-Google-Smtp-Source: AK7set+6nR3PdC+bLUM0mRD3ICNqYx6AqEbULf57vUUimaqPU/GNepSkLhGvqGxzIrfzk/FsdYaw+w==
X-Received: by 2002:a62:2782:0:b0:5a8:16b7:ce6e with SMTP id n124-20020a622782000000b005a816b7ce6emr2853223pfn.10.1676004657775;
        Thu, 09 Feb 2023 20:50:57 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id t13-20020a62ea0d000000b0057fec210d33sm2269218pfh.152.2023.02.09.20.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 20:50:57 -0800 (PST)
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
Subject: [RFC PATCH 6/9] apple-gmux: support MMIO gmux on T2 Macs
Date:   Fri, 10 Feb 2023 15:48:23 +1100
Message-Id: <20230210044826.9834-7-orlandoch.dev@gmail.com>
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

In some newer dual gpu MacBooks, gmux is controlled by the T2 security
chip, and acessed with MMIO. Add support for these gmux controllers

Interestingly, the ACPI table only allocates 8 bytes for GMUX, but we
actually need 16, and as such we request 16 with request_mem_region.

Reading and writing from ports:
    16 bytes from 0xfe0b0200 are used. 0x0 to 0x4 are where data
    to read appears, and where data to write goes. Writing to 0xe
    sets the gmux port being accessed, and writing to 0xf sends commands.

    These commands are 0x40 & data_length for write, and data_length for
    read, where data_length is 1, 2 or 4. Once byte base+0xf is 0, the
    command is done.

Interrupts:
    Clearing interrupts on T2 macs seems different to older models,
    0 has to be written for them to stop, but this isn't what macOS
    does and further investigation may be needed.

Issues:
    As with other retina models, we can't switch DDC lines so
    switching at runtime doesn't work if the inactive gpu driver
    already disabled eDP due to it not being connected when that
    driver loaded.

    Additionally, turning on the dgpu back on T2 macs doesn't work,
    and it fails in amdgpu's code for bringing the gpu back online.

Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 134 ++++++++++++++++++++++++++++--
 include/linux/apple-gmux.h        |  34 +++++---
 2 files changed, 149 insertions(+), 19 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index c605f036ea0b..c38d6ef0c15a 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -28,15 +28,17 @@
  * DOC: Overview
  *
  * gmux is a microcontroller built into the MacBook Pro to support dual GPUs:
- * A `Lattice XP2`_ on pre-retinas, a `Renesas R4F2113`_ on retinas.
+ * A `Lattice XP2`_ on pre-retinas, a `Renesas R4F2113`_ on pre-T2 retinas.
+ * The chip used on T2 Macs is not known.
  *
  * (The MacPro6,1 2013 also has a gmux, however it is unclear why since it has
  * dual GPUs but no built-in display.)
  *
  * gmux is connected to the LPC bus of the southbridge. Its I/O ports are
  * accessed differently depending on the microcontroller: Driver functions
- * to access a pre-retina gmux are infixed ``_pio_``, those for a retina gmux
- * are infixed ``_index_``.
+ * to access a pre-retina gmux are infixed ``_pio_``, those for a pre-T2
+ * retina gmux are infixed ``_index_``, and those on T2 Macs are infixed
+ * with ``_mmio_``.
  *
  * .. _Lattice XP2:
  *     http://www.latticesemi.com/en/Products/FPGAandCPLD/LatticeXP2.aspx
@@ -47,6 +49,7 @@
 struct apple_gmux_config;
 
 struct apple_gmux_data {
+	u8 *__iomem iomem_base;
 	unsigned long iostart;
 	unsigned long iolen;
 	const struct apple_gmux_config *config;
@@ -193,6 +196,79 @@ static void gmux_index_write32(struct apple_gmux_data *gmux_data, int port,
 	mutex_unlock(&gmux_data->index_lock);
 }
 
+static int gmux_mmio_wait(struct apple_gmux_data *gmux_data)
+{
+	int i = 200;
+	u8 gwr = ioread8(gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
+
+	while (i && gwr) {
+		gwr = ioread8(gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
+		udelay(100);
+		i--;
+	}
+
+	return !!i;
+}
+
+static u8 gmux_mmio_read8(struct apple_gmux_data *gmux_data, int port)
+{
+	u8 val;
+
+	mutex_lock(&gmux_data->index_lock);
+	gmux_mmio_wait(gmux_data);
+	iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
+	iowrite8(GMUX_MMIO_READ | sizeof(val),
+		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
+	gmux_mmio_wait(gmux_data);
+	val = ioread8(gmux_data->iomem_base);
+	mutex_unlock(&gmux_data->index_lock);
+
+	return val;
+}
+
+static void gmux_mmio_write8(struct apple_gmux_data *gmux_data, int port,
+			      u8 val)
+{
+	mutex_lock(&gmux_data->index_lock);
+	gmux_mmio_wait(gmux_data);
+	iowrite8(val, gmux_data->iomem_base);
+
+	iowrite8(port & 0xff, gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
+	iowrite8(GMUX_MMIO_WRITE | sizeof(val),
+		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
+
+	gmux_mmio_wait(gmux_data);
+	mutex_unlock(&gmux_data->index_lock);
+}
+
+static u32 gmux_mmio_read32(struct apple_gmux_data *gmux_data, int port)
+{
+	u32 val;
+
+	mutex_lock(&gmux_data->index_lock);
+	gmux_mmio_wait(gmux_data);
+	iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
+	iowrite8(GMUX_MMIO_READ | sizeof(val),
+		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
+	gmux_mmio_wait(gmux_data);
+	val = be32_to_cpu(ioread32(gmux_data->iomem_base));
+	mutex_unlock(&gmux_data->index_lock);
+
+	return val;
+}
+
+static void gmux_mmio_write32(struct apple_gmux_data *gmux_data, int port,
+			       u32 val)
+{
+	mutex_lock(&gmux_data->index_lock);
+	iowrite32(cpu_to_be32(val), gmux_data->iomem_base);
+	iowrite8(port & 0xff, gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
+	iowrite8(GMUX_MMIO_WRITE | sizeof(val),
+		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
+	gmux_mmio_wait(gmux_data);
+	mutex_unlock(&gmux_data->index_lock);
+}
+
 static u8 gmux_read8(struct apple_gmux_data *gmux_data, int port)
 {
 	return gmux_data->config->read8(gmux_data, port);
@@ -486,6 +562,18 @@ static const struct apple_gmux_config apple_gmux_index = {
 	.name = "indexed"
 };
 
+static const struct apple_gmux_config apple_gmux_mmio = {
+	.read8 = &gmux_mmio_read8,
+	.write8 = &gmux_mmio_write8,
+	.read32 = &gmux_mmio_read32,
+	.write32 = &gmux_mmio_write32,
+	.gmux_handler = &gmux_handler_no_ddc,
+	.handler_flags = VGA_SWITCHEROO_NEEDS_EDP_CONFIG,
+	.resource_type = IORESOURCE_MEM,
+	.name = "T2"
+};
+
+
 /**
  * DOC: Interrupt
  *
@@ -538,7 +626,7 @@ static void gmux_clear_interrupts(struct apple_gmux_data *gmux_data)
 {
 	u8 status;
 
-	/* to clear interrupts write back current status */
+	/* to clear interrupts write back current status. */
 	status = gmux_interrupt_get_status(gmux_data);
 	if (status) {
 		gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_STATUS, status);
@@ -616,6 +704,25 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	pnp_set_drvdata(pnp, gmux_data);
 
 	switch (type) {
+	case APPLE_GMUX_TYPE_MMIO:
+		gmux_data->config = &apple_gmux_mmio;
+		mutex_init(&gmux_data->index_lock);
+
+		res = pnp_get_resource(pnp, IORESOURCE_MEM, 0);
+		gmux_data->iostart = res->start;
+		/* Although the ACPI table only allocates 8 bytes, we need 16. */
+		gmux_data->iolen = 16;
+		if (!request_mem_region(gmux_data->iostart, gmux_data->iolen,
+					"Apple gmux")) {
+			pr_err("gmux I/O already in use\n");
+			goto err_free;
+		}
+		gmux_data->iomem_base = ioremap(gmux_data->iostart, gmux_data->iolen);
+		if (!gmux_data->iomem_base) {
+			pr_err("couldn't remap gmux mmio region");
+			goto err_release;
+		}
+		goto get_version;
 	case APPLE_GMUX_TYPE_INDEXED:
 		gmux_data->config = &apple_gmux_index;
 		mutex_init(&gmux_data->index_lock);
@@ -635,6 +742,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 		goto err_free;
 	}
 
+get_version:
 	version = gmux_read32(gmux_data, GMUX_PORT_VERSION_MAJOR);
 	ver_major = (version >> 24) & 0xff;
 	ver_minor = (version >> 16) & 0xff;
@@ -660,7 +768,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 					 gmux_data, &gmux_bl_ops, &props);
 	if (IS_ERR(bdev)) {
 		ret = PTR_ERR(bdev);
-		goto err_release;
+		goto err_unmap;
 	}
 
 	gmux_data->bdev = bdev;
@@ -727,7 +835,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	/*
 	 * Retina MacBook Pros cannot switch the panel's AUX separately
 	 * and need eDP pre-calibration. They are distinguishable from
-	 * pre-retinas by having an "indexed" gmux.
+	 * pre-retinas by having an "indexed" or "T2" gmux.
 	 *
 	 * Pre-retina MacBook Pros can switch the panel's DDC separately.
 	 */
@@ -752,8 +860,14 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 					   &gmux_notify_handler);
 err_notify:
 	backlight_device_unregister(bdev);
+err_unmap:
+	if (gmux_data->iomem_base)
+		iounmap(gmux_data->iomem_base);
 err_release:
-	release_region(gmux_data->iostart, gmux_data->iolen);
+	if (gmux_data->config->resource_type == IORESOURCE_MEM)
+		release_mem_region(gmux_data->iostart, gmux_data->iolen);
+	else
+		release_region(gmux_data->iostart, gmux_data->iolen);
 err_free:
 	kfree(gmux_data);
 	return ret;
@@ -774,7 +888,11 @@ static void gmux_remove(struct pnp_dev *pnp)
 
 	backlight_device_unregister(gmux_data->bdev);
 
-	release_region(gmux_data->iostart, gmux_data->iolen);
+	if (gmux_data->iomem_base) {
+		iounmap(gmux_data->iomem_base);
+		release_mem_region(gmux_data->iostart, gmux_data->iolen);
+	} else
+		release_region(gmux_data->iostart, gmux_data->iolen);
 	apple_gmux_data = NULL;
 	kfree(gmux_data);
 
diff --git a/include/linux/apple-gmux.h b/include/linux/apple-gmux.h
index 25c1de4a716e..55b18f0f320d 100644
--- a/include/linux/apple-gmux.h
+++ b/include/linux/apple-gmux.h
@@ -34,11 +34,18 @@
 #define GMUX_PORT_READ			0xd0
 #define GMUX_PORT_WRITE			0xd4
 
+#define GMUX_MMIO_PORT_SELECT		0x0e
+#define GMUX_MMIO_COMMAND_SEND		0x0f
+
+#define GMUX_MMIO_READ			0x00
+#define GMUX_MMIO_WRITE			0x40
+
 #define GMUX_MIN_IO_LEN			(GMUX_PORT_BRIGHTNESS + 4)
 
 enum apple_gmux_type {
 	APPLE_GMUX_TYPE_PIO,
-	APPLE_GMUX_TYPE_INDEXED
+	APPLE_GMUX_TYPE_INDEXED,
+	APPLE_GMUX_TYPE_MMIO
 };
 
 #if IS_ENABLED(CONFIG_APPLE_GMUX)
@@ -92,16 +99,21 @@ static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, enum apple_gmux_ty
 	}
 
 	res = pnp_get_resource(pnp_dev, IORESOURCE_IO, 0);
-	if (!res || resource_size(res) < GMUX_MIN_IO_LEN)
-		goto out;
-
-	/*
-	 * Invalid version information may indicate either that the gmux
-	 * device isn't present or that it's a new one that uses indexed io.
-	 */
-	if (!(~inl(res->start + GMUX_PORT_VERSION_MAJOR))) {
-		if (apple_gmux_is_indexed(res->start))
-			type = APPLE_GMUX_TYPE_INDEXED;
+	if (res && resource_size(res) >= GMUX_MIN_IO_LEN) {
+		/*
+		 * Invalid version information may indicate either that the gmux
+		 * device isn't present or that it's a new one that uses indexed io.
+		 */
+		if (!(~inl(res->start + GMUX_PORT_VERSION_MAJOR))) {
+			if (apple_gmux_is_indexed(res->start))
+				type = APPLE_GMUX_TYPE_INDEXED;
+			else
+				goto out;
+		}
+	} else {
+		res = pnp_get_resource(pnp_dev, IORESOURCE_MEM, 0);
+		if (res)
+			type = APPLE_GMUX_TYPE_MMIO;
 		else
 			goto out;
 	}
-- 
2.39.1

