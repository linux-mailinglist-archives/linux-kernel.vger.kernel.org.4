Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078EF6D4127
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjDCJtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjDCJs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:48:56 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3028E4C35;
        Mon,  3 Apr 2023 02:48:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 3F5D64212E;
        Mon,  3 Apr 2023 09:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1680515303;
        bh=rLpv9N/MuJdWjBDskv5c1QhUT6HdCop84/bSBVygqeY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=P4AuYska6w6taph8lKaPQjWDuQWv0/U++vpi25iK/tGHl8+k0ScMPJqDtHS5w6OQk
         Y2xSwFeE/ppJ2dUMq76+75ztihktpRfMi3K237uiyULMRjw8ExgQcJS0zufJOJhc1N
         2cfoKzUAHdaYYIdx9toL8ZCHGBRIepXZOLBqNQx0lvWVShgnbxuo7g38eLCrsLX/Qd
         V+vCxcq/cYAcI3uHvIn5bWoonkMEPLaLwf8v1W+8zp9z5cQMFzvOLHIHyS80xGG8ji
         Tgt0QDpqEghlsRV8qCI4xraips5EJFpKKFxzKG8SB4+5Ndg0RTXwZROWQmZkBQJhhD
         oF3vJZNDPOOng==
From:   Asahi Lina <lina@asahilina.net>
Date:   Mon, 03 Apr 2023 18:48:10 +0900
Subject: [PATCH v3 1/6] rust: error: Rename to_kernel_errno() -> to_errno()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-error-v3-1-03779bddc02b@asahilina.net>
References: <20230224-rust-error-v3-0-03779bddc02b@asahilina.net>
In-Reply-To: <20230224-rust-error-v3-0-03779bddc02b@asahilina.net>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Fox Chen <foxhlchen@gmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680515295; l=1299;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=rLpv9N/MuJdWjBDskv5c1QhUT6HdCop84/bSBVygqeY=;
 b=9nrnwa52xgS4clQ3rmGPD/khl8o3VTE2q12KEAtx4dfi0zZ9q7qGssXBpVKJN5iqp/2XvrYZ9
 b0oMHm+OeghAiE5VWRiit7j0+M5na4OVUQKEkLB5eUGHUddgfgIFxJd
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=Qn8jZuOtR1m5GaiDfTrAoQ4NE1XoYVZ/wmt5YtXWFC4=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is kernel code, so specifying "kernel" is redundant. Let's simplify
things and just call it to_errno().

Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/error.rs  | 2 +-
 rust/macros/module.rs | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 5b9751d7ff1d..35894fa35efe 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -73,7 +73,7 @@ pub struct Error(core::ffi::c_int);
 
 impl Error {
     /// Returns the kernel error code.
-    pub fn to_kernel_errno(self) -> core::ffi::c_int {
+    pub fn to_errno(self) -> core::ffi::c_int {
         self.0
     }
 }
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index a7e363c2b044..143336543866 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -258,7 +258,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
                         return 0;
                     }}
                     Err(e) => {{
-                        return e.to_kernel_errno();
+                        return e.to_errno();
                     }}
                 }}
             }}

-- 
2.40.0

