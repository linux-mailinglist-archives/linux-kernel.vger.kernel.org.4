Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D3D6DD1F8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 07:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjDKFqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 01:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjDKFqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:46:06 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C06530E7;
        Mon, 10 Apr 2023 22:46:05 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id bg24so4712945oib.5;
        Mon, 10 Apr 2023 22:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681191964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VL4SAF5/q9qhJ4toS87ARUNeVl0yq0aauKrjQLRBpsM=;
        b=O0jOkImTs9oNDuKvb6A3Z3q43VibRlNxkR5SLEprXfU6PXoPfFRdkcoUfF6jCjIp1C
         PDHDllM6BVpZOzQoBSYZ1x0QlChxZVDd16M+ESAMePQO+sMwDBrix7uFUetPB32IKOyV
         8z/r7wNgG8Rup3GWTSVvTsp7vDxnsOhZI58jzpWiyIf17PRYVrWitdUP9/tydiM4yLiX
         FTR+mDpI+zxcajIZ+aB53fFFATstcr7CWiHm4nNHhWuA50MzG0YKX3Uf8tzyWTusoeAf
         mrvu9xThN/8+znVbtS9W371sPn5Vr42ThF9sWyo0+dpZbnZEh2BBY/ElybgiRImDE2Sl
         TAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681191964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VL4SAF5/q9qhJ4toS87ARUNeVl0yq0aauKrjQLRBpsM=;
        b=TxMjrbBTIxiSnBQ1hpEwUe+UFCtrT7XtF+SgkYFGIcUTCY99c1qB5Kh6XW+m3MxTna
         0mw5mGtefm8QW1qfcW4e14mKfL0ptNOH0vNfGDuJnbaZ0aa04VUeqibg3FZS2x4rk0hU
         JZDiKc1nxVJ+16TCbvIr1OXDPlLLMdBZiip8/wz4zQrgyj7v6d+CkK3Adnj1/LT5fdmq
         kPDwq2ShK2holpCNPEB81no09AQxo/tpG8ViX5iDRmBjwwWoSstDkGah+omHiOgFrsPr
         zMh9+DXAgHIVypCMoNvJd0qnOE6XAtx8sRw7FKas+6kWWTyzvqO92v1s7d0/EFIuK8Im
         nfjw==
X-Gm-Message-State: AAQBX9f8AWssxW3wG+1cH8/1th3OsTgSqNk8lN67XRK6II+pLmMhq8dG
        RRSOjA0tLP2MZjryN5JiH5DOL4n2uYY=
X-Google-Smtp-Source: AKy350YFLR76ZuH7LRR7MFbIXB8MIeMetDbUk0w9MzM7KBsfRZHxT+RcP65lN+Oi3cWAan803ZHGvg==
X-Received: by 2002:a05:6808:4ca:b0:38b:4fbe:43d0 with SMTP id a10-20020a05680804ca00b0038b4fbe43d0mr880307oie.29.1681191964548;
        Mon, 10 Apr 2023 22:46:04 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id z186-20020a4a49c3000000b005252d376caesm5440706ooa.22.2023.04.10.22.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 22:46:04 -0700 (PDT)
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
        Waiman Long <longman@redhat.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: [PATCH v4 03/13] rust: lock: introduce `Mutex`
Date:   Tue, 11 Apr 2023 02:45:33 -0300
Message-Id: <20230411054543.21278-3-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411054543.21278-1-wedsonaf@gmail.com>
References: <20230411054543.21278-1-wedsonaf@gmail.com>
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
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
v1 -> v2: No changes
v2 -> v3: No changes
v4 -> v4: No changes

 rust/helpers.c                 |   7 ++
 rust/kernel/sync.rs            |   1 +
 rust/kernel/sync/lock.rs       |   2 +
 rust/kernel/sync/lock/mutex.rs | 118 +++++++++++++++++++++++++++++++++
 4 files changed, 128 insertions(+)
 create mode 100644 rust/kernel/sync/lock/mutex.rs

diff --git a/rust/helpers.c b/rust/helpers.c
index 04b9be46e887..86af099d2d66 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -22,6 +22,7 @@
 #include <linux/build_bug.h>
 #include <linux/err.h>
 #include <linux/refcount.h>
+#include <linux/mutex.h>
 
 __noreturn void rust_helper_BUG(void)
 {
@@ -29,6 +30,12 @@ __noreturn void rust_helper_BUG(void)
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
index 1a8ecccf4f24..98de109d9e40 100644
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

