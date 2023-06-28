Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BD0740DE8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjF1JxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjF1J07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:26:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F208830FF;
        Wed, 28 Jun 2023 02:26:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C1D861295;
        Wed, 28 Jun 2023 09:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74234C433C8;
        Wed, 28 Jun 2023 09:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687944363;
        bh=qCsPdqSyHRio5P0ajpFFsP9Vnd01imw67knxsqiNov0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VZHz6Yfx9lZppLvALsbTSG64t9dRdTtPjMuRixyQt8LcVIpA7Z9kY7HiB1EJM43Jq
         TTQ6wqWOYN1aIKtpuoTUkfO5wx1tPIwoS66Fp4WsC2DOEG01w7mk2YqvT7h4hG/Uop
         uZPBrWXsqgf1a1oCXDvEx9atdwSA1mmsNCTN7hH4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.119
Date:   Wed, 28 Jun 2023 11:25:45 +0200
Message-ID: <2023062845-unwrapped-thwarting-db5a@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023062845-magnify-roundup-f735@gregkh>
References: <2023062845-magnify-roundup-f735@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index c4ef4eed1a12..b863208e31b2 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 118
+SUBLEVEL = 119
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index 2e94f32d9dfc..5de82729eb7e 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -527,7 +527,7 @@ touchscreen@1 {
 
 		interrupt-parent = <&gpio1>;
 		interrupts = <31 0>;
-		pendown-gpio = <&gpio1 31 0>;
+		pendown-gpio = <&gpio1 31 GPIO_ACTIVE_LOW>;
 
 
 		ti,x-min = /bits/ 16 <0x0>;
diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
index beed819609e8..8f3b483bb64d 100644
--- a/arch/arm/boot/dts/at91sam9261ek.dts
+++ b/arch/arm/boot/dts/at91sam9261ek.dts
@@ -156,7 +156,7 @@ tsc2046@2 {
 					compatible = "ti,ads7843";
 					interrupts-extended = <&pioC 2 IRQ_TYPE_EDGE_BOTH>;
 					spi-max-frequency = <3000000>;
-					pendown-gpio = <&pioC 2 GPIO_ACTIVE_HIGH>;
+					pendown-gpio = <&pioC 2 GPIO_ACTIVE_LOW>;
 
 					ti,x-min = /bits/ 16 <150>;
 					ti,x-max = /bits/ 16 <3830>;
diff --git a/arch/arm/boot/dts/imx7d-pico-hobbit.dts b/arch/arm/boot/dts/imx7d-pico-hobbit.dts
index d917dc4f2f22..6ad39dca7009 100644
--- a/arch/arm/boot/dts/imx7d-pico-hobbit.dts
+++ b/arch/arm/boot/dts/imx7d-pico-hobbit.dts
@@ -64,7 +64,7 @@ ads7846@0 {
 		interrupt-parent = <&gpio2>;
 		interrupts = <7 0>;
 		spi-max-frequency = <1000000>;
-		pendown-gpio = <&gpio2 7 0>;
+		pendown-gpio = <&gpio2 7 GPIO_ACTIVE_LOW>;
 		vcc-supply = <&reg_3p3v>;
 		ti,x-min = /bits/ 16 <0>;
 		ti,x-max = /bits/ 16 <4095>;
diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 4e1a6cde90fe..4e62ed2df11d 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -205,7 +205,7 @@ tsc2046@0 {
 		pinctrl-0 = <&pinctrl_tsc2046_pendown>;
 		interrupt-parent = <&gpio2>;
 		interrupts = <29 0>;
-		pendown-gpio = <&gpio2 29 GPIO_ACTIVE_HIGH>;
+		pendown-gpio = <&gpio2 29 GPIO_ACTIVE_LOW>;
 		touchscreen-max-pressure = <255>;
 		wakeup-source;
 	};
diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index e61b8a2bfb7d..51baedf1603b 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -227,7 +227,7 @@ ads7846@0 {
 
 		interrupt-parent = <&gpio2>;
 		interrupts = <25 0>;		/* gpio_57 */
-		pendown-gpio = <&gpio2 25 GPIO_ACTIVE_HIGH>;
+		pendown-gpio = <&gpio2 25 GPIO_ACTIVE_LOW>;
 
 		ti,x-min = /bits/ 16 <0x0>;
 		ti,x-max = /bits/ 16 <0x0fff>;
diff --git a/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi b/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi
index 3decc2d78a6c..a7f99ae0c1fe 100644
--- a/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi
+++ b/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi
@@ -54,7 +54,7 @@ ads7846@0 {
 
 		interrupt-parent = <&gpio1>;
 		interrupts = <27 0>;		/* gpio_27 */
-		pendown-gpio = <&gpio1 27 GPIO_ACTIVE_HIGH>;
+		pendown-gpio = <&gpio1 27 GPIO_ACTIVE_LOW>;
 
 		ti,x-min = /bits/ 16 <0x0>;
 		ti,x-max = /bits/ 16 <0x0fff>;
diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
index 73d477898ec2..06e7cf96c663 100644
--- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
+++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
@@ -311,7 +311,7 @@ tsc2046@0 {
 		interrupt-parent = <&gpio1>;
 		interrupts = <8 0>;   /* boot6 / gpio_8 */
 		spi-max-frequency = <1000000>;
-		pendown-gpio = <&gpio1 8 GPIO_ACTIVE_HIGH>;
+		pendown-gpio = <&gpio1 8 GPIO_ACTIVE_LOW>;
 		vcc-supply = <&reg_vcc3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&tsc2048_pins>;
diff --git a/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi b/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
index 1d6e88f99eb3..c3570acc35fa 100644
--- a/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
@@ -149,7 +149,7 @@ ads7846@0 {
 
 		interrupt-parent = <&gpio4>;
 		interrupts = <18 0>;			/* gpio_114 */
-		pendown-gpio = <&gpio4 18 GPIO_ACTIVE_HIGH>;
+		pendown-gpio = <&gpio4 18 GPIO_ACTIVE_LOW>;
 
 		ti,x-min = /bits/ 16 <0x0>;
 		ti,x-max = /bits/ 16 <0x0fff>;
diff --git a/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi b/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi
index 7e30f9d45790..d95a0e130058 100644
--- a/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi
@@ -160,7 +160,7 @@ ads7846@0 {
 
 		interrupt-parent = <&gpio4>;
 		interrupts = <18 0>;			/* gpio_114 */
-		pendown-gpio = <&gpio4 18 GPIO_ACTIVE_HIGH>;
+		pendown-gpio = <&gpio4 18 GPIO_ACTIVE_LOW>;
 
 		ti,x-min = /bits/ 16 <0x0>;
 		ti,x-max = /bits/ 16 <0x0fff>;
diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
index 37608af6c07f..ca6d777ebf84 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -651,7 +651,7 @@ tsc2046@0 {
 		pinctrl-0 = <&penirq_pins>;
 		interrupt-parent = <&gpio3>;
 		interrupts = <30 IRQ_TYPE_NONE>;	/* GPIO_94 */
-		pendown-gpio = <&gpio3 30 GPIO_ACTIVE_HIGH>;
+		pendown-gpio = <&gpio3 30 GPIO_ACTIVE_LOW>;
 		vcc-supply = <&vaux4>;
 
 		ti,x-min = /bits/ 16 <0>;
diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index ca759b7b8a58..e62ea8b6d53f 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -354,7 +354,7 @@ ads7846@0 {
 
 		interrupt-parent = <&gpio1>;
 		interrupts = <15 0>;			/* gpio1_wk15 */
-		pendown-gpio = <&gpio1 15 GPIO_ACTIVE_HIGH>;
+		pendown-gpio = <&gpio1 15 GPIO_ACTIVE_LOW>;
 
 
 		ti,x-min = /bits/ 16 <0x0>;
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index f79f3720e4cb..543eb08fa8e5 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -109,8 +109,14 @@
 #define SB_BARRIER_INSN			__SYS_BARRIER_INSN(0, 7, 31)
 
 #define SYS_DC_ISW			sys_insn(1, 0, 7, 6, 2)
+#define SYS_DC_IGSW			sys_insn(1, 0, 7, 6, 4)
+#define SYS_DC_IGDSW			sys_insn(1, 0, 7, 6, 6)
 #define SYS_DC_CSW			sys_insn(1, 0, 7, 10, 2)
+#define SYS_DC_CGSW			sys_insn(1, 0, 7, 10, 4)
+#define SYS_DC_CGDSW			sys_insn(1, 0, 7, 10, 6)
 #define SYS_DC_CISW			sys_insn(1, 0, 7, 14, 2)
+#define SYS_DC_CIGSW			sys_insn(1, 0, 7, 14, 4)
+#define SYS_DC_CIGDSW			sys_insn(1, 0, 7, 14, 6)
 
 /*
  * System registers, organised loosely by encoding but grouped together
diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index 360ada80d20c..d22ec8acb13c 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -26,6 +26,7 @@ KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
 KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
 KBUILD_CFLAGS += -c -MD -Os -m64 -msoft-float -fno-common
 KBUILD_CFLAGS += -fno-stack-protector
+KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 KBUILD_CFLAGS += $(CLANG_FLAGS)
 KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
 KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 6bde05a86b4e..896bc41cb2ba 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -97,7 +97,10 @@ static void init_x2apic_ldr(void)
 
 static int x2apic_phys_probe(void)
 {
-	if (x2apic_mode && (x2apic_phys || x2apic_fadt_phys()))
+	if (!x2apic_mode)
+		return 0;
+
+	if (x2apic_phys || x2apic_fadt_phys())
 		return 1;
 
 	return apic == &apic_x2apic_phys;
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 557f0fe25dff..37db264866b6 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -172,10 +172,10 @@ void __meminit init_trampoline_kaslr(void)
 		set_p4d(p4d_tramp,
 			__p4d(_KERNPG_TABLE | __pa(pud_page_tramp)));
 
-		set_pgd(&trampoline_pgd_entry,
-			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
+		trampoline_pgd_entry =
+			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp));
 	} else {
-		set_pgd(&trampoline_pgd_entry,
-			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
+		trampoline_pgd_entry =
+			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp));
 	}
 }
diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index 810de0b4c125..9c3ad33e926a 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -101,8 +101,6 @@ acpi_status
 acpi_hw_get_gpe_status(struct acpi_gpe_event_info *gpe_event_info,
 		       acpi_event_status *event_status);
 
-acpi_status acpi_hw_disable_all_gpes(void);
-
 acpi_status acpi_hw_enable_all_runtime_gpes(void);
 
 acpi_status acpi_hw_enable_all_wakeup_gpes(void);
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index d7194047d256..b277e25b276c 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -635,11 +635,19 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	}
 
 	/*
-	 * Disable and clear GPE status before interrupt is enabled. Some GPEs
-	 * (like wakeup GPE) haven't handler, this can avoid such GPE misfire.
-	 * acpi_leave_sleep_state will reenable specific GPEs later
+	 * Disable all GPE and clear their status bits before interrupts are
+	 * enabled. Some GPEs (like wakeup GPEs) have no handlers and this can
+	 * prevent them from producing spurious interrups.
+	 *
+	 * acpi_leave_sleep_state() will reenable specific GPEs later.
+	 *
+	 * Because this code runs on one CPU with disabled interrupts (all of
+	 * the other CPUs are offline at this time), it need not acquire any
+	 * sleeping locks which may trigger an implicit preemption point even
+	 * if there is no contention, so avoid doing that by using a low-level
+	 * library routine here.
 	 */
-	acpi_disable_all_gpes();
+	acpi_hw_disable_all_gpes();
 	/* Allow EC transactions to happen. */
 	acpi_ec_unblock_transactions();
 
diff --git a/drivers/base/regmap/regmap-spi-avmm.c b/drivers/base/regmap/regmap-spi-avmm.c
index ad1da83e849f..67f89937219c 100644
--- a/drivers/base/regmap/regmap-spi-avmm.c
+++ b/drivers/base/regmap/regmap-spi-avmm.c
@@ -666,7 +666,7 @@ static const struct regmap_bus regmap_spi_avmm_bus = {
 	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
 	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
 	.max_raw_read = SPI_AVMM_VAL_SIZE * MAX_READ_CNT,
-	.max_raw_write = SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT,
+	.max_raw_write = SPI_AVMM_REG_SIZE + SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT,
 	.free_context = spi_avmm_bridge_ctx_free,
 };
 
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 512c867495ea..365761055df3 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -731,7 +731,9 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
 		wake_up_interruptible(&priv->int_queue);
 
 	/* Clear interrupts handled with TPM_EOI */
+	tpm_tis_request_locality(chip, 0);
 	rc = tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), interrupt);
+	tpm_tis_relinquish_locality(chip, 0);
 	if (rc < 0)
 		return IRQ_NONE;
 
diff --git a/drivers/gpio/gpio-sifive.c b/drivers/gpio/gpio-sifive.c
index f41123de69c5..5ffab0fc1b76 100644
--- a/drivers/gpio/gpio-sifive.c
+++ b/drivers/gpio/gpio-sifive.c
@@ -215,8 +215,12 @@ static int sifive_gpio_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	for (i = 0; i < ngpio; i++)
-		chip->irq_number[i] = platform_get_irq(pdev, i);
+	for (i = 0; i < ngpio; i++) {
+		ret = platform_get_irq(pdev, i);
+		if (ret < 0)
+			return ret;
+		chip->irq_number[i] = ret;
+	}
 
 	ret = bgpio_init(&chip->gc, dev, 4,
 			 chip->base + SIFIVE_GPIO_INPUT_VAL,
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 8c041a8dd9d8..f9fdd117c654 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1578,9 +1578,14 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
 	}
 
 	if (gc->irq.parent_handler) {
-		void *data = gc->irq.parent_handler_data ?: gc;
-
 		for (i = 0; i < gc->irq.num_parents; i++) {
+			void *data;
+
+			if (gc->irq.per_parent_data)
+				data = gc->irq.parent_handler_data_array[i];
+			else
+				data = gc->irq.parent_handler_data ?: gc;
+
 			/*
 			 * The parent IRQ chip is already using the chip_data
 			 * for this IRQ chip, so our callbacks simply use the
@@ -1678,6 +1683,14 @@ int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
 	gc->to_irq = gpiochip_to_irq;
 	gc->irq.domain = domain;
 
+	/*
+	 * Using barrier() here to prevent compiler from reordering
+	 * gc->irq.initialized before adding irqdomain.
+	 */
+	barrier();
+
+	gc->irq.initialized = true;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(gpiochip_irqchip_add_domain);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 938aa11acb2d..be863af956bb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -353,6 +353,35 @@ static inline bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
 		return false;
 }
 
+/**
+ * update_planes_and_stream_adapter() - Send planes to be updated in DC
+ *
+ * DC has a generic way to update planes and stream via
+ * dc_update_planes_and_stream function; however, DM might need some
+ * adjustments and preparation before calling it. This function is a wrapper
+ * for the dc_update_planes_and_stream that does any required configuration
+ * before passing control to DC.
+ */
+static inline bool update_planes_and_stream_adapter(struct dc *dc,
+						    int update_type,
+						    int planes_count,
+						    struct dc_stream_state *stream,
+						    struct dc_stream_update *stream_update,
+						    struct dc_surface_update *array_of_surface_update)
+{
+	/*
+	 * Previous frame finished and HW is ready for optimization.
+	 */
+	if (update_type == UPDATE_TYPE_FAST)
+		dc_post_update_surfaces_to_stream(dc);
+
+	return dc_update_planes_and_stream(dc,
+					   array_of_surface_update,
+					   planes_count,
+					   stream,
+					   stream_update);
+}
+
 /**
  * dm_pflip_high_irq() - Handle pageflip interrupt
  * @interrupt_params: ignored
@@ -2550,10 +2579,13 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 			bundle->surface_updates[m].surface->force_full_update =
 				true;
 		}
-		dc_commit_updates_for_stream(
-			dm->dc, bundle->surface_updates,
-			dc_state->stream_status->plane_count,
-			dc_state->streams[k], &bundle->stream_update, dc_state);
+
+		update_planes_and_stream_adapter(dm->dc,
+					 UPDATE_TYPE_FULL,
+					 dc_state->stream_status->plane_count,
+					 dc_state->streams[k],
+					 &bundle->stream_update,
+					 bundle->surface_updates);
 	}
 
 cleanup:
@@ -9218,6 +9250,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		if (acrtc_state->abm_level != dm_old_crtc_state->abm_level)
 			bundle->stream_update.abm_level = &acrtc_state->abm_level;
 
+		mutex_lock(&dm->dc_lock);
+		if ((acrtc_state->update_type > UPDATE_TYPE_FAST) &&
+				acrtc_state->stream->link->psr_settings.psr_allow_active)
+			amdgpu_dm_psr_disable(acrtc_state->stream);
+		mutex_unlock(&dm->dc_lock);
+
 		/*
 		 * If FreeSync state on the stream has changed then we need to
 		 * re-adjust the min/max bounds now that DC doesn't handle this
@@ -9231,16 +9269,13 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
 		}
 		mutex_lock(&dm->dc_lock);
-		if ((acrtc_state->update_type > UPDATE_TYPE_FAST) &&
-				acrtc_state->stream->link->psr_settings.psr_allow_active)
-			amdgpu_dm_psr_disable(acrtc_state->stream);
 
-		dc_commit_updates_for_stream(dm->dc,
-						     bundle->surface_updates,
-						     planes_count,
-						     acrtc_state->stream,
-						     &bundle->stream_update,
-						     dc_state);
+		update_planes_and_stream_adapter(dm->dc,
+					 acrtc_state->update_type,
+					 planes_count,
+					 acrtc_state->stream,
+					 &bundle->stream_update,
+					 bundle->surface_updates);
 
 		/**
 		 * Enable or disable the interrupts on the backend.
@@ -9666,12 +9701,11 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 
 
 		mutex_lock(&dm->dc_lock);
-		dc_commit_updates_for_stream(dm->dc,
-						     dummy_updates,
-						     status->plane_count,
-						     dm_new_crtc_state->stream,
-						     &stream_update,
-						     dc_state);
+		dc_update_planes_and_stream(dm->dc,
+					    dummy_updates,
+					    status->plane_count,
+					    dm_new_crtc_state->stream,
+					    &stream_update);
 		mutex_unlock(&dm->dc_lock);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index eca882438f6e..220a26e45a28 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2534,6 +2534,137 @@ static void copy_stream_update_to_stream(struct dc *dc,
 	}
 }
 
+void dc_reset_state(struct dc *dc, struct dc_state *context)
+{
+	dc_resource_state_destruct(context);
+
+	/* clear the structure, but don't reset the reference count */
+	memset(context, 0, offsetof(struct dc_state, refcount));
+
+	init_state(dc, context);
+}
+
+static bool update_planes_and_stream_state(struct dc *dc,
+		struct dc_surface_update *srf_updates, int surface_count,
+		struct dc_stream_state *stream,
+		struct dc_stream_update *stream_update,
+		enum surface_update_type *new_update_type,
+		struct dc_state **new_context)
+{
+	struct dc_state *context;
+	int i, j;
+	enum surface_update_type update_type;
+	const struct dc_stream_status *stream_status;
+	struct dc_context *dc_ctx = dc->ctx;
+
+	stream_status = dc_stream_get_status(stream);
+
+	if (!stream_status) {
+		if (surface_count) /* Only an error condition if surf_count non-zero*/
+			ASSERT(false);
+
+		return false; /* Cannot commit surface to stream that is not committed */
+	}
+
+	context = dc->current_state;
+
+	update_type = dc_check_update_surfaces_for_stream(
+			dc, srf_updates, surface_count, stream_update, stream_status);
+
+	/* update current stream with the new updates */
+	copy_stream_update_to_stream(dc, context, stream, stream_update);
+
+	/* do not perform surface update if surface has invalid dimensions
+	 * (all zero) and no scaling_info is provided
+	 */
+	if (surface_count > 0) {
+		for (i = 0; i < surface_count; i++) {
+			if ((srf_updates[i].surface->src_rect.width == 0 ||
+				 srf_updates[i].surface->src_rect.height == 0 ||
+				 srf_updates[i].surface->dst_rect.width == 0 ||
+				 srf_updates[i].surface->dst_rect.height == 0) &&
+				(!srf_updates[i].scaling_info ||
+				  srf_updates[i].scaling_info->src_rect.width == 0 ||
+				  srf_updates[i].scaling_info->src_rect.height == 0 ||
+				  srf_updates[i].scaling_info->dst_rect.width == 0 ||
+				  srf_updates[i].scaling_info->dst_rect.height == 0)) {
+				DC_ERROR("Invalid src/dst rects in surface update!\n");
+				return false;
+			}
+		}
+	}
+
+	if (update_type >= update_surface_trace_level)
+		update_surface_trace(dc, srf_updates, surface_count);
+
+	if (update_type >= UPDATE_TYPE_FULL) {
+		struct dc_plane_state *new_planes[MAX_SURFACES] = {0};
+
+		for (i = 0; i < surface_count; i++)
+			new_planes[i] = srf_updates[i].surface;
+
+		/* initialize scratch memory for building context */
+		context = dc_create_state(dc);
+		if (context == NULL) {
+			DC_ERROR("Failed to allocate new validate context!\n");
+			return false;
+		}
+
+		dc_resource_state_copy_construct(
+				dc->current_state, context);
+
+		/*remove old surfaces from context */
+		if (!dc_rem_all_planes_for_stream(dc, stream, context)) {
+
+			BREAK_TO_DEBUGGER();
+			goto fail;
+		}
+
+		/* add surface to context */
+		if (!dc_add_all_planes_for_stream(dc, stream, new_planes, surface_count, context)) {
+
+			BREAK_TO_DEBUGGER();
+			goto fail;
+		}
+	}
+
+	/* save update parameters into surface */
+	for (i = 0; i < surface_count; i++) {
+		struct dc_plane_state *surface = srf_updates[i].surface;
+
+		copy_surface_update_to_plane(surface, &srf_updates[i]);
+
+		if (update_type >= UPDATE_TYPE_MED) {
+			for (j = 0; j < dc->res_pool->pipe_count; j++) {
+				struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
+
+				if (pipe_ctx->plane_state != surface)
+					continue;
+
+				resource_build_scaling_params(pipe_ctx);
+			}
+		}
+	}
+
+	if (update_type == UPDATE_TYPE_FULL) {
+		if (!dc->res_pool->funcs->validate_bandwidth(dc, context, false)) {
+			BREAK_TO_DEBUGGER();
+			goto fail;
+		}
+	}
+
+	*new_context = context;
+	*new_update_type = update_type;
+
+	return true;
+
+fail:
+	dc_release_state(context);
+
+	return false;
+
+}
+
 static void commit_planes_do_stream_update(struct dc *dc,
 		struct dc_stream_state *stream,
 		struct dc_stream_update *stream_update,
@@ -2931,6 +3062,152 @@ static void commit_planes_for_stream(struct dc *dc,
 	}
 }
 
+static bool commit_minimal_transition_state(struct dc *dc,
+		struct dc_state *transition_base_context)
+{
+	struct dc_state *transition_context = dc_create_state(dc);
+	enum pipe_split_policy tmp_policy;
+	enum dc_status ret = DC_ERROR_UNEXPECTED;
+	unsigned int i, j;
+
+	if (!transition_context)
+		return false;
+
+	tmp_policy = dc->debug.pipe_split_policy;
+	dc->debug.pipe_split_policy = MPC_SPLIT_AVOID;
+
+	dc_resource_state_copy_construct(transition_base_context, transition_context);
+
+	//commit minimal state
+	if (dc->res_pool->funcs->validate_bandwidth(dc, transition_context, false)) {
+		for (i = 0; i < transition_context->stream_count; i++) {
+			struct dc_stream_status *stream_status = &transition_context->stream_status[i];
+
+			for (j = 0; j < stream_status->plane_count; j++) {
+				struct dc_plane_state *plane_state = stream_status->plane_states[j];
+
+				/* force vsync flip when reconfiguring pipes to prevent underflow
+				 * and corruption
+				 */
+				plane_state->flip_immediate = false;
+			}
+		}
+
+		ret = dc_commit_state_no_check(dc, transition_context);
+	}
+
+	//always release as dc_commit_state_no_check retains in good case
+	dc_release_state(transition_context);
+
+	//restore previous pipe split policy
+	dc->debug.pipe_split_policy = tmp_policy;
+
+	if (ret != DC_OK) {
+		//this should never happen
+		BREAK_TO_DEBUGGER();
+		return false;
+	}
+
+	//force full surface update
+	for (i = 0; i < dc->current_state->stream_count; i++) {
+		for (j = 0; j < dc->current_state->stream_status[i].plane_count; j++) {
+			dc->current_state->stream_status[i].plane_states[j]->update_flags.raw = 0xFFFFFFFF;
+		}
+	}
+
+	return true;
+}
+
+bool dc_update_planes_and_stream(struct dc *dc,
+		struct dc_surface_update *srf_updates, int surface_count,
+		struct dc_stream_state *stream,
+		struct dc_stream_update *stream_update)
+{
+	struct dc_state *context;
+	enum surface_update_type update_type;
+	int i;
+
+	/* In cases where MPO and split or ODM are used transitions can
+	 * cause underflow. Apply stream configuration with minimal pipe
+	 * split first to avoid unsupported transitions for active pipes.
+	 */
+	bool force_minimal_pipe_splitting = false;
+	bool is_plane_addition = false;
+
+	struct dc_stream_status *cur_stream_status = stream_get_status(dc->current_state, stream);
+
+	if (cur_stream_status &&
+			dc->current_state->stream_count > 0 &&
+			dc->debug.pipe_split_policy != MPC_SPLIT_AVOID) {
+		/* determine if minimal transition is required */
+		if (cur_stream_status->plane_count > surface_count) {
+			force_minimal_pipe_splitting = true;
+		} else if (cur_stream_status->plane_count < surface_count) {
+			force_minimal_pipe_splitting = true;
+			is_plane_addition = true;
+		}
+	}
+
+	/* on plane addition, minimal state is the current one */
+	if (force_minimal_pipe_splitting && is_plane_addition &&
+		!commit_minimal_transition_state(dc, dc->current_state))
+				return false;
+
+	if (!update_planes_and_stream_state(
+			dc,
+			srf_updates,
+			surface_count,
+			stream,
+			stream_update,
+			&update_type,
+			&context))
+		return false;
+
+	/* on plane addition, minimal state is the new one */
+	if (force_minimal_pipe_splitting && !is_plane_addition) {
+		if (!commit_minimal_transition_state(dc, context)) {
+			dc_release_state(context);
+			return false;
+		}
+
+		update_type = UPDATE_TYPE_FULL;
+	}
+
+	commit_planes_for_stream(
+			dc,
+			srf_updates,
+			surface_count,
+			stream,
+			stream_update,
+			update_type,
+			context);
+
+	if (dc->current_state != context) {
+
+		/* Since memory free requires elevated IRQL, an interrupt
+		 * request is generated by mem free. If this happens
+		 * between freeing and reassigning the context, our vsync
+		 * interrupt will call into dc and cause a memory
+		 * corruption BSOD. Hence, we first reassign the context,
+		 * then free the old context.
+		 */
+
+		struct dc_state *old = dc->current_state;
+
+		dc->current_state = context;
+		dc_release_state(old);
+
+		// clear any forced full updates
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+			if (pipe_ctx->plane_state && pipe_ctx->stream == stream)
+				pipe_ctx->plane_state->force_full_update = false;
+		}
+	}
+	return true;
+}
+
 void dc_commit_updates_for_stream(struct dc *dc,
 		struct dc_surface_update *srf_updates,
 		int surface_count,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 7644f0e747d3..3e606faff58f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -288,6 +288,9 @@ bool dc_is_stream_scaling_unchanged(
 	struct dc_stream_state *old_stream, struct dc_stream_state *stream);
 
 /*
+ * Setup stream attributes if no stream updates are provided
+ * there will be no impact on the stream parameters
+ *
  * Set up surface attributes and associate to a stream
  * The surfaces parameter is an absolute set of all surface active for the stream.
  * If no surfaces are provided, the stream will be blanked; no memory read.
@@ -296,8 +299,23 @@ bool dc_is_stream_scaling_unchanged(
  * After this call:
  *   Surfaces attributes are programmed and configured to be composed into stream.
  *   This does not trigger a flip.  No surface address is programmed.
+ *
  */
+bool dc_update_planes_and_stream(struct dc *dc,
+		struct dc_surface_update *surface_updates, int surface_count,
+		struct dc_stream_state *dc_stream,
+		struct dc_stream_update *stream_update);
 
+/*
+ * Set up surface attributes and associate to a stream
+ * The surfaces parameter is an absolute set of all surface active for the stream.
+ * If no surfaces are provided, the stream will be blanked; no memory read.
+ * Any flip related attribute changes must be done through this interface.
+ *
+ * After this call:
+ *   Surfaces attributes are programmed and configured to be composed into stream.
+ *   This does not trigger a flip.  No surface address is programmed.
+ */
 void dc_commit_updates_for_stream(struct dc *dc,
 		struct dc_surface_update *srf_updates,
 		int surface_count,
diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index 471fd6c8135f..27613abeed96 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -1335,7 +1335,7 @@ int exynos_g2d_exec_ioctl(struct drm_device *drm_dev, void *data,
 	/* Let the runqueue know that there is work to do. */
 	queue_work(g2d->g2d_workq, &g2d->runqueue_work);
 
-	if (runqueue_node->async)
+	if (req->async)
 		goto out;
 
 	wait_for_completion(&runqueue_node->complete);
diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index e5662bdcbbde..e96436e11a36 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -468,8 +468,6 @@ static int vidi_remove(struct platform_device *pdev)
 	if (ctx->raw_edid != (struct edid *)fake_edid_info) {
 		kfree(ctx->raw_edid);
 		ctx->raw_edid = NULL;
-
-		return -EINVAL;
 	}
 
 	component_del(&pdev->dev, &vidi_component_ops);
diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index a36a4f2c76b0..57218263ef3b 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -456,7 +456,6 @@ int radeon_gem_set_domain_ioctl(struct drm_device *dev, void *data,
 	struct radeon_device *rdev = dev->dev_private;
 	struct drm_radeon_gem_set_domain *args = data;
 	struct drm_gem_object *gobj;
-	struct radeon_bo *robj;
 	int r;
 
 	/* for now if someone requests domain CPU -
@@ -469,13 +468,12 @@ int radeon_gem_set_domain_ioctl(struct drm_device *dev, void *data,
 		up_read(&rdev->exclusive_lock);
 		return -ENOENT;
 	}
-	robj = gem_to_radeon_bo(gobj);
 
 	r = radeon_gem_set_domain(gobj, args->read_domains, args->write_domain);
 
 	drm_gem_object_put(gobj);
 	up_read(&rdev->exclusive_lock);
-	r = radeon_gem_handle_lockup(robj->rdev, r);
+	r = radeon_gem_handle_lockup(rdev, r);
 	return r;
 }
 
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index d29773a799b4..33e763e746a0 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2425,8 +2425,13 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 		goto fail_quirks;
 	}
 
-	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR)
+	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR) {
 		error = hid_hw_open(hdev);
+		if (error) {
+			hid_err(hdev, "hw open failed\n");
+			goto fail_quirks;
+		}
+	}
 
 	wacom_set_shared_values(wacom_wac);
 	devres_close_group(&hdev->dev, wacom);
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index d8dc5cc5e3a8..62c864f8d991 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -827,11 +827,22 @@ static void vmbus_wait_for_unload(void)
 		if (completion_done(&vmbus_connection.unload_event))
 			goto completed;
 
-		for_each_online_cpu(cpu) {
+		for_each_present_cpu(cpu) {
 			struct hv_per_cpu_context *hv_cpu
 				= per_cpu_ptr(hv_context.cpu_context, cpu);
 
+			/*
+			 * In a CoCo VM the synic_message_page is not allocated
+			 * in hv_synic_alloc(). Instead it is set/cleared in
+			 * hv_synic_enable_regs() and hv_synic_disable_regs()
+			 * such that it is set only when the CPU is online. If
+			 * not all present CPUs are online, the message page
+			 * might be NULL, so skip such CPUs.
+			 */
 			page_addr = hv_cpu->synic_message_page;
+			if (!page_addr)
+				continue;
+
 			msg = (struct hv_message *)page_addr
 				+ VMBUS_MESSAGE_SINT;
 
@@ -865,11 +876,14 @@ static void vmbus_wait_for_unload(void)
 	 * maybe-pending messages on all CPUs to be able to receive new
 	 * messages after we reconnect.
 	 */
-	for_each_online_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
 
 		page_addr = hv_cpu->synic_message_page;
+		if (!page_addr)
+			continue;
+
 		msg = (struct hv_message *)page_addr + VMBUS_MESSAGE_SINT;
 		msg->header.message_type = HVMSG_NONE;
 	}
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index b906a3a7941c..115835bd562c 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1538,7 +1538,7 @@ static int vmbus_bus_init(void)
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online",
 				hv_synic_init, hv_synic_cleanup);
 	if (ret < 0)
-		goto err_cpuhp;
+		goto err_alloc;
 	hyperv_cpuhp_online = ret;
 
 	ret = vmbus_connect();
@@ -1589,9 +1589,8 @@ static int vmbus_bus_init(void)
 
 err_connect:
 	cpuhp_remove_state(hyperv_cpuhp_online);
-err_cpuhp:
-	hv_synic_free();
 err_alloc:
+	hv_synic_free();
 	if (vmbus_irq == -1) {
 		hv_remove_vmbus_handler();
 	} else {
diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index d45ec26d51cb..c688f11ae5c9 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -200,8 +200,8 @@ static void lpi2c_imx_stop(struct lpi2c_imx_struct *lpi2c_imx)
 /* CLKLO = I2C_CLK_RATIO * CLKHI, SETHOLD = CLKHI, DATAVD = CLKHI/2 */
 static int lpi2c_imx_config(struct lpi2c_imx_struct *lpi2c_imx)
 {
-	u8 prescale, filt, sethold, clkhi, clklo, datavd;
-	unsigned int clk_rate, clk_cycle;
+	u8 prescale, filt, sethold, datavd;
+	unsigned int clk_rate, clk_cycle, clkhi, clklo;
 	enum lpi2c_imx_pincfg pincfg;
 	unsigned int temp;
 
diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index 31c02c2019c1..67a134c8448d 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -108,6 +108,27 @@ static const struct dmi_system_id dmi_use_low_level_irq[] = {
 	{} /* Terminating entry */
 };
 
+/*
+ * Some devices have a wrong entry which points to a GPIO which is
+ * required in another driver, so this driver must not claim it.
+ */
+static const struct dmi_system_id dmi_invalid_acpi_index[] = {
+	{
+		/*
+		 * Lenovo Yoga Book X90F / X90L, the PNP0C40 home button entry
+		 * points to a GPIO which is not a home button and which is
+		 * required by the lenovo-yogabook driver.
+		 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "YETI-11"),
+		},
+		.driver_data = (void *)1l,
+	},
+	{} /* Terminating entry */
+};
+
 /*
  * Get the Nth GPIO number from the ACPI object.
  */
@@ -137,6 +158,8 @@ soc_button_device_create(struct platform_device *pdev,
 	struct platform_device *pd;
 	struct gpio_keys_button *gpio_keys;
 	struct gpio_keys_platform_data *gpio_keys_pdata;
+	const struct dmi_system_id *dmi_id;
+	int invalid_acpi_index = -1;
 	int error, gpio, irq;
 	int n_buttons = 0;
 
@@ -154,10 +177,17 @@ soc_button_device_create(struct platform_device *pdev,
 	gpio_keys = (void *)(gpio_keys_pdata + 1);
 	n_buttons = 0;
 
+	dmi_id = dmi_first_match(dmi_invalid_acpi_index);
+	if (dmi_id)
+		invalid_acpi_index = (long)dmi_id->driver_data;
+
 	for (info = button_info; info->name; info++) {
 		if (info->autorepeat != autorepeat)
 			continue;
 
+		if (info->acpi_index == invalid_acpi_index)
+			continue;
+
 		error = soc_button_lookup_gpio(&pdev->dev, info->acpi_index, &gpio, &irq);
 		if (error || irq < 0) {
 			/*
diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index 67776a0d31e8..99ede1417d72 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -1086,7 +1086,8 @@ void cec_received_msg_ts(struct cec_adapter *adap,
 	mutex_lock(&adap->lock);
 	dprintk(2, "%s: %*ph\n", __func__, msg->len, msg->msg);
 
-	adap->last_initiator = 0xff;
+	if (!adap->transmit_in_progress)
+		adap->last_initiator = 0xff;
 
 	/* Check if this message was for us (directed or broadcast). */
 	if (!cec_msg_is_broadcast(msg))
diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 753f9ea254d4..287705729064 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -981,11 +981,8 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (status & (IRQ_END_OF_CHAIN | IRQ_RESP_STATUS)) {
 		if (data && !cmd->error)
 			data->bytes_xfered = data->blksz * data->blocks;
-		if (meson_mmc_bounce_buf_read(data) ||
-		    meson_mmc_get_next_command(cmd))
-			ret = IRQ_WAKE_THREAD;
-		else
-			ret = IRQ_HANDLED;
+
+		return IRQ_WAKE_THREAD;
 	}
 
 out:
@@ -997,9 +994,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 		writel(start, host->regs + SD_EMMC_START);
 	}
 
-	if (ret == IRQ_HANDLED)
-		meson_mmc_request_done(host->mmc, cmd->mrq);
-
 	return ret;
 }
 
@@ -1185,8 +1179,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	}
 
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq <= 0) {
-		ret = -EINVAL;
+	if (host->irq < 0) {
+		ret = host->irq;
 		goto free_host;
 	}
 
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 2c4eda83ca18..090246aa6f03 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1729,7 +1729,8 @@ static void mmci_set_max_busy_timeout(struct mmc_host *mmc)
 		return;
 
 	if (host->variant->busy_timeout && mmc->actual_clock)
-		max_busy_timeout = ~0UL / (mmc->actual_clock / MSEC_PER_SEC);
+		max_busy_timeout = U32_MAX / DIV_ROUND_UP(mmc->actual_clock,
+							  MSEC_PER_SEC);
 
 	mmc->max_busy_timeout = max_busy_timeout;
 }
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 9871c19d2b4e..6d0fc247bddb 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2525,7 +2525,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq < 0) {
-		ret = -EINVAL;
+		ret = host->irq;
 		goto host_free;
 	}
 
diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 629efbe639c4..b4f6a0a2fcb5 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -704,7 +704,7 @@ static int mvsd_probe(struct platform_device *pdev)
 	}
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		return -ENXIO;
+		return irq;
 
 	mmc = mmc_alloc_host(sizeof(struct mvsd_host), &pdev->dev);
 	if (!mmc) {
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 5e5af34090f1..ecf2a68d0e84 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1343,7 +1343,7 @@ static int mmc_omap_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		return -ENXIO;
+		return irq;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->virt_base = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index eb0bd46b7e81..500c906413a7 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1832,9 +1832,11 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	irq = platform_get_irq(pdev, 0);
-	if (res == NULL || irq < 0)
+	if (!res)
 		return -ENXIO;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
 	base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base))
diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
index 3dc143b03939..679b8b0b310e 100644
--- a/drivers/mmc/host/owl-mmc.c
+++ b/drivers/mmc/host/owl-mmc.c
@@ -638,7 +638,7 @@ static int owl_mmc_probe(struct platform_device *pdev)
 
 	owl_host->irq = platform_get_irq(pdev, 0);
 	if (owl_host->irq < 0) {
-		ret = -EINVAL;
+		ret = owl_host->irq;
 		goto err_release_channel;
 	}
 
diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 8fe65f172a61..f4e15eef7045 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -910,7 +910,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	host->ops	= &sdhci_acpi_ops_dflt;
 	host->irq	= platform_get_irq(pdev, 0);
 	if (host->irq < 0) {
-		err = -EINVAL;
+		err = host->irq;
 		goto err_free;
 	}
 
diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 83d38e44fc25..6537a845266d 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2482,6 +2482,9 @@ static inline void sdhci_msm_get_of_property(struct platform_device *pdev,
 		msm_host->ddr_config = DDR_CONFIG_POR_VAL;
 
 	of_property_read_u32(node, "qcom,dll-config", &msm_host->dll_config);
+
+	if (of_device_is_compatible(node, "qcom,msm8916-sdhci"))
+		host->quirks2 |= SDHCI_QUIRK2_BROKEN_64_BIT_DMA;
 }
 
 static int sdhci_msm_gcc_reset(struct device *dev, struct sdhci_host *host)
diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index bcc595c70a9f..e12fe29b275c 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1398,7 +1398,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	irq[0] = platform_get_irq(pdev, 0);
 	irq[1] = platform_get_irq_optional(pdev, 1);
 	if (irq[0] < 0)
-		return -ENXIO;
+		return irq[0];
 
 	reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(reg))
diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 99515be6e5e5..2032e4e1ee68 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1757,8 +1757,10 @@ static int usdhi6_probe(struct platform_device *pdev)
 	irq_cd = platform_get_irq_byname(pdev, "card detect");
 	irq_sd = platform_get_irq_byname(pdev, "data");
 	irq_sdio = platform_get_irq_byname(pdev, "SDIO");
-	if (irq_sd < 0 || irq_sdio < 0)
-		return -ENODEV;
+	if (irq_sd < 0)
+		return irq_sd;
+	if (irq_sdio < 0)
+		return irq_sdio;
 
 	mmc = mmc_alloc_host(sizeof(struct usdhi6_host), dev);
 	if (!mmc)
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 4ec598efc333..f74d9fbd0817 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -993,6 +993,14 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 	mutex_unlock(&priv->reg_mutex);
 }
 
+static void
+mt753x_trap_frames(struct mt7530_priv *priv)
+{
+	/* Trap BPDUs to the CPU port(s) */
+	mt7530_rmw(priv, MT753X_BPC, MT753X_BPDU_PORT_FW_MASK,
+		   MT753X_BPDU_CPU_ONLY);
+}
+
 static int
 mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
 {
@@ -1015,7 +1023,7 @@ mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
 		   UNU_FFP(BIT(port)));
 
 	/* Set CPU port number */
-	if (priv->id == ID_MT7621)
+	if (priv->id == ID_MT7530 || priv->id == ID_MT7621)
 		mt7530_rmw(priv, MT7530_MFC, CPU_MASK, CPU_EN | CPU_PORT(port));
 
 	/* CPU port gets connected to all user ports of
@@ -2194,6 +2202,8 @@ mt7530_setup(struct dsa_switch *ds)
 
 	priv->p6_interface = PHY_INTERFACE_MODE_NA;
 
+	mt753x_trap_frames(priv);
+
 	/* Enable and reset MIB counters */
 	mt7530_mib_reset(ds);
 
@@ -2300,8 +2310,8 @@ mt7531_setup_common(struct dsa_switch *ds)
 			   BIT(cpu_dp->index));
 		break;
 	}
-	mt7530_rmw(priv, MT753X_BPC, MT753X_BPDU_PORT_FW_MASK,
-		   MT753X_BPDU_CPU_ONLY);
+
+	mt753x_trap_frames(priv);
 
 	/* Enable and reset MIB counters */
 	mt7530_mib_reset(ds);
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 361c1c87c183..e874b907bfbd 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1136,8 +1136,8 @@ static struct sk_buff *be_lancer_xmit_workarounds(struct be_adapter *adapter,
 	eth_hdr_len = ntohs(skb->protocol) == ETH_P_8021Q ?
 						VLAN_ETH_HLEN : ETH_HLEN;
 	if (skb->len <= 60 &&
-	    (lancer_chip(adapter) || skb_vlan_tag_present(skb)) &&
-	    is_ipv4_pkt(skb)) {
+	    (lancer_chip(adapter) || BE3_chip(adapter) ||
+	     skb_vlan_tag_present(skb)) && is_ipv4_pkt(skb)) {
 		ip = (struct iphdr *)ip_hdr(skb);
 		pskb_trim(skb, eth_hdr_len + ntohs(ip->tot_len));
 	}
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
index 8427fe1b8fd1..2205bb437e68 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -582,8 +582,7 @@ qcaspi_spi_thread(void *data)
 	while (!kthread_should_stop()) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		if ((qca->intr_req == qca->intr_svc) &&
-		    (qca->txr.skb[qca->txr.head] == NULL) &&
-		    (qca->sync == QCASPI_SYNC_READY))
+		    !qca->txr.skb[qca->txr.head])
 			schedule();
 
 		set_current_state(TASK_RUNNING);
diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index 36f1c5aa98fc..1ab1ba41c430 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -522,7 +522,7 @@ static int hwsim_del_edge_nl(struct sk_buff *msg, struct genl_info *info)
 static int hwsim_set_edge_lqi(struct sk_buff *msg, struct genl_info *info)
 {
 	struct nlattr *edge_attrs[MAC802154_HWSIM_EDGE_ATTR_MAX + 1];
-	struct hwsim_edge_info *einfo;
+	struct hwsim_edge_info *einfo, *einfo_old;
 	struct hwsim_phy *phy_v0;
 	struct hwsim_edge *e;
 	u32 v0, v1;
@@ -560,8 +560,10 @@ static int hwsim_set_edge_lqi(struct sk_buff *msg, struct genl_info *info)
 	list_for_each_entry_rcu(e, &phy_v0->edges, list) {
 		if (e->endpoint->idx == v1) {
 			einfo->lqi = lqi;
-			rcu_assign_pointer(e->info, einfo);
+			einfo_old = rcu_replace_pointer(e->info, einfo,
+							lockdep_is_held(&hwsim_phys_lock));
 			rcu_read_unlock();
+			kfree_rcu(einfo_old, rcu);
 			mutex_unlock(&hwsim_phys_lock);
 			return 0;
 		}
diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 6230dd5e2990..76ca43108d99 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -836,7 +836,7 @@ static int dp83867_phy_reset(struct phy_device *phydev)
 {
 	int err;
 
-	err = phy_write(phydev, DP83867_CTRL, DP83867_SW_RESTART);
+	err = phy_write(phydev, DP83867_CTRL, DP83867_SW_RESET);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/nfc/nfcsim.c b/drivers/nfc/nfcsim.c
index 85bf8d586c70..0f6befe8be1e 100644
--- a/drivers/nfc/nfcsim.c
+++ b/drivers/nfc/nfcsim.c
@@ -336,10 +336,6 @@ static struct dentry *nfcsim_debugfs_root;
 static void nfcsim_debugfs_init(void)
 {
 	nfcsim_debugfs_root = debugfs_create_dir("nfcsim", NULL);
-
-	if (!nfcsim_debugfs_root)
-		pr_err("Could not create debugfs entry\n");
-
 }
 
 static void nfcsim_debugfs_remove(void)
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e5318b38c662..98a7649a0f06 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1247,9 +1247,25 @@ EXPORT_SYMBOL_NS_GPL(nvme_execute_passthru_rq, NVME_TARGET_PASSTHRU);
  *   The host should send Keep Alive commands at half of the Keep Alive Timeout
  *   accounting for transport roundtrip times [..].
  */
+static unsigned long nvme_keep_alive_work_period(struct nvme_ctrl *ctrl)
+{
+	unsigned long delay = ctrl->kato * HZ / 2;
+
+	/*
+	 * When using Traffic Based Keep Alive, we need to run
+	 * nvme_keep_alive_work at twice the normal frequency, as one
+	 * command completion can postpone sending a keep alive command
+	 * by up to twice the delay between runs.
+	 */
+	if (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS)
+		delay /= 2;
+	return delay;
+}
+
 static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
 {
-	queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ / 2);
+	queue_delayed_work(nvme_wq, &ctrl->ka_work,
+			   nvme_keep_alive_work_period(ctrl));
 }
 
 static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 9b54715a4b63..9b15c0130bbb 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -483,7 +483,10 @@ struct hv_pcibus_device {
 	struct fwnode_handle *fwnode;
 	/* Protocol version negotiated with the host */
 	enum pci_protocol_version_t protocol_version;
+
+	struct mutex state_lock;
 	enum hv_pcibus_state state;
+
 	struct hv_device *hdev;
 	resource_size_t low_mmio_space;
 	resource_size_t high_mmio_space;
@@ -547,19 +550,10 @@ struct hv_dr_state {
 	struct hv_pcidev_description func[];
 };
 
-enum hv_pcichild_state {
-	hv_pcichild_init = 0,
-	hv_pcichild_requirements,
-	hv_pcichild_resourced,
-	hv_pcichild_ejecting,
-	hv_pcichild_maximum
-};
-
 struct hv_pci_dev {
 	/* List protected by pci_rescan_remove_lock */
 	struct list_head list_entry;
 	refcount_t refs;
-	enum hv_pcichild_state state;
 	struct pci_slot *pci_slot;
 	struct hv_pcidev_description desc;
 	bool reported_missing;
@@ -1261,6 +1255,11 @@ static void hv_irq_unmask(struct irq_data *data)
 	pbus = pdev->bus;
 	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
 	int_desc = data->chip_data;
+	if (!int_desc) {
+		dev_warn(&hbus->hdev->device, "%s() can not unmask irq %u\n",
+			 __func__, data->irq);
+		return;
+	}
 
 	spin_lock_irqsave(&hbus->retarget_msi_interrupt_lock, flags);
 
@@ -1610,12 +1609,6 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		hv_pci_onchannelcallback(hbus);
 		spin_unlock_irqrestore(&channel->sched_lock, flags);
 
-		if (hpdev->state == hv_pcichild_ejecting) {
-			dev_err_once(&hbus->hdev->device,
-				     "the device is being ejected\n");
-			goto enable_tasklet;
-		}
-
 		udelay(100);
 	}
 
@@ -2201,6 +2194,8 @@ static void pci_devices_present_work(struct work_struct *work)
 	if (!dr)
 		return;
 
+	mutex_lock(&hbus->state_lock);
+
 	/* First, mark all existing children as reported missing. */
 	spin_lock_irqsave(&hbus->device_list_lock, flags);
 	list_for_each_entry(hpdev, &hbus->children, list_entry) {
@@ -2282,6 +2277,8 @@ static void pci_devices_present_work(struct work_struct *work)
 		break;
 	}
 
+	mutex_unlock(&hbus->state_lock);
+
 	kfree(dr);
 }
 
@@ -2430,7 +2427,7 @@ static void hv_eject_device_work(struct work_struct *work)
 	hpdev = container_of(work, struct hv_pci_dev, wrk);
 	hbus = hpdev->hbus;
 
-	WARN_ON(hpdev->state != hv_pcichild_ejecting);
+	mutex_lock(&hbus->state_lock);
 
 	/*
 	 * Ejection can come before or after the PCI bus has been set up, so
@@ -2468,6 +2465,8 @@ static void hv_eject_device_work(struct work_struct *work)
 	put_pcichild(hpdev);
 	put_pcichild(hpdev);
 	/* hpdev has been freed. Do not use it any more. */
+
+	mutex_unlock(&hbus->state_lock);
 }
 
 /**
@@ -2488,7 +2487,6 @@ static void hv_pci_eject_device(struct hv_pci_dev *hpdev)
 		return;
 	}
 
-	hpdev->state = hv_pcichild_ejecting;
 	get_pcichild(hpdev);
 	INIT_WORK(&hpdev->wrk, hv_eject_device_work);
 	queue_work(hbus->wq, &hpdev->wrk);
@@ -2889,8 +2887,10 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
 	struct pci_bus_d0_entry *d0_entry;
 	struct hv_pci_compl comp_pkt;
 	struct pci_packet *pkt;
+	bool retry = true;
 	int ret;
 
+enter_d0_retry:
 	/*
 	 * Tell the host that the bus is ready to use, and moved into the
 	 * powered-on state.  This includes telling the host which region
@@ -2917,6 +2917,38 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
 	if (ret)
 		goto exit;
 
+	/*
+	 * In certain case (Kdump) the pci device of interest was
+	 * not cleanly shut down and resource is still held on host
+	 * side, the host could return invalid device status.
+	 * We need to explicitly request host to release the resource
+	 * and try to enter D0 again.
+	 */
+	if (comp_pkt.completion_status < 0 && retry) {
+		retry = false;
+
+		dev_err(&hdev->device, "Retrying D0 Entry\n");
+
+		/*
+		 * Hv_pci_bus_exit() calls hv_send_resource_released()
+		 * to free up resources of its child devices.
+		 * In the kdump kernel we need to set the
+		 * wslot_res_allocated to 255 so it scans all child
+		 * devices to release resources allocated in the
+		 * normal kernel before panic happened.
+		 */
+		hbus->wslot_res_allocated = 255;
+
+		ret = hv_pci_bus_exit(hdev, true);
+
+		if (ret == 0) {
+			kfree(pkt);
+			goto enter_d0_retry;
+		}
+		dev_err(&hdev->device,
+			"Retrying D0 failed with ret %d\n", ret);
+	}
+
 	if (comp_pkt.completion_status < 0) {
 		dev_err(&hdev->device,
 			"PCI Pass-through VSP failed D0 Entry with status %x\n",
@@ -2959,6 +2991,24 @@ static int hv_pci_query_relations(struct hv_device *hdev)
 	if (!ret)
 		ret = wait_for_response(hdev, &comp);
 
+	/*
+	 * In the case of fast device addition/removal, it's possible that
+	 * vmbus_sendpacket() or wait_for_response() returns -ENODEV but we
+	 * already got a PCI_BUS_RELATIONS* message from the host and the
+	 * channel callback already scheduled a work to hbus->wq, which can be
+	 * running pci_devices_present_work() -> survey_child_resources() ->
+	 * complete(&hbus->survey_event), even after hv_pci_query_relations()
+	 * exits and the stack variable 'comp' is no longer valid; as a result,
+	 * a hang or a page fault may happen when the complete() calls
+	 * raw_spin_lock_irqsave(). Flush hbus->wq before we exit from
+	 * hv_pci_query_relations() to avoid the issues. Note: if 'ret' is
+	 * -ENODEV, there can't be any more work item scheduled to hbus->wq
+	 * after the flush_workqueue(): see vmbus_onoffer_rescind() ->
+	 * vmbus_reset_channel_cb(), vmbus_rescind_cleanup() ->
+	 * channel->rescind = true.
+	 */
+	flush_workqueue(hbus->wq);
+
 	return ret;
 }
 
@@ -3144,7 +3194,6 @@ static int hv_pci_probe(struct hv_device *hdev,
 	struct hv_pcibus_device *hbus;
 	u16 dom_req, dom;
 	char *name;
-	bool enter_d0_retry = true;
 	int ret;
 
 	/*
@@ -3180,6 +3229,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 		return -ENOMEM;
 
 	hbus->bridge = bridge;
+	mutex_init(&hbus->state_lock);
 	hbus->state = hv_pcibus_init;
 	hbus->wslot_res_allocated = -1;
 
@@ -3280,49 +3330,15 @@ static int hv_pci_probe(struct hv_device *hdev,
 	if (ret)
 		goto free_fwnode;
 
-retry:
 	ret = hv_pci_query_relations(hdev);
 	if (ret)
 		goto free_irq_domain;
 
-	ret = hv_pci_enter_d0(hdev);
-	/*
-	 * In certain case (Kdump) the pci device of interest was
-	 * not cleanly shut down and resource is still held on host
-	 * side, the host could return invalid device status.
-	 * We need to explicitly request host to release the resource
-	 * and try to enter D0 again.
-	 * Since the hv_pci_bus_exit() call releases structures
-	 * of all its child devices, we need to start the retry from
-	 * hv_pci_query_relations() call, requesting host to send
-	 * the synchronous child device relations message before this
-	 * information is needed in hv_send_resources_allocated()
-	 * call later.
-	 */
-	if (ret == -EPROTO && enter_d0_retry) {
-		enter_d0_retry = false;
-
-		dev_err(&hdev->device, "Retrying D0 Entry\n");
-
-		/*
-		 * Hv_pci_bus_exit() calls hv_send_resources_released()
-		 * to free up resources of its child devices.
-		 * In the kdump kernel we need to set the
-		 * wslot_res_allocated to 255 so it scans all child
-		 * devices to release resources allocated in the
-		 * normal kernel before panic happened.
-		 */
-		hbus->wslot_res_allocated = 255;
-		ret = hv_pci_bus_exit(hdev, true);
-
-		if (ret == 0)
-			goto retry;
+	mutex_lock(&hbus->state_lock);
 
-		dev_err(&hdev->device,
-			"Retrying D0 failed with ret %d\n", ret);
-	}
+	ret = hv_pci_enter_d0(hdev);
 	if (ret)
-		goto free_irq_domain;
+		goto release_state_lock;
 
 	ret = hv_pci_allocate_bridge_windows(hbus);
 	if (ret)
@@ -3340,12 +3356,15 @@ static int hv_pci_probe(struct hv_device *hdev,
 	if (ret)
 		goto free_windows;
 
+	mutex_unlock(&hbus->state_lock);
 	return 0;
 
 free_windows:
 	hv_pci_free_bridge_windows(hbus);
 exit_d0:
 	(void) hv_pci_bus_exit(hdev, true);
+release_state_lock:
+	mutex_unlock(&hbus->state_lock);
 free_irq_domain:
 	irq_domain_remove(hbus->irq_domain);
 free_fwnode:
@@ -3578,20 +3597,26 @@ static int hv_pci_resume(struct hv_device *hdev)
 	if (ret)
 		goto out;
 
+	mutex_lock(&hbus->state_lock);
+
 	ret = hv_pci_enter_d0(hdev);
 	if (ret)
-		goto out;
+		goto release_state_lock;
 
 	ret = hv_send_resources_allocated(hdev);
 	if (ret)
-		goto out;
+		goto release_state_lock;
 
 	prepopulate_bars(hbus);
 
 	hv_pci_restore_msi_state(hbus);
 
 	hbus->state = hv_pcibus_installed;
+	mutex_unlock(&hbus->state_lock);
 	return 0;
+
+release_state_lock:
+	mutex_unlock(&hbus->state_lock);
 out:
 	vmbus_close(hdev->channel);
 	return ret;
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index b21fa57d1a46..a111154a9046 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1379,6 +1379,7 @@ void ccw_device_set_notoper(struct ccw_device *cdev)
 enum io_sch_action {
 	IO_SCH_UNREG,
 	IO_SCH_ORPH_UNREG,
+	IO_SCH_UNREG_CDEV,
 	IO_SCH_ATTACH,
 	IO_SCH_UNREG_ATTACH,
 	IO_SCH_ORPH_ATTACH,
@@ -1411,7 +1412,7 @@ static enum io_sch_action sch_get_action(struct subchannel *sch)
 	}
 	if ((sch->schib.pmcw.pam & sch->opm) == 0) {
 		if (ccw_device_notify(cdev, CIO_NO_PATH) != NOTIFY_OK)
-			return IO_SCH_UNREG;
+			return IO_SCH_UNREG_CDEV;
 		return IO_SCH_DISC;
 	}
 	if (device_is_disconnected(cdev))
@@ -1473,6 +1474,7 @@ static int io_subchannel_sch_event(struct subchannel *sch, int process)
 	case IO_SCH_ORPH_ATTACH:
 		ccw_device_set_disconnected(cdev);
 		break;
+	case IO_SCH_UNREG_CDEV:
 	case IO_SCH_UNREG_ATTACH:
 	case IO_SCH_UNREG:
 		if (!cdev)
@@ -1506,6 +1508,7 @@ static int io_subchannel_sch_event(struct subchannel *sch, int process)
 		if (rc)
 			goto out;
 		break;
+	case IO_SCH_UNREG_CDEV:
 	case IO_SCH_UNREG_ATTACH:
 		spin_lock_irqsave(sch->lock, flags);
 		sch_set_cdev(sch, NULL);
diff --git a/drivers/soundwire/dmi-quirks.c b/drivers/soundwire/dmi-quirks.c
index 2bf534632f64..39f0cc2a5b33 100644
--- a/drivers/soundwire/dmi-quirks.c
+++ b/drivers/soundwire/dmi-quirks.c
@@ -63,6 +63,13 @@ static const struct dmi_system_id adr_remap_quirk_table[] = {
 		},
 		.driver_data = (void *)intel_tgl_bios,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8709"),
+		},
+		.driver_data = (void *)intel_tgl_bios,
+	},
 	{
 		/* quirk used for NUC15 'Bishop County' LAPBC510 and LAPBC710 skews */
 		.matches = {
diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 5d98611dd999..c5ff6e8c45be 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -906,9 +906,14 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	ret = fsl_lpspi_dma_init(&pdev->dev, fsl_lpspi, controller);
 	if (ret == -EPROBE_DEFER)
 		goto out_pm_get;
-
 	if (ret < 0)
 		dev_err(&pdev->dev, "dma setup error %d, use pio\n", ret);
+	else
+		/*
+		 * disable LPSPI module IRQ when enable DMA mode successfully,
+		 * to prevent the unexpected LPSPI module IRQ events.
+		 */
+		disable_irq(irq);
 
 	ret = devm_spi_register_controller(&pdev->dev, controller);
 	if (ret < 0) {
diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
index c0ed6f8e5c5b..32a2852352db 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -1071,6 +1071,7 @@ int iscsi_target_locate_portal(
 	iscsi_target_set_sock_callbacks(conn);
 
 	login->np = np;
+	conn->tpg = NULL;
 
 	login_req = (struct iscsi_login_req *) login->req;
 	payload_length = ntoh24(login_req->dlength);
@@ -1138,7 +1139,6 @@ int iscsi_target_locate_portal(
 	 */
 	sessiontype = strncmp(s_buf, DISCOVERY, 9);
 	if (!sessiontype) {
-		conn->tpg = iscsit_global->discovery_tpg;
 		if (!login->leading_connection)
 			goto get_target;
 
@@ -1155,9 +1155,11 @@ int iscsi_target_locate_portal(
 		 * Serialize access across the discovery struct iscsi_portal_group to
 		 * process login attempt.
 		 */
+		conn->tpg = iscsit_global->discovery_tpg;
 		if (iscsit_access_np(np, conn->tpg) < 0) {
 			iscsit_tx_login_rsp(conn, ISCSI_STATUS_CLS_TARGET_ERR,
 				ISCSI_LOGIN_STATUS_SVC_UNAVAILABLE);
+			conn->tpg = NULL;
 			ret = -1;
 			goto out;
 		}
diff --git a/drivers/usb/gadget/udc/amd5536udc_pci.c b/drivers/usb/gadget/udc/amd5536udc_pci.c
index c80f9bd51b75..a36913ae31f9 100644
--- a/drivers/usb/gadget/udc/amd5536udc_pci.c
+++ b/drivers/usb/gadget/udc/amd5536udc_pci.c
@@ -170,6 +170,9 @@ static int udc_pci_probe(
 		retval = -ENODEV;
 		goto err_probe;
 	}
+
+	udc = dev;
+
 	return 0;
 
 err_probe:
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 32148f011200..00f10d340259 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -933,13 +933,18 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
 
 		err = sock->ops->sendmsg(sock, &msg, len);
 		if (unlikely(err < 0)) {
+			bool retry = err == -EAGAIN || err == -ENOMEM || err == -ENOBUFS;
+
 			if (zcopy_used) {
 				if (vq->heads[ubuf->desc].len == VHOST_DMA_IN_PROGRESS)
 					vhost_net_ubuf_put(ubufs);
-				nvq->upend_idx = ((unsigned)nvq->upend_idx - 1)
-					% UIO_MAXIOV;
+				if (retry)
+					nvq->upend_idx = ((unsigned)nvq->upend_idx - 1)
+						% UIO_MAXIOV;
+				else
+					vq->heads[ubuf->desc].len = VHOST_DMA_DONE_LEN;
 			}
-			if (err == -EAGAIN || err == -ENOMEM || err == -ENOBUFS) {
+			if (retry) {
 				vhost_discard_vq_desc(vq, 1);
 				vhost_net_enable_vq(net, vq);
 				break;
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index d1a148f0cae3..81992b9a219b 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -369,7 +369,15 @@ void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent)
 			struct page *page = pvec.pages[i];
 
 			lock_page(page);
-			nilfs_clear_dirty_page(page, silent);
+
+			/*
+			 * This page may have been removed from the address
+			 * space by truncation or invalidation when the lock
+			 * was acquired.  Skip processing in that case.
+			 */
+			if (likely(page->mapping == mapping))
+				nilfs_clear_dirty_page(page, silent);
+
 			unlock_page(page);
 		}
 		pagevec_release(&pvec);
diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
index 56872e93823d..5e845eea1af0 100644
--- a/fs/nilfs2/segbuf.c
+++ b/fs/nilfs2/segbuf.c
@@ -101,6 +101,12 @@ int nilfs_segbuf_extend_segsum(struct nilfs_segment_buffer *segbuf)
 	if (unlikely(!bh))
 		return -ENOMEM;
 
+	lock_buffer(bh);
+	if (!buffer_uptodate(bh)) {
+		memset(bh->b_data, 0, bh->b_size);
+		set_buffer_uptodate(bh);
+	}
+	unlock_buffer(bh);
 	nilfs_segbuf_add_segsum_buffer(segbuf, bh);
 	return 0;
 }
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index c25f28094508..5c310eb7dd0c 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -979,10 +979,13 @@ static void nilfs_segctor_fill_in_super_root(struct nilfs_sc_info *sci,
 	unsigned int isz, srsz;
 
 	bh_sr = NILFS_LAST_SEGBUF(&sci->sc_segbufs)->sb_super_root;
+
+	lock_buffer(bh_sr);
 	raw_sr = (struct nilfs_super_root *)bh_sr->b_data;
 	isz = nilfs->ns_inode_size;
 	srsz = NILFS_SR_BYTES(isz);
 
+	raw_sr->sr_sum = 0;  /* Ensure initialization within this update */
 	raw_sr->sr_bytes = cpu_to_le16(srsz);
 	raw_sr->sr_nongc_ctime
 		= cpu_to_le64(nilfs_doing_gc() ?
@@ -996,6 +999,8 @@ static void nilfs_segctor_fill_in_super_root(struct nilfs_sc_info *sci,
 	nilfs_write_inode_common(nilfs->ns_sufile, (void *)raw_sr +
 				 NILFS_SR_SUFILE_OFFSET(isz), 1);
 	memset((void *)raw_sr + srsz, 0, nilfs->ns_blocksize - srsz);
+	set_buffer_uptodate(bh_sr);
+	unlock_buffer(bh_sr);
 }
 
 static void nilfs_redirty_inodes(struct list_head *head)
@@ -1778,6 +1783,7 @@ static void nilfs_abort_logs(struct list_head *logs, int err)
 	list_for_each_entry(segbuf, logs, sb_list) {
 		list_for_each_entry(bh, &segbuf->sb_segsum_buffers,
 				    b_assoc_buffers) {
+			clear_buffer_uptodate(bh);
 			if (bh->b_page != bd_page) {
 				if (bd_page)
 					end_page_writeback(bd_page);
@@ -1789,6 +1795,7 @@ static void nilfs_abort_logs(struct list_head *logs, int err)
 				    b_assoc_buffers) {
 			clear_buffer_async_write(bh);
 			if (bh == segbuf->sb_super_root) {
+				clear_buffer_uptodate(bh);
 				if (bh->b_page != bd_page) {
 					end_page_writeback(bd_page);
 					bd_page = bh->b_page;
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 9d5e4ce7426b..130ffa8a9bed 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -372,10 +372,31 @@ static int nilfs_move_2nd_super(struct super_block *sb, loff_t sb2off)
 		goto out;
 	}
 	nsbp = (void *)nsbh->b_data + offset;
-	memset(nsbp, 0, nilfs->ns_blocksize);
 
+	lock_buffer(nsbh);
 	if (sb2i >= 0) {
+		/*
+		 * The position of the second superblock only changes by 4KiB,
+		 * which is larger than the maximum superblock data size
+		 * (= 1KiB), so there is no need to use memmove() to allow
+		 * overlap between source and destination.
+		 */
 		memcpy(nsbp, nilfs->ns_sbp[sb2i], nilfs->ns_sbsize);
+
+		/*
+		 * Zero fill after copy to avoid overwriting in case of move
+		 * within the same block.
+		 */
+		memset(nsbh->b_data, 0, offset);
+		memset((void *)nsbp + nilfs->ns_sbsize, 0,
+		       nsbh->b_size - offset - nilfs->ns_sbsize);
+	} else {
+		memset(nsbh->b_data, 0, nsbh->b_size);
+	}
+	set_buffer_uptodate(nsbh);
+	unlock_buffer(nsbh);
+
+	if (sb2i >= 0) {
 		brelse(nilfs->ns_sbh[sb2i]);
 		nilfs->ns_sbh[sb2i] = nsbh;
 		nilfs->ns_sbp[sb2i] = nsbp;
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index fa02e3ff0faf..9d45a6001bc0 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -749,6 +749,7 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 						     acpi_event_status
 						     *event_status))
 ACPI_HW_DEPENDENT_RETURN_UINT32(u32 acpi_dispatch_gpe(acpi_handle gpe_device, u32 gpe_number))
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_hw_disable_all_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_disable_all_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_runtime_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_wakeup_gpes(void))
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 11c26ae7b4fa..65df2ce96f0b 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -168,11 +168,18 @@ struct gpio_irq_chip {
 
 	/**
 	 * @parent_handler_data:
+	 * @parent_handler_data_array:
 	 *
 	 * Data associated, and passed to, the handler for the parent
-	 * interrupt.
+	 * interrupt. Can either be a single pointer if @per_parent_data
+	 * is false, or an array of @num_parents pointers otherwise.  If
+	 * @per_parent_data is true, @parent_handler_data_array cannot be
+	 * NULL.
 	 */
-	void *parent_handler_data;
+	union {
+		void *parent_handler_data;
+		void **parent_handler_data_array;
+	};
 
 	/**
 	 * @num_parents:
@@ -203,6 +210,14 @@ struct gpio_irq_chip {
 	 */
 	bool threaded;
 
+	/**
+	 * @per_parent_data:
+	 *
+	 * True if parent_handler_data_array describes a @num_parents
+	 * sized array to be used as parent data.
+	 */
+	bool per_parent_data;
+
 	/**
 	 * @init_hw: optional routine to initialize hardware before
 	 * an IRQ chip will be added. This is quite useful when
diff --git a/include/linux/regulator/pca9450.h b/include/linux/regulator/pca9450.h
index 71902f41c919..0c3edff6bdff 100644
--- a/include/linux/regulator/pca9450.h
+++ b/include/linux/regulator/pca9450.h
@@ -196,11 +196,11 @@ enum {
 
 /* PCA9450_REG_LDO3_VOLT bits */
 #define LDO3_EN_MASK			0xC0
-#define LDO3OUT_MASK			0x0F
+#define LDO3OUT_MASK			0x1F
 
 /* PCA9450_REG_LDO4_VOLT bits */
 #define LDO4_EN_MASK			0xC0
-#define LDO4OUT_MASK			0x0F
+#define LDO4OUT_MASK			0x1F
 
 /* PCA9450_REG_LDO5_VOLT bits */
 #define LDO5L_EN_MASK			0xC0
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 37d5d4968e20..4eb0edc6640d 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -377,9 +377,11 @@ static inline int ip_tunnel_encap(struct sk_buff *skb, struct ip_tunnel *t,
 static inline u8 ip_tunnel_get_dsfield(const struct iphdr *iph,
 				       const struct sk_buff *skb)
 {
-	if (skb->protocol == htons(ETH_P_IP))
+	__be16 payload_protocol = skb_protocol(skb, true);
+
+	if (payload_protocol == htons(ETH_P_IP))
 		return iph->tos;
-	else if (skb->protocol == htons(ETH_P_IPV6))
+	else if (payload_protocol == htons(ETH_P_IPV6))
 		return ipv6_get_dsfield((const struct ipv6hdr *)iph);
 	else
 		return 0;
@@ -388,9 +390,11 @@ static inline u8 ip_tunnel_get_dsfield(const struct iphdr *iph,
 static inline u8 ip_tunnel_get_ttl(const struct iphdr *iph,
 				       const struct sk_buff *skb)
 {
-	if (skb->protocol == htons(ETH_P_IP))
+	__be16 payload_protocol = skb_protocol(skb, true);
+
+	if (payload_protocol == htons(ETH_P_IP))
 		return iph->ttl;
-	else if (skb->protocol == htons(ETH_P_IPV6))
+	else if (payload_protocol == htons(ETH_P_IPV6))
 		return ((const struct ipv6hdr *)iph)->hop_limit;
 	else
 		return 0;
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 8bac5a5ca0f1..7da74b9428b9 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -863,6 +863,7 @@ struct nft_expr_type {
 
 enum nft_trans_phase {
 	NFT_TRANS_PREPARE,
+	NFT_TRANS_PREPARE_ERROR,
 	NFT_TRANS_ABORT,
 	NFT_TRANS_COMMIT,
 	NFT_TRANS_RELEASE
@@ -968,7 +969,10 @@ static inline struct nft_userdata *nft_userdata(const struct nft_rule *rule)
 	return (void *)&rule->data[rule->dlen];
 }
 
-void nf_tables_rule_release(const struct nft_ctx *ctx, struct nft_rule *rule);
+void nft_rule_expr_activate(const struct nft_ctx *ctx, struct nft_rule *rule);
+void nft_rule_expr_deactivate(const struct nft_ctx *ctx, struct nft_rule *rule,
+			      enum nft_trans_phase phase);
+void nf_tables_rule_destroy(const struct nft_ctx *ctx, struct nft_rule *rule);
 
 static inline void nft_set_elem_update_expr(const struct nft_set_ext *ext,
 					    struct nft_regs *regs,
@@ -1037,6 +1041,8 @@ int nft_setelem_validate(const struct nft_ctx *ctx, struct nft_set *set,
 			 const struct nft_set_iter *iter,
 			 struct nft_set_elem *elem);
 int nft_set_catchall_validate(const struct nft_ctx *ctx, struct nft_set *set);
+int nf_tables_bind_chain(const struct nft_ctx *ctx, struct nft_chain *chain);
+void nf_tables_unbind_chain(const struct nft_ctx *ctx, struct nft_chain *chain);
 
 enum nft_chain_types {
 	NFT_CHAIN_T_DEFAULT = 0,
@@ -1073,11 +1079,17 @@ int nft_chain_validate_dependency(const struct nft_chain *chain,
 int nft_chain_validate_hooks(const struct nft_chain *chain,
                              unsigned int hook_flags);
 
+static inline bool nft_chain_binding(const struct nft_chain *chain)
+{
+	return chain->flags & NFT_CHAIN_BINDING;
+}
+
 static inline bool nft_chain_is_bound(struct nft_chain *chain)
 {
 	return (chain->flags & NFT_CHAIN_BINDING) && chain->bound;
 }
 
+int nft_chain_add(struct nft_table *table, struct nft_chain *chain);
 void nft_chain_del(struct nft_chain *chain);
 void nf_tables_chain_destroy(struct nft_ctx *ctx);
 
@@ -1491,6 +1503,7 @@ static inline void nft_set_elem_clear_busy(struct nft_set_ext *ext)
  *	struct nft_trans - nf_tables object update in transaction
  *
  *	@list: used internally
+ *	@binding_list: list of objects with possible bindings
  *	@msg_type: message type
  *	@put_net: ctx->net needs to be put
  *	@ctx: transaction context
@@ -1498,6 +1511,7 @@ static inline void nft_set_elem_clear_busy(struct nft_set_ext *ext)
  */
 struct nft_trans {
 	struct list_head		list;
+	struct list_head		binding_list;
 	int				msg_type;
 	bool				put_net;
 	struct nft_ctx			ctx;
@@ -1508,6 +1522,7 @@ struct nft_trans_rule {
 	struct nft_rule			*rule;
 	struct nft_flow_rule		*flow;
 	u32				rule_id;
+	bool				bound;
 };
 
 #define nft_trans_rule(trans)	\
@@ -1516,6 +1531,8 @@ struct nft_trans_rule {
 	(((struct nft_trans_rule *)trans->data)->flow)
 #define nft_trans_rule_id(trans)	\
 	(((struct nft_trans_rule *)trans->data)->rule_id)
+#define nft_trans_rule_bound(trans)	\
+	(((struct nft_trans_rule *)trans->data)->bound)
 
 struct nft_trans_set {
 	struct nft_set			*set;
@@ -1540,13 +1557,17 @@ struct nft_trans_set {
 	(((struct nft_trans_set *)trans->data)->gc_int)
 
 struct nft_trans_chain {
+	struct nft_chain		*chain;
 	bool				update;
 	char				*name;
 	struct nft_stats __percpu	*stats;
 	u8				policy;
+	bool				bound;
 	u32				chain_id;
 };
 
+#define nft_trans_chain(trans)	\
+	(((struct nft_trans_chain *)trans->data)->chain)
 #define nft_trans_chain_update(trans)	\
 	(((struct nft_trans_chain *)trans->data)->update)
 #define nft_trans_chain_name(trans)	\
@@ -1555,6 +1576,8 @@ struct nft_trans_chain {
 	(((struct nft_trans_chain *)trans->data)->stats)
 #define nft_trans_chain_policy(trans)	\
 	(((struct nft_trans_chain *)trans->data)->policy)
+#define nft_trans_chain_bound(trans)	\
+	(((struct nft_trans_chain *)trans->data)->bound)
 #define nft_trans_chain_id(trans)	\
 	(((struct nft_trans_chain *)trans->data)->chain_id)
 
@@ -1627,6 +1650,7 @@ static inline int nft_request_module(struct net *net, const char *fmt, ...) { re
 struct nftables_pernet {
 	struct list_head	tables;
 	struct list_head	commit_list;
+	struct list_head	binding_list;
 	struct list_head	module_list;
 	struct list_head	notify_list;
 	struct mutex		commit_mutex;
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 73030094c6e6..6156ed2950f9 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1026,6 +1026,7 @@ struct xfrm_offload {
 struct sec_path {
 	int			len;
 	int			olen;
+	int			verified_cnt;
 
 	struct xfrm_state	*xvec[XFRM_MAX_DEPTH];
 	struct xfrm_offload	ovec[XFRM_MAX_OFFLOAD_DEPTH];
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 840d1ba84cf5..9d8303a93a36 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -68,7 +68,7 @@ DECLARE_EVENT_CLASS(writeback_page_template,
 		strscpy_pad(__entry->name,
 			    bdi_dev_name(mapping ? inode_to_bdi(mapping->host) :
 					 NULL), 32);
-		__entry->ino = mapping ? mapping->host->i_ino : 0;
+		__entry->ino = (mapping && mapping->host) ? mapping->host->i_ino : 0;
 		__entry->index = page->index;
 	),
 
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 1d8adc57a44a..cbfc9bbe87b0 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -581,6 +581,7 @@ struct io_sr_msg {
 	size_t				len;
 	size_t				done_io;
 	struct io_buffer		*kbuf;
+	void __user			*msg_control;
 };
 
 struct io_open {
@@ -4864,10 +4865,16 @@ static int io_setup_async_msg(struct io_kiocb *req,
 static int io_sendmsg_copy_hdr(struct io_kiocb *req,
 			       struct io_async_msghdr *iomsg)
 {
+	struct io_sr_msg *sr = &req->sr_msg;
+	int ret;
+
 	iomsg->msg.msg_name = &iomsg->addr;
 	iomsg->free_iov = iomsg->fast_iov;
-	return sendmsg_copy_msghdr(&iomsg->msg, req->sr_msg.umsg,
+	ret = sendmsg_copy_msghdr(&iomsg->msg, req->sr_msg.umsg,
 				   req->sr_msg.msg_flags, &iomsg->free_iov);
+	/* save msg_control as sys_sendmsg() overwrites it */
+	sr->msg_control = iomsg->msg.msg_control;
+	return ret;
 }
 
 static int io_sendmsg_prep_async(struct io_kiocb *req)
@@ -4924,6 +4931,8 @@ static int io_sendmsg(struct io_kiocb *req, unsigned int issue_flags)
 		if (ret)
 			return ret;
 		kmsg = &iomsg;
+	} else {
+		kmsg->msg.msg_control = sr->msg_control;
 	}
 
 	flags = req->sr_msg.msg_flags;
@@ -4940,6 +4949,8 @@ static int io_sendmsg(struct io_kiocb *req, unsigned int issue_flags)
 		if (ret == -ERESTARTSYS)
 			ret = -EINTR;
 		if (ret > 0 && io_net_retry(sock, flags)) {
+			kmsg->msg.msg_controllen = 0;
+			kmsg->msg.msg_control = NULL;
 			sr->done_io += ret;
 			req->flags |= REQ_F_PARTIAL_IO;
 			return io_setup_async_msg(req, kmsg);
@@ -5190,7 +5201,7 @@ static int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 	flags = req->sr_msg.msg_flags;
 	if (force_nonblock)
 		flags |= MSG_DONTWAIT;
-	if (flags & MSG_WAITALL)
+	if (flags & MSG_WAITALL && !kmsg->msg.msg_controllen)
 		min_ret = iov_iter_count(&kmsg->msg.msg_iter);
 
 	ret = __sys_recvmsg_sock(sock, &kmsg->msg, req->sr_msg.umsg,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6c7126de5c17..5d4bea53ac1f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -633,13 +633,12 @@ static bool btf_name_offset_valid(const struct btf *btf, u32 offset)
 	return offset < btf->hdr.str_len;
 }
 
-static bool __btf_name_char_ok(char c, bool first, bool dot_ok)
+static bool __btf_name_char_ok(char c, bool first)
 {
 	if ((first ? !isalpha(c) :
 		     !isalnum(c)) &&
 	    c != '_' &&
-	    ((c == '.' && !dot_ok) ||
-	      c != '.'))
+	    c != '.')
 		return false;
 	return true;
 }
@@ -656,20 +655,20 @@ static const char *btf_str_by_offset(const struct btf *btf, u32 offset)
 	return NULL;
 }
 
-static bool __btf_name_valid(const struct btf *btf, u32 offset, bool dot_ok)
+static bool __btf_name_valid(const struct btf *btf, u32 offset)
 {
 	/* offset must be valid */
 	const char *src = btf_str_by_offset(btf, offset);
 	const char *src_limit;
 
-	if (!__btf_name_char_ok(*src, true, dot_ok))
+	if (!__btf_name_char_ok(*src, true))
 		return false;
 
 	/* set a limit on identifier length */
 	src_limit = src + KSYM_NAME_LEN;
 	src++;
 	while (*src && src < src_limit) {
-		if (!__btf_name_char_ok(*src, false, dot_ok))
+		if (!__btf_name_char_ok(*src, false))
 			return false;
 		src++;
 	}
@@ -677,17 +676,14 @@ static bool __btf_name_valid(const struct btf *btf, u32 offset, bool dot_ok)
 	return !*src;
 }
 
-/* Only C-style identifier is permitted. This can be relaxed if
- * necessary.
- */
 static bool btf_name_valid_identifier(const struct btf *btf, u32 offset)
 {
-	return __btf_name_valid(btf, offset, false);
+	return __btf_name_valid(btf, offset);
 }
 
 static bool btf_name_valid_section(const struct btf *btf, u32 offset)
 {
-	return __btf_name_valid(btf, offset, true);
+	return __btf_name_valid(btf, offset);
 }
 
 static const char *__btf_name_by_offset(const struct btf *btf, u32 offset)
@@ -3536,7 +3532,7 @@ static s32 btf_var_check_meta(struct btf_verifier_env *env,
 	}
 
 	if (!t->name_off ||
-	    !__btf_name_valid(env->btf, t->name_off, true)) {
+	    !__btf_name_valid(env->btf, t->name_off)) {
 		btf_verifier_log_type(env, t, "Invalid name");
 		return -EINVAL;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 27fd331aefe5..4f2271f27a1d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2659,6 +2659,11 @@ static void save_register_state(struct bpf_func_state *state,
 		scrub_spilled_slot(&state->stack[spi].slot_type[i - 1]);
 }
 
+static bool is_bpf_st_mem(struct bpf_insn *insn)
+{
+	return BPF_CLASS(insn->code) == BPF_ST && BPF_MODE(insn->code) == BPF_MEM;
+}
+
 /* check_stack_{read,write}_fixed_off functions track spill/fill of registers,
  * stack boundary and alignment are checked in check_mem_access()
  */
@@ -2670,8 +2675,9 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 {
 	struct bpf_func_state *cur; /* state of the current function */
 	int i, slot = -off - 1, spi = slot / BPF_REG_SIZE, err;
-	u32 dst_reg = env->prog->insnsi[insn_idx].dst_reg;
+	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
 	struct bpf_reg_state *reg = NULL;
+	u32 dst_reg = insn->dst_reg;
 
 	err = grow_stack_state(state, round_up(slot + 1, BPF_REG_SIZE));
 	if (err)
@@ -2719,6 +2725,16 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 				return err;
 		}
 		save_register_state(state, spi, reg, size);
+		/* Break the relation on a narrowing spill. */
+		if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
+			state->stack[spi].spilled_ptr.id = 0;
+	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
+		   insn->imm != 0 && env->bpf_capable) {
+		struct bpf_reg_state fake_reg = {};
+
+		__mark_reg_known(&fake_reg, (u32)insn->imm);
+		fake_reg.type = SCALAR_VALUE;
+		save_register_state(state, spi, &fake_reg, size);
 	} else if (reg && is_spillable_regtype(reg->type)) {
 		/* register containing pointer is being spilled into stack */
 		if (size != BPF_REG_SIZE) {
@@ -2753,7 +2769,8 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 			state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
 
 		/* when we zero initialize stack slots mark them as such */
-		if (reg && register_is_null(reg)) {
+		if ((reg && register_is_null(reg)) ||
+		    (!reg && is_bpf_st_mem(insn) && insn->imm == 0)) {
 			/* backtracking doesn't work for STACK_ZERO yet. */
 			err = mark_chain_precision(env, value_regno);
 			if (err)
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index edae2f49f73f..6ccdbce17399 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1741,7 +1741,7 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 {
 	struct cgroup *dcgrp = &dst_root->cgrp;
 	struct cgroup_subsys *ss;
-	int ssid, i, ret;
+	int ssid, ret;
 	u16 dfl_disable_ss_mask = 0;
 
 	lockdep_assert_held(&cgroup_mutex);
@@ -1785,7 +1785,8 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		struct cgroup_root *src_root = ss->root;
 		struct cgroup *scgrp = &src_root->cgrp;
 		struct cgroup_subsys_state *css = cgroup_css(scgrp, ss);
-		struct css_set *cset;
+		struct css_set *cset, *cset_pos;
+		struct css_task_iter *it;
 
 		WARN_ON(!css || cgroup_css(dcgrp, ss));
 
@@ -1803,9 +1804,22 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		css->cgroup = dcgrp;
 
 		spin_lock_irq(&css_set_lock);
-		hash_for_each(css_set_table, i, cset, hlist)
+		WARN_ON(!list_empty(&dcgrp->e_csets[ss->id]));
+		list_for_each_entry_safe(cset, cset_pos, &scgrp->e_csets[ss->id],
+					 e_cset_node[ss->id]) {
 			list_move_tail(&cset->e_cset_node[ss->id],
 				       &dcgrp->e_csets[ss->id]);
+			/*
+			 * all css_sets of scgrp together in same order to dcgrp,
+			 * patch in-flight iterators to preserve correct iteration.
+			 * since the iterator is always advanced right away and
+			 * finished when it->cset_pos meets it->cset_head, so only
+			 * update it->cset_head is enough here.
+			 */
+			list_for_each_entry(it, &cset->task_iters, iters_node)
+				if (it->cset_head == &scgrp->e_csets[ss->id])
+					it->cset_head = &dcgrp->e_csets[ss->id];
+		}
 		spin_unlock_irq(&css_set_lock);
 
 		if (ss->css_rstat_flush) {
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 65b8658da829..e9138cd7a0f5 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -218,19 +218,8 @@ static void tick_setup_device(struct tick_device *td,
 		 * this cpu:
 		 */
 		if (tick_do_timer_cpu == TICK_DO_TIMER_BOOT) {
-			ktime_t next_p;
-			u32 rem;
-
 			tick_do_timer_cpu = cpu;
-
-			next_p = ktime_get();
-			div_u64_rem(next_p, TICK_NSEC, &rem);
-			if (rem) {
-				next_p -= rem;
-				next_p += TICK_NSEC;
-			}
-
-			tick_next_period = next_p;
+			tick_next_period = ktime_get();
 #ifdef CONFIG_NO_HZ_FULL
 			/*
 			 * The boot CPU may be nohz_full, in which case set
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index e014927c82e7..f42d0776bc84 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -161,8 +161,19 @@ static ktime_t tick_init_jiffy_update(void)
 	raw_spin_lock(&jiffies_lock);
 	write_seqcount_begin(&jiffies_seq);
 	/* Did we start the jiffies update yet ? */
-	if (last_jiffies_update == 0)
+	if (last_jiffies_update == 0) {
+		u32 rem;
+
+		/*
+		 * Ensure that the tick is aligned to a multiple of
+		 * TICK_NSEC.
+		 */
+		div_u64_rem(tick_next_period, TICK_NSEC, &rem);
+		if (rem)
+			tick_next_period += TICK_NSEC - rem;
+
 		last_jiffies_update = tick_next_period;
+	}
 	period = last_jiffies_update;
 	write_seqcount_end(&jiffies_seq);
 	raw_spin_unlock(&jiffies_lock);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f8b5abd6e36c..0202f23ae960 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2175,10 +2175,12 @@ void tracing_reset_online_cpus(struct array_buffer *buf)
 }
 
 /* Must have trace_types_lock held */
-void tracing_reset_all_online_cpus(void)
+void tracing_reset_all_online_cpus_unlocked(void)
 {
 	struct trace_array *tr;
 
+	lockdep_assert_held(&trace_types_lock);
+
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
 		if (!tr->clear_trace)
 			continue;
@@ -2190,6 +2192,13 @@ void tracing_reset_all_online_cpus(void)
 	}
 }
 
+void tracing_reset_all_online_cpus(void)
+{
+	mutex_lock(&trace_types_lock);
+	tracing_reset_all_online_cpus_unlocked();
+	mutex_unlock(&trace_types_lock);
+}
+
 /*
  * The tgid_map array maps from pid to tgid; i.e. the value stored at index i
  * is the tgid last observed corresponding to pid=i.
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 66b6c8395fbc..2c3d9b6ce148 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -580,6 +580,7 @@ int tracing_is_enabled(void);
 void tracing_reset_online_cpus(struct array_buffer *buf);
 void tracing_reset_current(int cpu);
 void tracing_reset_all_online_cpus(void);
+void tracing_reset_all_online_cpus_unlocked(void);
 int tracing_open_generic(struct inode *inode, struct file *filp);
 int tracing_open_generic_tr(struct inode *inode, struct file *filp);
 bool tracing_is_disabled(void);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 1aadc9a6487b..160298d285c0 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2974,7 +2974,7 @@ static void trace_module_remove_events(struct module *mod)
 	 * over from this module may be passed to the new module events and
 	 * unexpected results may occur.
 	 */
-	tracing_reset_all_online_cpus();
+	tracing_reset_all_online_cpus_unlocked();
 }
 
 static int trace_module_notify(struct notifier_block *self,
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 2fdf3fd591e1..08c7df42ade7 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1416,7 +1416,6 @@ int synth_event_delete(const char *event_name)
 	mutex_unlock(&event_mutex);
 
 	if (mod) {
-		mutex_lock(&trace_types_lock);
 		/*
 		 * It is safest to reset the ring buffer if the module
 		 * being unloaded registered any events that were
@@ -1428,7 +1427,6 @@ int synth_event_delete(const char *event_name)
 		 * occur.
 		 */
 		tracing_reset_all_online_cpus();
-		mutex_unlock(&trace_types_lock);
 	}
 
 	return ret;
diff --git a/mm/memfd.c b/mm/memfd.c
index 475d095dd7f5..a73af8be9c28 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -330,7 +330,8 @@ SYSCALL_DEFINE2(memfd_create,
 
 	if (flags & MFD_ALLOW_SEALING) {
 		file_seals = memfd_file_seals_ptr(file);
-		*file_seals &= ~F_SEAL_SEAL;
+		if (file_seals)
+			*file_seals &= ~F_SEAL_SEAL;
 	}
 
 	fd_install(fd, file);
diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index 2ddba1e2cf22..ab6fe94b8fd9 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -337,6 +337,9 @@ static int esp_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features_
 
 	secpath_reset(skb);
 
+	if (skb_needs_linearize(skb, skb->dev->features) &&
+	    __skb_linearize(skb))
+		return -ENOMEM;
 	return 0;
 }
 
diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index ad2afeef4f10..eac206a290d0 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -164,6 +164,7 @@ int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
 	kfree_skb(skb);
 	return 0;
 }
+EXPORT_SYMBOL(xfrm4_udp_encap_rcv);
 
 int xfrm4_rcv(struct sk_buff *skb)
 {
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 4cc19acfc369..6b30f34c7978 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -372,6 +372,9 @@ static int esp6_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features
 
 	secpath_reset(skb);
 
+	if (skb_needs_linearize(skb, skb->dev->features) &&
+	    __skb_linearize(skb))
+		return -ENOMEM;
 	return 0;
 }
 
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index 04cbeefd8982..4907ab241d6b 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -86,6 +86,9 @@ int xfrm6_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
 	__be32 *udpdata32;
 	__u16 encap_type = up->encap_type;
 
+	if (skb->protocol == htons(ETH_P_IP))
+		return xfrm4_udp_encap_rcv(sk, skb);
+
 	/* if this is not encapsulated socket, then just return now */
 	if (!encap_type)
 		return 1;
diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index d2e5a8f644b8..cd2130e98836 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -1225,6 +1225,7 @@ ip_vs_tunnel_xmit(struct sk_buff *skb, struct ip_vs_conn *cp,
 	skb->transport_header = skb->network_header;
 
 	skb_set_inner_ipproto(skb, next_protocol);
+	skb_set_inner_mac_header(skb, skb_inner_network_offset(skb));
 
 	if (tun_type == IP_VS_CONN_F_TUNNEL_TYPE_GUE) {
 		bool check = false;
@@ -1373,6 +1374,7 @@ ip_vs_tunnel_xmit_v6(struct sk_buff *skb, struct ip_vs_conn *cp,
 	skb->transport_header = skb->network_header;
 
 	skb_set_inner_ipproto(skb, next_protocol);
+	skb_set_inner_mac_header(skb, skb_inner_network_offset(skb));
 
 	if (tun_type == IP_VS_CONN_F_TUNNEL_TYPE_GUE) {
 		bool check = false;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 35b9f74f0bc6..826bd961d90c 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -153,6 +153,7 @@ static struct nft_trans *nft_trans_alloc_gfp(const struct nft_ctx *ctx,
 		return NULL;
 
 	INIT_LIST_HEAD(&trans->list);
+	INIT_LIST_HEAD(&trans->binding_list);
 	trans->msg_type = msg_type;
 	trans->ctx	= *ctx;
 
@@ -165,13 +166,20 @@ static struct nft_trans *nft_trans_alloc(const struct nft_ctx *ctx,
 	return nft_trans_alloc_gfp(ctx, msg_type, size, GFP_KERNEL);
 }
 
-static void nft_trans_destroy(struct nft_trans *trans)
+static void nft_trans_list_del(struct nft_trans *trans)
 {
 	list_del(&trans->list);
+	list_del(&trans->binding_list);
+}
+
+static void nft_trans_destroy(struct nft_trans *trans)
+{
+	nft_trans_list_del(trans);
 	kfree(trans);
 }
 
-static void nft_set_trans_bind(const struct nft_ctx *ctx, struct nft_set *set)
+static void __nft_set_trans_bind(const struct nft_ctx *ctx, struct nft_set *set,
+				 bool bind)
 {
 	struct nftables_pernet *nft_net;
 	struct net *net = ctx->net;
@@ -185,16 +193,80 @@ static void nft_set_trans_bind(const struct nft_ctx *ctx, struct nft_set *set)
 		switch (trans->msg_type) {
 		case NFT_MSG_NEWSET:
 			if (nft_trans_set(trans) == set)
-				nft_trans_set_bound(trans) = true;
+				nft_trans_set_bound(trans) = bind;
 			break;
 		case NFT_MSG_NEWSETELEM:
 			if (nft_trans_elem_set(trans) == set)
-				nft_trans_elem_set_bound(trans) = true;
+				nft_trans_elem_set_bound(trans) = bind;
+			break;
+		}
+	}
+}
+
+static void nft_set_trans_bind(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	return __nft_set_trans_bind(ctx, set, true);
+}
+
+static void nft_set_trans_unbind(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	return __nft_set_trans_bind(ctx, set, false);
+}
+
+static void __nft_chain_trans_bind(const struct nft_ctx *ctx,
+				   struct nft_chain *chain, bool bind)
+{
+	struct nftables_pernet *nft_net;
+	struct net *net = ctx->net;
+	struct nft_trans *trans;
+
+	if (!nft_chain_binding(chain))
+		return;
+
+	nft_net = nft_pernet(net);
+	list_for_each_entry_reverse(trans, &nft_net->commit_list, list) {
+		switch (trans->msg_type) {
+		case NFT_MSG_NEWCHAIN:
+			if (nft_trans_chain(trans) == chain)
+				nft_trans_chain_bound(trans) = bind;
+			break;
+		case NFT_MSG_NEWRULE:
+			if (trans->ctx.chain == chain)
+				nft_trans_rule_bound(trans) = bind;
 			break;
 		}
 	}
 }
 
+static void nft_chain_trans_bind(const struct nft_ctx *ctx,
+				 struct nft_chain *chain)
+{
+	__nft_chain_trans_bind(ctx, chain, true);
+}
+
+int nf_tables_bind_chain(const struct nft_ctx *ctx, struct nft_chain *chain)
+{
+	if (!nft_chain_binding(chain))
+		return 0;
+
+	if (nft_chain_binding(ctx->chain))
+		return -EOPNOTSUPP;
+
+	if (chain->bound)
+		return -EBUSY;
+
+	chain->bound = true;
+	chain->use++;
+	nft_chain_trans_bind(ctx, chain);
+
+	return 0;
+}
+
+void nf_tables_unbind_chain(const struct nft_ctx *ctx, struct nft_chain *chain)
+{
+	__nft_chain_trans_bind(ctx, chain, false);
+}
+
 static int nft_netdev_register_hooks(struct net *net,
 				     struct list_head *hook_list)
 {
@@ -294,6 +366,19 @@ static void nft_trans_commit_list_add_tail(struct net *net, struct nft_trans *tr
 {
 	struct nftables_pernet *nft_net = nft_pernet(net);
 
+	switch (trans->msg_type) {
+	case NFT_MSG_NEWSET:
+		if (!nft_trans_set_update(trans) &&
+		    nft_set_is_anonymous(nft_trans_set(trans)))
+			list_add_tail(&trans->binding_list, &nft_net->binding_list);
+		break;
+	case NFT_MSG_NEWCHAIN:
+		if (!nft_trans_chain_update(trans) &&
+		    nft_chain_binding(nft_trans_chain(trans)))
+			list_add_tail(&trans->binding_list, &nft_net->binding_list);
+		break;
+	}
+
 	list_add_tail(&trans->list, &nft_net->commit_list);
 }
 
@@ -340,8 +425,9 @@ static struct nft_trans *nft_trans_chain_add(struct nft_ctx *ctx, int msg_type)
 				ntohl(nla_get_be32(ctx->nla[NFTA_CHAIN_ID]));
 		}
 	}
-
+	nft_trans_chain(trans) = ctx->chain;
 	nft_trans_commit_list_add_tail(ctx->net, trans);
+
 	return trans;
 }
 
@@ -359,8 +445,7 @@ static int nft_delchain(struct nft_ctx *ctx)
 	return 0;
 }
 
-static void nft_rule_expr_activate(const struct nft_ctx *ctx,
-				   struct nft_rule *rule)
+void nft_rule_expr_activate(const struct nft_ctx *ctx, struct nft_rule *rule)
 {
 	struct nft_expr *expr;
 
@@ -373,9 +458,8 @@ static void nft_rule_expr_activate(const struct nft_ctx *ctx,
 	}
 }
 
-static void nft_rule_expr_deactivate(const struct nft_ctx *ctx,
-				     struct nft_rule *rule,
-				     enum nft_trans_phase phase)
+void nft_rule_expr_deactivate(const struct nft_ctx *ctx, struct nft_rule *rule,
+			      enum nft_trans_phase phase)
 {
 	struct nft_expr *expr;
 
@@ -2094,7 +2178,7 @@ static int nft_basechain_init(struct nft_base_chain *basechain, u8 family,
 	return 0;
 }
 
-static int nft_chain_add(struct nft_table *table, struct nft_chain *chain)
+int nft_chain_add(struct nft_table *table, struct nft_chain *chain)
 {
 	int err;
 
@@ -3220,8 +3304,7 @@ static int nf_tables_getrule(struct sk_buff *skb, const struct nfnl_info *info,
 	return err;
 }
 
-static void nf_tables_rule_destroy(const struct nft_ctx *ctx,
-				   struct nft_rule *rule)
+void nf_tables_rule_destroy(const struct nft_ctx *ctx, struct nft_rule *rule)
 {
 	struct nft_expr *expr, *next;
 
@@ -3238,7 +3321,7 @@ static void nf_tables_rule_destroy(const struct nft_ctx *ctx,
 	kfree(rule);
 }
 
-void nf_tables_rule_release(const struct nft_ctx *ctx, struct nft_rule *rule)
+static void nf_tables_rule_release(const struct nft_ctx *ctx, struct nft_rule *rule)
 {
 	nft_rule_expr_deactivate(ctx, rule, NFT_TRANS_RELEASE);
 	nf_tables_rule_destroy(ctx, rule);
@@ -3572,7 +3655,7 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 	if (flow)
 		nft_flow_rule_destroy(flow);
 err_release_rule:
-	nft_rule_expr_deactivate(&ctx, rule, NFT_TRANS_PREPARE);
+	nft_rule_expr_deactivate(&ctx, rule, NFT_TRANS_PREPARE_ERROR);
 	nf_tables_rule_destroy(&ctx, rule);
 err_release_expr:
 	for (i = 0; i < n; i++) {
@@ -4545,6 +4628,9 @@ static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
 		if (info->nlh->nlmsg_flags & NLM_F_REPLACE)
 			return -EOPNOTSUPP;
 
+		if (nft_set_is_anonymous(set))
+			return -EOPNOTSUPP;
+
 		err = nft_set_expr_alloc(&ctx, set, nla, exprs, &num_exprs, flags);
 		if (err < 0)
 			return err;
@@ -4853,6 +4939,13 @@ void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 			      enum nft_trans_phase phase)
 {
 	switch (phase) {
+	case NFT_TRANS_PREPARE_ERROR:
+		nft_set_trans_unbind(ctx, set);
+		if (nft_set_is_anonymous(set))
+			nft_deactivate_next(ctx->net, set);
+
+		set->use--;
+		break;
 	case NFT_TRANS_PREPARE:
 		if (nft_set_is_anonymous(set))
 			nft_deactivate_next(ctx->net, set);
@@ -6262,7 +6355,8 @@ static int nf_tables_newsetelem(struct sk_buff *skb,
 	if (IS_ERR(set))
 		return PTR_ERR(set);
 
-	if (!list_empty(&set->bindings) && set->flags & NFT_SET_CONSTANT)
+	if (!list_empty(&set->bindings) &&
+	    (set->flags & (NFT_SET_CONSTANT | NFT_SET_ANONYMOUS)))
 		return -EBUSY;
 
 	nft_ctx_init(&ctx, net, skb, info->nlh, family, table, NULL, nla);
@@ -6293,7 +6387,6 @@ static int nf_tables_newsetelem(struct sk_buff *skb,
 void nft_data_hold(const struct nft_data *data, enum nft_data_types type)
 {
 	struct nft_chain *chain;
-	struct nft_rule *rule;
 
 	if (type == NFT_DATA_VERDICT) {
 		switch (data->verdict.code) {
@@ -6301,15 +6394,6 @@ void nft_data_hold(const struct nft_data *data, enum nft_data_types type)
 		case NFT_GOTO:
 			chain = data->verdict.chain;
 			chain->use++;
-
-			if (!nft_chain_is_bound(chain))
-				break;
-
-			chain->table->use++;
-			list_for_each_entry(rule, &chain->rules, list)
-				chain->use++;
-
-			nft_chain_add(chain->table, chain);
 			break;
 		}
 	}
@@ -6542,7 +6626,9 @@ static int nf_tables_delsetelem(struct sk_buff *skb,
 	set = nft_set_lookup(table, nla[NFTA_SET_ELEM_LIST_SET], genmask);
 	if (IS_ERR(set))
 		return PTR_ERR(set);
-	if (!list_empty(&set->bindings) && set->flags & NFT_SET_CONSTANT)
+
+	if (!list_empty(&set->bindings) &&
+	    (set->flags & (NFT_SET_CONSTANT | NFT_SET_ANONYMOUS)))
 		return -EBUSY;
 
 	nft_ctx_init(&ctx, net, skb, info->nlh, family, table, NULL, nla);
@@ -7307,6 +7393,7 @@ void nf_tables_deactivate_flowtable(const struct nft_ctx *ctx,
 				    enum nft_trans_phase phase)
 {
 	switch (phase) {
+	case NFT_TRANS_PREPARE_ERROR:
 	case NFT_TRANS_PREPARE:
 	case NFT_TRANS_ABORT:
 	case NFT_TRANS_RELEASE:
@@ -8501,7 +8588,7 @@ static void nf_tables_trans_destroy_work(struct work_struct *w)
 	synchronize_rcu();
 
 	list_for_each_entry_safe(trans, next, &head, list) {
-		list_del(&trans->list);
+		nft_trans_list_del(trans);
 		nft_commit_release(trans);
 	}
 }
@@ -8819,6 +8906,27 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 		return 0;
 	}
 
+	list_for_each_entry(trans, &nft_net->binding_list, binding_list) {
+		switch (trans->msg_type) {
+		case NFT_MSG_NEWSET:
+			if (!nft_trans_set_update(trans) &&
+			    nft_set_is_anonymous(nft_trans_set(trans)) &&
+			    !nft_trans_set_bound(trans)) {
+				pr_warn_once("nftables ruleset with unbound set\n");
+				return -EINVAL;
+			}
+			break;
+		case NFT_MSG_NEWCHAIN:
+			if (!nft_trans_chain_update(trans) &&
+			    nft_chain_binding(nft_trans_chain(trans)) &&
+			    !nft_trans_chain_bound(trans)) {
+				pr_warn_once("nftables ruleset with unbound chain\n");
+				return -EINVAL;
+			}
+			break;
+		}
+	}
+
 	/* 0. Validate ruleset, otherwise roll back for error reporting. */
 	if (nf_tables_validate(net) < 0)
 		return -EAGAIN;
@@ -9162,7 +9270,7 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 				kfree(nft_trans_chain_name(trans));
 				nft_trans_destroy(trans);
 			} else {
-				if (nft_chain_is_bound(trans->ctx.chain)) {
+				if (nft_trans_chain_bound(trans)) {
 					nft_trans_destroy(trans);
 					break;
 				}
@@ -9179,6 +9287,10 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWRULE:
+			if (nft_trans_rule_bound(trans)) {
+				nft_trans_destroy(trans);
+				break;
+			}
 			trans->ctx.chain->use--;
 			list_del_rcu(&nft_trans_rule(trans)->list);
 			nft_rule_expr_deactivate(&trans->ctx,
@@ -9288,7 +9400,7 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 
 	list_for_each_entry_safe_reverse(trans, next,
 					 &nft_net->commit_list, list) {
-		list_del(&trans->list);
+		nft_trans_list_del(trans);
 		nf_tables_abort_release(trans);
 	}
 
@@ -9737,22 +9849,12 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 static void nft_verdict_uninit(const struct nft_data *data)
 {
 	struct nft_chain *chain;
-	struct nft_rule *rule;
 
 	switch (data->verdict.code) {
 	case NFT_JUMP:
 	case NFT_GOTO:
 		chain = data->verdict.chain;
 		chain->use--;
-
-		if (!nft_chain_is_bound(chain))
-			break;
-
-		chain->table->use--;
-		list_for_each_entry(rule, &chain->rules, list)
-			chain->use--;
-
-		nft_chain_del(chain);
 		break;
 	}
 }
@@ -10071,6 +10173,7 @@ static int __net_init nf_tables_init_net(struct net *net)
 
 	INIT_LIST_HEAD(&nft_net->tables);
 	INIT_LIST_HEAD(&nft_net->commit_list);
+	INIT_LIST_HEAD(&nft_net->binding_list);
 	INIT_LIST_HEAD(&nft_net->module_list);
 	INIT_LIST_HEAD(&nft_net->notify_list);
 	mutex_init(&nft_net->commit_mutex);
diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
index ee6840bd5933..8f1bfa6ccc2d 100644
--- a/net/netfilter/nfnetlink_osf.c
+++ b/net/netfilter/nfnetlink_osf.c
@@ -439,3 +439,4 @@ module_init(nfnl_osf_init);
 module_exit(nfnl_osf_fini);
 
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_NFNL_SUBSYS(NFNL_SUBSYS_OSF);
diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index fcdbc5ed3f36..6b0efab4fad0 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -76,11 +76,9 @@ static int nft_immediate_init(const struct nft_ctx *ctx,
 		switch (priv->data.verdict.code) {
 		case NFT_JUMP:
 		case NFT_GOTO:
-			if (nft_chain_is_bound(chain)) {
-				err = -EBUSY;
-				goto err1;
-			}
-			chain->bound = true;
+			err = nf_tables_bind_chain(ctx, chain);
+			if (err < 0)
+				return err;
 			break;
 		default:
 			break;
@@ -98,6 +96,31 @@ static void nft_immediate_activate(const struct nft_ctx *ctx,
 				   const struct nft_expr *expr)
 {
 	const struct nft_immediate_expr *priv = nft_expr_priv(expr);
+	const struct nft_data *data = &priv->data;
+	struct nft_ctx chain_ctx;
+	struct nft_chain *chain;
+	struct nft_rule *rule;
+
+	if (priv->dreg == NFT_REG_VERDICT) {
+		switch (data->verdict.code) {
+		case NFT_JUMP:
+		case NFT_GOTO:
+			chain = data->verdict.chain;
+			if (!nft_chain_binding(chain))
+				break;
+
+			chain_ctx = *ctx;
+			chain_ctx.chain = chain;
+
+			list_for_each_entry(rule, &chain->rules, list)
+				nft_rule_expr_activate(&chain_ctx, rule);
+
+			nft_clear(ctx->net, chain);
+			break;
+		default:
+			break;
+		}
+	}
 
 	return nft_data_hold(&priv->data, nft_dreg_to_type(priv->dreg));
 }
@@ -107,6 +130,43 @@ static void nft_immediate_deactivate(const struct nft_ctx *ctx,
 				     enum nft_trans_phase phase)
 {
 	const struct nft_immediate_expr *priv = nft_expr_priv(expr);
+	const struct nft_data *data = &priv->data;
+	struct nft_ctx chain_ctx;
+	struct nft_chain *chain;
+	struct nft_rule *rule;
+
+	if (priv->dreg == NFT_REG_VERDICT) {
+		switch (data->verdict.code) {
+		case NFT_JUMP:
+		case NFT_GOTO:
+			chain = data->verdict.chain;
+			if (!nft_chain_binding(chain))
+				break;
+
+			chain_ctx = *ctx;
+			chain_ctx.chain = chain;
+
+			list_for_each_entry(rule, &chain->rules, list)
+				nft_rule_expr_deactivate(&chain_ctx, rule, phase);
+
+			switch (phase) {
+			case NFT_TRANS_PREPARE_ERROR:
+				nf_tables_unbind_chain(ctx, chain);
+				fallthrough;
+			case NFT_TRANS_PREPARE:
+				nft_deactivate_next(ctx->net, chain);
+				break;
+			default:
+				nft_chain_del(chain);
+				chain->bound = false;
+				chain->table->use--;
+				break;
+			}
+			break;
+		default:
+			break;
+		}
+	}
 
 	if (phase == NFT_TRANS_COMMIT)
 		return;
@@ -131,15 +191,27 @@ static void nft_immediate_destroy(const struct nft_ctx *ctx,
 	case NFT_GOTO:
 		chain = data->verdict.chain;
 
-		if (!nft_chain_is_bound(chain))
+		if (!nft_chain_binding(chain))
+			break;
+
+		/* Rule construction failed, but chain is already bound:
+		 * let the transaction records release this chain and its rules.
+		 */
+		if (chain->bound) {
+			chain->use--;
 			break;
+		}
 
+		/* Rule has been deleted, release chain and its rules. */
 		chain_ctx = *ctx;
 		chain_ctx.chain = chain;
 
-		list_for_each_entry_safe(rule, n, &chain->rules, list)
-			nf_tables_rule_release(&chain_ctx, rule);
-
+		chain->use--;
+		list_for_each_entry_safe(rule, n, &chain->rules, list) {
+			chain->use--;
+			list_del(&rule->list);
+			nf_tables_rule_destroy(&chain_ctx, rule);
+		}
 		nf_tables_chain_destroy(&chain_ctx);
 		break;
 	default:
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 15e451dc3fc4..78e1ec8badde 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1974,12 +1974,16 @@ static void nft_pipapo_walk(const struct nft_ctx *ctx, struct nft_set *set,
 			    struct nft_set_iter *iter)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
+	struct net *net = read_pnet(&set->net);
 	struct nft_pipapo_match *m;
 	struct nft_pipapo_field *f;
 	int i, r;
 
 	rcu_read_lock();
-	m = rcu_dereference(priv->match);
+	if (iter->genmask == nft_genmask_cur(net))
+		m = rcu_dereference(priv->match);
+	else
+		m = priv->clone;
 
 	if (unlikely(!m))
 		goto out;
diff --git a/net/netfilter/xt_osf.c b/net/netfilter/xt_osf.c
index e1990baf3a3b..dc9485854002 100644
--- a/net/netfilter/xt_osf.c
+++ b/net/netfilter/xt_osf.c
@@ -71,4 +71,3 @@ MODULE_AUTHOR("Evgeniy Polyakov <zbr@ioremap.net>");
 MODULE_DESCRIPTION("Passive OS fingerprint matching.");
 MODULE_ALIAS("ipt_osf");
 MODULE_ALIAS("ip6t_osf");
-MODULE_ALIAS_NFNL_SUBSYS(NFNL_SUBSYS_OSF);
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index adc5407fd5d5..be42b1196786 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -969,6 +969,7 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	if (ret < 0)
 		return ret;
 
+	sch_tree_lock(sch);
 	/* backup q->clg and q->loss_model */
 	old_clg = q->clg;
 	old_loss_model = q->loss_model;
@@ -977,7 +978,7 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 		ret = get_loss_clg(q, tb[TCA_NETEM_LOSS]);
 		if (ret) {
 			q->loss_model = old_loss_model;
-			return ret;
+			goto unlock;
 		}
 	} else {
 		q->loss_model = CLG_RANDOM;
@@ -1044,6 +1045,8 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	/* capping jitter to the range acceptable by tabledist() */
 	q->jitter = min_t(s64, abs(q->jitter), INT_MAX);
 
+unlock:
+	sch_tree_unlock(sch);
 	return ret;
 
 get_table_failure:
@@ -1053,7 +1056,8 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	 */
 	q->clg = old_clg;
 	q->loss_model = old_loss_model;
-	return ret;
+
+	goto unlock;
 }
 
 static int netem_init(struct Qdisc *sch, struct nlattr *opt,
diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
index 494aa744bfb9..08a2870fdd36 100644
--- a/net/xfrm/Makefile
+++ b/net/xfrm/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the XFRM subsystem.
 #
 
+xfrm_interface-$(CONFIG_XFRM_INTERFACE) += xfrm_interface_core.o
+
 obj-$(CONFIG_XFRM) := xfrm_policy.o xfrm_state.o xfrm_hash.o \
 		      xfrm_input.o xfrm_output.o \
 		      xfrm_sysctl.o xfrm_replay.o xfrm_device.o
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 7c5958a2eed4..a6861832710d 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -130,6 +130,7 @@ struct sec_path *secpath_set(struct sk_buff *skb)
 	memset(sp->ovec, 0, sizeof(sp->ovec));
 	sp->olen = 0;
 	sp->len = 0;
+	sp->verified_cnt = 0;
 
 	return sp;
 }
diff --git a/net/xfrm/xfrm_interface.c b/net/xfrm/xfrm_interface.c
deleted file mode 100644
index 1e8b26eecb3f..000000000000
--- a/net/xfrm/xfrm_interface.c
+++ /dev/null
@@ -1,1032 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *	XFRM virtual interface
- *
- *	Copyright (C) 2018 secunet Security Networks AG
- *
- *	Author:
- *	Steffen Klassert <steffen.klassert@secunet.com>
- */
-
-#include <linux/module.h>
-#include <linux/capability.h>
-#include <linux/errno.h>
-#include <linux/types.h>
-#include <linux/sockios.h>
-#include <linux/icmp.h>
-#include <linux/if.h>
-#include <linux/in.h>
-#include <linux/ip.h>
-#include <linux/net.h>
-#include <linux/in6.h>
-#include <linux/netdevice.h>
-#include <linux/if_link.h>
-#include <linux/if_arp.h>
-#include <linux/icmpv6.h>
-#include <linux/init.h>
-#include <linux/route.h>
-#include <linux/rtnetlink.h>
-#include <linux/netfilter_ipv6.h>
-#include <linux/slab.h>
-#include <linux/hash.h>
-
-#include <linux/uaccess.h>
-#include <linux/atomic.h>
-
-#include <net/icmp.h>
-#include <net/ip.h>
-#include <net/ipv6.h>
-#include <net/ip6_route.h>
-#include <net/ip_tunnels.h>
-#include <net/addrconf.h>
-#include <net/xfrm.h>
-#include <net/net_namespace.h>
-#include <net/netns/generic.h>
-#include <linux/etherdevice.h>
-
-static int xfrmi_dev_init(struct net_device *dev);
-static void xfrmi_dev_setup(struct net_device *dev);
-static struct rtnl_link_ops xfrmi_link_ops __read_mostly;
-static unsigned int xfrmi_net_id __read_mostly;
-static const struct net_device_ops xfrmi_netdev_ops;
-
-#define XFRMI_HASH_BITS	8
-#define XFRMI_HASH_SIZE	BIT(XFRMI_HASH_BITS)
-
-struct xfrmi_net {
-	/* lists for storing interfaces in use */
-	struct xfrm_if __rcu *xfrmi[XFRMI_HASH_SIZE];
-};
-
-#define for_each_xfrmi_rcu(start, xi) \
-	for (xi = rcu_dereference(start); xi; xi = rcu_dereference(xi->next))
-
-static u32 xfrmi_hash(u32 if_id)
-{
-	return hash_32(if_id, XFRMI_HASH_BITS);
-}
-
-static struct xfrm_if *xfrmi_lookup(struct net *net, struct xfrm_state *x)
-{
-	struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
-	struct xfrm_if *xi;
-
-	for_each_xfrmi_rcu(xfrmn->xfrmi[xfrmi_hash(x->if_id)], xi) {
-		if (x->if_id == xi->p.if_id &&
-		    (xi->dev->flags & IFF_UP))
-			return xi;
-	}
-
-	return NULL;
-}
-
-static struct xfrm_if *xfrmi_decode_session(struct sk_buff *skb,
-					    unsigned short family)
-{
-	struct net_device *dev;
-	int ifindex = 0;
-
-	if (!secpath_exists(skb) || !skb->dev)
-		return NULL;
-
-	switch (family) {
-	case AF_INET6:
-		ifindex = inet6_sdif(skb);
-		break;
-	case AF_INET:
-		ifindex = inet_sdif(skb);
-		break;
-	}
-
-	if (ifindex) {
-		struct net *net = xs_net(xfrm_input_state(skb));
-
-		dev = dev_get_by_index_rcu(net, ifindex);
-	} else {
-		dev = skb->dev;
-	}
-
-	if (!dev || !(dev->flags & IFF_UP))
-		return NULL;
-	if (dev->netdev_ops != &xfrmi_netdev_ops)
-		return NULL;
-
-	return netdev_priv(dev);
-}
-
-static void xfrmi_link(struct xfrmi_net *xfrmn, struct xfrm_if *xi)
-{
-	struct xfrm_if __rcu **xip = &xfrmn->xfrmi[xfrmi_hash(xi->p.if_id)];
-
-	rcu_assign_pointer(xi->next , rtnl_dereference(*xip));
-	rcu_assign_pointer(*xip, xi);
-}
-
-static void xfrmi_unlink(struct xfrmi_net *xfrmn, struct xfrm_if *xi)
-{
-	struct xfrm_if __rcu **xip;
-	struct xfrm_if *iter;
-
-	for (xip = &xfrmn->xfrmi[xfrmi_hash(xi->p.if_id)];
-	     (iter = rtnl_dereference(*xip)) != NULL;
-	     xip = &iter->next) {
-		if (xi == iter) {
-			rcu_assign_pointer(*xip, xi->next);
-			break;
-		}
-	}
-}
-
-static void xfrmi_dev_free(struct net_device *dev)
-{
-	struct xfrm_if *xi = netdev_priv(dev);
-
-	gro_cells_destroy(&xi->gro_cells);
-	free_percpu(dev->tstats);
-}
-
-static int xfrmi_create(struct net_device *dev)
-{
-	struct xfrm_if *xi = netdev_priv(dev);
-	struct net *net = dev_net(dev);
-	struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
-	int err;
-
-	dev->rtnl_link_ops = &xfrmi_link_ops;
-	err = register_netdevice(dev);
-	if (err < 0)
-		goto out;
-
-	xfrmi_link(xfrmn, xi);
-
-	return 0;
-
-out:
-	return err;
-}
-
-static struct xfrm_if *xfrmi_locate(struct net *net, struct xfrm_if_parms *p)
-{
-	struct xfrm_if __rcu **xip;
-	struct xfrm_if *xi;
-	struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
-
-	for (xip = &xfrmn->xfrmi[xfrmi_hash(p->if_id)];
-	     (xi = rtnl_dereference(*xip)) != NULL;
-	     xip = &xi->next)
-		if (xi->p.if_id == p->if_id)
-			return xi;
-
-	return NULL;
-}
-
-static void xfrmi_dev_uninit(struct net_device *dev)
-{
-	struct xfrm_if *xi = netdev_priv(dev);
-	struct xfrmi_net *xfrmn = net_generic(xi->net, xfrmi_net_id);
-
-	xfrmi_unlink(xfrmn, xi);
-}
-
-static void xfrmi_scrub_packet(struct sk_buff *skb, bool xnet)
-{
-	skb->tstamp = 0;
-	skb->pkt_type = PACKET_HOST;
-	skb->skb_iif = 0;
-	skb->ignore_df = 0;
-	skb_dst_drop(skb);
-	nf_reset_ct(skb);
-	nf_reset_trace(skb);
-
-	if (!xnet)
-		return;
-
-	ipvs_reset(skb);
-	secpath_reset(skb);
-	skb_orphan(skb);
-	skb->mark = 0;
-}
-
-static int xfrmi_rcv_cb(struct sk_buff *skb, int err)
-{
-	const struct xfrm_mode *inner_mode;
-	struct net_device *dev;
-	struct xfrm_state *x;
-	struct xfrm_if *xi;
-	bool xnet;
-
-	if (err && !secpath_exists(skb))
-		return 0;
-
-	x = xfrm_input_state(skb);
-
-	xi = xfrmi_lookup(xs_net(x), x);
-	if (!xi)
-		return 1;
-
-	dev = xi->dev;
-	skb->dev = dev;
-
-	if (err) {
-		dev->stats.rx_errors++;
-		dev->stats.rx_dropped++;
-
-		return 0;
-	}
-
-	xnet = !net_eq(xi->net, dev_net(skb->dev));
-
-	if (xnet) {
-		inner_mode = &x->inner_mode;
-
-		if (x->sel.family == AF_UNSPEC) {
-			inner_mode = xfrm_ip2inner_mode(x, XFRM_MODE_SKB_CB(skb)->protocol);
-			if (inner_mode == NULL) {
-				XFRM_INC_STATS(dev_net(skb->dev),
-					       LINUX_MIB_XFRMINSTATEMODEERROR);
-				return -EINVAL;
-			}
-		}
-
-		if (!xfrm_policy_check(NULL, XFRM_POLICY_IN, skb,
-				       inner_mode->family))
-			return -EPERM;
-	}
-
-	xfrmi_scrub_packet(skb, xnet);
-	dev_sw_netstats_rx_add(dev, skb->len);
-
-	return 0;
-}
-
-static int
-xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
-{
-	struct xfrm_if *xi = netdev_priv(dev);
-	struct net_device_stats *stats = &xi->dev->stats;
-	struct dst_entry *dst = skb_dst(skb);
-	unsigned int length = skb->len;
-	struct net_device *tdev;
-	struct xfrm_state *x;
-	int err = -1;
-	int mtu;
-
-	dst_hold(dst);
-	dst = xfrm_lookup_with_ifid(xi->net, dst, fl, NULL, 0, xi->p.if_id);
-	if (IS_ERR(dst)) {
-		err = PTR_ERR(dst);
-		dst = NULL;
-		goto tx_err_link_failure;
-	}
-
-	x = dst->xfrm;
-	if (!x)
-		goto tx_err_link_failure;
-
-	if (x->if_id != xi->p.if_id)
-		goto tx_err_link_failure;
-
-	tdev = dst->dev;
-
-	if (tdev == dev) {
-		stats->collisions++;
-		net_warn_ratelimited("%s: Local routing loop detected!\n",
-				     dev->name);
-		goto tx_err_dst_release;
-	}
-
-	mtu = dst_mtu(dst);
-	if ((!skb_is_gso(skb) && skb->len > mtu) ||
-	    (skb_is_gso(skb) && !skb_gso_validate_network_len(skb, mtu))) {
-		skb_dst_update_pmtu_no_confirm(skb, mtu);
-
-		if (skb->protocol == htons(ETH_P_IPV6)) {
-			if (mtu < IPV6_MIN_MTU)
-				mtu = IPV6_MIN_MTU;
-
-			if (skb->len > 1280)
-				icmpv6_ndo_send(skb, ICMPV6_PKT_TOOBIG, 0, mtu);
-			else
-				goto xmit;
-		} else {
-			if (!(ip_hdr(skb)->frag_off & htons(IP_DF)))
-				goto xmit;
-			icmp_ndo_send(skb, ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED,
-				      htonl(mtu));
-		}
-
-		dst_release(dst);
-		return -EMSGSIZE;
-	}
-
-xmit:
-	xfrmi_scrub_packet(skb, !net_eq(xi->net, dev_net(dev)));
-	skb_dst_set(skb, dst);
-	skb->dev = tdev;
-
-	err = dst_output(xi->net, skb->sk, skb);
-	if (net_xmit_eval(err) == 0) {
-		dev_sw_netstats_tx_add(dev, 1, length);
-	} else {
-		stats->tx_errors++;
-		stats->tx_aborted_errors++;
-	}
-
-	return 0;
-tx_err_link_failure:
-	stats->tx_carrier_errors++;
-	dst_link_failure(skb);
-tx_err_dst_release:
-	dst_release(dst);
-	return err;
-}
-
-static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
-{
-	struct xfrm_if *xi = netdev_priv(dev);
-	struct net_device_stats *stats = &xi->dev->stats;
-	struct dst_entry *dst = skb_dst(skb);
-	struct flowi fl;
-	int ret;
-
-	memset(&fl, 0, sizeof(fl));
-
-	switch (skb->protocol) {
-	case htons(ETH_P_IPV6):
-		xfrm_decode_session(skb, &fl, AF_INET6);
-		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
-		if (!dst) {
-			fl.u.ip6.flowi6_oif = dev->ifindex;
-			fl.u.ip6.flowi6_flags |= FLOWI_FLAG_ANYSRC;
-			dst = ip6_route_output(dev_net(dev), NULL, &fl.u.ip6);
-			if (dst->error) {
-				dst_release(dst);
-				stats->tx_carrier_errors++;
-				goto tx_err;
-			}
-			skb_dst_set(skb, dst);
-		}
-		break;
-	case htons(ETH_P_IP):
-		xfrm_decode_session(skb, &fl, AF_INET);
-		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
-		if (!dst) {
-			struct rtable *rt;
-
-			fl.u.ip4.flowi4_oif = dev->ifindex;
-			fl.u.ip4.flowi4_flags |= FLOWI_FLAG_ANYSRC;
-			rt = __ip_route_output_key(dev_net(dev), &fl.u.ip4);
-			if (IS_ERR(rt)) {
-				stats->tx_carrier_errors++;
-				goto tx_err;
-			}
-			skb_dst_set(skb, &rt->dst);
-		}
-		break;
-	default:
-		goto tx_err;
-	}
-
-	fl.flowi_oif = xi->p.link;
-
-	ret = xfrmi_xmit2(skb, dev, &fl);
-	if (ret < 0)
-		goto tx_err;
-
-	return NETDEV_TX_OK;
-
-tx_err:
-	stats->tx_errors++;
-	stats->tx_dropped++;
-	kfree_skb(skb);
-	return NETDEV_TX_OK;
-}
-
-static int xfrmi4_err(struct sk_buff *skb, u32 info)
-{
-	const struct iphdr *iph = (const struct iphdr *)skb->data;
-	struct net *net = dev_net(skb->dev);
-	int protocol = iph->protocol;
-	struct ip_comp_hdr *ipch;
-	struct ip_esp_hdr *esph;
-	struct ip_auth_hdr *ah ;
-	struct xfrm_state *x;
-	struct xfrm_if *xi;
-	__be32 spi;
-
-	switch (protocol) {
-	case IPPROTO_ESP:
-		esph = (struct ip_esp_hdr *)(skb->data+(iph->ihl<<2));
-		spi = esph->spi;
-		break;
-	case IPPROTO_AH:
-		ah = (struct ip_auth_hdr *)(skb->data+(iph->ihl<<2));
-		spi = ah->spi;
-		break;
-	case IPPROTO_COMP:
-		ipch = (struct ip_comp_hdr *)(skb->data+(iph->ihl<<2));
-		spi = htonl(ntohs(ipch->cpi));
-		break;
-	default:
-		return 0;
-	}
-
-	switch (icmp_hdr(skb)->type) {
-	case ICMP_DEST_UNREACH:
-		if (icmp_hdr(skb)->code != ICMP_FRAG_NEEDED)
-			return 0;
-		break;
-	case ICMP_REDIRECT:
-		break;
-	default:
-		return 0;
-	}
-
-	x = xfrm_state_lookup(net, skb->mark, (const xfrm_address_t *)&iph->daddr,
-			      spi, protocol, AF_INET);
-	if (!x)
-		return 0;
-
-	xi = xfrmi_lookup(net, x);
-	if (!xi) {
-		xfrm_state_put(x);
-		return -1;
-	}
-
-	if (icmp_hdr(skb)->type == ICMP_DEST_UNREACH)
-		ipv4_update_pmtu(skb, net, info, 0, protocol);
-	else
-		ipv4_redirect(skb, net, 0, protocol);
-	xfrm_state_put(x);
-
-	return 0;
-}
-
-static int xfrmi6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
-		    u8 type, u8 code, int offset, __be32 info)
-{
-	const struct ipv6hdr *iph = (const struct ipv6hdr *)skb->data;
-	struct net *net = dev_net(skb->dev);
-	int protocol = iph->nexthdr;
-	struct ip_comp_hdr *ipch;
-	struct ip_esp_hdr *esph;
-	struct ip_auth_hdr *ah;
-	struct xfrm_state *x;
-	struct xfrm_if *xi;
-	__be32 spi;
-
-	switch (protocol) {
-	case IPPROTO_ESP:
-		esph = (struct ip_esp_hdr *)(skb->data + offset);
-		spi = esph->spi;
-		break;
-	case IPPROTO_AH:
-		ah = (struct ip_auth_hdr *)(skb->data + offset);
-		spi = ah->spi;
-		break;
-	case IPPROTO_COMP:
-		ipch = (struct ip_comp_hdr *)(skb->data + offset);
-		spi = htonl(ntohs(ipch->cpi));
-		break;
-	default:
-		return 0;
-	}
-
-	if (type != ICMPV6_PKT_TOOBIG &&
-	    type != NDISC_REDIRECT)
-		return 0;
-
-	x = xfrm_state_lookup(net, skb->mark, (const xfrm_address_t *)&iph->daddr,
-			      spi, protocol, AF_INET6);
-	if (!x)
-		return 0;
-
-	xi = xfrmi_lookup(net, x);
-	if (!xi) {
-		xfrm_state_put(x);
-		return -1;
-	}
-
-	if (type == NDISC_REDIRECT)
-		ip6_redirect(skb, net, skb->dev->ifindex, 0,
-			     sock_net_uid(net, NULL));
-	else
-		ip6_update_pmtu(skb, net, info, 0, 0, sock_net_uid(net, NULL));
-	xfrm_state_put(x);
-
-	return 0;
-}
-
-static int xfrmi_change(struct xfrm_if *xi, const struct xfrm_if_parms *p)
-{
-	if (xi->p.link != p->link)
-		return -EINVAL;
-
-	xi->p.if_id = p->if_id;
-
-	return 0;
-}
-
-static int xfrmi_update(struct xfrm_if *xi, struct xfrm_if_parms *p)
-{
-	struct net *net = xi->net;
-	struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
-	int err;
-
-	xfrmi_unlink(xfrmn, xi);
-	synchronize_net();
-	err = xfrmi_change(xi, p);
-	xfrmi_link(xfrmn, xi);
-	netdev_state_change(xi->dev);
-	return err;
-}
-
-static int xfrmi_get_iflink(const struct net_device *dev)
-{
-	struct xfrm_if *xi = netdev_priv(dev);
-
-	return xi->p.link;
-}
-
-static const struct net_device_ops xfrmi_netdev_ops = {
-	.ndo_init	= xfrmi_dev_init,
-	.ndo_uninit	= xfrmi_dev_uninit,
-	.ndo_start_xmit = xfrmi_xmit,
-	.ndo_get_stats64 = dev_get_tstats64,
-	.ndo_get_iflink = xfrmi_get_iflink,
-};
-
-static void xfrmi_dev_setup(struct net_device *dev)
-{
-	dev->netdev_ops 	= &xfrmi_netdev_ops;
-	dev->header_ops		= &ip_tunnel_header_ops;
-	dev->type		= ARPHRD_NONE;
-	dev->mtu		= ETH_DATA_LEN;
-	dev->min_mtu		= ETH_MIN_MTU;
-	dev->max_mtu		= IP_MAX_MTU;
-	dev->flags 		= IFF_NOARP;
-	dev->needs_free_netdev	= true;
-	dev->priv_destructor	= xfrmi_dev_free;
-	netif_keep_dst(dev);
-
-	eth_broadcast_addr(dev->broadcast);
-}
-
-#define XFRMI_FEATURES (NETIF_F_SG |		\
-			NETIF_F_FRAGLIST |	\
-			NETIF_F_GSO_SOFTWARE |	\
-			NETIF_F_HW_CSUM)
-
-static int xfrmi_dev_init(struct net_device *dev)
-{
-	struct xfrm_if *xi = netdev_priv(dev);
-	struct net_device *phydev = __dev_get_by_index(xi->net, xi->p.link);
-	int err;
-
-	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!dev->tstats)
-		return -ENOMEM;
-
-	err = gro_cells_init(&xi->gro_cells, dev);
-	if (err) {
-		free_percpu(dev->tstats);
-		return err;
-	}
-
-	dev->features |= NETIF_F_LLTX;
-	dev->features |= XFRMI_FEATURES;
-	dev->hw_features |= XFRMI_FEATURES;
-
-	if (phydev) {
-		dev->needed_headroom = phydev->needed_headroom;
-		dev->needed_tailroom = phydev->needed_tailroom;
-
-		if (is_zero_ether_addr(dev->dev_addr))
-			eth_hw_addr_inherit(dev, phydev);
-		if (is_zero_ether_addr(dev->broadcast))
-			memcpy(dev->broadcast, phydev->broadcast,
-			       dev->addr_len);
-	} else {
-		eth_hw_addr_random(dev);
-		eth_broadcast_addr(dev->broadcast);
-	}
-
-	return 0;
-}
-
-static int xfrmi_validate(struct nlattr *tb[], struct nlattr *data[],
-			 struct netlink_ext_ack *extack)
-{
-	return 0;
-}
-
-static void xfrmi_netlink_parms(struct nlattr *data[],
-			       struct xfrm_if_parms *parms)
-{
-	memset(parms, 0, sizeof(*parms));
-
-	if (!data)
-		return;
-
-	if (data[IFLA_XFRM_LINK])
-		parms->link = nla_get_u32(data[IFLA_XFRM_LINK]);
-
-	if (data[IFLA_XFRM_IF_ID])
-		parms->if_id = nla_get_u32(data[IFLA_XFRM_IF_ID]);
-}
-
-static int xfrmi_newlink(struct net *src_net, struct net_device *dev,
-			struct nlattr *tb[], struct nlattr *data[],
-			struct netlink_ext_ack *extack)
-{
-	struct net *net = dev_net(dev);
-	struct xfrm_if_parms p = {};
-	struct xfrm_if *xi;
-	int err;
-
-	xfrmi_netlink_parms(data, &p);
-	if (!p.if_id) {
-		NL_SET_ERR_MSG(extack, "if_id must be non zero");
-		return -EINVAL;
-	}
-
-	xi = xfrmi_locate(net, &p);
-	if (xi)
-		return -EEXIST;
-
-	xi = netdev_priv(dev);
-	xi->p = p;
-	xi->net = net;
-	xi->dev = dev;
-
-	err = xfrmi_create(dev);
-	return err;
-}
-
-static void xfrmi_dellink(struct net_device *dev, struct list_head *head)
-{
-	unregister_netdevice_queue(dev, head);
-}
-
-static int xfrmi_changelink(struct net_device *dev, struct nlattr *tb[],
-			   struct nlattr *data[],
-			   struct netlink_ext_ack *extack)
-{
-	struct xfrm_if *xi = netdev_priv(dev);
-	struct net *net = xi->net;
-	struct xfrm_if_parms p = {};
-
-	xfrmi_netlink_parms(data, &p);
-	if (!p.if_id) {
-		NL_SET_ERR_MSG(extack, "if_id must be non zero");
-		return -EINVAL;
-	}
-
-	xi = xfrmi_locate(net, &p);
-	if (!xi) {
-		xi = netdev_priv(dev);
-	} else {
-		if (xi->dev != dev)
-			return -EEXIST;
-	}
-
-	return xfrmi_update(xi, &p);
-}
-
-static size_t xfrmi_get_size(const struct net_device *dev)
-{
-	return
-		/* IFLA_XFRM_LINK */
-		nla_total_size(4) +
-		/* IFLA_XFRM_IF_ID */
-		nla_total_size(4) +
-		0;
-}
-
-static int xfrmi_fill_info(struct sk_buff *skb, const struct net_device *dev)
-{
-	struct xfrm_if *xi = netdev_priv(dev);
-	struct xfrm_if_parms *parm = &xi->p;
-
-	if (nla_put_u32(skb, IFLA_XFRM_LINK, parm->link) ||
-	    nla_put_u32(skb, IFLA_XFRM_IF_ID, parm->if_id))
-		goto nla_put_failure;
-	return 0;
-
-nla_put_failure:
-	return -EMSGSIZE;
-}
-
-static struct net *xfrmi_get_link_net(const struct net_device *dev)
-{
-	struct xfrm_if *xi = netdev_priv(dev);
-
-	return xi->net;
-}
-
-static const struct nla_policy xfrmi_policy[IFLA_XFRM_MAX + 1] = {
-	[IFLA_XFRM_LINK]	= { .type = NLA_U32 },
-	[IFLA_XFRM_IF_ID]	= { .type = NLA_U32 },
-};
-
-static struct rtnl_link_ops xfrmi_link_ops __read_mostly = {
-	.kind		= "xfrm",
-	.maxtype	= IFLA_XFRM_MAX,
-	.policy		= xfrmi_policy,
-	.priv_size	= sizeof(struct xfrm_if),
-	.setup		= xfrmi_dev_setup,
-	.validate	= xfrmi_validate,
-	.newlink	= xfrmi_newlink,
-	.dellink	= xfrmi_dellink,
-	.changelink	= xfrmi_changelink,
-	.get_size	= xfrmi_get_size,
-	.fill_info	= xfrmi_fill_info,
-	.get_link_net	= xfrmi_get_link_net,
-};
-
-static void __net_exit xfrmi_exit_batch_net(struct list_head *net_exit_list)
-{
-	struct net *net;
-	LIST_HEAD(list);
-
-	rtnl_lock();
-	list_for_each_entry(net, net_exit_list, exit_list) {
-		struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
-		struct xfrm_if __rcu **xip;
-		struct xfrm_if *xi;
-		int i;
-
-		for (i = 0; i < XFRMI_HASH_SIZE; i++) {
-			for (xip = &xfrmn->xfrmi[i];
-			     (xi = rtnl_dereference(*xip)) != NULL;
-			     xip = &xi->next)
-				unregister_netdevice_queue(xi->dev, &list);
-		}
-	}
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
-}
-
-static struct pernet_operations xfrmi_net_ops = {
-	.exit_batch = xfrmi_exit_batch_net,
-	.id   = &xfrmi_net_id,
-	.size = sizeof(struct xfrmi_net),
-};
-
-static struct xfrm6_protocol xfrmi_esp6_protocol __read_mostly = {
-	.handler	=	xfrm6_rcv,
-	.input_handler	=	xfrm_input,
-	.cb_handler	=	xfrmi_rcv_cb,
-	.err_handler	=	xfrmi6_err,
-	.priority	=	10,
-};
-
-static struct xfrm6_protocol xfrmi_ah6_protocol __read_mostly = {
-	.handler	=	xfrm6_rcv,
-	.input_handler	=	xfrm_input,
-	.cb_handler	=	xfrmi_rcv_cb,
-	.err_handler	=	xfrmi6_err,
-	.priority	=	10,
-};
-
-static struct xfrm6_protocol xfrmi_ipcomp6_protocol __read_mostly = {
-	.handler	=	xfrm6_rcv,
-	.input_handler	=	xfrm_input,
-	.cb_handler	=	xfrmi_rcv_cb,
-	.err_handler	=	xfrmi6_err,
-	.priority	=	10,
-};
-
-#if IS_REACHABLE(CONFIG_INET6_XFRM_TUNNEL)
-static int xfrmi6_rcv_tunnel(struct sk_buff *skb)
-{
-	const xfrm_address_t *saddr;
-	__be32 spi;
-
-	saddr = (const xfrm_address_t *)&ipv6_hdr(skb)->saddr;
-	spi = xfrm6_tunnel_spi_lookup(dev_net(skb->dev), saddr);
-
-	return xfrm6_rcv_spi(skb, IPPROTO_IPV6, spi, NULL);
-}
-
-static struct xfrm6_tunnel xfrmi_ipv6_handler __read_mostly = {
-	.handler	=	xfrmi6_rcv_tunnel,
-	.cb_handler	=	xfrmi_rcv_cb,
-	.err_handler	=	xfrmi6_err,
-	.priority	=	2,
-};
-
-static struct xfrm6_tunnel xfrmi_ip6ip_handler __read_mostly = {
-	.handler	=	xfrmi6_rcv_tunnel,
-	.cb_handler	=	xfrmi_rcv_cb,
-	.err_handler	=	xfrmi6_err,
-	.priority	=	2,
-};
-#endif
-
-static struct xfrm4_protocol xfrmi_esp4_protocol __read_mostly = {
-	.handler	=	xfrm4_rcv,
-	.input_handler	=	xfrm_input,
-	.cb_handler	=	xfrmi_rcv_cb,
-	.err_handler	=	xfrmi4_err,
-	.priority	=	10,
-};
-
-static struct xfrm4_protocol xfrmi_ah4_protocol __read_mostly = {
-	.handler	=	xfrm4_rcv,
-	.input_handler	=	xfrm_input,
-	.cb_handler	=	xfrmi_rcv_cb,
-	.err_handler	=	xfrmi4_err,
-	.priority	=	10,
-};
-
-static struct xfrm4_protocol xfrmi_ipcomp4_protocol __read_mostly = {
-	.handler	=	xfrm4_rcv,
-	.input_handler	=	xfrm_input,
-	.cb_handler	=	xfrmi_rcv_cb,
-	.err_handler	=	xfrmi4_err,
-	.priority	=	10,
-};
-
-#if IS_REACHABLE(CONFIG_INET_XFRM_TUNNEL)
-static int xfrmi4_rcv_tunnel(struct sk_buff *skb)
-{
-	return xfrm4_rcv_spi(skb, IPPROTO_IPIP, ip_hdr(skb)->saddr);
-}
-
-static struct xfrm_tunnel xfrmi_ipip_handler __read_mostly = {
-	.handler	=	xfrmi4_rcv_tunnel,
-	.cb_handler	=	xfrmi_rcv_cb,
-	.err_handler	=	xfrmi4_err,
-	.priority	=	3,
-};
-
-static struct xfrm_tunnel xfrmi_ipip6_handler __read_mostly = {
-	.handler	=	xfrmi4_rcv_tunnel,
-	.cb_handler	=	xfrmi_rcv_cb,
-	.err_handler	=	xfrmi4_err,
-	.priority	=	2,
-};
-#endif
-
-static int __init xfrmi4_init(void)
-{
-	int err;
-
-	err = xfrm4_protocol_register(&xfrmi_esp4_protocol, IPPROTO_ESP);
-	if (err < 0)
-		goto xfrm_proto_esp_failed;
-	err = xfrm4_protocol_register(&xfrmi_ah4_protocol, IPPROTO_AH);
-	if (err < 0)
-		goto xfrm_proto_ah_failed;
-	err = xfrm4_protocol_register(&xfrmi_ipcomp4_protocol, IPPROTO_COMP);
-	if (err < 0)
-		goto xfrm_proto_comp_failed;
-#if IS_REACHABLE(CONFIG_INET_XFRM_TUNNEL)
-	err = xfrm4_tunnel_register(&xfrmi_ipip_handler, AF_INET);
-	if (err < 0)
-		goto xfrm_tunnel_ipip_failed;
-	err = xfrm4_tunnel_register(&xfrmi_ipip6_handler, AF_INET6);
-	if (err < 0)
-		goto xfrm_tunnel_ipip6_failed;
-#endif
-
-	return 0;
-
-#if IS_REACHABLE(CONFIG_INET_XFRM_TUNNEL)
-xfrm_tunnel_ipip6_failed:
-	xfrm4_tunnel_deregister(&xfrmi_ipip_handler, AF_INET);
-xfrm_tunnel_ipip_failed:
-	xfrm4_protocol_deregister(&xfrmi_ipcomp4_protocol, IPPROTO_COMP);
-#endif
-xfrm_proto_comp_failed:
-	xfrm4_protocol_deregister(&xfrmi_ah4_protocol, IPPROTO_AH);
-xfrm_proto_ah_failed:
-	xfrm4_protocol_deregister(&xfrmi_esp4_protocol, IPPROTO_ESP);
-xfrm_proto_esp_failed:
-	return err;
-}
-
-static void xfrmi4_fini(void)
-{
-#if IS_REACHABLE(CONFIG_INET_XFRM_TUNNEL)
-	xfrm4_tunnel_deregister(&xfrmi_ipip6_handler, AF_INET6);
-	xfrm4_tunnel_deregister(&xfrmi_ipip_handler, AF_INET);
-#endif
-	xfrm4_protocol_deregister(&xfrmi_ipcomp4_protocol, IPPROTO_COMP);
-	xfrm4_protocol_deregister(&xfrmi_ah4_protocol, IPPROTO_AH);
-	xfrm4_protocol_deregister(&xfrmi_esp4_protocol, IPPROTO_ESP);
-}
-
-static int __init xfrmi6_init(void)
-{
-	int err;
-
-	err = xfrm6_protocol_register(&xfrmi_esp6_protocol, IPPROTO_ESP);
-	if (err < 0)
-		goto xfrm_proto_esp_failed;
-	err = xfrm6_protocol_register(&xfrmi_ah6_protocol, IPPROTO_AH);
-	if (err < 0)
-		goto xfrm_proto_ah_failed;
-	err = xfrm6_protocol_register(&xfrmi_ipcomp6_protocol, IPPROTO_COMP);
-	if (err < 0)
-		goto xfrm_proto_comp_failed;
-#if IS_REACHABLE(CONFIG_INET6_XFRM_TUNNEL)
-	err = xfrm6_tunnel_register(&xfrmi_ipv6_handler, AF_INET6);
-	if (err < 0)
-		goto xfrm_tunnel_ipv6_failed;
-	err = xfrm6_tunnel_register(&xfrmi_ip6ip_handler, AF_INET);
-	if (err < 0)
-		goto xfrm_tunnel_ip6ip_failed;
-#endif
-
-	return 0;
-
-#if IS_REACHABLE(CONFIG_INET6_XFRM_TUNNEL)
-xfrm_tunnel_ip6ip_failed:
-	xfrm6_tunnel_deregister(&xfrmi_ipv6_handler, AF_INET6);
-xfrm_tunnel_ipv6_failed:
-	xfrm6_protocol_deregister(&xfrmi_ipcomp6_protocol, IPPROTO_COMP);
-#endif
-xfrm_proto_comp_failed:
-	xfrm6_protocol_deregister(&xfrmi_ah6_protocol, IPPROTO_AH);
-xfrm_proto_ah_failed:
-	xfrm6_protocol_deregister(&xfrmi_esp6_protocol, IPPROTO_ESP);
-xfrm_proto_esp_failed:
-	return err;
-}
-
-static void xfrmi6_fini(void)
-{
-#if IS_REACHABLE(CONFIG_INET6_XFRM_TUNNEL)
-	xfrm6_tunnel_deregister(&xfrmi_ip6ip_handler, AF_INET);
-	xfrm6_tunnel_deregister(&xfrmi_ipv6_handler, AF_INET6);
-#endif
-	xfrm6_protocol_deregister(&xfrmi_ipcomp6_protocol, IPPROTO_COMP);
-	xfrm6_protocol_deregister(&xfrmi_ah6_protocol, IPPROTO_AH);
-	xfrm6_protocol_deregister(&xfrmi_esp6_protocol, IPPROTO_ESP);
-}
-
-static const struct xfrm_if_cb xfrm_if_cb = {
-	.decode_session =	xfrmi_decode_session,
-};
-
-static int __init xfrmi_init(void)
-{
-	const char *msg;
-	int err;
-
-	pr_info("IPsec XFRM device driver\n");
-
-	msg = "tunnel device";
-	err = register_pernet_device(&xfrmi_net_ops);
-	if (err < 0)
-		goto pernet_dev_failed;
-
-	msg = "xfrm4 protocols";
-	err = xfrmi4_init();
-	if (err < 0)
-		goto xfrmi4_failed;
-
-	msg = "xfrm6 protocols";
-	err = xfrmi6_init();
-	if (err < 0)
-		goto xfrmi6_failed;
-
-
-	msg = "netlink interface";
-	err = rtnl_link_register(&xfrmi_link_ops);
-	if (err < 0)
-		goto rtnl_link_failed;
-
-	xfrm_if_register_cb(&xfrm_if_cb);
-
-	return err;
-
-rtnl_link_failed:
-	xfrmi6_fini();
-xfrmi6_failed:
-	xfrmi4_fini();
-xfrmi4_failed:
-	unregister_pernet_device(&xfrmi_net_ops);
-pernet_dev_failed:
-	pr_err("xfrmi init: failed to register %s\n", msg);
-	return err;
-}
-
-static void __exit xfrmi_fini(void)
-{
-	xfrm_if_unregister_cb();
-	rtnl_link_unregister(&xfrmi_link_ops);
-	xfrmi4_fini();
-	xfrmi6_fini();
-	unregister_pernet_device(&xfrmi_net_ops);
-}
-
-module_init(xfrmi_init);
-module_exit(xfrmi_fini);
-MODULE_LICENSE("GPL");
-MODULE_ALIAS_RTNL_LINK("xfrm");
-MODULE_ALIAS_NETDEV("xfrm0");
-MODULE_AUTHOR("Steffen Klassert");
-MODULE_DESCRIPTION("XFRM virtual interface");
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
new file mode 100644
index 000000000000..694eec6ca147
--- /dev/null
+++ b/net/xfrm/xfrm_interface_core.c
@@ -0,0 +1,1078 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *	XFRM virtual interface
+ *
+ *	Copyright (C) 2018 secunet Security Networks AG
+ *
+ *	Author:
+ *	Steffen Klassert <steffen.klassert@secunet.com>
+ */
+
+#include <linux/module.h>
+#include <linux/capability.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/sockios.h>
+#include <linux/icmp.h>
+#include <linux/if.h>
+#include <linux/in.h>
+#include <linux/ip.h>
+#include <linux/net.h>
+#include <linux/in6.h>
+#include <linux/netdevice.h>
+#include <linux/if_link.h>
+#include <linux/if_arp.h>
+#include <linux/icmpv6.h>
+#include <linux/init.h>
+#include <linux/route.h>
+#include <linux/rtnetlink.h>
+#include <linux/netfilter_ipv6.h>
+#include <linux/slab.h>
+#include <linux/hash.h>
+
+#include <linux/uaccess.h>
+#include <linux/atomic.h>
+
+#include <net/icmp.h>
+#include <net/ip.h>
+#include <net/ipv6.h>
+#include <net/ip6_route.h>
+#include <net/ip_tunnels.h>
+#include <net/addrconf.h>
+#include <net/xfrm.h>
+#include <net/net_namespace.h>
+#include <net/netns/generic.h>
+#include <linux/etherdevice.h>
+
+static int xfrmi_dev_init(struct net_device *dev);
+static void xfrmi_dev_setup(struct net_device *dev);
+static struct rtnl_link_ops xfrmi_link_ops __read_mostly;
+static unsigned int xfrmi_net_id __read_mostly;
+static const struct net_device_ops xfrmi_netdev_ops;
+
+#define XFRMI_HASH_BITS	8
+#define XFRMI_HASH_SIZE	BIT(XFRMI_HASH_BITS)
+
+struct xfrmi_net {
+	/* lists for storing interfaces in use */
+	struct xfrm_if __rcu *xfrmi[XFRMI_HASH_SIZE];
+};
+
+#define for_each_xfrmi_rcu(start, xi) \
+	for (xi = rcu_dereference(start); xi; xi = rcu_dereference(xi->next))
+
+static u32 xfrmi_hash(u32 if_id)
+{
+	return hash_32(if_id, XFRMI_HASH_BITS);
+}
+
+static struct xfrm_if *xfrmi_lookup(struct net *net, struct xfrm_state *x)
+{
+	struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
+	struct xfrm_if *xi;
+
+	for_each_xfrmi_rcu(xfrmn->xfrmi[xfrmi_hash(x->if_id)], xi) {
+		if (x->if_id == xi->p.if_id &&
+		    (xi->dev->flags & IFF_UP))
+			return xi;
+	}
+
+	return NULL;
+}
+
+static struct xfrm_if *xfrmi_decode_session(struct sk_buff *skb,
+					    unsigned short family)
+{
+	struct net_device *dev;
+	int ifindex = 0;
+
+	if (!secpath_exists(skb) || !skb->dev)
+		return NULL;
+
+	switch (family) {
+	case AF_INET6:
+		ifindex = inet6_sdif(skb);
+		break;
+	case AF_INET:
+		ifindex = inet_sdif(skb);
+		break;
+	}
+
+	if (ifindex) {
+		struct net *net = xs_net(xfrm_input_state(skb));
+
+		dev = dev_get_by_index_rcu(net, ifindex);
+	} else {
+		dev = skb->dev;
+	}
+
+	if (!dev || !(dev->flags & IFF_UP))
+		return NULL;
+	if (dev->netdev_ops != &xfrmi_netdev_ops)
+		return NULL;
+
+	return netdev_priv(dev);
+}
+
+static void xfrmi_link(struct xfrmi_net *xfrmn, struct xfrm_if *xi)
+{
+	struct xfrm_if __rcu **xip = &xfrmn->xfrmi[xfrmi_hash(xi->p.if_id)];
+
+	rcu_assign_pointer(xi->next , rtnl_dereference(*xip));
+	rcu_assign_pointer(*xip, xi);
+}
+
+static void xfrmi_unlink(struct xfrmi_net *xfrmn, struct xfrm_if *xi)
+{
+	struct xfrm_if __rcu **xip;
+	struct xfrm_if *iter;
+
+	for (xip = &xfrmn->xfrmi[xfrmi_hash(xi->p.if_id)];
+	     (iter = rtnl_dereference(*xip)) != NULL;
+	     xip = &iter->next) {
+		if (xi == iter) {
+			rcu_assign_pointer(*xip, xi->next);
+			break;
+		}
+	}
+}
+
+static void xfrmi_dev_free(struct net_device *dev)
+{
+	struct xfrm_if *xi = netdev_priv(dev);
+
+	gro_cells_destroy(&xi->gro_cells);
+	free_percpu(dev->tstats);
+}
+
+static int xfrmi_create(struct net_device *dev)
+{
+	struct xfrm_if *xi = netdev_priv(dev);
+	struct net *net = dev_net(dev);
+	struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
+	int err;
+
+	dev->rtnl_link_ops = &xfrmi_link_ops;
+	err = register_netdevice(dev);
+	if (err < 0)
+		goto out;
+
+	xfrmi_link(xfrmn, xi);
+
+	return 0;
+
+out:
+	return err;
+}
+
+static struct xfrm_if *xfrmi_locate(struct net *net, struct xfrm_if_parms *p)
+{
+	struct xfrm_if __rcu **xip;
+	struct xfrm_if *xi;
+	struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
+
+	for (xip = &xfrmn->xfrmi[xfrmi_hash(p->if_id)];
+	     (xi = rtnl_dereference(*xip)) != NULL;
+	     xip = &xi->next)
+		if (xi->p.if_id == p->if_id)
+			return xi;
+
+	return NULL;
+}
+
+static void xfrmi_dev_uninit(struct net_device *dev)
+{
+	struct xfrm_if *xi = netdev_priv(dev);
+	struct xfrmi_net *xfrmn = net_generic(xi->net, xfrmi_net_id);
+
+	xfrmi_unlink(xfrmn, xi);
+}
+
+static void xfrmi_scrub_packet(struct sk_buff *skb, bool xnet)
+{
+	skb->tstamp = 0;
+	skb->pkt_type = PACKET_HOST;
+	skb->skb_iif = 0;
+	skb->ignore_df = 0;
+	skb_dst_drop(skb);
+	nf_reset_ct(skb);
+	nf_reset_trace(skb);
+
+	if (!xnet)
+		return;
+
+	ipvs_reset(skb);
+	secpath_reset(skb);
+	skb_orphan(skb);
+	skb->mark = 0;
+}
+
+static int xfrmi_input(struct sk_buff *skb, int nexthdr, __be32 spi,
+		       int encap_type, unsigned short family)
+{
+	struct sec_path *sp;
+
+	sp = skb_sec_path(skb);
+	if (sp && (sp->len || sp->olen) &&
+	    !xfrm_policy_check(NULL, XFRM_POLICY_IN, skb, family))
+		goto discard;
+
+	XFRM_SPI_SKB_CB(skb)->family = family;
+	if (family == AF_INET) {
+		XFRM_SPI_SKB_CB(skb)->daddroff = offsetof(struct iphdr, daddr);
+		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 = NULL;
+	} else {
+		XFRM_SPI_SKB_CB(skb)->daddroff = offsetof(struct ipv6hdr, daddr);
+		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip6 = NULL;
+	}
+
+	return xfrm_input(skb, nexthdr, spi, encap_type);
+discard:
+	kfree_skb(skb);
+	return 0;
+}
+
+static int xfrmi4_rcv(struct sk_buff *skb)
+{
+	return xfrmi_input(skb, ip_hdr(skb)->protocol, 0, 0, AF_INET);
+}
+
+static int xfrmi6_rcv(struct sk_buff *skb)
+{
+	return xfrmi_input(skb, skb_network_header(skb)[IP6CB(skb)->nhoff],
+			   0, 0, AF_INET6);
+}
+
+static int xfrmi4_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
+{
+	return xfrmi_input(skb, nexthdr, spi, encap_type, AF_INET);
+}
+
+static int xfrmi6_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
+{
+	return xfrmi_input(skb, nexthdr, spi, encap_type, AF_INET6);
+}
+
+static int xfrmi_rcv_cb(struct sk_buff *skb, int err)
+{
+	const struct xfrm_mode *inner_mode;
+	struct net_device *dev;
+	struct xfrm_state *x;
+	struct xfrm_if *xi;
+	bool xnet;
+
+	if (err && !secpath_exists(skb))
+		return 0;
+
+	x = xfrm_input_state(skb);
+
+	xi = xfrmi_lookup(xs_net(x), x);
+	if (!xi)
+		return 1;
+
+	dev = xi->dev;
+	skb->dev = dev;
+
+	if (err) {
+		dev->stats.rx_errors++;
+		dev->stats.rx_dropped++;
+
+		return 0;
+	}
+
+	xnet = !net_eq(xi->net, dev_net(skb->dev));
+
+	if (xnet) {
+		inner_mode = &x->inner_mode;
+
+		if (x->sel.family == AF_UNSPEC) {
+			inner_mode = xfrm_ip2inner_mode(x, XFRM_MODE_SKB_CB(skb)->protocol);
+			if (inner_mode == NULL) {
+				XFRM_INC_STATS(dev_net(skb->dev),
+					       LINUX_MIB_XFRMINSTATEMODEERROR);
+				return -EINVAL;
+			}
+		}
+
+		if (!xfrm_policy_check(NULL, XFRM_POLICY_IN, skb,
+				       inner_mode->family))
+			return -EPERM;
+	}
+
+	xfrmi_scrub_packet(skb, xnet);
+	dev_sw_netstats_rx_add(dev, skb->len);
+
+	return 0;
+}
+
+static int
+xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
+{
+	struct xfrm_if *xi = netdev_priv(dev);
+	struct net_device_stats *stats = &xi->dev->stats;
+	struct dst_entry *dst = skb_dst(skb);
+	unsigned int length = skb->len;
+	struct net_device *tdev;
+	struct xfrm_state *x;
+	int err = -1;
+	int mtu;
+
+	dst_hold(dst);
+	dst = xfrm_lookup_with_ifid(xi->net, dst, fl, NULL, 0, xi->p.if_id);
+	if (IS_ERR(dst)) {
+		err = PTR_ERR(dst);
+		dst = NULL;
+		goto tx_err_link_failure;
+	}
+
+	x = dst->xfrm;
+	if (!x)
+		goto tx_err_link_failure;
+
+	if (x->if_id != xi->p.if_id)
+		goto tx_err_link_failure;
+
+	tdev = dst->dev;
+
+	if (tdev == dev) {
+		stats->collisions++;
+		net_warn_ratelimited("%s: Local routing loop detected!\n",
+				     dev->name);
+		goto tx_err_dst_release;
+	}
+
+	mtu = dst_mtu(dst);
+	if ((!skb_is_gso(skb) && skb->len > mtu) ||
+	    (skb_is_gso(skb) && !skb_gso_validate_network_len(skb, mtu))) {
+		skb_dst_update_pmtu_no_confirm(skb, mtu);
+
+		if (skb->protocol == htons(ETH_P_IPV6)) {
+			if (mtu < IPV6_MIN_MTU)
+				mtu = IPV6_MIN_MTU;
+
+			if (skb->len > 1280)
+				icmpv6_ndo_send(skb, ICMPV6_PKT_TOOBIG, 0, mtu);
+			else
+				goto xmit;
+		} else {
+			if (!(ip_hdr(skb)->frag_off & htons(IP_DF)))
+				goto xmit;
+			icmp_ndo_send(skb, ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED,
+				      htonl(mtu));
+		}
+
+		dst_release(dst);
+		return -EMSGSIZE;
+	}
+
+xmit:
+	xfrmi_scrub_packet(skb, !net_eq(xi->net, dev_net(dev)));
+	skb_dst_set(skb, dst);
+	skb->dev = tdev;
+
+	err = dst_output(xi->net, skb->sk, skb);
+	if (net_xmit_eval(err) == 0) {
+		dev_sw_netstats_tx_add(dev, 1, length);
+	} else {
+		stats->tx_errors++;
+		stats->tx_aborted_errors++;
+	}
+
+	return 0;
+tx_err_link_failure:
+	stats->tx_carrier_errors++;
+	dst_link_failure(skb);
+tx_err_dst_release:
+	dst_release(dst);
+	return err;
+}
+
+static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct xfrm_if *xi = netdev_priv(dev);
+	struct net_device_stats *stats = &xi->dev->stats;
+	struct dst_entry *dst = skb_dst(skb);
+	struct flowi fl;
+	int ret;
+
+	memset(&fl, 0, sizeof(fl));
+
+	switch (skb->protocol) {
+	case htons(ETH_P_IPV6):
+		xfrm_decode_session(skb, &fl, AF_INET6);
+		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+		if (!dst) {
+			fl.u.ip6.flowi6_oif = dev->ifindex;
+			fl.u.ip6.flowi6_flags |= FLOWI_FLAG_ANYSRC;
+			dst = ip6_route_output(dev_net(dev), NULL, &fl.u.ip6);
+			if (dst->error) {
+				dst_release(dst);
+				stats->tx_carrier_errors++;
+				goto tx_err;
+			}
+			skb_dst_set(skb, dst);
+		}
+		break;
+	case htons(ETH_P_IP):
+		xfrm_decode_session(skb, &fl, AF_INET);
+		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+		if (!dst) {
+			struct rtable *rt;
+
+			fl.u.ip4.flowi4_oif = dev->ifindex;
+			fl.u.ip4.flowi4_flags |= FLOWI_FLAG_ANYSRC;
+			rt = __ip_route_output_key(dev_net(dev), &fl.u.ip4);
+			if (IS_ERR(rt)) {
+				stats->tx_carrier_errors++;
+				goto tx_err;
+			}
+			skb_dst_set(skb, &rt->dst);
+		}
+		break;
+	default:
+		goto tx_err;
+	}
+
+	fl.flowi_oif = xi->p.link;
+
+	ret = xfrmi_xmit2(skb, dev, &fl);
+	if (ret < 0)
+		goto tx_err;
+
+	return NETDEV_TX_OK;
+
+tx_err:
+	stats->tx_errors++;
+	stats->tx_dropped++;
+	kfree_skb(skb);
+	return NETDEV_TX_OK;
+}
+
+static int xfrmi4_err(struct sk_buff *skb, u32 info)
+{
+	const struct iphdr *iph = (const struct iphdr *)skb->data;
+	struct net *net = dev_net(skb->dev);
+	int protocol = iph->protocol;
+	struct ip_comp_hdr *ipch;
+	struct ip_esp_hdr *esph;
+	struct ip_auth_hdr *ah ;
+	struct xfrm_state *x;
+	struct xfrm_if *xi;
+	__be32 spi;
+
+	switch (protocol) {
+	case IPPROTO_ESP:
+		esph = (struct ip_esp_hdr *)(skb->data+(iph->ihl<<2));
+		spi = esph->spi;
+		break;
+	case IPPROTO_AH:
+		ah = (struct ip_auth_hdr *)(skb->data+(iph->ihl<<2));
+		spi = ah->spi;
+		break;
+	case IPPROTO_COMP:
+		ipch = (struct ip_comp_hdr *)(skb->data+(iph->ihl<<2));
+		spi = htonl(ntohs(ipch->cpi));
+		break;
+	default:
+		return 0;
+	}
+
+	switch (icmp_hdr(skb)->type) {
+	case ICMP_DEST_UNREACH:
+		if (icmp_hdr(skb)->code != ICMP_FRAG_NEEDED)
+			return 0;
+		break;
+	case ICMP_REDIRECT:
+		break;
+	default:
+		return 0;
+	}
+
+	x = xfrm_state_lookup(net, skb->mark, (const xfrm_address_t *)&iph->daddr,
+			      spi, protocol, AF_INET);
+	if (!x)
+		return 0;
+
+	xi = xfrmi_lookup(net, x);
+	if (!xi) {
+		xfrm_state_put(x);
+		return -1;
+	}
+
+	if (icmp_hdr(skb)->type == ICMP_DEST_UNREACH)
+		ipv4_update_pmtu(skb, net, info, 0, protocol);
+	else
+		ipv4_redirect(skb, net, 0, protocol);
+	xfrm_state_put(x);
+
+	return 0;
+}
+
+static int xfrmi6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
+		    u8 type, u8 code, int offset, __be32 info)
+{
+	const struct ipv6hdr *iph = (const struct ipv6hdr *)skb->data;
+	struct net *net = dev_net(skb->dev);
+	int protocol = iph->nexthdr;
+	struct ip_comp_hdr *ipch;
+	struct ip_esp_hdr *esph;
+	struct ip_auth_hdr *ah;
+	struct xfrm_state *x;
+	struct xfrm_if *xi;
+	__be32 spi;
+
+	switch (protocol) {
+	case IPPROTO_ESP:
+		esph = (struct ip_esp_hdr *)(skb->data + offset);
+		spi = esph->spi;
+		break;
+	case IPPROTO_AH:
+		ah = (struct ip_auth_hdr *)(skb->data + offset);
+		spi = ah->spi;
+		break;
+	case IPPROTO_COMP:
+		ipch = (struct ip_comp_hdr *)(skb->data + offset);
+		spi = htonl(ntohs(ipch->cpi));
+		break;
+	default:
+		return 0;
+	}
+
+	if (type != ICMPV6_PKT_TOOBIG &&
+	    type != NDISC_REDIRECT)
+		return 0;
+
+	x = xfrm_state_lookup(net, skb->mark, (const xfrm_address_t *)&iph->daddr,
+			      spi, protocol, AF_INET6);
+	if (!x)
+		return 0;
+
+	xi = xfrmi_lookup(net, x);
+	if (!xi) {
+		xfrm_state_put(x);
+		return -1;
+	}
+
+	if (type == NDISC_REDIRECT)
+		ip6_redirect(skb, net, skb->dev->ifindex, 0,
+			     sock_net_uid(net, NULL));
+	else
+		ip6_update_pmtu(skb, net, info, 0, 0, sock_net_uid(net, NULL));
+	xfrm_state_put(x);
+
+	return 0;
+}
+
+static int xfrmi_change(struct xfrm_if *xi, const struct xfrm_if_parms *p)
+{
+	if (xi->p.link != p->link)
+		return -EINVAL;
+
+	xi->p.if_id = p->if_id;
+
+	return 0;
+}
+
+static int xfrmi_update(struct xfrm_if *xi, struct xfrm_if_parms *p)
+{
+	struct net *net = xi->net;
+	struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
+	int err;
+
+	xfrmi_unlink(xfrmn, xi);
+	synchronize_net();
+	err = xfrmi_change(xi, p);
+	xfrmi_link(xfrmn, xi);
+	netdev_state_change(xi->dev);
+	return err;
+}
+
+static int xfrmi_get_iflink(const struct net_device *dev)
+{
+	struct xfrm_if *xi = netdev_priv(dev);
+
+	return xi->p.link;
+}
+
+static const struct net_device_ops xfrmi_netdev_ops = {
+	.ndo_init	= xfrmi_dev_init,
+	.ndo_uninit	= xfrmi_dev_uninit,
+	.ndo_start_xmit = xfrmi_xmit,
+	.ndo_get_stats64 = dev_get_tstats64,
+	.ndo_get_iflink = xfrmi_get_iflink,
+};
+
+static void xfrmi_dev_setup(struct net_device *dev)
+{
+	dev->netdev_ops 	= &xfrmi_netdev_ops;
+	dev->header_ops		= &ip_tunnel_header_ops;
+	dev->type		= ARPHRD_NONE;
+	dev->mtu		= ETH_DATA_LEN;
+	dev->min_mtu		= ETH_MIN_MTU;
+	dev->max_mtu		= IP_MAX_MTU;
+	dev->flags 		= IFF_NOARP;
+	dev->needs_free_netdev	= true;
+	dev->priv_destructor	= xfrmi_dev_free;
+	netif_keep_dst(dev);
+
+	eth_broadcast_addr(dev->broadcast);
+}
+
+#define XFRMI_FEATURES (NETIF_F_SG |		\
+			NETIF_F_FRAGLIST |	\
+			NETIF_F_GSO_SOFTWARE |	\
+			NETIF_F_HW_CSUM)
+
+static int xfrmi_dev_init(struct net_device *dev)
+{
+	struct xfrm_if *xi = netdev_priv(dev);
+	struct net_device *phydev = __dev_get_by_index(xi->net, xi->p.link);
+	int err;
+
+	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
+	if (!dev->tstats)
+		return -ENOMEM;
+
+	err = gro_cells_init(&xi->gro_cells, dev);
+	if (err) {
+		free_percpu(dev->tstats);
+		return err;
+	}
+
+	dev->features |= NETIF_F_LLTX;
+	dev->features |= XFRMI_FEATURES;
+	dev->hw_features |= XFRMI_FEATURES;
+
+	if (phydev) {
+		dev->needed_headroom = phydev->needed_headroom;
+		dev->needed_tailroom = phydev->needed_tailroom;
+
+		if (is_zero_ether_addr(dev->dev_addr))
+			eth_hw_addr_inherit(dev, phydev);
+		if (is_zero_ether_addr(dev->broadcast))
+			memcpy(dev->broadcast, phydev->broadcast,
+			       dev->addr_len);
+	} else {
+		eth_hw_addr_random(dev);
+		eth_broadcast_addr(dev->broadcast);
+	}
+
+	return 0;
+}
+
+static int xfrmi_validate(struct nlattr *tb[], struct nlattr *data[],
+			 struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static void xfrmi_netlink_parms(struct nlattr *data[],
+			       struct xfrm_if_parms *parms)
+{
+	memset(parms, 0, sizeof(*parms));
+
+	if (!data)
+		return;
+
+	if (data[IFLA_XFRM_LINK])
+		parms->link = nla_get_u32(data[IFLA_XFRM_LINK]);
+
+	if (data[IFLA_XFRM_IF_ID])
+		parms->if_id = nla_get_u32(data[IFLA_XFRM_IF_ID]);
+}
+
+static int xfrmi_newlink(struct net *src_net, struct net_device *dev,
+			struct nlattr *tb[], struct nlattr *data[],
+			struct netlink_ext_ack *extack)
+{
+	struct net *net = dev_net(dev);
+	struct xfrm_if_parms p = {};
+	struct xfrm_if *xi;
+	int err;
+
+	xfrmi_netlink_parms(data, &p);
+	if (!p.if_id) {
+		NL_SET_ERR_MSG(extack, "if_id must be non zero");
+		return -EINVAL;
+	}
+
+	xi = xfrmi_locate(net, &p);
+	if (xi)
+		return -EEXIST;
+
+	xi = netdev_priv(dev);
+	xi->p = p;
+	xi->net = net;
+	xi->dev = dev;
+
+	err = xfrmi_create(dev);
+	return err;
+}
+
+static void xfrmi_dellink(struct net_device *dev, struct list_head *head)
+{
+	unregister_netdevice_queue(dev, head);
+}
+
+static int xfrmi_changelink(struct net_device *dev, struct nlattr *tb[],
+			   struct nlattr *data[],
+			   struct netlink_ext_ack *extack)
+{
+	struct xfrm_if *xi = netdev_priv(dev);
+	struct net *net = xi->net;
+	struct xfrm_if_parms p = {};
+
+	xfrmi_netlink_parms(data, &p);
+	if (!p.if_id) {
+		NL_SET_ERR_MSG(extack, "if_id must be non zero");
+		return -EINVAL;
+	}
+
+	xi = xfrmi_locate(net, &p);
+	if (!xi) {
+		xi = netdev_priv(dev);
+	} else {
+		if (xi->dev != dev)
+			return -EEXIST;
+	}
+
+	return xfrmi_update(xi, &p);
+}
+
+static size_t xfrmi_get_size(const struct net_device *dev)
+{
+	return
+		/* IFLA_XFRM_LINK */
+		nla_total_size(4) +
+		/* IFLA_XFRM_IF_ID */
+		nla_total_size(4) +
+		0;
+}
+
+static int xfrmi_fill_info(struct sk_buff *skb, const struct net_device *dev)
+{
+	struct xfrm_if *xi = netdev_priv(dev);
+	struct xfrm_if_parms *parm = &xi->p;
+
+	if (nla_put_u32(skb, IFLA_XFRM_LINK, parm->link) ||
+	    nla_put_u32(skb, IFLA_XFRM_IF_ID, parm->if_id))
+		goto nla_put_failure;
+	return 0;
+
+nla_put_failure:
+	return -EMSGSIZE;
+}
+
+static struct net *xfrmi_get_link_net(const struct net_device *dev)
+{
+	struct xfrm_if *xi = netdev_priv(dev);
+
+	return xi->net;
+}
+
+static const struct nla_policy xfrmi_policy[IFLA_XFRM_MAX + 1] = {
+	[IFLA_XFRM_LINK]	= { .type = NLA_U32 },
+	[IFLA_XFRM_IF_ID]	= { .type = NLA_U32 },
+};
+
+static struct rtnl_link_ops xfrmi_link_ops __read_mostly = {
+	.kind		= "xfrm",
+	.maxtype	= IFLA_XFRM_MAX,
+	.policy		= xfrmi_policy,
+	.priv_size	= sizeof(struct xfrm_if),
+	.setup		= xfrmi_dev_setup,
+	.validate	= xfrmi_validate,
+	.newlink	= xfrmi_newlink,
+	.dellink	= xfrmi_dellink,
+	.changelink	= xfrmi_changelink,
+	.get_size	= xfrmi_get_size,
+	.fill_info	= xfrmi_fill_info,
+	.get_link_net	= xfrmi_get_link_net,
+};
+
+static void __net_exit xfrmi_exit_batch_net(struct list_head *net_exit_list)
+{
+	struct net *net;
+	LIST_HEAD(list);
+
+	rtnl_lock();
+	list_for_each_entry(net, net_exit_list, exit_list) {
+		struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
+		struct xfrm_if __rcu **xip;
+		struct xfrm_if *xi;
+		int i;
+
+		for (i = 0; i < XFRMI_HASH_SIZE; i++) {
+			for (xip = &xfrmn->xfrmi[i];
+			     (xi = rtnl_dereference(*xip)) != NULL;
+			     xip = &xi->next)
+				unregister_netdevice_queue(xi->dev, &list);
+		}
+	}
+	unregister_netdevice_many(&list);
+	rtnl_unlock();
+}
+
+static struct pernet_operations xfrmi_net_ops = {
+	.exit_batch = xfrmi_exit_batch_net,
+	.id   = &xfrmi_net_id,
+	.size = sizeof(struct xfrmi_net),
+};
+
+static struct xfrm6_protocol xfrmi_esp6_protocol __read_mostly = {
+	.handler	=	xfrmi6_rcv,
+	.input_handler	=	xfrmi6_input,
+	.cb_handler	=	xfrmi_rcv_cb,
+	.err_handler	=	xfrmi6_err,
+	.priority	=	10,
+};
+
+static struct xfrm6_protocol xfrmi_ah6_protocol __read_mostly = {
+	.handler	=	xfrm6_rcv,
+	.input_handler	=	xfrm_input,
+	.cb_handler	=	xfrmi_rcv_cb,
+	.err_handler	=	xfrmi6_err,
+	.priority	=	10,
+};
+
+static struct xfrm6_protocol xfrmi_ipcomp6_protocol __read_mostly = {
+	.handler	=	xfrm6_rcv,
+	.input_handler	=	xfrm_input,
+	.cb_handler	=	xfrmi_rcv_cb,
+	.err_handler	=	xfrmi6_err,
+	.priority	=	10,
+};
+
+#if IS_REACHABLE(CONFIG_INET6_XFRM_TUNNEL)
+static int xfrmi6_rcv_tunnel(struct sk_buff *skb)
+{
+	const xfrm_address_t *saddr;
+	__be32 spi;
+
+	saddr = (const xfrm_address_t *)&ipv6_hdr(skb)->saddr;
+	spi = xfrm6_tunnel_spi_lookup(dev_net(skb->dev), saddr);
+
+	return xfrm6_rcv_spi(skb, IPPROTO_IPV6, spi, NULL);
+}
+
+static struct xfrm6_tunnel xfrmi_ipv6_handler __read_mostly = {
+	.handler	=	xfrmi6_rcv_tunnel,
+	.cb_handler	=	xfrmi_rcv_cb,
+	.err_handler	=	xfrmi6_err,
+	.priority	=	2,
+};
+
+static struct xfrm6_tunnel xfrmi_ip6ip_handler __read_mostly = {
+	.handler	=	xfrmi6_rcv_tunnel,
+	.cb_handler	=	xfrmi_rcv_cb,
+	.err_handler	=	xfrmi6_err,
+	.priority	=	2,
+};
+#endif
+
+static struct xfrm4_protocol xfrmi_esp4_protocol __read_mostly = {
+	.handler	=	xfrmi4_rcv,
+	.input_handler	=	xfrmi4_input,
+	.cb_handler	=	xfrmi_rcv_cb,
+	.err_handler	=	xfrmi4_err,
+	.priority	=	10,
+};
+
+static struct xfrm4_protocol xfrmi_ah4_protocol __read_mostly = {
+	.handler	=	xfrm4_rcv,
+	.input_handler	=	xfrm_input,
+	.cb_handler	=	xfrmi_rcv_cb,
+	.err_handler	=	xfrmi4_err,
+	.priority	=	10,
+};
+
+static struct xfrm4_protocol xfrmi_ipcomp4_protocol __read_mostly = {
+	.handler	=	xfrm4_rcv,
+	.input_handler	=	xfrm_input,
+	.cb_handler	=	xfrmi_rcv_cb,
+	.err_handler	=	xfrmi4_err,
+	.priority	=	10,
+};
+
+#if IS_REACHABLE(CONFIG_INET_XFRM_TUNNEL)
+static int xfrmi4_rcv_tunnel(struct sk_buff *skb)
+{
+	return xfrm4_rcv_spi(skb, IPPROTO_IPIP, ip_hdr(skb)->saddr);
+}
+
+static struct xfrm_tunnel xfrmi_ipip_handler __read_mostly = {
+	.handler	=	xfrmi4_rcv_tunnel,
+	.cb_handler	=	xfrmi_rcv_cb,
+	.err_handler	=	xfrmi4_err,
+	.priority	=	3,
+};
+
+static struct xfrm_tunnel xfrmi_ipip6_handler __read_mostly = {
+	.handler	=	xfrmi4_rcv_tunnel,
+	.cb_handler	=	xfrmi_rcv_cb,
+	.err_handler	=	xfrmi4_err,
+	.priority	=	2,
+};
+#endif
+
+static int __init xfrmi4_init(void)
+{
+	int err;
+
+	err = xfrm4_protocol_register(&xfrmi_esp4_protocol, IPPROTO_ESP);
+	if (err < 0)
+		goto xfrm_proto_esp_failed;
+	err = xfrm4_protocol_register(&xfrmi_ah4_protocol, IPPROTO_AH);
+	if (err < 0)
+		goto xfrm_proto_ah_failed;
+	err = xfrm4_protocol_register(&xfrmi_ipcomp4_protocol, IPPROTO_COMP);
+	if (err < 0)
+		goto xfrm_proto_comp_failed;
+#if IS_REACHABLE(CONFIG_INET_XFRM_TUNNEL)
+	err = xfrm4_tunnel_register(&xfrmi_ipip_handler, AF_INET);
+	if (err < 0)
+		goto xfrm_tunnel_ipip_failed;
+	err = xfrm4_tunnel_register(&xfrmi_ipip6_handler, AF_INET6);
+	if (err < 0)
+		goto xfrm_tunnel_ipip6_failed;
+#endif
+
+	return 0;
+
+#if IS_REACHABLE(CONFIG_INET_XFRM_TUNNEL)
+xfrm_tunnel_ipip6_failed:
+	xfrm4_tunnel_deregister(&xfrmi_ipip_handler, AF_INET);
+xfrm_tunnel_ipip_failed:
+	xfrm4_protocol_deregister(&xfrmi_ipcomp4_protocol, IPPROTO_COMP);
+#endif
+xfrm_proto_comp_failed:
+	xfrm4_protocol_deregister(&xfrmi_ah4_protocol, IPPROTO_AH);
+xfrm_proto_ah_failed:
+	xfrm4_protocol_deregister(&xfrmi_esp4_protocol, IPPROTO_ESP);
+xfrm_proto_esp_failed:
+	return err;
+}
+
+static void xfrmi4_fini(void)
+{
+#if IS_REACHABLE(CONFIG_INET_XFRM_TUNNEL)
+	xfrm4_tunnel_deregister(&xfrmi_ipip6_handler, AF_INET6);
+	xfrm4_tunnel_deregister(&xfrmi_ipip_handler, AF_INET);
+#endif
+	xfrm4_protocol_deregister(&xfrmi_ipcomp4_protocol, IPPROTO_COMP);
+	xfrm4_protocol_deregister(&xfrmi_ah4_protocol, IPPROTO_AH);
+	xfrm4_protocol_deregister(&xfrmi_esp4_protocol, IPPROTO_ESP);
+}
+
+static int __init xfrmi6_init(void)
+{
+	int err;
+
+	err = xfrm6_protocol_register(&xfrmi_esp6_protocol, IPPROTO_ESP);
+	if (err < 0)
+		goto xfrm_proto_esp_failed;
+	err = xfrm6_protocol_register(&xfrmi_ah6_protocol, IPPROTO_AH);
+	if (err < 0)
+		goto xfrm_proto_ah_failed;
+	err = xfrm6_protocol_register(&xfrmi_ipcomp6_protocol, IPPROTO_COMP);
+	if (err < 0)
+		goto xfrm_proto_comp_failed;
+#if IS_REACHABLE(CONFIG_INET6_XFRM_TUNNEL)
+	err = xfrm6_tunnel_register(&xfrmi_ipv6_handler, AF_INET6);
+	if (err < 0)
+		goto xfrm_tunnel_ipv6_failed;
+	err = xfrm6_tunnel_register(&xfrmi_ip6ip_handler, AF_INET);
+	if (err < 0)
+		goto xfrm_tunnel_ip6ip_failed;
+#endif
+
+	return 0;
+
+#if IS_REACHABLE(CONFIG_INET6_XFRM_TUNNEL)
+xfrm_tunnel_ip6ip_failed:
+	xfrm6_tunnel_deregister(&xfrmi_ipv6_handler, AF_INET6);
+xfrm_tunnel_ipv6_failed:
+	xfrm6_protocol_deregister(&xfrmi_ipcomp6_protocol, IPPROTO_COMP);
+#endif
+xfrm_proto_comp_failed:
+	xfrm6_protocol_deregister(&xfrmi_ah6_protocol, IPPROTO_AH);
+xfrm_proto_ah_failed:
+	xfrm6_protocol_deregister(&xfrmi_esp6_protocol, IPPROTO_ESP);
+xfrm_proto_esp_failed:
+	return err;
+}
+
+static void xfrmi6_fini(void)
+{
+#if IS_REACHABLE(CONFIG_INET6_XFRM_TUNNEL)
+	xfrm6_tunnel_deregister(&xfrmi_ip6ip_handler, AF_INET);
+	xfrm6_tunnel_deregister(&xfrmi_ipv6_handler, AF_INET6);
+#endif
+	xfrm6_protocol_deregister(&xfrmi_ipcomp6_protocol, IPPROTO_COMP);
+	xfrm6_protocol_deregister(&xfrmi_ah6_protocol, IPPROTO_AH);
+	xfrm6_protocol_deregister(&xfrmi_esp6_protocol, IPPROTO_ESP);
+}
+
+static const struct xfrm_if_cb xfrm_if_cb = {
+	.decode_session =	xfrmi_decode_session,
+};
+
+static int __init xfrmi_init(void)
+{
+	const char *msg;
+	int err;
+
+	pr_info("IPsec XFRM device driver\n");
+
+	msg = "tunnel device";
+	err = register_pernet_device(&xfrmi_net_ops);
+	if (err < 0)
+		goto pernet_dev_failed;
+
+	msg = "xfrm4 protocols";
+	err = xfrmi4_init();
+	if (err < 0)
+		goto xfrmi4_failed;
+
+	msg = "xfrm6 protocols";
+	err = xfrmi6_init();
+	if (err < 0)
+		goto xfrmi6_failed;
+
+
+	msg = "netlink interface";
+	err = rtnl_link_register(&xfrmi_link_ops);
+	if (err < 0)
+		goto rtnl_link_failed;
+
+	xfrm_if_register_cb(&xfrm_if_cb);
+
+	return err;
+
+rtnl_link_failed:
+	xfrmi6_fini();
+xfrmi6_failed:
+	xfrmi4_fini();
+xfrmi4_failed:
+	unregister_pernet_device(&xfrmi_net_ops);
+pernet_dev_failed:
+	pr_err("xfrmi init: failed to register %s\n", msg);
+	return err;
+}
+
+static void __exit xfrmi_fini(void)
+{
+	xfrm_if_unregister_cb();
+	rtnl_link_unregister(&xfrmi_link_ops);
+	xfrmi4_fini();
+	xfrmi6_fini();
+	unregister_pernet_device(&xfrmi_net_ops);
+}
+
+module_init(xfrmi_init);
+module_exit(xfrmi_fini);
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_RTNL_LINK("xfrm");
+MODULE_ALIAS_NETDEV("xfrm0");
+MODULE_AUTHOR("Steffen Klassert");
+MODULE_DESCRIPTION("XFRM virtual interface");
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 3e28a84ab922..b0a19cc92879 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3275,6 +3275,13 @@ xfrm_policy_ok(const struct xfrm_tmpl *tmpl, const struct sec_path *sp, int star
 		if (xfrm_state_ok(tmpl, sp->xvec[idx], family, if_id))
 			return ++idx;
 		if (sp->xvec[idx]->props.mode != XFRM_MODE_TRANSPORT) {
+			if (idx < sp->verified_cnt) {
+				/* Secpath entry previously verified, consider optional and
+				 * continue searching
+				 */
+				continue;
+			}
+
 			if (start == -1)
 				start = -2-idx;
 			break;
@@ -3647,6 +3654,9 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 		 * Order is _important_. Later we will implement
 		 * some barriers, but at the moment barriers
 		 * are implied between each two transformations.
+		 * Upon success, marks secpath entries as having been
+		 * verified to allow them to be skipped in future policy
+		 * checks (e.g. nested tunnels).
 		 */
 		for (i = xfrm_nr-1, k = 0; i >= 0; i--) {
 			k = xfrm_policy_ok(tpp[i], sp, k, family, if_id);
@@ -3665,6 +3675,8 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 		}
 
 		xfrm_pols_put(pols, npols);
+		sp->verified_cnt = k;
+
 		return 1;
 	}
 	XFRM_INC_STATS(net, LINUX_MIB_XFRMINPOLBLOCK);
diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 27589900f4fb..f7ff130a9485 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -1866,6 +1866,30 @@ static const struct dmi_system_id nau8824_quirk_table[] = {
 		},
 		.driver_data = (void *)(NAU8824_JD_ACTIVE_HIGH),
 	},
+	{
+		/* Positivo CW14Q01P */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
+			DMI_MATCH(DMI_BOARD_NAME, "CW14Q01P"),
+		},
+		.driver_data = (void *)(NAU8824_JD_ACTIVE_HIGH),
+	},
+	{
+		/* Positivo K1424G */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
+			DMI_MATCH(DMI_BOARD_NAME, "K1424G"),
+		},
+		.driver_data = (void *)(NAU8824_JD_ACTIVE_HIGH),
+	},
+	{
+		/* Positivo N14ZP74G */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
+			DMI_MATCH(DMI_BOARD_NAME, "N14ZP74G"),
+		},
+		.driver_data = (void *)(NAU8824_JD_ACTIVE_HIGH),
+	},
 	{}
 };
 
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index bc3e24c6a28a..283aa21879aa 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -417,6 +417,7 @@ static int __simple_for_each_link(struct asoc_simple_priv *priv,
 
 			if (ret < 0) {
 				of_node_put(codec);
+				of_node_put(plat);
 				of_node_put(np);
 				goto error;
 			}
diff --git a/tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c b/tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c
index c2aa6f26738b..bf82b923c5fe 100644
--- a/tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c
+++ b/tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c
@@ -1,13 +1,14 @@
 {
 	"bounds checks mixing signed and unsigned, positive bounds",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, 2),
 	BPF_JMP_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 3),
@@ -17,20 +18,21 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 3),
@@ -40,20 +42,21 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 2",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 5),
@@ -65,20 +68,21 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 3",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 4),
@@ -89,20 +93,21 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 4",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, 1),
 	BPF_ALU64_REG(BPF_AND, BPF_REG_1, BPF_REG_2),
@@ -112,19 +117,20 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.result = ACCEPT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 5",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 5),
@@ -135,17 +141,20 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 6",
 	.insns = {
+	BPF_MOV64_REG(BPF_REG_9, BPF_REG_1),
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_9),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, -512),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_6, -1),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_6, 5),
@@ -163,13 +172,14 @@
 {
 	"bounds checks mixing signed and unsigned, variant 7",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, 1024 * 1024 * 1024),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 3),
@@ -179,19 +189,20 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.result = ACCEPT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 8",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 2),
@@ -203,20 +214,21 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 9",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_LD_IMM64(BPF_REG_2, -9223372036854775808ULL),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 2),
@@ -228,19 +240,20 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.result = ACCEPT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 10",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 2),
@@ -252,20 +265,21 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 11",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
 	BPF_JMP_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 2),
@@ -278,20 +292,21 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 12",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -6),
 	BPF_JMP_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 2),
@@ -303,20 +318,21 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 13",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, 2),
 	BPF_JMP_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 2),
@@ -331,7 +347,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
@@ -340,13 +356,14 @@
 	.insns = {
 	BPF_LDX_MEM(BPF_W, BPF_REG_9, BPF_REG_1,
 		    offsetof(struct __sk_buff, mark)),
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
 	BPF_MOV64_IMM(BPF_REG_8, 2),
@@ -360,20 +377,21 @@
 	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, -3),
 	BPF_JMP_IMM(BPF_JA, 0, 0, -7),
 	},
-	.fixup_map_hash_8b = { 4 },
+	.fixup_map_hash_8b = { 6 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 15",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -6),
 	BPF_JMP_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 2),
@@ -387,7 +405,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 969647228817..c6a8c732b802 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -104,13 +104,6 @@
 	#else
 		#define __NR_mount_setattr 442
 	#endif
-
-struct mount_attr {
-	__u64 attr_set;
-	__u64 attr_clr;
-	__u64 propagation;
-	__u64 userns_fd;
-};
 #endif
 
 #ifndef __NR_open_tree
diff --git a/tools/testing/selftests/net/fcnal-test.sh b/tools/testing/selftests/net/fcnal-test.sh
index 364c82b797c1..6ecdbbe1b54f 100755
--- a/tools/testing/selftests/net/fcnal-test.sh
+++ b/tools/testing/selftests/net/fcnal-test.sh
@@ -84,6 +84,13 @@ NSC_CMD="ip netns exec ${NSC}"
 
 which ping6 > /dev/null 2>&1 && ping6=$(which ping6) || ping6=$(which ping)
 
+# Check if FIPS mode is enabled
+if [ -f /proc/sys/crypto/fips_enabled ]; then
+	fips_enabled=`cat /proc/sys/crypto/fips_enabled`
+else
+	fips_enabled=0
+fi
+
 ################################################################################
 # utilities
 
@@ -1202,7 +1209,7 @@ ipv4_tcp_novrf()
 	run_cmd nettest -d ${NSA_DEV} -r ${a}
 	log_test_addr ${a} $? 1 "No server, device client, local conn"
 
-	ipv4_tcp_md5_novrf
+	[ "$fips_enabled" = "1" ] || ipv4_tcp_md5_novrf
 }
 
 ipv4_tcp_vrf()
@@ -1256,9 +1263,11 @@ ipv4_tcp_vrf()
 	log_test_addr ${a} $? 1 "Global server, local connection"
 
 	# run MD5 tests
-	setup_vrf_dup
-	ipv4_tcp_md5
-	cleanup_vrf_dup
+	if [ "$fips_enabled" = "0" ]; then
+		setup_vrf_dup
+		ipv4_tcp_md5
+		cleanup_vrf_dup
+	fi
 
 	#
 	# enable VRF global server
@@ -2674,7 +2683,7 @@ ipv6_tcp_novrf()
 		log_test_addr ${a} $? 1 "No server, device client, local conn"
 	done
 
-	ipv6_tcp_md5_novrf
+	[ "$fips_enabled" = "1" ] || ipv6_tcp_md5_novrf
 }
 
 ipv6_tcp_vrf()
@@ -2744,9 +2753,11 @@ ipv6_tcp_vrf()
 	log_test_addr ${a} $? 1 "Global server, local connection"
 
 	# run MD5 tests
-	setup_vrf_dup
-	ipv6_tcp_md5
-	cleanup_vrf_dup
+	if [ "$fips_enabled" = "0" ]; then
+		setup_vrf_dup
+		ipv6_tcp_md5
+		cleanup_vrf_dup
+	fi
 
 	#
 	# enable VRF global server
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d.sh b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d.sh
index c5095da7f6bf..aec752a22e9e 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d.sh
@@ -93,12 +93,16 @@ cleanup()
 
 test_gretap()
 {
+	ip neigh replace 192.0.2.130 lladdr $(mac_get $h3) \
+		 nud permanent dev br2
 	full_test_span_gre_dir gt4 ingress 8 0 "mirror to gretap"
 	full_test_span_gre_dir gt4 egress 0 8 "mirror to gretap"
 }
 
 test_ip6gretap()
 {
+	ip neigh replace 2001:db8:2::2 lladdr $(mac_get $h3) \
+		nud permanent dev br2
 	full_test_span_gre_dir gt6 ingress 8 0 "mirror to ip6gretap"
 	full_test_span_gre_dir gt6 egress 0 8 "mirror to ip6gretap"
 }
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q.sh b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q.sh
index 9ff22f28032d..0cf4c47a46f9 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q.sh
@@ -90,12 +90,16 @@ cleanup()
 
 test_gretap()
 {
+	ip neigh replace 192.0.2.130 lladdr $(mac_get $h3) \
+		 nud permanent dev br1
 	full_test_span_gre_dir gt4 ingress 8 0 "mirror to gretap"
 	full_test_span_gre_dir gt4 egress 0 8 "mirror to gretap"
 }
 
 test_ip6gretap()
 {
+	ip neigh replace 2001:db8:2::2 lladdr $(mac_get $h3) \
+		nud permanent dev br1
 	full_test_span_gre_dir gt6 ingress 8 0 "mirror to ip6gretap"
 	full_test_span_gre_dir gt6 egress 0 8 "mirror to ip6gretap"
 }
diff --git a/tools/testing/selftests/net/forwarding/tc_actions.sh b/tools/testing/selftests/net/forwarding/tc_actions.sh
index 22a1e4c9553a..1e27031288c8 100755
--- a/tools/testing/selftests/net/forwarding/tc_actions.sh
+++ b/tools/testing/selftests/net/forwarding/tc_actions.sh
@@ -199,7 +199,6 @@ mirred_egress_to_ingress_tcp_test()
 	log_test "mirred_egress_to_ingress_tcp ($tcflags)"
 }
 
->>>>>>> e921d05033293 (act_mirred: use the backlog for nested calls to mirred ingress)
 setup_prepare()
 {
 	h1=${NETIFS[p1]}
diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 0faaccd21447..f7d33a16051c 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -1,3 +1,4 @@
+CONFIG_KALLSYMS=y
 CONFIG_MPTCP=y
 CONFIG_IPV6=y
 CONFIG_MPTCP_IPV6=y
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 7330e32bb9ab..368fae525fea 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -12,6 +12,8 @@ cinfail=""
 cinsent=""
 cout=""
 ksft_skip=4
+iptables="iptables"
+ip6tables="ip6tables"
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 mptcp_connect=""
@@ -126,9 +128,9 @@ reset_with_add_addr_timeout()
 	local ip="${1:-4}"
 	local tables
 
-	tables="iptables"
+	tables="${iptables}"
 	if [ $ip -eq 6 ]; then
-		tables="ip6tables"
+		tables="${ip6tables}"
 	fi
 
 	reset
@@ -171,8 +173,10 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
 
-iptables -V > /dev/null 2>&1
-if [ $? -ne 0 ];then
+if iptables-legacy -V &> /dev/null; then
+	iptables="iptables-legacy"
+	ip6tables="ip6tables-legacy"
+elif ! iptables -V &> /dev/null; then
 	echo "SKIP: Could not run all tests without iptables tool"
 	exit $ksft_skip
 fi
@@ -243,6 +247,22 @@ is_v6()
 	[ -z "${1##*:*}" ]
 }
 
+# $1: ns ; $2: counter
+get_counter()
+{
+	local ns="${1}"
+	local counter="${2}"
+	local count
+
+	count=$(ip netns exec ${ns} nstat -asz "${counter}" | awk 'NR==1 {next} {print $2}')
+	if [ -z "${count}" ]; then
+		mptcp_lib_fail_if_expected_feature "${counter} counter"
+		return 1
+	fi
+
+	echo "${count}"
+}
+
 do_transfer()
 {
 	listener_ns="$1"
@@ -556,9 +576,10 @@ chk_csum_nr()
 		echo -n "  "
 	fi
 	printf " %-36s %s" "$msg" "sum"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != 0 ]; then
+	count=$(get_counter ${ns1} "MPTcpExtDataCsumErr")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != 0 ]; then
 		echo "[fail] got $count data checksum error[s] expected 0"
 		ret=1
 		dump_stats=1
@@ -566,9 +587,10 @@ chk_csum_nr()
 		echo -n "[ ok ]"
 	fi
 	echo -n " - csum  "
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != 0 ]; then
+	count=$(get_counter ${ns2} "MPTcpExtDataCsumErr")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != 0 ]; then
 		echo "[fail] got $count data checksum error[s] expected 0"
 		ret=1
 		dump_stats=1
@@ -591,9 +613,10 @@ chk_fail_nr()
 	local dump_stats
 
 	printf "%-39s %s" " " "ftx"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$mp_fail_nr_tx" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtMPFailTx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$mp_fail_nr_tx" ]; then
 		echo "[fail] got $count MP_FAIL[s] TX expected $mp_fail_nr_tx"
 		ret=1
 		dump_stats=1
@@ -602,9 +625,10 @@ chk_fail_nr()
 	fi
 
 	echo -n " - frx   "
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPFailRx | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$mp_fail_nr_rx" ]; then
+	count=$(get_counter ${ns2} "MPTcpExtMPFailRx")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != "$mp_fail_nr_rx" ]; then
 		echo "[fail] got $count MP_FAIL[s] RX expected $mp_fail_nr_rx"
 		ret=1
 		dump_stats=1
@@ -631,9 +655,10 @@ chk_join_nr()
 	local with_cookie
 
 	printf "%02u %-36s %s" "$TEST_COUNT" "$msg" "syn"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinSynRx | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$syn_nr" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtMPJoinSynRx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$syn_nr" ]; then
 		echo "[fail] got $count JOIN[s] syn expected $syn_nr"
 		ret=1
 		dump_stats=1
@@ -643,9 +668,10 @@ chk_join_nr()
 
 	echo -n " - synack"
 	with_cookie=`ip netns exec $ns2 sysctl -n net.ipv4.tcp_syncookies`
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinSynAckRx | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$syn_ack_nr" ]; then
+	count=$(get_counter ${ns2} "MPTcpExtMPJoinSynAckRx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$syn_ack_nr" ]; then
 		# simult connections exceeding the limit with cookie enabled could go up to
 		# synack validation as the conn limit can be enforced reliably only after
 		# the subflow creation
@@ -661,9 +687,10 @@ chk_join_nr()
 	fi
 
 	echo -n " - ack"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinAckRx | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$ack_nr" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtMPJoinAckRx")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != "$ack_nr" ]; then
 		echo "[fail] got $count JOIN[s] ack expected $ack_nr"
 		ret=1
 		dump_stats=1
@@ -698,14 +725,13 @@ chk_stale_nr()
 	local recover_nr
 
 	printf "%-39s %-18s" " " "stale"
-	stale_nr=`ip netns exec $ns nstat -as | grep MPTcpExtSubflowStale | awk '{print $2}'`
-	[ -z "$stale_nr" ] && stale_nr=0
-	recover_nr=`ip netns exec $ns nstat -as | grep MPTcpExtSubflowRecover | awk '{print $2}'`
-	[ -z "$recover_nr" ] && recover_nr=0
-
-	if [ $stale_nr -lt $stale_min ] ||
-	   [ $stale_max -gt 0 -a $stale_nr -gt $stale_max ] ||
-	   [ $((stale_nr - $recover_nr)) -ne $stale_delta ]; then
+	stale_nr=$(get_counter ${ns} "MPTcpExtSubflowStale")
+	recover_nr=$(get_counter ${ns} "MPTcpExtSubflowRecover")
+	if [ -z "$stale_nr" ] || [ -z "$recover_nr" ]; then
+		echo "[skip]"
+	elif [ $stale_nr -lt $stale_min ] ||
+	     [ $stale_max -gt 0 -a $stale_nr -gt $stale_max ] ||
+	     [ $((stale_nr - $recover_nr)) -ne $stale_delta ]; then
 		echo "[fail] got $stale_nr stale[s] $recover_nr recover[s], " \
 		     " expected stale in range [$stale_min..$stale_max]," \
 		     " stale-recover delta $stale_delta "
@@ -736,9 +762,10 @@ chk_add_nr()
 	local dump_stats
 
 	printf "%-39s %s" " " "add"
-	count=`ip netns exec $ns2 nstat -as MPTcpExtAddAddr | grep MPTcpExtAddAddr | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$add_nr" ]; then
+	count=$(get_counter ${ns2} "MPTcpExtAddAddr")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$add_nr" ]; then
 		echo "[fail] got $count ADD_ADDR[s] expected $add_nr"
 		ret=1
 		dump_stats=1
@@ -747,9 +774,10 @@ chk_add_nr()
 	fi
 
 	echo -n " - echo  "
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtEchoAdd | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$echo_nr" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtEchoAdd")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$echo_nr" ]; then
 		echo "[fail] got $count ADD_ADDR echo[s] expected $echo_nr"
 		ret=1
 		dump_stats=1
@@ -759,9 +787,10 @@ chk_add_nr()
 
 	if [ $port_nr -gt 0 ]; then
 		echo -n " - pt "
-		count=`ip netns exec $ns2 nstat -as | grep MPTcpExtPortAdd | awk '{print $2}'`
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$port_nr" ]; then
+		count=$(get_counter ${ns2} "MPTcpExtPortAdd")
+		if [ -z "$count" ]; then
+			echo "[skip]"
+		elif [ "$count" != "$port_nr" ]; then
 			echo "[fail] got $count ADD_ADDR[s] with a port-number expected $port_nr"
 			ret=1
 			dump_stats=1
@@ -770,10 +799,10 @@ chk_add_nr()
 		fi
 
 		printf "%-39s %s" " " "syn"
-		count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortSynRx |
-			awk '{print $2}'`
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$syn_nr" ]; then
+		count=$(get_counter ${ns1} "MPTcpExtMPJoinPortSynRx")
+		if [ -z "$count" ]; then
+			echo -n "[skip]"
+		elif [ "$count" != "$syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a different \
 				port-number expected $syn_nr"
 			ret=1
@@ -783,10 +812,10 @@ chk_add_nr()
 		fi
 
 		echo -n " - synack"
-		count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinPortSynAckRx |
-			awk '{print $2}'`
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$syn_ack_nr" ]; then
+		count=$(get_counter ${ns2} "MPTcpExtMPJoinPortSynAckRx")
+		if [ -z "$count" ]; then
+			echo -n "[skip]"
+		elif [ "$count" != "$syn_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] synack with a different \
 				port-number expected $syn_ack_nr"
 			ret=1
@@ -796,10 +825,10 @@ chk_add_nr()
 		fi
 
 		echo -n " - ack"
-		count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortAckRx |
-			awk '{print $2}'`
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$ack_nr" ]; then
+		count=$(get_counter ${ns1} "MPTcpExtMPJoinPortAckRx")
+		if [ -z "$count" ]; then
+			echo "[skip]"
+		elif [ "$count" != "$ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a different \
 				port-number expected $ack_nr"
 			ret=1
@@ -809,10 +838,10 @@ chk_add_nr()
 		fi
 
 		printf "%-39s %s" " " "syn"
-		count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortSynRx |
-			awk '{print $2}'`
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$mis_syn_nr" ]; then
+		count=$(get_counter ${ns1} "MPTcpExtMismatchPortSynRx")
+		if [ -z "$count" ]; then
+			echo -n "[skip]"
+		elif [ "$count" != "$mis_syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a mismatched \
 				port-number expected $mis_syn_nr"
 			ret=1
@@ -822,10 +851,10 @@ chk_add_nr()
 		fi
 
 		echo -n " - ack   "
-		count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortAckRx |
-			awk '{print $2}'`
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$mis_ack_nr" ]; then
+		count=$(get_counter ${ns1} "MPTcpExtMismatchPortAckRx")
+		if [ -z "$count" ]; then
+			echo "[skip]"
+		elif [ "$count" != "$mis_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a mismatched \
 				port-number expected $mis_ack_nr"
 			ret=1
@@ -864,9 +893,10 @@ chk_rm_nr()
 	fi
 
 	printf "%-39s %s" " " "rm "
-	count=`ip netns exec $addr_ns nstat -as | grep MPTcpExtRmAddr | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$rm_addr_nr" ]; then
+	count=$(get_counter ${addr_ns} "MPTcpExtRmAddr")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$rm_addr_nr" ]; then
 		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_nr"
 		ret=1
 		dump_stats=1
@@ -875,9 +905,10 @@ chk_rm_nr()
 	fi
 
 	echo -n " - sf    "
-	count=`ip netns exec $subflow_ns nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$rm_subflow_nr" ]; then
+	count=$(get_counter ${subflow_ns} "MPTcpExtRmSubflow")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != "$rm_subflow_nr" ]; then
 		echo "[fail] got $count RM_SUBFLOW[s] expected $rm_subflow_nr"
 		ret=1
 		dump_stats=1
@@ -901,9 +932,10 @@ chk_prio_nr()
 	local dump_stats
 
 	printf "%-39s %s" " " "ptx"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioTx | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$mp_prio_nr_tx" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtMPPrioTx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$mp_prio_nr_tx" ]; then
 		echo "[fail] got $count MP_PRIO[s] TX expected $mp_prio_nr_tx"
 		ret=1
 		dump_stats=1
@@ -912,9 +944,10 @@ chk_prio_nr()
 	fi
 
 	echo -n " - prx   "
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioRx | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$mp_prio_nr_rx" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtMPPrioRx")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != "$mp_prio_nr_rx" ]; then
 		echo "[fail] got $count MP_PRIO[s] RX expected $mp_prio_nr_rx"
 		ret=1
 		dump_stats=1
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 3286536b79d5..f32045b23b89 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -38,3 +38,67 @@ mptcp_lib_check_mptcp() {
 		exit ${KSFT_SKIP}
 	fi
 }
+
+mptcp_lib_check_kallsyms() {
+	if ! mptcp_lib_has_file "/proc/kallsyms"; then
+		echo "SKIP: CONFIG_KALLSYMS is missing"
+		exit ${KSFT_SKIP}
+	fi
+}
+
+# Internal: use mptcp_lib_kallsyms_has() instead
+__mptcp_lib_kallsyms_has() {
+	local sym="${1}"
+
+	mptcp_lib_check_kallsyms
+
+	grep -q " ${sym}" /proc/kallsyms
+}
+
+# $1: part of a symbol to look at, add '$' at the end for full name
+mptcp_lib_kallsyms_has() {
+	local sym="${1}"
+
+	if __mptcp_lib_kallsyms_has "${sym}"; then
+		return 0
+	fi
+
+	mptcp_lib_fail_if_expected_feature "${sym} symbol not found"
+}
+
+# $1: part of a symbol to look at, add '$' at the end for full name
+mptcp_lib_kallsyms_doesnt_have() {
+	local sym="${1}"
+
+	if ! __mptcp_lib_kallsyms_has "${sym}"; then
+		return 0
+	fi
+
+	mptcp_lib_fail_if_expected_feature "${sym} symbol has been found"
+}
+
+# !!!AVOID USING THIS!!!
+# Features might not land in the expected version and features can be backported
+#
+# $1: kernel version, e.g. 6.3
+mptcp_lib_kversion_ge() {
+	local exp_maj="${1%.*}"
+	local exp_min="${1#*.}"
+	local v maj min
+
+	# If the kernel has backported features, set this env var to 1:
+	if [ "${SELFTESTS_MPTCP_LIB_NO_KVERSION_CHECK:-}" = "1" ]; then
+		return 0
+	fi
+
+	v=$(uname -r | cut -d'.' -f1,2)
+	maj=${v%.*}
+	min=${v#*.}
+
+	if   [ "${maj}" -gt "${exp_maj}" ] ||
+	   { [ "${maj}" -eq "${exp_maj}" ] && [ "${min}" -ge "${exp_min}" ]; }; then
+		return 0
+	fi
+
+	mptcp_lib_fail_if_expected_feature "kernel version ${1} lower than ${v}"
+}
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 7fb06c854852..306372b1526a 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -73,8 +73,12 @@ check()
 }
 
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "defaults addr list"
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
+
+default_limits="$(ip netns exec $ns1 ./pm_nl_ctl limits)"
+if mptcp_lib_expect_all_features; then
+	check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
 subflows 0" "defaults limits"
+fi
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2 flags subflow dev lo
@@ -121,12 +125,10 @@ ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 9 1
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
-subflows 0" "rcv addrs above hard limit"
+check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "rcv addrs above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 1 9
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
-subflows 0" "subflows above hard limit"
+check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "subflows above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 8 8
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 8
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1cb2530831f4..3967184b7d62 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -636,6 +636,24 @@ static __always_inline int kvm_handle_hva_range_no_flush(struct mmu_notifier *mn
 
 	return __kvm_handle_hva_range(kvm, &range);
 }
+
+static bool kvm_change_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
+{
+	/*
+	 * Skipping invalid memslots is correct if and only change_pte() is
+	 * surrounded by invalidate_range_{start,end}(), which is currently
+	 * guaranteed by the primary MMU.  If that ever changes, KVM needs to
+	 * unmap the memslot instead of skipping the memslot to ensure that KVM
+	 * doesn't hold references to the old PFN.
+	 */
+	WARN_ON_ONCE(!READ_ONCE(kvm->mn_active_invalidate_count));
+
+	if (range->slot->flags & KVM_MEMSLOT_INVALID)
+		return false;
+
+	return kvm_set_spte_gfn(kvm, range);
+}
+
 static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
 					struct mm_struct *mm,
 					unsigned long address,
@@ -656,7 +674,7 @@ static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
 	if (!READ_ONCE(kvm->mmu_notifier_count))
 		return;
 
-	kvm_handle_hva_range(mn, address, address + 1, pte, kvm_set_spte_gfn);
+	kvm_handle_hva_range(mn, address, address + 1, pte, kvm_change_spte_gfn);
 }
 
 void kvm_inc_notifier_count(struct kvm *kvm, unsigned long start,
