Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4958067402A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjASRlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjASRlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:41:20 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FDF5421C;
        Thu, 19 Jan 2023 09:40:59 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id p133so2282941oig.8;
        Thu, 19 Jan 2023 09:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+sej2ZxxI8+9iAYbhNxmaN6Ujy8XCLYxGf1h6Atn53o=;
        b=oXH2HzaBjYUWyrxXrR0aA6Trc8tK3yh35yGvu1GnMLz2SAhX4u5RQpxt5ma5Wl75oh
         VTRKvtXos1Z2WX7lK5t0u9Zs5bqPHiH2MSPs8EAp5WP9KkdYCxXJUXtVL3V6OJSknG0w
         AcaKL0SIUL8BC9N9CfCzOrgk2fcNODHN6ZwWYyCqSJjSsg9rmz3gT6AcoQAKeth5xk6P
         C5EQJNyRyVGERAEpsi2iaR5f3oRWpRBDw2hSJd8TFCLQx2YFuis42RB7K8YWmwD7H1Zn
         QsxwFXiPR7LJqRmX5cCW0N+LEOvZqpcIVbuisVzO4d1iXH9WH4Wmmk5rw4QaX4raT1Q+
         APPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+sej2ZxxI8+9iAYbhNxmaN6Ujy8XCLYxGf1h6Atn53o=;
        b=SP56YPl+17g4mzKIo74s6s7MqysUD+9GU8NTwNsRdaVDJUj2tT03GspGHNpgBzUWwx
         ebmOLJ+H5jcIIsAa+w1IHiiSw3qWOn53sAQKr51abwlr9BowZ+R9uGHfr/MewPjfQedm
         Xw3JP0nb39sjVUJcsVWCKVpSpwre5vDjktmrJZ6yASJhI13MDY0eCnEhGjGleS8gdoiH
         cmp3lv2Do/Q1k3s5YQyFs8zKjTewKCkIduFL4R/Xz4n1Shs7Wv+HMo2w1Dj/FYpiVhCo
         9f1K2xExF9/MmjmFRYU5kKBuQ/RgTPLuU9EKU1mzGKo32G/2xVWYC26/tc76htEoT5bo
         oVOQ==
X-Gm-Message-State: AFqh2krUfyytv0iVmTzKs4Yyvma7i85HYezhk64n/HBcP2xBcHNc6r8B
        Q3pqgIIqi7oR5AU67IbKKmEu2pKj8gFuN905
X-Google-Smtp-Source: AMrXdXua1TdChQflT3oJQMco3ayOtezrsL4DFbYeJt2NUqYkwEqjENwbK6xppHotS6D/Fl+UPk+9CQ==
X-Received: by 2002:aca:3c88:0:b0:35e:bc08:35f6 with SMTP id j130-20020aca3c88000000b0035ebc0835f6mr4959874oia.8.1674150058819;
        Thu, 19 Jan 2023 09:40:58 -0800 (PST)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id i7-20020a056808054700b003631fe1810dsm10226906oig.47.2023.01.19.09.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 09:40:58 -0800 (PST)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: [PATCH 1/5] rust: types: introduce `ScopeGuard`
Date:   Thu, 19 Jan 2023 14:40:32 -0300
Message-Id: <20230119174036.64046-1-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to run some code when the guard is dropped (e.g.,
implicitly when it goes out of scope). We can also prevent the
guard from running by calling its `dismiss()` method.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
---
 rust/kernel/types.rs | 127 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 126 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index e84e51ec9716..f0ad4472292d 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -2,7 +2,132 @@
 
 //! Kernel types.
 
-use core::{cell::UnsafeCell, mem::MaybeUninit};
+use alloc::boxed::Box;
+use core::{
+    cell::UnsafeCell,
+    mem::MaybeUninit,
+    ops::{Deref, DerefMut},
+};
+
+/// Runs a cleanup function/closure when dropped.
+///
+/// The [`ScopeGuard::dismiss`] function prevents the cleanup function from running.
+///
+/// # Examples
+///
+/// In the example below, we have multiple exit paths and we want to log regardless of which one is
+/// taken:
+/// ```
+/// # use kernel::ScopeGuard;
+/// fn example1(arg: bool) {
+///     let _log = ScopeGuard::new(|| pr_info!("example1 completed\n"));
+///
+///     if arg {
+///         return;
+///     }
+///
+///     pr_info!("Do something...\n");
+/// }
+///
+/// # example1(false);
+/// # example1(true);
+/// ```
+///
+/// In the example below, we want to log the same message on all early exits but a different one on
+/// the main exit path:
+/// ```
+/// # use kernel::ScopeGuard;
+/// fn example2(arg: bool) {
+///     let log = ScopeGuard::new(|| pr_info!("example2 returned early\n"));
+///
+///     if arg {
+///         return;
+///     }
+///
+///     // (Other early returns...)
+///
+///     log.dismiss();
+///     pr_info!("example2 no early return\n");
+/// }
+///
+/// # example2(false);
+/// # example2(true);
+/// ```
+///
+/// In the example below, we need a mutable object (the vector) to be accessible within the log
+/// function, so we wrap it in the [`ScopeGuard`]:
+/// ```
+/// # use kernel::ScopeGuard;
+/// fn example3(arg: bool) -> Result {
+///     let mut vec =
+///         ScopeGuard::new_with_data(Vec::new(), |v| pr_info!("vec had {} elements\n", v.len()));
+///
+///     vec.try_push(10u8)?;
+///     if arg {
+///         return Ok(());
+///     }
+///     vec.try_push(20u8)?;
+///     Ok(())
+/// }
+///
+/// # assert_eq!(example3(false), Ok(()));
+/// # assert_eq!(example3(true), Ok(()));
+/// ```
+///
+/// # Invariants
+///
+/// The value stored in the struct is nearly always `Some(_)`, except between
+/// [`ScopeGuard::dismiss`] and [`ScopeGuard::drop`]: in this case, it will be `None` as the value
+/// will have been returned to the caller. Since  [`ScopeGuard::dismiss`] consumes the guard,
+/// callers won't be able to use it anymore.
+pub struct ScopeGuard<T, F: FnOnce(T)>(Option<(T, F)>);
+
+impl<T, F: FnOnce(T)> ScopeGuard<T, F> {
+    /// Creates a new guarded object wrapping the given data and with the given cleanup function.
+    pub fn new_with_data(data: T, cleanup_func: F) -> Self {
+        // INVARIANT: The struct is being initialised with `Some(_)`.
+        Self(Some((data, cleanup_func)))
+    }
+
+    /// Prevents the cleanup function from running and returns the guarded data.
+    pub fn dismiss(mut self) -> T {
+        // INVARIANT: This is the exception case in the invariant; it is not visible to callers
+        // because this function consumes `self`.
+        self.0.take().unwrap().0
+    }
+}
+
+impl ScopeGuard<(), Box<dyn FnOnce(())>> {
+    /// Creates a new guarded object with the given cleanup function.
+    pub fn new(cleanup: impl FnOnce()) -> ScopeGuard<(), impl FnOnce(())> {
+        ScopeGuard::new_with_data((), move |_| cleanup())
+    }
+}
+
+impl<T, F: FnOnce(T)> Deref for ScopeGuard<T, F> {
+    type Target = T;
+
+    fn deref(&self) -> &T {
+        // The type invariants guarantee that `unwrap` will succeed.
+        &self.0.as_ref().unwrap().0
+    }
+}
+
+impl<T, F: FnOnce(T)> DerefMut for ScopeGuard<T, F> {
+    fn deref_mut(&mut self) -> &mut T {
+        // The type invariants guarantee that `unwrap` will succeed.
+        &mut self.0.as_mut().unwrap().0
+    }
+}
+
+impl<T, F: FnOnce(T)> Drop for ScopeGuard<T, F> {
+    fn drop(&mut self) {
+        // Run the cleanup function if one is still present.
+        if let Some((data, cleanup)) = self.0.take() {
+            cleanup(data)
+        }
+    }
+}
 
 /// Stores an opaque value.
 ///
-- 
2.34.1

