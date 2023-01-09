Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2878B662197
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjAIJai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237074AbjAIJ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:29:56 -0500
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C515589
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:28:23 -0800 (PST)
Received: by mail-qv1-f44.google.com with SMTP id h10so5809494qvq.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 01:28:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=143wDsMVoT3ACA6WVcfJSImlvXbq2c2/rZtfKrhZST8=;
        b=X0xmjH7f5uHWMRSaJkz8VjO9PnAyFqV/muP2isKaNo1MNnK95wMXnCK1fecmhD984S
         gkkO56FKrsSwFwR9tK5vh3RYzj5+2GJvlmVQpYQvYmfEKPXcgkuT9Thuhf/JFy8oHaT2
         MWVdsbKhHBkObzfIoBhdN6EJtauv3Q0Ns/7aAL7nped3WIdEaxgsXNw0kQlH8PabXfax
         zQqATmFOiK23RQqg6nCWK6KaXnl53QjJwxtNFW07m89lTVHLpJcdV01gxkcqIyS8EWQ4
         vS/S5Vl8E0ey8WUtYKRcGZHJmX98/mHbvMshmPpnx0srcFGk4iHjC6YFdR2LsFz+3Dk0
         y89w==
X-Gm-Message-State: AFqh2kqisfAj/+0tVzvbMGp0fWd1q66m7Nwss7kz3l6ISGqLH7Jh2BRg
        Q3oGVG5OLV1JFa6wQpdNxnnYYm+o4z85jQ==
X-Google-Smtp-Source: AMrXdXsj/nJ0yAA2FfWSGJ+lA9vMZvjN3tHbE0aKt83Y82El1OqO70BPOtw9Gdg2FKBywUlkxbz1ug==
X-Received: by 2002:ad4:5429:0:b0:4c6:e10e:8cff with SMTP id g9-20020ad45429000000b004c6e10e8cffmr83309507qvt.9.1673256502277;
        Mon, 09 Jan 2023 01:28:22 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id f8-20020a05620a408800b0070543181468sm5096831qko.57.2023.01.09.01.28.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 01:28:21 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-4c9b9185d18so34440387b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 01:28:21 -0800 (PST)
X-Received: by 2002:a81:ac18:0:b0:475:f3f5:c6c with SMTP id
 k24-20020a81ac18000000b00475f3f50c6cmr185969ywh.358.1673256501562; Mon, 09
 Jan 2023 01:28:21 -0800 (PST)
MIME-Version: 1.0
References: <Y7nyd4hPeXsdiibH@duo.ucw.cz> <Y7pRw47hidw+s6+g@mit.edu>
 <Y7pzbnlXgv+asekg@amd.ucw.cz> <CAMuHMdVvVoEs8yjNLmK=_shmGkyz1zYc8ZMi-vmP4aee0yKoPQ@mail.gmail.com>
 <Y7sPq3Tmm6vI/RAJ@duo.ucw.cz> <Y7tjnhs77o4TL5ey@mit.edu>
In-Reply-To: <Y7tjnhs77o4TL5ey@mit.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Jan 2023 10:28:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXP8ycxE_Sny0q+SAzLTwnaA3hks=ErW-ZfiMBw7ZMSgg@mail.gmail.com>
Message-ID: <CAMuHMdXP8ycxE_Sny0q+SAzLTwnaA3hks=ErW-ZfiMBw7ZMSgg@mail.gmail.com>
Subject: Re: Dhrystone -- userland version
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

On Mon, Jan 9, 2023 at 1:45 AM Theodore Ts'o <tytso@mit.edu> wrote:
> On Sun, Jan 08, 2023 at 07:47:07PM +0100, Pavel Machek wrote:
> > > However, as this is not Linux-specific, how hard can it be to convince
> > > your distro to include https://github.com/qris/dhrystone-deb.git?
> > > Usually, when I have a full userspace available, I just clone the above,
> > > and debuild it myself.
> >
> > Dunno. I'd not solve it if package was in Debian, but it is not.
>
> I would suspect the better long-term solution would be to get the
> package into Debian, since that will be easier for people to use.  I
> suspect the reason why most distros don't include it is because it
> really is a **terrible** benchmark for most use cases.

My use case is verifying the CPU core clock rate when working on
the clock driver and/or cpufreq.  I can easily measure e.g. SPI or
UART clock rates
externally, but not CPU core clock rates.

> (I'm not even convinced that using it to try to auto-tune the schedule
> by including a random dhrystone number in a device tree is reallty all
> that useful, but hey, I'm not a scheduler expert.)

I leave that to the scheduler people, too ;-)

> So I took a quick look at dhrystone-deb.git, as well as the original
> version of the Dhrystone source code at [1], and I do see huge red
> flag show-stopper that would prevent it from getting it into Debian.
>
> There are no copyright license notices anywhere in the source code,
> and from what I can tell, it was originally published in ACM's SIGPLAN
> Notices --- which even today is behind a paywall, so I presume it's
> under an ACM copyright.

Note that the version published by ACM was the original ADA version...

> Which makes me wonder --- did someone get copyright clearance from ACM
> and/or the original authors before this was published in a linux git
> tree?  And if not, we should get this clarified before someone sends a
> pull request to Linus with a potential copyright licensing problem.

I used "GPL-2.0-only OR BSD-2-Clause"[1], as the latter is what FreeBSD
uses, now augmented with calls into Linux-specific code.

Contacting the original author is no longer possible, unfortunately[3].
I don't know if Rick Richardson is still around.

> However, there are people who use the Linux kernel who are much
> touchier about copyright concerns, so if we can't build a Linux kernel
> without including lib/dhrystone.c, and we don't have copyright
> permission from ACM, I suspect some corporate lawyers would
> be.... uneasy.

Chromium hosts the Dhrystone benchmark as part of the LLVM testsuite,
under the LLVM license[4].  The Fuego Test System says MIT[5].

[1] https://lore.kernel.org/all/CAMuHMdXVkdmnKDobfZHkk+Lxradq238wAcaLOyW-cmS7J3MS4g@mail.gmail.com
[2] https://www.freshports.org/benchmarks/dhrystone/
[3] https://www.spec.org/spec/memories/reinhold/
[4] https://chromium.googlesource.com/native_client/pnacl-llvm-testsuite/+/c5be109f343430594ecec866dfa6d9833b921e1e/SingleSource/Benchmarks/Dhrystone/LICENSE.TXT
[5] http://fuegotest.org/server/Benchmark.Dhrystone

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
