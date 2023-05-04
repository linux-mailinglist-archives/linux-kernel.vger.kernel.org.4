Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E7A6F62F0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 04:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjEDC3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 22:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjEDC3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 22:29:09 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67221E4A
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 19:29:06 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3ef588dcf7aso59619671cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 19:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1683167345; x=1685759345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EN98kruW+UyajuDoJOOXmJ6SnmFPGvXcjLV0DXjMEmM=;
        b=r2qVglpG+tNTYcg16qpuf9/eKF1z+vZ3oEe0tXEUbkRR2CIQGizdv9FiO5fGhNPt0e
         SS8+GqPEebxukquzwH50Kmf9MvHqTyEwa6sul8NT3jbedM2WVsgYMM7lN2BDTkGktwVk
         +MbAwdxPldNJBhyH0N71/TdEDKKR02XX4sXowzHkwSKKlqbHui0jTDahJmasPA3To7ar
         TW4nPxCCDIJnA4DN3uTTFf4vWGOaUcjzxHr2OBXYmVXp8Tpz4zYp5tlcw4GOQJmlIYPm
         pe3tIvY+1tj2YIrSSpRuz1Q1OHLFx+wP7qiZIABx6q2EF8KVGenL1dpGugsVSV/sdozj
         uYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683167345; x=1685759345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EN98kruW+UyajuDoJOOXmJ6SnmFPGvXcjLV0DXjMEmM=;
        b=GeyktEIgLQw/GBHKCsYz6X0ILOSXby1wHlrL+IEfJOsE2WKYESwE0gGxmdFYrGfV64
         1lOegaKhWUmtqMJNApsDZt/76Rm2f2ukQErhEg1x8wI2esp0hM88Kpu6BodjxtWmLMzS
         RPmZDj3vMuoQBZcs/dccVWRPMEHNdxsZHuwiJ8wwgCrfbuQNjmzG7HkWqNnhfhs/r5/A
         46dvGY6OHEL7srzxoRj+5i18AdFjYQWR3hWYS/BzSk7ivU8MLjgs/V+eNwzLAuHJIHDM
         EGgAsUKpq/5y1TVQ3WT68xE0zpNfIeDnsSGW29exqrTY4myLnKqpln3zcf2R3Um+Ou9b
         sN/w==
X-Gm-Message-State: AC+VfDzYSOxrVLB9xemT7vKsalaATMwjd/hPtteuRJBNNd7YzH8R0j3Y
        0i1VhEeLjnJCzVFR8MYi1gk12g==
X-Google-Smtp-Source: ACHHUZ5c3ftEeeDH6kHUr7jXEXv6cF2lQWdHfegMSQDGKoh5DLnyGvBQA5/MYnqd3Do0hwciOMOoBA==
X-Received: by 2002:a05:622a:1495:b0:3ef:612c:58a1 with SMTP id t21-20020a05622a149500b003ef612c58a1mr3319622qtx.62.1683167345532;
        Wed, 03 May 2023 19:29:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:1366])
        by smtp.gmail.com with ESMTPSA id f17-20020ac86ed1000000b003ef2db16e72sm11960190qtv.94.2023.05.03.19.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 19:29:05 -0700 (PDT)
Date:   Wed, 3 May 2023 22:29:04 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Li <chrisl@kernel.org>
Cc:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        minchan@kernel.org, ngupta@vflare.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: fix zswap writeback race condition
Message-ID: <20230504022904.GA202700@cmpxchg.org>
References: <20230503151200.19707-1-cerasuolodomenico@gmail.com>
 <ZFLZQ/hJarV+iNYd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFLZQ/hJarV+iNYd@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 02:59:31PM -0700, Chris Li wrote:
> Hi Domenico,
> 
> On Wed, May 03, 2023 at 05:12:00PM +0200, Domenico Cerasuolo wrote:
> > 1. a page with data A and swap offset X is stored in zswap
> > 2. page A is removed off the LRU by zpool driver for writeback in
> > zswap-shrink work, data for A is mapped by zpool driver
> > 3. user space program faults and invalidates page entry A, offset X is
> > considered free
> > 4. kswapd stores page B at offset X in zswap (zswap could also be full,
> > if so, page B would then be IOed to X, then skip step 5.)
> > 5. entry A is replaced by B in tree->rbroot, this doesn't affect the
> > local reference held by zswap-shrink work
> > 6. zswap-shrink work writes back A at X, and frees zswap entry A
> > 7. swapin of slot X brings A in memory instead of B
> 
> Thanks for the interesting discovery.
> 
> > V2:
> > - updated comment with better explaination of the situation being
> > addressed in the check
> > 
> > Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  mm/zswap.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index f6c89049cf70..5d5977c9ea45 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -995,6 +995,22 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
> >  		goto fail;
> >  
> >  	case ZSWAP_SWAPCACHE_NEW: /* page is locked */

                                  ^^^^^^^^^^^^^^^^^^^^

> > +		/*
> > +		 * Having a local reference to the zswap entry doesn't exclude
> > +		 * swapping from invalidating and recycling the swap slot. Once
> > +		 * the swapcache is secured against concurrent swapping to and
> > +		 * from the slot, recheck that the entry is still current before
> > +		 * writing.
> > +		 */
> > +		spin_lock(&tree->lock);
> > +		if (zswap_rb_search(&tree->rbroot, entry->offset) != entry) {
> > +			spin_unlock(&tree->lock);
> > +			delete_from_swap_cache(page_folio(page));
> > +			ret = -ENOMEM;
> > +			goto fail;
> > +		}
> > +		spin_unlock(&tree->lock);
> > +
> 
> The race condition is still there, just making it much harder to hit.
> What happens after you perform the rb tree search, release tree lock.
> Then the entry gets invalid and recycled right here before the decompress
> step?

Recyling can only happen up until we see ZSWAP_SWAPCACHE_NEW.

Once we see it, we're holding the page lock* on a new swapcache page
for a valid, in-use** swp_entry_t.

The lock of the swapcache page prevents swapin, which would be
required for the count to drop and the entry to be recycled.

__read_swap_cache_async() checked that the entry is valid, so the slot
cannot be allocated to someone else.

Now we just have to check if that entry is the right one, iow the slot
wasn't recycled.

If the slot wasn't recycled, we know we have the right data and we can
start the IO and unlock the page. (After that swapins can continue and
the data can change, but regular writeback vs redirtying rules apply.)

If the slot was indeed recycled before we get ZSWAP_SWAPCACHE_NEW, we
see the mismatch, delete the page from the swapcache and unlock it. A
racing do_swap_page() may have found and reffed the page in swapcache,
and acquire the page lock after us; but it'll see it's no longer in
the swapcache, drop the reference (free the page) and retry the fault.
