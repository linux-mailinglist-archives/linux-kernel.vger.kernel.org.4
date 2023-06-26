Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEAD73D8B5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 09:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjFZHnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 03:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjFZHm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 03:42:58 -0400
Received: from out0-222.mail.aliyun.com (out0-222.mail.aliyun.com [140.205.0.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06771AC;
        Mon, 26 Jun 2023 00:42:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047205;MF=changxian.cqs@antgroup.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---.Te0ogGy_1687765369;
Received: from localhost(mailfrom:changxian.cqs@antgroup.com fp:SMTPD_---.Te0ogGy_1687765369)
          by smtp.aliyun-inc.com;
          Mon, 26 Jun 2023 15:42:49 +0800
From:   "Qingsong Chen" <changxian.cqs@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "=?UTF-8?B?55Sw5rSq5Lqu?=" <tate.thl@antgroup.com>,
        "Qingsong Chen" <changxian.cqs@antgroup.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        "Benno Lossin" <benno.lossin@proton.me>,
        "=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?=" 
        <sergio.collado@gmail.com>, <rust-for-linux@vger.kernel.org>
Subject: [PATCH 1/1] rust: macros: fix redefine const_name in `vtable`
Date:   Mon, 26 Jun 2023 15:42:42 +0800
Message-Id: <20230626074242.3945398-2-changxian.cqs@antgroup.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230626074242.3945398-1-changxian.cqs@antgroup.com>
References: <20230626074242.3945398-1-changxian.cqs@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the trait has same function name, the `vtable` macro
will redefine its `gen_const_name`, e.g.:
```rust
    #[vtable]
    pub trait Foo {
        #[cfg(CONFIG_X)]
        fn bar();

        #[cfg(not(CONFIG_X))]
        fn bar(x: usize);
    }
```
Use `HashSet` to avoid this.

Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
---
 rust/macros/vtable.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/macros/vtable.rs b/rust/macros/vtable.rs
index 34d5e7fb5768..08eb0355f99b 100644
--- a/rust/macros/vtable.rs
+++ b/rust/macros/vtable.rs
@@ -27,7 +27,7 @@ pub(crate) fn vtable(_attr: TokenStream, ts: TokenStream) -> TokenStream {
     };
 
     let mut body_it = body.stream().into_iter();
-    let mut functions = Vec::new();
+    let mut functions = HashSet::new();
     let mut consts = HashSet::new();
     while let Some(token) = body_it.next() {
         match token {
@@ -37,7 +37,7 @@ pub(crate) fn vtable(_attr: TokenStream, ts: TokenStream) -> TokenStream {
                     // Possibly we've encountered a fn pointer type instead.
                     _ => continue,
                 };
-                functions.push(fn_name);
+                functions.insert(fn_name);
             }
             TokenTree::Ident(ident) if ident.to_string() == "const" => {
                 let const_name = match body_it.next() {
-- 
2.40.1

