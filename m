Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F8B65730A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 07:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiL1GFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 01:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiL1GEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 01:04:41 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E31BDEFD;
        Tue, 27 Dec 2022 22:04:40 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id y16so14086160wrm.2;
        Tue, 27 Dec 2022 22:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeNZhBrSDUYQju7RRVfm5I6e0SpSr4tjimgdJCI7t2s=;
        b=hBpEZlcwkbj1rwV3hPjKwJmJHcE/5WKwhuxtTDMKYQKe2CImcnt3QdOTvLb7G7vEY4
         cqAMRxB0qP5ptsaD8CH/fdev6J9lAFCvaVf+rkbnKb7QQSMFbGhBoXvof6zYHSe8i9j4
         Ej6C+CnpjBTVmgO+yLnO1BwCIJEA/QrKu68BwcgCie7xHBAEqJBwibjX8YKWNOXLHgQq
         BxLIxnbEoBGpzK3vookEkJwtNUMwU5XAXlF131X5LqUOo2qEQR4lZP6Pk4GkvuYwdSMg
         vkAuHPsze27Lso5+WNQEWsAtgOn9PrShtaONkq/3X8N+O1r4VT03bbewoxFg7FTAnH0d
         ZNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XeNZhBrSDUYQju7RRVfm5I6e0SpSr4tjimgdJCI7t2s=;
        b=1ZevucE/i31PSMP2Z1j6C1qkrW3aXXg/zefLhH9fst0F2y42vPTbKWJMfappZ6aVrs
         oGYRp6NtOrC1+7bcIn93huTS8QKIdiYJqAdsW7faS8A6V3/GbhacuRirnrnexWMZg+l0
         zoYDOmrTv/9Ei5+awxblfaLOU/H9N4wPcl9nQv0GYweI2q87fHaOcw0roDWQVF5HPb+5
         +9ZVSQHYfX958JifpwIDUW8wobKKdvsWlGvqSC4CmJV9XNy/+/y5oIKBI2j4vrXvSWA3
         HkPd/DIi3BS5d+odnItntycyNzNTP+rPuvOFnC0GgzW2IL+FpcEartq8kllTBpFqa3Zi
         Kqqg==
X-Gm-Message-State: AFqh2ko9xXpHDVv8FqWJfD41v3d0DfKp0m75/vc0OdOXpWCa5M7UnQZJ
        OiqEP9NO6pxeK4xyue11Sfcw6rdujSaq7Q==
X-Google-Smtp-Source: AMrXdXsm8VgrnwKioOBCZlcAYaP3Cj8yXcd2dB/CUDd+urZQyGIOfh9/dReyyn9eTk8xRek7szTKbA==
X-Received: by 2002:adf:f206:0:b0:280:8ebd:263a with SMTP id p6-20020adff206000000b002808ebd263amr4491556wro.62.1672207478627;
        Tue, 27 Dec 2022 22:04:38 -0800 (PST)
Received: from wedsonaf-dev.. ([81.2.152.129])
        by smtp.googlemail.com with ESMTPSA id x16-20020a5d6510000000b002755e301eeasm12128867wru.100.2022.12.27.22.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 22:04:38 -0800 (PST)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: [PATCH 5/7] rust: sync: allow type of `self` to be `ArcBorrow<T>`
Date:   Wed, 28 Dec 2022 06:03:44 +0000
Message-Id: <20221228060346.352362-5-wedsonaf@gmail.com>
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

This allows associated functions whose `self` argument has
`ArcBorrow<T>` as their type. This, in turn, allows callers to use the
dot syntax to make calls.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
---
 rust/kernel/sync/arc.rs | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index f68bfc02c81a..84f31c85a513 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -255,11 +255,34 @@ impl<T: ?Sized> Drop for Arc<T> {
 /// // Assert that both `obj` and `cloned` point to the same underlying object.
 /// assert!(core::ptr::eq(&*obj, &*cloned));
 /// ```
+///
+/// Using `ArcBorrow<T>` as the type of `self`:
+///
+/// ```
+/// use crate::sync::{Arc, ArcBorrow};
+///
+/// struct Example {
+///     a: u32,
+///     b: u32,
+/// }
+///
+/// impl Example {
+///     fn use_reference(self: ArcBorrow<'_, Self>) {
+///         // ...
+///     }
+/// }
+///
+/// let obj = Arc::try_new(Example { a: 10, b: 20 })?;
+/// obj.as_arc_borrow().use_reference();
+/// ```
 pub struct ArcBorrow<'a, T: ?Sized + 'a> {
     inner: NonNull<ArcInner<T>>,
     _p: PhantomData<&'a ()>,
 }
 
+// This is to allow [`ArcBorrow`] (and variants) to be used as the type of `self`.
+impl<T: ?Sized> core::ops::Receiver for ArcBorrow<'_, T> {}
+
 impl<T: ?Sized> Clone for ArcBorrow<'_, T> {
     fn clone(&self) -> Self {
         *self
-- 
2.34.1

