Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A61F5E7ABF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 14:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiIWM23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 08:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiIWM2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 08:28:09 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC02B139F63
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 05:23:56 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id c11so8244425qtw.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 05:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mxDZwKAzNZt2zRVC0wtLoWkTnhHiobHwZDxR8SDLM4U=;
        b=A5DNYS+kppZgra8amf5fCa4Y7kTZEslMR6HrxyzWWflHFZdx11zgm48XvA1qBmJYaP
         oLWT+k1eCfL4It2pBLmPCEQXav/7I1VikB9FPbb4vwHWrZR+isd3mnCLpITXRFDQursL
         jlOaoxfcJOhKheBRY830Kqh27fbkCch+dASn+eGmt3gmdOaJA9jByK0DT0VJ8eGUa49W
         VU7tcGa3L/aHY8BaU6hNNn6Un5ipW71ZmFnxS+WOyiW8CSK2C9DHyhmFulpHcPZcrOZc
         tqlZljTu2lIdJHR7RBXN/ewo3/DpDKC5fsd1zAhRM2bwBjZQ1YOjaG8fqSfHrcJrKjnL
         OsQQ==
X-Gm-Message-State: ACrzQf3ThO8vY0lB1hAwQHBlB0pIIZhYNsxlq4rBJMbWgy3BLVt+hMz6
        lIcQs7GYz6cUvKWQejoNMa2HO07Upkz4jA==
X-Google-Smtp-Source: AMsMyM7ud1VgIC553gxL0SYtQJ4RgdHi0aDgcKk+4JeFX1eeR7hT6FZKaLv6BtAr1vKkHqNjySUwIQ==
X-Received: by 2002:ac8:5a41:0:b0:35c:fa93:f227 with SMTP id o1-20020ac85a41000000b0035cfa93f227mr6844316qta.102.1663935834439;
        Fri, 23 Sep 2022 05:23:54 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id u2-20020ae9d802000000b006ce407b996asm5602362qkf.69.2022.09.23.05.23.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 05:23:53 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 135so5116683ybl.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 05:23:53 -0700 (PDT)
X-Received: by 2002:a25:8e84:0:b0:696:466c:baa with SMTP id
 q4-20020a258e84000000b00696466c0baamr8375558ybl.604.1663935833560; Fri, 23
 Sep 2022 05:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220921185208.3549140-1-Jason@zx2c4.com> <20220921185208.3549140-2-Jason@zx2c4.com>
 <CAMuHMdUuM85s1APoxRmXnw13hHHEGgo8Z9EKvpV6maaZPaVUfA@mail.gmail.com> <CAHmME9pAsY4M=V0o4QLrrQiXwCvtiEO9FApBibXRiG41h-AgVA@mail.gmail.com>
In-Reply-To: <CAHmME9pAsY4M=V0o4QLrrQiXwCvtiEO9FApBibXRiG41h-AgVA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 23 Sep 2022 14:23:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUSF=ARvKTP33psHNWEqvSeUUDuWLRsUUA7LHa+12agng@mail.gmail.com>
Message-ID: <CAMuHMdUSF=ARvKTP33psHNWEqvSeUUDuWLRsUUA7LHa+12agng@mail.gmail.com>
Subject: Re: [PATCH 2/2] m68k: virt: generate new RNG seed on reboot
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
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

On Fri, Sep 23, 2022 at 1:53 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Fri, Sep 23, 2022 at 1:30 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > +static struct bi_record *rng_seed_record;
> >
> > This can be const...
> > >                 memzero_explicit((void *)data, len + 2);
> > > +                /* Store a reference to be filled in on reboot. */
> > > +               rng_seed_record = (void *)record;
> >
> > ... so this cast can be dropped.
>
> Will do.
>
> >
> > > +
> > >  static void virt_reset(void)
> > >  {
> > >         void __iomem *base = (void __iomem *)virt_bi_data.ctrl.mmio;
> > >
> > > +       if (rng_seed_record && rng_seed_record->size > sizeof(*rng_seed_record) + 2) {
> > > +               u16 len = rng_seed_record->size - sizeof(*rng_seed_record) - 2;
> > > +               get_random_bytes((u8 *)rng_seed_record->data + 2, len);
> > > +               *(u16 *)rng_seed_record->data = len;

Storing the length should use the proper cpu_to_be16 accessor.

> > Wouldn't it be simpler to just use the existing length?
> >
> >     if (rnd_seed_record) {
> >            u16 len = be16_to_cpup(data);
> >            get_random_bytes((u8 *)rng_seed_record->data + 2, len);
> >     }
>
> No, that would not work. len is 0 there, since we zero out the bytes
> after use for forward secrecy, and we zero out the length, so that we
> don't wind up feeding it zeros.

You're right. I misread the location of the "+ 2" in the clearing code.

> > However, I have my doubts this will actually work. Was this tested?
> > The bootinfo is passed from userspace, usually by reading
> > /proc/bootinfo, and adapting it where needed.
> > So I think you should implement this in kexec-tools instead.
>
> Yes, this was tested. This is to handle the reboot case, just as the
> commit subject says. Specifically, calling `reboot(RB_AUTOBOOT);`.

OK.

> It does *not* handle kexec. For that, indeed, kexec-tools needs to be
> augmented, but that's a separate patch that doesn't need to interact
> with this one.
>
> The way I tested this is by having my initramfs just call
> `reboot(RB_AUTOBOOT);`, and having add_bootloader_randomness() print
> its contents to the console. I checked that it was both present and
> different every time.

Are you sure the new kernel did receive the same randomness as prepared
by get_random_bytes()? I would expect it to just reboot into qemu,
reload the kernel from disk, and recreate a new bootinfo from scratch,
including generating a new random seed.

> I'll send a v2 with that const fix.

OK, thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
