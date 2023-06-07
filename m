Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E5872536A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbjFGFgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjFGFgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:36:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB3E1989;
        Tue,  6 Jun 2023 22:36:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD3B7635AE;
        Wed,  7 Jun 2023 05:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35C1C433EF;
        Wed,  7 Jun 2023 05:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686116161;
        bh=dmngplKS6c3sG/NymxeyYpNud7A468aDfo1T86Ux7j4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q03XjOKTI/X0xf5zqp7RZWNr0/YWCdFOofxH3NAkjsEgrj9dq35ghwIb5R14vaIGE
         234HkgyAcd+YjdIinu52r1AlCqnSkSwE+pDSfUmBJBq8z8WoDdUsJ0gFiN3G1qwL++
         TcNqUdIcUokhbDWjl/MQkODY3E4q9Lx0Plf+XflUnTgqe1oocsRXSsB5PiG+Ke/YSQ
         /HDldQzBZ3pHaq0VQNQ8ig1lD6SaXY3MoJZWiYB1HIimfMfxxvM1Gci0fCxqHyOGjj
         kgK0AwAL3vT1JtcGazAFRhaxZtHSLegx/RgxKfTlDxJfThnzPXSko4nHHJX50qO6Tx
         uscmcTg82naSQ==
Date:   Tue, 6 Jun 2023 22:35:58 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com, elliott@hpe.com, gmazyland@gmail.com,
        luto@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        bp@alien8.de, mingo@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au, ardb@kernel.org,
        dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com, nhuck@google.com,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v8 12/12] crypto: x86/aes-kl - Implement the AES-XTS
 algorithm
Message-ID: <20230607053558.GC941@sol.localdomain>
References: <20230524165717.14062-1-chang.seok.bae@intel.com>
 <20230603152227.12335-1-chang.seok.bae@intel.com>
 <20230603152227.12335-13-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230603152227.12335-13-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2023 at 08:22:27AM -0700, Chang S. Bae wrote:
> == Key Handle Restriction ==
> 
> A key handle may be encoded with some restrictions.

It's unclear what this means.  Please avoid passive tense and the word "may"
like this.  I think you mean something like "The AES-KL instruction set supports
selecting key usage restrictions at key handle creation time."

> Restrict every handle only available in kernel mode via setkey().

I think you mean something like "Restrict all key handles created by the kernel
to kernel mode use only."

Can you also mention why you are doing this?  I suppose it might as well be
done, but I'm not seeing how it would actually matter.

What other sorts of key usage restrictions does AES-KL support?  Are any other
ones useful here?

> Subsequently the key handle could be corrupted or fail with handle
> restrictions. Then, encrypt()/decrypt() returns -EINVAL.

Aren't these scenarios actually impossible?  At least without memory corruption.

> == Userspace Exposition ==
> 
> Some hardware implementations may have some performance penalties.

Likewise, please avoid vague statements like this.  This makes it unclear
whether this is something that happens in the real world or whether it's just
theoretical.  You indeed have actual benchmark results that show that AES-KL is
much slower than AES-NI on current CPUs, right?

> But, for disk encryption, storage bandwidth may be the bottleneck before
> encryption bandwidth.

Again, please try to be less vague.  E.g. "With a slow storage device, storage
bandwidth is the bottleneck, even if disk encryption is enabled..."

> Thus, advertise it with a unique name 'xts-aes-aeskl' in /proc/crypto while
> not replacing AES-NI under the generic name 'xts(aes)' with a lower priority.

The above sentence seems to say that xts-aes-aeskl does *not* have a lower
priority than xts-aes-aesni.  But actually it does.

> Then, the performance is unlikely better than 64-bit which has already a gap
> vs. AES-NI.

I don't understand what this sentence is trying to say.

> diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
> index 9bbfd01cfa2f..658adfd7aebf 100644
> --- a/arch/x86/crypto/Kconfig
> +++ b/arch/x86/crypto/Kconfig
> @@ -2,6 +2,11 @@
>  
>  menu "Accelerated Cryptographic Algorithms for CPU (x86)"
>  
> +config AS_HAS_KEYLOCKER
> +	def_bool $(as-instr,encodekey256 %eax$(comma)%eax)
> +	help
> +	  Supported by binutils >= 2.36 and LLVM integrated assembler >= V12

It looks like arch/x86/Kconfig.assembler would be a better place for this.

> diff --git a/arch/x86/crypto/aeskl-intel_asm.S b/arch/x86/crypto/aeskl-intel_asm.S
> new file mode 100644
> index 000000000000..61addc61dd4e
> --- /dev/null
> +++ b/arch/x86/crypto/aeskl-intel_asm.S
> @@ -0,0 +1,552 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Implement AES algorithm using AES Key Locker instructions.
> + *
> + * Most code is based from the AES-NI implementation, aesni-intel_asm.S
> + *
> + */
> +
> +#include <linux/linkage.h>
> +#include <linux/cfi_types.h>
> +#include <asm/errno.h>
> +#include <asm/inst.h>
> +#include <asm/frame.h>
> +#include "aes-helper_asm.S"
> +
> +.text
> +
> +#define STATE1	%xmm0
> +#define STATE2	%xmm1
> +#define STATE3	%xmm2
> +#define STATE4	%xmm3
> +#define STATE5	%xmm4
> +#define STATE6	%xmm5
> +#define STATE7	%xmm6
> +#define STATE8	%xmm7
> +#define STATE	STATE1
> +
> +#define IV	%xmm9
> +#define KEY	%xmm10
> +#define INC	%xmm13
> +
> +#define IN1	%xmm8
> +#define IN	IN1

Why do both IN1 and IN exist?  Shouldn't there just be IN?

> +
> +#define AREG	%rax

Shouldn't %rax just be hardcoded?

> +#define HANDLEP	%rdi

This should be called CTX, to match the function prototypes.

> +#define UKEYP	OUTP

This should be called IN_KEY, to match the function prototypes.

> +#define GF128MUL_MASK %xmm11
> +
> +/*
> + * int __aeskl_setkey(struct crypto_aes_ctx *ctx, const u8 *in_key, unsigned int key_len)
> + */
> +SYM_FUNC_START(__aeskl_setkey)
> +	FRAME_BEGIN
> +	movl %edx, 480(HANDLEP)
> +	movdqu (UKEYP), STATE1
> +	mov $1, %eax
> +	cmp $16, %dl
> +	je .Lsetkey_128
> +
> +	movdqu 0x10(UKEYP), STATE2
> +	encodekey256 %eax, %eax
> +	movdqu STATE4, 0x30(HANDLEP)
> +	jmp .Lsetkey_end
> +.Lsetkey_128:
> +	encodekey128 %eax, %eax
> +
> +.Lsetkey_end:
> +	movdqu STATE1, (HANDLEP)
> +	movdqu STATE2, 0x10(HANDLEP)
> +	movdqu STATE3, 0x20(HANDLEP)

The moves to the ctx should use movdqa, since it is aligned.

> +
> +	xor AREG, AREG
> +	FRAME_END
> +	RET
> +SYM_FUNC_END(__aeskl_setkey)

This function always returns 0, so it really should return void.

> +/*
> + * int __aeskl_enc(const void *ctx, u8 *dst, const u8 *src)
> + */
> +SYM_FUNC_START(__aeskl_enc)
> +	FRAME_BEGIN
> +	movdqu (INP), STATE
> +	movl 480(HANDLEP), KLEN
> +
> +	cmp $16, KLEN
> +	je .Lenc_128
> +	aesenc256kl (HANDLEP), STATE
> +	jz .Lenc_err
> +	jmp .Lenc_noerr
> +.Lenc_128:
> +	aesenc128kl (HANDLEP), STATE
> +	jz .Lenc_err
> +
> +.Lenc_noerr:
> +	xor AREG, AREG
> +	jmp .Lenc_end
> +.Lenc_err:
> +	mov $(-EINVAL), AREG
> +.Lenc_end:
> +	movdqu STATE, (OUTP)
> +	FRAME_END
> +	RET
> +SYM_FUNC_END(__aeskl_enc)

In the common case (successful AES-256 encryption) this is executing 'jmp'
twice.  I think the code should be rearranged to eliminate these jmps.

> +/*
> + * int __aeskl_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *dst,
> + *			   const u8 *src, unsigned int len, le128 *iv)
> + */
> +SYM_FUNC_START(__aeskl_xts_encrypt)

__aeskl_xts_encrypt() and __aeskl_xts_decrypt() are very similar.  To reduce
code duplication, can you consider generating them from a macro that takes an
argument that indicates whether it is encrypt or decrypt?

> +static int aeskl_setkey(struct crypto_tfm *tfm, void *raw_ctx, const u8 *in_key,
> +			unsigned int keylen)
> +{
> +	struct crypto_aes_ctx *ctx = (struct crypto_aes_ctx *)raw_ctx;
> +	int err;
> +
> +	if (!crypto_simd_usable())
> +		return -EBUSY;
> +
> +	if (keylen != AES_KEYSIZE_128 && keylen != AES_KEYSIZE_192 &&
> +	    keylen != AES_KEYSIZE_256)
> +		return -EINVAL;
> +
> +	kernel_fpu_begin();
> +	if (unlikely(keylen == AES_KEYSIZE_192)) {
> +		pr_warn_once("AES-KL does not support 192-bit key. Use AES-NI.\n");
> +		err = aesni_set_key(ctx, in_key, keylen);
> +	} else {
> +		if (!valid_keylocker())
> +			err = -ENODEV;
> +		else
> +			err = __aeskl_setkey(ctx, in_key, keylen);
> +	}
> +	kernel_fpu_end();
> +
> +	return err;
> +}
[...]
> +			.cra_ctxsize		= XTS_AES_CTX_SIZE,
[...]

Something that your AES-KL code does that's a bit ugly is that it abuses
'struct crypto_aes_ctx' to store a Keylocker key handle instead
of the actual AES key schedule which the struct is supposed to be for.

The proper way to represent that would be to make the tfm context for
xts-aes-aeskl be a union of crypto_aes_ctx and a Keylocker specific context.

If you don't do that and instead keep the proposed workaround, then please add a
comment somewhere that very clearly explains how the struct is being used.
Above aeskl_setkey() or above .cra_ctxsize might be a good place.

> diff --git a/arch/x86/crypto/aesni-intel_glue.h b/arch/x86/crypto/aesni-intel_glue.h
> new file mode 100644
> index 000000000000..5b1919f49efe
> --- /dev/null
> +++ b/arch/x86/crypto/aesni-intel_glue.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Support for Intel AES-NI instructions. This file contains function
> + * prototypes to be referenced for other AES implementations
> + */

It would be helpful if this comment was more concrete, like "These are AES-NI
functions that are used by the AES-KL code as a fallback when it is given a
192-bit key.  Key Locker does not support 192-bit keys."

- Eric
