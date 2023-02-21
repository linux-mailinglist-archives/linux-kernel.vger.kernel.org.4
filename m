Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C4969DAEC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 08:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjBUHH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 02:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjBUHH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:07:27 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BE41F4B2;
        Mon, 20 Feb 2023 23:07:25 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 3663C4212E;
        Tue, 21 Feb 2023 07:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1676963243;
        bh=A6KIoIu/aWBN1yeja85GO8JYcwY1Qw51Y1+fwsMD53Q=;
        h=From:Date:Subject:To:Cc;
        b=XHzIza3Ub/FjJcWrwQHESLsoh9ezdwJTGya8kSVtAe1FKXcEN0itGH1EBuzZ2l74+
         gtLrDhK1sAeFoFHh/ZMSjv0j5GYVW1sTIiPHKFLNPqTC4Jr5fRlW/XJ/JAuXP9wcpX
         ErcFiyIu/5MUj8CrwvfXsbm4+uK2J2MbJPpL1zkk3CiDCITxaeMI6fsxElrnNMb6U0
         LuB938Hfl4B3ajFzIlr9gvQBt8AHVunuie/nrAIv7gpri1T8un7oA/ShRT04xWz2Oc
         eK9r1kkNjANKKTE13wHlr5ydHgsM+WxB4AgVqfZiWK4QJq4l15Rk2/up5JO4GT2JF9
         yruLTZsgjvvNw==
From:   Asahi Lina <lina@asahilina.net>
Date:   Tue, 21 Feb 2023 16:06:36 +0900
Subject: [PATCH] rust: time: New module for timekeeping functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230221-gpu-up-time-v1-1-bf8fe74b7f55@asahilina.net>
X-B4-Tracking: v=1; b=H4sIAHtt9GMC/x2NQQrDIBAAvxL23AXd5NJ+peSgZqsLqRGtIRDy9
 yw9zsAwJzSuwg1ewwmVd2myZQX7GCAklyOjLMpAhkZDZDGWjr3gT76M7J6TJTJTGD1o4V1j9NX
 lkLTJfV1VlsofOf6L93xdNyr3I0hyAAAA
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676963239; l=2619;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=A6KIoIu/aWBN1yeja85GO8JYcwY1Qw51Y1+fwsMD53Q=;
 b=PCyQteOlBV30u4Or1zgaDIULokFbkC+cEOyujN6u6p+d3o8raXypNxbmbQsytrR+KgZlcE0PH
 i7eGpPhDHZmD+14BL1DMnBTwBEJ2NDnS9UV3DRHqqnwHySW4bZp9LTR
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

This module is intended to contain functions related to kernel
timekeeping and time. Initially, this just wraps ktime_get() and
ktime_get_boottime() and returns them as core::time::Duration instances.
This is useful for drivers that need to implement simple retry loops and
timeouts.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/bindings/bindings_helper.h |  4 +++-
 rust/kernel/lib.rs              |  1 +
 rust/kernel/time.rs             | 25 +++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 75d85bd6c592..587f3d1c0c9f 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -6,8 +6,10 @@
  * Sorted alphabetically.
  */
 
-#include <linux/slab.h>
+#include <linux/ktime.h>
 #include <linux/refcount.h>
+#include <linux/slab.h>
+#include <linux/timekeeping.h>
 
 /* `bindgen` gets confused at certain things. */
 const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 223564f9f0cc..371b1b17570e 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -37,6 +37,7 @@ mod static_assert;
 pub mod std_vendor;
 pub mod str;
 pub mod sync;
+pub mod time;
 pub mod types;
 
 #[doc(hidden)]
diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
new file mode 100644
index 000000000000..02844db47d34
--- /dev/null
+++ b/rust/kernel/time.rs
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Timekeeping functions.
+//!
+//! C header: [`include/linux/ktime.h`](../../../../include/linux/ktime.h)
+//! C header: [`include/linux/timekeeping.h`](../../../../include/linux/timekeeping.h)
+
+use crate::bindings;
+use core::time::Duration;
+
+/// Returns the kernel time elapsed since boot, excluding time spent sleeping, as a [`Duration`].
+pub fn ktime_get() -> Duration {
+    // SAFETY: Function has no side effects and no inputs.
+    Duration::from_nanos(unsafe { bindings::ktime_get() }.try_into().unwrap())
+}
+
+/// Returns the kernel time elapsed since boot, including time spent sleeping, as a [`Duration`].
+pub fn ktime_get_boottime() -> Duration {
+    Duration::from_nanos(
+        // SAFETY: Function has no side effects and no variable inputs.
+        unsafe { bindings::ktime_get_with_offset(bindings::tk_offsets_TK_OFFS_BOOT) }
+            .try_into()
+            .unwrap(),
+    )
+}

---
base-commit: 89f5349e0673322857bd432fa23113af56673739
change-id: 20230221-gpu-up-time-ea9412204c3b

Thank you,
~~ Lina

