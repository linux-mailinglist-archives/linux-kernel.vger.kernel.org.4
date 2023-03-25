Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CF26C8E4A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjCYMpF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 25 Mar 2023 08:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCYMpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:45:03 -0400
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7E111171
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:45:02 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id o20so1423715ljp.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679748300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3FEH8eZrFvGP+z3Ek8xngh+/YrLq34X8EDL4pF+Bk0=;
        b=1R0leLUNmpOn4Ju0jJsAo6Z8rOhoF5Ul9cswW46b7UHIVBulzhoIrtbXxYBphHJZlv
         XY1KAWtHm059mDx8ssipMvwpiMzrZl1pYHXUbdXxfjRqZHXZTV19AzbKkRB5UU45D/2A
         70Of4gra5WmdAmT8QQ54m44YVtfbDl7TJhXlCkWiRMsUHH2t8BW/VOcM0eRrSx1RkkVB
         kQLzw58IlQhJqiB6cPfr5u857X4CvFzmOKe9chHpgP9TnUYW1Qbqu1Kfgiqgnx88yh0a
         LHoASYgssoRqDnsgfwOWUzkYiCH5sAL2gnxUcHMAJ9y7NSjQaju7zLWDWPjdU7YTg+hG
         OlhQ==
X-Gm-Message-State: AAQBX9dSrfATUQIOBJXgKqUhy40ICcg+8/Knd31bHgy0l/Bfx1W64EZp
        khI1vckSALrIMgaRGrdD4EFnzNW9B8mcJXA+
X-Google-Smtp-Source: AKy350btyW/VCczlSnEvICH8jwgr9LvakYGByOvxtyZp8/4qbrzi6Q43ZcwzdhzmQCTcJQWyBbr6HQ==
X-Received: by 2002:a2e:7005:0:b0:295:93eb:e795 with SMTP id l5-20020a2e7005000000b0029593ebe795mr1976945ljc.41.1679748299595;
        Sat, 25 Mar 2023 05:44:59 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id u22-20020a2e8456000000b00295b2e08b90sm3680485ljh.65.2023.03.25.05.44.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 05:44:59 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id t11so5581565lfr.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:44:59 -0700 (PDT)
X-Received: by 2002:a05:6512:143:b0:4db:266c:4338 with SMTP id
 m3-20020a056512014300b004db266c4338mr1703638lfo.1.1679748299291; Sat, 25 Mar
 2023 05:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <5b7c473247d66776343d82a55b9815195b1b11fb.1679551394.git.fthain@linux-m68k.org>
 <CAMuHMdUJ6kbpYGTjyY5dX+-YRv3pL0ydG3HQ-H1khyeqLOa05A@mail.gmail.com>
 <072fd894-ec50-ae5f-2be5-ebbeb0e7b39b@linux-m68k.org> <20230324085927.GA6354@allandria.com>
 <0cd7f288-ba43-7764-01a7-2e1e5c7a1640@linux-m68k.org>
In-Reply-To: <0cd7f288-ba43-7764-01a7-2e1e5c7a1640@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 25 Mar 2023 13:44:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXi1mF=j_Qzzg971AqHF-JdgfaDd+v0HymXXusFt-WBUQ@mail.gmail.com>
Message-ID: <CAMuHMdXi1mF=j_Qzzg971AqHF-JdgfaDd+v0HymXXusFt-WBUQ@mail.gmail.com>
Subject: Re: [PATCH v2] nubus: Don't list card resources by default
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Brad Boyer <flar@allandria.com>, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Sat, Mar 25, 2023 at 12:33 AM Finn Thain <fthain@linux-m68k.org> wrote:
> On Fri, 24 Mar 2023, Brad Boyer wrote:
> > On Fri, Mar 24, 2023 at 10:13:51AM +1100, Finn Thain wrote:
> > > On Thu, 23 Mar 2023, Geert Uytterhoeven wrote:
> > > > On Thu, Mar 23, 2023 at 7:02???AM Finn Thain <fthain@linux-m68k.org> wrote:
> > > > > --- a/drivers/nubus/nubus.c
> > > > > +++ b/drivers/nubus/nubus.c
> > > > > @@ -34,6 +34,9 @@
> > > > >
> > > > >  LIST_HEAD(nubus_func_rsrcs);
> > > > >
> > > > > +bool procfs_rsrcs;
> > > > > +module_param(procfs_rsrcs, bool, 0444);
> > > >
> > > > With the expanded functionality, is "rsrcs" still a good name?
> > > > Perhaps this should be an integer, so you can define different
> > > > levels? E.g.
> > > >   - 0 = just devices
> > > >   - 1 = above + boards + public resources
> > > >   - 2 = above + private resources
> > >
> > > That really depends on how the proc entries get used. I think it's
> > > probably going to be developers who would use them so I consider all
> > > of this to be outside of the UAPI and subject to change. But it would
> > > be nice to hear from other developers on that point.
> >
> > I don't know of anything that currently uses them, but there's a number
> > of potential uses depending on how far we want to take things. A real
> > video driver for X.org for some of the more advanced cards could take
> > advantage of some of the secondary information made available. I've got
> > a number of NuBus video cards with some acceleration capabilities that
> > were pretty advanced for the time.
>
> Good point. I had not considered Xorg drivers. But I'm not sure why
> userspace drivers would access /proc when they already need /dev/mem or
> some more modern graphics API to be implemented by an in-kernel driver.
>
> > There's even a driver in the ROM on video cards that could be used, but
> > that also requires more emulation of the MacOS environment. KVM could
> > potentially need more information if we got it running on m68k, although
> > I doubt any real Mac has enough RAM to make that useful.
>
> You only need a few MB to run MacOS (or an early Linux distro). So I
> rather think that KVM could be workable with 64 or 128 MB of RAM.
>
> The /proc/bus/nubus/boards file is not affected by this patch, so userland
> tools could still identify the available boards if need be.

Perhaps it would be worthwhile to move the resources out of /proc,
but into a separate virtual file system?
That way people who need access to the additional info can load the
separate virtual file system kernel module, and mount the file system?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
