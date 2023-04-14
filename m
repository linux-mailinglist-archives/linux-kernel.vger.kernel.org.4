Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC416E2092
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjDNKTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjDNKTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:19:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BE183CD
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:19:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B96791FD95;
        Fri, 14 Apr 2023 10:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681467544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oxm+Jbd0/Tkjw/vGhSVmsyY0h1pCAWJpxgNwHUNcSZ8=;
        b=HjXeb8lquZ6LFAsP8NfkDUKuHxmSIPuev7wDyM6h5va7AUsw22u/xHpgNzfjRQ0bZ6A2+B
        Ngo7JZu8RPnLoDf9V8UzAMRuCY5FQJ/7npoTINDjEgp2KZh1+v1M0WYKcDCRKZ7TB62Ze9
        LOb0HC5cb20hDf6ADo2IJ6gUbRYrS+Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A1D4139FC;
        Fri, 14 Apr 2023 10:19:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pPttI5goOWRmJAAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 14 Apr 2023 10:19:04 +0000
Date:   Fri, 14 Apr 2023 12:19:03 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <OSalvador@suse.com>,
        Yuanxi Liu <y.liu@naruida.com>,
        David Hildenbrand <david@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: page_alloc: Assume huge tail pages are valid when
 allocating contiguous pages
Message-ID: <ZDkolzCWQNe0NmTD@dhcp22.suse.cz>
References: <20230414082222.idgw745cgcduzy37@techsingularity.net>
 <ZDkU6PuuDsUb82lr@dhcp22.suse.cz>
 <20230414095204.7fz6trkj5i4mzthz@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414095204.7fz6trkj5i4mzthz@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 14-04-23 10:52:04, Mel Gorman wrote:
> On Fri, Apr 14, 2023 at 10:55:04AM +0200, Michal Hocko wrote:
> > On Fri 14-04-23 09:22:22, Mel Gorman wrote:
> > [...]
> > > +
> > > +		/*
> > > +		 * Do not migrate huge pages that span the size of the region
> > > +		 * being allocated contiguous. e.g. Do not migrate a 1G page
> > > +		 * for a 1G allocation request. CMA is an exception as the
> > > +		 * region may be reserved for hardware that requires physical
> > > +		 * memory without a MMU or scatter/gather capability.
> > > +		 *
> > > +		 * Note that the compound check is race-prone versus
> > > +		 * free/split/collapse but it should be safe and result in
> > > +		 * a premature skip or a useless migration attempt.
> > > +		 */
> > > +		if (PageHuge(page) && compound_nr(page) >= nr_pages &&
> > > +		    !is_migrate_cma_page(page)) {
> > > +			return false;
> > 
> > Is the CMA check working as expected?
> 
> I didn't test it as I don't have a good simulator for CMA contraints which
> is still a mobile phone concern for devices like cameras.
> 
> > The function sounds quite generic
> > and I agree that it would make sense if it was generic but it is used
> > only for GB pages in fact and unless I am missing something it would
> > allow to migrate CMA pages and potentially allocate over that region
> > without any possibility to migrate GB page out so the CMA region would
> > be essentially unusable for CMA users.
> 
> It's used primarily for 1G pages but does have other users (debugging
> mostly, low priority). As it's advertised as a general API, I decided to
> treat it as such and that meant being nice to CMA if possible. If CMA pages
> migrate but can still use the target location then it should be fine. If a
> CMA can migrate to an usable location that breaks a device then that's a bug.
> 
> > GB pages already have their CMA
> > allocator path before we get to alloc_contig_pages. Or do I miss
> > something?
> 
> I don't think you missed anything. The CMA check is, at best, an effort
> to have a potentially useful semantic but it's very doubtful anyone will
> notice or care. I'm perfectly happy just to drop the CMA check because it's a
> straight-forward fix and more suitable as a -stable backport.  I'm also happy
> to just go with a PageHuge check and ignore any possibility that a 2M page
> could be migrated to satisfy a 1G allocation.  1G allocation requests after
> significant uptime is a crapshoot at best and relying on them succeeding is
> unwise. There is a non-zero possibility that the latency incurred migrating
> 2M pages and still failing a 1G allocation could itself be classed as a
> bug with users preferring fast-failure of 1G allocation attempts.

Yes, the simpler the better. If we encounter a real usecase where couple
of 2MB hugetlb pages stand in the way to GB pages then we can add the
check so I would just go with reintroducing the PageHuge check alone.

Thanks!
-- 
Michal Hocko
SUSE Labs
