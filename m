Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1DB6DF038
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDLJXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjDLJXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:23:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F9161B4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 02:23:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B05591F890;
        Wed, 12 Apr 2023 09:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681291408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f9fMYDJZDgUQAkG8XezrdJzHQ/H+XHFOp2dBJyvFZng=;
        b=srRAZkGNHFWybWCUH/9iHfY36CH4iNoSYiYJRuBfDoudIVOmtt5MgU7Ec8Tkvwp+50aiTe
        NA6iHiEjlqIxVAEWMuo1ZAq+rJUEcPHYS8ATBjmlilIpaL8BOX3+lOLxMHVuqO088QIpNs
        3LJJzy8nYFgNyTnUWMNnml6O9l/duf8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FC3D13498;
        Wed, 12 Apr 2023 09:23:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hZ9xIJB4NmSFeAAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 12 Apr 2023 09:23:28 +0000
Date:   Wed, 12 Apr 2023 11:23:27 +0200
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
Message-ID: <ZDZ4j7UdBt32j28J@dhcp22.suse.cz>
References: <ZDZqYTSHBNGLq0zI@dhcp22.suse.cz>
 <20230410073228.23043-1-jaewon31.kim@samsung.com>
 <CGME20230410073304epcas1p4cf3079b096994d69472b7801bd530bc7@epcms1p7>
 <20230412085726epcms1p7d2bec2526e47bd10a3b6ea6a113c9cc3@epcms1p7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412085726epcms1p7d2bec2526e47bd10a3b6ea6a113c9cc3@epcms1p7>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-04-23 17:57:26, Jaewon Kim wrote:
> >Sorry for being late. I know there was some pre-existing discussion
> >around that but I didn't have time to participate.
> >
> >On Mon 10-04-23 16:32:28, Jaewon Kim wrote:
> >> @@ -350,6 +350,9 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
> >>  	struct page *page, *tmp_page;
> >>  	int i, ret = -ENOMEM;
> >>  
> >> +	if (len / PAGE_SIZE > totalram_pages())
> >> +		return ERR_PTR(-ENOMEM);
> >> +
> >
> >This is an antipattern imho. Check 7661809d493b ("mm: don't allow
> >oversized kvmalloc() calls") how kvmalloc has dealt with a similar
> 
> Hello Thank you for the information.
> 
> I tried to search the macro of INT_MAX.
> 
> include/vdso/limits.h
> #define INT_MAX         ((int)(~0U >> 1))
> 
> AFAIK the dma-buf system heap user can request that huge size more than 2GB.

Do you have any pointers? This all is unreclaimable memory, right? How
are those users constrained to not go overboard?

> So
> I think totalram_pages() is better than INT_MAX in this case.
> 
> >issue. totalram_pages doesn't really tell you anything about incorrect
> >users. You might be on a low memory system where the request size is
> >sane normally, it just doesn't fit into memory on that particular
> >machine.
> 
> Sorry maybe I'm not fully understand what you meant. User may requested
> a huge size like 3GB on 2GB ram device. But I think that should be rejected
> because it is bigger than the device ram size.

Even totalram_pages/10 can be just unfeasible amount of data to be
allocated without a major disruption. totalram_pages is no measure of
the memory availability.
If you want to have a ballpark estimation then si_mem_available might be
something you are looking for. But I thought the sole purpose of this
patch is to catch obviously buggy callers (like sign overflow lenght
etc) rather than any memory consumption sanity check.

-- 
Michal Hocko
SUSE Labs
