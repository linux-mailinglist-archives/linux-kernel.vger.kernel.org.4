Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEBF6D8702
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjDETiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbjDEThj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:37:39 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3B17D80
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 12:37:18 -0700 (PDT)
Date:   Wed, 05 Apr 2023 19:36:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680723416; x=1680982616;
        bh=gdEIW+2bBi1IvDlMbXGasea4+ibnJ2p7QwfZLUN+zQA=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=vseFoYZ2AedjxwlXJ3fIjHnHGUIujb/axlbQHpdZbxcvkaslLN1WTFsA7YM3LB858
         pvGizao1DJjhKyBl5p537z73NOCdj8QKKV0wxa8vDj1p/P/N1pwYEIsvwH95IH7M/i
         7atH4Ra2gTX00vff6+oQkXRiBbmAYenT3MLkzkdvZfo83e5cbHej45umedVd5CMw6T
         5vJGlDEJGGHciHru9A9lR0u5EV/UFjCLbaQywYwQhX6KaWBvFsUG/jIsucCcbFqjq6
         qxMaxldA43c/Qj2lugQvRJGBBbu1/HQPdMJy/sTz4tnKDF8AD1em+wG2NUQ8pepM39
         GsZn59T03sAjg==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, Andreas Hindborg <nmi@metaspace.dk>
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Benno Lossin <y86-dev@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: [PATCH v6 12/15] rust: prelude: add `pin-init` API items to prelude
Message-ID: <20230405193445.745024-13-y86-dev@protonmail.com>
In-Reply-To: <20230405193445.745024-1-y86-dev@protonmail.com>
References: <20230405193445.745024-1-y86-dev@protonmail.com>
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


