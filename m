Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1117498B2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 11:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjGFJq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 05:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGFJq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 05:46:26 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50A41727
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 02:46:24 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-51e2295e74eso469035a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 02:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688636783; x=1691228783;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0eYCSqQxSlAR3RibXXnHPvPQ1h6TQ1/VygEPnbsiTbg=;
        b=H1tRYgNOzaDextngjG1i4fRJhAypNqzhecp294gztutf6ZBH1wl5Ew+HgbKmFp8cM9
         x6SvTCcxQ3ARUDbkgO/lWmwyIk6zK8U6l9/EXSp6Pi7+RjegS4lD39Uf8idzxr80pqPF
         bjpeA2CTI28mosSlpzVDMkmYsCn+17IqyL7lEehCKl+q4VXuk3LnppdTUfeWEeTp5ido
         yzRwFow3HTTW9PPWHVl8yK6GZ32aKCMQcHis/NPnknLNfOJE+1eXSrZ9nla31dgoiFeI
         nIzqkLiUsAiSvzA+B8L6TQbz2R07iW5IsTtfvloT0jIXgZUvk/aFUBmVqyl0jCVxGGL7
         6bfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688636783; x=1691228783;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0eYCSqQxSlAR3RibXXnHPvPQ1h6TQ1/VygEPnbsiTbg=;
        b=iR6MWB8YhHuCjTGHzwW0Kl1EUYmx4SHNuFnzIKUOm1lw2BEteW3gboJkD/WKSk0eCB
         YOjttKt46iqq40T8hUwX8sbMlbbEX1wrGiODPaEW6d1Yweo6I8dorRoypER2lO16A5gz
         ViRHh68wkcBZvcVcioUKdXqo8sRuKJQ4fihulU+JO+Rblo7l4n8Mdu0POXyhrIBOlGQM
         WA3By1QYAzsL0n/GRuSdee2/LL/9n9Im5Oe5n9bIkR17Pj7KTroPIhprn5E9ZzV8DoAG
         jQI4Anlor8pKwIOvYM71DfLg2YIiiBN3HZaK+gHKpOA8jaOiYrMJDZRMyLIg2aYWpe+7
         voog==
X-Gm-Message-State: ABy/qLYCYBI2zgzAK5qSNO4ySpXJH64S8F90MwZ53pI0a/WgHS7u0Tio
        U50c/Jw+dFXiiLJ+NzNWwuH8/RLzPMP85xU=
X-Google-Smtp-Source: APBJJlGlXnXSogXQMZLv1m0sa+cO8bIZhhr+Phsktwd5wancAgiLZxSk5gVA7y7E4iW379DNToZn7e9HT6WW0/g=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a50:9345:0:b0:51d:9659:4dae with SMTP id
 n5-20020a509345000000b0051d96594daemr7394eda.5.1688636783141; Thu, 06 Jul
 2023 02:46:23 -0700 (PDT)
Date:   Thu,  6 Jul 2023 09:46:15 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230706094615.3080784-1-aliceryhl@google.com>
Subject: [PATCH] rust: delete `ForeignOwnable::borrow_mut`
From:   Alice Ryhl <aliceryhl@google.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We discovered that the current design of `borrow_mut` is problematic.
This patch removes it until a better solution can be found.

Specifically, the current design gives you access to a `&mut T`, which
lets you change where the `ForeignOwnable` points (e.g., with
`core::mem::swap`). No upcoming user of this API intended to make that
possible, making all of them unsound.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/arc.rs |  3 +--
 rust/kernel/types.rs    | 22 ++--------------------
 2 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index a89843cacaad..172f563976a9 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -243,8 +243,7 @@ unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
         let inner = NonNull::new(ptr as *mut ArcInner<T>).unwrap();
 
         // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
-        // for the lifetime of the returned value. Additionally, the safety requirements of
-        // `ForeignOwnable::borrow_mut` ensure that no new mutable references are created.
+        // for the lifetime of the returned value.
         unsafe { ArcBorrow::new(inner) }
     }
 
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 1e5380b16ed5..d479f8da8f38 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -35,34 +35,16 @@ pub trait ForeignOwnable: Sized {
     ///
     /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
     /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
-    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow_mut`]
-    /// for this object must have been dropped.
     unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrowed<'a>;
 
-    /// Mutably borrows a foreign-owned object.
-    ///
-    /// # Safety
-    ///
-    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
-    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
-    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] and
-    /// [`ForeignOwnable::borrow_mut`] for this object must have been dropped.
-    unsafe fn borrow_mut(ptr: *const core::ffi::c_void) -> ScopeGuard<Self, fn(Self)> {
-        // SAFETY: The safety requirements ensure that `ptr` came from a previous call to
-        // `into_foreign`.
-        ScopeGuard::new_with_data(unsafe { Self::from_foreign(ptr) }, |d| {
-            d.into_foreign();
-        })
-    }
-
     /// Converts a foreign-owned object back to a Rust-owned one.
     ///
     /// # Safety
     ///
     /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
     /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
-    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] and
-    /// [`ForeignOwnable::borrow_mut`] for this object must have been dropped.
+    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] for
+    /// this object must have been dropped.
     unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self;
 }
 

base-commit: d2e3115d717197cb2bc020dd1f06b06538474ac3
-- 
2.41.0.255.g8b1d071c50-goog

