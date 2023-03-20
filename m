Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DF06C0CDB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjCTJMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjCTJMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:12:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3AD233D7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:12:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61571B80DB2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3EEC433EF;
        Mon, 20 Mar 2023 09:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679303546;
        bh=6rNDRsJJPvw8KCM0VtEHgt3GOmCv1ZQUGOOi9vJhRjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o9Qd7C/kbDEyEwhfVSSXHQHEmjzdnlRMYzZRPNIXfpgU9zYPHVPZGKpji3O4lJePX
         WrN/IgSr5buQi+SL+Xw7M0q1ura4Q3VnChv+0nEBUQjTKCY7bIXn1icdLkbhjXDt6h
         Pkdcd0v2/ntNrwhcqkJYINsB+fLaJuU0c/4giF1DFx7bGwFtQBRXNG0Csmtt0fbxdE
         6jNrnGxhu9Dpi3IW53HxZ5wTX/m0GyRdNpNQqGsQIAhtUSYHZ8APr+WuPvx/pi2ysa
         65ARevYRc/dZ/eHCAD1JENvVw0TYldmlZJpZr8jq/VWnvcU6pab1G2GMSMgxc6QuOY
         1kwhnTsiFlwqg==
Date:   Mon, 20 Mar 2023 11:12:06 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "chenjun (AM)" <chenjun102@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "xuqiang (M)" <xuqiang36@huawei.com>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] mm/slub: Reduce memory consumption in extreme scenarios
Message-ID: <ZBgjZn7WOqO5ruws@kernel.org>
References: <20230314123403.100158-1-chenjun102@huawei.com>
 <0cad1ff3-8339-a3eb-fc36-c8bda1392451@suse.cz>
 <344c7521d72e4107b451c19b329e9864@huawei.com>
 <8c700468-245d-72e9-99e7-b99d4547e6d8@suse.cz>
 <aeb2bd3990004b9eb4f151aa833ddcf2@huawei.com>
 <015855b3-ced3-8d84-e21d-cc6ce112b556@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <015855b3-ced3-8d84-e21d-cc6ce112b556@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 09:05:57AM +0100, Vlastimil Babka wrote:
> On 3/19/23 08:22, chenjun (AM) wrote:
> > 在 2023/3/17 20:06, Vlastimil Babka 写道:
> >> On 3/17/23 12:32, chenjun (AM) wrote:
> >>> 在 2023/3/14 22:41, Vlastimil Babka 写道:
> >>>>>    	pc.flags = gfpflags;
> >>>>> +
> >>>>> +	/*
> >>>>> +	 * when (node != NUMA_NO_NODE) && (gfpflags & __GFP_THISNODE)
> >>>>> +	 * 1) try to get a partial slab from target node with __GFP_THISNODE.
> >>>>> +	 * 2) if 1) failed, try to allocate a new slab from target node with
> >>>>> +	 *    __GFP_THISNODE.
> >>>>> +	 * 3) if 2) failed, retry 1) and 2) without __GFP_THISNODE constraint.
> >>>>> +	 */
> >>>>> +	if (node != NUMA_NO_NODE && !(gfpflags & __GFP_THISNODE) && try_thisnode)
> >>>>> +			pc.flags |= __GFP_THISNODE;
> >>>>
> >>>> Hmm I'm thinking we should also perhaps remove direct reclaim possibilities
> >>>> from the attempt 2). In your qemu test it should make no difference, as it
> >>>> fills everything with kernel memory that is not reclaimable. But in practice
> >>>> the target node might be filled with user memory, and I think it's better to
> >>>> quickly allocate on a different node than spend time in direct reclaim. So
> >>>> the following should work I think?
> >>>>
> >>>> pc.flags = GFP_NOWAIT | __GFP_NOWARN |__GFP_THISNODE
> >>>>
> >>>
> >>> Hmm, Should it be that:
> >>>
> >>> pc.flags |= GFP_NOWAIT | __GFP_NOWARN |__GFP_THISNODE
> >> 
> >> No, we need to ignore the other reclaim-related flags that the caller
> >> passed, or it wouldn't work as intended.
> >> The danger is that we ignore some flag that would be necessary to pass, but
> >> I don't think there's any?
> >> 
> >> 
> > 
> > If we ignore __GFP_ZERO passed by kzalloc， kzalloc will not work.
> > Could we just unmask __GFP_RECLAIMABLE | __GFP_RECLAIM?
> > 
> > pc.flags &= ~(__GFP_RECLAIMABLE | __GFP_RECLAIM)
> > pc.flags |= __GFP_THISNODE
> 
> __GFP_RECLAIMABLE would be wrong, but also ignored as new_slab() does:
> 	flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK)
> 
> which would filter out __GFP_ZERO as well. That's not a problem as kzalloc()
> will zero out the individual allocated objects, so it doesn't matter if we
> don't zero out the whole slab page.
> 
> But I wonder, if we're not past due time for a helper e.g.
> gfp_opportunistic(flags) that would turn any allocation flags to a
> GFP_NOWAIT while keeping the rest of relevant flags intact, and thus there
> would be one canonical way to do it - I'm sure there's a number of places
> with their own variants now?
> With such helper we'd just add __GFP_THISNODE to the result here as that's
> specific to this particular opportunistic allocation.

I like the idea, but maybe gfp_no_reclaim() would be clearer?

-- 
Sincerely yours,
Mike.
