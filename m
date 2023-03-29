Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809296CF671
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 00:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjC2Wex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 18:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjC2Wed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 18:34:33 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D69F6A41
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 15:34:01 -0700 (PDT)
Date:   Wed, 29 Mar 2023 22:33:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680129237; x=1680388437;
        bh=YF0KQdg01n5qzHolAR22LM31sPRu0U9EL2Fgy7BvhWY=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=K9Mcc2lgyAmLApQ1FKC5qh6AYqyIwn0z69T0ipfKpv9PzSGlJ6nZCEm9X8+lCGn+5
         ThpO2yyOmgEQmeLNXPSMIvWa0B7ZjDqiVcH6AK8Uvxjvo2hzHpzeL94RkO1dfQ5/oC
         M5teL0DzerQKN4/EXPZWJm9VyfhbrfSQjdfPBtoHWEw7Uv9+VRgxnbgMhONhPTuARe
         PKmjwAfroRqXsSzwqLMTr3sTESGEUwacs6jny3JlQkdgKR3IP9ifxXrRQoMj3xVpbW
         Tw/DVhXp51T0Kr41EfIK8addT277VjnnnH9JAFjFgfA7JAxdWD14CsB2P7edEUDRLJ
         vQ4MIN7biMu4w==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>
From:   y86-dev@protonmail.com
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v3 13/13] rust: sync: add functions for initializing `UniqueArc<MaybeUninit<T>>`
Message-ID: <20230329223239.138757-14-y86-dev@protonmail.com>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benno Lossin <y86-dev@protonmail.com>

Add two functions `init_with` and `pin_init_with` to
`UniqueArc<MaybeUninit<T>>` to initialize the memory of already allocated
`UniqueArc`s. This is useful when you want to allocate memory check some
condition inside of a context where allocation is forbidden and then
conditionally initialize an object.

Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
---
 rust/kernel/sync/arc.rs | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 4ed6329a5e5f..64b0e9d67025 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -540,6 +540,30 @@ impl<T> UniqueArc<MaybeUninit<T>> {
             inner: unsafe { Arc::from_inner(inner.cast()) },
         }
     }
+
+    /// Initialize `self` using the given initializer.
+    pub fn init_with<E>(mut self, init: impl Init<T, E>) -> core::result::=
Result<UniqueArc<T>, E> {
+        // SAFETY: The supplied pointer is valid for initialization.
+        match unsafe { init.__init(self.as_mut_ptr()) } {
+            // SAFETY: Initialization completed successfully.
+            Ok(()) =3D> Ok(unsafe { self.assume_init() }),
+            Err(err) =3D> Err(err),
+        }
+    }
+
+    /// Pin-initialize `self` using the given pin-initializer.
+    pub fn pin_init_with<E>(
+        mut self,
+        init: impl PinInit<T, E>,
+    ) -> core::result::Result<Pin<UniqueArc<T>>, E> {
+        // SAFETY: The supplied pointer is valid for initialization and we=
 will later pin the value
+        // to ensure it does not move.
+        match unsafe { init.__pinned_init(self.as_mut_ptr()) } {
+            // SAFETY: Initialization completed successfully.
+            Ok(()) =3D> Ok(unsafe { self.assume_init() }.into()),
+            Err(err) =3D> Err(err),
+        }
+    }
 }

 impl<T: ?Sized> From<UniqueArc<T>> for Pin<UniqueArc<T>> {
--
2.39.2


