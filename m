Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67ACA6DF279
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjDLLDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDLLDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:03:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31556A58
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:03:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B0FE41F890;
        Wed, 12 Apr 2023 11:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681297380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fNN7SNZCqWM5pixcyzb+RtLg6Zm4j6Y+uXTVrtsJ//8=;
        b=QHcDT0FRQxGosX0TleQ+60spnNEYZaxrvNfQxFMKfoFHy1YedQ4UuIJVhLg9Sy2BjRg73E
        mzxJcenfsNUGsVQ5JRJ4Tw6Abl9xPUxAGjLZ2WtAZoIg0nSqWQG2/T4UE4ULcVwVJ53US4
        tXfbDI37740XXMRRexPgxLPhb05lAV8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EA8413498;
        Wed, 12 Apr 2023 11:03:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yEzaH+SPNmRVKwAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 12 Apr 2023 11:03:00 +0000
Date:   Wed, 12 Apr 2023 13:02:59 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     "jstultz@google.com" <jstultz@google.com>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
Subject: Re: [PATCH v3] dma-buf/heaps: system_heap: avoid too much allocation
Message-ID: <ZDaP4/PYyb9tKGQi@dhcp22.suse.cz>
References: <ZDZ4j7UdBt32j28J@dhcp22.suse.cz>
 <ZDZqYTSHBNGLq0zI@dhcp22.suse.cz>
 <20230410073228.23043-1-jaewon31.kim@samsung.com>
 <20230412085726epcms1p7d2bec2526e47bd10a3b6ea6a113c9cc3@epcms1p7>
 <CGME20230410073304epcas1p4cf3079b096994d69472b7801bd530bc7@epcms1p4>
 <20230412094440epcms1p445319579ead0d0576bb616ebb07501b4@epcms1p4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412094440epcms1p445319579ead0d0576bb616ebb07501b4@epcms1p4>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-04-23 18:44:40, Jaewon Kim wrote:
> >On Wed 12-04-23 17:57:26, Jaewon Kim wrote:
> >> >Sorry for being late. I know there was some pre-existing discussion
> >> >around that but I didn't have time to participate.
> >> >
> >> >On Mon 10-04-23 16:32:28, Jaewon Kim wrote:
> >> >> @@ -350,6 +350,9 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
> >> >>  	struct page *page, *tmp_page;
> >> >>  	int i, ret = -ENOMEM;
> >> >>  
> >> >> +	if (len / PAGE_SIZE > totalram_pages())
> >> >> +		return ERR_PTR(-ENOMEM);
> >> >> +
> >> >
> >> >This is an antipattern imho. Check 7661809d493b ("mm: don't allow
> >> >oversized kvmalloc() calls") how kvmalloc has dealt with a similar
> >> 
> >> Hello Thank you for the information.
> >> 
> >> I tried to search the macro of INT_MAX.
> >> 
> >> include/vdso/limits.h
> >> #define INT_MAX         ((int)(~0U >> 1))
> >> 
> >> AFAIK the dma-buf system heap user can request that huge size more than 2GB.
> >
> >Do you have any pointers? This all is unreclaimable memory, right? How
> >are those users constrained to not go overboard?
> 
> Correct dma-buf system heap memory is unreclaimable. To avoid that huge request,
> this patch includes __GFP_RETRY_MAYFAIL.

__GFP_RETRY_MAYFAIL doesn't avoud huge requests. It will drain the free
available memory to the edge of OOM (especially for low order requests)
so effectively anybody else requesting any memory (GFP_KERNEL like req.)
will hit the oom killer very likely).

>  #define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_RETRY_MAYFAIL)
> 
> >
> >> So
> >> I think totalram_pages() is better than INT_MAX in this case.
> >> 
> >> >issue. totalram_pages doesn't really tell you anything about incorrect
> >> >users. You might be on a low memory system where the request size is
> >> >sane normally, it just doesn't fit into memory on that particular
> >> >machine.
> >> 
> >> Sorry maybe I'm not fully understand what you meant. User may requested
> >> a huge size like 3GB on 2GB ram device. But I think that should be rejected
> >> because it is bigger than the device ram size.
> >
> >Even totalram_pages/10 can be just unfeasible amount of data to be
> >allocated without a major disruption. totalram_pages is no measure of
> >the memory availability.
> >If you want to have a ballpark estimation then si_mem_available might be
> >something you are looking for. But I thought the sole purpose of this
> >patch is to catch obviously buggy callers (like sign overflow lenght
> >etc) rather than any memory consumption sanity check.
> 
> Yes if we want to avoid some big size, si_mem_available could be one option.
> Actually I tried to do totalram_pages() / 2 like the old ion system heap in
> the previous patch version. Anyway totalram_pages in this patch is used to
> avoid the buggy size.

So let me repeat that totalram_pages is a wrong thing to do(tm).

This is not a subsystem I would feel like nacking a patch, but consider
this feedback as strong of a rejection as somebody external can give
you. A mm internal allocator would get an outright nack.

What you are doing is just wrong and an antipattern to what other
allocators do. Either use something like INT_MAX to catch overflows or
do not try to catch buggy code but pretend a better memory consumer
citizen by using something like si_mem_available (ideally think of
other potential memory users so do not allow any request to use all
of it). The later might require much more involved interface and I do
rememeber some attempts to account and limit dmabuf memory better.

> And as we discussed in v2 patch, __GFP_RETRY_MAYFAIL was added. And I think
> the gfp makes us feel better in memory perspective.

wishful thinking that is.
-- 
Michal Hocko
SUSE Labs
