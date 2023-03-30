Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C169F6D1088
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 23:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjC3VKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 17:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjC3VK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 17:10:29 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB50CE068
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 14:10:28 -0700 (PDT)
Date:   Thu, 30 Mar 2023 21:10:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680210626; x=1680469826;
        bh=CLgO8As5bEevfVZ/jlQ4M8lt0TNqWZbzE5S1UXMu7FY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=pFBML9XxmyoxWjuk6ywiVWrCOW6OE8kh4TAkzA7CucR8s8/0Eh6POncencqSHcx6D
         Ki+nVIErkEYsQYZ681qxbbtQO6PzfVebBXTBbuvS5AkjhRbNvCSf9jRpQCKkvP7Te4
         uvLEsH3EAX3QHuWEY2sH9w17fMiIcDJoEKTtshc60IYLOS5uyth0b9fs0dLa5Cjssi
         QhnPt6IPSKtPQ5batHvYhRFlJCJ3im/SgawP2QGBJ0w7dsR01GLMUZ+4WLnVYxwKcZ
         O0xFishbiN03E5LaAJFe4v0zfTjYDG/C2HKp6q5Z2+LaJbdePRO69pysLhF5c9tEQO
         r3mreGAdPb/gw==
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 13/13] rust: sync: introduce `LockedBy`
Message-ID: <8a5d6cf1-17eb-6cb9-fb45-0a4d454d385e@protonmail.com>
In-Reply-To: <CANeycqotBmHkXAFbibp3BerEt=RA6sse+dgAkmpcy+oFMiA-vA@mail.gmail.com>
References: <20230330043954.562237-1-wedsonaf@gmail.com> <20230330043954.562237-13-wedsonaf@gmail.com> <04034640-2d89-dd63-07e5-29fa612aa458@protonmail.com> <06a7c5e7-fc5f-3860-7f17-7f3609de669a@protonmail.com> <CANeycqotBmHkXAFbibp3BerEt=RA6sse+dgAkmpcy+oFMiA-vA@mail.gmail.com>
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

On 30.03.23 23:04, Wedson Almeida Filho wrote:
> On Thu, 30 Mar 2023 at 08:45, Benno Lossin <y86-dev@protonmail.com> wrote=
:
>>
>> On 30.03.23 13:28, Benno Lossin wrote:
>>       struct Outer {
>>           mtx1: Mutex<()>,
>>           mtx2: Mutex<()>,
>>           inners: Vec<Inner>,
>>       }
>>
>>       struct Inner {
>>           count: LockedBy<usize, ()>,
>>       }
>>
>>       fn new_inner(outer: &Outer) -> Inner {
>>           Inner { count: LockedBy::new(&outer.mtx1, 0) }
>>       }
>>
>>       fn evil(outer: &Outer) {
>>           let inner =3D outer.inners.get(0).unwrap();
>>           let mut guard1 =3D outer.mtx1.lock();
>>           let mut guard2 =3D outer.mtx2.lock();
>>          // The pointee of `guard1` and `guard2` have the same address.
>>           let ref1 =3D inner.count.access_mut(&mut *guard1);
>>           let ref2 =3D inner.count.access_mut(&mut *guard2);
>>           mem::swap(ref1, ref2);
>>       }
>
> This doesn't reproduce the issue because `mtx2` itself is not a ZST
> (it contains a `struct mutex` before the data it protects).
>
> Something like the following should reproduce it though:
>
>      struct Outer {
>           mtx1: Mutex<()>,
>           zst: (),
>       }
>
>       fn evil(outer: &Outer) {
>           let lb =3D LockedBy::new(&outer.mtx1, 0u8);
>           let value =3D lb.access(&outer.zst);
>           // Accessing "value" without holding `mtx1`.
>           pr_info!("{}", *value);
>       }

You are correct, but in your example you also cannot be sure that it
works, since the layout of the `Mutex` and `Outer` is `repr(Rust)`.
And so you cannot be sure that `zst` has the same address as `value`
inside of the `Mutex` (since the `struct mutex` could be in between).
But regardless, lets just deny ZSTs in `LockedBy` since the fix is
easy and it would be weird to put a ZST in a lock in the first place.
(Not that you have argued against it)

--
Cheers,
Benno


