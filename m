Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9706D09DF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjC3Pj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjC3Pj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:39:26 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EF883E7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:39:07 -0700 (PDT)
Date:   Thu, 30 Mar 2023 15:38:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680190744; x=1680449944;
        bh=78dr7bQ+n1CF5BDMkt72hk6Mu6tYllNVNQReiUB0IjI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=JGzM4eUkMb2oKzbtBusmrJvRD2L8QnkKxZtArCmw0bGeVW/gzfBagKYDIOFvMXgTX
         zzqdOjM5qc/ZysddzD8REBjEkoimegRnJnqNn3MuBjtOiWcX+yicS69x2D02Z8RXfW
         k1woEYcHMUsdNKJrhyv4gF4ZWKeibAh0kBlHugsy7p2OcwtlXSVx2TYZI6YQ94xu0u
         OcmOPeXjPvGFba00XAH6u4xUYZA2wzCHw8JpcvJgYB9O8POjE3tVVaXkTAUO7Utbv/
         p9+CijLBTzJRZ/THBoUMPfnzRsmj2P/qrp+V+Rc0v1fQwEzYbgjvFnXGO3UYpNd/9q
         9xBbAy0ia7lLA==
To:     Alice Ryhl <alice@ryhl.io>
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v3 05/13] rust: init: add initialization macros
Message-ID: <226e4772-0e10-6593-7cfe-e1e290a0216c@protonmail.com>
In-Reply-To: <f9f1d67f-5c89-d508-d582-528273b635db@ryhl.io>
References: <20230329223239.138757-1-y86-dev@protonmail.com> <20230329223239.138757-6-y86-dev@protonmail.com> <f9f1d67f-5c89-d508-d582-528273b635db@ryhl.io>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.23 16:21, Alice Ryhl wrote:
> On 3/30/23 00:33, y86-dev@protonmail.com wrote:
>> From: Benno Lossin <y86-dev@protonmail.com>
>>
>> Add the following initializer macros:
>> - `#[pin_data]` to annotate structurally pinned fields of structs,
>>     needed for `pin_init!` and `try_pin_init!` to select the correct
>>     initializer of fields.
>> - `pin_init!` create a pin-initializer for a struct with the
>>     `Infallible` error type.
>> - `try_pin_init!` create a pin-initializer for a struct with a custom
>>     error type (`kernel::error::Error` is the default).
>> - `init!` create an in-place-initializer for a struct with the
>>     `Infallible` error type.
>> - `try_init!` create an in-place-initializer for a struct with a custom
>>     error type (`kernel::error::Error` is the default).
>>
>> Also add their needed internal helper traits and structs.
>>
>> Co-developed-by: Gary Guo <gary@garyguo.net>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
>> +/// ```rust
>> +/// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
>> +/// # use kernel::{init, pin_init, prelude::*, init::*};
>> +/// # use core::pin::Pin;
>> +/// # #[pin_data]
>> +/// # struct Foo {
>> +/// #     a: usize,
>> +/// #     b: Bar,
>> +/// # }
>> +/// # #[pin_data]
>> +/// # struct Bar {
>> +/// #     x: u32,
>> +/// # }
>> +///
>> +/// impl Foo {
>> +///     fn new() -> impl PinInit<Self> {
>
> I would remove the empty line above `impl Foo` so that the example
> doesn't start with an empty line when rendered.

Sure.

>
>> +/// # Syntax
>> +///
>> +/// As already mentioned in the examples above, inside of `pin_init!` a=
 `struct` initializer with
>> +/// the following modifications is expected:
>> +/// - Fields that you want to initialize in-place have to use `<-` inst=
ead of `:`.
>> +/// - In front of the initializer you can write `&this in` to have acce=
ss to a [`NonNull<Self>`]
>> +///   pointer named `this` inside of the initializer.
>> +///
>> +/// For instance:
>> +///
>> +/// ```rust
>> +/// # use kernel::pin_init;
>> +/// # use macros::pin_data;
>> +/// # use core::{ptr::addr_of_mut, marker::PhantomPinned};
>> +/// #[pin_data]
>> +/// struct Buf {
>> +///     ptr: *mut u8,
>
> I'd add a comment on the `ptr` field saying "points at `buf`".

Sure.

>
>> +/// impl BigBuf {
>> +///     fn new() -> impl PinInit<Self, Error> {
>> +///         try_pin_init!(Self {
>> +///             big: {
>> +///                 let zero =3D Box::try_new_zeroed()?;
>> +///                 unsafe { zero.assume_init() }
>> +///             },
>
> Is there a reason for not using `Box::init(kernel::init::zeroed())?` here=
?

No, this was probably designed prior to `zeroed`, will change it.

--
Cheers,
Benno

