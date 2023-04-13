Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67006E093C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjDMIqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjDMIqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:46:43 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3C08A5E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:46:37 -0700 (PDT)
Date:   Thu, 13 Apr 2023 08:46:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1681375595; x=1681634795;
        bh=0I/cvvpMNFNtXs2XWin/vszkgzAUgAeUAKIfq3GLX/k=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=RWlzmm1GQzYZ1nwcTa2ePHSXZP6eZrmkB3cTRabXCOzxK6+aKS1J9fc1QQtyUwr3e
         csfMhLobVFT4Sjq2YqccWNQPyK5JnY6LtSGR9CW6QVJOeP0Pe4P4CcA0DGY7ZMIX0i
         SwY80tor+0D37nGvRafPstMk5LZHUnypb62s0gHwy67otDpqPul6002wacgTkBBz8i
         cX53Qd25rwJMJie8OfsyBXLHdmoH/qymi18zoc2rAklD1uLLGkoAL5trHAgZcvKotx
         XV5hUe77luobTLvn2iDKtoF3BjOPJF+rkVhIQ/0na+MzX7orXEF4prY0VktfmqT/Mj
         ivkYF2aBC7i7A==
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v4 02/13] rust: sync: introduce `Lock` and `Guard`
Message-ID: <94625fe6-b87a-a8f0-5b2a-a8152d5f7436@proton.me>
In-Reply-To: <20230411054543.21278-2-wedsonaf@gmail.com>
References: <20230411054543.21278-1-wedsonaf@gmail.com> <20230411054543.21278-2-wedsonaf@gmail.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.04.23 07:45, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> They are generic Rust implementations of a lock and a lock guard that
> contain code that is common to all locks. Different backends will be
> introduced in subsequent commits.
>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Suggested-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
> v1 -> v2: No changes
> v2 -> v3: Use new Opaque::ffi_init from Benno's series
> v3 -> v4: Fixed name of parameter in Lock comment
>
>   rust/kernel/sync.rs      |   2 +-
>   rust/kernel/sync/lock.rs | 162 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 163 insertions(+), 1 deletion(-)
>   create mode 100644 rust/kernel/sync/lock.rs
>
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 541d235ffbeb..81b0998eaa18 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -8,6 +8,7 @@
>   use crate::types::Opaque;
>
>   mod arc;
> +pub mod lock;
>
>   pub use arc::{Arc, ArcBorrow, UniqueArc};
>
> @@ -25,7 +26,6 @@ impl LockClassKey {
>           Self(Opaque::uninit())
>       }
>
> -    #[allow(dead_code)]
>       pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
>           self.0.get()
>       }
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> new file mode 100644
> index 000000000000..1a8ecccf4f24
> --- /dev/null
> +++ b/rust/kernel/sync/lock.rs
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Generic kernel lock and guard.
> +//!
> +//! It contains a generic Rust lock and guard that allow for different b=
ackends (e.g., mutexes,
> +//! spinlocks, raw spinlocks) to be provided with minimal effort.
> +
> +use super::LockClassKey;
> +use crate::{bindings, init::PinInit, pin_init, str::CStr, types::Opaque}=
;
> +use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned}=
;
> +use macros::pin_data;
> +
> +/// The "backend" of a lock.
> +///
> +/// It is the actual implementation of the lock, without the need to rep=
eat patterns used in all
> +/// locks.
> +///
> +/// # Safety
> +///
> +/// - Implementers must ensure that only one thread/CPU may access the p=
rotected data once the lock
> +/// is owned, that is, between calls to `lock` and `unlock`.

I am a bit confused which data is protected. The `Backend` should not be
aware of any data it protects. To me the safety requirement is:
- Up to one thread may be in the critical section at any one time.
- When `lock` returns, the current thread has entered the critical
   section.
- A thread leaves the critical section by calling `unlock`.

> +pub unsafe trait Backend {
> +    /// The state required by the lock.
> +    type State;
> +
> +    /// The state required to be kept between lock and unlock.
> +    type GuardState;
> +
> +    /// Initialises the lock.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must be valid for write for the duration of the call, whil=
e `name` and `key` must
> +    /// remain valid for read indefinitely.

- Only call this function once on uninitialized memory.

Do we require some sort of drop guarantee like pin? This function does not
state anything about `State` having to be pinned, but `Lock` is `!Unpin`
(and also pins the state). If other people decide to use `Backend`
somewhere, these things should be clear.

> +    unsafe fn init(
> +        ptr: *mut Self::State,
> +        name: *const core::ffi::c_char,
> +        key: *mut bindings::lock_class_key,
> +    );
> +
> +    /// Acquires the lock, making the caller its owner.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that [`Backend::init`] has been previously c=
alled.

Is it safe to call this function twice? Does `unlock` have to be
called, or is one allowed to drop the value before?

> +    #[must_use]
> +    unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState;
> +
> +    /// Releases the lock, giving up its ownership.
> +    ///
> +    /// # Safety
> +    ///
> +    /// It must only be called by the current owner of the lock.
> +    unsafe fn unlock(ptr: *mut Self::State, guard_state: &Self::GuardSta=
te);
> +}
> +
> +/// A mutual exclusion primitive.
> +///
> +/// Exposes one of the kernel locking primitives. Which one is exposed d=
epends on the lock banckend

Typo: 'banckend' -> '[`Backend`]' (I would prefer a link here)

> +/// specified as the generic parameter `B`.
> +#[pin_data]
> +pub struct Lock<T: ?Sized, B: Backend> {
> +    /// The kernel lock object.
> +    #[pin]
> +    state: Opaque<B::State>,
> +
> +    /// Some locks are known to be self-referential (e.g., mutexes), whi=
le others are architecture
> +    /// or config defined (e.g., spinlocks). So we conservatively requir=
e them to be pinned in case
> +    /// some architecture uses self-references now or in the future.
> +    #[pin]
> +    _pin: PhantomPinned,
> +
> +    /// The data protected by the lock.
> +    data: UnsafeCell<T>,
> +}
> +
> +// SAFETY: `Lock` can be transferred across thread boundaries iff the da=
ta it protects can.

Are there backends where `Backend::State: !Send`? If so we should add
this as a bound, if not, there should be a comment here, since it is
unconditionally implemented. Same for `Sync`

> +unsafe impl<T: ?Sized + Send, B: Backend> Send for Lock<T, B> {}
> +
> +// SAFETY: `Lock` serialises the interior mutability it provides, so it =
is `Sync` as long as the
> +// data it protects is `Send`.
> +unsafe impl<T: ?Sized + Send, B: Backend> Sync for Lock<T, B> {}
> +
> +impl<T, B: Backend> Lock<T, B> {
> +    /// Constructs a new lock initialiser.
> +    #[allow(clippy::new_ret_no_self)]
> +    pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) ->=
 impl PinInit<Self> {
> +        pin_init!(Self {
> +            data: UnsafeCell::new(t),
> +            _pin: PhantomPinned,
> +            // SAFETY: `slot` is valid while the closure is called and b=
oth `name` and `key` have
> +            // static lifetimes so they live indefinitely.
> +            state <- Opaque::ffi_init(|slot| unsafe {
> +                B::init(slot, name.as_char_ptr(), key.as_ptr())
> +            }),
> +        })
> +    }
> +}
> +
> +impl<T: ?Sized, B: Backend> Lock<T, B> {
> +    /// Acquires the lock and gives the caller access to the data protec=
ted by it.
> +    pub fn lock(&self) -> Guard<'_, T, B> {
> +        // SAFETY: The constructor of the type calls `init`, so the exis=
tence of the object proves

I would make 'the type' concrete here: 'The constructor of `Self` ...'. And
then '... so the existence of `self` ...'.

> +        // that `init` was called.
> +        let state =3D unsafe { B::lock(self.state.get()) };
> +        // SAFETY: The lock was just acquired.
> +        unsafe { Guard::new(self, state) }
> +    }
> +}
> +
> +/// A lock guard.
> +///
> +/// Allows mutual exclusion primitives that implement the `Backend` trai=
t to automatically unlock

Make `Backend` a link.

> +/// when a guard goes out of scope. It also provides a safe and convenie=
nt way to access the data
> +/// protected by the lock.
> +#[must_use =3D "the lock unlocks immediately when the guard is unused"]
> +pub struct Guard<'a, T: ?Sized, B: Backend> {
> +    pub(crate) lock: &'a Lock<T, B>,
> +    pub(crate) state: B::GuardState,
> +    _not_send: PhantomData<*mut ()>,
> +}
> +
> +// SAFETY: `Guard` is sync when the data protected by the lock is also s=
ync.
> +unsafe impl<T: Sync + ?Sized, B: Backend> Sync for Guard<'_, T, B> {}
> +
> +impl<T: ?Sized, B: Backend> core::ops::Deref for Guard<'_, T, B> {
> +    type Target =3D T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: The caller owns the lock, so it is safe to deref the =
protected data.
> +        unsafe { &*self.lock.data.get() }
> +    }
> +}
> +
> +impl<T: ?Sized, B: Backend> core::ops::DerefMut for Guard<'_, T, B> {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        // SAFETY: The caller owns the lock, so it is safe to deref the =
protected data.
> +        unsafe { &mut *self.lock.data.get() }
> +    }
> +}
> +
> +impl<T: ?Sized, B: Backend> Drop for Guard<'_, T, B> {
> +    fn drop(&mut self) {
> +        // SAFETY: The caller owns the lock, so it is safe to unlock it.
> +        unsafe { B::unlock(self.lock.state.get(), &self.state) };
> +    }
> +}
> +
> +impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
> +    /// Constructs a new immutable lock guard.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that it owns the lock.
> +    pub(crate) unsafe fn new(lock: &'a Lock<T, B>, state: B::GuardState)=
 -> Self {
> +        Self {
> +            lock,
> +            state,
> +            _not_send: PhantomData,
> +        }
> +    }
> +}
> --
> 2.34.1
>

