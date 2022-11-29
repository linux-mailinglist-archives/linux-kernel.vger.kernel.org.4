Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A85063CAE6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 23:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbiK2WCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 17:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235900AbiK2WCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 17:02:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEAC20F;
        Tue, 29 Nov 2022 14:02:32 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669759349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DZAHwIvckru6Vi3Gbl8PJvR5WTwEr5s4k3inkGZ1KBo=;
        b=rTPBU8e3CehUcU6xBMQgxtPnl7yv0Eyq/lpyUjWiLrVIZXXBPfGDZTVLLC9V7advjVGav0
        bzZmBQ5FAvCMnLR/e5/mbseSBTT8TAwBqKyWKGT9BKbT7kjAdcRkqT9XTUypXrkWWMoLaF
        NLMlQ3FWEN5C0ih8KHyHJG31XrTpaVHVvZUGBWfvZdOwKo6JrL2Nm6cpx3jvAVqHZUpW4W
        XjE5f8Q5hqtauGGA0L4G0CsZQdIQ0Hy+3g5QNoBcttChK0pRqmtIst5HfzP4e3t1mkMPBx
        5sylWLMRn4plmS/tktcYP/YoUQ0xEh6+mF3eVG/5Th9UL96ErDm6RYHDnFblXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669759349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DZAHwIvckru6Vi3Gbl8PJvR5WTwEr5s4k3inkGZ1KBo=;
        b=mYKio4bZMU6Ug7qrJUJFVW9uIq38INUZeB8GDyXMJ8u6qoU+7tr2exeT6C/TbpFqNi6hVR
        g4szvw5IiK2AzWDQ==
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
Subject: Re: [PATCH v10 1/4] random: add vgetrandom_alloc() syscall
In-Reply-To: <20221129210639.42233-2-Jason@zx2c4.com>
References: <20221129210639.42233-1-Jason@zx2c4.com>
 <20221129210639.42233-2-Jason@zx2c4.com>
Date:   Tue, 29 Nov 2022 23:02:29 +0100
Message-ID: <87cz95v2q2.ffs@tglx>
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

On Tue, Nov 29 2022 at 22:06, Jason A. Donenfeld wrote:
> +
> +/********************************************************************
> + *
> + * vDSO support helpers.
> + *
> + * The actual vDSO function is defined over in lib/vdso/getrandom.c,
> + * but this section contains the kernel-mode helpers to support that.
> + *
> + ********************************************************************/
> +
> +#ifdef CONFIG_VGETRANDOM_ALLOC_SYSCALL
> +/**
> + * vgetrandom_alloc - allocate opaque states for use with vDSO getrandom().
> + *
> + * @num: on input, a pointer to a suggested hint of how many states to
> + * allocate, and on output the number of states actually allocated.
> + *
> + * @size_per_each: the size of each state allocated, so that the caller can
> + * split up the returned allocation into individual states.
> + *
> + * @flags: currently always zero.

NIT!

I personally prefer and ask for it in stuff I maintain:

 * @num:		On input, a pointer to a suggested hint of how many states to
 *			allocate, and on output the number of states actually allocated.
 *
 * @size_per_each: 	The size of each state allocated, so that the caller can
 * 			split up the returned allocation into individual states.
 *
 * @flags: 		Currently always zero.

But your turf :)

> + *
> + * The getrandom() vDSO function in userspace requires an opaque state, which
> + * this function allocates by mapping a certain number of special pages into
> + * the calling process. It takes a hint as to the number of opaque states
> + * desired, and provides the caller with the number of opaque states actually
> + * allocated, the size of each one in bytes, and the address of the first
> + * state.

make W=1 rightfully complains about:

> +

drivers/char/random.c:182: warning: bad line: 

> + * Returns a pointer to the first state in the allocation.

I have serious doubts that this statement is correct.

Think about this comment and documentation as a boiler plate for the
mandatory man page for a new syscall (hint...)

> + *
> + */

and W=1 also complains rightfully here:

> +SYSCALL_DEFINE3(vgetrandom_alloc, unsigned int __user *, num,
> +		unsigned int __user *, size_per_each, unsigned int, flags)

drivers/char/random.c:188: warning: expecting prototype for vgetrandom_alloc(). Prototype was for sys_vgetrandom_alloc() instead

> +{
> diff --git a/include/vdso/getrandom.h b/include/vdso/getrandom.h
> new file mode 100644
> index 000000000000..5f04c8bf4bd4
> --- /dev/null
> +++ b/include/vdso/getrandom.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> + */
> +
> +#ifndef _VDSO_GETRANDOM_H
> +#define _VDSO_GETRANDOM_H
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
> +	bool in_use;
> +};

Again, please make this properly tabular:

struct vgetrandom_state {
	union {
		struct {
			u8	batch[CHACHA_BLOCK_SIZE * 3 / 2];
			u32	key[CHACHA_KEY_SIZE / sizeof(u32)];
		};
		u8	batch_key[CHACHA_BLOCK_SIZE * 2];
	};
	unsigned long	generation;
	u8		pos;
	bool		in_use;
};

Plus some kernel doc which explains what this is about.

Thanks,

        tglx
