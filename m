Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6796C7A01
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCXIjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjCXIjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:39:49 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCEF25E39
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 01:39:47 -0700 (PDT)
Date:   Fri, 24 Mar 2023 08:39:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1679647185; x=1679906385;
        bh=I8/f3JO/VA5KWyLN4wKp4hGSRAS0uOmn5BtDka1Qfpo=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=e1OidOwma+seobgitoxy4TukCO+qj4IBs36t91OuEhT4JbWavof1KoVj/j28ytLU0
         hIbvgvfRf4lbyL0lFIEnuMFSUeNAwvnZWCwHO/QBPBFsX+/8wedn4Cz5slKHxVWbfY
         rMuc26kQSIHXkdpt4PFYJuY/1+5PyfTNqyEmsqVZUV5A8tO40LQRHUoMvrPIj9ZBpD
         wxF0758GJJ5aUXpoqqQKpN+23XTPyQg8X5qqPxFZPVQmk4Y4vATeuv2Zj/sKK47viF
         bgadAFbZJXBRolAEpj33dG0zFGtEed+pV2bPLmMXJ2YrJmg3tvthIaRYwBIh4zWfw3
         //uFrPn/NLtew==
To:     Boqun Feng <boqun.feng@gmail.com>
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v2 3/5] rust: add pin-init API
Message-ID: <15f01078-4756-8f87-fe3c-ab9f433ebe7a@protonmail.com>
In-Reply-To: <ZBvyCwPcpTnk2R7h@Boquns-Mac-mini.local>
References: <20230321194934.908891-1-y86-dev@protonmail.com> <20230321194934.908891-4-y86-dev@protonmail.com> <ZBvyCwPcpTnk2R7h@Boquns-Mac-mini.local>
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

On 23.03.23 07:30, Boqun Feng wrote:
> On Tue, Mar 21, 2023 at 07:50:00PM +0000, Benno Lossin wrote:
> [...]
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
>> +///     buf: [u8; 64],
>
> Say we have an extra field,
>
>             a: u8,
>
>> +///     #[pin]
>> +///     pin: PhantomPinned,
>> +/// }
>> +/// pin_init!(&this in Buf {
>> +///     buf: [0; 64],
>> +///     ptr: unsafe { addr_of_mut!((*this.as_ptr()).buf).cast() },
>
> And I think we want to disallow:
>
>             a: unsafe { (*addr_of!(*this.as_ptr().buf))[0] }
>
> , right? Because we don't want `pin_init!` to provide any initialization
> order guarantee? If so, maybe add one or two sentences to call it out.
>
> If not sure, I think we can leave it as it is, until someone really uses
> this pattern ;-)

The `pin_init!` macro initializes everything in the order specified, so
if `a` is the last field you initialize, the code above is fine. I think
we could guarantee this. I will add a comment.

--
Cheers,
Benno


