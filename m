Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93EE6D09CF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjC3PhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjC3PhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:37:08 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF83CD517
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:36:36 -0700 (PDT)
Date:   Thu, 30 Mar 2023 15:36:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680190593; x=1680449793;
        bh=BFhSFq3J8IyHD8N/GJl+CpIhHOZfQHYWPId2eeLRAZk=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=snCcK7u/bNBcYmywMJ1/hoYfNPUpab5DYWsPfsI3mGFS8NicIrzagfnFvjI9ZyRpq
         VR6j0ZFWmed3XNnGh+0jSJHV/dedOil8FAdU5FA0qybzAyfiwhE3/pMP5dYevTZcb7
         zrmtfZDxkOl9XROZZB3ElybjbhMzgNr6aMmfAnlUd78xRyGs2Dyj8YXAsKj9T9qOMg
         C1BrnOmTGriTcz2dPtOvJc6cGOrXN/GmGoiOzFA9uQ58kZmnybTyArmkuq0/9euS+P
         ARJcLS4trYz/hIMZtVBS7RRoieU4VLFuav2RsWqIPpSkqi0Xw/+Wn3fosq+qgvH+OS
         hcGhA9prSYwng==
To:     Alice Ryhl <alice@ryhl.io>
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v3 04/13] rust: add pin-init API core
Message-ID: <9c2d4516-f0d7-73ca-d64b-df60e9bd6df1@protonmail.com>
In-Reply-To: <ce17f68e-521f-f55e-8ae2-35bcd6ebd709@ryhl.io>
References: <20230329223239.138757-1-y86-dev@protonmail.com> <20230329223239.138757-5-y86-dev@protonmail.com> <ce17f68e-521f-f55e-8ae2-35bcd6ebd709@ryhl.io>
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

On 30.03.23 15:33, Alice Ryhl wrote:
> On 3/30/23 00:33, y86-dev@protonmail.com wrote:
>> From: Benno Lossin <y86-dev@protonmail.com>
>>
>> This API is used to facilitate safe pinned initialization of structs. It
>> replaces cumbersome `unsafe` manual initialization with elegant safe mac=
ro
>> invocations.
>>
>> Due to the size of this change it has been split into six commits:
>> 1. This commit introducing the basic public interface: traits and
>>      functions to represent and create initializers.
>> 2. Adds the `#[pin_data]`, `pin_init!`, `try_pin_init!`, `init!` and
>>      `try_init!` macros along with their internal types.
>> 3. Adds the `InPlaceInit` trait that allows using an initializer to crea=
te
>>      an object inside of a `Box<T>` and other smart pointers.
>> 4. Adds the `PinnedDrop` trait and adds macro support for it in
>>      the `#[pin_data]` macro.
>> 5. Adds the `stack_pin_init!` macro allowing to pin-initialize a struct =
on
>>      the stack.
>> 6. Adds the `Zeroable` trait and `init::zeroed` function to initialize
>>      types that have `0x00` in all bytes as a valid bit pattern.
>>
>> Co-developed-by: Gary Guo <gary@garyguo.net>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
>> +//! Aside from pinned initialization, this API also supports in-place c=
onstruction without pinning,
>> +//! the marcos/types/functions are generally named like the pinned vari=
ants without the `pin`
>> +//! prefix.
>
> Typo: Should be "macros".
>
>> +type Invariant<T> =3D PhantomData<fn(*mut T) -> *mut T>;
>
> I think it would make sense to include a link to the nomicon on the
> documentation for the Invariant type.
>
> E.g. this link: https://doc.rust-lang.org/nomicon/subtyping.html

Sure that is a good idea.

>> +// This is the module-internal type implementing `PinInit` and `Init`. =
It is unsafe to create this
>> +// type, since the closure needs to fulfill the same safety requirement=
 as the
>> +// `__pinned_init`/`__init` functions.
>> +struct InitClosure<F, T: ?Sized, E>(F, Invariant<(E, T)>);
>
> Documentation for a type should use /// rather than //.
>
> I think it would help to call out explicitly in the documentation on
> this type that it is an implementation detail of the
> pin_init_from_closure and init_from_closure methods.

Yeah, I will also move this into `__internal.rs` and add the comment.

--
Cheers,
Benno

