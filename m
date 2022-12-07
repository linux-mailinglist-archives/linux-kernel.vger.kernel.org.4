Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A257645728
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiLGKIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiLGKIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:08:41 -0500
X-Greylist: delayed 76566 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Dec 2022 02:08:35 PST
Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [195.10.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB74E6478;
        Wed,  7 Dec 2022 02:08:34 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4NRtK610Dpz9tNf;
        Wed,  7 Dec 2022 11:08:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyantec.com; s=default;
        t=1670407706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UtXMoeXi1qBSi9cvHiCoHNypqIMOxmxK2Icq0MwhSb4=;
        b=EeMEfGVJQlqDJWmSgBWm5BCfy1s1okzxFTi6o+w7qDiiygCt/+is3+Fn4K0x1eMp9TvuAI
        Kcv8F5mUZD4WrASOU0MR9iSZn+M7hGesvpymwDAT9XlsBRN1htYNbRkE3NhR8RVuchXvcF
        36UsYtRZJnVuH2OJm+DRxYuUctgfnTbb70hhWQQNNE9WyuY0VaJZiXgKXoZrPnaNcBvyE2
        CMKpvUOLBmVmXC3M10mYQv45OkWdUK/lsPszqxFEA+0l+g09ejRbfZQkPjEdKkM8/vv/U0
        1eYFsVlFvBqXQa5sz2ikb49HgZH2NEcTmweADcOnuorp2jXxXEu02I8a/mCuAA==
From:   Finn Behrens <fin@nyantec.com>
To:     ojeda@kernel.org
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH v1] rust: alloc: remove the `borrow` module (`ToOwned`,
 `Cow`)
Date:   Wed, 07 Dec 2022 11:08:08 +0100
Message-ID: <EF1A0F36-36F5-4538-817F-ABB2C9EA2180@nyantec.com>
In-Reply-To: <20221206010519.39075-1-ojeda@kernel.org>
References: <20221206010519.39075-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6 Dec 2022, at 2:05, ojeda@kernel.org wrote:

> From: Miguel Ojeda <ojeda@kernel.org>
>
> The `Cow` type [1] requires that its generic parameter type implements
> the `ToOwned` trait [2], which provides a method to create owned data
> from borrowed data, usually by cloning.
>
> However, it is infallible, and thus in most cases it is not useful for
> the kernel. [3]
>
> Therefore, introduce `cfg(no_borrow)` to remove the `borrow` module
> (which contains `ToOwned` and `Cow`) from `alloc`.
Maybe in the future, if Cow is helpful, we could create a TryToOwned trai=
t (and then probably TryCow), but for now this looks good.

>
> Link: https://doc.rust-lang.org/alloc/borrow/enum.Cow.html [1]
> Link: https://doc.rust-lang.org/alloc/borrow/trait.ToOwned.html [2]
> Link: https://lore.kernel.org/rust-for-linux/20221204103153.117675b1@Ga=
ryWorkstation/ [3]
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Finn Behrens <fin@nyantec.com>

Regards,
Finn

> ---
>  rust/Makefile         |   1 +
>  rust/alloc/borrow.rs  | 498 ------------------------------------------=

>  rust/alloc/lib.rs     |   3 +-
>  rust/alloc/vec/mod.rs |   3 +
>  4 files changed, 6 insertions(+), 499 deletions(-)
>  delete mode 100644 rust/alloc/borrow.rs
>
> diff --git a/rust/Makefile b/rust/Makefile
> index 7700d3853404..208b520fcbea 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -44,6 +44,7 @@ core-cfgs =3D \
>      --cfg no_fp_fmt_parse
>
>  alloc-cfgs =3D \
> +    --cfg no_borrow \
>      --cfg no_fmt \
>      --cfg no_global_oom_handling \
>      --cfg no_macros \
> diff --git a/rust/alloc/borrow.rs b/rust/alloc/borrow.rs
> deleted file mode 100644
> index dde4957200d4..000000000000
> --- a/rust/alloc/borrow.rs
> +++ /dev/null
> @@ -1,498 +0,0 @@
> -// SPDX-License-Identifier: Apache-2.0 OR MIT
> -
> -//! A module for working with borrowed data.
> -
> -#![stable(feature =3D "rust1", since =3D "1.0.0")]
> -
> -use core::cmp::Ordering;
> -use core::hash::{Hash, Hasher};
> -use core::ops::Deref;
> -#[cfg(not(no_global_oom_handling))]
> -use core::ops::{Add, AddAssign};
> -
> -#[stable(feature =3D "rust1", since =3D "1.0.0")]
> -pub use core::borrow::{Borrow, BorrowMut};
> -
> -use core::fmt;
> -#[cfg(not(no_global_oom_handling))]
> -use crate::string::String;
> -
> -use Cow::*;
> -
> -#[stable(feature =3D "rust1", since =3D "1.0.0")]
> -impl<'a, B: ?Sized> Borrow<B> for Cow<'a, B>
> -where
> -    B: ToOwned,
> -    <B as ToOwned>::Owned: 'a,
> -{
> -    fn borrow(&self) -> &B {
> -        &**self
> -    }
> -}
> -
> -/// A generalization of `Clone` to borrowed data.
> -///
> -/// Some types make it possible to go from borrowed to owned, usually =
by
> -/// implementing the `Clone` trait. But `Clone` works only for going f=
rom `&T`
> -/// to `T`. The `ToOwned` trait generalizes `Clone` to construct owned=
 data
> -/// from any borrow of a given type.
> -#[cfg_attr(not(test), rustc_diagnostic_item =3D "ToOwned")]
> -#[stable(feature =3D "rust1", since =3D "1.0.0")]
> -pub trait ToOwned {
> -    /// The resulting type after obtaining ownership.
> -    #[stable(feature =3D "rust1", since =3D "1.0.0")]
> -    type Owned: Borrow<Self>;
> -
> -    /// Creates owned data from borrowed data, usually by cloning.
> -    ///
> -    /// # Examples
> -    ///
> -    /// Basic usage:
> -    ///
> -    /// ```
> -    /// let s: &str =3D "a";
> -    /// let ss: String =3D s.to_owned();
> -    ///
> -    /// let v: &[i32] =3D &[1, 2];
> -    /// let vv: Vec<i32> =3D v.to_owned();
> -    /// ```
> -    #[stable(feature =3D "rust1", since =3D "1.0.0")]
> -    #[must_use =3D "cloning is often expensive and is not expected to =
have side effects"]
> -    fn to_owned(&self) -> Self::Owned;
> -
> -    /// Uses borrowed data to replace owned data, usually by cloning.
> -    ///
> -    /// This is borrow-generalized version of `Clone::clone_from`.
> -    ///
> -    /// # Examples
> -    ///
> -    /// Basic usage:
> -    ///
> -    /// ```
> -    /// # #![feature(toowned_clone_into)]
> -    /// let mut s: String =3D String::new();
> -    /// "hello".clone_into(&mut s);
> -    ///
> -    /// let mut v: Vec<i32> =3D Vec::new();
> -    /// [1, 2][..].clone_into(&mut v);
> -    /// ```
> -    #[unstable(feature =3D "toowned_clone_into", reason =3D "recently =
added", issue =3D "41263")]
> -    fn clone_into(&self, target: &mut Self::Owned) {
> -        *target =3D self.to_owned();
> -    }
> -}
> -
> -#[stable(feature =3D "rust1", since =3D "1.0.0")]
> -impl<T> ToOwned for T
> -where
> -    T: Clone,
> -{
> -    type Owned =3D T;
> -    fn to_owned(&self) -> T {
> -        self.clone()
> -    }
> -
> -    fn clone_into(&self, target: &mut T) {
> -        target.clone_from(self);
> -    }
> -}
> -
> -/// A clone-on-write smart pointer.
> -///
> -/// The type `Cow` is a smart pointer providing clone-on-write functio=
nality: it
> -/// can enclose and provide immutable access to borrowed data, and clo=
ne the
> -/// data lazily when mutation or ownership is required. The type is de=
signed to
> -/// work with general borrowed data via the `Borrow` trait.
> -///
> -/// `Cow` implements `Deref`, which means that you can call
> -/// non-mutating methods directly on the data it encloses. If mutation=

> -/// is desired, `to_mut` will obtain a mutable reference to an owned
> -/// value, cloning if necessary.
> -///
> -/// If you need reference-counting pointers, note that
> -/// [`Rc::make_mut`][crate::rc::Rc::make_mut] and
> -/// [`Arc::make_mut`][crate::sync::Arc::make_mut] can provide clone-on=
-write
> -/// functionality as well.
> -///
> -/// # Examples
> -///
> -/// ```
> -/// use std::borrow::Cow;
> -///
> -/// fn abs_all(input: &mut Cow<[i32]>) {
> -///     for i in 0..input.len() {
> -///         let v =3D input[i];
> -///         if v < 0 {
> -///             // Clones into a vector if not already owned.
> -///             input.to_mut()[i] =3D -v;
> -///         }
> -///     }
> -/// }
> -///
> -/// // No clone occurs because `input` doesn't need to be mutated.
> -/// let slice =3D [0, 1, 2];
> -/// let mut input =3D Cow::from(&slice[..]);
> -/// abs_all(&mut input);
> -///
> -/// // Clone occurs because `input` needs to be mutated.
> -/// let slice =3D [-1, 0, 1];
> -/// let mut input =3D Cow::from(&slice[..]);
> -/// abs_all(&mut input);
> -///
> -/// // No clone occurs because `input` is already owned.
> -/// let mut input =3D Cow::from(vec![-1, 0, 1]);
> -/// abs_all(&mut input);
> -/// ```
> -///
> -/// Another example showing how to keep `Cow` in a struct:
> -///
> -/// ```
> -/// use std::borrow::Cow;
> -///
> -/// struct Items<'a, X: 'a> where [X]: ToOwned<Owned =3D Vec<X>> {
> -///     values: Cow<'a, [X]>,
> -/// }
> -///
> -/// impl<'a, X: Clone + 'a> Items<'a, X> where [X]: ToOwned<Owned =3D =
Vec<X>> {
> -///     fn new(v: Cow<'a, [X]>) -> Self {
> -///         Items { values: v }
> -///     }
> -/// }
> -///
> -/// // Creates a container from borrowed values of a slice
> -/// let readonly =3D [1, 2];
> -/// let borrowed =3D Items::new((&readonly[..]).into());
> -/// match borrowed {
> -///     Items { values: Cow::Borrowed(b) } =3D> println!("borrowed {b:=
?}"),
> -///     _ =3D> panic!("expect borrowed value"),
> -/// }
> -///
> -/// let mut clone_on_write =3D borrowed;
> -/// // Mutates the data from slice into owned vec and pushes a new val=
ue on top
> -/// clone_on_write.values.to_mut().push(3);
> -/// println!("clone_on_write =3D {:?}", clone_on_write.values);
> -///
> -/// // The data was mutated. Let's check it out.
> -/// match clone_on_write {
> -///     Items { values: Cow::Owned(_) } =3D> println!("clone_on_write =
contains owned data"),
> -///     _ =3D> panic!("expect owned data"),
> -/// }
> -/// ```
> -#[stable(feature =3D "rust1", since =3D "1.0.0")]
> -#[cfg_attr(not(test), rustc_diagnostic_item =3D "Cow")]
> -pub enum Cow<'a, B: ?Sized + 'a>
> -where
> -    B: ToOwned,
> -{
> -    /// Borrowed data.
> -    #[stable(feature =3D "rust1", since =3D "1.0.0")]
> -    Borrowed(#[stable(feature =3D "rust1", since =3D "1.0.0")] &'a B),=

> -
> -    /// Owned data.
> -    #[stable(feature =3D "rust1", since =3D "1.0.0")]
> -    Owned(#[stable(feature =3D "rust1", since =3D "1.0.0")] <B as ToOw=
ned>::Owned),
> -}
> -
> -#[stable(feature =3D "rust1", since =3D "1.0.0")]
> -impl<B: ?Sized + ToOwned> Clone for Cow<'_, B> {
> -    fn clone(&self) -> Self {
> -        match *self {
> -            Borrowed(b) =3D> Borrowed(b),
> -            Owned(ref o) =3D> {
> -                let b: &B =3D o.borrow();
> -                Owned(b.to_owned())
> -            }
> -        }
> -    }
> -
> -    fn clone_from(&mut self, source: &Self) {
> -        match (self, source) {
> -            (&mut Owned(ref mut dest), &Owned(ref o)) =3D> o.borrow().=
clone_into(dest),
> -            (t, s) =3D> *t =3D s.clone(),
> -        }
> -    }
> -}
> -
> -impl<B: ?Sized + ToOwned> Cow<'_, B> {
> -    /// Returns true if the data is borrowed, i.e. if `to_mut` would r=
equire additional work.
> -    ///
> -    /// # Examples
> -    ///
> -    /// ```
> -    /// #![feature(cow_is_borrowed)]
> -    /// use std::borrow::Cow;
> -    ///
> -    /// let cow =3D Cow::Borrowed("moo");
> -    /// assert!(cow.is_borrowed());
> -    ///
> -    /// let bull: Cow<'_, str> =3D Cow::Owned("...moo?".to_string());
> -    /// assert!(!bull.is_borrowed());
> -    /// ```
> -    #[unstable(feature =3D "cow_is_borrowed", issue =3D "65143")]
> -    #[rustc_const_unstable(feature =3D "const_cow_is_borrowed", issue =
=3D "65143")]
> -    pub const fn is_borrowed(&self) -> bool {
> -        match *self {
> -            Borrowed(_) =3D> true,
> -            Owned(_) =3D> false,
> -        }
> -    }
> -
> -    /// Returns true if the data is owned, i.e. if `to_mut` would be a=
 no-op.
> -    ///
> -    /// # Examples
> -    ///
> -    /// ```
> -    /// #![feature(cow_is_borrowed)]
> -    /// use std::borrow::Cow;
> -    ///
> -    /// let cow: Cow<'_, str> =3D Cow::Owned("moo".to_string());
> -    /// assert!(cow.is_owned());
> -    ///
> -    /// let bull =3D Cow::Borrowed("...moo?");
> -    /// assert!(!bull.is_owned());
> -    /// ```
> -    #[unstable(feature =3D "cow_is_borrowed", issue =3D "65143")]
> -    #[rustc_const_unstable(feature =3D "const_cow_is_borrowed", issue =
=3D "65143")]
> -    pub const fn is_owned(&self) -> bool {
> -        !self.is_borrowed()
> -    }
> -
> -    /// Acquires a mutable reference to the owned form of the data.
> -    ///
> -    /// Clones the data if it is not already owned.
> -    ///
> -    /// # Examples
> -    ///
> -    /// ```
> -    /// use std::borrow::Cow;
> -    ///
> -    /// let mut cow =3D Cow::Borrowed("foo");
> -    /// cow.to_mut().make_ascii_uppercase();
> -    ///
> -    /// assert_eq!(
> -    ///   cow,
> -    ///   Cow::Owned(String::from("FOO")) as Cow<str>
> -    /// );
> -    /// ```
> -    #[stable(feature =3D "rust1", since =3D "1.0.0")]
> -    pub fn to_mut(&mut self) -> &mut <B as ToOwned>::Owned {
> -        match *self {
> -            Borrowed(borrowed) =3D> {
> -                *self =3D Owned(borrowed.to_owned());
> -                match *self {
> -                    Borrowed(..) =3D> unreachable!(),
> -                    Owned(ref mut owned) =3D> owned,
> -                }
> -            }
> -            Owned(ref mut owned) =3D> owned,
> -        }
> -    }
> -
> -    /// Extracts the owned data.
> -    ///
> -    /// Clones the data if it is not already owned.
> -    ///
> -    /// # Examples
> -    ///
> -    /// Calling `into_owned` on a `Cow::Borrowed` returns a clone of t=
he borrowed data:
> -    ///
> -    /// ```
> -    /// use std::borrow::Cow;
> -    ///
> -    /// let s =3D "Hello world!";
> -    /// let cow =3D Cow::Borrowed(s);
> -    ///
> -    /// assert_eq!(
> -    ///   cow.into_owned(),
> -    ///   String::from(s)
> -    /// );
> -    /// ```
> -    ///
> -    /// Calling `into_owned` on a `Cow::Owned` returns the owned data.=
 The data is moved out of the
> -    /// `Cow` without being cloned.
> -    ///
> -    /// ```
> -    /// use std::borrow::Cow;
> -    ///
> -    /// let s =3D "Hello world!";
> -    /// let cow: Cow<str> =3D Cow::Owned(String::from(s));
> -    ///
> -    /// assert_eq!(
> -    ///   cow.into_owned(),
> -    ///   String::from(s)
> -    /// );
> -    /// ```
> -    #[stable(feature =3D "rust1", since =3D "1.0.0")]
> -    pub fn into_owned(self) -> <B as ToOwned>::Owned {
> -        match self {
> -            Borrowed(borrowed) =3D> borrowed.to_owned(),
> -            Owned(owned) =3D> owned,
> -        }
> -    }
> -}
> -
> -#[stable(feature =3D "rust1", since =3D "1.0.0")]
> -#[rustc_const_unstable(feature =3D "const_deref", issue =3D "88955")]
> -impl<B: ?Sized + ToOwned> const Deref for Cow<'_, B>
> -where
> -    B::Owned: ~const Borrow<B>,
> -{
> -    type Target =3D B;
> -
> -    fn deref(&self) -> &B {
> -        match *self {
> -            Borrowed(borrowed) =3D> borrowed,
> -            Owned(ref owned) =3D> owned.borrow(),
> -        }
> -    }
> -}
> -
> -#[stable(feature =3D "rust1", since =3D "1.0.0")]
> -impl<B: ?Sized> Eq for Cow<'_, B> where B: Eq + ToOwned {}
> -
> -#[stable(feature =3D "rust1", since =3D "1.0.0")]
> -impl<B: ?Sized> Ord for Cow<'_, B>
> -where
> -    B: Ord + ToOwned,
> -{
> -    #[inline]
> -    fn cmp(&self, other: &Self) -> Ordering {
> -        Ord::cmp(&**self, &**other)
> -    }
> -}
> -
> -#[stable(feature =3D "rust1", since =3D "1.0.0")]
> -impl<'a, 'b, B: ?Sized, C: ?Sized> PartialEq<Cow<'b, C>> for Cow<'a, B=
>
> -where
> -    B: PartialEq<C> + ToOwned,
> -    C: ToOwned,
> -{
> -    #[inline]
> -    fn eq(&self, other: &Cow<'b, C>) -> bool {
> -        PartialEq::eq(&**self, &**other)
> -    }
> -}
> -
> -#[stable(feature =3D "rust1", since =3D "1.0.0")]
> -impl<'a, B: ?Sized> PartialOrd for Cow<'a, B>
> -where
> -    B: PartialOrd + ToOwned,
> -{
> -    #[inline]
> -    fn partial_cmp(&self, other: &Cow<'a, B>) -> Option<Ordering> {
> -        PartialOrd::partial_cmp(&**self, &**other)
> -    }
> -}
> -
> -#[stable(feature =3D "rust1", since =3D "1.0.0")]
> -impl<B: ?Sized> fmt::Debug for Cow<'_, B>
> -where
> -    B: fmt::Debug + ToOwned<Owned: fmt::Debug>,
> -{
> -    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> -        match *self {
> -            Borrowed(ref b) =3D> fmt::Debug::fmt(b, f),
> -            Owned(ref o) =3D> fmt::Debug::fmt(o, f),
> -        }
> -    }
> -}
> -
> -#[stable(feature =3D "rust1", since =3D "1.0.0")]
> -impl<B: ?Sized> fmt::Display for Cow<'_, B>
> -where
> -    B: fmt::Display + ToOwned<Owned: fmt::Display>,
> -{
> -    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> -        match *self {
> -            Borrowed(ref b) =3D> fmt::Display::fmt(b, f),
> -            Owned(ref o) =3D> fmt::Display::fmt(o, f),
> -        }
> -    }
> -}
> -
> -#[stable(feature =3D "default", since =3D "1.11.0")]
> -impl<B: ?Sized> Default for Cow<'_, B>
> -where
> -    B: ToOwned<Owned: Default>,
> -{
> -    /// Creates an owned Cow<'a, B> with the default value for the con=
tained owned value.
> -    fn default() -> Self {
> -        Owned(<B as ToOwned>::Owned::default())
> -    }
> -}
> -
> -#[stable(feature =3D "rust1", since =3D "1.0.0")]
> -impl<B: ?Sized> Hash for Cow<'_, B>
> -where
> -    B: Hash + ToOwned,
> -{
> -    #[inline]
> -    fn hash<H: Hasher>(&self, state: &mut H) {
> -        Hash::hash(&**self, state)
> -    }
> -}
> -
> -#[stable(feature =3D "rust1", since =3D "1.0.0")]
> -impl<T: ?Sized + ToOwned> AsRef<T> for Cow<'_, T> {
> -    fn as_ref(&self) -> &T {
> -        self
> -    }
> -}
> -
> -#[cfg(not(no_global_oom_handling))]
> -#[stable(feature =3D "cow_add", since =3D "1.14.0")]
> -impl<'a> Add<&'a str> for Cow<'a, str> {
> -    type Output =3D Cow<'a, str>;
> -
> -    #[inline]
> -    fn add(mut self, rhs: &'a str) -> Self::Output {
> -        self +=3D rhs;
> -        self
> -    }
> -}
> -
> -#[cfg(not(no_global_oom_handling))]
> -#[stable(feature =3D "cow_add", since =3D "1.14.0")]
> -impl<'a> Add<Cow<'a, str>> for Cow<'a, str> {
> -    type Output =3D Cow<'a, str>;
> -
> -    #[inline]
> -    fn add(mut self, rhs: Cow<'a, str>) -> Self::Output {
> -        self +=3D rhs;
> -        self
> -    }
> -}
> -
> -#[cfg(not(no_global_oom_handling))]
> -#[stable(feature =3D "cow_add", since =3D "1.14.0")]
> -impl<'a> AddAssign<&'a str> for Cow<'a, str> {
> -    fn add_assign(&mut self, rhs: &'a str) {
> -        if self.is_empty() {
> -            *self =3D Cow::Borrowed(rhs)
> -        } else if !rhs.is_empty() {
> -            if let Cow::Borrowed(lhs) =3D *self {
> -                let mut s =3D String::with_capacity(lhs.len() + rhs.le=
n());
> -                s.push_str(lhs);
> -                *self =3D Cow::Owned(s);
> -            }
> -            self.to_mut().push_str(rhs);
> -        }
> -    }
> -}
> -
> -#[cfg(not(no_global_oom_handling))]
> -#[stable(feature =3D "cow_add", since =3D "1.14.0")]
> -impl<'a> AddAssign<Cow<'a, str>> for Cow<'a, str> {
> -    fn add_assign(&mut self, rhs: Cow<'a, str>) {
> -        if self.is_empty() {
> -            *self =3D rhs
> -        } else if !rhs.is_empty() {
> -            if let Cow::Borrowed(lhs) =3D *self {
> -                let mut s =3D String::with_capacity(lhs.len() + rhs.le=
n());
> -                s.push_str(lhs);
> -                *self =3D Cow::Owned(s);
> -            }
> -            self.to_mut().push_str(&rhs);
> -        }
> -    }
> -}
> diff --git a/rust/alloc/lib.rs b/rust/alloc/lib.rs
> index 233bcd5e4654..3aebf83c9967 100644
> --- a/rust/alloc/lib.rs
> +++ b/rust/alloc/lib.rs
> @@ -100,7 +100,7 @@
>  #![cfg_attr(not(no_global_oom_handling), feature(const_alloc_error))]
>  #![feature(const_box)]
>  #![cfg_attr(not(no_global_oom_handling), feature(const_btree_new))]
> -#![feature(const_cow_is_borrowed)]
> +#![cfg_attr(not(no_borrow), feature(const_cow_is_borrowed))]
>  #![feature(const_convert)]
>  #![feature(const_size_of_val)]
>  #![feature(const_align_of_val)]
> @@ -215,6 +215,7 @@ pub mod boxed;
>  mod boxed {
>      pub use std::boxed::Box;
>  }
> +#[cfg(not(no_borrow))]
>  pub mod borrow;
>  pub mod collections;
>  #[cfg(not(no_global_oom_handling))]
> diff --git a/rust/alloc/vec/mod.rs b/rust/alloc/vec/mod.rs
> index 540787804cc2..ae0085e1231f 100644
> --- a/rust/alloc/vec/mod.rs
> +++ b/rust/alloc/vec/mod.rs
> @@ -72,6 +72,7 @@ use core::ptr::{self, NonNull};
>  use core::slice::{self, SliceIndex};
>
>  use crate::alloc::{Allocator, Global};
> +#[cfg(not(no_borrow))]
>  use crate::borrow::{Cow, ToOwned};
>  use crate::boxed::Box;
>  use crate::collections::TryReserveError;
> @@ -94,6 +95,7 @@ pub use self::drain::Drain;
>
>  mod drain;
>
> +#[cfg(not(no_borrow))]
>  #[cfg(not(no_global_oom_handling))]
>  mod cow;
>
> @@ -3014,6 +3016,7 @@ impl<T, const N: usize> From<[T; N]> for Vec<T> {=

>      }
>  }
>
> +#[cfg(not(no_borrow))]
>  #[stable(feature =3D "vec_from_cow_slice", since =3D "1.14.0")]
>  impl<'a, T> From<Cow<'a, [T]>> for Vec<T>
>  where
>
> base-commit: 76dcd734eca23168cb008912c0f69ff408905235
> -- =

> 2.38.1
