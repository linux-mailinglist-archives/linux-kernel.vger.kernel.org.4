Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4EE6390CC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 21:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiKYUpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 15:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiKYUpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 15:45:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3789355CB2;
        Fri, 25 Nov 2022 12:45:35 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669409132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nx7J1ZYr7PRDjr0HjbjLwEuOmEiqovGUiWQQwnfrbYQ=;
        b=AdCx8VPE/lzRBFp7vbqM3AWVW89sObDyt43L3+MHIoDr1ZzaVYwNcdPk1SFmEv+x41P4rg
        jmmVPNEhH0Dt6Ar4z6lI4svK79bAj6/nzBllkMSCGFBgGz+NNHxjR9kz1BgSvDqfDhHkHR
        MdA7+TniTH4Llx5g5AYETV37fiBxXc0Vbn59hmZ3ryGKfeHR8B/zRYu1zsWl4cUYrhKcgO
        bngTt11EPv4BYrkv4hOhJsRQC/tIjIVL8XIPhC12VfRbcqVzQN4knhwAm+HOknvZd3JclX
        vO+Ic1zJts7unrwo2HsRzwS9cVglJ4Jy8zdFxXCORI9f72omzt0DZijsgKzZLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669409132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nx7J1ZYr7PRDjr0HjbjLwEuOmEiqovGUiWQQwnfrbYQ=;
        b=HFsIpAcT6mMdpz79iidHhND9Aa/Q6QqVc7oqC6hX0dK3g5hv7aHto9ob0Xt4sKULt+jUCy
        SN3mGKCZx+oHUaAQ==
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
Subject: Re: [PATCH v7 1/3] random: add vgetrandom_alloc() syscall
In-Reply-To: <20221124165536.1631325-2-Jason@zx2c4.com>
References: <20221124165536.1631325-1-Jason@zx2c4.com>
 <20221124165536.1631325-2-Jason@zx2c4.com>
Date:   Fri, 25 Nov 2022 21:45:31 +0100
Message-ID: <87bkouyd90.ffs@tglx>
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

On Thu, Nov 24 2022 at 17:55, Jason A. Donenfeld wrote:
> ---
>  MAINTAINERS                             |  1 +
>  arch/x86/Kconfig                        |  1 +
>  arch/x86/entry/syscalls/syscall_64.tbl  |  1 +
>  arch/x86/include/asm/unistd.h           |  1 +
>  drivers/char/random.c                   | 59 +++++++++++++++++++++++++
>  include/uapi/asm-generic/unistd.h       |  7 ++-
>  kernel/sys_ni.c                         |  3 ++
>  lib/vdso/getrandom.h                    | 23 ++++++++++
>  scripts/checksyscalls.sh                |  4 ++
>  tools/include/uapi/asm-generic/unistd.h |  7 ++-
>  10 files changed, 105 insertions(+), 2 deletions(-)
>  create mode 100644 lib/vdso/getrandom.h

I think I asked for this before:

Please split these things properly up. Provide the syscall and then wire
it up.

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 67745ceab0db..331e21ba961a 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -59,6 +59,7 @@ config X86
>  	#
>  	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
>  	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
> +	select ADVISE_SYSCALLS			if X86_64

Why is this x86_64 specific?

> --- a/arch/x86/include/asm/unistd.h
> +++ b/arch/x86/include/asm/unistd.h
> @@ -27,6 +27,7 @@
>  #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64
>  #  define __ARCH_WANT_COMPAT_SYS_PREADV64V2
>  #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64V2
> +#  define __ARCH_WANT_VGETRANDOM_ALLOC

So instead of this define, why can't you do:

config VGETRADOM_ALLOC
       bool
       select ADVISE_SYSCALLS

and then have

config GENERIC_VDSO_RANDOM_WHATEVER
       bool
       select VGETRANDOM_ALLOC

This gives a clear Kconfig dependency instead of the random
ADVISE_SYSCALLS select.

>--- a/drivers/char/random.c
> +++ b/drivers/char/random.c

> +#include "../../lib/vdso/getrandom.h"

Seriously?

include/vdso/ exists for a reason.

> +#ifdef __ARCH_WANT_VGETRANDOM_ALLOC
> +/*
> + * The vgetrandom() function in userspace requires an opaque state, which this
> + * function provides to userspace, by mapping a certain number of special pages
> + * into the calling process. It takes a hint as to the number of opaque states
> + * desired, and returns the number of opaque states actually allocated, the
> + * size of each one in bytes, and the address of the first state.

As this is a syscall which can be invoked outside of the VDSO, can you
please provide proper kernel-doc which explains the arguments, the
functionality and the return value?

> + */
> +SYSCALL_DEFINE3(vgetrandom_alloc, unsigned int __user *, num,
> +		unsigned int __user *, size_per_each, unsigned int, flags)
> +{
> +	size_t alloc_size, num_states;
> +	unsigned long pages_addr;
> +	unsigned int num_hint;
> +	int ret;
> +
> +	if (flags)
> +		return -EINVAL;
> +
> +	if (get_user(num_hint, num))
> +		return -EFAULT;
> +
> +	num_states = clamp_t(size_t, num_hint, 1, (SIZE_MAX & PAGE_MASK) / sizeof(struct vgetrandom_state));
> +	alloc_size = PAGE_ALIGN(num_states * sizeof(struct vgetrandom_state));
> +
> +	if (put_user(alloc_size / sizeof(struct vgetrandom_state), num) ||
> +	    put_user(sizeof(struct vgetrandom_state), size_per_each))
> +		return -EFAULT;

That's a total of four sizeof(struct vgetrandom_state) usage sites.

       size_t state_size = sizeof(struct vgetrandom_state);

perhaps?

> diff --git a/lib/vdso/getrandom.h b/lib/vdso/getrandom.h
> new file mode 100644
> index 000000000000..c7f727db2aaa
> --- /dev/null
> +++ b/lib/vdso/getrandom.h

Wrong place. See above.

> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> + */
> +
> +#ifndef _VDSO_LIB_GETRANDOM_H
> +#define _VDSO_LIB_GETRANDOM_H
> +
> +#include <crypto/chacha.h>
> +
> +struct vgetrandom_state {
> +	union {
> +		struct {
> +			u8 batch[CHACHA_BLOCK_SIZE * 3 / 2];
> +			u32 key[CHACHA_KEY_SIZE / sizeof(u32)];
> +		};
> +		u8 batch_key[CHACHA_BLOCK_SIZE * 2];
> +	};
> +	unsigned long generation;
> +	u8 pos;
> +};

Thanks,

        tglx
