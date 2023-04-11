Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004216DD208
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 07:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjDKFr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 01:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjDKFrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:47:05 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12988D3;
        Mon, 10 Apr 2023 22:46:41 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id bg24so4713460oib.5;
        Mon, 10 Apr 2023 22:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681191999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgB0YMTALi714jlWS5MjgBj10Lq8MN7ZWt0hNjRBEmg=;
        b=Fd5QF4fS6HFrlai4MhzBvkpuDmjCE2SvaXB/Jee5HcGIl8vJx+gx59v6A3strn/bQE
         LJOBc3yZoJhGbBvMWpEnwMkxXrYgTXkxIcBPpPqyudpGo0dk736HchRsh3vYHT0NbtPI
         QJY86YQHbbAEqXdxrlt8GBuPL2TAYT7yUA4L5bGTp1RWRyG44tVVQ3HyoBuZYBAyLh0E
         aFEqjscqgasf4/RG0pt/jZwa8W1QdN80tEUKtrn1cl8jMyYVMzbnA703VMSi9TtqrQSZ
         4Bp2xI+GJvRgrdFlFYW1v74YI2cZ4nom8kvGllyHiMFL55P6wg1HaK6AFoutPH/su/nN
         +zqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681191999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgB0YMTALi714jlWS5MjgBj10Lq8MN7ZWt0hNjRBEmg=;
        b=zCzGKTqLP8oSNl2R6Yoh5dko1yEPkTuUHJxbg4SdodcdgklV7yiAqTNYXRw396jdqK
         gOdh5TsisA6xXne1RlYjdn/tuB2TkgPB75Oho0Yxmc19joAJHqvd1xryWleA7xpN0/jE
         V1Oz4fzEfDwmuLePWwIg/ZNkoz0HxK9zlV0Xrz84XE/FT0GSQsX46hPEc492FeVdqS/Y
         W1twJcTqD1Ko4nV/jOpyqmdoYA7XgpWJNDZMd3/lF5pAwVDl/bPzq+cjQ7h0XE7MbdQG
         T4t/xD9SlTndc5YZgfWQpT7xGZmePhV7W7CT78q4S0hLTArerYNBETjTcMCeKPM1TIez
         ZjwQ==
X-Gm-Message-State: AAQBX9fwwQy23hbnOCEtjP0Wp15jlDTJ5CYEAjzGw1VWlurWrGhkT9Hq
        0uY98yHB/H1kmTUZw6QMmAtVektu0rA=
X-Google-Smtp-Source: AKy350bbrPtjBvopkuVZ93d01h5SGS1guzQ6BEEZtG6DEyentF3d5d00Mz5hrOCF0/Q303rzMHSWJw==
X-Received: by 2002:aca:b541:0:b0:38a:63c8:800e with SMTP id e62-20020acab541000000b0038a63c8800emr8291992oif.7.1681191999568;
        Mon, 10 Apr 2023 22:46:39 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id z186-20020a4a49c3000000b005252d376caesm5440706ooa.22.2023.04.10.22.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 22:46:39 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: [PATCH v4 13/13] rust: sync: introduce `LockedBy`
Date:   Tue, 11 Apr 2023 02:45:43 -0300
Message-Id: <20230411054543.21278-13-wedsonaf@gmail.com>
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

This allows us to have data protected by a lock despite not being
wrapped by it. Access is granted by providing evidence that the lock is
held by the caller.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
v1 -> v2: Added build_assert to rule out zero-sized types
v2 -> v3: Improve comments around panics and support for ZSTs
v3 -> v4:
- Added build_assert to LockBy::new
- Updated build_assert calls with messages
- Included crate::build_assert and mem::size_of since they're used
  repeatedly.

 rust/kernel/sync.rs           |   2 +
 rust/kernel/sync/lock.rs      |   2 +-
 rust/kernel/sync/locked_by.rs | 156 ++++++++++++++++++++++++++++++++++
 3 files changed, 159 insertions(+), 1 deletion(-)
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
index 816c5d3bba12..14940312141d 100644
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
index 000000000000..b17ee5cd98f3
--- /dev/null
+++ b/rust/kernel/sync/locked_by.rs
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A wrapper for data protected by a lock that does not wrap it.
+
+use super::{lock::Backend, lock::Lock};
+use crate::build_assert;
+use core::{cell::UnsafeCell, mem::size_of, ptr};
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
+impl<T, U> LockedBy<T, U> {
+    /// Constructs a new instance of [`LockedBy`].
+    ///
+    /// It stores a raw pointer to the owner that is never dereferenced. It is only used to ensure
+    /// that the right owner is being used to access the protected data. If the owner is freed, the
+    /// data becomes inaccessible; if another instance of the owner is allocated *on the same
+    /// memory location*, the data becomes accessible again: none of this affects memory safety
+    /// because in any case at most one thread (or CPU) can access the protected data at a time.
+    pub fn new<B: Backend>(owner: &Lock<U, B>, data: T) -> Self {
+        build_assert!(
+            size_of::<Lock<U, B>>() > 0,
+            "The lock type cannot be a ZST because it may be impossible to distinguish instances"
+        );
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
+        build_assert!(
+            size_of::<U>() > 0,
+            "`U` cannot be a ZST because `owner` wouldn't be unique"
+        );
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
+        build_assert!(
+            size_of::<U>() > 0,
+            "`U` cannot be a ZST because `owner` wouldn't be unique"
+        );
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

