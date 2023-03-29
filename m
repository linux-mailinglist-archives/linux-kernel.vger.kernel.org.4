Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DFD6CF675
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 00:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjC2WfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 18:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjC2Wee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 18:34:34 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929CA4C28;
        Wed, 29 Mar 2023 15:34:06 -0700 (PDT)
Date:   Wed, 29 Mar 2023 22:33:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680129240; x=1680388440;
        bh=WBq9Qox9RYulnSw9oc/MGso5/S0eX4nkpu/+y4M+6as=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=J0V9SVh1KtaWFwjveTDKp+0NCuN4siA12pgB9f0jXBxXKUd2CYMTN8WxeLyy3AXw2
         Rxu4x25pGOSzXCwcnvHL3voDdw8cPcqnMf14tGv7kmNOJYwuTeksOIIhy8uKqWY1Lr
         2IlmLEccE5DPrNzujrRTD/+963tKd/+2XLo4RhYz9Nm3nwDWqTgOTiLbeMk2hkOmx8
         bjf3LlAU5vp+1z5ltRi84yZdIVwOSiQqS/t35tJdaU58lNfqYM6WbCEtK1JiKMXkeg
         LCK7ol3OjeMcCY3G5enM7jha0pX0v/QiZ1966SH5Ci6TzkQnOnxqkII7wqSFWtWMTH
         ANnJrvM1T8UzQ==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>
From:   y86-dev@protonmail.com
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v3 10/13] rust: prelude: add `pin-init` API items to prelude
Message-ID: <20230329223239.138757-11-y86-dev@protonmail.com>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benno Lossin <y86-dev@protonmail.com>

Add `pin-init` API macros and traits to the prelude.

Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
---
 rust/kernel/prelude.rs | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 0bc1c97e5604..fcdc511d2ce8 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -18,7 +18,7 @@ pub use core::pin::Pin;
 pub use alloc::{boxed::Box, vec::Vec};

 #[doc(no_inline)]
-pub use macros::{module, vtable};
+pub use macros::{module, pin_data, pinned_drop, vtable};

 pub use super::build_assert;

@@ -27,8 +27,12 @@ pub use super::build_assert;
 pub use super::dbg;
 pub use super::{pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info, pr=
_notice, pr_warn};

+pub use super::{init, pin_init, try_init, try_pin_init};
+
 pub use super::static_assert;

 pub use super::error::{code::*, Error, Result};

 pub use super::{str::CStr, ThisModule};
+
+pub use super::init::{InPlaceInit, Init, PinInit};
--
2.39.2


