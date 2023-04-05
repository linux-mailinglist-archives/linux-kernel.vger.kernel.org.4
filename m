Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE6C6D8802
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjDEUPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbjDEUOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:14:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B416B59E2;
        Wed,  5 Apr 2023 13:14:39 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2804:14d:72b4:8284:32a8:8167:f815:2895])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dwlsalmeida)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CF81D6603197;
        Wed,  5 Apr 2023 21:14:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680725678;
        bh=Msw7QEEtZ+8jJUyb1J6l3LyE9/JSE7aFA2Xyrz/Kgk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aMR4Oy+KKxBNmZ0CKywbxKCyxfmHAvw+OZpqyGSCE6giSTjWLCxnIF8/Kq9m8mRYi
         3AjwJ6PMX56bADWvFvXhAwRbhEaIqFOZb9q+OpBGGdPwFpUHXsFicCNv3ghXnsIzz9
         gqxk1Rv2UwJ1KCU2Gpg0KdhYQoIfBD4EDGwHGBdJyN4uzJNMpWqN1m6AkCbmirvIN0
         f79FUdQrEt3VRydz2Z/EJSQPNR9pk7OQu389uyBGU+TkmkPXElnsJDx+kUEQ/Xx2PS
         fFYL8mVVo2Gi9ji6GzIKY3PgxILygTY6Q5TChsrV7p6SkXwrCTkDLCqMVj6QD7OEU0
         nfKIVafuEwGAw==
From:   Daniel Almeida <daniel.almeida@collabora.com>
To:     wedsonaf@gmail.com, ojeda@kernel.org
Cc:     Daniel Almeida <daniel.almeida@collabora.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 1/2] rust: add scatterlist support
Date:   Wed,  5 Apr 2023 17:14:15 -0300
Message-Id: <20230405201416.395840-2-daniel.almeida@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405201416.395840-1-daniel.almeida@collabora.com>
References: <20230405201416.395840-1-daniel.almeida@collabora.com>
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

This patch adds a scatterlist abstraction. It is then used and tested
by the new rust virtio sample module.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/lib.rs         |  1 +
 rust/kernel/scatterlist.rs | 40 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 rust/kernel/scatterlist.rs

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index c20b37e88ab2..b23be69919cc 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -71,6 +71,7 @@ pub mod net;
 pub mod pages;
 pub mod power;
 pub mod revocable;
+pub mod scatterlist;
 pub mod security;
 pub mod task;
 pub mod workqueue;
diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
new file mode 100644
index 000000000000..fe036af13995
--- /dev/null
+++ b/rust/kernel/scatterlist.rs
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Scatterlist abstractions.
+//!
+//! C header: [`include/linux/virtio.h`](../../../../include/linux/scatterlist.h)
+
+use core::cell::UnsafeCell;
+
+/// Scatterlist abstraction over the C side `struct scatterlist`.
+pub struct Scatterlist {
+    /// The C side `struct scatterlist`.
+    inner: UnsafeCell<bindings::scatterlist>,
+}
+
+impl Scatterlist {
+    /// A wrapper over the C-side `sg_init_one()`. Initialize a single entry sg
+    /// list.
+    ///
+    /// # Safety
+    ///
+    /// Caller must ensure that `buf` is valid and `buflen` really
+    /// represents the size of `buf`.
+    pub unsafe fn init_one(buf: *const core::ffi::c_void, buflen: u32) -> Self {
+        // SAFETY: There are no references or function pointers in this
+        // `Scatterlist`.
+        let mut sg: Scatterlist = unsafe { core::mem::zeroed() };
+        // SAFETY: we pass a valid sg entry, which points to stack-allocated
+        // variable above. `buf` and `buflen` are presumed valid as per this
+        // function's safety requirements.
+        unsafe {
+            bindings::sg_init_one(sg.inner.get_mut(), buf, buflen);
+        }
+
+        sg
+    }
+
+    pub(crate) fn inner(&self) -> &UnsafeCell<bindings::scatterlist> {
+        &self.inner
+    }
+}
-- 
2.40.0

