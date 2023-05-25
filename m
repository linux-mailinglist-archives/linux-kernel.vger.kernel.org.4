Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2194710D97
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241396AbjEYNvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240966AbjEYNvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:51:14 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E03186
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 06:51:10 -0700 (PDT)
Date:   Thu, 25 May 2023 13:50:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=5aoyqs344fhubkfvtkwrcry4xi.protonmail; t=1685022668; x=1685281868;
        bh=6YZpbdH442xI5ahkra+Rj8DusW4wlxrFG6pdXqv769o=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=cic8tsuMcaYjh0AMhivCkzsA+0kzurdnfjqVM765he8bkT8tkQgrvp089nwYJM+CV
         d+5g0t8hYTSg+UVnh9GdmI8mJLILcuAojija4H84jbglWtt0EBe2Vn9aJKC/O+ndFc
         enZU/AhuEDoBcJU1vjw3OcCmojJcjBzMj+SXv9FUe37Ha7+TUNuxFXiTj3g76iXmsX
         rLbrf1JqGnl8uRanlVDMT5auqTdYbAvMWVpo1jB5AL8AKyijOWa7Wca+tgus1dozq4
         krlOwEsJagjMUrOKP6xRyLSc607E20mjjNLUrOSJXWGbY4wyx0NkWBlEbrQbv1Mbcn
         hz7mlX575i33w==
To:     Alice Ryhl <aliceryhl@google.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v1 2/2] rust: sync: implement `AsRef<T>` for `Arc<T>`
Message-ID: <DT_8UBvti_dML0vOrXVfUwNnTjhHlhBsioFDBIudjzzxjJl1SCTHU6cn5qjmZj3wTt7r8R1PFDStDv2C2IAjMj4Ubbpy5r587LkyfJEa4VY=@proton.me>
In-Reply-To: <20230517200814.3157916-2-aliceryhl@google.com>
References: <20230517200814.3157916-1-aliceryhl@google.com> <20230517200814.3157916-2-aliceryhl@google.com>
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

On 5/17/23 22:08, Alice Ryhl wrote:
> This trait lets you use `Arc<T>` in code that is generic over smart
> pointer types.
>=20
> The `AsRef` trait should be implemented on all smart pointers. The
> standard library also implements it on the ordinary `Arc`.
>=20
> Co-developed-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
>   rust/kernel/sync/arc.rs | 6 ++++++
>   1 file changed, 6 insertions(+)
>=20
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 274febe3bb06..9ec911e4a0c7 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -264,6 +264,12 @@ impl<T: ?Sized> Deref for Arc<T> {
>       }
>   }
>=20
> +impl<T: ?Sized> AsRef<T> for Arc<T> {
> +    fn as_ref(&self) -> &T {
> +        self.deref()
> +    }
> +}
> +
>   impl<T: ?Sized> Clone for Arc<T> {
>       fn clone(&self) -> Self {
>           // INVARIANT: C `refcount_inc` saturates the refcount, so it ca=
nnot overflow to zero.
> --
> 2.40.1.606.ga4b1b128d6-goog
>=20

--=20
Cheers,
Benno
