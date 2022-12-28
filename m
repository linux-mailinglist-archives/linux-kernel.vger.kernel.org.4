Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A8A6573A0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 08:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiL1HZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 02:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiL1HYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 02:24:51 -0500
Received: from mr85p00im-hyfv06011401.me.com (mr85p00im-hyfv06011401.me.com [17.58.23.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39203FAC0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 23:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1672212290; bh=T/yLVxjFm9+5yED0EaI0vGt/JL3GC85BWInW5xiO43U=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=SXfh8dkDtKeIV0MUTaQIYiKlBJD4lGjc00OOEUO/CpeEgbmC5+BTntqIwLgpp9+5K
         eiF3L6CaQAyAVI8xa+VzwWB1oJl+fPTLWPpnI52kEAqOUyQzmKV9773GKEWWiNqFpV
         Cnk/YBnatDrj6wm942pJbRjum11qAFad5a5O8VeDA64XZpDw+9PzN1NvNhiTHhVuAl
         Qn93+7XOyhYRrSCKWE1RYIzxksK1Wd3+eyXwu8EjTd7s/aCQ6Bqvlo5USwB6EHmgEO
         nDTOW90cp5c5T0PeoqyXpegZSApk64UnEhyTbkSe6c03vw9MSKNyPKAr//HpFzOzPR
         kY8m3jWtOP5jg==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-hyfv06011401.me.com (Postfix) with ESMTPSA id 558A1357C7A2;
        Wed, 28 Dec 2022 07:24:49 +0000 (UTC)
Content-Type: multipart/signed;
        boundary="Apple-Mail=_40C9644B-DA5B-4EE1-AEDB-66403DCD5AE5";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.23\))
Subject: Re: [PATCH 7/7] rust: sync: add support for dispatching on Arc and
 ArcBorrow.
From:   Laine Taffin Altman <alexanderaltman@me.com>
In-Reply-To: <20221228060346.352362-7-wedsonaf@gmail.com>
Date:   Tue, 27 Dec 2022 23:24:37 -0800
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Message-Id: <D0EB09C0-A9F6-4AB3-B9A2-98ACDAA25DAD@me.com>
References: <20221228060346.352362-1-wedsonaf@gmail.com>
 <20221228060346.352362-7-wedsonaf@gmail.com>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
X-Mailer: Apple Mail (2.3731.400.23)
X-Proofpoint-GUID: qXi-_ls4wHgtlUf56CtQIbKndJRnfMKG
X-Proofpoint-ORIG-GUID: qXi-_ls4wHgtlUf56CtQIbKndJRnfMKG
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.816,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-18=5F01:2022-01-14=5F01,2022-01-18=5F01,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2212280059
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_40C9644B-DA5B-4EE1-AEDB-66403DCD5AE5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Dec 27, 2022, at 10:03 PM, Wedson Almeida Filho <wedsonaf@gmail.com> =
wrote:
>=20
> Trait objects (`dyn T`) require trait `T` to be "object safe". One of
> the requirements for "object safety" is that the receiver have one of
> the allowed types. This commit adds `Arc<T>` and `ArcBorrow<'_, T>` to
> the list of allowed types.
>=20
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> ---
> rust/kernel/lib.rs      |  1 +
> rust/kernel/sync/arc.rs | 20 ++++++++++++++++++--
> 2 files changed, 19 insertions(+), 2 deletions(-)
>=20
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 4bde65e7b06b..e0b0e953907d 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -15,6 +15,7 @@
> #![feature(allocator_api)]
> #![feature(coerce_unsized)]
> #![feature(core_ffi_c)]
> +#![feature(dispatch_from_dyn)]
> #![feature(receiver_trait)]
> #![feature(unsize)]
>=20
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 832bafc74a90..ff73f9240ca1 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -92,9 +92,15 @@ use core::{
> /// Coercion from `Arc<Example>` to `Arc<dyn MyTrait>`:
> ///
> /// ```
> -/// use kernel::sync::Arc;
> +/// use kernel::sync::{Arc, ArcBorrow};
> +///
> +/// trait MyTrait {
> +///     // Trait has a function whose `self` type is `Arc<Self>`.
> +///     fn example1(self: Arc<Self>) {}
> ///
> -/// trait MyTrait {}
> +///     // Trait has a function whose `self` type is `ArcBorrow<'_, =
Self>`.
> +///     fn example2(self: ArcBorrow<'_, Self>) {}
> +/// }
> ///
> /// struct Example;
> /// impl MyTrait for Example {}
> @@ -123,6 +129,9 @@ impl<T: ?Sized> core::ops::Receiver for Arc<T> {}
> // dynamically-sized type (DST) `U`.
> impl<T: ?Sized + Unsize<U>, U: ?Sized> =
core::ops::CoerceUnsized<Arc<U>> for Arc<T> {}
>=20
> +// This is to allow `Arc<U>` to be dispatched on when `Arc<T>` can be =
coerced into `Arc<U>`.
> +impl<T: ?Sized + Unsize<U>, U: ?Sized> =
core::ops::DispatchFromDyn<Arc<U>> for Arc<T> {}
> +
> // SAFETY: It is safe to send `Arc<T>` to another thread when the =
underlying `T` is `Sync` because
> // it effectively means sharing `&T` (which is safe because `T` is =
`Sync`); additionally, it needs
> // `T` to be `Send` because any thread that has an `Arc<T>` may =
ultimately access `T` directly, for
> @@ -297,6 +306,13 @@ pub struct ArcBorrow<'a, T: ?Sized + 'a> {
> // This is to allow [`ArcBorrow`] (and variants) to be used as the =
type of `self`.
> impl<T: ?Sized> core::ops::Receiver for ArcBorrow<'_, T> {}
>=20
> +// This is to allow `ArcBorrow<U>` to be dispatched on when =
`ArcBorrow<T>` can be coerced into
> +// `ArcBorrow<U>`.
> +impl<T: ?Sized + Unsize<U>, U: ?Sized> =
core::ops::DispatchFromDyn<ArcBorrow<'_, U>>
> +    for ArcBorrow<'_, T>

These lifetimes need to be tied together, I think.
`impl<'a, T: ?Sized + Unsize<U> + 'a, U: ?Sized + 'a> =
core::ops::DispatchFromDyn<ArcBorrow<'a, U>> for ArcBorrow<'a, T>`

> +{
> +}
> +
> impl<T: ?Sized> Clone for ArcBorrow<'_, T> {
>     fn clone(&self) -> Self {
>         *self
> --
> 2.34.1
>=20
>=20


=E2=80=94 Laine Taffin Altman

--Apple-Mail=_40C9644B-DA5B-4EE1-AEDB-66403DCD5AE5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEo5W+lyPTMTkLWJVjGsLcqzX23usFAmOr7zUACgkQGsLcqzX2
3utf9A//Yr/0rASWXyeNSGvowh8jtJLPNWwcaVEf2xb6/CD6zDXRvwPcTqtbSb+y
ldqt/skZJ4wFPBC2PAmOBXC5cmWNhNXuDWGWwlePtyuOghdwHwTFH7kB5Dk7m4wy
b0m50cTp859qhykWFcPC4pAWgW6Z2J+l2oYX16CUkwJK6briZmdSS7UdW9JGHqSx
s8vx3772q9CadE4NQWENlzqFAxcZ46nble/SXt2RUmKox2YzuP5EZkm7bGwPEuEE
qbRxKuL3RXIiEUrYLNakTPA8g2mZ6hO6LyogGmJ5vsD/7Lyrs2GU2dn2CvkfpwjF
91ic3q8/yju/z7L50+5sbHfHuKI8gzONVVOGcZo0nd0bkyNPoWOceiW6gFluA+52
0ws+XoOW03UkcpvRzPiTQ9ap9VaHJzEPz9B/AcM4N4zR8RICXr1hbKhBnHByoaRV
MjUKU/QvVxkBbDinD7ij1Buaw4sUbZnCMkPW/jEPviFC6grxm+V/D3LNN+y73DPI
j1ZXUKpl72/ujQ9cIJK339EvrBkSUnac/idybcncN++47yZHMyNaLczbOwAyx7Pl
gSvlrzEIggtZiD3EFMI6y4nsTimw3u8ALq2lfyxBCoE3vosHiNKLD240a+IikRbq
dFgwFw/2vAu+GEHCsfVcClTHASUAt6fas9oHBVz619zRWTsj6ao=
=mLYb
-----END PGP SIGNATURE-----

--Apple-Mail=_40C9644B-DA5B-4EE1-AEDB-66403DCD5AE5--
