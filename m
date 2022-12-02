Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D0A640A78
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbiLBQSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbiLBQSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:18:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03636DA216;
        Fri,  2 Dec 2022 08:16:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DC07B821EF;
        Fri,  2 Dec 2022 16:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A092C433C1;
        Fri,  2 Dec 2022 16:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669997804;
        bh=g8YHlGQGI5+kOudmGxtQLpBJJ0VXh/b1x75GjPjycds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KYWxTLoMH80ob3tE9WkideVGBL6HUpVaeZ5ha7q+gWJ8kjI8kW66x0wMfXqBvNl+s
         PJQd5K5KQZRPbx0Sf1colbtpMw5EMb5frdHCbG7WXSId49CmBIqnhXOgw/SvWlMLZW
         /pZ+eLV9PZFDyxqIlZn7RE/zRC50mbZ565dHUtozufFIjPr8JhTyW/GjdODiw5zipj
         PX+JcqHJ1LzyhAC0rPUsYW4UiIwEtvsY0IeeGfNCYu7LMAw735b5jv3CF0bl//grQn
         tO5nU021aoxzEyOal7ng3ohpzMfzsMpB4YvPYEu74tLUPOY8AjYGByia8fsEgC3mBx
         4QsQIkCbNju3g==
From:   ojeda@kernel.org
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v2 27/28] rust: types: add `Either` type
Date:   Fri,  2 Dec 2022 17:14:58 +0100
Message-Id: <20221202161502.385525-28-ojeda@kernel.org>
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

Introduce the new `types` module of the `kernel` crate with
`Either` as its first type.

`Either<L, R>` is a sum type that always holds either a value
of type `L` (`Left` variant) or `R` (`Right` variant).

For instance:

    struct Executor {
        queue: Either<BoxedQueue, &'static Queue>,
    }

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Reviewed-by: Wei Liu <wei.liu@kernel.org>
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

