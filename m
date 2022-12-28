Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B08B657307
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 07:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiL1GEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 01:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiL1GEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 01:04:39 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82481DF7A;
        Tue, 27 Dec 2022 22:04:38 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id o5so14090668wrm.1;
        Tue, 27 Dec 2022 22:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOo9rRH83QUmkvXUKyYf97kVoLlh2nALRLlTOM81350=;
        b=Fqd2ghAkIt63+p69JvueLL8sBn3T/lmXJ/spCefQKbXeohzqEKqM4253s03gDtQ3k2
         XDsudlLpPNshviV9YRRttUNpKxSYDumasa2fl7IoDbJ2SkTLyN/3MkRLBC2FlCIjYUWA
         fr7qu8YNKIRH0Bu6TDFU2T48Bo8rgUBWpQDvSAUhBAQMx9zIiMrC7liYap8mc3RuohUa
         PabVwkdWPozo3WKJKECyLOt6iAGQ1+MzBe2b5g3JQ3KRLdijDni1YNSAOPJ+Xp2otxUn
         ld8NfD5yUVKHAalq7VLI603sL+mNE2epnhLgeILZFBh8eAfj5mAJWcKCjfmiX/I7G3cL
         GtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOo9rRH83QUmkvXUKyYf97kVoLlh2nALRLlTOM81350=;
        b=H2DWKpokXOYGVXMvBfLBUlLvDDp0laCsNZ/R1VySsaf9sIuFRRvcNu2865DydeHMoy
         6m94hEvtyMGd0PG+BB9hE60fpwcDZmX6hUn8sZTk9iUkJhHhIQphH3TOYrtA7kG0yckZ
         1ok7kZvpAczGZzs4/WtI0eCdekrbAZIk5nX3kKCaZjFjxtQMEWeXQly4k3Ff2lXKeMbE
         M++Fg+wbGsxYhcaQ20bL1DkKa0fZdYIPkjbJ7pb/EnBVH9svYVLLACIjlK3KMic+pMUb
         G/voF7cfQvw9sJo1eaRin//EAyIJ2/AUxs9S/JZJPt5il1DMd4Y2KR2QUB9O60QIzw+h
         aBFw==
X-Gm-Message-State: AFqh2kokmtKl0ZuyqXjTT6SQouYpMHhPI+XDlJytTmSj1qySdN9TlmEp
        h2nI92ZWaJwhsLlkGuAOEr5nrdJK3oLxFg==
X-Google-Smtp-Source: AMrXdXv9Zi4SzSRgb8FoyJFms+0ZYGa3oyP1izjArnrERCHhkmAZAUy+IWuBPX34uEXDq8Zy5gjN/Q==
X-Received: by 2002:adf:e383:0:b0:255:300d:79c7 with SMTP id e3-20020adfe383000000b00255300d79c7mr15597738wrm.18.1672207476964;
        Tue, 27 Dec 2022 22:04:36 -0800 (PST)
Received: from wedsonaf-dev.. ([81.2.152.129])
        by smtp.googlemail.com with ESMTPSA id x16-20020a5d6510000000b002755e301eeasm12128867wru.100.2022.12.27.22.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 22:04:36 -0800 (PST)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: [PATCH 3/7] rust: sync: allow coercion from `Arc<T>` to `Arc<U>`
Date:   Wed, 28 Dec 2022 06:03:42 +0000
Message-Id: <20221228060346.352362-3-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221228060346.352362-1-wedsonaf@gmail.com>
References: <20221228060346.352362-1-wedsonaf@gmail.com>
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

The coercion is only allowed if `U` is a compatible dynamically-sized
type (DST). For example, if we have some type `X` that implements trait
`Y`, then this allows `Arc<X>` to be coerced into `Arc<dyn Y>`.

Suggested-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
---
 rust/kernel/lib.rs      |  2 ++
 rust/kernel/sync/arc.rs | 27 ++++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 1a10f7c0ddd9..4bde65e7b06b 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -13,8 +13,10 @@
 
 #![no_std]
 #![feature(allocator_api)]
+#![feature(coerce_unsized)]
 #![feature(core_ffi_c)]
 #![feature(receiver_trait)]
+#![feature(unsize)]
 
 // Ensure conditional compilation based on the kernel configuration works;
 // otherwise we may silently break things like initcall handling.
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index e2eb0e67d483..dbc7596cc3ce 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -17,7 +17,11 @@
 
 use crate::{bindings, error::Result, types::Opaque};
 use alloc::boxed::Box;
-use core::{marker::PhantomData, ops::Deref, ptr::NonNull};
+use core::{
+    marker::{PhantomData, Unsize},
+    ops::Deref,
+    ptr::NonNull,
+};
 
 /// A reference-counted pointer to an instance of `T`.
 ///
@@ -82,6 +86,23 @@ use core::{marker::PhantomData, ops::Deref, ptr::NonNull};
 /// obj.use_reference();
 /// obj.take_over();
 /// ```
+///
+/// Coercion from `Arc<Example>` to `Arc<dyn MyTrait>`:
+///
+/// ```
+/// use kernel::sync::Arc;
+///
+/// trait MyTrait {}
+///
+/// struct Example;
+/// impl MyTrait for Example {}
+///
+/// // `obj` has type `Arc<Example>`.
+/// let obj: Arc<Example> = Arc::try_new(Example)?;
+///
+/// // `coerced` has type `Arc<dyn MyTrait>`.
+/// let coerced: Arc<dyn MyTrait> = obj;
+/// ```
 pub struct Arc<T: ?Sized> {
     ptr: NonNull<ArcInner<T>>,
     _p: PhantomData<ArcInner<T>>,
@@ -96,6 +117,10 @@ struct ArcInner<T: ?Sized> {
 // This is to allow [`Arc`] (and variants) to be used as the type of `self`.
 impl<T: ?Sized> core::ops::Receiver for Arc<T> {}
 
+// This is to allow coercion from `Arc<T>` to `Arc<U>` if `T` can be converted to the
+// dynamically-sized type (DST) `U`.
+impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::CoerceUnsized<Arc<U>> for Arc<T> {}
+
 // SAFETY: It is safe to send `Arc<T>` to another thread when the underlying `T` is `Sync` because
 // it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
 // `T` to be `Send` because any thread that has an `Arc<T>` may ultimately access `T` directly, for
-- 
2.34.1

