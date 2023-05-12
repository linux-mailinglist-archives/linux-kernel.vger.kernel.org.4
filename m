Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7606FFF2F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 05:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239797AbjELDJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 23:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjELDJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 23:09:41 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BC32703
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 20:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683860979; x=1715396979;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=+H5lhwYTAVopTLoVpc+HC0bB/XWAei6tlb3WqKdd5x4=;
  b=Cwue8Pqyjb/QM3dHEvj5G8LHINBKiT8sNLp06+dsf9X7HoGnzt8v29Pj
   L8H1RyyBnQCuWGLRvN/0auG4GL2bTPq+hE7MQbFqpnB2CJEz/wTTMCg4k
   OCFDbPJ7CLVvOoADHm/z57pZSEftbQnFySxvMcfuxJq8sNxc/t+r7zHhl
   v7ILgcUDWlI7ShzPJQ2HcgvbiRy6CyNu70ptfFRrHRov1J61WePiepFax
   MVVkf6CueHB47iTy2ObSEj4VMAAIKjA+9792QmFGtpMMkeg6iL8DgXNs2
   7j9a1Lyg4nnP3voSNzsNZhKz6By4ai3XsTsUUnmTMMfWJ4SDzPuXbUDzz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="331055130"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="331055130"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 20:09:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="824209974"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="824209974"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 20:09:35 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        "David Hildenbrand" <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        "Pavel Tatashin" <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 0/6] mm: improve page allocator scalability via splitting
 zones
References: <20230511065607.37407-1-ying.huang@intel.com>
        <e314748f-b4df-c65d-7acc-45c21abf31ce@intel.com>
Date:   Fri, 12 May 2023 11:08:32 +0800
In-Reply-To: <e314748f-b4df-c65d-7acc-45c21abf31ce@intel.com> (Dave Hansen's
        message of "Thu, 11 May 2023 07:23:51 -0700")
Message-ID: <87mt2a8cwf.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dave,

Dave Hansen <dave.hansen@intel.com> writes:

> On 5/10/23 23:56, Huang Ying wrote:
>> To improve the scalability of the page allocation, in this series, we
>> will create one zone instance for each about 256 GB memory of a zone
>> type generally.  That is, one large zone type will be split into
>> multiple zone instances. 
>
> A few anecdotes for why I think _some_ people will like this:
>
> Some Intel hardware has a "RAM" caching mechanism.  It either caches
> DRAM in High-Bandwidth Memory or Persistent Memory in DRAM.  This cache
> is direct-mapped and can have lots of collisions.  One way to prevent
> collisions is to chop up the physical memory into cache-sized zones and
> let users choose to allocate from one zone.  That fixes the conflicts.
>
> Some other Intel hardware a ways to chop a NUMA node representing a
> single socket into slices.  Usually one slice gets a memory controller
> and its closest cores.  Intel calls these approaches Cluster on Die or
> Sub-NUMA Clustering and users can select it from the BIOS.
>
> In both of these cases, users have reported scalability improvements.
> We've gone as far as to suggest the socket-splitting options to folks
> today who are hitting zone scalability issues on that hardware.
>
> That said, those _same_ users sometimes come back and say something
> along the lines of: "So... we've got this app that allocates a big hunk
> of memory.  It's going slower than before."  They're filling up one of
> the chopped-up zones, hitting _some_ kind of undesirable reclaim
> behavior and they want their humpty-dumpty zones put back together again
> ... without hurting scalability.  Some people will never be happy. :)

Thanks a lot for your valuable input!

> Anyway, _if_ you do this, you might also consider being able to
> dynamically adjust a CPU's zonelists somehow.  That would relieve
> pressure on one zone for those uneven allocations.  That wasn't an
> option in the two cases above because users had ulterior motives for
> sticking inside a single zone.  But, in your case, the zones really do
> have equivalent performance.

Yes.  For the requirements you mentioned above, we need a mechanism to
adjust a CPU's zonelists dynamically.  I will not implement that in this
series.  But I think that it's doable based on the multiple zone
instances per zone type implementation in this series.

Best Regards,
Huang, Ying
