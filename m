Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE2E6A1710
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 08:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjBXH0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 02:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjBXH0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 02:26:38 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E725E878;
        Thu, 23 Feb 2023 23:26:37 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 89D5942627;
        Fri, 24 Feb 2023 07:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677223596;
        bh=i3HnPKPfmfqBLbRSmTJVD/vTe4oYMr0tLkjCkOowWxo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=mHLIUVdMDHCfaQJTwTd4ksLkgryWXo4VLHMXJtg6uviwjS5EWxgNNWlrSg1ErQ326
         DUT0sJbw9/KAETC9dAI+xVTcWc821z+l/0Itw4jPQ3EAsow+BvlpxX4MxmUVcSQ0hC
         Jbd7ERKwAlAsPZ4rat8nCUYk7vz9jsIcoBLbDaqux76T96/KICeEiRN09LcpJchb80
         atp4F4FtXCN1yeQSEKB4n2bC5tzNweKbQ2BMq6uGQaqQgqHLKtJhqp1x0HPqSAS5ST
         mJvGrztDEwGUmPrtEXITf/7GoixVky08rA+te6CgFLgU3f3rvcWDAo1oSQkEzVDqoU
         yyF38IDwV0NxQ==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 24 Feb 2023 16:25:56 +0900
Subject: [PATCH 2/3] rust: macros: concat_idents: Allow :: paths in the
 first argument
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-macros-v1-2-b39fae46e102@asahilina.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677223586; l=1727;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=i3HnPKPfmfqBLbRSmTJVD/vTe4oYMr0tLkjCkOowWxo=;
 b=DPiJmYbiFviJCZNTLudvSrFUdKkvqk1hC9plJ20sOU8vPA9fwNu18df1XX8QF2ceaXXwpg+Y7
 XS7veM7W473AkoL6twukc3WNjQq33aFILRpHVtIayz6H224BE84By1p
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

This makes things like concat_idents!(bindings::foo, bar) work.
Otherwise, there is no way to concatenate two idents and then use the
result as part of a type path.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/macros/concat_idents.rs | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/rust/macros/concat_idents.rs b/rust/macros/concat_idents.rs
index 6d955d65016e..d6614b900aa2 100644
--- a/rust/macros/concat_idents.rs
+++ b/rust/macros/concat_idents.rs
@@ -14,10 +14,28 @@ fn expect_ident(it: &mut token_stream::IntoIter) -> Ident {
 
 pub(crate) fn concat_idents(ts: TokenStream) -> TokenStream {
     let mut it = ts.into_iter();
-    let a = expect_ident(&mut it);
-    assert_eq!(expect_punct(&mut it).as_char(), ',');
+    let mut out = TokenStream::new();
+    let a = loop {
+        let ident = expect_ident(&mut it);
+        let punct = expect_punct(&mut it);
+        match punct.as_char() {
+            ',' => break ident,
+            ':' => {
+                let punct2 = expect_punct(&mut it);
+                assert_eq!(punct2.as_char(), ':');
+                out.extend([
+                    TokenTree::Ident(ident),
+                    TokenTree::Punct(punct),
+                    TokenTree::Punct(punct2),
+                ]);
+            }
+            _ => panic!("Expected , or ::"),
+        }
+    };
+
     let b = expect_ident(&mut it);
     assert!(it.next().is_none(), "only two idents can be concatenated");
     let res = Ident::new(&format!("{a}{b}"), b.span());
-    TokenStream::from_iter([TokenTree::Ident(res)])
+    out.extend([TokenTree::Ident(res)]);
+    out
 }

-- 
2.35.1

