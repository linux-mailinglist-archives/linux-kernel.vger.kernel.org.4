Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CF96F578D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 14:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjECMEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 08:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjECMEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 08:04:00 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1121B5585
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 05:03:58 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-50bc1a01cffso3956027a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 05:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683115436; x=1685707436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aNh3nAoRMa4V5EaowqHF7s4OcqODGsJdMyDwfRXX5Dc=;
        b=7EkdGqODljDSobiIzTDmeQFUKbnYpVmD2o1PGwhi/GkC7qaRoP2QddYAMvQrwIUsV9
         hBHpRu4OBxaO+ZLejbgWYiXPbfeL50zkdaoV/xeRyMBrr9PNasu68wJOhbM/6iX3PZZe
         ih8mtHWMoa4bgZoAmgFjvT3icnvTrIYrPX0sPlC46XUwkaYGIBKLv4Ncgv4GrgzYT6hZ
         DsVOdOe7WvizW//5nGqTrETTxBgBLAJ6Vy3+6xo/YJBinp1kiseAcq9GDW5oOoXxt95W
         qz5dX6Bc3EqGXfzua98UA39AgWsuVBtu5yTosXvOWdk88Rk4We+AK3a0VrmMbfEiMqWh
         QD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683115436; x=1685707436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aNh3nAoRMa4V5EaowqHF7s4OcqODGsJdMyDwfRXX5Dc=;
        b=eFsz0HIto7yGAqWWjnj/tjlddQ/V2y31VLJ/+zTz9DIzY7hwtd549h5t6MGRUJkVzC
         MymfCPenX8Q3+5+LKFhr4phB88LPGQfma7NVN/XfxgzFARUskEjonkP9j/dhSv5VcP1H
         8zCPjZhoM+hdJiVD0mrf/YRYrznNl9r0/kwvjCg3b3/hDn7NxJiNfwAqnajITj5+kW6w
         2U9MOc2DduovYYOdw9EGlJnWKzd+Dh7IT5OVc54pUdyhLLsnL7nizCoNxSzZMc3ADSNX
         epJqo8Jyv0y7iKxLgsERL0ISs4GuRQ+Iy9ofAC/VHh1CDui336L+VEVT/jZqn4/BaxGn
         9fjQ==
X-Gm-Message-State: AC+VfDwOcUTjqbn44bx/D40Pza1gTM5wiLlpZ7uGr0pEkJYd/X+b4PLu
        MJEG1lvNDzn2CwcPjSkjs5eu3YwDtMI0RwQ=
X-Google-Smtp-Source: ACHHUZ5Sg0i/GCzPD8JGP59MFHRO+1dlXdn7nksVppSZZKhJAPPp/c+7q+SGeENBK7IAdZi0eNSEBr9c3w6cg8A=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:906:cc14:b0:94f:2cba:b785 with SMTP
 id ml20-20020a170906cc1400b0094f2cbab785mr1253805ejb.12.1683115436592; Wed,
 03 May 2023 05:03:56 -0700 (PDT)
Date:   Wed,  3 May 2023 12:03:54 +0000
In-Reply-To: <20230503090708.2524310-7-nmi@metaspace.dk>
Mime-Version: 1.0
References: <20230503090708.2524310-7-nmi@metaspace.dk>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230503120354.534136-1-aliceryhl@google.com>
Subject: Re: [RFC PATCH 06/11] rust: apply cache line padding for `SpinLock`
From:   Alice Ryhl <aliceryhl@google.com>
To:     nmi@metaspace.dk
Cc:     Damien.LeMoal@wdc.com, a.hindborg@samsung.com,
        alex.gaynor@gmail.com, axboe@kernel.dk, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        gost.dev@samsung.com, hare@suse.de, hch@lst.de, kbusch@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 May 2023 11:07:03 +0200, Andreas Hindborg <a.hindborg@samsung.com> wrote:
> The kernel `struct spinlock` is 4 bytes on x86 when lockdep is not enabled. The
> structure is not padded to fit a cache line. The effect of this for `SpinLock`
> is that the lock variable and the value protected by the lock will share a cache
> line, depending on the alignment requirements of the protected value. Aligning
> the lock variable and the protected value to a cache line yields a 20%
> performance increase for the Rust null block driver for sequential reads to
> memory backed devices at 6 concurrent readers.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>

This applies the cacheline padding to all spinlocks unconditionally.
It's not clear to me that we want to do that. Instead, I suggest using
`SpinLock<CachePadded<T>>` in the null block driver to opt-in to the
cache padding there, and let other drivers choose whether or not they
want to cache pad their locks.

On Wed, 3 May 2023 11:07:03 +0200, Andreas Hindborg <a.hindborg@samsung.com> wrote:
> diff --git a/rust/kernel/cache_padded.rs b/rust/kernel/cache_padded.rs
> new file mode 100644
> index 000000000000..758678e71f50
> --- /dev/null
> +++ b/rust/kernel/cache_padded.rs
> 
> +impl<T> CachePadded<T> {
> +    /// Pads and aligns a value to 64 bytes.
> +    #[inline(always)]
> +    pub(crate) const fn new(t: T) -> CachePadded<T> {
> +        CachePadded::<T> { value: t }
> +    }
> +}

Please make this `pub` instead of just `pub(crate)`. Other drivers might
want to use this directly.

On Wed, 3 May 2023 11:07:03 +0200, Andreas Hindborg <a.hindborg@samsung.com> wrote:
> diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
> index 979b56464a4e..e39142a8148c 100644
> --- a/rust/kernel/sync/lock/spinlock.rs
> +++ b/rust/kernel/sync/lock/spinlock.rs
> @@ -100,18 +103,20 @@ unsafe impl super::Backend for SpinLockBackend {
>      ) {
>          // SAFETY: The safety requirements ensure that `ptr` is valid for writes, and `name` and
>          // `key` are valid for read indefinitely.
> -        unsafe { bindings::__spin_lock_init(ptr, name, key) }
> +        unsafe { bindings::__spin_lock_init((&mut *ptr).deref_mut(), name, key) }
>      }
>  
> +    #[inline(always)]
>      unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
>          // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
>          // memory, and that it has been initialised before.
> -        unsafe { bindings::spin_lock(ptr) }
> +        unsafe { bindings::spin_lock((&mut *ptr).deref_mut()) }
>      }
>  
> +    #[inline(always)]
>      unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
>          // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that the
>          // caller is the owner of the mutex.
> -        unsafe { bindings::spin_unlock(ptr) }
> +        unsafe { bindings::spin_unlock((&mut *ptr).deref_mut()) }
>      }
>  }

I would prefer to remain in pointer-land for the above operations. I
think that this leads to core that is more obviously correct.

For example:

```
impl<T> CachePadded<T> {
    pub const fn raw_get(ptr: *mut Self) -> *mut T {
        core::ptr::addr_of_mut!((*ptr).value)
    }
}

#[inline(always)]
unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
    unsafe { bindings::spin_unlock(CachePadded::raw_get(ptr)) }
}
```
