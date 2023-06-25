Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA97273D0CF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjFYMR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjFYMRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:17:25 -0400
Received: from out0-210.mail.aliyun.com (out0-210.mail.aliyun.com [140.205.0.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10660E76;
        Sun, 25 Jun 2023 05:17:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047192;MF=changxian.cqs@antgroup.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---.TdJuHXi_1687695430;
Received: from localhost(mailfrom:changxian.cqs@antgroup.com fp:SMTPD_---.TdJuHXi_1687695430)
          by smtp.aliyun-inc.com;
          Sun, 25 Jun 2023 20:17:11 +0800
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
        "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>,
        "Asahi Lina" <lina@asahilina.net>, <rust-for-linux@vger.kernel.org>
Subject: [RFC PATCH 1/8] rust: kernel: add basic abstractions for device-mapper
Date:   Sun, 25 Jun 2023 20:16:50 +0800
Message-Id: <20230625121657.3631109-2-changxian.cqs@antgroup.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230625121657.3631109-1-changxian.cqs@antgroup.com>
References: <20230625121657.3631109-1-changxian.cqs@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Declare `vtable` for basic target operations.
- Wrap `target_type` to register/unregister target.
- Wrap `dm_target`/`dm_dev` to handle io request.
- Add a dummy `bio` wrapper.

Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/device_mapper.rs    | 382 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 3 files changed, 384 insertions(+)
 create mode 100644 rust/kernel/device_mapper.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3e601ce2548d..807fc9cf41b8 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -11,6 +11,7 @@
 #include <linux/refcount.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/device-mapper.h>
 
 /* `bindgen` gets confused at certain things. */
 const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
diff --git a/rust/kernel/device_mapper.rs b/rust/kernel/device_mapper.rs
new file mode 100644
index 000000000000..28286b373b59
--- /dev/null
+++ b/rust/kernel/device_mapper.rs
@@ -0,0 +1,382 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Device Mapper.
+//!
+//! C header: [`include/linux/device-mapper.h`](../../../../include/linux/device-mapper.h)
+
+use core::marker::PhantomData;
+use core::ops::Index;
+use core::ptr::{addr_of, NonNull};
+
+use crate::error::to_result;
+use crate::prelude::*;
+use crate::str::CStr;
+use crate::types::Opaque;
+
+/// Declare operations that a device mapper target can do.
+#[vtable]
+pub trait TargetOperations: Sized {
+    /// Persist user data.
+    type Private: Sync;
+
+    /// Constructor. The target will already have the table, type, begin and
+    /// len fields filled in. A `Private` struct can be returned to persist
+    /// its own context.
+    fn ctr(t: &mut Target<Self>, args: Args) -> Result<Box<Self::Private>>;
+
+    /// Destructor. The target could clean up anything hidden in `Private`,
+    /// and `Private` itself can be dropped automatically.
+    fn dtr(t: &mut Target<Self>);
+
+    /// Map block IOs. Return [`MapState`] to indicate how to handle the `bio`
+    /// later (end or resubmit).
+    fn map(t: &mut Target<Self>, bio: Pin<&mut Bio>) -> MapState;
+}
+
+/// Wrap the kernel struct `target_type`.
+///
+/// It contains a struct `list_head` for internal device-mapper use, so it
+/// should be pinned. Users can use this struct to register/unregister their
+/// own device mapper target.
+#[pin_data(PinnedDrop)]
+pub struct TargetType {
+    #[pin]
+    opaque: Opaque<bindings::target_type>,
+}
+
+/// Define target feature type.
+pub type Feature = u64;
+
+// SAFETY: It's OK to access `TargetType` from multiple threads. The
+// `dm_register_target` and `dm_unregister_target` provides its own
+// synchronization.
+unsafe impl Sync for TargetType {}
+
+macro_rules! check_target_operations {
+    ($tt:expr, $(($op:ident, $filed:ident, $func:ident),)+) => {$(
+        if <T as TargetOperations>::$op {
+            (*$tt).$filed = Some(TargetType::$func::<T>);
+        }
+    )+};
+}
+
+impl TargetType {
+    /// Provide an in-place constructor to register a new device mapper target.
+    pub fn register<T: TargetOperations>(
+        module: &'static ThisModule,
+        name: &'static CStr,
+        version: [u32; 3],
+        feature: Feature,
+    ) -> impl PinInit<Self, Error> {
+        // SAFETY: `slot` is valid while the closure is called.
+        unsafe {
+            init::pin_init_from_closure(move |slot: *mut Self| {
+                // `slot` contains uninit memory, avoid creating a reference.
+                let opaque = addr_of!((*slot).opaque);
+                let tt = Opaque::raw_get(opaque);
+
+                (*tt).module = module.0;
+                (*tt).name = name.as_char_ptr();
+                (*tt).version = version;
+                (*tt).features = feature;
+
+                check_target_operations!(
+                    tt,
+                    (HAS_CTR, ctr, dm_ctr_fn),
+                    (HAS_DTR, dtr, dm_dtr_fn),
+                    (HAS_MAP, map, dm_map_fn),
+                );
+
+                to_result(bindings::dm_register_target(tt))
+            })
+        }
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for TargetType {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY: `self.opaque` are initialized by the `register` constructor,
+        // so it's valid.
+        unsafe {
+            bindings::dm_unregister_target(self.opaque.get());
+        }
+    }
+}
+
+impl TargetType {
+    unsafe extern "C" fn dm_ctr_fn<T: TargetOperations>(
+        target: *mut bindings::dm_target,
+        argc: core::ffi::c_uint,
+        argv: *mut *mut core::ffi::c_char,
+    ) -> core::ffi::c_int {
+        // SAFETY: the kernel splits arguments by `dm_split_args`, then pass
+        // suitable `argc` and `argv` to `dm_ctr_fn`. If `argc` is not zero,
+        // `argv` is non-null and valid.
+        let args = unsafe { Args::new(argc, argv) };
+
+        // SAFETY: the kernel should pass a valid `dm_target`.
+        let t = unsafe { Target::borrow_mut(target) };
+        T::ctr(t, args).map_or_else(
+            |e| e.to_errno(),
+            // SAFETY: the kernel should pass a valid `dm_target`.
+            |p| unsafe {
+                (*target).private = Box::into_raw(p) as _;
+                0
+            },
+        )
+    }
+    unsafe extern "C" fn dm_dtr_fn<T: TargetOperations>(ti: *mut bindings::dm_target) {
+        // SAFETY: the kernel should pass a valid `dm_target`.
+        let t = unsafe { Target::borrow_mut(ti) };
+        T::dtr(t);
+        // SAFETY: `private` is constructed in `dm_ctr_fn`, and we drop it here.
+        unsafe {
+            let ptr = (*ti).private as *mut T::Private;
+            drop(Box::from_raw(ptr));
+            (*ti).private = core::ptr::null_mut();
+        }
+    }
+    unsafe extern "C" fn dm_map_fn<T: TargetOperations>(
+        ti: *mut bindings::dm_target,
+        bio: *mut bindings::bio,
+    ) -> core::ffi::c_int {
+        // SAFETY: the kernel should pass a valid `dm_target` and `bio`.
+        unsafe {
+            let t = Target::borrow_mut(ti);
+            let bio = Bio::from_raw(bio);
+            T::map(t, bio) as _
+        }
+    }
+}
+
+/// Wrap the kernel struct `dm_target`.
+///
+/// This struct represents a device mapper target. And the device mapper
+/// core will alloc/free `dm_target` instances, so we just `borrow` it.
+/// It also holds a `Private` struct, which is used to persist user's data,
+/// and can be accessed by the `private` method.
+pub struct Target<T: TargetOperations + Sized> {
+    opaque: Opaque<bindings::dm_target>,
+    _p: PhantomData<*mut T::Private>,
+}
+
+impl<T: TargetOperations> Target<T> {
+    unsafe fn borrow<'a>(ptr: *const bindings::dm_target) -> &'a Self {
+        // SAFETY: the caller should pass a valid `ptr`.
+        unsafe { &*(ptr as *const Self) }
+    }
+
+    unsafe fn borrow_mut<'a>(ptr: *mut bindings::dm_target) -> &'a mut Self {
+        // SAFETY: the caller should pass a valid `ptr`.
+        unsafe { &mut *(ptr as *mut Self) }
+    }
+
+    /// Access user's private data.
+    pub fn private(&mut self) -> Option<Pin<&mut T::Private>> {
+        let t = self.opaque.get();
+        // SAFETY: `self.opaque` is borrowed from foreign pointer, should be valid.
+        // And 'p' is non-null and assigned in `dm_ctr_fn`, so it's valid.
+        unsafe {
+            ((*t).private as *mut T::Private)
+                .as_mut()
+                .map(|p| Pin::new_unchecked(p))
+        }
+    }
+
+    /// Return the target name.
+    pub fn name(&self) -> &CStr {
+        // SAFETY: `self.opaque` is borrowed from foreign pointer, should be valid.
+        unsafe {
+            let name = (*(*self.opaque.get()).type_).name;
+            CStr::from_char_ptr(name)
+        }
+    }
+
+    /// Return the target version.
+    pub fn version(&self) -> [u32; 3] {
+        // SAFETY: `self.opaque` is borrowed from foreign pointer, should be valid.
+        unsafe { (*(*self.opaque.get()).type_).version }
+    }
+
+    /// Return the target begin sector.
+    pub fn begin_sector(&self) -> usize {
+        // SAFETY: `self.opaque` is borrowed from foreign pointer, should be valid.
+        unsafe { (*self.opaque.get()).begin as _ }
+    }
+
+    /// Return the target total sectors.
+    pub fn total_sectors(&self) -> usize {
+        // SAFETY: `self.opaque` is borrowed from foreign pointer, should be valid.
+        unsafe { (*self.opaque.get()).len as _ }
+    }
+
+    /// Get the underlying device by `path`. The `dm_put_device` will be called when
+    /// [`TargetDevice`] is dropped.
+    pub fn get_device(&mut self, path: &CStr) -> Result<TargetDevice<T>> {
+        let mut dd = core::ptr::null_mut();
+        // SAFETY: `self.opaque` is borrowed from foreign pointer, should be valid.
+        unsafe {
+            let mode = bindings::dm_table_get_mode((*self.opaque.get()).table);
+            match bindings::dm_get_device(self.opaque.get(), path.as_char_ptr(), mode, &mut dd) {
+                0 => {
+                    let ti = self.opaque.get();
+                    Ok(TargetDevice::from_raw(ti, dd))
+                }
+                err => Err(Error::from_errno(err)),
+            }
+        }
+    }
+}
+
+/// Represent an underlying device of a device mapper target.
+///
+/// We also holds a pointer to `dm_target`, so that we can call
+/// `dm_put_device` in `drop`, to close the device correctly.
+pub struct TargetDevice<T: TargetOperations + Sized> {
+    ti: NonNull<bindings::dm_target>,
+    dev: NonNull<bindings::dm_dev>,
+    _p: PhantomData<*mut Target<T>>,
+}
+
+impl<T: TargetOperations> TargetDevice<T> {
+    unsafe fn from_raw(ti: *mut bindings::dm_target, dd: *mut bindings::dm_dev) -> Self {
+        // SAFETY: the caller should pass valid `dm_target` and `dm_dev`.
+        unsafe {
+            Self {
+                ti: NonNull::new_unchecked(ti),
+                dev: NonNull::new_unchecked(dd),
+                _p: PhantomData,
+            }
+        }
+    }
+
+    /// Borrow the device mapper target.
+    pub fn target(&self) -> &Target<T> {
+        // SAFETY: the `from_raw` caller should pass valid `ti` pointer.
+        unsafe { Target::borrow(self.ti.as_ptr()) }
+    }
+
+    /// Borrow the device mapper target mutably.
+    pub fn mut_target(&mut self) -> &mut Target<T> {
+        // SAFETY: the `from_raw` caller should pass valid `ti` pointer.
+        unsafe { Target::borrow_mut(self.ti.as_ptr()) }
+    }
+
+    /// Return the device name.
+    pub fn device_name(&self) -> &CStr {
+        // SAFETY: the `from_raw` caller should pass valid `dev` pointer.
+        unsafe {
+            let name = (*self.dev.as_ptr()).name.as_ptr();
+            CStr::from_char_ptr(name)
+        }
+    }
+
+    /// Return the total device sectors.
+    pub fn device_sectors(&self) -> usize {
+        // SAFETY: the `from_raw` caller should pass valid `dev` pointer.
+        unsafe { (*(*self.dev.as_ptr()).bdev).bd_nr_sectors as _ }
+    }
+}
+
+impl<T: TargetOperations> Drop for TargetDevice<T> {
+    fn drop(&mut self) {
+        // SAFETY: the `from_raw` caller should pass valid `ti` and `dev`.
+        unsafe { bindings::dm_put_device(self.ti.as_ptr(), self.dev.as_ptr()) }
+    }
+}
+
+/// The return values of target map function, i.e., [`TargetOperations::map`].
+#[repr(u32)]
+pub enum MapState {
+    /// The target will handle the io by resubmitting it later.
+    Submitted = bindings::DM_MAPIO_SUBMITTED,
+
+    /// Simple remap complete.
+    Remapped = bindings::DM_MAPIO_REMAPPED,
+
+    /// The target wants to requeue the io.
+    Requeue = bindings::DM_MAPIO_REQUEUE,
+
+    /// The target wants to requeue the io after a delay.
+    DelayRequeue = bindings::DM_MAPIO_DELAY_REQUEUE,
+
+    /// The target wants to complete the io.
+    Kill = bindings::DM_MAPIO_KILL,
+}
+
+/// Wrap the `c_char` arguments, which yields `CStr`.
+pub struct Args {
+    argc: core::ffi::c_uint,
+    argv: *mut *mut core::ffi::c_char,
+}
+
+impl Args {
+    /// The caller should ensure that the number of valid `argv` pointers
+    /// should be exactly `argc`.
+    unsafe fn new(argc: core::ffi::c_uint, argv: *mut *mut core::ffi::c_char) -> Self {
+        Self { argc, argv }
+    }
+
+    /// Return the number of arguments.
+    pub fn len(&self) -> usize {
+        self.argc as _
+    }
+
+    /// Return the `nth` (from zero) argument.
+    ///
+    /// If the index is out of bounds, return `None`.
+    pub fn get(&self, index: usize) -> Option<&CStr> {
+        if self.argc == 0 || index >= self.argc as _ {
+            None
+        } else {
+            // SAFETY: the `new` caller should ensure the number of valid `argv`.
+            unsafe { Some(CStr::from_char_ptr(*self.argv.add(index))) }
+        }
+    }
+}
+
+impl Index<usize> for Args {
+    type Output = CStr;
+
+    /// When using the indexing operator(`[]`), the caller should check the
+    /// length of [`Args`]. If the index is out of bounds, this will [`panic`].
+    fn index(&self, index: usize) -> &Self::Output {
+        if self.argc == 0 || index >= self.argc as _ {
+            panic!(
+                "Index out of bounds: the length is {} but the index is {}.",
+                self.argc, index
+            )
+        } else {
+            // SAFETY: the `new` caller should ensure the number of valid `argv`.
+            unsafe { CStr::from_char_ptr(*self.argv.add(index)) }
+        }
+    }
+}
+
+/// Wrap the kernel struct `bio`.
+///
+/// Dummy.
+#[pin_data]
+pub struct Bio {
+    #[pin]
+    opaque: Opaque<bindings::bio>,
+}
+
+impl Bio {
+    unsafe fn from_raw<'a>(ptr: *mut bindings::bio) -> Pin<&'a mut Self> {
+        // SAFETY: the caller should pass a valid `bio` pointer.
+        unsafe { Pin::new(&mut *(ptr as *mut Self)) }
+    }
+
+    fn op_and_flags(&self) -> u32 {
+        // SAFETY: the `from_raw` caller should pass valid `bio`, so
+        // `self.opaque` is valid too.
+        unsafe { (*self.opaque.get()).bi_opf }
+    }
+
+    /// Return `true` if the bio request is write.
+    pub fn is_write(&self) -> bool {
+        self.op_and_flags() & bindings::req_op_REQ_OP_WRITE != 0
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 85b261209977..3dc19f4642f0 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -31,6 +31,7 @@
 #[cfg(not(testlib))]
 mod allocator;
 mod build_assert;
+pub mod device_mapper;
 pub mod error;
 pub mod init;
 pub mod ioctl;
-- 
2.40.1

