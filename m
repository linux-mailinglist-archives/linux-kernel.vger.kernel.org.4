Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C277E7150D1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 23:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjE2VA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 17:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjE2VAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 17:00:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A6CC7
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 14:00:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F126B62085
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 21:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBF3C433D2;
        Mon, 29 May 2023 21:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685394050;
        bh=JOi/LKb5AuKdBACZSmeAW1OiDBvkw/aUjMpocvmao9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZYMUfGRuMcObjKM/F9pvw268GHIJUlZ1UDvmACODilEN4kUjXU43khnzmpUrVx1xe
         c7vT1B8pljcYtS5fz5a7Cq9gEA1obMZV/Cr6JDxfKhaCCje3FpOED9HRjraWZ26eDc
         5F3eaedx+ce7o/3n0JvmLOBr4FNtNNMy9pP6dkiqGESK1b+jTwyRCkUu0+DRbQPaBs
         5rbFpsm6qiPPVEtaOfgqj6ze+7vQvHRWDuanVu7DC1h1O/7N2U90DS+gI1qkNU4Ub1
         +RbE6yEim6ktvigiW1vSJa08qDcMsivzcUt+w89zT8w4czqzDBketDZGg9OES3gaa/
         1ntAwjKmMZyrQ==
Date:   Mon, 29 May 2023 14:00:46 -0700
From:   Chris Li <chrisl@kernel.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        yosryahmed@google.com, hannes@cmpxchg.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: zswap: shrink until can accept
Message-ID: <ZHUSfg+z3wcaIhAT@google.com>
References: <20230524065051.6328-1-cerasuolodomenico@gmail.com>
 <ZHE7KWId1fvXLpUy@google.com>
 <CA+CLi1iC35exSaKaCmVmTWtna=9xBKHSyGNGmHFo=OqiSECGoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CLi1iC35exSaKaCmVmTWtna=9xBKHSyGNGmHFo=OqiSECGoA@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 10:53:49AM +0200, Domenico Cerasuolo wrote:
> On Sat, May 27, 2023 at 1:05 AM Chris Li <chrisl@kernel.org> wrote:
> >
> > On Wed, May 24, 2023 at 08:50:51AM +0200, Domenico Cerasuolo wrote:
> > > This update addresses an issue with the zswap reclaim mechanism, which
> > > hinders the efficient offloading of cold pages to disk, thereby
> > > compromising the preservation of the LRU order and consequently
> > > diminishing, if not inverting, its performance benefits.
> > >
> > > The functioning of the zswap shrink worker was found to be inadequate,
> > > as shown by basic benchmark test. For the test, a kernel build was
> > > utilized as a reference, with its memory confined to 1G via a cgroup and
> > > a 5G swap file provided. The results are presented below, these are
> > > averages of three runs without the use of zswap:
> > >
> > > real 46m26s
> > > user 35m4s
> > > sys 7m37s
> > >
> > > With zswap (zbud) enabled and max_pool_percent set to 1 (in a 32G
> > > system), the results changed to:
> > >
> > > real 56m4s
> > > user 35m13s
> > > sys 8m43s
> > >
> > > written_back_pages: 18
> > > reject_reclaim_fail: 0
> > > pool_limit_hit:1478
> > >
> > > Besides the evident regression, one thing to notice from this data is
> > > the extremely low number of written_back_pages and pool_limit_hit.
> > >
> > > The pool_limit_hit counter, which is increased in zswap_frontswap_store
> > > when zswap is completely full, doesn't account for a particular
> > > scenario: once zswap hits his limit, zswap_pool_reached_full is set to
> > > true; with this flag on, zswap_frontswap_store rejects pages if zswap is
> > > still above the acceptance threshold. Once we include the rejections due
> > > to zswap_pool_reached_full && !zswap_can_accept(), the number goes from
> > > 1478 to a significant 21578266.
> > >
> > > Zswap is stuck in an undesirable state where it rejects pages because
> > > it's above the acceptance threshold, yet fails to attempt memory
> > > reclaimation. This happens because the shrink work is only queued when
> > > zswap_frontswap_store detects that it's full and the work itself only
> > > reclaims one page per run.
> > >
> > > This state results in hot pages getting written directly to disk,
> > > while cold ones remain memory, waiting only to be invalidated. The LRU
> > > order is completely broken and zswap ends up being just an overhead
> > > without providing any benefits.
> > >
> > > This commit applies 2 changes: a) the shrink worker is set to reclaim
> > > pages until the acceptance threshold is met and b) the task is also
> > > enqueued when zswap is not full but still above the threshold.
> > >
> > > Testing this suggested update showed much better numbers:
> > >
> > > real 36m37s
> > > user 35m8s
> > > sys 9m32s
> > >
> > > written_back_pages: 10459423
> > > reject_reclaim_fail: 12896
> > > pool_limit_hit: 75653
> > >
> > > Fixes: 45190f01dd40 ("mm/zswap.c: add allocation hysteresis if pool limit is hit")
> > > Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > > ---
> > >  mm/zswap.c | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index 59da2a415fbb..2ee0775d8213 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -587,9 +587,13 @@ static void shrink_worker(struct work_struct *w)
> > >  {
> > >       struct zswap_pool *pool = container_of(w, typeof(*pool),
> > >                                               shrink_work);
> > > +     int ret;
> > Very minor nit pick, you can move the declare inside the do
> > statement where it get used.
> >
> > >
> > > -     if (zpool_shrink(pool->zpool, 1, NULL))
> > > -             zswap_reject_reclaim_fail++;
> > > +     do {
> > > +             ret = zpool_shrink(pool->zpool, 1, NULL);
> > > +             if (ret)
> > > +                     zswap_reject_reclaim_fail++;
> > > +     } while (!zswap_can_accept() && ret != -EINVAL);
> >
> > As others point out, this while loop can be problematic.
> 
> Do you have some specific concern that's not been already addressed following
> other reviewers' suggestions?

Mostly as it is, the outer loop seems the wrong
place to do the retry because of lacking the error
context and properly continuing the iteration.


> 
> >
> > Have you find out what was the common reason causing the
> > reclaim fail? Inside the shrink function there is a while
> > loop that would be the place to perform try harder conditions.
> > For example, if all the page in the LRU are already try once
> > there's no reason to keep on calling the shrink function.
> > The outer loop actually doesn't have this kind of visibilities.
> >
> 
> The most common cause I saw during testing was concurrent operations
> on the swap entry, if an entry is being loaded/invalidated at the same time
> as the zswap writeback, then errors will be returned. This scenario doesn't
> seem harmful at all because the failure doesn't indicate that memory
> cannot be allocated, just that that particular page should not be written back.
> 
> As far as I understood the voiced concerns, the problem could arise if the
> writeback fails due to an impossibility to allocate memory, that could indicate
> that the system is in extremely high memory pressure and this loop could
> aggravate the situation by adding more contention on the already scarce
> available memory.

It seems to me the inner loop should continue if page writeback
fails due to loaded/invalidate, abort due to memory pressure.

The key difference is that one is transient while others might
be more permanent 

You definitely don't want to retry if it is already ENOMEM. 
> 
> Since both these cases are treated equally with the retries limit, we're
> adopting a conservative approach in considering non-harmful errors as if
> they were harmful. This could certainly be improved, but I don't see it as an
> issue because a differentiation of the errors would actually make the loop run
> longer than it would without the differentiation.

We don't want to run longer if error is persistent.

> 
> As I was writing to Yosry, the differentiation would be a great improvement
> here, I just have a patch set in the queue that moves the inner reclaim loop
> from the zpool driver up to zswap. With that, updating the error handling
> would be more convenient as it would be done in one place instead of three.i

This has tricky complications as well. The current shrink interface
doesn't support continuing from the previous error position. If you want
to avoid a repeat attempt if the page has a writeback error, you kinda
of need a way to skip that page.

Chris
 
> 
> >
> > Chris
> >
> > >       zswap_pool_put(pool);
> > >  }
> > >
> > > @@ -1188,7 +1192,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
> > >       if (zswap_pool_reached_full) {
> > >              if (!zswap_can_accept()) {
> > >                       ret = -ENOMEM;
> > > -                     goto reject;
> > > +                     goto shrink;
> > >               } else
> > >                       zswap_pool_reached_full = false;
> > >       }
> > > --
> > > 2.34.1
> > >
