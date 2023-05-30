Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABAD7155AB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 08:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjE3GtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 02:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjE3Gs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 02:48:57 -0400
Received: from out0-199.mail.aliyun.com (out0-199.mail.aliyun.com [140.205.0.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4297EE8;
        Mon, 29 May 2023 23:48:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047202;MF=changxian.cqs@antgroup.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---.TGKDcaV_1685429320;
Received: from localhost(mailfrom:changxian.cqs@antgroup.com fp:SMTPD_---.TGKDcaV_1685429320)
          by smtp.aliyun-inc.com;
          Tue, 30 May 2023 14:48:41 +0800
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
        "Alice Ryhl" <aliceryhl@google.com>,
        "Martin Rodriguez Reboredo" <yakoyoku@gmail.com>,
        "Asahi Lina" <lina@asahilina.net>,
        "Niklas Mohrin" <dev@niklasmohrin.de>,
        <rust-for-linux@vger.kernel.org>
Subject: [PATCH 1/2] rust: kernel: add scatterlist wrapper
Date:   Tue, 30 May 2023 14:48:20 +0800
Message-Id: <20230530064821.1222290-2-changxian.cqs@antgroup.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530064821.1222290-1-changxian.cqs@antgroup.com>
References: <20230530064821.1222290-1-changxian.cqs@antgroup.com>
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

Add abstractions for single `struct scatterlist` and chainable
`struct sg_table`.

Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers.c                  |  14 +
 rust/kernel/lib.rs              |   1 +
 rust/kernel/scatterlist.rs      | 478 ++++++++++++++++++++++++++++++++
 4 files changed, 494 insertions(+)
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
index 81e80261d597..1714ed05f561 100644
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
 
+void rust_helper_sg_set_buf(struct scatterlist *sg, const void *buf,
+			    unsigned int buflen)
+{
+	sg_set_buf(sg, buf, buflen);
+}
+EXPORT_SYMBOL_GPL(rust_helper_sg_set_buf);
+
+void *rust_helper_sg_virt(struct scatterlist *sg)
+{
+	return sg_virt(sg);
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
index 000000000000..183fb4de02a9
--- /dev/null
+++ b/rust/kernel/scatterlist.rs
@@ -0,0 +1,478 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Scatterlist.
+//!
+//! C header: [`include/linux/scatterlist.h`](../../../../include/linux/scatterlist.h)
+
+use crate::prelude::*;
+use crate::types::Opaque;
+use core::marker::PhantomData;
+
+/// A [`ScatterList`] table of fixed `N` entries.
+///
+/// According to the SG table design (form kernel ), the `page_link` field may contain
+/// a pointer to the next sg table list, so this struct should be pinned. If the table
+/// is chainable, the last entry will be reserved for chainning. The recommended way to
+/// create such instances is with the [`pin_init`].
+///
+/// # Examples
+///
+/// The following is examples of creating [`SgTable<N>`] instances.
+///
+/// ```rust
+/// use kernel::stack_try_pin_init;
+/// # use kernel::error::Result;
+/// # use kernel::scatterlist::SgTable;
+///
+/// // Prepare memory buffers.
+/// let buf0: Pin<&mut [u8]> = pin!([0u8; 512]);
+/// let buf1: Pin<&mut [u8]> = pin!([1u8; 512]);
+/// let mut entries: Vec<Pin<&mut [u8]>> = Vec::<Pin<&mut [u8]>>::new();
+/// entries.try_push(buf0)?;
+/// entries.try_push(buf1)?;
+///
+/// // Allocates an instance on stack.
+/// stack_try_pin_init!(let foo =? SgTable::new(entries.as_slice(), false));
+/// let foo: Pin<&mut SgTable<'_, 2>> = foo;
+/// assert_eq!(foo.count(), 2);
+///
+/// // Alloccate an instance by Box::pin_init.
+/// let bar: Result<Pin<Box<SgTable<'_, 3>>>> =
+///     Box::pin_init(SgTable::new(entries.as_slice(), true));
+/// assert_eq!(bar.unwrap().count(), 2);
+/// ```
+#[pin_data]
+pub struct SgTable<'a, const N: usize> {
+    #[pin]
+    entries: [ScatterList<'a>; N],
+}
+
+impl<'a, const N: usize> SgTable<'a, N> {
+    /// Construct a new initializer.
+    ///
+    /// The length of `entries` should exactly be the available size of [`SgTable<N>`].
+    /// If the table is `chainable`, the available size is `N`, otherwise, one entry
+    /// will be reserved for chainning.
+    pub fn new(
+        entries: &'a [Pin<&mut [u8]>],
+        chainable: bool,
+    ) -> impl PinInit<SgTable<'a, N>, Error> {
+        build_assert!(N > 0);
+        // SAFETY: `slot` is valid while the closure is called, the `entries` are pinned
+        // and valid.
+        unsafe {
+            init::pin_init_from_closure(move |slot: *mut Self| {
+                let mut nr_entry = N;
+                if chainable {
+                    nr_entry -= 1;
+                }
+                if nr_entry == 0 || entries.len() != nr_entry {
+                    return Err(EINVAL);
+                }
+
+                for i in 0..nr_entry {
+                    let sgl = &mut (*slot).entries[i];
+                    sgl.set_buf(&entries[i]);
+                    if i + 1 == nr_entry {
+                        sgl.mark_end();
+                    }
+                }
+                Ok(())
+            })
+        }
+    }
+
+    /// Chain two [`SgTable`] together.
+    ///
+    /// Transfer the last entry of this table as a chainable pointer to the first entry
+    /// of `sgt` SgTable.
+    pub fn chain_sgt<const M: usize>(&mut self, sgt: Pin<&mut SgTable<'_, M>>) -> Result {
+        if self.count() != N - 1 {
+            return Err(EINVAL);
+        }
+        self.entries[N - 2].unmark_end();
+
+        let next = ScatterList::as_mut(sgt.entries[0].opaque.get()).ok_or(EINVAL)?;
+        self.entries[N - 1].chain_sgl(next);
+        Ok(())
+    }
+
+    /// Chain [`SgTable`] and [`ScatterList`] together.
+    ///
+    /// Transfer the last entry of this table as a chainable pointer to `sgl` scatterlist.
+    pub fn chain_sgl(&mut self, sgl: Pin<&mut ScatterList<'_>>) -> Result {
+        if self.count() != N - 1 {
+            return Err(EINVAL);
+        }
+        self.entries[N - 2].unmark_end();
+        self.entries[N - 1].chain_sgl(sgl);
+        Ok(())
+    }
+
+    /// Split the first table from chained scatterlist.
+    pub fn split(&mut self) -> Result {
+        if !self.entries[N - 1].is_chain() {
+            return Err(EINVAL);
+        }
+        self.entries[N - 2].mark_end();
+        Ok(())
+    }
+
+    /// Return the total count of entries in the table.
+    ///
+    /// Allows to know how many entries are in sg, taking into account chaining as well.
+    pub fn count(&self) -> usize {
+        // SAFETY: `self.entries` are initialized by the `new` constructor, so it's valid.
+        unsafe { bindings::sg_nents(self.entries[0].opaque.get()) as _ }
+    }
+
+    /// Get the immutable reference to `n`th entry in the table.
+    ///
+    /// Like most indexing operations, the count starts from zero. Return None if `n`
+    /// is greater than or equal to the total count of entries.
+    pub fn get(&self, n: usize) -> Option<Pin<&ScatterList<'_>>> {
+        self.iter().nth(n)
+    }
+
+    /// Get the mutable reference to `n`th entry in the table.
+    ///
+    /// Like most indexing operations, the count starts from zero. Return None if `n`
+    /// is greater than or equal to the number of total entries.
+    pub fn get_mut(&mut self, n: usize) -> Option<Pin<&mut ScatterList<'_>>> {
+        self.iter_mut().nth(n)
+    }
+}
+
+impl<'a, const N: usize> SgTable<'a, N> {
+    /// Get an iterator for immutable entries.
+    pub fn iter(&self) -> Iter<'_> {
+        Iter(ScatterList::as_ref(self.entries[0].opaque.get()))
+    }
+
+    /// Get an iterator for mutable entries.
+    pub fn iter_mut(&mut self) -> IterMut<'_> {
+        IterMut(ScatterList::as_mut(self.entries[0].opaque.get()))
+    }
+}
+
+/// Wrap the kernel's `struct scatterlist`.
+///
+/// According to the SG table design (from kernel), the `page_link` field may contain
+/// a pointer to the next sg table list, so this struct should be pinned.
+///
+/// # Invirants
+///
+/// All instances are valid, either created by the `new` constructor (see [`pin_init`]),
+/// or transmuted from raw pointers by the `as_ref` or `as_mut` function (usually used
+/// to get an entry of [`SgTable`]).
+///
+/// # Examples
+///
+/// The following is examples of creating [`ScatterList`] instances.
+///
+/// ```rust
+/// use core::pin::pin;
+/// # use kernel::error::Result;
+/// # use kernel::scatterlist::ScatterList;
+///
+/// // Prepare memory buffer.
+/// let buf: Pin<&mut [u8]> = pin!([0u8; 512]);
+///
+/// // Allocates an instance on stack.
+/// kernel::stack_pin_init!(let foo = ScatterList::new(&buf));
+/// let foo: Pin<&mut ScatterList<'_>> = foo;
+/// assert_eq!(foo.length(), 512);
+/// assert_eq!(foo.count(), 1);
+///
+/// // Alloccate an instance by Box::pin_init.
+/// let bar: Result<Pin<Box<ScatterList<'_>>>> = Box::pin_init(ScatterList::new(&buf));
+/// assert_eq!(bar.as_ref().unwrap().length(), 512);
+/// assert_eq!(bar.as_ref().unwrap().count(), 1);
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
+        // SAFETY: `slot` is valid while the closure is called, the memory buffer is
+        // pinned and valid.
+        unsafe {
+            init::pin_init_from_closure(move |slot: *mut Self| {
+                (*slot).set_buf(buf);
+                (*slot).mark_end();
+                Ok(())
+            })
+        }
+    }
+
+    /// Obtain [`Pin<&ScatterList>`] from raw pointer.
+    pub fn as_ref(entry: *mut bindings::scatterlist) -> Option<Pin<&'a Self>> {
+        match entry.is_null() {
+            true => None,
+            // SAFETY: `entry` is non-null and valid.
+            false => Some(Pin::new(unsafe { &*(entry as *const ScatterList<'_>) })),
+        }
+    }
+
+    /// Obtain [`Pin<&mut ScatterList>`] from raw pointer.
+    pub fn as_mut(entry: *mut bindings::scatterlist) -> Option<Pin<&'a mut Self>> {
+        match entry.is_null() {
+            true => None,
+            // SAFETY: `entry` is non-null and valid.
+            false => Some(Pin::new(unsafe { &mut *(entry as *mut ScatterList<'_>) })),
+        }
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
+    /// It is only valid after this scatterlist has been mapped to some bus address
+    /// and then called `set_dma` method to setup it.
+    pub fn dma_address(&self) -> usize {
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        unsafe { (*self.opaque.get()).dma_address as _ }
+    }
+
+    /// Return the mapped DMA length.
+    ///
+    /// # Safety
+    ///
+    /// It is only valid after this scatterlist has been mapped to some bus address
+    /// and then called `set_dma` method to setup it.
+    #[cfg(CONFIG_NEED_SG_DMA_LENGTH)]
+    pub fn dma_length(&self) -> usize {
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        unsafe { (*self.opaque.get()).dma_length as _ }
+    }
+
+    /// Return the mapped DMA length.
+    ///
+    /// # Safety
+    ///
+    /// It is only valid after this scatterlist has been mapped to some bus address
+    /// and then called `set_dma` method to setup it.
+    #[cfg(not(CONFIG_NEED_SG_DMA_LENGTH))]
+    pub fn dma_length(&self) -> usize {
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        unsafe { (*self.opaque.get()).length as _ }
+    }
+
+    /// Setup the DMA address and length.
+    #[cfg(CONFIG_NEED_SG_DMA_LENGTH)]
+    pub fn set_dma(&mut self, addr: usize, len: usize) {
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        unsafe {
+            (*self.opaque.get()).dma_address = addr as _;
+            (*self.opaque.get()).dma_length = len as _;
+        }
+        self.dma_mark_bus_address();
+    }
+
+    /// Setup the DMA address and length.
+    #[cfg(not(CONFIG_NEED_SG_DMA_LENGTH))]
+    pub fn set_dma(&mut self, addr: usize, len: usize) {
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        unsafe {
+            (*self.opaque.get()).dma_address = addr as _;
+            (*self.opaque.get()).length = len as _;
+        }
+        self.dma_mark_bus_address();
+    }
+
+    /// Return `true` if it is mapped with a DMA address.
+    pub fn is_dma_bus_address(&self) -> bool {
+        #[cfg(CONFIG_PCI_P2PDMA)]
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        unsafe {
+            ((*self.opaque.get()).dma_flags & bindings::SG_DMA_BUS_ADDRESS) != 0
+        }
+        #[cfg(not(CONFIG_PCI_P2PDMA))]
+        false
+    }
+
+    /// Mark it as mapped to a DMA address.
+    pub fn dma_mark_bus_address(&mut self) {
+        #[cfg(CONFIG_PCI_P2PDMA)]
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        unsafe {
+            (*self.opaque.get()).dma_flags |= bindings::SG_DMA_BUS_ADDRESS;
+        }
+    }
+
+    /// Mark it as `not` mapped to a DMA address.
+    pub fn dma_unmark_bus_address(&mut self) {
+        #[cfg(CONFIG_PCI_P2PDMA)]
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        unsafe {
+            (*self.opaque.get()).dma_flags &= !bindings::SG_DMA_BUS_ADDRESS;
+        }
+    }
+
+    /// Return `true` if it is pointed to another scatterlist.
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
+    /// Transfer this scatterlist as a chainable pointer to `sgl`.
+    fn chain_sgl(&mut self, sgl: Pin<&mut ScatterList<'_>>) {
+        let addr = sgl.opaque.get() as u64;
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        unsafe {
+            (*self.opaque.get()).offset = 0;
+            (*self.opaque.get()).length = 0;
+            (*self.opaque.get()).page_link =
+                (addr | bindings::SG_CHAIN as u64) & !(bindings::SG_END as u64);
+        }
+    }
+
+    /// Return `true` if it is the last valid scatterlist, not include the chainable
+    /// entry (see [`SgTable`]).
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
+    /// Mark it as the last valid entry in a list.
+    fn mark_end(&mut self) {
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        unsafe {
+            (*self.opaque.get()).page_link |= bindings::SG_END as u64;
+            (*self.opaque.get()).page_link &= !(bindings::SG_CHAIN as u64);
+        }
+    }
+
+    /// Mark it as a normal entry in a list.
+    fn unmark_end(&mut self) {
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
+    /// Return the total count of entries in scatterlist.
+    ///
+    /// Allows to know how many entries are in scatterlist, taking into account
+    /// chaining as well (see [`SgTable`]).
+    pub fn count(&self) -> usize {
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        unsafe { bindings::sg_nents(self.opaque.get()) as _ }
+    }
+}
+
+/// An iterator that yields [`Pin<&ScatterList>`].
+///
+/// Only iterate valid scatterlist entries, chainable entry will be skipped.
+pub struct Iter<'a>(Option<Pin<&'a ScatterList<'a>>>);
+
+impl<'a> Iterator for Iter<'a> {
+    type Item = Pin<&'a ScatterList<'a>>;
+
+    fn next(&mut self) -> Option<Self::Item> {
+        if self.0.is_none() {
+            return None;
+        }
+        let ptr = self.0.as_ref().unwrap().opaque.get();
+        // SAFETY: `ptr` is from `self.opaque`, it is valid by the type invariant.
+        let next = unsafe { bindings::sg_next(ptr) };
+        self.0 = ScatterList::as_ref(next);
+        ScatterList::as_ref(ptr)
+    }
+}
+
+/// An iterator that yields [`Pin<&mut ScatterList>`].
+///
+/// Only iterate valid scatterlist entries, chainable entry will be skipped.
+pub struct IterMut<'a>(Option<Pin<&'a mut ScatterList<'a>>>);
+
+impl<'a> Iterator for IterMut<'a> {
+    type Item = Pin<&'a mut ScatterList<'a>>;
+
+    fn next(&mut self) -> Option<Self::Item> {
+        if self.0.is_none() {
+            return None;
+        }
+        let ptr = self.0.as_ref().unwrap().opaque.get();
+        // SAFETY: `ptr` is from `self.opaque`, it is valid by the type invariant.
+        let next = unsafe { bindings::sg_next(ptr) };
+        self.0 = ScatterList::as_mut(next);
+        ScatterList::as_mut(ptr)
+    }
+}
+
+impl ScatterList<'_> {
+    /// Get an iterator for immutable references.
+    pub fn iter(&self) -> Iter<'_> {
+        Iter(ScatterList::as_ref(self.opaque.get()))
+    }
+
+    /// Get an iterator for mutable references.
+    pub fn iter_mut(&mut self) -> IterMut<'_> {
+        IterMut(ScatterList::as_mut(self.opaque.get()))
+    }
+}
-- 
2.40.1

