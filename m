Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266436D09CD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbjC3Pgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbjC3Pg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:36:26 -0400
Received: from mail-41104.protonmail.ch (mail-41104.protonmail.ch [185.70.41.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9799CE06E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:36:01 -0700 (PDT)
Date:   Thu, 30 Mar 2023 15:16:21 +0000
Authentication-Results: mail-41104.protonmail.ch;
        dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="cOof9CWD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680189390; x=1680448590;
        bh=RFJsZt4PoyY34NqeT0ENI5ZWm6qyrS5nHiUvq+C365Y=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=cOof9CWD18CgA86f1wPCs6LHKCiYvfg3NtPnu42gtskj0YfGSo8dJf+7s6QN4g+58
         DeYkftVFrBPmOl02YrYw44gCxVO66GhuHn5FAX8BJevHqmKvbj/qtGVTOt/uOj5T01
         I3ItVqd67QmPUb8LGhV/Rmx3LzNO8G3wQx32wgPNxHvzNNkpmMwQE2ls291232cjD3
         DK+udlLKGLEC0CM2dYGnFlboDS+NJCsDnXJWkZEChNBj7t3r0qtCEI0ccCpjF7QEyI
         7YRrxJMSYwuit/73PF9ZXi/J+gVayhDAm5NefJopBphXPIKPCxhgHHYbfd/cxfke9+
         gvAlfpfYlgvDw==
To:     David Laight <David.Laight@ACULAB.COM>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v3 12/13] rust: sync: reduce stack usage of `UniqueArc::try_new_uninit`
Message-ID: <ed3f5907-bc28-46b5-5a61-79dd2719349f@protonmail.com>
In-Reply-To: <7f55875c46ab4c4989323ede57f6e46d@AcuMS.aculab.com>
References: <20230329223239.138757-13-y86-dev@protonmail.com> <7f55875c46ab4c4989323ede57f6e46d@AcuMS.aculab.com>
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

On 30.03.23 16:58, David Laight wrote:
> From: y86-dev@protonmail.com
>> Sent: 29 March 2023 23:34
>>
>> `UniqueArc::try_new_uninit` calls `Arc::try_new(MaybeUninit::uninit())`.
>> This results in the uninitialized memory being placed on the stack,
>> which may be arbitrarily large due to the generic `T` and thus could
>> cause a stack overflow for large types.
>
> Does that mean rust is using (the equivalent of) alloca() ?

No, the compiler knows the size of `T` statically (this is a requirement
for calling `MaybeUninit::uninit()`). It would simply reserve stack
space for a stack variable (like the C compiler would also do) and since
the type is generic and user-specified, it could be larger than the
stack size. The problem is that the Rust compiler does not optimize the
stack variable away. This fix avoids creating a stack variable in the
first place.

--
Cheers,
Benno


>
> That is banned for C code in the kernel for any sizes.
>
> =09David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)


