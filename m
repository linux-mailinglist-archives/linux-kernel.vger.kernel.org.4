Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB1765D73D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbjADPaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjADPaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:30:02 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A83A140DC;
        Wed,  4 Jan 2023 07:30:00 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-14455716674so40201201fac.7;
        Wed, 04 Jan 2023 07:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NfxHydJ7vcXPQ6fPlrgCpC4AEcwL+rcytzyr1+pnLIg=;
        b=jT+L3srWh2ZYUIkORPbrT1bXHkvtAhHuHovU35juyFt8hH9nhwxjFiU6ZTmvorFBcR
         +CzjVpknBEhnaKh9qktPb0sFyoyqw+NLZwPBIQbrG1qgfYoeeSQBisd5lbFT28EyzBBW
         1ajUawTyh6TWJTdCR/eu2/XEnb51oUqr2n7/Y3tIPchP4h+cZvG6oIS2DFB92uzQ4AzY
         M0GDp4FhkzPneogxygdw//PlaSpZ+2ZiIZF7IE5rfy5wE9ci2p/ij1kJ4s9vcUIHHOAz
         6OqqvC9gy50/AbqMQRlMwHdzxj0DeL+ROze8Z1RYvhWgTMCeKgv6K1v2FIh2woGL5qiF
         lL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NfxHydJ7vcXPQ6fPlrgCpC4AEcwL+rcytzyr1+pnLIg=;
        b=Wyk6bDpcAg72qgm84zhxEaDomsgwEtEX/tMEwaN6DbPGT6E8nTnLeWLknnwARgSE6P
         GcHu3c0Ep3l47seDMm8jEKjlbdz88vR3XyF7B1RUF/luuipedpGSnQAxX3y+ZZDwiEYn
         aU275BBaX5DurutiB29QG8/U+/ihldG+C9ZpJmYNRpY9sPKzza25H9DcneI+0a5wZNo+
         QJZU4l3EJ84jmF32Nn97Ukpr8xfFFzwPV7Td4FwmgAizOJualUfSN348PFsySv4q9ltb
         8qpJPIvUSkXBMW4/MVvSNlMXrQgBVbTOCYFmk3k4s+I0zg4oFlcvCVE0xxHb2BKB4Ptm
         Ozmg==
X-Gm-Message-State: AFqh2krBmjojYJKJ1svZrpGhphmgRjrXGcciFHkvSikces57QpwzuHx+
        UI3WGq0jA42F/OWx+vHTBnf+8S1pV7HQD0r5Z9I=
X-Google-Smtp-Source: AMrXdXthknk47AJCyahPlWiZVEC7YmaqDThEZmJspP8DPwuElsiR+5+3izzwlJdC3q3+FZgOVzhT8imOUbmeltiLt2E=
X-Received: by 2002:a05:6870:ac10:b0:144:bf10:eecd with SMTP id
 kw16-20020a056870ac1000b00144bf10eecdmr3762840oab.204.1672846199424; Wed, 04
 Jan 2023 07:29:59 -0800 (PST)
MIME-Version: 1.0
References: <20221228060346.352362-1-wedsonaf@gmail.com> <20221228060346.352362-4-wedsonaf@gmail.com>
 <20221231194352.55cf0a26.gary@garyguo.net>
In-Reply-To: <20221231194352.55cf0a26.gary@garyguo.net>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Wed, 4 Jan 2023 15:29:48 +0000
Message-ID: <CANeycqrVsbNJ+A+A26LXkBezBNUHvnZU2Q3_whexCwwG5ZcgPQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] rust: sync: introduce `ArcBorrow`
To:     Gary Guo <gary@garyguo.net>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Dec 2022 at 19:43, Gary Guo <gary@garyguo.net> wrote:
>
> On Wed, 28 Dec 2022 06:03:43 +0000
> Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
>
> > This allows us to create references to a ref-counted allocation without
> > double-indirection and that still allow us to increment the refcount to
> > a new `Arc<T>`.
> >
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > ---
> >  rust/kernel/sync.rs     |  2 +-
> >  rust/kernel/sync/arc.rs | 97 +++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 98 insertions(+), 1 deletion(-)
> >
> > diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> > index 39b379dd548f..5de03ea83ea1 100644
> > --- a/rust/kernel/sync.rs
> > +++ b/rust/kernel/sync.rs
> > @@ -7,4 +7,4 @@
> >
> >  mod arc;
> >
> > -pub use arc::Arc;
> > +pub use arc::{Arc, ArcBorrow};
> > diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> > index dbc7596cc3ce..f68bfc02c81a 100644
> > --- a/rust/kernel/sync/arc.rs
> > +++ b/rust/kernel/sync/arc.rs
> > @@ -19,6 +19,7 @@ use crate::{bindings, error::Result, types::Opaque};
> >  use alloc::boxed::Box;
> >  use core::{
> >      marker::{PhantomData, Unsize},
> > +    mem::ManuallyDrop,
> >      ops::Deref,
> >      ptr::NonNull,
> >  };
> > @@ -164,6 +165,18 @@ impl<T: ?Sized> Arc<T> {
> >              _p: PhantomData,
> >          }
> >      }
> > +
> > +    /// Returns an [`ArcBorrow`] from the given [`Arc`].
> > +    ///
> > +    /// This is useful when the argument of a function call is an [`ArcBorrow`] (e.g., in a method
> > +    /// receiver), but we have an [`Arc`] instead. Getting an [`ArcBorrow`] is free when optimised.
> > +    #[inline]
> > +    pub fn as_arc_borrow(&self) -> ArcBorrow<'_, T> {
> > +        // SAFETY: The constraint that the lifetime of the shared reference must outlive that of
> > +        // the returned `ArcBorrow` ensures that the object remains alive and that no mutable
> > +        // reference can be created.
> > +        unsafe { ArcBorrow::new(self.ptr) }
> > +    }
> >  }
> >
> >  impl<T: ?Sized> Deref for Arc<T> {
> > @@ -208,3 +221,87 @@ impl<T: ?Sized> Drop for Arc<T> {
> >          }
> >      }
> >  }
> > +
> > +/// A borrowed reference to an [`Arc`] instance.
> > +///
> > +/// For cases when one doesn't ever need to increment the refcount on the allocation, it is simpler
> > +/// to use just `&T`, which we can trivially get from an `Arc<T>` instance.
> > +///
> > +/// However, when one may need to increment the refcount, it is preferable to use an `ArcBorrow<T>`
> > +/// over `&Arc<T>` because the latter results in a double-indirection: a pointer (shared reference)
> > +/// to a pointer (`Arc<T>`) to the object (`T`). An [`ArcBorrow`] eliminates this double
> > +/// indirection while still allowing one to increment the refcount and getting an `Arc<T>` when/if
> > +/// needed.
> > +///
> > +/// # Invariants
> > +///
> > +/// There are no mutable references to the underlying [`Arc`], and it remains valid for the
> > +/// lifetime of the [`ArcBorrow`] instance.
> > +///
> > +/// # Example
> > +///
> > +/// ```
> > +/// use crate::sync::{Arc, ArcBorrow};
> > +///
> > +/// struct Example;
> > +///
> > +/// fn do_something(e: ArcBorrow<'_, Example>) -> Arc<Example> {
> > +///     e.into()
> > +/// }
> > +///
> > +/// let obj = Arc::try_new(Example)?;
> > +/// let cloned = do_something(obj.as_arc_borrow());
> > +///
> > +/// // Assert that both `obj` and `cloned` point to the same underlying object.
> > +/// assert!(core::ptr::eq(&*obj, &*cloned));
> > +/// ```
> > +pub struct ArcBorrow<'a, T: ?Sized + 'a> {
> > +    inner: NonNull<ArcInner<T>>,
> > +    _p: PhantomData<&'a ()>,
> > +}
> > +
> > +impl<T: ?Sized> Clone for ArcBorrow<'_, T> {
> > +    fn clone(&self) -> Self {
> > +        *self
> > +    }
> > +}
> > +
> > +impl<T: ?Sized> Copy for ArcBorrow<'_, T> {}
>
> Couldn't this just be derived `Clone` and `Copy`?

Indeed. I'll send a v2 with this.

>
> > +
> > +impl<T: ?Sized> ArcBorrow<'_, T> {
> > +    /// Creates a new [`ArcBorrow`] instance.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure the following for the lifetime of the returned [`ArcBorrow`] instance:
> > +    /// 1. That `inner` remains valid;
> > +    /// 2. That no mutable references to `inner` are created.
> > +    unsafe fn new(inner: NonNull<ArcInner<T>>) -> Self {
> > +        // INVARIANT: The safety requirements guarantee the invariants.
> > +        Self {
> > +            inner,
> > +            _p: PhantomData,
> > +        }
> > +    }
> > +}
> > +
> > +impl<T: ?Sized> From<ArcBorrow<'_, T>> for Arc<T> {
> > +    fn from(b: ArcBorrow<'_, T>) -> Self {
> > +        // SAFETY: The existence of `b` guarantees that the refcount is non-zero. `ManuallyDrop`
> > +        // guarantees that `drop` isn't called, so it's ok that the temporary `Arc` doesn't own the
> > +        // increment.
> > +        ManuallyDrop::new(unsafe { Arc::from_inner(b.inner) })
> > +            .deref()
> > +            .clone()
> > +    }
> > +}
>
> It might be easier to follow if this is jsut `bindings::refcount_inc`
> followed by `Arc::from_inner`?

I'd prefer to keep the interactions with `refcount_t` in `Arc` only so
that we can more easily change it in the future if we so choose.

> > +
> > +impl<T: ?Sized> Deref for ArcBorrow<'_, T> {
> > +    type Target = T;
> > +
> > +    fn deref(&self) -> &Self::Target {
> > +        // SAFETY: By the type invariant, the underlying object is still alive with no mutable
> > +        // references to it, so it is safe to create a shared reference.
> > +        unsafe { &self.inner.as_ref().data }
> > +    }
> > +}
