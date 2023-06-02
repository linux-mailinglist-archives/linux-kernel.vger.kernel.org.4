Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC19720807
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 19:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbjFBRAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 13:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbjFBRAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:00:01 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACBF1A8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 09:59:59 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b1a6a8e851so24619991fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 09:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685725197; x=1688317197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOhKhgTofXNa2KhmSrP+PeIdMDagD75LnrkpTcc4Hps=;
        b=ax+XOUcxLe/TLzujsZsHyD7j+1g/MTKcLQIg2s0QnwsQM29GsYnoSqVor9AHkgx/DZ
         TVPrkfOxnFraBzaDKFBVWASHAKEYBJVoZOx/L0mIRnrxYa3F0AjSbFrVbKd9k/k9tiBF
         0cwqdCmv3uBglUmGJIpIcgBMhnEMKqVvAfHSNqRIiH/1O356znOa9whEhHh7Pss1GZjb
         IPZIjXTRcXzT5a2Ki5sA688jgfRIfY7y6KD4F6j9wUyigx1sJtTabHIgPgAO1eUxzt8s
         7gAbjdqR0kCLsgvwwbEHmD88vHTuYnucGcQoIZW6PvOMAljz1d56K+NUosmher56YYOL
         1Tgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685725197; x=1688317197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOhKhgTofXNa2KhmSrP+PeIdMDagD75LnrkpTcc4Hps=;
        b=bPBPshOenYJZHjTfmt9cUy83O9mspp+B3HCs8IrFTijQjUk3AtUzfFVwVHOBUkDMNr
         2CC5Ctz3yLXmIqvQOjQHo4ZbfWf/gjUqwH5WXLRkANGLej/gxxFHzIpZO8c8va5ujaJP
         PZve6S3kPmRdNkDNBppPWqvh0U3XWaWKgut1yZBgDKY3zqVR//hz+9NIDnxA9R2F6LBx
         2ds/qoU1r0zNzczaO8sZBW9h6uQQoQhRSRkgz7qC0tsuoJIlH+OwS2IR0c85pgFg9Ahv
         p9NbRmKxNQ8J0mNC6VLm9REWTjzv1bSwV+xVODZB+4dzS4nqYuygwa+QgpC6myeeS7de
         PkUA==
X-Gm-Message-State: AC+VfDzzQJCXtq2Va6lh6PLLVpWTQ7dBCN6UHGlJKibo+utbdYoh/8+V
        OQsc33anXev3TIbXEZtWSzdsvUaCOq4LDp8g6inUomQFLy+e4XHOHxw=
X-Google-Smtp-Source: ACHHUZ48ephse3giXC9fgD37G6HAQmkCvJin4UNqLWEQUO3wkT6+Q/dwqJCbKBOhZJX5fet7HxkikO8n4SO9r3oom70=
X-Received: by 2002:a2e:980b:0:b0:2a8:c01a:71b6 with SMTP id
 a11-20020a2e980b000000b002a8c01a71b6mr432460ljj.3.1685725197185; Fri, 02 Jun
 2023 09:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230531022911.1168524-1-yosryahmed@google.com>
 <20230601155825.GF102494@cmpxchg.org> <CAJD7tkaFSfpTtB_ua_9QzR2voE1-hixv6RMJZd=WqpGmY93dSw@mail.gmail.com>
 <20230602164942.GA215355@cmpxchg.org>
In-Reply-To: <20230602164942.GA215355@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 2 Jun 2023 09:59:20 -0700
Message-ID: <CAJD7tkbp96S8MdrcH8y0V2G5Q-Zq6U4DAuweYhP-MjUWgcmjsQ@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: multiple zpool support
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>
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

On Fri, Jun 2, 2023 at 9:49=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Thu, Jun 01, 2023 at 10:51:39AM -0700, Yosry Ahmed wrote:
> > On Thu, Jun 1, 2023 at 8:58=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.=
org> wrote:
> > > On Wed, May 31, 2023 at 02:29:11AM +0000, Yosry Ahmed wrote:
> > > > +config ZSWAP_NR_ZPOOLS_ORDER
> > > > +     int "Number of zpools in zswap, as power of 2"
> > > > +     default 0
> > > > +     depends on ZSWAP
> > > > +     help
> > > > +       This options determines the number of zpools to use for zsw=
ap, it
> > > > +       will be 1 << CONFIG_ZSWAP_NR_ZPOOLS_ORDER.
> > > > +
> > > > +       Having multiple zpools helps with concurrency and lock cont=
ention
> > > > +       on the swap in and swap out paths, but uses a little bit of=
 extra
> > > > +       space.
> > >
> > > This is nearly impossible for a user, let alone a distribution, to
> > > answer adequately.
> > >
> > > The optimal value needs to be found empirically. And it varies heavil=
y
> > > not just by workload but by implementation changes. If we make change=
s
> > > to the lock holding time or redo the data structures, a previously
> > > chosen value might no longer be a net positive, and even be harmful.
> >
> > Yeah, I agree that this can only be tuned empirically, but there is a
> > real benefit to tuning it, at least in our experience. I imagined
> > having the config option with a default of 0 gives those who want to
> > tune it the option, while not messing with users that do not care.
>
> Realistically, how many users besides you will be able to do this
> tuning and benefit from this?

It's not difficult to try increasing the number of zpools and observe
reduction in lock contention vs. increase in cost for updating total
pool size. Updating the pool size is lockless and only involves an
atomic_read(), so I imagine it won't start showing up as a degradation
until the number of zpools is significant.

>
> > > Architecturally, the pool scoping and the interaction with zswap_tree
> > > is currently a mess. We're aware of lifetime bugs, where swapoff kill=
s
> > > the tree but the pool still exists with entries making dead reference=
s
> > > e.g. We likely need to rearchitect this in the near future - maybe ti=
e
> > > pools to trees to begin with.
> > >
> > > (I'm assuming you're already using multiple swap files to avoid tree
> > > lock contention, because it has the same scope as the pool otherwise.=
)
> > >
> > > Such changes quickly invalidate any settings the user or distro might
> > > make here. Exposing the implementation detail of the pools might even
> > > get in the way of fixing bugs and cleaning up the architecture.
> >
> > I was under the impression that config options are not very stable.
> > IOW, if we fix the lock contention on an architectural level, and
> > there is no more benefit to tuning the number of zpools per zswap
> > pool, we can remove the config option. Is this incorrect?
>
> The problem is that it complicates the code for everybody, for the
> benefit of a likely very small set of users - who have now opted out
> of any need for making the code better.
>
> And we have to keep this, and work around it, until things work for
> thosee users who have no incentive to address the underlying issues.
>
> That's difficult to justify.

I agree that it makes the code less digestible, but is it unbearably
terrible? I think it's arguably within reason.

>
> > > I don't think this patch is ready for primetime. A user build time
> > > setting is not appropriate for an optimization that is heavily tied t=
o
> > > implementation details and workload dynamics.
> >
> > What would you suggest instead? We do find value in having multiple
> > zpools, at least for the current architecture.
>
> I think it makes sense to look closer at the lock contention, and
> whether this can be improved more generically.
>
> zbud and z3fold don't have a lock in the ->map callback that heavily
> shows in the profile in your changelog. Is this zsmalloc specific?

We have observed this with zsmalloc, yes.

>
> If so, looking more closely at zsmalloc locking makes more sense. Is a
> lockless implementation feasible? Can we do rw-locking against
> zs_compact() to allow concurrency in zs_map_object()?

+Sergey Senozhatsky +Minchan Kim

I am not really sure, but it's not just zs_map_object(), it's also
zs_malloc() and I suspect other functions as well.

>
> This would benefit everybody, even zram users.
>
> Again, what about the zswap_tree.lock and swap_info_struct.lock?
> They're the same scope unless you use multiple swap files. Would it
> make sense to tie pools to trees, so that using multiple swapfiles for
> concurrency purposes also implies this optimization?

Yeah, using multiple swapfiles helps with those locks, but it doesn't
help with the zpool lock.

I am reluctant to take this path because I am trying to get rid of
zswap's dependency on swapfiles to begin with, and have it act as its
own standalone swapping backend. If I am successful, then having one
zpool per zswap_tree is just a temporary fix.
