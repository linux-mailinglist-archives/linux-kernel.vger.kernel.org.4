Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549EC6D8706
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjDETi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbjDETiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:38:15 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73DF7DB0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 12:37:44 -0700 (PDT)
Date:   Wed, 05 Apr 2023 19:36:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680723429; x=1680982629;
        bh=S5ndiOTk444R587cz6eQKsLf+C57xcupLszBquLvesM=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=XjtAfMfEFar0bfYi2prsjdoGPaslwrXi0qgDfn7bUnCxLHi96I22hFVxcZxD6a5nj
         ECWMccW60rBuYaRf394obLRxMwkEG6Ct9WKp6+VPlzKB/NUWLgB3DU/pvAblffnj7G
         kSrMeClDp/hbBB68bJlbiIP7VqkSqC9+TS9dkXtZQzEu640wPZeYI1cMp24w0pApjL
         ZcTcOG0Ug1I3b0zi3YlzxeWzQR4ZGKOUhJKmCYpGpRePOe7s7zj8auBUOMstj1e3QU
         C0F3hyhNVlPPE5aWhIzFr/KMeigk/cL92qOdGFWBSXl6D6E4sMIpVxCN4v01F19U3w
         8lDna6LXWeTrg==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, Andreas Hindborg <nmi@metaspace.dk>
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Benno Lossin <y86-dev@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: [PATCH v6 15/15] rust: sync: add functions for initializing `UniqueArc<MaybeUninit<T>>`
Message-ID: <20230405193445.745024-16-y86-dev@protonmail.com>
In-Reply-To: <20230405193445.745024-1-y86-dev@protonmail.com>
References: <20230405193445.745024-1-y86-dev@protonmail.com>
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

Add two functions `init_with` and `pin_init_with` to
`UniqueArc<MaybeUninit<T>>` to initialize the memory of already allocated
`UniqueArc`s. This is useful when you want to allocate memory check some
condition inside of a context where allocation is forbidden and then
conditionally initialize an object.

Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 rust/kernel/sync/arc.rs | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index d05caa723718..d1a79cce5e54 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -541,6 +541,30 @@ impl<T> UniqueArc<MaybeUninit<T>> {
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


