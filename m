Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71046DA511
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238521AbjDFV5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238783AbjDFV5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:57:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F12B453;
        Thu,  6 Apr 2023 14:56:37 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2804:14d:72b4:8284:32a8:8167:f815:2895])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dwlsalmeida)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B759766031D9;
        Thu,  6 Apr 2023 22:56:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680818196;
        bh=Z1mWh6lO7+hdoozjzHbSbRzBrAE3llpM//4UJUMybns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QAQepvs3Zbpe0+7Y9i4iiyVuHrSwrwPxURN0SnPqlGdXKKV2xwAcxDJo/g7rthf6F
         tKTIaCLdCWpceHIn/aD/e2JtpmxEJNGtLOdAsZiA7JxNK0cBxGsFj5+LVQq6+t7cLP
         cO2vM1NDzL5Cf93rZ/tHahn8YVzTJgGYBf1QcjiaqVgFi+5lqYNu7VHmeLfEZIZ5UD
         OJEvHEtuYBWTyx/nslLupNS5l+EEkWXRvBy/id14oXNfTExAsgV2Fqf+KFxzPD+1Ow
         wpTVW+O5X4Kzaykh/HAxMQt+Cp8AlxWHTJb8b0KY3Qzc3RB1D+2aCHESAzurWihORA
         Olef4SVXq8PYQ==
From:   Daniel Almeida <daniel.almeida@collabora.com>
To:     wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        hverkuil@xs4all.nl
Cc:     Daniel Almeida <daniel.almeida@collabora.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
Subject: [PATCH 3/6] rust: sync: introduce FfiMutex
Date:   Thu,  6 Apr 2023 18:56:12 -0300
Message-Id: <20230406215615.122099-4-daniel.almeida@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230406215615.122099-1-daniel.almeida@collabora.com>
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce an owned mutex that can be passed as bindings::mutex when
initializing C data structures. The kernel will be locking it without
user intervention so there is no data to protect and no guard type.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/sync.rs           |  1 +
 rust/kernel/sync/ffi_mutex.rs | 70 +++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 rust/kernel/sync/ffi_mutex.rs

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index b07db83972ac..1415062be34d 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -26,6 +26,7 @@ use core::{cell::UnsafeCell, mem::MaybeUninit, pin::Pin};
 
 mod arc;
 mod condvar;
+pub mod ffi_mutex;
 mod guard;
 mod locked_by;
 mod mutex;
diff --git a/rust/kernel/sync/ffi_mutex.rs b/rust/kernel/sync/ffi_mutex.rs
new file mode 100644
index 000000000000..e615ec4059f6
--- /dev/null
+++ b/rust/kernel/sync/ffi_mutex.rs
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! An owned mutex that can be passed as bindings::mutex when initializing C
+//! data structures. The kernel will be locking it without user intervention so
+//! there is no data to protect and no guard type.
+
+#![allow(dead_code)]
+
+use crate::prelude::*;
+use crate::sync::{LockClassKey, LockIniter};
+use core::marker::PhantomPinned;
+use core::pin::Pin;
+
+use crate::Opaque;
+
+/// An owned mutex that can be passed as bindings::mutex when initializing C
+/// data structures. The kernel will be locking it without user intervention so
+/// there is no data to protect and no guard type.
+pub struct FfiMutex {
+    mutex: Opaque<bindings::mutex>,
+    _pin: PhantomPinned,
+}
+
+impl FfiMutex {
+    /// Constructs a new Mutex for FFI purposes.
+    ///
+    /// # Safety
+    ///
+    /// The caller must call [`FfiMutex::init_lock`] before using the raw Mutex.
+    pub const unsafe fn new() -> Self {
+        Self {
+            mutex: Opaque::uninit(),
+            _pin: PhantomPinned,
+        }
+    }
+
+    /// Returns the inner bindings::mutex
+    ///
+    /// # Safety
+    ///
+    /// The caller must call [`FfiMutex::init_lock`] before using the raw Mutex.
+    pub(crate) unsafe fn raw(self: &mut Pin<&mut Self>) -> *mut bindings::mutex {
+        let this = self.as_mut();
+        // SAFETY: mutex is pinned when Lock is. The argument to the function is not moved.
+        let this = unsafe { this.map_unchecked_mut(|x| &mut x.mutex) };
+        // This does not move from the field.
+        this.get()
+    }
+}
+
+impl LockIniter for FfiMutex {
+    fn init_lock(self: Pin<&mut Self>, name: &'static CStr, key: &'static LockClassKey) {
+        unsafe { bindings::__mutex_init(self.mutex.get(), name.as_char_ptr(), key.get()) };
+    }
+}
+
+// SAFETY: the underlying bindings::mutex can be used from any thread.
+unsafe impl Send for FfiMutex {}
+// SAFETY: two threads can try locking the underlying bindings::mutex at the
+// same thread without issues.
+unsafe impl Sync for FfiMutex {}
+
+/// Safely initialises a [`FfiMutex`] with the given name, generating a new lock
+/// class.
+#[macro_export]
+macro_rules! ffi_mutex_init {
+    ($mutex:expr, $name:literal) => {
+        $crate::init_with_lockdep!($mutex, $name);
+    };
+}
-- 
2.40.0

