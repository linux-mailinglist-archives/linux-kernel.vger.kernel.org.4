Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0764A6A1AAD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjBXKzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjBXKyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:54:35 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADB665CFA;
        Fri, 24 Feb 2023 02:54:08 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 70EE74206F;
        Fri, 24 Feb 2023 10:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677236046;
        bh=EdCqFOCkFmNCQy+An4xXL1lM8eljicqRMAsCfNlFpXc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=QQ+STDuF5KmAnOI1efDmHlNdV4hDOgItX2AUUxdagG3FUFVa90uZxAGL7b8dUB7Pt
         5QjG7nWPiB/Iq8Ltdn2HxdrrDHWPOJb3c0rtMWBaq+tDdwz4TYBgFKoe9oQDJFMyYN
         LQFz/vE/drpBjenLI8bhQyU/zpctXEnwUdi3m22lq8s0Sai1gZvvwXgMtsCjXAVlm0
         7DayCYMhW3AuA7oiut0NtQNjrGvsadhl7fZI5KOY/UHYi42N1QGIR1ieMKtv0PLF1z
         JEbeIJBkLLKjIgRTi5TFHJpEFpZRr4qxYw16W2LiDqglXiENJ78ZjNj0jDto5vxOt8
         hRpzEfbVxlyRg==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 24 Feb 2023 19:53:17 +0900
Subject: [PATCH 5/5] rust: device: Add a stub abstraction for devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-iopt-rtkit-v1-5-49ced3391295@asahilina.net>
References: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
In-Reply-To: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677236013; l=5017;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=cdKIkyLwKJzj4pWUi4LyfvGZS5F3kfJKVHncm9kraaI=;
 b=OEIdscGIoIcKDDmhOPjbLGxA2i8Nhrg9rQMhaRWYJa7GQDqVwWSu3E/ZXAwXPBLNGXyvChxkV
 TnzkvIyCmpxAoIODcjIWil4i3mShoVRVROu+yHknTma9STuRcYVcEqq
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=Qn8jZuOtR1m5GaiDfTrAoQ4NE1XoYVZ/wmt5YtXWFC4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Add a Device type which represents an owned reference to a generic
struct device. This minimal implementation just handles reference
counting and allows the user to get the device name.

Lina: Rewrote commit message, dropped the Amba bits, and squashed in
simple changes to the core Device code from latter commits in
rust-for-linux/rust. Also include the rust_helper_dev_get_drvdata
helper which will be needed by consumers later on anyway.

Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/helpers.c        | 13 +++++++++
 rust/kernel/device.rs | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/rust/helpers.c b/rust/helpers.c
index 04b9be46e887..54954fd80c77 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -20,6 +20,7 @@
 
 #include <linux/bug.h>
 #include <linux/build_bug.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/refcount.h>
 
@@ -65,6 +66,18 @@ long rust_helper_PTR_ERR(__force const void *ptr)
 }
 EXPORT_SYMBOL_GPL(rust_helper_PTR_ERR);
 
+void *rust_helper_dev_get_drvdata(struct device *dev)
+{
+	return dev_get_drvdata(dev);
+}
+EXPORT_SYMBOL_GPL(rust_helper_dev_get_drvdata);
+
+const char *rust_helper_dev_name(const struct device *dev)
+{
+	return dev_name(dev);
+}
+EXPORT_SYMBOL_GPL(rust_helper_dev_name);
+
 /*
  * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
  * as the Rust `usize` type, so we can use it in contexts where Rust
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 9be021e393ca..e57da622d817 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -4,7 +4,7 @@
 //!
 //! C header: [`include/linux/device.h`](../../../../include/linux/device.h)
 
-use crate::bindings;
+use crate::{bindings, str::CStr};
 
 /// A raw device.
 ///
@@ -20,4 +20,78 @@ use crate::bindings;
 pub unsafe trait RawDevice {
     /// Returns the raw `struct device` related to `self`.
     fn raw_device(&self) -> *mut bindings::device;
+
+    /// Returns the name of the device.
+    fn name(&self) -> &CStr {
+        let ptr = self.raw_device();
+
+        // SAFETY: `ptr` is valid because `self` keeps it alive.
+        let name = unsafe { bindings::dev_name(ptr) };
+
+        // SAFETY: The name of the device remains valid while it is alive (because the device is
+        // never renamed, per the safety requirement of this trait). This is guaranteed to be the
+        // case because the reference to `self` outlives the one of the returned `CStr` (enforced
+        // by the compiler because of their lifetimes).
+        unsafe { CStr::from_char_ptr(name) }
+    }
+}
+
+/// A ref-counted device.
+///
+/// # Invariants
+///
+/// `ptr` is valid, non-null, and has a non-zero reference count. One of the references is owned by
+/// `self`, and will be decremented when `self` is dropped.
+pub struct Device {
+    pub(crate) ptr: *mut bindings::device,
+}
+
+// SAFETY: `Device` only holds a pointer to a C device, which is safe to be used from any thread.
+unsafe impl Send for Device {}
+
+// SAFETY: `Device` only holds a pointer to a C device, references to which are safe to be used
+// from any thread.
+unsafe impl Sync for Device {}
+
+impl Device {
+    /// Creates a new device instance.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid, non-null, and has a non-zero reference count.
+    pub unsafe fn new(ptr: *mut bindings::device) -> Self {
+        // SAFETY: By the safety requirements, ptr is valid and its refcounted will be incremented.
+        unsafe { bindings::get_device(ptr) };
+        // INVARIANT: The safety requirements satisfy all but one invariant, which is that `self`
+        // owns a reference. This is satisfied by the call to `get_device` above.
+        Self { ptr }
+    }
+
+    /// Creates a new device instance from an existing [`RawDevice`] instance.
+    pub fn from_dev(dev: &dyn RawDevice) -> Self {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        unsafe { Self::new(dev.raw_device()) }
+    }
+}
+
+// SAFETY: The device returned by `raw_device` is the one for which we hold a reference.
+unsafe impl RawDevice for Device {
+    fn raw_device(&self) -> *mut bindings::device {
+        self.ptr
+    }
+}
+
+impl Drop for Device {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // relinquish it now.
+        unsafe { bindings::put_device(self.ptr) };
+    }
+}
+
+impl Clone for Device {
+    fn clone(&self) -> Self {
+        Device::from_dev(self)
+    }
 }

-- 
2.35.1

