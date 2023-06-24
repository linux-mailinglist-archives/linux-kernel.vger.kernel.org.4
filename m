Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5963873CA14
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 11:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjFXJZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 05:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjFXJZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 05:25:40 -0400
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEDB1FF0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 02:25:28 -0700 (PDT)
Date:   Sat, 24 Jun 2023 09:25:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=xkiqz2ubxjcrjarzt6h2fs2eda.protonmail; t=1687598726; x=1687857926;
        bh=MwlsAZeth2fh5s/kKCjOwcaQoR9NfdiNJqcnIsJP+QU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=RX1QAFc2D7lJnNB8YIGMjffGX2FEKkrq6fmEfZflSEwkkwMLXzhsXN8ZLqMJFL9oW
         eaHYEK9ECgnIrEKj2hNjevL6+hEB1EsPWMmOxWnQQQE6XF/MEg/tpFrFaAMHfdB3ST
         YJhWTH9QJVe7q8dh8ykOd37SmZ6Za20e/jR7O8ztupEyl9TvSTMWqWr5+w7pB4Rd4h
         8shd5T+lOMdD3IVD+VzW+zQ18TluwVoBqC8G9mZq4EtC2pMhy6AueT+OcOFRd04TW9
         fpMkLLW3wmqrHR0wVHlpFOxMqX0pnYLjz0S0aR4lf7FsUsMOFju/QgLG68H3psY5b6
         MVGAuvLNTqwuw==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH 4/7] rust: init: wrap type checking struct initializers in a closure
Message-ID: <20230624092330.157338-4-benno.lossin@proton.me>
In-Reply-To: <20230624092330.157338-1-benno.lossin@proton.me>
References: <20230624092330.157338-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of the init macros there is a `if false` statement
that type checks the initializer to ensure every field is initialized.
Since the next patch has a stack variable to store the struct, the
function might allocate too much memory on debug builds. Putting the
struct into a closure ensures that even in debug builds no stack
overflow error is caused. In release builds this was not a problem since
the code was optimized away due to the `if false`.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/init/macros.rs | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index df4281743175..1e0c4aca055a 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -1037,14 +1037,18 @@ macro_rules! __init_internal {
                     // We use unreachable code to ensure that all fields h=
ave been mentioned exactly
                     // once, this struct initializer will still be type-ch=
ecked and complain with a
                     // very natural error message if a field is forgotten/=
mentioned more than once.
-                    #[allow(unreachable_code, clippy::diverging_sub_expres=
sion)]
+                    #[allow(unreachable_code,
+                            clippy::diverging_sub_expression,
+                            clippy::redundant_closure_call)]
                     if false {
-                        $crate::__init_internal!(make_initializer:
-                            @slot(slot),
-                            @type_name($t),
-                            @munch_fields($($fields)*,),
-                            @acc(),
-                        );
+                        (|| {
+                            $crate::__init_internal!(make_initializer:
+                                @slot(slot),
+                                @type_name($t),
+                                @munch_fields($($fields)*,),
+                                @acc(),
+                            );
+                        })();
                     }
                 }
                 Ok(__InitOk)
--
2.41.0


