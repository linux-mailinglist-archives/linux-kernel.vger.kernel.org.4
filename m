Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE4F680628
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 07:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbjA3Gqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 01:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbjA3Gou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:44:50 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E061A27D6F;
        Sun, 29 Jan 2023 22:44:45 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id r9so9240877oig.12;
        Sun, 29 Jan 2023 22:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQ9qgUpJKoZ5vFNL/Ds3EfhNmCcB+s3S4YIjtxQ6XEM=;
        b=CYBfd2h4juLb8ljnjOPnGGQy975kHYuXZKKiex0EiXvVdjsCLTYYd8A1e8Zlzam45F
         YzlFB1FKHC5fK48nD2AWqSM+4J6FVykrjrEvIpiDw0HeTkQm+m8QSf6JPDOq+sOdz2Vk
         TF2+6e1unJq8erVP4qARMVkJ5YJpiHIozLI3Sf1VanWf1norVjiC+i1cJQY7wTvMptOa
         OmMQgcQDjpoqUrZ/2mbksTBeGldJflLL1VUalb6djHZylczS7bIZs7FZm5Z8/gadrjEj
         lHrxNC/mLW1BbhjONgH+x/0JchUC/If7sKtjMbXMtyxJ4Q+V9yNHQZ8f/r8QuCuxjjLe
         Xriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQ9qgUpJKoZ5vFNL/Ds3EfhNmCcB+s3S4YIjtxQ6XEM=;
        b=4yFbdX94cKP3Q3NiWswb2raKWpbVjYQjTYx6rXo+I+ESl1dOLmqxTO7Yz9bdb+C5H6
         dxJBIoAZO6x4s4MjjYtAcG0GfPkMDbbo+XhrJX0Mfv2ckwlSJEXAub2wUDT6gj830PNg
         4GjW04dqb9NTgPYPa9jqmYk5eCebhxQRNl42n5t3RNqo6RUSZp/Lt4L3ayfF+BRn8JXi
         9ABxmN/ly9CBY5+WJ8+rNCF1dPPjDZUxykEZL0+ZhhrDvkMgHn3D9pGn0pcI6j2Iawty
         8zSx0k0HZL6fjbuHvkMRtQuAzJAdoOhRLUbrvK0Lg+9kxYa1jVSweJ4m53YpsreyrJqT
         0RIA==
X-Gm-Message-State: AO0yUKXCKPuUV9tLWKlazneo4f6iU2ijhz7kok8gGXTJnMH9MAGkEcEF
        zhNlhWQo6Cm9mynGOca8UqOjz1DqV4KeiiwB
X-Google-Smtp-Source: AK7set/Dhq2VDKOI3zELMz/PdNxFF6CQBqZmPeHOUjvMX/jvX4vWnGFMjomZTadRnTNfRC4BdexSig==
X-Received: by 2002:a05:6808:2394:b0:378:2aa6:ddcd with SMTP id bp20-20020a056808239400b003782aa6ddcdmr2723386oib.17.1675061085231;
        Sun, 29 Jan 2023 22:44:45 -0800 (PST)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id o64-20020aca5a43000000b003670342726fsm4427883oib.12.2023.01.29.22.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 22:44:45 -0800 (PST)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [PATCH v2 5/5] rust: types: implement `ForeignOwnable` for `Arc<T>`
Date:   Mon, 30 Jan 2023 03:44:04 -0300
Message-Id: <20230130064404.744600-5-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230130064404.744600-1-wedsonaf@gmail.com>
References: <20230130064404.744600-1-wedsonaf@gmail.com>
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

This allows us to hand ownership of Rust ref-counted objects to
the C side of the kernel.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Reviewed-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
---
v1 -> v2: Unmodified

 rust/kernel/sync/arc.rs | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index ff73f9240ca1..519a6ec43644 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -15,7 +15,11 @@
 //!
 //! [`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
 
-use crate::{bindings, error::Result, types::Opaque};
+use crate::{
+    bindings,
+    error::Result,
+    types::{ForeignOwnable, Opaque},
+};
 use alloc::boxed::Box;
 use core::{
     marker::{PhantomData, Unsize},
@@ -189,6 +193,32 @@ impl<T: ?Sized> Arc<T> {
     }
 }
 
+impl<T: 'static> ForeignOwnable for Arc<T> {
+    type Borrowed<'a> = ArcBorrow<'a, T>;
+
+    fn into_foreign(self) -> *const core::ffi::c_void {
+        ManuallyDrop::new(self).ptr.as_ptr() as _
+    }
+
+    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
+        // SAFETY: By the safety requirement of this function, we know that `ptr` came from
+        // a previous call to `Arc::into_foreign`.
+        let inner = NonNull::new(ptr as *mut ArcInner<T>).unwrap();
+
+        // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
+        // for the lifetime of the returned value. Additionally, the safety requirements of
+        // `ForeignOwnable::borrow_mut` ensure that no new mutable references are created.
+        unsafe { ArcBorrow::new(inner) }
+    }
+
+    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
+        // SAFETY: By the safety requirement of this function, we know that `ptr` came from
+        // a previous call to `Arc::into_foreign`, which owned guarantees that `ptr` is valid and
+        // owns a reference.
+        unsafe { Self::from_inner(NonNull::new(ptr as _).unwrap()) }
+    }
+}
+
 impl<T: ?Sized> Deref for Arc<T> {
     type Target = T;
 
-- 
2.34.1

