Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4666A1844
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 09:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjBXIu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 03:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjBXIut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 03:50:49 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5877165CDC;
        Fri, 24 Feb 2023 00:50:45 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 615E73FA55;
        Fri, 24 Feb 2023 08:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677228644;
        bh=kJHc+snPjIgQ0x5b0wG6oWK+hDCWiSQ0+kJLlveg4g4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=eADOkSXnOnrG+bRm9Lumm0rkE0iFgIIYcbPQEVc6tAjTSY7inqONtJOJBFpISJfvU
         514K3eerbniJ1CtxpN7Hkb3h0e8Z5BF/DqUq4gzG3bNkfzPCDqO6Jr0Q/LPt7watiM
         rvdT+A+mCY9kkpLVHYnRBlhTNl/SYg2jzo8cKL615LzPHdQiWhRFF8k6BWbDsvkmV1
         +u221r3xiv/Vk2G4Zoxi5COvkD69p8nXqnTGtREa+qDl0gPCQ+Zhh/OWTPS0AH9Yk1
         cr0/3fZWwsTsBbxPpwnJAaEbCzbai54MGUNTedh4M6NfIfmbL2/Fp7ZDI9yjSKcyHW
         t+Q1Yii2HzaTw==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 24 Feb 2023 17:50:21 +0900
Subject: [PATCH 3/5] rust: error: Add to_result() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-error-v1-3-f8f9a9a87303@asahilina.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677228630; l=1204;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=NH9SKYYkrqlm+FkWH/ZnDX0pl4F1HcPQKt111GaT3sI=;
 b=KCT/Vytm/SqVGGDB3HJRNnWM8vV7m/eg//dyk/XUccOo+pJEshAuoTMhBGxReTX91zNPMWhlm
 Lcfou1e9YyICK6k6MRMrXWr6EYJv1btKFyGKZxWjqu1Xom8w/AQwjpF
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

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Add a to_result() helper to convert kernel C return values to a Rust
Result, mapping >=0 values to Ok(()) and negative values to Err(...),
with Error::from_kernel_errno() ensuring that the errno is within range.

Lina: Imported from rust-for-linux/rust, originally developed by Wedson
as part of the AMBA device driver support.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/error.rs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 3b439fdb405c..1e8371f28746 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -167,3 +167,13 @@ impl From<core::convert::Infallible> for Error {
 /// it should still be modeled as returning a `Result` rather than
 /// just an [`Error`].
 pub type Result<T = ()> = core::result::Result<T, Error>;
+
+/// Converts an integer as returned by a C kernel function to an error if it's negative, and
+/// `Ok(())` otherwise.
+pub fn to_result(err: core::ffi::c_int) -> Result {
+    if err < 0 {
+        Err(Error::from_kernel_errno(err))
+    } else {
+        Ok(())
+    }
+}

-- 
2.35.1

