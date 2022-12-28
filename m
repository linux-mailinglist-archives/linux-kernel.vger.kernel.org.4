Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BFB657305
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 07:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiL1GEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 01:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiL1GEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 01:04:38 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01337DEFD;
        Tue, 27 Dec 2022 22:04:36 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h16so14046839wrz.12;
        Tue, 27 Dec 2022 22:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gRIFFRiWtKhehgMZp5r2SWnueOlS4dTgUKCwXFukHZk=;
        b=AphQNvib3d7n3b7NiAUKifYkeUSItHpgkIzA5zXVf6T64S2O/FLo2wG2knvFLrtvr5
         3jx+RIDnT8Eko3zxpuxKn+6c4jCPWpIUpy0ga49EGt4C9clKJACj6GBihfHFbCCH1I1F
         2+I+VfT6RDAu0UmGn8gDxB9+xcEUoFY5FekqUtZ+bJpF2rIt2IOc642gBuMAezKwp3L1
         0Wh8L4Cm3N34GHg6PP4qt2nNan9jDkNQOd22RCcQ88DQBaOjR6EShT48ya2FKIB9bOWi
         TZulVhLvzAbhv8hVE7kZbesL+ORkY3EQc1UruKPTKlyEO/MmjV3FirFOtAAOPoHbkCYN
         uYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRIFFRiWtKhehgMZp5r2SWnueOlS4dTgUKCwXFukHZk=;
        b=tlHWyI4E6zHjnx667fLmO7Nim3GhI+Kk6N+7t9Um11nqplqdYKS/IyOEvHaeFPWfnP
         clNiAstY9B6VBn5iNPk8uFlzUq8WsSoj4y/Umx1DVMOh6yqrTy0by4lL1iF6VAu5LToe
         1/F4FPz6wVws4hb+N7Ch4WHv81gudTOj85doO9CtntwBkQ7jGyZMU92y19t8KNmeUpY0
         +yn5cf2jipBPf5cqQfDQ72fLGBbS+5jUlyJIh3DMRNw8srnQLS7lyuvU/MuWrSraLTN1
         RujZjzj3qfvIjsP+c/d+LeHGf3ClWWvynzqTweNnOTTfjELYwoRAzlgqmYfJQivduc6F
         1Pow==
X-Gm-Message-State: AFqh2kpHjEkB3RxVIkGTOI/c3HXBCtVGhof/Bs1bG9wisoOR2o/UZ5N2
        wt+f+ixL3GWME8rO8KwHz9kULaOv0fQcxg==
X-Google-Smtp-Source: AMrXdXusoaCy8q6KNZXpqTWvFnvzLEniwouvxB3cd2C8FDiLtJcpAKcq/xxWDOE3rMnnLjkFbUUpVQ==
X-Received: by 2002:a5d:6104:0:b0:280:cc12:286d with SMTP id v4-20020a5d6104000000b00280cc12286dmr4105974wrt.67.1672207475343;
        Tue, 27 Dec 2022 22:04:35 -0800 (PST)
Received: from wedsonaf-dev.. ([81.2.152.129])
        by smtp.googlemail.com with ESMTPSA id x16-20020a5d6510000000b002755e301eeasm12128867wru.100.2022.12.27.22.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 22:04:34 -0800 (PST)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/7] rust: sync: add `Arc` for ref-counted allocations
Date:   Wed, 28 Dec 2022 06:03:40 +0000
Message-Id: <20221228060346.352362-1-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a basic implementation of `Arc` backed by C's `refcount_t`. It
allows Rust code to idiomatically allocate memory that is ref-counted.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/bindings/lib.rs            |   1 +
 rust/helpers.c                  |  19 ++++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/sync.rs             |  10 ++
 rust/kernel/sync/arc.rs         | 157 ++++++++++++++++++++++++++++++++
 6 files changed, 189 insertions(+)
 create mode 100644 rust/kernel/sync.rs
 create mode 100644 rust/kernel/sync/arc.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index c48bc284214a..75d85bd6c592 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -7,6 +7,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/refcount.h>
 
 /* `bindgen` gets confused at certain things. */
 const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 6c50ee62c56b..7b246454e009 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -41,6 +41,7 @@ mod bindings_raw {
 #[allow(dead_code)]
 mod bindings_helper {
     // Import the generated bindings for types.
+    use super::bindings_raw::*;
     include!(concat!(
         env!("OBJTREE"),
         "/rust/bindings/bindings_helpers_generated.rs"
diff --git a/rust/helpers.c b/rust/helpers.c
index b4f15eee2ffd..09a4d93f9d62 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -20,6 +20,7 @@
 
 #include <linux/bug.h>
 #include <linux/build_bug.h>
+#include <linux/refcount.h>
 
 __noreturn void rust_helper_BUG(void)
 {
@@ -27,6 +28,24 @@ __noreturn void rust_helper_BUG(void)
 }
 EXPORT_SYMBOL_GPL(rust_helper_BUG);
 
+refcount_t rust_helper_REFCOUNT_INIT(int n)
+{
+	return (refcount_t)REFCOUNT_INIT(n);
+}
+EXPORT_SYMBOL_GPL(rust_helper_REFCOUNT_INIT);
+
+void rust_helper_refcount_inc(refcount_t *r)
+{
+	refcount_inc(r);
+}
+EXPORT_SYMBOL_GPL(rust_helper_refcount_inc);
+
+bool rust_helper_refcount_dec_and_test(refcount_t *r)
+{
+	return refcount_dec_and_test(r);
+}
+EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
+
 /*
  * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
  * as the Rust `usize` type, so we can use it in contexts where Rust
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 53040fa9e897..ace064a3702a 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -31,6 +31,7 @@ mod static_assert;
 #[doc(hidden)]
 pub mod std_vendor;
 pub mod str;
+pub mod sync;
 pub mod types;
 
 #[doc(hidden)]
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
new file mode 100644
index 000000000000..39b379dd548f
--- /dev/null
+++ b/rust/kernel/sync.rs
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Synchronisation primitives.
+//!
+//! This module contains the kernel APIs related to synchronisation that have been ported or
+//! wrapped for usage by Rust code in the kernel.
+
+mod arc;
+
+pub use arc::Arc;
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
new file mode 100644
index 000000000000..22290eb5ab9b
--- /dev/null
+++ b/rust/kernel/sync/arc.rs
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A reference-counted pointer.
+//!
+//! This module implements a way for users to create reference-counted objects and pointers to
+//! them. Such a pointer automatically increments and decrements the count, and drops the
+//! underlying object when it reaches zero. It is also safe to use concurrently from multiple
+//! threads.
+//!
+//! It is different from the standard library's [`Arc`] in a few ways:
+//! 1. It is backed by the kernel's `refcount_t` type.
+//! 2. It does not support weak references, which allows it to be half the size.
+//! 3. It saturates the reference count instead of aborting when it goes over a threshold.
+//! 4. It does not provide a `get_mut` method, so the ref counted object is pinned.
+//!
+//! [`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
+
+use crate::{bindings, error::Result, types::Opaque};
+use alloc::boxed::Box;
+use core::{marker::PhantomData, ops::Deref, ptr::NonNull};
+
+/// A reference-counted pointer to an instance of `T`.
+///
+/// The reference count is incremented when new instances of [`Arc`] are created, and decremented
+/// when they are dropped. When the count reaches zero, the underlying `T` is also dropped.
+///
+/// # Invariants
+///
+/// The reference count on an instance of [`Arc`] is always non-zero.
+/// The object pointed to by [`Arc`] is always pinned.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::sync::Arc;
+///
+/// struct Example {
+///     a: u32,
+///     b: u32,
+/// }
+///
+/// // Create a ref-counted instance of `Example`.
+/// let obj = Arc::try_new(Example { a: 10, b: 20 })?;
+///
+/// // Get a new pointer to `obj` and increment the refcount.
+/// let cloned = obj.clone();
+///
+/// // Assert that both `obj` and `cloned` point to the same underlying object.
+/// assert!(core::ptr::eq(&*obj, &*cloned));
+///
+/// // Destroy `obj` and decrement its refcount.
+/// drop(obj);
+///
+/// // Check that the values are still accessible through `cloned`.
+/// assert_eq!(cloned.a, 10);
+/// assert_eq!(cloned.b, 20);
+///
+/// // The refcount drops to zero when `cloned` goes out of scope, and the memory is freed.
+/// ```
+pub struct Arc<T: ?Sized> {
+    ptr: NonNull<ArcInner<T>>,
+    _p: PhantomData<ArcInner<T>>,
+}
+
+#[repr(C)]
+struct ArcInner<T: ?Sized> {
+    refcount: Opaque<bindings::refcount_t>,
+    data: T,
+}
+
+// SAFETY: It is safe to send `Arc<T>` to another thread when the underlying `T` is `Sync` because
+// it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
+// `T` to be `Send` because any thread that has an `Arc<T>` may ultimately access `T` directly, for
+// example, when the reference count reaches zero and `T` is dropped.
+unsafe impl<T: ?Sized + Sync + Send> Send for Arc<T> {}
+
+// SAFETY: It is safe to send `&Arc<T>` to another thread when the underlying `T` is `Sync` for the
+// same reason as above. `T` needs to be `Send` as well because a thread can clone an `&Arc<T>`
+// into an `Arc<T>`, which may lead to `T` being accessed by the same reasoning as above.
+unsafe impl<T: ?Sized + Sync + Send> Sync for Arc<T> {}
+
+impl<T> Arc<T> {
+    /// Constructs a new reference counted instance of `T`.
+    pub fn try_new(contents: T) -> Result<Self> {
+        // INVARIANT: The refcount is initialised to a non-zero value.
+        let value = ArcInner {
+            // SAFETY: There are no safety requirements for this FFI call.
+            refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
+            data: contents,
+        };
+
+        let inner = Box::try_new(value)?;
+
+        // SAFETY: We just created `inner` with a reference count of 1, which is owned by the new
+        // `Arc` object.
+        Ok(unsafe { Self::from_inner(Box::leak(inner).into()) })
+    }
+}
+
+impl<T: ?Sized> Arc<T> {
+    /// Constructs a new [`Arc`] from an existing [`ArcInner`].
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `inner` points to a valid location and has a non-zero reference
+    /// count, one of which will be owned by the new [`Arc`] instance.
+    unsafe fn from_inner(inner: NonNull<ArcInner<T>>) -> Self {
+        // INVARIANT: By the safety requirements, the invariants hold.
+        Arc {
+            ptr: inner,
+            _p: PhantomData,
+        }
+    }
+}
+
+impl<T: ?Sized> Deref for Arc<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
+        // safe to dereference it.
+        unsafe { &self.ptr.as_ref().data }
+    }
+}
+
+impl<T: ?Sized> Clone for Arc<T> {
+    fn clone(&self) -> Self {
+        // INVARIANT: C `refcount_inc` saturates the refcount, so it cannot overflow to zero.
+        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
+        // safe to increment the refcount.
+        unsafe { bindings::refcount_inc(self.ptr.as_ref().refcount.get()) };
+
+        // SAFETY: We just incremented the refcount. This increment is now owned by the new `Arc`.
+        unsafe { Self::from_inner(self.ptr) }
+    }
+}
+
+impl<T: ?Sized> Drop for Arc<T> {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariant, there is necessarily a reference to the object. We cannot
+        // touch `refcount` after it's decremented to a non-zero value because another thread/CPU
+        // may concurrently decrement it to zero and free it. It is ok to have a raw pointer to
+        // freed/invalid memory as long as it is never dereferenced.
+        let refcount = unsafe { self.ptr.as_ref() }.refcount.get();
+
+        // INVARIANT: If the refcount reaches zero, there are no other instances of `Arc`, and
+        // this instance is being dropped, so the broken invariant is not observable.
+        // SAFETY: Also by the type invariant, we are allowed to decrement the refcount.
+        let is_zero = unsafe { bindings::refcount_dec_and_test(refcount) };
+        if is_zero {
+            // The count reached zero, we must free the memory.
+            //
+            // SAFETY: The pointer was initialised from the result of `Box::leak`.
+            unsafe { Box::from_raw(self.ptr.as_ptr()) };
+        }
+    }
+}
-- 
2.34.1

