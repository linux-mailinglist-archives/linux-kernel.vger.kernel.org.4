Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B776FF407
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbjEKOYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238302AbjEKOXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:23:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1C6106C5
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683815032; x=1715351032;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=be2GtGpChjQC18AL8KYB2LRliaSADqMrGVcS9L1D0U0=;
  b=jMJAJCq08UDR8v89x8za9VfXRvm7x7NewOJt1mVYc9f19Q6QBKZPANcJ
   KT94H8pNP1D3phOoA0z+MZ4bWHZ9y4cLMa2c/Nq501dMAgpEIxVD5YZw6
   je6J/+UmcE/Vu26AH2MNa1SYN+BPeIBwAQi2mvd+G+/zE+7Fm0TFruNT4
   QPVD3geCRnv/2Kir/8VJ4f/qXXkIWQg6B9oARcWNM5d2Jgo44thyBABKS
   h6QF8xp2ohyn/GboX/DizUk0evVnfbzLKkjszc0BYAWyRViTmHQ80QvZ9
   40vqHS9wBYn+mkSwJEF07iz3WKhNwGoesy1R6QnHSxAFDyjcWLC3XPJUN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="349352185"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="349352185"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 07:23:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="769349575"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="769349575"
Received: from ambujamp-mobl1.amr.corp.intel.com (HELO [10.212.238.119]) ([10.212.238.119])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 07:23:51 -0700
Message-ID: <e314748f-b4df-c65d-7acc-45c21abf31ce@intel.com>
Date:   Thu, 11 May 2023 07:23:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC 0/6] mm: improve page allocator scalability via splitting
 zones
Content-Language: en-US
To:     Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20230511065607.37407-1-ying.huang@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230511065607.37407-1-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/23 23:56, Huang Ying wrote:
> To improve the scalability of the page allocation, in this series, we
> will create one zone instance for each about 256 GB memory of a zone
> type generally.  That is, one large zone type will be split into
> multiple zone instances. 

A few anecdotes for why I think _some_ people will like this:

Some Intel hardware has a "RAM" caching mechanism.  It either caches
DRAM in High-Bandwidth Memory or Persistent Memory in DRAM.  This cache
is direct-mapped and can have lots of collisions.  One way to prevent
collisions is to chop up the physical memory into cache-sized zones and
let users choose to allocate from one zone.  That fixes the conflicts.

Some other Intel hardware a ways to chop a NUMA node representing a
single socket into slices.  Usually one slice gets a memory controller
and its closest cores.  Intel calls these approaches Cluster on Die or
Sub-NUMA Clustering and users can select it from the BIOS.

In both of these cases, users have reported scalability improvements.
We've gone as far as to suggest the socket-splitting options to folks
today who are hitting zone scalability issues on that hardware.

That said, those _same_ users sometimes come back and say something
along the lines of: "So... we've got this app that allocates a big hunk
of memory.  It's going slower than before."  They're filling up one of
the chopped-up zones, hitting _some_ kind of undesirable reclaim
behavior and they want their humpty-dumpty zones put back together again
... without hurting scalability.  Some people will never be happy. :)

Anyway, _if_ you do this, you might also consider being able to
dynamically adjust a CPU's zonelists somehow.  That would relieve
pressure on one zone for those uneven allocations.  That wasn't an
option in the two cases above because users had ulterior motives for
sticking inside a single zone.  But, in your case, the zones really do
have equivalent performance.
