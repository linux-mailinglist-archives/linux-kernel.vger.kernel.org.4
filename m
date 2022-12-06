Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12E1643A80
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 02:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiLFBFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 20:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiLFBFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 20:05:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E9DB7ED;
        Mon,  5 Dec 2022 17:05:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ED85614DE;
        Tue,  6 Dec 2022 01:05:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841A0C433C1;
        Tue,  6 Dec 2022 01:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670288748;
        bh=UTfAIAX1EY1vET9A6esUIInfSVhtd5EuneV1EFr6AOY=;
        h=From:To:Cc:Subject:Date:From;
        b=N5CA0rePMehuF5SNjKXtXC4no8g/uVf7rhoygQXeQyM9f2MeWL+aPbdgSyX/V+EZm
         +44+ucSkKKr8IfaNHu7vk2e0GP+vXiz1sy5hrmwlof8xGQ+pshVW6ju0limvNio2zv
         EVCEzCc4AjUhiCOp18vtSbpbevLZF8DkL/63jo5/tNqCNwBznrt+nKcxxgZzsniZtN
         Q0Pozsgbh25o0dzOVyIsWZ+UB2VvLWR7iPo8PUCr7YjGP2w61cu0pRX/VZbAcqRK+6
         FL7a/otI+jXluUSKsWJhZJ3ulROp5NBWHqTvjLYjUt1VQB7nYbP3louNgW82CZyFNb
         Q+CcrpLBcS1CQ==
From:   ojeda@kernel.org
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH v1] rust: alloc: remove the `borrow` module (`ToOwned`, `Cow`)
Date:   Tue,  6 Dec 2022 02:05:19 +0100
Message-Id: <20221206010519.39075-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miguel Ojeda <ojeda@kernel.org>

The `Cow` type [1] requires that its generic parameter type implements
the `ToOwned` trait [2], which provides a method to create owned data
from borrowed data, usually by cloning.

However, it is infallible, and thus in most cases it is not useful for
the kernel. [3]

Therefore, introduce `cfg(no_borrow)` to remove the `borrow` module
(which contains `ToOwned` and `Cow`) from `alloc`.

Link: https://doc.rust-lang.org/alloc/borrow/enum.Cow.html [1]
Link: https://doc.rust-lang.org/alloc/borrow/trait.ToOwned.html [2]
Link: https://lore.kernel.org/rust-for-linux/20221204103153.117675b1@GaryWorkstation/ [3]
Cc: Gary Guo <gary@garyguo.net>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/Makefile         |   1 +
 rust/alloc/borrow.rs  | 498 ------------------------------------------
 rust/alloc/lib.rs     |   3 +-
 rust/alloc/vec/mod.rs |   3 +
 4 files changed, 6 insertions(+), 499 deletions(-)
 delete mode 100644 rust/alloc/borrow.rs

diff --git a/rust/Makefile b/rust/Makefile
index 7700d3853404..208b520fcbea 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -44,6 +44,7 @@ core-cfgs = \
     --cfg no_fp_fmt_parse
 
 alloc-cfgs = \
+    --cfg no_borrow \
     --cfg no_fmt \
     --cfg no_global_oom_handling \
     --cfg no_macros \
diff --git a/rust/alloc/borrow.rs b/rust/alloc/borrow.rs
deleted file mode 100644
index dde4957200d4..000000000000
--- a/rust/alloc/borrow.rs
+++ /dev/null
@@ -1,498 +0,0 @@
-// SPDX-License-Identifier: Apache-2.0 OR MIT
-
-//! A module for working with borrowed data.
-
-#![stable(feature = "rust1", since = "1.0.0")]
-
-use core::cmp::Ordering;
-use core::hash::{Hash, Hasher};
-use core::ops::Deref;
-#[cfg(not(no_global_oom_handling))]
-use core::ops::{Add, AddAssign};
-
-#[stable(feature = "rust1", since = "1.0.0")]
-pub use core::borrow::{Borrow, BorrowMut};
-
-use core::fmt;
-#[cfg(not(no_global_oom_handling))]
-use crate::string::String;
-
-use Cow::*;
-
-#[stable(feature = "rust1", since = "1.0.0")]
-impl<'a, B: ?Sized> Borrow<B> for Cow<'a, B>
-where
-    B: ToOwned,
-    <B as ToOwned>::Owned: 'a,
-{
-    fn borrow(&self) -> &B {
-        &**self
-    }
-}
-
-/// A generalization of `Clone` to borrowed data.
-///
-/// Some types make it possible to go from borrowed to owned, usually by
-/// implementing the `Clone` trait. But `Clone` works only for going from `&T`
-/// to `T`. The `ToOwned` trait generalizes `Clone` to construct owned data
-/// from any borrow of a given type.
-#[cfg_attr(not(test), rustc_diagnostic_item = "ToOwned")]
-#[stable(feature = "rust1", since = "1.0.0")]
-pub trait ToOwned {
-    /// The resulting type after obtaining ownership.
-    #[stable(feature = "rust1", since = "1.0.0")]
-    type Owned: Borrow<Self>;
-
-    /// Creates owned data from borrowed data, usually by cloning.
-    ///
-    /// # Examples
-    ///
-    /// Basic usage:
-    ///
-    /// ```
-    /// let s: &str = "a";
-    /// let ss: String = s.to_owned();
-    ///
-    /// let v: &[i32] = &[1, 2];
-    /// let vv: Vec<i32> = v.to_owned();
-    /// ```
-    #[stable(feature = "rust1", since = "1.0.0")]
-    #[must_use = "cloning is often expensive and is not expected to have side effects"]
-    fn to_owned(&self) -> Self::Owned;
-
-    /// Uses borrowed data to replace owned data, usually by cloning.
-    ///
-    /// This is borrow-generalized version of `Clone::clone_from`.
-    ///
-    /// # Examples
-    ///
-    /// Basic usage:
-    ///
-    /// ```
-    /// # #![feature(toowned_clone_into)]
-    /// let mut s: String = String::new();
-    /// "hello".clone_into(&mut s);
-    ///
-    /// let mut v: Vec<i32> = Vec::new();
-    /// [1, 2][..].clone_into(&mut v);
-    /// ```
-    #[unstable(feature = "toowned_clone_into", reason = "recently added", issue = "41263")]
-    fn clone_into(&self, target: &mut Self::Owned) {
-        *target = self.to_owned();
-    }
-}
-
-#[stable(feature = "rust1", since = "1.0.0")]
-impl<T> ToOwned for T
-where
-    T: Clone,
-{
-    type Owned = T;
-    fn to_owned(&self) -> T {
-        self.clone()
-    }
-
-    fn clone_into(&self, target: &mut T) {
-        target.clone_from(self);
-    }
-}
-
-/// A clone-on-write smart pointer.
-///
-/// The type `Cow` is a smart pointer providing clone-on-write functionality: it
-/// can enclose and provide immutable access to borrowed data, and clone the
-/// data lazily when mutation or ownership is required. The type is designed to
-/// work with general borrowed data via the `Borrow` trait.
-///
-/// `Cow` implements `Deref`, which means that you can call
-/// non-mutating methods directly on the data it encloses. If mutation
-/// is desired, `to_mut` will obtain a mutable reference to an owned
-/// value, cloning if necessary.
-///
-/// If you need reference-counting pointers, note that
-/// [`Rc::make_mut`][crate::rc::Rc::make_mut] and
-/// [`Arc::make_mut`][crate::sync::Arc::make_mut] can provide clone-on-write
-/// functionality as well.
-///
-/// # Examples
-///
-/// ```
-/// use std::borrow::Cow;
-///
-/// fn abs_all(input: &mut Cow<[i32]>) {
-///     for i in 0..input.len() {
-///         let v = input[i];
-///         if v < 0 {
-///             // Clones into a vector if not already owned.
-///             input.to_mut()[i] = -v;
-///         }
-///     }
-/// }
-///
-/// // No clone occurs because `input` doesn't need to be mutated.
-/// let slice = [0, 1, 2];
-/// let mut input = Cow::from(&slice[..]);
-/// abs_all(&mut input);
-///
-/// // Clone occurs because `input` needs to be mutated.
-/// let slice = [-1, 0, 1];
-/// let mut input = Cow::from(&slice[..]);
-/// abs_all(&mut input);
-///
-/// // No clone occurs because `input` is already owned.
-/// let mut input = Cow::from(vec![-1, 0, 1]);
-/// abs_all(&mut input);
-/// ```
-///
-/// Another example showing how to keep `Cow` in a struct:
-///
-/// ```
-/// use std::borrow::Cow;
-///
-/// struct Items<'a, X: 'a> where [X]: ToOwned<Owned = Vec<X>> {
-///     values: Cow<'a, [X]>,
-/// }
-///
-/// impl<'a, X: Clone + 'a> Items<'a, X> where [X]: ToOwned<Owned = Vec<X>> {
-///     fn new(v: Cow<'a, [X]>) -> Self {
-///         Items { values: v }
-///     }
-/// }
-///
-/// // Creates a container from borrowed values of a slice
-/// let readonly = [1, 2];
-/// let borrowed = Items::new((&readonly[..]).into());
-/// match borrowed {
-///     Items { values: Cow::Borrowed(b) } => println!("borrowed {b:?}"),
-///     _ => panic!("expect borrowed value"),
-/// }
-///
-/// let mut clone_on_write = borrowed;
-/// // Mutates the data from slice into owned vec and pushes a new value on top
-/// clone_on_write.values.to_mut().push(3);
-/// println!("clone_on_write = {:?}", clone_on_write.values);
-///
-/// // The data was mutated. Let's check it out.
-/// match clone_on_write {
-///     Items { values: Cow::Owned(_) } => println!("clone_on_write contains owned data"),
-///     _ => panic!("expect owned data"),
-/// }
-/// ```
-#[stable(feature = "rust1", since = "1.0.0")]
-#[cfg_attr(not(test), rustc_diagnostic_item = "Cow")]
-pub enum Cow<'a, B: ?Sized + 'a>
-where
-    B: ToOwned,
-{
-    /// Borrowed data.
-    #[stable(feature = "rust1", since = "1.0.0")]
-    Borrowed(#[stable(feature = "rust1", since = "1.0.0")] &'a B),
-
-    /// Owned data.
-    #[stable(feature = "rust1", since = "1.0.0")]
-    Owned(#[stable(feature = "rust1", since = "1.0.0")] <B as ToOwned>::Owned),
-}
-
-#[stable(feature = "rust1", since = "1.0.0")]
-impl<B: ?Sized + ToOwned> Clone for Cow<'_, B> {
-    fn clone(&self) -> Self {
-        match *self {
-            Borrowed(b) => Borrowed(b),
-            Owned(ref o) => {
-                let b: &B = o.borrow();
-                Owned(b.to_owned())
-            }
-        }
-    }
-
-    fn clone_from(&mut self, source: &Self) {
-        match (self, source) {
-            (&mut Owned(ref mut dest), &Owned(ref o)) => o.borrow().clone_into(dest),
-            (t, s) => *t = s.clone(),
-        }
-    }
-}
-
-impl<B: ?Sized + ToOwned> Cow<'_, B> {
-    /// Returns true if the data is borrowed, i.e. if `to_mut` would require additional work.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// #![feature(cow_is_borrowed)]
-    /// use std::borrow::Cow;
-    ///
-    /// let cow = Cow::Borrowed("moo");
-    /// assert!(cow.is_borrowed());
-    ///
-    /// let bull: Cow<'_, str> = Cow::Owned("...moo?".to_string());
-    /// assert!(!bull.is_borrowed());
-    /// ```
-    #[unstable(feature = "cow_is_borrowed", issue = "65143")]
-    #[rustc_const_unstable(feature = "const_cow_is_borrowed", issue = "65143")]
-    pub const fn is_borrowed(&self) -> bool {
-        match *self {
-            Borrowed(_) => true,
-            Owned(_) => false,
-        }
-    }
-
-    /// Returns true if the data is owned, i.e. if `to_mut` would be a no-op.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// #![feature(cow_is_borrowed)]
-    /// use std::borrow::Cow;
-    ///
-    /// let cow: Cow<'_, str> = Cow::Owned("moo".to_string());
-    /// assert!(cow.is_owned());
-    ///
-    /// let bull = Cow::Borrowed("...moo?");
-    /// assert!(!bull.is_owned());
-    /// ```
-    #[unstable(feature = "cow_is_borrowed", issue = "65143")]
-    #[rustc_const_unstable(feature = "const_cow_is_borrowed", issue = "65143")]
-    pub const fn is_owned(&self) -> bool {
-        !self.is_borrowed()
-    }
-
-    /// Acquires a mutable reference to the owned form of the data.
-    ///
-    /// Clones the data if it is not already owned.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// use std::borrow::Cow;
-    ///
-    /// let mut cow = Cow::Borrowed("foo");
-    /// cow.to_mut().make_ascii_uppercase();
-    ///
-    /// assert_eq!(
-    ///   cow,
-    ///   Cow::Owned(String::from("FOO")) as Cow<str>
-    /// );
-    /// ```
-    #[stable(feature = "rust1", since = "1.0.0")]
-    pub fn to_mut(&mut self) -> &mut <B as ToOwned>::Owned {
-        match *self {
-            Borrowed(borrowed) => {
-                *self = Owned(borrowed.to_owned());
-                match *self {
-                    Borrowed(..) => unreachable!(),
-                    Owned(ref mut owned) => owned,
-                }
-            }
-            Owned(ref mut owned) => owned,
-        }
-    }
-
-    /// Extracts the owned data.
-    ///
-    /// Clones the data if it is not already owned.
-    ///
-    /// # Examples
-    ///
-    /// Calling `into_owned` on a `Cow::Borrowed` returns a clone of the borrowed data:
-    ///
-    /// ```
-    /// use std::borrow::Cow;
-    ///
-    /// let s = "Hello world!";
-    /// let cow = Cow::Borrowed(s);
-    ///
-    /// assert_eq!(
-    ///   cow.into_owned(),
-    ///   String::from(s)
-    /// );
-    /// ```
-    ///
-    /// Calling `into_owned` on a `Cow::Owned` returns the owned data. The data is moved out of the
-    /// `Cow` without being cloned.
-    ///
-    /// ```
-    /// use std::borrow::Cow;
-    ///
-    /// let s = "Hello world!";
-    /// let cow: Cow<str> = Cow::Owned(String::from(s));
-    ///
-    /// assert_eq!(
-    ///   cow.into_owned(),
-    ///   String::from(s)
-    /// );
-    /// ```
-    #[stable(feature = "rust1", since = "1.0.0")]
-    pub fn into_owned(self) -> <B as ToOwned>::Owned {
-        match self {
-            Borrowed(borrowed) => borrowed.to_owned(),
-            Owned(owned) => owned,
-        }
-    }
-}
-
-#[stable(feature = "rust1", since = "1.0.0")]
-#[rustc_const_unstable(feature = "const_deref", issue = "88955")]
-impl<B: ?Sized + ToOwned> const Deref for Cow<'_, B>
-where
-    B::Owned: ~const Borrow<B>,
-{
-    type Target = B;
-
-    fn deref(&self) -> &B {
-        match *self {
-            Borrowed(borrowed) => borrowed,
-            Owned(ref owned) => owned.borrow(),
-        }
-    }
-}
-
-#[stable(feature = "rust1", since = "1.0.0")]
-impl<B: ?Sized> Eq for Cow<'_, B> where B: Eq + ToOwned {}
-
-#[stable(feature = "rust1", since = "1.0.0")]
-impl<B: ?Sized> Ord for Cow<'_, B>
-where
-    B: Ord + ToOwned,
-{
-    #[inline]
-    fn cmp(&self, other: &Self) -> Ordering {
-        Ord::cmp(&**self, &**other)
-    }
-}
-
-#[stable(feature = "rust1", since = "1.0.0")]
-impl<'a, 'b, B: ?Sized, C: ?Sized> PartialEq<Cow<'b, C>> for Cow<'a, B>
-where
-    B: PartialEq<C> + ToOwned,
-    C: ToOwned,
-{
-    #[inline]
-    fn eq(&self, other: &Cow<'b, C>) -> bool {
-        PartialEq::eq(&**self, &**other)
-    }
-}
-
-#[stable(feature = "rust1", since = "1.0.0")]
-impl<'a, B: ?Sized> PartialOrd for Cow<'a, B>
-where
-    B: PartialOrd + ToOwned,
-{
-    #[inline]
-    fn partial_cmp(&self, other: &Cow<'a, B>) -> Option<Ordering> {
-        PartialOrd::partial_cmp(&**self, &**other)
-    }
-}
-
-#[stable(feature = "rust1", since = "1.0.0")]
-impl<B: ?Sized> fmt::Debug for Cow<'_, B>
-where
-    B: fmt::Debug + ToOwned<Owned: fmt::Debug>,
-{
-    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
-        match *self {
-            Borrowed(ref b) => fmt::Debug::fmt(b, f),
-            Owned(ref o) => fmt::Debug::fmt(o, f),
-        }
-    }
-}
-
-#[stable(feature = "rust1", since = "1.0.0")]
-impl<B: ?Sized> fmt::Display for Cow<'_, B>
-where
-    B: fmt::Display + ToOwned<Owned: fmt::Display>,
-{
-    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
-        match *self {
-            Borrowed(ref b) => fmt::Display::fmt(b, f),
-            Owned(ref o) => fmt::Display::fmt(o, f),
-        }
-    }
-}
-
-#[stable(feature = "default", since = "1.11.0")]
-impl<B: ?Sized> Default for Cow<'_, B>
-where
-    B: ToOwned<Owned: Default>,
-{
-    /// Creates an owned Cow<'a, B> with the default value for the contained owned value.
-    fn default() -> Self {
-        Owned(<B as ToOwned>::Owned::default())
-    }
-}
-
-#[stable(feature = "rust1", since = "1.0.0")]
-impl<B: ?Sized> Hash for Cow<'_, B>
-where
-    B: Hash + ToOwned,
-{
-    #[inline]
-    fn hash<H: Hasher>(&self, state: &mut H) {
-        Hash::hash(&**self, state)
-    }
-}
-
-#[stable(feature = "rust1", since = "1.0.0")]
-impl<T: ?Sized + ToOwned> AsRef<T> for Cow<'_, T> {
-    fn as_ref(&self) -> &T {
-        self
-    }
-}
-
-#[cfg(not(no_global_oom_handling))]
-#[stable(feature = "cow_add", since = "1.14.0")]
-impl<'a> Add<&'a str> for Cow<'a, str> {
-    type Output = Cow<'a, str>;
-
-    #[inline]
-    fn add(mut self, rhs: &'a str) -> Self::Output {
-        self += rhs;
-        self
-    }
-}
-
-#[cfg(not(no_global_oom_handling))]
-#[stable(feature = "cow_add", since = "1.14.0")]
-impl<'a> Add<Cow<'a, str>> for Cow<'a, str> {
-    type Output = Cow<'a, str>;
-
-    #[inline]
-    fn add(mut self, rhs: Cow<'a, str>) -> Self::Output {
-        self += rhs;
-        self
-    }
-}
-
-#[cfg(not(no_global_oom_handling))]
-#[stable(feature = "cow_add", since = "1.14.0")]
-impl<'a> AddAssign<&'a str> for Cow<'a, str> {
-    fn add_assign(&mut self, rhs: &'a str) {
-        if self.is_empty() {
-            *self = Cow::Borrowed(rhs)
-        } else if !rhs.is_empty() {
-            if let Cow::Borrowed(lhs) = *self {
-                let mut s = String::with_capacity(lhs.len() + rhs.len());
-                s.push_str(lhs);
-                *self = Cow::Owned(s);
-            }
-            self.to_mut().push_str(rhs);
-        }
-    }
-}
-
-#[cfg(not(no_global_oom_handling))]
-#[stable(feature = "cow_add", since = "1.14.0")]
-impl<'a> AddAssign<Cow<'a, str>> for Cow<'a, str> {
-    fn add_assign(&mut self, rhs: Cow<'a, str>) {
-        if self.is_empty() {
-            *self = rhs
-        } else if !rhs.is_empty() {
-            if let Cow::Borrowed(lhs) = *self {
-                let mut s = String::with_capacity(lhs.len() + rhs.len());
-                s.push_str(lhs);
-                *self = Cow::Owned(s);
-            }
-            self.to_mut().push_str(&rhs);
-        }
-    }
-}
diff --git a/rust/alloc/lib.rs b/rust/alloc/lib.rs
index 233bcd5e4654..3aebf83c9967 100644
--- a/rust/alloc/lib.rs
+++ b/rust/alloc/lib.rs
@@ -100,7 +100,7 @@
 #![cfg_attr(not(no_global_oom_handling), feature(const_alloc_error))]
 #![feature(const_box)]
 #![cfg_attr(not(no_global_oom_handling), feature(const_btree_new))]
-#![feature(const_cow_is_borrowed)]
+#![cfg_attr(not(no_borrow), feature(const_cow_is_borrowed))]
 #![feature(const_convert)]
 #![feature(const_size_of_val)]
 #![feature(const_align_of_val)]
@@ -215,6 +215,7 @@ pub mod boxed;
 mod boxed {
     pub use std::boxed::Box;
 }
+#[cfg(not(no_borrow))]
 pub mod borrow;
 pub mod collections;
 #[cfg(not(no_global_oom_handling))]
diff --git a/rust/alloc/vec/mod.rs b/rust/alloc/vec/mod.rs
index 540787804cc2..ae0085e1231f 100644
--- a/rust/alloc/vec/mod.rs
+++ b/rust/alloc/vec/mod.rs
@@ -72,6 +72,7 @@ use core::ptr::{self, NonNull};
 use core::slice::{self, SliceIndex};
 
 use crate::alloc::{Allocator, Global};
+#[cfg(not(no_borrow))]
 use crate::borrow::{Cow, ToOwned};
 use crate::boxed::Box;
 use crate::collections::TryReserveError;
@@ -94,6 +95,7 @@ pub use self::drain::Drain;
 
 mod drain;
 
+#[cfg(not(no_borrow))]
 #[cfg(not(no_global_oom_handling))]
 mod cow;
 
@@ -3014,6 +3016,7 @@ impl<T, const N: usize> From<[T; N]> for Vec<T> {
     }
 }
 
+#[cfg(not(no_borrow))]
 #[stable(feature = "vec_from_cow_slice", since = "1.14.0")]
 impl<'a, T> From<Cow<'a, [T]>> for Vec<T>
 where

base-commit: 76dcd734eca23168cb008912c0f69ff408905235
-- 
2.38.1

