Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D522C72944F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241039AbjFIJG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241110AbjFIJFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:05:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F88173A;
        Fri,  9 Jun 2023 02:05:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70A7D60B89;
        Fri,  9 Jun 2023 09:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C95C433D2;
        Fri,  9 Jun 2023 09:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686301536;
        bh=uDxr3T5dZ5GaIC76JfU59HIU63CBCGlxtD8H7qC0LKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JnYa7AkzLJiDUsVUgBBOtM763aGHbLFh+o8tQqWkLnm/gOqc+9hSXnD2d0TzBw9Ss
         AXE/X6SGSqwgvJtt3T1yJtJ5mMApUMkMVaAlTbGyDCN0u3SliSzBJNhOchd1Ezt3N9
         4sbnrufWMW8+JyK2uC5pXExlO0VttivUdy+l7iAM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.183
Date:   Fri,  9 Jun 2023 11:05:24 +0200
Message-ID: <2023060923-culinary-luxury-59a1@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023060923-dab-moonrise-74ff@gregkh>
References: <2023060923-dab-moonrise-74ff@gregkh>
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

diff --git a/Documentation/devicetree/bindings/sound/tas2562.yaml b/Documentation/devicetree/bindings/sound/tas2562.yaml
index 27f7132ba2ef..6ccb346d4a4d 100644
--- a/Documentation/devicetree/bindings/sound/tas2562.yaml
+++ b/Documentation/devicetree/bindings/sound/tas2562.yaml
@@ -50,7 +50,9 @@ properties:
     description: TDM TX current sense time slot.
 
   '#sound-dai-cells':
-    const: 1
+    # The codec has a single DAI, the #sound-dai-cells=<1>; case is left in for backward
+    # compatibility but is deprecated.
+    enum: [0, 1]
 
 required:
   - compatible
@@ -67,7 +69,7 @@ examples:
      codec: codec@4c {
        compatible = "ti,tas2562";
        reg = <0x4c>;
-       #sound-dai-cells = <1>;
+       #sound-dai-cells = <0>;
        interrupt-parent = <&gpio1>;
        interrupts = <14>;
        shutdown-gpios = <&gpio1 15 0>;
diff --git a/Documentation/devicetree/bindings/sound/tas2764.yaml b/Documentation/devicetree/bindings/sound/tas2764.yaml
index 5bf8c76ecda1..1ffe1a01668f 100644
--- a/Documentation/devicetree/bindings/sound/tas2764.yaml
+++ b/Documentation/devicetree/bindings/sound/tas2764.yaml
@@ -46,7 +46,9 @@ properties:
     description: TDM TX voltage sense time slot.
 
   '#sound-dai-cells':
-    const: 1
+    # The codec has a single DAI, the #sound-dai-cells=<1>; case is left in for backward
+    # compatibility but is deprecated.
+    enum: [0, 1]
 
 required:
   - compatible
@@ -63,7 +65,7 @@ examples:
      codec: codec@38 {
        compatible = "ti,tas2764";
        reg = <0x38>;
-       #sound-dai-cells = <1>;
+       #sound-dai-cells = <0>;
        interrupt-parent = <&gpio1>;
        interrupts = <14>;
        reset-gpios = <&gpio1 15 0>;
diff --git a/Documentation/devicetree/bindings/sound/tas2770.yaml b/Documentation/devicetree/bindings/sound/tas2770.yaml
index 07e7f9951d2e..f3d0ca067bea 100644
--- a/Documentation/devicetree/bindings/sound/tas2770.yaml
+++ b/Documentation/devicetree/bindings/sound/tas2770.yaml
@@ -52,7 +52,9 @@ properties:
       - 1 # Falling edge
 
   '#sound-dai-cells':
-    const: 1
+    # The codec has a single DAI, the #sound-dai-cells=<1>; case is left in for backward
+    # compatibility but is deprecated.
+    enum: [0, 1]
 
 required:
   - compatible
@@ -69,7 +71,7 @@ examples:
      codec: codec@41 {
        compatible = "ti,tas2770";
        reg = <0x41>;
-       #sound-dai-cells = <1>;
+       #sound-dai-cells = <0>;
        interrupt-parent = <&gpio1>;
        interrupts = <14>;
        reset-gpio = <&gpio1 15 0>;
diff --git a/Makefile b/Makefile
index 2f0efde21902..28115681fffd 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 182
+SUBLEVEL = 183
 EXTRAVERSION =
 NAME = Dare mighty things
 
@@ -808,6 +808,10 @@ endif
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
 
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
+
+# These result in bogus false positives
+KBUILD_CFLAGS += $(call cc-disable-warning, dangling-pointer)
+
 ifdef CONFIG_FRAME_POINTER
 KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
 else
diff --git a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi b/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
index fe4cfda72a47..4e1b8b3359e2 100644
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
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index a611b0c1e540..07b7a2b76cb4 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -672,7 +672,6 @@ CONFIG_DRM_IMX_LDB=m
 CONFIG_DRM_IMX_HDMI=m
 CONFIG_DRM_ATMEL_HLCDC=m
 CONFIG_DRM_RCAR_DU=m
-CONFIG_DRM_RCAR_LVDS=y
 CONFIG_DRM_SUN4I=m
 CONFIG_DRM_MSM=m
 CONFIG_DRM_FSL_DCU=m
diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index d2bd0df2318d..7e90f17a0676 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -300,6 +300,29 @@ static int unwind_exec_pop_subset_r0_to_r3(struct unwind_ctrl_block *ctrl,
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
@@ -353,7 +376,7 @@ static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
 		if (ret)
 			goto error;
 	} else if (insn == 0xb2) {
-		unsigned long uleb128 = unwind_get_byte(ctrl);
+		unsigned long uleb128 = unwind_decode_uleb128(ctrl);
 
 		ctrl->vrs[SP] += 0x204 + (uleb128 << 2);
 	} else {
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 2be856731e81..d8baedd160de 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -402,8 +402,8 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 	}
 }
 
-#define VM_FAULT_BADMAP		0x010000
-#define VM_FAULT_BADACCESS	0x020000
+#define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
+#define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
 
 static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
 				  unsigned int mm_flags, unsigned long vm_flags,
diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index ca866f1cca2e..4d79391bb787 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -110,66 +110,78 @@ typedef unsigned int addr_t;
 
 static inline u8 rdfs8(addr_t addr)
 {
+	u8 *ptr = (u8 *)absolute_pointer(addr);
 	u8 v;
-	asm volatile("movb %%fs:%1,%0" : "=q" (v) : "m" (*(u8 *)addr));
+	asm volatile("movb %%fs:%1,%0" : "=q" (v) : "m" (*ptr));
 	return v;
 }
 static inline u16 rdfs16(addr_t addr)
 {
+	u16 *ptr = (u16 *)absolute_pointer(addr);
 	u16 v;
-	asm volatile("movw %%fs:%1,%0" : "=r" (v) : "m" (*(u16 *)addr));
+	asm volatile("movw %%fs:%1,%0" : "=r" (v) : "m" (*ptr));
 	return v;
 }
 static inline u32 rdfs32(addr_t addr)
 {
+	u32 *ptr = (u32 *)absolute_pointer(addr);
 	u32 v;
-	asm volatile("movl %%fs:%1,%0" : "=r" (v) : "m" (*(u32 *)addr));
+	asm volatile("movl %%fs:%1,%0" : "=r" (v) : "m" (*ptr));
 	return v;
 }
 
 static inline void wrfs8(u8 v, addr_t addr)
 {
-	asm volatile("movb %1,%%fs:%0" : "+m" (*(u8 *)addr) : "qi" (v));
+	u8 *ptr = (u8 *)absolute_pointer(addr);
+	asm volatile("movb %1,%%fs:%0" : "+m" (*ptr) : "qi" (v));
 }
 static inline void wrfs16(u16 v, addr_t addr)
 {
-	asm volatile("movw %1,%%fs:%0" : "+m" (*(u16 *)addr) : "ri" (v));
+	u16 *ptr = (u16 *)absolute_pointer(addr);
+	asm volatile("movw %1,%%fs:%0" : "+m" (*ptr) : "ri" (v));
 }
 static inline void wrfs32(u32 v, addr_t addr)
 {
-	asm volatile("movl %1,%%fs:%0" : "+m" (*(u32 *)addr) : "ri" (v));
+	u32 *ptr = (u32 *)absolute_pointer(addr);
+	asm volatile("movl %1,%%fs:%0" : "+m" (*ptr) : "ri" (v));
 }
 
 static inline u8 rdgs8(addr_t addr)
 {
+	u8 *ptr = (u8 *)absolute_pointer(addr);
 	u8 v;
-	asm volatile("movb %%gs:%1,%0" : "=q" (v) : "m" (*(u8 *)addr));
+	asm volatile("movb %%gs:%1,%0" : "=q" (v) : "m" (*ptr));
 	return v;
 }
 static inline u16 rdgs16(addr_t addr)
 {
+	u16 *ptr = (u16 *)absolute_pointer(addr);
 	u16 v;
-	asm volatile("movw %%gs:%1,%0" : "=r" (v) : "m" (*(u16 *)addr));
+	asm volatile("movw %%gs:%1,%0" : "=r" (v) : "m" (*ptr));
 	return v;
 }
 static inline u32 rdgs32(addr_t addr)
 {
+	u32 *ptr = (u32 *)absolute_pointer(addr);
 	u32 v;
-	asm volatile("movl %%gs:%1,%0" : "=r" (v) : "m" (*(u32 *)addr));
+	asm volatile("movl %%gs:%1,%0" : "=r" (v) : "m" (*ptr));
 	return v;
 }
 
 static inline void wrgs8(u8 v, addr_t addr)
 {
-	asm volatile("movb %1,%%gs:%0" : "+m" (*(u8 *)addr) : "qi" (v));
+	u8 *ptr = (u8 *)absolute_pointer(addr);
+	asm volatile("movb %1,%%gs:%0" : "+m" (*ptr) : "qi" (v));
 }
 static inline void wrgs16(u16 v, addr_t addr)
 {
-	asm volatile("movw %1,%%gs:%0" : "+m" (*(u16 *)addr) : "ri" (v));
+	u16 *ptr = (u16 *)absolute_pointer(addr);
+	asm volatile("movw %1,%%gs:%0" : "+m" (*ptr) : "ri" (v));
 }
 static inline void wrgs32(u32 v, addr_t addr)
 {
-	asm volatile("movl %1,%%gs:%0" : "+m" (*(u32 *)addr) : "ri" (v));
+	u32 *ptr = (u32 *)absolute_pointer(addr);
+	asm volatile("movl %1,%%gs:%0" : "+m" (*ptr) : "ri" (v));
 }
 
 /* Note: these only return true/false, not a signed return value! */
diff --git a/arch/x86/boot/main.c b/arch/x86/boot/main.c
index e3add857c2c9..c421af5a3cdc 100644
--- a/arch/x86/boot/main.c
+++ b/arch/x86/boot/main.c
@@ -33,7 +33,7 @@ static void copy_boot_params(void)
 		u16 cl_offset;
 	};
 	const struct old_cmdline * const oldcmd =
-		(const struct old_cmdline *)OLD_CL_ADDRESS;
+		absolute_pointer(OLD_CL_ADDRESS);
 
 	BUILD_BUG_ON(sizeof(boot_params) != 4096);
 	memcpy(&boot_params.hdr, &hdr, sizeof(hdr));
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5fbae8cc0697..34670943f543 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1588,6 +1588,9 @@ bool kvm_msr_allowed(struct kvm_vcpu *vcpu, u32 index, u32 type)
 			allowed = !!test_bit(index - start, bitmap);
 			break;
 		}
+
+		/* Note, VM-Exits that go down the "slow" path are accounted below. */
+		++vcpu->stat.exits;
 	}
 
 out:
diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index cf9b7ac36202..bd713a214d7a 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -316,9 +316,10 @@ int public_key_verify_signature(const struct public_key *pkey,
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
@@ -342,34 +343,37 @@ int public_key_verify_signature(const struct public_key *pkey,
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
@@ -377,8 +381,8 @@ int public_key_verify_signature(const struct public_key *pkey,
 				      crypto_req_done, &cwait);
 	ret = crypto_wait_req(crypto_akcipher_verify(req), &cwait);
 
-error_free_key:
-	kfree(key);
+error_free_buf:
+	kfree(buf);
 error_free_req:
 	akcipher_request_free(req);
 error_free_tfm:
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 859b1de31ddc..d62bf6df78f8 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -1120,8 +1120,6 @@ static int acpi_thermal_resume(struct device *dev)
 		return -EINVAL;
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		if (!(&tz->trips.active[i]))
-			break;
 		if (!tz->trips.active[i].flags.valid)
 			break;
 		tz->trips.active[i].flags.enabled = 1;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index f1755efd30a2..dfa090ccd21c 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2742,18 +2742,36 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
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
 
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 55a30afc14a0..2a3c3dfefdce 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1998,6 +1998,8 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 	size_t val_count = val_len / val_bytes;
 	size_t chunk_count, chunk_bytes;
 	size_t chunk_regs = val_count;
+	size_t max_data = map->max_raw_write - map->format.reg_bytes -
+			map->format.pad_bytes;
 	int ret, i;
 
 	if (!val_count)
@@ -2005,8 +2007,8 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 
 	if (map->use_single_write)
 		chunk_regs = 1;
-	else if (map->max_raw_write && val_len > map->max_raw_write)
-		chunk_regs = map->max_raw_write / val_bytes;
+	else if (map->max_raw_write && val_len > max_data)
+		chunk_regs = max_data / val_bytes;
 
 	chunk_count = val_count / chunk_regs;
 	chunk_bytes = chunk_regs * val_bytes;
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index dbcd903ba128..b6940f0a9c90 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1624,7 +1624,7 @@ static int nbd_dev_dbg_init(struct nbd_device *nbd)
 		return -EIO;
 
 	dir = debugfs_create_dir(nbd_name(nbd), nbd_dbg_dir);
-	if (!dir) {
+	if (IS_ERR(dir)) {
 		dev_err(nbd_to_dev(nbd), "Failed to create debugfs dir for '%s'\n",
 			nbd_name(nbd));
 		return -EIO;
@@ -1650,7 +1650,7 @@ static int nbd_dbg_init(void)
 	struct dentry *dbg_dir;
 
 	dbg_dir = debugfs_create_dir("nbd", NULL);
-	if (!dbg_dir)
+	if (IS_ERR(dbg_dir))
 		return -EIO;
 
 	nbd_dbg_dir = dbg_dir;
diff --git a/drivers/block/rnbd/rnbd-proto.h b/drivers/block/rnbd/rnbd-proto.h
index ca166241452c..cb11855455dd 100644
--- a/drivers/block/rnbd/rnbd-proto.h
+++ b/drivers/block/rnbd/rnbd-proto.h
@@ -234,7 +234,7 @@ static inline u32 rnbd_to_bio_flags(u32 rnbd_opf)
 		bio_opf = REQ_OP_WRITE;
 		break;
 	case RNBD_OP_FLUSH:
-		bio_opf = REQ_OP_FLUSH | REQ_PREFLUSH;
+		bio_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 		break;
 	case RNBD_OP_DISCARD:
 		bio_opf = REQ_OP_DISCARD;
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index d65fff4e2ebe..512c867495ea 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -764,8 +764,11 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
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
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 856d867f46eb..8e2672ec6e03 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -156,6 +156,7 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 	struct sev_device *sev;
 	unsigned int phys_lsb, phys_msb;
 	unsigned int reg, ret = 0;
+	int buf_len;
 
 	if (!psp || !psp->sev_data)
 		return -ENODEV;
@@ -165,18 +166,27 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 
 	sev = psp->sev_data;
 
-	if (data && WARN_ON_ONCE(!virt_addr_valid(data)))
+	buf_len = sev_cmd_buffer_len(cmd);
+	if (WARN_ON_ONCE(!data != !buf_len))
 		return -EINVAL;
 
+	/*
+	 * Copy the incoming data to driver's scratch buffer as __pa() will not
+	 * work for some memory, e.g. vmalloc'd addresses, and @data may not be
+	 * physically contiguous.
+	 */
+	if (data)
+		memcpy(sev->cmd_buf, data, buf_len);
+
 	/* Get the physical address of the command buffer */
-	phys_lsb = data ? lower_32_bits(__psp_pa(data)) : 0;
-	phys_msb = data ? upper_32_bits(__psp_pa(data)) : 0;
+	phys_lsb = data ? lower_32_bits(__psp_pa(sev->cmd_buf)) : 0;
+	phys_msb = data ? upper_32_bits(__psp_pa(sev->cmd_buf)) : 0;
 
 	dev_dbg(sev->dev, "sev command id %#x buffer 0x%08x%08x timeout %us\n",
 		cmd, phys_msb, phys_lsb, psp_timeout);
 
 	print_hex_dump_debug("(in):  ", DUMP_PREFIX_OFFSET, 16, 2, data,
-			     sev_cmd_buffer_len(cmd), false);
+			     buf_len, false);
 
 	iowrite32(phys_lsb, sev->io_regs + sev->vdata->cmdbuff_addr_lo_reg);
 	iowrite32(phys_msb, sev->io_regs + sev->vdata->cmdbuff_addr_hi_reg);
@@ -212,7 +222,14 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 	}
 
 	print_hex_dump_debug("(out): ", DUMP_PREFIX_OFFSET, 16, 2, data,
-			     sev_cmd_buffer_len(cmd), false);
+			     buf_len, false);
+
+	/*
+	 * Copy potential output from the PSP back to data.  Do this even on
+	 * failure in case the caller wants to glean something from the error.
+	 */
+	if (data)
+		memcpy(data, sev->cmd_buf, buf_len);
 
 	return ret;
 }
@@ -974,6 +991,10 @@ int sev_dev_init(struct psp_device *psp)
 	if (!sev)
 		goto e_err;
 
+	sev->cmd_buf = (void *)devm_get_free_pages(dev, GFP_KERNEL, 0);
+	if (!sev->cmd_buf)
+		goto e_sev;
+
 	psp->sev_data = sev;
 
 	sev->dev = dev;
@@ -985,7 +1006,7 @@ int sev_dev_init(struct psp_device *psp)
 	if (!sev->vdata) {
 		ret = -ENODEV;
 		dev_err(dev, "sev: missing driver data\n");
-		goto e_sev;
+		goto e_buf;
 	}
 
 	psp_set_sev_irq_handler(psp, sev_irq_handler, sev);
@@ -1000,6 +1021,8 @@ int sev_dev_init(struct psp_device *psp)
 
 e_irq:
 	psp_clear_sev_irq_handler(psp);
+e_buf:
+	devm_free_pages(dev, (unsigned long)sev->cmd_buf);
 e_sev:
 	devm_kfree(dev, sev);
 e_err:
diff --git a/drivers/crypto/ccp/sev-dev.h b/drivers/crypto/ccp/sev-dev.h
index 3b0cd0f854df..0fd21433f627 100644
--- a/drivers/crypto/ccp/sev-dev.h
+++ b/drivers/crypto/ccp/sev-dev.h
@@ -51,6 +51,8 @@ struct sev_device {
 	u8 api_major;
 	u8 api_minor;
 	u8 build;
+
+	void *cmd_buf;
 };
 
 int sev_dev_init(struct psp_device *psp);
diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 1fe006cc643e..861be862a775 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -678,7 +678,8 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		if (!desc) {
 			dev_err(chan2dev(chan), "can't get descriptor\n");
 			if (first)
-				list_splice_init(&first->descs_list, &atchan->free_descs_list);
+				list_splice_tail_init(&first->descs_list,
+						      &atchan->free_descs_list);
 			goto spin_unlock;
 		}
 
@@ -766,7 +767,8 @@ at_xdmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
 		if (!desc) {
 			dev_err(chan2dev(chan), "can't get descriptor\n");
 			if (first)
-				list_splice_init(&first->descs_list, &atchan->free_descs_list);
+				list_splice_tail_init(&first->descs_list,
+						      &atchan->free_descs_list);
 			spin_unlock_irqrestore(&atchan->lock, irqflags);
 			return NULL;
 		}
@@ -968,6 +970,8 @@ at_xdmac_prep_interleaved(struct dma_chan *chan,
 							NULL,
 							src_addr, dst_addr,
 							xt, xt->sgl);
+		if (!first)
+			return NULL;
 
 		/* Length of the block is (BLEN+1) microblocks. */
 		for (i = 0; i < xt->numf - 1; i++)
@@ -998,8 +1002,9 @@ at_xdmac_prep_interleaved(struct dma_chan *chan,
 							       src_addr, dst_addr,
 							       xt, chunk);
 			if (!desc) {
-				list_splice_init(&first->descs_list,
-						 &atchan->free_descs_list);
+				if (first)
+					list_splice_tail_init(&first->descs_list,
+							      &atchan->free_descs_list);
 				return NULL;
 			}
 
@@ -1077,7 +1082,8 @@ at_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 		if (!desc) {
 			dev_err(chan2dev(chan), "can't get descriptor\n");
 			if (first)
-				list_splice_init(&first->descs_list, &atchan->free_descs_list);
+				list_splice_tail_init(&first->descs_list,
+						      &atchan->free_descs_list);
 			return NULL;
 		}
 
@@ -1251,8 +1257,8 @@ at_xdmac_prep_dma_memset_sg(struct dma_chan *chan, struct scatterlist *sgl,
 						   sg_dma_len(sg),
 						   value);
 		if (!desc && first)
-			list_splice_init(&first->descs_list,
-					 &atchan->free_descs_list);
+			list_splice_tail_init(&first->descs_list,
+					      &atchan->free_descs_list);
 
 		if (!first)
 			first = desc;
@@ -1527,20 +1533,6 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	return ret;
 }
 
-/* Call must be protected by lock. */
-static void at_xdmac_remove_xfer(struct at_xdmac_chan *atchan,
-				    struct at_xdmac_desc *desc)
-{
-	dev_dbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, desc);
-
-	/*
-	 * Remove the transfer from the transfer list then move the transfer
-	 * descriptors into the free descriptors list.
-	 */
-	list_del(&desc->xfer_node);
-	list_splice_init(&desc->descs_list, &atchan->free_descs_list);
-}
-
 static void at_xdmac_advance_work(struct at_xdmac_chan *atchan)
 {
 	struct at_xdmac_desc	*desc;
@@ -1651,17 +1643,20 @@ static void at_xdmac_tasklet(struct tasklet_struct *t)
 		}
 
 		txd = &desc->tx_dma_desc;
-
-		at_xdmac_remove_xfer(atchan, desc);
+		dma_cookie_complete(txd);
+		/* Remove the transfer from the transfer list. */
+		list_del(&desc->xfer_node);
 		spin_unlock_irq(&atchan->lock);
 
-		dma_cookie_complete(txd);
 		if (txd->flags & DMA_PREP_INTERRUPT)
 			dmaengine_desc_get_callback_invoke(txd, NULL);
 
 		dma_run_dependencies(txd);
 
 		spin_lock_irq(&atchan->lock);
+		/* Move the xfer descriptors into the free descriptors list. */
+		list_splice_tail_init(&desc->descs_list,
+				      &atchan->free_descs_list);
 		at_xdmac_advance_work(atchan);
 		spin_unlock_irq(&atchan->lock);
 	}
@@ -1808,8 +1803,11 @@ static int at_xdmac_device_terminate_all(struct dma_chan *chan)
 		cpu_relax();
 
 	/* Cancel all pending transfers. */
-	list_for_each_entry_safe(desc, _desc, &atchan->xfers_list, xfer_node)
-		at_xdmac_remove_xfer(atchan, desc);
+	list_for_each_entry_safe(desc, _desc, &atchan->xfers_list, xfer_node) {
+		list_del(&desc->xfer_node);
+		list_splice_tail_init(&desc->descs_list,
+				      &atchan->free_descs_list);
+	}
 
 	clear_bit(AT_XDMAC_CHAN_IS_PAUSED, &atchan->status);
 	clear_bit(AT_XDMAC_CHAN_IS_CYCLIC, &atchan->status);
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 5bbae99f2d34..6f697b3f2c18 100644
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
@@ -1704,7 +1704,7 @@ static int pl330_update(struct pl330_dmac *pl330)
 			thrd->req_running = -1;
 
 			/* Get going again ASAP */
-			_start(thrd);
+			pl330_start_thread(thrd);
 
 			/* For now, just make a list of callbacks to be done */
 			list_add_tail(&descdone->rqd, &pl330->req_done);
@@ -2091,7 +2091,7 @@ static void pl330_tasklet(struct tasklet_struct *t)
 	} else {
 		/* Make sure the PL330 Channel thread is active */
 		spin_lock(&pch->thread->dmac->lock);
-		_start(pch->thread);
+		pl330_start_thread(pch->thread);
 		spin_unlock(&pch->thread->dmac->lock);
 	}
 
@@ -2109,7 +2109,7 @@ static void pl330_tasklet(struct tasklet_struct *t)
 			if (power_down) {
 				pch->active = true;
 				spin_lock(&pch->thread->dmac->lock);
-				_start(pch->thread);
+				pl330_start_thread(pch->thread);
 				spin_unlock(&pch->thread->dmac->lock);
 				power_down = false;
 			}
diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index ecab6287c1c3..b81390d6ebd3 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -155,7 +155,12 @@ struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent)
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
 
 	pagetable = kzalloc(sizeof(*pagetable), GFP_KERNEL);
diff --git a/drivers/gpu/drm/rcar-du/Kconfig b/drivers/gpu/drm/rcar-du/Kconfig
index b47e74421e34..3e588ddba245 100644
--- a/drivers/gpu/drm/rcar-du/Kconfig
+++ b/drivers/gpu/drm/rcar-du/Kconfig
@@ -4,8 +4,6 @@ config DRM_RCAR_DU
 	depends on DRM && OF
 	depends on ARM || ARM64
 	depends on ARCH_RENESAS || COMPILE_TEST
-	imply DRM_RCAR_CMM
-	imply DRM_RCAR_LVDS
 	select DRM_KMS_HELPER
 	select DRM_KMS_CMA_HELPER
 	select DRM_GEM_CMA_HELPER
@@ -14,13 +12,17 @@ config DRM_RCAR_DU
 	  Choose this option if you have an R-Car chipset.
 	  If M is selected the module will be called rcar-du-drm.
 
-config DRM_RCAR_CMM
-	tristate "R-Car DU Color Management Module (CMM) Support"
-	depends on DRM && OF
+config DRM_RCAR_USE_CMM
+	bool "R-Car DU Color Management Module (CMM) Support"
 	depends on DRM_RCAR_DU
+	default DRM_RCAR_DU
 	help
 	  Enable support for R-Car Color Management Module (CMM).
 
+config DRM_RCAR_CMM
+	def_tristate DRM_RCAR_DU
+	depends on DRM_RCAR_USE_CMM
+
 config DRM_RCAR_DW_HDMI
 	tristate "R-Car Gen3 and RZ/G2 DU HDMI Encoder Support"
 	depends on DRM && OF
@@ -28,15 +30,20 @@ config DRM_RCAR_DW_HDMI
 	help
 	  Enable support for R-Car Gen3 or RZ/G2 internal HDMI encoder.
 
+config DRM_RCAR_USE_LVDS
+	bool "R-Car DU LVDS Encoder Support"
+	depends on DRM_BRIDGE && OF
+	default DRM_RCAR_DU
+	help
+	  Enable support for the R-Car Display Unit embedded LVDS encoders.
+
 config DRM_RCAR_LVDS
-	tristate "R-Car DU LVDS Encoder Support"
-	depends on DRM && DRM_BRIDGE && OF
+	def_tristate DRM_RCAR_DU
+	depends on DRM_RCAR_USE_LVDS
 	select DRM_KMS_HELPER
 	select DRM_PANEL
 	select OF_FLATTREE
 	select OF_OVERLAY
-	help
-	  Enable support for the R-Car Display Unit embedded LVDS encoders.
 
 config DRM_RCAR_VSP
 	bool "R-Car DU VSP Compositor Support" if ARM
diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 047630198396..2f4c5b45d409 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -532,6 +532,8 @@ static const struct hid_device_id hammer_devices[] = {
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_EEL) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_HAMMER) },
+	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_JEWEL) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_MAGNEMITE) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 1d1306a6004e..2b658d820b80 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -491,6 +491,7 @@
 #define USB_DEVICE_ID_GOOGLE_MOONBALL	0x5044
 #define USB_DEVICE_ID_GOOGLE_DON	0x5050
 #define USB_DEVICE_ID_GOOGLE_EEL	0x5057
+#define USB_DEVICE_ID_GOOGLE_JEWEL	0x5061
 
 #define USB_VENDOR_ID_GOTOP		0x08f2
 #define USB_DEVICE_ID_SUPER_Q2		0x007f
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 37754a1f733b..1bfcc94c1d23 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -831,7 +831,7 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 	/* Enter report */
 	if ((data[1] & 0xfc) == 0xc0) {
 		/* serial number of the tool */
-		wacom->serial[idx] = ((data[3] & 0x0f) << 28) +
+		wacom->serial[idx] = ((__u64)(data[3] & 0x0f) << 28) +
 			(data[4] << 20) + (data[5] << 12) +
 			(data[6] << 4) + (data[7] >> 4);
 
diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 1b8baba9d4d6..614c5e807bb8 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -835,10 +835,6 @@ static const struct iio_info ad7195_info = {
 	__AD719x_CHANNEL(_si, _channel1, -1, _address, NULL, IIO_VOLTAGE, \
 		BIT(IIO_CHAN_INFO_SCALE), ad7192_calibsys_ext_info)
 
-#define AD719x_SHORTED_CHANNEL(_si, _channel1, _address) \
-	__AD719x_CHANNEL(_si, _channel1, -1, _address, "shorted", IIO_VOLTAGE, \
-		BIT(IIO_CHAN_INFO_SCALE), ad7192_calibsys_ext_info)
-
 #define AD719x_TEMP_CHANNEL(_si, _address) \
 	__AD719x_CHANNEL(_si, 0, -1, _address, NULL, IIO_TEMP, 0, NULL)
 
@@ -846,7 +842,7 @@ static const struct iio_chan_spec ad7192_channels[] = {
 	AD719x_DIFF_CHANNEL(0, 1, 2, AD7192_CH_AIN1P_AIN2M),
 	AD719x_DIFF_CHANNEL(1, 3, 4, AD7192_CH_AIN3P_AIN4M),
 	AD719x_TEMP_CHANNEL(2, AD7192_CH_TEMP),
-	AD719x_SHORTED_CHANNEL(3, 2, AD7192_CH_AIN2P_AIN2M),
+	AD719x_DIFF_CHANNEL(3, 2, 2, AD7192_CH_AIN2P_AIN2M),
 	AD719x_CHANNEL(4, 1, AD7192_CH_AIN1),
 	AD719x_CHANNEL(5, 2, AD7192_CH_AIN2),
 	AD719x_CHANNEL(6, 3, AD7192_CH_AIN3),
@@ -860,7 +856,7 @@ static const struct iio_chan_spec ad7193_channels[] = {
 	AD719x_DIFF_CHANNEL(2, 5, 6, AD7193_CH_AIN5P_AIN6M),
 	AD719x_DIFF_CHANNEL(3, 7, 8, AD7193_CH_AIN7P_AIN8M),
 	AD719x_TEMP_CHANNEL(4, AD7193_CH_TEMP),
-	AD719x_SHORTED_CHANNEL(5, 2, AD7193_CH_AIN2P_AIN2M),
+	AD719x_DIFF_CHANNEL(5, 2, 2, AD7193_CH_AIN2P_AIN2M),
 	AD719x_CHANNEL(6, 1, AD7193_CH_AIN1),
 	AD719x_CHANNEL(7, 2, AD7193_CH_AIN2),
 	AD719x_CHANNEL(8, 3, AD7193_CH_AIN3),
diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index c480cb489c1a..c37e39b96f0e 100644
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
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 2fc481167724..09506d248c9e 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_AD5592R_BASE) += ad5592r-base.o
 obj-$(CONFIG_AD5592R) += ad5592r.o
 obj-$(CONFIG_AD5593R) += ad5593r.o
 obj-$(CONFIG_AD5755) += ad5755.o
-obj-$(CONFIG_AD5755) += ad5758.o
+obj-$(CONFIG_AD5758) += ad5758.o
 obj-$(CONFIG_AD5761) += ad5761.o
 obj-$(CONFIG_AD5764) += ad5764.o
 obj-$(CONFIG_AD5770R) += ad5770r.o
diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index beb9a15b7c74..0c0e726ae054 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -47,12 +47,18 @@ static int __maybe_unused mcp4725_suspend(struct device *dev)
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
 
 static int __maybe_unused mcp4725_resume(struct device *dev)
@@ -60,13 +66,19 @@ static int __maybe_unused mcp4725_resume(struct device *dev)
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
 static SIMPLE_DEV_PM_OPS(mcp4725_pm_ops, mcp4725_suspend, mcp4725_resume);
 
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
index 1bd85e21fd11..6e38a33f55c7 100644
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
@@ -415,6 +417,7 @@ static int vcnl4035_init(struct vcnl4035_data *data)
 		return ret;
 	}
 
+	id = FIELD_GET(VCNL4035_DEV_ID_MASK, id);
 	if (id != VCNL4035_DEV_ID_VAL) {
 		dev_err(&data->client->dev, "Wrong id, got %x, expected %x\n",
 			id, VCNL4035_DEV_ID_VAL);
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 10d77f50f818..2a973a1390a4 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -469,7 +469,6 @@ static int bnxt_re_create_fence_mr(struct bnxt_re_pd *pd)
 	struct bnxt_re_mr *mr = NULL;
 	dma_addr_t dma_addr = 0;
 	struct ib_mw *mw;
-	u64 pbl_tbl;
 	int rc;
 
 	dma_addr = dma_map_single(dev, fence->va, BNXT_RE_FENCE_BYTES,
@@ -504,9 +503,8 @@ static int bnxt_re_create_fence_mr(struct bnxt_re_pd *pd)
 	mr->ib_mr.lkey = mr->qplib_mr.lkey;
 	mr->qplib_mr.va = (u64)(unsigned long)fence->va;
 	mr->qplib_mr.total_size = BNXT_RE_FENCE_BYTES;
-	pbl_tbl = dma_addr;
-	rc = bnxt_qplib_reg_mr(&rdev->qplib_res, &mr->qplib_mr, &pbl_tbl,
-			       BNXT_RE_FENCE_PBL_SIZE, false, PAGE_SIZE);
+	rc = bnxt_qplib_reg_mr(&rdev->qplib_res, &mr->qplib_mr, NULL,
+			       BNXT_RE_FENCE_PBL_SIZE, PAGE_SIZE);
 	if (rc) {
 		ibdev_err(&rdev->ibdev, "Failed to register fence-MR\n");
 		goto fail;
@@ -3249,9 +3247,7 @@ static int bnxt_re_process_raw_qp_pkt_rx(struct bnxt_re_qp *gsi_qp,
 	udwr.remote_qkey = gsi_sqp->qplib_qp.qkey;
 
 	/* post data received  in the send queue */
-	rc = bnxt_re_post_send_shadow_qp(rdev, gsi_sqp, swr);
-
-	return 0;
+	return bnxt_re_post_send_shadow_qp(rdev, gsi_sqp, swr);
 }
 
 static void bnxt_re_process_res_rawqp1_wc(struct ib_wc *wc,
@@ -3588,7 +3584,6 @@ struct ib_mr *bnxt_re_get_dma_mr(struct ib_pd *ib_pd, int mr_access_flags)
 	struct bnxt_re_pd *pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
 	struct bnxt_re_dev *rdev = pd->rdev;
 	struct bnxt_re_mr *mr;
-	u64 pbl = 0;
 	int rc;
 
 	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
@@ -3607,7 +3602,7 @@ struct ib_mr *bnxt_re_get_dma_mr(struct ib_pd *ib_pd, int mr_access_flags)
 
 	mr->qplib_mr.hwq.level = PBL_LVL_MAX;
 	mr->qplib_mr.total_size = -1; /* Infinte length */
-	rc = bnxt_qplib_reg_mr(&rdev->qplib_res, &mr->qplib_mr, &pbl, 0, false,
+	rc = bnxt_qplib_reg_mr(&rdev->qplib_res, &mr->qplib_mr, NULL, 0,
 			       PAGE_SIZE);
 	if (rc)
 		goto fail_mr;
@@ -3778,19 +3773,6 @@ int bnxt_re_dealloc_mw(struct ib_mw *ib_mw)
 	return rc;
 }
 
-static int fill_umem_pbl_tbl(struct ib_umem *umem, u64 *pbl_tbl_orig,
-			     int page_shift)
-{
-	u64 *pbl_tbl = pbl_tbl_orig;
-	u64 page_size =  BIT_ULL(page_shift);
-	struct ib_block_iter biter;
-
-	rdma_umem_for_each_dma_block(umem, &biter, page_size)
-		*pbl_tbl++ = rdma_block_iter_dma_address(&biter);
-
-	return pbl_tbl - pbl_tbl_orig;
-}
-
 /* uverbs */
 struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 				  u64 virt_addr, int mr_access_flags,
@@ -3800,7 +3782,6 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 	struct bnxt_re_dev *rdev = pd->rdev;
 	struct bnxt_re_mr *mr;
 	struct ib_umem *umem;
-	u64 *pbl_tbl = NULL;
 	unsigned long page_size;
 	int umem_pgs, rc;
 
@@ -3854,30 +3835,18 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 	}
 
 	umem_pgs = ib_umem_num_dma_blocks(umem, page_size);
-	pbl_tbl = kcalloc(umem_pgs, sizeof(*pbl_tbl), GFP_KERNEL);
-	if (!pbl_tbl) {
-		rc = -ENOMEM;
-		goto free_umem;
-	}
-
-	/* Map umem buf ptrs to the PBL */
-	umem_pgs = fill_umem_pbl_tbl(umem, pbl_tbl, order_base_2(page_size));
-	rc = bnxt_qplib_reg_mr(&rdev->qplib_res, &mr->qplib_mr, pbl_tbl,
-			       umem_pgs, false, page_size);
+	rc = bnxt_qplib_reg_mr(&rdev->qplib_res, &mr->qplib_mr, umem,
+			       umem_pgs, page_size);
 	if (rc) {
 		ibdev_err(&rdev->ibdev, "Failed to register user MR");
-		goto fail;
+		goto free_umem;
 	}
 
-	kfree(pbl_tbl);
-
 	mr->ib_mr.lkey = mr->qplib_mr.lkey;
 	mr->ib_mr.rkey = mr->qplib_mr.lkey;
 	atomic_inc(&rdev->mr_count);
 
 	return &mr->ib_mr;
-fail:
-	kfree(pbl_tbl);
 free_umem:
 	ib_umem_release(umem);
 free_mrw:
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index bd153aa7e9ab..b26a89187a19 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -2041,6 +2041,12 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
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
@@ -2052,11 +2058,6 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 
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
index 754dcebeb4ca..123ea759f282 100644
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
 
 	if (npages == MAX_PBL_LVL_0_PGS) {
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 64d44f51db4b..f53d94c812ec 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -650,16 +650,15 @@ int bnxt_qplib_dereg_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw,
 }
 
 int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
-		      u64 *pbl_tbl, int num_pbls, bool block, u32 buf_pg_size)
+		      struct ib_umem *umem, int num_pbls, u32 buf_pg_size)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct bnxt_qplib_hwq_attr hwq_attr = {};
 	struct bnxt_qplib_sg_info sginfo = {};
 	struct creq_register_mr_resp resp;
 	struct cmdq_register_mr req;
-	int pg_ptrs, pages, i, rc;
 	u16 cmd_flags = 0, level;
-	dma_addr_t **pbl_ptr;
+	int pages, rc, pg_ptrs;
 	u32 pg_size;
 
 	if (num_pbls) {
@@ -680,26 +679,21 @@ int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
 		/* Free the hwq if it already exist, must be a rereg */
 		if (mr->hwq.max_elements)
 			bnxt_qplib_free_hwq(res, &mr->hwq);
-		/* Use system PAGE_SIZE */
 		hwq_attr.res = res;
 		hwq_attr.depth = pages;
-		hwq_attr.stride = PAGE_SIZE;
+		hwq_attr.stride = sizeof(dma_addr_t);
 		hwq_attr.type = HWQ_TYPE_MR;
 		hwq_attr.sginfo = &sginfo;
+		hwq_attr.sginfo->umem = umem;
 		hwq_attr.sginfo->npages = pages;
-		hwq_attr.sginfo->pgsize = PAGE_SIZE;
-		hwq_attr.sginfo->pgshft = PAGE_SHIFT;
+		hwq_attr.sginfo->pgsize = buf_pg_size;
+		hwq_attr.sginfo->pgshft = ilog2(buf_pg_size);
 		rc = bnxt_qplib_alloc_init_hwq(&mr->hwq, &hwq_attr);
 		if (rc) {
 			dev_err(&res->pdev->dev,
 				"SP: Reg MR memory allocation failed\n");
 			return -ENOMEM;
 		}
-		/* Write to the hwq */
-		pbl_ptr = (dma_addr_t **)mr->hwq.pbl_ptr;
-		for (i = 0; i < num_pbls; i++)
-			pbl_ptr[PTR_PG(i)][PTR_IDX(i)] =
-				(pbl_tbl[i] & PAGE_MASK) | PTU_PTE_VALID;
 	}
 
 	RCFW_CMD_PREP(req, REGISTER_MR, cmd_flags);
@@ -711,7 +705,7 @@ int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
 		req.pbl = 0;
 		pg_size = PAGE_SIZE;
 	} else {
-		level = mr->hwq.level + 1;
+		level = mr->hwq.level;
 		req.pbl = cpu_to_le64(mr->hwq.pbl[PBL_LVL_0].pg_map_arr[0]);
 	}
 	pg_size = buf_pg_size ? buf_pg_size : PAGE_SIZE;
@@ -728,7 +722,7 @@ int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
 	req.mr_size = cpu_to_le64(mr->total_size);
 
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp, NULL, block);
+					  (void *)&resp, NULL, false);
 	if (rc)
 		goto fail;
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index 967890cd81f2..bc228340684f 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -254,7 +254,7 @@ int bnxt_qplib_alloc_mrw(struct bnxt_qplib_res *res,
 int bnxt_qplib_dereg_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw,
 			 bool block);
 int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
-		      u64 *pbl_tbl, int num_pbls, bool block, u32 buf_pg_size);
+		      struct ib_umem *umem, int num_pbls, u32 buf_pg_size);
 int bnxt_qplib_free_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr);
 int bnxt_qplib_alloc_fast_reg_mr(struct bnxt_qplib_res *res,
 				 struct bnxt_qplib_mrw *mr, int max);
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 2ece682c7835..9cf051818725 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1328,7 +1328,7 @@ static int pbl_continuous_initialize(struct efa_dev *dev,
  */
 static int pbl_indirect_initialize(struct efa_dev *dev, struct pbl_context *pbl)
 {
-	u32 size_in_pages = DIV_ROUND_UP(pbl->pbl_buf_size_in_bytes, PAGE_SIZE);
+	u32 size_in_pages = DIV_ROUND_UP(pbl->pbl_buf_size_in_bytes, EFA_CHUNK_PAYLOAD_SIZE);
 	struct scatterlist *sgl;
 	int sg_dma_cnt, err;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f216a86d9c81..0a061a196b53 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3914,8 +3914,7 @@ int amd_iommu_activate_guest_mode(void *data)
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
 	u64 valid;
 
-	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
-	    !entry || entry->lo.fields_vapic.guest_mode)
+	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) || !entry)
 		return 0;
 
 	valid = entry->lo.fields_vapic.valid;
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index e5d86b7177de..12551dc11714 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1218,18 +1218,20 @@ static int rk_iommu_probe(struct platform_device *pdev)
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
diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c b/drivers/media/dvb-core/dvb_ca_en50221.c
index fd476536d32e..dec036e0336c 100644
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
  * Safely find needle in haystack.
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
 
@@ -1505,7 +1513,7 @@ static ssize_t dvb_ca_en50221_io_write(struct file *file,
 
 			mutex_lock(&sl->slot_lock);
 			status = dvb_ca_en50221_write_data(ca, slot, fragbuf,
-							   fraglen + 2);
+							   fraglen + 2, 0);
 			mutex_unlock(&sl->slot_lock);
 			if (status == (fraglen + 2)) {
 				written = 1;
@@ -1706,12 +1714,22 @@ static int dvb_ca_en50221_io_open(struct inode *inode, struct file *file)
 
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
 
@@ -1736,6 +1754,7 @@ static int dvb_ca_en50221_io_open(struct inode *inode, struct file *file)
 
 	dvb_ca_private_get(ca);
 
+	mutex_unlock(&ca->remove_mutex);
 	return 0;
 }
 
@@ -1755,6 +1774,8 @@ static int dvb_ca_en50221_io_release(struct inode *inode, struct file *file)
 
 	dprintk("%s\n", __func__);
 
+	mutex_lock(&ca->remove_mutex);
+
 	/* mark the CA device as closed */
 	ca->open = 0;
 	dvb_ca_en50221_thread_update_delay(ca);
@@ -1765,6 +1786,13 @@ static int dvb_ca_en50221_io_release(struct inode *inode, struct file *file)
 
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
 
@@ -1888,6 +1916,7 @@ int dvb_ca_en50221_init(struct dvb_adapter *dvb_adapter,
 	}
 
 	mutex_init(&ca->ioctl_mutex);
+	mutex_init(&ca->remove_mutex);
 
 	if (signal_pending(current)) {
 		ret = -EINTR;
@@ -1930,6 +1959,14 @@ void dvb_ca_en50221_release(struct dvb_ca_en50221 *pubca)
 
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
index 5fde1d38b3e3..80b495982f63 100644
--- a/drivers/media/dvb-core/dvb_demux.c
+++ b/drivers/media/dvb-core/dvb_demux.c
@@ -125,12 +125,12 @@ static inline int dvb_dmx_swfilter_payload(struct dvb_demux_feed *feed,
 
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
@@ -310,7 +310,6 @@ static int dvb_dmx_swfilter_section_packet(struct dvb_demux_feed *feed,
 
 	cc = buf[3] & 0x0f;
 	ccok = ((feed->cc + 1) & 0x0f) == cc;
-	feed->cc = cc;
 
 	if (buf[3] & 0x20) {
 		/* adaption field present, check for discontinuity_indicator */
@@ -346,6 +345,7 @@ static int dvb_dmx_swfilter_section_packet(struct dvb_demux_feed *feed,
 		feed->pusi_seen = false;
 		dvb_dmx_swfilter_section_new(feed);
 	}
+	feed->cc = cc;
 
 	if (buf[1] & 0x40) {
 		/* PUSI=1 (is set), section boundary is here */
diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index b04638321b75..ad3e42a4eaf7 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -292,14 +292,22 @@ static int dvb_frontend_get_event(struct dvb_frontend *fe,
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
index dddebea644bb..c594b1bdfcaa 100644
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
diff --git a/drivers/media/dvb-frontends/mn88443x.c b/drivers/media/dvb-frontends/mn88443x.c
index fff212c0bf3b..05894deb8a19 100644
--- a/drivers/media/dvb-frontends/mn88443x.c
+++ b/drivers/media/dvb-frontends/mn88443x.c
@@ -800,7 +800,7 @@ MODULE_DEVICE_TABLE(i2c, mn88443x_i2c_id);
 static struct i2c_driver mn88443x_driver = {
 	.driver = {
 		.name = "mn88443x",
-		.of_match_table = of_match_ptr(mn88443x_of_match),
+		.of_match_table = mn88443x_of_match,
 	},
 	.probe    = mn88443x_probe,
 	.remove   = mn88443x_remove,
diff --git a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
index a71814e2772d..7c5061953ee8 100644
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
diff --git a/drivers/media/platform/rcar-vin/rcar-dma.c b/drivers/media/platform/rcar-vin/rcar-dma.c
index 692dea300b0d..63c61c704446 100644
--- a/drivers/media/platform/rcar-vin/rcar-dma.c
+++ b/drivers/media/platform/rcar-vin/rcar-dma.c
@@ -645,11 +645,9 @@ static int rvin_setup(struct rvin_dev *vin)
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
diff --git a/drivers/media/platform/ti-vpe/cal.h b/drivers/media/platform/ti-vpe/cal.h
index 4123405ee0cf..20d07311d222 100644
--- a/drivers/media/platform/ti-vpe/cal.h
+++ b/drivers/media/platform/ti-vpe/cal.h
@@ -215,7 +215,7 @@ static inline void cal_write(struct cal_dev *cal, u32 offset, u32 val)
 	iowrite32(val, cal->base + offset);
 }
 
-static inline u32 cal_read_field(struct cal_dev *cal, u32 offset, u32 mask)
+static __always_inline u32 cal_read_field(struct cal_dev *cal, u32 offset, u32 mask)
 {
 	return FIELD_GET(mask, cal_read(cal, offset));
 }
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
index c278b9b0f102..70a2f0494216 100644
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
index 32b4ee65c280..991f4510aaeb 100644
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
index 4e3b3c064bcf..e56efebd4f0a 100644
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
index aa929db56db1..3c4ac998d040 100644
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
index df6c5e4a0f05..68f88143c8a6 100644
--- a/drivers/media/usb/ttusb-dec/ttusb_dec.c
+++ b/drivers/media/usb/ttusb-dec/ttusb_dec.c
@@ -1551,8 +1551,7 @@ static void ttusb_dec_exit_dvb(struct ttusb_dec *dec)
 	dvb_dmx_release(&dec->demux);
 	if (dec->fe) {
 		dvb_unregister_frontend(dec->fe);
-		if (dec->fe->ops.release)
-			dec->fe->ops.release(dec->fe);
+		dvb_frontend_detach(dec->fe);
 	}
 	dvb_unregister_adapter(&dec->adapter);
 }
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 67a51f69cf9a..2488a9a67d18 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1675,8 +1675,10 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
 	struct fastrpc_invoke_ctx *ctx;
 
 	spin_lock(&user->lock);
-	list_for_each_entry(ctx, &user->pending, node)
+	list_for_each_entry(ctx, &user->pending, node) {
+		ctx->retval = -EPIPE;
 		complete(&ctx->work);
+	}
 	spin_unlock(&user->lock);
 }
 
@@ -1686,7 +1688,9 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	struct fastrpc_user *user;
 	unsigned long flags;
 
+	/* No invocations past this point */
 	spin_lock_irqsave(&cctx->lock, flags);
+	cctx->rpdev = NULL;
 	list_for_each_entry(user, &cctx->users, user)
 		fastrpc_notify_users(user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
@@ -1694,7 +1698,6 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	misc_deregister(&cctx->miscdev);
 	of_platform_depopulate(&rpdev->dev);
 
-	cctx->rpdev = NULL;
 	fastrpc_channel_ctx_put(cctx);
 }
 
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
index dce35f81e0a5..2ef1a5adfcfc 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2443,6 +2443,12 @@ static int marvell_nfc_setup_interface(struct nand_chip *chip, int chipnr,
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
index 321c821876f6..8b2c8546f4c9 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5547,7 +5547,7 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 		goto out;
 	}
 	if (chip->reset)
-		usleep_range(1000, 2000);
+		usleep_range(10000, 20000);
 
 	err = mv88e6xxx_detect(chip);
 	if (err)
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
index 0a011a41c039..5273644fb2bf 100644
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
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index da4ca0f67e9c..22907f6364f5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -783,7 +783,6 @@ static int mlx5_pci_init(struct mlx5_core_dev *dev, struct pci_dev *pdev,
 	}
 
 	mlx5_pci_vsc_init(dev);
-	dev->caps.embedded_cpu = mlx5_read_embedded_cpu(dev);
 	return 0;
 
 err_clr_master:
@@ -978,6 +977,7 @@ static int mlx5_function_setup(struct mlx5_core_dev *dev, bool boot)
 		goto err_cmd_cleanup;
 	}
 
+	dev->caps.embedded_cpu = mlx5_read_embedded_cpu(dev);
 	mlx5_cmd_set_state(dev, MLX5_CMDIF_STATE_UP);
 
 	err = mlx5_core_enable_hca(dev, 0);
diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
index d245f6e21e8c..b929c6f6ce51 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -1325,7 +1325,7 @@ static void cas_init_rx_dma(struct cas *cp)
 	writel(val, cp->regs + REG_RX_PAGE_SIZE);
 
 	/* enable the header parser if desired */
-	if (CAS_HP_FIRMWARE == cas_prog_null)
+	if (&CAS_HP_FIRMWARE[0] == &cas_prog_null[0])
 		return;
 
 	val = CAS_BASE(HP_CFG_NUM_CPU, CAS_NCPUS > 63 ? 0 : CAS_NCPUS);
@@ -3793,7 +3793,7 @@ static void cas_reset(struct cas *cp, int blkflag)
 
 	/* program header parser */
 	if ((cp->cas_flags & CAS_FLAG_TARGET_ABORT) ||
-	    (CAS_HP_ALT_FIRMWARE == cas_prog_null)) {
+	    (&CAS_HP_ALT_FIRMWARE[0] == &cas_prog_null[0])) {
 		cas_load_firmware(cp, CAS_HP_FIRMWARE);
 	} else {
 		cas_load_firmware(cp, CAS_HP_ALT_FIRMWARE);
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 070910567c44..53f1cd0bfaf4 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1260,7 +1260,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x2001, 0x7e3d, 4)},	/* D-Link DWM-222 A2 */
 	{QMI_FIXED_INTF(0x2020, 0x2031, 4)},	/* Olicard 600 */
 	{QMI_FIXED_INTF(0x2020, 0x2033, 4)},	/* BroadMobi BM806U */
-	{QMI_FIXED_INTF(0x2020, 0x2060, 4)},	/* BroadMobi BM818 */
+	{QMI_QUIRK_SET_DTR(0x2020, 0x2060, 4)},	/* BroadMobi BM818 */
 	{QMI_FIXED_INTF(0x0f3d, 0x68a2, 8)},    /* Sierra Wireless MC7700 */
 	{QMI_FIXED_INTF(0x114f, 0x68a2, 8)},    /* Sierra Wireless MC7750 */
 	{QMI_FIXED_INTF(0x1199, 0x68a2, 8)},	/* Sierra Wireless MC7710 in QMI mode */
diff --git a/drivers/net/wireless/ath/ath6kl/htc.h b/drivers/net/wireless/ath/ath6kl/htc.h
index 112d8a9b8d43..d3534a29c4f0 100644
--- a/drivers/net/wireless/ath/ath6kl/htc.h
+++ b/drivers/net/wireless/ath/ath6kl/htc.h
@@ -153,12 +153,19 @@
  * implementations.
  */
 struct htc_frame_hdr {
-	u8 eid;
-	u8 flags;
-
-	/* length of data (including trailer) that follows the header */
-	__le16 payld_len;
-
+	struct_group_tagged(htc_frame_look_ahead, header,
+		union {
+			struct {
+				u8 eid;
+				u8 flags;
+
+				/* length of data (including trailer) that follows the header */
+				__le16 payld_len;
+
+			};
+			u32 word;
+		};
+	);
 	/* end of 4-byte lookahead */
 
 	u8 ctrl[2];
diff --git a/drivers/net/wireless/ath/ath6kl/htc_mbox.c b/drivers/net/wireless/ath/ath6kl/htc_mbox.c
index 998947ef63b6..e3874421c4c0 100644
--- a/drivers/net/wireless/ath/ath6kl/htc_mbox.c
+++ b/drivers/net/wireless/ath/ath6kl/htc_mbox.c
@@ -2260,19 +2260,16 @@ int ath6kl_htc_rxmsg_pending_handler(struct htc_target *target,
 static struct htc_packet *htc_wait_for_ctrl_msg(struct htc_target *target)
 {
 	struct htc_packet *packet = NULL;
-	struct htc_frame_hdr *htc_hdr;
-	u32 look_ahead;
+	struct htc_frame_look_ahead look_ahead;
 
-	if (ath6kl_hif_poll_mboxmsg_rx(target->dev, &look_ahead,
+	if (ath6kl_hif_poll_mboxmsg_rx(target->dev, &look_ahead.word,
 				       HTC_TARGET_RESPONSE_TIMEOUT))
 		return NULL;
 
 	ath6kl_dbg(ATH6KL_DBG_HTC,
-		   "htc rx wait ctrl look_ahead 0x%X\n", look_ahead);
-
-	htc_hdr = (struct htc_frame_hdr *)&look_ahead;
+		   "htc rx wait ctrl look_ahead 0x%X\n", look_ahead.word);
 
-	if (htc_hdr->eid != ENDPOINT_0)
+	if (look_ahead.eid != ENDPOINT_0)
 		return NULL;
 
 	packet = htc_get_control_buf(target, false);
@@ -2281,8 +2278,8 @@ static struct htc_packet *htc_wait_for_ctrl_msg(struct htc_target *target)
 		return NULL;
 
 	packet->info.rx.rx_flags = 0;
-	packet->info.rx.exp_hdr = look_ahead;
-	packet->act_len = le16_to_cpu(htc_hdr->payld_len) + HTC_HDR_LENGTH;
+	packet->info.rx.exp_hdr = look_ahead.word;
+	packet->act_len = le16_to_cpu(look_ahead.payld_len) + HTC_HDR_LENGTH;
 
 	if (packet->act_len > packet->buf_len)
 		goto fail_ctrl_rx;
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
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 0ed4d67308d7..fe1e4c4c17c4 100644
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
index deef1c09de31..004778faf3d0 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4045,6 +4045,7 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 		RCR_ACCEPT_MGMT_FRAME | RCR_HTC_LOC_CTRL |
 		RCR_APPEND_PHYSTAT | RCR_APPEND_ICV | RCR_APPEND_MIC;
 	rtl8xxxu_write32(priv, REG_RCR, val32);
+	priv->regrcr = val32;
 
 	/*
 	 * Accept all multicast
@@ -5999,7 +6000,7 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
 				      unsigned int *total_flags, u64 multicast)
 {
 	struct rtl8xxxu_priv *priv = hw->priv;
-	u32 rcr = rtl8xxxu_read32(priv, REG_RCR);
+	u32 rcr = priv->regrcr;
 
 	dev_dbg(&priv->udev->dev, "%s: changed_flags %08x, total_flags %08x\n",
 		__func__, changed_flags, *total_flags);
@@ -6045,6 +6046,7 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
 	 */
 
 	rtl8xxxu_write32(priv, REG_RCR, rcr);
+	priv->regrcr = rcr;
 
 	*total_flags &= (FIF_ALLMULTI | FIF_FCSFAIL | FIF_BCN_PRBRESP_PROMISC |
 			 FIF_CONTROL | FIF_OTHER_BSS | FIF_PSPOLL |
diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index dd84995049b9..870e00effe43 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -1271,6 +1271,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 			return PTR_ERR(kkey);
 		rc = pkey_keyblob2pkey(kkey, ktp.keylen, &ktp.protkey);
 		DEBUG_DBG("%s pkey_keyblob2pkey()=%d\n", __func__, rc);
+		memzero_explicit(kkey, ktp.keylen);
 		kfree(kkey);
 		if (rc)
 			break;
@@ -1404,6 +1405,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 					kkey, ktp.keylen, &ktp.protkey);
 		DEBUG_DBG("%s pkey_keyblob2pkey2()=%d\n", __func__, rc);
 		kfree(apqns);
+		memzero_explicit(kkey, ktp.keylen);
 		kfree(kkey);
 		if (rc)
 			break;
@@ -1530,6 +1532,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 					protkey, &protkeylen);
 		DEBUG_DBG("%s pkey_keyblob2pkey3()=%d\n", __func__, rc);
 		kfree(apqns);
+		memzero_explicit(kkey, ktp.keylen);
 		kfree(kkey);
 		if (rc) {
 			kfree(protkey);
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 701b61ec76ee..6524e1fe54d2 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -444,7 +444,7 @@ config SCSI_MVUMI
 
 config SCSI_DPT_I2O
 	tristate "Adaptec I2O RAID support "
-	depends on SCSI && PCI && VIRT_TO_BUS
+	depends on SCSI && PCI
 	help
 	  This driver supports all of Adaptec's I2O based RAID controllers as 
 	  well as the DPT SmartRaid V cards.  This is an Adaptec maintained
diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index 4251212acbbe..43ec5657a935 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -56,7 +56,7 @@ MODULE_DESCRIPTION("Adaptec I2O RAID Driver");
 #include <linux/mutex.h>
 
 #include <asm/processor.h>	/* for boot_cpu_data */
-#include <asm/io.h>		/* for virt_to_bus, etc. */
+#include <asm/io.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
@@ -582,51 +582,6 @@ static int adpt_show_info(struct seq_file *m, struct Scsi_Host *host)
 	return 0;
 }
 
-/*
- *	Turn a pointer to ioctl reply data into an u32 'context'
- */
-static u32 adpt_ioctl_to_context(adpt_hba * pHba, void *reply)
-{
-#if BITS_PER_LONG == 32
-	return (u32)(unsigned long)reply;
-#else
-	ulong flags = 0;
-	u32 nr, i;
-
-	spin_lock_irqsave(pHba->host->host_lock, flags);
-	nr = ARRAY_SIZE(pHba->ioctl_reply_context);
-	for (i = 0; i < nr; i++) {
-		if (pHba->ioctl_reply_context[i] == NULL) {
-			pHba->ioctl_reply_context[i] = reply;
-			break;
-		}
-	}
-	spin_unlock_irqrestore(pHba->host->host_lock, flags);
-	if (i >= nr) {
-		printk(KERN_WARNING"%s: Too many outstanding "
-				"ioctl commands\n", pHba->name);
-		return (u32)-1;
-	}
-
-	return i;
-#endif
-}
-
-/*
- *	Go from an u32 'context' to a pointer to ioctl reply data.
- */
-static void *adpt_ioctl_from_context(adpt_hba *pHba, u32 context)
-{
-#if BITS_PER_LONG == 32
-	return (void *)(unsigned long)context;
-#else
-	void *p = pHba->ioctl_reply_context[context];
-	pHba->ioctl_reply_context[context] = NULL;
-
-	return p;
-#endif
-}
-
 /*===========================================================================
  * Error Handling routines
  *===========================================================================
@@ -1648,208 +1603,6 @@ static int adpt_close(struct inode *inode, struct file *file)
 	return 0;
 }
 
-
-static int adpt_i2o_passthru(adpt_hba* pHba, u32 __user *arg)
-{
-	u32 msg[MAX_MESSAGE_SIZE];
-	u32* reply = NULL;
-	u32 size = 0;
-	u32 reply_size = 0;
-	u32 __user *user_msg = arg;
-	u32 __user * user_reply = NULL;
-	void **sg_list = NULL;
-	u32 sg_offset = 0;
-	u32 sg_count = 0;
-	int sg_index = 0;
-	u32 i = 0;
-	u32 rcode = 0;
-	void *p = NULL;
-	dma_addr_t addr;
-	ulong flags = 0;
-
-	memset(&msg, 0, MAX_MESSAGE_SIZE*4);
-	// get user msg size in u32s 
-	if(get_user(size, &user_msg[0])){
-		return -EFAULT;
-	}
-	size = size>>16;
-
-	user_reply = &user_msg[size];
-	if(size > MAX_MESSAGE_SIZE){
-		return -EFAULT;
-	}
-	size *= 4; // Convert to bytes
-
-	/* Copy in the user's I2O command */
-	if(copy_from_user(msg, user_msg, size)) {
-		return -EFAULT;
-	}
-	get_user(reply_size, &user_reply[0]);
-	reply_size = reply_size>>16;
-	if(reply_size > REPLY_FRAME_SIZE){
-		reply_size = REPLY_FRAME_SIZE;
-	}
-	reply_size *= 4;
-	reply = kzalloc(REPLY_FRAME_SIZE*4, GFP_KERNEL);
-	if(reply == NULL) {
-		printk(KERN_WARNING"%s: Could not allocate reply buffer\n",pHba->name);
-		return -ENOMEM;
-	}
-	sg_offset = (msg[0]>>4)&0xf;
-	msg[2] = 0x40000000; // IOCTL context
-	msg[3] = adpt_ioctl_to_context(pHba, reply);
-	if (msg[3] == (u32)-1) {
-		rcode = -EBUSY;
-		goto free;
-	}
-
-	sg_list = kcalloc(pHba->sg_tablesize, sizeof(*sg_list), GFP_KERNEL);
-	if (!sg_list) {
-		rcode = -ENOMEM;
-		goto free;
-	}
-	if(sg_offset) {
-		// TODO add 64 bit API
-		struct sg_simple_element *sg =  (struct sg_simple_element*) (msg+sg_offset);
-		sg_count = (size - sg_offset*4) / sizeof(struct sg_simple_element);
-		if (sg_count > pHba->sg_tablesize){
-			printk(KERN_DEBUG"%s:IOCTL SG List too large (%u)\n", pHba->name,sg_count);
-			rcode = -EINVAL;
-			goto free;
-		}
-
-		for(i = 0; i < sg_count; i++) {
-			int sg_size;
-
-			if (!(sg[i].flag_count & 0x10000000 /*I2O_SGL_FLAGS_SIMPLE_ADDRESS_ELEMENT*/)) {
-				printk(KERN_DEBUG"%s:Bad SG element %d - not simple (%x)\n",pHba->name,i,  sg[i].flag_count);
-				rcode = -EINVAL;
-				goto cleanup;
-			}
-			sg_size = sg[i].flag_count & 0xffffff;      
-			/* Allocate memory for the transfer */
-			p = dma_alloc_coherent(&pHba->pDev->dev, sg_size, &addr, GFP_KERNEL);
-			if(!p) {
-				printk(KERN_DEBUG"%s: Could not allocate SG buffer - size = %d buffer number %d of %d\n",
-						pHba->name,sg_size,i,sg_count);
-				rcode = -ENOMEM;
-				goto cleanup;
-			}
-			sg_list[sg_index++] = p; // sglist indexed with input frame, not our internal frame.
-			/* Copy in the user's SG buffer if necessary */
-			if(sg[i].flag_count & 0x04000000 /*I2O_SGL_FLAGS_DIR*/) {
-				// sg_simple_element API is 32 bit
-				if (copy_from_user(p,(void __user *)(ulong)sg[i].addr_bus, sg_size)) {
-					printk(KERN_DEBUG"%s: Could not copy SG buf %d FROM user\n",pHba->name,i);
-					rcode = -EFAULT;
-					goto cleanup;
-				}
-			}
-			/* sg_simple_element API is 32 bit, but addr < 4GB */
-			sg[i].addr_bus = addr;
-		}
-	}
-
-	do {
-		/*
-		 * Stop any new commands from enterring the
-		 * controller while processing the ioctl
-		 */
-		if (pHba->host) {
-			scsi_block_requests(pHba->host);
-			spin_lock_irqsave(pHba->host->host_lock, flags);
-		}
-		rcode = adpt_i2o_post_wait(pHba, msg, size, FOREVER);
-		if (rcode != 0)
-			printk("adpt_i2o_passthru: post wait failed %d %p\n",
-					rcode, reply);
-		if (pHba->host) {
-			spin_unlock_irqrestore(pHba->host->host_lock, flags);
-			scsi_unblock_requests(pHba->host);
-		}
-	} while (rcode == -ETIMEDOUT);
-
-	if(rcode){
-		goto cleanup;
-	}
-
-	if(sg_offset) {
-	/* Copy back the Scatter Gather buffers back to user space */
-		u32 j;
-		// TODO add 64 bit API
-		struct sg_simple_element* sg;
-		int sg_size;
-
-		// re-acquire the original message to handle correctly the sg copy operation
-		memset(&msg, 0, MAX_MESSAGE_SIZE*4); 
-		// get user msg size in u32s 
-		if(get_user(size, &user_msg[0])){
-			rcode = -EFAULT; 
-			goto cleanup; 
-		}
-		size = size>>16;
-		size *= 4;
-		if (size > MAX_MESSAGE_SIZE) {
-			rcode = -EINVAL;
-			goto cleanup;
-		}
-		/* Copy in the user's I2O command */
-		if (copy_from_user (msg, user_msg, size)) {
-			rcode = -EFAULT;
-			goto cleanup;
-		}
-		sg_count = (size - sg_offset*4) / sizeof(struct sg_simple_element);
-
-		// TODO add 64 bit API
-		sg 	 = (struct sg_simple_element*)(msg + sg_offset);
-		for (j = 0; j < sg_count; j++) {
-			/* Copy out the SG list to user's buffer if necessary */
-			if(! (sg[j].flag_count & 0x4000000 /*I2O_SGL_FLAGS_DIR*/)) {
-				sg_size = sg[j].flag_count & 0xffffff; 
-				// sg_simple_element API is 32 bit
-				if (copy_to_user((void __user *)(ulong)sg[j].addr_bus,sg_list[j], sg_size)) {
-					printk(KERN_WARNING"%s: Could not copy %p TO user %x\n",pHba->name, sg_list[j], sg[j].addr_bus);
-					rcode = -EFAULT;
-					goto cleanup;
-				}
-			}
-		}
-	} 
-
-	/* Copy back the reply to user space */
-	if (reply_size) {
-		// we wrote our own values for context - now restore the user supplied ones
-		if(copy_from_user(reply+2, user_msg+2, sizeof(u32)*2)) {
-			printk(KERN_WARNING"%s: Could not copy message context FROM user\n",pHba->name);
-			rcode = -EFAULT;
-		}
-		if(copy_to_user(user_reply, reply, reply_size)) {
-			printk(KERN_WARNING"%s: Could not copy reply TO user\n",pHba->name);
-			rcode = -EFAULT;
-		}
-	}
-
-
-cleanup:
-	if (rcode != -ETIME && rcode != -EINTR) {
-		struct sg_simple_element *sg =
-				(struct sg_simple_element*) (msg +sg_offset);
-		while(sg_index) {
-			if(sg_list[--sg_index]) {
-				dma_free_coherent(&pHba->pDev->dev,
-					sg[sg_index].flag_count & 0xffffff,
-					sg_list[sg_index],
-					sg[sg_index].addr_bus);
-			}
-		}
-	}
-
-free:
-	kfree(sg_list);
-	kfree(reply);
-	return rcode;
-}
-
 #if defined __ia64__ 
 static void adpt_ia64_info(sysInfo_S* si)
 {
@@ -1976,8 +1729,6 @@ static int adpt_ioctl(struct inode *inode, struct file *file, uint cmd, ulong ar
 			return -EFAULT;
 		}
 		break;
-	case I2OUSRCMD:
-		return adpt_i2o_passthru(pHba, argp);
 
 	case DPT_CTRLINFO:{
 		drvrHBAinfo_S HbaInfo;
@@ -2114,7 +1865,7 @@ static irqreturn_t adpt_isr(int irq, void *dev_id)
 		} else {
 			/* Ick, we should *never* be here */
 			printk(KERN_ERR "dpti: reply frame not from pool\n");
-			reply = (u8 *)bus_to_virt(m);
+			continue;
 		}
 
 		if (readl(reply) & MSG_FAIL) {
@@ -2134,13 +1885,6 @@ static irqreturn_t adpt_isr(int irq, void *dev_id)
 			adpt_send_nop(pHba, old_m);
 		} 
 		context = readl(reply+8);
-		if(context & 0x40000000){ // IOCTL
-			void *p = adpt_ioctl_from_context(pHba, readl(reply+12));
-			if( p != NULL) {
-				memcpy_fromio(p, reply, REPLY_FRAME_SIZE * 4);
-			}
-			// All IOCTLs will also be post wait
-		}
 		if(context & 0x80000000){ // Post wait message
 			status = readl(reply+16);
 			if(status  >> 24){
@@ -2148,16 +1892,14 @@ static irqreturn_t adpt_isr(int irq, void *dev_id)
 			} else {
 				status = I2O_POST_WAIT_OK;
 			}
-			if(!(context & 0x40000000)) {
-				/*
-				 * The request tag is one less than the command tag
-				 * as the firmware might treat a 0 tag as invalid
-				 */
-				cmd = scsi_host_find_tag(pHba->host,
-							 readl(reply + 12) - 1);
-				if(cmd != NULL) {
-					printk(KERN_WARNING"%s: Apparent SCSI cmd in Post Wait Context - cmd=%p context=%x\n", pHba->name, cmd, context);
-				}
+			/*
+			 * The request tag is one less than the command tag
+			 * as the firmware might treat a 0 tag as invalid
+			 */
+			cmd = scsi_host_find_tag(pHba->host,
+						 readl(reply + 12) - 1);
+			if(cmd != NULL) {
+				printk(KERN_WARNING"%s: Apparent SCSI cmd in Post Wait Context - cmd=%p context=%x\n", pHba->name, cmd, context);
 			}
 			adpt_i2o_post_wait_complete(context, status);
 		} else { // SCSI message
diff --git a/drivers/scsi/dpti.h b/drivers/scsi/dpti.h
index 8a079e8d7f65..0565533e8095 100644
--- a/drivers/scsi/dpti.h
+++ b/drivers/scsi/dpti.h
@@ -248,7 +248,6 @@ typedef struct _adpt_hba {
 	void __iomem *FwDebugBLEDflag_P;// Virtual Addr Of FW Debug BLED
 	void __iomem *FwDebugBLEDvalue_P;// Virtual Addr Of FW Debug BLED
 	u32 FwDebugFlags;
-	u32 *ioctl_reply_context[4];
 } adpt_hba;
 
 struct sg_simple_element {
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 6f3d29d16d1f..99b90031500b 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1490,6 +1490,7 @@ static int scsi_dispatch_cmd(struct scsi_cmnd *cmd)
 		 */
 		SCSI_LOG_MLQUEUE(3, scmd_printk(KERN_INFO, cmd,
 			"queuecommand : device blocked\n"));
+		atomic_dec(&cmd->device->iorequest_cnt);
 		return SCSI_MLQUEUE_DEVICE_BUSY;
 	}
 
@@ -1522,6 +1523,7 @@ static int scsi_dispatch_cmd(struct scsi_cmnd *cmd)
 	trace_scsi_dispatch_cmd_start(cmd);
 	rtn = host->hostt->queuecommand(host, cmd);
 	if (rtn) {
+		atomic_dec(&cmd->device->iorequest_cnt);
 		trace_scsi_dispatch_cmd_error(cmd, rtn);
 		if (rtn != SCSI_MLQUEUE_DEVICE_BUSY &&
 		    rtn != SCSI_MLQUEUE_TARGET_BUSY)
diff --git a/drivers/scsi/stex.c b/drivers/scsi/stex.c
index a3bce11ed4b4..fa607f218250 100644
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
index c0ffad1572c6..b6694ddfc4ea 100644
--- a/drivers/tty/serial/8250/8250_tegra.c
+++ b/drivers/tty/serial/8250/8250_tegra.c
@@ -111,13 +111,15 @@ static int tegra_uart_probe(struct platform_device *pdev)
 
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
 
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index a2efa81471f3..ca22a1125821 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1455,34 +1455,36 @@ static void lpuart_break_ctl(struct uart_port *port, int break_state)
 
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
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 8c48c9f801be..b17acab77fe2 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -3609,6 +3609,7 @@ static void ffs_func_unbind(struct usb_configuration *c,
 	/* Drain any pending AIO completions */
 	drain_workqueue(ffs->io_completion_wq);
 
+	ffs_event_add(ffs, FUNCTIONFS_UNBIND);
 	if (!--opts->refcnt)
 		functionfs_unbind(ffs);
 
@@ -3633,7 +3634,6 @@ static void ffs_func_unbind(struct usb_configuration *c,
 	func->function.ssp_descriptors = NULL;
 	func->interfaces_nums = NULL;
 
-	ffs_event_add(ffs, FUNCTIONFS_UNBIND);
 }
 
 static struct usb_function *ffs_alloc(struct usb_function_instance *fi)
diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index 9725ecd1255b..8e095b0982db 100644
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
index 3e55245e54e7..41a7ace9998e 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3872,6 +3872,7 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 
 	if (check_sibling_keys(left, right)) {
 		ret = -EUCLEAN;
+		btrfs_abort_transaction(trans, ret);
 		btrfs_tree_unlock(right);
 		free_extent_buffer(right);
 		return ret;
@@ -4116,6 +4117,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 
 	if (check_sibling_keys(left, right)) {
 		ret = -EUCLEAN;
+		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 	return __push_leaf_left(path, min_data_size,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 60b7a227624d..5a114cad988a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -220,7 +220,7 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
 	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
 			    PAGE_SIZE - BTRFS_CSUM_SIZE);
 
-	for (i = 1; i < num_pages; i++) {
+	for (i = 1; i < num_pages && INLINE_EXTENT_BUFFER_PAGES > 1; i++) {
 		kaddr = page_address(buf->pages[i]);
 		crypto_shash_update(shash, kaddr, PAGE_SIZE);
 	}
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 84a240025aa4..c8fdf127d843 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -980,11 +980,13 @@ do {									       \
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
 
 
@@ -2849,7 +2851,8 @@ typedef enum {
 	EXT4_IGET_NORMAL =	0,
 	EXT4_IGET_SPECIAL =	0x0001, /* OK to iget a system inode */
 	EXT4_IGET_HANDLE = 	0x0002,	/* Inode # is from a handle */
-	EXT4_IGET_BAD =		0x0004  /* Allow to iget a bad inode */
+	EXT4_IGET_BAD =		0x0004, /* Allow to iget a bad inode */
+	EXT4_IGET_EA_INODE =	0x0008	/* Inode should contain an EA value */
 } ext4_iget_flags;
 
 extern struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 735109b9e88d..d3143746bcdb 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4680,6 +4680,24 @@ static inline u64 ext4_inode_peek_iversion(const struct inode *inode)
 		return inode_peek_iversion(inode);
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
@@ -4688,6 +4706,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	struct ext4_inode *raw_inode;
 	struct ext4_inode_info *ei;
 	struct inode *inode;
+	const char *err_str;
 	journal_t *journal = EXT4_SB(sb)->s_journal;
 	long ret;
 	loff_t size;
@@ -4711,8 +4730,14 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
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
@@ -4981,10 +5006,9 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
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
index d89750e90bc4..f72896384dbc 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6005,18 +6005,6 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
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
@@ -6054,6 +6042,18 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
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
index abcba0255109..10b2f570d400 100644
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
@@ -1500,11 +1484,11 @@ ext4_xattr_inode_cache_find(struct inode *inode, const void *value,
 
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
@@ -1514,9 +1498,8 @@ ext4_xattr_inode_cache_find(struct inode *inode, const void *value,
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
index 5cb7e771b57a..e01b6a2d12d3 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1416,6 +1416,14 @@ static void gfs2_evict_inode(struct inode *inode)
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
diff --git a/include/net/sock.h b/include/net/sock.h
index 651dc0a7bbd5..3da0601b573e 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -326,6 +326,7 @@ struct bpf_local_storage;
   *	@sk_cgrp_data: cgroup data for this cgroup
   *	@sk_memcg: this socket's memory cgroup association
   *	@sk_write_pending: a write to stream socket waits to start
+  *	@sk_wait_pending: number of threads blocked on this socket
   *	@sk_state_change: callback to indicate change in the state of the sock
   *	@sk_data_ready: callback to indicate there is data to be processed
   *	@sk_write_space: callback to indicate there is bf sending space available
@@ -410,6 +411,7 @@ struct sock {
 	unsigned int		sk_napi_id;
 #endif
 	int			sk_rcvbuf;
+	int			sk_wait_pending;
 
 	struct sk_filter __rcu	*sk_filter;
 	union {
@@ -1095,6 +1097,7 @@ static inline void sock_rps_reset_rxhash(struct sock *sk)
 
 #define sk_wait_event(__sk, __timeo, __condition, __wait)		\
 	({	int __rc;						\
+		__sk->sk_wait_pending++;				\
 		release_sock(__sk);					\
 		__rc = __condition;					\
 		if (!__rc) {						\
@@ -1104,6 +1107,7 @@ static inline void sock_rps_reset_rxhash(struct sock *sk)
 		}							\
 		sched_annotate_sleep();					\
 		lock_sock(__sk);					\
+		__sk->sk_wait_pending--;				\
 		__rc = __condition;					\
 		__rc;							\
 	})
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 6d41e20c47ce..d4a69b83902e 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -301,7 +301,7 @@ trace_probe_primary_from_call(struct trace_event_call *call)
 {
 	struct trace_probe_event *tpe = trace_probe_event_from_call(call);
 
-	return list_first_entry(&tpe->probes, struct trace_probe, list);
+	return list_first_entry_or_null(&tpe->probes, struct trace_probe, list);
 }
 
 static inline struct list_head *trace_probe_probe_list(struct trace_probe *tp)
diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 76550d2e2edc..581ee3fcdd5c 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -41,6 +41,7 @@ struct test_batched_req {
 	bool sent;
 	const struct firmware *fw;
 	const char *name;
+	const char *fw_buf;
 	struct completion completion;
 	struct task_struct *task;
 	struct device *dev;
@@ -143,8 +144,14 @@ static void __test_release_all_firmware(void)
 
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
@@ -589,6 +596,8 @@ static ssize_t trigger_request_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 	release_firmware(test_firmware);
+	if (test_fw_config->reqs)
+		__test_release_all_firmware();
 	test_firmware = NULL;
 	rc = request_firmware(&test_firmware, name, dev);
 	if (rc) {
@@ -689,6 +698,8 @@ static ssize_t trigger_async_request_store(struct device *dev,
 	mutex_lock(&test_fw_mutex);
 	release_firmware(test_firmware);
 	test_firmware = NULL;
+	if (test_fw_config->reqs)
+		__test_release_all_firmware();
 	rc = request_firmware_nowait(THIS_MODULE, 1, name, dev, GFP_KERNEL,
 				     NULL, trigger_async_request_cb);
 	if (rc) {
@@ -731,6 +742,8 @@ static ssize_t trigger_custom_fallback_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 	release_firmware(test_firmware);
+	if (test_fw_config->reqs)
+		__test_release_all_firmware();
 	test_firmware = NULL;
 	rc = request_firmware_nowait(THIS_MODULE, FW_ACTION_NOHOTPLUG, name,
 				     dev, GFP_KERNEL, NULL,
@@ -793,6 +806,8 @@ static int test_fw_run_batch_request(void *data)
 						 test_fw_config->buf_size);
 		if (!req->fw)
 			kfree(test_buf);
+		else
+			req->fw_buf = test_buf;
 	} else {
 		req->rc = test_fw_config->req_firmware(&req->fw,
 						       req->name,
@@ -848,6 +863,7 @@ static ssize_t trigger_batched_requests_store(struct device *dev,
 		req->fw = NULL;
 		req->idx = i;
 		req->name = test_fw_config->name;
+		req->fw_buf = NULL;
 		req->dev = dev;
 		init_completion(&req->completion);
 		req->task = kthread_run(test_fw_run_batch_request, req,
@@ -947,6 +963,7 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
 	for (i = 0; i < test_fw_config->num_requests; i++) {
 		req = &test_fw_config->reqs[i];
 		req->name = test_fw_config->name;
+		req->fw_buf = NULL;
 		req->fw = NULL;
 		req->idx = i;
 		init_completion(&req->completion);
diff --git a/net/atm/resources.c b/net/atm/resources.c
index 53236986dfe0..3ad39ae97132 100644
--- a/net/atm/resources.c
+++ b/net/atm/resources.c
@@ -403,6 +403,7 @@ int atm_dev_ioctl(unsigned int cmd, void __user *buf, int __user *sioc_len,
 	return error;
 }
 
+#ifdef CONFIG_PROC_FS
 void *atm_dev_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	mutex_lock(&atm_dev_mutex);
@@ -418,3 +419,4 @@ void *atm_dev_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	return seq_list_next(v, &atm_devs, pos);
 }
+#endif
diff --git a/net/core/sock.c b/net/core/sock.c
index c5ae520d4a69..9b013d052a72 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2016,7 +2016,6 @@ void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
 {
 	u32 max_segs = 1;
 
-	sk_dst_set(sk, dst);
 	sk->sk_route_caps = dst->dev->features | sk->sk_route_forced_caps;
 	if (sk->sk_route_caps & NETIF_F_GSO)
 		sk->sk_route_caps |= NETIF_F_GSO_SOFTWARE;
@@ -2031,6 +2030,7 @@ void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
 		}
 	}
 	sk->sk_gso_max_segs = max_segs;
+	sk_dst_set(sk, dst);
 }
 EXPORT_SYMBOL_GPL(sk_setup_caps);
 
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 800c2c7607e1..acb4887351da 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -584,6 +584,7 @@ static long inet_wait_for_connect(struct sock *sk, long timeo, int writebias)
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	sk->sk_write_pending += writebias;
+	sk->sk_wait_pending++;
 
 	/* Basic assumption: if someone sets sk->sk_err, he _must_
 	 * change state of the socket from TCP_SYN_*.
@@ -599,6 +600,7 @@ static long inet_wait_for_connect(struct sock *sk, long timeo, int writebias)
 	}
 	remove_wait_queue(sk_sleep(sk), &wait);
 	sk->sk_write_pending -= writebias;
+	sk->sk_wait_pending--;
 	return timeo;
 }
 
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index e05dd87848f7..406305aaec90 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -839,6 +839,7 @@ struct sock *inet_csk_clone_lock(const struct sock *sk,
 	if (newsk) {
 		struct inet_connection_sock *newicsk = inet_csk(newsk);
 
+		newsk->sk_wait_pending = 0;
 		inet_sk_set_state(newsk, TCP_SYN_RECV);
 		newicsk->icsk_bind_hash = NULL;
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index eecce63ba25e..82abbf192985 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2748,6 +2748,12 @@ int tcp_disconnect(struct sock *sk, int flags)
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
 
@@ -3713,7 +3719,8 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 	switch (optname) {
 	case TCP_MAXSEG:
 		val = tp->mss_cache;
-		if (!val && ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)))
+		if (tp->rx_opt.user_mss &&
+		    ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)))
 			val = tp->rx_opt.user_mss;
 		if (tp->repair)
 			val = tp->rx_opt.mss_clamp;
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 6a055a221683..ceb7c988edef 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -2968,7 +2968,9 @@ static int ctnetlink_exp_dump_mask(struct sk_buff *skb,
 	return -1;
 }
 
+#if IS_ENABLED(CONFIG_NF_NAT)
 static const union nf_inet_addr any_addr;
+#endif
 
 static __be32 nf_expect_get_id(const struct nf_conntrack_expect *exp)
 {
@@ -3458,10 +3460,12 @@ ctnetlink_change_expect(struct nf_conntrack_expect *x,
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
index 651f8ca912af..99c869d8d304 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1781,7 +1781,7 @@ static int netlink_getsockopt(struct socket *sock, int level, int optname,
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
index 3c05414cd3f8..c7129616dd53 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3157,6 +3157,9 @@ static int packet_do_bind(struct sock *sk, const char *name, int ifindex,
 
 	lock_sock(sk);
 	spin_lock(&po->bind_lock);
+	if (!proto)
+		proto = po->num;
+
 	rcu_read_lock();
 
 	if (po->fanout) {
@@ -3259,7 +3262,7 @@ static int packet_bind_spkt(struct socket *sock, struct sockaddr *uaddr,
 	memcpy(name, uaddr->sa_data, sizeof(uaddr->sa_data));
 	name[sizeof(uaddr->sa_data)] = 0;
 
-	return packet_do_bind(sk, name, 0, pkt_sk(sk)->num);
+	return packet_do_bind(sk, name, 0, 0);
 }
 
 static int packet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
@@ -3276,8 +3279,7 @@ static int packet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len
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
index 35ee6d8226e6..caf1a05bfbde 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -1086,6 +1086,9 @@ static int fl_set_geneve_opt(const struct nlattr *nla, struct fl_flow_key *key,
 	if (option_len > sizeof(struct geneve_opt))
 		data_len = option_len - sizeof(struct geneve_opt);
 
+	if (key->enc_opts.len > FLOW_DIS_TUN_OPTS_MAX - 4)
+		return -ERANGE;
+
 	opt = (struct geneve_opt *)&key->enc_opts.data[key->enc_opts.len];
 	memset(opt, 0xff, option_len);
 	opt->length = data_len / 4;
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 54e2309315eb..2084724c36ad 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1223,7 +1223,12 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
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
@@ -1584,11 +1589,20 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
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
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 295685492853..d3b128b74a38 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3240,7 +3240,7 @@ xfrm_secpath_reject(int idx, struct sk_buff *skb, const struct flowi *fl)
 
 static inline int
 xfrm_state_ok(const struct xfrm_tmpl *tmpl, const struct xfrm_state *x,
-	      unsigned short family)
+	      unsigned short family, u32 if_id)
 {
 	if (xfrm_state_kern(x))
 		return tmpl->optional && !xfrm_state_addr_cmp(tmpl, x, tmpl->encap_family);
@@ -3251,7 +3251,8 @@ xfrm_state_ok(const struct xfrm_tmpl *tmpl, const struct xfrm_state *x,
 		(tmpl->allalgs || (tmpl->aalgos & (1<<x->props.aalgo)) ||
 		 !(xfrm_id_proto_match(tmpl->id.proto, IPSEC_PROTO_ANY))) &&
 		!(x->props.mode != XFRM_MODE_TRANSPORT &&
-		  xfrm_state_addr_cmp(tmpl, x, family));
+		  xfrm_state_addr_cmp(tmpl, x, family)) &&
+		(if_id == 0 || if_id == x->if_id);
 }
 
 /*
@@ -3263,7 +3264,7 @@ xfrm_state_ok(const struct xfrm_tmpl *tmpl, const struct xfrm_state *x,
  */
 static inline int
 xfrm_policy_ok(const struct xfrm_tmpl *tmpl, const struct sec_path *sp, int start,
-	       unsigned short family)
+	       unsigned short family, u32 if_id)
 {
 	int idx = start;
 
@@ -3273,7 +3274,7 @@ xfrm_policy_ok(const struct xfrm_tmpl *tmpl, const struct sec_path *sp, int star
 	} else
 		start = -1;
 	for (; idx < sp->len; idx++) {
-		if (xfrm_state_ok(tmpl, sp->xvec[idx], family))
+		if (xfrm_state_ok(tmpl, sp->xvec[idx], family, if_id))
 			return ++idx;
 		if (sp->xvec[idx]->props.mode != XFRM_MODE_TRANSPORT) {
 			if (start == -1)
@@ -3689,7 +3690,7 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 		 * are implied between each two transformations.
 		 */
 		for (i = xfrm_nr-1, k = 0; i >= 0; i--) {
-			k = xfrm_policy_ok(tpp[i], sp, k, family);
+			k = xfrm_policy_ok(tpp[i], sp, k, family, if_id);
 			if (k < 0) {
 				if (k < -1)
 					/* "-2 - errored_index" returned */
diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index ee1ddda96447..332a1c752b49 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -24,5 +24,9 @@ quiet_cmd_flask = GEN     $(obj)/flask.h $(obj)/av_permissions.h
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
index de1fe604905f..1f641712233e 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -264,6 +264,7 @@ enum {
 	AZX_DRIVER_ATI,
 	AZX_DRIVER_ATIHDMI,
 	AZX_DRIVER_ATIHDMI_NS,
+	AZX_DRIVER_GFHDMI,
 	AZX_DRIVER_VIA,
 	AZX_DRIVER_SIS,
 	AZX_DRIVER_ULI,
@@ -386,6 +387,7 @@ static const char * const driver_short_names[] = {
 	[AZX_DRIVER_ATI] = "HDA ATI SB",
 	[AZX_DRIVER_ATIHDMI] = "HDA ATI HDMI",
 	[AZX_DRIVER_ATIHDMI_NS] = "HDA ATI HDMI",
+	[AZX_DRIVER_GFHDMI] = "HDA GF HDMI",
 	[AZX_DRIVER_VIA] = "HDA VIA VT82xx",
 	[AZX_DRIVER_SIS] = "HDA SIS966",
 	[AZX_DRIVER_ULI] = "HDA ULI M5461",
@@ -1783,6 +1785,12 @@ static int default_bdl_pos_adj(struct azx *chip)
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
@@ -1902,6 +1910,12 @@ static int azx_first_init(struct azx *chip)
 		pci_write_config_dword(pci, PCI_BASE_ADDRESS_1, 0);
 	}
 #endif
+	/*
+	 * Fix response write request not synced to memory when handle
+	 * hdac interrupt on Glenfly Gpus
+	 */
+	if (chip->driver_type == AZX_DRIVER_GFHDMI)
+		bus->polling_mode = 1;
 
 	err = pci_request_regions(pci, "ICH HD audio");
 	if (err < 0)
@@ -2011,6 +2025,7 @@ static int azx_first_init(struct azx *chip)
 			chip->playback_streams = ATIHDMI_NUM_PLAYBACK;
 			chip->capture_streams = ATIHDMI_NUM_CAPTURE;
 			break;
+		case AZX_DRIVER_GFHDMI:
 		case AZX_DRIVER_GENERIC:
 		default:
 			chip->playback_streams = ICH6_NUM_PLAYBACK;
@@ -2756,6 +2771,12 @@ static const struct pci_device_id azx_ids[] = {
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
index e4366fea9e27..c19afe486194 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -4287,6 +4287,22 @@ static int patch_via_hdmi(struct hda_codec *codec)
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
@@ -4381,6 +4397,12 @@ HDA_CODEC_ENTRY(0x10de00a6, "GPU a6 HDMI/DP",	patch_nvhdmi),
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
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 905160246614..c7a90c34d8f0 100644
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
index 36da0f01571a..5469399abcb4 100644
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
diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 00bb158b4a5d..7072ef1c0ae7 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -10,7 +10,7 @@ TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
 
 TEST_GEN_FILES = mptcp_connect pm_nl_ctl
 
-TEST_FILES := settings
+TEST_FILES := mptcp_lib.sh settings
 
 EXTRA_CLEAN := *.pcap
 
diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 39edce4f541c..34577d469f58 100755
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
@@ -28,6 +30,8 @@ cleanup()
 	done
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 987a914ee0df..fb89298bdde4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 time_start=$(date +%s)
 
 optstring="S:R:d:e:l:r:h4cm:f:t"
@@ -131,6 +133,8 @@ cleanup()
 	done
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 08f53d86dedc..94b15bb28e11 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 ret=0
 sin=""
 sout=""
@@ -88,6 +90,8 @@ for arg in "$@"; do
 	fi
 done
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
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
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 15f4f46ca3a9..f7cdba0a97a9 100755
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
index 8fcb28927818..b51afba244be 100755
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
@@ -31,6 +33,8 @@ cleanup()
 	done
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
