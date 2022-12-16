Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57B664E64C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 04:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiLPDS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 22:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiLPDSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 22:18:08 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D945FB93
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 19:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671160637; x=1702696637;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=V7nMACfvQKW9NVbyjcAlrDxmwIs/5qIqkQZBaVPjfTQ=;
  b=LH0DTbnhIGesmPMNYGB7xKH/WOAs5N1HpL4LCAkw67S69n8VwKB6JZmW
   sy8cI0Y//XupcIVyqUGb9CNd5cJFGLyATlBa1Dfx++ctZWFmlcEYcT9/D
   TbZTIkYpPv4q6fEwWTYOAls1g/ptNVD1MsnUoOn0oNUaMOxchmzRghJp6
   DsJzPx+QE/SHl0MIz1I1t79/Mtl5rStHHNCbgBihcWTmc67OhTjQzuzll
   FTQsRa5EhmOnAZ5d357+zgyj6CRLCUTJm5yrk02pSPjiWkYTOGNW+iOeq
   CIfyM8/fN70PF7xgEa0/Y58Uv9kRfr+4UUg4tbzhQ5KKPCuhm5t2ImM9y
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="299209615"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="299209615"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 19:17:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="713147851"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="713147851"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 19:17:14 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Yang Shi <shy828301@gmail.com>, Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: memcg reclaim demotion wrt. isolation
References: <Y5idFucjKVbjatqc@dhcp22.suse.cz> <Y5ik+CCmvapf87Mb@cmpxchg.org>
        <Y5maoIUuH79KrfJt@dhcp22.suse.cz>
        <87edt1dwd2.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y5rZSRxcgQzQQVbS@cmpxchg.org>
Date:   Fri, 16 Dec 2022 11:16:26 +0800
In-Reply-To: <Y5rZSRxcgQzQQVbS@cmpxchg.org> (Johannes Weiner's message of
        "Thu, 15 Dec 2022 09:22:33 +0100")
Message-ID: <877cys9gxh.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Johannes Weiner <hannes@cmpxchg.org> writes:

> On Thu, Dec 15, 2022 at 02:17:13PM +0800, Huang, Ying wrote:
>> Michal Hocko <mhocko@suse.com> writes:
>> 
>> > On Tue 13-12-22 17:14:48, Johannes Weiner wrote:
>> >> On Tue, Dec 13, 2022 at 04:41:10PM +0100, Michal Hocko wrote:
>> >> > Hi,
>> >> > I have just noticed that that pages allocated for demotion targets
>> >> > includes __GFP_KSWAPD_RECLAIM (through GFP_NOWAIT). This is the case
>> >> > since the code has been introduced by 26aa2d199d6f ("mm/migrate: demote
>> >> > pages during reclaim"). I suspect the intention is to trigger the aging
>> >> > on the fallback node and either drop or further demote oldest pages.
>> >> > 
>> >> > This makes sense but I suspect that this wasn't intended also for
>> >> > memcg triggered reclaim. This would mean that a memory pressure in one
>> >> > hierarchy could trigger paging out pages of a different hierarchy if the
>> >> > demotion target is close to full.
>> >> 
>> >> This is also true if you don't do demotion. If a cgroup tries to
>> >> allocate memory on a full node (i.e. mbind()), it may wake kswapd or
>> >> enter global reclaim directly which may push out the memory of other
>> >> cgroups, regardless of the respective cgroup limits.
>> >
>> > You are right on this. But this is describing a slightly different
>> > situaton IMO. 
>> >
>> >> The demotion allocations don't strike me as any different. They're
>> >> just allocations on behalf of a cgroup. I would expect them to wake
>> >> kswapd and reclaim physical memory as needed.
>> >
>> > I am not sure this is an expected behavior. Consider the currently
>> > discussed memory.demote interface when the userspace can trigger
>> > (almost) arbitrary demotions. This can deplete fallback nodes without
>> > over-committing the memory overall yet push out demoted memory from
>> > other workloads. From the user POV it would look like a reclaim while
>> > the overall memory is far from depleted so it would be considered as
>> > premature and a warrant a bug report.
>> >
>> > The reclaim behavior would make more sense to me if it was constrained
>> > to the allocating memcg hierarchy so unrelated lruvecs wouldn't be
>> > disrupted.
>> 
>> When we reclaim/demote some pages from a memcg proactively, what is our
>> goal?  To free up some memory in this memcg for other memcgs to use?  If
>> so, it sounds reasonable to keep the pages of other memcgs as many as
>> possible.
>
> The goal of proactive aging is to free up any resources that aren't
> needed to meet the SLAs (e.g. end-to-end response time of webserver).
> Meaning, to run things as leanly as possible within spec. Into that
> free space, another container can then be co-located.
>
> This means that the goal is to free up as many resources as possible,
> starting with the coveted hightier. If a container has been using
> all-hightier memory but is able demote to lowtier, there are 3 options
> for existing memory in the lower tier:
>
> 1) Colder/stale memory - should be displaced
>
> 2) Memory that can be promoted once the hightier is free -
>    reclaim/demotion of the coldest pages needs to happen at least
>    temporarily, or the tierswap is in stale mate.
>
> 3) Equally hot memory - if this exceeds capacity of the lower tier,
>    the hottest overall pages should stay, the excess demoted/reclaimed.
>
> You can't know what scenario you're in until you put the demoted pages
> in direct LRU competition with what's already there. And in all three
> scenarios, direct LRU competition also produces the optimal outcome.

If my understanding were correct, your preferred semantics is to be memcg
specific in the higher tier, and global in the lower tier.

Another choice is to add another global "memory.reclaim" knob, for
example, as /sys/devices/virtual/memory_tiering/memory_tier<N>/memory.reclaim ?
Then we can trigger global memory reclaim in lower tiers firstly.  Then
trigger memcg specific memory reclaim in higher tier for the specified
memcg.

The cons of this choice is that you need 2 steps to finish the work.
The pros is that you don't need to combine memcg-specific and global
behavior in one interface.

Best Regards,
Huang, Ying
