Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFD46D098E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjC3P3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbjC3P3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:29:21 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C033E04F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:29:03 -0700 (PDT)
Date:   Thu, 30 Mar 2023 15:28:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680190102; x=1680449302;
        bh=kpaOTyrKqsw1XHAwXmaqpibdDWFN/5HsmHgDh0lZUrg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=odsQp3kuPYH79BQTdgIjYANBF/X5AwTkHo+Rx+bFHO+jN8jDLzyn/3n3aV3s5tX+S
         bUUbfGNFYEz9U7kyM7IJxHptVFFoh9xJC4OzG2tvcX1aPlBVT/Og0t42oiFq7VX4bg
         ZNv1QBD/PHk8n6EFgpLYq9lECnxEvb2FZUPbXGr84UXs82YAm34zWk/lDWt2B0CjX5
         5bdOAOi5zwpCtvpYrEonpP296gvgJRfTzA5j6qTMwkcV8tsfo5j2vikdhtAGEuEIvb
         NctaMjaE+N187DL9lX+jQES9OGdzCMkWerxcpRStLoDW5fuvSgc/KxVGiz72rdeSv9
         h3hthoAXLcpPA==
To:     Alice Ryhl <alice@ryhl.io>
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v3 06/13] rust: init/sync: add `InPlaceInit` trait to pin-initialize smart pointers
Message-ID: <3ea5cd8d-84ca-59bd-de50-fef185233a50@protonmail.com>
In-Reply-To: <1f93a045-5bd8-e07f-cf1b-7b1196c8ab54@ryhl.io>
References: <20230329223239.138757-1-y86-dev@protonmail.com> <20230329223239.138757-7-y86-dev@protonmail.com> <1f93a045-5bd8-e07f-cf1b-7b1196c8ab54@ryhl.io>
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

On 30.03.23 16:37, Alice Ryhl wrote:
> On 3/30/23 00:33, y86-dev@protonmail.com wrote:
>> From: Benno Lossin <y86-dev@protonmail.com>
>>
>> The `InPlaceInit` trait that provides two functions, for initializing
>> using `PinInit<T, E>` and `Init<T>`. It is implemented by `Arc<T>`,
>> `UniqueArc<T>` and `Box<T>`.
>>
>> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
>   > ---
>   >
>> +/// Smart pointer that can initialize memory in-place.
>> +pub trait InPlaceInit<T>: Sized {
>> +    /// Use the given initializer to in-place initialize a `T`.
>> +    ///
>> +    /// If `T: !Unpin` it will not be able to move afterwards.
>> +    fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self>=
>
>> +    where
>> +        Error: From<E>;
>> +
>> +    /// Use the given initializer to in-place initialize a `T`.
>> +    fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
>> +    where
>> +        Error: From<E>;
>> +}
>
> This definition is potentially rather limiting, because it can only be
> used with error types that can be converted into a `kernel::Error`. What
> do you think of this alternative?
>
> pub trait InPlaceInit<T>: Sized {
>       fn pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
>       where
>           E: From<AllocError>;
>
>       fn init<E>(init: impl Init<T, E>) -> Result<Self, E>
>       where
>           E: From<AllocError>;
> }

I initially implemented it like this, but it required almost always that
`E` is specified, I will try and see if the situation is any different now,
but I do not think so. In the user-space version of this API (see [1]) I
have four functions, normal variants that return an `AllocError` and `try`
variants that look exactly like what you suggested. In the kernel, we could
make the normal variants as they are now and add the `try` variants as you
described.

[1]: https://docs.rs/pinned-init/0.0.5/pinned_init/trait.InPlaceInit.html

--
Cheers,
Benno


