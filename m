Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAA5639D7D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 23:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiK0WHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 17:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiK0WHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 17:07:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C60DF33;
        Sun, 27 Nov 2022 14:07:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BC8160F01;
        Sun, 27 Nov 2022 22:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B1AC433D6;
        Sun, 27 Nov 2022 22:07:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RRzza62V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669586837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hKfNV26zRf+FEaOad/iOSscvcbxYzHOXAlsyzzY3NhI=;
        b=RRzza62VIE1wg8vBWFGKBN76AI4L06/7PSJ/yG4qcyMY/bD2etIUpA++V/5GkTm5YoDWXh
        +Rpu0sEKv0MFoUj4of+rVg5BtRjt2xu/KxU5ZgQ4OhMeH3d2niBsfjSPc8p31CAWKr1FCj
        tcGcZI0Yalhv7qFpIEu1EhM8zVa9PBs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8cc45b97 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sun, 27 Nov 2022 22:07:17 +0000 (UTC)
Date:   Sun, 27 Nov 2022 23:07:09 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v7 3/3] x86: vdso: Wire up getrandom() vDSO implementation
Message-ID: <Y4PfjcQRfezjH4f+@zx2c4.com>
References: <20221124165536.1631325-1-Jason@zx2c4.com>
 <20221124165536.1631325-4-Jason@zx2c4.com>
 <874jumy6me.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874jumy6me.ffs@tglx>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Sat, Nov 26, 2022 at 12:08:41AM +0100, Thomas Gleixner wrote:
> Jason!
> 
> On Thu, Nov 24 2022 at 17:55, Jason A. Donenfeld wrote:
> > +++ b/arch/x86/entry/vdso/vgetrandom-chacha.S
> > +/*
> > + * Very basic SSE2 implementation of ChaCha20. Produces a given positive number
> > + * of blocks of output with a nonce of 0, taking an input key and 8-byte
> > + * counter. Importantly does not spill to the stack. Its arguments are:
> 
> Basic or not.

Heh, FYI I didn't mean "basic" here as in "doesn't need a review", but
just that it's a straightforward technique and doesn't do any
complicated multiblock pyrotechnics (which frankly aren't really
needed).

> This needs a Reviewed-by from someone who understands SSE2
> and ChaCha20 before this can go anywhere near the x86 tree.

No problem. I'll see to it that somebody qualified gives this a review.

> > +#include <linux/kernel.h>
> 
> Why do you need kernel.h here?

Turns out I don't, thanks.

> > +static __always_inline ssize_t
> > +getrandom_syscall(void *buffer, size_t len, unsigned int flags)
> 
> static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsigned int flags)
> 
> please. We expanded to 100 quite some time ago.
> 
> Some kernel-doc compliant comment for this would be appreciated as well.

Will do.

> 
> > +{
> > +	long ret;
> > +
> > +	asm ("syscall" : "=a" (ret) :
> > +	     "0" (__NR_getrandom), "D" (buffer), "S" (len), "d" (flags) :
> > +	     "rcx", "r11", "memory");
> > +
> > +	return ret;
> > +}
> > +
> > +#define __vdso_rng_data (VVAR(_vdso_rng_data))
> > +
> > +static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void)
> > +{
> > +	if (__vdso_data->clock_mode == VDSO_CLOCKMODE_TIMENS)
> > +		return (void *)&__vdso_rng_data +
> > +		       ((void *)&__timens_vdso_data - (void *)&__vdso_data);
> > +	return &__vdso_rng_data;
> 
> So either bite the bullet and  write it:
> 
> 	if (__vdso_data->clock_mode == VDSO_CLOCKMODE_TIMENS)
> 		return (void *)&__vdso_rng_data + ((void *)&__timens_vdso_data - (void *)&__vdso_data);

Seems fine to me. I'll write it like that.

> > +/*
> > + * Generates a given positive number of block of ChaCha20 output with nonce=0,
> > + * and does not write to any stack or memory outside of the parameters passed
> > + * to it. This way, we don't need to worry about stack data leaking into forked
> > + * child processes.
> 
> Please use proper kernel-doc
> 
> > + */
> > +static __always_inline void __arch_chacha20_blocks_nostack(u8 *dst_bytes, const u32 *key, u32 *counter, size_t nblocks)
> > +{
> > +	extern void chacha20_blocks_nostack(u8 *dst_bytes, const u32 *key, u32 *counter, size_t nblocks);
> > +	return chacha20_blocks_nostack(dst_bytes, key, counter, nblocks);
> 
> The above aside, can you please explain the value of this __arch_()
> wrapper?
> 
> It's just voodoo for no value because it hands through the arguments
> 1:1. So where are you expecting that that __arch...() version of this is
> any different than invoking the architecture specific version of
> chacha20_blocks_nostack().

I'll just name the assembly function with __arch...(). The idea behind
the wrapper was just to keep all of the non-generic code called from the
generic code prefixed with __arch_, but there's no reason I need to name
it like that from C alone. Will fix for v8.

Thanks again,
Jason
