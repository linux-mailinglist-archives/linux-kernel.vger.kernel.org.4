Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01E36F53F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjECJH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjECJHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:07:25 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9764691
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 02:07:19 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3063afa2372so1356511f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 02:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1683104838; x=1685696838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2OF8cEuaV6eZXvZ8+TxAkEcAWTLOcEvP8M1z8Cu3eg=;
        b=gxwZbpfudAGlkc9suPmtflL1jblQr4MK2hN1E3gaOGf/Plu3em+uZBGDw0rNUr7SUW
         EFB1a9htiLdSYQkjbn0JwIhIuQzJvNeRrzMlV0eXOLXXzIMN08VTuR5LYMKTn7m05OvH
         9LHtC/oRDhdH3ACVUabMlgXW9Ewt8dD9XDI4Ez+21QfYADeNMEfiUmJzzu0XcckSKJuW
         Nj3Eh8mnhKzN9/T17uqbvi142/KhX1PBU6Qk/kU/ro0xuE5e8kN3AfwwdKqZvdZVSRvp
         4qO3v7fHN7bd8dDrEFaz1iXrwav7RAETaSSc1oLICAvTlYivVQel8jdUiGT3J45aYlDO
         jWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683104838; x=1685696838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2OF8cEuaV6eZXvZ8+TxAkEcAWTLOcEvP8M1z8Cu3eg=;
        b=B3djbIyFvFI1xcdYRleM7my6CV2w9AGmi0Js/kbqc5yaZdghRmV013oVBgH/RGSrX/
         uwutFZUtCJjbSCtD4QXxRaAmofOZgkgEWbDc2MkQ0jEjFkpCfwzIIgGd+5fTvhO8566O
         rO0eWgAKDtOCgXZgUq2bUTSLSXrqfT/T1vu7NBg7PvqsOdC15ne+wRVXusIFCJzQoxA6
         a+UrziC21rfJwkOro1mllKR1bLKhA1ab9yoRqRzmsPiV+Bueffv5nf4HAMX24tmQQ+A7
         CahJyDikTuXNJVfAybXwCxIJ5lcmZQGu+AhscxDX+DzwHsv6qbd7WMXnMifsHYl6GXsH
         sjAA==
X-Gm-Message-State: AC+VfDzqkwFbW16BVS1rN61ShpWfUt0Dr8AOWAwCCE/aYvXbMNeCywjB
        Zixf9suOGvFwXGS8nQJHSRVwyg==
X-Google-Smtp-Source: ACHHUZ7yrDB5gpNUkKE0X5q8MEbvZmkfVFN8rXKsdmGE0Vy4CSxFk+RB6D8+DyE/dyNCU1ItHJSB8g==
X-Received: by 2002:a05:6000:1145:b0:306:2cf5:79dc with SMTP id d5-20020a056000114500b003062cf579dcmr6255554wrx.35.1683104838080;
        Wed, 03 May 2023 02:07:18 -0700 (PDT)
Received: from localhost ([147.161.155.99])
        by smtp.gmail.com with ESMTPSA id t15-20020adfe44f000000b002f00793bd7asm33035982wrm.27.2023.05.03.02.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 02:07:17 -0700 (PDT)
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
Subject: [RFC PATCH 02/11] rust: add `pages` module for handling page allocation
Date:   Wed,  3 May 2023 11:06:59 +0200
Message-Id: <20230503090708.2524310-3-nmi@metaspace.dk>
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

This patch adds support for working with pages of order 0. Support for pages
with higher order is deferred. Page allocation flags are fixed in this patch.
Future work might allow the user to specify allocation flags.

This patch is a heavily modified version of code available in the rust tree [1],
primarily adding support for multiple page mapping strategies.

[1] https://github.com/rust-for-Linux/linux/tree/bc22545f38d74473cfef3e9fd65432733435b79f/rust/kernel/pages.rs

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 rust/helpers.c       |  31 +++++
 rust/kernel/lib.rs   |   6 +
 rust/kernel/pages.rs | 284 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 321 insertions(+)
 create mode 100644 rust/kernel/pages.rs

diff --git a/rust/helpers.c b/rust/helpers.c
index 5dd5e325b7cc..9bd9d95da951 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -27,6 +27,7 @@
 #include <linux/sched/signal.h>
 #include <linux/wait.h>
 #include <linux/radix-tree.h>
+#include <linux/highmem.h>
 
 __noreturn void rust_helper_BUG(void)
 {
@@ -150,6 +151,36 @@ void **rust_helper_radix_tree_next_slot(void **slot,
 }
 EXPORT_SYMBOL_GPL(rust_helper_radix_tree_next_slot);
 
+void *rust_helper_kmap(struct page *page)
+{
+	return kmap(page);
+}
+EXPORT_SYMBOL_GPL(rust_helper_kmap);
+
+void rust_helper_kunmap(struct page *page)
+{
+	return kunmap(page);
+}
+EXPORT_SYMBOL_GPL(rust_helper_kunmap);
+
+void *rust_helper_kmap_atomic(struct page *page)
+{
+	return kmap_atomic(page);
+}
+EXPORT_SYMBOL_GPL(rust_helper_kmap_atomic);
+
+void rust_helper_kunmap_atomic(void *address)
+{
+	kunmap_atomic(address);
+}
+EXPORT_SYMBOL_GPL(rust_helper_kunmap_atomic);
+
+struct page *rust_helper_alloc_pages(gfp_t gfp_mask, unsigned int order)
+{
+	return alloc_pages(gfp_mask, order);
+}
+EXPORT_SYMBOL_GPL(rust_helper_alloc_pages);
+
 /*
  * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
  * as the Rust `usize` type, so we can use it in contexts where Rust
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index a85cb6aae8d6..8bef6686504b 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -38,6 +38,7 @@ mod build_assert;
 pub mod error;
 pub mod init;
 pub mod ioctl;
+pub mod pages;
 pub mod prelude;
 pub mod print;
 pub mod radix_tree;
@@ -57,6 +58,11 @@ pub use uapi;
 #[doc(hidden)]
 pub use build_error::build_error;
 
+/// Page size defined in terms of the `PAGE_SHIFT` macro from C.
+///
+/// [`PAGE_SHIFT`]: ../../../include/asm-generic/page.h
+pub const PAGE_SIZE: u32 = 1 << bindings::PAGE_SHIFT;
+
 /// Prefix to appear before log messages printed from within the `kernel` crate.
 const __LOG_PREFIX: &[u8] = b"rust_kernel\0";
 
diff --git a/rust/kernel/pages.rs b/rust/kernel/pages.rs
new file mode 100644
index 000000000000..ed51b053dd5d
--- /dev/null
+++ b/rust/kernel/pages.rs
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Kernel page allocation and management.
+//!
+//! This module currently provides limited support. It supports pages of order 0
+//! for most operations. Page allocation flags are fixed.
+
+use crate::{bindings, error::code::*, error::Result, PAGE_SIZE};
+use core::{marker::PhantomData, ptr};
+
+/// A set of physical pages.
+///
+/// `Pages` holds a reference to a set of pages of order `ORDER`. Having the order as a generic
+/// const allows the struct to have the same size as a pointer.
+///
+/// # Invariants
+///
+/// The pointer `Pages::pages` is valid and points to 2^ORDER pages.
+pub struct Pages<const ORDER: u32> {
+    pub(crate) pages: *mut bindings::page,
+}
+
+impl<const ORDER: u32> Pages<ORDER> {
+    /// Allocates a new set of contiguous pages.
+    pub fn new() -> Result<Self> {
+        let pages = unsafe {
+            bindings::alloc_pages(
+                bindings::GFP_KERNEL | bindings::__GFP_ZERO | bindings::___GFP_HIGHMEM,
+                ORDER,
+            )
+        };
+        if pages.is_null() {
+            return Err(ENOMEM);
+        }
+        // INVARIANTS: We checked that the allocation above succeeded.
+        // SAFETY: We allocated pages above
+        Ok(unsafe { Self::from_raw(pages) })
+    }
+
+    /// Create a `Pages` from a raw `struct page` pointer
+    ///
+    /// # Safety
+    ///
+    /// Caller must own the pages pointed to by `ptr` as these will be freed
+    /// when the returned `Pages` is dropped.
+    pub unsafe fn from_raw(ptr: *mut bindings::page) -> Self {
+        Self { pages: ptr }
+    }
+}
+
+impl Pages<0> {
+    #[inline(always)]
+    fn check_offset_and_map<I: MappingInfo>(
+        &self,
+        offset: usize,
+        len: usize,
+    ) -> Result<PageMapping<'_, I>>
+    where
+        Pages<0>: MappingActions<I>,
+    {
+        let end = offset.checked_add(len).ok_or(EINVAL)?;
+        if end as u32 > PAGE_SIZE {
+            return Err(EINVAL);
+        }
+
+        let mapping = <Self as MappingActions<I>>::map(self);
+
+        Ok(mapping)
+    }
+
+    #[inline(always)]
+    unsafe fn read_internal<I: MappingInfo>(
+        &self,
+        dest: *mut u8,
+        offset: usize,
+        len: usize,
+    ) -> Result
+    where
+        Pages<0>: MappingActions<I>,
+    {
+        let mapping = self.check_offset_and_map::<I>(offset, len)?;
+
+        unsafe { ptr::copy_nonoverlapping((mapping.ptr as *mut u8).add(offset), dest, len) };
+        Ok(())
+    }
+
+    /// Maps the pages and reads from them into the given buffer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the destination buffer is valid for the given
+    /// length. Additionally, if the raw buffer is intended to be recast, they
+    /// must ensure that the data can be safely cast;
+    /// [`crate::io_buffer::ReadableFromBytes`] has more details about it.
+    /// `dest` may not point to the source page.
+    #[inline(always)]
+    pub unsafe fn read(&self, dest: *mut u8, offset: usize, len: usize) -> Result {
+        unsafe { self.read_internal::<NormalMappingInfo>(dest, offset, len) }
+    }
+
+    /// Maps the pages and reads from them into the given buffer. The page is
+    /// mapped atomically.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the destination buffer is valid for the given
+    /// length. Additionally, if the raw buffer is intended to be recast, they
+    /// must ensure that the data can be safely cast;
+    /// [`crate::io_buffer::ReadableFromBytes`] has more details about it.
+    /// `dest` may not point to the source page.
+    #[inline(always)]
+    pub unsafe fn read_atomic(&self, dest: *mut u8, offset: usize, len: usize) -> Result {
+        unsafe { self.read_internal::<AtomicMappingInfo>(dest, offset, len) }
+    }
+
+    #[inline(always)]
+    unsafe fn write_internal<I: MappingInfo>(
+        &self,
+        src: *const u8,
+        offset: usize,
+        len: usize,
+    ) -> Result
+    where
+        Pages<0>: MappingActions<I>,
+    {
+        let mapping = self.check_offset_and_map::<I>(offset, len)?;
+
+        unsafe { ptr::copy_nonoverlapping(src, (mapping.ptr as *mut u8).add(offset), len) };
+        Ok(())
+    }
+
+    /// Maps the pages and writes into them from the given buffer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the buffer is valid for the given length.
+    /// Additionally, if the page is (or will be) mapped by userspace, they must
+    /// ensure that no kernel data is leaked through padding if it was cast from
+    /// another type; [`crate::io_buffer::WritableToBytes`] has more details
+    /// about it. `src` must not point to the destination page.
+    #[inline(always)]
+    pub unsafe fn write(&self, src: *const u8, offset: usize, len: usize) -> Result {
+        unsafe { self.write_internal::<NormalMappingInfo>(src, offset, len) }
+    }
+
+    /// Maps the pages and writes into them from the given buffer. The page is
+    /// mapped atomically.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the buffer is valid for the given length.
+    /// Additionally, if the page is (or will be) mapped by userspace, they must
+    /// ensure that no kernel data is leaked through padding if it was cast from
+    /// another type; [`crate::io_buffer::WritableToBytes`] has more details
+    /// about it. `src` must not point to the destination page.
+    #[inline(always)]
+    pub unsafe fn write_atomic(&self, src: *const u8, offset: usize, len: usize) -> Result {
+        unsafe { self.write_internal::<AtomicMappingInfo>(src, offset, len) }
+    }
+
+    /// Maps the page at index 0.
+    #[inline(always)]
+    pub fn kmap(&self) -> PageMapping<'_, NormalMappingInfo> {
+        let ptr = unsafe { bindings::kmap(self.pages) };
+
+        PageMapping {
+            page: self.pages,
+            ptr,
+            _phantom: PhantomData,
+            _phantom2: PhantomData,
+        }
+    }
+
+    /// Atomically Maps the page at index 0.
+    #[inline(always)]
+    pub fn kmap_atomic(&self) -> PageMapping<'_, AtomicMappingInfo> {
+        let ptr = unsafe { bindings::kmap_atomic(self.pages) };
+
+        PageMapping {
+            page: self.pages,
+            ptr,
+            _phantom: PhantomData,
+            _phantom2: PhantomData,
+        }
+    }
+}
+
+impl<const ORDER: u32> Drop for Pages<ORDER> {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we know the pages are allocated with the given order.
+        unsafe { bindings::__free_pages(self.pages, ORDER) };
+    }
+}
+
+/// Specifies the type of page mapping
+pub trait MappingInfo {}
+
+/// Encapsulates methods to map and unmap pages
+pub trait MappingActions<I: MappingInfo>
+where
+    Pages<0>: MappingActions<I>,
+{
+    /// Map a page into the kernel address scpace
+    fn map(pages: &Pages<0>) -> PageMapping<'_, I>;
+
+    /// Unmap a page specified by `mapping`
+    ///
+    /// # Safety
+    ///
+    /// Must only be called by `PageMapping::drop()`.
+    unsafe fn unmap(mapping: &PageMapping<'_, I>);
+}
+
+/// A type state indicating that pages were mapped atomically
+pub struct AtomicMappingInfo;
+impl MappingInfo for AtomicMappingInfo {}
+
+/// A type state indicating that pages were not mapped atomically
+pub struct NormalMappingInfo;
+impl MappingInfo for NormalMappingInfo {}
+
+impl MappingActions<AtomicMappingInfo> for Pages<0> {
+    #[inline(always)]
+    fn map(pages: &Pages<0>) -> PageMapping<'_, AtomicMappingInfo> {
+        pages.kmap_atomic()
+    }
+
+    #[inline(always)]
+    unsafe fn unmap(mapping: &PageMapping<'_, AtomicMappingInfo>) {
+        // SAFETY: An instance of `PageMapping` is created only when `kmap` succeeded for the given
+        // page, so it is safe to unmap it here.
+        unsafe { bindings::kunmap_atomic(mapping.ptr) };
+    }
+}
+
+impl MappingActions<NormalMappingInfo> for Pages<0> {
+    #[inline(always)]
+    fn map(pages: &Pages<0>) -> PageMapping<'_, NormalMappingInfo> {
+        pages.kmap()
+    }
+
+    #[inline(always)]
+    unsafe fn unmap(mapping: &PageMapping<'_, NormalMappingInfo>) {
+        // SAFETY: An instance of `PageMapping` is created only when `kmap` succeeded for the given
+        // page, so it is safe to unmap it here.
+        unsafe { bindings::kunmap(mapping.page) };
+    }
+}
+
+/// An owned page mapping. When this struct is dropped, the page is unmapped.
+pub struct PageMapping<'a, I: MappingInfo>
+where
+    Pages<0>: MappingActions<I>,
+{
+    page: *mut bindings::page,
+    ptr: *mut core::ffi::c_void,
+    _phantom: PhantomData<&'a i32>,
+    _phantom2: PhantomData<I>,
+}
+
+impl<'a, I: MappingInfo> PageMapping<'a, I>
+where
+    Pages<0>: MappingActions<I>,
+{
+    /// Return a pointer to the wrapped `struct page`
+    #[inline(always)]
+    pub fn get_ptr(&self) -> *mut core::ffi::c_void {
+        self.ptr
+    }
+}
+
+// Because we do not have Drop specialization, we have to do this dance. Life
+// would be much more simple if we could have `impl Drop for PageMapping<'_,
+// Atomic>` and `impl Drop for PageMapping<'_, NotAtomic>`
+impl<I: MappingInfo> Drop for PageMapping<'_, I>
+where
+    Pages<0>: MappingActions<I>,
+{
+    #[inline(always)]
+    fn drop(&mut self) {
+        // SAFETY: We are OK to call this because we are `PageMapping::drop()`
+        unsafe { <Pages<0> as MappingActions<I>>::unmap(self) }
+    }
+}
-- 
2.40.0

