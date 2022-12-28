Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CDE65730C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 07:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbiL1GFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 01:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiL1GEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 01:04:43 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054C7DF5E;
        Tue, 27 Dec 2022 22:04:42 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t15so5238847wro.9;
        Tue, 27 Dec 2022 22:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nyqdaq2S7tC0O5h+EPr9voswYlNOiiQ62YOgK8u+XEY=;
        b=PkjOU0OwjgOja8a24OYSeB2xiCXsUcXR2DuCf4HwLICZZ6x5sUmJcWD+n6ZDvBAkTG
         Q+yDtygd9skAsH7t4D3HxYgI4yhnyQ4mSJt1uW+qYKr5q7Jka2QoKZll1mkxK5Ug149F
         fO1lUz8ciMe3jG1z4R/He3IGT7X3d09qLVq8L5fdAc+sQv1qBijTYeekmQUnBnE0KJ6y
         ZxPStzKKAtcEnK1FxUL6vlmqE8oH/vjbQ/iiV0qSrloeoFwlXy3KIVD5QWoGxMAmG4OW
         y+g3SztzbfqSiPuTK8NIqTg6b99rR+6POIH9XoXMkEZ0Bwj5wbv5fnr8W/bbql43LwpJ
         +Rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nyqdaq2S7tC0O5h+EPr9voswYlNOiiQ62YOgK8u+XEY=;
        b=onRpjMBBF4HRqEBlmSaNibzSz7COsuAPjn+8KM/7duv2V2aavRDQECpwzr6uPAzMNQ
         m3OZyoq7nycNz/UiFdYeowxLhvfSb1Wd8qqdhCXPKmKqjFzf685KfVbFIqgyPDRM6utX
         R4pHfEZn0GPaB8grdVV5/uPklAjPU10qmJj9XCW22Y4liAdHprwfqCuWwmwoSgdURuCB
         FlII50Eo2L3nOHTDdygMz8S7rkIq2yAd5+cV2tc7zmpOq3cb9IdzSy4j3HdqJgq65OAA
         oz7heN+OuIBa4utdlA5mkR83P3ezlnJkM0f5tfqOGjUUbdYtyRYae/oHglQfZID29nXu
         4L9Q==
X-Gm-Message-State: AFqh2kqRX257t2wXcArj2++vzM0+giWLTY7WdBn7Yvbfd+iJdT/eBr7a
        ItkRxr2I9glTjWUeo2iDBku8dZ86FpwEHA==
X-Google-Smtp-Source: AMrXdXtABS84gYIHH8ZbQgM2Qkg/NFqNPcb7MvyGsw2gQ7IA78r1Q7d4bmXrzMTCPQ5cGDlq2oHQZA==
X-Received: by 2002:a5d:494d:0:b0:268:5557:98c9 with SMTP id r13-20020a5d494d000000b00268555798c9mr14607418wrs.58.1672207480519;
        Tue, 27 Dec 2022 22:04:40 -0800 (PST)
Received: from wedsonaf-dev.. ([81.2.152.129])
        by smtp.googlemail.com with ESMTPSA id x16-20020a5d6510000000b002755e301eeasm12128867wru.100.2022.12.27.22.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 22:04:40 -0800 (PST)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: [PATCH 7/7] rust: sync: add support for dispatching on Arc and ArcBorrow.
Date:   Wed, 28 Dec 2022 06:03:46 +0000
Message-Id: <20221228060346.352362-7-wedsonaf@gmail.com>
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

Trait objects (`dyn T`) require trait `T` to be "object safe". One of
the requirements for "object safety" is that the receiver have one of
the allowed types. This commit adds `Arc<T>` and `ArcBorrow<'_, T>` to
the list of allowed types.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
---
 rust/kernel/lib.rs      |  1 +
 rust/kernel/sync/arc.rs | 20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 4bde65e7b06b..e0b0e953907d 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -15,6 +15,7 @@
 #![feature(allocator_api)]
 #![feature(coerce_unsized)]
 #![feature(core_ffi_c)]
+#![feature(dispatch_from_dyn)]
 #![feature(receiver_trait)]
 #![feature(unsize)]
 
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 832bafc74a90..ff73f9240ca1 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -92,9 +92,15 @@ use core::{
 /// Coercion from `Arc<Example>` to `Arc<dyn MyTrait>`:
 ///
 /// ```
-/// use kernel::sync::Arc;
+/// use kernel::sync::{Arc, ArcBorrow};
+///
+/// trait MyTrait {
+///     // Trait has a function whose `self` type is `Arc<Self>`.
+///     fn example1(self: Arc<Self>) {}
 ///
-/// trait MyTrait {}
+///     // Trait has a function whose `self` type is `ArcBorrow<'_, Self>`.
+///     fn example2(self: ArcBorrow<'_, Self>) {}
+/// }
 ///
 /// struct Example;
 /// impl MyTrait for Example {}
@@ -123,6 +129,9 @@ impl<T: ?Sized> core::ops::Receiver for Arc<T> {}
 // dynamically-sized type (DST) `U`.
 impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::CoerceUnsized<Arc<U>> for Arc<T> {}
 
+// This is to allow `Arc<U>` to be dispatched on when `Arc<T>` can be coerced into `Arc<U>`.
+impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::DispatchFromDyn<Arc<U>> for Arc<T> {}
+
 // SAFETY: It is safe to send `Arc<T>` to another thread when the underlying `T` is `Sync` because
 // it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
 // `T` to be `Send` because any thread that has an `Arc<T>` may ultimately access `T` directly, for
@@ -297,6 +306,13 @@ pub struct ArcBorrow<'a, T: ?Sized + 'a> {
 // This is to allow [`ArcBorrow`] (and variants) to be used as the type of `self`.
 impl<T: ?Sized> core::ops::Receiver for ArcBorrow<'_, T> {}
 
+// This is to allow `ArcBorrow<U>` to be dispatched on when `ArcBorrow<T>` can be coerced into
+// `ArcBorrow<U>`.
+impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::DispatchFromDyn<ArcBorrow<'_, U>>
+    for ArcBorrow<'_, T>
+{
+}
+
 impl<T: ?Sized> Clone for ArcBorrow<'_, T> {
     fn clone(&self) -> Self {
         *self
-- 
2.34.1

