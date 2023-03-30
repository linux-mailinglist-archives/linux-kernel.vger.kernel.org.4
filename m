Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE916D09E7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjC3Pj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbjC3Pjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:39:47 -0400
X-Greylist: delayed 763 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Mar 2023 08:39:36 PDT
Received: from mail-41103.protonmail.ch (mail-41103.protonmail.ch [185.70.41.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D70A35A1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:39:35 -0700 (PDT)
Date:   Thu, 30 Mar 2023 15:19:51 +0000
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="EWfJX+CK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680189597; x=1680448797;
        bh=Z3JCbWaaWUMZEyUU5ytYZUzOcZ8CnK3JDGgkqkS7+eI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=EWfJX+CKcZmbhRYtFful5fvUIEi+TDwouuLODz7hj1r1918HfMDyWmRZFA7CEdBGa
         MFSu1v9YXcYEHVMI5dI7lkiMhcjF3LTeMNPQRxUIOHo17qwuyX1Twuza49DxD4U+i7
         JjL/CScn6HFXql4n8Cj5Vozl9xDbIulns4ebrZVUpSD7po9J9WmoHeJ1TKlXL/ZCmz
         js4+NtwWITHIShFuzwi1eZ0e9c/WfErbn4klebzYePWA61DNiUL3TNT4KHrtMC8eEr
         YYicgA9rE6pVOKM5FOa27XbxXKsM9hAtPIcPT52BTt8gGo1ItxzZWaD+07p8CYqnTW
         57va7nW5NWcSQ==
To:     Alice Ryhl <alice@ryhl.io>
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Gary Guo <gary@garyguo.net>
Subject: Re: [PATCH v3 08/13] rust: init: add `stack_pin_init!` macro
Message-ID: <4b048bfc-e4fe-8c2f-ebfe-9b6a410cd8b8@protonmail.com>
In-Reply-To: <ada8307d-5177-2094-683f-bce619f1ea44@ryhl.io>
References: <20230329223239.138757-1-y86-dev@protonmail.com> <20230329223239.138757-9-y86-dev@protonmail.com> <ada8307d-5177-2094-683f-bce619f1ea44@ryhl.io>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.23 17:00, Alice Ryhl wrote:
> On 3/30/23 00:33, y86-dev@protonmail.com wrote:
>> From: Benno Lossin <y86-dev@protonmail.com>
>>
>> The `stack_pin_init!` macro allows pin-initializing a value on the
>> stack. It accepts a `impl PinInit<T, E>` to initialize a `T`. It allows
>> propagating any errors via `?` or handling it normally via `match`.
>>
>> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
>> ---
>> +#[macro_export]
>> +macro_rules! stack_pin_init {
>> +    (let $var:ident $(: $t:ty)? =3D $val:expr) =3D> {
>> +        let mut $var =3D $crate::init::__internal::StackInit$(::<$t>)?:=
:uninit();
>> +        let mut $var =3D {
>> +            let val =3D $val;
>> +            unsafe { $crate::init::__internal::StackInit::init(&mut $va=
r, val) }
>> +        };
>> +    };
>> +    (let $var:ident $(: $t:ty)? =3D? $val:expr) =3D> {
>> +        let mut $var =3D $crate::init::__internal::StackInit$(::<$t>)?:=
:uninit();
>> +        let mut $var =3D {
>> +            let val =3D $val;
>> +            unsafe { $crate::init::__internal::StackInit::init(&mut $va=
r, val)? }
>> +        };
>> +    };
>> +}
>
> This will be inconvenient to use if the initializer is infallible and is
> used inside an infallible function. However, I'm not sure what a better
> alternative would be. Perhaps we should have three variants?

That could be an option, any ideas for the syntax though? Or should it
be a different macro like `stack_pin_init!` and `try_stack_pin_init!`?

> Also, maybe a `<-` rather than `=3D` would be more consistent?

That is sadly not possible, since `<-` is not allowed after `ty` fragments.

> Anyway, I don't think this should block the PR. We can revisit it later
> if it becomes a problem.

Sure.

--
Cheers,
Benno


