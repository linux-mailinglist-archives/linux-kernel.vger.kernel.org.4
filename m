Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D84F6A1843
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 09:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjBXIus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 03:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjBXIun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 03:50:43 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF2B61EFE;
        Fri, 24 Feb 2023 00:50:42 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C372241A42;
        Fri, 24 Feb 2023 08:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677228640;
        bh=N+RXIF/i8BSXwu8BAV5Rq51ZpnCtf/pwSt4pl5MqBLw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=sgSwQWt9xGTwGFMB2TdWEr9w5/65uiCuNhnF6EePNANn7kTxyc9j1ki7VZHILynIi
         nzOz0/JtbOP1KoEPaFyAgKJ/Oti/bNVV7yy/3gsSB1Juy22ZiulYaNXAsEs19tH3tE
         1rIWsiSaH+gVFW93LS3A8XsKCp8WHR4tcimOujS/dZLB5SexFouEXMSpVPtANwGvtn
         LwriYEWDJ0Y9IGgHNeefy4M1xfJwxDYE0k1ZBxRz3/bt9/n2cl22vXFZEMa6zsWQlv
         LExpOrEzvitw/6oOyy3B3yTADIwl6i5gD6jr9Bo3y4yW5ty2MasfneY+vFxkA2oDmB
         2CZLOUUe/4BEA==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 24 Feb 2023 17:50:20 +0900
Subject: [PATCH 2/5] rust: error: Add Error::from_kernel_errno()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-error-v1-2-f8f9a9a87303@asahilina.net>
References: <20230224-rust-error-v1-0-f8f9a9a87303@asahilina.net>
In-Reply-To: <20230224-rust-error-v1-0-f8f9a9a87303@asahilina.net>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Fox Chen <foxhlchen@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677228630; l=1835;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=x7nP5Dl+jwwx+80LB5PaFXLvxugGvPP/700imGU1Bp0=;
 b=CdN4zbiFV2Fkiy8QTvCq6VBwUqTn1obt6jCAuKp+JyoSL0YG47zwHJBiiSUrkvLnt3nZjNt+7
 Fj9UV4SjXZ6ApdWLpqILoNme+RbeL+trkrVNJpsxdlZma9ofB4O79/+
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

From: Miguel Ojeda <ojeda@kernel.org>

Add a function to create `Error` values out of a kernel error return,
which safely upholds the invariant that the error code is well-formed
(negative and greater than -MAX_ERRNO). If a malformed code is passed
in, it will be converted to EINVAL.

Lina: Imported from rust-for-linux/rust as authored by Miguel and Fox
with refactoring from Wedson.

Co-developed-by: Fox Chen <foxhlchen@gmail.com>
Signed-off-by: Fox Chen <foxhlchen@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/error.rs | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 8611758e27f4..3b439fdb405c 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -72,6 +72,25 @@ pub mod code {
 pub struct Error(core::ffi::c_int);
 
 impl Error {
+    /// Creates an [`Error`] from a kernel error code.
+    ///
+    /// It is a bug to pass an out-of-range `errno`. `EINVAL` would
+    /// be returned in such a case.
+    pub(crate) fn from_kernel_errno(errno: core::ffi::c_int) -> Error {
+        if errno < -(bindings::MAX_ERRNO as i32) || errno >= 0 {
+            // TODO: Make it a `WARN_ONCE` once available.
+            crate::pr_warn!(
+                "attempted to create `Error` with out of range `errno`: {}",
+                errno
+            );
+            return code::EINVAL;
+        }
+
+        // INVARIANT: The check above ensures the type invariant
+        // will hold.
+        Error(errno)
+    }
+
     /// Returns the kernel error code.
     pub fn to_kernel_errno(self) -> core::ffi::c_int {
         self.0

-- 
2.35.1

