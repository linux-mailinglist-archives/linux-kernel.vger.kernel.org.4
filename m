Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9905D6D87A0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjDEUCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjDEUCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:02:36 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65DF7D9D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 13:01:52 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id a5so36136291qto.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 13:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680724911;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgGe4pUmwbq6B4NsSylYT8hCeXq6m9SaGK88QHwMshQ=;
        b=U19A8LKKl+fJZGxIKAXOBNvTvfbruhrr9biRcs2jmTzqRJxz4iytcYWdCpajJcxvwL
         SJ7M89UuRB1y87JneNoNtLAoYdjiP+Y7PTD7ccg6AYHFy0XXhuQgSXJff1QmL5rAj6Dn
         5onLrBqZ9ZDU34znBogo1SI+PnwCzyGahtovnaRZjHfKD3c1qB5WyX/s0XdHNuq4G5ny
         34qzJcKY+G8YJNQB1ZoQcEUiKw+nY/MFX9Azbkhoi3Ko/K4WTuML2T6c7h0pVu/5T55A
         E3cKNp0nAcZNcE7onDk+5IJB7MquiTZfDskUcBkVKxPhe7JCHVNa5UErAS3pGWRn/jCW
         XF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680724911;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgGe4pUmwbq6B4NsSylYT8hCeXq6m9SaGK88QHwMshQ=;
        b=diBND2SCnblavVjnflgqyu4ArV4Cnv63KmhBk3CSBln83fHGL3Zq6dr1Mue5zXgoUo
         OX1NgiruutlqmMGOwnU+XhHmewaOnETMnVByR1cKyD1HdPZXB+h9nybiBfWLgj1TvMGF
         E30INomIXus7rUoV+MDA8UitrZdVg31+3eOpDRjnxPrjSQctiyIxe/g8NVIK3oPNIMk7
         nONnNiPiGjopOgb945dYCzGDCn37vRuwXVRxfptJKHjboexVy4NOJfEu/v4vcj/yKb6U
         xzpJbFskdqvRjMwzq+aFA5PNqBKt+rvEIe5tougfUh8/2x6Ud8hfZLYwfhx7VsrbGImP
         ViuA==
X-Gm-Message-State: AAQBX9eMaVEL7ZWbdBx5jTHICBeqx+IvYxvKY/rm2FktoITXDjglp8Z3
        yukHhperv9u+hZ5ZgWaPLiDvKg==
X-Google-Smtp-Source: AKy350aX1Q577kbAVVqqzQ4NQD8iEi6zXbeaKnSWtw5h60ZgijFkV1O+9yZytvy5u9fCAVUX4DekmA==
X-Received: by 2002:ac8:5a93:0:b0:3e3:82c4:db44 with SMTP id c19-20020ac85a93000000b003e382c4db44mr6147901qtc.52.1680724911154;
        Wed, 05 Apr 2023 13:01:51 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id f8-20020a05620a280800b00749fa9e12e9sm4669594qkp.124.2023.04.05.13.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 13:01:50 -0700 (PDT)
Date:   Wed, 5 Apr 2023 16:01:50 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: global_reclaim() and code documentation (was: Re: [PATCH v3 3/3] mm:
 vmscan: ignore non-LRU-based reclaim in memcg reclaim
Message-ID: <20230405200150.GA35884@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 12:30:11AM -0700, Yosry Ahmed wrote:
> On Fri, Mar 31, 2023 at 12:25 AM Yu Zhao <yuzhao@google.com> wrote:
> > On Fri, Mar 31, 2023 at 1:08 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > ...
> >
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index a3e38851b34ac..bf9d8e175e92a 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -533,7 +533,35 @@ EXPORT_SYMBOL(mm_account_reclaimed_pages);
> > >  static void flush_reclaim_state(struct scan_control *sc,
> > >                                 struct reclaim_state *rs)
> > >  {
> > > -       if (rs) {
> > > +       /*
> > > +        * Currently, reclaim_state->reclaimed includes three types of pages
> > > +        * freed outside of vmscan:
> > > +        * (1) Slab pages.
> > > +        * (2) Clean file pages from pruned inodes.
> > > +        * (3) XFS freed buffer pages.
> > > +        *
> > > +        * For all of these cases, we have no way of finding out whether these
> > > +        * pages were related to the memcg under reclaim. For example, a freed
> > > +        * slab page could have had only a single object charged to the memcg
> > > +        * under reclaim. Also, populated inodes are not on shrinker LRUs
> > > +        * anymore except on highmem systems.
> > > +        *
> > > +        * Instead of over-reporting the reclaimed pages in a memcg reclaim,
> > > +        * only count such pages in system-wide reclaim. This prevents
> > > +        * unnecessary retries during memcg charging and false positive from
> > > +        * proactive reclaim (memory.reclaim).
> >
> > What happens when writing to the root memory.reclaim?
> >
> > > +        *
> > > +        * For uncommon cases were the freed pages were actually significantly
> > > +        * charged to the memcg under reclaim, and we end up under-reporting, it
> > > +        * should be fine. The freed pages will be uncharged anyway, even if
> > > +        * they are not reported properly, and we will be able to make forward
> > > +        * progress in charging (which is usually in a retry loop).
> > > +        *
> > > +        * We can go one step further, and report the uncharged objcg pages in
> > > +        * memcg reclaim, to make reporting more accurate and reduce
> > > +        * under-reporting, but it's probably not worth the complexity for now.
> > > +        */
> > > +       if (rs && !cgroup_reclaim(sc)) {
> >
> > To answer the question above, global_reclaim() would be preferred.
> 
> Great point, global_reclaim() is fairly recent. I didn't see it
> before. Thanks for pointing it out. I will change it for v4 -- will
> wait for more feedback before respinning.

I didn't realize it came back, I deleted it a while ago:

commit b5ead35e7e1d3434ce436dfcb2af32820ce54589
Author: Johannes Weiner <hannes@cmpxchg.org>
Date:   Sat Nov 30 17:55:40 2019 -0800

    mm: vmscan: naming fixes: global_reclaim() and sane_reclaim()
    
    Seven years after introducing the global_reclaim() function, I still have
    to double take when reading a callsite.  I don't know how others do it,
    this is a terrible name.
    
    Invert the meaning and rename it to cgroup_reclaim().

Could you shed some light on why it was brought back? It's not clear
to me from the changelog in a579086c99ed70cc4bfc104348dbe3dd8f2787e6.

We also now have this:

static bool cgroup_reclaim(struct scan_control *sc)
{
        return sc->target_mem_cgroup;
}

static bool global_reclaim(struct scan_control *sc)
{
        return !sc->target_mem_cgroup || mem_cgroup_is_root(sc->target_mem_cgroup);
}

The name suggests it's the same thing twice, with opposite
polarity. But of course they're subtly different, and not documented.

When do you use which?
