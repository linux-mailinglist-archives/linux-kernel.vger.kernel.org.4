Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A3D6884D8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjBBQxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjBBQxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:53:31 -0500
Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EFF6CCAC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:53:30 -0800 (PST)
Date:   Thu, 02 Feb 2023 16:53:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1675356808; x=1675616008;
        bh=CRMJsATKjRLIzIk/IM3Ofjd8VrM0+8WEYA35gsWakuk=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=OXYNP3hMhVDDNwxrF896QybQNZ5DyNssvDLLZ4ebhM5uypiDqD2WwqYVUTXk/MhdU
         bMz98dX6tYPjSj09JSG1HiwTABKa7VIEYWTHOYvdDrSnLifUvwo3kRqQr0I7k9KgHf
         Xud3Pn5RUhbwq+2mwrSbOFifYQRMQy9XBg8+vJhfjG2wvxImw+VhJWoawci64ZHLjB
         M5MP+zThXGxcKUHBctuN8VcfQ66xCURRTSr3ZbOe2WVaoffFUiaA8xI0iFe3l1G+st
         BkoA+YjaAtllTxKTPdiKPTOmvDT0GFjq4SerRWew8u5iqmUY8mJLZsALTOqwsNW9yF
         7UrX5eh7zlUbg==
To:     Boqun Feng <boqun.feng@gmail.com>
From:   =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: Re: [RFC 3/5] rust: sync: Arc: Introduces Arc::get_inner() helper
Message-ID: <Hoc5Wk4Qi6ck20o1sqzOAXf0p01Ntezl4V2PxizHTorqRdDFeoWnlnWIpsu-nrom3U7EWiLC0KUfatrF18yjh5EiOThk3MBXGFraN8zycPI=@protonmail.com>
In-Reply-To: <20230201232244.212908-4-boqun.feng@gmail.com>
References: <20230201232244.212908-1-boqun.feng@gmail.com> <20230201232244.212908-4-boqun.feng@gmail.com>
Feedback-ID: 27884398:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 2nd, 2023 at 00:22, Boqun Feng <boqun.feng@gmail.com>=
 wrote:


> Getting a `&ArcInner<T>` should always be safe from a `Arc<T>`,
>=20
> therefore add this helper function to avoid duplicate unsafe
> `ptr.as_ref()`.
>=20
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>

> ---
>  rust/kernel/sync/arc.rs | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index fbfceaa3096e..4d8de20c996f 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -201,6 +201,13 @@ impl<T: ?Sized> Arc<T> {
>          // reference can be created.
>          unsafe { ArcBorrow::new(self.ptr) }
>      }
> +
> +    /// Returns a reference to the internal [`ArcInner`].
> +    fn get_inner(&self) -> &ArcInner<T> {
> +        // SAFETY: By the type invariant, there is necessarily a referen=
ce to the object, so it is
> +        // safe to dereference it.
> +        unsafe { self.ptr.as_ref() }
> +    }
>  }
>=20
>  impl<T: 'static> ForeignOwnable for Arc<T> {
> @@ -233,9 +240,7 @@ impl<T: ?Sized> Deref for Arc<T> {
>      type Target =3D T;
>=20
>      fn deref(&self) -> &Self::Target {
> -        // SAFETY: By the type invariant, there is necessarily a referen=
ce to the object, so it is
> -        // safe to dereference it.
> -        unsafe { &self.ptr.as_ref().data }
> +        &self.get_inner().data
>      }
>  }
>=20
> @@ -244,7 +249,7 @@ impl<T: ?Sized> Clone for Arc<T> {
>          // INVARIANT: C `refcount_inc` saturates the refcount, so it can=
not overflow to zero.
>          // SAFETY: By the type invariant, there is necessarily a referen=
ce to the object, so it is
>          // safe to increment the refcount.
> -        unsafe { bindings::refcount_inc(self.ptr.as_ref().refcount.get()=
) };
> +        unsafe { bindings::refcount_inc(self.get_inner().refcount.get())=
 };
>=20
>          // SAFETY: We just incremented the refcount. This increment is n=
ow owned by the new `Arc`.
>          unsafe { Self::from_inner(self.ptr) }
> @@ -253,11 +258,7 @@ impl<T: ?Sized> Clone for Arc<T> {
>=20
>  impl<T: ?Sized> Drop for Arc<T> {
>      fn drop(&mut self) {
> -        // SAFETY: By the type invariant, there is necessarily a referen=
ce to the object. We cannot
> -        // touch `refcount` after it's decremented to a non-zero value b=
ecause another thread/CPU
> -        // may concurrently decrement it to zero and free it. It is ok t=
o have a raw pointer to
> -        // freed/invalid memory as long as it is never dereferenced.
> -        let refcount =3D unsafe { self.ptr.as_ref() }.refcount.get();
> +        let refcount =3D self.get_inner().refcount.get();
>=20
>          // INVARIANT: If the refcount reaches zero, there are no other i=
nstances of `Arc`, and
>          // this instance is being dropped, so the broken invariant is no=
t observable.
> --
> 2.39.1
