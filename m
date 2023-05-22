Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA4D70B4B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjEVF5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjEVF5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:57:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC34CE
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684735031; x=1716271031;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=tOMcNfhocZCO/GNSExZGCChK9wg74/hawJud+TAllGI=;
  b=QvE3N5b0AYeUi044/e9D+WiQIse6wqArQwLEDu5cZuSt44lF08TfN5ON
   /jny0IODGEv4vFapup+SEw0U9jEBLiqL9tg9TFJG2m20hd48o4i0bbO9r
   IhK5lZFterW3Bw8qqghNh8a/4YSje0oc22QDiIOue3PEoXc1983pA7AT4
   u62lV1rLVn3qkYOc0yQN6QMX9Z5b1kK+Uz2CP7U6/kb3gDcDqH7mT4dRx
   fxR89ow8PcFftnSB18DmXo+aYTgUyShtjo4DrFaM/7GZuu1hxtzOipi3q
   meCktHUxJC0zmJ0eK1IdRvrelqxI9fa+Cstx1PwoqsnA5YSxESvtrqfmx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="332439331"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="332439331"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 22:57:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="736286283"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="736286283"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 22:57:08 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
        willy@infradead.org, steven.sistare@oracle.com,
        mgorman@techsingularity.net, khalid@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm, compaction: Skip all non-migratable pages during
 scan
References: <20230517161555.84776-1-khalid.aziz@oracle.com>
        <c34e3768-8a01-d155-1970-8eada8c80ba7@redhat.com>
        <87sfbubg3j.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <5f43a17c-94a0-4bff-b451-e5014de36ed9@redhat.com>
Date:   Mon, 22 May 2023 13:55:51 +0800
In-Reply-To: <5f43a17c-94a0-4bff-b451-e5014de36ed9@redhat.com> (David
        Hildenbrand's message of "Fri, 19 May 2023 11:51:00 +0200")
Message-ID: <875y8k3o60.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> On 18.05.23 03:09, Huang, Ying wrote:
>> David Hildenbrand <david@redhat.com> writes:
>> 
>>> On 17.05.23 18:15, Khalid Aziz wrote:
>>>> Pages pinned in memory through extra refcounts can not be migrated.
>>>> Currently as isolate_migratepages_block() scans pages for
>>>> compaction, it skips any pinned anonymous pages. All non-migratable
>>>> pages should be skipped and not just the anonymous pinned pages.
>>>> This patch adds a check for extra refcounts on a page to determine
>>>> if the page can be migrated.  This was seen as a real issue on a
>>>> customer workload where a large number of pages were pinned by vfio
>>>> on the host and any attempts to allocate hugepages resulted in
>>>> significant amount of cpu time spent in either direct compaction or
>>>> in kcompactd scanning vfio pinned pages over and over again that can
>>>> not be migrated.
>>>
>>> How will this change affect alloc_contig_range(), such as used for CMA
>>> allocations or virtio-mem? alloc_contig_range() ends up calling
>>> isolate_migratepages_range() -> isolate_migratepages_block().
>> IIUC, cc->alloc_contig can be used to distinguish contiguous
>> allocation
>> and compaction.  And, from the original commit which introduced
>> anonymous pages skipping (commit 119d6d59dcc0 ("mm, compaction: avoid
>> isolating pinned pages ")) and this patch, large number of migration
>> failure during compaction causes real issue too.  So, I suggest to use
>> cc->alloc_contig here.
>
> Agreed. I further wonder if we want to special-case the !alloc_contig
> case also for MIGRATE_CMA and ZONE_MOVABLE, where we cannot have 
> longterm page pinnings (e.g., vfio pinned pages).

This makes sense.  The skipping is more accurate in this way.

Best Regards,
Huang, Ying
