Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CD67234E1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 03:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjFFB5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 21:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjFFB5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 21:57:14 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22ADDED
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 18:57:13 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-977c72b116fso408043866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 18:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686016631; x=1688608631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3lFS92Q9Y5Yi8hsvO0NMVnQb89Fjn5Ds6zHjO1KoiM=;
        b=XwnjUL0D819GhF7PXeXG3s5ECh9TuPAPuEMw5o4AuT35JX4iqRtqM7nttZLcWbHp6w
         hennia2JKWQLdKFRUuoHHN5OHXG97d1xw2rO/jMbjZ6z7bCRcwkmcKQCzz94DYqIjsxq
         pPHRpSNHZUR+kMoQsqVB2AWk06+cecwJqSTSrpNjpz8SBZxh2PYVpkPmdDLM6ExQx4b4
         Mzqo5Igu5UrMoe9l25HrbQm/e0j2cG4sOYLgOzy4dlmtbiH+To7U74GiK1e6iKe81r2i
         4rEvZ3uJga+56DHyEC1FsVe69UNP2sLqgIc2SUJzZhCyOyVXjESYxG2dket9tNQOWRkt
         iZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686016631; x=1688608631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3lFS92Q9Y5Yi8hsvO0NMVnQb89Fjn5Ds6zHjO1KoiM=;
        b=GjRC9mZHf4afnfkd2em9xNCP1MV/paGdqTV1vRYmp8zADgRQAQ5EPQKkDK7lNhCvUd
         LQxnJBaPFiMgwQFOz+g5ww/+xoVET4LkLG/UrQoPxg7kXKMHipPCpUsDCS3FtvKyfGJi
         kFwTwxsZM9IqN3CZRBXzQEC4TJRVuZVkbnXhAcao+JLx4QCJlo4fh1PmrCapCOGwR0Qr
         r5X8ZZByTqQLvfBQWrq6NI+wAmyna6tdUWYf1S8DEixaFV1eVTcEVFwBpUVgGNSOMHBC
         7O6NPmt8eCm6jetRp+/Y9RXs+dkrbd/50prM/4dT7cDG1g5+p0Myanq+mfKexuAlSEqB
         LnTA==
X-Gm-Message-State: AC+VfDwecjkKcvouupyASqiTTtZKkIvZ/QnwiJ6urrTTtBrlOmb5hQDC
        wsRGFU7xYuMJIuqBrIzQXviERLduTfYf9FiOVsIT8w==
X-Google-Smtp-Source: ACHHUZ6xqMRWE4SYR80sxO6KPoi/so3r5fLMEFY6iz/vvQJrQO0nAuV9N3BrvHOrohVUpOxZ4uf4O/yFsotZiLcF8Sc=
X-Received: by 2002:a17:907:6e0e:b0:978:6b18:e935 with SMTP id
 sd14-20020a1709076e0e00b009786b18e935mr605184ejc.23.1686016631437; Mon, 05
 Jun 2023 18:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230531022911.1168524-1-yosryahmed@google.com>
 <20230601155825.GF102494@cmpxchg.org> <CAJD7tkaFSfpTtB_ua_9QzR2voE1-hixv6RMJZd=WqpGmY93dSw@mail.gmail.com>
 <20230602164942.GA215355@cmpxchg.org> <CAJD7tkbp96S8MdrcH8y0V2G5Q-Zq6U4DAuweYhP-MjUWgcmjsQ@mail.gmail.com>
 <20230602183410.GB215355@cmpxchg.org> <CAJD7tka18Vw7HpA1gh6wWJcaCJ_U6jNfCC696pX=UkbiXKZMvQ@mail.gmail.com>
 <20230602202453.GA218605@cmpxchg.org>
In-Reply-To: <20230602202453.GA218605@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 5 Jun 2023 18:56:35 -0700
Message-ID: <CAJD7tkZBxddm1c4f99KmY+VwKU3jbYBMaNuTtfpis7a1E6242Q@mail.gmail.com>
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

On Fri, Jun 2, 2023 at 1:24=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Fri, Jun 02, 2023 at 12:14:28PM -0700, Yosry Ahmed wrote:
> > On Fri, Jun 2, 2023 at 11:34=E2=80=AFAM Johannes Weiner <hannes@cmpxchg=
.org> wrote:
> > >
> > > On Fri, Jun 02, 2023 at 09:59:20AM -0700, Yosry Ahmed wrote:
> > > > On Fri, Jun 2, 2023 at 9:49=E2=80=AFAM Johannes Weiner <hannes@cmpx=
chg.org> wrote:
> > > > > Again, what about the zswap_tree.lock and swap_info_struct.lock?
> > > > > They're the same scope unless you use multiple swap files. Would =
it
> > > > > make sense to tie pools to trees, so that using multiple swapfile=
s for
> > > > > concurrency purposes also implies this optimization?
> > > >
> > > > Yeah, using multiple swapfiles helps with those locks, but it doesn=
't
> > > > help with the zpool lock.
> > > >
> > > > I am reluctant to take this path because I am trying to get rid of
> > > > zswap's dependency on swapfiles to begin with, and have it act as i=
ts
> > > > own standalone swapping backend. If I am successful, then having on=
e
> > > > zpool per zswap_tree is just a temporary fix.
> > >
> > > What about making the pools per-cpu?
> > >
> > > This would scale nicely with the machine size. And we commonly deal
> > > with for_each_cpu() loops and per-cpu data structures, so have good
> > > developer intuition about what's reasonable to squeeze into those.
> > >
> > > It would eliminate the lock contention, for everybody, right away, an=
d
> > > without asking questions.
> > >
> > > It would open the door to all kinds of locking optimizations on top.
> >
> > The page can get swapped out on one cpu and swapped in on another, no?
> >
> > We will need to store which zpool the page is stored in in its zswap
> > entry, and potentially grab percpu locks from other cpus in the swap
> > in path. The lock contention would probably be less, but certainly not
> > eliminated.
> >
> > Did I misunderstand?
>
> Sorry, I should have been more precise.
>
> I'm saying that using NR_CPUS pools, and replacing the hash with
> smp_processor_id(), would accomplish your goal of pool concurrency.
> But it would do so with a broadly-used, well-understood scaling
> factor. We might not need a config option at all.
>
> The lock would still be there, but contention would be reduced fairly
> optimally (barring preemption) for store concurrency at least. Not
> fully eliminated due to frees and compaction, though, yes.

Yeah I think we can do that. I looked at the size of the zsmalloc pool
as an example, and it seems to be less than 1K, so having one percpu
seems okay.

There are a few things that we will need to do:
- Rework zswap_update_total_size(). We don't want to loop through all
cpus on each load/store. We can be smarter about it and inc/dec the
total zswap pool size each time we allocate or free a page in the
driver. This might need some plumbing from the drivers to zswap (or
passing a callback from zswap to the drivers).

- Update zsmalloc such that all pool share kmem caches, instead of
creating two kmem caches for zsmalloc percpu. This was a follow-up I
had in mind for multiple zpools support anyway, but I guess it's more
significant if we have NR_CPUS pools.

I was nervous about increasing the size of struct zswap_entry to store
the cpu/zpool where the entry resides, but I realized we can replace
the pointer to zswap_pool in struct zswap_entry with a pointer to
zpool, and add a zswap_pool pointer in struct zpool. This will
actually trim down the common "entry->pool->zpool" to just
"entry->zpool", and then we can replace any "entry->pool" with
"entry->zpool->pool".

@Yu Zhao, any thoughts on this? The multiple zpools support was
initially your idea (and did the initial implementation) -- so your
input is very valuable here.

>
> I'm not proposing more than that at this point. I only wrote the last
> line because already having per-cpu data structures might help with
> fast path optimizations down the line, if contention is still an
> issue. But unlikely. So it's not so important. Let's forget it.
