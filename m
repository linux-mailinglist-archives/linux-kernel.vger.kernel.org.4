Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C9D640A72
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbiLBQRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbiLBQQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:16:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34DDBE6A1;
        Fri,  2 Dec 2022 08:16:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C22BB821EF;
        Fri,  2 Dec 2022 16:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1C9C433D6;
        Fri,  2 Dec 2022 16:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669997785;
        bh=lNOFPVRbAKVrfjnVGGlh1mHXRjctVq4x9YbdvqaJ5Pc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eZA4rWwQlLf/QhcBhrlLCwVeLdG0tbiNvtMljCe5GPUaS1snLGeCqEF0fOQBXL7lc
         O2Ou8zvs6Vta595iqoUkxn4qyPgwQuNC5GP2RciAUllOKsi6dtrrQYCKCo9U0jkxh+
         sxWfFO04JADRtp9ZcKcTKc7ap54ysr+Z8tjDdc+I1gtNedTFaZU7/OHjDSQdVfGCl5
         xhAkSvQCowbAgvVNgnOAehjsD8GEYd/OPcBMJIl5vfBqi7Nm3LBbA9yDFVqDVTKnFT
         1+SBvnDxZ77h5m0ZRF2lCbhdTzUhYh1tR7kSG4rMVVbTib/D3BnZcwOWS/UJ/C1Hq6
         lqzZKBgD4TMFg==
From:   ojeda@kernel.org
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Adam Bratschi-Kaye <ark.email@gmail.com>
Subject: [PATCH v2 20/28] rust: str: add `Formatter` type
Date:   Fri,  2 Dec 2022 17:14:51 +0100
Message-Id: <20221202161502.385525-21-ojeda@kernel.org>
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

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Add the `Formatter` type, which leverages `RawFormatter`,
but fails if callers attempt to write more than will fit
in the buffer.

In order to so, implement the `RawFormatter::from_buffer()`
constructor as well.

Co-developed-by: Adam Bratschi-Kaye <ark.email@gmail.com>
Signed-off-by: Adam Bratschi-Kaye <ark.email@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
[Reworded, adapted for upstream and applied latest changes]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/str.rs | 57 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index a995db36486f..ce207d1b3d2a 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -406,6 +406,23 @@ impl RawFormatter {
         }
     }
 
+    /// Creates a new instance of [`RawFormatter`] with the given buffer.
+    ///
+    /// # Safety
+    ///
+    /// The memory region starting at `buf` and extending for `len` bytes must be valid for writes
+    /// for the lifetime of the returned [`RawFormatter`].
+    pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
+        let pos = buf as usize;
+        // INVARIANT: We ensure that `end` is never less then `buf`, and the safety requirements
+        // guarantees that the memory region is valid for writes.
+        Self {
+            pos,
+            beg: pos,
+            end: pos.saturating_add(len),
+        }
+    }
+
     /// Returns the current insert position.
     ///
     /// N.B. It may point to invalid memory.
@@ -439,3 +456,43 @@ impl fmt::Write for RawFormatter {
         Ok(())
     }
 }
+
+/// Allows formatting of [`fmt::Arguments`] into a raw buffer.
+///
+/// Fails if callers attempt to write more than will fit in the buffer.
+pub(crate) struct Formatter(RawFormatter);
+
+impl Formatter {
+    /// Creates a new instance of [`Formatter`] with the given buffer.
+    ///
+    /// # Safety
+    ///
+    /// The memory region starting at `buf` and extending for `len` bytes must be valid for writes
+    /// for the lifetime of the returned [`Formatter`].
+    #[allow(dead_code)]
+    pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
+        // SAFETY: The safety requirements of this function satisfy those of the callee.
+        Self(unsafe { RawFormatter::from_buffer(buf, len) })
+    }
+}
+
+impl Deref for Formatter {
+    type Target = RawFormatter;
+
+    fn deref(&self) -> &Self::Target {
+        &self.0
+    }
+}
+
+impl fmt::Write for Formatter {
+    fn write_str(&mut self, s: &str) -> fmt::Result {
+        self.0.write_str(s)?;
+
+        // Fail the request if we go past the end of the buffer.
+        if self.0.pos > self.0.end {
+            Err(fmt::Error)
+        } else {
+            Ok(())
+        }
+    }
+}
-- 
2.38.1

