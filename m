Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A0E6E940A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbjDTMPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbjDTMPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:15:44 -0400
X-Greylist: delayed 82 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Apr 2023 05:15:37 PDT
Received: from mail-40130.protonmail.ch (mail-40130.protonmail.ch [185.70.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC90510E4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:15:37 -0700 (PDT)
Date:   Thu, 20 Apr 2023 12:15:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1681992935; x=1682252135;
        bh=w0OYqHOdw4htSAzQlwAbUhfAuIJpOh8J4Y8eMaG57sw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=wuprcwpUt9xJIjIem3z1QphlNqVMO/sSjrvHLIICnR2R6idML3MN/Stiy4NmWuq7F
         fbR5NeKVO5t9vTwJP0bBErIIorE/8SOky13QEvQySBQvqpH9Ug2xuRX7/jGLuCzsSE
         sL08ZBsSVltM5QmXRyD1TW27L6ewGlH8viU5cnnE6p70S9RA89jDrwMNhCn9sgvRpy
         Dup6lwydW5+SFQGcUEJywvThjkTDnfh/SKn3POABNo9SW1A+QvbZNPWQKvflLclroz
         I51mDsRa9zOvW87pvhj2ZKFSTf5lbRwYczMXNDK9MOmoceN7w6WoICiiLtPRocXmBT
         0oEoZzFmLrEsQ==
To:     Miguel Ojeda <ojeda@kernel.org>
From:   =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Benno Lossin <benno.lossin@proton.me>,
        Josh Stone <jistone@redhat.com>,
        William Brown <william.brown@suse.com>,
        Georgy Yakovlev <gyakovlev@gentoo.org>,
        Jan Alexander Steffens <jan.steffens@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH 2/3] rust: arc: fix intra-doc link in `Arc<T>::init`
Message-ID: <el4vN20xtKtK131oTROhCWUJHjb_hN-Ub-KBZHx3DUI9AIXk8bEbT-FepN2L4v4z82ab0wvzDR5PZS54lmEBVDflniLbInLsVXVjfNov4ho=@protonmail.com>
In-Reply-To: <20230418214347.324156-3-ojeda@kernel.org>
References: <20230418214347.324156-1-ojeda@kernel.org> <20230418214347.324156-3-ojeda@kernel.org>
Feedback-ID: 27884398:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 18th, 2023 at 23:43, Miguel Ojeda <ojeda@kernel.org> wrot=
e:

> `Arc<T>::init` refers to `Arc<T>::pin_init` via an intra-doc link
>=20
> using the text `pin_init`, rather than more explicitly, which makes
> `rustdoc` point it to the `pin_init!` macro instead.
>=20
> This is required for the compiler upgrade since the newer `rustdoc`
> would trigger the `broken_intra_doc_links` lint [1], but in this case
> the macro was not the intended target to begin with, and so the actual
> fix is to make it point to the right place, regardless of the upgrade.
>=20
> Thus make it more explicit.
>=20
> Fixes: 92c4a1e7e81c ("rust: init/sync: add `InPlaceInit` trait to pin-ini=
tialize smart pointers")
> Link: https://github.com/rust-lang/rust/issues/106142 [1]
> Signed-off-by: Miguel Ojeda ojeda@kernel.org

Reviewed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>

>=20
> ---
>  rust/kernel/sync/arc.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index e6d206242465..1b0734fdf6a7 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -185,7 +185,7 @@ impl<T> Arc<T> {
>=20
>      /// Use the given initializer to in-place initialize a `T`.
>      ///
> -    /// This is equivalent to [`pin_init`], since an [`Arc`] is always p=
inned.
> +    /// This is equivalent to [`Arc<T>::pin_init`], since an [`Arc`] is =
always pinned.
>      #[inline]
>      pub fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
>      where
> --
> 2.40.0
