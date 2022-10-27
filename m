Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8C260EE04
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 04:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbiJ0CmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 22:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbiJ0CmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 22:42:11 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7F9C7053
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 19:42:08 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id p141so302496iod.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 19:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iaUe+pLIKuotMJ39OMLbcGSkpKsSa+oUY7YZScLgavs=;
        b=CCXUQWWKXkpgZJCxRkBX+IrdD+rb4aVaV7rSqSAB16iGSKWGRuBjROfW/aMB/z0XYj
         BfqpPRN8uuhiQQX0u7biU43mTr1AbZFm5GM2xSZ2hKGKzHD8D3a+VS4yDtDyyQI1Zg/V
         2CL8XxP1t6HcwyY7+7DdafDks3ESa7ls6B4nSRtX2dlOtZ6TvgeY1/EqBHiKDWJPBAhr
         2HNY7pEr97+4VJgUHA/gIWi03yj4W1c3gegOW7ArepjuzwXZue4WJ/WwLBPYbTA4BZ/h
         VhTE8WcnyswGp4OHdIKyatj/bo+ez3Rl5Cob9gfsXenB4QjM/XycKD6Qj2jo4M4GmsnA
         2avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iaUe+pLIKuotMJ39OMLbcGSkpKsSa+oUY7YZScLgavs=;
        b=rmYvcyC9BdEuDVh3DHz24jjCvLpB7v/03e39HMIuveN0vlIKKCfWZ/VEUxACnqslWF
         99PrOSWhe/9k3+Mbnw43aq3uUjTcw9UIiMGuACe4MXWP5U2uwYPuB9ROTaD6wJF06TGX
         YnSItL6tpd54zg+2Jw1UHcixHjo3IiK/e5BjxQ9ST4r1mziEUIe7PFlHeVlCsl2WLZpn
         tNdCkTp2K1gfCyObWQHOdMc4bhH6htM8SPOlv3eHG9tKrGfChZmGPkbwcFML/GFaf+XT
         w0CvY8DCNZCd2di1HjHb5YXKjFNY+4cEwe1NPXyPaeeOLWTsj0Qkj17YJR+Ob9wh2qNK
         xVLg==
X-Gm-Message-State: ACrzQf0pA61uxJEYrtFZtlQibU5b4y2b60k4wp2cswUBb3VqwFiWpZdK
        2AOP7s6WuyJinoPfPpyxIMsBhxGZtvwMprXv8pTPpd4LscY=
X-Google-Smtp-Source: AMsMyM7FUi9zjuaTuV+X2Qo0ESkxvnwWjKQvo/6yRCs963VpBh21BQkoHXBb1hn9z6pyJhFDk7SIZ4fnza8JpLTEeaA=
X-Received: by 2002:a05:6638:1450:b0:363:7052:9c30 with SMTP id
 l16-20020a056638145000b0036370529c30mr29897076jad.53.1666838516973; Wed, 26
 Oct 2022 19:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20221025170519.314511-1-hannes@cmpxchg.org> <CAHbLzkoXzbHRJxb9DkjGkKQ8TAO08ctvz7wvjyPA8Gy2Skm+2g@mail.gmail.com>
 <Y1hM6sMRpBGUPRyo@cmpxchg.org> <CAHbLzkpaoN37camSLYVDU7p9AXzQjYcvHnWm3K87iwae-YyZiQ@mail.gmail.com>
 <Y1lvJBnVx1Fv5WHz@cmpxchg.org> <CAHbLzkqQ=6U3uerEkypsCHnmsXerEZi5erMSYK-kp8-vJNk89Q@mail.gmail.com>
In-Reply-To: <CAHbLzkqQ=6U3uerEkypsCHnmsXerEZi5erMSYK-kp8-vJNk89Q@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 26 Oct 2022 19:41:21 -0700
Message-ID: <CAJD7tkb5y9oqgVauVPiS0KbiL2Wnsu7jhK7Q44oUBZzBXwKUYA@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: split khugepaged stats from direct reclaim stats
To:     Yang Shi <shy828301@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
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

On Wed, Oct 26, 2022 at 1:51 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Wed, Oct 26, 2022 at 10:32 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Tue, Oct 25, 2022 at 02:53:01PM -0700, Yang Shi wrote:
> > > On Tue, Oct 25, 2022 at 1:54 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > >
> > > > On Tue, Oct 25, 2022 at 12:40:15PM -0700, Yang Shi wrote:
> > > > > On Tue, Oct 25, 2022 at 10:05 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > > >
> > > > > > Direct reclaim stats are useful for identifying a potential source for
> > > > > > application latency, as well as spotting issues with kswapd. However,
> > > > > > khugepaged currently distorts the picture: as a kernel thread it
> > > > > > doesn't impose allocation latencies on userspace, and it explicitly
> > > > > > opts out of kswapd reclaim. Its activity showing up in the direct
> > > > > > reclaim stats is misleading. Counting it as kswapd reclaim could also
> > > > > > cause confusion when trying to understand actual kswapd behavior.
> > > > > >
> > > > > > Break out khugepaged from the direct reclaim counters into new
> > > > > > pgsteal_khugepaged, pgdemote_khugepaged, pgscan_khugepaged counters.
> > > > > >
> > > > > > Test with a huge executable (CONFIG_READ_ONLY_THP_FOR_FS):
> > > > > >
> > > > > > pgsteal_kswapd 1342185
> > > > > > pgsteal_direct 0
> > > > > > pgsteal_khugepaged 3623
> > > > > > pgscan_kswapd 1345025
> > > > > > pgscan_direct 0
> > > > > > pgscan_khugepaged 3623
> > > > >
> > > > > There are other kernel threads or works may allocate memory then
> > > > > trigger memory reclaim, there may be similar problems for them and
> > > > > someone may try to add a new stat. So how's about we make the stats
> > > > > more general, for example, call it "pg{steal|scan}_kthread"?
> > > >
> > > > I'm not convinved that's a good idea.
> > > >
> > > > Can you generally say that userspace isn't indirectly waiting for one
> > > > of those allocating threads? With khugepaged, we know.
> > >
> > > AFAIK, ksm may do slab allocation with __GFP_DIRECT_RECLAIM.
> >
> > Right, but ksm also uses __GFP_KSWAPD_RECLAIM. So while userspace
> > isn't directly waiting for ksm, when ksm enters direct reclaim it's
> > because kswapd failed. This is of interest to kernel developers.
> > Userspace will likely see direct reclaim in that scenario as well, so
> > the ksm direct reclaim counts aren't liable to confuse users.
> >
> > Khugepaged on the other hand will *always* reclaim directly, even if
> > there is no memory pressure or kswapd failure. The direct reclaim
> > counts there are misleading to both developers and users.
> >
> > What it really should be is pgscan_nokswapd_nouserprocesswaiting, but
> > that just seems kind of long ;-)
> >
> > I'm also not sure anybody but khugepaged is doing direct reclaim
> > without kswapd reclaim. It seems unlikely we'll get more of those.
>
> IIUC you actually don't care about how many direct reclaim are
> triggered by khugepaged, but you would like to separate the direct
> reclaim stats between that are triggered directly by userspace
> actions, which may stall userspace, and that aren't, which don't stall
> userspace. If so it doesn't sound that important to distinguish
> whether the direct reclaim are triggered by khugepaged or other kernel
> threads even though other kthreads are not liable to confuse users
> IMHO.

My 2c, if we care about direct reclaim as in reclaim that may stall
user space application allocations, then there are other reclaim
contexts that may pollute the direct reclaim stats. For instance,
proactive reclaim, or reclaim done by writing a limit lower than the
current usage to memory.max or memory.high, as they are not done in
the context of the application allocating memory.

At Google, we have some internal direct reclaim memcg statistics, and
the way we handle this is by passing a flag from such contexts to
try_to_free_mem_cgroup_pages() in the reclaim_options arg. This flag
is echod into a scan_struct bit, which we then use to filter out
direct reclaim operations that actually cause latencies in user space
allocations.

Perhaps something similar might be more generic here? I am not sure
what context khugepaged reclaims memory from, but I think it's not a
memcg context, so maybe we want to generalize the reclaim_options arg
to try_to_free_pages() or whatever interface khugepaged uses to free
memory.

>
> >
> > > Some device mapper drivers may do heavy lift in the work queue, for
> > > example, dm-crypt, particularly for writing.
> >
> > Userspace will wait for those through dirty throttling. We'd want to
>
> Not guaranteed.
>
> Anyway I just thought pgscan_khugepaged might be more confusing for
> the users even the developers who are not familiar with
> THP/khugepaged.
>
> > know about kswapd failures in that case - again, without them being
> > muddied by khugepaged.
> >
> > > > And those other allocations are usually ___GFP_KSWAPD_RECLAIM, so if
> > > > they do direct reclaim, we'd probably want to know that kswapd is
> > > > failing to keep up (doubly so if userspace is waiting). In a shared
> > > > kthread counter, khugepaged would again muddy the waters.
>
