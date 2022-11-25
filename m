Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0221F639190
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 23:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiKYWjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 17:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKYWjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 17:39:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABFB51C30;
        Fri, 25 Nov 2022 14:39:18 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669415956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N8+MS/xFsgevLrLJv9Sy6tR+lN5BKLIuEXQTXYZ/FII=;
        b=HmyeBrruBj2LHimdQornAPgaRXBHOCEjbEp1Hwz+G9hf07xKu1LRhzesmjO+Sp/fX+kWwY
        RB6NXwfWl+InHA1OvT9xgGOD4epvWf/tqv/dP8/NjFLqfGOKPLleE8AmQCkGxodv0jA7rs
        R6vzddSQ3WP3eg4MRo4IjXWk8rwyfskTdjRaOWKbG0J/1vDjUfHFEaA6a5b/lYR0koFi4F
        +ez58MmituKZ7ITq2U/F/lsr469yw4yk4iYWkupqx6JkpGFCb1mkj1HgMxgTt2KihMH7j1
        +nbb8jPOVzC9/qxJ/AKSpOkoXpnH4Z31jkJVb9okcBsaESvq+YZx4VccqR0r+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669415956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N8+MS/xFsgevLrLJv9Sy6tR+lN5BKLIuEXQTXYZ/FII=;
        b=c8mfDVsSYQNsAOYGPckwOJrHRQws8B5SmkVHaVpODY4E8OC95lTWfvPZPi7eakGt/VZ7hC
        kiIWQLznsjdyOYAw==
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
Subject: Re: [PATCH v7 2/3] random: introduce generic vDSO getrandom()
 implementation
In-Reply-To: <20221124165536.1631325-3-Jason@zx2c4.com>
References: <20221124165536.1631325-1-Jason@zx2c4.com>
 <20221124165536.1631325-3-Jason@zx2c4.com>
Date:   Fri, 25 Nov 2022 23:39:15 +0100
Message-ID: <877cziy7zg.ffs@tglx>
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
>
> Together with the previous commit that introduces vgetrandom_alloc(),

Together with the previous commit is just a complete useless
information. 

> this functionality is intended to be integrated into libc's thread
> management.

vdso_getrandom() and sys_vgetrandom_alloc() provide ..... which is
intended to be integrated ....

> diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
> index 73eb622e7663..cbacfd923a5c 100644
> --- a/include/vdso/datapage.h
> +++ b/include/vdso/datapage.h
> @@ -109,6 +109,11 @@ struct vdso_data {
>  	struct arch_vdso_data	arch_data;
>  };
>  
> +struct vdso_rng_data {
> +	unsigned long generation;
> +	bool is_ready;
> +};

Please follow the coding style in this header:

       - make the struct definition tabular aligned
       - provide kernel doc which explains the struct members

> +config HAVE_VDSO_GETRANDOM
> +	bool
> +	help
> +	  Selected by architectures that support vDSO getrandom().

See ?

>  endif
> diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
> new file mode 100644
> index 000000000000..2c4ef5ef212c
> --- /dev/null
> +++ b/lib/vdso/getrandom.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/atomic.h>
> +#include <linux/fs.h>

No. This is VDSO and builds a userspace library. You cannot include
random kernel headers, which in turn include the world and some more. It
might build today, but any legitimate change to fs.h or one of the
headers included by it will make it explode.

I just fixed up some other instance which included world and I have zero
interest to get more of this "works by chance" things.

If you really need anything from fs.h then please isolate it out into a
separate header file which is included by fs.h and here.

> +#include <vdso/datapage.h>
> +#include <asm/vdso/getrandom.h>
> +#include <asm/vdso/vsyscall.h>
> +#include "getrandom.h"
> +
> +static void memcpy_and_zero(void *dst, void *src, size_t len)
> +{
> +#define CASCADE(type) \
> +	while (len >= sizeof(type)) { \
> +		__put_unaligned_t(type, __get_unaligned_t(type, src), dst); \
> +		__put_unaligned_t(type, 0, src); \
> +		dst += sizeof(type); \
> +		src += sizeof(type); \
> +		len -= sizeof(type); \
> +	}

No. Defines inside of functions are a horrible habit. This is not the
obfuscated C-code contest.

> +#if IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
> +#if BITS_PER_LONG == 64
> +	CASCADE(u64);
> +#endif
> +	CASCADE(u32);
> +	CASCADE(u16);
> +#endif
> +	CASCADE(u8);
> +#undef CASCADE

This is equaly unreadable. I had to reread it 4 times to grok it.

#define MEMCPY_AND_ZERO_SRC(type, dst, src, len)				\
	while (len >= sizeof(type)) {                                           \
		__put_unaligned_t(type, __get_unaligned_t(type, src), dst);     \
		__put_unaligned_t(type, 0, src);                                \
		dst += sizeof(type);                                            \
		src += sizeof(type);                                            \
		len -= sizeof(type);                                            \
	}

static void memcpy_and_zero_src(void *dst, void *src, size_t len)
{
	if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
        	if (IS_ENABLED(CONFIG_64BIT))
                	MEMCPY_AND_ZERO_SRC(u64, dst, src, len);

		MEMCPY_AND_ZERO_SRC(u32, dst, src, len);
		MEMCPY_AND_ZERO_SRC(u16, dst, src, len);
        }
	MEMCPY_AND_ZERO_SRC(u8, dst, src, len);
}

Can you spot the difference in readability and formatting?

> +
> +static __always_inline ssize_t
> +__cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_t len,
> +		       unsigned int flags, void *opaque_state)

Lacks kernel-doc explaining the arguments and the functionality.

> +{
> +	ssize_t ret = min_t(size_t, MAX_RW_COUNT, len);
> +	struct vgetrandom_state *state = opaque_state;
> +	size_t batch_len, nblocks, orig_len = len;
> +	unsigned long current_generation;
> +	void *orig_buffer = buffer;
> +	u32 counter[2] = { 0 };
> +
> +	/*
> +	 * If the kernel isn't yet initialized, then the various flags might have some effect
> +	 * that we can't emulate in userspace, so use the syscall.  Otherwise, the flags have
> +	 * no effect, and can continue.

Sorry, this is word salad which raises a -ENOPARSE here.

@rng_info is a user supplied pointer, but there is zero information how
rng_info->is_ready is set to true because obviously getrandom_syscall()
does not know about it.

I know you described it in the changelog with an example to some extent,
but that does not help the casual reader of this code at all.

> +	 */
> +	if (unlikely(!rng_info->is_ready))
> +		return getrandom_syscall(orig_buffer, orig_len, flags);

What's the point of using orig_buffer and orig_len at this place? I can
understand it below, but here it does not make sense.

> +
> +	if (unlikely(!len))
> +		return 0;

Why go into the kernel above when len == 0?

> +
> +retry_generation:
> +	current_generation = READ_ONCE(rng_info->generation);

READ_ONCE() and WRITE_ONCE() require comments explaining why they are
used and what the actual counterpart of each operation is.

> +	if (unlikely(state->generation != current_generation)) {
> +		/* Write the generation before filling the key, in case there's a fork before. */
> +		WRITE_ONCE(state->generation, current_generation);
> +		/* If the generation is wrong, the kernel has reseeded, so we should too. */
> +		if (getrandom_syscall(state->key, sizeof(state->key), 0) != sizeof(state->key))
> +			return getrandom_syscall(orig_buffer, orig_len, flags);
> +		/* Set state->pos so that the batch is considered emptied. */
> +		state->pos = sizeof(state->batch);

Can you please add newlines into this so the various steps are visually
seperated?

	if (unlikely(state->generation != current_generation)) {
		/* Write the generation before filling the key, in case there's a fork before. */
		WRITE_ONCE(state->generation, current_generation);

		/* If the generation is wrong, the kernel has reseeded, so we should too. */
		if (getrandom_syscall(state->key, sizeof(state->key), 0) != sizeof(state->key))
			return getrandom_syscall(orig_buffer, orig_len, flags);

		/* Set state->pos so that the batch is considered emptied. */
		state->pos = sizeof(state->batch);
	}

Again: Can you spot the difference? Please fix that up all over the place.

Now let me comment on the content of this:

> +	if (unlikely(state->generation != current_generation)) {
> +		/* Write the generation before filling the key, in case there's a fork before. */

There is no space restriction which requires to write comments in a way
that they need crystal balls to decode.

                /*
                 * Update @state->generation before invoking the syscall, 
                 * which fills the key, to protect against a fork FOR
                 * WHATEVER EXPLICIT REASON
                 */

This might be completely obvious to you today, but it's not obvious to
me or anyone else and I'm sure that you would curse these comments six
month down the road yourself.

> +		WRITE_ONCE(state->generation, current_generation);
> +		/* If the generation is wrong, the kernel has reseeded, so we should too. */

Which generation is wrong? Your's or mine? Please spell things
out. There is enough space to do so.

Also please refrain from 'we should ...'. 'We' has no place here.

I know it is a common habit to impersonate code and code execution, but
it's a horrible habit. Aside of being non-factual there are people from
other cultures who really have a hard time to understand this.

Neither is 'should' a proper term here. 'should' is not mandatory.

  "If there is a state generation mismatch, which means the kernel has
   reseeded the random generator, then it is _required_ to reseed the
   vdso buffers too."

Sorry, I really fail to understand this sloppy wording coming from
someone who educates everyone else about the importance of correctness.

If you can't be bothered to express yourself in correct terms
consistently then why do you expect that anyone else understands
randomness or cryptography correctly?

I really appreciate your efforts to make all of this more accessible to
the average user, but please get your act together.

> +		if (getrandom_syscall(state->key, sizeof(state->key), 0) != sizeof(state->key))
> +			return getrandom_syscall(orig_buffer, orig_len, flags);

This lacks an explanation why this might invoke the syscall twice.

> +		/* Set state->pos so that the batch is considered emptied. */

Considered? There is nothing to consider here, right?

                /*
                 * Advance state->pos beyond the end of the batch buffer to
                 * signal that the batch needs to be refilled.
                 */

Hmm?

> +		state->pos = sizeof(state->batch);

> +	}
> +
> +	len = ret;
> +more_batch:
> +	/* First use whatever is left from the last call. */

Last call of what?

> +	batch_len = min_t(size_t, sizeof(state->batch) - state->pos, len);

Where is the sanity check for state->pos <= sizeof(state->batch)?

> +	if (batch_len) {
> +		/* Zero out bytes as they're copied out, to preserve forward secrecy. */

Please name the function so it is self explaining and add an
comprehensive comment to it so you can spare the comment here.

> +		memcpy_and_zero(buffer, state->batch + state->pos, batch_len);
> +		state->pos += batch_len;
> +		buffer += batch_len;
> +		len -= batch_len;

buffer and state->pos could be updated by that non-fail copy function to
aid the compiler, but I might be wrong about the ability of compilers to
optimize code like that.

> +	}
> +	if (!len) {
> +		/*
> +		 * Since rng_info->generation will never be 0, we re-read state->generation,

s/we// ....

> +		 * rather than using the local current_generation variable, to learn whether
> +		 * we forked. Primarily, though, this indicates whether the rng itself has
> +		 * reseeded, in which case we should generate a new key and start over.
> +		 */
> +		if (unlikely(READ_ONCE(state->generation) != READ_ONCE(rng_info->generation))) {
> +			buffer = orig_buffer;
> +			goto retry_generation;
> +		}
> +		return ret;
> +	}
> +
> +	/* Generate blocks of rng output directly into the buffer while there's enough left. */
> +	nblocks = len / CHACHA_BLOCK_SIZE;
> +	if (nblocks) {
> +		__arch_chacha20_blocks_nostack(buffer, state->key, counter, nblocks);
> +		buffer += nblocks * CHACHA_BLOCK_SIZE;
> +		len -= nblocks * CHACHA_BLOCK_SIZE;
> +	}
> +
> +	/* Refill the batch and then overwrite the key, in order to preserve forward secrecy. */
> +	BUILD_BUG_ON(sizeof(state->batch_key) % CHACHA_BLOCK_SIZE != 0);

Does this build bug really need to be glued in between the comment
explaining the function call and the function call itself?

> +	__arch_chacha20_blocks_nostack(state->batch_key, state->key, counter,
> +				       sizeof(state->batch_key) / CHACHA_BLOCK_SIZE);
> +	state->pos = 0;

This reset of state->pos also lacks a comment for the casual reader...

Thanks,

        tglx
