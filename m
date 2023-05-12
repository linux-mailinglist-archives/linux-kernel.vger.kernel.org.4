Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1C56FFF1B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 04:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239793AbjELC4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 22:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjELC4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 22:56:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B891E63
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 19:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683860195; x=1715396195;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=JQwFcMEcOc46Dt/Yt7xAWILwrd7bAWYMMUprblli39I=;
  b=dBqqFJCPCZOZvo7zqf9hoZdmDJl+Voc9Y9kdjTjinK2gAdgpWmFMOPtV
   piVNPhtuyTL/c0mXu6yaDLfDpIsvTu18JrJBMU3aNjFiUeSwKyWRNiPnb
   tvb2dH8oqidY0NUNQ3PVoys2h+T0jY+bqDME6lzUpmnU813ntWGJxFjTl
   n256NBFe4Xd8Mc8TArfj8AVuMY0IfYO7UFehC+M7vqBjIpHYJ5eB3H11s
   wefSA5CJ7aluIViV1YErYBQL4vcZK1wJiPSsfKjZHlsREnPw4xcpLHj9P
   YqfB1af9IeVKAMJbR+masvOEkzB9oWoxr2n5IghvRdZ25ddvAeAbsDpjG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="339996970"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="339996970"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 19:56:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="811888990"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="811888990"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 19:56:31 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
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
References: <20230511065607.37407-1-ying.huang@intel.com>
        <ZF0ET82ajDbFrIw/@dhcp22.suse.cz>
Date:   Fri, 12 May 2023 10:55:21 +0800
In-Reply-To: <ZF0ET82ajDbFrIw/@dhcp22.suse.cz> (Michal Hocko's message of
        "Thu, 11 May 2023 17:05:51 +0200")
Message-ID: <87r0rm8die.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Michal,

Thanks for comments!

Michal Hocko <mhocko@suse.com> writes:

> On Thu 11-05-23 14:56:01, Huang Ying wrote:
>> The patchset is based on upstream v6.3.
>> 
>> More and more cores are put in one physical CPU (usually one NUMA node
>> too).  In 2023, one high-end server CPU has 56, 64, or more cores.
>> Even more cores per physical CPU are planned for future CPUs.  While
>> all cores in one physical CPU will contend for the page allocation on
>> one zone in most cases.  This causes heavy zone lock contention in
>> some workloads.  And the situation will become worse and worse in the
>> future.
>> 
>> For example, on an 2-socket Intel server machine with 224 logical
>> CPUs, if the kernel is built with `make -j224`, the zone lock
>> contention cycles% can reach up to about 12.7%.
>> 
>> To improve the scalability of the page allocation, in this series, we
>> will create one zone instance for each about 256 GB memory of a zone
>> type generally.  That is, one large zone type will be split into
>> multiple zone instances.  Then, different logical CPUs will prefer
>> different zone instances based on the logical CPU No.  So the total
>> number of logical CPUs contend on one zone will be reduced.  Thus the
>> scalability is improved.
>
> It is not really clear to me why you need a new zone for all this rather
> than partition free lists internally within the zone? Essentially to
> increase the current two level system to 3: per cpu caches, per cpu
> arenas and global fallback.

Sorry, I didn't get your idea here.  What is per cpu arenas?  What's the
difference between it and per cpu caches (PCP)?

> I am also missing some information why pcp caches tunning is not
> sufficient.

PCP does improve the page allocation scalability greatly!  But it
doesn't help much for workloads that allocating pages on one CPU and
free them in different CPUs.  PCP tuning can improve the page allocation
scalability for a workload greatly.  But it's not trivial to find the
best tuning parameters for various workloads and workload run time
statuses (workloads may have different loads and memory requirements at
different time).  And we may run different workloads on different
logical CPUs of the system.  This also makes it hard to find the best
PCP tuning globally.  It would be better to find a solution to improve
the page allocation scalability out of box or automatically.  Do you
agree?

Best Regards,
Huang, Ying
