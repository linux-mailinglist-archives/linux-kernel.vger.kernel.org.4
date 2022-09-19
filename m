Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31055BCA87
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiISLSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiISLR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:17:59 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0773210543
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:17:58 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x94so23443062ede.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=989atl73zj2pSk9DVjp8+DPnil95ZWwqtwLB3IxnWyU=;
        b=jJ4yKqcbVHltC2A8rcPSpD+iorkrdLxcJ8E8zj9NKR0K3yYzD/aog3b8B8GMQtCwpt
         8t6ZfD38F2qMX/d7o8WGQEOGenAKQVmU1UxVYu+PXSnF9W4LKle++HkSPspt1OmuBmNC
         sMRzg7WIuguqoJpBBOydf92c9TwXIvwCv33e8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=989atl73zj2pSk9DVjp8+DPnil95ZWwqtwLB3IxnWyU=;
        b=Vkhwqd4pZM5+8+AVV+qRpnBSgFno7NnBlbEYb9MdjB3iVsX0Y6+NA7m9kEQSqPObw6
         wyPUZt7xMYoaLwk/7PVJi4MoSn9j3Wo5WZzudVCGjcCIC/0R86fiZlQMzYdESOWo0auL
         j3LuuuS4Kyx+GmUyXCIFO2D51I202lV1weHGChHEojvyRyST3JynNCABVQBqfT5qIeeN
         Em/ZAkdhiwUJNhddfJDSLAAe0LPptsCUuiuIlar/RaQsEc9KaGWZX9h2Vj/j3DSnFvYd
         +CVMCzr/gQn7BFNltMBvHRT4lSdDPcnNy7FTGN4oXhhbPxAPOhqzq41Gn6oQtGdPUq9n
         vyqg==
X-Gm-Message-State: ACrzQf1wTYIOEQIDPX57waWS5AQY89zWcyLZJpVu7zD61mvjLhs+Lir/
        85+U7szQoQoLSXxPCo9tFKIqEwaGZnMBEH/A9PuxVQ==
X-Google-Smtp-Source: AMsMyM78+vQORu2pJ+JZKgKKBoOYzijE4hZW3rdcDaH9MBs6GG5wOs2t0FphsSfIuH+zuYsBIYUPD7qQY8P8rJGDC5g=
X-Received: by 2002:a05:6402:4011:b0:44e:b8b5:f52e with SMTP id
 d17-20020a056402401100b0044eb8b5f52emr15051462eda.352.1663586276447; Mon, 19
 Sep 2022 04:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAOf5uwk=Tx+W-JuJBXUYjt2BLmSvr9Q153D1RTyJG_cmeO4AUw@mail.gmail.com>
 <826cd775-14d2-12ae-2e96-cf0766aa1502@redhat.com> <CAOf5uwmKfcC0OiiuN82tUzcE1XkPuA3N3u+o3Ue_ZPNJqeSM+g@mail.gmail.com>
 <4475783a-73c1-94f1-804e-507abeb84ab1@redhat.com> <CAOf5uwk8RLRrMa3vM-1+k0oi8XfnWVZH6_uc_UtagWYFVrMYKQ@mail.gmail.com>
 <c2efeb24-0da0-ee25-7cb9-2b9b05523f25@redhat.com>
In-Reply-To: <c2efeb24-0da0-ee25-7cb9-2b9b05523f25@redhat.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Mon, 19 Sep 2022 13:17:45 +0200
Message-ID: <CAOf5uwkq0aLg8KQB1HFRqPafXpk0_YohW_U_O5=8oQWcui-avQ@mail.gmail.com>
Subject: Re: Correlation CMA size and FORCE_MAX_ZONEORDER
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Mon, Sep 19, 2022 at 1:03 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 19.09.22 11:57, Michael Nazzareno Trimarchi wrote:
> > Hi
> >
> > On Mon, Sep 19, 2022 at 11:31 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 19.09.22 11:17, Michael Nazzareno Trimarchi wrote:
> >>> Hi David
> >>>
> >>> On Mon, Sep 19, 2022 at 10:38 AM David Hildenbrand <david@redhat.com> wrote:
> >>>>
> >>>> On 15.09.22 23:36, Michael Nazzareno Trimarchi wrote:
> >>>>> Hi all
> >>>>
> >>>> Hi,
> >>>>
> >>>>>
> >>>>> Working on a small device with 128MB of memory and using imx_v6_v7
> >>>>> defconfig I found that CMA_SIZE_MBYTES, CMA_SIZE_PERCENTAGE
> >>>>> are not respected. The calculation done does not allow the requested
> >>>>> size. I think that this should be somehow documented and described but
> >>>>> I did not
> >>>>> find the documentation. Does it work this way?
> >>>>>
> >>>>> With CMA_SIZE of 8MB I need to have FORCE_MAX_ZONEORDER=12 if I have
> >>>>> the default FORCE_MAX_ZONEORDER=14 the min size is 32Mb
> >>>>
> >>>> The underlying constraint is that CMA regions require a certain minimum
> >>>> alignment+size. They cannot be arbitrarily in size.
> >>>>
> >>>> CMA_MIN_ALIGNMENT_BYTES expresses that, and corresponds in upstream
> >>>> kernels to the size of a single pageblock.
> >>>>
> >>>> In previous kernels, it used to be the size of the largest buddy
> >>>> allocation granularity (derived from MAX_ORDER, derived from
> >>>> FORCE_MAX_ZONEORDER).
> >>>>
> >>>> On upstream kernels, the FORCE_MAX_ZONEORDER constraint should no longer
> >>>> apply. On most archs, the minimum alignment+size should be 2 MiB
> >>>> (x86-64, aarch64 with 4k base pages) -- the size of a single pageblock.
> >>>>
> >>>> So far the theory. Are you still running into this limitation on
> >>>> upstream kernels?
> >>>>
> >>>
> >>> I can run 6-rc2 on my board. I test again but according to it, if I
> >>> put 4M as CMA in cma=4M in boot
> >>> parameters, the result is 32Mb of CMA. Apart of that seems that
> >>> process lime tiny membench can not even start
> >>> to mblock memory
> >>>
> >>
> >> The CMA alignemnt change went into v5.19. If "cma=4M" still gives you >
> >> 4M, can you post /proc/meminfo and the early console output?
> >>
> >
> > cat /proc/cmdline
> > cma=4M mtdparts=gpmi-nand:4m(nandboot),1m(env),24m(kernel),1m(nanddtb),-(rootfs)
> > root=ubi0:root rw ubi.mtd=ro
> > otfs rootfstype=ubifs rootwait=1
> > # cat /proc/meminfo
> > MemTotal:         109560 kB
> > MemFree:           56084 kB
> > MemAvailable:      56820 kB
> > Buffers:               0 kB
> > Cached:            39680 kB
> > SwapCached:            0 kB
> > Active:               44 kB
> > Inactive:            644 kB
> > Active(anon):         44 kB
> > Inactive(anon):      644 kB
> > Active(file):          0 kB
> > Inactive(file):        0 kB
> > Unevictable:       39596 kB
> > Mlocked:               0 kB
> > HighTotal:             0 kB
> > HighFree:              0 kB
> > LowTotal:         109560 kB
> > LowFree:           56084 kB
> > SwapTotal:             0 kB
> > SwapFree:              0 kB
> > Dirty:                 0 kB
> > Writeback:             0 kB
> > AnonPages:           628 kB
> > Mapped:             1480 kB
> > Shmem:                84 kB
> > KReclaimable:       4268 kB
> > Slab:               8456 kB
> > SReclaimable:       4268 kB
> > SUnreclaim:         4188 kB
> > KernelStack:         392 kB
> > PageTables:           88 kB
> > NFS_Unstable:          0 kB
> > Bounce:                0 kB
> > WritebackTmp:          0 kB
> > CommitLimit:       54780 kB
> > Committed_AS:       1876 kB
> > VmallocTotal:     901120 kB
> > VmallocUsed:        2776 kB
> > VmallocChunk:          0 kB
> > Percpu:               72 kB
> > CmaTotal:          32768 kB
> > CmaFree:           32484 kB
> > # uname -a
> > Linux buildroot 6.0.0-rc5 #20 SMP Mon Sep 19 11:51:26 CEST 2022 armv7l GNU/Linux
> > #
> >
> > Then here https://pastebin.com/6MUB2VBM dmesg
> >
> > CONFIG_ARM_MODULE_PLTS=y
> > CONFIG_FORCE_MAX_ZONEORDER=14
> > CONFIG_ALIGNMENT_TRAP=y
> > ...
> > CONFIG_CMA
> > CONFIG_CMA_AREAS=7
> > ...
> >
> > CONFIG_CMA_SIZE_MBYTES=8
> > CONFIG_CMA_SIZE_SEL_MBYTES=y
> >
>
> Thanks!
>
> I assume that in your setup, the pageblock size depends on MAX_ORDER
> and, therefore, FORCE_MAX_ZONEORDER.
>
> This should be the case especially if CONFIG_HUGETLB_PAGE is not defined
> (include/linux/pageblock-flags.h).
>
> In contrast to what I remember, the pageblock size does not seem to
> depend on the THP size (weird) as well.
>
>
> So, yes, that limitation is still in effect for some kernel configs.
>
> One could make the pageblock size configurable (similar to
> CONFIG_HUGETLB_PAGE_SIZE_VARIABLE) or simply default to a smaller
> pageblock size as default with CONFIG_CMA and !CONFIG_HUGETLB_PAGE.
>
> I imagine something reasonable might be to set the pageblock size to
> 2MiB without CONFIG_HUGETLB_PAGE but with CONFIG_CMA.
>

I don't think making more configuration options makes things clear.
When we enable some configuration
we can force down the configuration. You need to explain clearly how
you envision it. FORCE_MAX_ZONEORDER
for me is the largest allocation that you can get from a zone (ex CMA
one). Any request allocation that is align to the
CMA align and can fit inside a region should be allowed

What am I missing?

Michael

> --
> Thanks,
>
> David / dhildenb
>
--
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
