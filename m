Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A176F65A4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjEDHXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjEDHW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:22:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC122D40
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 00:22:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B645661763
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 07:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA23C433EF;
        Thu,  4 May 2023 07:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683184975;
        bh=qJE+0VDf65DzGrnz6OhSis5f42jRxQcKqBnVkpXUuFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GcTtTYdDdvzZ5IUfTarqxjQUJBbA04A876488HjBrItLI98yBEMu7NXhfb1VVc3kS
         WCwtcsbw1q5JbWNaUquAm5MeftwfQYwm/F1Wrv1srXVO7z6UwsKtsja+KcEvZUYLCy
         kR+LWYRs5cvd7pwzuZ7i3t+tnOOIXlF2K6gK9Ax57OPlTtPHudCVtS2vcY5ydzGO3R
         wqS4fUCqNtZ2ludeB1h4V/HdQAESIiYL7NDDOfba5zoYDsPjG8k4TdZCVveEU3qCLD
         FW4BsbiYcNh9L38Bz9WmSWO8ld6SQlYgNrCRPIO5WylgHcErDyDJHbxn2VRZtD9s8E
         yp2wAtscjDRJg==
Date:   Thu, 4 May 2023 00:22:53 -0700
From:   Chris Li <chrisl@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        minchan@kernel.org, ngupta@vflare.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: fix zswap writeback race condition
Message-ID: <ZFNdTfki5HWmne2j@google.com>
References: <20230503151200.19707-1-cerasuolodomenico@gmail.com>
 <ZFLZQ/hJarV+iNYd@google.com>
 <20230504022904.GA202700@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504022904.GA202700@cmpxchg.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 10:29:04PM -0400, Johannes Weiner wrote:
> > >  
> > >  	case ZSWAP_SWAPCACHE_NEW: /* page is locked */
> 
>                                   ^^^^^^^^^^^^^^^^^^^^
> 
> > > +		/*
> > > +		 * Having a local reference to the zswap entry doesn't exclude
> > > +		 * swapping from invalidating and recycling the swap slot. Once
> > > +		 * the swapcache is secured against concurrent swapping to and
> > > +		 * from the slot, recheck that the entry is still current before
> > > +		 * writing.
> > > +		 */
> > > +		spin_lock(&tree->lock);
> > > +		if (zswap_rb_search(&tree->rbroot, entry->offset) != entry) {
> > > +			spin_unlock(&tree->lock);
> > > +			delete_from_swap_cache(page_folio(page));
> > > +			ret = -ENOMEM;
> > > +			goto fail;
> > > +		}
> > > +		spin_unlock(&tree->lock);
> > > +
> > 
> > The race condition is still there, just making it much harder to hit.
> > What happens after you perform the rb tree search, release tree lock.
> > Then the entry gets invalid and recycled right here before the decompress
> > step?
> 
> Recyling can only happen up until we see ZSWAP_SWAPCACHE_NEW.
> 
> Once we see it, we're holding the page lock* on a new swapcache page
> for a valid, in-use** swp_entry_t.
> 
> The lock of the swapcache page prevents swapin, which would be
> required for the count to drop and the entry to be recycled.

Thanks for the explain. I miss the locked page will prevent swapin part.

> __read_swap_cache_async() checked that the entry is valid, so the slot
> cannot be allocated to someone else.
> 
> Now we just have to check if that entry is the right one, iow the slot
> wasn't recycled.
> 
> If the slot wasn't recycled, we know we have the right data and we can
> start the IO and unlock the page. (After that swapins can continue and
> the data can change, but regular writeback vs redirtying rules apply.)
> 
> If the slot was indeed recycled before we get ZSWAP_SWAPCACHE_NEW, we
> see the mismatch, delete the page from the swapcache and unlock it. A
> racing do_swap_page() may have found and reffed the page in swapcache,
> and acquire the page lock after us; but it'll see it's no longer in
> the swapcache, drop the reference (free the page) and retry the fault.

LGTM then. Please feel free to add:

Reviewed-by: Chris Li (Google) <chrisl@kernel.org>

Chris
