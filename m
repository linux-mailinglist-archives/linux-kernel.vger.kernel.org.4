Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE385710D84
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241379AbjEYNpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241241AbjEYNpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:45:33 -0400
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389631A1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 06:45:25 -0700 (PDT)
Date:   Thu, 25 May 2023 13:45:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1685022324; x=1685281524;
        bh=n19llmgYWxTDw2crXfdj3ubR5MdoXByCzP69vRRATwg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Jq+Wt+KDlamfvOFx0M4kTWbRgwTJwMlfmU0ieBHde19C/yBBXEgRn83wLD+QqjF73
         PoPKvkK1Ouxy8kh/aEURmvgieDfrk2PubgsJermdxj2OPazN0mcF26KrFCIzzatYmm
         /Q91RIKxKMTkupeM8UDnScLwProp8mDJ81Pipr9aNJx82OzNzxfpS/9Ij2nrcm898R
         zFtv6HRgQRx9pcIEm3ik97g5ahfXrRtLcwM2U05nn0h3kp9UkA2Wc4gjSl15oe/+ur
         zpNLpfcmCT1ho5Boa2JFEFxtTOKNRKIJaWHUatusbkXsrct499JHRsyWrDHVV3SgFb
         oO1AXFGV8hRWw==
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH v2 3/4] rust: specify when `ARef` is thread safe
Message-ID: <rOt0aABwNz1toQucRDV8LRFqVIhxJOVXnFrob82CHbTEoxEDGbtIpNjqF-xDi9X5yztPI5qBwMVqJ-9r9hwcyM5Rx3s6O3rKtApouZ-KJ6Y=@proton.me>
In-Reply-To: <0b52529c-5570-bfe8-eb53-f51ae00c2e05@gmail.com>
References: <20230523144418.1250547-1-aliceryhl@google.com> <20230523144418.1250547-4-aliceryhl@google.com> <0b52529c-5570-bfe8-eb53-f51ae00c2e05@gmail.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/23 16:44, Alice Ryhl wrote:
> An `ARef` behaves just like the `Arc` when it comes to thread safety, so
> we can reuse the thread safety comments from `Arc` here.
>=20
> This is necessary because without this change, the Rust compiler will
> assume that things are not thread safe even though they are.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
>   rust/kernel/types.rs | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>=20
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 29db59d6119a..1e5380b16ed5 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -321,6 +321,19 @@ pub struct ARef<T: AlwaysRefCounted> {
>       _p: PhantomData<T>,
>   }
>=20
> +// SAFETY: It is safe to send `ARef<T>` to another thread when the under=
lying `T` is `Sync` because
> +// it effectively means sharing `&T` (which is safe because `T` is `Sync=
`); additionally, it needs
> +// `T` to be `Send` because any thread that has an `ARef<T>` may ultimat=
ely access `T` using a
> +// mutable reference, for example, when the reference count reaches zero=
 and `T` is dropped.
> +unsafe impl<T: AlwaysRefCounted + Sync + Send> Send for ARef<T> {}
> +
> +// SAFETY: It is safe to send `&ARef<T>` to another thread when the unde=
rlying `T` is `Sync`
> +// because it effectively means sharing `&T` (which is safe because `T` =
is `Sync`); additionally,
> +// it needs `T` to be `Send` because any thread that has a `&ARef<T>` ma=
y clone it and get an
> +// `ARef<T>` on that thread, so the thread may ultimately access `T` usi=
ng a mutable reference, for
> +// example, when the reference count reaches zero and `T` is dropped.
> +unsafe impl<T: AlwaysRefCounted + Sync + Send> Sync for ARef<T> {}
> +
>   impl<T: AlwaysRefCounted> ARef<T> {
>       /// Creates a new instance of [`ARef`].
>       ///
> --
> 2.40.1.698.g37aff9b760-goog
>=20

--=20
Cheers,
Benno
