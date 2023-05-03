Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BED6F53F5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjECJHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjECJHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:07:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E55420B
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 02:07:18 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30639daee76so1168136f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 02:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1683104837; x=1685696837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyybpekGpHGVvvaVewFrSrZRoEZZ/l3dGyzewmhKKwg=;
        b=Hpob7q1r0p4V0caXE2crEE/51FttP5ZNpxWPBnl62DekIdsJcpMiZqQ+U+0jmvfFhs
         BuAsztkxherqbyie+iWYnyQMMPYONBuj/oH4n3bIkTFCW6YxZ1Qzi8QEu4wrtQeU4R3m
         7pVC6wXg8s6dc6fWLdUSxUdlxle+M8WZmsl6xw4ADtWTPKY3Cr+OeVC1eL/tZD3HUO9D
         q8HSTwHe/phJrkywr0Cj2YrKfBXdA8V3FvuTAJaBlWK+ou8a65EmklXozWcnoVqQl1Nt
         SaOHMzoSKIqGjhbX5y3I97bbfDs7YJsYXztcWuw71U7QjlCUZXS0UIkgwyYoGaNAdEA8
         IrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683104837; x=1685696837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyybpekGpHGVvvaVewFrSrZRoEZZ/l3dGyzewmhKKwg=;
        b=ae9HYl3ufYHoY72dA88M1IrcDC1jQwLvM0/ONfyK36jPp7mMnZ43mOcCc1mwU+yyDk
         +ylJmpr26U6awHm6PTe82n/NlRO3G6p9nYIoDdTwc+lwIa9hxTywi3YAISoWYJjZrJW1
         5ljkTVECL9iTkjonjEf8pJ4JD5a66NCdVbaks3t8v7B+JdqNDFZqf6mDuEblxZPD/VEn
         6xmUCvITQWNAlV6x+DcuyH8Tx4X/Ezh3CaDHn4NxchlPwMoPWLvgJgFTAc41vQjFLg9i
         yvXoev/WW9RjJgh4k40dGEnbZRJUPvCGMkjzH6zL1f2lYvZ8zvQAbx+DKZBuQSQ1P0Bd
         zLVg==
X-Gm-Message-State: AC+VfDxiuJHovpPNMpMV66Y6lDQaCTYjy4q0RKkA7DET16yRGEArd1dh
        Fyneh3udDQjeWRA8UdtTv1HhXw==
X-Google-Smtp-Source: ACHHUZ4c7pdGYmFDE+EObHEdf29jnpXn/rtwlDJWATkEBCQ9LPR+y1yLX/HtD1fPIL1dXO2oFBe9Lg==
X-Received: by 2002:a5d:54d1:0:b0:306:2ff6:5cbf with SMTP id x17-20020a5d54d1000000b003062ff65cbfmr6873320wrv.24.1683104837081;
        Wed, 03 May 2023 02:07:17 -0700 (PDT)
Received: from localhost ([147.161.155.99])
        by smtp.gmail.com with ESMTPSA id e2-20020a056000120200b00306281cfa59sm9741741wrx.47.2023.05.03.02.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 02:07:16 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Andreas Hindborg <a.hindborg@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <nmi@metaspace.dk>,
        linux-kernel@vger.kernel.org (open list), gost.dev@samsung.com
Subject: [RFC PATCH 01/11] rust: add radix tree abstraction
Date:   Wed,  3 May 2023 11:06:58 +0200
Message-Id: <20230503090708.2524310-2-nmi@metaspace.dk>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503090708.2524310-1-nmi@metaspace.dk>
References: <20230503090708.2524310-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

Add abstractions for the C radix_tree. This abstraction allows Rust code to use
the radix_tree as a map from `u64` keys to `ForeignOwnable` values.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 rust/bindings/bindings_helper.h |   2 +
 rust/bindings/lib.rs            |   1 +
 rust/helpers.c                  |  22 +++++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/radix_tree.rs       | 156 ++++++++++++++++++++++++++++++++
 5 files changed, 182 insertions(+)
 create mode 100644 rust/kernel/radix_tree.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 50e7a76d5455..52834962b94d 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -10,7 +10,9 @@
 #include <linux/refcount.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/radix-tree.h>
 
 /* `bindgen` gets confused at certain things. */
 const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
+const gfp_t BINDINGS_GFP_ATOMIC = GFP_ATOMIC;
 const gfp_t BINDINGS___GFP_ZERO = __GFP_ZERO;
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 7b246454e009..62f36a9eb1f4 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -51,4 +51,5 @@ mod bindings_helper {
 pub use bindings_raw::*;
 
 pub const GFP_KERNEL: gfp_t = BINDINGS_GFP_KERNEL;
+pub const GFP_ATOMIC: gfp_t = BINDINGS_GFP_ATOMIC;
 pub const __GFP_ZERO: gfp_t = BINDINGS___GFP_ZERO;
diff --git a/rust/helpers.c b/rust/helpers.c
index 81e80261d597..5dd5e325b7cc 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -26,6 +26,7 @@
 #include <linux/spinlock.h>
 #include <linux/sched/signal.h>
 #include <linux/wait.h>
+#include <linux/radix-tree.h>
 
 __noreturn void rust_helper_BUG(void)
 {
@@ -128,6 +129,27 @@ void rust_helper_put_task_struct(struct task_struct *t)
 }
 EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
 
+void rust_helper_init_radix_tree(struct xarray *tree, gfp_t gfp_mask)
+{
+	INIT_RADIX_TREE(tree, gfp_mask);
+}
+EXPORT_SYMBOL_GPL(rust_helper_init_radix_tree);
+
+void **rust_helper_radix_tree_iter_init(struct radix_tree_iter *iter,
+					unsigned long start)
+{
+	return radix_tree_iter_init(iter, start);
+}
+EXPORT_SYMBOL_GPL(rust_helper_radix_tree_iter_init);
+
+void **rust_helper_radix_tree_next_slot(void **slot,
+					struct radix_tree_iter *iter,
+					unsigned flags)
+{
+	return radix_tree_next_slot(slot, iter, flags);
+}
+EXPORT_SYMBOL_GPL(rust_helper_radix_tree_next_slot);
+
 /*
  * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
  * as the Rust `usize` type, so we can use it in contexts where Rust
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 676995d4e460..a85cb6aae8d6 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -40,6 +40,7 @@ pub mod init;
 pub mod ioctl;
 pub mod prelude;
 pub mod print;
+pub mod radix_tree;
 mod static_assert;
 #[doc(hidden)]
 pub mod std_vendor;
diff --git a/rust/kernel/radix_tree.rs b/rust/kernel/radix_tree.rs
new file mode 100644
index 000000000000..f659ab8b017c
--- /dev/null
+++ b/rust/kernel/radix_tree.rs
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! RadixTree abstraction.
+//!
+//! C header: [`include/linux/radix_tree.h`](../../include/linux/radix_tree.h)
+
+use crate::error::to_result;
+use crate::error::Result;
+use crate::types::ForeignOwnable;
+use crate::types::Opaque;
+use crate::types::ScopeGuard;
+use alloc::boxed::Box;
+use core::marker::PhantomData;
+use core::pin::Pin;
+
+type Key = u64;
+
+/// A map of `u64` to `ForeignOwnable`
+///
+/// # Invariants
+///
+/// - `tree` always points to a valid and initialized `struct radix_tree`.
+/// - Pointers stored in the tree are created by a call to `ForignOwnable::into_foreign()`
+pub struct RadixTree<V: ForeignOwnable> {
+    tree: Pin<Box<Opaque<bindings::xarray>>>,
+    _marker: PhantomData<V>,
+}
+
+impl<V: ForeignOwnable> RadixTree<V> {
+    /// Create a new radix tree
+    ///
+    /// Note: This function allocates memory with `GFP_ATOMIC`.
+    pub fn new() -> Result<Self> {
+        let tree = Pin::from(Box::try_new(Opaque::uninit())?);
+
+        // SAFETY: `tree` points to allocated but not initialized memory. This
+        // call will initialize the memory.
+        unsafe { bindings::init_radix_tree(tree.get(), bindings::GFP_ATOMIC) };
+
+        Ok(Self {
+            tree,
+            _marker: PhantomData,
+        })
+    }
+
+    /// Try to insert a value into the tree
+    pub fn try_insert(&mut self, key: Key, value: V) -> Result<()> {
+        // SAFETY: `self.tree` points to a valid and initialized `struct radix_tree`
+        let ret =
+            unsafe { bindings::radix_tree_insert(self.tree.get(), key, value.into_foreign() as _) };
+        to_result(ret)
+    }
+
+    /// Search for `key` in the map. Returns a reference to the associated
+    /// value if found.
+    pub fn get(&self, key: Key) -> Option<V::Borrowed<'_>> {
+        // SAFETY: `self.tree` points to a valid and initialized `struct radix_tree`
+        let item =
+            core::ptr::NonNull::new(unsafe { bindings::radix_tree_lookup(self.tree.get(), key) })?;
+
+        // SAFETY: `item` was created by a call to
+        // `ForeignOwnable::into_foreign()`. As `get_mut()` and `remove()` takes
+        // a `&mut self`, no mutable borrows for `item` can exist and
+        // `ForeignOwnable::from_foreign()` cannot be called until this borrow
+        // is dropped.
+        Some(unsafe { V::borrow(item.as_ptr()) })
+    }
+
+    /// Search for `key` in the map. Return a mutable reference to the
+    /// associated value if found.
+    pub fn get_mut(&mut self, key: Key) -> Option<MutBorrow<'_, V>> {
+        let item =
+            core::ptr::NonNull::new(unsafe { bindings::radix_tree_lookup(self.tree.get(), key) })?;
+
+        // SAFETY: `item` was created by a call to
+        // `ForeignOwnable::into_foreign()`. As `get()` takes a `&self` and
+        // `remove()` takes a `&mut self`, no borrows for `item` can exist and
+        // `ForeignOwnable::from_foreign()` cannot be called until this borrow
+        // is dropped.
+        Some(MutBorrow {
+            guard: unsafe { V::borrow_mut(item.as_ptr()) },
+            _marker: core::marker::PhantomData,
+        })
+    }
+
+    /// Search for `key` in the map. If `key` is found, the key and value is
+    /// removed from the map and the value is returned.
+    pub fn remove(&mut self, key: Key) -> Option<V> {
+        // SAFETY: `self.tree` points to a valid and initialized `struct radix_tree`
+        let item =
+            core::ptr::NonNull::new(unsafe { bindings::radix_tree_delete(self.tree.get(), key) })?;
+
+        // SAFETY: `item` was created by a call to
+        // `ForeignOwnable::into_foreign()` and no borrows to `item` can exist
+        // because this function takes a `&mut self`.
+        Some(unsafe { ForeignOwnable::from_foreign(item.as_ptr()) })
+    }
+}
+
+impl<V: ForeignOwnable> Drop for RadixTree<V> {
+    fn drop(&mut self) {
+        let mut iter = bindings::radix_tree_iter {
+            index: 0,
+            next_index: 0,
+            tags: 0,
+            node: core::ptr::null_mut(),
+        };
+
+        // SAFETY: Iter is valid as we allocated it on the stack above
+        let mut slot = unsafe { bindings::radix_tree_iter_init(&mut iter, 0) };
+        loop {
+            if slot.is_null() {
+                // SAFETY: Both `self.tree` and `iter` are valid
+                slot = unsafe { bindings::radix_tree_next_chunk(self.tree.get(), &mut iter, 0) };
+            }
+
+            if slot.is_null() {
+                break;
+            }
+
+            // SAFETY: `self.tree` is valid and iter is managed by
+            // `radix_tree_next_chunk()` and `radix_tree_next_slot()`
+            let item = unsafe { bindings::radix_tree_delete(self.tree.get(), iter.index) };
+            assert!(!item.is_null());
+
+            // SAFETY: All items in the tree are created by a call to
+            // `ForeignOwnable::into_foreign()`.
+            let _ = unsafe { V::from_foreign(item) };
+
+            // SAFETY: `self.tree` is valid and iter is managed by
+            // `radix_tree_next_chunk()` and `radix_tree_next_slot()`. Slot is
+            // not null.
+            slot = unsafe { bindings::radix_tree_next_slot(slot, &mut iter, 0) };
+        }
+    }
+}
+
+/// A mutable borrow of an object owned by a `RadixTree`
+pub struct MutBorrow<'a, V: ForeignOwnable> {
+    guard: ScopeGuard<V, fn(V)>,
+    _marker: core::marker::PhantomData<&'a mut V>,
+}
+
+impl<'a, V: ForeignOwnable> core::ops::Deref for MutBorrow<'a, V> {
+    type Target = ScopeGuard<V, fn(V)>;
+
+    fn deref(&self) -> &Self::Target {
+        &self.guard
+    }
+}
+
+impl<'a, V: ForeignOwnable> core::ops::DerefMut for MutBorrow<'a, V> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        &mut self.guard
+    }
+}
-- 
2.40.0

