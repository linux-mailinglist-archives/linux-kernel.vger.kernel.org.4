Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F27E6A1B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 12:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjBXLpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 06:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjBXLpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 06:45:00 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE5D63A3B;
        Fri, 24 Feb 2023 03:44:57 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id F35A83FA55;
        Fri, 24 Feb 2023 11:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677239095;
        bh=KPYLb9h8eIZES6W78qPQAobPR6eULudvczx882aSyPE=;
        h=From:Date:Subject:To:Cc;
        b=hFcVE07thv9rTiqpidbiR1aSc39JeaIJADRggtPxIaXtUsrzWN/fBMWBO6/tDe+Se
         sr39EYZmPKsL+DbrV+xVPIoOUR838n/SizNeLeoZCCMmBm3Lf/1dE4IgG76+MWnopx
         v27oU7sr+fk65j1AvN52Xob878StmQILQAI1o74z2O7FTfhuPlh1y5kX8KUyk3FEHq
         FF6Ghmm6dmna5EvdOyLVDgvsA94zLEWoL1EgtU5nWxQlaoKYueaeS9qoodNNFdH2lj
         iUwzRht00vQOKgr1UPEpwaLeUUrD//cGoc/tFGz7YNfo5wRS+p1xDLLyg9PsN2P9Oc
         n6fHg3mhnfWZA==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 24 Feb 2023 20:44:19 +0900
Subject: [PATCH] rust: xarray: Add an abstraction for XArray
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-xarray-v1-1-80f0904ce5d3@asahilina.net>
X-B4-Tracking: v=1; b=H4sIABKj+GMC/x2NMQ7CMBAEvxJdzQnj2AV8BVGcw5m4cdAeREFR/
 o6TcjQ72pVMUdTo1q0EnYuVqTa4nDoaRqkv5fJsTN753nkfGF/78CKA/DhH1+erxhCjUiuSmHK
 C1GHcmxTOx1qBCbt/Q3NZjrf7Y9v+XB4xQH0AAAA=
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Neal Gompa <neal@gompa.dev>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, asahi@lists.linux.dev,
        Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677239091; l=16901;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=KPYLb9h8eIZES6W78qPQAobPR6eULudvczx882aSyPE=;
 b=oZemL1ASzJEdoeJOVeU6COeq7829hqyk1aQQyMqp6QdLbuDUS/nsFI+4o7uNEZvdo6epNnJ+D
 nfqTVNlKfRKBNdE8IPUJAawwyf95vo1xUDgDNb7OCCSv3BgrkcC0d18
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=Qn8jZuOtR1m5GaiDfTrAoQ4NE1XoYVZ/wmt5YtXWFC4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XArray is an abstract data type which behaves like a very large
array of pointers. Add a Rust abstraction for this data type.

The initial implementation uses explicit locking on get operations and
returns a guard which blocks mutation, ensuring that the referenced
object remains alive. To avoid excessive serialization, users are
expected to use an inner type that can be efficiently cloned (such as
Arc<T>), and eagerly clone and drop the guard to unblock other users
after a lookup.

Future variants may support using RCU instead to avoid mutex locking.

This abstraction also introduces a reservation mechanism, which can be
used by alloc-capable XArrays to reserve a free slot without immediately
filling it, and then do so at a later time. If the reservation is
dropped without being filled, the slot is freed again for other users,
which eliminates the need for explicit cleanup code.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---

Hi everyone!

This abstraction is part of the set of dependencies for the drm/asahi
Apple M1/M2 GPU driver.

The branch at [1] contains the full series of patches rebased on
upstream leading to the complete driver, for reference on how it is
intended to be used.

Thank you everyone who helped review this on GitHub [2]! I hope I didn't
forget any CCs...

Note that I dropped the convenience `Deref` impl for `Guard`, since I
couldn't figure out how to do it safely. Suggestions welcome, or we can
leave it for a future improvement ^^

[1] https://github.com/AsahiLinux/linux/tree/gpu/rebase-20230224
[2] https://github.com/Rust-for-Linux/linux/pull/952
---
 rust/bindings/bindings_helper.h |  17 +++
 rust/helpers.c                  |  37 +++++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/xarray.rs           | 292 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 347 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 75d85bd6c592..bd364f9e25fe 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -8,7 +8,24 @@
 
 #include <linux/slab.h>
 #include <linux/refcount.h>
+#include <linux/xarray.h>
 
 /* `bindgen` gets confused at certain things. */
 const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
 const gfp_t BINDINGS___GFP_ZERO = __GFP_ZERO;
+
+const gfp_t BINDINGS_XA_FLAGS_LOCK_IRQ = XA_FLAGS_LOCK_IRQ;
+const gfp_t BINDINGS_XA_FLAGS_LOCK_BH = XA_FLAGS_LOCK_BH;
+const gfp_t BINDINGS_XA_FLAGS_TRACK_FREE = XA_FLAGS_TRACK_FREE;
+const gfp_t BINDINGS_XA_FLAGS_ZERO_BUSY = XA_FLAGS_ZERO_BUSY;
+const gfp_t BINDINGS_XA_FLAGS_ALLOC_WRAPPED = XA_FLAGS_ALLOC_WRAPPED;
+const gfp_t BINDINGS_XA_FLAGS_ACCOUNT = XA_FLAGS_ACCOUNT;
+const gfp_t BINDINGS_XA_FLAGS_ALLOC = XA_FLAGS_ALLOC;
+const gfp_t BINDINGS_XA_FLAGS_ALLOC1 = XA_FLAGS_ALLOC1;
+
+const xa_mark_t BINDINGS_XA_MARK_0 = XA_MARK_0;
+const xa_mark_t BINDINGS_XA_MARK_1 = XA_MARK_1;
+const xa_mark_t BINDINGS_XA_MARK_2 = XA_MARK_2;
+const xa_mark_t BINDINGS_XA_PRESENT = XA_PRESENT;
+const xa_mark_t BINDINGS_XA_MARK_MAX = XA_MARK_MAX;
+const xa_mark_t BINDINGS_XA_FREE_MARK = XA_FREE_MARK;
diff --git a/rust/helpers.c b/rust/helpers.c
index 04b9be46e887..21a8e086472f 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -22,6 +22,7 @@
 #include <linux/build_bug.h>
 #include <linux/err.h>
 #include <linux/refcount.h>
+#include <linux/xarray.h>
 
 __noreturn void rust_helper_BUG(void)
 {
@@ -65,6 +66,42 @@ long rust_helper_PTR_ERR(__force const void *ptr)
 }
 EXPORT_SYMBOL_GPL(rust_helper_PTR_ERR);
 
+void rust_helper_xa_init_flags(struct xarray *xa, gfp_t flags)
+{
+	xa_init_flags(xa, flags);
+}
+EXPORT_SYMBOL_GPL(rust_helper_xa_init_flags);
+
+bool rust_helper_xa_empty(struct xarray *xa)
+{
+	return xa_empty(xa);
+}
+EXPORT_SYMBOL_GPL(rust_helper_xa_empty);
+
+int rust_helper_xa_alloc(struct xarray *xa, u32 *id, void *entry, struct xa_limit limit, gfp_t gfp)
+{
+	return xa_alloc(xa, id, entry, limit, gfp);
+}
+EXPORT_SYMBOL_GPL(rust_helper_xa_alloc);
+
+void rust_helper_xa_lock(struct xarray *xa)
+{
+	xa_lock(xa);
+}
+EXPORT_SYMBOL_GPL(rust_helper_xa_lock);
+
+void rust_helper_xa_unlock(struct xarray *xa)
+{
+	xa_unlock(xa);
+}
+EXPORT_SYMBOL_GPL(rust_helper_xa_unlock);
+
+int rust_helper_xa_err(void *entry)
+{
+	return xa_err(entry);
+}
+EXPORT_SYMBOL_GPL(rust_helper_xa_err);
+
 /*
  * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
  * as the Rust `usize` type, so we can use it in contexts where Rust
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 223564f9f0cc..3eb0a18acd55 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -38,6 +38,7 @@ pub mod std_vendor;
 pub mod str;
 pub mod sync;
 pub mod types;
+pub mod xarray;
 
 #[doc(hidden)]
 pub use bindings;
diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
new file mode 100644
index 000000000000..18721eeeebc3
--- /dev/null
+++ b/rust/kernel/xarray.rs
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! XArray abstraction.
+//!
+//! C header: [`include/linux/xarray.h`](../../include/linux/xarray.h)
+
+use crate::{
+    bindings,
+    error::{Error, Result},
+    types::{ForeignOwnable, Opaque, ScopeGuard},
+};
+use core::{marker::PhantomData, ptr::NonNull};
+
+/// Flags passed to `XArray::new` to configure the `XArray`.
+type Flags = bindings::gfp_t;
+
+/// Flag values passed to `XArray::new` to configure the `XArray`.
+pub mod flags {
+    /// Use IRQ-safe locking.
+    pub const LOCK_IRQ: super::Flags = bindings::BINDINGS_XA_FLAGS_LOCK_IRQ;
+    /// Use softirq-safe locking.
+    pub const LOCK_BH: super::Flags = bindings::BINDINGS_XA_FLAGS_LOCK_BH;
+    /// Track which entries are free (distinct from None).
+    pub const TRACK_FREE: super::Flags = bindings::BINDINGS_XA_FLAGS_TRACK_FREE;
+    /// Initialize array index 0 as busy.
+    pub const ZERO_BUSY: super::Flags = bindings::BINDINGS_XA_FLAGS_ZERO_BUSY;
+    /// Use GFP_ACCOUNT for internal memory allocations.
+    pub const ACCOUNT: super::Flags = bindings::BINDINGS_XA_FLAGS_ACCOUNT;
+    /// Create an allocating `XArray` starting at index 0.
+    pub const ALLOC: super::Flags = bindings::BINDINGS_XA_FLAGS_ALLOC;
+    /// Create an allocating `XArray` starting at index 1.
+    pub const ALLOC1: super::Flags = bindings::BINDINGS_XA_FLAGS_ALLOC1;
+}
+
+/// Wrapper for a value owned by the `XArray` which holds the `XArray` lock until dropped.
+pub struct Guard<'a, T: ForeignOwnable>(NonNull<T>, &'a XArray<T>);
+
+impl<'a, T: ForeignOwnable> Guard<'a, T> {
+    /// Borrow the underlying value wrapped by the `Guard`.
+    ///
+    /// Returns a `T::Borrowed` type for the owned `ForeignOwnable` type.
+    pub fn borrow(&self) -> T::Borrowed<'_> {
+        // SAFETY: The value is owned by the `XArray`, the lifetime it is borrowed for must not
+        // outlive the `XArray` itself, nor the Guard that holds the lock ensuring the value
+        // remains in the `XArray`.
+        unsafe { T::borrow(self.0.as_ptr() as _) }
+    }
+}
+
+impl<'a, T: ForeignOwnable> Drop for Guard<'a, T> {
+    fn drop(&mut self) {
+        // SAFETY: The XArray we have a reference to owns the C xarray object.
+        unsafe { bindings::xa_unlock(self.1.xa.get()) };
+    }
+}
+
+/// Represents a reserved slot in an `XArray`, which does not yet have a value but has an assigned
+/// index and may not be allocated by any other user. If the Reservation is dropped without
+/// being filled, the entry is marked as available again.
+///
+/// Users must ensure that reserved slots are not filled by other mechanisms, or otherwise their
+/// contents may be dropped and replaced (which will print a warning).
+pub struct Reservation<'a, T: ForeignOwnable>(&'a XArray<T>, usize, PhantomData<T>);
+
+impl<'a, T: ForeignOwnable> Reservation<'a, T> {
+    /// Stores a value into the reserved slot.
+    pub fn store(self, value: T) -> Result<usize> {
+        if self.0.replace(self.1, value)?.is_some() {
+            crate::pr_err!("XArray: Reservation stored but the entry already had data!\n");
+            // Consider it a success anyway, not much we can do
+        }
+        let index = self.1;
+        // The reservation is now fulfilled, so do not run our destructor.
+        core::mem::forget(self);
+        Ok(index)
+    }
+
+    /// Returns the index of this reservation.
+    pub fn index(&self) -> usize {
+        self.1
+    }
+}
+
+impl<'a, T: ForeignOwnable> Drop for Reservation<'a, T> {
+    fn drop(&mut self) {
+        if self.0.remove(self.1).is_some() {
+            crate::pr_err!("XArray: Reservation dropped but the entry was not empty!\n");
+        }
+    }
+}
+
+/// An array which efficiently maps sparse integer indices to owned objects.
+///
+/// This is similar to a `Vec<Option<T>>`, but more efficient when there are holes in the
+/// index space, and can be efficiently grown.
+///
+/// This structure is expected to often be used with an inner type that can either be efficiently
+/// cloned, such as an `Arc<T>`.
+pub struct XArray<T: ForeignOwnable> {
+    xa: Opaque<bindings::xarray>,
+    _p: PhantomData<T>,
+}
+
+impl<T: ForeignOwnable> XArray<T> {
+    /// Creates a new `XArray` with the given flags.
+    pub fn new(flags: Flags) -> XArray<T> {
+        let xa = Opaque::uninit();
+
+        // SAFETY: We have just created `xa`. This data structure does not require
+        // pinning.
+        unsafe { bindings::xa_init_flags(xa.get(), flags) };
+
+        // INVARIANT: Initialize the `XArray` with a valid `xa`.
+        XArray {
+            xa,
+            _p: PhantomData,
+        }
+    }
+
+    /// Replaces an entry with a new value, returning the old value (if any).
+    pub fn replace(&self, index: usize, value: T) -> Result<Option<T>> {
+        let new = value.into_foreign();
+        // SAFETY: `new` just came from into_foreign(), and we dismiss this guard if
+        // the xa_store operation succeeds and takes ownership of the pointer.
+        let guard = ScopeGuard::new(|| unsafe {
+            T::from_foreign(new);
+        });
+
+        // SAFETY: `self.xa` is always valid by the type invariant, and we are storing
+        // a `T::into_foreign()` result which upholds the later invariants.
+        let old = unsafe {
+            bindings::xa_store(
+                self.xa.get(),
+                index.try_into()?,
+                new as *mut _,
+                bindings::GFP_KERNEL,
+            )
+        };
+
+        let err = unsafe { bindings::xa_err(old) };
+        if err != 0 {
+            Err(Error::from_kernel_errno(err))
+        } else if old.is_null() {
+            guard.dismiss();
+            Ok(None)
+        } else {
+            guard.dismiss();
+            // SAFETY: The old value must have been stored by either this function or
+            // `alloc_limits_opt`, both of which ensure non-NULL entries are valid
+            // ForeignOwnable pointers.
+            Ok(Some(unsafe { T::from_foreign(old) }))
+        }
+    }
+
+    /// Replaces an entry with a new value, dropping the old value (if any).
+    pub fn set(&self, index: usize, value: T) -> Result {
+        self.replace(index, value)?;
+        Ok(())
+    }
+
+    /// Looks up and returns a reference to an entry in the array, returning a `Guard` if it
+    /// exists.
+    ///
+    /// This guard blocks all other actions on the `XArray`. Callers are expected to drop the
+    /// `Guard` eagerly to avoid blocking other users, such as by taking a clone of the value.
+    pub fn get(&self, index: usize) -> Option<Guard<'_, T>> {
+        // SAFETY: `self.xa` is always valid by the type invariant.
+        unsafe { bindings::xa_lock(self.xa.get()) };
+
+        // SAFETY: `self.xa` is always valid by the type invariant.
+        let guard = ScopeGuard::new(|| unsafe { bindings::xa_unlock(self.xa.get()) });
+
+        // SAFETY: `self.xa` is always valid by the type invariant.
+        let p = unsafe { bindings::xa_load(self.xa.get(), index.try_into().ok()?) };
+
+        NonNull::new(p as *mut T).map(|p| {
+            guard.dismiss();
+            Guard(p, self)
+        })
+    }
+
+    /// Removes and returns an entry, returning it if it existed.
+    pub fn remove(&self, index: usize) -> Option<T> {
+        let p = unsafe { bindings::xa_erase(self.xa.get(), index.try_into().ok()?) };
+        if p.is_null() {
+            None
+        } else {
+            Some(unsafe { T::from_foreign(p) })
+        }
+    }
+
+    /// Allocates a new index in the array, optionally storing a new value into it, with
+    /// configurable bounds for the index range to allocate from.
+    ///
+    /// If `value` is `None`, then the index is reserved from further allocation but remains
+    /// free for storing a value into it.
+    fn alloc_limits_opt(&self, value: Option<T>, min: u32, max: u32) -> Result<usize> {
+        let new = value.map_or(core::ptr::null(), |a| a.into_foreign());
+        let mut id: u32 = 0;
+
+        // SAFETY: `self.xa` is always valid by the type invariant. If this succeeds, it
+        // takes ownership of the passed `T` (if any). If it fails, we must drop the
+        // `T` again.
+        let ret = unsafe {
+            bindings::xa_alloc(
+                self.xa.get(),
+                &mut id,
+                new as *mut _,
+                bindings::xa_limit { min, max },
+                bindings::GFP_KERNEL,
+            )
+        };
+
+        if ret < 0 {
+            // Make sure to drop the value we failed to store
+            if !new.is_null() {
+                // SAFETY: If `new` is not NULL, it came from the `ForeignOwnable` we got
+                // from the caller.
+                unsafe { T::from_foreign(new) };
+            }
+            Err(Error::from_kernel_errno(ret))
+        } else {
+            Ok(id as usize)
+        }
+    }
+
+    /// Allocates a new index in the array, storing a new value into it, with configurable
+    /// bounds for the index range to allocate from.
+    pub fn alloc_limits(&self, value: T, min: u32, max: u32) -> Result<usize> {
+        self.alloc_limits_opt(Some(value), min, max)
+    }
+
+    /// Allocates a new index in the array, storing a new value into it.
+    pub fn alloc(&self, value: T) -> Result<usize> {
+        self.alloc_limits(value, 0, u32::MAX)
+    }
+
+    /// Reserves a new index in the array within configurable bounds for the index.
+    ///
+    /// Returns a `Reservation` object, which can then be used to store a value at this index or
+    /// otherwise free it for reuse.
+    pub fn reserve_limits(&self, min: u32, max: u32) -> Result<Reservation<'_, T>> {
+        Ok(Reservation(
+            self,
+            self.alloc_limits_opt(None, min, max)?,
+            PhantomData,
+        ))
+    }
+
+    /// Reserves a new index in the array.
+    ///
+    /// Returns a `Reservation` object, which can then be used to store a value at this index or
+    /// otherwise free it for reuse.
+    pub fn reserve(&self) -> Result<Reservation<'_, T>> {
+        Ok(Reservation(
+            self,
+            self.alloc_limits_opt(None, 0, u32::MAX)?,
+            PhantomData,
+        ))
+    }
+}
+
+impl<T: ForeignOwnable> Drop for XArray<T> {
+    fn drop(&mut self) {
+        // SAFETY: `self.xa` is valid by the type invariant, and as we have the only reference to
+        // the `XArray` we can safely iterate its contents and drop everything.
+        unsafe {
+            let mut index: core::ffi::c_ulong = 0;
+            let mut entry = bindings::xa_find(
+                self.xa.get(),
+                &mut index,
+                core::ffi::c_ulong::MAX,
+                bindings::BINDINGS_XA_PRESENT,
+            );
+            while !entry.is_null() {
+                T::from_foreign(entry);
+                entry = bindings::xa_find_after(
+                    self.xa.get(),
+                    &mut index,
+                    core::ffi::c_ulong::MAX,
+                    bindings::BINDINGS_XA_PRESENT,
+                );
+            }
+
+            bindings::xa_destroy(self.xa.get());
+        }
+    }
+}
+
+// SAFETY: XArray is thread-safe and all mutation operations are internally locked.
+unsafe impl<T: Send + ForeignOwnable> Send for XArray<T> {}
+unsafe impl<T: Sync + ForeignOwnable> Sync for XArray<T> {}

---
base-commit: 0ac13d87afc0086c0be43e7988173295a0864d5d
change-id: 20230224-rust-xarray-f503f9e5455e

Thank you,
~~ Lina

