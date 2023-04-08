Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB41E6DB96B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 09:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjDHHzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 03:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjDHHzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 03:55:04 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76321FF19;
        Sat,  8 Apr 2023 00:54:40 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id f7-20020a4ab647000000b0054101f316c7so3442260ooo.13;
        Sat, 08 Apr 2023 00:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680940472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7f1ZJtQ7GVMBkDWdLfo+KU/tSEuvyaRTAOcNqcasmo=;
        b=AHns2xsd72x2hzUF8tVoMr+YvL6brrpf82BA2x+ZNUu1iZKDGBC/cON1n5EL89JQBX
         ojJ1NLxsgtjEUMkWUOGJh4Tmfi7MjSbOzSdRjoX+cFe5LGz2qNRBdcAvNyYAwr5MICTI
         Ll0PKzZO6ioZcpDFvqwV6mQSGT2KbN+N6r3VW6HFbDvFZYfF3VQyMvRRtTazxbTCGKd1
         XnbKY4yqbEhcP8Wzp9wojyyVPt228OVOEgWptOrBZ5hfrbyJKonDaiARRcTt1mHobiFi
         l/TOojBi0NHOLARSdWm7xC9xkbn2LN1wgKqj3hHnyQrKQdCIS7a5gbLPAESw7+NYoSLy
         j+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680940472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7f1ZJtQ7GVMBkDWdLfo+KU/tSEuvyaRTAOcNqcasmo=;
        b=egaUS/r+zvSrd3GgecHPNUgYezkHRafbLCmDO/YWaW6H/amZJuUspS1T4ZkeRYbGG7
         vF5dhPK0uNmZmY5h5aNhCCeNQzSSmBmXx99Pk+pMQcG7BH7P7NEIyELAQbCzwkU+uKbH
         NyolvoTNk7zHyjfLqlaEQW+cfSRX97qta48A3NdUhLm2sHxXZomIvJW4j8pOMscqEs8U
         /LntpEbrtXzSd6IaGrGPeHtHijI+AL+02d4xqqaHIXrK5jmRJTxzDOvJO2RmMwEWQXzG
         utleblJx5xZmb2aECdHcnohEeKq86SZk2i0kOSBpM0Bp0W8bHWBnFePlWmYy0vEccvro
         syxw==
X-Gm-Message-State: AAQBX9fku461Fz5sF17/45c5D7+n5DZx3ys+EHZm4mlQda57XCBL0Ktz
        N5WhHlqcEo3gmLNgV6UYQ+5FfShSowY=
X-Google-Smtp-Source: AKy350a2hKfgP+151U0qph5fxpj4WNaTaRL2dIcaSsdHCeqEiUCC5GdlsDnv9Ire6LCobwhhBg21eg==
X-Received: by 2002:a4a:8963:0:b0:537:f9d4:a44c with SMTP id g32-20020a4a8963000000b00537f9d4a44cmr508363ooi.5.1680940472423;
        Sat, 08 Apr 2023 00:54:32 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id o6-20020a4a9586000000b0051ffe0fe11bsm2435175ooi.6.2023.04.08.00.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 00:54:32 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH v3 13/13] rust: sync: introduce `LockedBy`
Date:   Sat,  8 Apr 2023 04:53:40 -0300
Message-Id: <20230408075340.25237-13-wedsonaf@gmail.com>
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

This allows us to have data protected by a lock despite not being
wrapped by it. Access is granted by providing evidence that the lock is
held by the caller.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
v1 -> v2: Added build_assert to rule out zero-sized types
v2 -> v3: Improve comments around panics and support for ZSTs

 rust/kernel/sync.rs           |   2 +
 rust/kernel/sync/lock.rs      |   2 +-
 rust/kernel/sync/locked_by.rs | 147 ++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/sync/locked_by.rs

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 431402180aa8..d219ee518eff 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -10,10 +10,12 @@ use crate::types::Opaque;
 mod arc;
 mod condvar;
 pub mod lock;
+mod locked_by;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use condvar::CondVar;
 pub use lock::{mutex::Mutex, spinlock::SpinLock};
+pub use locked_by::LockedBy;
 
 /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
 #[repr(transparent)]
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index c365bc909dff..84d8d7d01aaa 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -111,7 +111,7 @@ pub struct Lock<T: ?Sized, B: Backend> {
     _pin: PhantomPinned,
 
     /// The data protected by the lock.
-    data: UnsafeCell<T>,
+    pub(crate) data: UnsafeCell<T>,
 }
 
 // SAFETY: `Lock` can be transferred across thread boundaries iff the data it protects can.
diff --git a/rust/kernel/sync/locked_by.rs b/rust/kernel/sync/locked_by.rs
new file mode 100644
index 000000000000..ab0ecb013f54
--- /dev/null
+++ b/rust/kernel/sync/locked_by.rs
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A wrapper for data protected by a lock that does not wrap it.
+
+use super::{lock::Backend, lock::Lock};
+use core::{cell::UnsafeCell, ptr};
+
+/// Allows access to some data to be serialised by a lock that does not wrap it.
+///
+/// In most cases, data protected by a lock is wrapped by the appropriate lock type, e.g.,
+/// [`super::Mutex`] or [`super::SpinLock`]. [`LockedBy`] is meant for cases when this is not
+/// possible. For example, if a container has a lock and some data in the contained elements needs
+/// to be protected by the same lock.
+///
+/// [`LockedBy`] wraps the data in lieu of another locking primitive, and only allows access to it
+/// when the caller shows evidence that the 'external' lock is locked. It panics if the evidence
+/// refers to the wrong instance of the lock.
+///
+/// # Examples
+///
+/// The following is an example for illustrative purposes: `InnerDirectory::bytes_used` is an
+/// aggregate of all `InnerFile::bytes_used` and must be kept consistent; so we wrap `InnerFile` in
+/// a `LockedBy` so that it shares a lock with `InnerDirectory`. This allows us to enforce at
+/// compile-time that access to `InnerFile` is only granted when an `InnerDirectory` is also
+/// locked; we enforce at run time that the right `InnerDirectory` is locked.
+///
+/// ```
+/// use kernel::sync::{LockedBy, Mutex};
+///
+/// struct InnerFile {
+///     bytes_used: u64,
+/// }
+///
+/// struct File {
+///     _ino: u32,
+///     inner: LockedBy<InnerFile, InnerDirectory>,
+/// }
+///
+/// struct InnerDirectory {
+///     /// The sum of the bytes used by all files.
+///     bytes_used: u64,
+///     _files: Vec<File>,
+/// }
+///
+/// struct Directory {
+///     _ino: u32,
+///     inner: Mutex<InnerDirectory>,
+/// }
+///
+/// /// Prints `bytes_used` from both the directory and file.
+/// fn print_bytes_used(dir: &Directory, file: &File) {
+///     let guard = dir.inner.lock();
+///     let inner_file = file.inner.access(&guard);
+///     pr_info!("{} {}", guard.bytes_used, inner_file.bytes_used);
+/// }
+///
+/// /// Increments `bytes_used` for both the directory and file.
+/// fn inc_bytes_used(dir: &Directory, file: &File) {
+///     let mut guard = dir.inner.lock();
+///     guard.bytes_used += 10;
+///
+///     let file_inner = file.inner.access_mut(&mut guard);
+///     file_inner.bytes_used += 10;
+/// }
+///
+/// /// Creates a new file.
+/// fn new_file(ino: u32, dir: &Directory) -> File {
+///     File {
+///         _ino: ino,
+///         inner: LockedBy::new(&dir.inner, InnerFile { bytes_used: 0 }),
+///     }
+/// }
+/// ```
+pub struct LockedBy<T: ?Sized, U: ?Sized> {
+    owner: *const U,
+    data: UnsafeCell<T>,
+}
+
+// SAFETY: `LockedBy` can be transferred across thread boundaries iff the data it protects can.
+unsafe impl<T: ?Sized + Send, U: ?Sized> Send for LockedBy<T, U> {}
+
+// SAFETY: `LockedBy` serialises the interior mutability it provides, so it is `Sync` as long as the
+// data it protects is `Send`.
+unsafe impl<T: ?Sized + Send, U: ?Sized> Sync for LockedBy<T, U> {}
+
+impl<T, U: ?Sized> LockedBy<T, U> {
+    /// Constructs a new instance of [`LockedBy`].
+    ///
+    /// It stores a raw pointer to the owner that is never dereferenced. It is only used to ensure
+    /// that the right owner is being used to access the protected data. If the owner is freed, the
+    /// data becomes inaccessible; if another instance of the owner is allocated *on the same
+    /// memory location*, the data becomes accessible again: none of this affects memory safety
+    /// because in any case at most one thread (or CPU) can access the protected data at a time.
+    pub fn new(owner: &Lock<U, impl Backend>, data: T) -> Self {
+        Self {
+            owner: owner.data.get(),
+            data: UnsafeCell::new(data),
+        }
+    }
+}
+
+impl<T: ?Sized, U> LockedBy<T, U> {
+    /// Returns a reference to the protected data when the caller provides evidence (via a
+    /// reference) that the owner is locked.
+    ///
+    /// `U` cannot be a zero-sized type (ZST) because there are ways to get an `&U` that matches
+    /// the data protected by the lock without actually holding it.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `owner` is different from the data protected by the lock used in
+    /// [`new`](LockedBy::new).
+    pub fn access<'a>(&'a self, owner: &'a U) -> &'a T {
+        // Detect the usage of SZTs, which are supported, at compile time.
+        crate::build_assert!(core::mem::size_of::<U>() > 0);
+        if !ptr::eq(owner, self.owner) {
+            panic!("mismatched owners");
+        }
+
+        // SAFETY: `owner` is evidence that the owner is locked.
+        unsafe { &*self.data.get() }
+    }
+
+    /// Returns a mutable reference to the protected data when the caller provides evidence (via a
+    /// mutable owner) that the owner is locked mutably.
+    ///
+    /// `U` cannot be a zero-sized type (ZST) because there are ways to get an `&mut U` that
+    /// matches the data protected by the lock without actually holding it.
+    ///
+    /// Showing a mutable reference to the owner is sufficient because we know no other references
+    /// can exist to it.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `owner` is different from the data protected by the lock used in
+    /// [`new`](LockedBy::new).
+    pub fn access_mut<'a>(&'a self, owner: &'a mut U) -> &'a mut T {
+        // Detect the usage of SZTs, which are supported, at compile time.
+        crate::build_assert!(core::mem::size_of::<U>() > 0);
+        if !ptr::eq(owner, self.owner) {
+            panic!("mismatched owners");
+        }
+
+        // SAFETY: `owner` is evidence that there is only one reference to the owner.
+        unsafe { &mut *self.data.get() }
+    }
+}
-- 
2.34.1

