Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9436E1FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 11:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjDNJrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 05:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjDNJrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 05:47:09 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9402A5260;
        Fri, 14 Apr 2023 02:47:06 -0700 (PDT)
Date:   Fri, 14 Apr 2023 09:46:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=z3jh5v3jozakpp3df5m447bjxe.protonmail; t=1681465623; x=1681724823;
        bh=pY+KVq/gVeOM7YWnGQoc40VtdobkIboYvdQNuDkH9Xc=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=NL3bExpfcfeRBjipi1kFVjyCieFajJhDROsdIdlJfqo3Yv/Gr4yfd4u9EQrDztAkq
         bitvRMMcaSLYNStioraWZ2buRxx+lKavpPt8uAcqv31ioDluDlENXBlmRO+57RVUXg
         IPKiCXrea2MqDWEqGIgvbPOzbWdtNptgQtJ5NP4NMeCfbiPm65sPS+WO+rFosZUNSs
         PkUxB4lLmUpK53HRsUY619AhUGfKNX+8jE+TW3UFgqbHpCwknQg0PWmHkG8DxweIUY
         K/0rEm/n1tB3P87Ig3APC8Kqw5G9i7PZtdvt5y8tkWiaUNxSPI7/9wItSWtVFNeVNQ
         ZhbiIxkGFrSJA==
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
Message-ID: <201a4df3-7af4-5b02-5853-f8d274831f90@proton.me>
In-Reply-To: <CANeycqpT6thLZeuFOQqdOFwamYuFLHN5=vwEaSVgC9cNzFtg_A@mail.gmail.com>
References: <20230411054543.21278-1-wedsonaf@gmail.com> <20230411054543.21278-8-wedsonaf@gmail.com> <f8575380-e710-d505-837c-bfcabe0eff00@proton.me> <CANeycqp_WfJxFDrxJGQ=UO2HOKtKYJCbOwGu50vZKyQSzYuiPQ@mail.gmail.com> <9619d06c-d631-1edb-cf92-3a998e7b98f2@proton.me> <CANeycqpT6thLZeuFOQqdOFwamYuFLHN5=vwEaSVgC9cNzFtg_A@mail.gmail.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.04.23 11:00, Wedson Almeida Filho wrote:
> On Thu, 13 Apr 2023 at 19:30, Benno Lossin <benno.lossin@proton.me> wrote=
:
>>
>> On 13.04.23 19:06, Wedson Almeida Filho wrote:
>>> On Thu, 13 Apr 2023 at 06:19, Benno Lossin <benno.lossin@proton.me> wro=
te:
>>>>
>>>> On 11.04.23 07:45, Wedson Almeida Filho wrote:
>>>>> From: Wedson Almeida Filho <walmeida@microsoft.com>
>>>>>
>>>>> This is an owned reference to an object that is always ref-counted. T=
his
>>>>> is meant to be used in wrappers for C types that have their own ref
>>>>> counting functions, for example, tasks, files, inodes, dentries, etc.
>>>>>
>>>>> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
>>>>> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
>>>>> ---
>>>>> v1 -> v2: No changes
>>>>> v2 -> v3: No changes
>>>>> v3 -> v4: No changes
>>>>>
>>>>>     rust/kernel/types.rs | 107 ++++++++++++++++++++++++++++++++++++++=
+++++
>>>>>     1 file changed, 107 insertions(+)
>>>>>
>>>>> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
>>>>> index a4b1e3778da7..29db59d6119a 100644
>>>>> --- a/rust/kernel/types.rs
>>>>> +++ b/rust/kernel/types.rs
>>>>> @@ -6,8 +6,10 @@ use crate::init::{self, PinInit};
>>>>>     use alloc::boxed::Box;
>>>>>     use core::{
>>>>>         cell::UnsafeCell,
>>>>> +    marker::PhantomData,
>>>>>         mem::MaybeUninit,
>>>>>         ops::{Deref, DerefMut},
>>>>> +    ptr::NonNull,
>>>>>     };
>>>>>
>>>>>     /// Used to transfer ownership to and from foreign (non-Rust) lan=
guages.
>>>>> @@ -268,6 +270,111 @@ impl<T> Opaque<T> {
>>>>>         }
>>>>>     }
>>>>>
>>>>> +/// Types that are _always_ reference counted.
>>>>> +///
>>>>> +/// It allows such types to define their own custom ref increment an=
d decrement functions.
>>>>> +/// Additionally, it allows users to convert from a shared reference=
 `&T` to an owned reference
>>>>> +/// [`ARef<T>`].
>>>>> +///
>>>>> +/// This is usually implemented by wrappers to existing structures o=
n the C side of the code. For
>>>>> +/// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc=
) to create reference-counted
>>>>> +/// instances of a type.
>>>>> +///
>>>>> +/// # Safety
>>>>> +///
>>>>> +/// Implementers must ensure that increments to the reference count =
keep the object alive in memory
>>>>> +/// at least until matching decrements are performed.
>>>>> +///
>>>>> +/// Implementers must also ensure that all instances are reference-c=
ounted. (Otherwise they
>>>>> +/// won't be able to honour the requirement that [`AlwaysRefCounted:=
:inc_ref`] keep the object
>>>>> +/// alive.)
>>>>
>>>> `dec_ref` states below that it 'Frees the object when the count reache=
s
>>>> zero.', this should also be stated here, since implementers should adh=
ere
>>>> to that when implementing `dec_ref`.
>>>
>>> This section is for safety requirements. Freeing the object doesn't
>>> fall into this category.
>>
>> It still needs to be upheld by the implementer, since it is guaranteed b=
y
>> the documentation on the `dec_ref` function. Even non-safety requirement=
s
>> are listed on the `unsafe` traits, if users should be able to rely on th=
em.
>> If users should not rely on this, then maybe change the docs of `dec_ref=
`
>> to "when the refcount reaches zero, the object might be freed.".
>
> I disagree that non-safety requirements should be listed under the
> Safety section.
>
> This section is meant for rules that implementers must adhere to to
> ensure their implementations are safe. So it's usually read before
> writing a "SAFETY:" comment for their "unsafe impl" blocks -- adding
> extraneous information is counterproductive.

Sure, I think it you could still mention it outside of the safety section.

>>>>> +pub unsafe trait AlwaysRefCounted {
>>>>> +    /// Increments the reference count on the object.
>>>>> +    fn inc_ref(&self);
>>>>
>>>>
>>>>
>>>>> +
>>>>> +    /// Decrements the reference count on the object.
>>>>> +    ///
>>>>> +    /// Frees the object when the count reaches zero.
>>>>> +    ///
>>>>> +    /// # Safety
>>>>> +    ///
>>>>> +    /// Callers must ensure that there was a previous matching incre=
ment to the reference count,
>>>>> +    /// and that the object is no longer used after its reference co=
unt is decremented (as it may
>>>>> +    /// result in the object being freed), unless the caller owns an=
other increment on the refcount
>>>>> +    /// (e.g., it calls [`AlwaysRefCounted::inc_ref`] twice, then ca=
lls
>>>>> +    /// [`AlwaysRefCounted::dec_ref`] once).
>>>>> +    unsafe fn dec_ref(obj: NonNull<Self>);
>>>>> +}
>>>>> +
>>>>> +/// An owned reference to an always-reference-counted object.
>>>>> +///
>>>>> +/// The object's reference count is automatically decremented when a=
n instance of [`ARef`] is
>>>>> +/// dropped. It is also automatically incremented when a new instanc=
e is created via
>>>>> +/// [`ARef::clone`].
>>>>> +///
>>>>> +/// # Invariants
>>>>> +///
>>>>> +/// The pointer stored in `ptr` is non-null and valid for the lifeti=
me of the [`ARef`] instance. In
>>>>> +/// particular, the [`ARef`] instance owns an increment on the under=
lying object's reference count.
>>>>> +pub struct ARef<T: AlwaysRefCounted> {
>>>>> +    ptr: NonNull<T>,
>>>>> +    _p: PhantomData<T>,
>>>>> +}
>>>>> +
>>>>> +impl<T: AlwaysRefCounted> ARef<T> {
>>>>> +    /// Creates a new instance of [`ARef`].
>>>>> +    ///
>>>>> +    /// It takes over an increment of the reference count on the und=
erlying object.
>>>>> +    ///
>>>>> +    /// # Safety
>>>>> +    ///
>>>>> +    /// Callers must ensure that the reference count was incremented=
 at least once, and that they
>>>>> +    /// are properly relinquishing one increment. That is, if there =
is only one increment, callers
>>>>> +    /// must not use the underlying object anymore -- it is only saf=
e to do so via the newly
>>>>> +    /// created [`ARef`].
>>>>> +    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>>>>> +        // INVARIANT: The safety requirements guarantee that the new=
 instance now owns the
>>>>> +        // increment on the refcount.
>>>>> +        Self {
>>>>> +            ptr,
>>>>> +            _p: PhantomData,
>>>>> +        }
>>>>> +    }
>>>>> +}
>>>>> +
>>>>> +impl<T: AlwaysRefCounted> Clone for ARef<T> {
>>>>> +    fn clone(&self) -> Self {
>>>>> +        self.inc_ref();
>>>>> +        // SAFETY: We just incremented the refcount above.
>>>>> +        unsafe { Self::from_raw(self.ptr) }
>>>>> +    }
>>>>> +}
>>>>> +
>>>>> +impl<T: AlwaysRefCounted> Deref for ARef<T> {
>>>>> +    type Target =3D T;
>>>>> +
>>>>> +    fn deref(&self) -> &Self::Target {
>>>>> +        // SAFETY: The type invariants guarantee that the object is =
valid.
>>>>> +        unsafe { self.ptr.as_ref() }
>>>>> +    }
>>>>> +}
>>>>> +
>>>>> +impl<T: AlwaysRefCounted> From<&T> for ARef<T> {
>>>>> +    fn from(b: &T) -> Self {
>>>>> +        b.inc_ref();
>>>>> +        // SAFETY: We just incremented the refcount above.
>>>>> +        unsafe { Self::from_raw(NonNull::from(b)) }
>>>>> +    }
>>>>> +}
>>>>
>>>> This impl seems unsound to me, as we can do this:
>>>>
>>>>        struct MyStruct {
>>>>            raw: Opaque<bindings::my_struct>, // This has a `refcount_t=
` inside.
>>>>        }
>>>>
>>>>        impl MyStruct {
>>>>            fn new() -> Self { ... }
>>>>        }
>>>>
>>>>        unsafe impl AlwaysRefCounted for MyStruct { ... } // Implemente=
d correctly.
>>>>
>>>>        fn evil() -> ARef<MyStruct> {
>>>>            let my_struct =3D MyStruct::new();
>>>>            ARef::from(&my_struct) // We return a pointer to the stack!
>>>>        }
>>>>
>>>> similarly, this can also be done with a `Box`:
>>>>
>>>>        fn evil2() -> ARef<MyStruct> {
>>>>            let my_struct =3D Box::new(MyStruct::new());
>>>>            ARef::from(&*my_struct)
>>>>            // Box is freed here, even just dropping the `ARef` will re=
sult in
>>>>            // a UAF.
>>>>        }
>>>
>>> This implementation of `AlwaysRefCounted` is in violation of the
>>> safety requirements of the trait, namely:
>>>
>>> /// Implementers must ensure that increments to the reference count
>>> keep the object alive in memory
>>> /// at least until matching decrements are performed.
>>> ///
>>> /// Implementers must also ensure that all instances are
>>> reference-counted. (Otherwise they
>>> /// won't be able to honour the requirement that
>>> [`AlwaysRefCounted::inc_ref`] keep the object
>>> /// alive.)
>>>
>>> It boils down `MyStruct::new` in your example. It's not refcounted.
>>>
>>>> Additionally, I think that `AlwaysRefCounted::inc_ref` should not be s=
afe,
>>>> as the caller must not deallocate the memory until the refcount is zer=
o.
>>>
>>> The existence of an `&T` is evidence that the refcount is non-zero, so
>>> it is safe to increment it. The caller cannot free the object without
>>> violating the safety requirements.
>>>
>>>> Another pitfall of `ARef`: it does not deallocate the memory when the
>>>> refcount reaches zero. People might expect that this code would not le=
ak
>>>> memory:
>>>>
>>>>        let foo =3D Box::try_new(Foo::new())?;
>>>>        let foo =3D Box::leak(foo); // Leak the box, such that we do no=
t
>>>>                                  // deallocate the memory too early.
>>>>        let foo =3D ARef::from(foo);
>>>>        drop(foo); // refcount is now zero, but the memory is never dea=
llocated.
>>>
>>> This is also in violation of the safety requirements of `AlwaysRefCount=
ed`.
>>
>> It seems I have misunderstood the term "always reference counted".
>> We should document this in more detail, since this places a lot of
>> constraints on the implementers:
>>
>>       Implementing `AlwaysRefCounted` for `T` places the following const=
raint on shared references `&T`:
>>       - Every `&T` points to memory that is not deallocated until the re=
ference count reaches zero.
>>       - The existence of `&T` proves that the reference count is at leas=
t 1.
>
> This is implied by the existing safety rules.

This was not obvious to me at all, I think we should extend the docs and
make this very clear.

>>       This has some important consequences:
>>       - Exposing safe a way to get `T` is not allowed, since stack alloc=
ations are freed when the scope
>>         ends even though the reference count is non-zero.
>
> Stack allocations are ok, as long as they wait for the refcount to
> drop to zero before the variable goes out of scope.

"Exposing a **safe** way", you cannot under any circumstances allow safe
code access to by value `T` when it implements `AlwaysRefCounted`, since
safe code can create a `&T` without upholding the invariants.

In your controlled function, you can create `T`s on the stack if you want,
but giving them out to safe code is the problem.

>>       - Similarly giving safe access to `Box<T>` or other smart pointers=
 is not allowed, since a `Box` can
>>         be freed independent from the reference count.
>
> `ARef<T>` is a smart pointer and it is definitely allowed.

Yes, I meant smart pointers except `ARef`. E.g. putting `T` inside of an
`Arc` has the same problem as `Box<T>`.

>
> Similarly to stack allocations I mention above, a `Box<T>`
> implementation is conceivable as long as it ensures that the
> allocation is freed only once the refcount reaches zero, for example,
> by having a drop implementation that performs such a wait. (IOW, when
> `Box<T>` goes out of scope, it always calls `drop` on `T` before
> actually freeing the memory, so this implementation could block until
> it is safe to do so, i.e., until the refcount reaches zero.)

Is this something you want to do? Because to me this sounds like something
that could end up deadlocking very easily.

AIUI `AlwaysRefCounted` is intended for wrapper structs that are never
created on the Rust side. They are created and destroyed by C. The scenario
of putting them into a `Box` or `Arc` should never happen, since Rust does
not have a way to create them.

As soon as this is not the only use case for this trait, I feel like this
trait becomes very dangerous, since there are many different ways for you
to mess up via normal coding patterns.

Hence I think it is better to spell out the dangerous patterns here and
forbid them, since the only use case should never use them anyway.

Also in the `Box` case, the same problem as with `&mut T` exists, since
you can derive a `&mut T` from it.

>
>>       This type is intended to be implemented for C types that embedd a =
`refcount_t` and that are both
>>       created and destroyed by C. Static references also work with this =
type, since they stay live
>>       indefinitely.
>
> Embedding a `refcount_t` is not a requirement. I already mention in
> the documentation that this is usually used for C structs and that
> Rust code should use `Arc`.

I would prefer if we change the wording in the docs from `usually` to
`only`. If you agree with my interpretation above, then Rust types should
not implement this trait.

>
>>       Implementers must also ensure that they never give out `&mut T`, s=
ince
>>       - it can be reborrowed as `&T`,
>>       - converted to `ARef<T>`,
>>       - which can yield a `&T` that is alive at the same time as the `&m=
ut T`.
>
> I agree with this. And I don't think this is a direct consequence of
> the safety requirements, so I think it makes sense to add something
> that covers this.
>
>>>>> +
>>>>> +impl<T: AlwaysRefCounted> Drop for ARef<T> {
>>>>> +    fn drop(&mut self) {
>>>>> +        // SAFETY: The type invariants guarantee that the `ARef` own=
s the reference we're about to
>>>>> +        // decrement.
>>>>> +        unsafe { T::dec_ref(self.ptr) };
>>>>> +    }
>>>>> +}
>>>>> +
>>>>>     /// A sum type that always holds either a value of type `L` or `R=
`.
>>>>>     pub enum Either<L, R> {
>>>>>         /// Constructs an instance of [`Either`] containing a value o=
f type `L`.
>>>>> --
>>>>> 2.34.1
>>>>>
>>>>
>>

