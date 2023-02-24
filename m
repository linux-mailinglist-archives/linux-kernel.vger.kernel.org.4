Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635DC6A1AAA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjBXKyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjBXKyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:54:00 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7DD149A5;
        Fri, 24 Feb 2023 02:53:51 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C3BF64248B;
        Fri, 24 Feb 2023 10:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677236029;
        bh=XcpgOxW9xbW5RI+qtCoIK9qZZvy3Hmqang8OrPgwtSc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=S5GfRRLtjTEa1GDauhqm4LwpVNGK9hwlbYZMDG1ymiXWS62XPbSGKGYfVdiESMhsi
         oUWZbjIsVtLtdpjnPlNLc77tt5cg+DOJTJpoB3SVHHaCuQoH8yutbwrBHCwUAni2W1
         mqtw2lyg9Mt87jqcgmsl1HYvkyr9NBfRbfvZgjxMbTcr393YYR5lLtfwsxo3q3n7pq
         ++U2vR8szdn9AXLuHQV+Y5Rvt+zp2PfwNt4/xhZjI/W2vjqvDSw+Fg+khrXomc4NsQ
         0TGF7QjLUZgLXGpMl/IEJlXXz2yC5DOQ17LEM+bGey75KDq1KQM6dPemGRxock3Wkv
         rB9HwMDHJCxtg==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 24 Feb 2023 19:53:14 +0900
Subject: [PATCH 2/5] rust: device: Add a minimal RawDevice trait
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-iopt-rtkit-v1-2-49ced3391295@asahilina.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677236013; l=2542;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=soR466tRTXjasiXIM/nVS1quyj2/l4EZ0DnmL76tJBs=;
 b=lgy1PZ0uyKdd/tM/G8noK7EaD5kUIHfT1uSUmIXZ1IA3ri0x3dNuPzq/TelJO3hm34TrgUqE9
 bNEhHLGfh08CnZPIzu2dvrfFa3L9h2u7tHdI6Yy4lBJWvKiNRcLpm1x
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

Add a RawDevice trait which can be implemented by any type representing
a device class (such as a PlatformDevice). This is the minimum amount of
Device support code required to unblock abstractions that need to take
device pointers.

Lina: Rewrote commit message, and dropped everything except RawDevice.

Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/device.rs           | 23 +++++++++++++++++++++++
 rust/kernel/lib.rs              |  1 +
 3 files changed, 25 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 75d85bd6c592..3632a39a28a6 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -6,6 +6,7 @@
  * Sorted alphabetically.
  */
 
+#include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
 
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
new file mode 100644
index 000000000000..9be021e393ca
--- /dev/null
+++ b/rust/kernel/device.rs
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Generic devices that are part of the kernel's driver model.
+//!
+//! C header: [`include/linux/device.h`](../../../../include/linux/device.h)
+
+use crate::bindings;
+
+/// A raw device.
+///
+/// # Safety
+///
+/// Implementers must ensure that the `*mut device` returned by [`RawDevice::raw_device`] is
+/// related to `self`, that is, actions on it will affect `self`. For example, if one calls
+/// `get_device`, then the refcount on the device represented by `self` will be incremented.
+///
+/// Additionally, implementers must ensure that the device is never renamed. Commit a5462516aa99
+/// ("driver-core: document restrictions on device_rename()") has details on why `device_rename`
+/// should not be used.
+pub unsafe trait RawDevice {
+    /// Returns the raw `struct device` related to `self`.
+    fn raw_device(&self) -> *mut bindings::device;
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 82dff6f4cf60..de44092718f8 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -29,6 +29,7 @@ compile_error!("Missing kernel configuration for conditional compilation");
 #[cfg(not(testlib))]
 mod allocator;
 mod build_assert;
+pub mod device;
 pub mod error;
 pub mod prelude;
 pub mod print;

-- 
2.35.1

