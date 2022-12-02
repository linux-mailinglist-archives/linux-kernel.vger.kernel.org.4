Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E9E640A63
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbiLBQQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbiLBQQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:16:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF46BF67C;
        Fri,  2 Dec 2022 08:15:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E7EF62331;
        Fri,  2 Dec 2022 16:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB730C433D7;
        Fri,  2 Dec 2022 16:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669997752;
        bh=3ozUOhrx52YHTps33arj4MB6UyVgxyGlHJRWzGu7eJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XrlQLClCl6lfpp1Axk7H9bFmwhtWQUtAGk45+2MVLgUfucuVL18toqPILDZqakMEa
         q4xgxTxkPKcVEnR0ei12ZpVF5v/5KQJN95pGG057rOFV8OHNC0F1sCPQYCUL7Gm2aC
         wKGHcsNz8rLyKzXdBcbB4tfsWHLI1dZ+DsoEJA8Uw9htPCOgbyRp3UmA90bFBysBvU
         06Fuw2TDtnG1pWBBPQkchyWi6t9Mkz6GNIVDFQs4S90BBbDjn3cPwJktAlOd/3AcOZ
         G/J0pvRKUlBjyAtKsYF/bPGO74BvwLz1phTne5YnvFDUZ4jhXZ/mMbf683kZjvaJlN
         emn0duyZHTbug==
From:   ojeda@kernel.org
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Finn Behrens <me@kloenk.dev>
Subject: [PATCH v2 08/28] rust: error: declare errors using macro
Date:   Fri,  2 Dec 2022 17:14:39 +0100
Message-Id: <20221202161502.385525-9-ojeda@kernel.org>
In-Reply-To: <20221202161502.385525-1-ojeda@kernel.org>
References: <20221202161502.385525-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Behrens <me@kloenk.dev>

Add a macro to declare errors, which simplifies the work needed to
add each one, avoids repetition of the code and makes it easier to
change the way they are declared.

Signed-off-by: Finn Behrens <me@kloenk.dev>
Reviewed-by: Gary Guo <gary@garyguo.net>
[Reworded, adapted for upstream and applied latest changes]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/error.rs | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 466b2a8fe569..b843f3445483 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -8,8 +8,16 @@ use alloc::collections::TryReserveError;
 
 /// Contains the C-compatible error codes.
 pub mod code {
-    /// Out of memory.
-    pub const ENOMEM: super::Error = super::Error(-(crate::bindings::ENOMEM as i32));
+    macro_rules! declare_err {
+        ($err:tt $(,)? $($doc:expr),+) => {
+            $(
+            #[doc = $doc]
+            )*
+            pub const $err: super::Error = super::Error(-(crate::bindings::$err as i32));
+        };
+    }
+
+    declare_err!(ENOMEM, "Out of memory.");
 }
 
 /// Generic integer kernel error.
-- 
2.38.1

