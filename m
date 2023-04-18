Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDB16E57A2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 04:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjDRCyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 22:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjDRCyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 22:54:02 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FFA4EF5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 19:53:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-94f7a0818aeso91109166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 19:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681786438; x=1684378438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJcn2LEoBt8R6cyXOgodEeDDSn6+mGEdMFgpgtawfqI=;
        b=m1/Hmj++ocjb3O5DLlJAm+C5Zwv1HnB2e/DIAOIh43KYJeXWSwm9VizR5MxpvigG7E
         ZSBNfbJOL7l+xrQmFHV+04iIRvbU1lfRGrOwEBeQbLvjcnqvk9dU5PF9VMj16lC6Sf0+
         er6zHd85y7kiB1hP32Qpmp7dSgIUHUSbGBLR4SCuQruXcTZnxbc8OU/BNNQiMfjoQq21
         kbM6bUYeINsbWfC/U4MO36STmT8VmashrOFHKoVVnA+qw6LZNfnAqG3x4c+WZoClEGiW
         JJVrxD35H7oGG61rbE01fRq9EznadiPtpmHue6Wu+ommBOs3y2eNdJaLTiAoh0TePZhy
         QRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681786438; x=1684378438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJcn2LEoBt8R6cyXOgodEeDDSn6+mGEdMFgpgtawfqI=;
        b=NyFgkc15RBZ+LSnSCPcPC416ZPhzXQ2mwxrSyg9rXTC+50BU9JbeKDVZw2/rtpyYUk
         0feYwfQKfN8QKzG8/15YOvgd/Mrps3oKiNlhrPLBDArmFK/CDjyTDpqrtP8lgctdfXpU
         HnS5NN5iMCi9LuTHQhNwgHuOkTsEOM0zk9Kq49BuE0EMowN1/smwlmCn60ObvWEq9bG9
         /eoNpY/lvKNJ2AzZ1kQwhgK3SZes+JFGbqUtf9hFuuJ/bzYKfhWEezvEIK+TqfsqGNae
         Hrzu1DhZ/UWFV2cX1l9jfgwr+KL4/eH7ZN30ppl1cBCivqMSpCDZpIh4x1xT8WznOwmt
         6PUQ==
X-Gm-Message-State: AAQBX9elC3fOSZN4XPLS3J0a2sai6sLhCPrkkPaNn+2JBrqB6aetmUCw
        /wiORhMGdlju+f0C/FSjwPdIzsA0W0x/B2U2IO3mdg==
X-Google-Smtp-Source: AKy350bKZRF6pSZqjUEcV0TejZqQJUA1mluM0zL4Xa6atN7/cE8aWBteisvt4hTpWRy6e0M5p6E11TdPyAwnZmHaXRw=
X-Received: by 2002:a05:6402:3c8:b0:504:b5e2:1106 with SMTP id
 t8-20020a05640203c800b00504b5e21106mr776059edw.31.1681786438102; Mon, 17 Apr
 2023 19:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230417135420.1836741-1-senozhatsky@chromium.org> <20230417174131.44de959204814209ef73e53e@linux-foundation.org>
In-Reply-To: <20230417174131.44de959204814209ef73e53e@linux-foundation.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 17 Apr 2023 19:53:21 -0700
Message-ID: <CAJD7tkZOmUnfi8mGtr3a-hbSZcHsR3cXqVO+Luo4w=8qh-i3_w@mail.gmail.com>
Subject: Re: [PATCHv2] zsmalloc: allow only one active pool compaction context
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
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

On Mon, Apr 17, 2023 at 5:41=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 17 Apr 2023 22:54:20 +0900 Sergey Senozhatsky <senozhatsky@chromi=
um.org> wrote:
>
> > zsmalloc pool can be compacted concurrently by many contexts,
> > e.g.
> >
> >  cc1 handle_mm_fault()
> >       do_anonymous_page()
> >        __alloc_pages_slowpath()
> >         try_to_free_pages()
> >          do_try_to_free_pages(
> >           lru_gen_shrink_node()
> >            shrink_slab()
> >             do_shrink_slab()
> >              zs_shrinker_scan()
> >               zs_compact()
> >
> > This creates unnecessary contention as all those processes
> > compete for access to the same classes. A single compaction
> > process is enough. Moreover contention that is created by
> > multiple compaction processes impact other zsmalloc functions,
> > e.g. zs_malloc(), since zsmalloc uses "global" pool->lock to
> > synchronize access to pool.
> >
> > Introduce pool compaction mutex and permit only one compaction
> > context at a time. This reduces overall pool->lock contention.
>
> That isn't what the patch does!  Perhaps an earlier version used a mutex?

Yup that's from v1. Thanks for catching that.

>
> > /proc/lock-stat after make -j$((`nproc`+1)) linux kernel for
> > &pool->lock#3:
> >
> >                 Base           Patched
> > ------------------------------------------
> > con-bounces     2035730        1540066
> > contentions     2343871        1774348
> > waittime-min    0.10           0.10
> > waittime-max    4004216.24     2745.22
> > waittime-total  101334168.29   67865414.91
> > waittime-avg    43.23          38.25
> > acq-bounces     2895765        2186745
> > acquisitions    6247686        5136943
> > holdtime-min    0.07           0.07
> > holdtime-max    2605507.97     482439.16
> > holdtime-total  9998599.59     5107151.01
> > holdtime-avg    1.60           0.99
> >
> > Test run time:
> > Base
> > 2775.15user 1709.13system 2:13.82elapsed 3350%CPU
> >
> > Patched
> > 2608.25user 1439.03system 2:03.63elapsed 3273%CPU
> >
> > ...
> >
> > @@ -2274,6 +2275,9 @@ unsigned long zs_compact(struct zs_pool *pool)
> >       struct size_class *class;
> >       unsigned long pages_freed =3D 0;
> >
> > +     if (atomic_xchg(&pool->compaction_in_progress, 1))
> > +             return 0;
> > +
>
> A code comment might be appropriate here.
>
> Is the spin_is_contended() test in __zs_compact() still relevant?

It is, as pool->lock is used to synchronize a lot of operations, not
just compaction.

>
> And....  single-threading the operation seems a pretty sad way of
> addressing a contention issue.  zs_compact() is fairly computationally
> expensive - surely a large machine would like to be able to
> concurrently run many instances of zs_compact()?

Yeah that was my initial thought as well, to attack this problem at a
larger scale and break down the pool->lock into class->lock. AFAICT,
zsmalloc pages/objects cannot change classes during their lifetime, so
this sounds reasonable initially.

The problem is that the pool->lock is used to synchronize ~all
zsmalloc operations:  zs_map_object(), zs_malloc(), zs_free(),
async_free_zspage(), zs_compact(), zs_reclaim_page(),
zs_page_migrate().

For some of those, changing a pool->lock into a class->lock is fairly
straightforward, specifically the ones where we operate on a
page/zspage (e.g. zs_compact()).

The problem is for operations where we operate on an object (e.g.
zs_map_object()). At this point, we only have a handle that we need to
use to find the underlying object. We have no idea what class the
object belongs to, and finding an object given a handle needs
synchronization as the handle<->object mapping can change by
compaction or page migration.

We can store the class somewhere and pay an extra byte per compressed
object (which doesn't sound too bad) -- but even then we'd have
trouble finding the right place to stash it. Perhaps we can enforce
some alignment on the objects and use the lowermost 8 bits of the
handle pointer, which also means we don't need to pay any extra
overhead, but I am not sure if this is practical.

We can also store the class at the first byte of the object, and
guarantee that through migration/compaction the first byte always
remains a valid class. We can then read the class from the handle
locklessly, acquire the class lock, and then make sure the handle is
still the same.

These are all ideas I am throwing in the air, I didn't think about
them thoroughly or try implementing them.

TLDR: I believe it is possible (in theory at least) to break down the
global pool->lock into class locks, which should benefit virtually
~all zsmalloc concurrent operations, not just compaction. It is not
easy though.

As for this patch, I personally do not observe a lot of compaction in
our production environment, and allowing one thread to perform
compaction while others move on with their lives can be better than
having all of them continuously contending for the pool->lock, which
means more contention with ~all zsmalloc operations, not just
concurrent compactors. I can't say for sure that this is an
improvement, but I *believe* it is.

I will shut up now and leave it up to Sergey to decide how to move
forward, sorry for the very long response :)
