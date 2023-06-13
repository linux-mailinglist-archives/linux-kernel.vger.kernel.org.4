Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4022472ECB6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjFMUPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbjFMUOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:14:44 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66101A7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:14:38 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9745d99cfccso1028996266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686687277; x=1689279277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1psdIQn/Alk8QNqRdoqO3HAQ2Q9SRKg6BbF+y6GPB4=;
        b=GiOiER+sxlhsvK2jx8M07h1B4SaZgb9IEwQ8TJ8C1zJ/EeFzbStk1wpz1w7kU1PyTO
         by8+yfr6hD8L8hvdyvNmWy6gwX7W1yrTq0KiCF35hjBcg1SjEK4MHaH0pam/9vghnjL4
         aiFt2qyHdxMoc88O/tZ4jPv2lPuciL+e28EmmPZLQEt30Voc/oGseWBow8yhSjQOcqYZ
         HUV+cXiSKywb9rI81U18z0qd7VJkK/+q2vU+V4YFx1rRjrBiAsNgbjid8ywF1diwoazm
         PVNg6cGUk5WP5eDzrV5r1G1q7VZz6Tuuf2fvuF70U5BsuOLitPmEn50drj+BaqnboFG5
         CZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686687277; x=1689279277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1psdIQn/Alk8QNqRdoqO3HAQ2Q9SRKg6BbF+y6GPB4=;
        b=FraBsI19qMrWlc+Q7OCCQietVEY3T1cwlnwcM7EVILULN60FCVsGgjQFNYRhgzaTmP
         9ChDGdlQT3+ZxMC8XZ0cCUE/r+FAcaZezL2MLiusFXqnXGHglsa3BZEfpXIGmYkkrda0
         +2vEOUr+SOnzdW6xX3NQV4j6SMj7oYeiHRrsuSvOXz5qXJ0pnISdf5HfbjZGsLZ59Q56
         A4I2EHr7tqOYA4V9CVb7ZnjRKxx4v+yXNxhgKhyVrwLOYVZuBNCadZU/YtWEkRmcstvi
         2LnF0PBsfmQ8kiShUBPrZWCs35zgpuGdf2WPji1OWiSns+XoscdLos1TTlUb+ZBd/e7x
         xQBg==
X-Gm-Message-State: AC+VfDwK4ejkLSmUnxe+VGUK36cp3MsbSDzU6HHK1ViJxIN8JrfKzIr8
        L9/4NYptSSya3LP5hU5OXrUaHlA/+LSKpygauHR2GA==
X-Google-Smtp-Source: ACHHUZ53+2YVtJiYKGxWl2T46vTV5fmxFpoPtRAbXNaVzRoAjUj9Fvo+8ty8smNGvZMLrqhuwKgSm6EtQa3Hor/qves=
X-Received: by 2002:a17:907:9620:b0:978:8790:9103 with SMTP id
 gb32-20020a170907962000b0097887909103mr17026037ejc.70.1686687276699; Tue, 13
 Jun 2023 13:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230531022911.1168524-1-yosryahmed@google.com>
 <20230601155825.GF102494@cmpxchg.org> <CAJD7tkaFSfpTtB_ua_9QzR2voE1-hixv6RMJZd=WqpGmY93dSw@mail.gmail.com>
 <20230602164942.GA215355@cmpxchg.org> <CAJD7tkbp96S8MdrcH8y0V2G5Q-Zq6U4DAuweYhP-MjUWgcmjsQ@mail.gmail.com>
 <20230602183410.GB215355@cmpxchg.org> <CAJD7tka18Vw7HpA1gh6wWJcaCJ_U6jNfCC696pX=UkbiXKZMvQ@mail.gmail.com>
 <20230602202453.GA218605@cmpxchg.org> <CAJD7tkZBxddm1c4f99KmY+VwKU3jbYBMaNuTtfpis7a1E6242Q@mail.gmail.com>
In-Reply-To: <CAJD7tkZBxddm1c4f99KmY+VwKU3jbYBMaNuTtfpis7a1E6242Q@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 13 Jun 2023 13:13:59 -0700
Message-ID: <CAJD7tkaraXuLKR8rsKw_8sp9YZga1caM7r0jA8DZC2Y6DxJNfQ@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: multiple zpool support
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Mon, Jun 5, 2023 at 6:56=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Fri, Jun 2, 2023 at 1:24=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
> >
> > On Fri, Jun 02, 2023 at 12:14:28PM -0700, Yosry Ahmed wrote:
> > > On Fri, Jun 2, 2023 at 11:34=E2=80=AFAM Johannes Weiner <hannes@cmpxc=
hg.org> wrote:
> > > >
> > > > On Fri, Jun 02, 2023 at 09:59:20AM -0700, Yosry Ahmed wrote:
> > > > > On Fri, Jun 2, 2023 at 9:49=E2=80=AFAM Johannes Weiner <hannes@cm=
pxchg.org> wrote:
> > > > > > Again, what about the zswap_tree.lock and swap_info_struct.lock=
?
> > > > > > They're the same scope unless you use multiple swap files. Woul=
d it
> > > > > > make sense to tie pools to trees, so that using multiple swapfi=
les for
> > > > > > concurrency purposes also implies this optimization?
> > > > >
> > > > > Yeah, using multiple swapfiles helps with those locks, but it doe=
sn't
> > > > > help with the zpool lock.
> > > > >
> > > > > I am reluctant to take this path because I am trying to get rid o=
f
> > > > > zswap's dependency on swapfiles to begin with, and have it act as=
 its
> > > > > own standalone swapping backend. If I am successful, then having =
one
> > > > > zpool per zswap_tree is just a temporary fix.
> > > >
> > > > What about making the pools per-cpu?
> > > >
> > > > This would scale nicely with the machine size. And we commonly deal
> > > > with for_each_cpu() loops and per-cpu data structures, so have good
> > > > developer intuition about what's reasonable to squeeze into those.
> > > >
> > > > It would eliminate the lock contention, for everybody, right away, =
and
> > > > without asking questions.
> > > >
> > > > It would open the door to all kinds of locking optimizations on top=
.
> > >
> > > The page can get swapped out on one cpu and swapped in on another, no=
?
> > >
> > > We will need to store which zpool the page is stored in in its zswap
> > > entry, and potentially grab percpu locks from other cpus in the swap
> > > in path. The lock contention would probably be less, but certainly no=
t
> > > eliminated.
> > >
> > > Did I misunderstand?
> >
> > Sorry, I should have been more precise.
> >
> > I'm saying that using NR_CPUS pools, and replacing the hash with
> > smp_processor_id(), would accomplish your goal of pool concurrency.
> > But it would do so with a broadly-used, well-understood scaling
> > factor. We might not need a config option at all.
> >
> > The lock would still be there, but contention would be reduced fairly
> > optimally (barring preemption) for store concurrency at least. Not
> > fully eliminated due to frees and compaction, though, yes.

I thought about this again and had some internal discussions, and I am
more unsure about it. Beyond the memory overhead, having too many
zpools might result in higher fragmentation within the zpools. For
zsmalloc, we do not compact across multiple zpools for example.

We have been using a specific number of zpools in our production for
years now, we know it can be tuned to achieve performance gains. OTOH,
percpu zpools (or NR_CPUS pools) seems like too big of a hammer,
probably too many zpools in a lot of cases, and we wouldn't know how
many zpools actually fits our workloads.

I see value in allowing the number of zpools to be directly
configurable (it can always be left as 1), and am worried that with
percpu we would be throwing away years of production testing for an
unknown.

I am obviously biased, but I don't think this adds significant
complexity to the zswap code as-is (or as v2 is to be precise).

WDYT?

>
> Yeah I think we can do that. I looked at the size of the zsmalloc pool
> as an example, and it seems to be less than 1K, so having one percpu
> seems okay.
>
> There are a few things that we will need to do:
> - Rework zswap_update_total_size(). We don't want to loop through all
> cpus on each load/store. We can be smarter about it and inc/dec the
> total zswap pool size each time we allocate or free a page in the
> driver. This might need some plumbing from the drivers to zswap (or
> passing a callback from zswap to the drivers).
>
> - Update zsmalloc such that all pool share kmem caches, instead of
> creating two kmem caches for zsmalloc percpu. This was a follow-up I
> had in mind for multiple zpools support anyway, but I guess it's more
> significant if we have NR_CPUS pools.
>
> I was nervous about increasing the size of struct zswap_entry to store
> the cpu/zpool where the entry resides, but I realized we can replace
> the pointer to zswap_pool in struct zswap_entry with a pointer to
> zpool, and add a zswap_pool pointer in struct zpool. This will
> actually trim down the common "entry->pool->zpool" to just
> "entry->zpool", and then we can replace any "entry->pool" with
> "entry->zpool->pool".
>
> @Yu Zhao, any thoughts on this? The multiple zpools support was
> initially your idea (and did the initial implementation) -- so your
> input is very valuable here.
>
> >
> > I'm not proposing more than that at this point. I only wrote the last
> > line because already having per-cpu data structures might help with
> > fast path optimizations down the line, if contention is still an
> > issue. But unlikely. So it's not so important. Let's forget it.
