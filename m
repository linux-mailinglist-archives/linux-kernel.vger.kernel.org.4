Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9016D2EF1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 09:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbjDAHok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 03:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbjDAHoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 03:44:37 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27361C1E8;
        Sat,  1 Apr 2023 00:44:36 -0700 (PDT)
Date:   Sat, 01 Apr 2023 07:44:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680335074; x=1680594274;
        bh=BzUT7zsUCdXVuuD2ZphbRGXxHROe8Fo8blx0Pe9lD9Q=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=GZ4I6tVWzNX4hRwAd1PBqs8dy+u1NBMxbCam00+1/+54RQCV1HJGS0k3DxmMQ2XXA
         r4/X55+6ERiY9/LKehCjz8mxOi2fSyR2SplInuStik9N3a6VIkeLI/Y14HLLdpsY0j
         +40XxjAfoD5cbcB54y6fUG3+PUpNS9DkA9rVqBbG0XAb7sbe9oWIecFe4bEcj4dNbf
         Br9IOXDpkpMGCP7Sl+iL2AQ9cSlC86n6zQO3sH7AJ183YIac7Fo0uJ8FqbPheTvdJR
         m5S5aLYe8rvV5mM/rOKaSbJRC/lgXDha9ozVLqV5Jo84pkWn231frSVXFuIPXd5BO0
         Nlwh5sPPfBW/A==
To:     Boqun Feng <boqun.feng@gmail.com>
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v4 08/15] rust: init/sync: add `InPlaceInit` trait to pin-initialize smart pointers
Message-ID: <90c7c075-255e-33ef-527e-32be5e9a6fc3@protonmail.com>
In-Reply-To: <ZCdh8fwSGTjDW6vE@boqun-archlinux>
References: <20230331215053.585759-9-y86-dev@protonmail.com> <ZCdh8fwSGTjDW6vE@boqun-archlinux>
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

On 01.04.23 00:42, Boqun Feng wrote:
> On Fri, Mar 31, 2023 at 09:53:25PM +0000, y86-dev@protonmail.com wrote:
> [...]
>> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
>> index eee7008e5e3e..24dc96603090 100644
>> --- a/rust/kernel/sync/arc.rs
>> +++ b/rust/kernel/sync/arc.rs
>> @@ -17,6 +17,7 @@
>>
>>   use crate::{
>>       bindings,
>> +    init::{InPlaceInit, Init, PinInit},
>>       types::{ForeignOwnable, Opaque},
>>   };
>>   use alloc::boxed::Box;
>> @@ -163,6 +164,28 @@ impl<T> Arc<T> {
>>           // `Arc` object.
>>           Ok(unsafe { Self::from_inner(Box::leak(inner).into()) })
>>       }
>> +
>> +    /// Use the given initializer to in-place initialize a `T`.
>> +    ///
>> +    /// If `T: !Unpin` it will not be able to move afterwards.
>> +    #[inline]
>> +    pub fn pin_init<E>(init: impl PinInit<T, E>) -> Result<Self>
>
> `Result` became `core::result::Result` after patch #3, so you will need
> to refer to `crate::error::Result` here. Alternatively you can change
> patch #3 to use the full path i.e. `core::result::Result`.
>
>> +    where
>> +        Error: From<E>,
>
> In my env, looks like the compiler doesn't know which `Error` it
> is after removing use of `crate::error::Result` in patch #3, you
> probably need to deal with this as well.
>
> Regards,
> Boqun
>
>> +    {
>> +        UniqueArc::pin_init(init).map(|u| u.into())
>> +    }
>> +
>> +    /// Use the given initializer to in-place initialize a `T`.
>> +    ///
>> +    /// This is equivalent to [`pin_init`], since an [`Arc`] is always =
pinned.
>> +    #[inline]
>> +    pub fn init<E>(init: impl Init<T, E>) -> Result<Self>
>> +    where
>> +        Error: From<E>,
>> +    {
>> +        UniqueArc::init(init).map(|u| u.into())
>> +    }
>>   }
>>
>>   impl<T: ?Sized> Arc<T> {
>> --
>> 2.39.2
>>
>>

Sorry, forgot to compile check that.
--
Cheers,
Benno


