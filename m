Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CCA62475E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbiKJQpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbiKJQo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:44:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BC010FE0;
        Thu, 10 Nov 2022 08:43:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73137B82251;
        Thu, 10 Nov 2022 16:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293CEC433B5;
        Thu, 10 Nov 2022 16:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668098620;
        bh=qGXfF0wUmE6bpAXFogr6UIGDaM64e+dQ9MKJUHRzQqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JzTGAWvq1ESHwzE5/pnlpzv+kVN4jQdV0B7HZEKQ/UmLxon1vkKllZAhV1tMEcGBL
         TjNhYhQ93oWavvSJQCrcp+aUEsO5yFkknl12Ak8++oIXZVVu+I41j9wAThrU43HkHP
         vXIf/h8URsKzoDgUyMR5OZQ/awbNiuMyca0x9jorm7yZ5X3Pw5NoQyuhw+5P0Rf+4Q
         KjUXEnopsOuDc92smLFfBJh4l3acvRr0CdfzyRSo14rrxUFbcxkeTULB5Ra47pyOUa
         u9uTDs58hdBnt5F4SuN1CHWr6iceMyvVijdPgUTVTX5b1sg4iytGoJQ2t5hR/IX7AE
         wy75gexKLrpoA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v1 27/28] rust: types: add `Either` type
Date:   Thu, 10 Nov 2022 17:41:39 +0100
Message-Id: <20221110164152.26136-28-ojeda@kernel.org>
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

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Introduce the new `types` module of the `kernel` crate with
`Either` as its first type.

`Either<L, R>` is a sum type that always holds either a value
of type `L` (`Left` variant) or `R` (`Right` variant).

For instance:

    struct Executor {
        queue: Either<BoxedQueue, &'static Queue>,
    }

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
[Reworded, adapted for upstream and applied latest changes]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/lib.rs   |  1 +
 rust/kernel/types.rs | 12 ++++++++++++
 2 files changed, 13 insertions(+)
 create mode 100644 rust/kernel/types.rs

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index a3abc110ff97..53040fa9e897 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -31,6 +31,7 @@ mod static_assert;
 #[doc(hidden)]
 pub mod std_vendor;
 pub mod str;
+pub mod types;
 
 #[doc(hidden)]
 pub use bindings;
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
new file mode 100644
index 000000000000..3b0c44769708
--- /dev/null
+++ b/rust/kernel/types.rs
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Kernel types.
+
+/// A sum type that always holds either a value of type `L` or `R`.
+pub enum Either<L, R> {
+    /// Constructs an instance of [`Either`] containing a value of type `L`.
+    Left(L),
+
+    /// Constructs an instance of [`Either`] containing a value of type `R`.
+    Right(R),
+}
-- 
2.38.1

