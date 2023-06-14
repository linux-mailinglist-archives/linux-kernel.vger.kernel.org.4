Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F530729444
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241174AbjFIJG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241173AbjFIJF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:05:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9DC1988;
        Fri,  9 Jun 2023 02:05:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20E6D6554E;
        Fri,  9 Jun 2023 09:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF8EC4339B;
        Fri,  9 Jun 2023 09:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686301546;
        bh=XXPYSOH4tAvvvxBuSL3EMS0LiWen4iM3G1jxsdv9XNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0a2H1Ae824v4drwB6JjvVKcmA4B98BcKTrtrIHUaJ6Zg337v3SY37GC/MOJbWPrnu
         u89bfhCH5IzGUKrsm19wJlT2Lb8Dt3hOZKbo19QVkXMH7mVcxd36VAUGjzZg3hHJsV
         D6wgd832UInJ3BzEtkRUwI41OP7WzFv0a0pWWTcs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.33
Date:   Fri,  9 Jun 2023 11:05:37 +0200
Message-ID: <2023060937-carpentry-cupid-c293@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023060937-legume-sustained-f6f9@gregkh>
References: <2023060937-legume-sustained-f6f9@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml
index c115e2e99bd9..4a7b1385fdc7 100644
--- a/Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml
@@ -86,7 +86,7 @@ patternProperties:
             of the MAX chips to the GyroADC, while MISO line of each Maxim
             ADC connects to a shared input pin of the GyroADC.
         enum:
-          - adi,7476
+          - adi,ad7476
           - fujitsu,mb88101a
           - maxim,max1162
           - maxim,max11100
diff --git a/Documentation/devicetree/bindings/sound/tas2562.yaml b/Documentation/devicetree/bindings/sound/tas2562.yaml
index 30f6b029ac08..cb519a4b6e71 100644
--- a/Documentation/devicetree/bindings/sound/tas2562.yaml
+++ b/Documentation/devicetree/bindings/sound/tas2562.yaml
@@ -52,7 +52,9 @@ properties:
     description: TDM TX current sense time slot.
 
   '#sound-dai-cells':
-    const: 1
+    # The codec has a single DAI, the #sound-dai-cells=<1>; case is left in for backward
+    # compatibility but is deprecated.
+    enum: [0, 1]
 
 required:
   - compatible
@@ -69,7 +71,7 @@ examples:
      codec: codec@4c {
        compatible = "ti,tas2562";
        reg = <0x4c>;
-       #sound-dai-cells = <1>;
+       #sound-dai-cells = <0>;
        interrupt-parent = <&gpio1>;
        interrupts = <14>;
        shutdown-gpios = <&gpio1 15 0>;
diff --git a/Documentation/devicetree/bindings/sound/tas2770.yaml b/Documentation/devicetree/bindings/sound/tas2770.yaml
index bc90e72bf7cf..1859fbe1cdf1 100644
--- a/Documentation/devicetree/bindings/sound/tas2770.yaml
+++ b/Documentation/devicetree/bindings/sound/tas2770.yaml
@@ -54,7 +54,9 @@ properties:
       - 1 # Falling edge
 
   '#sound-dai-cells':
-    const: 1
+    # The codec has a single DAI, the #sound-dai-cells=<1>; case is left in for backward
+    # compatibility but is deprecated.
+    enum: [0, 1]
 
 required:
   - compatible
@@ -71,7 +73,7 @@ examples:
      codec: codec@41 {
        compatible = "ti,tas2770";
        reg = <0x41>;
-       #sound-dai-cells = <1>;
+       #sound-dai-cells = <0>;
        interrupt-parent = <&gpio1>;
        interrupts = <14>;
        reset-gpio = <&gpio1 15 0>;
diff --git a/Documentation/devicetree/bindings/sound/tas27xx.yaml b/Documentation/devicetree/bindings/sound/tas27xx.yaml
index 66a0df8850ea..079cb6f8d447 100644
--- a/Documentation/devicetree/bindings/sound/tas27xx.yaml
+++ b/Documentation/devicetree/bindings/sound/tas27xx.yaml
@@ -47,7 +47,9 @@ properties:
     description: TDM TX voltage sense time slot.
 
   '#sound-dai-cells':
-    const: 1
+    # The codec has a single DAI, the #sound-dai-cells=<1>; case is left in for backward
+    # compatibility but is deprecated.
+    enum: [0, 1]
 
 required:
   - compatible
@@ -64,7 +66,7 @@ examples:
      codec: codec@38 {
        compatible = "ti,tas2764";
        reg = <0x38>;
-       #sound-dai-cells = <1>;
+       #sound-dai-cells = <0>;
        interrupt-parent = <&gpio1>;
        interrupts = <14>;
        reset-gpios = <&gpio1 15 0>;
diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 6d78048c4613..045fc7a28c45 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -260,7 +260,7 @@ properties:
     description:
       High-Speed PHY interface selection between UTMI+ and ULPI when the
       DWC_USB3_HSPHY_INTERFACE has value 3.
-    $ref: /schemas/types.yaml#/definitions/uint8
+    $ref: /schemas/types.yaml#/definitions/string
     enum: [utmi, ulpi]
 
   snps,quirk-frame-length-adjustment:
diff --git a/Makefile b/Makefile
index a0c3d8809e93..6be79c5c934f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 32
+SUBLEVEL = 33
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi b/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
index 8f37aefa7315..000278ec2c58 100644
--- a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
@@ -284,6 +284,88 @@ pins2 {
 					slew-rate = <2>;
 				};
 			};
+
+			can1_pins_a: can1-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('A', 12, AF9)>; /* CAN1_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('A', 11, AF9)>; /* CAN1_RX */
+					bias-pull-up;
+				};
+			};
+
+			can1_pins_b: can1-1 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 9, AF9)>; /* CAN1_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('B', 8, AF9)>; /* CAN1_RX */
+					bias-pull-up;
+				};
+			};
+
+			can1_pins_c: can1-2 {
+				pins1 {
+					pinmux = <STM32_PINMUX('D', 1, AF9)>; /* CAN1_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('D', 0, AF9)>; /* CAN1_RX */
+					bias-pull-up;
+
+				};
+			};
+
+			can1_pins_d: can1-3 {
+				pins1 {
+					pinmux = <STM32_PINMUX('H', 13, AF9)>; /* CAN1_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('H', 14, AF9)>; /* CAN1_RX */
+					bias-pull-up;
+
+				};
+			};
+
+			can2_pins_a: can2-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 6, AF9)>; /* CAN2_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('B', 5, AF9)>; /* CAN2_RX */
+					bias-pull-up;
+				};
+			};
+
+			can2_pins_b: can2-1 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 13, AF9)>; /* CAN2_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('B', 12, AF9)>; /* CAN2_RX */
+					bias-pull-up;
+				};
+			};
+
+			can3_pins_a: can3-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('A', 15, AF11)>; /* CAN3_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('A', 8, AF11)>; /* CAN3_RX */
+					bias-pull-up;
+				};
+			};
+
+			can3_pins_b: can3-1 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 4, AF11)>;  /* CAN3_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('B', 3, AF11)>; /* CAN3_RX */
+					bias-pull-up;
+				};
+			};
 		};
 	};
 };
diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index a37ea6c772cd..2e6aa5dc15bf 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -307,6 +307,29 @@ static int unwind_exec_pop_subset_r0_to_r3(struct unwind_ctrl_block *ctrl,
 	return URC_OK;
 }
 
+static unsigned long unwind_decode_uleb128(struct unwind_ctrl_block *ctrl)
+{
+	unsigned long bytes = 0;
+	unsigned long insn;
+	unsigned long result = 0;
+
+	/*
+	 * unwind_get_byte() will advance `ctrl` one instruction at a time, so
+	 * loop until we get an instruction byte where bit 7 is not set.
+	 *
+	 * Note: This decodes a maximum of 4 bytes to output 28 bits data where
+	 * max is 0xfffffff: that will cover a vsp increment of 1073742336, hence
+	 * it is sufficient for unwinding the stack.
+	 */
+	do {
+		insn = unwind_get_byte(ctrl);
+		result |= (insn & 0x7f) << (bytes * 7);
+		bytes++;
+	} while (!!(insn & 0x80) && (bytes != sizeof(result)));
+
+	return result;
+}
+
 /*
  * Execute the current unwind instruction.
  */
@@ -360,7 +383,7 @@ static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
 		if (ret)
 			goto error;
 	} else if (insn == 0xb2) {
-		unsigned long uleb128 = unwind_get_byte(ctrl);
+		unsigned long uleb128 = unwind_decode_uleb128(ctrl);
 
 		ctrl->vrs[SP] += 0x204 + (uleb128 << 2);
 	} else {
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 99ae81ab91a7..6ebb8dea5f09 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -312,7 +312,7 @@ static int aarch32_alloc_kuser_vdso_page(void)
 
 	memcpy((void *)(vdso_page + 0x1000 - kuser_sz), __kuser_helper_start,
 	       kuser_sz);
-	aarch32_vectors_page = virt_to_page(vdso_page);
+	aarch32_vectors_page = virt_to_page((void *)vdso_page);
 	return 0;
 }
 
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 3330d1b76bdd..2208d79b18de 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -351,17 +351,21 @@ static bool kvm_hyp_handle_cp15_32(struct kvm_vcpu *vcpu, u64 *exit_code)
 	return false;
 }
 
-static bool kvm_hyp_handle_iabt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
+static bool kvm_hyp_handle_memory_fault(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
 	if (!__populate_fault_info(vcpu))
 		return true;
 
 	return false;
 }
+static bool kvm_hyp_handle_iabt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
+	__alias(kvm_hyp_handle_memory_fault);
+static bool kvm_hyp_handle_watchpt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
+	__alias(kvm_hyp_handle_memory_fault);
 
 static bool kvm_hyp_handle_dabt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
-	if (!__populate_fault_info(vcpu))
+	if (kvm_hyp_handle_memory_fault(vcpu, exit_code))
 		return true;
 
 	if (static_branch_unlikely(&vgic_v2_cpuif_trap)) {
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index c2cb46ca4fb6..895fb3200076 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -186,6 +186,7 @@ static const exit_handler_fn hyp_exit_handlers[] = {
 	[ESR_ELx_EC_FP_ASIMD]		= kvm_hyp_handle_fpsimd,
 	[ESR_ELx_EC_IABT_LOW]		= kvm_hyp_handle_iabt_low,
 	[ESR_ELx_EC_DABT_LOW]		= kvm_hyp_handle_dabt_low,
+	[ESR_ELx_EC_WATCHPT_LOW]	= kvm_hyp_handle_watchpt_low,
 	[ESR_ELx_EC_PAC]		= kvm_hyp_handle_ptrauth,
 };
 
@@ -196,6 +197,7 @@ static const exit_handler_fn pvm_exit_handlers[] = {
 	[ESR_ELx_EC_FP_ASIMD]		= kvm_hyp_handle_fpsimd,
 	[ESR_ELx_EC_IABT_LOW]		= kvm_hyp_handle_iabt_low,
 	[ESR_ELx_EC_DABT_LOW]		= kvm_hyp_handle_dabt_low,
+	[ESR_ELx_EC_WATCHPT_LOW]	= kvm_hyp_handle_watchpt_low,
 	[ESR_ELx_EC_PAC]		= kvm_hyp_handle_ptrauth,
 };
 
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 1a97391fedd2..45ac4a59cc2c 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -110,6 +110,7 @@ static const exit_handler_fn hyp_exit_handlers[] = {
 	[ESR_ELx_EC_FP_ASIMD]		= kvm_hyp_handle_fpsimd,
 	[ESR_ELx_EC_IABT_LOW]		= kvm_hyp_handle_iabt_low,
 	[ESR_ELx_EC_DABT_LOW]		= kvm_hyp_handle_dabt_low,
+	[ESR_ELx_EC_WATCHPT_LOW]	= kvm_hyp_handle_watchpt_low,
 	[ESR_ELx_EC_PAC]		= kvm_hyp_handle_ptrauth,
 };
 
diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index 8c1d2d7128db..37e74ca4dad8 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -235,9 +235,9 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 	 * KVM io device for the redistributor that belongs to this VCPU.
 	 */
 	if (dist->vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3) {
-		mutex_lock(&vcpu->kvm->arch.config_lock);
+		mutex_lock(&vcpu->kvm->slots_lock);
 		ret = vgic_register_redist_iodev(vcpu);
-		mutex_unlock(&vcpu->kvm->arch.config_lock);
+		mutex_unlock(&vcpu->kvm->slots_lock);
 	}
 	return ret;
 }
@@ -446,11 +446,13 @@ int vgic_lazy_init(struct kvm *kvm)
 int kvm_vgic_map_resources(struct kvm *kvm)
 {
 	struct vgic_dist *dist = &kvm->arch.vgic;
+	gpa_t dist_base;
 	int ret = 0;
 
 	if (likely(vgic_ready(kvm)))
 		return 0;
 
+	mutex_lock(&kvm->slots_lock);
 	mutex_lock(&kvm->arch.config_lock);
 	if (vgic_ready(kvm))
 		goto out;
@@ -463,13 +465,26 @@ int kvm_vgic_map_resources(struct kvm *kvm)
 	else
 		ret = vgic_v3_map_resources(kvm);
 
-	if (ret)
+	if (ret) {
 		__kvm_vgic_destroy(kvm);
-	else
-		dist->ready = true;
+		goto out;
+	}
+	dist->ready = true;
+	dist_base = dist->vgic_dist_base;
+	mutex_unlock(&kvm->arch.config_lock);
+
+	ret = vgic_register_dist_iodev(kvm, dist_base,
+				       kvm_vgic_global_state.type);
+	if (ret) {
+		kvm_err("Unable to register VGIC dist MMIO regions\n");
+		kvm_vgic_destroy(kvm);
+	}
+	mutex_unlock(&kvm->slots_lock);
+	return ret;
 
 out:
 	mutex_unlock(&kvm->arch.config_lock);
+	mutex_unlock(&kvm->slots_lock);
 	return ret;
 }
 
diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index c9a03033d507..00ad6587bee9 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -1936,6 +1936,7 @@ void vgic_lpi_translation_cache_destroy(struct kvm *kvm)
 
 static int vgic_its_create(struct kvm_device *dev, u32 type)
 {
+	int ret;
 	struct vgic_its *its;
 
 	if (type != KVM_DEV_TYPE_ARM_VGIC_ITS)
@@ -1945,9 +1946,12 @@ static int vgic_its_create(struct kvm_device *dev, u32 type)
 	if (!its)
 		return -ENOMEM;
 
+	mutex_lock(&dev->kvm->arch.config_lock);
+
 	if (vgic_initialized(dev->kvm)) {
-		int ret = vgic_v4_init(dev->kvm);
+		ret = vgic_v4_init(dev->kvm);
 		if (ret < 0) {
+			mutex_unlock(&dev->kvm->arch.config_lock);
 			kfree(its);
 			return ret;
 		}
@@ -1960,12 +1964,10 @@ static int vgic_its_create(struct kvm_device *dev, u32 type)
 
 	/* Yep, even more trickery for lock ordering... */
 #ifdef CONFIG_LOCKDEP
-	mutex_lock(&dev->kvm->arch.config_lock);
 	mutex_lock(&its->cmd_lock);
 	mutex_lock(&its->its_lock);
 	mutex_unlock(&its->its_lock);
 	mutex_unlock(&its->cmd_lock);
-	mutex_unlock(&dev->kvm->arch.config_lock);
 #endif
 
 	its->vgic_its_base = VGIC_ADDR_UNDEF;
@@ -1986,7 +1988,11 @@ static int vgic_its_create(struct kvm_device *dev, u32 type)
 
 	dev->private = its;
 
-	return vgic_its_set_abi(its, NR_ITS_ABIS - 1);
+	ret = vgic_its_set_abi(its, NR_ITS_ABIS - 1);
+
+	mutex_unlock(&dev->kvm->arch.config_lock);
+
+	return ret;
 }
 
 static void vgic_its_destroy(struct kvm_device *kvm_dev)
diff --git a/arch/arm64/kvm/vgic/vgic-kvm-device.c b/arch/arm64/kvm/vgic/vgic-kvm-device.c
index 07e727023deb..bf4b3d9631ce 100644
--- a/arch/arm64/kvm/vgic/vgic-kvm-device.c
+++ b/arch/arm64/kvm/vgic/vgic-kvm-device.c
@@ -102,7 +102,11 @@ static int kvm_vgic_addr(struct kvm *kvm, struct kvm_device_attr *attr, bool wri
 		if (get_user(addr, uaddr))
 			return -EFAULT;
 
-	mutex_lock(&kvm->arch.config_lock);
+	/*
+	 * Since we can't hold config_lock while registering the redistributor
+	 * iodevs, take the slots_lock immediately.
+	 */
+	mutex_lock(&kvm->slots_lock);
 	switch (attr->attr) {
 	case KVM_VGIC_V2_ADDR_TYPE_DIST:
 		r = vgic_check_type(kvm, KVM_DEV_TYPE_ARM_VGIC_V2);
@@ -182,6 +186,7 @@ static int kvm_vgic_addr(struct kvm *kvm, struct kvm_device_attr *attr, bool wri
 	if (r)
 		goto out;
 
+	mutex_lock(&kvm->arch.config_lock);
 	if (write) {
 		r = vgic_check_iorange(kvm, *addr_ptr, addr, alignment, size);
 		if (!r)
@@ -189,9 +194,10 @@ static int kvm_vgic_addr(struct kvm *kvm, struct kvm_device_attr *attr, bool wri
 	} else {
 		addr = *addr_ptr;
 	}
+	mutex_unlock(&kvm->arch.config_lock);
 
 out:
-	mutex_unlock(&kvm->arch.config_lock);
+	mutex_unlock(&kvm->slots_lock);
 
 	if (!r && !write)
 		r =  put_user(addr, uaddr);
diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 472b18ac92a2..188d2187eede 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -769,10 +769,13 @@ int vgic_register_redist_iodev(struct kvm_vcpu *vcpu)
 	struct vgic_io_device *rd_dev = &vcpu->arch.vgic_cpu.rd_iodev;
 	struct vgic_redist_region *rdreg;
 	gpa_t rd_base;
-	int ret;
+	int ret = 0;
+
+	lockdep_assert_held(&kvm->slots_lock);
+	mutex_lock(&kvm->arch.config_lock);
 
 	if (!IS_VGIC_ADDR_UNDEF(vgic_cpu->rd_iodev.base_addr))
-		return 0;
+		goto out_unlock;
 
 	/*
 	 * We may be creating VCPUs before having set the base address for the
@@ -782,10 +785,12 @@ int vgic_register_redist_iodev(struct kvm_vcpu *vcpu)
 	 */
 	rdreg = vgic_v3_rdist_free_slot(&vgic->rd_regions);
 	if (!rdreg)
-		return 0;
+		goto out_unlock;
 
-	if (!vgic_v3_check_base(kvm))
-		return -EINVAL;
+	if (!vgic_v3_check_base(kvm)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
 
 	vgic_cpu->rdreg = rdreg;
 	vgic_cpu->rdreg_index = rdreg->free_index;
@@ -799,16 +804,20 @@ int vgic_register_redist_iodev(struct kvm_vcpu *vcpu)
 	rd_dev->nr_regions = ARRAY_SIZE(vgic_v3_rd_registers);
 	rd_dev->redist_vcpu = vcpu;
 
-	mutex_lock(&kvm->slots_lock);
+	mutex_unlock(&kvm->arch.config_lock);
+
 	ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, rd_base,
 				      2 * SZ_64K, &rd_dev->dev);
-	mutex_unlock(&kvm->slots_lock);
-
 	if (ret)
 		return ret;
 
+	/* Protected by slots_lock */
 	rdreg->free_index++;
 	return 0;
+
+out_unlock:
+	mutex_unlock(&kvm->arch.config_lock);
+	return ret;
 }
 
 static void vgic_unregister_redist_iodev(struct kvm_vcpu *vcpu)
@@ -834,12 +843,10 @@ static int vgic_register_all_redist_iodevs(struct kvm *kvm)
 		/* The current c failed, so iterate over the previous ones. */
 		int i;
 
-		mutex_lock(&kvm->slots_lock);
 		for (i = 0; i < c; i++) {
 			vcpu = kvm_get_vcpu(kvm, i);
 			vgic_unregister_redist_iodev(vcpu);
 		}
-		mutex_unlock(&kvm->slots_lock);
 	}
 
 	return ret;
@@ -938,7 +945,9 @@ int vgic_v3_set_redist_base(struct kvm *kvm, u32 index, u64 addr, u32 count)
 {
 	int ret;
 
+	mutex_lock(&kvm->arch.config_lock);
 	ret = vgic_v3_alloc_redist_region(kvm, index, addr, count);
+	mutex_unlock(&kvm->arch.config_lock);
 	if (ret)
 		return ret;
 
@@ -950,8 +959,10 @@ int vgic_v3_set_redist_base(struct kvm *kvm, u32 index, u64 addr, u32 count)
 	if (ret) {
 		struct vgic_redist_region *rdreg;
 
+		mutex_lock(&kvm->arch.config_lock);
 		rdreg = vgic_v3_rdist_region_from_index(kvm, index);
 		vgic_v3_free_redist_region(rdreg);
+		mutex_unlock(&kvm->arch.config_lock);
 		return ret;
 	}
 
diff --git a/arch/arm64/kvm/vgic/vgic-mmio.c b/arch/arm64/kvm/vgic/vgic-mmio.c
index a95f99b93dd6..eb5c58d785b9 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio.c
@@ -1093,7 +1093,6 @@ int vgic_register_dist_iodev(struct kvm *kvm, gpa_t dist_base_address,
 			     enum vgic_type type)
 {
 	struct vgic_io_device *io_device = &kvm->arch.vgic.dist_iodev;
-	int ret = 0;
 	unsigned int len;
 
 	switch (type) {
@@ -1111,10 +1110,6 @@ int vgic_register_dist_iodev(struct kvm *kvm, gpa_t dist_base_address,
 	io_device->iodev_type = IODEV_DIST;
 	io_device->redist_vcpu = NULL;
 
-	mutex_lock(&kvm->slots_lock);
-	ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, dist_base_address,
-				      len, &io_device->dev);
-	mutex_unlock(&kvm->slots_lock);
-
-	return ret;
+	return kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, dist_base_address,
+				       len, &io_device->dev);
 }
diff --git a/arch/arm64/kvm/vgic/vgic-v2.c b/arch/arm64/kvm/vgic/vgic-v2.c
index 645648349c99..7e9cdb78f7ce 100644
--- a/arch/arm64/kvm/vgic/vgic-v2.c
+++ b/arch/arm64/kvm/vgic/vgic-v2.c
@@ -312,12 +312,6 @@ int vgic_v2_map_resources(struct kvm *kvm)
 		return ret;
 	}
 
-	ret = vgic_register_dist_iodev(kvm, dist->vgic_dist_base, VGIC_V2);
-	if (ret) {
-		kvm_err("Unable to register VGIC MMIO regions\n");
-		return ret;
-	}
-
 	if (!static_branch_unlikely(&vgic_v2_cpuif_trap)) {
 		ret = kvm_phys_addr_ioremap(kvm, dist->vgic_cpu_base,
 					    kvm_vgic_global_state.vcpu_base,
diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index 5bdada313728..f86c3007a319 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -538,7 +538,6 @@ int vgic_v3_map_resources(struct kvm *kvm)
 {
 	struct vgic_dist *dist = &kvm->arch.vgic;
 	struct kvm_vcpu *vcpu;
-	int ret = 0;
 	unsigned long c;
 
 	kvm_for_each_vcpu(c, vcpu, kvm) {
@@ -568,12 +567,6 @@ int vgic_v3_map_resources(struct kvm *kvm)
 		return -EBUSY;
 	}
 
-	ret = vgic_register_dist_iodev(kvm, dist->vgic_dist_base, VGIC_V3);
-	if (ret) {
-		kvm_err("Unable to register VGICv3 dist MMIO regions\n");
-		return ret;
-	}
-
 	if (kvm_vgic_global_state.has_gicv4_1)
 		vgic_v4_configure_vsgis(kvm);
 
diff --git a/arch/arm64/kvm/vgic/vgic-v4.c b/arch/arm64/kvm/vgic/vgic-v4.c
index 3bb003478060..c1c28fe680ba 100644
--- a/arch/arm64/kvm/vgic/vgic-v4.c
+++ b/arch/arm64/kvm/vgic/vgic-v4.c
@@ -184,13 +184,14 @@ static void vgic_v4_disable_vsgis(struct kvm_vcpu *vcpu)
 	}
 }
 
-/* Must be called with the kvm lock held */
 void vgic_v4_configure_vsgis(struct kvm *kvm)
 {
 	struct vgic_dist *dist = &kvm->arch.vgic;
 	struct kvm_vcpu *vcpu;
 	unsigned long i;
 
+	lockdep_assert_held(&kvm->arch.config_lock);
+
 	kvm_arm_halt_guest(kvm);
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 4ee20280133e..2fef1fa93e7b 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -480,8 +480,8 @@ static void do_bad_area(unsigned long far, unsigned long esr,
 	}
 }
 
-#define VM_FAULT_BADMAP		0x010000
-#define VM_FAULT_BADACCESS	0x020000
+#define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
+#define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
 
 static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
 				  unsigned int mm_flags, unsigned long vm_flags,
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index efba867017e2..97b026130c71 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -311,13 +311,22 @@ static void tce_free_pSeriesLP(unsigned long liobn, long tcenum, long tceshift,
 static void tce_freemulti_pSeriesLP(struct iommu_table *tbl, long tcenum, long npages)
 {
 	u64 rc;
+	long rpages = npages;
+	unsigned long limit;
 
 	if (!firmware_has_feature(FW_FEATURE_STUFF_TCE))
 		return tce_free_pSeriesLP(tbl->it_index, tcenum,
 					  tbl->it_page_shift, npages);
 
-	rc = plpar_tce_stuff((u64)tbl->it_index,
-			     (u64)tcenum << tbl->it_page_shift, 0, npages);
+	do {
+		limit = min_t(unsigned long, rpages, 512);
+
+		rc = plpar_tce_stuff((u64)tbl->it_index,
+				     (u64)tcenum << tbl->it_page_shift, 0, limit);
+
+		rpages -= limit;
+		tcenum += limit;
+	} while (rpages > 0 && !rc);
 
 	if (rc && printk_ratelimit()) {
 		printk("tce_freemulti_pSeriesLP: plpar_tce_stuff failed\n");
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index e34d7809f6c9..bd8e80936f44 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -91,7 +91,7 @@ static unsigned long ndump = 64;
 static unsigned long nidump = 16;
 static unsigned long ncsum = 4096;
 static int termch;
-static char tmpstr[128];
+static char tmpstr[KSYM_NAME_LEN];
 static int tracing_enabled;
 
 static long bus_error_jmp[JMP_BUF_LEN];
diff --git a/arch/riscv/include/asm/perf_event.h b/arch/riscv/include/asm/perf_event.h
index d42c901f9a97..665bbc9b2f84 100644
--- a/arch/riscv/include/asm/perf_event.h
+++ b/arch/riscv/include/asm/perf_event.h
@@ -10,4 +10,11 @@
 
 #include <linux/perf_event.h>
 #define perf_arch_bpf_user_pt_regs(regs) (struct user_regs_struct *)regs
+
+#define perf_arch_fetch_caller_regs(regs, __ip) { \
+	(regs)->epc = (__ip); \
+	(regs)->s0 = (unsigned long) __builtin_frame_address(0); \
+	(regs)->sp = current_stack_pointer; \
+	(regs)->status = SR_PP; \
+}
 #endif /* _ASM_RISCV_PERF_EVENT_H */
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 6315a3c94225..2b9906ed2d1d 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -845,9 +845,9 @@ static void __init create_kernel_page_table(pgd_t *pgdir, bool early)
 static void __init create_fdt_early_page_table(uintptr_t fix_fdt_va,
 					       uintptr_t dtb_pa)
 {
+#ifndef CONFIG_BUILTIN_DTB
 	uintptr_t pa = dtb_pa & ~(PMD_SIZE - 1);
 
-#ifndef CONFIG_BUILTIN_DTB
 	/* Make sure the fdt fixmap address is always aligned on PMD size */
 	BUILD_BUG_ON(FIX_FDT % (PMD_SIZE / PAGE_SIZE));
 
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index c6eecd4a5302..10b20aeb27d3 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -95,7 +95,7 @@ static void cpu_group_map(cpumask_t *dst, struct mask_info *info, unsigned int c
 static void cpu_thread_map(cpumask_t *dst, unsigned int cpu)
 {
 	static cpumask_t mask;
-	int i;
+	unsigned int max_cpu;
 
 	cpumask_clear(&mask);
 	if (!cpumask_test_cpu(cpu, &cpu_setup_mask))
@@ -104,9 +104,10 @@ static void cpu_thread_map(cpumask_t *dst, unsigned int cpu)
 	if (topology_mode != TOPOLOGY_MODE_HW)
 		goto out;
 	cpu -= cpu % (smp_cpu_mtid + 1);
-	for (i = 0; i <= smp_cpu_mtid; i++) {
-		if (cpumask_test_cpu(cpu + i, &cpu_setup_mask))
-			cpumask_set_cpu(cpu + i, &mask);
+	max_cpu = min(cpu + smp_cpu_mtid, nr_cpu_ids - 1);
+	for (; cpu <= max_cpu; cpu++) {
+		if (cpumask_test_cpu(cpu, &cpu_setup_mask))
+			cpumask_set_cpu(cpu, &mask);
 	}
 out:
 	cpumask_copy(dst, &mask);
@@ -123,25 +124,26 @@ static void add_cpus_to_mask(struct topology_core *tl_core,
 	unsigned int core;
 
 	for_each_set_bit(core, &tl_core->mask, TOPOLOGY_CORE_BITS) {
-		unsigned int rcore;
-		int lcpu, i;
+		unsigned int max_cpu, rcore;
+		int cpu;
 
 		rcore = TOPOLOGY_CORE_BITS - 1 - core + tl_core->origin;
-		lcpu = smp_find_processor_id(rcore << smp_cpu_mt_shift);
-		if (lcpu < 0)
+		cpu = smp_find_processor_id(rcore << smp_cpu_mt_shift);
+		if (cpu < 0)
 			continue;
-		for (i = 0; i <= smp_cpu_mtid; i++) {
-			topo = &cpu_topology[lcpu + i];
+		max_cpu = min(cpu + smp_cpu_mtid, nr_cpu_ids - 1);
+		for (; cpu <= max_cpu; cpu++) {
+			topo = &cpu_topology[cpu];
 			topo->drawer_id = drawer->id;
 			topo->book_id = book->id;
 			topo->socket_id = socket->id;
 			topo->core_id = rcore;
-			topo->thread_id = lcpu + i;
+			topo->thread_id = cpu;
 			topo->dedicated = tl_core->d;
-			cpumask_set_cpu(lcpu + i, &drawer->mask);
-			cpumask_set_cpu(lcpu + i, &book->mask);
-			cpumask_set_cpu(lcpu + i, &socket->mask);
-			smp_cpu_set_polarization(lcpu + i, tl_core->pp);
+			cpumask_set_cpu(cpu, &drawer->mask);
+			cpumask_set_cpu(cpu, &book->mask);
+			cpumask_set_cpu(cpu, &socket->mask);
+			smp_cpu_set_polarization(cpu, tl_core->pp);
 		}
 	}
 }
diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index e1dc4292bd22..65b449c992d2 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -16,7 +16,8 @@ mconsole-objs := mconsole_kern.o mconsole_user.o
 hostaudio-objs := hostaudio_kern.o
 ubd-objs := ubd_kern.o ubd_user.o
 port-objs := port_kern.o port_user.o
-harddog-objs := harddog_kern.o harddog_user.o
+harddog-objs := harddog_kern.o
+harddog-builtin-$(CONFIG_UML_WATCHDOG) := harddog_user.o harddog_user_exp.o
 rtc-objs := rtc_kern.o rtc_user.o
 
 LDFLAGS_pcap.o = $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libpcap.a)
@@ -60,6 +61,7 @@ obj-$(CONFIG_PTY_CHAN) += pty.o
 obj-$(CONFIG_TTY_CHAN) += tty.o 
 obj-$(CONFIG_XTERM_CHAN) += xterm.o xterm_kern.o
 obj-$(CONFIG_UML_WATCHDOG) += harddog.o
+obj-y += $(harddog-builtin-y) $(harddog-builtin-m)
 obj-$(CONFIG_BLK_DEV_COW_COMMON) += cow_user.o
 obj-$(CONFIG_UML_RANDOM) += random.o
 obj-$(CONFIG_VIRTIO_UML) += virtio_uml.o
diff --git a/arch/um/drivers/harddog.h b/arch/um/drivers/harddog.h
new file mode 100644
index 000000000000..6d9ea60e7133
--- /dev/null
+++ b/arch/um/drivers/harddog.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef UM_WATCHDOG_H
+#define UM_WATCHDOG_H
+
+int start_watchdog(int *in_fd_ret, int *out_fd_ret, char *sock);
+void stop_watchdog(int in_fd, int out_fd);
+int ping_watchdog(int fd);
+
+#endif /* UM_WATCHDOG_H */
diff --git a/arch/um/drivers/harddog_kern.c b/arch/um/drivers/harddog_kern.c
index e6d4f43deba8..60d1c6cab8a9 100644
--- a/arch/um/drivers/harddog_kern.c
+++ b/arch/um/drivers/harddog_kern.c
@@ -47,6 +47,7 @@
 #include <linux/spinlock.h>
 #include <linux/uaccess.h>
 #include "mconsole.h"
+#include "harddog.h"
 
 MODULE_LICENSE("GPL");
 
@@ -60,8 +61,6 @@ static int harddog_out_fd = -1;
  *	Allow only one person to hold it open
  */
 
-extern int start_watchdog(int *in_fd_ret, int *out_fd_ret, char *sock);
-
 static int harddog_open(struct inode *inode, struct file *file)
 {
 	int err = -EBUSY;
@@ -92,8 +91,6 @@ static int harddog_open(struct inode *inode, struct file *file)
 	return err;
 }
 
-extern void stop_watchdog(int in_fd, int out_fd);
-
 static int harddog_release(struct inode *inode, struct file *file)
 {
 	/*
@@ -112,8 +109,6 @@ static int harddog_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-extern int ping_watchdog(int fd);
-
 static ssize_t harddog_write(struct file *file, const char __user *data, size_t len,
 			     loff_t *ppos)
 {
diff --git a/arch/um/drivers/harddog_user.c b/arch/um/drivers/harddog_user.c
index 070468d22e39..9ed89304975e 100644
--- a/arch/um/drivers/harddog_user.c
+++ b/arch/um/drivers/harddog_user.c
@@ -7,6 +7,7 @@
 #include <unistd.h>
 #include <errno.h>
 #include <os.h>
+#include "harddog.h"
 
 struct dog_data {
 	int stdin_fd;
diff --git a/arch/um/drivers/harddog_user_exp.c b/arch/um/drivers/harddog_user_exp.c
new file mode 100644
index 000000000000..c74d4b815d14
--- /dev/null
+++ b/arch/um/drivers/harddog_user_exp.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/export.h>
+#include "harddog.h"
+
+#if IS_MODULE(CONFIG_UML_WATCHDOG)
+EXPORT_SYMBOL(start_watchdog);
+EXPORT_SYMBOL(stop_watchdog);
+EXPORT_SYMBOL(ping_watchdog);
+#endif
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d7af225b63d8..f48ab047b41d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10829,6 +10829,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			exit_fastpath = EXIT_FASTPATH_EXIT_HANDLED;
 			break;
 		}
+
+		/* Note, VM-Exits that go down the "slow" path are accounted below. */
+		++vcpu->stat.exits;
 	}
 
 	/*
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 2642bc4c8ec0..66a209f7eb86 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -434,8 +434,7 @@ static unsigned long pat_x_mtrr_type(u64 start, u64 end,
 		u8 mtrr_type, uniform;
 
 		mtrr_type = mtrr_type_lookup(start, end, &uniform);
-		if (mtrr_type != MTRR_TYPE_WRBACK &&
-		    mtrr_type != MTRR_TYPE_INVALID)
+		if (mtrr_type != MTRR_TYPE_WRBACK)
 			return _PAGE_CACHE_MODE_UC_MINUS;
 
 		return _PAGE_CACHE_MODE_WB;
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 8ac1038d0c79..291cf9df7fc2 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -909,6 +909,7 @@ static bool disk_has_partitions(struct gendisk *disk)
 void disk_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
 {
 	struct request_queue *q = disk->queue;
+	unsigned int old_model = q->limits.zoned;
 
 	switch (model) {
 	case BLK_ZONED_HM:
@@ -946,7 +947,7 @@ void disk_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
 		 */
 		blk_queue_zone_write_granularity(q,
 						queue_logical_block_size(q));
-	} else {
+	} else if (old_model != BLK_ZONED_NONE) {
 		disk_clear_zone_settings(disk);
 	}
 }
diff --git a/block/fops.c b/block/fops.c
index e406aa605327..6197d1c41652 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -685,6 +685,16 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	return error;
 }
 
+static int blkdev_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct inode *bd_inode = bdev_file_inode(file);
+
+	if (bdev_read_only(I_BDEV(bd_inode)))
+		return generic_file_readonly_mmap(file, vma);
+
+	return generic_file_mmap(file, vma);
+}
+
 const struct file_operations def_blk_fops = {
 	.open		= blkdev_open,
 	.release	= blkdev_close,
@@ -692,7 +702,7 @@ const struct file_operations def_blk_fops = {
 	.read_iter	= blkdev_read_iter,
 	.write_iter	= blkdev_write_iter,
 	.iopoll		= iocb_bio_iopoll,
-	.mmap		= generic_file_mmap,
+	.mmap		= blkdev_mmap,
 	.fsync		= blkdev_fsync,
 	.unlocked_ioctl	= blkdev_ioctl,
 #ifdef CONFIG_COMPAT
diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index eca5671ad3f2..50c933f86b21 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -380,9 +380,10 @@ int public_key_verify_signature(const struct public_key *pkey,
 	struct crypto_wait cwait;
 	struct crypto_akcipher *tfm;
 	struct akcipher_request *req;
-	struct scatterlist src_sg[2];
+	struct scatterlist src_sg;
 	char alg_name[CRYPTO_MAX_ALG_NAME];
-	char *key, *ptr;
+	char *buf, *ptr;
+	size_t buf_len;
 	int ret;
 
 	pr_devel("==>%s()\n", __func__);
@@ -420,34 +421,37 @@ int public_key_verify_signature(const struct public_key *pkey,
 	if (!req)
 		goto error_free_tfm;
 
-	key = kmalloc(pkey->keylen + sizeof(u32) * 2 + pkey->paramlen,
-		      GFP_KERNEL);
-	if (!key)
+	buf_len = max_t(size_t, pkey->keylen + sizeof(u32) * 2 + pkey->paramlen,
+			sig->s_size + sig->digest_size);
+
+	buf = kmalloc(buf_len, GFP_KERNEL);
+	if (!buf)
 		goto error_free_req;
 
-	memcpy(key, pkey->key, pkey->keylen);
-	ptr = key + pkey->keylen;
+	memcpy(buf, pkey->key, pkey->keylen);
+	ptr = buf + pkey->keylen;
 	ptr = pkey_pack_u32(ptr, pkey->algo);
 	ptr = pkey_pack_u32(ptr, pkey->paramlen);
 	memcpy(ptr, pkey->params, pkey->paramlen);
 
 	if (pkey->key_is_private)
-		ret = crypto_akcipher_set_priv_key(tfm, key, pkey->keylen);
+		ret = crypto_akcipher_set_priv_key(tfm, buf, pkey->keylen);
 	else
-		ret = crypto_akcipher_set_pub_key(tfm, key, pkey->keylen);
+		ret = crypto_akcipher_set_pub_key(tfm, buf, pkey->keylen);
 	if (ret)
-		goto error_free_key;
+		goto error_free_buf;
 
 	if (strcmp(pkey->pkey_algo, "sm2") == 0 && sig->data_size) {
 		ret = cert_sig_digest_update(sig, tfm);
 		if (ret)
-			goto error_free_key;
+			goto error_free_buf;
 	}
 
-	sg_init_table(src_sg, 2);
-	sg_set_buf(&src_sg[0], sig->s, sig->s_size);
-	sg_set_buf(&src_sg[1], sig->digest, sig->digest_size);
-	akcipher_request_set_crypt(req, src_sg, NULL, sig->s_size,
+	memcpy(buf, sig->s, sig->s_size);
+	memcpy(buf + sig->s_size, sig->digest, sig->digest_size);
+
+	sg_init_one(&src_sg, buf, sig->s_size + sig->digest_size);
+	akcipher_request_set_crypt(req, &src_sg, NULL, sig->s_size,
 				   sig->digest_size);
 	crypto_init_wait(&cwait);
 	akcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
@@ -455,8 +459,8 @@ int public_key_verify_signature(const struct public_key *pkey,
 				      crypto_req_done, &cwait);
 	ret = crypto_wait_req(crypto_akcipher_verify(req), &cwait);
 
-error_free_key:
-	kfree(key);
+error_free_buf:
+	kfree(buf);
 error_free_req:
 	akcipher_request_free(req);
 error_free_tfm:
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index d08818baea88..a7f12bdbc5e2 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -502,6 +502,17 @@ static const struct dmi_system_id maingear_laptop[] = {
 	{ }
 };
 
+static const struct dmi_system_id lg_laptop[] = {
+	{
+		.ident = "LG Electronics 17U70P",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
+			DMI_MATCH(DMI_BOARD_NAME, "17U70P"),
+		},
+	},
+	{ }
+};
+
 struct irq_override_cmp {
 	const struct dmi_system_id *system;
 	unsigned char irq;
@@ -518,6 +529,7 @@ static const struct irq_override_cmp override_table[] = {
 	{ lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
 	{ tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
 	{ maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
+	{ lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
 };
 
 static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 06a3d95ed8f9..39e1ff9b686b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2699,18 +2699,36 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 	return 0;
 }
 
-static struct ata_device *ata_find_dev(struct ata_port *ap, int devno)
+static struct ata_device *ata_find_dev(struct ata_port *ap, unsigned int devno)
 {
-	if (!sata_pmp_attached(ap)) {
-		if (likely(devno >= 0 &&
-			   devno < ata_link_max_devices(&ap->link)))
+	/*
+	 * For the non-PMP case, ata_link_max_devices() returns 1 (SATA case),
+	 * or 2 (IDE master + slave case). However, the former case includes
+	 * libsas hosted devices which are numbered per scsi host, leading
+	 * to devno potentially being larger than 0 but with each struct
+	 * ata_device having its own struct ata_port and struct ata_link.
+	 * To accommodate these, ignore devno and always use device number 0.
+	 */
+	if (likely(!sata_pmp_attached(ap))) {
+		int link_max_devices = ata_link_max_devices(&ap->link);
+
+		if (link_max_devices == 1)
+			return &ap->link.device[0];
+
+		if (devno < link_max_devices)
 			return &ap->link.device[devno];
-	} else {
-		if (likely(devno >= 0 &&
-			   devno < ap->nr_pmp_links))
-			return &ap->pmp_link[devno].device[0];
+
+		return NULL;
 	}
 
+	/*
+	 * For PMP-attached devices, the device number corresponds to C
+	 * (channel) of SCSI [H:C:I:L], indicating the port pmp link
+	 * for the device.
+	 */
+	if (devno < ap->nr_pmp_links)
+		return &ap->pmp_link[devno].device[0];
+
 	return NULL;
 }
 
diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index c440d1af197a..26e13887aba4 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -280,6 +280,16 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 				continue;/* skip if itself or no cacheinfo */
 			for (sib_index = 0; sib_index < cache_leaves(i); sib_index++) {
 				sib_leaf = per_cpu_cacheinfo_idx(i, sib_index);
+
+				/*
+				 * Comparing cache IDs only makes sense if the leaves
+				 * belong to the same cache level of same type. Skip
+				 * the check if level and type do not match.
+				 */
+				if (sib_leaf->level != this_leaf->level ||
+				    sib_leaf->type != this_leaf->type)
+					continue;
+
 				if (cache_leaves_are_shared(this_leaf, sib_leaf)) {
 					cpumask_set_cpu(cpu, &sib_leaf->shared_cpu_map);
 					cpumask_set_cpu(i, &this_leaf->shared_cpu_map);
@@ -311,6 +321,16 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
 
 			for (sib_index = 0; sib_index < cache_leaves(sibling); sib_index++) {
 				sib_leaf = per_cpu_cacheinfo_idx(sibling, sib_index);
+
+				/*
+				 * Comparing cache IDs only makes sense if the leaves
+				 * belong to the same cache level of same type. Skip
+				 * the check if level and type do not match.
+				 */
+				if (sib_leaf->level != this_leaf->level ||
+				    sib_leaf->type != this_leaf->type)
+					continue;
+
 				if (cache_leaves_are_shared(this_leaf, sib_leaf)) {
 					cpumask_clear_cpu(cpu, &sib_leaf->shared_cpu_map);
 					cpumask_clear_cpu(sibling, &this_leaf->shared_cpu_map);
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 7de1f27d0323..8359164bff90 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2064,6 +2064,8 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 	size_t val_count = val_len / val_bytes;
 	size_t chunk_count, chunk_bytes;
 	size_t chunk_regs = val_count;
+	size_t max_data = map->max_raw_write - map->format.reg_bytes -
+			map->format.pad_bytes;
 	int ret, i;
 
 	if (!val_count)
@@ -2071,8 +2073,8 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 
 	if (map->use_single_write)
 		chunk_regs = 1;
-	else if (map->max_raw_write && val_len > map->max_raw_write)
-		chunk_regs = map->max_raw_write / val_bytes;
+	else if (map->max_raw_write && val_len > max_data)
+		chunk_regs = max_data / val_bytes;
 
 	chunk_count = val_count / chunk_regs;
 	chunk_bytes = chunk_regs * val_bytes;
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 888a6abb50f5..7718c81e1dba 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1665,7 +1665,7 @@ static int nbd_dev_dbg_init(struct nbd_device *nbd)
 		return -EIO;
 
 	dir = debugfs_create_dir(nbd_name(nbd), nbd_dbg_dir);
-	if (!dir) {
+	if (IS_ERR(dir)) {
 		dev_err(nbd_to_dev(nbd), "Failed to create debugfs dir for '%s'\n",
 			nbd_name(nbd));
 		return -EIO;
@@ -1691,7 +1691,7 @@ static int nbd_dbg_init(void)
 	struct dentry *dbg_dir;
 
 	dbg_dir = debugfs_create_dir("nbd", NULL);
-	if (!dbg_dir)
+	if (IS_ERR(dbg_dir))
 		return -EIO;
 
 	nbd_dbg_dir = dbg_dir;
diff --git a/drivers/block/rnbd/rnbd-proto.h b/drivers/block/rnbd/rnbd-proto.h
index ea7ac8bca63c..da1d0542d7e2 100644
--- a/drivers/block/rnbd/rnbd-proto.h
+++ b/drivers/block/rnbd/rnbd-proto.h
@@ -241,7 +241,7 @@ static inline blk_opf_t rnbd_to_bio_flags(u32 rnbd_opf)
 		bio_opf = REQ_OP_WRITE;
 		break;
 	case RNBD_OP_FLUSH:
-		bio_opf = REQ_OP_FLUSH | REQ_PREFLUSH;
+		bio_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 		break;
 	case RNBD_OP_DISCARD:
 		bio_opf = REQ_OP_DISCARD;
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c0cbc5f3eb26..c56d1c6d8e58 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1045,6 +1045,11 @@ static inline bool ublk_queue_ready(struct ublk_queue *ubq)
 	return ubq->nr_io_ready == ubq->q_depth;
 }
 
+static void ublk_cmd_cancel_cb(struct io_uring_cmd *cmd, unsigned issue_flags)
+{
+	io_uring_cmd_done(cmd, UBLK_IO_RES_ABORT, 0, issue_flags);
+}
+
 static void ublk_cancel_queue(struct ublk_queue *ubq)
 {
 	int i;
@@ -1056,8 +1061,8 @@ static void ublk_cancel_queue(struct ublk_queue *ubq)
 		struct ublk_io *io = &ubq->ios[i];
 
 		if (io->flags & UBLK_IO_FLAG_ACTIVE)
-			io_uring_cmd_done(io->cmd, UBLK_IO_RES_ABORT, 0,
-						IO_URING_F_UNLOCKED);
+			io_uring_cmd_complete_in_task(io->cmd,
+						      ublk_cmd_cancel_cb);
 	}
 
 	/* all io commands are canceled */
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index f02b583005a5..e05d2b227de3 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -805,8 +805,11 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
 	int rc;
 	u32 int_status;
 
-	if (devm_request_irq(chip->dev.parent, irq, tis_int_handler, flags,
-			     dev_name(&chip->dev), chip) != 0) {
+
+	rc = devm_request_threaded_irq(chip->dev.parent, irq, NULL,
+				       tis_int_handler, IRQF_ONESHOT | flags,
+				       dev_name(&chip->dev), chip);
+	if (rc) {
 		dev_info(&chip->dev, "Unable to request irq: %d for probe\n",
 			 irq);
 		return -1;
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index e978f457fd4d..610bfadb6acf 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -84,10 +84,10 @@ enum tis_defaults {
 #define ILB_REMAP_SIZE			0x100
 
 enum tpm_tis_flags {
-	TPM_TIS_ITPM_WORKAROUND		= BIT(0),
-	TPM_TIS_INVALID_STATUS		= BIT(1),
-	TPM_TIS_DEFAULT_CANCELLATION	= BIT(2),
-	TPM_TIS_IRQ_TESTED		= BIT(3),
+	TPM_TIS_ITPM_WORKAROUND		= 0,
+	TPM_TIS_INVALID_STATUS		= 1,
+	TPM_TIS_DEFAULT_CANCELLATION	= 2,
+	TPM_TIS_IRQ_TESTED		= 3,
 };
 
 struct tpm_tis_data {
diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index bfc8ae214395..7919906b02e7 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1026,6 +1026,8 @@ at_xdmac_prep_interleaved(struct dma_chan *chan,
 							NULL,
 							src_addr, dst_addr,
 							xt, xt->sgl);
+		if (!first)
+			return NULL;
 
 		/* Length of the block is (BLEN+1) microblocks. */
 		for (i = 0; i < xt->numf - 1; i++)
@@ -1056,8 +1058,9 @@ at_xdmac_prep_interleaved(struct dma_chan *chan,
 							       src_addr, dst_addr,
 							       xt, chunk);
 			if (!desc) {
-				list_splice_tail_init(&first->descs_list,
-						      &atchan->free_descs_list);
+				if (first)
+					list_splice_tail_init(&first->descs_list,
+							      &atchan->free_descs_list);
 				return NULL;
 			}
 
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 0d9257fbdfb0..b4731fe6bbc1 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1050,7 +1050,7 @@ static bool _trigger(struct pl330_thread *thrd)
 	return true;
 }
 
-static bool _start(struct pl330_thread *thrd)
+static bool pl330_start_thread(struct pl330_thread *thrd)
 {
 	switch (_state(thrd)) {
 	case PL330_STATE_FAULT_COMPLETING:
@@ -1702,7 +1702,7 @@ static int pl330_update(struct pl330_dmac *pl330)
 			thrd->req_running = -1;
 
 			/* Get going again ASAP */
-			_start(thrd);
+			pl330_start_thread(thrd);
 
 			/* For now, just make a list of callbacks to be done */
 			list_add_tail(&descdone->rqd, &pl330->req_done);
@@ -2089,7 +2089,7 @@ static void pl330_tasklet(struct tasklet_struct *t)
 	} else {
 		/* Make sure the PL330 Channel thread is active */
 		spin_lock(&pch->thread->dmac->lock);
-		_start(pch->thread);
+		pl330_start_thread(pch->thread);
 		spin_unlock(&pch->thread->dmac->lock);
 	}
 
@@ -2107,7 +2107,7 @@ static void pl330_tasklet(struct tasklet_struct *t)
 			if (power_down) {
 				pch->active = true;
 				spin_lock(&pch->thread->dmac->lock);
-				_start(pch->thread);
+				pl330_start_thread(pch->thread);
 				spin_unlock(&pch->thread->dmac->lock);
 				power_down = false;
 			}
diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 42282c5c3fe6..e2f90566b291 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -17,20 +17,43 @@
 
 static bool system_needs_vamap(void)
 {
-	const u8 *type1_family = efi_get_smbios_string(1, family);
+	const struct efi_smbios_type4_record *record;
+	const u32 __aligned(1) *socid;
+	const u8 *version;
 
 	/*
 	 * Ampere eMAG, Altra, and Altra Max machines crash in SetTime() if
-	 * SetVirtualAddressMap() has not been called prior.
+	 * SetVirtualAddressMap() has not been called prior. Most Altra systems
+	 * can be identified by the SMCCC soc ID, which is conveniently exposed
+	 * via the type 4 SMBIOS records. Otherwise, test the processor version
+	 * field. eMAG systems all appear to have the processor version field
+	 * set to "eMAG".
 	 */
-	if (!type1_family || (
-	    strcmp(type1_family, "eMAG") &&
-	    strcmp(type1_family, "Altra") &&
-	    strcmp(type1_family, "Altra Max")))
+	record = (struct efi_smbios_type4_record *)efi_get_smbios_record(4);
+	if (!record)
 		return false;
 
-	efi_warn("Working around broken SetVirtualAddressMap()\n");
-	return true;
+	socid = (u32 *)record->processor_id;
+	switch (*socid & 0xffff000f) {
+		static char const altra[] = "Ampere(TM) Altra(TM) Processor";
+		static char const emag[] = "eMAG";
+
+	default:
+		version = efi_get_smbios_string(&record->header, 4,
+						processor_version);
+		if (!version || (strncmp(version, altra, sizeof(altra) - 1) &&
+				 strncmp(version, emag, sizeof(emag) - 1)))
+			break;
+
+		fallthrough;
+
+	case 0x0a160001:	// Altra
+	case 0x0a160002:	// Altra Max
+		efi_warn("Working around broken SetVirtualAddressMap()\n");
+		return true;
+	}
+
+	return false;
 }
 
 efi_status_t check_platform_features(void)
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 900df67a2078..970e86e3aab0 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -983,6 +983,8 @@ struct efi_smbios_record {
 	u16	handle;
 };
 
+const struct efi_smbios_record *efi_get_smbios_record(u8 type);
+
 struct efi_smbios_type1_record {
 	struct efi_smbios_record	header;
 
@@ -996,13 +998,46 @@ struct efi_smbios_type1_record {
 	u8				family;
 };
 
-#define efi_get_smbios_string(__type, __name) ({			\
+struct efi_smbios_type4_record {
+	struct efi_smbios_record	header;
+
+	u8				socket;
+	u8				processor_type;
+	u8				processor_family;
+	u8				processor_manufacturer;
+	u8				processor_id[8];
+	u8				processor_version;
+	u8				voltage;
+	u16				external_clock;
+	u16				max_speed;
+	u16				current_speed;
+	u8				status;
+	u8				processor_upgrade;
+	u16				l1_cache_handle;
+	u16				l2_cache_handle;
+	u16				l3_cache_handle;
+	u8				serial_number;
+	u8				asset_tag;
+	u8				part_number;
+	u8				core_count;
+	u8				enabled_core_count;
+	u8				thread_count;
+	u16				processor_characteristics;
+	u16				processor_family2;
+	u16				core_count2;
+	u16				enabled_core_count2;
+	u16				thread_count2;
+	u16				thread_enabled;
+};
+
+#define efi_get_smbios_string(__record, __type, __name) ({		\
 	int size = sizeof(struct efi_smbios_type ## __type ## _record);	\
 	int off = offsetof(struct efi_smbios_type ## __type ## _record,	\
 			   __name);					\
-	__efi_get_smbios_string(__type, off, size);			\
+	__efi_get_smbios_string((__record), __type, off, size);		\
 })
 
-const u8 *__efi_get_smbios_string(u8 type, int offset, int recsize);
+const u8 *__efi_get_smbios_string(const struct efi_smbios_record *record,
+				  u8 type, int offset, int recsize);
 
 #endif
diff --git a/drivers/firmware/efi/libstub/smbios.c b/drivers/firmware/efi/libstub/smbios.c
index aadb422b9637..f9c159c28f46 100644
--- a/drivers/firmware/efi/libstub/smbios.c
+++ b/drivers/firmware/efi/libstub/smbios.c
@@ -22,19 +22,28 @@ struct efi_smbios_protocol {
 	u8 minor_version;
 };
 
-const u8 *__efi_get_smbios_string(u8 type, int offset, int recsize)
+const struct efi_smbios_record *efi_get_smbios_record(u8 type)
 {
 	struct efi_smbios_record *record;
 	efi_smbios_protocol_t *smbios;
 	efi_status_t status;
 	u16 handle = 0xfffe;
-	const u8 *strtable;
 
 	status = efi_bs_call(locate_protocol, &EFI_SMBIOS_PROTOCOL_GUID, NULL,
 			     (void **)&smbios) ?:
 		 efi_call_proto(smbios, get_next, &handle, &type, &record, NULL);
 	if (status != EFI_SUCCESS)
 		return NULL;
+	return record;
+}
+
+const u8 *__efi_get_smbios_string(const struct efi_smbios_record *record,
+				  u8 type, int offset, int recsize)
+{
+	const u8 *strtable;
+
+	if (!record)
+		return NULL;
 
 	strtable = (u8 *)record + record->length;
 	for (int i = 1; i < ((u8 *)record)[offset]; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 011e4fbe27f1..ef0a94c70859 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2512,8 +2512,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	amdgpu_fru_get_product_info(adev);
 
 init_failed:
-	if (amdgpu_sriov_vf(adev))
-		amdgpu_virt_release_full_gpu(adev, true);
 
 	return r;
 }
@@ -3557,6 +3555,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	int r, i;
 	bool px = false;
 	u32 max_MBps;
+	int tmp;
 
 	adev->shutdown = false;
 	adev->flags = flags;
@@ -3735,6 +3734,12 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		adev->have_atomics_support = ((struct amd_sriov_msg_pf2vf_info *)
 			adev->virt.fw_reserve.p_pf2vf)->pcie_atomic_ops_support_flags ==
 			(PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCAP2_ATOMIC_COMP64);
+	/* APUs w/ gfx9 onwards doesn't reply on PCIe atomics, rather it is a
+	 * internal path natively support atomics, set have_atomics_support to true.
+	 */
+	else if ((adev->flags & AMD_IS_APU) &&
+		(adev->ip_versions[GC_HWIP][0] > IP_VERSION(9, 0, 0)))
+		adev->have_atomics_support = true;
 	else
 		adev->have_atomics_support =
 			!pci_enable_atomic_ops_to_root(adev->pdev,
@@ -3778,7 +3783,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 				}
 			}
 		} else {
+			tmp = amdgpu_reset_method;
+			/* It should do a default reset when loading or reloading the driver,
+			 * regardless of the module parameter reset_method.
+			 */
+			amdgpu_reset_method = AMD_RESET_METHOD_NONE;
 			r = amdgpu_asic_reset(adev);
+			amdgpu_reset_method = tmp;
 			if (r) {
 				dev_err(adev->dev, "asic reset on init failed\n");
 				goto failed;
@@ -3838,18 +3849,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	r = amdgpu_device_ip_init(adev);
 	if (r) {
-		/* failed in exclusive mode due to timeout */
-		if (amdgpu_sriov_vf(adev) &&
-		    !amdgpu_sriov_runtime(adev) &&
-		    amdgpu_virt_mmio_blocked(adev) &&
-		    !amdgpu_virt_wait_reset(adev)) {
-			dev_err(adev->dev, "VF exclusive mode timeout\n");
-			/* Don't send request since VF is inactive. */
-			adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
-			adev->virt.ops = NULL;
-			r = -EAGAIN;
-			goto release_ras_con;
-		}
 		dev_err(adev->dev, "amdgpu_device_ip_init failed\n");
 		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_INIT_FAIL, 0, 0);
 		goto release_ras_con;
@@ -3921,8 +3920,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 				   msecs_to_jiffies(AMDGPU_RESUME_MS));
 	}
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
+		amdgpu_virt_release_full_gpu(adev, true);
 		flush_delayed_work(&adev->delayed_init_work);
+	}
 
 	r = sysfs_create_files(&adev->dev->kobj, amdgpu_dev_attributes);
 	if (r)
@@ -3962,6 +3963,20 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	return 0;
 
 release_ras_con:
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_virt_release_full_gpu(adev, true);
+
+	/* failed in exclusive mode due to timeout */
+	if (amdgpu_sriov_vf(adev) &&
+		!amdgpu_sriov_runtime(adev) &&
+		amdgpu_virt_mmio_blocked(adev) &&
+		!amdgpu_virt_wait_reset(adev)) {
+		dev_err(adev->dev, "VF exclusive mode timeout\n");
+		/* Don't send request since VF is inactive. */
+		adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
+		adev->virt.ops = NULL;
+		r = -EAGAIN;
+	}
 	amdgpu_release_ras_context(adev);
 
 failed:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 3cc1929285fc..ed6878d5b3ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -528,7 +528,8 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
 		if (r)
 			amdgpu_fence_driver_force_completion(ring);
 
-		if (ring->fence_drv.irq_src)
+		if (!drm_dev_is_unplugged(adev_to_drm(adev)) &&
+		    ring->fence_drv.irq_src)
 			amdgpu_irq_put(adev, ring->fence_drv.irq_src,
 				       ring->fence_drv.irq_type);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 02a4c93673ce..2bc791ed8830 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -526,6 +526,8 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	case IP_VERSION(9, 3, 0):
 	/* GC 10.3.7 */
 	case IP_VERSION(10, 3, 7):
+	/* GC 11.0.1 */
+	case IP_VERSION(11, 0, 1):
 		if (amdgpu_tmz == 0) {
 			adev->gmc.tmz_enabled = false;
 			dev_info(adev->dev,
@@ -548,7 +550,6 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 1):
 	/* YELLOW_CARP*/
 	case IP_VERSION(10, 3, 3):
-	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
 		/* Don't enable it by default yet.
 		 */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b46732cefe37..8ab0dd799b3c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2763,7 +2763,7 @@ static int dm_resume(void *handle)
 		 * this is the case when traversing through already created
 		 * MST connectors, should be skipped
 		 */
-		if (aconnector->dc_link->type == dc_connection_mst_branch)
+		if (aconnector && aconnector->mst_port)
 			continue;
 
 		mutex_lock(&aconnector->hpd_lock);
@@ -6492,7 +6492,7 @@ static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 	int clock, bpp = 0;
 	bool is_y420 = false;
 
-	if (!aconnector->port || !aconnector->dc_sink)
+	if (!aconnector->port)
 		return 0;
 
 	mst_port = aconnector->port;
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 49c398ec0aaf..c89cfef7cafa 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -6925,23 +6925,6 @@ static int si_dpm_enable(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int si_set_temperature_range(struct amdgpu_device *adev)
-{
-	int ret;
-
-	ret = si_thermal_enable_alert(adev, false);
-	if (ret)
-		return ret;
-	ret = si_thermal_set_temperature_range(adev, R600_TEMP_RANGE_MIN, R600_TEMP_RANGE_MAX);
-	if (ret)
-		return ret;
-	ret = si_thermal_enable_alert(adev, true);
-	if (ret)
-		return ret;
-
-	return ret;
-}
-
 static void si_dpm_disable(struct amdgpu_device *adev)
 {
 	struct rv7xx_power_info *pi = rv770_get_pi(adev);
@@ -7626,18 +7609,6 @@ static int si_dpm_process_interrupt(struct amdgpu_device *adev,
 
 static int si_dpm_late_init(void *handle)
 {
-	int ret;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
-	if (!adev->pm.dpm_enabled)
-		return 0;
-
-	ret = si_set_temperature_range(adev);
-	if (ret)
-		return ret;
-#if 0 //TODO ?
-	si_dpm_powergate_uvd(adev, true);
-#endif
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index cb10c7e31264..1b731a9c92d9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -580,7 +580,7 @@ static int vangogh_print_legacy_clk_levels(struct smu_context *smu,
 	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
 	SmuMetrics_legacy_t metrics;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
-	int i, size = 0, ret = 0;
+	int i, idx, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	bool cur_value_match_level = false;
 
@@ -654,7 +654,8 @@ static int vangogh_print_legacy_clk_levels(struct smu_context *smu,
 	case SMU_MCLK:
 	case SMU_FCLK:
 		for (i = 0; i < count; i++) {
-			ret = vangogh_get_dpm_clk_limited(smu, clk_type, i, &value);
+			idx = (clk_type == SMU_FCLK || clk_type == SMU_MCLK) ? (count - i - 1) : i;
+			ret = vangogh_get_dpm_clk_limited(smu, clk_type, idx, &value);
 			if (ret)
 				return ret;
 			if (!value)
@@ -681,7 +682,7 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
 	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
 	SmuMetrics_t metrics;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
-	int i, size = 0, ret = 0;
+	int i, idx, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	bool cur_value_match_level = false;
 	uint32_t min, max;
@@ -763,7 +764,8 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
 	case SMU_MCLK:
 	case SMU_FCLK:
 		for (i = 0; i < count; i++) {
-			ret = vangogh_get_dpm_clk_limited(smu, clk_type, i, &value);
+			idx = (clk_type == SMU_FCLK || clk_type == SMU_MCLK) ? (count - i - 1) : i;
+			ret = vangogh_get_dpm_clk_limited(smu, clk_type, idx, &value);
 			if (ret)
 				return ret;
 			if (!value)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 5cdc07165480..8a8ba25c9ad7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -494,7 +494,7 @@ static int renoir_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
 static int renoir_print_clk_levels(struct smu_context *smu,
 			enum smu_clk_type clk_type, char *buf)
 {
-	int i, size = 0, ret = 0;
+	int i, idx, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0, min = 0, max = 0;
 	SmuMetrics_t metrics;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
@@ -594,7 +594,8 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 	case SMU_VCLK:
 	case SMU_DCLK:
 		for (i = 0; i < count; i++) {
-			ret = renoir_get_dpm_clk_limited(smu, clk_type, i, &value);
+			idx = (clk_type == SMU_FCLK || clk_type == SMU_MCLK) ? (count - i - 1) : i;
+			ret = renoir_get_dpm_clk_limited(smu, clk_type, idx, &value);
 			if (ret)
 				return ret;
 			if (!value)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 8fa9a36c38b6..6d9760eac16d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -478,7 +478,7 @@ static int smu_v13_0_4_get_dpm_level_count(struct smu_context *smu,
 static int smu_v13_0_4_print_clk_levels(struct smu_context *smu,
 					enum smu_clk_type clk_type, char *buf)
 {
-	int i, size = 0, ret = 0;
+	int i, idx, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t min, max;
 
@@ -512,7 +512,8 @@ static int smu_v13_0_4_print_clk_levels(struct smu_context *smu,
 			break;
 
 		for (i = 0; i < count; i++) {
-			ret = smu_v13_0_4_get_dpm_freq_by_index(smu, clk_type, i, &value);
+			idx = (clk_type == SMU_FCLK || clk_type == SMU_MCLK) ? (count - i - 1) : i;
+			ret = smu_v13_0_4_get_dpm_freq_by_index(smu, clk_type, idx, &value);
 			if (ret)
 				break;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 66445964efbd..0081fa607e02 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -866,7 +866,7 @@ static int smu_v13_0_5_set_soft_freq_limited_range(struct smu_context *smu,
 static int smu_v13_0_5_print_clk_levels(struct smu_context *smu,
 				enum smu_clk_type clk_type, char *buf)
 {
-	int i, size = 0, ret = 0;
+	int i, idx, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t min = 0, max = 0;
 
@@ -898,7 +898,8 @@ static int smu_v13_0_5_print_clk_levels(struct smu_context *smu,
 			goto print_clk_out;
 
 		for (i = 0; i < count; i++) {
-			ret = smu_v13_0_5_get_dpm_freq_by_index(smu, clk_type, i, &value);
+			idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
+			ret = smu_v13_0_5_get_dpm_freq_by_index(smu, clk_type, idx, &value);
 			if (ret)
 				goto print_clk_out;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 04e56b0b3033..798f36cfcebd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -1000,7 +1000,7 @@ static int yellow_carp_set_soft_freq_limited_range(struct smu_context *smu,
 static int yellow_carp_print_clk_levels(struct smu_context *smu,
 				enum smu_clk_type clk_type, char *buf)
 {
-	int i, size = 0, ret = 0;
+	int i, idx, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t min, max;
 
@@ -1033,7 +1033,8 @@ static int yellow_carp_print_clk_levels(struct smu_context *smu,
 			goto print_clk_out;
 
 		for (i = 0; i < count; i++) {
-			ret = yellow_carp_get_dpm_freq_by_index(smu, clk_type, i, &value);
+			idx = (clk_type == SMU_FCLK || clk_type == SMU_MCLK) ? (count - i - 1) : i;
+			ret = yellow_carp_get_dpm_freq_by_index(smu, clk_type, idx, &value);
 			if (ret)
 				goto print_clk_out;
 
diff --git a/drivers/gpu/drm/ast/ast_main.c b/drivers/gpu/drm/ast/ast_main.c
index 067453266897..5df527051177 100644
--- a/drivers/gpu/drm/ast/ast_main.c
+++ b/drivers/gpu/drm/ast/ast_main.c
@@ -427,11 +427,12 @@ struct ast_private *ast_device_create(const struct drm_driver *drv,
 		return ERR_PTR(-EIO);
 
 	/*
-	 * If we don't have IO space at all, use MMIO now and
-	 * assume the chip has MMIO enabled by default (rev 0x20
-	 * and higher).
+	 * After AST2500, MMIO is enabled by default, and it should be adopted
+	 * to be compatible with Arm.
 	 */
-	if (!(pci_resource_flags(pdev, 2) & IORESOURCE_IO)) {
+	if (pdev->revision >= 0x40) {
+		ast->ioregs = ast->regs + AST_IO_MM_OFFSET;
+	} else if (!(pci_resource_flags(pdev, 2) & IORESOURCE_IO)) {
 		drm_info(dev, "platform has no IO space, trying MMIO\n");
 		ast->ioregs = ast->regs + AST_IO_MM_OFFSET;
 	}
diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 5577cea7c009..d12ba47b37c4 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -227,7 +227,12 @@ struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent)
 	/* Get the pagetable configuration from the domain */
 	if (adreno_smmu->cookie)
 		ttbr1_cfg = adreno_smmu->get_ttbr1_cfg(adreno_smmu->cookie);
-	if (!ttbr1_cfg)
+
+	/*
+	 * If you hit this WARN_ONCE() you are probably missing an entry in
+	 * qcom_smmu_impl_of_match[] in arm-smmu-qcom.c
+	 */
+	if (WARN_ONCE(!ttbr1_cfg, "No per-process page tables"))
 		return ERR_PTR(-ENODEV);
 
 	/*
diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 7ae5f27df54d..c6bdb9c4ef3e 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -586,6 +586,8 @@ static const struct hid_device_id hammer_devices[] = {
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_EEL) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_HAMMER) },
+	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_JEWEL) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_MAGNEMITE) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 53c6692d7771..653db6cdab57 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -523,6 +523,7 @@
 #define USB_DEVICE_ID_GOOGLE_MOONBALL	0x5044
 #define USB_DEVICE_ID_GOOGLE_DON	0x5050
 #define USB_DEVICE_ID_GOOGLE_EEL	0x5057
+#define USB_DEVICE_ID_GOOGLE_JEWEL	0x5061
 
 #define USB_VENDOR_ID_GOTOP		0x08f2
 #define USB_DEVICE_ID_SUPER_Q2		0x007f
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index d2f500242ed4..9c30dd30537a 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -826,7 +826,7 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 	/* Enter report */
 	if ((data[1] & 0xfc) == 0xc0) {
 		/* serial number of the tool */
-		wacom->serial[idx] = ((data[3] & 0x0f) << 28) +
+		wacom->serial[idx] = ((__u64)(data[3] & 0x0f) << 28) +
 			(data[4] << 20) + (data[5] << 12) +
 			(data[6] << 4) + (data[7] >> 4);
 
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index be8bbb1c3a02..823d0ca1d605 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -507,6 +507,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
 };
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index c8c8eb15c34e..c4143c567874 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1289,12 +1289,12 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev)
 
 	adev = ACPI_COMPANION(indio_dev->dev.parent);
 	if (!adev)
-		return 0;
+		return -ENXIO;
 
 	/* Read _ONT data, which should be a package of 6 integers. */
 	status = acpi_evaluate_object(adev->handle, "_ONT", NULL, &buffer);
 	if (status == AE_NOT_FOUND) {
-		return 0;
+		return -ENXIO;
 	} else if (ACPI_FAILURE(status)) {
 		dev_warn(&indio_dev->dev, "failed to execute _ONT: %d\n",
 			 status);
diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index d71977be7d22..a8f6fa48daa8 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -898,10 +898,6 @@ static const struct iio_info ad7195_info = {
 	__AD719x_CHANNEL(_si, _channel1, -1, _address, NULL, IIO_VOLTAGE, \
 		BIT(IIO_CHAN_INFO_SCALE), ad7192_calibsys_ext_info)
 
-#define AD719x_SHORTED_CHANNEL(_si, _channel1, _address) \
-	__AD719x_CHANNEL(_si, _channel1, -1, _address, "shorted", IIO_VOLTAGE, \
-		BIT(IIO_CHAN_INFO_SCALE), ad7192_calibsys_ext_info)
-
 #define AD719x_TEMP_CHANNEL(_si, _address) \
 	__AD719x_CHANNEL(_si, 0, -1, _address, NULL, IIO_TEMP, 0, NULL)
 
@@ -909,7 +905,7 @@ static const struct iio_chan_spec ad7192_channels[] = {
 	AD719x_DIFF_CHANNEL(0, 1, 2, AD7192_CH_AIN1P_AIN2M),
 	AD719x_DIFF_CHANNEL(1, 3, 4, AD7192_CH_AIN3P_AIN4M),
 	AD719x_TEMP_CHANNEL(2, AD7192_CH_TEMP),
-	AD719x_SHORTED_CHANNEL(3, 2, AD7192_CH_AIN2P_AIN2M),
+	AD719x_DIFF_CHANNEL(3, 2, 2, AD7192_CH_AIN2P_AIN2M),
 	AD719x_CHANNEL(4, 1, AD7192_CH_AIN1),
 	AD719x_CHANNEL(5, 2, AD7192_CH_AIN2),
 	AD719x_CHANNEL(6, 3, AD7192_CH_AIN3),
@@ -923,7 +919,7 @@ static const struct iio_chan_spec ad7193_channels[] = {
 	AD719x_DIFF_CHANNEL(2, 5, 6, AD7193_CH_AIN5P_AIN6M),
 	AD719x_DIFF_CHANNEL(3, 7, 8, AD7193_CH_AIN7P_AIN8M),
 	AD719x_TEMP_CHANNEL(4, AD7193_CH_TEMP),
-	AD719x_SHORTED_CHANNEL(5, 2, AD7193_CH_AIN2P_AIN2M),
+	AD719x_DIFF_CHANNEL(5, 2, 2, AD7193_CH_AIN2P_AIN2M),
 	AD719x_CHANNEL(6, 1, AD7193_CH_AIN1),
 	AD719x_CHANNEL(7, 2, AD7193_CH_AIN2),
 	AD719x_CHANNEL(8, 3, AD7193_CH_AIN3),
diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index d8570f620785..7e2192870743 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -584,6 +584,10 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
 	init_completion(&sigma_delta->completion);
 
 	sigma_delta->irq_dis = true;
+
+	/* the IRQ core clears IRQ_DISABLE_UNLAZY flag when freeing an IRQ */
+	irq_set_status_flags(sigma_delta->spi->irq, IRQ_DISABLE_UNLAZY);
+
 	ret = devm_request_irq(dev, sigma_delta->spi->irq,
 			       ad_sd_data_rdy_trig_poll,
 			       sigma_delta->info->irq_flags | IRQF_NO_AUTOEN,
diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index bca79a93cbe4..a50f39143d3e 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -757,13 +757,13 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
 
 	ret = mxs_lradc_adc_trigger_init(iio);
 	if (ret)
-		goto err_trig;
+		return ret;
 
 	ret = iio_triggered_buffer_setup(iio, &iio_pollfunc_store_time,
 					 &mxs_lradc_adc_trigger_handler,
 					 &mxs_lradc_adc_buffer_ops);
 	if (ret)
-		return ret;
+		goto err_trig;
 
 	adc->vref_mv = mxs_lradc_adc_vref_mv[lradc->soc];
 
@@ -801,9 +801,9 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
 
 err_dev:
 	mxs_lradc_adc_hw_stop(adc);
-	mxs_lradc_adc_trigger_remove(iio);
-err_trig:
 	iio_triggered_buffer_cleanup(iio);
+err_trig:
+	mxs_lradc_adc_trigger_remove(iio);
 	return ret;
 }
 
@@ -814,8 +814,8 @@ static int mxs_lradc_adc_remove(struct platform_device *pdev)
 
 	iio_device_unregister(iio);
 	mxs_lradc_adc_hw_stop(adc);
-	mxs_lradc_adc_trigger_remove(iio);
 	iio_triggered_buffer_cleanup(iio);
+	mxs_lradc_adc_trigger_remove(iio);
 
 	return 0;
 }
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 3cda529f081d..a5d5b7b3823b 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1882,16 +1882,15 @@ static int stm32_adc_get_legacy_chan_count(struct iio_dev *indio_dev, struct stm
 	 * to get the *real* number of channels.
 	 */
 	ret = device_property_count_u32(dev, "st,adc-diff-channels");
-	if (ret < 0)
-		return ret;
-
-	ret /= (int)(sizeof(struct stm32_adc_diff_channel) / sizeof(u32));
-	if (ret > adc_info->max_channels) {
-		dev_err(&indio_dev->dev, "Bad st,adc-diff-channels?\n");
-		return -EINVAL;
-	} else if (ret > 0) {
-		adc->num_diff = ret;
-		num_channels += ret;
+	if (ret > 0) {
+		ret /= (int)(sizeof(struct stm32_adc_diff_channel) / sizeof(u32));
+		if (ret > adc_info->max_channels) {
+			dev_err(&indio_dev->dev, "Bad st,adc-diff-channels?\n");
+			return -EINVAL;
+		} else if (ret > 0) {
+			adc->num_diff = ret;
+			num_channels += ret;
+		}
 	}
 
 	/* Optional sample time is provided either for each, or all channels */
@@ -1913,6 +1912,7 @@ static int stm32_adc_legacy_chan_init(struct iio_dev *indio_dev,
 	struct stm32_adc_diff_channel diff[STM32_ADC_CH_MAX];
 	struct device *dev = &indio_dev->dev;
 	u32 num_diff = adc->num_diff;
+	int num_se = nchans - num_diff;
 	int size = num_diff * sizeof(*diff) / sizeof(u32);
 	int scan_index = 0, ret, i, c;
 	u32 smp = 0, smps[STM32_ADC_CH_MAX], chans[STM32_ADC_CH_MAX];
@@ -1939,29 +1939,32 @@ static int stm32_adc_legacy_chan_init(struct iio_dev *indio_dev,
 			scan_index++;
 		}
 	}
-
-	ret = device_property_read_u32_array(dev, "st,adc-channels", chans,
-					     nchans);
-	if (ret)
-		return ret;
-
-	for (c = 0; c < nchans; c++) {
-		if (chans[c] >= adc_info->max_channels) {
-			dev_err(&indio_dev->dev, "Invalid channel %d\n",
-				chans[c]);
-			return -EINVAL;
+	if (num_se > 0) {
+		ret = device_property_read_u32_array(dev, "st,adc-channels", chans, num_se);
+		if (ret) {
+			dev_err(&indio_dev->dev, "Failed to get st,adc-channels %d\n", ret);
+			return ret;
 		}
 
-		/* Channel can't be configured both as single-ended & diff */
-		for (i = 0; i < num_diff; i++) {
-			if (chans[c] == diff[i].vinp) {
-				dev_err(&indio_dev->dev, "channel %d misconfigured\n",	chans[c]);
+		for (c = 0; c < num_se; c++) {
+			if (chans[c] >= adc_info->max_channels) {
+				dev_err(&indio_dev->dev, "Invalid channel %d\n",
+					chans[c]);
 				return -EINVAL;
 			}
+
+			/* Channel can't be configured both as single-ended & diff */
+			for (i = 0; i < num_diff; i++) {
+				if (chans[c] == diff[i].vinp) {
+					dev_err(&indio_dev->dev, "channel %d misconfigured\n",
+						chans[c]);
+					return -EINVAL;
+				}
+			}
+			stm32_adc_chan_init_one(indio_dev, &channels[scan_index],
+						chans[c], 0, scan_index, false);
+			scan_index++;
 		}
-		stm32_adc_chan_init_one(indio_dev, &channels[scan_index],
-					chans[c], 0, scan_index, false);
-		scan_index++;
 	}
 
 	if (adc->nsmps > 0) {
@@ -2153,7 +2156,7 @@ static int stm32_adc_chan_fw_init(struct iio_dev *indio_dev, bool timestamping)
 
 	if (legacy)
 		ret = stm32_adc_legacy_chan_init(indio_dev, adc, channels,
-						 num_channels);
+						 timestamping ? num_channels - 1 : num_channels);
 	else
 		ret = stm32_adc_generic_chan_init(indio_dev, adc, channels);
 	if (ret < 0)
diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index e0e130ba9d3e..05faf3910bfc 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -973,7 +973,7 @@ static int ad74413r_read_raw(struct iio_dev *indio_dev,
 
 		ret = ad74413r_get_single_adc_result(indio_dev, chan->channel,
 						     val);
-		if (ret)
+		if (ret < 0)
 			return ret;
 
 		ad74413r_adc_to_resistance_result(*val, val);
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index ec3e42713f00..e22d9b4bac80 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -17,7 +17,7 @@ obj-$(CONFIG_AD5592R_BASE) += ad5592r-base.o
 obj-$(CONFIG_AD5592R) += ad5592r.o
 obj-$(CONFIG_AD5593R) += ad5593r.o
 obj-$(CONFIG_AD5755) += ad5755.o
-obj-$(CONFIG_AD5755) += ad5758.o
+obj-$(CONFIG_AD5758) += ad5758.o
 obj-$(CONFIG_AD5761) += ad5761.o
 obj-$(CONFIG_AD5764) += ad5764.o
 obj-$(CONFIG_AD5766) += ad5766.o
diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 446d1a8fe4be..2be821d561c4 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -47,12 +47,18 @@ static int mcp4725_suspend(struct device *dev)
 	struct mcp4725_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
 	u8 outbuf[2];
+	int ret;
 
 	outbuf[0] = (data->powerdown_mode + 1) << 4;
 	outbuf[1] = 0;
 	data->powerdown = true;
 
-	return i2c_master_send(data->client, outbuf, 2);
+	ret = i2c_master_send(data->client, outbuf, 2);
+	if (ret < 0)
+		return ret;
+	else if (ret != 2)
+		return -EIO;
+	return 0;
 }
 
 static int mcp4725_resume(struct device *dev)
@@ -60,13 +66,19 @@ static int mcp4725_resume(struct device *dev)
 	struct mcp4725_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
 	u8 outbuf[2];
+	int ret;
 
 	/* restore previous DAC value */
 	outbuf[0] = (data->dac_value >> 8) & 0xf;
 	outbuf[1] = data->dac_value & 0xff;
 	data->powerdown = false;
 
-	return i2c_master_send(data->client, outbuf, 2);
+	ret = i2c_master_send(data->client, outbuf, 2);
+	if (ret < 0)
+		return ret;
+	else if (ret != 2)
+		return -EIO;
+	return 0;
 }
 static DEFINE_SIMPLE_DEV_PM_OPS(mcp4725_pm_ops, mcp4725_suspend,
 				mcp4725_resume);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 99576b2c171f..32d7f8364230 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -275,9 +275,14 @@ static int inv_icm42600_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
+	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
 
 	pm_runtime_get_sync(dev);
 
+	mutex_lock(&st->lock);
+	inv_icm42600_timestamp_reset(ts);
+	mutex_unlock(&st->lock);
+
 	return 0;
 }
 
@@ -375,7 +380,6 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int sensor;
 	unsigned int *watermark;
-	struct inv_icm42600_timestamp *ts;
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int sleep_temp = 0;
 	unsigned int sleep_sensor = 0;
@@ -385,11 +389,9 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 	if (indio_dev == st->indio_gyro) {
 		sensor = INV_ICM42600_SENSOR_GYRO;
 		watermark = &st->fifo.watermark.gyro;
-		ts = iio_priv(st->indio_gyro);
 	} else if (indio_dev == st->indio_accel) {
 		sensor = INV_ICM42600_SENSOR_ACCEL;
 		watermark = &st->fifo.watermark.accel;
-		ts = iio_priv(st->indio_accel);
 	} else {
 		return -EINVAL;
 	}
@@ -417,8 +419,6 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 	if (!st->fifo.on)
 		ret = inv_icm42600_set_temp_conf(st, false, &sleep_temp);
 
-	inv_icm42600_timestamp_reset(ts);
-
 out_unlock:
 	mutex_unlock(&st->lock);
 
diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 3ed37f6057fb..a23c415fcb7a 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -8,6 +8,7 @@
  * TODO: Proximity
  */
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
@@ -42,6 +43,7 @@
 #define VCNL4035_ALS_PERS_MASK		GENMASK(3, 2)
 #define VCNL4035_INT_ALS_IF_H_MASK	BIT(12)
 #define VCNL4035_INT_ALS_IF_L_MASK	BIT(13)
+#define VCNL4035_DEV_ID_MASK		GENMASK(7, 0)
 
 /* Default values */
 #define VCNL4035_MODE_ALS_ENABLE	BIT(0)
@@ -413,6 +415,7 @@ static int vcnl4035_init(struct vcnl4035_data *data)
 		return ret;
 	}
 
+	id = FIELD_GET(VCNL4035_DEV_ID_MASK, id);
 	if (id != VCNL4035_DEV_ID_VAL) {
 		dev_err(&data->client->dev, "Wrong id, got %x, expected %x\n",
 			id, VCNL4035_DEV_ID_VAL);
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 989edc789633..94222de1d371 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3241,9 +3241,7 @@ static int bnxt_re_process_raw_qp_pkt_rx(struct bnxt_re_qp *gsi_qp,
 	udwr.remote_qkey = gsi_sqp->qplib_qp.qkey;
 
 	/* post data received  in the send queue */
-	rc = bnxt_re_post_send_shadow_qp(rdev, gsi_sqp, swr);
-
-	return 0;
+	return bnxt_re_post_send_shadow_qp(rdev, gsi_sqp, swr);
 }
 
 static void bnxt_re_process_res_rawqp1_wc(struct ib_wc *wc,
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 96e581ced50e..ab2cc1c67f70 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -2043,6 +2043,12 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 	u32 pg_sz_lvl;
 	int rc;
 
+	if (!cq->dpi) {
+		dev_err(&rcfw->pdev->dev,
+			"FP: CREATE_CQ failed due to NULL DPI\n");
+		return -EINVAL;
+	}
+
 	hwq_attr.res = res;
 	hwq_attr.depth = cq->max_wqe;
 	hwq_attr.stride = sizeof(struct cq_base);
@@ -2054,11 +2060,6 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 
 	RCFW_CMD_PREP(req, CREATE_CQ, cmd_flags);
 
-	if (!cq->dpi) {
-		dev_err(&rcfw->pdev->dev,
-			"FP: CREATE_CQ failed due to NULL DPI\n");
-		return -EINVAL;
-	}
 	req.dpi = cpu_to_le32(cq->dpi->dpi);
 	req.cq_handle = cpu_to_le64(cq->cq_handle);
 	req.cq_size = cpu_to_le32(cq->hwq.max_elements);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 126d4f26f75a..81b0c5e879f9 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -215,17 +215,9 @@ int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *hwq,
 			return -EINVAL;
 		hwq_attr->sginfo->npages = npages;
 	} else {
-		unsigned long sginfo_num_pages = ib_umem_num_dma_blocks(
-			hwq_attr->sginfo->umem, hwq_attr->sginfo->pgsize);
-
+		npages = ib_umem_num_dma_blocks(hwq_attr->sginfo->umem,
+						hwq_attr->sginfo->pgsize);
 		hwq->is_user = true;
-		npages = sginfo_num_pages;
-		npages = (npages * PAGE_SIZE) /
-			  BIT_ULL(hwq_attr->sginfo->pgshft);
-		if ((sginfo_num_pages * PAGE_SIZE) %
-		     BIT_ULL(hwq_attr->sginfo->pgshft))
-			if (!npages)
-				npages++;
 	}
 
 	if (npages == MAX_PBL_LVL_0_PGS && !hwq_attr->sginfo->nopte) {
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index b802981b7171..bae7d8926143 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -584,16 +584,15 @@ int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
 		/* Free the hwq if it already exist, must be a rereg */
 		if (mr->hwq.max_elements)
 			bnxt_qplib_free_hwq(res, &mr->hwq);
-		/* Use system PAGE_SIZE */
 		hwq_attr.res = res;
 		hwq_attr.depth = pages;
-		hwq_attr.stride = buf_pg_size;
+		hwq_attr.stride = sizeof(dma_addr_t);
 		hwq_attr.type = HWQ_TYPE_MR;
 		hwq_attr.sginfo = &sginfo;
 		hwq_attr.sginfo->umem = umem;
 		hwq_attr.sginfo->npages = pages;
-		hwq_attr.sginfo->pgsize = PAGE_SIZE;
-		hwq_attr.sginfo->pgshft = PAGE_SHIFT;
+		hwq_attr.sginfo->pgsize = buf_pg_size;
+		hwq_attr.sginfo->pgshft = ilog2(buf_pg_size);
 		rc = bnxt_qplib_alloc_init_hwq(&mr->hwq, &hwq_attr);
 		if (rc) {
 			dev_err(&res->pdev->dev,
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 31454643f8c5..f9526a4c75b2 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1397,7 +1397,7 @@ static int pbl_continuous_initialize(struct efa_dev *dev,
  */
 static int pbl_indirect_initialize(struct efa_dev *dev, struct pbl_context *pbl)
 {
-	u32 size_in_pages = DIV_ROUND_UP(pbl->pbl_buf_size_in_bytes, PAGE_SIZE);
+	u32 size_in_pages = DIV_ROUND_UP(pbl->pbl_buf_size_in_bytes, EFA_CHUNK_PAYLOAD_SIZE);
 	struct scatterlist *sgl;
 	int sg_dma_cnt, err;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index b2421883993b..34a270b6891a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4728,11 +4728,9 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	mtu = ib_mtu_enum_to_int(ib_mtu);
 	if (WARN_ON(mtu <= 0))
 		return -EINVAL;
-#define MAX_LP_MSG_LEN 16384
-	/* MTU * (2 ^ LP_PKTN_INI) shouldn't be bigger than 16KB */
-	lp_pktn_ini = ilog2(MAX_LP_MSG_LEN / mtu);
-	if (WARN_ON(lp_pktn_ini >= 0xF))
-		return -EINVAL;
+#define MIN_LP_MSG_LEN 1024
+	/* mtu * (2 ^ lp_pktn_ini) should be in the range of 1024 to mtu */
+	lp_pktn_ini = ilog2(max(mtu, MIN_LP_MSG_LEN) / mtu);
 
 	if (attr_mask & IB_QP_PATH_MTU) {
 		hr_reg_write(context, QPC_MTU, ib_mtu);
@@ -5136,7 +5134,6 @@ static int hns_roce_v2_set_abs_fields(struct ib_qp *ibqp,
 static bool check_qp_timeout_cfg_range(struct hns_roce_dev *hr_dev, u8 *timeout)
 {
 #define QP_ACK_TIMEOUT_MAX_HIP08 20
-#define QP_ACK_TIMEOUT_OFFSET 10
 #define QP_ACK_TIMEOUT_MAX 31
 
 	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08) {
@@ -5145,7 +5142,7 @@ static bool check_qp_timeout_cfg_range(struct hns_roce_dev *hr_dev, u8 *timeout)
 				   "local ACK timeout shall be 0 to 20.\n");
 			return false;
 		}
-		*timeout += QP_ACK_TIMEOUT_OFFSET;
+		*timeout += HNS_ROCE_V2_QP_ACK_TIMEOUT_OFS_HIP08;
 	} else if (hr_dev->pci_dev->revision > PCI_REVISION_ID_HIP08) {
 		if (*timeout > QP_ACK_TIMEOUT_MAX) {
 			ibdev_warn(&hr_dev->ib_dev,
@@ -5431,6 +5428,18 @@ static int hns_roce_v2_query_qpc(struct hns_roce_dev *hr_dev, u32 qpn,
 	return ret;
 }
 
+static u8 get_qp_timeout_attr(struct hns_roce_dev *hr_dev,
+			      struct hns_roce_v2_qp_context *context)
+{
+	u8 timeout;
+
+	timeout = (u8)hr_reg_read(context, QPC_AT);
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08)
+		timeout -= HNS_ROCE_V2_QP_ACK_TIMEOUT_OFS_HIP08;
+
+	return timeout;
+}
+
 static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 				int qp_attr_mask,
 				struct ib_qp_init_attr *qp_init_attr)
@@ -5508,7 +5517,7 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	qp_attr->max_dest_rd_atomic = 1 << hr_reg_read(&context, QPC_RR_MAX);
 
 	qp_attr->min_rnr_timer = (u8)hr_reg_read(&context, QPC_MIN_RNR_TIME);
-	qp_attr->timeout = (u8)hr_reg_read(&context, QPC_AT);
+	qp_attr->timeout = get_qp_timeout_attr(hr_dev, &context);
 	qp_attr->retry_cnt = hr_reg_read(&context, QPC_RETRY_NUM_INIT);
 	qp_attr->rnr_retry = hr_reg_read(&context, QPC_RNR_NUM_INIT);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index b1b3e1e0b84e..2b4dbbb06eb5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -72,6 +72,8 @@
 #define HNS_ROCE_V2_IDX_ENTRY_SZ		4
 
 #define HNS_ROCE_V2_SCCC_SZ			32
+#define HNS_ROCE_V2_QP_ACK_TIMEOUT_OFS_HIP08    10
+
 #define HNS_ROCE_V3_SCCC_SZ			64
 #define HNS_ROCE_V3_GMV_ENTRY_SZ		32
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 37a5cf62f88b..14376490ac22 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -33,6 +33,7 @@
 
 #include <linux/vmalloc.h>
 #include <rdma/ib_umem.h>
+#include <linux/math.h>
 #include "hns_roce_device.h"
 #include "hns_roce_cmd.h"
 #include "hns_roce_hem.h"
@@ -909,6 +910,44 @@ static int mtr_init_buf_cfg(struct hns_roce_dev *hr_dev,
 	return page_cnt;
 }
 
+static u64 cal_pages_per_l1ba(unsigned int ba_per_bt, unsigned int hopnum)
+{
+	return int_pow(ba_per_bt, hopnum - 1);
+}
+
+static unsigned int cal_best_bt_pg_sz(struct hns_roce_dev *hr_dev,
+				      struct hns_roce_mtr *mtr,
+				      unsigned int pg_shift)
+{
+	unsigned long cap = hr_dev->caps.page_size_cap;
+	struct hns_roce_buf_region *re;
+	unsigned int pgs_per_l1ba;
+	unsigned int ba_per_bt;
+	unsigned int ba_num;
+	int i;
+
+	for_each_set_bit_from(pg_shift, &cap, sizeof(cap) * BITS_PER_BYTE) {
+		if (!(BIT(pg_shift) & cap))
+			continue;
+
+		ba_per_bt = BIT(pg_shift) / BA_BYTE_LEN;
+		ba_num = 0;
+		for (i = 0; i < mtr->hem_cfg.region_count; i++) {
+			re = &mtr->hem_cfg.region[i];
+			if (re->hopnum == 0)
+				continue;
+
+			pgs_per_l1ba = cal_pages_per_l1ba(ba_per_bt, re->hopnum);
+			ba_num += DIV_ROUND_UP(re->count, pgs_per_l1ba);
+		}
+
+		if (ba_num <= ba_per_bt)
+			return pg_shift;
+	}
+
+	return 0;
+}
+
 static int mtr_alloc_mtt(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 			 unsigned int ba_page_shift)
 {
@@ -917,6 +956,10 @@ static int mtr_alloc_mtt(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 
 	hns_roce_hem_list_init(&mtr->hem_list);
 	if (!cfg->is_direct) {
+		ba_page_shift = cal_best_bt_pg_sz(hr_dev, mtr, ba_page_shift);
+		if (!ba_page_shift)
+			return -ERANGE;
+
 		ret = hns_roce_hem_list_request(hr_dev, &mtr->hem_list,
 						cfg->region, cfg->region_count,
 						ba_page_shift);
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index f6973ea55eda..6a8bb6ed4bf4 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -522,11 +522,6 @@ static int irdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	if (!iwqp->user_mode)
 		cancel_delayed_work_sync(&iwqp->dwork_flush);
 
-	irdma_qp_rem_ref(&iwqp->ibqp);
-	wait_for_completion(&iwqp->free_qp);
-	irdma_free_lsmm_rsrc(iwqp);
-	irdma_cqp_qp_destroy_cmd(&iwdev->rf->sc_dev, &iwqp->sc_qp);
-
 	if (!iwqp->user_mode) {
 		if (iwqp->iwscq) {
 			irdma_clean_cqes(iwqp, iwqp->iwscq);
@@ -534,6 +529,12 @@ static int irdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 				irdma_clean_cqes(iwqp, iwqp->iwrcq);
 		}
 	}
+
+	irdma_qp_rem_ref(&iwqp->ibqp);
+	wait_for_completion(&iwqp->free_qp);
+	irdma_free_lsmm_rsrc(iwqp);
+	irdma_cqp_qp_destroy_cmd(&iwdev->rf->sc_dev, &iwqp->sc_qp);
+
 	irdma_remove_push_mmap_entries(iwqp);
 	irdma_free_qp_rsrc(iwqp);
 
@@ -3190,6 +3191,7 @@ static int irdma_post_send(struct ib_qp *ibqp,
 			break;
 		case IB_WR_LOCAL_INV:
 			info.op_type = IRDMA_OP_TYPE_INV_STAG;
+			info.local_fence = info.read_fence;
 			info.op.inv_local_stag.target_stag = ib_wr->ex.invalidate_rkey;
 			err = irdma_uk_stag_local_invalidate(ukqp, &info, true);
 			break;
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index c160a332ce33..471f40351f4c 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -15,9 +15,7 @@ extern irqreturn_t amd_iommu_int_thread(int irq, void *data);
 extern irqreturn_t amd_iommu_int_handler(int irq, void *data);
 extern void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
 extern void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
-extern int amd_iommu_init_devices(void);
-extern void amd_iommu_uninit_devices(void);
-extern void amd_iommu_init_notifier(void);
+extern void amd_iommu_restart_ga_log(struct amd_iommu *iommu);
 extern void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 7c14b1d32c8d..b0af8b5967e0 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -751,6 +751,30 @@ void amd_iommu_restart_event_logging(struct amd_iommu *iommu)
 	iommu_feature_enable(iommu, CONTROL_EVT_LOG_EN);
 }
 
+/*
+ * This function restarts event logging in case the IOMMU experienced
+ * an GA log overflow.
+ */
+void amd_iommu_restart_ga_log(struct amd_iommu *iommu)
+{
+	u32 status;
+
+	status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
+	if (status & MMIO_STATUS_GALOG_RUN_MASK)
+		return;
+
+	pr_info_ratelimited("IOMMU GA Log restarting\n");
+
+	iommu_feature_disable(iommu, CONTROL_GALOG_EN);
+	iommu_feature_disable(iommu, CONTROL_GAINT_EN);
+
+	writel(MMIO_STATUS_GALOG_OVERFLOW_MASK,
+	       iommu->mmio_base + MMIO_STATUS_OFFSET);
+
+	iommu_feature_enable(iommu, CONTROL_GAINT_EN);
+	iommu_feature_enable(iommu, CONTROL_GALOG_EN);
+}
+
 /*
  * This function resets the command buffer if the IOMMU stopped fetching
  * commands from it.
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 26fb78003889..5d34416b3468 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -836,6 +836,7 @@ amd_iommu_set_pci_msi_domain(struct device *dev, struct amd_iommu *iommu) { }
 	(MMIO_STATUS_EVT_OVERFLOW_INT_MASK | \
 	 MMIO_STATUS_EVT_INT_MASK | \
 	 MMIO_STATUS_PPR_INT_MASK | \
+	 MMIO_STATUS_GALOG_OVERFLOW_MASK | \
 	 MMIO_STATUS_GALOG_INT_MASK)
 
 irqreturn_t amd_iommu_int_thread(int irq, void *data)
@@ -859,10 +860,16 @@ irqreturn_t amd_iommu_int_thread(int irq, void *data)
 		}
 
 #ifdef CONFIG_IRQ_REMAP
-		if (status & MMIO_STATUS_GALOG_INT_MASK) {
+		if (status & (MMIO_STATUS_GALOG_INT_MASK |
+			      MMIO_STATUS_GALOG_OVERFLOW_MASK)) {
 			pr_devel("Processing IOMMU GA Log\n");
 			iommu_poll_ga_log(iommu);
 		}
+
+		if (status & MMIO_STATUS_GALOG_OVERFLOW_MASK) {
+			pr_info_ratelimited("IOMMU GA Log overflow\n");
+			amd_iommu_restart_ga_log(iommu);
+		}
 #endif
 
 		if (status & MMIO_STATUS_EVT_OVERFLOW_INT_MASK) {
@@ -2094,6 +2101,15 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	return NULL;
 }
 
+static inline u64 dma_max_address(void)
+{
+	if (amd_iommu_pgtable == AMD_IOMMU_V1)
+		return ~0ULL;
+
+	/* V2 with 4 level page table */
+	return ((1ULL << PM_LEVEL_SHIFT(PAGE_MODE_4_LEVEL)) - 1);
+}
+
 static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 {
 	struct protection_domain *domain;
@@ -2110,7 +2126,7 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 		return NULL;
 
 	domain->domain.geometry.aperture_start = 0;
-	domain->domain.geometry.aperture_end   = ~0ULL;
+	domain->domain.geometry.aperture_end   = dma_max_address();
 	domain->domain.geometry.force_aperture = true;
 
 	return &domain->domain;
@@ -2389,7 +2405,7 @@ static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
 	unsigned long flags;
 
 	spin_lock_irqsave(&dom->lock, flags);
-	domain_flush_pages(dom, gather->start, gather->end - gather->start, 1);
+	domain_flush_pages(dom, gather->start, gather->end - gather->start + 1, 1);
 	amd_iommu_domain_flush_complete(dom);
 	spin_unlock_irqrestore(&dom->lock, flags);
 }
@@ -3504,8 +3520,7 @@ int amd_iommu_activate_guest_mode(void *data)
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
 	u64 valid;
 
-	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
-	    !entry || entry->lo.fields_vapic.guest_mode)
+	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) || !entry)
 		return 0;
 
 	valid = entry->lo.fields_vapic.valid;
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index e93ca9dc37c8..2ae5a6058a34 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -737,7 +737,8 @@ static void mtk_iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 
-	mtk_iommu_tlb_flush_all(dom->bank->parent_data);
+	if (dom->bank)
+		mtk_iommu_tlb_flush_all(dom->bank->parent_data);
 }
 
 static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index a68eadd64f38..f7e9b56be174 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1303,20 +1303,22 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	for (i = 0; i < iommu->num_irq; i++) {
 		int irq = platform_get_irq(pdev, i);
 
-		if (irq < 0)
-			return irq;
+		if (irq < 0) {
+			err = irq;
+			goto err_pm_disable;
+		}
 
 		err = devm_request_irq(iommu->dev, irq, rk_iommu_irq,
 				       IRQF_SHARED, dev_name(dev), iommu);
-		if (err) {
-			pm_runtime_disable(dev);
-			goto err_remove_sysfs;
-		}
+		if (err)
+			goto err_pm_disable;
 	}
 
 	dma_set_mask_and_coherent(dev, rk_ops->dma_bit_mask);
 
 	return 0;
+err_pm_disable:
+	pm_runtime_disable(dev);
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
 err_put_group:
diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
index 4555d678fadd..abcee58e851c 100644
--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/poll.h>
@@ -38,6 +39,7 @@ struct mbox_test_device {
 	char			*signal;
 	char			*message;
 	spinlock_t		lock;
+	struct mutex		mutex;
 	wait_queue_head_t	waitq;
 	struct fasync_struct	*async_queue;
 	struct dentry		*root_debugfs_dir;
@@ -95,6 +97,7 @@ static ssize_t mbox_test_message_write(struct file *filp,
 				       size_t count, loff_t *ppos)
 {
 	struct mbox_test_device *tdev = filp->private_data;
+	char *message;
 	void *data;
 	int ret;
 
@@ -110,10 +113,13 @@ static ssize_t mbox_test_message_write(struct file *filp,
 		return -EINVAL;
 	}
 
-	tdev->message = kzalloc(MBOX_MAX_MSG_LEN, GFP_KERNEL);
-	if (!tdev->message)
+	message = kzalloc(MBOX_MAX_MSG_LEN, GFP_KERNEL);
+	if (!message)
 		return -ENOMEM;
 
+	mutex_lock(&tdev->mutex);
+
+	tdev->message = message;
 	ret = copy_from_user(tdev->message, userbuf, count);
 	if (ret) {
 		ret = -EFAULT;
@@ -144,6 +150,8 @@ static ssize_t mbox_test_message_write(struct file *filp,
 	kfree(tdev->message);
 	tdev->signal = NULL;
 
+	mutex_unlock(&tdev->mutex);
+
 	return ret < 0 ? ret : count;
 }
 
@@ -392,6 +400,7 @@ static int mbox_test_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, tdev);
 
 	spin_lock_init(&tdev->lock);
+	mutex_init(&tdev->mutex);
 
 	if (tdev->rx_channel) {
 		tdev->rx_buffer = devm_kzalloc(&pdev->dev,
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index f787c9e5b10e..fbef3c9badb6 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5516,7 +5516,7 @@ static int raid5_read_one_chunk(struct mddev *mddev, struct bio *raid_bio)
 
 	sector = raid5_compute_sector(conf, raid_bio->bi_iter.bi_sector, 0,
 				      &dd_idx, NULL);
-	end_sector = bio_end_sector(raid_bio);
+	end_sector = sector + bio_sectors(raid_bio);
 
 	rcu_read_lock();
 	if (r5c_big_stripe_cached(conf, sector))
diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c b/drivers/media/dvb-core/dvb_ca_en50221.c
index c2d2792227f8..baf64540dc00 100644
--- a/drivers/media/dvb-core/dvb_ca_en50221.c
+++ b/drivers/media/dvb-core/dvb_ca_en50221.c
@@ -151,6 +151,12 @@ struct dvb_ca_private {
 
 	/* mutex serializing ioctls */
 	struct mutex ioctl_mutex;
+
+	/* A mutex used when a device is disconnected */
+	struct mutex remove_mutex;
+
+	/* Whether the device is disconnected */
+	int exit;
 };
 
 static void dvb_ca_private_free(struct dvb_ca_private *ca)
@@ -187,7 +193,7 @@ static void dvb_ca_en50221_thread_wakeup(struct dvb_ca_private *ca);
 static int dvb_ca_en50221_read_data(struct dvb_ca_private *ca, int slot,
 				    u8 *ebuf, int ecount);
 static int dvb_ca_en50221_write_data(struct dvb_ca_private *ca, int slot,
-				     u8 *ebuf, int ecount);
+				     u8 *ebuf, int ecount, int size_write_flag);
 
 /**
  * findstr - Safely find needle in haystack.
@@ -370,7 +376,7 @@ static int dvb_ca_en50221_link_init(struct dvb_ca_private *ca, int slot)
 	ret = dvb_ca_en50221_wait_if_status(ca, slot, STATUSREG_FR, HZ / 10);
 	if (ret)
 		return ret;
-	ret = dvb_ca_en50221_write_data(ca, slot, buf, 2);
+	ret = dvb_ca_en50221_write_data(ca, slot, buf, 2, CMDREG_SW);
 	if (ret != 2)
 		return -EIO;
 	ret = ca->pub->write_cam_control(ca->pub, slot, CTRLIF_COMMAND, IRQEN);
@@ -778,11 +784,13 @@ static int dvb_ca_en50221_read_data(struct dvb_ca_private *ca, int slot,
  * @buf: The data in this buffer is treated as a complete link-level packet to
  *	 be written.
  * @bytes_write: Size of ebuf.
+ * @size_write_flag: A flag on Command Register which says whether the link size
+ * information will be writen or not.
  *
  * return: Number of bytes written, or < 0 on error.
  */
 static int dvb_ca_en50221_write_data(struct dvb_ca_private *ca, int slot,
-				     u8 *buf, int bytes_write)
+				     u8 *buf, int bytes_write, int size_write_flag)
 {
 	struct dvb_ca_slot *sl = &ca->slot_info[slot];
 	int status;
@@ -817,7 +825,7 @@ static int dvb_ca_en50221_write_data(struct dvb_ca_private *ca, int slot,
 
 	/* OK, set HC bit */
 	status = ca->pub->write_cam_control(ca->pub, slot, CTRLIF_COMMAND,
-					    IRQEN | CMDREG_HC);
+					    IRQEN | CMDREG_HC | size_write_flag);
 	if (status)
 		goto exit;
 
@@ -1508,7 +1516,7 @@ static ssize_t dvb_ca_en50221_io_write(struct file *file,
 
 			mutex_lock(&sl->slot_lock);
 			status = dvb_ca_en50221_write_data(ca, slot, fragbuf,
-							   fraglen + 2);
+							   fraglen + 2, 0);
 			mutex_unlock(&sl->slot_lock);
 			if (status == (fraglen + 2)) {
 				written = 1;
@@ -1709,12 +1717,22 @@ static int dvb_ca_en50221_io_open(struct inode *inode, struct file *file)
 
 	dprintk("%s\n", __func__);
 
-	if (!try_module_get(ca->pub->owner))
+	mutex_lock(&ca->remove_mutex);
+
+	if (ca->exit) {
+		mutex_unlock(&ca->remove_mutex);
+		return -ENODEV;
+	}
+
+	if (!try_module_get(ca->pub->owner)) {
+		mutex_unlock(&ca->remove_mutex);
 		return -EIO;
+	}
 
 	err = dvb_generic_open(inode, file);
 	if (err < 0) {
 		module_put(ca->pub->owner);
+		mutex_unlock(&ca->remove_mutex);
 		return err;
 	}
 
@@ -1739,6 +1757,7 @@ static int dvb_ca_en50221_io_open(struct inode *inode, struct file *file)
 
 	dvb_ca_private_get(ca);
 
+	mutex_unlock(&ca->remove_mutex);
 	return 0;
 }
 
@@ -1758,6 +1777,8 @@ static int dvb_ca_en50221_io_release(struct inode *inode, struct file *file)
 
 	dprintk("%s\n", __func__);
 
+	mutex_lock(&ca->remove_mutex);
+
 	/* mark the CA device as closed */
 	ca->open = 0;
 	dvb_ca_en50221_thread_update_delay(ca);
@@ -1768,6 +1789,13 @@ static int dvb_ca_en50221_io_release(struct inode *inode, struct file *file)
 
 	dvb_ca_private_put(ca);
 
+	if (dvbdev->users == 1 && ca->exit == 1) {
+		mutex_unlock(&ca->remove_mutex);
+		wake_up(&dvbdev->wait_queue);
+	} else {
+		mutex_unlock(&ca->remove_mutex);
+	}
+
 	return err;
 }
 
@@ -1891,6 +1919,7 @@ int dvb_ca_en50221_init(struct dvb_adapter *dvb_adapter,
 	}
 
 	mutex_init(&ca->ioctl_mutex);
+	mutex_init(&ca->remove_mutex);
 
 	if (signal_pending(current)) {
 		ret = -EINTR;
@@ -1933,6 +1962,14 @@ void dvb_ca_en50221_release(struct dvb_ca_en50221 *pubca)
 
 	dprintk("%s\n", __func__);
 
+	mutex_lock(&ca->remove_mutex);
+	ca->exit = 1;
+	mutex_unlock(&ca->remove_mutex);
+
+	if (ca->dvbdev->users < 1)
+		wait_event(ca->dvbdev->wait_queue,
+				ca->dvbdev->users == 1);
+
 	/* shutdown the thread if there was one */
 	kthread_stop(ca->thread);
 
diff --git a/drivers/media/dvb-core/dvb_demux.c b/drivers/media/dvb-core/dvb_demux.c
index 83cc32ad7e12..eadd579bb4fa 100644
--- a/drivers/media/dvb-core/dvb_demux.c
+++ b/drivers/media/dvb-core/dvb_demux.c
@@ -115,12 +115,12 @@ static inline int dvb_dmx_swfilter_payload(struct dvb_demux_feed *feed,
 
 	cc = buf[3] & 0x0f;
 	ccok = ((feed->cc + 1) & 0x0f) == cc;
-	feed->cc = cc;
 	if (!ccok) {
 		set_buf_flags(feed, DMX_BUFFER_FLAG_DISCONTINUITY_DETECTED);
 		dprintk_sect_loss("missed packet: %d instead of %d!\n",
 				  cc, (feed->cc + 1) & 0x0f);
 	}
+	feed->cc = cc;
 
 	if (buf[1] & 0x40)	// PUSI ?
 		feed->peslen = 0xfffa;
@@ -300,7 +300,6 @@ static int dvb_dmx_swfilter_section_packet(struct dvb_demux_feed *feed,
 
 	cc = buf[3] & 0x0f;
 	ccok = ((feed->cc + 1) & 0x0f) == cc;
-	feed->cc = cc;
 
 	if (buf[3] & 0x20) {
 		/* adaption field present, check for discontinuity_indicator */
@@ -336,6 +335,7 @@ static int dvb_dmx_swfilter_section_packet(struct dvb_demux_feed *feed,
 		feed->pusi_seen = false;
 		dvb_dmx_swfilter_section_new(feed);
 	}
+	feed->cc = cc;
 
 	if (buf[1] & 0x40) {
 		/* PUSI=1 (is set), section boundary is here */
diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index c41a7e5c2b92..fce0e2094078 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -293,14 +293,22 @@ static int dvb_frontend_get_event(struct dvb_frontend *fe,
 	}
 
 	if (events->eventw == events->eventr) {
-		int ret;
+		struct wait_queue_entry wait;
+		int ret = 0;
 
 		if (flags & O_NONBLOCK)
 			return -EWOULDBLOCK;
 
-		ret = wait_event_interruptible(events->wait_queue,
-					       dvb_frontend_test_event(fepriv, events));
-
+		init_waitqueue_entry(&wait, current);
+		add_wait_queue(&events->wait_queue, &wait);
+		while (!dvb_frontend_test_event(fepriv, events)) {
+			wait_woken(&wait, TASK_INTERRUPTIBLE, 0);
+			if (signal_pending(current)) {
+				ret = -ERESTARTSYS;
+				break;
+			}
+		}
+		remove_wait_queue(&events->wait_queue, &wait);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/drivers/media/dvb-core/dvb_net.c b/drivers/media/dvb-core/dvb_net.c
index 8a2febf33ce2..8bb8dd34c223 100644
--- a/drivers/media/dvb-core/dvb_net.c
+++ b/drivers/media/dvb-core/dvb_net.c
@@ -1564,15 +1564,43 @@ static long dvb_net_ioctl(struct file *file,
 	return dvb_usercopy(file, cmd, arg, dvb_net_do_ioctl);
 }
 
+static int locked_dvb_net_open(struct inode *inode, struct file *file)
+{
+	struct dvb_device *dvbdev = file->private_data;
+	struct dvb_net *dvbnet = dvbdev->priv;
+	int ret;
+
+	if (mutex_lock_interruptible(&dvbnet->remove_mutex))
+		return -ERESTARTSYS;
+
+	if (dvbnet->exit) {
+		mutex_unlock(&dvbnet->remove_mutex);
+		return -ENODEV;
+	}
+
+	ret = dvb_generic_open(inode, file);
+
+	mutex_unlock(&dvbnet->remove_mutex);
+
+	return ret;
+}
+
 static int dvb_net_close(struct inode *inode, struct file *file)
 {
 	struct dvb_device *dvbdev = file->private_data;
 	struct dvb_net *dvbnet = dvbdev->priv;
 
+	mutex_lock(&dvbnet->remove_mutex);
+
 	dvb_generic_release(inode, file);
 
-	if(dvbdev->users == 1 && dvbnet->exit == 1)
+	if (dvbdev->users == 1 && dvbnet->exit == 1) {
+		mutex_unlock(&dvbnet->remove_mutex);
 		wake_up(&dvbdev->wait_queue);
+	} else {
+		mutex_unlock(&dvbnet->remove_mutex);
+	}
+
 	return 0;
 }
 
@@ -1580,7 +1608,7 @@ static int dvb_net_close(struct inode *inode, struct file *file)
 static const struct file_operations dvb_net_fops = {
 	.owner = THIS_MODULE,
 	.unlocked_ioctl = dvb_net_ioctl,
-	.open =	dvb_generic_open,
+	.open =	locked_dvb_net_open,
 	.release = dvb_net_close,
 	.llseek = noop_llseek,
 };
@@ -1599,10 +1627,13 @@ void dvb_net_release (struct dvb_net *dvbnet)
 {
 	int i;
 
+	mutex_lock(&dvbnet->remove_mutex);
 	dvbnet->exit = 1;
+	mutex_unlock(&dvbnet->remove_mutex);
+
 	if (dvbnet->dvbdev->users < 1)
 		wait_event(dvbnet->dvbdev->wait_queue,
-				dvbnet->dvbdev->users==1);
+				dvbnet->dvbdev->users == 1);
 
 	dvb_unregister_device(dvbnet->dvbdev);
 
@@ -1621,6 +1652,7 @@ int dvb_net_init (struct dvb_adapter *adap, struct dvb_net *dvbnet,
 	int i;
 
 	mutex_init(&dvbnet->ioctl_mutex);
+	mutex_init(&dvbnet->remove_mutex);
 	dvbnet->demux = dmx;
 
 	for (i=0; i<DVB_NET_DEVICES_MAX; i++)
diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index a31d52cb6d62..9f9a97652708 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -27,6 +27,7 @@
 #include <media/tuner.h>
 
 static DEFINE_MUTEX(dvbdev_mutex);
+static LIST_HEAD(dvbdevfops_list);
 static int dvbdev_debug;
 
 module_param(dvbdev_debug, int, 0644);
@@ -452,14 +453,15 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 			enum dvb_device_type type, int demux_sink_pads)
 {
 	struct dvb_device *dvbdev;
-	struct file_operations *dvbdevfops;
+	struct file_operations *dvbdevfops = NULL;
+	struct dvbdevfops_node *node = NULL, *new_node = NULL;
 	struct device *clsdev;
 	int minor;
 	int id, ret;
 
 	mutex_lock(&dvbdev_register_lock);
 
-	if ((id = dvbdev_get_free_id (adap, type)) < 0){
+	if ((id = dvbdev_get_free_id (adap, type)) < 0) {
 		mutex_unlock(&dvbdev_register_lock);
 		*pdvbdev = NULL;
 		pr_err("%s: couldn't find free device id\n", __func__);
@@ -467,18 +469,45 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	}
 
 	*pdvbdev = dvbdev = kzalloc(sizeof(*dvbdev), GFP_KERNEL);
-
 	if (!dvbdev){
 		mutex_unlock(&dvbdev_register_lock);
 		return -ENOMEM;
 	}
 
-	dvbdevfops = kmemdup(template->fops, sizeof(*dvbdevfops), GFP_KERNEL);
+	/*
+	 * When a device of the same type is probe()d more than once,
+	 * the first allocated fops are used. This prevents memory leaks
+	 * that can occur when the same device is probe()d repeatedly.
+	 */
+	list_for_each_entry(node, &dvbdevfops_list, list_head) {
+		if (node->fops->owner == adap->module &&
+				node->type == type &&
+				node->template == template) {
+			dvbdevfops = node->fops;
+			break;
+		}
+	}
 
-	if (!dvbdevfops){
-		kfree (dvbdev);
-		mutex_unlock(&dvbdev_register_lock);
-		return -ENOMEM;
+	if (dvbdevfops == NULL) {
+		dvbdevfops = kmemdup(template->fops, sizeof(*dvbdevfops), GFP_KERNEL);
+		if (!dvbdevfops) {
+			kfree(dvbdev);
+			mutex_unlock(&dvbdev_register_lock);
+			return -ENOMEM;
+		}
+
+		new_node = kzalloc(sizeof(struct dvbdevfops_node), GFP_KERNEL);
+		if (!new_node) {
+			kfree(dvbdevfops);
+			kfree(dvbdev);
+			mutex_unlock(&dvbdev_register_lock);
+			return -ENOMEM;
+		}
+
+		new_node->fops = dvbdevfops;
+		new_node->type = type;
+		new_node->template = template;
+		list_add_tail (&new_node->list_head, &dvbdevfops_list);
 	}
 
 	memcpy(dvbdev, template, sizeof(struct dvb_device));
@@ -489,20 +518,20 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	dvbdev->priv = priv;
 	dvbdev->fops = dvbdevfops;
 	init_waitqueue_head (&dvbdev->wait_queue);
-
 	dvbdevfops->owner = adap->module;
-
 	list_add_tail (&dvbdev->list_head, &adap->device_list);
-
 	down_write(&minor_rwsem);
 #ifdef CONFIG_DVB_DYNAMIC_MINORS
 	for (minor = 0; minor < MAX_DVB_MINORS; minor++)
 		if (dvb_minors[minor] == NULL)
 			break;
-
 	if (minor == MAX_DVB_MINORS) {
+		if (new_node) {
+			list_del (&new_node->list_head);
+			kfree(dvbdevfops);
+			kfree(new_node);
+		}
 		list_del (&dvbdev->list_head);
-		kfree(dvbdevfops);
 		kfree(dvbdev);
 		up_write(&minor_rwsem);
 		mutex_unlock(&dvbdev_register_lock);
@@ -511,41 +540,47 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 #else
 	minor = nums2minor(adap->num, type, id);
 #endif
-
 	dvbdev->minor = minor;
 	dvb_minors[minor] = dvb_device_get(dvbdev);
 	up_write(&minor_rwsem);
-
 	ret = dvb_register_media_device(dvbdev, type, minor, demux_sink_pads);
 	if (ret) {
 		pr_err("%s: dvb_register_media_device failed to create the mediagraph\n",
 		      __func__);
-
+		if (new_node) {
+			list_del (&new_node->list_head);
+			kfree(dvbdevfops);
+			kfree(new_node);
+		}
 		dvb_media_device_free(dvbdev);
 		list_del (&dvbdev->list_head);
-		kfree(dvbdevfops);
 		kfree(dvbdev);
 		mutex_unlock(&dvbdev_register_lock);
 		return ret;
 	}
 
-	mutex_unlock(&dvbdev_register_lock);
-
 	clsdev = device_create(dvb_class, adap->device,
 			       MKDEV(DVB_MAJOR, minor),
 			       dvbdev, "dvb%d.%s%d", adap->num, dnames[type], id);
 	if (IS_ERR(clsdev)) {
 		pr_err("%s: failed to create device dvb%d.%s%d (%ld)\n",
 		       __func__, adap->num, dnames[type], id, PTR_ERR(clsdev));
+		if (new_node) {
+			list_del (&new_node->list_head);
+			kfree(dvbdevfops);
+			kfree(new_node);
+		}
 		dvb_media_device_free(dvbdev);
 		list_del (&dvbdev->list_head);
-		kfree(dvbdevfops);
 		kfree(dvbdev);
+		mutex_unlock(&dvbdev_register_lock);
 		return PTR_ERR(clsdev);
 	}
+
 	dprintk("DVB: register adapter%d/%s%d @ minor: %i (0x%02x)\n",
 		adap->num, dnames[type], id, minor, minor);
 
+	mutex_unlock(&dvbdev_register_lock);
 	return 0;
 }
 EXPORT_SYMBOL(dvb_register_device);
@@ -574,7 +609,6 @@ static void dvb_free_device(struct kref *ref)
 {
 	struct dvb_device *dvbdev = container_of(ref, struct dvb_device, ref);
 
-	kfree (dvbdev->fops);
 	kfree (dvbdev);
 }
 
@@ -1080,9 +1114,17 @@ static int __init init_dvbdev(void)
 
 static void __exit exit_dvbdev(void)
 {
+	struct dvbdevfops_node *node, *next;
+
 	class_destroy(dvb_class);
 	cdev_del(&dvb_device_cdev);
 	unregister_chrdev_region(MKDEV(DVB_MAJOR, 0), MAX_DVB_MINORS);
+
+	list_for_each_entry_safe(node, next, &dvbdevfops_list, list_head) {
+		list_del (&node->list_head);
+		kfree(node->fops);
+		kfree(node);
+	}
 }
 
 subsys_initcall(init_dvbdev);
diff --git a/drivers/media/dvb-frontends/mn88443x.c b/drivers/media/dvb-frontends/mn88443x.c
index 452571b380b7..5a024870979d 100644
--- a/drivers/media/dvb-frontends/mn88443x.c
+++ b/drivers/media/dvb-frontends/mn88443x.c
@@ -798,7 +798,7 @@ MODULE_DEVICE_TABLE(i2c, mn88443x_i2c_id);
 static struct i2c_driver mn88443x_driver = {
 	.driver = {
 		.name = "mn88443x",
-		.of_match_table = of_match_ptr(mn88443x_of_match),
+		.of_match_table = mn88443x_of_match,
 	},
 	.probe    = mn88443x_probe,
 	.remove   = mn88443x_remove,
diff --git a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
index aaa1d2dedebd..d85bfbb77a25 100644
--- a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
+++ b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
@@ -887,12 +887,7 @@ static int netup_unidvb_initdev(struct pci_dev *pci_dev,
 		ndev->lmmio0, (u32)pci_resource_len(pci_dev, 0),
 		ndev->lmmio1, (u32)pci_resource_len(pci_dev, 1),
 		pci_dev->irq);
-	if (request_irq(pci_dev->irq, netup_unidvb_isr, IRQF_SHARED,
-			"netup_unidvb", pci_dev) < 0) {
-		dev_err(&pci_dev->dev,
-			"%s(): can't get IRQ %d\n", __func__, pci_dev->irq);
-		goto irq_request_err;
-	}
+
 	ndev->dma_size = 2 * 188 *
 		NETUP_DMA_BLOCKS_COUNT * NETUP_DMA_PACKETS_COUNT;
 	ndev->dma_virt = dma_alloc_coherent(&pci_dev->dev,
@@ -933,6 +928,14 @@ static int netup_unidvb_initdev(struct pci_dev *pci_dev,
 		dev_err(&pci_dev->dev, "netup_unidvb: DMA setup failed\n");
 		goto dma_setup_err;
 	}
+
+	if (request_irq(pci_dev->irq, netup_unidvb_isr, IRQF_SHARED,
+			"netup_unidvb", pci_dev) < 0) {
+		dev_err(&pci_dev->dev,
+			"%s(): can't get IRQ %d\n", __func__, pci_dev->irq);
+		goto dma_setup_err;
+	}
+
 	dev_info(&pci_dev->dev,
 		"netup_unidvb: device has been initialized\n");
 	return 0;
@@ -951,8 +954,6 @@ static int netup_unidvb_initdev(struct pci_dev *pci_dev,
 	dma_free_coherent(&pci_dev->dev, ndev->dma_size,
 			ndev->dma_virt, ndev->dma_phys);
 dma_alloc_err:
-	free_irq(pci_dev->irq, pci_dev);
-irq_request_err:
 	iounmap(ndev->lmmio1);
 pci_bar1_error:
 	iounmap(ndev->lmmio0);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
index 29991551cf61..0fbd030026c7 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
@@ -584,6 +584,9 @@ static void mtk_init_vdec_params(struct mtk_vcodec_ctx *ctx)
 
 	if (!(ctx->dev->dec_capability & VCODEC_CAPABILITY_4K_DISABLED)) {
 		for (i = 0; i < num_supported_formats; i++) {
+			if (mtk_video_formats[i].type != MTK_FMT_DEC)
+				continue;
+
 			mtk_video_formats[i].frmsize.max_width =
 				VCODEC_DEC_4K_CODED_WIDTH;
 			mtk_video_formats[i].frmsize.max_height =
diff --git a/drivers/media/platform/renesas/rcar-vin/rcar-dma.c b/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
index 3aea96d85165..ef5adffae197 100644
--- a/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
+++ b/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
@@ -651,11 +651,9 @@ static int rvin_setup(struct rvin_dev *vin)
 	case V4L2_FIELD_SEQ_TB:
 	case V4L2_FIELD_SEQ_BT:
 	case V4L2_FIELD_NONE:
-		vnmc = VNMC_IM_ODD_EVEN;
-		progressive = true;
-		break;
 	case V4L2_FIELD_ALTERNATE:
 		vnmc = VNMC_IM_ODD_EVEN;
+		progressive = true;
 		break;
 	default:
 		vnmc = VNMC_IM_ODD;
diff --git a/drivers/media/usb/dvb-usb-v2/ce6230.c b/drivers/media/usb/dvb-usb-v2/ce6230.c
index 44540de1a206..d3b5cb4a24da 100644
--- a/drivers/media/usb/dvb-usb-v2/ce6230.c
+++ b/drivers/media/usb/dvb-usb-v2/ce6230.c
@@ -101,6 +101,10 @@ static int ce6230_i2c_master_xfer(struct i2c_adapter *adap,
 		if (num > i + 1 && (msg[i+1].flags & I2C_M_RD)) {
 			if (msg[i].addr ==
 				ce6230_zl10353_config.demod_address) {
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				req.cmd = DEMOD_READ;
 				req.value = msg[i].addr >> 1;
 				req.index = msg[i].buf[0];
@@ -117,6 +121,10 @@ static int ce6230_i2c_master_xfer(struct i2c_adapter *adap,
 		} else {
 			if (msg[i].addr ==
 				ce6230_zl10353_config.demod_address) {
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				req.cmd = DEMOD_WRITE;
 				req.value = msg[i].addr >> 1;
 				req.index = msg[i].buf[0];
diff --git a/drivers/media/usb/dvb-usb-v2/ec168.c b/drivers/media/usb/dvb-usb-v2/ec168.c
index 7ed0ab9e429b..0e4773fc025c 100644
--- a/drivers/media/usb/dvb-usb-v2/ec168.c
+++ b/drivers/media/usb/dvb-usb-v2/ec168.c
@@ -115,6 +115,10 @@ static int ec168_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 	while (i < num) {
 		if (num > i + 1 && (msg[i+1].flags & I2C_M_RD)) {
 			if (msg[i].addr == ec168_ec100_config.demod_address) {
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				req.cmd = READ_DEMOD;
 				req.value = 0;
 				req.index = 0xff00 + msg[i].buf[0]; /* reg */
@@ -131,6 +135,10 @@ static int ec168_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			}
 		} else {
 			if (msg[i].addr == ec168_ec100_config.demod_address) {
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				req.cmd = WRITE_DEMOD;
 				req.value = msg[i].buf[1]; /* val */
 				req.index = 0xff00 + msg[i].buf[0]; /* reg */
@@ -139,6 +147,10 @@ static int ec168_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 				ret = ec168_ctrl_msg(d, &req);
 				i += 1;
 			} else {
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				req.cmd = WRITE_I2C;
 				req.value = msg[i].buf[0]; /* val */
 				req.index = 0x0100 + msg[i].addr; /* I2C addr */
diff --git a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
index 795a012d4020..f7884bb56fcc 100644
--- a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
+++ b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
@@ -176,6 +176,10 @@ static int rtl28xxu_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			ret = -EOPNOTSUPP;
 			goto err_mutex_unlock;
 		} else if (msg[0].addr == 0x10) {
+			if (msg[0].len < 1 || msg[1].len < 1) {
+				ret = -EOPNOTSUPP;
+				goto err_mutex_unlock;
+			}
 			/* method 1 - integrated demod */
 			if (msg[0].buf[0] == 0x00) {
 				/* return demod page from driver cache */
@@ -189,6 +193,10 @@ static int rtl28xxu_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 				ret = rtl28xxu_ctrl_msg(d, &req);
 			}
 		} else if (msg[0].len < 2) {
+			if (msg[0].len < 1) {
+				ret = -EOPNOTSUPP;
+				goto err_mutex_unlock;
+			}
 			/* method 2 - old I2C */
 			req.value = (msg[0].buf[0] << 8) | (msg[0].addr << 1);
 			req.index = CMD_I2C_RD;
@@ -217,8 +225,16 @@ static int rtl28xxu_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			ret = -EOPNOTSUPP;
 			goto err_mutex_unlock;
 		} else if (msg[0].addr == 0x10) {
+			if (msg[0].len < 1) {
+				ret = -EOPNOTSUPP;
+				goto err_mutex_unlock;
+			}
 			/* method 1 - integrated demod */
 			if (msg[0].buf[0] == 0x00) {
+				if (msg[0].len < 2) {
+					ret = -EOPNOTSUPP;
+					goto err_mutex_unlock;
+				}
 				/* save demod page for later demod access */
 				dev->page = msg[0].buf[1];
 				ret = 0;
@@ -231,6 +247,10 @@ static int rtl28xxu_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 				ret = rtl28xxu_ctrl_msg(d, &req);
 			}
 		} else if ((msg[0].len < 23) && (!dev->new_i2c_write)) {
+			if (msg[0].len < 1) {
+				ret = -EOPNOTSUPP;
+				goto err_mutex_unlock;
+			}
 			/* method 2 - old I2C */
 			req.value = (msg[0].buf[0] << 8) | (msg[0].addr << 1);
 			req.index = CMD_I2C_WR;
diff --git a/drivers/media/usb/dvb-usb/az6027.c b/drivers/media/usb/dvb-usb/az6027.c
index 7d78ee09be5e..a31c6f82f4e9 100644
--- a/drivers/media/usb/dvb-usb/az6027.c
+++ b/drivers/media/usb/dvb-usb/az6027.c
@@ -988,6 +988,10 @@ static int az6027_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int n
 			/* write/read request */
 			if (i + 1 < num && (msg[i + 1].flags & I2C_M_RD)) {
 				req = 0xB9;
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				index = (((msg[i].buf[0] << 8) & 0xff00) | (msg[i].buf[1] & 0x00ff));
 				value = msg[i].addr + (msg[i].len << 8);
 				length = msg[i + 1].len + 6;
@@ -1001,6 +1005,10 @@ static int az6027_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int n
 
 				/* demod 16bit addr */
 				req = 0xBD;
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				index = (((msg[i].buf[0] << 8) & 0xff00) | (msg[i].buf[1] & 0x00ff));
 				value = msg[i].addr + (2 << 8);
 				length = msg[i].len - 2;
@@ -1026,6 +1034,10 @@ static int az6027_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int n
 			} else {
 
 				req = 0xBD;
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				index = msg[i].buf[0] & 0x00FF;
 				value = msg[i].addr + (1 << 8);
 				length = msg[i].len - 1;
diff --git a/drivers/media/usb/dvb-usb/digitv.c b/drivers/media/usb/dvb-usb/digitv.c
index 2756815a780b..32134be16914 100644
--- a/drivers/media/usb/dvb-usb/digitv.c
+++ b/drivers/media/usb/dvb-usb/digitv.c
@@ -63,6 +63,10 @@ static int digitv_i2c_xfer(struct i2c_adapter *adap,struct i2c_msg msg[],int num
 		warn("more than 2 i2c messages at a time is not handled yet. TODO.");
 
 	for (i = 0; i < num; i++) {
+		if (msg[i].len < 1) {
+			i = -EOPNOTSUPP;
+			break;
+		}
 		/* write/read request */
 		if (i+1 < num && (msg[i+1].flags & I2C_M_RD)) {
 			if (digitv_ctrl_msg(d, USB_READ_COFDM, msg[i].buf[0], NULL, 0,
diff --git a/drivers/media/usb/dvb-usb/dw2102.c b/drivers/media/usb/dvb-usb/dw2102.c
index 0ca764282c76..8747960e6146 100644
--- a/drivers/media/usb/dvb-usb/dw2102.c
+++ b/drivers/media/usb/dvb-usb/dw2102.c
@@ -946,7 +946,7 @@ static int su3000_read_mac_address(struct dvb_usb_device *d, u8 mac[6])
 	for (i = 0; i < 6; i++) {
 		obuf[1] = 0xf0 + i;
 		if (i2c_transfer(&d->i2c_adap, msg, 2) != 2)
-			break;
+			return -1;
 		else
 			mac[i] = ibuf[0];
 	}
diff --git a/drivers/media/usb/ttusb-dec/ttusb_dec.c b/drivers/media/usb/ttusb-dec/ttusb_dec.c
index 38822cedd93a..c4474d4c44e2 100644
--- a/drivers/media/usb/ttusb-dec/ttusb_dec.c
+++ b/drivers/media/usb/ttusb-dec/ttusb_dec.c
@@ -1544,8 +1544,7 @@ static void ttusb_dec_exit_dvb(struct ttusb_dec *dec)
 	dvb_dmx_release(&dec->demux);
 	if (dec->fe) {
 		dvb_unregister_frontend(dec->fe);
-		if (dec->fe->ops.release)
-			dec->fe->ops.release(dec->fe);
+		dvb_frontend_detach(dec->fe);
 	}
 	dvb_unregister_adapter(&dec->adapter);
 }
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index a9cdef07e6b1..191db831d760 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -251,14 +251,17 @@ static int uvc_parse_format(struct uvc_device *dev,
 		/* Find the format descriptor from its GUID. */
 		fmtdesc = uvc_format_by_guid(&buffer[5]);
 
-		if (fmtdesc != NULL) {
-			format->fcc = fmtdesc->fcc;
-		} else {
+		if (!fmtdesc) {
+			/*
+			 * Unknown video formats are not fatal errors, the
+			 * caller will skip this descriptor.
+			 */
 			dev_info(&streaming->intf->dev,
 				 "Unknown video format %pUl\n", &buffer[5]);
-			format->fcc = 0;
+			return 0;
 		}
 
+		format->fcc = fmtdesc->fcc;
 		format->bpp = buffer[21];
 
 		/*
@@ -675,7 +678,7 @@ static int uvc_parse_streaming(struct uvc_device *dev,
 	interval = (u32 *)&frame[nframes];
 
 	streaming->format = format;
-	streaming->nformats = nformats;
+	streaming->nformats = 0;
 
 	/* Parse the format descriptors. */
 	while (buflen > 2 && buffer[1] == USB_DT_CS_INTERFACE) {
@@ -689,7 +692,10 @@ static int uvc_parse_streaming(struct uvc_device *dev,
 				&interval, buffer, buflen);
 			if (ret < 0)
 				goto error;
+			if (!ret)
+				break;
 
+			streaming->nformats++;
 			frame += format->nframes;
 			format++;
 
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 02d26160c64e..8b1e8661c3d7 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2149,8 +2149,10 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
 	struct fastrpc_invoke_ctx *ctx;
 
 	spin_lock(&user->lock);
-	list_for_each_entry(ctx, &user->pending, node)
+	list_for_each_entry(ctx, &user->pending, node) {
+		ctx->retval = -EPIPE;
 		complete(&ctx->work);
+	}
 	spin_unlock(&user->lock);
 }
 
@@ -2160,7 +2162,9 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	struct fastrpc_user *user;
 	unsigned long flags;
 
+	/* No invocations past this point */
 	spin_lock_irqsave(&cctx->lock, flags);
+	cctx->rpdev = NULL;
 	list_for_each_entry(user, &cctx->users, user)
 		fastrpc_notify_users(user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
@@ -2173,7 +2177,6 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 
 	of_platform_depopulate(&rpdev->dev);
 
-	cctx->rpdev = NULL;
 	fastrpc_channel_ctx_put(cctx);
 }
 
diff --git a/drivers/mmc/core/pwrseq_sd8787.c b/drivers/mmc/core/pwrseq_sd8787.c
index 2e120ad83020..0c5f5e371e1f 100644
--- a/drivers/mmc/core/pwrseq_sd8787.c
+++ b/drivers/mmc/core/pwrseq_sd8787.c
@@ -28,7 +28,6 @@ struct mmc_pwrseq_sd8787 {
 	struct mmc_pwrseq pwrseq;
 	struct gpio_desc *reset_gpio;
 	struct gpio_desc *pwrdn_gpio;
-	u32 reset_pwrdwn_delay_ms;
 };
 
 #define to_pwrseq_sd8787(p) container_of(p, struct mmc_pwrseq_sd8787, pwrseq)
@@ -39,7 +38,7 @@ static void mmc_pwrseq_sd8787_pre_power_on(struct mmc_host *host)
 
 	gpiod_set_value_cansleep(pwrseq->reset_gpio, 1);
 
-	msleep(pwrseq->reset_pwrdwn_delay_ms);
+	msleep(300);
 	gpiod_set_value_cansleep(pwrseq->pwrdn_gpio, 1);
 }
 
@@ -51,17 +50,37 @@ static void mmc_pwrseq_sd8787_power_off(struct mmc_host *host)
 	gpiod_set_value_cansleep(pwrseq->reset_gpio, 0);
 }
 
+static void mmc_pwrseq_wilc1000_pre_power_on(struct mmc_host *host)
+{
+	struct mmc_pwrseq_sd8787 *pwrseq = to_pwrseq_sd8787(host->pwrseq);
+
+	/* The pwrdn_gpio is really CHIP_EN, reset_gpio is RESETN */
+	gpiod_set_value_cansleep(pwrseq->pwrdn_gpio, 1);
+	msleep(5);
+	gpiod_set_value_cansleep(pwrseq->reset_gpio, 1);
+}
+
+static void mmc_pwrseq_wilc1000_power_off(struct mmc_host *host)
+{
+	struct mmc_pwrseq_sd8787 *pwrseq = to_pwrseq_sd8787(host->pwrseq);
+
+	gpiod_set_value_cansleep(pwrseq->reset_gpio, 0);
+	gpiod_set_value_cansleep(pwrseq->pwrdn_gpio, 0);
+}
+
 static const struct mmc_pwrseq_ops mmc_pwrseq_sd8787_ops = {
 	.pre_power_on = mmc_pwrseq_sd8787_pre_power_on,
 	.power_off = mmc_pwrseq_sd8787_power_off,
 };
 
-static const u32 sd8787_delay_ms = 300;
-static const u32 wilc1000_delay_ms = 5;
+static const struct mmc_pwrseq_ops mmc_pwrseq_wilc1000_ops = {
+	.pre_power_on = mmc_pwrseq_wilc1000_pre_power_on,
+	.power_off = mmc_pwrseq_wilc1000_power_off,
+};
 
 static const struct of_device_id mmc_pwrseq_sd8787_of_match[] = {
-	{ .compatible = "mmc-pwrseq-sd8787", .data = &sd8787_delay_ms },
-	{ .compatible = "mmc-pwrseq-wilc1000", .data = &wilc1000_delay_ms },
+	{ .compatible = "mmc-pwrseq-sd8787", .data = &mmc_pwrseq_sd8787_ops },
+	{ .compatible = "mmc-pwrseq-wilc1000", .data = &mmc_pwrseq_wilc1000_ops },
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, mmc_pwrseq_sd8787_of_match);
@@ -77,7 +96,6 @@ static int mmc_pwrseq_sd8787_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	match = of_match_node(mmc_pwrseq_sd8787_of_match, pdev->dev.of_node);
-	pwrseq->reset_pwrdwn_delay_ms = *(u32 *)match->data;
 
 	pwrseq->pwrdn_gpio = devm_gpiod_get(dev, "powerdown", GPIOD_OUT_LOW);
 	if (IS_ERR(pwrseq->pwrdn_gpio))
@@ -88,7 +106,7 @@ static int mmc_pwrseq_sd8787_probe(struct platform_device *pdev)
 		return PTR_ERR(pwrseq->reset_gpio);
 
 	pwrseq->pwrseq.dev = dev;
-	pwrseq->pwrseq.ops = &mmc_pwrseq_sd8787_ops;
+	pwrseq->pwrseq.ops = match->data;
 	pwrseq->pwrseq.owner = THIS_MODULE;
 	platform_set_drvdata(pdev, pwrseq);
 
diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 72f65f32abbc..7dc0e91dabfc 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -1715,6 +1715,9 @@ static void construct_request_response(struct vub300_mmc_host *vub300,
 	int bytes = 3 & less_cmd;
 	int words = less_cmd >> 2;
 	u8 *r = vub300->resp.response.command_response;
+
+	if (!resp_len)
+		return;
 	if (bytes == 3) {
 		cmd->resp[words] = (r[1 + (words << 2)] << 24)
 			| (r[2 + (words << 2)] << 16)
diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 01f1c6792df9..8dc4f5c493fc 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -590,8 +590,8 @@ static void adjust_oob_length(struct mtd_info *mtd, uint64_t start,
 			    (end_page - start_page + 1) * oob_per_page);
 }
 
-static int mtdchar_write_ioctl(struct mtd_info *mtd,
-		struct mtd_write_req __user *argp)
+static noinline_for_stack int
+mtdchar_write_ioctl(struct mtd_info *mtd, struct mtd_write_req __user *argp)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
 	struct mtd_write_req req;
@@ -688,8 +688,8 @@ static int mtdchar_write_ioctl(struct mtd_info *mtd,
 	return ret;
 }
 
-static int mtdchar_read_ioctl(struct mtd_info *mtd,
-		struct mtd_read_req __user *argp)
+static noinline_for_stack int
+mtdchar_read_ioctl(struct mtd_info *mtd, struct mtd_read_req __user *argp)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
 	struct mtd_read_req req;
diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h
index 2cda439b5e11..017868f59f22 100644
--- a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h
@@ -36,25 +36,25 @@ int ingenic_ecc_correct(struct ingenic_ecc *ecc,
 void ingenic_ecc_release(struct ingenic_ecc *ecc);
 struct ingenic_ecc *of_ingenic_ecc_get(struct device_node *np);
 #else /* CONFIG_MTD_NAND_INGENIC_ECC */
-int ingenic_ecc_calculate(struct ingenic_ecc *ecc,
+static inline int ingenic_ecc_calculate(struct ingenic_ecc *ecc,
 			  struct ingenic_ecc_params *params,
 			  const u8 *buf, u8 *ecc_code)
 {
 	return -ENODEV;
 }
 
-int ingenic_ecc_correct(struct ingenic_ecc *ecc,
+static inline int ingenic_ecc_correct(struct ingenic_ecc *ecc,
 			struct ingenic_ecc_params *params, u8 *buf,
 			u8 *ecc_code)
 {
 	return -ENODEV;
 }
 
-void ingenic_ecc_release(struct ingenic_ecc *ecc)
+static inline void ingenic_ecc_release(struct ingenic_ecc *ecc)
 {
 }
 
-struct ingenic_ecc *of_ingenic_ecc_get(struct device_node *np)
+static inline struct ingenic_ecc *of_ingenic_ecc_get(struct device_node *np)
 {
 	return ERR_PTR(-ENODEV);
 }
diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index b9d1e96e3334..a57a1501449a 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2449,6 +2449,12 @@ static int marvell_nfc_setup_interface(struct nand_chip *chip, int chipnr,
 			NDTR1_WAIT_MODE;
 	}
 
+	/*
+	 * Reset nfc->selected_chip so the next command will cause the timing
+	 * registers to be updated in marvell_nfc_select_target().
+	 */
+	nfc->selected_chip = NULL;
+
 	return 0;
 }
 
@@ -2885,10 +2891,6 @@ static int marvell_nfc_init(struct marvell_nfc *nfc)
 		regmap_update_bits(sysctrl_base, GENCONF_CLK_GATING_CTRL,
 				   GENCONF_CLK_GATING_CTRL_ND_GATE,
 				   GENCONF_CLK_GATING_CTRL_ND_GATE);
-
-		regmap_update_bits(sysctrl_base, GENCONF_ND_CLK_CTRL,
-				   GENCONF_ND_CLK_CTRL_EN,
-				   GENCONF_ND_CLK_CTRL_EN);
 	}
 
 	/* Configure the DMA if appropriate */
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index a8ff6ee6d58e..4db1652015d1 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -7067,7 +7067,7 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 		goto out;
 	}
 	if (chip->reset)
-		usleep_range(1000, 2000);
+		usleep_range(10000, 20000);
 
 	/* Detect if the device is configured in single chip addressing mode,
 	 * otherwise continue with address specific smi init/detection.
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
index 43fdd111235a..ca7372369b3e 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -1312,7 +1312,7 @@ static enum xgbe_mode xgbe_phy_status_aneg(struct xgbe_prv_data *pdata)
 	return pdata->phy_if.phy_impl.an_outcome(pdata);
 }
 
-static void xgbe_phy_status_result(struct xgbe_prv_data *pdata)
+static bool xgbe_phy_status_result(struct xgbe_prv_data *pdata)
 {
 	struct ethtool_link_ksettings *lks = &pdata->phy.lks;
 	enum xgbe_mode mode;
@@ -1347,8 +1347,13 @@ static void xgbe_phy_status_result(struct xgbe_prv_data *pdata)
 
 	pdata->phy.duplex = DUPLEX_FULL;
 
-	if (xgbe_set_mode(pdata, mode) && pdata->an_again)
+	if (!xgbe_set_mode(pdata, mode))
+		return false;
+
+	if (pdata->an_again)
 		xgbe_phy_reconfig_aneg(pdata);
+
+	return true;
 }
 
 static void xgbe_phy_status(struct xgbe_prv_data *pdata)
@@ -1378,7 +1383,8 @@ static void xgbe_phy_status(struct xgbe_prv_data *pdata)
 			return;
 		}
 
-		xgbe_phy_status_result(pdata);
+		if (xgbe_phy_status_result(pdata))
+			return;
 
 		if (test_bit(XGBE_LINK_INIT, &pdata->dev_state))
 			clear_bit(XGBE_LINK_INIT, &pdata->dev_state);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
index d7b2ee5de115..c4e40834e3ff 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
@@ -483,7 +483,7 @@ static void poll_trace(struct mlx5_fw_tracer *tracer,
 				(u64)timestamp_low;
 		break;
 	default:
-		if (tracer_event->event_id >= tracer->str_db.first_string_trace ||
+		if (tracer_event->event_id >= tracer->str_db.first_string_trace &&
 		    tracer_event->event_id <= tracer->str_db.first_string_trace +
 					      tracer->str_db.num_string_trace) {
 			tracer_event->type = TRACER_EVENT_TYPE_STRING;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
index 68f19324db93..03a99918a894 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
@@ -139,10 +139,8 @@ int mlx5e_refresh_tirs(struct mlx5e_priv *priv, bool enable_uc_lb,
 
 	inlen = MLX5_ST_SZ_BYTES(modify_tir_in);
 	in = kvzalloc(inlen, GFP_KERNEL);
-	if (!in) {
-		err = -ENOMEM;
-		goto out;
-	}
+	if (!in)
+		return -ENOMEM;
 
 	if (enable_uc_lb)
 		lb_flags = MLX5_TIRC_SELF_LB_BLOCK_BLOCK_UNICAST;
@@ -160,14 +158,13 @@ int mlx5e_refresh_tirs(struct mlx5e_priv *priv, bool enable_uc_lb,
 		tirn = tir->tirn;
 		err = mlx5_core_modify_tir(mdev, tirn, in);
 		if (err)
-			goto out;
+			break;
 	}
+	mutex_unlock(&mdev->mlx5e_res.hw_objs.td.list_lock);
 
-out:
 	kvfree(in);
 	if (err)
 		netdev_err(priv->netdev, "refresh tir(0x%x) failed, %d\n", tirn, err);
-	mutex_unlock(&mdev->mlx5e_res.hw_objs.td.list_lock);
 
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 94d010e2d5ef..4e7daa382bc0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5745,8 +5745,8 @@ void mlx5e_detach_netdev(struct mlx5e_priv *priv)
 }
 
 static int
-mlx5e_netdev_attach_profile(struct net_device *netdev, struct mlx5_core_dev *mdev,
-			    const struct mlx5e_profile *new_profile, void *new_ppriv)
+mlx5e_netdev_init_profile(struct net_device *netdev, struct mlx5_core_dev *mdev,
+			  const struct mlx5e_profile *new_profile, void *new_ppriv)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	int err;
@@ -5762,6 +5762,25 @@ mlx5e_netdev_attach_profile(struct net_device *netdev, struct mlx5_core_dev *mde
 	err = new_profile->init(priv->mdev, priv->netdev);
 	if (err)
 		goto priv_cleanup;
+
+	return 0;
+
+priv_cleanup:
+	mlx5e_priv_cleanup(priv);
+	return err;
+}
+
+static int
+mlx5e_netdev_attach_profile(struct net_device *netdev, struct mlx5_core_dev *mdev,
+			    const struct mlx5e_profile *new_profile, void *new_ppriv)
+{
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+	int err;
+
+	err = mlx5e_netdev_init_profile(netdev, mdev, new_profile, new_ppriv);
+	if (err)
+		return err;
+
 	err = mlx5e_attach_netdev(priv);
 	if (err)
 		goto profile_cleanup;
@@ -5769,7 +5788,6 @@ mlx5e_netdev_attach_profile(struct net_device *netdev, struct mlx5_core_dev *mde
 
 profile_cleanup:
 	new_profile->cleanup(priv);
-priv_cleanup:
 	mlx5e_priv_cleanup(priv);
 	return err;
 }
@@ -5788,6 +5806,12 @@ int mlx5e_netdev_change_profile(struct mlx5e_priv *priv,
 	priv->profile->cleanup(priv);
 	mlx5e_priv_cleanup(priv);
 
+	if (mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR) {
+		mlx5e_netdev_init_profile(netdev, mdev, new_profile, new_ppriv);
+		set_bit(MLX5E_STATE_DESTROYING, &priv->state);
+		return -EIO;
+	}
+
 	err = mlx5e_netdev_attach_profile(netdev, mdev, new_profile, new_ppriv);
 	if (err) { /* roll back to original profile */
 		netdev_warn(netdev, "%s: new profile init failed, %d\n", __func__, err);
@@ -5847,8 +5871,11 @@ static int mlx5e_suspend(struct auxiliary_device *adev, pm_message_t state)
 	struct net_device *netdev = priv->netdev;
 	struct mlx5_core_dev *mdev = priv->mdev;
 
-	if (!netif_device_present(netdev))
+	if (!netif_device_present(netdev)) {
+		if (test_bit(MLX5E_STATE_DESTROYING, &priv->state))
+			mlx5e_destroy_mdev_resources(mdev);
 		return -ENODEV;
+	}
 
 	mlx5e_detach_netdev(priv);
 	mlx5e_destroy_mdev_resources(mdev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 91724c5450a0..077204929fe4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -896,7 +896,6 @@ static int mlx5_pci_init(struct mlx5_core_dev *dev, struct pci_dev *pdev,
 	}
 
 	mlx5_pci_vsc_init(dev);
-	dev->caps.embedded_cpu = mlx5_read_embedded_cpu(dev);
 	return 0;
 
 err_clr_master:
@@ -1130,6 +1129,7 @@ static int mlx5_function_setup(struct mlx5_core_dev *dev, bool boot, u64 timeout
 		goto err_cmd_cleanup;
 	}
 
+	dev->caps.embedded_cpu = mlx5_read_embedded_cpu(dev);
 	mlx5_cmd_set_state(dev, MLX5_CMDIF_STATE_UP);
 
 	mlx5_start_health_poll(dev);
@@ -1753,14 +1753,15 @@ static void remove_one(struct pci_dev *pdev)
 	struct devlink *devlink = priv_to_devlink(dev);
 
 	set_bit(MLX5_BREAK_FW_WAIT, &dev->intf_state);
-	/* mlx5_drain_fw_reset() is using devlink APIs. Hence, we must drain
-	 * fw_reset before unregistering the devlink.
+	/* mlx5_drain_fw_reset() and mlx5_drain_health_wq() are using
+	 * devlink notify APIs.
+	 * Hence, we must drain them before unregistering the devlink.
 	 */
 	mlx5_drain_fw_reset(dev);
+	mlx5_drain_health_wq(dev);
 	devlink_unregister(devlink);
 	mlx5_sriov_disable(pdev);
 	mlx5_crdump_disable(dev);
-	mlx5_drain_health_wq(dev);
 	mlx5_uninit_one(dev);
 	mlx5_pci_close(dev);
 	mlx5_mdev_uninit(dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
index a7377619ba6f..2424cdf9cca9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
@@ -63,6 +63,7 @@ static void mlx5_sf_dev_remove(struct auxiliary_device *adev)
 	struct mlx5_sf_dev *sf_dev = container_of(adev, struct mlx5_sf_dev, adev);
 	struct devlink *devlink = priv_to_devlink(sf_dev->mdev);
 
+	mlx5_drain_health_wq(sf_dev->mdev);
 	devlink_unregister(devlink);
 	mlx5_uninit_one(sf_dev->mdev);
 	iounmap(sf_dev->mdev->iseg);
diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
index afa3b92a6905..0d5a41a2ae01 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
@@ -245,12 +245,6 @@ static bool mlxbf_gige_rx_packet(struct mlxbf_gige *priv, int *rx_pkts)
 
 		skb = priv->rx_skb[rx_pi_rem];
 
-		skb_put(skb, datalen);
-
-		skb->ip_summed = CHECKSUM_NONE; /* device did not checksum packet */
-
-		skb->protocol = eth_type_trans(skb, netdev);
-
 		/* Alloc another RX SKB for this same index */
 		rx_skb = mlxbf_gige_alloc_skb(priv, MLXBF_GIGE_DEFAULT_BUF_SZ,
 					      &rx_buf_dma, DMA_FROM_DEVICE);
@@ -259,6 +253,13 @@ static bool mlxbf_gige_rx_packet(struct mlxbf_gige *priv, int *rx_pkts)
 		priv->rx_skb[rx_pi_rem] = rx_skb;
 		dma_unmap_single(priv->dev, *rx_wqe_addr,
 				 MLXBF_GIGE_DEFAULT_BUF_SZ, DMA_FROM_DEVICE);
+
+		skb_put(skb, datalen);
+
+		skb->ip_summed = CHECKSUM_NONE; /* device did not checksum packet */
+
+		skb->protocol = eth_type_trans(skb, netdev);
+
 		*rx_wqe_addr = rx_buf_dma;
 	} else if (rx_cqe & MLXBF_GIGE_RX_CQE_PKT_STATUS_MAC_ERR) {
 		priv->stats.rx_mac_errors++;
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 2cc28af52ee2..45c258501135 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1324,7 +1324,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x2001, 0x7e3d, 4)},	/* D-Link DWM-222 A2 */
 	{QMI_FIXED_INTF(0x2020, 0x2031, 4)},	/* Olicard 600 */
 	{QMI_FIXED_INTF(0x2020, 0x2033, 4)},	/* BroadMobi BM806U */
-	{QMI_FIXED_INTF(0x2020, 0x2060, 4)},	/* BroadMobi BM818 */
+	{QMI_QUIRK_SET_DTR(0x2020, 0x2060, 4)},	/* BroadMobi BM818 */
 	{QMI_FIXED_INTF(0x0f3d, 0x68a2, 8)},    /* Sierra Wireless MC7700 */
 	{QMI_FIXED_INTF(0x114f, 0x68a2, 8)},    /* Sierra Wireless MC7750 */
 	{QMI_FIXED_INTF(0x1199, 0x68a2, 8)},	/* Sierra Wireless MC7710 in QMI mode */
diff --git a/drivers/net/wireless/broadcom/b43/b43.h b/drivers/net/wireless/broadcom/b43/b43.h
index 9fc7c088a539..67b4bac048e5 100644
--- a/drivers/net/wireless/broadcom/b43/b43.h
+++ b/drivers/net/wireless/broadcom/b43/b43.h
@@ -651,7 +651,7 @@ struct b43_iv {
 	union {
 		__be16 d16;
 		__be32 d32;
-	} data __packed;
+	} __packed data;
 } __packed;
 
 
diff --git a/drivers/net/wireless/broadcom/b43legacy/b43legacy.h b/drivers/net/wireless/broadcom/b43legacy/b43legacy.h
index 6b0cec467938..f49365d14619 100644
--- a/drivers/net/wireless/broadcom/b43legacy/b43legacy.h
+++ b/drivers/net/wireless/broadcom/b43legacy/b43legacy.h
@@ -379,7 +379,7 @@ struct b43legacy_iv {
 	union {
 		__be16 d16;
 		__be32 d32;
-	} data __packed;
+	} __packed data;
 } __packed;
 
 #define B43legacy_PHYMODE(phytype)	(1 << (phytype))
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 0b50b816684a..2be6801d48ac 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -2692,6 +2692,8 @@ static void rs_drv_get_rate(void *mvm_r, struct ieee80211_sta *sta,
 		return;
 
 	lq_sta = mvm_sta;
+
+	spin_lock(&lq_sta->pers.lock);
 	iwl_mvm_hwrate_to_tx_rate_v1(lq_sta->last_rate_n_flags,
 				     info->band, &info->control.rates[0]);
 	info->control.rates[0].count = 1;
@@ -2706,6 +2708,7 @@ static void rs_drv_get_rate(void *mvm_r, struct ieee80211_sta *sta,
 		iwl_mvm_hwrate_to_tx_rate_v1(last_ucode_rate, info->band,
 					     &txrc->reported_rate);
 	}
+	spin_unlock(&lq_sta->pers.lock);
 }
 
 static void *rs_drv_alloc_sta(void *mvm_rate, struct ieee80211_sta *sta,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 1ba66b8f70c9..cda3b802e89d 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1346,6 +1346,7 @@ struct rtl8xxxu_priv {
 	u32 rege9c;
 	u32 regeb4;
 	u32 regebc;
+	u32 regrcr;
 	int next_mbox;
 	int nr_out_eps;
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 95c0150f2356..3a9fa3ff37ac 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4049,6 +4049,7 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 		RCR_ACCEPT_MGMT_FRAME | RCR_HTC_LOC_CTRL |
 		RCR_APPEND_PHYSTAT | RCR_APPEND_ICV | RCR_APPEND_MIC;
 	rtl8xxxu_write32(priv, REG_RCR, val32);
+	priv->regrcr = val32;
 
 	/*
 	 * Accept all multicast
@@ -6058,7 +6059,7 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
 				      unsigned int *total_flags, u64 multicast)
 {
 	struct rtl8xxxu_priv *priv = hw->priv;
-	u32 rcr = rtl8xxxu_read32(priv, REG_RCR);
+	u32 rcr = priv->regrcr;
 
 	dev_dbg(&priv->udev->dev, "%s: changed_flags %08x, total_flags %08x\n",
 		__func__, changed_flags, *total_flags);
@@ -6104,6 +6105,7 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
 	 */
 
 	rtl8xxxu_write32(priv, REG_RCR, rcr);
+	priv->regrcr = rcr;
 
 	*total_flags &= (FIF_ALLMULTI | FIF_FCSFAIL | FIF_BCN_PRBRESP_PROMISC |
 			 FIF_CONTROL | FIF_OTHER_BSS | FIF_PSPOLL |
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index 226fc1703e90..91256e005b84 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -45,6 +45,7 @@
 #define T7XX_PCI_IREG_BASE		0
 #define T7XX_PCI_EREG_BASE		2
 
+#define T7XX_INIT_TIMEOUT		20
 #define PM_SLEEP_DIS_TIMEOUT_MS		20
 #define PM_ACK_TIMEOUT_MS		1500
 #define PM_AUTOSUSPEND_MS		20000
@@ -96,6 +97,7 @@ static int t7xx_pci_pm_init(struct t7xx_pci_dev *t7xx_dev)
 	spin_lock_init(&t7xx_dev->md_pm_lock);
 	init_completion(&t7xx_dev->sleep_lock_acquire);
 	init_completion(&t7xx_dev->pm_sr_ack);
+	init_completion(&t7xx_dev->init_done);
 	atomic_set(&t7xx_dev->md_pm_state, MTK_PM_INIT);
 
 	device_init_wakeup(&pdev->dev, true);
@@ -124,6 +126,7 @@ void t7xx_pci_pm_init_late(struct t7xx_pci_dev *t7xx_dev)
 	pm_runtime_mark_last_busy(&t7xx_dev->pdev->dev);
 	pm_runtime_allow(&t7xx_dev->pdev->dev);
 	pm_runtime_put_noidle(&t7xx_dev->pdev->dev);
+	complete_all(&t7xx_dev->init_done);
 }
 
 static int t7xx_pci_pm_reinit(struct t7xx_pci_dev *t7xx_dev)
@@ -529,6 +532,20 @@ static void t7xx_pci_shutdown(struct pci_dev *pdev)
 	__t7xx_pci_pm_suspend(pdev);
 }
 
+static int t7xx_pci_pm_prepare(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct t7xx_pci_dev *t7xx_dev;
+
+	t7xx_dev = pci_get_drvdata(pdev);
+	if (!wait_for_completion_timeout(&t7xx_dev->init_done, T7XX_INIT_TIMEOUT * HZ)) {
+		dev_warn(dev, "Not ready for system sleep.\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static int t7xx_pci_pm_suspend(struct device *dev)
 {
 	return __t7xx_pci_pm_suspend(to_pci_dev(dev));
@@ -555,6 +572,7 @@ static int t7xx_pci_pm_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops t7xx_pci_pm_ops = {
+	.prepare = t7xx_pci_pm_prepare,
 	.suspend = t7xx_pci_pm_suspend,
 	.resume = t7xx_pci_pm_resume,
 	.resume_noirq = t7xx_pci_pm_resume_noirq,
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
index 50b37056ce5a..5dffe24ef37b 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.h
+++ b/drivers/net/wwan/t7xx/t7xx_pci.h
@@ -69,6 +69,7 @@ struct t7xx_pci_dev {
 	struct t7xx_modem	*md;
 	struct t7xx_ccmni_ctrl	*ccmni_ctlb;
 	bool			rgu_pci_irq_en;
+	struct completion	init_done;
 
 	/* Low Power Items */
 	struct list_head	md_pm_entities;
diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index e958d5015585..5766ceba2fec 100644
--- a/drivers/nvme/host/constants.c
+++ b/drivers/nvme/host/constants.c
@@ -21,7 +21,7 @@ static const char * const nvme_ops[] = {
 	[nvme_cmd_resv_release] = "Reservation Release",
 	[nvme_cmd_zone_mgmt_send] = "Zone Management Send",
 	[nvme_cmd_zone_mgmt_recv] = "Zone Management Receive",
-	[nvme_cmd_zone_append] = "Zone Management Append",
+	[nvme_cmd_zone_append] = "Zone Append",
 };
 
 static const char * const nvme_admin_ops[] = {
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f502e032e7e4..2e22c78991cc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3540,6 +3540,9 @@ static ssize_t nvme_sysfs_delete(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
+	if (!test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags))
+		return -EBUSY;
+
 	if (device_remove_file_self(dev, attr))
 		nvme_delete_ctrl_sync(ctrl);
 	return count;
@@ -4980,7 +4983,7 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 	 * that were missed. We identify persistent discovery controllers by
 	 * checking that they started once before, hence are reconnecting back.
 	 */
-	if (test_and_set_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags) &&
+	if (test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags) &&
 	    nvme_discovery_ctrl(ctrl))
 		nvme_change_uevent(ctrl, "NVME_EVENT=rediscover");
 
@@ -4991,6 +4994,7 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 	}
 
 	nvme_change_uevent(ctrl, "NVME_EVENT=connected");
+	set_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags);
 }
 EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 
diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 9e6e56c20ec9..316f3e4ca7cc 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -163,7 +163,9 @@ static umode_t nvme_hwmon_is_visible(const void *_data,
 	case hwmon_temp_max:
 	case hwmon_temp_min:
 		if ((!channel && data->ctrl->wctemp) ||
-		    (channel && data->log->temp_sensor[channel - 1])) {
+		    (channel && data->log->temp_sensor[channel - 1] &&
+		     !(data->ctrl->quirks &
+		       NVME_QUIRK_NO_SECONDARY_TEMP_THRESH))) {
 			if (data->ctrl->quirks &
 			    NVME_QUIRK_NO_TEMP_THRESH_CHANGE)
 				return 0444;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d09ed0070174..f96d330d3964 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -858,7 +858,6 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 	if (!head->disk)
 		return;
-	blk_mark_disk_dead(head->disk);
 	/* make sure all pending bios are cleaned up */
 	kblockd_schedule_work(&head->requeue_work);
 	flush_work(&head->requeue_work);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 01d90424af53..3f82de6060ef 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -149,6 +149,11 @@ enum nvme_quirks {
 	 * Reports garbage in the namespace identifiers (eui64, nguid, uuid).
 	 */
 	NVME_QUIRK_BOGUS_NID			= (1 << 18),
+
+	/*
+	 * No temperature thresholds for channels other than 0 (Composite).
+	 */
+	NVME_QUIRK_NO_SECONDARY_TEMP_THRESH	= (1 << 19),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 581bf94416e6..ba4903c86f7f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3515,6 +3515,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
+	{ PCI_DEVICE(0x2646, 0x5013),   /* Kingston KC3000, Kingston FURY Renegade */
+		.driver_data = NVME_QUIRK_NO_SECONDARY_TEMP_THRESH, },
 	{ PCI_DEVICE(0x2646, 0x5018),   /* KINGSTON OM8SFP4xxxxP OS21012 NVMe SSD */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x2646, 0x5016),   /* KINGSTON OM3PGP4xxxxP OS21011 NVMe SSD */
@@ -3554,6 +3556,10 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x10ec, 0x5763), /* TEAMGROUP T-FORCE CARDEA ZERO Z330 SSD */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1e4b, 0x1602), /* HS-SSD-FUTURE 2048G  */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x10ec, 0x5765), /* TEAMGROUP MP33 2TB SSD */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
diff --git a/drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c b/drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c
index c14089fa7db4..cabdddbbabfd 100644
--- a/drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c
+++ b/drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c
@@ -70,7 +70,7 @@ static int phy_g12a_mipi_dphy_analog_power_on(struct phy *phy)
 		     HHI_MIPI_CNTL1_BANDGAP);
 
 	regmap_write(priv->regmap, HHI_MIPI_CNTL2,
-		     FIELD_PREP(HHI_MIPI_CNTL2_DIF_TX_CTL0, 0x459) |
+		     FIELD_PREP(HHI_MIPI_CNTL2_DIF_TX_CTL0, 0x45a) |
 		     FIELD_PREP(HHI_MIPI_CNTL2_DIF_TX_CTL1, 0x2680));
 
 	reg = DSI_LANE_CLK;
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 816829105135..8c527c4927fd 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -1993,7 +1993,7 @@ static int qmp_combo_com_init(struct qmp_phy *qphy)
 	ret = regulator_bulk_enable(cfg->num_vregs, qmp->vregs);
 	if (ret) {
 		dev_err(qmp->dev, "failed to enable regulators, err=%d\n", ret);
-		goto err_unlock;
+		goto err_decrement_count;
 	}
 
 	ret = reset_control_bulk_assert(cfg->num_resets, qmp->resets);
@@ -2048,7 +2048,8 @@ static int qmp_combo_com_init(struct qmp_phy *qphy)
 	reset_control_bulk_assert(cfg->num_resets, qmp->resets);
 err_disable_regulators:
 	regulator_bulk_disable(cfg->num_vregs, qmp->vregs);
-err_unlock:
+err_decrement_count:
+	qmp->init_count--;
 	mutex_unlock(&qmp->phy_mutex);
 
 	return ret;
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
index 461f0b5d464a..31c223a54394 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
@@ -425,7 +425,7 @@ static int qmp_pcie_msm8996_com_init(struct qmp_phy *qphy)
 	ret = regulator_bulk_enable(cfg->num_vregs, qmp->vregs);
 	if (ret) {
 		dev_err(qmp->dev, "failed to enable regulators, err=%d\n", ret);
-		goto err_unlock;
+		goto err_decrement_count;
 	}
 
 	ret = reset_control_bulk_assert(cfg->num_resets, qmp->resets);
@@ -455,7 +455,8 @@ static int qmp_pcie_msm8996_com_init(struct qmp_phy *qphy)
 	reset_control_bulk_assert(cfg->num_resets, qmp->resets);
 err_disable_regulators:
 	regulator_bulk_disable(cfg->num_vregs, qmp->vregs);
-err_unlock:
+err_decrement_count:
+	qmp->init_count--;
 	mutex_unlock(&qmp->phy_mutex);
 
 	return ret;
diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 1ae3c56b66b0..b2e19f30a928 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -765,7 +765,7 @@ static void mlxbf_tmfifo_rxtx(struct mlxbf_tmfifo_vring *vring, bool is_rx)
 	fifo = vring->fifo;
 
 	/* Return if vdev is not ready. */
-	if (!fifo->vdev[devid])
+	if (!fifo || !fifo->vdev[devid])
 		return;
 
 	/* Return if another vring is running. */
@@ -961,9 +961,13 @@ static int mlxbf_tmfifo_virtio_find_vqs(struct virtio_device *vdev,
 
 		vq->num_max = vring->num;
 
+		vq->priv = vring;
+
+		/* Make vq update visible before using it. */
+		virtio_mb(false);
+
 		vqs[i] = vq;
 		vring->vq = vq;
-		vq->priv = vring;
 	}
 
 	return 0;
@@ -1260,6 +1264,9 @@ static int mlxbf_tmfifo_probe(struct platform_device *pdev)
 
 	mod_timer(&fifo->timer, jiffies + MLXBF_TMFIFO_TIMER_INTERVAL);
 
+	/* Make all updates visible before setting the 'is_ready' flag. */
+	virtio_mb(false);
+
 	fifo->is_ready = true;
 	return 0;
 
diff --git a/drivers/platform/x86/intel_scu_pcidrv.c b/drivers/platform/x86/intel_scu_pcidrv.c
index 80abc708e4f2..d904fad499aa 100644
--- a/drivers/platform/x86/intel_scu_pcidrv.c
+++ b/drivers/platform/x86/intel_scu_pcidrv.c
@@ -34,6 +34,7 @@ static int intel_scu_pci_probe(struct pci_dev *pdev,
 
 static const struct pci_device_id pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x080e) },
+	{ PCI_VDEVICE(INTEL, 0x082a) },
 	{ PCI_VDEVICE(INTEL, 0x08ea) },
 	{ PCI_VDEVICE(INTEL, 0x0a94) },
 	{ PCI_VDEVICE(INTEL, 0x11a0) },
diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 5a05d1cdfec2..a8def50c149b 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -1293,6 +1293,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 			return PTR_ERR(kkey);
 		rc = pkey_keyblob2pkey(kkey, ktp.keylen, &ktp.protkey);
 		DEBUG_DBG("%s pkey_keyblob2pkey()=%d\n", __func__, rc);
+		memzero_explicit(kkey, ktp.keylen);
 		kfree(kkey);
 		if (rc)
 			break;
@@ -1426,6 +1427,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 					kkey, ktp.keylen, &ktp.protkey);
 		DEBUG_DBG("%s pkey_keyblob2pkey2()=%d\n", __func__, rc);
 		kfree(apqns);
+		memzero_explicit(kkey, ktp.keylen);
 		kfree(kkey);
 		if (rc)
 			break;
@@ -1552,6 +1554,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 					protkey, &protkeylen);
 		DEBUG_DBG("%s pkey_keyblob2pkey3()=%d\n", __func__, rc);
 		kfree(apqns);
+		memzero_explicit(kkey, ktp.keylen);
 		kfree(kkey);
 		if (rc) {
 			kfree(protkey);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 8b89fab7c420..fb6e9a7a7f58 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1491,6 +1491,7 @@ static int scsi_dispatch_cmd(struct scsi_cmnd *cmd)
 		 */
 		SCSI_LOG_MLQUEUE(3, scmd_printk(KERN_INFO, cmd,
 			"queuecommand : device blocked\n"));
+		atomic_dec(&cmd->device->iorequest_cnt);
 		return SCSI_MLQUEUE_DEVICE_BUSY;
 	}
 
@@ -1523,6 +1524,7 @@ static int scsi_dispatch_cmd(struct scsi_cmnd *cmd)
 	trace_scsi_dispatch_cmd_start(cmd);
 	rtn = host->hostt->queuecommand(host, cmd);
 	if (rtn) {
+		atomic_dec(&cmd->device->iorequest_cnt);
 		trace_scsi_dispatch_cmd_error(cmd, rtn);
 		if (rtn != SCSI_MLQUEUE_DEVICE_BUSY &&
 		    rtn != SCSI_MLQUEUE_TARGET_BUSY)
diff --git a/drivers/scsi/stex.c b/drivers/scsi/stex.c
index 8def242675ef..6b07f367918e 100644
--- a/drivers/scsi/stex.c
+++ b/drivers/scsi/stex.c
@@ -109,7 +109,9 @@ enum {
 	TASK_ATTRIBUTE_HEADOFQUEUE		= 0x1,
 	TASK_ATTRIBUTE_ORDERED			= 0x2,
 	TASK_ATTRIBUTE_ACA			= 0x4,
+};
 
+enum {
 	SS_STS_NORMAL				= 0x80000000,
 	SS_STS_DONE				= 0x40000000,
 	SS_STS_HANDSHAKE			= 0x20000000,
@@ -121,7 +123,9 @@ enum {
 	SS_I2H_REQUEST_RESET			= 0x2000,
 
 	SS_MU_OPERATIONAL			= 0x80000000,
+};
 
+enum {
 	STEX_CDB_LENGTH				= 16,
 	STATUS_VAR_LEN				= 128,
 
diff --git a/drivers/tty/serial/8250/8250_tegra.c b/drivers/tty/serial/8250/8250_tegra.c
index e7cddeec9d8e..c424e2ae0e8f 100644
--- a/drivers/tty/serial/8250/8250_tegra.c
+++ b/drivers/tty/serial/8250/8250_tegra.c
@@ -112,13 +112,15 @@ static int tegra_uart_probe(struct platform_device *pdev)
 
 	ret = serial8250_register_8250_port(&port8250);
 	if (ret < 0)
-		goto err_clkdisable;
+		goto err_ctrl_assert;
 
 	platform_set_drvdata(pdev, uart);
 	uart->line = ret;
 
 	return 0;
 
+err_ctrl_assert:
+	reset_control_assert(uart->rst);
 err_clkdisable:
 	clk_disable_unprepare(uart->clk);
 
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 4fce15296f31..12f685168aef 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -769,7 +769,7 @@ config SERIAL_PMACZILOG_CONSOLE
 
 config SERIAL_CPM
 	tristate "CPM SCC/SMC serial port support"
-	depends on CPM2 || CPM1 || (PPC32 && COMPILE_TEST)
+	depends on CPM2 || CPM1
 	select SERIAL_CORE
 	help
 	  This driver supports the SCC and SMC serial ports on Motorola 
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart.h b/drivers/tty/serial/cpm_uart/cpm_uart.h
index 0577618e78c0..46c03ed71c31 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart.h
+++ b/drivers/tty/serial/cpm_uart/cpm_uart.h
@@ -19,8 +19,6 @@ struct gpio_desc;
 #include "cpm_uart_cpm2.h"
 #elif defined(CONFIG_CPM1)
 #include "cpm_uart_cpm1.h"
-#elif defined(CONFIG_COMPILE_TEST)
-#include "cpm_uart_cpm2.h"
 #endif
 
 #define SERIAL_CPM_MAJOR	204
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 81467e93c7d5..dc7ac1ddbca5 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1475,34 +1475,36 @@ static void lpuart_break_ctl(struct uart_port *port, int break_state)
 
 static void lpuart32_break_ctl(struct uart_port *port, int break_state)
 {
-	unsigned long temp, modem;
-	struct tty_struct *tty;
-	unsigned int cflag = 0;
-
-	tty = tty_port_tty_get(&port->state->port);
-	if (tty) {
-		cflag = tty->termios.c_cflag;
-		tty_kref_put(tty);
-	}
+	unsigned long temp;
 
-	temp = lpuart32_read(port, UARTCTRL) & ~UARTCTRL_SBK;
-	modem = lpuart32_read(port, UARTMODIR);
+	temp = lpuart32_read(port, UARTCTRL);
 
+	/*
+	 * LPUART IP now has two known bugs, one is CTS has higher priority than the
+	 * break signal, which causes the break signal sending through UARTCTRL_SBK
+	 * may impacted by the CTS input if the HW flow control is enabled. It
+	 * exists on all platforms we support in this driver.
+	 * Another bug is i.MX8QM LPUART may have an additional break character
+	 * being sent after SBK was cleared.
+	 * To avoid above two bugs, we use Transmit Data Inversion function to send
+	 * the break signal instead of UARTCTRL_SBK.
+	 */
 	if (break_state != 0) {
-		temp |= UARTCTRL_SBK;
 		/*
-		 * LPUART CTS has higher priority than SBK, need to disable CTS before
-		 * asserting SBK to avoid any interference if flow control is enabled.
+		 * Disable the transmitter to prevent any data from being sent out
+		 * during break, then invert the TX line to send break.
 		 */
-		if (cflag & CRTSCTS && modem & UARTMODIR_TXCTSE)
-			lpuart32_write(port, modem & ~UARTMODIR_TXCTSE, UARTMODIR);
+		temp &= ~UARTCTRL_TE;
+		lpuart32_write(port, temp, UARTCTRL);
+		temp |= UARTCTRL_TXINV;
+		lpuart32_write(port, temp, UARTCTRL);
 	} else {
-		/* Re-enable the CTS when break off. */
-		if (cflag & CRTSCTS && !(modem & UARTMODIR_TXCTSE))
-			lpuart32_write(port, modem | UARTMODIR_TXCTSE, UARTMODIR);
+		/* Disable the TXINV to turn off break and re-enable transmitter. */
+		temp &= ~UARTCTRL_TXINV;
+		lpuart32_write(port, temp, UARTCTRL);
+		temp |= UARTCTRL_TE;
+		lpuart32_write(port, temp, UARTCTRL);
 	}
-
-	lpuart32_write(port, temp, UARTCTRL);
 }
 
 static void lpuart_setup_watermark(struct lpuart_port *sport)
diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index ccfaebca6faa..1dcadef933e3 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -2097,6 +2097,19 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 	else
 		priv_ep->trb_burst_size = 16;
 
+	/*
+	 * In versions preceding DEV_VER_V2, for example, iMX8QM, there exit the bugs
+	 * in the DMA. These bugs occur when the trb_burst_size exceeds 16 and the
+	 * address is not aligned to 128 Bytes (which is a product of the 64-bit AXI
+	 * and AXI maximum burst length of 16 or 0xF+1, dma_axi_ctrl0[3:0]). This
+	 * results in data corruption when it crosses the 4K border. The corruption
+	 * specifically occurs from the position (4K - (address & 0x7F)) to 4K.
+	 *
+	 * So force trb_burst_size to 16 at such platform.
+	 */
+	if (priv_dev->dev_ver < DEV_VER_V2)
+		priv_ep->trb_burst_size = 16;
+
 	mult = min_t(u8, mult, EP_CFG_MULT_MAX);
 	buffering = min_t(u8, buffering, EP_CFG_BUFFERING_MAX);
 	maxburst = min_t(u8, maxburst, EP_CFG_MAXBURST_MAX);
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 8ad354741380..3e59055aa504 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -3620,6 +3620,7 @@ static void ffs_func_unbind(struct usb_configuration *c,
 	/* Drain any pending AIO completions */
 	drain_workqueue(ffs->io_completion_wq);
 
+	ffs_event_add(ffs, FUNCTIONFS_UNBIND);
 	if (!--opts->refcnt)
 		functionfs_unbind(ffs);
 
@@ -3644,7 +3645,6 @@ static void ffs_func_unbind(struct usb_configuration *c,
 	func->function.ssp_descriptors = NULL;
 	func->interfaces_nums = NULL;
 
-	ffs_event_add(ffs, FUNCTIONFS_UNBIND);
 }
 
 static struct usb_function *ffs_alloc(struct usb_function_instance *fi)
diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index f98e8f298bc1..8587c9da0670 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -247,6 +247,9 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 
 	cursor.set = 0;
 
+	if (!vc->vc_font.data)
+		return;
+
  	c = scr_readw((u16 *) vc->vc_pos);
 	attribute = get_attribute(info, c);
 	src = vc->vc_font.data + ((c & charmask) * (w * vc->vc_font.height));
diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core/modedb.c
index 6473e0dfe146..e78ec7f72846 100644
--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -257,6 +257,11 @@ static const struct fb_videomode modedb[] = {
 	{ NULL, 72, 480, 300, 33386, 40, 24, 11, 19, 80, 3, 0,
 		FB_VMODE_DOUBLE },
 
+	/* 1920x1080 @ 60 Hz, 67.3 kHz hsync */
+	{ NULL, 60, 1920, 1080, 6734, 148, 88, 36, 4, 44, 5, 0,
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		FB_VMODE_NONINTERLACED },
+
 	/* 1920x1200 @ 60 Hz, 74.5 Khz hsync */
 	{ NULL, 60, 1920, 1200, 5177, 128, 336, 1, 38, 208, 3,
 		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index d7edb9c5d3a3..e6adb2890ecf 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1347,7 +1347,7 @@ static const struct fb_ops imsttfb_ops = {
 	.fb_ioctl 	= imsttfb_ioctl,
 };
 
-static void init_imstt(struct fb_info *info)
+static int init_imstt(struct fb_info *info)
 {
 	struct imstt_par *par = info->par;
 	__u32 i, tmp, *ip, *end;
@@ -1420,7 +1420,7 @@ static void init_imstt(struct fb_info *info)
 	    || !(compute_imstt_regvals(par, info->var.xres, info->var.yres))) {
 		printk("imsttfb: %ux%ux%u not supported\n", info->var.xres, info->var.yres, info->var.bits_per_pixel);
 		framebuffer_release(info);
-		return;
+		return -ENODEV;
 	}
 
 	sprintf(info->fix.id, "IMS TT (%s)", par->ramdac == IBM ? "IBM" : "TVP");
@@ -1456,12 +1456,13 @@ static void init_imstt(struct fb_info *info)
 
 	if (register_framebuffer(info) < 0) {
 		framebuffer_release(info);
-		return;
+		return -ENODEV;
 	}
 
 	tmp = (read_reg_le32(par->dc_regs, SSTATUS) & 0x0f00) >> 8;
 	fb_info(info, "%s frame buffer; %uMB vram; chip version %u\n",
 		info->fix.id, info->fix.smem_len >> 20, tmp);
+	return 0;
 }
 
 static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
@@ -1529,10 +1530,10 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!par->cmap_regs)
 		goto error;
 	info->pseudo_palette = par->palette;
-	init_imstt(info);
-
-	pci_set_drvdata(pdev, info);
-	return 0;
+	ret = init_imstt(info);
+	if (!ret)
+		pci_set_drvdata(pdev, info);
+	return ret;
 
 error:
 	if (par->dc_regs)
diff --git a/drivers/video/fbdev/stifb.c b/drivers/video/fbdev/stifb.c
index ef8a4c5fc687..63f51783352d 100644
--- a/drivers/video/fbdev/stifb.c
+++ b/drivers/video/fbdev/stifb.c
@@ -1413,6 +1413,7 @@ static int __init stifb_init_fb(struct sti_struct *sti, int bpp_pref)
 	iounmap(info->screen_base);
 out_err0:
 	kfree(fb);
+	sti->info = NULL;
 	return -ENXIO;
 }
 
diff --git a/drivers/watchdog/menz69_wdt.c b/drivers/watchdog/menz69_wdt.c
index 8973f98bc6a5..bca0938f3429 100644
--- a/drivers/watchdog/menz69_wdt.c
+++ b/drivers/watchdog/menz69_wdt.c
@@ -98,14 +98,6 @@ static const struct watchdog_ops men_z069_ops = {
 	.set_timeout = men_z069_wdt_set_timeout,
 };
 
-static struct watchdog_device men_z069_wdt = {
-	.info = &men_z069_info,
-	.ops = &men_z069_ops,
-	.timeout = MEN_Z069_DEFAULT_TIMEOUT,
-	.min_timeout = 1,
-	.max_timeout = MEN_Z069_WDT_COUNTER_MAX / MEN_Z069_TIMER_FREQ,
-};
-
 static int men_z069_probe(struct mcb_device *dev,
 			  const struct mcb_device_id *id)
 {
@@ -125,15 +117,19 @@ static int men_z069_probe(struct mcb_device *dev,
 		goto release_mem;
 
 	drv->mem = mem;
+	drv->wdt.info = &men_z069_info;
+	drv->wdt.ops = &men_z069_ops;
+	drv->wdt.timeout = MEN_Z069_DEFAULT_TIMEOUT;
+	drv->wdt.min_timeout = 1;
+	drv->wdt.max_timeout = MEN_Z069_WDT_COUNTER_MAX / MEN_Z069_TIMER_FREQ;
 
-	drv->wdt = men_z069_wdt;
 	watchdog_init_timeout(&drv->wdt, 0, &dev->dev);
 	watchdog_set_nowayout(&drv->wdt, nowayout);
 	watchdog_set_drvdata(&drv->wdt, drv);
 	drv->wdt.parent = &dev->dev;
 	mcb_set_drvdata(dev, drv);
 
-	return watchdog_register_device(&men_z069_wdt);
+	return watchdog_register_device(&drv->wdt);
 
 release_mem:
 	mcb_release_mem(mem);
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index dbbae92ac23d..ab9f8d6c4f1b 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3118,6 +3118,7 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 
 	if (check_sibling_keys(left, right)) {
 		ret = -EUCLEAN;
+		btrfs_abort_transaction(trans, ret);
 		btrfs_tree_unlock(right);
 		free_extent_buffer(right);
 		return ret;
@@ -3348,6 +3349,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 
 	if (check_sibling_keys(left, right)) {
 		ret = -EUCLEAN;
+		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 	return __push_leaf_left(path, min_data_size,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 21d8a895e9ad..ca69a46f1006 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -104,7 +104,7 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
 	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
 			    first_page_part - BTRFS_CSUM_SIZE);
 
-	for (i = 1; i < num_pages; i++) {
+	for (i = 1; i < num_pages && INLINE_EXTENT_BUFFER_PAGES > 1; i++) {
 		kaddr = page_address(buf->pages[i]);
 		crypto_shash_update(shash, kaddr, PAGE_SIZE);
 	}
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 54e3c2ab21d2..1989c8deea55 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3938,7 +3938,7 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 	struct dentry *dentry;
 	struct ceph_cap *cap;
 	char *path;
-	int pathlen = 0, err = 0;
+	int pathlen = 0, err;
 	u64 pathbase;
 	u64 snap_follows;
 
@@ -3961,6 +3961,7 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 	cap = __get_cap_for_mds(ci, mds);
 	if (!cap) {
 		spin_unlock(&ci->i_ceph_lock);
+		err = 0;
 		goto out_err;
 	}
 	dout(" adding %p ino %llx.%llx cap %p %lld %s\n",
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 2156d2a1a770..0ea3960cb83e 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1007,11 +1007,13 @@ do {									       \
  *			  where the second inode has larger inode number
  *			  than the first
  *  I_DATA_SEM_QUOTA  - Used for quota inodes only
+ *  I_DATA_SEM_EA     - Used for ea_inodes only
  */
 enum {
 	I_DATA_SEM_NORMAL = 0,
 	I_DATA_SEM_OTHER,
 	I_DATA_SEM_QUOTA,
+	I_DATA_SEM_EA
 };
 
 
@@ -2968,7 +2970,8 @@ typedef enum {
 	EXT4_IGET_NORMAL =	0,
 	EXT4_IGET_SPECIAL =	0x0001, /* OK to iget a system inode */
 	EXT4_IGET_HANDLE = 	0x0002,	/* Inode # is from a handle */
-	EXT4_IGET_BAD =		0x0004  /* Allow to iget a bad inode */
+	EXT4_IGET_BAD =		0x0004, /* Allow to iget a bad inode */
+	EXT4_IGET_EA_INODE =	0x0008	/* Inode should contain an EA value */
 } ext4_iget_flags;
 
 extern struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ffc810436ef2..80d5a859ab14 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4763,6 +4763,24 @@ static inline void ext4_inode_set_iversion_queried(struct inode *inode, u64 val)
 		inode_set_iversion_queried(inode, val);
 }
 
+static const char *check_igot_inode(struct inode *inode, ext4_iget_flags flags)
+
+{
+	if (flags & EXT4_IGET_EA_INODE) {
+		if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
+			return "missing EA_INODE flag";
+		if (ext4_test_inode_state(inode, EXT4_STATE_XATTR) ||
+		    EXT4_I(inode)->i_file_acl)
+			return "ea_inode with extended attributes";
+	} else {
+		if ((EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
+			return "unexpected EA_INODE flag";
+	}
+	if (is_bad_inode(inode) && !(flags & EXT4_IGET_BAD))
+		return "unexpected bad inode w/o EXT4_IGET_BAD";
+	return NULL;
+}
+
 struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 			  ext4_iget_flags flags, const char *function,
 			  unsigned int line)
@@ -4772,6 +4790,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	struct ext4_inode_info *ei;
 	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
 	struct inode *inode;
+	const char *err_str;
 	journal_t *journal = EXT4_SB(sb)->s_journal;
 	long ret;
 	loff_t size;
@@ -4799,8 +4818,14 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode->i_state & I_NEW)) {
+		if ((err_str = check_igot_inode(inode, flags)) != NULL) {
+			ext4_error_inode(inode, function, line, 0, err_str);
+			iput(inode);
+			return ERR_PTR(-EFSCORRUPTED);
+		}
 		return inode;
+	}
 
 	ei = EXT4_I(inode);
 	iloc.bh = NULL;
@@ -5066,10 +5091,9 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	if (IS_CASEFOLDED(inode) && !ext4_has_feature_casefold(inode->i_sb))
 		ext4_error_inode(inode, function, line, 0,
 				 "casefold flag without casefold feature");
-	if (is_bad_inode(inode) && !(flags & EXT4_IGET_BAD)) {
-		ext4_error_inode(inode, function, line, 0,
-				 "bad inode without EXT4_IGET_BAD flag");
-		ret = -EUCLEAN;
+	if ((err_str = check_igot_inode(inode, flags)) != NULL) {
+		ext4_error_inode(inode, function, line, 0, err_str);
+		ret = -EFSCORRUPTED;
 		goto bad_inode;
 	}
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index bd2e803d653f..5db1060b8684 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6541,18 +6541,6 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 		}
 	}
 
-	/*
-	 * Reinitialize lazy itable initialization thread based on
-	 * current settings
-	 */
-	if (sb_rdonly(sb) || !test_opt(sb, INIT_INODE_TABLE))
-		ext4_unregister_li_request(sb);
-	else {
-		ext4_group_t first_not_zeroed;
-		first_not_zeroed = ext4_has_uninit_itable(sb);
-		ext4_register_li_request(sb, first_not_zeroed);
-	}
-
 	/*
 	 * Handle creation of system zone data early because it can fail.
 	 * Releasing of existing data is done when we are sure remount will
@@ -6590,6 +6578,18 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	if (enable_rw)
 		sb->s_flags &= ~SB_RDONLY;
 
+	/*
+	 * Reinitialize lazy itable initialization thread based on
+	 * current settings
+	 */
+	if (sb_rdonly(sb) || !test_opt(sb, INIT_INODE_TABLE))
+		ext4_unregister_li_request(sb);
+	else {
+		ext4_group_t first_not_zeroed;
+		first_not_zeroed = ext4_has_uninit_itable(sb);
+		ext4_register_li_request(sb, first_not_zeroed);
+	}
+
 	if (!ext4_has_feature_mmp(sb) || sb_rdonly(sb))
 		ext4_stop_mmpd(sbi);
 
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index b1b8fe86ccdb..fddde5045d0c 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -123,7 +123,11 @@ ext4_expand_inode_array(struct ext4_xattr_inode_array **ea_inode_array,
 #ifdef CONFIG_LOCKDEP
 void ext4_xattr_inode_set_class(struct inode *ea_inode)
 {
+	struct ext4_inode_info *ei = EXT4_I(ea_inode);
+
 	lockdep_set_subclass(&ea_inode->i_rwsem, 1);
+	(void) ei;	/* shut up clang warning if !CONFIG_LOCKDEP */
+	lockdep_set_subclass(&ei->i_data_sem, I_DATA_SEM_EA);
 }
 #endif
 
@@ -397,7 +401,7 @@ static int ext4_xattr_inode_iget(struct inode *parent, unsigned long ea_ino,
 		return -EFSCORRUPTED;
 	}
 
-	inode = ext4_iget(parent->i_sb, ea_ino, EXT4_IGET_NORMAL);
+	inode = ext4_iget(parent->i_sb, ea_ino, EXT4_IGET_EA_INODE);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		ext4_error(parent->i_sb,
@@ -405,23 +409,6 @@ static int ext4_xattr_inode_iget(struct inode *parent, unsigned long ea_ino,
 			   err);
 		return err;
 	}
-
-	if (is_bad_inode(inode)) {
-		ext4_error(parent->i_sb,
-			   "error while reading EA inode %lu is_bad_inode",
-			   ea_ino);
-		err = -EIO;
-		goto error;
-	}
-
-	if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)) {
-		ext4_error(parent->i_sb,
-			   "EA inode %lu does not have EXT4_EA_INODE_FL flag",
-			    ea_ino);
-		err = -EINVAL;
-		goto error;
-	}
-
 	ext4_xattr_inode_set_class(inode);
 
 	/*
@@ -442,9 +429,6 @@ static int ext4_xattr_inode_iget(struct inode *parent, unsigned long ea_ino,
 
 	*ea_inode = inode;
 	return 0;
-error:
-	iput(inode);
-	return err;
 }
 
 /* Remove entry from mbcache when EA inode is getting evicted */
@@ -1507,11 +1491,11 @@ ext4_xattr_inode_cache_find(struct inode *inode, const void *value,
 
 	while (ce) {
 		ea_inode = ext4_iget(inode->i_sb, ce->e_value,
-				     EXT4_IGET_NORMAL);
-		if (!IS_ERR(ea_inode) &&
-		    !is_bad_inode(ea_inode) &&
-		    (EXT4_I(ea_inode)->i_flags & EXT4_EA_INODE_FL) &&
-		    i_size_read(ea_inode) == value_len &&
+				     EXT4_IGET_EA_INODE);
+		if (IS_ERR(ea_inode))
+			goto next_entry;
+		ext4_xattr_inode_set_class(ea_inode);
+		if (i_size_read(ea_inode) == value_len &&
 		    !ext4_xattr_inode_read(ea_inode, ea_data, value_len) &&
 		    !ext4_xattr_inode_verify_hashes(ea_inode, NULL, ea_data,
 						    value_len) &&
@@ -1521,9 +1505,8 @@ ext4_xattr_inode_cache_find(struct inode *inode, const void *value,
 			kvfree(ea_data);
 			return ea_inode;
 		}
-
-		if (!IS_ERR(ea_inode))
-			iput(ea_inode);
+		iput(ea_inode);
+	next_entry:
 		ce = mb_cache_entry_find_next(ea_inode_cache, ce);
 	}
 	kvfree(ea_data);
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 2015bd05cba1..9d27aa8bd2bc 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1380,6 +1380,14 @@ static void gfs2_evict_inode(struct inode *inode)
 	if (inode->i_nlink || sb_rdonly(sb))
 		goto out;
 
+	/*
+	 * In case of an incomplete mount, gfs2_evict_inode() may be called for
+	 * system files without having an active journal to write to.  In that
+	 * case, skip the filesystem evict.
+	 */
+	if (!sdp->sd_jdesc)
+		goto out;
+
 	gfs2_holder_mark_uninitialized(&gh);
 	ret = evict_should_delete(inode, &gh);
 	if (ret == SHOULD_DEFER_EVICTION)
diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index c7466546e59b..cbfed03a1e5c 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -157,13 +157,42 @@ static struct oplock_info *opinfo_get_list(struct ksmbd_inode *ci)
 	rcu_read_lock();
 	opinfo = list_first_or_null_rcu(&ci->m_op_list, struct oplock_info,
 					op_entry);
-	if (opinfo && !atomic_inc_not_zero(&opinfo->refcount))
-		opinfo = NULL;
+	if (opinfo) {
+		if (!atomic_inc_not_zero(&opinfo->refcount))
+			opinfo = NULL;
+		else {
+			atomic_inc(&opinfo->conn->r_count);
+			if (ksmbd_conn_releasing(opinfo->conn)) {
+				atomic_dec(&opinfo->conn->r_count);
+				atomic_dec(&opinfo->refcount);
+				opinfo = NULL;
+			}
+		}
+	}
+
 	rcu_read_unlock();
 
 	return opinfo;
 }
 
+static void opinfo_conn_put(struct oplock_info *opinfo)
+{
+	struct ksmbd_conn *conn;
+
+	if (!opinfo)
+		return;
+
+	conn = opinfo->conn;
+	/*
+	 * Checking waitqueue to dropping pending requests on
+	 * disconnection. waitqueue_active is safe because it
+	 * uses atomic operation for condition.
+	 */
+	if (!atomic_dec_return(&conn->r_count) && waitqueue_active(&conn->r_count_q))
+		wake_up(&conn->r_count_q);
+	opinfo_put(opinfo);
+}
+
 void opinfo_put(struct oplock_info *opinfo)
 {
 	if (!atomic_dec_and_test(&opinfo->refcount))
@@ -666,13 +695,6 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 
 out:
 	ksmbd_free_work_struct(work);
-	/*
-	 * Checking waitqueue to dropping pending requests on
-	 * disconnection. waitqueue_active is safe because it
-	 * uses atomic operation for condition.
-	 */
-	if (!atomic_dec_return(&conn->r_count) && waitqueue_active(&conn->r_count_q))
-		wake_up(&conn->r_count_q);
 }
 
 /**
@@ -706,7 +728,6 @@ static int smb2_oplock_break_noti(struct oplock_info *opinfo)
 	work->conn = conn;
 	work->sess = opinfo->sess;
 
-	atomic_inc(&conn->r_count);
 	if (opinfo->op_state == OPLOCK_ACK_WAIT) {
 		INIT_WORK(&work->work, __smb2_oplock_break_noti);
 		ksmbd_queue_work(work);
@@ -776,13 +797,6 @@ static void __smb2_lease_break_noti(struct work_struct *wk)
 
 out:
 	ksmbd_free_work_struct(work);
-	/*
-	 * Checking waitqueue to dropping pending requests on
-	 * disconnection. waitqueue_active is safe because it
-	 * uses atomic operation for condition.
-	 */
-	if (!atomic_dec_return(&conn->r_count) && waitqueue_active(&conn->r_count_q))
-		wake_up(&conn->r_count_q);
 }
 
 /**
@@ -822,7 +836,6 @@ static int smb2_lease_break_noti(struct oplock_info *opinfo)
 	work->conn = conn;
 	work->sess = opinfo->sess;
 
-	atomic_inc(&conn->r_count);
 	if (opinfo->op_state == OPLOCK_ACK_WAIT) {
 		list_for_each_safe(tmp, t, &opinfo->interim_list) {
 			struct ksmbd_work *in_work;
@@ -1144,8 +1157,10 @@ int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
 	}
 	prev_opinfo = opinfo_get_list(ci);
 	if (!prev_opinfo ||
-	    (prev_opinfo->level == SMB2_OPLOCK_LEVEL_NONE && lctx))
+	    (prev_opinfo->level == SMB2_OPLOCK_LEVEL_NONE && lctx)) {
+		opinfo_conn_put(prev_opinfo);
 		goto set_lev;
+	}
 	prev_op_has_lease = prev_opinfo->is_lease;
 	if (prev_op_has_lease)
 		prev_op_state = prev_opinfo->o_lease->state;
@@ -1153,19 +1168,19 @@ int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
 	if (share_ret < 0 &&
 	    prev_opinfo->level == SMB2_OPLOCK_LEVEL_EXCLUSIVE) {
 		err = share_ret;
-		opinfo_put(prev_opinfo);
+		opinfo_conn_put(prev_opinfo);
 		goto err_out;
 	}
 
 	if (prev_opinfo->level != SMB2_OPLOCK_LEVEL_BATCH &&
 	    prev_opinfo->level != SMB2_OPLOCK_LEVEL_EXCLUSIVE) {
-		opinfo_put(prev_opinfo);
+		opinfo_conn_put(prev_opinfo);
 		goto op_break_not_needed;
 	}
 
 	list_add(&work->interim_entry, &prev_opinfo->interim_list);
 	err = oplock_break(prev_opinfo, SMB2_OPLOCK_LEVEL_II);
-	opinfo_put(prev_opinfo);
+	opinfo_conn_put(prev_opinfo);
 	if (err == -ENOENT)
 		goto set_lev;
 	/* Check all oplock was freed by close */
@@ -1228,14 +1243,14 @@ static void smb_break_all_write_oplock(struct ksmbd_work *work,
 		return;
 	if (brk_opinfo->level != SMB2_OPLOCK_LEVEL_BATCH &&
 	    brk_opinfo->level != SMB2_OPLOCK_LEVEL_EXCLUSIVE) {
-		opinfo_put(brk_opinfo);
+		opinfo_conn_put(brk_opinfo);
 		return;
 	}
 
 	brk_opinfo->open_trunc = is_trunc;
 	list_add(&work->interim_entry, &brk_opinfo->interim_list);
 	oplock_break(brk_opinfo, SMB2_OPLOCK_LEVEL_II);
-	opinfo_put(brk_opinfo);
+	opinfo_conn_put(brk_opinfo);
 }
 
 /**
@@ -1263,6 +1278,13 @@ void smb_break_all_levII_oplock(struct ksmbd_work *work, struct ksmbd_file *fp,
 	list_for_each_entry_rcu(brk_op, &ci->m_op_list, op_entry) {
 		if (!atomic_inc_not_zero(&brk_op->refcount))
 			continue;
+
+		atomic_inc(&brk_op->conn->r_count);
+		if (ksmbd_conn_releasing(brk_op->conn)) {
+			atomic_dec(&brk_op->conn->r_count);
+			continue;
+		}
+
 		rcu_read_unlock();
 		if (brk_op->is_lease && (brk_op->o_lease->state &
 		    (~(SMB2_LEASE_READ_CACHING_LE |
@@ -1292,7 +1314,7 @@ void smb_break_all_levII_oplock(struct ksmbd_work *work, struct ksmbd_file *fp,
 		brk_op->open_trunc = is_trunc;
 		oplock_break(brk_op, SMB2_OPLOCK_LEVEL_NONE);
 next:
-		opinfo_put(brk_op);
+		opinfo_conn_put(brk_op);
 		rcu_read_lock();
 	}
 	rcu_read_unlock();
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 7684b31035d9..01887570efe8 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -326,13 +326,9 @@ int smb2_set_rsp_credits(struct ksmbd_work *work)
 	if (hdr->Command == SMB2_NEGOTIATE)
 		aux_max = 1;
 	else
-		aux_max = conn->vals->max_credits - credit_charge;
+		aux_max = conn->vals->max_credits - conn->total_credits;
 	credits_granted = min_t(unsigned short, credits_requested, aux_max);
 
-	if (conn->vals->max_credits - conn->total_credits < credits_granted)
-		credits_granted = conn->vals->max_credits -
-			conn->total_credits;
-
 	conn->total_credits += credits_granted;
 	work->credits_granted += credits_granted;
 
@@ -865,13 +861,14 @@ static void assemble_neg_contexts(struct ksmbd_conn *conn,
 
 static __le32 decode_preauth_ctxt(struct ksmbd_conn *conn,
 				  struct smb2_preauth_neg_context *pneg_ctxt,
-				  int len_of_ctxts)
+				  int ctxt_len)
 {
 	/*
 	 * sizeof(smb2_preauth_neg_context) assumes SMB311_SALT_SIZE Salt,
 	 * which may not be present. Only check for used HashAlgorithms[1].
 	 */
-	if (len_of_ctxts < MIN_PREAUTH_CTXT_DATA_LEN)
+	if (ctxt_len <
+	    sizeof(struct smb2_neg_context) + MIN_PREAUTH_CTXT_DATA_LEN)
 		return STATUS_INVALID_PARAMETER;
 
 	if (pneg_ctxt->HashAlgorithms != SMB2_PREAUTH_INTEGRITY_SHA512)
@@ -883,15 +880,23 @@ static __le32 decode_preauth_ctxt(struct ksmbd_conn *conn,
 
 static void decode_encrypt_ctxt(struct ksmbd_conn *conn,
 				struct smb2_encryption_neg_context *pneg_ctxt,
-				int len_of_ctxts)
+				int ctxt_len)
 {
-	int cph_cnt = le16_to_cpu(pneg_ctxt->CipherCount);
-	int i, cphs_size = cph_cnt * sizeof(__le16);
+	int cph_cnt;
+	int i, cphs_size;
+
+	if (sizeof(struct smb2_encryption_neg_context) > ctxt_len) {
+		pr_err("Invalid SMB2_ENCRYPTION_CAPABILITIES context size\n");
+		return;
+	}
 
 	conn->cipher_type = 0;
 
+	cph_cnt = le16_to_cpu(pneg_ctxt->CipherCount);
+	cphs_size = cph_cnt * sizeof(__le16);
+
 	if (sizeof(struct smb2_encryption_neg_context) + cphs_size >
-	    len_of_ctxts) {
+	    ctxt_len) {
 		pr_err("Invalid cipher count(%d)\n", cph_cnt);
 		return;
 	}
@@ -939,15 +944,22 @@ static void decode_compress_ctxt(struct ksmbd_conn *conn,
 
 static void decode_sign_cap_ctxt(struct ksmbd_conn *conn,
 				 struct smb2_signing_capabilities *pneg_ctxt,
-				 int len_of_ctxts)
+				 int ctxt_len)
 {
-	int sign_algo_cnt = le16_to_cpu(pneg_ctxt->SigningAlgorithmCount);
-	int i, sign_alos_size = sign_algo_cnt * sizeof(__le16);
+	int sign_algo_cnt;
+	int i, sign_alos_size;
+
+	if (sizeof(struct smb2_signing_capabilities) > ctxt_len) {
+		pr_err("Invalid SMB2_SIGNING_CAPABILITIES context length\n");
+		return;
+	}
 
 	conn->signing_negotiated = false;
+	sign_algo_cnt = le16_to_cpu(pneg_ctxt->SigningAlgorithmCount);
+	sign_alos_size = sign_algo_cnt * sizeof(__le16);
 
 	if (sizeof(struct smb2_signing_capabilities) + sign_alos_size >
-	    len_of_ctxts) {
+	    ctxt_len) {
 		pr_err("Invalid signing algorithm count(%d)\n", sign_algo_cnt);
 		return;
 	}
@@ -985,18 +997,16 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
 	len_of_ctxts = len_of_smb - offset;
 
 	while (i++ < neg_ctxt_cnt) {
-		int clen;
-
-		/* check that offset is not beyond end of SMB */
-		if (len_of_ctxts == 0)
-			break;
+		int clen, ctxt_len;
 
 		if (len_of_ctxts < sizeof(struct smb2_neg_context))
 			break;
 
 		pctx = (struct smb2_neg_context *)((char *)pctx + offset);
 		clen = le16_to_cpu(pctx->DataLength);
-		if (clen + sizeof(struct smb2_neg_context) > len_of_ctxts)
+		ctxt_len = clen + sizeof(struct smb2_neg_context);
+
+		if (ctxt_len > len_of_ctxts)
 			break;
 
 		if (pctx->ContextType == SMB2_PREAUTH_INTEGRITY_CAPABILITIES) {
@@ -1007,7 +1017,7 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
 
 			status = decode_preauth_ctxt(conn,
 						     (struct smb2_preauth_neg_context *)pctx,
-						     len_of_ctxts);
+						     ctxt_len);
 			if (status != STATUS_SUCCESS)
 				break;
 		} else if (pctx->ContextType == SMB2_ENCRYPTION_CAPABILITIES) {
@@ -1018,7 +1028,7 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
 
 			decode_encrypt_ctxt(conn,
 					    (struct smb2_encryption_neg_context *)pctx,
-					    len_of_ctxts);
+					    ctxt_len);
 		} else if (pctx->ContextType == SMB2_COMPRESSION_CAPABILITIES) {
 			ksmbd_debug(SMB,
 				    "deassemble SMB2_COMPRESSION_CAPABILITIES context\n");
@@ -1037,9 +1047,10 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
 		} else if (pctx->ContextType == SMB2_SIGNING_CAPABILITIES) {
 			ksmbd_debug(SMB,
 				    "deassemble SMB2_SIGNING_CAPABILITIES context\n");
+
 			decode_sign_cap_ctxt(conn,
 					     (struct smb2_signing_capabilities *)pctx,
-					     len_of_ctxts);
+					     ctxt_len);
 		}
 
 		/* offsets must be 8 byte aligned */
@@ -1073,16 +1084,16 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 		return rc;
 	}
 
-	if (req->DialectCount == 0) {
-		pr_err("malformed packet\n");
+	smb2_buf_len = get_rfc1002_len(work->request_buf);
+	smb2_neg_size = offsetof(struct smb2_negotiate_req, Dialects);
+	if (smb2_neg_size > smb2_buf_len) {
 		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
 		rc = -EINVAL;
 		goto err_out;
 	}
 
-	smb2_buf_len = get_rfc1002_len(work->request_buf);
-	smb2_neg_size = offsetof(struct smb2_negotiate_req, Dialects);
-	if (smb2_neg_size > smb2_buf_len) {
+	if (req->DialectCount == 0) {
+		pr_err("malformed packet\n");
 		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
 		rc = -EINVAL;
 		goto err_out;
@@ -4371,21 +4382,6 @@ static int get_file_basic_info(struct smb2_query_info_rsp *rsp,
 	return 0;
 }
 
-static unsigned long long get_allocation_size(struct inode *inode,
-					      struct kstat *stat)
-{
-	unsigned long long alloc_size = 0;
-
-	if (!S_ISDIR(stat->mode)) {
-		if ((inode->i_blocks << 9) <= stat->size)
-			alloc_size = stat->size;
-		else
-			alloc_size = inode->i_blocks << 9;
-	}
-
-	return alloc_size;
-}
-
 static void get_file_standard_info(struct smb2_query_info_rsp *rsp,
 				   struct ksmbd_file *fp, void *rsp_org)
 {
@@ -4400,7 +4396,7 @@ static void get_file_standard_info(struct smb2_query_info_rsp *rsp,
 	sinfo = (struct smb2_file_standard_info *)rsp->Buffer;
 	delete_pending = ksmbd_inode_pending_delete(fp);
 
-	sinfo->AllocationSize = cpu_to_le64(get_allocation_size(inode, &stat));
+	sinfo->AllocationSize = cpu_to_le64(inode->i_blocks << 9);
 	sinfo->EndOfFile = S_ISDIR(stat.mode) ? 0 : cpu_to_le64(stat.size);
 	sinfo->NumberOfLinks = cpu_to_le32(get_nlink(&stat) - delete_pending);
 	sinfo->DeletePending = delete_pending;
@@ -4465,7 +4461,7 @@ static int get_file_all_info(struct ksmbd_work *work,
 	file_info->Attributes = fp->f_ci->m_fattr;
 	file_info->Pad1 = 0;
 	file_info->AllocationSize =
-		cpu_to_le64(get_allocation_size(inode, &stat));
+		cpu_to_le64(inode->i_blocks << 9);
 	file_info->EndOfFile = S_ISDIR(stat.mode) ? 0 : cpu_to_le64(stat.size);
 	file_info->NumberOfLinks =
 			cpu_to_le32(get_nlink(&stat) - delete_pending);
@@ -4654,7 +4650,7 @@ static int get_file_network_open_info(struct smb2_query_info_rsp *rsp,
 	file_info->ChangeTime = cpu_to_le64(time);
 	file_info->Attributes = fp->f_ci->m_fattr;
 	file_info->AllocationSize =
-		cpu_to_le64(get_allocation_size(inode, &stat));
+		cpu_to_le64(inode->i_blocks << 9);
 	file_info->EndOfFile = S_ISDIR(stat.mode) ? 0 : cpu_to_le64(stat.size);
 	file_info->Reserved = cpu_to_le32(0);
 	rsp->OutputBufferLength =
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index dc74a947a440..573de0d49e17 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -710,16 +710,11 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 	if (err != 0 || fd < 0)
 		return -EINVAL;
 
-	if (svc_alien_sock(net, fd)) {
-		printk(KERN_ERR "%s: socket net is different to NFSd's one\n", __func__);
-		return -EINVAL;
-	}
-
 	err = nfsd_create_serv(net);
 	if (err != 0)
 		return err;
 
-	err = svc_addsock(nn->nfsd_serv, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
+	err = svc_addsock(nn->nfsd_serv, net, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
 
 	if (err >= 0 &&
 	    !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index dc3ba13546dd..155b34c4683c 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -469,7 +469,15 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	inode_lock(inode);
 	for (retries = 1;;) {
-		host_err = __nfsd_setattr(dentry, iap);
+		struct iattr attrs;
+
+		/*
+		 * notify_change() can alter its iattr argument, making
+		 * @iap unsuitable for submission multiple times. Make a
+		 * copy for every loop iteration.
+		 */
+		attrs = *iap;
+		host_err = __nfsd_setattr(dentry, &attrs);
 		if (host_err != -EAGAIN || !retries--)
 			break;
 		if (!nfsd_wait_for_delegreturn(rqstp, inode))
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 57988fedd184..e52dfa5c7562 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -98,6 +98,12 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	/* Record should contain $I30 root. */
 	is_dir = rec->flags & RECORD_FLAG_DIR;
 
+	/* MFT_REC_MFT is not a dir */
+	if (is_dir && ino == MFT_REC_MFT) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	inode->i_generation = le16_to_cpu(rec->seq);
 
 	/* Enumerate all struct Attributes MFT. */
diff --git a/fs/xfs/xfs_buf_item_recover.c b/fs/xfs/xfs_buf_item_recover.c
index ffa94102094d..43167f543afc 100644
--- a/fs/xfs/xfs_buf_item_recover.c
+++ b/fs/xfs/xfs_buf_item_recover.c
@@ -943,6 +943,16 @@ xlog_recover_buf_commit_pass2(
 	if (lsn && lsn != -1 && XFS_LSN_CMP(lsn, current_lsn) >= 0) {
 		trace_xfs_log_recover_buf_skip(log, buf_f);
 		xlog_recover_validate_buf_type(mp, bp, buf_f, NULLCOMMITLSN);
+
+		/*
+		 * We're skipping replay of this buffer log item due to the log
+		 * item LSN being behind the ondisk buffer.  Verify the buffer
+		 * contents since we aren't going to run the write verifier.
+		 */
+		if (bp->b_ops) {
+			bp->b_ops->verify_read(bp);
+			error = bp->b_error;
+		}
 		goto out_release;
 	}
 
diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index bcc555c7ae9c..13aff355d5a1 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -59,10 +59,9 @@ int		svc_recv(struct svc_rqst *, long);
 int		svc_send(struct svc_rqst *);
 void		svc_drop(struct svc_rqst *);
 void		svc_sock_update_bufs(struct svc_serv *serv);
-bool		svc_alien_sock(struct net *net, int fd);
-int		svc_addsock(struct svc_serv *serv, const int fd,
-					char *name_return, const size_t len,
-					const struct cred *cred);
+int		svc_addsock(struct svc_serv *serv, struct net *net,
+			    const int fd, char *name_return, const size_t len,
+			    const struct cred *cred);
 void		svc_init_xprt_sock(void);
 void		svc_cleanup_xprt_sock(void);
 struct svc_xprt *svc_sock_create(struct svc_serv *serv, int prot);
diff --git a/include/media/dvb_net.h b/include/media/dvb_net.h
index 5e31d37f25fa..cc01dffcc9f3 100644
--- a/include/media/dvb_net.h
+++ b/include/media/dvb_net.h
@@ -41,6 +41,9 @@
  * @exit:		flag to indicate when the device is being removed.
  * @demux:		pointer to &struct dmx_demux.
  * @ioctl_mutex:	protect access to this struct.
+ * @remove_mutex:	mutex that avoids a race condition between a callback
+ *			called when the hardware is disconnected and the
+ *			file_operations of dvb_net.
  *
  * Currently, the core supports up to %DVB_NET_DEVICES_MAX (10) network
  * devices.
@@ -53,6 +56,7 @@ struct dvb_net {
 	unsigned int exit:1;
 	struct dmx_demux *demux;
 	struct mutex ioctl_mutex;
+	struct mutex remove_mutex;
 };
 
 /**
diff --git a/include/media/dvbdev.h b/include/media/dvbdev.h
index ac60c9fcfe9a..34b01ebf3282 100644
--- a/include/media/dvbdev.h
+++ b/include/media/dvbdev.h
@@ -189,6 +189,21 @@ struct dvb_device {
 	void *priv;
 };
 
+/**
+ * struct dvbdevfops_node - fops nodes registered in dvbdevfops_list
+ *
+ * @fops:		Dynamically allocated fops for ->owner registration
+ * @type:		type of dvb_device
+ * @template:		dvb_device used for registration
+ * @list_head:		list_head for dvbdevfops_list
+ */
+struct dvbdevfops_node {
+	struct file_operations *fops;
+	enum dvb_device_type type;
+	const struct dvb_device *template;
+	struct list_head list_head;
+};
+
 /**
  * dvb_device_get - Increase dvb_device reference
  *
diff --git a/include/net/sock.h b/include/net/sock.h
index beb1b747fb09..f11b98bd0244 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -333,6 +333,7 @@ struct sk_filter;
   *	@sk_cgrp_data: cgroup data for this cgroup
   *	@sk_memcg: this socket's memory cgroup association
   *	@sk_write_pending: a write to stream socket waits to start
+  *	@sk_wait_pending: number of threads blocked on this socket
   *	@sk_state_change: callback to indicate change in the state of the sock
   *	@sk_data_ready: callback to indicate there is data to be processed
   *	@sk_write_space: callback to indicate there is bf sending space available
@@ -425,6 +426,7 @@ struct sock {
 	unsigned int		sk_napi_id;
 #endif
 	int			sk_rcvbuf;
+	int			sk_wait_pending;
 
 	struct sk_filter __rcu	*sk_filter;
 	union {
@@ -1170,6 +1172,7 @@ static inline void sock_rps_reset_rxhash(struct sock *sk)
 
 #define sk_wait_event(__sk, __timeo, __condition, __wait)		\
 	({	int __rc;						\
+		__sk->sk_wait_pending++;				\
 		release_sock(__sk);					\
 		__rc = __condition;					\
 		if (!__rc) {						\
@@ -1179,6 +1182,7 @@ static inline void sock_rps_reset_rxhash(struct sock *sk)
 		}							\
 		sched_annotate_sleep();					\
 		lock_sock(__sk);					\
+		__sk->sk_wait_pending--;				\
 		__rc = __condition;					\
 		__rc;							\
 	})
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 0744717f5caa..5eedd476a38d 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -632,6 +632,7 @@ void tcp_reset(struct sock *sk, struct sk_buff *skb);
 void tcp_skb_mark_lost_uncond_verify(struct tcp_sock *tp, struct sk_buff *skb);
 void tcp_fin(struct sock *sk);
 void tcp_check_space(struct sock *sk);
+void tcp_sack_compress_send_ack(struct sock *sk);
 
 /* tcp_timer.c */
 void tcp_init_xmit_timers(struct sock *);
diff --git a/io_uring/epoll.c b/io_uring/epoll.c
index 9aa74d2c80bc..89bff2068a19 100644
--- a/io_uring/epoll.c
+++ b/io_uring/epoll.c
@@ -25,10 +25,6 @@ int io_epoll_ctl_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_epoll *epoll = io_kiocb_to_cmd(req, struct io_epoll);
 
-	pr_warn_once("%s: epoll_ctl support in io_uring is deprecated and will "
-		     "be removed in a future Linux kernel version.\n",
-		     current->comm);
-
 	if (sqe->buf_index || sqe->splice_fd_in)
 		return -EINVAL;
 
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 2b2120ed2460..75244d9e2bf9 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4193,13 +4193,19 @@ static int __create_val_field(struct hist_trigger_data *hist_data,
 		goto out;
 	}
 
-	/* Some types cannot be a value */
-	if (hist_field->flags & (HIST_FIELD_FL_GRAPH | HIST_FIELD_FL_PERCENT |
-				 HIST_FIELD_FL_BUCKET | HIST_FIELD_FL_LOG2 |
-				 HIST_FIELD_FL_SYM | HIST_FIELD_FL_SYM_OFFSET |
-				 HIST_FIELD_FL_SYSCALL | HIST_FIELD_FL_STACKTRACE)) {
-		hist_err(file->tr, HIST_ERR_BAD_FIELD_MODIFIER, errpos(field_str));
-		ret = -EINVAL;
+	/* values and variables should not have some modifiers */
+	if (hist_field->flags & HIST_FIELD_FL_VAR) {
+		/* Variable */
+		if (hist_field->flags & (HIST_FIELD_FL_GRAPH | HIST_FIELD_FL_PERCENT |
+					 HIST_FIELD_FL_BUCKET | HIST_FIELD_FL_LOG2))
+			goto err;
+	} else {
+		/* Value */
+		if (hist_field->flags & (HIST_FIELD_FL_GRAPH | HIST_FIELD_FL_PERCENT |
+					 HIST_FIELD_FL_BUCKET | HIST_FIELD_FL_LOG2 |
+					 HIST_FIELD_FL_SYM | HIST_FIELD_FL_SYM_OFFSET |
+					 HIST_FIELD_FL_SYSCALL | HIST_FIELD_FL_STACKTRACE))
+			goto err;
 	}
 
 	hist_data->fields[val_idx] = hist_field;
@@ -4211,6 +4217,9 @@ static int __create_val_field(struct hist_trigger_data *hist_data,
 		ret = -EINVAL;
  out:
 	return ret;
+ err:
+	hist_err(file->tr, HIST_ERR_BAD_FIELD_MODIFIER, errpos(field_str));
+	return -EINVAL;
 }
 
 static int create_val_field(struct hist_trigger_data *hist_data,
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 689361097bb0..26111b0ca1da 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1595,6 +1595,8 @@ static enum hrtimer_restart timerlat_irq(struct hrtimer *timer)
 			osnoise_stop_tracing();
 			notify_new_max_latency(diff);
 
+			wake_up_process(tlat->kthread);
+
 			return HRTIMER_NORESTART;
 		}
 	}
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index de38f1c03776..3d731aac94d4 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -302,7 +302,7 @@ trace_probe_primary_from_call(struct trace_event_call *call)
 {
 	struct trace_probe_event *tpe = trace_probe_event_from_call(call);
 
-	return list_first_entry(&tpe->probes, struct trace_probe, list);
+	return list_first_entry_or_null(&tpe->probes, struct trace_probe, list);
 }
 
 static inline struct list_head *trace_probe_probe_list(struct trace_probe *tp)
diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 1c5a2adb16ef..7f165c517338 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -44,6 +44,7 @@ struct test_batched_req {
 	bool sent;
 	const struct firmware *fw;
 	const char *name;
+	const char *fw_buf;
 	struct completion completion;
 	struct task_struct *task;
 	struct device *dev;
@@ -174,8 +175,14 @@ static void __test_release_all_firmware(void)
 
 	for (i = 0; i < test_fw_config->num_requests; i++) {
 		req = &test_fw_config->reqs[i];
-		if (req->fw)
+		if (req->fw) {
+			if (req->fw_buf) {
+				kfree_const(req->fw_buf);
+				req->fw_buf = NULL;
+			}
 			release_firmware(req->fw);
+			req->fw = NULL;
+		}
 	}
 
 	vfree(test_fw_config->reqs);
@@ -651,6 +658,8 @@ static ssize_t trigger_request_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 	release_firmware(test_firmware);
+	if (test_fw_config->reqs)
+		__test_release_all_firmware();
 	test_firmware = NULL;
 	rc = request_firmware(&test_firmware, name, dev);
 	if (rc) {
@@ -751,6 +760,8 @@ static ssize_t trigger_async_request_store(struct device *dev,
 	mutex_lock(&test_fw_mutex);
 	release_firmware(test_firmware);
 	test_firmware = NULL;
+	if (test_fw_config->reqs)
+		__test_release_all_firmware();
 	rc = request_firmware_nowait(THIS_MODULE, 1, name, dev, GFP_KERNEL,
 				     NULL, trigger_async_request_cb);
 	if (rc) {
@@ -793,6 +804,8 @@ static ssize_t trigger_custom_fallback_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 	release_firmware(test_firmware);
+	if (test_fw_config->reqs)
+		__test_release_all_firmware();
 	test_firmware = NULL;
 	rc = request_firmware_nowait(THIS_MODULE, FW_ACTION_NOUEVENT, name,
 				     dev, GFP_KERNEL, NULL,
@@ -855,6 +868,8 @@ static int test_fw_run_batch_request(void *data)
 						 test_fw_config->buf_size);
 		if (!req->fw)
 			kfree(test_buf);
+		else
+			req->fw_buf = test_buf;
 	} else {
 		req->rc = test_fw_config->req_firmware(&req->fw,
 						       req->name,
@@ -894,6 +909,11 @@ static ssize_t trigger_batched_requests_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 
+	if (test_fw_config->reqs) {
+		rc = -EBUSY;
+		goto out_bail;
+	}
+
 	test_fw_config->reqs =
 		vzalloc(array3_size(sizeof(struct test_batched_req),
 				    test_fw_config->num_requests, 2));
@@ -910,6 +930,7 @@ static ssize_t trigger_batched_requests_store(struct device *dev,
 		req->fw = NULL;
 		req->idx = i;
 		req->name = test_fw_config->name;
+		req->fw_buf = NULL;
 		req->dev = dev;
 		init_completion(&req->completion);
 		req->task = kthread_run(test_fw_run_batch_request, req,
@@ -992,6 +1013,11 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 
+	if (test_fw_config->reqs) {
+		rc = -EBUSY;
+		goto out_bail;
+	}
+
 	test_fw_config->reqs =
 		vzalloc(array3_size(sizeof(struct test_batched_req),
 				    test_fw_config->num_requests, 2));
@@ -1009,6 +1035,7 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
 	for (i = 0; i < test_fw_config->num_requests; i++) {
 		req = &test_fw_config->reqs[i];
 		req->name = test_fw_config->name;
+		req->fw_buf = NULL;
 		req->fw = NULL;
 		req->idx = i;
 		init_completion(&req->completion);
diff --git a/net/atm/resources.c b/net/atm/resources.c
index 2b2d33eeaf20..995d29e7fb13 100644
--- a/net/atm/resources.c
+++ b/net/atm/resources.c
@@ -400,6 +400,7 @@ int atm_dev_ioctl(unsigned int cmd, void __user *buf, int __user *sioc_len,
 	return error;
 }
 
+#ifdef CONFIG_PROC_FS
 void *atm_dev_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	mutex_lock(&atm_dev_mutex);
@@ -415,3 +416,4 @@ void *atm_dev_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	return seq_list_next(v, &atm_devs, pos);
 }
+#endif
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 74864dc46a7e..b192c69f3936 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3212,6 +3212,7 @@ struct net_device *rtnl_create_link(struct net *net, const char *ifname,
 	struct net_device *dev;
 	unsigned int num_tx_queues = 1;
 	unsigned int num_rx_queues = 1;
+	int err;
 
 	if (tb[IFLA_NUM_TX_QUEUES])
 		num_tx_queues = nla_get_u32(tb[IFLA_NUM_TX_QUEUES]);
@@ -3247,13 +3248,18 @@ struct net_device *rtnl_create_link(struct net *net, const char *ifname,
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 
+	err = validate_linkmsg(dev, tb, extack);
+	if (err < 0) {
+		free_netdev(dev);
+		return ERR_PTR(err);
+	}
+
 	dev_net_set(dev, net);
 	dev->rtnl_link_ops = ops;
 	dev->rtnl_link_state = RTNL_LINK_INITIALIZING;
 
 	if (tb[IFLA_MTU]) {
 		u32 mtu = nla_get_u32(tb[IFLA_MTU]);
-		int err;
 
 		err = dev_validate_mtu(dev, mtu, extack);
 		if (err) {
diff --git a/net/core/sock.c b/net/core/sock.c
index eb0b76acd9df..83f590d8d085 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2370,7 +2370,6 @@ void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
 {
 	u32 max_segs = 1;
 
-	sk_dst_set(sk, dst);
 	sk->sk_route_caps = dst->dev->features;
 	if (sk_is_tcp(sk))
 		sk->sk_route_caps |= NETIF_F_GSO;
@@ -2392,6 +2391,7 @@ void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
 		}
 	}
 	sk->sk_gso_max_segs = max_segs;
+	sk_dst_set(sk, dst);
 }
 EXPORT_SYMBOL_GPL(sk_setup_caps);
 
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 5fd0ff5734e3..ebb737ac9e89 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -589,6 +589,7 @@ static long inet_wait_for_connect(struct sock *sk, long timeo, int writebias)
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	sk->sk_write_pending += writebias;
+	sk->sk_wait_pending++;
 
 	/* Basic assumption: if someone sets sk->sk_err, he _must_
 	 * change state of the socket from TCP_SYN_*.
@@ -604,6 +605,7 @@ static long inet_wait_for_connect(struct sock *sk, long timeo, int writebias)
 	}
 	remove_wait_queue(sk_sleep(sk), &wait);
 	sk->sk_write_pending -= writebias;
+	sk->sk_wait_pending--;
 	return timeo;
 }
 
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 916075e00d06..8e35ea66d930 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1143,6 +1143,7 @@ struct sock *inet_csk_clone_lock(const struct sock *sk,
 	if (newsk) {
 		struct inet_connection_sock *newicsk = inet_csk(newsk);
 
+		newsk->sk_wait_pending = 0;
 		inet_sk_set_state(newsk, TCP_SYN_RECV);
 		newicsk->icsk_bind_hash = NULL;
 		newicsk->icsk_bind2_hash = NULL;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 021a8bf6a189..0bd0be3c63d2 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3079,6 +3079,12 @@ int tcp_disconnect(struct sock *sk, int flags)
 	int old_state = sk->sk_state;
 	u32 seq;
 
+	/* Deny disconnect if other threads are blocked in sk_wait_event()
+	 * or inet_wait_for_connect().
+	 */
+	if (sk->sk_wait_pending)
+		return -EBUSY;
+
 	if (old_state != TCP_CLOSE)
 		tcp_set_state(sk, TCP_CLOSE);
 
@@ -4065,7 +4071,8 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 	switch (optname) {
 	case TCP_MAXSEG:
 		val = tp->mss_cache;
-		if (!val && ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)))
+		if (tp->rx_opt.user_mss &&
+		    ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)))
 			val = tp->rx_opt.user_mss;
 		if (tp->repair)
 			val = tp->rx_opt.mss_clamp;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index ac44edd6f52e..5dabb38b857f 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4529,7 +4529,7 @@ static void tcp_sack_maybe_coalesce(struct tcp_sock *tp)
 	}
 }
 
-static void tcp_sack_compress_send_ack(struct sock *sk)
+void tcp_sack_compress_send_ack(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index cb79127f45c3..0b5d0a2867a8 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -290,9 +290,19 @@ static int tcp_write_timeout(struct sock *sk)
 void tcp_delack_timer_handler(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
 
-	if (((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) ||
-	    !(icsk->icsk_ack.pending & ICSK_ACK_TIMER))
+	if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))
+		return;
+
+	/* Handling the sack compression case */
+	if (tp->compressed_ack) {
+		tcp_mstamp_refresh(tp);
+		tcp_sack_compress_send_ack(sk);
+		return;
+	}
+
+	if (!(icsk->icsk_ack.pending & ICSK_ACK_TIMER))
 		return;
 
 	if (time_after(icsk->icsk_ack.timeout, jiffies)) {
@@ -312,7 +322,7 @@ void tcp_delack_timer_handler(struct sock *sk)
 			inet_csk_exit_pingpong_mode(sk);
 			icsk->icsk_ack.ato      = TCP_ATO_MIN;
 		}
-		tcp_mstamp_refresh(tcp_sk(sk));
+		tcp_mstamp_refresh(tp);
 		tcp_send_ack(sk);
 		__NET_INC_STATS(sock_net(sk), LINUX_MIB_DELAYEDACKS);
 	}
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index e72cf0749d49..f07e34bed8f3 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -258,7 +258,8 @@ ieee80211_get_max_required_bw(struct ieee80211_sub_if_data *sdata,
 
 static enum nl80211_chan_width
 ieee80211_get_chanctx_vif_max_required_bw(struct ieee80211_sub_if_data *sdata,
-					  struct ieee80211_chanctx_conf *conf)
+					  struct ieee80211_chanctx *ctx,
+					  struct ieee80211_link_data *rsvd_for)
 {
 	enum nl80211_chan_width max_bw = NL80211_CHAN_WIDTH_20_NOHT;
 	struct ieee80211_vif *vif = &sdata->vif;
@@ -267,13 +268,14 @@ ieee80211_get_chanctx_vif_max_required_bw(struct ieee80211_sub_if_data *sdata,
 	rcu_read_lock();
 	for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
 		enum nl80211_chan_width width = NL80211_CHAN_WIDTH_20_NOHT;
-		struct ieee80211_bss_conf *link_conf =
-			rcu_dereference(sdata->vif.link_conf[link_id]);
+		struct ieee80211_link_data *link =
+			rcu_dereference(sdata->link[link_id]);
 
-		if (!link_conf)
+		if (!link)
 			continue;
 
-		if (rcu_access_pointer(link_conf->chanctx_conf) != conf)
+		if (link != rsvd_for &&
+		    rcu_access_pointer(link->conf->chanctx_conf) != &ctx->conf)
 			continue;
 
 		switch (vif->type) {
@@ -287,7 +289,7 @@ ieee80211_get_chanctx_vif_max_required_bw(struct ieee80211_sub_if_data *sdata,
 			 * point, so take the width from the chandef, but
 			 * account also for TDLS peers
 			 */
-			width = max(link_conf->chandef.width,
+			width = max(link->conf->chandef.width,
 				    ieee80211_get_max_required_bw(sdata, link_id));
 			break;
 		case NL80211_IFTYPE_P2P_DEVICE:
@@ -296,7 +298,7 @@ ieee80211_get_chanctx_vif_max_required_bw(struct ieee80211_sub_if_data *sdata,
 		case NL80211_IFTYPE_ADHOC:
 		case NL80211_IFTYPE_MESH_POINT:
 		case NL80211_IFTYPE_OCB:
-			width = link_conf->chandef.width;
+			width = link->conf->chandef.width;
 			break;
 		case NL80211_IFTYPE_WDS:
 		case NL80211_IFTYPE_UNSPECIFIED:
@@ -316,7 +318,8 @@ ieee80211_get_chanctx_vif_max_required_bw(struct ieee80211_sub_if_data *sdata,
 
 static enum nl80211_chan_width
 ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
-				      struct ieee80211_chanctx_conf *conf)
+				      struct ieee80211_chanctx *ctx,
+				      struct ieee80211_link_data *rsvd_for)
 {
 	struct ieee80211_sub_if_data *sdata;
 	enum nl80211_chan_width max_bw = NL80211_CHAN_WIDTH_20_NOHT;
@@ -328,7 +331,8 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 		if (!ieee80211_sdata_running(sdata))
 			continue;
 
-		width = ieee80211_get_chanctx_vif_max_required_bw(sdata, conf);
+		width = ieee80211_get_chanctx_vif_max_required_bw(sdata, ctx,
+								  rsvd_for);
 
 		max_bw = max(max_bw, width);
 	}
@@ -336,8 +340,8 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 	/* use the configured bandwidth in case of monitor interface */
 	sdata = rcu_dereference(local->monitor_sdata);
 	if (sdata &&
-	    rcu_access_pointer(sdata->vif.bss_conf.chanctx_conf) == conf)
-		max_bw = max(max_bw, conf->def.width);
+	    rcu_access_pointer(sdata->vif.bss_conf.chanctx_conf) == &ctx->conf)
+		max_bw = max(max_bw, ctx->conf.def.width);
 
 	rcu_read_unlock();
 
@@ -349,8 +353,10 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
  * the max of min required widths of all the interfaces bound to this
  * channel context.
  */
-static u32 _ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
-					     struct ieee80211_chanctx *ctx)
+static u32
+_ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
+				  struct ieee80211_chanctx *ctx,
+				  struct ieee80211_link_data *rsvd_for)
 {
 	enum nl80211_chan_width max_bw;
 	struct cfg80211_chan_def min_def;
@@ -370,7 +376,7 @@ static u32 _ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 		return 0;
 	}
 
-	max_bw = ieee80211_get_chanctx_max_required_bw(local, &ctx->conf);
+	max_bw = ieee80211_get_chanctx_max_required_bw(local, ctx, rsvd_for);
 
 	/* downgrade chandef up to max_bw */
 	min_def = ctx->conf.def;
@@ -448,9 +454,10 @@ static void ieee80211_chan_bw_change(struct ieee80211_local *local,
  * channel context.
  */
 void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
-				      struct ieee80211_chanctx *ctx)
+				      struct ieee80211_chanctx *ctx,
+				      struct ieee80211_link_data *rsvd_for)
 {
-	u32 changed = _ieee80211_recalc_chanctx_min_def(local, ctx);
+	u32 changed = _ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for);
 
 	if (!changed)
 		return;
@@ -464,10 +471,11 @@ void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 	ieee80211_chan_bw_change(local, ctx, false);
 }
 
-static void ieee80211_change_chanctx(struct ieee80211_local *local,
-				     struct ieee80211_chanctx *ctx,
-				     struct ieee80211_chanctx *old_ctx,
-				     const struct cfg80211_chan_def *chandef)
+static void _ieee80211_change_chanctx(struct ieee80211_local *local,
+				      struct ieee80211_chanctx *ctx,
+				      struct ieee80211_chanctx *old_ctx,
+				      const struct cfg80211_chan_def *chandef,
+				      struct ieee80211_link_data *rsvd_for)
 {
 	u32 changed;
 
@@ -492,7 +500,7 @@ static void ieee80211_change_chanctx(struct ieee80211_local *local,
 	ieee80211_chan_bw_change(local, old_ctx, true);
 
 	if (cfg80211_chandef_identical(&ctx->conf.def, chandef)) {
-		ieee80211_recalc_chanctx_min_def(local, ctx);
+		ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for);
 		return;
 	}
 
@@ -502,7 +510,7 @@ static void ieee80211_change_chanctx(struct ieee80211_local *local,
 
 	/* check if min chanctx also changed */
 	changed = IEEE80211_CHANCTX_CHANGE_WIDTH |
-		  _ieee80211_recalc_chanctx_min_def(local, ctx);
+		  _ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for);
 	drv_change_chanctx(local, ctx, changed);
 
 	if (!local->use_chanctx) {
@@ -514,6 +522,14 @@ static void ieee80211_change_chanctx(struct ieee80211_local *local,
 	ieee80211_chan_bw_change(local, old_ctx, false);
 }
 
+static void ieee80211_change_chanctx(struct ieee80211_local *local,
+				     struct ieee80211_chanctx *ctx,
+				     struct ieee80211_chanctx *old_ctx,
+				     const struct cfg80211_chan_def *chandef)
+{
+	_ieee80211_change_chanctx(local, ctx, old_ctx, chandef, NULL);
+}
+
 static struct ieee80211_chanctx *
 ieee80211_find_chanctx(struct ieee80211_local *local,
 		       const struct cfg80211_chan_def *chandef,
@@ -638,7 +654,7 @@ ieee80211_alloc_chanctx(struct ieee80211_local *local,
 	ctx->conf.rx_chains_dynamic = 1;
 	ctx->mode = mode;
 	ctx->conf.radar_enabled = false;
-	ieee80211_recalc_chanctx_min_def(local, ctx);
+	_ieee80211_recalc_chanctx_min_def(local, ctx, NULL);
 
 	return ctx;
 }
@@ -855,6 +871,9 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 	}
 
 	if (new_ctx) {
+		/* recalc considering the link we'll use it for now */
+		ieee80211_recalc_chanctx_min_def(local, new_ctx, link);
+
 		ret = drv_assign_vif_chanctx(local, sdata, link->conf, new_ctx);
 		if (ret)
 			goto out;
@@ -873,12 +892,12 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 		ieee80211_recalc_chanctx_chantype(local, curr_ctx);
 		ieee80211_recalc_smps_chanctx(local, curr_ctx);
 		ieee80211_recalc_radar_chanctx(local, curr_ctx);
-		ieee80211_recalc_chanctx_min_def(local, curr_ctx);
+		ieee80211_recalc_chanctx_min_def(local, curr_ctx, NULL);
 	}
 
 	if (new_ctx && ieee80211_chanctx_num_assigned(local, new_ctx) > 0) {
 		ieee80211_recalc_txpower(sdata, false);
-		ieee80211_recalc_chanctx_min_def(local, new_ctx);
+		ieee80211_recalc_chanctx_min_def(local, new_ctx, NULL);
 	}
 
 	if (sdata->vif.type != NL80211_IFTYPE_P2P_DEVICE &&
@@ -1270,7 +1289,7 @@ ieee80211_link_use_reserved_reassign(struct ieee80211_link_data *link)
 
 	ieee80211_link_update_chandef(link, &link->reserved_chandef);
 
-	ieee80211_change_chanctx(local, new_ctx, old_ctx, chandef);
+	_ieee80211_change_chanctx(local, new_ctx, old_ctx, chandef, link);
 
 	vif_chsw[0].vif = &sdata->vif;
 	vif_chsw[0].old_ctx = &old_ctx->conf;
@@ -1300,7 +1319,7 @@ ieee80211_link_use_reserved_reassign(struct ieee80211_link_data *link)
 	if (ieee80211_chanctx_refcount(local, old_ctx) == 0)
 		ieee80211_free_chanctx(local, old_ctx);
 
-	ieee80211_recalc_chanctx_min_def(local, new_ctx);
+	ieee80211_recalc_chanctx_min_def(local, new_ctx, NULL);
 	ieee80211_recalc_smps_chanctx(local, new_ctx);
 	ieee80211_recalc_radar_chanctx(local, new_ctx);
 
@@ -1665,7 +1684,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		ieee80211_recalc_chanctx_chantype(local, ctx);
 		ieee80211_recalc_smps_chanctx(local, ctx);
 		ieee80211_recalc_radar_chanctx(local, ctx);
-		ieee80211_recalc_chanctx_min_def(local, ctx);
+		ieee80211_recalc_chanctx_min_def(local, ctx, NULL);
 
 		list_for_each_entry_safe(link, link_tmp, &ctx->reserved_links,
 					 reserved_chanctx_list) {
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e57001e00a3d..27479bbb093a 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2475,7 +2475,8 @@ int ieee80211_chanctx_refcount(struct ieee80211_local *local,
 void ieee80211_recalc_smps_chanctx(struct ieee80211_local *local,
 				   struct ieee80211_chanctx *chanctx);
 void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
-				      struct ieee80211_chanctx *ctx);
+				      struct ieee80211_chanctx *ctx,
+				      struct ieee80211_link_data *rsvd_for);
 bool ieee80211_is_radar_required(struct ieee80211_local *local);
 
 void ieee80211_dfs_cac_timer(unsigned long data);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 0785d9393e71..784b9ba61581 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2899,7 +2899,7 @@ void ieee80211_recalc_min_chandef(struct ieee80211_sub_if_data *sdata,
 
 		chanctx = container_of(chanctx_conf, struct ieee80211_chanctx,
 				       conf);
-		ieee80211_recalc_chanctx_min_def(local, chanctx);
+		ieee80211_recalc_chanctx_min_def(local, chanctx, NULL);
 	}
  unlock:
 	mutex_unlock(&local->chanctx_mtx);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ea46a5cb1c30..59186997c3e2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -111,8 +111,8 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
 	if (err)
 		return err;
 
-	msk->first = ssock->sk;
-	msk->subflow = ssock;
+	WRITE_ONCE(msk->first, ssock->sk);
+	WRITE_ONCE(msk->subflow, ssock);
 	subflow = mptcp_subflow_ctx(ssock->sk);
 	list_add(&subflow->node, &msk->conn_list);
 	sock_hold(ssock->sk);
@@ -599,7 +599,7 @@ static bool mptcp_check_data_fin(struct sock *sk)
 		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
 		WRITE_ONCE(msk->rcv_data_fin, 0);
 
-		sk->sk_shutdown |= RCV_SHUTDOWN;
+		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
 		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
 
 		switch (sk->sk_state) {
@@ -821,6 +821,13 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 	mptcp_data_unlock(sk);
 }
 
+static void mptcp_subflow_joined(struct mptcp_sock *msk, struct sock *ssk)
+{
+	mptcp_subflow_ctx(ssk)->map_seq = READ_ONCE(msk->ack_seq);
+	WRITE_ONCE(msk->allow_infinite_fallback, false);
+	mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);
+}
+
 static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct sock *sk = (struct sock *)msk;
@@ -835,6 +842,7 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 		mptcp_sock_graft(ssk, sk->sk_socket);
 
 	mptcp_sockopt_sync_locked(msk, ssk);
+	mptcp_subflow_joined(msk, ssk);
 	return true;
 }
 
@@ -906,7 +914,7 @@ static void mptcp_check_for_eof(struct mptcp_sock *msk)
 		/* hopefully temporary hack: propagate shutdown status
 		 * to msk, when all subflows agree on it
 		 */
-		sk->sk_shutdown |= RCV_SHUTDOWN;
+		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
 
 		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
 		sk->sk_data_ready(sk);
@@ -1683,7 +1691,6 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct sock *ssk, struct msgh
 
 	lock_sock(ssk);
 	msg->msg_flags |= MSG_DONTWAIT;
-	msk->connect_flags = O_NONBLOCK;
 	msk->fastopening = 1;
 	ret = tcp_sendmsg_fastopen(ssk, msg, copied_syn, len, NULL);
 	msk->fastopening = 0;
@@ -2269,7 +2276,7 @@ static void mptcp_dispose_initial_subflow(struct mptcp_sock *msk)
 {
 	if (msk->subflow) {
 		iput(SOCK_INODE(msk->subflow));
-		msk->subflow = NULL;
+		WRITE_ONCE(msk->subflow, NULL);
 	}
 }
 
@@ -2405,7 +2412,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	sock_put(ssk);
 
 	if (ssk == msk->first)
-		msk->first = NULL;
+		WRITE_ONCE(msk->first, NULL);
 
 out:
 	if (ssk == msk->last_snd)
@@ -2512,7 +2519,7 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 	}
 
 	inet_sk_state_store(sk, TCP_CLOSE);
-	sk->sk_shutdown = SHUTDOWN_MASK;
+	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 	smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
 	set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags);
 
@@ -2706,7 +2713,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	WRITE_ONCE(msk->rmem_released, 0);
 	msk->timer_ival = TCP_RTO_MIN;
 
-	msk->first = NULL;
+	WRITE_ONCE(msk->first, NULL);
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
 	WRITE_ONCE(msk->allow_infinite_fallback, true);
@@ -2941,7 +2948,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 	bool do_cancel_work = false;
 	int subflows_alive = 0;
 
-	sk->sk_shutdown = SHUTDOWN_MASK;
+	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) {
 		inet_sk_state_store(sk, TCP_CLOSE);
@@ -3017,7 +3024,7 @@ static void mptcp_close(struct sock *sk, long timeout)
 	sock_put(sk);
 }
 
-void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
+static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
 {
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	const struct ipv6_pinfo *ssk6 = inet6_sk(ssk);
@@ -3079,7 +3086,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_pm_data_reset(msk);
 	mptcp_ca_reset(sk);
 
-	sk->sk_shutdown = 0;
+	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
 	return 0;
 }
@@ -3093,9 +3100,10 @@ static struct ipv6_pinfo *mptcp_inet6_sk(const struct sock *sk)
 }
 #endif
 
-struct sock *mptcp_sk_clone(const struct sock *sk,
-			    const struct mptcp_options_received *mp_opt,
-			    struct request_sock *req)
+struct sock *mptcp_sk_clone_init(const struct sock *sk,
+				 const struct mptcp_options_received *mp_opt,
+				 struct sock *ssk,
+				 struct request_sock *req)
 {
 	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
 	struct sock *nsk = sk_clone_lock(sk, GFP_ATOMIC);
@@ -3115,7 +3123,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk = mptcp_sk(nsk);
 	msk->local_key = subflow_req->local_key;
 	msk->token = subflow_req->token;
-	msk->subflow = NULL;
+	WRITE_ONCE(msk->subflow, NULL);
 	msk->in_accept_queue = 1;
 	WRITE_ONCE(msk->fully_established, false);
 	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
@@ -3137,10 +3145,30 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	}
 
 	sock_reset_flag(nsk, SOCK_RCU_FREE);
-	/* will be fully established after successful MPC subflow creation */
-	inet_sk_state_store(nsk, TCP_SYN_RECV);
-
 	security_inet_csk_clone(nsk, req);
+
+	/* this can't race with mptcp_close(), as the msk is
+	 * not yet exposted to user-space
+	 */
+	inet_sk_state_store(nsk, TCP_ESTABLISHED);
+
+	/* The msk maintain a ref to each subflow in the connections list */
+	WRITE_ONCE(msk->first, ssk);
+	list_add(&mptcp_subflow_ctx(ssk)->node, &msk->conn_list);
+	sock_hold(ssk);
+
+	/* new mpc subflow takes ownership of the newly
+	 * created mptcp socket
+	 */
+	mptcp_token_accept(subflow_req, msk);
+
+	/* set msk addresses early to ensure mptcp_pm_get_local_id()
+	 * uses the correct data
+	 */
+	mptcp_copy_inaddrs(nsk, ssk);
+	mptcp_propagate_sndbuf(nsk, ssk);
+
+	mptcp_rcv_space_init(msk, ssk);
 	bh_unlock_sock(nsk);
 
 	/* note: the newly allocated socket refcount is 2 now */
@@ -3172,7 +3200,7 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
 	struct socket *listener;
 	struct sock *newsk;
 
-	listener = __mptcp_nmpc_socket(msk);
+	listener = READ_ONCE(msk->subflow);
 	if (WARN_ON_ONCE(!listener)) {
 		*err = -EINVAL;
 		return NULL;
@@ -3398,7 +3426,7 @@ static int mptcp_get_port(struct sock *sk, unsigned short snum)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct socket *ssock;
 
-	ssock = __mptcp_nmpc_socket(msk);
+	ssock = msk->subflow;
 	pr_debug("msk=%p, subflow=%p", msk, ssock);
 	if (WARN_ON_ONCE(!ssock))
 		return -EINVAL;
@@ -3465,14 +3493,16 @@ bool mptcp_finish_join(struct sock *ssk)
 		return false;
 	}
 
-	if (!list_empty(&subflow->node))
-		goto out;
+	/* active subflow, already present inside the conn_list */
+	if (!list_empty(&subflow->node)) {
+		mptcp_subflow_joined(msk, ssk);
+		return true;
+	}
 
 	if (!mptcp_pm_allow_new_subflow(msk))
 		goto err_prohibited;
 
-	/* active connections are already on conn_list.
-	 * If we can't acquire msk socket lock here, let the release callback
+	/* If we can't acquire msk socket lock here, let the release callback
 	 * handle it
 	 */
 	mptcp_data_lock(parent);
@@ -3495,11 +3525,6 @@ bool mptcp_finish_join(struct sock *ssk)
 		return false;
 	}
 
-	subflow->map_seq = READ_ONCE(msk->ack_seq);
-	WRITE_ONCE(msk->allow_infinite_fallback, false);
-
-out:
-	mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);
 	return true;
 }
 
@@ -3617,9 +3642,9 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	 * acquired the subflow socket lock, too.
 	 */
 	if (msk->fastopening)
-		err = __inet_stream_connect(ssock, uaddr, addr_len, msk->connect_flags, 1);
+		err = __inet_stream_connect(ssock, uaddr, addr_len, O_NONBLOCK, 1);
 	else
-		err = inet_stream_connect(ssock, uaddr, addr_len, msk->connect_flags);
+		err = inet_stream_connect(ssock, uaddr, addr_len, O_NONBLOCK);
 	inet_sk(sk)->defer_connect = inet_sk(ssock->sk)->defer_connect;
 
 	/* on successful connect, the msk state will be moved to established by
@@ -3632,12 +3657,10 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 
 	mptcp_copy_inaddrs(sk, ssock->sk);
 
-	/* unblocking connect, mptcp-level inet_stream_connect will error out
-	 * without changing the socket state, update it here.
+	/* silence EINPROGRESS and let the caller inet_stream_connect
+	 * handle the connection in progress
 	 */
-	if (err == -EINPROGRESS)
-		sk->sk_socket->state = ssock->state;
-	return err;
+	return 0;
 }
 
 static struct proto mptcp_prot = {
@@ -3696,18 +3719,6 @@ static int mptcp_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	return err;
 }
 
-static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
-				int addr_len, int flags)
-{
-	int ret;
-
-	lock_sock(sock->sk);
-	mptcp_sk(sock->sk)->connect_flags = flags;
-	ret = __inet_stream_connect(sock, uaddr, addr_len, flags, 0);
-	release_sock(sock->sk);
-	return ret;
-}
-
 static int mptcp_listen(struct socket *sock, int backlog)
 {
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
@@ -3746,7 +3757,10 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 
 	pr_debug("msk=%p", msk);
 
-	ssock = __mptcp_nmpc_socket(msk);
+	/* Buggy applications can call accept on socket states other then LISTEN
+	 * but no need to allocate the first subflow just to error out.
+	 */
+	ssock = READ_ONCE(msk->subflow);
 	if (!ssock)
 		return -EINVAL;
 
@@ -3791,9 +3805,6 @@ static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
 
-	if (unlikely(sk->sk_shutdown & SEND_SHUTDOWN))
-		return EPOLLOUT | EPOLLWRNORM;
-
 	if (sk_stream_is_writeable(sk))
 		return EPOLLOUT | EPOLLWRNORM;
 
@@ -3811,6 +3822,7 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	struct sock *sk = sock->sk;
 	struct mptcp_sock *msk;
 	__poll_t mask = 0;
+	u8 shutdown;
 	int state;
 
 	msk = mptcp_sk(sk);
@@ -3819,23 +3831,30 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	state = inet_sk_state_load(sk);
 	pr_debug("msk=%p state=%d flags=%lx", msk, state, msk->flags);
 	if (state == TCP_LISTEN) {
-		if (WARN_ON_ONCE(!msk->subflow || !msk->subflow->sk))
+		struct socket *ssock = READ_ONCE(msk->subflow);
+
+		if (WARN_ON_ONCE(!ssock || !ssock->sk))
 			return 0;
 
-		return inet_csk_listen_poll(msk->subflow->sk);
+		return inet_csk_listen_poll(ssock->sk);
 	}
 
+	shutdown = READ_ONCE(sk->sk_shutdown);
+	if (shutdown == SHUTDOWN_MASK || state == TCP_CLOSE)
+		mask |= EPOLLHUP;
+	if (shutdown & RCV_SHUTDOWN)
+		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
+
 	if (state != TCP_SYN_SENT && state != TCP_SYN_RECV) {
 		mask |= mptcp_check_readable(msk);
-		mask |= mptcp_check_writeable(msk);
+		if (shutdown & SEND_SHUTDOWN)
+			mask |= EPOLLOUT | EPOLLWRNORM;
+		else
+			mask |= mptcp_check_writeable(msk);
 	} else if (state == TCP_SYN_SENT && inet_sk(sk)->defer_connect) {
 		/* cf tcp_poll() note about TFO */
 		mask |= EPOLLOUT | EPOLLWRNORM;
 	}
-	if (sk->sk_shutdown == SHUTDOWN_MASK || state == TCP_CLOSE)
-		mask |= EPOLLHUP;
-	if (sk->sk_shutdown & RCV_SHUTDOWN)
-		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 
 	/* This barrier is coupled with smp_wmb() in __mptcp_error_report() */
 	smp_rmb();
@@ -3850,7 +3869,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.owner		   = THIS_MODULE,
 	.release	   = inet_release,
 	.bind		   = mptcp_bind,
-	.connect	   = mptcp_stream_connect,
+	.connect	   = inet_stream_connect,
 	.socketpair	   = sock_no_socketpair,
 	.accept		   = mptcp_stream_accept,
 	.getname	   = inet_getname,
@@ -3945,7 +3964,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.owner		   = THIS_MODULE,
 	.release	   = inet6_release,
 	.bind		   = mptcp_bind,
-	.connect	   = mptcp_stream_connect,
+	.connect	   = inet_stream_connect,
 	.socketpair	   = sock_no_socketpair,
 	.accept		   = mptcp_stream_accept,
 	.getname	   = inet6_getname,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 441feeaeb242..55fc5e42082e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -288,7 +288,6 @@ struct mptcp_sock {
 			nodelay:1,
 			fastopening:1,
 			in_accept_queue:1;
-	int		connect_flags;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
@@ -297,7 +296,11 @@ struct mptcp_sock {
 	struct list_head rtx_queue;
 	struct mptcp_data_frag *first_pending;
 	struct list_head join_list;
-	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
+	struct socket	*subflow; /* outgoing connect/listener/!mp_capable
+				   * The mptcp ops can safely dereference, using suitable
+				   * ONCE annotation, the subflow outside the socket
+				   * lock as such sock is freed after close().
+				   */
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
 	struct {
@@ -602,7 +605,6 @@ int mptcp_is_checksum_enabled(const struct net *net);
 int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
 int mptcp_get_pm_type(const struct net *net);
-void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool __mptcp_retransmit_pending_data(struct sock *sk);
@@ -671,9 +673,10 @@ void __init mptcp_proto_init(void);
 int __init mptcp_proto_v6_init(void);
 #endif
 
-struct sock *mptcp_sk_clone(const struct sock *sk,
-			    const struct mptcp_options_received *mp_opt,
-			    struct request_sock *req);
+struct sock *mptcp_sk_clone_init(const struct sock *sk,
+				 const struct mptcp_options_received *mp_opt,
+				 struct sock *ssk,
+				 struct request_sock *req);
 void mptcp_get_options(const struct sk_buff *skb,
 		       struct mptcp_options_received *mp_opt);
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 67ddbf6f2e4e..336878f8a222 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -633,14 +633,6 @@ static bool subflow_hmac_valid(const struct request_sock *req,
 	return !crypto_memneq(hmac, mp_opt->hmac, MPTCPOPT_HMAC_LEN);
 }
 
-static void mptcp_force_close(struct sock *sk)
-{
-	/* the msk is not yet exposed to user-space, and refcount is 2 */
-	inet_sk_state_store(sk, TCP_CLOSE);
-	sk_common_release(sk);
-	sock_put(sk);
-}
-
 static void subflow_ulp_fallback(struct sock *sk,
 				 struct mptcp_subflow_context *old_ctx)
 {
@@ -693,7 +685,6 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	struct mptcp_subflow_request_sock *subflow_req;
 	struct mptcp_options_received mp_opt;
 	bool fallback, fallback_is_fatal;
-	struct sock *new_msk = NULL;
 	struct mptcp_sock *owner;
 	struct sock *child;
 
@@ -722,14 +713,9 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		 * options.
 		 */
 		mptcp_get_options(skb, &mp_opt);
-		if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPC)) {
+		if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPC))
 			fallback = true;
-			goto create_child;
-		}
 
-		new_msk = mptcp_sk_clone(listener->conn, &mp_opt, req);
-		if (!new_msk)
-			fallback = true;
 	} else if (subflow_req->mp_join) {
 		mptcp_get_options(skb, &mp_opt);
 		if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPJ) ||
@@ -758,47 +744,19 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 				subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
 				goto dispose_child;
 			}
-
-			if (new_msk)
-				mptcp_copy_inaddrs(new_msk, child);
-			mptcp_subflow_drop_ctx(child);
-			goto out;
+			goto fallback;
 		}
 
 		/* ssk inherits options of listener sk */
 		ctx->setsockopt_seq = listener->setsockopt_seq;
 
 		if (ctx->mp_capable) {
-			owner = mptcp_sk(new_msk);
-
-			/* this can't race with mptcp_close(), as the msk is
-			 * not yet exposted to user-space
-			 */
-			inet_sk_state_store((void *)new_msk, TCP_ESTABLISHED);
-
-			/* record the newly created socket as the first msk
-			 * subflow, but don't link it yet into conn_list
-			 */
-			WRITE_ONCE(owner->first, child);
+			ctx->conn = mptcp_sk_clone_init(listener->conn, &mp_opt, child, req);
+			if (!ctx->conn)
+				goto fallback;
 
-			/* new mpc subflow takes ownership of the newly
-			 * created mptcp socket
-			 */
-			mptcp_sk(new_msk)->setsockopt_seq = ctx->setsockopt_seq;
+			owner = mptcp_sk(ctx->conn);
 			mptcp_pm_new_connection(owner, child, 1);
-			mptcp_token_accept(subflow_req, owner);
-			ctx->conn = new_msk;
-			new_msk = NULL;
-
-			/* set msk addresses early to ensure mptcp_pm_get_local_id()
-			 * uses the correct data
-			 */
-			mptcp_copy_inaddrs(ctx->conn, child);
-			mptcp_propagate_sndbuf(ctx->conn, child);
-
-			mptcp_rcv_space_init(owner, child);
-			list_add(&ctx->node, &owner->conn_list);
-			sock_hold(child);
 
 			/* with OoO packets we can reach here without ingress
 			 * mpc option
@@ -838,11 +796,6 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		}
 	}
 
-out:
-	/* dispose of the left over mptcp master, if any */
-	if (unlikely(new_msk))
-		mptcp_force_close(new_msk);
-
 	/* check for expected invariant - should never trigger, just help
 	 * catching eariler subtle bugs
 	 */
@@ -860,6 +813,10 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 	/* The last child reference will be released by the caller */
 	return child;
+
+fallback:
+	mptcp_subflow_drop_ctx(child);
+	return child;
 }
 
 static struct inet_connection_sock_af_ops subflow_specific __ro_after_init;
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 857cddd9d82e..9ee8abd3e4b1 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -2976,7 +2976,9 @@ static int ctnetlink_exp_dump_mask(struct sk_buff *skb,
 	return -1;
 }
 
+#if IS_ENABLED(CONFIG_NF_NAT)
 static const union nf_inet_addr any_addr;
+#endif
 
 static __be32 nf_expect_get_id(const struct nf_conntrack_expect *exp)
 {
@@ -3460,10 +3462,12 @@ ctnetlink_change_expect(struct nf_conntrack_expect *x,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_NF_NAT)
 static const struct nla_policy exp_nat_nla_policy[CTA_EXPECT_NAT_MAX+1] = {
 	[CTA_EXPECT_NAT_DIR]	= { .type = NLA_U32 },
 	[CTA_EXPECT_NAT_TUPLE]	= { .type = NLA_NESTED },
 };
+#endif
 
 static int
 ctnetlink_parse_expect_nat(const struct nlattr *attr,
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index d1b19618890b..6d493a0ccf39 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1768,7 +1768,7 @@ static int netlink_getsockopt(struct socket *sock, int level, int optname,
 				break;
 			}
 		}
-		if (put_user(ALIGN(nlk->ngroups / 8, sizeof(u32)), optlen))
+		if (put_user(ALIGN(BITS_TO_BYTES(nlk->ngroups), sizeof(u32)), optlen))
 			err = -EFAULT;
 		netlink_unlock_table();
 		return err;
diff --git a/net/netrom/nr_subr.c b/net/netrom/nr_subr.c
index 3f99b432ea70..e2d2af924cff 100644
--- a/net/netrom/nr_subr.c
+++ b/net/netrom/nr_subr.c
@@ -123,7 +123,7 @@ void nr_write_internal(struct sock *sk, int frametype)
 	unsigned char  *dptr;
 	int len, timeout;
 
-	len = NR_NETWORK_LEN + NR_TRANSPORT_LEN;
+	len = NR_TRANSPORT_LEN;
 
 	switch (frametype & 0x0F) {
 	case NR_CONNREQ:
@@ -141,7 +141,8 @@ void nr_write_internal(struct sock *sk, int frametype)
 		return;
 	}
 
-	if ((skb = alloc_skb(len, GFP_ATOMIC)) == NULL)
+	skb = alloc_skb(NR_NETWORK_LEN + len, GFP_ATOMIC);
+	if (!skb)
 		return;
 
 	/*
@@ -149,7 +150,7 @@ void nr_write_internal(struct sock *sk, int frametype)
 	 */
 	skb_reserve(skb, NR_NETWORK_LEN);
 
-	dptr = skb_put(skb, skb_tailroom(skb));
+	dptr = skb_put(skb, len);
 
 	switch (frametype & 0x0F) {
 	case NR_CONNREQ:
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 67771b0f5771..6ab9d5b54338 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3193,6 +3193,9 @@ static int packet_do_bind(struct sock *sk, const char *name, int ifindex,
 
 	lock_sock(sk);
 	spin_lock(&po->bind_lock);
+	if (!proto)
+		proto = po->num;
+
 	rcu_read_lock();
 
 	if (po->fanout) {
@@ -3291,7 +3294,7 @@ static int packet_bind_spkt(struct socket *sock, struct sockaddr *uaddr,
 	memcpy(name, uaddr->sa_data, sizeof(uaddr->sa_data));
 	name[sizeof(uaddr->sa_data)] = 0;
 
-	return packet_do_bind(sk, name, 0, pkt_sk(sk)->num);
+	return packet_do_bind(sk, name, 0, 0);
 }
 
 static int packet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
@@ -3308,8 +3311,7 @@ static int packet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len
 	if (sll->sll_family != AF_PACKET)
 		return -EINVAL;
 
-	return packet_do_bind(sk, NULL, sll->sll_ifindex,
-			      sll->sll_protocol ? : pkt_sk(sk)->num);
+	return packet_do_bind(sk, NULL, sll->sll_ifindex, sll->sll_protocol);
 }
 
 static struct proto packet_proto = {
diff --git a/net/packet/diag.c b/net/packet/diag.c
index d704c7bf51b2..a68a84574c73 100644
--- a/net/packet/diag.c
+++ b/net/packet/diag.c
@@ -143,7 +143,7 @@ static int sk_diag_fill(struct sock *sk, struct sk_buff *skb,
 	rp = nlmsg_data(nlh);
 	rp->pdiag_family = AF_PACKET;
 	rp->pdiag_type = sk->sk_type;
-	rp->pdiag_num = ntohs(po->num);
+	rp->pdiag_num = ntohs(READ_ONCE(po->num));
 	rp->pdiag_ino = sk_ino;
 	sock_diag_save_cookie(sk, rp->pdiag_cookie);
 
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 25bc57ee6ea1..3de72e7c1075 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -1147,6 +1147,9 @@ static int fl_set_geneve_opt(const struct nlattr *nla, struct fl_flow_key *key,
 	if (option_len > sizeof(struct geneve_opt))
 		data_len = option_len - sizeof(struct geneve_opt);
 
+	if (key->enc_opts.len > FLOW_DIS_TUN_OPTS_MAX - 4)
+		return -ERANGE;
+
 	opt = (struct geneve_opt *)&key->enc_opts.data[key->enc_opts.len];
 	memset(opt, 0xff, option_len);
 	opt->length = data_len / 4;
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index c82532e20699..f6a7b876d595 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1241,7 +1241,12 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 	sch->parent = parent;
 
 	if (handle == TC_H_INGRESS) {
-		sch->flags |= TCQ_F_INGRESS;
+		if (!(sch->flags & TCQ_F_INGRESS)) {
+			NL_SET_ERR_MSG(extack,
+				       "Specified parent ID is reserved for ingress and clsact Qdiscs");
+			err = -EINVAL;
+			goto err_out3;
+		}
 		handle = TC_H_MAKE(TC_H_INGRESS, 0);
 	} else {
 		if (handle == 0) {
@@ -1586,11 +1591,20 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 					NL_SET_ERR_MSG(extack, "Invalid qdisc name");
 					return -EINVAL;
 				}
+				if (q->flags & TCQ_F_INGRESS) {
+					NL_SET_ERR_MSG(extack,
+						       "Cannot regraft ingress or clsact Qdiscs");
+					return -EINVAL;
+				}
 				if (q == p ||
 				    (p && check_loop(q, p, 0))) {
 					NL_SET_ERR_MSG(extack, "Qdisc parent/child loop detected");
 					return -ELOOP;
 				}
+				if (clid == TC_H_INGRESS) {
+					NL_SET_ERR_MSG(extack, "Ingress cannot graft directly");
+					return -EINVAL;
+				}
 				qdisc_refcount_inc(q);
 				goto graft;
 			} else {
diff --git a/net/sched/sch_ingress.c b/net/sched/sch_ingress.c
index 84838128b9c5..e43a45499372 100644
--- a/net/sched/sch_ingress.c
+++ b/net/sched/sch_ingress.c
@@ -80,6 +80,9 @@ static int ingress_init(struct Qdisc *sch, struct nlattr *opt,
 	struct net_device *dev = qdisc_dev(sch);
 	int err;
 
+	if (sch->parent != TC_H_INGRESS)
+		return -EOPNOTSUPP;
+
 	net_inc_ingress_queue();
 
 	mini_qdisc_pair_init(&q->miniqp, sch, &dev->miniq_ingress);
@@ -101,6 +104,9 @@ static void ingress_destroy(struct Qdisc *sch)
 {
 	struct ingress_sched_data *q = qdisc_priv(sch);
 
+	if (sch->parent != TC_H_INGRESS)
+		return;
+
 	tcf_block_put_ext(q->block, sch, &q->block_info);
 	net_dec_ingress_queue();
 }
@@ -134,7 +140,7 @@ static struct Qdisc_ops ingress_qdisc_ops __read_mostly = {
 	.cl_ops			=	&ingress_class_ops,
 	.id			=	"ingress",
 	.priv_size		=	sizeof(struct ingress_sched_data),
-	.static_flags		=	TCQ_F_CPUSTATS,
+	.static_flags		=	TCQ_F_INGRESS | TCQ_F_CPUSTATS,
 	.init			=	ingress_init,
 	.destroy		=	ingress_destroy,
 	.dump			=	ingress_dump,
@@ -219,6 +225,9 @@ static int clsact_init(struct Qdisc *sch, struct nlattr *opt,
 	struct net_device *dev = qdisc_dev(sch);
 	int err;
 
+	if (sch->parent != TC_H_CLSACT)
+		return -EOPNOTSUPP;
+
 	net_inc_ingress_queue();
 	net_inc_egress_queue();
 
@@ -248,6 +257,9 @@ static void clsact_destroy(struct Qdisc *sch)
 {
 	struct clsact_sched_data *q = qdisc_priv(sch);
 
+	if (sch->parent != TC_H_CLSACT)
+		return;
+
 	tcf_block_put_ext(q->egress_block, sch, &q->egress_block_info);
 	tcf_block_put_ext(q->ingress_block, sch, &q->ingress_block_info);
 
@@ -269,7 +281,7 @@ static struct Qdisc_ops clsact_qdisc_ops __read_mostly = {
 	.cl_ops			=	&clsact_class_ops,
 	.id			=	"clsact",
 	.priv_size		=	sizeof(struct clsact_sched_data),
-	.static_flags		=	TCQ_F_CPUSTATS,
+	.static_flags		=	TCQ_F_INGRESS | TCQ_F_CPUSTATS,
 	.init			=	clsact_init,
 	.destroy		=	clsact_destroy,
 	.dump			=	ingress_dump,
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 524649d0ab65..3008dfdf7c55 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -578,7 +578,10 @@ static struct smc_buf_desc *smc_llc_get_next_rmb(struct smc_link_group *lgr,
 {
 	struct smc_buf_desc *buf_next;
 
-	if (!buf_pos || list_is_last(&buf_pos->list, &lgr->rmbs[*buf_lst])) {
+	if (!buf_pos)
+		return _smc_llc_get_next_rmb(lgr, buf_lst);
+
+	if (list_is_last(&buf_pos->list, &lgr->rmbs[*buf_lst])) {
 		(*buf_lst)++;
 		return _smc_llc_get_next_rmb(lgr, buf_lst);
 	}
@@ -614,6 +617,8 @@ static int smc_llc_fill_ext_v2(struct smc_llc_msg_add_link_v2_ext *ext,
 		goto out;
 	buf_pos = smc_llc_get_first_rmb(lgr, &buf_lst);
 	for (i = 0; i < ext->num_rkeys; i++) {
+		while (buf_pos && !(buf_pos)->used)
+			buf_pos = smc_llc_get_next_rmb(lgr, &buf_lst, buf_pos);
 		if (!buf_pos)
 			break;
 		rmb = buf_pos;
@@ -623,8 +628,6 @@ static int smc_llc_fill_ext_v2(struct smc_llc_msg_add_link_v2_ext *ext,
 			cpu_to_be64((uintptr_t)rmb->cpu_addr) :
 			cpu_to_be64((u64)sg_dma_address(rmb->sgt[lnk_idx].sgl));
 		buf_pos = smc_llc_get_next_rmb(lgr, &buf_lst, buf_pos);
-		while (buf_pos && !(buf_pos)->used)
-			buf_pos = smc_llc_get_next_rmb(lgr, &buf_lst, buf_pos);
 	}
 	len += i * sizeof(ext->rt[0]);
 out:
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 7107fbcbff34..d808c00cdbac 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1338,25 +1338,10 @@ static struct svc_sock *svc_setup_socket(struct svc_serv *serv,
 	return svsk;
 }
 
-bool svc_alien_sock(struct net *net, int fd)
-{
-	int err;
-	struct socket *sock = sockfd_lookup(fd, &err);
-	bool ret = false;
-
-	if (!sock)
-		goto out;
-	if (sock_net(sock->sk) != net)
-		ret = true;
-	sockfd_put(sock);
-out:
-	return ret;
-}
-EXPORT_SYMBOL_GPL(svc_alien_sock);
-
 /**
  * svc_addsock - add a listener socket to an RPC service
  * @serv: pointer to RPC service to which to add a new listener
+ * @net: caller's network namespace
  * @fd: file descriptor of the new listener
  * @name_return: pointer to buffer to fill in with name of listener
  * @len: size of the buffer
@@ -1366,8 +1351,8 @@ EXPORT_SYMBOL_GPL(svc_alien_sock);
  * Name is terminated with '\n'.  On error, returns a negative errno
  * value.
  */
-int svc_addsock(struct svc_serv *serv, const int fd, char *name_return,
-		const size_t len, const struct cred *cred)
+int svc_addsock(struct svc_serv *serv, struct net *net, const int fd,
+		char *name_return, const size_t len, const struct cred *cred)
 {
 	int err = 0;
 	struct socket *so = sockfd_lookup(fd, &err);
@@ -1378,6 +1363,9 @@ int svc_addsock(struct svc_serv *serv, const int fd, char *name_return,
 
 	if (!so)
 		return err;
+	err = -EINVAL;
+	if (sock_net(so->sk) != net)
+		goto out;
 	err = -EAFNOSUPPORT;
 	if ((so->sk->sk_family != PF_INET) && (so->sk->sk_family != PF_INET6))
 		goto out;
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index da95abbb7ea3..f37f4a0fcd3c 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -20,7 +20,9 @@ static void tls_strp_abort_strp(struct tls_strparser *strp, int err)
 	strp->stopped = 1;
 
 	/* Report an error on the lower socket */
-	strp->sk->sk_err = -err;
+	WRITE_ONCE(strp->sk->sk_err, -err);
+	/* Paired with smp_rmb() in tcp_poll() */
+	smp_wmb();
 	sk_error_report(strp->sk);
 }
 
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 992092aeebad..96b4545ea700 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -67,7 +67,9 @@ noinline void tls_err_abort(struct sock *sk, int err)
 {
 	WARN_ON_ONCE(err >= 0);
 	/* sk->sk_err should contain a positive error code. */
-	sk->sk_err = -err;
+	WRITE_ONCE(sk->sk_err, -err);
+	/* Paired with smp_rmb() in tcp_poll() */
+	smp_wmb();
 	sk_error_report(sk);
 }
 
@@ -2287,8 +2289,12 @@ static void tls_data_ready(struct sock *sk)
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
 	struct sk_psock *psock;
+	gfp_t alloc_save;
 
+	alloc_save = sk->sk_allocation;
+	sk->sk_allocation = GFP_ATOMIC;
 	tls_strp_data_ready(&ctx->strp);
+	sk->sk_allocation = alloc_save;
 
 	psock = sk_psock_get(sk);
 	if (psock) {
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index bc04cb83215f..e894c269affb 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3237,7 +3237,7 @@ xfrm_secpath_reject(int idx, struct sk_buff *skb, const struct flowi *fl)
 
 static inline int
 xfrm_state_ok(const struct xfrm_tmpl *tmpl, const struct xfrm_state *x,
-	      unsigned short family)
+	      unsigned short family, u32 if_id)
 {
 	if (xfrm_state_kern(x))
 		return tmpl->optional && !xfrm_state_addr_cmp(tmpl, x, tmpl->encap_family);
@@ -3248,7 +3248,8 @@ xfrm_state_ok(const struct xfrm_tmpl *tmpl, const struct xfrm_state *x,
 		(tmpl->allalgs || (tmpl->aalgos & (1<<x->props.aalgo)) ||
 		 !(xfrm_id_proto_match(tmpl->id.proto, IPSEC_PROTO_ANY))) &&
 		!(x->props.mode != XFRM_MODE_TRANSPORT &&
-		  xfrm_state_addr_cmp(tmpl, x, family));
+		  xfrm_state_addr_cmp(tmpl, x, family)) &&
+		(if_id == 0 || if_id == x->if_id);
 }
 
 /*
@@ -3260,7 +3261,7 @@ xfrm_state_ok(const struct xfrm_tmpl *tmpl, const struct xfrm_state *x,
  */
 static inline int
 xfrm_policy_ok(const struct xfrm_tmpl *tmpl, const struct sec_path *sp, int start,
-	       unsigned short family)
+	       unsigned short family, u32 if_id)
 {
 	int idx = start;
 
@@ -3270,7 +3271,7 @@ xfrm_policy_ok(const struct xfrm_tmpl *tmpl, const struct sec_path *sp, int star
 	} else
 		start = -1;
 	for (; idx < sp->len; idx++) {
-		if (xfrm_state_ok(tmpl, sp->xvec[idx], family))
+		if (xfrm_state_ok(tmpl, sp->xvec[idx], family, if_id))
 			return ++idx;
 		if (sp->xvec[idx]->props.mode != XFRM_MODE_TRANSPORT) {
 			if (start == -1)
@@ -3649,7 +3650,7 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 		 * are implied between each two transformations.
 		 */
 		for (i = xfrm_nr-1, k = 0; i >= 0; i--) {
-			k = xfrm_policy_ok(tpp[i], sp, k, family);
+			k = xfrm_policy_ok(tpp[i], sp, k, family, if_id);
 			if (k < 0) {
 				if (k < -1)
 					/* "-2 - errored_index" returned */
diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index 0aecf9334ec3..8b21520bd4b9 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -26,5 +26,9 @@ quiet_cmd_flask = GEN     $(obj)/flask.h $(obj)/av_permissions.h
       cmd_flask = $< $(obj)/flask.h $(obj)/av_permissions.h
 
 targets += flask.h av_permissions.h
-$(obj)/flask.h $(obj)/av_permissions.h &: scripts/selinux/genheaders/genheaders FORCE
+# once make >= 4.3 is required, we can use grouped targets in the rule below,
+# which basically involves adding both headers and a '&' before the colon, see
+# the example below:
+#   $(obj)/flask.h $(obj)/av_permissions.h &: scripts/selinux/...
+$(obj)/flask.h: scripts/selinux/genheaders/genheaders FORCE
 	$(call if_changed,flask)
diff --git a/sound/core/oss/pcm_plugin.h b/sound/core/oss/pcm_plugin.h
index 46e273bd4a78..50a6b50f5db4 100644
--- a/sound/core/oss/pcm_plugin.h
+++ b/sound/core/oss/pcm_plugin.h
@@ -141,6 +141,14 @@ int snd_pcm_area_copy(const struct snd_pcm_channel_area *src_channel,
 
 void *snd_pcm_plug_buf_alloc(struct snd_pcm_substream *plug, snd_pcm_uframes_t size);
 void snd_pcm_plug_buf_unlock(struct snd_pcm_substream *plug, void *ptr);
+#else
+
+static inline snd_pcm_sframes_t snd_pcm_plug_client_size(struct snd_pcm_substream *handle, snd_pcm_uframes_t drv_size) { return drv_size; }
+static inline snd_pcm_sframes_t snd_pcm_plug_slave_size(struct snd_pcm_substream *handle, snd_pcm_uframes_t clt_size) { return clt_size; }
+static inline int snd_pcm_plug_slave_format(int format, const struct snd_mask *format_mask) { return format; }
+
+#endif
+
 snd_pcm_sframes_t snd_pcm_oss_write3(struct snd_pcm_substream *substream,
 				     const char *ptr, snd_pcm_uframes_t size,
 				     int in_kernel);
@@ -151,14 +159,6 @@ snd_pcm_sframes_t snd_pcm_oss_writev3(struct snd_pcm_substream *substream,
 snd_pcm_sframes_t snd_pcm_oss_readv3(struct snd_pcm_substream *substream,
 				     void **bufs, snd_pcm_uframes_t frames);
 
-#else
-
-static inline snd_pcm_sframes_t snd_pcm_plug_client_size(struct snd_pcm_substream *handle, snd_pcm_uframes_t drv_size) { return drv_size; }
-static inline snd_pcm_sframes_t snd_pcm_plug_slave_size(struct snd_pcm_substream *handle, snd_pcm_uframes_t clt_size) { return clt_size; }
-static inline int snd_pcm_plug_slave_format(int format, const struct snd_mask *format_mask) { return format; }
-
-#endif
-
 #ifdef PLUGIN_DEBUG
 #define pdprintf(fmt, args...) printk(KERN_DEBUG "plugin: " fmt, ##args)
 #else
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 881b2f3a1551..3226691ac923 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -227,6 +227,7 @@ enum {
 	AZX_DRIVER_ATI,
 	AZX_DRIVER_ATIHDMI,
 	AZX_DRIVER_ATIHDMI_NS,
+	AZX_DRIVER_GFHDMI,
 	AZX_DRIVER_VIA,
 	AZX_DRIVER_SIS,
 	AZX_DRIVER_ULI,
@@ -349,6 +350,7 @@ static const char * const driver_short_names[] = {
 	[AZX_DRIVER_ATI] = "HDA ATI SB",
 	[AZX_DRIVER_ATIHDMI] = "HDA ATI HDMI",
 	[AZX_DRIVER_ATIHDMI_NS] = "HDA ATI HDMI",
+	[AZX_DRIVER_GFHDMI] = "HDA GF HDMI",
 	[AZX_DRIVER_VIA] = "HDA VIA VT82xx",
 	[AZX_DRIVER_SIS] = "HDA SIS966",
 	[AZX_DRIVER_ULI] = "HDA ULI M5461",
@@ -1743,6 +1745,12 @@ static int default_bdl_pos_adj(struct azx *chip)
 	}
 
 	switch (chip->driver_type) {
+	/*
+	 * increase the bdl size for Glenfly Gpus for hardware
+	 * limitation on hdac interrupt interval
+	 */
+	case AZX_DRIVER_GFHDMI:
+		return 128;
 	case AZX_DRIVER_ICH:
 	case AZX_DRIVER_PCH:
 		return 1;
@@ -1858,6 +1866,12 @@ static int azx_first_init(struct azx *chip)
 		pci_write_config_dword(pci, PCI_BASE_ADDRESS_1, 0);
 	}
 #endif
+	/*
+	 * Fix response write request not synced to memory when handle
+	 * hdac interrupt on Glenfly Gpus
+	 */
+	if (chip->driver_type == AZX_DRIVER_GFHDMI)
+		bus->polling_mode = 1;
 
 	err = pcim_iomap_regions(pci, 1 << 0, "ICH HD audio");
 	if (err < 0)
@@ -1959,6 +1973,7 @@ static int azx_first_init(struct azx *chip)
 			chip->playback_streams = ATIHDMI_NUM_PLAYBACK;
 			chip->capture_streams = ATIHDMI_NUM_CAPTURE;
 			break;
+		case AZX_DRIVER_GFHDMI:
 		case AZX_DRIVER_GENERIC:
 		default:
 			chip->playback_streams = ICH6_NUM_PLAYBACK;
@@ -2727,6 +2742,12 @@ static const struct pci_device_id azx_ids[] = {
 	{ PCI_DEVICE(0x1002, 0xab38),
 	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
 	  AZX_DCAPS_PM_RUNTIME },
+	/* GLENFLY */
+	{ PCI_DEVICE(0x6766, PCI_ANY_ID),
+	  .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
+	  .class_mask = 0xffffff,
+	  .driver_data = AZX_DRIVER_GFHDMI | AZX_DCAPS_POSFIX_LPIB |
+	  AZX_DCAPS_NO_MSI | AZX_DCAPS_NO_64BIT },
 	/* VIA VT8251/VT8237A */
 	{ PCI_DEVICE(0x1106, 0x3288), .driver_data = AZX_DRIVER_VIA },
 	/* VIA GFX VT7122/VX900 */
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index be2c6cff7701..7b5e09070ab9 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -4489,6 +4489,22 @@ static int patch_via_hdmi(struct hda_codec *codec)
 	return patch_simple_hdmi(codec, VIAHDMI_CVT_NID, VIAHDMI_PIN_NID);
 }
 
+static int patch_gf_hdmi(struct hda_codec *codec)
+{
+	int err;
+
+	err = patch_generic_hdmi(codec);
+	if (err)
+		return err;
+
+	/*
+	 * Glenfly GPUs have two codecs, stream switches from one codec to
+	 * another, need to do actual clean-ups in codec_cleanup_stream
+	 */
+	codec->no_sticky_stream = 1;
+	return 0;
+}
+
 /*
  * patch entries
  */
@@ -4584,6 +4600,12 @@ HDA_CODEC_ENTRY(0x10de00a6, "GPU a6 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de00a7, "GPU a7 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de8001, "MCP73 HDMI",	patch_nvhdmi_2ch),
 HDA_CODEC_ENTRY(0x10de8067, "MCP67/68 HDMI",	patch_nvhdmi_2ch),
+HDA_CODEC_ENTRY(0x67663d82, "Arise 82 HDMI/DP",	patch_gf_hdmi),
+HDA_CODEC_ENTRY(0x67663d83, "Arise 83 HDMI/DP",	patch_gf_hdmi),
+HDA_CODEC_ENTRY(0x67663d84, "Arise 84 HDMI/DP",	patch_gf_hdmi),
+HDA_CODEC_ENTRY(0x67663d85, "Arise 85 HDMI/DP",	patch_gf_hdmi),
+HDA_CODEC_ENTRY(0x67663d86, "Arise 86 HDMI/DP",	patch_gf_hdmi),
+HDA_CODEC_ENTRY(0x67663d87, "Arise 87 HDMI/DP",	patch_gf_hdmi),
 HDA_CODEC_ENTRY(0x11069f80, "VX900 HDMI/DP",	patch_via_hdmi),
 HDA_CODEC_ENTRY(0x11069f81, "VX900 HDMI/DP",	patch_via_hdmi),
 HDA_CODEC_ENTRY(0x11069f84, "VX11 HDMI/DP",	patch_generic_hdmi),
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 379f216158ab..7b5f194513c7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7063,6 +7063,8 @@ enum {
 	ALC225_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC295_FIXUP_DISABLE_DAC3,
 	ALC285_FIXUP_SPEAKER2_TO_DAC1,
+	ALC285_FIXUP_ASUS_SPEAKER2_TO_DAC1,
+	ALC285_FIXUP_ASUS_HEADSET_MIC,
 	ALC280_FIXUP_HP_HEADSET_MIC,
 	ALC221_FIXUP_HP_FRONT_MIC,
 	ALC292_FIXUP_TPT460,
@@ -8033,6 +8035,22 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_THINKPAD_ACPI
 	},
+	[ALC285_FIXUP_ASUS_SPEAKER2_TO_DAC1] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc285_fixup_speaker2_to_dac1,
+		.chained = true,
+		.chain_id = ALC245_FIXUP_CS35L41_SPI_2
+	},
+	[ALC285_FIXUP_ASUS_HEADSET_MIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x03a11050 },
+			{ 0x1b, 0x03a11c30 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC285_FIXUP_ASUS_SPEAKER2_TO_DAC1
+	},
 	[ALC256_FIXUP_DELL_INSPIRON_7559_SUBWOOFER] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -9507,6 +9525,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1313, "Asus K42JZ", ALC269VB_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
+	SND_PCI_QUIRK(0x1043, 0x1473, "ASUS GU604V", ALC285_FIXUP_ASUS_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1043, 0x1483, "ASUS GU603V", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x1662, "ASUS GV301QH", ALC294_FIXUP_ASUS_DUAL_SPK),
 	SND_PCI_QUIRK(0x1043, 0x1683, "ASUS UM3402YAR", ALC287_FIXUP_CS35L41_I2C_2),
diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index b9958e555367..84b401b685f7 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -297,6 +297,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8A22"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "System76"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "pang12"),
+		}
+	},
 	{}
 };
 
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index cbbe83b85ada..cf7927222be1 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -53,6 +53,18 @@ static const struct reg_default ssm2602_reg[SSM2602_CACHEREGNUM] = {
 	{ .reg = 0x09, .def = 0x0000 }
 };
 
+/*
+ * ssm2602 register patch
+ * Workaround for playback distortions after power up: activates digital
+ * core, and then powers on output, DAC, and whole chip at the same time
+ */
+
+static const struct reg_sequence ssm2602_patch[] = {
+	{ SSM2602_ACTIVE, 0x01 },
+	{ SSM2602_PWR,    0x07 },
+	{ SSM2602_RESET,  0x00 },
+};
+
 
 /*Appending several "None"s just for OSS mixer use*/
 static const char *ssm2602_input_select[] = {
@@ -589,6 +601,9 @@ static int ssm260x_component_probe(struct snd_soc_component *component)
 		return ret;
 	}
 
+	regmap_register_patch(ssm2602->regmap, ssm2602_patch,
+			      ARRAY_SIZE(ssm2602_patch));
+
 	/* set the update bits */
 	regmap_update_bits(ssm2602->regmap, SSM2602_LINVOL,
 			    LINVOL_LRIN_BOTH, LINVOL_LRIN_BOTH);
diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index 7f7dd07c63b2..3496301582b2 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -132,13 +132,13 @@ static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
 
 		/* Error Handling: TX */
 		if (isr[i] & ISR_TXFO) {
-			dev_err(dev->dev, "TX overrun (ch_id=%d)\n", i);
+			dev_err_ratelimited(dev->dev, "TX overrun (ch_id=%d)\n", i);
 			irq_valid = true;
 		}
 
 		/* Error Handling: TX */
 		if (isr[i] & ISR_RXFO) {
-			dev_err(dev->dev, "RX overrun (ch_id=%d)\n", i);
+			dev_err_ratelimited(dev->dev, "RX overrun (ch_id=%d)\n", i);
 			irq_valid = true;
 		}
 	}
diff --git a/sound/soc/intel/common/soc-acpi-intel-cht-match.c b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
index 6beb00858c33..cdcbf04b8832 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cht-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
@@ -50,6 +50,31 @@ static struct snd_soc_acpi_mach *cht_quirk(void *arg)
 		return mach;
 }
 
+/*
+ * Some tablets with Android factory OS have buggy DSDTs with an ESSX8316 device
+ * in the ACPI tables. While they are not using an ESS8316 codec. These DSDTs
+ * also have an ACPI device for the correct codec, ignore the ESSX8316.
+ */
+static const struct dmi_system_id cht_ess8316_not_present_table[] = {
+	{
+		/* Nextbook Ares 8A */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "CherryTrail"),
+			DMI_MATCH(DMI_BIOS_VERSION, "M882"),
+		},
+	},
+	{ }
+};
+
+static struct snd_soc_acpi_mach *cht_ess8316_quirk(void *arg)
+{
+	if (dmi_check_system(cht_ess8316_not_present_table))
+		return NULL;
+
+	return arg;
+}
+
 static const struct snd_soc_acpi_codecs rt5640_comp_ids = {
 	.num_codecs = 2,
 	.codecs = { "10EC5640", "10EC3276" },
@@ -113,6 +138,7 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "bytcht_es8316",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcht_es8316",
+		.machine_quirk = cht_ess8316_quirk,
 		.sof_tplg_filename = "sof-cht-es8316.tplg",
 	},
 	/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
diff --git a/sound/soc/sof/debug.c b/sound/soc/sof/debug.c
index ade0507328af..5042312b1b98 100644
--- a/sound/soc/sof/debug.c
+++ b/sound/soc/sof/debug.c
@@ -437,8 +437,8 @@ void snd_sof_handle_fw_exception(struct snd_sof_dev *sdev, const char *msg)
 		/* should we prevent DSP entering D3 ? */
 		if (!sdev->ipc_dump_printed)
 			dev_info(sdev->dev,
-				 "preventing DSP entering D3 state to preserve context\n");
-		pm_runtime_get_noresume(sdev->dev);
+				 "Attempting to prevent DSP from entering D3 state to preserve context\n");
+		pm_runtime_get_if_in_use(sdev->dev);
 	}
 
 	/* dump vital information to the logs */
diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index 14571b821eca..be6f38af37b5 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -619,16 +619,17 @@ static int sof_pcm_probe(struct snd_soc_component *component)
 				       "%s/%s",
 				       plat_data->tplg_filename_prefix,
 				       plat_data->tplg_filename);
-	if (!tplg_filename)
-		return -ENOMEM;
+	if (!tplg_filename) {
+		ret = -ENOMEM;
+		goto pm_error;
+	}
 
 	ret = snd_sof_load_topology(component, tplg_filename);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(component->dev, "error: failed to load DSP topology %d\n",
 			ret);
-		return ret;
-	}
 
+pm_error:
 	pm_runtime_mark_last_busy(component->dev);
 	pm_runtime_put_autosuspend(component->dev);
 
diff --git a/sound/soc/sof/pm.c b/sound/soc/sof/pm.c
index 26ffcbb6e30f..a1bfa5a37e2a 100644
--- a/sound/soc/sof/pm.c
+++ b/sound/soc/sof/pm.c
@@ -159,7 +159,7 @@ static int sof_resume(struct device *dev, bool runtime_resume)
 		ret = tplg_ops->set_up_all_pipelines(sdev, false);
 		if (ret < 0) {
 			dev_err(sdev->dev, "Failed to restore pipeline after resume %d\n", ret);
-			return ret;
+			goto setup_fail;
 		}
 	}
 
@@ -173,6 +173,18 @@ static int sof_resume(struct device *dev, bool runtime_resume)
 			dev_err(sdev->dev, "ctx_restore IPC error during resume: %d\n", ret);
 	}
 
+setup_fail:
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_ENABLE_DEBUGFS_CACHE)
+	if (ret < 0) {
+		/*
+		 * Debugfs cannot be read in runtime suspend, so cache
+		 * the contents upon failure. This allows to capture
+		 * possible DSP coredump information.
+		 */
+		sof_cache_debugfs(sdev);
+	}
+#endif
+
 	return ret;
 }
 
diff --git a/sound/soc/sof/sof-client-probes.c b/sound/soc/sof/sof-client-probes.c
index ddeabbb5580e..1e521a9e34d2 100644
--- a/sound/soc/sof/sof-client-probes.c
+++ b/sound/soc/sof/sof-client-probes.c
@@ -441,12 +441,7 @@ static ssize_t sof_probes_dfs_points_read(struct file *file, char __user *to,
 
 	ret = sof_probes_points_info(cdev, &desc, &num_desc);
 	if (ret < 0)
-		goto exit;
-
-	pm_runtime_mark_last_busy(dev);
-	err = pm_runtime_put_autosuspend(dev);
-	if (err < 0)
-		dev_err_ratelimited(dev, "debugfs read failed to idle %d\n", err);
+		goto pm_error;
 
 	for (i = 0; i < num_desc; i++) {
 		offset = strlen(buf);
@@ -464,6 +459,13 @@ static ssize_t sof_probes_dfs_points_read(struct file *file, char __user *to,
 	ret = simple_read_from_buffer(to, count, ppos, buf, strlen(buf));
 
 	kfree(desc);
+
+pm_error:
+	pm_runtime_mark_last_busy(dev);
+	err = pm_runtime_put_autosuspend(dev);
+	if (err < 0)
+		dev_err_ratelimited(dev, "debugfs read failed to idle %d\n", err);
+
 exit:
 	kfree(buf);
 	return ret;
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 4bc5b7cf3e04..1d40f9bcb63b 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -1175,7 +1175,7 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_BOOLEAN('b', "use-bpf", &ftrace.target.use_bpf,
 		    "Use BPF to measure function latency"),
 #endif
-	OPT_BOOLEAN('n', "--use-nsec", &ftrace.use_nsec,
+	OPT_BOOLEAN('n', "use-nsec", &ftrace.use_nsec,
 		    "Use nano-second histogram"),
 	OPT_PARENT(common_options),
 	};
diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 43a723626126..7b936a926859 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -9,7 +9,7 @@ TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
 
 TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq
 
-TEST_FILES := settings
+TEST_FILES := mptcp_lib.sh settings
 
 EXTRA_CLEAN := *.pcap
 
diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 515859a5168b..dd730a35bd12 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns="ns1-$rndh"
 ksft_skip=4
@@ -25,6 +27,8 @@ cleanup()
 	ip netns del $ns
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 621af6895f4d..c923ce5ff6eb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 time_start=$(date +%s)
 
 optstring="S:R:d:e:l:r:h4cm:f:tC"
@@ -141,6 +143,8 @@ cleanup()
 	done
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 76a197f7b813..c7da2bd7c328 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -6,6 +6,8 @@
 # address all other issues detected by shellcheck.
 #shellcheck disable=SC2086
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 ret=0
 sin=""
 sinfail=""
@@ -13,6 +15,7 @@ sout=""
 cin=""
 cinfail=""
 cinsent=""
+tmpfile=""
 cout=""
 capout=""
 ns1=""
@@ -127,6 +130,8 @@ cleanup_partial()
 
 check_tools()
 {
+	mptcp_lib_check_mptcp
+
 	if ! ip -Version &> /dev/null; then
 		echo "SKIP: Could not run test without ip tool"
 		exit $ksft_skip
@@ -164,6 +169,7 @@ cleanup()
 {
 	rm -f "$cin" "$cout" "$sinfail"
 	rm -f "$sin" "$sout" "$cinsent" "$cinfail"
+	rm -f "$tmpfile"
 	cleanup_partial
 }
 
@@ -358,9 +364,16 @@ check_transfer()
 			fail_test
 			return 1
 		fi
-		bytes="--bytes=${bytes}"
+
+		# note: BusyBox's "cmp" command doesn't support --bytes
+		tmpfile=$(mktemp)
+		head --bytes="$bytes" "$in" > "$tmpfile"
+		mv "$tmpfile" "$in"
+		head --bytes="$bytes" "$out" > "$tmpfile"
+		mv "$tmpfile" "$out"
+		tmpfile=""
 	fi
-	cmp -l "$in" "$out" ${bytes} | while read -r i a b; do
+	cmp -l "$in" "$out" | while read -r i a b; do
 		local sum=$((0${a} + 0${b}))
 		if [ $check_invert -eq 0 ] || [ $sum -ne $((0xff)) ]; then
 			echo "[ FAIL ] $what does not match (in, out):"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
new file mode 100644
index 000000000000..3286536b79d5
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -0,0 +1,40 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+readonly KSFT_FAIL=1
+readonly KSFT_SKIP=4
+
+# SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when validating all
+# features using the last version of the kernel and the selftests to make sure
+# a test is not being skipped by mistake.
+mptcp_lib_expect_all_features() {
+	[ "${SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES:-}" = "1" ]
+}
+
+# $1: msg
+mptcp_lib_fail_if_expected_feature() {
+	if mptcp_lib_expect_all_features; then
+		echo "ERROR: missing feature: ${*}"
+		exit ${KSFT_FAIL}
+	fi
+
+	return 1
+}
+
+# $1: file
+mptcp_lib_has_file() {
+	local f="${1}"
+
+	if [ -f "${f}" ]; then
+		return 0
+	fi
+
+	mptcp_lib_fail_if_expected_feature "${f} file not found"
+}
+
+mptcp_lib_check_mptcp() {
+	if ! mptcp_lib_has_file "/proc/sys/net/mptcp/enabled"; then
+		echo "SKIP: MPTCP support is not available"
+		exit ${KSFT_SKIP}
+	fi
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 80d36f7cfee8..08d8533c98c4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 ret=0
 sin=""
 sout=""
@@ -81,6 +83,8 @@ cleanup()
 	rm -f "$sin" "$sout"
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 89839d1ff9d8..32f7533e0919 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 ksft_skip=4
 ret=0
 
@@ -34,6 +36,8 @@ cleanup()
 	ip netns del $ns1
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 40aeb5a71a2a..4a417f9d51d6 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
@@ -33,6 +35,8 @@ cleanup()
 	done
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index ad6547c79b83..084a2b0a197e 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -1,6 +1,10 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Cannot not run test without ip tool"
