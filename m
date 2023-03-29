Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A5C6CD90E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjC2MFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjC2MFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:05:03 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03166468B;
        Wed, 29 Mar 2023 05:04:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1B3A4424A5;
        Wed, 29 Mar 2023 12:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1680091498;
        bh=D4/twBr+bzIjY4ZGn+sbXBAJvi8KroM1AK8OX54iYyI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=O9YVbyPosEDBz1Y3e376jGTJdPZ56RObMPGEQKs2kbZDSMJLGz0iqM48RP9Bgg4jP
         9j92qyyx8XYyVdP9cHvMvyyaXSRb9OtgPm1wKg/eiWnptEAI6XELAMSSY5aNs1Ar58
         X9N0AK2DO4ogwJQwYo2KRRQAeLgzB9Wip9ZJ8n6/0XSPCiOka5Xs06nUzf1sWZ5JgZ
         LkPFlZMXMaX7E8pZ70aWPsUFsyoarZEJnCR6uF1GjvRmWt+nOWCFN/dmINb2qEsQUW
         svC9yWrzKhMMRJH07fzM0S9pvF5tlqwpfp2DDeaywrYCtFsFwugn3rLElXy4x5NthK
         px9nunpoJGpJg==
From:   Asahi Lina <lina@asahilina.net>
Date:   Wed, 29 Mar 2023 21:04:36 +0900
Subject: [PATCH v2 4/6] rust: error: Add to_result() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-error-v2-4-3900319812da@asahilina.net>
References: <20230224-rust-error-v2-0-3900319812da@asahilina.net>
In-Reply-To: <20230224-rust-error-v2-0-3900319812da@asahilina.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680091478; l=1246;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=Pyrepc31fu1j2hIHl+GlAJgfJXkFKrgb4Ue04icQgQk=;
 b=Qi1Fy6I/4bHQHbB9VuqBIwCJsY+ax2RlS2ro/Kyr4QO8xcgJz+/zdD8IOdnkYaufWCDB//8ot
 kA5XhtU7hJlADXksO7SehAh9Q98rL6Ptixy/XzzymQEtuAjJBKlp5vR
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

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Add a to_result() helper to convert kernel C return values to a Rust
Result, mapping >=0 values to Ok(()) and negative values to Err(...),
with Error::from_errno() ensuring that the errno is within range.

Lina: Imported from rust-for-linux/rust, originally developed by Wedson
as part of the AMBA device driver support.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/error.rs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 659468bd1735..4f599c4d1752 100644
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
+        Err(Error::from_errno(err))
+    } else {
+        Ok(())
+    }
+}

-- 
2.40.0

