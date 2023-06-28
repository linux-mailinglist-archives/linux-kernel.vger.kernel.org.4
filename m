Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887AC741007
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjF1L1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:27:09 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:37309 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjF1L1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:27:06 -0400
Date:   Wed, 28 Jun 2023 11:26:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1687951625; x=1688210825;
        bh=XPNoqmm6Hfyg8DRJ8RMQMbmbtTIOF4zGcaTgbL8kroU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=IvDh8X+gOmPu9XFnkVl+Xn3ZsayvdNrFO65a1DhXW0KXm63pfOphgJIIiLKrx8Qmw
         aKERZ/Ohoa+OPjHcJvKmCkOn237PTp+0ByWjt/aH0lkMqgzsm7A3nTe92NomWU2l1x
         VdlelvNkXUv/o1NOA77FZLZ8j4vj1d6eoweqL2y8/M6RsISDOmj0mdbds8T+Btqoov
         YwkA80Pnc8StEGs/PbGyPO/EM72VEQsxRPN6FD/rHJve3dCKn6T7FK0Z+sQl57jb4b
         1h0slrqyKZdJFMRKVjcGAqF6rIXKtmqOV+I+38uTXWUWtAGxkq7nnk23Rk+cD1c8gZ
         C2xmodH9dZ+hg==
To:     Gary Guo <gary@garyguo.net>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH 7/7] rust: init: add support for arbitrary paths in init macros
Message-ID: <u8Hy97tvl2TFqYO2rZch21iVBAAH7Cqe_ONBp7B35wE6QnevIyABIWgaGrZcA1NZ3rcr0m_K-RzVfiiycccX0UACcTx-pMF94CiGxT-auYM=@proton.me>
In-Reply-To: <20230625220117.667db9ea.gary@garyguo.net>
References: <20230624092330.157338-1-benno.lossin@proton.me> <20230624092330.157338-7-benno.lossin@proton.me> <20230625220117.667db9ea.gary@garyguo.net>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.06.23 23:01, Gary Guo wrote:
> On Sat, 24 Jun 2023 09:25:39 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>=20
>> Previously only `ident` and generic types were supported in the
>> `{try_}{pin_}init!` macros. This patch allows arbitrary path fragments,
>> so for example `Foo::Bar` but also very complex paths such as
>> `<Foo as Baz>::Bar::<0, i32>`.
>>
>> Internally this is accomplished by using `path` fragments. Due to some
>> peculiar declarative macro limitations, we have to "forget" certain
>> additional parsing information in the token trees. This is achieved by
>> the new `retokenize` proc macro. It does not modify the input, but just
>> strips this information. For example, if a declarative macro takes
>> `$t:path` as its input, it cannot sensibly propagate this to a macro tha=
t
>> takes `$($p:tt)*` as its input, since the `$t` token will only be
>> considered one `tt` token for the second macro. If we first pipe the
>> tokens through `retokenize`, then it parses as expected.
>=20
> I think this "retokenize" macro could also be functionally replaced by
> `paste`. Would you mind to apply my paste patch (referenced in a
> previous email) and see if it works?

I tried your patch and it seems to work. I also executed all of the test
in the userspace library and they passed.
The `paste!` code also looks good to me. One thing that I thought was this:
do we want to accept `paste!( [<=3D foo bar>])`? Because the `<` token has
spacing `Joint`, maybe add a check for that? No idea if that would be a pro=
blem.

--=20
Cheers,
Benno

>=20
> Best,
> Gary
>=20

