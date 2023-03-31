Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F726D20ED
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjCaMwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjCaMwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:52:05 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2469D1FD26
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:51:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r29so22239878wra.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112; t=1680267099;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=UsGubbzk0dCjG5wCsoY5mRw327zyvC5R+ejx+1+wa68=;
        b=03sQJJ1LaNV8LEYEs1ETSwJlzUJlhnJ8G2vSy8+UA5LIU3mqUs7QN4TDdNoDAk9Eqk
         V8R3E702XY/7PSlW6boqvagNy4uVcrpSmGt7yzS353DV+ASE0U0lYFQgQqo8J3C3fMFp
         W6j9R1u7FwlqjnBD1+IXqwwReW987DCIb218egtvqoewVBqVdaqv3WKrLn3aELu5d7Rw
         2dPAIoqnk7mevLWNAVeWFMLjfju7xSYJBXoYUtmb5NtOt068fpBJJnJZPq7DIdUNScAo
         03xlxqvSKLTk6hHlE9Qu3u2X6QoOg/jmK30cMU+qQ1do4hIeb0Zck7DUW5e6IZwkVCsy
         ECFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680267099;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsGubbzk0dCjG5wCsoY5mRw327zyvC5R+ejx+1+wa68=;
        b=rwWI0fNvScifc5uy4khMaULazA8PvTfP/Tn8rI3qfhcXkgdYTZsKwdTkk5O2UASsUF
         BAiewBtQs8t64GDkfo3ddH+IH8BASd+dOvsR8G49ZVwCUaqXWLWBzR3AmlgKE4gN/ApA
         OuVo9AH1BG8P9/zt5C40vlPBkXFqvSpune4fKABv6IE948xF8EiK7Qf/V+M9L6fFLfKG
         MdMSxYj+Ng8vuTkwa01GpFrEeaX2VQziSD6/MkW5cJDqtOTkfc+rzFGh7OR8L5fQxXC3
         YuQzJmtS1HzQOfKL1RxpkwBZ33XcjS8I3X4aX89YXUwJlD0R+/WNJqRRHxsgdyb80PNz
         mGmg==
X-Gm-Message-State: AAQBX9cks4Q95X0obpJVy0SnVlatCrylCSoTmH2I/1zZTC5MZNEfr12r
        VayWW4anNPOyw1iyEHY3Ik8JoA==
X-Google-Smtp-Source: AKy350aDcoHRT3JiiMvfouQyjeJsV4oDEXMvorqyhiIA+F6ahoEd/4aNjEXVaQZExo/0h8Md4kambQ==
X-Received: by 2002:adf:f2c6:0:b0:2d1:5b75:28f0 with SMTP id d6-20020adff2c6000000b002d15b7528f0mr20065546wrp.39.1680267098890;
        Fri, 31 Mar 2023 05:51:38 -0700 (PDT)
Received: from localhost ([165.225.194.194])
        by smtp.gmail.com with ESMTPSA id o11-20020a056000010b00b002de9a0b0a20sm2104329wrx.113.2023.03.31.05.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 05:51:38 -0700 (PDT)
References: <20230329223239.138757-11-y86-dev@protonmail.com>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     y86-dev@protonmail.com
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH v3 10/13] rust: prelude: add `pin-init` API items to
 prelude
Date:   Fri, 31 Mar 2023 14:50:59 +0200
In-reply-to: <20230329223239.138757-11-y86-dev@protonmail.com>
Message-ID: <87bkk92ied.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


y86-dev@protonmail.com writes:

> From: Benno Lossin <y86-dev@protonmail.com>
>
> Add `pin-init` API macros and traits to the prelude.
>
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

>  rust/kernel/prelude.rs | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index 0bc1c97e5604..fcdc511d2ce8 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -18,7 +18,7 @@ pub use core::pin::Pin;
>  pub use alloc::{boxed::Box, vec::Vec};
>
>  #[doc(no_inline)]
> -pub use macros::{module, vtable};
> +pub use macros::{module, pin_data, pinned_drop, vtable};
>
>  pub use super::build_assert;
>
> @@ -27,8 +27,12 @@ pub use super::build_assert;
>  pub use super::dbg;
>  pub use super::{pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info, pr_notice, pr_warn};
>
> +pub use super::{init, pin_init, try_init, try_pin_init};
> +
>  pub use super::static_assert;
>
>  pub use super::error::{code::*, Error, Result};
>
>  pub use super::{str::CStr, ThisModule};
> +
> +pub use super::init::{InPlaceInit, Init, PinInit};

