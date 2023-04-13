Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9F16E175B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 00:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDMWaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 18:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDMWaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 18:30:22 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8EA903D;
        Thu, 13 Apr 2023 15:30:11 -0700 (PDT)
Date:   Thu, 13 Apr 2023 22:29:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=4j42h4bppra4pjcypmvcuhhscu.protonmail; t=1681425008; x=1681684208;
        bh=TV83wzA0A3DB3ODsttBdVlZSzssILWLHuKJwSKCwli0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=AE7mIAJF88pRuOtE4fv7LAclyNYdraKXl4v8b3+fPuR1FZx0BLl2lIgnJr6wPxbEb
         rHPqic6Ql1KLArD7PFt2OLCDoI72RXWkXBoy0AKHQRVGlU7FRR6rjv6XtRi/rxbPOa
         Zqzlsejgpy5GmVYrKtjuwhdGPThHIJvP0n4DIpFUD+cWG4YM1VVt9Q5OvoAjcPh1BK
         CKaDxQe3oZNhh5nv0tP2CnfA6G4c8qskfEu7v8HMTzqaD6Bn3yt76IHOeDxH83QgO3
         1FNyugG6ykmfIEpyYq2rbJJBjqR4HWP8i7ba+4VQZwKP22uLhz1PdX58H3AKSIlrTE
         JKeJzfJw9jyjw==
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v4 08/13] rust: introduce `ARef`
Message-ID: <9619d06c-d631-1edb-cf92-3a998e7b98f2@proton.me>
In-Reply-To: <CANeycqp_WfJxFDrxJGQ=UO2HOKtKYJCbOwGu50vZKyQSzYuiPQ@mail.gmail.com>
References: <20230411054543.21278-1-wedsonaf@gmail.com> <20230411054543.21278-8-wedsonaf@gmail.com> <f8575380-e710-d505-837c-bfcabe0eff00@proton.me> <CANeycqp_WfJxFDrxJGQ=UO2HOKtKYJCbOwGu50vZKyQSzYuiPQ@mail.gmail.com>
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

On 13.04.23 19:06, Wedson Almeida Filho wrote:
> On Thu, 13 Apr 2023 at 06:19, Benno Lossin <benno.lossin@proton.me> wrote=
:
>>
>> On 11.04.23 07:45, Wedson Almeida Filho wrote:
>>> From: Wedson Almeida Filho <walmeida@microsoft.com>
>>>
>>> This is an owned reference to an object that is always ref-counted. Thi=
s
>>> is meant to be used in wrappers for C types that have their own ref
>>> counting functions, for example, tasks, files, inodes, dentries, etc.
>>>
>>> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
>>> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
>>> ---
>>> v1 -> v2: No changes
>>> v2 -> v3: No changes
>>> v3 -> v4: No changes
>>>
>>>    rust/kernel/types.rs | 107 +++++++++++++++++++++++++++++++++++++++++=
++
>>>    1 file changed, 107 insertions(+)
>>>
>>> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
>>> index a4b1e3778da7..29db59d6119a 100644
>>> --- a/rust/kernel/types.rs
>>> +++ b/rust/kernel/types.rs
>>> @@ -6,8 +6,10 @@ use crate::init::{self, PinInit};
>>>    use alloc::boxed::Box;
>>>    use core::{
>>>        cell::UnsafeCell,
>>> +    marker::PhantomData,
>>>        mem::MaybeUninit,
>>>        ops::{Deref, DerefMut},
>>> +    ptr::NonNull,
>>>    };
>>>
>>>    /// Used to transfer ownership to and from foreign (non-Rust) langua=
ges.
>>> @@ -268,6 +270,111 @@ impl<T> Opaque<T> {
>>>        }
>>>    }
>>>
>>> +/// Types that are _always_ reference counted.
>>> +///
>>> +/// It allows such types to define their own custom ref increment and =
decrement functions.
>>> +/// Additionally, it allows users to convert from a shared reference `=
&T` to an owned reference
>>> +/// [`ARef<T>`].
>>> +///
>>> +/// This is usually implemented by wrappers to existing structures on =
the C side of the code. For
>>> +/// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) =
to create reference-counted
>>> +/// instances of a type.
>>> +///
>>> +/// # Safety
>>> +///
>>> +/// Implementers must ensure that increments to the reference count ke=
ep the object alive in memory
>>> +/// at least until matching decrements are performed.
>>> +///
>>> +/// Implementers must also ensure that all instances are reference-cou=
nted. (Otherwise they
>>> +/// won't be able to honour the requirement that [`AlwaysRefCounted::i=
nc_ref`] keep the object
>>> +/// alive.)
>>
>> `dec_ref` states below that it 'Frees the object when the count reaches
>> zero.', this should also be stated here, since implementers should adher=
e
>> to that when implementing `dec_ref`.
>
> This section is for safety requirements. Freeing the object doesn't
> fall into this category.

It still needs to be upheld by the implementer, since it is guaranteed by
the documentation on the `dec_ref` function. Even non-safety requirements
are listed on the `unsafe` traits, if users should be able to rely on them.
If users should not rely on this, then maybe change the docs of `dec_ref`
to "when the refcount reaches zero, the object might be freed.".

>
>>> +pub unsafe trait AlwaysRefCounted {
>>> +    /// Increments the reference count on the object.
>>> +    fn inc_ref(&self);
>>
>>
>>
>>> +
>>> +    /// Decrements the reference count on the object.
>>> +    ///
>>> +    /// Frees the object when the count reaches zero.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// Callers must ensure that there was a previous matching increme=
nt to the reference count,
>>> +    /// and that the object is no longer used after its reference coun=
t is decremented (as it may
>>> +    /// result in the object being freed), unless the caller owns anot=
her increment on the refcount
>>> +    /// (e.g., it calls [`AlwaysRefCounted::inc_ref`] twice, then call=
s
>>> +    /// [`AlwaysRefCounted::dec_ref`] once).
>>> +    unsafe fn dec_ref(obj: NonNull<Self>);
>>> +}
>>> +
>>> +/// An owned reference to an always-reference-counted object.
>>> +///
>>> +/// The object's reference count is automatically decremented when an =
instance of [`ARef`] is
>>> +/// dropped. It is also automatically incremented when a new instance =
is created via
>>> +/// [`ARef::clone`].
>>> +///
>>> +/// # Invariants
>>> +///
>>> +/// The pointer stored in `ptr` is non-null and valid for the lifetime=
 of the [`ARef`] instance. In
>>> +/// particular, the [`ARef`] instance owns an increment on the underly=
ing object's reference count.
>>> +pub struct ARef<T: AlwaysRefCounted> {
>>> +    ptr: NonNull<T>,
>>> +    _p: PhantomData<T>,
>>> +}
>>> +
>>> +impl<T: AlwaysRefCounted> ARef<T> {
>>> +    /// Creates a new instance of [`ARef`].
>>> +    ///
>>> +    /// It takes over an increment of the reference count on the under=
lying object.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// Callers must ensure that the reference count was incremented a=
t least once, and that they
>>> +    /// are properly relinquishing one increment. That is, if there is=
 only one increment, callers
>>> +    /// must not use the underlying object anymore -- it is only safe =
to do so via the newly
>>> +    /// created [`ARef`].
>>> +    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>>> +        // INVARIANT: The safety requirements guarantee that the new i=
nstance now owns the
>>> +        // increment on the refcount.
>>> +        Self {
>>> +            ptr,
>>> +            _p: PhantomData,
>>> +        }
>>> +    }
>>> +}
>>> +
>>> +impl<T: AlwaysRefCounted> Clone for ARef<T> {
>>> +    fn clone(&self) -> Self {
>>> +        self.inc_ref();
>>> +        // SAFETY: We just incremented the refcount above.
>>> +        unsafe { Self::from_raw(self.ptr) }
>>> +    }
>>> +}
>>> +
>>> +impl<T: AlwaysRefCounted> Deref for ARef<T> {
>>> +    type Target =3D T;
>>> +
>>> +    fn deref(&self) -> &Self::Target {
>>> +        // SAFETY: The type invariants guarantee that the object is va=
lid.
>>> +        unsafe { self.ptr.as_ref() }
>>> +    }
>>> +}
>>> +
>>> +impl<T: AlwaysRefCounted> From<&T> for ARef<T> {
>>> +    fn from(b: &T) -> Self {
>>> +        b.inc_ref();
>>> +        // SAFETY: We just incremented the refcount above.
>>> +        unsafe { Self::from_raw(NonNull::from(b)) }
>>> +    }
>>> +}
>>
>> This impl seems unsound to me, as we can do this:
>>
>>       struct MyStruct {
>>           raw: Opaque<bindings::my_struct>, // This has a `refcount_t` i=
nside.
>>       }
>>
>>       impl MyStruct {
>>           fn new() -> Self { ... }
>>       }
>>
>>       unsafe impl AlwaysRefCounted for MyStruct { ... } // Implemented c=
orrectly.
>>
>>       fn evil() -> ARef<MyStruct> {
>>           let my_struct =3D MyStruct::new();
>>           ARef::from(&my_struct) // We return a pointer to the stack!
>>       }
>>
>> similarly, this can also be done with a `Box`:
>>
>>       fn evil2() -> ARef<MyStruct> {
>>           let my_struct =3D Box::new(MyStruct::new());
>>           ARef::from(&*my_struct)
>>           // Box is freed here, even just dropping the `ARef` will resul=
t in
>>           // a UAF.
>>       }
>
> This implementation of `AlwaysRefCounted` is in violation of the
> safety requirements of the trait, namely:
>
> /// Implementers must ensure that increments to the reference count
> keep the object alive in memory
> /// at least until matching decrements are performed.
> ///
> /// Implementers must also ensure that all instances are
> reference-counted. (Otherwise they
> /// won't be able to honour the requirement that
> [`AlwaysRefCounted::inc_ref`] keep the object
> /// alive.)
>
> It boils down `MyStruct::new` in your example. It's not refcounted.
>
>> Additionally, I think that `AlwaysRefCounted::inc_ref` should not be saf=
e,
>> as the caller must not deallocate the memory until the refcount is zero.
>
> The existence of an `&T` is evidence that the refcount is non-zero, so
> it is safe to increment it. The caller cannot free the object without
> violating the safety requirements.
>
>> Another pitfall of `ARef`: it does not deallocate the memory when the
>> refcount reaches zero. People might expect that this code would not leak
>> memory:
>>
>>       let foo =3D Box::try_new(Foo::new())?;
>>       let foo =3D Box::leak(foo); // Leak the box, such that we do not
>>                                 // deallocate the memory too early.
>>       let foo =3D ARef::from(foo);
>>       drop(foo); // refcount is now zero, but the memory is never deallo=
cated.
>
> This is also in violation of the safety requirements of `AlwaysRefCounted=
`.

It seems I have misunderstood the term "always reference counted".
We should document this in more detail, since this places a lot of
constraints on the implementers:

     Implementing `AlwaysRefCounted` for `T` places the following constrain=
t on shared references `&T`:
     - Every `&T` points to memory that is not deallocated until the refere=
nce count reaches zero.
     - The existence of `&T` proves that the reference count is at least 1.

     This has some important consequences:
     - Exposing safe a way to get `T` is not allowed, since stack allocatio=
ns are freed when the scope
       ends even though the reference count is non-zero.
     - Similarly giving safe access to `Box<T>` or other smart pointers is =
not allowed, since a `Box` can
       be freed independent from the reference count.

     This type is intended to be implemented for C types that embedd a `ref=
count_t` and that are both
     created and destroyed by C. Static references also work with this type=
, since they stay live
     indefinitely.

     Implementers must also ensure that they never give out `&mut T`, since
     - it can be reborrowed as `&T`,
     - converted to `ARef<T>`,
     - which can yield a `&T` that is alive at the same time as the `&mut T=
`.

>>> +
>>> +impl<T: AlwaysRefCounted> Drop for ARef<T> {
>>> +    fn drop(&mut self) {
>>> +        // SAFETY: The type invariants guarantee that the `ARef` owns =
the reference we're about to
>>> +        // decrement.
>>> +        unsafe { T::dec_ref(self.ptr) };
>>> +    }
>>> +}
>>> +
>>>    /// A sum type that always holds either a value of type `L` or `R`.
>>>    pub enum Either<L, R> {
>>>        /// Constructs an instance of [`Either`] containing a value of t=
ype `L`.
>>> --
>>> 2.34.1
>>>
>>

