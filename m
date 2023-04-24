Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647E16DB5FD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 23:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjDGV7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 17:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjDGV7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 17:59:38 -0400
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A307ED0
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 14:59:36 -0700 (PDT)
Date:   Fri, 07 Apr 2023 21:59:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680904774; x=1681163974;
        bh=/4akTJdCic2QY2I7m0VwCcocwGvSRK4Skfpuoyu1kww=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=uU2Fx9cUTnwZVafX317cac7uuUYBszjxUHcrXR0M/49VMnpHsIFWvicKQmUXyGfGw
         yo3iax0MkyH3ttcV2HgFBhzSdV+hnBij/umqs9nXUQwapzsGIPEL+XrcdVJFvZNN+9
         WxcFazU6mh/WXaa3swlfQnNMUgVATSAZT6HKxjKi1GmnUdgWc/OYG+sA+uN7ST6NbY
         s/Fr1U1SwkmObE7e8g2aq+LBX9GHUTc4u81/FUDQu4wzjktFYqYJElNc9DGcWirqvK
         aT5++lwop2chx993BQyfLsVnjKejfP25T4LXza0rkQRyS6uZWkxsKrRylQZovUxLx0
         ld8n//87XrniA==
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v2 08/13] rust: introduce `ARef`
Message-ID: <236fe27d-ce0c-88e0-6830-f4079ef23a87@protonmail.com>
In-Reply-To: <20230405175111.5974-8-wedsonaf@gmail.com>
References: <20230405175111.5974-1-wedsonaf@gmail.com> <20230405175111.5974-8-wedsonaf@gmail.com>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.04.23 19:51, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> This is an owned reference to an object that is always ref-counted. This
> is meant to be used in wrappers for C types that have their own ref
> counting functions, for example, tasks, files, inodes, dentries, etc.
>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
> v1 -> v2: No changes
>
>   rust/kernel/types.rs | 107 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 107 insertions(+)
>
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index dbfae9bb97ce..b071730253c7 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -6,8 +6,10 @@ use crate::init::{self, PinInit};
>   use alloc::boxed::Box;
>   use core::{
>       cell::UnsafeCell,
> +    marker::PhantomData,
>       mem::MaybeUninit,
>       ops::{Deref, DerefMut},
> +    ptr::NonNull,
>   };
>
>   /// Used to transfer ownership to and from foreign (non-Rust) languages=
.
> @@ -295,6 +297,111 @@ opaque_init_funcs! {
>       "Rust" manual_init4(arg1: A1, arg2: A2, arg3: A3, arg4: A4);
>   }
>
> +/// Types that are _always_ reference counted.
> +///
> +/// It allows such types to define their own custom ref increment and de=
crement functions.
> +/// Additionally, it allows users to convert from a shared reference `&T=
` to an owned reference
> +/// [`ARef<T>`].
> +///
> +/// This is usually implemented by wrappers to existing structures on th=
e C side of the code. For
> +/// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) to=
 create reference-counted
> +/// instances of a type.
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that increments to the reference count keep=
 the object alive in memory
> +/// at least until matching decrements are performed.
> +///
> +/// Implementers must also ensure that all instances are reference-count=
ed. (Otherwise they
> +/// won't be able to honour the requirement that [`AlwaysRefCounted::inc=
_ref`] keep the object
> +/// alive.)
> +pub unsafe trait AlwaysRefCounted {
> +    /// Increments the reference count on the object.
> +    fn inc_ref(&self);
> +
> +    /// Decrements the reference count on the object.
> +    ///
> +    /// Frees the object when the count reaches zero.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that there was a previous matching increment=
 to the reference count,
> +    /// and that the object is no longer used after its reference count =
is decremented (as it may
> +    /// result in the object being freed), unless the caller owns anothe=
r increment on the refcount
> +    /// (e.g., it calls [`AlwaysRefCounted::inc_ref`] twice, then calls
> +    /// [`AlwaysRefCounted::dec_ref`] once).
> +    unsafe fn dec_ref(obj: NonNull<Self>);
> +}
> +
> +/// An owned reference to an always-reference-counted object.
> +///
> +/// The object's reference count is automatically decremented when an in=
stance of [`ARef`] is
> +/// dropped. It is also automatically incremented when a new instance is=
 created via
> +/// [`ARef::clone`].
> +///
> +/// # Invariants
> +///
> +/// The pointer stored in `ptr` is non-null and valid for the lifetime o=
f the [`ARef`] instance. In
> +/// particular, the [`ARef`] instance owns an increment on the underlyin=
g object's reference count.
> +pub struct ARef<T: AlwaysRefCounted> {
> +    ptr: NonNull<T>,
> +    _p: PhantomData<T>,
> +}
> +
> +impl<T: AlwaysRefCounted> ARef<T> {
> +    /// Creates a new instance of [`ARef`].
> +    ///
> +    /// It takes over an increment of the reference count on the underly=
ing object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the reference count was incremented at =
least once, and that they
> +    /// are properly relinquishing one increment. That is, if there is o=
nly one increment, callers
> +    /// must not use the underlying object anymore -- it is only safe to=
 do so via the newly
> +    /// created [`ARef`].

I think you should also mention that the pointee at `ptr` must live
at least until this `ARef` decides to decrement the refcount.
Otherwise I would interpret the docs as written to allow you to give
a pointer to the stack and then free the backing storage and then
continue to use the `ARef`.

--
Cheers,
Benno

> +    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
> +        // INVARIANT: The safety requirements guarantee that the new ins=
tance now owns the
> +        // increment on the refcount.
> +        Self {
> +            ptr,
> +            _p: PhantomData,
> +        }
> +    }
> +}
> +
> +impl<T: AlwaysRefCounted> Clone for ARef<T> {
> +    fn clone(&self) -> Self {
> +        self.inc_ref();
> +        // SAFETY: We just incremented the refcount above.
> +        unsafe { Self::from_raw(self.ptr) }
> +    }
> +}
> +
> +impl<T: AlwaysRefCounted> Deref for ARef<T> {
> +    type Target =3D T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: The type invariants guarantee that the object is vali=
d.
> +        unsafe { self.ptr.as_ref() }
> +    }
> +}
> +
> +impl<T: AlwaysRefCounted> From<&T> for ARef<T> {
> +    fn from(b: &T) -> Self {
> +        b.inc_ref();
> +        // SAFETY: We just incremented the refcount above.
> +        unsafe { Self::from_raw(NonNull::from(b)) }
> +    }
> +}
> +
> +impl<T: AlwaysRefCounted> Drop for ARef<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: The type invariants guarantee that the `ARef` owns th=
e reference we're about to
> +        // decrement.
> +        unsafe { T::dec_ref(self.ptr) };
> +    }
> +}
> +
>   /// A sum type that always holds either a value of type `L` or `R`.
>   pub enum Either<L, R> {
>       /// Constructs an instance of [`Either`] containing a value of type=
 `L`.
> --
> 2.34.1
>

