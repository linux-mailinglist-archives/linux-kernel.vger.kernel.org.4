Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555EF72AAF2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 12:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbjFJKta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 06:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjFJKt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 06:49:29 -0400
Received: from out0-208.mail.aliyun.com (out0-208.mail.aliyun.com [140.205.0.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A2E35BC;
        Sat, 10 Jun 2023 03:49:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047203;MF=changxian.cqs@antgroup.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---.TQGLBZH_1686394162;
Received: from localhost(mailfrom:changxian.cqs@antgroup.com fp:SMTPD_---.TQGLBZH_1686394162)
          by smtp.aliyun-inc.com;
          Sat, 10 Jun 2023 18:49:23 +0800
From:   "Qingsong Chen" <changxian.cqs@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "=?UTF-8?B?55Sw5rSq5Lqu?=" <tate.thl@antgroup.com>,
        "Qingsong Chen" <changxian.cqs@antgroup.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        "Benno Lossin" <benno.lossin@proton.me>,
        "Martin Rodriguez Reboredo" <yakoyoku@gmail.com>,
        "Alice Ryhl" <aliceryhl@google.com>,
        "Asahi Lina" <lina@asahilina.net>,
        "Niklas Mohrin" <dev@niklasmohrin.de>,
        <rust-for-linux@vger.kernel.org>
Subject: [PATCH v3 1/3] rust: kernel: add ScatterList abstraction
Date:   Sat, 10 Jun 2023 18:49:07 +0800
Message-Id: <20230610104909.3202958-2-changxian.cqs@antgroup.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610104909.3202958-1-changxian.cqs@antgroup.com>
References: <20230610104909.3202958-1-changxian.cqs@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a wrapper for `struct scatterlist`.

Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers.c                  |  14 ++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/scatterlist.rs      | 293 ++++++++++++++++++++++++++++++++
 4 files changed, 309 insertions(+)
 create mode 100644 rust/kernel/scatterlist.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 50e7a76d5455..9cfa1ef92a04 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -10,6 +10,7 @@
 #include <linux/refcount.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/scatterlist.h>
 
 /* `bindgen` gets confused at certain things. */
 const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
diff --git a/rust/helpers.c b/rust/helpers.c
index 81e80261d597..4eb48f6c926e 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -26,6 +26,7 @@
 #include <linux/spinlock.h>
 #include <linux/sched/signal.h>
 #include <linux/wait.h>
+#include <linux/scatterlist.h>
 
 __noreturn void rust_helper_BUG(void)
 {
@@ -128,6 +129,19 @@ void rust_helper_put_task_struct(struct task_struct *t)
 }
 EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
 
+void rust_helper_sg_set_buf(struct scatterlist *sgl, const void *buf,
+			    unsigned int buflen)
+{
+	sg_set_buf(sgl, buf, buflen);
+}
+EXPORT_SYMBOL_GPL(rust_helper_sg_set_buf);
+
+void *rust_helper_sg_virt(struct scatterlist *sgl)
+{
+	return sg_virt(sgl);
+}
+EXPORT_SYMBOL_GPL(rust_helper_sg_virt);
+
 /*
  * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
  * as the Rust `usize` type, so we can use it in contexts where Rust
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 676995d4e460..d8dbcde4ad5c 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -40,6 +40,7 @@ pub mod init;
 pub mod ioctl;
 pub mod prelude;
 pub mod print;
+pub mod scatterlist;
 mod static_assert;
 #[doc(hidden)]
 pub mod std_vendor;
diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
new file mode 100644
index 000000000000..7fb8f3326ff3
--- /dev/null
+++ b/rust/kernel/scatterlist.rs
@@ -0,0 +1,293 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Scatterlist.
+//!
+//! C header: [`include/linux/scatterlist.h`](../../../../include/linux/scatterlist.h)
+
+use crate::prelude::*;
+use crate::types::Opaque;
+use core::marker::PhantomData;
+use core::ptr::{addr_of, NonNull};
+
+/// Wrap the kernel's `struct scatterlist`.
+///
+/// According to the design of kernel's `struct sg_table`, the `page_link`
+/// field of one `scatterlist` may contain a pointer to another. That is,
+/// there could exist external pointers to it, making it necessary to pin
+/// this struct.
+///
+/// # Invariants
+///
+/// All instances should be valid, either created by the `new` constructor
+/// (see [`pin_init`]), or transmuted from raw pointers (which could be used
+/// to reference a valid entry of `sg_table`).
+///
+/// # Examples
+///
+/// The following are some use cases of [`ScatterList`].
+///
+/// ```rust
+/// use core::pin::pin;
+/// # use kernel::error::Result;
+/// # use kernel::scatterlist::ScatterList;
+///
+/// // Prepare memory buffers.
+/// let buf0: Pin<&mut [u8]> = pin!([0u8; 512]);
+/// let buf1: Pin<&mut [u8]> = pin!([1u8; 512]);
+///
+/// // Allocate an instance on stack.
+/// kernel::stack_pin_init!(let foo = ScatterList::new(&buf0));
+/// let mut foo: Pin<&mut ScatterList<'_>> = foo;
+/// assert_eq!(foo.length(), 512);
+///
+/// // Allocate an instance by Box::pin_init.
+/// let bar: Pin<Box<ScatterList<'_>>> = Box::pin_init(ScatterList::new(&buf1))?;
+/// assert_eq!(bar.length(), 512);
+///
+/// // Assert other attributes of an instance.
+/// assert_eq!(foo.is_dma_bus_address(), false);
+/// assert_eq!(foo.is_chain(), false);
+/// assert_eq!(foo.is_last(), true);
+/// assert_eq!(foo.count(), 1);
+///
+/// // Get an immutable reference to memory buffer.
+/// assert_eq!(foo.get_buf(), [0u8; 512]);
+///
+/// // Reset the memory buffer.
+/// foo.set_buf(&buf1);
+/// assert_eq!(foo.get_buf(), [1u8; 512]);
+///
+/// // Get a mutable reference to memory buffer.
+/// foo.get_mut_buf().fill(2);
+/// assert_eq!(foo.get_buf(), [2u8; 512]);
+/// ```
+#[pin_data]
+pub struct ScatterList<'a> {
+    #[pin]
+    opaque: Opaque<bindings::scatterlist>,
+    _p: PhantomData<&'a mut bindings::scatterlist>,
+}
+
+impl<'a> ScatterList<'a> {
+    /// Construct a new initializer.
+    pub fn new(buf: &'a Pin<&mut [u8]>) -> impl PinInit<ScatterList<'a>> {
+        // SAFETY: `slot` is valid while the closure is called, the memory
+        // buffer is pinned and valid.
+        unsafe {
+            init::pin_init_from_closure(move |slot: *mut Self| {
+                // `slot` contains uninit memory, avoid creating a reference.
+                let opaque = addr_of!((*slot).opaque);
+                let sgl = Opaque::raw_get(opaque);
+
+                bindings::sg_set_buf(sgl, buf.as_ptr() as _, buf.len() as _);
+                (*sgl).page_link |= bindings::SG_END as u64;
+                (*sgl).page_link &= !(bindings::SG_CHAIN as u64);
+                Ok(())
+            })
+        }
+    }
+
+    /// Obtain a pinned reference to an immutable scatterlist from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// The `ptr` is null, or pointed to a valid `scatterlist`.
+    unsafe fn as_ref(ptr: *mut bindings::scatterlist) -> Option<Pin<&'a Self>> {
+        // SAFETY: `sgl` is non-null and valid.
+        NonNull::new(ptr).map(|sgl| Pin::new(unsafe { &*(sgl.as_ptr() as *const ScatterList<'_>) }))
+    }
+
+    /// Obtain a pinned reference to a mutable scatterlist from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// The `ptr` is null, or pointed to a valid `scatterlist`.
+    unsafe fn as_mut(ptr: *mut bindings::scatterlist) -> Option<Pin<&'a mut Self>> {
+        // SAFETY: `sgl` is non-null and valid.
+        NonNull::new(ptr)
+            .map(|sgl| Pin::new(unsafe { &mut *(sgl.as_ptr() as *mut ScatterList<'_>) }))
+    }
+}
+
+impl ScatterList<'_> {
+    /// Return the offset of memory buffer into the page.
+    pub fn offset(&self) -> usize {
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        unsafe { (*self.opaque.get()).offset as _ }
+    }
+
+    /// Return the length of memory buffer.
+    pub fn length(&self) -> usize {
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        unsafe { (*self.opaque.get()).length as _ }
+    }
+
+    /// Return the mapped DMA address.
+    ///
+    /// # Safety
+    ///
+    /// It is only valid after this scatterlist has been mapped to some bus
+    /// address and then called `set_dma` method to setup it.
+    pub fn dma_address(&self) -> usize {
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        unsafe { (*self.opaque.get()).dma_address as _ }
+    }
+
+    /// Return the mapped DMA length.
+    ///
+    /// # Safety
+    ///
+    /// It is only valid after this scatterlist has been mapped to some bus
+    /// address and then called `set_dma` method to setup it.
+    pub fn dma_length(&self) -> usize {
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        #[cfg(CONFIG_NEED_SG_DMA_LENGTH)]
+        unsafe {
+            (*self.opaque.get()).dma_length as _
+        }
+        #[cfg(not(CONFIG_NEED_SG_DMA_LENGTH))]
+        unsafe {
+            (*self.opaque.get()).length as _
+        }
+    }
+
+    /// Setup the DMA address and length.
+    pub fn set_dma(&mut self, addr: usize, len: usize) {
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        #[cfg(CONFIG_NEED_SG_DMA_LENGTH)]
+        unsafe {
+            (*self.opaque.get()).dma_address = addr as _;
+            (*self.opaque.get()).dma_length = len as _;
+        }
+        #[cfg(not(CONFIG_NEED_SG_DMA_LENGTH))]
+        unsafe {
+            (*self.opaque.get()).dma_address = addr as _;
+            (*self.opaque.get()).length = len as _;
+        }
+        self.dma_mark_bus_address();
+    }
+
+    /// Return `true` if it is mapped with a DMA address.
+    pub fn is_dma_bus_address(&self) -> bool {
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        #[cfg(CONFIG_PCI_P2PDMA)]
+        unsafe {
+            ((*self.opaque.get()).dma_flags & bindings::SG_DMA_BUS_ADDRESS) != 0
+        }
+        #[cfg(not(CONFIG_PCI_P2PDMA))]
+        false
+    }
+
+    /// Mark it as mapped to a DMA address.
+    pub fn dma_mark_bus_address(&mut self) {
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        #[cfg(CONFIG_PCI_P2PDMA)]
+        unsafe {
+            (*self.opaque.get()).dma_flags |= bindings::SG_DMA_BUS_ADDRESS;
+        }
+    }
+
+    /// Mark it as `not` mapped to a DMA address.
+    pub fn dma_unmark_bus_address(&mut self) {
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        #[cfg(CONFIG_PCI_P2PDMA)]
+        unsafe {
+            (*self.opaque.get()).dma_flags &= !bindings::SG_DMA_BUS_ADDRESS;
+        }
+    }
+
+    /// Return `true` if it is a chainable entry.
+    pub fn is_chain(&self) -> bool {
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        unsafe {
+            ((*self.opaque.get()).page_link
+                & (bindings::SG_PAGE_LINK_MASK as u64)
+                & (bindings::SG_CHAIN as u64))
+                != 0
+        }
+    }
+
+    /// Transfer this scatterlist as a chainable entry, linked to `sgl`.
+    pub fn chain_sgl(&mut self, sgl: Pin<&mut ScatterList<'_>>) {
+        let addr = sgl.opaque.get() as u64;
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        unsafe {
+            (*self.opaque.get()).offset = 0;
+            (*self.opaque.get()).length = 0;
+            (*self.opaque.get()).page_link = addr | (bindings::SG_CHAIN as u64);
+        }
+        self.unmark_end();
+    }
+
+    /// Return `true` if it is the last normal entry in scatterlist.
+    pub fn is_last(&self) -> bool {
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        unsafe {
+            ((*self.opaque.get()).page_link
+                & (bindings::SG_PAGE_LINK_MASK as u64)
+                & (bindings::SG_END as u64))
+                != 0
+        }
+    }
+
+    /// Mark it as the last normal entry in scatterlist.
+    pub fn mark_end(&mut self) {
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        unsafe {
+            (*self.opaque.get()).page_link |= bindings::SG_END as u64;
+            (*self.opaque.get()).page_link &= !(bindings::SG_CHAIN as u64);
+        }
+    }
+
+    /// Mark it as `not` the last normal entry in scatterlist.
+    pub fn unmark_end(&mut self) {
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        unsafe {
+            (*self.opaque.get()).page_link &= !(bindings::SG_END as u64);
+        }
+    }
+
+    /// Get an immutable reference to memory buffer.
+    pub fn get_buf(&self) -> &[u8] {
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        let addr = unsafe { bindings::sg_virt(self.opaque.get()) };
+        let len = self.length();
+        // SAFETY: `addr` is returned by `sg_virt`, so it is valid. And the memory
+        // buffer is set by `new` constructor or `set_buf` method, so it's pinned
+        // and valid.
+        unsafe { core::slice::from_raw_parts(addr as _, len) }
+    }
+
+    /// Get a mutable reference to memory buffer.
+    pub fn get_mut_buf(&mut self) -> &mut [u8] {
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        let addr = unsafe { bindings::sg_virt(self.opaque.get()) };
+        let len = self.length();
+        // SAFETY: `addr` is returned by `sg_virt`, so it is valid. And the memory
+        // buffer is set by `new` constructor or `set_buf` method, so it's pinned
+        // and valid.
+        unsafe { core::slice::from_raw_parts_mut(addr as _, len) }
+    }
+
+    /// Set the memory buffer.
+    pub fn set_buf(&mut self, buf: &Pin<&mut [u8]>) {
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        // And `buf` is pinned and valid.
+        unsafe {
+            bindings::sg_set_buf(
+                self.opaque.get(),
+                buf.as_ptr() as *const core::ffi::c_void,
+                buf.len() as core::ffi::c_uint,
+            );
+        }
+    }
+
+    /// Return the total count of normal entries in scatterlist.
+    ///
+    /// It allows to know how many entries are in scatterlist, taking into
+    /// account chaining as well.
+    pub fn count(&self) -> usize {
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        unsafe { bindings::sg_nents(self.opaque.get()) as _ }
+    }
+}
-- 
2.40.1

