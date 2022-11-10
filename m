Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DA8624748
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbiKJQnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbiKJQm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:42:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97387450A0;
        Thu, 10 Nov 2022 08:42:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FE5161BCD;
        Thu, 10 Nov 2022 16:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC79C433D7;
        Thu, 10 Nov 2022 16:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668098562;
        bh=6C+J3CqClsIGimlHszB691qkxwmrQJQgf22GuHYX/4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G1+TkYS81fI6KSg3uG+BjrvTTqwlFukFJRj2LwmIc/PY+4bu15wKIHNVRoMKmd2w3
         fOILmAK9tfxfkhrj1mZCLHN67XlwCgHTuFOTQtgog4E1l1DZijE51REMWOHUKX+AgU
         Cf6Cl+PmHmrNUfwGYynRW6v35tV6JQ8m47tEE1noO0kLk3P4GpQDeLriy/uMxv8jCZ
         8EH6wHcR5p2rdvqVYomwjKh4SreNFMlss2KEl0EdqsrU1t90p8SuY3Kuet8yilSJ6s
         /Amoxx4CaUbgEQ5q6nVtIIkC6vyTWt/zaw3fEq7ZGmCqORj1UXaSXE+1FYnYfbnWw5
         lXJ435A+AMdog==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Finn Behrens <me@kloenk.dev>
Subject: [PATCH v1 08/28] rust: error: declare errors using macro
Date:   Thu, 10 Nov 2022 17:41:20 +0100
Message-Id: <20221110164152.26136-9-ojeda@kernel.org>
In-Reply-To: <20221110164152.26136-1-ojeda@kernel.org>
References: <20221110164152.26136-1-ojeda@kernel.org>
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

