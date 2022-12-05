Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044FA6421B8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 03:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiLEC6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 21:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiLEC6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 21:58:04 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2A79FC2
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 18:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670209083; x=1701745083;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=iIlftp72e7lOy9y0ialET0UyyQONsrRT5Ayg2jLvnxo=;
  b=lI05sv8u4g2rAXZTl1PnnpPuDu5zCWxQHRdgteIHKZ0EmrO9WEDboQtu
   DHer3SshEW9P9D5Ram+1MLBWcvgzJ5s36s3L36VCuBVO0/NIWHUcPmYXE
   w6T7kCxEnV5yU3W6FOb7I741SE278XdFVjm8nbVApIidTYV0sQVO4nVi8
   7s5UwbQ9FOWcxKJipRVzUU3CJIbQ+a+FXv004tHMY/f6ykQCOiukApnHR
   2f3bZrUNyrcsTlHPuz6MYdoc9EDQXeIVMY4b68OMaCCTfgPF/eoI3x8f4
   r+69r3N26dF3RsA8Jjar66QuW627wUpmT8Xz67HwiOUz5hOcEZAgykEZI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="380542211"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="380542211"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 18:58:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="770199000"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="770199000"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 18:57:53 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Wei Xu <weixugc@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, fvdl@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] [mm-unstable] mm: Fix memcg reclaim on memory tiered
 systems
References: <20221203011120.2361610-1-almasrymina@google.com>
        <CAAPL-u_e7-4BT20Z9atTXFgeZSnGXWM2uX0r+2GrBqXk8RmX2Q@mail.gmail.com>
Date:   Mon, 05 Dec 2022 10:57:04 +0800
In-Reply-To: <CAAPL-u_e7-4BT20Z9atTXFgeZSnGXWM2uX0r+2GrBqXk8RmX2Q@mail.gmail.com>
        (Wei Xu's message of "Fri, 2 Dec 2022 20:14:25 -0800")
Message-ID: <87cz8y1rsv.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Xu <weixugc@google.com> writes:

> On Fri, Dec 2, 2022 at 5:11 PM Mina Almasry <almasrymina@google.com> wrote:
>>
>> commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
>> reclaim"") enabled demotion in memcg reclaim, which is the right thing
>> to do, however, I suspect it introduced a regression in the behavior of
>> try_to_free_mem_cgroup_pages().
>>
>> The callers of try_to_free_mem_cgroup_pages() expect it to attempt to
>> reclaim - not demote - nr_pages from the cgroup. I.e. the memory usage
>> of the cgroup should reduce by nr_pages. The callers expect
>> try_to_free_mem_cgroup_pages() to also return the number of pages
>> reclaimed, not demoted.
>>
>> However, what try_to_free_mem_cgroup_pages() actually does is it
>> unconditionally counts demoted pages as reclaimed pages. So in practice
>> when it is called it will often demote nr_pages and return the number of
>> demoted pages to the caller. Demoted pages don't lower the memcg usage,
>> and so I think try_to_free_mem_cgroup_pages() is not actually doing what
>> the callers want it to do.
>>
>> I suspect various things work suboptimally on memory systems or don't
>> work at all due to this:
>>
>> - memory.high enforcement likely doesn't work (it just demotes nr_pages
>>   instead of lowering the memcg usage by nr_pages).
>> - try_charge_memcg() will keep retrying the charge while
>>   try_to_free_mem_cgroup_pages() is just demoting pages and not actually
>>   making any room for the charge.
>> - memory.reclaim has a wonky interface. It advertises to the user it
>>   reclaims the provided amount but it will actually demote that amount.
>>
>> There may be more effects to this issue.
>>
>> To fix these issues I propose shrink_folio_list() to only count pages
>> demoted from inside of sc->nodemask to outside of sc->nodemask as
>> 'reclaimed'.
>>
>> For callers such as reclaim_high() or try_charge_memcg() that set
>> sc->nodemask to NULL, try_to_free_mem_cgroup_pages() will try to
>> actually reclaim nr_pages and return the number of pages reclaimed. No
>> demoted pages would count towards the nr_pages requirement.
>>
>> For callers such as memory_reclaim() that set sc->nodemask,
>> try_to_free_mem_cgroup_pages() will free nr_pages from that nodemask
>> with either reclaim or demotion.
>>
>> Tested this change using memory.reclaim interface. With this change,
>>
>>         echo "1m" > memory.reclaim
>>
>> Will cause freeing of 1m of memory from the cgroup regardless of the
>> demotions happening inside.
>>
>>         echo "1m nodes=0" > memory.reclaim
>>
>> Will cause freeing of 1m of node 0 by demotion if a demotion target is
>> available, and by reclaim if no demotion target is available.
>>
>> Signed-off-by: Mina Almasry <almasrymina@google.com>
>>
>> ---
>>
>> This is developed on top of mm-unstable largely because I need the
>> memory.reclaim nodes= arg to test it properly.
>> ---
>>  mm/vmscan.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 2b42ac9ad755..8f6e993b870d 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1653,6 +1653,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>         LIST_HEAD(free_folios);
>>         LIST_HEAD(demote_folios);
>>         unsigned int nr_reclaimed = 0;
>> +       unsigned int nr_demoted = 0;
>>         unsigned int pgactivate = 0;
>>         bool do_demote_pass;
>>         struct swap_iocb *plug = NULL;
>> @@ -2085,7 +2086,17 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>         /* 'folio_list' is always empty here */
>>
>>         /* Migrate folios selected for demotion */
>> -       nr_reclaimed += demote_folio_list(&demote_folios, pgdat);
>> +       nr_demoted = demote_folio_list(&demote_folios, pgdat);
>> +
>> +       /*
>> +        * Only count demoted folios as reclaimed if we demoted them from
>> +        * inside of the nodemask to outside of the nodemask, hence reclaiming
>> +        * pages in the nodemask.
>> +        */
>> +       if (sc->nodemask && node_isset(pgdat->node_id, *sc->nodemask) &&
>> +           !node_isset(next_demotion_node(pgdat->node_id), *sc->nodemask))
>
> next_demotion_node() is just the first demotion target node. Demotion
> can fall back to other allowed target nodes returned by
> node_get_allowed_targets().  When the page is demoted to a fallback
> node and this fallback node is in sc->nodemask, nr_demoted should not
> be added into nr_reclaimed, either.
>
> One way to address this issue is to pass sc->nodemask into
> demote_folio_list() and exclude sc->nodemask from the allowed target
> demotion nodes.

I don't think this is a good idea.  Because this may break the fast ->
slow -> storage aging order.  A warm page in fast memory node may be
reclaimed to storage directly, instead of being demoted to the slow
memory node.

If necessary, we can account "nr_demoted" in alloc_demote_page() and
to-be-added free_demote_page().

Best Regards,
Huang, Ying

>> +               nr_reclaimed += nr_demoted;
>> +
>>         /* Folios that could not be demoted are still in @demote_folios */
>>         if (!list_empty(&demote_folios)) {
>>                 /* Folios which weren't demoted go back on @folio_list */
>> --
>> 2.39.0.rc0.267.gcb52ba06e7-goog
