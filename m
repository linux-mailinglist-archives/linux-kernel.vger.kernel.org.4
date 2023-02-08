Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3315C68F69D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBHSKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjBHSJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:09:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EE51BED
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 10:09:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78F446179A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 18:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BBBC4339C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 18:09:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YScLU8WA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1675879781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JOYXip39glVdXPnOanB6zCygr3LW1kqcLdaTjLZq8co=;
        b=YScLU8WAJq7zwx9zPZ1j0O4lJ0E9MGIw3bTecZY3+p4blqSvxpNVyXXHt8pwtsfBupsaCq
        osDAFQYqJaGtlvB9yWem8HoiDailPYKWj02IHDg9raADmvFyL0zzIwfTPJMzaw9h2LoKYN
        Bsl7/63McqgISxXWTrg/gjA/RiDmtg8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id db581de2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Wed, 8 Feb 2023 18:09:41 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id q9so2077192ybk.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 10:09:41 -0800 (PST)
X-Gm-Message-State: AO0yUKUy+PXC5dQlsO5DSH655/naVW5vsUWO7KWesVhb1Dd3zV9Pt7Og
        0UE3N8y25s198I7imBFeOP0fJ7AVzwitkHMlo2k=
X-Google-Smtp-Source: AK7set/Vl0tbDv9vbUQB8vt8A1LEoBKakLCdjnLoynIZLxn24iZnqQ4wyt+6FLRh05grhGgr5YqLXGyE1uSKalC6Bq0=
X-Received: by 2002:a25:9f90:0:b0:87b:121:93d8 with SMTP id
 u16-20020a259f90000000b0087b012193d8mr743695ybq.231.1675879780079; Wed, 08
 Feb 2023 10:09:40 -0800 (PST)
MIME-Version: 1.0
References: <Y69fUstLKNv/RLd7@zx2c4.com> <20221230220725.618763-1-Jason@zx2c4.com>
 <Y+Pf0q6LmQKN+FHo@dev-arch.thelio-3990X> <CAHmME9pQ6yvRQzzT_k0vmDFi4QioCfgryCebhvfNCWNP_tkddQ@mail.gmail.com>
In-Reply-To: <CAHmME9pQ6yvRQzzT_k0vmDFi4QioCfgryCebhvfNCWNP_tkddQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 8 Feb 2023 15:09:27 -0300
X-Gmail-Original-Message-ID: <CAHmME9rqCpEHAdJhKNACVx2a_o6LNS4Hy5ff6pX6o5oeJCRZOg@mail.gmail.com>
Message-ID: <CAHmME9rqCpEHAdJhKNACVx2a_o6LNS4Hy5ff6pX6o5oeJCRZOg@mail.gmail.com>
Subject: Re: [PATCH qemu v3] x86: don't let decompressed kernel image clobber setup_data
To:     Nathan Chancellor <nathan@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     pbonzini@redhat.com, ebiggers@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        ardb@kernel.org, kraxel@redhat.com, hpa@zytor.com, bp@alien8.de,
        philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 8, 2023 at 2:54 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Nathan (and MST),
>
> On Wed, Feb 8, 2023 at 2:45 PM Nathan Chancellor <nathan@kernel.org> wrot=
e:
> >
> > Hi Jason,
> >
> > On Fri, Dec 30, 2022 at 11:07:25PM +0100, Jason A. Donenfeld wrote:
> > > The setup_data links are appended to the compressed kernel image. Sin=
ce
> > > the kernel image is typically loaded at 0x100000, setup_data lives at
> > > `0x100000 + compressed_size`, which does not get relocated during the
> > > kernel's boot process.
> > >
> > > The kernel typically decompresses the image starting at address
> > > 0x1000000 (note: there's one more zero there than the compressed imag=
e
> > > above). This usually is fine for most kernels.
> > >
> > > However, if the compressed image is actually quite large, then
> > > setup_data will live at a `0x100000 + compressed_size` that extends i=
nto
> > > the decompressed zone at 0x1000000. In other words, if compressed_siz=
e
> > > is larger than `0x1000000 - 0x100000`, then the decompression step wi=
ll
> > > clobber setup_data, resulting in crashes.
> > >
> > > Visually, what happens now is that QEMU appends setup_data to the ker=
nel
> > > image:
> > >
> > >           kernel image            setup_data
> > >    |--------------------------||----------------|
> > > 0x100000                  0x100000+l1     0x100000+l1+l2
> > >
> > > The problem is that this decompresses to 0x1000000 (one more zero). S=
o
> > > if l1 is > (0x1000000-0x100000), then this winds up looking like:
> > >
> > >           kernel image            setup_data
> > >    |--------------------------||----------------|
> > > 0x100000                  0x100000+l1     0x100000+l1+l2
> > >
> > >                                  d e c o m p r e s s e d   k e r n e =
l
> > >                      |-----------------------------------------------=
--------------|
> > >                 0x1000000                                            =
         0x1000000+l3
> > >
> > > The decompressed kernel seemingly overwriting the compressed kernel
> > > image isn't a problem, because that gets relocated to a higher addres=
s
> > > early on in the boot process, at the end of startup_64. setup_data,
> > > however, stays in the same place, since those links are self referent=
ial
> > > and nothing fixes them up.  So the decompressed kernel clobbers it.
> > >
> > > Fix this by appending setup_data to the cmdline blob rather than the
> > > kernel image blob, which remains at a lower address that won't get
> > > clobbered.
> > >
> > > This could have been done by overwriting the initrd blob instead, but
> > > that poses big difficulties, such as no longer being able to use memo=
ry
> > > mapped files for initrd, hurting performance, and, more importantly, =
the
> > > initrd address calculation is hard coded in qboot, and it always grow=
s
> > > down rather than up, which means lots of brittle semantics would have=
 to
> > > be changed around, incurring more complexity. In contrast, using cmdl=
ine
> > > is simple and doesn't interfere with anything.
> > >
> > > The microvm machine has a gross hack where it fiddles with fw_cfg dat=
a
> > > after the fact. So this hack is updated to account for this appending=
,
> > > by reserving some bytes.
> > >
> > > Cc: x86@kernel.org
> > > Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > > Cc: H. Peter Anvin <hpa@zytor.com>
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Cc: Eric Biggers <ebiggers@kernel.org>
> > > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> >
> > I apologize if this has already been reported/fixed already (I did a
> > brief search on lore.kernel.org) or if my terminology is not as precise
> > as it could be, I am a little out of my element here :)
> >
> > After this change as commit eac7a7791b ("x86: don't let decompressed
> > kernel image clobber setup_data") in QEMU master, I am no longer able t=
o
> > boot a kernel directly through OVMF using '-append' + '-initrd' +
> > '-kernel'. Instead, systemd-boot tries to start the distribution's
> > kernel, which fails with:
> >
> >   Error registering initrd: Already started
> >
> > This can be reproduced with just a defconfig Linux kernel (I used
> > 6.2-rc7), the simple buildroot images that ClangBuiltLinux uses for
> > boot testing [1], and OVMF. Prior to this change, the kernel would star=
t
> > up but after, I am dumped into the UEFI shell (as there is no
> > bootloader).
> >
> > The QEMU command I used was:
> >
> > $ qemu-system-x86_64 \
> >     -kernel arch/x86_64/boot/bzImage \
> >     -append "console=3DttyS0 earlycon=3Duart8250,io,0x3f8" \
> >     -drive if=3Dpflash,format=3Draw,file=3D/usr/share/edk2/x64/OVMF_COD=
E.fd,readonly=3Don
> >     -drive if=3Dpflash,format=3Draw,file=3D../boot-utils/images/x86_64/=
OVMF_VARS.fd \
>
> Oh no... Without jumping into it, at first glance, I have absolutely
> no idea. I suppose I could start debugging it and probably come up
> with a solution, but...
>
> @mst - I'm beginning to think that this whole setup_data route is
> cursed. This is accumulating hacks within hacks within hacks. What
> would you think if I just send a patch *removing* all use of
> setup_data (the rng seed and the dtb thing), and then we can gradually
> add that back with an actual overarching design. For example, it'd
> probably make sense to have a separate fwcfg file for setup_data
> rather than trying to mangle and existing one, etc. This way, we
> unbreak the tree, and let the new approach be reviewed more
> reasonably.

Sent as https://lore.kernel.org/qemu-devel/20230208180835.234638-1-Jason@zx=
2c4.com/
