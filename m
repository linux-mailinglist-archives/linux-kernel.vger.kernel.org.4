Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D256A170F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 08:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjBXH0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 02:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBXH0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 02:26:35 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722301EBDF;
        Thu, 23 Feb 2023 23:26:34 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6B55D424B9;
        Fri, 24 Feb 2023 07:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677223593;
        bh=znEXimllrWJvfY/ohmIs0JciCK61gw0J+CRFrn2gudU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=KJoHBpU9113mO+mdOiaJNn+0HklOkWluH51fJFbKl8NYFDEBkIICjJyoRhOLobouU
         QzH3np0L6dmJO+aRIahBLIEY3Iby8a9Hzx1zmLHjELLA9UPfIIAYhX+HS+Sty9fe12
         EjEwDHNE2btQIyFRnNHPbOb89uShMQmcL8qVqLsTSJMr0JV9CRux2yS2EBram+jfRw
         AiFlXtJs3LjNKhuzNRk2X1Qbx6ddH4ZJ/wM1cRlUV5eRq1H9GHSnXEwQaiTU/9hVCL
         KQozTR6J4ZTU7R9qa3fDLZVf7JR28dXlz7XpAAG9//vGTtCJwiaQX1W8sbrDKdlaVG
         7OIvQV1aXpFQg==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 24 Feb 2023 16:25:55 +0900
Subject: [PATCH 1/3] rust: macros: Make expect_punct() return the Punct
 directly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-macros-v1-1-b39fae46e102@asahilina.net>
References: <20230224-rust-macros-v1-0-b39fae46e102@asahilina.net>
In-Reply-To: <20230224-rust-macros-v1-0-b39fae46e102@asahilina.net>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677223586; l=2668;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=znEXimllrWJvfY/ohmIs0JciCK61gw0J+CRFrn2gudU=;
 b=H/oQs1/Pt+6iQus1S0oDMkRIMRYO/sCD2ik5qRDSJzQ3aWOjUiTjg2D+qmrDeb1VTO+yDB6ZI
 XGJ6yp2aYR9Aik6WMEy5SEeA1CISZ8nNhb01BFVy76fEoq2IxnOFK4l
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=Qn8jZuOtR1m5GaiDfTrAoQ4NE1XoYVZ/wmt5YtXWFC4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it mirror the way expect_ident() works, and means we can more
easily push the result back into the token stream.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/macros/concat_idents.rs | 2 +-
 rust/macros/helpers.rs       | 6 +++---
 rust/macros/module.rs        | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/rust/macros/concat_idents.rs b/rust/macros/concat_idents.rs
index 7e4b450f3a50..6d955d65016e 100644
--- a/rust/macros/concat_idents.rs
+++ b/rust/macros/concat_idents.rs
@@ -15,7 +15,7 @@ fn expect_ident(it: &mut token_stream::IntoIter) -> Ident {
 pub(crate) fn concat_idents(ts: TokenStream) -> TokenStream {
     let mut it = ts.into_iter();
     let a = expect_ident(&mut it);
-    assert_eq!(expect_punct(&mut it), ',');
+    assert_eq!(expect_punct(&mut it).as_char(), ',');
     let b = expect_ident(&mut it);
     assert!(it.next().is_none(), "only two idents can be concatenated");
     let res = Ident::new(&format!("{a}{b}"), b.span());
diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
index cf7ad950dc1e..65706ecc007e 100644
--- a/rust/macros/helpers.rs
+++ b/rust/macros/helpers.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use proc_macro::{token_stream, TokenTree};
+use proc_macro::{token_stream, Punct, TokenTree};
 
 pub(crate) fn try_ident(it: &mut token_stream::IntoIter) -> Option<String> {
     if let Some(TokenTree::Ident(ident)) = it.next() {
@@ -38,9 +38,9 @@ pub(crate) fn expect_ident(it: &mut token_stream::IntoIter) -> String {
     try_ident(it).expect("Expected Ident")
 }
 
-pub(crate) fn expect_punct(it: &mut token_stream::IntoIter) -> char {
+pub(crate) fn expect_punct(it: &mut token_stream::IntoIter) -> Punct {
     if let TokenTree::Punct(punct) = it.next().expect("Reached end of token stream for Punct") {
-        punct.as_char()
+        punct
     } else {
         panic!("Expected Punct");
     }
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index a7e363c2b044..07503b242d2d 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -104,7 +104,7 @@ impl ModuleInfo {
                 );
             }
 
-            assert_eq!(expect_punct(it), ':');
+            assert_eq!(expect_punct(it).as_char(), ':');
 
             match key.as_str() {
                 "type" => info.type_ = expect_ident(it),
@@ -119,7 +119,7 @@ impl ModuleInfo {
                 ),
             }
 
-            assert_eq!(expect_punct(it), ',');
+            assert_eq!(expect_punct(it).as_char(), ',');
 
             seen_keys.push(key);
         }

-- 
2.35.1

