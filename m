Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17E25E7A05
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiIWLxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiIWLxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:53:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC63138F0D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:53:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D55CB82EEF
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 11:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E3FC433D7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 11:53:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OWdhdAy6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663934013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hx2pBFFQZ2hQiwU5v3ghPr4Q2vXv/4ROSWTFrLQojKc=;
        b=OWdhdAy6461hrSZDn1oOkxuOWPdoHmDlAyhAR9s4fY/kVfJ4I9ukjzBUusvQycSrzMgMvB
        O1BEZPXgIalatIb5SLNR7B6fEwvfXlcxxyinprynMp48Udrf1PrAhZPwoVqRdZHAJHZqhY
        Xxe5e+D3bbTO1xa73JDRphp0Pv79ONo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b8acf6da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 23 Sep 2022 11:53:33 +0000 (UTC)
Received: by mail-ua1-f52.google.com with SMTP id i17so4779232uaq.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:53:32 -0700 (PDT)
X-Gm-Message-State: ACrzQf0A0NqNTC81vxa5qoR+wCJZF7aY0YZee9elK4wDuMEBn+izPQr5
        nx407aegDvRm5mjFcsbqMdvlt2kXp0OGVcpG1Uw=
X-Google-Smtp-Source: AMsMyM6JgQZl7kN56NJPsJMgp1u5o38zeZ+Zm6L/2SbaH3FXXFcNFbp0pTGCriZr4LvCxpR7U8wCLl+nQ8DIK8eOEVY=
X-Received: by 2002:ab0:6154:0:b0:398:c252:23d8 with SMTP id
 w20-20020ab06154000000b00398c25223d8mr3488274uan.65.1663934012143; Fri, 23
 Sep 2022 04:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220921185208.3549140-1-Jason@zx2c4.com> <20220921185208.3549140-2-Jason@zx2c4.com>
 <CAMuHMdUuM85s1APoxRmXnw13hHHEGgo8Z9EKvpV6maaZPaVUfA@mail.gmail.com>
In-Reply-To: <CAMuHMdUuM85s1APoxRmXnw13hHHEGgo8Z9EKvpV6maaZPaVUfA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 23 Sep 2022 13:53:21 +0200
X-Gmail-Original-Message-ID: <CAHmME9pAsY4M=V0o4QLrrQiXwCvtiEO9FApBibXRiG41h-AgVA@mail.gmail.com>
Message-ID: <CAHmME9pAsY4M=V0o4QLrrQiXwCvtiEO9FApBibXRiG41h-AgVA@mail.gmail.com>
Subject: Re: [PATCH 2/2] m68k: virt: generate new RNG seed on reboot
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Fri, Sep 23, 2022 at 1:30 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > +static struct bi_record *rng_seed_record;
>
> This can be const...
> >                 memzero_explicit((void *)data, len + 2);
> > +                /* Store a reference to be filled in on reboot. */
> > +               rng_seed_record = (void *)record;
>
> ... so this cast can be dropped.

Will do.

>
> > +
> >  static void virt_reset(void)
> >  {
> >         void __iomem *base = (void __iomem *)virt_bi_data.ctrl.mmio;
> >
> > +       if (rng_seed_record && rng_seed_record->size > sizeof(*rng_seed_record) + 2) {
> > +               u16 len = rng_seed_record->size - sizeof(*rng_seed_record) - 2;
> > +               get_random_bytes((u8 *)rng_seed_record->data + 2, len);
> > +               *(u16 *)rng_seed_record->data = len;
>
> Wouldn't it be simpler to just use the existing length?
>
>     if (rnd_seed_record) {
>            u16 len = be16_to_cpup(data);
>            get_random_bytes((u8 *)rng_seed_record->data + 2, len);
>     }

No, that would not work. len is 0 there, since we zero out the bytes
after use for forward secrecy, and we zero out the length, so that we
don't wind up feeding it zeros.

>
> However, I have my doubts this will actually work. Was this tested?
> The bootinfo is passed from userspace, usually by reading
> /proc/bootinfo, and adapting it where needed.
> So I think you should implement this in kexec-tools instead.

Yes, this was tested. This is to handle the reboot case, just as the
commit subject says. Specifically, calling `reboot(RB_AUTOBOOT);`.

It does *not* handle kexec. For that, indeed, kexec-tools needs to be
augmented, but that's a separate patch that doesn't need to interact
with this one.

The way I tested this is by having my initramfs just call
`reboot(RB_AUTOBOOT);`, and having add_bootloader_randomness() print
its contents to the console. I checked that it was both present and
different every time.

I'll send a v2 with that const fix.

Jason
