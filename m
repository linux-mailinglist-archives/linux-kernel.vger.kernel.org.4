Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5FF716C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 20:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjE3STH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 14:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjE3SSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 14:18:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C266FA7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 11:18:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56BE160E92
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 18:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637D9C4339C;
        Tue, 30 May 2023 18:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685470733;
        bh=GSoJuOKRdY+uRAsGoUp8M6lD7U0u8mQi49JYAbktU9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HbsjnUKjcjDwjDBgQ5g4mt2ee+gpdY2yXecyHxE/5hujI30cFSqea0ycWzHcL81rT
         Mfr3M+KeDBwyVG8wGbmB3kBb3lzVPSTnZXtLdj2NQG+nbccDO2IXHWGlQIBkUOB9au
         oAW2PbOv2XKJzGjYmq07qE4hKm4OSZzNn7qitSAtF3cZ3aJQfQdmfmtG8FUfqSIUWV
         eIadpWXL3xmWRS3aZekd7viWkoV6I04WuQbWW2EE+iCds6XzUFPe3Cr7yFp+MGoA/O
         8ZK/DKacTit9g01Bph9xXyfJSQUxoaz0C2XJySRvgeSj0hf2s50rv3Q98U0tmOlXmd
         JVjlNbIm8Rh5Q==
Date:   Tue, 30 May 2023 11:18:51 -0700
From:   Chris Li <chrisl@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        yosryahmed@google.com, kernel-team@fb.com
Subject: Re: [PATCH] mm: zswap: shrink until can accept
Message-ID: <ZHY+C0ICTah8/+V3@google.com>
References: <20230524065051.6328-1-cerasuolodomenico@gmail.com>
 <ZHE7KWId1fvXLpUy@google.com>
 <CA+CLi1iC35exSaKaCmVmTWtna=9xBKHSyGNGmHFo=OqiSECGoA@mail.gmail.com>
 <ZHUSfg+z3wcaIhAT@google.com>
 <20230530041341.GB84971@cmpxchg.org>
 <ZHYNaxgcKs7PSp9I@google.com>
 <20230530155519.GB97194@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530155519.GB97194@cmpxchg.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 11:55:19AM -0400, Johannes Weiner wrote:
> On Tue, May 30, 2023 at 07:51:23AM -0700, Chris Li wrote:
> > Thanks for pointing out -ENOMEM shouldn't be persistent.
> > Points taken.
> > 
> > The original point of not retrying the persistent error
> > still holds.
> 
> Okay, but what persistent errors are you referring to?

Maybe ENOMEM is a bad example. How about if the swap device
just went bad and can't complete new IO writes?

> Aside from -ENOMEM, writeback_entry will fail on concurrent swap
> invalidation or a racing swapin fault. In both cases we should
> absolutely keep trying other entries until the goal is met.

How about a narrower fix recognizing those error cases and making
the inner loop continue in those errors?

> > > Should it be fixed before merging this patch? I don't think the
> > > ordering matters. Right now the -ENOMEM case invokes OOM, so it isn't
> > > really persistent either. Retrying a few times in that case certainly
> > > doesn't seem to make things worse.
> > 
> > If you already know the error is persistent, retrying is wasting
> > CPU. It can pertancial hold locks during the retry, which can
> > slow someone else down.
> 
> That's a bit of a truism. How does this pertain to the zswap reclaim
> situation?

See the above narrower fix alternative.
> 
> > > > > As I was writing to Yosry, the differentiation would be a great improvement
> > > > > here, I just have a patch set in the queue that moves the inner reclaim loop
> > > > > from the zpool driver up to zswap. With that, updating the error handling
> > > > > would be more convenient as it would be done in one place instead of three.i
> > > > 
> > > > This has tricky complications as well. The current shrink interface
> > > > doesn't support continuing from the previous error position. If you want
> > > > to avoid a repeat attempt if the page has a writeback error, you kinda
> > > > of need a way to skip that page.
> > > 
> > > A page that fails to reclaim is put back to the tail of the LRU, so
> > > for all intents and purposes it will be skipped. In the rare and
> > 
> > Do you mean the page is treated as hot again?
> > 
> > Wouldn't that be undesirable from the app's point of view?
> 
> That's current backend LRU behavior. Is it optimal? That's certainly
> debatable. But it's tangential to this patch. The point is that
> capping retries to a fixed number of failures works correctly as a
> safety precaution and introduces no (new) undesirable behavior.
> 
> It's entirely moot once we refactor the backend page LRU to the zswap
> entry LRU. The only time we'll fail to reclaim an entry is if we race
> with something already freeing it, so it doesn't really matter where
> we put it.

Agree with you there. A bit side tracked.

> > > extreme case where it's the only page left on the list, I again don't
> > > see how retrying a few times will make the situation worse.
> > > 
> > > In practice, IMO there is little upside in trying to be more
> > > discerning about the error codes. Simple seems better here.
> > 
> > Just trying to think about what should be the precise loop termination
> > condition here.
> > 
> > I still feel blindly trying a few times is a very imprecise condition.
> 
> The precise termination condition is when can_accept() returns true
> again. The safety cap is only added as precaution to avoid infinite
> loops if something goes wrong or unexpected, now or in the future.

In my mind, that statement already suggests can_accept() is not
*precise*, considering the avoid infinite loop.
e.g. Do we know what is the optimal cap value and why that value
is optical?

Putting the definition of precise aside, I do see the unconditional
retry can have unwanted effects.

Chris

