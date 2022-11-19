Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993946311D9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 00:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbiKSXK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 18:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbiKSXKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 18:10:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B130193D0;
        Sat, 19 Nov 2022 15:10:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5C76B8074D;
        Sat, 19 Nov 2022 23:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53913C433D6;
        Sat, 19 Nov 2022 23:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668899414;
        bh=bkuSRBFDHyTrfGrC4KmbCSPIuhtzJ5efV2cTzCfWd9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OSH3LlbuG/YLsIbXArD7xopOxfCB/p10MBAvvDlJclp2WosnSoj9W2OIX2FEJN87F
         wpXb/JiKYvJX5aiZ4QQXRU2gS3Vvt5b5EddUgjrltztyUcDwWP5GPXWQWctEvdHQNG
         Te+W8qJHw3rSRmVjVHBe2VAI7KAJ9wzdXOvKf7+KySR44+zO8MA5u5Ri9JRXntrBwH
         pGmHUsBcC/gbeQRQ6BwHYUkwURkji5c/UQUKLuWnS341GazeyTrKUJP7GyB7lZ7gkE
         +DSbLSWigU0ppFimo8uBMckgDyfwOwtzIjxIRxliciJaw6t+USuwjwdIHltl5Lr69P
         rwAarfNWAofDA==
Date:   Sat, 19 Nov 2022 15:10:12 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH v5 2/3] random: introduce generic vDSO getrandom()
 implementation
Message-ID: <Y3liVEdYByF2gZZU@sol.localdomain>
References: <20221119120929.2963813-1-Jason@zx2c4.com>
 <20221119120929.2963813-3-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119120929.2963813-3-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 01:09:28PM +0100, Jason A. Donenfeld wrote:
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index ab6e02efa432..7dfdbf424c92 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -61,6 +61,7 @@
>  #include <asm/irq.h>
>  #include <asm/irq_regs.h>
>  #include <asm/io.h>
> +#include <vdso/datapage.h>
>  #include "../../lib/vdso/getrandom.h"
>  
>  /*********************************************************************
> @@ -307,6 +308,8 @@ static void crng_reseed(struct work_struct *work)
>  	if (next_gen == ULONG_MAX)
>  		++next_gen;
>  	WRITE_ONCE(base_crng.generation, next_gen);
> +	if (IS_ENABLED(CONFIG_HAVE_VDSO_GETRANDOM))
> +		smp_store_release(&_vdso_rng_data.generation, next_gen + 1);

Is the purpose of the smp_store_release() here to order the writes of
base_crng.generation and _vdso_rng_data.generation?  It could use a comment.

>  	if (!static_branch_likely(&crng_is_ready))
>  		crng_init = CRNG_READY;
>  	spin_unlock_irqrestore(&base_crng.lock, flags);
> @@ -756,6 +759,8 @@ static void __cold _credit_init_bits(size_t bits)
>  		crng_reseed(NULL); /* Sets crng_init to CRNG_READY under base_crng.lock. */
>  		if (static_key_initialized)
>  			execute_in_process_context(crng_set_ready, &set_ready);
> +		if (IS_ENABLED(CONFIG_HAVE_VDSO_GETRANDOM))
> +			smp_store_release(&_vdso_rng_data.is_ready, true);

Similarly, is the purpose of this smp_store_release() to order the writes to the
the generation counters and is_ready?  It could use a comment.

> diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
> new file mode 100644
> index 000000000000..8bef1e92a79d
> --- /dev/null
> +++ b/lib/vdso/getrandom.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/atomic.h>
> +#include <linux/fs.h>
> +#include <vdso/datapage.h>
> +#include <asm/vdso/getrandom.h>
> +#include <asm/vdso/vsyscall.h>
> +#include "getrandom.h"
> +
> +#undef memcpy
> +#define memcpy(d,s,l) __builtin_memcpy(d,s,l)
> +#undef memset
> +#define memset(d,c,l) __builtin_memset(d,c,l)
> +
> +#define CHACHA_FOR_VDSO_INCLUDE
> +#include "../crypto/chacha.c"
> +
> +static void memcpy_and_zero(void *dst, void *src, size_t len)
> +{
> +#define CASCADE(type) \
> +	while (len >= sizeof(type)) { \
> +		*(type *)dst = *(type *)src; \
> +		*(type *)src = 0; \
> +		dst += sizeof(type); \
> +		src += sizeof(type); \
> +		len -= sizeof(type); \
> +	}
> +#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> +#if BITS_PER_LONG == 64
> +	CASCADE(u64);
> +#endif
> +	CASCADE(u32);
> +	CASCADE(u16);
> +#endif
> +	CASCADE(u8);
> +#undef CASCADE
> +}

CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS doesn't mean that dereferencing
misaligned pointers is okay.  You still need to use get_unaligned() and
put_unaligned().  Take a look at crypto_xor(), for example.

> +static __always_inline ssize_t
> +__cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_t len,
> +		       unsigned int flags, void *opaque_state)
> +{
> +	ssize_t ret = min_t(size_t, MAX_RW_COUNT, len);
> +	struct vgetrandom_state *state = opaque_state;
> +	u32 chacha_state[CHACHA_STATE_WORDS];
> +	unsigned long current_generation;
> +	size_t batch_len;
> +
> +	if (unlikely(!rng_info->is_ready))
> +		return getrandom_syscall(buffer, len, flags);
> +
> +	if (unlikely(!len))
> +		return 0;
> +
> +retry_generation:
> +	current_generation = READ_ONCE(rng_info->generation);
> +	if (unlikely(state->generation != current_generation)) {
> +		if (getrandom_syscall(state->key, sizeof(state->key), 0) != sizeof(state->key))
> +			return getrandom_syscall(buffer, len, flags);
> +		WRITE_ONCE(state->generation, current_generation);
> +		state->pos = sizeof(state->batch);
> +	}
> +
> +	len = ret;
> +more_batch:
> +	batch_len = min_t(size_t, sizeof(state->batch) - state->pos, len);
> +	if (batch_len) {
> +		memcpy_and_zero(buffer, state->batch + state->pos, batch_len);
> +		state->pos += batch_len;
> +		buffer += batch_len;
> +		len -= batch_len;
> +	}
> +	if (!len) {
> +		/*
> +		 * Since rng_info->generation will never be 0, we re-read state->generation,
> +		 * rather than using the local current_generation variable, to learn whether
> +		 * we forked.
> +		 */
> +		if (unlikely(READ_ONCE(state->generation) != READ_ONCE(rng_info->generation))) {
> +			buffer -= ret;
> +			goto retry_generation;
> +		}
> +		return ret;
> +	}
> +
> +	chacha_init_consts(chacha_state);
> +	memcpy(&chacha_state[4], state->key, CHACHA_KEY_SIZE);
> +	memset(&chacha_state[12], 0, sizeof(u32) * 4);
> +
> +	while (len >= CHACHA_BLOCK_SIZE) {
> +		chacha20_block(chacha_state, buffer);
> +		if (unlikely(chacha_state[12] == 0))
> +			++chacha_state[13];
> +		buffer += CHACHA_BLOCK_SIZE;
> +		len -= CHACHA_BLOCK_SIZE;
> +	}
> +
> +	chacha20_block(chacha_state, state->key_batch);
> +	if (unlikely(chacha_state[12] == 0))
> +		++chacha_state[13];
> +	chacha20_block(chacha_state, state->key_batch + CHACHA_BLOCK_SIZE);
> +	state->pos = 0;
> +	memzero_explicit(chacha_state, sizeof(chacha_state));
> +	goto more_batch;
> +}

There's a lot of subtle stuff going on here.  Adding some more comments would be
helpful.  Maybe bring in some of the explanation that's currently only in the
commit message.

One question I have is about forking.  So, when a thread calls fork(), in the
child the kernel automatically replaces all vgetrandom_state pages with zeroed
pages (due to MADV_WIPEONFORK).  If the child calls __cvdso_getrandom_data()
afterwards, it sees the zeroed state.  But that's indistinguishable from the
state at the very beginning, after sys_vgetrandom_alloc() was just called,
right?  So as long as this code handles initializing the state at the beginning,
then I'd think it would naturally handle fork() as well.

However, it seems you have something a bit more subtle in mind, where the thread
calls fork() *while* it's in the middle of __cvdso_getrandom_data().  I guess
you are thinking of the case where a signal is sent to the thread while it's
executing __cvdso_getrandom_data(), and then the signal handler calls fork()?
Note that it doesn't matter if a different thread in the *process* calls fork().

If it's possible for the thread to fork() (and hence for the vgetrandom_state to
be zeroed) at absolutely any time, it probably would be a good idea to mark that
whole struct as volatile.

- Eric
