Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B4F6BDCAE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 00:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjCPXIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 19:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCPXIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 19:08:31 -0400
Received: from mail-4324.protonmail.ch (mail-4324.protonmail.ch [185.70.43.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481DA1B571;
        Thu, 16 Mar 2023 16:08:30 -0700 (PDT)
Date:   Thu, 16 Mar 2023 23:08:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1679008107; x=1679267307;
        bh=RdJwww2uvpzoysL9F0tXhEGT0GvPdq65lmBm2Zylcbg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ZdWvBT0TeUg6A0ZKKr31UdOcYoYWLttR9awIs6+khWO/kZTZEtRiyk8roZFBBSABp
         a6Yi18rswqADWNghtORfqRR4XtBUx0DVEIxEmhqjuLELmurEg0BxNrrcI/nNNdY+r1
         KzNLD7CHdnOoFs7SV23uzxV3lqUmq9VdCb0G95+HV+9q18E5bzvKFpz+FbC6vsX3C+
         ZTt4SrBN6fzBoo1S2XTZhXpY34cC1UWK8xfS27s1NJgpCdp2c9ff1P0kf46lRllphd
         EGg9kF+b9ZuX/dohR1LWNo1RUnvUctyiPDpT9lngz1Cj8AZ0Ayr/gdgWvrHQWkvFyC
         nqXKOK+E+TW2A==
To:     Gary Guo <gary@garyguo.net>
From:   y86-dev <y86-dev@protonmail.com>
Cc:     "ojeda@kernel.org" <ojeda@kernel.org>,
        "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>,
        "wedsonaf@gmail.com" <wedsonaf@gmail.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v1 2/3] rust: add pin-init API
Message-ID: <mtmuEYnjtcWcHUOLMmGQ35qZ6AhxE7bna6gGB4u1Ldh9MLvSdZT2xKL43LYy71MMNQbwEvkWmUkEOO3HiiNrIgmYvIVjDt1kBVxaBI23ERY=@protonmail.com>
In-Reply-To: <20230316173848.18b45232.gary@garyguo.net>
References: <D0mWM1KEcWLeFa7IIqPygHlXRTD6gRFHvJKaegYzQXo9zTx7YbSpVLeYLFfq53s2S30Wx7v0khkPMOy6Ng5HiNZ5x7TXtOyLB58vUHtq6ro=@protonmail.com> <20230315200722.57487341.gary@garyguo.net> <ct76zcR4JhAXHG90VDfewAmzPJmEHhMvvOf-MejsM_uZsdcsBs9qVLJNYvNvTHOBLlOedgQ4Dm16M2DSDRBIF-olZfq2zp4XboRsCxsm3CA=@protonmail.com> <20230316173848.18b45232.gary@garyguo.net>
Feedback-ID: 40624463:user:proton
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

On Thursday, March 16th, 2023 at 18:38, Gary Guo <gary@garyguo.net> wrote:
> On Thu, 16 Mar 2023 09:38:16 +0000
> y86-dev <y86-dev@protonmail.com> wrote:
>
> > > > +
> > > > +/// Trait facilitating pinned destruction.
> > > > +///
> > > > +/// Use [`pinned_drop`] to implement this trait safely:
> > > > +///
> > > > +/// ```rust
> > > > +/// # use kernel::sync::Mutex;
> > > > +/// use kernel::macros::pinned_drop;
> > > > +/// use core::pin::Pin;
> > > > +/// #[pin_data(PinnedDrop)]
> > > > +/// struct Foo {
> > > > +///     #[pin]
> > > > +///     mtx: Mutex<usize>,
> > > > +/// }
> > > > +///
> > > > +/// #[pinned_drop]
> > > > +/// impl PinnedDrop for Foo {
> > > > +///     fn drop(self: Pin<&mut Self>) {
> > > > +///         pr_info!("Foo is being dropped!");
> > > > +///     }
> > > > +/// }
> > > > +/// ```
> > > > +///
> > > > +/// # Safety
> > > > +///
> > > > +/// This trait must be implemented with [`pinned_drop`].
> > > > +///
> > > > +/// [`pinned_drop`]: kernel::macros::pinned_drop
> > > > +pub unsafe trait PinnedDrop: __PinData {
> > > > +    /// Executes the pinned destructor of this type.
> > > > +    ///
> > > > +    /// # Safety
> > > > +    ///
> > > > +    /// Only call this from `<Self as Drop>::drop`.
> > > > +    unsafe fn drop(self: Pin<&mut Self>);
> > > > +
> > > > +    // Used by the `pinned_drop` proc-macro to ensure that only sa=
fe operations are used in `drop`.
> > > > +    // the function should not be called.
> > > > +    #[doc(hidden)]
> > > > +    fn __ensure_no_unsafe_op_in_drop(self: Pin<&mut Self>);
> > >
> > > One idea to avoid this extra function is to have an unsafe token to t=
he
> > > drop function.
> > >
> > > fn drop(self: Pin<&mut Self>, token: TokenThatCanOnlyBeCreatedUnsafel=
y);
> >
> > What is wrong with having this extra function? If the problem is that t=
his
> > function might be called, then we could add a parameter with an
> > unconstructable type.
> >
> > I think that `drop` should be `unsafe`, since it really does have
> > the requirement of only being called in the normal drop impl.
>
> The point to avoid having two functions with the same body. This would
> require double the amount of checks needed by the compiler (and make
> error message worth if anything's wrong in the body of `drop`).
>
> This current approach is really just a hack to avoid code from doing
> unsafe stuff without using `unsafe` block -- and the best solution is
> just to avoid make `drop` function unsafe. However we don't want drop
> function to be actually called from safe code, and that's the point of
> a token that can only be created unsafely is force `drop` to *not* be
> called by safe code. The token is a proof that `unsafe` is being used.
>
> This way the `__ensure_no_unsafe_op_in_drop` function would not be
> needed.

That makes sense.

> > > > +// This trait is only implemented via the `#[pin_data]` proc-macro=
. It is used to facilitate
> > > > +// the pin projections within the initializers.
> > > > +#[doc(hidden)]
> > > > +pub unsafe trait __PinData {
> > > > +    type __PinData;
> > > > +}
> > > > +
> > > > +/// Stack initializer helper type. Use [`stack_pin_init`] instead =
of this primitive.
> > >
> > > `#[doc(hidden)]`?
> >
> > This trait is implementation detail of the `#[pin_data]` macro. Why sho=
uld
> > it be visible in the rust-docs?
>
> I am commenting about `stack_pin_init` (note the doc comment above my
> comment). `StackInit` is an implementation detail of `stack_pin_init`
> and shouldn't be exposed, IMO. Or do you think manual use of
> `StackInit` is needed?

I thought that it could be used by something else, but I will hide it for
now.

Cheers,
Benno
