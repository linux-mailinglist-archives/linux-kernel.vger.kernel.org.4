Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F71716555
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjE3O5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbjE3O5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:57:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9E0F9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:57:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9558A631CC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C67C48C32;
        Tue, 30 May 2023 14:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685458285;
        bh=mjNuHuokKNWBuOoaQbbCKxiLOzcnvF4WFIhM9Mj30Zw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H9ActstRZ5uclx9XncAE2ll4p9fe24ujjTitbE+YqHeYQ1+Kf51dh+5iOK/5iywA6
         WsCKlhZ2qKFDR8/kN9dc3KurVcT4jYXsiLsoxfR3ilRFIL9Mh1KIin3Ce30kRZXUYm
         0cCcs5SN1wixKYzt3Fm5Re7YaFIj7x2W45aY/gft6Z07T1x1IV+jvIsYiJJiBioHl2
         J2FNeOcTMOn5oPyAQXP2AiBbF3NGqmSvMqJ18qX75E8Qan3FMOO+dlwfcnQi+MbTMk
         PUcRzSKzVeJv2INRxZI/Pb4YFJ7RV1vkF2Rwk/1dDeoEdXkbyi7f45XGW+YyNqxKMS
         mzXEwj2DNU+XA==
Date:   Tue, 30 May 2023 07:51:23 -0700
From:   Chris Li <chrisl@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        yosryahmed@google.com, kernel-team@fb.com
Subject: Re: [PATCH] mm: zswap: shrink until can accept
Message-ID: <ZHYNaxgcKs7PSp9I@google.com>
References: <20230524065051.6328-1-cerasuolodomenico@gmail.com>
 <ZHE7KWId1fvXLpUy@google.com>
 <CA+CLi1iC35exSaKaCmVmTWtna=9xBKHSyGNGmHFo=OqiSECGoA@mail.gmail.com>
 <ZHUSfg+z3wcaIhAT@google.com>
 <20230530041341.GB84971@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230530041341.GB84971@cmpxchg.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 12:13:41AM -0400, Johannes Weiner wrote:
> On Mon, May 29, 2023 at 02:00:46PM -0700, Chris Li wrote:
> > On Sun, May 28, 2023 at 10:53:49AM +0200, Domenico Cerasuolo wrote:
> > > On Sat, May 27, 2023 at 1:05 AM Chris Li <chrisl@kernel.org> wrote:
> > > >
> > > > On Wed, May 24, 2023 at 08:50:51AM +0200, Domenico Cerasuolo wrote:
> > > > > This update addresses an issue with the zswap reclaim mechanism, which
> > > > > hinders the efficient offloading of cold pages to disk, thereby
> > > > > compromising the preservation of the LRU order and consequently
> > > > > diminishing, if not inverting, its performance benefits.
> > > > >
> > > > > The functioning of the zswap shrink worker was found to be inadequate,
> > > > > as shown by basic benchmark test. For the test, a kernel build was
> > > > > utilized as a reference, with its memory confined to 1G via a cgroup and
> > > > > a 5G swap file provided. The results are presented below, these are
> > > > > averages of three runs without the use of zswap:
> > > > >
> > > > > real 46m26s
> > > > > user 35m4s
> > > > > sys 7m37s
> > > > >
> > > > > With zswap (zbud) enabled and max_pool_percent set to 1 (in a 32G
> > > > > system), the results changed to:
> > > > >
> > > > > real 56m4s
> > > > > user 35m13s
> > > > > sys 8m43s
> > > > >
> > > > > written_back_pages: 18
> > > > > reject_reclaim_fail: 0
> > > > > pool_limit_hit:1478
> > > > >
> > > > > Besides the evident regression, one thing to notice from this data is
> > > > > the extremely low number of written_back_pages and pool_limit_hit.
> > > > >
> > > > > The pool_limit_hit counter, which is increased in zswap_frontswap_store
> > > > > when zswap is completely full, doesn't account for a particular
> > > > > scenario: once zswap hits his limit, zswap_pool_reached_full is set to
> > > > > true; with this flag on, zswap_frontswap_store rejects pages if zswap is
> > > > > still above the acceptance threshold. Once we include the rejections due
> > > > > to zswap_pool_reached_full && !zswap_can_accept(), the number goes from
> > > > > 1478 to a significant 21578266.
> > > > >
> > > > > Zswap is stuck in an undesirable state where it rejects pages because
> > > > > it's above the acceptance threshold, yet fails to attempt memory
> > > > > reclaimation. This happens because the shrink work is only queued when
> > > > > zswap_frontswap_store detects that it's full and the work itself only
> > > > > reclaims one page per run.
> > > > >
> > > > > This state results in hot pages getting written directly to disk,
> > > > > while cold ones remain memory, waiting only to be invalidated. The LRU
> > > > > order is completely broken and zswap ends up being just an overhead
> > > > > without providing any benefits.
> > > > >
> > > > > This commit applies 2 changes: a) the shrink worker is set to reclaim
> > > > > pages until the acceptance threshold is met and b) the task is also
> > > > > enqueued when zswap is not full but still above the threshold.
> > > > >
> > > > > Testing this suggested update showed much better numbers:
> > > > >
> > > > > real 36m37s
> > > > > user 35m8s
> > > > > sys 9m32s
> > > > >
> > > > > written_back_pages: 10459423
> > > > > reject_reclaim_fail: 12896
> > > > > pool_limit_hit: 75653
> > > > >
> > > > > Fixes: 45190f01dd40 ("mm/zswap.c: add allocation hysteresis if pool limit is hit")
> > > > > Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > > > > ---
> > > > >  mm/zswap.c | 10 +++++++---
> > > > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > > index 59da2a415fbb..2ee0775d8213 100644
> > > > > --- a/mm/zswap.c
> > > > > +++ b/mm/zswap.c
> > > > > @@ -587,9 +587,13 @@ static void shrink_worker(struct work_struct *w)
> > > > >  {
> > > > >       struct zswap_pool *pool = container_of(w, typeof(*pool),
> > > > >                                               shrink_work);
> > > > > +     int ret;
> > > > Very minor nit pick, you can move the declare inside the do
> > > > statement where it get used.
> > > >
> > > > >
> > > > > -     if (zpool_shrink(pool->zpool, 1, NULL))
> > > > > -             zswap_reject_reclaim_fail++;
> > > > > +     do {
> > > > > +             ret = zpool_shrink(pool->zpool, 1, NULL);
> > > > > +             if (ret)
> > > > > +                     zswap_reject_reclaim_fail++;
> > > > > +     } while (!zswap_can_accept() && ret != -EINVAL);
> > > >
> > > > As others point out, this while loop can be problematic.
> > > 
> > > Do you have some specific concern that's not been already addressed following
> > > other reviewers' suggestions?
> > 
> > Mostly as it is, the outer loop seems the wrong
> > place to do the retry because of lacking the error
> > context and properly continuing the iteration.
> > 
> > 
> > > 
> > > >
> > > > Have you find out what was the common reason causing the
> > > > reclaim fail? Inside the shrink function there is a while
> > > > loop that would be the place to perform try harder conditions.
> > > > For example, if all the page in the LRU are already try once
> > > > there's no reason to keep on calling the shrink function.
> > > > The outer loop actually doesn't have this kind of visibilities.
> > > >
> > > 
> > > The most common cause I saw during testing was concurrent operations
> > > on the swap entry, if an entry is being loaded/invalidated at the same time
> > > as the zswap writeback, then errors will be returned. This scenario doesn't
> > > seem harmful at all because the failure doesn't indicate that memory
> > > cannot be allocated, just that that particular page should not be written back.
> > > 
> > > As far as I understood the voiced concerns, the problem could arise if the
> > > writeback fails due to an impossibility to allocate memory, that could indicate
> > > that the system is in extremely high memory pressure and this loop could
> > > aggravate the situation by adding more contention on the already scarce
> > > available memory.
> > 
> > It seems to me the inner loop should continue if page writeback
> > fails due to loaded/invalidate, abort due to memory pressure.
> > 
> > The key difference is that one is transient while others might
> > be more permanent 
> > 
> > You definitely don't want to retry if it is already ENOMEM. 
> 
> This is actually a separate problem that Domenico was preparing a
> patch for. Writeback is a reclaim operation, so it should have access
> to the memory reserves (PF_MEMALLOC). Persistent -ENOMEM shouldn't
> exist. It actually used have reserve access when writeback happened
> directly from inside the store (reclaim -> swapout path). When
> writeback was moved out to the async worker, it lost reserve access as
> an unintended side effect. This should be fixed, so we don't OOM while
> we try to free memory.
Thanks for pointing out -ENOMEM shouldn't be persistent.
Points taken.

The original point of not retrying the persistent error
still holds.

> 
> Should it be fixed before merging this patch? I don't think the
> ordering matters. Right now the -ENOMEM case invokes OOM, so it isn't
> really persistent either. Retrying a few times in that case certainly
> doesn't seem to make things worse.

If you already know the error is persistent, retrying is wasting
CPU. It can pertancial hold locks during the retry, which can
slow someone else down.

> > > As I was writing to Yosry, the differentiation would be a great improvement
> > > here, I just have a patch set in the queue that moves the inner reclaim loop
> > > from the zpool driver up to zswap. With that, updating the error handling
> > > would be more convenient as it would be done in one place instead of three.i
> > 
> > This has tricky complications as well. The current shrink interface
> > doesn't support continuing from the previous error position. If you want
> > to avoid a repeat attempt if the page has a writeback error, you kinda
> > of need a way to skip that page.
> 
> A page that fails to reclaim is put back to the tail of the LRU, so
> for all intents and purposes it will be skipped. In the rare and

Do you mean the page is treated as hot again?

Wouldn't that be undesirable from the app's point of view?
> extreme case where it's the only page left on the list, I again don't
> see how retrying a few times will make the situation worse.
> 
> In practice, IMO there is little upside in trying to be more
> discerning about the error codes. Simple seems better here.

Just trying to think about what should be the precise loop termination
condition here.

I still feel blindly trying a few times is a very imprecise condition.

Chris
