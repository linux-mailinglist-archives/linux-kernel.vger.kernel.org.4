Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF4B666628
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 23:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbjAKWXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 17:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbjAKWX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 17:23:27 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0031D431A6;
        Wed, 11 Jan 2023 14:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1673475805;
        bh=1Oxpyw0xOs6/7W8Tuvd1QWxZNFxc0oTmNh4yGrJ47L0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ahLgkiB5IQ5QRVqLfHoeZAVd/D9rkVuFxvdtTNVcpj+nX3+Rzvw9sNQfLAFLHAfuC
         fx2epI4w+DJKuXv6m4KR7SNDMY4qMZkhSzNmwfHDp9UqNnqPC07Z+ESFd62ySxl27x
         1wDae6L32WANYrSWVuQ5r5f0bvZJC1zbqZBt+qAO6TYRifgM/TovLMfKe8NlW3HsLj
         fGxSA7BZCmBpd8/UoA5TukoL0tLQap1kgsp3nWKpTHdr1PKfLtKXSds8I04INn6pf9
         2Ku8+BOZMXNrPpCwYL7CdG4HKbEZoiMxoIHB2d2PRE0F6GcbbuI2DJ91Zc50i/9/Ua
         ZUhqiJZIJYa4A==
Received: from localhost (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Nshz073rzzgWG;
        Wed, 11 Jan 2023 17:23:24 -0500 (EST)
Date:   Wed, 11 Jan 2023 17:23:56 -0500
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v14 0/7] implement getrandom() in vDSO
Message-ID: <Y782/D2WZJRR8SHY@localhost>
References: <20230101162910.710293-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230101162910.710293-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-Jan-2023 05:29:03 PM, Jason A. Donenfeld wrote:
[...]
> Two statements:
> 
>   1) Userspace wants faster cryptographically secure random numbers of
>      arbitrary size, big or small.
> 
>   2) Userspace is currently unable to safely roll its own RNG with the
>      same security profile as getrandom().
>
[...]
> API-wise, the vDSO gains this function:
> 
>   ssize_t vgetrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state);
> 
> The return value and the first 3 arguments are the same as ordinary
> getrandom(), while the last argument is a pointer to some state
> allocated with vgetrandom_alloc(), explained below. Were all four
> arguments passed to the getrandom syscall, nothing different would
> happen, and the functions would have the exact same behavior.
> 
> Then, we introduce a new syscall:
> 
>   void *vgetrandom_alloc(unsigned int *num, unsigned int *size_per_each,
>                          unsigned long addr, unsigned int flags);
> 
> This takes a hinted number of opaque states in `num`, and returns a
> pointer to an array of opaque states, the number actually allocated back
> in `num`, and the size in bytes of each one in `size_per_each`, enabling
> a libc to slice up the returned array into a state per each thread. (The
> `flags` and `addr` arguments, as well as the `*size_per_each` input
> value, are reserved for the future and are forced to be zero for now.)
> 
> Libc is expected to allocate a chunk of these on first use, and then
> dole them out to threads as they're created, allocating more when
> needed. The returned address of the first state may be passed to
> munmap(2) with a length of `num * size_per_each`, in order to deallocate
> the memory.
> 
> We very intentionally do *not* leave state allocation up to the caller
> of vgetrandom, but provide vgetrandom_alloc for that allocation. There
> are too many weird things that can go wrong, and it's important that
> vDSO does not provide too generic of a mechanism. It's not going to
> store its state in just any old memory address. It'll do it only in ones
> it allocates.

[...]

Have you considered extending rseq(2) per-thread "struct rseq" with an
additional "prng_seed" pointer field, which would point to a per-thread
memory area accessible both from userspace (at address
__builtin_thread_pointer() + __rseq_offset) and from kernel's
return-to-userspace rseq notification code (which can handle page
faults) ?

This way, the kernel can update its content when returning to userspace
if an update is needed since the last update.

Would that be sufficient as prng seed for your security requirements ?

Implementation-wise, the semantic of the prng_seed could be entirely
internal to a vgetrandom vDSO implementation, but the allocation of the
memory holding this seed would be the responsibility of libc.

libc could query the size required by the kernel for this prng seed with
a new getauxval(3) entry, e.g. AT_RSEQ_PRNG_SIZE. By doing so, libc
would only allocate as much memory as needed by the kernel vDSO
implementation.

This would remove the need for any kind of vgetrandom_alloc system call
and all its associated complexity.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
