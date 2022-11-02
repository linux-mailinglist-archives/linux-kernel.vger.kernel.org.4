Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B52615E31
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiKBIqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiKBIqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:46:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C330927CD9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 01:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667378781; x=1698914781;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=aS31B0qCdqNEVkcc38xnNSgQkHYgfw1HrY1wqPLFUtU=;
  b=X/x8PSSSLZ6yS6/krARQgPIANDUYPRH+LpGj+YM5nHS/Meqx7XPuW2hm
   R5hyZt3IiTkg2YOHrqhZmd299S/jSza6kU63kYm/xd5lovzK8jAXvPVeA
   GZqjPA4Qt1cPHJKQmkpOXYPtgG9+MAdwRC2j3HmOg5Oh6Jq1rcTJUqAgD
   yHpUDjnXo4avoqvCh7yXJYOjcdp72SEtLCmSJIH0SqKhS0UMsNjYmW+xm
   o87/ziB4SwstVSKPmdAwU0CLmF2GZaUo8t9vJby+RJJuadkgROFmCVXR4
   EPp98D4RrT+IHVd+v2SD43C0QwK32LD+U71glnr2I3dqojFfn0PC4o1wl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="310454506"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="310454506"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 01:46:21 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="634180580"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="634180580"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 01:46:17 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Bharata B Rao <bharata@amd.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Jagdish Gediya <jvgediya.oss@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tim Chen <tim.c.chen@intel.com>, Wei Xu <weixugc@google.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [RFC] memory tiering: use small chunk size and more tiers
References: <0d938c9f-c810-b10a-e489-c2b312475c52@amd.com>
        <87tu3oibyr.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <07912a0d-eb91-a6ef-2b9d-74593805f29e@amd.com>
        <87leowepz6.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y2Eui+kKvwj8ip+T@dhcp22.suse.cz>
        <878rkuchpm.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y2IhiSnpQsmY7khx@dhcp22.suse.cz>
        <87bkppbx75.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y2Inot4i4xUGH60O@dhcp22.suse.cz>
        <877d0dbw13.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y2IsvbOadq+TZx+R@dhcp22.suse.cz>
Date:   Wed, 02 Nov 2022 16:45:38 +0800
In-Reply-To: <Y2IsvbOadq+TZx+R@dhcp22.suse.cz> (Michal Hocko's message of
        "Wed, 2 Nov 2022 09:39:25 +0100")
Message-ID: <8735b1bv7x.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Wed 02-11-22 16:28:08, Huang, Ying wrote:
>> Michal Hocko <mhocko@suse.com> writes:
>> 
>> > On Wed 02-11-22 16:02:54, Huang, Ying wrote:
>> >> Michal Hocko <mhocko@suse.com> writes:
>> >> 
>> >> > On Wed 02-11-22 08:39:49, Huang, Ying wrote:
>> >> >> Michal Hocko <mhocko@suse.com> writes:
>> >> >> 
>> >> >> > On Mon 31-10-22 09:33:49, Huang, Ying wrote:
>> >> >> > [...]
>> >> >> >> In the upstream implementation, 4 tiers are possible below DRAM.  That's
>> >> >> >> enough for now.  But in the long run, it may be better to define more.
>> >> >> >> 100 possible tiers below DRAM may be too extreme.
>> >> >> >
>> >> >> > I am just curious. Is any configurations with more than couple of tiers
>> >> >> > even manageable? I mean applications have been struggling even with
>> >> >> > regular NUMA systems for years and vast majority of them is largerly
>> >> >> > NUMA unaware. How are they going to configure for a more complex system
>> >> >> > when a) there is no resource access control so whatever you aim for
>> >> >> > might not be available and b) in which situations there is going to be a
>> >> >> > demand only for subset of tears (GPU memory?) ?
>> >> >> 
>> >> >> Sorry for confusing.  I think that there are only several (less than 10)
>> >> >> tiers in a system in practice.  Yes, here, I suggested to define 100 (10
>> >> >> in the later text) POSSIBLE tiers below DRAM.  My intention isn't to
>> >> >> manage a system with tens memory tiers.  Instead, my intention is to
>> >> >> avoid to put 2 memory types into one memory tier by accident via make
>> >> >> the abstract distance range of each memory tier as small as possible.
>> >> >> More possible memory tiers, smaller abstract distance range of each
>> >> >> memory tier.
>> >> >
>> >> > TBH I do not really understand how tweaking ranges helps anything.
>> >> > IIUC drivers are free to assign any abstract distance so they will clash
>> >> > without any higher level coordination.
>> >> 
>> >> Yes.  That's possible.  Each memory tier corresponds to one abstract
>> >> distance range.  The larger the range is, the higher the possibility of
>> >> clashing is.  So I suggest to make the abstract distance range smaller
>> >> to reduce the possibility of clashing.
>> >
>> > I am sorry but I really do not understand how the size of the range
>> > actually addresses a fundamental issue that each driver simply picks
>> > what it wants. Is there any enumeration defining basic characteristic of
>> > each tier? How does a driver developer knows which tear to assign its
>> > driver to?
>> 
>> The smaller range size will not guarantee anything.  It just tries to
>> help the default behavior.
>> 
>> The drivers are expected to assign the abstract distance based on the
>> memory latency/bandwidth, etc.
>
> Would it be possible/feasible to have a canonical way to calculate the
> abstract distance from these characteristics by the core kernel so that
> drivers do not even have fall into that trap?

Yes.  That sounds a good idea.  We can provide a function to map from
the memory latency/bandwidth to the abstract distance for the drivers.

Best Regards,
Huang, Ying
