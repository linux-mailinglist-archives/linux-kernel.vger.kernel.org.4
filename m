Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32256D854B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjDERxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjDERxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:53:03 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833FA7683;
        Wed,  5 Apr 2023 10:52:39 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id bj20so27246757oib.3;
        Wed, 05 Apr 2023 10:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680717158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNUYspx19IADgHh5+dQkFTo3WdN9gKiyBBCTIaE+T8A=;
        b=lYYGJ2ojuoGdIra0r5s5ocFIVoOj2hZT+oKToAmI6i1YXSLMd3VvIFxIcEbHYSqYFC
         MVo6iuE8kZ7cE6/XC5PL/2sMs3ld5pUYVk2MD00o/IFKvaY9BM1ED9w3affr242wCAoU
         3OI1AZ7CaywpMQTXCFGJp+UH0jSfKNah7bDux959gvn6EDLOYD6C2Qpu9eLJTv2HwfPQ
         RerVeJc0xXcmtDjedmRZuMBFr3oJa89eTD1E2qa2OIM1rJQCQ9mgLazt8ova1aYwWv/j
         V8N0NpVSuEHad9hlua7aGgGPQNaynI0gCK1Rx+n09cw8jmkaIKQMYaDJSx0C5Nh9c4pW
         myiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680717158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNUYspx19IADgHh5+dQkFTo3WdN9gKiyBBCTIaE+T8A=;
        b=hS81iNyEJ4X5rAsSfIIS6lb5TI2dhcZKVVN8CiRQa1GJOMEnWJIgg767uT6Zq9WP7L
         xc3zZs0VfZ9nApNhG5FXSQzLFJiZn6DWtkbchvyg27eVpdK9UC3r9aDz/lUn7z8ghmhQ
         +PN+ZH/46Ob/iGT3/Iy8FfihotaJZG9JaUZADn9jb4yeLGy+nfy0sKIagmdKY9+dPADx
         TIiNIVLyTTHAIVF0FFk1FLl9RlyIF5FwA3AqEgYd7Dvr88UZzxW9R3SC6+1DFtG+c6DI
         7gFp9LpRODuxLl33CEtH8+VMrkddgF18QHCF/tf7rA2fRQ24NWcjOqxNCK90nNBVZPi/
         Opcw==
X-Gm-Message-State: AAQBX9fbQVqYCjw8erxkq/LgETbiLDRiveLaQ3KpA06vOarysvnw8KOf
        MIU4u1j1905k3U3ggBQFEg59wcbRdKE=
X-Google-Smtp-Source: AKy350b98f/8pFBHhzijSqe40x+ZGonqdWCNBdHEHuyKv8DM0L8EvH83KJYLwxwtfF8floADfu6Uxw==
X-Received: by 2002:a05:6808:292:b0:389:7ffe:5059 with SMTP id z18-20020a056808029200b003897ffe5059mr3001434oic.58.1680717158019;
        Wed, 05 Apr 2023 10:52:38 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id w185-20020aca62c2000000b003896e31867esm6604045oib.49.2023.04.05.10.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 10:52:37 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH v2 13/13] rust: sync: introduce `LockedBy`
Date:   Wed,  5 Apr 2023 14:51:11 -0300
Message-Id: <20230405175111.5974-13-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230405175111.5974-1-wedsonaf@gmail.com>
References: <20230405175111.5974-1-wedsonaf@gmail.com>
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

 rust/kernel/sync.rs           |   2 +
 rust/kernel/sync/lock.rs      |   2 +-
 rust/kernel/sync/locked_by.rs | 128 ++++++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/sync/locked_by.rs

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index d6dd0e2c1678..f8edb6d0d794 100644
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
index f52ba9ab1b70..51c996ca2109 100644
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
index 000000000000..191e37d804e5
--- /dev/null
+++ b/rust/kernel/sync/locked_by.rs
@@ -0,0 +1,128 @@
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
+/// when the caller shows evidence that the 'external' lock is locked.
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
+    pub fn access<'a>(&'a self, owner: &'a U) -> &'a T {
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
+    /// Showing a mutable reference to the owner is sufficient because we know no other references
+    /// can exist to it.
+    pub fn access_mut<'a>(&'a self, owner: &'a mut U) -> &'a mut T {
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

