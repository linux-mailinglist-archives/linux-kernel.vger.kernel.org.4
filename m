Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4B86CFA58
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 06:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjC3Emy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 00:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjC3EmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 00:42:16 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201F37690;
        Wed, 29 Mar 2023 21:41:39 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-17fcc07d6c4so4496091fac.8;
        Wed, 29 Mar 2023 21:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680151298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtdTMwagWvTyqFDLE8n/H2MEvpwLqJxi8owZihcxfPE=;
        b=HAFHUZpWxT3qSD2wPnoPLCaZ5UDuTIvrCv1uNN1BeOYbL4/IS6Rlz485uErRKtu69b
         Sz7poGHEm212a83mkkSRMnMFB2CAa+zgu3IBD1ftjFiaUSG6DrP3aXAx8WonZFQeM6+k
         ElIpLFxVGHzLjNgNkSWHg1RrXofiOwzWF9OY3zIVS8oyZodOUlgK/WJXd8xBX/yDRqEk
         /W8I39ws/8jWZy4/eYe+URo+XmOisZ/FU/Wg1ZJxYWlTfbbr/Kif2mLtXxkvZTHyL0er
         3/Jv0xvE6BGQRqXplmDWW2bjTEOodfySEnj0VAJ8fRdXvsBtThzK+HNQx1bG8dZ2WKQG
         OgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680151298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtdTMwagWvTyqFDLE8n/H2MEvpwLqJxi8owZihcxfPE=;
        b=58zN0d5UBf9olSr+vPicz+4B3enqGIevWuxF84nfp5agmgTCA4kkeaBYXn6t4DdG8T
         Qy0ESHC/2hljOlD2O0Tmjn6ZXTejqSjQH7cLN4XDjR2rIw06STVba3ZbH3cBoUl5EdEt
         Rs38AwpuPm45uC+AYq0bLvSgNuoztKdS/XPFtrRvndxgHwjGlpdMl7SlNguBkmFL6tNd
         EgHl170FkJCZ3p2eQDk02OHde5Fyhv5Cben1UgQ+imQirg6fOM6u8foXm9vYKNbDx/vA
         /++3d4H0bQfWMX6W5to/g0ahWtZUIC3ulguMZWfNenf3fx35bo4qbP3weR0zpK/nlbxg
         8MlQ==
X-Gm-Message-State: AAQBX9eCZpfduexPBl8NfrN04bW71q3oq11WP4NESGBR62nJAgJ6yNMf
        peFH/xtxzd3/cze/zAJnLI/wn3X/1TTVvA==
X-Google-Smtp-Source: AK7set8yNSMC1rKAfIGTIYsa2f+P2VNECKjP7bgCL6sNtkGfsXczF0JcdU0lC0PVXnuEp6Kj6plPSA==
X-Received: by 2002:a05:6870:968b:b0:177:caaa:4cc8 with SMTP id o11-20020a056870968b00b00177caaa4cc8mr15409780oaq.20.1680151297693;
        Wed, 29 Mar 2023 21:41:37 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id ea43-20020a056870072b00b0017e0c13b29asm7518599oab.36.2023.03.29.21.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 21:41:37 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH 13/13] rust: sync: introduce `LockedBy`
Date:   Thu, 30 Mar 2023 01:39:54 -0300
Message-Id: <20230330043954.562237-13-wedsonaf@gmail.com>
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

This allows us to have data protected by a lock despite not being
wrapped by it. Access is granted by providing evidence that the lock is
held by the caller.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/sync.rs           |   2 +
 rust/kernel/sync/lock.rs      |   2 +-
 rust/kernel/sync/locked_by.rs | 126 ++++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+), 1 deletion(-)
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
index 000000000000..cbfd4e84b770
--- /dev/null
+++ b/rust/kernel/sync/locked_by.rs
@@ -0,0 +1,126 @@
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
+impl<T: ?Sized, U: ?Sized> LockedBy<T, U> {
+    /// Returns a reference to the protected data when the caller provides evidence (via a
+    /// reference) that the owner is locked.
+    pub fn access<'a>(&'a self, owner: &'a U) -> &'a T {
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

