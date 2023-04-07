Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD146DA78F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 04:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbjDGCNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 22:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbjDGCN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 22:13:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15E25B92
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 19:13:19 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-93df929479cso184382766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 19:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680833598; x=1683425598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uw7z6BtmdRPECHM5D7R39D046Vw8erZekBIO6oda94A=;
        b=J0aH9T34gdgTkw+EogKK58akB7cnB7hqxhrjOq78CTU6CGB1ouCDiXi+IpAAHiiImr
         Oh1E2I4B65WJYDBbVyZvlatduia9W7ir+wcIqzTgRIP9ICuH8qx/ypzh27BoCyxGnD0D
         38yL3zS3spOxi4lUYCklbKN/jDti5VosL+9Ad6sqWD98m7cUP50fJTRivJheSAj959WA
         I9jhfJ3y7RruYN2NTJ36a+v+lMMk+Se7L4R/FLYJ+/04X9lrWHFZ4gE5MN9Mo4gSHSQL
         5pTc++4NWsJxgd2h5zewB8m3yfcuAd0Rm2WmYfrCQ8gXnm6lJnlG9YcFLD8dhcRE8U0X
         +mmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680833598; x=1683425598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uw7z6BtmdRPECHM5D7R39D046Vw8erZekBIO6oda94A=;
        b=OpCn/9UCOXB5soqUZrDDDTK1z7kUOK8OppeUD0g36eTqYLuGOy+tBM/Au21P9L6BLI
         Si0umM7g+bASaR8IEQLx5j2qcxj3MK+qgSNKp8Qlk6BUEJgTfyRRTb8oMzaK4xzFST+i
         ABX1FNsdAmZwCJABfx1jgkJ2eOuwO/RsxOXE2Hy1sHvJhg9NvKBsnCbgBMO5umK/oKAQ
         ue4enr7bd9GHV0hU1jwZLR5ze8u52lFn7JwEixIqB3I96QfxYPADgBr2ORehnT+79z/0
         l5z1QRJThTw0Mo0SG4dUJtskY8EI4a4WkmJxnGUxFO9MeD9peGGT68TGeQ5X/mrPJ2So
         2hKg==
X-Gm-Message-State: AAQBX9eUHGDXuOgRORqEoUE7o6RggUf3v18oF6FWdgKByj2d2oKiGC9G
        QDOd2FknNZGHPPgdcgLzbS2Z1cQJp6XNjDOsr+RVF5Z393gyo+jxd7RTGw==
X-Google-Smtp-Source: AKy350bd4DrRe4bHvAqsPe6hbXJ578VTqrJY0Efj1hLNCP/NAAyPKr8UKh7/faMYFxRUrB5peBjh0FsTOmSPHItv3Bk=
X-Received: by 2002:a50:cddc:0:b0:4fb:9735:f915 with SMTP id
 h28-20020a50cddc000000b004fb9735f915mr178852edj.8.1680833598134; Thu, 06 Apr
 2023 19:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230405200150.GA35884@cmpxchg.org> <CAOUHufYCxdAXtw_b1qFT_02L3gWcs3of6Y0-5mmLwr+CeWvLQQ@mail.gmail.com>
 <20230406200213.GA50192@cmpxchg.org>
In-Reply-To: <20230406200213.GA50192@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 6 Apr 2023 19:12:41 -0700
Message-ID: <CAJD7tkY681w3wJD4NnNJFwG2Xz6Y-7sXdX9CWp=FGhqBqzYzrQ@mail.gmail.com>
Subject: Re: global_reclaim() and code documentation (was: Re: [PATCH v3 3/3]
 mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 1:02=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Wed, Apr 05, 2023 at 03:09:27PM -0600, Yu Zhao wrote:
> > On Wed, Apr 5, 2023 at 2:01=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.=
org> wrote:
> > > static bool cgroup_reclaim(struct scan_control *sc)
> > > {
> > >         return sc->target_mem_cgroup;
> > > }
> > >
> > > static bool global_reclaim(struct scan_control *sc)
> > > {
> > >         return !sc->target_mem_cgroup || mem_cgroup_is_root(sc->targe=
t_mem_cgroup);
> > > }
> > >
> > > The name suggests it's the same thing twice, with opposite
> > > polarity. But of course they're subtly different, and not documented.
> > >
> > > When do you use which?
> >
> > The problem I saw is that target_mem_cgroup is set when writing to the
> > root memory.reclaim. And for this case, a few places might prefer
> > global_reclaim(), e.g., in shrink_lruvec(), in addition to where it's
> > being used.
> >
> > If this makes sense, we could 1) document it (or rename it) and apply
> > it to those places, or 2) just unset target_mem_cgroup for root and
> > delete global_reclaim(). Option 2 might break ABI but still be
> > acceptable.
>
> Ah, cgroup_reclaim() tests whether it's limit/proactive reclaim or
> allocator reclaim. global_reclaim() tests whether it's root reclaim
> (which could be from either after memory.reclaim).
>
> I suppose we didn't clarify when introducing memory.reclaim what the
> semantics should be on the root cgroup:

Thanks for the great summary, Johannes!

>
> - We currently exclude PGSCAN and PGSTEAL stats from /proc/vmstat for
>   limit reclaim to tell cgroup constraints from physical pressure. We
>   currently exclude root memory.reclaim activity as well. Seems okay.
>
> - The file_is_tiny heuristic is for allocator reclaim near OOM. It's
>   currently excluded for root memory.reclaim, which seems okay too.
>
> - Like limit reclaim, root memory.reclaim currently NEVER swaps when
>   global swappiness is 0. The whole cgroup-specific swappiness=3D0
>   semantic is kind of quirky. But I suppose we can keep it as-is.
>
> - Proportional reclaim is disabled for everybody but direct reclaim
>   from the allocator at initial priority. Effectively disabled for all
>   situations where it might matter, including root memory.reclaim. We
>   should also keep this as-is.

Agree with the above.

>
> - Writeback throttling is interesting. Historically, kswapd set the
>   congestion state when running into lots of PG_reclaim pages, and
>   clear it when the node is balanced. This throttles direct reclaim.
>
>   Cgroup limit reclaim would set and clear congestion on non-root only
>   to do local limit-reclaim throttling. But now root memory.reclaim
>   might clear a bit set by kswapd before the node is balanced, and
>   release direct reclaimers from throttling prematurely. This seems
>   wrong. However, the alternative is throttling memory.reclaim on
>   subgroup congestion but not root, which seems also wrong.

Ah yes, that is a problem.

It seems like the behavior of the congested bit is different on the
root's lruvec, it would throttle direct reclaimers until the node is
balanced, not just until reclaim completes. Is my understanding
correct?

If yes, would it be a solution to introduce a dedicated bit for this
behavior, LRUVEC_UNBALANCED or so?
We can set this bit in kswapd only for root, and only clear it when
the node is balanced.
This would be separate from LRUVEC_CONGESTED that always gets cleared
when reclaim completes.

Although it might be confusing that we set both LRUVEC_CONGESTED and
LRUVEC_UNBALANCED for root, perhaps it would be better to have a more
explicit condition to set LRUVEC_UNBALANCED in kswapd logic -- but
this may be a change of behavior.

I understand the special casing might not be pretty, but it seems like
it may already be a special case, so perhaps a separate bit will make
this more clear.

Just thinking out loud here, I am not familiar with this part of
reclaim code so please excuse any stupid statements I might have made.

>
> - Root memory.reclaim is exempted from the compaction_ready() bail
>   condition as well as soft limit reclaim. But they'd both be no-ops
>   anyway if we changed cgroup_reclaim() semantics.
>
> IMO we should either figure out what we want to do in those cases
> above, at least for writeback throttling.
>
> Are you guys using root-level proactive reclaim?

We do, but not in its current upstream form. We have some special
flags to only iterate the root memcg and zombie memcgs, and we
periodically use proactive reclaim on the root memcg with these flags.
The purpose is to reclaim any unaccounted memory or memory charged to
zombie memcgs if possible -- potentially freeing zombie memcgs as
well.

>
> > If we don't want to decide right now, I can rename global_reclaim() to
> > root_reclaim() and move it within #ifdef CONFIG_LRU_GEN and probably
> > come back and revisit later.
>
> So conventional vmscan treats root-level memory.reclaim the same as
> any other cgroup reclaim. And the cgroup_reclaim() checks are mostly
> reserved for (questionable) allocator reclaim-specific heuristics.
>
> Is there a chance lrugen could do the same, and you'd be fine with
> using cgroup_reclaim()? Or is it a data structure problem?

I will let Yu answer this question, but I will take a stab at it just
for my own education :)

It seems like we use global_reclaim() mainly for two things for MGLRU:
(1) For global_reclaim(), we use the memcg fairness/scalability logic
that was introduced by [1], where for global_reclaim() we don't use
mem_cgroup_iter(), but we use an LRU of memcgs for fairness and
scalability purposes (we don't have to iterate all memcgs every time,
and parallel reclaimers can iterate different memcgs).

(2) For !global_reclaim(), we do not abort early before traversing all
memcgs to be fair to all children.

If we use cgroup_reclaim() instead of global_reclaim(), we move
proactive reclaim on root from (1) to (2) above.
My gut feeling is that it's fine, because proactive reclaim is more
latency tolerant, and other direct reclaimers will be using the LRU of
memcgs anyway, so proactive reclaim should not affect their
fairness/scalability.

[1]https://lkml.kernel.org/r/20221222041905.2431096-7-yuzhao@google.com

>
> If so, I agree it could be better to move it to CONFIG_LRU_GEN and
> rename it for the time being. root_reclaim() SGTM.
