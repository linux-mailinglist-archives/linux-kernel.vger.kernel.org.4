Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7721C64D645
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 06:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiLOFvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 00:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiLOFvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 00:51:17 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EAF2B1A3;
        Wed, 14 Dec 2022 21:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671083476; x=1702619476;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=Vy1nnsBUMyfJdWB0HL7AxX9ZAnGiu08F+Oqh6ALowk0=;
  b=Y0f6k6Ob/PVLCF7ZV8Cn8u4/Y1FeG0TEP0ks29g7L98rs+pRQZAf2s8Y
   isvFerH0xEt7LpCCtQhIKfSkyOdnMtCjlSHnRlo9UAz+pD7ppom6yf6tx
   yJUrPh6QisJo/160AOUnw6Tae0JrP7H/8dunmntoAiruoKWdUyfidhzaV
   M4TvNwcONIR0ApnfGb32+Cv61rkwDp4Sn9Dp/jPVVpgsOb/dyDU39luec
   KaL+8l1IDb4V7QdvHHbmMVQ86EFqb1GvypxhYFb/OzC3RxbJTILNta/qi
   WRVbKIgyUiYrEcQXV2UW/5l4BN2RpDoJcaewaKWR1DrIEYeJITWO/YO1E
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="320448563"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="320448563"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 21:51:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="978080190"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="978080190"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 21:51:10 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, bagasdotme@gmail.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3] mm: Add nodes= arg to memory.reclaim
References: <20221202223533.1785418-1-almasrymina@google.com>
        <Y5bsmpCyeryu3Zz1@dhcp22.suse.cz>
        <CAHS8izM-XdLgFrQ1k13X-4YrK=JGayRXV_G3c3Qh4NLKP7cH_g@mail.gmail.com>
        <87k02volwe.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y5h+gHBneexFQcR3@cmpxchg.org> <Y5iGJ/9PMmSCwqLj@dhcp22.suse.cz>
        <CAHS8izOuT_-p-N1xPApi+BPJQ+P--2YVSUeiWBROGvGinN0vcg@mail.gmail.com>
        <Y5mkJL6I5Zlc1k97@dhcp22.suse.cz>
Date:   Thu, 15 Dec 2022 13:50:14 +0800
In-Reply-To: <Y5mkJL6I5Zlc1k97@dhcp22.suse.cz> (Michal Hocko's message of
        "Wed, 14 Dec 2022 11:23:32 +0100")
Message-ID: <87mt7pdxm1.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Michal Hocko <mhocko@suse.com> writes:

> On Tue 13-12-22 11:29:45, Mina Almasry wrote:
>> On Tue, Dec 13, 2022 at 6:03 AM Michal Hocko <mhocko@suse.com> wrote:
>> >
>> > On Tue 13-12-22 14:30:40, Johannes Weiner wrote:
>> > > On Tue, Dec 13, 2022 at 02:30:57PM +0800, Huang, Ying wrote:
>> > [...]
>> > > > After these discussion, I think the solution maybe use different
>> > > > interfaces for "proactive demote" and "proactive reclaim".  That is,
>> > > > reconsider "memory.demote".  In this way, we will always uncharge the
>> > > > cgroup for "memory.reclaim".  This avoid the possible confusion there.
>> > > > And, because demotion is considered aging, we don't need to disable
>> > > > demotion for "memory.reclaim", just don't count it.
>> > >
>> > > Hm, so in summary:
>> > >
>> > > 1) memory.reclaim would demote and reclaim like today, but it would
>> > >    change to only count reclaimed pages against the goal.
>> > >
>> > > 2) memory.demote would only demote.
>> > >
>> 
>> If the above 2 points are agreeable then yes, this sounds good to me
>> and does address our use case.
>> 
>> > >    a) What if the demotion targets are full? Would it reclaim or fail?
>> > >
>> 
>> Wei will chime in if he disagrees, but I think we _require_ that it
>> fails, not falls back to reclaim. The interface is asking for
>> demotion, and is called memory.demote. For such an interface to fall
>> back to reclaim would be very confusing to userspace and may trigger
>> reclaim on a high priority job that we want to shield from proactive
>> reclaim.
>
> But what should happen if the immediate demotion target is full but
> lower tiers are still usable. Should the first one demote before
> allowing to demote from the top tier?
>  
>> > > 3) Would memory.reclaim and memory.demote still need nodemasks?
>> 
>> memory.demote will need a nodemask, for sure. Today the nodemask would
>> be useful if there is a specific node in the top tier that is
>> overloaded and we want to reduce the pressure by demoting. In the
>> future there will be N tiers and the nodemask says which tier to
>> demote from.
>
> OK, so what is the exact semantic of the node mask. Does it control
> where to demote from or to or both?
>
>> I don't think memory.reclaim would need a nodemask anymore? At least I
>> no longer see the use for it for us.
>> 
>> > >    Would
>> > >    they return -EINVAL if a) memory.reclaim gets passed only toptier
>> > >    nodes or b) memory.demote gets passed any lasttier nodes?
>> >
>> 
>> Honestly it would be great if memory.reclaim can force reclaim from a
>> top tier nodes. It breaks the aginig pipeline, yes, but if the user is
>> specifically asking for that because they decided in their usecase
>> it's a good idea then the kernel should comply IMO. Not a strict
>> requirement for us. Wei will chime in if he disagrees.
>
> That would require a nodemask to say which nodes to reclaim, no? The
> default behavior should be in line with what standard memory reclaim
> does. If the demotion is a part of that process so should be
> memory.reclaim part of it. If we want to have a finer control then a
> nodemask is really a must and then the nodemaks should constrain both
> agining and reclaim.
>
>> memory.demote returning -EINVAL for lasttier nodes makes sense to me.
>> 
>> > I would also add
>> > 4) Do we want to allow to control the demotion path (e.g. which node to
>> >    demote from and to) and how to achieve that?
>> 
>> We care deeply about specifying which node to demote _from_. That
>> would be some node that is approaching pressure and we're looking for
>> proactive saving from. So far I haven't seen any reason to control
>> which nodes to demote _to_. The kernel deciding that based on the
>> aging pipeline and the node distances sounds good to me. Obviously
>> someone else may find that useful.
>
> Please keep in mind that the interface should be really prepared for
> future extensions so try to abstract from your immediate usecases.

I see two requirements here, one is to control the demotion source, that
is, which nodes to free memory.  The other is to control the demotion
path.  I think that we can use two different parameters for them, for
example, "from=<demotion source nodes>" and "to=<demotion target
nodes>".  In most cases we don't need to control the demotion path.
Because in current implementation, the nodes in the lower tiers in the
same socket (local nodes) will be preferred.  I think that this is
the desired behavior in most cases.

>> > 5) Is the demotion api restricted to multi-tier systems or any numa
>> >    configuration allowed as well?
>> >
>> 
>> demotion will of course not work on single tiered systems. The
>> interface may return some failure on such systems or not be available
>> at all.
>
> Is there any strong reason for that? We do not have any interface to
> control NUMA balancing from userspace. Why cannot we use the interface
> for that purpose? 

Do you mean to demote the cold pages from the specified source nodes to
the specified target nodes in different sockets?  We don't do that to
avoid loop in the demotion path.  If we prevent the target nodes from
demoting cold pages to the source nodes at the same time, it seems
doable.

Best Regards,
Huang, Ying
