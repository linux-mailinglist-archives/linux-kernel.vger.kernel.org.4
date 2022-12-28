Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6AB657390
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 08:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiL1HQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 02:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiL1HPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 02:15:55 -0500
Received: from mr85p00im-ztdg06021201.me.com (mr85p00im-ztdg06021201.me.com [17.58.23.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FE6F03E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 23:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1672211753; bh=8YW4spCKwQ7dhxTiCP+x19c0TJOKw29VidZ2+hBMIC0=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=etF/bD2yHwq0axtvhlhyt4dxZsD6nW89N/xzPNIS5/DyIx9WNX0i9HfIK4wG/tshM
         53PAydnQoDbXpz9qAzMzY1wODx787fdwktqmO8YA1x66+LCVNwdQvkEPBG+bFpQOp5
         3ri14/49xywLSeYjkOiT+5J32ibg9iq07DTfXdD9EsjmzAWbai+dhfT+Uy38k5xDlr
         TE46x2ytgkHzjDpga2VUY6ds51aYgsFaWLsvBM5fHIUiVcFAxQdni8Es2VNPz1ZuBl
         WJ+vOtw+Xde8QCKrmjqEgJvXesj7AGHAHMntUGVkb88PbNyqg4qusXZv8lI5TAsbNC
         P/vRj0uUvEppg==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-ztdg06021201.me.com (Postfix) with ESMTPSA id E0062321231;
        Wed, 28 Dec 2022 07:15:52 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.23\))
Subject: Re: [PATCH 4/7] rust: sync: introduce `ArcBorrow`
From:   Laine Taffin Altman <alexanderaltman@me.com>
In-Reply-To: <20221228060346.352362-4-wedsonaf@gmail.com>
Date:   Tue, 27 Dec 2022 23:15:41 -0800
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2ED9BF63-43FC-4669-BA19-47E8D209E8A6@me.com>
References: <20221228060346.352362-1-wedsonaf@gmail.com>
 <20221228060346.352362-4-wedsonaf@gmail.com>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
X-Mailer: Apple Mail (2.3731.400.23)
X-Proofpoint-GUID: oziFp2iBiyJaaZe6P7YiyFg063_KZ96S
X-Proofpoint-ORIG-GUID: oziFp2iBiyJaaZe6P7YiyFg063_KZ96S
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.816,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-18=5F01:2020-02-14=5F02,2022-01-18=5F01,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=777 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2212280058
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 27, 2022, at 10:03 PM, Wedson Almeida Filho <wedsonaf@gmail.com> =
wrote:
> This allows us to create references to a ref-counted allocation =
without
> double-indirection and that still allow us to increment the refcount =
to
> a new `Arc<T>`.
>=20
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> ---
> rust/kernel/sync.rs     |  2 +-
> rust/kernel/sync/arc.rs | 97 +++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 98 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 39b379dd548f..5de03ea83ea1 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -7,4 +7,4 @@
>=20
> mod arc;
>=20
> -pub use arc::Arc;
> +pub use arc::{Arc, ArcBorrow};
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index dbc7596cc3ce..f68bfc02c81a 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -19,6 +19,7 @@ use crate::{bindings, error::Result, types::Opaque};
> use alloc::boxed::Box;
> use core::{
>     marker::{PhantomData, Unsize},
> +    mem::ManuallyDrop,
>     ops::Deref,
>     ptr::NonNull,
> };
> @@ -164,6 +165,18 @@ impl<T: ?Sized> Arc<T> {
>             _p: PhantomData,
>         }
>     }
> +
> +    /// Returns an [`ArcBorrow`] from the given [`Arc`].
> +    ///
> +    /// This is useful when the argument of a function call is an =
[`ArcBorrow`] (e.g., in a method
> +    /// receiver), but we have an [`Arc`] instead. Getting an =
[`ArcBorrow`] is free when optimised.
> +    #[inline]
> +    pub fn as_arc_borrow(&self) -> ArcBorrow<'_, T> {
> +        // SAFETY: The constraint that the lifetime of the shared =
reference must outlive that of
> +        // the returned `ArcBorrow` ensures that the object remains =
alive and that no mutable
> +        // reference can be created.
> +        unsafe { ArcBorrow::new(self.ptr) }
> +    }
> }
>=20
> impl<T: ?Sized> Deref for Arc<T> {
> @@ -208,3 +221,87 @@ impl<T: ?Sized> Drop for Arc<T> {
>         }
>     }
> }
> +
> +/// A borrowed reference to an [`Arc`] instance.
> +///
> +/// For cases when one doesn't ever need to increment the refcount on =
the allocation, it is simpler
> +/// to use just `&T`, which we can trivially get from an `Arc<T>` =
instance.
> +///
> +/// However, when one may need to increment the refcount, it is =
preferable to use an `ArcBorrow<T>`
> +/// over `&Arc<T>` because the latter results in a =
double-indirection: a pointer (shared reference)
> +/// to a pointer (`Arc<T>`) to the object (`T`). An [`ArcBorrow`] =
eliminates this double
> +/// indirection while still allowing one to increment the refcount =
and getting an `Arc<T>` when/if
> +/// needed.
> +///
> +/// # Invariants
> +///
> +/// There are no mutable references to the underlying [`Arc`], and it =
remains valid for the
> +/// lifetime of the [`ArcBorrow`] instance.
> +///
> +/// # Example
> +///
> +/// ```
> +/// use crate::sync::{Arc, ArcBorrow};
> +///
> +/// struct Example;
> +///
> +/// fn do_something(e: ArcBorrow<'_, Example>) -> Arc<Example> {
> +///     e.into()
> +/// }
> +///
> +/// let obj =3D Arc::try_new(Example)?;
> +/// let cloned =3D do_something(obj.as_arc_borrow());
> +///
> +/// // Assert that both `obj` and `cloned` point to the same =
underlying object.
> +/// assert!(core::ptr::eq(&*obj, &*cloned));
> +/// ```
> +pub struct ArcBorrow<'a, T: ?Sized + 'a> {
> +    inner: NonNull<ArcInner<T>>,
> +    _p: PhantomData<&'a ()>,
> +}
> +
> +impl<T: ?Sized> Clone for ArcBorrow<'_, T> {
> +    fn clone(&self) -> Self {
> +        *self
> +    }
> +}
> +
> +impl<T: ?Sized> Copy for ArcBorrow<'_, T> {}
> +
> +impl<T: ?Sized> ArcBorrow<'_, T> {
> +    /// Creates a new [`ArcBorrow`] instance.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure the following for the lifetime of the =
returned [`ArcBorrow`] instance:
> +    /// 1. That `inner` remains valid;
> +    /// 2. That no mutable references to `inner` are created.
> +    unsafe fn new(inner: NonNull<ArcInner<T>>) -> Self {
> +        // INVARIANT: The safety requirements guarantee the =
invariants.
> +        Self {
> +            inner,
> +            _p: PhantomData,
> +        }
> +    }
> +}
> +
> +impl<T: ?Sized> From<ArcBorrow<'_, T>> for Arc<T> {
> +    fn from(b: ArcBorrow<'_, T>) -> Self {
> +        // SAFETY: The existence of `b` guarantees that the refcount =
is non-zero. `ManuallyDrop`
> +        // guarantees that `drop` isn't called, so it's ok that the =
temporary `Arc` doesn't own the
> +        // increment.
> +        ManuallyDrop::new(unsafe { Arc::from_inner(b.inner) })
> +            .deref()
> +            .clone()

The same worries about safety apply here too.  You need to make this =
fallible=E2=80=94try_from is nice enough for that.

> +    }
> +}
> +
> +impl<T: ?Sized> Deref for ArcBorrow<'_, T> {
> +    type Target =3D T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: By the type invariant, the underlying object is =
still alive with no mutable
> +        // references to it, so it is safe to create a shared =
reference.
> +        unsafe { &self.inner.as_ref().data }
> +    }
> +}
> --=20
> 2.34.1
>=20
>=20

=E2=80=94 Laine Taffin Altman

