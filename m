Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602EB7155AC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 08:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjE3GtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 02:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjE3Gs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 02:48:58 -0400
Received: from out0-198.mail.aliyun.com (out0-198.mail.aliyun.com [140.205.0.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A358110E;
        Mon, 29 May 2023 23:48:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047213;MF=changxian.cqs@antgroup.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---.TGKDccU_1685429325;
Received: from localhost(mailfrom:changxian.cqs@antgroup.com fp:SMTPD_---.TGKDccU_1685429325)
          by smtp.aliyun-inc.com;
          Tue, 30 May 2023 14:48:45 +0800
From:   "Qingsong Chen" <changxian.cqs@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "=?UTF-8?B?55Sw5rSq5Lqu?=" <tate.thl@antgroup.com>,
        "Qingsong Chen" <changxian.cqs@antgroup.com>,
        "Boqun Feng" <boqun.feng@gmail.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Gary Guo" <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        "Benno Lossin" <benno.lossin@proton.me>,
        "Martin Rodriguez Reboredo" <yakoyoku@gmail.com>,
        "Asahi Lina" <lina@asahilina.net>,
        "Sven Van Asbroeck" <thesven73@gmail.com>,
        "Viktor Garske" <viktor@v-gar.de>, "Finn Behrens" <me@kloenk.dev>,
        <rust-for-linux@vger.kernel.org>
Subject: [PATCH 2/2] samples: rust: add `SgTable` and `ScatterList` selftests
Date:   Tue, 30 May 2023 14:48:21 +0800
Message-Id: <20230530064821.1222290-3-changxian.cqs@antgroup.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530064821.1222290-1-changxian.cqs@antgroup.com>
References: <20230530064821.1222290-1-changxian.cqs@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a selftest module to provide a temporary place to put "pure tests"
for Rust funtionality and wrappers.

Add test cases for `SgTable` and `ScatterList`.

Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
---
 rust/kernel/error.rs           |   2 +-
 samples/rust/Kconfig           |  10 ++
 samples/rust/Makefile          |   1 +
 samples/rust/rust_selftests.rs | 186 +++++++++++++++++++++++++++++++++
 4 files changed, 198 insertions(+), 1 deletion(-)
 create mode 100644 samples/rust/rust_selftests.rs

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 5f4114b30b94..40f2db9d57a6 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -68,7 +68,7 @@ pub mod code {
 /// # Invariants
 ///
 /// The value is a valid `errno` (i.e. `>= -MAX_ERRNO && < 0`).
-#[derive(Clone, Copy, PartialEq, Eq)]
+#[derive(Clone, Copy, PartialEq, Eq, Debug)]
 pub struct Error(core::ffi::c_int);
 
 impl Error {
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index b0f74a81c8f9..a1f29e5aaf83 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -30,6 +30,16 @@ config SAMPLE_RUST_PRINT
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_SELFTESTS
+	tristate "Self tests"
+	help
+	  This option builds the self test cases for Rust.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_selftests.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_HOSTPROGS
 	bool "Host programs"
 	help
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index 03086dabbea4..4519a567db7c 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -2,5 +2,6 @@
 
 obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
 obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
+obj-$(CONFIG_SAMPLE_RUST_SELFTESTS)		+= rust_selftests.o
 
 subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
diff --git a/samples/rust/rust_selftests.rs b/samples/rust/rust_selftests.rs
new file mode 100644
index 000000000000..843d53159ac8
--- /dev/null
+++ b/samples/rust/rust_selftests.rs
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Self test cases for Rust.
+
+use kernel::prelude::*;
+// Keep the `use` for a test in its test function. Module-level `use`s are only for the test
+// framework.
+
+module! {
+    type: RustSelftests,
+    name: "rust_selftests",
+    author: "Rust for Linux Contributors",
+    description: "Self test cases for Rust",
+    license: "GPL",
+}
+
+struct RustSelftests;
+
+/// A summary of testing.
+///
+/// A test can
+///
+/// * pass (successfully), or
+/// * fail (without hitting any error), or
+/// * hit an error (interrupted).
+///
+/// This is the type that differentiates the first two (pass and fail) cases.
+///
+/// When a test hits an error, the test function should skip and return the error. Note that this
+/// doesn't mean the test fails, for example if the system doesn't have enough memory for
+/// testing, the test function may return an `Err(ENOMEM)` and skip.
+#[allow(dead_code)]
+enum TestSummary {
+    Pass,
+    Fail,
+}
+
+use TestSummary::Fail;
+use TestSummary::Pass;
+
+macro_rules! do_tests {
+    ($($name:ident),*) => {
+        let mut total = 0;
+        let mut pass = 0;
+        let mut fail = 0;
+
+        $({
+            total += 1;
+
+            match $name() {
+                Ok(Pass) => {
+                    pass += 1;
+                    pr_info!("{} passed!", stringify!($name));
+                },
+                Ok(Fail) => {
+                    fail += 1;
+                    pr_info!("{} failed!", stringify!($name));
+                },
+                Err(err) => {
+                    pr_info!("{} hit error {:?}", stringify!($name), err);
+                }
+            }
+        })*
+
+        pr_info!("{} tests run, {} passed, {} failed, {} hit errors\n",
+                 total, pass, fail, total - pass - fail);
+
+        if total == pass {
+            pr_info!("All tests passed. Congratulations!\n");
+        }
+    }
+}
+
+/// An example of test.
+#[allow(dead_code)]
+fn test_example() -> Result<TestSummary> {
+    // `use` declarations for the test can be put here, e.g. `use foo::bar;`.
+
+    // Always pass.
+    Ok(Pass)
+}
+
+/// A selftest case for `SgTable`.
+fn test_sgtable() -> Result<TestSummary> {
+    use core::pin::pin;
+    use kernel::scatterlist::*;
+
+    // Prepare memory buffers.
+    let buf0: Pin<&mut [u8]> = pin!([0u8; 512]);
+    let buf1: Pin<&mut [u8]> = pin!([1u8; 512]);
+    let mut entries = Vec::<Pin<&mut [u8]>>::new();
+    entries.try_push(buf0)?;
+    entries.try_push(buf1)?;
+
+    // Construct two `SgTable` instances. And the first is chainable, which
+    // requires one entry reserved.
+    let mut sgt0: Pin<Box<SgTable<'_, 3>>> =
+        Box::pin_init(SgTable::<'_, 3>::new(entries.as_slice(), true))?;
+    let mut sgt1: Pin<Box<SgTable<'_, 2>>> =
+        Box::pin_init(SgTable::<'_, 2>::new(entries.as_slice(), false))?;
+
+    // Assert the total count of entries in the table.
+    assert_eq!(sgt0.count(), 2);
+    assert_eq!(sgt1.count(), 2);
+
+    // Chain two `SgTable` together.
+    sgt0.chain_sgt(sgt1.as_mut())?;
+    assert_eq!(sgt0.count(), 4);
+    assert_eq!(sgt1.count(), 2);
+
+    // Get the immutable reference to the entry in the table.
+    let sgl1: Pin<&ScatterList<'_>> = sgt0.get(1).ok_or(EINVAL)?;
+    assert_eq!(sgl1.count(), 3);
+
+    // Get the mutable reference to the entry in the table.
+    let sgl3: Pin<&mut ScatterList<'_>> = sgt0.get_mut(3).ok_or(EINVAL)?;
+    assert_eq!(sgl3.count(), 1);
+
+    // Try to get a non-exist entry from the table.
+    let sgl4 = sgt0.get(4);
+    assert_eq!(sgl4.is_none(), true);
+
+    // Split the first table from chained scatterlist.
+    sgt0.split()?;
+    assert_eq!(sgt0.count(), 2);
+    assert_eq!(sgt1.count(), 2);
+
+    // Chain `SgTable` with single `ScatterList`.
+    let mut sgl: Pin<Box<ScatterList<'_>>> = Box::pin_init(ScatterList::new(&entries[0]))?;
+    sgt0.chain_sgl(sgl.as_mut())?;
+    assert_eq!(sgt0.count(), 3);
+
+    Ok(Pass)
+}
+
+/// A selftest case for `ScatterList`.
+fn test_scatterlist() -> Result<TestSummary> {
+    use core::pin::pin;
+    use kernel::scatterlist::*;
+
+    // Prepare memory buffers.
+    let buf0: Pin<&mut [u8]> = pin!([0u8; 512]);
+    let buf1: Pin<&mut [u8]> = pin!([1u8; 512]);
+
+    // Construct a `ScatterList` instance. And assert its attributes.
+    let mut sgl: Pin<Box<ScatterList<'_>>> = Box::pin_init(ScatterList::new(&buf0))?;
+    assert_eq!(sgl.length(), 512);
+    assert_eq!(sgl.is_dma_bus_address(), false);
+    assert_eq!(sgl.dma_address(), 0);
+    assert_eq!(sgl.dma_length(), 0);
+    assert_eq!(sgl.is_chain(), false);
+    assert_eq!(sgl.is_last(), true);
+    assert_eq!(sgl.count(), 1);
+
+    // Get an immutable reference to the memory buffer.
+    assert_eq!(sgl.get_buf(), [0u8; 512]);
+
+    // Reset the memory buffer.
+    sgl.set_buf(&buf1);
+    assert_eq!(sgl.get_buf(), [1u8; 512]);
+
+    // Get a mutable reference to memory buffer.
+    sgl.get_mut_buf().fill(2);
+    assert_eq!(sgl.get_buf(), [2u8; 512]);
+
+    Ok(Pass)
+}
+
+impl kernel::Module for RustSelftests {
+    fn init(_module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust self tests (init)\n");
+
+        do_tests! {
+            test_sgtable,
+            test_scatterlist
+        };
+
+        Ok(RustSelftests)
+    }
+}
+
+impl Drop for RustSelftests {
+    fn drop(&mut self) {
+        pr_info!("Rust self tests (exit)\n");
+    }
+}
-- 
2.40.1

