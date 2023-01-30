Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140A268061E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 07:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbjA3Goa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 01:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbjA3Go1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:44:27 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7D415578;
        Sun, 29 Jan 2023 22:44:24 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id j21so312924oie.4;
        Sun, 29 Jan 2023 22:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j8ZUXqun6hxbI6VIQC3Ge5/u02Uxo9oBunAE6nqBMNE=;
        b=OEef1OhR/654sAULD3m23pr5qKgaUq+QcLO3XuwifFwoihper6elgbQSP9owaWpU/s
         Tgj1YJDnA2Iy4BdLW1i2PCPqCwe+SLIM4rZqXlCbRiqj/Rbf40OYxeVhwEa+QXRCyU7W
         QNLu+MsUEmcWvlnTr9RaYQWO8MnkVuXFFTL2vSpIxD/TrdsXJh2QW0h6LUVB5ATjT15r
         Yl7nRc3dISIo4Tb1UQylhR3CknCd2yhoyTtW+KjbLKlP5HauDgu2af9+rt0RIZdGDvVD
         MbwAX3NjJRcXNeTad24q95nTY2RCiRWiFWuUDWONeDNlhf+ufGr2ZNUQRakHabTYIdba
         Xv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8ZUXqun6hxbI6VIQC3Ge5/u02Uxo9oBunAE6nqBMNE=;
        b=pYhQ8jCeY/RqkP7s7RnZLS4+gBhjOI54dIZQdBJVNuEpInkmYCT8s06SYUDXuv50Jf
         P2YgnR3kvzS7Nr8LTG/rYXUZaSL7aWDTjN7Wb0oQqUyjtN9palZINJkpyITmoOurRIaS
         e0d+NZmxpFN3/UycbsKY/EJDrykB9KQKSVaUhrnXyaTgNZtJJrzm5GHHdpi7kER0p/4A
         Z44ZXSTJBjEzDlSge5nj7rbF1p0a0i8PWkjnND6SxPNC879LsuIUCK4WMqG62t1RbJp8
         KBFxAsAzz5n5s5HI+gVKBGjNJsUsTD7WQ8ue4RS3Om3BygW2XkoZe+/HI/M5D1rvBslB
         5Rqw==
X-Gm-Message-State: AFqh2kpw1HMz5uZ9+CljIPJL/KUXd7WrkhSzTcFTNGCgL7F1rfM0UBv3
        BL4OngOXpi5eir3NZOCuEQr84qT78RSL9FSt
X-Google-Smtp-Source: AMrXdXvDCps1U1MgXHPHos9QbB4W324FPVoZ8fVOBzFF28m5LyME+YAjEZ0ynXB7QKo12LEF1GS1hQ==
X-Received: by 2002:aca:3c87:0:b0:360:cb13:e78a with SMTP id j129-20020aca3c87000000b00360cb13e78amr20257473oia.58.1675061063833;
        Sun, 29 Jan 2023 22:44:23 -0800 (PST)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id o64-20020aca5a43000000b003670342726fsm4427883oib.12.2023.01.29.22.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 22:44:23 -0800 (PST)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: [PATCH v2 1/5] rust: types: introduce `ScopeGuard`
Date:   Mon, 30 Jan 2023 03:44:00 -0300
Message-Id: <20230130064404.744600-1-wedsonaf@gmail.com>
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
Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
---
v1 -> v2: Simpler type for `ScopeGuard::new()` impl block

 rust/kernel/types.rs | 126 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index e84e51ec9716..dd834bfcb57b 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -2,7 +2,131 @@
 
 //! Kernel types.
 
-use core::{cell::UnsafeCell, mem::MaybeUninit};
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
+impl ScopeGuard<(), fn(())> {
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

