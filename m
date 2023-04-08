Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B468B6DB963
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 09:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjDHHyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 03:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjDHHyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 03:54:02 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85042E18D;
        Sat,  8 Apr 2023 00:54:01 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id f14so18830837oiw.10;
        Sat, 08 Apr 2023 00:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680940441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdK7JrX/rQUp7e2zQbiDuLx9MtRcIQVTQroy9sLX/Ho=;
        b=P+MG41Bt1xeXQU4EkCmu4OXlVwPAqqYePd9ipkYQyF+tlD42dm9J/Oju/lEpLN7Y9S
         YW4v+cRNoOYiYOp+t8GhpEaFox3UPyg6W/qveFG+GdjDfEUVvTT4ZyxUzupfNuhAKgc5
         BI2OSKfL6Tlf9IzOE6gNmWgFybq9zZJJSS6HjIVNLr6Cf9P7pGtC1EnD5JSgN89BFHGj
         j/nFioLidzT9T5He7N85T19e+Qip75i8u4vlfkj8hL5wBeVx10ZGwJG5H4mzKCiOYaer
         rVrSwJqCjj6yooyC2kV30Eqz7kdGl5ONgXGujfc72VJgSn46U4iTjZWBaLR4N6vCnWGX
         ynAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680940441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdK7JrX/rQUp7e2zQbiDuLx9MtRcIQVTQroy9sLX/Ho=;
        b=7xkiH603WhyF32JSjR48QWi8hVP9c6SXtVb084McwpUAMcMjr4nDBRXiW2muPZeofy
         qo6R5ZDRKiZU9qzOpWKnSuPPUeXA3AmKnIEneYvBn4ESeFEANgJ9VCrl6g3eMVa9TgjQ
         HKhGTzdk8kxSXRAPe35Uz1wiCcvnZ+tCuCngHuAYOHXdE8xqOTTUM432j3s3qjHr6Tdy
         GUhl7HnDbBglIICtxJyz+bZkxRzVD+q+c/JItVx4BoUsXBsVxkc66VKnCcM59QhwiHzY
         YqO6/fuAJeFV6XwXNB09XOQPhTOQhUNkaKO8cMy27Mpmq3iTUEUsyZS93L/HSVZNZqu5
         z+LQ==
X-Gm-Message-State: AAQBX9cLa+os2wgbGgyWsTSppNgVoIfso0Jh+Jdk3q4jCvIQ20wE5Kao
        840U3t9CjUJv7ul85+vRgmaD62ONEfst2g==
X-Google-Smtp-Source: AKy350avTj+MSNkzupQaHwXziRWe6WTYwlorio8CQyx7z0vckXEl3lW6nHvc+f3kayR5ZPD5db/tLg==
X-Received: by 2002:a05:6808:1396:b0:386:c879:d3ae with SMTP id c22-20020a056808139600b00386c879d3aemr7582840oiw.10.1680940440748;
        Sat, 08 Apr 2023 00:54:00 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id o6-20020a4a9586000000b0051ffe0fe11bsm2435175ooi.6.2023.04.08.00.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 00:54:00 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3 03/13] rust: lock: introduce `Mutex`
Date:   Sat,  8 Apr 2023 04:53:30 -0300
Message-Id: <20230408075340.25237-3-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230408075340.25237-1-wedsonaf@gmail.com>
References: <20230408075340.25237-1-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wedson Almeida Filho <walmeida@microsoft.com>

This is the `struct mutex` lock backend and allows Rust code to use the
kernel mutex idiomatically.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
v1 -> v2: No changes
v2 -> v3: No changes

 rust/helpers.c                 |   7 ++
 rust/kernel/sync.rs            |   1 +
 rust/kernel/sync/lock.rs       |   2 +
 rust/kernel/sync/lock/mutex.rs | 118 +++++++++++++++++++++++++++++++++
 4 files changed, 128 insertions(+)
 create mode 100644 rust/kernel/sync/lock/mutex.rs

diff --git a/rust/helpers.c b/rust/helpers.c
index 09a4d93f9d62..3010a2ec26e2 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -21,6 +21,7 @@
 #include <linux/bug.h>
 #include <linux/build_bug.h>
 #include <linux/refcount.h>
+#include <linux/mutex.h>
 
 __noreturn void rust_helper_BUG(void)
 {
@@ -28,6 +29,12 @@ __noreturn void rust_helper_BUG(void)
 }
 EXPORT_SYMBOL_GPL(rust_helper_BUG);
 
+void rust_helper_mutex_lock(struct mutex *lock)
+{
+	mutex_lock(lock);
+}
+EXPORT_SYMBOL_GPL(rust_helper_mutex_lock);
+
 refcount_t rust_helper_REFCOUNT_INIT(int n)
 {
 	return (refcount_t)REFCOUNT_INIT(n);
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 81b0998eaa18..693f0b7f4e4f 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -11,6 +11,7 @@ mod arc;
 pub mod lock;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
+pub use lock::mutex::Mutex;
 
 /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
 #[repr(transparent)]
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 3fa4eefde740..86669f771ee0 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -10,6 +10,8 @@ use crate::{bindings, init::PinInit, pin_init, str::CStr, types::Opaque};
 use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
 use macros::pin_data;
 
+pub mod mutex;
+
 /// The "backend" of a lock.
 ///
 /// It is the actual implementation of the lock, without the need to repeat patterns used in all
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
new file mode 100644
index 000000000000..923472f04af4
--- /dev/null
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A kernel mutex.
+//!
+//! This module allows Rust code to use the kernel's `struct mutex`.
+
+use crate::bindings;
+
+/// Creates a [`Mutex`] initialiser with the given name and a newly-created lock class.
+///
+/// It uses the name if one is given, otherwise it generates one based on the file name and line
+/// number.
+#[macro_export]
+macro_rules! new_mutex {
+    ($inner:expr $(, $name:literal)? $(,)?) => {
+        $crate::sync::Mutex::new(
+            $inner, $crate::optional_name!($($name)?), $crate::static_lock_class!())
+    };
+}
+
+/// A mutual exclusion primitive.
+///
+/// Exposes the kernel's [`struct mutex`]. When multiple threads attempt to lock the same mutex,
+/// only one at a time is allowed to progress, the others will block (sleep) until the mutex is
+/// unlocked, at which point another thread will be allowed to wake up and make progress.
+///
+/// Since it may block, [`Mutex`] needs to be used with care in atomic contexts.
+///
+/// Instances of [`Mutex`] need a lock class and to be pinned. The recommended way to create such
+/// instances is with the [`pin_init`](crate::pin_init) and [`new_mutex`] macros.
+///
+/// # Examples
+///
+/// The following example shows how to declare, allocate and initialise a struct (`Example`) that
+/// contains an inner struct (`Inner`) that is protected by a mutex.
+///
+/// ```
+/// use kernel::{init::InPlaceInit, init::PinInit, new_mutex, pin_init, sync::Mutex};
+///
+/// struct Inner {
+///     a: u32,
+///     b: u32,
+/// }
+///
+/// #[pin_data]
+/// struct Example {
+///     c: u32,
+///     #[pin]
+///     d: Mutex<Inner>,
+/// }
+///
+/// impl Example {
+///     fn new() -> impl PinInit<Self> {
+///         pin_init!(Self {
+///             c: 10,
+///             d <- new_mutex!(Inner { a: 20, b: 30 }),
+///         })
+///     }
+/// }
+///
+/// // Allocate a boxed `Example`.
+/// let e = Box::pin_init(Example::new())?;
+/// assert_eq!(e.c, 10);
+/// assert_eq!(e.d.lock().a, 20);
+/// assert_eq!(e.d.lock().b, 30);
+/// ```
+///
+/// The following example shows how to use interior mutability to modify the contents of a struct
+/// protected by a mutex despite only having a shared reference:
+///
+/// ```
+/// use kernel::sync::Mutex;
+///
+/// struct Example {
+///     a: u32,
+///     b: u32,
+/// }
+///
+/// fn example(m: &Mutex<Example>) {
+///     let mut guard = m.lock();
+///     guard.a += 10;
+///     guard.b += 20;
+/// }
+/// ```
+///
+/// [`struct mutex`]: ../../../../include/linux/mutex.h
+pub type Mutex<T> = super::Lock<T, MutexBackend>;
+
+/// A kernel `struct mutex` lock backend.
+pub struct MutexBackend;
+
+// SAFETY: The underlying kernel `struct mutex` object ensures mutual exclusion.
+unsafe impl super::Backend for MutexBackend {
+    type State = bindings::mutex;
+    type GuardState = ();
+
+    unsafe fn init(
+        ptr: *mut Self::State,
+        name: *const core::ffi::c_char,
+        key: *mut bindings::lock_class_key,
+    ) {
+        // SAFETY: The safety requirements ensure that `ptr` is valid for writes, and `name` and
+        // `key` are valid for read indefinitely.
+        unsafe { bindings::__mutex_init(ptr, name, key) }
+    }
+
+    unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
+        // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
+        // memory, and that it has been initialised before.
+        unsafe { bindings::mutex_lock(ptr) };
+    }
+
+    unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
+        // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that the
+        // caller is the owner of the mutex.
+        unsafe { bindings::mutex_unlock(ptr) };
+    }
+}
-- 
2.34.1

