Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7746B676B4D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 07:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjAVGb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 01:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVGbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 01:31:25 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A2B1E5E3;
        Sat, 21 Jan 2023 22:31:24 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id o66so7858112oia.6;
        Sat, 21 Jan 2023 22:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KBSy9hFuKMUpYaDx9yOTnZrIzQnaQnfxfZMOiVFBsms=;
        b=V/B7ucgrcYDKYz3RfAr72+1S3BN5L8fJL512/Z8CteHhazoUZMI4Wbvo1wpzi94iR4
         FxZVTRxrzYQh5ZcJc6EiYN4vtl8WVFBx89YfrZ8LI/+oSRh6BGFH4X2riAxHh+wmQLbr
         bLZVjGg4tYaSGoHLccn+dG6OcKyHbJJ2QOZCC5ouZLderTzDzGqpWO9wFQasB3KcvOSm
         azpjj8wcvLcLlNDPN7ihTSzxw7s/uSjg1F2pNCSW7Tu8u9eUcTzu1mnRXv3C2/4qJEUi
         y3ZDSBGsrbRcQKST8p5i++HTVY6y60xJXzXlUxm5M/UUnhyhgTyIhyRHHDCBte3hDXmH
         d8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KBSy9hFuKMUpYaDx9yOTnZrIzQnaQnfxfZMOiVFBsms=;
        b=65ipLXrSJTXSRnCZagirbr/fInYaJBlcQXDYPCs1y36x6Bkp+m4a/GdETeVyfwZgre
         MjUKEkCLtypAjYkAxCGAy/GmkD1eBNG4+gqudJmczG3bLyuwtZUbfv6/ex66cIiBbmHn
         odu4Pa4xQ4Ar91REpT336mkECXJYWXRysCf46TENHhpce/dV9HhL8U0csoblf5gYwyNn
         gD0Q+zaJs19m9TBgaC3Tv0Qdck7pYsOmXUP93BL+qrqUvSNay0H+0oZQUQEASlRaLNJv
         EQdGTpQJ5TwtSZDOgrlbvoXCnfV3o5tsp2A7WWT6WyK4YM7sL0uqToaqXIkiZw5WkAUO
         44kQ==
X-Gm-Message-State: AFqh2kqpLpwoGtdwM081bwigzd6i8OOTTNo4Z+OH8AG8lP+bxbl6jzgv
        ZzFopui8XZSrZ/+/AxGiUNHvT+scE4uGqWUcT30=
X-Google-Smtp-Source: AMrXdXv4l2FkJN5p19054A3oXv1zcs9PicyECPzRymyx8T3kNlHNMoevDmWgT6Ptc+cMAJ9n6JpZ+Ry5UkMUIyl/kTs=
X-Received: by 2002:a05:6808:4346:b0:369:e573:3e54 with SMTP id
 dx6-20020a056808434600b00369e5733e54mr904178oib.215.1674369083421; Sat, 21
 Jan 2023 22:31:23 -0800 (PST)
MIME-Version: 1.0
References: <20230119174036.64046-1-wedsonaf@gmail.com> <Y8ozfNAYhuOPgL/7@Boquns-Mac-mini.local>
In-Reply-To: <Y8ozfNAYhuOPgL/7@Boquns-Mac-mini.local>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Sun, 22 Jan 2023 03:31:12 -0300
Message-ID: <CANeycqo3b2+3_156vy+vFUEU=ysxSqpubShQpEL3iOHrAA+ZsA@mail.gmail.com>
Subject: Re: [PATCH 1/5] rust: types: introduce `ScopeGuard`
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

On Fri, 20 Jan 2023 at 03:24, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Thu, Jan 19, 2023 at 02:40:32PM -0300, Wedson Almeida Filho wrote:
> > This allows us to run some code when the guard is dropped (e.g.,
> > implicitly when it goes out of scope). We can also prevent the
> > guard from running by calling its `dismiss()` method.
> >
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > ---
> >  rust/kernel/types.rs | 127 ++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 126 insertions(+), 1 deletion(-)
> >
> > diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> > index e84e51ec9716..f0ad4472292d 100644
> > --- a/rust/kernel/types.rs
> > +++ b/rust/kernel/types.rs
> > @@ -2,7 +2,132 @@
> >
> >  //! Kernel types.
> >
> > -use core::{cell::UnsafeCell, mem::MaybeUninit};
> > +use alloc::boxed::Box;
> > +use core::{
> > +    cell::UnsafeCell,
> > +    mem::MaybeUninit,
> > +    ops::{Deref, DerefMut},
> > +};
> > +
> > +/// Runs a cleanup function/closure when dropped.
> > +///
> > +/// The [`ScopeGuard::dismiss`] function prevents the cleanup function from running.
> > +///
> > +/// # Examples
> > +///
> > +/// In the example below, we have multiple exit paths and we want to log regardless of which one is
> > +/// taken:
> > +/// ```
> > +/// # use kernel::ScopeGuard;
> > +/// fn example1(arg: bool) {
> > +///     let _log = ScopeGuard::new(|| pr_info!("example1 completed\n"));
> > +///
> > +///     if arg {
> > +///         return;
> > +///     }
> > +///
> > +///     pr_info!("Do something...\n");
> > +/// }
> > +///
> > +/// # example1(false);
> > +/// # example1(true);
> > +/// ```
> > +///
> > +/// In the example below, we want to log the same message on all early exits but a different one on
> > +/// the main exit path:
> > +/// ```
> > +/// # use kernel::ScopeGuard;
> > +/// fn example2(arg: bool) {
> > +///     let log = ScopeGuard::new(|| pr_info!("example2 returned early\n"));
> > +///
> > +///     if arg {
> > +///         return;
> > +///     }
> > +///
> > +///     // (Other early returns...)
> > +///
> > +///     log.dismiss();
> > +///     pr_info!("example2 no early return\n");
> > +/// }
> > +///
> > +/// # example2(false);
> > +/// # example2(true);
> > +/// ```
> > +///
> > +/// In the example below, we need a mutable object (the vector) to be accessible within the log
> > +/// function, so we wrap it in the [`ScopeGuard`]:
> > +/// ```
> > +/// # use kernel::ScopeGuard;
> > +/// fn example3(arg: bool) -> Result {
> > +///     let mut vec =
> > +///         ScopeGuard::new_with_data(Vec::new(), |v| pr_info!("vec had {} elements\n", v.len()));
> > +///
> > +///     vec.try_push(10u8)?;
> > +///     if arg {
> > +///         return Ok(());
> > +///     }
> > +///     vec.try_push(20u8)?;
> > +///     Ok(())
> > +/// }
> > +///
> > +/// # assert_eq!(example3(false), Ok(()));
> > +/// # assert_eq!(example3(true), Ok(()));
> > +/// ```
> > +///
> > +/// # Invariants
> > +///
> > +/// The value stored in the struct is nearly always `Some(_)`, except between
> > +/// [`ScopeGuard::dismiss`] and [`ScopeGuard::drop`]: in this case, it will be `None` as the value
> > +/// will have been returned to the caller. Since  [`ScopeGuard::dismiss`] consumes the guard,
> > +/// callers won't be able to use it anymore.
> > +pub struct ScopeGuard<T, F: FnOnce(T)>(Option<(T, F)>);
> > +
> > +impl<T, F: FnOnce(T)> ScopeGuard<T, F> {
> > +    /// Creates a new guarded object wrapping the given data and with the given cleanup function.
> > +    pub fn new_with_data(data: T, cleanup_func: F) -> Self {
> > +        // INVARIANT: The struct is being initialised with `Some(_)`.
> > +        Self(Some((data, cleanup_func)))
> > +    }
> > +
> > +    /// Prevents the cleanup function from running and returns the guarded data.
> > +    pub fn dismiss(mut self) -> T {
> > +        // INVARIANT: This is the exception case in the invariant; it is not visible to callers
> > +        // because this function consumes `self`.
> > +        self.0.take().unwrap().0
> > +    }
> > +}
> > +
> > +impl ScopeGuard<(), Box<dyn FnOnce(())>> {
>
> How about `fn(())` here as a placeholder? I.e
>
>         impl ScopeGuard<(), fn(())>
>

That's simpler, I like it. I'll change this for v2. Thanks!

> Regards,
> Boqun
>
> > +    /// Creates a new guarded object with the given cleanup function.
> > +    pub fn new(cleanup: impl FnOnce()) -> ScopeGuard<(), impl FnOnce(())> {
> > +        ScopeGuard::new_with_data((), move |_| cleanup())
> > +    }
> > +}
> > +
> > +impl<T, F: FnOnce(T)> Deref for ScopeGuard<T, F> {
> > +    type Target = T;
> > +
> > +    fn deref(&self) -> &T {
> > +        // The type invariants guarantee that `unwrap` will succeed.
> > +        &self.0.as_ref().unwrap().0
> > +    }
> > +}
> > +
> > +impl<T, F: FnOnce(T)> DerefMut for ScopeGuard<T, F> {
> > +    fn deref_mut(&mut self) -> &mut T {
> > +        // The type invariants guarantee that `unwrap` will succeed.
> > +        &mut self.0.as_mut().unwrap().0
> > +    }
> > +}
> > +
> > +impl<T, F: FnOnce(T)> Drop for ScopeGuard<T, F> {
> > +    fn drop(&mut self) {
> > +        // Run the cleanup function if one is still present.
> > +        if let Some((data, cleanup)) = self.0.take() {
> > +            cleanup(data)
> > +        }
> > +    }
> > +}
> >
> >  /// Stores an opaque value.
> >  ///
> > --
> > 2.34.1
> >
