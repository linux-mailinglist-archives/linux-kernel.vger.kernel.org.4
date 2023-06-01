Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7140971F129
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjFARwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjFARwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:52:19 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEFD107
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:52:17 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-96f7bf3cf9eso174147266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 10:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685641936; x=1688233936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exz8jHGGlbFPTRIu+KyeFYPOTRAMQRA0KdQTa6tuVIE=;
        b=oljK7KQegUu/ksQiF7GvxgyFAZG+MiCBFiyIKiNj2w+1uZBsrFOHgLSC2L/0ZnVYFM
         6VBKZBA/Dt3N/TO8Lx/zPWDUeVoGQAMg1c0HhQGkkAD9iC3mkPtlRPgTuusSNdxupaqp
         5I2kvigrFxUPPwhpF6lX04XqUxAODnOYjiDAV+xC4tyEMtOq0fC0Fn/4kUfYf4VXd7rI
         6VNNBJuqOuINji+spMEJX71PNLV4ByoV+JBkVFn+KU4WPHykAG9mhln1/KmX065XdzV0
         UaOOqdkUaNM7dHwLHz06buezQfuU8bRyrcDmzN+mCDbXYY/Z4AeX+OeG1AzrUUWOj3CN
         ML/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685641936; x=1688233936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exz8jHGGlbFPTRIu+KyeFYPOTRAMQRA0KdQTa6tuVIE=;
        b=U4ehy+8RPhPNSoxBy3QiIPVRCcTOoou/zeb+mtX2sO452XqeMfWa++ymO/P97q/nDs
         MXdU5T5aPa8aILA17wEApEk8wWVdnhOydhRzWgjWdY9GASz7TTS6VOt2Nfe6m8EJN9CP
         SHd9Rjg0oGhDAp1jWT5Xjy9TY2eBFK2G287+Uw3EaAb8FUkHzisR1WnplovG2wKlALNy
         74DcEvqH5Ew1NjSB8/+rmm4kYUsJ/yauBUDadX/XArQqEHgZMlJuT4He4/q9hWI+Vt2p
         Uqh5k4xCOCYWo57Ow5FsLjysqz0RqSmQttOMoB5TorjYOKeDntPurvalUKn6zkt/5z3Z
         Bk7Q==
X-Gm-Message-State: AC+VfDzLTNvizl5GXvNtAlUyT7Mf3qThFVYuDEKDpH217lSgHJJGxPMs
        xn6YeXUGn7NfFdPd5CRjWZaxKJQ7sYlv8qePZpOG+JNMz8WJIyFc3bU=
X-Google-Smtp-Source: ACHHUZ7jUZ20nfXDXBJOWeN1B+zdMiLbbuPEEwVtKmpUrCxLVy+CVxDqO/kvCxTU201DxZwdbr6g7wzpQ6FEeR7cvic=
X-Received: by 2002:a17:907:6297:b0:974:1c98:d2d9 with SMTP id
 nd23-20020a170907629700b009741c98d2d9mr8477764ejc.3.1685641936158; Thu, 01
 Jun 2023 10:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230531022911.1168524-1-yosryahmed@google.com> <20230601155825.GF102494@cmpxchg.org>
In-Reply-To: <20230601155825.GF102494@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 1 Jun 2023 10:51:39 -0700
Message-ID: <CAJD7tkaFSfpTtB_ua_9QzR2voE1-hixv6RMJZd=WqpGmY93dSw@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: multiple zpool support
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
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

On Thu, Jun 1, 2023 at 8:58=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Wed, May 31, 2023 at 02:29:11AM +0000, Yosry Ahmed wrote:
> > Support using multiple zpools of the same type in zswap, for concurrenc=
y
> > purposes. Add CONFIG_ZSWAP_NR_ZPOOLS_ORDER to control the number of
> > zpools. The order is specific by the config rather than the absolute
> > number to guarantee a power of 2. This is useful so that we can use
> > deterministically link each entry to a zpool by hashing the zswap_entry
> > pointer.
> >
> > On a setup with zswap and zsmalloc, comparing a single zpool (current
> > default) to 32 zpools (by setting CONFIG_ZSWAP_NR_ZPOOLS_ORDER=3D32) sh=
ows
> > improvements in the zsmalloc lock contention, especially on the swap ou=
t
> > path.
> >
> > The following shows the perf analysis of the swapout path when 10
> > workloads are simulatenously reclaiming and refaulting tmpfs pages.
> > There are some improvements on the swapin path as well, but much less
> > significant.
> >
> > 1 zpool:
> >
> >  |--28.99%--zswap_frontswap_store
> >        |     |
> >        <snip>
> >        |     |
> >        |     |--8.98%--zpool_map_handle
> >        |     |     |
> >        |     |      --8.98%--zs_zpool_map
> >        |     |           |
> >        |     |            --8.95%--zs_map_object
> >        |     |                 |
> >        |     |                  --8.38%--_raw_spin_lock
> >        |     |                       |
> >        |     |                        --7.39%--queued_spin_lock_slowpat=
h
> >        |     |
> >        |     |--8.82%--zpool_malloc
> >        |     |     |
> >        |     |      --8.82%--zs_zpool_malloc
> >        |     |           |
> >        |     |            --8.80%--zs_malloc
> >        |     |                 |
> >        |     |                 |--7.21%--_raw_spin_lock
> >        |     |                 |     |
> >        |     |                 |      --6.81%--queued_spin_lock_slowpat=
h
> >        <snip>
> >
> > 32 zpools:
> >
> >  |--16.73%--zswap_frontswap_store
> >        |     |
> >        <snip>
> >        |     |
> >        |     |--1.81%--zpool_malloc
> >        |     |     |
> >        |     |      --1.81%--zs_zpool_malloc
> >        |     |           |
> >        |     |            --1.79%--zs_malloc
> >        |     |                 |
> >        |     |                  --0.73%--obj_malloc
> >        |     |
> >        |     |--1.06%--zswap_update_total_size
> >        |     |
> >        |     |--0.59%--zpool_map_handle
> >        |     |     |
> >        |     |      --0.59%--zs_zpool_map
> >        |     |           |
> >        |     |            --0.57%--zs_map_object
> >        |     |                 |
> >        |     |                  --0.51%--_raw_spin_lock
> >        <snip>
> >
> > Suggested-by: Yu Zhao <yuzhao@google.com>
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  mm/Kconfig | 12 +++++++
> >  mm/zswap.c | 95 ++++++++++++++++++++++++++++++++++++------------------
> >  2 files changed, 76 insertions(+), 31 deletions(-)
> >
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 92c30879bf67..de1da56d2c07 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -59,6 +59,18 @@ config ZSWAP_EXCLUSIVE_LOADS
> >         The cost is that if the page was never dirtied and needs to be
> >         swapped out again, it will be re-compressed.
> >
> > +config ZSWAP_NR_ZPOOLS_ORDER
> > +     int "Number of zpools in zswap, as power of 2"
> > +     default 0
> > +     depends on ZSWAP
> > +     help
> > +       This options determines the number of zpools to use for zswap, =
it
> > +       will be 1 << CONFIG_ZSWAP_NR_ZPOOLS_ORDER.
> > +
> > +       Having multiple zpools helps with concurrency and lock contenti=
on
> > +       on the swap in and swap out paths, but uses a little bit of ext=
ra
> > +       space.
>
> This is nearly impossible for a user, let alone a distribution, to
> answer adequately.
>
> The optimal value needs to be found empirically. And it varies heavily
> not just by workload but by implementation changes. If we make changes
> to the lock holding time or redo the data structures, a previously
> chosen value might no longer be a net positive, and even be harmful.

Yeah, I agree that this can only be tuned empirically, but there is a
real benefit to tuning it, at least in our experience. I imagined
having the config option with a default of 0 gives those who want to
tune it the option, while not messing with users that do not care.

>
> Architecturally, the pool scoping and the interaction with zswap_tree
> is currently a mess. We're aware of lifetime bugs, where swapoff kills
> the tree but the pool still exists with entries making dead references
> e.g. We likely need to rearchitect this in the near future - maybe tie
> pools to trees to begin with.
>
> (I'm assuming you're already using multiple swap files to avoid tree
> lock contention, because it has the same scope as the pool otherwise.)
>
> Such changes quickly invalidate any settings the user or distro might
> make here. Exposing the implementation detail of the pools might even
> get in the way of fixing bugs and cleaning up the architecture.

I was under the impression that config options are not very stable.
IOW, if we fix the lock contention on an architectural level, and
there is no more benefit to tuning the number of zpools per zswap
pool, we can remove the config option. Is this incorrect?

>
> > @@ -263,11 +266,13 @@ static void zswap_update_total_size(void)
> >  {
> >       struct zswap_pool *pool;
> >       u64 total =3D 0;
> > +     int i;
> >
> >       rcu_read_lock();
> >
> >       list_for_each_entry_rcu(pool, &zswap_pools, list)
> > -             total +=3D zpool_get_total_size(pool->zpool);
> > +             for (i =3D 0; i < zswap_nr_zpools; i++)
> > +                     total +=3D zpool_get_total_size(pool->zpools[i]);
>
> This adds a O(nr_pools) operation to every load and store. It's easy
> for this to dominate or outweigh locking costs as workload concurrency
> changes, or data structures and locking change inside the kernel.

Right, which is why this is empirically tuned. In the perf analysis in
the commit log, the lock contention gains far outweigh this cost.
FWIW, the cost here is constant, we just iterate the pools and read a
value.

>
> > @@ -587,14 +603,17 @@ static void shrink_worker(struct work_struct *w)
> >  {
> >       struct zswap_pool *pool =3D container_of(w, typeof(*pool),
> >                                               shrink_work);
> > +     int i;
> >
> > -     if (zpool_shrink(pool->zpool, 1, NULL))
> > -             zswap_reject_reclaim_fail++;
> > +     for (i =3D 0; i < zswap_nr_zpools; i++)
> > +             if (zpool_shrink(pool->zpools[i], 1, NULL))
> > +                     zswap_reject_reclaim_fail++;
> >       zswap_pool_put(pool);
>
> This scales reclaim batch size by the number of zpools, which can lead
> to varying degrees of overreclaim especially on small zswap sizes with
> high pool concurrency.

I was under the assumption that with Domenico's patch we will mostly
be reclaiming multiple pages anyway, but I can certainly remove this
part and only reclaim one page at a time from one zpool. We can select
one at random or round robin through the zpools.

>
> I don't think this patch is ready for primetime. A user build time
> setting is not appropriate for an optimization that is heavily tied to
> implementation details and workload dynamics.

What would you suggest instead? We do find value in having multiple
zpools, at least for the current architecture.

An internal implementation that we have exposes this as a module
parameter instead, but that is more complicated (I image), because you
need to set it before enabling zswap, or before changing the zswap
pool, otherwise changing it is nop because the zpool(s) is already
allocated. I am also guessing module params are more stable than
config options. Hence, I thought a config option might be more
appropriate.
