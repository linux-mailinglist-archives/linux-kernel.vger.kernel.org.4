Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FF0601D49
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiJQXGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiJQXGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:06:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831DD82D0E;
        Mon, 17 Oct 2022 16:06:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB396612BC;
        Mon, 17 Oct 2022 23:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC691C43470;
        Mon, 17 Oct 2022 23:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666047751;
        bh=BZ+LTZceLwdbNyktC2zUcnmC4URC/V/Chf6caZqqTqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kVEOAJD9FCiTEyXHjS84vDt77euPvo+OZ5bW1POhNQ8iNsNBWXXXbAW8Tk39VE9Sv
         OVO5qrRVTjN2ahRKi+n9FuuhARaWnmj3MZQySmoizZEBuI3oU7NRnkyCHVd+ComU8B
         qqOGD8PykJsU7d0AYzgwKYWjyrT3edEp0eRlRFfjvB7ts1+S1oGaVd9c0UBGFNHj1S
         tK+slTFluaemOGS7kwIF6Yf2DOzlMtdiC+ae4QpAILgvUZQC2d/HH0SVkBxAcbf6VQ
         Na18NWaXtqT3963CbK0hy9Gc3k7iwu/34T8VU0U+Szqx3B/eTYtQ2Z5JKCpcUBgBTB
         eYZp2rty06wZA==
Date:   Mon, 17 Oct 2022 16:02:29 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Bruno Goncalves <bgoncalv@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: x86/polyval - Fix crashes when keys are not
 16-byte aligned
Message-ID: <Y03fBQPM7h7+cfGK@sol.localdomain>
References: <20221017222620.715153-1-nhuck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017222620.715153-1-nhuck@google.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 03:26:20PM -0700, Nathan Huckleberry wrote:
> The key_powers array is not guaranteed to be 16-byte aligned, so using
> movaps to operate on key_powers is not allowed.
> 
> Switch movaps to movups.
> 
> Fixes: 34f7f6c30112 ("crypto: x86/polyval - Add PCLMULQDQ accelerated implementation of POLYVAL")
> Reported-by: Bruno Goncalves <bgoncalv@redhat.com>
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> ---
>  arch/x86/crypto/polyval-clmulni_asm.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/crypto/polyval-clmulni_asm.S b/arch/x86/crypto/polyval-clmulni_asm.S
> index a6ebe4e7dd2b..32b98cb53ddf 100644
> --- a/arch/x86/crypto/polyval-clmulni_asm.S
> +++ b/arch/x86/crypto/polyval-clmulni_asm.S
> @@ -234,7 +234,7 @@
>  
>  	movups (MSG), %xmm0
>  	pxor SUM, %xmm0
> -	movaps (KEY_POWERS), %xmm1
> +	movups (KEY_POWERS), %xmm1
>  	schoolbook1_noload
>  	dec BLOCKS_LEFT
>  	addq $16, MSG

I thought that crypto_tfm::__crt_ctx is guaranteed to be 16-byte aligned,
and that the x86 AES code relies on that property.

But now I see that actually the x86 AES code manually aligns the context.
See aes_ctx() in arch/x86/crypto/aesni-intel_glue.c.

Did you consider doing the same for polyval?

If you do prefer this way, it would be helpful to leave a comment for
schoolbook1_iteration that mentions that the unaligned access support of
vpclmulqdq is being relied on, i.e. pclmulqdq wouldn't work.

- Eric
