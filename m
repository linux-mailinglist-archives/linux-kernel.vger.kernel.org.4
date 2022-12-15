Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751B664D664
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiLOGSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLOGSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:18:05 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC60264AB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671085084; x=1702621084;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=zzdErWsHXDwGOYfP5lOS1dk1HI5wjgZ5Uqew68m/uCc=;
  b=f1+R3deV82BxLg/jfRIIiUgUQgxeypu2uA1Zhmn1wNxrTUm9riqTkEot
   PPl2Ho6Si2JNOINI98+3A99z9SSK2g5pwhsomTY5GSibjJRfx+Fd5Bt6Z
   GaZtFVLwAky3sXdprsDyOYzeDSGYAeiU7XK1NLUKsslKFEqunc38w5qkM
   FTrIiAGROMVgbEGq4T1E34EZvKwHEoMchN3E1fyUuS6mYgdyI14RgnfkD
   LzQ9SZvwRfp5mS6V1xV/0LbKU60Id6IAaQgK7D79oeE4yv+loTgnCgCYU
   aYfSm8yABOtIDyAE8SOC9gHRIepq75DcAyQupAf+7l6nw67sTasV3yGoM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="298272763"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="298272763"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 22:18:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="978091472"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="978091472"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 22:18:02 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Yang Shi <shy828301@gmail.com>, Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: memcg reclaim demotion wrt. isolation
References: <Y5idFucjKVbjatqc@dhcp22.suse.cz> <Y5ik+CCmvapf87Mb@cmpxchg.org>
        <Y5maoIUuH79KrfJt@dhcp22.suse.cz>
Date:   Thu, 15 Dec 2022 14:17:13 +0800
In-Reply-To: <Y5maoIUuH79KrfJt@dhcp22.suse.cz> (Michal Hocko's message of
        "Wed, 14 Dec 2022 10:42:56 +0100")
Message-ID: <87edt1dwd2.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Tue 13-12-22 17:14:48, Johannes Weiner wrote:
>> On Tue, Dec 13, 2022 at 04:41:10PM +0100, Michal Hocko wrote:
>> > Hi,
>> > I have just noticed that that pages allocated for demotion targets
>> > includes __GFP_KSWAPD_RECLAIM (through GFP_NOWAIT). This is the case
>> > since the code has been introduced by 26aa2d199d6f ("mm/migrate: demote
>> > pages during reclaim"). I suspect the intention is to trigger the aging
>> > on the fallback node and either drop or further demote oldest pages.
>> > 
>> > This makes sense but I suspect that this wasn't intended also for
>> > memcg triggered reclaim. This would mean that a memory pressure in one
>> > hierarchy could trigger paging out pages of a different hierarchy if the
>> > demotion target is close to full.
>> 
>> This is also true if you don't do demotion. If a cgroup tries to
>> allocate memory on a full node (i.e. mbind()), it may wake kswapd or
>> enter global reclaim directly which may push out the memory of other
>> cgroups, regardless of the respective cgroup limits.
>
> You are right on this. But this is describing a slightly different
> situaton IMO. 
>
>> The demotion allocations don't strike me as any different. They're
>> just allocations on behalf of a cgroup. I would expect them to wake
>> kswapd and reclaim physical memory as needed.
>
> I am not sure this is an expected behavior. Consider the currently
> discussed memory.demote interface when the userspace can trigger
> (almost) arbitrary demotions. This can deplete fallback nodes without
> over-committing the memory overall yet push out demoted memory from
> other workloads. From the user POV it would look like a reclaim while
> the overall memory is far from depleted so it would be considered as
> premature and a warrant a bug report.
>
> The reclaim behavior would make more sense to me if it was constrained
> to the allocating memcg hierarchy so unrelated lruvecs wouldn't be
> disrupted.

When we reclaim/demote some pages from a memcg proactively, what is our
goal?  To free up some memory in this memcg for other memcgs to use?  If
so, it sounds reasonable to keep the pages of other memcgs as many as
possible.

Best Regards,
Huang, Ying
