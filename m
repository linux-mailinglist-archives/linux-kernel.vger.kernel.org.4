Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1645FE32A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiJMUQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJMUQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:16:46 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD0733358;
        Thu, 13 Oct 2022 13:16:44 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c24so2842030plo.3;
        Thu, 13 Oct 2022 13:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gOTkI6DiG9zNlMVvwhJN0xPlCDiBJf3npR9m1obgkeo=;
        b=Lsxl/tLwGNZv9z+oGntC+5LE/pkahStDM6pBWlZuCiAaTuym7A3vMYZz82HZHCOOdy
         303PbGf9qgLhPz6gYeVjhsODFOQBDTKwPZ4o384PcBLrNJD6T/386rk3h5oOQ3l9kCkt
         bn5vpwBS4VoLHflw8Dlu0hy0elVT6i/Db9dfVa3kVwAAyJh+4EXsDSvnBGsrLUoHNH0v
         4hIFnZeD7QxnfQL/Cq5pkIBG8QmBlIBemKRie1OAuHDVvYcAGJVhaeiTdnDf+f+ze2IR
         +dDha5Qt6qamaohKfhX1pCPK/JSTypuHSlgw7FuvY6eWjhccY0d6rzTFRje4k0y/rPMR
         L80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gOTkI6DiG9zNlMVvwhJN0xPlCDiBJf3npR9m1obgkeo=;
        b=7EhN9s04s2CSA4uyiQARhChAEYKNGsrjzlCb7Z8JBcvtBTOiJDn74ufgWwW9SUz6P/
         7kLy0eoqbT9aDFPciSvf3hGgnTGiq0tCPDF/0zruhrZaMpoxMiXSMLxYgbH7MK6pZb3d
         ad+FMyE+htNVhNX12sjUwG5j+Nq1rA4W5Ribm6nFC027eqkNucRuU0avTdGfqacLBtuJ
         ngtAx9xIdYS8xyFuCQKyBHFffQ1hKBlJjsSCP5FAbR3zucINgfbXY/j9xbSAJ3vf+Fx2
         wmQCdSBgT5xN8NXZVDXAN56YxgTUSSoibM5YKj/x6f2dNIaJ2SqqxyIeH40cQbe/1DZq
         Iczg==
X-Gm-Message-State: ACrzQf1QHqh+nnKS5FHwttpmlrJJcOkeuwL5LjJQBgG2PEZmGxiiSoD9
        r4SL6v7Y95jXvteJCOhde86x15BbtZxv5I3615w=
X-Google-Smtp-Source: AMsMyM6oJD/yMaxb7cro3W7Zw+cQjBDGxa+i3q11ifg/KVLAfGAnzcBpn57njRrsLsdEm4UMGMYmjk8ypjuUqiKsQ4M=
X-Received: by 2002:a17:903:41cf:b0:183:5a22:c63e with SMTP id
 u15-20020a17090341cf00b001835a22c63emr1364803ple.61.1665692203956; Thu, 13
 Oct 2022 13:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20221005180341.1738796-1-shy828301@gmail.com> <20221005180341.1738796-3-shy828301@gmail.com>
 <20221013123830.opbulq4qad56kuev@techsingularity.net>
In-Reply-To: <20221013123830.opbulq4qad56kuev@techsingularity.net>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 13 Oct 2022 13:16:31 -0700
Message-ID: <CAHbLzkpc+CAfsYe6gXjh=-3MxMH_aWhPMYhic7ddFZgWttOhng@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm: mempool: introduce page bulk allocator
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 5:38 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Wed, Oct 05, 2022 at 11:03:39AM -0700, Yang Shi wrote:
> > Since v5.13 the page bulk allocator was introduced to allocate order-0
> > pages in bulk.  There are a few mempool allocator callers which does
> > order-0 page allocation in a loop, for example, dm-crypt, f2fs compress,
> > etc.  A mempool page bulk allocator seems useful.  So introduce the
> > mempool page bulk allocator.
> >
> > It introduces the below APIs:
> >   - mempool_init_pages_bulk()
> >   - mempool_create_pages_bulk()
> > They initialize the mempool for page bulk allocator.  The pool is filled
> > by alloc_page() in a loop.
> >
> >   - mempool_alloc_pages_bulk_list()
> >   - mempool_alloc_pages_bulk_array()
> > They do bulk allocation from mempool.
> > They do the below conceptually:
> >   1. Call bulk page allocator
> >   2. If the allocation is fulfilled then return otherwise try to
> >      allocate the remaining pages from the mempool
> >   3. If it is fulfilled then return otherwise retry from #1 with sleepable
> >      gfp
> >   4. If it is still failed, sleep for a while to wait for the mempool is
> >      refilled, then retry from #1
> > The populated pages will stay on the list or array until the callers
> > consume them or free them.
> > Since mempool allocator is guaranteed to success in the sleepable context,
> > so the two APIs return true for success or false for fail.  It is the
> > caller's responsibility to handle failure case (partial allocation), just
> > like the page bulk allocator.
> >
> > The mempool typically is an object agnostic allocator, but bulk allocation
> > is only supported by pages, so the mempool bulk allocator is for page
> > allocation only as well.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
>
> Overall, I think it's an ok approach and certainly a good use case for
> the bulk allocator.
>
> The main concern that I have is that the dm-crypt use case doesn't really
> want to use lists as such and it's just a means for collecting pages to pass
> to bio_add_page(). bio_add_page() is working with arrays but you cannot
> use that array directly as any change to how that array is populated will
> then explode. Unfortunately, what you have is adding pages to a list to
> take them off the list and put them in an array and that is inefficient.

Yeah, I didn't think of a better way to pass the pages to dm-crypt.

>
> How about this
>
> 1. Add a callback to __alloc_pages_bulk() that takes a page as a
>    parameter like bulk_add_page() or whatever.
>
> 2. For page_list == NULL && page_array == NULL, the callback is used
>
> 3. Add alloc_pages_bulk_cb() that passes in the name of a callback
>    function
>
> 4. In the dm-crypt case, use the callback to pass the page to bio_add_page
>    for the new page allocated.

Thank you so much for the suggestion. But I have a hard time
understanding how these work together. Do you mean call bio_add_page()
in the callback? But bio_add_page() needs other parameters. Or I
misunderstood you?

>
> It's not free because there will be an additional function call for every
> page bulk allocated but I suspect that's cheaper than adding a pile of
> pages to a list just to take them off again. It also avoids adding a user
> for the bulk allocator list interface that does not even want a list.
>
> It might mean that there is additional cleanup work for __alloc_pages_bulk
> to abstract away whether a list, array or cb is used but nothing
> impossible.
>
> --
> Mel Gorman
> SUSE Labs
