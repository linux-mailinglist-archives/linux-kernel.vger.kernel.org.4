Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5438661834C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiKCPxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiKCPxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:53:33 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8854D167DA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 08:53:32 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s196so2032162pgs.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 08:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iefhXYcFca+HyMrTaCiWzQ24fHFIs/brIYiJSEqSUcQ=;
        b=mnEgPRYk2PPB666Mwc6QMzwxTKX+rHctMioHYBKj2e0+U0kbTQLPG0Vk5U7nmSb9wV
         PISe2i9oNNIXplC90+WVjOWIs8l49/kPSfcN5II4Ot73q+9bAJawAHd55MYPSnkXs/qj
         FIRWz0djKi2SgpHLqSCp3pK9HC57ylPOzHGkWmSRlY6zO929FS1SFMnoj31Gdvi6PF9V
         JSPUHze4LGYGvzrfdncqMAS65bVQF/8vr7ji42neU0tBUIHYsKx7ATT+TXTyhdDxBW6g
         OIvvRJPvZqzRKqXvqCisKq8OrHP5H5/DI8tUlmMMR+ZE8FtbzYgWXqDHgm6CsU4OuH85
         VXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iefhXYcFca+HyMrTaCiWzQ24fHFIs/brIYiJSEqSUcQ=;
        b=T1/SHSAjDqMDRdf55d4/koayv4KiaKaFIAOW3WF+7Cx0l2xtElhnG8vKSE6NkIiT0b
         ULDYL30Y1fYDzweGplZEgZO1RtsU5Wm01FhqsBcyWY309atEHytCYjiY80PpEV5btlUn
         C4sGeZvXkesgjROL76Cm25lhWLRdsB3lJuZ5ovKWGi3ev3qnbJd+b8dxOdLX1ZI+mdVl
         FnJ6lDQH0EfBbC5IbbzU1u8DCQm6WyCFwg7luLQeI3t8JrSrZ3qVYO28qJuIz6WqAHJ3
         hwL8MNQ0aoqIoWXCiqExNFPFMuisahioHfjx+7u8jRPpShKzGWgxTWTAURmaDxPZtysw
         c//w==
X-Gm-Message-State: ACrzQf0046LuXWdvWX7GRss15uZ1IWfVku+G3yoU32UhcLUlNIchcwQA
        bgwCkyv1l1KqFSwxLcnGU6ZFFi0+W8c=
X-Google-Smtp-Source: AMsMyM4fr0j5T3py3yG/3/HWamAEHR9CXTW4h3U6KJORTNzMY9j5TYUF1eC9OhTEn2s6p+YvKd5f9w==
X-Received: by 2002:a63:e007:0:b0:46f:d715:3704 with SMTP id e7-20020a63e007000000b0046fd7153704mr15322741pgh.108.1667490811941;
        Thu, 03 Nov 2022 08:53:31 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:3d65:7dc2:c62a:5d98])
        by smtp.gmail.com with ESMTPSA id k9-20020a17090a3cc900b00212d9a06edcsm125728pjd.42.2022.11.03.08.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 08:53:31 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 3 Nov 2022 08:53:29 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ngupta@vflare.org, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com
Subject: Re: [PATCH 2/5] zsmalloc: Consolidate zs_pool's migrate_lock and
 size_class's locks
Message-ID: <Y2Pj+fuON8lTMcmn@google.com>
References: <20221026200613.1031261-1-nphamcs@gmail.com>
 <20221026200613.1031261-3-nphamcs@gmail.com>
 <Y2Hj+H4VzlN/fcmR@google.com>
 <Y2Li412OGB6g8ARA@google.com>
 <Y2PbrOqRMLDsYev0@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2PbrOqRMLDsYev0@cmpxchg.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 11:18:04AM -0400, Johannes Weiner wrote:
> On Wed, Nov 02, 2022 at 02:36:35PM -0700, Minchan Kim wrote:
> > On Wed, Nov 02, 2022 at 12:28:56PM +0900, Sergey Senozhatsky wrote:
> > > On (22/10/26 13:06), Nhat Pham wrote:
> > > >  struct size_class {
> > > > -	spinlock_t lock;
> > > >  	struct list_head fullness_list[NR_ZS_FULLNESS];
> > > >  	/*
> > > >  	 * Size of objects stored in this class. Must be multiple
> > > > @@ -247,8 +245,7 @@ struct zs_pool {
> > > >  #ifdef CONFIG_COMPACTION
> > > >  	struct work_struct free_work;
> > > >  #endif
> > > > -	/* protect page/zspage migration */
> > > > -	rwlock_t migrate_lock;
> > > > +	spinlock_t lock;
> > > >  };
> > > 
> > > I'm not in love with this, to be honest. One big pool lock instead
> > > of 255 per-class locks doesn't look attractive, as one big pool lock
> > > is going to be hammered quite a lot when zram is used, e.g. as a regular
> > > block device with a file system and is under heavy parallel writes/reads.
> 
> TBH the class always struck me as an odd scope to split the lock. Lock
> contention depends on how variable the compression rate is of the
> hottest incoming data, which is unpredictable from a user POV.
> 
> My understanding is that the primary usecase for zram is swapping, and
> the pool lock is the same granularity as the swap locking.

People uses the zram to store caching object files in build server.

> 
> Regardless, we'll do some benchmarks with filesystems to understand
> what a reasonable tradeoff would be between overhead and complexity.

Thanks.

> Do you have a particular one in mind? (I'm thinking journaled ones are
> not of much interest, since their IO tends to be fairly serialized.)
> 
> btrfs?

I am not sure what FSes others are using but at least for me, just
plain ext4.

> 
> > I am also worry about that LRU stuff should be part of allocator
> > instead of higher level.
> 
> I'm sorry, but that's not a reasonable objection.
> 
> These patches implement a core feature of being a zswap backend, using
> standard LRU and locking techniques established by the other backends.
> 
> I don't disagree that it would nicer if zswap had a strong abstraction
> for backend pages and a generalized LRU. But that is major surgery on
> a codebase of over 6,500 lines. It's not a reasonable ask to change
> all that first before implementing a basic feature that's useful now.

With same logic, folks added the LRU logic into their allocators
without the effort considering moving the LRU into upper layer.

And then trend is still going on since I have seen multiple times
people are trying to add more allocators. So if it's not a reasonable
ask to consier, we couldn't stop the trend in the end.

> 
> I get that your main interest is zram, and so this feature isn't of
> interest to you. But zram isn't the only user, nor is it the primary

I am interest to the feature but my interest is more of general swap
layer to manage the LRU so that it could support any hierarchy among
swap devices, not only zswap.
