Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082FB6DA8B0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 08:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjDGGDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 02:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjDGGDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 02:03:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699C359C7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 23:03:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g18so6269302ejx.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 23:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680847417; x=1683439417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bG/ZnLi19D5O/SrE3f26gQDppjt4TYCXq5qDEfu3yk=;
        b=C0OKCAkNpCuqMVoglQszSXSfrLXbKCG88wzIvdCQWt2IKTq2EOQqXymr+cXj/mD0f5
         GLf5/ZxghjmOVsI+B9Omic/DGS+gJTTeeyVne7MVe+2gTSvpfFkhLXjtNJdGcTtdeh7k
         3q85559UjToVuMHX706df5nD8mngIV/snDziDP9A+F6AsxUK9/IB2m59k2k87FDz7BLn
         m96JJcWSapLbiaW8Sl71JnMxlpjUMQAmTOWO1I+ER6rAWA4dMoYZsjj74/zIWY5r8ASP
         MsJnkpHhzg8M2ZSLMTGb+5LVgB5MW6Vx4U4hKW2FiM0TZPE/3n+uMmxJwdeNMqxh8eLO
         EXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680847417; x=1683439417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bG/ZnLi19D5O/SrE3f26gQDppjt4TYCXq5qDEfu3yk=;
        b=hAiZwwcjXr35SI/6J/L1LeDzz7nqy3ArB2fM3es74rkuLq1SU5sqZYgegTTesz3yT/
         eofVzSKZIDVha1u8kGmYjg3NbtS4koao7mgYMr3IEHChJDo/lGZ7gHM9ametJkZUYoku
         3XOd1JQEP0A8Z/cV/X5046ovUD1cAt4D7zBTiHC9TjVUZBJXDSluopHOBJtGE5rFM+dy
         l8bJI0uFMXouTEL/bTxec1KnjqUxZ4cpH99GxD1NdWcB1uqdhfwuB6injdk637gOSeB4
         EFYxq+IeAweV1VUEvKnik7cNLtEDWPtwoPuGSg/QidqmN4LreYBtgA7E2dPfNq95wunW
         2LxA==
X-Gm-Message-State: AAQBX9ehB2QgZtvA7H+cDBaLI0p0Yc2zvTQFTN24Z+BMWoe8VQ7bMXhv
        XbbsW3INPo982lh28Y/MUSdjJbD0Be2C1h1WJLuuoA==
X-Google-Smtp-Source: AKy350Zs79NcKShlkUJkXCvv+lqDNYKXRHT7Sgzmh3o6Jvl7qDy8I9/biYjb2riqTPkATS+AGUjUtlLtPeu2PIsuWXo=
X-Received: by 2002:a17:906:7ac5:b0:933:7658:8b44 with SMTP id
 k5-20020a1709067ac500b0093376588b44mr522670ejo.15.1680847416736; Thu, 06 Apr
 2023 23:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230405200150.GA35884@cmpxchg.org> <CAOUHufYCxdAXtw_b1qFT_02L3gWcs3of6Y0-5mmLwr+CeWvLQQ@mail.gmail.com>
 <20230406200213.GA50192@cmpxchg.org>
In-Reply-To: <20230406200213.GA50192@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 6 Apr 2023 23:03:00 -0700
Message-ID: <CAJD7tkaBHKvT2KDYg0x873mV6WW-Ky-HmQRKqc2qA4ir3nb=5g@mail.gmail.com>
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
>
> - Root memory.reclaim is exempted from the compaction_ready() bail
>   condition as well as soft limit reclaim. But they'd both be no-ops
>   anyway if we changed cgroup_reclaim() semantics.
>
> IMO we should either figure out what we want to do in those cases
> above, at least for writeback throttling.
>
> Are you guys using root-level proactive reclaim?
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
>
> If so, I agree it could be better to move it to CONFIG_LRU_GEN and
> rename it for the time being. root_reclaim() SGTM.

Oh and if we decide to keep the helper as root_reclaim I would prefer
it to be outside CONFIG_LRU_GEN so that I can still use it in the
patch series that this thread was originally a part of (ignoring
non-LRU freed pages in memcg reclaim).
