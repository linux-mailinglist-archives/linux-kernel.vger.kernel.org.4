Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43825ED839
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbiI1IuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbiI1Itc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:49:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E709923EE
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664354969; x=1695890969;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=qKQIq21NKAdBYO/NiB/2nQyRgzRAJfVSm/FkW9deYnM=;
  b=Fj6tWnUQ1azOeFnGE2TCSb30lXjvvC+i2BA/WsZzmCjW0jq3x1dfwdmc
   s7V5aTfBb4v6135CS4KFUNcabmk2JFiR0hyFqqPwOZjYGyvw+pT7ss6Dp
   yOxbKPdAwMnStepxY8rJ73gpTCElQc4y7Okj+eBZ+nYzwip12ZGI1Ue95
   JU1Q3yqRLyOrxmyweI7qWkJ1EwIOgzmgFAwxOJ3PP6L/CHl/7oq4oVmOc
   ec54fkYDy+bBBLjqBkE8H173UgGbgjL/r7N0FjANzfRraQvPTSzsXAnC1
   Ov6XAQTq+jd/8ZAnj9VTzh11n9V3ahGTtJ6L0BKCO0nqK5ZOPM2TY1Z9T
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="302457560"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="302457560"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 01:49:29 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="655051213"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="655051213"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 01:49:27 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     <alexlzhu@fb.com>
Cc:     <linux-mm@kvack.org>, <willy@infradead.org>,
        <akpm@linux-foundation.org>, <riel@surriel.com>,
        <hannes@cmpxchg.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH 2/3] mm: changes to split_huge_page() to free zero
 filled tail pages
References: <cover.1664347167.git.alexlzhu@fb.com>
        <94de34378bb748196e7709205a75331569d1d28e.1664347167.git.alexlzhu@fb.com>
Date:   Wed, 28 Sep 2022 16:48:40 +0800
In-Reply-To: <94de34378bb748196e7709205a75331569d1d28e.1664347167.git.alexlzhu@fb.com>
        (alexlzhu@fb.com's message of "Tue, 27 Sep 2022 23:44:12 -0700")
Message-ID: <87v8p728bb.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<alexlzhu@fb.com> writes:

> From: Alexander Zhu <alexlzhu@fb.com>
>
> Currently, when /sys/kernel/mm/transparent_hugepage/enabled=always is set
> there are a large number of transparent hugepages that are almost entirely
> zero filled.  This is mentioned in a number of previous patchsets
> including:
> https://lore.kernel.org/all/20210731063938.1391602-1-yuzhao@google.com/
> https://lore.kernel.org/all/
> 1635422215-99394-1-git-send-email-ningzhang@linux.alibaba.com/
>
> Currently, split_huge_page() does not have a way to identify zero filled
> pages within the THP. Thus these zero pages get remapped and continue to
> create memory waste. In this patch, we identify and free tail pages that
> are zero filled in split_huge_page(). In this way, we avoid mapping these
> pages back into page table entries and can free up unused memory within
> THPs. This is based off the previously mentioned patchset by Yu Zhao.
> However, we chose to free anonymous zero tail pages whenever they are
> encountered instead of only on reclaim or migration.
>
> We also add self tests to verify the RssAnon value to make sure zero
> pages are not remapped except in the case of userfaultfd. In the case
> of userfaultfd we remap to the shared zero page, similar to what is
> done by KSM.
>
> Signed-off-by: Alexander Zhu <alexlzhu@fb.com>
> ---
>  include/linux/rmap.h                          |   2 +-
>  include/linux/vm_event_item.h                 |   3 +
>  mm/huge_memory.c                              |  44 ++++++-
>  mm/migrate.c                                  |  72 +++++++++--
>  mm/migrate_device.c                           |   4 +-
>  mm/vmstat.c                                   |   3 +
>  .../selftests/vm/split_huge_page_test.c       | 113 +++++++++++++++++-
>  tools/testing/selftests/vm/vm_util.c          |  23 ++++
>  tools/testing/selftests/vm/vm_util.h          |   1 +
>  9 files changed, 250 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index b89b4b86951f..f7d5d5639dea 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -372,7 +372,7 @@ int folio_mkclean(struct folio *);
>  int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
>  		      struct vm_area_struct *vma);
>  
> -void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked);
> +void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked, bool unmap_clean);

There are 2 bool parameters now.  How about use "flags" style
parameters?  IMHO, well defined constants are more readable than a set
of true/false.

Best Regards,
Huang, Ying

[snip]
