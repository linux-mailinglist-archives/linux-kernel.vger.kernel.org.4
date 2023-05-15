Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20679702B32
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240013AbjEOLOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjEOLO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:14:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DA11725
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 04:14:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 888001F8D7;
        Mon, 15 May 2023 11:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684149266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0wvSqGZQauFmNuobTLgK83+3YhJe93al7FwH3tXa7po=;
        b=iWAWmzdKZmsPabxGe5UA24wp8QY736oyIjouPSU6qVKt8s88OKwFSKeYD5CKXW5hGN1xZP
        WnjIkKf7ZLCvant58JIsOtXluSP6bg8pyIVjGKuNBX0afBbts3XSNN2ILH7OsQ7jax0E6h
        Dxmvyn/vB2YCQQ9G1kyZCJR6sCJpzWo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77E6513466;
        Mon, 15 May 2023 11:14:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QvurHBIUYmRSAgAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 15 May 2023 11:14:26 +0000
Date:   Mon, 15 May 2023 13:14:26 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 0/6] mm: improve page allocator scalability via splitting
 zones
Message-ID: <ZGIUEqhSydAdvRFN@dhcp22.suse.cz>
References: <20230511065607.37407-1-ying.huang@intel.com>
 <ZF0ET82ajDbFrIw/@dhcp22.suse.cz>
 <87r0rm8die.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0rm8die.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 12-05-23 10:55:21, Huang, Ying wrote:
> Hi, Michal,
> 
> Thanks for comments!
> 
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Thu 11-05-23 14:56:01, Huang Ying wrote:
> >> The patchset is based on upstream v6.3.
> >> 
> >> More and more cores are put in one physical CPU (usually one NUMA node
> >> too).  In 2023, one high-end server CPU has 56, 64, or more cores.
> >> Even more cores per physical CPU are planned for future CPUs.  While
> >> all cores in one physical CPU will contend for the page allocation on
> >> one zone in most cases.  This causes heavy zone lock contention in
> >> some workloads.  And the situation will become worse and worse in the
> >> future.
> >> 
> >> For example, on an 2-socket Intel server machine with 224 logical
> >> CPUs, if the kernel is built with `make -j224`, the zone lock
> >> contention cycles% can reach up to about 12.7%.
> >> 
> >> To improve the scalability of the page allocation, in this series, we
> >> will create one zone instance for each about 256 GB memory of a zone
> >> type generally.  That is, one large zone type will be split into
> >> multiple zone instances.  Then, different logical CPUs will prefer
> >> different zone instances based on the logical CPU No.  So the total
> >> number of logical CPUs contend on one zone will be reduced.  Thus the
> >> scalability is improved.
> >
> > It is not really clear to me why you need a new zone for all this rather
> > than partition free lists internally within the zone? Essentially to
> > increase the current two level system to 3: per cpu caches, per cpu
> > arenas and global fallback.
> 
> Sorry, I didn't get your idea here.  What is per cpu arenas?  What's the
> difference between it and per cpu caches (PCP)?

Sorry, I didn't give this much thought than the above. Essentially, we
have 2 level system right now. Pcp caches should reduce the contention
on the per cpu level and that should work reasonably well, if you manage
to align batch sizes to the workload AFAIK. If this is not sufficient
then why to add the full zone rather than to add another level that
caches across a larger than a cpu unit. Maybe a core?

This might be a wrong way around going for this but there is not much
performance analysis about the source of the lock contention so I am
mostly guessing.

> > I am also missing some information why pcp caches tunning is not
> > sufficient.
> 
> PCP does improve the page allocation scalability greatly!  But it
> doesn't help much for workloads that allocating pages on one CPU and
> free them in different CPUs.  PCP tuning can improve the page allocation
> scalability for a workload greatly.  But it's not trivial to find the
> best tuning parameters for various workloads and workload run time
> statuses (workloads may have different loads and memory requirements at
> different time).  And we may run different workloads on different
> logical CPUs of the system.  This also makes it hard to find the best
> PCP tuning globally.

Yes this makes sense. Does that mean that the global pcp tuning is not
keeping up and we need to be able to do more auto-tuning on local bases
rather than global?

> It would be better to find a solution to improve
> the page allocation scalability out of box or automatically.  Do you
> agree?

Yes. 

-- 
Michal Hocko
SUSE Labs
