Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63157710D4B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241287AbjEYNfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjEYNfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:35:20 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4A4132;
        Thu, 25 May 2023 06:35:15 -0700 (PDT)
Date:   Thu, 25 May 2023 13:35:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1685021712; x=1685280912;
        bh=7IixD+bhmeF+BKHzzoQ2QhW1JCPmJJ1WQf05j26o1sY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=DYGfzTpQu21styBltnt9D3k03W6GJg/uDtdfvnDhGdlAkMwooOCP07D9xAQ+v0Wle
         KbKuwPAFzEvhNoPQ1nq7IxFvMvcr5KZr0c3jE2ihw1dMspOJYajdYkiKhTL0jgcrL8
         VX9v2M3+UZJwdBgpDwL8eaiW2Ot1x743FfbdZK6hPcqXn2cRwonPFhT3036J3r0n/c
         tPpCXSVwyt5qf44euL/D1m9D6kHglDndgT1xe7Vb2qJwz1FM2Yr1kJ4EWSCu8GbEWW
         k5Ym3rg8IWCXZ2PdDnA62WRuqHwtHGoupZ7Jvqx0S+qUMucL6cwo0UokPYRlRlkjaS
         0J5j2mM4B2C0Q==
To:     Alice Ryhl <aliceryhl@google.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
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
Subject: Re: [PATCH v2 1/4] rust: sync: reword the `Arc` safety comment for `Send`
Message-ID: <JuMYWDm-bTPwPZDn-6oMCeneM4Po-XXsrihWp6sJmkrr60ANrJ3s32Vm6mlxrttdZAlSG5lcjPGtOqf9yrsAkgjV7JNyDZvHkH0einxCNhg=@proton.me>
In-Reply-To: <20230523144418.1250547-2-aliceryhl@google.com>
References: <20230523144418.1250547-1-aliceryhl@google.com> <20230523144418.1250547-2-aliceryhl@google.com>
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
> The safety comment on `impl Send for Arc` talks about "directly"
> accessing the value, when it really means "accessing the value with a
> mutable reference". This commit clarifies that.
>=20
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
>   rust/kernel/sync/arc.rs | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index e6d206242465..87a4c9ed712b 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -146,8 +146,8 @@ impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::Dis=
patchFromDyn<Arc<U>> for Ar
>=20
>   // SAFETY: It is safe to send `Arc<T>` to another thread when the under=
lying `T` is `Sync` because
>   // it effectively means sharing `&T` (which is safe because `T` is `Syn=
c`); additionally, it needs
> -// `T` to be `Send` because any thread that has an `Arc<T>` may ultimate=
ly access `T` directly, for
> -// example, when the reference count reaches zero and `T` is dropped.
> +// `T` to be `Send` because any thread that has an `Arc<T>` may ultimate=
ly access `T` using a
> +// mutable reference, for example, when the reference count reaches zero=
 and `T` is dropped.
>   unsafe impl<T: ?Sized + Sync + Send> Send for Arc<T> {}
>=20
>   // SAFETY: It is safe to send `&Arc<T>` to another thread when the unde=
rlying `T` is `Sync` for the
> --
> 2.40.1.698.g37aff9b760-goog
>=20

--=20
Cheers,
Benno
