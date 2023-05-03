Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D426F53FC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjECJHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjECJHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:07:37 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3201FE3
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 02:07:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-2fc3f1d6f8cso2976472f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 02:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1683104841; x=1685696841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSA28PAasqbQ6gihh6v56FFurfwvVr3++GQNYiXLBOM=;
        b=vQsE9+nWwjoc0CqWeJtb/ZfNGHy0rUvS1Y6KMIM/8XIALq5wndo94M0A9dNDG/sgx3
         TntjBxyhGd3sPHq81BA5d+rCrZqPK+YW4IthsZPI1CtTP6bLLkexUwvgl31L4ic67Qf3
         3a/12tbFt4/FvWOnftXK8qByjLSFlbpkmQMkf5C8I3hc6vlYpAnFzNFcDxdS2MRw4IEx
         wPbbwhJsNepi1C2Pis2b+onQe5ZIJJr4481QrdlPAHTxbbNDusKuXuoh7FCB5nas1ipJ
         GJZUZOXkGrlNsq2sAq9Ubuo5revBkkMADIqKLVPTnZWg7liUy4NgrQWnKD4vuzI/VlLI
         s34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683104841; x=1685696841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSA28PAasqbQ6gihh6v56FFurfwvVr3++GQNYiXLBOM=;
        b=gubZbuZWBV2BcI1ZfV/2i/NNXAjhxlKHPxxydid1/9yvDoxvQ23FhL8kLh9xqpjmqh
         +evqKAjDStriPfD2YQyIAocLq96s4Lu2mMZmaEJolo1l4/stN9juV482uWMix+3sEIAC
         wdsZhTQ/Lx/zduXdjXs1QuiUHBEU0Gad079WtN3/gqwocQANouajj6PL26f9nCsi7ecK
         2BQaNgISUaW76Vzaig3qYd+phGxEAi4LyqVZPhpLrNac4tmHXB5J3b3BBzi03NVxOUML
         5MSCsGIAS6XgbMaAV04y9/dAQpFOzYR+w5fjo4jroRGIoiwylBq/kL4vXlkSBZ8hKAyY
         r1XA==
X-Gm-Message-State: AC+VfDwezXsJCCFxbU0Z9vwV1r9J7jmKgS2NbWruyO3nFDdOHZWKT8Oi
        9qad3/yNRQVLfGq0C3iT0j2Fhg==
X-Google-Smtp-Source: ACHHUZ7Ksbe7Ooyt5nBUxHytKU58iAJRK1L03foLc8Hcc6DMHl/WjWoe8IHgUJ0g8IzAAH00aNw/ZQ==
X-Received: by 2002:adf:f68c:0:b0:2f5:6430:35c with SMTP id v12-20020adff68c000000b002f56430035cmr13820637wrp.26.1683104841285;
        Wed, 03 May 2023 02:07:21 -0700 (PDT)
Received: from localhost ([147.161.155.99])
        by smtp.gmail.com with ESMTPSA id q11-20020a5d574b000000b003049d7b9f4csm19166645wrw.32.2023.05.03.02.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 02:07:21 -0700 (PDT)
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
Subject: [RFC PATCH 05/11] RUST: add `module_params` macro
Date:   Wed,  3 May 2023 11:07:02 +0200
Message-Id: <20230503090708.2524310-6-nmi@metaspace.dk>
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

This patch includes changes required for Rust kernel modules to utilize module
parameters.

Imported with minor changes from `rust` branch [1], see original code for
attributions.

[1] https://github.com/Rust-for-Linux/linux/tree/bc22545f38d74473cfef3e9fd65432733435b79f

Cc: adamrk <ark.email@gmail.com>
---
 rust/kernel/lib.rs          |   3 +
 rust/kernel/module_param.rs | 501 ++++++++++++++++++++++++++++++++++++
 rust/macros/helpers.rs      |  46 +++-
 rust/macros/module.rs       | 402 +++++++++++++++++++++++++++--
 4 files changed, 920 insertions(+), 32 deletions(-)
 create mode 100644 rust/kernel/module_param.rs

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index cd798d12d97c..a0bd0b0e2aef 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -22,6 +22,7 @@
 #![feature(pin_macro)]
 #![feature(receiver_trait)]
 #![feature(unsize)]
+#![feature(const_mut_refs)]
 
 // Ensure conditional compilation based on the kernel configuration works;
 // otherwise we may silently break things like initcall handling.
@@ -39,6 +40,8 @@ mod build_assert;
 pub mod error;
 pub mod init;
 pub mod ioctl;
+#[doc(hidden)]
+pub mod module_param;
 pub mod pages;
 pub mod prelude;
 pub mod print;
diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
new file mode 100644
index 000000000000..539decbdcd48
--- /dev/null
+++ b/rust/kernel/module_param.rs
@@ -0,0 +1,501 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Types for module parameters.
+//!
+//! C header: [`include/linux/moduleparam.h`](../../../include/linux/moduleparam.h)
+
+use crate::error::{code::*, from_result};
+use crate::str::{CStr, Formatter};
+use core::fmt::Write;
+
+/// Types that can be used for module parameters.
+///
+/// Note that displaying the type in `sysfs` will fail if
+/// [`alloc::string::ToString::to_string`] (as implemented through the
+/// [`core::fmt::Display`] trait) writes more than [`PAGE_SIZE`]
+/// bytes (including an additional null terminator).
+///
+/// [`PAGE_SIZE`]: `crate::PAGE_SIZE`
+pub trait ModuleParam: core::fmt::Display + core::marker::Sized {
+    /// The `ModuleParam` will be used by the kernel module through this type.
+    ///
+    /// This may differ from `Self` if, for example, `Self` needs to track
+    /// ownership without exposing it or allocate extra space for other possible
+    /// parameter values. See [`StringParam`] or [`ArrayParam`] for examples.
+    type Value: ?Sized;
+
+    /// Whether the parameter is allowed to be set without an argument.
+    ///
+    /// Setting this to `true` allows the parameter to be passed without an
+    /// argument (e.g. just `module.param` instead of `module.param=foo`).
+    const NOARG_ALLOWED: bool;
+
+    /// Convert a parameter argument into the parameter value.
+    ///
+    /// `None` should be returned when parsing of the argument fails.
+    /// `arg == None` indicates that the parameter was passed without an
+    /// argument. If `NOARG_ALLOWED` is set to `false` then `arg` is guaranteed
+    /// to always be `Some(_)`.
+    ///
+    /// Parameters passed at boot time will be set before [`kmalloc`] is
+    /// available (even if the module is loaded at a later time). However, in
+    /// this case, the argument buffer will be valid for the entire lifetime of
+    /// the kernel. So implementations of this method which need to allocate
+    /// should first check that the allocator is available (with
+    /// [`crate::bindings::slab_is_available`]) and when it is not available
+    /// provide an alternative implementation which doesn't allocate. In cases
+    /// where the allocator is not available it is safe to save references to
+    /// `arg` in `Self`, but in other cases a copy should be made.
+    ///
+    /// [`kmalloc`]: ../../../include/linux/slab.h
+    fn try_from_param_arg(arg: Option<&'static [u8]>) -> Option<Self>;
+
+    /// Get the current value of the parameter for use in the kernel module.
+    ///
+    /// This function should not be used directly. Instead use the wrapper
+    /// `read` which will be generated by [`macros::module`].
+    fn value(&self) -> &Self::Value;
+
+    /// Set the module parameter from a string.
+    ///
+    /// Used to set the parameter value when loading the module or when set
+    /// through `sysfs`.
+    ///
+    /// # Safety
+    ///
+    /// If `val` is non-null then it must point to a valid null-terminated
+    /// string. The `arg` field of `param` must be an instance of `Self`.
+    unsafe extern "C" fn set_param(
+        val: *const core::ffi::c_char,
+        param: *const crate::bindings::kernel_param,
+    ) -> core::ffi::c_int {
+        let arg = if val.is_null() {
+            None
+        } else {
+            Some(unsafe { CStr::from_char_ptr(val).as_bytes() })
+        };
+        match Self::try_from_param_arg(arg) {
+            Some(new_value) => {
+                let old_value = unsafe { (*param).__bindgen_anon_1.arg as *mut Self };
+                let _ = unsafe { core::ptr::replace(old_value, new_value) };
+                0
+            }
+            None => EINVAL.to_errno(),
+        }
+    }
+
+    /// Write a string representation of the current parameter value to `buf`.
+    ///
+    /// Used for displaying the current parameter value in `sysfs`.
+    ///
+    /// # Safety
+    ///
+    /// `buf` must be a buffer of length at least `kernel::PAGE_SIZE` that is
+    /// writeable. The `arg` field of `param` must be an instance of `Self`.
+    unsafe extern "C" fn get_param(
+        buf: *mut core::ffi::c_char,
+        param: *const crate::bindings::kernel_param,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: The C contracts guarantees that the buffer is at least `PAGE_SIZE` bytes.
+            let mut f = unsafe { Formatter::from_buffer(buf.cast(), crate::PAGE_SIZE as usize) };
+            unsafe { write!(f, "{}\0", *((*param).__bindgen_anon_1.arg as *mut Self)) }?;
+            Ok(f.bytes_written().try_into()?)
+        })
+    }
+
+    /// Drop the parameter.
+    ///
+    /// Called when unloading a module.
+    ///
+    /// # Safety
+    ///
+    /// The `arg` field of `param` must be an instance of `Self`.
+    unsafe extern "C" fn free(arg: *mut core::ffi::c_void) {
+        unsafe { core::ptr::drop_in_place(arg as *mut Self) };
+    }
+}
+
+/// Trait for parsing integers.
+///
+/// Strings beginning with `0x`, `0o`, or `0b` are parsed as hex, octal, or
+/// binary respectively. Strings beginning with `0` otherwise are parsed as
+/// octal. Anything else is parsed as decimal. A leading `+` or `-` is also
+/// permitted. Any string parsed by [`kstrtol()`] or [`kstrtoul()`] will be
+/// successfully parsed.
+///
+/// [`kstrtol()`]: https://www.kernel.org/doc/html/latest/core-api/kernel-api.html#c.kstrtol
+/// [`kstrtoul()`]: https://www.kernel.org/doc/html/latest/core-api/kernel-api.html#c.kstrtoul
+trait ParseInt: Sized {
+    fn from_str_radix(src: &str, radix: u32) -> Result<Self, core::num::ParseIntError>;
+    fn checked_neg(self) -> Option<Self>;
+
+    fn from_str_unsigned(src: &str) -> Result<Self, core::num::ParseIntError> {
+        let (radix, digits) = if let Some(n) = src.strip_prefix("0x") {
+            (16, n)
+        } else if let Some(n) = src.strip_prefix("0X") {
+            (16, n)
+        } else if let Some(n) = src.strip_prefix("0o") {
+            (8, n)
+        } else if let Some(n) = src.strip_prefix("0O") {
+            (8, n)
+        } else if let Some(n) = src.strip_prefix("0b") {
+            (2, n)
+        } else if let Some(n) = src.strip_prefix("0B") {
+            (2, n)
+        } else if src.starts_with('0') {
+            (8, src)
+        } else {
+            (10, src)
+        };
+        Self::from_str_radix(digits, radix)
+    }
+
+    fn from_str(src: &str) -> Option<Self> {
+        match src.bytes().next() {
+            None => None,
+            Some(b'-') => Self::from_str_unsigned(&src[1..]).ok()?.checked_neg(),
+            Some(b'+') => Some(Self::from_str_unsigned(&src[1..]).ok()?),
+            Some(_) => Some(Self::from_str_unsigned(src).ok()?),
+        }
+    }
+}
+
+macro_rules! impl_parse_int {
+    ($ty:ident) => {
+        impl ParseInt for $ty {
+            fn from_str_radix(src: &str, radix: u32) -> Result<Self, core::num::ParseIntError> {
+                $ty::from_str_radix(src, radix)
+            }
+
+            fn checked_neg(self) -> Option<Self> {
+                self.checked_neg()
+            }
+        }
+    };
+}
+
+impl_parse_int!(i8);
+impl_parse_int!(u8);
+impl_parse_int!(i16);
+impl_parse_int!(u16);
+impl_parse_int!(i32);
+impl_parse_int!(u32);
+impl_parse_int!(i64);
+impl_parse_int!(u64);
+impl_parse_int!(isize);
+impl_parse_int!(usize);
+
+macro_rules! impl_module_param {
+    ($ty:ident) => {
+        impl ModuleParam for $ty {
+            type Value = $ty;
+
+            const NOARG_ALLOWED: bool = false;
+
+            fn try_from_param_arg(arg: Option<&'static [u8]>) -> Option<Self> {
+                let bytes = arg?;
+                let utf8 = core::str::from_utf8(bytes).ok()?;
+                <$ty as crate::module_param::ParseInt>::from_str(utf8)
+            }
+
+            #[inline(always)]
+            fn value(&self) -> &Self::Value {
+                self
+            }
+        }
+    };
+}
+
+#[doc(hidden)]
+#[macro_export]
+/// Generate a static [`kernel_param_ops`](../../../include/linux/moduleparam.h) struct.
+///
+/// # Examples
+///
+/// ```ignore
+/// make_param_ops!(
+///     /// Documentation for new param ops.
+///     PARAM_OPS_MYTYPE, // Name for the static.
+///     MyType // A type which implements [`ModuleParam`].
+/// );
+/// ```
+macro_rules! make_param_ops {
+    ($ops:ident, $ty:ty) => {
+        $crate::make_param_ops!(
+            #[doc=""]
+            $ops,
+            $ty
+        );
+    };
+    ($(#[$meta:meta])* $ops:ident, $ty:ty) => {
+        $(#[$meta])*
+        ///
+        /// Static [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+        /// struct generated by [`make_param_ops`].
+        pub static $ops: $crate::bindings::kernel_param_ops = $crate::bindings::kernel_param_ops {
+            flags: if <$ty as $crate::module_param::ModuleParam>::NOARG_ALLOWED {
+                $crate::bindings::KERNEL_PARAM_OPS_FL_NOARG
+            } else {
+                0
+            },
+            set: Some(<$ty as $crate::module_param::ModuleParam>::set_param),
+            get: Some(<$ty as $crate::module_param::ModuleParam>::get_param),
+            free: Some(<$ty as $crate::module_param::ModuleParam>::free),
+        };
+    };
+}
+
+impl_module_param!(i8);
+impl_module_param!(u8);
+impl_module_param!(i16);
+impl_module_param!(u16);
+impl_module_param!(i32);
+impl_module_param!(u32);
+impl_module_param!(i64);
+impl_module_param!(u64);
+impl_module_param!(isize);
+impl_module_param!(usize);
+
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`i8`].
+    PARAM_OPS_I8,
+    i8
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`u8`].
+    PARAM_OPS_U8,
+    u8
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`i16`].
+    PARAM_OPS_I16,
+    i16
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`u16`].
+    PARAM_OPS_U16,
+    u16
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`i32`].
+    PARAM_OPS_I32,
+    i32
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`u32`].
+    PARAM_OPS_U32,
+    u32
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`i64`].
+    PARAM_OPS_I64,
+    i64
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`u64`].
+    PARAM_OPS_U64,
+    u64
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`isize`].
+    PARAM_OPS_ISIZE,
+    isize
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`usize`].
+    PARAM_OPS_USIZE,
+    usize
+);
+
+impl ModuleParam for bool {
+    type Value = bool;
+
+    const NOARG_ALLOWED: bool = true;
+
+    fn try_from_param_arg(arg: Option<&'static [u8]>) -> Option<Self> {
+        match arg {
+            None => Some(true),
+            Some(b"y") | Some(b"Y") | Some(b"1") | Some(b"true") => Some(true),
+            Some(b"n") | Some(b"N") | Some(b"0") | Some(b"false") => Some(false),
+            _ => None,
+        }
+    }
+
+    #[inline(always)]
+    fn value(&self) -> &Self::Value {
+        self
+    }
+}
+
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`bool`].
+    PARAM_OPS_BOOL,
+    bool
+);
+
+/// An array of at __most__ `N` values.
+///
+/// # Invariant
+///
+/// The first `self.used` elements of `self.values` are initialized.
+pub struct ArrayParam<T, const N: usize> {
+    values: [core::mem::MaybeUninit<T>; N],
+    used: usize,
+}
+
+impl<T, const N: usize> ArrayParam<T, { N }> {
+    fn values(&self) -> &[T] {
+        // SAFETY: The invariant maintained by `ArrayParam` allows us to cast
+        // the first `self.used` elements to `T`.
+        unsafe {
+            &*(&self.values[0..self.used] as *const [core::mem::MaybeUninit<T>] as *const [T])
+        }
+    }
+}
+
+impl<T: Copy, const N: usize> ArrayParam<T, { N }> {
+    const fn new() -> Self {
+        // INVARIANT: The first `self.used` elements of `self.values` are
+        // initialized.
+        ArrayParam {
+            values: [core::mem::MaybeUninit::uninit(); N],
+            used: 0,
+        }
+    }
+
+    const fn push(&mut self, val: T) {
+        if self.used < N {
+            // INVARIANT: The first `self.used` elements of `self.values` are
+            // initialized.
+            self.values[self.used] = core::mem::MaybeUninit::new(val);
+            self.used += 1;
+        }
+    }
+
+    /// Create an instance of `ArrayParam` initialized with `vals`.
+    ///
+    /// This function is only meant to be used in the [`module::module`] macro.
+    pub const fn create(vals: &[T]) -> Self {
+        let mut result = ArrayParam::new();
+        let mut i = 0;
+        while i < vals.len() {
+            result.push(vals[i]);
+            i += 1;
+        }
+        result
+    }
+}
+
+impl<T: core::fmt::Display, const N: usize> core::fmt::Display for ArrayParam<T, { N }> {
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        for val in self.values() {
+            write!(f, "{},", val)?;
+        }
+        Ok(())
+    }
+}
+
+impl<T: Copy + core::fmt::Display + ModuleParam, const N: usize> ModuleParam
+    for ArrayParam<T, { N }>
+{
+    type Value = [T];
+
+    const NOARG_ALLOWED: bool = false;
+
+    fn try_from_param_arg(arg: Option<&'static [u8]>) -> Option<Self> {
+        arg.and_then(|args| {
+            let mut result = Self::new();
+            for arg in args.split(|b| *b == b',') {
+                result.push(T::try_from_param_arg(Some(arg))?);
+            }
+            Some(result)
+        })
+    }
+
+    fn value(&self) -> &Self::Value {
+        self.values()
+    }
+}
+
+/// A C-style string parameter.
+///
+/// The Rust version of the [`charp`] parameter. This type is meant to be
+/// used by the [`macros::module`] macro, not handled directly. Instead use the
+/// `read` method generated by that macro.
+///
+/// [`charp`]: ../../../include/linux/moduleparam.h
+pub enum StringParam {
+    /// A borrowed parameter value.
+    ///
+    /// Either the default value (which is static in the module) or borrowed
+    /// from the original argument buffer used to set the value.
+    Ref(&'static [u8]),
+
+    /// A value that was allocated when the parameter was set.
+    ///
+    /// The value needs to be freed when the parameter is reset or the module is
+    /// unloaded.
+    Owned(alloc::vec::Vec<u8>),
+}
+
+impl StringParam {
+    fn bytes(&self) -> &[u8] {
+        match self {
+            StringParam::Ref(bytes) => *bytes,
+            StringParam::Owned(vec) => &vec[..],
+        }
+    }
+}
+
+impl core::fmt::Display for StringParam {
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        let bytes = self.bytes();
+        match core::str::from_utf8(bytes) {
+            Ok(utf8) => write!(f, "{}", utf8),
+            Err(_) => write!(f, "{:?}", bytes),
+        }
+    }
+}
+
+impl ModuleParam for StringParam {
+    type Value = [u8];
+
+    const NOARG_ALLOWED: bool = false;
+
+    fn try_from_param_arg(arg: Option<&'static [u8]>) -> Option<Self> {
+        // SAFETY: It is always safe to call [`slab_is_available`](../../../include/linux/slab.h).
+        let slab_available = unsafe { crate::bindings::slab_is_available() };
+        arg.and_then(|arg| {
+            if slab_available {
+                let mut vec = alloc::vec::Vec::new();
+                vec.try_extend_from_slice(arg).ok()?;
+                Some(StringParam::Owned(vec))
+            } else {
+                Some(StringParam::Ref(arg))
+            }
+        })
+    }
+
+    fn value(&self) -> &Self::Value {
+        self.bytes()
+    }
+}
+
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`StringParam`].
+    PARAM_OPS_STR,
+    StringParam
+);
diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
index b2bdd4d8c958..8b5f9bc414d7 100644
--- a/rust/macros/helpers.rs
+++ b/rust/macros/helpers.rs
@@ -18,6 +18,16 @@ pub(crate) fn try_literal(it: &mut token_stream::IntoIter) -> Option<String> {
     }
 }
 
+pub(crate) fn try_byte_string(it: &mut token_stream::IntoIter) -> Option<String> {
+    try_literal(it).and_then(|byte_string| {
+        if byte_string.starts_with("b\"") && byte_string.ends_with('\"') {
+            Some(byte_string[2..byte_string.len() - 1].to_string())
+        } else {
+            None
+        }
+    })
+}
+
 pub(crate) fn try_string(it: &mut token_stream::IntoIter) -> Option<String> {
     try_literal(it).and_then(|string| {
         if string.starts_with('\"') && string.ends_with('\"') {
@@ -46,14 +56,8 @@ pub(crate) fn expect_punct(it: &mut token_stream::IntoIter) -> char {
     }
 }
 
-pub(crate) fn expect_string(it: &mut token_stream::IntoIter) -> String {
-    try_string(it).expect("Expected string")
-}
-
-pub(crate) fn expect_string_ascii(it: &mut token_stream::IntoIter) -> String {
-    let string = try_string(it).expect("Expected string");
-    assert!(string.is_ascii(), "Expected ASCII string");
-    string
+pub(crate) fn expect_literal(it: &mut token_stream::IntoIter) -> String {
+    try_literal(it).expect("Expected Literal")
 }
 
 pub(crate) fn expect_group(it: &mut token_stream::IntoIter) -> Group {
@@ -64,8 +68,34 @@ pub(crate) fn expect_group(it: &mut token_stream::IntoIter) -> Group {
     }
 }
 
+pub(crate) fn expect_string(it: &mut token_stream::IntoIter) -> String {
+    try_string(it).expect("Expected string")
+}
+
+pub(crate) fn expect_string_ascii(it: &mut token_stream::IntoIter) -> String {
+    let string = try_string(it).expect("Expected string");
+    assert!(string.is_ascii(), "Expected ASCII string");
+    string
+}
+
 pub(crate) fn expect_end(it: &mut token_stream::IntoIter) {
     if it.next().is_some() {
         panic!("Expected end");
     }
 }
+
+pub(crate) fn get_literal(it: &mut token_stream::IntoIter, expected_name: &str) -> String {
+    assert_eq!(expect_ident(it), expected_name);
+    assert_eq!(expect_punct(it), ':');
+    let literal = expect_literal(it);
+    assert_eq!(expect_punct(it), ',');
+    literal
+}
+
+pub(crate) fn get_string(it: &mut token_stream::IntoIter, expected_name: &str) -> String {
+    assert_eq!(expect_ident(it), expected_name);
+    assert_eq!(expect_punct(it), ':');
+    let string = expect_string(it);
+    assert_eq!(expect_punct(it), ',');
+    string
+}
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index fb1244f8c2e6..172631e7fb05 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -1,25 +1,40 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use crate::helpers::*;
-use proc_macro::{token_stream, Delimiter, Literal, TokenStream, TokenTree};
+use proc_macro::{token_stream, Delimiter, Group, Literal, TokenStream, TokenTree};
 use std::fmt::Write;
 
-fn expect_string_array(it: &mut token_stream::IntoIter) -> Vec<String> {
-    let group = expect_group(it);
-    assert_eq!(group.delimiter(), Delimiter::Bracket);
-    let mut values = Vec::new();
-    let mut it = group.stream().into_iter();
-
-    while let Some(val) = try_string(&mut it) {
-        assert!(val.is_ascii(), "Expected ASCII string");
-        values.push(val);
-        match it.next() {
-            Some(TokenTree::Punct(punct)) => assert_eq!(punct.as_char(), ','),
-            None => break,
-            _ => panic!("Expected ',' or end of array"),
+use crate::helpers::*;
+
+#[derive(Clone, PartialEq)]
+enum ParamType {
+    Ident(String),
+    Array { vals: String, max_length: usize },
+}
+
+fn expect_array_fields(it: &mut token_stream::IntoIter) -> ParamType {
+    assert_eq!(expect_punct(it), '<');
+    let vals = expect_ident(it);
+    assert_eq!(expect_punct(it), ',');
+    let max_length_str = expect_literal(it);
+    let max_length = max_length_str
+        .parse::<usize>()
+        .expect("Expected usize length");
+    assert_eq!(expect_punct(it), '>');
+    ParamType::Array { vals, max_length }
+}
+
+fn expect_type(it: &mut token_stream::IntoIter) -> ParamType {
+    if let TokenTree::Ident(ident) = it
+        .next()
+        .expect("Reached end of token stream for param type")
+    {
+        match ident.to_string().as_ref() {
+            "ArrayParam" => expect_array_fields(it),
+            _ => ParamType::Ident(ident.to_string()),
         }
+    } else {
+        panic!("Expected Param Type")
     }
-    values
 }
 
 struct ModInfoBuilder<'a> {
@@ -87,6 +102,113 @@ impl<'a> ModInfoBuilder<'a> {
         self.emit_only_builtin(field, content);
         self.emit_only_loadable(field, content);
     }
+
+    fn emit_param(&mut self, field: &str, param: &str, content: &str) {
+        let content = format!("{param}:{content}", param = param, content = content);
+        self.emit(field, &content);
+    }
+}
+
+fn permissions_are_readonly(perms: &str) -> bool {
+    let (radix, digits) = if let Some(n) = perms.strip_prefix("0x") {
+        (16, n)
+    } else if let Some(n) = perms.strip_prefix("0o") {
+        (8, n)
+    } else if let Some(n) = perms.strip_prefix("0b") {
+        (2, n)
+    } else {
+        (10, perms)
+    };
+    match u32::from_str_radix(digits, radix) {
+        Ok(perms) => perms & 0o222 == 0,
+        Err(_) => false,
+    }
+}
+
+fn param_ops_path(param_type: &str) -> &'static str {
+    match param_type {
+        "bool" => "kernel::module_param::PARAM_OPS_BOOL",
+        "i8" => "kernel::module_param::PARAM_OPS_I8",
+        "u8" => "kernel::module_param::PARAM_OPS_U8",
+        "i16" => "kernel::module_param::PARAM_OPS_I16",
+        "u16" => "kernel::module_param::PARAM_OPS_U16",
+        "i32" => "kernel::module_param::PARAM_OPS_I32",
+        "u32" => "kernel::module_param::PARAM_OPS_U32",
+        "i64" => "kernel::module_param::PARAM_OPS_I64",
+        "u64" => "kernel::module_param::PARAM_OPS_U64",
+        "isize" => "kernel::module_param::PARAM_OPS_ISIZE",
+        "usize" => "kernel::module_param::PARAM_OPS_USIZE",
+        "str" => "kernel::module_param::PARAM_OPS_STR",
+        t => panic!("Unrecognized type {}", t),
+    }
+}
+
+#[allow(clippy::type_complexity)]
+fn try_simple_param_val(
+    param_type: &str,
+) -> Box<dyn Fn(&mut token_stream::IntoIter) -> Option<String>> {
+    match param_type {
+        "bool" => Box::new(try_ident),
+        "str" => Box::new(|param_it| {
+            try_byte_string(param_it)
+                .map(|s| format!("kernel::module_param::StringParam::Ref(b\"{}\")", s))
+        }),
+        _ => Box::new(try_literal),
+    }
+}
+
+fn get_default(param_type: &ParamType, param_it: &mut token_stream::IntoIter) -> String {
+    let try_param_val = match param_type {
+        ParamType::Ident(ref param_type)
+        | ParamType::Array {
+            vals: ref param_type,
+            max_length: _,
+        } => try_simple_param_val(param_type),
+    };
+    assert_eq!(expect_ident(param_it), "default");
+    assert_eq!(expect_punct(param_it), ':');
+    let default = match param_type {
+        ParamType::Ident(_) => try_param_val(param_it).expect("Expected default param value"),
+        ParamType::Array {
+            vals: _,
+            max_length: _,
+        } => {
+            let group = expect_group(param_it);
+            assert_eq!(group.delimiter(), Delimiter::Bracket);
+            let mut default_vals = Vec::new();
+            let mut it = group.stream().into_iter();
+
+            while let Some(default_val) = try_param_val(&mut it) {
+                default_vals.push(default_val);
+                match it.next() {
+                    Some(TokenTree::Punct(punct)) => assert_eq!(punct.as_char(), ','),
+                    None => break,
+                    _ => panic!("Expected ',' or end of array default values"),
+                }
+            }
+
+            let mut default_array = "kernel::module_param::ArrayParam::create(&[".to_string();
+            default_array.push_str(
+                &default_vals
+                    .iter()
+                    .map(|val| val.to_string())
+                    .collect::<Vec<String>>()
+                    .join(","),
+            );
+            default_array.push_str("])");
+            default_array
+        }
+    };
+    assert_eq!(expect_punct(param_it), ',');
+    default
+}
+
+fn generated_array_ops_name(vals: &str, max_length: usize) -> String {
+    format!(
+        "__generated_array_ops_{vals}_{max_length}",
+        vals = vals,
+        max_length = max_length
+    )
 }
 
 #[derive(Debug, Default)]
@@ -96,15 +218,24 @@ struct ModuleInfo {
     name: String,
     author: Option<String>,
     description: Option<String>,
-    alias: Option<Vec<String>>,
+    alias: Option<String>,
+    params: Option<Group>,
 }
 
 impl ModuleInfo {
     fn parse(it: &mut token_stream::IntoIter) -> Self {
         let mut info = ModuleInfo::default();
 
-        const EXPECTED_KEYS: &[&str] =
-            &["type", "name", "author", "description", "license", "alias"];
+        const EXPECTED_KEYS: &[&str] = &[
+            "type",
+            "name",
+            "author",
+            "description",
+            "license",
+            "alias",
+            "alias_rtnl_link",
+            "params",
+        ];
         const REQUIRED_KEYS: &[&str] = &["type", "name", "license"];
         let mut seen_keys = Vec::new();
 
@@ -130,7 +261,11 @@ impl ModuleInfo {
                 "author" => info.author = Some(expect_string(it)),
                 "description" => info.description = Some(expect_string(it)),
                 "license" => info.license = expect_string_ascii(it),
-                "alias" => info.alias = Some(expect_string_array(it)),
+                "alias" => info.alias = Some(expect_string_ascii(it)),
+                "alias_rtnl_link" => {
+                    info.alias = Some(format!("rtnl-link-{}", expect_string_ascii(it)))
+                }
+                "params" => info.params = Some(expect_group(it)),
                 _ => panic!(
                     "Unknown key \"{}\". Valid keys are: {:?}.",
                     key, EXPECTED_KEYS
@@ -181,10 +316,8 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
         modinfo.emit("description", &description);
     }
     modinfo.emit("license", &info.license);
-    if let Some(aliases) = info.alias {
-        for alias in aliases {
-            modinfo.emit("alias", &alias);
-        }
+    if let Some(alias) = info.alias {
+        modinfo.emit("alias", &alias);
     }
 
     // Built-in modules also export the `file` modinfo string.
@@ -192,6 +325,195 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
         std::env::var("RUST_MODFILE").expect("Unable to fetch RUST_MODFILE environmental variable");
     modinfo.emit_only_builtin("file", &file);
 
+    let mut array_types_to_generate = Vec::new();
+    if let Some(params) = info.params {
+        assert_eq!(params.delimiter(), Delimiter::Brace);
+
+        let mut it = params.stream().into_iter();
+
+        loop {
+            let param_name = match it.next() {
+                Some(TokenTree::Ident(ident)) => ident.to_string(),
+                Some(_) => panic!("Expected Ident or end"),
+                None => break,
+            };
+
+            assert_eq!(expect_punct(&mut it), ':');
+            let param_type = expect_type(&mut it);
+            let group = expect_group(&mut it);
+            assert_eq!(expect_punct(&mut it), ',');
+
+            assert_eq!(group.delimiter(), Delimiter::Brace);
+
+            let mut param_it = group.stream().into_iter();
+            let param_default = get_default(&param_type, &mut param_it);
+            let param_permissions = get_literal(&mut param_it, "permissions");
+            let param_description = get_string(&mut param_it, "description");
+            expect_end(&mut param_it);
+
+            // TODO: More primitive types.
+            // TODO: Other kinds: unsafes, etc.
+            let (param_kernel_type, ops): (String, _) = match param_type {
+                ParamType::Ident(ref param_type) => (
+                    param_type.to_string(),
+                    param_ops_path(param_type).to_string(),
+                ),
+                ParamType::Array {
+                    ref vals,
+                    max_length,
+                } => {
+                    array_types_to_generate.push((vals.clone(), max_length));
+                    (
+                        format!("__rust_array_param_{}_{}", vals, max_length),
+                        generated_array_ops_name(vals, max_length),
+                    )
+                }
+            };
+
+            modinfo.emit_param("parmtype", &param_name, &param_kernel_type);
+            modinfo.emit_param("parm", &param_name, &param_description);
+            let param_type_internal = match param_type {
+                ParamType::Ident(ref param_type) => match param_type.as_ref() {
+                    "str" => "kernel::module_param::StringParam".to_string(),
+                    other => other.to_string(),
+                },
+                ParamType::Array {
+                    ref vals,
+                    max_length,
+                } => format!(
+                    "kernel::module_param::ArrayParam<{vals}, {max_length}>",
+                    vals = vals,
+                    max_length = max_length
+                ),
+            };
+            let read_func = if permissions_are_readonly(&param_permissions) {
+                format!(
+                    "
+                        fn read(&self)
+                            -> &<{param_type_internal} as kernel::module_param::ModuleParam>::Value {{
+                            // SAFETY: Parameters do not need to be locked because they are
+                            // read only or sysfs is not enabled.
+                            unsafe {{
+                                <{param_type_internal} as kernel::module_param::ModuleParam>::value(
+                                    &__{name}_{param_name}_value
+                                )
+                            }}
+                        }}
+                    ",
+                    name = info.name,
+                    param_name = param_name,
+                    param_type_internal = param_type_internal,
+                )
+            } else {
+                format!(
+                    "
+                        fn read<'lck>(&self, lock: &'lck kernel::KParamGuard)
+                            -> &'lck <{param_type_internal} as kernel::module_param::ModuleParam>::Value {{
+                            // SAFETY: Parameters are locked by `KParamGuard`.
+                            unsafe {{
+                                <{param_type_internal} as kernel::module_param::ModuleParam>::value(
+                                    &__{name}_{param_name}_value
+                                )
+                            }}
+                        }}
+                    ",
+                    name = info.name,
+                    param_name = param_name,
+                    param_type_internal = param_type_internal,
+                )
+            };
+            let kparam = format!(
+                "
+                    kernel::bindings::kernel_param__bindgen_ty_1 {{
+                        arg: unsafe {{ &__{name}_{param_name}_value }}
+                            as *const _ as *mut core::ffi::c_void,
+                    }},
+                ",
+                name = info.name,
+                param_name = param_name,
+            );
+            write!(
+                modinfo.buffer,
+                "
+                static mut __{name}_{param_name}_value: {param_type_internal} = {param_default};
+
+                struct __{name}_{param_name};
+
+                impl __{name}_{param_name} {{ {read_func} }}
+
+                const {param_name}: __{name}_{param_name} = __{name}_{param_name};
+
+                // Note: the C macro that generates the static structs for the `__param` section
+                // asks for them to be `aligned(sizeof(void *))`. However, that was put in place
+                // in 2003 in commit 38d5b085d2a0 (\"[PATCH] Fix over-alignment problem on x86-64\")
+                // to undo GCC over-alignment of static structs of >32 bytes. It seems that is
+                // not the case anymore, so we simplify to a transparent representation here
+                // in the expectation that it is not needed anymore.
+                // TODO: Revisit this to confirm the above comment and remove it if it happened.
+                #[repr(transparent)]
+                struct __{name}_{param_name}_RacyKernelParam(kernel::bindings::kernel_param);
+
+                unsafe impl Sync for __{name}_{param_name}_RacyKernelParam {{
+                }}
+
+                #[cfg(not(MODULE))]
+                const __{name}_{param_name}_name: *const core::ffi::c_char =
+                    b\"{name}.{param_name}\\0\" as *const _ as *const core::ffi::c_char;
+
+                #[cfg(MODULE)]
+                const __{name}_{param_name}_name: *const core::ffi::c_char =
+                    b\"{param_name}\\0\" as *const _ as *const core::ffi::c_char;
+
+                #[link_section = \"__param\"]
+                #[used]
+                static __{name}_{param_name}_struct: __{name}_{param_name}_RacyKernelParam =
+                    __{name}_{param_name}_RacyKernelParam(kernel::bindings::kernel_param {{
+                        name: __{name}_{param_name}_name,
+                        // SAFETY: `__this_module` is constructed by the kernel at load time
+                        // and will not be freed until the module is unloaded.
+                        #[cfg(MODULE)]
+                        mod_: unsafe {{ &kernel::bindings::__this_module as *const _ as *mut _ }},
+                        #[cfg(not(MODULE))]
+                        mod_: core::ptr::null_mut(),
+                        ops: unsafe {{ &{ops} }} as *const kernel::bindings::kernel_param_ops,
+                        perm: {permissions},
+                        level: -1,
+                        flags: 0,
+                        __bindgen_anon_1: {kparam}
+                    }});
+                ",
+                name = info.name,
+                param_type_internal = param_type_internal,
+                read_func = read_func,
+                param_default = param_default,
+                param_name = param_name,
+                ops = ops,
+                permissions = param_permissions,
+                kparam = kparam,
+            )
+            .unwrap();
+        }
+    }
+
+    let mut generated_array_types = String::new();
+
+    for (vals, max_length) in array_types_to_generate {
+        let ops_name = generated_array_ops_name(&vals, max_length);
+        write!(
+            generated_array_types,
+            "
+                kernel::make_param_ops!(
+                    {ops_name},
+                    kernel::module_param::ArrayParam<{vals}, {{ {max_length} }}>
+                );
+            ",
+            ops_name = ops_name,
+            vals = vals,
+            max_length = max_length,
+        )
+        .unwrap();
+    }
+
     format!(
         "
             /// The module name.
@@ -291,12 +613,44 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             }}
 
             {modinfo}
+
+            {generated_array_types}
         ",
         type_ = info.type_,
         name = info.name,
         modinfo = modinfo.buffer,
+        generated_array_types = generated_array_types,
         initcall_section = ".initcall6.init"
     )
     .parse()
     .expect("Error parsing formatted string into token stream.")
 }
+
+#[cfg(test)]
+mod tests {
+    use super::*;
+
+    #[test]
+    fn test_permissions_are_readonly() {
+        assert!(permissions_are_readonly("0b000000000"));
+        assert!(permissions_are_readonly("0o000"));
+        assert!(permissions_are_readonly("000"));
+        assert!(permissions_are_readonly("0x000"));
+
+        assert!(!permissions_are_readonly("0b111111111"));
+        assert!(!permissions_are_readonly("0o777"));
+        assert!(!permissions_are_readonly("511"));
+        assert!(!permissions_are_readonly("0x1ff"));
+
+        assert!(permissions_are_readonly("0o014"));
+        assert!(permissions_are_readonly("0o015"));
+
+        assert!(!permissions_are_readonly("0o214"));
+        assert!(!permissions_are_readonly("0o024"));
+        assert!(!permissions_are_readonly("0o012"));
+
+        assert!(!permissions_are_readonly("0o315"));
+        assert!(!permissions_are_readonly("0o065"));
+        assert!(!permissions_are_readonly("0o017"));
+    }
+}
-- 
2.40.0

