Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8771F732A11
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245747AbjFPIlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343627AbjFPIkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:40:46 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1DD30D7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:40:32 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-970028cfb6cso64158266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686904830; x=1689496830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hUmPtWFh5/EWum1zehJNPIUaxqrN5E+ZkPwZ+4G0HY=;
        b=5Y1FW0H3JrfD9KIMsSvaqegsfT9Lim5Lc3nlqwXDCgMSk9svoe9Q1G9YkYCsR1HilR
         n+I6XjUPAZuUyEk50NIdkPrUZ4v4fyI1lafXc+lL4LzvxG6rbkRaXJ6umA6mmpq4eRTm
         tyVR+YtTZj/CAsMLUTL+xHMrdTRCjEKWVEhypARIarat710jwIsDM4vEk/U/8U/vAABf
         qMVKW9VGCT/mflUwFa7c++19hQ+q33hkQyvykhUsdFPoN9kDCne8DEtJy5GvyKCb+IeQ
         whYPKLSpFCR4Az1PzxZQRpjuUjct1DBQYVwfkUjN56izsf6pkCk8tQVsTk1dpdYiIaMo
         0QHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686904830; x=1689496830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hUmPtWFh5/EWum1zehJNPIUaxqrN5E+ZkPwZ+4G0HY=;
        b=JdrKOaO/Rg2zE6QmC5l/84g+dSRG7jn1QXOwQeVjeu6XENX7WKscmbJas+WJwmL0tC
         52KwPvR2HI3nMG7yLfFdqL1XzNpzSL9iPJ2hnbmrDSHMsAy475QRu3GN6ofZK3F6wc9D
         KHp5mB3NjHTM7z2iSFPzwToCNOO2TX867m9yI8oySjjvrgQE4gDrDvIjn1xZMokFm+s1
         +CluhSRwBBBgGGDibDsrnxVwLgKF30MdQj/n0CRiMQiGlr5IC6NaAUy6MU6stZB0OcbG
         B7537ubumR0LiWTs6dMqEInkJJiAg+SbDr3/N+lWdgnjbHNePew+iFvHA92zxdIqCqXQ
         gZUA==
X-Gm-Message-State: AC+VfDwSfAsrzVdMIcflrG4BzasCyWruHgT4RovysDaaliKPvfS95srG
        QQZBTyZVaA2UXHtsg/vtgxYju/b/Id2IG7HX8ot/Ng==
X-Google-Smtp-Source: ACHHUZ7LpQYRuPKU0I5fZ/djL4rUcBBH38tpNgQsSNflvXkvfezNU2XZOyksY2Swnn4B1pUUGZenJychifsP2nmMw7s=
X-Received: by 2002:a17:907:80c:b0:974:1d8b:ca5f with SMTP id
 wv12-20020a170907080c00b009741d8bca5fmr1184408ejb.9.1686904830264; Fri, 16
 Jun 2023 01:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
 <CAOUHufZBUEm1P7gm0nFkPSFkNg2fPbs3v3qhL-R9m5yFNoW2YA@mail.gmail.com>
 <CA+PVUaTqNTSYkTy9yCFF=Y+xkimgM+3YQRF7EYr1UruesQnJrg@mail.gmail.com>
 <CAJD7tka-=ppaheVxn2-f6u0egBp8kOHYAK0bBudC62SKkZPk5w@mail.gmail.com>
 <CACSyD1MepXm4EL3o6OscAjRKQhAWZZ5xZKS8a0TXLAazUE+MpA@mail.gmail.com>
 <CAJD7tka4Uc1DhNzKbrj71vGyVVA12bJivPUQU7P0DOinunLgGg@mail.gmail.com>
 <576b7ba6-4dcd-48c9-3917-4e2a25aaa823@redhat.com> <CAJD7tkaS-wRjGjKbmN-HfiKJNTX0+PDdtw83NefEQ8nYAFznog@mail.gmail.com>
 <dede2f5b-2ae5-6fa3-c0d5-3ce7fba11694@redhat.com>
In-Reply-To: <dede2f5b-2ae5-6fa3-c0d5-3ce7fba11694@redhat.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 16 Jun 2023 01:39:53 -0700
Message-ID: <CAJD7tkY7CMLFS7Kv-DYnPwO9cGVWZmQZzkgOfVJMkH2pO8Kt9Q@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 1/3] zram: charge the compressed RAM to
 the page's memcgroup
To:     David Hildenbrand <david@redhat.com>
Cc:     =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>,
        Yu Zhao <yuzhao@google.com>, minchan@kernel.org,
        senozhatsky@chromium.org, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Fabian Deutsch <fdeutsch@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 1:37=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 16.06.23 10:04, Yosry Ahmed wrote:
> > On Fri, Jun 16, 2023 at 12:57=E2=80=AFAM David Hildenbrand <david@redha=
t.com> wrote:
> >>
> >> On 16.06.23 09:37, Yosry Ahmed wrote:
> >>> On Thu, Jun 15, 2023 at 9:41=E2=80=AFPM =E8=B4=BA=E4=B8=AD=E5=9D=A4 <=
hezhongkun.hzk@bytedance.com> wrote:
> >>>>
> >>>>> Thanks Fabian for tagging me.
> >>>>>
> >>>>> I am not familiar with #1, so I will speak to #2. Zhongkun, There a=
re
> >>>>> a few parts that I do not understand -- hopefully you can help me o=
ut
> >>>>> here:
> >>>>>
> >>>>> (1) If I understand correctly in this patch we set the active memcg
> >>>>> trying to charge any pages allocated in a zspage to the current mem=
cg,
> >>>>> yet that zspage will contain multiple compressed object slots, not
> >>>>> just the one used by this memcg. Aren't we overcharging the memcg?
> >>>>> Basically the first memcg that happens to allocate the zspage will =
pay
> >>>>> for all the objects in this zspage, even after it stops using the
> >>>>> zspage completely?
> >>>>
> >>>> It will not overcharge.  As you said below, we are not using
> >>>> __GFP_ACCOUNT and charging the compressed slots to the memcgs.
> >>>>
> >>>>>
> >>>>> (2) Patch 3 seems to be charging the compressed slots to the memcgs=
,
> >>>>> yet this patch is trying to charge the entire zspage. Aren't we dou=
ble
> >>>>> charging the zspage? I am guessing this isn't happening because (as
> >>>>> Michal pointed out) we are not using __GFP_ACCOUNT here anyway, so
> >>>>> this patch may be NOP, and the actual charging is coming from patch=
 3
> >>>>> only.
> >>>>
> >>>> YES=EF=BC=8C the actual charging is coming from patch 3. This patch =
just
> >>>> delivers the BIO page's  memcg to the current task which is not the
> >>>> consumer.
> >>>>
> >>>>>
> >>>>> (3) Zswap recently implemented per-memcg charging of compressed
> >>>>> objects in a much simpler way. If your main interest is #2 (which i=
s
> >>>>> what I understand from the commit log), it seems like zswap might b=
e
> >>>>> providing this already? Why can't you use zswap? Is it the fact tha=
t
> >>>>> zswap requires a backing swapfile?
> >>>>
> >>>> Thanks for your reply and review. Yes, the zswap requires a backing
> >>>> swapfile. The I/O path is very complex, sometimes it will throttle t=
he
> >>>> whole system if some resources are short , so we hope to use zram.
> >>>
> >>> Is the only problem with zswap for you the requirement of a backing s=
wapfile?
> >>>
> >>> If yes, I am in the early stages of developing a solution to make
> >>> zswap work without a backing swapfile. This was discussed in LSF/MM
> >>> [1]. Would this make zswap usable in for your use case?
> >>
> >> Out of curiosity, are there any other known pros/cons when using
> >> zswap-without-swap instead of zram?
> >>
> >> I know that zram requires sizing (size of the virtual block device) an=
d
> >> consumes metadata, zswap doesn't.
> >
> > We don't use zram in our data centers so I am not an expert about
> > zram, but off the top of my head there are a few more advantages to
> > zswap:
>
> Thanks!
>
> > (1) Better memcg support (which this series is attempting to address
> > in zram, although in a much more complicated way).
>
> Right. I think this patch also misses to update apply the charging in the=
 recompress
> case. (only triggered by user space IIUC)
>
> >
> > (2) We internally have incompressible memory handling on top of zswap,
> > which is something that we would like to upstream when
> > zswap-without-swap is supported. Basically if a page does not compress
> > well enough to save memory we reject it from zswap and make it
> > unevictable (if there is no backing swapfile). The existence of zswap
> > in the MM layer helps with this. Since zram is a block device from the
> > MM perspective, it's more difficult to do something like this.
> > Incompressible pages just sit in zram AFAICT.
>
> I see. With ZRAM_HUGE we still have to store the uncompressed page
> (because, it's a block device and has to hold that data).

Right.

>
> >
> > (3) Writeback support. If you're running out of memory to store
> > compressed pages you can add a swapfile in runtime and zswap will
> > start writing to it freeing up space to compress more pages. This
> > wouldn't be possible in the same way in zram. Zram supports writing to
> > a backing device but in a more manual way (userspace has to write to
> > an interface to tell zram to write some pages).
>
> Right, that zram backing device stuff is really sub-optimal and only usef=
ul
> in corner cases (most probably not datacenters).
>
> What one can do with zram is to add a second swap device with lower prior=
ity.
> Looking at my Fedora machine:
>
>   $ cat /proc/swaps
> Filename                                Type            Size            U=
sed            Priority
> /dev/dm-2                               partition       16588796        0=
               -2
> /dev/zram0                              partition       8388604         0=
               100
>
>
> Guess the difference here is that you won't be writing out the compressed
> data to the disk, but anything the gets swapped out afterwards will
> end up on the disk. I can see how the zswap behavior might be better in t=
hat case
> (instead of swapping out some additional pages you relocate the
> already-swapped-out-to-zswap pages to the disk).

Yeah I am hoping we can enable the use of zswap without a backing
swapfile, and I keep seeing use cases that would benefit from that.

>
> --
> Cheers,
>
> David / dhildenb
>
