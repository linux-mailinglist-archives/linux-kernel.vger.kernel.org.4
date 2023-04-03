Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB19E6D4D2C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjDCQGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjDCQGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:06:05 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFA73581;
        Mon,  3 Apr 2023 09:05:57 -0700 (PDT)
Date:   Mon, 03 Apr 2023 16:05:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680537955; x=1680797155;
        bh=gdEIW+2bBi1IvDlMbXGasea4+ibnJ2p7QwfZLUN+zQA=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=CAT4FcRPTKXOD8ELZ4PLIVsTI8iHWhIEqw0uBQFS3y6BZnwwTLJwQ7fiDy6R+tLAd
         2DJ3X5zs/GaB3jmr4rDHPa6+6fFiN3uly5OXYGngjr+IjKkcXvwA/AerUMkMggtyFJ
         CbWXUj0EY1BpWheiee5gIAXGz24jy1OG2cYe+FxVxaRaglMMvVnv81xIr1B+1aD6mk
         XIQPbTa0KANgDd5lFa8swL1iqs0KIDXbkkXfqqCFPqH+DesWaSkGUu+LlEA7PKxCY/
         3RcAwXC+760CUYQF6jW0zLghHzVBLDBOMRYPyKKNKeU5fnOj0fbtbDG++vyzUFda1Q
         8VaCwQojdAjWg==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Benno Lossin <y86-dev@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: [PATCH v5 12/15] rust: prelude: add `pin-init` API items to prelude
Message-ID: <20230403160511.174894-5-y86-dev@protonmail.com>
In-Reply-To: <20230403154422.168633-1-y86-dev@protonmail.com>
References: <20230403154422.168633-1-y86-dev@protonmail.com>
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

Add `pin-init` API macros and traits to the prelude.

Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
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


