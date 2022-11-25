Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365CA639203
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 00:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiKYXIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 18:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKYXIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 18:08:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0FE27B0E;
        Fri, 25 Nov 2022 15:08:44 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669417722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6hxW2N4kxmUbACxVJ2sLC2tD7nS+hLHLjTZx7sixZYM=;
        b=twx8rF2lsPE6PBtsHMA++brIpc3uCQi+qb0wdSHkIvs7AfFXtCPsY1x4O0PwGnK7QYl3xk
        YEKB4yBS4owCWRqCu6HHA3uQipm3zAOwBuxDGtLOUy62I+YAfSJ2s0QGVER1uhnz53QaRx
        cIYqn6gVZRRxAL0cE210J66VCvKCc07xUfjesKnwcgTAW40UYdKANSpfX2Sa765hgXAqzg
        bLE/eEPyETCs7B2E+0alr7dtdZAKXsHNUDTFUdUlhAiyBU7aCnldKqARjlCUHugS7Ex/Dv
        sYnIfVSCOkXl4dKQoFyQWUPyBgvugFnN/FLcP6RIvDNeJBNIKkXCX1a5Y5aIjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669417722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6hxW2N4kxmUbACxVJ2sLC2tD7nS+hLHLjTZx7sixZYM=;
        b=/L7yn3LQCqK3rKZ4qZRQwSYbwQP7NCTdySqDRR88jr6gFkN+qbUuQYHxLVPWAw4Wh6/QJC
        2lFUsr+kgdfqOZBQ==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v7 3/3] x86: vdso: Wire up getrandom() vDSO implementation
In-Reply-To: <20221124165536.1631325-4-Jason@zx2c4.com>
References: <20221124165536.1631325-1-Jason@zx2c4.com>
 <20221124165536.1631325-4-Jason@zx2c4.com>
Date:   Sat, 26 Nov 2022 00:08:41 +0100
Message-ID: <874jumy6me.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason!

On Thu, Nov 24 2022 at 17:55, Jason A. Donenfeld wrote:
> +++ b/arch/x86/entry/vdso/vgetrandom-chacha.S
> +/*
> + * Very basic SSE2 implementation of ChaCha20. Produces a given positive number
> + * of blocks of output with a nonce of 0, taking an input key and 8-byte
> + * counter. Importantly does not spill to the stack. Its arguments are:

Basic or not. This needs a Reviewed-by from someone who understands SSE2
and ChaCha20 before this can go anywhere near the x86 tree.

> +++ b/arch/x86/entry/vdso/vgetrandom.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> + */
> +#include <linux/kernel.h>

Why do you need kernel.h here?

> +#include <linux/types.h>
> +
> +#include "../../../../lib/vdso/getrandom.c"
> +
> +ssize_t __vdso_getrandom(void *buffer, size_t len, unsigned int flags, void *state);
> +
> +ssize_t __vdso_getrandom(void *buffer, size_t len, unsigned int flags, void *state)
> +{
> +	return __cvdso_getrandom(buffer, len, flags, state);
> +}
> +
> +ssize_t getrandom(void *, size_t, unsigned int, void *)
> +	__attribute__((weak, alias("__vdso_getrandom")));
> diff --git a/arch/x86/include/asm/vdso/getrandom.h b/arch/x86/include/asm/vdso/getrandom.h
> new file mode 100644
> index 000000000000..099aca58ef20
> --- /dev/null
> +++ b/arch/x86/include/asm/vdso/getrandom.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> + */
> +#ifndef __ASM_VDSO_GETRANDOM_H
> +#define __ASM_VDSO_GETRANDOM_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <asm/unistd.h>
> +#include <asm/vvar.h>
> +
> +static __always_inline ssize_t
> +getrandom_syscall(void *buffer, size_t len, unsigned int flags)

static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsigned int flags)

please. We expanded to 100 quite some time ago.

Some kernel-doc compliant comment for this would be appreciated as well.

> +{
> +	long ret;
> +
> +	asm ("syscall" : "=a" (ret) :
> +	     "0" (__NR_getrandom), "D" (buffer), "S" (len), "d" (flags) :
> +	     "rcx", "r11", "memory");
> +
> +	return ret;
> +}
> +
> +#define __vdso_rng_data (VVAR(_vdso_rng_data))
> +
> +static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void)
> +{
> +	if (__vdso_data->clock_mode == VDSO_CLOCKMODE_TIMENS)
> +		return (void *)&__vdso_rng_data +
> +		       ((void *)&__timens_vdso_data - (void *)&__vdso_data);
> +	return &__vdso_rng_data;

So either bite the bullet and  write it:

	if (__vdso_data->clock_mode == VDSO_CLOCKMODE_TIMENS)
		return (void *)&__vdso_rng_data + ((void *)&__timens_vdso_data - (void *)&__vdso_data);

        return &__vdso_rng_data;

or comply to the well documented rules of the tip tree:

   https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#bracket-rules

> +/*
> + * Generates a given positive number of block of ChaCha20 output with nonce=0,
> + * and does not write to any stack or memory outside of the parameters passed
> + * to it. This way, we don't need to worry about stack data leaking into forked
> + * child processes.

Please use proper kernel-doc

> + */
> +static __always_inline void __arch_chacha20_blocks_nostack(u8 *dst_bytes, const u32 *key, u32 *counter, size_t nblocks)
> +{
> +	extern void chacha20_blocks_nostack(u8 *dst_bytes, const u32 *key, u32 *counter, size_t nblocks);
> +	return chacha20_blocks_nostack(dst_bytes, key, counter, nblocks);

You surely have an issue with your newline key...

The above aside, can you please explain the value of this __arch_()
wrapper?

It's just voodoo for no value because it hands through the arguments
1:1. So where are you expecting that that __arch...() version of this is
any different than invoking the architecture specific version of
chacha20_blocks_nostack().

Can you spot the irony of your naming choices?

    __arch_chacha20_blocks_nostack() {
      	return chacha20_blocks_nostack()
    };

Thanks,

        tglx
