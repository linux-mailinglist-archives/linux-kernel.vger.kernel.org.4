Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBDB71546F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 06:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjE3ENt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 00:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjE3ENp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 00:13:45 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24171E3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 21:13:43 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-75afeacb5e4so482434285a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 21:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685420022; x=1688012022;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tyqnzUTxnxhmPWkuNt0nbJNVYrVvyezEPu908a9ooAA=;
        b=dZ4FfHCwFRr7DI27ClBfnQdPFEsTDHI+rwycrkhaQuvNIrK/ufq5mtV8lLvGo4+51e
         mwrksdnoBLNzXDotj0TUZitCFik4SqmsHgeWjuIYQRgBG3qbAoy3VsUjTB71S5MA2zT1
         O+GVgbufiGNaYWMOAaSWx0LArTf4wnfdhO5sv0aiW3qycHIIlBnUSpInlr6ZZQx1Sn17
         JdgU9pU0qdwdPTh+66069+lQ4uaTQFyVW4w/p9+UWfSzrzLy6A9iil8wODyi1KO0xUPQ
         IAiqwGzaJU5PhNQj9+7M8FB9gi3CNW1ALTMYx/xDR4pvTQB3oj/+vUbVi8rlwNb5Hust
         oPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685420022; x=1688012022;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tyqnzUTxnxhmPWkuNt0nbJNVYrVvyezEPu908a9ooAA=;
        b=JKYxVgsuBzpqoV3vNZujKp4hlpdITxQtuPcN7J2+OMHhZAgXHnPJ9iGftsawI1kMVQ
         EDoFr1tgaKLazTN3+wEWN1OQBit8tcvbrbmwMiktuy0K14GZmFS1TKMjMxSQZOIG7oPR
         uHcZH0dzVzpcFkkhPMdZpktcNibfeVeuJczpnHu2FcYKDwtxNO3rkCnTAcLYZRWR7mMB
         oMpc/n4W1IfqZdF8rK3s3NObRrz2HybSP1ukd/qKKJkhTZSDz3OIvukW5dff63HArhNy
         DCv6ShQHwgCGfmyXJoYFuS219RzWDnIlyq2zv4QDKUTGUPhu5ZqMhlm/sNdoCRGvE/dp
         OHQQ==
X-Gm-Message-State: AC+VfDzOI58HzGuqvsQEekrcgyOGcGJgUbd8HTMBUdbTE32ulo+lh44w
        JQ09GZcJY8NghYxkz8tbPW1YAA==
X-Google-Smtp-Source: ACHHUZ7MnNt5DC0QVMW5xmcyjoLYktC8rt49PNDlcyewiQzOPUaAULN8qdij9vG/bTLHQB2BiGLTAw==
X-Received: by 2002:a05:620a:916:b0:75b:23a1:3633 with SMTP id v22-20020a05620a091600b0075b23a13633mr824483qkv.68.1685420022290;
        Mon, 29 May 2023 21:13:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:8bb6])
        by smtp.gmail.com with ESMTPSA id g11-20020a37e20b000000b0075945c93107sm3804709qki.102.2023.05.29.21.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 21:13:41 -0700 (PDT)
Date:   Tue, 30 May 2023 00:13:41 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Li <chrisl@kernel.org>
Cc:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        yosryahmed@google.com, kernel-team@fb.com
Subject: Re: [PATCH] mm: zswap: shrink until can accept
Message-ID: <20230530041341.GB84971@cmpxchg.org>
References: <20230524065051.6328-1-cerasuolodomenico@gmail.com>
 <ZHE7KWId1fvXLpUy@google.com>
 <CA+CLi1iC35exSaKaCmVmTWtna=9xBKHSyGNGmHFo=OqiSECGoA@mail.gmail.com>
 <ZHUSfg+z3wcaIhAT@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHUSfg+z3wcaIhAT@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 02:00:46PM -0700, Chris Li wrote:
> On Sun, May 28, 2023 at 10:53:49AM +0200, Domenico Cerasuolo wrote:
> > On Sat, May 27, 2023 at 1:05 AM Chris Li <chrisl@kernel.org> wrote:
> > >
> > > On Wed, May 24, 2023 at 08:50:51AM +0200, Domenico Cerasuolo wrote:
> > > > This update addresses an issue with the zswap reclaim mechanism, which
> > > > hinders the efficient offloading of cold pages to disk, thereby
> > > > compromising the preservation of the LRU order and consequently
> > > > diminishing, if not inverting, its performance benefits.
> > > >
> > > > The functioning of the zswap shrink worker was found to be inadequate,
> > > > as shown by basic benchmark test. For the test, a kernel build was
> > > > utilized as a reference, with its memory confined to 1G via a cgroup and
> > > > a 5G swap file provided. The results are presented below, these are
> > > > averages of three runs without the use of zswap:
> > > >
> > > > real 46m26s
> > > > user 35m4s
> > > > sys 7m37s
> > > >
> > > > With zswap (zbud) enabled and max_pool_percent set to 1 (in a 32G
> > > > system), the results changed to:
> > > >
> > > > real 56m4s
> > > > user 35m13s
> > > > sys 8m43s
> > > >
> > > > written_back_pages: 18
> > > > reject_reclaim_fail: 0
> > > > pool_limit_hit:1478
> > > >
> > > > Besides the evident regression, one thing to notice from this data is
> > > > the extremely low number of written_back_pages and pool_limit_hit.
> > > >
> > > > The pool_limit_hit counter, which is increased in zswap_frontswap_store
> > > > when zswap is completely full, doesn't account for a particular
> > > > scenario: once zswap hits his limit, zswap_pool_reached_full is set to
> > > > true; with this flag on, zswap_frontswap_store rejects pages if zswap is
> > > > still above the acceptance threshold. Once we include the rejections due
> > > > to zswap_pool_reached_full && !zswap_can_accept(), the number goes from
> > > > 1478 to a significant 21578266.
> > > >
> > > > Zswap is stuck in an undesirable state where it rejects pages because
> > > > it's above the acceptance threshold, yet fails to attempt memory
> > > > reclaimation. This happens because the shrink work is only queued when
> > > > zswap_frontswap_store detects that it's full and the work itself only
> > > > reclaims one page per run.
> > > >
> > > > This state results in hot pages getting written directly to disk,
> > > > while cold ones remain memory, waiting only to be invalidated. The LRU
> > > > order is completely broken and zswap ends up being just an overhead
> > > > without providing any benefits.
> > > >
> > > > This commit applies 2 changes: a) the shrink worker is set to reclaim
> > > > pages until the acceptance threshold is met and b) the task is also
> > > > enqueued when zswap is not full but still above the threshold.
> > > >
> > > > Testing this suggested update showed much better numbers:
> > > >
> > > > real 36m37s
> > > > user 35m8s
> > > > sys 9m32s
> > > >
> > > > written_back_pages: 10459423
> > > > reject_reclaim_fail: 12896
> > > > pool_limit_hit: 75653
> > > >
> > > > Fixes: 45190f01dd40 ("mm/zswap.c: add allocation hysteresis if pool limit is hit")
> > > > Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > > > ---
> > > >  mm/zswap.c | 10 +++++++---
> > > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > index 59da2a415fbb..2ee0775d8213 100644
> > > > --- a/mm/zswap.c
> > > > +++ b/mm/zswap.c
> > > > @@ -587,9 +587,13 @@ static void shrink_worker(struct work_struct *w)
> > > >  {
> > > >       struct zswap_pool *pool = container_of(w, typeof(*pool),
> > > >                                               shrink_work);
> > > > +     int ret;
> > > Very minor nit pick, you can move the declare inside the do
> > > statement where it get used.
> > >
> > > >
> > > > -     if (zpool_shrink(pool->zpool, 1, NULL))
> > > > -             zswap_reject_reclaim_fail++;
> > > > +     do {
> > > > +             ret = zpool_shrink(pool->zpool, 1, NULL);
> > > > +             if (ret)
> > > > +                     zswap_reject_reclaim_fail++;
> > > > +     } while (!zswap_can_accept() && ret != -EINVAL);
> > >
> > > As others point out, this while loop can be problematic.
> > 
> > Do you have some specific concern that's not been already addressed following
> > other reviewers' suggestions?
> 
> Mostly as it is, the outer loop seems the wrong
> place to do the retry because of lacking the error
> context and properly continuing the iteration.
> 
> 
> > 
> > >
> > > Have you find out what was the common reason causing the
> > > reclaim fail? Inside the shrink function there is a while
> > > loop that would be the place to perform try harder conditions.
> > > For example, if all the page in the LRU are already try once
> > > there's no reason to keep on calling the shrink function.
> > > The outer loop actually doesn't have this kind of visibilities.
> > >
> > 
> > The most common cause I saw during testing was concurrent operations
> > on the swap entry, if an entry is being loaded/invalidated at the same time
> > as the zswap writeback, then errors will be returned. This scenario doesn't
> > seem harmful at all because the failure doesn't indicate that memory
> > cannot be allocated, just that that particular page should not be written back.
> > 
> > As far as I understood the voiced concerns, the problem could arise if the
> > writeback fails due to an impossibility to allocate memory, that could indicate
> > that the system is in extremely high memory pressure and this loop could
> > aggravate the situation by adding more contention on the already scarce
> > available memory.
> 
> It seems to me the inner loop should continue if page writeback
> fails due to loaded/invalidate, abort due to memory pressure.
> 
> The key difference is that one is transient while others might
> be more permanent 
> 
> You definitely don't want to retry if it is already ENOMEM. 

This is actually a separate problem that Domenico was preparing a
patch for. Writeback is a reclaim operation, so it should have access
to the memory reserves (PF_MEMALLOC). Persistent -ENOMEM shouldn't
exist. It actually used have reserve access when writeback happened
directly from inside the store (reclaim -> swapout path). When
writeback was moved out to the async worker, it lost reserve access as
an unintended side effect. This should be fixed, so we don't OOM while
we try to free memory.

Should it be fixed before merging this patch? I don't think the
ordering matters. Right now the -ENOMEM case invokes OOM, so it isn't
really persistent either. Retrying a few times in that case certainly
doesn't seem to make things worse.

> > As I was writing to Yosry, the differentiation would be a great improvement
> > here, I just have a patch set in the queue that moves the inner reclaim loop
> > from the zpool driver up to zswap. With that, updating the error handling
> > would be more convenient as it would be done in one place instead of three.i
> 
> This has tricky complications as well. The current shrink interface
> doesn't support continuing from the previous error position. If you want
> to avoid a repeat attempt if the page has a writeback error, you kinda
> of need a way to skip that page.

A page that fails to reclaim is put back to the tail of the LRU, so
for all intents and purposes it will be skipped. In the rare and
extreme case where it's the only page left on the list, I again don't
see how retrying a few times will make the situation worse.

In practice, IMO there is little upside in trying to be more
discerning about the error codes. Simple seems better here.
