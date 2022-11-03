Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9393061823D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiKCPSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiKCPSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:18:03 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D731759F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 08:18:02 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id i12so1335901qvs.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 08:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Y91EMmWkKaDNLHulFaIVLlw/0EjJtCCjHihzz5PhWk=;
        b=PccX6QjizeOvlnpoTObOI84VoFlp0uZB37fB7rBt93+yxAolIIErLnWuBNu4i0hxwg
         dPVH6YwiBblIu/66nxf0sR77eazM57ZGbKjYGBmrS4mRy3K3NaTeWNq+c0aptUG/DjDD
         DyqUVvJIRrE/Ag34h5nuo6Ra/NFHTK730c1F7k2HlhR1NUZWflyGwtN2ciIT1kSS5VaJ
         l5OyLyfUqPVv0dEaBAF4/cPhru2PuwuMxMknIKL7k+SN4uvNRVG8Po0/N2cHlC0IDxWO
         Dr8ZqnSY5fryvhMDwPsW/P3OPvQ+jXM5EKNUnmno5pgAElKzQx4TzFUtVa9efERk/5+J
         MKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Y91EMmWkKaDNLHulFaIVLlw/0EjJtCCjHihzz5PhWk=;
        b=fbWqHaFRHThfiOo0qRkVYVgdWSaYTQMCiISQBuS/6ycJoJF4IwuVSfCgqGF6kT0Ips
         nXHpAv+oDsS1IEKSkMswaa3pEXwEfg6n4B50EU6dNpXyDreI6+ndHGbdYdLt3XIK3PIc
         rhvajgdF1driTSuN8k6dg1riU4Ls4wpOoADdB5PtYEZ4J2wKnAMKlAzFqLLqTf3iO0Iu
         +aL1VAMAaT9JXAM/9rmQOsAUpNQhI2GChYezIwNiyyHd1i7scER2j2BizAfaCRe+Q2TT
         TcRV8fpIKsOrYE9IMDwlmIuWfoyAsunNMr3dyDebJGpbU/RRWi+o8lUNkOcIoDORO+f/
         cdzQ==
X-Gm-Message-State: ACrzQf1GncV3IIRTjJI99Vekoa+/81dCQqYPQshamCyi3M7G8cT3xNRl
        MmCO5gy4iark56HXBZVu7yS2XQ==
X-Google-Smtp-Source: AMsMyM7JB/Ih4o4p/NED8dCLrDKvYU2z10bZku6KhZ0Ar6O6VgXOvhFZQiWItlhqzX+Q37kYlFpJHg==
X-Received: by 2002:a05:6214:3016:b0:4bb:9e66:1100 with SMTP id ke22-20020a056214301600b004bb9e661100mr27182644qvb.23.1667488681877;
        Thu, 03 Nov 2022 08:18:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::25f1])
        by smtp.gmail.com with ESMTPSA id bk14-20020a05620a1a0e00b006f3e6933bacsm881844qkb.113.2022.11.03.08.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 08:18:01 -0700 (PDT)
Date:   Thu, 3 Nov 2022 11:18:04 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ngupta@vflare.org, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com
Subject: Re: [PATCH 2/5] zsmalloc: Consolidate zs_pool's migrate_lock and
 size_class's locks
Message-ID: <Y2PbrOqRMLDsYev0@cmpxchg.org>
References: <20221026200613.1031261-1-nphamcs@gmail.com>
 <20221026200613.1031261-3-nphamcs@gmail.com>
 <Y2Hj+H4VzlN/fcmR@google.com>
 <Y2Li412OGB6g8ARA@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Li412OGB6g8ARA@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 02:36:35PM -0700, Minchan Kim wrote:
> On Wed, Nov 02, 2022 at 12:28:56PM +0900, Sergey Senozhatsky wrote:
> > On (22/10/26 13:06), Nhat Pham wrote:
> > >  struct size_class {
> > > -	spinlock_t lock;
> > >  	struct list_head fullness_list[NR_ZS_FULLNESS];
> > >  	/*
> > >  	 * Size of objects stored in this class. Must be multiple
> > > @@ -247,8 +245,7 @@ struct zs_pool {
> > >  #ifdef CONFIG_COMPACTION
> > >  	struct work_struct free_work;
> > >  #endif
> > > -	/* protect page/zspage migration */
> > > -	rwlock_t migrate_lock;
> > > +	spinlock_t lock;
> > >  };
> > 
> > I'm not in love with this, to be honest. One big pool lock instead
> > of 255 per-class locks doesn't look attractive, as one big pool lock
> > is going to be hammered quite a lot when zram is used, e.g. as a regular
> > block device with a file system and is under heavy parallel writes/reads.

TBH the class always struck me as an odd scope to split the lock. Lock
contention depends on how variable the compression rate is of the
hottest incoming data, which is unpredictable from a user POV.

My understanding is that the primary usecase for zram is swapping, and
the pool lock is the same granularity as the swap locking.

Regardless, we'll do some benchmarks with filesystems to understand
what a reasonable tradeoff would be between overhead and complexity.
Do you have a particular one in mind? (I'm thinking journaled ones are
not of much interest, since their IO tends to be fairly serialized.)

btrfs?

> I am also worry about that LRU stuff should be part of allocator
> instead of higher level.

I'm sorry, but that's not a reasonable objection.

These patches implement a core feature of being a zswap backend, using
standard LRU and locking techniques established by the other backends.

I don't disagree that it would nicer if zswap had a strong abstraction
for backend pages and a generalized LRU. But that is major surgery on
a codebase of over 6,500 lines. It's not a reasonable ask to change
all that first before implementing a basic feature that's useful now.

I get that your main interest is zram, and so this feature isn't of
interest to you. But zram isn't the only user, nor is it the primary
user, of zsmalloc.
