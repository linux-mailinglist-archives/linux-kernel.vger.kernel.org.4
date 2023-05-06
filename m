Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DECA6F8CF9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 02:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjEFABx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 20:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjEFABv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 20:01:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEF65FE0;
        Fri,  5 May 2023 17:01:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04D59615D4;
        Sat,  6 May 2023 00:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4BEC433D2;
        Sat,  6 May 2023 00:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683331309;
        bh=QsO73mPrM5vKsvjhH2dwYFe32pVRTPoPfaa85S1KdnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NfVPZbtV2V3DoseQezuTESztq+VvO/83tHYbI8XcmmBODYMvqEB7YMaxz4+7RXFEE
         3c25xRVeBgGXCErUdq1MSICUO5FpYPdMNqt4gu9apY918PfI0b92jjygzG+YZcV22f
         C5QH+0Ui2Wost33jN/uaBWBgwPfG4cbbeXMcVFpw5CsuQMUytaHfOYknMWey89GFt8
         /M78hOBEw1SkzQe6ORz2yVBOzG+98rDne+CaRKHkaneM/act46b01/gSy2yFDuYNDr
         fjzuKmY9fpTY1oiIj8z2IcHyjZ9SuUsPn/EZb0tjPZUr1uiro+0lT3jC7i+7BcMvzf
         IK4ln/rl0kMMw==
Date:   Sat, 6 May 2023 00:01:47 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com, gmazyland@gmail.com, luto@kernel.org,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@suse.de,
        mingo@kernel.org, x86@kernel.org, herbert@gondor.apana.org.au,
        ardb@kernel.org, dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Subject: Re: [PATCH v6 11/12] crypto: x86/aes-kl - Support AES algorithm
 using Key Locker instructions
Message-ID: <ZFWY6/VelArVYy1F@gmail.com>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
 <20230410225936.8940-1-chang.seok.bae@intel.com>
 <20230410225936.8940-12-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410225936.8940-12-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 03:59:35PM -0700, Chang S. Bae wrote:
> [PATCH v6 11/12] crypto: x86/aes-kl - Support AES algorithm using Key Locker instructions

Thanks for dropping the unnecessary modes of operation (CBC, ECB, CTR).  It
simplified the patchset quite a bit!

Now that only AES-XTS is included, can you please also merge this patch with the
following patch?  As-is, this patch is misleading since it doesn't actually add
"support" for anything at all.  It actually just adds an unfinished AES-XTS
implementation, which patch 12 then finishes.  I assume that the current
patchset organization is left over from when you were trying to support multiple
modes of operation.  IMO, it would be much easier to review if patches 11-12
were merged into one patch that adds the new AES-XTS implementation.

> For disk encryption, storage bandwidth may be the bottleneck
> before encryption bandwidth, but the potential performance difference is
> why AES-KL is advertised as a distinct cipher in /proc/crypto rather than
> the kernel transparently replacing AES-NI usage with AES-KL.

This does not correctly describe what is going on.  Actually, this patchset
registers the AES-KL XTS algorithm with the usual name "xts(aes)".  So, it can
potentially be used by any AES-XTS user.  It seems that you're actually relying
on the algorithm priorities to prioritize AES-NI, as you've assigned priority
200 to AES-KL, whereas AES-NI has priority 401.  Is that what you intend, and if
so can you please update your explanation to properly explain this?

The alternative would be to use a unique algorithm name, such as
"keylocker-xts(aes)".  I'm not sure that would be better, given that the
algorithms are compatible.  However, that actually would seem to match the
explanation you gave more closely, so perhaps that's what you actually intended?

> diff --git a/arch/x86/crypto/aeskl-intel_asm.S b/arch/x86/crypto/aeskl-intel_asm.S
[...]
> +#ifdef __x86_64__
> +#define AREG	%rax
> +#define HANDLEP	%rdi
> +#define OUTP	%rsi
> +#define KLEN	%r9d
> +#define INP	%rdx
> +#define T1	%r10
> +#define LEN	%rcx
> +#define IVP	%r8
> +#else
> +#define AREG	%eax
> +#define HANDLEP	%edi
> +#define OUTP	AREG
> +#define KLEN	%ebx
> +#define INP	%edx
> +#define T1	%ecx
> +#define LEN	%esi
> +#define IVP	%ebp
> +#endif

I strongly recommend skipping the 32-bit support, as it's unlikely to be worth
the effort.

And actually, aeskl-intel_glue.c only registers the algorithm for 64-bit
anyway...  So the 32-bit code paths are untested dead code.

> +static inline int aeskl_enc(const void *ctx, u8 *out, const u8 *in)
> +{
> +	if (unlikely(keylength(ctx) == AES_KEYSIZE_192))
> +		return -EINVAL;
> +	else if (!valid_keylocker())
> +		return -ENODEV;
> +	else if (_aeskl_enc(ctx, out, in))
> +		return -EINVAL;
> +	else
> +		return 0;
> +}
> +
> +static inline int aeskl_dec(const void *ctx, u8 *out, const u8 *in)
> +{
> +	if (unlikely(keylength(ctx) == AES_KEYSIZE_192))
> +		return -EINVAL;
> +	else if (!valid_keylocker())
> +		return -ENODEV;
> +	else if (_aeskl_dec(ctx, out, in))
> +		return -EINVAL;
> +	else
> +		return 0;
> +}

I don't think the above two functions should exist.  keylength() and
valid_keylocker() should be checked before calling xts_crypt_common(), and the
assembly functions should just return the correct error code (-EINVAL,
apparently) instead of an unspecified nonzero value.  That would leave nothing
for a wrapper function to do.

Note: if you take this suggestion, the assembly functions would need to use
SYM_TYPED_FUNC_START instead of SYM_FUNC_START.

- Eric
