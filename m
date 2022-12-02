Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E90640A7A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbiLBQTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbiLBQQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:16:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717BAE0753;
        Fri,  2 Dec 2022 08:16:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A54062333;
        Fri,  2 Dec 2022 16:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AAAC43470;
        Fri,  2 Dec 2022 16:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669997771;
        bh=Pqv7nrnSw/i2nkLoHhZe36xor+0aWZ+RAfK3x5lb5qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fky4ZsDJiU3etZhLmzF50RMo1Y6FOs5obZoZgvhHWPXb8facOP7VEFr4Vbq/zrBQR
         FE2/+nVF2wE3qw+KzUdijKQbNSLTznHojE3xp7hR++wAAwz9vAr4yosMQQKblualkO
         0MpAJMnouHyArC23yrUXCRkJoCzS6rUaD8nFEFSUe8gP86xCz/mzyIuKZ2oag3jX0N
         KlTyl1gSJ4ID2Nh/WND4JAuXxS+P3i6vfLBYEyHz1zU4NTLlHcB0RupT7yExgcgWQq
         P5SnUwok4tIbVVl/N+RiT853BgCTYF4NNyDUbxYC1hXpyy7VLaxj7/52MaQsuJfWui
         EICKYz3IfPfew==
From:   ojeda@kernel.org
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v2 15/28] rust: str: add `b_str!` macro
Date:   Fri,  2 Dec 2022 17:14:46 +0100
Message-Id: <20221202161502.385525-16-ojeda@kernel.org>
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

From: Gary Guo <gary@garyguo.net>

Add the `b_str!` macro, which creates a new `BStr` from
a string literal.

It is usable in const contexts, for instance:

    const X: &BStr = b_str!("Example");

Signed-off-by: Gary Guo <gary@garyguo.net>
[Reworded, adapted for upstream and applied latest changes]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/str.rs | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 3aa1a0cb9bf8..95eb757c619d 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -9,6 +9,27 @@ use core::fmt;
 /// `BStr` is simply an alias to `[u8]`, but has a more evident semantical meaning.
 pub type BStr = [u8];
 
+/// Creates a new [`BStr`] from a string literal.
+///
+/// `b_str!` converts the supplied string literal to byte string, so non-ASCII
+/// characters can be included.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::b_str;
+/// # use kernel::str::BStr;
+/// const MY_BSTR: &BStr = b_str!("My awesome BStr!");
+/// ```
+#[macro_export]
+macro_rules! b_str {
+    ($str:literal) => {{
+        const S: &'static str = $str;
+        const C: &'static $crate::str::BStr = S.as_bytes();
+        C
+    }};
+}
+
 /// Allows formatting of [`fmt::Arguments`] into a raw buffer.
 ///
 /// It does not fail if callers write past the end of the buffer so that they can calculate the
-- 
2.38.1

