Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3005B657396
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 08:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiL1HUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 02:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiL1HUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 02:20:06 -0500
Received: from mr85p00im-ztdg06011801.me.com (mr85p00im-ztdg06011801.me.com [17.58.23.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21705F038
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 23:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1672212004; bh=h6QXMJKjXRhLN3M3TBsEF+a1iGTF5nwOodBXfKcg/rw=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=YrOY5R0FnmGXU+X8MGGIqdqQMt4FEQTzvV6G/qJ4b6N1QP+2xlMWp5mZh0fTGaFm4
         zxtOLSGrq2+5pEgr3qHbgdoiMYIKmDGLAokeMePHYCmlsHFzCNRpS/mWpJT3yCMxva
         ZaGYBysml2A8e0MQUCA/ykBruMxnnrM4Cwo9JByQi4uUEJAo0R//47c/WUydrcsNcn
         KBr9086S4SVLrtV6wkzNfHuSJ2TFi84+dhSVJN/c9TCKfULN8kDXOsvJwcnzVzyBUy
         oNDPPLAn7Ed9+dc6dnrea4p6hEDwrILL/pV6lLzdCOJWwptU+AYvKeqtgYj8MqlkWF
         w8ybMFzjlbpqQ==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-ztdg06011801.me.com (Postfix) with ESMTPSA id B89129C1CB7;
        Wed, 28 Dec 2022 07:20:03 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.23\))
Subject: Re: [PATCH 6/7] rust: sync: introduce `UniqueArc`
From:   Laine Taffin Altman <alexanderaltman@me.com>
In-Reply-To: <20221228060346.352362-6-wedsonaf@gmail.com>
Date:   Tue, 27 Dec 2022 23:19:52 -0800
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <792D12DA-73F0-4218-B0E1-7A0D8C235C21@me.com>
References: <20221228060346.352362-1-wedsonaf@gmail.com>
 <20221228060346.352362-6-wedsonaf@gmail.com>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
X-Mailer: Apple Mail (2.3731.400.23)
X-Proofpoint-GUID: DBm9ilUyzi5etzvJXVSIrCyBbuFE_PWX
X-Proofpoint-ORIG-GUID: DBm9ilUyzi5etzvJXVSIrCyBbuFE_PWX
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2212280058
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 27, 2022, at 10:03 PM, Wedson Almeida Filho =
<wedsonaf@gmail.com> wrote:
>=20
> Since `Arc<T>` does not allow mutating `T` directly (i.e., without =
inner
> mutability), it is currently not possible to do some initialisation of
> `T` post construction but before being shared.
>=20
> `UniqueArc<T>` addresses this problem essentially being an `Arc<T>` =
that
> has a refcount of 1 and is therefore writable. Once initialisation is
> completed, it can be transitioned (without failure paths) into an
> `Arc<T>`.
>=20
> Suggested-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> ---
> rust/kernel/sync.rs     |   2 +-
> rust/kernel/sync/arc.rs | 152 +++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 151 insertions(+), 3 deletions(-)
>=20
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 5de03ea83ea1..33da23e3076d 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -7,4 +7,4 @@
>=20
> mod arc;
>=20
> -pub use arc::{Arc, ArcBorrow};
> +pub use arc::{Arc, ArcBorrow, UniqueArc};
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 84f31c85a513..832bafc74a90 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -19,8 +19,9 @@ use crate::{bindings, error::Result, types::Opaque};
> use alloc::boxed::Box;
> use core::{
>     marker::{PhantomData, Unsize},
> -    mem::ManuallyDrop,
> -    ops::Deref,
> +    mem::{ManuallyDrop, MaybeUninit},
> +    ops::{Deref, DerefMut},
> +    pin::Pin,
>     ptr::NonNull,
> };
>=20
> @@ -222,6 +223,19 @@ impl<T: ?Sized> Drop for Arc<T> {
>     }
> }
>=20
> +impl<T: ?Sized> From<UniqueArc<T>> for Arc<T> {
> +    fn from(item: UniqueArc<T>) -> Self {
> +        item.inner
> +    }
> +}
> +
> +impl<T: ?Sized> From<Pin<UniqueArc<T>>> for Arc<T> {
> +    fn from(item: Pin<UniqueArc<T>>) -> Self {
> +        // SAFETY: The type invariants of `Arc` guarantee that the =
data is pinned.
> +        unsafe { Pin::into_inner_unchecked(item).inner }
> +    }
> +}
> +
> /// A borrowed reference to an [`Arc`] instance.
> ///
> /// For cases when one doesn't ever need to increment the refcount on =
the allocation, it is simpler
> @@ -328,3 +342,137 @@ impl<T: ?Sized> Deref for ArcBorrow<'_, T> {
>         unsafe { &self.inner.as_ref().data }
>     }
> }
> +
> +/// A refcounted object that is known to have a refcount of 1.
> +///
> +/// It is mutable and can be converted to an [`Arc`] so that it can =
be shared.
> +///
> +/// # Invariants
> +///
> +/// `inner` always has a reference count of 1.
> +///
> +/// # Examples
> +///
> +/// In the following example, we make changes to the inner object =
before turning it into an
> +/// `Arc<Test>` object (after which point, it cannot be mutated =
directly). Note that `x.into()`
> +/// cannot fail.
> +///
> +/// ```
> +/// use kernel::sync::{Arc, UniqueArc};
> +///
> +/// struct Example {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// fn test() -> Result<Arc<Example>> {
> +///     let mut x =3D UniqueArc::try_new(Example { a: 10, b: 20 })?;
> +///     x.a +=3D 1;
> +///     x.b +=3D 1;
> +///     Ok(x.into())
> +/// }
> +///
> +/// # test().unwrap();
> +/// ```
> +///
> +/// In the following example we first allocate memory for a =
ref-counted `Example` but we don't
> +/// initialise it on allocation. We do initialise it later with a =
call to [`UniqueArc::write`],
> +/// followed by a conversion to `Arc<Example>`. This is particularly =
useful when allocation happens
> +/// in one context (e.g., sleepable) and initialisation in another =
(e.g., atomic):
> +///
> +/// ```
> +/// use kernel::sync::{Arc, UniqueArc};
> +///
> +/// struct Example {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// fn test() -> Result<Arc<Example>> {
> +///     let x =3D UniqueArc::try_new_uninit()?;
> +///     Ok(x.write(Example { a: 10, b: 20 }).into())
> +/// }
> +///
> +/// # test().unwrap();
> +/// ```
> +///
> +/// In the last example below, the caller gets a pinned instance of =
`Example` while converting to
> +/// `Arc<Example>`; this is useful in scenarios where one needs a =
pinned reference during
> +/// initialisation, for example, when initialising fields that are =
wrapped in locks.
> +///
> +/// ```
> +/// use kernel::sync::{Arc, UniqueArc};
> +///
> +/// struct Example {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// fn test() -> Result<Arc<Example>> {
> +///     let mut pinned =3D Pin::from(UniqueArc::try_new(Example { a: =
10, b: 20 })?);
> +///     // We can modify `pinned` because it is `Unpin`.
> +///     pinned.as_mut().a +=3D 1;
> +///     Ok(pinned.into())
> +/// }
> +///
> +/// # test().unwrap();
> +/// ```
> +pub struct UniqueArc<T: ?Sized> {
> +    inner: Arc<T>,
> +}
> +
> +impl<T> UniqueArc<T> {
> +    /// Tries to allocate a new [`UniqueArc`] instance.
> +    pub fn try_new(value: T) -> Result<Self> {
> +        Ok(Self {
> +            // INVARIANT: The newly-created object has a ref-count of =
1.
> +            inner: Arc::try_new(value)?,
> +        })
> +    }
> +
> +    /// Tries to allocate a new [`UniqueArc`] instance whose contents =
are not initialised yet.
> +    pub fn try_new_uninit() -> Result<UniqueArc<MaybeUninit<T>>> {
> +        Ok(UniqueArc::<MaybeUninit<T>> {
> +            // INVARIANT: The newly-created object has a ref-count of =
1.
> +            inner: Arc::try_new(MaybeUninit::uninit())?,
> +        })
> +    }
> +}
> +
> +impl<T> UniqueArc<MaybeUninit<T>> {
> +    /// Converts a `UniqueArc<MaybeUninit<T>>` into a `UniqueArc<T>` =
by writing a value into it.
> +    pub fn write(mut self, value: T) -> UniqueArc<T> {
> +        self.deref_mut().write(value);
> +        let inner =3D ManuallyDrop::new(self).inner.ptr;
> +        UniqueArc {
> +            // SAFETY: The new `Arc` is taking over `ptr` from =
`self.inner` (which won't be
> +            // dropped). The types are compatible because =
`MaybeUninit<T>` is compatible with `T`.
> +            inner: unsafe { Arc::from_inner(inner.cast()) },
> +        }
> +    }
> +}
> +
> +impl<T: ?Sized> From<UniqueArc<T>> for Pin<UniqueArc<T>> {
> +    fn from(obj: UniqueArc<T>) -> Self {
> +        // SAFETY: It is not possible to move/replace `T` inside a =
`Pin<UniqueArc<T>>` (unless `T`

Minor nit:  `Pin<UniqueArc<T>>` in this comment should just be =
`UniqueArc<T>`.

> +        // is `Unpin`), so it is ok to convert it to =
`Pin<UniqueArc<T>>`.
> +        unsafe { Pin::new_unchecked(obj) }
> +    }
> +}
> +
> +impl<T: ?Sized> Deref for UniqueArc<T> {
> +    type Target =3D T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        self.inner.deref()
> +    }
> +}
> +
> +impl<T: ?Sized> DerefMut for UniqueArc<T> {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        // SAFETY: By the `Arc` type invariant, there is necessarily =
a reference to the object, so
> +        // it is safe to dereference it. Additionally, we know there =
is only one reference when
> +        // it's inside a `UniqueArc`, so it is safe to get a mutable =
reference.
> +        unsafe { &mut self.inner.ptr.as_mut().data }
> +    }
> +}
> --=20
> 2.34.1
>=20
>=20

=E2=80=94 Laine Taffin Altman

