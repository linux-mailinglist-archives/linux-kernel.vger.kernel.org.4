Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B063A640A60
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiLBQQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbiLBQPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:15:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB1CD96A9;
        Fri,  2 Dec 2022 08:15:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBBF1B821E8;
        Fri,  2 Dec 2022 16:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3E4C433C1;
        Fri,  2 Dec 2022 16:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669997743;
        bh=dtOQU49yR7LQiDxvwc6HHhk83pUumrESygYwXplYSi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dgXNifwtz8f9FEDXONTfj3cn2QJYnm8teZte4lQpJxMPea8wUtXyATIgmMeKzTcc5
         YrYJkdjvYKOSt+76f5eHIO1KRmO/Q5YLnq3bNhL4V1oRk3vebFIXrkYseYbKXSQhc/
         QkLxtKZLmMnoq7K0UXyxEITHuUHw/Yyf0lpXKPYSvs8Pn71MKjqfd+6kE4l/dRTaIG
         xIL++tc8A2qgNGZ4SPkuxeE2MHXsVLvV4fV8/AsVb8wWxVXNd2EFu4+MKoDz0ncjtK
         zu+T16cjFD/nu2Jh7uD6HM4JGWLVgpvf5ae3S1TVPsbRhaMqlKGdu7ijHIwhVNePcz
         3qdx+Dx684TjA==
From:   ojeda@kernel.org
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Finn Behrens <me@kloenk.dev>
Subject: [PATCH v2 05/28] rust: macros: add `concat_idents!` proc macro
Date:   Fri,  2 Dec 2022 17:14:36 +0100
Message-Id: <20221202161502.385525-6-ojeda@kernel.org>
In-Reply-To: <20221202161502.385525-1-ojeda@kernel.org>
References: <20221202161502.385525-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Roy Baron <bjorn3_gh@protonmail.com>

This macro provides similar functionality to the unstable feature
`concat_idents` without having to rely on it.

For instance:

    let x_1 = 42;
    let x_2 = concat_idents!(x, _1);
    assert!(x_1 == x_2);

It has different behavior with respect to macro hygiene. Unlike
the unstable `concat_idents!` macro, it allows, for example,
referring to local variables by taking the span of the second
macro as span for the output identifier.

Signed-off-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
Reviewed-by: Finn Behrens <me@kloenk.dev>
[Reworded, adapted for upstream and applied latest changes]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/macros/concat_idents.rs | 23 +++++++++++++++++++
 rust/macros/lib.rs           | 44 ++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 rust/macros/concat_idents.rs

diff --git a/rust/macros/concat_idents.rs b/rust/macros/concat_idents.rs
new file mode 100644
index 000000000000..7e4b450f3a50
--- /dev/null
+++ b/rust/macros/concat_idents.rs
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use proc_macro::{token_stream, Ident, TokenStream, TokenTree};
+
+use crate::helpers::expect_punct;
+
+fn expect_ident(it: &mut token_stream::IntoIter) -> Ident {
+    if let Some(TokenTree::Ident(ident)) = it.next() {
+        ident
+    } else {
+        panic!("Expected Ident")
+    }
+}
+
+pub(crate) fn concat_idents(ts: TokenStream) -> TokenStream {
+    let mut it = ts.into_iter();
+    let a = expect_ident(&mut it);
+    assert_eq!(expect_punct(&mut it), ',');
+    let b = expect_ident(&mut it);
+    assert!(it.next().is_none(), "only two idents can be concatenated");
+    let res = Ident::new(&format!("{a}{b}"), b.span());
+    TokenStream::from_iter([TokenTree::Ident(res)])
+}
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 91764bfb1f89..15555e7ff487 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -2,6 +2,7 @@
 
 //! Crate for all kernel procedural macros.
 
+mod concat_idents;
 mod helpers;
 mod module;
 
@@ -70,3 +71,46 @@ use proc_macro::TokenStream;
 pub fn module(ts: TokenStream) -> TokenStream {
     module::module(ts)
 }
+
+/// Concatenate two identifiers.
+///
+/// This is useful in macros that need to declare or reference items with names
+/// starting with a fixed prefix and ending in a user specified name. The resulting
+/// identifier has the span of the second argument.
+///
+/// # Examples
+///
+/// ```ignore
+/// use kernel::macro::concat_idents;
+///
+/// macro_rules! pub_no_prefix {
+///     ($prefix:ident, $($newname:ident),+) => {
+///         $(pub(crate) const $newname: u32 = kernel::macros::concat_idents!($prefix, $newname);)+
+///     };
+/// }
+///
+/// pub_no_prefix!(
+///     binder_driver_return_protocol_,
+///     BR_OK,
+///     BR_ERROR,
+///     BR_TRANSACTION,
+///     BR_REPLY,
+///     BR_DEAD_REPLY,
+///     BR_TRANSACTION_COMPLETE,
+///     BR_INCREFS,
+///     BR_ACQUIRE,
+///     BR_RELEASE,
+///     BR_DECREFS,
+///     BR_NOOP,
+///     BR_SPAWN_LOOPER,
+///     BR_DEAD_BINDER,
+///     BR_CLEAR_DEATH_NOTIFICATION_DONE,
+///     BR_FAILED_REPLY
+/// );
+///
+/// assert_eq!(BR_OK, binder_driver_return_protocol_BR_OK);
+/// ```
+#[proc_macro]
+pub fn concat_idents(ts: TokenStream) -> TokenStream {
+    concat_idents::concat_idents(ts)
+}
-- 
2.38.1

