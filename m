Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2631168F6AB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjBHSMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBHSMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:12:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDE3113EF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 10:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675879858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w9/f/MOvQp5IAgOQDRaxUjgUOW0JDTw4EI3n537Ih6U=;
        b=M+04iltVJhj8O4YuwP4rBPvxAqPg3Vz5QrsbrdZMHBj5aujYryY4NYEqcx18i7y0gYgsP7
        nf8SM56AQoy2t6I2aIozWvuZFs2h0/fw2qFYWskKxLS7pbvBzJEfKvrqVsQ39TZVzAqI/g
        XNasoeZnK09WG2iWYTC2COHZK+21bM8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-605-8c8owj2KPeWKJbbGZZcmLA-1; Wed, 08 Feb 2023 13:10:56 -0500
X-MC-Unique: 8c8owj2KPeWKJbbGZZcmLA-1
Received: by mail-ed1-f72.google.com with SMTP id z19-20020a05640235d300b004aaca83cd87so4504227edc.20
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 10:10:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9/f/MOvQp5IAgOQDRaxUjgUOW0JDTw4EI3n537Ih6U=;
        b=uMhuBe+HTHYppjfG8rsWpVaVHgP0AJ77clJIKoSNDsd4wbH7uDRTDWMy9IWda5k7Bb
         WbI/5l005i1EWK/TScLS9nssKsflVnm5PgC6V3tURP3/dTE62zmu5ZjUkB7/nkvpCi0T
         G7+mu80pc4QbMa9vTTIXFvUYgOoKSa9StJrki1YxC+uUwoRPzgPj0IEDQnTrTcf0Ie6j
         rqLmdpfvYxtwr7tVYFjAhcnkJqpgkjZd2ztHtdPruJs4iK1US/A/rINCFusJS1n9SiP8
         DveXDdwqwzQyIkW7wzdxz12vUsiXnTZsb60bKTrRAl3gt8UjwfUL1x0QlT5jHmqDcqz+
         jETg==
X-Gm-Message-State: AO0yUKUVIiuDKFLW2yjOa0kbTH/8f45J0qqO8bkkAWPcAESS+BAfqduT
        rh1NLS4p+S16A5XyMWNLJPtkMY1QLRojl5aE/MO06rY8zeVky/mlLgH19iknNlHtYjmallFVJp1
        nikLR4h7nIH9eaQbN1rBcV0pUOuPtYhxn
X-Received: by 2002:a50:8746:0:b0:4a0:e234:5351 with SMTP id 6-20020a508746000000b004a0e2345351mr9582151edv.15.1675879855058;
        Wed, 08 Feb 2023 10:10:55 -0800 (PST)
X-Google-Smtp-Source: AK7set8KbCd/jX0TGW03RDuhZNYyg1q2LUeQ1QMJZ7jKfoCOrGy4UjA3Z4M5GoaTHaEqDrf7ZXxdew==
X-Received: by 2002:a50:8746:0:b0:4a0:e234:5351 with SMTP id 6-20020a508746000000b004a0e2345351mr9582140edv.15.1675879854844;
        Wed, 08 Feb 2023 10:10:54 -0800 (PST)
Received: from redhat.com ([2.52.132.212])
        by smtp.gmail.com with ESMTPSA id v21-20020a50d595000000b004aaa09d50adsm6415207edi.94.2023.02.08.10.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 10:10:54 -0800 (PST)
Date:   Wed, 8 Feb 2023 13:10:50 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Nathan Chancellor <nathan@kernel.org>, pbonzini@redhat.com,
        ebiggers@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, ardb@kernel.org, kraxel@redhat.com,
        hpa@zytor.com, bp@alien8.de, philmd@linaro.org
Subject: Re: [PATCH qemu v3] x86: don't let decompressed kernel image clobber
 setup_data
Message-ID: <20230208130835-mutt-send-email-mst@kernel.org>
References: <Y69fUstLKNv/RLd7@zx2c4.com>
 <20221230220725.618763-1-Jason@zx2c4.com>
 <Y+Pf0q6LmQKN+FHo@dev-arch.thelio-3990X>
 <CAHmME9pQ6yvRQzzT_k0vmDFi4QioCfgryCebhvfNCWNP_tkddQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHmME9pQ6yvRQzzT_k0vmDFi4QioCfgryCebhvfNCWNP_tkddQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 02:54:41PM -0300, Jason A. Donenfeld wrote:
> Hi Nathan (and MST),
> 
> On Wed, Feb 8, 2023 at 2:45 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Hi Jason,
> >
> > On Fri, Dec 30, 2022 at 11:07:25PM +0100, Jason A. Donenfeld wrote:
> > > The setup_data links are appended to the compressed kernel image. Since
> > > the kernel image is typically loaded at 0x100000, setup_data lives at
> > > `0x100000 + compressed_size`, which does not get relocated during the
> > > kernel's boot process.
> > >
> > > The kernel typically decompresses the image starting at address
> > > 0x1000000 (note: there's one more zero there than the compressed image
> > > above). This usually is fine for most kernels.
> > >
> > > However, if the compressed image is actually quite large, then
> > > setup_data will live at a `0x100000 + compressed_size` that extends into
> > > the decompressed zone at 0x1000000. In other words, if compressed_size
> > > is larger than `0x1000000 - 0x100000`, then the decompression step will
> > > clobber setup_data, resulting in crashes.
> > >
> > > Visually, what happens now is that QEMU appends setup_data to the kernel
> > > image:
> > >
> > >           kernel image            setup_data
> > >    |--------------------------||----------------|
> > > 0x100000                  0x100000+l1     0x100000+l1+l2
> > >
> > > The problem is that this decompresses to 0x1000000 (one more zero). So
> > > if l1 is > (0x1000000-0x100000), then this winds up looking like:
> > >
> > >           kernel image            setup_data
> > >    |--------------------------||----------------|
> > > 0x100000                  0x100000+l1     0x100000+l1+l2
> > >
> > >                                  d e c o m p r e s s e d   k e r n e l
> > >                      |-------------------------------------------------------------|
> > >                 0x1000000                                                     0x1000000+l3
> > >
> > > The decompressed kernel seemingly overwriting the compressed kernel
> > > image isn't a problem, because that gets relocated to a higher address
> > > early on in the boot process, at the end of startup_64. setup_data,
> > > however, stays in the same place, since those links are self referential
> > > and nothing fixes them up.  So the decompressed kernel clobbers it.
> > >
> > > Fix this by appending setup_data to the cmdline blob rather than the
> > > kernel image blob, which remains at a lower address that won't get
> > > clobbered.
> > >
> > > This could have been done by overwriting the initrd blob instead, but
> > > that poses big difficulties, such as no longer being able to use memory
> > > mapped files for initrd, hurting performance, and, more importantly, the
> > > initrd address calculation is hard coded in qboot, and it always grows
> > > down rather than up, which means lots of brittle semantics would have to
> > > be changed around, incurring more complexity. In contrast, using cmdline
> > > is simple and doesn't interfere with anything.
> > >
> > > The microvm machine has a gross hack where it fiddles with fw_cfg data
> > > after the fact. So this hack is updated to account for this appending,
> > > by reserving some bytes.
> > >
> > > Cc: x86@kernel.org
> > > Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
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
> > kernel image clobber setup_data") in QEMU master, I am no longer able to
> > boot a kernel directly through OVMF using '-append' + '-initrd' +
> > '-kernel'. Instead, systemd-boot tries to start the distribution's
> > kernel, which fails with:
> >
> >   Error registering initrd: Already started
> >
> > This can be reproduced with just a defconfig Linux kernel (I used
> > 6.2-rc7), the simple buildroot images that ClangBuiltLinux uses for
> > boot testing [1], and OVMF. Prior to this change, the kernel would start
> > up but after, I am dumped into the UEFI shell (as there is no
> > bootloader).
> >
> > The QEMU command I used was:
> >
> > $ qemu-system-x86_64 \
> >     -kernel arch/x86_64/boot/bzImage \
> >     -append "console=ttyS0 earlycon=uart8250,io,0x3f8" \
> >     -drive if=pflash,format=raw,file=/usr/share/edk2/x64/OVMF_CODE.fd,readonly=on
> >     -drive if=pflash,format=raw,file=../boot-utils/images/x86_64/OVMF_VARS.fd \
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
> 
> Jason

Yea basically this is close to what I proposed. I can't off-hand figure
out whether just dropping all of this is fine or we need some compat
hacks to enable this in some way for 7.2, and it's pretty late here.
Suggestions welcome.

-- 
MST

