Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB0A68A976
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 11:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjBDKUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 05:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjBDKUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 05:20:37 -0500
Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [IPv6:2001:67c:2050:102:465::206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FDC268E;
        Sat,  4 Feb 2023 02:20:35 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4P87nr271yz9tKM;
        Sat,  4 Feb 2023 11:20:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyantec.com; s=default;
        t=1675506032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/4CnxbYPhSwwcLfDCu2Isb4HFKKjbzoGz1iu24gYOfY=;
        b=UWiK7weGqMFNV72/qRxSXKYh17yIYHWPrD+0jBJKslbhmR1jWbmSYcjpL8yf4qfxYUAyt7
        QBJmA8G3I6Mnoxq0Tr3cyV9GjEHi8Pz26ANXIhOqQB1blLG4E36pXqTb9iJDRUvwbV8ZQu
        P8CC9ow8h7NGD0PstWuI7wZZn1hIh1JVT3EnIlvhmqr/3P4kGUE3p9iRhBqM6Qx89HSy7P
        RO1RkXMP8C7ArBEmTW2qJ3TW2eIDYCVikwfAvGf7eGfVgKQICWeytAxw03xten/hpzKQOr
        ZfT6q24nEy8Bvfk37HnnCtbMKIl3vjRbj0p0z4Mqm10u3uOwduvPIXFIuSWoDQ==
From:   Finn Behrens <fin@nyantec.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: Re: [RFC 1/5] rust: sync: impl Display for {Unique,}Arc
Date:   Sat, 04 Feb 2023 11:20:29 +0100
Message-ID: <462147AA-C158-4EAE-B1CC-8A9A88F237F3@nyantec.com>
In-Reply-To: <20230201232244.212908-2-boqun.feng@gmail.com>
References: <20230201232244.212908-1-boqun.feng@gmail.com>
 <20230201232244.212908-2-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4P87nr271yz9tKM
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2 Feb 2023, at 0:22, Boqun Feng wrote:

> This allows printing the inner data of `Arc` and its friends if the
> inner data implements `Display`. It's useful for logging and debugging
> purpose.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Finn Behrens <fin@nyantec.com>

> ---
>  rust/kernel/sync/arc.rs | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 519a6ec43644..fc680a4a795c 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -22,6 +22,7 @@ use crate::{
>  };
>  use alloc::boxed::Box;
>  use core::{
> +    fmt,
>      marker::{PhantomData, Unsize},
>      mem::{ManuallyDrop, MaybeUninit},
>      ops::{Deref, DerefMut},
> @@ -522,3 +523,15 @@ impl<T: ?Sized> DerefMut for UniqueArc<T> {
>          unsafe { &mut self.inner.ptr.as_mut().data }
>      }
>  }
> +
> +impl<T: fmt::Display + ?Sized> fmt::Display for UniqueArc<T> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        fmt::Display::fmt(self.deref(), f)
> +    }
> +}
> +
> +impl<T: fmt::Display + ?Sized> fmt::Display for Arc<T> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        fmt::Display::fmt(self.deref(), f)
> +    }
> +}
> -- =

> 2.39.1
