Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A688B6A964F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjCCLbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjCCLbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:31:22 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1F35D76D;
        Fri,  3 Mar 2023 03:30:54 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id d10so1237110pgt.12;
        Fri, 03 Mar 2023 03:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677843053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rvz56ZRcc7W4estONSzTU16SLxUjh8YXIHvA8hAQ6U=;
        b=dcM28P7zr3Ny1/wIUTamxrTOJFGh8DuDy9OAMH96ivUNyBBWGltj7Ox8pTv1z3Yiiw
         c1vYjliFnewdZoccDDEXG+zaDUxc4fII6/oQZdiPsZ/RskctTfkiVarPFrZ6/nf/cklx
         0rmNO5rkV0JCkeqDMzXuECTXGvSQay/8Uq0p8qu/hvGF16TuOpHXIXkpIBY04kkP4YUo
         pXP3asO31hCeIqeeldMK/niQNfj0ym0ijIPg547QAcEZNX/koc0kRLZit53y3xGJbPCi
         FW4h8U3zyoX8r3Yj3exk4eNN+XP8Ooib5qp6TgR96OGZWzHxtlJZ8SUvnsYnMabPBVey
         lB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677843053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rvz56ZRcc7W4estONSzTU16SLxUjh8YXIHvA8hAQ6U=;
        b=YTB7zEOiYZw5Lg26x2uk0VXUBWe3lzB6vCqJ9SimHX2I6Y9OFz/2ZTcuPHNGWbuO+4
         QzoZkTfQQOK0/sNLX1TxbcgCQHFwQm8psUdfaFOCbppAosCba/D/sgRdouMb80HVJOc2
         bddM0Hqp/nEsBo0KV2gl2AkwNDBvvX/4sIIEGk/sH18RKp858TkHPXTdytFkm1fWoo3A
         XY3zFpQ+BvSkKBn+MrnUQFzxO8KYFPOROvL5mnMHxGzVNESrI1BDugTO8SOdy/H2+Qrd
         CbtdOYf/8K2rVEJ8fB4QrvDr0M6pN85FDZNxHwCxRgKWrLlPzWZxYerc0cMs3AXj+L8a
         a0sw==
X-Gm-Message-State: AO0yUKU+MOELuzQV15aHGklqkwDRdVlT4NsS2yN3rHtoVflhlf+/1rZh
        r0XPxpW2apE51mDxaLj84EY=
X-Google-Smtp-Source: AK7set8eKsKz2NMh82q8eOTeQRtSzYDpnwPi++vXrzJ2kfX6eBDK5AkDxV3Q2Lf3VXg7lVSYv3z0yw==
X-Received: by 2002:a62:5485:0:b0:5a8:ad6c:cd43 with SMTP id i127-20020a625485000000b005a8ad6ccd43mr1712383pfb.31.1677843053300;
        Fri, 03 Mar 2023 03:30:53 -0800 (PST)
Received: from localhost.localdomain (124-148-239-17.tpgi.com.au. [124.148.239.17])
        by smtp.gmail.com with ESMTPSA id n4-20020a62e504000000b005a8c92f7c27sm1356262pff.212.2023.03.03.03.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 03:30:53 -0800 (PST)
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
Subject: [PATCH v4 3/4] apple-gmux: support MMIO gmux on T2 Macs
Date:   Fri,  3 Mar 2023 22:28:42 +1100
Message-Id: <20230303112842.3094-4-orlandoch.dev@gmail.com>
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

In some newer dual gpu MacBooks, the T2 Coprocessor functions as the
gmux, and the Intel side can interract with this new gmux type through
MMIO. Add support for these gmux controllers to the apple-gmux driver.

We start using the GMSP(0) acpi method on these gmux's when clearing
interrupts, as this prevents a flood of status=0 interrupts that can't
be cleared. It's unknown if this helps or hinders older gmux types, so
it isn't enabled for those.

Interestingly, the ACPI table only allocates 8 bytes for GMUX, but we
actually need 16, and as such we request 16 with request_mem_region.

Reading and writing from ports:
    16 bytes from 0xfe0b0200 are used. 0x0 to 0x4 are where data
    to read appears, and where data to write goes. Writing to 0xe
    sets the gmux port being accessed, and writing to 0xf sends commands.

    These commands are 0x40 & data_length for write, and data_length for
    read, where data_length is 1, 2 or 4. Once byte base+0xf is 0, the
    command is done.

Issues:
    As with other retina models, we can't switch DDC lines so
    switching at runtime doesn't work if the inactive gpu driver
    already disabled eDP due to it not being connected when that
    driver loaded.

    Additionally, turning on the dgpu back on on the MacBookPro16,1 does
    not work.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
v3->v4: Collect Hans' review
v3->v4: Squash using GMSP acpi method into this commit
v3->v4: use acpi_execute_simple_method()
v3->v4: Document more of what chips are used, how interrupts work, etc

 drivers/platform/x86/apple-gmux.c | 170 +++++++++++++++++++++++++++---
 include/linux/apple-gmux.h        |  56 +++++++---
 2 files changed, 200 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 36208e93d745..79809fc5cf0c 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -28,25 +28,35 @@
  * DOC: Overview
  *
  * gmux is a microcontroller built into the MacBook Pro to support dual GPUs:
- * A `Lattice XP2`_ on pre-retinas, a `Renesas R4F2113`_ on retinas.
+ * A `Lattice XP2`_ on pre-retinas, a `Renesas R4F2113`_ on pre-T2 retinas.
+ *
+ * On T2 Macbooks, the gmux is part of the T2 Coprocessor's SMC. The SMC has
+ * an I2C connection to a `NXP PCAL6524` GPIO expander, which enables/disables
+ * the voltage regulators of the discrete GPU, drives the display panel power,
+ * and has a GPIO to switch the eDP mux. The Intel CPU can interact with
+ * gmux through MMIO, similar to how the main SMC interface is controlled.
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
  * .. _Renesas R4F2113:
  *     http://www.renesas.com/products/mpumcu/h8s/h8s2100/h8s2113/index.jsp
+ * .. _NXP PCAL6524:
+ *     https://www.nxp.com/docs/en/data-sheet/PCAL6524.pdf
  */
 
 struct apple_gmux_config;
 
 struct apple_gmux_data {
+	u8 *__iomem iomem_base;
 	unsigned long iostart;
 	unsigned long iolen;
 	const struct apple_gmux_config *config;
@@ -208,6 +218,79 @@ static void gmux_index_write32(struct apple_gmux_data *gmux_data, int port,
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
@@ -236,8 +319,8 @@ static void gmux_write32(struct apple_gmux_data *gmux_data, int port,
  * the GPU. On dual GPU MacBook Pros by contrast, either GPU may be suspended
  * to conserve energy. Hence the PWM signal needs to be generated by a separate
  * backlight driver which is controlled by gmux. The earliest generation
- * MBP5 2008/09 uses a `TI LP8543`_ backlight driver. All newer models
- * use a `TI LP8545`_.
+ * MBP5 2008/09 uses a `TI LP8543`_ backlight driver. Newer models
+ * use a `TI LP8545`_ or a TI LP8548.
  *
  * .. _TI LP8543: https://www.ti.com/lit/ds/symlink/lp8543.pdf
  * .. _TI LP8545: https://www.ti.com/lit/ds/symlink/lp8545.pdf
@@ -301,8 +384,8 @@ static const struct backlight_ops gmux_bl_ops = {
  * connecting it either to the discrete GPU or the Thunderbolt controller.
  * Oddly enough, while the full port is no longer switchable, AUX and HPD
  * are still switchable by way of an `NXP CBTL03062`_ (on pre-retinas
- * MBP8 2011 and MBP9 2012) or two `TI TS3DS10224`_ (on retinas) under the
- * control of gmux. Since the integrated GPU is missing the main link,
+ * MBP8 2011 and MBP9 2012) or two `TI TS3DS10224`_ (on pre-t2 retinas) under
+ * the control of gmux. Since the integrated GPU is missing the main link,
  * external displays appear to it as phantoms which fail to link-train.
  *
  * gmux receives the HPD signal of all display connectors and sends an
@@ -503,14 +586,42 @@ static const struct apple_gmux_config apple_gmux_index = {
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
+	.read_version_as_u32 = true,
+	.name = "T2"
+};
+
+
 /**
  * DOC: Interrupt
  *
  * gmux is also connected to a GPIO pin of the southbridge and thereby is able
- * to trigger an ACPI GPE. On the MBP5 2008/09 it's GPIO pin 22 of the Nvidia
- * MCP79, on all following generations it's GPIO pin 6 of the Intel PCH.
+ * to trigger an ACPI GPE. ACPI name GMGP holds this GPIO pin's number. On the
+ * MBP5 2008/09 it's GPIO pin 22 of the Nvidia MCP79, on following generations
+ * it's GPIO pin 6 of the Intel PCH, on MMIO gmux's it's pin 21.
+ *
  * The GPE merely signals that an interrupt occurred, the actual type of event
  * is identified by reading a gmux register.
+ *
+ * In addition to the GMGP name, gmux's ACPI device also has two methods GMSP
+ * and GMLV. GMLV likely means "GMUX Level", and reads the value of the GPIO,
+ * while GMSP likely means "GMUX Set Polarity", and seems to write to the GPIO's
+ * value. On newer Macbooks (This was introduced with or sometime before the
+ * MacBookPro14,3), the ACPI GPE method differentiates between the OS type: On
+ * Darwin, only a notification is signaled, whereas on other OSes, the GPIO's
+ * value is read and then inverted.
+ *
+ * Because Linux masquerades as Darwin, it ends up in the notification-only code
+ * path. On MMIO gmux's, this seems to lead to us being unable to clear interrupts,
+ * unless we call GMSP(0). Without this, there is a flood of status=0 interrupts
+ * that can't be cleared. This issue seems to be unique to MMIO gmux's.
  */
 
 static inline void gmux_disable_interrupts(struct apple_gmux_data *gmux_data)
@@ -537,6 +648,9 @@ static void gmux_clear_interrupts(struct apple_gmux_data *gmux_data)
 	/* to clear interrupts write back current status */
 	status = gmux_interrupt_get_status(gmux_data);
 	gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_STATUS, status);
+	/* Prevent flood of status=0 interrupts */
+	if (gmux_data->config == &apple_gmux_mmio)
+		acpi_execute_simple_method(gmux_data->dhandle, "GMSP", 0);
 }
 
 static void gmux_notify_handler(acpi_handle device, u32 value, void *context)
@@ -609,6 +723,25 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
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
@@ -628,6 +761,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 		goto err_free;
 	}
 
+get_version:
 	if (gmux_data->config->read_version_as_u32) {
 		version = gmux_read32(gmux_data, GMUX_PORT_VERSION_MAJOR);
 		ver_major = (version >> 24) & 0xff;
@@ -658,7 +792,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 					 gmux_data, &gmux_bl_ops, &props);
 	if (IS_ERR(bdev)) {
 		ret = PTR_ERR(bdev);
-		goto err_release;
+		goto err_unmap;
 	}
 
 	gmux_data->bdev = bdev;
@@ -725,7 +859,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	/*
 	 * Retina MacBook Pros cannot switch the panel's AUX separately
 	 * and need eDP pre-calibration. They are distinguishable from
-	 * pre-retinas by having an "indexed" gmux.
+	 * pre-retinas by having an "indexed" or "T2" gmux.
 	 *
 	 * Pre-retina MacBook Pros can switch the panel's DDC separately.
 	 */
@@ -750,8 +884,14 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
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
@@ -772,7 +912,11 @@ static void gmux_remove(struct pnp_dev *pnp)
 
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
index 147dc1c52e08..272f63f8fd7c 100644
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
 	APPLE_GMUX_TYPE_INDEXED,
+	APPLE_GMUX_TYPE_MMIO,
 };
 
 #if IS_ENABLED(CONFIG_APPLE_GMUX)
@@ -57,6 +64,24 @@ static inline bool apple_gmux_is_indexed(unsigned long iostart)
 	return false;
 }
 
+static inline bool apple_gmux_is_mmio(unsigned long iostart)
+{
+	u8 *__iomem iomem_base = ioremap(iostart, 16);
+	u8 val;
+
+	if (!iomem_base)
+		return false;
+
+	/*
+	 * If this is 0xff, then gmux must not be present, as the gmux would
+	 * reset it to 0x00, or it would be one of 0x1, 0x4, 0x41, 0x44 if a
+	 * command is currently being processed.
+	 */
+	val = ioread8(iomem_base + GMUX_MMIO_COMMAND_SEND);
+	iounmap(iomem_base);
+	return (val != 0xff);
+}
+
 /**
  * apple_gmux_detect() - detect if gmux is built into the machine
  *
@@ -93,19 +118,24 @@ static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, enum apple_gmux_ty
 	}
 
 	res = pnp_get_resource(pnp_dev, IORESOURCE_IO, 0);
-	if (!res || resource_size(res) < GMUX_MIN_IO_LEN)
-		goto out;
-
-	/*
-	 * Invalid version information may indicate either that the gmux
-	 * device isn't present or that it's a new one that uses indexed io.
-	 */
-	ver_major = inb(res->start + GMUX_PORT_VERSION_MAJOR);
-	ver_minor = inb(res->start + GMUX_PORT_VERSION_MINOR);
-	ver_release = inb(res->start + GMUX_PORT_VERSION_RELEASE);
-	if (ver_major == 0xff && ver_minor == 0xff && ver_release == 0xff) {
-		if (apple_gmux_is_indexed(res->start))
-			type = APPLE_GMUX_TYPE_INDEXED;
+	if (res && resource_size(res) >= GMUX_MIN_IO_LEN) {
+		/*
+		 * Invalid version information may indicate either that the gmux
+		 * device isn't present or that it's a new one that uses indexed io.
+		 */
+		ver_major = inb(res->start + GMUX_PORT_VERSION_MAJOR);
+		ver_minor = inb(res->start + GMUX_PORT_VERSION_MINOR);
+		ver_release = inb(res->start + GMUX_PORT_VERSION_RELEASE);
+		if (ver_major == 0xff && ver_minor == 0xff && ver_release == 0xff) {
+			if (apple_gmux_is_indexed(res->start))
+				type = APPLE_GMUX_TYPE_INDEXED;
+			else
+				goto out;
+		}
+	} else {
+		res = pnp_get_resource(pnp_dev, IORESOURCE_MEM, 0);
+		if (res && apple_gmux_is_mmio(res->start))
+			type = APPLE_GMUX_TYPE_MMIO;
 		else
 			goto out;
 	}
-- 
2.39.2

