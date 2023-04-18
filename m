Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F466E6E7D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjDRVo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbjDRVos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:44:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA765A5F7;
        Tue, 18 Apr 2023 14:44:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1239C63962;
        Tue, 18 Apr 2023 21:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101CDC4339B;
        Tue, 18 Apr 2023 21:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681854279;
        bh=7St2QdvRUg0DG008yoaYFHQHU6KdAVssVB08KAUqID8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I7xWfIUvAb00Iz7FLW0EFeZgmrIrIbCXKTwuEyI44tFdoJ/ETu1mOAaUMdmVuQN3s
         BXCJ0uLQxRGgw1hQK+NXXFuVkIXUAo96fzOj/vazGfqXUOzKE0FwA6bUBB8Q4FJ2rH
         HpeCqvPVEqh6fepGLcxx6prrnEVVOwLMQnO/21oFOse9Hd6xvq8/6ltiBEycr7J6b3
         /FdKAzYGFJJwWvquT3wO97FIc2jd+qnLS9Lazj0osaZWHWYEtKUvYxnhrB6QvOGMhD
         OPxYNAUsOSXO6ZXLFwo9XD386W43G2pLiLF5Y8Mam08o4LF5JVQA6yqCnhKXZWh9Vc
         VnEusXPRkQ33Q==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Josh Stone <jistone@redhat.com>,
        William Brown <william.brown@suse.com>,
        Georgy Yakovlev <gyakovlev@gentoo.org>,
        Jan Alexander Steffens <jan.steffens@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH 3/3] rust: upgrade to Rust 1.68.2
Date:   Tue, 18 Apr 2023 23:43:47 +0200
Message-Id: <20230418214347.324156-4-ojeda@kernel.org>
In-Reply-To: <20230418214347.324156-1-ojeda@kernel.org>
References: <20230418214347.324156-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first upgrade to the Rust toolchain since the initial Rust
merge, from 1.62.0 to 1.68.2 (i.e. the latest).

# Context

The kernel currently supports only a single Rust version [1] (rather
than a minimum) given our usage of some "unstable" Rust features [2]
which do not promise backwards compatibility.

The goal is to reach a point where we can declare a minimum version for
the toolchain. For instance, by waiting for some of the features to be
stabilized. Therefore, the first minimum Rust version that the kernel
will support is "in the future".

# Upgrade policy

Given we will eventually need to reach that minimum version, it would be
ideal to upgrade the compiler from time to time to be as close as
possible to that goal and find any issues sooner. In the extreme, we
could upgrade as soon as a new Rust release is out. Of course, upgrading
so often is in stark contrast to what one normally would need for GCC
and LLVM, especially given the release schedule: 6 weeks for Rust vs.
half a year for LLVM and a year for GCC.

Having said that, there is no particular advantage to updating slowly
either: kernel developers in "stable" distributions are unlikely to be
able to use their distribution-provided Rust toolchain for the kernel
anyway [3]. Instead, by routinely upgrading to the latest instead,
kernel developers using Linux distributions that track the latest Rust
release may be able to use those rather than Rust-provided ones,
especially if their package manager allows to pin / hold back /
downgrade the version for some days during windows where the version may
not match. For instance, Arch, Fedora, Gentoo and openSUSE all provide
and track the latest version of Rust as they get released every 6 weeks.

Then, when the minimum version is reached, we will stop upgrading and
decide how wide the window of support will be. For instance, a year of
Rust versions. We will probably want to start small, and then widen it
over time, just like the kernel did originally for LLVM, see commit
3519c4d6e08e ("Documentation: add minimum clang/llvm version").

# Unstable features stabilized

This upgrade allows us to remove the following unstable features since
they were stabilized:

  - `feature(explicit_generic_args_with_impl_trait)` (1.63).
  - `feature(core_ffi_c)` (1.64).
  - `feature(generic_associated_types)` (1.65).
  - `feature(const_ptr_offset_from)` (1.65, *).
  - `feature(bench_black_box)` (1.66, *).
  - `feature(pin_macro)` (1.68).

The ones marked with `*` apply only to our old `rust` branch, not
mainline yet, i.e. only for code that we may potentially upstream.

With this patch applied, the only unstable feature allowed to be used
outside the `kernel` crate is `new_uninit`, though other code to be
upstreamed may increase the list.

Please see [2] for details.

# Other required changes

Since 1.63, `rustdoc` triggers the `broken_intra_doc_links` lint for
links pointing to exported (`#[macro_export]`) `macro_rules`. An issue
was opened upstream [4], but it turns out it is intended behavior. For
the moment, just add an explicit reference for each link. Later we can
revisit this if `rustdoc` removes the compatibility measure.

Nevertheless, this was helpful to discover a link that was pointing to
the wrong place unintentionally. Since that one was actually wrong, it
is fixed in a previous commit independently.

Another change was the addition of `cfg(no_rc)` and `cfg(no_sync)` in
upstream [5], thus remove our original changes for that.

Similarly, upstream now tests that it compiles successfully with
`#[cfg(not(no_global_oom_handling))]` [6], which allow us to get rid
of some changes, such as an `#[allow(dead_code)]`.

In addition, remove another `#[allow(dead_code)]` due to new uses
within the standard library.

Finally, add `try_extend_trusted` and move the code in `spec_extend.rs`
since upstream moved it for the infallible version.

# `alloc` upgrade and reviewing

There are a large amount of changes, but the vast majority of them are
due to our `alloc` fork being upgraded at once.

There are two kinds of changes to be aware of: the ones coming from
upstream, which we should follow as closely as possible, and the updates
needed in our added fallible APIs to keep them matching the newer
infallible APIs coming from upstream.

Instead of taking a look at the diff of this patch, an alternative
approach is reviewing a diff of the changes between upstream `alloc` and
the kernel's. This allows to easily inspect the kernel additions only,
especially to check if the fallible methods we already have still match
the infallible ones in the new version coming from upstream.

Another approach is reviewing the changes introduced in the additions in
the kernel fork between the two versions. This is useful to spot
potentially unintended changes to our additions.

To apply these approaches, one may follow steps similar to the following
to generate a pair of patches that show the differences between upstream
Rust and the kernel (for the subset of `alloc` we use) before and after
applying this patch:

    # Get the difference with respect to the old version.
    git -C rust checkout $(linux/scripts/min-tool-version.sh rustc)
    git -C linux ls-tree -r --name-only HEAD -- rust/alloc |
        cut -d/ -f3- |
        grep -Fv README.md |
        xargs -IPATH cp rust/library/alloc/src/PATH linux/rust/alloc/PATH
    git -C linux diff --patch-with-stat --summary -R > old.patch
    git -C linux restore rust/alloc

    # Apply this patch.
    git -C linux am rust-upgrade.patch

    # Get the difference with respect to the new version.
    git -C rust checkout $(linux/scripts/min-tool-version.sh rustc)
    git -C linux ls-tree -r --name-only HEAD -- rust/alloc |
        cut -d/ -f3- |
        grep -Fv README.md |
        xargs -IPATH cp rust/library/alloc/src/PATH linux/rust/alloc/PATH
    git -C linux diff --patch-with-stat --summary -R > new.patch
    git -C linux restore rust/alloc

Now one may check the `new.patch` to take a look at the additions (first
approach) or at the difference between those two patches (second
approach). For the latter, a side-by-side tool is recommended.

Link: https://rust-for-linux.com/rust-version-policy [1]
Link: https://github.com/Rust-for-Linux/linux/issues/2 [2]
Link: https://lore.kernel.org/rust-for-linux/CANiq72mT3bVDKdHgaea-6WiZazd8Mvurqmqegbe5JZxVyLR8Yg@mail.gmail.com/ [3]
Link: https://github.com/rust-lang/rust/issues/106142 [4]
Link: https://github.com/rust-lang/rust/pull/89891 [5]
Link: https://github.com/rust-lang/rust/pull/98652 [6]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/process/changes.rst |   2 +-
 rust/alloc/alloc.rs               |  55 ++--
 rust/alloc/boxed.rs               | 446 ++++++++++++++++++++++++++--
 rust/alloc/collections/mod.rs     |   5 +-
 rust/alloc/lib.rs                 |  71 +++--
 rust/alloc/raw_vec.rs             |  16 +-
 rust/alloc/slice.rs               | 447 ++++------------------------
 rust/alloc/vec/drain.rs           |  81 +++++-
 rust/alloc/vec/drain_filter.rs    |  60 +++-
 rust/alloc/vec/into_iter.rs       | 125 ++++++--
 rust/alloc/vec/is_zero.rs         |  96 ++++++-
 rust/alloc/vec/mod.rs             | 464 +++++++++++++++++++++++-------
 rust/alloc/vec/set_len_on_drop.rs |   5 +
 rust/alloc/vec/spec_extend.rs     |  63 +---
 rust/bindings/lib.rs              |   1 -
 rust/kernel/build_assert.rs       |   2 +
 rust/kernel/init.rs               |   5 +
 rust/kernel/lib.rs                |   4 -
 rust/kernel/std_vendor.rs         |   2 +
 scripts/Makefile.build            |   2 +-
 scripts/min-tool-version.sh       |   2 +-
 21 files changed, 1274 insertions(+), 680 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index ef540865ad22..5cf6a5f8ca57 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -31,7 +31,7 @@ you probably needn't concern yourself with pcmciautils.
 ====================== ===============  ========================================
 GNU C                  5.1              gcc --version
 Clang/LLVM (optional)  11.0.0           clang --version
-Rust (optional)        1.62.0           rustc --version
+Rust (optional)        1.68.2           rustc --version
 bindgen (optional)     0.56.0           bindgen --version
 GNU make               3.82             make --version
 bash                   4.2              bash --version
diff --git a/rust/alloc/alloc.rs b/rust/alloc/alloc.rs
index ca224a541770..acf22d45e6f2 100644
--- a/rust/alloc/alloc.rs
+++ b/rust/alloc/alloc.rs
@@ -22,21 +22,24 @@ use core::marker::Destruct;
 mod tests;
 
 extern "Rust" {
-    // These are the magic symbols to call the global allocator.  rustc generates
+    // These are the magic symbols to call the global allocator. rustc generates
     // them to call `__rg_alloc` etc. if there is a `#[global_allocator]` attribute
     // (the code expanding that attribute macro generates those functions), or to call
-    // the default implementations in libstd (`__rdl_alloc` etc. in `library/std/src/alloc.rs`)
+    // the default implementations in std (`__rdl_alloc` etc. in `library/std/src/alloc.rs`)
     // otherwise.
-    // The rustc fork of LLVM also special-cases these function names to be able to optimize them
+    // The rustc fork of LLVM 14 and earlier also special-cases these function names to be able to optimize them
     // like `malloc`, `realloc`, and `free`, respectively.
     #[rustc_allocator]
-    #[rustc_allocator_nounwind]
+    #[rustc_nounwind]
     fn __rust_alloc(size: usize, align: usize) -> *mut u8;
-    #[rustc_allocator_nounwind]
+    #[rustc_deallocator]
+    #[rustc_nounwind]
     fn __rust_dealloc(ptr: *mut u8, size: usize, align: usize);
-    #[rustc_allocator_nounwind]
+    #[rustc_reallocator]
+    #[rustc_nounwind]
     fn __rust_realloc(ptr: *mut u8, old_size: usize, align: usize, new_size: usize) -> *mut u8;
-    #[rustc_allocator_nounwind]
+    #[rustc_allocator_zeroed]
+    #[rustc_nounwind]
     fn __rust_alloc_zeroed(size: usize, align: usize) -> *mut u8;
 }
 
@@ -72,11 +75,14 @@ pub use std::alloc::Global;
 /// # Examples
 ///
 /// ```
-/// use std::alloc::{alloc, dealloc, Layout};
+/// use std::alloc::{alloc, dealloc, handle_alloc_error, Layout};
 ///
 /// unsafe {
 ///     let layout = Layout::new::<u16>();
 ///     let ptr = alloc(layout);
+///     if ptr.is_null() {
+///         handle_alloc_error(layout);
+///     }
 ///
 ///     *(ptr as *mut u16) = 42;
 ///     assert_eq!(*(ptr as *mut u16), 42);
@@ -349,7 +355,7 @@ pub(crate) const unsafe fn box_free<T: ?Sized, A: ~const Allocator + ~const Dest
 
 #[cfg(not(no_global_oom_handling))]
 extern "Rust" {
-    // This is the magic symbol to call the global alloc error handler.  rustc generates
+    // This is the magic symbol to call the global alloc error handler. rustc generates
     // it to call `__rg_oom` if there is a `#[alloc_error_handler]`, or to call the
     // default implementations below (`__rdl_oom`) otherwise.
     fn __rust_alloc_error_handler(size: usize, align: usize) -> !;
@@ -394,25 +400,24 @@ pub use std::alloc::handle_alloc_error;
 #[allow(unused_attributes)]
 #[unstable(feature = "alloc_internals", issue = "none")]
 pub mod __alloc_error_handler {
-    use crate::alloc::Layout;
-
-    // called via generated `__rust_alloc_error_handler`
-
-    // if there is no `#[alloc_error_handler]`
+    // called via generated `__rust_alloc_error_handler` if there is no
+    // `#[alloc_error_handler]`.
     #[rustc_std_internal_symbol]
-    pub unsafe extern "C-unwind" fn __rdl_oom(size: usize, _align: usize) -> ! {
-        panic!("memory allocation of {size} bytes failed")
-    }
-
-    // if there is an `#[alloc_error_handler]`
-    #[rustc_std_internal_symbol]
-    pub unsafe extern "C-unwind" fn __rg_oom(size: usize, align: usize) -> ! {
-        let layout = unsafe { Layout::from_size_align_unchecked(size, align) };
+    pub unsafe fn __rdl_oom(size: usize, _align: usize) -> ! {
         extern "Rust" {
-            #[lang = "oom"]
-            fn oom_impl(layout: Layout) -> !;
+            // This symbol is emitted by rustc next to __rust_alloc_error_handler.
+            // Its value depends on the -Zoom={panic,abort} compiler option.
+            static __rust_alloc_error_handler_should_panic: u8;
+        }
+
+        #[allow(unused_unsafe)]
+        if unsafe { __rust_alloc_error_handler_should_panic != 0 } {
+            panic!("memory allocation of {size} bytes failed")
+        } else {
+            core::panicking::panic_nounwind_fmt(format_args!(
+                "memory allocation of {size} bytes failed"
+            ))
         }
-        unsafe { oom_impl(layout) }
     }
 }
 
diff --git a/rust/alloc/boxed.rs b/rust/alloc/boxed.rs
index dcfe87b14f3a..14af9860c36c 100644
--- a/rust/alloc/boxed.rs
+++ b/rust/alloc/boxed.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: Apache-2.0 OR MIT
 
-//! A pointer type for heap allocation.
+//! The `Box<T>` type for heap allocation.
 //!
 //! [`Box<T>`], casually referred to as a 'box', provides the simplest form of
 //! heap allocation in Rust. Boxes provide ownership for this allocation, and
@@ -124,7 +124,21 @@
 //! definition is just using `T*` can lead to undefined behavior, as
 //! described in [rust-lang/unsafe-code-guidelines#198][ucg#198].
 //!
+//! # Considerations for unsafe code
+//!
+//! **Warning: This section is not normative and is subject to change, possibly
+//! being relaxed in the future! It is a simplified summary of the rules
+//! currently implemented in the compiler.**
+//!
+//! The aliasing rules for `Box<T>` are the same as for `&mut T`. `Box<T>`
+//! asserts uniqueness over its content. Using raw pointers derived from a box
+//! after that box has been mutated through, moved or borrowed as `&mut T`
+//! is not allowed. For more guidance on working with box from unsafe code, see
+//! [rust-lang/unsafe-code-guidelines#326][ucg#326].
+//!
+//!
 //! [ucg#198]: https://github.com/rust-lang/unsafe-code-guidelines/issues/198
+//! [ucg#326]: https://github.com/rust-lang/unsafe-code-guidelines/issues/326
 //! [dereferencing]: core::ops::Deref
 //! [`Box::<T>::from_raw(value)`]: Box::from_raw
 //! [`Global`]: crate::alloc::Global
@@ -139,12 +153,14 @@ use core::async_iter::AsyncIterator;
 use core::borrow;
 use core::cmp::Ordering;
 use core::convert::{From, TryFrom};
+use core::error::Error;
 use core::fmt;
 use core::future::Future;
 use core::hash::{Hash, Hasher};
 #[cfg(not(no_global_oom_handling))]
 use core::iter::FromIterator;
 use core::iter::{FusedIterator, Iterator};
+use core::marker::Tuple;
 use core::marker::{Destruct, Unpin, Unsize};
 use core::mem;
 use core::ops::{
@@ -163,6 +179,8 @@ use crate::raw_vec::RawVec;
 #[cfg(not(no_global_oom_handling))]
 use crate::str::from_boxed_utf8_unchecked;
 #[cfg(not(no_global_oom_handling))]
+use crate::string::String;
+#[cfg(not(no_global_oom_handling))]
 use crate::vec::Vec;
 
 #[cfg(not(no_thin))]
@@ -172,7 +190,7 @@ pub use thin::ThinBox;
 #[cfg(not(no_thin))]
 mod thin;
 
-/// A pointer type for heap allocation.
+/// A pointer type that uniquely owns a heap allocation of type `T`.
 ///
 /// See the [module-level documentation](../../std/boxed/index.html) for more.
 #[lang = "owned_box"]
@@ -196,12 +214,13 @@ impl<T> Box<T> {
     /// ```
     /// let five = Box::new(5);
     /// ```
-    #[cfg(not(no_global_oom_handling))]
+    #[cfg(all(not(no_global_oom_handling)))]
     #[inline(always)]
     #[stable(feature = "rust1", since = "1.0.0")]
     #[must_use]
     pub fn new(x: T) -> Self {
-        box x
+        #[rustc_box]
+        Box::new(x)
     }
 
     /// Constructs a new box with uninitialized contents.
@@ -256,14 +275,21 @@ impl<T> Box<T> {
         Self::new_zeroed_in(Global)
     }
 
-    /// Constructs a new `Pin<Box<T>>`. If `T` does not implement `Unpin`, then
+    /// Constructs a new `Pin<Box<T>>`. If `T` does not implement [`Unpin`], then
     /// `x` will be pinned in memory and unable to be moved.
+    ///
+    /// Constructing and pinning of the `Box` can also be done in two steps: `Box::pin(x)`
+    /// does the same as <code>[Box::into_pin]\([Box::new]\(x))</code>. Consider using
+    /// [`into_pin`](Box::into_pin) if you already have a `Box<T>`, or if you want to
+    /// construct a (pinned) `Box` in a different way than with [`Box::new`].
     #[cfg(not(no_global_oom_handling))]
     #[stable(feature = "pin", since = "1.33.0")]
     #[must_use]
     #[inline(always)]
     pub fn pin(x: T) -> Pin<Box<T>> {
-        (box x).into()
+        (#[rustc_box]
+        Box::new(x))
+        .into()
     }
 
     /// Allocates memory on the heap then places `x` into it,
@@ -543,8 +569,13 @@ impl<T, A: Allocator> Box<T, A> {
         unsafe { Ok(Box::from_raw_in(ptr.as_ptr(), alloc)) }
     }
 
-    /// Constructs a new `Pin<Box<T, A>>`. If `T` does not implement `Unpin`, then
+    /// Constructs a new `Pin<Box<T, A>>`. If `T` does not implement [`Unpin`], then
     /// `x` will be pinned in memory and unable to be moved.
+    ///
+    /// Constructing and pinning of the `Box` can also be done in two steps: `Box::pin_in(x, alloc)`
+    /// does the same as <code>[Box::into_pin]\([Box::new_in]\(x, alloc))</code>. Consider using
+    /// [`into_pin`](Box::into_pin) if you already have a `Box<T, A>`, or if you want to
+    /// construct a (pinned) `Box` in a different way than with [`Box::new_in`].
     #[cfg(not(no_global_oom_handling))]
     #[unstable(feature = "allocator_api", issue = "32838")]
     #[rustc_const_unstable(feature = "const_box", issue = "92521")]
@@ -926,6 +957,7 @@ impl<T: ?Sized> Box<T> {
     /// [`Layout`]: crate::Layout
     #[stable(feature = "box_raw", since = "1.4.0")]
     #[inline]
+    #[must_use = "call `drop(Box::from_raw(ptr))` if you intend to drop the `Box`"]
     pub unsafe fn from_raw(raw: *mut T) -> Self {
         unsafe { Self::from_raw_in(raw, Global) }
     }
@@ -1160,19 +1192,44 @@ impl<T: ?Sized, A: Allocator> Box<T, A> {
         unsafe { &mut *mem::ManuallyDrop::new(b).0.as_ptr() }
     }
 
-    /// Converts a `Box<T>` into a `Pin<Box<T>>`
+    /// Converts a `Box<T>` into a `Pin<Box<T>>`. If `T` does not implement [`Unpin`], then
+    /// `*boxed` will be pinned in memory and unable to be moved.
     ///
     /// This conversion does not allocate on the heap and happens in place.
     ///
     /// This is also available via [`From`].
-    #[unstable(feature = "box_into_pin", issue = "62370")]
+    ///
+    /// Constructing and pinning a `Box` with <code>Box::into_pin([Box::new]\(x))</code>
+    /// can also be written more concisely using <code>[Box::pin]\(x)</code>.
+    /// This `into_pin` method is useful if you already have a `Box<T>`, or you are
+    /// constructing a (pinned) `Box` in a different way than with [`Box::new`].
+    ///
+    /// # Notes
+    ///
+    /// It's not recommended that crates add an impl like `From<Box<T>> for Pin<T>`,
+    /// as it'll introduce an ambiguity when calling `Pin::from`.
+    /// A demonstration of such a poor impl is shown below.
+    ///
+    /// ```compile_fail
+    /// # use std::pin::Pin;
+    /// struct Foo; // A type defined in this crate.
+    /// impl From<Box<()>> for Pin<Foo> {
+    ///     fn from(_: Box<()>) -> Pin<Foo> {
+    ///         Pin::new(Foo)
+    ///     }
+    /// }
+    ///
+    /// let foo = Box::new(());
+    /// let bar = Pin::from(foo);
+    /// ```
+    #[stable(feature = "box_into_pin", since = "1.63.0")]
     #[rustc_const_unstable(feature = "const_box", issue = "92521")]
     pub const fn into_pin(boxed: Self) -> Pin<Self>
     where
         A: 'static,
     {
         // It's not possible to move or replace the insides of a `Pin<Box<T>>`
-        // when `T: !Unpin`,  so it's safe to pin it directly without any
+        // when `T: !Unpin`, so it's safe to pin it directly without any
         // additional requirements.
         unsafe { Pin::new_unchecked(boxed) }
     }
@@ -1190,7 +1247,8 @@ unsafe impl<#[may_dangle] T: ?Sized, A: Allocator> Drop for Box<T, A> {
 impl<T: Default> Default for Box<T> {
     /// Creates a `Box<T>`, with the `Default` value for T.
     fn default() -> Self {
-        box T::default()
+        #[rustc_box]
+        Box::new(T::default())
     }
 }
 
@@ -1408,9 +1466,17 @@ impl<T: ?Sized, A: Allocator> const From<Box<T, A>> for Pin<Box<T, A>>
 where
     A: 'static,
 {
-    /// Converts a `Box<T>` into a `Pin<Box<T>>`
+    /// Converts a `Box<T>` into a `Pin<Box<T>>`. If `T` does not implement [`Unpin`], then
+    /// `*boxed` will be pinned in memory and unable to be moved.
     ///
     /// This conversion does not allocate on the heap and happens in place.
+    ///
+    /// This is also available via [`Box::into_pin`].
+    ///
+    /// Constructing and pinning a `Box` with <code><Pin<Box\<T>>>::from([Box::new]\(x))</code>
+    /// can also be written more concisely using <code>[Box::pin]\(x)</code>.
+    /// This `From` implementation is useful if you already have a `Box<T>`, or you are
+    /// constructing a (pinned) `Box` in a different way than with [`Box::new`].
     fn from(boxed: Box<T, A>) -> Self {
         Box::into_pin(boxed)
     }
@@ -1422,7 +1488,7 @@ impl<T: Copy> From<&[T]> for Box<[T]> {
     /// Converts a `&[T]` into a `Box<[T]>`
     ///
     /// This conversion allocates on the heap
-    /// and performs a copy of `slice`.
+    /// and performs a copy of `slice` and its contents.
     ///
     /// # Examples
     /// ```rust
@@ -1554,10 +1620,27 @@ impl<T, const N: usize> From<[T; N]> for Box<[T]> {
     /// println!("{boxed:?}");
     /// ```
     fn from(array: [T; N]) -> Box<[T]> {
-        box array
+        #[rustc_box]
+        Box::new(array)
     }
 }
 
+/// Casts a boxed slice to a boxed array.
+///
+/// # Safety
+///
+/// `boxed_slice.len()` must be exactly `N`.
+unsafe fn boxed_slice_as_array_unchecked<T, A: Allocator, const N: usize>(
+    boxed_slice: Box<[T], A>,
+) -> Box<[T; N], A> {
+    debug_assert_eq!(boxed_slice.len(), N);
+
+    let (ptr, alloc) = Box::into_raw_with_allocator(boxed_slice);
+    // SAFETY: Pointer and allocator came from an existing box,
+    // and our safety condition requires that the length is exactly `N`
+    unsafe { Box::from_raw_in(ptr as *mut [T; N], alloc) }
+}
+
 #[stable(feature = "boxed_slice_try_from", since = "1.43.0")]
 impl<T, const N: usize> TryFrom<Box<[T]>> for Box<[T; N]> {
     type Error = Box<[T]>;
@@ -1573,13 +1656,46 @@ impl<T, const N: usize> TryFrom<Box<[T]>> for Box<[T; N]> {
     /// `boxed_slice.len()` does not equal `N`.
     fn try_from(boxed_slice: Box<[T]>) -> Result<Self, Self::Error> {
         if boxed_slice.len() == N {
-            Ok(unsafe { Box::from_raw(Box::into_raw(boxed_slice) as *mut [T; N]) })
+            Ok(unsafe { boxed_slice_as_array_unchecked(boxed_slice) })
         } else {
             Err(boxed_slice)
         }
     }
 }
 
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "boxed_array_try_from_vec", since = "1.66.0")]
+impl<T, const N: usize> TryFrom<Vec<T>> for Box<[T; N]> {
+    type Error = Vec<T>;
+
+    /// Attempts to convert a `Vec<T>` into a `Box<[T; N]>`.
+    ///
+    /// Like [`Vec::into_boxed_slice`], this is in-place if `vec.capacity() == N`,
+    /// but will require a reallocation otherwise.
+    ///
+    /// # Errors
+    ///
+    /// Returns the original `Vec<T>` in the `Err` variant if
+    /// `boxed_slice.len()` does not equal `N`.
+    ///
+    /// # Examples
+    ///
+    /// This can be used with [`vec!`] to create an array on the heap:
+    ///
+    /// ```
+    /// let state: Box<[f32; 100]> = vec![1.0; 100].try_into().unwrap();
+    /// assert_eq!(state.len(), 100);
+    /// ```
+    fn try_from(vec: Vec<T>) -> Result<Self, Self::Error> {
+        if vec.len() == N {
+            let boxed_slice = vec.into_boxed_slice();
+            Ok(unsafe { boxed_slice_as_array_unchecked(boxed_slice) })
+        } else {
+            Err(vec)
+        }
+    }
+}
+
 impl<A: Allocator> Box<dyn Any, A> {
     /// Attempt to downcast the box to a concrete type.
     ///
@@ -1869,7 +1985,7 @@ impl<I: ExactSizeIterator + ?Sized, A: Allocator> ExactSizeIterator for Box<I, A
 impl<I: FusedIterator + ?Sized, A: Allocator> FusedIterator for Box<I, A> {}
 
 #[stable(feature = "boxed_closure_impls", since = "1.35.0")]
-impl<Args, F: FnOnce<Args> + ?Sized, A: Allocator> FnOnce<Args> for Box<F, A> {
+impl<Args: Tuple, F: FnOnce<Args> + ?Sized, A: Allocator> FnOnce<Args> for Box<F, A> {
     type Output = <F as FnOnce<Args>>::Output;
 
     extern "rust-call" fn call_once(self, args: Args) -> Self::Output {
@@ -1878,20 +1994,20 @@ impl<Args, F: FnOnce<Args> + ?Sized, A: Allocator> FnOnce<Args> for Box<F, A> {
 }
 
 #[stable(feature = "boxed_closure_impls", since = "1.35.0")]
-impl<Args, F: FnMut<Args> + ?Sized, A: Allocator> FnMut<Args> for Box<F, A> {
+impl<Args: Tuple, F: FnMut<Args> + ?Sized, A: Allocator> FnMut<Args> for Box<F, A> {
     extern "rust-call" fn call_mut(&mut self, args: Args) -> Self::Output {
         <F as FnMut<Args>>::call_mut(self, args)
     }
 }
 
 #[stable(feature = "boxed_closure_impls", since = "1.35.0")]
-impl<Args, F: Fn<Args> + ?Sized, A: Allocator> Fn<Args> for Box<F, A> {
+impl<Args: Tuple, F: Fn<Args> + ?Sized, A: Allocator> Fn<Args> for Box<F, A> {
     extern "rust-call" fn call(&self, args: Args) -> Self::Output {
         <F as Fn<Args>>::call(self, args)
     }
 }
 
-#[unstable(feature = "coerce_unsized", issue = "27732")]
+#[unstable(feature = "coerce_unsized", issue = "18598")]
 impl<T: ?Sized + Unsize<U>, U: ?Sized, A: Allocator> CoerceUnsized<Box<U, A>> for Box<T, A> {}
 
 #[unstable(feature = "dispatch_from_dyn", issue = "none")]
@@ -1973,8 +2089,7 @@ impl<T: ?Sized, A: Allocator> AsMut<T> for Box<T, A> {
  *  could have a method to project a Pin<T> from it.
  */
 #[stable(feature = "pin", since = "1.33.0")]
-#[rustc_const_unstable(feature = "const_box", issue = "92521")]
-impl<T: ?Sized, A: Allocator> const Unpin for Box<T, A> where A: 'static {}
+impl<T: ?Sized, A: Allocator> Unpin for Box<T, A> where A: 'static {}
 
 #[unstable(feature = "generator_trait", issue = "43122")]
 impl<G: ?Sized + Generator<R> + Unpin, R, A: Allocator> Generator<R> for Box<G, A>
@@ -2026,3 +2141,292 @@ impl<S: ?Sized + AsyncIterator + Unpin> AsyncIterator for Box<S> {
         (**self).size_hint()
     }
 }
+
+impl dyn Error {
+    #[inline]
+    #[stable(feature = "error_downcast", since = "1.3.0")]
+    #[rustc_allow_incoherent_impl]
+    /// Attempts to downcast the box to a concrete type.
+    pub fn downcast<T: Error + 'static>(self: Box<Self>) -> Result<Box<T>, Box<dyn Error>> {
+        if self.is::<T>() {
+            unsafe {
+                let raw: *mut dyn Error = Box::into_raw(self);
+                Ok(Box::from_raw(raw as *mut T))
+            }
+        } else {
+            Err(self)
+        }
+    }
+}
+
+impl dyn Error + Send {
+    #[inline]
+    #[stable(feature = "error_downcast", since = "1.3.0")]
+    #[rustc_allow_incoherent_impl]
+    /// Attempts to downcast the box to a concrete type.
+    pub fn downcast<T: Error + 'static>(self: Box<Self>) -> Result<Box<T>, Box<dyn Error + Send>> {
+        let err: Box<dyn Error> = self;
+        <dyn Error>::downcast(err).map_err(|s| unsafe {
+            // Reapply the `Send` marker.
+            mem::transmute::<Box<dyn Error>, Box<dyn Error + Send>>(s)
+        })
+    }
+}
+
+impl dyn Error + Send + Sync {
+    #[inline]
+    #[stable(feature = "error_downcast", since = "1.3.0")]
+    #[rustc_allow_incoherent_impl]
+    /// Attempts to downcast the box to a concrete type.
+    pub fn downcast<T: Error + 'static>(self: Box<Self>) -> Result<Box<T>, Box<Self>> {
+        let err: Box<dyn Error> = self;
+        <dyn Error>::downcast(err).map_err(|s| unsafe {
+            // Reapply the `Send + Sync` marker.
+            mem::transmute::<Box<dyn Error>, Box<dyn Error + Send + Sync>>(s)
+        })
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<'a, E: Error + 'a> From<E> for Box<dyn Error + 'a> {
+    /// Converts a type of [`Error`] into a box of dyn [`Error`].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::error::Error;
+    /// use std::fmt;
+    /// use std::mem;
+    ///
+    /// #[derive(Debug)]
+    /// struct AnError;
+    ///
+    /// impl fmt::Display for AnError {
+    ///     fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+    ///         write!(f, "An error")
+    ///     }
+    /// }
+    ///
+    /// impl Error for AnError {}
+    ///
+    /// let an_error = AnError;
+    /// assert!(0 == mem::size_of_val(&an_error));
+    /// let a_boxed_error = Box::<dyn Error>::from(an_error);
+    /// assert!(mem::size_of::<Box<dyn Error>>() == mem::size_of_val(&a_boxed_error))
+    /// ```
+    fn from(err: E) -> Box<dyn Error + 'a> {
+        Box::new(err)
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<'a, E: Error + Send + Sync + 'a> From<E> for Box<dyn Error + Send + Sync + 'a> {
+    /// Converts a type of [`Error`] + [`Send`] + [`Sync`] into a box of
+    /// dyn [`Error`] + [`Send`] + [`Sync`].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::error::Error;
+    /// use std::fmt;
+    /// use std::mem;
+    ///
+    /// #[derive(Debug)]
+    /// struct AnError;
+    ///
+    /// impl fmt::Display for AnError {
+    ///     fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+    ///         write!(f, "An error")
+    ///     }
+    /// }
+    ///
+    /// impl Error for AnError {}
+    ///
+    /// unsafe impl Send for AnError {}
+    ///
+    /// unsafe impl Sync for AnError {}
+    ///
+    /// let an_error = AnError;
+    /// assert!(0 == mem::size_of_val(&an_error));
+    /// let a_boxed_error = Box::<dyn Error + Send + Sync>::from(an_error);
+    /// assert!(
+    ///     mem::size_of::<Box<dyn Error + Send + Sync>>() == mem::size_of_val(&a_boxed_error))
+    /// ```
+    fn from(err: E) -> Box<dyn Error + Send + Sync + 'a> {
+        Box::new(err)
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl From<String> for Box<dyn Error + Send + Sync> {
+    /// Converts a [`String`] into a box of dyn [`Error`] + [`Send`] + [`Sync`].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::error::Error;
+    /// use std::mem;
+    ///
+    /// let a_string_error = "a string error".to_string();
+    /// let a_boxed_error = Box::<dyn Error + Send + Sync>::from(a_string_error);
+    /// assert!(
+    ///     mem::size_of::<Box<dyn Error + Send + Sync>>() == mem::size_of_val(&a_boxed_error))
+    /// ```
+    #[inline]
+    fn from(err: String) -> Box<dyn Error + Send + Sync> {
+        struct StringError(String);
+
+        impl Error for StringError {
+            #[allow(deprecated)]
+            fn description(&self) -> &str {
+                &self.0
+            }
+        }
+
+        impl fmt::Display for StringError {
+            fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+                fmt::Display::fmt(&self.0, f)
+            }
+        }
+
+        // Purposefully skip printing "StringError(..)"
+        impl fmt::Debug for StringError {
+            fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+                fmt::Debug::fmt(&self.0, f)
+            }
+        }
+
+        Box::new(StringError(err))
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "string_box_error", since = "1.6.0")]
+impl From<String> for Box<dyn Error> {
+    /// Converts a [`String`] into a box of dyn [`Error`].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::error::Error;
+    /// use std::mem;
+    ///
+    /// let a_string_error = "a string error".to_string();
+    /// let a_boxed_error = Box::<dyn Error>::from(a_string_error);
+    /// assert!(mem::size_of::<Box<dyn Error>>() == mem::size_of_val(&a_boxed_error))
+    /// ```
+    fn from(str_err: String) -> Box<dyn Error> {
+        let err1: Box<dyn Error + Send + Sync> = From::from(str_err);
+        let err2: Box<dyn Error> = err1;
+        err2
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<'a> From<&str> for Box<dyn Error + Send + Sync + 'a> {
+    /// Converts a [`str`] into a box of dyn [`Error`] + [`Send`] + [`Sync`].
+    ///
+    /// [`str`]: prim@str
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::error::Error;
+    /// use std::mem;
+    ///
+    /// let a_str_error = "a str error";
+    /// let a_boxed_error = Box::<dyn Error + Send + Sync>::from(a_str_error);
+    /// assert!(
+    ///     mem::size_of::<Box<dyn Error + Send + Sync>>() == mem::size_of_val(&a_boxed_error))
+    /// ```
+    #[inline]
+    fn from(err: &str) -> Box<dyn Error + Send + Sync + 'a> {
+        From::from(String::from(err))
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "string_box_error", since = "1.6.0")]
+impl From<&str> for Box<dyn Error> {
+    /// Converts a [`str`] into a box of dyn [`Error`].
+    ///
+    /// [`str`]: prim@str
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::error::Error;
+    /// use std::mem;
+    ///
+    /// let a_str_error = "a str error";
+    /// let a_boxed_error = Box::<dyn Error>::from(a_str_error);
+    /// assert!(mem::size_of::<Box<dyn Error>>() == mem::size_of_val(&a_boxed_error))
+    /// ```
+    fn from(err: &str) -> Box<dyn Error> {
+        From::from(String::from(err))
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "cow_box_error", since = "1.22.0")]
+impl<'a, 'b> From<Cow<'b, str>> for Box<dyn Error + Send + Sync + 'a> {
+    /// Converts a [`Cow`] into a box of dyn [`Error`] + [`Send`] + [`Sync`].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::error::Error;
+    /// use std::mem;
+    /// use std::borrow::Cow;
+    ///
+    /// let a_cow_str_error = Cow::from("a str error");
+    /// let a_boxed_error = Box::<dyn Error + Send + Sync>::from(a_cow_str_error);
+    /// assert!(
+    ///     mem::size_of::<Box<dyn Error + Send + Sync>>() == mem::size_of_val(&a_boxed_error))
+    /// ```
+    fn from(err: Cow<'b, str>) -> Box<dyn Error + Send + Sync + 'a> {
+        From::from(String::from(err))
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "cow_box_error", since = "1.22.0")]
+impl<'a> From<Cow<'a, str>> for Box<dyn Error> {
+    /// Converts a [`Cow`] into a box of dyn [`Error`].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::error::Error;
+    /// use std::mem;
+    /// use std::borrow::Cow;
+    ///
+    /// let a_cow_str_error = Cow::from("a str error");
+    /// let a_boxed_error = Box::<dyn Error>::from(a_cow_str_error);
+    /// assert!(mem::size_of::<Box<dyn Error>>() == mem::size_of_val(&a_boxed_error))
+    /// ```
+    fn from(err: Cow<'a, str>) -> Box<dyn Error> {
+        From::from(String::from(err))
+    }
+}
+
+#[stable(feature = "box_error", since = "1.8.0")]
+impl<T: core::error::Error> core::error::Error for Box<T> {
+    #[allow(deprecated, deprecated_in_future)]
+    fn description(&self) -> &str {
+        core::error::Error::description(&**self)
+    }
+
+    #[allow(deprecated)]
+    fn cause(&self) -> Option<&dyn core::error::Error> {
+        core::error::Error::cause(&**self)
+    }
+
+    fn source(&self) -> Option<&(dyn core::error::Error + 'static)> {
+        core::error::Error::source(&**self)
+    }
+}
diff --git a/rust/alloc/collections/mod.rs b/rust/alloc/collections/mod.rs
index 1eec265b28f8..2506065d158a 100644
--- a/rust/alloc/collections/mod.rs
+++ b/rust/alloc/collections/mod.rs
@@ -141,7 +141,7 @@ impl Display for TryReserveError {
                 " because the computed capacity exceeded the collection's maximum"
             }
             TryReserveErrorKind::AllocError { .. } => {
-                " because the memory allocator returned a error"
+                " because the memory allocator returned an error"
             }
         };
         fmt.write_str(reason)
@@ -154,3 +154,6 @@ trait SpecExtend<I: IntoIterator> {
     /// Extends `self` with the contents of the given iterator.
     fn spec_extend(&mut self, iter: I);
 }
+
+#[stable(feature = "try_reserve", since = "1.57.0")]
+impl core::error::Error for TryReserveError {}
diff --git a/rust/alloc/lib.rs b/rust/alloc/lib.rs
index 3aebf83c9967..5f374378b0d4 100644
--- a/rust/alloc/lib.rs
+++ b/rust/alloc/lib.rs
@@ -5,7 +5,7 @@
 //! This library provides smart pointers and collections for managing
 //! heap-allocated values.
 //!
-//! This library, like libcore, normally doesn’t need to be used directly
+//! This library, like core, normally doesn’t need to be used directly
 //! since its contents are re-exported in the [`std` crate](../std/index.html).
 //! Crates that use the `#![no_std]` attribute however will typically
 //! not depend on `std`, so they’d use this crate instead.
@@ -58,10 +58,6 @@
 //! [`Rc`]: rc
 //! [`RefCell`]: core::cell
 
-// To run liballoc tests without x.py without ending up with two copies of liballoc, Miri needs to be
-// able to "empty" this crate. See <https://github.com/rust-lang/miri-test-libstd/issues/4>.
-// rustc itself never sets the feature, so this line has no affect there.
-#![cfg(any(not(feature = "miri-test-libstd"), test, doctest))]
 #![allow(unused_attributes)]
 #![stable(feature = "alloc", since = "1.36.0")]
 #![doc(
@@ -75,23 +71,30 @@
     any(not(feature = "miri-test-libstd"), test, doctest),
     no_global_oom_handling,
     not(no_global_oom_handling),
+    not(no_rc),
+    not(no_sync),
     target_has_atomic = "ptr"
 ))]
 #![no_std]
 #![needs_allocator]
+// To run alloc tests without x.py without ending up with two copies of alloc, Miri needs to be
+// able to "empty" this crate. See <https://github.com/rust-lang/miri-test-libstd/issues/4>.
+// rustc itself never sets the feature, so this line has no affect there.
+#![cfg(any(not(feature = "miri-test-libstd"), test, doctest))]
 //
 // Lints:
 #![deny(unsafe_op_in_unsafe_fn)]
+#![deny(fuzzy_provenance_casts)]
 #![warn(deprecated_in_future)]
 #![warn(missing_debug_implementations)]
 #![warn(missing_docs)]
 #![allow(explicit_outlives_requirements)]
 //
 // Library features:
-#![cfg_attr(not(no_global_oom_handling), feature(alloc_c_string))]
 #![feature(alloc_layout_extra)]
 #![feature(allocator_api)]
 #![feature(array_chunks)]
+#![feature(array_into_iter_constructors)]
 #![feature(array_methods)]
 #![feature(array_windows)]
 #![feature(assert_matches)]
@@ -99,39 +102,53 @@
 #![feature(coerce_unsized)]
 #![cfg_attr(not(no_global_oom_handling), feature(const_alloc_error))]
 #![feature(const_box)]
-#![cfg_attr(not(no_global_oom_handling), feature(const_btree_new))]
+#![cfg_attr(not(no_global_oom_handling), feature(const_btree_len))]
 #![cfg_attr(not(no_borrow), feature(const_cow_is_borrowed))]
 #![feature(const_convert)]
 #![feature(const_size_of_val)]
 #![feature(const_align_of_val)]
 #![feature(const_ptr_read)]
+#![feature(const_maybe_uninit_zeroed)]
 #![feature(const_maybe_uninit_write)]
 #![feature(const_maybe_uninit_as_mut_ptr)]
 #![feature(const_refs_to_cell)]
-#![feature(core_c_str)]
 #![feature(core_intrinsics)]
-#![feature(core_ffi_c)]
+#![feature(core_panic)]
 #![feature(const_eval_select)]
 #![feature(const_pin)]
+#![feature(const_waker)]
 #![feature(cstr_from_bytes_until_nul)]
 #![feature(dispatch_from_dyn)]
+#![feature(error_generic_member_access)]
+#![feature(error_in_core)]
 #![feature(exact_size_is_empty)]
 #![feature(extend_one)]
 #![feature(fmt_internals)]
 #![feature(fn_traits)]
 #![feature(hasher_prefixfree_extras)]
+#![feature(inline_const)]
 #![feature(inplace_iteration)]
+#![cfg_attr(test, feature(is_sorted))]
 #![feature(iter_advance_by)]
+#![feature(iter_next_chunk)]
+#![feature(iter_repeat_n)]
 #![feature(layout_for_ptr)]
 #![feature(maybe_uninit_slice)]
+#![feature(maybe_uninit_uninit_array)]
+#![feature(maybe_uninit_uninit_array_transpose)]
 #![cfg_attr(test, feature(new_uninit))]
 #![feature(nonnull_slice_from_raw_parts)]
 #![feature(pattern)]
+#![feature(pointer_byte_offsets)]
+#![feature(provide_any)]
 #![feature(ptr_internals)]
 #![feature(ptr_metadata)]
 #![feature(ptr_sub_ptr)]
 #![feature(receiver_trait)]
+#![feature(saturating_int_impl)]
 #![feature(set_ptr_value)]
+#![feature(sized_type_properties)]
+#![feature(slice_from_ptr_range)]
 #![feature(slice_group_by)]
 #![feature(slice_ptr_get)]
 #![feature(slice_ptr_len)]
@@ -141,15 +158,17 @@
 #![feature(trusted_len)]
 #![feature(trusted_random_access)]
 #![feature(try_trait_v2)]
+#![feature(tuple_trait)]
 #![feature(unchecked_math)]
 #![feature(unicode_internals)]
 #![feature(unsize)]
+#![feature(utf8_chunks)]
+#![feature(std_internals)]
 //
 // Language features:
 #![feature(allocator_internals)]
 #![feature(allow_internal_unstable)]
 #![feature(associated_type_bounds)]
-#![feature(box_syntax)]
 #![feature(cfg_sanitize)]
 #![feature(const_deref)]
 #![feature(const_mut_refs)]
@@ -163,19 +182,21 @@
 #![cfg_attr(not(test), feature(generator_trait))]
 #![feature(hashmap_internals)]
 #![feature(lang_items)]
-#![feature(let_else)]
 #![feature(min_specialization)]
 #![feature(negative_impls)]
 #![feature(never_type)]
-#![feature(nll)] // Not necessary, but here to test the `nll` feature.
 #![feature(rustc_allow_const_fn_unstable)]
 #![feature(rustc_attrs)]
+#![feature(pointer_is_aligned)]
 #![feature(slice_internals)]
 #![feature(staged_api)]
+#![feature(stmt_expr_attributes)]
 #![cfg_attr(test, feature(test))]
 #![feature(unboxed_closures)]
 #![feature(unsized_fn_params)]
 #![feature(c_unwind)]
+#![feature(with_negative_coherence)]
+#![cfg_attr(test, feature(panic_update_hook))]
 //
 // Rustdoc features:
 #![feature(doc_cfg)]
@@ -192,6 +213,8 @@
 extern crate std;
 #[cfg(test)]
 extern crate test;
+#[cfg(test)]
+mod testing;
 
 // Module with internal macros used by other modules (needs to be included before other modules).
 #[cfg(not(no_macros))]
@@ -218,7 +241,7 @@ mod boxed {
 #[cfg(not(no_borrow))]
 pub mod borrow;
 pub mod collections;
-#[cfg(not(no_global_oom_handling))]
+#[cfg(all(not(no_rc), not(no_sync), not(no_global_oom_handling)))]
 pub mod ffi;
 #[cfg(not(no_fmt))]
 pub mod fmt;
@@ -229,10 +252,9 @@ pub mod slice;
 pub mod str;
 #[cfg(not(no_string))]
 pub mod string;
-#[cfg(not(no_sync))]
-#[cfg(target_has_atomic = "ptr")]
+#[cfg(all(not(no_rc), not(no_sync), target_has_atomic = "ptr"))]
 pub mod sync;
-#[cfg(all(not(no_global_oom_handling), target_has_atomic = "ptr"))]
+#[cfg(all(not(no_global_oom_handling), not(no_rc), not(no_sync), target_has_atomic = "ptr"))]
 pub mod task;
 #[cfg(test)]
 mod tests;
@@ -243,3 +265,20 @@ pub mod vec;
 pub mod __export {
     pub use core::format_args;
 }
+
+#[cfg(test)]
+#[allow(dead_code)] // Not used in all configurations
+pub(crate) mod test_helpers {
+    /// Copied from `std::test_helpers::test_rng`, since these tests rely on the
+    /// seed not being the same for every RNG invocation too.
+    pub(crate) fn test_rng() -> rand_xorshift::XorShiftRng {
+        use std::hash::{BuildHasher, Hash, Hasher};
+        let mut hasher = std::collections::hash_map::RandomState::new().build_hasher();
+        std::panic::Location::caller().hash(&mut hasher);
+        let hc64 = hasher.finish();
+        let seed_vec =
+            hc64.to_le_bytes().into_iter().chain(0u8..8).collect::<crate::vec::Vec<u8>>();
+        let seed: [u8; 16] = seed_vec.as_slice().try_into().unwrap();
+        rand::SeedableRng::from_seed(seed)
+    }
+}
diff --git a/rust/alloc/raw_vec.rs b/rust/alloc/raw_vec.rs
index eb77db5def55..5db87eac53b7 100644
--- a/rust/alloc/raw_vec.rs
+++ b/rust/alloc/raw_vec.rs
@@ -5,7 +5,7 @@
 use core::alloc::LayoutError;
 use core::cmp;
 use core::intrinsics;
-use core::mem::{self, ManuallyDrop, MaybeUninit};
+use core::mem::{self, ManuallyDrop, MaybeUninit, SizedTypeProperties};
 use core::ops::Drop;
 use core::ptr::{self, NonNull, Unique};
 use core::slice;
@@ -177,7 +177,7 @@ impl<T, A: Allocator> RawVec<T, A> {
     #[cfg(not(no_global_oom_handling))]
     fn allocate_in(capacity: usize, init: AllocInit, alloc: A) -> Self {
         // Don't allocate here because `Drop` will not deallocate when `capacity` is 0.
-        if mem::size_of::<T>() == 0 || capacity == 0 {
+        if T::IS_ZST || capacity == 0 {
             Self::new_in(alloc)
         } else {
             // We avoid `unwrap_or_else` here because it bloats the amount of
@@ -212,7 +212,7 @@ impl<T, A: Allocator> RawVec<T, A> {
 
     fn try_allocate_in(capacity: usize, init: AllocInit, alloc: A) -> Result<Self, TryReserveError> {
         // Don't allocate here because `Drop` will not deallocate when `capacity` is 0.
-        if mem::size_of::<T>() == 0 || capacity == 0 {
+        if T::IS_ZST || capacity == 0 {
             return Ok(Self::new_in(alloc));
         }
 
@@ -262,7 +262,7 @@ impl<T, A: Allocator> RawVec<T, A> {
     /// This will always be `usize::MAX` if `T` is zero-sized.
     #[inline(always)]
     pub fn capacity(&self) -> usize {
-        if mem::size_of::<T>() == 0 { usize::MAX } else { self.cap }
+        if T::IS_ZST { usize::MAX } else { self.cap }
     }
 
     /// Returns a shared reference to the allocator backing this `RawVec`.
@@ -271,7 +271,7 @@ impl<T, A: Allocator> RawVec<T, A> {
     }
 
     fn current_memory(&self) -> Option<(NonNull<u8>, Layout)> {
-        if mem::size_of::<T>() == 0 || self.cap == 0 {
+        if T::IS_ZST || self.cap == 0 {
             None
         } else {
             // We have an allocated chunk of memory, so we can bypass runtime
@@ -419,7 +419,7 @@ impl<T, A: Allocator> RawVec<T, A> {
         // This is ensured by the calling contexts.
         debug_assert!(additional > 0);
 
-        if mem::size_of::<T>() == 0 {
+        if T::IS_ZST {
             // Since we return a capacity of `usize::MAX` when `elem_size` is
             // 0, getting to here necessarily means the `RawVec` is overfull.
             return Err(CapacityOverflow.into());
@@ -445,7 +445,7 @@ impl<T, A: Allocator> RawVec<T, A> {
     // `grow_amortized`, but this method is usually instantiated less often so
     // it's less critical.
     fn grow_exact(&mut self, len: usize, additional: usize) -> Result<(), TryReserveError> {
-        if mem::size_of::<T>() == 0 {
+        if T::IS_ZST {
             // Since we return a capacity of `usize::MAX` when the type size is
             // 0, getting to here necessarily means the `RawVec` is overfull.
             return Err(CapacityOverflow.into());
@@ -460,7 +460,7 @@ impl<T, A: Allocator> RawVec<T, A> {
         Ok(())
     }
 
-    #[allow(dead_code)]
+    #[cfg(not(no_global_oom_handling))]
     fn shrink(&mut self, cap: usize) -> Result<(), TryReserveError> {
         assert!(cap <= self.capacity(), "Tried to shrink to a larger capacity");
 
diff --git a/rust/alloc/slice.rs b/rust/alloc/slice.rs
index e444e97fa145..245e01590df7 100644
--- a/rust/alloc/slice.rs
+++ b/rust/alloc/slice.rs
@@ -1,84 +1,14 @@
 // SPDX-License-Identifier: Apache-2.0 OR MIT
 
-//! A dynamically-sized view into a contiguous sequence, `[T]`.
+//! Utilities for the slice primitive type.
 //!
 //! *[See also the slice primitive type](slice).*
 //!
-//! Slices are a view into a block of memory represented as a pointer and a
-//! length.
+//! Most of the structs in this module are iterator types which can only be created
+//! using a certain function. For example, `slice.iter()` yields an [`Iter`].
 //!
-//! ```
-//! // slicing a Vec
-//! let vec = vec![1, 2, 3];
-//! let int_slice = &vec[..];
-//! // coercing an array to a slice
-//! let str_slice: &[&str] = &["one", "two", "three"];
-//! ```
-//!
-//! Slices are either mutable or shared. The shared slice type is `&[T]`,
-//! while the mutable slice type is `&mut [T]`, where `T` represents the element
-//! type. For example, you can mutate the block of memory that a mutable slice
-//! points to:
-//!
-//! ```
-//! let x = &mut [1, 2, 3];
-//! x[1] = 7;
-//! assert_eq!(x, &[1, 7, 3]);
-//! ```
-//!
-//! Here are some of the things this module contains:
-//!
-//! ## Structs
-//!
-//! There are several structs that are useful for slices, such as [`Iter`], which
-//! represents iteration over a slice.
-//!
-//! ## Trait Implementations
-//!
-//! There are several implementations of common traits for slices. Some examples
-//! include:
-//!
-//! * [`Clone`]
-//! * [`Eq`], [`Ord`] - for slices whose element type are [`Eq`] or [`Ord`].
-//! * [`Hash`] - for slices whose element type is [`Hash`].
-//!
-//! ## Iteration
-//!
-//! The slices implement `IntoIterator`. The iterator yields references to the
-//! slice elements.
-//!
-//! ```
-//! let numbers = &[0, 1, 2];
-//! for n in numbers {
-//!     println!("{n} is a number!");
-//! }
-//! ```
-//!
-//! The mutable slice yields mutable references to the elements:
-//!
-//! ```
-//! let mut scores = [7, 8, 9];
-//! for score in &mut scores[..] {
-//!     *score += 1;
-//! }
-//! ```
-//!
-//! This iterator yields mutable references to the slice's elements, so while
-//! the element type of the slice is `i32`, the element type of the iterator is
-//! `&mut i32`.
-//!
-//! * [`.iter`] and [`.iter_mut`] are the explicit methods to return the default
-//!   iterators.
-//! * Further methods that return iterators are [`.split`], [`.splitn`],
-//!   [`.chunks`], [`.windows`] and more.
-//!
-//! [`Hash`]: core::hash::Hash
-//! [`.iter`]: slice::iter
-//! [`.iter_mut`]: slice::iter_mut
-//! [`.split`]: slice::split
-//! [`.splitn`]: slice::splitn
-//! [`.chunks`]: slice::chunks
-//! [`.windows`]: slice::windows
+//! A few functions are provided to create a slice from a value reference
+//! or from a raw pointer.
 #![stable(feature = "rust1", since = "1.0.0")]
 // Many of the usings in this module are only used in the test configuration.
 // It's cleaner to just turn off the unused_imports warning than to fix them.
@@ -88,20 +18,23 @@ use core::borrow::{Borrow, BorrowMut};
 #[cfg(not(no_global_oom_handling))]
 use core::cmp::Ordering::{self, Less};
 #[cfg(not(no_global_oom_handling))]
-use core::mem;
-#[cfg(not(no_global_oom_handling))]
-use core::mem::size_of;
+use core::mem::{self, SizedTypeProperties};
 #[cfg(not(no_global_oom_handling))]
 use core::ptr;
+#[cfg(not(no_global_oom_handling))]
+use core::slice::sort;
 
 use crate::alloc::Allocator;
 #[cfg(not(no_global_oom_handling))]
-use crate::alloc::Global;
+use crate::alloc::{self, Global};
 #[cfg(not(no_global_oom_handling))]
 use crate::borrow::ToOwned;
 use crate::boxed::Box;
 use crate::vec::Vec;
 
+#[cfg(test)]
+mod tests;
+
 #[unstable(feature = "slice_range", issue = "76393")]
 pub use core::slice::range;
 #[unstable(feature = "array_chunks", issue = "74985")]
@@ -116,6 +49,8 @@ pub use core::slice::EscapeAscii;
 pub use core::slice::SliceIndex;
 #[stable(feature = "from_ref", since = "1.28.0")]
 pub use core::slice::{from_mut, from_ref};
+#[unstable(feature = "slice_from_ptr_range", issue = "89792")]
+pub use core::slice::{from_mut_ptr_range, from_ptr_range};
 #[stable(feature = "rust1", since = "1.0.0")]
 pub use core::slice::{from_raw_parts, from_raw_parts_mut};
 #[stable(feature = "rust1", since = "1.0.0")]
@@ -275,7 +210,7 @@ impl<T> [T] {
     where
         T: Ord,
     {
-        merge_sort(self, |a, b| a.lt(b));
+        stable_sort(self, T::lt);
     }
 
     /// Sorts the slice with a comparator function.
@@ -331,7 +266,7 @@ impl<T> [T] {
     where
         F: FnMut(&T, &T) -> Ordering,
     {
-        merge_sort(self, |a, b| compare(a, b) == Less);
+        stable_sort(self, |a, b| compare(a, b) == Less);
     }
 
     /// Sorts the slice with a key extraction function.
@@ -374,7 +309,7 @@ impl<T> [T] {
         F: FnMut(&T) -> K,
         K: Ord,
     {
-        merge_sort(self, |a, b| f(a).lt(&f(b)));
+        stable_sort(self, |a, b| f(a).lt(&f(b)));
     }
 
     /// Sorts the slice with a key extraction function.
@@ -530,7 +465,7 @@ impl<T> [T] {
         hack::into_vec(self)
     }
 
-    /// Creates a vector by repeating a slice `n` times.
+    /// Creates a vector by copying a slice `n` times.
     ///
     /// # Panics
     ///
@@ -725,7 +660,7 @@ impl [u8] {
 ///
 /// ```error
 /// error[E0207]: the type parameter `T` is not constrained by the impl trait, self type, or predica
-///    --> src/liballoc/slice.rs:608:6
+///    --> library/alloc/src/slice.rs:608:6
 ///     |
 /// 608 | impl<T: Clone, V: Borrow<[T]>> Concat for [V] {
 ///     |      ^ unconstrained type parameter
@@ -836,14 +771,14 @@ impl<T: Clone, V: Borrow<[T]>> Join<&[T]> for [V] {
 ////////////////////////////////////////////////////////////////////////////////
 
 #[stable(feature = "rust1", since = "1.0.0")]
-impl<T> Borrow<[T]> for Vec<T> {
+impl<T, A: Allocator> Borrow<[T]> for Vec<T, A> {
     fn borrow(&self) -> &[T] {
         &self[..]
     }
 }
 
 #[stable(feature = "rust1", since = "1.0.0")]
-impl<T> BorrowMut<[T]> for Vec<T> {
+impl<T, A: Allocator> BorrowMut<[T]> for Vec<T, A> {
     fn borrow_mut(&mut self) -> &mut [T] {
         &mut self[..]
     }
@@ -881,324 +816,52 @@ impl<T: Clone> ToOwned for [T] {
 // Sorting
 ////////////////////////////////////////////////////////////////////////////////
 
-/// Inserts `v[0]` into pre-sorted sequence `v[1..]` so that whole `v[..]` becomes sorted.
-///
-/// This is the integral subroutine of insertion sort.
+#[inline]
 #[cfg(not(no_global_oom_handling))]
-fn insert_head<T, F>(v: &mut [T], is_less: &mut F)
+fn stable_sort<T, F>(v: &mut [T], mut is_less: F)
 where
     F: FnMut(&T, &T) -> bool,
 {
-    if v.len() >= 2 && is_less(&v[1], &v[0]) {
-        unsafe {
-            // There are three ways to implement insertion here:
-            //
-            // 1. Swap adjacent elements until the first one gets to its final destination.
-            //    However, this way we copy data around more than is necessary. If elements are big
-            //    structures (costly to copy), this method will be slow.
-            //
-            // 2. Iterate until the right place for the first element is found. Then shift the
-            //    elements succeeding it to make room for it and finally place it into the
-            //    remaining hole. This is a good method.
-            //
-            // 3. Copy the first element into a temporary variable. Iterate until the right place
-            //    for it is found. As we go along, copy every traversed element into the slot
-            //    preceding it. Finally, copy data from the temporary variable into the remaining
-            //    hole. This method is very good. Benchmarks demonstrated slightly better
-            //    performance than with the 2nd method.
-            //
-            // All methods were benchmarked, and the 3rd showed best results. So we chose that one.
-            let tmp = mem::ManuallyDrop::new(ptr::read(&v[0]));
-
-            // Intermediate state of the insertion process is always tracked by `hole`, which
-            // serves two purposes:
-            // 1. Protects integrity of `v` from panics in `is_less`.
-            // 2. Fills the remaining hole in `v` in the end.
-            //
-            // Panic safety:
-            //
-            // If `is_less` panics at any point during the process, `hole` will get dropped and
-            // fill the hole in `v` with `tmp`, thus ensuring that `v` still holds every object it
-            // initially held exactly once.
-            let mut hole = InsertionHole { src: &*tmp, dest: &mut v[1] };
-            ptr::copy_nonoverlapping(&v[1], &mut v[0], 1);
-
-            for i in 2..v.len() {
-                if !is_less(&v[i], &*tmp) {
-                    break;
-                }
-                ptr::copy_nonoverlapping(&v[i], &mut v[i - 1], 1);
-                hole.dest = &mut v[i];
-            }
-            // `hole` gets dropped and thus copies `tmp` into the remaining hole in `v`.
-        }
-    }
-
-    // When dropped, copies from `src` into `dest`.
-    struct InsertionHole<T> {
-        src: *const T,
-        dest: *mut T,
-    }
-
-    impl<T> Drop for InsertionHole<T> {
-        fn drop(&mut self) {
-            unsafe {
-                ptr::copy_nonoverlapping(self.src, self.dest, 1);
-            }
-        }
-    }
-}
-
-/// Merges non-decreasing runs `v[..mid]` and `v[mid..]` using `buf` as temporary storage, and
-/// stores the result into `v[..]`.
-///
-/// # Safety
-///
-/// The two slices must be non-empty and `mid` must be in bounds. Buffer `buf` must be long enough
-/// to hold a copy of the shorter slice. Also, `T` must not be a zero-sized type.
-#[cfg(not(no_global_oom_handling))]
-unsafe fn merge<T, F>(v: &mut [T], mid: usize, buf: *mut T, is_less: &mut F)
-where
-    F: FnMut(&T, &T) -> bool,
-{
-    let len = v.len();
-    let v = v.as_mut_ptr();
-    let (v_mid, v_end) = unsafe { (v.add(mid), v.add(len)) };
-
-    // The merge process first copies the shorter run into `buf`. Then it traces the newly copied
-    // run and the longer run forwards (or backwards), comparing their next unconsumed elements and
-    // copying the lesser (or greater) one into `v`.
-    //
-    // As soon as the shorter run is fully consumed, the process is done. If the longer run gets
-    // consumed first, then we must copy whatever is left of the shorter run into the remaining
-    // hole in `v`.
-    //
-    // Intermediate state of the process is always tracked by `hole`, which serves two purposes:
-    // 1. Protects integrity of `v` from panics in `is_less`.
-    // 2. Fills the remaining hole in `v` if the longer run gets consumed first.
-    //
-    // Panic safety:
-    //
-    // If `is_less` panics at any point during the process, `hole` will get dropped and fill the
-    // hole in `v` with the unconsumed range in `buf`, thus ensuring that `v` still holds every
-    // object it initially held exactly once.
-    let mut hole;
-
-    if mid <= len - mid {
-        // The left run is shorter.
-        unsafe {
-            ptr::copy_nonoverlapping(v, buf, mid);
-            hole = MergeHole { start: buf, end: buf.add(mid), dest: v };
-        }
-
-        // Initially, these pointers point to the beginnings of their arrays.
-        let left = &mut hole.start;
-        let mut right = v_mid;
-        let out = &mut hole.dest;
-
-        while *left < hole.end && right < v_end {
-            // Consume the lesser side.
-            // If equal, prefer the left run to maintain stability.
-            unsafe {
-                let to_copy = if is_less(&*right, &**left) {
-                    get_and_increment(&mut right)
-                } else {
-                    get_and_increment(left)
-                };
-                ptr::copy_nonoverlapping(to_copy, get_and_increment(out), 1);
-            }
-        }
-    } else {
-        // The right run is shorter.
-        unsafe {
-            ptr::copy_nonoverlapping(v_mid, buf, len - mid);
-            hole = MergeHole { start: buf, end: buf.add(len - mid), dest: v_mid };
-        }
-
-        // Initially, these pointers point past the ends of their arrays.
-        let left = &mut hole.dest;
-        let right = &mut hole.end;
-        let mut out = v_end;
-
-        while v < *left && buf < *right {
-            // Consume the greater side.
-            // If equal, prefer the right run to maintain stability.
-            unsafe {
-                let to_copy = if is_less(&*right.offset(-1), &*left.offset(-1)) {
-                    decrement_and_get(left)
-                } else {
-                    decrement_and_get(right)
-                };
-                ptr::copy_nonoverlapping(to_copy, decrement_and_get(&mut out), 1);
-            }
-        }
-    }
-    // Finally, `hole` gets dropped. If the shorter run was not fully consumed, whatever remains of
-    // it will now be copied into the hole in `v`.
-
-    unsafe fn get_and_increment<T>(ptr: &mut *mut T) -> *mut T {
-        let old = *ptr;
-        *ptr = unsafe { ptr.offset(1) };
-        old
-    }
-
-    unsafe fn decrement_and_get<T>(ptr: &mut *mut T) -> *mut T {
-        *ptr = unsafe { ptr.offset(-1) };
-        *ptr
-    }
-
-    // When dropped, copies the range `start..end` into `dest..`.
-    struct MergeHole<T> {
-        start: *mut T,
-        end: *mut T,
-        dest: *mut T,
-    }
-
-    impl<T> Drop for MergeHole<T> {
-        fn drop(&mut self) {
-            // `T` is not a zero-sized type, and these are pointers into a slice's elements.
-            unsafe {
-                let len = self.end.sub_ptr(self.start);
-                ptr::copy_nonoverlapping(self.start, self.dest, len);
-            }
-        }
-    }
-}
-
-/// This merge sort borrows some (but not all) ideas from TimSort, which is described in detail
-/// [here](https://github.com/python/cpython/blob/main/Objects/listsort.txt).
-///
-/// The algorithm identifies strictly descending and non-descending subsequences, which are called
-/// natural runs. There is a stack of pending runs yet to be merged. Each newly found run is pushed
-/// onto the stack, and then some pairs of adjacent runs are merged until these two invariants are
-/// satisfied:
-///
-/// 1. for every `i` in `1..runs.len()`: `runs[i - 1].len > runs[i].len`
-/// 2. for every `i` in `2..runs.len()`: `runs[i - 2].len > runs[i - 1].len + runs[i].len`
-///
-/// The invariants ensure that the total running time is *O*(*n* \* log(*n*)) worst-case.
-#[cfg(not(no_global_oom_handling))]
-fn merge_sort<T, F>(v: &mut [T], mut is_less: F)
-where
-    F: FnMut(&T, &T) -> bool,
-{
-    // Slices of up to this length get sorted using insertion sort.
-    const MAX_INSERTION: usize = 20;
-    // Very short runs are extended using insertion sort to span at least this many elements.
-    const MIN_RUN: usize = 10;
-
-    // Sorting has no meaningful behavior on zero-sized types.
-    if size_of::<T>() == 0 {
+    if T::IS_ZST {
+        // Sorting has no meaningful behavior on zero-sized types. Do nothing.
         return;
     }
 
-    let len = v.len();
+    let elem_alloc_fn = |len: usize| -> *mut T {
+        // SAFETY: Creating the layout is safe as long as merge_sort never calls this with len >
+        // v.len(). Alloc in general will only be used as 'shadow-region' to store temporary swap
+        // elements.
+        unsafe { alloc::alloc(alloc::Layout::array::<T>(len).unwrap_unchecked()) as *mut T }
+    };
 
-    // Short arrays get sorted in-place via insertion sort to avoid allocations.
-    if len <= MAX_INSERTION {
-        if len >= 2 {
-            for i in (0..len - 1).rev() {
-                insert_head(&mut v[i..], &mut is_less);
-            }
+    let elem_dealloc_fn = |buf_ptr: *mut T, len: usize| {
+        // SAFETY: Creating the layout is safe as long as merge_sort never calls this with len >
+        // v.len(). The caller must ensure that buf_ptr was created by elem_alloc_fn with the same
+        // len.
+        unsafe {
+            alloc::dealloc(buf_ptr as *mut u8, alloc::Layout::array::<T>(len).unwrap_unchecked());
         }
-        return;
-    }
+    };
 
-    // Allocate a buffer to use as scratch memory. We keep the length 0 so we can keep in it
-    // shallow copies of the contents of `v` without risking the dtors running on copies if
-    // `is_less` panics. When merging two sorted runs, this buffer holds a copy of the shorter run,
-    // which will always have length at most `len / 2`.
-    let mut buf = Vec::with_capacity(len / 2);
-
-    // In order to identify natural runs in `v`, we traverse it backwards. That might seem like a
-    // strange decision, but consider the fact that merges more often go in the opposite direction
-    // (forwards). According to benchmarks, merging forwards is slightly faster than merging
-    // backwards. To conclude, identifying runs by traversing backwards improves performance.
-    let mut runs = vec![];
-    let mut end = len;
-    while end > 0 {
-        // Find the next natural run, and reverse it if it's strictly descending.
-        let mut start = end - 1;
-        if start > 0 {
-            start -= 1;
-            unsafe {
-                if is_less(v.get_unchecked(start + 1), v.get_unchecked(start)) {
-                    while start > 0 && is_less(v.get_unchecked(start), v.get_unchecked(start - 1)) {
-                        start -= 1;
-                    }
-                    v[start..end].reverse();
-                } else {
-                    while start > 0 && !is_less(v.get_unchecked(start), v.get_unchecked(start - 1))
-                    {
-                        start -= 1;
-                    }
-                }
-            }
+    let run_alloc_fn = |len: usize| -> *mut sort::TimSortRun {
+        // SAFETY: Creating the layout is safe as long as merge_sort never calls this with an
+        // obscene length or 0.
+        unsafe {
+            alloc::alloc(alloc::Layout::array::<sort::TimSortRun>(len).unwrap_unchecked())
+                as *mut sort::TimSortRun
         }
+    };
 
-        // Insert some more elements into the run if it's too short. Insertion sort is faster than
-        // merge sort on short sequences, so this significantly improves performance.
-        while start > 0 && end - start < MIN_RUN {
-            start -= 1;
-            insert_head(&mut v[start..end], &mut is_less);
+    let run_dealloc_fn = |buf_ptr: *mut sort::TimSortRun, len: usize| {
+        // SAFETY: The caller must ensure that buf_ptr was created by elem_alloc_fn with the same
+        // len.
+        unsafe {
+            alloc::dealloc(
+                buf_ptr as *mut u8,
+                alloc::Layout::array::<sort::TimSortRun>(len).unwrap_unchecked(),
+            );
         }
+    };
 
-        // Push this run onto the stack.
-        runs.push(Run { start, len: end - start });
-        end = start;
-
-        // Merge some pairs of adjacent runs to satisfy the invariants.
-        while let Some(r) = collapse(&runs) {
-            let left = runs[r + 1];
-            let right = runs[r];
-            unsafe {
-                merge(
-                    &mut v[left.start..right.start + right.len],
-                    left.len,
-                    buf.as_mut_ptr(),
-                    &mut is_less,
-                );
-            }
-            runs[r] = Run { start: left.start, len: left.len + right.len };
-            runs.remove(r + 1);
-        }
-    }
-
-    // Finally, exactly one run must remain in the stack.
-    debug_assert!(runs.len() == 1 && runs[0].start == 0 && runs[0].len == len);
-
-    // Examines the stack of runs and identifies the next pair of runs to merge. More specifically,
-    // if `Some(r)` is returned, that means `runs[r]` and `runs[r + 1]` must be merged next. If the
-    // algorithm should continue building a new run instead, `None` is returned.
-    //
-    // TimSort is infamous for its buggy implementations, as described here:
-    // http://envisage-project.eu/timsort-specification-and-verification/
-    //
-    // The gist of the story is: we must enforce the invariants on the top four runs on the stack.
-    // Enforcing them on just top three is not sufficient to ensure that the invariants will still
-    // hold for *all* runs in the stack.
-    //
-    // This function correctly checks invariants for the top four runs. Additionally, if the top
-    // run starts at index 0, it will always demand a merge operation until the stack is fully
-    // collapsed, in order to complete the sort.
-    #[inline]
-    fn collapse(runs: &[Run]) -> Option<usize> {
-        let n = runs.len();
-        if n >= 2
-            && (runs[n - 1].start == 0
-                || runs[n - 2].len <= runs[n - 1].len
-                || (n >= 3 && runs[n - 3].len <= runs[n - 2].len + runs[n - 1].len)
-                || (n >= 4 && runs[n - 4].len <= runs[n - 3].len + runs[n - 2].len))
-        {
-            if n >= 3 && runs[n - 3].len < runs[n - 1].len { Some(n - 3) } else { Some(n - 2) }
-        } else {
-            None
-        }
-    }
-
-    #[derive(Clone, Copy)]
-    struct Run {
-        start: usize,
-        len: usize,
-    }
+    sort::merge_sort(v, &mut is_less, elem_alloc_fn, elem_dealloc_fn, run_alloc_fn, run_dealloc_fn);
 }
diff --git a/rust/alloc/vec/drain.rs b/rust/alloc/vec/drain.rs
index b6a5f98e4fcd..d503d2f478ce 100644
--- a/rust/alloc/vec/drain.rs
+++ b/rust/alloc/vec/drain.rs
@@ -3,7 +3,7 @@
 use crate::alloc::{Allocator, Global};
 use core::fmt;
 use core::iter::{FusedIterator, TrustedLen};
-use core::mem;
+use core::mem::{self, ManuallyDrop, SizedTypeProperties};
 use core::ptr::{self, NonNull};
 use core::slice::{self};
 
@@ -67,6 +67,77 @@ impl<'a, T, A: Allocator> Drain<'a, T, A> {
     pub fn allocator(&self) -> &A {
         unsafe { self.vec.as_ref().allocator() }
     }
+
+    /// Keep unyielded elements in the source `Vec`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(drain_keep_rest)]
+    ///
+    /// let mut vec = vec!['a', 'b', 'c'];
+    /// let mut drain = vec.drain(..);
+    ///
+    /// assert_eq!(drain.next().unwrap(), 'a');
+    ///
+    /// // This call keeps 'b' and 'c' in the vec.
+    /// drain.keep_rest();
+    ///
+    /// // If we wouldn't call `keep_rest()`,
+    /// // `vec` would be empty.
+    /// assert_eq!(vec, ['b', 'c']);
+    /// ```
+    #[unstable(feature = "drain_keep_rest", issue = "101122")]
+    pub fn keep_rest(self) {
+        // At this moment layout looks like this:
+        //
+        // [head] [yielded by next] [unyielded] [yielded by next_back] [tail]
+        //        ^-- start         \_________/-- unyielded_len        \____/-- self.tail_len
+        //                          ^-- unyielded_ptr                  ^-- tail
+        //
+        // Normally `Drop` impl would drop [unyielded] and then move [tail] to the `start`.
+        // Here we want to
+        // 1. Move [unyielded] to `start`
+        // 2. Move [tail] to a new start at `start + len(unyielded)`
+        // 3. Update length of the original vec to `len(head) + len(unyielded) + len(tail)`
+        //    a. In case of ZST, this is the only thing we want to do
+        // 4. Do *not* drop self, as everything is put in a consistent state already, there is nothing to do
+        let mut this = ManuallyDrop::new(self);
+
+        unsafe {
+            let source_vec = this.vec.as_mut();
+
+            let start = source_vec.len();
+            let tail = this.tail_start;
+
+            let unyielded_len = this.iter.len();
+            let unyielded_ptr = this.iter.as_slice().as_ptr();
+
+            // ZSTs have no identity, so we don't need to move them around.
+            let needs_move = mem::size_of::<T>() != 0;
+
+            if needs_move {
+                let start_ptr = source_vec.as_mut_ptr().add(start);
+
+                // memmove back unyielded elements
+                if unyielded_ptr != start_ptr {
+                    let src = unyielded_ptr;
+                    let dst = start_ptr;
+
+                    ptr::copy(src, dst, unyielded_len);
+                }
+
+                // memmove back untouched tail
+                if tail != (start + unyielded_len) {
+                    let src = source_vec.as_ptr().add(tail);
+                    let dst = start_ptr.add(unyielded_len);
+                    ptr::copy(src, dst, this.tail_len);
+                }
+            }
+
+            source_vec.set_len(start + unyielded_len + this.tail_len);
+        }
+    }
 }
 
 #[stable(feature = "vec_drain_as_slice", since = "1.46.0")]
@@ -133,7 +204,7 @@ impl<T, A: Allocator> Drop for Drain<'_, T, A> {
 
         let mut vec = self.vec;
 
-        if mem::size_of::<T>() == 0 {
+        if T::IS_ZST {
             // ZSTs have no identity, so we don't need to move them around, we only need to drop the correct amount.
             // this can be achieved by manipulating the Vec length instead of moving values out from `iter`.
             unsafe {
@@ -154,9 +225,9 @@ impl<T, A: Allocator> Drop for Drain<'_, T, A> {
         }
 
         // as_slice() must only be called when iter.len() is > 0 because
-        // vec::Splice modifies vec::Drain fields and may grow the vec which would invalidate
-        // the iterator's internal pointers. Creating a reference to deallocated memory
-        // is invalid even when it is zero-length
+        // it also gets touched by vec::Splice which may turn it into a dangling pointer
+        // which would make it and the vec pointer point to different allocations which would
+        // lead to invalid pointer arithmetic below.
         let drop_ptr = iter.as_slice().as_ptr();
 
         unsafe {
diff --git a/rust/alloc/vec/drain_filter.rs b/rust/alloc/vec/drain_filter.rs
index b04fce041622..4b019220657d 100644
--- a/rust/alloc/vec/drain_filter.rs
+++ b/rust/alloc/vec/drain_filter.rs
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: Apache-2.0 OR MIT
 
 use crate::alloc::{Allocator, Global};
-use core::ptr::{self};
-use core::slice::{self};
+use core::mem::{self, ManuallyDrop};
+use core::ptr;
+use core::slice;
 
 use super::Vec;
 
@@ -56,6 +57,61 @@ where
     pub fn allocator(&self) -> &A {
         self.vec.allocator()
     }
+
+    /// Keep unyielded elements in the source `Vec`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(drain_filter)]
+    /// #![feature(drain_keep_rest)]
+    ///
+    /// let mut vec = vec!['a', 'b', 'c'];
+    /// let mut drain = vec.drain_filter(|_| true);
+    ///
+    /// assert_eq!(drain.next().unwrap(), 'a');
+    ///
+    /// // This call keeps 'b' and 'c' in the vec.
+    /// drain.keep_rest();
+    ///
+    /// // If we wouldn't call `keep_rest()`,
+    /// // `vec` would be empty.
+    /// assert_eq!(vec, ['b', 'c']);
+    /// ```
+    #[unstable(feature = "drain_keep_rest", issue = "101122")]
+    pub fn keep_rest(self) {
+        // At this moment layout looks like this:
+        //
+        //  _____________________/-- old_len
+        // /                     \
+        // [kept] [yielded] [tail]
+        //        \_______/ ^-- idx
+        //                \-- del
+        //
+        // Normally `Drop` impl would drop [tail] (via .for_each(drop), ie still calling `pred`)
+        //
+        // 1. Move [tail] after [kept]
+        // 2. Update length of the original vec to `old_len - del`
+        //    a. In case of ZST, this is the only thing we want to do
+        // 3. Do *not* drop self, as everything is put in a consistent state already, there is nothing to do
+        let mut this = ManuallyDrop::new(self);
+
+        unsafe {
+            // ZSTs have no identity, so we don't need to move them around.
+            let needs_move = mem::size_of::<T>() != 0;
+
+            if needs_move && this.idx < this.old_len && this.del > 0 {
+                let ptr = this.vec.as_mut_ptr();
+                let src = ptr.add(this.idx);
+                let dst = src.sub(this.del);
+                let tail_len = this.old_len - this.idx;
+                src.copy_to(dst, tail_len);
+            }
+
+            let new_len = this.old_len - this.del;
+            this.vec.set_len(new_len);
+        }
+    }
 }
 
 #[unstable(feature = "drain_filter", reason = "recently added", issue = "43244")]
diff --git a/rust/alloc/vec/into_iter.rs b/rust/alloc/vec/into_iter.rs
index f7a50e76691e..34a2a70d6ded 100644
--- a/rust/alloc/vec/into_iter.rs
+++ b/rust/alloc/vec/into_iter.rs
@@ -3,14 +3,16 @@
 #[cfg(not(no_global_oom_handling))]
 use super::AsVecIntoIter;
 use crate::alloc::{Allocator, Global};
+#[cfg(not(no_global_oom_handling))]
+use crate::collections::VecDeque;
 use crate::raw_vec::RawVec;
+use core::array;
 use core::fmt;
-use core::intrinsics::arith_offset;
 use core::iter::{
     FusedIterator, InPlaceIterable, SourceIter, TrustedLen, TrustedRandomAccessNoCoerce,
 };
 use core::marker::PhantomData;
-use core::mem::{self, ManuallyDrop};
+use core::mem::{self, ManuallyDrop, MaybeUninit, SizedTypeProperties};
 #[cfg(not(no_global_oom_handling))]
 use core::ops::Deref;
 use core::ptr::{self, NonNull};
@@ -40,7 +42,9 @@ pub struct IntoIter<
     // to avoid dropping the allocator twice we need to wrap it into ManuallyDrop
     pub(super) alloc: ManuallyDrop<A>,
     pub(super) ptr: *const T,
-    pub(super) end: *const T,
+    pub(super) end: *const T, // If T is a ZST, this is actually ptr+len. This encoding is picked so that
+                              // ptr == end is a quick test for the Iterator being empty, that works
+                              // for both ZST and non-ZST.
 }
 
 #[stable(feature = "vec_intoiter_debug", since = "1.13.0")]
@@ -97,13 +101,16 @@ impl<T, A: Allocator> IntoIter<T, A> {
     }
 
     /// Drops remaining elements and relinquishes the backing allocation.
+    /// This method guarantees it won't panic before relinquishing
+    /// the backing allocation.
     ///
     /// This is roughly equivalent to the following, but more efficient
     ///
     /// ```
     /// # let mut into_iter = Vec::<u8>::with_capacity(10).into_iter();
+    /// let mut into_iter = std::mem::replace(&mut into_iter, Vec::new().into_iter());
     /// (&mut into_iter).for_each(core::mem::drop);
-    /// unsafe { core::ptr::write(&mut into_iter, Vec::new().into_iter()); }
+    /// std::mem::forget(into_iter);
     /// ```
     ///
     /// This method is used by in-place iteration, refer to the vec::in_place_collect
@@ -120,15 +127,45 @@ impl<T, A: Allocator> IntoIter<T, A> {
         self.ptr = self.buf.as_ptr();
         self.end = self.buf.as_ptr();
 
+        // Dropping the remaining elements can panic, so this needs to be
+        // done only after updating the other fields.
         unsafe {
             ptr::drop_in_place(remaining);
         }
     }
 
     /// Forgets to Drop the remaining elements while still allowing the backing allocation to be freed.
-    #[allow(dead_code)]
     pub(crate) fn forget_remaining_elements(&mut self) {
-        self.ptr = self.end;
+        // For th ZST case, it is crucial that we mutate `end` here, not `ptr`.
+        // `ptr` must stay aligned, while `end` may be unaligned.
+        self.end = self.ptr;
+    }
+
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    pub(crate) fn into_vecdeque(self) -> VecDeque<T, A> {
+        // Keep our `Drop` impl from dropping the elements and the allocator
+        let mut this = ManuallyDrop::new(self);
+
+        // SAFETY: This allocation originally came from a `Vec`, so it passes
+        // all those checks. We have `this.buf` ≤ `this.ptr` ≤ `this.end`,
+        // so the `sub_ptr`s below cannot wrap, and will produce a well-formed
+        // range. `end` ≤ `buf + cap`, so the range will be in-bounds.
+        // Taking `alloc` is ok because nothing else is going to look at it,
+        // since our `Drop` impl isn't going to run so there's no more code.
+        unsafe {
+            let buf = this.buf.as_ptr();
+            let initialized = if T::IS_ZST {
+                // All the pointers are the same for ZSTs, so it's fine to
+                // say that they're all at the beginning of the "allocation".
+                0..this.len()
+            } else {
+                this.ptr.sub_ptr(buf)..this.end.sub_ptr(buf)
+            };
+            let cap = this.cap;
+            let alloc = ManuallyDrop::take(&mut this.alloc);
+            VecDeque::from_contiguous_raw_parts_in(buf, initialized, cap, alloc)
+        }
     }
 }
 
@@ -150,19 +187,18 @@ impl<T, A: Allocator> Iterator for IntoIter<T, A> {
 
     #[inline]
     fn next(&mut self) -> Option<T> {
-        if self.ptr as *const _ == self.end {
+        if self.ptr == self.end {
             None
-        } else if mem::size_of::<T>() == 0 {
-            // purposefully don't use 'ptr.offset' because for
-            // vectors with 0-size elements this would return the
-            // same pointer.
-            self.ptr = unsafe { arith_offset(self.ptr as *const i8, 1) as *mut T };
+        } else if T::IS_ZST {
+            // `ptr` has to stay where it is to remain aligned, so we reduce the length by 1 by
+            // reducing the `end`.
+            self.end = self.end.wrapping_byte_sub(1);
 
             // Make up a value of this ZST.
             Some(unsafe { mem::zeroed() })
         } else {
             let old = self.ptr;
-            self.ptr = unsafe { self.ptr.offset(1) };
+            self.ptr = unsafe { self.ptr.add(1) };
 
             Some(unsafe { ptr::read(old) })
         }
@@ -170,7 +206,7 @@ impl<T, A: Allocator> Iterator for IntoIter<T, A> {
 
     #[inline]
     fn size_hint(&self) -> (usize, Option<usize>) {
-        let exact = if mem::size_of::<T>() == 0 {
+        let exact = if T::IS_ZST {
             self.end.addr().wrapping_sub(self.ptr.addr())
         } else {
             unsafe { self.end.sub_ptr(self.ptr) }
@@ -182,11 +218,9 @@ impl<T, A: Allocator> Iterator for IntoIter<T, A> {
     fn advance_by(&mut self, n: usize) -> Result<(), usize> {
         let step_size = self.len().min(n);
         let to_drop = ptr::slice_from_raw_parts_mut(self.ptr as *mut T, step_size);
-        if mem::size_of::<T>() == 0 {
-            // SAFETY: due to unchecked casts of unsigned amounts to signed offsets the wraparound
-            // effectively results in unsigned pointers representing positions 0..usize::MAX,
-            // which is valid for ZSTs.
-            self.ptr = unsafe { arith_offset(self.ptr as *const i8, step_size as isize) as *mut T }
+        if T::IS_ZST {
+            // See `next` for why we sub `end` here.
+            self.end = self.end.wrapping_byte_sub(step_size);
         } else {
             // SAFETY: the min() above ensures that step_size is in bounds
             self.ptr = unsafe { self.ptr.add(step_size) };
@@ -206,6 +240,43 @@ impl<T, A: Allocator> Iterator for IntoIter<T, A> {
         self.len()
     }
 
+    #[inline]
+    fn next_chunk<const N: usize>(&mut self) -> Result<[T; N], core::array::IntoIter<T, N>> {
+        let mut raw_ary = MaybeUninit::uninit_array();
+
+        let len = self.len();
+
+        if T::IS_ZST {
+            if len < N {
+                self.forget_remaining_elements();
+                // Safety: ZSTs can be conjured ex nihilo, only the amount has to be correct
+                return Err(unsafe { array::IntoIter::new_unchecked(raw_ary, 0..len) });
+            }
+
+            self.end = self.end.wrapping_byte_sub(N);
+            // Safety: ditto
+            return Ok(unsafe { raw_ary.transpose().assume_init() });
+        }
+
+        if len < N {
+            // Safety: `len` indicates that this many elements are available and we just checked that
+            // it fits into the array.
+            unsafe {
+                ptr::copy_nonoverlapping(self.ptr, raw_ary.as_mut_ptr() as *mut T, len);
+                self.forget_remaining_elements();
+                return Err(array::IntoIter::new_unchecked(raw_ary, 0..len));
+            }
+        }
+
+        // Safety: `len` is larger than the array size. Copy a fixed amount here to fully initialize
+        // the array.
+        return unsafe {
+            ptr::copy_nonoverlapping(self.ptr, raw_ary.as_mut_ptr() as *mut T, N);
+            self.ptr = self.ptr.add(N);
+            Ok(raw_ary.transpose().assume_init())
+        };
+    }
+
     unsafe fn __iterator_get_unchecked(&mut self, i: usize) -> Self::Item
     where
         Self: TrustedRandomAccessNoCoerce,
@@ -219,7 +290,7 @@ impl<T, A: Allocator> Iterator for IntoIter<T, A> {
         // that `T: Copy` so reading elements from the buffer doesn't invalidate
         // them for `Drop`.
         unsafe {
-            if mem::size_of::<T>() == 0 { mem::zeroed() } else { ptr::read(self.ptr.add(i)) }
+            if T::IS_ZST { mem::zeroed() } else { ptr::read(self.ptr.add(i)) }
         }
     }
 }
@@ -230,14 +301,14 @@ impl<T, A: Allocator> DoubleEndedIterator for IntoIter<T, A> {
     fn next_back(&mut self) -> Option<T> {
         if self.end == self.ptr {
             None
-        } else if mem::size_of::<T>() == 0 {
+        } else if T::IS_ZST {
             // See above for why 'ptr.offset' isn't used
-            self.end = unsafe { arith_offset(self.end as *const i8, -1) as *mut T };
+            self.end = self.end.wrapping_byte_sub(1);
 
             // Make up a value of this ZST.
             Some(unsafe { mem::zeroed() })
         } else {
-            self.end = unsafe { self.end.offset(-1) };
+            self.end = unsafe { self.end.sub(1) };
 
             Some(unsafe { ptr::read(self.end) })
         }
@@ -246,14 +317,12 @@ impl<T, A: Allocator> DoubleEndedIterator for IntoIter<T, A> {
     #[inline]
     fn advance_back_by(&mut self, n: usize) -> Result<(), usize> {
         let step_size = self.len().min(n);
-        if mem::size_of::<T>() == 0 {
+        if T::IS_ZST {
             // SAFETY: same as for advance_by()
-            self.end = unsafe {
-                arith_offset(self.end as *const i8, step_size.wrapping_neg() as isize) as *mut T
-            }
+            self.end = self.end.wrapping_byte_sub(step_size);
         } else {
             // SAFETY: same as for advance_by()
-            self.end = unsafe { self.end.offset(step_size.wrapping_neg() as isize) };
+            self.end = unsafe { self.end.sub(step_size) };
         }
         let to_drop = ptr::slice_from_raw_parts_mut(self.end as *mut T, step_size);
         // SAFETY: same as for advance_by()
diff --git a/rust/alloc/vec/is_zero.rs b/rust/alloc/vec/is_zero.rs
index 377f3d172777..d928dcf90e80 100644
--- a/rust/alloc/vec/is_zero.rs
+++ b/rust/alloc/vec/is_zero.rs
@@ -1,10 +1,13 @@
 // SPDX-License-Identifier: Apache-2.0 OR MIT
 
+use core::num::{Saturating, Wrapping};
+
 use crate::boxed::Box;
 
 #[rustc_specialization_trait]
 pub(super) unsafe trait IsZero {
-    /// Whether this value's representation is all zeros
+    /// Whether this value's representation is all zeros,
+    /// or can be represented with all zeroes.
     fn is_zero(&self) -> bool;
 }
 
@@ -19,12 +22,14 @@ macro_rules! impl_is_zero {
     };
 }
 
+impl_is_zero!(i8, |x| x == 0); // It is needed to impl for arrays and tuples of i8.
 impl_is_zero!(i16, |x| x == 0);
 impl_is_zero!(i32, |x| x == 0);
 impl_is_zero!(i64, |x| x == 0);
 impl_is_zero!(i128, |x| x == 0);
 impl_is_zero!(isize, |x| x == 0);
 
+impl_is_zero!(u8, |x| x == 0); // It is needed to impl for arrays and tuples of u8.
 impl_is_zero!(u16, |x| x == 0);
 impl_is_zero!(u32, |x| x == 0);
 impl_is_zero!(u64, |x| x == 0);
@@ -55,16 +60,42 @@ unsafe impl<T: IsZero, const N: usize> IsZero for [T; N] {
     #[inline]
     fn is_zero(&self) -> bool {
         // Because this is generated as a runtime check, it's not obvious that
-        // it's worth doing if the array is really long.  The threshold here
-        // is largely arbitrary, but was picked because as of 2022-05-01 LLVM
-        // can const-fold the check in `vec![[0; 32]; n]` but not in
-        // `vec![[0; 64]; n]`: https://godbolt.org/z/WTzjzfs5b
+        // it's worth doing if the array is really long. The threshold here
+        // is largely arbitrary, but was picked because as of 2022-07-01 LLVM
+        // fails to const-fold the check in `vec![[1; 32]; n]`
+        // See https://github.com/rust-lang/rust/pull/97581#issuecomment-1166628022
         // Feel free to tweak if you have better evidence.
 
-        N <= 32 && self.iter().all(IsZero::is_zero)
+        N <= 16 && self.iter().all(IsZero::is_zero)
     }
 }
 
+// This is recursive macro.
+macro_rules! impl_for_tuples {
+    // Stopper
+    () => {
+        // No use for implementing for empty tuple because it is ZST.
+    };
+    ($first_arg:ident $(,$rest:ident)*) => {
+        unsafe impl <$first_arg: IsZero, $($rest: IsZero,)*> IsZero for ($first_arg, $($rest,)*){
+            #[inline]
+            fn is_zero(&self) -> bool{
+                // Destructure tuple to N references
+                // Rust allows to hide generic params by local variable names.
+                #[allow(non_snake_case)]
+                let ($first_arg, $($rest,)*) = self;
+
+                $first_arg.is_zero()
+                    $( && $rest.is_zero() )*
+            }
+        }
+
+        impl_for_tuples!($($rest),*);
+    }
+}
+
+impl_for_tuples!(A, B, C, D, E, F, G, H);
+
 // `Option<&T>` and `Option<Box<T>>` are guaranteed to represent `None` as null.
 // For fat pointers, the bytes that would be the pointer metadata in the `Some`
 // variant are padding in the `None` variant, so ignoring them and
@@ -118,3 +149,56 @@ impl_is_zero_option_of_nonzero!(
     NonZeroUsize,
     NonZeroIsize,
 );
+
+macro_rules! impl_is_zero_option_of_num {
+    ($($t:ty,)+) => {$(
+        unsafe impl IsZero for Option<$t> {
+            #[inline]
+            fn is_zero(&self) -> bool {
+                const {
+                    let none: Self = unsafe { core::mem::MaybeUninit::zeroed().assume_init() };
+                    assert!(none.is_none());
+                }
+                self.is_none()
+            }
+        }
+    )+};
+}
+
+impl_is_zero_option_of_num!(u8, u16, u32, u64, u128, i8, i16, i32, i64, i128, usize, isize,);
+
+unsafe impl<T: IsZero> IsZero for Wrapping<T> {
+    #[inline]
+    fn is_zero(&self) -> bool {
+        self.0.is_zero()
+    }
+}
+
+unsafe impl<T: IsZero> IsZero for Saturating<T> {
+    #[inline]
+    fn is_zero(&self) -> bool {
+        self.0.is_zero()
+    }
+}
+
+macro_rules! impl_for_optional_bool {
+    ($($t:ty,)+) => {$(
+        unsafe impl IsZero for $t {
+            #[inline]
+            fn is_zero(&self) -> bool {
+                // SAFETY: This is *not* a stable layout guarantee, but
+                // inside `core` we're allowed to rely on the current rustc
+                // behaviour that options of bools will be one byte with
+                // no padding, so long as they're nested less than 254 deep.
+                let raw: u8 = unsafe { core::mem::transmute(*self) };
+                raw == 0
+            }
+        }
+    )+};
+}
+impl_for_optional_bool! {
+    Option<bool>,
+    Option<Option<bool>>,
+    Option<Option<Option<bool>>>,
+    // Could go further, but not worth the metadata overhead
+}
diff --git a/rust/alloc/vec/mod.rs b/rust/alloc/vec/mod.rs
index fe4fff5064bc..94995913566b 100644
--- a/rust/alloc/vec/mod.rs
+++ b/rust/alloc/vec/mod.rs
@@ -61,12 +61,12 @@ use core::cmp::Ordering;
 use core::convert::TryFrom;
 use core::fmt;
 use core::hash::{Hash, Hasher};
-use core::intrinsics::{arith_offset, assume};
+use core::intrinsics::assume;
 use core::iter;
 #[cfg(not(no_global_oom_handling))]
 use core::iter::FromIterator;
 use core::marker::PhantomData;
-use core::mem::{self, ManuallyDrop, MaybeUninit};
+use core::mem::{self, ManuallyDrop, MaybeUninit, SizedTypeProperties};
 use core::ops::{self, Index, IndexMut, Range, RangeBounds};
 use core::ptr::{self, NonNull};
 use core::slice::{self, SliceIndex};
@@ -75,7 +75,7 @@ use crate::alloc::{Allocator, Global};
 #[cfg(not(no_borrow))]
 use crate::borrow::{Cow, ToOwned};
 use crate::boxed::Box;
-use crate::collections::TryReserveError;
+use crate::collections::{TryReserveError, TryReserveErrorKind};
 use crate::raw_vec::RawVec;
 
 #[unstable(feature = "drain_filter", reason = "recently added", issue = "43244")]
@@ -127,7 +127,7 @@ use self::set_len_on_drop::SetLenOnDrop;
 mod set_len_on_drop;
 
 #[cfg(not(no_global_oom_handling))]
-use self::in_place_drop::InPlaceDrop;
+use self::in_place_drop::{InPlaceDrop, InPlaceDstBufDrop};
 
 #[cfg(not(no_global_oom_handling))]
 mod in_place_drop;
@@ -169,7 +169,7 @@ mod spec_extend;
 /// vec[0] = 7;
 /// assert_eq!(vec[0], 7);
 ///
-/// vec.extend([1, 2, 3].iter().copied());
+/// vec.extend([1, 2, 3]);
 ///
 /// for x in &vec {
 ///     println!("{x}");
@@ -428,17 +428,25 @@ impl<T> Vec<T> {
         Vec { buf: RawVec::NEW, len: 0 }
     }
 
-    /// Constructs a new, empty `Vec<T>` with the specified capacity.
+    /// Constructs a new, empty `Vec<T>` with at least the specified capacity.
     ///
-    /// The vector will be able to hold exactly `capacity` elements without
-    /// reallocating. If `capacity` is 0, the vector will not allocate.
+    /// The vector will be able to hold at least `capacity` elements without
+    /// reallocating. This method is allowed to allocate for more elements than
+    /// `capacity`. If `capacity` is 0, the vector will not allocate.
     ///
     /// It is important to note that although the returned vector has the
-    /// *capacity* specified, the vector will have a zero *length*. For an
-    /// explanation of the difference between length and capacity, see
+    /// minimum *capacity* specified, the vector will have a zero *length*. For
+    /// an explanation of the difference between length and capacity, see
     /// *[Capacity and reallocation]*.
     ///
+    /// If it is important to know the exact allocated capacity of a `Vec`,
+    /// always use the [`capacity`] method after construction.
+    ///
+    /// For `Vec<T>` where `T` is a zero-sized type, there will be no allocation
+    /// and the capacity will always be `usize::MAX`.
+    ///
     /// [Capacity and reallocation]: #capacity-and-reallocation
+    /// [`capacity`]: Vec::capacity
     ///
     /// # Panics
     ///
@@ -451,19 +459,24 @@ impl<T> Vec<T> {
     ///
     /// // The vector contains no items, even though it has capacity for more
     /// assert_eq!(vec.len(), 0);
-    /// assert_eq!(vec.capacity(), 10);
+    /// assert!(vec.capacity() >= 10);
     ///
     /// // These are all done without reallocating...
     /// for i in 0..10 {
     ///     vec.push(i);
     /// }
     /// assert_eq!(vec.len(), 10);
-    /// assert_eq!(vec.capacity(), 10);
+    /// assert!(vec.capacity() >= 10);
     ///
     /// // ...but this may make the vector reallocate
     /// vec.push(11);
     /// assert_eq!(vec.len(), 11);
     /// assert!(vec.capacity() >= 11);
+    ///
+    /// // A vector of a zero-sized type will always over-allocate, since no
+    /// // allocation is necessary
+    /// let vec_units = Vec::<()>::with_capacity(10);
+    /// assert_eq!(vec_units.capacity(), usize::MAX);
     /// ```
     #[cfg(not(no_global_oom_handling))]
     #[inline]
@@ -473,17 +486,25 @@ impl<T> Vec<T> {
         Self::with_capacity_in(capacity, Global)
     }
 
-    /// Tries to construct a new, empty `Vec<T>` with the specified capacity.
+    /// Tries to construct a new, empty `Vec<T>` with at least the specified capacity.
     ///
-    /// The vector will be able to hold exactly `capacity` elements without
-    /// reallocating. If `capacity` is 0, the vector will not allocate.
+    /// The vector will be able to hold at least `capacity` elements without
+    /// reallocating. This method is allowed to allocate for more elements than
+    /// `capacity`. If `capacity` is 0, the vector will not allocate.
     ///
     /// It is important to note that although the returned vector has the
-    /// *capacity* specified, the vector will have a zero *length*. For an
-    /// explanation of the difference between length and capacity, see
+    /// minimum *capacity* specified, the vector will have a zero *length*. For
+    /// an explanation of the difference between length and capacity, see
     /// *[Capacity and reallocation]*.
     ///
+    /// If it is important to know the exact allocated capacity of a `Vec`,
+    /// always use the [`capacity`] method after construction.
+    ///
+    /// For `Vec<T>` where `T` is a zero-sized type, there will be no allocation
+    /// and the capacity will always be `usize::MAX`.
+    ///
     /// [Capacity and reallocation]: #capacity-and-reallocation
+    /// [`capacity`]: Vec::capacity
     ///
     /// # Examples
     ///
@@ -492,14 +513,14 @@ impl<T> Vec<T> {
     ///
     /// // The vector contains no items, even though it has capacity for more
     /// assert_eq!(vec.len(), 0);
-    /// assert_eq!(vec.capacity(), 10);
+    /// assert!(vec.capacity() >= 10);
     ///
     /// // These are all done without reallocating...
     /// for i in 0..10 {
     ///     vec.push(i);
     /// }
     /// assert_eq!(vec.len(), 10);
-    /// assert_eq!(vec.capacity(), 10);
+    /// assert!(vec.capacity() >= 10);
     ///
     /// // ...but this may make the vector reallocate
     /// vec.push(11);
@@ -508,6 +529,11 @@ impl<T> Vec<T> {
     ///
     /// let mut result = Vec::try_with_capacity(usize::MAX);
     /// assert!(result.is_err());
+    ///
+    /// // A vector of a zero-sized type will always over-allocate, since no
+    /// // allocation is necessary
+    /// let vec_units = Vec::<()>::try_with_capacity(10).unwrap();
+    /// assert_eq!(vec_units.capacity(), usize::MAX);
     /// ```
     #[inline]
     #[stable(feature = "kernel", since = "1.0.0")]
@@ -515,15 +541,15 @@ impl<T> Vec<T> {
         Self::try_with_capacity_in(capacity, Global)
     }
 
-    /// Creates a `Vec<T>` directly from the raw components of another vector.
+    /// Creates a `Vec<T>` directly from a pointer, a capacity, and a length.
     ///
     /// # Safety
     ///
     /// This is highly unsafe, due to the number of invariants that aren't
     /// checked:
     ///
-    /// * `ptr` needs to have been previously allocated via [`String`]/`Vec<T>`
-    ///   (at least, it's highly likely to be incorrect if it wasn't).
+    /// * `ptr` must have been allocated using the global allocator, such as via
+    ///   the [`alloc::alloc`] function.
     /// * `T` needs to have the same alignment as what `ptr` was allocated with.
     ///   (`T` having a less strict alignment is not sufficient, the alignment really
     ///   needs to be equal to satisfy the [`dealloc`] requirement that memory must be
@@ -532,6 +558,14 @@ impl<T> Vec<T> {
     ///   to be the same size as the pointer was allocated with. (Because similar to
     ///   alignment, [`dealloc`] must be called with the same layout `size`.)
     /// * `length` needs to be less than or equal to `capacity`.
+    /// * The first `length` values must be properly initialized values of type `T`.
+    /// * `capacity` needs to be the capacity that the pointer was allocated with.
+    /// * The allocated size in bytes must be no larger than `isize::MAX`.
+    ///   See the safety documentation of [`pointer::offset`].
+    ///
+    /// These requirements are always upheld by any `ptr` that has been allocated
+    /// via `Vec<T>`. Other allocation sources are allowed if the invariants are
+    /// upheld.
     ///
     /// Violating these may cause problems like corrupting the allocator's
     /// internal data structures. For example it is normally **not** safe
@@ -552,6 +586,7 @@ impl<T> Vec<T> {
     /// function.
     ///
     /// [`String`]: crate::string::String
+    /// [`alloc::alloc`]: crate::alloc::alloc
     /// [`dealloc`]: crate::alloc::GlobalAlloc::dealloc
     ///
     /// # Examples
@@ -574,8 +609,8 @@ impl<T> Vec<T> {
     ///
     /// unsafe {
     ///     // Overwrite memory with 4, 5, 6
-    ///     for i in 0..len as isize {
-    ///         ptr::write(p.offset(i), 4 + i);
+    ///     for i in 0..len {
+    ///         ptr::write(p.add(i), 4 + i);
     ///     }
     ///
     ///     // Put everything back together into a Vec
@@ -583,6 +618,32 @@ impl<T> Vec<T> {
     ///     assert_eq!(rebuilt, [4, 5, 6]);
     /// }
     /// ```
+    ///
+    /// Using memory that was allocated elsewhere:
+    ///
+    /// ```rust
+    /// #![feature(allocator_api)]
+    ///
+    /// use std::alloc::{AllocError, Allocator, Global, Layout};
+    ///
+    /// fn main() {
+    ///     let layout = Layout::array::<u32>(16).expect("overflow cannot happen");
+    ///
+    ///     let vec = unsafe {
+    ///         let mem = match Global.allocate(layout) {
+    ///             Ok(mem) => mem.cast::<u32>().as_ptr(),
+    ///             Err(AllocError) => return,
+    ///         };
+    ///
+    ///         mem.write(1_000_000);
+    ///
+    ///         Vec::from_raw_parts_in(mem, 1, 16, Global)
+    ///     };
+    ///
+    ///     assert_eq!(vec, &[1_000_000]);
+    ///     assert_eq!(vec.capacity(), 16);
+    /// }
+    /// ```
     #[inline]
     #[stable(feature = "rust1", since = "1.0.0")]
     pub unsafe fn from_raw_parts(ptr: *mut T, length: usize, capacity: usize) -> Self {
@@ -611,18 +672,26 @@ impl<T, A: Allocator> Vec<T, A> {
         Vec { buf: RawVec::new_in(alloc), len: 0 }
     }
 
-    /// Constructs a new, empty `Vec<T, A>` with the specified capacity with the provided
-    /// allocator.
+    /// Constructs a new, empty `Vec<T, A>` with at least the specified capacity
+    /// with the provided allocator.
     ///
-    /// The vector will be able to hold exactly `capacity` elements without
-    /// reallocating. If `capacity` is 0, the vector will not allocate.
+    /// The vector will be able to hold at least `capacity` elements without
+    /// reallocating. This method is allowed to allocate for more elements than
+    /// `capacity`. If `capacity` is 0, the vector will not allocate.
     ///
     /// It is important to note that although the returned vector has the
-    /// *capacity* specified, the vector will have a zero *length*. For an
-    /// explanation of the difference between length and capacity, see
+    /// minimum *capacity* specified, the vector will have a zero *length*. For
+    /// an explanation of the difference between length and capacity, see
     /// *[Capacity and reallocation]*.
     ///
+    /// If it is important to know the exact allocated capacity of a `Vec`,
+    /// always use the [`capacity`] method after construction.
+    ///
+    /// For `Vec<T, A>` where `T` is a zero-sized type, there will be no allocation
+    /// and the capacity will always be `usize::MAX`.
+    ///
     /// [Capacity and reallocation]: #capacity-and-reallocation
+    /// [`capacity`]: Vec::capacity
     ///
     /// # Panics
     ///
@@ -652,6 +721,11 @@ impl<T, A: Allocator> Vec<T, A> {
     /// vec.push(11);
     /// assert_eq!(vec.len(), 11);
     /// assert!(vec.capacity() >= 11);
+    ///
+    /// // A vector of a zero-sized type will always over-allocate, since no
+    /// // allocation is necessary
+    /// let vec_units = Vec::<(), System>::with_capacity_in(10, System);
+    /// assert_eq!(vec_units.capacity(), usize::MAX);
     /// ```
     #[cfg(not(no_global_oom_handling))]
     #[inline]
@@ -660,18 +734,26 @@ impl<T, A: Allocator> Vec<T, A> {
         Vec { buf: RawVec::with_capacity_in(capacity, alloc), len: 0 }
     }
 
-    /// Tries to construct a new, empty `Vec<T, A>` with the specified capacity
+    /// Tries to construct a new, empty `Vec<T, A>` with at least the specified capacity
     /// with the provided allocator.
     ///
-    /// The vector will be able to hold exactly `capacity` elements without
-    /// reallocating. If `capacity` is 0, the vector will not allocate.
+    /// The vector will be able to hold at least `capacity` elements without
+    /// reallocating. This method is allowed to allocate for more elements than
+    /// `capacity`. If `capacity` is 0, the vector will not allocate.
     ///
     /// It is important to note that although the returned vector has the
-    /// *capacity* specified, the vector will have a zero *length*. For an
-    /// explanation of the difference between length and capacity, see
+    /// minimum *capacity* specified, the vector will have a zero *length*. For
+    /// an explanation of the difference between length and capacity, see
     /// *[Capacity and reallocation]*.
     ///
+    /// If it is important to know the exact allocated capacity of a `Vec`,
+    /// always use the [`capacity`] method after construction.
+    ///
+    /// For `Vec<T, A>` where `T` is a zero-sized type, there will be no allocation
+    /// and the capacity will always be `usize::MAX`.
+    ///
     /// [Capacity and reallocation]: #capacity-and-reallocation
+    /// [`capacity`]: Vec::capacity
     ///
     /// # Examples
     ///
@@ -700,6 +782,11 @@ impl<T, A: Allocator> Vec<T, A> {
     ///
     /// let mut result = Vec::try_with_capacity_in(usize::MAX, System);
     /// assert!(result.is_err());
+    ///
+    /// // A vector of a zero-sized type will always over-allocate, since no
+    /// // allocation is necessary
+    /// let vec_units = Vec::<(), System>::try_with_capacity_in(10, System).unwrap();
+    /// assert_eq!(vec_units.capacity(), usize::MAX);
     /// ```
     #[inline]
     #[stable(feature = "kernel", since = "1.0.0")]
@@ -707,21 +794,31 @@ impl<T, A: Allocator> Vec<T, A> {
         Ok(Vec { buf: RawVec::try_with_capacity_in(capacity, alloc)?, len: 0 })
     }
 
-    /// Creates a `Vec<T, A>` directly from the raw components of another vector.
+    /// Creates a `Vec<T, A>` directly from a pointer, a capacity, a length,
+    /// and an allocator.
     ///
     /// # Safety
     ///
     /// This is highly unsafe, due to the number of invariants that aren't
     /// checked:
     ///
-    /// * `ptr` needs to have been previously allocated via [`String`]/`Vec<T>`
-    ///   (at least, it's highly likely to be incorrect if it wasn't).
-    /// * `T` needs to have the same size and alignment as what `ptr` was allocated with.
+    /// * `ptr` must be [*currently allocated*] via the given allocator `alloc`.
+    /// * `T` needs to have the same alignment as what `ptr` was allocated with.
     ///   (`T` having a less strict alignment is not sufficient, the alignment really
     ///   needs to be equal to satisfy the [`dealloc`] requirement that memory must be
     ///   allocated and deallocated with the same layout.)
+    /// * The size of `T` times the `capacity` (ie. the allocated size in bytes) needs
+    ///   to be the same size as the pointer was allocated with. (Because similar to
+    ///   alignment, [`dealloc`] must be called with the same layout `size`.)
     /// * `length` needs to be less than or equal to `capacity`.
-    /// * `capacity` needs to be the capacity that the pointer was allocated with.
+    /// * The first `length` values must be properly initialized values of type `T`.
+    /// * `capacity` needs to [*fit*] the layout size that the pointer was allocated with.
+    /// * The allocated size in bytes must be no larger than `isize::MAX`.
+    ///   See the safety documentation of [`pointer::offset`].
+    ///
+    /// These requirements are always upheld by any `ptr` that has been allocated
+    /// via `Vec<T, A>`. Other allocation sources are allowed if the invariants are
+    /// upheld.
     ///
     /// Violating these may cause problems like corrupting the allocator's
     /// internal data structures. For example it is **not** safe
@@ -739,6 +836,8 @@ impl<T, A: Allocator> Vec<T, A> {
     ///
     /// [`String`]: crate::string::String
     /// [`dealloc`]: crate::alloc::GlobalAlloc::dealloc
+    /// [*currently allocated*]: crate::alloc::Allocator#currently-allocated-memory
+    /// [*fit*]: crate::alloc::Allocator#memory-fitting
     ///
     /// # Examples
     ///
@@ -768,8 +867,8 @@ impl<T, A: Allocator> Vec<T, A> {
     ///
     /// unsafe {
     ///     // Overwrite memory with 4, 5, 6
-    ///     for i in 0..len as isize {
-    ///         ptr::write(p.offset(i), 4 + i);
+    ///     for i in 0..len {
+    ///         ptr::write(p.add(i), 4 + i);
     ///     }
     ///
     ///     // Put everything back together into a Vec
@@ -777,6 +876,29 @@ impl<T, A: Allocator> Vec<T, A> {
     ///     assert_eq!(rebuilt, [4, 5, 6]);
     /// }
     /// ```
+    ///
+    /// Using memory that was allocated elsewhere:
+    ///
+    /// ```rust
+    /// use std::alloc::{alloc, Layout};
+    ///
+    /// fn main() {
+    ///     let layout = Layout::array::<u32>(16).expect("overflow cannot happen");
+    ///     let vec = unsafe {
+    ///         let mem = alloc(layout).cast::<u32>();
+    ///         if mem.is_null() {
+    ///             return;
+    ///         }
+    ///
+    ///         mem.write(1_000_000);
+    ///
+    ///         Vec::from_raw_parts(mem, 1, 16)
+    ///     };
+    ///
+    ///     assert_eq!(vec, &[1_000_000]);
+    ///     assert_eq!(vec.capacity(), 16);
+    /// }
+    /// ```
     #[inline]
     #[unstable(feature = "allocator_api", issue = "32838")]
     pub unsafe fn from_raw_parts_in(ptr: *mut T, length: usize, capacity: usize, alloc: A) -> Self {
@@ -869,13 +991,14 @@ impl<T, A: Allocator> Vec<T, A> {
         (ptr, len, capacity, alloc)
     }
 
-    /// Returns the number of elements the vector can hold without
+    /// Returns the total number of elements the vector can hold without
     /// reallocating.
     ///
     /// # Examples
     ///
     /// ```
-    /// let vec: Vec<i32> = Vec::with_capacity(10);
+    /// let mut vec: Vec<i32> = Vec::with_capacity(10);
+    /// vec.push(42);
     /// assert_eq!(vec.capacity(), 10);
     /// ```
     #[inline]
@@ -885,10 +1008,10 @@ impl<T, A: Allocator> Vec<T, A> {
     }
 
     /// Reserves capacity for at least `additional` more elements to be inserted
-    /// in the given `Vec<T>`. The collection may reserve more space to avoid
-    /// frequent reallocations. After calling `reserve`, capacity will be
-    /// greater than or equal to `self.len() + additional`. Does nothing if
-    /// capacity is already sufficient.
+    /// in the given `Vec<T>`. The collection may reserve more space to
+    /// speculatively avoid frequent reallocations. After calling `reserve`,
+    /// capacity will be greater than or equal to `self.len() + additional`.
+    /// Does nothing if capacity is already sufficient.
     ///
     /// # Panics
     ///
@@ -907,10 +1030,12 @@ impl<T, A: Allocator> Vec<T, A> {
         self.buf.reserve(self.len, additional);
     }
 
-    /// Reserves the minimum capacity for exactly `additional` more elements to
-    /// be inserted in the given `Vec<T>`. After calling `reserve_exact`,
-    /// capacity will be greater than or equal to `self.len() + additional`.
-    /// Does nothing if the capacity is already sufficient.
+    /// Reserves the minimum capacity for at least `additional` more elements to
+    /// be inserted in the given `Vec<T>`. Unlike [`reserve`], this will not
+    /// deliberately over-allocate to speculatively avoid frequent allocations.
+    /// After calling `reserve_exact`, capacity will be greater than or equal to
+    /// `self.len() + additional`. Does nothing if the capacity is already
+    /// sufficient.
     ///
     /// Note that the allocator may give the collection more space than it
     /// requests. Therefore, capacity can not be relied upon to be precisely
@@ -936,10 +1061,11 @@ impl<T, A: Allocator> Vec<T, A> {
     }
 
     /// Tries to reserve capacity for at least `additional` more elements to be inserted
-    /// in the given `Vec<T>`. The collection may reserve more space to avoid
+    /// in the given `Vec<T>`. The collection may reserve more space to speculatively avoid
     /// frequent reallocations. After calling `try_reserve`, capacity will be
-    /// greater than or equal to `self.len() + additional`. Does nothing if
-    /// capacity is already sufficient.
+    /// greater than or equal to `self.len() + additional` if it returns
+    /// `Ok(())`. Does nothing if capacity is already sufficient. This method
+    /// preserves the contents even if an error occurs.
     ///
     /// # Errors
     ///
@@ -971,10 +1097,11 @@ impl<T, A: Allocator> Vec<T, A> {
         self.buf.try_reserve(self.len, additional)
     }
 
-    /// Tries to reserve the minimum capacity for exactly `additional`
-    /// elements to be inserted in the given `Vec<T>`. After calling
-    /// `try_reserve_exact`, capacity will be greater than or equal to
-    /// `self.len() + additional` if it returns `Ok(())`.
+    /// Tries to reserve the minimum capacity for at least `additional`
+    /// elements to be inserted in the given `Vec<T>`. Unlike [`try_reserve`],
+    /// this will not deliberately over-allocate to speculatively avoid frequent
+    /// allocations. After calling `try_reserve_exact`, capacity will be greater
+    /// than or equal to `self.len() + additional` if it returns `Ok(())`.
     /// Does nothing if the capacity is already sufficient.
     ///
     /// Note that the allocator may give the collection more space than it
@@ -1066,7 +1193,8 @@ impl<T, A: Allocator> Vec<T, A> {
 
     /// Converts the vector into [`Box<[T]>`][owned slice].
     ///
-    /// Note that this will drop any excess capacity.
+    /// If the vector has excess capacity, its items will be moved into a
+    /// newly-allocated buffer with exactly the right capacity.
     ///
     /// [owned slice]: Box
     ///
@@ -1199,7 +1327,8 @@ impl<T, A: Allocator> Vec<T, A> {
         self
     }
 
-    /// Returns a raw pointer to the vector's buffer.
+    /// Returns a raw pointer to the vector's buffer, or a dangling raw pointer
+    /// valid for zero sized reads if the vector didn't allocate.
     ///
     /// The caller must ensure that the vector outlives the pointer this
     /// function returns, or else it will end up pointing to garbage.
@@ -1236,7 +1365,8 @@ impl<T, A: Allocator> Vec<T, A> {
         ptr
     }
 
-    /// Returns an unsafe mutable pointer to the vector's buffer.
+    /// Returns an unsafe mutable pointer to the vector's buffer, or a dangling
+    /// raw pointer valid for zero sized reads if the vector didn't allocate.
     ///
     /// The caller must ensure that the vector outlives the pointer this
     /// function returns, or else it will end up pointing to garbage.
@@ -1440,9 +1570,6 @@ impl<T, A: Allocator> Vec<T, A> {
         }
 
         let len = self.len();
-        if index > len {
-            assert_failed(index, len);
-        }
 
         // space for the new element
         if len == self.buf.capacity() {
@@ -1454,9 +1581,15 @@ impl<T, A: Allocator> Vec<T, A> {
             // The spot to put the new value
             {
                 let p = self.as_mut_ptr().add(index);
-                // Shift everything over to make space. (Duplicating the
-                // `index`th element into two consecutive places.)
-                ptr::copy(p, p.offset(1), len - index);
+                if index < len {
+                    // Shift everything over to make space. (Duplicating the
+                    // `index`th element into two consecutive places.)
+                    ptr::copy(p, p.add(1), len - index);
+                } else if index == len {
+                    // No elements need shifting.
+                } else {
+                    assert_failed(index, len);
+                }
                 // Write it in, overwriting the first copy of the `index`th
                 // element.
                 ptr::write(p, element);
@@ -1513,7 +1646,7 @@ impl<T, A: Allocator> Vec<T, A> {
                 ret = ptr::read(ptr);
 
                 // Shift everything down to fill in that spot.
-                ptr::copy(ptr.offset(1), ptr, len - index - 1);
+                ptr::copy(ptr.add(1), ptr, len - index - 1);
             }
             self.set_len(len - 1);
             ret
@@ -1562,11 +1695,11 @@ impl<T, A: Allocator> Vec<T, A> {
     ///
     /// ```
     /// let mut vec = vec![1, 2, 3, 4];
-    /// vec.retain_mut(|x| if *x > 3 {
-    ///     false
-    /// } else {
+    /// vec.retain_mut(|x| if *x <= 3 {
     ///     *x += 1;
     ///     true
+    /// } else {
+    ///     false
     /// });
     /// assert_eq!(vec, [2, 3, 4]);
     /// ```
@@ -1854,6 +1987,51 @@ impl<T, A: Allocator> Vec<T, A> {
         Ok(())
     }
 
+    /// Appends an element if there is sufficient spare capacity, otherwise an error is returned
+    /// with the element.
+    ///
+    /// Unlike [`push`] this method will not reallocate when there's insufficient capacity.
+    /// The caller should use [`reserve`] or [`try_reserve`] to ensure that there is enough capacity.
+    ///
+    /// [`push`]: Vec::push
+    /// [`reserve`]: Vec::reserve
+    /// [`try_reserve`]: Vec::try_reserve
+    ///
+    /// # Examples
+    ///
+    /// A manual, panic-free alternative to [`FromIterator`]:
+    ///
+    /// ```
+    /// #![feature(vec_push_within_capacity)]
+    ///
+    /// use std::collections::TryReserveError;
+    /// fn from_iter_fallible<T>(iter: impl Iterator<Item=T>) -> Result<Vec<T>, TryReserveError> {
+    ///     let mut vec = Vec::new();
+    ///     for value in iter {
+    ///         if let Err(value) = vec.push_within_capacity(value) {
+    ///             vec.try_reserve(1)?;
+    ///             // this cannot fail, the previous line either returned or added at least 1 free slot
+    ///             let _ = vec.push_within_capacity(value);
+    ///         }
+    ///     }
+    ///     Ok(vec)
+    /// }
+    /// assert_eq!(from_iter_fallible(0..100), Ok(Vec::from_iter(0..100)));
+    /// ```
+    #[inline]
+    #[unstable(feature = "vec_push_within_capacity", issue = "100486")]
+    pub fn push_within_capacity(&mut self, value: T) -> Result<(), T> {
+        if self.len == self.buf.capacity() {
+            return Err(value);
+        }
+        unsafe {
+            let end = self.as_mut_ptr().add(self.len);
+            ptr::write(end, value);
+            self.len += 1;
+        }
+        Ok(())
+    }
+
     /// Removes the last element from a vector and returns it, or [`None`] if it
     /// is empty.
     ///
@@ -1886,7 +2064,7 @@ impl<T, A: Allocator> Vec<T, A> {
     ///
     /// # Panics
     ///
-    /// Panics if the number of elements in the vector overflows a `usize`.
+    /// Panics if the new capacity exceeds `isize::MAX` bytes.
     ///
     /// # Examples
     ///
@@ -1980,9 +2158,7 @@ impl<T, A: Allocator> Vec<T, A> {
         unsafe {
             // set self.vec length's to start, to be safe in case Drain is leaked
             self.set_len(start);
-            // Use the borrow in the IterMut to indicate borrowing behavior of the
-            // whole Drain iterator (like &mut T).
-            let range_slice = slice::from_raw_parts_mut(self.as_mut_ptr().add(start), end - start);
+            let range_slice = slice::from_raw_parts(self.as_ptr().add(start), end - start);
             Drain {
                 tail_start: end,
                 tail_len: len - end,
@@ -2145,7 +2321,7 @@ impl<T, A: Allocator> Vec<T, A> {
     {
         let len = self.len();
         if new_len > len {
-            self.extend_with(new_len - len, ExtendFunc(f));
+            self.extend_trusted(iter::repeat_with(f).take(new_len - len));
         } else {
             self.truncate(new_len);
         }
@@ -2174,7 +2350,6 @@ impl<T, A: Allocator> Vec<T, A> {
     /// static_ref[0] += 1;
     /// assert_eq!(static_ref, &[2, 2, 3]);
     /// ```
-    #[cfg(not(no_global_oom_handling))]
     #[stable(feature = "vec_leak", since = "1.47.0")]
     #[inline]
     pub fn leak<'a>(self) -> &'a mut [T]
@@ -2469,7 +2644,7 @@ impl<T: Clone, A: Allocator> Vec<T, A> {
         self.reserve(range.len());
 
         // SAFETY:
-        // - `slice::range` guarantees  that the given range is valid for indexing self
+        // - `slice::range` guarantees that the given range is valid for indexing self
         unsafe {
             self.spec_extend_from_within(range);
         }
@@ -2501,7 +2676,7 @@ impl<T, A: Allocator, const N: usize> Vec<[T; N], A> {
     #[unstable(feature = "slice_flatten", issue = "95629")]
     pub fn into_flattened(self) -> Vec<T, A> {
         let (ptr, len, cap, alloc) = self.into_raw_parts_with_alloc();
-        let (new_len, new_cap) = if mem::size_of::<T>() == 0 {
+        let (new_len, new_cap) = if T::IS_ZST {
             (len.checked_mul(N).expect("vec len overflow"), usize::MAX)
         } else {
             // SAFETY:
@@ -2537,16 +2712,6 @@ impl<T: Clone> ExtendWith<T> for ExtendElement<T> {
     }
 }
 
-struct ExtendFunc<F>(F);
-impl<T, F: FnMut() -> T> ExtendWith<T> for ExtendFunc<F> {
-    fn next(&mut self) -> T {
-        (self.0)()
-    }
-    fn last(mut self) -> T {
-        (self.0)()
-    }
-}
-
 impl<T, A: Allocator> Vec<T, A> {
     #[cfg(not(no_global_oom_handling))]
     /// Extend the vector by `n` values, using the given generator.
@@ -2563,7 +2728,7 @@ impl<T, A: Allocator> Vec<T, A> {
             // Write all elements except the last one
             for _ in 1..n {
                 ptr::write(ptr, value.next());
-                ptr = ptr.offset(1);
+                ptr = ptr.add(1);
                 // Increment the length in every step in case next() panics
                 local_len.increment_len(1);
             }
@@ -2592,7 +2757,7 @@ impl<T, A: Allocator> Vec<T, A> {
             // Write all elements except the last one
             for _ in 1..n {
                 ptr::write(ptr, value.next());
-                ptr = ptr.offset(1);
+                ptr = ptr.add(1);
                 // Increment the length in every step in case next() panics
                 local_len.increment_len(1);
             }
@@ -2664,7 +2829,7 @@ impl<T: Clone, A: Allocator> ExtendFromWithinSpec for Vec<T, A> {
         let (this, spare, len) = unsafe { self.split_at_spare_mut_with_len() };
 
         // SAFETY:
-        // - caller guaratees that src is a valid index
+        // - caller guarantees that src is a valid index
         let to_clone = unsafe { this.get_unchecked(src) };
 
         iter::zip(to_clone, spare)
@@ -2683,13 +2848,13 @@ impl<T: Copy, A: Allocator> ExtendFromWithinSpec for Vec<T, A> {
             let (init, spare) = self.split_at_spare_mut();
 
             // SAFETY:
-            // - caller guaratees that `src` is a valid index
+            // - caller guarantees that `src` is a valid index
             let source = unsafe { init.get_unchecked(src) };
 
             // SAFETY:
             // - Both pointers are created from unique slice references (`&mut [_]`)
             //   so they are valid and do not overlap.
-            // - Elements are :Copy so it's OK to to copy them, without doing
+            // - Elements are :Copy so it's OK to copy them, without doing
             //   anything with the original values
             // - `count` is equal to the len of `source`, so source is valid for
             //   `count` reads
@@ -2712,6 +2877,7 @@ impl<T: Copy, A: Allocator> ExtendFromWithinSpec for Vec<T, A> {
 impl<T, A: Allocator> ops::Deref for Vec<T, A> {
     type Target = [T];
 
+    #[inline]
     fn deref(&self) -> &[T] {
         unsafe { slice::from_raw_parts(self.as_ptr(), self.len) }
     }
@@ -2719,6 +2885,7 @@ impl<T, A: Allocator> ops::Deref for Vec<T, A> {
 
 #[stable(feature = "rust1", since = "1.0.0")]
 impl<T, A: Allocator> ops::DerefMut for Vec<T, A> {
+    #[inline]
     fn deref_mut(&mut self) -> &mut [T] {
         unsafe { slice::from_raw_parts_mut(self.as_mut_ptr(), self.len) }
     }
@@ -2764,7 +2931,7 @@ impl<T: Clone, A: Allocator + Clone> Clone for Vec<T, A> {
 
     // HACK(japaric): with cfg(test) the inherent `[T]::to_vec` method, which is
     // required for this method definition, is not available. Instead use the
-    // `slice::to_vec`  function which is only available with cfg(test)
+    // `slice::to_vec` function which is only available with cfg(test)
     // NB see the slice::hack module in slice.rs for more information
     #[cfg(test)]
     fn clone(&self) -> Self {
@@ -2845,19 +3012,22 @@ impl<T, A: Allocator> IntoIterator for Vec<T, A> {
     ///
     /// ```
     /// let v = vec!["a".to_string(), "b".to_string()];
-    /// for s in v.into_iter() {
-    ///     // s has type String, not &String
-    ///     println!("{s}");
-    /// }
+    /// let mut v_iter = v.into_iter();
+    ///
+    /// let first_element: Option<String> = v_iter.next();
+    ///
+    /// assert_eq!(first_element, Some("a".to_string()));
+    /// assert_eq!(v_iter.next(), Some("b".to_string()));
+    /// assert_eq!(v_iter.next(), None);
     /// ```
     #[inline]
-    fn into_iter(self) -> IntoIter<T, A> {
+    fn into_iter(self) -> Self::IntoIter {
         unsafe {
             let mut me = ManuallyDrop::new(self);
             let alloc = ManuallyDrop::new(ptr::read(me.allocator()));
             let begin = me.as_mut_ptr();
-            let end = if mem::size_of::<T>() == 0 {
-                arith_offset(begin as *const i8, me.len() as isize) as *const T
+            let end = if T::IS_ZST {
+                begin.wrapping_byte_add(me.len())
             } else {
                 begin.add(me.len()) as *const T
             };
@@ -2879,7 +3049,7 @@ impl<'a, T, A: Allocator> IntoIterator for &'a Vec<T, A> {
     type Item = &'a T;
     type IntoIter = slice::Iter<'a, T>;
 
-    fn into_iter(self) -> slice::Iter<'a, T> {
+    fn into_iter(self) -> Self::IntoIter {
         self.iter()
     }
 }
@@ -2889,7 +3059,7 @@ impl<'a, T, A: Allocator> IntoIterator for &'a mut Vec<T, A> {
     type Item = &'a mut T;
     type IntoIter = slice::IterMut<'a, T>;
 
-    fn into_iter(self) -> slice::IterMut<'a, T> {
+    fn into_iter(self) -> Self::IntoIter {
         self.iter_mut()
     }
 }
@@ -2969,6 +3139,69 @@ impl<T, A: Allocator> Vec<T, A> {
         Ok(())
     }
 
+    // specific extend for `TrustedLen` iterators, called both by the specializations
+    // and internal places where resolving specialization makes compilation slower
+    #[cfg(not(no_global_oom_handling))]
+    fn extend_trusted(&mut self, iterator: impl iter::TrustedLen<Item = T>) {
+        let (low, high) = iterator.size_hint();
+        if let Some(additional) = high {
+            debug_assert_eq!(
+                low,
+                additional,
+                "TrustedLen iterator's size hint is not exact: {:?}",
+                (low, high)
+            );
+            self.reserve(additional);
+            unsafe {
+                let ptr = self.as_mut_ptr();
+                let mut local_len = SetLenOnDrop::new(&mut self.len);
+                iterator.for_each(move |element| {
+                    ptr::write(ptr.add(local_len.current_len()), element);
+                    // Since the loop executes user code which can panic we have to update
+                    // the length every step to correctly drop what we've written.
+                    // NB can't overflow since we would have had to alloc the address space
+                    local_len.increment_len(1);
+                });
+            }
+        } else {
+            // Per TrustedLen contract a `None` upper bound means that the iterator length
+            // truly exceeds usize::MAX, which would eventually lead to a capacity overflow anyway.
+            // Since the other branch already panics eagerly (via `reserve()`) we do the same here.
+            // This avoids additional codegen for a fallback code path which would eventually
+            // panic anyway.
+            panic!("capacity overflow");
+        }
+    }
+
+    // specific extend for `TrustedLen` iterators, called both by the specializations
+    // and internal places where resolving specialization makes compilation slower
+    fn try_extend_trusted(&mut self, iterator: impl iter::TrustedLen<Item = T>) -> Result<(), TryReserveError> {
+        let (low, high) = iterator.size_hint();
+        if let Some(additional) = high {
+            debug_assert_eq!(
+                low,
+                additional,
+                "TrustedLen iterator's size hint is not exact: {:?}",
+                (low, high)
+            );
+            self.try_reserve(additional)?;
+            unsafe {
+                let ptr = self.as_mut_ptr();
+                let mut local_len = SetLenOnDrop::new(&mut self.len);
+                iterator.for_each(move |element| {
+                    ptr::write(ptr.add(local_len.current_len()), element);
+                    // Since the loop executes user code which can panic we have to update
+                    // the length every step to correctly drop what we've written.
+                    // NB can't overflow since we would have had to alloc the address space
+                    local_len.increment_len(1);
+                });
+            }
+            Ok(())
+        } else {
+            Err(TryReserveErrorKind::CapacityOverflow.into())
+        }
+    }
+
     /// Creates a splicing iterator that replaces the specified range in the vector
     /// with the given `replace_with` iterator and yields the removed items.
     /// `replace_with` does not need to be the same length as `range`.
@@ -3135,6 +3368,8 @@ unsafe impl<#[may_dangle] T, A: Allocator> Drop for Vec<T, A> {
 #[rustc_const_unstable(feature = "const_default_impls", issue = "87864")]
 impl<T> const Default for Vec<T> {
     /// Creates an empty `Vec<T>`.
+    ///
+    /// The vector will not allocate until elements are pushed onto it.
     fn default() -> Vec<T> {
         Vec::new()
     }
@@ -3227,12 +3462,15 @@ impl<T, const N: usize> From<[T; N]> for Vec<T> {
     /// ```
     #[cfg(not(test))]
     fn from(s: [T; N]) -> Vec<T> {
-        <[T]>::into_vec(box s)
+        <[T]>::into_vec(
+            #[rustc_box]
+            Box::new(s),
+        )
     }
 
     #[cfg(test)]
     fn from(s: [T; N]) -> Vec<T> {
-        crate::slice::into_vec(box s)
+        crate::slice::into_vec(Box::new(s))
     }
 }
 
@@ -3261,7 +3499,7 @@ where
     }
 }
 
-// note: test pulls in libstd, which causes errors here
+// note: test pulls in std, which causes errors here
 #[cfg(not(test))]
 #[stable(feature = "vec_from_box", since = "1.18.0")]
 impl<T, A: Allocator> From<Box<[T], A>> for Vec<T, A> {
@@ -3279,7 +3517,7 @@ impl<T, A: Allocator> From<Box<[T], A>> for Vec<T, A> {
     }
 }
 
-// note: test pulls in libstd, which causes errors here
+// note: test pulls in std, which causes errors here
 #[cfg(not(no_global_oom_handling))]
 #[cfg(not(test))]
 #[stable(feature = "box_from_vec", since = "1.20.0")]
@@ -3294,6 +3532,14 @@ impl<T, A: Allocator> From<Vec<T, A>> for Box<[T], A> {
     /// ```
     /// assert_eq!(Box::from(vec![1, 2, 3]), vec![1, 2, 3].into_boxed_slice());
     /// ```
+    ///
+    /// Any excess capacity is removed:
+    /// ```
+    /// let mut vec = Vec::with_capacity(10);
+    /// vec.extend([1, 2, 3]);
+    ///
+    /// assert_eq!(Box::from(vec), vec![1, 2, 3].into_boxed_slice());
+    /// ```
     fn from(v: Vec<T, A>) -> Self {
         v.into_boxed_slice()
     }
diff --git a/rust/alloc/vec/set_len_on_drop.rs b/rust/alloc/vec/set_len_on_drop.rs
index 448bf5076a0b..d3c7297b80ec 100644
--- a/rust/alloc/vec/set_len_on_drop.rs
+++ b/rust/alloc/vec/set_len_on_drop.rs
@@ -20,6 +20,11 @@ impl<'a> SetLenOnDrop<'a> {
     pub(super) fn increment_len(&mut self, increment: usize) {
         self.local_len += increment;
     }
+
+    #[inline]
+    pub(super) fn current_len(&self) -> usize {
+        self.local_len
+    }
 }
 
 impl Drop for SetLenOnDrop<'_> {
diff --git a/rust/alloc/vec/spec_extend.rs b/rust/alloc/vec/spec_extend.rs
index 5ce2d00991bc..a6a735201e59 100644
--- a/rust/alloc/vec/spec_extend.rs
+++ b/rust/alloc/vec/spec_extend.rs
@@ -1,12 +1,11 @@
 // SPDX-License-Identifier: Apache-2.0 OR MIT
 
 use crate::alloc::Allocator;
-use crate::collections::{TryReserveError, TryReserveErrorKind};
+use crate::collections::TryReserveError;
 use core::iter::TrustedLen;
-use core::ptr::{self};
 use core::slice::{self};
 
-use super::{IntoIter, SetLenOnDrop, Vec};
+use super::{IntoIter, Vec};
 
 // Specialization trait used for Vec::extend
 #[cfg(not(no_global_oom_handling))]
@@ -44,36 +43,7 @@ where
     I: TrustedLen<Item = T>,
 {
     default fn spec_extend(&mut self, iterator: I) {
-        // This is the case for a TrustedLen iterator.
-        let (low, high) = iterator.size_hint();
-        if let Some(additional) = high {
-            debug_assert_eq!(
-                low,
-                additional,
-                "TrustedLen iterator's size hint is not exact: {:?}",
-                (low, high)
-            );
-            self.reserve(additional);
-            unsafe {
-                let mut ptr = self.as_mut_ptr().add(self.len());
-                let mut local_len = SetLenOnDrop::new(&mut self.len);
-                iterator.for_each(move |element| {
-                    ptr::write(ptr, element);
-                    ptr = ptr.offset(1);
-                    // Since the loop executes user code which can panic we have to bump the pointer
-                    // after each step.
-                    // NB can't overflow since we would have had to alloc the address space
-                    local_len.increment_len(1);
-                });
-            }
-        } else {
-            // Per TrustedLen contract a `None` upper bound means that the iterator length
-            // truly exceeds usize::MAX, which would eventually lead to a capacity overflow anyway.
-            // Since the other branch already panics eagerly (via `reserve()`) we do the same here.
-            // This avoids additional codegen for a fallback code path which would eventually
-            // panic anyway.
-            panic!("capacity overflow");
-        }
+        self.extend_trusted(iterator)
     }
 }
 
@@ -82,32 +52,7 @@ where
     I: TrustedLen<Item = T>,
 {
     default fn try_spec_extend(&mut self, iterator: I) -> Result<(), TryReserveError> {
-        // This is the case for a TrustedLen iterator.
-        let (low, high) = iterator.size_hint();
-        if let Some(additional) = high {
-            debug_assert_eq!(
-                low,
-                additional,
-                "TrustedLen iterator's size hint is not exact: {:?}",
-                (low, high)
-            );
-            self.try_reserve(additional)?;
-            unsafe {
-                let mut ptr = self.as_mut_ptr().add(self.len());
-                let mut local_len = SetLenOnDrop::new(&mut self.len);
-                iterator.for_each(move |element| {
-                    ptr::write(ptr, element);
-                    ptr = ptr.offset(1);
-                    // Since the loop executes user code which can panic we have to bump the pointer
-                    // after each step.
-                    // NB can't overflow since we would have had to alloc the address space
-                    local_len.increment_len(1);
-                });
-            }
-            Ok(())
-        } else {
-            Err(TryReserveErrorKind::CapacityOverflow.into())
-        }
+        self.try_extend_trusted(iterator)
     }
 }
 
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 7b246454e009..9bcbea04dac3 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -9,7 +9,6 @@
 //! using this crate.
 
 #![no_std]
-#![feature(core_ffi_c)]
 // See <https://github.com/rust-lang/rust-bindgen/issues/1651>.
 #![cfg_attr(test, allow(deref_nullptr))]
 #![cfg_attr(test, allow(unaligned_references))]
diff --git a/rust/kernel/build_assert.rs b/rust/kernel/build_assert.rs
index 659542393c09..9e37120bc69c 100644
--- a/rust/kernel/build_assert.rs
+++ b/rust/kernel/build_assert.rs
@@ -67,6 +67,8 @@ macro_rules! build_error {
 ///     assert!(n > 1); // Run-time check
 /// }
 /// ```
+///
+/// [`static_assert!`]: crate::static_assert!
 #[macro_export]
 macro_rules! build_assert {
     ($cond:expr $(,)?) => {{
diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index a1298c8bbda0..3013985838ee 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -197,6 +197,7 @@
 //! [`Opaque`]: kernel::types::Opaque
 //! [`Opaque::ffi_init`]: kernel::types::Opaque::ffi_init
 //! [`pin_data`]: ::macros::pin_data
+//! [`pin_init!`]: crate::pin_init!
 
 use crate::{
     error::{self, Error},
@@ -255,6 +256,8 @@ pub mod macros;
 /// A normal `let` binding with optional type annotation. The expression is expected to implement
 /// [`PinInit`]/[`Init`] with the error type [`Infallible`]. If you want to use a different error
 /// type, then use [`stack_try_pin_init!`].
+///
+/// [`stack_try_pin_init!`]: crate::stack_try_pin_init!
 #[macro_export]
 macro_rules! stack_pin_init {
     (let $var:ident $(: $t:ty)? = $val:expr) => {
@@ -804,6 +807,8 @@ macro_rules! try_pin_init {
 ///
 /// This initializer is for initializing data in-place that might later be moved. If you want to
 /// pin-initialize, use [`pin_init!`].
+///
+/// [`try_init!`]: crate::try_init!
 // For a detailed example of how this macro works, see the module documentation of the hidden
 // module `__internal` inside of `init/__internal.rs`.
 #[macro_export]
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 2d7606135ef6..f58596c3d816 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -14,12 +14,8 @@
 #![no_std]
 #![feature(allocator_api)]
 #![feature(coerce_unsized)]
-#![feature(core_ffi_c)]
 #![feature(dispatch_from_dyn)]
-#![feature(explicit_generic_args_with_impl_trait)]
-#![feature(generic_associated_types)]
 #![feature(new_uninit)]
-#![feature(pin_macro)]
 #![feature(receiver_trait)]
 #![feature(unsize)]
 
diff --git a/rust/kernel/std_vendor.rs b/rust/kernel/std_vendor.rs
index b3e68b24a8c6..388d6a5147a2 100644
--- a/rust/kernel/std_vendor.rs
+++ b/rust/kernel/std_vendor.rs
@@ -137,6 +137,8 @@
 /// [`std::dbg`]: https://doc.rust-lang.org/std/macro.dbg.html
 /// [`eprintln`]: https://doc.rust-lang.org/std/macro.eprintln.html
 /// [`printk`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html
+/// [`pr_info`]: crate::pr_info!
+/// [`pr_debug`]: crate::pr_debug!
 #[macro_export]
 macro_rules! dbg {
     // NOTE: We cannot use `concat!` to make a static string as a format argument
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 9f94fc83f086..78175231c969 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -277,7 +277,7 @@ $(obj)/%.lst: $(src)/%.c FORCE
 # Compile Rust sources (.rs)
 # ---------------------------------------------------------------------------
 
-rust_allowed_features := core_ffi_c,explicit_generic_args_with_impl_trait,new_uninit,pin_macro
+rust_allowed_features := new_uninit
 
 rust_common_cmd = \
 	RUST_MODFILE=$(modfile) $(RUSTC_OR_CLIPPY) $(rust_flags) \
diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index 20d483ec6f5f..131be76d2130 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -27,7 +27,7 @@ llvm)
 	fi
 	;;
 rustc)
-	echo 1.62.0
+	echo 1.68.2
 	;;
 bindgen)
 	echo 0.56.0
-- 
2.40.0

