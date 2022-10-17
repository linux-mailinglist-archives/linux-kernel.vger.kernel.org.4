Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46079601ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJQVBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJQVBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:01:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8CE1DA73;
        Mon, 17 Oct 2022 14:01:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39B0C61267;
        Mon, 17 Oct 2022 21:01:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C5BC43142;
        Mon, 17 Oct 2022 21:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666040508;
        bh=Z2H8cPp0/ZthnN/3soOj8NGIPmpILuFfUY3SKclznMM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bQFdhgdGa8T6xK3ZGvWAaBR3zFFFVPzB2/8SLdMRUffkIrGvoTskAz/vasWUGhd4Z
         jS+KJi/nrImaHttSgtj5f3Q7qm1HNPPVuNKAldKwj9ylERWqP9bJmH0GyfkuwqBNX4
         tym+v6go3gOnjQfXLJYp94fDkw9xGI6FzjM5h9HDWna5nabRgqX60Fu/fWO/+wh3Hs
         EaZtsB9RD2pOc+R1G3iPLLr24M3Rz2002q2/AT5MQpF2EUUghqjBU4P+LtZDeUXq2H
         jfOFrMXImvPU0h6uFSOFv3hrHwTFJ8X+XeJawjhaFtLm8Ol1sGOgAT7A+KqbHsvXbY
         39RzdPPoPdspA==
Received: by mail-lj1-f171.google.com with SMTP id bs14so15509099ljb.9;
        Mon, 17 Oct 2022 14:01:48 -0700 (PDT)
X-Gm-Message-State: ACrzQf3ewYdIyo5CiJ7DWiDxPgEvU0A2oYoyxs7H0sbHFeWaSXyTadtH
        +BCupAORwLAtj33crh9vYbUAFZE1/9BT4smZ/7U=
X-Google-Smtp-Source: AMsMyM7tWWA4XbRsgaNTss/+oEgDlhBOXKvTPLmyKEDTPmcMJ/XG1HhlNakIQ7nMs5d1QzO4Id4anJaGzkXXZqA2nhY=
X-Received: by 2002:a2e:9a81:0:b0:26c:5b63:7a83 with SMTP id
 p1-20020a2e9a81000000b0026c5b637a83mr5054864lji.291.1666040506574; Mon, 17
 Oct 2022 14:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221006234138.1835739-1-keescook@chromium.org>
 <191ec24d-35d4-e4e5-85f7-d7301984e647@igalia.com> <202210171100.5BAC4A5CC8@keescook>
 <CAMj1kXHzrRTVcxb5+hgUPV3tjekPcDWzVf6cG_Mc9JJmYBz2Mw@mail.gmail.com>
 <202210171227.35ED875219@keescook> <CAMj1kXEJQ8gh-iXZNL8bNcmV=JCmKHNp5BnhYthhSOyR5h79_g@mail.gmail.com>
 <202210171237.DF5D4A3FD7@keescook> <CAMj1kXGmsJNg7En-55aRF+ApicPD_Opkh8Jw+oTorSOSO+cfuw@mail.gmail.com>
 <202210171307.32A5D9C07@keescook> <CAMj1kXHced1khwsrHqMUmECh_7irYOckFd+Sx3z9KSmsL7tPxw@mail.gmail.com>
 <202210171333.309A3D9@keescook>
In-Reply-To: <202210171333.309A3D9@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 17 Oct 2022 23:01:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHTxc2PM1mz3pm-UEcmch9YG5QKF+JKAUNe9b+1L0OnfA@mail.gmail.com>
Message-ID: <CAMj1kXHTxc2PM1mz3pm-UEcmch9YG5QKF+JKAUNe9b+1L0OnfA@mail.gmail.com>
Subject: Re: [PATCH] pstore: migrate to crypto acomp interface (take 2)
To:     Kees Cook <keescook@chromium.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2022 at 22:36, Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Oct 17, 2022 at 10:13:52PM +0200, Ard Biesheuvel wrote:
> > On Mon, 17 Oct 2022 at 22:11, Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Mon, Oct 17, 2022 at 09:45:08PM +0200, Ard Biesheuvel wrote:
> > > > On Mon, 17 Oct 2022 at 21:40, Kees Cook <keescook@chromium.org> wrote:
> > > > > Okay, so strictly speaking, eliminating the per-CPU allocation is an
> > > > > improvement. Keeping scomp and doing in-place compression will let
> > > > > pstore use "any" compressions method.
> > > >
> > > > I'm not following the point you are making here.
> > >
> > > Sorry, I mean to say that if I leave scomp in pstore, nothing is "worse"
> > > (i.e. the per-cpu allocation is present in both scomp and acomp). i.e.
> > > no regression either way, but if we switch to a distinct library call,
> > > it's an improvement on the memory utilization front.
> > >
> > > > > Is there a crypto API that does _not_ preallocate the per-CPU stuff?
> > > > > Because, as you say, it's a huge amount of memory on the bigger
> > > > > systems...
> > > >
> > > > The library interface for each of the respective algorithms.
> > >
> > > Where is the crypto API for just using the library interfaces, so I
> > > don't have to be tied to a specific algo?
> > >
> >
> > That doesn't exist, that is the point.
>
> Shouldn't something like that exist, though?
>

Well, if what you have in mind is a pluggable API where abstract
compress() invocations can be backed by different implementations,
you'll soon find that you don't want to compile every alternative into
the kernel statically, and you'll need some kind of module dispatch.
That brings you very close to the crypto API already.

However, the main mismatch between the crypto API and a library
interface is the use of scatterlists, and this is the reason we have
those per-cpu buffers in the first place, as the underlying algos
don't operate on scatterlists, and so you need a scratch buffer to
hold the data. Another complication is that you cannot test for
in-place operation as easily by comparing src and dst pointers, given
that distinct scatterlists for src and may still describe the same
buffer in memory.

All this complexity is there to abstract from the differences between
software algos and h/w accelerators, but there only exists a single
instance of the latter in the tree, for HiSilicon SoCs, so this is
obviously not a resounding success.

In summary, we're better off sticking with the legacy comp interface,
but unfortunately, due to the way that has been plumbed into the
scomp/acomp with scatterlists version, that doesn't really help us get
rid of the memory overhead.


> > But how does the algo matter when you are dealing with mere kilobytes
> > of ASCII text?
>
> Sure, though, this is how we got here -- every couple of years, someone
> added another library interface to another compression aglo.

But why? How does that make a meaningful difference for compressing kernel logs?

> I tore all
> that out so we could avoid having to choose a single one, but was left
> with the zbufsize mess (that, yes, doesn't matter). So now pstore can
> just not care what compression is chosen.
>

What I propose is to simply hard wire pstore to a single existing
library implementation, and forget about the crypto API entirely.

We know the pros, given the above. So what would we lose that is
valuable by doing this?
