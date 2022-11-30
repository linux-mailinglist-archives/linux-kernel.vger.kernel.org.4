Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B7263D3CB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbiK3KxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbiK3KxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:53:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEDC7342D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669805532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pvh0cCJDgAci2aX0Jdydv7b4QnzuovzLy7wn9SQOJdE=;
        b=V0XIH9q0JQFWXv5ckaSapJUL0qj+ukD0596w+ktkAfle4DpPx8vAX04sl7Tz/BkmQa+7TF
        Ga/+Yw3iOwiu6vu+DjyzUY0hGp81IK8CV5X1h1BRMC+JNPOIUUTOCh7WGi9YqTl4486OXP
        mzX5ngo8lJG/bohJM2mopEctXrgXGJQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-CWBn_NusP6CRRW80MXlqxw-1; Wed, 30 Nov 2022 05:52:06 -0500
X-MC-Unique: CWBn_NusP6CRRW80MXlqxw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E88E185A588;
        Wed, 30 Nov 2022 10:52:05 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.98])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 411362024CBE;
        Wed, 30 Nov 2022 10:52:03 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v10 1/4] random: add vgetrandom_alloc() syscall
References: <20221129210639.42233-1-Jason@zx2c4.com>
        <20221129210639.42233-2-Jason@zx2c4.com>
Date:   Wed, 30 Nov 2022 11:51:59 +0100
In-Reply-To: <20221129210639.42233-2-Jason@zx2c4.com> (Jason A. Donenfeld's
        message of "Tue, 29 Nov 2022 22:06:36 +0100")
Message-ID: <877czc7m0g.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jason A. Donenfeld:

> +#ifdef CONFIG_VGETRANDOM_ALLOC_SYSCALL
> +/**
> + * vgetrandom_alloc - allocate opaque states for use with vDSO getrandom().
> + *
> + * @num: on input, a pointer to a suggested hint of how many states to
> + * allocate, and on output the number of states actually allocated.

Should userspace call this system call again if it needs more states?
The interface description doesn't make this clear.

> + * @size_per_each: the size of each state allocated, so that the caller can
> + * split up the returned allocation into individual states.
> + *
> + * @flags: currently always zero.
> + *
> + * The getrandom() vDSO function in userspace requires an opaque state, which
> + * this function allocates by mapping a certain number of special pages into
> + * the calling process. It takes a hint as to the number of opaque states
> + * desired, and provides the caller with the number of opaque states actually
> + * allocated, the size of each one in bytes, and the address of the first
> + * state.
> +
> + * Returns a pointer to the first state in the allocation.
> + *
> + */

How do we deallocate this memory?  Must it remain permanently allocated?

Can userspace use the memory for something else if it's not passed to
getrandom?  The separate system call strongly suggests that the
allocation is completely owned by the kernel, but there isn't
documentation here how the allocation life-cycle is supposed to look
like.  In particular, it is not clear if vgetrandom_alloc or getrandom
could retain a reference to the allocation in a future implementation of
these interfaces.

Some users might want to zap the memory for extra hardening after use,
and it's not clear if that's allowed, either.

> +SYSCALL_DEFINE3(vgetrandom_alloc, unsigned int __user *, num,
> +		unsigned int __user *, size_per_each, unsigned int, flags)
> +{

ABI-wise, that should work.

> +	const size_t state_size = sizeof(struct vgetrandom_state);
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
> +	num_states = clamp_t(size_t, num_hint, 1, (SIZE_MAX & PAGE_MASK) / state_size);
> +	alloc_size = PAGE_ALIGN(num_states * state_size);

Doesn't this waste space for one state if state_size happens to be a
power of 2?  Why do this SIZE_MAX & PAGE_MASK thing at all?  Shouldn't
it be PAGE_SIZE / state_size?

> +	if (put_user(alloc_size / state_size, num) || put_user(state_size, size_per_each))
> +		return -EFAULT;
> +
> +	pages_addr = vm_mmap(NULL, 0, alloc_size, PROT_READ | PROT_WRITE,
> +			     MAP_PRIVATE | MAP_ANONYMOUS | MAP_LOCKED, 0);

I think Rasmus has already raised questions about MAP_LOCKED.

I think the kernel cannot rely on it because userspace could call
munlock on the allocation.

> +	if (IS_ERR_VALUE(pages_addr))
> +		return pages_addr;
> +
> +	ret = do_madvise(current->mm, pages_addr, alloc_size, MADV_WIPEONFORK);
> +	if (ret < 0)
> +		goto err_unmap;
> +
> +	return pages_addr;
> +
> +err_unmap:
> +	vm_munmap(pages_addr, alloc_size);
> +	return ret;
> +}
> +#endif

If there's no registration of the allocation, it's not clear why we need
a separate system call for this.  From a documentation perspective, it
may be easier to describe proper use of the getrandom vDSO call if
ownership resides with userspace.  But it will constrain future
evolution of the implementation because you can't add registration
(retaining a reference to the passed-in area in getrandom) after the
fact.  But I'm not sure if this is possible with the current interface,
either.  Userspace has to make some assumptions about the life-cycle to
avoid a memory leak on thread exit.

Thanks,
Florian

