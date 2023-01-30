Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487AC680622
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 07:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbjA3Goq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 01:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbjA3Gok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:44:40 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11E71556F;
        Sun, 29 Jan 2023 22:44:36 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id p133so9243767oig.8;
        Sun, 29 Jan 2023 22:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWJyUEkZEQaGfIphT2kEHbYhQK8gjFMeU5IeqaqkaN8=;
        b=I5vCrxtE7OddIrmBOvuhwg/Vyh7yMyA0GCYe32UT8twm4O6URjG0kOMGqPjcQfRbl6
         lyIjY8Hyzvcl+SigwcHOqgQ1ZW25KJg/J2VgJ4tRcU+oO/m7ce7GokbIw+64d4QaAItf
         AtM35hI8QevoZ4PmD9dFyb6s/VfgFKborWlJKaT4ihLADxiDmsjlA/rhVNkn6H3m/5HX
         gfTeB3LlOof60rNB0mQ/b0hfKxVMLXlomHU9WWCbI8XwDkNf8Sz0cSLNIaKw02KfIy1v
         tLBtYSlpwKeoTIQqo6dx/S754EMc/6oxHcbcWk5WEP2TFmbg734XUPyScvG4l/iXYOil
         vRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWJyUEkZEQaGfIphT2kEHbYhQK8gjFMeU5IeqaqkaN8=;
        b=v6vwTMr46srDj0vZH/QBBbPwi5kEO0C+NslSTCbOxsxJuX/+0pr6QwvzOgVBDhGVpC
         lWzrHHu+nKi0p7Elov2zLTDP3Rjej9Eg4ETDdR+K/idRoB5XC5T+PEA4npRPsiA2FHJc
         74bgpfh8RsGhsq/oira7wEV/2yL+l43cspMx5LCZVouJuyNZjWyL4MgB8KCjr/VMkdUr
         L1W8/vOwUh329kPvmXRuQ5mDZ2iUUb+9E3h/4rxK5p09/mqpscenK0l643tN1weYa9l8
         OxpxtYmefgHwveT7OY5HrlKuL752g8SkD9bWe8WO1f9sNVlwEPBQZ3YkSj5jDHMIEruX
         Sr/w==
X-Gm-Message-State: AO0yUKWFMwOHoyqadkfa/rPc8p6+akBBBu7uk0Is9g7XRQoU+3Jdq+oK
        xCumgxr8Ndsw2vsLzQ438VbJNisL8ukngi2U
X-Google-Smtp-Source: AK7set+S49X9qmcRPNOHN71v5DjdJ1CN4QXKGZOfcPvV7KHkMnylH/Wh96Oupvd9Ex9N43g4iH9BlQ==
X-Received: by 2002:a05:6808:b25:b0:378:1ae6:86b7 with SMTP id t5-20020a0568080b2500b003781ae686b7mr2661128oij.35.1675061076234;
        Sun, 29 Jan 2023 22:44:36 -0800 (PST)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id o64-20020aca5a43000000b003670342726fsm4427883oib.12.2023.01.29.22.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 22:44:36 -0800 (PST)
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
Subject: [PATCH v2 3/5] rust: types: implement `ForeignOwnable` for `Box<T>`
Date:   Mon, 30 Jan 2023 03:44:02 -0300
Message-Id: <20230130064404.744600-3-wedsonaf@gmail.com>
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

This allows us to hand ownership of Rust dynamically allocated
objects to the C side of the kernel.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Reviewed-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
---
v1 -> v2: Add `use alloc::boxed::Box`, which wasn't needed before

 rust/kernel/types.rs | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 72710b7442a3..411655eca3e9 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -2,6 +2,7 @@
 
 //! Kernel types.
 
+use alloc::boxed::Box;
 use core::{
     cell::UnsafeCell,
     mem::MaybeUninit,
@@ -62,6 +63,28 @@ pub trait ForeignOwnable: Sized {
     unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self;
 }
 
+impl<T: 'static> ForeignOwnable for Box<T> {
+    type Borrowed<'a> = &'a T;
+
+    fn into_foreign(self) -> *const core::ffi::c_void {
+        Box::into_raw(self) as _
+    }
+
+    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
+        // SAFETY: The safety requirements for this function ensure that the object is still alive,
+        // so it is safe to dereference the raw pointer.
+        // The safety requirements of `from_foreign` also ensure that the object remains alive for
+        // the lifetime of the returned value.
+        unsafe { &*ptr.cast() }
+    }
+
+    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
+        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
+        // call to `Self::into_foreign`.
+        unsafe { Box::from_raw(ptr as _) }
+    }
+}
+
 /// Runs a cleanup function/closure when dropped.
 ///
 /// The [`ScopeGuard::dismiss`] function prevents the cleanup function from running.
-- 
2.34.1

