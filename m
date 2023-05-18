Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4399F707729
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 03:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjERBNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 21:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjERBNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 21:13:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB27D421F
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 18:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684372389; x=1715908389;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=pFd4A2MBW6n8v4ZN7ohmso4i6OszRE3YLaer66HYCrA=;
  b=VqH6haNpLdb/5h2UL/uAon1LoyW7g7ncuItSDWDzLF1sn0KmMcJ1onCT
   Bqw5YmNA9V9FUueRaPM/tTTxo7kOztPcY+Tonhq0GyDq5UMmrcJvQ8/6j
   YfZnjE2Z9Dm1UjfjZbGAVgSFmCqM2r2WAzMGj8X8E+ZEvO+B8jN7jf+kI
   oOU58zuXnVkybqS5XL558CDQ6eQdRMNCBGFLmUIQOFaR28Uy3fmu7Pj+J
   YlcVim/5M6qyuOHMzUkXfvL9yn2+5DUEAW7BeD5ak1CeEDpsBcYe4zdui
   lxdRgvOiy8+2/HC/wW2LzDiMkWyhNY2S+Wnb2HDfkQI+wHFVdhstmkS+p
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="341324964"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="341324964"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 18:13:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="826175640"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="826175640"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 18:13:06 -0700
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
Date:   Thu, 18 May 2023 09:09:20 +0800
In-Reply-To: <c34e3768-8a01-d155-1970-8eada8c80ba7@redhat.com> (David
        Hildenbrand's message of "Wed, 17 May 2023 20:32:51 +0200")
Message-ID: <87sfbubg3j.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> On 17.05.23 18:15, Khalid Aziz wrote:
>> Pages pinned in memory through extra refcounts can not be migrated.
>> Currently as isolate_migratepages_block() scans pages for
>> compaction, it skips any pinned anonymous pages. All non-migratable
>> pages should be skipped and not just the anonymous pinned pages.
>> This patch adds a check for extra refcounts on a page to determine
>> if the page can be migrated.  This was seen as a real issue on a
>> customer workload where a large number of pages were pinned by vfio
>> on the host and any attempts to allocate hugepages resulted in
>> significant amount of cpu time spent in either direct compaction or
>> in kcompactd scanning vfio pinned pages over and over again that can
>> not be migrated.
>
> How will this change affect alloc_contig_range(), such as used for CMA
> allocations or virtio-mem? alloc_contig_range() ends up calling 
> isolate_migratepages_range() -> isolate_migratepages_block().

IIUC, cc->alloc_contig can be used to distinguish contiguous allocation
and compaction.  And, from the original commit which introduced
anonymous pages skipping (commit 119d6d59dcc0 ("mm, compaction: avoid
isolating pinned pages ")) and this patch, large number of migration
failure during compaction causes real issue too.  So, I suggest to use
cc->alloc_contig here.

> We don't want to fail early in case there is a short-term pin that
> might go away any moment after we isolated ... that will make the
> situation worse for these use cases, especially if MIGRATE_CMA or
> ZONE_MOVABLE is involved.

Best Regards,
Huang, Ying
