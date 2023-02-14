Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C776964D2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjBNNjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjBNNjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:39:03 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3682799D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 05:39:00 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 40C461FDCC;
        Tue, 14 Feb 2023 13:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676381939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fVkDxlzkjhPlGXV60nBdIuB31PjiXgHNSQsXA54F1NI=;
        b=MFsQlHcSHW5ymDxefdZXVg0eNsTKCNHecnlN8mVLZwXtJt/zzSJFIRoUCfuvqHR3d4NbV3
        GkjPC+iWPVTWFJV7r6TmtfaaEA3VvBqAtNZoanOcYBX458i4zEEngB/R8dHcEeHLGob5EH
        DFPk2Xz/iSStQFb5R1nMAoB77QvQUS0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02E11138E3;
        Tue, 14 Feb 2023 13:38:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1PpkO+SO62NXOwAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 14 Feb 2023 13:38:44 +0000
Date:   Tue, 14 Feb 2023 14:38:44 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Qi Zheng <arch0.zheng@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Teng Hu <huteng.ht@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH] mm: page_alloc: don't allocate page from memoryless nodes
Message-ID: <Y+uO5IE7boORqsne@dhcp22.suse.cz>
References: <c6908bd0-5f76-47eb-2b77-ce8f7bf9fbff@suse.cz>
 <eefc40e5-a14b-22c5-3480-6786afa1c8f4@redhat.com>
 <Y+tXrK/g1Nrd/q1h@kernel.org>
 <67240e55-af49-f20a-2b4b-b7d574cd910d@gmail.com>
 <22f0e262-982e-ea80-e52a-a3c924b31d58@redhat.com>
 <dbfbd982-27f3-0d72-49e0-d3dd5fe636a8@bytedance.com>
 <4386151c-0328-d207-9a71-933ef61817f9@redhat.com>
 <Y+t0Bhu7BCzH2Dp4@kernel.org>
 <a7f8be91-32c1-bfbe-7e81-5b1e818ba01d@redhat.com>
 <a09bfe3a-87e4-f8ce-89bb-c5fde8cc33c9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a09bfe3a-87e4-f8ce-89bb-c5fde8cc33c9@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14-02-23 12:58:39, David Hildenbrand wrote:
> On 14.02.23 12:48, David Hildenbrand wrote:
> > On 14.02.23 12:44, Mike Rapoport wrote:
> > > (added x86 folks)
> > > 
> > > On Tue, Feb 14, 2023 at 12:29:42PM +0100, David Hildenbrand wrote:
> > > > On 14.02.23 12:26, Qi Zheng wrote:
> > > > > On 2023/2/14 19:22, David Hildenbrand wrote:
> > > > > > 
> > > > > > TBH, this is the first time I hear of NODE_MIN_SIZE and it seems to be a
> > > > > > pretty x86 specific thing.
> > > > > > 
> > > > > > Are we sure we want to get NODE_MIN_SIZE involved?
> > > > > 
> > > > > Maybe add an arch_xxx() to handle it?
> > > > 
> > > > I still haven't figured out what we want to achieve with NODE_MIN_SIZE at
> > > > all. It smells like an arch-specific hack looking at
> > > > 
> > > > "Don't confuse VM with a node that doesn't have the minimum amount of
> > > > memory"
> > > > 
> > > > Why shouldn't mm-core deal with that?
> > > 
> > > Well, a node with <4M RAM is not very useful and bears all the overhead of
> > > an extra live node.
> > 
> > And totally not with 4.1M, haha.
> > 
> > I really like the "Might fix boot" in the commit description.
> > 
> > > 
> > > But, hey, why won't we just drop that '< NODE_MIN_SIZE' and let people with
> > > weird HW configurations just live with this?
> > 
> > 
> > ;)
> > 
> 
> Actually, remembering 09f49dca570a ("mm: handle uninitialized numa nodes
> gracefully"), this might be the right thing to do. That commit assumes that
> all offline nodes would get the pgdat allocated in free_area_init(). So that
> we end up with an allocated pgdat for all possible nodes. The reasoning IIRC
> was that we don't care about wasting memory in weird VM setups.

Yes, that is the case indeed. I suspect the NODE_MIN_SIZE is a relict of
the past when some PXM entries were incorrect or fishy. I would just
drop the check and see whether something breaks. Or make those involved
back then remember whether this is addressing something that is relevant
these days. Even 5MB node makes (as the memmap is allocated for the
whole memory section anyway and that is 128MB) a very little sense if you ask me.
-- 
Michal Hocko
SUSE Labs
