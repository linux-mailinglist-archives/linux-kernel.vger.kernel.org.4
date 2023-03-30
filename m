Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AE56CFA4D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 06:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjC3ElR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 00:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjC3ElD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 00:41:03 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5645245;
        Wed, 29 Mar 2023 21:40:55 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-17aceccdcf6so18533864fac.9;
        Wed, 29 Mar 2023 21:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680151254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rz/wA0EJV4qXfvvhu8fz27iXlBcuFSyg7BlqCeu9CZc=;
        b=I+fkMkkxnBBRv2+/t8pOUUKk0cut4cRWJeetknDDR1iaYt4jnaOtVdIGjmRPpOsYNM
         +nQGpEMRDZY6CIzKcNDj5R+k8iH/qbgD++X0hsdNeD22E/p+EuLX0Ux6B7sc2gvU8v58
         S1yVBRNn6GL9lgpAi1cTgG8+HWW31p1HeMJ3IJoinJiuOHp/kmDWt7lp0lTHgcV3yZAv
         I2X6RYhtBomXLlF33qAvYQXIqFWc1lmVq1McMb5D3GKFPYvmhfi6PJXu7XyM/fria4xE
         0FC3+6Z7TXG1/ooQ6/uxGsNObFJxYJzspcU+4NBHvTRXqy31dRg6NbqqTkO55i6fdA1x
         2KMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680151254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rz/wA0EJV4qXfvvhu8fz27iXlBcuFSyg7BlqCeu9CZc=;
        b=R0XzU3X4J/XPVHrAZ4OSpiIBzsjinI3Ek3i3gHBJMS1J1Y4lh0NfLQf1+H7QJF4JnS
         C4na1cy71VzWac7toWOysnnu+HALh6QMQ2W5k8V/Ua3KfzmR5l1bsFHqEL3WMBQFTVq2
         8fGeUCw8hX8weAY1lUGh0N6HYIH1MQi9cRaw1Gu7DZDAFaLOgMCqfkHrqkpc+1uJPgCf
         kA48EoC1QTrL/lRt6n8mFrlm+We7OV74mS2URlIyrhbcfKUAtHbAjghFtOIFJoIfdihd
         pcx8ZJxk7KV1Kcr7fpX8wJRhgEAjk2jifu7nvfGJZYGvlcWs3F8D2ayumeFK8bEt7pbN
         u0tA==
X-Gm-Message-State: AO0yUKWxBAsjX2ck1kd9RhVNBJFDYI80gC58f3MPuuLREziZLWSvOz5S
        BpFDkQwej0qLQD79J9AMWHZtGnzOLeF3Qw==
X-Google-Smtp-Source: AKy350blu0fdTg3fxTo6LyxG67QXzFJNfYrL6N3ACPi14t5u+MISjEqdkOdL+TECd2zeJo7K/NtgNg==
X-Received: by 2002:a05:6870:9113:b0:17e:a3d8:5a1b with SMTP id o19-20020a056870911300b0017ea3d85a1bmr13032336oae.31.1680151254456;
        Wed, 29 Mar 2023 21:40:54 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id ea43-20020a056870072b00b0017e0c13b29asm7518599oab.36.2023.03.29.21.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 21:40:54 -0700 (PDT)
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
Subject: [PATCH 03/13] rust: lock: introduce `Mutex`
Date:   Thu, 30 Mar 2023 01:39:44 -0300
Message-Id: <20230330043954.562237-3-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330043954.562237-1-wedsonaf@gmail.com>
References: <20230330043954.562237-1-wedsonaf@gmail.com>
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
index bf088b324af4..9ff116b2eebe 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -11,6 +11,7 @@ mod arc;
 pub mod lock;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
+pub use lock::mutex::Mutex;
 
 /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
 #[repr(transparent)]
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f5614bed2a78..cec1d68bab86 100644
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

