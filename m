Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACACD640A59
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiLBQPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbiLBQPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:15:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE69AD30A;
        Fri,  2 Dec 2022 08:15:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAAA2B821E8;
        Fri,  2 Dec 2022 16:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E1EC43470;
        Fri,  2 Dec 2022 16:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669997730;
        bh=VSt+/hGabeANQLeUUkDMOId6k6ru4ZPGzmVrw2MIUuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=beKukvFATiP3u3Xmr1v5gXIFi9wWHxS2ykMD9tlunHXc0BjJhHm/7q+kk4wJE0ZDd
         hZqg8ob2kXYdCh+NZA7oIOv6mMoIPjK2nTBZEo22zPv58BgXDSvVRTZeNSzmto5K6u
         3FaBYP0EzT4WRCn/By0vFwDnxZpt+mODz4ADYxZGtf9aYrTSam0ZBk1iuRxxTYiswM
         l788yFfb5w8NzJqPmgWhfR0a6KD4pvHRZ60BjMVHyxPs9E6GbMYv9hGBsOxzmiaLY0
         FKpbd2GlRVljMf5qO/NaoUzsNPUQBB8fjz1/nJFavwPt8woD+NzJ+gQdGzI1oQ6YRw
         gZenyb9qJdpgA==
From:   ojeda@kernel.org
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v2 01/28] rust: prelude: split re-exports into groups
Date:   Fri,  2 Dec 2022 17:14:32 +0100
Message-Id: <20221202161502.385525-2-ojeda@kernel.org>
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

From: Miguel Ojeda <ojeda@kernel.org>

Split the prelude re-exports into groups: first the ones coming
from the `core` crate, then `alloc`, then our own crates and
finally the ones from modules from `kernel` itself (i.e. `super`).

We are doing this manually for the moment, but ideally, long-term,
this could be automated via `rustfmt` with options such as
`group_imports` and `imports_granularity` (both currently unstable).

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/prelude.rs | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 495e22250726..f8219285d8c0 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -11,10 +11,14 @@
 //! use kernel::prelude::*;
 //! ```
 
-pub use super::{
-    error::{Error, Result},
-    pr_emerg, pr_info, ThisModule,
-};
-pub use alloc::{boxed::Box, vec::Vec};
 pub use core::pin::Pin;
+
+pub use alloc::{boxed::Box, vec::Vec};
+
 pub use macros::module;
+
+pub use super::{pr_emerg, pr_info};
+
+pub use super::error::{Error, Result};
+
+pub use super::ThisModule;
-- 
2.38.1

