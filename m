Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDB064510E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 02:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiLGBX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 20:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLGBX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 20:23:27 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0873C6DD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 17:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670376206; x=1701912206;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=WVlevJAAvUHI6+70tiF2I2mN3+Cpcrc2mvg4fmmFWMw=;
  b=aqWNQitEeq2JhPDdpuYB1Ima1T2sWy5OpX6gRcEwbspeVtXo1V9jwLWq
   0zHYaVhOuSrgiQ7g79Xrjjy/HIEaW/gtbNMmM6iL90JKaUobktiQZ1pUj
   RvP1G8Dv8CWtN5BwNRWl211WEj6uvpaSmlhvP7e4FAyEZQl2ZAijLSNdV
   BtpZMc+mT4+elVRT5ZTr1/Y7rW1BbcsawSt+ycfBbTLoEIutXxOgfOIU0
   nfut1AjtEeSGuGUBkGxsjRX+zRwp1TgbxiQgGOAOx6TaAsI1rtHA283Ot
   Dl9pMrG4FDE8mCw3Mc8QzZ78odz1IqEO9Trv1bMxj+llb8piRubWYCrZ7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="317919211"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="317919211"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 17:23:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="709880911"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="709880911"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 17:23:23 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] [mm-unstable] mm: Fix memcg reclaim on memory tiered
 systems
References: <20221206023406.3182800-1-almasrymina@google.com>
        <Y48zlaimOb/wr8qd@dhcp22.suse.cz>
        <CAHS8izMKz_JtN-P7BTHydE2x2rmSg5-JRoHgaDCdCHV-S0YLJw@mail.gmail.com>
        <Y4+eLyl8HQNZS5ot@dhcp22.suse.cz>
Date:   Wed, 07 Dec 2022 09:22:25 +0800
In-Reply-To: <Y4+eLyl8HQNZS5ot@dhcp22.suse.cz> (Michal Hocko's message of
        "Tue, 6 Dec 2022 20:55:27 +0100")
Message-ID: <875yeo80tq.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Tue 06-12-22 08:06:51, Mina Almasry wrote:
>> On Tue, Dec 6, 2022 at 4:20 AM Michal Hocko <mhocko@suse.com> wrote:
>> >
>> > On Mon 05-12-22 18:34:05, Mina Almasry wrote:
>> > > commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
>> > > reclaim"") enabled demotion in memcg reclaim, which is the right thing
>> > > to do, however, it introduced a regression in the behavior of
>> > > try_to_free_mem_cgroup_pages().
>> > >
>> > > The callers of try_to_free_mem_cgroup_pages() expect it to attempt to
>> > > reclaim - not demote - nr_pages from the cgroup. I.e. the memory usage
>> > > of the cgroup should reduce by nr_pages. The callers expect
>> > > try_to_free_mem_cgroup_pages() to also return the number of pages
>> > > reclaimed, not demoted.
>> > >
>> > > However, what try_to_free_mem_cgroup_pages() actually does is it
>> > > unconditionally counts demoted pages as reclaimed pages. So in practice
>> > > when it is called it will often demote nr_pages and return the number of
>> > > demoted pages to the caller. Demoted pages don't lower the memcg usage,
>> > > and so try_to_free_mem_cgroup_pages() is not actually doing what the
>> > > callers want it to do.
>> > >
>> > > Various things work suboptimally on memory tiered systems or don't work
>> > > at all due to this:
>> > >
>> > > - memory.high enforcement likely doesn't work (it just demotes nr_pages
>> > >   instead of lowering the memcg usage by nr_pages).
>> > > - try_charge_memcg() will keep retrying the charge while
>> > >   try_to_free_mem_cgroup_pages() is just demoting pages and not actually
>> > >   making any room for the charge.
>> >
>> > This has been brought up during the review https://lore.kernel.org/all/YoYTEDD+c4GT0xYY@dhcp22.suse.cz/
>> >
>> 
>> Ah, I did indeed miss this. Thanks for the pointer. However I don't
>> understand this bit from your email (sorry I'm probably missing
>> something):
>> 
>> "I suspect this is rather unlikely situation, though. The last tear
>> (without any fallback) should have some memory to reclaim most of
>> the time."
>> 
>> Reading the code in try_charge_memcg(), I don't see the last retry for
>> try_to_free_mem_cgroup_pages() do anything special. My concern here is
>> that try_charge_memcg() calls try_to_free_mem_cgroup_pages()
>> MAX_RECLAIM_RETRIES times. Each time that call may demote pages and
>> report back that it was able to 'reclaim' memory, but the charge keeps
>> failing because the memcg reclaim didn't actually make room for the
>> charge. What happens in this case? My understanding is that the memcg
>> oom-killer gets wrongly invoked.
>
> The memcg reclaim shrinks from all zones in the allowed zonelist. In
> general from all nodes. So unless the lower tier is outside of this
> zonelist then there is a zone to reclaim from which cannot demote.
> Correct?
>
>> > > - memory.reclaim has a wonky interface. It advertises to the user it
>> > >   reclaims the provided amount but it will actually often demote that
>> > >   amount.
>> > >
>> > > There may be more effects to this issue.
>> > >
>> > > To fix these issues I propose shrink_folio_list() to only count pages
>> > > demoted from inside of sc->nodemask to outside of sc->nodemask as
>> > > 'reclaimed'.
>> >
>> > Could you expand on why the node mask matters? From the charge point of
>> > view it should be completely uninteresting as the charge remains.
>> >
>> > I suspect we really need to change to reclaim metrics for memcg reclaim.
>> > In the memory balancing reclaim we can indeed consider demotions as a
>> > reclaim because the memory is freed in the end but for the memcg reclaim
>> > we really should be counting discharges instead. No demotion/migration will
>> > free up charges.
>> 
>> I think what you're describing is exactly what this patch aims to do.
>> I'm proposing an interface change to shrink_folio_list() such that it
>> only counts demoted pages as reclaimed iff sc->nodemask is provided by
>> the caller and the demotion removed pages from inside sc->nodemask to
>> outside sc->nodemask. In this case:
>> 
>> 1. memory balancing reclaim would pass sc->nodemask=nid to
>> shrink_folio_list() indicating that it should count pages demoted from
>> sc->nodemask as reclaimed.
>> 
>> 2. memcg reclaim would pass sc->nodemask=NULL to shrink_folio_list()
>> indicating that it is looking for reclaim across all nodes and no
>> demoted pages should count as reclaimed.
>> 
>> Sorry if the commit message was not clear. I can try making it clearer
>> in the next version but it's already very long.
>
> Either I am missing something or I simply do not understand why you are
> hooked into nodemask so much. Why cannot we have a simple rule that
> only global reclaim considers demotions as nr_reclaimed?

Yes.  This sounds reasonable to me and this simplify the logic greatly!

Best Regards,
Huang, Ying

