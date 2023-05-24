Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5B070FC65
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbjEXRLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 13:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbjEXRK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:10:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674071B4;
        Wed, 24 May 2023 10:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684948229; x=1716484229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=9/5gnc/XJECGIE2pSVhiuudjhsgUa8FK7B6AwTL6aPs=;
  b=NEb0W29QdfC3QIIdcM/MMs2Dbaad0R7hk1yfPy31CJeKmmkQqBYmcgkN
   Qd+ztOcSAXdmpF8hNIXGKzw2BQ7SM3O4soyTcWQbxTTiquQfTH8WeEfYW
   pz5nJme7bRUKeCKn8C7w+jq7bF6rDliRZ18DNlq1fti81AxvKP2KC104t
   Xf6LGcUSIyesXZWEt/T9PiXVy0g2LTwyHIZ4zFwVQMz7/6cuHt7w3LZAl
   +docfbGcjPcEyCpT5PwCHuI+llxDML9Eislr8L8y7t1uM55yuseA+5ejL
   cYTp6u1fCnt0ZcJHURYQWCBFMp7iHlHvQqBUwyqd1heXTc1OBoM4wZJ9m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="338206830"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="338206830"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:09:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="704427378"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="704427378"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga002.jf.intel.com with ESMTP; 24 May 2023 10:09:57 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com
Cc:     ebiggers@kernel.org, elliott@hpe.com, gmazyland@gmail.com,
        luto@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        bp@alien8.de, mingo@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au, ardb@kernel.org,
        dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com, nhuck@google.com,
        chang.seok.bae@intel.com, "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v7 12/12] crypto: x86/aes-kl - Implement the AES-XTS algorithm
Date:   Wed, 24 May 2023 09:57:17 -0700
Message-Id: <20230524165717.14062-13-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230524165717.14062-1-chang.seok.bae@intel.com>
References: <20230410225936.8940-1-chang.seok.bae@intel.com>
 <20230524165717.14062-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Key Locker is a CPU feature to reduce key exfiltration opportunities.
It converts the AES key into an encoded form, called 'key handle', to
reduce the exposure of private key material in memory.

This key conversion as well as all subsequent data transformation are
provided by new AES instructions ('AES-KL'). AES-KL is analogous to
that of AES-NI as maintains a similar programming interface.

Support the XTS mode as the primary use case is dm-crypt. The
implementation has some details worth mentioning, which differentiate
itself from others, that users may need to be aware of:

== Key Handle Restriction ==

A key handle may be encoded with some restrictions. Restrict every
handle only available in kernel mode via setkey().

Subsequently the key handle could be corrupted or fail with handle
restrictions. Then, encrypt()/decrypt() returns -EINVAL.

== API Limitation ==

The setkey() function transforms an AES key into a handle. But, an
extended key is a usual outcome of setkey() in other AES cipher
implementations. For this reason, a setkey() failure does not fall
back to the other. So, expose AES-KL methods via synchronous
interfaces only.

=== AES Compliance ===

Key Locker is not AES compliant as it lacks 192-bit key support.
However, per the expectations of Linux crypto-cipher implementations
the software cipher implementation must support all the AES-compliant
key sizes.

The AES-KL cipher implementation achieves this constraint by logging a
warning and falling back to AES-NI. In other words, the 192-bit
key-size limitation for what can be converted into a key handle is
only documented, not enforced.

== Wrapping Key Restore Failure ==

The failure of setkey() as well as encode()/decode() is also possible
with the wrapping key failure. In the event of hardware failure, the
wrapping key is lost from deep sleep states. Then, those functions
return -ENODEV as the feature is disabled.

== Userspace Exposition ==

Some hardware implementations may have some performance penalties.
E.g., the cryptsetup benchmark indicates the raw throughput is
measurably slower than AES-NI. But, for disk encryption, storage
bandwidth may be the bottleneck before encryption bandwidth.

This, along with the above points, is an end-user consideration for
selecting AES-KL over AES-NI. Thus, advertise it with a unique name
'xts-aes-aeskl' in /proc/crypto while not replacing AES-NI under the
generic name 'xts(aes)' with a lower priority.

== 64-bit Only ==

AES-KL provides wide instructions that process eight blocks at once
which can boost the AES performance. Leveraging those, the code needs
to clobber more than eight 128-bit registers.

But, the 32-bit does not have enough wide registers. Then, the
performance is unlikely better than 64-bit which has already a gap vs.
AES-NI. So, simply make it for the 64-bit mode only at the moment.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Milan Broz <gmazyland@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v6:
* Merge all the AES-KL patches. (Eric Biggers)
* Make the driver for the 64-bit mode only. (Eric Biggers)
* Rework the key-size check code:
  - Trim unnecessary checks. (Eric Biggers)
  - Document the reason
  - Make sure both XTS keys with the same size
* Adjust the Kconfig change:
  - Move the location. (Robert Elliott)
  - Trim the description to follow others such as AES-NI.
* Update the changelog:
  - Explain the priority value for the common name under 'User
    Exposition' (renamed from 'Performance'). (Eric Biggers)
  - Trim the introduction
  - Switch to more imperative mood for those explaining the code
    change
  - Add a new section '64-bit Only'
* Adjust the ASM code to return a proper error code. (Eric Biggers)
* Update assembly code macros:
  - Remove unused one.
  - Document the reason for the duplicated ones.

Changes from v5:
* Replace the ret instruction with RET as rebased on the upstream -- commit
  f94909ceb1ed ("x86: Prepare asm files for straight-line-speculation").

Changes from v3:
* Exclude non-AES-KL objects. (Eric Biggers)
* Simplify the assembler dependency check. (Peter Zijlstra)
* Trim the Kconfig help text. (Dan Williams)
* Fix a defined-but-not-used warning.

Changes from RFC v2:
* Move out each mode support in new patches.
* Update the changelog to describe the limitation and the tradeoff
  clearly. (Andy Lutomirski)

Changes from RFC v1:
* Rebased on the refactored code. (Ard Biesheuvel)
* Dropped exporting the single block interface. (Ard Biesheuvel)
* Fixed the fallback and error handling paths. (Ard Biesheuvel)
* Revised the module description. (Dave Hansen and Peter Zijlsta)
* Made the build depend on the binutils version to support new
  instructions. (Borislav Petkov and Peter Zijlstra)
* Updated the changelog accordingly.
Link: https://lore.kernel.org/lkml/CAMj1kXGa4f21eH0mdxd1pQsZMUjUr1Btq+Dgw-gC=O-yYft7xw@mail.gmail.com/
---
 arch/x86/crypto/Kconfig            |  22 ++
 arch/x86/crypto/Makefile           |   3 +
 arch/x86/crypto/aeskl-intel_asm.S  | 580 +++++++++++++++++++++++++++++
 arch/x86/crypto/aeskl-intel_glue.c | 216 +++++++++++
 arch/x86/crypto/aesni-intel_asm.S  |   8 +-
 arch/x86/crypto/aesni-intel_glue.c |  40 +-
 arch/x86/crypto/aesni-intel_glue.h |  17 +
 7 files changed, 873 insertions(+), 13 deletions(-)
 create mode 100644 arch/x86/crypto/aeskl-intel_asm.S
 create mode 100644 arch/x86/crypto/aeskl-intel_glue.c
 create mode 100644 arch/x86/crypto/aesni-intel_glue.h

diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
index 9bbfd01cfa2f..658adfd7aebf 100644
--- a/arch/x86/crypto/Kconfig
+++ b/arch/x86/crypto/Kconfig
@@ -2,6 +2,11 @@
 
 menu "Accelerated Cryptographic Algorithms for CPU (x86)"
 
+config AS_HAS_KEYLOCKER
+	def_bool $(as-instr,encodekey256 %eax$(comma)%eax)
+	help
+	  Supported by binutils >= 2.36 and LLVM integrated assembler >= V12
+
 config CRYPTO_CURVE25519_X86
 	tristate "Public key crypto: Curve25519 (ADX)"
 	depends on X86 && 64BIT
@@ -29,6 +34,23 @@ config CRYPTO_AES_NI_INTEL
 	  Architecture: x86 (32-bit and 64-bit) using:
 	  - AES-NI (AES new instructions)
 
+config CRYPTO_AES_KL
+	tristate "Ciphers: AES, modes: XTS (AES-KL)"
+	depends on X86 && 64BIT
+	depends on AS_HAS_KEYLOCKER
+	depends on CRYPTO_AES_NI_INTEL
+	select X86_KEYLOCKER
+
+	help
+	  Block cipher: AES cipher algorithms
+	  Length-preserving ciphers: AES with XTS
+
+	  Architecture: x86 (64-bit) using:
+	  - AES-KL (AES Key Locker)
+	  - AES-NI for a 192-bit key
+
+	  See Documentation/arch/x86/keylocker.rst for more details.
+
 config CRYPTO_BLOWFISH_X86_64
 	tristate "Ciphers: Blowfish, modes: ECB, CBC"
 	depends on X86 && 64BIT
diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
index 9aa46093c91b..ae2aa7abd151 100644
--- a/arch/x86/crypto/Makefile
+++ b/arch/x86/crypto/Makefile
@@ -50,6 +50,9 @@ obj-$(CONFIG_CRYPTO_AES_NI_INTEL) += aesni-intel.o
 aesni-intel-y := aesni-intel_asm.o aesni-intel_glue.o
 aesni-intel-$(CONFIG_64BIT) += aesni-intel_avx-x86_64.o aes_ctrby8_avx-x86_64.o
 
+obj-$(CONFIG_CRYPTO_AES_KL) += aeskl-intel.o
+aeskl-intel-y := aeskl-intel_asm.o aeskl-intel_glue.o
+
 obj-$(CONFIG_CRYPTO_SHA1_SSSE3) += sha1-ssse3.o
 sha1-ssse3-y := sha1_avx2_x86_64_asm.o sha1_ssse3_asm.o sha1_ssse3_glue.o
 sha1-ssse3-$(CONFIG_AS_SHA1_NI) += sha1_ni_asm.o
diff --git a/arch/x86/crypto/aeskl-intel_asm.S b/arch/x86/crypto/aeskl-intel_asm.S
new file mode 100644
index 000000000000..402dd7796375
--- /dev/null
+++ b/arch/x86/crypto/aeskl-intel_asm.S
@@ -0,0 +1,580 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Implement AES algorithm using AES Key Locker instructions.
+ *
+ * Most code is based from the AES-NI implementation, aesni-intel_asm.S
+ *
+ */
+
+#include <linux/linkage.h>
+#include <linux/cfi_types.h>
+#include <asm/errno.h>
+#include <asm/inst.h>
+#include <asm/frame.h>
+#include "aes-helper_asm.S"
+
+.text
+
+#define STATE1	%xmm0
+#define STATE2	%xmm1
+#define STATE3	%xmm2
+#define STATE4	%xmm3
+#define STATE5	%xmm4
+#define STATE6	%xmm5
+#define STATE7	%xmm6
+#define STATE8	%xmm7
+#define STATE	STATE1
+
+#define IV	%xmm9
+#define KEY	%xmm10
+#define INC	%xmm13
+
+#define IN1	%xmm8
+#define IN	IN1
+
+#define AREG	%rax
+#define HANDLEP	%rdi
+#define OUTP	%rsi
+#define KLEN	%r9d
+#define INP	%rdx
+#define T1	%r10
+#define LEN	%rcx
+#define IVP	%r8
+
+#define UKEYP	OUTP
+#define GF128MUL_MASK %xmm11
+
+/*
+ * int aeskl_setkey(struct crypto_aes_ctx *ctx, const u8 *in_key, unsigned int key_len)
+ */
+SYM_FUNC_START(aeskl_setkey)
+	FRAME_BEGIN
+	movl %edx, 480(HANDLEP)
+	movdqu (UKEYP), STATE1
+	mov $1, %eax
+	cmp $16, %dl
+	je .Lsetkey_128
+
+	movdqu 0x10(UKEYP), STATE2
+	encodekey256 %eax, %eax
+	movdqu STATE4, 0x30(HANDLEP)
+	jmp .Lsetkey_end
+.Lsetkey_128:
+	encodekey128 %eax, %eax
+
+.Lsetkey_end:
+	movdqu STATE1, (HANDLEP)
+	movdqu STATE2, 0x10(HANDLEP)
+	movdqu STATE3, 0x20(HANDLEP)
+
+	xor AREG, AREG
+	FRAME_END
+	RET
+SYM_FUNC_END(aeskl_setkey)
+
+/*
+ * int __aeskl_enc(const void *ctx, u8 *dst, const u8 *src)
+ */
+SYM_FUNC_START(__aeskl_enc)
+	FRAME_BEGIN
+	movdqu (INP), STATE
+	movl 480(HANDLEP), KLEN
+
+	cmp $16, KLEN
+	je .Lenc_128
+	aesenc256kl (HANDLEP), STATE
+	jz .Lenc_err
+	jmp .Lenc_noerr
+.Lenc_128:
+	aesenc128kl (HANDLEP), STATE
+	jz .Lenc_err
+
+.Lenc_noerr:
+	xor AREG, AREG
+	jmp .Lenc_end
+.Lenc_err:
+	mov $(-EINVAL), AREG
+.Lenc_end:
+	movdqu STATE, (OUTP)
+	FRAME_END
+	RET
+SYM_FUNC_END(__aeskl_enc)
+
+/*
+ * int __aeskl_dec(const void *ctx, u8 *dst, const u8 *src)
+ */
+SYM_FUNC_START(__aeskl_dec)
+	FRAME_BEGIN
+	movdqu (INP), STATE
+	mov 480(HANDLEP), KLEN
+
+	cmp $16, KLEN
+	je .Ldec_128
+	aesdec256kl (HANDLEP), STATE
+	jz .Ldec_err
+	jmp .Ldec_noerr
+.Ldec_128:
+	aesdec128kl (HANDLEP), STATE
+	jz .Ldec_err
+
+.Ldec_noerr:
+	xor AREG, AREG
+	jmp .Ldec_end
+.Ldec_err:
+	mov $(-EINVAL), AREG
+.Ldec_end:
+	movdqu STATE, (OUTP)
+	FRAME_END
+	RET
+SYM_FUNC_END(__aeskl_dec)
+
+/*
+ * XTS implementation
+ */
+
+/*
+ * _aeskl_gf128mul_x_ble: 	internal ABI
+ *	Multiply in GF(2^128) for XTS IVs
+ * input:
+ *	IV:	current IV
+ *	GF128MUL_MASK == mask with 0x87 and 0x01
+ * output:
+ *	IV:	next IV
+ * changed:
+ *	CTR:	== temporary value
+ *
+ * While based on the AES-NI code, this macro is separated here due to
+ * the register constraint. E.g., aesencwide256kl has implicit
+ * operands: XMM0-7.
+ */
+#define _aeskl_gf128mul_x_ble() \
+	pshufd $0x13, IV, KEY; \
+	paddq IV, IV; \
+	psrad $31, KEY; \
+	pand GF128MUL_MASK, KEY; \
+	pxor KEY, IV;
+
+/*
+ * int __aeskl_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *dst,
+ *			   const u8 *src, unsigned int len, le128 *iv)
+ */
+SYM_FUNC_START(__aeskl_xts_encrypt)
+	FRAME_BEGIN
+	movdqa .Lgf128mul_x_ble_mask(%rip), GF128MUL_MASK
+	movups (IVP), IV
+
+	mov 480(HANDLEP), KLEN
+
+.Lxts_enc8:
+	sub $128, LEN
+	jl .Lxts_enc1_pre
+
+	movdqa IV, STATE1
+	movdqu (INP), INC
+	pxor INC, STATE1
+	movdqu IV, (OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE2
+	movdqu 0x10(INP), INC
+	pxor INC, STATE2
+	movdqu IV, 0x10(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE3
+	movdqu 0x20(INP), INC
+	pxor INC, STATE3
+	movdqu IV, 0x20(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE4
+	movdqu 0x30(INP), INC
+	pxor INC, STATE4
+	movdqu IV, 0x30(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE5
+	movdqu 0x40(INP), INC
+	pxor INC, STATE5
+	movdqu IV, 0x40(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE6
+	movdqu 0x50(INP), INC
+	pxor INC, STATE6
+	movdqu IV, 0x50(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE7
+	movdqu 0x60(INP), INC
+	pxor INC, STATE7
+	movdqu IV, 0x60(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE8
+	movdqu 0x70(INP), INC
+	pxor INC, STATE8
+	movdqu IV, 0x70(OUTP)
+
+	cmp $16, KLEN
+	je .Lxts_enc8_128
+	aesencwide256kl (%rdi)
+	jz .Lxts_enc_ret_err
+	jmp .Lxts_enc8_end
+.Lxts_enc8_128:
+	aesencwide128kl (%rdi)
+	jz .Lxts_enc_ret_err
+
+.Lxts_enc8_end:
+	movdqu 0x00(OUTP), INC
+	pxor INC, STATE1
+	movdqu STATE1, 0x00(OUTP)
+
+	movdqu 0x10(OUTP), INC
+	pxor INC, STATE2
+	movdqu STATE2, 0x10(OUTP)
+
+	movdqu 0x20(OUTP), INC
+	pxor INC, STATE3
+	movdqu STATE3, 0x20(OUTP)
+
+	movdqu 0x30(OUTP), INC
+	pxor INC, STATE4
+	movdqu STATE4, 0x30(OUTP)
+
+	movdqu 0x40(OUTP), INC
+	pxor INC, STATE5
+	movdqu STATE5, 0x40(OUTP)
+
+	movdqu 0x50(OUTP), INC
+	pxor INC, STATE6
+	movdqu STATE6, 0x50(OUTP)
+
+	movdqu 0x60(OUTP), INC
+	pxor INC, STATE7
+	movdqu STATE7, 0x60(OUTP)
+
+	movdqu 0x70(OUTP), INC
+	pxor INC, STATE8
+	movdqu STATE8, 0x70(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+
+	add $128, INP
+	add $128, OUTP
+	test LEN, LEN
+	jnz .Lxts_enc8
+
+.Lxts_enc_ret_iv:
+	movups IV, (IVP)
+.Lxts_enc_ret_noerr:
+	xor AREG, AREG
+	jmp .Lxts_enc_ret
+.Lxts_enc_ret_err:
+	mov $(-EINVAL), AREG
+.Lxts_enc_ret:
+	FRAME_END
+	RET
+
+.Lxts_enc1_pre:
+	add $128, LEN
+	jz .Lxts_enc_ret_iv
+	sub $16, LEN
+	jl .Lxts_enc_cts4
+
+.Lxts_enc1:
+	movdqu (INP), STATE1
+	pxor IV, STATE1
+
+	cmp $16, KLEN
+	je .Lxts_enc1_128
+	aesenc256kl (HANDLEP), STATE1
+	jz .Lxts_enc_ret_err
+	jmp .Lxts_enc1_end
+.Lxts_enc1_128:
+	aesenc128kl (HANDLEP), STATE1
+	jz .Lxts_enc_ret_err
+
+.Lxts_enc1_end:
+	pxor IV, STATE1
+	_aeskl_gf128mul_x_ble()
+
+	test LEN, LEN
+	jz .Lxts_enc1_out
+
+	add $16, INP
+	sub $16, LEN
+	jl .Lxts_enc_cts1
+
+	movdqu STATE1, (OUTP)
+	add $16, OUTP
+	jmp .Lxts_enc1
+
+.Lxts_enc1_out:
+	movdqu STATE1, (OUTP)
+	jmp .Lxts_enc_ret_iv
+
+.Lxts_enc_cts4:
+	movdqu STATE8, STATE1
+	sub $16, OUTP
+
+.Lxts_enc_cts1:
+	lea .Lcts_permute_table(%rip), T1
+	add LEN, INP		/* rewind input pointer */
+	add $16, LEN		/* # bytes in final block */
+	movups (INP), IN1
+
+	mov T1, IVP
+	add $32, IVP
+	add LEN, T1
+	sub LEN, IVP
+	add OUTP, LEN
+
+	movups (T1), STATE2
+	movaps STATE1, STATE3
+	pshufb STATE2, STATE1
+	movups STATE1, (LEN)
+
+	movups (IVP), STATE1
+	pshufb STATE1, IN1
+	pblendvb STATE3, IN1
+	movaps IN1, STATE1
+
+	pxor IV, STATE1
+
+	cmp $16, KLEN
+	je .Lxts_enc1_cts_128
+	aesenc256kl (HANDLEP), STATE1
+	jz .Lxts_enc_ret_err
+	jmp .Lxts_enc1_cts_end
+.Lxts_enc1_cts_128:
+	aesenc128kl (HANDLEP), STATE1
+	jz .Lxts_enc_ret_err
+
+.Lxts_enc1_cts_end:
+	pxor IV, STATE1
+	movups STATE1, (OUTP)
+	jmp .Lxts_enc_ret_noerr
+SYM_FUNC_END(__aeskl_xts_encrypt)
+
+/*
+ * int __aeskl_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *dst,
+ *			   const u8 *src, unsigned int len, le128 *iv)
+ */
+SYM_FUNC_START(__aeskl_xts_decrypt)
+	FRAME_BEGIN
+	movdqa .Lgf128mul_x_ble_mask(%rip), GF128MUL_MASK
+	movups (IVP), IV
+
+	mov 480(HANDLEP), KLEN
+
+	test $15, LEN
+	jz .Lxts_dec8
+	sub $16, LEN
+
+.Lxts_dec8:
+	sub $128, LEN
+	jl .Lxts_dec1_pre
+
+	movdqa IV, STATE1
+	movdqu (INP), INC
+	pxor INC, STATE1
+	movdqu IV, (OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE2
+	movdqu 0x10(INP), INC
+	pxor INC, STATE2
+	movdqu IV, 0x10(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE3
+	movdqu 0x20(INP), INC
+	pxor INC, STATE3
+	movdqu IV, 0x20(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE4
+	movdqu 0x30(INP), INC
+	pxor INC, STATE4
+	movdqu IV, 0x30(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE5
+	movdqu 0x40(INP), INC
+	pxor INC, STATE5
+	movdqu IV, 0x40(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE6
+	movdqu 0x50(INP), INC
+	pxor INC, STATE6
+	movdqu IV, 0x50(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE7
+	movdqu 0x60(INP), INC
+	pxor INC, STATE7
+	movdqu IV, 0x60(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+	movdqa IV, STATE8
+	movdqu 0x70(INP), INC
+	pxor INC, STATE8
+	movdqu IV, 0x70(OUTP)
+
+	cmp $16, KLEN
+	je .Lxts_dec8_128
+	aesdecwide256kl (%rdi)
+	jz .Lxts_dec_ret_err
+	jmp .Lxts_dec8_end
+.Lxts_dec8_128:
+	aesdecwide128kl (%rdi)
+	jz .Lxts_dec_ret_err
+
+.Lxts_dec8_end:
+	movdqu 0x00(OUTP), INC
+	pxor INC, STATE1
+	movdqu STATE1, 0x00(OUTP)
+
+	movdqu 0x10(OUTP), INC
+	pxor INC, STATE2
+	movdqu STATE2, 0x10(OUTP)
+
+	movdqu 0x20(OUTP), INC
+	pxor INC, STATE3
+	movdqu STATE3, 0x20(OUTP)
+
+	movdqu 0x30(OUTP), INC
+	pxor INC, STATE4
+	movdqu STATE4, 0x30(OUTP)
+
+	movdqu 0x40(OUTP), INC
+	pxor INC, STATE5
+	movdqu STATE5, 0x40(OUTP)
+
+	movdqu 0x50(OUTP), INC
+	pxor INC, STATE6
+	movdqu STATE6, 0x50(OUTP)
+
+	movdqu 0x60(OUTP), INC
+	pxor INC, STATE7
+	movdqu STATE7, 0x60(OUTP)
+
+	movdqu 0x70(OUTP), INC
+	pxor INC, STATE8
+	movdqu STATE8, 0x70(OUTP)
+
+	_aeskl_gf128mul_x_ble()
+
+	add $128, INP
+	add $128, OUTP
+	test LEN, LEN
+	jnz .Lxts_dec8
+
+.Lxts_dec_ret_iv:
+	movups IV, (IVP)
+.Lxts_dec_ret_noerr:
+	xor AREG, AREG
+	jmp .Lxts_dec_ret
+.Lxts_dec_ret_err:
+	mov $(-EINVAL), AREG
+.Lxts_dec_ret:
+	FRAME_END
+	RET
+
+.Lxts_dec1_pre:
+	add $128, LEN
+	jz .Lxts_dec_ret_iv
+
+.Lxts_dec1:
+	movdqu (INP), STATE1
+
+	add $16, INP
+	sub $16, LEN
+	jl .Lxts_dec_cts1
+
+	pxor IV, STATE1
+
+	cmp $16, KLEN
+	je .Lxts_dec1_128
+	aesdec256kl (HANDLEP), STATE1
+	jz .Lxts_dec_ret_err
+	jmp .Lxts_dec1_end
+.Lxts_dec1_128:
+	aesdec128kl (HANDLEP), STATE1
+	jz .Lxts_dec_ret_err
+
+.Lxts_dec1_end:
+	pxor IV, STATE1
+	_aeskl_gf128mul_x_ble()
+
+	test LEN, LEN
+	jz .Lxts_dec1_out
+
+	movdqu STATE1, (OUTP)
+	add $16, OUTP
+	jmp .Lxts_dec1
+
+.Lxts_dec1_out:
+	movdqu STATE1, (OUTP)
+	jmp .Lxts_dec_ret_iv
+
+.Lxts_dec_cts1:
+	movdqa IV, STATE5
+	_aeskl_gf128mul_x_ble()
+
+	pxor IV, STATE1
+
+	cmp $16, KLEN
+	je .Lxts_dec1_cts_pre_128
+	aesdec256kl (HANDLEP), STATE1
+	jz .Lxts_dec_ret_err
+	jmp .Lxts_dec1_cts_pre_end
+.Lxts_dec1_cts_pre_128:
+	aesdec128kl (HANDLEP), STATE1
+	jz .Lxts_dec_ret_err
+
+.Lxts_dec1_cts_pre_end:
+	pxor IV, STATE1
+
+	lea .Lcts_permute_table(%rip), T1
+	add LEN, INP		/* rewind input pointer */
+	add $16, LEN		/* # bytes in final block */
+	movups (INP), IN1
+
+	mov T1, IVP
+	add $32, IVP
+	add LEN, T1
+	sub LEN, IVP
+	add OUTP, LEN
+
+	movups (T1), STATE2
+	movaps STATE1, STATE3
+	pshufb STATE2, STATE1
+	movups STATE1, (LEN)
+
+	movups (IVP), STATE1
+	pshufb STATE1, IN1
+	pblendvb STATE3, IN1
+	movaps IN1, STATE1
+
+	pxor STATE5, STATE1
+
+	cmp $16, KLEN
+	je .Lxts_dec1_cts_128
+	aesdec256kl (HANDLEP), STATE1
+	jz .Lxts_dec_ret_err
+	jmp .Lxts_dec1_cts_end
+.Lxts_dec1_cts_128:
+	aesdec128kl (HANDLEP), STATE1
+	jz .Lxts_dec_ret_err
+
+.Lxts_dec1_cts_end:
+	pxor STATE5, STATE1
+
+	movups STATE1, (OUTP)
+	jmp .Lxts_dec_ret_noerr
+
+SYM_FUNC_END(__aeskl_xts_decrypt)
+
diff --git a/arch/x86/crypto/aeskl-intel_glue.c b/arch/x86/crypto/aeskl-intel_glue.c
new file mode 100644
index 000000000000..c6824c50fc72
--- /dev/null
+++ b/arch/x86/crypto/aeskl-intel_glue.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Support for AES Key Locker instructions. This file contains glue
+ * code and the real AES implementation is in aeskl-intel_asm.S.
+ *
+ * Most code is based on AES-NI glue code, aesni-intel_glue.c
+ */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <crypto/algapi.h>
+#include <crypto/aes.h>
+#include <crypto/xts.h>
+#include <crypto/internal/skcipher.h>
+#include <crypto/internal/simd.h>
+#include <asm/simd.h>
+#include <asm/cpu_device_id.h>
+#include <asm/fpu/api.h>
+#include <asm/keylocker.h>
+
+#include "aes-helper_glue.h"
+#include "aesni-intel_glue.h"
+
+asmlinkage int aeskl_setkey(struct crypto_aes_ctx *ctx, const u8 *in_key, unsigned int keylen);
+
+asmlinkage int __aeskl_enc(const void *ctx, u8 *out, const u8 *in);
+asmlinkage int __aeskl_dec(const void *ctx, u8 *out, const u8 *in);
+
+asmlinkage int __aeskl_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+				   unsigned int len, u8 *iv);
+asmlinkage int __aeskl_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+				   unsigned int len, u8 *iv);
+
+static int aeskl_setkey_common(struct crypto_tfm *tfm, void *raw_ctx, const u8 *in_key,
+			       unsigned int keylen)
+{
+	/* raw_ctx is an aligned address via xts_setkey_common() */
+	struct crypto_aes_ctx *ctx = (struct crypto_aes_ctx *)raw_ctx;
+	int err;
+
+	if (!crypto_simd_usable())
+		return -EBUSY;
+
+	if (keylen != AES_KEYSIZE_128 && keylen != AES_KEYSIZE_192 &&
+	    keylen != AES_KEYSIZE_256)
+		return -EINVAL;
+
+	kernel_fpu_begin();
+	if (unlikely(keylen == AES_KEYSIZE_192)) {
+		pr_warn_once("AES-KL does not support 192-bit key. Use AES-NI.\n");
+		err = aesni_set_key(ctx, in_key, keylen);
+	} else {
+		if (!valid_keylocker())
+			err = -ENODEV;
+		else
+			err = aeskl_setkey(ctx, in_key, keylen);
+	}
+	kernel_fpu_end();
+
+	return err;
+}
+
+/*
+ * The below wrappers for the encryption/decryption functions
+ * incorporate the feature availability check:
+ *
+ * In the rare event of hardware failure, the wrapping key can be lost
+ * after wake-up from a deep sleep state. Then, this check helps to
+ * avoid any subsequent misuse with populating a proper error code.
+ */
+
+static inline int aeskl_enc(const void *ctx, u8 *out, const u8 *in)
+{
+	if (!valid_keylocker())
+		return -ENODEV;
+
+	return __aeskl_enc(ctx, out, in);
+}
+
+static inline int aeskl_dec(const void *ctx, u8 *out, const u8 *in)
+{
+	if (!valid_keylocker())
+		return -ENODEV;
+
+	return __aeskl_dec(ctx, out, in);
+}
+
+static inline int aeskl_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+				    unsigned int len, u8 *iv)
+{
+	if (!valid_keylocker())
+		return -ENODEV;
+
+	return __aeskl_xts_encrypt(ctx, out, in, len, iv);
+}
+
+static inline int aeskl_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+				    unsigned int len, u8 *iv)
+{
+	if (!valid_keylocker())
+		return -ENODEV;
+
+	return __aeskl_xts_decrypt(ctx, out, in, len, iv);
+}
+
+static int aeskl_xts_setkey(struct crypto_skcipher *tfm, const u8 *key,
+			    unsigned int keylen)
+{
+	return xts_setkey_common(tfm, key, keylen, aeskl_setkey_common);
+}
+
+static inline int xts_keylen(struct skcipher_request *req, u32 *keylen)
+{
+	struct aes_xts_ctx *ctx = aes_xts_ctx(crypto_skcipher_reqtfm(req));
+
+	if (ctx->crypt_ctx.key_length != ctx->tweak_ctx.key_length)
+		return -EINVAL;
+
+	*keylen = ctx->crypt_ctx.key_length;
+	return 0;
+}
+
+static int xts_encrypt(struct skcipher_request *req)
+{
+	u32 keylen;
+	int err;
+
+	err = xts_keylen(req, &keylen);
+	if (err)
+		return err;
+
+	if (likely(keylen != AES_KEYSIZE_192))
+		return xts_crypt_common(req, aeskl_xts_encrypt, aeskl_enc);
+	else
+		return xts_crypt_common(req, aesni_xts_encrypt, aesni_enc);
+}
+
+static int xts_decrypt(struct skcipher_request *req)
+{
+	u32 keylen;
+	int rc;
+
+	rc = xts_keylen(req, &keylen);
+	if (rc)
+		return rc;
+
+	if (likely(keylen != AES_KEYSIZE_192))
+		return xts_crypt_common(req, aeskl_xts_decrypt, aeskl_enc);
+	else
+		return xts_crypt_common(req, aesni_xts_decrypt, aesni_enc);
+}
+
+static struct skcipher_alg aeskl_skciphers[] = {
+	{
+		.base = {
+			.cra_name		= "__xts(aes)",
+			.cra_driver_name	= "__xts-aes-aeskl",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_INTERNAL,
+			.cra_blocksize		= AES_BLOCK_SIZE,
+			.cra_ctxsize		= XTS_AES_CTX_SIZE,
+			.cra_module		= THIS_MODULE,
+		},
+		.min_keysize	= 2 * AES_MIN_KEY_SIZE,
+		.max_keysize	= 2 * AES_MAX_KEY_SIZE,
+		.ivsize		= AES_BLOCK_SIZE,
+		.walksize	= 2 * AES_BLOCK_SIZE,
+		.setkey		= aeskl_xts_setkey,
+		.encrypt	= xts_encrypt,
+		.decrypt	= xts_decrypt,
+	}
+};
+
+static struct simd_skcipher_alg *aeskl_simd_skciphers[ARRAY_SIZE(aeskl_skciphers)];
+
+static int __init aeskl_init(void)
+{
+	u32 eax, ebx, ecx, edx;
+	int err;
+
+	if (!valid_keylocker())
+		return -ENODEV;
+
+	cpuid_count(KEYLOCKER_CPUID, 0, &eax, &ebx, &ecx, &edx);
+	if (!(ebx & KEYLOCKER_CPUID_EBX_WIDE))
+		return -ENODEV;
+
+	/*
+	 * AES-KL itself does not depend on AES-NI. But AES-KL does not
+	 * support 192-bit keys. To make itself AES-compliant, it falls
+	 * back to AES-NI.
+	 */
+	if (!boot_cpu_has(X86_FEATURE_AES))
+		return -ENODEV;
+
+	err = simd_register_skciphers_compat(aeskl_skciphers, ARRAY_SIZE(aeskl_skciphers),
+					     aeskl_simd_skciphers);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static void __exit aeskl_exit(void)
+{
+	simd_unregister_skciphers(aeskl_skciphers, ARRAY_SIZE(aeskl_skciphers),
+				  aeskl_simd_skciphers);
+}
+
+late_initcall(aeskl_init);
+module_exit(aeskl_exit);
+
+MODULE_DESCRIPTION("Rijndael (AES) Cipher Algorithm, AES Key Locker implementation");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("aes");
diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 3922d24cae2b..d38abcc69d9e 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -1821,10 +1821,10 @@ SYM_FUNC_START_LOCAL(_key_expansion_256b)
 SYM_FUNC_END(_key_expansion_256b)
 
 /*
- * int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
- *                   unsigned int key_len)
+ * int __aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
+ *                     unsigned int key_len)
  */
-SYM_FUNC_START(aesni_set_key)
+SYM_FUNC_START(__aesni_set_key)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl KEYP
@@ -1933,7 +1933,7 @@ SYM_FUNC_START(aesni_set_key)
 #endif
 	FRAME_END
 	RET
-SYM_FUNC_END(aesni_set_key)
+SYM_FUNC_END(__aesni_set_key)
 
 /*
  * void __aesni_enc(const void *ctx, u8 *dst, const u8 *src)
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 857cff484bb3..3aaf5504e349 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -37,6 +37,7 @@
 #include <linux/static_call.h>
 
 #include "aes-helper_glue.h"
+#include "aesni-intel_glue.h"
 
 #define RFC4106_HASH_SUBKEY_SIZE 16
 #define AES_BLOCK_MASK (~(AES_BLOCK_SIZE - 1))
@@ -72,8 +73,8 @@ struct gcm_context_data {
 	u8 hash_keys[GCM_BLOCK_LEN * 16];
 };
 
-asmlinkage int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
-			     unsigned int key_len);
+asmlinkage int __aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
+			       unsigned int key_len);
 asmlinkage void __aesni_enc(const void *ctx, u8 *out, const u8 *in);
 asmlinkage void __aesni_dec(const void *ctx, u8 *out, const u8 *in);
 asmlinkage void aesni_ecb_enc(struct crypto_aes_ctx *ctx, u8 *out,
@@ -89,17 +90,32 @@ asmlinkage void aesni_cts_cbc_enc(struct crypto_aes_ctx *ctx, u8 *out,
 asmlinkage void aesni_cts_cbc_dec(struct crypto_aes_ctx *ctx, u8 *out,
 				  const u8 *in, unsigned int len, u8 *iv);
 
-static int aesni_enc(const void *ctx, u8 *out, const u8 *in)
+int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
+		  unsigned int key_len)
+{
+	return __aesni_set_key(ctx, in_key, key_len);
+}
+#if IS_MODULE(CONFIG_CRYPTO_AES_KL)
+EXPORT_SYMBOL_GPL(aesni_set_key);
+#endif
+
+int aesni_enc(const void *ctx, u8 *out, const u8 *in)
 {
 	__aesni_enc(ctx, out, in);
 	return 0;
 }
+#if IS_MODULE(CONFIG_CRYPTO_AES_KL)
+EXPORT_SYMBOL_GPL(aesni_enc);
+#endif
 
-static int aesni_dec(const void *ctx, u8 *out, const u8 *in)
+int aesni_dec(const void *ctx, u8 *out, const u8 *in)
 {
 	__aesni_dec(ctx, out, in);
 	return 0;
 }
+#if IS_MODULE(CONFIG_CRYPTO_AES_KL)
+EXPORT_SYMBOL_GPL(aesni_dec);
+#endif
 
 #define AVX_GEN2_OPTSIZE 640
 #define AVX_GEN4_OPTSIZE 4096
@@ -110,19 +126,25 @@ asmlinkage void __aesni_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *out,
 asmlinkage void __aesni_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *out,
 				    const u8 *in, unsigned int len, u8 *iv);
 
-static int aesni_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
-			     unsigned int len, u8 *iv)
+int aesni_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+		      unsigned int len, u8 *iv)
 {
 	__aesni_xts_encrypt(ctx, out, in, len, iv);
 	return 0;
 }
+#if IS_MODULE(CONFIG_CRYPTO_AES_KL)
+EXPORT_SYMBOL_GPL(aesni_xts_encrypt);
+#endif
 
-static int aesni_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
-			     unsigned int len, u8 *iv)
+int aesni_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+		      unsigned int len, u8 *iv)
 {
 	__aesni_xts_decrypt(ctx, out, in, len, iv);
 	return 0;
 }
+#if IS_MODULE(CONFIG_CRYPTO_AES_KL)
+EXPORT_SYMBOL_GPL(aesni_xts_decrypt);
+#endif
 
 #ifdef CONFIG_X86_64
 
@@ -256,7 +278,7 @@ static int aes_set_key_common(struct crypto_tfm *tfm, void *raw_ctx,
 		err = aes_expandkey(ctx, in_key, key_len);
 	else {
 		kernel_fpu_begin();
-		err = aesni_set_key(ctx, in_key, key_len);
+		err = __aesni_set_key(ctx, in_key, key_len);
 		kernel_fpu_end();
 	}
 
diff --git a/arch/x86/crypto/aesni-intel_glue.h b/arch/x86/crypto/aesni-intel_glue.h
new file mode 100644
index 000000000000..81ecacb4e54c
--- /dev/null
+++ b/arch/x86/crypto/aesni-intel_glue.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Support for Intel AES-NI instructions. This file contains function
+ * prototypes to be referenced for other AES implementations
+ */
+
+int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key, unsigned int key_len);
+
+int aesni_enc(const void *ctx, u8 *out, const u8 *in);
+int aesni_dec(const void *ctx, u8 *out, const u8 *in);
+
+int aesni_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+		      unsigned int len, u8 *iv);
+int aesni_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in,
+		      unsigned int len, u8 *iv);
+
-- 
2.17.1

