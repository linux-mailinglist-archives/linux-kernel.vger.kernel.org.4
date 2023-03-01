Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00726A77F5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjCAXsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCAXsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:48:16 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4222CC47
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:48:05 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id v11so12251323plz.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 15:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677714485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IwnplCZss/sjev7Hh27BVil2zDjq9ax06z63d9E4vYY=;
        b=GpXkbFhcR+YXAEC9td8Szq1ZMuyjfpUMKgB3P7Odc6nMN5mfl0uTGmcLq0dXc6aZbw
         NJo/SFk/ew1uJxyY0A7dFEH1PB/VS2EVoiFeQ+To0sYD/SHzmkYoWZKgkoVfwIpZMdzv
         E65W+sp9Dv1nLfD+oVddXYTwqnL2X7iF05ZPNUnhMc5P90tKkAiwFAEYd791K3crES7/
         ITr6nrUXbr4q1Fj+kyjGKPNQ3pRUMpKf2i7pUQJNUgftNwUPMz8yfCgqRni3YfBIniS6
         evhwQ6sOHdJkAqmTL8me0I/YtNWeWWL09O3vDTcgzadkCCOTh8Sb9U4vYPIJ46SAVdKN
         5coQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677714485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IwnplCZss/sjev7Hh27BVil2zDjq9ax06z63d9E4vYY=;
        b=CPPKQrOgX7KqsO3bL6zC5MK+NeHdnPtz44al1ML7d0oRLt+HNQIgWxSRGbjJ+utePd
         IbAzIps2T9P6ZiykR8wIDVDJ3lXIzB1gSORdLmNvbv0Twk3/2qT9DbxXkq8fI0ah9bFX
         wKGYpvgy8yV51UfKw7Yo/f2oWPCrpssYXFuK9U5w+3NX1pyxMi3d0BazLP1eESQssckt
         hrGjAZ4i77vnvViJCV012dnDbczpHmXPGD2S76lDbuhmcrRNJVI3TxT9RB3lX+AvWXoE
         0RuPyzX0gRMI4ytaV+MkF9CCkwLcwRuyoOnxV9Lfb2f18ZVcOcLsOAh1hpEWwUy6SrRj
         FCIw==
X-Gm-Message-State: AO0yUKVO9LtugQhFnzN2VnIOwQGr9SzqCOE8WEuPOLlFK0U9IOY6caAS
        n7UkKOykQG4cQbzRC3myiM06Y7hbWcY=
X-Google-Smtp-Source: AK7set8pm9GVZz+CiwcKtVsULeY275AftnO/TM3U50O74RuKS7xCbHJ/5t6tVSe791ZyGMKLJbgcyA==
X-Received: by 2002:a05:6a20:8407:b0:cc:eb3b:56e9 with SMTP id c7-20020a056a20840700b000cceb3b56e9mr11850682pzd.1.1677714485139;
        Wed, 01 Mar 2023 15:48:05 -0800 (PST)
Received: from google.com ([2620:15c:211:201:a524:71b8:ce7e:745d])
        by smtp.gmail.com with ESMTPSA id f23-20020aa782d7000000b005dea362ed18sm8497558pfn.27.2023.03.01.15.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 15:48:04 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 1 Mar 2023 15:48:02 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 5/6] zsmalloc: extend compaction statistics
Message-ID: <Y//kMuCV7dzdrfGp@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <20230223030451.543162-6-senozhatsky@chromium.org>
 <Y/f75fkcQg6m3cbG@google.com>
 <Y/rYQdUDNHDCJJTO@google.com>
 <Y/5+PEfuEl3b/sDR@google.com>
 <Y/7MkLdVXImxPQeJ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/7MkLdVXImxPQeJ@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 12:54:56PM +0900, Sergey Senozhatsky wrote:
> On (23/02/28 14:20), Minchan Kim wrote:
> > On Sun, Feb 26, 2023 at 12:55:45PM +0900, Sergey Senozhatsky wrote:
> > > On (23/02/23 15:51), Minchan Kim wrote:
> > > > On Thu, Feb 23, 2023 at 12:04:50PM +0900, Sergey Senozhatsky wrote:
> > > > > Extend zsmalloc zs_pool_stats with a new member that
> > > > > holds the number of objects pool compaction moved
> > > > > between pool pages.
> > > > 
> > > > I totally understand this new stat would be very useful for your
> > > > development but not sure it's really useful for workload tune or
> > > > monitoring.
> > > > 
> > > > Unless we have strong usecase, I'd like to avoid new stat.
> > > 
> > > The way I see is that it *can* give some interesting additional data to
> > > periodical compaction (the one is not triggeed by the shrinker): if the
> > > number of moves objects is relatively high but the number of comapcted
> > > (feeed) pages is relatively low then the system has fragmentation in
> > > small size classes (that tend to have many objects per zspage but not
> > > too many pages per zspage) and in this case the interval between
> > > periodical compactions probably can be increased. What do you think?
> > 
> > In the case, how could we get only data triggered by periodical munual
> > compaction?
> 
> Something very simple like
> 
> 	read zram mm_stat
> 	trigger comapction
> 	read zram mm_stat
> 
> can work in most cases, I guess. There can be memory pressure
> and shrinkers can compact the pool concurrently, in which case
> mm_stat will include shrinker impact, but that's probably not
> a problem. If system is under memory pressure then user space

Agreed.

> in general does not have to do comapction, since the kernel will
> handle it.
> 
> Just an idea. It feels like "pages compacted" on its own tells very
> little, but I don't insist on exporting that new stat.

I don't mind adding the simple metric but I want to add metric if
we have real usecase with handful of comments how they uses it
in real world.

Thanks.
