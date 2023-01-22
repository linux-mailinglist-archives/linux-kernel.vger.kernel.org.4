Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38228676B4F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 07:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjAVGez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 01:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVGex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 01:34:53 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719B421A2E;
        Sat, 21 Jan 2023 22:34:52 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-15fe106c7c7so4768008fac.8;
        Sat, 21 Jan 2023 22:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hjbzVjhCY8YZ/A5RPkClWyob4cGDtlGmsyktX8xQAZ0=;
        b=AI6O02MNsnkNbUUz6zhYWmTclgFQrnfCV5+L6Vj/Xeiir+ga8LrWi6L00msyn6Sswq
         87eWHCa9yYhGGsLT17C3P1dKVE23mXAHHC7oqz6pCfvAkkW5FRNsy90C5W0YiJRbcdHI
         i7f5vc4lqAUvkrTXCyj2akJEGNA+Epq4xUlEXHfkPkndapu1KxzFLBR6u9F0WsSFnnYH
         aTox+O+mLBtedIfYt59man9DlzfT/CctiOMj5prE8JJlee7wjTH2TxV96vWePwEIauxg
         ilCoOGA0NWwuNZTHs7FMfjSmMVFp8+LRLo1u6O4ebdr+ChWMEwLX8nxBM88Sd/QvqJ67
         sqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hjbzVjhCY8YZ/A5RPkClWyob4cGDtlGmsyktX8xQAZ0=;
        b=lPI6FnmWvgAb/qbeznJS5Erz2bfg2MZkJBjT5yQWF9jbm1t8cU9eSC0tjHtc+9xWrf
         6jk11UvlZpkh5vlDA8HZ+f/ajjOjAIrWQrpKU6k2jBm9KljUhntsuTAv8CR8pk48OXCW
         PdA14alJnVdiWWWR5q1XWglpLKXgwPf22rk5NwwDuPAv80X3Bhw9D+a3amVJTrq7tl5/
         CO0jF73Ada6D1JYJQkF9goI0NsemC3Az3vvYbWGu36ydiROcb6N0lMWwzXb09lEyadLj
         Yl5AmnIB3UzzrirYApcgR2aR2HJBD6vTJZxPeYgjN9CPFXaX7zC01MC3TxBgJ/udXzyL
         GgAw==
X-Gm-Message-State: AFqh2ko1M8/Z1fZCtcNpeSjHHTw4aKs66hww3EoOEQaAlYOl5dZWi9/H
        cNMcZV4CB01mKZW4zrP4h/A9hkdz+9sQ/v5Qi2E=
X-Google-Smtp-Source: AMrXdXvPVE3mgOcGMtyP3N6SPAH94rkHKLwREC3iSk4xBoqg3lNWuJJnjXb4pfGcEJhpxoo8L2VoLmWsaRxBWFiKSnI=
X-Received: by 2002:a05:6870:5d93:b0:15e:ca6a:913 with SMTP id
 fu19-20020a0568705d9300b0015eca6a0913mr1780711oab.204.1674369291740; Sat, 21
 Jan 2023 22:34:51 -0800 (PST)
MIME-Version: 1.0
References: <20230119174036.64046-1-wedsonaf@gmail.com> <20230119174036.64046-2-wedsonaf@gmail.com>
 <Y8ryoTYIKpYtuqow@boqun-archlinux>
In-Reply-To: <Y8ryoTYIKpYtuqow@boqun-archlinux>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Sun, 22 Jan 2023 03:34:40 -0300
Message-ID: <CANeycqp8-S3fb1YF=mj6BzWLytCTTH1ihir_OmhGG7u6mkPkvQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] rust: types: introduce `ForeignOwnable`
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023 at 16:59, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Thu, Jan 19, 2023 at 02:40:33PM -0300, Wedson Almeida Filho wrote:
> > It was originally called `PointerWrapper`. It is used to convert
> > a Rust object to a pointer representation (void *) that can be
> > stored on the C side, used, and eventually returned to Rust.
> >
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > ---
> >  rust/kernel/lib.rs   |  1 +
> >  rust/kernel/types.rs | 54 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 55 insertions(+)
> >
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index e0b0e953907d..223564f9f0cc 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -16,6 +16,7 @@
> >  #![feature(coerce_unsized)]
> >  #![feature(core_ffi_c)]
> >  #![feature(dispatch_from_dyn)]
> > +#![feature(generic_associated_types)]
> >  #![feature(receiver_trait)]
> >  #![feature(unsize)]
> >
> > diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> > index f0ad4472292d..5475f6163002 100644
> > --- a/rust/kernel/types.rs
> > +++ b/rust/kernel/types.rs
> > @@ -9,6 +9,60 @@ use core::{
> >      ops::{Deref, DerefMut},
> >  };
> >
> > +/// Used to transfer ownership to and from foreign (non-Rust) languages.
> > +///
> > +/// Ownership is transferred from Rust to a foreign language by calling [`Self::into_foreign`] and
> > +/// later may be transferred back to Rust by calling [`Self::from_foreign`].
> > +///
> > +/// This trait is meant to be used in cases when Rust objects are stored in C objects and
> > +/// eventually "freed" back to Rust.
> > +pub trait ForeignOwnable {
> > +    /// Type of values borrowed between calls to [`ForeignOwnable::into_foreign`] and
> > +    /// [`ForeignOwnable::from_foreign`].
> > +    type Borrowed<'a>;
> > +
> > +    /// Converts a Rust-owned object to a foreign-owned one.
> > +    ///
> > +    /// The foreign representation is a pointer to void.
> > +    fn into_foreign(self) -> *const core::ffi::c_void;
> > +
> > +    /// Borrows a foreign-owned object.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
> > +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
> > +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow_mut`]
> > +    /// for this object must have been dropped.
> > +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrowed<'a>;
> > +
> > +    /// Mutably borrows a foreign-owned object.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
> > +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
> > +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] and
> > +    /// [`ForeignOwnable::borrow_mut`] for this object must have been dropped.
> > +    unsafe fn borrow_mut<T: ForeignOwnable>(ptr: *const core::ffi::c_void) -> ScopeGuard<T, fn(T)> {
> > +        // SAFETY: The safety requirements ensure that `ptr` came from a previous call to
> > +        // `into_foreign`.
> > +        ScopeGuard::new_with_data(unsafe { T::from_foreign(ptr) }, |d| {
> > +            d.into_foreign();
> > +        })
>
> I kinda want to suggest borrow_mut() to be implemented as:
>
>     pub trait ForeignOwnable {
>         ...
>         unsafe fn borrow_mut(ptr: *const core::ffi::c_void) -> ScopeGuard<Self, fn(Self)> {
>             // SAFETY: The safety requirements ensure that `ptr` came from a previous call to
>             // `into_foreign`.
>             ScopeGuard::new_with_data(unsafe { Self::from_foreign(ptr) }, |d| {
>                 d.into_foreign();
>             })
>     }

Oh, eliminate the generic type `T` and just use `Self`. Yes, I think
that's a good simplification.

>
> to avoid funny code as follow:
>
>         let a = Box::new(0).into_foreign();
>         // Using an irrelevant `impl ForeignOwnable` to `borrow_mut`
>         let borrowed_a: ScopeGuard<Box<i32>, ...> = unsafe { Arc::<u64>::borrow_mut(a) };
>
> but that requires `Self: Sized`. Is it too restrictive?

It isn't. Since we want the raw pointer to fit in a single pointer
(from C's perspective), we already require `Self: Sized`.

I'll make this change in v2.

>
> Regards,
> Boqun
>
> > +    }
> > +
> > +    /// Converts a foreign-owned object back to a Rust-owned one.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
> > +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
> > +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] and
> > +    /// [`ForeignOwnable::borrow_mut`] for this object must have been dropped.
> > +    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self;
> > +}
> > +
> >  /// Runs a cleanup function/closure when dropped.
> >  ///
> >  /// The [`ScopeGuard::dismiss`] function prevents the cleanup function from running.
> > --
> > 2.34.1
> >
