Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE3F624756
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbiKJQoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbiKJQnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:43:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF8847312;
        Thu, 10 Nov 2022 08:43:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B44DB82251;
        Thu, 10 Nov 2022 16:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362CAC433D6;
        Thu, 10 Nov 2022 16:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668098595;
        bh=bTwV3nkr6jPDZcA7hO2dJXGMLx9sZQV043G74OSH4H0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CadoW2qBa6bNQMyp1nnAz/fKRxL9PT6Cjyz4lVonGscW0FXbELPIh151r/bpTZLX0
         RNBGpEae5EeDzpOjPC/lFxm/X6VPej6rwjFjK/TaJOCaNEXZ0jFlLbaFPm9LxgnORm
         uK6QlIAdByyC1uohiB+V3QQ/ch52eA5RRBBq4PHpLLDPVcrDgDVBcwBaod1F2V71v8
         b7i8y6F1+iKuiSPcH9IjuBo3kRwpV4TJEVJYuWJ/T9fQNrk4BEQPnomVI4rHV7K/k+
         sC16wilA/IOLzQ6c7yZUqcRsX5a1u2QcVF/sjIQuDByyUbd8CgZ8SFCbo5L9Hf53wh
         CYzN6evp+pGOA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v1 19/28] rust: str: add `c_str!` macro
Date:   Thu, 10 Nov 2022 17:41:31 +0100
Message-Id: <20221110164152.26136-20-ojeda@kernel.org>
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

From: Gary Guo <gary@garyguo.net>

Add `c_str!`, which is a convenience macro that creates a new `CStr`
from a string literal.

It is designed to be similar to a `str` in usage, and it is usable
in const contexts, for instance:

    const X: &CStr = c_str!("Example");

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
[Reworded, adapted for upstream and applied latest changes]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/str.rs | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 3ed685cb5a3c..3fb73b888dce 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -128,6 +128,18 @@ impl CStr {
         Ok(unsafe { Self::from_bytes_with_nul_unchecked(bytes) })
     }
 
+    /// Creates a [`CStr`] from a `[u8]`, panic if input is not valid.
+    ///
+    /// This function is only meant to be used by `c_str!` macro, so
+    /// crates using `c_str!` macro don't have to enable `const_panic` feature.
+    #[doc(hidden)]
+    pub const fn from_bytes_with_nul_unwrap(bytes: &[u8]) -> &Self {
+        match Self::from_bytes_with_nul(bytes) {
+            Ok(v) => v,
+            Err(_) => panic!("string contains interior NUL"),
+        }
+    }
+
     /// Creates a [`CStr`] from a `[u8]` without performing any additional
     /// checks.
     ///
@@ -321,6 +333,26 @@ where
     }
 }
 
+/// Creates a new [`CStr`] from a string literal.
+///
+/// The string literal should not contain any `NUL` bytes.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::c_str;
+/// # use kernel::str::CStr;
+/// const MY_CSTR: &CStr = c_str!("My awesome CStr!");
+/// ```
+#[macro_export]
+macro_rules! c_str {
+    ($str:expr) => {{
+        const S: &str = concat!($str, "\0");
+        const C: &$crate::str::CStr = $crate::str::CStr::from_bytes_with_nul_unwrap(S.as_bytes());
+        C
+    }};
+}
+
 #[cfg(test)]
 mod tests {
     use super::*;
-- 
2.38.1

