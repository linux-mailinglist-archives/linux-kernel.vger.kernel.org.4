Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6866C7BF6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjCXJuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjCXJug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:50:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E900665A9;
        Fri, 24 Mar 2023 02:50:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C9AD62A13;
        Fri, 24 Mar 2023 09:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D057EC433D2;
        Fri, 24 Mar 2023 09:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679651433;
        bh=S4Jr5OT55gMmqOJIDNJBIj8rUMO/IhxbXMdnkvuUqy4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BLOvLugAYUysLJ3X+xCbQofawB6nUK6vMlkHLiKmIp3WDVY3MUw32EIoQjHAQlyuy
         v5tx6IHA5+bEVcJ+3xZ++p3KAiq+wj8dRmLPdLvTJY3AG9nL+xXAoSuPj7/C9znWFr
         mbZA9trBWjN753gqgb0R0kd2lgZcwvZsbpqFygwR879MvH2ZHGepX4+zbkpZ7WA9uq
         OjGlREvtPFEbkEnYucTGK3f44T9yNKeBT/JDVj0pTm6PNSOeSmgnFcmOnst73B7qkj
         ql1rW8Hat72gOwvSdFe+Oj/O4C9p6cewYRmVtykEAvCTWZQMBhZ0d3H6IcxBi1b1BG
         4oThUsvDu7aZg==
Received: by mail-ed1-f53.google.com with SMTP id t10so5413858edd.12;
        Fri, 24 Mar 2023 02:50:33 -0700 (PDT)
X-Gm-Message-State: AAQBX9ciWw4i0v5cXJwC8KKYxNxTCC9fhXmKq1cN/pgeM6IFQ6jYvMXw
        HJR2nLoWiH0KR3PE+AsDeJCxwZlRlmx1CGyuMdU=
X-Google-Smtp-Source: AKy350YzU1gKtBIlfYm5UxCbGzyhHJ/YD2U6/ZtMlKKEiMfrES5/oTd8Xx3wkt/ILWobUPenuuAf4Kn0gq5eQFDvxpc=
X-Received: by 2002:a17:906:db02:b0:931:7350:a7b6 with SMTP id
 xj2-20020a170906db0200b009317350a7b6mr1143115ejb.10.1679651432048; Fri, 24
 Mar 2023 02:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <e6aaddb9-afec-e77d-be33-570f9f10a9c2@leemhuis.info>
 <53e8b4db-e8dd-4dfa-f873-7dcbeac09149@leemhuis.info> <3089214d-292b-885d-9bc1-c81d0101d5f0@leemhuis.info>
In-Reply-To: <3089214d-292b-885d-9bc1-c81d0101d5f0@leemhuis.info>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 24 Mar 2023 17:50:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5j29CnCN+F8Oz0qh1UCqp+CmL=aQXCSjqgX8CZ5sXTtg@mail.gmail.com>
Message-ID: <CAAhV-H5j29CnCN+F8Oz0qh1UCqp+CmL=aQXCSjqgX8CZ5sXTtg@mail.gmail.com>
Subject: Re: [regression] Bug 217069 - Wake on Lan is broken on r8169 since 6.2
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bob Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        acpica-devel@lists.linuxfoundation.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thorsten,

I'm sorry I ignored this email, and Jianmin, could you please
investigate this problem? Thank you.

Huacai

On Fri, Mar 24, 2023 at 5:46=E2=80=AFPM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 19.03.23 08:20, Linux regression tracking (Thorsten Leemhuis) wrote:
> > Hi, Thorsten here, the Linux kernel's regression tracker.
> >
> > On 22.02.23 08:57, Thorsten Leemhuis wrote:
> >>
> >> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> >> kernel developer don't keep an eye on it, I decided to forward it by
> >> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=3D21706=
9 :
> >
> > An issue that looked like a network bug was now bisected and it turns
> > out it's cause by 5c62d5aab875 ("ACPICA: Events: Support fixed PCIe wak=
e
> > event") which Huacai Chen provided. Could you take a look at the ticket
> > linked above?
>
> Huacai Chen, did you look into this? Would be good to have this
> regression fixed rather sooner than later, as it seems to annoy quite a
> few people.
>
> Should we maybe simply revert the problematic change for now and reapply
> it later once the root-issue was found and fixed?
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
> #regzbot poke
>
> > FWIW, the whole story started like this:
> >
> >>> Ivan Ivanich 2023-02-22 00:51:52 UTC
> >>>
> >>> After upgrade to 6.2 having issues with wake on lan on 2 systems: -
> >>> first is an old lenovo laptop from 2012(Ivy Bridge) with realtek
> >>> network adapter - second is a PC(Haswell refresh) with PCIE realtek
> >>> network adapter
> >>>
> >>> Both uses r8169 driver for network.
> >>>
> >>> On laptop it's not possible to wake on lan after poweroff On PC it's
> >>> not possible to wake on lan up after hibernate but works after
> >>> poweroff
> >>>
> >>> In both cases downgrade to 6.1.x kernel fixes the issue.
> >
> > Meanwhile a few others that ran into the same problem with NICs from
> > different vendors joined the ticket
> >
> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat=
)
> > --
> > Everything you wanna know about Linux kernel regression tracking:
> > https://linux-regtracking.leemhuis.info/about/#tldr
> > If I did something stupid, please tell me, as explained on that page.
