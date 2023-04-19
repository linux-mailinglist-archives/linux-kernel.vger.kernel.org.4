Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E266E74B4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjDSILn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjDSILj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:11:39 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAC33ABB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:11:37 -0700 (PDT)
Date:   Wed, 19 Apr 2023 08:11:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1681891895; x=1682151095;
        bh=TMt+77U6FMfxb/S+sxZ8N7thoPZfss9+P904a/37zKk=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=GukhTUGJlvryxqN+JZUCkUt0q+wzArbN8QesEafh5xbGBYMsOKC5vunPvDYkrcAFg
         mfOSPFIznXzu9ViuerNuNtZwbEPg/u4F7kEwtNcLTWkYEVlRGcOoP096ci23kTJ0Bq
         klNFwoyiMRWG8q1pw5k5+z1NHTVCbYDLvRcyGGXPYQm5tVWrr/v7yk3fy3lVBWHOjl
         iIJCVMkTpYQQKpwK15UwKWglgtPhMfqqBYHzxaQT6aqN+yTbRt39yfF6l/8Z086h/d
         LI9F5cS56y5UGCOp8BqhFiYehhM5LAMicqlapvWUgktc57t6rFfgp1UG22Mn9aRMMS
         JcIY3i9W89Pbw==
To:     Miguel Ojeda <ojeda@kernel.org>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Josh Stone <jistone@redhat.com>,
        William Brown <william.brown@suse.com>,
        Georgy Yakovlev <gyakovlev@gentoo.org>,
        Jan Alexander Steffens <jan.steffens@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH 2/3] rust: arc: fix intra-doc link in `Arc<T>::init`
Message-ID: <ra8UTkN3PNi-lqfaOWeTlwkVExN4D5jrsxPcSCWFBqNmbTRXpuHgzELMb_PsmowHFuS_1SEPQa9GMCAK_6D0tRH41Khw6Tb72Nv0baVFjEM=@proton.me>
In-Reply-To: <20230418214347.324156-3-ojeda@kernel.org>
References: <20230418214347.324156-1-ojeda@kernel.org> <20230418214347.324156-3-ojeda@kernel.org>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.04.23 23:43, Miguel Ojeda wrote:
> `Arc<T>::init` refers to `Arc<T>::pin_init` via an intra-doc link
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
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
>   rust/kernel/sync/arc.rs | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index e6d206242465..1b0734fdf6a7 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -185,7 +185,7 @@ impl<T> Arc<T> {
>=20
>       /// Use the given initializer to in-place initialize a `T`.
>       ///
> -    /// This is equivalent to [`pin_init`], since an [`Arc`] is always p=
inned.
> +    /// This is equivalent to [`Arc<T>::pin_init`], since an [`Arc`] is =
always pinned.
>       #[inline]
>       pub fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
>       where
> --
> 2.40.0
>
