Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F6360FA3C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbiJ0OPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbiJ0OPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:15:03 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DCC23EB2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:15:00 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id g11so1192413qts.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FiB4/nl2jh2fpoxzZJWIvh2hpwEiUdFi4UfLtVCENQg=;
        b=AeTtgS/zZSnwsC9g8GsOldGdwurc9M1oBkLYH2kp9NS3+l30aKe+SXPdGa0vOpXZqf
         66aHfw92eRn6oVxjdSHlIGccu+js8ILxw87BIz48jsc1U4nK8JPCEvzkIdcgv05vNzXl
         nb8k2vKMXKyvotZm2b6USSq996c0lHEI/ED1DXLKOnsyr508MRXK1znMs9l4tHwVuk1f
         xlIRfyJswp8J/5Xjv7SGaMkB47zRA1nIku4pmZl1sWdRXOG41P7rtA8cohc4PL2t4fks
         h83PvU+W14WKzD1GpFM1mXaKKde4rATCcbHACvpZPzuftI6Q8p6uAS6nPg3AiR1dl0wp
         +HjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FiB4/nl2jh2fpoxzZJWIvh2hpwEiUdFi4UfLtVCENQg=;
        b=TVC7jbcX/LF+EdpAOFVS0xEZjHf2svR1ITNPZIeUMyHdYlvfVDEUxUdMjmWetWT9Nx
         oJsAJbUSfAJ/Hjz4LyxBMu/IBRaVJ9iiNMmf1f4Pv0fZxVrTUuFeRg0DPcyhWvbQ42dF
         Ff572JR5oODN0mr6pp5zgalcT6OX/9gs5kV5YuXwVO8zaPwMEBUN8J2FRxwv/5hMhSHZ
         uueHiOe+xqhqp2AvVTpC9+x8S1SPd/lCJPB48PpW6usJQypHiHzHlrbL/VmRxqQk0oz5
         xnaGHbdc2jsND7U0/sIqRQjSOgpNMSNvEyk+gUzFCFYw+Sx7gvmV4PuK+D1qKKybckmr
         8Vhw==
X-Gm-Message-State: ACrzQf3iqPnnKIAK6tAroIuu9Yf4o3Erp0zCxRDd4pTAG8aHQCeIeeDJ
        JPQ6gVypBzUQsQX6Tkses17z4A==
X-Google-Smtp-Source: AMsMyM6LcCaZZAUoNCcj7eWRFmN1YMhnldHivBKR+dETtiflk/Op4/eS2tIEbNoo6ZeiRY8Vs5dytA==
X-Received: by 2002:ac8:5707:0:b0:39d:c40:cf51 with SMTP id 7-20020ac85707000000b0039d0c40cf51mr32277314qtw.102.1666880099687;
        Thu, 27 Oct 2022 07:14:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::25f1])
        by smtp.gmail.com with ESMTPSA id r6-20020ac85c86000000b003431446588fsm966231qta.5.2022.10.27.07.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 07:14:59 -0700 (PDT)
Date:   Thu, 27 Oct 2022 10:15:00 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Eric Bergen <ebergen@meta.com>
Subject: Re: [PATCH] mm: vmscan: split khugepaged stats from direct reclaim
 stats
Message-ID: <Y1qSZHK/U0SpNqNa@cmpxchg.org>
References: <20221025170519.314511-1-hannes@cmpxchg.org>
 <CAHbLzkoXzbHRJxb9DkjGkKQ8TAO08ctvz7wvjyPA8Gy2Skm+2g@mail.gmail.com>
 <Y1hM6sMRpBGUPRyo@cmpxchg.org>
 <CAHbLzkpaoN37camSLYVDU7p9AXzQjYcvHnWm3K87iwae-YyZiQ@mail.gmail.com>
 <Y1lvJBnVx1Fv5WHz@cmpxchg.org>
 <CAHbLzkqQ=6U3uerEkypsCHnmsXerEZi5erMSYK-kp8-vJNk89Q@mail.gmail.com>
 <CAJD7tkb5y9oqgVauVPiS0KbiL2Wnsu7jhK7Q44oUBZzBXwKUYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkb5y9oqgVauVPiS0KbiL2Wnsu7jhK7Q44oUBZzBXwKUYA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 07:41:21PM -0700, Yosry Ahmed wrote:
> On Wed, Oct 26, 2022 at 1:51 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Wed, Oct 26, 2022 at 10:32 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > On Tue, Oct 25, 2022 at 02:53:01PM -0700, Yang Shi wrote:
> > > > On Tue, Oct 25, 2022 at 1:54 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > >
> > > > > On Tue, Oct 25, 2022 at 12:40:15PM -0700, Yang Shi wrote:
> > > > > > On Tue, Oct 25, 2022 at 10:05 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > > > >
> > > > > > > Direct reclaim stats are useful for identifying a potential source for
> > > > > > > application latency, as well as spotting issues with kswapd. However,
> > > > > > > khugepaged currently distorts the picture: as a kernel thread it
> > > > > > > doesn't impose allocation latencies on userspace, and it explicitly
> > > > > > > opts out of kswapd reclaim. Its activity showing up in the direct
> > > > > > > reclaim stats is misleading. Counting it as kswapd reclaim could also
> > > > > > > cause confusion when trying to understand actual kswapd behavior.
> > > > > > >
> > > > > > > Break out khugepaged from the direct reclaim counters into new
> > > > > > > pgsteal_khugepaged, pgdemote_khugepaged, pgscan_khugepaged counters.
> > > > > > >
> > > > > > > Test with a huge executable (CONFIG_READ_ONLY_THP_FOR_FS):
> > > > > > >
> > > > > > > pgsteal_kswapd 1342185
> > > > > > > pgsteal_direct 0
> > > > > > > pgsteal_khugepaged 3623
> > > > > > > pgscan_kswapd 1345025
> > > > > > > pgscan_direct 0
> > > > > > > pgscan_khugepaged 3623
> > > > > >
> > > > > > There are other kernel threads or works may allocate memory then
> > > > > > trigger memory reclaim, there may be similar problems for them and
> > > > > > someone may try to add a new stat. So how's about we make the stats
> > > > > > more general, for example, call it "pg{steal|scan}_kthread"?
> > > > >
> > > > > I'm not convinved that's a good idea.
> > > > >
> > > > > Can you generally say that userspace isn't indirectly waiting for one
> > > > > of those allocating threads? With khugepaged, we know.
> > > >
> > > > AFAIK, ksm may do slab allocation with __GFP_DIRECT_RECLAIM.
> > >
> > > Right, but ksm also uses __GFP_KSWAPD_RECLAIM. So while userspace
> > > isn't directly waiting for ksm, when ksm enters direct reclaim it's
> > > because kswapd failed. This is of interest to kernel developers.
> > > Userspace will likely see direct reclaim in that scenario as well, so
> > > the ksm direct reclaim counts aren't liable to confuse users.
> > >
> > > Khugepaged on the other hand will *always* reclaim directly, even if
> > > there is no memory pressure or kswapd failure. The direct reclaim
> > > counts there are misleading to both developers and users.
> > >
> > > What it really should be is pgscan_nokswapd_nouserprocesswaiting, but
> > > that just seems kind of long ;-)
> > >
> > > I'm also not sure anybody but khugepaged is doing direct reclaim
> > > without kswapd reclaim. It seems unlikely we'll get more of those.
> >
> > IIUC you actually don't care about how many direct reclaim are
> > triggered by khugepaged, but you would like to separate the direct
> > reclaim stats between that are triggered directly by userspace
> > actions, which may stall userspace, and that aren't, which don't stall
> > userspace. If so it doesn't sound that important to distinguish
> > whether the direct reclaim are triggered by khugepaged or other kernel
> > threads even though other kthreads are not liable to confuse users
> > IMHO.

I feel like I've sufficiently explained my reason for wanting to
separate out the __GFP_KSWAPD_RECLAIM special case from other sites.

> My 2c, if we care about direct reclaim as in reclaim that may stall
> user space application allocations, then there are other reclaim
> contexts that may pollute the direct reclaim stats. For instance,
> proactive reclaim, or reclaim done by writing a limit lower than the
> current usage to memory.max or memory.high, as they are not done in
> the context of the application allocating memory.
>
> At Google, we have some internal direct reclaim memcg statistics, and
> the way we handle this is by passing a flag from such contexts to
> try_to_free_mem_cgroup_pages() in the reclaim_options arg. This flag
> is echod into a scan_struct bit, which we then use to filter out
> direct reclaim operations that actually cause latencies in user space
> allocations.
> 
> Perhaps something similar might be more generic here? I am not sure
> what context khugepaged reclaims memory from, but I think it's not a
> memcg context, so maybe we want to generalize the reclaim_options arg
> to try_to_free_pages() or whatever interface khugepaged uses to free
> memory.

So at the /proc/vmstat level, I'm not sure it matters much because it
doesn't count any cgroup_reclaim() activity.

But at the cgroup level, it sure would be nice to split out proactive
reclaim churn. Both in terms of not polluting direct reclaim counts,
but also for *knowing* how much proactive reclaim is doing.

Do you have separate counters for this?
