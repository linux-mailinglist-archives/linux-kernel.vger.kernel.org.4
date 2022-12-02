Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6150F640A6E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbiLBQRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbiLBQQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:16:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16659E076D;
        Fri,  2 Dec 2022 08:16:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A93AEB821E6;
        Fri,  2 Dec 2022 16:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B15C43470;
        Fri,  2 Dec 2022 16:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669997782;
        bh=rwwioSQhWGlbsSveUMx0tqInUdVD+U2ybxu5VIpUbRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qdHfVr+fC3u1HwOHRGvxny6qMSmv3OfyzAhLmZZ7j/F/TrmrzFJ6s84m7LjHucTKp
         TS6N0rnkE/xFe1YstIfnTSkEtUqfzhf0Y3qhLKhskGzpmr4TufyQo5Lo15ee+2mOdu
         w4g14HgGx1uIsrYgu8IOD/bER8fvYm7UKyHup70UaX4ujOnAuh7eqHhtaq8B4J8xsb
         sqOwnD2etHNPp7uYQbIwvuUoJEtbMYOtvPy0F70Psnxd/aRK0xIwzi4V7rXs+8RDg3
         8orTszzXRwKeY2xuyDMhN0jRiGl4LzpZQIaUShQLDRngz93H5W5Fb7QV73cnoUzqVX
         ARc6ohQ3LMCtw==
From:   ojeda@kernel.org
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v2 19/28] rust: str: add `c_str!` macro
Date:   Fri,  2 Dec 2022 17:14:50 +0100
Message-Id: <20221202161502.385525-20-ojeda@kernel.org>
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
 rust/kernel/str.rs | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 3ed685cb5a3c..a995db36486f 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -321,6 +321,29 @@ where
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
+        const C: &$crate::str::CStr = match $crate::str::CStr::from_bytes_with_nul(S.as_bytes()) {
+            Ok(v) => v,
+            Err(_) => panic!("string contains interior NUL"),
+        };
+        C
+    }};
+}
+
 #[cfg(test)]
 mod tests {
     use super::*;
-- 
2.38.1

