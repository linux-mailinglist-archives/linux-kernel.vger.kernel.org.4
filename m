Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B79264C610
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 10:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237930AbiLNJfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 04:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237896AbiLNJfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 04:35:08 -0500
Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [IPv6:2001:67c:2050:102:465::206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF5F13E15;
        Wed, 14 Dec 2022 01:35:04 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4NX9FF23mNz9tNM;
        Wed, 14 Dec 2022 10:34:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyantec.com; s=default;
        t=1671010497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=JECLRqzznZVJcQFxEyTyGBYjuCU4Zk5HVm/KjeUQy0I=;
        b=HwA7McrarJVH/sxyrgRgGr+zC/lc6vUMGrXbB/tPfqGIat/vDLQUeeEN7HVYKH+SAe69/X
        qkUjLPb4vIccxfoKgCP70xba6gUN+Nf10pRWqM19ElXmkU8Nm4n1bNvBqbvve3Y695x0BD
        pz/Ine/xCXK3TGkx9zS/MZiJnyH9mWgQQlgvEzNo7jtoEt1Le0Xy8fWBMLfd5O9TyzUvWw
        gr5JaRxFjsDLYr401Y5/pOY3bS41iBK0M0gjzWxMnsR57EH9ZtMW7d1m6FVowjMTRtdtWb
        /3LUycOpUR7lQDiXr7CT/8biL9mw+PGZswEr2KRhJklglw+SwcwiS3tuTXjekw==
Date:   Wed, 14 Dec 2022 10:34:51 +0100
From:   Finn Behrens <fin@nyantec.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH] rust: prelude: prevent doc inline of external imports
Message-ID: <20221214093451.zdyhmdyxwz73n6pe@imap.mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This shows exactly where the items are from, previously the items from
macros, alloc and core where shown as a decleration from the kernel crate,
this shows the correct path.

Signed-off-by: Finn Behrens <fin@nyantec.com>
---
 rust/kernel/prelude.rs | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 7a90249ee9b9..917721e791b6 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -11,15 +11,21 @@
 //! use kernel::prelude::*;
 //! ```
 
+#[doc(no_inline)]
 pub use core::pin::Pin;
 
+#[doc(no_inline)]
 pub use alloc::{boxed::Box, vec::Vec};
 
+#[doc(no_inline)]
 pub use macros::{module, vtable};
 
 pub use super::build_assert;
 
-pub use super::{dbg, pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info, pr_notice, pr_warn};
+// super::std_vendor is hidden, which makes the macro inline for some reason
+#[doc(no_inline)]
+pub use super::dbg;
+pub use super::{pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info, pr_notice, pr_warn};
 
 pub use super::static_assert;
 
-- 
2.31.1

