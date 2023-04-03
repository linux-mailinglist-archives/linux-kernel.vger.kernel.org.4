Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4105D6D412D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjDCJtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjDCJtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:49:07 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0FC12BE3;
        Mon,  3 Apr 2023 02:48:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 24C1E42463;
        Mon,  3 Apr 2023 09:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1680515315;
        bh=1P5QGZkC91BVciAq6IwmhV1rY1KwoTA3fWIHUuZy+8g=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=yDLljO8EQYJSU7dJ+J6J9ferhSr78RHQpptYiIXjCN4njyWl+ikQicZrU+qxXvDEf
         vk5FQKn2DIO/Fw3UKfz/lVKKDX5arP2NJtjDUYjygOZoN/VQ2z3+0nCsCkZhQ8mKWw
         hhBWhrrXhKA//jjKt+OrZHhIEuVnGebVioKkHOOXASQKrIZGZxUyFJn+gFQd+NhMBP
         AYXtiwwAmWQ6eMu6L4HNmwbhpGMTJyK3Xg+OuIslqkXoPVBhaH0F2Zvxgri24KKx4j
         jOo6q75oulz4XEPDquYa74A37ibPMg95pnse8PosvEK8Beul9P+7zUCsUNcuyltsWw
         gKAQO2ba1cbZA==
From:   Asahi Lina <lina@asahilina.net>
Date:   Mon, 03 Apr 2023 18:48:13 +0900
Subject: [PATCH v3 4/6] rust: error: Add to_result() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-error-v3-4-03779bddc02b@asahilina.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680515295; l=1349;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=1wdN2vnmW6zZsxONU/uE2/YF42hR2YW74gn3/MQ5V4U=;
 b=EE3/RV3dvHT1L2FgxdAj0DSteyWP1D6o3slOa15LxiMp77atWOjnl7bza4WyQYjEugRjcHi0/
 ZLnnlVRInMeBqD0zq36OfZoU1YH/4CWbRTujeVXXJeLoVlw2YekLDOH
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
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/error.rs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 1af0d75d3a73..e8697ad6b62e 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -178,3 +178,13 @@ impl From<core::convert::Infallible> for Error {
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

