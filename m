Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A867617A14
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiKCJi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKCJi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:38:26 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E809A2BFA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 02:38:24 -0700 (PDT)
Date:   Thu, 03 Nov 2022 09:38:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1667468300; x=1667727500;
        bh=he9+l/70m2lr35cIAprLwH48TPFg7J4DOfr7a4QfBkQ=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Is4ZCo3AzYEW6MQ4uobjGOIb4AUmYzrEgz1vB9kRIR0yZZAHQVi4dHpZzLTgx5m+t
         3G/xk7Oo3lqcaLlp31qo07vk7jIBVhgBrMA5kv1NP4tSZDO+vV5W4C5MaKQA2hmtPr
         xFOceBnTxi3a8QaK+h+lauZz4VcwFVfc54o5+jja2WDfMDQgf6iu+F2I5nqNqbHi37
         A2SliPS8nMiGcz/6SB6GIwHXyC7TPVONi/mTfab8H98LpeM94dFDi14USiLFMQtQLy
         mUXTlQK9qaFzxq5kW44Dz6b6WvwqW/BWt9V+56EcZOqR0fAI3y+zEAiOTM5dR+gDib
         zrTlV8Vu3Ooag==
To:     Dennis Dai <dzy.0424thu@gmail.com>
From:   =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: rust nvme driver: potential sleep-in-atomic-context
Message-ID: <nyfz0H8A-5nGCgsAynqZyYtFlEcvPHDecY6c8MC840zNNdEWz2NSPPuZgE_VS7RnrTwFhd6aCDi2TXWh6YtqfUeUEWZvFCT7HjpO-Z_UPCk=@protonmail.com>
In-Reply-To: <CACMswuMVERF_+R3Qxb0xGHCBQUCuxtBLA+eDo__Coed3BoVC3A@mail.gmail.com>
References: <CACMswuMVERF_+R3Qxb0xGHCBQUCuxtBLA+eDo__Coed3BoVC3A@mail.gmail.com>
Feedback-ID: 27884398:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, November 3rd, 2022 at 07:12, Dennis Dai <dzy.0424thu@gmail.com=
> wrote:


> The rust nvme driver [1] (which is still pending to be merged into
> mainline [2]) has a potential sleep-in-atomic-context bug.
>=20
> The potential buggy code is below
>=20
> // drivers/block/nvme.rs:192
> dev.queues.lock().io.try_reserve(nr_io_queues as _)?;
> // drivers/block/nvme.rs:227
> dev.queues.lock().io.try_push(io_queue.clone())?;
>=20
> The queues field is wrapped in SpinLock, which means that we cannot
> sleep (or indirectly call any function that may sleep) when the lock
> is held.
> However try_reserve function may indirectly call krealloc with a
> sleepable flag GFP_KERNEL (that's default behaviour of the global rust
> allocator).
> The the case is similar for try_push.
>=20
> I wonder if the bug could be confirmed.
>=20
>=20
> [1] https://github.com/metaspace/rust-linux/commit/d88c3744d6cbdf11767e08=
bad56cbfb67c4c96d0
> [2] https://lore.kernel.org/lkml/202210010816.1317F2C@keescook/

setup_io_queues is only called by dev_add which in turn is only called Nvme=
Device::probe. This last function is responsible for creating the &Ref<Devi=
ceData> that ends up being passed to setup_io_queues. It doesn't seem like =
any reference is passed to another thread between &Ref<DeviceData>. As such=
 no other thread can block on the current thread due to holding the lock. A=
s far as I understand this means that sleeping while the lock is held is ha=
rmless. I think it would be possible to replace the &Ref<DeviceData> argume=
nt with an Pin<&mut DeviceData> argument by moving the add_dev call to befo=
re Ref::<DeviceData>::from(data). This would make it clear that only the cu=
rrent thread holds a reference and would also allow using a method like get=
_mut [1] to get a reference to the protected data without actually locking =
the spinlock as it is statically enforced that nobody can else can hold the=
 lock. It seems that get_mut is missing from all of the locks offered in th=
e kernel crate. I opened an issue for this. [2]

[1]: https://doc.rust-lang.org/stable/std/sync/struct.Mutex.html#method.get=
_mut
[2]: https://github.com/Rust-for-Linux/linux/issues/924

Cheers,
Bj=C3=B6rn
