Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA686F3883
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjEATzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjEATzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:55:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C083F2107
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 12:55:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA6006111F
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 19:55:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E80C433EF;
        Mon,  1 May 2023 19:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682970913;
        bh=yVadDZkKTAgZPvoruE+W0GbcwpOyHNSfv14dBmKX55A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YANzG2sbpFwyfn0olLgq955pBelAikqDYTjIhmEyTq7s6R/gluMaDAYYmWlPkstBE
         CKPgSoIXO6LfByKtw24CYIxRxo1ftbyNGUZEqr4sXrT+HeNcJiQT9apTnwVrP6+ier
         KP+4SgKUo+u/V3LGdqZOaszU8YXo8fONTpxZ+1U1+XF5ezN59J6B0RIFR4IOar4DAW
         8R94/haVco7MiNGRlLe5Jh+miVqiQq7d3PUbgg9A0Vk6+4sFnVsoi08JAcINQHrx4m
         ub8B/1li8YqLJb8ob6A8BT4ZdyG2UG+D1qLtnf7BKv8s0ROBvpAVZx4MGtYLTLVQKF
         PHhfaG7QmEDIA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, paul.walmsley@sifive.com
Cc:     heiko@sntech.de, kito.cheng@sifive.com, jrtc27@jrtc27.com,
        conor.dooley@microchip.com, matthias.bgg@gmail.com,
        heinrich.schuchardt@canonical.com, greentime.hu@sifive.com,
        nick.knight@sifive.com, christoph.muellner@vrull.eu,
        philipp.tomsich@vrull.eu, richard.henderson@linaro.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH 0/4] Expose the isa-string via the AT_BASE_PLATFORM aux
 vector
In-Reply-To: <20230424194911.264850-1-heiko.stuebner@vrull.eu>
References: <20230424194911.264850-1-heiko.stuebner@vrull.eu>
Date:   Mon, 01 May 2023 21:55:10 +0200
Message-ID: <87ednz7roh.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Stuebner <heiko@sntech.de> writes:

> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
>
> The hwprobing infrastructure was merged recently [0] and contains a
> mechanism to probe both extensions but also microarchitecural features
> on a per-core level of detail.
>
> While discussing the solution internally we identified some possible issu=
es,
> tried to understand the underlying issue and come up with a solution for =
it.
> All these deliberations overlapped with hwprobing being merged, but that
> shouldn't really be an issue, as both have their usability - see below.
> Also please see the "Things to consider" at the bottom!
>
>
> Possible issues:
> - very much limited to Linux
> - schedulers run processes on all cores by default, so will need
>   the common set of extensions in most cases

...which hwprobe has support for via the CPU mask. no?

> - each new extensions requires an uapi change, requiring at least
>   two pieces of software to be changed
> - adding another extension requires a review process (only known
>   extensions can be exposed to user-space)
> - vendor extensions have special needs and therefore possibly
>   don=E2=80=99t fit well
>
>
> Limited to Linux:
> -----------------
>
> The syscall and its uapi is Linux-specific and other OSes probably
> will not defer to our review process and requirements just to get
> new bits in. Instead most likely they'll build their own systems,
> leading to fragmentation.

There are a number of examples where multiple OSs have followed what
Linux does, and vice versa. I'd say the opposite -- today system
builders do not do their own solution, but review what's out there and
mimics existing ones.

Personally I think this argument is moot, and will not matter much for
fragmentation.

> Feature on all cores:
> ---------------------
>
> Arnd previously ([1]) commented in the discussion, that there
> should not be a need for optimization towards hardware with an
> asymmetric set of features. We believe so as well, especially
> when talking about an interface that helps processes to identify
> the optimized routines they can execute.
>
> Of course seeing it with this finality might not take into account
> the somewhat special nature of RISC-V, but nevertheless it describes
> the common case for programs very well.
>
> For starters the scheduler in its default behaviour, will try to use any
> available core, so the standard program behaviour will always need the
> intersection of available extensions over all cores.
>
>
> Limiting program execution to specific cores will likely always be a
> special use case and already requires Linux-specific syscalls to
> select the set of cores.
>
> So while it can come in handy to get per-core information down the road
> via the hwprobing interface, most programs will just want to know if
> they can use a extension on just any core.
>
>
> Review process:
> ---------------
>
> There are so many (multi-letter-)extensions already with even more in
> the pipeline. To expose all of them, each will require a review process
> and uapi change that will make defining all of them slow as the
> kernel needs patching after which userspace needs to sync in the new
> api header.
>
>
> Vendor-extensions:
> ------------------
>
> Vendor extensions are special in their own right.
> Userspace probably will want to know about them, but we as the kernel
> don't want to care about them too much (except as errata), as they're
> not part of the official RISC-V ISA spec.
>
> Getting vendor extensions from the dt to userspace via hwprobe would
> require coordination efforts and as vendors have the tendency to invent
> things during their development process before trying to submit changes
> upstream this likely would result in conflicts with assigned ids down
> the road. Which in turn then may create compatibility-issues with
> userspace builds built on top of the mainline kernel or a pre-
> existing vendor kernel.
>
> The special case also is that vendor A could in theory implement an
> extension from vendor B. So this would require to actually assign
> separate hwprobe keys to vendors (key for xthead extensions, key for
> xventana extensions, etc). This in turn would require vendors to
> come to the mainline kernel to get assigned a key (which in reality
> probably won't happen), which would then make the kernel community
> sort of an id authority.
>
>
>
>
> To address these, the attached patch series adds a second interface
> for the common case and "just" exposes the isa-string via the
> AT_BASE_PLATFORM aux vector.

*A second interface* introduced the second hwprobe landed. Really?
Start a discussion on how to extend hwprobe instead.


Bj=C3=B6rn
