Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C3E61197E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJ1Rmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiJ1RmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:42:12 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8982922BAFD
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:41:56 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j15so7562702wrq.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8KkWfKiz0cSNppU9iFP+EvH1bzfYhMCvsF3MklhkLYw=;
        b=B5mRf1YsKAzLwejzUowTuA0m8tpmrtQDWwrhFV18HQ9HVtNHc/9c75EGEitREptPvj
         w4I7u+u87r3EzaLmOZp9uU8Qa2eXbUUl4bTrSXJLSUK7M1IbPVpZs8c+3ZZK/TKrTvfD
         zyUT1pm3XScW9vsl45X8LCg14rZ1nSpPddHM8RowDkivSLw/zlO1gaMHfZ5lduTtgZ2L
         GU2tuvr6EaOt4Sq33px6tMbqkVzbe5TfGPMejiP8y3Teu+4uD5BgywslqBOfbTGoYY+U
         v/soxbnnCqJFlwOMOHEw3Jjk6XaN8zSuGQhY1PLiOpZ8x+v9GhbXNz5pOWKxX78NhbIa
         LCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8KkWfKiz0cSNppU9iFP+EvH1bzfYhMCvsF3MklhkLYw=;
        b=i7FY0vhGbVcV8nnWEXBPrylvNDJUJaX3167zLpz6XQcPQAGoDDLoOWQQDaafhP6Dwc
         0cAUoVEhvXUZNxRMpp5RSbTH5nCzRx+STeVyEyhDTWKVT13wtzVqIMIawttU1cLjYuTy
         Z0lVRfzakrVcx0u5LK7lbD/Zk6bf+IbZOao+aX/INPaTAV47r7lMAbJid5bK1+SWlz8U
         uDizUq2CliN2D33VulAkpWMDpUwhwsW5H5b4m5vp50dcoEp79KaUBX5c7ZabudoJ4FXI
         VQvpGvMJULAcRyK8MSCIr54J/hW+Y5a/qtxovITpmJTR/4CwMjcufIeHEsvIIzsTW21f
         wI7g==
X-Gm-Message-State: ACrzQf00OpTb8fugFh5xOTlmzNexdEA6ksjjPnrOzK5wRhvmvVpJn2M9
        y4G9n6sjqQgi11NJmrEgyObAkLwuZthWAIFDd5pWlVBInVqTiw==
X-Google-Smtp-Source: AMsMyM76WTtyCx9G4hKBPCNNp48t/fgBD1R42C4iJR7ts6rTEsWoUilhcv/zLdwytkre3jAFO9DH91uBeTX8anY+8j8=
X-Received: by 2002:a5d:6d0b:0:b0:232:bd2e:1bf2 with SMTP id
 e11-20020a5d6d0b000000b00232bd2e1bf2mr311572wrq.534.1666978914934; Fri, 28
 Oct 2022 10:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221025170519.314511-1-hannes@cmpxchg.org> <CAHbLzkoXzbHRJxb9DkjGkKQ8TAO08ctvz7wvjyPA8Gy2Skm+2g@mail.gmail.com>
 <Y1hM6sMRpBGUPRyo@cmpxchg.org> <CAHbLzkpaoN37camSLYVDU7p9AXzQjYcvHnWm3K87iwae-YyZiQ@mail.gmail.com>
 <Y1lvJBnVx1Fv5WHz@cmpxchg.org> <CAHbLzkqQ=6U3uerEkypsCHnmsXerEZi5erMSYK-kp8-vJNk89Q@mail.gmail.com>
 <CAJD7tkb5y9oqgVauVPiS0KbiL2Wnsu7jhK7Q44oUBZzBXwKUYA@mail.gmail.com>
 <Y1qSZHK/U0SpNqNa@cmpxchg.org> <CAJD7tkYt-KL=jDEy6pSOc5tDij=3SWmbhFeco39pjJuOmEAH0g@mail.gmail.com>
 <Y1vprODaLJLk0dka@cmpxchg.org>
In-Reply-To: <Y1vprODaLJLk0dka@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 28 Oct 2022 10:41:17 -0700
Message-ID: <CAJD7tkbBbh+uXe7S=a0E5=FBX4wVa7YDJDLmti370v2sVWVtWw@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: split khugepaged stats from direct reclaim stats
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Eric Bergen <ebergen@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 7:39 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, Oct 27, 2022 at 01:43:24PM -0700, Yosry Ahmed wrote:
> > On Thu, Oct 27, 2022 at 7:15 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > On Wed, Oct 26, 2022 at 07:41:21PM -0700, Yosry Ahmed wrote:
> > > > My 2c, if we care about direct reclaim as in reclaim that may stall
> > > > user space application allocations, then there are other reclaim
> > > > contexts that may pollute the direct reclaim stats. For instance,
> > > > proactive reclaim, or reclaim done by writing a limit lower than the
> > > > current usage to memory.max or memory.high, as they are not done in
> > > > the context of the application allocating memory.
> > > >
> > > > At Google, we have some internal direct reclaim memcg statistics, and
> > > > the way we handle this is by passing a flag from such contexts to
> > > > try_to_free_mem_cgroup_pages() in the reclaim_options arg. This flag
> > > > is echod into a scan_struct bit, which we then use to filter out
> > > > direct reclaim operations that actually cause latencies in user space
> > > > allocations.
> > > >
> > > > Perhaps something similar might be more generic here? I am not sure
> > > > what context khugepaged reclaims memory from, but I think it's not a
> > > > memcg context, so maybe we want to generalize the reclaim_options arg
> > > > to try_to_free_pages() or whatever interface khugepaged uses to free
> > > > memory.
> > >
> > > So at the /proc/vmstat level, I'm not sure it matters much because it
> > > doesn't count any cgroup_reclaim() activity.
> > >
> > > But at the cgroup level, it sure would be nice to split out proactive
> > > reclaim churn. Both in terms of not polluting direct reclaim counts,
> > > but also for *knowing* how much proactive reclaim is doing.
> > >
> > > Do you have separate counters for this?
> >
> > Not yet. Currently we only have the first part, not polluting direct
> > reclaim counts.
> >
> > We basically exclude reclaim coming from memory.reclaim, setting
> > memory.max/memory.limit_in_bytes, memory.high (on write, not hitting
> > the high limit), and memory.force_empty from direct reclaim stats.
> >
> > As for having a separate counter for proactive reclaim, do you think
> > it should be limited to reclaim coming from memory.reclaim (and
> > potentially memory.force_empty), or should it include reclaim coming
> > from limit-setting as well?
>
> A combined counter seems reasonable to me. We *have* used the limit
> knobs to drive proactive reclaim in production in the past, so it's
> not a stretch. And I can't think of a scenario where you'd like them
> to be separate.
>
> I could think of two ways of describing it:
>
> pgscan_user: User-requested reclaim. Could be confusing if we ever
> have an in-kernel proactive reclaim driver - unless that would then go
> to another counter (new or kswapd).
>
> pgscan_ext: Reclaim activity from extraordinary/external
> requests. External as in: outside the allocation context.

I imagine if the kernel is doing proactive reclaim on its own, we
might want a separate counter for that anyway to monitor what the
kernel is doing. So maybe pgscan_user sounds nice for now, but I also
like that the latter explicitly says "this is external to the
allocation context". But we can just go with pgscan_user and document
it properly.

How would khugepaged fit in this story? Seems like it would be part of
pgscan_ext but not pgscan_user. I imagine we also don't want to
pollute proactive reclaim counters with khugepaged reclaim (or other
non-direct reclaim).

Maybe pgscan_user and pgscan_kernel/pgscan_indirect for things like khugepaged?
The problem with pgscan_kernel/indirect is that if we add a proactive
reclaim kthread in the future it would technically fit there but we
would want a separate counter for it.

I am honestly not sure where to put khugepaged. The reasons I don't
like a dedicated counter for khugepaged are:
- What if other kthreads like khugepaged start doing the same, do we
add one counter per-thread?
- What if we deprecate khugepaged (or such threads)? Seems more likely
than deprecating kswapd.

Looks like we want a stat that would group all of this reclaim coming
from non-direct kthreads, but would not include a future proactive
reclaim kthread.
