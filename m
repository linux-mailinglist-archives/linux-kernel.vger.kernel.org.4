Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C568A6D86F7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjDETgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbjDETgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:36:37 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367BE7298
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 12:36:14 -0700 (PDT)
Date:   Wed, 05 Apr 2023 19:35:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680723372; x=1680982572;
        bh=7rH6H6G+ATzJ5NdhnHFFoHIa5Qvd43Dus1uGWQ71zqY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=FZZCOcHOC/Mp6LipdJFIMGMkvtopwN7C0MWlZ5ngtjSzJMw3iU5v6hHzanI4lv+WZ
         KB31i4FgNkEUPEVLDoR1Nphk3mZkceC90kSPa0fNk+msZVIdUMa+KsRn9R1Jnieo+j
         DGk+DTaD8R9is8H/6s1+7685+2eOjggM9jUTNcdOm51x/LkFce5KBDK+bnBNOLd/gI
         iGEUb2SLFlfPj7/dx/nwGMNMfHydsB7TBIC4PZtfBZG9hcPq8uTvm2dpereR5Tfxxa
         lEjzVvHKsATfYukEToMxjMB/cgg2cfFHPe6rVkjVaUXmPeO5ASSAiKN3QLj9DSgcnM
         vA+hVVoOmm+0A==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, Andreas Hindborg <nmi@metaspace.dk>
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Benno Lossin <y86-dev@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>
Subject: [PATCH v6 05/15] rust: types: add `Opaque::raw_get`
Message-ID: <20230405193445.745024-6-y86-dev@protonmail.com>
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

This function mirrors `UnsafeCell::raw_get`. It avoids creating a
reference and allows solely using raw pointers.
The `pin-init` API will be using this, since uninitialized memory
requires raw pointers.

Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/types.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 9d0fdbc55843..ff2b2fac951d 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -238,6 +238,14 @@ impl<T> Opaque<T> {
     pub fn get(&self) -> *mut T {
         UnsafeCell::raw_get(self.0.as_ptr())
     }
+
+    /// Gets the value behind `this`.
+    ///
+    /// This function is useful to get access to the value without creatin=
g intermediate
+    /// references.
+    pub const fn raw_get(this: *const Self) -> *mut T {
+        UnsafeCell::raw_get(this.cast::<UnsafeCell<T>>())
+    }
 }

 /// A sum type that always holds either a value of type `L` or `R`.
--
2.39.2


