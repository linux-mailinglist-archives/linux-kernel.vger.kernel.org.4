Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F327C624755
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbiKJQoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiKJQni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:43:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C91C45090;
        Thu, 10 Nov 2022 08:43:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECA5261BD9;
        Thu, 10 Nov 2022 16:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2831AC433B5;
        Thu, 10 Nov 2022 16:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668098592;
        bh=McON9F/ZloZh668lpPUE38B16LOD0pkq/6vZiAe96vI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q9PPYY1RDgJiOgY/j1c3gLqlW1NCi+Y11qnDMQHXS+tqtbOuG/Ny56LlRF7+NwNnB
         9Y/lhcdYdOiv+uiVlkW9HWFhyfxJIlmxwlJmDK+2V8AGbt5TdWRtZXumE1qkOGtsdb
         tawjy5DCiUrEGcCnVjRUSgyL3zFL7l+yTA8i/wjzG4CAM7H5tJMMi6Mkph182Nyf9w
         C5zxzTSteoJtEOtbPiPSDC7NCl1TJ/O/ucRBFtii1TWmL0YtDpsXuNeTg5h9InIMyg
         y//I7SkZSGS9P304qTlJroPkvhPixeHCVtQ5A1JUpZCOX9v5FxNVUsIR0YqHFCtsxI
         +VfABN/suQgVw==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Milan Landaverde <milan@mdaverde.com>
Subject: [PATCH v1 18/28] rust: str: add `CStr` unit tests
Date:   Thu, 10 Nov 2022 17:41:30 +0100
Message-Id: <20221110164152.26136-19-ojeda@kernel.org>
In-Reply-To: <20221110164152.26136-1-ojeda@kernel.org>
References: <20221110164152.26136-1-ojeda@kernel.org>
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

From: Milan Landaverde <milan@mdaverde.com>

Add unit tests for `CStr::from_bytes_with_nul()` and
`CStr::from_bytes_with_nul_unchecked()`.

These serve as an example of the first unit tests for Rust code
(i.e. different from documentation tests).

Signed-off-by: Milan Landaverde <milan@mdaverde.com>
[Reworded, adapted for upstream and applied latest changes]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/str.rs | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 11d297c1a61c..3ed685cb5a3c 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -321,6 +321,35 @@ where
     }
 }
 
+#[cfg(test)]
+mod tests {
+    use super::*;
+
+    #[test]
+    fn test_cstr_to_str() {
+        let good_bytes = b"\xf0\x9f\xa6\x80\0";
+        let checked_cstr = CStr::from_bytes_with_nul(good_bytes).unwrap();
+        let checked_str = checked_cstr.to_str().unwrap();
+        assert_eq!(checked_str, "🦀");
+    }
+
+    #[test]
+    #[should_panic]
+    fn test_cstr_to_str_panic() {
+        let bad_bytes = b"\xc3\x28\0";
+        let checked_cstr = CStr::from_bytes_with_nul(bad_bytes).unwrap();
+        checked_cstr.to_str().unwrap();
+    }
+
+    #[test]
+    fn test_cstr_as_str_unchecked() {
+        let good_bytes = b"\xf0\x9f\x90\xA7\0";
+        let checked_cstr = CStr::from_bytes_with_nul(good_bytes).unwrap();
+        let unchecked_str = unsafe { checked_cstr.as_str_unchecked() };
+        assert_eq!(unchecked_str, "🐧");
+    }
+}
+
 /// Allows formatting of [`fmt::Arguments`] into a raw buffer.
 ///
 /// It does not fail if callers write past the end of the buffer so that they can calculate the
-- 
2.38.1

