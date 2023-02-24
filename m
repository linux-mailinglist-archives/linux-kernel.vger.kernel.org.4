Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117B16A1AA9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjBXKxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBXKxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:53:46 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B2D30E0;
        Fri, 24 Feb 2023 02:53:45 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 44C634206F;
        Fri, 24 Feb 2023 10:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677236024;
        bh=sJXKzM9ye5UpmrgbyuuthZgT+KWJTloP+4kPhG+KQ/k=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=oa1/MEiiXrg9mbqpHfbEKIp8g2n5RxkQB42j1wGBzAU51cFkRJi7ueQBGd/e59Brl
         7GoMcsyCOveOh/QgTpe9MahflHSAX3d67TWE2Fkll+LVpC7TmLb2WlFNCThlREjzLD
         6GUpv6nT76QR2+qiaVjO8JIWMCYT5kO15bKsbjxwjSY0wh0Cev51ebn/OijewbwjpB
         /2qDSDR9e03ZKD8m6EG42hw0Jst6DA4Y7tLPtc2WHipqK3rY5QbcvsFPcLPsQM58bK
         yhVVjgcSEvXz0Lox/JZZk/8axll9MDYOPzV8hitLUmGKRjGCHDuyNKJzDhgwlbFUDR
         G8/MIhnVT3HKA==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 24 Feb 2023 19:53:13 +0900
Subject: [PATCH 1/5] rust: Add a Sealed trait
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-iopt-rtkit-v1-1-49ced3391295@asahilina.net>
References: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
In-Reply-To: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677236013; l=780;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=sJXKzM9ye5UpmrgbyuuthZgT+KWJTloP+4kPhG+KQ/k=;
 b=2N7EOf9lvtQl1KnhDXXm0FkvG4Na7dWKbQBTLsMk8jqk7B7Y4WPfN/hlCBMv3CBOdYjE0fIKU
 E+XrQbtCkZPD7FsAJAXaDP50Tbk5LoTqUkrE+GslcgajYZk1801LH+S
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

Some traits exposed by the kernel crate may not be intended to be
implemented by downstream modules. Add a Sealed trait to allow avoiding
this using the sealed trait pattern.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/lib.rs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 223564f9f0cc..82dff6f4cf60 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -46,6 +46,11 @@ pub use macros;
 #[doc(hidden)]
 pub use build_error::build_error;
 
+pub(crate) mod private {
+    #[allow(unreachable_pub)]
+    pub trait Sealed {}
+}
+
 /// Prefix to appear before log messages printed from within the `kernel` crate.
 const __LOG_PREFIX: &[u8] = b"rust_kernel\0";
 

-- 
2.35.1

