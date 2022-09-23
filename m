Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EE85E7B29
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 14:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiIWMuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 08:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiIWMuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 08:50:40 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFBB12CC9C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 05:50:34 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id g23so8314867qtu.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 05:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TIxUcLFewKUrI9Gr/MmE+wKa02a1LZQqMu2jG1Cimoc=;
        b=CT2S3S+Krlt4PUddaN/GIloLTXVkmAEvIGKC2nSXSlkKuoxUpTN9fJoqXdE9xyC8Wc
         hLtpmfG4sWirKWvUZgxi/4kGQPTkhNSFmwQUsug7J8UW0l02e1ao7/2SU+SyOez4gD5f
         jlJAP2ml5bMofv8tShPbZpnOjV8eNUJenE/qlOmQ/AoDV02Xo9tseEkWjiczYOq/BRx+
         0VIgzfvRBqok6XtvAtWBgUajVRCX268h0lDq/GFw8IFhonHqn29EV8MDVn4f0Y0O29d8
         OjN9ccpv8mjGL6WQyhamXwv9Wflc3F8tnje0GP/V0rMdYL7XrAppdk2dFShRIULBOuGo
         9sgA==
X-Gm-Message-State: ACrzQf2f6U8516mNUZdgG0yliRq9bgn9hh9wToaBUsDEZ68MF/DI77GQ
        YQTXumpSm92XL8mSiBAqGgRwFq8icr8PQQ==
X-Google-Smtp-Source: AMsMyM7ekuBOhzLhK9huiA1mrQxoGkimqmciJKtIKbeMPF0tOmR3jUt+ESnkFrhzjXo7N1+teV1zgg==
X-Received: by 2002:ac8:59d4:0:b0:35b:b9a4:8ff8 with SMTP id f20-20020ac859d4000000b0035bb9a48ff8mr6824019qtf.614.1663937433086;
        Fri, 23 Sep 2022 05:50:33 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id c6-20020a05620a268600b006cbb8ca04f8sm6262873qkp.40.2022.09.23.05.50.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 05:50:32 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id e81so16908157ybb.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 05:50:32 -0700 (PDT)
X-Received: by 2002:a25:8e84:0:b0:696:466c:baa with SMTP id
 q4-20020a258e84000000b00696466c0baamr8477549ybl.604.1663937432351; Fri, 23
 Sep 2022 05:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220921185208.3549140-1-Jason@zx2c4.com> <20220921185208.3549140-2-Jason@zx2c4.com>
 <CAMuHMdUuM85s1APoxRmXnw13hHHEGgo8Z9EKvpV6maaZPaVUfA@mail.gmail.com>
 <CAHmME9pAsY4M=V0o4QLrrQiXwCvtiEO9FApBibXRiG41h-AgVA@mail.gmail.com>
 <CAMuHMdUSF=ARvKTP33psHNWEqvSeUUDuWLRsUUA7LHa+12agng@mail.gmail.com> <CAHmME9ocjS11ugpKKwmosqb2HUBf4_N74a056=OOoj06yD6wmQ@mail.gmail.com>
In-Reply-To: <CAHmME9ocjS11ugpKKwmosqb2HUBf4_N74a056=OOoj06yD6wmQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 23 Sep 2022 14:50:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWruwCNqM3eLaaM9L+D+ZTw+t6z3O+rjNWTMiCQyj4_zQ@mail.gmail.com>
Message-ID: <CAMuHMdWruwCNqM3eLaaM9L+D+ZTw+t6z3O+rjNWTMiCQyj4_zQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] m68k: virt: generate new RNG seed on reboot
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Laurent Vivier <Laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Fri, Sep 23, 2022 at 2:26 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Fri, Sep 23, 2022 at 2:23 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > +       if (rng_seed_record && rng_seed_record->size > sizeof(*rng_seed_record) + 2) {
> > > > > +               u16 len = rng_seed_record->size - sizeof(*rng_seed_record) - 2;
> > > > > +               get_random_bytes((u8 *)rng_seed_record->data + 2, len);
> > > > > +               *(u16 *)rng_seed_record->data = len;
> >
> > Storing the length should use the proper cpu_to_be16 accessor.
>
> Okay, I'll do that for v2.
>
> (Simply out of curiosity, why? Isn't m68k always big endian and this
> is arch/ code?)

Yes it is.  But virt_parse_bootinfo() below already uses the right
accessor.

BTW, I guess people thought the same about PowerPC?
Although I agree the probability of someone creating a little-endian
m68k clone in an FPGA or SkyWater project and trying to run Linux on
it quite low ;-)

> > > The way I tested this is by having my initramfs just call
> > > `reboot(RB_AUTOBOOT);`, and having add_bootloader_randomness() print
> > > its contents to the console. I checked that it was both present and
> > > different every time.
> >
> > Are you sure the new kernel did receive the same randomness as prepared
> > by get_random_bytes()? I would expect it to just reboot into qemu,
> > reload the kernel from disk, and recreate a new bootinfo from scratch,
> > including generating a new random seed.
>
> Yes I'm sure. Without this patch, the new kernel sees the zeroed state.

That's interesting.  So QEMU preserves the old bootinfo, which is
AFAIK not guaranteed to be still available (that's why I added
save_bootinfo()).  Perhaps that works because only memory starting
from a rounded-up value of _end will be used, and you're just lucky?
I'm wondering what else it preserves. It sure has to reload the
kernel image, as at least the data section will no longer contain the
initialization values after a reboot...

Laurent?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
